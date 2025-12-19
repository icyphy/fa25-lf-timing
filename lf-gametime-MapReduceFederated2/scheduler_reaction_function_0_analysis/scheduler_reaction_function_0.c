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

// Reactor: scheduler_reaction_function_0
// Generated from LF compiler output

int _schedulerreaction_function_0(int* jobs_scheduled, map_task_t in) {
    int __output_to_worker1;
    map_task_t task = in;
        if (task.pattern == SINGLE_NODE) {
          printf("[Sched] J%d -> W%d", task.job_id, task.target_worker);
          if (task.target_worker == 1) __output_to_worker1 = task;;
          else __output_to_worker2 = task;;
        } else if (task.pattern == SEQUENTIAL) {
          printf("[Sched] J%d -> W%d->W%d", task.job_id, task.target_worker,
                   (task.target_worker == 1) ? 2 : 1);
          if (task.target_worker == 1) __output_to_worker1 = task;;
          else __output_to_worker2 = task;;
        } else {  // PARALLEL_CROSS
          printf("[Sched] J%d -> W1+W2", task.job_id);
          map_task_t task1 = task, task2 = task;
          task1.target_worker = 1;
          task2.target_worker = 2;
          __output_to_worker1 = task1;;
          __output_to_worker2 = task2;;
        }
        (*jobs_scheduled)++;
    return __output_to_worker1;
}
