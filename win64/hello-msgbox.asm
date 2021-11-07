extrn MessageBoxA: PROC
extrn GetStdHandle: PROC
extrn WriteConsoleA: PROC
extrn ExitProcess: PROC

.data
titlemsg  db 'Playing with assembler - Win64', 0
msg       db 'Hello World!', 0ah, 0dh, 0
msg_size equ $ - offset msg

stdout    dq ?          ; stdout handle
nbwr      dq ?          ; Number of bytes written
console   equ  -11

.code
main proc
  sub rsp, 28h          ; Reserve "shadow space" on stack

; Display a message box with the Hello World text
  mov     rcx, 0        ; HWND_DESKTOP
  lea     rdx, msg
  lea     r8,  titlemsg
  mov     r9d, 0        ; MB_OK
  call    MessageBoxA

; Get the handle for writing to the console
  mov     ecx, console
  call    GetStdHandle
  mov     rcx, rax
  mov     stdout, rcx    ; save for future use, but never used in this example   

; Write to console
  lea     rdx,msg
  mov     r8, msg_size
  lea     r9, nbwr
  call    WriteConsoleA

  add     rsp, 28h       ; Replace "shadow space" on stack

; exit with rc 0    
  mov     ecx, 0
  call    ExitProcess

main endp

end