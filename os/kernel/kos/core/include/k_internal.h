#ifndef K_INTERNAL_H
#define K_INTERNAL_H

#include "../../arch/include/k_config.h"
#include "k_default_config.h"
#include "k_err.h"
#include "k_task.h"
#include "k_critical.h"
#include "k_sched.h"
#include "k_obj.h"
#include "k_sem.h"
#include "k_sys.h"

#define K_OBJ_STATIC_ALLOC 1u
#define K_OBJ_DYN_ALLOC    2u

#define INTRPT_NESTED_LEVEL_CHK()                                 \
        do {                                                      \
            if (g_intrpt_nested_level[cpu_cur_get()] > 0u) {      \
                RHINO_CRITICAL_EXIT();                            \
                return 1002; /*RHINO_NOT_CALLED_BY_INTRPT;*/      \
            }                                                     \
        } while (0)

#define NULL_PARA_CHK(para)             \
        do {                            \
            if(para == NULL){           \
                return RHINO_NULL_PTR;  \
            }                           \
        } while(0)

#define RES_FREE_NUM 4

typedef struct {
    uint8_t cnt;
    void   *res[RES_FREE_NUM];
    klist_t res_list;
} res_free_t;
/*   */
//status
extern kstat_t     g_sys_stat;

//lock
extern kspinlock_t g_sys_lock;

/* system lock */
extern uint8_t     g_sched_lock[RHINO_CONFIG_CPU_NUM];
extern uint8_t     g_intrpt_nested_level[RHINO_CONFIG_CPU_NUM];

//queue
extern runqueue_t  g_ready_queue;

//ready task
extern ktask_t    *g_preferred_ready_task[RHINO_CONFIG_CPU_NUM];

//current task
extern ktask_t    *g_active_task[RHINO_CONFIG_CPU_NUM];

//tick
extern tick_t      g_tick_count;
extern klist_t     g_tick_head;

//obj
extern kobj_list_t g_kobj_list;

//idle task
void                idle_task(void *p_arg);
extern ktask_t      g_idle_task[RHINO_CONFIG_CPU_NUM];  /*tcb*/
extern idle_count_t g_idle_count[RHINO_CONFIG_CPU_NUM]; /*count idle*/
extern cpu_stack_t  g_idle_task_stack[RHINO_CONFIG_CPU_NUM][RHINO_CONFIG_IDLE_TASK_STACK_SIZE]; /*stack 256+20*/
extern uint8_t      g_idle_spawned[RHINO_CONFIG_CPU_NUM]; /*idle task check */

//idle test task
void                test_task1(void *p_arg);
void                test_task2(void *p_arg);
extern ktask_t      g_test_task1; /*tcb*/
extern ktask_t      g_test_task2; /*tcb*/
extern cpu_stack_t  g_test_task1_stack[RHINO_CONFIG_K_DYN_TASK_STACK];
extern cpu_stack_t  g_test_task2_stack[RHINO_CONFIG_K_DYN_TASK_STACK];

//dynamic memory alloc task
extern ksem_t       g_res_sem;  /*sem*/
extern klist_t      g_res_list; /*link*/
extern ktask_t      g_dyn_task; /*tcb*/
extern cpu_stack_t  g_dyn_task_stack[RHINO_CONFIG_K_DYN_TASK_STACK]; /*stack 64+20*/

/* k_mm.c */
void k_mm_init(void);

/* k_sched.c */
void runqueue_init(runqueue_t *rq);
void ready_list_add(runqueue_t *rq, ktask_t *task);
void ready_list_add_tail(runqueue_t *rq, ktask_t *task);
void ready_list_add_head(runqueue_t *rq, ktask_t *task);
void ready_list_rm(runqueue_t *rq, ktask_t *task);
void ready_list_head_to_tail(runqueue_t *rq, ktask_t *task);
void core_sched(void);
void time_slice_update(void);
void preferred_cpu_ready_task_get(runqueue_t *rq, uint8_t cpu_num);

/* k_dyn_mem_proc.c */
void dyn_mem_proc_task_start(void);

/* k_pend.c */
void pend_list_reorder(ktask_t *task);
void pend_task_wakeup(ktask_t *task);
void pend_to_blk_obj(blk_obj_t *blk_obj, ktask_t *task, tick_t timeout);
void pend_task_rm(ktask_t *task);

/* tick link list k_tick.c */
void tick_list_init(void);
void tick_task_start(void);
void tick_list_rm(ktask_t *task);
void tick_list_insert(ktask_t *task, tick_t time);
void tick_list_update(tick_i_t ticks);

#endif //K_INTERNAL_H
