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
; Steht der Cursor darauf, blinkt die Fläche.
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
	ora #cursor_bit
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

; Leert den Platz draw_col/draw_row.
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

; Leert drei Zeichen breit ab Spalte sx die Zeilen A bis clear_end.
clear_rows
	sta cur_y
clear_row
	lda cur_y
	jsr line_ptr
	ldy #2
	lda #0
clear_cell
	sta (scr),y
	sta (colr),y
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

line_lo
	!for i, 0, 24 { !byte <(screen + i * 40) }
line_hi
	!for i, 0, 24 { !byte >(screen + i * 40) }

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
