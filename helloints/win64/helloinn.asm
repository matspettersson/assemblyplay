global helloint	;:function
global helloints	;:function

;section .data


section .text

helloint:
      push	rbp
      mov   rbp, rsp
;      push	rdx
;      push	rdi
;      push	rsi

      mov   rax, rcx
      and   rax, 1
      jz    even1
      mov   rax, 1
      jmp   finish
even1:
     mov  rax, 0

finish:
 ;     pop	rsi
 ;     pop	rdi
 ;     pop	rdx
      mov	rsp,rbp
      pop	rbp

      ret
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


helloints:
      push	rbp
      mov   rbp, rsp

;      mov   rax, rdi
;      add   rax, rsi
;      add   rax, rdx
;      add   rax, rcx
;      add   rax, r8
;      add   rax, r9

;      add   rax, [rbp + 0x10]
;      add   rax, [rbp + 0x18]
;      add   rax, [rbp + 0x20]

      mov   rax, rcx
      add   rax, rdx
      add   rax, r8
      add   rax, r9
      add   rax, [rsp + 30h]
      add   rax, [rsp + 38h]
      add   rax, [rsp + 40h]
      add   rax, [rsp + 48h]
      add   rax, [rsp + 50h]

      mov	rsp,rbp
      pop	rbp

      ret
