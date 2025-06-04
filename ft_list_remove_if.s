
struc   t_list
    ; we are reserving 8 bytes ofcourse because we are working with pointers
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_remove_if

extern free

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
; rdi = **begin_list
; rsi = *data_ref
; rdx = (*cmp)()
; rcx = (*free_fct)(void*)
ft_list_remove_if:
    push r12
    push r13
    push r14
    push r15
    mov r12 rdi
    mov r13 rsi
    mov r14 rdx
    mov r15 rcx
    test r12, r12
    jz .end
    call r14
    

    

    mov r8, [rdi] ; we need to make another pointer to reconnect the list
    mov 






.loop:
    
    jmp .loop 



.end:
    push r15
    push r14
    push r13
    push r12
    ret

