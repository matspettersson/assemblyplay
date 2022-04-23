global _start

section .rodata
msg:      db "Hello, world! Linux 64-bit", 13, 10
msglen:   equ $ - msg

section .text

_start:
  mov rax, 1        ;  write
  mov rdi, 1        ;  STDOUT
  mov rsi, msg
  mov rdx, msglen
  syscall

  mov rax, 60       ; exit
  mov rdi, 0        ; rc 0
  syscall
