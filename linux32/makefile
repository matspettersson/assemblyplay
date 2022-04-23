all: hello

hello: hello.o
	ld -m elf_i386 hello.o -o hello

hello.o: hello.asm
	nasm  -f elf32 -l hello.lst hello.asm

clean:
	rm hello hello.o hello.lst
