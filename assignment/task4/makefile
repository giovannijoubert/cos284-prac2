make: go

bit.o:  bit.asm
		yasm -f elf64 -g dwarf2 -l bit.lst bit.asm

go:   bit.o
		ld -o bit bit.o

run: 
		./bit <input> output