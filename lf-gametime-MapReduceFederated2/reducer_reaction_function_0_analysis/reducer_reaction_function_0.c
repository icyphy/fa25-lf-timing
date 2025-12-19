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

// Reactor: reducer_reaction_function_0
// Generated from LF compiler output

void _reducerreaction_function_0(int* jobs_completed, long* total_latency_ms, int from_worker1) {
    map_result_t result = from_worker1;
        const char* pat = (result.pattern == SINGLE_NODE) ? "SINGLE" : 
                          (result.pattern == SEQUENTIAL) ? "SEQ" : "PARALLEL";
        printf("[Reduce] J%d [%s] from W%d: %ld ms", 
                 result.job_id, pat, result.worker_id, result.processing_time_ms);
        (*jobs_completed)++;
        (*total_latency_ms) += result.processing_time_ms;
}
