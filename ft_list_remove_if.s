
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
    push rbx
    xor rbx, rbx
    mov r12, rdi ; **begin_list
    mov r13, rsi ; *data_ref
    mov r14, rdx ; (*cmp)()
    mov r15, rcx ; (*free_fct)(void*)
    test r12, r12
    jz .end

.loop:
    mov rbx, [r12] ; copy node struct out of head
    mov rdi, [rbx + t_list.data]
    mov rsi, r13
    call r14
    test rax, rax ; test if cmp func returned 0
    jz .remove_node
    




    

    mov r8, [rdi] ; we need to make another pointer to reconnect the list
    mov 






.loop:
    
    jmp .loop 



.end:
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

