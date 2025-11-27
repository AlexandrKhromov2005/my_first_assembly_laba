ASM = nasm
AS = as
LD = ld
ASMFLAGS = -f elf32
ASFLAGS = --32
LDFLAGS = -m elf_i386

TARGET_INTEL = task1
TARGET_ATT = task1_att
ASM_SRC_INTEL = task1.asm
ASM_SRC_ATT = task1_att.s
ASM_OBJ_INTEL = task1.o
ASM_OBJ_ATT = task1_att.o

all: intel att

intel: $(TARGET_INTEL)

att: $(TARGET_ATT)

$(ASM_OBJ_INTEL): $(ASM_SRC_INTEL)
	$(ASM) $(ASMFLAGS) $(ASM_SRC_INTEL) -o $(ASM_OBJ_INTEL)

$(ASM_OBJ_ATT): $(ASM_SRC_ATT)
	$(AS) $(ASFLAGS) $(ASM_SRC_ATT) -o $(ASM_OBJ_ATT)

$(TARGET_INTEL): $(ASM_OBJ_INTEL)
	$(LD) $(LDFLAGS) $(ASM_OBJ_INTEL) -o $(TARGET_INTEL)

$(TARGET_ATT): $(ASM_OBJ_ATT)
	$(LD) $(LDFLAGS) $(ASM_OBJ_ATT) -o $(TARGET_ATT)

run: $(TARGET_INTEL)
	./$(TARGET_INTEL)

run-att: $(TARGET_ATT)
	./$(TARGET_ATT)

test: all
	@echo "Intel syntax:"
	./$(TARGET_INTEL)
	@echo "\nAT&T syntax:"
	./$(TARGET_ATT)

clean:
	rm -f $(TARGET_INTEL) $(TARGET_ATT) $(ASM_OBJ_INTEL) $(ASM_OBJ_ATT)

.PHONY: all intel att run run-att test clean
