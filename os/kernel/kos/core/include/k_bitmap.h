#ifndef K_BITMAP_H
#define K_BITMAP_H

#include <stdint.h>
#include "../../arch/include/k_types.h"

#define BITMAP_UNIT_SIZE 32U
#define BITMAP_UNIT_MASK 0X0000001F
#define BITMAP_UNIT_BITS 5U

#define BITMAP_MASK(nr) (1UL << (BITMAP_UNIT_SIZE - 1U - ((nr) & BITMAP_UNIT_MASK)))
#define BITMAP_WORD(nr) ((nr) >> BITMAP_UNIT_BITS)

RHINO_INLINE void krhino_bitmap_set(uint32_t *bitmap, int32_t nr)
{
    bitmap[BITMAP_WORD(nr)] |= BITMAP_MASK(nr);
}

RHINO_INLINE void krhino_bitmap_clear(uint32_t *bitmap, int32_t nr)
{
    bitmap[BITMAP_WORD(nr)] &= ~BITMAP_MASK(nr);
}

RHINO_INLINE int krhino_find_first_bit(uint32_t *bitmap)
{
    int32_t  nr  = 0;
    uint32_t tmp = 0;

    while (*bitmap == 0UL) {
        nr += BITMAP_UNIT_SIZE;
        bitmap++;
    }

    tmp = *bitmap;

    if (!(tmp & 0XFFFF0000)) {
        tmp <<= 16;
        nr   += 16;
    }

    if (!(tmp & 0XFF000000)) {
        tmp <<= 8;
        nr   += 8;
    }

    if (!(tmp & 0XF0000000)) {
        tmp <<= 4;
        nr   += 4;
    }

    if (!(tmp & 0XC0000000)) {
        tmp <<= 2;
        nr   += 2;
    }

    if (!(tmp & 0X80000000)) {
        nr   += 1;
    }


    return nr;
}

#endif //K_BITMAP_H
