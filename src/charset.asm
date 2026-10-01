; Erzeugt von tools/charset.py, nicht von Hand ändern.
; Zeichen $00 leer, $01–$09 Kartenrücken, ab $0A die Früchte 1–8, je 3×3 zeilenweise.
; Ab $52 Ziffern und Buchstaben. $7F ist das Hintergrundmuster, es wird zur Laufzeit geschrieben.

*=$3000
	!fill 8, 0
; Kartenrücken
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
	!byte $dd, $bb, $77, $ee, $dd, $bb, $77, $ee
; 1 Banane
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $87, $87, $87, $b7, $b7, $33, $7b
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $e0
	!byte $fe, $fe, $fc, $f9, $f3, $c7, $1f, $7e
	!byte $7b, $fb, $db, $db, $b3, $b7, $67, $ef
	!byte $cf, $cf, $cc, $e7, $f1, $fc, $ff, $ff
	!byte $f9, $c7, $3f, $fc, $f0, $00, $ff, $ff
	!byte $cf, $9f, $3f, $7f, $0f, $0f, $ff, $ff
; 2 Apfel
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $fe, $fc
	!byte $ff, $ff, $ff, $f0, $f0, $f7, $14, $c1
	!byte $ff, $ff, $7f, $7f, $ff, $ff, $3f, $9f
	!byte $f9, $fb, $f3, $f7, $f7, $f7, $f7, $f3
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $cf, $ef, $e7, $e7, $e7, $a7, $a7, $a7
	!byte $fb, $f9, $fc, $fe, $ff, $ff, $ff, $ff
	!byte $ff, $f4, $ff, $63, $00, $80, $ff, $ff
	!byte $4f, $cf, $9f, $3f, $0f, $0f, $ff, $ff
; 3 Birne
	!byte $ff, $ff, $ff, $ff, $ff, $fe, $fe, $fe
	!byte $ff, $c3, $c1, $ef, $01, $7c, $fe, $fe
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $7f
	!byte $fc, $fd, $f9, $fb, $f3, $f7, $f7, $f7
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $7f, $3f, $3f, $9f, $df, $cf, $4f, $cf
	!byte $f7, $f3, $f9, $fc, $fe, $ff, $ff, $ff
	!byte $ff, $fe, $f1, $ff, $20, $80, $ff, $ff
	!byte $4f, $cf, $9f, $3f, $07, $07, $ff, $ff
; 4 Kirsche
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $fd, $f8, $f0, $e5, $cd, $9d
	!byte $ff, $ff, $ff, $7f, $1f, $0f, $87, $87
	!byte $ff, $fe, $fe, $fc, $fd, $f8, $f0, $e6
	!byte $3d, $7d, $fc, $fe, $fe, $7c, $38, $13
	!byte $cf, $ff, $ff, $ff, $ff, $3f, $1f, $0f
	!byte $e6, $e0, $e0, $f0, $f8, $ff, $ff, $ff
	!byte $13, $10, $10, $38, $1c, $ff, $ff, $ff
	!byte $0f, $0f, $0f, $1f, $07, $ff, $ff, $ff
; 5 Trauben
	!byte $ff, $fc, $fc, $fe, $ff, $ff, $fc, $fb
	!byte $ff, $7f, $3d, $1b, $07, $ef, $44, $bb
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $7f, $bf
	!byte $fb, $fb, $f8, $fc, $fe, $fe, $fe, $fe
	!byte $bb, $33, $00, $44, $ee, $ee, $cc, $00
	!byte $bf, $3f, $3f, $7f, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $11, $bb, $bb, $b3, $80, $c0, $ff, $ff
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
; 6 Orange
	!byte $ff, $ff, $ff, $ff, $fe, $fc, $f9, $f3
	!byte $ff, $ff, $ff, $83, $38, $d6, $11, $11
	!byte $ff, $ff, $ff, $ff, $ff, $7f, $3f, $9f
	!byte $f4, $e4, $e8, $ef, $e8, $e4, $f4, $f3
	!byte $92, $54, $38, $ff, $38, $54, $92, $11
	!byte $4f, $4f, $27, $e7, $27, $47, $47, $8f
	!byte $f9, $fc, $fe, $ff, $ff, $ff, $ff, $ff
	!byte $11, $d6, $38, $00, $c0, $ff, $ff, $ff
	!byte $0f, $1f, $3f, $07, $07, $ff, $ff, $ff
; 7 Pflaume
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $fb, $f3, $e3, $e7, $ef, $c3
	!byte $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!byte $ff, $ff, $fe, $fe, $fc, $fd, $fd, $fd
	!byte $a9, $5c, $de, $be, $be, $be, $be, $be
	!byte $ff, $ff, $7f, $7f, $3f, $3f, $3f, $3f
	!byte $fd, $fd, $fc, $fe, $ff, $ff, $ff, $ff
	!byte $bc, $bc, $b8, $70, $00, $80, $ff, $ff
	!byte $3f, $3f, $7f, $7f, $0f, $0f, $ff, $ff
; 8 Himbeere
	!byte $ff, $ff, $fb, $fd, $fc, $fe, $fc, $fa
	!byte $ff, $bf, $b7, $bb, $92, $00, $00, $da
	!byte $ff, $ff, $ff, $1f, $7f, $ff, $3f, $1f
	!byte $fa, $fc, $fb, $fb, $fc, $fd, $fd, $fc
	!byte $da, $00, $6d, $6d, $00, $b6, $b6, $00
	!byte $1f, $3f, $1f, $1f, $3f, $3f, $3f, $3f
	!byte $fe, $fe, $fe, $ff, $ff, $ff, $ff, $ff
	!byte $da, $da, $00, $68, $80, $ff, $ff, $ff
	!byte $7f, $7f, $7f, $07, $07, $ff, $ff, $ff
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
