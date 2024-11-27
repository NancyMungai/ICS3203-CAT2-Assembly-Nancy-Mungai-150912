section .data
    sensor_value db 0            ; Memory location simulating water level sensor
    motor_status db 0            ; Memory location for motor control (0 = off, 1 = on)
    alarm_status db 0            ; Memory location for alarm (0 = off, 1 = on)

    prompt_msg db "Input sensor value: ", 0
    low_msg db "Motor OFF: Water level low.", 0
    moderate_msg db "Motor OFF: Water level moderate.", 0
    high_msg db "ALARM ON: Water level high!", 0
    newline db 10, 0             ; Newline character for formatting

section .bss
    input_buffer resb 2          ; Buffer to read user input (1 byte + newline)

section .text
    global _start

_start:
    ; Display the prompt
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, prompt_msg          ; Address of the prompt message
    mov edx, 21                  ; Length of the prompt message
    int 0x80                     ; Perform syscall to display the prompt

    ; Read "sensor value" from input (simulating a sensor)
    mov eax, 3                   ; Syscall number for sys_read
    mov ebx, 0                   ; File descriptor (stdin)
    mov ecx, input_buffer        ; Address to store sensor value
    mov edx, 2                   ; Read 2 bytes (input + newline)
    int 0x80                     ; Perform syscall

    ; Convert ASCII input to integer
    movzx eax, byte [input_buffer] ; Read first byte of input
    sub eax, '0'                 ; Convert ASCII to integer
    cmp eax, 0                   ; Check if valid input (>= 0)
    jl invalid_input             ; Jump if invalid input
    cmp eax, 9                   ; Check if valid input (<= 9)
    jg invalid_input             ; Jump if invalid input
    mov [sensor_value], al       ; Store integer value back to memory

    ; Determine action based on sensor value
    cmp al, 2                    ; Compare water level to 2 (low threshold)
    jl low_level                 ; Jump if water level < 2 (low)

    cmp al, 5                    ; Compare water level to 5 (high threshold)
    jg high_level                ; Jump if water level > 5 (high)

moderate_level:
    ; Water level is moderate: Turn motor OFF
    mov byte [motor_status], 0   ; Set motor_status to OFF
    mov byte [alarm_status], 0   ; Set alarm_status to OFF
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, moderate_msg        ; Address of message
    mov edx, 29                  ; Length of message
    int 0x80                     ; Write output
    jmp end_program              ; Exit program

high_level:
    ; Water level is high: Trigger alarm
    mov byte [motor_status], 0   ; Set motor_status to OFF
    mov byte [alarm_status], 1   ; Set alarm_status to ON
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, high_msg            ; Address of message
    mov edx, 27                  ; Length of message
    int 0x80                     ; Write output
    jmp end_program              ; Exit program

low_level:
    ; Water level is low: Turn motor OFF
    mov byte [motor_status], 0   ; Set motor_status to OFF
    mov byte [alarm_status], 0   ; Set alarm_status to OFF
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, low_msg             ; Address of message
    mov edx, 29                  ; Length of message
    int 0x80                     ; Write output
    jmp end_program              ; Exit program

invalid_input:
    ; Handle invalid input
    mov eax, 4                   ; Syscall number for sys_write
    mov ebx, 1                   ; File descriptor (stdout)
    mov ecx, newline             ; Print newline for invalid input
    mov edx, 1                   ; Length of newline
    int 0x80                     ; Perform syscall

end_program:
    ; Exit program
    mov eax, 1                   ; Syscall number for sys_exit
    xor ebx, ebx                 ; Exit code 0
    int 0x80                     ; Exit
                   ; Exit
