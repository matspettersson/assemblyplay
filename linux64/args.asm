extern print_uint32, print, printcrlf


sys_exit	equ	60		; the linux EXIT syscall

section .data

section .text
global _start
_start:
    pop     rax 	; number of arguments
    mov     r8, rax

    mov     rdi, rax
    call    print_uint32

top:
	cmp	r8,	0
	jz	exit

    pop     rdi
    call    print
    call    printcrlf
	
	dec	r8
	jmp	top

exit:
	mov	rax,	sys_exit
	mov	rdi,	0
	syscall