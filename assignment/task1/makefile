make: go

mul.o:  mul.asm
		yasm -f elf64 -g dwarf2 -l mul.lst mul.asm

go:   mul.o
		ld -o mul mul.o

run: 
		./mul <input> output