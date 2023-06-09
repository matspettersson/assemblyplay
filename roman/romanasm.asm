global romanToInt:function

; nasm -f elf64 -gdwarf fiboasm.asm -o fiboasm.o

;%ifidn __OUTPUT_FORMAT__, win64 
;      mov rax, rcx
;%elifidn __OUTPUT_FORMAT__, elf64 
;      mov rax, rdi                ; linux rdi, win rcx
;      mov rcx, rdi
;%endif


section .bss


section .rodata
roman db    'I', 'V', 'X', 'L', 'C', 'D', 'M', 0
arab  dq    1, 5, 10, 50, 100, 500, 1000, 0

section .text

; rdi = str
romanToInt:
      xor   rax, rax
      xor   r10, r10
      xor   r11, r11
      xor   rcx, rcx
      mov   r8, roman
      mov   r10, arab
loopstr:
      xor   rbx, rbx
      xor   rdx, rdx

      cmp   byte [rdi + rcx], 0     ;Check the end of string
      jz    end

      xor   rdx, rdx
looproman:
      xor   r9, r9
      mov   r11b, r9b               ; Save previous value
      cmp   byte [r8 + rdx], 0      ; Check the end of array
      jle   endroman
      mov   r9b, [r8 + rdx]
      cmp   byte [rdi + rcx], r9b
      je    e2
      inc   rdx
      jmp   looproman
e2:   

      cmp   r11b, r9b
      jae   e3
      ;neg   r9b
      ;add   rax, r9
      ;add   rax, r9
e3:
      mov   rax, [r10 + rdx * 8]
      jmp   end2
      push  rax

endroman:
      inc   rcx                     ;increment our counter
      jmp   loopstr

;e1:   
      ;mov   rcx, rdx
end:
      jmp   end2
      dec   rcx
 ;     mov   rax, rcx
 ;     jmp   end2
      xor   rbx, rbx
      pop   rbx
      cmp   rbx, rax
      jge   end1
      neg   rbx
      cmp   rcx, 0
      jae    end
end1:
      add   rax, rbx
      ;mov   rax, rcx
      jmp   end
end2:
      ret

