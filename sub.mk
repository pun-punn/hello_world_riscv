ifeq ($(KERNEL), kos)
INCLUDEDIRS += -I$(OSDIR)/kernel/include
INCLUDEDIRS += -I$(OSDIR)/kernel/kos/arch/include
INCLUDEDIRS += -I$(OSDIR)/kernel/kos/core/include

CSRC += $(OSDIR)/kernel/kos/adapter/kos_rhino.c
CSRC += $(OSDIR)/kernel/kos/arch/riscv/port_c.c
SSRC += $(OSDIR)/kernel/kos/arch/riscv/port_s.S

CSRC += $(OSDIR)/kernel/kos/core/src/k_dyn_mem_proc.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_idle.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_mm.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_obj.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_sched.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_sem.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_stats.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_sys.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_task.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_tick.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_time.c
CSRC += $(OSDIR)/kernel/kos/core/src/k_pend.c
endif
