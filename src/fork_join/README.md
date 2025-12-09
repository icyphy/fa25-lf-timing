# Fork-Join Federated System for Zephyr Microcontrollers

This example demonstrates a federated fork-join pattern running on Zephyr-based microcontrollers, where work is distributed in parallel to multiple workers and then synchronized at a join point.

## Architecture

The system consists of three federates communicating over TCP/IP:

### Federate 0 (Host) - IP: 192.168.1.100
- **Clock**: Generates periodic ticks (1 second intervals)
- **Sensor**: Fork point - distributes work to both workers
- **Timer_Start**: Marks the start of each fork-join cycle
- **Actuator**: Join point - synchronizes results from both workers
- **Calculator**: Measures total fork-join latency

### Federate 1 (Worker1) - IP: 192.168.1.101
- **Middle**: Processes tasks with 100ms duration
- Receives work from Host, returns results to Host

### Federate 2 (Worker2) - IP: 192.168.1.102
- **Middle**: Processes tasks with 200ms duration
- Receives work from Host, returns results to Host

## Network Configuration

### TCP Ports
- Host → Worker1 tasks: **9001**
- Worker1 → Host results: **9002**
- Host → Worker2 tasks: **9011**
- Worker2 → Host results: **9012**

### IP Configuration
Update the IP addresses in [ForkJoinFederated.lf](src/ForkJoinFederated.lf) if your network uses different addresses:
```lf
@interface_tcp(name="host_if", address="192.168.1.100")
@interface_tcp(name="worker1_if", address="192.168.1.101")
@interface_tcp(name="worker2_if", address="192.168.1.102")
```

## Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    Host (192.168.1.100)                      │
│                                                              │
│  ┌───────┐                     ┌────────────┐               │
│  │ Clock ├─────┬──────────────►│   Sensor   │               │
│  └───────┘     │               │ (Fork pt)  │               │
│                │               └──────┬─────┘               │
│                │                      │                     │
│                │                 Fork │ Work                │
│                │               ┌──────┴──────┐              │
│  ┌────────────┐│               │             │              │
│  │Timer_Start ├┘               ▼             ▼              │
│  └──────┬─────┘          To Worker1     To Worker2         │
│         │                                                   │
└─────────┼───────────────────┬────────────────┬──────────────┘
          │                   │                │
     Start time         Port 9001         Port 9011
          │                   │                │
          │                   ▼                ▼
          │        ┌──────────────┐  ┌──────────────┐
          │        │   Worker1    │  │   Worker2    │
          │        │ (.101:9001)  │  │ (.102:9011)  │
          │        │              │  │              │
          │        │ Process      │  │ Process      │
          │        │ (100 ms)     │  │ (200 ms)     │
          │        └──────┬───────┘  └──────┬───────┘
          │               │                 │
          │          Port 9002         Port 9012
          │               │                 │
          │               ▼                 ▼
┌─────────┼───────────────┴─────────────────┴──────────────────┐
│         │              Results         Results               │
│         │               │                 │                  │
│         │         ┌─────┴─────────────────┴─────┐            │
│         │         │       Actuator              │            │
│         │         │       (Join pt)             │            │
│         │         └────────────┬────────────────┘            │
│         │                      │ End time                    │
│         │                      ▼                             │
│         └─────────────►┌──────────────────┐                 │
│                        │   Calculator     │                 │
│                        │ (Measures time)  │                 │
│                        └──────────────────┘                 │
│                    Host (192.168.1.100)                      │
└──────────────────────────────────────────────────────────────┘
```

## Timing Characteristics

- **Worker1**: 100ms processing time
- **Worker2**: 200ms processing time (critical path)
- **Network delays**: ~5ms each direction
- **Expected fork-join latency**: ~210ms (limited by slower worker)

The system measures:
- Average fork-join latency
- Best (minimum) latency
- Worst (maximum) latency

## Building and Running

### Prerequisites
1. Three Zephyr-capable microcontroller boards
2. Network connectivity between boards (Ethernet or WiFi)
3. West build tool installed
4. Custom LFC compiler with federated uC support

### Build Steps

1. **Build all federates**:
   ```bash
   cd examples/zephyr/fork_join
   ./buildAndFlash.sh build-only
   ```

2. **Flash each federate to its respective board**:
   ```bash
   # Flash host (connect host board)
   ./buildAndFlash.sh host

   # Flash worker1 (connect worker1 board)
   ./buildAndFlash.sh worker1

   # Flash worker2 (connect worker2 board)
   ./buildAndFlash.sh worker2
   ```

### Running the System

1. Power on all three boards
2. Verify network connectivity (boards should obtain correct IP addresses)
3. The system will automatically:
   - Establish TCP connections
   - Begin periodic fork-join cycles (every 1 second)
   - Print timing measurements

### Expected Output

**Host Console**:
```
(500, 0) [Clock] Tick, physical time 500
(500, 0) [Sensor] Fork tick #1, physical time 500
(500, 0) [Timer] Start mark, physical time 500
(715, 0) [Actuator] Join: W1=ready W2=ready, physical time 715
(715, 0) [Calc] Fork-join elapsed: 215 ms
(1500, 0) [Clock] Tick, physical time 1500
...
(30000, 0) [Sensor] Processed 30 ticks
(30000, 0) [Actuator] Completed 30 joins
(30000, 0) [Calc] Measurements: 30
(30000, 0) [Calc] Avg:212 ms, Best:205 ms, Worst:220 ms
```

**Worker1 Console**:
```
(505, 0) [Worker1] Start processing, physical time 505
(605, 0) [Worker1] Done processing (100 ms), physical time 605
(1505, 0) [Worker1] Start processing, physical time 1505
...
(30000, 0) [Worker1] Processed 30 tasks
```

**Worker2 Console**:
```
(505, 0) [Worker2] Start processing, physical time 505
(705, 0) [Worker2] Done processing (200 ms), physical time 705
(1505, 0) [Worker2] Start processing, physical time 1505
...
(30000, 0) [Worker2] Processed 30 tasks
```

## Configuration Files

- **[host.conf](host.conf)**: Network configuration for host federate
- **[w1_prj.conf](w1_prj.conf)**: Network configuration for worker1 federate
- **[w2_prj.conf](w2_prj.conf)**: Network configuration for worker2 federate

All configuration files include:
- TCP/IP networking support
- Sufficient network contexts for multiple connections (8 for host, default for workers)
- POSIX API support
- Appropriate stack and heap sizes

## Troubleshooting

### Connection Issues
- Verify all boards are on the same network subnet
- Check firewall settings allow TCP ports 9001, 9002, 9011, 9012
- Confirm IP addresses match the configuration

### Timing Issues
- If `@maxwait` violations occur, network delays may be too high
- Adjust `@maxwait` values in [ForkJoinFederated.lf](src/ForkJoinFederated.lf)
- Current setting: 50 msec per connection

### Build Issues
- Ensure custom LFC compiler is in PATH
- Verify West is properly configured
- Check that Zephyr SDK is installed

## Key Features

- **Parallel Processing**: Work distributed to multiple workers simultaneously
- **Synchronization**: Join point waits for all workers before proceeding
- **Timing Measurement**: Tracks fork-join latency with statistics
- **Network Transparency**: Workers can be on separate physical devices
- **Real-time Logging**: All events logged with logical and physical timestamps

## Differences from Original Version

The federated version differs from [ForkJoinTimingMeasure.lf](src/ForkJoinTimingMeasure.lf):

1. **Distribution**: Workers run on separate microcontrollers
2. **Communication**: Uses TCP/IP instead of local connections
3. **Platform**: Changed from FlexPRET to Zephyr
4. **Timing**: Added comprehensive timing annotations
5. **Statistics**: Enhanced measurements with min/max tracking
6. **Network Config**: Added proper Zephyr network configuration
