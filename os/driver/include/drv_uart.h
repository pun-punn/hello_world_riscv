#ifndef DRV_UART_H
#define DRV_UART_H

#include "soc.h"
#include "../include/drv_clk.h"
#include <stdint.h>

typedef void *uart_handle_t;

typedef struct {
    _IO uint32_t DATA;
    _IO uint32_t CFG;
    _IO uint32_t BAUD;
    _I  uint32_t STS;
} uart_reg_t;

typedef enum {
    UART_EVENT_SEND_COMPLETE       = 0,
    UART_EVENT_RECEIVE_COMPLETE    = 1,
} uart_event_e;
typedef void (*uart_event_cb_t)(int32_t idx, uart_event_e event);

uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event);
int32_t       drv_uart_config_baudrate(uart_handle_t handle, uint32_t baud, uint32_t cfg);
int32_t       drv_uart_putc(uart_handle_t handle, uint8_t ch);
int32_t       drv_uart_getc(uart_handle_t handle, uint8_t *ch);
int32_t       drv_uart_puts(uart_handle_t handle, char *str);
int32_t       drv_uart_gets(uart_handle_t handle, char *str);

#endif //DRV_UART_H
