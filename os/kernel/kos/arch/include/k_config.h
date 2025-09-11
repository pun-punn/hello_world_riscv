#ifndef K_CONFIG_H
#define K_CONFIG_H


#define CSK_CPU_STACK_EXTRAL    20

#define RHINO_CONFIG_TIME_SLICE_DEFAULT      50
#define RHINO_CONFIG_PRI_MAX                 62
#define RHINO_CONFIG_USER_PRI_MAX            (RHINO_CONFIG_PRI_MAX - 2)

#define RHINO_CONFIG_KOBJ_DYN_ALLOC          1
#if (RHINO_CONFIG_KOBJ_DYN_ALLOC > 0)
#define RHINO_CONFIG_K_DYN_QUEUE_MSG         30
#define RHINO_CONFIG_K_DYN_TASK_STACK        (64 + CSK_CPU_STACK_EXTRAL)
#define RHINO_CONFIG_K_DYN_MEM_TASK_PRI      RHINO_CONFIG_USER_PRI_MAX
#endif

/* interrupt */
#define RHINO_CONFIG_INTRPT_MAX_NESTED_LEVEL 188u

/* tick */
#define RHINO_CONFIG_TICKS_PER_SECOND        100

/* idel config*/
#define RHINO_CONFIG_IDLE_TASK_STACK_SIZE    (256 + CSK_CPU_STACK_EXTRAL)

/* kernel hook conf */
#define RHINO_CONFIG_USER_HOOK               1

/* kernel stats conf */
#define RHINO_CONFIG_SYSTEM_STATS            1

#endif //K_CONFIG_H
