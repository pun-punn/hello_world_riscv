#include "../../kernel/include/kos_api_kernel.h"
#include <string.h>

#ifndef MALLOC_WEAK
#define MALLOC_WEAK __attribute__((weak))
#endif

MALLOC_WEAK void *malloc(size_t size){
    void *ret;
    ret = kos_kernel_malloc(size, __builtin_return_address(0) );
    return ret;
}

MALLOC_WEAK void free(void *ptr){
    kos_kernel_free(ptr, __builtin_return_address(0) );
}

MALLOC_WEAK void *realloc(void *ptr, size_t size){
    void *new_ptr;
    new_ptr = kos_kernel_malloc(size, __builtin_return_address(0) );

    if(new_ptr == NULL) return new_ptr;

    if(ptr){
        memcpy(new_ptr,ptr,size);
        kos_kernel_free(ptr, __builtin_return_address(0) );
    }
    return new_ptr;
}

MALLOC_WEAK void *calloc(size_t nmemb, size_t size){
    void *ptr = NULL;
    ptr = kos_kernel_malloc(size * nmemb, __builtin_return_address(0) );

    if(ptr){
        memset(ptr,0,size*nmemb);
    }
    return ptr;
}
