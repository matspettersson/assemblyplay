global romanToInt:function

; nasm -f elf64 -gdwarf fiboasm.asm -o fiboasm.o

section .bss


section .rodata
roman db    'I', 'V', 'X', 'L', 'C', 'D', 'M', 0
arab  dw    1, 5, 10, 50, 100, 500, 1000, 0


section .text



; rdi = str
romanToInt:
      xor   rcx, rcx
      xor   rdx, rdx
loop:
      xor   rbx, rbx
      xor   rdx, rdx

      ;mov   bl, [rdi + rcx]
      ;cmp   bl, 0
      cmp   byte [rdi + rcx], 0     ;Check the end of string
      jz    end

      mov   r8, roman
      mov   r9b, [r8 + rcx]
      cmp   byte [rdi + rcx], r9b
      je    e1


      inc   rcx                     ;increment our counter
      jmp   loop

e1:   mov   rcx, 64
end:

      mov   rax, rcx

      ret


fib:

%ifidn __OUTPUT_FORMAT__, win64 
      mov rax, rcx
%elifidn __OUTPUT_FORMAT__, elf64 
      mov rax, rdi                ; linux rdi, win rcx
      mov rcx, rdi
%endif
        sub rcx, 1
        jle fib_done            ; f(0)=0, f(1)=1
        xor rbx, rbx            ; f(n-1)
        mov rax, 1              ; f(n)
fib_loop:
        xadd rax, rbx
        sub rcx, 1
        jnz fib_loop

fib_done:
        ret

