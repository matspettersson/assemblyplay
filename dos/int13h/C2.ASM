
	TITLE   c2

extrn _printf:near

_TEXT	SEGMENT  WORD PUBLIC 'CODE'
_TEXT	ENDS

_DATA	SEGMENT  WORD PUBLIC 'DATA'
p1	db 'In asm. Address: %x',0dH,0aH,0
p2	db 'str=%s',0dh,0ah,0
p3	db 'l1=%d, l2=%d, s=%s', 0dh, 0ah, 0
p3a	db 'l1=%d, l2=%d', 0dh, 0ah, 0
val1	dw 5
segm	dw	?
offs	dw	?
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

	mov	ax, word ptr [bp+4]
	push	ax
	mov	ax, offset dgroup:p2
	push	ax
	call	_printf
	add	sp, 4

;	mov	ax, ds
;	mov	ds, ax
;	mov	es, ax

	mov	bx, word ptr [bp+4]
;	add	bx,16
;	sub	bx,16

	mov	ah, 2
	mov	al, 1
	mov	ch, 0
	mov	cl, 1
	mov	dh, 0
	mov	dl, 1	; drive
	int	13h

;	mov	ax, cs
;	mov	ds, ax
;	mov	es, ax

	mov	sp, bp
	pop	bp
	ret
_readbootsector endp


	public	_allocmem
_allocmem	proc near
	mov	ah, 48h
	mov	bx, 34	; 32 paragraphs = 512byte
	int	21h
	ret
_allocmem	endp


	public	_getsegoff
_getsegoff	proc near
	push	bp
	mov	bp, sp

; 8 / 6 / 4

	mov	ax, word ptr [bp+8]
	mov	offs, ax
	mov	ax, ds
	mov	segm, ax

	mov	bx, word ptr [bp+4]
	mov	[bx], ax
	mov	ax, offs
	mov	bx, word ptr [bp+6]
	mov	[bx], ax

;	mov	bx, ax
;	mov	ax, val1
;	mov	[bx], ax
;	mov	segm, ax
;	mov	bx, segm
;	mov	ax, 16
;	mul	bx
;	add	ax, offs
	
;	mov	bx, word ptr [bp+4]
;	add	ax, [bx]

;	push	bx
;	mov	bx, word ptr [bp+8]
;	push	bx
;	mov	ax, offset dgroup:p3a
;	push	ax
;	call	_printf
;	add	sp,6

;	mov	ax, word ptr [bp+12]
;	mov	ax, 10
;	mov	bx, word ptr [bp+2]

;	mov	[bx], ax
;	mov	bx, word ptr [bp+4]
;	mov	ax, 20
;	mov	[bx], ax

	pop	bp
	ret
_getsegoff	endp

_TEXT	ENDS
END
