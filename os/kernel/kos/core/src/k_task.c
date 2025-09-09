#include "../include/k_api.h"


kstat_t krhino_task_create(ktask_t *task, const name_t *name, void *arg,
                           uint8_t prio, tick_t ticks, cpu_stack_t *stack_buf,
                           size_t stack_size, task_entry_t entry, uint8_t autorun){

    return 0;
}

kstat_t krhino_task_dyn_create(ktask_t **task, const name_t *name, void *arg,
                            uint8_t pri,
                            tick_t ticks, size_t stack,
                            task_entry_t entry, uint8_t autorun){

    return 0;
}
