#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Stub for FlexPRET fp_delay_for - the real version uses RISC-V assembly (rdtime)
// which KLEE cannot symbolically execute
#define fp_delay_for(ns) do { volatile int64_t __delay_stub = (ns); (void)__delay_stub; } while(0)

// Reactor: middle_reaction_function_0
// Generated from LF compiler output

int _middlereaction_function_0(int64_t* duration, int in) {
    int __output_out;
    fp_delay_for(*duration);
        __output_out = 1;  // lf_set_present;
    return __output_out;
}
