#include "../include/k_api.h"

kstat_t krhino_init(void){
    g_sys_stat = RHINO_STOPPED;

    krhino_spin_init(&g_sys_lock);

    runqueue_init(&g_ready_queue);

    tick_list_init();

    kobj_list_init();

    k_mm_init();

    //klist_init(&g_res_list);
    //krhino_sem_create(&g_res_sem, "res_sem", 0);
    //dyn_mem_proc_task_start();

    //create idle task
    krhino_task_create(&g_idle_task[0] /* tcb */, "idle_task", NULL, RHINO_IDLE_PRI, 0,
                       &g_idle_task_stack[0][0], RHINO_CONFIG_IDLE_TASK_STACK_SIZE /*256 + 20*/,
                       idle_task, 1u);

    //create task1
    krhino_task_create(&g_test_task1 /* tcb */, "task1", NULL, 10, 0,
                       g_test_task1_stack, RHINO_CONFIG_K_DYN_TASK_STACK /*64 + 20*/,
                        test_task1, 1u);
    //create task2
    krhino_task_create(&g_test_task2 /* tcb */, "task2", NULL, 10, 0,
                       g_test_task2_stack, RHINO_CONFIG_K_DYN_TASK_STACK /*64 + 20*/,
                       test_task2, 1u);
    //ktimer_init();

    return RHINO_SUCCESS;
}

kstat_t krhino_start(void){
    //CPSR_ALLOC();
    if (g_sys_stat == RHINO_STOPPED) {
        //RHINO_CPU_INTRPT_DISABLE();
        preferred_cpu_ready_task_get(&g_ready_queue, 0);
        g_active_task[0] = g_preferred_ready_task[0];

        //cpu_stack_t *sp = g_active_task[0]->task_stack;
        //printf("active task %s \r\n", g_active_task[0]->task_name);
        //for (int i = 0; i < 16; i++) {
        //    printf("[%02d] 0x%08lx\r\n", i, (unsigned long)sp[i]);
        //}
        g_sys_stat = RHINO_RUNNING;
        cpu_first_task_start();
        //RHINO_CPU_INTRPT_ENABLE();
        /* should not be here */
        return RHINO_SYS_FATAL_ERR;
    }
    return RHINO_SUCCESS;
}

kstat_t krhino_intrpt_enter(void){
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    cur_cpu_num = cpu_cur_get();
    if(g_intrpt_nested_level[cur_cpu_num] > RHINO_CONFIG_INTRPT_MAX_NESTED_LEVEL){
        RHINO_CPU_INTRPT_ENABLE();
        return -1;
    }
    g_intrpt_nested_level[cur_cpu_num]++;
    RHINO_CPU_INTRPT_ENABLE();
    return RHINO_SUCCESS;
}

void krhino_intrpt_exit(void){
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    cur_cpu_num = cpu_cur_get();

    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
        RHINO_CPU_INTRPT_ENABLE();
        //error
    }

    g_intrpt_nested_level[cur_cpu_num]--;

    if(g_intrpt_nested_level[cur_cpu_num] > 0u){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }

    if(g_sched_lock[cur_cpu_num] > 0u){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }

    /*get g_preferred_ready_task from g_ready_queue*/
    preferred_cpu_ready_task_get(&g_ready_queue, cur_cpu_num);
    cpu_stack_t *sp = g_active_task[0]->task_stack;
    printf("ret: 0x%08lx\n",(unsigned long)sp[14]);
    if(g_preferred_ready_task[cur_cpu_num] == g_active_task[cur_cpu_num]){
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }
    /* switch between g_active_task and g_preferred_ready_task*/
    cpu_intrpt_switch();
    RHINO_CPU_INTRPT_ENABLE();
}
