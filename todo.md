Automorphic number :

An automorphic number is a number which is present in the last digit(s) of its square. Example: 25 is an automorphic number as its square is 625 and 25 is present as the last digits.

Neon number:

A number is said to be a Neon Number if the sum of digits of the square of the number is equal to thenumber itself. Example 9 is a Neon Number. 9*9=81 and 8+1=9.Hence it is a Neon Number.

Magic number :

A number is said to be a Magic number if the sum of its digits are calculated till a single digit is obtained by recursively adding the sum of its digits. If the single digit comes to be 1 then the number is a magic number.

Example :

901

9+0+1=10

1+0=1

Palindrome:

Reverse of a number is also same as the original number.

Examle:

100001,






; strncmp implementation using SSE instructions
; Inputs:
;   rdi - pointer to the first string
;   rsi - pointer to the second string
;   rdx - maximum number of characters to compare

strncmp_sse:
    push rbp
    mov rbp, rsp

    xor eax, eax            ; result

    mov ecx, rdx            ; counter
    shr ecx, 4              ; divide the counter by 16 to handle 16-byte comparisons

loop_comparison_c:
    cmp ecx, 0              ; check if all 16-byte blocks have been compared
    je end_comparison_c

    movdqu xmm0, [rdi]      ; load 16 bytes from the first string
    movdqu xmm1, [rsi]      ; load 16 bytes from the second string
    pcmpestri xmm0, xmm1, 0 ; compare the strings

    jnz mismatch_c            ; jump if mismatch is found

    add rdi, 16             ; move pointers to the next 16-byte block
    add rsi, 16
    dec ecx                 ; decrement counter
    jmp loop_comparison_c

mismatch_c:
    mov eax, 1              ; set result to a non-zero value indicating mismatch

end_comparison_c:
    pop rbp
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







