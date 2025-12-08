#include <klee/klee.h>
#include <stdbool.h>

#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdlib.h>
#include <time.h>

bool conditional_var_0 = false;
bool conditional_var_1 = false;
bool conditional_var_2 = false;
bool conditional_var_3 = false;
bool conditional_var_4 = false;
bool conditional_var_5 = false;
bool conditional_var_6 = false;
bool conditional_var_7 = true;

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

// Preamble from LF file (custom types and functions)



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

// Reactor: server_reaction_function_0
// Generated from LF compiler output

packet _serverreaction_function_0(interval_t* refresh, int64_t __symbolic_elapsed_time, unsigned int __symbolic_microstep, packet inp) {
    packet __output_outp;
    packet *in = &inp;
        packet *out = malloc(sizeof(packet));
        out->id = in->id;
        out->seq = in->seq + 1;
        bool send = true;
        printf("(%lld, %d) [SERVER] Received packet id=%d seq=%d",
            __symbolic_elapsed_time, __symbolic_microstep, in->id, in->seq);
        switch (in->flags) {
            case 1: // SYN
                printf("[SERVER] Received SYN", __symbolic_elapsed_time, __symbolic_microstep);
                out->flags = 3; // SYN-ACK
                break;    
            case 2: // ACK
                printf("[SERVER] Received ACK", __symbolic_elapsed_time, __symbolic_microstep);
                send = false;
                break;
        }
        __gt_delay_for(MSEC(100));
        if (send)
            __output_outp = *out;;
    return __output_outp;
}

int main() {
    interval_t refresh_val;
    klee_make_symbolic(&refresh_val, sizeof(refresh_val), "refresh_val");
    interval_t* refresh = &refresh_val;
    int64_t __symbolic_elapsed_time;
    klee_make_symbolic(&__symbolic_elapsed_time, sizeof(__symbolic_elapsed_time), "__symbolic_elapsed_time");
    unsigned int __symbolic_microstep;
    klee_make_symbolic(&__symbolic_microstep, sizeof(__symbolic_microstep), "__symbolic_microstep");
    packet inp;
    klee_make_symbolic(&inp, sizeof(inp), "inp");
    // Force case 2 (path_index=5)
    klee_assume(inp.flags == 2);
    _serverreaction_function_0(refresh, __symbolic_elapsed_time, __symbolic_microstep, inp);
    klee_assert(conditional_var_0);
    klee_assert(conditional_var_1);
    klee_assert(conditional_var_2);
    klee_assert(conditional_var_3);
    klee_assert(conditional_var_4);
    klee_assert(conditional_var_5);
    klee_assert(conditional_var_6);
    klee_assert(conditional_var_7);
    return 0;
}