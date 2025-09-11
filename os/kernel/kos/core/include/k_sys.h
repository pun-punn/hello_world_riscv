#ifndef K_SYS_H
#define K_SYS_H

#include <stdint.h>
#include "../../arch/include/k_config.h"
#include "../include/k_err.h"

#define RHINO_IDLE_PRI (RHINO_CONFIG_PRI_MAX -1 )

typedef uint32_t        sys_time_t;
typedef uint32_t        sys_time_i_t;
typedef uint32_t        idle_count_t;
typedef uint32_t        tick_t;
typedef int32_t         tick_i_t;

kstat_t krhino_init(void);
kstat_t krhino_start(void);
kstat_t krhino_intrpt_enter(void);
void    krhino_intrpt_exit(void);
#endif //K_SYS_H
