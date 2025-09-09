#include "../include/k_api.h"

void runqueue_init(runqueue_t *rq){

    uint8_t prio;
    rq->highest_pri = RHINO_CONFIG_PRI_MAX;

    for(prio =0; prio<RHINO_CONFIG_PRI_MAX; prio++ ){
        rq->cur_list_item[prio] = NULL;
    }

}
