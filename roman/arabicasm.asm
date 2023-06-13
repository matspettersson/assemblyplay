global romanToInt:function

;%ifidn __OUTPUT_FORMAT__, win64 
;      mov rax, rcx
;%elifidn __OUTPUT_FORMAT__, elf64 
;      mov rax, rdi                ; linux rdi, win rcx
;      mov rcx, rdi
;%endif

; No more than 3 of the same
; Max: 3999 = MMMCMXCIX


section .bss

section .rodata
roman db    'M', 0, 'CM', 0, 'D', 0, 'CD', 0, 'C', 0, 'XC', 0, 'L', 0, 'XL', 0, 'X', 0, 'IX', 0, 'V', 0, 'IV', 0, 'I', 0      ; Roman symbols
arab  dq    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1, 0           ; Corresponding integer values

section .text

; rdi = str
romanToInt:
      xor   rax, rax
      xor   r10, r10
      xor   r11, r11
      xor   r12, r12
      xor   rcx, rcx
      mov   r8, roman
      mov   r9, arab

      call  strlen                                    ; length of rdi
      mov   rcx, rax                                  ; Counter
      xor   rax, rax                

loopstr:
      xor   rbx, rbx
      xor   rdx, rdx

      cmp   rcx, 0
      je    end

looproman:
      cmp   byte [r8 + rdx], 0                        ; Check the end of array
      jle   endroman
      mov   r10b, [r8 + rdx]                          ; rdx = index in roman array
      cmp   byte [rdi + rcx - 1], r10b                ; Match
      je    romanmatch
      inc   rdx
      jmp   looproman
romanmatch:
      mov   r11,[r9 + rdx * 8]
      cmp   r11, r12
      jge   addval
      sub   rax, r11                                  ; decrease sum with current value
      jmp   endroman
addval:
      add   rax, r11                                  ; Add to rax
endroman:
      dec   rcx                                       ; decrease counter
      mov   r12, r11                                  ; save current value
      jmp   loopstr
end:
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