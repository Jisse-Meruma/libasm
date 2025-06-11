
struc   t_list
    ; we are reserving 8 bytes ofcourse because we are working with pointers
    .data: resq 1
    .next: resq 1
endstruc

; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(void*, void*), void (*free_fct)(void *))
; {
;     t_list *temp;
;     t_list *node = *begin_list;
;     while (node->next)
;     {
;         if (!cmp(node->next->data, data_ref));
;         {
;             free_fct(node->next->data);
;             temp = node->next;
;             node->next = temp->next;
;             free(temp);
;         }
;         node = node->next;
;     } 
;     node = *begin_list;
;     if (!cmp(node->data, data_ref))
;     {
;         free_fct(node->data);
;         *begin_list = node->next;
;         free(node->next); // we can free NULL
;     }
; }

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
    push rbp
    push rbp ; need for stinky stack alligment

    xor rbx, rbx ; current node
    xor rbp, rbp ; remove node
    mov r12, rdi ; **begin_list
    mov r13, rsi ; *data_ref
    mov r14, rdx ; (*cmp)(void*, void*)
    mov r15, rcx ; (*free_fct)(void*)
    test r12, r12
    jz .end
    mov rbx, [r12] ; copy node struct out of head
    
.loop:
    test rbx, rbx ; is node NULL
    je .end
    mov rbp, [rbx + t_list.next] ; temp = node->next
    test rbp, rbp
    jz .check_final
    mov rdi, [rbp + t_list.data] ; node->next->data
    mov rsi, r13 ; *data_ref
    call r14 ; call cmp
    test rax, rax ; test if cmp func returned 0 
    jz .remove_node
    mov rbx, [rbx + t_list.next] ; node = node->next
    jmp .loop

.remove_node:
    mov rdi, [rbp + t_list.data] ; node->next->data
    call r15 ; free_fct func
    mov rdi, [rbp + t_list.next] ; node->next = node->next->next
    mov [rbx + t_list.next], rdi
    mov rdi, rbp
    call free wrt ..plt ; free(temp)
    jmp .loop

.check_final:
    mov rbx, [r12] ; node = *begin_list 
    mov rdi, [rbx + t_list.data] 
    mov rsi, r13
    call r14 ; compare with the cmp function
    test rax, rax
    jnz .end
    mov rdi, [rbx + t_list.data]
    call r15 ; free the data object inside the struct
    mov rdi, [rbx + t_list.next]
    mov [r12], rdi
    mov rdi, rbx ; move node to rdi to be freed
    call free wrt ..plt
    jmp .end


.end:
    pop rbp
    pop rbp
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    ret

