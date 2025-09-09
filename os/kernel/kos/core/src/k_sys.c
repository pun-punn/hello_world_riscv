#include "../include/k_api.h"

kstat_t krhino_init(void){
    g_sys_stat = RHINO_STOPPED;

    krhino_spin_init(&g_sys_lock);

    runqueue_init(&g_ready_queue); // init

    tick_list_init();

    kobj_list_init();

    //k_mm_init();

    klist_init(&g_res_list);
    krhino_sem_create(&g_res_sem, "res_sem", 0);
    dyn_mem_proc_task_start();

    //create idle task
    krhino_task_create(&g_idle_task[0] /* tcb */, "idle_task", NULL, RHINO_IDLE_PRI, 0,
                       &g_idle_task_stack[0][0], RHINO_CONFIG_IDLE_TASK_STACK_SIZE /*256 + 20*/,
                       idle_task, 1u);
    //ktimer_init();

    //cpu_usage_stats_start();

    //rhino_stack_check_init();

    return RHINO_SUCCESS;
}

kstat_t krhino_start(void){

    if (g_sys_stat == RHINO_STOPPED) {
        //preferred_cpu_ready_task_get(&g_ready_queue, 0);
        //g_active_task[0] = g_preferred_ready_task[0];

        g_sys_stat = RHINO_RUNNING;
        //cpu_first_task_start();

        /* should not be here */
        return RHINO_SYS_FATAL_ERR;
    }
    return RHINO_SUCCESS;
}
