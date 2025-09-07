ifeq ($(KERNEL), rhino)
INCLUDEDIRS += -I$(OSDIR)/kernel/include
INCLUDEDIRS += -I$(OSDIR)/kernel/rhino/pwrmgmt
INCLUDEDIRS += -I$(OSDIR)/kernel/rhino/common
INCLUDEDIRS += -I$(OSDIR)/kernel/rhino/core/include
INCLUDEDIRS += -I$(OSDIR)/kernel/rhino/arch/include

CSRC += $(OSDIR)/kernel/rhino/arch/riscv/cpu_impl.c
CSRC += $(OSDIR)/kernel/rhino/arch/riscv/csky_sched.c
CSRC += $(OSDIR)/kernel/rhino/arch/riscv/dump_backtrace.c
CSRC += $(OSDIR)/kernel/rhino/arch/riscv/port_c.c
SSRC += $(OSDIR)/kernel/rhino/arch/riscv/port_s.S

CSRC += $(OSDIR)/kernel/rhino/adapter/csi_rhino.c
CSRC += $(OSDIR)/kernel/rhino/core/k_buf_queue.c
CSRC += $(OSDIR)/kernel/rhino/core/k_dyn_mem_proc.c
CSRC += $(OSDIR)/kernel/rhino/core/k_err.c
CSRC += $(OSDIR)/kernel/rhino/core/k_event.c
CSRC += $(OSDIR)/kernel/rhino/core/k_idle.c
CSRC += $(OSDIR)/kernel/rhino/core/k_mm.c
CSRC += $(OSDIR)/kernel/rhino/core/k_mm_debug.c
CSRC += $(OSDIR)/kernel/rhino/core/k_mm_blk.c
CSRC += $(OSDIR)/kernel/rhino/core/k_mutex.c
CSRC += $(OSDIR)/kernel/rhino/core/k_obj.c
CSRC += $(OSDIR)/kernel/rhino/core/k_pend.c
CSRC += $(OSDIR)/kernel/rhino/core/k_queue.c
CSRC += $(OSDIR)/kernel/rhino/core/k_ringbuf.c
CSRC += $(OSDIR)/kernel/rhino/core/k_sched.c
CSRC += $(OSDIR)/kernel/rhino/core/k_sem.c
CSRC += $(OSDIR)/kernel/rhino/core/k_stats.c
CSRC += $(OSDIR)/kernel/rhino/core/k_sys.c
CSRC += $(OSDIR)/kernel/rhino/core/k_task.c
CSRC += $(OSDIR)/kernel/rhino/core/k_task_sem.c
CSRC += $(OSDIR)/kernel/rhino/core/k_tick.c
CSRC += $(OSDIR)/kernel/rhino/core/k_time.c
CSRC += $(OSDIR)/kernel/rhino/core/k_timer.c
CSRC += $(OSDIR)/kernel/rhino/core/k_workqueue.c
CSRC += $(OSDIR)/kernel/rhino/driver/hook_impl.c
CSRC += $(OSDIR)/kernel/rhino/driver/hook_weak.c
CSRC += $(OSDIR)/kernel/rhino/driver/systick.c
CSRC += $(OSDIR)/kernel/rhino/driver/yoc_impl.c
CSRC += $(OSDIR)/kernel/rhino/common/k_atomic.c
CSRC += $(OSDIR)/kernel/rhino/common/k_ffs.c
CSRC += $(OSDIR)/kernel/rhino/board/board_cpu_pwr.c
CSRC += $(OSDIR)/kernel/rhino/board/board_cpu_pwr_systick.c
CSRC += $(OSDIR)/kernel/rhino/board/board_cpu_pwr_timer.c

endif

ifeq ($(KERNEL), kos)
INCLUDEDIRS += -I$(OSDIR)/kernel/include
INCLUDEDIRS += -I$(OSDIR)/kernel/kos/core/include
INCLUDEDIRS += -I$(OSDIR)/kernel/kos/arch/include

CSRC += $(OSDIR)/kernel/rhino/arch/riscv/port.c
SSRC += $(OSDIR)/kernel/rhino/arch/riscv/port.S

CSRC += $(OSDIR)/kernel/rhino/adapter/kos_rhino.c
endif
