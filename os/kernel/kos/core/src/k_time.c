#include "../include/k_api.h"

void krhino_tick_proc(void){
    tick_list_update(1);
    time_slice_update();
}
