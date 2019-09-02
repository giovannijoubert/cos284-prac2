	segment .data
      init:	db "Please input a string: ",0x0a
      msg: 	db "The new string is: ",0x0a
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
	mov edx, 19
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

	cmp al, ' '
	jnz whitechecked

	mov r15, ' ' 
	mov [res1], r15
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[res1]
	syscall
	inc rbx  
	jmp lop

whitechecked:
	mov dl, al
	sub dl, 'A'
	cmp dl, 'Z'-'A'
	jbe big

  	sub al, 20h         ; Convert to upper case

	jmp conv
                      ; A better solution would be: and al, 0DFh
big: 
	add al, 20h 

conv:
	inc rbx   
	mov cl, [inpt + rbx] 
	cmp cl, 0   
	je endlop 

	mov [res1], al
	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi,[res1]
	syscall

  ; Output the character in al
       ; Move to the next byte in the string
  jmp lop           ; Loop

endlop:
	
	mov [res2], al
    
    

	mov eax,1
	mov edi,1
	mov edx, 1
	lea rsi, [endl]
	syscall


	mov eax,60
	xor edi, edi
	syscall