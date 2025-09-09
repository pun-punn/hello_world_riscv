#include "../include/k_api.h"
#include <cstdint>

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
    rq->cur_list_item[task->prio] = &task->task_list;
}

void ready_list_add_tail(runqueue_t *rq, ktask_t *task){
    _ready_list_add_tail(rq,task);
}

void time_slice_update(void){

}
