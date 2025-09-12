/*
 * Copyright (C) 2017-2019 Alibaba Group Holding Limited
 */


/******************************************************************************
 * @file     minilibc_port.c
 * @brief    minilibc port
 * @version  V1.0
 * @date     26. Dec 2017
 ******************************************************************************/

#include <stdio.h>
#include "../../driver/include/drv_uart.h"
#include "../../kernel/include/kos_api_kernel.h"

uart_handle_t console_handle = NULL;

__attribute__((weak)) int write(int __fd, __const void *__buf, int __n)
{
    return 0;
}

int fputc(int ch, FILE *stream)
{
    (void)stream;

    if (console_handle == NULL) {
        return -1;
    }

    if (ch == '\n') {
        drv_uart_putc(console_handle, '\r');
    }

    drv_uart_putc(console_handle, ch);


    return 0;
}

int fgetc(FILE *stream)
{
    uint8_t ch;
    (void)stream;

    drv_uart_getc(console_handle, &ch);

    return ch;
}

int os_critical_enter(unsigned int *lock){
     (void)lock;
     kos_kernel_sched_suspend();
     return 0;
}

int os_critical_exit(unsigned int *lock){
     (void)lock;
     kos_kernel_sched_resume(0);
     return 0;
}
