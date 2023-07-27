all: armstrong test

test: test.o armstrongasm.o
	gcc test.o armstrongasm.o  -z noexecstack -no-pie -o test

armstrong: armstrong.o
	ld armstrongasm.o -o armstrong 

armstrongasm.o: armstrongasm.asm makefile
	nasm -f elf64 -gdwarf armstrongasm.asm

#testasm.o: testasm.asm makefile
#	nasm -f elf64 -gdwarf testasm.asm

test.o: test.c makefile
	gcc -c test.c

clean:
	rm armstrong armstrong.o armstrong.o test.o armstrongasm.o
