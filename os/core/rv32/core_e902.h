#ifndef CORE_E902_H
#define CORE_E902_H

#include <stdint.h>
#include "core_e902_gcc.h"

#define   _I     volatile const
#define   _O     volatile
#define   _IO    volatile

#define CLIC_INTIP_IP_Pos                      0U                                    /*!< CLIC INTIP: IP Position */
#define CLIC_INTIP_IP                         (0x1UL << CLIC_INTIP_IP_Pos)           /*!< CLIC INTIP: IP Mask */

#define CLIC_INTIE_IE_Pos                      0U                                    /*!< CLIC INTIE: IE Position */
#define CLIC_INTIE_IE                         (0x1UL << CLIC_INTIE_IE_Pos)           /*!< CLIC INTIE: IE Mask */

typedef struct{
    _IO uint32_t MSIP;
} CLINTMODE_TypeDef;

typedef struct{
    _IO uint32_t MTIMECMPLO;
    _IO uint32_t MTIMECMPHI;
} CLINTCMPS_TypeDef;

typedef struct{
    _IO uint64_t MTIMECMP;
} CLINTCMP_TypeDef;

typedef struct{
    _I uint32_t MTIMELO;
    _I uint32_t MTIMEHI;
} CLINTTIMES_TypeDef;

typedef struct{
    _I uint64_t MTIME;
} CLINTTIME_TypeDef;

typedef struct{
    _IO uint8_t CLICINTIP;
    _IO uint8_t CLICINTIE;
    _IO uint8_t CLICINTATTR;
    _IO uint8_t CLICINTCTRL;
} CLIC_INT_TypeDef;

typedef struct{
    _IO uint32_t     CLICCFG;          //0xE0800000
    _I  uint32_t     CLICINFO;         //0xE0800004
    _IO uint32_t     MINTTHRESH;       //0xE0800008
    _I  uint32_t     RESERVED0[0x3FD]; //0xE080000c - 0xE0800FFF
    CLIC_INT_TypeDef INT[256];         //0xE0801000
} CLIC_TypeDef;

typedef struct{
    CLIC_INT_TypeDef INT[256];         //0xE0801000
} CLIC_INTER_TypeDef;

#define TCIP_BASE      0xE0000000
#define CLINT_BASE     TCIP_BASE
#define CLINT_MTIMECMP (CLINT_BASE + 0x004000)
#define CLINT_MTIME    (CLINT_BASE + 0x00BFF8)
#define CLIC_BASE      (TCIP_BASE  + 0x800000)
#define CLIC_CFG        CLIC_BASE
#define CLIC_INT       (CLIC_BASE  +   0x1000)

#define CLINTMODE      ((CLINTMODE_TypeDef  *) CLINT_BASE)
#define CLINTCMP       ((CLINTCMP_TypeDef   *) CLINT_MTIMECMP)
#define CLINTTIME      ((CLINTTIME_TypeDef  *) CLINT_MTIME)
#define CLIC           ((CLIC_TypeDef       *) CLIC_BASE)
#define CLIC_I         ((CLIC_INTER_TypeDef *) CLIC_INT)


__STATIC_INLINE void vic_enable_irq(int32_t IRQn){
    CLIC->INT[IRQn].CLICINTIP   = 0x00;
    CLIC->INT[IRQn].CLICINTIE   = 0x01;
    CLIC->INT[IRQn].CLICINTATTR = 0x03;
    CLIC->INT[IRQn].CLICINTCTRL = 0x00; //0x7f
}

__STATIC_INLINE void vic_disable_irq(int32_t IRQn){
    CLIC->INT[IRQn].CLICINTIP   &= 0x00;
    CLIC->INT[IRQn].CLICINTIE   &= 0x00;
    CLIC->INT[IRQn].CLICINTATTR &= 0x00;
    CLIC->INT[IRQn].CLICINTCTRL &= 0x00;
}

__STATIC_INLINE uint8_t vic_get_pend_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTIP);
}

__STATIC_INLINE uint8_t vic_get_enable_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTIE & CLIC_INTIE_IE);
}

__STATIC_INLINE uint8_t vic_get_attr_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTATTR);
}

__STATIC_INLINE uint8_t vic_get_ctl_irq(int32_t IRQn){
    return (uint8_t)(CLIC->INT[IRQn].CLICINTCTRL);
}
#endif //CORE_E902_H


