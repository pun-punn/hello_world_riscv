#include "../include/k_api.h"

/* status */
kstat_t      g_sys_stat;

/* lock */
kspinlock_t  g_sys_lock;

/* schedule lock counter */
uint8_t      g_sched_lock[RHINO_CONFIG_CPU_NUM];
uint8_t      g_intrpt_nested_level[RHINO_CONFIG_CPU_NUM];

/* queue of task in scheduler */
runqueue_t   g_ready_queue;

/* tcb of ready task */
ktask_t     *g_preferred_ready_task[RHINO_CONFIG_CPU_NUM];

/* tcb of active task */
ktask_t     *g_active_task[RHINO_CONFIG_CPU_NUM];

/* tick attribute */
tick_t       g_tick_count;
klist_t      g_tick_head;

/* kobj of link list*/
kobj_list_t  g_kobj_list;


/*task idle */
ktask_t      g_idle_task[RHINO_CONFIG_CPU_NUM];
idle_count_t g_idle_count[RHINO_CONFIG_CPU_NUM];
cpu_stack_t  g_idle_task_stack[RHINO_CONFIG_CPU_NUM][RHINO_CONFIG_IDLE_TASK_STACK_SIZE];
uint8_t      g_idle_spawned[RHINO_CONFIG_CPU_NUM];

/* task dynamic memory alloc */
ksem_t       g_res_sem;
klist_t      g_res_list;
ktask_t      g_dyn_task;
cpu_stack_t  g_dyn_task_stack[RHINO_CONFIG_K_DYN_TASK_STACK];
