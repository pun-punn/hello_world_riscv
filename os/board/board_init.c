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
#include "../driver/include/soc.h"

extern uart_handle_t console_handle;

void board_init(void)
{
    int ret = 0;
    console_handle = drv_uart_initialize(0, NULL);

    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));

    printf("boad init console uart0 \r\n");

    if(ret < 0 ) { return; }
}

int32_t drv_get_cpu_id(void)
{
    return 0;
}
