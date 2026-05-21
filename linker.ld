ENTRY(_start)

SECTIONS
{
    . = 0x10000;
    
    __image_start = .;
    
    .text : ALIGN(16) {
        __text_start = .;
        *(.text.__start)
        *(.text*)
        __text_end = .;
    }

    .rodata : ALIGN(16) {
        __rodata_start = .;
        *(.rodata*)
        __rodata_end = .;
    }

    .data : ALIGN(16) {
        __data_start = .;
        *(.data*)
        __data_end = .;

    }

    .bss : ALIGN(16) {
        __bss_start = .;
        *(.bss*)
        *(COMMON)
        __bss_end = .;
    }

    /* stack */
    . = ALIGN(16);
    __stack_top = 0x20000;

    __image_end = .;
}
