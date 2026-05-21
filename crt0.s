.section .text
.global _start
.type _start, @function

.extern main
.extern __bss_start
.extern __bss_end
.extern __stack_top

_start:
    /* set stack ptr */
    r29 = ##__stack_top /* SP */

    /* zero bss */
    r0 = ##__bss_start
    r1 = ##__bss_end

1: 
    p0 = cmp.gtu(r0, r1)    /* predicate register */
    if (p0) jump 2f

    memw(r0+#0) = #0
    r0 = add(r0, #4)
    jump 1b
2:
    call main
3:
    jump 3b /* main returns -> halt */
