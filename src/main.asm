; Endlos-Memory. Raster 4×6, Paare verschwinden, Spalten packen sich, neue Karten fallen.

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
phase      = $042e
open1      = $042f
open2      = $0430
cell_color = $0431
shuf_i     = $0432
rnd        = $0434		; 2 Bytes
gap        = $0436		; 4 Bytes
step       = $043a
anim_col   = $043b
anim_row   = $043c
anim_e     = $043d
count      = $043e
pick_k     = $043f
drop_cell  = $0440
drop_motif = $0441
target     = $0442
cur_y      = $0443
clear_end  = $0444
bg_step    = $0445
bg_timer   = $0446
bg_row_byte = $0447
score      = $0448		; 3 Ziffern, höchste zuerst
game_over  = $044b
was_pair   = $044c
shake_i    = $044d
scr        = $fb
colr       = $fd

back_char  = 1
back_color = $51
hud_color  = $71
ch_0       = $52		; Ziffern, danach A E L O P R V
ch_a       = $5c
ch_e       = $5d
ch_l       = $5e
ch_o       = $5f
ch_p       = $60
ch_r       = $61
ch_v       = $62
cursor_lum = $10		; Cursor: eine Helligkeitsstufe heller

charset    = $3000
bg_char    = $7f		; $ff ist dasselbe Zeichen invertiert
bg_color   = $21
bg_speed   = 4		; Frames je Pixel

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
	and #%10011000
	ora #%00010011		; Feinscroll senkrecht 3 ist die Ruhelage
	sta ted_ctrl1
	lda ted_ctrl2
	and #%01101000		; waagerecht 0
	sta ted_ctrl2
	lda ted_misc1
	and #%11111011		; Zeichensatz aus dem RAM
	sta ted_misc1
	lda #$30		; Zeichensatz bei $3000
	sta ted_misc2
	lda #0
	sta bg_step
	lda #bg_speed
	sta bg_timer
	jsr bg_glyph
	jsr seed_random
new_game
	jsr clear_screen
	jsr init_board
	jsr draw_board
	jsr draw_hud
!ifdef PREVIEW {
	jsr draw_preview
}
loop
	ldx #1
	jsr wait_frames
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
	lda edges
	and #$10
	beq not_fire
	jsr pick
not_fire
	lda game_over
	bne game_end
	ldx #3			; kurz warten, damit ein prellender Taster nicht zweimal zählt
	jsr wait_frames
	jmp loop

; Kein Platz mehr: VOLL zeigen, auf Feuer warten, neu geben.
game_end
	jsr draw_full
wait_restart
	ldx #1
	jsr wait_frames
	jsr read_edges
	and #$10
	beq wait_restart
	jmp new_game

	!source "src/board.asm"
	!source "src/draw.asm"
	!source "src/input.asm"
	!source "src/anim.asm"
	!source "src/charset.asm"
