
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
   4:	0c018193          	addi	gp,gp,192 # 200000c0 <__global_pointer$>
.option pop
    la      a0, Default_Handler
   8:	00000517          	auipc	a0,0x0
   c:	0b850513          	addi	a0,a0,184 # c0 <Default_Handler>
    ori     a0, a0, 3
  10:	00356513          	ori	a0,a0,3
    csrw    mtvec, a0
  14:	30551073          	csrw	mtvec,a0

    la      a0, __Vectors
  18:	f4018513          	addi	a0,gp,-192 # 20000000 <console_handle>
    csrw    mtvt, a0
  1c:	30751073          	csrw	mtvt,a0

    la      sp, g_top_irqstack
  20:	20001117          	auipc	sp,0x20001
  24:	fe410113          	addi	sp,sp,-28 # 20001004 <uart_instance>

    /* Load data section */
    la      a0, __erodata
  28:	2a400513          	li	a0,676
    la      a1, __data_start__
  2c:	f4018593          	addi	a1,gp,-192 # 20000000 <console_handle>
    la      a2, __data_end__
  30:	00018613          	mv	a2,gp
    bgeu    a1, a2, 2f
  34:	00c5fa63          	bgeu	a1,a2,48 <Reset_Handler+0x48>
1:
    lw      t0, (a0)
  38:	00052283          	lw	t0,0(a0)
    sw      t0, (a1)
  3c:	0055a023          	sw	t0,0(a1)
    addi    a0, a0, 4
  40:	0511                	addi	a0,a0,4
    addi    a1, a1, 4
  42:	0591                	addi	a1,a1,4
    bltu    a1, a2, 1b
  44:	fec5eae3          	bltu	a1,a2,38 <Reset_Handler+0x38>
2:

    /* Clear bss section */
    la      a0, __bss_start__
  48:	f4018513          	addi	a0,gp,-192 # 20000000 <console_handle>
    la      a1, __bss_end__
  4c:	20001597          	auipc	a1,0x20001
  50:	03058593          	addi	a1,a1,48 # 2000107c <__bss_end__>
    bgeu    a0, a1, 2f
  54:	00b57763          	bgeu	a0,a1,62 <Reset_Handler+0x62>
1:
    sw      zero, (a0)
  58:	00052023          	sw	zero,0(a0)
    addi    a0, a0, 4
  5c:	0511                	addi	a0,a0,4
    bltu    a0, a1, 1b
  5e:	feb56de3          	bltu	a0,a1,58 <Reset_Handler+0x58>
2:


    #jal     SystemInit
    jal     board_init
  62:	184000ef          	jal	ra,1e6 <board_init>
    jal     entry
  66:	1a6000ef          	jal	ra,20c <entry>

0000006a <__exit>:

    .size   Reset_Handler, . - Reset_Handler

__exit:
    j      __exit
  6a:	a001                	j	6a <__exit>
	...

00000080 <Default_IRQHandler>:
    .align  2
    .global Default_IRQHandler
    .weak   Default_IRQHandler
    .type   Default_IRQHandler, %function
Default_IRQHandler:
    nop
  80:	0001                	nop
  82:	0001                	nop

00000084 <trap>:
 ******************************************************************************/
    .align  2
    .global trap
    .type   trap, %function
trap:
    nop
  84:	0001                	nop
  86:	00000013          	nop
  8a:	00000013          	nop
  8e:	00000013          	nop
  92:	00000013          	nop
  96:	00000013          	nop
  9a:	00000013          	nop
  9e:	00000013          	nop
  a2:	00000013          	nop
  a6:	00000013          	nop
  aa:	00000013          	nop
  ae:	00000013          	nop
  b2:	00000013          	nop
  b6:	00000013          	nop
  ba:	00000013          	nop
  be:	0001                	nop

000000c0 <Default_Handler>:
    .align  6
    .weak   Default_Handler
    .global Default_Handler
    .type   Default_Handler, %function
Default_Handler:
    j      trap
  c0:	b7d1                	j	84 <trap>
	...

000000fa <fputc>:
{
    return 0;
}

int fputc(int ch, FILE *stream)
{
  fa:	1151                	addi	sp,sp,-12
  fc:	c026                	sw	s1,0(sp)
  fe:	84aa                	mv	s1,a0
    (void)stream;

    if (console_handle == NULL) {
 100:	f401a503          	lw	a0,-192(gp) # 20000000 <console_handle>
{
 104:	c406                	sw	ra,8(sp)
 106:	c222                	sw	s0,4(sp)
    if (console_handle == NULL) {
 108:	c115                	beqz	a0,12c <fputc+0x32>
 10a:	f4018413          	addi	s0,gp,-192 # 20000000 <console_handle>
        return -1;
    }

    if (ch == '\n') {
 10e:	47a9                	li	a5,10
 110:	00f49463          	bne	s1,a5,118 <fputc+0x1e>
        drv_uart_putc(console_handle, '\r');
 114:	45b5                	li	a1,13
 116:	28a5                	jal	18e <drv_uart_putc>
    }

    drv_uart_putc(console_handle, ch);
 118:	4008                	lw	a0,0(s0)
 11a:	0ff4f593          	zext.b	a1,s1
 11e:	2885                	jal	18e <drv_uart_putc>


    return 0;
 120:	4501                	li	a0,0
}
 122:	40a2                	lw	ra,8(sp)
 124:	4412                	lw	s0,4(sp)
 126:	4482                	lw	s1,0(sp)
 128:	0131                	addi	sp,sp,12
 12a:	8082                	ret
        return -1;
 12c:	557d                	li	a0,-1
 12e:	bfd5                	j	122 <fputc+0x28>

00000130 <drv_uart_initialize>:

static uart_priv_t uart_instance[2]; // 2 uarts port [0,1]

extern int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler);

uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
 130:	1111                	addi	sp,sp,-28
 132:	c826                	sw	s1,16(sp)
    uint32_t base;
    uint32_t irq;
    void    *handler;
    uint32_t gpio_base;
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
 134:	0038                	addi	a4,sp,8
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
 136:	84ae                	mv	s1,a1
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
 138:	0054                	addi	a3,sp,4
 13a:	0070                	addi	a2,sp,12
 13c:	858a                	mv	a1,sp
uart_handle_t drv_uart_initialize(int32_t idx, uart_event_cb_t cb_event){
 13e:	ca22                	sw	s0,20(sp)
 140:	cc06                	sw	ra,24(sp)
 142:	842a                	mv	s0,a0
    int32_t ret = target_uart_init(idx, &base, &gpio_base ,&irq, &handler);
 144:	28b1                	jal	1a0 <target_uart_init>

    if(ret < 0) { return 0;}
 146:	02054863          	bltz	a0,176 <drv_uart_initialize+0x46>
    uart_priv_t *uart_priv = &uart_instance[idx];
 14a:	03c00513          	li	a0,60
 14e:	02a40533          	mul	a0,s0,a0
 152:	200017b7          	lui	a5,0x20001
 156:	00478793          	addi	a5,a5,4 # 20001004 <uart_instance>
 15a:	953e                	add	a0,a0,a5
    uart_priv->base = base;
 15c:	4782                	lw	a5,0(sp)
    uart_priv->gpio_base = gpio_base;
    uart_priv->idx  = idx;
 15e:	dd00                	sw	s0,56(a0)
    uart_priv->irq  = irq;
    uart_priv->cb_event  = cb_event;
 160:	c544                	sw	s1,12(a0)
    uart_priv->base = base;
 162:	c11c                	sw	a5,0(a0)
    uart_priv->gpio_base = gpio_base;
 164:	47b2                	lw	a5,12(sp)
 166:	c15c                	sw	a5,4(a0)
    uart_priv->irq  = irq;
 168:	4792                	lw	a5,4(sp)
 16a:	c51c                	sw	a5,8(a0)

    return (uart_handle_t)uart_priv;
}
 16c:	40e2                	lw	ra,24(sp)
 16e:	4452                	lw	s0,20(sp)
 170:	44c2                	lw	s1,16(sp)
 172:	0171                	addi	sp,sp,28
 174:	8082                	ret
    if(ret < 0) { return 0;}
 176:	4501                	li	a0,0
 178:	bfd5                	j	16c <drv_uart_initialize+0x3c>

0000017a <drv_uart_config_baudrate>:


int32_t drv_uart_config_baudrate(uart_handle_t handle, uint32_t baud, uint32_t cfg){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr_uart = (uart_reg_t*) (uart_priv->base);
    gpio_reg_t *addr_gpio = (gpio_reg_t*) (uart_priv->gpio_base);
 17a:	4158                	lw	a4,4(a0)
    uart_reg_t *addr_uart = (uart_reg_t*) (uart_priv->base);
 17c:	411c                	lw	a5,0(a0)

    addr_gpio->DIR = 0x00000001;
 17e:	4685                	li	a3,1
 180:	c754                	sw	a3,12(a4)
    addr_gpio->MUX = 0x0000000F;
 182:	46bd                	li	a3,15
 184:	cb14                	sw	a3,16(a4)
    addr_uart->BAUD = baud;
 186:	c78c                	sw	a1,8(a5)
    addr_uart->CFG  = cfg;
 188:	c3d0                	sw	a2,4(a5)

    return 0;
}
 18a:	4501                	li	a0,0
 18c:	8082                	ret

0000018e <drv_uart_putc>:

int32_t drv_uart_putc(uart_handle_t handle, uint8_t ch){
    uart_priv_t *uart_priv = handle;
    uart_reg_t *addr = (uart_reg_t*) (uart_priv->base);
 18e:	4118                	lw	a4,0(a0)

    uint32_t fifo;
    do { fifo = addr->STS;
      fifo = fifo&0x1F;
    } while (fifo==16);
 190:	46c1                	li	a3,16
    do { fifo = addr->STS;
 192:	475c                	lw	a5,12(a4)
      fifo = fifo&0x1F;
 194:	8bfd                	andi	a5,a5,31
    } while (fifo==16);
 196:	fed78ee3          	beq	a5,a3,192 <drv_uart_putc+0x4>

    addr->DATA = ch;
 19a:	c30c                	sw	a1,0(a4)

    return 0;
}
 19c:	4501                	li	a0,0
 19e:	8082                	ret

000001a0 <target_uart_init>:
    {UART1_BASE, 39/*uart irq1*/, UART1_IRQHandler, GPIO1_BASE},
};

int32_t target_uart_init(int32_t idx, uint32_t *base, uint32_t *gpio_base ,uint32_t *irq, void **handler)
{
    if (base != 0) {
 1a0:	c981                	beqz	a1,1b0 <target_uart_init+0x10>
        *base = sg_uart_config[idx].base;
 1a2:	00451793          	slli	a5,a0,0x4
 1a6:	25000313          	li	t1,592
 1aa:	979a                	add	a5,a5,t1
 1ac:	439c                	lw	a5,0(a5)
 1ae:	c19c                	sw	a5,0(a1)
    }

    if(gpio_base != 0){
 1b0:	ca01                	beqz	a2,1c0 <target_uart_init+0x20>
        *gpio_base = sg_uart_config[idx].gpio_base;
 1b2:	00451793          	slli	a5,a0,0x4
 1b6:	25000593          	li	a1,592
 1ba:	97ae                	add	a5,a5,a1
 1bc:	47dc                	lw	a5,12(a5)
 1be:	c21c                	sw	a5,0(a2)
    }

    if (irq != 0) {
 1c0:	ca81                	beqz	a3,1d0 <target_uart_init+0x30>
        *irq = sg_uart_config[idx].irq;
 1c2:	00451793          	slli	a5,a0,0x4
 1c6:	25000613          	li	a2,592
 1ca:	97b2                	add	a5,a5,a2
 1cc:	43dc                	lw	a5,4(a5)
 1ce:	c29c                	sw	a5,0(a3)
    }

    if (handler != 0) {
 1d0:	cb01                	beqz	a4,1e0 <target_uart_init+0x40>
        *handler = sg_uart_config[idx].handler;
 1d2:	00451793          	slli	a5,a0,0x4
 1d6:	25000693          	li	a3,592
 1da:	97b6                	add	a5,a5,a3
 1dc:	479c                	lw	a5,8(a5)
 1de:	c31c                	sw	a5,0(a4)
    }
    return idx;
}
 1e0:	8082                	ret

000001e2 <UART0_IRQHandler>:
 1e2:	8082                	ret

000001e4 <UART1_IRQHandler>:
 1e4:	8082                	ret

000001e6 <board_init>:
#include "soc.h"

extern uart_handle_t console_handle;

void board_init(void)
{
 1e6:	1151                	addi	sp,sp,-12
    int ret = 0;
    console_handle = drv_uart_initialize(0, NULL);
 1e8:	4581                	li	a1,0
 1ea:	4501                	li	a0,0
{
 1ec:	c406                	sw	ra,8(sp)
    console_handle = drv_uart_initialize(0, NULL);
 1ee:	3789                	jal	130 <drv_uart_initialize>

    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
 1f0:	460d                	li	a2,3
 1f2:	0d900593          	li	a1,217
    console_handle = drv_uart_initialize(0, NULL);
 1f6:	f4a1a023          	sw	a0,-192(gp) # 20000000 <console_handle>
    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
 1fa:	3741                	jal	17a <drv_uart_config_baudrate>

    printf("Boad init UART0 \r\n");

    if(ret < 0 ) { return; }
}
 1fc:	40a2                	lw	ra,8(sp)
    printf("Boad init UART0 \r\n");
 1fe:	27000513          	li	a0,624
}
 202:	0131                	addi	sp,sp,12
    printf("Boad init UART0 \r\n");
 204:	a831                	j	220 <puts>

00000206 <app_init>:
    return 0;
}

void app_init(void){
    //start main thread
    printf("Start Main Thread \r\n");
 206:	28400513          	li	a0,644
 20a:	a819                	j	220 <puts>

0000020c <entry>:
int entry(){
 20c:	1151                	addi	sp,sp,-12
    printf("Entry OS \r\n");
 20e:	29800513          	li	a0,664
int entry(){
 212:	c406                	sw	ra,8(sp)
    printf("Entry OS \r\n");
 214:	2031                	jal	220 <puts>
    app_init();
 216:	3fc5                	jal	206 <app_init>
}
 218:	40a2                	lw	ra,8(sp)
 21a:	4501                	li	a0,0
 21c:	0131                	addi	sp,sp,12
 21e:	8082                	ret

00000220 <puts>:
 220:	1151                	addi	sp,sp,-12
 222:	c222                	sw	s0,4(sp)
 224:	c406                	sw	ra,8(sp)
 226:	842a                	mv	s0,a0
 228:	00044503          	lbu	a0,0(s0)
 22c:	55fd                	li	a1,-1
 22e:	e901                	bnez	a0,23e <puts+0x1e>
 230:	4529                	li	a0,10
 232:	35e1                	jal	fa <fputc>
 234:	40a2                	lw	ra,8(sp)
 236:	4412                	lw	s0,4(sp)
 238:	4501                	li	a0,0
 23a:	0131                	addi	sp,sp,12
 23c:	8082                	ret
 23e:	3d75                	jal	fa <fputc>
 240:	0405                	addi	s0,s0,1
 242:	b7dd                	j	228 <puts+0x8>
	...
