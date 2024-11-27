section .data
    prompt db "Enter a number: ", 0        ; Prompt message
    positive_msg db "The number is POSITIVE.", 0
    negative_msg db "The number is NEGATIVE.", 0
    zero_msg db "The number is ZERO.", 0

section .bss
    input resb 10                         ; Buffer to store user input

section .text
    global _start

_start:
    ; Display prompt
    mov eax, 4                            ; syscall: write
    mov ebx, 1                            ; file descriptor: stdout
    mov ecx, prompt                       ; address of prompt message
    mov edx, 16                           ; length of prompt message
    int 0x80                              ; interrupt to invoke syscall

    ; Read user input
    mov eax, 3                            ; syscall: read
    mov ebx, 0                            ; file descriptor: stdin
    mov ecx, input                        ; address of input buffer
    mov edx, 10                           ; max bytes to read
    int 0x80                              ; interrupt to invoke syscall

    ; Convert ASCII input to integer (assuming input is a single number)
    mov eax, 0                            ; Clear eax (initialize to 0)
    mov ebx, input                        ; Load address of input buffer

convert_loop:
    movzx ecx, byte [ebx]                 ; Load next byte of input into ecx
    cmp ecx, 10                            ; Check if it is a newline (ASCII value 10)
    je done_conversion                     ; If newline, we're done
    sub ecx, '0'                           ; Convert from ASCII to integer (subtract ASCII value of '0')
    imul eax, eax, 10                      ; Multiply current number in eax by 10 (shift left by one decimal place)
    add eax, ecx                           ; Add the current digit to eax
    inc ebx                                ; Move to the next character
    jmp convert_loop                       ; Repeat the loop

done_conversion:
    ; Now, eax contains the integer value of the user input in decimal

    ; Branching logic
    cmp eax, 0                            ; Compare input with zero
    je is_zero                            ; Jump to is_zero if equal
    jl is_negative                        ; Jump to is_negative if less
    jmp is_positive                       ; Unconditional jump to is_positive

is_positive:
    ; Display "POSITIVE"
    mov eax, 4                            ; syscall: write
    mov ebx, 1                            ; file descriptor: stdout
    mov ecx, positive_msg                 ; address of message
    mov edx, 24                           ; length of message
    int 0x80                              ; interrupt to invoke syscall
    jmp end                               ; Jump to end of program

is_negative:
    ; Display "NEGATIVE"
    mov eax, 4                            ; syscall: write
    mov ebx, 1                            ; file descriptor: stdout
    mov ecx, negative_msg                 ; address of message
    mov edx, 24                           ; length of message
    int 0x80                              ; interrupt to invoke syscall
    jmp end                               ; Jump to end of program

is_zero:
    ; Display "ZERO"
    mov eax, 4                            ; syscall: write
    mov ebx, 1                            ; file descriptor: stdout
    mov ecx, zero_msg                     ; address of message
    mov edx, 20                           ; length of message
    int 0x80                              ; interrupt to invoke syscall

end:
    ; Exit program
    mov eax, 1                            ; syscall: exit
    xor ebx, ebx                          ; status: 0
    int 0x80                              ; interrupt to invoke syscall

