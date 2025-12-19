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
#include <stdlib.h>
    #include <time.h>

    typedef struct {
        int id;
        int seq;
        int flags;
        /*
        0 = SYN
        1 = ACK
        2 = FIN
        */
    } packet;

    static inline int randint(int a, int b) {
        return (rand() % (b - a + 1)) + a;
    }

// Driver function - orchestrates all reactors
// Represents one logical time step of TCP2
// Execution order determined by LF compiler's topological sort

// Scheduling counter for WCET analysis
int schedule_count = 0;

// Global state variables from all reactors
// From server reactor:
interval_t refresh = MSEC(20);
// From client reactor:
interval_t period = SEC(1);
int id = 0;

// Forward declarations of reaction functions
int _serverreaction_function_0(void);
void _serverreaction_function_1(void);
void _clientreaction_function_0(void);
int _clientreaction_function_1(void);
int _clientreaction_function_2(void);

void TCP2_tick() {
    // Execute reactions in topological order (level 0, then level 1, ...)

    // Connection: c.outp → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: s.outp → delay.inp
    // Note: Could not find matching reaction functions

    // Connection: delay.out → s.inp
    // Note: Could not find matching reaction functions

    // Connection: delay.out → c.inp
    // Note: Could not find matching reaction functions
}
