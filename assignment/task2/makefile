make: go

div.o:  div.asm
		yasm -f elf64 -g dwarf2 -l div.lst div.asm

go:   div.o
		ld -o div div.o

run: 
		./div <input> output