.PHONY: all run

all: memory.prg

memory.prg: src/main.asm src/charset.asm src/board.asm src/draw.asm src/input.asm
	acme -f cbm --cpu 6502 -o memory.prg src/main.asm

run: memory.prg
	xplus4 -model c16 +sound -autostart memory.prg
