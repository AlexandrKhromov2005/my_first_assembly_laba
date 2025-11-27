ASM = nasm
AS = as
CC = gcc
ASMFLAGS = -f elf32
ASFLAGS = --32
CFLAGS = -m32 -Wall

TARGET_INTEL = program
TARGET_ATT = program_att
ASM_SRC_INTEL = rotate.asm
ASM_SRC_ATT = rotate_att.s
C_SRC = main.c
ASM_OBJ_INTEL = rotate.o
ASM_OBJ_ATT = rotate_att.o
C_OBJ = main.o

all: intel att

intel: $(TARGET_INTEL)

att: $(TARGET_ATT)

$(ASM_OBJ_INTEL): $(ASM_SRC_INTEL)
	$(ASM) $(ASMFLAGS) $(ASM_SRC_INTEL) -o $(ASM_OBJ_INTEL)

$(ASM_OBJ_ATT): $(ASM_SRC_ATT)
	$(AS) $(ASFLAGS) $(ASM_SRC_ATT) -o $(ASM_OBJ_ATT)

$(C_OBJ): $(C_SRC)
	$(CC) $(CFLAGS) -c $(C_SRC) -o $(C_OBJ)

$(TARGET_INTEL): $(ASM_OBJ_INTEL) $(C_OBJ)
	$(CC) $(CFLAGS) $(C_OBJ) $(ASM_OBJ_INTEL) -o $(TARGET_INTEL)

$(TARGET_ATT): $(ASM_OBJ_ATT) $(C_OBJ)
	$(CC) $(CFLAGS) $(C_OBJ) $(ASM_OBJ_ATT) -o $(TARGET_ATT)

run: $(TARGET_INTEL)
	./$(TARGET_INTEL) 5

run-att: $(TARGET_ATT)
	./$(TARGET_ATT) 5

test: all
	@echo "=== Intel syntax ==="
	@echo "Test 1: 3x3 matrix"
	./$(TARGET_INTEL) 3 0 10
	@echo "\nTest 2: 4x4 matrix"
	./$(TARGET_INTEL) 4 -50 50
	@echo "\n=== AT&T syntax ==="
	@echo "Test 1: 3x3 matrix"
	./$(TARGET_ATT) 3 0 10
	@echo "\nTest 2: 4x4 matrix"
	./$(TARGET_ATT) 4 -50 50

clean:
	rm -f $(TARGET_INTEL) $(TARGET_ATT) $(ASM_OBJ_INTEL) $(ASM_OBJ_ATT) $(C_OBJ)

.PHONY: all intel att run run-att test clean
