section .text
global ft_strcpy

; char*   ft_strcpy(char *dest, const char *src);

; rdi = char* dest
; rsi = char* src

ft_strcpy:
    ; set the pointer of the dest already to the return register rax
    mov rax, rdi 

.loop:
    ; we are not allowed to move straight from memory to memory so we have to store it into a register and then copy the data in the register to the dest pointer
    mov cl, byte [rsi]
    mov byte [rdi], cl
    ; Its faster to compare straight from the register instead of memory 
    cmp cl, 0
    je .end
    ; Increment both pointers
    inc rdi
    inc rsi
    jmp .loop

.end:
    ret
