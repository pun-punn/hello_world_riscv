#include "../../include/kos_api_kernel.h"
#include "../../../driver/include/soc.h"
#include "../core/include/k_api.h"

#define AUTORUN  1

k_status_t kos_kernel_init(void){
    kstat_t ret = krhino_init();
    if(ret == RHINO_SUCCESS){
        return 0;
    } else {
        return -1;
    }
}

k_status_t kos_kernel_start(void){
    kstat_t ret = krhino_start();
    if(ret == RHINO_SUCCESS){
        return 0;
    } else {
        return -1;
    }
}

k_status_t kos_kernel_task_new(k_task_entry_t task, const char *name, void *arg,
                               k_priority_t prio, uint32_t time_quanta,
                               void *stack, uint32_t stack_size, k_task_handle_t *task_handle){

    if ((task_handle == NULL) || (stack_size % 4 != 0) || ((stack_size == 0) && (stack == NULL)) || prio <= KPRIO_IDLE || prio > KPRIO_REALTIME7) {
        return -22;
    }

    k_status_t rc = -1;
    uint8_t prio_trans = RHINO_CONFIG_USER_PRI_MAX - prio;
    kos_kernel_sched_suspend();
    kstat_t ret;
    if (name) {
        ret = krhino_task_dyn_create((ktask_t **)task_handle, name, arg, prio_trans, time_quanta, stack_size / 4, task, AUTORUN);
    } else {
        ret = krhino_task_dyn_create((ktask_t **)task_handle, "user_task", arg, prio_trans, time_quanta, stack_size / 4, task, AUTORUN);
    }

    if (ret == RHINO_SUCCESS) {
        kos_kernel_sched_resume(0);
        return 0;
    } else {
        kos_kernel_sched_resume(0);
        return -1;
    }
    return rc;
}

uint32_t kos_kernel_sched_suspend(void){
    if (g_sys_stat != RHINO_RUNNING) {
        return 0;
    }
    krhino_sched_disable();
    return 0;
}

void kos_kernel_sched_resume(uint32_t sleep_ticks){
    if (g_sys_stat != RHINO_RUNNING) {
        return;
    }
    krhino_sched_enable();
}
