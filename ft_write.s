section .text
global ft_write

;  ssize_t ft_write(int fd, const void *buf, size_t count);
; rdi = fd
; rsi = *buf
; rdx = count

; this only works if we compile with the c runtime because __errno_location is defined there 
extern __errno_location

ft_write:
    mov rax, 1 ; syscall write = 0
    syscall ; the reason this works is because syscall uses rdi, rsi, rdx the exact way we recieve the data so we dont need to move any data to other locations
    cmp rax, 0 ; did the write syscall return a negative value then we need to handle the error.
    jl .error
    ret

.error:
    neg rax ; make a positive errno value
    mov rcx, rax ; we need to save the data since calling errno location will overwrite rax
    call __errno_location wrt ..plt
    mov [rax], rcx ; __errno_location sets rax as a pointer to errno. 
    mov rax, -1 ; after setting errno we overwrite rax to -1 since we need to return -1 when an error occurd.
    ret
