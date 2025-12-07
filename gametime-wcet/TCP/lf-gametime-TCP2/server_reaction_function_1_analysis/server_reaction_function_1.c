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

// Reactor: server_reaction_function_1
// Generated from LF compiler output

void _serverreaction_function_1(interval_t* refresh, packet inp) {
    // (*refresh) --> triggers network bandwidth overload
}
