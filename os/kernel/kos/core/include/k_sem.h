#ifndef K_SEM_H
#define K_SEM_H

#include "../../arch/include/k_types.h"
#include "k_sys.h"
#include "k_obj.h"
#include "k_err.h"

typedef struct sem_s {
    blk_obj_t   blk_obj;
    sem_count_t count;
    sem_count_t peak_count;

    klist_t     sem_item;
    uint8_t     mm_alloc_flag;
    uint8_t     semid;
} ksem_t;

kstat_t krhino_sem_create(ksem_t *sem, const name_t *name, sem_count_t count);

kstat_t krhino_sem_take(ksem_t *sem, tick_t ticks);
#endif //K_SEM_H
