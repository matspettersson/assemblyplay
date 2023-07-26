global power:function
global power_sse:function
global checkparm:function
global armstrong:function

section .bss

numlen  db  0
sum     dq  0
remain  dq  0

section .rodata


section .data

section .text


armstrong:
    push    rbx
    push    rcx
    push    rdx

    mov     rax, rdi
    xor     rcx, rcx
    
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
    mov     [numlen], rax       ; now numlen contains number of digits
    mov     r8, rax

    mov     rax, rdi
power_and_add_numbers:
    cmp     rcx, 0
    je      armstrong_done

    xor     rdx, rdx
 
    idiv    rbx                 ; rdx => rdx ^ 3
    push    rdi
    mov     [remain], rax

    mov     rdi, rdx
    mov     rsi, [numlen]
    mov     rsi, r8
    call    power

    add     [sum], rax

    pop     rdi

    mov     rax, [remain]
    dec     rcx
    jmp     power_and_add_numbers
armstrong_done:
    mov     rax, rdi
    ;mov     rax, [sum]
    mov     rdi, [sum]
;    sub     rax, rdi        ; if 0 => armstrong
    sub     rdi, rax
    pop     rdx
    pop     rcx
    pop     rbx
    ret


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


power_sse:
    push    rbx
    push    rcx
    push    rdx
    cmp     rsi, 0
    je      ps0              ; any number ^ 0  = 1

;    mov     rax, rdi
    xor     rbx, rbx
    mov     rcx, rsi
    dec     rcx
ps1:
;    mov     rdx, rdi

    cmp     rcx, 0
    jle     power_exits

    cvtsi2ss    xmm0, rdi
    cvtsi2ss    xmm1, rdi

    mulss   xmm0, xmm1

    dec     rcx
    jmp     ps1
ps0:
    mov     rax, 1
power_exits:
    cvttss2si	rax, xmm0
    pop     rdx
    pop     rcx
    pop     rbx
    ret




    ret


;	movss	%xmm0, -20(%rbp)
;	movss	%xmm1, -24(%rbp)
;	movss	-20(%rbp), %xmm0
;	mulss	-24(%rbp), %xmm0
;	movss	%xmm0, -4(%rbp)
;	movss	-4(%rbp), %xmm0
;	cvttss2sil	%xmm0, %eax





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