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

// Reactor: worker_reaction_function_1
// Generated from LF compiler output

map_result_t _workerreaction_function_1(int* worker_id, int* tasks_processed, int peer_result) {
    map_result_t __output_result_out;
    map_result_t peer = peer_result;
        long proc_time_ms = base_processing_ms + random_range(-20, 50);
        if (proc_time_ms < 10) proc_time_ms = 10;
        printf("[W%d] Stage2 J%d", *worker_id, peer.job_id);
        __gt_delay_for(MSEC(proc_time_ms));
        map_result_t result;
        result.job_id = peer.job_id;
        result.worker_id = *worker_id;
        result.pattern = peer.pattern;
        // For SEQUENTIAL, add times; for PARALLEL, just use stage2 time
        result.processing_time_ms = (peer.pattern == SEQUENTIAL) ? 
                                     peer.processing_time_ms + proc_time_ms : proc_time_ms;
        result.succeeded = peer.succeeded;
        __output_result_out = result;;
        (*tasks_processed)++;
    return __output_result_out;
}
