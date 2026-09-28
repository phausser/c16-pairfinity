.PHONY: all run preview

all: memory.prg

SRC = src/main.asm src/charset.asm src/board.asm src/draw.asm src/input.asm

memory.prg: $(SRC)
	acme -f cbm --cpu 6502 -o memory.prg src/main.asm

preview.prg: $(SRC)
	acme -f cbm --cpu 6502 -DPREVIEW=1 -o preview.prg src/main.asm

src/charset.asm: tools/charset.py
	python3 tools/charset.py > src/charset.asm

run: memory.prg
	xplus4 -model c16 +sound -autostart memory.prg

preview: preview.prg
	xplus4 -model c16 +sound -autostart preview.prg
