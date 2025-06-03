section .text
global ft_read

;  ssize_t ft_read(int fd, const void *buf, size_t count);
; rdi = fd
; rsi = *buf
; rdx = count

; this only works if we compile with the c runtime because __errno_location is defined there 
extern __errno_location

ft_read:
    ; syscall read = 0
    mov rax, 0
    ; the reason this works is because syscall uses rdi, rsi, rdx the exact way we recieve the data so we dont need to move any data to other locations
    syscall

    ; dit the read syscall return a negative value then we need to handle the error.
    cmp rax, 0
    jl .error
    ret

.error:
    ; make a positive errno value
    neg rax
    ; we need to save the data since calling errno location will overwrite rax
    mov rcx, rax

    call __errno_location
    ; __errno_location sets rax as a pointer to errno. 
    mov [rax], rcx
    ; after setting errno we overwrite rax to -1 since we need to return -1 when an error occurd.
    mov rax, -1
    ret
