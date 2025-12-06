# Network Latency Measurement Tool

Simple network latency measurement tool for FRDM-K64F boards running Zephyr RTOS.

## Overview

This tool consists of two programs:

- **latency_server**: Echo server that reflects received packets back to the client
- **latency_client**: Client that measures Round-Trip Time (RTT) by sending packets and timing responses

## Setup

### Board Configuration

- **Board 1 (Server)**: 192.168.1.100
- **Board 2 (Client)**: 192.168.1.101
- **Network**: Connected via Ethernet switch
- **Port**: 4242

### Building

#### Server (for 192.168.1.100 board)

```bash
cd latency_server
west build -b frdm_k64f
west flash
```

#### Client (for 192.168.1.101 board)

```bash
cd latency_client
west build -b frdm_k64f
west flash
```

## How It Works

1. **Server** listens on port 4242 and echoes back any received data
2. **Client** connects to the server and sends 100 packets (64 bytes each)
3. For each packet, the client:
   - Records the start time using `k_uptime_get()`
   - Sends the packet
   - Waits for the echo response
   - Records the end time
   - Calculates RTT = end_time - start_time
4. After all packets, statistics are displayed:
   - Minimum RTT
   - Maximum RTT
   - Average RTT
   - Packet loss percentage

## Customization

You can modify these parameters in [latency_client/src/main.c](latency_client/src/main.c):

- `SERVER_ADDR`: IP address of the server (line 13)
- `SERVER_PORT`: Port number (line 14)
- `NUM_PINGS`: Number of test packets (line 15)
- `PAYLOAD_SIZE`: Size of each packet in bytes (line 16)

## Expected Output

### Server

```
Latency Measurement Server
Listening on port 4242
Server ready, waiting for connections...

Connection #1 from 192.168.1.101:xxxxx
Connection from 192.168.1.101 closed
```

### Client

```
Latency Measurement Client
Connecting to 192.168.1.100:4242
Connected! Starting latency measurements...
Sending 100 packets of 64 bytes each

Ping   0: RTT = 2 ms
Ping   1: RTT = 1 ms
Ping   2: RTT = 2 ms
...
Ping  99: RTT = 1 ms

=== Latency Statistics ===
Packets sent:     100
Packets received: 100
Packet loss:      0.00%
Min RTT:          1 ms
Max RTT:          3 ms
Avg RTT:          1 ms
```

## Notes

- RTT measurements use `k_uptime_get()` which provides millisecond resolution
- The tool uses TCP for reliable delivery
- A 100ms delay is added between pings to avoid overwhelming the network
- The server handles one client connection at a time
- Payload verification ensures data integrity during transmission
