global fiboasm
global fib


; nasm -f elf64 -gdwarf fiboasm.asm -o fiboasm.o

section .bss
x1    db    ?
x2    db    ?

section .text

fiboasm:
;      push	rbp
;      mov   rbp, rsp

      cmp   rcx, 1
      jbe   .beloworequal1

      sub   rcx,1
      call  fiboasm
      mov   rbx, rax
;      jmp   .finish

      sub   rcx, 1      ;
;;      push  rdi
      call  fiboasm
      add   rax, rbx
      jmp   .finish

.beloworequal1:
      mov   rax, rcx

.finish:
;      mov	rsp,rbp
;      pop	rbp

      ret

fib:

%ifidn __OUTPUT_FORMAT__, win64 
      mov rax, rcx
%elifidn __OUTPUT_FORMAT__, elf64 
      mov rax, rdi                ; linux rdi, win rcx
      mov rcx, rdi
%endif
        sub rcx, 1
        jle fib_done            ; f(0)=0, f(1)=1
        xor rbx, rbx            ; f(n-1)
        mov rax, 1              ; f(n)
fib_loop:
        xadd rax, rbx
        sub rcx, 1
        jnz fib_loop

fib_done:
        ret




; int f(int x) {
;	int retval;
;	//printf("x=%d\n", x);
;	if(x <= 1) {
;		retval = x;
;	} else {
;		//printf("Else....\n");
;		int x1 = f(x-1);
;		int x2 = f(x-2);
;		retval =  x1 + x2;
;	}
;
;	//printf("Retval=%d\n", retval);
;	return retval;
;}
