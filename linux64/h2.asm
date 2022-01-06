global _start

section .rodata
msg:      db "Hello, world! Linux 64-bit", 13, 10
msglen:   equ $ - msg
crlf:     db 0dh, 0ah, 0
crlflen:  equ $ - crlf

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
  call print_uint32

  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, [rsp+16]
  mov rdx, 3
  syscall

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

;      strlen: # (rdi = buf)
;          save_registers

          # r12 will be used as an accumulator and string index,
          # which is fine since maximum string index is its length
;          mov $0, %r12

;          strlen_loop:
              # r13b = buf[r12]
;              mov (%rdi, %r12, 1), %r13b

;              # if(r13b == 0) goto strlen_return
;              cmp $0, %r13b
;              je strlen_return

;              inc %r12
;              jmp strlen_loop

;          strlen_return:
;              mov %r12, %rax # save the return value in rax
;              restore_registers
;              ret
;      .type strlen, @function

;      puts: # (rdi = filedescr, rsi = buf)
;          save_registers

          # Save original arguments
;          mov %rdi, %r12 # r12 = filedescr
;          mov %rsi, %r13 # r13 = buf

          # r13 = strlen(buf)
;          mov %r13, %rdi
;          call strlen

;          mov %rax, %r14 # r14 = strlen(buf)

;          write %r12 %r13 %r14

;          restore_registers
;          ret
;      .type puts, @function
