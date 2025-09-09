#include "../include/k_api.h"

kstat_t     g_sys_stat;

kspinlock_t g_sys_lock;

runqueue_t  g_ready_quque;

/* tcb of ready task */
ktask_t     *g_preferred_ready_task[RHINO_CONFIG_CPU_NUM];

/* tcb of active task */
ktask_t     *g_active_task[RHINO_CONFIG_CPU_NUM];
