 SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1

segment .data 
    msg db "Please input a number: " 
    len equ $- msg 
    endl: db "",0x0a
     num db 0     ;declare a variable to store the two digit input
    ten db 10     ;declare a variable that holds a value 10

segment .bss

    number1 resw 2
    num1ten resw 1
    num1one resw 1
    result resw 1    
	result1 resw 1   

segment .text 

global _start 

 _start: 

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg         
    mov edx, len 
    int 0x80                

    mov eax, SYS_READ 
    mov ebx, STDIN  
    mov ecx, number1 
    mov edx, 3
    int 0x80  
              

    ; load number1 into eax and subtract '0' to convert from ASCII to decimal
    mov rax, 0
    mov ax, [number1]


    ;NUMBER 1 SPLIT
    shr ax, 8
    sub ax, '0'
    mov [num1one], ax
    mov rax, 0
    mov ax, [number1]
    mov cx, 0x00FF
    and ax, cx
    sub ax, '0'
    mov [num1ten], ax

    ;r10b = num1ten
    ;r11b = num1one
    ;r12b = num2ten
    ;r13b = num2one

    mov r10, 0
    mov r10b, [num1ten]
    mov r11, 0
    mov r11b, [num1one]

    imul r10w, [ten]

    add r10w, r11w

    mov r13w, 0
    mov r13w, r10w
    sub r13w, 1
    and r10w, r13w

    cmp r10w, 0
    jz zero
    mov r10w, 1
    jmp one

zero: mov r10w, 0
one:

    add r10w, '0'
    ; store the result in result
    mov [result], r10w

    ; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result         
    mov edx, 1        
    int 0x80

    mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[endl]
	syscall


exit:    
    mov eax, SYS_EXIT   
    xor ebx, ebx 
    int 0x80