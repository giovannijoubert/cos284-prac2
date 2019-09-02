make: go

complexCaesar.o:  complexCaesar.asm
		yasm -f elf64 -g dwarf2 -l complexCaesar.lst complexCaesar.asm

go:   complexCaesar.o
		ld -o complexCaesar complexCaesar.o

run: 
		./complexCaesar