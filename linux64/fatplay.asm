
    section .data

    ; BPB for FAT12 and FAT16 volumes
    struc BPB_FAT12
    .bpbBytesPerSector: resw 1;DW ? ; 0x0B
    .bpbSectorsPerCluster: resb 1 ;0x0D
    .bpbReservedSectors: resw 1; DW ? ;0x0E
    .bpbNumberOfFATs: resb 1; DB ? ;0x10
    .bpbRootEntries: resw 1 ;0x11
    .bpbTotalSectors: resw 1 ;0x13
    .bpbMedia: resb 1 ;DB ? ;0x15
    .bpbSectorsPerFAT: resw 1;DW ?, ;0x16
    .bpbSectorsPerTrack: resw 1;DW ? ;0x18
    .bpbHeadsPerCylinder: resw 1;DW ? ;0x1A
    .bpbHiddenSectors: resd 1;DD ? ;0x1C
    .bpbTotalSectorsBig: resd 1;DD ? ;0x20
    endstruc

    ; BPB for FAT32 volumes
    ;struc BPB_FAT32
    ;bpbBytesPerSector: DW ? ; 0x0B
    ;bpbSectorsPerCluster: DB ? ; 0x0D
    ;bpbReservedSectors: DW ? ; 0x0E
    ;bpbNumberOfFATs: DB ? ; 0x10
    ;bpbRootEntries: DW ? ; 0x11
    ;bpbTotalSectors: DW ? ; 0x13
    ;bpbMedia: DB ? ; 0x15
    ;bpbSectorsPerFAT: DW ? ; 0x16
    ;bpbSectorsPerTrack: DW ? ; 0x18
    ;bpbHeadsPerCylinder: DW ? ; 0x1A
    ;bpbHiddenSectors: DD ? ; 0x1C
    ;bpbTotalSectorsBig: DD ? ; 0x20
    ;bpb32SectorsPerFAT: DD ? ; 0x24
    ;bpb32Flags: DW ? ; 0x28
    ;bpb32Version: DW ? ; 0x2A
    ;bpb32RootCluster: DD ? ; 0x2C
    ;bpb32InfoSector: DW ? ; 0x30
    ;bpb32BootBackupStart: DW ? ; 0x32
    ;bpb32Reserved: DB 12 DUP (?) ; 0x34
    ;endstruc

    ; Boot Sector layout for FAT12 and FAT16
    struc BS_FAT12
    .bsJmp: resb 3;DB 3 DUP (?) ; 0x00
    .bsOemName: resb 8;DB 8 DUP (?), ; 0x03
    ;bsFAT12 BPB_FAT12 Structure, ; 0x0B
    ;bsFAT12 BPB_FAT12,
    .bsFAT12:  resb BPB_FAT12_size
    .bsDriveNumber: resb 1;DB ?, ; 0x24
    .bsUnused: resb 1;DB ?, ; 0x25
    .bsExtBootSignature: resb 1;DB ?, ; 0x26
    .bsSerialNumber: resd 1;DD ?, ; 0x27
    .bsVolumeLabel: resb 8;DB 8 dup(?), ;"NO NAME ", ; 0x2B
    .bsFileSystem: resb 6;DB 6 dup(?), ;"FAT12 ", ; 0x36
    .bsBootCode: resb 450;DB 450 DUP (?) ; 0x3E
    endstruc

    ;Boot Sector layout for FAT32
    ;struc BS_FAT32
    ;bsJmp: DB 3 DUP (?), ; 0x00
    ;bsOemName: DB 8 DUP (?), ; 0x03
    ;bsFAT32 BPB_FAT32 , ;Structure 0x0B
    ;bs32DriveNumber: DB ?, ; 0x40
    ;bs32Unused: DB ?, ; 0x41
    ;bs32ExtBootSignature: DB ?, ; 0x42
    ;bs32SerialNumber: DD ?, ; 0x43
    ;bs32VolumeLabel: DB 8 dup(?), ;"NO NAME ", ; 0x47
    ;bs32FileSystem: DB 6 dup(?), ;"FAT32 ", ; 0x52
    ;bs32BootCode: DB 422 DUP (?) ; 0x5A
    ;endstruc

    msg:    db "Hello, world,", 0
    msg2:   db "...and goodbye!", 0
    fmt:    db "%s", 10, 0

      bootsector: resb BS_FAT12_size
      fn:     db  '/home/habanero/source/cplay/dosimage.img',0
      crlf:  db  13,10,0
      ;buffer: db 512 dup(?)


section .bss

section .text
default rel
extern printf
global main

main:
;_start:
    mov edi, 5
    call  print_uint32
    jmp exit
    ; open the file
    xor rax,rax
    add al, 2
    lea rdi, [fn]
    xor rsi, rsi
    syscall

    mov rdi, rax
    sub sp, 0xfff
    ;lea rsi, [rsp]
    lea rsi, [bootsector]
    xor rdx, rdx
    mov dx, 0x200
    xor rax, rax
    syscall

;    mov esi, bootsector + BS_FAT12.bsOemName
;    mov esi, msg    ; 64-bit ABI passing order starts w/ edi, esi, ...
;    mov edi, fmt    ;
;    mov eax, 0      ; printf is varargs, so EAX counts # of non-integer arguments being passed
;    call printf  wrt ..plt

;    mov	rdi, fmt
    ;mov	rsi, bootsector + BS_FAT12.bsOemName
;    mov rsi, msg
;    mov	rax, 0
    ; Call printf
    ;call printf wrt ..plt


    ;mov rax, 3
    ; rdi innehåller redan fh
    ;syscall

    ; write to stdout
    mov	rsi, bootsector + BS_FAT12.bsOemName
    xor rdi, rdi
    add dil, 1
    mov rdx, rax  ; hela bufferten
    mov rdx, 8
    xor rax, rax
    add al,1
    syscall
    call prnewline
exit:    ; exit
    xor rax,rax
    add al, 60
    syscall
    ret

prnewline:
    mov	rsi, crlf
    xor rdi, rdi
    add dil, 1
    mov rdx, 3
    xor rax, rax
    add al,1
    syscall
    ret


;    ALIGN 16
    ; void print_uint32(uint32_t edi)
    ; x86-64 System V calling convention.  Clobbers RSI, RCX, RDX, RAX.
    ; optimized for simplicity and compactness, not speed (DIV is slow)
    global print_uint32
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
