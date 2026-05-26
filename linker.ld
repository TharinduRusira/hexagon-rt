ENTRY(_start)

SECTIONS
{
    . = 0x70000000;
    
    __image_start = .;
    
    .text : {
        _stext = .;
        *(.text.__start)
        *(.text*)
        _etext = .;
    }

    .rodata : {
        _srodata = .;
        *(.rodata*)
        _erodata = .;
    }

    .data : {
        _sdata = .;
        *(.data*)
        _edata = .;

    }

    .bss : {
        _sbss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    }

    __image_end = .;
}
