	TITLE   c2

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
	
_TEXT      SEGMENT

	PUBLIC	_testprint
_testprint	PROC NEAR
	push	bp
	mov	bp,sp
	mov	dx, word ptr [bp + 4]
	mov	ah, 9
	int 	21h

	mov	ax, 0
	mov	sp,bp
	pop	bp
	ret	

_testprint	ENDP


	public	_readbootsector
_readbootsector proc	near
	push	bp
	mov	bp, sp

	mov	bx, word ptr [bp+4]
	add	bx,16

	mov	ah, 2
	mov	al, 1
	mov	ch, 0
	mov	cl, 1
	mov	dh, 0
	mov	dl, 1	; drive
	int	13h

	mov	sp, bp
	pop	bp
	ret
_readbootsector endp

_TEXT	ENDS
END
