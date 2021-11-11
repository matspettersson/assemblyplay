all: hello hellofromc

hellofromc: hellofromc.o helloint.o
	gcc hellofromc.o helloint.o -o hellofromc

hellofromc.o : hellofromc.c
	gcc -c hellofromc.c

helloint.o: helloint.asm
	nasm  -f elf64 -l helloint.lst helloint.asm

hello: hello.o
	ld hello.o -o hello

hello.o: hello.asm
	nasm  -f elf64 -l hello.lst hello.asm

clean:
	rm hello hello.o hello.lst hellofromc.o helloint.o helloint.lst
