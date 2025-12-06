#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Reactor: time_elapsed_calculator_reaction_function_0
// Generated from LF compiler output

void _time_elapsed_calculatorreaction_function_0(int64_t* saved_start_time) {
    (*saved_start_time) = start_time->value;
        if (*saved_start_time >= 0) {
            int64_t elapsed = end_time->value - *saved_start_time;
            printf("Time elapsed = %d ns", (int)elapsed);
        }
}
