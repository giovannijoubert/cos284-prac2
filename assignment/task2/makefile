make: go

decoder.o:  decoder.asm
		yasm -f elf64 -g dwarf2 -l decoder.lst decoder.asm

go:   decoder.o
		ld -o decoder decoder.o

run: 
		./decoder