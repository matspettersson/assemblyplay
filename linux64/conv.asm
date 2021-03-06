global _start
extern strlen
extern strlen2
extern print_uint32
extern printcrlf
extern print

section .data
msg:      db "Hello, world! Linux 64-bit", 13, 10, 0
msglen:   equ $ - msg
parm_dh:  db "DH",0
parm_hd:  db "HD",0
parm_db:  db "DB",0
parm_bd:  db "BD",0
usage:    db "Usage:  conv DH (Decimal to Hex) number", 0dh, 0ah,
          db "        conv HD (Hex to Decimal) number", 0dh, 0ah,
          db "        conv DB (Decimal to Bin) number", 0dh, 0ah,
          db "        conv BD (Bin to Decimal) number", 0dh, 0ah, 0
usagelen:    equ $-usage
convdh:   db "Converting from decimal to hex: ", 0dh, 0ah,0
convdhlen: equ $-convdh
convhd:   db "Converting from hex to decimal: ", 0dh, 0ah,0
convhdlen: equ $-convhd
convdb:   db "Converting from decimal to bin: ", 0dh, 0ah,0
convdblen: equ $-convdb
convbd:   db "Converting from bin to decimal: ", 0dh, 0ah,0
convbdlen: equ $-convbd
wrongparms: db "Wrong parmameters given.",  0dh, 0ah,0
wrongparmslen: equ $-wrongparms

section .text

_start:

  mov rdi, [rsp]
  call  verify_no_of_parms

  mov rdi, [rsp+24]     ;
  call  string_to_int

  mov rdi, rax
  call print_uint32
  call printcrlf

  mov rdi, [rsp+16]
  call toUpper

  mov   rdi, [rsp+16]
  mov   rsi, parm_dh
  call  cmpstr
  cmp ax, 0
  je  decimal_to_hex

  mov   rdi, [rsp+16]
  mov   rsi, parm_hd
  call  cmpstr
  cmp ax, 0
  je  hex_to_decimal

  mov   rdi, [rsp+16]
  mov   rsi, parm_db
  call  cmpstr
  cmp ax, 0
  je  decimal_to_bin

  mov   rdi, [rsp+16]
  mov   rsi, parm_bd
  call  cmpstr
  cmp ax, 0
  je  bin_to_decimal

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, wrongparms
  mov rdx, wrongparmslen
  syscall


e1:
  mov rax, 60       ; exit
  mov rdi, 0        ; rc 0
  syscall

  ret

decimal_to_hex:
      mov rax, 1        ;  write
      mov rdi, 1        ;  STDOUT
      mov rsi, convdh
      mov rdx, convdhlen
      syscall
      jmp e1


hex_to_decimal:
      mov rax, 1        ;  write
      mov rdi, 1        ;  STDOUT
      mov rsi, convhd
      mov rdx, convhdlen
      syscall
      jmp e1


decimal_to_bin:
      mov rax, 1        ;  write
      mov rdi, 1        ;  STDOUT
      mov rsi, convdb
      mov rdx, convdblen
      syscall
      jmp e1

bin_to_decimal:
      mov rax, 1        ;  write
      mov rdi, 1        ;  STDOUT
      mov rsi, convbd
      mov rdx, convbdlen
      syscall
      jmp e1


verify_no_of_parms:
        mov rax, rdi
        cmp rax, 3
        je  ver_ok

        mov rax, 1        ;  write
        mov rdi, 1        ;  STDOUT
        mov rsi, usage
        mov rdx, usagelen
        syscall
        jmp e1          ; exit
  ver_ok:
        ret



toUpper:          ;lea rcx, string
                      push rdi
                      call s1
                      pop rdi
;                      push rdi
;                      call print
;                      pop rdi
                      ret
s1:
                        mov al, byte[rdi]      ; ecx is the pointer, so [ecx] the current char
                        cmp al,0x0
                        je done
                        cmp al,'a'
                        jb next_please
                        cmp al,'z'
                        ja next_please
                        sub al,0x20       ; move AL upper case and
                        mov [rdi], al      ; write it back to string
        next_please:
                        inc rdi
                        jmp s1
        done:           ;pop rcx
                        ret



cmpstr:
;                        	mov rsi, s1     ; esi = &s1
;                        	mov rdi, s2     ; edi = &s2
                        	xor rdx, rdx    ; edx = 0
cmpstrloop:
                        	mov al, [rsi + rdx]
                        	mov bl, [rdi + rdx]
                        	inc rdx
                        	cmp al, bl      ; compare two current characters
                        	jne cmpstrnot_equal   ; not equal
                        	cmp al, 0       ; at end?
                        	je cmpstrequal        ; end of both strings
                        	jmp cmpstrloop        ; equal so far
cmpstrnot_equal:
                        	mov rdi, 1
                        	jmp cmpstrexit
cmpstrequal:
                        	mov rdi, 0
                        	jmp cmpstrexit
cmpstrexit:
                ret



;        atoi:
;            push rbx            ; preserve rbx on the stack
;            push rcx            ; preserve rcx on the stack
;            push rdx            ; preserve rdx on the stack
;            push rsi            ; preserve rsi on the stack
;          ;  mov rsi, rax        ; move rax in rsi. The string to convert is in rsi
;            mov rax, 0          ; move the value of 0 into rax
;            mov rcx, 0          ; move the value of 0 into rcx
;        _conversion:
;            xor rbx, rbx        ; clear the register rbx
;            mov bl, [rsi+rcx]   ; bl is a single byte ( 8bits) we move a single byte into rbx
;            cmp bl, 48          ; it's comparing bl with 48. 48 = 0 according to the ascii table
;            jl _end             ; if it lower to 0, go to the label finished
;            cmp bl, 57          ; it's comparing bi with 57. 57 = 9 according to the ascii table
;            jg _end             ; if it's greater to 9, go to the label finished
;            sub bl, 48          ; convert a signle byte of the string into an integer value.The equivalent is sub bl, '0'
;            add rax, rbx        ; add rbx to rax
;            mov rbx, 10         ; move 10 into rbx
;            mul rbx             ; mul rbx by 10
;            inc rcx             ; increment the counter by 1
;            jmp _conversion     ; loop
;        _end:
;            cmp rcx, 0          ; compare rcx with the counter (rcx)
;            je _pop             ; if it's equal, go to the pop label
;            mov rbx, 10         ; move 10 into rbx
;            div rbx             ; divide rax by 10 (because 10 is in rbx)
;        _pop:
;            pop rsi             ; remove rsi of the stack
;            pop rdx             ; remove rdx of the stack
;            pop rcx             ; remove rcx of the stack
;            pop rbx             ; remove rbx of the stack
;            ret                 ; return

; Input:
; RDI = pointer to the string to convert
; Output:
; EAX = integer value
string_to_int:
    push rdi
    call strlen
    mov  rcx, rax

    xor rax, rax
    xor rbx,rbx    ; clear ebx

.next_digit:
    ;movzx eax,byte[rdi]
    mov al, byte[rdi]
    sub al,'0'    ; convert from ASCII to number

    imul rbx,10
    add rbx,rax   ; ebx = ebx*10 + eax
    inc rdi
    loop .next_digit  ; while (--ecx)

    mov rax,rbx

    pop rdi
    ret



        ; Input:
        ; EAX = integer value to convert
        ; ESI = pointer to buffer to store the string in (must have room for at least 10 bytes)
        ; Output:
        ; EAX = pointer to the first character of the generated string
int_to_string:
          add esi,9
          mov byte [esi], 0

          mov ebx,10
.next_digit:
          xor edx,edx         ; Clear edx prior to dividing edx:eax by ebx
          div ebx             ; eax /= 10
          add dl,'0'          ; Convert the remainder to ASCII
          dec esi             ; store characters in reverse order
          mov [esi],dl
          test eax,eax
          jnz .next_digit     ; Repeat until eax==0
          mov eax,esi
          ret

;      puts: # (rdi = filedescr, rsi = buf)
;          save_registers

;          # Save original arguments
;          mov %rdi, %r12 # r12 = filedescr
;          mov %rsi, %r13 # r13 = buf

;          # r13 = strlen(buf)
;          mov %r13, %rdi
;          call strlen

;          mov %rax, %r14 # r14 = strlen(buf)

;          write %r12 %r13 %r14

;          restore_registers
;          ret
;      .type puts, @function
