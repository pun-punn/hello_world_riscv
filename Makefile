NAME   = hello_world_rtos
CDIR   = .
MAKEDIR = $(shell pwd)
ROOTDIR = $(MAKEDIR)#/../../../../../
OSDIR   = $(ROOTDIR)/os
APPDIR  = $(ROOTDIR)/app
BUILDDIR= $(ROOTDIR)/build
OBJDIR = $(BUILDDIR)/obj

CFLAGS += -g2
CFLAGS += -Os

MODE ?= e902

ifeq ($(MODE),qemu)
    #TARGET_CPU = rv32imac
    #ABI        = ilp32
	TARGET_CPU = rv32emc
    ABI        = ilp32e
else
    TARGET_CPU = rv32emc
    ABI        = ilp32e
endif

#TARGET_CPU = rv32emc
KERNEL = kos
HAVE_VIC = y

HEX_BUILDDIR = hex_build

export TARGET_CPU KERNEL HAVE_VIC

#linker script
ifeq ($(MODE),qemu)
	LINKFILE = linker_qemu.ld
	LINKDIR  = $(OSDIR)/board
else
	LINKFILE = linker.ld
	LINKDIR  = $(OSDIR)/board
endif

CC      = riscv64-unknown-elf-gcc
LD      = riscv64-unknown-elf-ld
AR      = riscv64-unknown-elf-ar
AS      = riscv64-unknown-elf-as
OBJDUMP = riscv64-unknown-elf-objdump
OBJCOPY = riscv64-unknown-elf-objcopy
RM      = rm
MV      = mv

#include
INCLUDEDIRS = \
              -I$(OSDIR)/core          \
              -I$(OSDIR)/core/rv32      \
              -I$(OSDIR)/driver/include  \
              -I$(OSDIR)/libs/include     \
	      -I$(APPDIR)/include          \
#source c
CSRC = \
          $(OSDIR)/libs/libc/minilibc_port.c \
          $(OSDIR)/libs/libc/malloc.c \
          $(shell find $(OSDIR)/driver/src/ -name "*.c")    \
          $(OSDIR)/board/*.c   \

#source c and asm in startup
CSRC += $(shell find $(OSDIR)/startup/ -name "*.c")
SSRC += $(shell find $(OSDIR)/startup/ -name "*.S")

#source s in driver
SSRC += $(shell find $(OSDIR)/driver/src/ -name "*.S")

#kernel
include sub.mk

CFLAGS += $(INCLUDEDIRS)
CFLAGS += -c -g -ffunction-sections -fdata-sections -Wall
#ifeq ($(strip $(TARGET_CPU)),$(filter $(TARGET_CPU), rv32ec rv32emc))
#CFLAGS += -march=$(TARGET_CPU) -mabi=ilp32e
#LDFLAGS += -march=$(TARGET_CPU) -mabi=ilp32e
#else
#ifeq ($(TARGET_CPU), rv32imac)
#CFLAGS += -march=$(TARGET_CPU) -mabi=ilp32
#LDFLAGS += -march=$(TARGET_CPU) -mabi=ilp32
#else
#CFLAGS += -mcpu=$(TARGET_CPU)
#LDFLAGS += -mcpu=$(TARGET_CPU)
#endif
#endif
CFLAGS += -march=$(TARGET_CPU) -mabi=$(ABI)
LDFLAGS += -march=$(TARGET_CPU) -mabi=$(ABI)

LDFLAGS +=

ifeq ($(MODE),qemu)
    #NEWLIB_WRAP_LIB += $(OSDIR)/libs/libnewlib_wrap_imac.a
    NEWLIB_WRAP_LIB += $(OSDIR)/libs/libnewlib_wrap.a
    NEWTHIRDPARTY_LIBS +=
else
    NEWLIB_WRAP_LIB += $(OSDIR)/libs/libnewlib_wrap.a
    NEWTHIRDPARTY_LIBS +=
endif

export CC AS AR LD GS RM OBJDUMP CFLAGS AFLAGS MV
Q = @

all: $(NAME).elf

#source c in app
#CSRC += $(shell find $(APPDIR)/src/ -name "*.c")

SSRCFILE = $(wildcard $(SSRC))
CSRCFILE = $(wildcard $(CSRC))

OBJECTS = $(SSRCFILE:%.S=%.o) $(CSRCFILE:%.c=%.o)

%.o:%.c
	@echo CC ${shell echo $<|awk -F '/' '{print $$NF}'}
	$(Q)$(CC)  $(CFLAGS) -o $@  $<

%.o:%.S
	@echo AS ${shell echo $<|awk -F '/' '{print $$NF}'}
	$(Q)$(CC)  $(CFLAGS) -o $@  $<

build_dir:
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(OBJDIR)

$(NAME).elf: build_dir $(OBJECTS) $(LINKDIR)/$(LINKFILE)
	@echo LINK $@
	$(Q)$(CC) $(LDFLAGS) \
	-nostartfiles -o $(BUILDDIR)/$(NAME).elf \
	-Wl,--whole-archive $(OBJECTS) $(DSP_LIB) $(VDSP_LIB) $(DSP_NN_LIB) $(VDSP_NN_LIB) $(NEWLIB_WRAP_LIB) $(NEWTHIRDPARTY_LIBS) -Wl,--no-whole-archive \
	-Wl,-T$(LINKDIR)/$(LINKFILE) \
	-lm -lc -lgcc -Wl,-gc-sections -Wl,-zmax-page-size=1024
	$(Q)$(OBJDUMP) -S $(BUILDDIR)/$(NAME).elf > $(BUILDDIR)/$(NAME).asm
	@-mv $(OBJECTS) $(OBJDIR)
hexfile:
	@$(OBJCOPY) -O binary $(BUILDDIR)/$(NAME).elf $(BUILDDIR)/$(NAME).bin
	@$(OBJCOPY) -O ihex   $(BUILDDIR)/$(NAME).elf $(BUILDDIR)/$(NAME).hex
clean:
	@echo clean
	@$(RM) -rf $(BUILDDIR) $(OBJECTS)


