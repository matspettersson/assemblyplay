all: helloc 


helloc: helloc.o helloint.o
	gcc helloc.o helloint.o -o helloc -z noexecstack

helloc.o : helloc.c
	gcc -Dhellolin64 -c helloc.c

helloint.o: helloint.asm
	nasm  -f elf64 -l helloint.lst helloint.asm


clean:
	rm helloc.o helloint.o helloint.lst 
