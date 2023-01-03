all: helloc.exe

helloc.exe: helloc.obj helloint.obj
	link helloc.obj helloint.obj

helloc.obj : helloc.c
	cl -c helloc.c -D hellowin64

helloint.obj: helloint.asm
	ml64 /c /Flhelloint.lst helloint.asm


helloinn.obj: helloinn.asm
	nasm -f win64 helloinn.asm -o helloinn.obj

clean:
	del helloc.obj helloc.exe helloint.obj helloint.lst