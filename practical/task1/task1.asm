	segment .data
      init:	db "Please input your student number: ",0x0a
      msg: 	db "Your student number is: u",0x0a
      endl: db "",0x0a
	segment .bss
	inpt: resb 8
	segment .text
	global _start
_start:
	mov eax,1
	mov edi,1
	mov edx, 34
	lea rsi,[init]
	syscall

	mov eax,0
	mov edi,0
	mov edx, 8
	lea rsi,[inpt]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 25
	lea rsi,[msg]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 8
	lea rsi,[inpt]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [endl]
	syscall


	mov eax,60
	xor edi, edi
	syscall