#include <stdint.h>
#include <stdio.h>
//#include "../kernel/include/kos_api_kernel.h"
#include "../driver/include/soc.h"

#define MAIN_THREAD_STACK_SIZE 2048
#define MAIN_THREAD_PRIORITY   5

int  os_startup(void);
void app_init(void);

extern int main(void);

int entry(){
    printf("Entry OS \r\n");
    os_startup();
    return 0;
}

int os_startup(void){
    //init before start app
    printf("core_int base addr = 0x%08lx\r\n", (unsigned long)&CLIC->INT[7]);
    printf("core_int.ip   addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTIP,   (uint8_t)vic_get_pend_irq(7));
    printf("core_int.ie   addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTIE,   (uint8_t)vic_get_enable_irq(7));
    printf("core_int.attr addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTATTR, (uint8_t)vic_get_attr_irq(7));
    printf("core_int.ctl  addr = 0x%08lx, coret_int = 0x%02x\r\n", (unsigned long)&CLIC->INT[7].CLICINTCTRL, (uint8_t)vic_get_ctl_irq(7));
    app_init();
    return 0;
}

void app_init(void){
    //start main thread
    printf("Start Main Thread \r\n");
}
