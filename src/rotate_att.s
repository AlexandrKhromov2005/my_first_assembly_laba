# Поворот матрицы на 90 градусов по часовой стрелке
# result[i][j] = source[size-1-j][i]
#
# Параметры:
#   8(%ebp)  - matrix
#   12(%ebp) - temp
#   16(%ebp) - size

.section .text
    .globl rotate_matrix

rotate_matrix:
    pushl %ebp
    movl %esp, %ebp

    # сохраняем регистры
    pushl %ebx
    pushl %esi
    pushl %edi

    # загрузка параметров
    movl 8(%ebp), %esi              # matrix
    movl 12(%ebp), %edi             # temp
    movl 16(%ebp), %ebx             # size

    # внешний цикл (i)
    xorl %ecx, %ecx

outer_loop:
    cmpl %ebx, %ecx
    jge copy_back

    # внутренний цикл (j)
    xorl %edx, %edx

inner_loop:
    cmpl %ebx, %edx
    jge next_row

    # вычисляем source_row = size - 1 - j
    movl %ebx, %eax
    decl %eax
    subl %edx, %eax

    # source_index = (size - 1 - j) * size + i
    pushl %edx
    mull %ebx
    addl %ecx, %eax
    popl %edx

    # читаем элемент
    movl (%esi, %eax, 4), %eax

    # dest_index = i * size + j
    pushl %eax
    movl %ecx, %eax
    pushl %edx
    mull %ebx
    popl %edx
    addl %edx, %eax

    # записываем в temp
    popl %ebx
    movl %ebx, (%edi, %eax, 4)
    movl 16(%ebp), %ebx

    incl %edx
    jmp inner_loop

next_row:
    incl %ecx
    jmp outer_loop

copy_back:
    # копируем из temp обратно в matrix
    movl %ebx, %eax
    mull %ebx                       # eax = size * size
    movl %eax, %ecx

    xorl %eax, %eax

copy_loop:
    cmpl %ecx, %eax
    jge done

    movl (%edi, %eax, 4), %edx
    movl %edx, (%esi, %eax, 4)

    incl %eax
    jmp copy_loop

done:
    # восстанавливаем регистры
    popl %edi
    popl %esi
    popl %ebx

    popl %ebp
    ret
