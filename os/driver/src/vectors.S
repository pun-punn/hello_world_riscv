/*
 * Copyright (C) 2017-2019 Alibaba Group Holding Limited
 */

 /******************************************************************************
 * @file     vectors.S
 * @brief    define default vector handlers. Should use with
 *           GCC for WUJIAN Embedded Processors
 * @version  V1.0
 * @date     8. otc 2019
 ******************************************************************************/

.section .bss
    .align  2
    .globl  g_trapstackalloc
    .global g_trapstackbase
    .global g_top_trapstack
g_trapstackalloc:
g_trapstackbase:
    .space 512
g_top_trapstack:

    .align 2
    .globl g_trap_sp
    .type  g_trap_sp, object
g_trap_sp:
    .long 0
    .size g_trap_sp, .-g_trap_sp

irq_nested_level:
.long 0

.text

    .align  2
    .global Default_IRQHandler
    .weak   Default_IRQHandler
    .type   Default_IRQHandler, %function
Default_IRQHandler:
    nop #weak function not do any thing need to be generic irq

/******************************************************************************
 * Functions:
 *     void trap(void);
 * default exception handler
 ******************************************************************************/
    .align  2
    .global trap
    .type   trap, %function
trap:
    addi    sp, sp, -4
    sw      t0, 0x0(sp)
    csrr    t0, mcause

    blt     t0, x0, .Lirq # check MSB 1 or 0

    # go to exception
    addi    sp, sp, 4      # store sp from previous -4

    la      t0, g_trap_sp  # load address g_trap_sp
    addi    t0, t0, -68    # reserve 17*4 for x1-x15, mepc, mstatus
    sw      x1, 0(t0)
    sw      x2, 4(t0)
    sw      x3, 8(t0)
    sw      x4, 12(t0)
    sw      x6, 20(t0)
    sw      x7, 24(t0)
    sw      x8, 28(t0)
    sw      x9, 32(t0)
    sw      x10, 36(t0)
    sw      x11, 40(t0)
    sw      x12, 44(t0)
    sw      x13, 48(t0)
    sw      x14, 52(t0)
    sw      x15, 56(t0)
    csrr    a0, mepc
    sw      a0, 60(t0)
    csrr    a0, mstatus
    sw      a0, 64(t0)

    mv      a0, t0      # g_trap_sp-68 to a0
    lw      t0, -4(sp)  # load sp to t0
    mv      sp, a0      # sp = g_trap_sp-68
    sw      t0, 16(sp)  # load sp to t0 it just pass arg base address x1 to trap_c

    jal     trap_c       # jump to trap_c in drv_trap.c
.Lirq:
    lw      t0, 0x0(sp)
    addi    sp, sp, 4
    j       Default_IRQHandler

    .align  6
    .weak   Default_Handler
    .global Default_Handler
    .type   Default_Handler, %function
Default_Handler:
    j      trap
    .size   Default_Handler, . - Default_Handler


