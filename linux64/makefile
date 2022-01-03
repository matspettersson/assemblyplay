all: hello hellofromc testhex fatplay

fatplay : fatplay.o
	#ld fatplay.o -o fatplay
	gcc fatplay.o -o fatplay

fatplay.o: fatplay.asm makefile
	nasm -felf64 fatplay.asm

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

testhex: testhex.o hexdisp.o
	gcc testhex.o hexdisp.o -o testhex

testhex.o: testhex.c makefile
	gcc -c testhex.c

hexdisp.o: hexdisp.asm makefile
	nasm -f elf64 -l hexdisp.lst hexdisp.asm

clean:
	rm hello hello.o hello.lst hellofromc.o helloint.o helloint.lst
