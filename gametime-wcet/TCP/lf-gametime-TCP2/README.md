# TCP2 WCET Analysis Results

This directory contains the GameTime WCET analysis results for the TCP2 Lingua Franca program, which simulates a TCP three-way handshake between a client and server.

## Section 1: Reading the Output Files

### 1.1 Viewing the Control Flow Graph (CFG)

Each reaction function has a `.dot` file that visualizes the control flow graph. To view these files:

```bash
# Install Graphviz if not already installed
brew install graphviz  # macOS
apt install graphviz   # Linux

# Convert .dot to PDF or PNG
dot -Tpdf server_reaction_function_0gt/._serverreaction_function_0.dot -o cfg_server_0.pdf
dot -Tpng client_reaction_function_2gt/._clientreaction_function_2.dot -o cfg_client_2.png

# Or view interactively with xdot
xdot server_reaction_function_0gt/._serverreaction_function_0.dot
```

The `.dot` files are located in each `*gt/` subdirectory (e.g., `server_reaction_function_0gt/`).

### 1.2 Understanding labels.txt - Path Exploration

The `labels_0.txt` file in each analysis directory contains the sequence of basic block labels that define possible execution paths through the function.

```bash
# View the labels for a reaction
cat server_reaction_function_0_analysis/server_reaction_function_0gt/labels_0.txt
```

**Example output:**
```
4
54
44
50
60
65
68
70
```

Each number represents a basic block ID in the CFG. Different paths through the function visit different sequences of blocks. More labels generally indicate more complex control flow (branches, loops).

| Reaction Function | Labels Count | Interpretation |
|-------------------|--------------|----------------|
| `client_reaction_function_0` | 1 | Single path - just `srand()` initialization |
| `client_reaction_function_1` | 1 | Single path - packet creation |
| `client_reaction_function_2` | 7 | Multiple paths - switch + delay loop |
| `server_reaction_function_0` | 8 | Multiple paths - switch (SYN/ACK) + delay loop |
| `server_reaction_function_1` | 1 | Single path - empty/minimal reaction |
| `driver` | 1 | Single path - tick orchestration |

### 1.3 Viewing KLEE Symbolic Inputs

For reactions with multiple paths, GameTime uses KLEE to generate concrete input values that exercise each path. These are stored in `feasible-path*/` directories.

**Detailed input information:**
```bash
cat client_reaction_function_2_analysis/client_reaction_function_2gt/feasible-path1/klee_input_0.txt
```

This shows each symbolic variable with its:
- Name (e.g., `period_val`, `inp`, `__symbolic_elapsed_time`)
- Size in bytes
- Concrete data value (hex and int representations)

**Compact hex values:**
```bash
cat client_reaction_function_2_analysis/client_reaction_function_2gt/feasible-path1/klee_input_0_values.txt
```

**Example output:**
```
0x0000000000000000   <- period_val (8 bytes)
0x00000000           <- id_val (4 bytes)
0x0000000000000000   <- __symbolic_elapsed_time (8 bytes)
0x00000000           <- __symbolic_microstep (4 bytes)
0x000000030000000000000000  <- inp packet (12 bytes: id=0, seq=0, flags=3)
```

---

## Section 2: WCET Analysis Results

### WCET Measurements by Reactor

| Reactor Function | WCET (cycles) | Paths | Explanation |
|------------------|---------------|-------|-------------|
| `client_reaction_function_0` | 0* | 1 | Initialization only (`srand()`). Single basic block with no measurable computation in analysis context. |
| `client_reaction_function_1` | 0* | 1 | Creates SYN packet. Single path with simple memory allocation and field assignment. |
| `client_reaction_function_2` | **10,830** | 5 feasible | Handles SYN-ACK response. Includes switch statement (only case 3) and `__gt_delay_for(MSEC(40-60))` busy-wait loop. All paths show same WCET because switch has only one case. |
| `server_reaction_function_0` | **9,447** | 5 feasible | Handles incoming SYN/ACK. Switch with 2 cases (SYN→SYN-ACK, ACK→no response) + `__gt_delay_for(MSEC(100))`. Both switch paths have identical timing because the delay dominates execution time. |
| `server_reaction_function_1` | 0* | 1 | Empty reaction body (bandwidth overload trigger placeholder). No computation to measure. |
| `driver` (TCP2_tick) | 0* | 1 | Orchestration stub. Actual connections not fully resolved in this analysis. |

**Notes:**
- `0*` indicates the reaction has a single trivial path with no significant computation or the path analysis couldn't generate measurable inputs
- WCET values are in **FlexPRET CPU cycles** at the configured clock frequency
- `server_reaction_function_0` shows identical WCET across all paths because:
  - Both switch cases (SYN and ACK) perform similar operations (printf, field assignments)
  - The `__gt_delay_for(MSEC(100))` dominates execution time and is constant
- `client_reaction_function_2` has the highest WCET due to the processing delay simulation

### Path Diversity Analysis

For `server_reaction_function_0`, despite having 2 switch cases, all measured paths show WCET = 9,447 because:
1. **Case 1 (SYN)**: Print → set flags to SYN-ACK → delay 100ms → send
2. **Case 2 (ACK)**: Print → set send=false → delay 100ms → skip send

Both paths execute the same `__gt_delay_for(MSEC(100))` which dominates the timing.

---

## Section 3: Overall WCET Calculation

### Reactor Structure

![TCP2 Reactor Diagram](TCP2_diagram.png)

The diagram shows the TCP2 program structure: a Server reactor with two reactions (packet handler with 50ms deadline, and a timer) communicating with a Client reactor (startup, periodic SYN sender, and packet handler). Messages travel through 50 msec logical delays in both directions.

### GameTime Results

From our analysis, only two reactions had meaningful WCET measurements:

- **Server.1** (packet handler): **9,447 cycles** — handles incoming SYN and ACK packets
- **Client.3** (packet handler): **10,830 cycles** — responds to SYN-ACK with ACK

The other reactions (startup, timers, etc.) were too simple for GameTime to generate meaningful paths.

### Calculating Overall WCET

The worst case happens during the handshake when both packet handlers need to run at the same logical time. On FlexPRET (single-threaded), reactions run one after another, so we add them:

**WCET per tag = 9,447 + 10,830 = 20,277 cycles**

On a multi-threaded platform, Server and Client could run in parallel, so we'd take the max instead (10,830 cycles).

### A Note on Delays

The `after 50 msec` in the LF connections is a *logical time* delay — it tells the scheduler when to deliver messages, not actual CPU busy-waiting. GameTime doesn't include these in the WCET since they don't consume execution time.

However, the `lf_sleep()` call inside `client_reaction_function_2` *is* measured because it's converted to a busy-wait loop (`__gt_delay_for`) for the analysis.

### Summary

On single-threaded FlexPRET, the worst-case execution time per logical time step is **20,277 cycles**. This needs to complete before the Server's 50 msec deadline for the system to meet its real-time requirements.
