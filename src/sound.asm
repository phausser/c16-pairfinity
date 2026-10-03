; TED-Ton. Drei Effekte aus c16-sound-fx (https://github.com/phausser/c16-sound-fx),
; nur PAL: 69 zelda-discovery (Paar), 31 sword-swing (Karte aufgedeckt),
; 13 action-denied (Fehlversuch), 38 switch-click im Loop (fallende Karte).
; Ein neuer Effekt ersetzt den laufenden.

!addr {
ted_freq1  = $ff0e		; Stimme 1, untere 8 Bit
ted_freq2  = $ff0f		; Stimme 2, untere 8 Bit
ted_freq2h = $ff10		; Bits 0–1: Stimme 2, obere 2 Bit
ted_sound  = $ff11		; Bits 0–3 Lautstärke, 4 Stimme 1, 5 Rechteck und 6 Rauschen auf Stimme 2
}				; $ff12 Bits 0–1: Stimme 1, obere 2 Bit

volume     = 6

sound_init
	lda #volume		; beide Stimmen aus
	sta ted_sound
	lda #0
	sta snd_time
	lda #$ff
	sta snd_loop
	rts

; Wiederholt den Effekt ab Offset A, bis snd_loop $ff wird. Ein laufender
; Effekt spielt erst zu Ende, der Loop schliesst an.
play_loop
	sta snd_loop
	ldx snd_time
	bne sound_done
	beq snd_start

; Startet den Effekt ab Offset A in sounds.
play
	ldx #$ff
	stx snd_loop
snd_start
	sta snd_pos
	; weiter in snd_next

; Nächster Schritt: Frames, Stimme 1 unten/oben, Stimme 2 unten/oben, $ff11.
; 0 Frames beendet den Effekt oder springt zurück an den Loop.
snd_next
	ldx snd_pos
	lda sounds,x
	sta snd_time
	bne snd_step
	lda snd_loop
	bmi snd_off
	sta snd_pos
	bpl snd_next
snd_step
	lda sounds+1,x
	sta ted_freq1
	lda ted_misc1
	and #%11111100
	ora sounds+2,x
	sta ted_misc1
	lda sounds+3,x
	sta ted_freq2
	lda ted_freq2h
	and #%11111100
	ora sounds+4,x
	sta ted_freq2h
	lda sounds+5,x
	sta ted_sound
	txa
	clc
	adc #6
	sta snd_pos
	rts
snd_off
	lda #volume
	sta ted_sound
	rts

; Einmal je Frame aus wait_frames.
sound_tick
	lda snd_time
	beq sound_done
	dec snd_time
	bne sound_done
	jsr snd_next
sound_done
	rts

; Registerwerte für PAL, gerundet wie in c16-sound-fx.
!macro step .frames, .hz1, .hz2, .control {
	.n1 = 1024 - (110840 + .hz1 / 2) / .hz1
	.n2 = 1024 - (110840 + .hz2 / 2) / .hz2
	!byte .frames, <.n1, >.n1, <.n2, >.n2, .control
}

sounds
snd_pair = * - sounds		; 69 zelda-discovery
	+step 3, 659, 110, $14
	+step 3, 784, 110, $14
	+step 3, 988, 110, $15
	+step 3, 1319, 110, $15
	+step 4, 1568, 110, $14
	+step 5, 1976, 110, $13
	+step 7, 2637, 110, $11
	!byte 0
snd_flip = * - sounds		; 31 sword-swing
	+step 2, 110, 350, $42
	+step 4, 110, 1800, $44
	+step 2, 110, 600, $42
	!byte 0
snd_miss = * - sounds		; 13 action-denied
	+step 4, 146, 110, $15
	+step 2, 110, 110, $00
	+step 4, 130, 110, $14
	!byte 0
snd_drop = * - sounds		; 38 switch-click, Pause wie im Loop der Bibliothek
	+step 2, 110, 2000, $44
	+step 10, 110, 110, $00
	!byte 0

snd_flip_frames = 8		; Länge von snd_flip
