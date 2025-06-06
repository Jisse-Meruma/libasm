struc   t_list
    ; we are reserving 8 bytes ofcourse because we are working with pointers
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_size

; int ft_list_size(t_list *begin_list);
; rdi = *begin_list
ft_list_size:
    push r12
    xor rax, rax ; set rax to 0
    mov r12, rdi
    test r12, r12 ; check if pointer is NULL
    jz .end

.loop:
    inc rax ; Increment Counter
    cmp qword [r12 + t_list.next], 0 ; check if node->*next is NULL
    je .end
    mov r12, qword [r12 + t_list.next] ; Move the pointer to *next and dereference
    jmp .loop

.end:
    pop r12
    ret
