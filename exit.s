.section .text
.global _exit
.type _exit, @function

_exit:
    trap0(#0)
1:
    jump 1b
