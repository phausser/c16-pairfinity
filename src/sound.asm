; TED-Ton. Stimme 1 spielt Tonfolgen, Stimme 2 klickt beim Aufdecken und rauscht beim Fallen.
; Registerwert für f Hz (PAL): 1024 - 111861 / f.

ted_freq1  = $ff0e		; Stimme 1, untere 8 Bit
ted_freq2  = $ff0f		; Stimme 2, untere 8 Bit
ted_freq2h = $ff10		; Bits 0–1: Stimme 2, obere 2 Bit
ted_sound  = $ff11		; Bits 0–3 Lautstärke, 4 Stimme 1, 5 Rechteck und 6 Rauschen auf Stimme 2
				; $ff12 Bits 0–1: Stimme 1, obere 2 Bit

volume     = 6

sound_init
	lda #volume		; beide Stimmen aus
	sta ted_sound
	lda #0
	sta snd_time
	sta tick_time
	rts

; Startet die Tonfolge ab Offset A in sounds.
play
	sta snd_pos
	; weiter in snd_next

; Nächster Ton: Frequenz unten, oben, Frames. 0 Frames beendet die Folge.
snd_next
	ldx snd_pos
	lda sounds+2,x
	beq snd_off
	sta snd_time
	lda sounds,x
	sta ted_freq1
	lda ted_misc1
	and #%11111100
	ora sounds+1,x
	sta ted_misc1
	lda ted_sound
	ora #%00010000
	sta ted_sound
	inx
	inx
	inx
	stx snd_pos
	rts
snd_off
	lda ted_sound
	and #%11101111
	sta ted_sound
	rts

; Kurzes Rauschen, ein Frame lang.
tick
	lda #<tick_freq
	ldx #>tick_freq
	ldy #%01000000
	bne voice2

; Kurzer hoher Klick, ein Frame lang.
click
	lda #<click_freq
	ldx #>click_freq
	ldy #%00100000
	; weiter in voice2

; Stimme 2 für einen Frame. A/X = Frequenz, Y = Rechteck- oder Rauschbit.
voice2
	sta ted_freq2
	txa
	sta tick_x
	lda ted_freq2h
	and #%11111100
	ora tick_x
	sta ted_freq2h
	tya
	sta tick_x
	lda ted_sound
	and #%10011111
	ora tick_x
	sta ted_sound
	lda #1
	sta tick_time
	rts

; Einmal je Frame aus wait_frames.
sound_tick
	lda snd_time
	beq sound_no_tone
	dec snd_time
	bne sound_no_tone
	jsr snd_next
sound_no_tone
	lda tick_time
	beq sound_done
	dec tick_time
	bne sound_done
	lda ted_sound
	and #%10011111
	sta ted_sound
sound_done
	rts

tick_freq  = 1000
click_freq = 1024 - 111861 / 2000

!macro note .f, .frames {
	!byte <(1024 - 111861 / .f), >(1024 - 111861 / .f), .frames
}

sounds
snd_pair = * - sounds		; hoch, aufsteigend
	+note 1047, 3		; C6
	+note 1319, 3		; E6
	+note 1568, 3		; G6
	+note 2093, 6		; C7
	!byte 0, 0, 0
snd_miss = * - sounds		; tief, absteigend
	+note 196, 6		; G3
	+note 147, 10		; D3
	!byte 0, 0, 0
