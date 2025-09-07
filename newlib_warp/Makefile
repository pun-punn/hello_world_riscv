CC      = riscv64-unknown-elf-gcc
AR      = riscv64-unknown-elf-ar

CFLAGS  = -Os -Wall -I. -march=rv32emc -mabi=ilp32e -ffunction-sections -fdata-sections

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
