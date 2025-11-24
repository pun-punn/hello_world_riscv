
/home/pun/public_released/hello_world_e902/build/hello_world_rtos.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <Reset_Handler>:
    .globl  Reset_Handler
    .type   Reset_Handler, %function
Reset_Handler:
.option push
.option norelax
    la      gp, __global_pointer$
       0:	20000197          	auipc	gp,0x20000
       4:	1e018193          	addi	gp,gp,480 # 200001e0 <_impure_ptr>
.option pop
    la      a0, Default_Handler
       8:	00000517          	auipc	a0,0x0
       c:	0f850513          	addi	a0,a0,248 # 100 <Default_Handler>
    ori     a0, a0, 3
      10:	00356513          	ori	a0,a0,3
    csrw    mtvec, a0
      14:	30551073          	csrw	mtvec,a0

    la      a0, __Vectors
      18:	e2018513          	addi	a0,gp,-480 # 20000000 <__Vectors>
    csrw    mtvt, a0
      1c:	30751073          	csrw	mtvt,a0

    la      sp, g_top_irqstack
      20:	20001117          	auipc	sp,0x20001
      24:	20410113          	addi	sp,sp,516 # 20001224 <g_top_irqstack>

    /* Load data section */
    la      a0, __erodata
      28:	00005517          	auipc	a0,0x5
      2c:	22850513          	addi	a0,a0,552 # 5250 <__ctor_end__>
    la      a1, __data_start__
      30:	e2018593          	addi	a1,gp,-480 # 20000000 <__Vectors>
    la      a2, __data_end__
      34:	00418613          	addi	a2,gp,4 # 200001e4 <_impure_ptr+0x4>
    bgeu    a1, a2, 2f
      38:	00c5fa63          	bgeu	a1,a2,4c <Reset_Handler+0x4c>
1:
    lw      t0, (a0)
      3c:	00052283          	lw	t0,0(a0)
    sw      t0, (a1)
      40:	0055a023          	sw	t0,0(a1)
    addi    a0, a0, 4
      44:	0511                	addi	a0,a0,4
    addi    a1, a1, 4
      46:	0591                	addi	a1,a1,4
    bltu    a1, a2, 1b
      48:	fec5eae3          	bltu	a1,a2,3c <Reset_Handler+0x3c>
2:

    /* Clear bss section */
    la      a0, __bss_start__
      4c:	00818513          	addi	a0,gp,8 # 200001e8 <clk_handle>
    la      a1, __bss_end__
      50:	20002597          	auipc	a1,0x20002
      54:	f6058593          	addi	a1,a1,-160 # 20001fb0 <__bss_end__>
    bgeu    a0, a1, 2f
      58:	00b57763          	bgeu	a0,a1,66 <Reset_Handler+0x66>
1:
    sw      zero, (a0)
      5c:	00052023          	sw	zero,0(a0)
    addi    a0, a0, 4
      60:	0511                	addi	a0,a0,4
    bltu    a0, a1, 1b
      62:	feb56de3          	bltu	a0,a1,5c <Reset_Handler+0x5c>
2:

    jal     system_init
      66:	573020ef          	jal	ra,2dd8 <system_init>
    jal     board_init
      6a:	6e1020ef          	jal	ra,2f4a <board_init>
    jal     entry
      6e:	729020ef          	jal	ra,2f96 <entry>

00000072 <__exit>:

    .size   Reset_Handler, . - Reset_Handler

__exit:
    j      __exit
      72:	a001                	j	72 <__exit>
	...
    .align  2
    .global Default_IRQHandler
    .weak   Default_IRQHandler
    .type   Default_IRQHandler, %function
Default_IRQHandler:
    nop #weak function not do any thing need to be generic irq
      80:	0001                	nop
      82:	0001                	nop

00000084 <trap>:
 ******************************************************************************/
    .align  2
    .global trap
    .type   trap, %function
trap:
    addi    sp, sp, -4
      84:	1171                	addi	sp,sp,-4
    sw      t0, 0x0(sp)
      86:	c016                	sw	t0,0(sp)
    csrr    t0, mcause
      88:	342022f3          	csrr	t0,mcause

    blt     t0, x0, .Lirq # check MSB 1 or 0
      8c:	0602c463          	bltz	t0,f4 <trap+0x70>

    # go to exception
    addi    sp, sp, 4      # store sp from previous -4
      90:	0111                	addi	sp,sp,4

    la      t0, g_trap_sp  # load address g_trap_sp
      92:	20001297          	auipc	t0,0x20001
      96:	39228293          	addi	t0,t0,914 # 20001424 <g_trap_sp>
    addi    t0, t0, -68    # reserve 17*4 for x1-x15, mepc, mstatus
      9a:	fbc28293          	addi	t0,t0,-68
    sw      x1, 0(t0)
      9e:	0012a023          	sw	ra,0(t0)
    sw      x2, 4(t0)
      a2:	0022a223          	sw	sp,4(t0)
    sw      x3, 8(t0)
      a6:	0032a423          	sw	gp,8(t0)
    sw      x4, 12(t0)
      aa:	0042a623          	sw	tp,12(t0)
    sw      x6, 20(t0)
      ae:	0062aa23          	sw	t1,20(t0)
    sw      x7, 24(t0)
      b2:	0072ac23          	sw	t2,24(t0)
    sw      x8, 28(t0)
      b6:	0082ae23          	sw	s0,28(t0)
    sw      x9, 32(t0)
      ba:	0292a023          	sw	s1,32(t0)
    sw      x10, 36(t0)
      be:	02a2a223          	sw	a0,36(t0)
    sw      x11, 40(t0)
      c2:	02b2a423          	sw	a1,40(t0)
    sw      x12, 44(t0)
      c6:	02c2a623          	sw	a2,44(t0)
    sw      x13, 48(t0)
      ca:	02d2a823          	sw	a3,48(t0)
    sw      x14, 52(t0)
      ce:	02e2aa23          	sw	a4,52(t0)
    sw      x15, 56(t0)
      d2:	02f2ac23          	sw	a5,56(t0)
    csrr    a0, mepc
      d6:	34102573          	csrr	a0,mepc
    sw      a0, 60(t0)
      da:	02a2ae23          	sw	a0,60(t0)
    csrr    a0, mstatus
      de:	30002573          	csrr	a0,mstatus
    sw      a0, 64(t0)
      e2:	04a2a023          	sw	a0,64(t0)

    mv      a0, t0      # g_trap_sp-68 to a0
      e6:	8516                	mv	a0,t0
    lw      t0, -4(sp)  # load sp to t0
      e8:	ffc12283          	lw	t0,-4(sp)
    mv      sp, a0      # sp = g_trap_sp-68
      ec:	812a                	mv	sp,a0
    sw      t0, 16(sp)  # load sp to t0 it just pass arg base address x1 to trap_c
      ee:	c816                	sw	t0,16(sp)

    jal     trap_c       # jump to trap_c in drv_trap.c
      f0:	60b020ef          	jal	ra,2efa <trap_c>
.Lirq:
    lw      t0, 0x0(sp)
      f4:	4282                	lw	t0,0(sp)
    addi    sp, sp, 4
      f6:	0111                	addi	sp,sp,4
    j       Default_IRQHandler
      f8:	0ae0006f          	j	1a6 <Default_IRQHandler>
      fc:	00000013          	nop

00000100 <Default_Handler>:
    .align  6
    .weak   Default_Handler
    .global Default_Handler
    .type   Default_Handler, %function
Default_Handler:
    j      trap
     100:	b751                	j	84 <trap>
	...

00000104 <cpu_intrpt_save>:
 ******************************************************************************/

.global cpu_intrpt_save
.type cpu_intrpt_save, %function
cpu_intrpt_save:
    csrr    a0, mstatus  # read a0 store in psr
     104:	30002573          	csrr	a0,mstatus
    csrc    mstatus, 8   # clear mie bit 3
     108:	30047073          	csrci	mstatus,8
    ret
     10c:	8082                	ret

0000010e <cpu_intrpt_restore>:

.global cpu_intrpt_restore
.type cpu_intrpt_restore, %function
cpu_intrpt_restore:
    csrw    mstatus, a0 # write psr = a0 to mstatus
     10e:	30051073          	csrw	mstatus,a0
    ret
     112:	8082                	ret

00000114 <cpu_task_switch>:
 ******************************************************************************/

.global cpu_task_switch
.type cpu_task_switch, %function
cpu_task_switch:
    la      a0, g_intrpt_nested_level
     114:	02818513          	addi	a0,gp,40 # 20000208 <g_intrpt_nested_level>
    lb      a0, (a0)
     118:	00050503          	lb	a0,0(a0)
    beqz    a0, __task_switch
     11c:	cd11                	beqz	a0,138 <__task_switch>

    la      a0, g_active_task
     11e:	01c18513          	addi	a0,gp,28 # 200001fc <g_active_task>
    la      a1, g_preferred_ready_task
     122:	02c18593          	addi	a1,gp,44 # 2000020c <g_preferred_ready_task>
    lw      a2, (a1)
     126:	4190                	lw	a2,0(a1)
    sw      a2, (a0)
     128:	c110                	sw	a2,0(a0)

0000012a <cpu_intrpt_switch>:

.global cpu_intrpt_switch
.type cpu_intrpt_switch, %function
cpu_intrpt_switch:
    la      a0, g_active_task
     12a:	01c18513          	addi	a0,gp,28 # 200001fc <g_active_task>
    la      a1, g_preferred_ready_task
     12e:	02c18593          	addi	a1,gp,44 # 2000020c <g_preferred_ready_task>
    lw      a2, (a1)                    #load  a1(g_preferred_ready_task) to a2
     132:	4190                	lw	a2,0(a1)
    sw      a2, (a0)                    #store a2g_preferred_ready_task)  to a0 (replace g_active_task)
     134:	c110                	sw	a2,0(a0)

00000136 <cpu_first_task_start>:
 *     void cpu_first_task_start(void);
 ******************************************************************************/
.global cpu_first_task_start
.type cpu_first_task_start, %function
cpu_first_task_start:
    j       __task_switch_nosave
     136:	a03d                	j	164 <__task_switch_nosave>

00000138 <__task_switch>:
 *     void __task_switch(void);
 ******************************************************************************/

.type __task_switch, %function
__task_switch:
    addi    sp, sp, -60
     138:	fc410113          	addi	sp,sp,-60

    sw      x1, 0(sp)
     13c:	c006                	sw	ra,0(sp)
    sw      x3, 4(sp)
     13e:	c20e                	sw	gp,4(sp)
    sw      x4, 8(sp)
     140:	c412                	sw	tp,8(sp)
    sw      x5, 12(sp)
     142:	c616                	sw	t0,12(sp)
    sw      x6, 16(sp)
     144:	c81a                	sw	t1,16(sp)
    sw      x7, 20(sp)
     146:	ca1e                	sw	t2,20(sp)
    sw      x8, 24(sp)
     148:	cc22                	sw	s0,24(sp)
    sw      x9, 28(sp)
     14a:	ce26                	sw	s1,28(sp)
    sw      x10, 32(sp)
     14c:	d02a                	sw	a0,32(sp)
    sw      x11, 36(sp)
     14e:	d22e                	sw	a1,36(sp)
    sw      x12, 40(sp)
     150:	d432                	sw	a2,40(sp)
    sw      x13, 44(sp)
     152:	d636                	sw	a3,44(sp)
    sw      x14, 48(sp)
     154:	d83a                	sw	a4,48(sp)
    sw      x15, 52(sp)
     156:	da3e                	sw	a5,52(sp)
    sw      ra,  56(sp)
     158:	dc06                	sw	ra,56(sp)

    la      a1, g_active_task
     15a:	01c18593          	addi	a1,gp,28 # 200001fc <g_active_task>
    lw      a1, (a1)
     15e:	418c                	lw	a1,0(a1)
    sw      sp, (a1)
     160:	0025a023          	sw	sp,0(a1)

00000164 <__task_switch_nosave>:

__task_switch_nosave:
    la      a0, g_preferred_ready_task # load address g_preferred_ready_task
     164:	02c18513          	addi	a0,gp,44 # 2000020c <g_preferred_ready_task>
    la      a1, g_active_task          # load address g_active_task
     168:	01c18593          	addi	a1,gp,28 # 200001fc <g_active_task>
    lw      a2, (a0)                   # a2 = value g_preferred_ready_task
     16c:	4110                	lw	a2,0(a0)
    sw      a2, (a1)                   # store a1 = a2 = g_preferred_ready_task
     16e:	c190                	sw	a2,0(a1)

    lw      sp, (a2)                   # sp = g_preferred_ready_task
     170:	00062103          	lw	sp,0(a2)

    li      t0, MSTATUS_PRV1
     174:	c00002b7          	lui	t0,0xc0000
    csrs    mstatus, t0
     178:	3002a073          	csrs	mstatus,t0

    lw      t0, 56(sp)
     17c:	52e2                	lw	t0,56(sp)
    csrw    mepc, t0
     17e:	34129073          	csrw	mepc,t0

    lw      x1, 0(sp)
     182:	4082                	lw	ra,0(sp)
    lw      x3, 4(sp)
     184:	4192                	lw	gp,4(sp)
    lw      x4, 8(sp)
     186:	4222                	lw	tp,8(sp)
    lw      x5, 12(sp)
     188:	42b2                	lw	t0,12(sp)
    lw      x6, 16(sp)
     18a:	4342                	lw	t1,16(sp)
    lw      x7, 20(sp)
     18c:	43d2                	lw	t2,20(sp)
    lw      x8, 24(sp)
     18e:	4462                	lw	s0,24(sp)
    lw      x9, 28(sp)
     190:	44f2                	lw	s1,28(sp)
    lw      x10, 32(sp)
     192:	5502                	lw	a0,32(sp)
    lw      x11, 36(sp)
     194:	5592                	lw	a1,36(sp)
    lw      x12, 40(sp)
     196:	5622                	lw	a2,40(sp)
    lw      x13, 44(sp)
     198:	56b2                	lw	a3,44(sp)
    lw      x14, 48(sp)
     19a:	5742                	lw	a4,48(sp)
    lw      x15, 52(sp)
     19c:	57d2                	lw	a5,52(sp)

    addi    sp, sp, 60
     19e:	03c10113          	addi	sp,sp,60

    mret
     1a2:	30200073          	mret

000001a6 <Default_IRQHandler>:

.global Default_IRQHandler
.type   Default_IRQHandler, %function
Default_IRQHandler:
    /* reserved 15*4 bytes to save x1-x15 + mepc to stack if sp = 0x20001000 -> 0x20000FC4 */
    addi    sp, sp, -60
     1a6:	fc410113          	addi	sp,sp,-60

    sw      x1, 0(sp) # 0x20000FC8 - 0x20000FC4
     1aa:	c006                	sw	ra,0(sp)
    sw      x3, 4(sp)
     1ac:	c20e                	sw	gp,4(sp)
    sw      x4, 8(sp)
     1ae:	c412                	sw	tp,8(sp)
    sw      x5, 12(sp)
     1b0:	c616                	sw	t0,12(sp)
    sw      x6, 16(sp)
     1b2:	c81a                	sw	t1,16(sp)
    sw      x7, 20(sp)
     1b4:	ca1e                	sw	t2,20(sp)
    sw      x8, 24(sp)
     1b6:	cc22                	sw	s0,24(sp)
    sw      x9, 28(sp)
     1b8:	ce26                	sw	s1,28(sp)
    sw      x10, 32(sp)
     1ba:	d02a                	sw	a0,32(sp)
    sw      x11, 36(sp)
     1bc:	d22e                	sw	a1,36(sp)
    sw      x12, 40(sp)
     1be:	d432                	sw	a2,40(sp)
    sw      x13, 44(sp)
     1c0:	d636                	sw	a3,44(sp)
    sw      x14, 48(sp)
     1c2:	d83a                	sw	a4,48(sp)
    sw      x15, 52(sp)
     1c4:	da3e                	sw	a5,52(sp)

    csrr    t0,  mepc
     1c6:	341022f3          	csrr	t0,mepc
    sw      t0,  56(sp) # 0x20001000 - 0x20000FFC
     1ca:	dc16                	sw	t0,56(sp)

    /* load sp address (0x20000FC4) to tbc-> g_active_task (save context) */
    la      a0, g_active_task
     1cc:	01c18513          	addi	a0,gp,28 # 200001fc <g_active_task>
    lw      a0, (a0)
     1d0:	4108                	lw	a0,0(a0)
    sw      sp, (a0)
     1d2:	00252023          	sw	sp,0(a0)

    /* load address g_top_irqstack to sp for isr to use stack */
    la      sp, g_top_irqstack
     1d6:	20001117          	auipc	sp,0x20001
     1da:	04e10113          	addi	sp,sp,78 # 20001224 <g_top_irqstack>

    /* read mcause to get offset */
    csrr    a0, mcause    # if mcause =  0x80000007 (core timer)
     1de:	34202573          	csrr	a0,mcause
    andi    a0, a0, 0x3FF # mask 10 bits 0x80000007 & 0b1111111111 = 0x00000007
     1e2:	3ff57513          	andi	a0,a0,1023
    slli    a0, a0, 2     # left shift 2 bits to 7*4 = 28 (address is 4 bytes)
     1e6:	050a                	slli	a0,a0,0x2

    /* jump to handler according to g_irqvector */
    la      a1, g_irqvector  # base address g_irqvector
     1e8:	20001597          	auipc	a1,0x20001
     1ec:	3f458593          	addi	a1,a1,1012 # 200015dc <g_irqvector>
    add     a1, a1, a0       # isr address = base + (mcause & 0x3FF) << 2
     1f0:	95aa                	add	a1,a1,a0
    lw      a2, (a1)         # load jump address
     1f2:	4190                	lw	a2,0(a1)
    jalr    a2
     1f4:	9602                	jalr	a2

    /* hook */
    la      a2, irq_hook
     1f6:	00003617          	auipc	a2,0x3
     1fa:	eba60613          	addi	a2,a2,-326 # 30b0 <irq_hook>
    jalr    a2
     1fe:	9602                	jalr	a2
    /* restore sp address form tbc->g_active_task to sp (load context) */
    la      a0, g_active_task
     200:	01c18513          	addi	a0,gp,28 # 200001fc <g_active_task>
    lw      a0, (a0)
     204:	4108                	lw	a0,0(a0)
    lw      sp, (a0)
     206:	00052103          	lw	sp,0(a0)

    /* get idx to point to clic */
    csrr    a0, mcause
     20a:	34202573          	csrr	a0,mcause
    andi    a0, a0, 0x3FF
     20e:	3ff57513          	andi	a0,a0,1023
    slli    a0, a0, 2
     212:	050a                	slli	a0,a0,0x2

    /* clear pending */
    li      a2, 0xE0801000 # base address CLIC_INT->[ip,ie,attr,ctrl] see core_e902.h
     214:	e0801637          	lui	a2,0xe0801
    add     a2, a2, a0     # base + (mcause & 0x3FF) << 2
     218:	962a                	add	a2,a2,a0
    lb      a3, 0(a2)      # load current pending value to a2
     21a:	00060683          	lb	a3,0(a2) # e0801000 <__bss_end__+0xc07ff050>
    li      a4, 1          # load 0x01 to a4
     21e:	4705                	li	a4,1
    not     a4, a4         # convert 0x01 to 0xFE = 0x11111110 to a4
     220:	fff74713          	not	a4,a4
    and     a5, a4, a3     # set bit 0 in pending value to 0 0x0000001 & 0x11111110 = 0
     224:	00d777b3          	and	a5,a4,a3
    sb      a5, 0(a2)      # store in 0 pending value to address
     228:	00f60023          	sb	a5,0(a2)

    /* Run in machine mode */
    li      t0, MSTATUS_PRV1
     22c:	c00002b7          	lui	t0,0xc0000
    csrs    mstatus, t0
     230:	3002a073          	csrs	mstatus,t0

    /* restore back x1-x15 mepc from stack to register */
    lw      t0, 56(sp)
     234:	52e2                	lw	t0,56(sp)
    csrw    mepc, t0
     236:	34129073          	csrw	mepc,t0

    lw      x1, 0(sp)
     23a:	4082                	lw	ra,0(sp)
    lw      x3, 4(sp)
     23c:	4192                	lw	gp,4(sp)
    lw      x4, 8(sp)
     23e:	4222                	lw	tp,8(sp)
    lw      x5, 12(sp)
     240:	42b2                	lw	t0,12(sp)
    lw      x6, 16(sp)
     242:	4342                	lw	t1,16(sp)
    lw      x7, 20(sp)
     244:	43d2                	lw	t2,20(sp)
    lw      x8, 24(sp)
     246:	4462                	lw	s0,24(sp)
    lw      x9, 28(sp)
     248:	44f2                	lw	s1,28(sp)
    lw      x10, 32(sp)
     24a:	5502                	lw	a0,32(sp)
    lw      x11, 36(sp)
     24c:	5592                	lw	a1,36(sp)
    lw      x12, 40(sp)
     24e:	5622                	lw	a2,40(sp)
    lw      x13, 44(sp)
     250:	56b2                	lw	a3,44(sp)
    lw      x14, 48(sp)
     252:	5742                	lw	a4,48(sp)
    lw      x15, 52(sp)
     254:	57d2                	lw	a5,52(sp)

    addi    sp, sp, 60
     256:	03c10113          	addi	sp,sp,60

    /* return and switch to user mode */
    mret
     25a:	30200073          	mret

0000025e <_strtol_l.part.0>:
     25e:	1111                	addi	sp,sp,-28
     260:	c82a                	sw	a0,16(sp)
     262:	6511                	lui	a0,0x4
     264:	cc22                	sw	s0,24(sp)
     266:	ca26                	sw	s1,20(sp)
     268:	872e                	mv	a4,a1
     26a:	c42e                	sw	a1,8(sp)
     26c:	c032                	sw	a2,0(sp)
     26e:	47150513          	addi	a0,a0,1137 # 4471 <_ctype_+0x1>
     272:	00074783          	lbu	a5,0(a4)
     276:	85ba                	mv	a1,a4
     278:	0705                	addi	a4,a4,1
     27a:	00f50633          	add	a2,a0,a5
     27e:	00064603          	lbu	a2,0(a2)
     282:	8a21                	andi	a2,a2,8
     284:	f67d                	bnez	a2,272 <_strtol_l.part.0+0x14>
     286:	02d00613          	li	a2,45
     28a:	0cc78f63          	beq	a5,a2,368 <_strtol_l.part.0+0x10a>
     28e:	02b00613          	li	a2,43
     292:	06c78063          	beq	a5,a2,2f2 <_strtol_l.part.0+0x94>
     296:	800004b7          	lui	s1,0x80000
     29a:	fff4c493          	not	s1,s1
     29e:	c602                	sw	zero,12(sp)
     2a0:	c2bd                	beqz	a3,306 <_strtol_l.part.0+0xa8>
     2a2:	4641                	li	a2,16
     2a4:	8436                	mv	s0,a3
     2a6:	0cc68a63          	beq	a3,a2,37a <_strtol_l.part.0+0x11c>
     2aa:	0284f633          	remu	a2,s1,s0
     2ae:	4581                	li	a1,0
     2b0:	4501                	li	a0,0
     2b2:	4325                	li	t1,9
     2b4:	43e5                	li	t2,25
     2b6:	0284d2b3          	divu	t0,s1,s0
     2ba:	c232                	sw	a2,4(sp)
     2bc:	fd078613          	addi	a2,a5,-48
     2c0:	00c37863          	bgeu	t1,a2,2d0 <_strtol_l.part.0+0x72>
     2c4:	fbf78613          	addi	a2,a5,-65
     2c8:	04c3e863          	bltu	t2,a2,318 <_strtol_l.part.0+0xba>
     2cc:	fc978613          	addi	a2,a5,-55
     2d0:	04d65c63          	bge	a2,a3,328 <_strtol_l.part.0+0xca>
     2d4:	0405c063          	bltz	a1,314 <_strtol_l.part.0+0xb6>
     2d8:	55fd                	li	a1,-1
     2da:	00a2e863          	bltu	t0,a0,2ea <_strtol_l.part.0+0x8c>
     2de:	06a28563          	beq	t0,a0,348 <_strtol_l.part.0+0xea>
     2e2:	4585                	li	a1,1
     2e4:	02850533          	mul	a0,a0,s0
     2e8:	9532                	add	a0,a0,a2
     2ea:	0705                	addi	a4,a4,1
     2ec:	fff74783          	lbu	a5,-1(a4)
     2f0:	b7f1                	j	2bc <_strtol_l.part.0+0x5e>
     2f2:	800004b7          	lui	s1,0x80000
     2f6:	c602                	sw	zero,12(sp)
     2f8:	00074783          	lbu	a5,0(a4)
     2fc:	fff4c493          	not	s1,s1
     300:	00258713          	addi	a4,a1,2
     304:	fed9                	bnez	a3,2a2 <_strtol_l.part.0+0x44>
     306:	03000693          	li	a3,48
     30a:	08d78c63          	beq	a5,a3,3a2 <_strtol_l.part.0+0x144>
     30e:	4429                	li	s0,10
     310:	46a9                	li	a3,10
     312:	bf61                	j	2aa <_strtol_l.part.0+0x4c>
     314:	55fd                	li	a1,-1
     316:	bfd1                	j	2ea <_strtol_l.part.0+0x8c>
     318:	f9f78613          	addi	a2,a5,-97
     31c:	00c3e663          	bltu	t2,a2,328 <_strtol_l.part.0+0xca>
     320:	fa978613          	addi	a2,a5,-87
     324:	fad648e3          	blt	a2,a3,2d4 <_strtol_l.part.0+0x76>
     328:	0205c463          	bltz	a1,350 <_strtol_l.part.0+0xf2>
     32c:	47b2                	lw	a5,12(sp)
     32e:	c399                	beqz	a5,334 <_strtol_l.part.0+0xd6>
     330:	40a00533          	neg	a0,a0
     334:	4782                	lw	a5,0(sp)
     336:	c789                	beqz	a5,340 <_strtol_l.part.0+0xe2>
     338:	e1c1                	bnez	a1,3b8 <_strtol_l.part.0+0x15a>
     33a:	4782                	lw	a5,0(sp)
     33c:	4722                	lw	a4,8(sp)
     33e:	c398                	sw	a4,0(a5)
     340:	4462                	lw	s0,24(sp)
     342:	44d2                	lw	s1,20(sp)
     344:	0171                	addi	sp,sp,28
     346:	8082                	ret
     348:	4792                	lw	a5,4(sp)
     34a:	fac7c0e3          	blt	a5,a2,2ea <_strtol_l.part.0+0x8c>
     34e:	bf51                	j	2e2 <_strtol_l.part.0+0x84>
     350:	46c2                	lw	a3,16(sp)
     352:	02200793          	li	a5,34
     356:	8526                	mv	a0,s1
     358:	c29c                	sw	a5,0(a3)
     35a:	4782                	lw	a5,0(sp)
     35c:	d3f5                	beqz	a5,340 <_strtol_l.part.0+0xe2>
     35e:	fff70793          	addi	a5,a4,-1
     362:	c43e                	sw	a5,8(sp)
     364:	8526                	mv	a0,s1
     366:	bfd1                	j	33a <_strtol_l.part.0+0xdc>
     368:	4605                	li	a2,1
     36a:	00074783          	lbu	a5,0(a4)
     36e:	800004b7          	lui	s1,0x80000
     372:	00258713          	addi	a4,a1,2
     376:	c632                	sw	a2,12(sp)
     378:	b725                	j	2a0 <_strtol_l.part.0+0x42>
     37a:	03000613          	li	a2,48
     37e:	00c79a63          	bne	a5,a2,392 <_strtol_l.part.0+0x134>
     382:	00074603          	lbu	a2,0(a4)
     386:	05800593          	li	a1,88
     38a:	0df67613          	andi	a2,a2,223
     38e:	00b60463          	beq	a2,a1,396 <_strtol_l.part.0+0x138>
     392:	4441                	li	s0,16
     394:	bf19                	j	2aa <_strtol_l.part.0+0x4c>
     396:	00174783          	lbu	a5,1(a4)
     39a:	4441                	li	s0,16
     39c:	0709                	addi	a4,a4,2
     39e:	46c1                	li	a3,16
     3a0:	b729                	j	2aa <_strtol_l.part.0+0x4c>
     3a2:	00074683          	lbu	a3,0(a4)
     3a6:	05800613          	li	a2,88
     3aa:	0df6f693          	andi	a3,a3,223
     3ae:	fec684e3          	beq	a3,a2,396 <_strtol_l.part.0+0x138>
     3b2:	4421                	li	s0,8
     3b4:	46a1                	li	a3,8
     3b6:	bdd5                	j	2aa <_strtol_l.part.0+0x4c>
     3b8:	84aa                	mv	s1,a0
     3ba:	b755                	j	35e <_strtol_l.part.0+0x100>

000003bc <_strtol_r>:
     3bc:	4705                	li	a4,1
     3be:	00e68763          	beq	a3,a4,3cc <_strtol_r+0x10>
     3c2:	02400713          	li	a4,36
     3c6:	00d76363          	bltu	a4,a3,3cc <_strtol_r+0x10>
     3ca:	bd51                	j	25e <_strtol_l.part.0>
     3cc:	1151                	addi	sp,sp,-12
     3ce:	c406                	sw	ra,8(sp)
     3d0:	2bc1                	jal	9a0 <__errno>
     3d2:	40a2                	lw	ra,8(sp)
     3d4:	47d9                	li	a5,22
     3d6:	c11c                	sw	a5,0(a0)
     3d8:	4501                	li	a0,0
     3da:	0131                	addi	sp,sp,12
     3dc:	8082                	ret

000003de <strtol_l>:
     3de:	4705                	li	a4,1
     3e0:	00e60d63          	beq	a2,a4,3fa <strtol_l+0x1c>
     3e4:	02400713          	li	a4,36
     3e8:	00c76963          	bltu	a4,a2,3fa <strtol_l+0x1c>
     3ec:	87aa                	mv	a5,a0
     3ee:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     3f2:	86b2                	mv	a3,a2
     3f4:	862e                	mv	a2,a1
     3f6:	85be                	mv	a1,a5
     3f8:	b59d                	j	25e <_strtol_l.part.0>
     3fa:	1151                	addi	sp,sp,-12
     3fc:	c406                	sw	ra,8(sp)
     3fe:	234d                	jal	9a0 <__errno>
     400:	40a2                	lw	ra,8(sp)
     402:	47d9                	li	a5,22
     404:	c11c                	sw	a5,0(a0)
     406:	4501                	li	a0,0
     408:	0131                	addi	sp,sp,12
     40a:	8082                	ret

0000040c <strtol>:
     40c:	4705                	li	a4,1
     40e:	00e60d63          	beq	a2,a4,428 <strtol+0x1c>
     412:	02400713          	li	a4,36
     416:	00c76963          	bltu	a4,a2,428 <strtol+0x1c>
     41a:	87aa                	mv	a5,a0
     41c:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     420:	86b2                	mv	a3,a2
     422:	862e                	mv	a2,a1
     424:	85be                	mv	a1,a5
     426:	bd25                	j	25e <_strtol_l.part.0>
     428:	1151                	addi	sp,sp,-12
     42a:	c406                	sw	ra,8(sp)
     42c:	2b95                	jal	9a0 <__errno>
     42e:	40a2                	lw	ra,8(sp)
     430:	47d9                	li	a5,22
     432:	c11c                	sw	a5,0(a0)
     434:	4501                	li	a0,0
     436:	0131                	addi	sp,sp,12
     438:	8082                	ret

0000043a <_strtoul_l.constprop.0>:
     43a:	1121                	addi	sp,sp,-24
     43c:	6311                	lui	t1,0x4
     43e:	ca22                	sw	s0,20(sp)
     440:	c826                	sw	s1,16(sp)
     442:	c62a                	sw	a0,12(sp)
     444:	c032                	sw	a2,0(sp)
     446:	872e                	mv	a4,a1
     448:	47130313          	addi	t1,t1,1137 # 4471 <_ctype_+0x1>
     44c:	00074783          	lbu	a5,0(a4)
     450:	853a                	mv	a0,a4
     452:	0705                	addi	a4,a4,1
     454:	00f30633          	add	a2,t1,a5
     458:	00064603          	lbu	a2,0(a2)
     45c:	8a21                	andi	a2,a2,8
     45e:	f67d                	bnez	a2,44c <_strtoul_l.constprop.0+0x12>
     460:	02d00613          	li	a2,45
     464:	0cc78b63          	beq	a5,a2,53a <_strtoul_l.constprop.0+0x100>
     468:	02b00613          	li	a2,43
     46c:	c402                	sw	zero,8(sp)
     46e:	06c78963          	beq	a5,a2,4e0 <_strtoul_l.constprop.0+0xa6>
     472:	ce81                	beqz	a3,48a <_strtoul_l.constprop.0+0x50>
     474:	4641                	li	a2,16
     476:	0cc68963          	beq	a3,a2,548 <_strtoul_l.constprop.0+0x10e>
     47a:	567d                	li	a2,-1
     47c:	02d653b3          	divu	t2,a2,a3
     480:	84b6                	mv	s1,a3
     482:	02d67633          	remu	a2,a2,a3
     486:	c232                	sw	a2,4(sp)
     488:	a829                	j	4a2 <_strtoul_l.constprop.0+0x68>
     48a:	03000693          	li	a3,48
     48e:	0ed78463          	beq	a5,a3,576 <_strtoul_l.constprop.0+0x13c>
     492:	4695                	li	a3,5
     494:	1999a3b7          	lui	t2,0x1999a
     498:	c236                	sw	a3,4(sp)
     49a:	99938393          	addi	t2,t2,-1639 # 19999999 <__ctor_end__+0x19994749>
     49e:	44a9                	li	s1,10
     4a0:	46a9                	li	a3,10
     4a2:	4301                	li	t1,0
     4a4:	4501                	li	a0,0
     4a6:	42a5                	li	t0,9
     4a8:	4465                	li	s0,25
     4aa:	fd078613          	addi	a2,a5,-48
     4ae:	00c2f863          	bgeu	t0,a2,4be <_strtoul_l.constprop.0+0x84>
     4b2:	fbf78613          	addi	a2,a5,-65
     4b6:	02c46c63          	bltu	s0,a2,4ee <_strtoul_l.constprop.0+0xb4>
     4ba:	fc978613          	addi	a2,a5,-55
     4be:	04d65063          	bge	a2,a3,4fe <_strtoul_l.constprop.0+0xc4>
     4c2:	02034463          	bltz	t1,4ea <_strtoul_l.constprop.0+0xb0>
     4c6:	537d                	li	t1,-1
     4c8:	00a3e863          	bltu	t2,a0,4d8 <_strtoul_l.constprop.0+0x9e>
     4cc:	04750963          	beq	a0,t2,51e <_strtoul_l.constprop.0+0xe4>
     4d0:	02950533          	mul	a0,a0,s1
     4d4:	4305                	li	t1,1
     4d6:	9532                	add	a0,a0,a2
     4d8:	0705                	addi	a4,a4,1
     4da:	fff74783          	lbu	a5,-1(a4)
     4de:	b7f1                	j	4aa <_strtoul_l.constprop.0+0x70>
     4e0:	00074783          	lbu	a5,0(a4)
     4e4:	00250713          	addi	a4,a0,2
     4e8:	b769                	j	472 <_strtoul_l.constprop.0+0x38>
     4ea:	537d                	li	t1,-1
     4ec:	b7f5                	j	4d8 <_strtoul_l.constprop.0+0x9e>
     4ee:	f9f78613          	addi	a2,a5,-97
     4f2:	00c46663          	bltu	s0,a2,4fe <_strtoul_l.constprop.0+0xc4>
     4f6:	fa978613          	addi	a2,a5,-87
     4fa:	fcd644e3          	blt	a2,a3,4c2 <_strtoul_l.constprop.0+0x88>
     4fe:	02034463          	bltz	t1,526 <_strtoul_l.constprop.0+0xec>
     502:	47a2                	lw	a5,8(sp)
     504:	c399                	beqz	a5,50a <_strtoul_l.constprop.0+0xd0>
     506:	40a00533          	neg	a0,a0
     50a:	4782                	lw	a5,0(sp)
     50c:	c789                	beqz	a5,516 <_strtoul_l.constprop.0+0xdc>
     50e:	02031363          	bnez	t1,534 <_strtoul_l.constprop.0+0xfa>
     512:	4782                	lw	a5,0(sp)
     514:	c38c                	sw	a1,0(a5)
     516:	4452                	lw	s0,20(sp)
     518:	44c2                	lw	s1,16(sp)
     51a:	0161                	addi	sp,sp,24
     51c:	8082                	ret
     51e:	4792                	lw	a5,4(sp)
     520:	fac7cce3          	blt	a5,a2,4d8 <_strtoul_l.constprop.0+0x9e>
     524:	b775                	j	4d0 <_strtoul_l.constprop.0+0x96>
     526:	46b2                	lw	a3,12(sp)
     528:	02200793          	li	a5,34
     52c:	557d                	li	a0,-1
     52e:	c29c                	sw	a5,0(a3)
     530:	4782                	lw	a5,0(sp)
     532:	d3f5                	beqz	a5,516 <_strtoul_l.constprop.0+0xdc>
     534:	fff70593          	addi	a1,a4,-1
     538:	bfe9                	j	512 <_strtoul_l.constprop.0+0xd8>
     53a:	00074783          	lbu	a5,0(a4)
     53e:	4705                	li	a4,1
     540:	c43a                	sw	a4,8(sp)
     542:	00250713          	addi	a4,a0,2
     546:	b735                	j	472 <_strtoul_l.constprop.0+0x38>
     548:	03000613          	li	a2,48
     54c:	04c79c63          	bne	a5,a2,5a4 <_strtoul_l.constprop.0+0x16a>
     550:	00074603          	lbu	a2,0(a4)
     554:	05800513          	li	a0,88
     558:	0df67613          	andi	a2,a2,223
     55c:	02a61d63          	bne	a2,a0,596 <_strtoul_l.constprop.0+0x15c>
     560:	46bd                	li	a3,15
     562:	100003b7          	lui	t2,0x10000
     566:	00174783          	lbu	a5,1(a4)
     56a:	c236                	sw	a3,4(sp)
     56c:	0709                	addi	a4,a4,2
     56e:	13fd                	addi	t2,t2,-1
     570:	44c1                	li	s1,16
     572:	46c1                	li	a3,16
     574:	b73d                	j	4a2 <_strtoul_l.constprop.0+0x68>
     576:	00074683          	lbu	a3,0(a4)
     57a:	05800613          	li	a2,88
     57e:	0df6f693          	andi	a3,a3,223
     582:	fcc68fe3          	beq	a3,a2,560 <_strtoul_l.constprop.0+0x126>
     586:	469d                	li	a3,7
     588:	200003b7          	lui	t2,0x20000
     58c:	c236                	sw	a3,4(sp)
     58e:	13fd                	addi	t2,t2,-1
     590:	44a1                	li	s1,8
     592:	46a1                	li	a3,8
     594:	b739                	j	4a2 <_strtoul_l.constprop.0+0x68>
     596:	53fd                	li	t2,-1
     598:	463d                	li	a2,15
     59a:	02d3d3b3          	divu	t2,t2,a3
     59e:	44c1                	li	s1,16
     5a0:	c232                	sw	a2,4(sp)
     5a2:	b701                	j	4a2 <_strtoul_l.constprop.0+0x68>
     5a4:	463d                	li	a2,15
     5a6:	100003b7          	lui	t2,0x10000
     5aa:	c232                	sw	a2,4(sp)
     5ac:	13fd                	addi	t2,t2,-1
     5ae:	44c1                	li	s1,16
     5b0:	bdcd                	j	4a2 <_strtoul_l.constprop.0+0x68>

000005b2 <_strtoul_r>:
     5b2:	b561                	j	43a <_strtoul_l.constprop.0>

000005b4 <strtoul_l>:
     5b4:	87aa                	mv	a5,a0
     5b6:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     5ba:	86b2                	mv	a3,a2
     5bc:	862e                	mv	a2,a1
     5be:	85be                	mv	a1,a5
     5c0:	bdad                	j	43a <_strtoul_l.constprop.0>

000005c2 <strtoul>:
     5c2:	87aa                	mv	a5,a0
     5c4:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     5c8:	86b2                	mv	a3,a2
     5ca:	862e                	mv	a2,a1
     5cc:	85be                	mv	a1,a5
     5ce:	b5b5                	j	43a <_strtoul_l.constprop.0>

000005d0 <strchr>:
     5d0:	0ff5f693          	zext.b	a3,a1
     5d4:	00357793          	andi	a5,a0,3
     5d8:	cec1                	beqz	a3,670 <strchr+0xa0>
     5da:	cb91                	beqz	a5,5ee <strchr+0x1e>
     5dc:	00054783          	lbu	a5,0(a0)
     5e0:	c7d1                	beqz	a5,66c <strchr+0x9c>
     5e2:	08d78663          	beq	a5,a3,66e <strchr+0x9e>
     5e6:	0505                	addi	a0,a0,1
     5e8:	00357793          	andi	a5,a0,3
     5ec:	fbe5                	bnez	a5,5dc <strchr+0xc>
     5ee:	0ff5f593          	zext.b	a1,a1
     5f2:	00859313          	slli	t1,a1,0x8
     5f6:	4118                	lw	a4,0(a0)
     5f8:	0065e5b3          	or	a1,a1,t1
     5fc:	01059313          	slli	t1,a1,0x10
     600:	00b36333          	or	t1,t1,a1
     604:	feff0637          	lui	a2,0xfeff0
     608:	00e345b3          	xor	a1,t1,a4
     60c:	eff60613          	addi	a2,a2,-257 # fefefeff <__bss_end__+0xdefedf4f>
     610:	00c587b3          	add	a5,a1,a2
     614:	00c702b3          	add	t0,a4,a2
     618:	fff5c593          	not	a1,a1
     61c:	fff74713          	not	a4,a4
     620:	8fed                	and	a5,a5,a1
     622:	00e2f733          	and	a4,t0,a4
     626:	808085b7          	lui	a1,0x80808
     62a:	8fd9                	or	a5,a5,a4
     62c:	08058593          	addi	a1,a1,128 # 80808080 <__bss_end__+0x608060d0>
     630:	8fed                	and	a5,a5,a1
     632:	e785                	bnez	a5,65a <strchr+0x8a>
     634:	4158                	lw	a4,4(a0)
     636:	0511                	addi	a0,a0,4
     638:	006742b3          	xor	t0,a4,t1
     63c:	00c707b3          	add	a5,a4,a2
     640:	00c283b3          	add	t2,t0,a2
     644:	fff74713          	not	a4,a4
     648:	fff2c293          	not	t0,t0
     64c:	8ff9                	and	a5,a5,a4
     64e:	0053f2b3          	and	t0,t2,t0
     652:	0057e7b3          	or	a5,a5,t0
     656:	8fed                	and	a5,a5,a1
     658:	dff1                	beqz	a5,634 <strchr+0x64>
     65a:	00054783          	lbu	a5,0(a0)
     65e:	c799                	beqz	a5,66c <strchr+0x9c>
     660:	06f68163          	beq	a3,a5,6c2 <strchr+0xf2>
     664:	00154783          	lbu	a5,1(a0)
     668:	0505                	addi	a0,a0,1
     66a:	fbfd                	bnez	a5,660 <strchr+0x90>
     66c:	4501                	li	a0,0
     66e:	8082                	ret
     670:	cb81                	beqz	a5,680 <strchr+0xb0>
     672:	00054783          	lbu	a5,0(a0)
     676:	dfe5                	beqz	a5,66e <strchr+0x9e>
     678:	0505                	addi	a0,a0,1
     67a:	00357793          	andi	a5,a0,3
     67e:	fbf5                	bnez	a5,672 <strchr+0xa2>
     680:	4118                	lw	a4,0(a0)
     682:	feff0637          	lui	a2,0xfeff0
     686:	eff60613          	addi	a2,a2,-257 # fefefeff <__bss_end__+0xdefedf4f>
     68a:	00c707b3          	add	a5,a4,a2
     68e:	808086b7          	lui	a3,0x80808
     692:	fff74713          	not	a4,a4
     696:	8ff9                	and	a5,a5,a4
     698:	08068693          	addi	a3,a3,128 # 80808080 <__bss_end__+0x608060d0>
     69c:	8ff5                	and	a5,a5,a3
     69e:	eb91                	bnez	a5,6b2 <strchr+0xe2>
     6a0:	4158                	lw	a4,4(a0)
     6a2:	0511                	addi	a0,a0,4
     6a4:	00c707b3          	add	a5,a4,a2
     6a8:	fff74713          	not	a4,a4
     6ac:	8ff9                	and	a5,a5,a4
     6ae:	8ff5                	and	a5,a5,a3
     6b0:	dbe5                	beqz	a5,6a0 <strchr+0xd0>
     6b2:	00054783          	lbu	a5,0(a0)
     6b6:	dfc5                	beqz	a5,66e <strchr+0x9e>
     6b8:	00154783          	lbu	a5,1(a0)
     6bc:	0505                	addi	a0,a0,1
     6be:	ffed                	bnez	a5,6b8 <strchr+0xe8>
     6c0:	8082                	ret
     6c2:	8082                	ret

000006c4 <_strerror_r>:
     6c4:	87ae                	mv	a5,a1
     6c6:	08e00713          	li	a4,142
     6ca:	85b2                	mv	a1,a2
     6cc:	00f76a63          	bltu	a4,a5,6e0 <_strerror_r+0x1c>
     6d0:	6311                	lui	t1,0x4
     6d2:	00279713          	slli	a4,a5,0x2
     6d6:	57430313          	addi	t1,t1,1396 # 4574 <_ctype_+0x104>
     6da:	971a                	add	a4,a4,t1
     6dc:	4318                	lw	a4,0(a4)
     6de:	8702                	jr	a4
     6e0:	1151                	addi	sp,sp,-12
     6e2:	c406                	sw	ra,8(sp)
     6e4:	28068e63          	beqz	a3,980 <_strerror_r+0x2bc>
     6e8:	8636                	mv	a2,a3
     6ea:	853e                	mv	a0,a5
     6ec:	2c45                	jal	99c <_user_strerror>
     6ee:	28050563          	beqz	a0,978 <_strerror_r+0x2b4>
     6f2:	40a2                	lw	ra,8(sp)
     6f4:	0131                	addi	sp,sp,12
     6f6:	8082                	ret
     6f8:	6515                	lui	a0,0x5
     6fa:	18450513          	addi	a0,a0,388 # 5184 <pad_line+0x68c>
     6fe:	8082                	ret
     700:	6515                	lui	a0,0x5
     702:	16c50513          	addi	a0,a0,364 # 516c <pad_line+0x674>
     706:	8082                	ret
     708:	6515                	lui	a0,0x5
     70a:	12450513          	addi	a0,a0,292 # 5124 <pad_line+0x62c>
     70e:	8082                	ret
     710:	6515                	lui	a0,0x5
     712:	13c50513          	addi	a0,a0,316 # 513c <pad_line+0x644>
     716:	8082                	ret
     718:	6515                	lui	a0,0x5
     71a:	d2850513          	addi	a0,a0,-728 # 4d28 <pad_line+0x230>
     71e:	8082                	ret
     720:	6515                	lui	a0,0x5
     722:	0e850513          	addi	a0,a0,232 # 50e8 <pad_line+0x5f0>
     726:	8082                	ret
     728:	6515                	lui	a0,0x5
     72a:	f5c50513          	addi	a0,a0,-164 # 4f5c <pad_line+0x464>
     72e:	8082                	ret
     730:	6515                	lui	a0,0x5
     732:	1e450513          	addi	a0,a0,484 # 51e4 <pad_line+0x6ec>
     736:	8082                	ret
     738:	6515                	lui	a0,0x5
     73a:	bf050513          	addi	a0,a0,-1040 # 4bf0 <pad_line+0xf8>
     73e:	8082                	ret
     740:	6515                	lui	a0,0x5
     742:	bb850513          	addi	a0,a0,-1096 # 4bb8 <pad_line+0xc0>
     746:	8082                	ret
     748:	6515                	lui	a0,0x5
     74a:	15850513          	addi	a0,a0,344 # 5158 <pad_line+0x660>
     74e:	8082                	ret
     750:	6515                	lui	a0,0x5
     752:	1bc50513          	addi	a0,a0,444 # 51bc <pad_line+0x6c4>
     756:	8082                	ret
     758:	6515                	lui	a0,0x5
     75a:	eb450513          	addi	a0,a0,-332 # 4eb4 <pad_line+0x3bc>
     75e:	8082                	ret
     760:	6515                	lui	a0,0x5
     762:	dec50513          	addi	a0,a0,-532 # 4dec <pad_line+0x2f4>
     766:	8082                	ret
     768:	6515                	lui	a0,0x5
     76a:	cc050513          	addi	a0,a0,-832 # 4cc0 <pad_line+0x1c8>
     76e:	8082                	ret
     770:	6515                	lui	a0,0x5
     772:	dc050513          	addi	a0,a0,-576 # 4dc0 <pad_line+0x2c8>
     776:	8082                	ret
     778:	6515                	lui	a0,0x5
     77a:	cb050513          	addi	a0,a0,-848 # 4cb0 <pad_line+0x1b8>
     77e:	8082                	ret
     780:	6515                	lui	a0,0x5
     782:	1f850513          	addi	a0,a0,504 # 51f8 <pad_line+0x700>
     786:	8082                	ret
     788:	6515                	lui	a0,0x5
     78a:	d0450513          	addi	a0,a0,-764 # 4d04 <pad_line+0x20c>
     78e:	8082                	ret
     790:	6515                	lui	a0,0x5
     792:	ed850513          	addi	a0,a0,-296 # 4ed8 <pad_line+0x3e0>
     796:	8082                	ret
     798:	6515                	lui	a0,0x5
     79a:	10050513          	addi	a0,a0,256 # 5100 <pad_line+0x608>
     79e:	8082                	ret
     7a0:	6515                	lui	a0,0x5
     7a2:	0d050513          	addi	a0,a0,208 # 50d0 <pad_line+0x5d8>
     7a6:	8082                	ret
     7a8:	6515                	lui	a0,0x5
     7aa:	0a050513          	addi	a0,a0,160 # 50a0 <pad_line+0x5a8>
     7ae:	8082                	ret
     7b0:	6515                	lui	a0,0x5
     7b2:	08850513          	addi	a0,a0,136 # 5088 <pad_line+0x590>
     7b6:	8082                	ret
     7b8:	6515                	lui	a0,0x5
     7ba:	06850513          	addi	a0,a0,104 # 5068 <pad_line+0x570>
     7be:	8082                	ret
     7c0:	6515                	lui	a0,0x5
     7c2:	04850513          	addi	a0,a0,72 # 5048 <pad_line+0x550>
     7c6:	8082                	ret
     7c8:	6515                	lui	a0,0x5
     7ca:	01850513          	addi	a0,a0,24 # 5018 <pad_line+0x520>
     7ce:	8082                	ret
     7d0:	6515                	lui	a0,0x5
     7d2:	ff450513          	addi	a0,a0,-12 # 4ff4 <pad_line+0x4fc>
     7d6:	8082                	ret
     7d8:	6515                	lui	a0,0x5
     7da:	0b450513          	addi	a0,a0,180 # 50b4 <pad_line+0x5bc>
     7de:	8082                	ret
     7e0:	6515                	lui	a0,0x5
     7e2:	19850513          	addi	a0,a0,408 # 5198 <pad_line+0x6a0>
     7e6:	8082                	ret
     7e8:	6515                	lui	a0,0x5
     7ea:	fdc50513          	addi	a0,a0,-36 # 4fdc <pad_line+0x4e4>
     7ee:	8082                	ret
     7f0:	6515                	lui	a0,0x5
     7f2:	fc050513          	addi	a0,a0,-64 # 4fc0 <pad_line+0x4c8>
     7f6:	8082                	ret
     7f8:	6515                	lui	a0,0x5
     7fa:	fac50513          	addi	a0,a0,-84 # 4fac <pad_line+0x4b4>
     7fe:	8082                	ret
     800:	6515                	lui	a0,0x5
     802:	f9050513          	addi	a0,a0,-112 # 4f90 <pad_line+0x498>
     806:	8082                	ret
     808:	6515                	lui	a0,0x5
     80a:	f8450513          	addi	a0,a0,-124 # 4f84 <pad_line+0x48c>
     80e:	8082                	ret
     810:	6515                	lui	a0,0x5
     812:	f7050513          	addi	a0,a0,-144 # 4f70 <pad_line+0x478>
     816:	8082                	ret
     818:	6515                	lui	a0,0x5
     81a:	f4c50513          	addi	a0,a0,-180 # 4f4c <pad_line+0x454>
     81e:	8082                	ret
     820:	6515                	lui	a0,0x5
     822:	f3450513          	addi	a0,a0,-204 # 4f34 <pad_line+0x43c>
     826:	8082                	ret
     828:	6515                	lui	a0,0x5
     82a:	f2050513          	addi	a0,a0,-224 # 4f20 <pad_line+0x428>
     82e:	8082                	ret
     830:	6515                	lui	a0,0x5
     832:	f0850513          	addi	a0,a0,-248 # 4f08 <pad_line+0x410>
     836:	8082                	ret
     838:	6515                	lui	a0,0x5
     83a:	01050513          	addi	a0,a0,16 # 5010 <pad_line+0x518>
     83e:	8082                	ret
     840:	6515                	lui	a0,0x5
     842:	ef850513          	addi	a0,a0,-264 # 4ef8 <pad_line+0x400>
     846:	8082                	ret
     848:	6515                	lui	a0,0x5
     84a:	ef050513          	addi	a0,a0,-272 # 4ef0 <pad_line+0x3f8>
     84e:	8082                	ret
     850:	6515                	lui	a0,0x5
     852:	ecc50513          	addi	a0,a0,-308 # 4ecc <pad_line+0x3d4>
     856:	8082                	ret
     858:	6515                	lui	a0,0x5
     85a:	ea050513          	addi	a0,a0,-352 # 4ea0 <pad_line+0x3a8>
     85e:	8082                	ret
     860:	6515                	lui	a0,0x5
     862:	e8450513          	addi	a0,a0,-380 # 4e84 <pad_line+0x38c>
     866:	8082                	ret
     868:	6515                	lui	a0,0x5
     86a:	e7050513          	addi	a0,a0,-400 # 4e70 <pad_line+0x378>
     86e:	8082                	ret
     870:	6515                	lui	a0,0x5
     872:	e4050513          	addi	a0,a0,-448 # 4e40 <pad_line+0x348>
     876:	8082                	ret
     878:	6515                	lui	a0,0x5
     87a:	e3450513          	addi	a0,a0,-460 # 4e34 <pad_line+0x33c>
     87e:	8082                	ret
     880:	6515                	lui	a0,0x5
     882:	e2450513          	addi	a0,a0,-476 # 4e24 <pad_line+0x32c>
     886:	8082                	ret
     888:	6515                	lui	a0,0x5
     88a:	e0c50513          	addi	a0,a0,-500 # 4e0c <pad_line+0x314>
     88e:	8082                	ret
     890:	6515                	lui	a0,0x5
     892:	dfc50513          	addi	a0,a0,-516 # 4dfc <pad_line+0x304>
     896:	8082                	ret
     898:	6515                	lui	a0,0x5
     89a:	dd450513          	addi	a0,a0,-556 # 4dd4 <pad_line+0x2dc>
     89e:	8082                	ret
     8a0:	6515                	lui	a0,0x5
     8a2:	db050513          	addi	a0,a0,-592 # 4db0 <pad_line+0x2b8>
     8a6:	8082                	ret
     8a8:	6515                	lui	a0,0x5
     8aa:	da050513          	addi	a0,a0,-608 # 4da0 <pad_line+0x2a8>
     8ae:	8082                	ret
     8b0:	6515                	lui	a0,0x5
     8b2:	d8850513          	addi	a0,a0,-632 # 4d88 <pad_line+0x290>
     8b6:	8082                	ret
     8b8:	6515                	lui	a0,0x5
     8ba:	d6850513          	addi	a0,a0,-664 # 4d68 <pad_line+0x270>
     8be:	8082                	ret
     8c0:	6515                	lui	a0,0x5
     8c2:	d4850513          	addi	a0,a0,-696 # 4d48 <pad_line+0x250>
     8c6:	8082                	ret
     8c8:	6515                	lui	a0,0x5
     8ca:	cf050513          	addi	a0,a0,-784 # 4cf0 <pad_line+0x1f8>
     8ce:	8082                	ret
     8d0:	6515                	lui	a0,0x5
     8d2:	ce050513          	addi	a0,a0,-800 # 4ce0 <pad_line+0x1e8>
     8d6:	8082                	ret
     8d8:	6515                	lui	a0,0x5
     8da:	ca050513          	addi	a0,a0,-864 # 4ca0 <pad_line+0x1a8>
     8de:	8082                	ret
     8e0:	6515                	lui	a0,0x5
     8e2:	c9050513          	addi	a0,a0,-880 # 4c90 <pad_line+0x198>
     8e6:	8082                	ret
     8e8:	6515                	lui	a0,0x5
     8ea:	c7c50513          	addi	a0,a0,-900 # 4c7c <pad_line+0x184>
     8ee:	8082                	ret
     8f0:	6515                	lui	a0,0x5
     8f2:	c7050513          	addi	a0,a0,-912 # 4c70 <pad_line+0x178>
     8f6:	8082                	ret
     8f8:	6515                	lui	a0,0x5
     8fa:	c5850513          	addi	a0,a0,-936 # 4c58 <pad_line+0x160>
     8fe:	8082                	ret
     900:	6515                	lui	a0,0x5
     902:	c4c50513          	addi	a0,a0,-948 # 4c4c <pad_line+0x154>
     906:	8082                	ret
     908:	6515                	lui	a0,0x5
     90a:	c3850513          	addi	a0,a0,-968 # 4c38 <pad_line+0x140>
     90e:	8082                	ret
     910:	6515                	lui	a0,0x5
     912:	c2450513          	addi	a0,a0,-988 # 4c24 <pad_line+0x12c>
     916:	8082                	ret
     918:	6515                	lui	a0,0x5
     91a:	c1050513          	addi	a0,a0,-1008 # 4c10 <pad_line+0x118>
     91e:	8082                	ret
     920:	6515                	lui	a0,0x5
     922:	be450513          	addi	a0,a0,-1052 # 4be4 <pad_line+0xec>
     926:	8082                	ret
     928:	6515                	lui	a0,0x5
     92a:	bd450513          	addi	a0,a0,-1068 # 4bd4 <pad_line+0xdc>
     92e:	8082                	ret
     930:	6515                	lui	a0,0x5
     932:	ba450513          	addi	a0,a0,-1116 # 4ba4 <pad_line+0xac>
     936:	8082                	ret
     938:	6515                	lui	a0,0x5
     93a:	b9050513          	addi	a0,a0,-1136 # 4b90 <pad_line+0x98>
     93e:	8082                	ret
     940:	6515                	lui	a0,0x5
     942:	b7450513          	addi	a0,a0,-1164 # 4b74 <pad_line+0x7c>
     946:	8082                	ret
     948:	6515                	lui	a0,0x5
     94a:	b6850513          	addi	a0,a0,-1176 # 4b68 <pad_line+0x70>
     94e:	8082                	ret
     950:	6515                	lui	a0,0x5
     952:	b5050513          	addi	a0,a0,-1200 # 4b50 <pad_line+0x58>
     956:	8082                	ret
     958:	6515                	lui	a0,0x5
     95a:	b4050513          	addi	a0,a0,-1216 # 4b40 <pad_line+0x48>
     95e:	8082                	ret
     960:	6515                	lui	a0,0x5
     962:	b2450513          	addi	a0,a0,-1244 # 4b24 <pad_line+0x2c>
     966:	8082                	ret
     968:	6515                	lui	a0,0x5
     96a:	21050513          	addi	a0,a0,528 # 5210 <pad_line+0x718>
     96e:	8082                	ret
     970:	6515                	lui	a0,0x5
     972:	b1850513          	addi	a0,a0,-1256 # 4b18 <pad_line+0x20>
     976:	8082                	ret
     978:	6515                	lui	a0,0x5
     97a:	c0c50513          	addi	a0,a0,-1012 # 4c0c <pad_line+0x114>
     97e:	bb95                	j	6f2 <_strerror_r+0x2e>
     980:	86aa                	mv	a3,a0
     982:	b39d                	j	6e8 <_strerror_r+0x24>

00000984 <strerror>:
     984:	85aa                	mv	a1,a0
     986:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     98a:	4681                	li	a3,0
     98c:	4601                	li	a2,0
     98e:	bb1d                	j	6c4 <_strerror_r>

00000990 <strerror_l>:
     990:	85aa                	mv	a1,a0
     992:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     996:	4681                	li	a3,0
     998:	4601                	li	a2,0
     99a:	b32d                	j	6c4 <_strerror_r>

0000099c <_user_strerror>:
     99c:	4501                	li	a0,0
     99e:	8082                	ret

000009a0 <__errno>:
     9a0:	0001a503          	lw	a0,0(gp) # 200001e0 <_impure_ptr>
     9a4:	8082                	ret

000009a6 <memmove>:
     9a6:	06a5f063          	bgeu	a1,a0,a06 <memmove+0x60>
     9aa:	00c58733          	add	a4,a1,a2
     9ae:	04e57c63          	bgeu	a0,a4,a06 <memmove+0x60>
     9b2:	468d                	li	a3,3
     9b4:	00c507b3          	add	a5,a0,a2
     9b8:	02c6f863          	bgeu	a3,a2,9e8 <memmove+0x42>
     9bc:	00f766b3          	or	a3,a4,a5
     9c0:	8a8d                	andi	a3,a3,3
     9c2:	e6e5                	bnez	a3,aaa <memmove+0x104>
     9c4:	ffc60293          	addi	t0,a2,-4
     9c8:	fff2c293          	not	t0,t0
     9cc:	ffc2f293          	andi	t0,t0,-4
     9d0:	00578333          	add	t1,a5,t0
     9d4:	86ba                	mv	a3,a4
     9d6:	ffc6a583          	lw	a1,-4(a3)
     9da:	17f1                	addi	a5,a5,-4
     9dc:	16f1                	addi	a3,a3,-4
     9de:	c38c                	sw	a1,0(a5)
     9e0:	fe679be3          	bne	a5,t1,9d6 <memmove+0x30>
     9e4:	8a0d                	andi	a2,a2,3
     9e6:	9716                	add	a4,a4,t0
     9e8:	fff60693          	addi	a3,a2,-1
     9ec:	c271                	beqz	a2,ab0 <memmove+0x10a>
     9ee:	fff6c613          	not	a2,a3
     9f2:	963e                	add	a2,a2,a5
     9f4:	fff74683          	lbu	a3,-1(a4)
     9f8:	17fd                	addi	a5,a5,-1
     9fa:	177d                	addi	a4,a4,-1
     9fc:	00d78023          	sb	a3,0(a5)
     a00:	fef61ae3          	bne	a2,a5,9f4 <memmove+0x4e>
     a04:	8082                	ret
     a06:	478d                	li	a5,3
     a08:	02c7e163          	bltu	a5,a2,a2a <memmove+0x84>
     a0c:	87aa                	mv	a5,a0
     a0e:	fff60693          	addi	a3,a2,-1
     a12:	ca59                	beqz	a2,aa8 <memmove+0x102>
     a14:	0685                	addi	a3,a3,1
     a16:	96ae                	add	a3,a3,a1
     a18:	0005c703          	lbu	a4,0(a1)
     a1c:	0585                	addi	a1,a1,1
     a1e:	0785                	addi	a5,a5,1
     a20:	fee78fa3          	sb	a4,-1(a5)
     a24:	fed59ae3          	bne	a1,a3,a18 <memmove+0x72>
     a28:	8082                	ret
     a2a:	00a5e7b3          	or	a5,a1,a0
     a2e:	8b8d                	andi	a5,a5,3
     a30:	eba5                	bnez	a5,aa0 <memmove+0xfa>
     a32:	47bd                	li	a5,15
     a34:	06c7ff63          	bgeu	a5,a2,ab2 <memmove+0x10c>
     a38:	ff060793          	addi	a5,a2,-16
     a3c:	9bc1                	andi	a5,a5,-16
     a3e:	07c1                	addi	a5,a5,16
     a40:	00f58333          	add	t1,a1,a5
     a44:	872a                	mv	a4,a0
     a46:	4194                	lw	a3,0(a1)
     a48:	05c1                	addi	a1,a1,16
     a4a:	0741                	addi	a4,a4,16
     a4c:	fed72823          	sw	a3,-16(a4)
     a50:	ff45a683          	lw	a3,-12(a1)
     a54:	fed72a23          	sw	a3,-12(a4)
     a58:	ff85a683          	lw	a3,-8(a1)
     a5c:	fed72c23          	sw	a3,-8(a4)
     a60:	ffc5a683          	lw	a3,-4(a1)
     a64:	fed72e23          	sw	a3,-4(a4)
     a68:	fcb31fe3          	bne	t1,a1,a46 <memmove+0xa0>
     a6c:	00f67293          	andi	t0,a2,15
     a70:	00c67713          	andi	a4,a2,12
     a74:	97aa                	add	a5,a5,a0
     a76:	8616                	mv	a2,t0
     a78:	db59                	beqz	a4,a0e <memmove+0x68>
     a7a:	ffc28313          	addi	t1,t0,-4 # bffffffc <__bss_end__+0x9fffe04c>
     a7e:	ffc37313          	andi	t1,t1,-4
     a82:	0311                	addi	t1,t1,4
     a84:	00658633          	add	a2,a1,t1
     a88:	873e                	mv	a4,a5
     a8a:	4194                	lw	a3,0(a1)
     a8c:	0591                	addi	a1,a1,4
     a8e:	0711                	addi	a4,a4,4
     a90:	fed72e23          	sw	a3,-4(a4)
     a94:	fec59be3          	bne	a1,a2,a8a <memmove+0xe4>
     a98:	0032f613          	andi	a2,t0,3
     a9c:	979a                	add	a5,a5,t1
     a9e:	bf85                	j	a0e <memmove+0x68>
     aa0:	fff60693          	addi	a3,a2,-1
     aa4:	87aa                	mv	a5,a0
     aa6:	b7bd                	j	a14 <memmove+0x6e>
     aa8:	8082                	ret
     aaa:	fff60693          	addi	a3,a2,-1
     aae:	b781                	j	9ee <memmove+0x48>
     ab0:	8082                	ret
     ab2:	87aa                	mv	a5,a0
     ab4:	82b2                	mv	t0,a2
     ab6:	b7d1                	j	a7a <memmove+0xd4>

00000ab8 <memset>:
     ab8:	47fd                	li	a5,31
     aba:	86aa                	mv	a3,a0
     abc:	0ec7fa63          	bgeu	a5,a2,bb0 <memset+0xf8>
     ac0:	0036f713          	andi	a4,a3,3
     ac4:	cf19                	beqz	a4,ae2 <memset+0x2a>
     ac6:	00000297          	auipc	t0,0x0
     aca:	00271313          	slli	t1,a4,0x2
     ace:	929a                	add	t0,t0,t1
     ad0:	8306                	mv	t1,ra
     ad2:	166280e7          	jalr	358(t0) # c2c <memset+0x174>
     ad6:	809a                	mv	ra,t1
     ad8:	1771                	addi	a4,a4,-4
     ada:	963a                	add	a2,a2,a4
     adc:	8e99                	sub	a3,a3,a4
     ade:	0cc7f963          	bgeu	a5,a2,bb0 <memset+0xf8>
     ae2:	e199                	bnez	a1,ae8 <memset+0x30>
     ae4:	a821                	j	afc <memset+0x44>
     ae6:	0001                	nop
     ae8:	0ff5f593          	zext.b	a1,a1
     aec:	00859293          	slli	t0,a1,0x8
     af0:	0055e5b3          	or	a1,a1,t0
     af4:	01059293          	slli	t0,a1,0x10
     af8:	0055e5b3          	or	a1,a1,t0
     afc:	ffc67293          	andi	t0,a2,-4
     b00:	00568333          	add	t1,a3,t0
     b04:	07c2f293          	andi	t0,t0,124
     b08:	00028e63          	beqz	t0,b24 <memset+0x6c>
     b0c:	405002b3          	neg	t0,t0
     b10:	08028293          	addi	t0,t0,128
     b14:	405686b3          	sub	a3,a3,t0
     b18:	00000397          	auipc	t2,0x0
     b1c:	9396                	add	t2,t2,t0
     b1e:	00c38067          	jr	12(t2) # b24 <memset+0x6c>
     b22:	0001                	nop
     b24:	00b6a023          	sw	a1,0(a3)
     b28:	00b6a223          	sw	a1,4(a3)
     b2c:	00b6a423          	sw	a1,8(a3)
     b30:	00b6a623          	sw	a1,12(a3)
     b34:	00b6a823          	sw	a1,16(a3)
     b38:	00b6aa23          	sw	a1,20(a3)
     b3c:	00b6ac23          	sw	a1,24(a3)
     b40:	00b6ae23          	sw	a1,28(a3)
     b44:	02b6a023          	sw	a1,32(a3)
     b48:	02b6a223          	sw	a1,36(a3)
     b4c:	02b6a423          	sw	a1,40(a3)
     b50:	02b6a623          	sw	a1,44(a3)
     b54:	02b6a823          	sw	a1,48(a3)
     b58:	02b6aa23          	sw	a1,52(a3)
     b5c:	02b6ac23          	sw	a1,56(a3)
     b60:	02b6ae23          	sw	a1,60(a3)
     b64:	04b6a023          	sw	a1,64(a3)
     b68:	04b6a223          	sw	a1,68(a3)
     b6c:	04b6a423          	sw	a1,72(a3)
     b70:	04b6a623          	sw	a1,76(a3)
     b74:	04b6a823          	sw	a1,80(a3)
     b78:	04b6aa23          	sw	a1,84(a3)
     b7c:	04b6ac23          	sw	a1,88(a3)
     b80:	04b6ae23          	sw	a1,92(a3)
     b84:	06b6a023          	sw	a1,96(a3)
     b88:	06b6a223          	sw	a1,100(a3)
     b8c:	06b6a423          	sw	a1,104(a3)
     b90:	06b6a623          	sw	a1,108(a3)
     b94:	06b6a823          	sw	a1,112(a3)
     b98:	06b6aa23          	sw	a1,116(a3)
     b9c:	06b6ac23          	sw	a1,120(a3)
     ba0:	06b6ae23          	sw	a1,124(a3)
     ba4:	08068693          	addi	a3,a3,128
     ba8:	f666eee3          	bltu	a3,t1,b24 <memset+0x6c>
     bac:	8a0d                	andi	a2,a2,3
     bae:	c659                	beqz	a2,c3c <memset+0x184>
     bb0:	00000297          	auipc	t0,0x0
     bb4:	40c78633          	sub	a2,a5,a2
     bb8:	060a                	slli	a2,a2,0x2
     bba:	92b2                	add	t0,t0,a2
     bbc:	01028067          	jr	16(t0) # bc0 <memset+0x108>
     bc0:	00b68f23          	sb	a1,30(a3)
     bc4:	00b68ea3          	sb	a1,29(a3)
     bc8:	00b68e23          	sb	a1,28(a3)
     bcc:	00b68da3          	sb	a1,27(a3)
     bd0:	00b68d23          	sb	a1,26(a3)
     bd4:	00b68ca3          	sb	a1,25(a3)
     bd8:	00b68c23          	sb	a1,24(a3)
     bdc:	00b68ba3          	sb	a1,23(a3)
     be0:	00b68b23          	sb	a1,22(a3)
     be4:	00b68aa3          	sb	a1,21(a3)
     be8:	00b68a23          	sb	a1,20(a3)
     bec:	00b689a3          	sb	a1,19(a3)
     bf0:	00b68923          	sb	a1,18(a3)
     bf4:	00b688a3          	sb	a1,17(a3)
     bf8:	00b68823          	sb	a1,16(a3)
     bfc:	00b687a3          	sb	a1,15(a3)
     c00:	00b68723          	sb	a1,14(a3)
     c04:	00b686a3          	sb	a1,13(a3)
     c08:	00b68623          	sb	a1,12(a3)
     c0c:	00b685a3          	sb	a1,11(a3)
     c10:	00b68523          	sb	a1,10(a3)
     c14:	00b684a3          	sb	a1,9(a3)
     c18:	00b68423          	sb	a1,8(a3)
     c1c:	00b683a3          	sb	a1,7(a3)
     c20:	00b68323          	sb	a1,6(a3)
     c24:	00b682a3          	sb	a1,5(a3)
     c28:	00b68223          	sb	a1,4(a3)
     c2c:	00b681a3          	sb	a1,3(a3)
     c30:	00b68123          	sb	a1,2(a3)
     c34:	00b680a3          	sb	a1,1(a3)
     c38:	00b68023          	sb	a1,0(a3)
     c3c:	8082                	ret

00000c3e <strlen>:
     c3e:	00357793          	andi	a5,a0,3
     c42:	872a                	mv	a4,a0
     c44:	ef95                	bnez	a5,c80 <strlen+0x42>
     c46:	7f7f86b7          	lui	a3,0x7f7f8
     c4a:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__bss_end__+0x5f7f5fcf>
     c4e:	55fd                	li	a1,-1
     c50:	4310                	lw	a2,0(a4)
     c52:	0711                	addi	a4,a4,4
     c54:	00d677b3          	and	a5,a2,a3
     c58:	97b6                	add	a5,a5,a3
     c5a:	8fd1                	or	a5,a5,a2
     c5c:	8fd5                	or	a5,a5,a3
     c5e:	feb789e3          	beq	a5,a1,c50 <strlen+0x12>
     c62:	ffc74683          	lbu	a3,-4(a4)
     c66:	ffd74603          	lbu	a2,-3(a4)
     c6a:	ffe74783          	lbu	a5,-2(a4)
     c6e:	8f09                	sub	a4,a4,a0
     c70:	c68d                	beqz	a3,c9a <strlen+0x5c>
     c72:	c20d                	beqz	a2,c94 <strlen+0x56>
     c74:	00f03533          	snez	a0,a5
     c78:	953a                	add	a0,a0,a4
     c7a:	1579                	addi	a0,a0,-2
     c7c:	8082                	ret
     c7e:	d6e1                	beqz	a3,c46 <strlen+0x8>
     c80:	00074783          	lbu	a5,0(a4)
     c84:	0705                	addi	a4,a4,1
     c86:	00377693          	andi	a3,a4,3
     c8a:	fbf5                	bnez	a5,c7e <strlen+0x40>
     c8c:	8f09                	sub	a4,a4,a0
     c8e:	fff70513          	addi	a0,a4,-1
     c92:	8082                	ret
     c94:	ffd70513          	addi	a0,a4,-3
     c98:	8082                	ret
     c9a:	ffc70513          	addi	a0,a4,-4
     c9e:	8082                	ret

00000ca0 <strcpy>:
     ca0:	00b567b3          	or	a5,a0,a1
     ca4:	8b8d                	andi	a5,a5,3
     ca6:	efb1                	bnez	a5,d02 <strcpy+0x62>
     ca8:	4198                	lw	a4,0(a1)
     caa:	7f7f86b7          	lui	a3,0x7f7f8
     cae:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__bss_end__+0x5f7f5fcf>
     cb2:	00d777b3          	and	a5,a4,a3
     cb6:	97b6                	add	a5,a5,a3
     cb8:	8fd9                	or	a5,a5,a4
     cba:	8fd5                	or	a5,a5,a3
     cbc:	567d                	li	a2,-1
     cbe:	04c79b63          	bne	a5,a2,d14 <strcpy+0x74>
     cc2:	862a                	mv	a2,a0
     cc4:	537d                	li	t1,-1
     cc6:	c218                	sw	a4,0(a2)
     cc8:	41d8                	lw	a4,4(a1)
     cca:	0591                	addi	a1,a1,4
     ccc:	0611                	addi	a2,a2,4
     cce:	00d777b3          	and	a5,a4,a3
     cd2:	97b6                	add	a5,a5,a3
     cd4:	8fd9                	or	a5,a5,a4
     cd6:	8fd5                	or	a5,a5,a3
     cd8:	fe6787e3          	beq	a5,t1,cc6 <strcpy+0x26>
     cdc:	0005c783          	lbu	a5,0(a1)
     ce0:	00f60023          	sb	a5,0(a2)
     ce4:	cb99                	beqz	a5,cfa <strcpy+0x5a>
     ce6:	0015c783          	lbu	a5,1(a1)
     cea:	00f600a3          	sb	a5,1(a2)
     cee:	c791                	beqz	a5,cfa <strcpy+0x5a>
     cf0:	0025c783          	lbu	a5,2(a1)
     cf4:	00f60123          	sb	a5,2(a2)
     cf8:	e391                	bnez	a5,cfc <strcpy+0x5c>
     cfa:	8082                	ret
     cfc:	000601a3          	sb	zero,3(a2)
     d00:	8082                	ret
     d02:	87aa                	mv	a5,a0
     d04:	0005c703          	lbu	a4,0(a1)
     d08:	0785                	addi	a5,a5,1
     d0a:	0585                	addi	a1,a1,1
     d0c:	fee78fa3          	sb	a4,-1(a5)
     d10:	fb75                	bnez	a4,d04 <strcpy+0x64>
     d12:	8082                	ret
     d14:	862a                	mv	a2,a0
     d16:	b7d9                	j	cdc <strcpy+0x3c>

00000d18 <__udivdi3>:
#endif

#ifdef L_udivdi3
UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
     d18:	1161                	addi	sp,sp,-8
     d1a:	c222                	sw	s0,4(sp)
     d1c:	c026                	sw	s1,0(sp)
     d1e:	82aa                	mv	t0,a0
     d20:	87ae                	mv	a5,a1
  if (d1 == 0)
     d22:	20069d63          	bnez	a3,f3c <__udivdi3+0x224>
     d26:	85b6                	mv	a1,a3
     d28:	6695                	lui	a3,0x5
     d2a:	8332                	mv	t1,a2
     d2c:	83aa                	mv	t2,a0
      if (d0 > n1)
     d2e:	82868693          	addi	a3,a3,-2008 # 4828 <__clz_tab>
     d32:	0cc7f263          	bgeu	a5,a2,df6 <__udivdi3+0xde>
	  count_leading_zeros (bm, d0);
     d36:	6741                	lui	a4,0x10
     d38:	853e                	mv	a0,a5
     d3a:	0ae67763          	bgeu	a2,a4,de8 <__udivdi3+0xd0>
     d3e:	0ff00713          	li	a4,255
     d42:	00c73733          	sltu	a4,a4,a2
     d46:	070e                	slli	a4,a4,0x3
     d48:	00e655b3          	srl	a1,a2,a4
     d4c:	96ae                	add	a3,a3,a1
     d4e:	0006c683          	lbu	a3,0(a3)
     d52:	9736                	add	a4,a4,a3
     d54:	02000693          	li	a3,32
     d58:	40e68433          	sub	s0,a3,a4
	  if (bm != 0)
     d5c:	00e68c63          	beq	a3,a4,d74 <__udivdi3+0x5c>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
     d60:	008796b3          	sll	a3,a5,s0
     d64:	00e2d733          	srl	a4,t0,a4
	      d0 = d0 << bm;
     d68:	00861333          	sll	t1,a2,s0
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
     d6c:	00d76533          	or	a0,a4,a3
	      n0 = n0 << bm;
     d70:	008293b3          	sll	t2,t0,s0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
     d74:	01035593          	srli	a1,t1,0x10
     d78:	02b556b3          	divu	a3,a0,a1
     d7c:	01031613          	slli	a2,t1,0x10
     d80:	8241                	srli	a2,a2,0x10
     d82:	0103d793          	srli	a5,t2,0x10
     d86:	02b57733          	remu	a4,a0,a1
     d8a:	8536                	mv	a0,a3
     d8c:	02d602b3          	mul	t0,a2,a3
     d90:	0742                	slli	a4,a4,0x10
     d92:	8fd9                	or	a5,a5,a4
     d94:	0057fc63          	bgeu	a5,t0,dac <__udivdi3+0x94>
     d98:	979a                	add	a5,a5,t1
     d9a:	fff68513          	addi	a0,a3,-1
     d9e:	0067e763          	bltu	a5,t1,dac <__udivdi3+0x94>
     da2:	0057f563          	bgeu	a5,t0,dac <__udivdi3+0x94>
     da6:	ffe68513          	addi	a0,a3,-2
     daa:	979a                	add	a5,a5,t1
     dac:	405787b3          	sub	a5,a5,t0
     db0:	02b7f733          	remu	a4,a5,a1
     db4:	03c2                	slli	t2,t2,0x10
     db6:	0103d393          	srli	t2,t2,0x10
     dba:	02b7d7b3          	divu	a5,a5,a1
     dbe:	0742                	slli	a4,a4,0x10
     dc0:	007763b3          	or	t2,a4,t2
     dc4:	02f60633          	mul	a2,a2,a5
     dc8:	873e                	mv	a4,a5
     dca:	00c3fb63          	bgeu	t2,a2,de0 <__udivdi3+0xc8>
     dce:	939a                	add	t2,t2,t1
     dd0:	fff78713          	addi	a4,a5,-1
     dd4:	0063e663          	bltu	t2,t1,de0 <__udivdi3+0xc8>
     dd8:	00c3f463          	bgeu	t2,a2,de0 <__udivdi3+0xc8>
     ddc:	ffe78713          	addi	a4,a5,-2
     de0:	0542                	slli	a0,a0,0x10
     de2:	8d59                	or	a0,a0,a4
	      q1 = 0;
     de4:	4581                	li	a1,0
     de6:	a855                	j	e9a <__udivdi3+0x182>
	  count_leading_zeros (bm, d0);
     de8:	010005b7          	lui	a1,0x1000
     dec:	4741                	li	a4,16
     dee:	f4b66de3          	bltu	a2,a1,d48 <__udivdi3+0x30>
     df2:	4761                	li	a4,24
     df4:	bf91                	j	d48 <__udivdi3+0x30>
	  if (d0 == 0)
     df6:	e601                	bnez	a2,dfe <__udivdi3+0xe6>
	    d0 = 1 / d0;	/* Divide intentionally by zero.  */
     df8:	4705                	li	a4,1
     dfa:	02c75333          	divu	t1,a4,a2
	  count_leading_zeros (bm, d0);
     dfe:	6741                	lui	a4,0x10
     e00:	0ae37163          	bgeu	t1,a4,ea2 <__udivdi3+0x18a>
     e04:	0ff00713          	li	a4,255
     e08:	00677363          	bgeu	a4,t1,e0e <__udivdi3+0xf6>
     e0c:	45a1                	li	a1,8
     e0e:	00b35733          	srl	a4,t1,a1
     e12:	96ba                	add	a3,a3,a4
     e14:	0006c703          	lbu	a4,0(a3)
     e18:	02000693          	li	a3,32
     e1c:	972e                	add	a4,a4,a1
     e1e:	40e68533          	sub	a0,a3,a4
	  if (bm == 0)
     e22:	08e69763          	bne	a3,a4,eb0 <__udivdi3+0x198>
	      n1 -= d0;
     e26:	406787b3          	sub	a5,a5,t1
	      q1 = 1;
     e2a:	4585                	li	a1,1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
     e2c:	01035293          	srli	t0,t1,0x10
     e30:	01031613          	slli	a2,t1,0x10
     e34:	8241                	srli	a2,a2,0x10
     e36:	0103d713          	srli	a4,t2,0x10
     e3a:	0257f6b3          	remu	a3,a5,t0
     e3e:	0257d7b3          	divu	a5,a5,t0
     e42:	06c2                	slli	a3,a3,0x10
     e44:	8f55                	or	a4,a4,a3
     e46:	02f60433          	mul	s0,a2,a5
     e4a:	853e                	mv	a0,a5
     e4c:	00877c63          	bgeu	a4,s0,e64 <__udivdi3+0x14c>
     e50:	971a                	add	a4,a4,t1
     e52:	fff78513          	addi	a0,a5,-1
     e56:	00676763          	bltu	a4,t1,e64 <__udivdi3+0x14c>
     e5a:	00877563          	bgeu	a4,s0,e64 <__udivdi3+0x14c>
     e5e:	ffe78513          	addi	a0,a5,-2
     e62:	971a                	add	a4,a4,t1
     e64:	8f01                	sub	a4,a4,s0
     e66:	025777b3          	remu	a5,a4,t0
     e6a:	03c2                	slli	t2,t2,0x10
     e6c:	0103d393          	srli	t2,t2,0x10
     e70:	02575733          	divu	a4,a4,t0
     e74:	07c2                	slli	a5,a5,0x10
     e76:	0077e3b3          	or	t2,a5,t2
     e7a:	02e60633          	mul	a2,a2,a4
     e7e:	87ba                	mv	a5,a4
     e80:	00c3fb63          	bgeu	t2,a2,e96 <__udivdi3+0x17e>
     e84:	939a                	add	t2,t2,t1
     e86:	fff70793          	addi	a5,a4,-1 # ffff <__ctor_end__+0xadaf>
     e8a:	0063e663          	bltu	t2,t1,e96 <__udivdi3+0x17e>
     e8e:	00c3f463          	bgeu	t2,a2,e96 <__udivdi3+0x17e>
     e92:	ffe70793          	addi	a5,a4,-2
     e96:	0542                	slli	a0,a0,0x10
     e98:	8d5d                	or	a0,a0,a5
  return __udivmoddi4 (n, d, (UDWtype *) 0);
}
     e9a:	4412                	lw	s0,4(sp)
     e9c:	4482                	lw	s1,0(sp)
     e9e:	0121                	addi	sp,sp,8
     ea0:	8082                	ret
	  count_leading_zeros (bm, d0);
     ea2:	01000737          	lui	a4,0x1000
     ea6:	45c1                	li	a1,16
     ea8:	f6e363e3          	bltu	t1,a4,e0e <__udivdi3+0xf6>
     eac:	45e1                	li	a1,24
     eae:	b785                	j	e0e <__udivdi3+0xf6>
	      d0 = d0 << bm;
     eb0:	00a31333          	sll	t1,t1,a0
	      n2 = n1 >> b;
     eb4:	00e7d6b3          	srl	a3,a5,a4
	      n0 = n0 << bm;
     eb8:	00a293b3          	sll	t2,t0,a0
	      n1 = (n1 << bm) | (n0 >> b);
     ebc:	00a797b3          	sll	a5,a5,a0
	      udiv_qrnnd (q1, n1, n2, n1, d0);
     ec0:	01035513          	srli	a0,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
     ec4:	00e2d733          	srl	a4,t0,a4
	      udiv_qrnnd (q1, n1, n2, n1, d0);
     ec8:	02a6d2b3          	divu	t0,a3,a0
	      n1 = (n1 << bm) | (n0 >> b);
     ecc:	00f76633          	or	a2,a4,a5
	      udiv_qrnnd (q1, n1, n2, n1, d0);
     ed0:	01031793          	slli	a5,t1,0x10
     ed4:	83c1                	srli	a5,a5,0x10
     ed6:	01065593          	srli	a1,a2,0x10
     eda:	02a6f733          	remu	a4,a3,a0
     ede:	025786b3          	mul	a3,a5,t0
     ee2:	0742                	slli	a4,a4,0x10
     ee4:	8f4d                	or	a4,a4,a1
     ee6:	8596                	mv	a1,t0
     ee8:	00d77c63          	bgeu	a4,a3,f00 <__udivdi3+0x1e8>
     eec:	971a                	add	a4,a4,t1
     eee:	fff28593          	addi	a1,t0,-1
     ef2:	00676763          	bltu	a4,t1,f00 <__udivdi3+0x1e8>
     ef6:	00d77563          	bgeu	a4,a3,f00 <__udivdi3+0x1e8>
     efa:	ffe28593          	addi	a1,t0,-2
     efe:	971a                	add	a4,a4,t1
     f00:	40d706b3          	sub	a3,a4,a3
     f04:	02a6f733          	remu	a4,a3,a0
     f08:	02a6d6b3          	divu	a3,a3,a0
     f0c:	0742                	slli	a4,a4,0x10
     f0e:	02d78533          	mul	a0,a5,a3
     f12:	01061793          	slli	a5,a2,0x10
     f16:	83c1                	srli	a5,a5,0x10
     f18:	8fd9                	or	a5,a5,a4
     f1a:	8736                	mv	a4,a3
     f1c:	00a7fc63          	bgeu	a5,a0,f34 <__udivdi3+0x21c>
     f20:	979a                	add	a5,a5,t1
     f22:	fff68713          	addi	a4,a3,-1
     f26:	0067e763          	bltu	a5,t1,f34 <__udivdi3+0x21c>
     f2a:	00a7f563          	bgeu	a5,a0,f34 <__udivdi3+0x21c>
     f2e:	ffe68713          	addi	a4,a3,-2
     f32:	979a                	add	a5,a5,t1
     f34:	05c2                	slli	a1,a1,0x10
     f36:	8f89                	sub	a5,a5,a0
     f38:	8dd9                	or	a1,a1,a4
     f3a:	bdcd                	j	e2c <__udivdi3+0x114>
      if (d1 > n1)
     f3c:	12d5ee63          	bltu	a1,a3,1078 <__udivdi3+0x360>
	  count_leading_zeros (bm, d1);
     f40:	6741                	lui	a4,0x10
     f42:	02e6fe63          	bgeu	a3,a4,f7e <__udivdi3+0x266>
     f46:	0ff00713          	li	a4,255
     f4a:	00d73733          	sltu	a4,a4,a3
     f4e:	070e                	slli	a4,a4,0x3
     f50:	6595                	lui	a1,0x5
     f52:	00e6d533          	srl	a0,a3,a4
     f56:	82858593          	addi	a1,a1,-2008 # 4828 <__clz_tab>
     f5a:	95aa                	add	a1,a1,a0
     f5c:	0005c583          	lbu	a1,0(a1)
     f60:	02000513          	li	a0,32
     f64:	972e                	add	a4,a4,a1
     f66:	40e505b3          	sub	a1,a0,a4
	  if (bm == 0)
     f6a:	02e51163          	bne	a0,a4,f8c <__udivdi3+0x274>
		  q0 = 1;
     f6e:	4505                	li	a0,1
	      if (n1 > d1 || n0 >= d0)
     f70:	f2f6e5e3          	bltu	a3,a5,e9a <__udivdi3+0x182>
     f74:	00c2b633          	sltu	a2,t0,a2
     f78:	00164513          	xori	a0,a2,1
     f7c:	bf39                	j	e9a <__udivdi3+0x182>
	  count_leading_zeros (bm, d1);
     f7e:	010005b7          	lui	a1,0x1000
     f82:	4741                	li	a4,16
     f84:	fcb6e6e3          	bltu	a3,a1,f50 <__udivdi3+0x238>
     f88:	4761                	li	a4,24
     f8a:	b7d9                	j	f50 <__udivdi3+0x238>
	      d1 = (d1 << bm) | (d0 >> b);
     f8c:	00e65333          	srl	t1,a2,a4
     f90:	00b696b3          	sll	a3,a3,a1
     f94:	00d36333          	or	t1,t1,a3
	      n2 = n1 >> b;
     f98:	00e7d3b3          	srl	t2,a5,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
     f9c:	01035413          	srli	s0,t1,0x10
     fa0:	0283f6b3          	remu	a3,t2,s0
     fa4:	01031513          	slli	a0,t1,0x10
     fa8:	8141                	srli	a0,a0,0x10
	      n1 = (n1 << bm) | (n0 >> b);
     faa:	00e2d733          	srl	a4,t0,a4
     fae:	00b797b3          	sll	a5,a5,a1
     fb2:	8fd9                	or	a5,a5,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
     fb4:	0107d713          	srli	a4,a5,0x10
	      d0 = d0 << bm;
     fb8:	00b61633          	sll	a2,a2,a1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
     fbc:	0283d3b3          	divu	t2,t2,s0
     fc0:	06c2                	slli	a3,a3,0x10
     fc2:	8ed9                	or	a3,a3,a4
     fc4:	027504b3          	mul	s1,a0,t2
     fc8:	871e                	mv	a4,t2
     fca:	0096fc63          	bgeu	a3,s1,fe2 <__udivdi3+0x2ca>
     fce:	969a                	add	a3,a3,t1
     fd0:	fff38713          	addi	a4,t2,-1
     fd4:	0066e763          	bltu	a3,t1,fe2 <__udivdi3+0x2ca>
     fd8:	0096f563          	bgeu	a3,s1,fe2 <__udivdi3+0x2ca>
     fdc:	ffe38713          	addi	a4,t2,-2
     fe0:	969a                	add	a3,a3,t1
     fe2:	8e85                	sub	a3,a3,s1
     fe4:	0286f3b3          	remu	t2,a3,s0
     fe8:	07c2                	slli	a5,a5,0x10
     fea:	83c1                	srli	a5,a5,0x10
     fec:	0286d6b3          	divu	a3,a3,s0
     ff0:	03c2                	slli	t2,t2,0x10
     ff2:	00f3e7b3          	or	a5,t2,a5
     ff6:	02d50533          	mul	a0,a0,a3
     ffa:	83b6                	mv	t2,a3
     ffc:	00a7fc63          	bgeu	a5,a0,1014 <__udivdi3+0x2fc>
    1000:	979a                	add	a5,a5,t1
    1002:	fff68393          	addi	t2,a3,-1
    1006:	0067e763          	bltu	a5,t1,1014 <__udivdi3+0x2fc>
    100a:	00a7f563          	bgeu	a5,a0,1014 <__udivdi3+0x2fc>
    100e:	ffe68393          	addi	t2,a3,-2
    1012:	979a                	add	a5,a5,t1
    1014:	8f89                	sub	a5,a5,a0
	      umul_ppmm (m1, m0, q0, d0);
    1016:	6441                	lui	s0,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    1018:	01071513          	slli	a0,a4,0x10
    101c:	00756533          	or	a0,a0,t2
	      umul_ppmm (m1, m0, q0, d0);
    1020:	fff40713          	addi	a4,s0,-1 # ffff <__ctor_end__+0xadaf>
    1024:	00e573b3          	and	t2,a0,a4
    1028:	01055693          	srli	a3,a0,0x10
    102c:	8f71                	and	a4,a4,a2
    102e:	8241                	srli	a2,a2,0x10
    1030:	02e38333          	mul	t1,t2,a4
    1034:	02e68733          	mul	a4,a3,a4
    1038:	02c383b3          	mul	t2,t2,a2
    103c:	02c686b3          	mul	a3,a3,a2
    1040:	93ba                	add	t2,t2,a4
    1042:	01035613          	srli	a2,t1,0x10
    1046:	961e                	add	a2,a2,t2
    1048:	00e67363          	bgeu	a2,a4,104e <__udivdi3+0x336>
    104c:	96a2                	add	a3,a3,s0
    104e:	01065713          	srli	a4,a2,0x10
    1052:	96ba                	add	a3,a3,a4
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    1054:	02d7e063          	bltu	a5,a3,1074 <__udivdi3+0x35c>
    1058:	d8d796e3          	bne	a5,a3,de4 <__udivdi3+0xcc>
	      umul_ppmm (m1, m0, q0, d0);
    105c:	67c1                	lui	a5,0x10
    105e:	17fd                	addi	a5,a5,-1
    1060:	8e7d                	and	a2,a2,a5
    1062:	0642                	slli	a2,a2,0x10
    1064:	00f37333          	and	t1,t1,a5
	      n0 = n0 << bm;
    1068:	00b292b3          	sll	t0,t0,a1
	      umul_ppmm (m1, m0, q0, d0);
    106c:	961a                	add	a2,a2,t1
	      q1 = 0;
    106e:	4581                	li	a1,0
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    1070:	e2c2f5e3          	bgeu	t0,a2,e9a <__udivdi3+0x182>
		  q0--;
    1074:	157d                	addi	a0,a0,-1
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
    1076:	b3bd                	j	de4 <__udivdi3+0xcc>
	  q1 = 0;
    1078:	4581                	li	a1,0
	  q0 = 0;
    107a:	4501                	li	a0,0
    107c:	bd39                	j	e9a <__udivdi3+0x182>

0000107e <__umoddi3>:
{
    107e:	1151                	addi	sp,sp,-12
    1080:	c422                	sw	s0,8(sp)
    1082:	c226                	sw	s1,4(sp)
  n0 = nn.s.low;
    1084:	87aa                	mv	a5,a0
  n1 = nn.s.high;
    1086:	872e                	mv	a4,a1
  if (d1 == 0)
    1088:	1c069963          	bnez	a3,125a <__umoddi3+0x1dc>
    108c:	8336                	mv	t1,a3
      if (d0 > n1)
    108e:	6695                	lui	a3,0x5
    1090:	8432                	mv	s0,a2
    1092:	82868693          	addi	a3,a3,-2008 # 4828 <__clz_tab>
    1096:	0ac5fa63          	bgeu	a1,a2,114a <__umoddi3+0xcc>
	  count_leading_zeros (bm, d0);
    109a:	62c1                	lui	t0,0x10
    109c:	0a567063          	bgeu	a2,t0,113c <__umoddi3+0xbe>
    10a0:	0ff00293          	li	t0,255
    10a4:	00c2f363          	bgeu	t0,a2,10aa <__umoddi3+0x2c>
    10a8:	4321                	li	t1,8
    10aa:	006652b3          	srl	t0,a2,t1
    10ae:	9696                	add	a3,a3,t0
    10b0:	0006c683          	lbu	a3,0(a3)
    10b4:	9336                	add	t1,t1,a3
    10b6:	02000693          	li	a3,32
    10ba:	406682b3          	sub	t0,a3,t1
	  if (bm != 0)
    10be:	00668c63          	beq	a3,t1,10d6 <__umoddi3+0x58>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    10c2:	005595b3          	sll	a1,a1,t0
    10c6:	00655333          	srl	t1,a0,t1
	      d0 = d0 << bm;
    10ca:	00561433          	sll	s0,a2,t0
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    10ce:	00b36733          	or	a4,t1,a1
	      n0 = n0 << bm;
    10d2:	005517b3          	sll	a5,a0,t0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    10d6:	01045393          	srli	t2,s0,0x10
    10da:	02777633          	remu	a2,a4,t2
    10de:	01041513          	slli	a0,s0,0x10
    10e2:	8141                	srli	a0,a0,0x10
    10e4:	0107d693          	srli	a3,a5,0x10
    10e8:	02775733          	divu	a4,a4,t2
    10ec:	0642                	slli	a2,a2,0x10
    10ee:	8ed1                	or	a3,a3,a2
    10f0:	02e50733          	mul	a4,a0,a4
    10f4:	00e6f863          	bgeu	a3,a4,1104 <__umoddi3+0x86>
    10f8:	96a2                	add	a3,a3,s0
    10fa:	0086e563          	bltu	a3,s0,1104 <__umoddi3+0x86>
    10fe:	00e6f363          	bgeu	a3,a4,1104 <__umoddi3+0x86>
    1102:	96a2                	add	a3,a3,s0
    1104:	8e99                	sub	a3,a3,a4
    1106:	0276f733          	remu	a4,a3,t2
    110a:	07c2                	slli	a5,a5,0x10
    110c:	83c1                	srli	a5,a5,0x10
    110e:	0276d6b3          	divu	a3,a3,t2
    1112:	02d506b3          	mul	a3,a0,a3
    1116:	01071513          	slli	a0,a4,0x10
    111a:	8fc9                	or	a5,a5,a0
    111c:	00d7f863          	bgeu	a5,a3,112c <__umoddi3+0xae>
    1120:	97a2                	add	a5,a5,s0
    1122:	0087e563          	bltu	a5,s0,112c <__umoddi3+0xae>
    1126:	00d7f363          	bgeu	a5,a3,112c <__umoddi3+0xae>
    112a:	97a2                	add	a5,a5,s0
    112c:	8f95                	sub	a5,a5,a3
	  rr.s.low = n0 >> bm;
    112e:	0057d533          	srl	a0,a5,t0
	  *rp = rr.ll;
    1132:	4581                	li	a1,0
}
    1134:	4422                	lw	s0,8(sp)
    1136:	4492                	lw	s1,4(sp)
    1138:	0131                	addi	sp,sp,12
    113a:	8082                	ret
	  count_leading_zeros (bm, d0);
    113c:	010002b7          	lui	t0,0x1000
    1140:	4341                	li	t1,16
    1142:	f65664e3          	bltu	a2,t0,10aa <__umoddi3+0x2c>
    1146:	4361                	li	t1,24
    1148:	b78d                	j	10aa <__umoddi3+0x2c>
	  if (d0 == 0)
    114a:	e601                	bnez	a2,1152 <__umoddi3+0xd4>
	    d0 = 1 / d0;	/* Divide intentionally by zero.  */
    114c:	4705                	li	a4,1
    114e:	02c75433          	divu	s0,a4,a2
	  count_leading_zeros (bm, d0);
    1152:	6741                	lui	a4,0x10
    1154:	08e47163          	bgeu	s0,a4,11d6 <__umoddi3+0x158>
    1158:	0ff00713          	li	a4,255
    115c:	00877363          	bgeu	a4,s0,1162 <__umoddi3+0xe4>
    1160:	4321                	li	t1,8
    1162:	00645733          	srl	a4,s0,t1
    1166:	96ba                	add	a3,a3,a4
    1168:	0006c603          	lbu	a2,0(a3)
    116c:	02000713          	li	a4,32
    1170:	9332                	add	t1,t1,a2
    1172:	406702b3          	sub	t0,a4,t1
	  if (bm == 0)
    1176:	06671763          	bne	a4,t1,11e4 <__umoddi3+0x166>
	      n1 -= d0;
    117a:	8d81                	sub	a1,a1,s0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    117c:	01045693          	srli	a3,s0,0x10
    1180:	01041513          	slli	a0,s0,0x10
    1184:	8141                	srli	a0,a0,0x10
    1186:	0107d613          	srli	a2,a5,0x10
    118a:	02d5f733          	remu	a4,a1,a3
    118e:	02d5d5b3          	divu	a1,a1,a3
    1192:	0742                	slli	a4,a4,0x10
    1194:	8f51                	or	a4,a4,a2
    1196:	02b505b3          	mul	a1,a0,a1
    119a:	00b77863          	bgeu	a4,a1,11aa <__umoddi3+0x12c>
    119e:	9722                	add	a4,a4,s0
    11a0:	00876563          	bltu	a4,s0,11aa <__umoddi3+0x12c>
    11a4:	00b77363          	bgeu	a4,a1,11aa <__umoddi3+0x12c>
    11a8:	9722                	add	a4,a4,s0
    11aa:	40b705b3          	sub	a1,a4,a1
    11ae:	02d5f733          	remu	a4,a1,a3
    11b2:	07c2                	slli	a5,a5,0x10
    11b4:	83c1                	srli	a5,a5,0x10
    11b6:	02d5d5b3          	divu	a1,a1,a3
    11ba:	0742                	slli	a4,a4,0x10
    11bc:	8fd9                	or	a5,a5,a4
    11be:	02b50533          	mul	a0,a0,a1
    11c2:	00a7f863          	bgeu	a5,a0,11d2 <__umoddi3+0x154>
    11c6:	97a2                	add	a5,a5,s0
    11c8:	0087e563          	bltu	a5,s0,11d2 <__umoddi3+0x154>
    11cc:	00a7f363          	bgeu	a5,a0,11d2 <__umoddi3+0x154>
    11d0:	97a2                	add	a5,a5,s0
    11d2:	8f89                	sub	a5,a5,a0
    11d4:	bfa9                	j	112e <__umoddi3+0xb0>
	  count_leading_zeros (bm, d0);
    11d6:	01000737          	lui	a4,0x1000
    11da:	4341                	li	t1,16
    11dc:	f8e463e3          	bltu	s0,a4,1162 <__umoddi3+0xe4>
    11e0:	4361                	li	t1,24
    11e2:	b741                	j	1162 <__umoddi3+0xe4>
	      d0 = d0 << bm;
    11e4:	00541433          	sll	s0,s0,t0
	      n2 = n1 >> b;
    11e8:	0065d6b3          	srl	a3,a1,t1
	      n0 = n0 << bm;
    11ec:	005517b3          	sll	a5,a0,t0
	      n1 = (n1 << bm) | (n0 >> b);
    11f0:	00655333          	srl	t1,a0,t1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    11f4:	01045513          	srli	a0,s0,0x10
    11f8:	02a6f733          	remu	a4,a3,a0
	      n1 = (n1 << bm) | (n0 >> b);
    11fc:	005595b3          	sll	a1,a1,t0
    1200:	00b36633          	or	a2,t1,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    1204:	01041593          	slli	a1,s0,0x10
    1208:	81c1                	srli	a1,a1,0x10
    120a:	01065313          	srli	t1,a2,0x10
    120e:	02a6d6b3          	divu	a3,a3,a0
    1212:	0742                	slli	a4,a4,0x10
    1214:	00676733          	or	a4,a4,t1
    1218:	02d586b3          	mul	a3,a1,a3
    121c:	00d77863          	bgeu	a4,a3,122c <__umoddi3+0x1ae>
    1220:	9722                	add	a4,a4,s0
    1222:	00876563          	bltu	a4,s0,122c <__umoddi3+0x1ae>
    1226:	00d77363          	bgeu	a4,a3,122c <__umoddi3+0x1ae>
    122a:	9722                	add	a4,a4,s0
    122c:	40d706b3          	sub	a3,a4,a3
    1230:	02a6f733          	remu	a4,a3,a0
    1234:	02a6d6b3          	divu	a3,a3,a0
    1238:	0742                	slli	a4,a4,0x10
    123a:	02d586b3          	mul	a3,a1,a3
    123e:	01061593          	slli	a1,a2,0x10
    1242:	81c1                	srli	a1,a1,0x10
    1244:	8dd9                	or	a1,a1,a4
    1246:	00d5f863          	bgeu	a1,a3,1256 <__umoddi3+0x1d8>
    124a:	95a2                	add	a1,a1,s0
    124c:	0085e563          	bltu	a1,s0,1256 <__umoddi3+0x1d8>
    1250:	00d5f363          	bgeu	a1,a3,1256 <__umoddi3+0x1d8>
    1254:	95a2                	add	a1,a1,s0
    1256:	8d95                	sub	a1,a1,a3
    1258:	b715                	j	117c <__umoddi3+0xfe>
      if (d1 > n1)
    125a:	ecd5ede3          	bltu	a1,a3,1134 <__umoddi3+0xb6>
	  count_leading_zeros (bm, d1);
    125e:	6341                	lui	t1,0x10
    1260:	0466f463          	bgeu	a3,t1,12a8 <__umoddi3+0x22a>
    1264:	0ff00293          	li	t0,255
    1268:	00d2b333          	sltu	t1,t0,a3
    126c:	030e                	slli	t1,t1,0x3
    126e:	6295                	lui	t0,0x5
    1270:	0066d3b3          	srl	t2,a3,t1
    1274:	82828293          	addi	t0,t0,-2008 # 4828 <__clz_tab>
    1278:	929e                	add	t0,t0,t2
    127a:	0002c283          	lbu	t0,0(t0)
    127e:	929a                	add	t0,t0,t1
    1280:	02000313          	li	t1,32
    1284:	405303b3          	sub	t2,t1,t0
	  if (bm == 0)
    1288:	02531763          	bne	t1,t0,12b6 <__umoddi3+0x238>
	      if (n1 > d1 || n0 >= d0)
    128c:	00b6e463          	bltu	a3,a1,1294 <__umoddi3+0x216>
    1290:	00c56963          	bltu	a0,a2,12a2 <__umoddi3+0x224>
		  sub_ddmmss (n1, n0, n1, n0, d1, d0);
    1294:	40c507b3          	sub	a5,a0,a2
    1298:	8d95                	sub	a1,a1,a3
    129a:	00f53533          	sltu	a0,a0,a5
    129e:	40a58733          	sub	a4,a1,a0
		  *rp = rr.ll;
    12a2:	853e                	mv	a0,a5
    12a4:	85ba                	mv	a1,a4
    12a6:	b579                	j	1134 <__umoddi3+0xb6>
	  count_leading_zeros (bm, d1);
    12a8:	010002b7          	lui	t0,0x1000
    12ac:	4341                	li	t1,16
    12ae:	fc56e0e3          	bltu	a3,t0,126e <__umoddi3+0x1f0>
    12b2:	4361                	li	t1,24
    12b4:	bf6d                	j	126e <__umoddi3+0x1f0>
	      d1 = (d1 << bm) | (d0 >> b);
    12b6:	007696b3          	sll	a3,a3,t2
    12ba:	00565333          	srl	t1,a2,t0
    12be:	00d36333          	or	t1,t1,a3
	      n2 = n1 >> b;
    12c2:	0055d4b3          	srl	s1,a1,t0
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    12c6:	01035413          	srli	s0,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
    12ca:	00555733          	srl	a4,a0,t0
	      n0 = n0 << bm;
    12ce:	007517b3          	sll	a5,a0,t2
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    12d2:	0284d533          	divu	a0,s1,s0
	      n0 = n0 << bm;
    12d6:	c03e                	sw	a5,0(sp)
	      n1 = (n1 << bm) | (n0 >> b);
    12d8:	007595b3          	sll	a1,a1,t2
    12dc:	8dd9                	or	a1,a1,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    12de:	01031713          	slli	a4,t1,0x10
    12e2:	8341                	srli	a4,a4,0x10
	      d0 = d0 << bm;
    12e4:	00761633          	sll	a2,a2,t2
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    12e8:	0284f7b3          	remu	a5,s1,s0
    12ec:	02a704b3          	mul	s1,a4,a0
    12f0:	01079693          	slli	a3,a5,0x10
    12f4:	0105d793          	srli	a5,a1,0x10
    12f8:	8fd5                	or	a5,a5,a3
    12fa:	86aa                	mv	a3,a0
    12fc:	0097fc63          	bgeu	a5,s1,1314 <__umoddi3+0x296>
    1300:	979a                	add	a5,a5,t1
    1302:	fff50693          	addi	a3,a0,-1
    1306:	0067e763          	bltu	a5,t1,1314 <__umoddi3+0x296>
    130a:	0097f563          	bgeu	a5,s1,1314 <__umoddi3+0x296>
    130e:	ffe50693          	addi	a3,a0,-2
    1312:	979a                	add	a5,a5,t1
    1314:	8f85                	sub	a5,a5,s1
    1316:	0287f533          	remu	a0,a5,s0
    131a:	05c2                	slli	a1,a1,0x10
    131c:	81c1                	srli	a1,a1,0x10
    131e:	0287d433          	divu	s0,a5,s0
    1322:	0542                	slli	a0,a0,0x10
    1324:	8dc9                	or	a1,a1,a0
    1326:	02870733          	mul	a4,a4,s0
    132a:	87a2                	mv	a5,s0
    132c:	00e5fc63          	bgeu	a1,a4,1344 <__umoddi3+0x2c6>
    1330:	959a                	add	a1,a1,t1
    1332:	fff40793          	addi	a5,s0,-1
    1336:	0065e763          	bltu	a1,t1,1344 <__umoddi3+0x2c6>
    133a:	00e5f563          	bgeu	a1,a4,1344 <__umoddi3+0x2c6>
    133e:	ffe40793          	addi	a5,s0,-2
    1342:	959a                	add	a1,a1,t1
    1344:	06c2                	slli	a3,a3,0x10
	      umul_ppmm (m1, m0, q0, d0);
    1346:	6441                	lui	s0,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    1348:	8edd                	or	a3,a3,a5
    134a:	40e58733          	sub	a4,a1,a4
	      umul_ppmm (m1, m0, q0, d0);
    134e:	fff40593          	addi	a1,s0,-1 # ffff <__ctor_end__+0xadaf>
    1352:	00b6f7b3          	and	a5,a3,a1
    1356:	01065493          	srli	s1,a2,0x10
    135a:	82c1                	srli	a3,a3,0x10
    135c:	8df1                	and	a1,a1,a2
    135e:	02b78533          	mul	a0,a5,a1
    1362:	02b685b3          	mul	a1,a3,a1
    1366:	029787b3          	mul	a5,a5,s1
    136a:	029686b3          	mul	a3,a3,s1
    136e:	97ae                	add	a5,a5,a1
    1370:	01055493          	srli	s1,a0,0x10
    1374:	97a6                	add	a5,a5,s1
    1376:	00b7f363          	bgeu	a5,a1,137c <__umoddi3+0x2fe>
    137a:	96a2                	add	a3,a3,s0
    137c:	0107d593          	srli	a1,a5,0x10
    1380:	96ae                	add	a3,a3,a1
    1382:	65c1                	lui	a1,0x10
    1384:	15fd                	addi	a1,a1,-1
    1386:	8fed                	and	a5,a5,a1
    1388:	07c2                	slli	a5,a5,0x10
    138a:	8d6d                	and	a0,a0,a1
    138c:	953e                	add	a0,a0,a5
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    138e:	00d76763          	bltu	a4,a3,139c <__umoddi3+0x31e>
    1392:	00d71d63          	bne	a4,a3,13ac <__umoddi3+0x32e>
    1396:	4782                	lw	a5,0(sp)
    1398:	00a7fa63          	bgeu	a5,a0,13ac <__umoddi3+0x32e>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
    139c:	40c50633          	sub	a2,a0,a2
    13a0:	00c53533          	sltu	a0,a0,a2
    13a4:	932a                	add	t1,t1,a0
    13a6:	406686b3          	sub	a3,a3,t1
    13aa:	8532                	mv	a0,a2
		  sub_ddmmss (n1, n0, n1, n0, m1, m0);
    13ac:	4782                	lw	a5,0(sp)
    13ae:	40d706b3          	sub	a3,a4,a3
    13b2:	40a78533          	sub	a0,a5,a0
    13b6:	00a7b5b3          	sltu	a1,a5,a0
    13ba:	40b685b3          	sub	a1,a3,a1
		  rr.s.low = (n1 << b) | (n0 >> bm);
    13be:	005597b3          	sll	a5,a1,t0
    13c2:	00755533          	srl	a0,a0,t2
		  *rp = rr.ll;
    13c6:	8d5d                	or	a0,a0,a5
    13c8:	0075d5b3          	srl	a1,a1,t2
    13cc:	b3a5                	j	1134 <__umoddi3+0xb6>

000013ce <__adddf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
    13ce:	00100337          	lui	t1,0x100
    13d2:	137d                	addi	t1,t1,-1
{
    13d4:	1131                	addi	sp,sp,-20
  FP_UNPACK_SEMIRAW_D (A, a);
    13d6:	00b377b3          	and	a5,t1,a1
    13da:	0145d713          	srli	a4,a1,0x14
{
    13de:	c426                	sw	s1,8(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
    13e0:	078e                	slli	a5,a5,0x3
    13e2:	7ff77493          	andi	s1,a4,2047
    13e6:	01d55713          	srli	a4,a0,0x1d
    13ea:	8fd9                	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
    13ec:	00d37733          	and	a4,t1,a3
    13f0:	0146d313          	srli	t1,a3,0x14
{
    13f4:	c622                	sw	s0,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    13f6:	7ff37313          	andi	t1,t1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
    13fa:	01f5d413          	srli	s0,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
    13fe:	070e                	slli	a4,a4,0x3
    1400:	01f6d593          	srli	a1,a3,0x1f
{
    1404:	c806                	sw	ra,16(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    1406:	01d65693          	srli	a3,a2,0x1d
    140a:	8f55                	or	a4,a4,a3
  FP_UNPACK_SEMIRAW_D (A, a);
    140c:	050e                	slli	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
    140e:	060e                	slli	a2,a2,0x3
  FP_ADD_D (R, A, B);
    1410:	406486b3          	sub	a3,s1,t1
    1414:	22b41463          	bne	s0,a1,163c <__adddf3+0x26e>
    1418:	0ed05263          	blez	a3,14fc <__adddf3+0x12e>
    141c:	02031863          	bnez	t1,144c <__adddf3+0x7e>
    1420:	00c765b3          	or	a1,a4,a2
    1424:	20058a63          	beqz	a1,1638 <__adddf3+0x26a>
    1428:	fff68593          	addi	a1,a3,-1
    142c:	e989                	bnez	a1,143e <__adddf3+0x70>
    142e:	962a                	add	a2,a2,a0
    1430:	00a63533          	sltu	a0,a2,a0
    1434:	97ba                	add	a5,a5,a4
    1436:	97aa                	add	a5,a5,a0
    1438:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    143a:	4485                	li	s1,1
  FP_ADD_D (R, A, B);
    143c:	a8b9                	j	149a <__adddf3+0xcc>
    143e:	7ff00313          	li	t1,2047
    1442:	00669d63          	bne	a3,t1,145c <__adddf3+0x8e>
    1446:	7ff00493          	li	s1,2047
    144a:	aa71                	j	15e6 <__adddf3+0x218>
    144c:	7ff00593          	li	a1,2047
    1450:	18b48b63          	beq	s1,a1,15e6 <__adddf3+0x218>
    1454:	008005b7          	lui	a1,0x800
    1458:	8f4d                	or	a4,a4,a1
    145a:	85b6                	mv	a1,a3
    145c:	03800693          	li	a3,56
    1460:	08b6ca63          	blt	a3,a1,14f4 <__adddf3+0x126>
    1464:	46fd                	li	a3,31
    1466:	06b6c163          	blt	a3,a1,14c8 <__adddf3+0xfa>
    146a:	02000313          	li	t1,32
    146e:	40b30333          	sub	t1,t1,a1
    1472:	006716b3          	sll	a3,a4,t1
    1476:	00b652b3          	srl	t0,a2,a1
    147a:	00661633          	sll	a2,a2,t1
    147e:	0056e6b3          	or	a3,a3,t0
    1482:	00c03633          	snez	a2,a2
    1486:	8e55                	or	a2,a2,a3
    1488:	00b75733          	srl	a4,a4,a1
    148c:	962a                	add	a2,a2,a0
    148e:	00a63533          	sltu	a0,a2,a0
    1492:	973e                	add	a4,a4,a5
    1494:	00a707b3          	add	a5,a4,a0
    1498:	8532                	mv	a0,a2
    149a:	00800737          	lui	a4,0x800
    149e:	8f7d                	and	a4,a4,a5
    14a0:	14070363          	beqz	a4,15e6 <__adddf3+0x218>
    14a4:	0485                	addi	s1,s1,1
    14a6:	7ff00713          	li	a4,2047
    14aa:	48e48b63          	beq	s1,a4,1940 <__adddf3+0x572>
    14ae:	ff800737          	lui	a4,0xff800
    14b2:	177d                	addi	a4,a4,-1
    14b4:	8ff9                	and	a5,a5,a4
    14b6:	00155713          	srli	a4,a0,0x1
    14ba:	8905                	andi	a0,a0,1
    14bc:	8d59                	or	a0,a0,a4
    14be:	01f79713          	slli	a4,a5,0x1f
    14c2:	8d59                	or	a0,a0,a4
    14c4:	8385                	srli	a5,a5,0x1
    14c6:	a205                	j	15e6 <__adddf3+0x218>
    14c8:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    14cc:	02000293          	li	t0,32
    14d0:	00d756b3          	srl	a3,a4,a3
    14d4:	4301                	li	t1,0
    14d6:	00558863          	beq	a1,t0,14e6 <__adddf3+0x118>
    14da:	04000313          	li	t1,64
    14de:	40b305b3          	sub	a1,t1,a1
    14e2:	00b71333          	sll	t1,a4,a1
    14e6:	00c36633          	or	a2,t1,a2
    14ea:	00c03633          	snez	a2,a2
    14ee:	8e55                	or	a2,a2,a3
    14f0:	4701                	li	a4,0
    14f2:	bf69                	j	148c <__adddf3+0xbe>
    14f4:	8e59                	or	a2,a2,a4
    14f6:	00c03633          	snez	a2,a2
    14fa:	bfdd                	j	14f0 <__adddf3+0x122>
    14fc:	cacd                	beqz	a3,15ae <__adddf3+0x1e0>
    14fe:	409305b3          	sub	a1,t1,s1
    1502:	e48d                	bnez	s1,152c <__adddf3+0x15e>
    1504:	00a7e6b3          	or	a3,a5,a0
    1508:	42068363          	beqz	a3,192e <__adddf3+0x560>
    150c:	fff58693          	addi	a3,a1,-1
    1510:	e699                	bnez	a3,151e <__adddf3+0x150>
    1512:	9532                	add	a0,a0,a2
    1514:	97ba                	add	a5,a5,a4
    1516:	00c53633          	sltu	a2,a0,a2
    151a:	97b2                	add	a5,a5,a2
    151c:	bf39                	j	143a <__adddf3+0x6c>
    151e:	7ff00293          	li	t0,2047
    1522:	00559d63          	bne	a1,t0,153c <__adddf3+0x16e>
  FP_UNPACK_SEMIRAW_D (B, b);
    1526:	87ba                	mv	a5,a4
    1528:	8532                	mv	a0,a2
    152a:	bf31                	j	1446 <__adddf3+0x78>
  FP_ADD_D (R, A, B);
    152c:	7ff00693          	li	a3,2047
    1530:	fed30be3          	beq	t1,a3,1526 <__adddf3+0x158>
    1534:	008006b7          	lui	a3,0x800
    1538:	8fd5                	or	a5,a5,a3
    153a:	86ae                	mv	a3,a1
    153c:	03800593          	li	a1,56
    1540:	06d5c363          	blt	a1,a3,15a6 <__adddf3+0x1d8>
    1544:	45fd                	li	a1,31
    1546:	02d5ca63          	blt	a1,a3,157a <__adddf3+0x1ac>
    154a:	02000293          	li	t0,32
    154e:	40d282b3          	sub	t0,t0,a3
    1552:	005795b3          	sll	a1,a5,t0
    1556:	00d553b3          	srl	t2,a0,a3
    155a:	00551533          	sll	a0,a0,t0
    155e:	0075e5b3          	or	a1,a1,t2
    1562:	00a03533          	snez	a0,a0
    1566:	8d4d                	or	a0,a0,a1
    1568:	00d7d7b3          	srl	a5,a5,a3
    156c:	9532                	add	a0,a0,a2
    156e:	97ba                	add	a5,a5,a4
    1570:	00c53633          	sltu	a2,a0,a2
    1574:	97b2                	add	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    1576:	849a                	mv	s1,t1
    1578:	b70d                	j	149a <__adddf3+0xcc>
  FP_ADD_D (R, A, B);
    157a:	fe068593          	addi	a1,a3,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    157e:	02000393          	li	t2,32
    1582:	00b7d5b3          	srl	a1,a5,a1
    1586:	4281                	li	t0,0
    1588:	00768863          	beq	a3,t2,1598 <__adddf3+0x1ca>
    158c:	04000293          	li	t0,64
    1590:	40d286b3          	sub	a3,t0,a3
    1594:	00d792b3          	sll	t0,a5,a3
    1598:	00a2e533          	or	a0,t0,a0
    159c:	00a03533          	snez	a0,a0
    15a0:	8d4d                	or	a0,a0,a1
    15a2:	4781                	li	a5,0
    15a4:	b7e1                	j	156c <__adddf3+0x19e>
    15a6:	8d5d                	or	a0,a0,a5
    15a8:	00a03533          	snez	a0,a0
    15ac:	bfdd                	j	15a2 <__adddf3+0x1d4>
    15ae:	00148693          	addi	a3,s1,1 # 80000001 <__bss_end__+0x5fffe051>
    15b2:	7fe6f593          	andi	a1,a3,2046
    15b6:	e1bd                	bnez	a1,161c <__adddf3+0x24e>
    15b8:	00a7e6b3          	or	a3,a5,a0
    15bc:	e4a9                	bnez	s1,1606 <__adddf3+0x238>
    15be:	36068c63          	beqz	a3,1936 <__adddf3+0x568>
    15c2:	00c766b3          	or	a3,a4,a2
    15c6:	c285                	beqz	a3,15e6 <__adddf3+0x218>
    15c8:	962a                	add	a2,a2,a0
    15ca:	97ba                	add	a5,a5,a4
    15cc:	00a63533          	sltu	a0,a2,a0
    15d0:	97aa                	add	a5,a5,a0
    15d2:	00800737          	lui	a4,0x800
    15d6:	8f7d                	and	a4,a4,a5
    15d8:	8532                	mv	a0,a2
    15da:	c711                	beqz	a4,15e6 <__adddf3+0x218>
    15dc:	ff800737          	lui	a4,0xff800
    15e0:	177d                	addi	a4,a4,-1
    15e2:	8ff9                	and	a5,a5,a4
    15e4:	4485                	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
    15e6:	00757713          	andi	a4,a0,7
    15ea:	34070d63          	beqz	a4,1944 <__adddf3+0x576>
    15ee:	00f57713          	andi	a4,a0,15
    15f2:	4691                	li	a3,4
    15f4:	34d70863          	beq	a4,a3,1944 <__adddf3+0x576>
    15f8:	00450713          	addi	a4,a0,4
    15fc:	00a73533          	sltu	a0,a4,a0
    1600:	97aa                	add	a5,a5,a0
    1602:	853a                	mv	a0,a4
    1604:	a681                	j	1944 <__adddf3+0x576>
  FP_ADD_D (R, A, B);
    1606:	d285                	beqz	a3,1526 <__adddf3+0x158>
    1608:	8e59                	or	a2,a2,a4
    160a:	e2060ee3          	beqz	a2,1446 <__adddf3+0x78>
    160e:	4401                	li	s0,0
    1610:	004007b7          	lui	a5,0x400
    1614:	4501                	li	a0,0
    1616:	7ff00493          	li	s1,2047
    161a:	a62d                	j	1944 <__adddf3+0x576>
    161c:	7ff00593          	li	a1,2047
    1620:	30b68e63          	beq	a3,a1,193c <__adddf3+0x56e>
    1624:	962a                	add	a2,a2,a0
    1626:	00a63533          	sltu	a0,a2,a0
    162a:	97ba                	add	a5,a5,a4
    162c:	97aa                	add	a5,a5,a0
    162e:	01f79513          	slli	a0,a5,0x1f
    1632:	8205                	srli	a2,a2,0x1
    1634:	8d51                	or	a0,a0,a2
    1636:	8385                	srli	a5,a5,0x1
    1638:	84b6                	mv	s1,a3
    163a:	b775                	j	15e6 <__adddf3+0x218>
    163c:	0cd05463          	blez	a3,1704 <__adddf3+0x336>
    1640:	06031f63          	bnez	t1,16be <__adddf3+0x2f0>
    1644:	00c765b3          	or	a1,a4,a2
    1648:	d9e5                	beqz	a1,1638 <__adddf3+0x26a>
    164a:	fff68593          	addi	a1,a3,-1
    164e:	e991                	bnez	a1,1662 <__adddf3+0x294>
    1650:	40c50633          	sub	a2,a0,a2
    1654:	00c53533          	sltu	a0,a0,a2
    1658:	8f99                	sub	a5,a5,a4
    165a:	8f89                	sub	a5,a5,a0
    165c:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    165e:	4485                	li	s1,1
  FP_ADD_D (R, A, B);
    1660:	a0b1                	j	16ac <__adddf3+0x2de>
    1662:	7ff00313          	li	t1,2047
    1666:	de6680e3          	beq	a3,t1,1446 <__adddf3+0x78>
    166a:	03800693          	li	a3,56
    166e:	08b6c763          	blt	a3,a1,16fc <__adddf3+0x32e>
    1672:	46fd                	li	a3,31
    1674:	04b6ce63          	blt	a3,a1,16d0 <__adddf3+0x302>
    1678:	02000313          	li	t1,32
    167c:	40b30333          	sub	t1,t1,a1
    1680:	006716b3          	sll	a3,a4,t1
    1684:	00b652b3          	srl	t0,a2,a1
    1688:	00661633          	sll	a2,a2,t1
    168c:	0056e6b3          	or	a3,a3,t0
    1690:	00c03633          	snez	a2,a2
    1694:	8e55                	or	a2,a2,a3
    1696:	00b75733          	srl	a4,a4,a1
    169a:	40c50633          	sub	a2,a0,a2
    169e:	00c53533          	sltu	a0,a0,a2
    16a2:	40e78733          	sub	a4,a5,a4
    16a6:	40a707b3          	sub	a5,a4,a0
    16aa:	8532                	mv	a0,a2
    16ac:	008006b7          	lui	a3,0x800
    16b0:	00d7f733          	and	a4,a5,a3
    16b4:	db0d                	beqz	a4,15e6 <__adddf3+0x218>
    16b6:	16fd                	addi	a3,a3,-1
    16b8:	8efd                	and	a3,a3,a5
    16ba:	832a                	mv	t1,a0
    16bc:	aa55                	j	1870 <__adddf3+0x4a2>
    16be:	7ff00593          	li	a1,2047
    16c2:	f2b482e3          	beq	s1,a1,15e6 <__adddf3+0x218>
    16c6:	008005b7          	lui	a1,0x800
    16ca:	8f4d                	or	a4,a4,a1
    16cc:	85b6                	mv	a1,a3
    16ce:	bf71                	j	166a <__adddf3+0x29c>
    16d0:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    16d4:	02000293          	li	t0,32
    16d8:	00d756b3          	srl	a3,a4,a3
    16dc:	4301                	li	t1,0
    16de:	00558863          	beq	a1,t0,16ee <__adddf3+0x320>
    16e2:	04000313          	li	t1,64
    16e6:	40b305b3          	sub	a1,t1,a1
    16ea:	00b71333          	sll	t1,a4,a1
    16ee:	00c36633          	or	a2,t1,a2
    16f2:	00c03633          	snez	a2,a2
    16f6:	8e55                	or	a2,a2,a3
    16f8:	4701                	li	a4,0
    16fa:	b745                	j	169a <__adddf3+0x2cc>
    16fc:	8e59                	or	a2,a2,a4
    16fe:	00c03633          	snez	a2,a2
    1702:	bfdd                	j	16f8 <__adddf3+0x32a>
    1704:	c2f9                	beqz	a3,17ca <__adddf3+0x3fc>
    1706:	409302b3          	sub	t0,t1,s1
    170a:	e895                	bnez	s1,173e <__adddf3+0x370>
    170c:	00a7e6b3          	or	a3,a5,a0
    1710:	28068863          	beqz	a3,19a0 <__adddf3+0x5d2>
    1714:	fff28693          	addi	a3,t0,-1 # ffffff <__ctor_end__+0xffadaf>
    1718:	ea91                	bnez	a3,172c <__adddf3+0x35e>
    171a:	40a60533          	sub	a0,a2,a0
    171e:	40f707b3          	sub	a5,a4,a5
    1722:	00a63633          	sltu	a2,a2,a0
    1726:	8f91                	sub	a5,a5,a2
    1728:	842e                	mv	s0,a1
    172a:	bf15                	j	165e <__adddf3+0x290>
    172c:	7ff00393          	li	t2,2047
    1730:	00729f63          	bne	t0,t2,174e <__adddf3+0x380>
  FP_UNPACK_SEMIRAW_D (B, b);
    1734:	87ba                	mv	a5,a4
    1736:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    1738:	7ff00493          	li	s1,2047
    173c:	a07d                	j	17ea <__adddf3+0x41c>
    173e:	7ff00693          	li	a3,2047
    1742:	fed309e3          	beq	t1,a3,1734 <__adddf3+0x366>
    1746:	008006b7          	lui	a3,0x800
    174a:	8fd5                	or	a5,a5,a3
    174c:	8696                	mv	a3,t0
    174e:	03800293          	li	t0,56
    1752:	06d2c863          	blt	t0,a3,17c2 <__adddf3+0x3f4>
    1756:	42fd                	li	t0,31
    1758:	02d2ce63          	blt	t0,a3,1794 <__adddf3+0x3c6>
    175c:	02000393          	li	t2,32
    1760:	40d383b3          	sub	t2,t2,a3
    1764:	007792b3          	sll	t0,a5,t2
    1768:	00d55433          	srl	s0,a0,a3
    176c:	00751533          	sll	a0,a0,t2
    1770:	0082e2b3          	or	t0,t0,s0
    1774:	00a03533          	snez	a0,a0
    1778:	00a2e533          	or	a0,t0,a0
    177c:	00d7d7b3          	srl	a5,a5,a3
    1780:	40a60533          	sub	a0,a2,a0
    1784:	40f707b3          	sub	a5,a4,a5
    1788:	00a63633          	sltu	a2,a2,a0
    178c:	8f91                	sub	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    178e:	849a                	mv	s1,t1
    1790:	842e                	mv	s0,a1
    1792:	bf29                	j	16ac <__adddf3+0x2de>
  FP_ADD_D (R, A, B);
    1794:	fe068293          	addi	t0,a3,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    1798:	02000413          	li	s0,32
    179c:	0057d2b3          	srl	t0,a5,t0
    17a0:	4381                	li	t2,0
    17a2:	00868863          	beq	a3,s0,17b2 <__adddf3+0x3e4>
    17a6:	04000393          	li	t2,64
    17aa:	40d386b3          	sub	a3,t2,a3
    17ae:	00d793b3          	sll	t2,a5,a3
    17b2:	00a3e533          	or	a0,t2,a0
    17b6:	00a03533          	snez	a0,a0
    17ba:	00a2e533          	or	a0,t0,a0
    17be:	4781                	li	a5,0
    17c0:	b7c1                	j	1780 <__adddf3+0x3b2>
    17c2:	8d5d                	or	a0,a0,a5
    17c4:	00a03533          	snez	a0,a0
    17c8:	bfdd                	j	17be <__adddf3+0x3f0>
    17ca:	00148693          	addi	a3,s1,1
    17ce:	7fe6f693          	andi	a3,a3,2046
    17d2:	eaa5                	bnez	a3,1842 <__adddf3+0x474>
    17d4:	00a7e333          	or	t1,a5,a0
    17d8:	00c766b3          	or	a3,a4,a2
    17dc:	e8a1                	bnez	s1,182c <__adddf3+0x45e>
    17de:	00031863          	bnez	t1,17ee <__adddf3+0x420>
    17e2:	1c068363          	beqz	a3,19a8 <__adddf3+0x5da>
  FP_UNPACK_SEMIRAW_D (B, b);
    17e6:	87ba                	mv	a5,a4
    17e8:	8532                	mv	a0,a2
    17ea:	842e                	mv	s0,a1
    17ec:	bbed                	j	15e6 <__adddf3+0x218>
  FP_ADD_D (R, A, B);
    17ee:	de068ce3          	beqz	a3,15e6 <__adddf3+0x218>
    17f2:	40c50333          	sub	t1,a0,a2
    17f6:	006532b3          	sltu	t0,a0,t1
    17fa:	40e786b3          	sub	a3,a5,a4
    17fe:	405686b3          	sub	a3,a3,t0
    1802:	008002b7          	lui	t0,0x800
    1806:	0056f2b3          	and	t0,a3,t0
    180a:	00028a63          	beqz	t0,181e <__adddf3+0x450>
    180e:	40a60533          	sub	a0,a2,a0
    1812:	40f707b3          	sub	a5,a4,a5
    1816:	00a63633          	sltu	a2,a2,a0
    181a:	8f91                	sub	a5,a5,a2
    181c:	b7f9                	j	17ea <__adddf3+0x41c>
    181e:	00d36533          	or	a0,t1,a3
    1822:	18050763          	beqz	a0,19b0 <__adddf3+0x5e2>
    1826:	87b6                	mv	a5,a3
    1828:	851a                	mv	a0,t1
    182a:	bb75                	j	15e6 <__adddf3+0x218>
    182c:	00031863          	bnez	t1,183c <__adddf3+0x46e>
    1830:	18068263          	beqz	a3,19b4 <__adddf3+0x5e6>
  FP_UNPACK_SEMIRAW_D (B, b);
    1834:	87ba                	mv	a5,a4
    1836:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    1838:	842e                	mv	s0,a1
    183a:	b131                	j	1446 <__adddf3+0x78>
    183c:	c00685e3          	beqz	a3,1446 <__adddf3+0x78>
    1840:	b3f9                	j	160e <__adddf3+0x240>
    1842:	40c50333          	sub	t1,a0,a2
    1846:	006532b3          	sltu	t0,a0,t1
    184a:	40e786b3          	sub	a3,a5,a4
    184e:	405686b3          	sub	a3,a3,t0
    1852:	008002b7          	lui	t0,0x800
    1856:	0056f2b3          	and	t0,a3,t0
    185a:	06028b63          	beqz	t0,18d0 <__adddf3+0x502>
    185e:	40a60333          	sub	t1,a2,a0
    1862:	40f707b3          	sub	a5,a4,a5
    1866:	00663633          	sltu	a2,a2,t1
    186a:	40c786b3          	sub	a3,a5,a2
    186e:	842e                	mv	s0,a1
    1870:	c6b5                	beqz	a3,18dc <__adddf3+0x50e>
    1872:	8536                	mv	a0,a3
    1874:	c21a                	sw	t1,4(sp)
    1876:	c036                	sw	a3,0(sp)
    1878:	404010ef          	jal	ra,2c7c <__clzsi2>
    187c:	4682                	lw	a3,0(sp)
    187e:	4312                	lw	t1,4(sp)
    1880:	ff850713          	addi	a4,a0,-8
    1884:	47fd                	li	a5,31
    1886:	06e7c563          	blt	a5,a4,18f0 <__adddf3+0x522>
    188a:	02000793          	li	a5,32
    188e:	8f99                	sub	a5,a5,a4
    1890:	00e696b3          	sll	a3,a3,a4
    1894:	00f357b3          	srl	a5,t1,a5
    1898:	8fd5                	or	a5,a5,a3
    189a:	00e31533          	sll	a0,t1,a4
    189e:	08974263          	blt	a4,s1,1922 <__adddf3+0x554>
    18a2:	8f05                	sub	a4,a4,s1
    18a4:	00170613          	addi	a2,a4,1 # ff800001 <__bss_end__+0xdf7fe051>
    18a8:	46fd                	li	a3,31
    18aa:	04c6c963          	blt	a3,a2,18fc <__adddf3+0x52e>
    18ae:	02000713          	li	a4,32
    18b2:	8f11                	sub	a4,a4,a2
    18b4:	00e796b3          	sll	a3,a5,a4
    18b8:	00c555b3          	srl	a1,a0,a2
    18bc:	00e51533          	sll	a0,a0,a4
    18c0:	8ecd                	or	a3,a3,a1
    18c2:	00a03533          	snez	a0,a0
    18c6:	8d55                	or	a0,a0,a3
    18c8:	00c7d7b3          	srl	a5,a5,a2
    18cc:	4481                	li	s1,0
    18ce:	bb21                	j	15e6 <__adddf3+0x218>
    18d0:	00d36533          	or	a0,t1,a3
    18d4:	fd51                	bnez	a0,1870 <__adddf3+0x4a2>
    18d6:	4781                	li	a5,0
    18d8:	4481                	li	s1,0
    18da:	a8c9                	j	19ac <__adddf3+0x5de>
    18dc:	851a                	mv	a0,t1
    18de:	c236                	sw	a3,4(sp)
    18e0:	c01a                	sw	t1,0(sp)
    18e2:	39a010ef          	jal	ra,2c7c <__clzsi2>
    18e6:	4692                	lw	a3,4(sp)
    18e8:	4302                	lw	t1,0(sp)
    18ea:	02050513          	addi	a0,a0,32
    18ee:	bf49                	j	1880 <__adddf3+0x4b2>
    18f0:	fd850793          	addi	a5,a0,-40
    18f4:	00f317b3          	sll	a5,t1,a5
    18f8:	4501                	li	a0,0
    18fa:	b755                	j	189e <__adddf3+0x4d0>
    18fc:	1705                	addi	a4,a4,-31
    18fe:	02000593          	li	a1,32
    1902:	00e7d733          	srl	a4,a5,a4
    1906:	4681                	li	a3,0
    1908:	00b60763          	beq	a2,a1,1916 <__adddf3+0x548>
    190c:	04000693          	li	a3,64
    1910:	8e91                	sub	a3,a3,a2
    1912:	00d796b3          	sll	a3,a5,a3
    1916:	8d55                	or	a0,a0,a3
    1918:	00a03533          	snez	a0,a0
    191c:	8d59                	or	a0,a0,a4
    191e:	4781                	li	a5,0
    1920:	b775                	j	18cc <__adddf3+0x4fe>
    1922:	8c99                	sub	s1,s1,a4
    1924:	ff800737          	lui	a4,0xff800
    1928:	177d                	addi	a4,a4,-1
    192a:	8ff9                	and	a5,a5,a4
    192c:	b96d                	j	15e6 <__adddf3+0x218>
  FP_UNPACK_SEMIRAW_D (B, b);
    192e:	87ba                	mv	a5,a4
    1930:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    1932:	84ae                	mv	s1,a1
    1934:	b94d                	j	15e6 <__adddf3+0x218>
  FP_UNPACK_SEMIRAW_D (B, b);
    1936:	87ba                	mv	a5,a4
    1938:	8532                	mv	a0,a2
    193a:	b175                	j	15e6 <__adddf3+0x218>
    193c:	7ff00493          	li	s1,2047
    1940:	4781                	li	a5,0
    1942:	4501                	li	a0,0
  FP_PACK_SEMIRAW_D (r, R);
    1944:	00800737          	lui	a4,0x800
    1948:	8f7d                	and	a4,a4,a5
    194a:	cb11                	beqz	a4,195e <__adddf3+0x590>
    194c:	0485                	addi	s1,s1,1
    194e:	7ff00713          	li	a4,2047
    1952:	06e48663          	beq	s1,a4,19be <__adddf3+0x5f0>
    1956:	ff800737          	lui	a4,0xff800
    195a:	177d                	addi	a4,a4,-1
    195c:	8ff9                	and	a5,a5,a4
    195e:	01d79713          	slli	a4,a5,0x1d
    1962:	810d                	srli	a0,a0,0x3
    1964:	8d59                	or	a0,a0,a4
    1966:	7ff00713          	li	a4,2047
    196a:	838d                	srli	a5,a5,0x3
    196c:	00e49963          	bne	s1,a4,197e <__adddf3+0x5b0>
    1970:	8d5d                	or	a0,a0,a5
    1972:	4781                	li	a5,0
    1974:	c509                	beqz	a0,197e <__adddf3+0x5b0>
    1976:	000807b7          	lui	a5,0x80
    197a:	4501                	li	a0,0
    197c:	4401                	li	s0,0
    197e:	01449713          	slli	a4,s1,0x14
    1982:	7ff006b7          	lui	a3,0x7ff00
    1986:	07b2                	slli	a5,a5,0xc
    1988:	8f75                	and	a4,a4,a3
    198a:	83b1                	srli	a5,a5,0xc
    198c:	047e                	slli	s0,s0,0x1f
    198e:	8fd9                	or	a5,a5,a4
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    1990:	40c2                	lw	ra,16(sp)
  FP_PACK_SEMIRAW_D (r, R);
    1992:	0087e733          	or	a4,a5,s0
}
    1996:	4432                	lw	s0,12(sp)
    1998:	44a2                	lw	s1,8(sp)
    199a:	85ba                	mv	a1,a4
    199c:	0151                	addi	sp,sp,20
    199e:	8082                	ret
  FP_UNPACK_SEMIRAW_D (B, b);
    19a0:	87ba                	mv	a5,a4
    19a2:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    19a4:	8496                	mv	s1,t0
    19a6:	b591                	j	17ea <__adddf3+0x41c>
    19a8:	4781                	li	a5,0
    19aa:	4501                	li	a0,0
    19ac:	4401                	li	s0,0
    19ae:	bf59                	j	1944 <__adddf3+0x576>
    19b0:	4781                	li	a5,0
    19b2:	bfed                	j	19ac <__adddf3+0x5de>
    19b4:	4501                	li	a0,0
    19b6:	4401                	li	s0,0
    19b8:	004007b7          	lui	a5,0x400
    19bc:	b9a9                	j	1616 <__adddf3+0x248>
    19be:	4781                	li	a5,0
    19c0:	4501                	li	a0,0
    19c2:	bf71                	j	195e <__adddf3+0x590>

000019c4 <__divdf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__divdf3 (DFtype a, DFtype b)
{
    19c4:	fdc10113          	addi	sp,sp,-36
    19c8:	cc26                	sw	s1,24(sp)
    19ca:	872a                	mv	a4,a0
    19cc:	84b2                	mv	s1,a2
    19ce:	87aa                	mv	a5,a0
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
    19d0:	01f5d613          	srli	a2,a1,0x1f
    19d4:	0145d513          	srli	a0,a1,0x14
    19d8:	00c59313          	slli	t1,a1,0xc
{
    19dc:	d006                	sw	ra,32(sp)
    19de:	ce22                	sw	s0,28(sp)
  FP_UNPACK_D (A, a);
    19e0:	7ff57513          	andi	a0,a0,2047
    19e4:	c432                	sw	a2,8(sp)
    19e6:	00c35313          	srli	t1,t1,0xc
    19ea:	c541                	beqz	a0,1a72 <__divdf3+0xae>
    19ec:	7ff00593          	li	a1,2047
    19f0:	0eb50663          	beq	a0,a1,1adc <__divdf3+0x118>
    19f4:	01d75413          	srli	s0,a4,0x1d
    19f8:	030e                	slli	t1,t1,0x3
    19fa:	008007b7          	lui	a5,0x800
    19fe:	00646433          	or	s0,s0,t1
    1a02:	8c5d                	or	s0,s0,a5
    1a04:	c0150613          	addi	a2,a0,-1023
    1a08:	00371793          	slli	a5,a4,0x3
    1a0c:	4301                	li	t1,0
  FP_UNPACK_D (B, b);
    1a0e:	0146d513          	srli	a0,a3,0x14
    1a12:	01f6d713          	srli	a4,a3,0x1f
    1a16:	00c69393          	slli	t2,a3,0xc
    1a1a:	7ff57513          	andi	a0,a0,2047
    1a1e:	c63a                	sw	a4,12(sp)
    1a20:	00c3d393          	srli	t2,t2,0xc
    1a24:	cd69                	beqz	a0,1afe <__divdf3+0x13a>
    1a26:	7ff00713          	li	a4,2047
    1a2a:	14e50563          	beq	a0,a4,1b74 <__divdf3+0x1b0>
    1a2e:	01d4d713          	srli	a4,s1,0x1d
    1a32:	038e                	slli	t2,t2,0x3
    1a34:	007763b3          	or	t2,a4,t2
    1a38:	008006b7          	lui	a3,0x800
    1a3c:	00d3e3b3          	or	t2,t2,a3
    1a40:	00349713          	slli	a4,s1,0x3
    1a44:	c0150513          	addi	a0,a0,-1023
    1a48:	4681                	li	a3,0
  FP_DIV_D (R, A, B);
    1a4a:	45a2                	lw	a1,8(sp)
    1a4c:	44b2                	lw	s1,12(sp)
    1a4e:	8e09                	sub	a2,a2,a0
    1a50:	c232                	sw	a2,4(sp)
    1a52:	00231613          	slli	a2,t1,0x2
    1a56:	8da5                	xor	a1,a1,s1
    1a58:	8e55                	or	a2,a2,a3
    1a5a:	c02e                	sw	a1,0(sp)
    1a5c:	167d                	addi	a2,a2,-1
    1a5e:	45b9                	li	a1,14
    1a60:	12c5eb63          	bltu	a1,a2,1b96 <__divdf3+0x1d2>
    1a64:	6591                	lui	a1,0x4
    1a66:	060a                	slli	a2,a2,0x2
    1a68:	7b058593          	addi	a1,a1,1968 # 47b0 <_ctype_+0x340>
    1a6c:	962e                	add	a2,a2,a1
    1a6e:	4210                	lw	a2,0(a2)
    1a70:	8602                	jr	a2
  FP_UNPACK_D (A, a);
    1a72:	00e36433          	or	s0,t1,a4
    1a76:	c83d                	beqz	s0,1aec <__divdf3+0x128>
    1a78:	c636                	sw	a3,12(sp)
    1a7a:	04030063          	beqz	t1,1aba <__divdf3+0xf6>
    1a7e:	851a                	mv	a0,t1
    1a80:	c23a                	sw	a4,4(sp)
    1a82:	c01a                	sw	t1,0(sp)
    1a84:	1f8010ef          	jal	ra,2c7c <__clzsi2>
    1a88:	4302                	lw	t1,0(sp)
    1a8a:	4712                	lw	a4,4(sp)
    1a8c:	46b2                	lw	a3,12(sp)
    1a8e:	ff550593          	addi	a1,a0,-11
    1a92:	47f1                	li	a5,28
    1a94:	02b7ce63          	blt	a5,a1,1ad0 <__divdf3+0x10c>
    1a98:	4475                	li	s0,29
    1a9a:	ff850793          	addi	a5,a0,-8
    1a9e:	8c0d                	sub	s0,s0,a1
    1aa0:	00f31333          	sll	t1,t1,a5
    1aa4:	00875433          	srl	s0,a4,s0
    1aa8:	00646433          	or	s0,s0,t1
    1aac:	00f717b3          	sll	a5,a4,a5
    1ab0:	c0d00593          	li	a1,-1011
    1ab4:	40a58633          	sub	a2,a1,a0
    1ab8:	bf91                	j	1a0c <__divdf3+0x48>
    1aba:	853a                	mv	a0,a4
    1abc:	c21a                	sw	t1,4(sp)
    1abe:	c03a                	sw	a4,0(sp)
    1ac0:	1bc010ef          	jal	ra,2c7c <__clzsi2>
    1ac4:	46b2                	lw	a3,12(sp)
    1ac6:	4312                	lw	t1,4(sp)
    1ac8:	4702                	lw	a4,0(sp)
    1aca:	02050513          	addi	a0,a0,32
    1ace:	b7c1                	j	1a8e <__divdf3+0xca>
    1ad0:	fd850413          	addi	s0,a0,-40
    1ad4:	00871433          	sll	s0,a4,s0
    1ad8:	4781                	li	a5,0
    1ada:	bfd9                	j	1ab0 <__divdf3+0xec>
    1adc:	00e36433          	or	s0,t1,a4
    1ae0:	c811                	beqz	s0,1af4 <__divdf3+0x130>
    1ae2:	841a                	mv	s0,t1
    1ae4:	7ff00613          	li	a2,2047
    1ae8:	430d                	li	t1,3
    1aea:	b715                	j	1a0e <__divdf3+0x4a>
    1aec:	4781                	li	a5,0
    1aee:	4601                	li	a2,0
    1af0:	4305                	li	t1,1
    1af2:	bf31                	j	1a0e <__divdf3+0x4a>
    1af4:	4781                	li	a5,0
    1af6:	7ff00613          	li	a2,2047
    1afa:	4309                	li	t1,2
    1afc:	bf09                	j	1a0e <__divdf3+0x4a>
  FP_UNPACK_D (B, b);
    1afe:	0093e733          	or	a4,t2,s1
    1b02:	c349                	beqz	a4,1b84 <__divdf3+0x1c0>
    1b04:	04038463          	beqz	t2,1b4c <__divdf3+0x188>
    1b08:	851e                	mv	a0,t2
    1b0a:	ca1a                	sw	t1,20(sp)
    1b0c:	c832                	sw	a2,16(sp)
    1b0e:	c23e                	sw	a5,4(sp)
    1b10:	c01e                	sw	t2,0(sp)
    1b12:	16a010ef          	jal	ra,2c7c <__clzsi2>
    1b16:	4382                	lw	t2,0(sp)
    1b18:	4792                	lw	a5,4(sp)
    1b1a:	4642                	lw	a2,16(sp)
    1b1c:	4352                	lw	t1,20(sp)
    1b1e:	ff550293          	addi	t0,a0,-11
    1b22:	4771                	li	a4,28
    1b24:	04574263          	blt	a4,t0,1b68 <__divdf3+0x1a4>
    1b28:	46f5                	li	a3,29
    1b2a:	ff850713          	addi	a4,a0,-8
    1b2e:	405686b3          	sub	a3,a3,t0
    1b32:	00e393b3          	sll	t2,t2,a4
    1b36:	00d4d6b3          	srl	a3,s1,a3
    1b3a:	0076e3b3          	or	t2,a3,t2
    1b3e:	00e49733          	sll	a4,s1,a4
    1b42:	c0d00693          	li	a3,-1011
    1b46:	40a68533          	sub	a0,a3,a0
    1b4a:	bdfd                	j	1a48 <__divdf3+0x84>
    1b4c:	8526                	mv	a0,s1
    1b4e:	ca1e                	sw	t2,20(sp)
    1b50:	c81a                	sw	t1,16(sp)
    1b52:	c232                	sw	a2,4(sp)
    1b54:	c03e                	sw	a5,0(sp)
    1b56:	126010ef          	jal	ra,2c7c <__clzsi2>
    1b5a:	43d2                	lw	t2,20(sp)
    1b5c:	4342                	lw	t1,16(sp)
    1b5e:	4612                	lw	a2,4(sp)
    1b60:	4782                	lw	a5,0(sp)
    1b62:	02050513          	addi	a0,a0,32
    1b66:	bf65                	j	1b1e <__divdf3+0x15a>
    1b68:	fd850393          	addi	t2,a0,-40
    1b6c:	007493b3          	sll	t2,s1,t2
    1b70:	4701                	li	a4,0
    1b72:	bfc1                	j	1b42 <__divdf3+0x17e>
    1b74:	0093e733          	or	a4,t2,s1
    1b78:	cb11                	beqz	a4,1b8c <__divdf3+0x1c8>
    1b7a:	8726                	mv	a4,s1
    1b7c:	7ff00513          	li	a0,2047
    1b80:	468d                	li	a3,3
    1b82:	b5e1                	j	1a4a <__divdf3+0x86>
    1b84:	4381                	li	t2,0
    1b86:	4501                	li	a0,0
    1b88:	4685                	li	a3,1
    1b8a:	b5c1                	j	1a4a <__divdf3+0x86>
    1b8c:	4381                	li	t2,0
    1b8e:	7ff00513          	li	a0,2047
    1b92:	4689                	li	a3,2
    1b94:	bd5d                	j	1a4a <__divdf3+0x86>
  FP_DIV_D (R, A, B);
    1b96:	0083e663          	bltu	t2,s0,1ba2 <__divdf3+0x1de>
    1b9a:	2c741263          	bne	s0,t2,1e5e <__divdf3+0x49a>
    1b9e:	2ce7e063          	bltu	a5,a4,1e5e <__divdf3+0x49a>
    1ba2:	01f41613          	slli	a2,s0,0x1f
    1ba6:	0017d693          	srli	a3,a5,0x1
    1baa:	01f79513          	slli	a0,a5,0x1f
    1bae:	8005                	srli	s0,s0,0x1
    1bb0:	00d667b3          	or	a5,a2,a3
    1bb4:	03a2                	slli	t2,t2,0x8
    1bb6:	0103d493          	srli	s1,t2,0x10
    1bba:	02945333          	divu	t1,s0,s1
    1bbe:	01875613          	srli	a2,a4,0x18
    1bc2:	00766633          	or	a2,a2,t2
    1bc6:	00871593          	slli	a1,a4,0x8
    1bca:	01061713          	slli	a4,a2,0x10
    1bce:	8341                	srli	a4,a4,0x10
    1bd0:	c43a                	sw	a4,8(sp)
    1bd2:	0107d693          	srli	a3,a5,0x10
    1bd6:	02947433          	remu	s0,s0,s1
    1bda:	02670733          	mul	a4,a4,t1
    1bde:	0442                	slli	s0,s0,0x10
    1be0:	8c55                	or	s0,s0,a3
    1be2:	869a                	mv	a3,t1
    1be4:	00e47c63          	bgeu	s0,a4,1bfc <__divdf3+0x238>
    1be8:	9432                	add	s0,s0,a2
    1bea:	fff30693          	addi	a3,t1,-1 # fffff <__ctor_end__+0xfadaf>
    1bee:	00c46763          	bltu	s0,a2,1bfc <__divdf3+0x238>
    1bf2:	00e47563          	bgeu	s0,a4,1bfc <__divdf3+0x238>
    1bf6:	ffe30693          	addi	a3,t1,-2
    1bfa:	9432                	add	s0,s0,a2
    1bfc:	8c19                	sub	s0,s0,a4
    1bfe:	029452b3          	divu	t0,s0,s1
    1c02:	01061713          	slli	a4,a2,0x10
    1c06:	8341                	srli	a4,a4,0x10
    1c08:	07c2                	slli	a5,a5,0x10
    1c0a:	83c1                	srli	a5,a5,0x10
    1c0c:	02947433          	remu	s0,s0,s1
    1c10:	8396                	mv	t2,t0
    1c12:	02570333          	mul	t1,a4,t0
    1c16:	0442                	slli	s0,s0,0x10
    1c18:	8fc1                	or	a5,a5,s0
    1c1a:	0067fc63          	bgeu	a5,t1,1c32 <__divdf3+0x26e>
    1c1e:	97b2                	add	a5,a5,a2
    1c20:	fff28393          	addi	t2,t0,-1 # 7fffff <__ctor_end__+0x7fadaf>
    1c24:	00c7e763          	bltu	a5,a2,1c32 <__divdf3+0x26e>
    1c28:	0067f563          	bgeu	a5,t1,1c32 <__divdf3+0x26e>
    1c2c:	ffe28393          	addi	t2,t0,-2
    1c30:	97b2                	add	a5,a5,a2
    1c32:	06c2                	slli	a3,a3,0x10
    1c34:	6441                	lui	s0,0x10
    1c36:	0076e6b3          	or	a3,a3,t2
    1c3a:	fff40713          	addi	a4,s0,-1 # ffff <__ctor_end__+0xadaf>
    1c3e:	00e6f2b3          	and	t0,a3,a4
    1c42:	406787b3          	sub	a5,a5,t1
    1c46:	8f6d                	and	a4,a4,a1
    1c48:	0106d313          	srli	t1,a3,0x10
    1c4c:	025703b3          	mul	t2,a4,t0
    1c50:	c43a                	sw	a4,8(sp)
    1c52:	02e30733          	mul	a4,t1,a4
    1c56:	c63a                	sw	a4,12(sp)
    1c58:	0105d713          	srli	a4,a1,0x10
    1c5c:	025702b3          	mul	t0,a4,t0
    1c60:	02e30333          	mul	t1,t1,a4
    1c64:	4732                	lw	a4,12(sp)
    1c66:	92ba                	add	t0,t0,a4
    1c68:	0103d713          	srli	a4,t2,0x10
    1c6c:	9716                	add	a4,a4,t0
    1c6e:	42b2                	lw	t0,12(sp)
    1c70:	00577363          	bgeu	a4,t0,1c76 <__divdf3+0x2b2>
    1c74:	9322                	add	t1,t1,s0
    1c76:	6441                	lui	s0,0x10
    1c78:	147d                	addi	s0,s0,-1
    1c7a:	01075293          	srli	t0,a4,0x10
    1c7e:	8f61                	and	a4,a4,s0
    1c80:	0742                	slli	a4,a4,0x10
    1c82:	0083f3b3          	and	t2,t2,s0
    1c86:	9316                	add	t1,t1,t0
    1c88:	971e                	add	a4,a4,t2
    1c8a:	0067e763          	bltu	a5,t1,1c98 <__divdf3+0x2d4>
    1c8e:	83b6                	mv	t2,a3
    1c90:	02679e63          	bne	a5,t1,1ccc <__divdf3+0x308>
    1c94:	02e57c63          	bgeu	a0,a4,1ccc <__divdf3+0x308>
    1c98:	952e                	add	a0,a0,a1
    1c9a:	00b532b3          	sltu	t0,a0,a1
    1c9e:	92b2                	add	t0,t0,a2
    1ca0:	9796                	add	a5,a5,t0
    1ca2:	fff68393          	addi	t2,a3,-1 # 7fffff <__ctor_end__+0x7fadaf>
    1ca6:	00f66663          	bltu	a2,a5,1cb2 <__divdf3+0x2ee>
    1caa:	02f61163          	bne	a2,a5,1ccc <__divdf3+0x308>
    1cae:	00b56f63          	bltu	a0,a1,1ccc <__divdf3+0x308>
    1cb2:	0067e663          	bltu	a5,t1,1cbe <__divdf3+0x2fa>
    1cb6:	00f31b63          	bne	t1,a5,1ccc <__divdf3+0x308>
    1cba:	00e57963          	bgeu	a0,a4,1ccc <__divdf3+0x308>
    1cbe:	952e                	add	a0,a0,a1
    1cc0:	ffe68393          	addi	t2,a3,-2
    1cc4:	00b536b3          	sltu	a3,a0,a1
    1cc8:	96b2                	add	a3,a3,a2
    1cca:	97b6                	add	a5,a5,a3
    1ccc:	40e502b3          	sub	t0,a0,a4
    1cd0:	40678333          	sub	t1,a5,t1
    1cd4:	00553533          	sltu	a0,a0,t0
    1cd8:	40a30333          	sub	t1,t1,a0
    1cdc:	577d                	li	a4,-1
    1cde:	10660063          	beq	a2,t1,1dde <__divdf3+0x41a>
    1ce2:	02935433          	divu	s0,t1,s1
    1ce6:	01061793          	slli	a5,a2,0x10
    1cea:	83c1                	srli	a5,a5,0x10
    1cec:	0102d693          	srli	a3,t0,0x10
    1cf0:	02878733          	mul	a4,a5,s0
    1cf4:	029377b3          	remu	a5,t1,s1
    1cf8:	07c2                	slli	a5,a5,0x10
    1cfa:	8fd5                	or	a5,a5,a3
    1cfc:	86a2                	mv	a3,s0
    1cfe:	00e7fc63          	bgeu	a5,a4,1d16 <__divdf3+0x352>
    1d02:	97b2                	add	a5,a5,a2
    1d04:	fff40693          	addi	a3,s0,-1 # ffff <__ctor_end__+0xadaf>
    1d08:	00c7e763          	bltu	a5,a2,1d16 <__divdf3+0x352>
    1d0c:	00e7f563          	bgeu	a5,a4,1d16 <__divdf3+0x352>
    1d10:	ffe40693          	addi	a3,s0,-2
    1d14:	97b2                	add	a5,a5,a2
    1d16:	40e78733          	sub	a4,a5,a4
    1d1a:	02975333          	divu	t1,a4,s1
    1d1e:	01061793          	slli	a5,a2,0x10
    1d22:	83c1                	srli	a5,a5,0x10
    1d24:	02678533          	mul	a0,a5,t1
    1d28:	841a                	mv	s0,t1
    1d2a:	029777b3          	remu	a5,a4,s1
    1d2e:	01029713          	slli	a4,t0,0x10
    1d32:	8341                	srli	a4,a4,0x10
    1d34:	07c2                	slli	a5,a5,0x10
    1d36:	8fd9                	or	a5,a5,a4
    1d38:	00a7fc63          	bgeu	a5,a0,1d50 <__divdf3+0x38c>
    1d3c:	97b2                	add	a5,a5,a2
    1d3e:	fff30413          	addi	s0,t1,-1
    1d42:	00c7e763          	bltu	a5,a2,1d50 <__divdf3+0x38c>
    1d46:	00a7f563          	bgeu	a5,a0,1d50 <__divdf3+0x38c>
    1d4a:	ffe30413          	addi	s0,t1,-2
    1d4e:	97b2                	add	a5,a5,a2
    1d50:	06c2                	slli	a3,a3,0x10
    1d52:	8ec1                	or	a3,a3,s0
    1d54:	4422                	lw	s0,8(sp)
    1d56:	8f89                	sub	a5,a5,a0
    1d58:	4522                	lw	a0,8(sp)
    1d5a:	0106d293          	srli	t0,a3,0x10
    1d5e:	01069713          	slli	a4,a3,0x10
    1d62:	02828333          	mul	t1,t0,s0
    1d66:	8341                	srli	a4,a4,0x10
    1d68:	0105d413          	srli	s0,a1,0x10
    1d6c:	02a70533          	mul	a0,a4,a0
    1d70:	02e40733          	mul	a4,s0,a4
    1d74:	025402b3          	mul	t0,s0,t0
    1d78:	971a                	add	a4,a4,t1
    1d7a:	01055413          	srli	s0,a0,0x10
    1d7e:	9722                	add	a4,a4,s0
    1d80:	00677463          	bgeu	a4,t1,1d88 <__divdf3+0x3c4>
    1d84:	6341                	lui	t1,0x10
    1d86:	929a                	add	t0,t0,t1
    1d88:	01075313          	srli	t1,a4,0x10
    1d8c:	929a                	add	t0,t0,t1
    1d8e:	6341                	lui	t1,0x10
    1d90:	137d                	addi	t1,t1,-1
    1d92:	00677733          	and	a4,a4,t1
    1d96:	0742                	slli	a4,a4,0x10
    1d98:	00657533          	and	a0,a0,t1
    1d9c:	953a                	add	a0,a0,a4
    1d9e:	0057e663          	bltu	a5,t0,1daa <__divdf3+0x3e6>
    1da2:	1a579663          	bne	a5,t0,1f4e <__divdf3+0x58a>
    1da6:	8736                	mv	a4,a3
    1da8:	c91d                	beqz	a0,1dde <__divdf3+0x41a>
    1daa:	97b2                	add	a5,a5,a2
    1dac:	fff68713          	addi	a4,a3,-1
    1db0:	02c7e163          	bltu	a5,a2,1dd2 <__divdf3+0x40e>
    1db4:	0057e663          	bltu	a5,t0,1dc0 <__divdf3+0x3fc>
    1db8:	18579a63          	bne	a5,t0,1f4c <__divdf3+0x588>
    1dbc:	00a5fd63          	bgeu	a1,a0,1dd6 <__divdf3+0x412>
    1dc0:	ffe68713          	addi	a4,a3,-2
    1dc4:	00159693          	slli	a3,a1,0x1
    1dc8:	00b6b5b3          	sltu	a1,a3,a1
    1dcc:	962e                	add	a2,a2,a1
    1dce:	97b2                	add	a5,a5,a2
    1dd0:	85b6                	mv	a1,a3
    1dd2:	00579463          	bne	a5,t0,1dda <__divdf3+0x416>
    1dd6:	00b50463          	beq	a0,a1,1dde <__divdf3+0x41a>
    1dda:	00176713          	ori	a4,a4,1
  FP_PACK_D (r, R);
    1dde:	4792                	lw	a5,4(sp)
    1de0:	3ff78793          	addi	a5,a5,1023 # 8003ff <__ctor_end__+0x7fb1af>
    1de4:	0af05e63          	blez	a5,1ea0 <__divdf3+0x4dc>
    1de8:	00777693          	andi	a3,a4,7
    1dec:	ce81                	beqz	a3,1e04 <__divdf3+0x440>
    1dee:	00f77693          	andi	a3,a4,15
    1df2:	4611                	li	a2,4
    1df4:	00c68863          	beq	a3,a2,1e04 <__divdf3+0x440>
    1df8:	00470693          	addi	a3,a4,4 # ff800004 <__bss_end__+0xdf7fe054>
    1dfc:	00e6b733          	sltu	a4,a3,a4
    1e00:	93ba                	add	t2,t2,a4
    1e02:	8736                	mv	a4,a3
    1e04:	010006b7          	lui	a3,0x1000
    1e08:	00d3f6b3          	and	a3,t2,a3
    1e0c:	ca89                	beqz	a3,1e1e <__divdf3+0x45a>
    1e0e:	ff0007b7          	lui	a5,0xff000
    1e12:	17fd                	addi	a5,a5,-1
    1e14:	00f3f3b3          	and	t2,t2,a5
    1e18:	4792                	lw	a5,4(sp)
    1e1a:	40078793          	addi	a5,a5,1024 # ff000400 <__bss_end__+0xdeffe450>
    1e1e:	7fe00693          	li	a3,2046
    1e22:	06f6c163          	blt	a3,a5,1e84 <__divdf3+0x4c0>
    1e26:	01d39693          	slli	a3,t2,0x1d
    1e2a:	830d                	srli	a4,a4,0x3
    1e2c:	8f55                	or	a4,a4,a3
    1e2e:	0033d393          	srli	t2,t2,0x3
    1e32:	7ff006b7          	lui	a3,0x7ff00
    1e36:	07d2                	slli	a5,a5,0x14
    1e38:	8ff5                	and	a5,a5,a3
    1e3a:	4682                	lw	a3,0(sp)
    1e3c:	03b2                	slli	t2,t2,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    1e3e:	5082                	lw	ra,32(sp)
    1e40:	4472                	lw	s0,28(sp)
  FP_PACK_D (r, R);
    1e42:	00c3d393          	srli	t2,t2,0xc
    1e46:	01f69593          	slli	a1,a3,0x1f
    1e4a:	0077e7b3          	or	a5,a5,t2
    1e4e:	00b7e6b3          	or	a3,a5,a1
}
    1e52:	44e2                	lw	s1,24(sp)
    1e54:	853a                	mv	a0,a4
    1e56:	85b6                	mv	a1,a3
    1e58:	02410113          	addi	sp,sp,36
    1e5c:	8082                	ret
  FP_DIV_D (R, A, B);
    1e5e:	4692                	lw	a3,4(sp)
    1e60:	4501                	li	a0,0
    1e62:	16fd                	addi	a3,a3,-1
    1e64:	c236                	sw	a3,4(sp)
    1e66:	b3b9                	j	1bb4 <__divdf3+0x1f0>
  FP_UNPACK_D (A, a);
    1e68:	4722                	lw	a4,8(sp)
  FP_DIV_D (R, A, B);
    1e6a:	83a2                	mv	t2,s0
    1e6c:	869a                	mv	a3,t1
  FP_UNPACK_D (A, a);
    1e6e:	c03a                	sw	a4,0(sp)
  FP_DIV_D (R, A, B);
    1e70:	873e                	mv	a4,a5
  FP_PACK_D (r, R);
    1e72:	478d                	li	a5,3
    1e74:	0af68e63          	beq	a3,a5,1f30 <__divdf3+0x56c>
    1e78:	4785                	li	a5,1
    1e7a:	0cf68263          	beq	a3,a5,1f3e <__divdf3+0x57a>
    1e7e:	4789                	li	a5,2
    1e80:	f4f69fe3          	bne	a3,a5,1dde <__divdf3+0x41a>
    1e84:	4381                	li	t2,0
    1e86:	4701                	li	a4,0
    1e88:	7ff00793          	li	a5,2047
    1e8c:	b75d                	j	1e32 <__divdf3+0x46e>
  FP_UNPACK_D (B, b);
    1e8e:	47b2                	lw	a5,12(sp)
    1e90:	c03e                	sw	a5,0(sp)
  FP_DIV_D (R, A, B);
    1e92:	b7c5                	j	1e72 <__divdf3+0x4ae>
    1e94:	000803b7          	lui	t2,0x80
    1e98:	4701                	li	a4,0
    1e9a:	c002                	sw	zero,0(sp)
    1e9c:	468d                	li	a3,3
    1e9e:	bfd1                	j	1e72 <__divdf3+0x4ae>
  FP_PACK_D (r, R);
    1ea0:	4685                	li	a3,1
    1ea2:	8e9d                	sub	a3,a3,a5
    1ea4:	03800613          	li	a2,56
    1ea8:	08d64b63          	blt	a2,a3,1f3e <__divdf3+0x57a>
    1eac:	467d                	li	a2,31
    1eae:	04d64c63          	blt	a2,a3,1f06 <__divdf3+0x542>
    1eb2:	4792                	lw	a5,4(sp)
    1eb4:	00d75633          	srl	a2,a4,a3
    1eb8:	41e78593          	addi	a1,a5,1054
    1ebc:	00b397b3          	sll	a5,t2,a1
    1ec0:	00b71733          	sll	a4,a4,a1
    1ec4:	8fd1                	or	a5,a5,a2
    1ec6:	00e03733          	snez	a4,a4
    1eca:	8f5d                	or	a4,a4,a5
    1ecc:	00d3d3b3          	srl	t2,t2,a3
    1ed0:	00777793          	andi	a5,a4,7
    1ed4:	cf81                	beqz	a5,1eec <__divdf3+0x528>
    1ed6:	00f77793          	andi	a5,a4,15
    1eda:	4691                	li	a3,4
    1edc:	00d78863          	beq	a5,a3,1eec <__divdf3+0x528>
    1ee0:	00470693          	addi	a3,a4,4
    1ee4:	00e6b733          	sltu	a4,a3,a4
    1ee8:	93ba                	add	t2,t2,a4
    1eea:	8736                	mv	a4,a3
    1eec:	008007b7          	lui	a5,0x800
    1ef0:	00f3f7b3          	and	a5,t2,a5
    1ef4:	eba1                	bnez	a5,1f44 <__divdf3+0x580>
    1ef6:	01d39793          	slli	a5,t2,0x1d
    1efa:	830d                	srli	a4,a4,0x3
    1efc:	8f5d                	or	a4,a4,a5
    1efe:	0033d393          	srli	t2,t2,0x3
    1f02:	4781                	li	a5,0
    1f04:	b73d                	j	1e32 <__divdf3+0x46e>
    1f06:	5605                	li	a2,-31
    1f08:	40f607b3          	sub	a5,a2,a5
    1f0c:	02000613          	li	a2,32
    1f10:	00f3d7b3          	srl	a5,t2,a5
    1f14:	4581                	li	a1,0
    1f16:	00c68763          	beq	a3,a2,1f24 <__divdf3+0x560>
    1f1a:	4692                	lw	a3,4(sp)
    1f1c:	43e68593          	addi	a1,a3,1086 # 7ff0043e <__bss_end__+0x5fefe48e>
    1f20:	00b395b3          	sll	a1,t2,a1
    1f24:	8f4d                	or	a4,a4,a1
    1f26:	00e03733          	snez	a4,a4
    1f2a:	8f5d                	or	a4,a4,a5
    1f2c:	4381                	li	t2,0
    1f2e:	b74d                	j	1ed0 <__divdf3+0x50c>
    1f30:	000803b7          	lui	t2,0x80
    1f34:	4701                	li	a4,0
    1f36:	7ff00793          	li	a5,2047
    1f3a:	c002                	sw	zero,0(sp)
    1f3c:	bddd                	j	1e32 <__divdf3+0x46e>
    1f3e:	4381                	li	t2,0
    1f40:	4701                	li	a4,0
    1f42:	b7c1                	j	1f02 <__divdf3+0x53e>
    1f44:	4381                	li	t2,0
    1f46:	4701                	li	a4,0
    1f48:	4785                	li	a5,1
    1f4a:	b5e5                	j	1e32 <__divdf3+0x46e>
  FP_DIV_D (R, A, B);
    1f4c:	86ba                	mv	a3,a4
    1f4e:	8736                	mv	a4,a3
    1f50:	b569                	j	1dda <__divdf3+0x416>

00001f52 <__eqdf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    1f52:	001007b7          	lui	a5,0x100
    1f56:	17fd                	addi	a5,a5,-1
{
    1f58:	1151                	addi	sp,sp,-12
  FP_UNPACK_RAW_D (A, a);
    1f5a:	00b7f2b3          	and	t0,a5,a1
    1f5e:	0145d713          	srli	a4,a1,0x14
    1f62:	81fd                	srli	a1,a1,0x1f
{
    1f64:	c422                	sw	s0,8(sp)
    1f66:	c226                	sw	s1,4(sp)
    1f68:	832a                	mv	t1,a0
    1f6a:	842a                	mv	s0,a0
  FP_UNPACK_RAW_D (A, a);
    1f6c:	c02e                	sw	a1,0(sp)
    1f6e:	7ff77713          	andi	a4,a4,2047
  FP_UNPACK_RAW_D (B, b);
    1f72:	0146d593          	srli	a1,a3,0x14
  FP_CMP_EQ_D (r, A, B, 1);
    1f76:	7ff00513          	li	a0,2047
  FP_UNPACK_RAW_D (B, b);
    1f7a:	8ff5                	and	a5,a5,a3
    1f7c:	84b2                	mv	s1,a2
    1f7e:	7ff5f593          	andi	a1,a1,2047
    1f82:	82fd                	srli	a3,a3,0x1f
  FP_CMP_EQ_D (r, A, B, 1);
    1f84:	00a71a63          	bne	a4,a0,1f98 <__eqdf2+0x46>
    1f88:	0062e3b3          	or	t2,t0,t1
    1f8c:	4505                	li	a0,1
    1f8e:	02039963          	bnez	t2,1fc0 <__eqdf2+0x6e>
    1f92:	02e59763          	bne	a1,a4,1fc0 <__eqdf2+0x6e>
    1f96:	a019                	j	1f9c <__eqdf2+0x4a>
    1f98:	00a59563          	bne	a1,a0,1fa2 <__eqdf2+0x50>
    1f9c:	8e5d                	or	a2,a2,a5
    1f9e:	4505                	li	a0,1
    1fa0:	e205                	bnez	a2,1fc0 <__eqdf2+0x6e>
    1fa2:	4505                	li	a0,1
    1fa4:	00b71e63          	bne	a4,a1,1fc0 <__eqdf2+0x6e>
    1fa8:	00f29c63          	bne	t0,a5,1fc0 <__eqdf2+0x6e>
    1fac:	00941a63          	bne	s0,s1,1fc0 <__eqdf2+0x6e>
    1fb0:	4782                	lw	a5,0(sp)
    1fb2:	00d78b63          	beq	a5,a3,1fc8 <__eqdf2+0x76>
    1fb6:	e709                	bnez	a4,1fc0 <__eqdf2+0x6e>
    1fb8:	0062e533          	or	a0,t0,t1
    1fbc:	00a03533          	snez	a0,a0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    1fc0:	4422                	lw	s0,8(sp)
    1fc2:	4492                	lw	s1,4(sp)
    1fc4:	0131                	addi	sp,sp,12
    1fc6:	8082                	ret
  FP_CMP_EQ_D (r, A, B, 1);
    1fc8:	4501                	li	a0,0
    1fca:	bfdd                	j	1fc0 <__eqdf2+0x6e>

00001fcc <__gedf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    1fcc:	00100737          	lui	a4,0x100
{
    1fd0:	1161                	addi	sp,sp,-8
  FP_UNPACK_RAW_D (A, a);
    1fd2:	177d                	addi	a4,a4,-1
    1fd4:	0145d313          	srli	t1,a1,0x14
    1fd8:	00b772b3          	and	t0,a4,a1
{
    1fdc:	c222                	sw	s0,4(sp)
    1fde:	c026                	sw	s1,0(sp)
    1fe0:	87aa                	mv	a5,a0
    1fe2:	83aa                	mv	t2,a0
  FP_UNPACK_RAW_D (A, a);
    1fe4:	7ff37313          	andi	t1,t1,2047
    1fe8:	01f5d513          	srli	a0,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
  FP_CMP_D (r, A, B, -2, 2);
    1fec:	7ff00493          	li	s1,2047
  FP_UNPACK_RAW_D (B, b);
    1ff0:	0146d593          	srli	a1,a3,0x14
    1ff4:	8f75                	and	a4,a4,a3
    1ff6:	8432                	mv	s0,a2
    1ff8:	7ff5f593          	andi	a1,a1,2047
    1ffc:	82fd                	srli	a3,a3,0x1f
  FP_CMP_D (r, A, B, -2, 2);
    1ffe:	00931763          	bne	t1,s1,200c <__gedf2+0x40>
    2002:	00f2e4b3          	or	s1,t0,a5
    2006:	c4ad                	beqz	s1,2070 <__gedf2+0xa4>
    2008:	5579                	li	a0,-2
    200a:	a815                	j	203e <__gedf2+0x72>
    200c:	00959563          	bne	a1,s1,2016 <__gedf2+0x4a>
    2010:	00c764b3          	or	s1,a4,a2
    2014:	f8f5                	bnez	s1,2008 <__gedf2+0x3c>
    2016:	04031f63          	bnez	t1,2074 <__gedf2+0xa8>
    201a:	00f2e7b3          	or	a5,t0,a5
    201e:	0017b793          	seqz	a5,a5
    2022:	e199                	bnez	a1,2028 <__gedf2+0x5c>
    2024:	8e59                	or	a2,a2,a4
    2026:	c221                	beqz	a2,2066 <__gedf2+0x9a>
    2028:	eb81                	bnez	a5,2038 <__gedf2+0x6c>
    202a:	00d51463          	bne	a0,a3,2032 <__gedf2+0x66>
    202e:	0065dc63          	bge	a1,t1,2046 <__gedf2+0x7a>
    2032:	c905                	beqz	a0,2062 <__gedf2+0x96>
    2034:	557d                	li	a0,-1
    2036:	a021                	j	203e <__gedf2+0x72>
    2038:	557d                	li	a0,-1
    203a:	c291                	beqz	a3,203e <__gedf2+0x72>
    203c:	8536                	mv	a0,a3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    203e:	4412                	lw	s0,4(sp)
    2040:	4482                	lw	s1,0(sp)
    2042:	0121                	addi	sp,sp,8
    2044:	8082                	ret
  FP_CMP_D (r, A, B, -2, 2);
    2046:	00b35463          	bge	t1,a1,204e <__gedf2+0x82>
    204a:	f975                	bnez	a0,203e <__gedf2+0x72>
    204c:	b7e5                	j	2034 <__gedf2+0x68>
    204e:	fe5762e3          	bltu	a4,t0,2032 <__gedf2+0x66>
    2052:	00e29c63          	bne	t0,a4,206a <__gedf2+0x9e>
    2056:	fc746ee3          	bltu	s0,t2,2032 <__gedf2+0x66>
    205a:	fe83e8e3          	bltu	t2,s0,204a <__gedf2+0x7e>
    205e:	4501                	li	a0,0
    2060:	bff9                	j	203e <__gedf2+0x72>
    2062:	4505                	li	a0,1
    2064:	bfe9                	j	203e <__gedf2+0x72>
    2066:	ffe5                	bnez	a5,205e <__gedf2+0x92>
    2068:	b7e9                	j	2032 <__gedf2+0x66>
    206a:	fee2e0e3          	bltu	t0,a4,204a <__gedf2+0x7e>
    206e:	bfc5                	j	205e <__gedf2+0x92>
    2070:	fa6580e3          	beq	a1,t1,2010 <__gedf2+0x44>
    2074:	f9dd                	bnez	a1,202a <__gedf2+0x5e>
    2076:	4781                	li	a5,0
    2078:	b775                	j	2024 <__gedf2+0x58>

0000207a <__ledf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    207a:	00100737          	lui	a4,0x100
{
    207e:	1161                	addi	sp,sp,-8
  FP_UNPACK_RAW_D (A, a);
    2080:	177d                	addi	a4,a4,-1
    2082:	0145d313          	srli	t1,a1,0x14
    2086:	00b772b3          	and	t0,a4,a1
{
    208a:	c222                	sw	s0,4(sp)
    208c:	c026                	sw	s1,0(sp)
    208e:	87aa                	mv	a5,a0
    2090:	83aa                	mv	t2,a0
  FP_UNPACK_RAW_D (A, a);
    2092:	7ff37313          	andi	t1,t1,2047
    2096:	01f5d513          	srli	a0,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
  FP_CMP_D (r, A, B, 2, 2);
    209a:	7ff00493          	li	s1,2047
  FP_UNPACK_RAW_D (B, b);
    209e:	0146d593          	srli	a1,a3,0x14
    20a2:	8f75                	and	a4,a4,a3
    20a4:	8432                	mv	s0,a2
    20a6:	7ff5f593          	andi	a1,a1,2047
    20aa:	82fd                	srli	a3,a3,0x1f
  FP_CMP_D (r, A, B, 2, 2);
    20ac:	00931763          	bne	t1,s1,20ba <__ledf2+0x40>
    20b0:	00f2e4b3          	or	s1,t0,a5
    20b4:	c4ad                	beqz	s1,211e <__ledf2+0xa4>
    20b6:	4509                	li	a0,2
    20b8:	a815                	j	20ec <__ledf2+0x72>
    20ba:	00959563          	bne	a1,s1,20c4 <__ledf2+0x4a>
    20be:	00c764b3          	or	s1,a4,a2
    20c2:	f8f5                	bnez	s1,20b6 <__ledf2+0x3c>
    20c4:	04031f63          	bnez	t1,2122 <__ledf2+0xa8>
    20c8:	00f2e7b3          	or	a5,t0,a5
    20cc:	0017b793          	seqz	a5,a5
    20d0:	e199                	bnez	a1,20d6 <__ledf2+0x5c>
    20d2:	8e59                	or	a2,a2,a4
    20d4:	c221                	beqz	a2,2114 <__ledf2+0x9a>
    20d6:	eb81                	bnez	a5,20e6 <__ledf2+0x6c>
    20d8:	00d51463          	bne	a0,a3,20e0 <__ledf2+0x66>
    20dc:	0065dc63          	bge	a1,t1,20f4 <__ledf2+0x7a>
    20e0:	c905                	beqz	a0,2110 <__ledf2+0x96>
    20e2:	557d                	li	a0,-1
    20e4:	a021                	j	20ec <__ledf2+0x72>
    20e6:	557d                	li	a0,-1
    20e8:	c291                	beqz	a3,20ec <__ledf2+0x72>
    20ea:	8536                	mv	a0,a3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    20ec:	4412                	lw	s0,4(sp)
    20ee:	4482                	lw	s1,0(sp)
    20f0:	0121                	addi	sp,sp,8
    20f2:	8082                	ret
  FP_CMP_D (r, A, B, 2, 2);
    20f4:	00b35463          	bge	t1,a1,20fc <__ledf2+0x82>
    20f8:	f975                	bnez	a0,20ec <__ledf2+0x72>
    20fa:	b7e5                	j	20e2 <__ledf2+0x68>
    20fc:	fe5762e3          	bltu	a4,t0,20e0 <__ledf2+0x66>
    2100:	00e29c63          	bne	t0,a4,2118 <__ledf2+0x9e>
    2104:	fc746ee3          	bltu	s0,t2,20e0 <__ledf2+0x66>
    2108:	fe83e8e3          	bltu	t2,s0,20f8 <__ledf2+0x7e>
    210c:	4501                	li	a0,0
    210e:	bff9                	j	20ec <__ledf2+0x72>
    2110:	4505                	li	a0,1
    2112:	bfe9                	j	20ec <__ledf2+0x72>
    2114:	ffe5                	bnez	a5,210c <__ledf2+0x92>
    2116:	b7e9                	j	20e0 <__ledf2+0x66>
    2118:	fee2e0e3          	bltu	t0,a4,20f8 <__ledf2+0x7e>
    211c:	bfc5                	j	210c <__ledf2+0x92>
    211e:	fa6580e3          	beq	a1,t1,20be <__ledf2+0x44>
    2122:	f9dd                	bnez	a1,20d8 <__ledf2+0x5e>
    2124:	4781                	li	a5,0
    2126:	b775                	j	20d2 <__ledf2+0x58>

00002128 <__muldf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__muldf3 (DFtype a, DFtype b)
{
    2128:	fd810113          	addi	sp,sp,-40
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
    212c:	00c59793          	slli	a5,a1,0xc
{
    2130:	ce26                	sw	s1,28(sp)
  FP_UNPACK_D (A, a);
    2132:	0145d313          	srli	t1,a1,0x14
    2136:	00c7d493          	srli	s1,a5,0xc
    213a:	01f5d793          	srli	a5,a1,0x1f
{
    213e:	d022                	sw	s0,32(sp)
    2140:	d206                	sw	ra,36(sp)
  FP_UNPACK_D (A, a);
    2142:	7ff37313          	andi	t1,t1,2047
    2146:	c43e                	sw	a5,8(sp)
{
    2148:	842a                	mv	s0,a0
  FP_UNPACK_D (A, a);
    214a:	08030763          	beqz	t1,21d8 <__muldf3+0xb0>
    214e:	7ff00793          	li	a5,2047
    2152:	0ef30163          	beq	t1,a5,2234 <__muldf3+0x10c>
    2156:	00349713          	slli	a4,s1,0x3
    215a:	01d55793          	srli	a5,a0,0x1d
    215e:	8fd9                	or	a5,a5,a4
    2160:	00800737          	lui	a4,0x800
    2164:	00e7e4b3          	or	s1,a5,a4
    2168:	00351593          	slli	a1,a0,0x3
    216c:	c0130313          	addi	t1,t1,-1023 # fc01 <__ctor_end__+0xa9b1>
    2170:	4401                	li	s0,0
  FP_UNPACK_D (B, b);
    2172:	0146d513          	srli	a0,a3,0x14
    2176:	01f6d713          	srli	a4,a3,0x1f
    217a:	00c69793          	slli	a5,a3,0xc
    217e:	7ff57513          	andi	a0,a0,2047
    2182:	c63a                	sw	a4,12(sp)
    2184:	83b1                	srli	a5,a5,0xc
    2186:	c961                	beqz	a0,2256 <__muldf3+0x12e>
    2188:	7ff00713          	li	a4,2047
    218c:	12e50e63          	beq	a0,a4,22c8 <__muldf3+0x1a0>
    2190:	01d65713          	srli	a4,a2,0x1d
    2194:	078e                	slli	a5,a5,0x3
    2196:	8fd9                	or	a5,a5,a4
    2198:	00800737          	lui	a4,0x800
    219c:	8fd9                	or	a5,a5,a4
    219e:	00361693          	slli	a3,a2,0x3
    21a2:	c0150513          	addi	a0,a0,-1023
    21a6:	4701                	li	a4,0
  FP_MUL_D (R, A, B);
    21a8:	4622                	lw	a2,8(sp)
    21aa:	42b2                	lw	t0,12(sp)
    21ac:	00564633          	xor	a2,a2,t0
    21b0:	c032                	sw	a2,0(sp)
    21b2:	00a30633          	add	a2,t1,a0
    21b6:	c832                	sw	a2,16(sp)
    21b8:	0605                	addi	a2,a2,1
    21ba:	c232                	sw	a2,4(sp)
    21bc:	00241613          	slli	a2,s0,0x2
    21c0:	8e59                	or	a2,a2,a4
    21c2:	167d                	addi	a2,a2,-1
    21c4:	4539                	li	a0,14
    21c6:	12c56263          	bltu	a0,a2,22ea <__muldf3+0x1c2>
    21ca:	6511                	lui	a0,0x4
    21cc:	060a                	slli	a2,a2,0x2
    21ce:	7ec50513          	addi	a0,a0,2028 # 47ec <_ctype_+0x37c>
    21d2:	962a                	add	a2,a2,a0
    21d4:	4210                	lw	a2,0(a2)
    21d6:	8602                	jr	a2
  FP_UNPACK_D (A, a);
    21d8:	00a4e5b3          	or	a1,s1,a0
    21dc:	c5a5                	beqz	a1,2244 <__muldf3+0x11c>
    21de:	c236                	sw	a3,4(sp)
    21e0:	c032                	sw	a2,0(sp)
    21e2:	cc85                	beqz	s1,221a <__muldf3+0xf2>
    21e4:	8526                	mv	a0,s1
    21e6:	297000ef          	jal	ra,2c7c <__clzsi2>
    21ea:	4602                	lw	a2,0(sp)
    21ec:	4692                	lw	a3,4(sp)
    21ee:	ff550713          	addi	a4,a0,-11
    21f2:	47f1                	li	a5,28
    21f4:	02e7ca63          	blt	a5,a4,2228 <__muldf3+0x100>
    21f8:	47f5                	li	a5,29
    21fa:	ff850593          	addi	a1,a0,-8
    21fe:	8f99                	sub	a5,a5,a4
    2200:	00b49333          	sll	t1,s1,a1
    2204:	00f457b3          	srl	a5,s0,a5
    2208:	0067e4b3          	or	s1,a5,t1
    220c:	00b415b3          	sll	a1,s0,a1
    2210:	c0d00313          	li	t1,-1011
    2214:	40a30333          	sub	t1,t1,a0
    2218:	bfa1                	j	2170 <__muldf3+0x48>
    221a:	263000ef          	jal	ra,2c7c <__clzsi2>
    221e:	4692                	lw	a3,4(sp)
    2220:	4602                	lw	a2,0(sp)
    2222:	02050513          	addi	a0,a0,32
    2226:	b7e1                	j	21ee <__muldf3+0xc6>
    2228:	fd850793          	addi	a5,a0,-40
    222c:	00f414b3          	sll	s1,s0,a5
    2230:	4581                	li	a1,0
    2232:	bff9                	j	2210 <__muldf3+0xe8>
    2234:	00a4e5b3          	or	a1,s1,a0
    2238:	c991                	beqz	a1,224c <__muldf3+0x124>
    223a:	85aa                	mv	a1,a0
    223c:	7ff00313          	li	t1,2047
    2240:	440d                	li	s0,3
    2242:	bf05                	j	2172 <__muldf3+0x4a>
    2244:	4481                	li	s1,0
    2246:	4301                	li	t1,0
    2248:	4405                	li	s0,1
    224a:	b725                	j	2172 <__muldf3+0x4a>
    224c:	4481                	li	s1,0
    224e:	7ff00313          	li	t1,2047
    2252:	4409                	li	s0,2
    2254:	bf39                	j	2172 <__muldf3+0x4a>
  FP_UNPACK_D (B, b);
    2256:	00c7e6b3          	or	a3,a5,a2
    225a:	cebd                	beqz	a3,22d8 <__muldf3+0x1b0>
    225c:	c3b1                	beqz	a5,22a0 <__muldf3+0x178>
    225e:	853e                	mv	a0,a5
    2260:	ca32                	sw	a2,20(sp)
    2262:	c82e                	sw	a1,16(sp)
    2264:	c21a                	sw	t1,4(sp)
    2266:	c03e                	sw	a5,0(sp)
    2268:	215000ef          	jal	ra,2c7c <__clzsi2>
    226c:	4782                	lw	a5,0(sp)
    226e:	4312                	lw	t1,4(sp)
    2270:	45c2                	lw	a1,16(sp)
    2272:	4652                	lw	a2,20(sp)
    2274:	ff550393          	addi	t2,a0,-11
    2278:	4771                	li	a4,28
    227a:	04774163          	blt	a4,t2,22bc <__muldf3+0x194>
    227e:	4775                	li	a4,29
    2280:	ff850693          	addi	a3,a0,-8
    2284:	40770733          	sub	a4,a4,t2
    2288:	00d797b3          	sll	a5,a5,a3
    228c:	00e65733          	srl	a4,a2,a4
    2290:	8fd9                	or	a5,a5,a4
    2292:	00d616b3          	sll	a3,a2,a3
    2296:	c0d00713          	li	a4,-1011
    229a:	40a70533          	sub	a0,a4,a0
    229e:	b721                	j	21a6 <__muldf3+0x7e>
    22a0:	8532                	mv	a0,a2
    22a2:	ca3e                	sw	a5,20(sp)
    22a4:	c82e                	sw	a1,16(sp)
    22a6:	c21a                	sw	t1,4(sp)
    22a8:	c032                	sw	a2,0(sp)
    22aa:	1d3000ef          	jal	ra,2c7c <__clzsi2>
    22ae:	47d2                	lw	a5,20(sp)
    22b0:	45c2                	lw	a1,16(sp)
    22b2:	4312                	lw	t1,4(sp)
    22b4:	4602                	lw	a2,0(sp)
    22b6:	02050513          	addi	a0,a0,32
    22ba:	bf6d                	j	2274 <__muldf3+0x14c>
    22bc:	fd850793          	addi	a5,a0,-40
    22c0:	00f617b3          	sll	a5,a2,a5
    22c4:	4681                	li	a3,0
    22c6:	bfc1                	j	2296 <__muldf3+0x16e>
    22c8:	00c7e6b3          	or	a3,a5,a2
    22cc:	ca91                	beqz	a3,22e0 <__muldf3+0x1b8>
    22ce:	86b2                	mv	a3,a2
    22d0:	7ff00513          	li	a0,2047
    22d4:	470d                	li	a4,3
    22d6:	bdc9                	j	21a8 <__muldf3+0x80>
    22d8:	4781                	li	a5,0
    22da:	4501                	li	a0,0
    22dc:	4705                	li	a4,1
    22de:	b5e9                	j	21a8 <__muldf3+0x80>
    22e0:	4781                	li	a5,0
    22e2:	7ff00513          	li	a0,2047
    22e6:	4709                	li	a4,2
    22e8:	b5c1                	j	21a8 <__muldf3+0x80>
  FP_MUL_D (R, A, B);
    22ea:	0105d513          	srli	a0,a1,0x10
    22ee:	0106d413          	srli	s0,a3,0x10
    22f2:	02850633          	mul	a2,a0,s0
    22f6:	6741                	lui	a4,0x10
    22f8:	177d                	addi	a4,a4,-1
    22fa:	8df9                	and	a1,a1,a4
    22fc:	8ef9                	and	a3,a3,a4
    22fe:	02d503b3          	mul	t2,a0,a3
    2302:	c432                	sw	a2,8(sp)
    2304:	02b40633          	mul	a2,s0,a1
    2308:	02d58333          	mul	t1,a1,a3
    230c:	961e                	add	a2,a2,t2
    230e:	82b2                	mv	t0,a2
    2310:	01035613          	srli	a2,t1,0x10
    2314:	9616                	add	a2,a2,t0
    2316:	00767763          	bgeu	a2,t2,2324 <__muldf3+0x1fc>
    231a:	028503b3          	mul	t2,a0,s0
    231e:	62c1                	lui	t0,0x10
    2320:	929e                	add	t0,t0,t2
    2322:	c416                	sw	t0,8(sp)
    2324:	01065293          	srli	t0,a2,0x10
    2328:	8e79                	and	a2,a2,a4
    232a:	00e37333          	and	t1,t1,a4
    232e:	0642                	slli	a2,a2,0x10
    2330:	961a                	add	a2,a2,t1
    2332:	8f7d                	and	a4,a4,a5
    2334:	ca32                	sw	a2,20(sp)
    2336:	0107d613          	srli	a2,a5,0x10
    233a:	02e50333          	mul	t1,a0,a4
    233e:	02e587b3          	mul	a5,a1,a4
    2342:	02b605b3          	mul	a1,a2,a1
    2346:	0107d393          	srli	t2,a5,0x10
    234a:	959a                	add	a1,a1,t1
    234c:	959e                	add	a1,a1,t2
    234e:	02c50533          	mul	a0,a0,a2
    2352:	0065f463          	bgeu	a1,t1,235a <__muldf3+0x232>
    2356:	6341                	lui	t1,0x10
    2358:	951a                	add	a0,a0,t1
    235a:	0105d313          	srli	t1,a1,0x10
    235e:	951a                	add	a0,a0,t1
    2360:	c62a                	sw	a0,12(sp)
    2362:	6541                	lui	a0,0x10
    2364:	fff50313          	addi	t1,a0,-1 # ffff <__ctor_end__+0xadaf>
    2368:	0065f5b3          	and	a1,a1,t1
    236c:	0067f7b3          	and	a5,a5,t1
    2370:	05c2                	slli	a1,a1,0x10
    2372:	95be                	add	a1,a1,a5
    2374:	00b287b3          	add	a5,t0,a1
    2378:	0064f333          	and	t1,s1,t1
    237c:	0104d293          	srli	t0,s1,0x10
    2380:	cc3e                	sw	a5,24(sp)
    2382:	026404b3          	mul	s1,s0,t1
    2386:	026687b3          	mul	a5,a3,t1
    238a:	02d286b3          	mul	a3,t0,a3
    238e:	025403b3          	mul	t2,s0,t0
    2392:	94b6                	add	s1,s1,a3
    2394:	0107d413          	srli	s0,a5,0x10
    2398:	94a2                	add	s1,s1,s0
    239a:	00d4f363          	bgeu	s1,a3,23a0 <__muldf3+0x278>
    239e:	93aa                	add	t2,t2,a0
    23a0:	0104d693          	srli	a3,s1,0x10
    23a4:	93b6                	add	t2,t2,a3
    23a6:	66c1                	lui	a3,0x10
    23a8:	fff68513          	addi	a0,a3,-1 # ffff <__ctor_end__+0xadaf>
    23ac:	8ce9                	and	s1,s1,a0
    23ae:	8fe9                	and	a5,a5,a0
    23b0:	02670533          	mul	a0,a4,t1
    23b4:	04c2                	slli	s1,s1,0x10
    23b6:	94be                	add	s1,s1,a5
    23b8:	02e28733          	mul	a4,t0,a4
    23bc:	02660333          	mul	t1,a2,t1
    23c0:	025602b3          	mul	t0,a2,t0
    23c4:	933a                	add	t1,t1,a4
    23c6:	01055613          	srli	a2,a0,0x10
    23ca:	9332                	add	t1,t1,a2
    23cc:	00e37363          	bgeu	t1,a4,23d2 <__muldf3+0x2aa>
    23d0:	92b6                	add	t0,t0,a3
    23d2:	47a2                	lw	a5,8(sp)
    23d4:	4762                	lw	a4,24(sp)
    23d6:	66c1                	lui	a3,0x10
    23d8:	16fd                	addi	a3,a3,-1
    23da:	973e                	add	a4,a4,a5
    23dc:	00d377b3          	and	a5,t1,a3
    23e0:	07c2                	slli	a5,a5,0x10
    23e2:	8d75                	and	a0,a0,a3
    23e4:	953e                	add	a0,a0,a5
    23e6:	47b2                	lw	a5,12(sp)
    23e8:	00b735b3          	sltu	a1,a4,a1
    23ec:	46b2                	lw	a3,12(sp)
    23ee:	953e                	add	a0,a0,a5
    23f0:	00b50633          	add	a2,a0,a1
    23f4:	9726                	add	a4,a4,s1
    23f6:	009737b3          	sltu	a5,a4,s1
    23fa:	00760433          	add	s0,a2,t2
    23fe:	00f404b3          	add	s1,s0,a5
    2402:	00d53533          	sltu	a0,a0,a3
    2406:	00b635b3          	sltu	a1,a2,a1
    240a:	00f4b7b3          	sltu	a5,s1,a5
    240e:	8dc9                	or	a1,a1,a0
    2410:	01035313          	srli	t1,t1,0x10
    2414:	007433b3          	sltu	t2,s0,t2
    2418:	959a                	add	a1,a1,t1
    241a:	00f3e7b3          	or	a5,t2,a5
    241e:	97ae                	add	a5,a5,a1
    2420:	4652                	lw	a2,20(sp)
    2422:	92be                	add	t0,t0,a5
    2424:	0174d693          	srli	a3,s1,0x17
    2428:	00929793          	slli	a5,t0,0x9
    242c:	8fd5                	or	a5,a5,a3
    242e:	00971693          	slli	a3,a4,0x9
    2432:	8ed1                	or	a3,a3,a2
    2434:	835d                	srli	a4,a4,0x17
    2436:	00d036b3          	snez	a3,a3
    243a:	8ed9                	or	a3,a3,a4
    243c:	01000737          	lui	a4,0x1000
    2440:	04a6                	slli	s1,s1,0x9
    2442:	8f7d                	and	a4,a4,a5
    2444:	8ec5                	or	a3,a3,s1
    2446:	c75d                	beqz	a4,24f4 <__muldf3+0x3cc>
    2448:	0016d713          	srli	a4,a3,0x1
    244c:	8a85                	andi	a3,a3,1
    244e:	8ed9                	or	a3,a3,a4
    2450:	01f79713          	slli	a4,a5,0x1f
    2454:	8ed9                	or	a3,a3,a4
    2456:	8385                	srli	a5,a5,0x1
  FP_PACK_D (r, R);
    2458:	4712                	lw	a4,4(sp)
    245a:	3ff70713          	addi	a4,a4,1023 # 10003ff <__ctor_end__+0xffb1af>
    245e:	08e05e63          	blez	a4,24fa <__muldf3+0x3d2>
    2462:	0076f613          	andi	a2,a3,7
    2466:	ce01                	beqz	a2,247e <__muldf3+0x356>
    2468:	00f6f613          	andi	a2,a3,15
    246c:	4591                	li	a1,4
    246e:	00b60863          	beq	a2,a1,247e <__muldf3+0x356>
    2472:	00468613          	addi	a2,a3,4 # 10004 <__ctor_end__+0xadb4>
    2476:	00d636b3          	sltu	a3,a2,a3
    247a:	97b6                	add	a5,a5,a3
    247c:	86b2                	mv	a3,a2
    247e:	01000637          	lui	a2,0x1000
    2482:	8e7d                	and	a2,a2,a5
    2484:	ca01                	beqz	a2,2494 <__muldf3+0x36c>
    2486:	ff000737          	lui	a4,0xff000
    248a:	177d                	addi	a4,a4,-1
    248c:	8ff9                	and	a5,a5,a4
    248e:	4712                	lw	a4,4(sp)
    2490:	40070713          	addi	a4,a4,1024 # ff000400 <__bss_end__+0xdeffe450>
    2494:	7fe00613          	li	a2,2046
    2498:	0ee64e63          	blt	a2,a4,2594 <__muldf3+0x46c>
    249c:	01d79613          	slli	a2,a5,0x1d
    24a0:	828d                	srli	a3,a3,0x3
    24a2:	8ed1                	or	a3,a3,a2
    24a4:	838d                	srli	a5,a5,0x3
    24a6:	7ff00637          	lui	a2,0x7ff00
    24aa:	0752                	slli	a4,a4,0x14
    24ac:	07b2                	slli	a5,a5,0xc
    24ae:	8f71                	and	a4,a4,a2
    24b0:	83b1                	srli	a5,a5,0xc
    24b2:	8fd9                	or	a5,a5,a4
    24b4:	4702                	lw	a4,0(sp)
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    24b6:	5092                	lw	ra,36(sp)
    24b8:	5402                	lw	s0,32(sp)
  FP_PACK_D (r, R);
    24ba:	077e                	slli	a4,a4,0x1f
    24bc:	00e7e633          	or	a2,a5,a4
}
    24c0:	44f2                	lw	s1,28(sp)
    24c2:	8536                	mv	a0,a3
    24c4:	85b2                	mv	a1,a2
    24c6:	02810113          	addi	sp,sp,40
    24ca:	8082                	ret
  FP_UNPACK_D (A, a);
    24cc:	47a2                	lw	a5,8(sp)
    24ce:	c03e                	sw	a5,0(sp)
  FP_MUL_D (R, A, B);
    24d0:	87a6                	mv	a5,s1
    24d2:	86ae                	mv	a3,a1
    24d4:	8722                	mv	a4,s0
  FP_PACK_D (r, R);
    24d6:	4609                	li	a2,2
    24d8:	0ac70e63          	beq	a4,a2,2594 <__muldf3+0x46c>
    24dc:	460d                	li	a2,3
    24de:	0ac70463          	beq	a4,a2,2586 <__muldf3+0x45e>
    24e2:	4605                	li	a2,1
    24e4:	f6c71ae3          	bne	a4,a2,2458 <__muldf3+0x330>
    24e8:	4781                	li	a5,0
    24ea:	4681                	li	a3,0
    24ec:	a0b5                	j	2558 <__muldf3+0x430>
  FP_UNPACK_D (B, b);
    24ee:	4632                	lw	a2,12(sp)
    24f0:	c032                	sw	a2,0(sp)
  FP_MUL_D (R, A, B);
    24f2:	b7d5                	j	24d6 <__muldf3+0x3ae>
    24f4:	4742                	lw	a4,16(sp)
    24f6:	c23a                	sw	a4,4(sp)
    24f8:	b785                	j	2458 <__muldf3+0x330>
  FP_PACK_D (r, R);
    24fa:	4585                	li	a1,1
    24fc:	8d99                	sub	a1,a1,a4
    24fe:	03800613          	li	a2,56
    2502:	feb643e3          	blt	a2,a1,24e8 <__muldf3+0x3c0>
    2506:	467d                	li	a2,31
    2508:	04b64a63          	blt	a2,a1,255c <__muldf3+0x434>
    250c:	4712                	lw	a4,4(sp)
    250e:	00b6d533          	srl	a0,a3,a1
    2512:	41e70713          	addi	a4,a4,1054
    2516:	00e79633          	sll	a2,a5,a4
    251a:	00e696b3          	sll	a3,a3,a4
    251e:	8e49                	or	a2,a2,a0
    2520:	00d036b3          	snez	a3,a3
    2524:	8ed1                	or	a3,a3,a2
    2526:	00b7d7b3          	srl	a5,a5,a1
    252a:	0076f713          	andi	a4,a3,7
    252e:	cf01                	beqz	a4,2546 <__muldf3+0x41e>
    2530:	00f6f713          	andi	a4,a3,15
    2534:	4611                	li	a2,4
    2536:	00c70863          	beq	a4,a2,2546 <__muldf3+0x41e>
    253a:	00468713          	addi	a4,a3,4
    253e:	00d736b3          	sltu	a3,a4,a3
    2542:	97b6                	add	a5,a5,a3
    2544:	86ba                	mv	a3,a4
    2546:	00800737          	lui	a4,0x800
    254a:	8f7d                	and	a4,a4,a5
    254c:	eb29                	bnez	a4,259e <__muldf3+0x476>
    254e:	01d79713          	slli	a4,a5,0x1d
    2552:	828d                	srli	a3,a3,0x3
    2554:	8ed9                	or	a3,a3,a4
    2556:	838d                	srli	a5,a5,0x3
    2558:	4701                	li	a4,0
    255a:	b7b1                	j	24a6 <__muldf3+0x37e>
    255c:	5605                	li	a2,-31
    255e:	40e60733          	sub	a4,a2,a4
    2562:	02000513          	li	a0,32
    2566:	00e7d733          	srl	a4,a5,a4
    256a:	4601                	li	a2,0
    256c:	00a58763          	beq	a1,a0,257a <__muldf3+0x452>
    2570:	4612                	lw	a2,4(sp)
    2572:	43e60613          	addi	a2,a2,1086 # 7ff0043e <__bss_end__+0x5fefe48e>
    2576:	00c79633          	sll	a2,a5,a2
    257a:	8ed1                	or	a3,a3,a2
    257c:	00d036b3          	snez	a3,a3
    2580:	8ed9                	or	a3,a3,a4
    2582:	4781                	li	a5,0
    2584:	b75d                	j	252a <__muldf3+0x402>
    2586:	000807b7          	lui	a5,0x80
    258a:	4681                	li	a3,0
    258c:	7ff00713          	li	a4,2047
    2590:	c002                	sw	zero,0(sp)
    2592:	bf11                	j	24a6 <__muldf3+0x37e>
    2594:	4781                	li	a5,0
    2596:	4681                	li	a3,0
    2598:	7ff00713          	li	a4,2047
    259c:	b729                	j	24a6 <__muldf3+0x37e>
    259e:	4781                	li	a5,0
    25a0:	4681                	li	a3,0
    25a2:	4705                	li	a4,1
    25a4:	b709                	j	24a6 <__muldf3+0x37e>

000025a6 <__subdf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
    25a6:	00100337          	lui	t1,0x100
    25aa:	137d                	addi	t1,t1,-1
{
    25ac:	1131                	addi	sp,sp,-20
  FP_UNPACK_SEMIRAW_D (A, a);
    25ae:	00b377b3          	and	a5,t1,a1
    25b2:	0145d713          	srli	a4,a1,0x14
{
    25b6:	c426                	sw	s1,8(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
    25b8:	078e                	slli	a5,a5,0x3
    25ba:	7ff77493          	andi	s1,a4,2047
    25be:	01d55713          	srli	a4,a0,0x1d
    25c2:	8fd9                	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
    25c4:	00d37733          	and	a4,t1,a3
{
    25c8:	c622                	sw	s0,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    25ca:	0146d313          	srli	t1,a3,0x14
  FP_UNPACK_SEMIRAW_D (A, a);
    25ce:	01f5d413          	srli	s0,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
    25d2:	070e                	slli	a4,a4,0x3
    25d4:	01d65593          	srli	a1,a2,0x1d
    25d8:	8f4d                	or	a4,a4,a1
{
    25da:	c806                	sw	ra,16(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    25dc:	7ff37313          	andi	t1,t1,2047
  FP_SUB_D (R, A, B);
    25e0:	7ff00593          	li	a1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
    25e4:	050e                	slli	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
    25e6:	82fd                	srli	a3,a3,0x1f
    25e8:	060e                	slli	a2,a2,0x3
  FP_SUB_D (R, A, B);
    25ea:	00b31563          	bne	t1,a1,25f4 <__subdf3+0x4e>
    25ee:	00c765b3          	or	a1,a4,a2
    25f2:	e199                	bnez	a1,25f8 <__subdf3+0x52>
    25f4:	0016c693          	xori	a3,a3,1
    25f8:	406482b3          	sub	t0,s1,t1
    25fc:	22869563          	bne	a3,s0,2826 <__subdf3+0x280>
    2600:	0e505263          	blez	t0,26e4 <__subdf3+0x13e>
    2604:	02031863          	bnez	t1,2634 <__subdf3+0x8e>
    2608:	00c766b3          	or	a3,a4,a2
    260c:	56068f63          	beqz	a3,2b8a <__subdf3+0x5e4>
    2610:	fff28593          	addi	a1,t0,-1 # ffff <__ctor_end__+0xadaf>
    2614:	e989                	bnez	a1,2626 <__subdf3+0x80>
    2616:	962a                	add	a2,a2,a0
    2618:	00a63533          	sltu	a0,a2,a0
    261c:	97ba                	add	a5,a5,a4
    261e:	97aa                	add	a5,a5,a0
    2620:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    2622:	4485                	li	s1,1
  FP_SUB_D (R, A, B);
    2624:	a8b9                	j	2682 <__subdf3+0xdc>
    2626:	7ff00693          	li	a3,2047
    262a:	00d29d63          	bne	t0,a3,2644 <__subdf3+0x9e>
    262e:	7ff00493          	li	s1,2047
    2632:	aa79                	j	27d0 <__subdf3+0x22a>
    2634:	7ff00693          	li	a3,2047
    2638:	18d48c63          	beq	s1,a3,27d0 <__subdf3+0x22a>
    263c:	008006b7          	lui	a3,0x800
    2640:	8f55                	or	a4,a4,a3
    2642:	8596                	mv	a1,t0
    2644:	03800693          	li	a3,56
    2648:	08b6ca63          	blt	a3,a1,26dc <__subdf3+0x136>
    264c:	46fd                	li	a3,31
    264e:	06b6c163          	blt	a3,a1,26b0 <__subdf3+0x10a>
    2652:	02000313          	li	t1,32
    2656:	40b30333          	sub	t1,t1,a1
    265a:	006716b3          	sll	a3,a4,t1
    265e:	00b652b3          	srl	t0,a2,a1
    2662:	00661633          	sll	a2,a2,t1
    2666:	0056e6b3          	or	a3,a3,t0
    266a:	00c03633          	snez	a2,a2
    266e:	8e55                	or	a2,a2,a3
    2670:	00b75733          	srl	a4,a4,a1
    2674:	962a                	add	a2,a2,a0
    2676:	00a63533          	sltu	a0,a2,a0
    267a:	973e                	add	a4,a4,a5
    267c:	00a707b3          	add	a5,a4,a0
    2680:	8532                	mv	a0,a2
    2682:	00800737          	lui	a4,0x800
    2686:	8f7d                	and	a4,a4,a5
    2688:	14070463          	beqz	a4,27d0 <__subdf3+0x22a>
    268c:	0485                	addi	s1,s1,1
    268e:	7ff00713          	li	a4,2047
    2692:	48e48c63          	beq	s1,a4,2b2a <__subdf3+0x584>
    2696:	ff800737          	lui	a4,0xff800
    269a:	177d                	addi	a4,a4,-1
    269c:	8ff9                	and	a5,a5,a4
    269e:	00155713          	srli	a4,a0,0x1
    26a2:	8905                	andi	a0,a0,1
    26a4:	8d59                	or	a0,a0,a4
    26a6:	01f79713          	slli	a4,a5,0x1f
    26aa:	8d59                	or	a0,a0,a4
    26ac:	8385                	srli	a5,a5,0x1
    26ae:	a20d                	j	27d0 <__subdf3+0x22a>
    26b0:	fe058693          	addi	a3,a1,-32
    26b4:	02000293          	li	t0,32
    26b8:	00d756b3          	srl	a3,a4,a3
    26bc:	4301                	li	t1,0
    26be:	00558863          	beq	a1,t0,26ce <__subdf3+0x128>
    26c2:	04000313          	li	t1,64
    26c6:	40b305b3          	sub	a1,t1,a1
    26ca:	00b71333          	sll	t1,a4,a1
    26ce:	00c36633          	or	a2,t1,a2
    26d2:	00c03633          	snez	a2,a2
    26d6:	8e55                	or	a2,a2,a3
    26d8:	4701                	li	a4,0
    26da:	bf69                	j	2674 <__subdf3+0xce>
    26dc:	8e59                	or	a2,a2,a4
    26de:	00c03633          	snez	a2,a2
    26e2:	bfdd                	j	26d8 <__subdf3+0x132>
    26e4:	0a028a63          	beqz	t0,2798 <__subdf3+0x1f2>
    26e8:	409305b3          	sub	a1,t1,s1
    26ec:	e48d                	bnez	s1,2716 <__subdf3+0x170>
    26ee:	00a7e6b3          	or	a3,a5,a0
    26f2:	42068363          	beqz	a3,2b18 <__subdf3+0x572>
    26f6:	fff58693          	addi	a3,a1,-1
    26fa:	e699                	bnez	a3,2708 <__subdf3+0x162>
    26fc:	9532                	add	a0,a0,a2
    26fe:	97ba                	add	a5,a5,a4
    2700:	00c53633          	sltu	a2,a0,a2
    2704:	97b2                	add	a5,a5,a2
    2706:	bf31                	j	2622 <__subdf3+0x7c>
    2708:	7ff00293          	li	t0,2047
    270c:	00559d63          	bne	a1,t0,2726 <__subdf3+0x180>
  FP_UNPACK_SEMIRAW_D (B, b);
    2710:	87ba                	mv	a5,a4
    2712:	8532                	mv	a0,a2
    2714:	bf29                	j	262e <__subdf3+0x88>
  FP_SUB_D (R, A, B);
    2716:	7ff00693          	li	a3,2047
    271a:	fed30be3          	beq	t1,a3,2710 <__subdf3+0x16a>
    271e:	008006b7          	lui	a3,0x800
    2722:	8fd5                	or	a5,a5,a3
    2724:	86ae                	mv	a3,a1
    2726:	03800593          	li	a1,56
    272a:	06d5c363          	blt	a1,a3,2790 <__subdf3+0x1ea>
    272e:	45fd                	li	a1,31
    2730:	02d5ca63          	blt	a1,a3,2764 <__subdf3+0x1be>
    2734:	02000293          	li	t0,32
    2738:	40d282b3          	sub	t0,t0,a3
    273c:	005795b3          	sll	a1,a5,t0
    2740:	00d553b3          	srl	t2,a0,a3
    2744:	00551533          	sll	a0,a0,t0
    2748:	0075e5b3          	or	a1,a1,t2
    274c:	00a03533          	snez	a0,a0
    2750:	8d4d                	or	a0,a0,a1
    2752:	00d7d7b3          	srl	a5,a5,a3
    2756:	9532                	add	a0,a0,a2
    2758:	97ba                	add	a5,a5,a4
    275a:	00c53633          	sltu	a2,a0,a2
    275e:	97b2                	add	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    2760:	849a                	mv	s1,t1
    2762:	b705                	j	2682 <__subdf3+0xdc>
  FP_SUB_D (R, A, B);
    2764:	fe068593          	addi	a1,a3,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    2768:	02000393          	li	t2,32
    276c:	00b7d5b3          	srl	a1,a5,a1
    2770:	4281                	li	t0,0
    2772:	00768863          	beq	a3,t2,2782 <__subdf3+0x1dc>
    2776:	04000293          	li	t0,64
    277a:	40d286b3          	sub	a3,t0,a3
    277e:	00d792b3          	sll	t0,a5,a3
    2782:	00a2e533          	or	a0,t0,a0
    2786:	00a03533          	snez	a0,a0
    278a:	8d4d                	or	a0,a0,a1
    278c:	4781                	li	a5,0
    278e:	b7e1                	j	2756 <__subdf3+0x1b0>
    2790:	8d5d                	or	a0,a0,a5
    2792:	00a03533          	snez	a0,a0
    2796:	bfdd                	j	278c <__subdf3+0x1e6>
    2798:	00148693          	addi	a3,s1,1
    279c:	7fe6f593          	andi	a1,a3,2046
    27a0:	e1bd                	bnez	a1,2806 <__subdf3+0x260>
    27a2:	00a7e6b3          	or	a3,a5,a0
    27a6:	e4a9                	bnez	s1,27f0 <__subdf3+0x24a>
    27a8:	36068c63          	beqz	a3,2b20 <__subdf3+0x57a>
    27ac:	00c766b3          	or	a3,a4,a2
    27b0:	c285                	beqz	a3,27d0 <__subdf3+0x22a>
    27b2:	962a                	add	a2,a2,a0
    27b4:	97ba                	add	a5,a5,a4
    27b6:	00a63533          	sltu	a0,a2,a0
    27ba:	97aa                	add	a5,a5,a0
    27bc:	00800737          	lui	a4,0x800
    27c0:	8f7d                	and	a4,a4,a5
    27c2:	8532                	mv	a0,a2
    27c4:	c711                	beqz	a4,27d0 <__subdf3+0x22a>
    27c6:	ff800737          	lui	a4,0xff800
    27ca:	177d                	addi	a4,a4,-1
    27cc:	8ff9                	and	a5,a5,a4
    27ce:	4485                	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
    27d0:	00757713          	andi	a4,a0,7
    27d4:	34070d63          	beqz	a4,2b2e <__subdf3+0x588>
    27d8:	00f57713          	andi	a4,a0,15
    27dc:	4691                	li	a3,4
    27de:	34d70863          	beq	a4,a3,2b2e <__subdf3+0x588>
    27e2:	00450713          	addi	a4,a0,4
    27e6:	00a73533          	sltu	a0,a4,a0
    27ea:	97aa                	add	a5,a5,a0
    27ec:	853a                	mv	a0,a4
    27ee:	a681                	j	2b2e <__subdf3+0x588>
  FP_SUB_D (R, A, B);
    27f0:	d285                	beqz	a3,2710 <__subdf3+0x16a>
    27f2:	8e59                	or	a2,a2,a4
    27f4:	e2060de3          	beqz	a2,262e <__subdf3+0x88>
    27f8:	4401                	li	s0,0
    27fa:	004007b7          	lui	a5,0x400
    27fe:	4501                	li	a0,0
    2800:	7ff00493          	li	s1,2047
    2804:	a62d                	j	2b2e <__subdf3+0x588>
    2806:	7ff00593          	li	a1,2047
    280a:	30b68e63          	beq	a3,a1,2b26 <__subdf3+0x580>
    280e:	962a                	add	a2,a2,a0
    2810:	00a63533          	sltu	a0,a2,a0
    2814:	97ba                	add	a5,a5,a4
    2816:	97aa                	add	a5,a5,a0
    2818:	01f79513          	slli	a0,a5,0x1f
    281c:	8205                	srli	a2,a2,0x1
    281e:	8d51                	or	a0,a0,a2
    2820:	8385                	srli	a5,a5,0x1
    2822:	84b6                	mv	s1,a3
    2824:	b775                	j	27d0 <__subdf3+0x22a>
    2826:	0c505563          	blez	t0,28f0 <__subdf3+0x34a>
    282a:	08031063          	bnez	t1,28aa <__subdf3+0x304>
    282e:	00c766b3          	or	a3,a4,a2
    2832:	34068c63          	beqz	a3,2b8a <__subdf3+0x5e4>
    2836:	fff28593          	addi	a1,t0,-1
    283a:	e991                	bnez	a1,284e <__subdf3+0x2a8>
    283c:	40c50633          	sub	a2,a0,a2
    2840:	00c53533          	sltu	a0,a0,a2
    2844:	8f99                	sub	a5,a5,a4
    2846:	8f89                	sub	a5,a5,a0
    2848:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    284a:	4485                	li	s1,1
  FP_SUB_D (R, A, B);
    284c:	a0b1                	j	2898 <__subdf3+0x2f2>
    284e:	7ff00693          	li	a3,2047
    2852:	dcd28ee3          	beq	t0,a3,262e <__subdf3+0x88>
    2856:	03800693          	li	a3,56
    285a:	08b6c763          	blt	a3,a1,28e8 <__subdf3+0x342>
    285e:	46fd                	li	a3,31
    2860:	04b6ce63          	blt	a3,a1,28bc <__subdf3+0x316>
    2864:	02000313          	li	t1,32
    2868:	40b30333          	sub	t1,t1,a1
    286c:	006716b3          	sll	a3,a4,t1
    2870:	00b652b3          	srl	t0,a2,a1
    2874:	00661633          	sll	a2,a2,t1
    2878:	0056e6b3          	or	a3,a3,t0
    287c:	00c03633          	snez	a2,a2
    2880:	8e55                	or	a2,a2,a3
    2882:	00b75733          	srl	a4,a4,a1
    2886:	40c50633          	sub	a2,a0,a2
    288a:	00c53533          	sltu	a0,a0,a2
    288e:	40e78733          	sub	a4,a5,a4
    2892:	40a707b3          	sub	a5,a4,a0
    2896:	8532                	mv	a0,a2
    2898:	008005b7          	lui	a1,0x800
    289c:	00b7f733          	and	a4,a5,a1
    28a0:	db05                	beqz	a4,27d0 <__subdf3+0x22a>
    28a2:	15fd                	addi	a1,a1,-1
    28a4:	8dfd                	and	a1,a1,a5
    28a6:	832a                	mv	t1,a0
    28a8:	aa5d                	j	2a5e <__subdf3+0x4b8>
    28aa:	7ff00693          	li	a3,2047
    28ae:	f2d481e3          	beq	s1,a3,27d0 <__subdf3+0x22a>
    28b2:	008006b7          	lui	a3,0x800
    28b6:	8f55                	or	a4,a4,a3
    28b8:	8596                	mv	a1,t0
    28ba:	bf71                	j	2856 <__subdf3+0x2b0>
    28bc:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    28c0:	02000293          	li	t0,32
    28c4:	00d756b3          	srl	a3,a4,a3
    28c8:	4301                	li	t1,0
    28ca:	00558863          	beq	a1,t0,28da <__subdf3+0x334>
    28ce:	04000313          	li	t1,64
    28d2:	40b305b3          	sub	a1,t1,a1
    28d6:	00b71333          	sll	t1,a4,a1
    28da:	00c36633          	or	a2,t1,a2
    28de:	00c03633          	snez	a2,a2
    28e2:	8e55                	or	a2,a2,a3
    28e4:	4701                	li	a4,0
    28e6:	b745                	j	2886 <__subdf3+0x2e0>
    28e8:	8e59                	or	a2,a2,a4
    28ea:	00c03633          	snez	a2,a2
    28ee:	bfdd                	j	28e4 <__subdf3+0x33e>
    28f0:	0c028463          	beqz	t0,29b8 <__subdf3+0x412>
    28f4:	409302b3          	sub	t0,t1,s1
    28f8:	e895                	bnez	s1,292c <__subdf3+0x386>
    28fa:	00a7e5b3          	or	a1,a5,a0
    28fe:	28058863          	beqz	a1,2b8e <__subdf3+0x5e8>
    2902:	fff28593          	addi	a1,t0,-1
    2906:	e991                	bnez	a1,291a <__subdf3+0x374>
    2908:	40a60533          	sub	a0,a2,a0
    290c:	40f707b3          	sub	a5,a4,a5
    2910:	00a63633          	sltu	a2,a2,a0
    2914:	8f91                	sub	a5,a5,a2
    2916:	8436                	mv	s0,a3
    2918:	bf0d                	j	284a <__subdf3+0x2a4>
    291a:	7ff00393          	li	t2,2047
    291e:	00729f63          	bne	t0,t2,293c <__subdf3+0x396>
  FP_UNPACK_SEMIRAW_D (B, b);
    2922:	87ba                	mv	a5,a4
    2924:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    2926:	7ff00493          	li	s1,2047
    292a:	a07d                	j	29d8 <__subdf3+0x432>
    292c:	7ff00593          	li	a1,2047
    2930:	feb309e3          	beq	t1,a1,2922 <__subdf3+0x37c>
    2934:	008005b7          	lui	a1,0x800
    2938:	8fcd                	or	a5,a5,a1
    293a:	8596                	mv	a1,t0
    293c:	03800293          	li	t0,56
    2940:	06b2c863          	blt	t0,a1,29b0 <__subdf3+0x40a>
    2944:	42fd                	li	t0,31
    2946:	02b2ce63          	blt	t0,a1,2982 <__subdf3+0x3dc>
    294a:	02000393          	li	t2,32
    294e:	40b383b3          	sub	t2,t2,a1
    2952:	007792b3          	sll	t0,a5,t2
    2956:	00b55433          	srl	s0,a0,a1
    295a:	00751533          	sll	a0,a0,t2
    295e:	0082e2b3          	or	t0,t0,s0
    2962:	00a03533          	snez	a0,a0
    2966:	00a2e533          	or	a0,t0,a0
    296a:	00b7d7b3          	srl	a5,a5,a1
    296e:	40a60533          	sub	a0,a2,a0
    2972:	40f707b3          	sub	a5,a4,a5
    2976:	00a63633          	sltu	a2,a2,a0
    297a:	8f91                	sub	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    297c:	849a                	mv	s1,t1
    297e:	8436                	mv	s0,a3
    2980:	bf21                	j	2898 <__subdf3+0x2f2>
  FP_SUB_D (R, A, B);
    2982:	fe058293          	addi	t0,a1,-32 # 7fffe0 <__ctor_end__+0x7fad90>
    2986:	02000413          	li	s0,32
    298a:	0057d2b3          	srl	t0,a5,t0
    298e:	4381                	li	t2,0
    2990:	00858863          	beq	a1,s0,29a0 <__subdf3+0x3fa>
    2994:	04000393          	li	t2,64
    2998:	40b385b3          	sub	a1,t2,a1
    299c:	00b793b3          	sll	t2,a5,a1
    29a0:	00a3e533          	or	a0,t2,a0
    29a4:	00a03533          	snez	a0,a0
    29a8:	00a2e533          	or	a0,t0,a0
    29ac:	4781                	li	a5,0
    29ae:	b7c1                	j	296e <__subdf3+0x3c8>
    29b0:	8d5d                	or	a0,a0,a5
    29b2:	00a03533          	snez	a0,a0
    29b6:	bfdd                	j	29ac <__subdf3+0x406>
    29b8:	00148593          	addi	a1,s1,1
    29bc:	7fe5f593          	andi	a1,a1,2046
    29c0:	e9a5                	bnez	a1,2a30 <__subdf3+0x48a>
    29c2:	00c765b3          	or	a1,a4,a2
    29c6:	00a7e333          	or	t1,a5,a0
    29ca:	e8a1                	bnez	s1,2a1a <__subdf3+0x474>
    29cc:	00031863          	bnez	t1,29dc <__subdf3+0x436>
    29d0:	1c058363          	beqz	a1,2b96 <__subdf3+0x5f0>
  FP_UNPACK_SEMIRAW_D (B, b);
    29d4:	87ba                	mv	a5,a4
    29d6:	8532                	mv	a0,a2
    29d8:	8436                	mv	s0,a3
    29da:	bbdd                	j	27d0 <__subdf3+0x22a>
  FP_SUB_D (R, A, B);
    29dc:	de058ae3          	beqz	a1,27d0 <__subdf3+0x22a>
    29e0:	40c50333          	sub	t1,a0,a2
    29e4:	006532b3          	sltu	t0,a0,t1
    29e8:	40e785b3          	sub	a1,a5,a4
    29ec:	405585b3          	sub	a1,a1,t0
    29f0:	008002b7          	lui	t0,0x800
    29f4:	0055f2b3          	and	t0,a1,t0
    29f8:	00028a63          	beqz	t0,2a0c <__subdf3+0x466>
    29fc:	40a60533          	sub	a0,a2,a0
    2a00:	40f707b3          	sub	a5,a4,a5
    2a04:	00a63633          	sltu	a2,a2,a0
    2a08:	8f91                	sub	a5,a5,a2
    2a0a:	b7f9                	j	29d8 <__subdf3+0x432>
    2a0c:	00b36533          	or	a0,t1,a1
    2a10:	18050763          	beqz	a0,2b9e <__subdf3+0x5f8>
    2a14:	87ae                	mv	a5,a1
    2a16:	851a                	mv	a0,t1
    2a18:	bb65                	j	27d0 <__subdf3+0x22a>
    2a1a:	00031863          	bnez	t1,2a2a <__subdf3+0x484>
    2a1e:	18058263          	beqz	a1,2ba2 <__subdf3+0x5fc>
  FP_UNPACK_SEMIRAW_D (B, b);
    2a22:	87ba                	mv	a5,a4
    2a24:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    2a26:	8436                	mv	s0,a3
    2a28:	b119                	j	262e <__subdf3+0x88>
    2a2a:	c00582e3          	beqz	a1,262e <__subdf3+0x88>
    2a2e:	b3e9                	j	27f8 <__subdf3+0x252>
    2a30:	40c50333          	sub	t1,a0,a2
    2a34:	006532b3          	sltu	t0,a0,t1
    2a38:	40e785b3          	sub	a1,a5,a4
    2a3c:	405585b3          	sub	a1,a1,t0
    2a40:	008002b7          	lui	t0,0x800
    2a44:	0055f2b3          	and	t0,a1,t0
    2a48:	06028a63          	beqz	t0,2abc <__subdf3+0x516>
    2a4c:	40a60333          	sub	t1,a2,a0
    2a50:	40f707b3          	sub	a5,a4,a5
    2a54:	00663633          	sltu	a2,a2,t1
    2a58:	40c785b3          	sub	a1,a5,a2
    2a5c:	8436                	mv	s0,a3
    2a5e:	c5ad                	beqz	a1,2ac8 <__subdf3+0x522>
    2a60:	852e                	mv	a0,a1
    2a62:	c21a                	sw	t1,4(sp)
    2a64:	c02e                	sw	a1,0(sp)
    2a66:	2c19                	jal	2c7c <__clzsi2>
    2a68:	4582                	lw	a1,0(sp)
    2a6a:	4312                	lw	t1,4(sp)
    2a6c:	ff850713          	addi	a4,a0,-8
    2a70:	47fd                	li	a5,31
    2a72:	06e7c463          	blt	a5,a4,2ada <__subdf3+0x534>
    2a76:	02000793          	li	a5,32
    2a7a:	8f99                	sub	a5,a5,a4
    2a7c:	00e595b3          	sll	a1,a1,a4
    2a80:	00f357b3          	srl	a5,t1,a5
    2a84:	8fcd                	or	a5,a5,a1
    2a86:	00e31533          	sll	a0,t1,a4
    2a8a:	08974163          	blt	a4,s1,2b0c <__subdf3+0x566>
    2a8e:	8f05                	sub	a4,a4,s1
    2a90:	00170613          	addi	a2,a4,1 # ff800001 <__bss_end__+0xdf7fe051>
    2a94:	46fd                	li	a3,31
    2a96:	04c6c863          	blt	a3,a2,2ae6 <__subdf3+0x540>
    2a9a:	02000713          	li	a4,32
    2a9e:	8f11                	sub	a4,a4,a2
    2aa0:	00e796b3          	sll	a3,a5,a4
    2aa4:	00c555b3          	srl	a1,a0,a2
    2aa8:	00e51533          	sll	a0,a0,a4
    2aac:	8ecd                	or	a3,a3,a1
    2aae:	00a03533          	snez	a0,a0
    2ab2:	8d55                	or	a0,a0,a3
    2ab4:	00c7d7b3          	srl	a5,a5,a2
    2ab8:	4481                	li	s1,0
    2aba:	bb19                	j	27d0 <__subdf3+0x22a>
    2abc:	00b36533          	or	a0,t1,a1
    2ac0:	fd59                	bnez	a0,2a5e <__subdf3+0x4b8>
    2ac2:	4781                	li	a5,0
    2ac4:	4481                	li	s1,0
    2ac6:	a8d1                	j	2b9a <__subdf3+0x5f4>
    2ac8:	851a                	mv	a0,t1
    2aca:	c22e                	sw	a1,4(sp)
    2acc:	c01a                	sw	t1,0(sp)
    2ace:	227d                	jal	2c7c <__clzsi2>
    2ad0:	4592                	lw	a1,4(sp)
    2ad2:	4302                	lw	t1,0(sp)
    2ad4:	02050513          	addi	a0,a0,32
    2ad8:	bf51                	j	2a6c <__subdf3+0x4c6>
    2ada:	fd850793          	addi	a5,a0,-40
    2ade:	00f317b3          	sll	a5,t1,a5
    2ae2:	4501                	li	a0,0
    2ae4:	b75d                	j	2a8a <__subdf3+0x4e4>
    2ae6:	1705                	addi	a4,a4,-31
    2ae8:	02000593          	li	a1,32
    2aec:	00e7d733          	srl	a4,a5,a4
    2af0:	4681                	li	a3,0
    2af2:	00b60763          	beq	a2,a1,2b00 <__subdf3+0x55a>
    2af6:	04000693          	li	a3,64
    2afa:	8e91                	sub	a3,a3,a2
    2afc:	00d796b3          	sll	a3,a5,a3
    2b00:	8d55                	or	a0,a0,a3
    2b02:	00a03533          	snez	a0,a0
    2b06:	8d59                	or	a0,a0,a4
    2b08:	4781                	li	a5,0
    2b0a:	b77d                	j	2ab8 <__subdf3+0x512>
    2b0c:	8c99                	sub	s1,s1,a4
    2b0e:	ff800737          	lui	a4,0xff800
    2b12:	177d                	addi	a4,a4,-1
    2b14:	8ff9                	and	a5,a5,a4
    2b16:	b96d                	j	27d0 <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    2b18:	87ba                	mv	a5,a4
    2b1a:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    2b1c:	84ae                	mv	s1,a1
    2b1e:	b94d                	j	27d0 <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    2b20:	87ba                	mv	a5,a4
    2b22:	8532                	mv	a0,a2
    2b24:	b175                	j	27d0 <__subdf3+0x22a>
    2b26:	7ff00493          	li	s1,2047
    2b2a:	4781                	li	a5,0
    2b2c:	4501                	li	a0,0
  FP_PACK_SEMIRAW_D (r, R);
    2b2e:	00800737          	lui	a4,0x800
    2b32:	8f7d                	and	a4,a4,a5
    2b34:	cb11                	beqz	a4,2b48 <__subdf3+0x5a2>
    2b36:	0485                	addi	s1,s1,1
    2b38:	7ff00713          	li	a4,2047
    2b3c:	06e48863          	beq	s1,a4,2bac <__subdf3+0x606>
    2b40:	ff800737          	lui	a4,0xff800
    2b44:	177d                	addi	a4,a4,-1
    2b46:	8ff9                	and	a5,a5,a4
    2b48:	01d79713          	slli	a4,a5,0x1d
    2b4c:	810d                	srli	a0,a0,0x3
    2b4e:	8d59                	or	a0,a0,a4
    2b50:	7ff00713          	li	a4,2047
    2b54:	838d                	srli	a5,a5,0x3
    2b56:	00e49963          	bne	s1,a4,2b68 <__subdf3+0x5c2>
    2b5a:	8d5d                	or	a0,a0,a5
    2b5c:	4781                	li	a5,0
    2b5e:	c509                	beqz	a0,2b68 <__subdf3+0x5c2>
    2b60:	000807b7          	lui	a5,0x80
    2b64:	4501                	li	a0,0
    2b66:	4401                	li	s0,0
    2b68:	01449713          	slli	a4,s1,0x14
    2b6c:	7ff006b7          	lui	a3,0x7ff00
    2b70:	07b2                	slli	a5,a5,0xc
    2b72:	8f75                	and	a4,a4,a3
    2b74:	83b1                	srli	a5,a5,0xc
    2b76:	047e                	slli	s0,s0,0x1f
    2b78:	8fd9                	or	a5,a5,a4
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    2b7a:	40c2                	lw	ra,16(sp)
  FP_PACK_SEMIRAW_D (r, R);
    2b7c:	0087e733          	or	a4,a5,s0
}
    2b80:	4432                	lw	s0,12(sp)
    2b82:	44a2                	lw	s1,8(sp)
    2b84:	85ba                	mv	a1,a4
    2b86:	0151                	addi	sp,sp,20
    2b88:	8082                	ret
    2b8a:	8496                	mv	s1,t0
    2b8c:	b191                	j	27d0 <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    2b8e:	87ba                	mv	a5,a4
    2b90:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    2b92:	8496                	mv	s1,t0
    2b94:	b591                	j	29d8 <__subdf3+0x432>
    2b96:	4781                	li	a5,0
    2b98:	4501                	li	a0,0
    2b9a:	4401                	li	s0,0
    2b9c:	bf49                	j	2b2e <__subdf3+0x588>
    2b9e:	4781                	li	a5,0
    2ba0:	bfed                	j	2b9a <__subdf3+0x5f4>
    2ba2:	4501                	li	a0,0
    2ba4:	4401                	li	s0,0
    2ba6:	004007b7          	lui	a5,0x400
    2baa:	b999                	j	2800 <__subdf3+0x25a>
    2bac:	4781                	li	a5,0
    2bae:	4501                	li	a0,0
    2bb0:	bf61                	j	2b48 <__subdf3+0x5a2>

00002bb2 <__fixdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    2bb2:	0145d713          	srli	a4,a1,0x14
    2bb6:	001006b7          	lui	a3,0x100
    2bba:	fff68793          	addi	a5,a3,-1 # fffff <__ctor_end__+0xfadaf>
    2bbe:	7ff77713          	andi	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 1);
    2bc2:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
    2bc6:	8fed                	and	a5,a5,a1
    2bc8:	81fd                	srli	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 1);
    2bca:	04e65463          	bge	a2,a4,2c12 <__fixdfsi+0x60>
    2bce:	41d00613          	li	a2,1053
    2bd2:	00e65863          	bge	a2,a4,2be2 <__fixdfsi+0x30>
    2bd6:	80000537          	lui	a0,0x80000
    2bda:	fff54513          	not	a0,a0
    2bde:	952e                	add	a0,a0,a1
    2be0:	8082                	ret
    2be2:	8fd5                	or	a5,a5,a3
    2be4:	43300693          	li	a3,1075
    2be8:	8e99                	sub	a3,a3,a4
    2bea:	467d                	li	a2,31
    2bec:	00d64d63          	blt	a2,a3,2c06 <__fixdfsi+0x54>
    2bf0:	bed70713          	addi	a4,a4,-1043 # ff7ffbed <__bss_end__+0xdf7fdc3d>
    2bf4:	00e797b3          	sll	a5,a5,a4
    2bf8:	00d55533          	srl	a0,a0,a3
    2bfc:	8d5d                	or	a0,a0,a5
    2bfe:	c999                	beqz	a1,2c14 <__fixdfsi+0x62>
    2c00:	40a00533          	neg	a0,a0
    2c04:	8082                	ret
    2c06:	41300513          	li	a0,1043
    2c0a:	8d19                	sub	a0,a0,a4
    2c0c:	00a7d533          	srl	a0,a5,a0
    2c10:	b7fd                	j	2bfe <__fixdfsi+0x4c>
    2c12:	4501                	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    2c14:	8082                	ret

00002c16 <__floatsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatsidf (SItype i)
{
    2c16:	1151                	addi	sp,sp,-12
    2c18:	c406                	sw	ra,8(sp)
    2c1a:	c222                	sw	s0,4(sp)
    2c1c:	c026                	sw	s1,0(sp)
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
    2c1e:	cd21                	beqz	a0,2c76 <__floatsidf+0x60>
    2c20:	41f55793          	srai	a5,a0,0x1f
    2c24:	00a7c433          	xor	s0,a5,a0
    2c28:	8c1d                	sub	s0,s0,a5
    2c2a:	01f55493          	srli	s1,a0,0x1f
    2c2e:	8522                	mv	a0,s0
    2c30:	20b1                	jal	2c7c <__clzsi2>
    2c32:	41e00713          	li	a4,1054
    2c36:	47a9                	li	a5,10
    2c38:	8f09                	sub	a4,a4,a0
    2c3a:	02a7c863          	blt	a5,a0,2c6a <__floatsidf+0x54>
    2c3e:	47ad                	li	a5,11
    2c40:	8f89                	sub	a5,a5,a0
    2c42:	0555                	addi	a0,a0,21
    2c44:	00f457b3          	srl	a5,s0,a5
    2c48:	00a41433          	sll	s0,s0,a0
    2c4c:	8526                	mv	a0,s1
  FP_PACK_RAW_D (a, A);
    2c4e:	07b2                	slli	a5,a5,0xc
    2c50:	0752                	slli	a4,a4,0x14
    2c52:	83b1                	srli	a5,a5,0xc
    2c54:	057e                	slli	a0,a0,0x1f
    2c56:	8fd9                	or	a5,a5,a4

  return a;
}
    2c58:	40a2                	lw	ra,8(sp)
  FP_PACK_RAW_D (a, A);
    2c5a:	00a7e733          	or	a4,a5,a0
}
    2c5e:	8522                	mv	a0,s0
    2c60:	4412                	lw	s0,4(sp)
    2c62:	4482                	lw	s1,0(sp)
    2c64:	85ba                	mv	a1,a4
    2c66:	0131                	addi	sp,sp,12
    2c68:	8082                	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
    2c6a:	1555                	addi	a0,a0,-11
    2c6c:	00a417b3          	sll	a5,s0,a0
    2c70:	8526                	mv	a0,s1
    2c72:	4401                	li	s0,0
    2c74:	bfe9                	j	2c4e <__floatsidf+0x38>
    2c76:	4701                	li	a4,0
    2c78:	4781                	li	a5,0
    2c7a:	bfe5                	j	2c72 <__floatsidf+0x5c>

00002c7c <__clzsi2>:
  count_leading_zeros (ret, x);
    2c7c:	67c1                	lui	a5,0x10
    2c7e:	02f57563          	bgeu	a0,a5,2ca8 <__clzsi2+0x2c>
    2c82:	0ff00793          	li	a5,255
    2c86:	00a7b7b3          	sltu	a5,a5,a0
    2c8a:	078e                	slli	a5,a5,0x3
    2c8c:	6715                	lui	a4,0x5
    2c8e:	02000693          	li	a3,32
    2c92:	8e9d                	sub	a3,a3,a5
    2c94:	00f55533          	srl	a0,a0,a5
    2c98:	82870793          	addi	a5,a4,-2008 # 4828 <__clz_tab>
    2c9c:	953e                	add	a0,a0,a5
    2c9e:	00054503          	lbu	a0,0(a0) # 80000000 <__bss_end__+0x5fffe050>
}
    2ca2:	40a68533          	sub	a0,a3,a0
    2ca6:	8082                	ret
  count_leading_zeros (ret, x);
    2ca8:	01000737          	lui	a4,0x1000
    2cac:	47c1                	li	a5,16
    2cae:	fce56fe3          	bltu	a0,a4,2c8c <__clzsi2+0x10>
    2cb2:	47e1                	li	a5,24
    2cb4:	bfe1                	j	2c8c <__clzsi2+0x10>

00002cb6 <fputc>:
{
    return 0;
}

int fputc(int ch, FILE *stream)
{
    2cb6:	1151                	addi	sp,sp,-12
    2cb8:	c026                	sw	s1,0(sp)
    2cba:	84aa                	mv	s1,a0
    (void)stream;

    if (console_handle == NULL) {
    2cbc:	00c1a503          	lw	a0,12(gp) # 200001ec <console_handle>
{
    2cc0:	c406                	sw	ra,8(sp)
    2cc2:	c222                	sw	s0,4(sp)
    if (console_handle == NULL) {
    2cc4:	c115                	beqz	a0,2ce8 <fputc+0x32>
    2cc6:	00c18413          	addi	s0,gp,12 # 200001ec <console_handle>
        return -1;
    }

    if (ch == '\n') {
    2cca:	47a9                	li	a5,10
    2ccc:	00f49463          	bne	s1,a5,2cd4 <fputc+0x1e>
        drv_uart_putc(console_handle, '\r');
    2cd0:	45b5                	li	a1,13
    2cd2:	2879                	jal	2d70 <drv_uart_putc>
    }

    drv_uart_putc(console_handle, ch);
    2cd4:	4008                	lw	a0,0(s0)
    2cd6:	0ff4f593          	zext.b	a1,s1
    2cda:	2859                	jal	2d70 <drv_uart_putc>


    return 0;
    2cdc:	4501                	li	a0,0
}
    2cde:	40a2                	lw	ra,8(sp)
    2ce0:	4412                	lw	s0,4(sp)
    2ce2:	4482                	lw	s1,0(sp)
    2ce4:	0131                	addi	sp,sp,12
    2ce6:	8082                	ret
        return -1;
    2ce8:	557d                	li	a0,-1
    2cea:	bfd5                	j	2cde <fputc+0x28>

00002cec <os_critical_enter>:
    drv_uart_getc(console_handle, &ch);

    return ch;
}

int os_critical_enter(unsigned int *lock){
    2cec:	1151                	addi	sp,sp,-12
    2cee:	c406                	sw	ra,8(sp)
     (void)lock;
     kos_kernel_sched_suspend();
    2cf0:	24dd                	jal	2fd6 <kos_kernel_sched_suspend>
     return 0;
}
    2cf2:	40a2                	lw	ra,8(sp)
    2cf4:	4501                	li	a0,0
    2cf6:	0131                	addi	sp,sp,12
    2cf8:	8082                	ret

00002cfa <os_critical_exit>:

int os_critical_exit(unsigned int *lock){
    2cfa:	1151                	addi	sp,sp,-12
     (void)lock;
     kos_kernel_sched_resume(0);
    2cfc:	4501                	li	a0,0
int os_critical_exit(unsigned int *lock){
    2cfe:	c406                	sw	ra,8(sp)
     kos_kernel_sched_resume(0);
    2d00:	2ccd                	jal	2ff2 <kos_kernel_sched_resume>
     return 0;
}
    2d02:	40a2                	lw	ra,8(sp)
    2d04:	4501                	li	a0,0
    2d06:	0131                	addi	sp,sp,12
    2d08:	8082                	ret

00002d0a <drv_uart_initialize>:

static uart_priv_t uart_instance[2]; // 2 uarts port [0,1]

extern int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *soc_base ,uint32_t *irq, void **handler);

uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
    2d0a:	1111                	addi	sp,sp,-28
    2d0c:	c826                	sw	s1,16(sp)
    uint32_t base;
    uint32_t irq;
    void    *handler;
    uint32_t soc_base;
    int32_t ret = target_uart_init(idx, &base, &soc_base ,&irq, &handler);
    2d0e:	0038                	addi	a4,sp,8
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
    2d10:	84ae                	mv	s1,a1
    int32_t ret = target_uart_init(idx, &base, &soc_base ,&irq, &handler);
    2d12:	0054                	addi	a3,sp,4
    2d14:	0070                	addi	a2,sp,12
    2d16:	858a                	mv	a1,sp
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
    2d18:	ca22                	sw	s0,20(sp)
    2d1a:	cc06                	sw	ra,24(sp)
    2d1c:	842a                	mv	s0,a0
    int32_t ret = target_uart_init(idx, &base, &soc_base ,&irq, &handler);
    2d1e:	2885                	jal	2d8e <target_uart_init>

    if(ret < 0) { return 0;}
    2d20:	02054863          	bltz	a0,2d50 <drv_uart_initialize+0x46>
    uart_priv_t *uart_priv = &uart_instance[idx];
    2d24:	03c00513          	li	a0,60
    2d28:	02a40533          	mul	a0,s0,a0
    2d2c:	200017b7          	lui	a5,0x20001
    2d30:	56478793          	addi	a5,a5,1380 # 20001564 <uart_instance>
    2d34:	953e                	add	a0,a0,a5
    uart_priv->base = base;
    2d36:	4782                	lw	a5,0(sp)
    uart_priv->soc_base = soc_base;
    uart_priv->idx  = idx;
    2d38:	dd00                	sw	s0,56(a0)
    uart_priv->irq  = irq;
    uart_priv->cb_event  = cb_event;
    2d3a:	c544                	sw	s1,12(a0)
    uart_priv->base = base;
    2d3c:	c11c                	sw	a5,0(a0)
    uart_priv->soc_base = soc_base;
    2d3e:	47b2                	lw	a5,12(sp)
    2d40:	c15c                	sw	a5,4(a0)
    uart_priv->irq  = irq;
    2d42:	4792                	lw	a5,4(sp)
    2d44:	c51c                	sw	a5,8(a0)

    return (uart_handle_t)uart_priv;
}
    2d46:	40e2                	lw	ra,24(sp)
    2d48:	4452                	lw	s0,20(sp)
    2d4a:	44c2                	lw	s1,16(sp)
    2d4c:	0171                	addi	sp,sp,28
    2d4e:	8082                	ret
    if(ret < 0) { return 0;}
    2d50:	4501                	li	a0,0
    2d52:	bfd5                	j	2d46 <drv_uart_initialize+0x3c>

00002d54 <drv_uart_config_baudrate>:


int32_t drv_uart_config_baudrate(uart_handle_t handle, uint32_t baud, uint32_t cfg){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr_uart = (uart_reg_t*)(uintptr_t)(uart_priv->base);
    soc_reg_t  *addr_port = (soc_reg_t*)(uintptr_t)(uart_priv->soc_base);
    2d54:	415c                	lw	a5,4(a0)
    uart_reg_t *addr_uart = (uart_reg_t*)(uintptr_t)(uart_priv->base);
    2d56:	4114                	lw	a3,0(a0)
    addr_port->IOMUX |= (SOC_IOMUX_IOMUX0 + SOC_IOMUX_IOMUX1);
    addr_uart->BAUD   = baud;
    addr_uart->CFG    = cfg;

    return 0;
}
    2d58:	4501                	li	a0,0
    addr_port->IODIR |= SOC_IODIR_IODIR0;
    2d5a:	4798                	lw	a4,8(a5)
    2d5c:	00176713          	ori	a4,a4,1
    2d60:	c798                	sw	a4,8(a5)
    addr_port->IOMUX |= (SOC_IOMUX_IOMUX0 + SOC_IOMUX_IOMUX1);
    2d62:	47d8                	lw	a4,12(a5)
    2d64:	00376713          	ori	a4,a4,3
    2d68:	c7d8                	sw	a4,12(a5)
    addr_uart->BAUD   = baud;
    2d6a:	c68c                	sw	a1,8(a3)
    addr_uart->CFG    = cfg;
    2d6c:	c2d0                	sw	a2,4(a3)
}
    2d6e:	8082                	ret

00002d70 <drv_uart_putc>:

int32_t drv_uart_putc(uart_handle_t handle, uint8_t ch){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*)(uintptr_t)(uart_priv->base);
    2d70:	4118                	lw	a4,0(a0)

    uint32_t fifo;
    do{
        fifo = addr->STS & 0x1F;
    } while(fifo == 16);
    2d72:	46c1                	li	a3,16
        fifo = addr->STS & 0x1F;
    2d74:	475c                	lw	a5,12(a4)
    2d76:	8bfd                	andi	a5,a5,31
    } while(fifo == 16);
    2d78:	fed78ee3          	beq	a5,a3,2d74 <drv_uart_putc+0x4>
    addr->DATA = ch;
    2d7c:	c30c                	sw	a1,0(a4)
    return 0;
}
    2d7e:	4501                	li	a0,0
    2d80:	8082                	ret

00002d82 <target_get_clk>:
const sg_clk_config[1] = { //soc [0]
    {SOC_BASE},
};

int32_t target_get_clk(uint32_t *base){
    if (base != 0) {
    2d82:	c501                	beqz	a0,2d8a <target_get_clk+0x8>
        *base = sg_clk_config[0].base;
    2d84:	300007b7          	lui	a5,0x30000
    2d88:	c11c                	sw	a5,0(a0)
    }
    return 1;
}
    2d8a:	4505                	li	a0,1
    2d8c:	8082                	ret

00002d8e <target_uart_init>:
    {UART1_BASE, 39/*uart irq1*/, UART1_IRQHandler, SOC_BASE},
};

int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *soc_base ,uint32_t *irq, void **handler)
{
    if (base != 0) {
    2d8e:	c989                	beqz	a1,2da0 <target_uart_init+0x12>
        *base = sg_uart_config[idx].base;
    2d90:	6315                	lui	t1,0x5
    2d92:	00451793          	slli	a5,a0,0x4
    2d96:	92830313          	addi	t1,t1,-1752 # 4928 <sg_uart_config>
    2d9a:	979a                	add	a5,a5,t1
    2d9c:	439c                	lw	a5,0(a5)
    2d9e:	c19c                	sw	a5,0(a1)
    }

    if(soc_base != 0){
    2da0:	ca09                	beqz	a2,2db2 <target_uart_init+0x24>
        *soc_base = sg_uart_config[idx].soc_base;
    2da2:	6595                	lui	a1,0x5
    2da4:	00451793          	slli	a5,a0,0x4
    2da8:	92858593          	addi	a1,a1,-1752 # 4928 <sg_uart_config>
    2dac:	97ae                	add	a5,a5,a1
    2dae:	47dc                	lw	a5,12(a5)
    2db0:	c21c                	sw	a5,0(a2)
    }

    if (irq != 0) {
    2db2:	ca89                	beqz	a3,2dc4 <target_uart_init+0x36>
        *irq = sg_uart_config[idx].irq;
    2db4:	6615                	lui	a2,0x5
    2db6:	00451793          	slli	a5,a0,0x4
    2dba:	92860613          	addi	a2,a2,-1752 # 4928 <sg_uart_config>
    2dbe:	97b2                	add	a5,a5,a2
    2dc0:	43dc                	lw	a5,4(a5)
    2dc2:	c29c                	sw	a5,0(a3)
    }

    if (handler != 0) {
    2dc4:	cb09                	beqz	a4,2dd6 <target_uart_init+0x48>
        *handler = sg_uart_config[idx].handler;
    2dc6:	6695                	lui	a3,0x5
    2dc8:	00451793          	slli	a5,a0,0x4
    2dcc:	92868693          	addi	a3,a3,-1752 # 4928 <sg_uart_config>
    2dd0:	97b6                	add	a5,a5,a3
    2dd2:	479c                	lw	a5,8(a5)
    2dd4:	c31c                	sw	a5,0(a4)
    }
    return idx;
}
    2dd6:	8082                	ret

00002dd8 <system_init>:
    //config core timer
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
    __enable_irq();
}

void system_init(void){
    2dd8:	1151                	addi	sp,sp,-12
    2dda:	c406                	sw	ra,8(sp)
    //config core local interrupt controller
    CLIC->CLICCFG = 0x6UL;
    2ddc:	e08007b7          	lui	a5,0xe0800
    2de0:	4719                	li	a4,6
    2de2:	c398                	sw	a4,0(a5)

    uint32_t tick = 50000; // cycles
    CLINTCMP->MTIMECMP = CLINTTIME->MTIME + tick;
    2de4:	e000c7b7          	lui	a5,0xe000c
    2de8:	ff87a503          	lw	a0,-8(a5) # e000bff8 <__bss_end__+0xc000a048>
    2dec:	ffc7a583          	lw	a1,-4(a5)
    2df0:	67b1                	lui	a5,0xc
    2df2:	35078793          	addi	a5,a5,848 # c350 <__ctor_end__+0x7100>
    2df6:	97aa                	add	a5,a5,a0
    2df8:	00a7b733          	sltu	a4,a5,a0
    2dfc:	863e                	mv	a2,a5
    2dfe:	e00047b7          	lui	a5,0xe0004
    2e02:	00b706b3          	add	a3,a4,a1
    2e06:	c390                	sw	a2,0(a5)
    2e08:	c3d4                	sw	a3,4(a5)

    //set interrupt pendding
    for (int i = 0; i < 12; i++) {
    2e0a:	4701                	li	a4,0
        CLIC->INT[i].CLICINTIP = 0;
    2e0c:	e0800637          	lui	a2,0xe0800
    for (int i = 0; i < 12; i++) {
    2e10:	46b1                	li	a3,12
        CLIC->INT[i].CLICINTIP = 0;
    2e12:	40070793          	addi	a5,a4,1024 # 1000400 <__ctor_end__+0xffb1b0>
    2e16:	078a                	slli	a5,a5,0x2
    2e18:	97b2                	add	a5,a5,a2
    2e1a:	00078023          	sb	zero,0(a5) # e0004000 <__bss_end__+0xc0002050>
    for (int i = 0; i < 12; i++) {
    2e1e:	0705                	addi	a4,a4,1
    2e20:	fed719e3          	bne	a4,a3,2e12 <system_init+0x3a>
    irq_vectors_init();
    2e24:	2811                	jal	2e38 <irq_vectors_init>
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
    2e26:	451d                	li	a0,7
    2e28:	2855                	jal	2edc <drv_irq_enable>
#ifndef __STATIC_INLINE
#define __STATIC_INLINE         static inline
#endif

__ALWAYS_STATIC_INLINE void __enable_irq(void){
    __ASM volatile ("csrsi mstatus, 0x8");
    2e2a:	30046073          	csrsi	mstatus,8
    __ASM volatile ("csrsi mie, 0x7");
    2e2e:	3043e073          	csrsi	mie,7
    }
    //drv_irq_enable(MACH_SOFT_IRQn); //enable machine software interrupt
    _system_init_for_kernel();      //setting default interrupt and core timer interrupt
}
    2e32:	40a2                	lw	ra,8(sp)
    2e34:	0131                	addi	sp,sp,12
    2e36:	8082                	ret

00002e38 <irq_vectors_init>:
extern void CORET_IRQHandler(void);

void (*g_irqvector[48])(void);

void irq_vectors_init(void){
    for (int i = 0; i < 48; i++) {
    2e38:	20001737          	lui	a4,0x20001
    2e3c:	5dc70793          	addi	a5,a4,1500 # 200015dc <g_irqvector>
        g_irqvector[i] = Default_Handler;
    2e40:	0c078613          	addi	a2,a5,192
    2e44:	5dc70713          	addi	a4,a4,1500
    2e48:	10000693          	li	a3,256
    2e4c:	c394                	sw	a3,0(a5)
    for (int i = 0; i < 48; i++) {
    2e4e:	0791                	addi	a5,a5,4
    2e50:	fec79ee3          	bne	a5,a2,2e4c <irq_vectors_init+0x14>
    }
    g_irqvector[CORET_IRQn] = CORET_IRQHandler;
    2e54:	678d                	lui	a5,0x3
    2e56:	e5e78793          	addi	a5,a5,-418 # 2e5e <CORET_IRQHandler>
    2e5a:	cf5c                	sw	a5,28(a4)
}
    2e5c:	8082                	ret

00002e5e <CORET_IRQHandler>:

extern void systick_handler(void);

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    2e5e:	1151                	addi	sp,sp,-12
    2e60:	c406                	sw	ra,8(sp)
    2e62:	c222                	sw	s0,4(sp)
    INTRPT_ENTER();
    2e64:	2a71                	jal	3000 <kos_kernel_intrpt_enter>
    g_idle_count[cpu_cur_get()]++;
    2e66:	0201a783          	lw	a5,32(gp) # 20000200 <g_idle_count>
    2e6a:	0785                	addi	a5,a5,1
    2e6c:	02f1a023          	sw	a5,32(gp) # 20000200 <g_idle_count>
    systick_handler();
    2e70:	2889                	jal	2ec2 <systick_handler>
    CLINTCMP->MTIMECMP = CLINTTIME->MTIME + 50000;
    2e72:	e000c7b7          	lui	a5,0xe000c
    2e76:	ff87a603          	lw	a2,-8(a5) # e000bff8 <__bss_end__+0xc000a048>
    2e7a:	ffc7a683          	lw	a3,-4(a5)
    2e7e:	67b1                	lui	a5,0xc
    2e80:	35078793          	addi	a5,a5,848 # c350 <__ctor_end__+0x7100>
    2e84:	97b2                	add	a5,a5,a2
    2e86:	00c7b733          	sltu	a4,a5,a2
    2e8a:	853e                	mv	a0,a5
    2e8c:	00d705b3          	add	a1,a4,a3
    2e90:	e00047b7          	lui	a5,0xe0004

    if(g_idle_count[0] == 10){
    2e94:	0201a703          	lw	a4,32(gp) # 20000200 <g_idle_count>
    CLINTCMP->MTIMECMP = CLINTTIME->MTIME + 50000;
    2e98:	c388                	sw	a0,0(a5)
    2e9a:	c3cc                	sw	a1,4(a5)
    if(g_idle_count[0] == 10){
    2e9c:	47a9                	li	a5,10
    2e9e:	00f71663          	bne	a4,a5,2eaa <CORET_IRQHandler+0x4c>
        SIMULATION->END = 1;
    2ea2:	3f0017b7          	lui	a5,0x3f001
    2ea6:	4705                	li	a4,1
    2ea8:	c398                	sw	a4,0(a5)
    }

    INTRPT_EXIT();
}
    2eaa:	4412                	lw	s0,4(sp)
    2eac:	40a2                	lw	ra,8(sp)
    2eae:	0131                	addi	sp,sp,12
    INTRPT_EXIT();
    2eb0:	a295                	j	3014 <kos_kernel_intrpt_exit>

00002eb2 <TIM0_IRQHandler>:

ATTRIBUTE_ISR void TIM0_IRQHandler(void){
    2eb2:	1151                	addi	sp,sp,-12
    2eb4:	c406                	sw	ra,8(sp)
    INTRPT_ENTER();
    2eb6:	22a9                	jal	3000 <kos_kernel_intrpt_enter>
    // your ISR code here
    INTRPT_EXIT();
}
    2eb8:	40a2                	lw	ra,8(sp)
    2eba:	0131                	addi	sp,sp,12
    INTRPT_EXIT();
    2ebc:	aaa1                	j	3014 <kos_kernel_intrpt_exit>

00002ebe <UART0_IRQHandler>:
    2ebe:	bfd5                	j	2eb2 <TIM0_IRQHandler>

00002ec0 <UART1_IRQHandler>:
    2ec0:	bfcd                	j	2eb2 <TIM0_IRQHandler>

00002ec2 <systick_handler>:
#include "../../kernel/kos/core/include/k_api.h"
#include "../include/soc.h"

uint64_t g_sys_tick_count;
void systick_handler(void){
    g_sys_tick_count++;
    2ec2:	01018793          	addi	a5,gp,16 # 200001f0 <g_sys_tick_count>
    2ec6:	4398                	lw	a4,0(a5)
    2ec8:	43d0                	lw	a2,4(a5)
    2eca:	00170693          	addi	a3,a4,1
    2ece:	00e6b733          	sltu	a4,a3,a4
    2ed2:	9732                	add	a4,a4,a2
    2ed4:	c394                	sw	a3,0(a5)
    2ed6:	c3d8                	sw	a4,4(a5)
    //printf("core timer interrupt handler %d \r\n",(int)g_sys_tick_count);
    krhino_tick_proc();
    2ed8:	76c0006f          	j	3644 <krhino_tick_proc>

00002edc <drv_irq_enable>:
#define CLIC           ((CLIC_TypeDef       *) CLIC_BASE)
#define CLIC_I         ((CLIC_INTER_TypeDef *) CLIC_INT)


__STATIC_INLINE void vic_enable_irq(int32_t IRQn){
    CLIC->INT[IRQn].CLICINTIP   = 0x00;
    2edc:	e08017b7          	lui	a5,0xe0801
    2ee0:	050a                	slli	a0,a0,0x2
    2ee2:	953e                	add	a0,a0,a5
    2ee4:	00050023          	sb	zero,0(a0)
    CLIC->INT[IRQn].CLICINTIE   = 0x01;
    2ee8:	4785                	li	a5,1
    2eea:	00f500a3          	sb	a5,1(a0)
    CLIC->INT[IRQn].CLICINTATTR = 0x03;
    2eee:	478d                	li	a5,3
    2ef0:	00f50123          	sb	a5,2(a0)
    CLIC->INT[IRQn].CLICINTCTRL = 0x00; //0x7f
    2ef4:	000501a3          	sb	zero,3(a0)
extern void Default_Handler(void);
extern void (*g_irqvector[])(void);

void drv_irq_enable (uint32_t irq_num){
    vic_enable_irq(irq_num);
}
    2ef8:	8082                	ret

00002efa <trap_c>:
    return (uint32_t)(result);
}

__ALWAYS_STATIC_INLINE uint32_t __get_MCAUSE(void){
    uintptr_t result;
    __ASM volatile("csrr %0, mcause" : "=r"(result));
    2efa:	342025f3          	csrr	a1,mcause

void trap_c(uint32_t *regs){
    //read exception code and print
    uint32_t vec = 0;
    vec = __get_MCAUSE() & 0x3FF;
    printf("err:%d\n",(int)vec);
    2efe:	6515                	lui	a0,0x5
    2f00:	3ff5f593          	andi	a1,a1,1023
    2f04:	94850513          	addi	a0,a0,-1720 # 4948 <sg_uart_config+0x20>
    2f08:	50f0006f          	j	3c16 <printf>

00002f0c <drv_clk_initialize>:

static clk_priv_t clk_instance;

extern int32_t target_get_clk(uint32_t *base);

clk_handle_t drv_clk_initialize(){
    2f0c:	1141                	addi	sp,sp,-16
    uint32_t base;
    int32_t ret = target_get_clk(&base);
    2f0e:	850a                	mv	a0,sp
clk_handle_t drv_clk_initialize(){
    2f10:	c606                	sw	ra,12(sp)
    int32_t ret = target_get_clk(&base);
    2f12:	3d85                	jal	2d82 <target_get_clk>

    if(ret < 0) { return 0;}
    2f14:	4781                	li	a5,0
    2f16:	00054763          	bltz	a0,2f24 <drv_clk_initialize+0x18>
    clk_priv_t *clk_priv = &clk_instance;
    clk_priv->base = base;
    2f1a:	4702                	lw	a4,0(sp)
    2f1c:	00e1ac23          	sw	a4,24(gp) # 200001f8 <clk_instance>
    return (clk_handle_t)clk_priv;
    2f20:	01818793          	addi	a5,gp,24 # 200001f8 <clk_instance>
}
    2f24:	40b2                	lw	ra,12(sp)
    2f26:	853e                	mv	a0,a5
    2f28:	0141                	addi	sp,sp,16
    2f2a:	8082                	ret

00002f2c <drv_clk_setup>:

int32_t drv_clk_setup(clk_handle_t handle, uint32_t clk){
    clk_priv_t *clk_priv = handle;
    soc_reg_t *addr_clk = (soc_reg_t*)(uintptr_t)(clk_priv->base);
    2f2c:	411c                	lw	a5,0(a0)

    while((addr_clk->CLK & SOC_CLK_PLLLOCK) == 0);
    2f2e:	4398                	lw	a4,0(a5)
    2f30:	8b21                	andi	a4,a4,8
    2f32:	df75                	beqz	a4,2f2e <drv_clk_setup+0x2>

    addr_clk->CLK |= clk;
    2f34:	4398                	lw	a4,0(a5)

    for(uint8_t iter = 0; iter < 200; iter++);

    return 1;
}
    2f36:	4505                	li	a0,1
    addr_clk->CLK |= clk;
    2f38:	8dd9                	or	a1,a1,a4
    2f3a:	c38c                	sw	a1,0(a5)
}
    2f3c:	8082                	ret

00002f3e <drv_clk_enable>:

int32_t drv_clk_enable(clk_handle_t handle, uint32_t enable){
    clk_priv_t *clk_priv = handle;
    soc_reg_t *addr_clk = (soc_reg_t*)(uintptr_t)(clk_priv->base);
    2f3e:	4118                	lw	a4,0(a0)

    addr_clk->CLKEN |= enable;
    return 1;
}
    2f40:	4505                	li	a0,1
    addr_clk->CLKEN |= enable;
    2f42:	435c                	lw	a5,4(a4)
    2f44:	8fcd                	or	a5,a5,a1
    2f46:	c35c                	sw	a5,4(a4)
}
    2f48:	8082                	ret

00002f4a <board_init>:

extern uart_handle_t console_handle;
extern clk_handle_t  clk_handle;

void board_init(void)
{
    2f4a:	1151                	addi	sp,sp,-12
    2f4c:	c406                	sw	ra,8(sp)
    2f4e:	c222                	sw	s0,4(sp)
    int ret = 0;

    clk_handle = drv_clk_initialize();
    2f50:	3f75                	jal	2f0c <drv_clk_initialize>
    drv_clk_setup(clk_handle, SOC_CLK_CLKSRC_PLL | SOC_CLK_CLKSEL_DIV4);
    2f52:	4595                	li	a1,5
    clk_handle = drv_clk_initialize();
    2f54:	00a1a423          	sw	a0,8(gp) # 200001e8 <clk_handle>
    drv_clk_setup(clk_handle, SOC_CLK_CLKSRC_PLL | SOC_CLK_CLKSEL_DIV4);
    2f58:	3fd1                	jal	2f2c <drv_clk_setup>
    drv_clk_enable(clk_handle, SOC_CLKEN_UART0);
    2f5a:	0081a503          	lw	a0,8(gp) # 200001e8 <clk_handle>
    2f5e:	002005b7          	lui	a1,0x200
    2f62:	3ff1                	jal	2f3e <drv_clk_enable>

    console_handle = drv_uart_initialize(0, NULL);
    2f64:	4581                	li	a1,0
    2f66:	4501                	li	a0,0
    2f68:	334d                	jal	2d0a <drv_uart_initialize>
    ret = drv_uart_config_baudrate(console_handle, 217, (UART_CFG_TXSTART | UART_CFG_RXSTART ));
    2f6a:	460d                	li	a2,3
    2f6c:	0d900593          	li	a1,217
    console_handle = drv_uart_initialize(0, NULL);
    2f70:	00a1a623          	sw	a0,12(gp) # 200001ec <console_handle>
    ret = drv_uart_config_baudrate(console_handle, 217, (UART_CFG_TXSTART | UART_CFG_RXSTART ));
    2f74:	33c5                	jal	2d54 <drv_uart_config_baudrate>

    printf("boad init console uart0 \r\n");

    if(ret < 0 ) { return; }
}
    2f76:	4412                	lw	s0,4(sp)
    2f78:	40a2                	lw	ra,8(sp)
    printf("boad init console uart0 \r\n");
    2f7a:	6515                	lui	a0,0x5
    2f7c:	95050513          	addi	a0,a0,-1712 # 4950 <sg_uart_config+0x28>
}
    2f80:	0131                	addi	sp,sp,12
    printf("boad init console uart0 \r\n");
    2f82:	4cd0006f          	j	3c4e <puts>

00002f86 <os_startup>:
    printf("entry os \r\n");
    os_startup();
    return 0;
}

int os_startup(void){
    2f86:	1151                	addi	sp,sp,-12
    2f88:	c406                	sw	ra,8(sp)
    kos_kernel_init();
    2f8a:	2015                	jal	2fae <kos_kernel_init>
    kos_kernel_start();
    2f8c:	281d                	jal	2fc2 <kos_kernel_start>
    app_init();
    return 0;
}
    2f8e:	40a2                	lw	ra,8(sp)
    2f90:	4501                	li	a0,0
    2f92:	0131                	addi	sp,sp,12
    2f94:	8082                	ret

00002f96 <entry>:
    printf("entry os \r\n");
    2f96:	6515                	lui	a0,0x5
int entry(){
    2f98:	1151                	addi	sp,sp,-12
    printf("entry os \r\n");
    2f9a:	96c50513          	addi	a0,a0,-1684 # 496c <sg_uart_config+0x44>
int entry(){
    2f9e:	c406                	sw	ra,8(sp)
    printf("entry os \r\n");
    2fa0:	4af000ef          	jal	ra,3c4e <puts>
    os_startup();
    2fa4:	37cd                	jal	2f86 <os_startup>
}
    2fa6:	40a2                	lw	ra,8(sp)
    2fa8:	4501                	li	a0,0
    2faa:	0131                	addi	sp,sp,12
    2fac:	8082                	ret

00002fae <kos_kernel_init>:
#include "../../../driver/include/soc.h"
#include "../core/include/k_api.h"

#define AUTORUN  1

k_status_t kos_kernel_init(void){
    2fae:	1151                	addi	sp,sp,-12
    2fb0:	c406                	sw	ra,8(sp)
    kstat_t ret = krhino_init();
    2fb2:	2639                	jal	32c0 <krhino_init>
    if(ret == RHINO_SUCCESS){
        return 0;
    } else {
        return -1;
    }
}
    2fb4:	40a2                	lw	ra,8(sp)
    if(ret == RHINO_SUCCESS){
    2fb6:	00a03533          	snez	a0,a0
}
    2fba:	40a00533          	neg	a0,a0
    2fbe:	0131                	addi	sp,sp,12
    2fc0:	8082                	ret

00002fc2 <kos_kernel_start>:

k_status_t kos_kernel_start(void){
    2fc2:	1151                	addi	sp,sp,-12
    2fc4:	c406                	sw	ra,8(sp)
    kstat_t ret = krhino_start();
    2fc6:	267d                	jal	3374 <krhino_start>
    if(ret == RHINO_SUCCESS){
        return 0;
    } else {
        return -1;
    }
}
    2fc8:	40a2                	lw	ra,8(sp)
    if(ret == RHINO_SUCCESS){
    2fca:	00a03533          	snez	a0,a0
}
    2fce:	40a00533          	neg	a0,a0
    2fd2:	0131                	addi	sp,sp,12
    2fd4:	8082                	ret

00002fd6 <kos_kernel_sched_suspend>:
    }
    return rc;
}

uint32_t kos_kernel_sched_suspend(void){
    if (g_sys_stat != RHINO_RUNNING) {
    2fd6:	0341a703          	lw	a4,52(gp) # 20000214 <g_sys_stat>
    2fda:	478d                	li	a5,3
    2fdc:	00f71963          	bne	a4,a5,2fee <kos_kernel_sched_suspend+0x18>
uint32_t kos_kernel_sched_suspend(void){
    2fe0:	1151                	addi	sp,sp,-12
    2fe2:	c406                	sw	ra,8(sp)
        return 0;
    }
    krhino_sched_disable();
    2fe4:	2a9d                	jal	315a <krhino_sched_disable>
    return 0;
}
    2fe6:	40a2                	lw	ra,8(sp)
    2fe8:	4501                	li	a0,0
    2fea:	0131                	addi	sp,sp,12
    2fec:	8082                	ret
    2fee:	4501                	li	a0,0
    2ff0:	8082                	ret

00002ff2 <kos_kernel_sched_resume>:

void kos_kernel_sched_resume(uint32_t sleep_ticks){
    if (g_sys_stat != RHINO_RUNNING) {
    2ff2:	0341a703          	lw	a4,52(gp) # 20000214 <g_sys_stat>
    2ff6:	478d                	li	a5,3
    2ff8:	00f71363          	bne	a4,a5,2ffe <kos_kernel_sched_resume+0xc>
        return;
    }
    krhino_sched_enable();
    2ffc:	aadd                	j	31f2 <krhino_sched_enable>
}
    2ffe:	8082                	ret

00003000 <kos_kernel_intrpt_enter>:

k_status_t kos_kernel_intrpt_enter(void){
    3000:	1151                	addi	sp,sp,-12
    3002:	c406                	sw	ra,8(sp)
    k_status_t ret = krhino_intrpt_enter();
    3004:	266d                	jal	33ae <krhino_intrpt_enter>
        return 0;
    } else {
        return -1;
    }
    return 0;
}
    3006:	40a2                	lw	ra,8(sp)
    if(ret == RHINO_SUCCESS){
    3008:	00a03533          	snez	a0,a0
}
    300c:	40a00533          	neg	a0,a0
    3010:	0131                	addi	sp,sp,12
    3012:	8082                	ret

00003014 <kos_kernel_intrpt_exit>:

k_status_t kos_kernel_intrpt_exit(void){
    3014:	1151                	addi	sp,sp,-12
    3016:	c406                	sw	ra,8(sp)
    krhino_intrpt_exit();
    3018:	26d1                	jal	33dc <krhino_intrpt_exit>
    return 0;
}
    301a:	40a2                	lw	ra,8(sp)
    301c:	4501                	li	a0,0
    301e:	0131                	addi	sp,sp,12
    3020:	8082                	ret

00003022 <cpu_task_stack_init>:
#include "../../core/include/k_api.h"

void *cpu_task_stack_init(cpu_stack_t *base, size_t size, void *arg, task_entry_t entry){
    cpu_stack_t *stk;
    register int *gp asm("x3");
    uint32_t temp = (uint32_t)(uintptr_t)(base + size);
    3022:	058a                	slli	a1,a1,0x2
    3024:	952e                	add	a0,a0,a1
    temp &= 0xFFFFFFFCUL;
    3026:	9971                	andi	a0,a0,-4
    stk = (cpu_stack_t *)(uintptr_t)temp;

    *(--stk) = (uint32_t)(uintptr_t)entry;                  /*PC  */
    *(--stk) = (uint32_t)(uintptr_t)0x15151515L;            /*X15 */
    3028:	15151737          	lui	a4,0x15151
    *(--stk) = (uint32_t)(uintptr_t)entry;                  /*PC  */
    302c:	f8050793          	addi	a5,a0,-128
    *(--stk) = (uint32_t)(uintptr_t)0x15151515L;            /*X15 */
    3030:	51570713          	addi	a4,a4,1301 # 15151515 <__ctor_end__+0x1514c2c5>
    3034:	dfb8                	sw	a4,120(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x14141414;             /*X14 */
    3036:	14141737          	lui	a4,0x14141
    303a:	41470713          	addi	a4,a4,1044 # 14141414 <__ctor_end__+0x1413c1c4>
    303e:	dbf8                	sw	a4,116(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x13131313;             /*X13 */
    3040:	13131737          	lui	a4,0x13131
    3044:	31370713          	addi	a4,a4,787 # 13131313 <__ctor_end__+0x1312c0c3>
    3048:	dbb8                	sw	a4,112(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x12121212;             /*X12 */
    304a:	12121737          	lui	a4,0x12121
    304e:	21270713          	addi	a4,a4,530 # 12121212 <__ctor_end__+0x1211bfc2>
    3052:	d7f8                	sw	a4,108(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x11111111;             /*X11 */
    3054:	11111737          	lui	a4,0x11111
    3058:	11170713          	addi	a4,a4,273 # 11111111 <__ctor_end__+0x1110bec1>
    305c:	d7b8                	sw	a4,104(a5)
    *(--stk) = (uint32_t)(uintptr_t)arg;                    /*X10 */
    *(--stk) = (uint32_t)(uintptr_t)0x09090909;             /*X9  */
    305e:	09091737          	lui	a4,0x9091
    3062:	90970713          	addi	a4,a4,-1783 # 9090909 <__ctor_end__+0x908b6b9>
    3066:	d3b8                	sw	a4,96(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x08080808;             /*X8  */
    3068:	08081737          	lui	a4,0x8081
    306c:	80870713          	addi	a4,a4,-2040 # 8080808 <__ctor_end__+0x807b5b8>
    3070:	cff8                	sw	a4,92(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x07070707;             /*X7  */
    3072:	07070737          	lui	a4,0x7070
    3076:	70770713          	addi	a4,a4,1799 # 7070707 <__ctor_end__+0x706b4b7>
    307a:	cfb8                	sw	a4,88(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x06060606;             /*X6  */
    307c:	06060737          	lui	a4,0x6060
    3080:	60670713          	addi	a4,a4,1542 # 6060606 <__ctor_end__+0x605b3b6>
    3084:	cbf8                	sw	a4,84(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x05050505;             /*X5  */
    3086:	05050737          	lui	a4,0x5050
    308a:	50570713          	addi	a4,a4,1285 # 5050505 <__ctor_end__+0x504b2b5>
    308e:	cbb8                	sw	a4,80(a5)
    *(--stk) = (uint32_t)(uintptr_t)0x04040404;             /*X4  */
    3090:	04040737          	lui	a4,0x4040
    3094:	40470713          	addi	a4,a4,1028 # 4040404 <__ctor_end__+0x403b1b4>
    3098:	c7f8                	sw	a4,76(a5)
    *(--stk) = (uint32_t)(uintptr_t)gp;                     /*X3  */
    *(--stk) = (uint32_t)(uintptr_t)krhino_task_deathbed;   /*X1  */
    309a:	670d                	lui	a4,0x3
    309c:	5be70713          	addi	a4,a4,1470 # 35be <krhino_task_deathbed>
    *(--stk) = (uint32_t)(uintptr_t)entry;                  /*PC  */
    30a0:	dff4                	sw	a3,124(a5)
    *(--stk) = (uint32_t)(uintptr_t)arg;                    /*X10 */
    30a2:	d3f0                	sw	a2,100(a5)
    *(--stk) = (uint32_t)(uintptr_t)gp;                     /*X3  */
    30a4:	0437a423          	sw	gp,72(a5) # e0801048 <__bss_end__+0xc07ff098>
    *(--stk) = (uint32_t)(uintptr_t)krhino_task_deathbed;   /*X1  */
    30a8:	c3f8                	sw	a4,68(a5)

    return stk;
}
    30aa:	fc450513          	addi	a0,a0,-60
    30ae:	8082                	ret

000030b0 <irq_hook>:

void irq_hook(void){
    printf("h");
    30b0:	06800513          	li	a0,104
    30b4:	3870006f          	j	3c3a <putchar>

000030b8 <idle_task>:
#include "../include/k_api.h"

void idle_task(void *arg){
    30b8:	1151                	addi	sp,sp,-12
    30ba:	c026                	sw	s1,0(sp)
    30bc:	c406                	sw	ra,8(sp)
    30be:	c222                	sw	s0,4(sp)
    CPSR_ALLOC();
    (void)arg;
    while (1){
        RHINO_CPU_INTRPT_DISABLE();
    30c0:	844fd0ef          	jal	ra,104 <cpu_intrpt_save>
        //g_idle_count[cpu_cur_get()]++;
        printf("%d\n", (int)g_idle_count[cpu_cur_get()]);
    30c4:	0201a583          	lw	a1,32(gp) # 20000200 <g_idle_count>
        RHINO_CPU_INTRPT_DISABLE();
    30c8:	842a                	mv	s0,a0
        printf("%d\n", (int)g_idle_count[cpu_cur_get()]);
    30ca:	6515                	lui	a0,0x5
    30cc:	94c50513          	addi	a0,a0,-1716 # 494c <sg_uart_config+0x24>
    30d0:	347000ef          	jal	ra,3c16 <printf>
        RHINO_CPU_INTRPT_ENABLE();
    30d4:	8522                	mv	a0,s0
    30d6:	838fd0ef          	jal	ra,10e <cpu_intrpt_restore>
    while (1){
    30da:	b7dd                	j	30c0 <idle_task+0x8>

000030dc <k_mm_init>:
#include "../include/k_api.h"

void k_mm_init(void){
    //uint32_t e = 0;
}
    30dc:	8082                	ret

000030de <ready_list_init>:
    cpu_task_switch();
    RHINO_CPU_INTRPT_ENABLE();
}

RHINO_INLINE void ready_list_init(runqueue_t *rq, ktask_t *task){
    rq->cur_list_item[task->prio] = &task->task_list;
    30de:	0525c783          	lbu	a5,82(a1) # 200052 <__ctor_end__+0x1fae02>
    30e2:	00c58713          	addi	a4,a1,12
    30e6:	00279693          	slli	a3,a5,0x2
    30ea:	96aa                	add	a3,a3,a0
    30ec:	c298                	sw	a4,0(a3)
#define BITMAP_MASK(nr) (1UL << (BITMAP_UNIT_SIZE - 1U - ((nr) & BITMAP_UNIT_MASK)))
#define BITMAP_WORD(nr) ((nr) >> BITMAP_UNIT_BITS)

RHINO_INLINE void krhino_bitmap_set(uint32_t *bitmap, int32_t nr)
{
    bitmap[BITMAP_WORD(nr)] |= BITMAP_MASK(nr);
    30ee:	4057d693          	srai	a3,a5,0x5
} klist_t;

#define krhino_list_entry(node, type, member) ((type *)((uint8_t *)(node) - (size_t)(&((type *)0)->member)))

RHINO_INLINE void klist_init(klist_t *list_head){
    list_head->next = list_head;
    30f2:	c5d8                	sw	a4,12(a1)
    list_head->prev = list_head;
    30f4:	c998                	sw	a4,16(a1)
    30f6:	068a                	slli	a3,a3,0x2
    klist_init(rq->cur_list_item[task->prio]);
    krhino_bitmap_set(rq->task_bit_map,task->prio);
    30f8:	0f850713          	addi	a4,a0,248
    30fc:	9736                	add	a4,a4,a3
    30fe:	fff7c613          	not	a2,a5
    3102:	4685                	li	a3,1
    3104:	00c69633          	sll	a2,a3,a2
    3108:	4314                	lw	a3,0(a4)
    310a:	8ed1                	or	a3,a3,a2
    310c:	c314                	sw	a3,0(a4)
    if((task->prio) < (rq->highest_pri)){
    310e:	10054703          	lbu	a4,256(a0)
    3112:	00e7f463          	bgeu	a5,a4,311a <ready_list_init+0x3c>
        rq->highest_pri = task->prio;
    3116:	10f50023          	sb	a5,256(a0)
    }
}
    311a:	8082                	ret

0000311c <_ready_list_add_tail>:

RHINO_INLINE uint8_t is_ready_list_empty(uint8_t prio){
    return (g_ready_queue.cur_list_item[prio] == NULL);
    311c:	0525c603          	lbu	a2,82(a1)
    3120:	200026b7          	lui	a3,0x20002
    3124:	b5c68693          	addi	a3,a3,-1188 # 20001b5c <g_ready_queue>
    3128:	060a                	slli	a2,a2,0x2
    312a:	96b2                	add	a3,a3,a2
}

RHINO_INLINE void _ready_list_add_tail(runqueue_t *rq, ktask_t *task){
    if(is_ready_list_empty(task->prio)){
    312c:	4294                	lw	a3,0(a3)
    312e:	e291                	bnez	a3,3132 <_ready_list_add_tail+0x16>
        ready_list_init(rq,task);
    3130:	b77d                	j	30de <ready_list_init>
        return;
    }
    klist_insert(rq->cur_list_item[task->prio],&task->task_list);
    3132:	00c50733          	add	a4,a0,a2
    3136:	4318                	lw	a4,0(a4)
    3138:	00c58693          	addi	a3,a1,12
    return (list->next == list);
}

RHINO_INLINE void klist_insert(klist_t *head, klist_t *element)
{
    element->prev = head->prev;
    313c:	4350                	lw	a2,4(a4)
    element->next = head;
    313e:	c5d8                	sw	a4,12(a1)
    element->prev = head->prev;
    3140:	c990                	sw	a2,16(a1)

    head->prev->next = element;
    3142:	c214                	sw	a3,0(a2)
    head->prev       = element;
    3144:	c354                	sw	a3,4(a4)
}
    3146:	8082                	ret

00003148 <runqueue_init>:
    rq->highest_pri = RHINO_CONFIG_PRI_MAX;
    3148:	03e00793          	li	a5,62
    314c:	10f50023          	sb	a5,256(a0)
        rq->cur_list_item[prio] = NULL;
    3150:	0f800613          	li	a2,248
    3154:	4581                	li	a1,0
    3156:	963fd06f          	j	ab8 <memset>

0000315a <krhino_sched_disable>:
kstat_t krhino_sched_disable(void){
    315a:	1151                	addi	sp,sp,-12
    315c:	c406                	sw	ra,8(sp)
    RHINO_CRITICAL_ENTER();
    315e:	fa7fc0ef          	jal	ra,104 <cpu_intrpt_save>
    INTRPT_NESTED_LEVEL_CHK();
    3162:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    3166:	cb81                	beqz	a5,3176 <krhino_sched_disable+0x1c>
    3168:	fa7fc0ef          	jal	ra,10e <cpu_intrpt_restore>
    316c:	3ea00513          	li	a0,1002
}
    3170:	40a2                	lw	ra,8(sp)
    3172:	0131                	addi	sp,sp,12
    3174:	8082                	ret
    if (g_sched_lock[cpu_cur_get()] >= SCHED_MAX_LOCK_COUNT) {
    3176:	0301c783          	lbu	a5,48(gp) # 20000210 <g_sched_lock>
    317a:	0c700693          	li	a3,199
    317e:	00f6f763          	bgeu	a3,a5,318c <krhino_sched_disable+0x32>
        RHINO_CRITICAL_EXIT();
    3182:	f8dfc0ef          	jal	ra,10e <cpu_intrpt_restore>
        return 202;/*RHINO_SCHED_LOCK_COUNT_OVF;*/
    3186:	0ca00513          	li	a0,202
    318a:	b7dd                	j	3170 <krhino_sched_disable+0x16>
    g_sched_lock[cpu_cur_get()]++;
    318c:	0785                	addi	a5,a5,1
    318e:	02f18823          	sb	a5,48(gp) # 20000210 <g_sched_lock>
    RHINO_CRITICAL_EXIT();
    3192:	f7dfc0ef          	jal	ra,10e <cpu_intrpt_restore>
    return RHINO_SUCCESS;
    3196:	4501                	li	a0,0
    3198:	bfe1                	j	3170 <krhino_sched_disable+0x16>

0000319a <ready_list_add_tail>:
    rq->cur_list_item[task->prio] = &task->task_list;
}


void ready_list_add_tail(runqueue_t *rq, ktask_t *task){
    _ready_list_add_tail(rq,task);
    319a:	b749                	j	311c <_ready_list_add_tail>

0000319c <preferred_cpu_ready_task_get>:
        //k_err_proc(RHINO_SYS_FATAL_ERR);
    }
}

void preferred_cpu_ready_task_get(runqueue_t *rq, uint8_t cpu_num){
    klist_t *node = rq->cur_list_item[rq->highest_pri];
    319c:	10054783          	lbu	a5,256(a0)
    31a0:	078a                	slli	a5,a5,0x2
    31a2:	953e                	add	a0,a0,a5
    g_preferred_ready_task[cpu_cur_get()] = krhino_list_entry(node, ktask_t ,task_list );
    31a4:	411c                	lw	a5,0(a0)
    31a6:	17d1                	addi	a5,a5,-12
    31a8:	02f1a623          	sw	a5,44(gp) # 2000020c <g_preferred_ready_task>
}
    31ac:	8082                	ret

000031ae <core_sched>:
void core_sched(void){
    31ae:	1151                	addi	sp,sp,-12
    31b0:	c406                	sw	ra,8(sp)
    31b2:	c222                	sw	s0,4(sp)
    RHINO_CPU_INTRPT_DISABLE();
    31b4:	f51fc0ef          	jal	ra,104 <cpu_intrpt_save>
    if(g_intrpt_nested_level[cur_cpu_num] > 0u){
    31b8:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    31bc:	c791                	beqz	a5,31c8 <core_sched+0x1a>
}
    31be:	4412                	lw	s0,4(sp)
    31c0:	40a2                	lw	ra,8(sp)
    31c2:	0131                	addi	sp,sp,12
    RHINO_CPU_INTRPT_ENABLE();
    31c4:	f4bfc06f          	j	10e <cpu_intrpt_restore>
    if(g_sched_lock[cur_cpu_num] > 0u){
    31c8:	0301c783          	lbu	a5,48(gp) # 20000210 <g_sched_lock>
    31cc:	fbed                	bnez	a5,31be <core_sched+0x10>
    31ce:	842a                	mv	s0,a0
    preferred_cpu_ready_task_get(&g_ready_queue, cur_cpu_num);
    31d0:	20002537          	lui	a0,0x20002
    31d4:	4581                	li	a1,0
    31d6:	b5c50513          	addi	a0,a0,-1188 # 20001b5c <g_ready_queue>
    31da:	37c9                	jal	319c <preferred_cpu_ready_task_get>
    if(g_preferred_ready_task[cur_cpu_num] == g_active_task[cur_cpu_num]){
    31dc:	02c1a703          	lw	a4,44(gp) # 2000020c <g_preferred_ready_task>
    31e0:	01c1a783          	lw	a5,28(gp) # 200001fc <g_active_task>
    31e4:	00f71463          	bne	a4,a5,31ec <core_sched+0x3e>
    RHINO_CPU_INTRPT_ENABLE();
    31e8:	8522                	mv	a0,s0
    31ea:	bfd1                	j	31be <core_sched+0x10>
    cpu_task_switch();
    31ec:	f29fc0ef          	jal	ra,114 <cpu_task_switch>
    31f0:	bfe5                	j	31e8 <core_sched+0x3a>

000031f2 <krhino_sched_enable>:
kstat_t krhino_sched_enable(void){
    31f2:	1151                	addi	sp,sp,-12
    31f4:	c406                	sw	ra,8(sp)
    RHINO_CRITICAL_ENTER();
    31f6:	f0ffc0ef          	jal	ra,104 <cpu_intrpt_save>
    INTRPT_NESTED_LEVEL_CHK();
    31fa:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    31fe:	cb81                	beqz	a5,320e <krhino_sched_enable+0x1c>
    3200:	f0ffc0ef          	jal	ra,10e <cpu_intrpt_restore>
    3204:	3ea00513          	li	a0,1002
}
    3208:	40a2                	lw	ra,8(sp)
    320a:	0131                	addi	sp,sp,12
    320c:	8082                	ret
    if (g_sched_lock[cpu_cur_get()] == 0u ) {
    320e:	0301c783          	lbu	a5,48(gp) # 20000210 <g_sched_lock>
    3212:	e791                	bnez	a5,321e <krhino_sched_enable+0x2c>
        RHINO_CRITICAL_EXIT();
    3214:	efbfc0ef          	jal	ra,10e <cpu_intrpt_restore>
        return 201;/*RHINO_SCHED_ALREADY_ENABLED;*/
    3218:	0c900513          	li	a0,201
    321c:	b7f5                	j	3208 <krhino_sched_enable+0x16>
    g_sched_lock[cpu_cur_get()]--;
    321e:	17fd                	addi	a5,a5,-1
    3220:	0ff7f793          	zext.b	a5,a5
    3224:	02f18823          	sb	a5,48(gp) # 20000210 <g_sched_lock>
    if (g_sched_lock[cpu_cur_get()] > 0u ) {
    3228:	c791                	beqz	a5,3234 <krhino_sched_enable+0x42>
        RHINO_CRITICAL_EXIT();
    322a:	ee5fc0ef          	jal	ra,10e <cpu_intrpt_restore>
        return 200;/*RHINO_SCHED_ALREADY_DISABLE;*/
    322e:	0c800513          	li	a0,200
    3232:	bfd9                	j	3208 <krhino_sched_enable+0x16>
    RHINO_CRITICAL_EXIT_SCHED();
    3234:	edbfc0ef          	jal	ra,10e <cpu_intrpt_restore>
    3238:	3f9d                	jal	31ae <core_sched>
    return RHINO_SUCCESS;
    323a:	4501                	li	a0,0
    323c:	b7f1                	j	3208 <krhino_sched_enable+0x16>

0000323e <time_slice_update>:

void time_slice_update(void){
    323e:	1151                	addi	sp,sp,-12
    3240:	c222                	sw	s0,4(sp)
    3242:	c406                	sw	ra,8(sp)
    3244:	c026                	sw	s1,0(sp)

    ktask_t *task;
    klist_t *head;
    uint8_t  task_pri;

    RHINO_CRITICAL_ENTER();
    3246:	ebffc0ef          	jal	ra,104 <cpu_intrpt_save>
    task_pri = g_active_task[cpu_cur_get()]->prio;
    324a:	01c1a683          	lw	a3,28(gp) # 200001fc <g_active_task>
    head     = g_ready_queue.cur_list_item[task_pri];
    324e:	200027b7          	lui	a5,0x20002
    3252:	b5c78713          	addi	a4,a5,-1188 # 20001b5c <g_ready_queue>
    3256:	0526c683          	lbu	a3,82(a3)
    325a:	068a                	slli	a3,a3,0x2
    325c:	9736                	add	a4,a4,a3
    325e:	4300                	lw	s0,0(a4)
    if(is_ready_list_empty(task_pri)){
    3260:	e419                	bnez	s0,326e <time_slice_update+0x30>

    /* if time slice = 0 move task to tail of ready list and restore time slice */
    ready_list_add_tail(&g_ready_queue,task );
    task->time_slice = task->time_total;
    RHINO_CRITICAL_EXIT();
}
    3262:	4412                	lw	s0,4(sp)
    3264:	40a2                	lw	ra,8(sp)
    3266:	4482                	lw	s1,0(sp)
    3268:	0131                	addi	sp,sp,12
    RHINO_CRITICAL_EXIT();
    326a:	ea5fc06f          	j	10e <cpu_intrpt_restore>
    326e:	873e                	mv	a4,a5
    if(task->sched_policy == KSCHED_FIFO){
    3270:	04444783          	lbu	a5,68(s0)
    3274:	d7fd                	beqz	a5,3262 <time_slice_update+0x24>
    if(head->next == head){
    3276:	401c                	lw	a5,0(s0)
    3278:	fe8785e3          	beq	a5,s0,3262 <time_slice_update+0x24>
    if(task->time_slice > 0u) task->time_slice--;
    327c:	5c5c                	lw	a5,60(s0)
    327e:	84aa                	mv	s1,a0
    3280:	c781                	beqz	a5,3288 <time_slice_update+0x4a>
    3282:	17fd                	addi	a5,a5,-1
    3284:	dc5c                	sw	a5,60(s0)
    if(task->time_slice > 0u){
    3286:	fff1                	bnez	a5,3262 <time_slice_update+0x24>
    _ready_list_add_tail(rq,task);
    3288:	b5c70513          	addi	a0,a4,-1188
    328c:	ff440593          	addi	a1,s0,-12
    3290:	3571                	jal	311c <_ready_list_add_tail>
    task->time_slice = task->time_total;
    3292:	403c                	lw	a5,64(s0)
    RHINO_CRITICAL_EXIT();
    3294:	8526                	mv	a0,s1
    task->time_slice = task->time_total;
    3296:	dc5c                	sw	a5,60(s0)
    RHINO_CRITICAL_EXIT();
    3298:	b7e9                	j	3262 <time_slice_update+0x24>

0000329a <kobj_list_init>:
    list_head->next = list_head;
    329a:	200027b7          	lui	a5,0x20002
    329e:	20002737          	lui	a4,0x20002
    32a2:	b4478793          	addi	a5,a5,-1212 # 20001b44 <g_kobj_list>
    32a6:	b4c70713          	addi	a4,a4,-1204 # 20001b4c <g_kobj_list+0x8>
    32aa:	c798                	sw	a4,8(a5)
    list_head->prev = list_head;
    32ac:	c7d8                	sw	a4,12(a5)
    list_head->next = list_head;
    32ae:	20002737          	lui	a4,0x20002
    32b2:	b5470713          	addi	a4,a4,-1196 # 20001b54 <g_kobj_list+0x10>
    32b6:	c39c                	sw	a5,0(a5)
    list_head->prev = list_head;
    32b8:	c3dc                	sw	a5,4(a5)
    list_head->next = list_head;
    32ba:	cb98                	sw	a4,16(a5)
    list_head->prev = list_head;
    32bc:	cbd8                	sw	a4,20(a5)
    //klist_init(&(g_kobj_list.mblkpool_head));
    klist_init(&(g_kobj_list.sem_head));
    //klist_init(&(g_kobj_list.queue_head));
    //klist_init(&(g_kobj_list.buf_queue_head));
    //klist_init(&(g_kobj_list.event_head));
}
    32be:	8082                	ret

000032c0 <krhino_init>:
kstat_t krhino_init(void){
    g_sys_stat = RHINO_STOPPED;

    krhino_spin_init(&g_sys_lock);

    runqueue_init(&g_ready_queue);
    32c0:	20002537          	lui	a0,0x20002
kstat_t krhino_init(void){
    32c4:	1121                	addi	sp,sp,-24
    g_sys_stat = RHINO_STOPPED;
    32c6:	4711                	li	a4,4
    runqueue_init(&g_ready_queue);
    32c8:	b5c50513          	addi	a0,a0,-1188 # 20001b5c <g_ready_queue>
kstat_t krhino_init(void){
    32cc:	ca06                	sw	ra,20(sp)
    32ce:	c822                	sw	s0,16(sp)
    32d0:	c626                	sw	s1,12(sp)
    g_sys_stat = RHINO_STOPPED;
    32d2:	02e1aa23          	sw	a4,52(gp) # 20000214 <g_sys_stat>
    runqueue_init(&g_ready_queue);
    32d6:	3d8d                	jal	3148 <runqueue_init>

    tick_list_init();
    32d8:	2689                	jal	361a <tick_list_init>

    kobj_list_init();
    32da:	37c1                	jal	329a <kobj_list_init>

    k_mm_init();
    32dc:	3501                	jal	30dc <k_mm_init>
    //klist_init(&g_res_list);
    //krhino_sem_create(&g_res_sem, "res_sem", 0);
    //dyn_mem_proc_task_start();

    //create idle task
    krhino_task_create(&g_idle_task[0] /* tcb */, "idle_task", NULL, RHINO_IDLE_PRI, 0,
    32de:	678d                	lui	a5,0x3
    32e0:	0b878793          	addi	a5,a5,184 # 30b8 <idle_task>
    32e4:	c23e                	sw	a5,4(sp)
    32e6:	11400793          	li	a5,276
    32ea:	4405                	li	s0,1
    32ec:	c03e                	sw	a5,0(sp)
    32ee:	6595                	lui	a1,0x5
    32f0:	200017b7          	lui	a5,0x20001
    32f4:	20001537          	lui	a0,0x20001
    32f8:	c422                	sw	s0,8(sp)
    32fa:	6f478793          	addi	a5,a5,1780 # 200016f4 <g_idle_task_stack>
    32fe:	4701                	li	a4,0
    3300:	03d00693          	li	a3,61
    3304:	4601                	li	a2,0
    3306:	97858593          	addi	a1,a1,-1672 # 4978 <sg_uart_config+0x50>
    330a:	69c50513          	addi	a0,a0,1692 # 2000169c <g_idle_task>
    330e:	2a2d                	jal	3448 <krhino_task_create>
                       &g_idle_task_stack[0][0], RHINO_CONFIG_IDLE_TASK_STACK_SIZE /*256 + 20*/,
                       idle_task, 1u);

    //create task1
    krhino_task_create(&g_test_task1 /* tcb */, "task1", NULL, 10, 0,
    3310:	678d                	lui	a5,0x3
    3312:	5de78793          	addi	a5,a5,1502 # 35de <test_task1>
    3316:	c23e                	sw	a5,4(sp)
    3318:	05400493          	li	s1,84
    331c:	200027b7          	lui	a5,0x20002
    3320:	6595                	lui	a1,0x5
    3322:	20002537          	lui	a0,0x20002
    3326:	c422                	sw	s0,8(sp)
    3328:	c026                	sw	s1,0(sp)
    332a:	cb878793          	addi	a5,a5,-840 # 20001cb8 <g_test_task1_stack>
    332e:	4701                	li	a4,0
    3330:	46a9                	li	a3,10
    3332:	4601                	li	a2,0
    3334:	98458593          	addi	a1,a1,-1660 # 4984 <sg_uart_config+0x5c>
    3338:	c6050513          	addi	a0,a0,-928 # 20001c60 <g_test_task1>
    333c:	2231                	jal	3448 <krhino_task_create>
                       g_test_task1_stack, RHINO_CONFIG_K_DYN_TASK_STACK /*64 + 20*/,
                        test_task1, 1u);
    //create task2
    krhino_task_create(&g_test_task2 /* tcb */, "task2", NULL, 10, 0,
    333e:	678d                	lui	a5,0x3
    3340:	5fc78793          	addi	a5,a5,1532 # 35fc <test_task2>
    3344:	c23e                	sw	a5,4(sp)
    3346:	6595                	lui	a1,0x5
    3348:	200027b7          	lui	a5,0x20002
    334c:	20002537          	lui	a0,0x20002
    3350:	c422                	sw	s0,8(sp)
    3352:	c026                	sw	s1,0(sp)
    3354:	e6078793          	addi	a5,a5,-416 # 20001e60 <g_test_task2_stack>
    3358:	4701                	li	a4,0
    335a:	46a9                	li	a3,10
    335c:	4601                	li	a2,0
    335e:	98c58593          	addi	a1,a1,-1652 # 498c <sg_uart_config+0x64>
    3362:	e0850513          	addi	a0,a0,-504 # 20001e08 <g_test_task2>
    3366:	20cd                	jal	3448 <krhino_task_create>
                       g_test_task2_stack, RHINO_CONFIG_K_DYN_TASK_STACK /*64 + 20*/,
                       test_task2, 1u);
    //ktimer_init();

    return RHINO_SUCCESS;
}
    3368:	40d2                	lw	ra,20(sp)
    336a:	4442                	lw	s0,16(sp)
    336c:	44b2                	lw	s1,12(sp)
    336e:	4501                	li	a0,0
    3370:	0161                	addi	sp,sp,24
    3372:	8082                	ret

00003374 <krhino_start>:

kstat_t krhino_start(void){
    3374:	1151                	addi	sp,sp,-12
    3376:	c222                	sw	s0,4(sp)
    //CPSR_ALLOC();
    if (g_sys_stat == RHINO_STOPPED) {
    3378:	0341a703          	lw	a4,52(gp) # 20000214 <g_sys_stat>
kstat_t krhino_start(void){
    337c:	c406                	sw	ra,8(sp)
    if (g_sys_stat == RHINO_STOPPED) {
    337e:	4791                	li	a5,4
    3380:	4501                	li	a0,0
    3382:	02f71263          	bne	a4,a5,33a6 <krhino_start+0x32>
        //RHINO_CPU_INTRPT_DISABLE();
        preferred_cpu_ready_task_get(&g_ready_queue, 0);
    3386:	20002537          	lui	a0,0x20002
    338a:	b5c50513          	addi	a0,a0,-1188 # 20001b5c <g_ready_queue>
    338e:	4581                	li	a1,0
    3390:	3531                	jal	319c <preferred_cpu_ready_task_get>
        g_active_task[0] = g_preferred_ready_task[0];
    3392:	02c1a703          	lw	a4,44(gp) # 2000020c <g_preferred_ready_task>
    3396:	00e1ae23          	sw	a4,28(gp) # 200001fc <g_active_task>
        //cpu_stack_t *sp = g_active_task[0]->task_stack;
        //printf("active task %s \r\n", g_active_task[0]->task_name);
        //for (int i = 0; i < 16; i++) {
        //    printf("[%02d] 0x%08lx\r\n", i, (unsigned long)sp[i]);
        //}
        g_sys_stat = RHINO_RUNNING;
    339a:	478d                	li	a5,3
    339c:	02f1aa23          	sw	a5,52(gp) # 20000214 <g_sys_stat>
        cpu_first_task_start();
    33a0:	d97fc0ef          	jal	ra,136 <cpu_first_task_start>
        //RHINO_CPU_INTRPT_ENABLE();
        /* should not be here */
        return RHINO_SYS_FATAL_ERR;
    33a4:	4505                	li	a0,1
    }
    return RHINO_SUCCESS;
}
    33a6:	40a2                	lw	ra,8(sp)
    33a8:	4412                	lw	s0,4(sp)
    33aa:	0131                	addi	sp,sp,12
    33ac:	8082                	ret

000033ae <krhino_intrpt_enter>:

kstat_t krhino_intrpt_enter(void){
    33ae:	1151                	addi	sp,sp,-12
    33b0:	c406                	sw	ra,8(sp)
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    33b2:	d53fc0ef          	jal	ra,104 <cpu_intrpt_save>
    cur_cpu_num = cpu_cur_get();
    if(g_intrpt_nested_level[cur_cpu_num] > RHINO_CONFIG_INTRPT_MAX_NESTED_LEVEL){
    33b6:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    33ba:	0bc00693          	li	a3,188
    33be:	00f6f863          	bgeu	a3,a5,33ce <krhino_intrpt_enter+0x20>
        RHINO_CPU_INTRPT_ENABLE();
    33c2:	d4dfc0ef          	jal	ra,10e <cpu_intrpt_restore>
        return -1;
    33c6:	557d                	li	a0,-1
    }
    g_intrpt_nested_level[cur_cpu_num]++;
    RHINO_CPU_INTRPT_ENABLE();
    return RHINO_SUCCESS;
}
    33c8:	40a2                	lw	ra,8(sp)
    33ca:	0131                	addi	sp,sp,12
    33cc:	8082                	ret
    g_intrpt_nested_level[cur_cpu_num]++;
    33ce:	0785                	addi	a5,a5,1
    33d0:	02f18423          	sb	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    RHINO_CPU_INTRPT_ENABLE();
    33d4:	d3bfc0ef          	jal	ra,10e <cpu_intrpt_restore>
    return RHINO_SUCCESS;
    33d8:	4501                	li	a0,0
    33da:	b7fd                	j	33c8 <krhino_intrpt_enter+0x1a>

000033dc <krhino_intrpt_exit>:

void krhino_intrpt_exit(void){
    33dc:	1151                	addi	sp,sp,-12
    33de:	c222                	sw	s0,4(sp)
    33e0:	c026                	sw	s1,0(sp)
    33e2:	c406                	sw	ra,8(sp)
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    33e4:	d21fc0ef          	jal	ra,104 <cpu_intrpt_save>
    cur_cpu_num = cpu_cur_get();

    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
    33e8:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    RHINO_CPU_INTRPT_DISABLE();
    33ec:	842a                	mv	s0,a0
    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
    33ee:	e399                	bnez	a5,33f4 <krhino_intrpt_exit+0x18>
        RHINO_CPU_INTRPT_ENABLE();
    33f0:	d1ffc0ef          	jal	ra,10e <cpu_intrpt_restore>
        //error
    }

    g_intrpt_nested_level[cur_cpu_num]--;
    33f4:	0281c783          	lbu	a5,40(gp) # 20000208 <g_intrpt_nested_level>
    33f8:	17fd                	addi	a5,a5,-1
    33fa:	0ff7f793          	zext.b	a5,a5
    33fe:	02f18423          	sb	a5,40(gp) # 20000208 <g_intrpt_nested_level>

    if(g_intrpt_nested_level[cur_cpu_num] > 0u){
    3402:	cb81                	beqz	a5,3412 <krhino_intrpt_exit+0x36>
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }
    /* switch between g_active_task and g_preferred_ready_task*/
    cpu_intrpt_switch();
    RHINO_CPU_INTRPT_ENABLE();
    3404:	8522                	mv	a0,s0
}
    3406:	4412                	lw	s0,4(sp)
    3408:	40a2                	lw	ra,8(sp)
    340a:	4482                	lw	s1,0(sp)
    340c:	0131                	addi	sp,sp,12
    RHINO_CPU_INTRPT_ENABLE();
    340e:	d01fc06f          	j	10e <cpu_intrpt_restore>
    if(g_sched_lock[cur_cpu_num] > 0u){
    3412:	0301c783          	lbu	a5,48(gp) # 20000210 <g_sched_lock>
    3416:	f7fd                	bnez	a5,3404 <krhino_intrpt_exit+0x28>
    preferred_cpu_ready_task_get(&g_ready_queue, cur_cpu_num);
    3418:	20002537          	lui	a0,0x20002
    341c:	4581                	li	a1,0
    341e:	b5c50513          	addi	a0,a0,-1188 # 20001b5c <g_ready_queue>
    3422:	3bad                	jal	319c <preferred_cpu_ready_task_get>
    cpu_stack_t *sp = g_active_task[0]->task_stack;
    3424:	01c1a783          	lw	a5,28(gp) # 200001fc <g_active_task>
    printf("ret: 0x%08lx\n",(unsigned long)sp[14]);
    3428:	6515                	lui	a0,0x5
    342a:	99450513          	addi	a0,a0,-1644 # 4994 <sg_uart_config+0x6c>
    342e:	439c                	lw	a5,0(a5)
    3430:	5f8c                	lw	a1,56(a5)
    3432:	7e4000ef          	jal	ra,3c16 <printf>
    if(g_preferred_ready_task[cur_cpu_num] == g_active_task[cur_cpu_num]){
    3436:	02c1a703          	lw	a4,44(gp) # 2000020c <g_preferred_ready_task>
    343a:	01c1a783          	lw	a5,28(gp) # 200001fc <g_active_task>
    343e:	fcf703e3          	beq	a4,a5,3404 <krhino_intrpt_exit+0x28>
    cpu_intrpt_switch();
    3442:	ce9fc0ef          	jal	ra,12a <cpu_intrpt_switch>
    3446:	bf7d                	j	3404 <krhino_intrpt_exit+0x28>

00003448 <krhino_task_create>:
    return RHINO_SUCCESS;
}

kstat_t krhino_task_create(ktask_t *task, const name_t *name, void *arg,
                           uint8_t prio, tick_t ticks, cpu_stack_t *stack_buf,
                           size_t stack_size, task_entry_t entry, uint8_t autorun){
    3448:	fd810113          	addi	sp,sp,-40
    344c:	c23e                	sw	a5,4(sp)
    344e:	03014783          	lbu	a5,48(sp)
    3452:	d022                	sw	s0,32(sp)
    3454:	d206                	sw	ra,36(sp)
    3456:	ce26                	sw	s1,28(sp)
    3458:	c42e                	sw	a1,8(sp)
    345a:	c832                	sw	a2,16(sp)
    345c:	c036                	sw	a3,0(sp)
    345e:	ca3a                	sw	a4,20(sp)
    3460:	c63e                	sw	a5,12(sp)
    3462:	5422                	lw	s0,40(sp)
    NULL_PARA_CHK(task);
    3464:	12050363          	beqz	a0,358a <krhino_task_create+0x142>
    NULL_PARA_CHK(name);
    3468:	12058163          	beqz	a1,358a <krhino_task_create+0x142>
    NULL_PARA_CHK(entry);
    346c:	57b2                	lw	a5,44(sp)
    346e:	10078e63          	beqz	a5,358a <krhino_task_create+0x142>
    NULL_PARA_CHK(stack_buf);
    3472:	4792                	lw	a5,4(sp)
    3474:	10078b63          	beqz	a5,358a <krhino_task_create+0x142>
    if(stack_size == 0u) { return 0; /*RHINO_TASK_INV_STACK_SIZE */}
    3478:	c01d                	beqz	s0,349e <krhino_task_create+0x56>
    if(prio >= RHINO_CONFIG_PRI_MAX) {return 0;/*RHINO_BEYOND_MAX_PRI*/ }
    347a:	03d00613          	li	a2,61
    347e:	0ed66d63          	bltu	a2,a3,3578 <krhino_task_create+0x130>
    3482:	84aa                	mv	s1,a0
    RHINO_CRITICAL_ENTER();
    3484:	c81fc0ef          	jal	ra,104 <cpu_intrpt_save>
    INTRPT_NESTED_LEVEL_CHK();
    3488:	0281c583          	lbu	a1,40(gp) # 20000208 <g_intrpt_nested_level>
    348c:	4752                	lw	a4,20(sp)
    RHINO_CRITICAL_ENTER();
    348e:	86aa                	mv	a3,a0
    INTRPT_NESTED_LEVEL_CHK();
    3490:	03d00613          	li	a2,61
    3494:	cd81                	beqz	a1,34ac <krhino_task_create+0x64>
    3496:	c79fc0ef          	jal	ra,10e <cpu_intrpt_restore>
    349a:	3ea00413          	li	s0,1002
    return task_create(task,name,arg,prio,ticks,stack_buf,stack_size,entry,autorun,
                       K_OBJ_STATIC_ALLOC,0,0);
}
    349e:	5092                	lw	ra,36(sp)
    34a0:	8522                	mv	a0,s0
    34a2:	5402                	lw	s0,32(sp)
    34a4:	44f2                	lw	s1,28(sp)
    34a6:	02810113          	addi	sp,sp,40
    34aa:	8082                	ret
    if(prio == RHINO_IDLE_PRI){
    34ac:	4782                	lw	a5,0(sp)
    34ae:	00c79b63          	bne	a5,a2,34c4 <krhino_task_create+0x7c>
        if(g_idle_spawned[cpu_num] >0u){
    34b2:	0241c583          	lbu	a1,36(gp) # 20000204 <g_idle_spawned>
    34b6:	c581                	beqz	a1,34be <krhino_task_create+0x76>
    RHINO_CRITICAL_EXIT();
    34b8:	c57fc0ef          	jal	ra,10e <cpu_intrpt_restore>
    return RHINO_SUCCESS;
    34bc:	a875                	j	3578 <krhino_task_create+0x130>
        g_idle_spawned[cpu_num] = 1u;
    34be:	4585                	li	a1,1
    34c0:	02b18223          	sb	a1,36(gp) # 20000204 <g_idle_spawned>
    memset(task,0,sizeof(ktask_t));
    34c4:	05800613          	li	a2,88
    34c8:	4581                	li	a1,0
    34ca:	8526                	mv	a0,s1
    34cc:	cc3a                	sw	a4,24(sp)
    34ce:	ca36                	sw	a3,20(sp)
    34d0:	de8fd0ef          	jal	ra,ab8 <memset>
    if(ticks > 0u){
    34d4:	4762                	lw	a4,24(sp)
    34d6:	46d2                	lw	a3,20(sp)
    34d8:	e319                	bnez	a4,34de <krhino_task_create+0x96>
        task->time_total = RHINO_CONFIG_TIME_SLICE_DEFAULT;
    34da:	03200713          	li	a4,50
    34de:	c4f8                	sw	a4,76(s1)
    task->time_slice   = task->time_total;
    34e0:	c4b8                	sw	a4,72(s1)
    task->sched_policy = KSCHED_RR;
    34e2:	4705                	li	a4,1
    34e4:	04e48823          	sb	a4,80(s1)
    RHINO_CRITICAL_EXIT();
    34e8:	8536                	mv	a0,a3
    34ea:	c25fc0ef          	jal	ra,10e <cpu_intrpt_restore>
    if(autorun > 0u){
    34ee:	47b2                	lw	a5,12(sp)
    34f0:	4705                	li	a4,1
    34f2:	c7c9                	beqz	a5,357c <krhino_task_create+0x134>
        task->task_state = K_RDY;
    34f4:	dcd8                	sw	a4,60(s1)
    task->task_stack_base = stack_buf;
    34f6:	4792                	lw	a5,4(sp)
    memset(tmp,0,stack_size*sizeof(cpu_stack_t));
    34f8:	00241613          	slli	a2,s0,0x2
    34fc:	4581                	li	a1,0
    task->task_stack_base = stack_buf;
    34fe:	c0dc                	sw	a5,4(s1)
    memset(tmp,0,stack_size*sizeof(cpu_stack_t));
    3500:	853e                	mv	a0,a5
    3502:	db6fd0ef          	jal	ra,ab8 <memset>
    task->task_name     = name;
    3506:	47a2                	lw	a5,8(sp)
    *tmp = RHINO_TASK_STACK_OVF_MAGIC;
    3508:	40d4                	lw	a3,4(s1)
    task->mm_alloc_flag = mm_alloc_flag;
    350a:	4705                	li	a4,1
    task->task_name     = name;
    350c:	dc9c                	sw	a5,56(s1)
    task->prio          = prio;
    350e:	4782                	lw	a5,0(sp)
    task->mm_alloc_flag = mm_alloc_flag;
    3510:	04e48a23          	sb	a4,84(s1)
    *tmp = RHINO_TASK_STACK_OVF_MAGIC;
    3514:	deadc737          	lui	a4,0xdeadc
    task->prio          = prio;
    3518:	04f48923          	sb	a5,82(s1)
    task->b_prio        = prio;
    351c:	04f489a3          	sb	a5,83(s1)
    *tmp = RHINO_TASK_STACK_OVF_MAGIC;
    3520:	eef70713          	addi	a4,a4,-273 # deadbeef <__bss_end__+0xbead9f3f>
    task->stack_size    = stack_size;
    3524:	c480                	sw	s0,8(s1)
    task->cpu_num       = cpu_num;
    3526:	040488a3          	sb	zero,81(s1)
    *tmp = RHINO_TASK_STACK_OVF_MAGIC;
    352a:	c298                	sw	a4,0(a3)
    task->task_stack = cpu_task_stack_init(stack_buf,stack_size,arg,entry);
    352c:	4642                	lw	a2,16(sp)
    352e:	56b2                	lw	a3,44(sp)
    3530:	4512                	lw	a0,4(sp)
    3532:	85a2                	mv	a1,s0
    3534:	aefff0ef          	jal	ra,3022 <cpu_task_stack_init>
    3538:	c088                	sw	a0,0(s1)
    RHINO_CRITICAL_ENTER();
    353a:	bcbfc0ef          	jal	ra,104 <cpu_intrpt_save>
    element->prev = head->prev;
    353e:	200027b7          	lui	a5,0x20002
    3542:	b4478793          	addi	a5,a5,-1212 # 20001b44 <g_kobj_list>
    3546:	43d4                	lw	a3,4(a5)
    klist_insert(&(g_kobj_list.task_head), &task->task_stats_item);
    3548:	01848713          	addi	a4,s1,24
    element->next = head;
    354c:	cc9c                	sw	a5,24(s1)
    element->prev = head->prev;
    354e:	ccd4                	sw	a3,28(s1)
    head->prev->next = element;
    3550:	c298                	sw	a4,0(a3)
    head->prev       = element;
    3552:	c3d8                	sw	a4,4(a5)
    if(autorun > 0u){
    3554:	47b2                	lw	a5,12(sp)
    RHINO_CRITICAL_ENTER();
    3556:	842a                	mv	s0,a0
    if(autorun > 0u){
    3558:	c79d                	beqz	a5,3586 <krhino_task_create+0x13e>
        ready_list_add_tail(&g_ready_queue,task);
    355a:	20002537          	lui	a0,0x20002
    355e:	85a6                	mv	a1,s1
    3560:	b5c50513          	addi	a0,a0,-1188 # 20001b5c <g_ready_queue>
    3564:	391d                	jal	319a <ready_list_add_tail>
        if(g_sys_stat == RHINO_RUNNING){
    3566:	0341a703          	lw	a4,52(gp) # 20000214 <g_sys_stat>
    356a:	478d                	li	a5,3
    356c:	00f71d63          	bne	a4,a5,3586 <krhino_task_create+0x13e>
            RHINO_CRITICAL_EXIT_SCHED();
    3570:	8522                	mv	a0,s0
    3572:	b9dfc0ef          	jal	ra,10e <cpu_intrpt_restore>
    3576:	3925                	jal	31ae <core_sched>
    if(stack_size == 0u) { return 0; /*RHINO_TASK_INV_STACK_SIZE */}
    3578:	4401                	li	s0,0
    357a:	b715                	j	349e <krhino_task_create+0x56>
        task->task_state = K_SUSPENDED;
    357c:	468d                	li	a3,3
    357e:	dcd4                	sw	a3,60(s1)
        task->suspend_count = 1u;
    3580:	00e48a23          	sb	a4,20(s1)
    3584:	bf8d                	j	34f6 <krhino_task_create+0xae>
    RHINO_CRITICAL_EXIT();
    3586:	8522                	mv	a0,s0
    3588:	bf05                	j	34b8 <krhino_task_create+0x70>
    NULL_PARA_CHK(task);
    358a:	4419                	li	s0,6
    358c:	bf09                	j	349e <krhino_task_create+0x56>

0000358e <krhino_task_dyn_del>:

kstat_t krhino_task_sleep(tick_t dly){
    return 0;
}

kstat_t krhino_task_dyn_del(ktask_t *task){
    358e:	1151                	addi	sp,sp,-12
    3590:	c406                	sw	ra,8(sp)

    CPSR_ALLOC();

    RHINO_CRITICAL_ENTER();
    3592:	b73fc0ef          	jal	ra,104 <cpu_intrpt_save>

    RHINO_CRITICAL_EXIT();
    3596:	b79fc0ef          	jal	ra,10e <cpu_intrpt_restore>


    return 0;
}
    359a:	40a2                	lw	ra,8(sp)
    359c:	4501                	li	a0,0
    359e:	0131                	addi	sp,sp,12
    35a0:	8082                	ret

000035a2 <krhino_cur_task_get>:

ktask_t *krhino_cur_task_get(void){
    35a2:	1151                	addi	sp,sp,-12
    35a4:	c406                	sw	ra,8(sp)
    35a6:	c222                	sw	s0,4(sp)
    CPSR_ALLOC();
    ktask_t *task;
    RHINO_CRITICAL_ENTER();
    35a8:	b5dfc0ef          	jal	ra,104 <cpu_intrpt_save>
    task = g_active_task[cpu_cur_get()];
    35ac:	01c1a403          	lw	s0,28(gp) # 200001fc <g_active_task>
    RHINO_CRITICAL_EXIT();
    35b0:	b5ffc0ef          	jal	ra,10e <cpu_intrpt_restore>
    return task;
}
    35b4:	40a2                	lw	ra,8(sp)
    35b6:	8522                	mv	a0,s0
    35b8:	4412                	lw	s0,4(sp)
    35ba:	0131                	addi	sp,sp,12
    35bc:	8082                	ret

000035be <krhino_task_deathbed>:

void krhino_task_deathbed(void){
    35be:	1151                	addi	sp,sp,-12
    35c0:	c406                	sw	ra,8(sp)
    35c2:	c222                	sw	s0,4(sp)
    ktask_t *task;
    task = krhino_cur_task_get();
    35c4:	3ff9                	jal	35a2 <krhino_cur_task_get>
    if(task->mm_alloc_flag == K_OBJ_DYN_ALLOC){
    35c6:	05454703          	lbu	a4,84(a0)
    35ca:	4789                	li	a5,2
    35cc:	00f71463          	bne	a4,a5,35d4 <krhino_task_deathbed+0x16>
        krhino_task_dyn_del(NULL);
    35d0:	4501                	li	a0,0
    35d2:	3f75                	jal	358e <krhino_task_dyn_del>
    }
    while(1){
        printf("krhino_task_deathbed \r\n");
    35d4:	6415                	lui	s0,0x5
    35d6:	9a440513          	addi	a0,s0,-1628 # 49a4 <sg_uart_config+0x7c>
    35da:	2d95                	jal	3c4e <puts>
    return 0;
    35dc:	bfed                	j	35d6 <krhino_task_deathbed+0x18>

000035de <test_task1>:
        krhino_task_sleep(RHINO_CONFIG_TICKS_PER_SECOND * 10);
    }
}

void test_task1(void *arg){
    35de:	1151                	addi	sp,sp,-12
    35e0:	c026                	sw	s1,0(sp)
    35e2:	c406                	sw	ra,8(sp)
    35e4:	c222                	sw	s0,4(sp)
    CPSR_ALLOC();
    (void)arg;
    while (1){
        RHINO_CPU_INTRPT_DISABLE();
        printf("t1\n");
    35e6:	6495                	lui	s1,0x5
        RHINO_CPU_INTRPT_DISABLE();
    35e8:	b1dfc0ef          	jal	ra,104 <cpu_intrpt_save>
    35ec:	842a                	mv	s0,a0
        printf("t1\n");
    35ee:	9bc48513          	addi	a0,s1,-1604 # 49bc <sg_uart_config+0x94>
    35f2:	2db1                	jal	3c4e <puts>
        RHINO_CPU_INTRPT_ENABLE();
    35f4:	8522                	mv	a0,s0
    35f6:	b19fc0ef          	jal	ra,10e <cpu_intrpt_restore>
    while (1){
    35fa:	b7fd                	j	35e8 <test_task1+0xa>

000035fc <test_task2>:
    }
}

void test_task2(void *arg){
    35fc:	1151                	addi	sp,sp,-12
    35fe:	c026                	sw	s1,0(sp)
    3600:	c406                	sw	ra,8(sp)
    3602:	c222                	sw	s0,4(sp)
    CPSR_ALLOC();
    (void)arg;
    while (1){
        RHINO_CPU_INTRPT_DISABLE();
        printf("t2\n");
    3604:	6495                	lui	s1,0x5
        RHINO_CPU_INTRPT_DISABLE();
    3606:	afffc0ef          	jal	ra,104 <cpu_intrpt_save>
    360a:	842a                	mv	s0,a0
        printf("t2\n");
    360c:	9c048513          	addi	a0,s1,-1600 # 49c0 <sg_uart_config+0x98>
    3610:	2d3d                	jal	3c4e <puts>
        RHINO_CPU_INTRPT_ENABLE();
    3612:	8522                	mv	a0,s0
    3614:	afbfc0ef          	jal	ra,10e <cpu_intrpt_restore>
    while (1){
    3618:	b7fd                	j	3606 <test_task2+0xa>

0000361a <tick_list_init>:
    list_head->next = list_head;
    361a:	03c18793          	addi	a5,gp,60 # 2000021c <g_tick_head>
    361e:	c39c                	sw	a5,0(a5)
    list_head->prev = list_head;
    3620:	c3dc                	sw	a5,4(a5)
#include "../include/k_api.h"

void tick_list_init(void){
    klist_init(&g_tick_head);
}
    3622:	8082                	ret

00003624 <tick_list_update>:
        tick_list_pri_insert(tick_head_ptr, task);
        task->tick_head   = tick_head_ptr;
    }
}

void tick_list_update(tick_i_t ticks){
    3624:	1151                	addi	sp,sp,-12
    3626:	c222                	sw	s0,4(sp)
    3628:	c406                	sw	ra,8(sp)
    362a:	842a                	mv	s0,a0
    ktask_t  *p_tcb;
    klist_t  *iter;
    klist_t  *iter_temp;
    tick_i_t  delta;

    RHINO_CRITICAL_ENTER();
    362c:	ad9fc0ef          	jal	ra,104 <cpu_intrpt_save>

    g_tick_count += ticks;
    3630:	0381a783          	lw	a5,56(gp) # 20000218 <g_tick_count>
            break;
        }
    }

    RHINO_CRITICAL_EXIT();
}
    3634:	40a2                	lw	ra,8(sp)
    g_tick_count += ticks;
    3636:	97a2                	add	a5,a5,s0
}
    3638:	4412                	lw	s0,4(sp)
    g_tick_count += ticks;
    363a:	02f1ac23          	sw	a5,56(gp) # 20000218 <g_tick_count>
}
    363e:	0131                	addi	sp,sp,12
    RHINO_CRITICAL_EXIT();
    3640:	acffc06f          	j	10e <cpu_intrpt_restore>

00003644 <krhino_tick_proc>:
#include "../include/k_api.h"

void krhino_tick_proc(void){
    3644:	1151                	addi	sp,sp,-12
    tick_list_update(1);
    3646:	4505                	li	a0,1
void krhino_tick_proc(void){
    3648:	c406                	sw	ra,8(sp)
    tick_list_update(1);
    364a:	3fe9                	jal	3624 <tick_list_update>
    time_slice_update();
}
    364c:	40a2                	lw	ra,8(sp)
    364e:	0131                	addi	sp,sp,12
    time_slice_update();
    3650:	befff06f          	j	323e <time_slice_update>

00003654 <copystring>:
    3654:	87aa                	mv	a5,a0
    3656:	470d                	li	a4,3
    3658:	4501                	li	a0,0
    365a:	00b54363          	blt	a0,a1,3660 <copystring+0xc>
    365e:	8082                	ret
    3660:	00a606b3          	add	a3,a2,a0
    3664:	0006c303          	lbu	t1,0(a3)
    3668:	00a786b3          	add	a3,a5,a0
    366c:	0505                	addi	a0,a0,1
    366e:	00668023          	sb	t1,0(a3)
    3672:	fee514e3          	bne	a0,a4,365a <copystring+0x6>
    3676:	00b55563          	bge	a0,a1,3680 <copystring+0x2c>
    367a:	000781a3          	sb	zero,3(a5)
    367e:	4511                	li	a0,4
    3680:	8082                	ret

00003682 <__dtostr>:
    3682:	fa810113          	addi	sp,sp,-88
    3686:	c6a6                	sw	s1,76(sp)
    3688:	ca86                	sw	ra,84(sp)
    368a:	c8a2                	sw	s0,80(sp)
    368c:	cc2a                	sw	a0,24(sp)
    368e:	c42e                	sw	a1,8(sp)
    3690:	c032                	sw	a2,0(sp)
    3692:	84b6                	mv	s1,a3
    3694:	d43a                	sw	a4,40(sp)
    3696:	c23e                	sw	a5,4(sp)
    3698:	2ec5                	jal	3a88 <__isinf>
    369a:	cd01                	beqz	a0,36b2 <__dtostr+0x30>
    369c:	6615                	lui	a2,0x5
    369e:	9c460613          	addi	a2,a2,-1596 # 49c4 <sg_uart_config+0x9c>
    36a2:	4446                	lw	s0,80(sp)
    36a4:	4502                	lw	a0,0(sp)
    36a6:	40d6                	lw	ra,84(sp)
    36a8:	85a6                	mv	a1,s1
    36aa:	44b6                	lw	s1,76(sp)
    36ac:	05810113          	addi	sp,sp,88
    36b0:	b755                	j	3654 <copystring>
    36b2:	4762                	lw	a4,24(sp)
    36b4:	47a2                	lw	a5,8(sp)
    36b6:	853a                	mv	a0,a4
    36b8:	85be                	mv	a1,a5
    36ba:	26fd                	jal	3aa8 <__isnan>
    36bc:	d22a                	sw	a0,36(sp)
    36be:	c509                	beqz	a0,36c8 <__dtostr+0x46>
    36c0:	6615                	lui	a2,0x5
    36c2:	9c860613          	addi	a2,a2,-1592 # 49c8 <sg_uart_config+0xa0>
    36c6:	bff1                	j	36a2 <__dtostr+0x20>
    36c8:	4762                	lw	a4,24(sp)
    36ca:	47a2                	lw	a5,8(sp)
    36cc:	4601                	li	a2,0
    36ce:	4681                	li	a3,0
    36d0:	853a                	mv	a0,a4
    36d2:	85be                	mv	a1,a5
    36d4:	87ffe0ef          	jal	ra,1f52 <__eqdf2>
    36d8:	e141                	bnez	a0,3758 <__dtostr+0xd6>
    36da:	4792                	lw	a5,4(sp)
    36dc:	3a078163          	beqz	a5,3a7e <__dtostr+0x3fc>
    36e0:	00278513          	addi	a0,a5,2
    36e4:	06a4e863          	bltu	s1,a0,3754 <__dtostr+0xd2>
    36e8:	c915                	beqz	a0,371c <__dtostr+0x9a>
    36ea:	47a2                	lw	a5,8(sp)
    36ec:	4401                	li	s0,0
    36ee:	0007db63          	bgez	a5,3704 <__dtostr+0x82>
    36f2:	4702                	lw	a4,0(sp)
    36f4:	02d00793          	li	a5,45
    36f8:	0505                	addi	a0,a0,1
    36fa:	00f70023          	sb	a5,0(a4)
    36fe:	4405                	li	s0,1
    3700:	4481                	li	s1,0
    3702:	c119                	beqz	a0,3708 <__dtostr+0x86>
    3704:	408504b3          	sub	s1,a0,s0
    3708:	4782                	lw	a5,0(sp)
    370a:	8626                	mv	a2,s1
    370c:	03000593          	li	a1,48
    3710:	00878533          	add	a0,a5,s0
    3714:	ba4fd0ef          	jal	ra,ab8 <memset>
    3718:	00848533          	add	a0,s1,s0
    371c:	4782                	lw	a5,0(sp)
    371e:	03000713          	li	a4,48
    3722:	0007c683          	lbu	a3,0(a5)
    3726:	4785                	li	a5,1
    3728:	00e68363          	beq	a3,a4,372e <__dtostr+0xac>
    372c:	4789                	li	a5,2
    372e:	4702                	lw	a4,0(sp)
    3730:	d22a                	sw	a0,36(sp)
    3732:	97ba                	add	a5,a5,a4
    3734:	02e00713          	li	a4,46
    3738:	00e78023          	sb	a4,0(a5)
    373c:	4782                	lw	a5,0(sp)
    373e:	00a78633          	add	a2,a5,a0
    3742:	00060023          	sb	zero,0(a2)
    3746:	40d6                	lw	ra,84(sp)
    3748:	4446                	lw	s0,80(sp)
    374a:	5512                	lw	a0,36(sp)
    374c:	44b6                	lw	s1,76(sp)
    374e:	05810113          	addi	sp,sp,88
    3752:	8082                	ret
    3754:	4521                	li	a0,8
    3756:	bf51                	j	36ea <__dtostr+0x68>
    3758:	4762                	lw	a4,24(sp)
    375a:	47a2                	lw	a5,8(sp)
    375c:	4601                	li	a2,0
    375e:	4681                	li	a3,0
    3760:	853a                	mv	a0,a4
    3762:	85be                	mv	a1,a5
    3764:	917fe0ef          	jal	ra,207a <__ledf2>
    3768:	16055b63          	bgez	a0,38de <__dtostr+0x25c>
    376c:	47a2                	lw	a5,8(sp)
    376e:	4702                	lw	a4,0(sp)
    3770:	80000337          	lui	t1,0x80000
    3774:	00f34333          	xor	t1,t1,a5
    3778:	02d00793          	li	a5,45
    377c:	00f70023          	sb	a5,0(a4)
    3780:	14fd                	addi	s1,s1,-1
    3782:	00170413          	addi	s0,a4,1
    3786:	6795                	lui	a5,0x5
    3788:	2187a503          	lw	a0,536(a5) # 5218 <pad_line+0x720>
    378c:	21c7a583          	lw	a1,540(a5)
    3790:	6795                	lui	a5,0x5
    3792:	2287a703          	lw	a4,552(a5) # 5228 <pad_line+0x730>
    3796:	22c7a783          	lw	a5,556(a5)
    379a:	4281                	li	t0,0
    379c:	c83a                	sw	a4,16(sp)
    379e:	ca3e                	sw	a5,20(sp)
    37a0:	4792                	lw	a5,4(sp)
    37a2:	14f29163          	bne	t0,a5,38e4 <__dtostr+0x262>
    37a6:	4762                	lw	a4,24(sp)
    37a8:	862a                	mv	a2,a0
    37aa:	86ae                	mv	a3,a1
    37ac:	853a                	mv	a0,a4
    37ae:	859a                	mv	a1,t1
    37b0:	c1ffd0ef          	jal	ra,13ce <__adddf3>
    37b4:	6795                	lui	a5,0x5
    37b6:	2307a603          	lw	a2,560(a5) # 5230 <pad_line+0x738>
    37ba:	2347a683          	lw	a3,564(a5)
    37be:	ce2a                	sw	a0,28(sp)
    37c0:	d02e                	sw	a1,32(sp)
    37c2:	8b9fe0ef          	jal	ra,207a <__ledf2>
    37c6:	00055863          	bgez	a0,37d6 <__dtostr+0x154>
    37ca:	03000793          	li	a5,48
    37ce:	00f40023          	sb	a5,0(s0)
    37d2:	14fd                	addi	s1,s1,-1
    37d4:	0405                	addi	s0,s0,1
    37d6:	47a2                	lw	a5,8(sp)
    37d8:	0147d513          	srli	a0,a5,0x14
    37dc:	7ff57513          	andi	a0,a0,2047
    37e0:	c0150513          	addi	a0,a0,-1023
    37e4:	c32ff0ef          	jal	ra,2c16 <__floatsidf>
    37e8:	6795                	lui	a5,0x5
    37ea:	2387a603          	lw	a2,568(a5) # 5238 <pad_line+0x740>
    37ee:	23c7a683          	lw	a3,572(a5)
    37f2:	937fe0ef          	jal	ra,2128 <__muldf3>
    37f6:	bbcff0ef          	jal	ra,2bb2 <__fixdfsi>
    37fa:	00150793          	addi	a5,a0,1
    37fe:	c83e                	sw	a5,16(sp)
    3800:	20f05b63          	blez	a5,3a16 <__dtostr+0x394>
    3804:	6695                	lui	a3,0x5
    3806:	2206a703          	lw	a4,544(a3) # 5220 <pad_line+0x728>
    380a:	2246a303          	lw	t1,548(a3)
    380e:	6695                	lui	a3,0x5
    3810:	2406a603          	lw	a2,576(a3) # 5240 <pad_line+0x748>
    3814:	2446a683          	lw	a3,580(a3)
    3818:	42a9                	li	t0,10
    381a:	d632                	sw	a2,44(sp)
    381c:	d836                	sw	a3,48(sp)
    381e:	0cf2ed63          	bltu	t0,a5,38f8 <__dtostr+0x276>
    3822:	6695                	lui	a3,0x5
    3824:	2206a603          	lw	a2,544(a3) # 5220 <pad_line+0x728>
    3828:	2246a683          	lw	a3,548(a3)
    382c:	4285                	li	t0,1
    382e:	d632                	sw	a2,44(sp)
    3830:	d836                	sw	a3,48(sp)
    3832:	0e579063          	bne	a5,t0,3912 <__dtostr+0x290>
    3836:	4785                	li	a5,1
    3838:	d63e                	sw	a5,44(sp)
    383a:	6795                	lui	a5,0x5
    383c:	2487a603          	lw	a2,584(a5) # 5248 <pad_line+0x750>
    3840:	24c7a683          	lw	a3,588(a5)
    3844:	6795                	lui	a5,0x5
    3846:	da32                	sw	a2,52(sp)
    3848:	dc36                	sw	a3,56(sp)
    384a:	2207a603          	lw	a2,544(a5) # 5220 <pad_line+0x728>
    384e:	2247a683          	lw	a3,548(a5)
    3852:	de32                	sw	a2,60(sp)
    3854:	c0b6                	sw	a3,64(sp)
    3856:	5652                	lw	a2,52(sp)
    3858:	56e2                	lw	a3,56(sp)
    385a:	853a                	mv	a0,a4
    385c:	859a                	mv	a1,t1
    385e:	c4ba                	sw	a4,72(sp)
    3860:	c29a                	sw	t1,68(sp)
    3862:	f6afe0ef          	jal	ra,1fcc <__gedf2>
    3866:	4316                	lw	t1,68(sp)
    3868:	4726                	lw	a4,72(sp)
    386a:	0ca04163          	bgtz	a0,392c <__dtostr+0x2aa>
    386e:	4782                	lw	a5,0(sp)
    3870:	00f41a63          	bne	s0,a5,3884 <__dtostr+0x202>
    3874:	ec0489e3          	beqz	s1,3746 <__dtostr+0xc4>
    3878:	03000793          	li	a5,48
    387c:	00f40023          	sb	a5,0(s0)
    3880:	14fd                	addi	s1,s1,-1
    3882:	0405                	addi	s0,s0,1
    3884:	4792                	lw	a5,4(sp)
    3886:	eb81                	bnez	a5,3896 <__dtostr+0x214>
    3888:	4782                	lw	a5,0(sp)
    388a:	56a2                	lw	a3,40(sp)
    388c:	40f407b3          	sub	a5,s0,a5
    3890:	0785                	addi	a5,a5,1
    3892:	12d7f963          	bgeu	a5,a3,39c4 <__dtostr+0x342>
    3896:	ea0488e3          	beqz	s1,3746 <__dtostr+0xc4>
    389a:	02e00793          	li	a5,46
    389e:	00f40023          	sb	a5,0(s0)
    38a2:	4792                	lw	a5,4(sp)
    38a4:	fff48693          	addi	a3,s1,-1
    38a8:	00140493          	addi	s1,s0,1
    38ac:	eb81                	bnez	a5,38bc <__dtostr+0x23a>
    38ae:	57a2                	lw	a5,40(sp)
    38b0:	4602                	lw	a2,0(sp)
    38b2:	0785                	addi	a5,a5,1
    38b4:	40c48633          	sub	a2,s1,a2
    38b8:	8f91                	sub	a5,a5,a2
    38ba:	c23e                	sw	a5,4(sp)
    38bc:	4792                	lw	a5,4(sp)
    38be:	e8f6e4e3          	bltu	a3,a5,3746 <__dtostr+0xc4>
    38c2:	6695                	lui	a3,0x5
    38c4:	2206a603          	lw	a2,544(a3) # 5220 <pad_line+0x728>
    38c8:	2246a683          	lw	a3,548(a3)
    38cc:	97a2                	add	a5,a5,s0
    38ce:	c432                	sw	a2,8(sp)
    38d0:	c636                	sw	a3,12(sp)
    38d2:	14f41863          	bne	s0,a5,3a22 <__dtostr+0x3a0>
    38d6:	4792                	lw	a5,4(sp)
    38d8:	00f48433          	add	s0,s1,a5
    38dc:	a0e5                	j	39c4 <__dtostr+0x342>
    38de:	4402                	lw	s0,0(sp)
    38e0:	4322                	lw	t1,8(sp)
    38e2:	b555                	j	3786 <__dtostr+0x104>
    38e4:	4642                	lw	a2,16(sp)
    38e6:	46d2                	lw	a3,20(sp)
    38e8:	d01a                	sw	t1,32(sp)
    38ea:	ce16                	sw	t0,28(sp)
    38ec:	83dfe0ef          	jal	ra,2128 <__muldf3>
    38f0:	42f2                	lw	t0,28(sp)
    38f2:	5302                	lw	t1,32(sp)
    38f4:	0285                	addi	t0,t0,1
    38f6:	b56d                	j	37a0 <__dtostr+0x11e>
    38f8:	5632                	lw	a2,44(sp)
    38fa:	56c2                	lw	a3,48(sp)
    38fc:	853a                	mv	a0,a4
    38fe:	859a                	mv	a1,t1
    3900:	da3e                	sw	a5,52(sp)
    3902:	827fe0ef          	jal	ra,2128 <__muldf3>
    3906:	57d2                	lw	a5,52(sp)
    3908:	872a                	mv	a4,a0
    390a:	832e                	mv	t1,a1
    390c:	17d9                	addi	a5,a5,-10
    390e:	42a9                	li	t0,10
    3910:	b739                	j	381e <__dtostr+0x19c>
    3912:	5632                	lw	a2,44(sp)
    3914:	56c2                	lw	a3,48(sp)
    3916:	853a                	mv	a0,a4
    3918:	859a                	mv	a1,t1
    391a:	da3e                	sw	a5,52(sp)
    391c:	80dfe0ef          	jal	ra,2128 <__muldf3>
    3920:	57d2                	lw	a5,52(sp)
    3922:	872a                	mv	a4,a0
    3924:	832e                	mv	t1,a1
    3926:	17fd                	addi	a5,a5,-1
    3928:	4285                	li	t0,1
    392a:	b721                	j	3832 <__dtostr+0x1b0>
    392c:	4572                	lw	a0,28(sp)
    392e:	5582                	lw	a1,32(sp)
    3930:	869a                	mv	a3,t1
    3932:	863a                	mv	a2,a4
    3934:	c4ba                	sw	a4,72(sp)
    3936:	c29a                	sw	t1,68(sp)
    3938:	88cfe0ef          	jal	ra,19c4 <__divdf3>
    393c:	a76ff0ef          	jal	ra,2bb2 <__fixdfsi>
    3940:	56b2                	lw	a3,44(sp)
    3942:	4316                	lw	t1,68(sp)
    3944:	4726                	lw	a4,72(sp)
    3946:	0ff57793          	zext.b	a5,a0
    394a:	c291                	beqz	a3,394e <__dtostr+0x2cc>
    394c:	cfc5                	beqz	a5,3a04 <__dtostr+0x382>
    394e:	03078793          	addi	a5,a5,48
    3952:	00f40023          	sb	a5,0(s0)
    3956:	0405                	addi	s0,s0,1
    3958:	ecad                	bnez	s1,39d2 <__dtostr+0x350>
    395a:	47a2                	lw	a5,8(sp)
    395c:	863a                	mv	a2,a4
    395e:	4762                	lw	a4,24(sp)
    3960:	869a                	mv	a3,t1
    3962:	85be                	mv	a1,a5
    3964:	853a                	mv	a0,a4
    3966:	85efe0ef          	jal	ra,19c4 <__divdf3>
    396a:	4792                	lw	a5,4(sp)
    396c:	5722                	lw	a4,40(sp)
    396e:	4602                	lw	a2,0(sp)
    3970:	4681                	li	a3,0
    3972:	3b01                	jal	3682 <__dtostr>
    3974:	dc0509e3          	beqz	a0,3746 <__dtostr+0xc4>
    3978:	942a                	add	s0,s0,a0
    397a:	06500793          	li	a5,101
    397e:	00f40023          	sb	a5,0(s0)
    3982:	fff54513          	not	a0,a0
    3986:	0405                	addi	s0,s0,1
    3988:	4711                	li	a4,4
    398a:	4685                	li	a3,1
    398c:	3e800793          	li	a5,1000
    3990:	4629                	li	a2,10
    3992:	45c2                	lw	a1,16(sp)
    3994:	00f5d363          	bge	a1,a5,399a <__dtostr+0x318>
    3998:	e285                	bnez	a3,39b8 <__dtostr+0x336>
    399a:	c909                	beqz	a0,39ac <__dtostr+0x32a>
    399c:	46c2                	lw	a3,16(sp)
    399e:	0405                	addi	s0,s0,1
    39a0:	02f6c6b3          	div	a3,a3,a5
    39a4:	03068693          	addi	a3,a3,48
    39a8:	fed40fa3          	sb	a3,-1(s0)
    39ac:	46c2                	lw	a3,16(sp)
    39ae:	157d                	addi	a0,a0,-1
    39b0:	02f6e6b3          	rem	a3,a3,a5
    39b4:	c836                	sw	a3,16(sp)
    39b6:	4681                	li	a3,0
    39b8:	177d                	addi	a4,a4,-1
    39ba:	02c7c7b3          	div	a5,a5,a2
    39be:	fb71                	bnez	a4,3992 <__dtostr+0x310>
    39c0:	d80503e3          	beqz	a0,3746 <__dtostr+0xc4>
    39c4:	4782                	lw	a5,0(sp)
    39c6:	00040023          	sb	zero,0(s0)
    39ca:	40f407b3          	sub	a5,s0,a5
    39ce:	d23e                	sw	a5,36(sp)
    39d0:	bb9d                	j	3746 <__dtostr+0xc4>
    39d2:	0ff57513          	zext.b	a0,a0
    39d6:	c29a                	sw	t1,68(sp)
    39d8:	d63a                	sw	a4,44(sp)
    39da:	a3cff0ef          	jal	ra,2c16 <__floatsidf>
    39de:	5732                	lw	a4,44(sp)
    39e0:	4316                	lw	t1,68(sp)
    39e2:	14fd                	addi	s1,s1,-1
    39e4:	863a                	mv	a2,a4
    39e6:	869a                	mv	a3,t1
    39e8:	c4ba                	sw	a4,72(sp)
    39ea:	f3efe0ef          	jal	ra,2128 <__muldf3>
    39ee:	862a                	mv	a2,a0
    39f0:	86ae                	mv	a3,a1
    39f2:	4572                	lw	a0,28(sp)
    39f4:	5582                	lw	a1,32(sp)
    39f6:	bb1fe0ef          	jal	ra,25a6 <__subdf3>
    39fa:	4726                	lw	a4,72(sp)
    39fc:	4316                	lw	t1,68(sp)
    39fe:	ce2a                	sw	a0,28(sp)
    3a00:	d02e                	sw	a1,32(sp)
    3a02:	d602                	sw	zero,44(sp)
    3a04:	5672                	lw	a2,60(sp)
    3a06:	4686                	lw	a3,64(sp)
    3a08:	853a                	mv	a0,a4
    3a0a:	859a                	mv	a1,t1
    3a0c:	fb9fd0ef          	jal	ra,19c4 <__divdf3>
    3a10:	872a                	mv	a4,a0
    3a12:	832e                	mv	t1,a1
    3a14:	b589                	j	3856 <__dtostr+0x1d4>
    3a16:	6795                	lui	a5,0x5
    3a18:	2287a703          	lw	a4,552(a5) # 5228 <pad_line+0x730>
    3a1c:	22c7a303          	lw	t1,556(a5)
    3a20:	b5b9                	j	386e <__dtostr+0x1ec>
    3a22:	4572                	lw	a0,28(sp)
    3a24:	5582                	lw	a1,32(sp)
    3a26:	863a                	mv	a2,a4
    3a28:	869a                	mv	a3,t1
    3a2a:	d23e                	sw	a5,36(sp)
    3a2c:	cc3a                	sw	a4,24(sp)
    3a2e:	c81a                	sw	t1,16(sp)
    3a30:	f95fd0ef          	jal	ra,19c4 <__divdf3>
    3a34:	97eff0ef          	jal	ra,2bb2 <__fixdfsi>
    3a38:	03050693          	addi	a3,a0,48
    3a3c:	00d400a3          	sb	a3,1(s0)
    3a40:	0ff57513          	zext.b	a0,a0
    3a44:	9d2ff0ef          	jal	ra,2c16 <__floatsidf>
    3a48:	4762                	lw	a4,24(sp)
    3a4a:	4342                	lw	t1,16(sp)
    3a4c:	0405                	addi	s0,s0,1
    3a4e:	863a                	mv	a2,a4
    3a50:	869a                	mv	a3,t1
    3a52:	ed6fe0ef          	jal	ra,2128 <__muldf3>
    3a56:	862a                	mv	a2,a0
    3a58:	86ae                	mv	a3,a1
    3a5a:	4572                	lw	a0,28(sp)
    3a5c:	5582                	lw	a1,32(sp)
    3a5e:	b49fe0ef          	jal	ra,25a6 <__subdf3>
    3a62:	4762                	lw	a4,24(sp)
    3a64:	4342                	lw	t1,16(sp)
    3a66:	4622                	lw	a2,8(sp)
    3a68:	46b2                	lw	a3,12(sp)
    3a6a:	ce2a                	sw	a0,28(sp)
    3a6c:	d02e                	sw	a1,32(sp)
    3a6e:	853a                	mv	a0,a4
    3a70:	859a                	mv	a1,t1
    3a72:	f53fd0ef          	jal	ra,19c4 <__divdf3>
    3a76:	5792                	lw	a5,36(sp)
    3a78:	872a                	mv	a4,a0
    3a7a:	832e                	mv	t1,a1
    3a7c:	bd99                	j	38d2 <__dtostr+0x250>
    3a7e:	4521                	li	a0,8
    3a80:	c60485e3          	beqz	s1,36ea <__dtostr+0x68>
    3a84:	4505                	li	a0,1
    3a86:	b195                	j	36ea <__dtostr+0x68>

00003a88 <__isinf>:
    3a88:	e509                	bnez	a0,3a92 <__isinf+0xa>
    3a8a:	7ff007b7          	lui	a5,0x7ff00
    3a8e:	00f58b63          	beq	a1,a5,3aa4 <__isinf+0x1c>
    3a92:	fff007b7          	lui	a5,0xfff00
    3a96:	8dbd                	xor	a1,a1,a5
    3a98:	8d4d                	or	a0,a0,a1
    3a9a:	00153513          	seqz	a0,a0
    3a9e:	40a00533          	neg	a0,a0
    3aa2:	8082                	ret
    3aa4:	4505                	li	a0,1
    3aa6:	8082                	ret

00003aa8 <__isnan>:
    3aa8:	fff807b7          	lui	a5,0xfff80
    3aac:	17fd                	addi	a5,a5,-1
    3aae:	8fed                	and	a5,a5,a1
    3ab0:	e509                	bnez	a0,3aba <__isnan+0x12>
    3ab2:	7ff00737          	lui	a4,0x7ff00
    3ab6:	00e78963          	beq	a5,a4,3ac8 <__isnan+0x20>
    3aba:	fff807b7          	lui	a5,0xfff80
    3abe:	8dbd                	xor	a1,a1,a5
    3ac0:	8d4d                	or	a0,a0,a1
    3ac2:	00153513          	seqz	a0,a0
    3ac6:	8082                	ret
    3ac8:	4505                	li	a0,1
    3aca:	8082                	ret

00003acc <__lltostr>:
    3acc:	fdc10113          	addi	sp,sp,-36
    3ad0:	15fd                	addi	a1,a1,-1
    3ad2:	d006                	sw	ra,32(sp)
    3ad4:	ce22                	sw	s0,28(sp)
    3ad6:	cc26                	sw	s1,24(sp)
    3ad8:	8336                	mv	t1,a3
    3ada:	86be                	mv	a3,a5
    3adc:	00b507b3          	add	a5,a0,a1
    3ae0:	00078023          	sb	zero,0(a5) # fff80000 <__bss_end__+0xdff7e050>
    3ae4:	83aa                	mv	t2,a0
    3ae6:	82b2                	mv	t0,a2
    3ae8:	c711                	beqz	a4,3af4 <__lltostr+0x28>
    3aea:	863a                	mv	a2,a4
    3aec:	02400713          	li	a4,36
    3af0:	00c75363          	bge	a4,a2,3af6 <__lltostr+0x2a>
    3af4:	4629                	li	a2,10
    3af6:	0062e733          	or	a4,t0,t1
    3afa:	4401                	li	s0,0
    3afc:	e719                	bnez	a4,3b0a <__lltostr+0x3e>
    3afe:	03000713          	li	a4,48
    3b02:	fee78fa3          	sb	a4,-1(a5)
    3b06:	4405                	li	s0,1
    3b08:	17fd                	addi	a5,a5,-1
    3b0a:	02700713          	li	a4,39
    3b0e:	c291                	beqz	a3,3b12 <__lltostr+0x46>
    3b10:	471d                	li	a4,7
    3b12:	c03a                	sw	a4,0(sp)
    3b14:	84be                	mv	s1,a5
    3b16:	943e                	add	s0,s0,a5
    3b18:	41f65693          	srai	a3,a2,0x1f
    3b1c:	40940733          	sub	a4,s0,s1
    3b20:	0093f563          	bgeu	t2,s1,3b2a <__lltostr+0x5e>
    3b24:	0062e5b3          	or	a1,t0,t1
    3b28:	e185                	bnez	a1,3b48 <__lltostr+0x7c>
    3b2a:	00170613          	addi	a2,a4,1 # 7ff00001 <__bss_end__+0x5fefe051>
    3b2e:	85a6                	mv	a1,s1
    3b30:	851e                	mv	a0,t2
    3b32:	c03a                	sw	a4,0(sp)
    3b34:	e73fc0ef          	jal	ra,9a6 <memmove>
    3b38:	4702                	lw	a4,0(sp)
    3b3a:	5082                	lw	ra,32(sp)
    3b3c:	4472                	lw	s0,28(sp)
    3b3e:	44e2                	lw	s1,24(sp)
    3b40:	853a                	mv	a0,a4
    3b42:	02410113          	addi	sp,sp,36
    3b46:	8082                	ret
    3b48:	8516                	mv	a0,t0
    3b4a:	859a                	mv	a1,t1
    3b4c:	ca1e                	sw	t2,20(sp)
    3b4e:	c832                	sw	a2,16(sp)
    3b50:	c636                	sw	a3,12(sp)
    3b52:	c416                	sw	t0,8(sp)
    3b54:	c21a                	sw	t1,4(sp)
    3b56:	d28fd0ef          	jal	ra,107e <__umoddi3>
    3b5a:	03050513          	addi	a0,a0,48
    3b5e:	0ff57513          	zext.b	a0,a0
    3b62:	03900793          	li	a5,57
    3b66:	4312                	lw	t1,4(sp)
    3b68:	42a2                	lw	t0,8(sp)
    3b6a:	46b2                	lw	a3,12(sp)
    3b6c:	4642                	lw	a2,16(sp)
    3b6e:	43d2                	lw	t2,20(sp)
    3b70:	14fd                	addi	s1,s1,-1
    3b72:	02a7e163          	bltu	a5,a0,3b94 <__lltostr+0xc8>
    3b76:	00a48023          	sb	a0,0(s1)
    3b7a:	859a                	mv	a1,t1
    3b7c:	8516                	mv	a0,t0
    3b7e:	c61e                	sw	t2,12(sp)
    3b80:	c432                	sw	a2,8(sp)
    3b82:	c236                	sw	a3,4(sp)
    3b84:	994fd0ef          	jal	ra,d18 <__udivdi3>
    3b88:	43b2                	lw	t2,12(sp)
    3b8a:	4622                	lw	a2,8(sp)
    3b8c:	4692                	lw	a3,4(sp)
    3b8e:	82aa                	mv	t0,a0
    3b90:	832e                	mv	t1,a1
    3b92:	b769                	j	3b1c <__lltostr+0x50>
    3b94:	4782                	lw	a5,0(sp)
    3b96:	953e                	add	a0,a0,a5
    3b98:	bff9                	j	3b76 <__lltostr+0xaa>

00003b9a <__ltostr>:
    3b9a:	1151                	addi	sp,sp,-12
    3b9c:	15fd                	addi	a1,a1,-1
    3b9e:	c406                	sw	ra,8(sp)
    3ba0:	c222                	sw	s0,4(sp)
    3ba2:	95aa                	add	a1,a1,a0
    3ba4:	00058023          	sb	zero,0(a1)
    3ba8:	fff68313          	addi	t1,a3,-1
    3bac:	02300793          	li	a5,35
    3bb0:	0067f363          	bgeu	a5,t1,3bb6 <__ltostr+0x1c>
    3bb4:	46a9                	li	a3,10
    3bb6:	4781                	li	a5,0
    3bb8:	e619                	bnez	a2,3bc6 <__ltostr+0x2c>
    3bba:	03000793          	li	a5,48
    3bbe:	fef58fa3          	sb	a5,-1(a1)
    3bc2:	15fd                	addi	a1,a1,-1
    3bc4:	4785                	li	a5,1
    3bc6:	02700313          	li	t1,39
    3bca:	c311                	beqz	a4,3bce <__ltostr+0x34>
    3bcc:	431d                	li	t1,7
    3bce:	0ff37713          	zext.b	a4,t1
    3bd2:	03900293          	li	t0,57
    3bd6:	00f58333          	add	t1,a1,a5
    3bda:	40b30433          	sub	s0,t1,a1
    3bde:	00b57363          	bgeu	a0,a1,3be4 <__ltostr+0x4a>
    3be2:	ea11                	bnez	a2,3bf6 <__ltostr+0x5c>
    3be4:	00140613          	addi	a2,s0,1
    3be8:	dbffc0ef          	jal	ra,9a6 <memmove>
    3bec:	40a2                	lw	ra,8(sp)
    3bee:	8522                	mv	a0,s0
    3bf0:	4412                	lw	s0,4(sp)
    3bf2:	0131                	addi	sp,sp,12
    3bf4:	8082                	ret
    3bf6:	02d677b3          	remu	a5,a2,a3
    3bfa:	15fd                	addi	a1,a1,-1
    3bfc:	03078793          	addi	a5,a5,48
    3c00:	0ff7f793          	zext.b	a5,a5
    3c04:	00f2e763          	bltu	t0,a5,3c12 <__ltostr+0x78>
    3c08:	02d65633          	divu	a2,a2,a3
    3c0c:	00f58023          	sb	a5,0(a1)
    3c10:	b7e9                	j	3bda <__ltostr+0x40>
    3c12:	97ba                	add	a5,a5,a4
    3c14:	bfd5                	j	3c08 <__ltostr+0x6e>

00003c16 <printf>:
    3c16:	fdc10113          	addi	sp,sp,-36
    3c1a:	c82e                	sw	a1,16(sp)
    3c1c:	080c                	addi	a1,sp,16
    3c1e:	c606                	sw	ra,12(sp)
    3c20:	ca32                	sw	a2,20(sp)
    3c22:	cc36                	sw	a3,24(sp)
    3c24:	ce3a                	sw	a4,28(sp)
    3c26:	d03e                	sw	a5,32(sp)
    3c28:	c02e                	sw	a1,0(sp)
    3c2a:	7c6000ef          	jal	ra,43f0 <vprintf>
    3c2e:	40b2                	lw	ra,12(sp)
    3c30:	02410113          	addi	sp,sp,36
    3c34:	8082                	ret

00003c36 <putc>:
    3c36:	880ff06f          	j	2cb6 <fputc>

00003c3a <putchar>:
    3c3a:	0001a783          	lw	a5,0(gp) # 200001e0 <_impure_ptr>
    3c3e:	1151                	addi	sp,sp,-12
    3c40:	c406                	sw	ra,8(sp)
    3c42:	478c                	lw	a1,8(a5)
    3c44:	3fcd                	jal	3c36 <putc>
    3c46:	40a2                	lw	ra,8(sp)
    3c48:	4501                	li	a0,0
    3c4a:	0131                	addi	sp,sp,12
    3c4c:	8082                	ret

00003c4e <puts>:
    3c4e:	1151                	addi	sp,sp,-12
    3c50:	c222                	sw	s0,4(sp)
    3c52:	c406                	sw	ra,8(sp)
    3c54:	842a                	mv	s0,a0
    3c56:	00044503          	lbu	a0,0(s0)
    3c5a:	55fd                	li	a1,-1
    3c5c:	e909                	bnez	a0,3c6e <puts+0x20>
    3c5e:	4529                	li	a0,10
    3c60:	856ff0ef          	jal	ra,2cb6 <fputc>
    3c64:	40a2                	lw	ra,8(sp)
    3c66:	4412                	lw	s0,4(sp)
    3c68:	4501                	li	a0,0
    3c6a:	0131                	addi	sp,sp,12
    3c6c:	8082                	ret
    3c6e:	848ff0ef          	jal	ra,2cb6 <fputc>
    3c72:	0405                	addi	s0,s0,1
    3c74:	b7cd                	j	3c56 <puts+0x8>

00003c76 <write_pad>:
    3c76:	1131                	addi	sp,sp,-20
    3c78:	fd060613          	addi	a2,a2,-48
    3c7c:	c622                	sw	s0,12(sp)
    3c7e:	00163613          	seqz	a2,a2
    3c82:	6415                	lui	s0,0x5
    3c84:	0612                	slli	a2,a2,0x4
    3c86:	af840413          	addi	s0,s0,-1288 # 4af8 <pad_line>
    3c8a:	c426                	sw	s1,8(sp)
    3c8c:	c806                	sw	ra,16(sp)
    3c8e:	84aa                	mv	s1,a0
    3c90:	87ae                	mv	a5,a1
    3c92:	9432                	add	s0,s0,a2
    3c94:	872e                	mv	a4,a1
    3c96:	46bd                	li	a3,15
    3c98:	40e78533          	sub	a0,a5,a4
    3c9c:	02e6c163          	blt	a3,a4,3cbe <write_pad+0x48>
    3ca0:	c03e                	sw	a5,0(sp)
    3ca2:	00e05963          	blez	a4,3cb4 <write_pad+0x3e>
    3ca6:	40d4                	lw	a3,4(s1)
    3ca8:	4090                	lw	a2,0(s1)
    3caa:	85ba                	mv	a1,a4
    3cac:	8522                	mv	a0,s0
    3cae:	9682                	jalr	a3
    3cb0:	4782                	lw	a5,0(sp)
    3cb2:	853e                	mv	a0,a5
    3cb4:	40c2                	lw	ra,16(sp)
    3cb6:	4432                	lw	s0,12(sp)
    3cb8:	44a2                	lw	s1,8(sp)
    3cba:	0151                	addi	sp,sp,20
    3cbc:	8082                	ret
    3cbe:	40d4                	lw	a3,4(s1)
    3cc0:	4090                	lw	a2,0(s1)
    3cc2:	45c1                	li	a1,16
    3cc4:	8522                	mv	a0,s0
    3cc6:	c23e                	sw	a5,4(sp)
    3cc8:	c03a                	sw	a4,0(sp)
    3cca:	9682                	jalr	a3
    3ccc:	4702                	lw	a4,0(sp)
    3cce:	4792                	lw	a5,4(sp)
    3cd0:	1741                	addi	a4,a4,-16
    3cd2:	b7d1                	j	3c96 <write_pad+0x20>

00003cd4 <__v_printf>:
    3cd4:	f2c10113          	addi	sp,sp,-212
    3cd8:	c7a2                	sw	s0,204(sp)
    3cda:	c5a6                	sw	s1,200(sp)
    3cdc:	c986                	sw	ra,208(sp)
    3cde:	84aa                	mv	s1,a0
    3ce0:	c82e                	sw	a1,16(sp)
    3ce2:	8432                	mv	s0,a2
    3ce4:	cbdfc0ef          	jal	ra,9a0 <__errno>
    3ce8:	411c                	lw	a5,0(a0)
    3cea:	c202                	sw	zero,4(sp)
    3cec:	d83e                	sw	a5,48(sp)
    3cee:	47c2                	lw	a5,16(sp)
    3cf0:	0007c783          	lbu	a5,0(a5)
    3cf4:	5c078b63          	beqz	a5,42ca <__v_printf+0x5f6>
    3cf8:	4581                	li	a1,0
    3cfa:	02500693          	li	a3,37
    3cfe:	a011                	j	3d02 <__v_printf+0x2e>
    3d00:	0585                	addi	a1,a1,1
    3d02:	47c2                	lw	a5,16(sp)
    3d04:	97ae                	add	a5,a5,a1
    3d06:	0007c703          	lbu	a4,0(a5)
    3d0a:	6a070363          	beqz	a4,43b0 <__v_printf+0x6dc>
    3d0e:	fed719e3          	bne	a4,a3,3d00 <__v_printf+0x2c>
    3d12:	edb1                	bnez	a1,3d6e <__v_printf+0x9a>
    3d14:	47c2                	lw	a5,16(sp)
    3d16:	02000713          	li	a4,32
    3d1a:	00178513          	addi	a0,a5,1
    3d1e:	c002                	sw	zero,0(sp)
    3d20:	c602                	sw	zero,12(sp)
    3d22:	4781                	li	a5,0
    3d24:	ca02                	sw	zero,20(sp)
    3d26:	cc02                	sw	zero,24(sp)
    3d28:	d602                	sw	zero,44(sp)
    3d2a:	d002                	sw	zero,32(sp)
    3d2c:	c402                	sw	zero,8(sp)
    3d2e:	ce3a                	sw	a4,28(sp)
    3d30:	00054303          	lbu	t1,0(a0)
    3d34:	00150713          	addi	a4,a0,1
    3d38:	c83a                	sw	a4,16(sp)
    3d3a:	046101a3          	sb	t1,67(sp)
    3d3e:	07a00713          	li	a4,122
    3d42:	fa6766e3          	bltu	a4,t1,3cee <__v_printf+0x1a>
    3d46:	04b00713          	li	a4,75
    3d4a:	04676a63          	bltu	a4,t1,3d9e <__v_printf+0xca>
    3d4e:	56030c63          	beqz	t1,42c6 <__v_printf+0x5f2>
    3d52:	1301                	addi	t1,t1,-32
    3d54:	0ff37313          	zext.b	t1,t1
    3d58:	4765                	li	a4,25
    3d5a:	f8676ae3          	bltu	a4,t1,3cee <__v_printf+0x1a>
    3d5e:	6715                	lui	a4,0x5
    3d60:	9d470713          	addi	a4,a4,-1580 # 49d4 <sg_uart_config+0xac>
    3d64:	030a                	slli	t1,t1,0x2
    3d66:	933a                	add	t1,t1,a4
    3d68:	00032703          	lw	a4,0(t1) # 80000000 <__bss_end__+0x5fffe050>
    3d6c:	8702                	jr	a4
    3d6e:	40d8                	lw	a4,4(s1)
    3d70:	4090                	lw	a2,0(s1)
    3d72:	4542                	lw	a0,16(sp)
    3d74:	c43e                	sw	a5,8(sp)
    3d76:	c02e                	sw	a1,0(sp)
    3d78:	9702                	jalr	a4
    3d7a:	4792                	lw	a5,4(sp)
    3d7c:	4582                	lw	a1,0(sp)
    3d7e:	02500713          	li	a4,37
    3d82:	97ae                	add	a5,a5,a1
    3d84:	c23e                	sw	a5,4(sp)
    3d86:	47a2                	lw	a5,8(sp)
    3d88:	0007c683          	lbu	a3,0(a5)
    3d8c:	f8e685e3          	beq	a3,a4,3d16 <__v_printf+0x42>
    3d90:	c83e                	sw	a5,16(sp)
    3d92:	bfb1                	j	3cee <__v_printf+0x1a>
    3d94:	0ff00713          	li	a4,255
    3d98:	c43a                	sw	a4,8(sp)
    3d9a:	4542                	lw	a0,16(sp)
    3d9c:	bf51                	j	3d30 <__v_printf+0x5c>
    3d9e:	fb430713          	addi	a4,t1,-76
    3da2:	0ff77713          	zext.b	a4,a4
    3da6:	02e00693          	li	a3,46
    3daa:	f4e6e2e3          	bltu	a3,a4,3cee <__v_printf+0x1a>
    3dae:	6695                	lui	a3,0x5
    3db0:	070a                	slli	a4,a4,0x2
    3db2:	a3c68693          	addi	a3,a3,-1476 # 4a3c <sg_uart_config+0x114>
    3db6:	9736                	add	a4,a4,a3
    3db8:	4318                	lw	a4,0(a4)
    3dba:	8702                	jr	a4
    3dbc:	4589                	li	a1,2
    3dbe:	4701                	li	a4,0
    3dc0:	4281                	li	t0,0
    3dc2:	ae01                	j	40d2 <__v_printf+0x3fe>
    3dc4:	4705                	li	a4,1
    3dc6:	d03a                	sw	a4,32(sp)
    3dc8:	bfc9                	j	3d9a <__v_printf+0xc6>
    3dca:	17fd                	addi	a5,a5,-1
    3dcc:	07e2                	slli	a5,a5,0x18
    3dce:	87e1                	srai	a5,a5,0x18
    3dd0:	b7e9                	j	3d9a <__v_printf+0xc6>
    3dd2:	0785                	addi	a5,a5,1
    3dd4:	07e2                	slli	a5,a5,0x18
    3dd6:	87e1                	srai	a5,a5,0x18
    3dd8:	0785                	addi	a5,a5,1
    3dda:	bfcd                	j	3dcc <__v_printf+0xf8>
    3ddc:	4705                	li	a4,1
    3dde:	d63a                	sw	a4,44(sp)
    3de0:	bf6d                	j	3d9a <__v_printf+0xc6>
    3de2:	4705                	li	a4,1
    3de4:	cc3a                	sw	a4,24(sp)
    3de6:	bf55                	j	3d9a <__v_printf+0xc6>
    3de8:	c83e                	sw	a5,16(sp)
    3dea:	47d2                	lw	a5,20(sp)
    3dec:	4c079d63          	bnez	a5,42c6 <__v_printf+0x5f2>
    3df0:	4629                	li	a2,10
    3df2:	00cc                	addi	a1,sp,68
    3df4:	fcefc0ef          	jal	ra,5c2 <strtoul>
    3df8:	04314683          	lbu	a3,67(sp)
    3dfc:	c62a                	sw	a0,12(sp)
    3dfe:	03000713          	li	a4,48
    3e02:	47c2                	lw	a5,16(sp)
    3e04:	00e69763          	bne	a3,a4,3e12 <__v_printf+0x13e>
    3e08:	5702                	lw	a4,32(sp)
    3e0a:	e701                	bnez	a4,3e12 <__v_printf+0x13e>
    3e0c:	03000713          	li	a4,48
    3e10:	ce3a                	sw	a4,28(sp)
    3e12:	4716                	lw	a4,68(sp)
    3e14:	c83a                	sw	a4,16(sp)
    3e16:	b751                	j	3d9a <__v_printf+0xc6>
    3e18:	4018                	lw	a4,0(s0)
    3e1a:	0411                	addi	s0,s0,4
    3e1c:	c63a                	sw	a4,12(sp)
    3e1e:	bfb5                	j	3d9a <__v_printf+0xc6>
    3e20:	00154683          	lbu	a3,1(a0)
    3e24:	02a00713          	li	a4,42
    3e28:	02e69063          	bne	a3,a4,3e48 <__v_printf+0x174>
    3e2c:	4014                	lw	a3,0(s0)
    3e2e:	00440713          	addi	a4,s0,4
    3e32:	c036                	sw	a3,0(sp)
    3e34:	0006d363          	bgez	a3,3e3a <__v_printf+0x166>
    3e38:	c002                	sw	zero,0(sp)
    3e3a:	00250693          	addi	a3,a0,2
    3e3e:	c836                	sw	a3,16(sp)
    3e40:	843a                	mv	s0,a4
    3e42:	4705                	li	a4,1
    3e44:	ca3a                	sw	a4,20(sp)
    3e46:	bf91                	j	3d9a <__v_printf+0xc6>
    3e48:	4542                	lw	a0,16(sp)
    3e4a:	4629                	li	a2,10
    3e4c:	00cc                	addi	a1,sp,68
    3e4e:	ca3e                	sw	a5,20(sp)
    3e50:	dbcfc0ef          	jal	ra,40c <strtol>
    3e54:	c02a                	sw	a0,0(sp)
    3e56:	47d2                	lw	a5,20(sp)
    3e58:	00055363          	bgez	a0,3e5e <__v_printf+0x18a>
    3e5c:	c002                	sw	zero,0(sp)
    3e5e:	4716                	lw	a4,68(sp)
    3e60:	c83a                	sw	a4,16(sp)
    3e62:	b7c5                	j	3e42 <__v_printf+0x16e>
    3e64:	401c                	lw	a5,0(s0)
    3e66:	0411                	addi	s0,s0,4
    3e68:	04f101a3          	sb	a5,67(sp)
    3e6c:	40dc                	lw	a5,4(s1)
    3e6e:	4090                	lw	a2,0(s1)
    3e70:	4585                	li	a1,1
    3e72:	04310513          	addi	a0,sp,67
    3e76:	9782                	jalr	a5
    3e78:	4792                	lw	a5,4(sp)
    3e7a:	0785                	addi	a5,a5,1
    3e7c:	c23e                	sw	a5,4(sp)
    3e7e:	bd85                	j	3cee <__v_printf+0x1a>
    3e80:	5542                	lw	a0,48(sp)
    3e82:	b03fc0ef          	jal	ra,984 <strerror>
    3e86:	c2aa                	sw	a0,68(sp)
    3e88:	c42a                	sw	a0,8(sp)
    3e8a:	db5fc0ef          	jal	ra,c3e <strlen>
    3e8e:	47a2                	lw	a5,8(sp)
    3e90:	40d8                	lw	a4,4(s1)
    3e92:	4090                	lw	a2,0(s1)
    3e94:	85aa                	mv	a1,a0
    3e96:	c02a                	sw	a0,0(sp)
    3e98:	853e                	mv	a0,a5
    3e9a:	9702                	jalr	a4
    3e9c:	4792                	lw	a5,4(sp)
    3e9e:	4582                	lw	a1,0(sp)
    3ea0:	97ae                	add	a5,a5,a1
    3ea2:	bfe9                	j	3e7c <__v_printf+0x1a8>
    3ea4:	401c                	lw	a5,0(s0)
    3ea6:	00440713          	addi	a4,s0,4
    3eaa:	c7a1                	beqz	a5,3ef2 <__v_printf+0x21e>
    3eac:	c2be                	sw	a5,68(sp)
    3eae:	4516                	lw	a0,68(sp)
    3eb0:	cc3a                	sw	a4,24(sp)
    3eb2:	d8dfc0ef          	jal	ra,c3e <strlen>
    3eb6:	47d2                	lw	a5,20(sp)
    3eb8:	4762                	lw	a4,24(sp)
    3eba:	832a                	mv	t1,a0
    3ebc:	cf9d                	beqz	a5,3efa <__v_printf+0x226>
    3ebe:	4782                	lw	a5,0(sp)
    3ec0:	00a7f363          	bgeu	a5,a0,3ec6 <__v_printf+0x1f2>
    3ec4:	833e                	mv	t1,a5
    3ec6:	843a                	mv	s0,a4
    3ec8:	c002                	sw	zero,0(sp)
    3eca:	ca02                	sw	zero,20(sp)
    3ecc:	4281                	li	t0,0
    3ece:	02000793          	li	a5,32
    3ed2:	ce3e                	sw	a5,28(sp)
    3ed4:	47b2                	lw	a5,12(sp)
    3ed6:	4702                	lw	a4,0(sp)
    3ed8:	4696                	lw	a3,68(sp)
    3eda:	8fd9                	or	a5,a5,a4
    3edc:	e39d                	bnez	a5,3f02 <__v_printf+0x22e>
    3ede:	40dc                	lw	a5,4(s1)
    3ee0:	4090                	lw	a2,0(s1)
    3ee2:	859a                	mv	a1,t1
    3ee4:	8536                	mv	a0,a3
    3ee6:	c01a                	sw	t1,0(sp)
    3ee8:	9782                	jalr	a5
    3eea:	4792                	lw	a5,4(sp)
    3eec:	4302                	lw	t1,0(sp)
    3eee:	979a                	add	a5,a5,t1
    3ef0:	b771                	j	3e7c <__v_printf+0x1a8>
    3ef2:	6795                	lui	a5,0x5
    3ef4:	9cc78793          	addi	a5,a5,-1588 # 49cc <sg_uart_config+0xa4>
    3ef8:	bf55                	j	3eac <__v_printf+0x1d8>
    3efa:	843a                	mv	s0,a4
    3efc:	4281                	li	t0,0
    3efe:	c002                	sw	zero,0(sp)
    3f00:	b7f9                	j	3ece <__v_printf+0x1fa>
    3f02:	3c029b63          	bnez	t0,42d8 <__v_printf+0x604>
    3f06:	47a2                	lw	a5,8(sp)
    3f08:	3c078d63          	beqz	a5,42e2 <__v_printf+0x60e>
    3f0c:	47a2                	lw	a5,8(sp)
    3f0e:	00f68733          	add	a4,a3,a5
    3f12:	c2ba                	sw	a4,68(sp)
    3f14:	4732                	lw	a4,12(sp)
    3f16:	40f30333          	sub	t1,t1,a5
    3f1a:	8f1d                	sub	a4,a4,a5
    3f1c:	c63a                	sw	a4,12(sp)
    3f1e:	5702                	lw	a4,32(sp)
    3f20:	3c070563          	beqz	a4,42ea <__v_printf+0x616>
    3f24:	40d8                	lw	a4,4(s1)
    3f26:	4090                	lw	a2,0(s1)
    3f28:	85be                	mv	a1,a5
    3f2a:	8536                	mv	a0,a3
    3f2c:	ca1a                	sw	t1,20(sp)
    3f2e:	c43e                	sw	a5,8(sp)
    3f30:	9702                	jalr	a4
    3f32:	4712                	lw	a4,4(sp)
    3f34:	47a2                	lw	a5,8(sp)
    3f36:	4352                	lw	t1,20(sp)
    3f38:	97ba                	add	a5,a5,a4
    3f3a:	c23e                	sw	a5,4(sp)
    3f3c:	4782                	lw	a5,0(sp)
    3f3e:	03000613          	li	a2,48
    3f42:	8526                	mv	a0,s1
    3f44:	406785b3          	sub	a1,a5,t1
    3f48:	ca1a                	sw	t1,20(sp)
    3f4a:	3335                	jal	3c76 <write_pad>
    3f4c:	4792                	lw	a5,4(sp)
    3f4e:	4352                	lw	t1,20(sp)
    3f50:	40d8                	lw	a4,4(s1)
    3f52:	97aa                	add	a5,a5,a0
    3f54:	4090                	lw	a2,0(s1)
    3f56:	4516                	lw	a0,68(sp)
    3f58:	859a                	mv	a1,t1
    3f5a:	c43e                	sw	a5,8(sp)
    3f5c:	c21a                	sw	t1,4(sp)
    3f5e:	9702                	jalr	a4
    3f60:	4312                	lw	t1,4(sp)
    3f62:	47a2                	lw	a5,8(sp)
    3f64:	4582                	lw	a1,0(sp)
    3f66:	979a                	add	a5,a5,t1
    3f68:	0065f363          	bgeu	a1,t1,3f6e <__v_printf+0x29a>
    3f6c:	859a                	mv	a1,t1
    3f6e:	c03e                	sw	a5,0(sp)
    3f70:	47b2                	lw	a5,12(sp)
    3f72:	02000613          	li	a2,32
    3f76:	8526                	mv	a0,s1
    3f78:	40b785b3          	sub	a1,a5,a1
    3f7c:	cfbff0ef          	jal	ra,3c76 <write_pad>
    3f80:	4782                	lw	a5,0(sp)
    3f82:	97aa                	add	a5,a5,a0
    3f84:	bde5                	j	3e7c <__v_printf+0x1a8>
    3f86:	c78d                	beqz	a5,3fb0 <__v_printf+0x2dc>
    3f88:	4672                	lw	a2,28(sp)
    3f8a:	03000713          	li	a4,48
    3f8e:	02e61163          	bne	a2,a4,3fb0 <__v_printf+0x2dc>
    3f92:	40d8                	lw	a4,4(s1)
    3f94:	4090                	lw	a2,0(s1)
    3f96:	85be                	mv	a1,a5
    3f98:	8536                	mv	a0,a3
    3f9a:	ca1a                	sw	t1,20(sp)
    3f9c:	c43e                	sw	a5,8(sp)
    3f9e:	c036                	sw	a3,0(sp)
    3fa0:	9702                	jalr	a4
    3fa2:	4712                	lw	a4,4(sp)
    3fa4:	47a2                	lw	a5,8(sp)
    3fa6:	4352                	lw	t1,20(sp)
    3fa8:	4682                	lw	a3,0(sp)
    3faa:	97ba                	add	a5,a5,a4
    3fac:	c23e                	sw	a5,4(sp)
    3fae:	4781                	li	a5,0
    3fb0:	c43e                	sw	a5,8(sp)
    3fb2:	47b2                	lw	a5,12(sp)
    3fb4:	4672                	lw	a2,28(sp)
    3fb6:	8526                	mv	a0,s1
    3fb8:	406785b3          	sub	a1,a5,t1
    3fbc:	c01a                	sw	t1,0(sp)
    3fbe:	ca36                	sw	a3,20(sp)
    3fc0:	cb7ff0ef          	jal	ra,3c76 <write_pad>
    3fc4:	4792                	lw	a5,4(sp)
    3fc6:	4302                	lw	t1,0(sp)
    3fc8:	00a78733          	add	a4,a5,a0
    3fcc:	47a2                	lw	a5,8(sp)
    3fce:	38078163          	beqz	a5,4350 <__v_printf+0x67c>
    3fd2:	46d2                	lw	a3,20(sp)
    3fd4:	0044a383          	lw	t2,4(s1)
    3fd8:	4090                	lw	a2,0(s1)
    3fda:	85be                	mv	a1,a5
    3fdc:	8536                	mv	a0,a3
    3fde:	c41a                	sw	t1,8(sp)
    3fe0:	c23a                	sw	a4,4(sp)
    3fe2:	c03e                	sw	a5,0(sp)
    3fe4:	9382                	jalr	t2
    3fe6:	4782                	lw	a5,0(sp)
    3fe8:	4712                	lw	a4,4(sp)
    3fea:	4322                	lw	t1,8(sp)
    3fec:	973e                	add	a4,a4,a5
    3fee:	a68d                	j	4350 <__v_printf+0x67c>
    3ff0:	07800793          	li	a5,120
    3ff4:	4709                	li	a4,2
    3ff6:	04f101a3          	sb	a5,67(sp)
    3ffa:	c43a                	sw	a4,8(sp)
    3ffc:	4785                	li	a5,1
    3ffe:	04314703          	lbu	a4,67(sp)
    4002:	fa870713          	addi	a4,a4,-88
    4006:	00173713          	seqz	a4,a4
    400a:	46a2                	lw	a3,8(sp)
    400c:	4301                	li	t1,0
    400e:	ce81                	beqz	a3,4026 <__v_printf+0x352>
    4010:	03000693          	li	a3,48
    4014:	04d104a3          	sb	a3,73(sp)
    4018:	04314683          	lbu	a3,67(sp)
    401c:	4309                	li	t1,2
    401e:	04d10523          	sb	a3,74(sp)
    4022:	4689                	li	a3,2
    4024:	c436                	sw	a3,8(sp)
    4026:	46b2                	lw	a3,12(sp)
    4028:	4602                	lw	a2,0(sp)
    402a:	00c6f363          	bgeu	a3,a2,4030 <__v_printf+0x35c>
    402e:	c632                	sw	a2,12(sp)
    4030:	45c1                	li	a1,16
    4032:	4281                	li	t0,0
    4034:	04910693          	addi	a3,sp,73
    4038:	c2b6                	sw	a3,68(sp)
    403a:	0ef05c63          	blez	a5,4132 <__v_printf+0x45e>
    403e:	4685                	li	a3,1
    4040:	0ad78e63          	beq	a5,a3,40fc <__v_printf+0x428>
    4044:	4008                	lw	a0,0(s0)
    4046:	4054                	lw	a3,4(s0)
    4048:	00840393          	addi	t2,s0,8
    404c:	4601                	li	a2,0
    404e:	0a028e63          	beqz	t0,410a <__v_printf+0x436>
    4052:	0006da63          	bgez	a3,4066 <__v_printf+0x392>
    4056:	00a037b3          	snez	a5,a0
    405a:	40d006b3          	neg	a3,a3
    405e:	8e9d                	sub	a3,a3,a5
    4060:	40a00533          	neg	a0,a0
    4064:	4289                	li	t0,2
    4066:	862a                	mv	a2,a0
    4068:	04910513          	addi	a0,sp,73
    406c:	87ba                	mv	a5,a4
    406e:	951a                	add	a0,a0,t1
    4070:	872e                	mv	a4,a1
    4072:	07b00593          	li	a1,123
    4076:	da16                	sw	t0,52(sp)
    4078:	d41e                	sw	t2,40(sp)
    407a:	d21a                	sw	t1,36(sp)
    407c:	a51ff0ef          	jal	ra,3acc <__lltostr>
    4080:	53a2                	lw	t2,40(sp)
    4082:	5312                	lw	t1,36(sp)
    4084:	52d2                	lw	t0,52(sp)
    4086:	841e                	mv	s0,t2
    4088:	4752                	lw	a4,20(sp)
    408a:	4796                	lw	a5,68(sp)
    408c:	cb69                	beqz	a4,415e <__v_printf+0x48a>
    408e:	4705                	li	a4,1
    4090:	0ce51763          	bne	a0,a4,415e <__v_printf+0x48a>
    4094:	00678733          	add	a4,a5,t1
    4098:	00074683          	lbu	a3,0(a4)
    409c:	03000713          	li	a4,48
    40a0:	0ae69f63          	bne	a3,a4,415e <__v_printf+0x48a>
    40a4:	4702                	lw	a4,0(sp)
    40a6:	cf55                	beqz	a4,4162 <__v_printf+0x48e>
    40a8:	4722                	lw	a4,8(sp)
    40aa:	c319                	beqz	a4,40b0 <__v_printf+0x3dc>
    40ac:	c402                	sw	zero,8(sp)
    40ae:	4301                	li	t1,0
    40b0:	4709                	li	a4,2
    40b2:	0ae29b63          	bne	t0,a4,4168 <__v_printf+0x494>
    40b6:	fff78713          	addi	a4,a5,-1
    40ba:	c2ba                	sw	a4,68(sp)
    40bc:	02d00713          	li	a4,45
    40c0:	fee78fa3          	sb	a4,-1(a5)
    40c4:	0305                	addi	t1,t1,1
    40c6:	b539                	j	3ed4 <__v_printf+0x200>
    40c8:	4701                	li	a4,0
    40ca:	b781                	j	400a <__v_printf+0x336>
    40cc:	45a9                	li	a1,10
    40ce:	4701                	li	a4,0
    40d0:	4285                	li	t0,1
    40d2:	4301                	li	t1,0
    40d4:	b785                	j	4034 <__v_printf+0x360>
    40d6:	4722                	lw	a4,8(sp)
    40d8:	cf11                	beqz	a4,40f4 <__v_printf+0x420>
    40da:	03000713          	li	a4,48
    40de:	04e104a3          	sb	a4,73(sp)
    40e2:	4705                	li	a4,1
    40e4:	c43a                	sw	a4,8(sp)
    40e6:	45a1                	li	a1,8
    40e8:	4701                	li	a4,0
    40ea:	4281                	li	t0,0
    40ec:	4305                	li	t1,1
    40ee:	b799                	j	4034 <__v_printf+0x360>
    40f0:	45a9                	li	a1,10
    40f2:	b1f1                	j	3dbe <__v_printf+0xea>
    40f4:	4701                	li	a4,0
    40f6:	4281                	li	t0,0
    40f8:	45a1                	li	a1,8
    40fa:	bfe1                	j	40d2 <__v_printf+0x3fe>
    40fc:	4010                	lw	a2,0(s0)
    40fe:	00440393          	addi	t2,s0,4
    4102:	02029d63          	bnez	t0,413c <__v_printf+0x468>
    4106:	4501                	li	a0,0
    4108:	4681                	li	a3,0
    410a:	4405                	li	s0,1
    410c:	f4f44de3          	blt	s0,a5,4066 <__v_printf+0x392>
    4110:	04910793          	addi	a5,sp,73
    4114:	86ae                	mv	a3,a1
    4116:	00678533          	add	a0,a5,t1
    411a:	07b00593          	li	a1,123
    411e:	da16                	sw	t0,52(sp)
    4120:	d41e                	sw	t2,40(sp)
    4122:	d21a                	sw	t1,36(sp)
    4124:	a77ff0ef          	jal	ra,3b9a <__ltostr>
    4128:	53a2                	lw	t2,40(sp)
    412a:	52d2                	lw	t0,52(sp)
    412c:	5312                	lw	t1,36(sp)
    412e:	841e                	mv	s0,t2
    4130:	bfa1                	j	4088 <__v_printf+0x3b4>
    4132:	4010                	lw	a2,0(s0)
    4134:	00440393          	addi	t2,s0,4
    4138:	00028863          	beqz	t0,4148 <__v_printf+0x474>
    413c:	4285                	li	t0,1
    413e:	00065563          	bgez	a2,4148 <__v_printf+0x474>
    4142:	40c00633          	neg	a2,a2
    4146:	4289                	li	t0,2
    4148:	fa07dfe3          	bgez	a5,4106 <__v_printf+0x432>
    414c:	56fd                	li	a3,-1
    414e:	00d79563          	bne	a5,a3,4158 <__v_printf+0x484>
    4152:	0642                	slli	a2,a2,0x10
    4154:	8241                	srli	a2,a2,0x10
    4156:	bf6d                	j	4110 <__v_printf+0x43c>
    4158:	0ff67613          	zext.b	a2,a2
    415c:	bf55                	j	4110 <__v_printf+0x43c>
    415e:	932a                	add	t1,t1,a0
    4160:	bf81                	j	40b0 <__v_printf+0x3dc>
    4162:	4301                	li	t1,0
    4164:	c402                	sw	zero,8(sp)
    4166:	b7a9                	j	40b0 <__v_printf+0x3dc>
    4168:	d60286e3          	beqz	t0,3ed4 <__v_printf+0x200>
    416c:	4762                	lw	a4,24(sp)
    416e:	ef19                	bnez	a4,418c <__v_printf+0x4b8>
    4170:	5732                	lw	a4,44(sp)
    4172:	4281                	li	t0,0
    4174:	d60700e3          	beqz	a4,3ed4 <__v_printf+0x200>
    4178:	02000713          	li	a4,32
    417c:	fff78693          	addi	a3,a5,-1
    4180:	c2b6                	sw	a3,68(sp)
    4182:	fee78fa3          	sb	a4,-1(a5)
    4186:	0305                	addi	t1,t1,1
    4188:	4285                	li	t0,1
    418a:	b3a9                	j	3ed4 <__v_printf+0x200>
    418c:	02b00713          	li	a4,43
    4190:	b7f5                	j	417c <__v_printf+0x4a8>
    4192:	00840793          	addi	a5,s0,8
    4196:	da3e                	sw	a5,52(sp)
    4198:	401c                	lw	a5,0(s0)
    419a:	d23e                	sw	a5,36(sp)
    419c:	405c                	lw	a5,4(s0)
    419e:	d43e                	sw	a5,40(sp)
    41a0:	04910793          	addi	a5,sp,73
    41a4:	c2be                	sw	a5,68(sp)
    41a6:	47b2                	lw	a5,12(sp)
    41a8:	e399                	bnez	a5,41ae <__v_printf+0x4da>
    41aa:	4785                	li	a5,1
    41ac:	c63e                	sw	a5,12(sp)
    41ae:	47d2                	lw	a5,20(sp)
    41b0:	e399                	bnez	a5,41b6 <__v_printf+0x4e2>
    41b2:	4799                	li	a5,6
    41b4:	c03e                	sw	a5,0(sp)
    41b6:	42e2                	lw	t0,24(sp)
    41b8:	00029e63          	bnez	t0,41d4 <__v_printf+0x500>
    41bc:	5712                	lw	a4,36(sp)
    41be:	57a2                	lw	a5,40(sp)
    41c0:	4601                	li	a2,0
    41c2:	4681                	li	a3,0
    41c4:	853a                	mv	a0,a4
    41c6:	85be                	mv	a1,a5
    41c8:	dc1a                	sw	t1,56(sp)
    41ca:	eb1fd0ef          	jal	ra,207a <__ledf2>
    41ce:	5362                	lw	t1,56(sp)
    41d0:	01f55293          	srli	t0,a0,0x1f
    41d4:	5412                	lw	s0,36(sp)
    41d6:	53a2                	lw	t2,40(sp)
    41d8:	4782                	lw	a5,0(sp)
    41da:	4732                	lw	a4,12(sp)
    41dc:	8522                	mv	a0,s0
    41de:	07f00693          	li	a3,127
    41e2:	04910613          	addi	a2,sp,73
    41e6:	859e                	mv	a1,t2
    41e8:	de16                	sw	t0,60(sp)
    41ea:	dc1a                	sw	t1,56(sp)
    41ec:	c96ff0ef          	jal	ra,3682 <__dtostr>
    41f0:	47d2                	lw	a5,20(sp)
    41f2:	5362                	lw	t1,56(sp)
    41f4:	52f2                	lw	t0,60(sp)
    41f6:	842a                	mv	s0,a0
    41f8:	cb8d                	beqz	a5,422a <__v_printf+0x556>
    41fa:	4796                	lw	a5,68(sp)
    41fc:	02e00593          	li	a1,46
    4200:	853e                	mv	a0,a5
    4202:	ca3e                	sw	a5,20(sp)
    4204:	bccfc0ef          	jal	ra,5d0 <strchr>
    4208:	47d2                	lw	a5,20(sp)
    420a:	5362                	lw	t1,56(sp)
    420c:	52f2                	lw	t0,60(sp)
    420e:	cd51                	beqz	a0,42aa <__v_printf+0x5d6>
    4210:	4782                	lw	a5,0(sp)
    4212:	e399                	bnez	a5,4218 <__v_printf+0x544>
    4214:	47a2                	lw	a5,8(sp)
    4216:	cb81                	beqz	a5,4226 <__v_printf+0x552>
    4218:	0505                	addi	a0,a0,1
    421a:	4782                	lw	a5,0(sp)
    421c:	c789                	beqz	a5,4226 <__v_printf+0x552>
    421e:	00154783          	lbu	a5,1(a0)
    4222:	0505                	addi	a0,a0,1
    4224:	efbd                	bnez	a5,42a2 <__v_printf+0x5ce>
    4226:	00050023          	sb	zero,0(a0)
    422a:	06700793          	li	a5,103
    422e:	04f31b63          	bne	t1,a5,4284 <__v_printf+0x5b0>
    4232:	4516                	lw	a0,68(sp)
    4234:	02e00593          	li	a1,46
    4238:	c416                	sw	t0,8(sp)
    423a:	b96fc0ef          	jal	ra,5d0 <strchr>
    423e:	42a2                	lw	t0,8(sp)
    4240:	842a                	mv	s0,a0
    4242:	c129                	beqz	a0,4284 <__v_printf+0x5b0>
    4244:	06500593          	li	a1,101
    4248:	b88fc0ef          	jal	ra,5d0 <strchr>
    424c:	42a2                	lw	t0,8(sp)
    424e:	85aa                	mv	a1,a0
    4250:	00044783          	lbu	a5,0(s0)
    4254:	e7bd                	bnez	a5,42c2 <__v_printf+0x5ee>
    4256:	c191                	beqz	a1,425a <__v_printf+0x586>
    4258:	842e                	mv	s0,a1
    425a:	03000693          	li	a3,48
    425e:	8722                	mv	a4,s0
    4260:	fff44783          	lbu	a5,-1(s0)
    4264:	147d                	addi	s0,s0,-1
    4266:	fed78ce3          	beq	a5,a3,425e <__v_printf+0x58a>
    426a:	02e00693          	li	a3,46
    426e:	00d78363          	beq	a5,a3,4274 <__v_printf+0x5a0>
    4272:	843a                	mv	s0,a4
    4274:	00040023          	sb	zero,0(s0)
    4278:	c591                	beqz	a1,4284 <__v_printf+0x5b0>
    427a:	8522                	mv	a0,s0
    427c:	c416                	sw	t0,8(sp)
    427e:	a23fc0ef          	jal	ra,ca0 <strcpy>
    4282:	42a2                	lw	t0,8(sp)
    4284:	47e2                	lw	a5,24(sp)
    4286:	e3ed                	bnez	a5,4368 <__v_printf+0x694>
    4288:	57b2                	lw	a5,44(sp)
    428a:	10079463          	bnez	a5,4392 <__v_printf+0x6be>
    428e:	4516                	lw	a0,68(sp)
    4290:	cc16                	sw	t0,24(sp)
    4292:	9adfc0ef          	jal	ra,c3e <strlen>
    4296:	42e2                	lw	t0,24(sp)
    4298:	5452                	lw	s0,52(sp)
    429a:	832a                	mv	t1,a0
    429c:	ca02                	sw	zero,20(sp)
    429e:	c402                	sw	zero,8(sp)
    42a0:	b915                	j	3ed4 <__v_printf+0x200>
    42a2:	4782                	lw	a5,0(sp)
    42a4:	17fd                	addi	a5,a5,-1
    42a6:	c03e                	sw	a5,0(sp)
    42a8:	bf8d                	j	421a <__v_printf+0x546>
    42aa:	4722                	lw	a4,8(sp)
    42ac:	df3d                	beqz	a4,422a <__v_printf+0x556>
    42ae:	97a2                	add	a5,a5,s0
    42b0:	02e00713          	li	a4,46
    42b4:	00e78023          	sb	a4,0(a5)
    42b8:	4516                	lw	a0,68(sp)
    42ba:	942a                	add	s0,s0,a0
    42bc:	000400a3          	sb	zero,1(s0)
    42c0:	b7ad                	j	422a <__v_printf+0x556>
    42c2:	0405                	addi	s0,s0,1
    42c4:	b771                	j	4250 <__v_printf+0x57c>
    42c6:	57fd                	li	a5,-1
    42c8:	c23e                	sw	a5,4(sp)
    42ca:	40ce                	lw	ra,208(sp)
    42cc:	443e                	lw	s0,204(sp)
    42ce:	4512                	lw	a0,4(sp)
    42d0:	44ae                	lw	s1,200(sp)
    42d2:	0d410113          	addi	sp,sp,212
    42d6:	8082                	ret
    42d8:	47a2                	lw	a5,8(sp)
    42da:	c20799e3          	bnez	a5,3f0c <__v_printf+0x238>
    42de:	4785                	li	a5,1
    42e0:	b13d                	j	3f0e <__v_printf+0x23a>
    42e2:	5782                	lw	a5,32(sp)
    42e4:	c4079ce3          	bnez	a5,3f3c <__v_printf+0x268>
    42e8:	4781                	li	a5,0
    42ea:	4752                	lw	a4,20(sp)
    42ec:	c8070de3          	beqz	a4,3f86 <__v_printf+0x2b2>
    42f0:	4582                	lw	a1,0(sp)
    42f2:	0065f363          	bgeu	a1,t1,42f8 <__v_printf+0x624>
    42f6:	859a                	mv	a1,t1
    42f8:	ca3e                	sw	a5,20(sp)
    42fa:	47b2                	lw	a5,12(sp)
    42fc:	02000613          	li	a2,32
    4300:	8526                	mv	a0,s1
    4302:	40b785b3          	sub	a1,a5,a1
    4306:	c41a                	sw	t1,8(sp)
    4308:	cc36                	sw	a3,24(sp)
    430a:	96dff0ef          	jal	ra,3c76 <write_pad>
    430e:	4792                	lw	a5,4(sp)
    4310:	4322                	lw	t1,8(sp)
    4312:	00f50733          	add	a4,a0,a5
    4316:	47d2                	lw	a5,20(sp)
    4318:	cf99                	beqz	a5,4336 <__v_printf+0x662>
    431a:	46e2                	lw	a3,24(sp)
    431c:	0044a383          	lw	t2,4(s1)
    4320:	4090                	lw	a2,0(s1)
    4322:	85be                	mv	a1,a5
    4324:	8536                	mv	a0,a3
    4326:	c61a                	sw	t1,12(sp)
    4328:	c43a                	sw	a4,8(sp)
    432a:	c23e                	sw	a5,4(sp)
    432c:	9382                	jalr	t2
    432e:	4792                	lw	a5,4(sp)
    4330:	4722                	lw	a4,8(sp)
    4332:	4332                	lw	t1,12(sp)
    4334:	973e                	add	a4,a4,a5
    4336:	4782                	lw	a5,0(sp)
    4338:	03000613          	li	a2,48
    433c:	8526                	mv	a0,s1
    433e:	406785b3          	sub	a1,a5,t1
    4342:	c23a                	sw	a4,4(sp)
    4344:	c01a                	sw	t1,0(sp)
    4346:	931ff0ef          	jal	ra,3c76 <write_pad>
    434a:	4712                	lw	a4,4(sp)
    434c:	4302                	lw	t1,0(sp)
    434e:	972a                	add	a4,a4,a0
    4350:	40dc                	lw	a5,4(s1)
    4352:	4090                	lw	a2,0(s1)
    4354:	4516                	lw	a0,68(sp)
    4356:	859a                	mv	a1,t1
    4358:	c23a                	sw	a4,4(sp)
    435a:	c01a                	sw	t1,0(sp)
    435c:	9782                	jalr	a5
    435e:	4302                	lw	t1,0(sp)
    4360:	4712                	lw	a4,4(sp)
    4362:	006707b3          	add	a5,a4,t1
    4366:	be19                	j	3e7c <__v_printf+0x1a8>
    4368:	5712                	lw	a4,36(sp)
    436a:	57a2                	lw	a5,40(sp)
    436c:	4601                	li	a2,0
    436e:	4681                	li	a3,0
    4370:	853a                	mv	a0,a4
    4372:	85be                	mv	a1,a5
    4374:	c416                	sw	t0,8(sp)
    4376:	c57fd0ef          	jal	ra,1fcc <__gedf2>
    437a:	42a2                	lw	t0,8(sp)
    437c:	f00549e3          	bltz	a0,428e <__v_printf+0x5ba>
    4380:	02b00793          	li	a5,43
    4384:	4716                	lw	a4,68(sp)
    4386:	fff70693          	addi	a3,a4,-1
    438a:	c2b6                	sw	a3,68(sp)
    438c:	fef70fa3          	sb	a5,-1(a4)
    4390:	bdfd                	j	428e <__v_printf+0x5ba>
    4392:	57a2                	lw	a5,40(sp)
    4394:	5712                	lw	a4,36(sp)
    4396:	4601                	li	a2,0
    4398:	85be                	mv	a1,a5
    439a:	4681                	li	a3,0
    439c:	853a                	mv	a0,a4
    439e:	c416                	sw	t0,8(sp)
    43a0:	c2dfd0ef          	jal	ra,1fcc <__gedf2>
    43a4:	42a2                	lw	t0,8(sp)
    43a6:	02000793          	li	a5,32
    43aa:	fc055de3          	bgez	a0,4384 <__v_printf+0x6b0>
    43ae:	b5c5                	j	428e <__v_printf+0x5ba>
    43b0:	9a059fe3          	bnez	a1,3d6e <__v_printf+0x9a>
    43b4:	47c2                	lw	a5,16(sp)
    43b6:	bae9                	j	3d90 <__v_printf+0xbc>

000043b8 <__stdio_outs>:
    43b8:	1151                	addi	sp,sp,-12
    43ba:	c222                	sw	s0,4(sp)
    43bc:	c026                	sw	s1,0(sp)
    43be:	842a                	mv	s0,a0
    43c0:	84ae                	mv	s1,a1
    43c2:	c406                	sw	ra,8(sp)
    43c4:	94a2                	add	s1,s1,s0
    43c6:	927fe0ef          	jal	ra,2cec <os_critical_enter>
    43ca:	00941a63          	bne	s0,s1,43de <__stdio_outs+0x26>
    43ce:	92dfe0ef          	jal	ra,2cfa <os_critical_exit>
    43d2:	40a2                	lw	ra,8(sp)
    43d4:	4412                	lw	s0,4(sp)
    43d6:	4482                	lw	s1,0(sp)
    43d8:	4505                	li	a0,1
    43da:	0131                	addi	sp,sp,12
    43dc:	8082                	ret
    43de:	0001a703          	lw	a4,0(gp) # 200001e0 <_impure_ptr>
    43e2:	00044503          	lbu	a0,0(s0)
    43e6:	0405                	addi	s0,s0,1
    43e8:	470c                	lw	a1,8(a4)
    43ea:	8cdfe0ef          	jal	ra,2cb6 <fputc>
    43ee:	bff1                	j	43ca <__stdio_outs+0x12>

000043f0 <vprintf>:
    43f0:	1131                	addi	sp,sp,-20
    43f2:	6791                	lui	a5,0x4
    43f4:	862e                	mv	a2,a1
    43f6:	3b878793          	addi	a5,a5,952 # 43b8 <__stdio_outs>
    43fa:	85aa                	mv	a1,a0
    43fc:	850a                	mv	a0,sp
    43fe:	c806                	sw	ra,16(sp)
    4400:	c002                	sw	zero,0(sp)
    4402:	c23e                	sw	a5,4(sp)
    4404:	8d1ff0ef          	jal	ra,3cd4 <__v_printf>
    4408:	40c2                	lw	ra,16(sp)
    440a:	0151                	addi	sp,sp,20
    440c:	8082                	ret
	...
