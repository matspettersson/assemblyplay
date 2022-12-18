; .MODEL SMALL
; .CODE

_TEXT	SEGMENT
;	ASSUME CS:_TEXT, DS: _TEXT, ES: _TEXT, SS:_TEXT
	ASSUME CS:_TEXT

_max PROC NEAR                ;return value is in AX
        PUBLIC _max
        PUSH BP
        MOV BP,SP
        MOV AX,[BP+4]    ;AX=a
        CMP AX,[BP+6]    ;a=b?
        JGE endl         ;jump if a>=b
        MOV AX,[BP+6]    ;else AX=b
endl:
        POP BP
        RET
_max ENDP


_swap PROC NEAR
        PUBLIC _swap
        PUSH BP
        MOV BP,SP
        MOV SI,[BP+4]    ;SI=adresa a
        MOV DI,[BP+6]    ;DI=adresa b
        MOV AX,[SI]      ;AX=a
        MOV BX,[DI]      ;BX=b
        MOV [SI],BX      ;a=b
        MOV [DI],AX      ;b=a
        POP BP
        RET
_swap ENDP

;ENDS
_TEXT	ENDS
END
