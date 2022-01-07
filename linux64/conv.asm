global _start

section .data
msg:      db "Hello, world! Linux 64-bit", 13, 10, 0
msglen:   equ $ - msg
crlf:     db 0dh, 0ah, 0
crlflen:  equ $ - crlf
usage:    db "Usage:  conv DH (Decimal to Hex) number", 0dh, 0ah,
          db "        conv HD (Hex to Decimal) number", 0dh, 0ah,
          db "        conv DB (Decimal to Bin) number", 0dh, 0ah,
          db "        conv BD (Bin to Decimal) number", 0dh, 0ah, 0
usagelen:    equ $-usage

string: db "h4ppy c0d1ng",13,10,0
len:    equ $-string

;top of stack
;               <- rsp after alignment
;return address <- rsp at beginning (aligned rsp + 8)
;  [something]  <- rsp + 16
;    argc       <- rsp + 24
;   argv        <- rsp + 32
;   envp        <- rsp + 40  (in most Unix-compatible systems, the environment
;    ...            ...       string array, char **envp)
;bottom of stack
; ...
;somewhere else:
;   argv[0]     <- argv+0:   address of first parameter (program path or name)
;   argv[1]     <- argv+8:   address of second parameter (first command line argument)
;   argv[2]     <- argv+16:  address of third parameter (second command line argument)
;    ...
;   argv[argc]  <-  argv+argc*8:  NULL


;If you aren't using the C startup (you are using _start instead of main) then ARGC
;is the value at memory location [rsp] . This is documented in the x86-64 System V ABI
;can be found here: github.com/hjl-tools/x86-psABI/wiki/X86-psABI .
;See section 3.4.1 Initial Stack and Register State . If your entry point is main then ARGC is passed in RDI
; as described in the same calling convention. It is different for Windows. –
;Michael Petch
;Aug 24 '18 at 22:36


section .text

_start:

  mov rdi, [rsp]
  ;call  verify_no_of_parms

;  mov edi, [rsp+16]
;  lea     edx, [edi - ('A')]     ; we substract the value of the letter A
;  mov     eax, edi     ; return value set to input value
;  or      edi, 0x20    ; create a lowercase version
;  cmp     edx, 'Z'-'A' ; that we will use only if we were facing an upper case character
;  cmovb   eax, edi     ; if it was, we move value from edi to eax


;  mov rdi, [rsp+16]
;  call strlen2

  mov rdi, msg
  call s1


  mov rdi, 1        ;  STDOUT
  mov rsi, [rsp+16]
  mov rdx, rax
  mov rax, 1        ;  write
  syscall
  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, crlf
  mov rdx, crlflen
  syscall



  mov rdi, [rsp + 16]
  call  strlen
  mov   rdi, rax
  call print_uint32


  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, crlf
  mov rdx, crlflen
  syscall

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, [rsp+24]
  mov rdx, 3
  syscall

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, crlf
  mov rdx, crlflen
  syscall

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, [rsp+32]
  mov rdx, 3
  syscall

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, crlf
  mov rdx, crlflen
  syscall

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, msg
  mov rdx, msglen
  syscall

e1:
  mov rax, 60       ; exit
  mov rdi, 0        ; rc 0
  syscall

  ret

print_uint32:
      mov    eax, edi              ; function arg

      mov    ecx, 0xa              ; base 10
      push   rcx                   ; ASCII newline '\n' = 0xa = base
      mov    rsi, rsp
      sub    rsp, 16               ; not needed on 64-bit Linux, the red-zone is big enough.  Change the LEA below if you remove this.

  ;;; rsi is pointing at '\n' on the stack, with 16B of "allocated" space below that.
  .toascii_digit:                ; do {
      xor    edx, edx
      div    ecx                   ; edx=remainder = low digit = 0..9.  eax/=10
                                   ;; DIV IS SLOW.  use a multiplicative inverse if performance is relevant.
      add    edx, '0'
      dec    rsi                 ; store digits in MSD-first printing order, working backwards from the end of the string
      mov    [rsi], dl

      test   eax,eax             ; } while(x);
      jnz  .toascii_digit
  ;;; rsi points to the first digit

      mov    eax, 1               ; __NR_write from /usr/include/asm/unistd_64.h
      mov    edi, 1               ; fd = STDOUT_FILENO
      ; pointer already in RSI    ; buf = last digit stored = most significant
      lea    edx, [rsp+16 + 1]    ; yes, it's safe to truncate pointers before subtracting to find length.
      sub    edx, esi             ; RDX = length = end-start, including the \n
      syscall                     ; write(1, string /*RSI*/,  digits + 1)

      add  rsp, 24                ; (in 32-bit: add esp,20) undo the push and the buffer reservation
      ret



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
      ret                   ;

; https://tuttlem.github.io/2013/01/08/strlen-implementation-in-nasm.html
strlen2:
        push  rbx                 ; save any registers that
        push  rcx                 ; we will trash in here
        mov   rbx, rdi            ; rbx = rdi
        xor   al, al              ; the byte that the scan will
                                  ; compare to is zero
        mov   rcx, 0xffffffff     ; the maximum number of bytes
                                  ; i'm assuming any string will
                                  ; have is 4gb
        repne scasb               ; while [rdi] != al, keep scanning

        sub   rdi, rbx            ; length = dist2 - dist1
        mov   rax, rdi            ; rax now holds our length
        pop   rcx                 ; restore the saved registers
        pop   rbx
        ret                       ; all done!


s1:          ;lea rcx, string
              push rdi
              call toUpper
              pop rdi
              push rdi
              call print
              pop rdi
              ret
toUpper:
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
                jmp toUpper
done:           ;pop rcx
                ret

print:           mov rsi, rdi
;lea rsi, string    ; what to print
                call strlen2
                mov rdx, rax       ; length of string to be printed
                mov rdi, 1
                mov rax, 1
                syscall

                mov rax, 1        ;  write
                mov rdi, 1        ;  STDOUT
                mov rsi, crlf
                mov rdx, crlflen
                syscall

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
