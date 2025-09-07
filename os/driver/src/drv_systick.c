#include "../include/soc.h"

uint64_t g_sys_tick_count;
void systick_handler(void){
    g_sys_tick_count++;
}
