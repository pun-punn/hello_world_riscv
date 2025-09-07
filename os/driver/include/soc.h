#define boot

#ifndef SOC_H
#define SOC_H

//#include "core.h"

#define   _I     volatile const
#define   _O     volatile
#define   _IO    volatile

// -------------- AHB -------------------

#define BOOT_DATA        (int*)0x00100000
#define BOOT_BASE        (int*)0x00200000

#define SYS_BASE         0x30000000
#define DMA_BASE         0x31000000
#define HDMI_BASE        0x32000000
#define SDC_BASE         0x33000000

// ------------ For Sim -----------------

// Write anything to 0x30001000 will end sim
typedef struct
{
	_IO  int        END;
	
} SIM_TypeDef;

#define SIMULATION      ((SIM_TypeDef*) (SYS_BASE+0x1000))

// -------------- APB -------------------

#define UART0_BASE       0x50000000
#define UART1_BASE       0x50010000
#define TIMER0_BASE      0x50300000
#define TIMER1_BASE      0x50310000
#define TIMER2_BASE      0x50320000
#define TIMER3_BASE      0x50330000
#define TIMER4_BASE      0x50340000
#define GPIO0_BASE       0x50400000
#define GPIO1_BASE       0x50410000

 // ----------- UART CFG ------------------

#define U_NO_PAR         0b00_000000<<8
#define U_EV_PAR         0b10_000000<<8
#define U_OD_PAR         0b11_000000<<8

#define URX_DMA_FULL     0b00_00_0000<<8
#define URX_DMA_HALF     0b00_10_0000<<8
#define URX_DMA_NEMPTY   0b00_11_0000<<8

#define UTX_DMA_EMPTY    0b0000_00_00<<8
#define UTX_DMA_ALMOST   0b0000_10_00<<8
#define UTX_DMA_HALF     0b0000_11_00<<8

#define URX_INT_FULL     0b000000_00<<8
#define URX_INT_HALF     0b000000_10<<8
#define URX_INT_NEMPTY   0b000000_11<<8

#define UTX_INT_EMPTY    0b00_000000
#define UTX_INT_ALMOST   0b10_000000
#define UTX_INT_HALF     0b11_000000

#define URX_DMA_EN       0b00100000
#define UTX_DMA_EN       0b00010000
#define URX_INT_EN       0b00001000
#define UTX_INT_EN       0b00000100
#define URX_START        0b00000010
#define UTX_START        0b00000001

#define URX_INT_CHAR     0b0000_0001<<24
#define URX_DMA_CHAR     0b0000_0010<<24

// ----------- UART STS ------------------

#define URX_PAR_ERR      0b10000000<<16
#define URX_DMA_STS      0b01000000<<16
#define URX_INT_STS      0b00100000<<16
#define URX_SIZE         0b00011111<<16

#define UTX_DMA_STS      0b01000000
#define UTX_INT_STS      0b00100000
#define UTX_SIZE         0b00011111


// -------- TIMER CFG ---------------

#define TIMER_PRESCALE_1   0x00<<4
#define TIMER_PRESCALE_2   0x01<<4
#define TIMER_PRESCALE_4   0x02<<4
#define TIMER_PRESCALE_8   0x03<<4
#define TIMER_PRESCALE_16  0x04<<4
#define TIMER_PRESCALE_32  0x05<<4
#define TIMER_PRESCALE_64  0x06<<4
#define TIMER_PRESCALE_128 0x07<<4

#define TIMER_O_PULSE      0x00<<7
#define TIMER_O_TOGGLE     0x01<<7

#define TIMER_EN           0x01
#define TIMER_RELOAD       0x02
#define TIMER_INT_EN       0x04
#define TIMER_DMA_EN       0x08

#define TIMER_INT_CLR      0x01


// -------- GPIO INT ---------------

#define GPIO_RISE       0b0100
#define GPIO_FALL       0b0101
#define GPIO_TOG        0b0110    

// -------------------------------------------------------------


/*********************************************************************************/
/*                              RISC-V MTIME Interrupt                           */
/*********************************************************************************/

#define CLINT_BASE      0xE0000000
#define CLINT_MTIMECMP  (CLINT_BASE + 0x004000)  // Machine Timer Compare
#define CLINT_MTIME     (CLINT_BASE + 0x00BFF8)  // Machine Timer
#define CLINT_MTIMEINT  (CLINT_BASE + 0x80101C)  // Machine Timer Setting 

												   // 0x800000+((16+16)*4)=0x80
#define CLINT_APB_TIMEINT (CLINT_BASE + 0x801080)  // APB Timer Setting EXT16


#endif //SOC_H
