# RTT (Round-Trip Time) Latency Measurement

A simple federated program to measure round-trip network latency between two Zephyr-based microcontrollers communicating over TCP/IP.

## Architecture

The system consists of two federates:

### Federate 0 (Initiator) - IP: 192.168.1.100
- **Timer**: Sends ping messages at regular intervals (default: 1 second)
- **RTT Calculator**: Measures round-trip time for each ping/pong pair
- **Statistics**: Tracks min, max, average RTT, jitter, and packet loss

### Federate 1 (Responder) - IP: 192.168.1.101
- **Echo Service**: Immediately echoes back any received ping message
- **Counter**: Tracks number of messages echoed

## Network Configuration

### TCP Ports
- Initiator → Responder: **9000**
- Responder → Initiator: **9001**

### IP Configuration
Update the IP addresses in [RTTMeasure.lf](src/RTTMeasure.lf) if your network uses different addresses:
```lf
@interface_tcp(name="initiator_if", address="192.168.1.100")
@interface_tcp(name="responder_if", address="192.168.1.101")
```

## Data Flow

```
┌────────────────────────────────────────────────┐
│         Initiator (192.168.1.100)              │
│                                                │
│  ┌───────┐                                     │
│  │ Timer │                                     │
│  └───┬───┘                                     │
│      │ Trigger                                 │
│      ▼                                         │
│  ┌──────────────┐                              │
│  │  Send Ping   │  Record timestamp T0         │
│  │  (seq #N)    │                              │
│  └──────┬───────┘                              │
└─────────┼──────────────────────────────────────┘
          │ Port 9000
          │ Ping message
          ▼
┌────────────────────────────────────────────────┐
│         Responder (192.168.1.101)              │
│                                                │
│  ┌──────────────┐                              │
│  │ Receive Ping │                              │
│  │  (seq #N)    │                              │
│  └──────┬───────┘                              │
│         │                                      │
│         ▼                                      │
│  ┌──────────────┐                              │
│  │  Echo Back   │  Immediate response          │
│  │  (seq #N)    │                              │
│  └──────┬───────┘                              │
└─────────┼──────────────────────────────────────┘
          │ Port 9001
          │ Pong message
          ▼
┌────────────────────────────────────────────────┐
│         Initiator (192.168.1.100)              │
│                                                │
│  ┌──────────────┐                              │
│  │ Receive Pong │  Record timestamp T1         │
│  │  (seq #N)    │  Calculate RTT = T1 - T0     │
│  └──────────────┘                              │
│                                                │
│  Update statistics:                            │
│  - Min RTT, Max RTT, Avg RTT                   │
│  - Jitter (variance)                           │
│  - Packet loss percentage                      │
└────────────────────────────────────────────────┘
```

## Measurement Parameters

Default configuration (adjustable in [RTTMeasure.lf](src/RTTMeasure.lf)):
- **Ping interval**: 1 second
- **Test duration**: 30 seconds (controlled by timeout)
- **Expected pings**: ~29 (starts at 500ms, then every 1 second)

To change the test duration, modify the timeout in the target specification:
```lf
target uC {
  platform: Zephyr,
  timeout: 30 sec  // Change this value
}
```

To change the ping interval:
```lf
init = new Initiator(interval=1 sec)  // Change interval here
```

## Building and Running

### Prerequisites
1. Two Zephyr-capable microcontroller boards (e.g., FRDM-K64F)
2. Network connectivity between boards (Ethernet or WiFi)
3. West build tool installed
4. Custom LFC compiler with federated uC support

### Build Steps

1. **Build all federates**:
   ```bash
   cd examples/zephyr/rtt_measure
   ./buildAndFlash.sh
   ```

   This will:
   - Generate federated code
   - Build initiator federate
   - Build responder federate
   - Flash both to their respective boards (if connected)

2. **Manual flashing** (if needed):
   ```bash
   # Flash initiator (connect initiator board)
   cp RTTMeasure/initiator/build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/

   # Flash responder (connect responder board)
   cp RTTMeasure/responder/build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
   ```

### Running the Test

1. Power on both boards
2. Verify network connectivity (boards should obtain correct IP addresses)
3. The test will automatically:
   - Establish TCP connections
   - Send ping messages at 1-second intervals
   - Measure RTT for each ping/pong pair
   - Run for 30 seconds (configurable via timeout)
   - Print final statistics at shutdown

### Expected Output

**Initiator Console**:
```
(500, 0) [Init] Ping #0 sent, physical time 500 ms
(520, 0) [Init] Pong #0 received, RTT=15234 us, physical time 515 ms
(1500, 0) [Init] Ping #1 sent, physical time 1500 ms
(1517, 0) [Init] Pong #1 received, RTT=14892 us, physical time 1515 ms
...
(29500, 0) [Init] Ping #29 sent, physical time 29500 ms
(29517, 0) [Init] Pong #29 received, RTT=14756 us, physical time 29515 ms
(30000, 0) [Init] ===== RTT MEASUREMENT RESULTS =====
(30000, 0) [Init] Pings sent: 30, Pongs received: 29
(30000, 0) [Init] Min RTT: 12456 us (12.456 ms)
(30000, 0) [Init] Avg RTT: 14832 us (14.832 ms)
(30000, 0) [Init] Max RTT: 18923 us (18.923 ms)
(30000, 0) [Init] Jitter: ~1234 us (1.234 ms)
(30000, 0) [Init] Packet loss: 3%
```

**Responder Console**:
```
(505, 0) [Resp] Ping #0 received, echoing back, physical time 505 ms
(1505, 0) [Resp] Ping #1 received, echoing back, physical time 1505 ms
...
(29505, 0) [Resp] Ping #29 received, echoing back, physical time 29505 ms
(30000, 0) [Resp] Echoed 29 messages
```

## Interpreting Results

- **Min RTT**: Best-case latency (likely when network is idle)
- **Avg RTT**: Typical latency under normal conditions
- **Max RTT**: Worst-case latency (network congestion or interference)
- **Jitter**: Variance in latency (lower is better for real-time apps)
- **Packet loss**: Percentage of pings that didn't receive a response

### Typical Values
For local Ethernet network:
- **Min RTT**: 5-15 ms
- **Avg RTT**: 10-20 ms
- **Max RTT**: 15-50 ms
- **Jitter**: 1-5 ms
- **Packet loss**: 0%

Higher values may indicate:
- Network congestion
- WiFi interference
- Processing delays
- TCP connection issues

## Configuration Files

- **[initiator.conf](initiator.conf)**: Network configuration for initiator (192.168.1.100)
- **[responder.conf](responder.conf)**: Network configuration for responder (192.168.1.101)

## Troubleshooting

### No Pongs Received
- Verify both boards are on the same network subnet
- Check firewall settings allow TCP ports 9000, 9001
- Confirm IP addresses match the configuration
- Check serial output for connection errors

### High RTT Values
- Normal for first few pings (TCP connection establishment)
- Check network load
- Verify network hardware (switches, cables)
- Try reducing ping interval to avoid queueing

### Build Issues
- Ensure `REACTOR_UC_PATH` environment variable is set
- Verify West is properly configured
- Check that Zephyr SDK is installed

## Use Cases

1. **Network Characterization**: Understand baseline latency for your setup
2. **Fork-Join Tuning**: Use RTT measurements to set appropriate `after` delays
3. **Network Debugging**: Identify connectivity or performance issues
4. **Benchmark Comparison**: Compare different network configurations

## Customization

### Change Test Duration
Modify the timeout in the target specification:
```lf
target uC {
  platform: Zephyr,
  timeout: 60 sec  // Run for 60 seconds instead of 30
}
```

### Change Ping Frequency
Modify the `interval` parameter:
```lf
init = new Initiator(interval=500 msec)  // 2 pings/sec
```

### Burst Mode Testing
For testing under load, use shorter interval:
```lf
init = new Initiator(interval=100 msec)  // 10 pings/sec
```

And increase timeout if needed:
```lf
target uC {
  platform: Zephyr,
  timeout: 60 sec
}
```

## Notes

- RTT includes network propagation delay + processing time on both ends
- Physical time is used for accurate measurements (not logical time)
- Each ping carries a sequence number to match with corresponding pong
- Statistics are printed at shutdown for easy analysis
