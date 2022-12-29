all: hc_s.exe  hc_m.exe hc_l.exe 
# hc_h.exe

hc_s.exe : hc_s.obj
	link hc_s + hint.obj;;;

hc_h.exe : hc_h.obj
	link hc_h + hint.obj;;;

#hc_m.exe : hc_m.obj
#	link hc_m + hint.obj;;;

hc_l.exe : hc_l.obj
	link hc_l + hint.obj;;;

hc_s.obj : hc.c
	cc /AS  hc.c;;;
	ren hc.obj hc_s.obj

hc_m.obj : hc.c
	cc /AM hc.c ;;;
	ren hc.obj hc_m.obj

hc_l.obj : hc.c
	cc /AL hc.c ;;;
	ren hc.obj hc_l.obj

#hc_h.obj : hc.c
#	cc /AH  hc.c ;;;
#	ren hc.obj hc_h.obj


clean:
	del hc_s.exe hc_h.exe hc_m.exe hc_l.exe hc_s.obj hc_h.obj hc_m.obj hc_l.obj
