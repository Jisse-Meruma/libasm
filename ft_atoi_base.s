; int get_base_numb(char c, const char* base)
; {
;     int i = 0;

;     while (base[i] != '\0')
;     {
;         if (base[i] == c)
;             return i;
;         i++;
;     }
;     return -1;
; }

; int ft_atoi_base(const char* str, const char* base)
; {
;     int i = 0;
;     int sign = 0;
;     int numb = 0;
;     int check;
;     int base_len = ft_strlen(base);

;     while (str[i] == '\t' || str[i] == '\v' || str[i] == ' ' || str[i] == '\n' || str[i] == '\r' || str[i] == '\f')
;         i++;
;     while (str[i] != '\0' && (str[i] == '-' || str[i] == '+'))
;     {
;         i++;
;         sign++;
;     }
;     sign = (sign % 2) == 1 ? -1 : 1; ; just check right bit bro
;     while (str[i] != '\0')
;     {
;         check = get_base_numb(str[i], base);
;         if (check == -1)
;             return (numb * sign);
;         numb *= base_len;
;         numb += check;
;         i++;
;     }
;     return (numb * sign);
; }


tab             equ 0x09
newline         equ 0x0A
vertical_tab    equ 0x0B
form_feed       equ 0x0C
carriage_return equ 0x0D
space           equ 0x20
minus           equ 0x2D
plus            equ 0x2B

section .text
global ft_atoi_base

extern ft_strlen
; int    ft_atoi_base(const char *str, const char *base);
; rdi = *str
; rsi = *base
ft_atoi_base:
    push r12
    push r13
    push r14
    push r15
    mov r12, rdi ; *str
    mov r13, rsi ; *base
    mov rdi, r13
    call ft_strlen
    mov r14, rax ; base_len int
    xor r15, r15 ; numb
    mov rdi, 1 ; sign

.skipSpaces:
    cmp byte [r12], tab
    je .incrementSpaces
    cmp byte [r12], newline
    je .incrementSpaces
    cmp byte [r12], vertical_tab
    je .incrementSpaces
    cmp byte [r12], form_feed
    je .incrementSpaces
    cmp byte [r12], carriage_return
    je .incrementSpaces
    cmp byte [r12], space
    je .incrementSpaces
    jmp .checkNegative
    

.incrementSpaces:
    inc r12
    jmp .skipSpaces

.checkNegative:
    cmp byte [r12], 0
    je .end
    cmp byte [r12], plus
    je .increment
    cmp byte [r12], minus
    je .incrementNegative
    jmp .loop

.incrementNegative:
    inc r12
    neg rdi
    jmp .checkNegative

.increment:
    inc r12
    jmp .checkNegative

.loop:
    cmp byte [r12], 0 ; interate untill null terminator
    je .end
    xor rcx, rcx ; index = 0
    mov rsi, r13 ; we need to save the start location of the address *base
    mov dl, byte [r12] ; we only need to check a single char
    mov rax, -1 ; preset rax to -1 so we dont have to do that in the loop if it fully falls through

.getBaseNumb:
    cmp byte [rsi], 0
    je .loop2
    cmp byte [rsi], dl ; check if the basenumber is equeal and return the index (aka value)
    je .setBaseNumb
    inc rcx ; index++
    inc rsi ; base++
    jmp .getBaseNumb

.setBaseNumb:
    mov rax, rcx ; return the index of the base array
    jmp .loop2

.loop2:
    cmp rax, -1
    je .end
    imul r15, r14 ; base_len
    add r15, rax ; numb += baseNumb
    inc r12
    jmp .loop

.end:
    imul r15, rdi ; numb *= sign (make it negative if needed)
    mov rax, r15
    pop r15
    pop r14
    pop r13
    pop r12
    ret
