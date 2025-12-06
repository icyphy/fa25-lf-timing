#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Reactor: clock_reaction_function_0
// Generated from LF compiler output

// Scheduling counter for WCET analysis
int schedule_count = 0;

void _clockreaction_function_0(void) {
    schedule_count++;  // lf_schedule overhead for WCET
}
