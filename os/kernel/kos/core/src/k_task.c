#include "../include/k_api.h"

static kstat_t task_create(ktask_t *task, const name_t *name, void *arg,
                           uint8_t prio, tick_t ticks, cpu_stack_t *stack_buf,
                           size_t stack_size, task_entry_t entry, uint8_t autorun,
                           uint8_t mm_alloc_flag, uint8_t cpu_num, uint8_t cpu_binded)
{
    CPSR_ALLOC();
    cpu_stack_t *tmp;
    NULL_PARA_CHK(task);
    NULL_PARA_CHK(name);
    NULL_PARA_CHK(entry);
    NULL_PARA_CHK(stack_buf);

    if(stack_size == 0u) { return 0; /*RHINO_TASK_INV_STACK_SIZE */}
    if(prio >= RHINO_CONFIG_PRI_MAX) {return 0;/*RHINO_BEYOND_MAX_PRI*/ }

    RHINO_CRITICAL_ENTER();
    INTRPT_NESTED_LEVEL_CHK();

    /* idle task is only allowed to create once*/
    if(prio == RHINO_IDLE_PRI){



        RHINO_CRITICAL_EXIT();
        return 0; /* RHINO_IDLE_TASK_EXIST*/
    }

    //set memmory to 0
    memset(task,0,sizeof(ktask_t));

    //RR
    if(ticks > 0u){
        task->time_total = ticks;
    } else {
        task->time_total = RHINO_CONFIG_TIME_SLICE_DEFAULT;
    }
    task->time_slice   = task->time_total;
    task->sched_policy = KSCHED_RR;

    RHINO_CRITICAL_EXIT();

    if(autorun > 0u){
        task->task_state = K_RDY;
    } else {
        task->task_state = K_SUSPENDED;
        task->suspend_count = 1u;
    }

    task->task_stack_base = stack_buf;
    tmp = stack_buf;
    //set stack to 0
    memset(tmp,0,stack_size*sizeof(cpu_stack_t));

    task->task_name     = name;
    task->prio          = prio;
    task->b_prio        = prio;
    task->stack_size    = stack_size;
    task->mm_alloc_flag = mm_alloc_flag;
    task->cpu_num       = cpu_num;
    cpu_binded          = cpu_binded;

    task->task_stack = cpu_task_stack_init(stack_buf,stack_size,arg,entry);

    RHINO_CRITICAL_ENTER();
    klist_insert(&(g_kobj_list.task_head), &task->task_stats_item);

    if(autorun > 0u){

        if(g_sys_stat == RHINO_RUNNING){
            RHINO_CRITICAL_EXIT_SCHED();
            return RHINO_SUCCESS;
        }
    }

    RHINO_CRITICAL_EXIT();
    return RHINO_SUCCESS;
}

kstat_t krhino_task_create(ktask_t *task, const name_t *name, void *arg,
                           uint8_t prio, tick_t ticks, cpu_stack_t *stack_buf,
                           size_t stack_size, task_entry_t entry, uint8_t autorun){
    return task_create(task,name,arg,prio,ticks,stack_buf,stack_size,entry,autorun,
                       K_OBJ_STATIC_ALLOC,0,0);
}

kstat_t krhino_task_dyn_create(ktask_t **task, const name_t *name, void *arg,
                               uint8_t pri,
                               tick_t ticks, size_t stack,
                               task_entry_t entry, uint8_t autorun){

    return 0;
}
