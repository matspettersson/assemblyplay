global checkarmstrong:function
;global _start

section .bss

section .rodata
msg:      db "Hello, world! Linux 64-bit", 13, 10
msglen:   equ $ - msg


section .data
sys_write   equ 1
sys_stdout  equ 1
linebreak db 0x0A, 0X0D

section .text

_startX:
    ; Pop the number of arguments from the stack.
    pop   rbx

    ; Discard the program name, since we only want
    ; the command line arguments.
    pop   rsi
    
    ; If there are no extra command line argments,
    ; just exit directly!
    dec   rbx
    jz    exit

top:
    mov     rdi, [rsp]                  ; check argument
    call    checkparm

    mov   edx, eax
    mov   eax, sys_write
    mov   edi, sys_stdout
    pop   rsi
    syscall

    mov   eax, sys_write
    mov   edi, sys_stdout
    mov   esi, linebreak
    mov   edx, 2
    syscall

    ; If `dec r8` is not zero, goto top.
    dec   rbx
    jnz   top

exit:
    mov rdi, rcx                    ; exit code in rcx
    mov rax, 60
    
    syscall


exitX:
	mov	rax,	60	; load the EXIT syscall number into rax
	mov	rdi,	0		; the program return code
	syscall				; execute the system call
      mov   rax, 1        ;  write
      mov   rdi, 1        ;  STDOUT
      mov   rsi, msg
      mov   rdx, msglen
      syscall

      mov   rax, 60       ; exit
      mov   rdi, 0        ; rc 0
      syscall


global checkarmstrong
; checkarmstrong
;
; rdi = int
checkarmstrong:
      mov   rax, 0
      ret



checkparm:                      ; rdi = pointer to string argument (argv[0])
    mov     rcx, 1              ; return 1 if zero length string
    call    strlen
    cmp     rax, 0
    je      exit

    xor     rbx, rbx
    mov     rdx, rax            ; save strlen in rdx
    cmp     rdx, 0
    jle     not_numeric
    mov     rcx, 0
l1:
    mov     bl, [rdi + rcx]
    cmp     bl,  48    ; ascii 0
    jb      not_numeric
    cmp     bl, byte 57    ; ascii 9
    ja      not_numeric
    sub     bl, 48

    mov     rax, 10
;    dec     rdx
;    dec     rdx

not_numeric:
    mov     rax, 1

checkparm_exit:
    ret


; x ^ y
; RDI = argv[1], RSI = argv[2]
power:
    push    rbx
    push    rcx
    push    rdx
    cmp     rsi, 0
    je      p0              ; any number ^ 0  = 1
    mov     rax, rdi
    xor     rbx, rbx
    mov     rcx, rsi
    dec     rcx
p1:
    mov     rdx, rdi
    cmp     rcx, 0
    jle     power_exit

    mul     rdx

    dec     rcx
    jmp     p1
p0:
    mov     rax, 1
power_exit:
    pop     rdx
    pop     rcx
    pop     rbx
    ret





; strlen
; Inputs:
;   rdi - pointer to the string
strlen:         ;(rdi = *)
      push  rcx                                       ; save and clear out counter
      push  rdi
      xor   rcx, rcx
strlen_next:
      cmp   [rdi + rcx], byte 0                       ; null byte yet?
      jz    strlen_null                               ; yes, get out
      inc   rcx                                       ; char is ok, count it
      jmp   strlen_next                               ; process again
strlen_null:
      mov   rax, rcx                                  ; rcx = the length (put in rax)
      pop   rdi
      pop   rcx                                       ; restore rcx
      ret   
