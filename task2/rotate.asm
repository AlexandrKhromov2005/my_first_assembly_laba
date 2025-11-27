; Поворот матрицы на 90 градусов по часовой стрелке
; result[i][j] = source[size-1-j][i]
;
; Параметры:
;   [ebp+8]  - matrix
;   [ebp+12] - temp
;   [ebp+16] - size

section .text
    global rotate_matrix

rotate_matrix:
    push ebp
    mov ebp, esp

    ; сохраняем регистры
    push ebx
    push esi
    push edi

    ; загрузка параметров
    mov esi, [ebp + 8]          ; matrix
    mov edi, [ebp + 12]         ; temp
    mov ebx, [ebp + 16]         ; size

    ; внешний цикл (i)
    xor ecx, ecx

outer_loop:
    cmp ecx, ebx
    jge copy_back

    ; внутренний цикл (j)
    xor edx, edx

inner_loop:
    cmp edx, ebx
    jge next_row

    ; вычисляем source_row = size - 1 - j
    mov eax, ebx
    dec eax
    sub eax, edx

    ; source_index = (size - 1 - j) * size + i
    push edx
    mul ebx
    add eax, ecx
    pop edx

    ; читаем элемент
    mov eax, [esi + eax*4]

    ; dest_index = i * size + j
    push eax
    mov eax, ecx
    push edx
    mul ebx
    pop edx
    add eax, edx

    ; записываем в temp
    pop ebx
    mov [edi + eax*4], ebx
    mov ebx, [ebp + 16]

    inc edx
    jmp inner_loop

next_row:
    inc ecx
    jmp outer_loop

copy_back:
    ; копируем из temp обратно в matrix
    mov eax, ebx
    mul ebx                     ; eax = size * size
    mov ecx, eax

    xor eax, eax

copy_loop:
    cmp eax, ecx
    jge done

    mov edx, [edi + eax*4]
    mov [esi + eax*4], edx

    inc eax
    jmp copy_loop

done:
    ; восстанавливаем регистры
    pop edi
    pop esi
    pop ebx

    pop ebp
    ret
