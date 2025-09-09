#ifndef K_TYPES_H
#define K_TYPES_H

#include <stdint.h>

#define RHINO_NO_WAIT         0u

#define RHINO_TASK_STACK_OVF_MAGIC   0xdeadbeef
#define RHINO_INTRPT_STACK_OVF_MAGIC 0xdeaddead
#define RHINO_INLINE                 static __inline

#define RHINO_MM_CORRUPT_DYE         0xFEFEFEFE
#define RHINO_MM_FREE_DYE            0xABABABAB

typedef char     name_t;
typedef uint32_t sem_count_t;
typedef uint32_t cpu_stack_t;
typedef uint32_t cpu_cpsr_t ;
typedef uint32_t mutex_nested_t;
typedef uint8_t  suspend_nested_t;
typedef uint64_t ctx_switch_t;

#endif //K_TYPES_H
