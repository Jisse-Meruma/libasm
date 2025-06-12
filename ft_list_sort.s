struc   t_list
    ; we are reserving 8 bytes ofcourse because we are working with pointers
    .data: resq 1
    .next: resq 1
endstruc

; void ft_list_sort(t_list **begin_list, int (*cmp)(void*, void*))
; {
;     t_list *node = *begin_list;
;     t_list *next = node->next;
;     void* temp; 
    
;     while (next != NULL)
;     {
;         if (cmp(node->data, next->data) > 0)
;         {
;             temp = node->data;
;             node->data = next->data;
;             next->data = temp;
;             node = *begin_list;
;             next = node->next;
;         }
;         node = node->next;
;         next = next->next;
;     }
; }

section .text
global ft_list_sort

; void ft_list_sort(t_list **begin_list, int (*cmp)(void*, void*))
; rdi = **begin_list
; rsi = cmp(void*, void*)
ft_list_sort:
    push r12
    push r13
    push r14
    push r15
    push r15 ; for stinky stack alligment
    test rdi, rdi
    jz .end
    test rsi, rsi
    jz .end

    mov r13, rsi ; cmp
    mov r15, rdi ; **begin_list
    mov r12, [r15] ; node
    mov r14, [r12 + t_list.next] ; next = node->next

.loop:
    test r14, r14
    jz .end
    mov rdi, [r12 + t_list.data]
    mov rsi, [r14 + t_list.data]
    call r13
    test eax, eax ; we need to use eax since we are comparing a int (4 bits) not a pointer (8 bits)
    jg .swap_data ; jump if the data needs to be swapped
    mov r12, [r12 + t_list.next] ; increment to the next node
    mov r14, [r14 + t_list.next] ; increment to the next node
    jmp .loop

.swap_data:
   mov rdi, [r12 + t_list.data]
   mov rsi, [r14 + t_list.data]
   mov [r12 + t_list.data], rsi
   mov [r14 + t_list.data], rdi
   mov r12, [r15] ; reset to the start of the array *begin_list
   mov r14, [r12 + t_list.next] ; next = node->next
   jmp .loop

.end:
    pop r15
    pop r15
    pop r14
    pop r13
    pop r12
    ret
