#ifndef DRV_IRQ_H
#define DRV_IRQ_H

#include <stdint.h>

void drv_irq_enable (uint32_t irq_num);
void drv_irq_disable(uint32_t irq_num);

void drv_irq_register  (uint32_t irq_num, void *irq_handler);
void drv_irq_unregister(uint32_t irq_num);

#endif //DRV_IRQ_H
