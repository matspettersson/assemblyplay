
section .data
    number:  db 10 dup(0)
    gt:   db 'greater than', 0
    gtlen equ $-gt
    lt:   db 'less than',0
    ltlen equ $-lt
    crlf:  db  13,10,0
;    result: dw 0
;    quotient: dw 0

section .text

    global main, _start
main:
_start:
    ; Create a stack-frame, re-aligning the stack to 16-byte alignment before calls
    push rbp

    lea   rbx, [number]
    mov   ax, 25321
    test  ax, ax
    jge    pos

    mov    rax, 1               ; __NR_write from /usr/include/asm/unistd_64.h
    mov    rdi, 1               ; fd = STDOUT_FILENO
    lea    rsi, lt    ; yes, it's safe to truncate pointers before subtracting to find length.
    mov    rdx, ltlen             ; RDX = length = end-start, including the \n
    syscall                     ; write(1, string /*RSI*/,  digits + 1)
    call prnewline

pos:
    xor   rdx, rdx
    xor   dx,dx ; dx:ax
    mov   cx, 10
    div   cx
    ; result AX
    ; remainder DX
    add   dx, '0'
    mov   [rbx], dx
    inc   rbx
    cmp   ax, 10
    jge   pos
    add   ax, '0'
    mov   [rbx], ax

;    mov   rdx, [revnumber]
;    sub   rdx, rbx

reverse:
            lea eax, [number]   ; eax <- points to string
            mov edx, eax
look_for_last:
            mov ch, [edx]      ; put char from edx in ch
            inc edx
            test ch, ch
            jnz look_for_last  ; if char != 0 loop
            sub edx, 2         ; found last
swap:                      ; eax = first, edx = last (characters in string)
            cmp eax, edx
            jg end             ; if eax > edx reverse is done
            mov cl, [eax]      ; put char from eax in cl
            mov ch, [edx]      ; put char from edx in ch
            mov [edx], cl      ; put cl in edx
            mov [eax], ch      ; put ch in eax
            inc eax
            dec edx
            jmp swap
end:

            lea eax, [number]   ; eax <- points to string
            mov edx, eax
            mov   ch, [edx]
            cmp   ch, '0'
            jne  ne01  ; not a zero in first position
m1:         ;mov   [eax], [eax+1]
            inc   eax
            mov   ch, [eax]
            mov   [eax-1], ch
            cmp   ch, 0
            jne   m1

            mov   dl, 0
            mov   [eax], dl
ne01:

    mov    rax, 1               ; __NR_write from /usr/include/asm/unistd_64.h
    mov    rdi, 1               ; fd = STDOUT_FILENO
    ; pointer already in RSI    ; buf = last digit stored = most significant
    lea    rsi, [number]    ; yes, it's safe to truncate pointers before subtracting to find length.
    mov    rdx, 10             ; RDX = length = end-start, including the \n
    syscall                     ; write(1, string /*RSI*/,  digits + 1)
    call prnewline

    pop	rbp		; Pop stack


    mov rax, 60       ; exit
    mov rdi, 0        ; rc 0
    syscall
    ret			; Return

    prnewline:
        mov	rsi, crlf
        mov rdi, 1
        mov rdx, 3
        mov rax, 1
        syscall
        ret
