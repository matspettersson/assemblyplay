global _start

section .rodata
msg:      db "Hello, world! Linux 32-bit", 13, 10
msglen:   equ $ - msg

section .text

_start:
  mov     eax,4     ; system call number (sys_write)
  mov     ebx,1     ; STDOUT
  mov     ecx,msg
  mov     edx,msglen
  int     0x80

  mov     eax,1     ; system call number (sys_exit)
  mov     ebx,0     ; rc 0
  int     0x80
