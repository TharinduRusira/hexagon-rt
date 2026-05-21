ENTRY(_start)

SECTIONS
{
    . = 0x10000;

    .text : {
        *(.text*)
    }

    .rodata : {
        *(.rodata*)
    }

    .data : {
        *(.data*)
    }

    .bss : {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    }

    /* stack */
    . = ALIGN(16);
    __stack_bottom = .;
    . = . + 0x1000; /* 4 KB */
    __stack_top = .;
}
