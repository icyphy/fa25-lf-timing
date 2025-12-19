#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// LF type definitions
typedef int64_t instant_t;
typedef int64_t interval_t;

// LF time macros
#define NSEC(t) ((interval_t)(t))
#define USEC(t) ((interval_t)((t) * 1000LL))
#define MSEC(t) ((interval_t)((t) * 1000000LL))
#define SEC(t)  ((interval_t)((t) * 1000000000LL))

// Solution #1: Wrap rdtime in a normal C function for KLEE compatibility
#ifdef __KLEE__
uint64_t klee_any_uint64_t(void);
static inline uint64_t __gt_get_rdtime(void) {
    return klee_any_uint64_t();
}
#else
static inline uint64_t read_time_hw(void) {
    uint64_t t;
    asm volatile("rdtime %0" : "=r"(t));
    return t;
}
static inline uint64_t __gt_get_rdtime(void) {
    return read_time_hw();
}
#endif

static inline void __gt_delay_for(interval_t ns) {
    uint64_t start = __gt_get_rdtime();
    uint64_t target = start + (uint64_t)ns;
    while (__gt_get_rdtime() < target) { }
}

// Driver function - orchestrates all reactors
// Represents one logical time step of MapReduceFederated2
// Execution order determined by LF compiler's topological sort

// Scheduling counter for WCET analysis
int schedule_count = 0;

// Global state variables from all reactors
// From routernode reactor:
int messages_routed = 0;
// From worker reactor:
int worker_id = 1;
int tasks_processed = 0;
// From reducer reactor:
int jobs_completed = 0;
long total_latency_ms = 0;
// From scheduler reactor:
int jobs_scheduled = 0;
// From client reactor:
interval_t period = SEC(2);
int job_counter = 0;

// Forward declarations of reaction functions
int _routernodereaction_function_0(void);
int _routernodereaction_function_1(void);
int _routernodereaction_function_2(void);
int _routernodereaction_function_3(void);
int _routernodereaction_function_4(void);
int _routernodereaction_function_5(void);
void _routernodereaction_function_6(void);
int _workerreaction_function_0(map_task_t task_in);
int _workerreaction_function_1(void);
void _workerreaction_function_2(void);
void _reducerreaction_function_0(void);
void _reducerreaction_function_1(void);
void _reducerreaction_function_2(void);
int _schedulerreaction_function_0(map_task_t in);
void _schedulerreaction_function_1(void);
void _clientreaction_function_0(void);
int _clientreaction_function_1(void);
void _clientreaction_function_2(void);

void MapReduceFederated2_tick() {
    // Execute reactions in topological order (level 0, then level 1, ...)

    // Connection: client.out → scheduler.in
    int client_out_to_scheduler = _clientreaction_function_0();
    _schedulerreaction_function_0(client_out_to_scheduler);

    // Connection: scheduler.to_worker1 → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: scheduler.to_worker2 → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: worker1.result_out → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: worker1.to_peer → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: worker2.result_out → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: worker2.to_peer → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: delay.out → worker1.task_in
    // Note: Could not find matching reaction functions

    // Connection: delay.out → worker2.task_in
    // Note: Could not find matching reaction functions

    // Connection: delay.out → worker2.peer_result
    // Note: Could not find matching reaction functions

    // Connection: delay.out → worker1.peer_result
    // Note: Could not find matching reaction functions

    // Connection: delay.out → reducer.from_worker1
    // Note: Could not find matching reaction functions

    // Connection: delay.out → reducer.from_worker2
    // Note: Could not find matching reaction functions
}
