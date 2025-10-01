#ifndef K_CRITICAL_H
#define K_CRITICAL_H

#include <stdint.h>
#include "../../arch/include/k_types.h"
#include "../../arch/include/port.h"

typedef struct{

    uint32_t   cnt;
    cpu_cpsr_t cpsr;
} kspinlock_t;


#define krhino_spin_lock(lock)        krhino_sched_disable();
#define krhino_spin_unlock(lock)      krhino_sched_enable();

#define krhino_spin_init(lock)

#define RHINO_CRITICAL_ENTER()      \
do {                                \
    RHINO_CPU_INTRPT_DISABLE();     \
} while (0)

#define RHINO_CRITICAL_EXIT()       \
do {                                \
    RHINO_CPU_INTRPT_ENABLE();      \
} while (0)

#define RHINO_CRITICAL_EXIT_SCHED() \
do {                                \
    RHINO_CPU_INTRPT_ENABLE();      \
    core_sched();                   \
} while (0)

#endif //K_CRITICAL_H
