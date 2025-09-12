#include "../include/k_api.h"

void idle_task(void *arg){
    CPSR_ALLOC();
    (void)arg;
    while (1){
        RHINO_CPU_INTRPT_DISABLE();
        g_idle_count[cpu_cur_get()]++;
        RHINO_CPU_INTRPT_ENABLE();
        //hook

        //pwr mgmt
    }
}
