#include "../../kernel/kos/core/include/k_api.h"
#include "../include/soc.h"

uint64_t g_sys_tick_count;
void systick_handler(void){
    g_sys_tick_count++;
    krhino_tick_proc();
}
