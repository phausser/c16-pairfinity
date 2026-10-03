; Nach dem Zug: Spalten packen, Cursor prüfen, eine Karte fallen lassen.

settle_board
	jsr pack
	jsr cursor_check
	jsr free_columns
	bne settle_drop
	lda #1			; kein Platz: Spielende
	sta game_over
	jmp draw_board
settle_drop
	jsr drop
	jmp draw_board

; Liefert in A und count die Zahl der Spalten mit freiem Platz.
free_columns
	lda #0
	sta count
	ldx #3
free_count
	lda board+20,x		; oberste Reihe der Spalte
	bne free_full
	inc count
free_full
	dex
	bpl free_count
	lda count
	rts

; Rückt alle Karten über der untersten Lücke einer Spalte einen Platz tiefer,
; vier Zeichenzeilen lang animiert, alle Spalten zugleich. Dann die nächste Lücke.
pack
	jsr find_gaps
	beq pack_done
	lda #1
	sta step
pack_step
	ldx #2
	jsr wait_frames
	lda #0
	sta anim_col
pack_cols
	ldx anim_col
	lda gap,x
	bmi pack_next
	jsr pack_draw_col
pack_next
	inc anim_col
	lda anim_col
	cmp #4
	bne pack_cols
	inc step
	lda step
	cmp #5
	bne pack_step
	jsr shift_down
	jmp pack
pack_done
	rts

; gap[Spalte] = unterste leere Reihe mit einer Karte darüber, sonst $ff.
; Liefert in A die Zahl der Spalten, die rutschen.
find_gaps
	lda #0
	sta count
	sta anim_col
gaps_col
	ldx anim_col
	lda #$ff
	sta gap,x
	lda #0
	sta anim_row
gaps_empty
	jsr anim_index
	lda board,x
	beq gaps_found
	inc anim_row
	lda anim_row
	cmp #6
	bne gaps_empty
	beq gaps_next		; Spalte voll
gaps_found
	lda anim_row
	sta anim_e
gaps_above
	inc anim_row
	lda anim_row
	cmp #6
	beq gaps_next
	jsr anim_index
	lda board,x
	beq gaps_above
	ldx anim_col
	lda anim_e
	sta gap,x
	inc count
gaps_next
	inc anim_col
	lda anim_col
	cmp #4
	bne gaps_col
	lda count
	rts

; Zieht in jeder rutschenden Spalte die Reihen über der Lücke eine tiefer.
shift_down
	lda #0
	sta anim_col
shift_col
	ldx anim_col
	lda gap,x
	bmi shift_next
	sta anim_row
shift_row
	jsr anim_index
	lda anim_row
	cmp #5
	beq shift_top
	lda board+4,x
	sta board,x
	inc anim_row
	jmp shift_row
shift_top
	lda #0
	sta board,x
shift_next
	inc anim_col
	lda anim_col
	cmp #4
	bne shift_col
	rts

; Zeichnet Spalte anim_col im Schritt step. A = Reihe der Lücke.
pack_draw_col
	sta anim_e
	lda anim_col
	jsr col_x
	lda anim_e
	jsr row_y
	clc
	adc #2
	sta clear_end
	lda #1
	jsr clear_rows
	lda anim_e
	sta anim_row
pack_row
	inc anim_row
	lda anim_row
	cmp #6
	beq pack_col_done
	jsr anim_index
	lda board,x
	beq pack_row
	lda anim_row
	jsr row_y
	clc
	adc step
	sta sy
	ldx #back_color
	lda anim_col
	cmp cursor_col
	bne pack_paint
	lda anim_row
	cmp cursor_row
	bne pack_paint
	ldx #cursor_color
pack_paint
	lda #back_char
	jsr draw_at
	jmp pack_row
pack_col_done
	rts

; Neue Karte: zufällige Spalte mit Platz, Motiv einer zufälligen liegenden Karte.
drop
	jsr free_columns
	bne drop_room
	rts			; kein Platz
drop_room
	jsr random
	jsr mod_count
	sta pick_k
	ldx #$ff
drop_pick
	inx
	lda board+20,x
	bne drop_pick
	dec pick_k
	bpl drop_pick
	stx anim_col
	lda #0
	sta anim_row
drop_height
	jsr anim_index
	lda board,x
	beq drop_slot
	inc anim_row
	bne drop_height
drop_slot
	stx drop_cell
	jsr pick_motif
	sta drop_motif
	lda anim_row
	jsr row_y
	sta target
	lda anim_col
	jsr col_x
	lda #snd_drop
	jsr play_loop
	lda #$ff		; eine Zeile über dem Raster
	sta sy
drop_fall
	ldx #2
	jsr wait_frames
	lda sy
	sec
	sbc #1
	bmi drop_draw
	beq drop_draw
	sta clear_end		; frei gewordene Zeile über der Karte
	jsr clear_rows
drop_draw
	lda #back_char
	ldx #back_color
	jsr draw_at
	lda sy
	cmp target
	beq drop_land
	inc sy
	jmp drop_fall
drop_land
	lda #$ff		; Klick-Loop endet nach dem laufenden Schritt
	sta snd_loop
	ldx drop_cell
	lda drop_motif
	sta board,x
	lda cursor_col
	bpl drop_done
	lda anim_col		; Feld war leer: Cursor auf die gelandete Karte
	sta cursor_col
	lda anim_row
	sta cursor_row
drop_done
	rts

; Liefert in A das Motiv einer zufälligen liegenden Karte, bei leerem Feld 1–8.
pick_motif
	lda #0
	sta count
	ldx #23
motif_count
	lda board,x
	beq motif_empty
	inc count
motif_empty
	dex
	bpl motif_count
	jsr random
	ldy count
	bne motif_existing
	and #7
	clc
	adc #1
	rts
motif_existing
	jsr mod_count
	sta pick_k
	ldx #$ff
motif_find
	inx
	lda board,x
	beq motif_find
	dec pick_k
	bpl motif_find
	lda board,x
	rts

; Wird der Platz unter dem Cursor leer, springt er auf die erste liegende Karte.
cursor_check
	lda cursor_col
	bmi check_done
	lda cursor_row
	asl
	asl
	ora cursor_col
	tax
	lda board,x
	bne check_done
	jmp cursor_home
check_done
	rts

; X = anim_row*4 + anim_col.
anim_index
	lda anim_row
	asl
	asl
	ora anim_col
	tax
	rts

; A = A mod count, count > 0.
mod_count
	cmp count
	bcc mod_done
	sbc count
	jmp mod_count
mod_done
	rts

; Kurzes Beben über die Feinscroll-Register, ein Wert je Frame.
; Beide Richtungen nur weg von der Ruhelage: waagerecht nach rechts, senkrecht
; nach unten. Unter 3 zeigt der TED unten eine 26. Zeile aus dem Speicher dahinter.
shake
	ldy #0
shake_frame
	sty shake_i
	ldx #1
	jsr wait_frames
	ldy shake_i
	lda ted_ctrl2
	and #%11111000
	ora shake_x,y
	sta ted_ctrl2
	lda ted_ctrl1
	and #%11111000
	ora shake_y,y
	sta ted_ctrl1
	iny
	cpy #shake_y - shake_x
	bne shake_frame
	rts

shake_x
	!byte 4, 0, 3, 0, 2, 0, 1, 0, 1, 0
shake_y
	!byte 7, 3, 6, 3, 5, 3, 4, 3, 4, 3
