global armstrong:function

section .bss

section .rodata

section .data

section .text


armstrong:
    push    rbx
    push    rcx
    push    rdx

    mov     rax, rdi
    xor     rcx, rcx
    xor     r10, r10            ; r10 = sum
    
    mov     rbx, 10
a1b:
    inc     rcx
    xor     rdx, rdx
    cmp     rax, 9
    jbe     a1
    idiv    rbx
    jmp     a1b
a1:
    mov     rax, rcx
    mov     r8, rax              ; r8 = number of digits

    mov     rax, rdi
power_and_add_numbers:
    cmp     rcx, 0
    je      armstrong_done

    xor     rdx, rdx
 
    idiv    rbx                 ; 
    push    rdi
    mov     r9, rax             ; r9 = remaining

    mov     rdi, rdx
    mov     rsi, r8
    call    power

    add     r10, rax            ; sum

    pop     rdi

    mov     rax, r9
    dec     rcx
    jmp     power_and_add_numbers
armstrong_done:
    mov     rax, rdi
    mov     rdi, r10        ; [sum]
    sub     rax, rdi        ; if 0 => armstrong
    pop     rdx
    pop     rcx
    pop     rbx
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

