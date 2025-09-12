/*Copyright 2018-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");

you may not use this file except in compliance with the License.

You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software

distributed under the License is distributed on an "AS IS" BASIS,

WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

See the License for the specific language governing permissions and

limitations under the License.

*/

.text

.global	__start

__start:

#------------------------------ Define -------------------------------------

#clic

.set CLICCFG       ,0x0000

.set CLICINFO      ,0x0004

.set MINTTHRESH	   ,0x0008

.set INTIP         ,0x1000

.set INTIE         ,0x1001

.set INTATTR       ,0x1002

.set INTCTL        ,0x1003

#clint

.set MTIME_CMP_LO_ADDR      ,0xe0004000

.set MTIME_CMP_HI_ADDR      ,0xe0004004

.set MSIP_ADDR              ,0xe0000000

.set MTIME_LO_ADDR          ,0xe000bff8

.set MTIME_HI_ADDR          ,0xe000bffc

#------------------------------ Macro --------------------------------------

.macro SETINT EXP_CODE, HANDLER_BEGIN   # ,HANDLER_END

   li   x10 , 0x0

   la   t0, vector_table+64

   addi t1,x0,\EXP_CODE

   slli t1,t1,0x2

   add  t1,t1,t0

   la   t0, \HANDLER_BEGIN

   sw   t0, 0(t1)

.endm

  la x3, __erodata

  la x4, __data_start__

  la x5, __data_end__

  sub x5, x5, x4

  beqz x5, L_loop0_done

L_loop0:

   lw x6, 0(x3)

   sw x6, 0(x4)

   addi x3, x3, 0x4

   addi x4, x4, 0x4

   addi x5, x5, -4

   bnez x5, L_loop0

L_loop0_done:

   la x3, __data_end__

   la x4, __bss_end__

   li x5, 0

   sub x4, x4, x3

   beqz x4, L_loop1_done

L_loop1:

   sw x5, 0(x3)

   addi x3, x3, 0x4

   addi x4, x4, -4

   bnez x4, L_loop1


L_loop1_done:

  la x3, trap_handler

  csrw mtvec, x3

  la x3, vector_table

  addi x3, x3, 64

  csrw mtvt, x3

  la  x2, __kernel_stack

#enable cache

#  li x3, 0x1

#  csrw mhcr, x3

#open theadisaee

#  la  x3, 0x400000

#  csrrs x0, mxstatus, x3

#open mie in mstatus

  #csrsi mstatus, 0x8

  #csrsi mie,     0x7

#Set Interrupt Handler

  SETINT   7   CORET_IRQHandler     # MTIMER is No. (64+) 7

#SETINT  16   hdmi_int_handler      # AHB_HDMI  is No. (64+)  0+16 = 16     CH0

#SETINT  17   sdio_int_handler      # AHB_SDIO  is No. (64+)  1+16 = 17     CH1

#SETINT  32   tmr0_int_handler      # APB_TIMER0 is No. (64+) 16+16 = 32    CH16

#SETINT  33   tmr1_int_handler      # APB_TIMER1 is No. (64+) 17+16 = 33    CH17

#SETINT  34   tmr2_int_handler      # APB_TIMER2 is No. (64+) 18+16 = 34    CH18

#SETINT  35   tmr3_int_handler      # APB_TIMER3 is No. (64+) 19+16 = 35    CH19

#SETINT  36   tmr4_int_handler      # APB_TIMER4 is No. (64+) 20+16 = 36    CH20

#SETINT  37   utx0_int_handler      # APB_UART_TX0 is No. (64+) 21+16 = 37  CH21

#SETINT  38   urx0_int_handler      # APB_UART_RX0 is No. (64+) 22+16 = 38  CH22

#SETINT  39   utx1_int_handler      # APB_UART_TX1 is No. (64+) 23+16 = 39  CH23

#SETINT  40   urx1_int_handler      # APB_UART_RX1 is No. (64+) 24+16 = 40  CH24

#SETINT  41   gpio0_int_handler     # APB_GPIO0 is No. (64+) 25+16 = 41     CH25

#SETINT  42   gpio1_int_handler     # APB_GPIO1 is No. (64+) 26+16 = 42     CH26

#SETINT  43   gpio2_int_handler     # APB_GPIO2 is No. (64+) 27+16 = 43     CH27

#SETINT  44   gpio3_int_handler     # APB_GPIO3 is No. (64+) 28+16 = 44     CH28

__to_main:

  jal system_init
  jal board_init
  csrsi mstatus, 0x8
  csrsi mie,     0x7
  jal entry

  .global __exit

__exit:

  fence.i

  fence

  li    x4, 0x6000fff8

  addi  x3, x0,0xFF

  slli  x3, x3,0x4

  addi  x3, x3, 0xf #0xFFF

  sw	x3, 0(x4)

  .global __fail

__fail:

  fence.i

  fence

  li    x4, 0x6000fff8

  addi  x3, x0,0xEE

  slli  x3, x3,0x4

  addi  x3, x3,0xe #0xEEE

  sw	x3, 0(x4)

  .align 6

  .global trap_handler

trap_handler:

  j __synchronous_exception

  .align 2

  j __fail

__synchronous_exception:

  sw   x13,-4(x2)

  sw   x14,-8(x2)

  sw   x15,-12(x2)

  csrr x14,mcause

  andi x15,x14,0xff  #cause

  srli x14,x14,0x1b   #int

  andi x14,x14,0x10   #mask bit

  add  x14,x14,x15    #{int,cause}

  slli x14,x14,0x2  #offset

  la   x15,vector_table

  add  x15,x14,x15  #target pc

  lw   x14, 0(x15)  #get exception addr

  lw   x13, -4(x2)  #recover x16

  lw   x15, -12(x2) #recover x15

#addi x14,x14,-4

  jr   x14

  .global vector_table

  .align  6

vector_table:	#totally 256 entries

	.rept   256

	    .long   __dummy

	.endr

  .global __dummy

__dummy:

  j __fail

  .data

  .long 0


