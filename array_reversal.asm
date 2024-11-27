section .data
    prompt db "Please input 5 numbers: ", 0
    result_msg db "Reversed array: ", 0
    newline db 10, 0             ; Newline character for formatting

section .bss
    array resb 20                ; Reserve space for input
    cleaned_array resb 20        ; Array for cleaned numbers

section .text
    global _start

_start:
    ; Step 1: Display the prompt for input
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, prompt              ; Address of the prompt message
    mov edx, 25                  ; Length of the prompt string
    int 0x80                     ; Make syscall

    ; Step 2: Read user input into the array
    mov eax, 3                   ; Syscall number for sys_read
    mov ebx, 0                   ; File descriptor (stdin)
    mov ecx, array               ; Address to store input
    mov edx, 20                  ; Max bytes to read
    int 0x80                     ; Make syscall

    ; Step 3: Clean the input (remove extra characters)
    lea esi, [array]             ; Source pointer
    lea edi, [cleaned_array]     ; Destination pointer
clean_loop:
    cmp byte [esi], 0            ; Check end of input
    je reverse_loop              ; Jump to reverse if done
    cmp byte [esi], ' '          ; Check for spaces
    je skip_space                ; Skip spaces
    mov al, byte [esi]           ; Load character
    mov byte [edi], al           ; Store in cleaned array
    inc edi                      ; Move cleaned pointer
skip_space:
    inc esi                      ; Move input pointer
    jmp clean_loop

reverse_loop:
    ; Step 4: Reverse the cleaned array
    lea esi, [cleaned_array]     ; Start of cleaned array
    lea edi, [cleaned_array + 19] ; End of cleaned array
    sub edi, 1                   ; Adjust for null terminator

reverse_array:
    cmp esi, edi                 ; Check if pointers meet or cross
    jge done_reversing           ; Done if pointers cross
    mov al, byte [esi]           ; Load start character
    mov bl, byte [edi]           ; Load end character
    mov byte [esi], bl           ; Swap end with start
    mov byte [edi], al           ; Swap start with end
    inc esi                      ; Move start pointer forward
    dec edi                      ; Move end pointer backward
    jmp reverse_array

done_reversing:
    ; Step 5: Display result message
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, result_msg          ; Address of result message
    mov edx, 16                  ; Length of result message
    int 0x80                     ; Make syscall

    ; Step 6: Output the reversed array
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    lea ecx, [cleaned_array]     ; Address of reversed array
    mov edx, 20                  ; Length of cleaned array
    int 0x80                     ; Make syscall

    ; Step 7: Print a newline
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, newline             ; Address of newline character
    mov edx, 1                   ; Length of newline
    int 0x80                     ; Make syscall

    ; Step 8: Exit program
    mov eax, 1                   ; Syscall number for sys_exit
    xor ebx, ebx                 ; Exit code 0
    int 0x80                     ; Make syscall

