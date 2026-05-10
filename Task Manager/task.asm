; Task Manager for data.txt (NASM - DOS 16-bit)
; Compile: nasm -f bin task.asm -o task.com

org 100h

section .text

start:
    ; --- Main Menu ---
    mov dx, menu_msg
    mov ah, 09h
    int 21h

    ; --- User Input ---
    mov ah, 01h
    int 21h
    
    cmp al, '1'
    je near add_to_file
    
    cmp al, '2'
    je near view_the_file
    
    cmp al, '3'
    je near exit_app
    
    jmp start

add_to_file:
    ; 1. Get Priority
    mov dx, prio_prompt
    mov ah, 09h
    int 21h
    mov ah, 01h
    int 21h
    mov [prio_val], al

    ; 2. Get Task
    mov dx, task_prompt
    mov ah, 09h
    int 21h

    mov si, task_buffer
    mov cx, 0
input_loop:
    mov ah, 01h
    int 21h
    cmp al, 13 ; Enter key?
    je input_finished
    mov [si], al
    inc si
    inc cx
    jmp input_loop
input_finished:
    mov [task_size], cx

    ; 3. Open/Create data.txt
    mov ah, 3Dh
    mov al, 2           ; Read/Write mode
    mov dx, filename    ; "data.txt"
    int 21h
    jc create_it        ; If file doesn't exist, create it
    mov [f_handle], ax
    jmp go_to_end

create_it:
    mov ah, 3Ch
    mov cx, 0
    mov dx, filename
    int 21h
    mov [f_handle], ax

go_to_end:
    ; Move pointer to end of data.txt for Appending
    mov ah, 42h
    mov al, 2
    mov bx, [f_handle]
    mov cx, 0
    mov dx, 0
    int 21h

    ; --- Write to File ---
    mov bx, [f_handle]
    
    ; Write Priority
    mov ah, 40h
    mov cx, 1
    mov dx, prio_val
    int 21h

    ; Write Divider
    mov ah, 40h
    mov cx, 1
    mov dx, sep
    int 21h

    ; Write Task
    mov ah, 40h
    mov cx, [task_size]
    mov dx, task_buffer
    int 21h

    ; Write Newline
    mov ah, 40h
    mov cx, 2
    mov dx, nl
    int 21h

    ; Close file
    mov ah, 3Eh
    mov bx, [f_handle]
    int 21h

    mov dx, success
    mov ah, 09h
    int 21h
    jmp start

view_the_file:
    ; --- Open data.txt to READ ---
    mov ah, 3Dh
    mov al, 0           ; Read only
    mov dx, filename
    int 21h
    jc file_not_found
    mov [f_handle], ax

    mov dx, header
    mov ah, 09h
    int 21h

read_loop:
    mov ah, 3Fh
    mov bx, [f_handle]
    mov cx, 1
    mov dx, single_char
    int 21h
    
    cmp ax, 0           ; End of file?
    je finish_view

    ; Display char
    mov dl, [single_char]
    mov ah, 02h
    int 21h
    jmp read_loop

finish_view:
    mov ah, 3Eh
    mov bx, [f_handle]
    int 21h
    jmp start

file_not_found:
    mov dx, err_msg
    mov ah, 09h
    int 21h
    jmp start

exit_app:
    mov ah, 4Ch
    int 21h

section .data
    filename      db 'data.txt', 0    ; <--- Yeh raha file ka naam
    menu_msg      db 13, 10, '--- DATA.TXT MANAGER ---', 13, 10, '1. Add Task', 13, 10, '2. View File', 13, 10, '3. Exit', 13, 10, 'Choice: $'
    prio_prompt   db 13, 10, 'Priority (1-3): $'
    task_prompt   db 13, 10, 'Task Name: $'
    success       db 13, 10, 'Done! Saved in data.txt$', 13, 10
    header        db 13, 10, '--- Content of data.txt ---', 13, 10, '$'
    err_msg       db 13, 10, 'File data.txt not found yet!$', 13, 10
    sep           db '|'
    nl            db 13, 10

section .bss
    f_handle      resw 1
    prio_val      resb 1
    task_buffer   resb 128
    task_size     resw 1
    single_char   resb 1