all: roman arab

roman: roman.o romanasm.o
	gcc roman.o romanasm.o  -z noexecstack -no-pie -o roman

arab: arabic.o arabicasm.o
	gcc arabic.o arabicasm.o  -z noexecstack -no-pie -o arabic

romanasm.o : romanasm.asm makefile
	nasm -f elf64 -gdwarf romanasm.asm

roman.o : roman.c
	gcc -c roman.c

clean:
	rm roman roman.o romanasm.o arabic arabic.o arabicasm.o
