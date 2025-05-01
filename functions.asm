; Name: Dominic McElroy 
; Date: 5/1/2025
; Purpose: Assignment 4 

section .data
    prompt db "Enter a string: ", 0
    yes db "Palindrome? Yes", 10, 0
    no db "Palindrome? No", 10, 0
    format_in db "%s", 0

section .bss
    user_input resb 100

section .text
    global addstr, factstr, is_palindrome, palindrome_check
    extern atoi, printf, scanf, fact

addstr:
    push ebp
    mov ebp, esp
    push ebx
    push esi

    mov esi, [ebp+8]
    test esi, esi
    jz .return_zero
    push esi
    call atoi
    add esp, 4
    mov ebx, eax

    mov esi, [ebp+12]
    test esi, esi
    jz .return_zero
    push esi
    call atoi
    add esp, 4

    add eax, ebx
    pop esi
    pop ebx
    pop ebp
    ret

.return_zero:
    xor eax, eax
    pop esi
    pop ebx
    pop ebp
    ret

factstr:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp+8]
    test ebx, ebx
    jz .return_zero_fact
    push ebx
    call atoi
    add esp, 4
    push eax
    call fact
    add esp, 4

    pop ebx
    pop ebp
    ret

.return_zero_fact:
    xor eax, eax
    pop ebx
    pop ebp
    ret

is_palindrome:
    push ebp
    mov ebp, esp
    push ebx
    push esi
    push edi

    mov esi, [ebp+8]
    test esi, esi
    jz .not_palindrome
    
    xor ecx, ecx
.len_loop:
    cmp byte [esi+ecx], 0
    je .done_len
    inc ecx
    jmp .len_loop
    
.done_len:
    mov edi, ecx
    dec edi
    xor ecx, ecx
    
.compare_loop:
    cmp ecx, edi
    jge .true_palindrome
    mov al, [esi+ecx]
    mov bl, [esi+edi]
    cmp al, bl
    jne .not_palindrome
    inc ecx
    dec edi
    jmp .compare_loop
    
.true_palindrome:
    mov eax, 1
    jmp .done
    
.not_palindrome:
    xor eax, eax
    
.done:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

palindrome_check:
    push ebp
    mov ebp, esp

    push prompt
    call printf
    add esp, 4

    push user_input
    push format_in
    call scanf
    add esp, 8

    push user_input
    call is_palindrome
    add esp, 4

    cmp eax, 1
    jne .print_no
    push yes
    call printf
    add esp, 4
    jmp .done

.print_no:
    push no
    call printf
    add esp, 4

.done:
    pop ebp
    ret
