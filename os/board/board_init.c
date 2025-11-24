/*
 * Copyright (C) 20xx-20xx xxx
 */


/******************************************************************************
 * @file     board_init.c
 * @brief    Source File for board init
 * @version
 * @date
 ******************************************************************************/
#include <stdio.h>
#include "../driver/include/drv_uart.h"
#include "../driver/include/drv_clk.h"
#include "../driver/include/soc.h"

extern uart_handle_t console_handle;
extern clk_handle_t  clk_handle;

void board_init(void)
{
    int ret = 0;

    clk_handle = drv_clk_initialize();
    drv_clk_setup(clk_handle, SOC_CLK_CLKSRC_PLL | SOC_CLK_CLKSEL_DIV4);
    drv_clk_enable(clk_handle, SOC_CLKEN_UART0);

    console_handle = drv_uart_initialize(0, NULL);
    ret = drv_uart_config_baudrate(console_handle, 217, (UART_CFG_TXSTART | UART_CFG_RXSTART ));

    printf("boad init console uart0 \r\n");

    if(ret < 0 ) { return; }
}

int32_t drv_get_cpu_id(void)
{
    return 0;
}
