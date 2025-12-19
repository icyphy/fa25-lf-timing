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

// Reactor: producerreactor_reaction_function_0
// Generated from LF compiler output

// Scheduling counter for WCET analysis
int schedule_count = 0;

bool _producerreactorreaction_function_0(int* countTo, int* i) {
    bool __output_outResetCounter;
    // Initialize: reset counter and start counting
        (*i) = 0;
        __output_outResetCounter = true;;
        schedule_count++;  // lf_schedule overhead for WCET
    return __output_outResetCounter;
}
