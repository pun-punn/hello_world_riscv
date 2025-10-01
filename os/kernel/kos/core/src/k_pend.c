#include "../include/k_api.h"

RHINO_INLINE void pend_list_add(klist_t *head, ktask_t *task){
    klist_t *tmp;
    klist_t *list_start = head;
    klist_t *list_end   = head;

    for (tmp = list_start->next; tmp != list_end; tmp = tmp->next) {
        if (krhino_list_entry(tmp, ktask_t, task_list)->prio > task->prio) {
            break;
        }
    }

    klist_insert(tmp, &task->task_list);
}

void pend_list_reorder(ktask_t *task){

}

void pend_task_wakeup(ktask_t *task){

}

void pend_to_blk_obj(blk_obj_t *blk_obj, ktask_t *task, tick_t timeout){
    /* task need to remember which object is blocked on */
    task->blk_obj = blk_obj;

    if (timeout != RHINO_WAIT_FOREVER) {
        tick_list_insert(task, timeout);
    }

    task->task_state = K_PEND;

    /* remove from the ready list */
    ready_list_rm(&g_ready_queue, task);

    if (blk_obj->blk_policy == BLK_POLICY_FIFO) {
        /* add to the end of blocked objet list */
        klist_insert(&blk_obj->blk_list, &task->task_list);
    } else {
        /* add to the prio sorted block list */
        pend_list_add(&blk_obj->blk_list, task);
    }
}

void pend_task_rm(ktask_t *task){

}


