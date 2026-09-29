; Erzeugt von tools/charset.py, nicht von Hand ändern.
; Zeichen $00 leer, $01–$09 Kartenrücken, ab $0A die Früchte 1–8, je 3×3 zeilenweise.
; Ab $52 Ziffern und Buchstaben. $7F ist das Hintergrundmuster, es wird zur Laufzeit geschrieben.

*=$3000
	!fill 8, 0
; Kartenrücken
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
	!byte $cc, $99, $33, $66, $cc, $99, $33, $66
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
; Ziffern 0–9, dann A–Z
	!byte $7c, $c6, $ce, $d6, $e6, $c6, $7c, $00	; 0
	!byte $18, $38, $78, $18, $18, $18, $7e, $00	; 1
	!byte $7c, $c6, $06, $1c, $70, $c0, $fe, $00	; 2
	!byte $7c, $c6, $06, $3c, $06, $c6, $7c, $00	; 3
	!byte $0c, $1c, $3c, $6c, $fe, $0c, $0c, $00	; 4
	!byte $fe, $c0, $fc, $06, $06, $c6, $7c, $00	; 5
	!byte $3c, $60, $c0, $fc, $c6, $c6, $7c, $00	; 6
	!byte $fe, $06, $0c, $18, $30, $30, $30, $00	; 7
	!byte $7c, $c6, $c6, $7c, $c6, $c6, $7c, $00	; 8
	!byte $7c, $c6, $c6, $7e, $06, $0c, $78, $00	; 9
	!byte $38, $6c, $c6, $c6, $fe, $c6, $c6, $00	; A
	!byte $fc, $c6, $c6, $fc, $c6, $c6, $fc, $00	; B
	!byte $7c, $c6, $c0, $c0, $c0, $c6, $7c, $00	; C
	!byte $fc, $c6, $c6, $c6, $c6, $c6, $fc, $00	; D
	!byte $fe, $c0, $c0, $fc, $c0, $c0, $fe, $00	; E
	!byte $fe, $c0, $c0, $f8, $c0, $c0, $c0, $00	; F
	!byte $7c, $c6, $c0, $de, $c6, $c6, $7c, $00	; G
	!byte $c6, $c6, $c6, $fe, $c6, $c6, $c6, $00	; H
	!byte $fe, $30, $30, $30, $30, $30, $fe, $00	; I
	!byte $fe, $0c, $0c, $0c, $cc, $cc, $78, $00	; J
	!byte $c6, $cc, $d8, $f0, $d8, $cc, $c6, $00	; K
	!byte $c0, $c0, $c0, $c0, $c0, $c0, $fe, $00	; L
	!byte $c6, $ee, $fe, $d6, $c6, $c6, $c6, $00	; M
	!byte $c6, $e6, $e6, $d6, $ce, $ce, $c6, $00	; N
	!byte $7c, $c6, $c6, $c6, $c6, $c6, $7c, $00	; O
	!byte $fc, $c6, $c6, $fc, $c0, $c0, $c0, $00	; P
	!byte $7c, $c6, $c6, $c6, $c6, $c6, $7a, $00	; Q
	!byte $fc, $c6, $c6, $fc, $d8, $cc, $c6, $00	; R
	!byte $7c, $c6, $c0, $7c, $06, $c6, $7c, $00	; S
	!byte $fc, $30, $30, $30, $30, $30, $30, $00	; T
	!byte $c6, $c6, $c6, $c6, $c6, $c6, $7c, $00	; U
	!byte $c6, $c6, $c6, $c6, $6c, $38, $10, $00	; V
	!byte $c6, $c6, $c6, $d6, $fe, $ee, $c6, $00	; W
	!byte $c6, $6c, $38, $10, $38, $6c, $c6, $00	; X
	!byte $c6, $6c, $38, $10, $10, $10, $10, $00	; Y
	!byte $fe, $06, $0c, $18, $30, $60, $fe, $00	; Z
