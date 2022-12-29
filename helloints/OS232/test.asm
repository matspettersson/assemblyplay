INCLUDELIB DOSCALLS.LIB

  .386
  .MODEL flat, syscall

  Dos32Write PROTO NEAR32 syscall,
      hf:WORD, pvBuf:NEAR32, cbBuf:WORD, pcbBytesWritten:NEAR32

  Dos32Exit PROTO NEAR32 syscall,
      fTerminate:WORD, ulExitCode:WORD

  .STACK 4096

  .DATA

  msg DB "Hello, world.", 13, 10
  written DW 0

  .CODE
  _start:
      INVOKE  Dos32Write,        ; OS/2 system call
          1,                     ; File handle for screen
          NEAR32 PTR msg,        ; Address of string
          LENGTHOF msg,          ; Length of string
          NEAR32 PTR written     ; Bytes written

      INVOKE  Dos32Exit,         ; OS/2 system call
          0,                     ; Terminate all threads
          0                      ; Result code for parent process

  END _start
