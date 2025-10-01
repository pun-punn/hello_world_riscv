/*
 * Copyright (C) 2016 YunOS Project. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* Enable interrupts when returning from the handler */
#define MSTATUS_PRV1 0xc0000000

/******************************************************************************
 * Functions:
 *     size_t cpu_intrpt_save(void);
 *     void   cpu_intrpt_restore(size_t psr);
 ******************************************************************************/

.global cpu_intrpt_save
.type cpu_intrpt_save, %function
cpu_intrpt_save:
    csrr    a0, mstatus  # read a0 store in psr
    csrc    mstatus, 8   # clear mie bit 3
    ret

.global cpu_intrpt_restore
.type cpu_intrpt_restore, %function
cpu_intrpt_restore:
    csrw    mstatus, a0 # write psr = a0 to mstatus
    ret

/******************************************************************************
 * Functions:
 *     void cpu_intrpt_switch(void);
 *     void cpu_task_switch(void);
 ******************************************************************************/

.global cpu_task_switch
.type cpu_task_switch, %function
cpu_task_switch:
    la      a0, g_intrpt_nested_level
    lb      a0, (a0)
    beqz    a0, __task_switch

    la      a0, g_active_task
    la      a1, g_preferred_ready_task
    lw      a2, (a1)
    sw      a2, (a0)

.global cpu_intrpt_switch
.type cpu_intrpt_switch, %function
cpu_intrpt_switch:
    la      a0, g_active_task
    la      a1, g_preferred_ready_task
    lw      a2, (a1)                    #load  a1(g_preferred_ready_task) to a2
    sw      a2, (a0)                    #store a2g_preferred_ready_task)  to a0 (replace g_active_task)

/******************************************************************************
 * Functions:
 *     void cpu_first_task_start(void);
 ******************************************************************************/
.global cpu_first_task_start
.type cpu_first_task_start, %function
cpu_first_task_start:
    j       __task_switch_nosave

/******************************************************************************
 * Functions:
 *     void __task_switch(void);
 ******************************************************************************/

.type __task_switch, %function
__task_switch:
    addi    sp, sp, -60

    sw      x1, 0(sp)
    sw      x3, 4(sp)
    sw      x4, 8(sp)
    sw      x5, 12(sp)
    sw      x6, 16(sp)
    sw      x7, 20(sp)
    sw      x8, 24(sp)
    sw      x9, 28(sp)
    sw      x10, 32(sp)
    sw      x11, 36(sp)
    sw      x12, 40(sp)
    sw      x13, 44(sp)
    sw      x14, 48(sp)
    sw      x15, 52(sp)
    sw      ra,  56(sp)

    la      a1, g_active_task
    lw      a1, (a1)
    sw      sp, (a1)

__task_switch_nosave:
    la      a0, g_preferred_ready_task # load address g_preferred_ready_task
    la      a1, g_active_task          # load address g_active_task
    lw      a2, (a0)                   # a2 = value g_preferred_ready_task
    sw      a2, (a1)                   # store a1 = a2 = g_preferred_ready_task

    lw      sp, (a2)                   # sp = g_preferred_ready_task

    li      t0, MSTATUS_PRV1
    csrs    mstatus, t0

    lw      t0, 56(sp)
    csrw    mepc, t0

    lw      x1, 0(sp)
    lw      x3, 4(sp)
    lw      x4, 8(sp)
    lw      x5, 12(sp)
    lw      x6, 16(sp)
    lw      x7, 20(sp)
    lw      x8, 24(sp)
    lw      x9, 28(sp)
    lw      x10, 32(sp)
    lw      x11, 36(sp)
    lw      x12, 40(sp)
    lw      x13, 44(sp)
    lw      x14, 48(sp)
    lw      x15, 52(sp)

    addi    sp, sp, 60

    mret
/******************************************************************************
 * Functions:
 *     void Default_IRQHandler(void);
 * novic default irq entry
 ******************************************************************************/

.global Default_IRQHandler
.type   Default_IRQHandler, %function
Default_IRQHandler:
    /* reserved 15*4 bytes to save x1-x15 + mepc to stack if sp = 0x20001000 -> 0x20000FC4 */
    addi    sp, sp, -60

    sw      x1, 0(sp) # 0x20000FC8 - 0x20000FC4
    sw      x3, 4(sp)
    sw      x4, 8(sp)
    sw      x5, 12(sp)
    sw      x6, 16(sp)
    sw      x7, 20(sp)
    sw      x8, 24(sp)
    sw      x9, 28(sp)
    sw      x10, 32(sp)
    sw      x11, 36(sp)
    sw      x12, 40(sp)
    sw      x13, 44(sp)
    sw      x14, 48(sp)
    sw      x15, 52(sp)

    csrr    t0,  mepc
    sw      t0,  56(sp) # 0x20001000 - 0x20000FFC

    /* load sp address (0x20000FC4) to tbc-> g_active_task (save context) */
    la      a0, g_active_task
    lw      a0, (a0)
    sw      sp, (a0)

    /* load address g_top_irqstack to sp for isr to use stack */
    la      sp, g_top_irqstack

    /* read mcause to get offset */
    csrr    a0, mcause    # if mcause =  0x80000007 (core timer)
    andi    a0, a0, 0x3FF # mask 10 bits 0x80000007 & 0b1111111111 = 0x00000007
    slli    a0, a0, 2     # left shift 2 bits to 7*4 = 28 (address is 4 bytes)

    /* jump to handler according to g_irqvector */
    la      a1, g_irqvector  # base address g_irqvector
    add     a1, a1, a0       # isr address = base + (mcause & 0x3FF) << 2
    lw      a2, (a1)         # load jump address
    jalr    a2

    /* hook */
    la      a2, irq_hook
    jalr    a2
    /* restore sp address form tbc->g_active_task to sp (load context) */
    la      a0, g_active_task
    lw      a0, (a0)
    lw      sp, (a0)

    /* get idx to point to clic */
    csrr    a0, mcause
    andi    a0, a0, 0x3FF
    slli    a0, a0, 2

    /* clear pending */
    li      a2, 0xE0801000 # base address CLIC_INT->[ip,ie,attr,ctrl] see core_e902.h
    add     a2, a2, a0     # base + (mcause & 0x3FF) << 2
    lb      a3, 0(a2)      # load current pending value to a2
    li      a4, 1          # load 0x01 to a4
    not     a4, a4         # convert 0x01 to 0xFE = 0x11111110 to a4
    and     a5, a4, a3     # set bit 0 in pending value to 0 0x0000001 & 0x11111110 = 0
    sb      a5, 0(a2)      # store in 0 pending value to address

    /* Run in machine mode */
    li      t0, MSTATUS_PRV1
    csrs    mstatus, t0

    /* restore back x1-x15 mepc from stack to register */
    lw      t0, 56(sp)
    csrw    mepc, t0

    lw      x1, 0(sp)
    lw      x3, 4(sp)
    lw      x4, 8(sp)
    lw      x5, 12(sp)
    lw      x6, 16(sp)
    lw      x7, 20(sp)
    lw      x8, 24(sp)
    lw      x9, 28(sp)
    lw      x10, 32(sp)
    lw      x11, 36(sp)
    lw      x12, 40(sp)
    lw      x13, 44(sp)
    lw      x14, 48(sp)
    lw      x15, 52(sp)

    addi    sp, sp, 60

    /* return and switch to user mode */
    mret

