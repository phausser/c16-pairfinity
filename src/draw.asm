; Zeichnet eine 3×3-Karte. A = erstes Zeichen, X = Farbbyte.
; draw_col und draw_row bestimmen den Platz.

draw_board
	lda #0
	sta draw_row
draw_rows
	lda #0
	sta draw_col
draw_cols
	jsr draw_cell
	inc draw_col
	lda draw_col
	cmp #4
	bne draw_cols
	inc draw_row
	lda draw_row
	cmp #6
	bne draw_rows
	rts

draw_cursor_cell
	lda cursor_col
	sta draw_col
	lda cursor_row
	sta draw_row
	; weiter in draw_cell

; Zeichnet den Platz draw_col/draw_row: leer, verdeckt oder offen.
; Eine verdeckte Karte unter dem Cursor ist weiss. Eine offene bleibt farbig.
draw_cell
	lda draw_row
	asl
	asl
	ora draw_col
	tax
	lda board,x
	bne cell_card
	jmp clear_slot
cell_card
	cpx open1
	beq cell_open
	cpx open2
	beq cell_open
	lda #back_color
	sta cell_color
	lda #back_char
	bne cell_cursor
cell_open
	tay
	lda fruit_color-1,y
	sta cell_color
	lda fruit_char-1,y
	ldx cell_color
	jmp draw_card
cell_cursor
	pha
	lda draw_col
	cmp cursor_col
	bne cell_draw
	lda draw_row
	cmp cursor_row
	bne cell_draw
	lda #cursor_color
	sta cell_color
cell_draw
	pla
	ldx cell_color
	jmp draw_card

draw_card
	pha
	lda draw_col
	jsr col_x
	lda draw_row
	jsr row_y
	sta sy
	pla
	; weiter in draw_at

; Zeichnet eine Karte bei Bildschirmspalte sx und Zeile sy (mit Vorzeichen).
; A = erstes Zeichen, X = Farbbyte. Zeilen über Zeile 1 bleiben weg.
draw_at
	sta char_base
	stx color_byte
	lda #0
	sta idx
	lda sy
	sta cur_y
	lda #3
	sta rows_left
at_row
	lda cur_y
	bmi at_skip
	beq at_skip		; Zeile 0 gehört der Kopfzeile
	jsr line_ptr
	ldy #0
at_col
	lda char_base
	clc
	adc idx
	sta (scr),y
	lda color_byte
	sta (colr),y
	inc idx
	iny
	cpy #3
	bne at_col
	beq at_next
at_skip
	lda idx
	clc
	adc #3
	sta idx
at_next
	inc cur_y
	dec rows_left
	bne at_row
	rts

; Füllt den Platz draw_col/draw_row mit Hintergrund.
clear_slot
	lda draw_col
	jsr col_x
	lda draw_row
	jsr row_y
	pha
	clc
	adc #2
	sta clear_end
	pla
	; weiter in clear_rows

; Füllt drei Zeichen breit ab Spalte sx die Zeilen A bis clear_end mit Hintergrund.
clear_rows
	sta cur_y
clear_row
	lda cur_y
	jsr line_ptr
	ldy #2
clear_cell
	tya
	clc
	adc sx
	jsr bg_cell
	dey
	bpl clear_cell
	lda cur_y
	cmp clear_end
	inc cur_y
	bcc clear_row
	rts

; A = Spalte 0–3, setzt sx auf die Bildschirmspalte.
col_x
	asl
	asl
	clc
	adc #12
	sta sx
	rts

; A = Reihe 0–5, liefert in A die oberste Bildschirmzeile des Platzes.
row_y
	eor #$ff
	clc
	adc #6			; 5 - Reihe
	asl
	asl
	adc #1
	rts

; A = Bildschirmzeile. scr und colr zeigen auf Spalte sx dieser Zeile.
; X wird dabei überschrieben.
line_ptr
	tax
	lda line_lo,x
	clc
	adc sx
	sta scr
	sta colr
	lda line_hi,x
	adc #0
	sta scr+1
	sec
	sbc #$04		; Farb-RAM liegt $0400 unter dem Bildschirm
	sta colr+1
	rts

; Ganzer Schirm mit diagonalen Streifen.
clear_screen
	lda #0
	sta sx
	sta cur_y
screen_row
	lda cur_y
	jsr line_ptr
	ldy #39
screen_cell
	tya
	jsr bg_cell
	dey
	bpl screen_cell
	inc cur_y
	lda cur_y
	cmp #25
	bne screen_row
	rts

; Schreibt Hintergrund nach (scr),y. Das Muster kachelt nahtlos.
bg_cell
	lda #bg_char
	sta (scr),y
	lda bg_color
	sta (colr),y
	rts

; Vier Pixel breite Streifen von links oben nach rechts unten.
; Jeder Schritt verschiebt das Muster einen Pixel nach rechts und oben.
; Das Muster wiederholt sich nach vier Schritten, bg_step läuft 0–3.
; Die Farbe wechselt unabhängig davon alle bg_hue_speed Frames.
bg_tick
	dec bg_timer
	bne bg_scroll_done
	lda #bg_speed
	sta bg_timer
	lda bg_step
	clc
	adc #1
	and #3
	sta bg_step
	jsr bg_glyph
bg_scroll_done
	dec bg_hue_timer
	bne bg_done
	lda #bg_hue_speed
	sta bg_hue_timer
	lda bg_phase
	clc
	adc #1
	cmp #bg_palette_end - bg_palette
	bne bg_store
	lda #0
bg_store
	sta bg_phase
	tax
	lda bg_palette,x
	sta bg_color
	jsr bg_recolor
bg_done
	rts

bg_glyph
	lda bg_step
	asl			; rechts und oben verschieben die Diagonale je um 1 Pixel
	sta bg_row_byte
	ldy #0
bg_row
	tya
	clc
	adc bg_row_byte
	and #7
	tax
	lda bg_mask,x
	sta charset + bg_char * 8,y
	iny
	cpy #8
	bne bg_row
	rts

; Färbt die Hintergrundfelder neu. Karten, Schrift und Rahmen bleiben.
bg_recolor
	lda sx
	pha
	lda cur_y
	pha
	lda #0
	sta sx
	sta cur_y
bg_recolor_row
	lda cur_y
	jsr line_ptr
	ldy #39
bg_recolor_cell
	lda (scr),y
	and #$7f
	cmp #bg_char
	bne bg_recolor_next
	lda bg_color
	sta (colr),y
bg_recolor_next
	dey
	bpl bg_recolor_cell
	inc cur_y
	lda cur_y
	cmp #25
	bne bg_recolor_row
	pla
	sta cur_y
	pla
	sta sx
	rts

; Blau, Lila, Rot, Orange, Gelb, Grün, alle Helligkeit 1 (niedrigste).
bg_palette
	!byte $16, $14, $12, $18, $17, $15
bg_palette_end

; Streifen-Font: 8 Zeilen, je ein Byte. 1 = Farbe, 0 = Schwarz.
; Die erste Zeile ist oben, das linke Bit ist der linke Pixel.
bg_mask
	!byte %11110111
	!byte %11111011
	!byte %11111101
	!byte %11111110
	!byte %01111111
	!byte %10111111
	!byte %11011111
	!byte %11101111

line_lo
	!for i, 0, 24 { !byte <(screen + i * 40) }
line_hi
	!for i, 0, 24 { !byte >(screen + i * 40) }

; Oben rechts: PAARE und die Punktzahl, ein Feld Abstand zu beiden Rändern.
hud_row    = 1
hud_col    = 30
hud        = hud_row * 40 + hud_col
msg_top    = 11		; (25 - 3) / 2, Bildschirmmitte
msg_row    = 12
blink_frames = 16		; Frames je Blinkphase

draw_hud
	ldx #4
hud_word
	lda word_paare,x
	sta screen + hud,x
	lda #hud_color
	sta color + hud,x
	dex
	bpl hud_word
	; weiter in draw_score

draw_score
	ldx #2
score_digit
	lda score,x
	clc
	adc #ch_0
	sta screen + hud + 6,x
	lda #hud_color
	sta color + hud + 6,x
	dex
	bpl score_digit
	rts

; Ein Paar mehr, dezimal mit drei Ziffern.
add_pair
	ldx #2
add_digit
	inc score,x
	lda score,x
	cmp #10
	bcc add_done
	lda #0
	sta score,x
	dex
	bpl add_digit
add_done
	jmp draw_score

; Zentriert den Text aus words in der Bildschirmmitte. A = Offset.
; Weisses Feld mit einem Zeichen Rand und schwarzer Schrift. Das Blinken
; übernimmt wait_fire in Software: Bit 7 im Farbbyte würde auch das Feld
; schwarz blinken lassen, weil der TED die gesetzten Pixel ausblendet.
show_label
	sta label_ofs
	tax
	lda words,x
	sta label_len
	clc
	adc #2
	sta box_w
	lda #40
	sec
	sbc box_w
	lsr
	sta box_x
	lda #msg_top
	sta cur_y
	lda #3
	sta rows_left
frame_row
	lda box_x
	sta sx
	lda cur_y
	jsr line_ptr
	ldy box_w
	dey
frame_col
	lda #$80		; invertiertes Leerzeichen: vollstaendig weisses Feld
	sta (scr),y
	lda #hud_color
	sta (colr),y
	dey
	bpl frame_col
	inc cur_y
	dec rows_left
	bne frame_row
	lda #$ff
	sta label_mask
	lda #blink_frames
	sta blink_timer
	; weiter in label_text

; Schreibt den Text ins Feld, mit label_mask 0 nur invertierte Leerzeichen.
label_text
	lda box_x
	clc
	adc #1
	sta sx
	lda #msg_row
	jsr line_ptr
	ldx label_ofs		; X überlebt line_ptr nicht
	inx			; erstes Zeichen
	ldy #0
label_char
	lda words,x
	and label_mask
	ora #$80		; invertierte Glyphe: schwarze Schrift auf Weiss
	sta (scr),y
	inx
	iny
	cpy label_len
	bne label_char
	rts

; Nimmt den Starttext weg. Brett und Punktzahl liegen danach wieder frei.
hide_label
	jsr clear_screen
	jsr draw_board
	jmp draw_hud

word_paare
	!byte ch_p, ch_a, ch_a, ch_r, ch_e

; Je Text: Länge, Zeichen.
words
word_start = * - words
	!byte 5, ch_s, ch_t, ch_a, ch_r, ch_t
word_game_over = * - words
	!byte 9, ch_g, ch_a, ch_m, ch_e, 0, ch_o, ch_v, ch_e, ch_r

; Erstes Zeichen und Flächenfarbe der Motive 1–8.
fruit_char
	!byte $0a, $13, $1c, $25, $2e, $37, $40, $49
fruit_color
; Banane, Apfel, Birne, Kirsche, Trauben, Orange, Pflaume, Himbeere.
	!byte $67, $52, $55, $3b, $4e, $58, $3e, $5b

!ifdef PREVIEW {
; Alle Plätze offen, Motive 1–8 der Reihe nach.
draw_preview
	lda #0
	sta motif
	sta draw_row
preview_rows
	lda #0
	sta draw_col
preview_cols
	ldx motif
	lda fruit_color,x
	pha
	lda fruit_char,x
	tay
	pla
	tax
	tya
	jsr draw_card
	lda motif
	clc
	adc #1
	and #7
	sta motif
	inc draw_col
	lda draw_col
	cmp #4
	bne preview_cols
	inc draw_row
	lda draw_row
	cmp #6
	bne preview_rows
	rts
}
