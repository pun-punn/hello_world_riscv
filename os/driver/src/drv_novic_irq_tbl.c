#include "../include/soc.h"

extern void Default_Handler(void);
extern void CORET_IRQHandler(void);

void (*g_irqvector[48])(void);

void irq_vectors_init(void){
    for (int i = 0; i < 48; i++) {
        g_irqvector[i] = Default_Handler;
    }
    g_irqvector[CORET_IRQn] = CORET_IRQHandler;
}
