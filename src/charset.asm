; Erzeugt von tools/charset.py, nicht von Hand ändern.
; Zeichen $00 leer, $01–$09 Kartenrücken, ab $0A die Früchte 1–8, je 3×3 zeilenweise.

*=$3000
	!fill 8, 0
; Kartenrücken
	!byte $ff, $ff, $ff, $ff, $f0, $f0, $f3, $f3
	!byte $ff, $ff, $ff, $ff, $00, $00, $ff, $e7
	!byte $ff, $ff, $ff, $ff, $0f, $0f, $cf, $cf
	!byte $f3, $f3, $f3, $f2, $f2, $f3, $f3, $f3
	!byte $c3, $81, $00, $00, $00, $00, $81, $c3
	!byte $cf, $cf, $cf, $4f, $4f, $cf, $cf, $cf
	!byte $f3, $f3, $f0, $f0, $ff, $ff, $ff, $ff
	!byte $e7, $ff, $00, $00, $ff, $ff, $ff, $ff
	!byte $cf, $cf, $0f, $0f, $ff, $ff, $ff, $ff
; 1 Apfel
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fc
	!byte $ff, $ff, $ff, $dc, $d8, $e0, $e3, $2c
	!byte $ff, $ff, $87, $0f, $1f, $7f, $ff, $3f
	!byte $f0, $e0, $e0, $e0, $e0, $e0, $e0, $f0
	!byte $08, $00, $00, $00, $00, $00, $00, $00
	!byte $0f, $07, $07, $07, $07, $07, $07, $0f
	!byte $f0, $f8, $f8, $fc, $fe, $ff, $ff, $ff
	!byte $00, $00, $00, $00, $18, $ff, $ff, $ff
	!byte $0f, $1f, $1f, $3f, $7f, $ff, $ff, $ff
; 2 Orange
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe
	!byte $ff, $ff, $ff, $e4, $e0, $e7, $81, $00
	!byte $ff, $ff, $1f, $07, $0f, $ff, $ff, $7f
	!byte $fc, $f8, $f8, $f0, $f0, $f0, $f0, $f0
	!byte $00, $00, $00, $00, $00, $00, $00, $00
	!byte $3f, $1f, $1f, $0f, $0f, $0f, $0f, $0f
	!byte $f0, $f8, $f8, $fc, $fe, $ff, $ff, $ff
	!byte $00, $00, $00, $00, $00, $81, $ff, $ff
	!byte $0f, $1f, $1f, $3f, $7f, $ff, $ff, $ff
; 3 Birne
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $df, $ef, $ef, $e7, $c3, $81
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $fe, $fc, $f8, $f8
	!byte $81, $81, $00, $00, $00, $00, $00, $00
	!byte $ff, $ff, $ff, $ff, $7f, $3f, $1f, $1f
	!byte $f0, $f0, $f0, $f8, $fc, $ff, $ff, $ff
	!byte $00, $00, $00, $00, $00, $18, $ff, $ff
	!byte $0f, $0f, $0f, $1f, $3f, $ff, $ff, $ff
; 4 Banane
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $fe, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $3f, $3f, $3f, $1f, $0f
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $fe, $fe, $fe, $fe, $fc, $fc, $f8, $f0
	!byte $0f, $07, $07, $07, $07, $07, $07, $0f
	!byte $ff, $ff, $f8, $e0, $e0, $ff, $ff, $ff
	!byte $c0, $00, $00, $03, $3f, $ff, $ff, $ff
	!byte $1f, $3f, $ff, $ff, $ff, $ff, $ff, $ff
; 5 Traube
	!byte $ff, $ff, $ff, $ff, $ff, $e3, $c0, $c0
	!byte $ff, $ff, $f4, $f0, $f4, $10, $00, $00
	!byte $ff, $ff, $3f, $1f, $7f, $c7, $03, $03
	!byte $c0, $e0, $f8, $f8, $f8, $fc, $fe, $fe
	!byte $00, $00, $00, $00, $00, $00, $00, $00
	!byte $03, $07, $0f, $0f, $0f, $1f, $7f, $7f
	!byte $fe, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $00, $c1, $c1, $c1, $e3, $ff, $ff
	!byte $7f, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; 6 Kirsche
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $fc, $fa, $f6, $ee, $df
	!byte $ff, $ff, $87, $0f, $3f, $ff, $ff, $7f
	!byte $ff, $ff, $ff, $fe, $fe, $f8, $f0, $e0
	!byte $bf, $7f, $7f, $ff, $fe, $7c, $38, $18
	!byte $7f, $7f, $7f, $7f, $1f, $0f, $07, $07
	!byte $e0, $e0, $e0, $f0, $f8, $ff, $ff, $ff
	!byte $18, $18, $1c, $3e, $7f, $ff, $ff, $ff
	!byte $07, $07, $0f, $1f, $ff, $ff, $ff, $ff
; 7 Zitrone
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $81, $00
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $7f
	!byte $fc, $f8, $f0, $c0, $c0, $f0, $f8, $fc
	!byte $00, $00, $00, $00, $00, $00, $00, $00
	!byte $3f, $1f, $0f, $03, $03, $0f, $1f, $3f
	!byte $fe, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $81, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $7f, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; 8 Erdbeere
	!byte $ff, $ff, $ff, $ff, $f7, $f3, $f9, $f8
	!byte $ff, $ff, $fb, $e7, $e7, $66, $00, $00
	!byte $ff, $ff, $ff, $ff, $ef, $cf, $9f, $1f
	!byte $f0, $f0, $f0, $f8, $f8, $fc, $fc, $fe
	!byte $00, $00, $00, $00, $00, $00, $00, $00
	!byte $0f, $0f, $0f, $1f, $1f, $3f, $3f, $7f
	!byte $fe, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $00, $81, $c3, $e7, $ff, $ff, $ff
	!byte $7f, $ff, $ff, $ff, $ff, $ff, $ff, $ff
