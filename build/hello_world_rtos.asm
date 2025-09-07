
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
  24:	ff010113          	addi	sp,sp,-16 # 20001010 <uart_instance>

    /* Load data section */
    la      a0, __erodata
  28:	30c00513          	li	a0,780
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
  50:	0fc58593          	addi	a1,a1,252 # 20001148 <__bss_end__>
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

    jal     system_init
  62:	180000ef          	jal	ra,1e2 <system_init>
    jal     board_init
  66:	1ec000ef          	jal	ra,252 <board_init>
    jal     entry
  6a:	20e000ef          	jal	ra,278 <entry>

0000006e <__exit>:

    .size   Reset_Handler, . - Reset_Handler

__exit:
    j      __exit
  6e:	a001                	j	6e <__exit>
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
 156:	01078793          	addi	a5,a5,16 # 20001010 <uart_instance>
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
 1a6:	2b000313          	li	t1,688
 1aa:	979a                	add	a5,a5,t1
 1ac:	439c                	lw	a5,0(a5)
 1ae:	c19c                	sw	a5,0(a1)
    }

    if(gpio_base != 0){
 1b0:	ca01                	beqz	a2,1c0 <target_uart_init+0x20>
        *gpio_base = sg_uart_config[idx].gpio_base;
 1b2:	00451793          	slli	a5,a0,0x4
 1b6:	2b000593          	li	a1,688
 1ba:	97ae                	add	a5,a5,a1
 1bc:	47dc                	lw	a5,12(a5)
 1be:	c21c                	sw	a5,0(a2)
    }

    if (irq != 0) {
 1c0:	ca81                	beqz	a3,1d0 <target_uart_init+0x30>
        *irq = sg_uart_config[idx].irq;
 1c2:	00451793          	slli	a5,a0,0x4
 1c6:	2b000613          	li	a2,688
 1ca:	97b2                	add	a5,a5,a2
 1cc:	43dc                	lw	a5,4(a5)
 1ce:	c29c                	sw	a5,0(a3)
    }

    if (handler != 0) {
 1d0:	cb01                	beqz	a4,1e0 <target_uart_init+0x40>
        *handler = sg_uart_config[idx].handler;
 1d2:	00451793          	slli	a5,a0,0x4
 1d6:	2b000693          	li	a3,688
 1da:	97b6                	add	a5,a5,a3
 1dc:	479c                	lw	a5,8(a5)
 1de:	c31c                	sw	a5,0(a4)
    }
    return idx;
}
 1e0:	8082                	ret

000001e2 <system_init>:

    //config core timer
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
}

void system_init(void){
 1e2:	1151                	addi	sp,sp,-12
 1e4:	c406                	sw	ra,8(sp)
    //config core local interrupt controller
    //CLIC->CLICCFG = 0x4UL;

    //set interrupt pendding
    for (int i = 0; i < 12; i++) {
 1e6:	4701                	li	a4,0
        CLIC->INT[i].CLICINTIP = 0;
 1e8:	e0800637          	lui	a2,0xe0800
    for (int i = 0; i < 12; i++) {
 1ec:	46b1                	li	a3,12
        CLIC->INT[i].CLICINTIP = 0;
 1ee:	40070793          	addi	a5,a4,1024
 1f2:	078a                	slli	a5,a5,0x2
 1f4:	97b2                	add	a5,a5,a2
 1f6:	00078023          	sb	zero,0(a5)
    for (int i = 0; i < 12; i++) {
 1fa:	0705                	addi	a4,a4,1
 1fc:	fed719e3          	bne	a4,a3,1ee <system_init+0xc>
    }
    drv_irq_enable(MACH_SOFT_IRQn); //enable machine software interrupt
 200:	450d                	li	a0,3
 202:	20b9                	jal	250 <drv_irq_enable>
    irq_vectors_init();
 204:	2029                	jal	20e <irq_vectors_init>
    _system_init_for_kernel();      //setting default interrupt and core timer interrupt
}
 206:	40a2                	lw	ra,8(sp)
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
 208:	451d                	li	a0,7
}
 20a:	0131                	addi	sp,sp,12
    drv_irq_enable(CORET_IRQn); //enable core timer interrupt
 20c:	a091                	j	250 <drv_irq_enable>

0000020e <irq_vectors_init>:
extern void CORET_IRQHandler(void);

void (*g_irqvector[48])(void);

void irq_vectors_init(void){
    for (int i = 0; i < 48; i++) {
 20e:	20001737          	lui	a4,0x20001
 212:	08870793          	addi	a5,a4,136 # 20001088 <g_irqvector>
        g_irqvector[i] = Default_Handler;
 216:	0c078613          	addi	a2,a5,192
 21a:	08870713          	addi	a4,a4,136
 21e:	0c000693          	li	a3,192
 222:	c394                	sw	a3,0(a5)
    for (int i = 0; i < 48; i++) {
 224:	0791                	addi	a5,a5,4
 226:	fec79ee3          	bne	a5,a2,222 <irq_vectors_init+0x14>
    }
    g_irqvector[CORET_IRQn] = CORET_IRQHandler;
 22a:	23200793          	li	a5,562
 22e:	cf5c                	sw	a5,28(a4)
}
 230:	8082                	ret

00000232 <CORET_IRQHandler>:
extern void systick_handler(void);

#define  ATTRIBUTE_ISR

ATTRIBUTE_ISR void CORET_IRQHandler(void){
    systick_handler();
 232:	a019                	j	238 <systick_handler>

00000234 <UART0_IRQHandler>:
 234:	8082                	ret

00000236 <UART1_IRQHandler>:
 236:	8082                	ret

00000238 <systick_handler>:
#include "../include/soc.h"

uint64_t g_sys_tick_count;
void systick_handler(void){
    g_sys_tick_count++;
 238:	f4818793          	addi	a5,gp,-184 # 20000008 <g_sys_tick_count>
 23c:	4398                	lw	a4,0(a5)
 23e:	43d0                	lw	a2,4(a5)
 240:	00170693          	addi	a3,a4,1
 244:	00e6b733          	sltu	a4,a3,a4
 248:	9732                	add	a4,a4,a2
 24a:	c394                	sw	a3,0(a5)
 24c:	c3d8                	sw	a4,4(a5)
}
 24e:	8082                	ret

00000250 <drv_irq_enable>:
extern void Default_Handler(void);
extern void (*g_irqvector[])(void);

void drv_irq_enable (uint32_t irq_num){
    vic_enable_irq(irq_num);
}
 250:	8082                	ret

00000252 <board_init>:
#include "../driver/include/soc.h"

extern uart_handle_t console_handle;

void board_init(void)
{
 252:	1151                	addi	sp,sp,-12
    int ret = 0;
    console_handle = drv_uart_initialize(0, NULL);
 254:	4581                	li	a1,0
 256:	4501                	li	a0,0
{
 258:	c406                	sw	ra,8(sp)
    console_handle = drv_uart_initialize(0, NULL);
 25a:	3dd9                	jal	130 <drv_uart_initialize>

    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
 25c:	460d                	li	a2,3
 25e:	0d900593          	li	a1,217
    console_handle = drv_uart_initialize(0, NULL);
 262:	f4a1a023          	sw	a0,-192(gp) # 20000000 <console_handle>
    ret = drv_uart_config_baudrate(console_handle, 217, (UTX_START | URX_START ));
 266:	3f11                	jal	17a <drv_uart_config_baudrate>

    printf("boad init console uart0 \r\n");

    if(ret < 0 ) { return; }
}
 268:	40a2                	lw	ra,8(sp)
    printf("boad init console uart0 \r\n");
 26a:	2d000513          	li	a0,720
}
 26e:	0131                	addi	sp,sp,12
    printf("boad init console uart0 \r\n");
 270:	a831                	j	28c <puts>

00000272 <app_init>:
    return 0;
}

void app_init(void){
    //start main thread
    printf("Start Main Thread \r\n");
 272:	2ec00513          	li	a0,748
 276:	a819                	j	28c <puts>

00000278 <entry>:
int entry(){
 278:	1151                	addi	sp,sp,-12
    printf("Entry OS \r\n");
 27a:	30000513          	li	a0,768
int entry(){
 27e:	c406                	sw	ra,8(sp)
    printf("Entry OS \r\n");
 280:	2031                	jal	28c <puts>
    app_init();
 282:	3fc5                	jal	272 <app_init>
}
 284:	40a2                	lw	ra,8(sp)
 286:	4501                	li	a0,0
 288:	0131                	addi	sp,sp,12
 28a:	8082                	ret

0000028c <puts>:
 28c:	1151                	addi	sp,sp,-12
 28e:	c222                	sw	s0,4(sp)
 290:	c406                	sw	ra,8(sp)
 292:	842a                	mv	s0,a0
 294:	00044503          	lbu	a0,0(s0)
 298:	55fd                	li	a1,-1
 29a:	e901                	bnez	a0,2aa <puts+0x1e>
 29c:	4529                	li	a0,10
 29e:	3db1                	jal	fa <fputc>
 2a0:	40a2                	lw	ra,8(sp)
 2a2:	4412                	lw	s0,4(sp)
 2a4:	4501                	li	a0,0
 2a6:	0131                	addi	sp,sp,12
 2a8:	8082                	ret
 2aa:	3d81                	jal	fa <fputc>
 2ac:	0405                	addi	s0,s0,1
 2ae:	b7dd                	j	294 <puts+0x8>
