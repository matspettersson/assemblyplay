global _helloint
global _helloints

;section .data

section .text

_helloint:
      push	bp
      mov   bp, sp
      mov	ax,[bp+6]	;a1
      and   ax, 1
      jz    even1
      mov   ax, 1
      jmp   finish1
even1:
     mov  ax, 0
finish1:
;      pop	si
;      pop	di
;      pop	dx
      mov	sp,bp
      pop	bp
      retf      

_helloints:
      push	bp
      mov	bp,sp
      mov	ax,[bp+6]	
      add	ax,[bp+8]
      add	ax,[bp+10]
      add	ax,[bp+12]
      add	ax,[bp+14]
      add	ax,[bp+16]
      add	ax,[bp+18]
      add	ax,[bp+20]
      add	ax,[bp+22]	
      pop	bp
      retf
