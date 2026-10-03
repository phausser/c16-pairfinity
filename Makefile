.PHONY: all run preview lint

all: pairfinity.prg

# Release 0.97 (Homebrew, Juni 2020) kennt --strict nicht. Trunk-Builds
# wie svn r446 in der CI schon; dort werden Warnungen zu Fehlern.
ACME_FLAGS = -f cbm --cpu 6502 --strict-segments -Wtype-mismatch
ifneq ($(shell acme --help 2>&1 | grep -c -e '--strict '),0)
ACME_FLAGS += --strict
endif
ACME = acme $(ACME_FLAGS)
SRC = src/main.asm src/charset.asm src/board.asm src/draw.asm src/input.asm src/anim.asm src/sound.asm

pairfinity.prg: $(SRC)
	$(ACME) -o pairfinity.prg src/main.asm

preview.prg: $(SRC)
	$(ACME) -DPREVIEW=1 -o preview.prg src/main.asm

src/charset.asm: tools/charset.py
	python3 tools/charset.py > src/charset.asm

run: pairfinity.prg
	xplus4 -model c16 -sound -autostart pairfinity.prg

preview: preview.prg
	xplus4 -model c16 -sound -autostart preview.prg

lint: pairfinity.prg preview.prg
	python3 -m py_compile tools/charset.py tools/lint.py
	python3 tools/lint.py
