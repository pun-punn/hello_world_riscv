#ifndef K_TASK_H
#define K_TASK_H

#include <stdint.h>
#include <stddef.h>

#include "../../arch/include/k_types.h"
#include "k_err.h"
#include "k_list.h"
#include "k_sys.h"

typedef enum {
    K_SEED,
    K_RDY,
    K_PEND,
    K_SUSPENDED,
    K_PEND_SUSPENDED,
    K_SLEEP,
    K_SLEEP_SUSPENDED,
    K_DELETED,
} task_stat_t;

typedef struct {
    void            *task_stack;

    cpu_stack_t     *task_stack_base;
    uint32_t         stack_size;
    klist_t          task_list;

    suspend_nested_t suspend_count;

    //struct mutex_s  *mutex_list;

    klist_t          task_stats_item;

    klist_t          tick_list;
    tick_t           tick_match;
    tick_t           tick_remain;
    klist_t         *tick_head;

    void            *msg;

    const name_t    *task_name;
    task_stat_t      task_state;

    uint32_t         time_slice;
    uint32_t         time_total;
    uint8_t          sched_policy;

    uint8_t          cpu_num;

    uint8_t          prio;
    uint8_t          b_prio;
    uint8_t          mm_alloc_flag;
} ktask_t; //tcb

typedef void (*task_entry_t)(void *arg);

kstat_t  krhino_task_create(ktask_t *task, const name_t *name, void *arg,
                            uint8_t prio, tick_t ticks, cpu_stack_t *stack_buf,
                            size_t stack_size, task_entry_t entry, uint8_t autorun);

kstat_t  krhino_task_dyn_create(ktask_t **task, const name_t *name, void *arg,
                                uint8_t pri,
                                tick_t ticks, size_t stack,
                                task_entry_t entry, uint8_t autorun);

kstat_t  krhino_task_sleep(tick_t dly);

kstat_t  krhino_task_dyn_del(ktask_t *task);

ktask_t *krhino_cur_task_get(void);

void     krhino_task_deathbed(void);
#endif //K_TASK_H
