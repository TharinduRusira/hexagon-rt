#include <stdarg.h>
#include "defs.h"

void putchar(char c) {
    register int r0_fd __asm__("r0") = 1; // stdout
    register const char* r1_buf __asm__("r1") = &c;
    register int r2_count __asm__("r2") = 1; // num bytes to write
    register int r6_sys __asm__("r6") = 64; // sys_write system call

    __asm__ volatile (
            "{\n\t"
            "trap0(#1)\n\t"
            "}\n\t"
            : "+r"(r0_fd)
            : "r"(r1_buf), "r"(r2_count), "r"(r6_sys)
            : "memory"
            );
}

void putstr(const char *s) {
    while(*s)
        putchar(*s++);
}

void putnum(int n) {
    if (n < 0) {
        putchar('-');
        n = -n;
    }

    if (n > 10)
        putnum(n / 10);
    putchar((n%10) + '0');
}

void hexprintf(const char *format, ...){
    va_list args;
    va_start(args, format);

    for (int i=0; format[i] != '\0'; i++) {
        if (format[i] != '%') {
            putchar(format[i]);
            continue;
        }
        i++;
        if (format[i] == '\0') break;

        switch(format[i]) {
            case 'd': {
                int num = va_arg(args, int);
                putnum(num);
                break;
            }
            case 's': {
                char *str = va_arg(args, char *);
                if (str == NULL) {
                    putstr("(null)");
                } else {
                    putstr(str);
                }
                break;
            }
            case '%': {
                putchar('%');
                break;
            }
            default : {
                // unsupported, just print the format char
                putchar('%s');
                putchar(format[i]);
                break;
            }

        }

    }
    va_end(args);
}
