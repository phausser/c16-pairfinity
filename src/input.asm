; Liefert in A die neu gedrückten Richtungen.
; Bit 0 hoch, 1 runter, 2 links, 3 rechts, 4 Feuer.

read_edges
	jsr read_dirs
	sta key
	eor prev_dirs
	and key
	pha
	lda key
	sta prev_dirs
	pla
	rts

read_dirs
	lda #$ff		; keine Tastaturzeile, sonst stört sie den Joystick
	sta $fd30
	ldx #$fa		; Joystick 1
	stx $ff08
	lda $ff08
	eor #$ff
	sta key
	and #$0f
	sta dirs
	lda key
	and #$40		; Feuer
	beq joy_no_fire
	lda dirs
	ora #$10
	sta dirs
joy_no_fire
	lda #$df		; Tastaturzeile 5: runter Bit 0, hoch Bit 3
	sta $fd30
	lda #$ff
	sta $ff08
	lda $ff08
	eor #$ff
	sta key
	and #$01
	beq key_not_down
	lda dirs
	ora #$02
	sta dirs
key_not_down
	lda key
	and #$08
	beq key_not_up
	lda dirs
	ora #$01
	sta dirs
key_not_up
	lda #$bf		; Tastaturzeile 6: links Bit 0, rechts Bit 3
	sta $fd30
	lda #$ff
	sta $ff08
	lda $ff08
	eor #$ff
	sta key
	and #$01
	beq key_not_left
	lda dirs
	ora #$04
	sta dirs
key_not_left
	lda key
	and #$08
	beq key_not_right
	lda dirs
	ora #$08
	sta dirs
key_not_right
	lda #$7f		; Tastaturzeile 7: Leertaste Bit 4
	sta $fd30
	lda #$ff
	sta $ff08
	lda $ff08
	and #$10
	beq key_fire
	lda #$fe		; Tastaturzeile 0: Return Bit 1
	sta $fd30
	lda #$ff
	sta $ff08
	lda $ff08
	and #$02
	bne key_no_fire
key_fire
	lda dirs
	ora #$10
	sta dirs
key_no_fire
	lda dirs
	rts
