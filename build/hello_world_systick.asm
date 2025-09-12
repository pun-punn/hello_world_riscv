
/home/pun/public_released/hello_world_e902/build/hello_world_systick.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <__start>:

   sw   t0, 0(t1)

.endm

  la x3, __erodata
       0:	00005197          	auipc	gp,0x5
       4:	0a818193          	addi	gp,gp,168 # 50a8 <__erodata>

  la x4, __data_start__
       8:	20000217          	auipc	tp,0x20000
       c:	ff820213          	addi	tp,tp,-8 # 20000000 <_impure_data>

  la x5, __data_end__
      10:	20000297          	auipc	t0,0x20000
      14:	11028293          	addi	t0,t0,272 # 20000120 <_impure_ptr>

  sub x5, x5, x4
      18:	404282b3          	sub	t0,t0,tp

  beqz x5, L_loop0_done
      1c:	00028b63          	beqz	t0,32 <L_loop0_done>

00000020 <L_loop0>:

L_loop0:

   lw x6, 0(x3)
      20:	0001a303          	lw	t1,0(gp)

   sw x6, 0(x4)
      24:	00622023          	sw	t1,0(tp) # 0 <__start>

   addi x3, x3, 0x4
      28:	0191                	addi	gp,gp,4

   addi x4, x4, 0x4
      2a:	0211                	addi	tp,tp,4

   addi x5, x5, -4
      2c:	12f1                	addi	t0,t0,-4

   bnez x5, L_loop0
      2e:	fe0299e3          	bnez	t0,20 <L_loop0>

00000032 <L_loop0_done>:

L_loop0_done:

   la x3, __data_end__
      32:	20000197          	auipc	gp,0x20000
      36:	0ee18193          	addi	gp,gp,238 # 20000120 <_impure_ptr>

   la x4, __bss_end__
      3a:	20000217          	auipc	tp,0x20000
      3e:	22220213          	addi	tp,tp,546 # 2000025c <console_handle>

   li x5, 0
      42:	4281                	li	t0,0

   sub x4, x4, x3
      44:	40320233          	sub	tp,tp,gp

   beqz x4, L_loop1_done
      48:	00020863          	beqz	tp,58 <L_loop1_done>

0000004c <L_loop1>:

L_loop1:

   sw x5, 0(x3)
      4c:	0051a023          	sw	t0,0(gp)

   addi x3, x3, 0x4
      50:	0191                	addi	gp,gp,4

   addi x4, x4, -4
      52:	1271                	addi	tp,tp,-4

   bnez x4, L_loop1
      54:	fe021ce3          	bnez	tp,4c <L_loop1>

00000058 <L_loop1_done>:


L_loop1_done:

  la x3, trap_handler
      58:	00000197          	auipc	gp,0x0
      5c:	0a818193          	addi	gp,gp,168 # 100 <trap_handler>

  csrw mtvec, x3
      60:	30519073          	csrw	mtvec,gp

  la x3, vector_table
      64:	00000197          	auipc	gp,0x0
      68:	0dc18193          	addi	gp,gp,220 # 140 <vector_table>

  addi x3, x3, 64
      6c:	04018193          	addi	gp,gp,64

  csrw mtvt, x3
      70:	30719073          	csrw	mtvt,gp

  la  x2, __kernel_stack
      74:	20010117          	auipc	sp,0x20010
      78:	f8c10113          	addi	sp,sp,-116 # 20010000 <__kernel_stack>

  #csrsi mie,     0x7

#Set Interrupt Handler

  SETINT   7   CORET_IRQHandler     # MTIMER is No. (64+) 7
      7c:	4501                	li	a0,0
      7e:	00000297          	auipc	t0,0x0
      82:	10228293          	addi	t0,t0,258 # 180 <vector_table+0x40>
      86:	431d                	li	t1,7
      88:	030a                	slli	t1,t1,0x2
      8a:	9316                	add	t1,t1,t0
      8c:	00000297          	auipc	t0,0x0
      90:	6f028293          	addi	t0,t0,1776 # 77c <CORET_IRQHandler>
      94:	00532023          	sw	t0,0(t1)

00000098 <__to_main>:

#SETINT  44   gpio3_int_handler     # APB_GPIO3 is No. (64+) 28+16 = 44     CH28

__to_main:

  jal system_init
      98:	6a8000ef          	jal	ra,740 <system_init>
  jal board_init
      9c:	736000ef          	jal	ra,7d2 <board_init>
  csrsi mstatus, 0x8
      a0:	30046073          	csrsi	mstatus,8
  csrsi mie,     0x7
      a4:	3043e073          	csrsi	mie,7
  jal entry
      a8:	7d6000ef          	jal	ra,87e <entry>

000000ac <__exit>:

  .global __exit

__exit:

  fence.i
      ac:	0000100f          	fence.i

  fence
      b0:	0ff0000f          	fence

  li    x4, 0x6000fff8
      b4:	60010237          	lui	tp,0x60010
      b8:	1261                	addi	tp,tp,-8

  addi  x3, x0,0xFF
      ba:	0ff00193          	li	gp,255

  slli  x3, x3,0x4
      be:	0192                	slli	gp,gp,0x4

  addi  x3, x3, 0xf #0xFFF
      c0:	01bd                	addi	gp,gp,15

  sw	x3, 0(x4)
      c2:	00322023          	sw	gp,0(tp) # 60010000 <__kernel_stack+0x40000000>

000000c6 <__fail>:

  .global __fail

__fail:

  fence.i
      c6:	0000100f          	fence.i

  fence
      ca:	0ff0000f          	fence

  li    x4, 0x6000fff8
      ce:	60010237          	lui	tp,0x60010
      d2:	1261                	addi	tp,tp,-8

  addi  x3, x0,0xEE
      d4:	0ee00193          	li	gp,238

  slli  x3, x3,0x4
      d8:	0192                	slli	gp,gp,0x4

  addi  x3, x3,0xe #0xEEE
      da:	01b9                	addi	gp,gp,14

  sw	x3, 0(x4)
      dc:	00322023          	sw	gp,0(tp) # 60010000 <__kernel_stack+0x40000000>
      e0:	00000013          	nop
      e4:	00000013          	nop
      e8:	00000013          	nop
      ec:	00000013          	nop
      f0:	00000013          	nop
      f4:	00000013          	nop
      f8:	00000013          	nop
      fc:	00000013          	nop

00000100 <trap_handler>:

  .global trap_handler

trap_handler:

  j __synchronous_exception
     100:	a019                	j	106 <__synchronous_exception>
     102:	0001                	nop

  .align 2

  j __fail
     104:	b7c9                	j	c6 <__fail>

00000106 <__synchronous_exception>:

__synchronous_exception:

  sw   x13,-4(x2)
     106:	fed12e23          	sw	a3,-4(sp)

  sw   x14,-8(x2)
     10a:	fee12c23          	sw	a4,-8(sp)

  sw   x15,-12(x2)
     10e:	fef12a23          	sw	a5,-12(sp)

  csrr x14,mcause
     112:	34202773          	csrr	a4,mcause

  andi x15,x14,0xff  #cause
     116:	0ff77793          	zext.b	a5,a4

  srli x14,x14,0x1b   #int
     11a:	836d                	srli	a4,a4,0x1b

  andi x14,x14,0x10   #mask bit
     11c:	8b41                	andi	a4,a4,16

  add  x14,x14,x15    #{int,cause}
     11e:	973e                	add	a4,a4,a5

  slli x14,x14,0x2  #offset
     120:	070a                	slli	a4,a4,0x2

  la   x15,vector_table
     122:	00000797          	auipc	a5,0x0
     126:	01e78793          	addi	a5,a5,30 # 140 <vector_table>

  add  x15,x14,x15  #target pc
     12a:	97ba                	add	a5,a5,a4

  lw   x14, 0(x15)  #get exception addr
     12c:	4398                	lw	a4,0(a5)

  lw   x13, -4(x2)  #recover x16
     12e:	ffc12683          	lw	a3,-4(sp)

  lw   x15, -12(x2) #recover x15
     132:	ff412783          	lw	a5,-12(sp)

#addi x14,x14,-4

  jr   x14
     136:	8702                	jr	a4
     138:	00000013          	nop
     13c:	00000013          	nop

00000140 <vector_table>:
     140:	0540                	addi	s0,sp,644
     142:	0000                	unimp
     144:	0540                	addi	s0,sp,644
     146:	0000                	unimp
     148:	0540                	addi	s0,sp,644
     14a:	0000                	unimp
     14c:	0540                	addi	s0,sp,644
     14e:	0000                	unimp
     150:	0540                	addi	s0,sp,644
     152:	0000                	unimp
     154:	0540                	addi	s0,sp,644
     156:	0000                	unimp
     158:	0540                	addi	s0,sp,644
     15a:	0000                	unimp
     15c:	0540                	addi	s0,sp,644
     15e:	0000                	unimp
     160:	0540                	addi	s0,sp,644
     162:	0000                	unimp
     164:	0540                	addi	s0,sp,644
     166:	0000                	unimp
     168:	0540                	addi	s0,sp,644
     16a:	0000                	unimp
     16c:	0540                	addi	s0,sp,644
     16e:	0000                	unimp
     170:	0540                	addi	s0,sp,644
     172:	0000                	unimp
     174:	0540                	addi	s0,sp,644
     176:	0000                	unimp
     178:	0540                	addi	s0,sp,644
     17a:	0000                	unimp
     17c:	0540                	addi	s0,sp,644
     17e:	0000                	unimp
     180:	0540                	addi	s0,sp,644
     182:	0000                	unimp
     184:	0540                	addi	s0,sp,644
     186:	0000                	unimp
     188:	0540                	addi	s0,sp,644
     18a:	0000                	unimp
     18c:	0540                	addi	s0,sp,644
     18e:	0000                	unimp
     190:	0540                	addi	s0,sp,644
     192:	0000                	unimp
     194:	0540                	addi	s0,sp,644
     196:	0000                	unimp
     198:	0540                	addi	s0,sp,644
     19a:	0000                	unimp
     19c:	0540                	addi	s0,sp,644
     19e:	0000                	unimp
     1a0:	0540                	addi	s0,sp,644
     1a2:	0000                	unimp
     1a4:	0540                	addi	s0,sp,644
     1a6:	0000                	unimp
     1a8:	0540                	addi	s0,sp,644
     1aa:	0000                	unimp
     1ac:	0540                	addi	s0,sp,644
     1ae:	0000                	unimp
     1b0:	0540                	addi	s0,sp,644
     1b2:	0000                	unimp
     1b4:	0540                	addi	s0,sp,644
     1b6:	0000                	unimp
     1b8:	0540                	addi	s0,sp,644
     1ba:	0000                	unimp
     1bc:	0540                	addi	s0,sp,644
     1be:	0000                	unimp
     1c0:	0540                	addi	s0,sp,644
     1c2:	0000                	unimp
     1c4:	0540                	addi	s0,sp,644
     1c6:	0000                	unimp
     1c8:	0540                	addi	s0,sp,644
     1ca:	0000                	unimp
     1cc:	0540                	addi	s0,sp,644
     1ce:	0000                	unimp
     1d0:	0540                	addi	s0,sp,644
     1d2:	0000                	unimp
     1d4:	0540                	addi	s0,sp,644
     1d6:	0000                	unimp
     1d8:	0540                	addi	s0,sp,644
     1da:	0000                	unimp
     1dc:	0540                	addi	s0,sp,644
     1de:	0000                	unimp
     1e0:	0540                	addi	s0,sp,644
     1e2:	0000                	unimp
     1e4:	0540                	addi	s0,sp,644
     1e6:	0000                	unimp
     1e8:	0540                	addi	s0,sp,644
     1ea:	0000                	unimp
     1ec:	0540                	addi	s0,sp,644
     1ee:	0000                	unimp
     1f0:	0540                	addi	s0,sp,644
     1f2:	0000                	unimp
     1f4:	0540                	addi	s0,sp,644
     1f6:	0000                	unimp
     1f8:	0540                	addi	s0,sp,644
     1fa:	0000                	unimp
     1fc:	0540                	addi	s0,sp,644
     1fe:	0000                	unimp
     200:	0540                	addi	s0,sp,644
     202:	0000                	unimp
     204:	0540                	addi	s0,sp,644
     206:	0000                	unimp
     208:	0540                	addi	s0,sp,644
     20a:	0000                	unimp
     20c:	0540                	addi	s0,sp,644
     20e:	0000                	unimp
     210:	0540                	addi	s0,sp,644
     212:	0000                	unimp
     214:	0540                	addi	s0,sp,644
     216:	0000                	unimp
     218:	0540                	addi	s0,sp,644
     21a:	0000                	unimp
     21c:	0540                	addi	s0,sp,644
     21e:	0000                	unimp
     220:	0540                	addi	s0,sp,644
     222:	0000                	unimp
     224:	0540                	addi	s0,sp,644
     226:	0000                	unimp
     228:	0540                	addi	s0,sp,644
     22a:	0000                	unimp
     22c:	0540                	addi	s0,sp,644
     22e:	0000                	unimp
     230:	0540                	addi	s0,sp,644
     232:	0000                	unimp
     234:	0540                	addi	s0,sp,644
     236:	0000                	unimp
     238:	0540                	addi	s0,sp,644
     23a:	0000                	unimp
     23c:	0540                	addi	s0,sp,644
     23e:	0000                	unimp
     240:	0540                	addi	s0,sp,644
     242:	0000                	unimp
     244:	0540                	addi	s0,sp,644
     246:	0000                	unimp
     248:	0540                	addi	s0,sp,644
     24a:	0000                	unimp
     24c:	0540                	addi	s0,sp,644
     24e:	0000                	unimp
     250:	0540                	addi	s0,sp,644
     252:	0000                	unimp
     254:	0540                	addi	s0,sp,644
     256:	0000                	unimp
     258:	0540                	addi	s0,sp,644
     25a:	0000                	unimp
     25c:	0540                	addi	s0,sp,644
     25e:	0000                	unimp
     260:	0540                	addi	s0,sp,644
     262:	0000                	unimp
     264:	0540                	addi	s0,sp,644
     266:	0000                	unimp
     268:	0540                	addi	s0,sp,644
     26a:	0000                	unimp
     26c:	0540                	addi	s0,sp,644
     26e:	0000                	unimp
     270:	0540                	addi	s0,sp,644
     272:	0000                	unimp
     274:	0540                	addi	s0,sp,644
     276:	0000                	unimp
     278:	0540                	addi	s0,sp,644
     27a:	0000                	unimp
     27c:	0540                	addi	s0,sp,644
     27e:	0000                	unimp
     280:	0540                	addi	s0,sp,644
     282:	0000                	unimp
     284:	0540                	addi	s0,sp,644
     286:	0000                	unimp
     288:	0540                	addi	s0,sp,644
     28a:	0000                	unimp
     28c:	0540                	addi	s0,sp,644
     28e:	0000                	unimp
     290:	0540                	addi	s0,sp,644
     292:	0000                	unimp
     294:	0540                	addi	s0,sp,644
     296:	0000                	unimp
     298:	0540                	addi	s0,sp,644
     29a:	0000                	unimp
     29c:	0540                	addi	s0,sp,644
     29e:	0000                	unimp
     2a0:	0540                	addi	s0,sp,644
     2a2:	0000                	unimp
     2a4:	0540                	addi	s0,sp,644
     2a6:	0000                	unimp
     2a8:	0540                	addi	s0,sp,644
     2aa:	0000                	unimp
     2ac:	0540                	addi	s0,sp,644
     2ae:	0000                	unimp
     2b0:	0540                	addi	s0,sp,644
     2b2:	0000                	unimp
     2b4:	0540                	addi	s0,sp,644
     2b6:	0000                	unimp
     2b8:	0540                	addi	s0,sp,644
     2ba:	0000                	unimp
     2bc:	0540                	addi	s0,sp,644
     2be:	0000                	unimp
     2c0:	0540                	addi	s0,sp,644
     2c2:	0000                	unimp
     2c4:	0540                	addi	s0,sp,644
     2c6:	0000                	unimp
     2c8:	0540                	addi	s0,sp,644
     2ca:	0000                	unimp
     2cc:	0540                	addi	s0,sp,644
     2ce:	0000                	unimp
     2d0:	0540                	addi	s0,sp,644
     2d2:	0000                	unimp
     2d4:	0540                	addi	s0,sp,644
     2d6:	0000                	unimp
     2d8:	0540                	addi	s0,sp,644
     2da:	0000                	unimp
     2dc:	0540                	addi	s0,sp,644
     2de:	0000                	unimp
     2e0:	0540                	addi	s0,sp,644
     2e2:	0000                	unimp
     2e4:	0540                	addi	s0,sp,644
     2e6:	0000                	unimp
     2e8:	0540                	addi	s0,sp,644
     2ea:	0000                	unimp
     2ec:	0540                	addi	s0,sp,644
     2ee:	0000                	unimp
     2f0:	0540                	addi	s0,sp,644
     2f2:	0000                	unimp
     2f4:	0540                	addi	s0,sp,644
     2f6:	0000                	unimp
     2f8:	0540                	addi	s0,sp,644
     2fa:	0000                	unimp
     2fc:	0540                	addi	s0,sp,644
     2fe:	0000                	unimp
     300:	0540                	addi	s0,sp,644
     302:	0000                	unimp
     304:	0540                	addi	s0,sp,644
     306:	0000                	unimp
     308:	0540                	addi	s0,sp,644
     30a:	0000                	unimp
     30c:	0540                	addi	s0,sp,644
     30e:	0000                	unimp
     310:	0540                	addi	s0,sp,644
     312:	0000                	unimp
     314:	0540                	addi	s0,sp,644
     316:	0000                	unimp
     318:	0540                	addi	s0,sp,644
     31a:	0000                	unimp
     31c:	0540                	addi	s0,sp,644
     31e:	0000                	unimp
     320:	0540                	addi	s0,sp,644
     322:	0000                	unimp
     324:	0540                	addi	s0,sp,644
     326:	0000                	unimp
     328:	0540                	addi	s0,sp,644
     32a:	0000                	unimp
     32c:	0540                	addi	s0,sp,644
     32e:	0000                	unimp
     330:	0540                	addi	s0,sp,644
     332:	0000                	unimp
     334:	0540                	addi	s0,sp,644
     336:	0000                	unimp
     338:	0540                	addi	s0,sp,644
     33a:	0000                	unimp
     33c:	0540                	addi	s0,sp,644
     33e:	0000                	unimp
     340:	0540                	addi	s0,sp,644
     342:	0000                	unimp
     344:	0540                	addi	s0,sp,644
     346:	0000                	unimp
     348:	0540                	addi	s0,sp,644
     34a:	0000                	unimp
     34c:	0540                	addi	s0,sp,644
     34e:	0000                	unimp
     350:	0540                	addi	s0,sp,644
     352:	0000                	unimp
     354:	0540                	addi	s0,sp,644
     356:	0000                	unimp
     358:	0540                	addi	s0,sp,644
     35a:	0000                	unimp
     35c:	0540                	addi	s0,sp,644
     35e:	0000                	unimp
     360:	0540                	addi	s0,sp,644
     362:	0000                	unimp
     364:	0540                	addi	s0,sp,644
     366:	0000                	unimp
     368:	0540                	addi	s0,sp,644
     36a:	0000                	unimp
     36c:	0540                	addi	s0,sp,644
     36e:	0000                	unimp
     370:	0540                	addi	s0,sp,644
     372:	0000                	unimp
     374:	0540                	addi	s0,sp,644
     376:	0000                	unimp
     378:	0540                	addi	s0,sp,644
     37a:	0000                	unimp
     37c:	0540                	addi	s0,sp,644
     37e:	0000                	unimp
     380:	0540                	addi	s0,sp,644
     382:	0000                	unimp
     384:	0540                	addi	s0,sp,644
     386:	0000                	unimp
     388:	0540                	addi	s0,sp,644
     38a:	0000                	unimp
     38c:	0540                	addi	s0,sp,644
     38e:	0000                	unimp
     390:	0540                	addi	s0,sp,644
     392:	0000                	unimp
     394:	0540                	addi	s0,sp,644
     396:	0000                	unimp
     398:	0540                	addi	s0,sp,644
     39a:	0000                	unimp
     39c:	0540                	addi	s0,sp,644
     39e:	0000                	unimp
     3a0:	0540                	addi	s0,sp,644
     3a2:	0000                	unimp
     3a4:	0540                	addi	s0,sp,644
     3a6:	0000                	unimp
     3a8:	0540                	addi	s0,sp,644
     3aa:	0000                	unimp
     3ac:	0540                	addi	s0,sp,644
     3ae:	0000                	unimp
     3b0:	0540                	addi	s0,sp,644
     3b2:	0000                	unimp
     3b4:	0540                	addi	s0,sp,644
     3b6:	0000                	unimp
     3b8:	0540                	addi	s0,sp,644
     3ba:	0000                	unimp
     3bc:	0540                	addi	s0,sp,644
     3be:	0000                	unimp
     3c0:	0540                	addi	s0,sp,644
     3c2:	0000                	unimp
     3c4:	0540                	addi	s0,sp,644
     3c6:	0000                	unimp
     3c8:	0540                	addi	s0,sp,644
     3ca:	0000                	unimp
     3cc:	0540                	addi	s0,sp,644
     3ce:	0000                	unimp
     3d0:	0540                	addi	s0,sp,644
     3d2:	0000                	unimp
     3d4:	0540                	addi	s0,sp,644
     3d6:	0000                	unimp
     3d8:	0540                	addi	s0,sp,644
     3da:	0000                	unimp
     3dc:	0540                	addi	s0,sp,644
     3de:	0000                	unimp
     3e0:	0540                	addi	s0,sp,644
     3e2:	0000                	unimp
     3e4:	0540                	addi	s0,sp,644
     3e6:	0000                	unimp
     3e8:	0540                	addi	s0,sp,644
     3ea:	0000                	unimp
     3ec:	0540                	addi	s0,sp,644
     3ee:	0000                	unimp
     3f0:	0540                	addi	s0,sp,644
     3f2:	0000                	unimp
     3f4:	0540                	addi	s0,sp,644
     3f6:	0000                	unimp
     3f8:	0540                	addi	s0,sp,644
     3fa:	0000                	unimp
     3fc:	0540                	addi	s0,sp,644
     3fe:	0000                	unimp
     400:	0540                	addi	s0,sp,644
     402:	0000                	unimp
     404:	0540                	addi	s0,sp,644
     406:	0000                	unimp
     408:	0540                	addi	s0,sp,644
     40a:	0000                	unimp
     40c:	0540                	addi	s0,sp,644
     40e:	0000                	unimp
     410:	0540                	addi	s0,sp,644
     412:	0000                	unimp
     414:	0540                	addi	s0,sp,644
     416:	0000                	unimp
     418:	0540                	addi	s0,sp,644
     41a:	0000                	unimp
     41c:	0540                	addi	s0,sp,644
     41e:	0000                	unimp
     420:	0540                	addi	s0,sp,644
     422:	0000                	unimp
     424:	0540                	addi	s0,sp,644
     426:	0000                	unimp
     428:	0540                	addi	s0,sp,644
     42a:	0000                	unimp
     42c:	0540                	addi	s0,sp,644
     42e:	0000                	unimp
     430:	0540                	addi	s0,sp,644
     432:	0000                	unimp
     434:	0540                	addi	s0,sp,644
     436:	0000                	unimp
     438:	0540                	addi	s0,sp,644
     43a:	0000                	unimp
     43c:	0540                	addi	s0,sp,644
     43e:	0000                	unimp
     440:	0540                	addi	s0,sp,644
     442:	0000                	unimp
     444:	0540                	addi	s0,sp,644
     446:	0000                	unimp
     448:	0540                	addi	s0,sp,644
     44a:	0000                	unimp
     44c:	0540                	addi	s0,sp,644
     44e:	0000                	unimp
     450:	0540                	addi	s0,sp,644
     452:	0000                	unimp
     454:	0540                	addi	s0,sp,644
     456:	0000                	unimp
     458:	0540                	addi	s0,sp,644
     45a:	0000                	unimp
     45c:	0540                	addi	s0,sp,644
     45e:	0000                	unimp
     460:	0540                	addi	s0,sp,644
     462:	0000                	unimp
     464:	0540                	addi	s0,sp,644
     466:	0000                	unimp
     468:	0540                	addi	s0,sp,644
     46a:	0000                	unimp
     46c:	0540                	addi	s0,sp,644
     46e:	0000                	unimp
     470:	0540                	addi	s0,sp,644
     472:	0000                	unimp
     474:	0540                	addi	s0,sp,644
     476:	0000                	unimp
     478:	0540                	addi	s0,sp,644
     47a:	0000                	unimp
     47c:	0540                	addi	s0,sp,644
     47e:	0000                	unimp
     480:	0540                	addi	s0,sp,644
     482:	0000                	unimp
     484:	0540                	addi	s0,sp,644
     486:	0000                	unimp
     488:	0540                	addi	s0,sp,644
     48a:	0000                	unimp
     48c:	0540                	addi	s0,sp,644
     48e:	0000                	unimp
     490:	0540                	addi	s0,sp,644
     492:	0000                	unimp
     494:	0540                	addi	s0,sp,644
     496:	0000                	unimp
     498:	0540                	addi	s0,sp,644
     49a:	0000                	unimp
     49c:	0540                	addi	s0,sp,644
     49e:	0000                	unimp
     4a0:	0540                	addi	s0,sp,644
     4a2:	0000                	unimp
     4a4:	0540                	addi	s0,sp,644
     4a6:	0000                	unimp
     4a8:	0540                	addi	s0,sp,644
     4aa:	0000                	unimp
     4ac:	0540                	addi	s0,sp,644
     4ae:	0000                	unimp
     4b0:	0540                	addi	s0,sp,644
     4b2:	0000                	unimp
     4b4:	0540                	addi	s0,sp,644
     4b6:	0000                	unimp
     4b8:	0540                	addi	s0,sp,644
     4ba:	0000                	unimp
     4bc:	0540                	addi	s0,sp,644
     4be:	0000                	unimp
     4c0:	0540                	addi	s0,sp,644
     4c2:	0000                	unimp
     4c4:	0540                	addi	s0,sp,644
     4c6:	0000                	unimp
     4c8:	0540                	addi	s0,sp,644
     4ca:	0000                	unimp
     4cc:	0540                	addi	s0,sp,644
     4ce:	0000                	unimp
     4d0:	0540                	addi	s0,sp,644
     4d2:	0000                	unimp
     4d4:	0540                	addi	s0,sp,644
     4d6:	0000                	unimp
     4d8:	0540                	addi	s0,sp,644
     4da:	0000                	unimp
     4dc:	0540                	addi	s0,sp,644
     4de:	0000                	unimp
     4e0:	0540                	addi	s0,sp,644
     4e2:	0000                	unimp
     4e4:	0540                	addi	s0,sp,644
     4e6:	0000                	unimp
     4e8:	0540                	addi	s0,sp,644
     4ea:	0000                	unimp
     4ec:	0540                	addi	s0,sp,644
     4ee:	0000                	unimp
     4f0:	0540                	addi	s0,sp,644
     4f2:	0000                	unimp
     4f4:	0540                	addi	s0,sp,644
     4f6:	0000                	unimp
     4f8:	0540                	addi	s0,sp,644
     4fa:	0000                	unimp
     4fc:	0540                	addi	s0,sp,644
     4fe:	0000                	unimp
     500:	0540                	addi	s0,sp,644
     502:	0000                	unimp
     504:	0540                	addi	s0,sp,644
     506:	0000                	unimp
     508:	0540                	addi	s0,sp,644
     50a:	0000                	unimp
     50c:	0540                	addi	s0,sp,644
     50e:	0000                	unimp
     510:	0540                	addi	s0,sp,644
     512:	0000                	unimp
     514:	0540                	addi	s0,sp,644
     516:	0000                	unimp
     518:	0540                	addi	s0,sp,644
     51a:	0000                	unimp
     51c:	0540                	addi	s0,sp,644
     51e:	0000                	unimp
     520:	0540                	addi	s0,sp,644
     522:	0000                	unimp
     524:	0540                	addi	s0,sp,644
     526:	0000                	unimp
     528:	0540                	addi	s0,sp,644
     52a:	0000                	unimp
     52c:	0540                	addi	s0,sp,644
     52e:	0000                	unimp
     530:	0540                	addi	s0,sp,644
     532:	0000                	unimp
     534:	0540                	addi	s0,sp,644
     536:	0000                	unimp
     538:	0540                	addi	s0,sp,644
     53a:	0000                	unimp
     53c:	0540                	addi	s0,sp,644
	...

00000540 <__dummy>:

  .global __dummy

__dummy:

  j __fail
     540:	b659                	j	c6 <__fail>
	...

0000056c <cpu_intrpt_save>:
 ******************************************************************************/

.global cpu_intrpt_save
.type cpu_intrpt_save, %function
cpu_intrpt_save:
    csrr    a0, mstatus  # read a0 store in psr
     56c:	30002573          	csrr	a0,mstatus
    csrc    mstatus, 8   # clear mie bit 3
     570:	30047073          	csrci	mstatus,8
    ret
     574:	8082                	ret

00000576 <cpu_intrpt_restore>:

.global cpu_intrpt_restore
.type cpu_intrpt_restore, %function
cpu_intrpt_restore:
    csrw    mstatus, a0 # write psr = a0 to mstatus
     576:	30051073          	csrw	mstatus,a0
    ret
     57a:	8082                	ret

0000057c <cpu_task_switch>:
 ******************************************************************************/

.global cpu_task_switch
.type cpu_task_switch, %function
cpu_task_switch:
    la      a0, g_intrpt_nested_level
     57c:	20000517          	auipc	a0,0x20000
     580:	e6c50513          	addi	a0,a0,-404 # 200003e8 <g_intrpt_nested_level>
    lb      a0, (a0)
     584:	00050503          	lb	a0,0(a0)
    beqz    a0, __task_switch
     588:	c515                	beqz	a0,5b4 <__task_switch>

    la      a0, g_active_task
     58a:	20000517          	auipc	a0,0x20000
     58e:	e5a50513          	addi	a0,a0,-422 # 200003e4 <g_active_task>
    la      a1, g_preferred_ready_task
     592:	20000597          	auipc	a1,0x20000
     596:	e5a58593          	addi	a1,a1,-422 # 200003ec <g_preferred_ready_task>
    lw      a2, (a1)
     59a:	4190                	lw	a2,0(a1)
    sw      a2, (a0)
     59c:	c110                	sw	a2,0(a0)

0000059e <cpu_intrpt_switch>:

.global cpu_intrpt_switch
.type cpu_intrpt_switch, %function
cpu_intrpt_switch:
    la      a0, g_active_task
     59e:	20000517          	auipc	a0,0x20000
     5a2:	e4650513          	addi	a0,a0,-442 # 200003e4 <g_active_task>
    la      a1, g_preferred_ready_task
     5a6:	20000597          	auipc	a1,0x20000
     5aa:	e4658593          	addi	a1,a1,-442 # 200003ec <g_preferred_ready_task>
    lw      a2, (a1)                    #load  a1(g_preferred_ready_task) to a2
     5ae:	4190                	lw	a2,0(a1)
    sw      a2, (a0)                    #store a2g_preferred_ready_task)  to a0 (replace g_active_task)
     5b0:	c110                	sw	a2,0(a0)

000005b2 <cpu_first_task_start>:
 *     void cpu_first_task_start(void);
 ******************************************************************************/
.global cpu_first_task_start
.type cpu_first_task_start, %function
cpu_first_task_start:
    j       __task_switch_nosave
     5b2:	a80d                	j	5e4 <__task_switch_nosave>

000005b4 <__task_switch>:
 *     void __task_switch(void);
 ******************************************************************************/

.type __task_switch, %function
__task_switch:
    addi    sp, sp, -60
     5b4:	fc410113          	addi	sp,sp,-60

    sw      x1, 0(sp)
     5b8:	c006                	sw	ra,0(sp)
    sw      x3, 4(sp)
     5ba:	c20e                	sw	gp,4(sp)
    sw      x4, 8(sp)
     5bc:	c412                	sw	tp,8(sp)
    sw      x5, 12(sp)
     5be:	c616                	sw	t0,12(sp)
    sw      x6, 16(sp)
     5c0:	c81a                	sw	t1,16(sp)
    sw      x7, 20(sp)
     5c2:	ca1e                	sw	t2,20(sp)
    sw      x8, 24(sp)
     5c4:	cc22                	sw	s0,24(sp)
    sw      x9, 28(sp)
     5c6:	ce26                	sw	s1,28(sp)
    sw      x10, 32(sp)
     5c8:	d02a                	sw	a0,32(sp)
    sw      x11, 36(sp)
     5ca:	d22e                	sw	a1,36(sp)
    sw      x12, 40(sp)
     5cc:	d432                	sw	a2,40(sp)
    sw      x13, 44(sp)
     5ce:	d636                	sw	a3,44(sp)
    sw      x14, 48(sp)
     5d0:	d83a                	sw	a4,48(sp)
    sw      x15, 52(sp)
     5d2:	da3e                	sw	a5,52(sp)
    sw      ra,  56(sp)
     5d4:	dc06                	sw	ra,56(sp)

    la      a1, g_active_task
     5d6:	20000597          	auipc	a1,0x20000
     5da:	e0e58593          	addi	a1,a1,-498 # 200003e4 <g_active_task>
    lw      a1, (a1)
     5de:	418c                	lw	a1,0(a1)
    sw      sp, (a1)
     5e0:	0025a023          	sw	sp,0(a1)

000005e4 <__task_switch_nosave>:

__task_switch_nosave:
    la      a0, g_preferred_ready_task # load address g_preferred_ready_task
     5e4:	20000517          	auipc	a0,0x20000
     5e8:	e0850513          	addi	a0,a0,-504 # 200003ec <g_preferred_ready_task>
    la      a1, g_active_task          # load address g_active_task
     5ec:	20000597          	auipc	a1,0x20000
     5f0:	df858593          	addi	a1,a1,-520 # 200003e4 <g_active_task>
    lw      a2, (a0)                   # a2 = value g_preferred_ready_task
     5f4:	4110                	lw	a2,0(a0)
    sw      a2, (a1)                   # store a1 = a2 = g_preferred_ready_task
     5f6:	c190                	sw	a2,0(a1)

    lw      sp, (a2)                   # sp = g_preferred_ready_task
     5f8:	00062103          	lw	sp,0(a2)

    li      t0, MSTATUS_PRV1
     5fc:	6289                	lui	t0,0x2
     5fe:	88028293          	addi	t0,t0,-1920 # 1880 <_strtol_l.part.0+0xd2>
    csrs    mstatus, t0
     602:	3002a073          	csrs	mstatus,t0

    lw      t0, 56(sp)
     606:	52e2                	lw	t0,56(sp)
    csrw    mepc, t0
     608:	34129073          	csrw	mepc,t0

    lw      x1, 0(sp)
     60c:	4082                	lw	ra,0(sp)
    lw      x3, 4(sp)
     60e:	4192                	lw	gp,4(sp)
    lw      x4, 8(sp)
     610:	4222                	lw	tp,8(sp)
    lw      x5, 12(sp)
     612:	42b2                	lw	t0,12(sp)
    lw      x6, 16(sp)
     614:	4342                	lw	t1,16(sp)
    lw      x7, 20(sp)
     616:	43d2                	lw	t2,20(sp)
    lw      x8, 24(sp)
     618:	4462                	lw	s0,24(sp)
    lw      x9, 28(sp)
     61a:	44f2                	lw	s1,28(sp)
    lw      x10, 32(sp)
     61c:	5502                	lw	a0,32(sp)
    lw      x11, 36(sp)
     61e:	5592                	lw	a1,36(sp)
    lw      x12, 40(sp)
     620:	5622                	lw	a2,40(sp)
    lw      x13, 44(sp)
     622:	56b2                	lw	a3,44(sp)
    lw      x14, 48(sp)
     624:	5742                	lw	a4,48(sp)
    lw      x15, 52(sp)
     626:	57d2                	lw	a5,52(sp)

    addi    sp, sp, 60
     628:	03c10113          	addi	sp,sp,60

0000062c <Default_IRQHandler>:
 ******************************************************************************/

.global Default_IRQHandler
.type   Default_IRQHandler, %function
Default_IRQHandler:
    nop
     62c:	0001                	nop

0000062e <fputc>:
{
    return 0;
}

int fputc(int ch, FILE *stream)
{
     62e:	1151                	addi	sp,sp,-12
    (void)stream;

    if (console_handle == NULL) {
     630:	200007b7          	lui	a5,0x20000
{
     634:	c026                	sw	s1,0(sp)
     636:	84aa                	mv	s1,a0
    if (console_handle == NULL) {
     638:	25c7a503          	lw	a0,604(a5) # 2000025c <console_handle>
{
     63c:	c406                	sw	ra,8(sp)
     63e:	c222                	sw	s0,4(sp)
    if (console_handle == NULL) {
     640:	c115                	beqz	a0,664 <fputc+0x36>
     642:	25c78413          	addi	s0,a5,604
        return -1;
    }

    if (ch == '\n') {
     646:	47a9                	li	a5,10
     648:	00f49463          	bne	s1,a5,650 <fputc+0x22>
        drv_uart_putc(console_handle, '\r');
     64c:	45b5                	li	a1,13
     64e:	2859                	jal	6e4 <drv_uart_putc>
    }

    drv_uart_putc(console_handle, ch);
     650:	4008                	lw	a0,0(s0)
     652:	0ff4f593          	zext.b	a1,s1
     656:	2079                	jal	6e4 <drv_uart_putc>


    return 0;
     658:	4501                	li	a0,0
}
     65a:	40a2                	lw	ra,8(sp)
     65c:	4412                	lw	s0,4(sp)
     65e:	4482                	lw	s1,0(sp)
     660:	0131                	addi	sp,sp,12
     662:	8082                	ret
        return -1;
     664:	557d                	li	a0,-1
     666:	bfd5                	j	65a <fputc+0x2c>

00000668 <os_critical_enter>:
    drv_uart_getc(console_handle, &ch);

    return ch;
}

int os_critical_enter(unsigned int *lock){
     668:	1151                	addi	sp,sp,-12
     66a:	c406                	sw	ra,8(sp)
     (void)lock;
     kos_kernel_sched_suspend();
     66c:	242d                	jal	896 <kos_kernel_sched_suspend>
     return 0;
}
     66e:	40a2                	lw	ra,8(sp)
     670:	4501                	li	a0,0
     672:	0131                	addi	sp,sp,12
     674:	8082                	ret

00000676 <os_critical_exit>:

int os_critical_exit(unsigned int *lock){
     676:	1151                	addi	sp,sp,-12
     (void)lock;
     kos_kernel_sched_resume(0);
     678:	4501                	li	a0,0
int os_critical_exit(unsigned int *lock){
     67a:	c406                	sw	ra,8(sp)
     kos_kernel_sched_resume(0);
     67c:	2c2d                	jal	8b6 <kos_kernel_sched_resume>
     return 0;
}
     67e:	40a2                	lw	ra,8(sp)
     680:	4501                	li	a0,0
     682:	0131                	addi	sp,sp,12
     684:	8082                	ret

00000686 <drv_uart_initialize>:

static uart_priv_t uart_instance[2]; // 2 uarts port [0,1]

extern int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler);

uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
     686:	1111                	addi	sp,sp,-28
     688:	c826                	sw	s1,16(sp)
    uint32_t base;
    uint32_t irq;
    void    *handler;
    uint32_t gpio_base;
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
     68a:	0038                	addi	a4,sp,8
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
     68c:	84ae                	mv	s1,a1
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
     68e:	0054                	addi	a3,sp,4
     690:	0070                	addi	a2,sp,12
     692:	858a                	mv	a1,sp
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
     694:	ca22                	sw	s0,20(sp)
     696:	cc06                	sw	ra,24(sp)
     698:	842a                	mv	s0,a0
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
     69a:	28b1                	jal	6f6 <target_uart_init>

    if(ret < 0) { return 0;}
     69c:	02054863          	bltz	a0,6cc <drv_uart_initialize+0x46>
    uart_priv_t *uart_priv = &uart_instance[idx];
     6a0:	03c00513          	li	a0,60
     6a4:	02a40533          	mul	a0,s0,a0
     6a8:	200007b7          	lui	a5,0x20000
     6ac:	26078793          	addi	a5,a5,608 # 20000260 <uart_instance>
     6b0:	953e                	add	a0,a0,a5
    uart_priv->base = base;
     6b2:	4782                	lw	a5,0(sp)
    uart_priv->gpio_base = gpio_base;
    uart_priv->idx  = idx;
     6b4:	dd00                	sw	s0,56(a0)
    uart_priv->irq  = irq;
    uart_priv->cb_event  = cb_event;
     6b6:	c544                	sw	s1,12(a0)
    uart_priv->base = base;
     6b8:	c11c                	sw	a5,0(a0)
    uart_priv->gpio_base = gpio_base;
     6ba:	47b2                	lw	a5,12(sp)
     6bc:	c15c                	sw	a5,4(a0)
    uart_priv->irq  = irq;
     6be:	4792                	lw	a5,4(sp)
     6c0:	c51c                	sw	a5,8(a0)

    return (uart_handle_t)uart_priv;
}
     6c2:	40e2                	lw	ra,24(sp)
     6c4:	4452                	lw	s0,20(sp)
     6c6:	44c2                	lw	s1,16(sp)
     6c8:	0171                	addi	sp,sp,28
     6ca:	8082                	ret
    if(ret < 0) { return 0;}
     6cc:	4501                	li	a0,0
     6ce:	bfd5                	j	6c2 <drv_uart_initialize+0x3c>

000006d0 <drv_uart_config_baudrate>:


int32_t drv_uart_config_baudrate(uart_handle_t handle, uint32_t baud, uint32_t cfg){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr_uart = (uart_reg_t*)(uintptr_t)(uart_priv->base);
    gpio_reg_t *addr_gpio = (gpio_reg_t*)(uintptr_t)(uart_priv->gpio_base);
     6d0:	4158                	lw	a4,4(a0)
    uart_reg_t *addr_uart = (uart_reg_t*)(uintptr_t)(uart_priv->base);
     6d2:	411c                	lw	a5,0(a0)

    addr_gpio->DIR = 0x00000001;
     6d4:	4685                	li	a3,1
     6d6:	c754                	sw	a3,12(a4)
    addr_gpio->MUX = 0x0000000F;
     6d8:	46bd                	li	a3,15
     6da:	cb14                	sw	a3,16(a4)
    addr_uart->BAUD = baud;
     6dc:	c78c                	sw	a1,8(a5)
    addr_uart->CFG  = cfg;
     6de:	c3d0                	sw	a2,4(a5)

    return 0;
}
     6e0:	4501                	li	a0,0
     6e2:	8082                	ret

000006e4 <drv_uart_putc>:

int32_t drv_uart_putc(uart_handle_t handle, uint8_t ch){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*)(uintptr_t)(uart_priv->base);
     6e4:	4118                	lw	a4,0(a0)

    uint32_t fifo;
    do { fifo = addr->STS;
      fifo = fifo&0x1F;
    } while (fifo==16);
     6e6:	46c1                	li	a3,16
    do { fifo = addr->STS;
     6e8:	475c                	lw	a5,12(a4)
      fifo = fifo&0x1F;
     6ea:	8bfd                	andi	a5,a5,31
    } while (fifo==16);
     6ec:	fed78ee3          	beq	a5,a3,6e8 <drv_uart_putc+0x4>

    addr->DATA = ch;
     6f0:	c30c                	sw	a1,0(a4)

    return 0;
}
     6f2:	4501                	li	a0,0
     6f4:	8082                	ret

000006f6 <target_uart_init>:
    {UART1_BASE, 39/*uart irq1*/, UART1_IRQHandler, GPIO1_BASE},
};

int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler)
{
    if (base != 0) {
     6f6:	c989                	beqz	a1,708 <target_uart_init+0x12>
        *base = sg_uart_config[idx].base;
     6f8:	6311                	lui	t1,0x4
     6fa:	00451793          	slli	a5,a0,0x4
     6fe:	23030313          	addi	t1,t1,560 # 4230 <sg_uart_config>
     702:	979a                	add	a5,a5,t1
     704:	439c                	lw	a5,0(a5)
     706:	c19c                	sw	a5,0(a1)
    }

    if(gpio_base != 0){
     708:	ca09                	beqz	a2,71a <target_uart_init+0x24>
        *gpio_base = sg_uart_config[idx].gpio_base;
     70a:	6591                	lui	a1,0x4
     70c:	00451793          	slli	a5,a0,0x4
     710:	23058593          	addi	a1,a1,560 # 4230 <sg_uart_config>
     714:	97ae                	add	a5,a5,a1
     716:	47dc                	lw	a5,12(a5)
     718:	c21c                	sw	a5,0(a2)
    }

    if (irq != 0) {
     71a:	ca89                	beqz	a3,72c <target_uart_init+0x36>
        *irq = sg_uart_config[idx].irq;
     71c:	6611                	lui	a2,0x4
     71e:	00451793          	slli	a5,a0,0x4
     722:	23060613          	addi	a2,a2,560 # 4230 <sg_uart_config>
     726:	97b2                	add	a5,a5,a2
     728:	43dc                	lw	a5,4(a5)
     72a:	c29c                	sw	a5,0(a3)
    }

    if (handler != 0) {
     72c:	cb09                	beqz	a4,73e <target_uart_init+0x48>
        *handler = sg_uart_config[idx].handler;
     72e:	6691                	lui	a3,0x4
     730:	00451793          	slli	a5,a0,0x4
     734:	23068693          	addi	a3,a3,560 # 4230 <sg_uart_config>
     738:	97b6                	add	a5,a5,a3
     73a:	479c                	lw	a5,8(a5)
     73c:	c31c                	sw	a5,0(a4)
    }
    return idx;
}
     73e:	8082                	ret

00000740 <system_init>:
    //__enable_irq();
}

void system_init(void){
    //config core local interrupt controller
    CLIC->CLICCFG = 0x6UL;
     740:	e08007b7          	lui	a5,0xe0800
     744:	4719                	li	a4,6
     746:	c398                	sw	a4,0(a5)

    uint32_t tick = 100000; // cycles
    CLINTCMP->MTIMECMPLO = CLINTTIME->MTIMELO + tick;
     748:	e000c7b7          	lui	a5,0xe000c
     74c:	ff87a783          	lw	a5,-8(a5) # e000bff8 <MTIME_HI_ADDR+0xfffffffc>
     750:	6761                	lui	a4,0x18
     752:	6a070713          	addi	a4,a4,1696 # 186a0 <__erodata+0x135f8>
     756:	97ba                	add	a5,a5,a4
     758:	e0004737          	lui	a4,0xe0004
     75c:	c31c                	sw	a5,0(a4)

    //set interrupt pendding
    for (int i = 0; i < 12; i++) {
        CLIC->INT[i].CLICINTIP = 0;
     75e:	e0800637          	lui	a2,0xe0800
    for (int i = 0; i < 12; i++) {
     762:	4701                	li	a4,0
     764:	46b1                	li	a3,12
        CLIC->INT[i].CLICINTIP = 0;
     766:	40070793          	addi	a5,a4,1024 # e0004400 <MTIME_HI_ADDR+0xffff8404>
     76a:	078a                	slli	a5,a5,0x2
     76c:	97b2                	add	a5,a5,a2
     76e:	00078023          	sb	zero,0(a5)
    for (int i = 0; i < 12; i++) {
     772:	0705                	addi	a4,a4,1
     774:	fed719e3          	bne	a4,a3,766 <system_init+0x26>
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
     778:	451d                	li	a0,7
     77a:	a825                	j	7b2 <drv_irq_enable>

0000077c <CORET_IRQHandler>:

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    //INTRPT_ENTER();
    systick_handler();
     77c:	a809                	j	78e <systick_handler>

0000077e <TIM0_IRQHandler>:
    //INTRPT_EXIT();
}

ATTRIBUTE_ISR void TIM0_IRQHandler(void){
     77e:	1151                	addi	sp,sp,-12
     780:	c406                	sw	ra,8(sp)
    INTRPT_ENTER();
     782:	2299                	jal	8c8 <kos_kernel_intrpt_enter>
    // your ISR code here
    INTRPT_EXIT();
}
     784:	40a2                	lw	ra,8(sp)
     786:	0131                	addi	sp,sp,12
    INTRPT_EXIT();
     788:	aa91                	j	8dc <kos_kernel_intrpt_exit>

0000078a <UART0_IRQHandler>:
     78a:	bfd5                	j	77e <TIM0_IRQHandler>

0000078c <UART1_IRQHandler>:
     78c:	bfcd                	j	77e <TIM0_IRQHandler>

0000078e <systick_handler>:
#include "../../kernel/kos/core/include/k_api.h"
#include "../include/soc.h"

uint64_t g_sys_tick_count;
void systick_handler(void){
    g_sys_tick_count++;
     78e:	200007b7          	lui	a5,0x20000
     792:	2d878793          	addi	a5,a5,728 # 200002d8 <g_sys_tick_count>
     796:	4398                	lw	a4,0(a5)
     798:	43d0                	lw	a2,4(a5)
    printf("core timer interrupt handler \r\n");
     79a:	6511                	lui	a0,0x4
    g_sys_tick_count++;
     79c:	00170693          	addi	a3,a4,1
     7a0:	00e6b733          	sltu	a4,a3,a4
     7a4:	9732                	add	a4,a4,a2
    printf("core timer interrupt handler \r\n");
     7a6:	25050513          	addi	a0,a0,592 # 4250 <sg_uart_config+0x20>
    g_sys_tick_count++;
     7aa:	c394                	sw	a3,0(a5)
     7ac:	c3d8                	sw	a4,4(a5)
    printf("core timer interrupt handler \r\n");
     7ae:	04b0006f          	j	ff8 <puts>

000007b2 <drv_irq_enable>:
#define CLIC           ((CLIC_TypeDef       *) CLIC_BASE)
#define CLIC_I         ((CLIC_INTER_TypeDef *) CLIC_INT)


__STATIC_INLINE void vic_enable_irq(int32_t IRQn){
    CLIC->INT[IRQn].CLICINTIP   = 0x00;
     7b2:	e08017b7          	lui	a5,0xe0801
     7b6:	050a                	slli	a0,a0,0x2
     7b8:	953e                	add	a0,a0,a5
     7ba:	00050023          	sb	zero,0(a0)
    CLIC->INT[IRQn].CLICINTIE   = 0x01;
     7be:	4785                	li	a5,1
     7c0:	00f500a3          	sb	a5,1(a0)
    CLIC->INT[IRQn].CLICINTATTR = 0x01;
     7c4:	00f50123          	sb	a5,2(a0)
    CLIC->INT[IRQn].CLICINTCTRL = 0x7f;
     7c8:	07f00793          	li	a5,127
     7cc:	00f501a3          	sb	a5,3(a0)
extern void Default_Handler(void);
extern void (*g_irqvector[])(void);

void drv_irq_enable (uint32_t irq_num){
    vic_enable_irq(irq_num);
}
     7d0:	8082                	ret

000007d2 <board_init>:
#include "../driver/include/soc.h"

extern uart_handle_t console_handle;

void board_init(void)
{
     7d2:	1151                	addi	sp,sp,-12
    int ret = 0;
    console_handle = drv_uart_initialize(0, NULL);
     7d4:	4581                	li	a1,0
     7d6:	4501                	li	a0,0
{
     7d8:	c406                	sw	ra,8(sp)
    console_handle = drv_uart_initialize(0, NULL);
     7da:	3575                	jal	686 <drv_uart_initialize>
     7dc:	200007b7          	lui	a5,0x20000

    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
     7e0:	460d                	li	a2,3
     7e2:	0d900593          	li	a1,217
    console_handle = drv_uart_initialize(0, NULL);
     7e6:	24a7ae23          	sw	a0,604(a5) # 2000025c <console_handle>
    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
     7ea:	35dd                	jal	6d0 <drv_uart_config_baudrate>

    printf("boad init console uart0 \r\n");

    if(ret < 0 ) { return; }
}
     7ec:	40a2                	lw	ra,8(sp)
    printf("boad init console uart0 \r\n");
     7ee:	6511                	lui	a0,0x4
     7f0:	27050513          	addi	a0,a0,624 # 4270 <sg_uart_config+0x40>
}
     7f4:	0131                	addi	sp,sp,12
    printf("boad init console uart0 \r\n");
     7f6:	0030006f          	j	ff8 <puts>

000007fa <app_init>:
    return 0;
}

void app_init(void){
    //start main thread
    printf("Start Main Thread \r\n");
     7fa:	6511                	lui	a0,0x4
     7fc:	28c50513          	addi	a0,a0,652 # 428c <sg_uart_config+0x5c>
     800:	7f80006f          	j	ff8 <puts>

00000804 <os_startup>:
int os_startup(void){
     804:	1151                	addi	sp,sp,-12
     806:	c222                	sw	s0,4(sp)
    printf("core_int base addr = 0x%08lx\r\n", (unsigned long)&CLIC->INT[7]);
     808:	6511                	lui	a0,0x4
     80a:	e0801437          	lui	s0,0xe0801
     80e:	01c40593          	addi	a1,s0,28 # e080101c <MTIME_HI_ADDR+0x7f5020>
     812:	2a050513          	addi	a0,a0,672 # 42a0 <sg_uart_config+0x70>
int os_startup(void){
     816:	c406                	sw	ra,8(sp)
    printf("core_int base addr = 0x%08lx\r\n", (unsigned long)&CLIC->INT[7]);
     818:	7c0000ef          	jal	ra,fd8 <printf>
    CLIC->INT[IRQn].CLICINTATTR &= 0x00;
    CLIC->INT[IRQn].CLICINTCTRL &= 0x00;
}

__STATIC_INLINE uint8_t vic_get_pend_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTIP);
     81c:	01c44603          	lbu	a2,28(s0)
    printf("core_int.ip   addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTIP,   (uint8_t)vic_get_pend_irq(7));
     820:	6511                	lui	a0,0x4
     822:	01c40593          	addi	a1,s0,28
     826:	0ff67613          	zext.b	a2,a2
     82a:	2c050513          	addi	a0,a0,704 # 42c0 <sg_uart_config+0x90>
     82e:	7aa000ef          	jal	ra,fd8 <printf>
}

__STATIC_INLINE uint8_t vic_get_enable_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTIE & CLIC_INTIE_IE_Msk);
     832:	01d44603          	lbu	a2,29(s0)
    printf("core_int.ie   addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTIE,   (uint8_t)vic_get_enable_irq(7));
     836:	6511                	lui	a0,0x4
     838:	01d40593          	addi	a1,s0,29
     83c:	8a05                	andi	a2,a2,1
     83e:	2f450513          	addi	a0,a0,756 # 42f4 <sg_uart_config+0xc4>
     842:	796000ef          	jal	ra,fd8 <printf>
}

__STATIC_INLINE uint8_t vic_get_attr_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTATTR);
     846:	01e44603          	lbu	a2,30(s0)
    printf("core_int.attr addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTATTR, (uint8_t)vic_get_attr_irq(7));
     84a:	6511                	lui	a0,0x4
     84c:	01e40593          	addi	a1,s0,30
     850:	0ff67613          	zext.b	a2,a2
     854:	32850513          	addi	a0,a0,808 # 4328 <sg_uart_config+0xf8>
     858:	780000ef          	jal	ra,fd8 <printf>
}

__STATIC_INLINE uint8_t vic_get_ctl_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTCTRL);
     85c:	01f44603          	lbu	a2,31(s0)
    printf("core_int.ctl  addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTCTRL, (uint8_t)vic_get_ctl_irq(7));
     860:	6511                	lui	a0,0x4
     862:	01f40593          	addi	a1,s0,31
     866:	0ff67613          	zext.b	a2,a2
     86a:	35c50513          	addi	a0,a0,860 # 435c <sg_uart_config+0x12c>
     86e:	76a000ef          	jal	ra,fd8 <printf>
    app_init();
     872:	3761                	jal	7fa <app_init>
}
     874:	40a2                	lw	ra,8(sp)
     876:	4412                	lw	s0,4(sp)
     878:	4501                	li	a0,0
     87a:	0131                	addi	sp,sp,12
     87c:	8082                	ret

0000087e <entry>:
    printf("Entry OS \r\n");
     87e:	6511                	lui	a0,0x4
int entry(){
     880:	1151                	addi	sp,sp,-12
    printf("Entry OS \r\n");
     882:	39050513          	addi	a0,a0,912 # 4390 <sg_uart_config+0x160>
int entry(){
     886:	c406                	sw	ra,8(sp)
    printf("Entry OS \r\n");
     888:	770000ef          	jal	ra,ff8 <puts>
    os_startup();
     88c:	3fa5                	jal	804 <os_startup>
}
     88e:	40a2                	lw	ra,8(sp)
     890:	4501                	li	a0,0
     892:	0131                	addi	sp,sp,12
     894:	8082                	ret

00000896 <kos_kernel_sched_suspend>:
    }
    return rc;
}

uint32_t kos_kernel_sched_suspend(void){
    if (g_sys_stat != RHINO_RUNNING) {
     896:	200007b7          	lui	a5,0x20000
     89a:	3f47a703          	lw	a4,1012(a5) # 200003f4 <g_sys_stat>
     89e:	478d                	li	a5,3
     8a0:	00f71963          	bne	a4,a5,8b2 <kos_kernel_sched_suspend+0x1c>
uint32_t kos_kernel_sched_suspend(void){
     8a4:	1151                	addi	sp,sp,-12
     8a6:	c406                	sw	ra,8(sp)
        return 0;
    }
    krhino_sched_disable();
     8a8:	2089                	jal	8ea <krhino_sched_disable>
    return 0;
}
     8aa:	40a2                	lw	ra,8(sp)
     8ac:	4501                	li	a0,0
     8ae:	0131                	addi	sp,sp,12
     8b0:	8082                	ret
     8b2:	4501                	li	a0,0
     8b4:	8082                	ret

000008b6 <kos_kernel_sched_resume>:

void kos_kernel_sched_resume(uint32_t sleep_ticks){
    if (g_sys_stat != RHINO_RUNNING) {
     8b6:	200007b7          	lui	a5,0x20000
     8ba:	3f47a703          	lw	a4,1012(a5) # 200003f4 <g_sys_stat>
     8be:	478d                	li	a5,3
     8c0:	00f71363          	bne	a4,a5,8c6 <kos_kernel_sched_resume+0x10>
        return;
    }
    krhino_sched_enable();
     8c4:	a09d                	j	92a <krhino_sched_enable>
}
     8c6:	8082                	ret

000008c8 <kos_kernel_intrpt_enter>:

k_status_t kos_kernel_intrpt_enter(void){
     8c8:	1151                	addi	sp,sp,-12
     8ca:	c406                	sw	ra,8(sp)
    k_status_t ret = krhino_intrpt_enter();
     8cc:	2875                	jal	988 <krhino_intrpt_enter>
        return 0;
    } else {
        return -1;
    }
    return 0;
}
     8ce:	40a2                	lw	ra,8(sp)
    if(ret == RHINO_SUCCESS){
     8d0:	00a03533          	snez	a0,a0
}
     8d4:	40a00533          	neg	a0,a0
     8d8:	0131                	addi	sp,sp,12
     8da:	8082                	ret

000008dc <kos_kernel_intrpt_exit>:

k_status_t kos_kernel_intrpt_exit(void){
     8dc:	1151                	addi	sp,sp,-12
     8de:	c406                	sw	ra,8(sp)
    krhino_intrpt_exit();
     8e0:	28d1                	jal	9b4 <krhino_intrpt_exit>
    return 0;
}
     8e2:	40a2                	lw	ra,8(sp)
     8e4:	4501                	li	a0,0
     8e6:	0131                	addi	sp,sp,12
     8e8:	8082                	ret

000008ea <krhino_sched_disable>:
    for(prio =0; prio<RHINO_CONFIG_PRI_MAX; prio++ ){
        rq->cur_list_item[prio] = NULL;
    }
}

kstat_t krhino_sched_disable(void){
     8ea:	1151                	addi	sp,sp,-12
     8ec:	c406                	sw	ra,8(sp)
    CPSR_ALLOC();

    RHINO_CRITICAL_ENTER();
     8ee:	39bd                	jal	56c <cpu_intrpt_save>

    INTRPT_NESTED_LEVEL_CHK();
     8f0:	200007b7          	lui	a5,0x20000
     8f4:	3e87c783          	lbu	a5,1000(a5) # 200003e8 <g_intrpt_nested_level>
     8f8:	c799                	beqz	a5,906 <krhino_sched_disable+0x1c>
     8fa:	39b5                	jal	576 <cpu_intrpt_restore>
     8fc:	3ea00513          	li	a0,1002
    }

    g_sched_lock[cpu_cur_get()]++;
    RHINO_CRITICAL_EXIT();
    return RHINO_SUCCESS;
}
     900:	40a2                	lw	ra,8(sp)
     902:	0131                	addi	sp,sp,12
     904:	8082                	ret
    if (g_sched_lock[cpu_cur_get()] >= SCHED_MAX_LOCK_COUNT) {
     906:	20000737          	lui	a4,0x20000
     90a:	3f074783          	lbu	a5,1008(a4) # 200003f0 <g_sched_lock>
     90e:	0c700693          	li	a3,199
     912:	00f6f663          	bgeu	a3,a5,91e <krhino_sched_disable+0x34>
        RHINO_CRITICAL_EXIT();
     916:	3185                	jal	576 <cpu_intrpt_restore>
        return 202;/*RHINO_SCHED_LOCK_COUNT_OVF;*/
     918:	0ca00513          	li	a0,202
     91c:	b7d5                	j	900 <krhino_sched_disable+0x16>
    g_sched_lock[cpu_cur_get()]++;
     91e:	0785                	addi	a5,a5,1
     920:	3ef70823          	sb	a5,1008(a4)
    RHINO_CRITICAL_EXIT();
     924:	3989                	jal	576 <cpu_intrpt_restore>
    return RHINO_SUCCESS;
     926:	4501                	li	a0,0
     928:	bfe1                	j	900 <krhino_sched_disable+0x16>

0000092a <krhino_sched_enable>:

kstat_t krhino_sched_enable(void){
     92a:	1151                	addi	sp,sp,-12
     92c:	c406                	sw	ra,8(sp)
    CPSR_ALLOC();

    RHINO_CRITICAL_ENTER();
     92e:	393d                	jal	56c <cpu_intrpt_save>

    INTRPT_NESTED_LEVEL_CHK();
     930:	200007b7          	lui	a5,0x20000
     934:	3e87c783          	lbu	a5,1000(a5) # 200003e8 <g_intrpt_nested_level>
     938:	c799                	beqz	a5,946 <krhino_sched_enable+0x1c>
     93a:	3935                	jal	576 <cpu_intrpt_restore>
     93c:	3ea00513          	li	a0,1002
        return 200;/*RHINO_SCHED_ALREADY_DISABLE;*/
    }

    RHINO_CRITICAL_EXIT_SCHED();
    return RHINO_SUCCESS;
}
     940:	40a2                	lw	ra,8(sp)
     942:	0131                	addi	sp,sp,12
     944:	8082                	ret
    if (g_sched_lock[cpu_cur_get()] == 0u ) {
     946:	20000737          	lui	a4,0x20000
     94a:	3f074783          	lbu	a5,1008(a4) # 200003f0 <g_sched_lock>
     94e:	e789                	bnez	a5,958 <krhino_sched_enable+0x2e>
        RHINO_CRITICAL_EXIT();
     950:	311d                	jal	576 <cpu_intrpt_restore>
        return 201;/*RHINO_SCHED_ALREADY_ENABLED;*/
     952:	0c900513          	li	a0,201
     956:	b7ed                	j	940 <krhino_sched_enable+0x16>
    g_sched_lock[cpu_cur_get()]--;
     958:	17fd                	addi	a5,a5,-1
     95a:	0ff7f793          	zext.b	a5,a5
     95e:	3ef70823          	sb	a5,1008(a4)
    if (g_sched_lock[cpu_cur_get()] > 0u ) {
     962:	c789                	beqz	a5,96c <krhino_sched_enable+0x42>
        RHINO_CRITICAL_EXIT();
     964:	3909                	jal	576 <cpu_intrpt_restore>
        return 200;/*RHINO_SCHED_ALREADY_DISABLE;*/
     966:	0c800513          	li	a0,200
     96a:	bfd9                	j	940 <krhino_sched_enable+0x16>
    RHINO_CRITICAL_EXIT_SCHED();
     96c:	3129                	jal	576 <cpu_intrpt_restore>
    return RHINO_SUCCESS;
     96e:	4501                	li	a0,0
     970:	bfc1                	j	940 <krhino_sched_enable+0x16>

00000972 <preferred_cpu_ready_task_get>:
        ready_list_add_head(rq,task );
    }
}

void preferred_cpu_ready_task_get(runqueue_t *rq, uint8_t cpu_num){
    klist_t *node = rq->cur_list_item[rq->highest_pri];
     972:	10054783          	lbu	a5,256(a0)
    g_preferred_ready_task[cpu_cur_get()] = krhino_list_entry(node, ktask_t ,task_list );
     976:	20000737          	lui	a4,0x20000
    klist_t *node = rq->cur_list_item[rq->highest_pri];
     97a:	078a                	slli	a5,a5,0x2
     97c:	953e                	add	a0,a0,a5
    g_preferred_ready_task[cpu_cur_get()] = krhino_list_entry(node, ktask_t ,task_list );
     97e:	411c                	lw	a5,0(a0)
     980:	17d1                	addi	a5,a5,-12
     982:	3ef72623          	sw	a5,1004(a4) # 200003ec <g_preferred_ready_task>
}
     986:	8082                	ret

00000988 <krhino_intrpt_enter>:
        return RHINO_SYS_FATAL_ERR;
    }
    return RHINO_SUCCESS;
}

kstat_t krhino_intrpt_enter(void){
     988:	1151                	addi	sp,sp,-12
     98a:	c406                	sw	ra,8(sp)
    CPSR_ALLOC();
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
     98c:	36c5                	jal	56c <cpu_intrpt_save>
    cur_cpu_num = cpu_cur_get();
    if(g_intrpt_nested_level[cur_cpu_num] > RHINO_CONFIG_INTRPT_MAX_NESTED_LEVEL){
     98e:	20000737          	lui	a4,0x20000
     992:	3e874783          	lbu	a5,1000(a4) # 200003e8 <g_intrpt_nested_level>
     996:	0bc00693          	li	a3,188
     99a:	00f6f763          	bgeu	a3,a5,9a8 <krhino_intrpt_enter+0x20>
        RHINO_CPU_INTRPT_ENABLE();
     99e:	3ee1                	jal	576 <cpu_intrpt_restore>
        return -1;
     9a0:	557d                	li	a0,-1
    }
    g_intrpt_nested_level[cur_cpu_num]++;
    RHINO_CPU_INTRPT_ENABLE();
    return RHINO_SUCCESS;
}
     9a2:	40a2                	lw	ra,8(sp)
     9a4:	0131                	addi	sp,sp,12
     9a6:	8082                	ret
    g_intrpt_nested_level[cur_cpu_num]++;
     9a8:	0785                	addi	a5,a5,1
     9aa:	3ef70423          	sb	a5,1000(a4)
    RHINO_CPU_INTRPT_ENABLE();
     9ae:	36e1                	jal	576 <cpu_intrpt_restore>
    return RHINO_SUCCESS;
     9b0:	4501                	li	a0,0
     9b2:	bfc5                	j	9a2 <krhino_intrpt_enter+0x1a>

000009b4 <krhino_intrpt_exit>:

void krhino_intrpt_exit(void){
     9b4:	1151                	addi	sp,sp,-12
     9b6:	c222                	sw	s0,4(sp)
     9b8:	c026                	sw	s1,0(sp)
     9ba:	c406                	sw	ra,8(sp)
    uint8_t cur_cpu_num;

    RHINO_CPU_INTRPT_DISABLE();
    cur_cpu_num = cpu_cur_get();

    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
     9bc:	200004b7          	lui	s1,0x20000
    RHINO_CPU_INTRPT_DISABLE();
     9c0:	3675                	jal	56c <cpu_intrpt_save>
    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
     9c2:	3e84c783          	lbu	a5,1000(s1) # 200003e8 <g_intrpt_nested_level>
    RHINO_CPU_INTRPT_DISABLE();
     9c6:	842a                	mv	s0,a0
    if(g_intrpt_nested_level[cur_cpu_num] == 0u){
     9c8:	e391                	bnez	a5,9cc <krhino_intrpt_exit+0x18>
        RHINO_CPU_INTRPT_ENABLE();
     9ca:	3675                	jal	576 <cpu_intrpt_restore>
        //error
    }

    g_intrpt_nested_level[cur_cpu_num]--;
     9cc:	3e84c783          	lbu	a5,1000(s1)
     9d0:	17fd                	addi	a5,a5,-1
     9d2:	0ff7f793          	zext.b	a5,a5
     9d6:	3ef48423          	sb	a5,1000(s1)

    if(g_intrpt_nested_level[cur_cpu_num] > 0u){
     9da:	c799                	beqz	a5,9e8 <krhino_intrpt_exit+0x34>
        RHINO_CPU_INTRPT_ENABLE();
        return;
    }
    /* switch between g_active_task and g_preferred_ready_task*/
    cpu_intrpt_switch();
    RHINO_CPU_INTRPT_ENABLE();
     9dc:	8522                	mv	a0,s0
}
     9de:	4412                	lw	s0,4(sp)
     9e0:	40a2                	lw	ra,8(sp)
     9e2:	4482                	lw	s1,0(sp)
     9e4:	0131                	addi	sp,sp,12
    RHINO_CPU_INTRPT_ENABLE();
     9e6:	be41                	j	576 <cpu_intrpt_restore>
    if(g_sched_lock[cur_cpu_num] > 0u){
     9e8:	200007b7          	lui	a5,0x20000
     9ec:	3f07c783          	lbu	a5,1008(a5) # 200003f0 <g_sched_lock>
     9f0:	f7f5                	bnez	a5,9dc <krhino_intrpt_exit+0x28>
    preferred_cpu_ready_task_get(&g_ready_queue, cur_cpu_num);
     9f2:	20000537          	lui	a0,0x20000
     9f6:	4581                	li	a1,0
     9f8:	2e050513          	addi	a0,a0,736 # 200002e0 <g_ready_queue>
     9fc:	3f9d                	jal	972 <preferred_cpu_ready_task_get>
    if(g_preferred_ready_task[cur_cpu_num] == g_active_task[cur_cpu_num]){
     9fe:	200007b7          	lui	a5,0x20000
     a02:	3ec7a703          	lw	a4,1004(a5) # 200003ec <g_preferred_ready_task>
     a06:	200007b7          	lui	a5,0x20000
     a0a:	3e47a783          	lw	a5,996(a5) # 200003e4 <g_active_task>
     a0e:	fcf707e3          	beq	a4,a5,9dc <krhino_intrpt_exit+0x28>
    cpu_intrpt_switch();
     a12:	3671                	jal	59e <cpu_intrpt_switch>
     a14:	b7e1                	j	9dc <krhino_intrpt_exit+0x28>

00000a16 <copystring>:
     a16:	87aa                	mv	a5,a0
     a18:	470d                	li	a4,3
     a1a:	4501                	li	a0,0
     a1c:	00b54363          	blt	a0,a1,a22 <copystring+0xc>
     a20:	8082                	ret
     a22:	00a606b3          	add	a3,a2,a0
     a26:	0006c303          	lbu	t1,0(a3)
     a2a:	00a786b3          	add	a3,a5,a0
     a2e:	0505                	addi	a0,a0,1
     a30:	00668023          	sb	t1,0(a3)
     a34:	fee514e3          	bne	a0,a4,a1c <copystring+0x6>
     a38:	00b55563          	bge	a0,a1,a42 <copystring+0x2c>
     a3c:	000781a3          	sb	zero,3(a5)
     a40:	4511                	li	a0,4
     a42:	8082                	ret

00000a44 <__dtostr>:
     a44:	fa810113          	addi	sp,sp,-88
     a48:	c6a6                	sw	s1,76(sp)
     a4a:	ca86                	sw	ra,84(sp)
     a4c:	c8a2                	sw	s0,80(sp)
     a4e:	cc2a                	sw	a0,24(sp)
     a50:	c42e                	sw	a1,8(sp)
     a52:	c032                	sw	a2,0(sp)
     a54:	84b6                	mv	s1,a3
     a56:	d43a                	sw	a4,40(sp)
     a58:	c23e                	sw	a5,4(sp)
     a5a:	2ec5                	jal	e4a <__isinf>
     a5c:	cd01                	beqz	a0,a74 <__dtostr+0x30>
     a5e:	6611                	lui	a2,0x4
     a60:	39c60613          	addi	a2,a2,924 # 439c <sg_uart_config+0x16c>
     a64:	4446                	lw	s0,80(sp)
     a66:	4502                	lw	a0,0(sp)
     a68:	40d6                	lw	ra,84(sp)
     a6a:	85a6                	mv	a1,s1
     a6c:	44b6                	lw	s1,76(sp)
     a6e:	05810113          	addi	sp,sp,88
     a72:	b755                	j	a16 <copystring>
     a74:	4762                	lw	a4,24(sp)
     a76:	47a2                	lw	a5,8(sp)
     a78:	853a                	mv	a0,a4
     a7a:	85be                	mv	a1,a5
     a7c:	26fd                	jal	e6a <__isnan>
     a7e:	d22a                	sw	a0,36(sp)
     a80:	c509                	beqz	a0,a8a <__dtostr+0x46>
     a82:	6611                	lui	a2,0x4
     a84:	3a060613          	addi	a2,a2,928 # 43a0 <sg_uart_config+0x170>
     a88:	bff1                	j	a64 <__dtostr+0x20>
     a8a:	4762                	lw	a4,24(sp)
     a8c:	47a2                	lw	a5,8(sp)
     a8e:	4601                	li	a2,0
     a90:	4681                	li	a3,0
     a92:	853a                	mv	a0,a4
     a94:	85be                	mv	a1,a5
     a96:	229020ef          	jal	ra,34be <__eqdf2>
     a9a:	e141                	bnez	a0,b1a <__dtostr+0xd6>
     a9c:	4792                	lw	a5,4(sp)
     a9e:	3a078163          	beqz	a5,e40 <__dtostr+0x3fc>
     aa2:	00278513          	addi	a0,a5,2
     aa6:	06a4e863          	bltu	s1,a0,b16 <__dtostr+0xd2>
     aaa:	c915                	beqz	a0,ade <__dtostr+0x9a>
     aac:	47a2                	lw	a5,8(sp)
     aae:	4401                	li	s0,0
     ab0:	0007db63          	bgez	a5,ac6 <__dtostr+0x82>
     ab4:	4702                	lw	a4,0(sp)
     ab6:	02d00793          	li	a5,45
     aba:	0505                	addi	a0,a0,1
     abc:	00f70023          	sb	a5,0(a4)
     ac0:	4405                	li	s0,1
     ac2:	4481                	li	s1,0
     ac4:	c119                	beqz	a0,aca <__dtostr+0x86>
     ac6:	408504b3          	sub	s1,a0,s0
     aca:	4782                	lw	a5,0(sp)
     acc:	8626                	mv	a2,s1
     ace:	03000593          	li	a1,48
     ad2:	00878533          	add	a0,a5,s0
     ad6:	54e010ef          	jal	ra,2024 <memset>
     ada:	00848533          	add	a0,s1,s0
     ade:	4782                	lw	a5,0(sp)
     ae0:	03000713          	li	a4,48
     ae4:	0007c683          	lbu	a3,0(a5)
     ae8:	4785                	li	a5,1
     aea:	00e68363          	beq	a3,a4,af0 <__dtostr+0xac>
     aee:	4789                	li	a5,2
     af0:	4702                	lw	a4,0(sp)
     af2:	d22a                	sw	a0,36(sp)
     af4:	97ba                	add	a5,a5,a4
     af6:	02e00713          	li	a4,46
     afa:	00e78023          	sb	a4,0(a5)
     afe:	4782                	lw	a5,0(sp)
     b00:	00a78633          	add	a2,a5,a0
     b04:	00060023          	sb	zero,0(a2)
     b08:	40d6                	lw	ra,84(sp)
     b0a:	4446                	lw	s0,80(sp)
     b0c:	5512                	lw	a0,36(sp)
     b0e:	44b6                	lw	s1,76(sp)
     b10:	05810113          	addi	sp,sp,88
     b14:	8082                	ret
     b16:	4521                	li	a0,8
     b18:	bf51                	j	aac <__dtostr+0x68>
     b1a:	4762                	lw	a4,24(sp)
     b1c:	47a2                	lw	a5,8(sp)
     b1e:	4601                	li	a2,0
     b20:	4681                	li	a3,0
     b22:	853a                	mv	a0,a4
     b24:	85be                	mv	a1,a5
     b26:	2c1020ef          	jal	ra,35e6 <__ledf2>
     b2a:	16055b63          	bgez	a0,ca0 <__dtostr+0x25c>
     b2e:	47a2                	lw	a5,8(sp)
     b30:	4702                	lw	a4,0(sp)
     b32:	80000337          	lui	t1,0x80000
     b36:	00f34333          	xor	t1,t1,a5
     b3a:	02d00793          	li	a5,45
     b3e:	00f70023          	sb	a5,0(a4)
     b42:	14fd                	addi	s1,s1,-1
     b44:	00170413          	addi	s0,a4,1
     b48:	6795                	lui	a5,0x5
     b4a:	0a87a503          	lw	a0,168(a5) # 50a8 <__erodata>
     b4e:	0ac7a583          	lw	a1,172(a5)
     b52:	6795                	lui	a5,0x5
     b54:	0b87a703          	lw	a4,184(a5) # 50b8 <__erodata+0x10>
     b58:	0bc7a783          	lw	a5,188(a5)
     b5c:	4281                	li	t0,0
     b5e:	c83a                	sw	a4,16(sp)
     b60:	ca3e                	sw	a5,20(sp)
     b62:	4792                	lw	a5,4(sp)
     b64:	14f29163          	bne	t0,a5,ca6 <__dtostr+0x262>
     b68:	4762                	lw	a4,24(sp)
     b6a:	862a                	mv	a2,a0
     b6c:	86ae                	mv	a3,a1
     b6e:	853a                	mv	a0,a4
     b70:	859a                	mv	a1,t1
     b72:	5c9010ef          	jal	ra,293a <__adddf3>
     b76:	6795                	lui	a5,0x5
     b78:	0c07a603          	lw	a2,192(a5) # 50c0 <__erodata+0x18>
     b7c:	0c47a683          	lw	a3,196(a5)
     b80:	ce2a                	sw	a0,28(sp)
     b82:	d02e                	sw	a1,32(sp)
     b84:	263020ef          	jal	ra,35e6 <__ledf2>
     b88:	00055863          	bgez	a0,b98 <__dtostr+0x154>
     b8c:	03000793          	li	a5,48
     b90:	00f40023          	sb	a5,0(s0)
     b94:	14fd                	addi	s1,s1,-1
     b96:	0405                	addi	s0,s0,1
     b98:	47a2                	lw	a5,8(sp)
     b9a:	0147d513          	srli	a0,a5,0x14
     b9e:	7ff57513          	andi	a0,a0,2047
     ba2:	c0150513          	addi	a0,a0,-1023
     ba6:	5dc030ef          	jal	ra,4182 <__floatsidf>
     baa:	6795                	lui	a5,0x5
     bac:	0c87a603          	lw	a2,200(a5) # 50c8 <__erodata+0x20>
     bb0:	0cc7a683          	lw	a3,204(a5)
     bb4:	2e1020ef          	jal	ra,3694 <__muldf3>
     bb8:	566030ef          	jal	ra,411e <__fixdfsi>
     bbc:	00150793          	addi	a5,a0,1
     bc0:	c83e                	sw	a5,16(sp)
     bc2:	20f05b63          	blez	a5,dd8 <__dtostr+0x394>
     bc6:	6695                	lui	a3,0x5
     bc8:	0b06a703          	lw	a4,176(a3) # 50b0 <__erodata+0x8>
     bcc:	0b46a303          	lw	t1,180(a3)
     bd0:	6695                	lui	a3,0x5
     bd2:	0d06a603          	lw	a2,208(a3) # 50d0 <__erodata+0x28>
     bd6:	0d46a683          	lw	a3,212(a3)
     bda:	42a9                	li	t0,10
     bdc:	d632                	sw	a2,44(sp)
     bde:	d836                	sw	a3,48(sp)
     be0:	0cf2ed63          	bltu	t0,a5,cba <__dtostr+0x276>
     be4:	6695                	lui	a3,0x5
     be6:	0b06a603          	lw	a2,176(a3) # 50b0 <__erodata+0x8>
     bea:	0b46a683          	lw	a3,180(a3)
     bee:	4285                	li	t0,1
     bf0:	d632                	sw	a2,44(sp)
     bf2:	d836                	sw	a3,48(sp)
     bf4:	0e579063          	bne	a5,t0,cd4 <__dtostr+0x290>
     bf8:	4785                	li	a5,1
     bfa:	d63e                	sw	a5,44(sp)
     bfc:	6795                	lui	a5,0x5
     bfe:	0d87a603          	lw	a2,216(a5) # 50d8 <__erodata+0x30>
     c02:	0dc7a683          	lw	a3,220(a5)
     c06:	6795                	lui	a5,0x5
     c08:	da32                	sw	a2,52(sp)
     c0a:	dc36                	sw	a3,56(sp)
     c0c:	0b07a603          	lw	a2,176(a5) # 50b0 <__erodata+0x8>
     c10:	0b47a683          	lw	a3,180(a5)
     c14:	de32                	sw	a2,60(sp)
     c16:	c0b6                	sw	a3,64(sp)
     c18:	5652                	lw	a2,52(sp)
     c1a:	56e2                	lw	a3,56(sp)
     c1c:	853a                	mv	a0,a4
     c1e:	859a                	mv	a1,t1
     c20:	c4ba                	sw	a4,72(sp)
     c22:	c29a                	sw	t1,68(sp)
     c24:	115020ef          	jal	ra,3538 <__gedf2>
     c28:	4316                	lw	t1,68(sp)
     c2a:	4726                	lw	a4,72(sp)
     c2c:	0ca04163          	bgtz	a0,cee <__dtostr+0x2aa>
     c30:	4782                	lw	a5,0(sp)
     c32:	00f41a63          	bne	s0,a5,c46 <__dtostr+0x202>
     c36:	ec0489e3          	beqz	s1,b08 <__dtostr+0xc4>
     c3a:	03000793          	li	a5,48
     c3e:	00f40023          	sb	a5,0(s0)
     c42:	14fd                	addi	s1,s1,-1
     c44:	0405                	addi	s0,s0,1
     c46:	4792                	lw	a5,4(sp)
     c48:	eb81                	bnez	a5,c58 <__dtostr+0x214>
     c4a:	4782                	lw	a5,0(sp)
     c4c:	56a2                	lw	a3,40(sp)
     c4e:	40f407b3          	sub	a5,s0,a5
     c52:	0785                	addi	a5,a5,1
     c54:	12d7f963          	bgeu	a5,a3,d86 <__dtostr+0x342>
     c58:	ea0488e3          	beqz	s1,b08 <__dtostr+0xc4>
     c5c:	02e00793          	li	a5,46
     c60:	00f40023          	sb	a5,0(s0)
     c64:	4792                	lw	a5,4(sp)
     c66:	fff48693          	addi	a3,s1,-1
     c6a:	00140493          	addi	s1,s0,1
     c6e:	eb81                	bnez	a5,c7e <__dtostr+0x23a>
     c70:	57a2                	lw	a5,40(sp)
     c72:	4602                	lw	a2,0(sp)
     c74:	0785                	addi	a5,a5,1
     c76:	40c48633          	sub	a2,s1,a2
     c7a:	8f91                	sub	a5,a5,a2
     c7c:	c23e                	sw	a5,4(sp)
     c7e:	4792                	lw	a5,4(sp)
     c80:	e8f6e4e3          	bltu	a3,a5,b08 <__dtostr+0xc4>
     c84:	6695                	lui	a3,0x5
     c86:	0b06a603          	lw	a2,176(a3) # 50b0 <__erodata+0x8>
     c8a:	0b46a683          	lw	a3,180(a3)
     c8e:	97a2                	add	a5,a5,s0
     c90:	c432                	sw	a2,8(sp)
     c92:	c636                	sw	a3,12(sp)
     c94:	14f41863          	bne	s0,a5,de4 <__dtostr+0x3a0>
     c98:	4792                	lw	a5,4(sp)
     c9a:	00f48433          	add	s0,s1,a5
     c9e:	a0e5                	j	d86 <__dtostr+0x342>
     ca0:	4402                	lw	s0,0(sp)
     ca2:	4322                	lw	t1,8(sp)
     ca4:	b555                	j	b48 <__dtostr+0x104>
     ca6:	4642                	lw	a2,16(sp)
     ca8:	46d2                	lw	a3,20(sp)
     caa:	d01a                	sw	t1,32(sp)
     cac:	ce16                	sw	t0,28(sp)
     cae:	1e7020ef          	jal	ra,3694 <__muldf3>
     cb2:	42f2                	lw	t0,28(sp)
     cb4:	5302                	lw	t1,32(sp)
     cb6:	0285                	addi	t0,t0,1
     cb8:	b56d                	j	b62 <__dtostr+0x11e>
     cba:	5632                	lw	a2,44(sp)
     cbc:	56c2                	lw	a3,48(sp)
     cbe:	853a                	mv	a0,a4
     cc0:	859a                	mv	a1,t1
     cc2:	da3e                	sw	a5,52(sp)
     cc4:	1d1020ef          	jal	ra,3694 <__muldf3>
     cc8:	57d2                	lw	a5,52(sp)
     cca:	872a                	mv	a4,a0
     ccc:	832e                	mv	t1,a1
     cce:	17d9                	addi	a5,a5,-10
     cd0:	42a9                	li	t0,10
     cd2:	b739                	j	be0 <__dtostr+0x19c>
     cd4:	5632                	lw	a2,44(sp)
     cd6:	56c2                	lw	a3,48(sp)
     cd8:	853a                	mv	a0,a4
     cda:	859a                	mv	a1,t1
     cdc:	da3e                	sw	a5,52(sp)
     cde:	1b7020ef          	jal	ra,3694 <__muldf3>
     ce2:	57d2                	lw	a5,52(sp)
     ce4:	872a                	mv	a4,a0
     ce6:	832e                	mv	t1,a1
     ce8:	17fd                	addi	a5,a5,-1
     cea:	4285                	li	t0,1
     cec:	b721                	j	bf4 <__dtostr+0x1b0>
     cee:	4572                	lw	a0,28(sp)
     cf0:	5582                	lw	a1,32(sp)
     cf2:	869a                	mv	a3,t1
     cf4:	863a                	mv	a2,a4
     cf6:	c4ba                	sw	a4,72(sp)
     cf8:	c29a                	sw	t1,68(sp)
     cfa:	236020ef          	jal	ra,2f30 <__divdf3>
     cfe:	420030ef          	jal	ra,411e <__fixdfsi>
     d02:	56b2                	lw	a3,44(sp)
     d04:	4316                	lw	t1,68(sp)
     d06:	4726                	lw	a4,72(sp)
     d08:	0ff57793          	zext.b	a5,a0
     d0c:	c291                	beqz	a3,d10 <__dtostr+0x2cc>
     d0e:	cfc5                	beqz	a5,dc6 <__dtostr+0x382>
     d10:	03078793          	addi	a5,a5,48
     d14:	00f40023          	sb	a5,0(s0)
     d18:	0405                	addi	s0,s0,1
     d1a:	ecad                	bnez	s1,d94 <__dtostr+0x350>
     d1c:	47a2                	lw	a5,8(sp)
     d1e:	863a                	mv	a2,a4
     d20:	4762                	lw	a4,24(sp)
     d22:	869a                	mv	a3,t1
     d24:	85be                	mv	a1,a5
     d26:	853a                	mv	a0,a4
     d28:	208020ef          	jal	ra,2f30 <__divdf3>
     d2c:	4792                	lw	a5,4(sp)
     d2e:	5722                	lw	a4,40(sp)
     d30:	4602                	lw	a2,0(sp)
     d32:	4681                	li	a3,0
     d34:	3b01                	jal	a44 <__dtostr>
     d36:	dc0509e3          	beqz	a0,b08 <__dtostr+0xc4>
     d3a:	942a                	add	s0,s0,a0
     d3c:	06500793          	li	a5,101
     d40:	00f40023          	sb	a5,0(s0)
     d44:	fff54513          	not	a0,a0
     d48:	0405                	addi	s0,s0,1
     d4a:	4711                	li	a4,4
     d4c:	4685                	li	a3,1
     d4e:	3e800793          	li	a5,1000
     d52:	4629                	li	a2,10
     d54:	45c2                	lw	a1,16(sp)
     d56:	00f5d363          	bge	a1,a5,d5c <__dtostr+0x318>
     d5a:	e285                	bnez	a3,d7a <__dtostr+0x336>
     d5c:	c909                	beqz	a0,d6e <__dtostr+0x32a>
     d5e:	46c2                	lw	a3,16(sp)
     d60:	0405                	addi	s0,s0,1
     d62:	02f6c6b3          	div	a3,a3,a5
     d66:	03068693          	addi	a3,a3,48
     d6a:	fed40fa3          	sb	a3,-1(s0)
     d6e:	46c2                	lw	a3,16(sp)
     d70:	157d                	addi	a0,a0,-1
     d72:	02f6e6b3          	rem	a3,a3,a5
     d76:	c836                	sw	a3,16(sp)
     d78:	4681                	li	a3,0
     d7a:	177d                	addi	a4,a4,-1
     d7c:	02c7c7b3          	div	a5,a5,a2
     d80:	fb71                	bnez	a4,d54 <__dtostr+0x310>
     d82:	d80503e3          	beqz	a0,b08 <__dtostr+0xc4>
     d86:	4782                	lw	a5,0(sp)
     d88:	00040023          	sb	zero,0(s0)
     d8c:	40f407b3          	sub	a5,s0,a5
     d90:	d23e                	sw	a5,36(sp)
     d92:	bb9d                	j	b08 <__dtostr+0xc4>
     d94:	0ff57513          	zext.b	a0,a0
     d98:	c29a                	sw	t1,68(sp)
     d9a:	d63a                	sw	a4,44(sp)
     d9c:	3e6030ef          	jal	ra,4182 <__floatsidf>
     da0:	5732                	lw	a4,44(sp)
     da2:	4316                	lw	t1,68(sp)
     da4:	14fd                	addi	s1,s1,-1
     da6:	863a                	mv	a2,a4
     da8:	869a                	mv	a3,t1
     daa:	c4ba                	sw	a4,72(sp)
     dac:	0e9020ef          	jal	ra,3694 <__muldf3>
     db0:	862a                	mv	a2,a0
     db2:	86ae                	mv	a3,a1
     db4:	4572                	lw	a0,28(sp)
     db6:	5582                	lw	a1,32(sp)
     db8:	55b020ef          	jal	ra,3b12 <__subdf3>
     dbc:	4726                	lw	a4,72(sp)
     dbe:	4316                	lw	t1,68(sp)
     dc0:	ce2a                	sw	a0,28(sp)
     dc2:	d02e                	sw	a1,32(sp)
     dc4:	d602                	sw	zero,44(sp)
     dc6:	5672                	lw	a2,60(sp)
     dc8:	4686                	lw	a3,64(sp)
     dca:	853a                	mv	a0,a4
     dcc:	859a                	mv	a1,t1
     dce:	162020ef          	jal	ra,2f30 <__divdf3>
     dd2:	872a                	mv	a4,a0
     dd4:	832e                	mv	t1,a1
     dd6:	b589                	j	c18 <__dtostr+0x1d4>
     dd8:	6795                	lui	a5,0x5
     dda:	0b87a703          	lw	a4,184(a5) # 50b8 <__erodata+0x10>
     dde:	0bc7a303          	lw	t1,188(a5)
     de2:	b5b9                	j	c30 <__dtostr+0x1ec>
     de4:	4572                	lw	a0,28(sp)
     de6:	5582                	lw	a1,32(sp)
     de8:	863a                	mv	a2,a4
     dea:	869a                	mv	a3,t1
     dec:	d23e                	sw	a5,36(sp)
     dee:	cc3a                	sw	a4,24(sp)
     df0:	c81a                	sw	t1,16(sp)
     df2:	13e020ef          	jal	ra,2f30 <__divdf3>
     df6:	328030ef          	jal	ra,411e <__fixdfsi>
     dfa:	03050693          	addi	a3,a0,48
     dfe:	00d400a3          	sb	a3,1(s0)
     e02:	0ff57513          	zext.b	a0,a0
     e06:	37c030ef          	jal	ra,4182 <__floatsidf>
     e0a:	4762                	lw	a4,24(sp)
     e0c:	4342                	lw	t1,16(sp)
     e0e:	0405                	addi	s0,s0,1
     e10:	863a                	mv	a2,a4
     e12:	869a                	mv	a3,t1
     e14:	081020ef          	jal	ra,3694 <__muldf3>
     e18:	862a                	mv	a2,a0
     e1a:	86ae                	mv	a3,a1
     e1c:	4572                	lw	a0,28(sp)
     e1e:	5582                	lw	a1,32(sp)
     e20:	4f3020ef          	jal	ra,3b12 <__subdf3>
     e24:	4762                	lw	a4,24(sp)
     e26:	4342                	lw	t1,16(sp)
     e28:	4622                	lw	a2,8(sp)
     e2a:	46b2                	lw	a3,12(sp)
     e2c:	ce2a                	sw	a0,28(sp)
     e2e:	d02e                	sw	a1,32(sp)
     e30:	853a                	mv	a0,a4
     e32:	859a                	mv	a1,t1
     e34:	0fc020ef          	jal	ra,2f30 <__divdf3>
     e38:	5792                	lw	a5,36(sp)
     e3a:	872a                	mv	a4,a0
     e3c:	832e                	mv	t1,a1
     e3e:	bd99                	j	c94 <__dtostr+0x250>
     e40:	4521                	li	a0,8
     e42:	c60485e3          	beqz	s1,aac <__dtostr+0x68>
     e46:	4505                	li	a0,1
     e48:	b195                	j	aac <__dtostr+0x68>

00000e4a <__isinf>:
     e4a:	e509                	bnez	a0,e54 <__isinf+0xa>
     e4c:	7ff007b7          	lui	a5,0x7ff00
     e50:	00f58b63          	beq	a1,a5,e66 <__isinf+0x1c>
     e54:	fff007b7          	lui	a5,0xfff00
     e58:	8dbd                	xor	a1,a1,a5
     e5a:	8d4d                	or	a0,a0,a1
     e5c:	00153513          	seqz	a0,a0
     e60:	40a00533          	neg	a0,a0
     e64:	8082                	ret
     e66:	4505                	li	a0,1
     e68:	8082                	ret

00000e6a <__isnan>:
     e6a:	fff807b7          	lui	a5,0xfff80
     e6e:	17fd                	addi	a5,a5,-1
     e70:	8fed                	and	a5,a5,a1
     e72:	e509                	bnez	a0,e7c <__isnan+0x12>
     e74:	7ff00737          	lui	a4,0x7ff00
     e78:	00e78963          	beq	a5,a4,e8a <__isnan+0x20>
     e7c:	fff807b7          	lui	a5,0xfff80
     e80:	8dbd                	xor	a1,a1,a5
     e82:	8d4d                	or	a0,a0,a1
     e84:	00153513          	seqz	a0,a0
     e88:	8082                	ret
     e8a:	4505                	li	a0,1
     e8c:	8082                	ret

00000e8e <__lltostr>:
     e8e:	fdc10113          	addi	sp,sp,-36
     e92:	15fd                	addi	a1,a1,-1
     e94:	d006                	sw	ra,32(sp)
     e96:	ce22                	sw	s0,28(sp)
     e98:	cc26                	sw	s1,24(sp)
     e9a:	8336                	mv	t1,a3
     e9c:	86be                	mv	a3,a5
     e9e:	00b507b3          	add	a5,a0,a1
     ea2:	00078023          	sb	zero,0(a5) # fff80000 <MTIME_HI_ADDR+0x1ff74004>
     ea6:	83aa                	mv	t2,a0
     ea8:	82b2                	mv	t0,a2
     eaa:	c711                	beqz	a4,eb6 <__lltostr+0x28>
     eac:	863a                	mv	a2,a4
     eae:	02400713          	li	a4,36
     eb2:	00c75363          	bge	a4,a2,eb8 <__lltostr+0x2a>
     eb6:	4629                	li	a2,10
     eb8:	0062e733          	or	a4,t0,t1
     ebc:	4401                	li	s0,0
     ebe:	e719                	bnez	a4,ecc <__lltostr+0x3e>
     ec0:	03000713          	li	a4,48
     ec4:	fee78fa3          	sb	a4,-1(a5)
     ec8:	4405                	li	s0,1
     eca:	17fd                	addi	a5,a5,-1
     ecc:	02700713          	li	a4,39
     ed0:	c291                	beqz	a3,ed4 <__lltostr+0x46>
     ed2:	471d                	li	a4,7
     ed4:	c03a                	sw	a4,0(sp)
     ed6:	84be                	mv	s1,a5
     ed8:	943e                	add	s0,s0,a5
     eda:	41f65693          	srai	a3,a2,0x1f
     ede:	40940733          	sub	a4,s0,s1
     ee2:	0093f563          	bgeu	t2,s1,eec <__lltostr+0x5e>
     ee6:	0062e5b3          	or	a1,t0,t1
     eea:	e185                	bnez	a1,f0a <__lltostr+0x7c>
     eec:	00170613          	addi	a2,a4,1 # 7ff00001 <__kernel_stack+0x5fef0001>
     ef0:	85a6                	mv	a1,s1
     ef2:	851e                	mv	a0,t2
     ef4:	c03a                	sw	a4,0(sp)
     ef6:	01c010ef          	jal	ra,1f12 <memmove>
     efa:	4702                	lw	a4,0(sp)
     efc:	5082                	lw	ra,32(sp)
     efe:	4472                	lw	s0,28(sp)
     f00:	44e2                	lw	s1,24(sp)
     f02:	853a                	mv	a0,a4
     f04:	02410113          	addi	sp,sp,36
     f08:	8082                	ret
     f0a:	8516                	mv	a0,t0
     f0c:	859a                	mv	a1,t1
     f0e:	ca1e                	sw	t2,20(sp)
     f10:	c832                	sw	a2,16(sp)
     f12:	c636                	sw	a3,12(sp)
     f14:	c416                	sw	t0,8(sp)
     f16:	c21a                	sw	t1,4(sp)
     f18:	6d2010ef          	jal	ra,25ea <__umoddi3>
     f1c:	03050513          	addi	a0,a0,48
     f20:	0ff57513          	zext.b	a0,a0
     f24:	03900793          	li	a5,57
     f28:	4312                	lw	t1,4(sp)
     f2a:	42a2                	lw	t0,8(sp)
     f2c:	46b2                	lw	a3,12(sp)
     f2e:	4642                	lw	a2,16(sp)
     f30:	43d2                	lw	t2,20(sp)
     f32:	14fd                	addi	s1,s1,-1
     f34:	02a7e163          	bltu	a5,a0,f56 <__lltostr+0xc8>
     f38:	00a48023          	sb	a0,0(s1)
     f3c:	859a                	mv	a1,t1
     f3e:	8516                	mv	a0,t0
     f40:	c61e                	sw	t2,12(sp)
     f42:	c432                	sw	a2,8(sp)
     f44:	c236                	sw	a3,4(sp)
     f46:	33e010ef          	jal	ra,2284 <__udivdi3>
     f4a:	43b2                	lw	t2,12(sp)
     f4c:	4622                	lw	a2,8(sp)
     f4e:	4692                	lw	a3,4(sp)
     f50:	82aa                	mv	t0,a0
     f52:	832e                	mv	t1,a1
     f54:	b769                	j	ede <__lltostr+0x50>
     f56:	4782                	lw	a5,0(sp)
     f58:	953e                	add	a0,a0,a5
     f5a:	bff9                	j	f38 <__lltostr+0xaa>

00000f5c <__ltostr>:
     f5c:	1151                	addi	sp,sp,-12
     f5e:	15fd                	addi	a1,a1,-1
     f60:	c406                	sw	ra,8(sp)
     f62:	c222                	sw	s0,4(sp)
     f64:	95aa                	add	a1,a1,a0
     f66:	00058023          	sb	zero,0(a1)
     f6a:	fff68313          	addi	t1,a3,-1
     f6e:	02300793          	li	a5,35
     f72:	0067f363          	bgeu	a5,t1,f78 <__ltostr+0x1c>
     f76:	46a9                	li	a3,10
     f78:	4781                	li	a5,0
     f7a:	e619                	bnez	a2,f88 <__ltostr+0x2c>
     f7c:	03000793          	li	a5,48
     f80:	fef58fa3          	sb	a5,-1(a1)
     f84:	15fd                	addi	a1,a1,-1
     f86:	4785                	li	a5,1
     f88:	02700313          	li	t1,39
     f8c:	c311                	beqz	a4,f90 <__ltostr+0x34>
     f8e:	431d                	li	t1,7
     f90:	0ff37713          	zext.b	a4,t1
     f94:	03900293          	li	t0,57
     f98:	00f58333          	add	t1,a1,a5
     f9c:	40b30433          	sub	s0,t1,a1
     fa0:	00b57363          	bgeu	a0,a1,fa6 <__ltostr+0x4a>
     fa4:	ea11                	bnez	a2,fb8 <__ltostr+0x5c>
     fa6:	00140613          	addi	a2,s0,1
     faa:	769000ef          	jal	ra,1f12 <memmove>
     fae:	40a2                	lw	ra,8(sp)
     fb0:	8522                	mv	a0,s0
     fb2:	4412                	lw	s0,4(sp)
     fb4:	0131                	addi	sp,sp,12
     fb6:	8082                	ret
     fb8:	02d677b3          	remu	a5,a2,a3
     fbc:	15fd                	addi	a1,a1,-1
     fbe:	03078793          	addi	a5,a5,48
     fc2:	0ff7f793          	zext.b	a5,a5
     fc6:	00f2e763          	bltu	t0,a5,fd4 <__ltostr+0x78>
     fca:	02d65633          	divu	a2,a2,a3
     fce:	00f58023          	sb	a5,0(a1)
     fd2:	b7e9                	j	f9c <__ltostr+0x40>
     fd4:	97ba                	add	a5,a5,a4
     fd6:	bfd5                	j	fca <__ltostr+0x6e>

00000fd8 <printf>:
     fd8:	fdc10113          	addi	sp,sp,-36
     fdc:	c82e                	sw	a1,16(sp)
     fde:	080c                	addi	a1,sp,16
     fe0:	c606                	sw	ra,12(sp)
     fe2:	ca32                	sw	a2,20(sp)
     fe4:	cc36                	sw	a3,24(sp)
     fe6:	ce3a                	sw	a4,28(sp)
     fe8:	d03e                	sw	a5,32(sp)
     fea:	c02e                	sw	a1,0(sp)
     fec:	7a4000ef          	jal	ra,1790 <vprintf>
     ff0:	40b2                	lw	ra,12(sp)
     ff2:	02410113          	addi	sp,sp,36
     ff6:	8082                	ret

00000ff8 <puts>:
     ff8:	1151                	addi	sp,sp,-12
     ffa:	c222                	sw	s0,4(sp)
     ffc:	c406                	sw	ra,8(sp)
     ffe:	842a                	mv	s0,a0
    1000:	00044503          	lbu	a0,0(s0)
    1004:	55fd                	li	a1,-1
    1006:	e909                	bnez	a0,1018 <INTCTL+0x15>
    1008:	4529                	li	a0,10
    100a:	e24ff0ef          	jal	ra,62e <fputc>
    100e:	40a2                	lw	ra,8(sp)
    1010:	4412                	lw	s0,4(sp)
    1012:	4501                	li	a0,0
    1014:	0131                	addi	sp,sp,12
    1016:	8082                	ret
    1018:	e16ff0ef          	jal	ra,62e <fputc>
    101c:	0405                	addi	s0,s0,1
    101e:	b7cd                	j	1000 <INTIP>

00001020 <write_pad>:
    1020:	1131                	addi	sp,sp,-20
    1022:	fd060613          	addi	a2,a2,-48
    1026:	c622                	sw	s0,12(sp)
    1028:	00163613          	seqz	a2,a2
    102c:	6411                	lui	s0,0x4
    102e:	0612                	slli	a2,a2,0x4
    1030:	4d040413          	addi	s0,s0,1232 # 44d0 <pad_line>
    1034:	c426                	sw	s1,8(sp)
    1036:	c806                	sw	ra,16(sp)
    1038:	84aa                	mv	s1,a0
    103a:	87ae                	mv	a5,a1
    103c:	9432                	add	s0,s0,a2
    103e:	872e                	mv	a4,a1
    1040:	46bd                	li	a3,15
    1042:	40e78533          	sub	a0,a5,a4
    1046:	02e6c163          	blt	a3,a4,1068 <write_pad+0x48>
    104a:	c03e                	sw	a5,0(sp)
    104c:	00e05963          	blez	a4,105e <write_pad+0x3e>
    1050:	40d4                	lw	a3,4(s1)
    1052:	4090                	lw	a2,0(s1)
    1054:	85ba                	mv	a1,a4
    1056:	8522                	mv	a0,s0
    1058:	9682                	jalr	a3
    105a:	4782                	lw	a5,0(sp)
    105c:	853e                	mv	a0,a5
    105e:	40c2                	lw	ra,16(sp)
    1060:	4432                	lw	s0,12(sp)
    1062:	44a2                	lw	s1,8(sp)
    1064:	0151                	addi	sp,sp,20
    1066:	8082                	ret
    1068:	40d4                	lw	a3,4(s1)
    106a:	4090                	lw	a2,0(s1)
    106c:	45c1                	li	a1,16
    106e:	8522                	mv	a0,s0
    1070:	c23e                	sw	a5,4(sp)
    1072:	c03a                	sw	a4,0(sp)
    1074:	9682                	jalr	a3
    1076:	4702                	lw	a4,0(sp)
    1078:	4792                	lw	a5,4(sp)
    107a:	1741                	addi	a4,a4,-16
    107c:	b7d1                	j	1040 <write_pad+0x20>

0000107e <__v_printf>:
    107e:	f2c10113          	addi	sp,sp,-212
    1082:	c7a2                	sw	s0,204(sp)
    1084:	c5a6                	sw	s1,200(sp)
    1086:	c986                	sw	ra,208(sp)
    1088:	84aa                	mv	s1,a0
    108a:	c82e                	sw	a1,16(sp)
    108c:	8432                	mv	s0,a2
    108e:	67b000ef          	jal	ra,1f08 <__errno>
    1092:	411c                	lw	a5,0(a0)
    1094:	c202                	sw	zero,4(sp)
    1096:	d83e                	sw	a5,48(sp)
    1098:	47c2                	lw	a5,16(sp)
    109a:	0007c783          	lbu	a5,0(a5)
    109e:	5c078463          	beqz	a5,1666 <__v_printf+0x5e8>
    10a2:	4581                	li	a1,0
    10a4:	02500693          	li	a3,37
    10a8:	a011                	j	10ac <__v_printf+0x2e>
    10aa:	0585                	addi	a1,a1,1
    10ac:	47c2                	lw	a5,16(sp)
    10ae:	97ae                	add	a5,a5,a1
    10b0:	0007c703          	lbu	a4,0(a5)
    10b4:	68070c63          	beqz	a4,174c <__v_printf+0x6ce>
    10b8:	fed719e3          	bne	a4,a3,10aa <__v_printf+0x2c>
    10bc:	edb1                	bnez	a1,1118 <__v_printf+0x9a>
    10be:	47c2                	lw	a5,16(sp)
    10c0:	02000713          	li	a4,32
    10c4:	00178513          	addi	a0,a5,1
    10c8:	c002                	sw	zero,0(sp)
    10ca:	c602                	sw	zero,12(sp)
    10cc:	4781                	li	a5,0
    10ce:	ca02                	sw	zero,20(sp)
    10d0:	cc02                	sw	zero,24(sp)
    10d2:	d602                	sw	zero,44(sp)
    10d4:	d002                	sw	zero,32(sp)
    10d6:	c402                	sw	zero,8(sp)
    10d8:	ce3a                	sw	a4,28(sp)
    10da:	00054303          	lbu	t1,0(a0)
    10de:	00150713          	addi	a4,a0,1
    10e2:	c83a                	sw	a4,16(sp)
    10e4:	046101a3          	sb	t1,67(sp)
    10e8:	07a00713          	li	a4,122
    10ec:	fa6766e3          	bltu	a4,t1,1098 <__v_printf+0x1a>
    10f0:	04b00713          	li	a4,75
    10f4:	04676a63          	bltu	a4,t1,1148 <__v_printf+0xca>
    10f8:	56030563          	beqz	t1,1662 <__v_printf+0x5e4>
    10fc:	1301                	addi	t1,t1,-32
    10fe:	0ff37313          	zext.b	t1,t1
    1102:	4765                	li	a4,25
    1104:	f8676ae3          	bltu	a4,t1,1098 <__v_printf+0x1a>
    1108:	6711                	lui	a4,0x4
    110a:	3ac70713          	addi	a4,a4,940 # 43ac <sg_uart_config+0x17c>
    110e:	030a                	slli	t1,t1,0x2
    1110:	933a                	add	t1,t1,a4
    1112:	00032703          	lw	a4,0(t1) # 80000000 <MTIME_HI_ADDR+0x9fff4004>
    1116:	8702                	jr	a4
    1118:	40d8                	lw	a4,4(s1)
    111a:	4090                	lw	a2,0(s1)
    111c:	4542                	lw	a0,16(sp)
    111e:	c43e                	sw	a5,8(sp)
    1120:	c02e                	sw	a1,0(sp)
    1122:	9702                	jalr	a4
    1124:	4792                	lw	a5,4(sp)
    1126:	4582                	lw	a1,0(sp)
    1128:	02500713          	li	a4,37
    112c:	97ae                	add	a5,a5,a1
    112e:	c23e                	sw	a5,4(sp)
    1130:	47a2                	lw	a5,8(sp)
    1132:	0007c683          	lbu	a3,0(a5)
    1136:	f8e685e3          	beq	a3,a4,10c0 <__v_printf+0x42>
    113a:	c83e                	sw	a5,16(sp)
    113c:	bfb1                	j	1098 <__v_printf+0x1a>
    113e:	0ff00713          	li	a4,255
    1142:	c43a                	sw	a4,8(sp)
    1144:	4542                	lw	a0,16(sp)
    1146:	bf51                	j	10da <__v_printf+0x5c>
    1148:	fb430713          	addi	a4,t1,-76
    114c:	0ff77713          	zext.b	a4,a4
    1150:	02e00693          	li	a3,46
    1154:	f4e6e2e3          	bltu	a3,a4,1098 <__v_printf+0x1a>
    1158:	6691                	lui	a3,0x4
    115a:	070a                	slli	a4,a4,0x2
    115c:	41468693          	addi	a3,a3,1044 # 4414 <sg_uart_config+0x1e4>
    1160:	9736                	add	a4,a4,a3
    1162:	4318                	lw	a4,0(a4)
    1164:	8702                	jr	a4
    1166:	4589                	li	a1,2
    1168:	4701                	li	a4,0
    116a:	4281                	li	t0,0
    116c:	a629                	j	1476 <__v_printf+0x3f8>
    116e:	4705                	li	a4,1
    1170:	d03a                	sw	a4,32(sp)
    1172:	bfc9                	j	1144 <__v_printf+0xc6>
    1174:	17fd                	addi	a5,a5,-1
    1176:	07e2                	slli	a5,a5,0x18
    1178:	87e1                	srai	a5,a5,0x18
    117a:	b7e9                	j	1144 <__v_printf+0xc6>
    117c:	0785                	addi	a5,a5,1
    117e:	07e2                	slli	a5,a5,0x18
    1180:	87e1                	srai	a5,a5,0x18
    1182:	0785                	addi	a5,a5,1
    1184:	bfcd                	j	1176 <__v_printf+0xf8>
    1186:	4705                	li	a4,1
    1188:	d63a                	sw	a4,44(sp)
    118a:	bf6d                	j	1144 <__v_printf+0xc6>
    118c:	4705                	li	a4,1
    118e:	cc3a                	sw	a4,24(sp)
    1190:	bf55                	j	1144 <__v_printf+0xc6>
    1192:	c83e                	sw	a5,16(sp)
    1194:	47d2                	lw	a5,20(sp)
    1196:	4c079663          	bnez	a5,1662 <__v_printf+0x5e4>
    119a:	4629                	li	a2,10
    119c:	00cc                	addi	a1,sp,68
    119e:	181000ef          	jal	ra,1b1e <strtoul>
    11a2:	04314683          	lbu	a3,67(sp)
    11a6:	c62a                	sw	a0,12(sp)
    11a8:	03000713          	li	a4,48
    11ac:	47c2                	lw	a5,16(sp)
    11ae:	00e69763          	bne	a3,a4,11bc <__v_printf+0x13e>
    11b2:	5702                	lw	a4,32(sp)
    11b4:	e701                	bnez	a4,11bc <__v_printf+0x13e>
    11b6:	03000713          	li	a4,48
    11ba:	ce3a                	sw	a4,28(sp)
    11bc:	4716                	lw	a4,68(sp)
    11be:	c83a                	sw	a4,16(sp)
    11c0:	b751                	j	1144 <__v_printf+0xc6>
    11c2:	4018                	lw	a4,0(s0)
    11c4:	0411                	addi	s0,s0,4
    11c6:	c63a                	sw	a4,12(sp)
    11c8:	bfb5                	j	1144 <__v_printf+0xc6>
    11ca:	00154683          	lbu	a3,1(a0)
    11ce:	02a00713          	li	a4,42
    11d2:	02e69063          	bne	a3,a4,11f2 <__v_printf+0x174>
    11d6:	4014                	lw	a3,0(s0)
    11d8:	00440713          	addi	a4,s0,4
    11dc:	c036                	sw	a3,0(sp)
    11de:	0006d363          	bgez	a3,11e4 <__v_printf+0x166>
    11e2:	c002                	sw	zero,0(sp)
    11e4:	00250693          	addi	a3,a0,2
    11e8:	c836                	sw	a3,16(sp)
    11ea:	843a                	mv	s0,a4
    11ec:	4705                	li	a4,1
    11ee:	ca3a                	sw	a4,20(sp)
    11f0:	bf91                	j	1144 <__v_printf+0xc6>
    11f2:	4542                	lw	a0,16(sp)
    11f4:	4629                	li	a2,10
    11f6:	00cc                	addi	a1,sp,68
    11f8:	ca3e                	sw	a5,20(sp)
    11fa:	766000ef          	jal	ra,1960 <strtol>
    11fe:	c02a                	sw	a0,0(sp)
    1200:	47d2                	lw	a5,20(sp)
    1202:	00055363          	bgez	a0,1208 <__v_printf+0x18a>
    1206:	c002                	sw	zero,0(sp)
    1208:	4716                	lw	a4,68(sp)
    120a:	c83a                	sw	a4,16(sp)
    120c:	b7c5                	j	11ec <__v_printf+0x16e>
    120e:	401c                	lw	a5,0(s0)
    1210:	0411                	addi	s0,s0,4
    1212:	04f101a3          	sb	a5,67(sp)
    1216:	40dc                	lw	a5,4(s1)
    1218:	4090                	lw	a2,0(s1)
    121a:	4585                	li	a1,1
    121c:	04310513          	addi	a0,sp,67
    1220:	9782                	jalr	a5
    1222:	4792                	lw	a5,4(sp)
    1224:	0785                	addi	a5,a5,1
    1226:	c23e                	sw	a5,4(sp)
    1228:	bd85                	j	1098 <__v_printf+0x1a>
    122a:	5542                	lw	a0,48(sp)
    122c:	4b9000ef          	jal	ra,1ee4 <strerror>
    1230:	c2aa                	sw	a0,68(sp)
    1232:	c42a                	sw	a0,8(sp)
    1234:	777000ef          	jal	ra,21aa <strlen>
    1238:	47a2                	lw	a5,8(sp)
    123a:	40d8                	lw	a4,4(s1)
    123c:	4090                	lw	a2,0(s1)
    123e:	85aa                	mv	a1,a0
    1240:	c02a                	sw	a0,0(sp)
    1242:	853e                	mv	a0,a5
    1244:	9702                	jalr	a4
    1246:	4792                	lw	a5,4(sp)
    1248:	4582                	lw	a1,0(sp)
    124a:	97ae                	add	a5,a5,a1
    124c:	bfe9                	j	1226 <__v_printf+0x1a8>
    124e:	401c                	lw	a5,0(s0)
    1250:	00440713          	addi	a4,s0,4
    1254:	c7a1                	beqz	a5,129c <__v_printf+0x21e>
    1256:	c2be                	sw	a5,68(sp)
    1258:	4516                	lw	a0,68(sp)
    125a:	cc3a                	sw	a4,24(sp)
    125c:	74f000ef          	jal	ra,21aa <strlen>
    1260:	47d2                	lw	a5,20(sp)
    1262:	4762                	lw	a4,24(sp)
    1264:	832a                	mv	t1,a0
    1266:	cf9d                	beqz	a5,12a4 <__v_printf+0x226>
    1268:	4782                	lw	a5,0(sp)
    126a:	00a7f363          	bgeu	a5,a0,1270 <__v_printf+0x1f2>
    126e:	833e                	mv	t1,a5
    1270:	843a                	mv	s0,a4
    1272:	c002                	sw	zero,0(sp)
    1274:	ca02                	sw	zero,20(sp)
    1276:	4281                	li	t0,0
    1278:	02000793          	li	a5,32
    127c:	ce3e                	sw	a5,28(sp)
    127e:	47b2                	lw	a5,12(sp)
    1280:	4702                	lw	a4,0(sp)
    1282:	4696                	lw	a3,68(sp)
    1284:	8fd9                	or	a5,a5,a4
    1286:	e39d                	bnez	a5,12ac <__v_printf+0x22e>
    1288:	40dc                	lw	a5,4(s1)
    128a:	4090                	lw	a2,0(s1)
    128c:	859a                	mv	a1,t1
    128e:	8536                	mv	a0,a3
    1290:	c01a                	sw	t1,0(sp)
    1292:	9782                	jalr	a5
    1294:	4792                	lw	a5,4(sp)
    1296:	4302                	lw	t1,0(sp)
    1298:	979a                	add	a5,a5,t1
    129a:	b771                	j	1226 <__v_printf+0x1a8>
    129c:	6791                	lui	a5,0x4
    129e:	3a478793          	addi	a5,a5,932 # 43a4 <sg_uart_config+0x174>
    12a2:	bf55                	j	1256 <__v_printf+0x1d8>
    12a4:	843a                	mv	s0,a4
    12a6:	4281                	li	t0,0
    12a8:	c002                	sw	zero,0(sp)
    12aa:	b7f9                	j	1278 <__v_printf+0x1fa>
    12ac:	3c029463          	bnez	t0,1674 <__v_printf+0x5f6>
    12b0:	47a2                	lw	a5,8(sp)
    12b2:	3c078663          	beqz	a5,167e <__v_printf+0x600>
    12b6:	47a2                	lw	a5,8(sp)
    12b8:	00f68733          	add	a4,a3,a5
    12bc:	c2ba                	sw	a4,68(sp)
    12be:	4732                	lw	a4,12(sp)
    12c0:	40f30333          	sub	t1,t1,a5
    12c4:	8f1d                	sub	a4,a4,a5
    12c6:	c63a                	sw	a4,12(sp)
    12c8:	5702                	lw	a4,32(sp)
    12ca:	3a070e63          	beqz	a4,1686 <__v_printf+0x608>
    12ce:	40d8                	lw	a4,4(s1)
    12d0:	4090                	lw	a2,0(s1)
    12d2:	85be                	mv	a1,a5
    12d4:	8536                	mv	a0,a3
    12d6:	ca1a                	sw	t1,20(sp)
    12d8:	c43e                	sw	a5,8(sp)
    12da:	9702                	jalr	a4
    12dc:	4712                	lw	a4,4(sp)
    12de:	47a2                	lw	a5,8(sp)
    12e0:	4352                	lw	t1,20(sp)
    12e2:	97ba                	add	a5,a5,a4
    12e4:	c23e                	sw	a5,4(sp)
    12e6:	4782                	lw	a5,0(sp)
    12e8:	03000613          	li	a2,48
    12ec:	8526                	mv	a0,s1
    12ee:	406785b3          	sub	a1,a5,t1
    12f2:	ca1a                	sw	t1,20(sp)
    12f4:	3335                	jal	1020 <write_pad>
    12f6:	4792                	lw	a5,4(sp)
    12f8:	4352                	lw	t1,20(sp)
    12fa:	40d8                	lw	a4,4(s1)
    12fc:	97aa                	add	a5,a5,a0
    12fe:	4090                	lw	a2,0(s1)
    1300:	4516                	lw	a0,68(sp)
    1302:	859a                	mv	a1,t1
    1304:	c43e                	sw	a5,8(sp)
    1306:	c21a                	sw	t1,4(sp)
    1308:	9702                	jalr	a4
    130a:	4312                	lw	t1,4(sp)
    130c:	47a2                	lw	a5,8(sp)
    130e:	4582                	lw	a1,0(sp)
    1310:	979a                	add	a5,a5,t1
    1312:	0065f363          	bgeu	a1,t1,1318 <__v_printf+0x29a>
    1316:	859a                	mv	a1,t1
    1318:	c03e                	sw	a5,0(sp)
    131a:	47b2                	lw	a5,12(sp)
    131c:	02000613          	li	a2,32
    1320:	8526                	mv	a0,s1
    1322:	40b785b3          	sub	a1,a5,a1
    1326:	39ed                	jal	1020 <write_pad>
    1328:	4782                	lw	a5,0(sp)
    132a:	97aa                	add	a5,a5,a0
    132c:	bded                	j	1226 <__v_printf+0x1a8>
    132e:	c78d                	beqz	a5,1358 <__v_printf+0x2da>
    1330:	4672                	lw	a2,28(sp)
    1332:	03000713          	li	a4,48
    1336:	02e61163          	bne	a2,a4,1358 <__v_printf+0x2da>
    133a:	40d8                	lw	a4,4(s1)
    133c:	4090                	lw	a2,0(s1)
    133e:	85be                	mv	a1,a5
    1340:	8536                	mv	a0,a3
    1342:	ca1a                	sw	t1,20(sp)
    1344:	c43e                	sw	a5,8(sp)
    1346:	c036                	sw	a3,0(sp)
    1348:	9702                	jalr	a4
    134a:	4712                	lw	a4,4(sp)
    134c:	47a2                	lw	a5,8(sp)
    134e:	4352                	lw	t1,20(sp)
    1350:	4682                	lw	a3,0(sp)
    1352:	97ba                	add	a5,a5,a4
    1354:	c23e                	sw	a5,4(sp)
    1356:	4781                	li	a5,0
    1358:	c43e                	sw	a5,8(sp)
    135a:	47b2                	lw	a5,12(sp)
    135c:	4672                	lw	a2,28(sp)
    135e:	8526                	mv	a0,s1
    1360:	406785b3          	sub	a1,a5,t1
    1364:	c01a                	sw	t1,0(sp)
    1366:	ca36                	sw	a3,20(sp)
    1368:	3965                	jal	1020 <write_pad>
    136a:	4792                	lw	a5,4(sp)
    136c:	4302                	lw	t1,0(sp)
    136e:	00a78733          	add	a4,a5,a0
    1372:	47a2                	lw	a5,8(sp)
    1374:	36078c63          	beqz	a5,16ec <__v_printf+0x66e>
    1378:	46d2                	lw	a3,20(sp)
    137a:	0044a383          	lw	t2,4(s1)
    137e:	4090                	lw	a2,0(s1)
    1380:	85be                	mv	a1,a5
    1382:	8536                	mv	a0,a3
    1384:	c41a                	sw	t1,8(sp)
    1386:	c23a                	sw	a4,4(sp)
    1388:	c03e                	sw	a5,0(sp)
    138a:	9382                	jalr	t2
    138c:	4782                	lw	a5,0(sp)
    138e:	4712                	lw	a4,4(sp)
    1390:	4322                	lw	t1,8(sp)
    1392:	973e                	add	a4,a4,a5
    1394:	aea1                	j	16ec <__v_printf+0x66e>
    1396:	07800793          	li	a5,120
    139a:	4709                	li	a4,2
    139c:	04f101a3          	sb	a5,67(sp)
    13a0:	c43a                	sw	a4,8(sp)
    13a2:	4785                	li	a5,1
    13a4:	04314703          	lbu	a4,67(sp)
    13a8:	fa870713          	addi	a4,a4,-88
    13ac:	00173713          	seqz	a4,a4
    13b0:	46a2                	lw	a3,8(sp)
    13b2:	4301                	li	t1,0
    13b4:	ce81                	beqz	a3,13cc <__v_printf+0x34e>
    13b6:	03000693          	li	a3,48
    13ba:	04d104a3          	sb	a3,73(sp)
    13be:	04314683          	lbu	a3,67(sp)
    13c2:	4309                	li	t1,2
    13c4:	04d10523          	sb	a3,74(sp)
    13c8:	4689                	li	a3,2
    13ca:	c436                	sw	a3,8(sp)
    13cc:	46b2                	lw	a3,12(sp)
    13ce:	4602                	lw	a2,0(sp)
    13d0:	00c6f363          	bgeu	a3,a2,13d6 <__v_printf+0x358>
    13d4:	c632                	sw	a2,12(sp)
    13d6:	45c1                	li	a1,16
    13d8:	4281                	li	t0,0
    13da:	04910693          	addi	a3,sp,73
    13de:	c2b6                	sw	a3,68(sp)
    13e0:	0ef05a63          	blez	a5,14d4 <__v_printf+0x456>
    13e4:	4685                	li	a3,1
    13e6:	0ad78d63          	beq	a5,a3,14a0 <__v_printf+0x422>
    13ea:	4008                	lw	a0,0(s0)
    13ec:	4054                	lw	a3,4(s0)
    13ee:	00840393          	addi	t2,s0,8
    13f2:	4601                	li	a2,0
    13f4:	0a028d63          	beqz	t0,14ae <__v_printf+0x430>
    13f8:	0006da63          	bgez	a3,140c <__v_printf+0x38e>
    13fc:	00a037b3          	snez	a5,a0
    1400:	40d006b3          	neg	a3,a3
    1404:	8e9d                	sub	a3,a3,a5
    1406:	40a00533          	neg	a0,a0
    140a:	4289                	li	t0,2
    140c:	862a                	mv	a2,a0
    140e:	04910513          	addi	a0,sp,73
    1412:	87ba                	mv	a5,a4
    1414:	951a                	add	a0,a0,t1
    1416:	872e                	mv	a4,a1
    1418:	07b00593          	li	a1,123
    141c:	da16                	sw	t0,52(sp)
    141e:	d41e                	sw	t2,40(sp)
    1420:	d21a                	sw	t1,36(sp)
    1422:	34b5                	jal	e8e <__lltostr>
    1424:	53a2                	lw	t2,40(sp)
    1426:	5312                	lw	t1,36(sp)
    1428:	52d2                	lw	t0,52(sp)
    142a:	841e                	mv	s0,t2
    142c:	4752                	lw	a4,20(sp)
    142e:	4796                	lw	a5,68(sp)
    1430:	cb61                	beqz	a4,1500 <__v_printf+0x482>
    1432:	4705                	li	a4,1
    1434:	0ce51663          	bne	a0,a4,1500 <__v_printf+0x482>
    1438:	00678733          	add	a4,a5,t1
    143c:	00074683          	lbu	a3,0(a4)
    1440:	03000713          	li	a4,48
    1444:	0ae69e63          	bne	a3,a4,1500 <__v_printf+0x482>
    1448:	4702                	lw	a4,0(sp)
    144a:	cf4d                	beqz	a4,1504 <__v_printf+0x486>
    144c:	4722                	lw	a4,8(sp)
    144e:	c319                	beqz	a4,1454 <__v_printf+0x3d6>
    1450:	c402                	sw	zero,8(sp)
    1452:	4301                	li	t1,0
    1454:	4709                	li	a4,2
    1456:	0ae29a63          	bne	t0,a4,150a <__v_printf+0x48c>
    145a:	fff78713          	addi	a4,a5,-1
    145e:	c2ba                	sw	a4,68(sp)
    1460:	02d00713          	li	a4,45
    1464:	fee78fa3          	sb	a4,-1(a5)
    1468:	0305                	addi	t1,t1,1
    146a:	bd11                	j	127e <__v_printf+0x200>
    146c:	4701                	li	a4,0
    146e:	b789                	j	13b0 <__v_printf+0x332>
    1470:	45a9                	li	a1,10
    1472:	4701                	li	a4,0
    1474:	4285                	li	t0,1
    1476:	4301                	li	t1,0
    1478:	b78d                	j	13da <__v_printf+0x35c>
    147a:	4722                	lw	a4,8(sp)
    147c:	cf11                	beqz	a4,1498 <__v_printf+0x41a>
    147e:	03000713          	li	a4,48
    1482:	04e104a3          	sb	a4,73(sp)
    1486:	4705                	li	a4,1
    1488:	c43a                	sw	a4,8(sp)
    148a:	45a1                	li	a1,8
    148c:	4701                	li	a4,0
    148e:	4281                	li	t0,0
    1490:	4305                	li	t1,1
    1492:	b7a1                	j	13da <__v_printf+0x35c>
    1494:	45a9                	li	a1,10
    1496:	b9c9                	j	1168 <__v_printf+0xea>
    1498:	4701                	li	a4,0
    149a:	4281                	li	t0,0
    149c:	45a1                	li	a1,8
    149e:	bfe1                	j	1476 <__v_printf+0x3f8>
    14a0:	4010                	lw	a2,0(s0)
    14a2:	00440393          	addi	t2,s0,4
    14a6:	02029c63          	bnez	t0,14de <__v_printf+0x460>
    14aa:	4501                	li	a0,0
    14ac:	4681                	li	a3,0
    14ae:	4405                	li	s0,1
    14b0:	f4f44ee3          	blt	s0,a5,140c <__v_printf+0x38e>
    14b4:	04910793          	addi	a5,sp,73
    14b8:	86ae                	mv	a3,a1
    14ba:	00678533          	add	a0,a5,t1
    14be:	07b00593          	li	a1,123
    14c2:	da16                	sw	t0,52(sp)
    14c4:	d41e                	sw	t2,40(sp)
    14c6:	d21a                	sw	t1,36(sp)
    14c8:	3c51                	jal	f5c <__ltostr>
    14ca:	53a2                	lw	t2,40(sp)
    14cc:	52d2                	lw	t0,52(sp)
    14ce:	5312                	lw	t1,36(sp)
    14d0:	841e                	mv	s0,t2
    14d2:	bfa9                	j	142c <__v_printf+0x3ae>
    14d4:	4010                	lw	a2,0(s0)
    14d6:	00440393          	addi	t2,s0,4
    14da:	00028863          	beqz	t0,14ea <__v_printf+0x46c>
    14de:	4285                	li	t0,1
    14e0:	00065563          	bgez	a2,14ea <__v_printf+0x46c>
    14e4:	40c00633          	neg	a2,a2
    14e8:	4289                	li	t0,2
    14ea:	fc07d0e3          	bgez	a5,14aa <__v_printf+0x42c>
    14ee:	56fd                	li	a3,-1
    14f0:	00d79563          	bne	a5,a3,14fa <__v_printf+0x47c>
    14f4:	0642                	slli	a2,a2,0x10
    14f6:	8241                	srli	a2,a2,0x10
    14f8:	bf75                	j	14b4 <__v_printf+0x436>
    14fa:	0ff67613          	zext.b	a2,a2
    14fe:	bf5d                	j	14b4 <__v_printf+0x436>
    1500:	932a                	add	t1,t1,a0
    1502:	bf89                	j	1454 <__v_printf+0x3d6>
    1504:	4301                	li	t1,0
    1506:	c402                	sw	zero,8(sp)
    1508:	b7b1                	j	1454 <__v_printf+0x3d6>
    150a:	d6028ae3          	beqz	t0,127e <__v_printf+0x200>
    150e:	4762                	lw	a4,24(sp)
    1510:	ef19                	bnez	a4,152e <__v_printf+0x4b0>
    1512:	5732                	lw	a4,44(sp)
    1514:	4281                	li	t0,0
    1516:	d60704e3          	beqz	a4,127e <__v_printf+0x200>
    151a:	02000713          	li	a4,32
    151e:	fff78693          	addi	a3,a5,-1
    1522:	c2b6                	sw	a3,68(sp)
    1524:	fee78fa3          	sb	a4,-1(a5)
    1528:	0305                	addi	t1,t1,1
    152a:	4285                	li	t0,1
    152c:	bb89                	j	127e <__v_printf+0x200>
    152e:	02b00713          	li	a4,43
    1532:	b7f5                	j	151e <__v_printf+0x4a0>
    1534:	00840793          	addi	a5,s0,8
    1538:	da3e                	sw	a5,52(sp)
    153a:	401c                	lw	a5,0(s0)
    153c:	d23e                	sw	a5,36(sp)
    153e:	405c                	lw	a5,4(s0)
    1540:	d43e                	sw	a5,40(sp)
    1542:	04910793          	addi	a5,sp,73
    1546:	c2be                	sw	a5,68(sp)
    1548:	47b2                	lw	a5,12(sp)
    154a:	e399                	bnez	a5,1550 <__v_printf+0x4d2>
    154c:	4785                	li	a5,1
    154e:	c63e                	sw	a5,12(sp)
    1550:	47d2                	lw	a5,20(sp)
    1552:	e399                	bnez	a5,1558 <__v_printf+0x4da>
    1554:	4799                	li	a5,6
    1556:	c03e                	sw	a5,0(sp)
    1558:	42e2                	lw	t0,24(sp)
    155a:	00029e63          	bnez	t0,1576 <__v_printf+0x4f8>
    155e:	5712                	lw	a4,36(sp)
    1560:	57a2                	lw	a5,40(sp)
    1562:	4601                	li	a2,0
    1564:	4681                	li	a3,0
    1566:	853a                	mv	a0,a4
    1568:	85be                	mv	a1,a5
    156a:	dc1a                	sw	t1,56(sp)
    156c:	07a020ef          	jal	ra,35e6 <__ledf2>
    1570:	5362                	lw	t1,56(sp)
    1572:	01f55293          	srli	t0,a0,0x1f
    1576:	5412                	lw	s0,36(sp)
    1578:	53a2                	lw	t2,40(sp)
    157a:	4782                	lw	a5,0(sp)
    157c:	4732                	lw	a4,12(sp)
    157e:	8522                	mv	a0,s0
    1580:	07f00693          	li	a3,127
    1584:	04910613          	addi	a2,sp,73
    1588:	859e                	mv	a1,t2
    158a:	de16                	sw	t0,60(sp)
    158c:	dc1a                	sw	t1,56(sp)
    158e:	cb6ff0ef          	jal	ra,a44 <__dtostr>
    1592:	47d2                	lw	a5,20(sp)
    1594:	5362                	lw	t1,56(sp)
    1596:	52f2                	lw	t0,60(sp)
    1598:	842a                	mv	s0,a0
    159a:	cb85                	beqz	a5,15ca <__v_printf+0x54c>
    159c:	4796                	lw	a5,68(sp)
    159e:	02e00593          	li	a1,46
    15a2:	853e                	mv	a0,a5
    15a4:	ca3e                	sw	a5,20(sp)
    15a6:	2369                	jal	1b30 <strchr>
    15a8:	47d2                	lw	a5,20(sp)
    15aa:	5362                	lw	t1,56(sp)
    15ac:	52f2                	lw	t0,60(sp)
    15ae:	cd41                	beqz	a0,1646 <__v_printf+0x5c8>
    15b0:	4782                	lw	a5,0(sp)
    15b2:	e399                	bnez	a5,15b8 <__v_printf+0x53a>
    15b4:	47a2                	lw	a5,8(sp)
    15b6:	cb81                	beqz	a5,15c6 <__v_printf+0x548>
    15b8:	0505                	addi	a0,a0,1
    15ba:	4782                	lw	a5,0(sp)
    15bc:	c789                	beqz	a5,15c6 <__v_printf+0x548>
    15be:	00154783          	lbu	a5,1(a0)
    15c2:	0505                	addi	a0,a0,1
    15c4:	efad                	bnez	a5,163e <__v_printf+0x5c0>
    15c6:	00050023          	sb	zero,0(a0)
    15ca:	06700793          	li	a5,103
    15ce:	04f31963          	bne	t1,a5,1620 <__v_printf+0x5a2>
    15d2:	4516                	lw	a0,68(sp)
    15d4:	02e00593          	li	a1,46
    15d8:	c416                	sw	t0,8(sp)
    15da:	2b99                	jal	1b30 <strchr>
    15dc:	42a2                	lw	t0,8(sp)
    15de:	842a                	mv	s0,a0
    15e0:	c121                	beqz	a0,1620 <__v_printf+0x5a2>
    15e2:	06500593          	li	a1,101
    15e6:	23a9                	jal	1b30 <strchr>
    15e8:	42a2                	lw	t0,8(sp)
    15ea:	85aa                	mv	a1,a0
    15ec:	00044783          	lbu	a5,0(s0)
    15f0:	e7bd                	bnez	a5,165e <__v_printf+0x5e0>
    15f2:	c191                	beqz	a1,15f6 <__v_printf+0x578>
    15f4:	842e                	mv	s0,a1
    15f6:	03000693          	li	a3,48
    15fa:	8722                	mv	a4,s0
    15fc:	fff44783          	lbu	a5,-1(s0)
    1600:	147d                	addi	s0,s0,-1
    1602:	fed78ce3          	beq	a5,a3,15fa <__v_printf+0x57c>
    1606:	02e00693          	li	a3,46
    160a:	00d78363          	beq	a5,a3,1610 <__v_printf+0x592>
    160e:	843a                	mv	s0,a4
    1610:	00040023          	sb	zero,0(s0)
    1614:	c591                	beqz	a1,1620 <__v_printf+0x5a2>
    1616:	8522                	mv	a0,s0
    1618:	c416                	sw	t0,8(sp)
    161a:	3f3000ef          	jal	ra,220c <strcpy>
    161e:	42a2                	lw	t0,8(sp)
    1620:	47e2                	lw	a5,24(sp)
    1622:	e3ed                	bnez	a5,1704 <__v_printf+0x686>
    1624:	57b2                	lw	a5,44(sp)
    1626:	10079463          	bnez	a5,172e <__v_printf+0x6b0>
    162a:	4516                	lw	a0,68(sp)
    162c:	cc16                	sw	t0,24(sp)
    162e:	37d000ef          	jal	ra,21aa <strlen>
    1632:	42e2                	lw	t0,24(sp)
    1634:	5452                	lw	s0,52(sp)
    1636:	832a                	mv	t1,a0
    1638:	ca02                	sw	zero,20(sp)
    163a:	c402                	sw	zero,8(sp)
    163c:	b189                	j	127e <__v_printf+0x200>
    163e:	4782                	lw	a5,0(sp)
    1640:	17fd                	addi	a5,a5,-1
    1642:	c03e                	sw	a5,0(sp)
    1644:	bf9d                	j	15ba <__v_printf+0x53c>
    1646:	4722                	lw	a4,8(sp)
    1648:	d349                	beqz	a4,15ca <__v_printf+0x54c>
    164a:	97a2                	add	a5,a5,s0
    164c:	02e00713          	li	a4,46
    1650:	00e78023          	sb	a4,0(a5)
    1654:	4516                	lw	a0,68(sp)
    1656:	942a                	add	s0,s0,a0
    1658:	000400a3          	sb	zero,1(s0)
    165c:	b7bd                	j	15ca <__v_printf+0x54c>
    165e:	0405                	addi	s0,s0,1
    1660:	b771                	j	15ec <__v_printf+0x56e>
    1662:	57fd                	li	a5,-1
    1664:	c23e                	sw	a5,4(sp)
    1666:	40ce                	lw	ra,208(sp)
    1668:	443e                	lw	s0,204(sp)
    166a:	4512                	lw	a0,4(sp)
    166c:	44ae                	lw	s1,200(sp)
    166e:	0d410113          	addi	sp,sp,212
    1672:	8082                	ret
    1674:	47a2                	lw	a5,8(sp)
    1676:	c40790e3          	bnez	a5,12b6 <__v_printf+0x238>
    167a:	4785                	li	a5,1
    167c:	b935                	j	12b8 <__v_printf+0x23a>
    167e:	5782                	lw	a5,32(sp)
    1680:	c60793e3          	bnez	a5,12e6 <__v_printf+0x268>
    1684:	4781                	li	a5,0
    1686:	4752                	lw	a4,20(sp)
    1688:	ca0703e3          	beqz	a4,132e <__v_printf+0x2b0>
    168c:	4582                	lw	a1,0(sp)
    168e:	0065f363          	bgeu	a1,t1,1694 <__v_printf+0x616>
    1692:	859a                	mv	a1,t1
    1694:	ca3e                	sw	a5,20(sp)
    1696:	47b2                	lw	a5,12(sp)
    1698:	02000613          	li	a2,32
    169c:	8526                	mv	a0,s1
    169e:	40b785b3          	sub	a1,a5,a1
    16a2:	c41a                	sw	t1,8(sp)
    16a4:	cc36                	sw	a3,24(sp)
    16a6:	97bff0ef          	jal	ra,1020 <write_pad>
    16aa:	4792                	lw	a5,4(sp)
    16ac:	4322                	lw	t1,8(sp)
    16ae:	00f50733          	add	a4,a0,a5
    16b2:	47d2                	lw	a5,20(sp)
    16b4:	cf99                	beqz	a5,16d2 <__v_printf+0x654>
    16b6:	46e2                	lw	a3,24(sp)
    16b8:	0044a383          	lw	t2,4(s1)
    16bc:	4090                	lw	a2,0(s1)
    16be:	85be                	mv	a1,a5
    16c0:	8536                	mv	a0,a3
    16c2:	c61a                	sw	t1,12(sp)
    16c4:	c43a                	sw	a4,8(sp)
    16c6:	c23e                	sw	a5,4(sp)
    16c8:	9382                	jalr	t2
    16ca:	4792                	lw	a5,4(sp)
    16cc:	4722                	lw	a4,8(sp)
    16ce:	4332                	lw	t1,12(sp)
    16d0:	973e                	add	a4,a4,a5
    16d2:	4782                	lw	a5,0(sp)
    16d4:	03000613          	li	a2,48
    16d8:	8526                	mv	a0,s1
    16da:	406785b3          	sub	a1,a5,t1
    16de:	c23a                	sw	a4,4(sp)
    16e0:	c01a                	sw	t1,0(sp)
    16e2:	93fff0ef          	jal	ra,1020 <write_pad>
    16e6:	4712                	lw	a4,4(sp)
    16e8:	4302                	lw	t1,0(sp)
    16ea:	972a                	add	a4,a4,a0
    16ec:	40dc                	lw	a5,4(s1)
    16ee:	4090                	lw	a2,0(s1)
    16f0:	4516                	lw	a0,68(sp)
    16f2:	859a                	mv	a1,t1
    16f4:	c23a                	sw	a4,4(sp)
    16f6:	c01a                	sw	t1,0(sp)
    16f8:	9782                	jalr	a5
    16fa:	4302                	lw	t1,0(sp)
    16fc:	4712                	lw	a4,4(sp)
    16fe:	006707b3          	add	a5,a4,t1
    1702:	b615                	j	1226 <__v_printf+0x1a8>
    1704:	5712                	lw	a4,36(sp)
    1706:	57a2                	lw	a5,40(sp)
    1708:	4601                	li	a2,0
    170a:	4681                	li	a3,0
    170c:	853a                	mv	a0,a4
    170e:	85be                	mv	a1,a5
    1710:	c416                	sw	t0,8(sp)
    1712:	627010ef          	jal	ra,3538 <__gedf2>
    1716:	42a2                	lw	t0,8(sp)
    1718:	f00549e3          	bltz	a0,162a <__v_printf+0x5ac>
    171c:	02b00793          	li	a5,43
    1720:	4716                	lw	a4,68(sp)
    1722:	fff70693          	addi	a3,a4,-1
    1726:	c2b6                	sw	a3,68(sp)
    1728:	fef70fa3          	sb	a5,-1(a4)
    172c:	bdfd                	j	162a <__v_printf+0x5ac>
    172e:	57a2                	lw	a5,40(sp)
    1730:	5712                	lw	a4,36(sp)
    1732:	4601                	li	a2,0
    1734:	85be                	mv	a1,a5
    1736:	4681                	li	a3,0
    1738:	853a                	mv	a0,a4
    173a:	c416                	sw	t0,8(sp)
    173c:	5fd010ef          	jal	ra,3538 <__gedf2>
    1740:	42a2                	lw	t0,8(sp)
    1742:	02000793          	li	a5,32
    1746:	fc055de3          	bgez	a0,1720 <__v_printf+0x6a2>
    174a:	b5c5                	j	162a <__v_printf+0x5ac>
    174c:	9c0596e3          	bnez	a1,1118 <__v_printf+0x9a>
    1750:	47c2                	lw	a5,16(sp)
    1752:	b2e5                	j	113a <__v_printf+0xbc>

00001754 <__stdio_outs>:
    1754:	1151                	addi	sp,sp,-12
    1756:	c222                	sw	s0,4(sp)
    1758:	c026                	sw	s1,0(sp)
    175a:	842a                	mv	s0,a0
    175c:	84ae                	mv	s1,a1
    175e:	c406                	sw	ra,8(sp)
    1760:	94a2                	add	s1,s1,s0
    1762:	f07fe0ef          	jal	ra,668 <os_critical_enter>
    1766:	200007b7          	lui	a5,0x20000
    176a:	00941a63          	bne	s0,s1,177e <__stdio_outs+0x2a>
    176e:	f09fe0ef          	jal	ra,676 <os_critical_exit>
    1772:	40a2                	lw	ra,8(sp)
    1774:	4412                	lw	s0,4(sp)
    1776:	4482                	lw	s1,0(sp)
    1778:	4505                	li	a0,1
    177a:	0131                	addi	sp,sp,12
    177c:	8082                	ret
    177e:	1207a703          	lw	a4,288(a5) # 20000120 <_impure_ptr>
    1782:	00044503          	lbu	a0,0(s0)
    1786:	0405                	addi	s0,s0,1
    1788:	470c                	lw	a1,8(a4)
    178a:	ea5fe0ef          	jal	ra,62e <fputc>
    178e:	bfe1                	j	1766 <__stdio_outs+0x12>

00001790 <vprintf>:
    1790:	1131                	addi	sp,sp,-20
    1792:	6785                	lui	a5,0x1
    1794:	862e                	mv	a2,a1
    1796:	75478793          	addi	a5,a5,1876 # 1754 <__stdio_outs>
    179a:	85aa                	mv	a1,a0
    179c:	850a                	mv	a0,sp
    179e:	c806                	sw	ra,16(sp)
    17a0:	c002                	sw	zero,0(sp)
    17a2:	c23e                	sw	a5,4(sp)
    17a4:	8dbff0ef          	jal	ra,107e <__v_printf>
    17a8:	40c2                	lw	ra,16(sp)
    17aa:	0151                	addi	sp,sp,20
    17ac:	8082                	ret

000017ae <_strtol_l.part.0>:
    17ae:	1111                	addi	sp,sp,-28
    17b0:	c82a                	sw	a0,16(sp)
    17b2:	6511                	lui	a0,0x4
    17b4:	cc22                	sw	s0,24(sp)
    17b6:	ca26                	sw	s1,20(sp)
    17b8:	872e                	mv	a4,a1
    17ba:	c42e                	sw	a1,8(sp)
    17bc:	c032                	sw	a2,0(sp)
    17be:	4f150513          	addi	a0,a0,1265 # 44f1 <_ctype_+0x1>
    17c2:	00074783          	lbu	a5,0(a4)
    17c6:	85ba                	mv	a1,a4
    17c8:	0705                	addi	a4,a4,1
    17ca:	00f50633          	add	a2,a0,a5
    17ce:	00064603          	lbu	a2,0(a2)
    17d2:	8a21                	andi	a2,a2,8
    17d4:	f67d                	bnez	a2,17c2 <_strtol_l.part.0+0x14>
    17d6:	02d00613          	li	a2,45
    17da:	0cc78f63          	beq	a5,a2,18b8 <_strtol_l.part.0+0x10a>
    17de:	02b00613          	li	a2,43
    17e2:	06c78063          	beq	a5,a2,1842 <_strtol_l.part.0+0x94>
    17e6:	800004b7          	lui	s1,0x80000
    17ea:	fff4c493          	not	s1,s1
    17ee:	c602                	sw	zero,12(sp)
    17f0:	c2bd                	beqz	a3,1856 <_strtol_l.part.0+0xa8>
    17f2:	4641                	li	a2,16
    17f4:	8436                	mv	s0,a3
    17f6:	0cc68a63          	beq	a3,a2,18ca <_strtol_l.part.0+0x11c>
    17fa:	0284f633          	remu	a2,s1,s0
    17fe:	4581                	li	a1,0
    1800:	4501                	li	a0,0
    1802:	4325                	li	t1,9
    1804:	43e5                	li	t2,25
    1806:	0284d2b3          	divu	t0,s1,s0
    180a:	c232                	sw	a2,4(sp)
    180c:	fd078613          	addi	a2,a5,-48
    1810:	00c37863          	bgeu	t1,a2,1820 <_strtol_l.part.0+0x72>
    1814:	fbf78613          	addi	a2,a5,-65
    1818:	04c3e863          	bltu	t2,a2,1868 <_strtol_l.part.0+0xba>
    181c:	fc978613          	addi	a2,a5,-55
    1820:	04d65c63          	bge	a2,a3,1878 <_strtol_l.part.0+0xca>
    1824:	0405c063          	bltz	a1,1864 <_strtol_l.part.0+0xb6>
    1828:	55fd                	li	a1,-1
    182a:	00a2e863          	bltu	t0,a0,183a <_strtol_l.part.0+0x8c>
    182e:	06a28563          	beq	t0,a0,1898 <_strtol_l.part.0+0xea>
    1832:	4585                	li	a1,1
    1834:	02850533          	mul	a0,a0,s0
    1838:	9532                	add	a0,a0,a2
    183a:	0705                	addi	a4,a4,1
    183c:	fff74783          	lbu	a5,-1(a4)
    1840:	b7f1                	j	180c <_strtol_l.part.0+0x5e>
    1842:	800004b7          	lui	s1,0x80000
    1846:	c602                	sw	zero,12(sp)
    1848:	00074783          	lbu	a5,0(a4)
    184c:	fff4c493          	not	s1,s1
    1850:	00258713          	addi	a4,a1,2
    1854:	fed9                	bnez	a3,17f2 <_strtol_l.part.0+0x44>
    1856:	03000693          	li	a3,48
    185a:	08d78c63          	beq	a5,a3,18f2 <_strtol_l.part.0+0x144>
    185e:	4429                	li	s0,10
    1860:	46a9                	li	a3,10
    1862:	bf61                	j	17fa <_strtol_l.part.0+0x4c>
    1864:	55fd                	li	a1,-1
    1866:	bfd1                	j	183a <_strtol_l.part.0+0x8c>
    1868:	f9f78613          	addi	a2,a5,-97
    186c:	00c3e663          	bltu	t2,a2,1878 <_strtol_l.part.0+0xca>
    1870:	fa978613          	addi	a2,a5,-87
    1874:	fad648e3          	blt	a2,a3,1824 <_strtol_l.part.0+0x76>
    1878:	0205c463          	bltz	a1,18a0 <_strtol_l.part.0+0xf2>
    187c:	47b2                	lw	a5,12(sp)
    187e:	c399                	beqz	a5,1884 <_strtol_l.part.0+0xd6>
    1880:	40a00533          	neg	a0,a0
    1884:	4782                	lw	a5,0(sp)
    1886:	c789                	beqz	a5,1890 <_strtol_l.part.0+0xe2>
    1888:	e1c1                	bnez	a1,1908 <_strtol_l.part.0+0x15a>
    188a:	4782                	lw	a5,0(sp)
    188c:	4722                	lw	a4,8(sp)
    188e:	c398                	sw	a4,0(a5)
    1890:	4462                	lw	s0,24(sp)
    1892:	44d2                	lw	s1,20(sp)
    1894:	0171                	addi	sp,sp,28
    1896:	8082                	ret
    1898:	4792                	lw	a5,4(sp)
    189a:	fac7c0e3          	blt	a5,a2,183a <_strtol_l.part.0+0x8c>
    189e:	bf51                	j	1832 <_strtol_l.part.0+0x84>
    18a0:	46c2                	lw	a3,16(sp)
    18a2:	02200793          	li	a5,34
    18a6:	8526                	mv	a0,s1
    18a8:	c29c                	sw	a5,0(a3)
    18aa:	4782                	lw	a5,0(sp)
    18ac:	d3f5                	beqz	a5,1890 <_strtol_l.part.0+0xe2>
    18ae:	fff70793          	addi	a5,a4,-1
    18b2:	c43e                	sw	a5,8(sp)
    18b4:	8526                	mv	a0,s1
    18b6:	bfd1                	j	188a <_strtol_l.part.0+0xdc>
    18b8:	4605                	li	a2,1
    18ba:	00074783          	lbu	a5,0(a4)
    18be:	800004b7          	lui	s1,0x80000
    18c2:	00258713          	addi	a4,a1,2
    18c6:	c632                	sw	a2,12(sp)
    18c8:	b725                	j	17f0 <_strtol_l.part.0+0x42>
    18ca:	03000613          	li	a2,48
    18ce:	00c79a63          	bne	a5,a2,18e2 <_strtol_l.part.0+0x134>
    18d2:	00074603          	lbu	a2,0(a4)
    18d6:	05800593          	li	a1,88
    18da:	0df67613          	andi	a2,a2,223
    18de:	00b60463          	beq	a2,a1,18e6 <_strtol_l.part.0+0x138>
    18e2:	4441                	li	s0,16
    18e4:	bf19                	j	17fa <_strtol_l.part.0+0x4c>
    18e6:	00174783          	lbu	a5,1(a4)
    18ea:	4441                	li	s0,16
    18ec:	0709                	addi	a4,a4,2
    18ee:	46c1                	li	a3,16
    18f0:	b729                	j	17fa <_strtol_l.part.0+0x4c>
    18f2:	00074683          	lbu	a3,0(a4)
    18f6:	05800613          	li	a2,88
    18fa:	0df6f693          	andi	a3,a3,223
    18fe:	fec684e3          	beq	a3,a2,18e6 <_strtol_l.part.0+0x138>
    1902:	4421                	li	s0,8
    1904:	46a1                	li	a3,8
    1906:	bdd5                	j	17fa <_strtol_l.part.0+0x4c>
    1908:	84aa                	mv	s1,a0
    190a:	b755                	j	18ae <_strtol_l.part.0+0x100>

0000190c <_strtol_r>:
    190c:	4705                	li	a4,1
    190e:	00e68763          	beq	a3,a4,191c <_strtol_r+0x10>
    1912:	02400713          	li	a4,36
    1916:	00d76363          	bltu	a4,a3,191c <_strtol_r+0x10>
    191a:	bd51                	j	17ae <_strtol_l.part.0>
    191c:	1151                	addi	sp,sp,-12
    191e:	c406                	sw	ra,8(sp)
    1920:	23e5                	jal	1f08 <__errno>
    1922:	40a2                	lw	ra,8(sp)
    1924:	47d9                	li	a5,22
    1926:	c11c                	sw	a5,0(a0)
    1928:	4501                	li	a0,0
    192a:	0131                	addi	sp,sp,12
    192c:	8082                	ret

0000192e <strtol_l>:
    192e:	4705                	li	a4,1
    1930:	00e60f63          	beq	a2,a4,194e <strtol_l+0x20>
    1934:	02400713          	li	a4,36
    1938:	00c76b63          	bltu	a4,a2,194e <strtol_l+0x20>
    193c:	20000737          	lui	a4,0x20000
    1940:	87aa                	mv	a5,a0
    1942:	12072503          	lw	a0,288(a4) # 20000120 <_impure_ptr>
    1946:	86b2                	mv	a3,a2
    1948:	862e                	mv	a2,a1
    194a:	85be                	mv	a1,a5
    194c:	b58d                	j	17ae <_strtol_l.part.0>
    194e:	1151                	addi	sp,sp,-12
    1950:	c406                	sw	ra,8(sp)
    1952:	2b5d                	jal	1f08 <__errno>
    1954:	40a2                	lw	ra,8(sp)
    1956:	47d9                	li	a5,22
    1958:	c11c                	sw	a5,0(a0)
    195a:	4501                	li	a0,0
    195c:	0131                	addi	sp,sp,12
    195e:	8082                	ret

00001960 <strtol>:
    1960:	4705                	li	a4,1
    1962:	00e60f63          	beq	a2,a4,1980 <strtol+0x20>
    1966:	02400713          	li	a4,36
    196a:	00c76b63          	bltu	a4,a2,1980 <strtol+0x20>
    196e:	20000737          	lui	a4,0x20000
    1972:	87aa                	mv	a5,a0
    1974:	12072503          	lw	a0,288(a4) # 20000120 <_impure_ptr>
    1978:	86b2                	mv	a3,a2
    197a:	862e                	mv	a2,a1
    197c:	85be                	mv	a1,a5
    197e:	bd05                	j	17ae <_strtol_l.part.0>
    1980:	1151                	addi	sp,sp,-12
    1982:	c406                	sw	ra,8(sp)
    1984:	2351                	jal	1f08 <__errno>
    1986:	40a2                	lw	ra,8(sp)
    1988:	47d9                	li	a5,22
    198a:	c11c                	sw	a5,0(a0)
    198c:	4501                	li	a0,0
    198e:	0131                	addi	sp,sp,12
    1990:	8082                	ret

00001992 <_strtoul_l.constprop.0>:
    1992:	1121                	addi	sp,sp,-24
    1994:	6311                	lui	t1,0x4
    1996:	ca22                	sw	s0,20(sp)
    1998:	c826                	sw	s1,16(sp)
    199a:	c62a                	sw	a0,12(sp)
    199c:	c032                	sw	a2,0(sp)
    199e:	872e                	mv	a4,a1
    19a0:	4f130313          	addi	t1,t1,1265 # 44f1 <_ctype_+0x1>
    19a4:	00074783          	lbu	a5,0(a4)
    19a8:	853a                	mv	a0,a4
    19aa:	0705                	addi	a4,a4,1
    19ac:	00f30633          	add	a2,t1,a5
    19b0:	00064603          	lbu	a2,0(a2)
    19b4:	8a21                	andi	a2,a2,8
    19b6:	f67d                	bnez	a2,19a4 <_strtoul_l.constprop.0+0x12>
    19b8:	02d00613          	li	a2,45
    19bc:	0cc78b63          	beq	a5,a2,1a92 <_strtoul_l.constprop.0+0x100>
    19c0:	02b00613          	li	a2,43
    19c4:	c402                	sw	zero,8(sp)
    19c6:	06c78963          	beq	a5,a2,1a38 <_strtoul_l.constprop.0+0xa6>
    19ca:	ce81                	beqz	a3,19e2 <_strtoul_l.constprop.0+0x50>
    19cc:	4641                	li	a2,16
    19ce:	0cc68963          	beq	a3,a2,1aa0 <_strtoul_l.constprop.0+0x10e>
    19d2:	567d                	li	a2,-1
    19d4:	02d653b3          	divu	t2,a2,a3
    19d8:	84b6                	mv	s1,a3
    19da:	02d67633          	remu	a2,a2,a3
    19de:	c232                	sw	a2,4(sp)
    19e0:	a829                	j	19fa <_strtoul_l.constprop.0+0x68>
    19e2:	03000693          	li	a3,48
    19e6:	0ed78463          	beq	a5,a3,1ace <_strtoul_l.constprop.0+0x13c>
    19ea:	4695                	li	a3,5
    19ec:	1999a3b7          	lui	t2,0x1999a
    19f0:	c236                	sw	a3,4(sp)
    19f2:	99938393          	addi	t2,t2,-1639 # 19999999 <__erodata+0x199948f1>
    19f6:	44a9                	li	s1,10
    19f8:	46a9                	li	a3,10
    19fa:	4301                	li	t1,0
    19fc:	4501                	li	a0,0
    19fe:	42a5                	li	t0,9
    1a00:	4465                	li	s0,25
    1a02:	fd078613          	addi	a2,a5,-48
    1a06:	00c2f863          	bgeu	t0,a2,1a16 <_strtoul_l.constprop.0+0x84>
    1a0a:	fbf78613          	addi	a2,a5,-65
    1a0e:	02c46c63          	bltu	s0,a2,1a46 <_strtoul_l.constprop.0+0xb4>
    1a12:	fc978613          	addi	a2,a5,-55
    1a16:	04d65063          	bge	a2,a3,1a56 <_strtoul_l.constprop.0+0xc4>
    1a1a:	02034463          	bltz	t1,1a42 <_strtoul_l.constprop.0+0xb0>
    1a1e:	537d                	li	t1,-1
    1a20:	00a3e863          	bltu	t2,a0,1a30 <_strtoul_l.constprop.0+0x9e>
    1a24:	04750963          	beq	a0,t2,1a76 <_strtoul_l.constprop.0+0xe4>
    1a28:	02950533          	mul	a0,a0,s1
    1a2c:	4305                	li	t1,1
    1a2e:	9532                	add	a0,a0,a2
    1a30:	0705                	addi	a4,a4,1
    1a32:	fff74783          	lbu	a5,-1(a4)
    1a36:	b7f1                	j	1a02 <_strtoul_l.constprop.0+0x70>
    1a38:	00074783          	lbu	a5,0(a4)
    1a3c:	00250713          	addi	a4,a0,2
    1a40:	b769                	j	19ca <_strtoul_l.constprop.0+0x38>
    1a42:	537d                	li	t1,-1
    1a44:	b7f5                	j	1a30 <_strtoul_l.constprop.0+0x9e>
    1a46:	f9f78613          	addi	a2,a5,-97
    1a4a:	00c46663          	bltu	s0,a2,1a56 <_strtoul_l.constprop.0+0xc4>
    1a4e:	fa978613          	addi	a2,a5,-87
    1a52:	fcd644e3          	blt	a2,a3,1a1a <_strtoul_l.constprop.0+0x88>
    1a56:	02034463          	bltz	t1,1a7e <_strtoul_l.constprop.0+0xec>
    1a5a:	47a2                	lw	a5,8(sp)
    1a5c:	c399                	beqz	a5,1a62 <_strtoul_l.constprop.0+0xd0>
    1a5e:	40a00533          	neg	a0,a0
    1a62:	4782                	lw	a5,0(sp)
    1a64:	c789                	beqz	a5,1a6e <_strtoul_l.constprop.0+0xdc>
    1a66:	02031363          	bnez	t1,1a8c <_strtoul_l.constprop.0+0xfa>
    1a6a:	4782                	lw	a5,0(sp)
    1a6c:	c38c                	sw	a1,0(a5)
    1a6e:	4452                	lw	s0,20(sp)
    1a70:	44c2                	lw	s1,16(sp)
    1a72:	0161                	addi	sp,sp,24
    1a74:	8082                	ret
    1a76:	4792                	lw	a5,4(sp)
    1a78:	fac7cce3          	blt	a5,a2,1a30 <_strtoul_l.constprop.0+0x9e>
    1a7c:	b775                	j	1a28 <_strtoul_l.constprop.0+0x96>
    1a7e:	46b2                	lw	a3,12(sp)
    1a80:	02200793          	li	a5,34
    1a84:	557d                	li	a0,-1
    1a86:	c29c                	sw	a5,0(a3)
    1a88:	4782                	lw	a5,0(sp)
    1a8a:	d3f5                	beqz	a5,1a6e <_strtoul_l.constprop.0+0xdc>
    1a8c:	fff70593          	addi	a1,a4,-1
    1a90:	bfe9                	j	1a6a <_strtoul_l.constprop.0+0xd8>
    1a92:	00074783          	lbu	a5,0(a4)
    1a96:	4705                	li	a4,1
    1a98:	c43a                	sw	a4,8(sp)
    1a9a:	00250713          	addi	a4,a0,2
    1a9e:	b735                	j	19ca <_strtoul_l.constprop.0+0x38>
    1aa0:	03000613          	li	a2,48
    1aa4:	04c79c63          	bne	a5,a2,1afc <_strtoul_l.constprop.0+0x16a>
    1aa8:	00074603          	lbu	a2,0(a4)
    1aac:	05800513          	li	a0,88
    1ab0:	0df67613          	andi	a2,a2,223
    1ab4:	02a61d63          	bne	a2,a0,1aee <_strtoul_l.constprop.0+0x15c>
    1ab8:	46bd                	li	a3,15
    1aba:	100003b7          	lui	t2,0x10000
    1abe:	00174783          	lbu	a5,1(a4)
    1ac2:	c236                	sw	a3,4(sp)
    1ac4:	0709                	addi	a4,a4,2
    1ac6:	13fd                	addi	t2,t2,-1
    1ac8:	44c1                	li	s1,16
    1aca:	46c1                	li	a3,16
    1acc:	b73d                	j	19fa <_strtoul_l.constprop.0+0x68>
    1ace:	00074683          	lbu	a3,0(a4)
    1ad2:	05800613          	li	a2,88
    1ad6:	0df6f693          	andi	a3,a3,223
    1ada:	fcc68fe3          	beq	a3,a2,1ab8 <_strtoul_l.constprop.0+0x126>
    1ade:	469d                	li	a3,7
    1ae0:	200003b7          	lui	t2,0x20000
    1ae4:	c236                	sw	a3,4(sp)
    1ae6:	13fd                	addi	t2,t2,-1
    1ae8:	44a1                	li	s1,8
    1aea:	46a1                	li	a3,8
    1aec:	b739                	j	19fa <_strtoul_l.constprop.0+0x68>
    1aee:	53fd                	li	t2,-1
    1af0:	463d                	li	a2,15
    1af2:	02d3d3b3          	divu	t2,t2,a3
    1af6:	44c1                	li	s1,16
    1af8:	c232                	sw	a2,4(sp)
    1afa:	b701                	j	19fa <_strtoul_l.constprop.0+0x68>
    1afc:	463d                	li	a2,15
    1afe:	100003b7          	lui	t2,0x10000
    1b02:	c232                	sw	a2,4(sp)
    1b04:	13fd                	addi	t2,t2,-1
    1b06:	44c1                	li	s1,16
    1b08:	bdcd                	j	19fa <_strtoul_l.constprop.0+0x68>

00001b0a <_strtoul_r>:
    1b0a:	b561                	j	1992 <_strtoul_l.constprop.0>

00001b0c <strtoul_l>:
    1b0c:	20000737          	lui	a4,0x20000
    1b10:	87aa                	mv	a5,a0
    1b12:	12072503          	lw	a0,288(a4) # 20000120 <_impure_ptr>
    1b16:	86b2                	mv	a3,a2
    1b18:	862e                	mv	a2,a1
    1b1a:	85be                	mv	a1,a5
    1b1c:	bd9d                	j	1992 <_strtoul_l.constprop.0>

00001b1e <strtoul>:
    1b1e:	20000737          	lui	a4,0x20000
    1b22:	87aa                	mv	a5,a0
    1b24:	12072503          	lw	a0,288(a4) # 20000120 <_impure_ptr>
    1b28:	86b2                	mv	a3,a2
    1b2a:	862e                	mv	a2,a1
    1b2c:	85be                	mv	a1,a5
    1b2e:	b595                	j	1992 <_strtoul_l.constprop.0>

00001b30 <strchr>:
    1b30:	0ff5f693          	zext.b	a3,a1
    1b34:	00357793          	andi	a5,a0,3
    1b38:	cec1                	beqz	a3,1bd0 <strchr+0xa0>
    1b3a:	cb91                	beqz	a5,1b4e <strchr+0x1e>
    1b3c:	00054783          	lbu	a5,0(a0)
    1b40:	c7d1                	beqz	a5,1bcc <strchr+0x9c>
    1b42:	08d78663          	beq	a5,a3,1bce <strchr+0x9e>
    1b46:	0505                	addi	a0,a0,1
    1b48:	00357793          	andi	a5,a0,3
    1b4c:	fbe5                	bnez	a5,1b3c <strchr+0xc>
    1b4e:	0ff5f593          	zext.b	a1,a1
    1b52:	00859313          	slli	t1,a1,0x8
    1b56:	4118                	lw	a4,0(a0)
    1b58:	0065e5b3          	or	a1,a1,t1
    1b5c:	01059313          	slli	t1,a1,0x10
    1b60:	00b36333          	or	t1,t1,a1
    1b64:	feff0637          	lui	a2,0xfeff0
    1b68:	00e345b3          	xor	a1,t1,a4
    1b6c:	eff60613          	addi	a2,a2,-257 # fefefeff <MTIME_HI_ADDR+0x1efe3f03>
    1b70:	00c587b3          	add	a5,a1,a2
    1b74:	00c702b3          	add	t0,a4,a2
    1b78:	fff5c593          	not	a1,a1
    1b7c:	fff74713          	not	a4,a4
    1b80:	8fed                	and	a5,a5,a1
    1b82:	00e2f733          	and	a4,t0,a4
    1b86:	808085b7          	lui	a1,0x80808
    1b8a:	8fd9                	or	a5,a5,a4
    1b8c:	08058593          	addi	a1,a1,128 # 80808080 <MTIME_HI_ADDR+0xa07fc084>
    1b90:	8fed                	and	a5,a5,a1
    1b92:	e785                	bnez	a5,1bba <strchr+0x8a>
    1b94:	4158                	lw	a4,4(a0)
    1b96:	0511                	addi	a0,a0,4
    1b98:	006742b3          	xor	t0,a4,t1
    1b9c:	00c707b3          	add	a5,a4,a2
    1ba0:	00c283b3          	add	t2,t0,a2
    1ba4:	fff74713          	not	a4,a4
    1ba8:	fff2c293          	not	t0,t0
    1bac:	8ff9                	and	a5,a5,a4
    1bae:	0053f2b3          	and	t0,t2,t0
    1bb2:	0057e7b3          	or	a5,a5,t0
    1bb6:	8fed                	and	a5,a5,a1
    1bb8:	dff1                	beqz	a5,1b94 <strchr+0x64>
    1bba:	00054783          	lbu	a5,0(a0)
    1bbe:	c799                	beqz	a5,1bcc <strchr+0x9c>
    1bc0:	06f68163          	beq	a3,a5,1c22 <strchr+0xf2>
    1bc4:	00154783          	lbu	a5,1(a0)
    1bc8:	0505                	addi	a0,a0,1
    1bca:	fbfd                	bnez	a5,1bc0 <strchr+0x90>
    1bcc:	4501                	li	a0,0
    1bce:	8082                	ret
    1bd0:	cb81                	beqz	a5,1be0 <strchr+0xb0>
    1bd2:	00054783          	lbu	a5,0(a0)
    1bd6:	dfe5                	beqz	a5,1bce <strchr+0x9e>
    1bd8:	0505                	addi	a0,a0,1
    1bda:	00357793          	andi	a5,a0,3
    1bde:	fbf5                	bnez	a5,1bd2 <strchr+0xa2>
    1be0:	4118                	lw	a4,0(a0)
    1be2:	feff0637          	lui	a2,0xfeff0
    1be6:	eff60613          	addi	a2,a2,-257 # fefefeff <MTIME_HI_ADDR+0x1efe3f03>
    1bea:	00c707b3          	add	a5,a4,a2
    1bee:	808086b7          	lui	a3,0x80808
    1bf2:	fff74713          	not	a4,a4
    1bf6:	8ff9                	and	a5,a5,a4
    1bf8:	08068693          	addi	a3,a3,128 # 80808080 <MTIME_HI_ADDR+0xa07fc084>
    1bfc:	8ff5                	and	a5,a5,a3
    1bfe:	eb91                	bnez	a5,1c12 <strchr+0xe2>
    1c00:	4158                	lw	a4,4(a0)
    1c02:	0511                	addi	a0,a0,4
    1c04:	00c707b3          	add	a5,a4,a2
    1c08:	fff74713          	not	a4,a4
    1c0c:	8ff9                	and	a5,a5,a4
    1c0e:	8ff5                	and	a5,a5,a3
    1c10:	dbe5                	beqz	a5,1c00 <strchr+0xd0>
    1c12:	00054783          	lbu	a5,0(a0)
    1c16:	dfc5                	beqz	a5,1bce <strchr+0x9e>
    1c18:	00154783          	lbu	a5,1(a0)
    1c1c:	0505                	addi	a0,a0,1
    1c1e:	ffed                	bnez	a5,1c18 <strchr+0xe8>
    1c20:	8082                	ret
    1c22:	8082                	ret

00001c24 <_strerror_r>:
    1c24:	87ae                	mv	a5,a1
    1c26:	08e00713          	li	a4,142
    1c2a:	85b2                	mv	a1,a2
    1c2c:	00f76a63          	bltu	a4,a5,1c40 <_strerror_r+0x1c>
    1c30:	6315                	lui	t1,0x5
    1c32:	00279713          	slli	a4,a5,0x2
    1c36:	cf430313          	addi	t1,t1,-780 # 4cf4 <_ctype_+0x804>
    1c3a:	971a                	add	a4,a4,t1
    1c3c:	4318                	lw	a4,0(a4)
    1c3e:	8702                	jr	a4
    1c40:	1151                	addi	sp,sp,-12
    1c42:	c406                	sw	ra,8(sp)
    1c44:	28068e63          	beqz	a3,1ee0 <_strerror_r+0x2bc>
    1c48:	8636                	mv	a2,a3
    1c4a:	853e                	mv	a0,a5
    1c4c:	2c65                	jal	1f04 <_user_strerror>
    1c4e:	28050563          	beqz	a0,1ed8 <_strerror_r+0x2b4>
    1c52:	40a2                	lw	ra,8(sp)
    1c54:	0131                	addi	sp,sp,12
    1c56:	8082                	ret
    1c58:	6515                	lui	a0,0x5
    1c5a:	c6050513          	addi	a0,a0,-928 # 4c60 <_ctype_+0x770>
    1c5e:	8082                	ret
    1c60:	6515                	lui	a0,0x5
    1c62:	c4850513          	addi	a0,a0,-952 # 4c48 <_ctype_+0x758>
    1c66:	8082                	ret
    1c68:	6515                	lui	a0,0x5
    1c6a:	c0050513          	addi	a0,a0,-1024 # 4c00 <_ctype_+0x710>
    1c6e:	8082                	ret
    1c70:	6515                	lui	a0,0x5
    1c72:	c1850513          	addi	a0,a0,-1000 # 4c18 <_ctype_+0x728>
    1c76:	8082                	ret
    1c78:	6515                	lui	a0,0x5
    1c7a:	80450513          	addi	a0,a0,-2044 # 4804 <_ctype_+0x314>
    1c7e:	8082                	ret
    1c80:	6515                	lui	a0,0x5
    1c82:	bc450513          	addi	a0,a0,-1084 # 4bc4 <_ctype_+0x6d4>
    1c86:	8082                	ret
    1c88:	6515                	lui	a0,0x5
    1c8a:	a3850513          	addi	a0,a0,-1480 # 4a38 <_ctype_+0x548>
    1c8e:	8082                	ret
    1c90:	6515                	lui	a0,0x5
    1c92:	cc050513          	addi	a0,a0,-832 # 4cc0 <_ctype_+0x7d0>
    1c96:	8082                	ret
    1c98:	6511                	lui	a0,0x4
    1c9a:	6cc50513          	addi	a0,a0,1740 # 46cc <_ctype_+0x1dc>
    1c9e:	8082                	ret
    1ca0:	6511                	lui	a0,0x4
    1ca2:	69450513          	addi	a0,a0,1684 # 4694 <_ctype_+0x1a4>
    1ca6:	8082                	ret
    1ca8:	6515                	lui	a0,0x5
    1caa:	c3450513          	addi	a0,a0,-972 # 4c34 <_ctype_+0x744>
    1cae:	8082                	ret
    1cb0:	6515                	lui	a0,0x5
    1cb2:	c9850513          	addi	a0,a0,-872 # 4c98 <_ctype_+0x7a8>
    1cb6:	8082                	ret
    1cb8:	6515                	lui	a0,0x5
    1cba:	99050513          	addi	a0,a0,-1648 # 4990 <_ctype_+0x4a0>
    1cbe:	8082                	ret
    1cc0:	6515                	lui	a0,0x5
    1cc2:	8c850513          	addi	a0,a0,-1848 # 48c8 <_ctype_+0x3d8>
    1cc6:	8082                	ret
    1cc8:	6511                	lui	a0,0x4
    1cca:	79c50513          	addi	a0,a0,1948 # 479c <_ctype_+0x2ac>
    1cce:	8082                	ret
    1cd0:	6515                	lui	a0,0x5
    1cd2:	89c50513          	addi	a0,a0,-1892 # 489c <_ctype_+0x3ac>
    1cd6:	8082                	ret
    1cd8:	6511                	lui	a0,0x4
    1cda:	78c50513          	addi	a0,a0,1932 # 478c <_ctype_+0x29c>
    1cde:	8082                	ret
    1ce0:	6515                	lui	a0,0x5
    1ce2:	cd450513          	addi	a0,a0,-812 # 4cd4 <_ctype_+0x7e4>
    1ce6:	8082                	ret
    1ce8:	6511                	lui	a0,0x4
    1cea:	7e050513          	addi	a0,a0,2016 # 47e0 <_ctype_+0x2f0>
    1cee:	8082                	ret
    1cf0:	6515                	lui	a0,0x5
    1cf2:	9b450513          	addi	a0,a0,-1612 # 49b4 <_ctype_+0x4c4>
    1cf6:	8082                	ret
    1cf8:	6515                	lui	a0,0x5
    1cfa:	bdc50513          	addi	a0,a0,-1060 # 4bdc <_ctype_+0x6ec>
    1cfe:	8082                	ret
    1d00:	6515                	lui	a0,0x5
    1d02:	bac50513          	addi	a0,a0,-1108 # 4bac <_ctype_+0x6bc>
    1d06:	8082                	ret
    1d08:	6515                	lui	a0,0x5
    1d0a:	b7c50513          	addi	a0,a0,-1156 # 4b7c <_ctype_+0x68c>
    1d0e:	8082                	ret
    1d10:	6515                	lui	a0,0x5
    1d12:	b6450513          	addi	a0,a0,-1180 # 4b64 <_ctype_+0x674>
    1d16:	8082                	ret
    1d18:	6515                	lui	a0,0x5
    1d1a:	b4450513          	addi	a0,a0,-1212 # 4b44 <_ctype_+0x654>
    1d1e:	8082                	ret
    1d20:	6515                	lui	a0,0x5
    1d22:	b2450513          	addi	a0,a0,-1244 # 4b24 <_ctype_+0x634>
    1d26:	8082                	ret
    1d28:	6515                	lui	a0,0x5
    1d2a:	af450513          	addi	a0,a0,-1292 # 4af4 <_ctype_+0x604>
    1d2e:	8082                	ret
    1d30:	6515                	lui	a0,0x5
    1d32:	ad050513          	addi	a0,a0,-1328 # 4ad0 <_ctype_+0x5e0>
    1d36:	8082                	ret
    1d38:	6515                	lui	a0,0x5
    1d3a:	b9050513          	addi	a0,a0,-1136 # 4b90 <_ctype_+0x6a0>
    1d3e:	8082                	ret
    1d40:	6515                	lui	a0,0x5
    1d42:	c7450513          	addi	a0,a0,-908 # 4c74 <_ctype_+0x784>
    1d46:	8082                	ret
    1d48:	6515                	lui	a0,0x5
    1d4a:	ab850513          	addi	a0,a0,-1352 # 4ab8 <_ctype_+0x5c8>
    1d4e:	8082                	ret
    1d50:	6515                	lui	a0,0x5
    1d52:	a9c50513          	addi	a0,a0,-1380 # 4a9c <_ctype_+0x5ac>
    1d56:	8082                	ret
    1d58:	6515                	lui	a0,0x5
    1d5a:	a8850513          	addi	a0,a0,-1400 # 4a88 <_ctype_+0x598>
    1d5e:	8082                	ret
    1d60:	6515                	lui	a0,0x5
    1d62:	a6c50513          	addi	a0,a0,-1428 # 4a6c <_ctype_+0x57c>
    1d66:	8082                	ret
    1d68:	6515                	lui	a0,0x5
    1d6a:	a6050513          	addi	a0,a0,-1440 # 4a60 <_ctype_+0x570>
    1d6e:	8082                	ret
    1d70:	6515                	lui	a0,0x5
    1d72:	a4c50513          	addi	a0,a0,-1460 # 4a4c <_ctype_+0x55c>
    1d76:	8082                	ret
    1d78:	6515                	lui	a0,0x5
    1d7a:	a2850513          	addi	a0,a0,-1496 # 4a28 <_ctype_+0x538>
    1d7e:	8082                	ret
    1d80:	6515                	lui	a0,0x5
    1d82:	a1050513          	addi	a0,a0,-1520 # 4a10 <_ctype_+0x520>
    1d86:	8082                	ret
    1d88:	6515                	lui	a0,0x5
    1d8a:	9fc50513          	addi	a0,a0,-1540 # 49fc <_ctype_+0x50c>
    1d8e:	8082                	ret
    1d90:	6515                	lui	a0,0x5
    1d92:	9e450513          	addi	a0,a0,-1564 # 49e4 <_ctype_+0x4f4>
    1d96:	8082                	ret
    1d98:	6515                	lui	a0,0x5
    1d9a:	aec50513          	addi	a0,a0,-1300 # 4aec <_ctype_+0x5fc>
    1d9e:	8082                	ret
    1da0:	6515                	lui	a0,0x5
    1da2:	9d450513          	addi	a0,a0,-1580 # 49d4 <_ctype_+0x4e4>
    1da6:	8082                	ret
    1da8:	6515                	lui	a0,0x5
    1daa:	9cc50513          	addi	a0,a0,-1588 # 49cc <_ctype_+0x4dc>
    1dae:	8082                	ret
    1db0:	6515                	lui	a0,0x5
    1db2:	9a850513          	addi	a0,a0,-1624 # 49a8 <_ctype_+0x4b8>
    1db6:	8082                	ret
    1db8:	6515                	lui	a0,0x5
    1dba:	97c50513          	addi	a0,a0,-1668 # 497c <_ctype_+0x48c>
    1dbe:	8082                	ret
    1dc0:	6515                	lui	a0,0x5
    1dc2:	96050513          	addi	a0,a0,-1696 # 4960 <_ctype_+0x470>
    1dc6:	8082                	ret
    1dc8:	6515                	lui	a0,0x5
    1dca:	94c50513          	addi	a0,a0,-1716 # 494c <_ctype_+0x45c>
    1dce:	8082                	ret
    1dd0:	6515                	lui	a0,0x5
    1dd2:	91c50513          	addi	a0,a0,-1764 # 491c <_ctype_+0x42c>
    1dd6:	8082                	ret
    1dd8:	6515                	lui	a0,0x5
    1dda:	91050513          	addi	a0,a0,-1776 # 4910 <_ctype_+0x420>
    1dde:	8082                	ret
    1de0:	6515                	lui	a0,0x5
    1de2:	90050513          	addi	a0,a0,-1792 # 4900 <_ctype_+0x410>
    1de6:	8082                	ret
    1de8:	6515                	lui	a0,0x5
    1dea:	8e850513          	addi	a0,a0,-1816 # 48e8 <_ctype_+0x3f8>
    1dee:	8082                	ret
    1df0:	6515                	lui	a0,0x5
    1df2:	8d850513          	addi	a0,a0,-1832 # 48d8 <_ctype_+0x3e8>
    1df6:	8082                	ret
    1df8:	6515                	lui	a0,0x5
    1dfa:	8b050513          	addi	a0,a0,-1872 # 48b0 <_ctype_+0x3c0>
    1dfe:	8082                	ret
    1e00:	6515                	lui	a0,0x5
    1e02:	88c50513          	addi	a0,a0,-1908 # 488c <_ctype_+0x39c>
    1e06:	8082                	ret
    1e08:	6515                	lui	a0,0x5
    1e0a:	87c50513          	addi	a0,a0,-1924 # 487c <_ctype_+0x38c>
    1e0e:	8082                	ret
    1e10:	6515                	lui	a0,0x5
    1e12:	86450513          	addi	a0,a0,-1948 # 4864 <_ctype_+0x374>
    1e16:	8082                	ret
    1e18:	6515                	lui	a0,0x5
    1e1a:	84450513          	addi	a0,a0,-1980 # 4844 <_ctype_+0x354>
    1e1e:	8082                	ret
    1e20:	6515                	lui	a0,0x5
    1e22:	82450513          	addi	a0,a0,-2012 # 4824 <_ctype_+0x334>
    1e26:	8082                	ret
    1e28:	6511                	lui	a0,0x4
    1e2a:	7cc50513          	addi	a0,a0,1996 # 47cc <_ctype_+0x2dc>
    1e2e:	8082                	ret
    1e30:	6511                	lui	a0,0x4
    1e32:	7bc50513          	addi	a0,a0,1980 # 47bc <_ctype_+0x2cc>
    1e36:	8082                	ret
    1e38:	6511                	lui	a0,0x4
    1e3a:	77c50513          	addi	a0,a0,1916 # 477c <_ctype_+0x28c>
    1e3e:	8082                	ret
    1e40:	6511                	lui	a0,0x4
    1e42:	76c50513          	addi	a0,a0,1900 # 476c <_ctype_+0x27c>
    1e46:	8082                	ret
    1e48:	6511                	lui	a0,0x4
    1e4a:	75850513          	addi	a0,a0,1880 # 4758 <_ctype_+0x268>
    1e4e:	8082                	ret
    1e50:	6511                	lui	a0,0x4
    1e52:	74c50513          	addi	a0,a0,1868 # 474c <_ctype_+0x25c>
    1e56:	8082                	ret
    1e58:	6511                	lui	a0,0x4
    1e5a:	73450513          	addi	a0,a0,1844 # 4734 <_ctype_+0x244>
    1e5e:	8082                	ret
    1e60:	6511                	lui	a0,0x4
    1e62:	72850513          	addi	a0,a0,1832 # 4728 <_ctype_+0x238>
    1e66:	8082                	ret
    1e68:	6511                	lui	a0,0x4
    1e6a:	71450513          	addi	a0,a0,1812 # 4714 <_ctype_+0x224>
    1e6e:	8082                	ret
    1e70:	6511                	lui	a0,0x4
    1e72:	70050513          	addi	a0,a0,1792 # 4700 <_ctype_+0x210>
    1e76:	8082                	ret
    1e78:	6511                	lui	a0,0x4
    1e7a:	6ec50513          	addi	a0,a0,1772 # 46ec <_ctype_+0x1fc>
    1e7e:	8082                	ret
    1e80:	6511                	lui	a0,0x4
    1e82:	6c050513          	addi	a0,a0,1728 # 46c0 <_ctype_+0x1d0>
    1e86:	8082                	ret
    1e88:	6511                	lui	a0,0x4
    1e8a:	6b050513          	addi	a0,a0,1712 # 46b0 <_ctype_+0x1c0>
    1e8e:	8082                	ret
    1e90:	6511                	lui	a0,0x4
    1e92:	68050513          	addi	a0,a0,1664 # 4680 <_ctype_+0x190>
    1e96:	8082                	ret
    1e98:	6511                	lui	a0,0x4
    1e9a:	66c50513          	addi	a0,a0,1644 # 466c <_ctype_+0x17c>
    1e9e:	8082                	ret
    1ea0:	6511                	lui	a0,0x4
    1ea2:	65050513          	addi	a0,a0,1616 # 4650 <_ctype_+0x160>
    1ea6:	8082                	ret
    1ea8:	6511                	lui	a0,0x4
    1eaa:	64450513          	addi	a0,a0,1604 # 4644 <_ctype_+0x154>
    1eae:	8082                	ret
    1eb0:	6511                	lui	a0,0x4
    1eb2:	62c50513          	addi	a0,a0,1580 # 462c <_ctype_+0x13c>
    1eb6:	8082                	ret
    1eb8:	6511                	lui	a0,0x4
    1eba:	61c50513          	addi	a0,a0,1564 # 461c <_ctype_+0x12c>
    1ebe:	8082                	ret
    1ec0:	6511                	lui	a0,0x4
    1ec2:	60050513          	addi	a0,a0,1536 # 4600 <_ctype_+0x110>
    1ec6:	8082                	ret
    1ec8:	6515                	lui	a0,0x5
    1eca:	cec50513          	addi	a0,a0,-788 # 4cec <_ctype_+0x7fc>
    1ece:	8082                	ret
    1ed0:	6511                	lui	a0,0x4
    1ed2:	5f450513          	addi	a0,a0,1524 # 45f4 <_ctype_+0x104>
    1ed6:	8082                	ret
    1ed8:	6511                	lui	a0,0x4
    1eda:	6e850513          	addi	a0,a0,1768 # 46e8 <_ctype_+0x1f8>
    1ede:	bb95                	j	1c52 <_strerror_r+0x2e>
    1ee0:	86aa                	mv	a3,a0
    1ee2:	b39d                	j	1c48 <_strerror_r+0x24>

00001ee4 <strerror>:
    1ee4:	200007b7          	lui	a5,0x20000
    1ee8:	85aa                	mv	a1,a0
    1eea:	1207a503          	lw	a0,288(a5) # 20000120 <_impure_ptr>
    1eee:	4681                	li	a3,0
    1ef0:	4601                	li	a2,0
    1ef2:	bb0d                	j	1c24 <_strerror_r>

00001ef4 <strerror_l>:
    1ef4:	200007b7          	lui	a5,0x20000
    1ef8:	85aa                	mv	a1,a0
    1efa:	1207a503          	lw	a0,288(a5) # 20000120 <_impure_ptr>
    1efe:	4681                	li	a3,0
    1f00:	4601                	li	a2,0
    1f02:	b30d                	j	1c24 <_strerror_r>

00001f04 <_user_strerror>:
    1f04:	4501                	li	a0,0
    1f06:	8082                	ret

00001f08 <__errno>:
    1f08:	200007b7          	lui	a5,0x20000
    1f0c:	1207a503          	lw	a0,288(a5) # 20000120 <_impure_ptr>
    1f10:	8082                	ret

00001f12 <memmove>:
    1f12:	06a5f063          	bgeu	a1,a0,1f72 <memmove+0x60>
    1f16:	00c58733          	add	a4,a1,a2
    1f1a:	04e57c63          	bgeu	a0,a4,1f72 <memmove+0x60>
    1f1e:	468d                	li	a3,3
    1f20:	00c507b3          	add	a5,a0,a2
    1f24:	02c6f863          	bgeu	a3,a2,1f54 <memmove+0x42>
    1f28:	00f766b3          	or	a3,a4,a5
    1f2c:	8a8d                	andi	a3,a3,3
    1f2e:	e6e5                	bnez	a3,2016 <memmove+0x104>
    1f30:	ffc60293          	addi	t0,a2,-4
    1f34:	fff2c293          	not	t0,t0
    1f38:	ffc2f293          	andi	t0,t0,-4
    1f3c:	00578333          	add	t1,a5,t0
    1f40:	86ba                	mv	a3,a4
    1f42:	ffc6a583          	lw	a1,-4(a3)
    1f46:	17f1                	addi	a5,a5,-4
    1f48:	16f1                	addi	a3,a3,-4
    1f4a:	c38c                	sw	a1,0(a5)
    1f4c:	fe679be3          	bne	a5,t1,1f42 <memmove+0x30>
    1f50:	8a0d                	andi	a2,a2,3
    1f52:	9716                	add	a4,a4,t0
    1f54:	fff60693          	addi	a3,a2,-1
    1f58:	c271                	beqz	a2,201c <memmove+0x10a>
    1f5a:	fff6c613          	not	a2,a3
    1f5e:	963e                	add	a2,a2,a5
    1f60:	fff74683          	lbu	a3,-1(a4)
    1f64:	17fd                	addi	a5,a5,-1
    1f66:	177d                	addi	a4,a4,-1
    1f68:	00d78023          	sb	a3,0(a5)
    1f6c:	fef61ae3          	bne	a2,a5,1f60 <memmove+0x4e>
    1f70:	8082                	ret
    1f72:	478d                	li	a5,3
    1f74:	02c7e163          	bltu	a5,a2,1f96 <memmove+0x84>
    1f78:	87aa                	mv	a5,a0
    1f7a:	fff60693          	addi	a3,a2,-1
    1f7e:	ca59                	beqz	a2,2014 <memmove+0x102>
    1f80:	0685                	addi	a3,a3,1
    1f82:	96ae                	add	a3,a3,a1
    1f84:	0005c703          	lbu	a4,0(a1)
    1f88:	0585                	addi	a1,a1,1
    1f8a:	0785                	addi	a5,a5,1
    1f8c:	fee78fa3          	sb	a4,-1(a5)
    1f90:	fed59ae3          	bne	a1,a3,1f84 <memmove+0x72>
    1f94:	8082                	ret
    1f96:	00a5e7b3          	or	a5,a1,a0
    1f9a:	8b8d                	andi	a5,a5,3
    1f9c:	eba5                	bnez	a5,200c <memmove+0xfa>
    1f9e:	47bd                	li	a5,15
    1fa0:	06c7ff63          	bgeu	a5,a2,201e <memmove+0x10c>
    1fa4:	ff060793          	addi	a5,a2,-16
    1fa8:	9bc1                	andi	a5,a5,-16
    1faa:	07c1                	addi	a5,a5,16
    1fac:	00f58333          	add	t1,a1,a5
    1fb0:	872a                	mv	a4,a0
    1fb2:	4194                	lw	a3,0(a1)
    1fb4:	05c1                	addi	a1,a1,16
    1fb6:	0741                	addi	a4,a4,16
    1fb8:	fed72823          	sw	a3,-16(a4)
    1fbc:	ff45a683          	lw	a3,-12(a1)
    1fc0:	fed72a23          	sw	a3,-12(a4)
    1fc4:	ff85a683          	lw	a3,-8(a1)
    1fc8:	fed72c23          	sw	a3,-8(a4)
    1fcc:	ffc5a683          	lw	a3,-4(a1)
    1fd0:	fed72e23          	sw	a3,-4(a4)
    1fd4:	fcb31fe3          	bne	t1,a1,1fb2 <memmove+0xa0>
    1fd8:	00f67293          	andi	t0,a2,15
    1fdc:	00c67713          	andi	a4,a2,12
    1fe0:	97aa                	add	a5,a5,a0
    1fe2:	8616                	mv	a2,t0
    1fe4:	db59                	beqz	a4,1f7a <memmove+0x68>
    1fe6:	ffc28313          	addi	t1,t0,-4
    1fea:	ffc37313          	andi	t1,t1,-4
    1fee:	0311                	addi	t1,t1,4
    1ff0:	00658633          	add	a2,a1,t1
    1ff4:	873e                	mv	a4,a5
    1ff6:	4194                	lw	a3,0(a1)
    1ff8:	0591                	addi	a1,a1,4
    1ffa:	0711                	addi	a4,a4,4
    1ffc:	fed72e23          	sw	a3,-4(a4)
    2000:	fec59be3          	bne	a1,a2,1ff6 <memmove+0xe4>
    2004:	0032f613          	andi	a2,t0,3
    2008:	979a                	add	a5,a5,t1
    200a:	bf85                	j	1f7a <memmove+0x68>
    200c:	fff60693          	addi	a3,a2,-1
    2010:	87aa                	mv	a5,a0
    2012:	b7bd                	j	1f80 <memmove+0x6e>
    2014:	8082                	ret
    2016:	fff60693          	addi	a3,a2,-1
    201a:	b781                	j	1f5a <memmove+0x48>
    201c:	8082                	ret
    201e:	87aa                	mv	a5,a0
    2020:	82b2                	mv	t0,a2
    2022:	b7d1                	j	1fe6 <memmove+0xd4>

00002024 <memset>:
    2024:	47fd                	li	a5,31
    2026:	86aa                	mv	a3,a0
    2028:	0ec7fa63          	bgeu	a5,a2,211c <memset+0xf8>
    202c:	0036f713          	andi	a4,a3,3
    2030:	cf19                	beqz	a4,204e <memset+0x2a>
    2032:	00000297          	auipc	t0,0x0
    2036:	00271313          	slli	t1,a4,0x2
    203a:	929a                	add	t0,t0,t1
    203c:	8306                	mv	t1,ra
    203e:	166280e7          	jalr	358(t0) # 2198 <memset+0x174>
    2042:	809a                	mv	ra,t1
    2044:	1771                	addi	a4,a4,-4
    2046:	963a                	add	a2,a2,a4
    2048:	8e99                	sub	a3,a3,a4
    204a:	0cc7f963          	bgeu	a5,a2,211c <memset+0xf8>
    204e:	e199                	bnez	a1,2054 <memset+0x30>
    2050:	a821                	j	2068 <memset+0x44>
    2052:	0001                	nop
    2054:	0ff5f593          	zext.b	a1,a1
    2058:	00859293          	slli	t0,a1,0x8
    205c:	0055e5b3          	or	a1,a1,t0
    2060:	01059293          	slli	t0,a1,0x10
    2064:	0055e5b3          	or	a1,a1,t0
    2068:	ffc67293          	andi	t0,a2,-4
    206c:	00568333          	add	t1,a3,t0
    2070:	07c2f293          	andi	t0,t0,124
    2074:	00028e63          	beqz	t0,2090 <memset+0x6c>
    2078:	405002b3          	neg	t0,t0
    207c:	08028293          	addi	t0,t0,128
    2080:	405686b3          	sub	a3,a3,t0
    2084:	00000397          	auipc	t2,0x0
    2088:	9396                	add	t2,t2,t0
    208a:	00c38067          	jr	12(t2) # 2090 <memset+0x6c>
    208e:	0001                	nop
    2090:	00b6a023          	sw	a1,0(a3)
    2094:	00b6a223          	sw	a1,4(a3)
    2098:	00b6a423          	sw	a1,8(a3)
    209c:	00b6a623          	sw	a1,12(a3)
    20a0:	00b6a823          	sw	a1,16(a3)
    20a4:	00b6aa23          	sw	a1,20(a3)
    20a8:	00b6ac23          	sw	a1,24(a3)
    20ac:	00b6ae23          	sw	a1,28(a3)
    20b0:	02b6a023          	sw	a1,32(a3)
    20b4:	02b6a223          	sw	a1,36(a3)
    20b8:	02b6a423          	sw	a1,40(a3)
    20bc:	02b6a623          	sw	a1,44(a3)
    20c0:	02b6a823          	sw	a1,48(a3)
    20c4:	02b6aa23          	sw	a1,52(a3)
    20c8:	02b6ac23          	sw	a1,56(a3)
    20cc:	02b6ae23          	sw	a1,60(a3)
    20d0:	04b6a023          	sw	a1,64(a3)
    20d4:	04b6a223          	sw	a1,68(a3)
    20d8:	04b6a423          	sw	a1,72(a3)
    20dc:	04b6a623          	sw	a1,76(a3)
    20e0:	04b6a823          	sw	a1,80(a3)
    20e4:	04b6aa23          	sw	a1,84(a3)
    20e8:	04b6ac23          	sw	a1,88(a3)
    20ec:	04b6ae23          	sw	a1,92(a3)
    20f0:	06b6a023          	sw	a1,96(a3)
    20f4:	06b6a223          	sw	a1,100(a3)
    20f8:	06b6a423          	sw	a1,104(a3)
    20fc:	06b6a623          	sw	a1,108(a3)
    2100:	06b6a823          	sw	a1,112(a3)
    2104:	06b6aa23          	sw	a1,116(a3)
    2108:	06b6ac23          	sw	a1,120(a3)
    210c:	06b6ae23          	sw	a1,124(a3)
    2110:	08068693          	addi	a3,a3,128
    2114:	f666eee3          	bltu	a3,t1,2090 <memset+0x6c>
    2118:	8a0d                	andi	a2,a2,3
    211a:	c659                	beqz	a2,21a8 <memset+0x184>
    211c:	00000297          	auipc	t0,0x0
    2120:	40c78633          	sub	a2,a5,a2
    2124:	060a                	slli	a2,a2,0x2
    2126:	92b2                	add	t0,t0,a2
    2128:	01028067          	jr	16(t0) # 212c <memset+0x108>
    212c:	00b68f23          	sb	a1,30(a3)
    2130:	00b68ea3          	sb	a1,29(a3)
    2134:	00b68e23          	sb	a1,28(a3)
    2138:	00b68da3          	sb	a1,27(a3)
    213c:	00b68d23          	sb	a1,26(a3)
    2140:	00b68ca3          	sb	a1,25(a3)
    2144:	00b68c23          	sb	a1,24(a3)
    2148:	00b68ba3          	sb	a1,23(a3)
    214c:	00b68b23          	sb	a1,22(a3)
    2150:	00b68aa3          	sb	a1,21(a3)
    2154:	00b68a23          	sb	a1,20(a3)
    2158:	00b689a3          	sb	a1,19(a3)
    215c:	00b68923          	sb	a1,18(a3)
    2160:	00b688a3          	sb	a1,17(a3)
    2164:	00b68823          	sb	a1,16(a3)
    2168:	00b687a3          	sb	a1,15(a3)
    216c:	00b68723          	sb	a1,14(a3)
    2170:	00b686a3          	sb	a1,13(a3)
    2174:	00b68623          	sb	a1,12(a3)
    2178:	00b685a3          	sb	a1,11(a3)
    217c:	00b68523          	sb	a1,10(a3)
    2180:	00b684a3          	sb	a1,9(a3)
    2184:	00b68423          	sb	a1,8(a3)
    2188:	00b683a3          	sb	a1,7(a3)
    218c:	00b68323          	sb	a1,6(a3)
    2190:	00b682a3          	sb	a1,5(a3)
    2194:	00b68223          	sb	a1,4(a3)
    2198:	00b681a3          	sb	a1,3(a3)
    219c:	00b68123          	sb	a1,2(a3)
    21a0:	00b680a3          	sb	a1,1(a3)
    21a4:	00b68023          	sb	a1,0(a3)
    21a8:	8082                	ret

000021aa <strlen>:
    21aa:	00357793          	andi	a5,a0,3
    21ae:	872a                	mv	a4,a0
    21b0:	ef95                	bnez	a5,21ec <strlen+0x42>
    21b2:	7f7f86b7          	lui	a3,0x7f7f8
    21b6:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__kernel_stack+0x5f7e7f7f>
    21ba:	55fd                	li	a1,-1
    21bc:	4310                	lw	a2,0(a4)
    21be:	0711                	addi	a4,a4,4
    21c0:	00d677b3          	and	a5,a2,a3
    21c4:	97b6                	add	a5,a5,a3
    21c6:	8fd1                	or	a5,a5,a2
    21c8:	8fd5                	or	a5,a5,a3
    21ca:	feb789e3          	beq	a5,a1,21bc <strlen+0x12>
    21ce:	ffc74683          	lbu	a3,-4(a4)
    21d2:	ffd74603          	lbu	a2,-3(a4)
    21d6:	ffe74783          	lbu	a5,-2(a4)
    21da:	8f09                	sub	a4,a4,a0
    21dc:	c68d                	beqz	a3,2206 <strlen+0x5c>
    21de:	c20d                	beqz	a2,2200 <strlen+0x56>
    21e0:	00f03533          	snez	a0,a5
    21e4:	953a                	add	a0,a0,a4
    21e6:	1579                	addi	a0,a0,-2
    21e8:	8082                	ret
    21ea:	d6e1                	beqz	a3,21b2 <strlen+0x8>
    21ec:	00074783          	lbu	a5,0(a4)
    21f0:	0705                	addi	a4,a4,1
    21f2:	00377693          	andi	a3,a4,3
    21f6:	fbf5                	bnez	a5,21ea <strlen+0x40>
    21f8:	8f09                	sub	a4,a4,a0
    21fa:	fff70513          	addi	a0,a4,-1
    21fe:	8082                	ret
    2200:	ffd70513          	addi	a0,a4,-3
    2204:	8082                	ret
    2206:	ffc70513          	addi	a0,a4,-4
    220a:	8082                	ret

0000220c <strcpy>:
    220c:	00b567b3          	or	a5,a0,a1
    2210:	8b8d                	andi	a5,a5,3
    2212:	efb1                	bnez	a5,226e <strcpy+0x62>
    2214:	4198                	lw	a4,0(a1)
    2216:	7f7f86b7          	lui	a3,0x7f7f8
    221a:	f7f68693          	addi	a3,a3,-129 # 7f7f7f7f <__kernel_stack+0x5f7e7f7f>
    221e:	00d777b3          	and	a5,a4,a3
    2222:	97b6                	add	a5,a5,a3
    2224:	8fd9                	or	a5,a5,a4
    2226:	8fd5                	or	a5,a5,a3
    2228:	567d                	li	a2,-1
    222a:	04c79b63          	bne	a5,a2,2280 <strcpy+0x74>
    222e:	862a                	mv	a2,a0
    2230:	537d                	li	t1,-1
    2232:	c218                	sw	a4,0(a2)
    2234:	41d8                	lw	a4,4(a1)
    2236:	0591                	addi	a1,a1,4
    2238:	0611                	addi	a2,a2,4
    223a:	00d777b3          	and	a5,a4,a3
    223e:	97b6                	add	a5,a5,a3
    2240:	8fd9                	or	a5,a5,a4
    2242:	8fd5                	or	a5,a5,a3
    2244:	fe6787e3          	beq	a5,t1,2232 <strcpy+0x26>
    2248:	0005c783          	lbu	a5,0(a1)
    224c:	00f60023          	sb	a5,0(a2)
    2250:	cb99                	beqz	a5,2266 <strcpy+0x5a>
    2252:	0015c783          	lbu	a5,1(a1)
    2256:	00f600a3          	sb	a5,1(a2)
    225a:	c791                	beqz	a5,2266 <strcpy+0x5a>
    225c:	0025c783          	lbu	a5,2(a1)
    2260:	00f60123          	sb	a5,2(a2)
    2264:	e391                	bnez	a5,2268 <strcpy+0x5c>
    2266:	8082                	ret
    2268:	000601a3          	sb	zero,3(a2)
    226c:	8082                	ret
    226e:	87aa                	mv	a5,a0
    2270:	0005c703          	lbu	a4,0(a1)
    2274:	0785                	addi	a5,a5,1
    2276:	0585                	addi	a1,a1,1
    2278:	fee78fa3          	sb	a4,-1(a5)
    227c:	fb75                	bnez	a4,2270 <strcpy+0x64>
    227e:	8082                	ret
    2280:	862a                	mv	a2,a0
    2282:	b7d9                	j	2248 <strcpy+0x3c>

00002284 <__udivdi3>:
#endif

#ifdef L_udivdi3
UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
    2284:	1161                	addi	sp,sp,-8
    2286:	c222                	sw	s0,4(sp)
    2288:	c026                	sw	s1,0(sp)
    228a:	82aa                	mv	t0,a0
    228c:	87ae                	mv	a5,a1
  if (d1 == 0)
    228e:	20069d63          	bnez	a3,24a8 <__udivdi3+0x224>
    2292:	85b6                	mv	a1,a3
    2294:	6695                	lui	a3,0x5
    2296:	8332                	mv	t1,a2
    2298:	83aa                	mv	t2,a0
      if (d0 > n1)
    229a:	fa868693          	addi	a3,a3,-88 # 4fa8 <__clz_tab>
    229e:	0cc7f263          	bgeu	a5,a2,2362 <__udivdi3+0xde>
	  count_leading_zeros (bm, d0);
    22a2:	6741                	lui	a4,0x10
    22a4:	853e                	mv	a0,a5
    22a6:	0ae67763          	bgeu	a2,a4,2354 <__udivdi3+0xd0>
    22aa:	0ff00713          	li	a4,255
    22ae:	00c73733          	sltu	a4,a4,a2
    22b2:	070e                	slli	a4,a4,0x3
    22b4:	00e655b3          	srl	a1,a2,a4
    22b8:	96ae                	add	a3,a3,a1
    22ba:	0006c683          	lbu	a3,0(a3)
    22be:	9736                	add	a4,a4,a3
    22c0:	02000693          	li	a3,32
    22c4:	40e68433          	sub	s0,a3,a4
	  if (bm != 0)
    22c8:	00e68c63          	beq	a3,a4,22e0 <__udivdi3+0x5c>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    22cc:	008796b3          	sll	a3,a5,s0
    22d0:	00e2d733          	srl	a4,t0,a4
	      d0 = d0 << bm;
    22d4:	00861333          	sll	t1,a2,s0
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    22d8:	00d76533          	or	a0,a4,a3
	      n0 = n0 << bm;
    22dc:	008293b3          	sll	t2,t0,s0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    22e0:	01035593          	srli	a1,t1,0x10
    22e4:	02b556b3          	divu	a3,a0,a1
    22e8:	01031613          	slli	a2,t1,0x10
    22ec:	8241                	srli	a2,a2,0x10
    22ee:	0103d793          	srli	a5,t2,0x10
    22f2:	02b57733          	remu	a4,a0,a1
    22f6:	8536                	mv	a0,a3
    22f8:	02d602b3          	mul	t0,a2,a3
    22fc:	0742                	slli	a4,a4,0x10
    22fe:	8fd9                	or	a5,a5,a4
    2300:	0057fc63          	bgeu	a5,t0,2318 <__udivdi3+0x94>
    2304:	979a                	add	a5,a5,t1
    2306:	fff68513          	addi	a0,a3,-1
    230a:	0067e763          	bltu	a5,t1,2318 <__udivdi3+0x94>
    230e:	0057f563          	bgeu	a5,t0,2318 <__udivdi3+0x94>
    2312:	ffe68513          	addi	a0,a3,-2
    2316:	979a                	add	a5,a5,t1
    2318:	405787b3          	sub	a5,a5,t0
    231c:	02b7f733          	remu	a4,a5,a1
    2320:	03c2                	slli	t2,t2,0x10
    2322:	0103d393          	srli	t2,t2,0x10
    2326:	02b7d7b3          	divu	a5,a5,a1
    232a:	0742                	slli	a4,a4,0x10
    232c:	007763b3          	or	t2,a4,t2
    2330:	02f60633          	mul	a2,a2,a5
    2334:	873e                	mv	a4,a5
    2336:	00c3fb63          	bgeu	t2,a2,234c <__udivdi3+0xc8>
    233a:	939a                	add	t2,t2,t1
    233c:	fff78713          	addi	a4,a5,-1
    2340:	0063e663          	bltu	t2,t1,234c <__udivdi3+0xc8>
    2344:	00c3f463          	bgeu	t2,a2,234c <__udivdi3+0xc8>
    2348:	ffe78713          	addi	a4,a5,-2
    234c:	0542                	slli	a0,a0,0x10
    234e:	8d59                	or	a0,a0,a4
	      q1 = 0;
    2350:	4581                	li	a1,0
    2352:	a855                	j	2406 <__udivdi3+0x182>
	  count_leading_zeros (bm, d0);
    2354:	010005b7          	lui	a1,0x1000
    2358:	4741                	li	a4,16
    235a:	f4b66de3          	bltu	a2,a1,22b4 <__udivdi3+0x30>
    235e:	4761                	li	a4,24
    2360:	bf91                	j	22b4 <__udivdi3+0x30>
	  if (d0 == 0)
    2362:	e601                	bnez	a2,236a <__udivdi3+0xe6>
	    d0 = 1 / d0;	/* Divide intentionally by zero.  */
    2364:	4705                	li	a4,1
    2366:	02c75333          	divu	t1,a4,a2
	  count_leading_zeros (bm, d0);
    236a:	6741                	lui	a4,0x10
    236c:	0ae37163          	bgeu	t1,a4,240e <__udivdi3+0x18a>
    2370:	0ff00713          	li	a4,255
    2374:	00677363          	bgeu	a4,t1,237a <__udivdi3+0xf6>
    2378:	45a1                	li	a1,8
    237a:	00b35733          	srl	a4,t1,a1
    237e:	96ba                	add	a3,a3,a4
    2380:	0006c703          	lbu	a4,0(a3)
    2384:	02000693          	li	a3,32
    2388:	972e                	add	a4,a4,a1
    238a:	40e68533          	sub	a0,a3,a4
	  if (bm == 0)
    238e:	08e69763          	bne	a3,a4,241c <__udivdi3+0x198>
	      n1 -= d0;
    2392:	406787b3          	sub	a5,a5,t1
	      q1 = 1;
    2396:	4585                	li	a1,1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    2398:	01035293          	srli	t0,t1,0x10
    239c:	01031613          	slli	a2,t1,0x10
    23a0:	8241                	srli	a2,a2,0x10
    23a2:	0103d713          	srli	a4,t2,0x10
    23a6:	0257f6b3          	remu	a3,a5,t0
    23aa:	0257d7b3          	divu	a5,a5,t0
    23ae:	06c2                	slli	a3,a3,0x10
    23b0:	8f55                	or	a4,a4,a3
    23b2:	02f60433          	mul	s0,a2,a5
    23b6:	853e                	mv	a0,a5
    23b8:	00877c63          	bgeu	a4,s0,23d0 <__udivdi3+0x14c>
    23bc:	971a                	add	a4,a4,t1
    23be:	fff78513          	addi	a0,a5,-1
    23c2:	00676763          	bltu	a4,t1,23d0 <__udivdi3+0x14c>
    23c6:	00877563          	bgeu	a4,s0,23d0 <__udivdi3+0x14c>
    23ca:	ffe78513          	addi	a0,a5,-2
    23ce:	971a                	add	a4,a4,t1
    23d0:	8f01                	sub	a4,a4,s0
    23d2:	025777b3          	remu	a5,a4,t0
    23d6:	03c2                	slli	t2,t2,0x10
    23d8:	0103d393          	srli	t2,t2,0x10
    23dc:	02575733          	divu	a4,a4,t0
    23e0:	07c2                	slli	a5,a5,0x10
    23e2:	0077e3b3          	or	t2,a5,t2
    23e6:	02e60633          	mul	a2,a2,a4
    23ea:	87ba                	mv	a5,a4
    23ec:	00c3fb63          	bgeu	t2,a2,2402 <__udivdi3+0x17e>
    23f0:	939a                	add	t2,t2,t1
    23f2:	fff70793          	addi	a5,a4,-1 # ffff <__erodata+0xaf57>
    23f6:	0063e663          	bltu	t2,t1,2402 <__udivdi3+0x17e>
    23fa:	00c3f463          	bgeu	t2,a2,2402 <__udivdi3+0x17e>
    23fe:	ffe70793          	addi	a5,a4,-2
    2402:	0542                	slli	a0,a0,0x10
    2404:	8d5d                	or	a0,a0,a5
  return __udivmoddi4 (n, d, (UDWtype *) 0);
}
    2406:	4412                	lw	s0,4(sp)
    2408:	4482                	lw	s1,0(sp)
    240a:	0121                	addi	sp,sp,8
    240c:	8082                	ret
	  count_leading_zeros (bm, d0);
    240e:	01000737          	lui	a4,0x1000
    2412:	45c1                	li	a1,16
    2414:	f6e363e3          	bltu	t1,a4,237a <__udivdi3+0xf6>
    2418:	45e1                	li	a1,24
    241a:	b785                	j	237a <__udivdi3+0xf6>
	      d0 = d0 << bm;
    241c:	00a31333          	sll	t1,t1,a0
	      n2 = n1 >> b;
    2420:	00e7d6b3          	srl	a3,a5,a4
	      n0 = n0 << bm;
    2424:	00a293b3          	sll	t2,t0,a0
	      n1 = (n1 << bm) | (n0 >> b);
    2428:	00a797b3          	sll	a5,a5,a0
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    242c:	01035513          	srli	a0,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
    2430:	00e2d733          	srl	a4,t0,a4
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    2434:	02a6d2b3          	divu	t0,a3,a0
	      n1 = (n1 << bm) | (n0 >> b);
    2438:	00f76633          	or	a2,a4,a5
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    243c:	01031793          	slli	a5,t1,0x10
    2440:	83c1                	srli	a5,a5,0x10
    2442:	01065593          	srli	a1,a2,0x10
    2446:	02a6f733          	remu	a4,a3,a0
    244a:	025786b3          	mul	a3,a5,t0
    244e:	0742                	slli	a4,a4,0x10
    2450:	8f4d                	or	a4,a4,a1
    2452:	8596                	mv	a1,t0
    2454:	00d77c63          	bgeu	a4,a3,246c <__udivdi3+0x1e8>
    2458:	971a                	add	a4,a4,t1
    245a:	fff28593          	addi	a1,t0,-1
    245e:	00676763          	bltu	a4,t1,246c <__udivdi3+0x1e8>
    2462:	00d77563          	bgeu	a4,a3,246c <__udivdi3+0x1e8>
    2466:	ffe28593          	addi	a1,t0,-2
    246a:	971a                	add	a4,a4,t1
    246c:	40d706b3          	sub	a3,a4,a3
    2470:	02a6f733          	remu	a4,a3,a0
    2474:	02a6d6b3          	divu	a3,a3,a0
    2478:	0742                	slli	a4,a4,0x10
    247a:	02d78533          	mul	a0,a5,a3
    247e:	01061793          	slli	a5,a2,0x10
    2482:	83c1                	srli	a5,a5,0x10
    2484:	8fd9                	or	a5,a5,a4
    2486:	8736                	mv	a4,a3
    2488:	00a7fc63          	bgeu	a5,a0,24a0 <__udivdi3+0x21c>
    248c:	979a                	add	a5,a5,t1
    248e:	fff68713          	addi	a4,a3,-1
    2492:	0067e763          	bltu	a5,t1,24a0 <__udivdi3+0x21c>
    2496:	00a7f563          	bgeu	a5,a0,24a0 <__udivdi3+0x21c>
    249a:	ffe68713          	addi	a4,a3,-2
    249e:	979a                	add	a5,a5,t1
    24a0:	05c2                	slli	a1,a1,0x10
    24a2:	8f89                	sub	a5,a5,a0
    24a4:	8dd9                	or	a1,a1,a4
    24a6:	bdcd                	j	2398 <__udivdi3+0x114>
      if (d1 > n1)
    24a8:	12d5ee63          	bltu	a1,a3,25e4 <__udivdi3+0x360>
	  count_leading_zeros (bm, d1);
    24ac:	6741                	lui	a4,0x10
    24ae:	02e6fe63          	bgeu	a3,a4,24ea <__udivdi3+0x266>
    24b2:	0ff00713          	li	a4,255
    24b6:	00d73733          	sltu	a4,a4,a3
    24ba:	070e                	slli	a4,a4,0x3
    24bc:	6595                	lui	a1,0x5
    24be:	00e6d533          	srl	a0,a3,a4
    24c2:	fa858593          	addi	a1,a1,-88 # 4fa8 <__clz_tab>
    24c6:	95aa                	add	a1,a1,a0
    24c8:	0005c583          	lbu	a1,0(a1)
    24cc:	02000513          	li	a0,32
    24d0:	972e                	add	a4,a4,a1
    24d2:	40e505b3          	sub	a1,a0,a4
	  if (bm == 0)
    24d6:	02e51163          	bne	a0,a4,24f8 <__udivdi3+0x274>
		  q0 = 1;
    24da:	4505                	li	a0,1
	      if (n1 > d1 || n0 >= d0)
    24dc:	f2f6e5e3          	bltu	a3,a5,2406 <__udivdi3+0x182>
    24e0:	00c2b633          	sltu	a2,t0,a2
    24e4:	00164513          	xori	a0,a2,1
    24e8:	bf39                	j	2406 <__udivdi3+0x182>
	  count_leading_zeros (bm, d1);
    24ea:	010005b7          	lui	a1,0x1000
    24ee:	4741                	li	a4,16
    24f0:	fcb6e6e3          	bltu	a3,a1,24bc <__udivdi3+0x238>
    24f4:	4761                	li	a4,24
    24f6:	b7d9                	j	24bc <__udivdi3+0x238>
	      d1 = (d1 << bm) | (d0 >> b);
    24f8:	00e65333          	srl	t1,a2,a4
    24fc:	00b696b3          	sll	a3,a3,a1
    2500:	00d36333          	or	t1,t1,a3
	      n2 = n1 >> b;
    2504:	00e7d3b3          	srl	t2,a5,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2508:	01035413          	srli	s0,t1,0x10
    250c:	0283f6b3          	remu	a3,t2,s0
    2510:	01031513          	slli	a0,t1,0x10
    2514:	8141                	srli	a0,a0,0x10
	      n1 = (n1 << bm) | (n0 >> b);
    2516:	00e2d733          	srl	a4,t0,a4
    251a:	00b797b3          	sll	a5,a5,a1
    251e:	8fd9                	or	a5,a5,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2520:	0107d713          	srli	a4,a5,0x10
	      d0 = d0 << bm;
    2524:	00b61633          	sll	a2,a2,a1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2528:	0283d3b3          	divu	t2,t2,s0
    252c:	06c2                	slli	a3,a3,0x10
    252e:	8ed9                	or	a3,a3,a4
    2530:	027504b3          	mul	s1,a0,t2
    2534:	871e                	mv	a4,t2
    2536:	0096fc63          	bgeu	a3,s1,254e <__udivdi3+0x2ca>
    253a:	969a                	add	a3,a3,t1
    253c:	fff38713          	addi	a4,t2,-1
    2540:	0066e763          	bltu	a3,t1,254e <__udivdi3+0x2ca>
    2544:	0096f563          	bgeu	a3,s1,254e <__udivdi3+0x2ca>
    2548:	ffe38713          	addi	a4,t2,-2
    254c:	969a                	add	a3,a3,t1
    254e:	8e85                	sub	a3,a3,s1
    2550:	0286f3b3          	remu	t2,a3,s0
    2554:	07c2                	slli	a5,a5,0x10
    2556:	83c1                	srli	a5,a5,0x10
    2558:	0286d6b3          	divu	a3,a3,s0
    255c:	03c2                	slli	t2,t2,0x10
    255e:	00f3e7b3          	or	a5,t2,a5
    2562:	02d50533          	mul	a0,a0,a3
    2566:	83b6                	mv	t2,a3
    2568:	00a7fc63          	bgeu	a5,a0,2580 <__udivdi3+0x2fc>
    256c:	979a                	add	a5,a5,t1
    256e:	fff68393          	addi	t2,a3,-1
    2572:	0067e763          	bltu	a5,t1,2580 <__udivdi3+0x2fc>
    2576:	00a7f563          	bgeu	a5,a0,2580 <__udivdi3+0x2fc>
    257a:	ffe68393          	addi	t2,a3,-2
    257e:	979a                	add	a5,a5,t1
    2580:	8f89                	sub	a5,a5,a0
	      umul_ppmm (m1, m0, q0, d0);
    2582:	6441                	lui	s0,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2584:	01071513          	slli	a0,a4,0x10
    2588:	00756533          	or	a0,a0,t2
	      umul_ppmm (m1, m0, q0, d0);
    258c:	fff40713          	addi	a4,s0,-1 # ffff <__erodata+0xaf57>
    2590:	00e573b3          	and	t2,a0,a4
    2594:	01055693          	srli	a3,a0,0x10
    2598:	8f71                	and	a4,a4,a2
    259a:	8241                	srli	a2,a2,0x10
    259c:	02e38333          	mul	t1,t2,a4
    25a0:	02e68733          	mul	a4,a3,a4
    25a4:	02c383b3          	mul	t2,t2,a2
    25a8:	02c686b3          	mul	a3,a3,a2
    25ac:	93ba                	add	t2,t2,a4
    25ae:	01035613          	srli	a2,t1,0x10
    25b2:	961e                	add	a2,a2,t2
    25b4:	00e67363          	bgeu	a2,a4,25ba <__udivdi3+0x336>
    25b8:	96a2                	add	a3,a3,s0
    25ba:	01065713          	srli	a4,a2,0x10
    25be:	96ba                	add	a3,a3,a4
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    25c0:	02d7e063          	bltu	a5,a3,25e0 <__udivdi3+0x35c>
    25c4:	d8d796e3          	bne	a5,a3,2350 <__udivdi3+0xcc>
	      umul_ppmm (m1, m0, q0, d0);
    25c8:	67c1                	lui	a5,0x10
    25ca:	17fd                	addi	a5,a5,-1
    25cc:	8e7d                	and	a2,a2,a5
    25ce:	0642                	slli	a2,a2,0x10
    25d0:	00f37333          	and	t1,t1,a5
	      n0 = n0 << bm;
    25d4:	00b292b3          	sll	t0,t0,a1
	      umul_ppmm (m1, m0, q0, d0);
    25d8:	961a                	add	a2,a2,t1
	      q1 = 0;
    25da:	4581                	li	a1,0
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    25dc:	e2c2f5e3          	bgeu	t0,a2,2406 <__udivdi3+0x182>
		  q0--;
    25e0:	157d                	addi	a0,a0,-1
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
    25e2:	b3bd                	j	2350 <__udivdi3+0xcc>
	  q1 = 0;
    25e4:	4581                	li	a1,0
	  q0 = 0;
    25e6:	4501                	li	a0,0
    25e8:	bd39                	j	2406 <__udivdi3+0x182>

000025ea <__umoddi3>:
{
    25ea:	1151                	addi	sp,sp,-12
    25ec:	c422                	sw	s0,8(sp)
    25ee:	c226                	sw	s1,4(sp)
  n0 = nn.s.low;
    25f0:	87aa                	mv	a5,a0
  n1 = nn.s.high;
    25f2:	872e                	mv	a4,a1
  if (d1 == 0)
    25f4:	1c069963          	bnez	a3,27c6 <__umoddi3+0x1dc>
    25f8:	8336                	mv	t1,a3
      if (d0 > n1)
    25fa:	6695                	lui	a3,0x5
    25fc:	8432                	mv	s0,a2
    25fe:	fa868693          	addi	a3,a3,-88 # 4fa8 <__clz_tab>
    2602:	0ac5fa63          	bgeu	a1,a2,26b6 <__umoddi3+0xcc>
	  count_leading_zeros (bm, d0);
    2606:	62c1                	lui	t0,0x10
    2608:	0a567063          	bgeu	a2,t0,26a8 <__umoddi3+0xbe>
    260c:	0ff00293          	li	t0,255
    2610:	00c2f363          	bgeu	t0,a2,2616 <__umoddi3+0x2c>
    2614:	4321                	li	t1,8
    2616:	006652b3          	srl	t0,a2,t1
    261a:	9696                	add	a3,a3,t0
    261c:	0006c683          	lbu	a3,0(a3)
    2620:	9336                	add	t1,t1,a3
    2622:	02000693          	li	a3,32
    2626:	406682b3          	sub	t0,a3,t1
	  if (bm != 0)
    262a:	00668c63          	beq	a3,t1,2642 <__umoddi3+0x58>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    262e:	005595b3          	sll	a1,a1,t0
    2632:	00655333          	srl	t1,a0,t1
	      d0 = d0 << bm;
    2636:	00561433          	sll	s0,a2,t0
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
    263a:	00b36733          	or	a4,t1,a1
	      n0 = n0 << bm;
    263e:	005517b3          	sll	a5,a0,t0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    2642:	01045393          	srli	t2,s0,0x10
    2646:	02777633          	remu	a2,a4,t2
    264a:	01041513          	slli	a0,s0,0x10
    264e:	8141                	srli	a0,a0,0x10
    2650:	0107d693          	srli	a3,a5,0x10
    2654:	02775733          	divu	a4,a4,t2
    2658:	0642                	slli	a2,a2,0x10
    265a:	8ed1                	or	a3,a3,a2
    265c:	02e50733          	mul	a4,a0,a4
    2660:	00e6f863          	bgeu	a3,a4,2670 <__umoddi3+0x86>
    2664:	96a2                	add	a3,a3,s0
    2666:	0086e563          	bltu	a3,s0,2670 <__umoddi3+0x86>
    266a:	00e6f363          	bgeu	a3,a4,2670 <__umoddi3+0x86>
    266e:	96a2                	add	a3,a3,s0
    2670:	8e99                	sub	a3,a3,a4
    2672:	0276f733          	remu	a4,a3,t2
    2676:	07c2                	slli	a5,a5,0x10
    2678:	83c1                	srli	a5,a5,0x10
    267a:	0276d6b3          	divu	a3,a3,t2
    267e:	02d506b3          	mul	a3,a0,a3
    2682:	01071513          	slli	a0,a4,0x10
    2686:	8fc9                	or	a5,a5,a0
    2688:	00d7f863          	bgeu	a5,a3,2698 <__umoddi3+0xae>
    268c:	97a2                	add	a5,a5,s0
    268e:	0087e563          	bltu	a5,s0,2698 <__umoddi3+0xae>
    2692:	00d7f363          	bgeu	a5,a3,2698 <__umoddi3+0xae>
    2696:	97a2                	add	a5,a5,s0
    2698:	8f95                	sub	a5,a5,a3
	  rr.s.low = n0 >> bm;
    269a:	0057d533          	srl	a0,a5,t0
	  *rp = rr.ll;
    269e:	4581                	li	a1,0
}
    26a0:	4422                	lw	s0,8(sp)
    26a2:	4492                	lw	s1,4(sp)
    26a4:	0131                	addi	sp,sp,12
    26a6:	8082                	ret
	  count_leading_zeros (bm, d0);
    26a8:	010002b7          	lui	t0,0x1000
    26ac:	4341                	li	t1,16
    26ae:	f65664e3          	bltu	a2,t0,2616 <__umoddi3+0x2c>
    26b2:	4361                	li	t1,24
    26b4:	b78d                	j	2616 <__umoddi3+0x2c>
	  if (d0 == 0)
    26b6:	e601                	bnez	a2,26be <__umoddi3+0xd4>
	    d0 = 1 / d0;	/* Divide intentionally by zero.  */
    26b8:	4705                	li	a4,1
    26ba:	02c75433          	divu	s0,a4,a2
	  count_leading_zeros (bm, d0);
    26be:	6741                	lui	a4,0x10
    26c0:	08e47163          	bgeu	s0,a4,2742 <__umoddi3+0x158>
    26c4:	0ff00713          	li	a4,255
    26c8:	00877363          	bgeu	a4,s0,26ce <__umoddi3+0xe4>
    26cc:	4321                	li	t1,8
    26ce:	00645733          	srl	a4,s0,t1
    26d2:	96ba                	add	a3,a3,a4
    26d4:	0006c603          	lbu	a2,0(a3)
    26d8:	02000713          	li	a4,32
    26dc:	9332                	add	t1,t1,a2
    26de:	406702b3          	sub	t0,a4,t1
	  if (bm == 0)
    26e2:	06671763          	bne	a4,t1,2750 <__umoddi3+0x166>
	      n1 -= d0;
    26e6:	8d81                	sub	a1,a1,s0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
    26e8:	01045693          	srli	a3,s0,0x10
    26ec:	01041513          	slli	a0,s0,0x10
    26f0:	8141                	srli	a0,a0,0x10
    26f2:	0107d613          	srli	a2,a5,0x10
    26f6:	02d5f733          	remu	a4,a1,a3
    26fa:	02d5d5b3          	divu	a1,a1,a3
    26fe:	0742                	slli	a4,a4,0x10
    2700:	8f51                	or	a4,a4,a2
    2702:	02b505b3          	mul	a1,a0,a1
    2706:	00b77863          	bgeu	a4,a1,2716 <__umoddi3+0x12c>
    270a:	9722                	add	a4,a4,s0
    270c:	00876563          	bltu	a4,s0,2716 <__umoddi3+0x12c>
    2710:	00b77363          	bgeu	a4,a1,2716 <__umoddi3+0x12c>
    2714:	9722                	add	a4,a4,s0
    2716:	40b705b3          	sub	a1,a4,a1
    271a:	02d5f733          	remu	a4,a1,a3
    271e:	07c2                	slli	a5,a5,0x10
    2720:	83c1                	srli	a5,a5,0x10
    2722:	02d5d5b3          	divu	a1,a1,a3
    2726:	0742                	slli	a4,a4,0x10
    2728:	8fd9                	or	a5,a5,a4
    272a:	02b50533          	mul	a0,a0,a1
    272e:	00a7f863          	bgeu	a5,a0,273e <__umoddi3+0x154>
    2732:	97a2                	add	a5,a5,s0
    2734:	0087e563          	bltu	a5,s0,273e <__umoddi3+0x154>
    2738:	00a7f363          	bgeu	a5,a0,273e <__umoddi3+0x154>
    273c:	97a2                	add	a5,a5,s0
    273e:	8f89                	sub	a5,a5,a0
    2740:	bfa9                	j	269a <__umoddi3+0xb0>
	  count_leading_zeros (bm, d0);
    2742:	01000737          	lui	a4,0x1000
    2746:	4341                	li	t1,16
    2748:	f8e463e3          	bltu	s0,a4,26ce <__umoddi3+0xe4>
    274c:	4361                	li	t1,24
    274e:	b741                	j	26ce <__umoddi3+0xe4>
	      d0 = d0 << bm;
    2750:	00541433          	sll	s0,s0,t0
	      n2 = n1 >> b;
    2754:	0065d6b3          	srl	a3,a1,t1
	      n0 = n0 << bm;
    2758:	005517b3          	sll	a5,a0,t0
	      n1 = (n1 << bm) | (n0 >> b);
    275c:	00655333          	srl	t1,a0,t1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    2760:	01045513          	srli	a0,s0,0x10
    2764:	02a6f733          	remu	a4,a3,a0
	      n1 = (n1 << bm) | (n0 >> b);
    2768:	005595b3          	sll	a1,a1,t0
    276c:	00b36633          	or	a2,t1,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
    2770:	01041593          	slli	a1,s0,0x10
    2774:	81c1                	srli	a1,a1,0x10
    2776:	01065313          	srli	t1,a2,0x10
    277a:	02a6d6b3          	divu	a3,a3,a0
    277e:	0742                	slli	a4,a4,0x10
    2780:	00676733          	or	a4,a4,t1
    2784:	02d586b3          	mul	a3,a1,a3
    2788:	00d77863          	bgeu	a4,a3,2798 <__umoddi3+0x1ae>
    278c:	9722                	add	a4,a4,s0
    278e:	00876563          	bltu	a4,s0,2798 <__umoddi3+0x1ae>
    2792:	00d77363          	bgeu	a4,a3,2798 <__umoddi3+0x1ae>
    2796:	9722                	add	a4,a4,s0
    2798:	40d706b3          	sub	a3,a4,a3
    279c:	02a6f733          	remu	a4,a3,a0
    27a0:	02a6d6b3          	divu	a3,a3,a0
    27a4:	0742                	slli	a4,a4,0x10
    27a6:	02d586b3          	mul	a3,a1,a3
    27aa:	01061593          	slli	a1,a2,0x10
    27ae:	81c1                	srli	a1,a1,0x10
    27b0:	8dd9                	or	a1,a1,a4
    27b2:	00d5f863          	bgeu	a1,a3,27c2 <__umoddi3+0x1d8>
    27b6:	95a2                	add	a1,a1,s0
    27b8:	0085e563          	bltu	a1,s0,27c2 <__umoddi3+0x1d8>
    27bc:	00d5f363          	bgeu	a1,a3,27c2 <__umoddi3+0x1d8>
    27c0:	95a2                	add	a1,a1,s0
    27c2:	8d95                	sub	a1,a1,a3
    27c4:	b715                	j	26e8 <__umoddi3+0xfe>
      if (d1 > n1)
    27c6:	ecd5ede3          	bltu	a1,a3,26a0 <__umoddi3+0xb6>
	  count_leading_zeros (bm, d1);
    27ca:	6341                	lui	t1,0x10
    27cc:	0466f463          	bgeu	a3,t1,2814 <__umoddi3+0x22a>
    27d0:	0ff00293          	li	t0,255
    27d4:	00d2b333          	sltu	t1,t0,a3
    27d8:	030e                	slli	t1,t1,0x3
    27da:	6295                	lui	t0,0x5
    27dc:	0066d3b3          	srl	t2,a3,t1
    27e0:	fa828293          	addi	t0,t0,-88 # 4fa8 <__clz_tab>
    27e4:	929e                	add	t0,t0,t2
    27e6:	0002c283          	lbu	t0,0(t0)
    27ea:	929a                	add	t0,t0,t1
    27ec:	02000313          	li	t1,32
    27f0:	405303b3          	sub	t2,t1,t0
	  if (bm == 0)
    27f4:	02531763          	bne	t1,t0,2822 <__umoddi3+0x238>
	      if (n1 > d1 || n0 >= d0)
    27f8:	00b6e463          	bltu	a3,a1,2800 <__umoddi3+0x216>
    27fc:	00c56963          	bltu	a0,a2,280e <__umoddi3+0x224>
		  sub_ddmmss (n1, n0, n1, n0, d1, d0);
    2800:	40c507b3          	sub	a5,a0,a2
    2804:	8d95                	sub	a1,a1,a3
    2806:	00f53533          	sltu	a0,a0,a5
    280a:	40a58733          	sub	a4,a1,a0
		  *rp = rr.ll;
    280e:	853e                	mv	a0,a5
    2810:	85ba                	mv	a1,a4
    2812:	b579                	j	26a0 <__umoddi3+0xb6>
	  count_leading_zeros (bm, d1);
    2814:	010002b7          	lui	t0,0x1000
    2818:	4341                	li	t1,16
    281a:	fc56e0e3          	bltu	a3,t0,27da <__umoddi3+0x1f0>
    281e:	4361                	li	t1,24
    2820:	bf6d                	j	27da <__umoddi3+0x1f0>
	      d1 = (d1 << bm) | (d0 >> b);
    2822:	007696b3          	sll	a3,a3,t2
    2826:	00565333          	srl	t1,a2,t0
    282a:	00d36333          	or	t1,t1,a3
	      n2 = n1 >> b;
    282e:	0055d4b3          	srl	s1,a1,t0
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2832:	01035413          	srli	s0,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
    2836:	00555733          	srl	a4,a0,t0
	      n0 = n0 << bm;
    283a:	007517b3          	sll	a5,a0,t2
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    283e:	0284d533          	divu	a0,s1,s0
	      n0 = n0 << bm;
    2842:	c03e                	sw	a5,0(sp)
	      n1 = (n1 << bm) | (n0 >> b);
    2844:	007595b3          	sll	a1,a1,t2
    2848:	8dd9                	or	a1,a1,a4
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    284a:	01031713          	slli	a4,t1,0x10
    284e:	8341                	srli	a4,a4,0x10
	      d0 = d0 << bm;
    2850:	00761633          	sll	a2,a2,t2
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    2854:	0284f7b3          	remu	a5,s1,s0
    2858:	02a704b3          	mul	s1,a4,a0
    285c:	01079693          	slli	a3,a5,0x10
    2860:	0105d793          	srli	a5,a1,0x10
    2864:	8fd5                	or	a5,a5,a3
    2866:	86aa                	mv	a3,a0
    2868:	0097fc63          	bgeu	a5,s1,2880 <__umoddi3+0x296>
    286c:	979a                	add	a5,a5,t1
    286e:	fff50693          	addi	a3,a0,-1
    2872:	0067e763          	bltu	a5,t1,2880 <__umoddi3+0x296>
    2876:	0097f563          	bgeu	a5,s1,2880 <__umoddi3+0x296>
    287a:	ffe50693          	addi	a3,a0,-2
    287e:	979a                	add	a5,a5,t1
    2880:	8f85                	sub	a5,a5,s1
    2882:	0287f533          	remu	a0,a5,s0
    2886:	05c2                	slli	a1,a1,0x10
    2888:	81c1                	srli	a1,a1,0x10
    288a:	0287d433          	divu	s0,a5,s0
    288e:	0542                	slli	a0,a0,0x10
    2890:	8dc9                	or	a1,a1,a0
    2892:	02870733          	mul	a4,a4,s0
    2896:	87a2                	mv	a5,s0
    2898:	00e5fc63          	bgeu	a1,a4,28b0 <__umoddi3+0x2c6>
    289c:	959a                	add	a1,a1,t1
    289e:	fff40793          	addi	a5,s0,-1
    28a2:	0065e763          	bltu	a1,t1,28b0 <__umoddi3+0x2c6>
    28a6:	00e5f563          	bgeu	a1,a4,28b0 <__umoddi3+0x2c6>
    28aa:	ffe40793          	addi	a5,s0,-2
    28ae:	959a                	add	a1,a1,t1
    28b0:	06c2                	slli	a3,a3,0x10
	      umul_ppmm (m1, m0, q0, d0);
    28b2:	6441                	lui	s0,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
    28b4:	8edd                	or	a3,a3,a5
    28b6:	40e58733          	sub	a4,a1,a4
	      umul_ppmm (m1, m0, q0, d0);
    28ba:	fff40593          	addi	a1,s0,-1 # ffff <__erodata+0xaf57>
    28be:	00b6f7b3          	and	a5,a3,a1
    28c2:	01065493          	srli	s1,a2,0x10
    28c6:	82c1                	srli	a3,a3,0x10
    28c8:	8df1                	and	a1,a1,a2
    28ca:	02b78533          	mul	a0,a5,a1
    28ce:	02b685b3          	mul	a1,a3,a1
    28d2:	029787b3          	mul	a5,a5,s1
    28d6:	029686b3          	mul	a3,a3,s1
    28da:	97ae                	add	a5,a5,a1
    28dc:	01055493          	srli	s1,a0,0x10
    28e0:	97a6                	add	a5,a5,s1
    28e2:	00b7f363          	bgeu	a5,a1,28e8 <__umoddi3+0x2fe>
    28e6:	96a2                	add	a3,a3,s0
    28e8:	0107d593          	srli	a1,a5,0x10
    28ec:	96ae                	add	a3,a3,a1
    28ee:	65c1                	lui	a1,0x10
    28f0:	15fd                	addi	a1,a1,-1
    28f2:	8fed                	and	a5,a5,a1
    28f4:	07c2                	slli	a5,a5,0x10
    28f6:	8d6d                	and	a0,a0,a1
    28f8:	953e                	add	a0,a0,a5
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
    28fa:	00d76763          	bltu	a4,a3,2908 <__umoddi3+0x31e>
    28fe:	00d71d63          	bne	a4,a3,2918 <__umoddi3+0x32e>
    2902:	4782                	lw	a5,0(sp)
    2904:	00a7fa63          	bgeu	a5,a0,2918 <__umoddi3+0x32e>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
    2908:	40c50633          	sub	a2,a0,a2
    290c:	00c53533          	sltu	a0,a0,a2
    2910:	932a                	add	t1,t1,a0
    2912:	406686b3          	sub	a3,a3,t1
    2916:	8532                	mv	a0,a2
		  sub_ddmmss (n1, n0, n1, n0, m1, m0);
    2918:	4782                	lw	a5,0(sp)
    291a:	40d706b3          	sub	a3,a4,a3
    291e:	40a78533          	sub	a0,a5,a0
    2922:	00a7b5b3          	sltu	a1,a5,a0
    2926:	40b685b3          	sub	a1,a3,a1
		  rr.s.low = (n1 << b) | (n0 >> bm);
    292a:	005597b3          	sll	a5,a1,t0
    292e:	00755533          	srl	a0,a0,t2
		  *rp = rr.ll;
    2932:	8d5d                	or	a0,a0,a5
    2934:	0075d5b3          	srl	a1,a1,t2
    2938:	b3a5                	j	26a0 <__umoddi3+0xb6>

0000293a <__adddf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
    293a:	00100337          	lui	t1,0x100
    293e:	137d                	addi	t1,t1,-1
{
    2940:	1131                	addi	sp,sp,-20
  FP_UNPACK_SEMIRAW_D (A, a);
    2942:	00b377b3          	and	a5,t1,a1
    2946:	0145d713          	srli	a4,a1,0x14
{
    294a:	c426                	sw	s1,8(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
    294c:	078e                	slli	a5,a5,0x3
    294e:	7ff77493          	andi	s1,a4,2047
    2952:	01d55713          	srli	a4,a0,0x1d
    2956:	8fd9                	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
    2958:	00d37733          	and	a4,t1,a3
    295c:	0146d313          	srli	t1,a3,0x14
{
    2960:	c622                	sw	s0,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    2962:	7ff37313          	andi	t1,t1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
    2966:	01f5d413          	srli	s0,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
    296a:	070e                	slli	a4,a4,0x3
    296c:	01f6d593          	srli	a1,a3,0x1f
{
    2970:	c806                	sw	ra,16(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    2972:	01d65693          	srli	a3,a2,0x1d
    2976:	8f55                	or	a4,a4,a3
  FP_UNPACK_SEMIRAW_D (A, a);
    2978:	050e                	slli	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
    297a:	060e                	slli	a2,a2,0x3
  FP_ADD_D (R, A, B);
    297c:	406486b3          	sub	a3,s1,t1
    2980:	22b41463          	bne	s0,a1,2ba8 <__adddf3+0x26e>
    2984:	0ed05263          	blez	a3,2a68 <__adddf3+0x12e>
    2988:	02031863          	bnez	t1,29b8 <__adddf3+0x7e>
    298c:	00c765b3          	or	a1,a4,a2
    2990:	20058a63          	beqz	a1,2ba4 <__adddf3+0x26a>
    2994:	fff68593          	addi	a1,a3,-1
    2998:	e989                	bnez	a1,29aa <__adddf3+0x70>
    299a:	962a                	add	a2,a2,a0
    299c:	00a63533          	sltu	a0,a2,a0
    29a0:	97ba                	add	a5,a5,a4
    29a2:	97aa                	add	a5,a5,a0
    29a4:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    29a6:	4485                	li	s1,1
  FP_ADD_D (R, A, B);
    29a8:	a8b9                	j	2a06 <__adddf3+0xcc>
    29aa:	7ff00313          	li	t1,2047
    29ae:	00669d63          	bne	a3,t1,29c8 <__adddf3+0x8e>
    29b2:	7ff00493          	li	s1,2047
    29b6:	aa71                	j	2b52 <__adddf3+0x218>
    29b8:	7ff00593          	li	a1,2047
    29bc:	18b48b63          	beq	s1,a1,2b52 <__adddf3+0x218>
    29c0:	008005b7          	lui	a1,0x800
    29c4:	8f4d                	or	a4,a4,a1
    29c6:	85b6                	mv	a1,a3
    29c8:	03800693          	li	a3,56
    29cc:	08b6ca63          	blt	a3,a1,2a60 <__adddf3+0x126>
    29d0:	46fd                	li	a3,31
    29d2:	06b6c163          	blt	a3,a1,2a34 <__adddf3+0xfa>
    29d6:	02000313          	li	t1,32
    29da:	40b30333          	sub	t1,t1,a1
    29de:	006716b3          	sll	a3,a4,t1
    29e2:	00b652b3          	srl	t0,a2,a1
    29e6:	00661633          	sll	a2,a2,t1
    29ea:	0056e6b3          	or	a3,a3,t0
    29ee:	00c03633          	snez	a2,a2
    29f2:	8e55                	or	a2,a2,a3
    29f4:	00b75733          	srl	a4,a4,a1
    29f8:	962a                	add	a2,a2,a0
    29fa:	00a63533          	sltu	a0,a2,a0
    29fe:	973e                	add	a4,a4,a5
    2a00:	00a707b3          	add	a5,a4,a0
    2a04:	8532                	mv	a0,a2
    2a06:	00800737          	lui	a4,0x800
    2a0a:	8f7d                	and	a4,a4,a5
    2a0c:	14070363          	beqz	a4,2b52 <__adddf3+0x218>
    2a10:	0485                	addi	s1,s1,1
    2a12:	7ff00713          	li	a4,2047
    2a16:	48e48b63          	beq	s1,a4,2eac <__adddf3+0x572>
    2a1a:	ff800737          	lui	a4,0xff800
    2a1e:	177d                	addi	a4,a4,-1
    2a20:	8ff9                	and	a5,a5,a4
    2a22:	00155713          	srli	a4,a0,0x1
    2a26:	8905                	andi	a0,a0,1
    2a28:	8d59                	or	a0,a0,a4
    2a2a:	01f79713          	slli	a4,a5,0x1f
    2a2e:	8d59                	or	a0,a0,a4
    2a30:	8385                	srli	a5,a5,0x1
    2a32:	a205                	j	2b52 <__adddf3+0x218>
    2a34:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__erodata+0x7faf38>
    2a38:	02000293          	li	t0,32
    2a3c:	00d756b3          	srl	a3,a4,a3
    2a40:	4301                	li	t1,0
    2a42:	00558863          	beq	a1,t0,2a52 <__adddf3+0x118>
    2a46:	04000313          	li	t1,64
    2a4a:	40b305b3          	sub	a1,t1,a1
    2a4e:	00b71333          	sll	t1,a4,a1
    2a52:	00c36633          	or	a2,t1,a2
    2a56:	00c03633          	snez	a2,a2
    2a5a:	8e55                	or	a2,a2,a3
    2a5c:	4701                	li	a4,0
    2a5e:	bf69                	j	29f8 <__adddf3+0xbe>
    2a60:	8e59                	or	a2,a2,a4
    2a62:	00c03633          	snez	a2,a2
    2a66:	bfdd                	j	2a5c <__adddf3+0x122>
    2a68:	cacd                	beqz	a3,2b1a <__adddf3+0x1e0>
    2a6a:	409305b3          	sub	a1,t1,s1
    2a6e:	e48d                	bnez	s1,2a98 <__adddf3+0x15e>
    2a70:	00a7e6b3          	or	a3,a5,a0
    2a74:	42068363          	beqz	a3,2e9a <__adddf3+0x560>
    2a78:	fff58693          	addi	a3,a1,-1
    2a7c:	e699                	bnez	a3,2a8a <__adddf3+0x150>
    2a7e:	9532                	add	a0,a0,a2
    2a80:	97ba                	add	a5,a5,a4
    2a82:	00c53633          	sltu	a2,a0,a2
    2a86:	97b2                	add	a5,a5,a2
    2a88:	bf39                	j	29a6 <__adddf3+0x6c>
    2a8a:	7ff00293          	li	t0,2047
    2a8e:	00559d63          	bne	a1,t0,2aa8 <__adddf3+0x16e>
  FP_UNPACK_SEMIRAW_D (B, b);
    2a92:	87ba                	mv	a5,a4
    2a94:	8532                	mv	a0,a2
    2a96:	bf31                	j	29b2 <__adddf3+0x78>
  FP_ADD_D (R, A, B);
    2a98:	7ff00693          	li	a3,2047
    2a9c:	fed30be3          	beq	t1,a3,2a92 <__adddf3+0x158>
    2aa0:	008006b7          	lui	a3,0x800
    2aa4:	8fd5                	or	a5,a5,a3
    2aa6:	86ae                	mv	a3,a1
    2aa8:	03800593          	li	a1,56
    2aac:	06d5c363          	blt	a1,a3,2b12 <__adddf3+0x1d8>
    2ab0:	45fd                	li	a1,31
    2ab2:	02d5ca63          	blt	a1,a3,2ae6 <__adddf3+0x1ac>
    2ab6:	02000293          	li	t0,32
    2aba:	40d282b3          	sub	t0,t0,a3
    2abe:	005795b3          	sll	a1,a5,t0
    2ac2:	00d553b3          	srl	t2,a0,a3
    2ac6:	00551533          	sll	a0,a0,t0
    2aca:	0075e5b3          	or	a1,a1,t2
    2ace:	00a03533          	snez	a0,a0
    2ad2:	8d4d                	or	a0,a0,a1
    2ad4:	00d7d7b3          	srl	a5,a5,a3
    2ad8:	9532                	add	a0,a0,a2
    2ada:	97ba                	add	a5,a5,a4
    2adc:	00c53633          	sltu	a2,a0,a2
    2ae0:	97b2                	add	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    2ae2:	849a                	mv	s1,t1
    2ae4:	b70d                	j	2a06 <__adddf3+0xcc>
  FP_ADD_D (R, A, B);
    2ae6:	fe068593          	addi	a1,a3,-32 # 7fffe0 <__erodata+0x7faf38>
    2aea:	02000393          	li	t2,32
    2aee:	00b7d5b3          	srl	a1,a5,a1
    2af2:	4281                	li	t0,0
    2af4:	00768863          	beq	a3,t2,2b04 <__adddf3+0x1ca>
    2af8:	04000293          	li	t0,64
    2afc:	40d286b3          	sub	a3,t0,a3
    2b00:	00d792b3          	sll	t0,a5,a3
    2b04:	00a2e533          	or	a0,t0,a0
    2b08:	00a03533          	snez	a0,a0
    2b0c:	8d4d                	or	a0,a0,a1
    2b0e:	4781                	li	a5,0
    2b10:	b7e1                	j	2ad8 <__adddf3+0x19e>
    2b12:	8d5d                	or	a0,a0,a5
    2b14:	00a03533          	snez	a0,a0
    2b18:	bfdd                	j	2b0e <__adddf3+0x1d4>
    2b1a:	00148693          	addi	a3,s1,1 # 80000001 <MTIME_HI_ADDR+0x9fff4005>
    2b1e:	7fe6f593          	andi	a1,a3,2046
    2b22:	e1bd                	bnez	a1,2b88 <__adddf3+0x24e>
    2b24:	00a7e6b3          	or	a3,a5,a0
    2b28:	e4a9                	bnez	s1,2b72 <__adddf3+0x238>
    2b2a:	36068c63          	beqz	a3,2ea2 <__adddf3+0x568>
    2b2e:	00c766b3          	or	a3,a4,a2
    2b32:	c285                	beqz	a3,2b52 <__adddf3+0x218>
    2b34:	962a                	add	a2,a2,a0
    2b36:	97ba                	add	a5,a5,a4
    2b38:	00a63533          	sltu	a0,a2,a0
    2b3c:	97aa                	add	a5,a5,a0
    2b3e:	00800737          	lui	a4,0x800
    2b42:	8f7d                	and	a4,a4,a5
    2b44:	8532                	mv	a0,a2
    2b46:	c711                	beqz	a4,2b52 <__adddf3+0x218>
    2b48:	ff800737          	lui	a4,0xff800
    2b4c:	177d                	addi	a4,a4,-1
    2b4e:	8ff9                	and	a5,a5,a4
    2b50:	4485                	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
    2b52:	00757713          	andi	a4,a0,7
    2b56:	34070d63          	beqz	a4,2eb0 <__adddf3+0x576>
    2b5a:	00f57713          	andi	a4,a0,15
    2b5e:	4691                	li	a3,4
    2b60:	34d70863          	beq	a4,a3,2eb0 <__adddf3+0x576>
    2b64:	00450713          	addi	a4,a0,4
    2b68:	00a73533          	sltu	a0,a4,a0
    2b6c:	97aa                	add	a5,a5,a0
    2b6e:	853a                	mv	a0,a4
    2b70:	a681                	j	2eb0 <__adddf3+0x576>
  FP_ADD_D (R, A, B);
    2b72:	d285                	beqz	a3,2a92 <__adddf3+0x158>
    2b74:	8e59                	or	a2,a2,a4
    2b76:	e2060ee3          	beqz	a2,29b2 <__adddf3+0x78>
    2b7a:	4401                	li	s0,0
    2b7c:	004007b7          	lui	a5,0x400
    2b80:	4501                	li	a0,0
    2b82:	7ff00493          	li	s1,2047
    2b86:	a62d                	j	2eb0 <__adddf3+0x576>
    2b88:	7ff00593          	li	a1,2047
    2b8c:	30b68e63          	beq	a3,a1,2ea8 <__adddf3+0x56e>
    2b90:	962a                	add	a2,a2,a0
    2b92:	00a63533          	sltu	a0,a2,a0
    2b96:	97ba                	add	a5,a5,a4
    2b98:	97aa                	add	a5,a5,a0
    2b9a:	01f79513          	slli	a0,a5,0x1f
    2b9e:	8205                	srli	a2,a2,0x1
    2ba0:	8d51                	or	a0,a0,a2
    2ba2:	8385                	srli	a5,a5,0x1
    2ba4:	84b6                	mv	s1,a3
    2ba6:	b775                	j	2b52 <__adddf3+0x218>
    2ba8:	0cd05463          	blez	a3,2c70 <__adddf3+0x336>
    2bac:	06031f63          	bnez	t1,2c2a <__adddf3+0x2f0>
    2bb0:	00c765b3          	or	a1,a4,a2
    2bb4:	d9e5                	beqz	a1,2ba4 <__adddf3+0x26a>
    2bb6:	fff68593          	addi	a1,a3,-1
    2bba:	e991                	bnez	a1,2bce <__adddf3+0x294>
    2bbc:	40c50633          	sub	a2,a0,a2
    2bc0:	00c53533          	sltu	a0,a0,a2
    2bc4:	8f99                	sub	a5,a5,a4
    2bc6:	8f89                	sub	a5,a5,a0
    2bc8:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    2bca:	4485                	li	s1,1
  FP_ADD_D (R, A, B);
    2bcc:	a0b1                	j	2c18 <__adddf3+0x2de>
    2bce:	7ff00313          	li	t1,2047
    2bd2:	de6680e3          	beq	a3,t1,29b2 <__adddf3+0x78>
    2bd6:	03800693          	li	a3,56
    2bda:	08b6c763          	blt	a3,a1,2c68 <__adddf3+0x32e>
    2bde:	46fd                	li	a3,31
    2be0:	04b6ce63          	blt	a3,a1,2c3c <__adddf3+0x302>
    2be4:	02000313          	li	t1,32
    2be8:	40b30333          	sub	t1,t1,a1
    2bec:	006716b3          	sll	a3,a4,t1
    2bf0:	00b652b3          	srl	t0,a2,a1
    2bf4:	00661633          	sll	a2,a2,t1
    2bf8:	0056e6b3          	or	a3,a3,t0
    2bfc:	00c03633          	snez	a2,a2
    2c00:	8e55                	or	a2,a2,a3
    2c02:	00b75733          	srl	a4,a4,a1
    2c06:	40c50633          	sub	a2,a0,a2
    2c0a:	00c53533          	sltu	a0,a0,a2
    2c0e:	40e78733          	sub	a4,a5,a4
    2c12:	40a707b3          	sub	a5,a4,a0
    2c16:	8532                	mv	a0,a2
    2c18:	008006b7          	lui	a3,0x800
    2c1c:	00d7f733          	and	a4,a5,a3
    2c20:	db0d                	beqz	a4,2b52 <__adddf3+0x218>
    2c22:	16fd                	addi	a3,a3,-1
    2c24:	8efd                	and	a3,a3,a5
    2c26:	832a                	mv	t1,a0
    2c28:	aa55                	j	2ddc <__adddf3+0x4a2>
    2c2a:	7ff00593          	li	a1,2047
    2c2e:	f2b482e3          	beq	s1,a1,2b52 <__adddf3+0x218>
    2c32:	008005b7          	lui	a1,0x800
    2c36:	8f4d                	or	a4,a4,a1
    2c38:	85b6                	mv	a1,a3
    2c3a:	bf71                	j	2bd6 <__adddf3+0x29c>
    2c3c:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__erodata+0x7faf38>
    2c40:	02000293          	li	t0,32
    2c44:	00d756b3          	srl	a3,a4,a3
    2c48:	4301                	li	t1,0
    2c4a:	00558863          	beq	a1,t0,2c5a <__adddf3+0x320>
    2c4e:	04000313          	li	t1,64
    2c52:	40b305b3          	sub	a1,t1,a1
    2c56:	00b71333          	sll	t1,a4,a1
    2c5a:	00c36633          	or	a2,t1,a2
    2c5e:	00c03633          	snez	a2,a2
    2c62:	8e55                	or	a2,a2,a3
    2c64:	4701                	li	a4,0
    2c66:	b745                	j	2c06 <__adddf3+0x2cc>
    2c68:	8e59                	or	a2,a2,a4
    2c6a:	00c03633          	snez	a2,a2
    2c6e:	bfdd                	j	2c64 <__adddf3+0x32a>
    2c70:	c2f9                	beqz	a3,2d36 <__adddf3+0x3fc>
    2c72:	409302b3          	sub	t0,t1,s1
    2c76:	e895                	bnez	s1,2caa <__adddf3+0x370>
    2c78:	00a7e6b3          	or	a3,a5,a0
    2c7c:	28068863          	beqz	a3,2f0c <__adddf3+0x5d2>
    2c80:	fff28693          	addi	a3,t0,-1 # ffffff <__erodata+0xffaf57>
    2c84:	ea91                	bnez	a3,2c98 <__adddf3+0x35e>
    2c86:	40a60533          	sub	a0,a2,a0
    2c8a:	40f707b3          	sub	a5,a4,a5
    2c8e:	00a63633          	sltu	a2,a2,a0
    2c92:	8f91                	sub	a5,a5,a2
    2c94:	842e                	mv	s0,a1
    2c96:	bf15                	j	2bca <__adddf3+0x290>
    2c98:	7ff00393          	li	t2,2047
    2c9c:	00729f63          	bne	t0,t2,2cba <__adddf3+0x380>
  FP_UNPACK_SEMIRAW_D (B, b);
    2ca0:	87ba                	mv	a5,a4
    2ca2:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    2ca4:	7ff00493          	li	s1,2047
    2ca8:	a07d                	j	2d56 <__adddf3+0x41c>
    2caa:	7ff00693          	li	a3,2047
    2cae:	fed309e3          	beq	t1,a3,2ca0 <__adddf3+0x366>
    2cb2:	008006b7          	lui	a3,0x800
    2cb6:	8fd5                	or	a5,a5,a3
    2cb8:	8696                	mv	a3,t0
    2cba:	03800293          	li	t0,56
    2cbe:	06d2c863          	blt	t0,a3,2d2e <__adddf3+0x3f4>
    2cc2:	42fd                	li	t0,31
    2cc4:	02d2ce63          	blt	t0,a3,2d00 <__adddf3+0x3c6>
    2cc8:	02000393          	li	t2,32
    2ccc:	40d383b3          	sub	t2,t2,a3
    2cd0:	007792b3          	sll	t0,a5,t2
    2cd4:	00d55433          	srl	s0,a0,a3
    2cd8:	00751533          	sll	a0,a0,t2
    2cdc:	0082e2b3          	or	t0,t0,s0
    2ce0:	00a03533          	snez	a0,a0
    2ce4:	00a2e533          	or	a0,t0,a0
    2ce8:	00d7d7b3          	srl	a5,a5,a3
    2cec:	40a60533          	sub	a0,a2,a0
    2cf0:	40f707b3          	sub	a5,a4,a5
    2cf4:	00a63633          	sltu	a2,a2,a0
    2cf8:	8f91                	sub	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    2cfa:	849a                	mv	s1,t1
    2cfc:	842e                	mv	s0,a1
    2cfe:	bf29                	j	2c18 <__adddf3+0x2de>
  FP_ADD_D (R, A, B);
    2d00:	fe068293          	addi	t0,a3,-32 # 7fffe0 <__erodata+0x7faf38>
    2d04:	02000413          	li	s0,32
    2d08:	0057d2b3          	srl	t0,a5,t0
    2d0c:	4381                	li	t2,0
    2d0e:	00868863          	beq	a3,s0,2d1e <__adddf3+0x3e4>
    2d12:	04000393          	li	t2,64
    2d16:	40d386b3          	sub	a3,t2,a3
    2d1a:	00d793b3          	sll	t2,a5,a3
    2d1e:	00a3e533          	or	a0,t2,a0
    2d22:	00a03533          	snez	a0,a0
    2d26:	00a2e533          	or	a0,t0,a0
    2d2a:	4781                	li	a5,0
    2d2c:	b7c1                	j	2cec <__adddf3+0x3b2>
    2d2e:	8d5d                	or	a0,a0,a5
    2d30:	00a03533          	snez	a0,a0
    2d34:	bfdd                	j	2d2a <__adddf3+0x3f0>
    2d36:	00148693          	addi	a3,s1,1
    2d3a:	7fe6f693          	andi	a3,a3,2046
    2d3e:	eaa5                	bnez	a3,2dae <__adddf3+0x474>
    2d40:	00a7e333          	or	t1,a5,a0
    2d44:	00c766b3          	or	a3,a4,a2
    2d48:	e8a1                	bnez	s1,2d98 <__adddf3+0x45e>
    2d4a:	00031863          	bnez	t1,2d5a <__adddf3+0x420>
    2d4e:	1c068363          	beqz	a3,2f14 <__adddf3+0x5da>
  FP_UNPACK_SEMIRAW_D (B, b);
    2d52:	87ba                	mv	a5,a4
    2d54:	8532                	mv	a0,a2
    2d56:	842e                	mv	s0,a1
    2d58:	bbed                	j	2b52 <__adddf3+0x218>
  FP_ADD_D (R, A, B);
    2d5a:	de068ce3          	beqz	a3,2b52 <__adddf3+0x218>
    2d5e:	40c50333          	sub	t1,a0,a2
    2d62:	006532b3          	sltu	t0,a0,t1
    2d66:	40e786b3          	sub	a3,a5,a4
    2d6a:	405686b3          	sub	a3,a3,t0
    2d6e:	008002b7          	lui	t0,0x800
    2d72:	0056f2b3          	and	t0,a3,t0
    2d76:	00028a63          	beqz	t0,2d8a <__adddf3+0x450>
    2d7a:	40a60533          	sub	a0,a2,a0
    2d7e:	40f707b3          	sub	a5,a4,a5
    2d82:	00a63633          	sltu	a2,a2,a0
    2d86:	8f91                	sub	a5,a5,a2
    2d88:	b7f9                	j	2d56 <__adddf3+0x41c>
    2d8a:	00d36533          	or	a0,t1,a3
    2d8e:	18050763          	beqz	a0,2f1c <__adddf3+0x5e2>
    2d92:	87b6                	mv	a5,a3
    2d94:	851a                	mv	a0,t1
    2d96:	bb75                	j	2b52 <__adddf3+0x218>
    2d98:	00031863          	bnez	t1,2da8 <__adddf3+0x46e>
    2d9c:	18068263          	beqz	a3,2f20 <__adddf3+0x5e6>
  FP_UNPACK_SEMIRAW_D (B, b);
    2da0:	87ba                	mv	a5,a4
    2da2:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    2da4:	842e                	mv	s0,a1
    2da6:	b131                	j	29b2 <__adddf3+0x78>
    2da8:	c00685e3          	beqz	a3,29b2 <__adddf3+0x78>
    2dac:	b3f9                	j	2b7a <__adddf3+0x240>
    2dae:	40c50333          	sub	t1,a0,a2
    2db2:	006532b3          	sltu	t0,a0,t1
    2db6:	40e786b3          	sub	a3,a5,a4
    2dba:	405686b3          	sub	a3,a3,t0
    2dbe:	008002b7          	lui	t0,0x800
    2dc2:	0056f2b3          	and	t0,a3,t0
    2dc6:	06028b63          	beqz	t0,2e3c <__adddf3+0x502>
    2dca:	40a60333          	sub	t1,a2,a0
    2dce:	40f707b3          	sub	a5,a4,a5
    2dd2:	00663633          	sltu	a2,a2,t1
    2dd6:	40c786b3          	sub	a3,a5,a2
    2dda:	842e                	mv	s0,a1
    2ddc:	c6b5                	beqz	a3,2e48 <__adddf3+0x50e>
    2dde:	8536                	mv	a0,a3
    2de0:	c21a                	sw	t1,4(sp)
    2de2:	c036                	sw	a3,0(sp)
    2de4:	404010ef          	jal	ra,41e8 <__clzsi2>
    2de8:	4682                	lw	a3,0(sp)
    2dea:	4312                	lw	t1,4(sp)
    2dec:	ff850713          	addi	a4,a0,-8
    2df0:	47fd                	li	a5,31
    2df2:	06e7c563          	blt	a5,a4,2e5c <__adddf3+0x522>
    2df6:	02000793          	li	a5,32
    2dfa:	8f99                	sub	a5,a5,a4
    2dfc:	00e696b3          	sll	a3,a3,a4
    2e00:	00f357b3          	srl	a5,t1,a5
    2e04:	8fd5                	or	a5,a5,a3
    2e06:	00e31533          	sll	a0,t1,a4
    2e0a:	08974263          	blt	a4,s1,2e8e <__adddf3+0x554>
    2e0e:	8f05                	sub	a4,a4,s1
    2e10:	00170613          	addi	a2,a4,1 # ff800001 <MTIME_HI_ADDR+0x1f7f4005>
    2e14:	46fd                	li	a3,31
    2e16:	04c6c963          	blt	a3,a2,2e68 <__adddf3+0x52e>
    2e1a:	02000713          	li	a4,32
    2e1e:	8f11                	sub	a4,a4,a2
    2e20:	00e796b3          	sll	a3,a5,a4
    2e24:	00c555b3          	srl	a1,a0,a2
    2e28:	00e51533          	sll	a0,a0,a4
    2e2c:	8ecd                	or	a3,a3,a1
    2e2e:	00a03533          	snez	a0,a0
    2e32:	8d55                	or	a0,a0,a3
    2e34:	00c7d7b3          	srl	a5,a5,a2
    2e38:	4481                	li	s1,0
    2e3a:	bb21                	j	2b52 <__adddf3+0x218>
    2e3c:	00d36533          	or	a0,t1,a3
    2e40:	fd51                	bnez	a0,2ddc <__adddf3+0x4a2>
    2e42:	4781                	li	a5,0
    2e44:	4481                	li	s1,0
    2e46:	a8c9                	j	2f18 <__adddf3+0x5de>
    2e48:	851a                	mv	a0,t1
    2e4a:	c236                	sw	a3,4(sp)
    2e4c:	c01a                	sw	t1,0(sp)
    2e4e:	39a010ef          	jal	ra,41e8 <__clzsi2>
    2e52:	4692                	lw	a3,4(sp)
    2e54:	4302                	lw	t1,0(sp)
    2e56:	02050513          	addi	a0,a0,32
    2e5a:	bf49                	j	2dec <__adddf3+0x4b2>
    2e5c:	fd850793          	addi	a5,a0,-40
    2e60:	00f317b3          	sll	a5,t1,a5
    2e64:	4501                	li	a0,0
    2e66:	b755                	j	2e0a <__adddf3+0x4d0>
    2e68:	1705                	addi	a4,a4,-31
    2e6a:	02000593          	li	a1,32
    2e6e:	00e7d733          	srl	a4,a5,a4
    2e72:	4681                	li	a3,0
    2e74:	00b60763          	beq	a2,a1,2e82 <__adddf3+0x548>
    2e78:	04000693          	li	a3,64
    2e7c:	8e91                	sub	a3,a3,a2
    2e7e:	00d796b3          	sll	a3,a5,a3
    2e82:	8d55                	or	a0,a0,a3
    2e84:	00a03533          	snez	a0,a0
    2e88:	8d59                	or	a0,a0,a4
    2e8a:	4781                	li	a5,0
    2e8c:	b775                	j	2e38 <__adddf3+0x4fe>
    2e8e:	8c99                	sub	s1,s1,a4
    2e90:	ff800737          	lui	a4,0xff800
    2e94:	177d                	addi	a4,a4,-1
    2e96:	8ff9                	and	a5,a5,a4
    2e98:	b96d                	j	2b52 <__adddf3+0x218>
  FP_UNPACK_SEMIRAW_D (B, b);
    2e9a:	87ba                	mv	a5,a4
    2e9c:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    2e9e:	84ae                	mv	s1,a1
    2ea0:	b94d                	j	2b52 <__adddf3+0x218>
  FP_UNPACK_SEMIRAW_D (B, b);
    2ea2:	87ba                	mv	a5,a4
    2ea4:	8532                	mv	a0,a2
    2ea6:	b175                	j	2b52 <__adddf3+0x218>
    2ea8:	7ff00493          	li	s1,2047
    2eac:	4781                	li	a5,0
    2eae:	4501                	li	a0,0
  FP_PACK_SEMIRAW_D (r, R);
    2eb0:	00800737          	lui	a4,0x800
    2eb4:	8f7d                	and	a4,a4,a5
    2eb6:	cb11                	beqz	a4,2eca <__adddf3+0x590>
    2eb8:	0485                	addi	s1,s1,1
    2eba:	7ff00713          	li	a4,2047
    2ebe:	06e48663          	beq	s1,a4,2f2a <__adddf3+0x5f0>
    2ec2:	ff800737          	lui	a4,0xff800
    2ec6:	177d                	addi	a4,a4,-1
    2ec8:	8ff9                	and	a5,a5,a4
    2eca:	01d79713          	slli	a4,a5,0x1d
    2ece:	810d                	srli	a0,a0,0x3
    2ed0:	8d59                	or	a0,a0,a4
    2ed2:	7ff00713          	li	a4,2047
    2ed6:	838d                	srli	a5,a5,0x3
    2ed8:	00e49963          	bne	s1,a4,2eea <__adddf3+0x5b0>
    2edc:	8d5d                	or	a0,a0,a5
    2ede:	4781                	li	a5,0
    2ee0:	c509                	beqz	a0,2eea <__adddf3+0x5b0>
    2ee2:	000807b7          	lui	a5,0x80
    2ee6:	4501                	li	a0,0
    2ee8:	4401                	li	s0,0
    2eea:	01449713          	slli	a4,s1,0x14
    2eee:	7ff006b7          	lui	a3,0x7ff00
    2ef2:	07b2                	slli	a5,a5,0xc
    2ef4:	8f75                	and	a4,a4,a3
    2ef6:	83b1                	srli	a5,a5,0xc
    2ef8:	047e                	slli	s0,s0,0x1f
    2efa:	8fd9                	or	a5,a5,a4
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    2efc:	40c2                	lw	ra,16(sp)
  FP_PACK_SEMIRAW_D (r, R);
    2efe:	0087e733          	or	a4,a5,s0
}
    2f02:	4432                	lw	s0,12(sp)
    2f04:	44a2                	lw	s1,8(sp)
    2f06:	85ba                	mv	a1,a4
    2f08:	0151                	addi	sp,sp,20
    2f0a:	8082                	ret
  FP_UNPACK_SEMIRAW_D (B, b);
    2f0c:	87ba                	mv	a5,a4
    2f0e:	8532                	mv	a0,a2
  FP_ADD_D (R, A, B);
    2f10:	8496                	mv	s1,t0
    2f12:	b591                	j	2d56 <__adddf3+0x41c>
    2f14:	4781                	li	a5,0
    2f16:	4501                	li	a0,0
    2f18:	4401                	li	s0,0
    2f1a:	bf59                	j	2eb0 <__adddf3+0x576>
    2f1c:	4781                	li	a5,0
    2f1e:	bfed                	j	2f18 <__adddf3+0x5de>
    2f20:	4501                	li	a0,0
    2f22:	4401                	li	s0,0
    2f24:	004007b7          	lui	a5,0x400
    2f28:	b9a9                	j	2b82 <__adddf3+0x248>
    2f2a:	4781                	li	a5,0
    2f2c:	4501                	li	a0,0
    2f2e:	bf71                	j	2eca <__adddf3+0x590>

00002f30 <__divdf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__divdf3 (DFtype a, DFtype b)
{
    2f30:	fdc10113          	addi	sp,sp,-36
    2f34:	cc26                	sw	s1,24(sp)
    2f36:	872a                	mv	a4,a0
    2f38:	84b2                	mv	s1,a2
    2f3a:	87aa                	mv	a5,a0
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
    2f3c:	01f5d613          	srli	a2,a1,0x1f
    2f40:	0145d513          	srli	a0,a1,0x14
    2f44:	00c59313          	slli	t1,a1,0xc
{
    2f48:	d006                	sw	ra,32(sp)
    2f4a:	ce22                	sw	s0,28(sp)
  FP_UNPACK_D (A, a);
    2f4c:	7ff57513          	andi	a0,a0,2047
    2f50:	c432                	sw	a2,8(sp)
    2f52:	00c35313          	srli	t1,t1,0xc
    2f56:	c541                	beqz	a0,2fde <__divdf3+0xae>
    2f58:	7ff00593          	li	a1,2047
    2f5c:	0eb50663          	beq	a0,a1,3048 <__divdf3+0x118>
    2f60:	01d75413          	srli	s0,a4,0x1d
    2f64:	030e                	slli	t1,t1,0x3
    2f66:	008007b7          	lui	a5,0x800
    2f6a:	00646433          	or	s0,s0,t1
    2f6e:	8c5d                	or	s0,s0,a5
    2f70:	c0150613          	addi	a2,a0,-1023
    2f74:	00371793          	slli	a5,a4,0x3
    2f78:	4301                	li	t1,0
  FP_UNPACK_D (B, b);
    2f7a:	0146d513          	srli	a0,a3,0x14
    2f7e:	01f6d713          	srli	a4,a3,0x1f
    2f82:	00c69393          	slli	t2,a3,0xc
    2f86:	7ff57513          	andi	a0,a0,2047
    2f8a:	c63a                	sw	a4,12(sp)
    2f8c:	00c3d393          	srli	t2,t2,0xc
    2f90:	cd69                	beqz	a0,306a <__divdf3+0x13a>
    2f92:	7ff00713          	li	a4,2047
    2f96:	14e50563          	beq	a0,a4,30e0 <__divdf3+0x1b0>
    2f9a:	01d4d713          	srli	a4,s1,0x1d
    2f9e:	038e                	slli	t2,t2,0x3
    2fa0:	007763b3          	or	t2,a4,t2
    2fa4:	008006b7          	lui	a3,0x800
    2fa8:	00d3e3b3          	or	t2,t2,a3
    2fac:	00349713          	slli	a4,s1,0x3
    2fb0:	c0150513          	addi	a0,a0,-1023
    2fb4:	4681                	li	a3,0
  FP_DIV_D (R, A, B);
    2fb6:	45a2                	lw	a1,8(sp)
    2fb8:	44b2                	lw	s1,12(sp)
    2fba:	8e09                	sub	a2,a2,a0
    2fbc:	c232                	sw	a2,4(sp)
    2fbe:	00231613          	slli	a2,t1,0x2
    2fc2:	8da5                	xor	a1,a1,s1
    2fc4:	8e55                	or	a2,a2,a3
    2fc6:	c02e                	sw	a1,0(sp)
    2fc8:	167d                	addi	a2,a2,-1
    2fca:	45b9                	li	a1,14
    2fcc:	12c5eb63          	bltu	a1,a2,3102 <__divdf3+0x1d2>
    2fd0:	6595                	lui	a1,0x5
    2fd2:	060a                	slli	a2,a2,0x2
    2fd4:	f3058593          	addi	a1,a1,-208 # 4f30 <_ctype_+0xa40>
    2fd8:	962e                	add	a2,a2,a1
    2fda:	4210                	lw	a2,0(a2)
    2fdc:	8602                	jr	a2
  FP_UNPACK_D (A, a);
    2fde:	00e36433          	or	s0,t1,a4
    2fe2:	c83d                	beqz	s0,3058 <__divdf3+0x128>
    2fe4:	c636                	sw	a3,12(sp)
    2fe6:	04030063          	beqz	t1,3026 <__divdf3+0xf6>
    2fea:	851a                	mv	a0,t1
    2fec:	c23a                	sw	a4,4(sp)
    2fee:	c01a                	sw	t1,0(sp)
    2ff0:	1f8010ef          	jal	ra,41e8 <__clzsi2>
    2ff4:	4302                	lw	t1,0(sp)
    2ff6:	4712                	lw	a4,4(sp)
    2ff8:	46b2                	lw	a3,12(sp)
    2ffa:	ff550593          	addi	a1,a0,-11
    2ffe:	47f1                	li	a5,28
    3000:	02b7ce63          	blt	a5,a1,303c <__divdf3+0x10c>
    3004:	4475                	li	s0,29
    3006:	ff850793          	addi	a5,a0,-8
    300a:	8c0d                	sub	s0,s0,a1
    300c:	00f31333          	sll	t1,t1,a5
    3010:	00875433          	srl	s0,a4,s0
    3014:	00646433          	or	s0,s0,t1
    3018:	00f717b3          	sll	a5,a4,a5
    301c:	c0d00593          	li	a1,-1011
    3020:	40a58633          	sub	a2,a1,a0
    3024:	bf91                	j	2f78 <__divdf3+0x48>
    3026:	853a                	mv	a0,a4
    3028:	c21a                	sw	t1,4(sp)
    302a:	c03a                	sw	a4,0(sp)
    302c:	1bc010ef          	jal	ra,41e8 <__clzsi2>
    3030:	46b2                	lw	a3,12(sp)
    3032:	4312                	lw	t1,4(sp)
    3034:	4702                	lw	a4,0(sp)
    3036:	02050513          	addi	a0,a0,32
    303a:	b7c1                	j	2ffa <__divdf3+0xca>
    303c:	fd850413          	addi	s0,a0,-40
    3040:	00871433          	sll	s0,a4,s0
    3044:	4781                	li	a5,0
    3046:	bfd9                	j	301c <__divdf3+0xec>
    3048:	00e36433          	or	s0,t1,a4
    304c:	c811                	beqz	s0,3060 <__divdf3+0x130>
    304e:	841a                	mv	s0,t1
    3050:	7ff00613          	li	a2,2047
    3054:	430d                	li	t1,3
    3056:	b715                	j	2f7a <__divdf3+0x4a>
    3058:	4781                	li	a5,0
    305a:	4601                	li	a2,0
    305c:	4305                	li	t1,1
    305e:	bf31                	j	2f7a <__divdf3+0x4a>
    3060:	4781                	li	a5,0
    3062:	7ff00613          	li	a2,2047
    3066:	4309                	li	t1,2
    3068:	bf09                	j	2f7a <__divdf3+0x4a>
  FP_UNPACK_D (B, b);
    306a:	0093e733          	or	a4,t2,s1
    306e:	c349                	beqz	a4,30f0 <__divdf3+0x1c0>
    3070:	04038463          	beqz	t2,30b8 <__divdf3+0x188>
    3074:	851e                	mv	a0,t2
    3076:	ca1a                	sw	t1,20(sp)
    3078:	c832                	sw	a2,16(sp)
    307a:	c23e                	sw	a5,4(sp)
    307c:	c01e                	sw	t2,0(sp)
    307e:	16a010ef          	jal	ra,41e8 <__clzsi2>
    3082:	4382                	lw	t2,0(sp)
    3084:	4792                	lw	a5,4(sp)
    3086:	4642                	lw	a2,16(sp)
    3088:	4352                	lw	t1,20(sp)
    308a:	ff550293          	addi	t0,a0,-11
    308e:	4771                	li	a4,28
    3090:	04574263          	blt	a4,t0,30d4 <__divdf3+0x1a4>
    3094:	46f5                	li	a3,29
    3096:	ff850713          	addi	a4,a0,-8
    309a:	405686b3          	sub	a3,a3,t0
    309e:	00e393b3          	sll	t2,t2,a4
    30a2:	00d4d6b3          	srl	a3,s1,a3
    30a6:	0076e3b3          	or	t2,a3,t2
    30aa:	00e49733          	sll	a4,s1,a4
    30ae:	c0d00693          	li	a3,-1011
    30b2:	40a68533          	sub	a0,a3,a0
    30b6:	bdfd                	j	2fb4 <__divdf3+0x84>
    30b8:	8526                	mv	a0,s1
    30ba:	ca1e                	sw	t2,20(sp)
    30bc:	c81a                	sw	t1,16(sp)
    30be:	c232                	sw	a2,4(sp)
    30c0:	c03e                	sw	a5,0(sp)
    30c2:	126010ef          	jal	ra,41e8 <__clzsi2>
    30c6:	43d2                	lw	t2,20(sp)
    30c8:	4342                	lw	t1,16(sp)
    30ca:	4612                	lw	a2,4(sp)
    30cc:	4782                	lw	a5,0(sp)
    30ce:	02050513          	addi	a0,a0,32
    30d2:	bf65                	j	308a <__divdf3+0x15a>
    30d4:	fd850393          	addi	t2,a0,-40
    30d8:	007493b3          	sll	t2,s1,t2
    30dc:	4701                	li	a4,0
    30de:	bfc1                	j	30ae <__divdf3+0x17e>
    30e0:	0093e733          	or	a4,t2,s1
    30e4:	cb11                	beqz	a4,30f8 <__divdf3+0x1c8>
    30e6:	8726                	mv	a4,s1
    30e8:	7ff00513          	li	a0,2047
    30ec:	468d                	li	a3,3
    30ee:	b5e1                	j	2fb6 <__divdf3+0x86>
    30f0:	4381                	li	t2,0
    30f2:	4501                	li	a0,0
    30f4:	4685                	li	a3,1
    30f6:	b5c1                	j	2fb6 <__divdf3+0x86>
    30f8:	4381                	li	t2,0
    30fa:	7ff00513          	li	a0,2047
    30fe:	4689                	li	a3,2
    3100:	bd5d                	j	2fb6 <__divdf3+0x86>
  FP_DIV_D (R, A, B);
    3102:	0083e663          	bltu	t2,s0,310e <__divdf3+0x1de>
    3106:	2c741263          	bne	s0,t2,33ca <__divdf3+0x49a>
    310a:	2ce7e063          	bltu	a5,a4,33ca <__divdf3+0x49a>
    310e:	01f41613          	slli	a2,s0,0x1f
    3112:	0017d693          	srli	a3,a5,0x1
    3116:	01f79513          	slli	a0,a5,0x1f
    311a:	8005                	srli	s0,s0,0x1
    311c:	00d667b3          	or	a5,a2,a3
    3120:	03a2                	slli	t2,t2,0x8
    3122:	0103d493          	srli	s1,t2,0x10
    3126:	02945333          	divu	t1,s0,s1
    312a:	01875613          	srli	a2,a4,0x18
    312e:	00766633          	or	a2,a2,t2
    3132:	00871593          	slli	a1,a4,0x8
    3136:	01061713          	slli	a4,a2,0x10
    313a:	8341                	srli	a4,a4,0x10
    313c:	c43a                	sw	a4,8(sp)
    313e:	0107d693          	srli	a3,a5,0x10
    3142:	02947433          	remu	s0,s0,s1
    3146:	02670733          	mul	a4,a4,t1
    314a:	0442                	slli	s0,s0,0x10
    314c:	8c55                	or	s0,s0,a3
    314e:	869a                	mv	a3,t1
    3150:	00e47c63          	bgeu	s0,a4,3168 <__divdf3+0x238>
    3154:	9432                	add	s0,s0,a2
    3156:	fff30693          	addi	a3,t1,-1 # fffff <__erodata+0xfaf57>
    315a:	00c46763          	bltu	s0,a2,3168 <__divdf3+0x238>
    315e:	00e47563          	bgeu	s0,a4,3168 <__divdf3+0x238>
    3162:	ffe30693          	addi	a3,t1,-2
    3166:	9432                	add	s0,s0,a2
    3168:	8c19                	sub	s0,s0,a4
    316a:	029452b3          	divu	t0,s0,s1
    316e:	01061713          	slli	a4,a2,0x10
    3172:	8341                	srli	a4,a4,0x10
    3174:	07c2                	slli	a5,a5,0x10
    3176:	83c1                	srli	a5,a5,0x10
    3178:	02947433          	remu	s0,s0,s1
    317c:	8396                	mv	t2,t0
    317e:	02570333          	mul	t1,a4,t0
    3182:	0442                	slli	s0,s0,0x10
    3184:	8fc1                	or	a5,a5,s0
    3186:	0067fc63          	bgeu	a5,t1,319e <__divdf3+0x26e>
    318a:	97b2                	add	a5,a5,a2
    318c:	fff28393          	addi	t2,t0,-1 # 7fffff <__erodata+0x7faf57>
    3190:	00c7e763          	bltu	a5,a2,319e <__divdf3+0x26e>
    3194:	0067f563          	bgeu	a5,t1,319e <__divdf3+0x26e>
    3198:	ffe28393          	addi	t2,t0,-2
    319c:	97b2                	add	a5,a5,a2
    319e:	06c2                	slli	a3,a3,0x10
    31a0:	6441                	lui	s0,0x10
    31a2:	0076e6b3          	or	a3,a3,t2
    31a6:	fff40713          	addi	a4,s0,-1 # ffff <__erodata+0xaf57>
    31aa:	00e6f2b3          	and	t0,a3,a4
    31ae:	406787b3          	sub	a5,a5,t1
    31b2:	8f6d                	and	a4,a4,a1
    31b4:	0106d313          	srli	t1,a3,0x10
    31b8:	025703b3          	mul	t2,a4,t0
    31bc:	c43a                	sw	a4,8(sp)
    31be:	02e30733          	mul	a4,t1,a4
    31c2:	c63a                	sw	a4,12(sp)
    31c4:	0105d713          	srli	a4,a1,0x10
    31c8:	025702b3          	mul	t0,a4,t0
    31cc:	02e30333          	mul	t1,t1,a4
    31d0:	4732                	lw	a4,12(sp)
    31d2:	92ba                	add	t0,t0,a4
    31d4:	0103d713          	srli	a4,t2,0x10
    31d8:	9716                	add	a4,a4,t0
    31da:	42b2                	lw	t0,12(sp)
    31dc:	00577363          	bgeu	a4,t0,31e2 <__divdf3+0x2b2>
    31e0:	9322                	add	t1,t1,s0
    31e2:	6441                	lui	s0,0x10
    31e4:	147d                	addi	s0,s0,-1
    31e6:	01075293          	srli	t0,a4,0x10
    31ea:	8f61                	and	a4,a4,s0
    31ec:	0742                	slli	a4,a4,0x10
    31ee:	0083f3b3          	and	t2,t2,s0
    31f2:	9316                	add	t1,t1,t0
    31f4:	971e                	add	a4,a4,t2
    31f6:	0067e763          	bltu	a5,t1,3204 <__divdf3+0x2d4>
    31fa:	83b6                	mv	t2,a3
    31fc:	02679e63          	bne	a5,t1,3238 <__divdf3+0x308>
    3200:	02e57c63          	bgeu	a0,a4,3238 <__divdf3+0x308>
    3204:	952e                	add	a0,a0,a1
    3206:	00b532b3          	sltu	t0,a0,a1
    320a:	92b2                	add	t0,t0,a2
    320c:	9796                	add	a5,a5,t0
    320e:	fff68393          	addi	t2,a3,-1 # 7fffff <__erodata+0x7faf57>
    3212:	00f66663          	bltu	a2,a5,321e <__divdf3+0x2ee>
    3216:	02f61163          	bne	a2,a5,3238 <__divdf3+0x308>
    321a:	00b56f63          	bltu	a0,a1,3238 <__divdf3+0x308>
    321e:	0067e663          	bltu	a5,t1,322a <__divdf3+0x2fa>
    3222:	00f31b63          	bne	t1,a5,3238 <__divdf3+0x308>
    3226:	00e57963          	bgeu	a0,a4,3238 <__divdf3+0x308>
    322a:	952e                	add	a0,a0,a1
    322c:	ffe68393          	addi	t2,a3,-2
    3230:	00b536b3          	sltu	a3,a0,a1
    3234:	96b2                	add	a3,a3,a2
    3236:	97b6                	add	a5,a5,a3
    3238:	40e502b3          	sub	t0,a0,a4
    323c:	40678333          	sub	t1,a5,t1
    3240:	00553533          	sltu	a0,a0,t0
    3244:	40a30333          	sub	t1,t1,a0
    3248:	577d                	li	a4,-1
    324a:	10660063          	beq	a2,t1,334a <__divdf3+0x41a>
    324e:	02935433          	divu	s0,t1,s1
    3252:	01061793          	slli	a5,a2,0x10
    3256:	83c1                	srli	a5,a5,0x10
    3258:	0102d693          	srli	a3,t0,0x10
    325c:	02878733          	mul	a4,a5,s0
    3260:	029377b3          	remu	a5,t1,s1
    3264:	07c2                	slli	a5,a5,0x10
    3266:	8fd5                	or	a5,a5,a3
    3268:	86a2                	mv	a3,s0
    326a:	00e7fc63          	bgeu	a5,a4,3282 <__divdf3+0x352>
    326e:	97b2                	add	a5,a5,a2
    3270:	fff40693          	addi	a3,s0,-1 # ffff <__erodata+0xaf57>
    3274:	00c7e763          	bltu	a5,a2,3282 <__divdf3+0x352>
    3278:	00e7f563          	bgeu	a5,a4,3282 <__divdf3+0x352>
    327c:	ffe40693          	addi	a3,s0,-2
    3280:	97b2                	add	a5,a5,a2
    3282:	40e78733          	sub	a4,a5,a4
    3286:	02975333          	divu	t1,a4,s1
    328a:	01061793          	slli	a5,a2,0x10
    328e:	83c1                	srli	a5,a5,0x10
    3290:	02678533          	mul	a0,a5,t1
    3294:	841a                	mv	s0,t1
    3296:	029777b3          	remu	a5,a4,s1
    329a:	01029713          	slli	a4,t0,0x10
    329e:	8341                	srli	a4,a4,0x10
    32a0:	07c2                	slli	a5,a5,0x10
    32a2:	8fd9                	or	a5,a5,a4
    32a4:	00a7fc63          	bgeu	a5,a0,32bc <__divdf3+0x38c>
    32a8:	97b2                	add	a5,a5,a2
    32aa:	fff30413          	addi	s0,t1,-1
    32ae:	00c7e763          	bltu	a5,a2,32bc <__divdf3+0x38c>
    32b2:	00a7f563          	bgeu	a5,a0,32bc <__divdf3+0x38c>
    32b6:	ffe30413          	addi	s0,t1,-2
    32ba:	97b2                	add	a5,a5,a2
    32bc:	06c2                	slli	a3,a3,0x10
    32be:	8ec1                	or	a3,a3,s0
    32c0:	4422                	lw	s0,8(sp)
    32c2:	8f89                	sub	a5,a5,a0
    32c4:	4522                	lw	a0,8(sp)
    32c6:	0106d293          	srli	t0,a3,0x10
    32ca:	01069713          	slli	a4,a3,0x10
    32ce:	02828333          	mul	t1,t0,s0
    32d2:	8341                	srli	a4,a4,0x10
    32d4:	0105d413          	srli	s0,a1,0x10
    32d8:	02a70533          	mul	a0,a4,a0
    32dc:	02e40733          	mul	a4,s0,a4
    32e0:	025402b3          	mul	t0,s0,t0
    32e4:	971a                	add	a4,a4,t1
    32e6:	01055413          	srli	s0,a0,0x10
    32ea:	9722                	add	a4,a4,s0
    32ec:	00677463          	bgeu	a4,t1,32f4 <__divdf3+0x3c4>
    32f0:	6341                	lui	t1,0x10
    32f2:	929a                	add	t0,t0,t1
    32f4:	01075313          	srli	t1,a4,0x10
    32f8:	929a                	add	t0,t0,t1
    32fa:	6341                	lui	t1,0x10
    32fc:	137d                	addi	t1,t1,-1
    32fe:	00677733          	and	a4,a4,t1
    3302:	0742                	slli	a4,a4,0x10
    3304:	00657533          	and	a0,a0,t1
    3308:	953a                	add	a0,a0,a4
    330a:	0057e663          	bltu	a5,t0,3316 <__divdf3+0x3e6>
    330e:	1a579663          	bne	a5,t0,34ba <__divdf3+0x58a>
    3312:	8736                	mv	a4,a3
    3314:	c91d                	beqz	a0,334a <__divdf3+0x41a>
    3316:	97b2                	add	a5,a5,a2
    3318:	fff68713          	addi	a4,a3,-1
    331c:	02c7e163          	bltu	a5,a2,333e <__divdf3+0x40e>
    3320:	0057e663          	bltu	a5,t0,332c <__divdf3+0x3fc>
    3324:	18579a63          	bne	a5,t0,34b8 <__divdf3+0x588>
    3328:	00a5fd63          	bgeu	a1,a0,3342 <__divdf3+0x412>
    332c:	ffe68713          	addi	a4,a3,-2
    3330:	00159693          	slli	a3,a1,0x1
    3334:	00b6b5b3          	sltu	a1,a3,a1
    3338:	962e                	add	a2,a2,a1
    333a:	97b2                	add	a5,a5,a2
    333c:	85b6                	mv	a1,a3
    333e:	00579463          	bne	a5,t0,3346 <__divdf3+0x416>
    3342:	00b50463          	beq	a0,a1,334a <__divdf3+0x41a>
    3346:	00176713          	ori	a4,a4,1
  FP_PACK_D (r, R);
    334a:	4792                	lw	a5,4(sp)
    334c:	3ff78793          	addi	a5,a5,1023 # 8003ff <__erodata+0x7fb357>
    3350:	0af05e63          	blez	a5,340c <__divdf3+0x4dc>
    3354:	00777693          	andi	a3,a4,7
    3358:	ce81                	beqz	a3,3370 <__divdf3+0x440>
    335a:	00f77693          	andi	a3,a4,15
    335e:	4611                	li	a2,4
    3360:	00c68863          	beq	a3,a2,3370 <__divdf3+0x440>
    3364:	00470693          	addi	a3,a4,4 # ff800004 <MTIME_HI_ADDR+0x1f7f4008>
    3368:	00e6b733          	sltu	a4,a3,a4
    336c:	93ba                	add	t2,t2,a4
    336e:	8736                	mv	a4,a3
    3370:	010006b7          	lui	a3,0x1000
    3374:	00d3f6b3          	and	a3,t2,a3
    3378:	ca89                	beqz	a3,338a <__divdf3+0x45a>
    337a:	ff0007b7          	lui	a5,0xff000
    337e:	17fd                	addi	a5,a5,-1
    3380:	00f3f3b3          	and	t2,t2,a5
    3384:	4792                	lw	a5,4(sp)
    3386:	40078793          	addi	a5,a5,1024 # ff000400 <MTIME_HI_ADDR+0x1eff4404>
    338a:	7fe00693          	li	a3,2046
    338e:	06f6c163          	blt	a3,a5,33f0 <__divdf3+0x4c0>
    3392:	01d39693          	slli	a3,t2,0x1d
    3396:	830d                	srli	a4,a4,0x3
    3398:	8f55                	or	a4,a4,a3
    339a:	0033d393          	srli	t2,t2,0x3
    339e:	7ff006b7          	lui	a3,0x7ff00
    33a2:	07d2                	slli	a5,a5,0x14
    33a4:	8ff5                	and	a5,a5,a3
    33a6:	4682                	lw	a3,0(sp)
    33a8:	03b2                	slli	t2,t2,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    33aa:	5082                	lw	ra,32(sp)
    33ac:	4472                	lw	s0,28(sp)
  FP_PACK_D (r, R);
    33ae:	00c3d393          	srli	t2,t2,0xc
    33b2:	01f69593          	slli	a1,a3,0x1f
    33b6:	0077e7b3          	or	a5,a5,t2
    33ba:	00b7e6b3          	or	a3,a5,a1
}
    33be:	44e2                	lw	s1,24(sp)
    33c0:	853a                	mv	a0,a4
    33c2:	85b6                	mv	a1,a3
    33c4:	02410113          	addi	sp,sp,36
    33c8:	8082                	ret
  FP_DIV_D (R, A, B);
    33ca:	4692                	lw	a3,4(sp)
    33cc:	4501                	li	a0,0
    33ce:	16fd                	addi	a3,a3,-1
    33d0:	c236                	sw	a3,4(sp)
    33d2:	b3b9                	j	3120 <__divdf3+0x1f0>
  FP_UNPACK_D (A, a);
    33d4:	4722                	lw	a4,8(sp)
  FP_DIV_D (R, A, B);
    33d6:	83a2                	mv	t2,s0
    33d8:	869a                	mv	a3,t1
  FP_UNPACK_D (A, a);
    33da:	c03a                	sw	a4,0(sp)
  FP_DIV_D (R, A, B);
    33dc:	873e                	mv	a4,a5
  FP_PACK_D (r, R);
    33de:	478d                	li	a5,3
    33e0:	0af68e63          	beq	a3,a5,349c <__divdf3+0x56c>
    33e4:	4785                	li	a5,1
    33e6:	0cf68263          	beq	a3,a5,34aa <__divdf3+0x57a>
    33ea:	4789                	li	a5,2
    33ec:	f4f69fe3          	bne	a3,a5,334a <__divdf3+0x41a>
    33f0:	4381                	li	t2,0
    33f2:	4701                	li	a4,0
    33f4:	7ff00793          	li	a5,2047
    33f8:	b75d                	j	339e <__divdf3+0x46e>
  FP_UNPACK_D (B, b);
    33fa:	47b2                	lw	a5,12(sp)
    33fc:	c03e                	sw	a5,0(sp)
  FP_DIV_D (R, A, B);
    33fe:	b7c5                	j	33de <__divdf3+0x4ae>
    3400:	000803b7          	lui	t2,0x80
    3404:	4701                	li	a4,0
    3406:	c002                	sw	zero,0(sp)
    3408:	468d                	li	a3,3
    340a:	bfd1                	j	33de <__divdf3+0x4ae>
  FP_PACK_D (r, R);
    340c:	4685                	li	a3,1
    340e:	8e9d                	sub	a3,a3,a5
    3410:	03800613          	li	a2,56
    3414:	08d64b63          	blt	a2,a3,34aa <__divdf3+0x57a>
    3418:	467d                	li	a2,31
    341a:	04d64c63          	blt	a2,a3,3472 <__divdf3+0x542>
    341e:	4792                	lw	a5,4(sp)
    3420:	00d75633          	srl	a2,a4,a3
    3424:	41e78593          	addi	a1,a5,1054
    3428:	00b397b3          	sll	a5,t2,a1
    342c:	00b71733          	sll	a4,a4,a1
    3430:	8fd1                	or	a5,a5,a2
    3432:	00e03733          	snez	a4,a4
    3436:	8f5d                	or	a4,a4,a5
    3438:	00d3d3b3          	srl	t2,t2,a3
    343c:	00777793          	andi	a5,a4,7
    3440:	cf81                	beqz	a5,3458 <__divdf3+0x528>
    3442:	00f77793          	andi	a5,a4,15
    3446:	4691                	li	a3,4
    3448:	00d78863          	beq	a5,a3,3458 <__divdf3+0x528>
    344c:	00470693          	addi	a3,a4,4
    3450:	00e6b733          	sltu	a4,a3,a4
    3454:	93ba                	add	t2,t2,a4
    3456:	8736                	mv	a4,a3
    3458:	008007b7          	lui	a5,0x800
    345c:	00f3f7b3          	and	a5,t2,a5
    3460:	eba1                	bnez	a5,34b0 <__divdf3+0x580>
    3462:	01d39793          	slli	a5,t2,0x1d
    3466:	830d                	srli	a4,a4,0x3
    3468:	8f5d                	or	a4,a4,a5
    346a:	0033d393          	srli	t2,t2,0x3
    346e:	4781                	li	a5,0
    3470:	b73d                	j	339e <__divdf3+0x46e>
    3472:	5605                	li	a2,-31
    3474:	40f607b3          	sub	a5,a2,a5
    3478:	02000613          	li	a2,32
    347c:	00f3d7b3          	srl	a5,t2,a5
    3480:	4581                	li	a1,0
    3482:	00c68763          	beq	a3,a2,3490 <__divdf3+0x560>
    3486:	4692                	lw	a3,4(sp)
    3488:	43e68593          	addi	a1,a3,1086 # 7ff0043e <__kernel_stack+0x5fef043e>
    348c:	00b395b3          	sll	a1,t2,a1
    3490:	8f4d                	or	a4,a4,a1
    3492:	00e03733          	snez	a4,a4
    3496:	8f5d                	or	a4,a4,a5
    3498:	4381                	li	t2,0
    349a:	b74d                	j	343c <__divdf3+0x50c>
    349c:	000803b7          	lui	t2,0x80
    34a0:	4701                	li	a4,0
    34a2:	7ff00793          	li	a5,2047
    34a6:	c002                	sw	zero,0(sp)
    34a8:	bddd                	j	339e <__divdf3+0x46e>
    34aa:	4381                	li	t2,0
    34ac:	4701                	li	a4,0
    34ae:	b7c1                	j	346e <__divdf3+0x53e>
    34b0:	4381                	li	t2,0
    34b2:	4701                	li	a4,0
    34b4:	4785                	li	a5,1
    34b6:	b5e5                	j	339e <__divdf3+0x46e>
  FP_DIV_D (R, A, B);
    34b8:	86ba                	mv	a3,a4
    34ba:	8736                	mv	a4,a3
    34bc:	b569                	j	3346 <__divdf3+0x416>

000034be <__eqdf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    34be:	001007b7          	lui	a5,0x100
    34c2:	17fd                	addi	a5,a5,-1
{
    34c4:	1151                	addi	sp,sp,-12
  FP_UNPACK_RAW_D (A, a);
    34c6:	00b7f2b3          	and	t0,a5,a1
    34ca:	0145d713          	srli	a4,a1,0x14
    34ce:	81fd                	srli	a1,a1,0x1f
{
    34d0:	c422                	sw	s0,8(sp)
    34d2:	c226                	sw	s1,4(sp)
    34d4:	832a                	mv	t1,a0
    34d6:	842a                	mv	s0,a0
  FP_UNPACK_RAW_D (A, a);
    34d8:	c02e                	sw	a1,0(sp)
    34da:	7ff77713          	andi	a4,a4,2047
  FP_UNPACK_RAW_D (B, b);
    34de:	0146d593          	srli	a1,a3,0x14
  FP_CMP_EQ_D (r, A, B, 1);
    34e2:	7ff00513          	li	a0,2047
  FP_UNPACK_RAW_D (B, b);
    34e6:	8ff5                	and	a5,a5,a3
    34e8:	84b2                	mv	s1,a2
    34ea:	7ff5f593          	andi	a1,a1,2047
    34ee:	82fd                	srli	a3,a3,0x1f
  FP_CMP_EQ_D (r, A, B, 1);
    34f0:	00a71a63          	bne	a4,a0,3504 <__eqdf2+0x46>
    34f4:	0062e3b3          	or	t2,t0,t1
    34f8:	4505                	li	a0,1
    34fa:	02039963          	bnez	t2,352c <__eqdf2+0x6e>
    34fe:	02e59763          	bne	a1,a4,352c <__eqdf2+0x6e>
    3502:	a019                	j	3508 <__eqdf2+0x4a>
    3504:	00a59563          	bne	a1,a0,350e <__eqdf2+0x50>
    3508:	8e5d                	or	a2,a2,a5
    350a:	4505                	li	a0,1
    350c:	e205                	bnez	a2,352c <__eqdf2+0x6e>
    350e:	4505                	li	a0,1
    3510:	00b71e63          	bne	a4,a1,352c <__eqdf2+0x6e>
    3514:	00f29c63          	bne	t0,a5,352c <__eqdf2+0x6e>
    3518:	00941a63          	bne	s0,s1,352c <__eqdf2+0x6e>
    351c:	4782                	lw	a5,0(sp)
    351e:	00d78b63          	beq	a5,a3,3534 <__eqdf2+0x76>
    3522:	e709                	bnez	a4,352c <__eqdf2+0x6e>
    3524:	0062e533          	or	a0,t0,t1
    3528:	00a03533          	snez	a0,a0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    352c:	4422                	lw	s0,8(sp)
    352e:	4492                	lw	s1,4(sp)
    3530:	0131                	addi	sp,sp,12
    3532:	8082                	ret
  FP_CMP_EQ_D (r, A, B, 1);
    3534:	4501                	li	a0,0
    3536:	bfdd                	j	352c <__eqdf2+0x6e>

00003538 <__gedf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    3538:	00100737          	lui	a4,0x100
{
    353c:	1161                	addi	sp,sp,-8
  FP_UNPACK_RAW_D (A, a);
    353e:	177d                	addi	a4,a4,-1
    3540:	0145d313          	srli	t1,a1,0x14
    3544:	00b772b3          	and	t0,a4,a1
{
    3548:	c222                	sw	s0,4(sp)
    354a:	c026                	sw	s1,0(sp)
    354c:	87aa                	mv	a5,a0
    354e:	83aa                	mv	t2,a0
  FP_UNPACK_RAW_D (A, a);
    3550:	7ff37313          	andi	t1,t1,2047
    3554:	01f5d513          	srli	a0,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
  FP_CMP_D (r, A, B, -2, 2);
    3558:	7ff00493          	li	s1,2047
  FP_UNPACK_RAW_D (B, b);
    355c:	0146d593          	srli	a1,a3,0x14
    3560:	8f75                	and	a4,a4,a3
    3562:	8432                	mv	s0,a2
    3564:	7ff5f593          	andi	a1,a1,2047
    3568:	82fd                	srli	a3,a3,0x1f
  FP_CMP_D (r, A, B, -2, 2);
    356a:	00931763          	bne	t1,s1,3578 <__gedf2+0x40>
    356e:	00f2e4b3          	or	s1,t0,a5
    3572:	c4ad                	beqz	s1,35dc <__gedf2+0xa4>
    3574:	5579                	li	a0,-2
    3576:	a815                	j	35aa <__gedf2+0x72>
    3578:	00959563          	bne	a1,s1,3582 <__gedf2+0x4a>
    357c:	00c764b3          	or	s1,a4,a2
    3580:	f8f5                	bnez	s1,3574 <__gedf2+0x3c>
    3582:	04031f63          	bnez	t1,35e0 <__gedf2+0xa8>
    3586:	00f2e7b3          	or	a5,t0,a5
    358a:	0017b793          	seqz	a5,a5
    358e:	e199                	bnez	a1,3594 <__gedf2+0x5c>
    3590:	8e59                	or	a2,a2,a4
    3592:	c221                	beqz	a2,35d2 <__gedf2+0x9a>
    3594:	eb81                	bnez	a5,35a4 <__gedf2+0x6c>
    3596:	00d51463          	bne	a0,a3,359e <__gedf2+0x66>
    359a:	0065dc63          	bge	a1,t1,35b2 <__gedf2+0x7a>
    359e:	c905                	beqz	a0,35ce <__gedf2+0x96>
    35a0:	557d                	li	a0,-1
    35a2:	a021                	j	35aa <__gedf2+0x72>
    35a4:	557d                	li	a0,-1
    35a6:	c291                	beqz	a3,35aa <__gedf2+0x72>
    35a8:	8536                	mv	a0,a3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    35aa:	4412                	lw	s0,4(sp)
    35ac:	4482                	lw	s1,0(sp)
    35ae:	0121                	addi	sp,sp,8
    35b0:	8082                	ret
  FP_CMP_D (r, A, B, -2, 2);
    35b2:	00b35463          	bge	t1,a1,35ba <__gedf2+0x82>
    35b6:	f975                	bnez	a0,35aa <__gedf2+0x72>
    35b8:	b7e5                	j	35a0 <__gedf2+0x68>
    35ba:	fe5762e3          	bltu	a4,t0,359e <__gedf2+0x66>
    35be:	00e29c63          	bne	t0,a4,35d6 <__gedf2+0x9e>
    35c2:	fc746ee3          	bltu	s0,t2,359e <__gedf2+0x66>
    35c6:	fe83e8e3          	bltu	t2,s0,35b6 <__gedf2+0x7e>
    35ca:	4501                	li	a0,0
    35cc:	bff9                	j	35aa <__gedf2+0x72>
    35ce:	4505                	li	a0,1
    35d0:	bfe9                	j	35aa <__gedf2+0x72>
    35d2:	ffe5                	bnez	a5,35ca <__gedf2+0x92>
    35d4:	b7e9                	j	359e <__gedf2+0x66>
    35d6:	fee2e0e3          	bltu	t0,a4,35b6 <__gedf2+0x7e>
    35da:	bfc5                	j	35ca <__gedf2+0x92>
    35dc:	fa6580e3          	beq	a1,t1,357c <__gedf2+0x44>
    35e0:	f9dd                	bnez	a1,3596 <__gedf2+0x5e>
    35e2:	4781                	li	a5,0
    35e4:	b775                	j	3590 <__gedf2+0x58>

000035e6 <__ledf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    35e6:	00100737          	lui	a4,0x100
{
    35ea:	1161                	addi	sp,sp,-8
  FP_UNPACK_RAW_D (A, a);
    35ec:	177d                	addi	a4,a4,-1
    35ee:	0145d313          	srli	t1,a1,0x14
    35f2:	00b772b3          	and	t0,a4,a1
{
    35f6:	c222                	sw	s0,4(sp)
    35f8:	c026                	sw	s1,0(sp)
    35fa:	87aa                	mv	a5,a0
    35fc:	83aa                	mv	t2,a0
  FP_UNPACK_RAW_D (A, a);
    35fe:	7ff37313          	andi	t1,t1,2047
    3602:	01f5d513          	srli	a0,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
  FP_CMP_D (r, A, B, 2, 2);
    3606:	7ff00493          	li	s1,2047
  FP_UNPACK_RAW_D (B, b);
    360a:	0146d593          	srli	a1,a3,0x14
    360e:	8f75                	and	a4,a4,a3
    3610:	8432                	mv	s0,a2
    3612:	7ff5f593          	andi	a1,a1,2047
    3616:	82fd                	srli	a3,a3,0x1f
  FP_CMP_D (r, A, B, 2, 2);
    3618:	00931763          	bne	t1,s1,3626 <__ledf2+0x40>
    361c:	00f2e4b3          	or	s1,t0,a5
    3620:	c4ad                	beqz	s1,368a <__ledf2+0xa4>
    3622:	4509                	li	a0,2
    3624:	a815                	j	3658 <__ledf2+0x72>
    3626:	00959563          	bne	a1,s1,3630 <__ledf2+0x4a>
    362a:	00c764b3          	or	s1,a4,a2
    362e:	f8f5                	bnez	s1,3622 <__ledf2+0x3c>
    3630:	04031f63          	bnez	t1,368e <__ledf2+0xa8>
    3634:	00f2e7b3          	or	a5,t0,a5
    3638:	0017b793          	seqz	a5,a5
    363c:	e199                	bnez	a1,3642 <__ledf2+0x5c>
    363e:	8e59                	or	a2,a2,a4
    3640:	c221                	beqz	a2,3680 <__ledf2+0x9a>
    3642:	eb81                	bnez	a5,3652 <__ledf2+0x6c>
    3644:	00d51463          	bne	a0,a3,364c <__ledf2+0x66>
    3648:	0065dc63          	bge	a1,t1,3660 <__ledf2+0x7a>
    364c:	c905                	beqz	a0,367c <__ledf2+0x96>
    364e:	557d                	li	a0,-1
    3650:	a021                	j	3658 <__ledf2+0x72>
    3652:	557d                	li	a0,-1
    3654:	c291                	beqz	a3,3658 <__ledf2+0x72>
    3656:	8536                	mv	a0,a3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    3658:	4412                	lw	s0,4(sp)
    365a:	4482                	lw	s1,0(sp)
    365c:	0121                	addi	sp,sp,8
    365e:	8082                	ret
  FP_CMP_D (r, A, B, 2, 2);
    3660:	00b35463          	bge	t1,a1,3668 <__ledf2+0x82>
    3664:	f975                	bnez	a0,3658 <__ledf2+0x72>
    3666:	b7e5                	j	364e <__ledf2+0x68>
    3668:	fe5762e3          	bltu	a4,t0,364c <__ledf2+0x66>
    366c:	00e29c63          	bne	t0,a4,3684 <__ledf2+0x9e>
    3670:	fc746ee3          	bltu	s0,t2,364c <__ledf2+0x66>
    3674:	fe83e8e3          	bltu	t2,s0,3664 <__ledf2+0x7e>
    3678:	4501                	li	a0,0
    367a:	bff9                	j	3658 <__ledf2+0x72>
    367c:	4505                	li	a0,1
    367e:	bfe9                	j	3658 <__ledf2+0x72>
    3680:	ffe5                	bnez	a5,3678 <__ledf2+0x92>
    3682:	b7e9                	j	364c <__ledf2+0x66>
    3684:	fee2e0e3          	bltu	t0,a4,3664 <__ledf2+0x7e>
    3688:	bfc5                	j	3678 <__ledf2+0x92>
    368a:	fa6580e3          	beq	a1,t1,362a <__ledf2+0x44>
    368e:	f9dd                	bnez	a1,3644 <__ledf2+0x5e>
    3690:	4781                	li	a5,0
    3692:	b775                	j	363e <__ledf2+0x58>

00003694 <__muldf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__muldf3 (DFtype a, DFtype b)
{
    3694:	fd810113          	addi	sp,sp,-40
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
    3698:	00c59793          	slli	a5,a1,0xc
{
    369c:	ce26                	sw	s1,28(sp)
  FP_UNPACK_D (A, a);
    369e:	0145d313          	srli	t1,a1,0x14
    36a2:	00c7d493          	srli	s1,a5,0xc
    36a6:	01f5d793          	srli	a5,a1,0x1f
{
    36aa:	d022                	sw	s0,32(sp)
    36ac:	d206                	sw	ra,36(sp)
  FP_UNPACK_D (A, a);
    36ae:	7ff37313          	andi	t1,t1,2047
    36b2:	c43e                	sw	a5,8(sp)
{
    36b4:	842a                	mv	s0,a0
  FP_UNPACK_D (A, a);
    36b6:	08030763          	beqz	t1,3744 <__muldf3+0xb0>
    36ba:	7ff00793          	li	a5,2047
    36be:	0ef30163          	beq	t1,a5,37a0 <__muldf3+0x10c>
    36c2:	00349713          	slli	a4,s1,0x3
    36c6:	01d55793          	srli	a5,a0,0x1d
    36ca:	8fd9                	or	a5,a5,a4
    36cc:	00800737          	lui	a4,0x800
    36d0:	00e7e4b3          	or	s1,a5,a4
    36d4:	00351593          	slli	a1,a0,0x3
    36d8:	c0130313          	addi	t1,t1,-1023 # fc01 <__erodata+0xab59>
    36dc:	4401                	li	s0,0
  FP_UNPACK_D (B, b);
    36de:	0146d513          	srli	a0,a3,0x14
    36e2:	01f6d713          	srli	a4,a3,0x1f
    36e6:	00c69793          	slli	a5,a3,0xc
    36ea:	7ff57513          	andi	a0,a0,2047
    36ee:	c63a                	sw	a4,12(sp)
    36f0:	83b1                	srli	a5,a5,0xc
    36f2:	c961                	beqz	a0,37c2 <__muldf3+0x12e>
    36f4:	7ff00713          	li	a4,2047
    36f8:	12e50e63          	beq	a0,a4,3834 <__muldf3+0x1a0>
    36fc:	01d65713          	srli	a4,a2,0x1d
    3700:	078e                	slli	a5,a5,0x3
    3702:	8fd9                	or	a5,a5,a4
    3704:	00800737          	lui	a4,0x800
    3708:	8fd9                	or	a5,a5,a4
    370a:	00361693          	slli	a3,a2,0x3
    370e:	c0150513          	addi	a0,a0,-1023
    3712:	4701                	li	a4,0
  FP_MUL_D (R, A, B);
    3714:	4622                	lw	a2,8(sp)
    3716:	42b2                	lw	t0,12(sp)
    3718:	00564633          	xor	a2,a2,t0
    371c:	c032                	sw	a2,0(sp)
    371e:	00a30633          	add	a2,t1,a0
    3722:	c832                	sw	a2,16(sp)
    3724:	0605                	addi	a2,a2,1
    3726:	c232                	sw	a2,4(sp)
    3728:	00241613          	slli	a2,s0,0x2
    372c:	8e59                	or	a2,a2,a4
    372e:	167d                	addi	a2,a2,-1
    3730:	4539                	li	a0,14
    3732:	12c56263          	bltu	a0,a2,3856 <__muldf3+0x1c2>
    3736:	6515                	lui	a0,0x5
    3738:	060a                	slli	a2,a2,0x2
    373a:	f6c50513          	addi	a0,a0,-148 # 4f6c <_ctype_+0xa7c>
    373e:	962a                	add	a2,a2,a0
    3740:	4210                	lw	a2,0(a2)
    3742:	8602                	jr	a2
  FP_UNPACK_D (A, a);
    3744:	00a4e5b3          	or	a1,s1,a0
    3748:	c5a5                	beqz	a1,37b0 <__muldf3+0x11c>
    374a:	c236                	sw	a3,4(sp)
    374c:	c032                	sw	a2,0(sp)
    374e:	cc85                	beqz	s1,3786 <__muldf3+0xf2>
    3750:	8526                	mv	a0,s1
    3752:	297000ef          	jal	ra,41e8 <__clzsi2>
    3756:	4602                	lw	a2,0(sp)
    3758:	4692                	lw	a3,4(sp)
    375a:	ff550713          	addi	a4,a0,-11
    375e:	47f1                	li	a5,28
    3760:	02e7ca63          	blt	a5,a4,3794 <__muldf3+0x100>
    3764:	47f5                	li	a5,29
    3766:	ff850593          	addi	a1,a0,-8
    376a:	8f99                	sub	a5,a5,a4
    376c:	00b49333          	sll	t1,s1,a1
    3770:	00f457b3          	srl	a5,s0,a5
    3774:	0067e4b3          	or	s1,a5,t1
    3778:	00b415b3          	sll	a1,s0,a1
    377c:	c0d00313          	li	t1,-1011
    3780:	40a30333          	sub	t1,t1,a0
    3784:	bfa1                	j	36dc <__muldf3+0x48>
    3786:	263000ef          	jal	ra,41e8 <__clzsi2>
    378a:	4692                	lw	a3,4(sp)
    378c:	4602                	lw	a2,0(sp)
    378e:	02050513          	addi	a0,a0,32
    3792:	b7e1                	j	375a <__muldf3+0xc6>
    3794:	fd850793          	addi	a5,a0,-40
    3798:	00f414b3          	sll	s1,s0,a5
    379c:	4581                	li	a1,0
    379e:	bff9                	j	377c <__muldf3+0xe8>
    37a0:	00a4e5b3          	or	a1,s1,a0
    37a4:	c991                	beqz	a1,37b8 <__muldf3+0x124>
    37a6:	85aa                	mv	a1,a0
    37a8:	7ff00313          	li	t1,2047
    37ac:	440d                	li	s0,3
    37ae:	bf05                	j	36de <__muldf3+0x4a>
    37b0:	4481                	li	s1,0
    37b2:	4301                	li	t1,0
    37b4:	4405                	li	s0,1
    37b6:	b725                	j	36de <__muldf3+0x4a>
    37b8:	4481                	li	s1,0
    37ba:	7ff00313          	li	t1,2047
    37be:	4409                	li	s0,2
    37c0:	bf39                	j	36de <__muldf3+0x4a>
  FP_UNPACK_D (B, b);
    37c2:	00c7e6b3          	or	a3,a5,a2
    37c6:	cebd                	beqz	a3,3844 <__muldf3+0x1b0>
    37c8:	c3b1                	beqz	a5,380c <__muldf3+0x178>
    37ca:	853e                	mv	a0,a5
    37cc:	ca32                	sw	a2,20(sp)
    37ce:	c82e                	sw	a1,16(sp)
    37d0:	c21a                	sw	t1,4(sp)
    37d2:	c03e                	sw	a5,0(sp)
    37d4:	215000ef          	jal	ra,41e8 <__clzsi2>
    37d8:	4782                	lw	a5,0(sp)
    37da:	4312                	lw	t1,4(sp)
    37dc:	45c2                	lw	a1,16(sp)
    37de:	4652                	lw	a2,20(sp)
    37e0:	ff550393          	addi	t2,a0,-11
    37e4:	4771                	li	a4,28
    37e6:	04774163          	blt	a4,t2,3828 <__muldf3+0x194>
    37ea:	4775                	li	a4,29
    37ec:	ff850693          	addi	a3,a0,-8
    37f0:	40770733          	sub	a4,a4,t2
    37f4:	00d797b3          	sll	a5,a5,a3
    37f8:	00e65733          	srl	a4,a2,a4
    37fc:	8fd9                	or	a5,a5,a4
    37fe:	00d616b3          	sll	a3,a2,a3
    3802:	c0d00713          	li	a4,-1011
    3806:	40a70533          	sub	a0,a4,a0
    380a:	b721                	j	3712 <__muldf3+0x7e>
    380c:	8532                	mv	a0,a2
    380e:	ca3e                	sw	a5,20(sp)
    3810:	c82e                	sw	a1,16(sp)
    3812:	c21a                	sw	t1,4(sp)
    3814:	c032                	sw	a2,0(sp)
    3816:	1d3000ef          	jal	ra,41e8 <__clzsi2>
    381a:	47d2                	lw	a5,20(sp)
    381c:	45c2                	lw	a1,16(sp)
    381e:	4312                	lw	t1,4(sp)
    3820:	4602                	lw	a2,0(sp)
    3822:	02050513          	addi	a0,a0,32
    3826:	bf6d                	j	37e0 <__muldf3+0x14c>
    3828:	fd850793          	addi	a5,a0,-40
    382c:	00f617b3          	sll	a5,a2,a5
    3830:	4681                	li	a3,0
    3832:	bfc1                	j	3802 <__muldf3+0x16e>
    3834:	00c7e6b3          	or	a3,a5,a2
    3838:	ca91                	beqz	a3,384c <__muldf3+0x1b8>
    383a:	86b2                	mv	a3,a2
    383c:	7ff00513          	li	a0,2047
    3840:	470d                	li	a4,3
    3842:	bdc9                	j	3714 <__muldf3+0x80>
    3844:	4781                	li	a5,0
    3846:	4501                	li	a0,0
    3848:	4705                	li	a4,1
    384a:	b5e9                	j	3714 <__muldf3+0x80>
    384c:	4781                	li	a5,0
    384e:	7ff00513          	li	a0,2047
    3852:	4709                	li	a4,2
    3854:	b5c1                	j	3714 <__muldf3+0x80>
  FP_MUL_D (R, A, B);
    3856:	0105d513          	srli	a0,a1,0x10
    385a:	0106d413          	srli	s0,a3,0x10
    385e:	02850633          	mul	a2,a0,s0
    3862:	6741                	lui	a4,0x10
    3864:	177d                	addi	a4,a4,-1
    3866:	8df9                	and	a1,a1,a4
    3868:	8ef9                	and	a3,a3,a4
    386a:	02d503b3          	mul	t2,a0,a3
    386e:	c432                	sw	a2,8(sp)
    3870:	02b40633          	mul	a2,s0,a1
    3874:	02d58333          	mul	t1,a1,a3
    3878:	961e                	add	a2,a2,t2
    387a:	82b2                	mv	t0,a2
    387c:	01035613          	srli	a2,t1,0x10
    3880:	9616                	add	a2,a2,t0
    3882:	00767763          	bgeu	a2,t2,3890 <__muldf3+0x1fc>
    3886:	028503b3          	mul	t2,a0,s0
    388a:	62c1                	lui	t0,0x10
    388c:	929e                	add	t0,t0,t2
    388e:	c416                	sw	t0,8(sp)
    3890:	01065293          	srli	t0,a2,0x10
    3894:	8e79                	and	a2,a2,a4
    3896:	00e37333          	and	t1,t1,a4
    389a:	0642                	slli	a2,a2,0x10
    389c:	961a                	add	a2,a2,t1
    389e:	8f7d                	and	a4,a4,a5
    38a0:	ca32                	sw	a2,20(sp)
    38a2:	0107d613          	srli	a2,a5,0x10
    38a6:	02e50333          	mul	t1,a0,a4
    38aa:	02e587b3          	mul	a5,a1,a4
    38ae:	02b605b3          	mul	a1,a2,a1
    38b2:	0107d393          	srli	t2,a5,0x10
    38b6:	959a                	add	a1,a1,t1
    38b8:	959e                	add	a1,a1,t2
    38ba:	02c50533          	mul	a0,a0,a2
    38be:	0065f463          	bgeu	a1,t1,38c6 <__muldf3+0x232>
    38c2:	6341                	lui	t1,0x10
    38c4:	951a                	add	a0,a0,t1
    38c6:	0105d313          	srli	t1,a1,0x10
    38ca:	951a                	add	a0,a0,t1
    38cc:	c62a                	sw	a0,12(sp)
    38ce:	6541                	lui	a0,0x10
    38d0:	fff50313          	addi	t1,a0,-1 # ffff <__erodata+0xaf57>
    38d4:	0065f5b3          	and	a1,a1,t1
    38d8:	0067f7b3          	and	a5,a5,t1
    38dc:	05c2                	slli	a1,a1,0x10
    38de:	95be                	add	a1,a1,a5
    38e0:	00b287b3          	add	a5,t0,a1
    38e4:	0064f333          	and	t1,s1,t1
    38e8:	0104d293          	srli	t0,s1,0x10
    38ec:	cc3e                	sw	a5,24(sp)
    38ee:	026404b3          	mul	s1,s0,t1
    38f2:	026687b3          	mul	a5,a3,t1
    38f6:	02d286b3          	mul	a3,t0,a3
    38fa:	025403b3          	mul	t2,s0,t0
    38fe:	94b6                	add	s1,s1,a3
    3900:	0107d413          	srli	s0,a5,0x10
    3904:	94a2                	add	s1,s1,s0
    3906:	00d4f363          	bgeu	s1,a3,390c <__muldf3+0x278>
    390a:	93aa                	add	t2,t2,a0
    390c:	0104d693          	srli	a3,s1,0x10
    3910:	93b6                	add	t2,t2,a3
    3912:	66c1                	lui	a3,0x10
    3914:	fff68513          	addi	a0,a3,-1 # ffff <__erodata+0xaf57>
    3918:	8ce9                	and	s1,s1,a0
    391a:	8fe9                	and	a5,a5,a0
    391c:	02670533          	mul	a0,a4,t1
    3920:	04c2                	slli	s1,s1,0x10
    3922:	94be                	add	s1,s1,a5
    3924:	02e28733          	mul	a4,t0,a4
    3928:	02660333          	mul	t1,a2,t1
    392c:	025602b3          	mul	t0,a2,t0
    3930:	933a                	add	t1,t1,a4
    3932:	01055613          	srli	a2,a0,0x10
    3936:	9332                	add	t1,t1,a2
    3938:	00e37363          	bgeu	t1,a4,393e <__muldf3+0x2aa>
    393c:	92b6                	add	t0,t0,a3
    393e:	47a2                	lw	a5,8(sp)
    3940:	4762                	lw	a4,24(sp)
    3942:	66c1                	lui	a3,0x10
    3944:	16fd                	addi	a3,a3,-1
    3946:	973e                	add	a4,a4,a5
    3948:	00d377b3          	and	a5,t1,a3
    394c:	07c2                	slli	a5,a5,0x10
    394e:	8d75                	and	a0,a0,a3
    3950:	953e                	add	a0,a0,a5
    3952:	47b2                	lw	a5,12(sp)
    3954:	00b735b3          	sltu	a1,a4,a1
    3958:	46b2                	lw	a3,12(sp)
    395a:	953e                	add	a0,a0,a5
    395c:	00b50633          	add	a2,a0,a1
    3960:	9726                	add	a4,a4,s1
    3962:	009737b3          	sltu	a5,a4,s1
    3966:	00760433          	add	s0,a2,t2
    396a:	00f404b3          	add	s1,s0,a5
    396e:	00d53533          	sltu	a0,a0,a3
    3972:	00b635b3          	sltu	a1,a2,a1
    3976:	00f4b7b3          	sltu	a5,s1,a5
    397a:	8dc9                	or	a1,a1,a0
    397c:	01035313          	srli	t1,t1,0x10
    3980:	007433b3          	sltu	t2,s0,t2
    3984:	959a                	add	a1,a1,t1
    3986:	00f3e7b3          	or	a5,t2,a5
    398a:	97ae                	add	a5,a5,a1
    398c:	4652                	lw	a2,20(sp)
    398e:	92be                	add	t0,t0,a5
    3990:	0174d693          	srli	a3,s1,0x17
    3994:	00929793          	slli	a5,t0,0x9
    3998:	8fd5                	or	a5,a5,a3
    399a:	00971693          	slli	a3,a4,0x9
    399e:	8ed1                	or	a3,a3,a2
    39a0:	835d                	srli	a4,a4,0x17
    39a2:	00d036b3          	snez	a3,a3
    39a6:	8ed9                	or	a3,a3,a4
    39a8:	01000737          	lui	a4,0x1000
    39ac:	04a6                	slli	s1,s1,0x9
    39ae:	8f7d                	and	a4,a4,a5
    39b0:	8ec5                	or	a3,a3,s1
    39b2:	c75d                	beqz	a4,3a60 <__muldf3+0x3cc>
    39b4:	0016d713          	srli	a4,a3,0x1
    39b8:	8a85                	andi	a3,a3,1
    39ba:	8ed9                	or	a3,a3,a4
    39bc:	01f79713          	slli	a4,a5,0x1f
    39c0:	8ed9                	or	a3,a3,a4
    39c2:	8385                	srli	a5,a5,0x1
  FP_PACK_D (r, R);
    39c4:	4712                	lw	a4,4(sp)
    39c6:	3ff70713          	addi	a4,a4,1023 # 10003ff <__erodata+0xffb357>
    39ca:	08e05e63          	blez	a4,3a66 <__muldf3+0x3d2>
    39ce:	0076f613          	andi	a2,a3,7
    39d2:	ce01                	beqz	a2,39ea <__muldf3+0x356>
    39d4:	00f6f613          	andi	a2,a3,15
    39d8:	4591                	li	a1,4
    39da:	00b60863          	beq	a2,a1,39ea <__muldf3+0x356>
    39de:	00468613          	addi	a2,a3,4 # 10004 <__erodata+0xaf5c>
    39e2:	00d636b3          	sltu	a3,a2,a3
    39e6:	97b6                	add	a5,a5,a3
    39e8:	86b2                	mv	a3,a2
    39ea:	01000637          	lui	a2,0x1000
    39ee:	8e7d                	and	a2,a2,a5
    39f0:	ca01                	beqz	a2,3a00 <__muldf3+0x36c>
    39f2:	ff000737          	lui	a4,0xff000
    39f6:	177d                	addi	a4,a4,-1
    39f8:	8ff9                	and	a5,a5,a4
    39fa:	4712                	lw	a4,4(sp)
    39fc:	40070713          	addi	a4,a4,1024 # ff000400 <MTIME_HI_ADDR+0x1eff4404>
    3a00:	7fe00613          	li	a2,2046
    3a04:	0ee64e63          	blt	a2,a4,3b00 <__muldf3+0x46c>
    3a08:	01d79613          	slli	a2,a5,0x1d
    3a0c:	828d                	srli	a3,a3,0x3
    3a0e:	8ed1                	or	a3,a3,a2
    3a10:	838d                	srli	a5,a5,0x3
    3a12:	7ff00637          	lui	a2,0x7ff00
    3a16:	0752                	slli	a4,a4,0x14
    3a18:	07b2                	slli	a5,a5,0xc
    3a1a:	8f71                	and	a4,a4,a2
    3a1c:	83b1                	srli	a5,a5,0xc
    3a1e:	8fd9                	or	a5,a5,a4
    3a20:	4702                	lw	a4,0(sp)
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    3a22:	5092                	lw	ra,36(sp)
    3a24:	5402                	lw	s0,32(sp)
  FP_PACK_D (r, R);
    3a26:	077e                	slli	a4,a4,0x1f
    3a28:	00e7e633          	or	a2,a5,a4
}
    3a2c:	44f2                	lw	s1,28(sp)
    3a2e:	8536                	mv	a0,a3
    3a30:	85b2                	mv	a1,a2
    3a32:	02810113          	addi	sp,sp,40
    3a36:	8082                	ret
  FP_UNPACK_D (A, a);
    3a38:	47a2                	lw	a5,8(sp)
    3a3a:	c03e                	sw	a5,0(sp)
  FP_MUL_D (R, A, B);
    3a3c:	87a6                	mv	a5,s1
    3a3e:	86ae                	mv	a3,a1
    3a40:	8722                	mv	a4,s0
  FP_PACK_D (r, R);
    3a42:	4609                	li	a2,2
    3a44:	0ac70e63          	beq	a4,a2,3b00 <__muldf3+0x46c>
    3a48:	460d                	li	a2,3
    3a4a:	0ac70463          	beq	a4,a2,3af2 <__muldf3+0x45e>
    3a4e:	4605                	li	a2,1
    3a50:	f6c71ae3          	bne	a4,a2,39c4 <__muldf3+0x330>
    3a54:	4781                	li	a5,0
    3a56:	4681                	li	a3,0
    3a58:	a0b5                	j	3ac4 <__muldf3+0x430>
  FP_UNPACK_D (B, b);
    3a5a:	4632                	lw	a2,12(sp)
    3a5c:	c032                	sw	a2,0(sp)
  FP_MUL_D (R, A, B);
    3a5e:	b7d5                	j	3a42 <__muldf3+0x3ae>
    3a60:	4742                	lw	a4,16(sp)
    3a62:	c23a                	sw	a4,4(sp)
    3a64:	b785                	j	39c4 <__muldf3+0x330>
  FP_PACK_D (r, R);
    3a66:	4585                	li	a1,1
    3a68:	8d99                	sub	a1,a1,a4
    3a6a:	03800613          	li	a2,56
    3a6e:	feb643e3          	blt	a2,a1,3a54 <__muldf3+0x3c0>
    3a72:	467d                	li	a2,31
    3a74:	04b64a63          	blt	a2,a1,3ac8 <__muldf3+0x434>
    3a78:	4712                	lw	a4,4(sp)
    3a7a:	00b6d533          	srl	a0,a3,a1
    3a7e:	41e70713          	addi	a4,a4,1054
    3a82:	00e79633          	sll	a2,a5,a4
    3a86:	00e696b3          	sll	a3,a3,a4
    3a8a:	8e49                	or	a2,a2,a0
    3a8c:	00d036b3          	snez	a3,a3
    3a90:	8ed1                	or	a3,a3,a2
    3a92:	00b7d7b3          	srl	a5,a5,a1
    3a96:	0076f713          	andi	a4,a3,7
    3a9a:	cf01                	beqz	a4,3ab2 <__muldf3+0x41e>
    3a9c:	00f6f713          	andi	a4,a3,15
    3aa0:	4611                	li	a2,4
    3aa2:	00c70863          	beq	a4,a2,3ab2 <__muldf3+0x41e>
    3aa6:	00468713          	addi	a4,a3,4
    3aaa:	00d736b3          	sltu	a3,a4,a3
    3aae:	97b6                	add	a5,a5,a3
    3ab0:	86ba                	mv	a3,a4
    3ab2:	00800737          	lui	a4,0x800
    3ab6:	8f7d                	and	a4,a4,a5
    3ab8:	eb29                	bnez	a4,3b0a <__muldf3+0x476>
    3aba:	01d79713          	slli	a4,a5,0x1d
    3abe:	828d                	srli	a3,a3,0x3
    3ac0:	8ed9                	or	a3,a3,a4
    3ac2:	838d                	srli	a5,a5,0x3
    3ac4:	4701                	li	a4,0
    3ac6:	b7b1                	j	3a12 <__muldf3+0x37e>
    3ac8:	5605                	li	a2,-31
    3aca:	40e60733          	sub	a4,a2,a4
    3ace:	02000513          	li	a0,32
    3ad2:	00e7d733          	srl	a4,a5,a4
    3ad6:	4601                	li	a2,0
    3ad8:	00a58763          	beq	a1,a0,3ae6 <__muldf3+0x452>
    3adc:	4612                	lw	a2,4(sp)
    3ade:	43e60613          	addi	a2,a2,1086 # 7ff0043e <__kernel_stack+0x5fef043e>
    3ae2:	00c79633          	sll	a2,a5,a2
    3ae6:	8ed1                	or	a3,a3,a2
    3ae8:	00d036b3          	snez	a3,a3
    3aec:	8ed9                	or	a3,a3,a4
    3aee:	4781                	li	a5,0
    3af0:	b75d                	j	3a96 <__muldf3+0x402>
    3af2:	000807b7          	lui	a5,0x80
    3af6:	4681                	li	a3,0
    3af8:	7ff00713          	li	a4,2047
    3afc:	c002                	sw	zero,0(sp)
    3afe:	bf11                	j	3a12 <__muldf3+0x37e>
    3b00:	4781                	li	a5,0
    3b02:	4681                	li	a3,0
    3b04:	7ff00713          	li	a4,2047
    3b08:	b729                	j	3a12 <__muldf3+0x37e>
    3b0a:	4781                	li	a5,0
    3b0c:	4681                	li	a3,0
    3b0e:	4705                	li	a4,1
    3b10:	b709                	j	3a12 <__muldf3+0x37e>

00003b12 <__subdf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
    3b12:	00100337          	lui	t1,0x100
    3b16:	137d                	addi	t1,t1,-1
{
    3b18:	1131                	addi	sp,sp,-20
  FP_UNPACK_SEMIRAW_D (A, a);
    3b1a:	00b377b3          	and	a5,t1,a1
    3b1e:	0145d713          	srli	a4,a1,0x14
{
    3b22:	c426                	sw	s1,8(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
    3b24:	078e                	slli	a5,a5,0x3
    3b26:	7ff77493          	andi	s1,a4,2047
    3b2a:	01d55713          	srli	a4,a0,0x1d
    3b2e:	8fd9                	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
    3b30:	00d37733          	and	a4,t1,a3
{
    3b34:	c622                	sw	s0,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    3b36:	0146d313          	srli	t1,a3,0x14
  FP_UNPACK_SEMIRAW_D (A, a);
    3b3a:	01f5d413          	srli	s0,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
    3b3e:	070e                	slli	a4,a4,0x3
    3b40:	01d65593          	srli	a1,a2,0x1d
    3b44:	8f4d                	or	a4,a4,a1
{
    3b46:	c806                	sw	ra,16(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
    3b48:	7ff37313          	andi	t1,t1,2047
  FP_SUB_D (R, A, B);
    3b4c:	7ff00593          	li	a1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
    3b50:	050e                	slli	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
    3b52:	82fd                	srli	a3,a3,0x1f
    3b54:	060e                	slli	a2,a2,0x3
  FP_SUB_D (R, A, B);
    3b56:	00b31563          	bne	t1,a1,3b60 <__subdf3+0x4e>
    3b5a:	00c765b3          	or	a1,a4,a2
    3b5e:	e199                	bnez	a1,3b64 <__subdf3+0x52>
    3b60:	0016c693          	xori	a3,a3,1
    3b64:	406482b3          	sub	t0,s1,t1
    3b68:	22869563          	bne	a3,s0,3d92 <__subdf3+0x280>
    3b6c:	0e505263          	blez	t0,3c50 <__subdf3+0x13e>
    3b70:	02031863          	bnez	t1,3ba0 <__subdf3+0x8e>
    3b74:	00c766b3          	or	a3,a4,a2
    3b78:	56068f63          	beqz	a3,40f6 <__subdf3+0x5e4>
    3b7c:	fff28593          	addi	a1,t0,-1 # ffff <__erodata+0xaf57>
    3b80:	e989                	bnez	a1,3b92 <__subdf3+0x80>
    3b82:	962a                	add	a2,a2,a0
    3b84:	00a63533          	sltu	a0,a2,a0
    3b88:	97ba                	add	a5,a5,a4
    3b8a:	97aa                	add	a5,a5,a0
    3b8c:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    3b8e:	4485                	li	s1,1
  FP_SUB_D (R, A, B);
    3b90:	a8b9                	j	3bee <__subdf3+0xdc>
    3b92:	7ff00693          	li	a3,2047
    3b96:	00d29d63          	bne	t0,a3,3bb0 <__subdf3+0x9e>
    3b9a:	7ff00493          	li	s1,2047
    3b9e:	aa79                	j	3d3c <__subdf3+0x22a>
    3ba0:	7ff00693          	li	a3,2047
    3ba4:	18d48c63          	beq	s1,a3,3d3c <__subdf3+0x22a>
    3ba8:	008006b7          	lui	a3,0x800
    3bac:	8f55                	or	a4,a4,a3
    3bae:	8596                	mv	a1,t0
    3bb0:	03800693          	li	a3,56
    3bb4:	08b6ca63          	blt	a3,a1,3c48 <__subdf3+0x136>
    3bb8:	46fd                	li	a3,31
    3bba:	06b6c163          	blt	a3,a1,3c1c <__subdf3+0x10a>
    3bbe:	02000313          	li	t1,32
    3bc2:	40b30333          	sub	t1,t1,a1
    3bc6:	006716b3          	sll	a3,a4,t1
    3bca:	00b652b3          	srl	t0,a2,a1
    3bce:	00661633          	sll	a2,a2,t1
    3bd2:	0056e6b3          	or	a3,a3,t0
    3bd6:	00c03633          	snez	a2,a2
    3bda:	8e55                	or	a2,a2,a3
    3bdc:	00b75733          	srl	a4,a4,a1
    3be0:	962a                	add	a2,a2,a0
    3be2:	00a63533          	sltu	a0,a2,a0
    3be6:	973e                	add	a4,a4,a5
    3be8:	00a707b3          	add	a5,a4,a0
    3bec:	8532                	mv	a0,a2
    3bee:	00800737          	lui	a4,0x800
    3bf2:	8f7d                	and	a4,a4,a5
    3bf4:	14070463          	beqz	a4,3d3c <__subdf3+0x22a>
    3bf8:	0485                	addi	s1,s1,1
    3bfa:	7ff00713          	li	a4,2047
    3bfe:	48e48c63          	beq	s1,a4,4096 <__subdf3+0x584>
    3c02:	ff800737          	lui	a4,0xff800
    3c06:	177d                	addi	a4,a4,-1
    3c08:	8ff9                	and	a5,a5,a4
    3c0a:	00155713          	srli	a4,a0,0x1
    3c0e:	8905                	andi	a0,a0,1
    3c10:	8d59                	or	a0,a0,a4
    3c12:	01f79713          	slli	a4,a5,0x1f
    3c16:	8d59                	or	a0,a0,a4
    3c18:	8385                	srli	a5,a5,0x1
    3c1a:	a20d                	j	3d3c <__subdf3+0x22a>
    3c1c:	fe058693          	addi	a3,a1,-32
    3c20:	02000293          	li	t0,32
    3c24:	00d756b3          	srl	a3,a4,a3
    3c28:	4301                	li	t1,0
    3c2a:	00558863          	beq	a1,t0,3c3a <__subdf3+0x128>
    3c2e:	04000313          	li	t1,64
    3c32:	40b305b3          	sub	a1,t1,a1
    3c36:	00b71333          	sll	t1,a4,a1
    3c3a:	00c36633          	or	a2,t1,a2
    3c3e:	00c03633          	snez	a2,a2
    3c42:	8e55                	or	a2,a2,a3
    3c44:	4701                	li	a4,0
    3c46:	bf69                	j	3be0 <__subdf3+0xce>
    3c48:	8e59                	or	a2,a2,a4
    3c4a:	00c03633          	snez	a2,a2
    3c4e:	bfdd                	j	3c44 <__subdf3+0x132>
    3c50:	0a028a63          	beqz	t0,3d04 <__subdf3+0x1f2>
    3c54:	409305b3          	sub	a1,t1,s1
    3c58:	e48d                	bnez	s1,3c82 <__subdf3+0x170>
    3c5a:	00a7e6b3          	or	a3,a5,a0
    3c5e:	42068363          	beqz	a3,4084 <__subdf3+0x572>
    3c62:	fff58693          	addi	a3,a1,-1
    3c66:	e699                	bnez	a3,3c74 <__subdf3+0x162>
    3c68:	9532                	add	a0,a0,a2
    3c6a:	97ba                	add	a5,a5,a4
    3c6c:	00c53633          	sltu	a2,a0,a2
    3c70:	97b2                	add	a5,a5,a2
    3c72:	bf31                	j	3b8e <__subdf3+0x7c>
    3c74:	7ff00293          	li	t0,2047
    3c78:	00559d63          	bne	a1,t0,3c92 <__subdf3+0x180>
  FP_UNPACK_SEMIRAW_D (B, b);
    3c7c:	87ba                	mv	a5,a4
    3c7e:	8532                	mv	a0,a2
    3c80:	bf29                	j	3b9a <__subdf3+0x88>
  FP_SUB_D (R, A, B);
    3c82:	7ff00693          	li	a3,2047
    3c86:	fed30be3          	beq	t1,a3,3c7c <__subdf3+0x16a>
    3c8a:	008006b7          	lui	a3,0x800
    3c8e:	8fd5                	or	a5,a5,a3
    3c90:	86ae                	mv	a3,a1
    3c92:	03800593          	li	a1,56
    3c96:	06d5c363          	blt	a1,a3,3cfc <__subdf3+0x1ea>
    3c9a:	45fd                	li	a1,31
    3c9c:	02d5ca63          	blt	a1,a3,3cd0 <__subdf3+0x1be>
    3ca0:	02000293          	li	t0,32
    3ca4:	40d282b3          	sub	t0,t0,a3
    3ca8:	005795b3          	sll	a1,a5,t0
    3cac:	00d553b3          	srl	t2,a0,a3
    3cb0:	00551533          	sll	a0,a0,t0
    3cb4:	0075e5b3          	or	a1,a1,t2
    3cb8:	00a03533          	snez	a0,a0
    3cbc:	8d4d                	or	a0,a0,a1
    3cbe:	00d7d7b3          	srl	a5,a5,a3
    3cc2:	9532                	add	a0,a0,a2
    3cc4:	97ba                	add	a5,a5,a4
    3cc6:	00c53633          	sltu	a2,a0,a2
    3cca:	97b2                	add	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    3ccc:	849a                	mv	s1,t1
    3cce:	b705                	j	3bee <__subdf3+0xdc>
  FP_SUB_D (R, A, B);
    3cd0:	fe068593          	addi	a1,a3,-32 # 7fffe0 <__erodata+0x7faf38>
    3cd4:	02000393          	li	t2,32
    3cd8:	00b7d5b3          	srl	a1,a5,a1
    3cdc:	4281                	li	t0,0
    3cde:	00768863          	beq	a3,t2,3cee <__subdf3+0x1dc>
    3ce2:	04000293          	li	t0,64
    3ce6:	40d286b3          	sub	a3,t0,a3
    3cea:	00d792b3          	sll	t0,a5,a3
    3cee:	00a2e533          	or	a0,t0,a0
    3cf2:	00a03533          	snez	a0,a0
    3cf6:	8d4d                	or	a0,a0,a1
    3cf8:	4781                	li	a5,0
    3cfa:	b7e1                	j	3cc2 <__subdf3+0x1b0>
    3cfc:	8d5d                	or	a0,a0,a5
    3cfe:	00a03533          	snez	a0,a0
    3d02:	bfdd                	j	3cf8 <__subdf3+0x1e6>
    3d04:	00148693          	addi	a3,s1,1
    3d08:	7fe6f593          	andi	a1,a3,2046
    3d0c:	e1bd                	bnez	a1,3d72 <__subdf3+0x260>
    3d0e:	00a7e6b3          	or	a3,a5,a0
    3d12:	e4a9                	bnez	s1,3d5c <__subdf3+0x24a>
    3d14:	36068c63          	beqz	a3,408c <__subdf3+0x57a>
    3d18:	00c766b3          	or	a3,a4,a2
    3d1c:	c285                	beqz	a3,3d3c <__subdf3+0x22a>
    3d1e:	962a                	add	a2,a2,a0
    3d20:	97ba                	add	a5,a5,a4
    3d22:	00a63533          	sltu	a0,a2,a0
    3d26:	97aa                	add	a5,a5,a0
    3d28:	00800737          	lui	a4,0x800
    3d2c:	8f7d                	and	a4,a4,a5
    3d2e:	8532                	mv	a0,a2
    3d30:	c711                	beqz	a4,3d3c <__subdf3+0x22a>
    3d32:	ff800737          	lui	a4,0xff800
    3d36:	177d                	addi	a4,a4,-1
    3d38:	8ff9                	and	a5,a5,a4
    3d3a:	4485                	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
    3d3c:	00757713          	andi	a4,a0,7
    3d40:	34070d63          	beqz	a4,409a <__subdf3+0x588>
    3d44:	00f57713          	andi	a4,a0,15
    3d48:	4691                	li	a3,4
    3d4a:	34d70863          	beq	a4,a3,409a <__subdf3+0x588>
    3d4e:	00450713          	addi	a4,a0,4
    3d52:	00a73533          	sltu	a0,a4,a0
    3d56:	97aa                	add	a5,a5,a0
    3d58:	853a                	mv	a0,a4
    3d5a:	a681                	j	409a <__subdf3+0x588>
  FP_SUB_D (R, A, B);
    3d5c:	d285                	beqz	a3,3c7c <__subdf3+0x16a>
    3d5e:	8e59                	or	a2,a2,a4
    3d60:	e2060de3          	beqz	a2,3b9a <__subdf3+0x88>
    3d64:	4401                	li	s0,0
    3d66:	004007b7          	lui	a5,0x400
    3d6a:	4501                	li	a0,0
    3d6c:	7ff00493          	li	s1,2047
    3d70:	a62d                	j	409a <__subdf3+0x588>
    3d72:	7ff00593          	li	a1,2047
    3d76:	30b68e63          	beq	a3,a1,4092 <__subdf3+0x580>
    3d7a:	962a                	add	a2,a2,a0
    3d7c:	00a63533          	sltu	a0,a2,a0
    3d80:	97ba                	add	a5,a5,a4
    3d82:	97aa                	add	a5,a5,a0
    3d84:	01f79513          	slli	a0,a5,0x1f
    3d88:	8205                	srli	a2,a2,0x1
    3d8a:	8d51                	or	a0,a0,a2
    3d8c:	8385                	srli	a5,a5,0x1
    3d8e:	84b6                	mv	s1,a3
    3d90:	b775                	j	3d3c <__subdf3+0x22a>
    3d92:	0c505563          	blez	t0,3e5c <__subdf3+0x34a>
    3d96:	08031063          	bnez	t1,3e16 <__subdf3+0x304>
    3d9a:	00c766b3          	or	a3,a4,a2
    3d9e:	34068c63          	beqz	a3,40f6 <__subdf3+0x5e4>
    3da2:	fff28593          	addi	a1,t0,-1
    3da6:	e991                	bnez	a1,3dba <__subdf3+0x2a8>
    3da8:	40c50633          	sub	a2,a0,a2
    3dac:	00c53533          	sltu	a0,a0,a2
    3db0:	8f99                	sub	a5,a5,a4
    3db2:	8f89                	sub	a5,a5,a0
    3db4:	8532                	mv	a0,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    3db6:	4485                	li	s1,1
  FP_SUB_D (R, A, B);
    3db8:	a0b1                	j	3e04 <__subdf3+0x2f2>
    3dba:	7ff00693          	li	a3,2047
    3dbe:	dcd28ee3          	beq	t0,a3,3b9a <__subdf3+0x88>
    3dc2:	03800693          	li	a3,56
    3dc6:	08b6c763          	blt	a3,a1,3e54 <__subdf3+0x342>
    3dca:	46fd                	li	a3,31
    3dcc:	04b6ce63          	blt	a3,a1,3e28 <__subdf3+0x316>
    3dd0:	02000313          	li	t1,32
    3dd4:	40b30333          	sub	t1,t1,a1
    3dd8:	006716b3          	sll	a3,a4,t1
    3ddc:	00b652b3          	srl	t0,a2,a1
    3de0:	00661633          	sll	a2,a2,t1
    3de4:	0056e6b3          	or	a3,a3,t0
    3de8:	00c03633          	snez	a2,a2
    3dec:	8e55                	or	a2,a2,a3
    3dee:	00b75733          	srl	a4,a4,a1
    3df2:	40c50633          	sub	a2,a0,a2
    3df6:	00c53533          	sltu	a0,a0,a2
    3dfa:	40e78733          	sub	a4,a5,a4
    3dfe:	40a707b3          	sub	a5,a4,a0
    3e02:	8532                	mv	a0,a2
    3e04:	008005b7          	lui	a1,0x800
    3e08:	00b7f733          	and	a4,a5,a1
    3e0c:	db05                	beqz	a4,3d3c <__subdf3+0x22a>
    3e0e:	15fd                	addi	a1,a1,-1
    3e10:	8dfd                	and	a1,a1,a5
    3e12:	832a                	mv	t1,a0
    3e14:	aa5d                	j	3fca <__subdf3+0x4b8>
    3e16:	7ff00693          	li	a3,2047
    3e1a:	f2d481e3          	beq	s1,a3,3d3c <__subdf3+0x22a>
    3e1e:	008006b7          	lui	a3,0x800
    3e22:	8f55                	or	a4,a4,a3
    3e24:	8596                	mv	a1,t0
    3e26:	bf71                	j	3dc2 <__subdf3+0x2b0>
    3e28:	fe058693          	addi	a3,a1,-32 # 7fffe0 <__erodata+0x7faf38>
    3e2c:	02000293          	li	t0,32
    3e30:	00d756b3          	srl	a3,a4,a3
    3e34:	4301                	li	t1,0
    3e36:	00558863          	beq	a1,t0,3e46 <__subdf3+0x334>
    3e3a:	04000313          	li	t1,64
    3e3e:	40b305b3          	sub	a1,t1,a1
    3e42:	00b71333          	sll	t1,a4,a1
    3e46:	00c36633          	or	a2,t1,a2
    3e4a:	00c03633          	snez	a2,a2
    3e4e:	8e55                	or	a2,a2,a3
    3e50:	4701                	li	a4,0
    3e52:	b745                	j	3df2 <__subdf3+0x2e0>
    3e54:	8e59                	or	a2,a2,a4
    3e56:	00c03633          	snez	a2,a2
    3e5a:	bfdd                	j	3e50 <__subdf3+0x33e>
    3e5c:	0c028463          	beqz	t0,3f24 <__subdf3+0x412>
    3e60:	409302b3          	sub	t0,t1,s1
    3e64:	e895                	bnez	s1,3e98 <__subdf3+0x386>
    3e66:	00a7e5b3          	or	a1,a5,a0
    3e6a:	28058863          	beqz	a1,40fa <__subdf3+0x5e8>
    3e6e:	fff28593          	addi	a1,t0,-1
    3e72:	e991                	bnez	a1,3e86 <__subdf3+0x374>
    3e74:	40a60533          	sub	a0,a2,a0
    3e78:	40f707b3          	sub	a5,a4,a5
    3e7c:	00a63633          	sltu	a2,a2,a0
    3e80:	8f91                	sub	a5,a5,a2
    3e82:	8436                	mv	s0,a3
    3e84:	bf0d                	j	3db6 <__subdf3+0x2a4>
    3e86:	7ff00393          	li	t2,2047
    3e8a:	00729f63          	bne	t0,t2,3ea8 <__subdf3+0x396>
  FP_UNPACK_SEMIRAW_D (B, b);
    3e8e:	87ba                	mv	a5,a4
    3e90:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    3e92:	7ff00493          	li	s1,2047
    3e96:	a07d                	j	3f44 <__subdf3+0x432>
    3e98:	7ff00593          	li	a1,2047
    3e9c:	feb309e3          	beq	t1,a1,3e8e <__subdf3+0x37c>
    3ea0:	008005b7          	lui	a1,0x800
    3ea4:	8fcd                	or	a5,a5,a1
    3ea6:	8596                	mv	a1,t0
    3ea8:	03800293          	li	t0,56
    3eac:	06b2c863          	blt	t0,a1,3f1c <__subdf3+0x40a>
    3eb0:	42fd                	li	t0,31
    3eb2:	02b2ce63          	blt	t0,a1,3eee <__subdf3+0x3dc>
    3eb6:	02000393          	li	t2,32
    3eba:	40b383b3          	sub	t2,t2,a1
    3ebe:	007792b3          	sll	t0,a5,t2
    3ec2:	00b55433          	srl	s0,a0,a1
    3ec6:	00751533          	sll	a0,a0,t2
    3eca:	0082e2b3          	or	t0,t0,s0
    3ece:	00a03533          	snez	a0,a0
    3ed2:	00a2e533          	or	a0,t0,a0
    3ed6:	00b7d7b3          	srl	a5,a5,a1
    3eda:	40a60533          	sub	a0,a2,a0
    3ede:	40f707b3          	sub	a5,a4,a5
    3ee2:	00a63633          	sltu	a2,a2,a0
    3ee6:	8f91                	sub	a5,a5,a2
  FP_UNPACK_SEMIRAW_D (B, b);
    3ee8:	849a                	mv	s1,t1
    3eea:	8436                	mv	s0,a3
    3eec:	bf21                	j	3e04 <__subdf3+0x2f2>
  FP_SUB_D (R, A, B);
    3eee:	fe058293          	addi	t0,a1,-32 # 7fffe0 <__erodata+0x7faf38>
    3ef2:	02000413          	li	s0,32
    3ef6:	0057d2b3          	srl	t0,a5,t0
    3efa:	4381                	li	t2,0
    3efc:	00858863          	beq	a1,s0,3f0c <__subdf3+0x3fa>
    3f00:	04000393          	li	t2,64
    3f04:	40b385b3          	sub	a1,t2,a1
    3f08:	00b793b3          	sll	t2,a5,a1
    3f0c:	00a3e533          	or	a0,t2,a0
    3f10:	00a03533          	snez	a0,a0
    3f14:	00a2e533          	or	a0,t0,a0
    3f18:	4781                	li	a5,0
    3f1a:	b7c1                	j	3eda <__subdf3+0x3c8>
    3f1c:	8d5d                	or	a0,a0,a5
    3f1e:	00a03533          	snez	a0,a0
    3f22:	bfdd                	j	3f18 <__subdf3+0x406>
    3f24:	00148593          	addi	a1,s1,1
    3f28:	7fe5f593          	andi	a1,a1,2046
    3f2c:	e9a5                	bnez	a1,3f9c <__subdf3+0x48a>
    3f2e:	00c765b3          	or	a1,a4,a2
    3f32:	00a7e333          	or	t1,a5,a0
    3f36:	e8a1                	bnez	s1,3f86 <__subdf3+0x474>
    3f38:	00031863          	bnez	t1,3f48 <__subdf3+0x436>
    3f3c:	1c058363          	beqz	a1,4102 <__subdf3+0x5f0>
  FP_UNPACK_SEMIRAW_D (B, b);
    3f40:	87ba                	mv	a5,a4
    3f42:	8532                	mv	a0,a2
    3f44:	8436                	mv	s0,a3
    3f46:	bbdd                	j	3d3c <__subdf3+0x22a>
  FP_SUB_D (R, A, B);
    3f48:	de058ae3          	beqz	a1,3d3c <__subdf3+0x22a>
    3f4c:	40c50333          	sub	t1,a0,a2
    3f50:	006532b3          	sltu	t0,a0,t1
    3f54:	40e785b3          	sub	a1,a5,a4
    3f58:	405585b3          	sub	a1,a1,t0
    3f5c:	008002b7          	lui	t0,0x800
    3f60:	0055f2b3          	and	t0,a1,t0
    3f64:	00028a63          	beqz	t0,3f78 <__subdf3+0x466>
    3f68:	40a60533          	sub	a0,a2,a0
    3f6c:	40f707b3          	sub	a5,a4,a5
    3f70:	00a63633          	sltu	a2,a2,a0
    3f74:	8f91                	sub	a5,a5,a2
    3f76:	b7f9                	j	3f44 <__subdf3+0x432>
    3f78:	00b36533          	or	a0,t1,a1
    3f7c:	18050763          	beqz	a0,410a <__subdf3+0x5f8>
    3f80:	87ae                	mv	a5,a1
    3f82:	851a                	mv	a0,t1
    3f84:	bb65                	j	3d3c <__subdf3+0x22a>
    3f86:	00031863          	bnez	t1,3f96 <__subdf3+0x484>
    3f8a:	18058263          	beqz	a1,410e <__subdf3+0x5fc>
  FP_UNPACK_SEMIRAW_D (B, b);
    3f8e:	87ba                	mv	a5,a4
    3f90:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    3f92:	8436                	mv	s0,a3
    3f94:	b119                	j	3b9a <__subdf3+0x88>
    3f96:	c00582e3          	beqz	a1,3b9a <__subdf3+0x88>
    3f9a:	b3e9                	j	3d64 <__subdf3+0x252>
    3f9c:	40c50333          	sub	t1,a0,a2
    3fa0:	006532b3          	sltu	t0,a0,t1
    3fa4:	40e785b3          	sub	a1,a5,a4
    3fa8:	405585b3          	sub	a1,a1,t0
    3fac:	008002b7          	lui	t0,0x800
    3fb0:	0055f2b3          	and	t0,a1,t0
    3fb4:	06028a63          	beqz	t0,4028 <__subdf3+0x516>
    3fb8:	40a60333          	sub	t1,a2,a0
    3fbc:	40f707b3          	sub	a5,a4,a5
    3fc0:	00663633          	sltu	a2,a2,t1
    3fc4:	40c785b3          	sub	a1,a5,a2
    3fc8:	8436                	mv	s0,a3
    3fca:	c5ad                	beqz	a1,4034 <__subdf3+0x522>
    3fcc:	852e                	mv	a0,a1
    3fce:	c21a                	sw	t1,4(sp)
    3fd0:	c02e                	sw	a1,0(sp)
    3fd2:	2c19                	jal	41e8 <__clzsi2>
    3fd4:	4582                	lw	a1,0(sp)
    3fd6:	4312                	lw	t1,4(sp)
    3fd8:	ff850713          	addi	a4,a0,-8
    3fdc:	47fd                	li	a5,31
    3fde:	06e7c463          	blt	a5,a4,4046 <__subdf3+0x534>
    3fe2:	02000793          	li	a5,32
    3fe6:	8f99                	sub	a5,a5,a4
    3fe8:	00e595b3          	sll	a1,a1,a4
    3fec:	00f357b3          	srl	a5,t1,a5
    3ff0:	8fcd                	or	a5,a5,a1
    3ff2:	00e31533          	sll	a0,t1,a4
    3ff6:	08974163          	blt	a4,s1,4078 <__subdf3+0x566>
    3ffa:	8f05                	sub	a4,a4,s1
    3ffc:	00170613          	addi	a2,a4,1 # ff800001 <MTIME_HI_ADDR+0x1f7f4005>
    4000:	46fd                	li	a3,31
    4002:	04c6c863          	blt	a3,a2,4052 <__subdf3+0x540>
    4006:	02000713          	li	a4,32
    400a:	8f11                	sub	a4,a4,a2
    400c:	00e796b3          	sll	a3,a5,a4
    4010:	00c555b3          	srl	a1,a0,a2
    4014:	00e51533          	sll	a0,a0,a4
    4018:	8ecd                	or	a3,a3,a1
    401a:	00a03533          	snez	a0,a0
    401e:	8d55                	or	a0,a0,a3
    4020:	00c7d7b3          	srl	a5,a5,a2
    4024:	4481                	li	s1,0
    4026:	bb19                	j	3d3c <__subdf3+0x22a>
    4028:	00b36533          	or	a0,t1,a1
    402c:	fd59                	bnez	a0,3fca <__subdf3+0x4b8>
    402e:	4781                	li	a5,0
    4030:	4481                	li	s1,0
    4032:	a8d1                	j	4106 <__subdf3+0x5f4>
    4034:	851a                	mv	a0,t1
    4036:	c22e                	sw	a1,4(sp)
    4038:	c01a                	sw	t1,0(sp)
    403a:	227d                	jal	41e8 <__clzsi2>
    403c:	4592                	lw	a1,4(sp)
    403e:	4302                	lw	t1,0(sp)
    4040:	02050513          	addi	a0,a0,32
    4044:	bf51                	j	3fd8 <__subdf3+0x4c6>
    4046:	fd850793          	addi	a5,a0,-40
    404a:	00f317b3          	sll	a5,t1,a5
    404e:	4501                	li	a0,0
    4050:	b75d                	j	3ff6 <__subdf3+0x4e4>
    4052:	1705                	addi	a4,a4,-31
    4054:	02000593          	li	a1,32
    4058:	00e7d733          	srl	a4,a5,a4
    405c:	4681                	li	a3,0
    405e:	00b60763          	beq	a2,a1,406c <__subdf3+0x55a>
    4062:	04000693          	li	a3,64
    4066:	8e91                	sub	a3,a3,a2
    4068:	00d796b3          	sll	a3,a5,a3
    406c:	8d55                	or	a0,a0,a3
    406e:	00a03533          	snez	a0,a0
    4072:	8d59                	or	a0,a0,a4
    4074:	4781                	li	a5,0
    4076:	b77d                	j	4024 <__subdf3+0x512>
    4078:	8c99                	sub	s1,s1,a4
    407a:	ff800737          	lui	a4,0xff800
    407e:	177d                	addi	a4,a4,-1
    4080:	8ff9                	and	a5,a5,a4
    4082:	b96d                	j	3d3c <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    4084:	87ba                	mv	a5,a4
    4086:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    4088:	84ae                	mv	s1,a1
    408a:	b94d                	j	3d3c <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    408c:	87ba                	mv	a5,a4
    408e:	8532                	mv	a0,a2
    4090:	b175                	j	3d3c <__subdf3+0x22a>
    4092:	7ff00493          	li	s1,2047
    4096:	4781                	li	a5,0
    4098:	4501                	li	a0,0
  FP_PACK_SEMIRAW_D (r, R);
    409a:	00800737          	lui	a4,0x800
    409e:	8f7d                	and	a4,a4,a5
    40a0:	cb11                	beqz	a4,40b4 <__subdf3+0x5a2>
    40a2:	0485                	addi	s1,s1,1
    40a4:	7ff00713          	li	a4,2047
    40a8:	06e48863          	beq	s1,a4,4118 <__subdf3+0x606>
    40ac:	ff800737          	lui	a4,0xff800
    40b0:	177d                	addi	a4,a4,-1
    40b2:	8ff9                	and	a5,a5,a4
    40b4:	01d79713          	slli	a4,a5,0x1d
    40b8:	810d                	srli	a0,a0,0x3
    40ba:	8d59                	or	a0,a0,a4
    40bc:	7ff00713          	li	a4,2047
    40c0:	838d                	srli	a5,a5,0x3
    40c2:	00e49963          	bne	s1,a4,40d4 <__subdf3+0x5c2>
    40c6:	8d5d                	or	a0,a0,a5
    40c8:	4781                	li	a5,0
    40ca:	c509                	beqz	a0,40d4 <__subdf3+0x5c2>
    40cc:	000807b7          	lui	a5,0x80
    40d0:	4501                	li	a0,0
    40d2:	4401                	li	s0,0
    40d4:	01449713          	slli	a4,s1,0x14
    40d8:	7ff006b7          	lui	a3,0x7ff00
    40dc:	07b2                	slli	a5,a5,0xc
    40de:	8f75                	and	a4,a4,a3
    40e0:	83b1                	srli	a5,a5,0xc
    40e2:	047e                	slli	s0,s0,0x1f
    40e4:	8fd9                	or	a5,a5,a4
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    40e6:	40c2                	lw	ra,16(sp)
  FP_PACK_SEMIRAW_D (r, R);
    40e8:	0087e733          	or	a4,a5,s0
}
    40ec:	4432                	lw	s0,12(sp)
    40ee:	44a2                	lw	s1,8(sp)
    40f0:	85ba                	mv	a1,a4
    40f2:	0151                	addi	sp,sp,20
    40f4:	8082                	ret
    40f6:	8496                	mv	s1,t0
    40f8:	b191                	j	3d3c <__subdf3+0x22a>
  FP_UNPACK_SEMIRAW_D (B, b);
    40fa:	87ba                	mv	a5,a4
    40fc:	8532                	mv	a0,a2
  FP_SUB_D (R, A, B);
    40fe:	8496                	mv	s1,t0
    4100:	b591                	j	3f44 <__subdf3+0x432>
    4102:	4781                	li	a5,0
    4104:	4501                	li	a0,0
    4106:	4401                	li	s0,0
    4108:	bf49                	j	409a <__subdf3+0x588>
    410a:	4781                	li	a5,0
    410c:	bfed                	j	4106 <__subdf3+0x5f4>
    410e:	4501                	li	a0,0
    4110:	4401                	li	s0,0
    4112:	004007b7          	lui	a5,0x400
    4116:	b999                	j	3d6c <__subdf3+0x25a>
    4118:	4781                	li	a5,0
    411a:	4501                	li	a0,0
    411c:	bf61                	j	40b4 <__subdf3+0x5a2>

0000411e <__fixdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
    411e:	0145d713          	srli	a4,a1,0x14
    4122:	001006b7          	lui	a3,0x100
    4126:	fff68793          	addi	a5,a3,-1 # fffff <__erodata+0xfaf57>
    412a:	7ff77713          	andi	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 1);
    412e:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
    4132:	8fed                	and	a5,a5,a1
    4134:	81fd                	srli	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 1);
    4136:	04e65463          	bge	a2,a4,417e <__fixdfsi+0x60>
    413a:	41d00613          	li	a2,1053
    413e:	00e65863          	bge	a2,a4,414e <__fixdfsi+0x30>
    4142:	80000537          	lui	a0,0x80000
    4146:	fff54513          	not	a0,a0
    414a:	952e                	add	a0,a0,a1
    414c:	8082                	ret
    414e:	8fd5                	or	a5,a5,a3
    4150:	43300693          	li	a3,1075
    4154:	8e99                	sub	a3,a3,a4
    4156:	467d                	li	a2,31
    4158:	00d64d63          	blt	a2,a3,4172 <__fixdfsi+0x54>
    415c:	bed70713          	addi	a4,a4,-1043 # ff7ffbed <MTIME_HI_ADDR+0x1f7f3bf1>
    4160:	00e797b3          	sll	a5,a5,a4
    4164:	00d55533          	srl	a0,a0,a3
    4168:	8d5d                	or	a0,a0,a5
    416a:	c999                	beqz	a1,4180 <__fixdfsi+0x62>
    416c:	40a00533          	neg	a0,a0
    4170:	8082                	ret
    4172:	41300513          	li	a0,1043
    4176:	8d19                	sub	a0,a0,a4
    4178:	00a7d533          	srl	a0,a5,a0
    417c:	b7fd                	j	416a <__fixdfsi+0x4c>
    417e:	4501                	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
    4180:	8082                	ret

00004182 <__floatsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatsidf (SItype i)
{
    4182:	1151                	addi	sp,sp,-12
    4184:	c406                	sw	ra,8(sp)
    4186:	c222                	sw	s0,4(sp)
    4188:	c026                	sw	s1,0(sp)
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
    418a:	cd21                	beqz	a0,41e2 <__floatsidf+0x60>
    418c:	41f55793          	srai	a5,a0,0x1f
    4190:	00a7c433          	xor	s0,a5,a0
    4194:	8c1d                	sub	s0,s0,a5
    4196:	01f55493          	srli	s1,a0,0x1f
    419a:	8522                	mv	a0,s0
    419c:	20b1                	jal	41e8 <__clzsi2>
    419e:	41e00713          	li	a4,1054
    41a2:	47a9                	li	a5,10
    41a4:	8f09                	sub	a4,a4,a0
    41a6:	02a7c863          	blt	a5,a0,41d6 <__floatsidf+0x54>
    41aa:	47ad                	li	a5,11
    41ac:	8f89                	sub	a5,a5,a0
    41ae:	0555                	addi	a0,a0,21
    41b0:	00f457b3          	srl	a5,s0,a5
    41b4:	00a41433          	sll	s0,s0,a0
    41b8:	8526                	mv	a0,s1
  FP_PACK_RAW_D (a, A);
    41ba:	07b2                	slli	a5,a5,0xc
    41bc:	0752                	slli	a4,a4,0x14
    41be:	83b1                	srli	a5,a5,0xc
    41c0:	057e                	slli	a0,a0,0x1f
    41c2:	8fd9                	or	a5,a5,a4

  return a;
}
    41c4:	40a2                	lw	ra,8(sp)
  FP_PACK_RAW_D (a, A);
    41c6:	00a7e733          	or	a4,a5,a0
}
    41ca:	8522                	mv	a0,s0
    41cc:	4412                	lw	s0,4(sp)
    41ce:	4482                	lw	s1,0(sp)
    41d0:	85ba                	mv	a1,a4
    41d2:	0131                	addi	sp,sp,12
    41d4:	8082                	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
    41d6:	1555                	addi	a0,a0,-11
    41d8:	00a417b3          	sll	a5,s0,a0
    41dc:	8526                	mv	a0,s1
    41de:	4401                	li	s0,0
    41e0:	bfe9                	j	41ba <__floatsidf+0x38>
    41e2:	4701                	li	a4,0
    41e4:	4781                	li	a5,0
    41e6:	bfe5                	j	41de <__floatsidf+0x5c>

000041e8 <__clzsi2>:
  count_leading_zeros (ret, x);
    41e8:	67c1                	lui	a5,0x10
    41ea:	02f57563          	bgeu	a0,a5,4214 <__clzsi2+0x2c>
    41ee:	0ff00793          	li	a5,255
    41f2:	00a7b7b3          	sltu	a5,a5,a0
    41f6:	078e                	slli	a5,a5,0x3
    41f8:	6715                	lui	a4,0x5
    41fa:	02000693          	li	a3,32
    41fe:	8e9d                	sub	a3,a3,a5
    4200:	00f55533          	srl	a0,a0,a5
    4204:	fa870793          	addi	a5,a4,-88 # 4fa8 <__clz_tab>
    4208:	953e                	add	a0,a0,a5
    420a:	00054503          	lbu	a0,0(a0) # 80000000 <MTIME_HI_ADDR+0x9fff4004>
}
    420e:	40a68533          	sub	a0,a3,a0
    4212:	8082                	ret
  count_leading_zeros (ret, x);
    4214:	01000737          	lui	a4,0x1000
    4218:	47c1                	li	a5,16
    421a:	fce56fe3          	bltu	a0,a4,41f8 <__clzsi2+0x10>
    421e:	47e1                	li	a5,24
    4220:	bfe1                	j	41f8 <__clzsi2+0x10>
	...
