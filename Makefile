# =============================================================================
# Продвинутый Makefile для лабораторной работы №3
# Автор: студент группы
# Дата: 2025-12-08
# =============================================================================

# Имя исполняемого файла
PROGRAM_NAME := matrix_rotate

# Флаги компиляции (могут передаваться из командной строки)
override COMPILE_FLAGS += -Wall -m32

# Директории проекта
SRC_DIR := src
BIN_DIR := bin
OBJ_DIR := $(BIN_DIR)/obj

# Выбор синтаксиса ассемблера (может быть intel или att)
# Использование: make SYNTAX=att
SYNTAX ?= intel

# Выбор метода ввода данных (console, file, random)
# Использование: make INPUT_METHOD=random
INPUT_METHOD ?= console

# Режим отладки (yes/no)
DEBUG ?= no

# Настройка компиляторов и флагов
CC := gcc
AS := as
ASM := nasm
CFLAGS := $(COMPILE_FLAGS)
ASFLAGS := --32
ASMFLAGS := -f elf32

# Добавление флагов отладки
ifeq ($(DEBUG),yes)
    CFLAGS += -g -DDEBUG
    ASMFLAGS += -g -F dwarf
endif

# Определение файлов в зависимости от синтаксиса
ifeq ($(SYNTAX),att)
    ASM_SRC := rotate_att.s
    ASM_COMPILER := $(AS)
    ASM_FLAGS := $(ASFLAGS)
else
    ASM_SRC := rotate.asm
    ASM_COMPILER := $(ASM)
    ASM_FLAGS := $(ASMFLAGS)
endif

# Определение макроса для метода ввода
ifeq ($(INPUT_METHOD),file)
    CFLAGS += -DINPUT_FILE
else ifeq ($(INPUT_METHOD),random)
    CFLAGS += -DINPUT_RANDOM
else
    CFLAGS += -DINPUT_CONSOLE
endif

# Автоматическое определение исходных файлов C
C_SOURCES := $(wildcard $(SRC_DIR)/*.c)

# Формирование списка объектных файлов
C_OBJECTS := $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(C_SOURCES))
ASM_OBJECT := $(OBJ_DIR)/$(basename $(ASM_SRC)).o

# Все объектные файлы
OBJECTS := $(C_OBJECTS) $(ASM_OBJECT)

# Путь к исполняемому файлу
TARGET := $(BIN_DIR)/$(PROGRAM_NAME)

# Поиск исходников в директории SRC_DIR
VPATH := $(SRC_DIR)

# =============================================================================
# Цели сборки
# =============================================================================

# Основная цель (по умолчанию)
.DEFAULT_GOAL := all

# Собрать программу
all: $(TARGET)

# Линковка исполняемого файла
$(TARGET): $(OBJECTS) | $(BIN_DIR)
	@echo "==> Linking: $@"
	$(CC) $(CFLAGS) $^ -o $@
	@echo "==> Build complete: $@"
	@echo "    Syntax: $(SYNTAX)"
	@echo "    Input method: $(INPUT_METHOD)"
	@echo "    Debug: $(DEBUG)"

# Компиляция C файлов с автоматическим созданием зависимостей
$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@echo "==> Compiling C: $<"
	$(CC) $(CFLAGS) -MD -c $< -o $@
	@echo "    Object: $@"

# Компиляция ассемблерных файлов (Intel синтаксис)
$(OBJ_DIR)/%.o: %.asm | $(OBJ_DIR)
	@echo "==> Assembling (Intel): $<"
	$(ASM) $(ASMFLAGS) $< -o $@
	@echo "    Object: $@"

# Компиляция ассемблерных файлов (AT&T синтаксис)
$(OBJ_DIR)/%_att.o: %_att.s | $(OBJ_DIR)
	@echo "==> Assembling (AT&T): $<"
	$(AS) $(ASFLAGS) $< -o $@
	@echo "    Object: $@"

# Создание директорий
$(BIN_DIR):
	@echo "==> Creating directory: $@"
	mkdir -p $@

$(OBJ_DIR):
	@echo "==> Creating directory: $@"
	mkdir -p $@

# =============================================================================
# Дополнительные цели
# =============================================================================

# Запуск программы
run: $(TARGET)
	@echo "==> Running program..."
	@$(TARGET) 3 0 10

# Запуск с тестовыми данными
test: $(TARGET)
	@echo "==> Running tests..."
	@echo "Test 1: 3x3 matrix (0-10)"
	@$(TARGET) 3 0 10
	@echo ""
	@echo "Test 2: 4x4 matrix (-50 to 50)"
	@$(TARGET) 4 -50 50
	@echo ""
	@echo "Test 3: 2x2 matrix (0-100)"
	@$(TARGET) 2 0 100

# Очистка временных файлов
clean:
	@echo "==> Cleaning object files and dependencies..."
	rm -f $(OBJ_DIR)/*.o $(OBJ_DIR)/*.d
	@echo "==> Clean complete"

# Полная очистка (включая исполняемый файл)
distclean: clean
	@echo "==> Removing executable and directories..."
	rm -f $(TARGET)
	rm -rf $(BIN_DIR)
	@echo "==> Distclean complete"

# Пересборка проекта
rebuild: distclean all

# Показать информацию о сборке
info:
	@echo "=== Build Configuration ==="
	@echo "Program name:   $(PROGRAM_NAME)"
	@echo "Target:         $(TARGET)"
	@echo "Syntax:         $(SYNTAX)"
	@echo "Input method:   $(INPUT_METHOD)"
	@echo "Debug mode:     $(DEBUG)"
	@echo "Compiler:       $(CC)"
	@echo "C Flags:        $(CFLAGS)"
	@echo "ASM Compiler:   $(ASM_COMPILER)"
	@echo "ASM Flags:      $(ASM_FLAGS)"
	@echo "Source dir:     $(SRC_DIR)"
	@echo "Binary dir:     $(BIN_DIR)"
	@echo "Object dir:     $(OBJ_DIR)"
	@echo ""
	@echo "=== Source Files ==="
	@echo "C sources:      $(C_SOURCES)"
	@echo "ASM source:     $(SRC_DIR)/$(ASM_SRC)"
	@echo ""
	@echo "=== Object Files ==="
	@echo "C objects:      $(C_OBJECTS)"
	@echo "ASM object:     $(ASM_OBJECT)"
	@echo ""
	@echo "=== Usage Examples ==="
	@echo "  make                    # Build with default settings"
	@echo "  make SYNTAX=att         # Build with AT&T syntax"
	@echo "  make INPUT_METHOD=random # Build with random input"
	@echo "  make DEBUG=yes          # Build with debug symbols"
	@echo "  make run                # Build and run"
	@echo "  make test               # Run tests"
	@echo "  make clean              # Clean object files"
	@echo "  make distclean          # Clean everything"

# Помощь
help:
	@echo "=== Available Targets ==="
	@echo "  all          - Build the program (default)"
	@echo "  run          - Build and run the program"
	@echo "  test         - Run test suite"
	@echo "  clean        - Remove object files and dependencies"
	@echo "  distclean    - Remove all generated files"
	@echo "  rebuild      - Clean and rebuild"
	@echo "  info         - Show build configuration"
	@echo "  help         - Show this help message"
	@echo ""
	@echo "=== Build Options ==="
	@echo "  SYNTAX       - Assembly syntax: intel (default) or att"
	@echo "  INPUT_METHOD - Input method: console (default), file, or random"
	@echo "  DEBUG        - Debug mode: yes or no (default)"
	@echo "  COMPILE_FLAGS - Additional compiler flags"
	@echo ""
	@echo "=== Examples ==="
	@echo "  make"
	@echo "  make SYNTAX=att"
	@echo "  make INPUT_METHOD=random DEBUG=yes"
	@echo "  make clean && make SYNTAX=att"

# Объявление фиктивных целей
.PHONY: all run test clean distclean rebuild info help

# Включение файлов зависимостей (если они существуют)
-include $(wildcard $(OBJ_DIR)/*.d)
