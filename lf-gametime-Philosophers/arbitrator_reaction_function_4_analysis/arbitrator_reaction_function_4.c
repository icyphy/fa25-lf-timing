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

// Reactor: arbitrator_reaction_function_4
// Generated from LF compiler output

// Scheduling counter for WCET analysis
int schedule_count = 0;

void _arbitratorreaction_function_4(size_t* num_philosophers, bool** forks, int** replies, size_t* finished_philosophers, size_t* arbitration_id, size_t* retries) {
    // Iterate over all philosophers, each time starting from a different one.
        // This arbitration ensures that no philosopher has to starve.
        for(size_t i = *arbitration_id; i < *arbitration_id + *num_philosophers; i++) {
            size_t j = i % *num_philosophers;
            if (hungry[j]->is_present) {
                if (acquire_forks(*forks, j, *num_philosophers)) {
                    *replies[j] = EAT;
                } else {
                    *replies[j] = DENIED;
                    (*retries)++;
                }
            }
        }
        (*arbitration_id)++;
        if ((*arbitration_id) == *num_philosophers) {
            (*arbitration_id) = 0;
        }
        schedule_count++;  // lf_schedule overhead for WCET
}
