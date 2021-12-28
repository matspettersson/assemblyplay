global hexdisp:function
global slen:function

section .data
msg:      db "Hello, world! Linux 64-bit", 13, 10
msglen:   equ $ - msg


section .text


;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push	rbp
    mov   rbp, rsp
    push	rdx
    push	rdi
    push	rsi

    mov rax, rdi
    mov rbx, 0
;    push    ebx
;    mov     ebx, eax

nextchar:
    ;cmp     byte [eax], 0
    cmp     byte [rax], 0
    jz      sfinished
;    inc     eax
    inc     rbx
    inc     rax
    jmp     nextchar

sfinished:
    pop	rsi
    pop	rdi
    pop	rdx
    mov	rsp,rbp
    pop	rbp

    mov rax, rbx
;    sub     eax, ebx
;    pop     ebx
    ret


hexdisp:

;mov eax, [ebp+8]     ; eax = start of string c
;mov ecx, [ebp+12]        ; ecx = start of string d

  push	rbp
  mov   rbp, rsp
  push	rdx
  push	rdi
  push	rsi

;  mov eax, [ebp+8]     ; eax = start of string c
;  mov ecx, [ebp+12]        ; ecx = start of string d

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, msg
;  mov rsi, [ebp+8]

  mov rdx, msglen
;  mov rdx, 5
  syscall

finish:
  pop	rsi
  pop	rdi
  pop	rdx
  mov	rsp,rbp
  pop	rbp

  ret





    mov    byte [rsp-4], dil      ; store the char from RDI

    mov     edi, 1                ; EDI = fd=1 = stdout
    lea     rsi, [rsp-4]          ; RSI = buf
    mov     edx, edi              ; RDX = len = 1
    syscall                    ; rax = write(1, buf, 1)
    ret


qhexdisp:
      push	rbp
      mov   rbp, rsp
      push	rdx
      push	rdi
      push	rsi

      mov   rax, rdi
      and   rax, 1
      jz    even
      mov   rax, 1
      jmp   finish
even:
     mov  rax, 0

qfinish:
      pop	rsi
      pop	rdi
      pop	rdx
      mov	rsp,rbp
      pop	rbp

      ret
