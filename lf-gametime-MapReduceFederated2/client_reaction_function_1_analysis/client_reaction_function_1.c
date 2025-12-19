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

// Reactor: client_reaction_function_1
// Generated from LF compiler output

map_task_t _clientreaction_function_1(interval_t* period, int* job_counter, int64_t __symbolic_physical_time) {
    map_task_t __output_out;
    map_task_t task;
        task.job_id = (*job_counter)++;
        task.start_time = __symbolic_physical_time / MSEC(1);
        int pattern_type = rand() % 3;
        task.pattern = (processing_pattern_t)pattern_type;
        task.target_worker = (pattern_type == 2) ? 0 : ((rand() % 2) + 1);
        const char* patterns[] = {"SINGLE", "SEQ", "PARALLEL"};
        printf("[Client] Job %d [%s]", task.job_id, patterns[pattern_type]);
        __output_out = task;;
    return __output_out;
}
