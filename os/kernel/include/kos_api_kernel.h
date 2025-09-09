#ifndef KOS_API_KERNEL
#define KOS_API_KERNEL

#include <stdint.h>

typedef int32_t k_status_t;

typedef enum  {
    KPRIO_IDLE            = 0,          ///< priority: idle (lowest)
    KPRIO_LOW0               ,          ///< priority: low
    KPRIO_LOW1               ,          ///< priority: low + 1
    KPRIO_LOW2               ,          ///< priority: low + 2
    KPRIO_LOW3               ,          ///< priority: low + 3
    KPRIO_LOW4               ,          ///< priority: low + 4
    KPRIO_LOW5               ,          ///< priority: low + 5
    KPRIO_LOW6               ,          ///< priority: low + 6
    KPRIO_LOW7               ,          ///< priority: low + 7
    KPRIO_NORMAL_BELOW0      ,          ///< priority: below normal
    KPRIO_NORMAL_BELOW1      ,          ///< priority: below normal + 1
    KPRIO_NORMAL_BELOW2      ,          ///< priority: below normal + 2
    KPRIO_NORMAL_BELOW3      ,          ///< priority: below normal + 3
    KPRIO_NORMAL_BELOW4      ,          ///< priority: below normal + 4
    KPRIO_NORMAL_BELOW5      ,          ///< priority: below normal + 5
    KPRIO_NORMAL_BELOW6      ,          ///< priority: below normal + 6
    KPRIO_NORMAL_BELOW7      ,          ///< priority: below normal + 7
    KPRIO_NORMAL             ,          ///< priority: normal (default)
    KPRIO_NORMAL1            ,          ///< priority: normal + 1
    KPRIO_NORMAL2            ,          ///< priority: normal + 2
    KPRIO_NORMAL3            ,          ///< priority: normal + 3
    KPRIO_NORMAL4            ,          ///< priority: normal + 4
    KPRIO_NORMAL5            ,          ///< priority: normal + 5
    KPRIO_NORMAL6            ,          ///< priority: normal + 6
    KPRIO_NORMAL7            ,          ///< priority: normal + 7
    KPRIO_NORMAL_ABOVE0      ,          ///< priority: above normal + 1
    KPRIO_NORMAL_ABOVE1      ,          ///< priority: above normal + 2
    KPRIO_NORMAL_ABOVE2      ,          ///< priority: above normal + 3
    KPRIO_NORMAL_ABOVE3      ,          ///< priority: above normal + 4
    KPRIO_NORMAL_ABOVE4      ,          ///< priority: above normal + 5
    KPRIO_NORMAL_ABOVE5      ,          ///< priority: above normal + 6
    KPRIO_NORMAL_ABOVE6      ,          ///< priority: above normal + 7
    KPRIO_NORMAL_ABOVE7      ,          ///< priority: above normal + 8
    KPRIO_HIGH0              ,          ///< priority: high
    KPRIO_HIGH1              ,          ///< priority: high + 1
    KPRIO_HIGH2              ,          ///< priority: high + 2
    KPRIO_HIGH3              ,          ///< priority: high + 3
    KPRIO_HIGH4              ,          ///< priority: high + 4
    KPRIO_HIGH5              ,          ///< priority: high + 5
    KPRIO_HIGH6              ,          ///< priority: high + 6
    KPRIO_HIGH7              ,          ///< priority: high + 7
    KPRIO_REALTIME0          ,          ///< priority: realtime + 1
    KPRIO_REALTIME1          ,          ///< priority: realtime + 2
    KPRIO_REALTIME2          ,          ///< priority: realtime + 3
    KPRIO_REALTIME3          ,          ///< priority: realtime + 4
    KPRIO_REALTIME4          ,          ///< priority: realtime + 5
    KPRIO_REALTIME5          ,          ///< priority: realtime + 6
    KPRIO_REALTIME6          ,          ///< priority: realtime + 7
    KPRIO_REALTIME7          ,          ///< priority: realtime + 8
    KPRIO_ISR                ,          ///< priority: Reserved for ISR deferred thread
    KPRIO_ERROR                         ///< Illegal priority
} k_priority_t;

// entry point of a task
typedef void (*k_task_entry_t) (void *arg) ;

// task handle
typedef void *k_task_handle_t ;

// initialize kernel
k_status_t kos_kernel_init(void);

// start the kernel
k_status_t kos_kernel_start(void);

// create new task
k_status_t kos_kernel_task_new(k_task_entry_t task, const char *name, void *arg,
                               k_priority_t prio, uint32_t time_quanta,
                               void *stack, uint32_t stack_size, k_task_handle_t *task_handle);
// suspend scheduler
uint32_t kos_kernel_sched_suspend(void);

// resume scheduler
void kos_kernel_sched_resume(uint32_t sleep_ticks);

#endif //KOS_API_KERNEL
