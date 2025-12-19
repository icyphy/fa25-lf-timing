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

// Reactor: printer_reaction_function_0
// Generated from LF compiler output

void _printerreaction_function_0(int* message_count, int64_t __symbolic_logical_time, int in) {
    (*message_count)++;
        // Multiple execution paths in printer too
        if (in < 10) {
            // Short message path
            printf("Small: %d", in);
        } else if (in < 50) {
            // Medium message path
            printf("Medium: %d at time %lld", in, __symbolic_logical_time);
        } else {
            // Large message path with more computation
            int temp = in;
            for (int i = 0; i < 2; i++) {
                temp += i;
            }
            printf("Large: %d (processed: %d) at time %lld", 
                     in, temp, __symbolic_logical_time);
        }
        // Additional conditional path
        if (*message_count > 3) {
            printf("High activity detected!");
        }
}
