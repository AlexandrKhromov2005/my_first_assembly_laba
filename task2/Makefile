ASM = nasm
CC = gcc
ASMFLAGS = -f elf32
CFLAGS = -m32 -Wall

TARGET = program
ASM_SRC = rotate.asm
C_SRC = main.c
ASM_OBJ = rotate.o
C_OBJ = main.o

all: $(TARGET)

$(ASM_OBJ): $(ASM_SRC)
	$(ASM) $(ASMFLAGS) $(ASM_SRC) -o $(ASM_OBJ)

$(C_OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c $(C_SRC) -o $(C_OBJ)

$(TARGET): $(ASM_OBJ) $(C_OBJ)
	$(CC) $(CFLAGS) $(C_OBJ) $(ASM_OBJ) -o $(TARGET)

run: $(TARGET)
	./$(TARGET) 5

test: $(TARGET)
	@echo "Test 1: 3x3 matrix"
	./$(TARGET) 3 0 10
	@echo "\nTest 2: 4x4 matrix"
	./$(TARGET) 4 -50 50

clean:
	rm -f $(TARGET) $(ASM_OBJ) $(C_OBJ)

.PHONY: all run test clean
