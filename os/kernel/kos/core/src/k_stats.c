#include "../include/k_api.h"

void kobj_list_init(void){
    klist_init(&(g_kobj_list.task_head));
    klist_init(&(g_kobj_list.mutex_head));
    //klist_init(&(g_kobj_list.mblkpool_head));
    klist_init(&(g_kobj_list.sem_head));
    //klist_init(&(g_kobj_list.queue_head));
    //klist_init(&(g_kobj_list.buf_queue_head));
    //klist_init(&(g_kobj_list.event_head));
}
