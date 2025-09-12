#include "../include/soc.h"
#include "../../kernel/include/kos_api_kernel.h"

#define INTRPT_ENTER() kos_kernel_intrpt_enter()
#define INTRPT_EXIT()  kos_kernel_intrpt_exit()

extern void systick_handler(void);

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    //INTRPT_ENTER();
    systick_handler();
    //INTRPT_EXIT();
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
