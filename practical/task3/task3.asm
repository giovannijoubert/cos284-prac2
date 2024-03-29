segment .data
      init:	db "Please input an integer: ",0x0a
      msg: 	db "The total sum is: ",0x0a
      endl: db "",0x0a
segment .bss
    res1: resb 10
	inpt: resb 10
	out1: resb 1
	buffer: resb 20
segment .text
	global _start
_start:
	;INITIAL MESSAGE
	mov eax,1
	mov edi,1
	mov edx, 25
	lea rsi,[init]
	syscall

	;GET INPUT NUMBER
	mov eax,0
	mov edi,0
	mov edx, 200
	lea rsi,[inpt]
	syscall

	;PRE-CALCULATION MESSAGE
	mov eax,1
	mov edi,1
	mov edx, 18
	lea rsi,[msg]
	syscall

	;CALCULATION STARTS

	;ASCII input -> Decimal Value
	xor r15, r15 ; counter
	xor r11, r11 ; interm value
	xor r10, r10 ; final value
a2d:
	cmp byte[inpt+r15], 0    ; check for end of string
	je a2dend

	mov eax, 0                      ; empty eax
	mov al, byte[inpt+r15]      ; move string position into al

	sub al, '0'
	imul r10, 10
	add r10b, al

	add r15, 1
	jmp a2d
a2dend:


	xor rax, rax
	xor rdx, rdx
	xor rcx, rcx
	xor r12, r12 ; final value
	mov rax, r10 ; input DECIMAL value stored in rax
cloop:
	cmp rax, 0
	je cloopend

	add r12, rax
	dec rax

	jmp cloop
cloopend:


	;r12 contains multidigit answer.. now output it

	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx
	xor r10, r10
	xor r11, r11

	mov rax, r12 ; value
	mov r10, 1000000000000000000 ; devisor

divloop:
	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx

	mov rax, r12
	mov rcx, r10

	idiv rcx

	cmp rax, 0
	jg divloopend

	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx

	mov rax, r10
	mov rcx, 10

	idiv rcx

	mov r10, rax

	jmp divloop
divloopend:


outloop:
	cmp r10, 1
	jle outloopend

	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx

	mov rax, r12
	mov rcx, r10

	idiv rcx

	mov r12, rdx ;save remainder as value


	;print rax
	add rax, '0'

	mov [res1], rax
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [res1]
	syscall

	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rdx,rdx

	mov rax, r10
	mov rcx, 10

	idiv rcx

	mov r10, rax

	jmp outloop
outloopend:

	add r12, '0'
	mov [res1], r12
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [res1]
	syscall

	;ENDL
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [endl]
	syscall

	;EXITSs
	mov eax,60
	xor edi, edi
	syscall