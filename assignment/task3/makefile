make: go

sub.o:  sub.asm
		yasm -f elf64 -g dwarf2 -l sub.lst sub.asm

go:   sub.o
		ld -o sub sub.o

run: 
		./sub 