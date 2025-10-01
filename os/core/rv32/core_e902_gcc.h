#ifndef CORE_E902_GCC_H
#define CORE_E902_GCC_H
#include <stdlib.h>
#include <stdint.h>

#ifndef __ASM
#define __ASM                   __asm     /*!< asm keyword for GNU Compiler */
#endif

#ifndef __INLINE
#define __INLINE                inline    /*!< inline keyword for GNU Compiler */
#endif

#ifndef __ALWAYS_STATIC_INLINE
#define __ALWAYS_STATIC_INLINE  __attribute__((always_inline)) static inline
#endif

#ifndef __STATIC_INLINE
#define __STATIC_INLINE         static inline
#endif

__ALWAYS_STATIC_INLINE void __enable_irq(void){
    __ASM volatile ("csrsi mstatus, 0x8");
    __ASM volatile ("csrsi mie, 0x7");
}

__ALWAYS_STATIC_INLINE uint32_t __get_MSTATUS(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mstatus" : "=r"(result));
    return (uint32_t)(result);
}

__ALWAYS_STATIC_INLINE uint32_t __get_MCAUSE(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mcause" : "=r"(result));
    return (uint32_t)(result);
}

__ALWAYS_STATIC_INLINE uint32_t __get_MIE(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mie" : "=r"(result));
    return (uint32_t)(result);
}

__ALWAYS_STATIC_INLINE uint32_t __get_MTVEC(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mtvec" : "=r"(result));
    return (uint32_t)(result);
}

__ALWAYS_STATIC_INLINE uint32_t __get_MTVT(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mtvt" : "=r"(result));
    return (uint32_t)(result);
}

#endif //CORE_E902_GCC_H
