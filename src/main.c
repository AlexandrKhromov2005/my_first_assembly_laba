// Лабораторная работа 1, задание 2
// Поворот матрицы на 90 градусов по часовой стрелке
// Делается через ассемблерную функцию

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>

// функция на асме, которая делает поворот
extern void rotate_matrix(int32_t* matrix, int32_t* temp, int32_t size);

// выводим матрицу на экран
void print_matrix(int32_t* matrix, int32_t size) {
    for (int32_t i = 0; i < size; i++) {
        for (int32_t j = 0; j < size; j++) {
            printf("%8d ", matrix[i * size + j]);  // матрица в одномерном массиве
        }
        printf("\n");
    }
    printf("\n");
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Использование: %s <размер_матрицы> [мин_значение] [макс_значение]\n", argv[0]);
        fprintf(stderr, "Пример: %s 5 -100 100\n", argv[0]);
        return 1;
    }

    int32_t size = atoi(argv[1]); \
    
    if (size <= 0) {
        fprintf(stderr, "Ошибка: размер матрицы должен быть положительным числом\n");
        return 1;
    }

    // диапазон для случайных чисел по умолчанию
    int32_t min_val = -1000;
    int32_t max_val = 1000;

    if (argc >= 3) {
        min_val = atoi(argv[2]);
    }
    if (argc >= 4) {
        max_val = atoi(argv[3]);
    }

    if (min_val >= max_val) {
        fprintf(stderr, "Ошибка: минимум должен быть меньше максимума\n");
        return 1;
    }

    printf("=== Поворот матрицы %dx%d ===\n", size, size);
    printf("Диапазон значений: [%d, %d]\n\n", min_val, max_val);

    int32_t* matrix = (int32_t*)malloc(size * size * sizeof(int32_t));
    if (matrix == NULL) {
        fprintf(stderr, "Ошибка: не удалось выделить память для матрицы\n");
        return 1;
    }

    // временный буфер для поворота
    int32_t* temp = (int32_t*)malloc(size * size * sizeof(int32_t));
    if (temp == NULL) {
        fprintf(stderr, "Ошибка: не удалось выделить память для временного буфера\n");
        free(matrix);
        return 1;
    }

    srand(time(NULL));

    int32_t range = max_val - min_val + 1;
    for (int32_t i = 0; i < size * size; i++) {
        matrix[i] = min_val + (rand() % range);
    }

    printf("Исходная матрица:\n");
    print_matrix(matrix, size);

    rotate_matrix(matrix, temp, size);

    printf("Матрица после поворота:\n");
    print_matrix(matrix, size);

    free(temp);
    free(matrix);

    return 0;
}
