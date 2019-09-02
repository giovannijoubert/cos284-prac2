	segment .data
      init:	db "Please enter a string: ",0x0a
      msg: 	db "The length of the string is: ",0x0a
      endl: db "",0x0a
      count: db 0
      resu: db ""
      asd: db ""
      result1: db ""
	segment .bss
    res1: resb 1
    res2: resb 1
	inpt: resb 8
	segment .text
	global _start
_start:
	mov eax,1
	mov edi,1
	mov edx, 23
	lea rsi,[init]
	syscall

	mov eax,0
	mov edi,0
	mov edx, 200
	lea rsi,[inpt]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 29
	lea rsi,[msg]
	syscall

    xor rbx,rbx
    mov rbx, 0

    xor rax, rax
    mov rax, [inpt]

   
    mov rbx, 0             ; cl is the counter register, set it to
                      ; zero (the first character in the string)

lop:                ; Beginning of loop
          ; Read the next byte from memory
    mov al, [inpt + rbx] 
  cmp al, 0           ; Compare the byte to null (the terminator)
  je endlop              ; If the byte is null, jump out of the loop

  ;sub al, 20h         ; Convert to upper case
                      ; A better solution would be: and al, 0DFh

  ; Output the character in al
  inc rbx          ; Move to the next byte in the string
  jmp lop           ; Loop
endlop:
    
    dec rbx

    mov rax, 0
    mov rax, rbx

    mov rbx, 0
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
    mov [res1], r9
	mov [res2], r10

    sub r9, '0'
    cmp r9, 0
    jz skip
    mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[res1]
	syscall

skip:
    mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[res2]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [endl]
	syscall


	mov eax,60
	xor edi, edi
	syscall