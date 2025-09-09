#ifndef K_CRITICAL_H
#define K_CRITICAL_H

#include <stdint.h>
#include "../../arch/include/k_types.h"

typedef struct{

    uint32_t   cnt;
    cpu_cpsr_t cpsr;
} kspinlock_t;


#define krhino_spin_lock(lock)        krhino_sched_disable();
#define krhino_spin_unlock(lock)      krhino_sched_enable();

#define krhino_spin_init(lock)


#endif //K_CRITICAL_H
