.386P
.MODEL flat
CODE32	SEGMENT DWORD USE32 PUBLIC 'CODE'
CODE32	ENDS
DATA32	SEGMENT DWORD USE32 PUBLIC 'DATA'
DATA32	ENDS
CONST32	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST32	ENDS
BSS32	SEGMENT DWORD USE32 PUBLIC 'BSS'
BSS32	ENDS
DGROUP	GROUP CONST32, BSS32, DATA32
	ASSUME	CS:FLAT, DS:FLAT, SS:FLAT, ES:FLAT

.STACK 4096

;.DATA

;.CODE

CODE32	SEGMENT

;***** 8 int helloc(a1, a2, a3, a4, a5, a6, a7, a8, a9) {  
	ALIGN 04H


public helloint
public helloints


helloint PROC
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,04H
	MOV	[EBP+08H],EAX;	a1
	MOV	[EBP+0cH],EDX;	a2
	MOV	[EBP+010H],ECX;	a3

      mov	eax, [ebp+8h]	;a1

      and   eax, 1
      jz    even1
      mov   eax, 1
      jmp   finish1
;even:
even1:
     mov  eax, 0

finish1:
;      pop	si
;      pop	di
;      pop	dx
      mov	esp,ebp
      pop	ebp
;	MOV	[EBP-04H],EAX;	ret
;	JMP	BLBL1
;	ALIGN 04H
;BLBL1:
;	LEAVE	
      ret

helloint ENDP

helloints   PROC
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,04H
	MOV	[EBP+08H],EAX;	a1
	MOV	[EBP+0cH],EDX;	a2
	MOV	[EBP+010H],ECX;	a3

      mov	eax,[ebp+08H]	;a1
      add	eax,[ebp+0CH]	;a2
      add	eax,[ebp+10H]
      add	eax,[ebp+14H]
      add	eax,[ebp+18H]
      add	eax,[ebp+1CH]
      add	eax,[ebp+20H]
      add	eax,[ebp+24H]
      add	eax,[ebp+28H]
      mov	esp,ebp

      pop	ebp
	MOV	[EBP-04H],EAX;	ret
;	JMP	BLBL2
;	ALIGN 04H
;BLBL2:
;	LEAVE	
      ret
helloints ENDP

CODE32 ENDS
END
