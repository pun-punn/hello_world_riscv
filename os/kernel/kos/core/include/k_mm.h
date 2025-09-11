#ifndef K_MM_H
#define K_MM_H

#include <string.h>
#include "k_err.h"


typedef struct{

} k_mm_head_t;

kstat_t krhino_init_mm_heap  (k_mm_head_t **ppmmhead, void *addr, size_t len);
kstat_t krhino_deinit_mm_heap(k_mm_head_t *mmhead);
kstat_t krhino_add_mm_region (k_mm_head_t *mmhead, void *addr, size_t len);

void   *k_mm_alloc  (k_mm_head_t *mmhead, size_t size);
void   *k_mm_free   (k_mm_head_t *mmhead, void *ptr);
void   *k_mm_realloc(k_mm_head_t *mmhead, void *oldmem, size_t new_size);

void   *krhino_mm_alloc(size_t size, void *caller);

void    krhino_mm_free(void *ptr);

void   *krhino_mm_realloc(void *oldmem, size_t new_size, void *caller);
#endif //K_MM_H
