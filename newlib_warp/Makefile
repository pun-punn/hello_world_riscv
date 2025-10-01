CC      = riscv64-unknown-elf-gcc
AR      = riscv64-unknown-elf-ar

ifeq ($(MODE),qemu)
    TARGET_CPU = rv32imac
    ABI        = ilp32
else
    TARGET_CPU = rv32emc
    ABI        = ilp32e
endif

CFLAGS  = -Os -Wall -I. -march=$(TARGET_CPU) -mabi=$(ABI) -ffunction-sections -fdata-sections

SRCS    = $(wildcard *.c)
OBJS    = $(SRCS:.c=.o)
LIB     = libnewlib_wrap.a

all: $(LIB)

$(LIB): $(OBJS)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(LIB)
