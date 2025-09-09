#ifndef K_SYS_H
#define K_SYS_H

#include <stdint.h>
#include "../include/k_err.h"

typedef uint32_t        sys_time_t;
typedef uint32_t        tick_t;

kstat_t krhino_init(void);

kstat_t krhino_start(void);

#endif //K_SYS_H
