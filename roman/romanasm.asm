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
roman_numerals db "IVXLCDM"    ; Roman numeral symbols
num_symbols equ ($ - roman_numerals)    ; Number of valid Roman numeral symbols
values        dw 1, 5, 10, 50, 100, 500, 1000   ; Corresponding integer values


section .text





; rdi = str
romanToInt:
      xor   rax, rax
      xor   r10, r10
      xor   r11, r11
      xor   r12, r12
      ;mov   r12, 9999
      xor   rcx, rcx
      mov   r8, roman
      mov   r9, arab

      call  strlen                  ; length of rdi
      mov   rcx, rax                

loopstr:
      xor   rbx, rbx
      xor   rdx, rdx

;      cmp   byte [rdi + rcx], 0         ; Check the end of string
      cmp   rcx, 0
      jge    end

looproman:
        cmp   byte [r8 + rdx], 0            ; Check the end of array
        jle   endroman
        mov   r10b, [r8 + rdx]              ; rdx = index in roman array
        cmp   byte [rdi + rcx], r10b        ; Match
        je    romanmatch
        inc   rdx
        jmp   looproman
romanmatch:
        mov   r11,[r9 + rdx * 8]
        cmp     r11, r12
        jge     addval
        sub     rax, r11
        jmp     endroman
addval:
        add rax, r11    ;[r9 + rdx * 8]             ; Add to rax

endroman:
;      inc   rcx                     ; increment counter
      dec   rcx
        mov     r12, r11        ; save current val 
      jmp   loopstr

end:
      ret




strlen:         ;(rdi = *)
      push  rcx             ; save and clear out counter
      push  rdi             ;
      xor   rcx, rcx        ;
strlen_next:
      cmp   [rdi], byte 0   ; null byte yet?
      jz    strlen_null     ; yes, get out
      inc   rcx             ; char is ok, count it
      inc   rdi             ; move to next char
      jmp   strlen_next     ; process again
strlen_null:
      mov   rax, rcx        ; rcx = the length (put in rax)
      pop   rdi
      pop   rcx             ; restore rcx
      ret   