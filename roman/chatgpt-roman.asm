section .data
    roman_numerals db "IVXLCDM"    ; Roman numeral symbols
    values        dw 1, 5, 10, 50, 100, 500, 1000   ; Corresponding integer values
;    roman_numerals db "IVXLCDM"    ; Roman numeral symbols
    num_symbols equ ($ - roman_numerals)    ; Number of valid Roman numeral symbols


section .text
    global roman_to_int:function
    global validate_roman_numeral:function

roman_to_int:
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

    ; Compare with the previous value
    cmp bx, cx
    jge add_value
    sub rax, rbx
    jmp next_iteration

add_value:
    add rax, rbx

next_iteration:
    inc rsi
    jmp convert_loop

end_conversion:
    pop rbp
    ret


validate_roman_numeral:
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
