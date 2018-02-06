;nasm -felf64 001_hello.asm
;ld -o 001_hello 001_hello.o
global _start   ; Here we declare label _start which is the entrypoint

section .data   ; Section data is used for global variables
message: db 'hello, world!', 10     ; db is used for data in bytes, 10 is a
                                    ; special character for new line

section .text   ; Section text is used for instructions
_start:
    mov     rax, 1    ; system call number should be stored in rax
    mov     rdi, 1    ; argument #1 in rdi: where to write (descriptor)?
    mov     rsi, message    ; argument #2 in rsi: where does string start?
    mov     rdx, 14     ; argument #3: how many bytes to write?
    syscall     ;invoke the syscall (write in this case) using the arguments
    
    mov     rax, 60     ; exit syscall is #60
    xor     rdi, rdi    ; zero out rdi an argument for syscall (exit code)
    syscall     ; exit
