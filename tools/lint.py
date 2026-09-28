#!/usr/bin/env python3
"""Prüft die Assembler-Quellen auf Stil und Speicher.

- Einrückung nur mit Tabs, keine Leerzeichen am Zeilenende, Newline am Ende
- Befehle eingerückt, nie in Spalte 0
- jedes Label und jede Konstante wird irgendwo benutzt
- Variablen im Zustandsbereich $0400–$07FF überlappen sich nicht
- src/charset.asm passt zu tools/charset.py
"""

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / 'src'
GENERATED = SRC / 'charset.asm'

MNEMONICS = set('''
adc and asl bcc bcs beq bit bmi bne bpl brk bvc bvs clc cld cli clv cmp cpx cpy
dec dex dey eor inc inx iny jmp jsr lda ldx ldy lsr nop ora pha php pla plp rol
ror rti rts sbc sec sed sei sta stx sty tax tay tsx txa txs tya
'''.split())

IDENT = re.compile(r'[A-Za-z_][A-Za-z0-9_]*')
DEFINE = re.compile(r'^([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)$')
LABEL = re.compile(r'^([A-Za-z_][A-Za-z0-9_]*)(\s|$)')
SIZE = re.compile(r'(\d+) (?:Bytes|Ziffern)')

errors = []


def error(path, num, text):
    errors.append(f'{path.relative_to(ROOT)}:{num}: {text}')


def code_part(line):
    """Zeile ohne Kommentar und ohne Zeichenketten."""
    line = re.sub(r'"[^"]*"', '""', line)
    return line.split(';', 1)[0]


def check_style(path, lines, text):
    if text and not text.endswith('\n'):
        error(path, len(lines), 'Datei endet ohne Zeilenumbruch')
    for num, line in enumerate(lines, 1):
        if line != line.rstrip():
            error(path, num, 'Leerzeichen am Zeilenende')
        if line.startswith(' '):
            error(path, num, 'Einrückung mit Leerzeichen statt Tab')
        first = code_part(line).split()
        if first and not line[0].isspace() and first[0].lower() in MNEMONICS:
            error(path, num, f'Befehl "{first[0]}" steht in Spalte 0')


def collect(files):
    """Definitionen (Name -> Datei, Zeile, Wert, Kommentar) und alle Verwendungen."""
    defined = {}
    used = set()
    for path, lines in files:
        for num, line in enumerate(lines, 1):
            code = code_part(line)
            comment = line.split(';', 1)[1] if ';' in line else ''
            names = IDENT.findall(re.sub(r'\$[0-9A-Fa-f]+|%[01]+', '', code))
            match = DEFINE.match(code.strip()) if not line[:1].isspace() else None
            if match:
                defined[match.group(1)] = (path, num, match.group(2).strip(), comment)
                used.update(IDENT.findall(re.sub(r'\$[0-9A-Fa-f]+', '', match.group(2))))
                continue
            label = LABEL.match(code) if code[:1] not in ' \t!*+}' else None
            if label:
                defined[label.group(1)] = (path, num, None, comment)
                names = names[1:]
            used.update(names)
    return defined, used


def check_unused(defined, used):
    for name, (path, num, _, _) in sorted(defined.items(), key=lambda d: (str(d[1][0]), d[1][1])):
        if name not in used:
            error(path, num, f'"{name}" wird nirgends benutzt')


def check_state_memory(defined):
    cells = {}
    for name, (path, num, value, comment) in defined.items():
        if not value or not re.fullmatch(r'\$[0-9A-Fa-f]{4}', value):
            continue
        addr = int(value[1:], 16)
        if not 0x0400 <= addr <= 0x07ff:
            continue
        size = SIZE.search(comment)
        size = int(size.group(1)) if size else 1
        if name == 'board':
            size = 24
        for a in range(addr, addr + size):
            if a in cells:
                error(path, num, f'"{name}" überlappt "{cells[a]}" bei ${a:04x}')
            cells[a] = name


def check_charset():
    out = subprocess.run([sys.executable, str(ROOT / 'tools' / 'charset.py')],
                         capture_output=True, text=True, check=True).stdout
    if out != GENERATED.read_text():
        error(GENERATED, 1, 'veraltet, bitte "make src/charset.asm" ausführen')


def main():
    files = []
    for path in sorted(SRC.glob('*.asm')):
        text = path.read_text()
        lines = text.splitlines()
        check_style(path, lines, text)
        if path != GENERATED:
            files.append((path, lines))
    defined, used = collect(files)
    check_unused(defined, used)
    check_state_memory(defined)
    check_charset()
    for line in errors:
        print(line)
    if errors:
        print(f'{len(errors)} Befund(e)')
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
