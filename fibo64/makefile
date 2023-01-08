all: fibo.exe

fibo.exe: fibo.obj fiboasm.obj
	link fibo.obj fiboasm.obj

fibo.obj : fibo.c
	cl -c -Fafibo.lst fibo.c

fiboasm.obj: fiboasm.asm
	..\nasm -f win64 fiboasm.asm -o fiboasm.obj -l fiboasm.lst

clean:
	del fibo.obj fibo.exe 