;global helloint:function
;global helloints:function

PUBLIC helloint
PUBLIC helloints

_DATA SEGMENT
_DATA ENDS

_TEXT SEGMENT
;section .data

;section .text

helloint PROC
; Integer arguments are passed in registers RCX, RDX, R8, and R9.
; https://learn.microsoft.com/en-us/cpp/build/x64-calling-convention?view=msvc-170
;helloint:
      push	rbp
      mov   rbp, rsp
      push	rdx
      push	rdi
      push	rsi

;      mov   rax, rdi
      mov   rax, rcx
      and   rax, 1
      jz    even1
      mov   rax, 1
      jmp   finish1
;even:
even1:
     mov  rax, 0

finish1:
      pop	rsi
      pop	rdi
      pop	rdx
      mov	rsp,rbp
      pop	rbp

      ret

helloint ENDP

;
;In 64-bit Linux system, function arguments of type integer/pointers are passed to the callee function in the following way:
;Arguments 1-6 are passed via registers RDI, RSI, RDX, RCX, R8, R9 respectively;
;
;    Arguments 7 and above are pushed on to the stack.
;
;Once inside the callee function:
;Arguments 1-6 are accessed via registers RDI, RSI, RDX, RCX, R8, R9 before they are modified or via  offsets from the RBP register like so: rbp - $offset. For example, if the first argument passed to the callee is int (4 bytes) and there are no local variables defined in the function, we could access it via rbp - 0x4; 
;It's worth noting, that:
;if the 1st argument was 8 bytes (for example, long int), we'd access it via rbp - 0x8;
;if the callee function had 1 local variable defined that is smaller or equal to 16 bytes, the first argument of type int would be accessed via rbp - (0x10 + 0x4) or simply rbp - 0x14;
;if the callee function had more than 16 bytes reserved for local variables, we'd access the first argument of type int via rbp - 0x24, which suggests that with every 16 bytes worth of local variables defined, the first argument is shifted by 0x10 bytes as shown 
;
;
;
;Argument 7 can be accessed via rbp + 0x10, argument 8 via rbp + 0x18 and so on.


;helloints:
helloints   PROC
      push	rbp
      ;mov   rbp, rsp
      ;push	rdx
      ;push	rdi
      ;push	rsi
; Integer arguments are passed in registers RCX, RDX, R8, and R9.
      mov   rax, rcx
      add   rax, rdx
      add   rax, r8
      add   rax, r9

;      mov   rax, [rsp + 32]
;      add   rax, [rsp + 40]
;      add   rax, [rsp + 48]
;      add   rax, [rsp + 56]
;a1$ = 32
;a2$ = 40
;a3$ = 48
;a4$ = 56
;a5$ = 64
;a6$ = 72
;a7$ = 80
;a8$ = 88
;a9$ = 96

      add   rax, [rsp + 48]
      add   rax, [rsp + 56]
      add   rax, [rsp + 64]
      add   rax, [rsp + 72]
      add   rax, [rsp + 80]
;      add   rax, [rsp + 18h]
;      add   rax, [rsp + 20h]
;      add   rax, [rsp + 28h]
;      add   rax, [rsp + 30h]

;      mov   rax, rdi
;      add   rax, rsi
;      add   rax, rdx
;      add   rax, rcx
;      add   rax, r8
;      add   rax, r9
      ;add   rax, [rsp + 0x10]
;      add   rax, [rsp + 10h]
      ;add   rax, [rsp + 0x18]
;      add   rax, [rsp + 18h]
      ;add   rax, [rsp + 0x20]
;      add   rax, [rsp + 20h]

      ;pop	rsi
      ;pop	rdi
      ;pop	rdx
      ;mov	rsp,rbp
      pop	rbp

      ret
helloints ENDP

_TEXT ENDS

END
