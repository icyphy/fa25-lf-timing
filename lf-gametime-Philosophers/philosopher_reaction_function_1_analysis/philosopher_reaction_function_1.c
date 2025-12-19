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

// Preamble from LF file (custom types and functions)
#include <string.h>
/*
     * Try to acquire both forks for a philosopher. Returns true if
     * successful and false otherwise.
     */
    bool acquire_forks(bool forks[], size_t instance, size_t num_philosophers) {
        size_t left = instance;
        size_t right = (instance + 1) % num_philosophers;
        if (forks[left] || forks[right]) {
            // someone else has access to the forks
            return false;
        } else {
            // Forks are available. Mark them in use.
            forks[left] = true;
            forks[right] = true;
            return true;
        }
    }

    /*
     * Release the forks acquired by a philosopher. This does not perform
     * any checks!
     */
     void free_forks(bool forks[], size_t instance, size_t num_philosophers) {
        forks[instance] = false; // left
        forks[(instance + 1) % num_philosophers] = false; // right
     }

     enum Reply {
        INVALID = 0,
        EAT = 1,
        DENIED = 2,
    };

// Reactor: philosopher_reaction_function_1
// Generated from LF compiler output

void _philosopherreaction_function_1(size_t* bank_index, size_t* count, int* times_eaten, bool eat) {
    bool __output_done;
    bool __output_finished;
    bool __output_hungry;
    // ... take left and right fork
        printf("Philosopher %zu is eating.", *bank_index);
        (*times_eaten)++;
        __output_done = true;;
        if ((*times_eaten) == *count) {
            __output_finished = true;;
        } else {
            __output_hungry = true;;
        }
}
