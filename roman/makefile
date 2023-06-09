all: roman

roman: roman.o romanasm.o chatgpt-roman.o
	gcc roman.o romanasm.o chatgpt-roman.o -z noexecstack -no-pie -o roman

romanasm.o : romanasm.asm makefile
	nasm -f elf64 -gdwarf romanasm.asm

chatgpt-roman.o : chatgpt-roman.asm makefile
	nasm -f elf64 chatgpt-roman.asm

roman.o : roman.c
	gcc -c roman.c

clean:
	rm roman roman.o romanasm.o
