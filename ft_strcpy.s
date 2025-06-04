section .text
global ft_strcpy

; char*   ft_strcpy(char *dest, const char *src);
; rdi = char* dest
; rsi = char* src
ft_strcpy:
    mov rax, rdi ; set the pointer of the dest already to the return register rax

.loop:
    mov cl, byte [rsi] ; we are not allowed to move straight from memory to memory so we have to store it into a register and then copy the data in the register to the dest pointer
    mov byte [rdi], cl
    cmp cl, 0 ; Its faster to compare straight from the register instead of memory 
    je .end
    ; Increment both pointers
    inc rdi
    inc rsi
    jmp .loop

.end:
    ret
