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

// Reactor: actuator_reaction_function_0
// Generated from LF compiler output

int _actuatorreaction_function_0(int64_t __symbolic_elapsed_time, int in1, int in2) {
    int __output_end_time;
    instant_t t = __symbolic_elapsed_time;
        __output_end_time = t;;
    return __output_end_time;
}
