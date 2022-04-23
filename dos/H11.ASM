_TEXT	SEGMENT
	ASSUME CS:_TEXT, DS: _TEXT, ES: _TEXT, SS:_TEXT
	ORG	100H

START:
	mov	dx, 0000h
	mov	bx, 0
	mov	bl, 0fh
	mov cx, msglen
	mov	al, 1
	mov bp, offset msg
	mov	ah, 13h
	int	10h

	ret

	msg db "Another Hello world using int 10h!", 0dh,0ah
	msglen equ $-msg

_TEXT	ENDS
end	START
