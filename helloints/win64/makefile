all: helloc.exe

helloc.exe: helloc.obj helloint.obj
	link helloc.obj helloint.obj

helloc.obj : helloc.c
	cl -c helloc.c

helloint.obj: helloint.asm
	ml64 /c /Flhelloint.lst helloint.asm

clean:
	del helloc.obj helloc.exe helloint.obj helloint.lst