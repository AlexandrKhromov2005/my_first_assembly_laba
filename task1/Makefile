build:
	echo "Start building..."
	nasm -f elf32 task1.asm -o task1.o
	echo "task1.o is ready"

link: build
	echo "Start linking..."
	ld -m elf_i386 task1.o -o task1
	echo "task1 is ready"

run: link
	echo "Start running..."
	echo "task1 has finished running with code: $$?" 

clean:
	rm -f task1 task1.o
	echo "Cleaning is finished!"
