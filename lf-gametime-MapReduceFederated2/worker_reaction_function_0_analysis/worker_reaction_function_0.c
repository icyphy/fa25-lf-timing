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

// Reactor: worker_reaction_function_0
// Generated from LF compiler output

map_result_t _workerreaction_function_0(int* worker_id, int* tasks_processed, map_task_t task_in) {
    map_result_t __output_result_out;
    map_task_t task = task_in;
        long proc_time_ms = base_processing_ms + random_range(-20, 50);
        if (proc_time_ms < 10) proc_time_ms = 10;
        printf("[W%d] Processing J%d", *worker_id, task.job_id);
        __gt_delay_for(MSEC(proc_time_ms));
        map_result_t result;
        result.job_id = task.job_id;
        result.worker_id = *worker_id;
        result.pattern = task.pattern;
        result.processing_time_ms = proc_time_ms;
        result.succeeded = true;
        if (task.pattern == SINGLE_NODE) {
          // Direct to reducer
          __output_result_out = result;;
          (*tasks_processed)++;
        } else {
          // SEQUENTIAL or PARALLEL_CROSS: send to peer first
          __output_to_peer = result;;
        }
    return __output_result_out;
}
