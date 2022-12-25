all: hello hellofromc testhex fatplay h1 conv matslib.o args logictests

h1 : h1.o
	ld h1.o -o h1

h1.o : h1.asm makefile
	nasm -f elf64 -g -F dwarf h1.asm

matslib.o : matslib.asm makefile
		nasm -f elf64 -g -F dwarf matslib.asm

conv : conv.o matslib.o
		ld conv.o matslib.o -o conv

conv.o : conv.asm makefile
		nasm -f elf64 -g -F dwarf conv.asm

fatplay : fatplay.o
	#ld fatplay.o -o fatplay
	gcc fatplay.o -o fatplay

fatplay.o: fatplay.asm makefile
	nasm -felf64 fatplay.asm

hellofromc: hellofromc.o helloint.o
	gcc hellofromc.o helloint.o -o hellofromc -z noexecstack

hellofromc.o : hellofromc.c
	gcc -c hellofromc.c

helloint.o: helloint.asm
	nasm  -f elf64 -l helloint.lst helloint.asm

hello: hello.o
	ld hello.o -o hello

hello.o: hello.asm
	nasm  -f elf64 -l hello.lst hello.asm

testhex: testhex.o hexdisp.o
	gcc testhex.o hexdisp.o -o testhex

testhex.o: testhex.c makefile
	gcc -c testhex.c

hexdisp.o: hexdisp.asm makefile
	nasm -f elf64 -l hexdisp.lst hexdisp.asm

args: args.o makefile matslib.o
	ld args.o matslib.o -o args

args.o: args.asm makefile
	nasm -f elf64 -l args.lst args.asm

logictests: logictests.o makefile
	ld logictests.o -o logictests

logictests.o: logictests.asm
	nasm -f elf64 -l logictests.lst logictests.asm

clean:
	rm hello hello.o hello.lst hellofromc.o helloint.o helloint.lst logictests.lst
