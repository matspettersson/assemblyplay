global romanToInt:function
global broman_to_int:function
global bvalidate_roman_numeral:function
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
      jge   e3
      ;sub   rax, r9
      ;neg   r9b
      ;add   rax, r9
      ;add   rax, r9
e3:
      add   rax, [r10 + rdx * 8]
      ;jmp   end2
      ;push  rax

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


broman_to_int:
    push rbp
    mov rbp, rsp

    ; Initialize variables
    mov rsi, rdi            ; Pointer to input string
    xor rax, rax            ; Result
    xor rcx, rcx            ; Previous value

convert_loop:
    movzx edx, byte [rsi]   ; Current symbol
    cmp edx, 0              ; Check for null terminator
    je end_conversion

    ; Find value of the current symbol
    xor rdi, rdi            ; Index of current symbol
    movzx edi, dl
    mov bx, word [values + rdi * 2]
    ;mov rbx,  [values + rdi * 2]
    ;mov rbx,  [arab + rdi * 8]

    ; Compare with the previous value
    ;cmp bx, cx
    cmp rbx, rcx
    jge add_value
    sub rax, rbx
    jmp next_iteration

add_value:
    add rax, rbx

next_iteration:
    inc rsi
    mov rcx, rbx
    jmp convert_loop

end_conversion:
    pop rbp
    ret


bvalidate_roman_numeral:
    push rbp
    mov rbp, rsp

    ; Initialize variables
    mov rsi, rdi    ; Pointer to input string
    xor eax, eax    ; Result

    ; Check for valid Roman numeral
    call validate_symbols
    jz validate_subtraction
    jmp invalid_numeral

validate_symbols:
    movzx edx, byte [rsi]    ; Current symbol
    cmp edx, 0    ; Check for null terminator
    je valid_symbols

    ; Check if the current symbol is a valid Roman numeral symbol
    xor rdi, rdi    ; Index of current symbol
    mov ecx, num_symbols
    xor ebx, ebx    ; Found flag

    search_symbol:
    cmp dl, byte [roman_numerals + rdi]
    je symbol_found

    inc rdi
    loop search_symbol

    jmp invalid_symbols

symbol_found:
    mov ebx, 1
    jmp validate_symbols

invalid_symbols:
    xor eax, eax    ; Invalid Roman numeral symbols
    jmp end_validation

valid_symbols:
    xor ebx, ebx    ; Reset found flag
    jmp validate_symbols

validate_subtraction:
    movzx edx, byte [rsi + 1]    ; Next symbol
    cmp edx, 0    ; Check for null terminator
    je valid_subtraction

    ; Check if the current symbol can be subtracted from the next symbol
    xor rdi, rdi    ; Index of current symbol
    mov ecx, num_symbols
    xor ebx, ebx    ; Found flag

    search_subtraction:
    cmp dl, byte [roman_numerals + rdi]
    je subtraction_found

    inc rdi
    loop search_subtraction

    jmp invalid_subtraction

subtraction_found:
    mov ebx, 1
    jmp validate_subtraction

invalid_subtraction:
    xor eax, eax    ; Invalid Roman numeral subtraction
    jmp end_validation

valid_subtraction:
    xor ebx, ebx    ; Reset found flag
    jmp validate_subtraction

invalid_numeral:
    xor eax, eax    ; Invalid Roman numeral
    jmp end_validation

end_validation:
    pop rbp
    ret
