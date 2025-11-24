#ifndef DRV_CLK_H
#define DRV_CLK_H

#include <stdio.h>
#include <stdint.h>
#include "soc.h"

typedef void *clk_handle_t;

typedef struct {
    _IO  uint32_t CLK;
    _IO  uint32_t CLKEN;
    _IO  uint32_t IODIR;
    _IO  uint32_t IOMUX;
} soc_reg_t ;

clk_handle_t drv_clk_initialize();
int32_t      drv_clk_setup(clk_handle_t handle, uint32_t clk);
int32_t      drv_clk_enable(clk_handle_t handle, uint32_t enable);

#endif //DRV_CLK_H
