;global helloint:function
;:global helloints:function

;hellodos_l	equ	1

PUBLIC _helloint
PUBLIC _helloints

;assume cs:_TEXT, ds:_DATA, es: _DATA, ss:_STACK


_TEXT	SEGMENT  BYTE PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT  WORD PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT  WORD PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT  WORD PUBLIC 'BSS'
_BSS	ENDS
DGROUP	GROUP	CONST,	_BSS,	_DATA
	ASSUME  CS: _TEXT, DS: DGROUP, SS: DGROUP, ES: DGROUP


_DATA SEGMENT
;	db	hellodos_l	1
_DATA ENDS
;_STACK SEGMENT
;_STACK ENDS

_TEXT SEGMENT
;section .data

;section .text

ifdef hellodos_l
_helloint PROC FAR
else
_helloint PROC NEAR
endif

; Integer arguments are passed in registers RCX, RDX, R8, and R9.
; https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170
;helloint:

;
;	*** 000000	55 			push	bp
;	*** 000001	8b ec 			mov	bp,sp
;	*** 000003	b8 02 00 		mov	ax,2
;	*** 000006	e8 00 00 		call	__chkstk
;	ret = -2
;|*** /* int hellocints(int , int , int , int , int , int , int , int , int ) { */
;|*** 	int ret;
;|*** 	/*
;|*** 	, a1, a2, a3, a4, a5, a6, a7, a8, a9;
;|*** 	*/
;|*** 	ret = 0;
; Line 14
;	*** 000009	c7 46 fe 00 00 		mov	WORD PTR [bp-2],0	;ret
;|*** 	ret = a1;
; Line 15
;	*** 00000e	8b 46 04 		mov	ax,[bp+4]	;a1
;	*** 000011	89 46 fe 		mov	[bp-2],ax	;ret
;|*** 	ret += a2;
; Line 16
;	*** 000014	8b 46 06 		mov	ax,[bp+6]	;a2
;	*** 000017	01 46 fe 		add	[bp-2],ax	;ret
;
      push	bp
      mov   bp, sp
;      push	dx
;      push	di
;      push	si

ifdef hellodos_l
      mov	ax,[bp+6]	;a1
else
      mov	ax,[bp+4]	;a1
endif
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

ifdef hellodos_l
_helloints PROC FAR
else
_helloints PROC NEAR
endif

      push	bp

      mov	bp,sp

ifdef hellodos_l
      mov	ax,[bp+6]	;a1
else
      mov	ax,[bp+4]	;a1
      add	ax,[bp+6]	;a2
endif
      add	ax,[bp+8]
      add	ax,[bp+10]
      add	ax,[bp+12]
      add	ax,[bp+14]
      add	ax,[bp+16]
      add	ax,[bp+18]
      add	ax,[bp+20]
ifdef hellodos_l
      add	ax,[bp+22]
endif
      pop	bp
      ret
_helloints ENDP

_TEXT ENDS

END
