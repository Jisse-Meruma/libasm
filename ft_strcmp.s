section .text
global ft_strcmp

; int     ft_strcmp(const char *s1, const char *s2);
; rdi = char* s1
; rsi = char* s2

ft_strcmp:

.loop:
    mov cl, byte [rdi]
    cmp byte [rsi], cl
    jne .end
    cmp byte [rsi], 0
    je .end
    cmp cl, 0
    je .end
    inc rdi
    inc rsi
    jmp .loop

.end:
    sub cl, byte [rsi]
    ; we need to use the instruction movsx because we are moving an 8 bit register into a 64 bit register.
    ; Simply moving it will leave the upper bits garbage or zero, which can be wrong if the number is negative.
    ; if we want it to make it unsigned we should use the instruction movzx (move with zero extension)
    
    ; mov al, cl → al = 0xFB (only low 8 bits, no extension)
    ; movsx rax, cl → rax = 0xFFFFFFFFFFFFFFFB (64-bit sign-extended -5)
    ; movzx rax, cl → rax = 0x00000000000000FB (64-bit zero-extended 251 unsigned)

    movsx rax, cl
    ret
    