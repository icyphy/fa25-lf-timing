# MapReduce System - Architecture Overview

## Project Structure

The MapReduce implementation includes the following Lingua Franca files:

- **[MapReduce.lf](MapReduce.lf)** - Shared type definitions and utility functions
- **[MapReduceHost.lf](MapReduceHost.lf)** - Standalone Host/PC-side components (Master, Router, Reducer)
- **[MapReduceWorker.lf](MapReduceWorker.lf)** - Standalone Worker/microcontroller components
- **[MapReduceFederated.lf](MapReduceFederated.lf)** - **Federated version for distributed execution**
- **[MapReducePseudocode.lf](MapReducePseudocode.lf)** - Python-based pseudocode version for analysis

## System Architecture

```
┌────────────────────────────────────────────────────────────────┐
│                        Host (PC) Side                          │
│                                                                │
│  ┌──────────┐      ┌───────────┐                               │
│  │  Client  │─────▶│ Scheduler │                               │
│  └──────────┘      └─────┬─────┘                               │
│     (generates           │                                     │
│      jobs with      ┌────┴─────┐                               │
│      patterns)      │          │                               │
│                Task │          │ Task                          │
│                     ▼          ▼                               │
│             ┌──────────────────────┐                           │
│             │       Router         │                           │
│             └───┬──────────────┬───┘                           │
│                 │              │                               │
└─────────────────┼──────────────┼───────────────────────────────┘
                  │              │
             Task │              │ Task
                  ▼              ▼
      ┌───────────────────┐  ┌───────────────────┐
      │    Worker 1       │  │    Worker 2       │
      │  ┌─────────────┐  │  │  ┌─────────────┐  │
      │  │  Stage 1    │  │  │  │  Stage 1    │  │
      │  │  (process   │  │  │  │  (process   │  │
      │  │   task)     │  │  │  │   task)     │  │
      │  └──────┬──────┘  │  │  └──────┬──────┘  │
      │         │         │  │         │         │
      └─────────┼─────────┘  └─────────┼─────────┘
                │                      │
         Result │                      │ Result
       from W1  │   (exchange results  │ from W2
                │    via Router)       │
                └──────┐      ┌────────┘
                       │      │
                  ┌────▼──────▼────┐
                  │     Router     │
                  └────┬──────┬────┘
                       │      │
  W2's Result  ┌───────┘      └────────┐  W1's Result
 (to Worker 1) │                       │ (to Worker 2)
               ▼                       ▼
      ┌───────────────────┐  ┌───────────────────┐
      │    Worker 1       │  │    Worker 2       │
      │  ┌─────────────┐  │  │  ┌─────────────┐  │
      │  │  Stage 2    │  │  │  │  Stage 2    │  │
      │  │  (process   │  │  │  │  (process   │  │
      │  │  W2 result) │  │  │  │  W1 result) │  │
      │  └──────┬──────┘  │  │  └──────┬──────┘  │
      │         │         │  │         │         │
      └─────────┼─────────┘  └─────────┼─────────┘
                │                      │
       Final W1 │                      │ Final W2
                └───────┐      ┌───────┘
                        │      │
┌───────────────────────▼──────▼─────────────────────────────────┐
│                    Host (PC) Side                              │
│                 ┌─────────────────┐                            │
│                 │    Reducer      │                            │
│                 │  (waits for &   │                            │
│                 │   aggregates    │                            │
│                 │   both results) │                            │
│                 └─────────────────┘                            │
│                                                                │
│  Note: This shows PARALLEL_CROSS pattern. SINGLE_NODE uses    │
│  only one worker. SEQUENTIAL sends W1's Stage 1 result to W2  │
│  for Stage 2 (no Stage 2 on W1).                              │
└────────────────────────────────────────────────────────────────┘
```

## Processing Patterns

The system supports three distinct job processing patterns:

### 1. SINGLE_NODE

- One worker processes the entire job
- Single-stage execution
- Worker assigned randomly (Worker 1 or Worker 2)
- **Flow:** Scheduler → Worker → Reducer

### 2. SEQUENTIAL

- Pipeline execution across two workers
- Worker A completes Stage 1, then Worker B performs Stage 2
- **Flow:** Scheduler → Worker A (Stage 1) → Router → Worker B (Stage 2) → Reducer

### 3. PARALLEL_CROSS

- Both workers process in parallel with cross-dependency
- Stage 1: Both workers process independently
- Stage 2: Workers exchange Stage 1 results and continue processing
- Reducer waits for both workers to complete before finalizing
- **Flow:** Scheduler → Worker 1 & Worker 2 (Stage 1) → Cross-exchange → Worker 1 & Worker 2 (Stage 2) → Reducer

## Component Details

### Host Components (MapReduceHost.lf)

#### Client

- Generates jobs at random intervals (2-3 seconds)
- Randomly assigns processing patterns to each job
- Tracks job submission count

#### Scheduler

- Routes jobs to appropriate workers based on pattern:
  - **SINGLE_NODE**: Routes to one randomly chosen worker
  - **SEQUENTIAL**: Routes to first worker in pipeline
  - **PARALLEL_CROSS**: Routes to both workers simultaneously

#### RouterNode

- Central message hub for all communications
- Routes tasks from Master to Workers
- Routes Stage 1 results between workers (peer exchange)
- Routes Stage 2 results to Reducer
- Tracks total messages routed

#### Reducer

- Aggregates results from all workers
- For PARALLEL_CROSS: waits for both worker results before completing job
- Computes statistics: jobs completed, jobs failed, average latency
- Maintains pending results buffer for parallel jobs

#### MasterNode

- Composite reactor combining Client + Scheduler
- Generates and schedules all jobs

#### ReducerNode

- Wrapper around Reducer with input connections

### Worker Components (MapReduceWorker.lf)

#### Worker

- Processes tasks in Stage 1 and/or Stage 2
- Simulates processing with configurable delay (base_processing_ms ± random variation)
- Handles three execution paths:
  - **SINGLE_NODE**: Stage 1 → direct result
  - **SEQUENTIAL**: Stage 1 → waits for peer result → Stage 2
  - **PARALLEL_CROSS**: Stage 1 → waits for peer result → Stage 2
- Tracks tasks processed count

#### WorkerNode

- Wrapper around Worker with input/output connections

## Data Types

### map_task_t

Task assignment sent to workers:

- `job_id`: Unique job identifier
- `pattern`: Processing pattern (SINGLE_NODE, SEQUENTIAL, PARALLEL_CROSS)
- `target_worker`: Worker ID assignment (1 or 2)
- `start_time`: Job creation timestamp
- `log`: Status message buffer

### map_result_t

Processing result returned from workers:

- `job_id`: Job identifier
- `worker_id`: Worker that produced result (1 or 2)
- `pattern`: Processing pattern used
- `processing_time_ms`: Time spent processing (milliseconds)
- `succeeded`: Success/failure flag
- `log`: Result message buffer

## Network Delays

The system simulates realistic network latency:

- **Master → Router**: 5 msec delay
- **Router → Reducer**: 8 msec delay

## Execution Flow Examples

### SINGLE_NODE Job (Job 1, Worker 2)

1. Client generates Job 1 with SINGLE_NODE pattern
2. Scheduler routes to Worker 2
3. Worker 2 processes Stage 1
4. Worker 2 sends result directly to Reducer
5. Reducer logs completion

### SEQUENTIAL Job (Job 2, Worker 1→2)

1. Client generates Job 2 with SEQUENTIAL pattern
2. Scheduler routes to Worker 1
3. Worker 1 processes Stage 1, outputs stage1_result
4. Router forwards to Worker 2 as peer_stage1_result
5. Worker 2 processes Stage 2, outputs stage2_result
6. Reducer logs completion

### PARALLEL_CROSS Job (Job 3)

1. Client generates Job 3 with PARALLEL_CROSS pattern
2. Scheduler routes to both Worker 1 and Worker 2
3. Both workers process Stage 1 simultaneously
4. Router exchanges Stage 1 results between workers
5. Both workers process Stage 2 with peer's Stage 1 data
6. Reducer waits for both results, then logs completion using max processing time

## Key Features

- **Decentralized coordination** for worker deployment
- **Simulated processing delays** with random variation
- **Pattern-based routing** for different workload types
- **Result aggregation** with parallel job tracking
- **Statistics collection** (completion rate, latency)
- **Microcontroller-compatible** worker code (uC target)
- **Federated execution** for distributed deployment across machines

## Running the Federated MapReduce System

The federated version ([MapReduceFederated.lf](MapReduceFederated.lf)) allows you to run the Host and Workers on separate computers.

### Important: Custom LFC with uC Federated Support

**NOTE:** The [MapReduceFederated.lf](MapReduceFederated.lf) file uses custom annotations for federated uC execution:
- `@interface_tcp` - Defines TCP network interfaces
- `@platform_linux` / `@platform_zephyr` - Specifies platform for each federate
- `@link` - Configures TCP connections between federates
- `@maxwait` - Sets network timeout

These annotations are **specific to your custom lfc compiler** and will show as errors in standard Lingua Franca IDEs. This is expected behavior - the file will compile correctly with your custom lfc.

### Prerequisites

1. Install your custom Lingua Franca compiler (`lfc`) with federated uC support
2. Ensure all machines are on the same network
3. Configure network interfaces and IP addresses in the federated reactor section
4. Flash Zephyr firmware to microcontroller worker nodes

### Network Configuration

Before compiling, update the IP addresses in [MapReduceFederated.lf](MapReduceFederated.lf) to match your network:

```lf
// In the federated reactor section (around line 485):
@interface_tcp(name="host_if", address="192.168.1.100")      // Update host IP
@interface_tcp(name="worker1_if", address="192.168.1.101")   // Update worker1 IP
@interface_tcp(name="worker2_if", address="192.168.1.102")   // Update worker2 IP
```

### Compilation

Compile the federated program with your custom lfc:

```bash
lfc src/MapReduce/MapReduceFederated.lf
```

This generates:
- **Host executable** (C target) - Runs on PC/Linux
- **Worker1 firmware** (uC/Zephyr target) - Flash to microcontroller
- **Worker2 firmware** (uC/Zephyr target) - Flash to microcontroller

TCP ports used:
- Host ↔ Worker1: 8001 (tasks), 8002 (peer), 8003 (stage1), 8004 (stage2)
- Host ↔ Worker2: 8011 (tasks), 8012 (peer), 8013 (stage1), 8014 (stage2)

### Running the Distributed System

The federated MapReduce system uses **direct TCP connections** between the host and workers (no RTI needed). The `@link` annotations configure the TCP server/client relationships.

#### Step 1: Flash Worker Firmware

Flash the compiled Zephyr firmware to your microcontrollers:

```bash
# Worker1 (assuming west build tool for Zephyr)
west flash --build-dir bin/MapReduceFederated/worker1

# Worker2
west flash --build-dir bin/MapReduceFederated/worker2
```

Connect the microcontrollers to your network and verify they obtain the configured IP addresses (192.168.1.101 and 192.168.1.102).

#### Step 2: Run Host on PC

On your PC/Linux machine (IP: 192.168.1.100):

```bash
./bin/MapReduceFederated/host
```

The host will:
1. Start TCP servers on ports 8001-8004 and 8011-8014
2. Wait for worker connections
3. Begin sending jobs once both workers connect

#### Step 3: Verify Communication

Check that all TCP connections are established:

```bash
# On the host machine
netstat -an | grep "800[0-9]\|801[0-9]"
```

You should see ESTABLISHED connections for all 8 ports (4 per worker).

### Network Configuration

The federated version uses **decentralized coordination**, which means:
- No central coordinator needed at runtime (only RTI for connection setup)
- Messages are sent directly between federates after initial connection
- Network delays are simulated (5ms for tasks, 8ms for results)

### Firewall Configuration

If running across different machines, ensure:
- RTI port (default 15045) is open
- Federate communication ports are accessible
- All machines can reach each other on the network

### Monitoring Execution

Each federate will print logs showing:
- **Host**: Job generation, scheduling, routing, and result aggregation
- **Worker1/Worker2**: Task processing (Stage 1 and Stage 2)

Example output from Host:
```
[Client] Job 0 [PARALLEL]
[Sched] J0 → W1+W2
[Router] Routed 2 messages
[Reduce] J0 OK: 142 ms
```

Example output from Worker1:
```
[W1] S1 J0
[W1] S2 J0
[W1] Processed 2 tasks
```

### Troubleshooting

**Issue: Federates can't connect to RTI**
- Verify RTI is running and accessible
- Check firewall settings
- Ensure correct IP address and port

**Issue: Workers not receiving tasks**
- Verify all 3 federates are connected to RTI
- Check network delays aren't too large
- Ensure Host federate started successfully

**Issue: Results not reaching Reducer**
- Check Worker outputs are being sent
- Verify Router is forwarding messages correctly
- Look for network connectivity issues

### Differences from Standalone Versions

The federated version differs from the standalone [MapReduceHost.lf](MapReduceHost.lf) and [MapReduceWorker.lf](MapReduceWorker.lf) files:

1. **Communication**: Uses federated connections instead of local connections
2. **Execution**: Each federate runs as a separate process (potentially on different machines)
3. **Coordination**: Uses decentralized coordination with logical time synchronization
4. **Network Delays**: Explicit `after` clauses simulate realistic network latency

### Performance Considerations

- Network latency adds to total job execution time
- Decentralized coordination minimizes synchronization overhead
- Workers can process independently without waiting for each other (except in PARALLEL_CROSS)
- Buffer sizes and timeouts may need adjustment for high-latency networks
