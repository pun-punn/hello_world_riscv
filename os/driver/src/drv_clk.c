#include "../include/drv_clk.h"
#include "../include/soc.h"

typedef struct {
    uint32_t base;
} clk_priv_t;

static clk_priv_t clk_instance;

extern int32_t target_get_clk(uint32_t *base);

clk_handle_t drv_clk_initialize(){
    uint32_t base;
    int32_t ret = target_get_clk(&base);

    if(ret < 0) { return 0;}
    clk_priv_t *clk_priv = &clk_instance;
    clk_priv->base = base;
    return (clk_handle_t)clk_priv;
}

int32_t drv_clk_setup(clk_handle_t handle, uint32_t clk){
    clk_priv_t *clk_priv = handle;
    soc_reg_t *addr_clk = (soc_reg_t*)(uintptr_t)(clk_priv->base);

    while((addr_clk->CLK & SOC_CLK_PLLLOCK) == 0);

    addr_clk->CLK |= clk;

    for(uint8_t iter = 0; iter < 200; iter++);

    return 1;
}

int32_t drv_clk_enable(clk_handle_t handle, uint32_t enable){
    clk_priv_t *clk_priv = handle;
    soc_reg_t *addr_clk = (soc_reg_t*)(uintptr_t)(clk_priv->base);

    addr_clk->CLKEN |= enable;
    return 1;
}
