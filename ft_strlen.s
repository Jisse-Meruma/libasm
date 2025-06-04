section .text
global ft_strlen

; int ft_strlen(char* str)
; rdi = (first argument register) rax = (return register)
ft_strlen:
   mov rax, rdi ; instruction [mov (dst, src)] moves data from one register to another

.loop:
    ; we compare the value inside rax with that of 0. 
    ; (byte) is how much we want to extract from rax we are extracting a single byte = 8 bits
    ; cmp will set the zero flag ZF to either true or false depending on the result of the cmp. (E.g: [rax] == 0 [ZF = 1])
    cmp byte [rax], 0
    je .end ; je instruction will jump to end if the ZF falg is 1 (aka) if compare returned true
    inc rax ; we increment the pointer address by 1
    jmp .loop ; we jump back into the loop

.end:
    sub rax, rdi ; we subtract the starting pointer address with the incremented address resulting in amount incremented.
    ret

