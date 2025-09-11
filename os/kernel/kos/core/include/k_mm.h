#ifndef K_MM_H
#define K_MM_H

#include <string.h>





void *krhino_mm_alloc(size_t size, void *caller);

void  krhino_mm_free(void *ptr);

void *krhino_mm_realloc(void *oldmem, size_t new_size, void *caller);
#endif //K_MM_H
