#include <stdint.h>
#include <stdio.h>
#include "../kernel/include/kos_api_kernel.h"
#include "../driver/include/soc.h"

#define MAIN_THREAD_STACK_SIZE 2048
#define MAIN_THREAD_PRIORITY   5

int  os_startup(void);
void app_init(void);

extern int main(void);

int entry(){
    printf("entry os \r\n");
    os_startup();
    return 0;
}

int os_startup(void){
    kos_kernel_init();
    kos_kernel_start();
    app_init();
    return 0;
}

void app_init(void){
    //start main thread
    //printf("Start Main Thread \r\n");
}
