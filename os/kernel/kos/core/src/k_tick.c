#include "../include/k_api.h"

void tick_list_init(void){
    klist_init(&g_tick_head);
}

void tick_list_rm(ktask_t *task){
    klist_t *tick_head_ptr = task->tick_head;
    if(tick_head_ptr != NULL){
        klist_rm(&task->tick_list);
        task->tick_head = NULL;
    }
}

RHINO_INLINE void tick_list_pri_insert(klist_t *head, ktask_t *task){
    tick_t  val;
    klist_t *q;
    klist_t *list_start;
    klist_t *list_end;
    ktask_t *task_iter_temp;

    list_start = list_end = head;
    val        = task->tick_remain;
    for(q = list_start->next; q!=list_end; q=q->next){
        task_iter_temp = krhino_list_entry(q, ktask_t ,tick_list );
        if(task_iter_temp->tick_match - g_tick_count > val){
            break;
        }
    }
    klist_insert(q, &task->task_list);
}

void tick_list_insert(ktask_t *task, tick_t time){
    klist_t *tick_head_ptr;
    if(time > 0u){
        task->tick_match  = g_tick_count + time;
        task->tick_remain = time;
        tick_head_ptr     = &g_tick_head;
        tick_list_pri_insert(tick_head_ptr, task);
        task->tick_head   = tick_head_ptr;
    }
}

void tick_list_update(tick_i_t ticks){

    CPSR_ALLOC();

    klist_t  *tick_head_ptr;
    ktask_t  *p_tcb;
    klist_t  *iter;
    klist_t  *iter_temp;
    tick_i_t  delta;

    RHINO_CRITICAL_ENTER();

    g_tick_count += ticks;

    tick_head_ptr = &g_tick_head;
    iter          = tick_head_ptr->next;

    while(1){
        if(iter != tick_head_ptr){
            iter_temp = iter->next;
            p_tcb     = krhino_list_entry(iter, ktask_t, tick_list);
            delta     = (tick_i_t)p_tcb->tick_match - (tick_i_t)(g_tick_count);
            if(delta < 0u){
                switch (p_tcb->task_state) {
                    case K_SLEEP:
                        break;
                    case K_PEND:
                        break;
                    case K_SUSPENDED:
                        break;
                    case K_SLEEP_SUSPENDED:
                        break;
                    default:
                        break;
                }
                iter = iter_temp;
            } else{
                break;
            }
        } else {
            break;
        }
    }

    RHINO_CRITICAL_EXIT();
}
