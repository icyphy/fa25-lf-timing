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

// Solution #1: Wrap rdtime in a normal C function for KLEE compatibility
#ifdef __KLEE__
uint64_t klee_any_uint64_t(void);
static inline uint64_t __gt_get_rdtime(void) {
    return klee_any_uint64_t();
}
#else
static inline uint64_t read_time_hw(void) {
    uint64_t t;
    asm volatile("rdtime %0" : "=r"(t));
    return t;
}
static inline uint64_t __gt_get_rdtime(void) {
    return read_time_hw();
}
#endif

static inline void __gt_delay_for(interval_t ns) {
    uint64_t start = __gt_get_rdtime();
    uint64_t target = start + (uint64_t)ns;
    while (__gt_get_rdtime() < target) { }
}

// Preamble from LF file
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

// Driver function - orchestrates all reactors
// Represents one logical time step of Philosophers
// Execution order determined by LF compiler's topological sort

// Scheduling counter for WCET analysis
int schedule_count = 0;

// Global state variables from all reactors
// From philosopher reactor:
size_t bank_index = (size_t)0;
size_t count = (size_t)0;
int times_eaten = 0;
// From arbitrator reactor:
size_t num_philosophers = (size_t)0;
bool* forks = (bool*)0;
int* replies = (int*)0;
size_t finished_philosophers = (size_t)0;
size_t arbitration_id = (size_t)0;
size_t retries = (size_t)0;

// Forward declarations of reaction functions
int _philosopherreaction_function_0(bool start);
int _philosopherreaction_function_1(bool eat);
int _philosopherreaction_function_2(bool denied);
void _arbitratorreaction_function_0(void);
void _arbitratorreaction_function_1(void);
int _arbitratorreaction_function_2(void);
void _arbitratorreaction_function_3(void);
void _arbitratorreaction_function_4(void);
int _arbitratorreaction_function_5(bool finished);

void Philosophers_tick() {
    // Execute reactions in topological order (level 0, then level 1, ...)

    // Connection: arbitrator.eat → philosophers.eat
    // Note: Could not find matching reaction functions

    // Connection: arbitrator.denied → philosophers.denied
    // Note: Could not find matching reaction functions

    // Connection: philosophers.finished → arbitrator.finished
    // Note: Could not find matching reaction functions

    // Connection: philosophers.hungry → arbitrator.hungry
    // Note: Could not find matching reaction functions

    // Connection: philosophers.done → arbitrator.done
    // Note: Could not find matching reaction functions
}
