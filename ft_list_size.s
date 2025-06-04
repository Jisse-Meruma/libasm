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
    xor rax, rax ; set rax to 0
    cmp qword rdi, 0 ; check if pointer is NULL
    je .end

.loop:
    cmp qword [rdi + t_list.next], 0 ; check if node->*next is NULL
    je .end
    mov rdi, [rdi + t_list.next] ; Move the pointer to *next and dereference
    inc rax ; Increment Counter
    jmp .loop

.end:
    ret
