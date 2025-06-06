section .text
global ft_strdup

; declare malloc from libc
extern malloc
extern ft_strlen
extern ft_strcpy

ft_strdup:
    ; ft_strlen will set rax to len of string
    ; rdi register is already set to the designated string and is not modified by the callee
    call ft_strlen
    push rdi  ; we need to save the pointer to the string, so we push it to the stack.
    ; now we are free to use rdi as size of string since that is what malloc uses
    ; rax has the stored return of ft_strlen
    mov rdi, rax
    inc rdi
    ; malloc uses rdi as amount of bytes to allocate
    ; rax will be the pointer to the allocated array
    call malloc wrt ..plt
    cmp rax, 0 ; we need to check if malloc fails. if it does rax will be set to 0
    je .error
    pop rsi ; we pop the result into rsi since that is the register that strcpy uses as source
    mov rdi, rax
    call ft_strcpy
    ret

.error:
    pop rdi ; if we error we still should balance the stack out. so we return the pointer to its corresponding register when it was pushed.
    ret






