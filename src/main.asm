; Endlos-Memory, Schritt 1.
; Schwarzer Schirm, ein Apfel: gesetztes Pixel = Fläche, gelöschtes = schwarz.

screen     = $0c00
color      = $0800
ted_ctrl1  = $ff06
ted_ctrl2  = $ff07
ted_misc1  = $ff12
ted_misc2  = $ff13
ted_bg     = $ff15
ted_border = $ff19

apple_row  = 11
apple_col  = 18
apple_off  = apple_row * 40 + apple_col
apple_color = $42
apple_char = 10

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

	ldx #0
	lda #0
clear
	sta screen,x
	sta screen+$100,x
	sta screen+$200,x
	sta screen+$300,x
	sta color,x
	sta color+$100,x
	sta color+$200,x
	sta color+$300,x
	inx
	bne clear

	lda #apple_char
	sta screen+apple_off
	lda #apple_char+1
	sta screen+apple_off+1
	lda #apple_char+2
	sta screen+apple_off+2
	lda #apple_char+3
	sta screen+apple_off+40
	lda #apple_char+4
	sta screen+apple_off+41
	lda #apple_char+5
	sta screen+apple_off+42
	lda #apple_char+6
	sta screen+apple_off+80
	lda #apple_char+7
	sta screen+apple_off+81
	lda #apple_char+8
	sta screen+apple_off+82
	lda #apple_color
	sta color+apple_off
	sta color+apple_off+1
	sta color+apple_off+2
	sta color+apple_off+40
	sta color+apple_off+41
	sta color+apple_off+42
	sta color+apple_off+80
	sta color+apple_off+81
	sta color+apple_off+82

ready	jmp ready

	!source "src/charset.asm"
