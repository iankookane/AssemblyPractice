section .data                                                           
codes:                              
    db      '0123456789ABCDEF'      

section .text                       
global _start                       
_start:                         
    ; number 1122... in hexadecimal format
    mov rax, 0x1EFDC34455667788    
    
    mov rdi, 1                  
    mov rdx, 1                  
    mov rcx, 64   
	; Each 4 bits should be output as one hexadecimal digit
	; Use shift and bitwise AND to isolate them
	; the result is the offset in 'codes' array
.loop:                            
    push rax                    
    sub rcx, 4   ;subtract 4 from rcx (orginally 64 for bits)
	; cl is a register, smallest part of rcx
	; rax -- eax -- ax -- ah + al
	; rcx -- ecx -- cx -- ch + cl
    sar rax, cl   ;64 can fit in 8 bits which is cl max, so get 4 bit chunk (a hex)
    and rax, 0xf  ;clear out everything but those 4 bits
    
    lea rsi, [codes + rax]  ;load codes[rax]
    mov rax, 1                  

    ; syscall leaves rcx and r11 changed
    push rcx    ; so store rcx
    syscall     ; write the number  
    pop rcx     ; restore rcx
    
    pop rax     ; restore rax
	; test can be used for the fastest 'is it a zero?' check
	; see docs for 'test' command
    test rcx, rcx  ;if rcx is zero (did all 16 shifts) continue
    jnz .loop      ;else jump to beginning of loop and repeat
    
    mov     rax, 60            ; invoke 'exit' system call
    xor     rdi, rdi           ; return 0
    syscall
