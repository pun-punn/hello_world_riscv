#define boot

#ifndef SOC_H
#define SOC_H

#include "../../core/core.h"

typedef enum irqn {
	USER_SOFT_IRQn  =   0,      /* User software interrupt */
	SUPER_SOFT_IRQn =   1,      /* Supervisor software interrupt */
	MACH_SOFT_IRQn  =   3,      /* Machine software interrupt */
	USER_TIM_IRQn   =   4,      /* User timer interrupt */
	SUPER_TIM_IRQn  =   5,      /* Supervisor timer interrupt */
	CORET_IRQn      =   7,      /* core Timer Interrupt */
	TIM0_IRQn       =   32,     /* timer0 Interrupt */
	TIM1_IRQn       =   33,     /* timer1 Interrupt */
	TIM2_IRQn       =   34,     /* timer2 Interrupt */
	TIM3_IRQn       =   35,     /* timer3 Interrupt */
	TIM4_IRQn       =   36,     /* timer4 Interrupt */
	UART0_IRQn      =   37,     /* uart0 Interrupt */
	UART1_IRQn      =   39,     /* uart1 Interrupt */
} irqn_t;


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
	_IO  uint32_t END;
	
} SIM_TypeDef;

#define SIMULATION      ((SIM_TypeDef*) (0x3F000000 + 0x1000))
//#define SIMULATION      ((SIM_TypeDef*) (SYS_BASE+0x1000))

/* -------------------- Peripheral memory map -------------------- */
/* --- SoC Configuration Base Address --- */
#define SOC_BASE                        (0x30000000UL)

/* --- Global Peripheral Base Address --- */
#define PERIPH_BASE                     (0x50000000UL)

/* --- Specific Peripheral Base Addresses (Relative to PERIPH_BASE) --- */
#define UART0_BASE                      (PERIPH_BASE + 0x00000000UL) /* 0x50000000 */
#define UART1_BASE                      (PERIPH_BASE + 0x00010000UL) /* 0x50010000 */
#define SPI_BASE                        (PERIPH_BASE + 0x00100000UL) /* 0x50100000 */
#define I2C_BASE                        (PERIPH_BASE + 0x00200000UL) /* 0x50200000 */
#define TIM0_BASE                       (PERIPH_BASE + 0x00300000UL) /* 0x50300000 */
#define TIM1_BASE                       (PERIPH_BASE + 0x00310000UL) /* 0x50310000 */
#define TIM2_BASE                       (PERIPH_BASE + 0x00320000UL) /* 0x50320000 */
#define TIM3_BASE                       (PERIPH_BASE + 0x00330000UL) /* 0x50330000 */
#define TIM4_BASE                       (PERIPH_BASE + 0x00340000UL) /* 0x50340000 */
#define GPIO0_BASE                      (PERIPH_BASE + 0x00400000UL) /* 0x50400000 */

/* ------ SOC Clock Configuration register (SOC_CLK) Macros ------ */
#define SOC_CLK_PLLLOCK_Pos             (3U)
#define SOC_CLK_PLLLOCK                 (1U << SOC_CLK_PLLLOCK_Pos)
#define SOC_CLK_CLKSRC_Pos              (2U)
#define SOC_CLK_CLKSRC                  (1U << SOC_CLK_CLKSRC_Pos)
#define SOC_CLK_CLKSEL_Pos              (0U)
#define SOC_CLK_CLKSEL                  (0x3U << SOC_CLK_CLKSEL_Pos)

#define SOC_CLK_CLKSRC_OSCILLATOR       (0x0U << SOC_CLK_CLKSRC_Pos)
#define SOC_CLK_CLKSRC_PLL              (0x1U << SOC_CLK_CLKSRC_Pos)
#define SOC_CLK_CLKSEL_DIV8             (0x0U << SOC_CLK_CLKSEL_Pos)
#define SOC_CLK_CLKSEL_DIV4             (0x1U << SOC_CLK_CLKSEL_Pos)
#define SOC_CLK_CLKSEL_DIV2             (0x2U << SOC_CLK_CLKSEL_Pos)

/* ------ SOC Clock Configuration register (SOC_CLKEN) Macros ------ */
#define SOC_CLKEN_RAM_Pos               (0U)
#define SOC_CLKEN_RAM                   (1U << SOC_CLKEN_RAM_Pos)
#define SOC_CLKEN_TIM0_Pos              (16U)
#define SOC_CLKEN_TIM0                  (1U << SOC_CLKEN_TIM0_Pos)
#define SOC_CLKEN_TIM1_Pos              (17U)
#define SOC_CLKEN_TIM1                  (1U << SOC_CLKEN_TIM1_Pos)
#define SOC_CLKEN_TIM2_Pos              (18U)
#define SOC_CLKEN_TIM2                  (1U << SOC_CLKEN_TIM2_Pos)
#define SOC_CLKEN_TIM3_Pos              (19U)
#define SOC_CLKEN_TIM3                  (1U << SOC_CLKEN_TIM3_Pos)
#define SOC_CLKEN_TIM4_Pos              (20U)
#define SOC_CLKEN_TIM4                  (1U << SOC_CLKEN_TIM4_Pos)
#define SOC_CLKEN_UART0_Pos             (21U)
#define SOC_CLKEN_UART0                 (1U << SOC_CLKEN_UART0_Pos)
#define SOC_CLKEN_UART1_Pos             (22U)
#define SOC_CLKEN_UART1                 (1U << SOC_CLKEN_UART1_Pos)
#define SOC_CLKEN_GPIO0_Pos             (25U)
#define SOC_CLKEN_GPIO0                 (1U << SOC_CLKEN_GPIO0_Pos)
#define SOC_CLKEN_I2C_Pos               (28U)
#define SOC_CLKEN_I2C                   (1U << SOC_CLKEN_I2C_Pos)
#define SOC_CLKEN_SPI_Pos               (29U)
#define SOC_CLKEN_SPI                   (1U << SOC_CLKEN_SPI_Pos)

/* ------ SOC Input/Output direction register (SOC_IODIR) Macros ------ */
#define SOC_IODIR_IODIR0_Pos            (0U)
#define SOC_IODIR_IODIR0                (1U << SOC_IODIR_IODIR0_Pos)
#define SOC_IODIR_IODIR1_Pos            (1U)
#define SOC_IODIR_IODIR1                (1U << SOC_IODIR_IODIR1_Pos)
#define SOC_IODIR_IODIR2_Pos            (2U)
#define SOC_IODIR_IODIR2                (1U << SOC_IODIR_IODIR2_Pos)
#define SOC_IODIR_IODIR3_Pos            (3U)
#define SOC_IODIR_IODIR3                (1U << SOC_IODIR_IODIR3_Pos)
#define SOC_IODIR_IODIR4_Pos            (4U)
#define SOC_IODIR_IODIR4                (1U << SOC_IODIR_IODIR4_Pos)
#define SOC_IODIR_IODIR5_Pos            (5U)
#define SOC_IODIR_IODIR5                (1U << SOC_IODIR_IODIR5_Pos)
#define SOC_IODIR_IODIR6_Pos            (6U)
#define SOC_IODIR_IODIR6                (1U << SOC_IODIR_IODIR6_Pos)
#define SOC_IODIR_IODIR7_Pos            (7U)
#define SOC_IODIR_IODIR7                (1U << SOC_IODIR_IODIR7_Pos)
#define SOC_IODIR_IODIR8_Pos            (8U)
#define SOC_IODIR_IODIR8                (1U << SOC_IODIR_IODIR8_Pos)
#define SOC_IODIR_IODIR9_Pos            (9U)
#define SOC_IODIR_IODIR9                (1U << SOC_IODIR_IODIR9_Pos)
#define SOC_IODIR_IODIR10_Pos           (10U)
#define SOC_IODIR_IODIR10               (1U << SOC_IODIR_IODIR10_Pos)
#define SOC_IODIR_IODIR11_Pos           (11U)
#define SOC_IODIR_IODIR11               (1U << SOC_IODIR_IODIR11_Pos)
#define SOC_IODIR_IODIR12_Pos           (12U)
#define SOC_IODIR_IODIR12               (1U << SOC_IODIR_IODIR12_Pos)
#define SOC_IODIR_IODIR13_Pos           (13U)
#define SOC_IODIR_IODIR13               (1U << SOC_IODIR_IODIR13_Pos)
#define SOC_IODIR_IODIR14_Pos           (14U)
#define SOC_IODIR_IODIR14               (1U << SOC_IODIR_IODIR14_Pos)
#define SOC_IODIR_IODIR15_Pos           (15U)
#define SOC_IODIR_IODIR15               (1U << SOC_IODIR_IODIR15_Pos)
#define SOC_IODIR_IODIR16_Pos           (16U)
#define SOC_IODIR_IODIR16               (1U << SOC_IODIR_IODIR16_Pos)
#define SOC_IODIR_IODIR17_Pos           (17U)
#define SOC_IODIR_IODIR17               (1U << SOC_IODIR_IODIR17_Pos)
#define SOC_IODIR_IODIR18_Pos           (18U)
#define SOC_IODIR_IODIR18               (1U << SOC_IODIR_IODIR18_Pos)
#define SOC_IODIR_IODIR19_Pos           (19U)
#define SOC_IODIR_IODIR19               (1U << SOC_IODIR_IODIR19_Pos)
#define SOC_IODIR_IODIR20_Pos           (20U)
#define SOC_IODIR_IODIR20               (1U << SOC_IODIR_IODIR20_Pos)
#define SOC_IODIR_IODIR21_Pos           (21U)
#define SOC_IODIR_IODIR21               (1U << SOC_IODIR_IODIR21_Pos)
#define SOC_IODIR_IODIR22_Pos           (22U)
#define SOC_IODIR_IODIR22               (1U << SOC_IODIR_IODIR22_Pos)
#define SOC_IODIR_IODIR23_Pos           (23U)
#define SOC_IODIR_IODIR23               (1U << SOC_IODIR_IODIR23_Pos)
#define SOC_IODIR_IODIR24_Pos           (24U)
#define SOC_IODIR_IODIR24               (1U << SOC_IODIR_IODIR24_Pos)
#define SOC_IODIR_IODIR25_Pos           (25U)
#define SOC_IODIR_IODIR25               (1U << SOC_IODIR_IODIR25_Pos)
#define SOC_IODIR_IODIR26_Pos           (26U)
#define SOC_IODIR_IODIR26               (1U << SOC_IODIR_IODIR26_Pos)
#define SOC_IODIR_IODIR27_Pos           (27U)
#define SOC_IODIR_IODIR27               (1U << SOC_IODIR_IODIR27_Pos)
#define SOC_IODIR_IODIR28_Pos           (28U)
#define SOC_IODIR_IODIR28               (1U << SOC_IODIR_IODIR28_Pos)
#define SOC_IODIR_IODIR29_Pos           (29U)
#define SOC_IODIR_IODIR29               (1U << SOC_IODIR_IODIR29_Pos)
#define SOC_IODIR_IODIR30_Pos           (30U)
#define SOC_IODIR_IODIR30               (1U << SOC_IODIR_IODIR30_Pos)
#define SOC_IODIR_IODIR31_Pos           (31U)
#define SOC_IODIR_IODIR31               (1U << SOC_IODIR_IODIR31_Pos)

/* ------ SOC Input/Output multiplexer register (SOC_IOMUX) Macros ------ */
#define SOC_IOMUX_IOMUX0_Pos            (0U)
#define SOC_IOMUX_IOMUX0                (1U << SOC_IOMUX_IOMUX0_Pos)
#define SOC_IOMUX_IOMUX1_Pos            (1U)
#define SOC_IOMUX_IOMUX1                (1U << SOC_IOMUX_IOMUX1_Pos)
#define SOC_IOMUX_IOMUX2_Pos            (2U)
#define SOC_IOMUX_IOMUX2                (1U << SOC_IOMUX_IOMUX2_Pos)
#define SOC_IOMUX_IOMUX3_Pos            (3U)
#define SOC_IOMUX_IOMUX3                (1U << SOC_IOMUX_IOMUX3_Pos)
#define SOC_IOMUX_IOMUX4_Pos            (4U)
#define SOC_IOMUX_IOMUX4                (1U << SOC_IOMUX_IOMUX4_Pos)
#define SOC_IOMUX_IOMUX5_Pos            (5U)
#define SOC_IOMUX_IOMUX5                (1U << SOC_IOMUX_IOMUX5_Pos)
#define SOC_IOMUX_IOMUX6_Pos            (6U)
#define SOC_IOMUX_IOMUX6                (1U << SOC_IOMUX_IOMUX6_Pos)
#define SOC_IOMUX_IOMUX7_Pos            (7U)
#define SOC_IOMUX_IOMUX7                (1U << SOC_IOMUX_IOMUX7_Pos)
#define SOC_IOMUX_IOMUX8_Pos            (8U)
#define SOC_IOMUX_IOMUX8                (1U << SOC_IOMUX_IOMUX8_Pos)
#define SOC_IOMUX_IOMUX9_Pos            (9U)
#define SOC_IOMUX_IOMUX9                (1U << SOC_IOMUX_IOMUX9_Pos)
#define SOC_IOMUX_IOMUX10_Pos           (10U)
#define SOC_IOMUX_IOMUX10               (1U << SOC_IOMUX_IOMUX10_Pos)
#define SOC_IOMUX_IOMUX11_Pos           (11U)
#define SOC_IOMUX_IOMUX11               (1U << SOC_IOMUX_IOMUX11_Pos)
#define SOC_IOMUX_IOMUX12_Pos           (12U)
#define SOC_IOMUX_IOMUX12               (1U << SOC_IOMUX_IOMUX12_Pos)
#define SOC_IOMUX_IOMUX13_Pos           (13U)
#define SOC_IOMUX_IOMUX13               (1U << SOC_IOMUX_IOMUX13_Pos)
#define SOC_IOMUX_IOMUX14_Pos           (14U)
#define SOC_IOMUX_IOMUX14               (1U << SOC_IOMUX_IOMUX14_Pos)
#define SOC_IOMUX_IOMUX15_Pos           (15U)
#define SOC_IOMUX_IOMUX15               (1U << SOC_IOMUX_IOMUX15_Pos)
#define SOC_IOMUX_IOMUX16_Pos           (16U)
#define SOC_IOMUX_IOMUX16               (1U << SOC_IOMUX_IOMUX16_Pos)
#define SOC_IOMUX_IOMUX17_Pos           (17U)
#define SOC_IOMUX_IOMUX17               (1U << SOC_IOMUX_IOMUX17_Pos)
#define SOC_IOMUX_IOMUX18_Pos           (18U)
#define SOC_IOMUX_IOMUX18               (1U << SOC_IOMUX_IOMUX18_Pos)
#define SOC_IOMUX_IOMUX19_Pos           (19U)
#define SOC_IOMUX_IOMUX19               (1U << SOC_IOMUX_IOMUX19_Pos)
#define SOC_IOMUX_IOMUX20_Pos           (20U)
#define SOC_IOMUX_IOMUX20               (1U << SOC_IOMUX_IOMUX20_Pos)
#define SOC_IOMUX_IOMUX21_Pos           (21U)
#define SOC_IOMUX_IOMUX21               (1U << SOC_IOMUX_IOMUX21_Pos)
#define SOC_IOMUX_IOMUX22_Pos           (22U)
#define SOC_IOMUX_IOMUX22               (1U << SOC_IOMUX_IOMUX22_Pos)
#define SOC_IOMUX_IOMUX23_Pos           (23U)
#define SOC_IOMUX_IOMUX23               (1U << SOC_IOMUX_IOMUX23_Pos)
#define SOC_IOMUX_IOMUX24_Pos           (24U)
#define SOC_IOMUX_IOMUX24               (1U << SOC_IOMUX_IOMUX24_Pos)
#define SOC_IOMUX_IOMUX25_Pos           (25U)
#define SOC_IOMUX_IOMUX25               (1U << SOC_IOMUX_IOMUX25_Pos)
#define SOC_IOMUX_IOMUX26_Pos           (26U)
#define SOC_IOMUX_IOMUX26               (1U << SOC_IOMUX_IOMUX26_Pos)
#define SOC_IOMUX_IOMUX27_Pos           (27U)
#define SOC_IOMUX_IOMUX27               (1U << SOC_IOMUX_IOMUX27_Pos)
#define SOC_IOMUX_IOMUX28_Pos           (28U)
#define SOC_IOMUX_IOMUX28               (1U << SOC_IOMUX_IOMUX28_Pos)
#define SOC_IOMUX_IOMUX29_Pos           (29U)
#define SOC_IOMUX_IOMUX29               (1U << SOC_IOMUX_IOMUX29_Pos)
#define SOC_IOMUX_IOMUX30_Pos           (30U)
#define SOC_IOMUX_IOMUX30               (1U << SOC_IOMUX_IOMUX30_Pos)
#define SOC_IOMUX_IOMUX31_Pos           (31U)
#define SOC_IOMUX_IOMUX31


/* ------ UART data register (UART_DATA) Macros ------ */
#define UART_DATA_DATA_Pos              (0U)
#define UART_DATA_DATA                  (0xFFU << UART_DATA_DATA_Pos)

#define UART_CFG_RXINTCHAREN_Pos        (24U)
#define UART_CFG_RXINTCHAREN            (1U << UART_CFG_RXINTCHAREN_Pos)
#define UART_CFG_RXCHAR_Pos             (16U)
#define UART_CFG_RXCHAR                 (0xFFU << UART_CFG_RXCHAR_Pos)
#define UART_CFG_PARITY_Pos             (14U)
#define UART_CFG_RXINTEVENT_Pos         (8U)
#define UART_CFG_RXINTEVENT             (3U << UART_CFG_RXINTEVENT_Pos)
#define UART_CFG_TXINTEVENT_Pos         (6U)
#define UART_CFG_TXINTEVENT             (3U << UART_CFG_TXINTEVENT_Pos)
#define UART_CFG_RXINTEN_Pos            (3U)
#define UART_CFG_RXINTEN                (1U << UART_CFG_RXINTEN_Pos)
#define UART_CFG_TXINTEN_Pos            (2U)
#define UART_CFG_TXINTEN                (1U << UART_CFG_TXINTEN_Pos)
#define UART_CFG_RXSTART_Pos            (1U)
#define UART_CFG_RXSTART                (1U << UART_CFG_RXSTART_Pos)
#define UART_CFG_TXSTART_Pos            (0U)
#define UART_CFG_TXSTART                (1U << UART_CFG_TXSTART_Pos)

#define UART_CFG_RXINTEVENT_NOTEMPTY    (3U << UART_CFG_RXINTEVENT_Pos)
#define UART_CFG_RXINTEVENT_HALF        (2U << UART_CFG_RXINTEVENT_Pos)
#define UART_CFG_RXINTEVENT_FULL        (0U << UART_CFG_RXINTEVENT_Pos)

#define UART_CFG_TXINTEVENT_HALF        (3U << UART_CFG_TXINTEVENT_Pos)
#define UART_CFG_TXINTEVENT_ALMOSTEMPTY (2U << UART_CFG_TXINTEVENT_Pos)
#define UART_CFG_TXINTEVENT_EMPTY       (0U << UART_CFG_TXINTEVENT_Pos)

#define UART_CFG_PARITY                 (0x3U << UART_CFG_PARITY_Pos)
#define UART_CFG_PARITY_NONE            (0x0U << UART_CFG_PARITY_Pos) /* 00: No parity bit */
#define UART_CFG_PARITY_EVEN            (0x2U << UART_CFG_PARITY_Pos) /* 10: Even parity bit */
#define UART_CFG_PARITY_ODD             (0x3U << UART_CFG_PARITY_Pos) /* 11: Odd parity bit */

/* ------ UART baud rate register (UART_BAUD) Macros ------ */
#define UART_BAUD_RATE_Pos              (0U)
#define UART_BAUD_RATE                  (0xFFFFFFU << UART_BAUD_RATE_Pos)

/* ------ UART status register (UART_STS) Macros ------ */
#define UART_STS_RXPARERR_Pos           (23U)
#define UART_STS_RXPARERR               (1U << UART_STS_RXPARERR_Pos)
#define UART_STS_RXINTSTS_Pos           (21U)
#define UART_STS_RXINTSTS               (1U << UART_STS_RXINTSTS_Pos)
#define UART_STS_RXDATASIZE_Pos         (16U)
#define UART_STS_RXDATASIZE             (0x1FU << UART_STS_RXDATASIZE_Pos)
#define UART_STS_TXINTSTS_Pos           (4U)
#define UART_STS_TXINTSTS               (1U << UART_STS_TXINTSTS_Pos)
#define UART_STS_TXDATASIZE_Pos         (0U)
#define UART_STS_TXDATASIZE             (0x1FU << UART_STS_TXDATASIZE_Pos)


/* ------ TIM counter start value register (TIM_BASE) Macros ------ */
#define TIM_BASE_Pos                    (0U)
#define TIM_BASE                        (0xFFFFFFFF << TIM_BASE_Pos)

/* ------ TIM counter value register (TIM_CNT) Macros ------ */
#define TIM_CNT_Pos                     (0U)
#define TIM_CNT                         (0xFFFFFFFF << TIM_CNT_Pos)

/* ------ TIM configuration register (TIM_CFG) Macros ------ */
#define TIM_CFG_OTYPE_Pos               (7U)
#define TIM_CFG_OTYPE                   (1U << TIM_CFG_OTYPE_Pos)
#define TIM_CFG_PRESCALE_Pos            (4U)
#define TIM_CFG_PRESCALE                (0x7U << TIM_CFG_PRESCALE_Pos)
#define TIM_CFG_OVFINT_Pos              (2U)
#define TIM_CFG_OVFINT                  (1U << TIM_CFG_OVFINT_Pos)
#define TIM_CFG_RELOAD_Pos              (1U)
#define TIM_CFG_RELOAD                  (1U << TIM_CFG_RELOAD_Pos)
#define TIM_CFG_EN_Pos                  (0U)
#define TIM_CFG_EN                      (1U << TIM_CFG_EN_Pos)

#define TIM_CFG_OTYPE_PULSE             (0U << TIM_CFG_OTYPE_Pos) /* 0: Pulse generated at overflow (default) */
#define TIM_CFG_OTYPE_TOGGLE            (1U << TIM_CFG_OTYPE_Pos) /* 1: Status toggles at overflow */

#define TIM_CFG_PRESCALE_DIV1           (0x0U << TIM_CFG_PRESCALE_Pos) /* 000: 1 */
#define TIM_CFG_PRESCALE_DIV2           (0x1U << TIM_CFG_PRESCALE_Pos) /* 001: 2 */
#define TIM_CFG_PRESCALE_DIV4           (0x2U << TIM_CFG_PRESCALE_Pos) /* 010: 4 */
#define TIM_CFG_PRESCALE_DIV8           (0x3U << TIM_CFG_PRESCALE_Pos) /* 011: 8 */
#define TIM_CFG_PRESCALE_DIV16          (0x4U << TIM_CFG_PRESCALE_Pos) /* 100: 16 */
#define TIM_CFG_PRESCALE_DIV32          (0x5U << TIM_CFG_PRESCALE_Pos) /* 101: 32 */
#define TIM_CFG_PRESCALE_DIV64          (0x6U << TIM_CFG_PRESCALE_Pos) /* 110: 64 */

/* ------ TIM status register (TIM_STS) Macros ------ */
#define TIM_STS_OVFFLG_Pos              (0U)
#define TIM_STS_OVFFLG                  (1U << TIM_STS_OVFFLG_Pos)

#endif //SOC_H
