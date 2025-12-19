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

// Reactor: time_elapsed_calculator_reaction_function_1
// Generated from LF compiler output

void _time_elapsed_calculatorreaction_function_1(instant_t* saved_start_time, instant_t end_time) {
    if (*saved_start_time >= 0) {
            instant_t elapsed = end_time - *saved_start_time;
            printf("Time elapsed = %d ns", (int)elapsed);
        }
}
