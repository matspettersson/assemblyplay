	TITLE	HC.C
	.386
	.387
	INCLUDELIB os2386.lib
	INCLUDELIB dde4sbs.lib
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
	EXTRN	_printfieee:PROC
	EXTRN	helloint:PROC
	EXTRN	helloints:PROC
	EXTRN	_exeentry:PROC
DATA32	SEGMENT
@STAT1	DB "Hello, world! OS/2 32-bi"
DB "t",0H
	ALIGN 04H
@STAT2	DB "%s",0aH,0H
@STAT3	DB "Return value: %d, Intege"
DB "r a = %d is %s",0aH,0H
@STAT4	DB "odd",0H
@STAT5	DB "even",0H
	ALIGN 04H
@STAT6	DB "Return value: %d, Intege"
DB "r a = %d is %s",0aH,0H
@STAT7	DB "odd",0H
@STAT8	DB "even",0H
	ALIGN 04H
@STAT9	DB "Return value: %d, Intege"
DB "r a = %d is %s",0aH,0H
@STATa	DB "odd",0H
@STATb	DB "even",0H
	ALIGN 04H
@STATc	DB "Return value: %d, Intege"
DB "r a = %d is %s",0aH,0H
@STATd	DB "odd",0H
@STATe	DB "even",0H
	ALIGN 04H
@STATf	DB "Return value: %d, Intege"
DB "r a = %d is %s",0aH,0H
@STAT10	DB "odd",0H
@STAT11	DB "even",0H
	ALIGN 04H
@STAT12	DB "rc=%d (%d %d %d %d %d %d"
DB " %d %d %d)",0aH,0H
@STAT13	DB "rc=%d (%d %d %d %d %d %d"
DB " %d %d %d)",0aH,0H
@STAT14	DB "rc=%d (%d %d %d %d %d %d"
DB " %d %d %d)",0aH,0H
@STAT15	DB "rc=%d (%d %d %d %d %d %d"
DB " %d %d %d)",0aH,0H
	DD	_exeentry
DATA32	ENDS
BSS32	SEGMENT
BSS32	ENDS
CONST32	SEGMENT
CONST32	ENDS
CODE32	SEGMENT

;***** 8 int helloc(a1, a2, a3, a4, a5, a6, a7, a8, a9) {  
	ALIGN 04H

	PUBLIC helloc
helloc	PROC
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,04H
	MOV	[EBP+08H],EAX;	a1
	MOV	[EBP+0cH],EDX;	a2
	MOV	[EBP+010H],ECX;	a3

;***** 10 	ret = 0;
	MOV	DWORD PTR [EBP-04H],0H;	ret

;***** 11 	ret = a1;
	MOV	EAX,[EBP+08H];	a1
	MOV	[EBP-04H],EAX;	ret

;***** 12 	ret += a2;
	MOV	EAX,[EBP+0cH];	a2
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 13 	ret += a3;
	MOV	EAX,[EBP+010H];	a3
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 14 	ret += a4;
	MOV	EAX,[EBP+014H];	a4
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 15 	ret += a5;
	MOV	EAX,[EBP+018H];	a5
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 16 	ret += a6;
	MOV	EAX,[EBP+01cH];	a6
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 17 	ret += a7;
	MOV	EAX,[EBP+020H];	a7
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 18 	ret += a8;
	MOV	EAX,[EBP+024H];	a8
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 19 	ret += a9;
	MOV	EAX,[EBP+028H];	a9
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 20 
;***** 21 	return ret;
	MOV	EAX,[EBP-04H];	ret
	JMP	BLBL1
	ALIGN 04H

;***** 22 }
BLBL1:
	LEAVE	
	RET	
helloc	ENDP

;***** 25 int hellocints(a1, a2, a3, a4, a5, a6, a7, a8, a9) {  
	ALIGN 04H

	PUBLIC hellocints
hellocints	PROC
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,04H
	MOV	[EBP+08H],EAX;	a1
	MOV	[EBP+0cH],EDX;	a2
	MOV	[EBP+010H],ECX;	a3

;***** 31 	ret = 0;
	MOV	DWORD PTR [EBP-04H],0H;	ret

;***** 32 	ret = a1;
	MOV	EAX,[EBP+08H];	a1
	MOV	[EBP-04H],EAX;	ret

;***** 33 	ret += a2;
	MOV	EAX,[EBP+0cH];	a2
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 34 	ret += a3;
	MOV	EAX,[EBP+010H];	a3
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 35 	ret += a4;
	MOV	EAX,[EBP+014H];	a4
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 36 	ret += a5;
	MOV	EAX,[EBP+018H];	a5
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 37 	ret += a6;
	MOV	EAX,[EBP+01cH];	a6
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 38 	ret += a7;
	MOV	EAX,[EBP+020H];	a7
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 39 	ret += a8;
	MOV	EAX,[EBP+024H];	a8
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 40 	ret += a9;
	MOV	EAX,[EBP+028H];	a9
	ADD	EAX,[EBP-04H];	ret
	MOV	[EBP-04H],EAX;	ret

;***** 41 
;***** 42 	return ret;
	MOV	EAX,[EBP-04H];	ret
	JMP	BLBL2
	ALIGN 04H

;***** 43 }
BLBL2:
	LEAVE	
	RET	
hellocints	ENDP

;***** 45 int main() {
	ALIGN 04H

	PUBLIC main
main	PROC
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,024H

;***** 48 char *hello = "Hello, world! OS/2 32-bit";
	MOV	DWORD PTR [EBP-04H],OFFSET FLAT:@STAT1;	hello

;***** 49 int a = 0;
	MOV	DWORD PTR [EBP-08H],0H;	a

;***** 50 int rc = 0;
	MOV	DWORD PTR [EBP-0cH],0H;	rc

;***** 51 
;***** 52 	printf("%s\n",hello);
	PUSH	DWORD PTR [EBP-04H];	hello
	MOV	EAX,OFFSET FLAT:@STAT2
	SUB	ESP,04H
	CALL	_printfieee

;***** 53 
;***** 54 	a = 0;
	MOV	DWORD PTR [EBP-08H],0H;	a

;***** 55 	rc = helloint(a);
	MOV	EAX,[EBP-08H];	a
	CALL	helloint
	ADD	ESP,08H
	MOV	[EBP-0cH],EAX;	rc

;***** 56 	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	CMP	DWORD PTR [EBP-0cH],0H;	rc
	JE	BLBL3
	MOV	DWORD PTR [EBP-010H],OFFSET FLAT:@STAT4;	#137
	JMP	BLBL4
	ALIGN 04H
BLBL3:
	MOV	DWORD PTR [EBP-010H],OFFSET FLAT:@STAT5;	#137
BLBL4:
	PUSH	DWORD PTR [EBP-010H];	#137
	PUSH	DWORD PTR [EBP-08H];	a
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT3
	SUB	ESP,04H
	CALL	_printfieee

;***** 57 	a = 1;
	MOV	DWORD PTR [EBP-08H],01H;	a

;***** 58 	rc = helloint(a);
	MOV	EAX,[EBP-08H];	a
	CALL	helloint
	ADD	ESP,010H
	MOV	[EBP-0cH],EAX;	rc

;***** 59 	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	CMP	DWORD PTR [EBP-0cH],0H;	rc
	JE	BLBL5
	MOV	DWORD PTR [EBP-014H],OFFSET FLAT:@STAT7;	#138
	JMP	BLBL6
	ALIGN 04H
BLBL5:
	MOV	DWORD PTR [EBP-014H],OFFSET FLAT:@STAT8;	#138
BLBL6:
	PUSH	DWORD PTR [EBP-014H];	#138
	PUSH	DWORD PTR [EBP-08H];	a
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT6
	SUB	ESP,04H
	CALL	_printfieee

;***** 60 	a = 2;
	MOV	DWORD PTR [EBP-08H],02H;	a

;***** 61 	rc = helloint(a);
	MOV	EAX,[EBP-08H];	a
	CALL	helloint
	ADD	ESP,010H
	MOV	[EBP-0cH],EAX;	rc

;***** 62 	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	CMP	DWORD PTR [EBP-0cH],0H;	rc
	JE	BLBL7
	MOV	DWORD PTR [EBP-018H],OFFSET FLAT:@STATa;	#139
	JMP	BLBL8
	ALIGN 04H
BLBL7:
	MOV	DWORD PTR [EBP-018H],OFFSET FLAT:@STATb;	#139
BLBL8:
	PUSH	DWORD PTR [EBP-018H];	#139
	PUSH	DWORD PTR [EBP-08H];	a
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT9
	SUB	ESP,04H
	CALL	_printfieee

;***** 63 	a = 3;
	MOV	DWORD PTR [EBP-08H],03H;	a

;***** 64 	rc = helloint(a);
	MOV	EAX,[EBP-08H];	a
	CALL	helloint
	ADD	ESP,010H
	MOV	[EBP-0cH],EAX;	rc

;***** 65 	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	CMP	DWORD PTR [EBP-0cH],0H;	rc
	JE	BLBL9
	MOV	DWORD PTR [EBP-01cH],OFFSET FLAT:@STATd;	#140
	JMP	BLBL10
	ALIGN 04H
BLBL9:
	MOV	DWORD PTR [EBP-01cH],OFFSET FLAT:@STATe;	#140
BLBL10:
	PUSH	DWORD PTR [EBP-01cH];	#140
	PUSH	DWORD PTR [EBP-08H];	a
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STATc
	SUB	ESP,04H
	CALL	_printfieee

;***** 66 	a = 8;
	MOV	DWORD PTR [EBP-08H],08H;	a

;***** 67 	rc = helloint(a);
	MOV	EAX,[EBP-08H];	a
	CALL	helloint
	ADD	ESP,010H
	MOV	[EBP-0cH],EAX;	rc

;***** 68 	printf("Return value: %d, Integer a = %d is %s\n", rc, a, rc ? "odd" : "even");
	CMP	DWORD PTR [EBP-0cH],0H;	rc
	JE	BLBL11
	MOV	DWORD PTR [EBP-020H],OFFSET FLAT:@STAT10;	#141
	JMP	BLBL12
	ALIGN 04H
BLBL11:
	MOV	DWORD PTR [EBP-020H],OFFSET FLAT:@STAT11;	#141
BLBL12:
	PUSH	DWORD PTR [EBP-020H];	#141
	PUSH	DWORD PTR [EBP-08H];	a
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STATf
	SUB	ESP,04H
	CALL	_printfieee

;***** 69 	rc = helloints(1, 2, 3, 4, 5, 6, 7, 8, 9);
	PUSH	09H
	PUSH	08H
	PUSH	07H
	PUSH	06H
	PUSH	05H
	PUSH	04H
	MOV	ECX,03H
	MOV	EDX,02H
	MOV	EAX,01H
	SUB	ESP,0cH
	CALL	helloints
	MOV	[EBP-0cH],EAX;	rc

;***** 70 	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 2, 3, 4, 5, 6, 7, 8, 9);
	PUSH	09H
	PUSH	08H
	PUSH	07H
	PUSH	06H
	PUSH	05H
	PUSH	04H
	PUSH	03H
	PUSH	02H
	PUSH	01H
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT12
	SUB	ESP,04H
	CALL	_printfieee

;***** 71 /*
;***** 72 	rc = hellocints(1, 2, 3, 4, 5, 6, 7, 8, 9);
;***** 73 	printf("crc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 2, 3, 4, 5, 6, 7, 8, 9);
;***** 74 */
;***** 75 
;***** 76 	rc = helloints(1, 1, 1, 1, 1, 5, 0, 0, 0);
	PUSH	0H
	PUSH	0H
	PUSH	0H
	PUSH	05H
	PUSH	01H
	PUSH	01H
	MOV	ECX,01H
	MOV	EDX,01H
	MOV	EAX,01H
	SUB	ESP,0cH
	CALL	helloints
	MOV	[EBP-0cH],EAX;	rc

;***** 77 	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 1, 1, 1, 1, 1, 5, 0, 0, 0);
	PUSH	0H
	PUSH	0H
	PUSH	0H
	PUSH	05H
	PUSH	01H
	PUSH	01H
	PUSH	01H
	PUSH	01H
	PUSH	01H
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT13
	SUB	ESP,04H
	CALL	_printfieee

;***** 78 
;***** 79 	rc = helloints(9, 9, 9, 9, 10, 10, 10, 10, 10);
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	09H
	MOV	ECX,09H
	MOV	EDX,09H
	MOV	EAX,09H
	SUB	ESP,0cH
	CALL	helloints
	MOV	[EBP-0cH],EAX;	rc

;***** 80 	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 9, 9, 9, 9, 10, 10, 10, 10, 10);
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	09H
	PUSH	09H
	PUSH	09H
	PUSH	09H
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT14
	SUB	ESP,04H
	CALL	_printfieee
	ADD	ESP,0100H

;***** 81 
;***** 82 
;***** 83 	rc = helloc(9, 9, 9, 9, 10, 10, 10, 10, 10);
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	09H
	MOV	ECX,09H
	MOV	EDX,09H
	MOV	EAX,09H
	SUB	ESP,0cH
	CALL	helloc
	MOV	[EBP-0cH],EAX;	rc

;***** 84 	printf("rc=%d (%d %d %d %d %d %d %d %d %d)\n", rc, 9, 9, 9, 9, 10, 10, 10, 10, 10);
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	0aH
	PUSH	09H
	PUSH	09H
	PUSH	09H
	PUSH	09H
	PUSH	DWORD PTR [EBP-0cH];	rc
	MOV	EAX,OFFSET FLAT:@STAT15
	SUB	ESP,04H
	CALL	_printfieee
	ADD	ESP,050H

;***** 85 
;***** 86 
;***** 87 /*
;***** 88 	rc = hellocints(1, 1, 1, 1, 1, 5, 0, 0, 0);
;***** 89 	printf("crc=%d\n", rc);
;***** 90 */
;***** 91 }
	XOR	EAX,EAX
	JMP	BLBL13
	ALIGN 04H
BLBL13:
	ADD	ESP,04H
	LEAVE	
	RET	
main	ENDP
CODE32	ENDS
END
