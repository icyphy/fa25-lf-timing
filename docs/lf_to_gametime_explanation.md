# LF to GameTime Converter: Technical Documentation

## Overview

The `lf_to_gametime.py` script is a critical component of our WCET (Worst-Case Execution Time) analysis pipeline for Lingua Franca programs. It bridges two systems that were never designed to work together:

1. **Lingua Franca (LF)**: A polyglot coordination language for building deterministic, timing-aware reactive systems
2. **GameTime**: A WCET analysis toolkit that uses symbolic execution (KLEE) combined with hardware measurement (FlexPRET) to produce tight, accurate timing bounds

The core challenge is that LF generates C code with runtime-specific constructs (reactor infrastructure, port connections, timing APIs) that GameTime cannot directly analyze. This script transforms LF-generated code into standalone, analyzable C functions while preserving the execution semantics that affect timing.

---

## Background Concepts

### What is Symbolic Execution?

Symbolic execution is a program analysis technique where instead of running a program with concrete values (like `x = 5`), we run it with *symbolic* values (like `x = α`, where α can be anything).

**Concrete execution example:**
```c
int foo(int x) {
    if (x > 10)
        return x * 2;
    else
        return x + 1;
}
// With x = 5: takes the else branch, returns 6
// We only see ONE path
```

**Symbolic execution example:**
```c
int foo(int x) {  // x is symbolic (can be any value)
    if (x > 10)   // Fork! Path 1: assume x > 10, Path 2: assume x <= 10
        return x * 2;   // Path 1: returns 2*α where α > 10
    else
        return x + 1;   // Path 2: returns α+1 where α <= 10
}
// KLEE explores BOTH paths and generates test inputs:
// - Test 1: x = 15 (exercises path 1)
// - Test 2: x = 3  (exercises path 2)
```

KLEE (our symbolic execution engine) tracks *path conditions* — the constraints that must be true for each path. When a branch is encountered, KLEE forks into two states and explores both. At the end of each path, KLEE uses an SMT solver to generate a concrete input that satisfies the path conditions.

**Why this matters for WCET:** Different paths through a function take different amounts of time. By using symbolic execution, we can discover ALL possible paths, then measure each one to find the worst case.

---

## Background: Why This Transformation is Necessary

### Lingua Franca's Compilation Model

When you compile an LF program like `TCP2.lf`, the LF compiler generates:

```
src-gen/TCP2/
├── TCP2.c              # Main reactor instantiation and connections
├── _client.c           # Client reactor reactions
├── _client.h           # Client reactor types and state
├── _server.c           # Server reactor reactions  
├── _server.h           # Server reactor types and state
└── ...
```

The generated C code uses LF runtime APIs:
- `lf_set(port, value)` — Send data through an output port
- `lf_time_logical_elapsed()` — Get elapsed logical time
- `lf_tag().microstep` — Get current microstep
- `lf_sleep(duration)` — Physical time delay
- `lf_schedule(action, delay)` — Schedule future events
- `self->state_var` — Access reactor state

These APIs depend on the LF runtime, which GameTime cannot link against.

### GameTime's Requirements

GameTime performs WCET analysis through:

1. **Symbolic Execution (KLEE)**: Explores all feasible paths through a function by treating inputs as symbolic values
2. **Hardware Measurement (FlexPRET)**: Executes each path on real RISC-V hardware to get precise cycle counts
3. **Path Composition**: Combines measurements using basis path testing to bound overall WCET

For this to work, GameTime needs:
- **Standalone C functions** with no external runtime dependencies
- **Symbolic inputs** declared via KLEE's `klee_make_symbolic()`
- **Deterministic control flow** (no undefined behavior)
- **FlexPRET-compatible code** (especially for timing primitives)

---

## What the Script Does: Step-by-Step

### Phase 1: Discovery and Extraction

```python
def convert(self):
    # 1. Find all reactor C files
    c_files = list(self.src_gen_dir.glob("_*.c"))
    
    # 2. Extract preamble from .lf source (custom types, helper functions)
    self.preamble = self.extract_preamble()
```

The script first locates all generated reactor files (`_client.c`, `_server.c`, etc.) and extracts any preamble code from the original `.lf` file. The preamble typically contains user-defined types like:

```c
typedef struct {
    int id;
    int seq;
    int flags;  // 1=SYN, 2=ACK, 3=SYN-ACK
} packet;
```

This is essential because reactions use these types, and GameTime needs the definitions.

### Phase 2: Reaction Extraction

```python
def extract_all_reactions(self, c_file_path):
    # Pattern matches: void _clientreaction_function_0(void* instance_args)
    pattern = r'void\s+(_\w+reaction_function_(\d+))\s*\(void\*\s+instance_args\)\s*\{'
```

Each reactor can have multiple reactions (numbered 0, 1, 2...). The script:

1. **Finds all reaction functions** by pattern matching
2. **Extracts the user code** between `#line` directives (filtering out LF boilerplate)
3. **Determines triggers** by analyzing how reactions are registered:
   - `startup` — Runs once at program start
   - `input:portname` — Triggered when data arrives on an input port
   - `action:timername` — Triggered by a timer or scheduled action

### Phase 3: State and Port Analysis

```python
def extract_from_include_header(self, reactor_name):
    # Parse include/ProgramName/ReactorName.h for:
    # - State variables (reactor_self_t struct)
    # - Input port types
    # - Output port types
```

The script examines header files to understand:
- **State variables**: `int count;`, `interval_t period;`
- **Input ports**: What data the reactor receives
- **Output ports**: What data the reactor produces

This information determines the function signature of the transformed code.

### Phase 4: Code Transformation

This is the heart of the script. Each LF API call is transformed:

#### 4.1 Output Ports: `lf_set()` → Return Values

In Lingua Franca, reactions send data to output ports using `lf_set()`:

```c
// LF-generated code:
lf_set(outp, *packet);
```

This `lf_set` macro does complex things behind the scenes:
1. Allocates memory in the port's buffer
2. Copies the value to the buffer
3. Marks the port as "present" for this logical time
4. Registers downstream reactions to be triggered

None of this is relevant for WCET analysis of the reaction itself — we just care about the computation cost of preparing the output value.

**Our transformation:**

```c
// Before (LF):
reaction(inp) -> outp {=
    packet *out = malloc(sizeof(packet));
    out->id = in->id;
    out->flags = 2;
    lf_set(outp, *out);  // Send to output port
=}

// After (GameTime):
packet _clientreaction_function_2(...) {
    packet __output_outp;  // Local variable for output
    packet *out = malloc(sizeof(packet));
    out->id = in->id;
    out->flags = 2;
    __output_outp = *out;  // Assign to local variable
    return __output_outp;  // Return the output value
}
```

The reaction becomes a function that **returns** its output value directly. This is semantically equivalent for timing purposes — we still do all the computation to prepare the output, we just deliver it differently.

For the driver function (which orchestrates multiple reactions), this returned value becomes input to the next reaction:

```c
void TCP2_tick() {
    // Client sends SYN
    packet client_out = _clientreaction_function_1(...);
    
    // Server receives SYN, responds with SYN-ACK
    packet server_out = _serverreaction_function_0(..., client_out);
    
    // Client receives SYN-ACK, sends ACK
    packet client_ack = _clientreaction_function_2(..., server_out);
}
```

The reaction becomes a function that *returns* its output instead of using the runtime API.

#### 4.2 Timing APIs → Symbolic Variables

```c
// Before (LF):
lf_time_logical_elapsed()
lf_tag().microstep

// After (GameTime):
__symbolic_elapsed_time    // Parameter, made symbolic by KLEE
__symbolic_microstep       // Parameter, made symbolic by KLEE
```

By making timing values symbolic, KLEE can explore paths that depend on time (e.g., `if (elapsed > THRESHOLD)`).

#### 4.3 Physical Delays: `lf_sleep()` → Busy-Wait Loop

```c
// Before (LF):
lf_sleep(MSEC(100));

// After (GameTime):
__gt_delay_for(MSEC(100));
```

Where `__gt_delay_for` is implemented as:

```c
#ifdef __KLEE__
// KLEE path: Use symbolic time (can't execute real delays)
static inline uint64_t __gt_get_rdtime(void) {
    return klee_any_uint64_t();  // Symbolic value
}
#else
// FlexPRET path: Use hardware timer
static inline uint64_t __gt_get_rdtime(void) {
    uint64_t t;
    asm volatile("rdtime %0" : "=r"(t));  // RISC-V rdtime instruction
    return t;
}
#endif

static inline void __gt_delay_for(interval_t ns) {
    uint64_t start = __gt_get_rdtime();
    uint64_t target = start + (uint64_t)ns;
    while (__gt_get_rdtime() < target) { }  // Busy-wait
}
```

**Why `#ifdef __KLEE__`?** 

KLEE performs symbolic execution and cannot execute inline assembly (`asm volatile`). When analyzing with KLEE, we use `klee_any_uint64_t()` which returns a symbolic value, allowing KLEE to explore the loop's termination conditions.

When measuring on FlexPRET, we use the actual `rdtime` instruction to read the hardware cycle counter, giving us real timing.

#### 4.4 State Variables: `self->var` → Pointer Parameters

```c
// Before (LF):
self->count++;

// After (GameTime):
(*count)++;  // count is now a pointer parameter
```

State variables become pointer parameters so they can be modified. The script carefully handles operator precedence:
- `self->count++` becomes `(*count)++` not `*count++` (which would be `*(count++)`)

#### 4.5 Input Ports: `port->value` → Direct Parameters

```c
// Before (LF):
packet *in = &inp->value;

// After (GameTime):
packet *in = &inp;  // inp is now a direct parameter of type 'packet'
```

### Phase 5: File Generation

For each reaction, the script generates:

```
reactor_reaction_function_N_analysis/
├── reactor_reaction_function_N.c   # Transformed C code
└── config.yaml                      # GameTime configuration
```

The generated C file includes:
1. Standard headers (`<stdio.h>`, `<stdint.h>`, etc.)
2. LF type definitions (`instant_t`, `interval_t`)
3. LF time macros (`MSEC()`, `SEC()`, etc.)
4. The `__gt_delay_for` implementation with KLEE/FlexPRET conditional compilation
5. Preamble code (user-defined types)
6. The transformed reaction function

### Phase 6: Driver Generation

The script also generates a "driver" function that represents one logical time step:

```c
void TCP2_tick() {
    // Execute reactions in topological order
    // Connection: c.outp → s.inp
    int c_outp = _clientreaction_function_1();
    _serverreaction_function_0(c_outp);
    
    // Connection: s.outp → c.inp  
    int s_outp = _serverreaction_function_0();
    _clientreaction_function_2(s_outp);
}
```

This allows analyzing the combined WCET of a complete execution step.

---

## Example Transformation

### Original LF Reaction (from TCP2.lf)

```lf
reaction(inp) -> outp {=
    packet *in = &inp->value;
    packet *out = malloc(sizeof(packet));
    out->id = in->id;
    out->seq = in->seq + 1;
    
    lf_print("(%lld, %d) [CLIENT] Received packet id=%d seq=%d",
        lf_time_logical_elapsed(), lf_tag().microstep, in->id, in->seq);
    
    switch (in->flags) {
        case 3: // SYN-ACK
            lf_print("[CLIENT] Received SYN-ACK");
            out->flags = 2; // ACK
            break;
    }
    
    lf_sleep(MSEC(randint(40, 60)));
    lf_set(outp, *out);
=}
```

### Transformed GameTime Code

```c
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef int64_t instant_t;
typedef int64_t interval_t;

#define MSEC(t) ((interval_t)((t) * 1000000LL))

// KLEE/FlexPRET conditional compilation
#ifdef __KLEE__
uint64_t klee_any_uint64_t(void);
static inline uint64_t __gt_get_rdtime(void) {
    return klee_any_uint64_t();
}
#else
static inline uint64_t __gt_get_rdtime(void) {
    uint64_t t;
    asm volatile("rdtime %0" : "=r"(t));
    return t;
}
#endif

static inline void __gt_delay_for(interval_t ns) {
    uint64_t start = __gt_get_rdtime();
    uint64_t target = start + (uint64_t)ns;
    while (__gt_get_rdtime() < target) { }
}

// Preamble from LF file
typedef struct {
    int id;
    int seq;
    int flags;
} packet;

static inline int randint(int a, int b) {
    return (rand() % (b - a + 1)) + a;
}

// Transformed reaction
packet _clientreaction_function_2(
    interval_t* period,           // State variable (pointer)
    int* id,                      // State variable (pointer)  
    int64_t __symbolic_elapsed_time,    // Symbolic timing
    unsigned int __symbolic_microstep,  // Symbolic timing
    packet inp                    // Input port (by value)
) {
    packet __output_outp;
    packet *in = &inp;
    packet *out = malloc(sizeof(packet));
    out->id = in->id;
    out->seq = in->seq + 1;
    
    printf("(%lld, %d) [CLIENT] Received packet id=%d seq=%d",
        __symbolic_elapsed_time, __symbolic_microstep, in->id, in->seq);
    
    switch (in->flags) {
        case 3: // SYN-ACK
            printf("[CLIENT] Received SYN-ACK");
            out->flags = 2; // ACK
            break;
    }
    
    __gt_delay_for(MSEC(randint(40, 60)));
    __output_outp = *out;
    
    return __output_outp;
}
```

---

## GameTime Analysis Flow

After transformation, the analysis proceeds:

1. **KLEE Symbolic Execution**
   ```bash
   klee --emit-all-errors client_reaction_function_2.bc
   ```
   KLEE explores all paths through the switch statement and delay loop, generating concrete inputs for each path.

2. **FlexPRET Measurement**
   ```bash
   # For each KLEE-generated test case:
   fp-emu driver.elf  # Run on FlexPRET emulator
   ```
   Each path is executed on FlexPRET (or its emulator) to measure actual cycle counts.

3. **WCET Computation**
   GameTime uses basis path testing to combine individual path measurements into an overall WCET bound.

---

## Key Design Decisions

### Why Transform Instead of Link?

An alternative approach would be to create a "stub" LF runtime — a fake version of the runtime that GameTime could link against. This would let us analyze the original LF-generated code directly. However, this doesn't work well for several reasons:

**Problem 1: The runtime has complex state management**

The LF runtime maintains global data structures:
- Event queues (what reactions are scheduled to run)
- Port status (which ports have pending data)
- Reactor hierarchy (parent/child relationships)
- Timing state (current logical time, microstep)

If we linked against a stub runtime, KLEE would try to symbolically execute all this infrastructure. It would fork on every queue operation, every pointer comparison, every scheduling decision. The state space would explode, and KLEE would time out before finding useful paths through the *actual reaction code* we care about.

**Problem 2: Port connections involve queues**

In LF, when you call `lf_set(port, value)`, it doesn't directly deliver data. Instead:
1. The value is copied to an internal buffer
2. The downstream reaction is added to the event queue
3. The scheduler eventually invokes the downstream reaction

This queue-based delivery is great for determinism, but terrible for symbolic execution — KLEE would need to model the entire queue.

**Problem 3: Timing APIs interact with the scheduler**

`lf_time_logical_elapsed()` doesn't just return a number — it queries the runtime's current state. If we stubbed it to return a symbolic value, we'd still have the problem of the runtime's internal time tracking.

**Our solution: Transform the code**

By transforming the code, we eliminate all runtime dependencies. The result is a pure C function where:
- Inputs come from function parameters (which KLEE makes symbolic)
- Outputs go to return values (or output parameters)
- State is passed in as pointers
- No queues, no scheduler, no runtime

KLEE can fully explore this standalone function, and we get clean path coverage.

---

### Why Pointer Parameters for State?

In Lingua Franca, reactors have *state variables* that persist between reaction invocations:

```lf
reactor Counter {
    state count: int = 0
    
    reaction(trigger) {=
        self->count++;  // Modifies state
        printf("Count: %d\n", self->count);
    =}
}
```

The state `count` starts at 0 and increases each time the reaction fires. Across the lifetime of the program, it might be 0, 1, 2, 100, etc.

**The transformation challenge:**

When we extract the reaction as a standalone function, we need to:
1. **Allow modification**: The function must be able to change `count`
2. **Preserve between calls**: In the driver function, `count` should retain its value
3. **Enable symbolic exploration**: KLEE should explore paths for different values of `count`

#### The Global Variable Problem

Our first attempt was to declare state variables as globals:

```c
// First attempt: Global state variables
int count = 0;  // Global

void _counterreaction_function_0() {
    count++;
    if (count > 10) {
        // Different path when count is high
        handle_overflow();
    }
    printf("Count: %d\n", count);
}
```

**This doesn't work with KLEE!** Here's why:

KLEE only makes things symbolic when you explicitly tell it to via `klee_make_symbolic()`. Global variables initialized to concrete values (like `int count = 0`) stay concrete. KLEE sees:

```c
int count = 0;  // KLEE: "count is 0, period."

if (count > 10) {  // KLEE: "0 > 10 is false, skip this branch"
    handle_overflow();  // KLEE: Never explores this path!
}
```

KLEE would only ever explore the `count <= 10` path because it knows `count` starts at 0. The `count > 10` path is never discovered, and if that path has different (worse) timing, our WCET would be wrong.

#### Solution: Pass State as Function Parameters

By making state variables into function parameters, GameTime's wrapper can make them symbolic:

```c
// GameTime-generated wrapper (simplified):
void analyze_counterreaction() {
    int count;
    klee_make_symbolic(&count, sizeof(count), "count");  // Now count can be ANY value
    
    _counterreaction_function_0(&count);  // Pass as pointer
}

// Our transformed reaction:
void _counterreaction_function_0(int* count) {
    (*count)++;
    if (*count > 10) {  // KLEE: "count is symbolic, fork!"
        handle_overflow();  // KLEE: Explores this path too!
    }
    printf("Count: %d\n", *count);
}
```

Now KLEE sees `count` as symbolic and forks:
- **Path 1**: Assume `*count > 10` → explores `handle_overflow()`
- **Path 2**: Assume `*count <= 10` → skips it

Both paths get measured, and we find the true WCET.

**Operator precedence matters!**

The script carefully handles expressions like `self->count++`. A naive transformation to `*count++` would be wrong:
- `*count++` means `*(count++)` — increment the pointer, then dereference
- `(*count)++` means dereference, then increment the value

The script uses regex to ensure proper parenthesization: `(*count)++`.

---

### Why Symbolic Timing Values?

Many reactions branch based on time:

```c
// Example: Timeout handling
if (lf_time_logical_elapsed() > SEC(5)) {
    // Timeout path - different code, different timing
    handle_timeout();
} else {
    // Normal path
    process_normally();
}
```

If we replaced `lf_time_logical_elapsed()` with a constant (say, 0), KLEE would only explore the else branch. We'd miss the timeout path entirely, and our WCET would be wrong.

**Solution: Symbolic timing parameters**

We transform timing API calls to symbolic parameters:

```c
// Before:
if (lf_time_logical_elapsed() > SEC(5)) { ... }

// After:
void reaction(int64_t __symbolic_elapsed_time, ...) {
    if (__symbolic_elapsed_time > SEC(5)) { ... }
}
```

Now KLEE sees that `__symbolic_elapsed_time` can be any 64-bit value. It will fork:
- **Path 1**: Assume `__symbolic_elapsed_time > 5000000000` (5 seconds in nanoseconds)
- **Path 2**: Assume `__symbolic_elapsed_time <= 5000000000`

Both paths get explored, and GameTime measures both to find the WCET.

---

## Limitations and Future Work

1. **Network/Federated Execution**: The current script handles local reactors. Federated LF programs with network communication would need additional handling.

2. **Dynamic Scheduling**: `lf_schedule()` is replaced with a counter increment. True scheduling semantics would require modeling the event queue.

3. **Multicore**: The analysis assumes single-threaded execution (FlexPRET). Multi-threaded platforms would need interference analysis.

4. **Memory Allocation**: `malloc()` calls are preserved but could cause issues with symbolic execution. Future work could replace with static allocation.

---

## Usage

```bash
# Generate GameTime-compatible code
python lf_to_gametime.py src-gen/TCP2 output-dir/

# Run analysis (inside Docker container)
cd output-dir/client_reaction_function_2_analysis
python /home/gametime/src/analyze_project.py config.yaml --backend flexpret
```

The script produces one analysis directory per reaction, plus a driver directory for whole-program analysis.
