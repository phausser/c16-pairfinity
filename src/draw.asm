; Zeichnet eine 3×3-Karte. A = erstes Zeichen, X = Farbbyte.
; draw_col und draw_row bestimmen den Platz.

draw_board
	lda #0
	sta draw_row
draw_rows
	lda #0
	sta draw_col
draw_cols
	lda #back_char
	ldx #back_color
	jsr draw_card
	inc draw_col
	lda draw_col
	cmp #4
	bne draw_cols
	inc draw_row
	lda draw_row
	cmp #6
	bne draw_rows
	rts

show_cursor
	lda cursor_col
	sta draw_col
	lda cursor_row
	sta draw_row
	lda #back_color
	ora #cursor_bit
	tax
	lda #back_char
	jmp draw_card

hide_cursor
	lda cursor_col
	sta draw_col
	lda cursor_row
	sta draw_row
	lda #back_char
	ldx #back_color
	jmp draw_card

draw_card
	sta char_base
	stx color_byte
	jsr card_ptr
	lda #0
	sta idx
	lda #3
	sta rows_left
card_row
	ldy #0
card_col
	lda char_base
	clc
	adc idx
	sta (scr),y
	lda color_byte
	sta (colr),y
	inc idx
	iny
	cpy #3
	bne card_col
	lda scr
	clc
	adc #40
	sta scr
	bcc card_scr_ok
	inc scr+1
card_scr_ok
	lda colr
	clc
	adc #40
	sta colr
	bcc card_colr_ok
	inc colr+1
card_colr_ok
	dec rows_left
	bne card_row
	rts

; scr und colr zeigen auf die linke obere Zelle der Karte.
card_ptr
	lda #5
	sec
	sbc draw_row
	asl
	asl
	clc
	adc #1
	sta sy
	lda draw_col
	asl
	asl
	clc
	adc #12
	sta sx
	lda #0
	sta scr
	sta scr+1
	ldx sy
	beq ptr_x
ptr_add
	lda scr
	clc
	adc #40
	sta scr
	bcc ptr_next
	inc scr+1
ptr_next
	dex
	bne ptr_add
ptr_x
	lda scr
	clc
	adc sx
	sta scr
	bcc ptr_ok
	inc scr+1
ptr_ok
	lda scr
	clc
	adc #<screen
	pha
	lda scr+1
	adc #>screen
	sta scr+1
	pla
	sta scr
	lda scr
	sta colr
	lda scr+1
	sec
	sbc #$04		; Farb-RAM liegt $0400 unter dem Bildschirm
	sta colr+1
	rts
