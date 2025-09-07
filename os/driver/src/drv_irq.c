#include "../include/drv_irq.h"
#include "../include/soc.h"

extern void Default_Handler(void);
extern void (*g_irqvector[])(void);

void drv_irq_enable (uint32_t irq_num){
    vic_enable_irq(irq_num);
}

void drv_irq_disable(uint32_t irq_num){
    vic_disable_irq(irq_num);
}

void drv_irq_register  (uint32_t irq_num, void *irq_handler){
    g_irqvector[irq_num] = irq_handler;
}

void drv_irq_unregister(uint32_t irq_num){
    g_irqvector[irq_num] = (void *)Default_Handler;
}
