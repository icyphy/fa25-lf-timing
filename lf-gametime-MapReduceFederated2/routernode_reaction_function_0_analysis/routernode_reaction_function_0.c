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

// Reactor: routernode_reaction_function_0
// Generated from LF compiler output

int _routernodereaction_function_0(int* messages_routed, int from_master_w1) {
    int __output_to_worker1_task;
    if (from_master_w1->is_present) {
          __output_to_worker1_task = from_master_w1;;
          (*messages_routed)++;
        }
    return __output_to_worker1_task;
}
