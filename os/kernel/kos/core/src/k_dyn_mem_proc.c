#include "../include/k_api.h"

//process task
void dyn_mem_proc_task(void *arg){


}

void dyn_mem_proc_task_start(void){
    krhino_task_create(&g_dyn_task /* tcb */, "dyn_mem", 0, RHINO_CONFIG_K_DYN_MEM_TASK_PRI,
                       0, g_dyn_task_stack, RHINO_CONFIG_K_DYN_TASK_STACK /*64 + 20*/,
                       dyn_mem_proc_task, 1);
}
