_TEXT	SEGMENT
	ASSUME CS:_TEXT, DS: _TEXT, ES: _TEXT, SS:_TEXT
	ORG	100H

START:

	mov	si, offset msg
	mov	ah, 0eh
	mov	cx, msglen
l1:
	mov	al,[si]
	int	10h
	inc	si
	loop 	l1

	mov	ah,10h	; int 16h ("press any key....")
	int	16h
	ret

	msg db "hello world using int 10h!", 0dh,0ah
	msglen equ $-msg

_TEXT	ENDS
end	START