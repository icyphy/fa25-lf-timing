#include <flexpret/flexpret.h> 
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

// Preamble from LF file (custom types and functions)
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

// Reactor: client_reaction_function_2
// Generated from LF compiler output

packet _clientreaction_function_2(interval_t* period, int* id, int64_t __symbolic_elapsed_time, unsigned int __symbolic_microstep, packet inp) {
    packet __output_outp;
    packet *in = &inp;
        packet *out = malloc(sizeof(packet));
        out->id = in->id;
        out->seq = in->seq + 1;
        bool send = true;
        printf("(%lld, %d) [CLIENT] Received packet (*id)=%d seq=%d",
            __symbolic_elapsed_time, __symbolic_microstep, in->id, in->seq);
        switch (in->flags) {
            case 3: // SYN-ACK
                printf("[CLIENT] Received SYN-ACK", __symbolic_elapsed_time, __symbolic_microstep);
                out->flags = 2; // ACK
                break;
        }
        __gt_delay_for(MSEC(randint(40, 60))); // simulate processing + connection delay
        if (send)
            __output_outp = *out;;
    return __output_outp;
}

static inline unsigned long read_cycle_count() {
    return rdcycle();
}
interval_t period_val = 0x0000000000000000;
int id_val = 0x00000000;
int64_t __symbolic_elapsed_time = 0x0000000000000000;
unsigned int __symbolic_microstep = 0x00000000;
packet inp = {0};
// Pointer arguments: pass address of local variable
// period -> &period_val
// id -> &id_val
int main(int argc, char ** argv)
{
  unsigned long long start;
  unsigned long long end;
  start = read_cycle_count();
  _clientreaction_function_2(&period_val, &id_val, __symbolic_elapsed_time, __symbolic_microstep, inp);
  end = read_cycle_count();
  printf("%i\n", (uint32_t) (end - start));
  return 0;
}

