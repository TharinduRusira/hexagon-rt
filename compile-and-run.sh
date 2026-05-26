#!/bin/bash
# Compiler crt0 and a given C/C++ function
# Link obj files and the custom linker script, bundle into `hexagon.elf`
# Run qemu-hexagon on the executable
# Check return value

if [ -z "$1" ]; then
    echo "Error! Usage: ./compiler-and-run.sh path/to/a/C/function.cpp"
    exit 1
fi

clang --target=hexagon-unknown-linux-musl -c crt0.s -o crt0.o

clang --target=hexagon-unknown-linux-musl -O2 -ffreestanding -c $1 -o main.o

ld.lld -T linker.ld crt0.o main.o -o hexagon.elf

qemu-hexagon ./hexagon.elf

echo $?
