#include "../include/soc.h"
#include<stdio.h>

void trap_c(uint32_t *regs){
    //read exception code and print
    uint32_t vec = 0;
    vec = __get_MCAUSE() & 0x3FF;
    printf("err:%d\n",(int)vec);
}
