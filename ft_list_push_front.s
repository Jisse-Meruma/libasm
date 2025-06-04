struc   t_list
    ; we are reserving 8 bytes ofcourse because we are working with pointers
    .data: resq 1
    .next: resq 1
endstruc

section .text
global ft_list_push_front

extern malloc
; void ft_list_push_front(t_list **begin_list, void *data);
; rdi = **begin_list
; rsi = *data
ft_list_push_front:
    test rdi, rdi ; null protection
    jz .end
    push rdi
    push rsi
    mov rdi, t_list%+_size
    call malloc wrt ..plt ; rax is now *t_list
    pop rsi
    pop rdi
    cmp rax, 0 ; did malloc fail?
    je .end
    mov qword [rax + t_list.data], rsi ; set the data into the struct
    cmp qword [rdi], 0 ; is it an empty list?
    je .push_front
    mov rdx, qword [rdi]
    mov qword [rax + t_list.next], rdx

.push_front:
    mov qword [rdi], rax ; push the node to the beginnen of the list

.end:
    ret

