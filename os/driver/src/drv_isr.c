#include "../include/soc.h"
#include "../../kernel/kos/core/include/k_api.h"
#include "../../kernel/include/kos_api_kernel.h"

#define INTRPT_ENTER() kos_kernel_intrpt_enter()
#define INTRPT_EXIT()  kos_kernel_intrpt_exit()

extern void systick_handler(void);

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    INTRPT_ENTER();
    g_idle_count[cpu_cur_get()]++;
    systick_handler();
    CLINTCMP->MTIMECMP = CLINTTIME->MTIME + 50000;

    if(g_idle_count[0] == 10){
        SIMULATION->END = 1;
    }

    INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM0_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM1_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM2_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM3_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM4_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void UART0_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}

ATTRIBUTE_ISR void UART1_IRQHandler(void){
    INTRPT_ENTER();
    // your ISR code here
    INTRPT_EXIT();
}
