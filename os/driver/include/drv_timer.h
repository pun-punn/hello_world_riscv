#ifndef DRV_TIMER_H
#define DRV_TIMER_H

#include <stdio.h>
#include <stdint.h>
#include "soc.h"

typedef void *timer_handle_t;

typedef struct{
    _IO  uint32_t BASE;
    _I   uint32_t CNT;
    _IO  uint32_t CFG;
    _IO  uint32_t STS;
} timer_reg_t ;

typedef enum {
    TIMER_EVENT_TIMEOUT = 0
} timer_event_e;
typedef void (*timer_event_cb_t)(int32_t idx, timer_event_e event);

timer_handle_t drv_timer_initializa(int32_t idx, timer_event_cb_t cb_event);
int32_t        drv_timer_config(timer_handle_t handle, int cfg);
int32_t        drv_timer_delay(timer_handle_t handle, int dly);
#endif //DRV_TIMER_H
