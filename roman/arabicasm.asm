global arabicToString:function

; No more than 3 of the same
; Max: 3999 = MMMCMXCIX
; https://www.calculateme.com/roman-numerals/to-roman/3999

section .bss
retstr      db    25 dup(0)


section .rodata
roman       db    'M', 0, 'CM', 0, 'D', 0, 'CD', 0, 'C', 0, 'XC', 0, 'L', 0, 'XL', 0, 'X', 0, 'IX', 0, 'V', 0, 'IV', 0, 'I', 0      ; Roman symbols
arabic      dw    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1, 0           ; Corresponding integer values


section .text

; rdi = int
arabicToString:
      xor   r10, r10                                  ; index for return string
      xor   rcx, rcx                                  ; counter for index in arabic

      lea   r8, roman
      lea   r9, arabic

      mov   rdx, rdi                                  ; holds the remainder
loopa:                                                ; find the position in the table
      cmp   rdi, 0
      je    end
      xor   rbx, rbx
      mov   bx, [r9 + rcx * 2]
      cmp   rdi, rbx
      jge   found0
      inc   rcx                                       ; increase counter
      jmp   loopa
found0:
      push  rdi
      push  rbx
      push  rcx
      mov   rdi, rcx                                  ; rcx holds the index in the array
      call  getRomanNumber
      pop   rcx
      pop   rbx
      pop   rdi
      sub   rdi, rbx                                  ; subtract the value found
      xor   rcx, rcx                                  ; counter for index in arabic
      jmp   loopa
end:
      lea   rax, retstr
      ret                                             ; return string in rax

getRomanNumber:                                       ; rdi holds index of string in array
      push  rdi

      xor   rcx, rcx
      inc   rcx
      xor   r11, r11
      lea   r12, roman                                ; r12 contains pointer to roman string
loopr1:
      mov   r11b, byte [r12]
      cmp   r11b, 0
      je    foundnull
      inc   r12
      jmp   loopr1
foundnull:
      cmp   rcx, rdi
      jge   ptrdone
      inc   r12
      inc   rcx
      jmp   loopr1
ptrdone:
      mov   rax, r12
      cmp   rdi, 0
      je    g1
      inc   rax
      jmp   g2
g1:
      lea   rax, roman
g2:      
      mov   rdi, rax
      lea   rcx, retstr
      call  copyRoman
      pop   rdi

      ret

copyRoman:
      xor   r13, r13
copyR1:
	mov   r13b, [rdi] ; rdi = source, rcx = target
      cmp   r13b, 0
      je    copyRomanDone

	mov   [rcx + r10], r13b
      inc   r10
      inc   rdi
      jmp   copyR1
copyRomanDone:
      mov   rax, rcx
	ret