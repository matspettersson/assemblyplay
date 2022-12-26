all: hellofromc 


hellofromc: hellofromc.o helloint.o
	gcc hellofromc.o helloint.o -o hellofromc -z noexecstack

hellofromc.o : hellofromc.c
	gcc -c hellofromc.c

helloint.o: helloint.asm
	nasm  -f elf64 -l helloint.lst helloint.asm


clean:
	rm hellofromc.o helloint.o helloint.lst 
