#include "../include/k_api.h"

void runqueue_init(runqueue_t *rq){
    uint8_t prio;
    rq->highest_pri = RHINO_CONFIG_PRI_MAX;

    for(prio =0; prio<RHINO_CONFIG_PRI_MAX; prio++ ){
        rq->cur_list_item[prio] = NULL;
    }
}

kstat_t krhino_sched_disable(void){
    CPSR_ALLOC();

    RHINO_CRITICAL_ENTER();

    INTRPT_NESTED_LEVEL_CHK();

    if (g_sched_lock[cpu_cur_get()] >= SCHED_MAX_LOCK_COUNT) {
        RHINO_CRITICAL_EXIT();
        return 202;/*RHINO_SCHED_LOCK_COUNT_OVF;*/
    }

    g_sched_lock[cpu_cur_get()]++;
    RHINO_CRITICAL_EXIT();
    return RHINO_SUCCESS;
}

kstat_t krhino_sched_enable(void){
    CPSR_ALLOC();

    RHINO_CRITICAL_ENTER();

    INTRPT_NESTED_LEVEL_CHK();

    if (g_sched_lock[cpu_cur_get()] == 0u ) {
        RHINO_CRITICAL_EXIT();
        return 201;/*RHINO_SCHED_ALREADY_ENABLED;*/
    }
    g_sched_lock[cpu_cur_get()]--;
    if (g_sched_lock[cpu_cur_get()] > 0u ) {
        RHINO_CRITICAL_EXIT();
        return 200;/*RHINO_SCHED_ALREADY_DISABLE;*/
    }

    RHINO_CRITICAL_EXIT_SCHED();
    return RHINO_SUCCESS;
}

void core_sched(void){
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    cur_cpu_num = cpu_cur_get();

    if(g_intrpt_nested_level[cur_cpu_num] > 0u){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }

    if(g_sched_lock[cur_cpu_num] > 0u){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }

    preferred_cpu_ready_task_get(&g_ready_queue, cur_cpu_num);
    if(g_preferred_ready_task[cur_cpu_num] == g_active_task[cur_cpu_num]){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }

    cpu_task_switch();
    RHINO_CPU_INTRPT_ENABLE();
}

RHINO_INLINE void ready_list_init(runqueue_t *rq, ktask_t *task){
    rq->cur_list_item[task->prio] = &task->task_list;
    klist_init(rq->cur_list_item[task->prio]);
    krhino_bitmap_set(rq->task_bit_map,task->prio);
    if((task->prio) < (rq->highest_pri)){
        rq->highest_pri = task->prio;
    }
}

RHINO_INLINE uint8_t is_ready_list_empty(uint8_t prio){
    return (g_ready_queue.cur_list_item[prio] == NULL);
}

RHINO_INLINE void _ready_list_add_tail(runqueue_t *rq, ktask_t *task){
    if(is_ready_list_empty(task->prio)){
        ready_list_init(rq,task);
        return;
    }
    klist_insert(rq->cur_list_item[task->prio],&task->task_list);
}

RHINO_INLINE void _ready_list_add_head(runqueue_t *rq, ktask_t *task){
    if(is_ready_list_empty(task->prio)){
        ready_list_init(rq,task);
        return;
    }
    klist_insert(rq->cur_list_item[task->prio],&task->task_list);
    rq->cur_list_item[task->prio] = &task->task_list;
}


void ready_list_add_tail(runqueue_t *rq, ktask_t *task){
    _ready_list_add_tail(rq,task);
}

void ready_list_add_head(runqueue_t *rq, ktask_t *task){
    _ready_list_add_head(rq,task);
}

void ready_lsit_add(runqueue_t *rq, ktask_t *task){
    if(task->prio == g_active_task[cpu_cur_get()]->prio){
        ready_list_add_tail(rq,task );
    } else {
        ready_list_add_head(rq,task );
    }
}

void preferred_cpu_ready_task_get(runqueue_t *rq, uint8_t cpu_num){
    klist_t *node = rq->cur_list_item[rq->highest_pri];
    g_preferred_ready_task[cpu_cur_get()] = krhino_list_entry(node, ktask_t ,task_list );
}

void time_slice_update(void){
    CPSR_ALLOC();

    ktask_t *task;
    klist_t *head;
    uint8_t  task_pri;

    RHINO_CRITICAL_ENTER();
    task_pri = g_active_task[cpu_cur_get()]->prio;
    head     = g_ready_queue.cur_list_item[task_pri];
    if(is_ready_list_empty(task_pri)){
        RHINO_CRITICAL_EXIT();
        return;
    }

    task = krhino_list_entry(head,ktask_t,task_list);
    /* check scheduler policy */
    if(task->sched_policy == KSCHED_FIFO){
        RHINO_CRITICAL_EXIT();
        return;
    }

    /* only one task in list */
    if(head->next == head){
        RHINO_CRITICAL_EXIT();
        return;
    }

    /* decrease time slice*/
    if(task->time_slice > 0u) task->time_slice--;

    /* current task has time slide*/
    if(task->time_slice > 0u){
        RHINO_CRITICAL_EXIT();
        return;
    }

    /* if time slice = 0 move task to tail of ready list and restore time slice */
    ready_list_add_tail(&g_ready_queue,task );
    task->time_slice = task->time_total;
    RHINO_CRITICAL_EXIT();
}
