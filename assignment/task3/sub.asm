 SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1

segment .data 
    msg db "Please input the first number: " 
    len equ $- msg 
    endl: db "",0x0a
     num db 0     ;declare a variable to store the two digit input
    ten db 10     ;declare a variable that holds a value 10

segment .bss

    number1 resw 2 
    number2 resw 2 
    num1ten resw 1
    num1one resw 1
    num2ten resw 1
    num2one resw 1
    result resw 1    
	result1 resw 1   

segment .text 

    msg2 db "Please input the second number: "
    len2 equ $- msg2 

    msg3 db ""
    len3 equ $- msg3

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
              

    mov eax, SYS_WRITE        
    mov ebx, STDOUT         
    mov ecx, msg2          
    mov edx, len2         
    int 0x80

    mov eax, SYS_READ  
    mov ebx, STDIN  
    mov ecx, number2 
    mov edx, 3
    int 0x80        

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg3          
    mov edx, len3         
    int 0x80

    ; load number1 into eax and subtract '0' to convert from ASCII to decimal
    mov rax, 0
    mov ax, [number1]
    ; do the same for number2
    mov rbx, 0
    mov bx, [number2]


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

    ;NUMBER 2 SPLIT
    shr bx, 8
    sub bx, '0'
    mov [num2one], bx
    mov rbx, 0
    mov bx, [number2]
    mov cx, 0x00FF
    and bx, cx
    sub bx, '0'
    mov [num2ten], bx

    ;r10b = num1ten
    ;r11b = num1one
    ;r12b = num2ten
    ;r13b = num2one

    mov r10, 0
    mov r10b, [num1ten]
    mov r11, 0
    mov r11b, [num1one]
    mov r12, 0
    mov r12b, [num2ten]
    mov r13, 0
    mov r13b, [num2one]

    imul r10w, [ten]
    imul r12w, [ten]

    add r10b, r11b
    add r12b, r13b 

    sub r10b, r12b

    ;split result into two parts
    mov rax, 0
    mov ax, r10w
	mov rdx, 0
	mov cx, 10
	idiv cx



    add ax, '0'
    add dx, '0'

    ; store the result in result
    mov [result], ax
	mov [result1], dx

    ; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result         
    mov edx, 1        
    int 0x80


	; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result1         
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