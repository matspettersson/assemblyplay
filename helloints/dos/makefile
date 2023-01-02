#all:  helloc.exe

#helloc_s.exe : 	helloc_s.obj helloint.obj
#	link helloc_s + helloint.obj;;;

#helloc_l.exe : helloc_l.obj helloint.obj
#	link helloc_l + helloint.obj;;;

helloc.exe: helloc.obj helloinn.obj
	link helloc+helloinn;;;

#helloc_s.obj : helloc.c
#	cc /AS  helloc.c;;;
#	ren helloc.obj helloc_s.obj

helloc.obj : helloc.c
	cc /AL helloc.c ;;;
#	ren helloc.obj helloc_l.obj

#helloint.obj: helloint.asm
#	masm  helloint.asm

helloinn.obj: helloinn.asm
	nasm -f obj helloinn.asm -o helloinn.obj

#clean:
#	del helloc_s.exe helloc_l.exe helloc_s.obj helloc_l.obj helloint.obj