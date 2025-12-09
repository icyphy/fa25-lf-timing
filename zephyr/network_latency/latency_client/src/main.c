/*
 * Simple Network Latency Measurement - Client
 * Measures RTT between two FRDM-K64F boards
 */

#include <zephyr/kernel.h>
#include <zephyr/net/socket.h>
#include <zephyr/posix/arpa/inet.h>
#include <errno.h>
#include <stdio.h>

#define SERVER_ADDR "192.168.1.100"  // Change to your server IP
#define SERVER_PORT 4242
#define NUM_PINGS 100
#define PAYLOAD_SIZE 64

static uint8_t payload[PAYLOAD_SIZE];

int main(void)
{
	int sock;
	struct sockaddr_in server_addr;
	int64_t start_time, end_time, rtt_us;
	int ret;
	int successful_pings = 0;
	int64_t total_rtt = 0;
	int64_t min_rtt = INT64_MAX;
	int64_t max_rtt = 0;
	int failed_pings = 0;

	printf("Latency Measurement Client\n");
	printf("Connecting to %s:%d\n", SERVER_ADDR, SERVER_PORT);

	/* Initialize payload with pattern */
	for (int i = 0; i < PAYLOAD_SIZE; i++) {
		payload[i] = i & 0xFF;
	}

	/* Create socket */
	sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (sock < 0) {
		printf("Failed to create socket: %d\n", errno);
		return -1;
	}

	/* Setup server address */
	memset(&server_addr, 0, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(SERVER_PORT);
	inet_pton(AF_INET, SERVER_ADDR, &server_addr.sin_addr);

	/* Connect to server */
	ret = connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr));
	if (ret < 0) {
		printf("Failed to connect: %d\n", errno);
		close(sock);
		return -1;
	}

	printf("Connected! Starting latency measurements...\n");
	printf("Sending %d packets of %d bytes each\n\n", NUM_PINGS, PAYLOAD_SIZE);

	/* Perform latency measurements */
	for (int i = 0; i < NUM_PINGS; i++) {
		uint8_t recv_buf[PAYLOAD_SIZE];
		int received = 0;

		/* Record start time in microseconds */
		start_time = k_cyc_to_us_floor64(k_cycle_get_64());

		/* Send payload */
		ret = send(sock, payload, PAYLOAD_SIZE, 0);
		if (ret < 0) {
			printf("Send failed on ping %d: %d\n", i, errno);
			failed_pings++;
			break;
		}

		/* Receive echo */
		while (received < PAYLOAD_SIZE) {
			ret = recv(sock, recv_buf + received, PAYLOAD_SIZE - received, 0);
			if (ret <= 0) {
				printf("Recv failed on ping %d: %d\n", i, errno);
				failed_pings++;
				goto cleanup;
			}
			received += ret;
		}

		/* Record end time and calculate RTT in microseconds */
		end_time = k_cyc_to_us_floor64(k_cycle_get_64());
		rtt_us = end_time - start_time;

		/* Verify payload */
		if (memcmp(payload, recv_buf, PAYLOAD_SIZE) != 0) {
			printf("Payload mismatch on ping %d!\n", i);
			failed_pings++;
			continue;
		}

		successful_pings++;
		total_rtt += rtt_us;

		if (rtt_us < min_rtt) {
			min_rtt = rtt_us;
		}
		if (rtt_us > max_rtt) {
			max_rtt = rtt_us;
		}

		printf("Ping %3d: RTT = %lld us\n", i, rtt_us);

		/* Small delay between pings */
		k_msleep(100);
	}

cleanup:
	close(sock);

	/* Print statistics */
	printf("\n=== Latency Statistics ===\n");
	printf("Packets sent:     %d\n", NUM_PINGS);
	printf("Packets received: %d\n", successful_pings);
	printf("Packets failed:   %d\n", failed_pings);

	if (successful_pings > 0) {
		printf("Min RTT:          %lld us\n", min_rtt);
		printf("Max RTT:          %lld us\n", max_rtt);
		printf("Avg RTT:          %lld us\n",
		       total_rtt / successful_pings,
		       (total_rtt / successful_pings) / 1000.0);
	}

	return 0;
}
