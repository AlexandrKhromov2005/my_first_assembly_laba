section .data
    source dd 0xFFFF0000

section .bss
    result resd 1   ;   reserve double word (4 bytes)

section .text
    global _start   ;   entry point

_start:
    mov eax, [source]
    xor ebx, ebx
    mov ecx, 32



reverse_loop:
    shl ebx, 1
    shr eax, 1
    adc ebx, 0
    loop reverse_loop

    mov [result], ebx
    mov eax, 1      ;   number of sys_exit
    xor ebx, ebx    ;   exit code 0
    int 0x80        ;   program abort - call of Linux kernel


