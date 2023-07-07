all: roar

roar: roar.o roarasm.o
	gcc roar.o roarasm.o  -z noexecstack -no-pie -o roar

roarasm.o : roarasm.asm makefile
	nasm -f elf64 -gdwarf roarasm.asm

roar.o : roar.c
	gcc -c roar.c

clean:
	rm roar roar.o roar.o 
