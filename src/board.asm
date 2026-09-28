; Brett: 24 Bytes, Index = col + row*4, 0 = leer. row 0 liegt unten.

; Start: 12 Karten, jede Spalte drei hoch. Jede Frucht einmal, dazu vier
; zufällige Kopien, alles gemischt.
init_board
	ldx #23
	lda #0
board_clear
	sta board,x
	dex
	bpl board_clear
	ldx #7
board_eight
	txa
	clc
	adc #1
	sta board,x
	dex
	bpl board_eight
	ldx #8
board_extra
	stx shuf_i
	jsr random
	and #7
	clc
	adc #1
	ldx shuf_i
	sta board,x
	inx
	cpx #12
	bne board_extra
	ldx #11
shuffle
	stx shuf_i
	inx
	stx count
	jsr random
	jsr mod_count
	tay
	ldx shuf_i
	lda board,x
	pha
	lda board,y
	sta board,x
	pla
	sta board,y
	dex
	bne shuffle
	lda #$ff
	sta open1
	sta open2
	lda #0
	sta phase
	sta prev_dirs
	sta game_over
	sta score
	sta score+1
	sta score+2
	jmp cursor_home

; Cursor auf die erste liegende Karte: Spalten von links, darin von unten.
; Ist das Feld leer, steht in cursor_col $ff.
cursor_home
	lda #0
	sta try_col
home_col
	lda #0
	sta try_row
home_row
	lda try_row
	asl
	asl
	ora try_col
	tax
	lda board,x
	bne home_found
	inc try_row
	lda try_row
	cmp #6
	bne home_row
	inc try_col
	lda try_col
	cmp #4
	bne home_col
	lda #$ff
	sta cursor_col
	rts
home_found
	lda try_col
	sta cursor_col
	lda try_row
	sta cursor_row
	rts

; 16-Bit-LFSR, liefert in A ein frisches Byte.
random
	ldy #8
random_bit
	lsr rnd+1
	ror rnd
	bcc random_next
	lda rnd+1
	eor #$b4
	sta rnd+1
random_next
	dey
	bne random_bit
	lda rnd
	rts

; Startwert aus der Rasterposition. 0 wird zu 1.
seed_random
	lda $ff1e
	sta rnd
	ldx #0
seed_wait
	dex
	bne seed_wait
	lda $ff1d
	eor $ff1e
	sta rnd+1
	ora rnd
	bne seed_done
	inc rnd
seed_done
	rts

; Richtung in A: 0 hoch, 1 runter, 2 links, 3 rechts.
; Hoch erhöht die logische Reihe, weil Reihe 0 unten liegt.
move_cursor
	sta dir
	ldx cursor_col
	bmi move_stay		; kein Cursor, Feld leer
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
	lda cursor_col
	sta draw_col
	lda cursor_row
	sta draw_row
	lda try_col
	sta cursor_col
	lda try_row
	sta cursor_row
	jsr draw_cell		; alter Platz ohne Cursor
	jmp draw_cursor_cell
move_stay
	rts

; Feuer auf dem Cursor. Erste Karte aufdecken, oder die zweite und den Zug auflösen.
pick
	lda cursor_col
	bpl pick_cursor
	rts			; kein Cursor
pick_cursor
	lda cursor_row
	asl
	asl
	ora cursor_col
	tax
	lda board,x
	beq pick_done		; leerer Platz
	cpx open1
	beq pick_done		; dieselbe Karte
	lda phase
	bne pick_second
	stx open1
	inc phase
	jmp draw_cursor_cell
pick_second
	stx open2
	jsr draw_cursor_cell
	ldx #30
	jsr wait_frames
	ldx open1
	ldy open2
	lda #0
	sta was_pair
	lda board,x
	cmp board,y
	bne pick_close
	inc was_pair
	lda #0			; Paar: beide Plätze leeren
	sta board,x
	sta board,y
	jsr add_pair
pick_close
	lda #0
	sta phase
	lda open1
	ldx #$ff
	stx open1
	jsr draw_index
	lda open2
	ldx #$ff
	stx open2
	jsr draw_index
	lda was_pair
	beq pick_miss
	lda #snd_pair
	jsr play
	jsr shake
	jmp settle_board
pick_miss
	lda #snd_miss
	jsr play
	jmp settle_board
pick_done
	rts

; Zeichnet den Platz mit dem Index in A neu.
draw_index
	pha
	and #3
	sta draw_col
	pla
	lsr
	lsr
	sta draw_row
	jmp draw_cell

; Wartet X Bildschirme. Hintergrundmuster und Ton laufen dabei weiter.
wait_frames
	lda $ff1d
	cmp #204
	beq wait_frames
wait_line
	lda $ff1d
	cmp #204
	bne wait_line
	txa
	pha
	jsr bg_tick
	jsr sound_tick
	pla
	tax
	dex
	bne wait_frames
	rts
