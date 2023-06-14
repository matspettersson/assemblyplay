global arabicToString:function

;%ifidn __OUTPUT_FORMAT__, win64 
;      mov rax, rcx
;%elifidn __OUTPUT_FORMAT__, elf64 
;      mov rax, rdi                ; linux rdi, win rcx
;      mov rcx, rdi
;%endif

; No more than 3 of the same
; Max: 3999 = MMMCMXCIX
; gdb --args arabic 2

section .bss

section .rodata
roman db    'M', 0, 'CM', 0, 'D', 0, 'CD', 0, 'C', 0, 'XC', 0, 'L', 0, 'XL', 0, 'X', 0, 'IX', 0, 'V', 0, 'IV', 0, 'I', 0      ; Roman symbols
arab  dq    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1, 0           ; Corresponding integer values

section .text

; rdi = int
arabicToString:
      xor   rax, rax
      xor   r10, r10
      xor   r11, r11
      xor   r12, r12
      xor   rcx, rcx

      mov   r8, roman
      mov   r9, arab
      mov   rdx, rdi
      xor   rcx, rcx
loopstr:
      cmp   rdx,0
      je    end
      mov   bl, r8[rcx]
      cmp   bl, 0
      je    found0

      inc   rcx                                       ; increase counter
      jmp   loopstr
found0:
      dec   rdx
      inc   rcx                                       ; increase counter
      jmp   loopstr
end:
      mov   rax, r8
      add   rax, rcx
      ret                                             ; return value in rax



strlen:         ;(rdi = *)
      push  rcx                                       ; save and clear out counter
      push  rdi
      xor   rcx, rcx
strlen_next:
      cmp   [rdi], byte 0                             ; null byte yet?
      jz    strlen_null                               ; yes, get out
      inc   rcx                                       ; char is ok, count it
      inc   rdi                                       ; move to next char
      jmp   strlen_next                               ; process again
strlen_null:
      mov   rax, rcx                                  ; rcx = the length (put in rax)
      pop   rdi
      pop   rcx                                       ; restore rcx
      ret   