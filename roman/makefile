all: roman arabic

roman: roman.o romanasm.o
	gcc roman.o romanasm.o  -z noexecstack -no-pie -o roman

arabic: arabic.o arabicasm.o
	gcc arabic.o arabicasm.o  -z noexecstack -no-pie -o arabic

romanasm.o : romanasm.asm makefile
	nasm -f elf64 -gdwarf romanasm.asm

arabicasm.o : arabicasm.asm makefile
	nasm -f elf64 -gdwarf arabicasm.asm

roman.o : roman.c
	gcc -c roman.c

arabic.o : arabic.c
	gcc -c arabic.c

clean:
	rm roman roman.o romanasm.o arabic arabic.o arabicasm.o
