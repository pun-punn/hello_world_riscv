#include "drv_uart.h"
#include "soc.h"

//private variable
typedef struct {
    uint32_t base;
    uint32_t gpio_base;
    uint32_t irq;
    uart_event_cb_t cb_event;
    uint32_t rx_total_num;
    uint32_t tx_total_num;
    uint8_t *rx_buf;
    uint8_t *tx_buf;
    volatile uint32_t rx_cnt;
    volatile uint32_t tx_cnt;
    volatile uint32_t tx_busy;
    volatile uint32_t rx_busy;
    //for get data count
    uint32_t last_tx_num;
    uint32_t last_rx_num;
    int32_t idx;
} uart_priv_t;

static uart_priv_t uart_instance[2]; // 2 uarts port [0,1]

extern int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler);

uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
    uint32_t base;
    uint32_t irq;
    void    *handler;
    uint32_t gpio_base;
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);

    if(ret < 0) { return 0;}
    uart_priv_t *uart_priv = &uart_instance[idx];
    uart_priv->base = base;
    uart_priv->gpio_base = gpio_base;
    uart_priv->idx  = idx;
    uart_priv->irq  = irq;
    uart_priv->cb_event  = cb_event;

    return (uart_handle_t)uart_priv;
}


int32_t drv_uart_config_baudrate(uart_handle_t handle, uint32_t baud, uint32_t cfg){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr_uart = (uart_reg_t*) (uart_priv->base);
    gpio_reg_t *addr_gpio = (gpio_reg_t*) (uart_priv->gpio_base);

    addr_gpio->DIR = 0x00000001;
    addr_gpio->MUX = 0x0000000F;
    addr_uart->BAUD = baud;
    addr_uart->CFG  = cfg;

    return 0;
}

int32_t drv_uart_putc(uart_handle_t handle, uint8_t ch){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*) (uart_priv->base);

    uint32_t fifo;
    do { fifo = addr->STS;
      fifo = fifo&0x1F;
    } while (fifo==16);

    addr->DATA = ch;

    return 0;
}

int32_t drv_uart_getc(uart_handle_t handle, uint8_t *ch){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*) (uart_priv->base);
    uint32_t fifo = 0;

    while (fifo==0) {
        fifo = addr->STS & 0x001F0000;
    }

    *ch = addr->DATA;
    return 0;
}

int32_t drv_uart_puts(uart_handle_t handle, char *str){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*) (uart_priv->base);

    uint32_t fifo = 0;
    while (*str) {
        fifo = addr->STS;
        fifo = fifo & 0x1F;
        if (fifo!=16) {addr->DATA = *str++;}
    }

    return 0;

}

int32_t drv_uart_gets(uart_handle_t handle, char *str){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*) (uart_priv->base);

    uint8_t ch,fifo;
    drv_uart_getc(handle, &ch);
    while ((ch!='\r') | (ch!='\n')) {
        *str++ = ch;
        drv_uart_getc(handle, &ch);
    }

    fifo = addr->STS & 0x001F0000;
    while (fifo!=0) {
        drv_uart_getc(handle, &ch);
        fifo = addr->STS & 0x001F0000;
    }
    return 0;
}
