#include "drv_timer.h"
#include "soc.h"

//private variable
typedef struct {
     uint8_t  idx;
     uint32_t base;
     uint32_t irq;
     timer_event_cb_t cb_event;
     uint32_t timeout;
     uint32_t timeout_flag;
} timer_priv_t;

extern int32_t target_get_timer(int32_t idx, uint32_t *base, uint32_t *irq, void **handler);

static timer_priv_t timer_instance[5]; // 5 timer port [0,1,2,3,4]

timer_handle_t drv_timer_initializa(int32_t idx, timer_event_cb_t cb_event){
     uint32_t base = 0u;
     uint32_t irq  = 0u;
     void    *handler;
     int32_t ret = target_get_timer(idx, &base ,&irq, &handler);

     if(ret < 0) { return 0;}
     timer_priv_t *timer_priv = &timer_instance[idx];
     timer_priv->base = base;
     timer_priv->irq  = irq;
     timer_priv->idx  = idx;
     timer_priv->cb_event  = cb_event;

     return (timer_handle_t)timer_priv;
}

int32_t drv_timer_config(timer_handle_t handle, int cfg){
     timer_priv_t *timer_priv = handle;
     timer_reg_t *addr = (timer_reg_t*) (timer_priv->base);
     addr->CFG = cfg;
     return 0;
}

int32_t drv_timer_delay(timer_handle_t handle, int dly){
     timer_priv_t *timer_priv = handle;
     timer_reg_t *addr = (timer_reg_t*) (timer_priv->base);

     addr->BASE =  0;
     addr->CFG  = (TIMER_PRESCALE_1) | 0x1;

     while ((addr->CNT)<=dly);

     addr->CFG  = (addr->CFG) & ~0x1;

     return 0;
}

/*
void timer0_cpu_int_en()
{
     *(volatile uint32*)CLINT_APB_TIMEINT = 0x80010100;
  	  
     return;
}

void timer0_cpu_int_dis()
{
     *(volatile uint32*)CLINT_APB_TIMEINT = 0x0;
  	  
     return;
}
*/
