# Two-Branch Barrier Synchronization - Federated Microcontrollers

This example demonstrates barrier synchronization in a federated fork-join pattern running on Zephyr-based microcontrollers. Work is distributed to multiple workers in parallel branches, and results are synchronized at a barrier before completion.

## Architecture

The system consists of three federates communicating over TCP/IP:

### Federate 0 (Host) - IP: 192.168.1.100
- **Fanout**: Distributes work to both the top chain and bottom worker
- **Barrier**: Join point that synchronizes results from both branches
- **Sink**: Receives synchronized completion notifications

### Federate 1 (Top Chain) - IP: 192.168.1.101
- **Top1 Worker**: First hop with quadratic workload (250ms delay, 1000 iterations)
- **Top2 Worker**: Second hop with quadratic workload (220ms delay, 1200 iterations)
- Chained execution: Top1 → Top2

### Federate 2 (Bottom Worker) - IP: 192.168.1.102
- **Bottom Worker**: Single-hop with linear workload (180ms delay, 900 iterations)
- Parallel path to the top chain

## Network Configuration

### TCP Ports
- Host → Top Chain: **9001**
- Top Chain → Host: **9002**
- Host → Bottom: **9011**
- Bottom → Host: **9012**

### IP Configuration
Update the IP addresses in [Sync.lf](src/Sync.lf) if your network uses different addresses:
```lf
@interface_tcp(name="host_if", address="192.168.1.100")
@interface_tcp(name="topchain_if", address="192.168.1.101")
@interface_tcp(name="bottom_if", address="192.168.1.102")
```

## Data Flow

```
┌────────────────────────────────────────────────────────────┐
│                   Host (192.168.1.100)                      │
│                                                             │
│  ┌────────┐                                                │
│  │ Fanout │ Sends work every 800ms (2 rounds)              │
│  └───┬────┘                                                │
│      │                                                      │
│      ├──────────────────┬─────────────────┐                │
│      │                  │                 │                │
│      ▼                  ▼                 │                │
│  To Top Chain      To Bottom             │                │
└──────┼──────────────────┼─────────────────┼────────────────┘
       │ Port 9001        │ Port 9011       │
       │                  │                 │
       ▼                  │                 │
┌──────────────────────┐  │                 │
│  Top Chain Worker    │  │                 │
│  (.101)              │  │                 │
│  ┌────────────────┐  │  │                 │
│  │ Top1 (250ms)   │  │  │                 │
│  │ Quadratic work │  │  │                 │
│  └───────┬────────┘  │  │                 │
│          │           │  │                 │
│          ▼           │  │                 │
│  ┌────────────────┐  │  │                 │
│  │ Top2 (220ms)   │  │  ▼                 │
│  │ Quadratic work │  │  ┌────────────────┐│
│  └───────┬────────┘  │  │ Bottom Worker  ││
│          │           │  │ (.102)         ││
│          │ Port 9002 │  │                ││
│          ▼           │  │ (180ms)        ││
└──────────┼───────────┘  │ Linear work    ││
           │              └────────┬───────┘│
           │                       │ Port 9012
           │                       │         │
           │                       │         │
┌──────────┼───────────────────────┼─────────┼────────────────┐
│          │                       │         │                │
│          ▼                       ▼         │                │
│     ┌────────────────────────────────┐     │                │
│     │         Barrier                │     │                │
│     │  Waits for both branches       │     │                │
│     └────────────┬───────────────────┘     │                │
│                  │                         │                │
│                  ▼                         │                │
│            ┌──────────┐                    │                │
│            │   Sink   │                    │                │
│            │ Completes│                    │                │
│            └──────────┘                    │                │
│                   Host (192.168.1.100)     │                │
└────────────────────────────────────────────┼────────────────┘
```

## Timing Characteristics

### Top Chain (Critical Path)
- Top1 Worker: ~250ms (quadratic workload: 1000²)
- Top2 Worker: ~220ms (quadratic workload: 1200²)
- **Total**: ~470ms + network delays

### Bottom Path
- Bottom Worker: ~180ms (linear workload: 1000)

### Expected Behavior
- The **top chain is the critical path** due to higher computational complexity
- Barrier synchronizes both branches before proceeding
- Total round time: ~500ms (top chain) + network overhead
- System runs 2 rounds with 800ms spacing

## Building and Running

### Prerequisites
1. Three Zephyr-capable microcontroller boards (e.g., FRDM-K64F)
2. Network connectivity between boards (Ethernet or WiFi)
3. West build tool installed
4. Custom LFC compiler with federated uC support

### Build Steps

1. **Build all federates**:
   ```bash
   cd examples/zephyr/sync
   ./buildAndFlash.sh
   ```

   This will:
   - Generate federated code from Sync.lf
   - Build host federate
   - Build topchain_fed federate
   - Build bottom_fed federate
   - Flash all three to their respective boards (if connected)

2. **Manual flashing** (if needed):
   ```bash
   # Flash host (connect host board)
   cp SyncFlow2/host/build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/

   # Flash top chain worker (connect topchain board)
   cp SyncFlow2/topchain_fed/build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/

   # Flash bottom worker (connect bottom board)
   cp SyncFlow2/bottom_fed/build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ2/
   ```

### Running the System

1. Power on all three boards
2. Verify network connectivity (boards should obtain correct IP addresses)
3. The system will automatically:
   - Establish TCP connections
   - Run 2 fork-join rounds with 800ms spacing
   - Measure execution times for each worker
   - Synchronize at the barrier
   - Print completion messages

### Expected Output

**Host Console**:
```
=== Round 0 fan-out ===
[Barrier] Both branches arrived (round 0) → sink [Critical path: top chain, skew: 290 ms]
[Sink] ✅ Round 0 synchronized and completed [Total pipeline WCET: 495 ms]

=== Round 1 fan-out ===
[Barrier] Both branches arrived (round 1) → sink [Critical path: top chain, skew: 285 ms]
[Sink] ✅ Round 1 synchronized and completed [Total pipeline WCET: 492 ms]
```

**Top Chain Worker Console**:
```
[Worker] top-hop-1 start (round 0)
[Worker] top-hop-1 done (round 0) [WCET: 248 ms]
[Worker] top-hop-2 start (round 0)
[Worker] top-hop-2 done (round 0) [WCET: 222 ms]

[Worker] top-hop-1 start (round 1)
[Worker] top-hop-1 done (round 1) [WCET: 251 ms]
[Worker] top-hop-2 start (round 1)
[Worker] top-hop-2 done (round 1) [WCET: 218 ms]
```

**Bottom Worker Console**:
```
[Worker] bottom-hop start (round 0)
[Worker] bottom-hop done (round 0) [WCET: 182 ms]

[Worker] bottom-hop start (round 1)
[Worker] bottom-hop done (round 1) [WCET: 179 ms]
```

## Configuration Files

- **[host.conf](host.conf)**: Network configuration for host federate
  - IP: 192.168.1.100
  - Network contexts: 8 (for 4 TCP connections)
- **[topchain.conf](topchain.conf)**: Network configuration for top chain worker
  - IP: 192.168.1.101
- **[bottom.conf](bottom.conf)**: Network configuration for bottom worker
  - IP: 192.168.1.102

## Troubleshooting

### Connection Issues
- Verify all boards are on the same network subnet
- Check firewall settings allow TCP ports 9001, 9002, 9011, 9012
- Confirm IP addresses match the configuration

### Timing Issues
- If `@maxwait` violations occur, network delays may be too high
- Adjust `@maxwait` values in [Sync.lf](src/Sync.lf)
- Top chain maxwait is 550ms to account for ~470ms processing time

### Build Issues
- Ensure `REACTOR_UC_PATH` environment variable is set
- Verify West is properly configured
- Check that Zephyr SDK is installed

## Key Features

- **Barrier Synchronization**: Join point waits for all branches before proceeding
- **Critical Path Analysis**: Identifies which path takes longer (top chain vs bottom)
- **WCET Measurements**: Tracks execution time for each worker
- **Heterogeneous Workloads**: Different computational complexities demonstrate timing differences
- **Network Transparency**: Workers distributed across separate physical devices
- **Real-time Logging**: All events logged with timing information

## Differences from Non-Federated Version

The federated version differs from a single-device implementation:

1. **Distribution**: Workers run on separate microcontrollers
2. **Communication**: Uses TCP/IP instead of local connections
3. **Platform**: Zephyr-based microcontrollers
4. **Timing**: Added network delay annotations (`after` clauses)
5. **Consolidation**: Top1 and Top2 on same device to minimize federates

## Customization

### Change Workload Sizes
Modify the worker instantiation in [Sync.lf](src/Sync.lf):
```lf
top1 = new Worker(branch=0, delay=250 msec, workload_size=2000)  // Increase work
```

### Change Number of Rounds
Modify the Fanout parameter:
```lf
fan = new Fanout(rounds=5, spacing=800 msec)  // Run 5 rounds
```

### Adjust Timing Delays
Modify the worker delays and `after` clauses to match your network characteristics.
