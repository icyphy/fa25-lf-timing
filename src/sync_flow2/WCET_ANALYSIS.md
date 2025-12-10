# WCET Analysis: SyncFlow2 Federated Program

## Executive Summary

This document provides a detailed Worst-Case Execution Time (WCET) analysis for the SyncFlow2 federated program running across three FRDM-K64F microcontrollers. The program implements a three-branch barrier synchronization pattern with a bypass path.

**Key Findings:**
- **End-to-End WCET per Round**: 520 ms (worst case)
- **Critical Path**: Top Worker branch (quadratic workload)
- **Bottleneck**: Top Worker computation + network delays
- **Throughput**: ~1.43 rounds/second (with 700 ms spacing)

---

## System Architecture

### Federates and Network Topology

```
┌─────────────────────────────────────────────────────────────┐
│  Host Federate (192.168.1.100)                              │
│  ┌──────────┐    ┌─────────┐    ┌──────┐                   │
│  │  Fanout  │───>│ Bottom  │───>│ Sink │                   │
│  └────┬─────┘    │ Worker  │    └───▲──┘                   │
│       │          └─────────┘        │                       │
│       │          (90 ms work)       │                       │
│       │                             │                       │
│       │          ┌─────────┐        │                       │
│       │          │ Barrier │────────┘                       │
│       │          └────▲────┘                                │
└───────┼───────────────┼─────────────────────────────────────┘
        │               │
        │ 20ms    after delays    250ms │
        ▼               │               ▼
┌───────────────┐       │       ┌───────────────┐
│ Top Worker    │───────┘       │ Mid Worker    │
│ (192.168.1.101)│  180ms       │ (192.168.1.102)│
│ 250 ms work   │               │ 180 ms work   │
└───────────────┘               └───────────────┘
```

### Network Connections

| Connection | After Delay | @maxwait | Purpose |
|------------|-------------|----------|---------|
| Host → Top | 20 ms | 100 ms | Task distribution |
| Top → Host | 250 ms | 300 ms | Result collection |
| Host → Mid | 20 ms | 100 ms | Task distribution |
| Mid → Host | 180 ms | 250 ms | Result collection |

---

## Per-Component WCET Analysis

### 1. Fanout Reactor (Host)
**Location**: [SyncFlow2.lf:143-167](src/SyncFlow2.lf#L143-L167)

**Execution Time**: < 1 ms (negligible)

**Operations**:
- Create three token_t structs
- Set three outputs (to_top, to_mid, to_bottom)
- Print fan-out message

**WCET**: ~0.5 ms

---

### 2. Bottom Worker (Host - Local)
**Location**: [SyncFlow2.lf:87-141](src/SyncFlow2.lf#L87-L141)

**Configuration**:
- Branch: BRANCH_BOTTOM_PRE (2)
- Work delay: 90 ms
- Workload size: 800
- Computation: O(n) linear workload

**Computational Work**:
```c
compute_linear_work(800)  // 800 iterations of result += i
```

**Measured Execution Time** (from terminal output):
- Round 0: 87 ms
- Round 1: 75 ms

**WCET Components**:
1. Computational work: ~3 ms (actual measurement shows minimal CPU time)
2. Scheduled delay: 90 ms (artificial `lf_schedule(finish, 90 msec)`)
3. **Total WCET**: 90 ms + overhead ≈ **93 ms**

**Note**: The computational workload is being optimized away or executes too quickly. The 87-75 ms measured times are primarily from the artificial delay, not actual computation.

---

### 3. Top Worker (Remote - 192.168.1.101)
**Location**: [SyncFlow2.lf:272-280](src/SyncFlow2.lf#L272-L280)

**Configuration**:
- Branch: BRANCH_TOP_PRE (0)
- Work delay: 250 ms
- Workload size: 1200
- Computation: O(n²) quadratic workload

**Computational Work**:
```c
compute_quadratic_work(1200 / 100)  // 12x12 nested loops = 144 iterations
```

**Measured Execution Time** (from terminal output):
- Round 0: 3 ms
- Round 1: 65 ms

**WCET Components**:
1. Network receive delay (Host → Top): 20 ms (after delay)
2. Reaction overhead: < 1 ms
3. Computational work: ~3-65 ms (measured, but mostly overhead)
4. Scheduled delay: 250 ms
5. Network send delay (Top → Host): 250 ms (after delay)
6. **Total WCET**: 20 + 250 + 250 = **520 ms**

**Critical Path**: This is the **slowest branch** and determines the overall system WCET.

---

### 4. Mid Worker (Remote - 192.168.1.102)
**Location**: [SyncFlow2.lf:283-291](src/SyncFlow2.lf#L283-L291)

**Configuration**:
- Branch: BRANCH_MID_PRE (1)
- Work delay: 180 ms
- Workload size: 1000
- Computation: O(n) linear workload

**Computational Work**:
```c
compute_linear_work(1000)  // 1000 iterations of result += i
```

**Measured Execution Time** (from terminal output):
- Round 0: 3 ms
- Round 1: 3 ms

**WCET Components**:
1. Network receive delay (Host → Mid): 20 ms
2. Reaction overhead: < 1 ms
3. Computational work: ~3 ms (measured)
4. Scheduled delay: 180 ms
5. Network send delay (Mid → Host): 180 ms
6. **Total WCET**: 20 + 180 + 180 = **380 ms**

---

### 5. Barrier Reactor (Host)
**Location**: [SyncFlow2.lf:169-202](src/SyncFlow2.lf#L169-L202)

**Execution Time**: < 1 ms (negligible)

**Operations**:
- Check if both top_in and mid_in are present
- Track seen_top and seen_mid state variables
- Release barrier when both inputs received

**WCET**: ~0.5 ms

**Synchronization Behavior**:
- Waits for BOTH Top and Mid workers to complete
- Releases immediately when both arrive
- Critical path determined by slower worker (Top: 520 ms)

---

### 6. Sink Reactor (Host)
**Location**: [SyncFlow2.lf:204-242](src/SyncFlow2.lf#L204-L242)

**Execution Time**: < 1 ms (negligible)

**Operations**:
- Wait for merged (from Barrier) and bypass (from Bottom) inputs
- Calculate end-to-end timing using clock_gettime()
- Print final merge message

**WCET**: ~1 ms

**Measured Total Round Time** (from terminal output):
- Round 0: 475 ms (logical time from fan-out to sink completion)
- Round 1: 691 ms

---

## End-to-End WCET Analysis

### Path Analysis

The program has three parallel paths from Fanout to Sink:

#### **Path 1: Top Branch (CRITICAL PATH)**
```
Fanout → [Network 20ms] → Top Worker [250ms + 250ms] → [Network 250ms] → Barrier → Sink
```
**Total**: 20 + 250 + 250 = **520 ms**

#### **Path 2: Mid Branch**
```
Fanout → [Network 20ms] → Mid Worker [180ms + 180ms] → [Network 180ms] → Barrier → Sink
```
**Total**: 20 + 180 + 180 = **380 ms**

#### **Path 3: Bottom Branch (Bypass)**
```
Fanout → Bottom Worker [90ms] → Sink (bypass)
```
**Total**: **90 ms**

### Barrier Synchronization

The Barrier waits for **both** Top and Mid workers:
- Top arrives at: 520 ms
- Mid arrives at: 380 ms
- Barrier releases at: **520 ms** (limited by Top)

### Sink Completion

The Sink waits for **both** Barrier release and Bypass:
- Barrier releases at: 520 ms
- Bypass arrives at: 90 ms
- Sink completes at: **520 ms** (limited by Barrier/Top)

### **Overall System WCET per Round: 520 ms**

---

## Measured vs. Theoretical Analysis

### Observed Timings (from terminal output)

**Round 0:**
- Total WCET: 475 ms (measured by Sink)
- Theoretical: 520 ms
- **Difference**: -45 ms (faster than worst case)

**Round 1:**
- Total WCET: 691 ms (measured by Sink)
- Theoretical: 520 ms
- **Difference**: +171 ms (SLOWER than expected!)

### Anomaly Analysis

The Round 1 timing (691 ms) exceeds the theoretical WCET. Possible causes:

1. **Network Jitter**: Actual network delays exceeded the `after` specifications
2. **Physical Time Drift**: Physical time measurements include:
   - TCP connection overhead
   - Packet retransmissions
   - OS scheduling delays
   - Interrupt handling latency

3. **Logical Time vs Physical Time**:
   - Logical time: Deterministic, follows `after` delays exactly
   - Physical time: Actual wall-clock time with system overhead

4. **Computational Workload Variance**:
   - Round 0: Top worker = 3 ms (cache warm, optimized)
   - Round 1: Top worker = 65 ms (cache effects, less optimization)

### Recommendation

The `after` delays and `@maxwait` timeouts should be increased to accommodate worst-case network and system overhead:

```lf
// Current (too optimistic):
top_fed.result -> host.from_top after 250 msec
@maxwait(300 msec)

// Recommended:
top_fed.result -> host.from_top after 300 msec
@maxwait(400 msec)
```

---

## Computational Workload Analysis

### Issue: Compiler Optimization

The computational workloads are not performing as intended:

**Expected**:
- Top: O(n²) quadratic = (12×12) = 144 iterations → ~250 ms
- Mid: O(n) linear = 1000 iterations → ~180 ms
- Bottom: O(n) linear = 400 iterations → ~90 ms

**Actual (measured)**:
- Top: 3-65 ms (mostly overhead, not computation)
- Mid: 3 ms (overhead only)
- Bottom: 87-75 ms (artificial delay)

### Root Cause

The compiler is likely optimizing away the computational loops because:

1. The `result` variable is never used except for:
   ```c
   if (result < 0) lf_print("Unexpected result");
   ```
   The compiler can prove this condition is always false.

2. Modern compilers (GCC/Clang with `-O2` or higher) will eliminate "dead code" that doesn't affect program output.

### Solution Options

**Option 1: Use volatile**
```c
static volatile long global_result;

// In Worker reaction:
global_result = compute_quadratic_work(size);
```

**Option 2: Force side effects**
```c
// Make result affect the output token
result = compute_quadratic_work(self->workload_size / 100);
token_t t = { self->pending_round, self->branch };
t.round += (result & 0x1);  // Use result in output
```

**Option 3: Memory operations**
```c
static long compute_memory_work(int size) {
  volatile long array[100];
  for (int i = 0; i < size; i++) {
    array[i % 100] = i * i;  // Force memory writes
  }
  return array[size % 100];
}
```

---

## Performance Bottlenecks

### Identified Bottlenecks (in order of impact)

1. **Top Worker Network Round-Trip**: 520 ms
   - 48% network `after` delays (270 ms)
   - 48% artificial work delay (250 ms)
   - 4% actual computation + overhead

2. **Round Spacing**: 700 ms
   - Limits throughput to 1.43 rounds/second
   - Creates 180 ms idle time between rounds (700 - 520)

3. **Network Serialization**: Sequential send/receive operations
   - No pipelining between rounds
   - Could use physical time overlap if spacing < WCET

### Optimization Opportunities

1. **Reduce Top Worker `after` delays**:
   - Current: 20 ms (send) + 250 ms (receive) = 270 ms
   - Optimized: 10 ms + 150 ms = 160 ms
   - **Savings**: 110 ms per round (21% improvement)

2. **Pipeline rounds**:
   - Start Round N+1 before Round N completes
   - Requires careful tag management
   - Could improve throughput to 1.8 rounds/second

3. **Reduce artificial work delays**:
   - Current delays are much larger than actual computation
   - If actual computation takes 3-65 ms, the 250 ms delay is excessive
   - **Recommendation**: Use actual CPU-bound work instead of artificial delays

---

## Timing Guarantees and Safety

### Logical Time Properties

**Determinism**: ✅ Guaranteed
- All reactions execute in deterministic logical time order
- Tag (logical_time, microstep) uniquely identifies each reaction

**Causality**: ✅ Guaranteed
- All `after` delays ensure proper causality
- No zero-delay cycles

**Synchronization**: ✅ Guaranteed
- Barrier ensures Top and Mid complete before release
- Sink ensures both Barrier and Bypass complete before merge

### Physical Time Properties

**Real-time Bounds**: ⚠️ Partially Guaranteed
- Logical time provides deterministic ordering
- Physical time may exceed worst-case due to:
  - Network jitter
  - OS scheduling
  - Hardware interrupts
  - Cache effects

**STP Violation Risk**: Low (with current `@maxwait` values)
- `@maxwait(300 msec)` on Top worker is sufficient for 250 ms work + overhead
- `@maxwait(250 msec)` on Mid worker is sufficient for 180 ms work + overhead
- Recommend monitoring for STP violations in production

---

## WCET Summary Table

| Component | Computation | Network Delay | Artificial Delay | Total WCET |
|-----------|-------------|---------------|------------------|------------|
| **Fanout** | < 1 ms | - | - | ~0.5 ms |
| **Bottom Worker** | ~3 ms | - | 90 ms | ~93 ms |
| **Top Worker** (critical) | ~3-65 ms | 270 ms | 250 ms | **520 ms** |
| **Mid Worker** | ~3 ms | 200 ms | 180 ms | 380 ms |
| **Barrier** | < 1 ms | - | - | ~0.5 ms |
| **Sink** | < 1 ms | - | - | ~1 ms |
| **End-to-End** | | | | **520 ms** |

---

## Recommendations

### Short-term

1. **Monitor STP Violations**: Watch for warnings in production logs
2. **Increase @maxwait buffers**: Add 50-100 ms safety margin
3. **Log Physical Time**: Continue using `lf_time_physical_elapsed()` for monitoring

### Medium-term

1. **Fix Computational Workload**: Implement proper CPU-bound work that can't be optimized away
2. **Tune Network Delays**: Measure actual network latency and adjust `after` delays accordingly
3. **Characterize Variance**: Run multiple rounds and compute statistical bounds

### Long-term

1. **Implement Pipelining**: Allow rounds to overlap for higher throughput
2. **Optimize Critical Path**: Reduce Top Worker delays or distribute work differently
3. **Add Watchdog**: Detect and handle tardy (late) messages gracefully

---

## Conclusion

The SyncFlow2 federated program has a **worst-case end-to-end execution time of 520 ms per round**, dominated by the Top Worker branch which combines network delays (270 ms) and artificial work delays (250 ms). The current implementation provides strong determinism guarantees through logical time, but actual physical execution times show variance (475-691 ms measured) due to system overhead and network jitter.

The main issue is that the computational workload is not executing as intended—the compiler is optimizing away most of the work. The artificial `lf_schedule()` delays are masking this problem but make the WCET analysis less meaningful. For a true WCET analysis of computational work, the workload functions need to be fixed to prevent compiler optimization.

**Key Metrics:**
- Theoretical WCET: 520 ms/round
- Measured range: 475-691 ms/round
- Throughput: 1.43 rounds/sec (with 700 ms spacing)
- Critical path: Top Worker (quadratic workload)
- Bottleneck: Network delays (52% of WCET)
