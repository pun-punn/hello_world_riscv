#include "../include/soc.h"
#include "../include/drv_irq.h"

extern int32_t g_top_irqstack;
extern void irq_vectors_init(void);

static void _system_init_for_kernel(void){

    irq_vectors_init();

    //config core timer
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
}

void system_init(void){
    //config core local interrupt controller
    //CLIC->CLICCFG = 0x4UL;

    //set interrupt pendding
    for (int i = 0; i < 12; i++) {
        CLIC->INT[i].CLICINTIP = 0;
    }
    drv_irq_enable(MACH_SOFT_IRQn); //enable machine software interrupt
    _system_init_for_kernel();      //setting default interrupt and core timer interrupt
}
