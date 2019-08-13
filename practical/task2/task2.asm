	segment .data
    init:	db "Please enter 3 characters: ",0x0a
    msg: 	db "Converted: ",0x0a
    endl: db "",0x0a
	segment .bss
        inpt: resb 4
	segment .text
	global _start
_start:
	mov eax,1
	mov edi,1
	mov edx, 27
	lea rsi,[init]
	syscall

	mov eax,0
	mov edi,0
	mov edx, 3
	lea rsi,[inpt]
	syscall

	mov rbx, [inpt + 0]
	sub rbx, 32
	mov [inpt + 0], rbx

	mov rbx, [inpt + 1]
	add rbx, 32
	mov [inpt + 1], rbx

	mov rbx, [inpt + 2]
	add rbx, 32
	mov [inpt + 2], rbx

	mov eax,1
	mov edi,1
	mov edx, 11
	lea rsi,[msg]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 3
	lea rsi,[inpt]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[endl]
	syscall

	mov eax,60
	xor edi, edi
	syscall