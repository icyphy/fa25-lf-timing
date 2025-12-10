# SyncFlow2 - Three-Branch Barrier Synchronization with Bypass

This federated Lingua Franca program demonstrates barrier synchronization with three branches and a bypass path, distributed across three FRDM-K64F microcontrollers. It includes WCET (Worst-Case Execution Time) analysis features.

## Architecture

```
                    ┌─────────────┐
                    │   Fanout    │
                    │ (Host MCU)  │
                    └──────┬──────┘
                           │
            ┌──────────────┼──────────────┐
            │              │              │
       ┌────▼────┐    ┌───▼────┐    ┌───▼─────┐
       │   Top   │    │  Mid   │    │ Bottom  │
       │ Worker  │    │ Worker │    │ Worker  │
       │ (Quad)  │    │ (Lin)  │    │  (Fast) │
       │MCU .101 │    │MCU .102│    │Host MCU │
       └────┬────┘    └───┬────┘    └────┬────┘
            │             │              │
            └──────┬──────┘              │
                   │                     │
              ┌────▼─────┐               │
              │ Barrier  │               │
              │ (Host)   │               │
              └────┬─────┘               │
                   │                     │
                   └──────────┬──────────┘
                              │
                         ┌────▼────┐
                         │  Sink   │
                         │ (Host)  │
                         └─────────┘
```

### Federates

1. **HostBottomFederate** (192.168.1.100)
   - Contains: Fanout, Barrier, Sink, and Bottom Worker
   - Distributes tasks to Top and Mid workers
   - Processes Bottom branch locally (bypass path)
   - Synchronizes Top and Mid results at Barrier
   - Collects all results at Sink

2. **TopFederate** (192.168.1.101)
   - Top Worker with quadratic workload (worst case)
   - Work duration: 250 msec
   - Workload size: 1200
   - Demonstrates O(n²) computational pattern

3. **MidFederate** (192.168.1.102)
   - Mid Worker with linear workload (average case)
   - Work duration: 180 msec
   - Workload size: 1000
   - Demonstrates O(n) computational pattern

### Execution Flow

1. **Fan-out**: Fanout distributes tokens to all three branches simultaneously
2. **Parallel Processing**:
   - Top Worker (remote) performs quadratic computation
   - Mid Worker (remote) performs linear computation
   - Bottom Worker (local) performs fast linear computation (bypass)
3. **Barrier Synchronization**: Barrier waits for both Top and Mid results
4. **Final Merge**: Sink waits for both barrier release AND bypass path
5. **WCET Reporting**: Each worker and the Sink report execution times

### Network Connections

- **Host → Top**: Port 9001, `after 20 msec`, `@maxwait(100 msec)`
- **Top → Host**: Port 9002, `after 250 msec`, `@maxwait(300 msec)`
- **Host → Mid**: Port 9011, `after 20 msec`, `@maxwait(100 msec)`
- **Mid → Host**: Port 9012, `after 180 msec`, `@maxwait(250 msec)`

## Build and Flash

### Prerequisites

1. Set the `REACTOR_UC_PATH` environment variable:
   ```bash
   export REACTOR_UC_PATH=/path/to/reactor-uc
   ```

2. Ensure three FRDM-K64F boards are connected via USB at:
   - `/run/media/nightxade/FRDM-K64FJ` (Host)
   - `/run/media/nightxade/FRDM-K64FJ1` (Top Worker)
   - `/run/media/nightxade/FRDM-K64FJ2` (Mid Worker)

3. Configure your network:
   - Connect all three boards to the same Ethernet switch
   - Ensure the subnet 192.168.1.0/24 is available

### Build and Flash All Federates

```bash
./buildAndFlash.sh
```

This script will:
1. Generate federated code using `lfc-dev --gen-fed-templates`
2. Build each federate for FRDM-K64F
3. Flash the binary to the corresponding board

### Manual Build (Individual Federates)

#### Host Federate

```bash
cd SyncFlow2/host
cp ../../host.conf prj.conf
./run_lfc.sh
west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
```

#### Top Worker Federate

```bash
cd SyncFlow2/top_fed
cp ../../top.conf prj.conf
./run_lfc.sh
west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
```

#### Mid Worker Federate

```bash
cd SyncFlow2/mid_fed
cp ../../mid.conf prj.conf
./run_lfc.sh
west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ2/
```

## Expected Output

### Host Console (192.168.1.100)

```
(0, 0) === Round 0: fan-out ===, physical time 300
(0, 0) [Stage 1] bottom-bypass started (round 0), physical time 304
(90, 0) [Stage 1] bottom-bypass finished (round 0) [Comp: 74 ms, Round: 74 ms], physical time 378
(520, 0) [Barrier] Top and mid arrived for round 0 → releasing sink merge, physical time 771
(520, 0) [Sink] ✅ Bypass and merged paths aligned for round 0 → final merge [Round WCET: 479 ms], physical time 779

(700, 0) === Round 1: fan-out ===, physical time 1000
(700, 0) [Stage 1] bottom-bypass started (round 1), physical time 1005
(790, 0) [Stage 1] bottom-bypass finished (round 1) [Comp: 73 ms, Round: 73 ms], physical time 1078
(1220, 0) [Barrier] Top and mid arrived for round 1 → releasing sink merge, physical time 1470
(1220, 0) [Sink] ✅ Bypass and merged paths aligned for round 1 → final merge [Round WCET: 689 ms], physical time 1479
```

### Top Worker Console (192.168.1.101)

```
(20, 0) [Stage 1] top-pre started (round 0), physical time -19584
(270, 0) [Stage 1] top-pre finished (round 0) [Comp: 58 ms, Round: 58 ms], physical time -19525
(720, 0) [Stage 1] top-pre started (round 1), physical time -18883
(970, 0) [Stage 1] top-pre finished (round 1) [Comp: 58 ms, Round: 58 ms], physical time -18825
```

### Mid Worker Console (192.168.1.102)

```
(20, 0) [Stage 1] mid-pre started (round 0), physical time -40056
(200, 0) [Stage 1] mid-pre finished (round 0) [Comp: 6 ms, Round: 6 ms], physical time -40050
(720, 0) [Stage 1] mid-pre started (round 1), physical time -39524
(900, 0) [Stage 1] mid-pre finished (round 1) [Comp: 6 ms, Round: 6 ms], physical time -39518
```

## WCET Analysis

The program demonstrates three different computational workload patterns:

1. **Top Worker** (Worst Case): O(n²) quadratic workload
   - Nested loops creating maximum execution time
   - Expected: ~250 ms per round

2. **Mid Worker** (Average Case): O(n) linear workload
   - Single loop with moderate iterations
   - Expected: ~180 ms per round

3. **Bottom Worker** (Best Case): O(n) linear workload with fewer iterations
   - Fastest path, bypasses barrier
   - Expected: ~90 ms per round

### Timing Measurements

- Each Worker reports individual execution time using `clock_gettime(CLOCK_MONOTONIC)`
- Sink reports total end-to-end time from fan-out to final merge
- Total WCET is dominated by the slowest path (Top Worker: 250 ms + network delays)

## Configuration

### Rounds and Spacing

Edit [SyncFlow2.lf:262](src/SyncFlow2.lf#L262):
```lf
fan = new Fanout(rounds=10, spacing=700 msec)
```

### Worker Workloads

Adjust computation parameters in federate instantiations:
- [TopFederate](src/SyncFlow2.lf#L265): `work=250 msec, workload_size=1200`
- [MidFederate](src/SyncFlow2.lf#L276): `work=180 msec, workload_size=1000`
- [BottomWorker](src/SyncFlow2.lf#L245): `work=90 msec, workload_size=800`

### Network Delays

Adjust `after` delays in federated connections at [SyncFlow2.lf:302-320](src/SyncFlow2.lf#L302-L320) based on your network latency measurements.

## Troubleshooting

### STP Violations

If you see "STP violation" messages, the network delays may be too optimistic. Increase:
- The `after` delay values
- The `@maxwait` timeout values

### Connection Failures

- Verify all boards are on the same subnet (192.168.1.0/24)
- Check that no other devices are using the assigned IP addresses
- Ensure Ethernet cables are properly connected
- Reset all boards if they fail to establish connections

### Build Failures

- Verify `REACTOR_UC_PATH` is set correctly
- Ensure Zephyr SDK and west tool are properly installed
- Check that all boards are properly mounted at expected paths
