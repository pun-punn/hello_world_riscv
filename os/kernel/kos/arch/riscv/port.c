#include "../../core/include/k_api.h"

void *cpu_task_stack_init(cpu_stack_t *base, size_t size, void *arg, task_entry_t entry){
    cpu_stack_t *stk;
    register int *gp asm("x3");
    uint32_t temp = (uint32_t)(uintptr_t)(base + size);
    temp &= 0xFFFFFFFCUL;
    stk = (cpu_stack_t *)(uintptr_t)temp;

    *(--stk) = (uint32_t)(uintptr_t)entry;                  /*PC  */
    *(--stk) = (uint32_t)(uintptr_t)0x15151515L;            /*X15 */
    *(--stk) = (uint32_t)(uintptr_t)0x14141414;             /*X14 */
    *(--stk) = (uint32_t)(uintptr_t)0x13131313;             /*X13 */
    *(--stk) = (uint32_t)(uintptr_t)0x12121212;             /*X12 */
    *(--stk) = (uint32_t)(uintptr_t)0x11111111;             /*X11 */
    *(--stk) = (uint32_t)(uintptr_t)arg;                    /*X10 */
    *(--stk) = (uint32_t)(uintptr_t)0x09090909;             /*X9  */
    *(--stk) = (uint32_t)(uintptr_t)0x08080808;             /*X8  */
    *(--stk) = (uint32_t)(uintptr_t)0x07070707;             /*X7  */
    *(--stk) = (uint32_t)(uintptr_t)0x06060606;             /*X6  */
    *(--stk) = (uint32_t)(uintptr_t)0x05050505;             /*X5  */
    *(--stk) = (uint32_t)(uintptr_t)0x04040404;             /*X4  */
    *(--stk) = (uint32_t)(uintptr_t)gp;                     /*X3  */
    *(--stk) = (uint32_t)(uintptr_t)krhino_task_deathbed;   /*X1  */

    return stk;
}
