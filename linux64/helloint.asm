global helloint:function

section .data


section .text

helloint:
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

finish:
      pop	rsi
      pop	rdi
      pop	rdx
      mov	rsp,rbp
      pop	rbp

      ret
