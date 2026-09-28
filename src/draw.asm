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
; Steht der Cursor darauf, ist die Fläche eine Stufe heller.
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
cell_cursor
	pha
	lda draw_col
	cmp cursor_col
	bne cell_draw
	lda draw_row
	cmp cursor_row
	bne cell_draw
	lda cell_color
	clc
	adc #cursor_lum
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

; Ganzer Schirm mit dem Schachbrett.
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

; Schreibt Hintergrund nach (scr),y. A = Bildschirmspalte, cur_y die Zeile.
; Auf Feldern mit ungerader Summe steht das invertierte Zeichen.
bg_cell
	eor cur_y
	and #1
	beq bg_cell_even
	lda #bg_char | $80
	bne bg_cell_put
bg_cell_even
	lda #bg_char
bg_cell_put
	sta (scr),y
	lda #bg_color
	sta (colr),y
	rts

; Schachbrett aus 8×8-Feldern, das jeden Pixel-Schritt nach rechts oben wandert.
; Das Muster wiederholt sich nach 16 Pixeln, bg_step läuft 0–15.
bg_tick
	dec bg_timer
	bne bg_done
	lda #bg_speed
	sta bg_timer
	lda bg_step
	clc
	adc #1
	and #15
	sta bg_step
bg_glyph
	ldx bg_step
	lda bg_mask,x
	sta bg_row_byte
	ldy #0
bg_row
	tya
	clc
	adc bg_step
	and #8			; untere Hälfte des Musters: Zeile invertiert
	beq bg_plain
	lda #$ff
bg_plain
	eor bg_row_byte
	sta charset + bg_char * 8,y
	iny
	cpy #8
	bne bg_row
bg_done
	rts

; Obere Musterzeile, um bg_step Pixel nach rechts geschoben.
bg_mask
	!byte $00, $80, $c0, $e0, $f0, $f8, $fc, $fe
	!byte $ff, $7f, $3f, $1f, $0f, $07, $03, $01

line_lo
	!for i, 0, 24 { !byte <(screen + i * 40) }
line_hi
	!for i, 0, 24 { !byte >(screen + i * 40) }

; Oben rechts: PAARE und die Punktzahl, ein Feld Abstand zu beiden Rändern.
hud_row    = 1
hud_col    = 30
hud        = hud_row * 40 + hud_col

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

; Schriftzug oben links, auf der Höhe der Punktzahl. A = Offset in words.
show_label
	tax
	ldy words,x		; Spalte
	lda words+1,x		; Länge
	sta label_len
label_char
	lda words+2,x
	sta screen + hud_row * 40,y
	lda #hud_color
	sta color + hud_row * 40,y
	inx
	iny
	dec label_len
	bne label_char
	rts

; Die Stelle des Schriftzugs wieder Hintergrund.
hide_label
	lda #0
	sta sx
	lda #hud_row
	sta cur_y
	jsr line_ptr
	ldy #9
hide_cell
	tya
	jsr bg_cell
	dey
	bne hide_cell
	rts

word_paare
	!byte ch_p, ch_a, ch_a, ch_r, ch_e

; Je Wort: Spalte, Länge, Zeichen. Höchstens 9 Zeichen ab Spalte 1.
words
word_start = * - words
	!byte 1, 5, ch_s, ch_t, ch_a, ch_r, ch_t
word_game_over = * - words
	!byte 1, 9, ch_g, ch_a, ch_m, ch_e, 0, ch_o, ch_v, ch_e, ch_r

; Erstes Zeichen und Flächenfarbe der Motive 1–8.
fruit_char
	!byte $0a, $13, $1c, $25, $2e, $37, $40, $49
fruit_color
	!byte $52, $58, $55, $69, $4e, $3b, $67, $5b

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
