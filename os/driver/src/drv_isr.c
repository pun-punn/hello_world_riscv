#include "../include/soc.h"

extern void systick_handler(void);

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    systick_handler();
}

ATTRIBUTE_ISR void TIM0_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void TIM1_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void TIM2_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void TIM3_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void TIM4_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void UART0_IRQHandler(void){
    // your ISR code here
}

ATTRIBUTE_ISR void UART1_IRQHandler(void){
    // your ISR code here
}
