make: go

basicCaesar.o:  basicCaesar.asm
		yasm -f elf64 -g dwarf2 -l basicCaesar.lst basicCaesar.asm

go:   basicCaesar.o
		ld -o basicCaesar basicCaesar.o

run: 
		./basicCaesar <input> output