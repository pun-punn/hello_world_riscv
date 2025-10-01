#!/bin/bash
# ---------------------------------------------------------
# Script to launch QEMU for RISC-V 32-bit bare-metal and GDB
# ---------------------------------------------------------

ELF_FILE="build/hello_world_systick.elf"
QEMU="qemu-riscv32"
GDB="riscv64-unknown-elf-gdb"

# QEMU options:
# -machine virt        : virtual RISC-V machine
# -nographic           : no graphical output, use console
# -bios none           : do not load OpenSBI/BIOS
# -kernel ELF_FILE     : load your ELF
# -S                   : freeze CPU at startup (wait for GDB)
# -s                   : enable GDB server on TCP port 1234
QEMU_CMD="$QEMU -cpu e902 -kernel $ELF_FILE -S -s"

echo "starting qemu..."
$QEMU_CMD &
QEMU_PID=$!

sleep 1

echo "launching gdb..."
$GDB -ex "set architecture riscv:rv32" \
     -ex "file $ELF_FILE" \
     -ex "target remote :1234" \
     -ex "break Reset_Handler" \
     -ex "continue"

# Kill QEMU after GDB exits
kill $QEMU_PID
