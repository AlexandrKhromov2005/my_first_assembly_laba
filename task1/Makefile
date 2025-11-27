ASM = nasm
LD = ld
ASMFLAGS = -f elf32
LDFLAGS = -m elf_i386

TARGET = task1
ASM_SRC = task1.asm
ASM_OBJ = task1.o

all: $(TARGET)

$(ASM_OBJ): $(ASM_SRC)
	$(ASM) $(ASMFLAGS) $(ASM_SRC) -o $(ASM_OBJ)

$(TARGET): $(ASM_OBJ)
	$(LD) $(LDFLAGS) $(ASM_OBJ) -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET) $(ASM_OBJ)

.PHONY: all run clean
