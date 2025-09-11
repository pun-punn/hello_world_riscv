#include "../include/k_api.h"

void k_mm_init(void){
    uint32_t e = 0;
}

kstat_t krhino_init_mm_heap(k_mm_head_t **ppmmhead, void *addr, size_t len){
    return 0;
}
kstat_t krhino_deinit_mm_heap(k_mm_head_t *mmhead){
    return 0;
}

kstat_t krhino_add_mm_region(k_mm_head_t *mmhead, void *addr, size_t len){
    return 0;
}

void *k_mm_alloc(k_mm_head_t *mmhead, size_t size){

}

void *k_mm_free(k_mm_head_t *mmhead, void *ptr){

}

void *k_mm_realloc(k_mm_head_t *mmhead, void *oldmem, size_t new_size){

}

void *krhino_mm_alloc(size_t size, void *caller){

}

void  krhino_mm_free(void *ptr){

}

void *krhino_mm_realloc(void *oldmem, size_t new_size, void *caller){

}
