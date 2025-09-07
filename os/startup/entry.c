#include <stdint.h>
#include <stdio.h>

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

    app_init();
    return 0;
}

void app_init(void){
    //start main thread
    printf("Start Main Thread \r\n");
}
