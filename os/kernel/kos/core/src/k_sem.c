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
