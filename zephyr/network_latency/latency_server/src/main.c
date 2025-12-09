/*
 * Simple Network Latency Measurement - Server
 * Echo server for latency measurements
 */

#include <zephyr/kernel.h>
#include <zephyr/net/socket.h>
#include <zephyr/posix/arpa/inet.h>
#include <errno.h>
#include <stdio.h>

#define BIND_PORT 4242
#define BUFFER_SIZE 1024

int main(void)
{
	int serv, client;
	struct sockaddr_in bind_addr;
	struct sockaddr_in client_addr;
	socklen_t client_addr_len;
	char addr_str[INET_ADDRSTRLEN];
	int ret;
	uint8_t buf[BUFFER_SIZE];
	int connection_counter = 0;

	printf("Latency Measurement Server\n");
	printf("Listening on port %d\n", BIND_PORT);

	/* Create socket */
	serv = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (serv < 0) {
		printf("Failed to create socket: %d\n", errno);
		return -1;
	}

	/* Setup bind address */
	memset(&bind_addr, 0, sizeof(bind_addr));
	bind_addr.sin_family = AF_INET;
	bind_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	bind_addr.sin_port = htons(BIND_PORT);

	/* Bind socket */
	ret = bind(serv, (struct sockaddr *)&bind_addr, sizeof(bind_addr));
	if (ret < 0) {
		printf("Failed to bind: %d\n", errno);
		close(serv);
		return -1;
	}

	/* Listen for connections */
	ret = listen(serv, 5);
	if (ret < 0) {
		printf("Failed to listen: %d\n", errno);
		close(serv);
		return -1;
	}

	printf("Server ready, waiting for connections...\n\n");

	/* Accept and handle connections */
	while (1) {
		client_addr_len = sizeof(client_addr);
		client = accept(serv, (struct sockaddr *)&client_addr, &client_addr_len);

		if (client < 0) {
			printf("Accept failed: %d\n", errno);
			continue;
		}

		/* Convert client address to string */
		inet_ntop(AF_INET, &client_addr.sin_addr, addr_str, sizeof(addr_str));
		printf("Connection #%d from %s:%d\n",
		       ++connection_counter, addr_str, ntohs(client_addr.sin_port));

		/* Echo loop */
		while (1) {
			int len, total_sent;
			uint8_t *p;

			/* Receive data */
			len = recv(client, buf, sizeof(buf), 0);

			if (len <= 0) {
				if (len < 0) {
					printf("Recv error: %d\n", errno);
				}
				break;  /* Connection closed */
			}

			/* Echo back - handle partial sends */
			p = buf;
			total_sent = 0;
			while (total_sent < len) {
				ret = send(client, p, len - total_sent, 0);
				if (ret < 0) {
					printf("Send error: %d\n", errno);
					goto connection_closed;
				}
				total_sent += ret;
				p += ret;
			}
		}

connection_closed:
		close(client);
		printf("Connection from %s closed\n\n", addr_str);
	}

	close(serv);
	return 0;
}
