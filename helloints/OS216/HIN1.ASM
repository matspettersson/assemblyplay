;PUBLIC  _helloint
;PUBLIC  _helloints
.386P
.MODEL flat

.STACK 4096

.DATA

CODE
_helloint PROC

      push	bp
      mov   bp, sp
;      push	dx
;      push	di
;      push	si

      mov	ax,[bp+4]	;a1

      and   ax, 1
      jz    even1
      mov   ax, 1
      jmp   finish1
;even:
even1:
     mov  ax, 0

finish1:
      pop	si
      pop	di
      pop	dx
      mov	sp,bp
      pop	bp

      ret

_helloint ENDP

;
;In 64-bit Linux system, function arguments of type integer/pointers are passed to the callee function in the following way:
;Arguments 1-6 are passed via registers RDI, RSI, RDX, RCX, R8, R9 respectively;
;
;    Arguments 7 and above are pushed on to the stack.
;
;Once inside the callee function:
;Arguments 1-6 are accessed via registers RDI, RSI, RDX, RCX, R8, R9 before they are modified or via  offsets from the RBP register like so: rbp - $offset. For example, if the first argument passed to the callee is int (4 bytes) and there are no local variables defined in the function, we could access it via rbp - 0x4; 
;It's worth noting, that:
;if the 1st argument was 8 bytes (for example, long int), we'd access it via rbp - 0x8;
;if the callee function had 1 local variable defined that is smaller or equal to 16 bytes, the first argument of type int would be accessed via rbp - (0x10 + 0x4) or simply rbp - 0x14;
;if the callee function had more than 16 bytes reserved for local variables, we'd access the first argument of type int via rbp - 0x24, which suggests that with every 16 bytes worth of local variables defined, the first argument is shifted by 0x10 bytes as shown 
;
;
;
;Argument 7 can be accessed via rbp + 0x10, argument 8 via rbp + 0x18 and so on.


;helloints:
_helloints   PROC
      push	bp

      mov	bp,sp
      mov	ax,[bp+4]	;a1
      add	ax,[bp+6]	;a2
      add	ax,[bp+8]
      add	ax,[bp+10]
      add	ax,[bp+12]
      add	ax,[bp+14]
      add	ax,[bp+16]
      add	ax,[bp+18]
      add	ax,[bp+20]

      pop	bp
      ret
_helloints ENDP


END
