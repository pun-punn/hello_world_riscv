#ifndef K_ERR_H
#define K_ERR_H

typedef enum{
    RHINO_SUCCESS       = 0u,
    RHINO_SYS_FATAL_ERR,
    RHINO_SYS_SP_ERR,
    RHINO_RUNNING,
    RHINO_STOPPED,
    RHINO_INV_PARAM,
    RHINO_NULL_PTR
} kstat_t;

typedef void (*krhino_err_proc_t) (kstat_t err) ;
extern krhino_err_proc_t q_err_prec;
#endif //K_ERR_H
