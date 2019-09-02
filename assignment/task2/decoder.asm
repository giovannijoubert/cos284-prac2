segment .data
      shiftmsg:	db "Please input the shift degree: ",0x0a
      inptmsg: 	db "Please input the string to decode: ",0x0a
	  outptmsg: 	db "Decoded text:  ",0x0a
      endl: db "",0x0a
segment .bss
    res1: resb 10
	inpt: resb 100
	shiftdegree: resb 10
	dshiftdegree: resb 10
	out1: resb 1
	buffer: resb 20
segment .text
	global _start
_start:
	;SHIFT MESSAGE
	mov eax,1
	mov edi,1
	mov edx, 31
	lea rsi,[shiftmsg]
	syscall

	;GET INPUT NUMBER
	mov eax,0
	mov edi,0
	mov edx, 3
	lea rsi,[shiftdegree]
	syscall

	;INPT REQEUST MESSAGE
	mov eax,1
	mov edi,1
	mov edx, 35
	lea rsi,[inptmsg]
	syscall

	;GET MESSAGE NUMBER
	mov eax,0
	mov edi,0
	mov edx, 2000
	lea rsi,[inpt]
	syscall

	;PRE-SHIFT MESSAGE
	mov eax,1
	mov edi,1
	mov edx, 14
	lea rsi, [outptmsg]
	syscall

;SPLIT DEGREE TO DECIMAL

	;ASCII input -> Decimal Value
	xor r15, r15 ; counter
	xor r11, r11 ; interm value
	xor r10, r10 ; final value
a2d:
	cmp byte[shiftdegree+r15], 10    ; check for end of string
	je a2dend

	mov eax, 0                      ; empty eax
	mov al, byte[shiftdegree+r15]      ; move string position into al

	sub al, '0'
	imul r10, 10
	add r10b, al

	add r15, 1
	jmp a2d
a2dend:

	mov [dshiftdegree], r10;

	xor r15, r15 ; counter
	xor r14, r14
shiftloop:
	cmp byte[inpt+r15], 10    ; check for end of string
	je shiftloopend

	mov r14, 0                      ; empty eax
	mov r14b, byte[inpt+r15]      ; move string position into al

	cmp r14b, ' '
	jnz shiftit

	mov [out1], r14b
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [out1]
	syscall
	jmp skipwhitespace

shiftit:

	sub r14, [dshiftdegree]

	cmp r14, 'a'
	jge abovea

	add r14, 26

abovea:
	mov [out1], r14

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [out1]
	syscall

skipwhitespace:
	add r15, 1
	jmp shiftloop
shiftloopend:


	jmp skipo



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

skipo:

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