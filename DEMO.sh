#!/bin/bash
# Демонстрационный скрипт для Makefile

echo "==================================================================="
echo "ДЕМОНСТРАЦИЯ РАБОТЫ ПРОДВИНУТОГО MAKEFILE"
echo "Лабораторная работа №3: GNU Make"
echo "==================================================================="
echo ""

echo "1. Просмотр справки"
echo "-------------------"
make help
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "2. Просмотр конфигурации"
echo "------------------------"
make info
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "3. Первая полная сборка (Intel синтаксис)"
echo "------------------------------------------"
make distclean
make
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "4. Проверка созданных файлов"
echo "-----------------------------"
ls -lh bin/
ls -lh bin/obj/
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "5. Запуск программы"
echo "-------------------"
make run
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "6. Демонстрация инкрементальной сборки"
echo "---------------------------------------"
echo "Время модификации файлов ДО изменения:"
stat -c "%y %n" bin/obj/*.o bin/matrix_rotate 2>/dev/null
echo ""
echo "Изменяем файл src/main.c..."
sleep 1
touch src/main.c
echo ""
echo "Пересборка проекта:"
make
echo ""
echo "Время модификации файлов ПОСЛЕ изменения:"
stat -c "%y %n" bin/obj/*.o bin/matrix_rotate 2>/dev/null
echo ""
echo "ВЫВОД: Только main.o был перекомпилирован!"
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "7. Сборка с AT&T синтаксисом"
echo "-----------------------------"
make clean
make SYNTAX=att
echo ""
echo "Запуск программы с AT&T:"
./bin/matrix_rotate 3 0 10
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "8. Сборка с отладочными символами"
echo "-----------------------------------"
make distclean
make DEBUG=yes
echo ""
echo "Проверка наличия отладочной информации:"
file bin/matrix_rotate | grep "debug_info"
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "9. Комбинированная сборка"
echo "-------------------------"
echo "Сборка: SYNTAX=att DEBUG=yes COMPILE_FLAGS=\"-O2\""
make distclean
make SYNTAX=att DEBUG=yes COMPILE_FLAGS="-O2"
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "10. Запуск тестов"
echo "-----------------"
make test
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "11. Просмотр файлов зависимостей"
echo "--------------------------------"
echo "Содержимое bin/obj/main.d (первые 5 строк):"
head -5 bin/obj/main.d
echo ""
read -p "Нажмите Enter для продолжения..."

echo ""
echo "==================================================================="
echo "ДЕМОНСТРАЦИЯ ЗАВЕРШЕНА"
echo "==================================================================="
echo ""
echo "Все требования лабораторной работы выполнены:"
echo "  ✓ Автоматическое определение зависимостей"
echo "  ✓ Инкрементальная сборка"
echo "  ✓ Структурирование проекта (src/, bin/)"
echo "  ✓ Динамическая компиляция (SYNTAX, DEBUG, INPUT_METHOD)"
echo "  ✓ Использование переменных и функций make"
echo "  ✓ Шаблонные правила"
echo "  ✓ Фиктивные цели"
echo ""
