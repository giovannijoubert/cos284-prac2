make: go

task3.o:  task3.asm
		yasm -f elf64 -g dwarf2 -l task3.lst task3.asm

go:   task3.o
		ld -o task3 task3.o

run: 
		./task3