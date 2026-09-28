; Endlos-Memory. Raster 4×6, verdeckte Karten, Cursor.

screen     = $0c00
color      = $0800
ted_ctrl1  = $ff06
ted_ctrl2  = $ff07
ted_misc1  = $ff12
ted_misc2  = $ff13
ted_bg     = $ff15
ted_border = $ff19

board      = $0400
cursor_col = $0418
cursor_row = $0419
prev_dirs  = $041a
try_col    = $041b
try_row    = $041c
draw_col   = $041d
draw_row   = $041e
char_base  = $041f
color_byte = $0420
idx        = $0425
rows_left  = $0426
dir        = $0427
dirs       = $0428
key        = $0429
sy         = $042a
sx         = $042b
edges      = $042c
motif      = $042d
scr        = $fb
colr       = $fd

back_char  = 1
back_color = $51
cursor_bit = $80

*=$1001
	!word basend
	!word 10
	!byte $9e, $20
	!byte start div 1000 + $30
	!byte start mod 1000 div 100 + $30
	!byte start mod 100 div 10 + $30
	!byte start mod 10 + $30
	!byte 0
basend	!word 0

start
	sei
	lda #0
	sta ted_bg
	sta ted_border
	lda ted_ctrl1
	and #%10011111
	ora #%00010000
	sta ted_ctrl1
	lda ted_ctrl2
	and #%01101111
	sta ted_ctrl2
	lda ted_misc1
	and #%11111011		; Zeichensatz aus dem RAM
	sta ted_misc1
	lda #$30		; Zeichensatz bei $3000
	sta ted_misc2
	jsr clear_screen
	jsr init_board
	jsr draw_board
!ifdef PREVIEW {
	jsr draw_preview
} else {
	jsr show_cursor
}
loop
	jsr read_edges
	beq loop
	sta edges
	and #1
	beq not_up
	lda #0
	jsr move_cursor
not_up
	lda edges
	and #2
	beq not_down
	lda #1
	jsr move_cursor
not_down
	lda edges
	and #4
	beq not_left
	lda #2
	jsr move_cursor
not_left
	lda edges
	and #8
	beq not_right
	lda #3
	jsr move_cursor
not_right
	jsr settle
	jmp loop

clear_screen
	ldx #0
	lda #0
clear_loop
	sta screen,x
	sta screen+$100,x
	sta screen+$200,x
	sta screen+$300,x
	sta color,x
	sta color+$100,x
	sta color+$200,x
	sta color+$300,x
	inx
	bne clear_loop
	rts

; Kurze Pause, damit ein prellender Taster nicht zweimal zählt.
settle
	ldx #$18
settle_outer
	ldy #0
settle_inner
	dey
	bne settle_inner
	dex
	bne settle_outer
	rts

	!source "src/board.asm"
	!source "src/draw.asm"
	!source "src/input.asm"
	!source "src/charset.asm"
