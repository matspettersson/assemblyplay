section .data
section .text
    global _start
_start:
  call .getNumberOfArgs   ; expects return value in $rax
  mov rdi, rax
  call .printNumberOfArgs ; expects value to be in 1st argument, i.e. $rdi
  call .exit
.getNumberOfArgs:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment
  pop rax         ; get argc from stack
  push rbx        ; return address of calling fxn to stack
  ret
; expects value to be in 1st argument, i.e. $rdi
.printNumberOfArgs:
  pop rbx         ; this is the address of the calling fxn. Remove it from the stack for a moment
  add rdi, 48     ; convert number of args to ascii (only works if < 10)
  push rdi        ; push the ascii converted argc to stack
  mov rsi, rsp    ; store value of rsp, i.e. pointer to ascii argc to param2 of sys_write fxn
  mov rdx, 8      ; param3 of sys_write fxn is the number of bits to print
  push rbx        ; return the address of the calling fxn to top of stack.
  call .print
  ; clean up the number that was pushed onto the stack. Retaining the return address currently on top of stack
  pop rbx
  pop rcx
  push rbx
  ret

.print:           ; print expects the calling location to be at the top of the stack
  mov rax, 1
  mov rdi, 1
  syscall
  ret             ; return to location pointed to at top of stack
.exit:
  mov rax, 60
  mov rdi, 0
  syscall
