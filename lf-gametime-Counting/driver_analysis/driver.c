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

// Driver function - orchestrates all reactors
// Represents one logical time step of Counting
// Execution order determined by LF compiler's topological sort

// Scheduling counter for WCET analysis
int schedule_count = 0;

// Global state variables from all reactors
// From countingreactor reactor:
int count = 0;
// From counting_main reactor:
int countTo = 10;
// From producerreactor reactor:
int producerreactor_countTo = 0;
int i = 0;

// Forward declarations of reaction functions
void _countingreactorreaction_function_0(bool inReset);
void _countingreactorreaction_function_1(bool inIncrement);
int _countingreactorreaction_function_2(bool inRetrieveResult);
void _counting_mainreaction_function_0(void);
void _counting_mainreaction_function_1(void);
int _producerreactorreaction_function_0(void);
int _producerreactorreaction_function_1(void);
int _producerreactorreaction_function_2(int inResult);
void _producerreactorreaction_function_3(void);

void Counting_tick() {
    // Execute reactions in topological order (level 0, then level 1, ...)

    // Connection: producer.outResetCounter → counter.inReset
    int producer_outResetCounter_to_counter = _producerreactorreaction_function_0();
    _countingreactorreaction_function_0(producer_outResetCounter_to_counter);

    // Connection: producer.outIncrement → counter.inIncrement
    int producer_outIncrement_to_counter = _producerreactorreaction_function_0();
    _countingreactorreaction_function_1(producer_outIncrement_to_counter);

    // Connection: producer.outRetrieveResult → counter.inRetrieveResult
    int producer_outRetrieveResult_to_counter = _producerreactorreaction_function_0();
    _countingreactorreaction_function_2(producer_outRetrieveResult_to_counter);

    // Connection: producer.finished → producer.finished
    // Note: Could not find matching reaction functions

    // Connection: counter.outSendResult → producer.inResult
    // Note: Could not find matching reaction functions
}
