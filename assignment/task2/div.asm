 SYS_EXIT  equ 1
    SYS_READ  equ 3
    SYS_WRITE equ 4
    STDIN     equ 0
    STDOUT    equ 1

segment .data 

    msg db "Please input the first number: " 
    len equ $- msg 
    endl: db "",0x0a
	re: db "r"

segment .bss

    number1 resq 1 
    number2 resq 1 
    result resq 1    
	result2 resq 1  

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

mov eax,0
	mov edi,0
	mov edx, 2
	lea rsi,[number1]
	syscall         

    mov eax, SYS_WRITE        
    mov ebx, STDOUT         
    mov ecx, msg2          
    mov edx, len2         
    int 0x80

  mov eax,0
	mov edi,0
	mov edx, 2
	lea rsi,[number2]
	syscall      

    mov eax, SYS_WRITE         
    mov ebx, STDOUT         
    mov ecx, msg3          
    mov edx, len3         
    int 0x80

    ; load number1 into eax and subtract '0' to convert from ASCII to decimal
	mov rax,0
    mov al, [number1]
    sub rax, '0'
    ; do the same for number2
	mov rbx,0
    mov bl, [number2]
    sub rbx, '0'

    ; add eax and ebx, storing the result in eax
	mov edx, 0
    idiv rbx
    ; add '0' to eax to convert the digit from decimal to ASCII
    add rax, '0'
	add edx, '0'

    ; store the result in result
    mov [result], ax
	mov [result2], dx

    ; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result         
    mov edx, 1        
    int 0x80

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[re]
	syscall

	 ; print the result digit
    mov eax, SYS_WRITE        
    mov ebx, STDOUT
    mov ecx, result2         
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