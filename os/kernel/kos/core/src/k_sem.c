#include "../include/k_api.h"

static kstat_t sem_create(ksem_t *sem, const name_t *name, sem_count_t count, uint8_t mm_alloc_flag){
    CPSR_ALLOC();
    NULL_PARA_CHK(sem);
    NULL_PARA_CHK(name);

    klist_init(&sem->blk_obj.blk_list);

    sem->count              = count;
    sem->peak_count         = count;
    sem->blk_obj.name       = name;
    sem->blk_obj.blk_policy = BLK_POLICY_PRI;
    sem->mm_alloc_flag      = mm_alloc_flag;

    RHINO_CRITICAL_ENTER();
    klist_insert(&(g_kobj_list.sem_head), &sem->sem_item);
    RHINO_CRITICAL_EXIT();

    sem->blk_obj.obj_type = RHINO_SEM_OBJ_TYPE;

    //trace

    return RHINO_SUCCESS;
}

kstat_t krhino_sem_create(ksem_t *sem, const name_t *name, sem_count_t count){
    return sem_create(sem, name, count, K_OBJ_STATIC_ALLOC);
}

kstat_t krhino_sem_take(ksem_t *sem, tick_t ticks){
    CPSR_ALLOC();

    uint8_t  cur_cpu_num;
    //kstat_t  stat;

    NULL_PARA_CHK(sem);

    RHINO_CRITICAL_ENTER();

    INTRPT_NESTED_LEVEL_CHK();

    if (sem->blk_obj.obj_type != RHINO_SEM_OBJ_TYPE) {
        RHINO_CRITICAL_EXIT();
        //return RHINO_KOBJ_TYPE_ERR;
        return -1;
    }

    cur_cpu_num = cpu_cur_get();

    if (sem->count > 0u) {
        sem->count--;

        RHINO_CRITICAL_EXIT();
        return RHINO_SUCCESS;
    }

    /* can't get semphore, and return immediately if wait_option is  RHINO_NO_WAIT */
    if (ticks == RHINO_NO_WAIT) {
        RHINO_CRITICAL_EXIT();
        return -1;
    }

    if (g_sched_lock[cur_cpu_num] > 0u) {
        RHINO_CRITICAL_EXIT();
        return -1;
    }

    pend_to_blk_obj((blk_obj_t *)sem, g_active_task[cur_cpu_num], ticks);

    RHINO_CRITICAL_EXIT_SCHED();

    RHINO_CPU_INTRPT_DISABLE();

    //stat = pend_state_end_proc(g_active_task[cpu_cur_get()]);

    RHINO_CPU_INTRPT_ENABLE();

    return RHINO_SUCCESS;
}
