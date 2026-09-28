.PHONY: all run preview lint

all: memory.prg

ACME = acme -f cbm --cpu 6502 --strict --strict-segments -Wtype-mismatch
SRC = src/main.asm src/charset.asm src/board.asm src/draw.asm src/input.asm src/anim.asm src/sound.asm

memory.prg: $(SRC)
	$(ACME) -o memory.prg src/main.asm

preview.prg: $(SRC)
	$(ACME) -DPREVIEW=1 -o preview.prg src/main.asm

src/charset.asm: tools/charset.py
	python3 tools/charset.py > src/charset.asm

run: memory.prg
	xplus4 -model c16 +sound -autostart memory.prg

preview: preview.prg
	xplus4 -model c16 +sound -autostart preview.prg

lint: memory.prg preview.prg
	python3 -m py_compile tools/charset.py tools/lint.py
	python3 tools/lint.py
