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
	!byte $f0, $e6, $e7, $e3, $e0, $e0, $e0, $f0
	!byte $08, $00, $00, $00, $00, $00, $00, $00
	!byte $0f, $07, $07, $07, $07, $07, $07, $0f
	!byte $f0, $f8, $f8, $fc, $fe, $ff, $ff, $ff
	!byte $00, $00, $00, $00, $18, $ff, $ff, $ff
	!byte $0f, $1f, $1f, $3f, $7f, $ff, $ff, $ff
; 2 Orange
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe
	!byte $ff, $ff, $ff, $e4, $e0, $e7, $81, $00
	!byte $ff, $ff, $1f, $07, $0f, $ff, $ff, $7f
	!byte $fc, $f8, $f9, $f9, $f1, $f0, $f0, $f0
	!byte $00, $00, $80, $c0, $80, $00, $00, $00
	!byte $3f, $1f, $1f, $1f, $0f, $0f, $0f, $0f
	!byte $f0, $f8, $f8, $fc, $fe, $ff, $ff, $ff
	!byte $00, $00, $00, $00, $00, $81, $ff, $ff
	!byte $0f, $1f, $1f, $3f, $7f, $ff, $ff, $ff
; 3 Birne
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $df, $ef, $ef, $e7, $c3, $81
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $fe, $fc, $f8, $f9
	!byte $81, $81, $00, $00, $00, $00, $00, $80
	!byte $ff, $ff, $ff, $ff, $7f, $3f, $1f, $1f
	!byte $f1, $f1, $f0, $f8, $fc, $ff, $ff, $ff
	!byte $c0, $80, $00, $00, $00, $18, $ff, $ff
	!byte $0f, $0f, $0f, $1f, $3f, $ff, $ff, $ff
; 4 Banane
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $fe, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $3f, $3f, $3f, $1f, $0f
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $fe, $fe, $fe, $fe, $fc, $fc, $f8, $f0
	!byte $0f, $87, $87, $07, $07, $07, $07, $0f
	!byte $ff, $ff, $f8, $e0, $e0, $ff, $ff, $ff
	!byte $c0, $00, $00, $03, $3f, $ff, $ff, $ff
	!byte $1f, $3f, $ff, $ff, $ff, $ff, $ff, $ff
; 5 Traube
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fd
	!byte $ff, $ff, $e3, $e7, $e7, $81, $00, $80
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $7f, $3f
	!byte $f8, $fc, $f8, $fc, $f8, $fc, $fe, $fe
	!byte $00, $00, $00, $80, $01, $00, $00, $00
	!byte $1f, $3f, $1f, $3f, $9f, $3f, $7f, $7f
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $00, $81, $c3, $e7, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; 6 Kirsche
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $fc, $fa, $f6, $ee, $df
	!byte $ff, $ff, $87, $0f, $3f, $ff, $ff, $7f
	!byte $ff, $ff, $ff, $fe, $fe, $f8, $f6, $e6
	!byte $bf, $7f, $7f, $ff, $fe, $7c, $3b, $19
	!byte $7f, $7f, $7f, $7f, $1f, $0f, $07, $87
	!byte $e0, $e0, $e0, $f0, $f8, $ff, $ff, $ff
	!byte $18, $18, $1c, $3e, $7f, $ff, $ff, $ff
	!byte $07, $07, $0f, $1f, $ff, $ff, $ff, $ff
; 7 Zitrone
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $fe
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $81, $00
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $7f
	!byte $fc, $f9, $f1, $c1, $c0, $f0, $f8, $fc
	!byte $00, $80, $c0, $80, $00, $00, $00, $00
	!byte $3f, $1f, $0f, $03, $03, $0f, $1f, $3f
	!byte $fe, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $81, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $7f, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; 8 Erdbeere
	!byte $ff, $ff, $ff, $ff, $f7, $f3, $f9, $f8
	!byte $ff, $ff, $fb, $e7, $e7, $66, $00, $00
	!byte $ff, $ff, $ff, $ff, $ef, $cf, $9f, $1f
	!byte $f1, $f0, $f2, $f8, $f8, $fc, $fc, $fe
	!byte $00, $00, $00, $00, $42, $00, $00, $20
	!byte $8f, $0f, $4f, $1f, $1f, $3f, $3f, $7f
	!byte $fe, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $00, $00, $81, $c3, $e7, $ff, $ff, $ff
	!byte $7f, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; Ziffern 0–9, dann A–Z
; 0
	!byte %01111100
	!byte %11000110
	!byte %11001110
	!byte %11010110
	!byte %11100110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; 1
	!byte %00011000
	!byte %00111000
	!byte %01111000
	!byte %00011000
	!byte %00011000
	!byte %00011000
	!byte %01111110
	!byte %00000000
; 2
	!byte %01111100
	!byte %11000110
	!byte %00000110
	!byte %00011100
	!byte %01110000
	!byte %11000000
	!byte %11111110
	!byte %00000000
; 3
	!byte %01111100
	!byte %11000110
	!byte %00000110
	!byte %00111100
	!byte %00000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; 4
	!byte %00001100
	!byte %00011100
	!byte %00111100
	!byte %01101100
	!byte %11111110
	!byte %00001100
	!byte %00001100
	!byte %00000000
; 5
	!byte %11111110
	!byte %11000000
	!byte %11111100
	!byte %00000110
	!byte %00000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; 6
	!byte %00111100
	!byte %01100000
	!byte %11000000
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; 7
	!byte %11111110
	!byte %00000110
	!byte %00001100
	!byte %00011000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00000000
; 8
	!byte %01111100
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; 9
	!byte %01111100
	!byte %11000110
	!byte %11000110
	!byte %01111110
	!byte %00000110
	!byte %00001100
	!byte %01111000
	!byte %00000000
; A
	!byte %00111000
	!byte %01101100
	!byte %11000110
	!byte %11000110
	!byte %11111110
	!byte %11000110
	!byte %11000110
	!byte %00000000
; B
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %11111100
	!byte %00000000
; C
	!byte %01111100
	!byte %11000110
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %11000110
	!byte %01111100
	!byte %00000000
; D
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11111100
	!byte %00000000
; E
	!byte %11111110
	!byte %11000000
	!byte %11000000
	!byte %11111100
	!byte %11000000
	!byte %11000000
	!byte %11111110
	!byte %00000000
; F
	!byte %11111110
	!byte %11000000
	!byte %11000000
	!byte %11111000
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %00000000
; G
	!byte %01111100
	!byte %11000110
	!byte %11000000
	!byte %11011110
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; H
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11111110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %00000000
; I
	!byte %11111110
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %11111110
	!byte %00000000
; J
	!byte %11111110
	!byte %00001100
	!byte %00001100
	!byte %00001100
	!byte %11001100
	!byte %11001100
	!byte %01111000
	!byte %00000000
; K
	!byte %11000110
	!byte %11001100
	!byte %11011000
	!byte %11110000
	!byte %11011000
	!byte %11001100
	!byte %11000110
	!byte %00000000
; L
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %11111110
	!byte %00000000
; M
	!byte %11000110
	!byte %11101110
	!byte %11111110
	!byte %11010110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %00000000
; N
	!byte %11000110
	!byte %11100110
	!byte %11100110
	!byte %11010110
	!byte %11001110
	!byte %11001110
	!byte %11000110
	!byte %00000000
; O
	!byte %01111100
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; P
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %11111100
	!byte %11000000
	!byte %11000000
	!byte %11000000
	!byte %00000000
; Q
	!byte %01111100
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %01111010
	!byte %00000000
; R
	!byte %11111100
	!byte %11000110
	!byte %11000110
	!byte %11111100
	!byte %11011000
	!byte %11001100
	!byte %11000110
	!byte %00000000
; S
	!byte %01111100
	!byte %11000110
	!byte %11000000
	!byte %01111100
	!byte %00000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; T
	!byte %11111100
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00110000
	!byte %00000000
; U
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %01111100
	!byte %00000000
; V
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %01101100
	!byte %00111000
	!byte %00010000
	!byte %00000000
; W
	!byte %11000110
	!byte %11000110
	!byte %11000110
	!byte %11010110
	!byte %11111110
	!byte %11101110
	!byte %11000110
	!byte %00000000
; X
	!byte %11000110
	!byte %01101100
	!byte %00111000
	!byte %00010000
	!byte %00111000
	!byte %01101100
	!byte %11000110
	!byte %00000000
; Y
	!byte %11000110
	!byte %01101100
	!byte %00111000
	!byte %00010000
	!byte %00010000
	!byte %00010000
	!byte %00010000
	!byte %00000000
; Z
	!byte %11111110
	!byte %00000110
	!byte %00001100
	!byte %00011000
	!byte %00110000
	!byte %01100000
	!byte %11111110
	!byte %00000000
