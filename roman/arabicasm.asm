global arabicToString:function
global romanToInt:function

; No more than 3 of the same
; Max: 3999 = MMMCMXCIX
; https://www.calculateme.com/roman-numerals/to-roman/3999

section .bss
retstr      db    25 dup(0)


section .rodata
roman       db    'M', 0, 'CM', 0, 'D', 0, 'CD', 0, 'C', 0, 'XC', 0, 'L', 0, 'XL', 0, 'X', 0, 'IX', 0, 'V', 0, 'IV', 0, 'I', 0      ; Roman symbols
arabic      dw    1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1, 0           ; Corresponding integer values

r_roman     db    'CM', 0, 'CD', 0, 'XC', 0, 'XL', 0, 'IX', 0, 'IV', 0, 'M', 0, 'D', 0, 'C', 0, 'L', 0, 'X', 0, 'V', 0, 'I', 0      ; Roman symbols
r_romanlen  equ   $-r_roman
r_arabic    dw    900, 400, 90, 40, 9, 4, 1000, 500, 100, 50, 10, 5, 1, 0           ; Corresponding integer values


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




; rdi = str
romanToInt:
      xor   rax, rax
      xor   r10, r10
      xor   r11, r11
      xor   r12, r12
      xor   r13, r13
      xor   r14, r14
      xor   r15, r15
      xor   rcx, rcx
      mov   r8, r_roman
      mov   r9, r_arabic

      call  strlen                                    ; length of string pased to function, in rdi
      mov   rcx, rax                                  ; save in rcx

      xor   rax, rax
      xor   rbx, rbx
      xor   rdx, rdx

      cmp   rcx, 0
      je    endr

looproman:
      cmp   rbx, rcx                            ; # of characters
      jge    endr

;      cmp   r15, 8                              ; 8 entries in the "array"
;      jge   end_of_array

      mov   r10, r8                             ; r10 = points to base of roman array
      add   r10, r11                          ; r10 plus a pointer to next string in roman array
      push  rdi
      mov   rdi, r10
      call  strlen
      mov   r14, rax                            ; r14 = strlen
      pop   rdi

      push  rdi
      push  rdx
      add   rdi, rbx                           ; Iterate through the string argument
      mov   rsi, r8
      add   rsi, r11
      mov   rdx, r14
      call  strncmp

      pop   rdx
      pop   rdi

      cmp   rax, 0
      je    romanmatch

      inc   r15
      inc   r14               ; add null
      add   r11, r14      
      add   rdx, r14

      jmp   looproman
romanmatch:
      xor   r12, r12
      mov   r12w, word[r9 + r15 * 2]
      add   r13, r12                                  ; Add sum to r13

      add   rbx, r14
      xor   rdx, rdx                      ; reset array index
      xor   r11, r11
      xor   r15, r15

      jmp   looproman
endr:
      mov   rax, r13
      ret                                             ; return value in rax
end_of_array:
      xor   r15, r15
      jmp   looproman


; strlen implementation using basic x86 instructions
; Inputs:
;   rdi - pointer to the string
strlen:         ;(rdi = *)
      push  rcx                                       ; save and clear out counter
      push  rdi
      xor   rcx, rcx
strlen_next:
      cmp   [rdi + rcx], byte 0                             ; null byte yet?
      jz    strlen_null                               ; yes, get out
      inc   rcx                                       ; char is ok, count it
;      inc   rdi                                       ; move to next char
      jmp   strlen_next                               ; process again
strlen_null:
      mov   rax, rcx                                  ; rcx = the length (put in rax)
      pop   rdi
      pop   rcx                                       ; restore rcx
      ret   



; strncmp implementation using basic x86 instructions
; Inputs:
;   rdi - pointer to the first string
;   rsi - pointer to the second string
;   rdx - maximum number of characters to compare

strncmp:
      push  rbx
      push  rcx
      xor rax, rax        ; result
      xor rcx, rcx        ; counter

strncmp_loop:
    cmp rcx, rdx        ; check if maximum number of characters to compare reached
    jge end_strncmp


    mov bl, byte [rdi + rcx]    ; load character from the first string
    mov bh, byte [rsi + rcx]    ; load character from the second string
    cmp bl, bh                  ; compare characters
    jne mismatch                ; jump if characters don't match

    inc rcx                     ; increment counter
    jmp strncmp_loop

mismatch:
;    sub al, dl                  ; calculate the difference
    mov rax, 1                  ; set result to a non-zero value indicating mismatch
;    jmp end_comparison_b

end_strncmp:
    pop     rcx
    pop     rbx
    ret
