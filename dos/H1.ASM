_TEXT	SEGMENT
	ASSUME CS:_TEXT, DS: _TEXT, ES: _TEXT, SS:_TEXT
	ORG	100H

START:
	mov	ah,09h
	mov	dx, offset msg
	int	21h
	mov	ah,4ch
	int	21h

	msg db "hello world", 0dh,0ah,'$'

_TEXT	ENDS
end	START
