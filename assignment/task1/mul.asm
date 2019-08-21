 SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1

segment .data 
    msg db "Please input the first number: " 
    len equ $- msg 
    endl: db "",0x0a

segment .bss

    number1 resb 2 
    number2 resb 2 
    result resb 1    
	result1 resb 1   

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
    mov edx, 2
    int 0x80            

    mov eax, SYS_WRITE        
    mov ebx, STDOUT         
    mov ecx, msg2          
    mov edx, len2         
    int 0x80

    mov eax, SYS_READ  
    mov ebx, STDIN  
    mov ecx, number2 
    mov edx, 2
    int 0x80        

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg3          
    mov edx, len3         
    int 0x80

    ; load number1 into eax and subtract '0' to convert from ASCII to decimal
    mov rax, [number1]
    sub rax, '0'
    ; do the same for number2
    mov rbx, [number2]
    sub rbx, '0'

    ; Multiply eax and ebx, storing the result in rax
    mul rbx
	;split result into two parts
	mov rdx, 0
	mov cx, 10
	idiv cx
	mov r9, rax
	mov r10, rdx

    ; add '0' to eax to convert the digit from decimal to ASCII
    add r9, '0'
	add r10, '0'

    ; store the result in result
    mov [result], r9
	mov [result1], r10

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