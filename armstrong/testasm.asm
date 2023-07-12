global power:function
global checkparm:function

section .bss

section .rodata


section .data

section .text





checkparm:                      ; rdi = pointer to string argument (argv[0])
    xor     r8, r8
    mov     rcx, 1              ; return 1 if zero length string
    call    strlen
    cmp     rax, 0
    je      checkparm_exit

    xor     rbx, rbx
    mov     rdx, rax            ; save strlen in rdx
    dec     rdx                 ; make it 1 shorter
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

    push    rdi
    push    rsi

    mov     rdi, 10
    mov     rsi, rdx
    sub     rsi, rcx
    call    power

    push    rdx
    mul     rbx
    pop     rdx

    add     r8, rax

    pop     rsi
    pop     rdi

    inc     rcx
    cmp     rcx, rdx
    jbe     l1

    mov     rax, rbx
    jmp     checkparm_exit
not_numeric:
    mov     r8, 0

checkparm_exit:
    mov     rax, r8
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
