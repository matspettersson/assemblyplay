all: helloc_s.exe  helloc_l.exe 

helloc_s.exe : helloc_s.obj helloint.obj
	link helloc_s + helloint.obj;;;

helloc_l.exe : helloc_l.obj helloint.obj
	link helloc_l + helloint.obj;;;

helloc_s.obj : helloc.c
	cc /AS  helloc.c;;;
	ren helloc.obj helloc_s.obj

helloc_l.obj : helloc.c
	cc /AL helloc.c ;;;
	ren helloc.obj helloc_l.obj

helloint.obj: helloint.asm
	masm /c /Flhelloint.lst helloint.asm

clean:
	del helloc_s.exe helloc_l.exe helloc_s.obj helloc_l.obj helloint.obj helloint.lst
