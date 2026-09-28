; Brett: 24 Bytes, Index = col + row*4, 0 = leer. row 0 liegt unten.

init_board
	ldx #23
	lda #1
fill_board
	sta board,x
	dex
	bpl fill_board
	lda #0
	sta cursor_col
	sta cursor_row
	sta prev_dirs
	rts

; Richtung in A: 0 hoch, 1 runter, 2 links, 3 rechts.
; Hoch erhöht die logische Reihe, weil Reihe 0 unten liegt.
move_cursor
	sta dir
	lda cursor_col
	sta try_col
	lda cursor_row
	sta try_row
step_cursor
	lda dir
	beq step_up
	cmp #1
	beq step_down
	cmp #2
	beq step_left
	lda try_col
	cmp #3
	bcs move_stay
	inc try_col
	jmp test_cell
step_up
	lda try_row
	cmp #5
	bcs move_stay
	inc try_row
	jmp test_cell
step_down
	lda try_row
	beq move_stay
	dec try_row
	jmp test_cell
step_left
	lda try_col
	beq move_stay
	dec try_col
test_cell
	lda try_row
	asl
	asl
	clc
	adc try_col
	tay
	lda board,y
	beq step_cursor
	jsr hide_cursor
	lda try_col
	sta cursor_col
	lda try_row
	sta cursor_row
	jmp show_cursor
move_stay
	rts
