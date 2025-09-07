#include "drv_uart.h"
#include "drv_timer.h"
#include "soc.h"

/****** TIMER *****/
extern void TIM0_IRQHandler(void);
extern void TIM1_IRQHandler(void);
extern void TIM2_IRQHandler(void);
extern void TIM3_IRQHandler(void);
extern void TIM4_IRQHandler(void);

struct {
    uint32_t  base;
    uint32_t  irq;
    void     *handler;
}
const sg_timer_config[5] = { //tim [0,1,2,3,4]
    {TIMER0_BASE, 32/*tim irq0*/, TIM0_IRQHandler},
    {TIMER1_BASE, 33/*tim irq1*/, TIM1_IRQHandler},
    {TIMER2_BASE, 34/*tim irq2*/, TIM2_IRQHandler},
    {TIMER3_BASE, 35/*tim irq3*/, TIM3_IRQHandler},
    {TIMER4_BASE, 36/*tim irq4*/, TIM4_IRQHandler},
};

int32_t target_get_timer(int32_t idx, uint32_t *base, uint32_t *irq, void **handler){
    if (base != 0) {
        *base = sg_timer_config[idx].base;
    }

    if (irq != 0) {
        *irq = sg_timer_config[idx].irq;
    }

    if (handler != 0) {
        *handler = sg_timer_config[idx].handler;
    }
    return idx;
}

/****** UART *****/
extern void UART0_IRQHandler(void);
extern void UART1_IRQHandler(void);

struct {
    uint32_t  base;
    uint32_t  irq;
    void     *handler;
    uint32_t  gpio_base;
}
const sg_uart_config[2] = { //uart [0,1]
    {UART0_BASE, 37/*uart irq0*/, UART0_IRQHandler, GPIO0_BASE},
    {UART1_BASE, 39/*uart irq1*/, UART1_IRQHandler, GPIO1_BASE},
};

int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler)
{
    if (base != 0) {
        *base = sg_uart_config[idx].base;
    }

    if(gpio_base != 0){
        *gpio_base = sg_uart_config[idx].gpio_base;
    }

    if (irq != 0) {
        *irq = sg_uart_config[idx].irq;
    }

    if (handler != 0) {
        *handler = sg_uart_config[idx].handler;
    }
    return idx;
}
