section .data
    source dd 0xFFFF0000        ; исходное значение
    hex_chars db "0123456789ABCDEF"

section .bss
    result resd 1               ; результат реверса
    output resb 11              ; буфер для вывода "0x" + 8 цифр + '\n'

section .text
    global _start

_start:
    ; реверс битов двойного слова
    mov eax, [source]
    xor ebx, ebx                ; ebx будет результатом
    mov ecx, 32                 ; счетчик битов

reverse_loop:
    shl ebx, 1                  ; сдвиг результата влево
    shr eax, 1                  ; сдвиг источника вправо
    adc ebx, 0                  ; добавляем выдвинутый бит
    loop reverse_loop

    mov [result], ebx

    ; конвертация в hex строку
    mov edi, output
    mov al, '0'                 ; префикс "0x"
    stosb
    mov al, 'x'
    stosb

    mov eax, [result]
    mov ecx, 8                  ; 8 hex цифр

convert_loop:
    rol eax, 4                  ; берем старшие 4 бита
    push eax
    and eax, 0x0F               ; оставляем только 4 бита
    mov al, [hex_chars + eax]   ; получаем символ
    stosb                       ; записываем в буфер
    pop eax
    loop convert_loop

    mov byte [edi], 0x0A        ; добавляем перевод строки

    ; вывод в консоль через sys_write
    mov eax, 4                  ; sys_write
    mov ebx, 1                  ; stdout
    mov ecx, output
    mov edx, 11
    int 0x80

    ; выход через sys_exit
    mov eax, 1                  ; sys_exit
    xor ebx, ebx                ; код возврата 0
    int 0x80


