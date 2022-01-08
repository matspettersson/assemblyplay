global strlen
global strlen2
global print_uint32
global printcrlf
global print

section .data
crlf:     db 0dh, 0ah, 0
crlflen:  equ $ - crlf

section .text


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

printcrlf:
        mov rax, 1        ;  write
        mov rdi, 1        ;  STDOUT
        mov rsi, crlf
        mov rdx, crlflen
        syscall
        ret



print:           mov rsi, rdi
;lea rsi, string    ; what to print
                call strlen2
                mov rdx, rax       ; length of string to be printed
                mov rdi, 1
                mov rax, 1
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
