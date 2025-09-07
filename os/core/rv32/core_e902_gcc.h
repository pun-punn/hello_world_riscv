#ifndef CORE_E902_GCC_H
#define CORE_E902_GCC_H
#include <stdlib.h>

#ifndef __ASM
#define __ASM                   __asm     /*!< asm keyword for GNU Compiler */
#endif

#ifndef __INLINE
#define __INLINE                inline    /*!< inline keyword for GNU Compiler */
#endif

#ifndef __ALWAYS_STATIC_INLINE
#define __ALWAYS_STATIC_INLINE  __attribute__((always_inline)) static inline
#endif

#ifndef __STATIC_INLINE
#define __STATIC_INLINE         static inline
#endif


#endif //CORE_E902_GCC_H
