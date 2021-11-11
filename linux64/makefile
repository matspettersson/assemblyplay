$src = hello
all: hello

hello: hello.o
	ld hello.o -o hello

hello.o: hello.asm
	nasm  -f elf64 -l hello.lst hello.asm 

clean:
	rm hello hello.o hello.lst
