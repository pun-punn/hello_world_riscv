#ifndef K_INTERNAL_H
#define K_INTERNAL_H

#include "../../arch/include/k_config.h"
#include "../include/k_default_config.h"
#include "../include/k_err.h"
#include "../include/k_task.h"
#include "../include/k_critical.h"
#include "../include/k_sched.h"

/*   */
//status
extern kstat_t     g_sys_stat;

//lock
extern kspinlock_t g_sys_lock;

//queue
extern runqueue_t  g_ready_quque;

//idle task
extern ktask_t     g_idle_rask[RHINO_CONFIG_CPU_NUM];

//ready task
extern ktask_t    *g_preferred_ready_task[RHINO_CONFIG_CPU_NUM];

//current task
extern ktask_t    *g_active_task[RHINO_CONFIG_CPU_NUM];

void runqueue_init(runqueue_t *rq);

#endif //K_INTERNAL_H
