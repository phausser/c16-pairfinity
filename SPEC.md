# Endlos-Memory — Spezifikation

Memory für den Commodore 16. Assembler ist ACME, die Entwicklung läuft im VICE (`xplus4 -model c16`). Dasselbe PRG läuft auf dem Plus/4, weil es im 16-KB-RAM des unausgebauten C16 bleibt.

Der TED hat keine Sprites. Karten sind ein eigener Zeichensatz, die Farbe steht im Farb-RAM, und eine fallende Karte rückt zeichenweise.

## Regeln

Das Raster hat 4 Spalten und 6 Reihen, 24 Plätze. Eine Karte ist 3×3 Zeichen (24×24 Pixel). Es gibt 8 Fruchtmotive. Die Farbe gehört zum Motiv: gleiche Früchte haben dieselbe Flächenfarbe.

Ein Zug deckt genau zwei Karten auf. Dieselbe Karte ein zweites Mal zu wählen geht nicht. Leere Plätze gehen nicht.

- Gleiches Motiv: beide Karten verschwinden. In jeder betroffenen Spalte rutschen die Karten darüber nach unten, bis die Spalte wieder unten dicht liegt.
- Verschiedene Motive: beide Karten bleiben offen, bis eine Cursortaste kommt, und drehen sich dann auf den Rücken.

Danach fällt immer eine neue Karte von oberhalb des Rasters. Sie landet in einer zufälligen Spalte, die noch einen freien Platz hat, auf dem obersten belegten Platz dieser Spalte. Ihr Motiv ist das Motiv einer zufälligen Karte, die schon liegt. Liegt keine Karte mehr, ist das Motiv zufällig von 1 bis 8.

Start: 12 Karten, untenbündig, jede Spalte drei hoch. Die Auslage enthält jedes der acht Motive mindestens einmal. Vier weitere Karten kopieren vier zufällig gezogene Motive. Die zwölf Karten werden gemischt.

Punktzahl ist die Anzahl gefundener Paare.

Spielende: nach dem Auflösen des Zuges hat keine Spalte mehr einen freien Platz. Die Paar-Zahl bleibt stehen. `GAME OVER` steht in der Bildschirmmitte. Feuer gibt neu.

## Spielfeld

Textmodus 40×25. Rahmen schwarz. Hinter dem Raster liegt ein Schachbrett aus Schwarz und Dunkelblau (`$2E`, Helligkeit 2), das langsam nach rechts oben wandert. Zeichensatz mit 128 Zeichen (1 KB); die oberen 128 Zeichen erzeugt der TED durch Invertierung.

Zwischen zwei Karten liegt eine Zeichenlücke, horizontal und vertikal. Das Raster ist 15 Zeichen breit und 23 hoch und füllt den 40×25-Schirm unter der Kopfzeile: links 12 Spalten frei, rechts 13, darunter eine Zeile.

| | |
| --- | --- |
| Ursprung | Spalte 12, Zeile 1 |
| Karte `(col, row)` | `x = 12 + col*4`, `y = 1 + (5-row)*4` |

`col` läuft von 0 links nach 3 rechts. `row` 0 ist der unterste Platz der Spalte, `row` 5 der oberste. Eine Spalte der Höhe `h` belegt die Reihen `0 .. h-1`.

Anzeige in Bildschirmzeile 1, ein Feld Abstand zum oberen Rand. Rechts `PAARE` und drei Ziffern in den Spalten 30–38. Vor dem Spiel steht `START`, bei Spielende `GAME OVER`. Beide Texte stehen in der Bildschirmmitte, horizontal und vertikal, mit einem schwarzen Rand von einem Zeichen oben, links, unten und rechts, und die Schrift blinkt. Während des Spiels ist die Stelle wieder Brett und Schachbrett. Zeile 0 ist reiner Hintergrund.

Zeichen im Satz:

| Codes | Inhalt |
| --- | --- |
| `$00` | leer |
| `$01`–`$09` | Kartenrücken, 3×3, zeilenweise von links nach rechts |
| `$0A`–`$51` | Früchte 1–8, je 3×3, dieselbe Reihenfolge. Motiv `n` beginnt bei `$0A + (n-1)*9` |
| danach | Ziffern `0`–`9` ab `$52` und die Buchstaben `A E G M O P R S T V` |

Offene Karte, nach der Vorlage: die Fläche ist die Fruchtfarbe, die Frucht selbst ist eine geschlossene schwarze Silhouette. Apfel, Orange, Birne und Banane folgen dem Blatt direkt (Stiel und Blatt am Apfel und an der Orange, Stiel an der Birne, Sichel der Banane). Dazu Traube, Kirsche, Zitrone und Erdbeere, dieselbe Art Fläche und Silhouette.

Im HiRes-Textmodus malt ein gesetztes Pixel die Farbe aus dem Farb-RAM, ein gelöschtes den globalen Hintergrund. Der globale Hintergrund und der Rahmen sind schwarz. Im Fruchtzeichen sind die Pixel der Silhouette gelöscht und alle übrigen Pixel des 3×3-Feldes gesetzt. Die Silhouette liegt in der Mitte der Karte, mit mindestens zwei Pixeln Farbrand an jedem Rand. Der Kartenrücken ist für alle Motive gleich, die Streifen laufen bis an den Rand, und er trägt die Fruchtfarbe nicht.

Farbbyte: Bit 7 blinkt, Bits 6–4 sind die Helligkeit, Bits 3–0 die Farbe. Die Helligkeit der Fruchtflächen bleibt unter 7, damit sie nicht ausbleicht. Kartenrücken überall Hellgrau `$61`. Die angewählte verdeckte Karte ist Weiss `$71`. Eine offene Karte bleibt in ihrer Fruchtfarbe; die schwarze Frucht bleibt schwarz. `START` und `GAME OVER` blinken über Bit 7. Sonst blinkt nichts. Die acht Motive:

| Motiv | Fläche | Byte | Silhouette |
| --- | --- | --- | --- |
| 1 Apfel | Rot | `$52` | rund, Stiel, ein Blatt |
| 2 Orange | Orange | `$58` | Kreis, kleiner Stiel, Blatt |
| 3 Birne | Grün | `$55` | schmal oben, bauchig unten, Stiel |
| 4 Banane | Goldgelb | `$69` | Sichel |
| 5 Traube | Blauviolett | `$4E` | mehrere Kugeln, kleines Blatt |
| 6 Kirsche | Kirschrot | `$3B` | zwei Kugeln, Stiele zusammen |
| 7 Zitrone | Zitronengelb | `$67` | Oval mit Spitzen |
| 8 Erdbeere | Pink | `$5B` | breit oben, spitz unten, Blätterkrone |

HUD-Text ist Weiß, `$71`.

Eine fallende Karte rückt pro Schritt eine Zeichenzeile nach unten und wartet dort zwei Frames. Weiches Scrollen einer einzelnen Karte kann der TED nicht, der Scroll gilt für den ganzen Schirm.

## Eingabe

Joystick in Port 1 und die Pfeiltasten wirken gleich. Feuer ist der Feuerknopf, die Leertaste oder Return. Ein Schritt pro Flanke, Halten wiederholt nicht. Solange eine Karte fällt, ein Paar noch kurz offen liegt oder die Spalten packen, liegt die Eingabe still. Ein Fehlversuch wartet auf eine Cursortaste; Feuer deckt in dieser Zeit nichts auf.

Joystick 1: `$FA` nach `$FF08` schreiben und `$FF08` lesen. Bits 0 bis 3 sind hoch, runter, links, rechts. Bit 6 ist Feuer. Aktiv ist low.

Tastatur: Zeile über `$FD30` wählen (0-Bit selektiert), `$FF` nach `$FF08` schreiben, `$FF08` lesen. Die Spalte ist das Bit, gedrückt ist low. Beim Lesen des Joysticks steht `$FD30` auf `$FF`.

| Taste | Zeile | Spalte |
| --- | --- | --- |
| Hoch | 5 | 3 |
| Runter | 5 | 0 |
| Links | 6 | 0 |
| Rechts | 6 | 3 |
| Leertaste | 7 | 4 |
| Return | 0 | 1 |

Der Cursor steht auf einer liegenden Karte. Ein Schritt sucht in dieser Richtung die nächste liegende Karte und bleibt stehen, wenn es keine gibt. Wird die Zelle unter dem Cursor leer, springt er auf die erste liegende Karte, Spalten von links, in der Spalte von unten nach oben. Ist das Feld leer, erscheint der Cursor auf der Karte, die gerade gelandet ist.

## Ablauf

1. Cursor bewegen. Feuer auf einer verdeckten Karte deckt sie auf.
2. Cursor bewegen. Feuer auf einer anderen verdeckten Karte deckt die zweite auf.
3. Treffer bleiben etwa 30 Frames offen. Ungleiche bleiben offen, bis eine Cursortaste kommt. Feuer deckt in dieser Zeit nichts auf.
4. Treffer: beide Plätze leeren, dann jede Spalte animiert nach unten packen. Daneben: beide wieder verdecken.
5. Hat keine Spalte Platz, Spielende. Sonst Motiv und Spalte wählen und die Karte von über dem Raster auf ihren Platz fallen lassen.
6. Bei Spielende steht `GAME OVER` in der Bildschirmmitte. Feuer gibt neu, Punktzahl auf 0, und `START` wartet dort auf das nächste Feuer.

Packen: solange in einer Spalte über einem leeren Platz eine Karte liegt, rückt jede solche Karte um einen Platz nach unten. Dieser eine Platz wird animiert (vier Zeichenzeilen, weil die Lücke dazwischen mitzählt), danach der nächste. Beide Karten eines Paares können in derselben Spalte liegen.

## Speicher

| Bereich | Inhalt |
| --- | --- |
| `$0400`–`$07FF` | Zustand: 24 Motiv-Bytes (`0` leer, `1`–`8` Motiv), Cursor, Phase, die zwei offenen Plätze, Punktzahl, LFSR |
| `$0800` | Farb-RAM, 40×25 |
| `$0C00` | Bildschirm-RAM, 40×25 |
| `$1001` | BASIC-Stub, eine `SYS`-Zeile auf den Start. BASIC beginnt auf dem C16 hier |
| ab Stub-Ende | Programm |
| `$3000` | Zeichensatz, 1 KB. `$FF13` = `$30` |
| unter `$4000` | Obergrenze, damit der unausgebaute C16 reicht |

BASIC und Kernal bleiben eingeblendet. Die Spielschleife ruft den Kernal nicht.

Index einer Zelle: `col + row*4`, `row` 0 ist unten.

Zufall: 16-Bit-LFSR. Startwert aus der Rasterposition: `$FF1E` (Spalte) und `$FF1D` (Zeile), zweimal im Abstand einiger Zeilen gelesen. `$FF0B` ist nur das Vergleichsregister für den Raster-IRQ. Ein Startwert 0 wird zu 1.

Ton über die zwei TED-Kanäle: kurz und hoch bei einem Paar, kurz und tief bei einem Fehlversuch, ein Tick je Fallschritt.

## Build

Aus dem Repo-Root:

```
acme -f cbm -o memory.prg src/main.asm
xplus4 -model c16 -autostart memory.prg
```

`make` baut `memory.prg`. `make run` startet VICE. Quelldateien, sobald der Code beginnt: `src/main.asm`, `src/board.asm`, `src/draw.asm`, `src/input.asm`, `src/anim.asm`, `src/sound.asm`, `src/charset.asm`, dazu das `Makefile`.
