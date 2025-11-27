.section .data
    source: .long 0xFFFF0000        # исходное значение
    hex_chars: .ascii "0123456789ABCDEF"

.section .bss
    .lcomm result, 4                # результат реверса
    .lcomm output, 11               # буфер для вывода "0x" + 8 цифр + '\n'

.section .text
    .globl _start

_start:
    # реверс битов двойного слова
    movl source, %eax
    xorl %ebx, %ebx                 # ebx будет результатом
    movl $32, %ecx                  # счетчик битов

reverse_loop:
    shll $1, %ebx                   # сдвиг результата влево
    shrl $1, %eax                   # сдвиг источника вправо
    adcl $0, %ebx                   # добавляем выдвинутый бит
    loop reverse_loop

    movl %ebx, result

    # конвертация в hex строку
    leal output, %edi
    movb $'0', %al                  # префикс "0x"
    stosb
    movb $'x', %al
    stosb

    movl result, %eax
    movl $8, %ecx                   # 8 hex цифр

convert_loop:
    roll $4, %eax                   # берем старшие 4 бита
    pushl %eax
    andl $0x0F, %eax                # оставляем только 4 бита
    movb hex_chars(%eax), %al       # получаем символ
    stosb                           # записываем в буфер
    popl %eax
    loop convert_loop

    movb $0x0A, (%edi)              # добавляем перевод строки

    # вывод в консоль через sys_write
    movl $4, %eax                   # sys_write
    movl $1, %ebx                   # stdout
    leal output, %ecx
    movl $11, %edx
    int $0x80

    # выход через sys_exit
    movl $1, %eax                   # sys_exit
    xorl %ebx, %ebx                 # код возврата 0
    int $0x80
