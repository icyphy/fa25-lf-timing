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

// Reactor: counter_reaction_function_0
// Generated from LF compiler output

int _counterreaction_function_0(int* stride, int* count, int* even_count, int* odd_count) {
    int __output_out;
    // Multiple execution paths based on *count value
        if (*count % 2 == 0) {
            // Even path - more complex computation
            (*even_count)++;
            for (int i = 0; i < 3; i++) {
                (*even_count) += i;
            }
            __output_out = *count * 2;;
        } else {
            // Odd path - different computation
            (*odd_count)++;
            if (*count > 5) {
                // Nested conditional for more paths
                __output_out = *count * 3;;
            } else {
                __output_out = *count + 10;;
            }
        }
        (*count) += *stride;
    return __output_out;
}
