.text
.global _start
.type _start, @function

.extern main
.extern _sbss
.extern _ebss

_start:
    /* zero bss */
    r0 = ##_sbss
    r1 = ##_ebss
    r2 = #0

.Lclear_bss_loop:
    p0 = cmp.eq(r0, r1) /* predicate register */
    if(p0) jump:nt .Llaunch_main

    memb(r0++#1) = r2   /* store #0 in r0, increment r0 1 byte */
    jump .Lclear_bss_loop

.Llaunch_main:
    /* qemu initial sp in r29 */
    r29 = and(r29, #-32)
    call main
    {
        r1 = r0
        r6 = #93 /* sys_exit */
    }
    trap0(#1)
    
.Ldead_loop:
    jump .Ldead_loop    /* for safe fallback */
