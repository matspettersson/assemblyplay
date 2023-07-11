all: armstrong

#armstrong: armstrong.o armstrongasm.o
#	gcc armstrong.o armstrongasm.o  -z noexecstack -no-pie -o armstrong

armstrong: armstrongasm.o
	ld armstrongasm.o -o armstrong 


armstrongasm.o : armstrongasm.asm makefile
	nasm -f elf64 -gdwarf armstrongasm.asm

armstrong.o : armstrong.c makefile
#	gcc -c -S armstrong.c

clean:
	rm armstrong armstrong.o armstrong.o 
