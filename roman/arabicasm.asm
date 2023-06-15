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
roman       db    'M', 0, 'CM', 0, 'D', 0, 'CD', 0, 'C', 0, 'XC', 0, 'L', 0, 'XL', 0, 'X', 0, 'IX', 0, 'V', 0, 'IV', 0, 'I', 0      ; Roman symbols
arabic      dq    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1, 0           ; Corresponding integer values
;retstr      db    20 dup(?)
retstr      db    "Mats",0

section .text

; rdi = int
arabicToString:
      xor   rax, rax
      xor   rbx, rbx
      xor   r10, r10                                  ; index of return string
      xor   r11, r11
      xor   r12, r12
      xor   rcx, rcx                                  ; counter for index in arabic

      lea   r8, roman
      lea   r9, arabic
      mov   rdx, rdi                                  ; holds the remainder


loopa:
      cmp   rdi, 0
      je    end
      mov   rbx, [r9 + rcx * 8]
      cmp   rdi, rbx
      jge   found0
      inc   rcx                                       ; increase counter
      jmp   loopa
found0:
      sub   rdi, rbx                                  ; subtact the value found
      push  rdi
      push  rbx
      push  rcx
      call  getRomanNumber
      pop   rcx
      pop   rbx
      pop   rdi
      inc   rcx                                       ; increase counter
      jmp   loopa
end:
;      mov   rax, r8
      lea   rax, retstr
      ret                                             ; return value in rax



getRomanNumber:

      ret



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


