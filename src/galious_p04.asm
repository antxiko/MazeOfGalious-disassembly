; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 04 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; Etiquetas que no caen en ninguna posicion emitida del listado
; (destinos fuera del binario o dentro de una instruccion).
; ----------------------------------------------------------------------
L_7BB3:	equ 0x07bb3

; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l67b6h:	equ 0x067b6

; ======================================================================
; CODIGO 0x6000..0x60ae  (174 bytes)
; ======================================================================


L_6000:
	call L_6091		;6000
	ld a,(0e041h)		;6003   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,0b5cbh		;6006
	call 04053h		;6009   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ex de,hl			;600c
	ld a,(0e042h)		;600d   ; lee la sala
	dec a			;6010
	jr z,L_6022		;6011
	ld b,a			;6013
L_6014:
	ld a,(hl)			;6014
	inc hl			;6015
	and 07fh		;6016
	jr z,L_601E		;6018
	inc hl			;601a
	jp L_6014		;601b
L_601E:
	dec b			;601e
	jp nz,L_6014		;601f
L_6022:
	ld a,(hl)			;6022
	ld b,a			;6023
	and 07fh		;6024
	ret z			;6026
	ld (0f000h),a		;6027
	inc hl			;602a
	inc hl			;602b
	call L_6078		;602c
	jr nz,L_6022		;602f
	dec hl			;6031
	ld a,(hl)			;6032
	and 0f8h		;6033
	ld d,a			;6035
	ld a,(hl)			;6036
	inc hl			;6037
	rl b		;6038
	rla			;603a
	rla			;603b
	rla			;603c
	rla			;603d
	rla			;603e
	and 0f0h		;603f
	ld e,a			;6041
	ld b,000h		;6042
	ld a,r		;6044
	and 003h		;6046
	ld c,a			;6048
	ld a,(0f000h)		;6049
	push hl			;604c
	call L_65DA		;604d
	pop hl			;6050
	jp L_6022		;6051
L_6054:
	xor a			;6054
	ld (0e612h),a		;6055
	ld bc,(0e041h)		;6058   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;605c
	cp 00bh		;605d
	ret z			;605f
	ld hl,060eeh		;6060
	call 04053h		;6063   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
L_6066:
	ld a,(de)			;6066
	or a			;6067
	ret z			;6068
	cp b			;6069
	jr z,L_6071		;606a
	ret nc			;606c
	inc de			;606d
	jp L_6066		;606e
L_6071:
	ld hl,00001h		;6071
	ld (0e612h),hl		;6074
	ret			;6077
L_6078:
	ld a,(0e612h)		;6078
	or a			;607b
	ret z			;607c
	push hl			;607d
	push bc			;607e
	ld hl,0e613h		;607f
	ld b,(hl)			;6082
	inc (hl)			;6083
	inc b			;6084
	xor a			;6085
	scf			;6086
L_6087:
	rla			;6087
	djnz L_6087		;6088
	ld hl,(0e60ch)		;608a   ; lee la direccion del byte de la sala en el tramo del mapa y el byte siguiente (16 bits)
	and (hl)			;608d
	pop bc			;608e
	pop hl			;608f
	ret			;6090
L_6091:
	xor a			;6091
	ld (0e610h),a		;6092
	ld bc,(0e041h)		;6095   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;6099
	dec a			;609a
	ld hl,060aeh		;609b
	call 04053h		;609e   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
L_60A1:
	ld a,(de)			;60a1
	or a			;60a2
	ret z			;60a3
	inc de			;60a4
	cp b			;60a5
	jr nz,L_60A1		;60a6
	ld a,001h		;60a8
	ld (0e610h),a		;60aa
	ret			;60ad

; ----------------------------------------------------------------------
; DATOS tabla_salas_e610: 11 punteros, uno por mapa desde el 1, a las salas en
;   las que p04:6091 pone 0xE610 a 1; lo leen p04:60A1 (22 bytes)
;   0x60ae..0x60c4  (22 bytes)
DATA_tabla_salas_e610:
	defb 0c4h,060h	; 60ae
	defb 0ceh,060h	; 60b0
	defb 0d1h,060h	; 60b2
	defb 0d5h,060h	; 60b4
	defb 0d8h,060h	; 60b6
	defb 0dbh,060h	; 60b8
	defb 0deh,060h	; 60ba
	defb 0e2h,060h	; 60bc
	defb 0e6h,060h	; 60be
	defb 0eah,060h	; 60c0
	defb 0efh,060h	; 60c2

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_1: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 1, acabadas en 0; lo leen p04:60A1 (10 bytes)
;   0x60c4..0x60ce  (10 bytes)
DATA_salas_e610_mapa_1:
	defb 018h,023h,030h,035h,045h,04bh,04dh,065h,069h,000h	; 60c4  .#05EKMei.

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_2: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 2, acabadas en 0; lo leen p04:60A1 (3 bytes)
;   0x60ce..0x60d1  (3 bytes)
DATA_salas_e610_mapa_2:
	defb 00ah,00ch,000h	; 60ce

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_3: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 3, acabadas en 0; lo leen p04:60A1 (4 bytes)
;   0x60d1..0x60d5  (4 bytes)
DATA_salas_e610_mapa_3:
	defb 007h,00dh,00eh,000h	; 60d1

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_4: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 4, acabadas en 0; lo leen p04:60A1 (3 bytes)
;   0x60d5..0x60d8  (3 bytes)
DATA_salas_e610_mapa_4:
	defb 00ch,00fh,000h	; 60d5

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_5: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 5, acabadas en 0; lo leen p04:60A1 (3 bytes)
;   0x60d8..0x60db  (3 bytes)
DATA_salas_e610_mapa_5:
	defb 008h,00bh,000h	; 60d8

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_6: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 6, acabadas en 0; lo leen p04:60A1 (3 bytes)
;   0x60db..0x60de  (3 bytes)
DATA_salas_e610_mapa_6:
	defb 003h,00eh,000h	; 60db

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_7: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 7, acabadas en 0; lo leen p04:60A1 (4 bytes)
;   0x60de..0x60e2  (4 bytes)
DATA_salas_e610_mapa_7:
	defb 005h,00bh,00fh,000h	; 60de

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_8: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 8, acabadas en 0; lo leen p04:60A1 (4 bytes)
;   0x60e2..0x60e6  (4 bytes)
DATA_salas_e610_mapa_8:
	defb 008h,00fh,012h,000h	; 60e2

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_9: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 9, acabadas en 0; lo leen p04:60A1 (4 bytes)
;   0x60e6..0x60ea  (4 bytes)
DATA_salas_e610_mapa_9:
	defb 003h,008h,014h,000h	; 60e6

; ----------------------------------------------------------------------
; DATOS salas_e610_mapa_10: las salas en las que p04:6091 pone 0xE610 a 1 del
;   mapa 10, acabadas en 0; se solapan 3 bloques (0x60EA-0x60EF,
;   0x60EE-0x6104, 0x60EF-0x60F0); lo leen p04:6066, p04:60A1 (26 bytes)
;   0x60ea..0x6104  (26 bytes)
DATA_salas_e610_mapa_10:
	defb 002h,00ah,012h,01ah,000h,000h,004h,061h,038h,061h,03eh,061h,043h,061h,04ah,061h	; 60ea  .......a8a>aCaJa
	defb 055h,061h,05fh,061h,069h,061h,070h,061h,079h,061h	; 60fa  Ua_aiapaya

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_1: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 1, acabadas en 0; lo leen p04:6066 (52
;   bytes)
;   0x6104..0x6138  (52 bytes)
DATA_salas_e612_mapa_1:
	defb 00ch,00eh,014h,016h,017h,018h,01ah,01dh,021h,023h,025h,028h,02bh,02ch,02dh,02eh	; 6104  ........!#%(+,-.
	defb 030h,031h,035h,03ch,03dh,040h,043h,045h,04bh,04dh,04fh,051h,052h,055h,058h,059h	; 6114  015<=@CEKMOQRUXY
	defb 05ch,05dh,063h,065h,067h,069h,06ah,06bh,06dh,06fh,074h,076h,077h,07eh,07fh,081h	; 6124  \]cegijkmotvw~..
	defb 085h,08dh,08eh,000h	; 6134

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_2: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 2, acabadas en 0; lo leen p04:6066 (6
;   bytes)
;   0x6138..0x613e  (6 bytes)
DATA_salas_e612_mapa_2:
	defb 002h,003h,005h,00ah,00dh,000h	; 6138

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_3: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 3, acabadas en 0; lo leen p04:6066 (5
;   bytes)
;   0x613e..0x6143  (5 bytes)
DATA_salas_e612_mapa_3:
	defb 002h,003h,005h,006h,000h	; 613e

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_4: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 4, acabadas en 0; lo leen p04:6066 (7
;   bytes)
;   0x6143..0x614a  (7 bytes)
DATA_salas_e612_mapa_4:
	defb 002h,004h,005h,008h,00ah,010h,000h	; 6143

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_5: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 5, acabadas en 0; lo leen p04:6066 (11
;   bytes)
;   0x614a..0x6155  (11 bytes)
DATA_salas_e612_mapa_5:
	defb 002h,003h,004h,006h,007h,008h,009h,00bh,00dh,00eh,000h	; 614a  ...........

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_6: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 6, acabadas en 0; lo leen p04:6066 (10
;   bytes)
;   0x6155..0x615f  (10 bytes)
DATA_salas_e612_mapa_6:
	defb 002h,003h,004h,005h,006h,00bh,00ch,00eh,00fh,000h	; 6155  ..........

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_7: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 7, acabadas en 0; lo leen p04:6066 (10
;   bytes)
;   0x615f..0x6169  (10 bytes)
DATA_salas_e612_mapa_7:
	defb 003h,005h,006h,009h,00ah,00ch,00eh,00fh,010h,000h	; 615f  ..........

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_8: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 8, acabadas en 0; lo leen p04:6066 (7
;   bytes)
;   0x6169..0x6170  (7 bytes)
DATA_salas_e612_mapa_8:
	defb 002h,003h,004h,007h,008h,00dh,000h	; 6169

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_9: las salas en las que p04:6054 pone 0xE612 a 1 (el 0
;   y el mapa 11 no tienen) del mapa 9, acabadas en 0; lo leen p04:6066 (9
;   bytes)
;   0x6170..0x6179  (9 bytes)
DATA_salas_e612_mapa_9:
	defb 003h,004h,008h,009h,00ah,00bh,00ch,00dh,000h	; 6170  .........

; ----------------------------------------------------------------------
; DATOS salas_e612_mapa_10: las salas en las que p04:6054 pone 0xE612 a 1 (el
;   0 y el mapa 11 no tienen) del mapa 10, acabadas en 0; lo leen p04:6066 (13
;   bytes)
;   0x6179..0x6186  (13 bytes)
DATA_salas_e612_mapa_10:
	defb 002h,008h,00ah,00bh,00dh,00eh,00fh,010h,015h,016h,017h,018h,000h	; 6179  .............

; ======================================================================
; CODIGO 0x6186..0x6336  (432 bytes)
; ======================================================================


L_6186:
	ld hl,0e650h		;6186
	ld de,0e651h		;6189
	ld bc,0001fh		;618c
	ld (hl),000h		;618f
	ldir		;6191
	call L_61E4		;6193
	call L_6200		;6196
	call L_6239		;6199
	call L_6249		;619c
	call L_6291		;619f
	call L_62A4		;61a2
	call L_62B9		;61a5
	ld hl,(0e041h)		;61a8   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;61ab
	cp 007h		;61ac
	ret nz			;61ae
	ld a,h			;61af
	cp 002h		;61b0
	ld c,005h		;61b2
	jr z,L_61D9		;61b4
	cp 003h		;61b6
	ld c,00ah		;61b8
	jr z,L_61D9		;61ba
	cp 004h		;61bc
	ld c,005h		;61be
	jr z,L_61D9		;61c0
	cp 007h		;61c2
	ld c,00ah		;61c4
	jr z,L_61D9		;61c6
	cp 008h		;61c8
	ld c,00ah		;61ca
	jr z,L_61D9		;61cc
	cp 011h		;61ce
	ld c,00ah		;61d0
	jr z,L_61D9		;61d2
	cp 012h		;61d4
	ld c,005h		;61d6
	ret nz			;61d8
L_61D9:
	ld hl,0e668h		;61d9
	ld (hl),001h		;61dc
	inc l			;61de
	ld (hl),c			;61df
	inc l			;61e0
	ld (hl),010h		;61e1
	ret			;61e3
L_61E4:
	ld hl,(0e041h)		;61e4   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;61e7
	dec a			;61e8
	ret nz			;61e9
	ld a,h			;61ea
	cp 03ah		;61eb
	jr z,L_61FA		;61ed
	cp 047h		;61ef
	jr z,L_61FA		;61f1
	cp 071h		;61f3
	jr z,L_61FA		;61f5
	cp 072h		;61f7
	ret nz			;61f9
L_61FA:
	ld a,001h		;61fa
	ld (0e650h),a		;61fc
	ret			;61ff
L_6200:
	ld a,(0e087h)		;6200   ; lee tiene el objeto 0x18
	or a			;6203
	ret nz			;6204
	ld hl,(0e041h)		;6205   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;6208
	dec a			;6209
	jr z,L_622D		;620a
	sub 008h		;620c
	jr z,L_6225		;620e
	dec a			;6210
	jr z,L_621D		;6211
	dec a			;6213
	ret nz			;6214
	ld a,h			;6215
	sub 002h		;6216
	cp 002h		;6218
	ret nc			;621a
	jr L_6233		;621b
L_621D:
	ld a,h			;621d
	sub 003h		;621e
	cp 003h		;6220
	ret nc			;6222
	jr L_6233		;6223
L_6225:
	ld a,h			;6225
	sub 00fh		;6226
	cp 005h		;6228
	ret nc			;622a
	jr L_6233		;622b
L_622D:
	ld a,h			;622d
	sub 090h		;622e
	cp 004h		;6230
	ret nc			;6232
L_6233:
	ld a,001h		;6233
	ld (0e653h),a		;6235
	ret			;6238
L_6239:
	ld hl,(0e041h)		;6239   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	dec l			;623c
	ret nz			;623d
	ld a,h			;623e
	sub 089h		;623f
	cp 004h		;6241
	ret nc			;6243
	inc a			;6244
	ld (0e659h),a		;6245
	ret			;6248
L_6249:
	ld hl,(0e041h)		;6249   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;624c
	dec a			;624d
	jr z,L_6261		;624e
	cp 006h		;6250
	jr z,L_6287		;6252
	cp 004h		;6254
	ret nz			;6256
	ld a,h			;6257
	cp 00ah		;6258
	jr z,L_628B		;625a
	cp 00ch		;625c
	jr z,L_628B		;625e
	ret			;6260
L_6261:
	ld a,h			;6261
	cp 00ah		;6262
	jr z,L_628B		;6264
	cp 011h		;6266
	jr z,L_628B		;6268
	cp 01ch		;626a
	jr z,L_628B		;626c
	cp 038h		;626e
	jr z,L_628B		;6270
	cp 049h		;6272
	jr z,L_628B		;6274
	cp 07ah		;6276
	jr z,L_628B		;6278
	cp 083h		;627a
	jr z,L_628B		;627c
	cp 084h		;627e
	jr z,L_628B		;6280
	cp 050h		;6282
	jr z,L_628B		;6284
	ret			;6286
L_6287:
	ld a,h			;6287
	cp 008h		;6288
	ret nz			;628a
L_628B:
	ld a,001h		;628b
	ld (0e65ch),a		;628d
	ret			;6290
L_6291:
	ld hl,(0e041h)		;6291   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;6294
	cp 006h		;6295
	ret nz			;6297
	ld a,h			;6298
	sub 007h		;6299
	cp 004h		;629b
	ret nc			;629d
	ld a,001h		;629e
	ld (0e65fh),a		;62a0
	ret			;62a3
L_62A4:
	ld hl,(0e041h)		;62a4   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	dec l			;62a7
	ret nz			;62a8
	ld a,h			;62a9
	cp 066h		;62aa
	jr z,L_62B3		;62ac
	sub 05eh		;62ae
	cp 002h		;62b0
	ret nc			;62b2
L_62B3:
	ld a,001h		;62b3
	ld (0e662h),a		;62b5
	ret			;62b8
L_62B9:
	ld hl,(0e041h)		;62b9   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,l			;62bc
	dec a			;62bd
	jr z,L_62CD		;62be
	cp 008h		;62c0
	ret nz			;62c2
	ld a,h			;62c3
	cp 002h		;62c4
	jr z,L_62D5		;62c6
	cp 00eh		;62c8
	jr z,L_62D5		;62ca
	ret			;62cc
L_62CD:
	ld a,h			;62cd
	cp 02fh		;62ce
	jr z,L_62D5		;62d0
	cp 03bh		;62d2
	ret nz			;62d4
L_62D5:
	ld a,001h		;62d5
	ld (0e665h),a		;62d7
	ret			;62da
L_62DB:
	ld a,(0e0d5h)		;62db
	or a			;62de
	ret nz			;62df
	xor a			;62e0
	ld (0e610h),a		;62e1
	call L_634A		;62e4
	call L_6374		;62e7
	call L_639D		;62ea
	call L_63C3		;62ed
	call L_63E9		;62f0
	call L_643A		;62f3
	call L_6460		;62f6
	ld hl,0e650h		;62f9
	bit 0,(hl)		;62fc
	ret z			;62fe
	inc l			;62ff
	ld a,(hl)			;6300
	or a			;6301
	jr z,L_6320		;6302
	inc l			;6304
	dec (hl)			;6305
	ret nz			;6306
	ld (hl),020h		;6307
	dec l			;6309
	dec (hl)			;630a
	ld a,(hl)			;630b
	and 003h		;630c
	ld hl,06336h		;630e
	ld c,a			;6311
	ld b,000h		;6312
	add hl,bc			;6314
	ld e,(hl)			;6315
	ld d,000h		;6316
	ld bc,00000h		;6318
	ld a,009h		;631b
	jp L_65DA		;631d
L_6320:
	ld a,(0e045h)		;6320
	ld de,0633ah		;6323
	call 04065h		;6326   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;6329
	ld (hl),a			;632a
	inc l			;632b
	ld a,(0e045h)		;632c
	add a,a			;632f
	sub 070h		;6330
	neg		;6332
	ld (hl),a			;6334
	ret			;6335

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_6336: 4 bytes que p04:630E elige con los dos bits bajos
;   de un contador de la ficha y usa como parte baja de una direccion (la alta
;   es 0)
;   0x6336..0x633a  (4 bytes)
DATA_cuatro_bytes_6336:
	defb 040h,0c0h,060h,0a0h	; 6336

; ----------------------------------------------------------------------
; DATOS dieciseis_bytes_633a: 16 bytes que p04:6323 lee en 0x633A + (0xE045) y
;   guarda en la ficha
;   0x633a..0x634a  (16 bytes)
DATA_dieciseis_bytes_633a:
	defb 003h,003h,003h,004h,004h,005h,005h,006h,006h,006h,007h,007h,007h,008h,008h,008h	; 633a  ................

; ======================================================================
; CODIGO 0x634a..0x6426  (220 bytes)
; ======================================================================


L_634A:
	ld hl,0e653h		;634a
	bit 0,(hl)		;634d
	ret z			;634f
	inc l			;6350
	ld a,(hl)			;6351
	or a			;6352
	jr z,L_636A		;6353
	inc l			;6355
	dec (hl)			;6356
	ret nz			;6357
	dec l			;6358
	dec (hl)			;6359
	ld a,(0e041h)		;635a   ; lee el mapa (1 el castillo, 2-11 los mundos)
	cp 009h		;635d
	ld d,0a0h		;635f
	jr nz,L_6365		;6361
	ld d,0b0h		;6363
L_6365:
	ld a,008h		;6365
	jp L_65DA		;6367
L_636A:
	inc (hl)			;636a
	inc l			;636b
	ld a,r		;636c
	and 03fh		;636e
	add a,030h		;6370
	ld (hl),a			;6372
	ret			;6373
L_6374:
	ld a,(0e511h)		;6374
	and a			;6377
	ret nz			;6378
	ld hl,0e659h		;6379
	ld a,(hl)			;637c
	and a			;637d
	ret z			;637e
	ld b,a			;637f
	inc l			;6380
	ld a,(hl)			;6381
	or a			;6382
	jr z,L_6391		;6383
	inc l			;6385
	dec (hl)			;6386
	ret nz			;6387
	dec l			;6388
	dec (hl)			;6389
	ld d,090h		;638a
	ld a,00dh		;638c
	jp L_65DA		;638e
L_6391:
	inc (hl)			;6391
	ld a,(0e045h)		;6392
	add a,a			;6395
	sub 090h		;6396
	neg		;6398
	inc l			;639a
	ld (hl),a			;639b
	ret			;639c
L_639D:
	ld hl,0e65ch		;639d
	bit 0,(hl)		;63a0
	ret z			;63a2
	inc l			;63a3
	ld a,(hl)			;63a4
	or a			;63a5
	jr z,L_63B7		;63a6
	inc l			;63a8
	dec (hl)			;63a9
	ret nz			;63aa
	dec l			;63ab
	dec (hl)			;63ac
	ld d,000h		;63ad
	ld bc,00000h		;63af
	ld a,021h		;63b2
	jp L_65DA		;63b4
L_63B7:
	inc (hl)			;63b7
	ld a,(0e045h)		;63b8
	add a,a			;63bb
	sub 090h		;63bc
	neg		;63be
	inc l			;63c0
	ld (hl),a			;63c1
	ret			;63c2
L_63C3:
	ld hl,0e65fh		;63c3
	bit 0,(hl)		;63c6
	ret z			;63c8
	inc l			;63c9
	ld a,(hl)			;63ca
	or a			;63cb
	jr z,L_63DD		;63cc
	inc l			;63ce
	dec (hl)			;63cf
	ret nz			;63d0
	dec l			;63d1
	dec (hl)			;63d2
	ld d,090h		;63d3
	ld bc,00000h		;63d5
	ld a,030h		;63d8
	jp L_65DA		;63da
L_63DD:
	inc (hl)			;63dd
	ld a,(0e045h)		;63de
	add a,a			;63e1
	sub 090h		;63e2
	neg		;63e4
	inc l			;63e6
	ld (hl),a			;63e7
	ret			;63e8
L_63E9:
	ld hl,0e662h		;63e9
	bit 0,(hl)		;63ec
	ret z			;63ee
	inc l			;63ef
	ld a,(hl)			;63f0
	or a			;63f1
	jr z,L_6410		;63f2
	inc l			;63f4
	dec (hl)			;63f5
	ret nz			;63f6
	ld (hl),020h		;63f7
	dec l			;63f9
	dec (hl)			;63fa
	ld a,(hl)			;63fb
	and 003h		;63fc
	ld hl,06426h		;63fe
	ld c,a			;6401
	ld b,000h		;6402
	add hl,bc			;6404
	ld e,(hl)			;6405
	ld d,0b0h		;6406
	ld bc,00000h		;6408
	ld a,038h		;640b
	jp L_65DA		;640d
L_6410:
	ld a,(0e045h)		;6410
	ld de,0642ah		;6413
	call 04065h		;6416   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;6419
	ld (hl),a			;641a
	inc l			;641b
	ld a,(0e045h)		;641c
	add a,a			;641f
	sub 070h		;6420
	neg		;6422
	ld (hl),a			;6424
	ret			;6425

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_6426: 4 bytes, como los de 0x6336, que p04:63FE usa como
;   parte baja de una direccion con la alta 0xB0
;   0x6426..0x642a  (4 bytes)
DATA_cuatro_bytes_6426:
	defb 040h,0c0h,060h,0a0h	; 6426

; ----------------------------------------------------------------------
; DATOS dieciseis_bytes_642a: 16 bytes, como los de 0x633A, que p04:6413 lee
;   en 0x642A + (0xE045)
;   0x642a..0x643a  (16 bytes)
DATA_dieciseis_bytes_642a:
	defb 003h,003h,003h,004h,004h,005h,005h,006h,006h,006h,007h,007h,007h,008h,008h,008h	; 642a  ................

; ======================================================================
; CODIGO 0x643a..0x647c  (66 bytes)
; ======================================================================


L_643A:
	ld hl,0e665h		;643a
	bit 0,(hl)		;643d
	ret z			;643f
	inc l			;6440
	ld a,(hl)			;6441
	or a			;6442
	jr z,L_6454		;6443
	inc l			;6445
	dec (hl)			;6446
	ret nz			;6447
	dec l			;6448
	dec (hl)			;6449
	ld d,000h		;644a
	ld bc,00000h		;644c
	ld a,035h		;644f
	jp L_65DA		;6451
L_6454:
	inc (hl)			;6454
	ld a,(0e045h)		;6455
	add a,a			;6458
	sub 090h		;6459
	neg		;645b
	inc l			;645d
	ld (hl),a			;645e
	ret			;645f
L_6460:
	ld hl,0e668h		;6460
	bit 0,(hl)		;6463
	ret z			;6465
	inc l			;6466
	ld a,(hl)			;6467
	or a			;6468
	ret z			;6469
	inc l			;646a
	dec (hl)			;646b
	ret nz			;646c
	ld (hl),010h		;646d
	dec l			;646f
	dec (hl)			;6470
	ld de,03040h		;6471
	ld bc,00000h		;6474
	ld a,03eh		;6477
	jp L_65DA		;6479

; ----------------------------------------------------------------------
; DATOS byte_por_tipo_647c: un byte por tipo de figura 1-107 que p06:B54B lee
;   en 0x647B + (0xE6C7) (p00:4155): 4 hace que p06:B548 salga con acarreo
;   0x647c..0x64e6  (106 bytes)
DATA_byte_por_tipo_647c:
	defb 000h,000h,000h,002h,000h,004h,000h,004h,004h,001h,001h,000h,001h,000h,001h,001h	; 647c  ................
	defb 001h,001h,000h,001h,003h,003h,002h,000h,003h,004h,004h,002h,004h,004h,001h,001h	; 648c  ................
	defb 001h,003h,004h,002h,002h,003h,000h,000h,004h,003h,003h,004h,001h,000h,002h,002h	; 649c  ................
	defb 004h,004h,004h,001h,004h,004h,004h,002h,003h,004h,004h,003h,004h,003h,004h,003h	; 64ac  ................
	defb 004h,003h,003h,004h,004h,004h,004h,004h,004h,004h,004h,003h,004h,004h,004h,004h	; 64bc  ................
	defb 004h,004h,003h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; 64cc  ................
	defb 004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; 64dc  ..........

; ----------------------------------------------------------------------
; DATOS byte_por_tipo_64e6: otro byte por tipo 1-107 que p06:B55D lee en
;   0x64E5 + (0xE6C7) y agrupa de tres en tres (0-2, 3-5, 6-8, 9 y mas)
;   0x64e6..0x6551  (107 bytes)
DATA_byte_por_tipo_64e6:
	defb 008h,005h,001h,002h,007h,012h,003h,004h,003h,003h,00ah,007h,001h,001h,005h,002h	; 64e6  ................
	defb 002h,004h,006h,006h,00ah,008h,004h,002h,001h,003h,001h,002h,001h,001h,004h,003h	; 64f6  ................
	defb 002h,008h,000h,003h,003h,003h,008h,001h,005h,001h,00ah,002h,003h,002h,001h,005h	; 6506  ................
	defb 002h,000h,001h,006h,003h,006h,000h,001h,00eh,000h,002h,005h,002h,003h,000h,00ch	; 6516  ................
	defb 004h,014h,00ah,002h,004h,002h,002h,001h,008h,002h,001h,007h,001h,000h,000h,000h	; 6526  ................
	defb 000h,002h,001h,001h,001h,002h,006h,004h,001h,000h,000h,000h,000h,000h,000h,002h	; 6536  ................
	defb 002h,008h,000h,002h,004h,008h,00ch,00ah,007h,000h,000h	; 6546  ...........

; ======================================================================
; CODIGO 0x6551..0x6584  (51 bytes)
; ======================================================================


L_6551:
	push ix		;6551
	ld (0f014h),hl		;6553
	ld hl,00000h		;6556
	ld (0f012h),hl		;6559
	call L_65E3		;655c
	pop ix		;655f
	ret			;6561
L_6562:
	xor a			;6562
	ld (0e611h),a		;6563
	ld a,(0e610h)		;6566
	or a			;6569
	ret z			;656a
	ld a,(0f019h)		;656b
	ld b,017h		;656e
	ld hl,06584h		;6570
L_6573:
	cp (hl)			;6573
	jr z,L_657A		;6574
	inc hl			;6576
	djnz L_6573		;6577
	ret			;6579
L_657A:
	ld hl,0e622h		;657a
	inc (hl)			;657d
	ld a,001h		;657e
	ld (0e611h),a		;6580
	ret			;6583

; ----------------------------------------------------------------------
; DATOS tipos_6584: 23 tipos de figura que p04:6570 recorre buscando el que se
;   crea (0xF019)
;   0x6584..0x659b  (23 bytes)
DATA_tipos_6584:
	defb 02fh,02dh,024h,00fh,02eh,022h,00ch,00eh,043h,010h,02ah,04ch,016h,01fh,013h,040h	; 6584  /-$.."..C.*L...@
	defb 015h,00ah,034h,014h,012h,007h,017h	; 6594

; ======================================================================
; CODIGO 0x659b..0x65bc  (33 bytes)
; ======================================================================


L_659B:
	xor a			;659b
	ld (0e625h),a		;659c
	ld a,(0e097h)		;659f   ; lee el nivel de los objetos 0x28/0x2B/0x2C
	dec a			;65a2
	ret m			;65a3
	ld hl,065bch		;65a4
	call 04053h		;65a7   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ex de,hl			;65aa
	ld a,(0f019h)		;65ab
	ld b,a			;65ae
L_65AF:
	ld a,(hl)			;65af
	or a			;65b0
	ret z			;65b1
	inc hl			;65b2
	cp b			;65b3
	jr nz,L_65AF		;65b4
	ld a,080h		;65b6
	ld (0e625h),a		;65b8
	ret			;65bb

; ----------------------------------------------------------------------
; DATOS tabla_65bc: 3 punteros que p04:65A4 elige con (0xE097) - 1 a listas de
;   tipos acabadas en 0; si el tipo que se crea esta, 0xE625 = 0x80
;   0x65bc..0x65c2  (6 bytes)
DATA_tabla_65bc:
	defb 0d2h,065h	; 65bc
	defb 0c9h,065h	; 65be
	defb 0c2h,065h	; 65c0

; ----------------------------------------------------------------------
; DATOS tipos_65c2: las tres listas de 0x65BC, una dentro de otra (empiezan en
;   0x65C2, 0x65C9 y 0x65D2 y acaban en el mismo 0)
;   0x65c2..0x65da  (24 bytes)
DATA_tipos_65c2:
	defb 058h,065h,054h,055h,059h,068h,065h,041h,045h,046h,061h,048h,04ah,04dh,04bh,03dh	; 65c2  XeTUYheAEFaHJMK=
	defb 044h,03fh,01ah,01dh,047h,01eh,056h,000h	; 65d2  D?..G.V.

; ======================================================================
; CODIGO 0x65da..0x66b4  (218 bytes)
; ======================================================================


L_65DA:
	ld hl,00000h		;65da
	ld (0f012h),hl		;65dd
	ld (0f014h),hl		;65e0
L_65E3:
	ld (0f019h),a		;65e3
	ld (0f01ah),de		;65e6
	ld a,b			;65ea
	ld (0e624h),a		;65eb
	ld a,(0e635h)		;65ee   ; lee cuantos huecos de figura hay
	ld b,a			;65f1
	ld a,(0e620h)		;65f2
	cp b			;65f5
	ret nc			;65f6
	ld a,(0f019h)		;65f7
	ld l,a			;65fa
	call L_67AF		;65fb
	ld (0f01ch),hl		;65fe
	ld a,(hl)			;6601
	bit 7,a		;6602
	jr z,L_6622		;6604
	and 007h		;6606
	ld c,a			;6608
	ld a,(0e636h)		;6609
	inc a			;660c
	ld b,a			;660d
	ld a,(0e621h)		;660e
	add a,c			;6611
	cp b			;6612
	ret nc			;6613
	call L_678D		;6614
	ret nz			;6617
	ld a,(0e621h)		;6618
	add a,c			;661b
	ld (0e621h),a		;661c
	jp L_6626		;661f
L_6622:
	call L_678D		;6622
	ret nz			;6625
L_6626:
	push hl			;6626
	pop ix		;6627
	ld (0f020h),hl		;6629
	ld hl,0e620h		;662c
	inc (hl)			;662f
	call L_6562		;6630
	call L_659B		;6633
	ld hl,(0f020h)		;6636
	ld a,(0f019h)		;6639
	ld (hl),a			;663c
	inc l			;663d
	ld (hl),000h		;663e
	inc l			;6640
	ld a,(0e611h)		;6641
	or a			;6644
	ld b,0f0h		;6645
	jr z,L_664B		;6647
	ld b,0f8h		;6649
L_664B:
	ld (hl),b			;664b
	inc l			;664c
	ld a,(0e612h)		;664d
	or a			;6650
	jr z,L_6659		;6651
	ld a,(0e613h)		;6653
	dec a			;6656
	or 008h		;6657
L_6659:
	ld b,a			;6659
	ld a,(0e625h)		;665a
	or b			;665d
	ld (hl),a			;665e
	inc l			;665f
	ld (hl),000h		;6660
	ld de,(0f01ah)		;6662
	inc l			;6666
	ld (hl),d			;6667
	inc l			;6668
	ld (hl),000h		;6669
	inc l			;666b
	ld (hl),e			;666c
	inc l			;666d
	ld (hl),000h		;666e
	inc l			;6670
	ex de,hl			;6671
	ld hl,(0f01ch)		;6672
	ldi		;6675
	ldi		;6677
	ldi		;6679
	ex de,hl			;667b
	ld bc,(0f012h)		;667c
	ld (hl),c			;6680
	inc l			;6681
	ld (hl),b			;6682
	inc l			;6683
	ld bc,(0f014h)		;6684
	ld (hl),c			;6688
	inc l			;6689
	ld (hl),b			;668a
	inc l			;668b
	ex de,hl			;668c
	ldi		;668d
	ldi		;668f
	xor a			;6691
	ld b,00eh		;6692
L_6694:
	ld (de),a			;6694
	inc e			;6695
	djnz L_6694		;6696
	ld a,(ix+010h)		;6698
	inc a			;669b
	jr nz,L_66A2		;669c
	res 5,(ix+002h)		;669e
L_66A2:
	inc a			;66a2
	jr nz,L_66A9		;66a3
	set 2,(ix+002h)		;66a5
L_66A9:
	ld hl,0678bh		;66a9
	push hl			;66ac
	ld a,(0f019h)		;66ad
	dec a			;66b0
	call 04050h		;66b1   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_66B4: 107 destinos del despachador de 0x4140 (call en p04:66B1):
;   0x7950, 0x6CDB, 0xABFE, 0x6F5D, 0x6AE8, 0x7679, 0xA830, 0x6DFE ...; lo
;   leen p04:66B1 (214 bytes)
;   0x66b4..0x678a  (214 bytes)
DATA_tabla_66B4:
	defb 050h,079h	; 66b4
	defb 0dbh,06ch	; 66b6
	defb 0feh,0abh	; 66b8
	defb 05dh,06fh	; 66ba
	defb 0e8h,06ah	; 66bc
	defb 079h,076h	; 66be
	defb 030h,0a8h	; 66c0
	defb 0feh,06dh	; 66c2
	defb 00dh,070h	; 66c4
	defb 00dh,07bh	; 66c6
	defb 093h,07ah	; 66c8
	defb 097h,09dh	; 66ca
	defb 04bh,078h	; 66cc
	defb 018h,07dh	; 66ce
	defb 047h,073h	; 66d0
	defb 0c9h,071h	; 66d2
	defb 0bah,073h	; 66d4
	defb 097h,070h	; 66d6
	defb 0e2h,0a3h	; 66d8
	defb 049h,072h	; 66da
	defb 005h,08eh	; 66dc
	defb 01fh,08ch	; 66de
	defb 01ch,095h	; 66e0
	defb 050h,06ch	; 66e2
	defb 03dh,086h	; 66e4
	defb 032h,06ch	; 66e6
	defb 0c2h,06eh	; 66e8
	defb 055h,06fh	; 66ea
	defb 042h,06ch	; 66ec
	defb 0ech,08ch	; 66ee
	defb 02fh,094h	; 66f0
	defb 0d4h,093h	; 66f2
	defb 089h,07eh	; 66f4
	defb 0c0h,080h	; 66f6
	defb 098h,0a1h	; 66f8
	defb 030h,09bh	; 66fa
	defb 0c0h,098h	; 66fc
	defb 02ah,0a4h	; 66fe
	defb 035h,089h	; 6700
	defb 057h,093h	; 6702
	defb 0bah,092h	; 6704
	defb 09ah,096h	; 6706
	defb 0dah,087h	; 6708
	defb 074h,0a9h	; 670a
	defb 025h,097h	; 670c
	defb 070h,0a0h	; 670e
	defb 0feh,091h	; 6710
	defb 02eh,07fh	; 6712
	defb 032h,08bh	; 6714
	defb 078h,090h	; 6716
	defb 043h,091h	; 6718
	defb 0f4h,0aah	; 671a
	defb 088h,0abh	; 671c
	defb 039h,08ah	; 671e
	defb 081h,086h	; 6720
	defb 0a8h,0a7h	; 6722
	defb 0dfh,0a8h	; 6724
	defb 059h,091h	; 6726
	defb 0e0h,091h	; 6728
	defb 04ch,0aeh	; 672a
	defb 0c4h,0aeh	; 672c
	defb 083h,0a2h	; 672e
	defb 090h,098h	; 6730
	defb 004h,08dh	; 6732
	defb 07fh,08dh	; 6734
	defb 08dh,083h	; 6736
	defb 0d5h,084h	; 6738
	defb 01eh,09fh	; 673a
	defb 0bah,08fh	; 673c
	defb 0e6h,08ch	; 673e
	defb 0ach,095h	; 6740
	defb 042h,06ch	; 6742
	defb 0e3h,0a0h	; 6744
	defb 0fbh,080h	; 6746
	defb 048h,0a5h	; 6748
	defb 0cah,08fh	; 674a
	defb 0f7h,08fh	; 674c
	defb 02ah,082h	; 674e
	defb 0f9h,082h	; 6750
	defb 059h,091h	; 6752
	defb 078h,090h	; 6754
	defb 0f1h,0a0h	; 6756
	defb 0f1h,0a0h	; 6758
	defb 0edh,06eh	; 675a
	defb 005h,0adh	; 675c
	defb 01eh,09fh	; 675e
	defb 051h,0adh	; 6760
	defb 0b2h,0adh	; 6762
	defb 003h,0aeh	; 6764
	defb 0bah,074h	; 6766
	defb 005h,06ah	; 6768
	defb 0beh,0aah	; 676a
	defb 0aah,06ah	; 676c
	defb 0aah,06ah	; 676e
	defb 0aah,06ah	; 6770
	defb 058h,084h	; 6772
	defb 0c5h,084h	; 6774
	defb 044h,085h	; 6776
	defb 0c4h,06ah	; 6778
	defb 0a3h,0aah	; 677a
	defb 060h,0a5h	; 677c
	defb 08ah,067h	; 677e
	defb 0e0h,0a5h	; 6780
	defb 03fh,09fh	; 6782
	defb 0bbh,074h	; 6784
	defb 037h,079h	; 6786
	defb 0b5h,0aah	; 6788

; ======================================================================
; CODIGO 0x678a..0x67bb  (49 bytes)
; ======================================================================


L_678A:
	ret			;678a
L_678B:
	scf			;678b
	ret			;678c
L_678D:
	ld a,(0f019h)		;678d
	cp 043h		;6790
	jr z,L_67A5		;6792
	ld hl,0e800h		;6794   ; apunta a los huecos de figura (32 bytes cada uno)
	ld a,(0e635h)		;6797   ; lee cuantos huecos de figura hay
L_679A:
	ld b,a			;679a
	ld de,00020h		;679b
	xor a			;679e
L_679F:
	cp (hl)			;679f
	ret z			;67a0
	add hl,de			;67a1
	djnz L_679F		;67a2
	ret			;67a4
L_67A5:
	ld hl,0e900h		;67a5
	ld a,(0e635h)		;67a8   ; lee cuantos huecos de figura hay
	sub 008h		;67ab
	jr L_679A		;67ad
L_67AF:
	ld c,l			;67af
	ld h,000h		;67b0
	ld b,h			;67b2
	add hl,hl			;67b3
	add hl,hl			;67b4
	add hl,bc			;67b5
L_67B6:
	ld bc,l67b6h		;67b6
	add hl,bc			;67b9
	ret			;67ba

; ----------------------------------------------------------------------
; DATOS fichas_de_tipo: 5 bytes por tipo de figura 1-107 (p04:67AF: 0x67B6 + 5
;   x tipo): el primero dice en el bit 7 si cuenta como grupo (bits 0-2
;   cuantos, p04:6602); los tres primeros van a (ix+9)-(ix+0x0B) y los dos
;   ultimos a (ix+0x10) y (ix+0x11), el indice de las fichas de choque del
;   banco 14
;   0x67bb..0x69d2  (535 bytes)
DATA_fichas_de_tipo:
	defb 0a2h,0a0h,008h,004h,000h	; 67bb
	defb 081h,0a0h,00fh,001h,075h	; 67c0
	defb 081h,0c4h,008h,001h,005h	; 67c5
	defb 040h,000h,000h,001h,022h	; 67ca
	defb 081h,0a0h,007h,003h,02ah	; 67cf
	defb 081h,0a0h,008h,0ffh,010h	; 67d4
	defb 081h,0a0h,009h,002h,026h	; 67d9
	defb 082h,0cch,009h,0ffh,04dh	; 67de
	defb 081h,0c4h,00eh,0feh,013h	; 67e3
	defb 08ah,0b0h,007h,006h,04eh	; 67e8
	defb 081h,0a0h,007h,001h,03eh	; 67ed
	defb 081h,0b0h,008h,003h,051h	; 67f2
	defb 081h,0c8h,009h,001h,000h	; 67f7
	defb 081h,0ach,001h,001h,069h	; 67fc
	defb 081h,0a0h,00ah,006h,032h	; 6801
	defb 081h,0a0h,007h,001h,00bh	; 6806
	defb 081h,0a4h,00bh,002h,058h	; 680b
	defb 081h,0ach,00eh,005h,013h	; 6810
	defb 081h,0a0h,00fh,004h,02dh	; 6815
	defb 081h,0a0h,00eh,004h,038h	; 681a
	defb 0c4h,008h,005h,028h,042h	; 681f
	defb 0c4h,000h,002h,018h,001h	; 6824
	defb 081h,0c8h,00ah,005h,013h	; 6829
	defb 081h,0a0h,009h,001h,01eh	; 682e
	defb 081h,0d0h,00bh,001h,04ah	; 6833
	defb 081h,0ach,009h,001h,005h	; 6838
	defb 081h,0c8h,00ah,001h,005h	; 683d
	defb 040h,000h,000h,001h,022h	; 6842
	defb 081h,0a0h,00bh,0ffh,005h	; 6847
	defb 081h,0a0h,00eh,0ffh,00ah	; 684c
	defb 081h,0a0h,002h,003h,000h	; 6851
	defb 081h,0a0h,001h,0feh,019h	; 6856
	defb 081h,0a0h,00bh,002h,058h	; 685b
	defb 081h,0c8h,003h,018h,009h	; 6860
	defb 09ah,0a0h,00eh,040h,06ch	; 6865
	defb 081h,0a0h,009h,003h,000h	; 686a
	defb 082h,0ach,00fh,008h,04eh	; 686f
	defb 081h,0c4h,00ah,00ah,012h	; 6874
	defb 081h,0c4h,007h,00ch,011h	; 6879
	defb 081h,0c4h,00fh,001h,062h	; 687e
	defb 081h,0c4h,00fh,0ffh,00eh	; 6883
	defb 081h,0c4h,00fh,003h,000h	; 6888
	defb 081h,0c4h,005h,003h,013h	; 688d
	defb 081h,0a0h,00eh,004h,00bh	; 6892
	defb 081h,0a0h,00fh,002h,00ch	; 6897
	defb 081h,0c4h,003h,002h,026h	; 689c
	defb 081h,0c4h,002h,005h,000h	; 68a1
	defb 08ah,0c4h,009h,005h,041h	; 68a6
	defb 081h,0c4h,00fh,0ffh,01bh	; 68ab
	defb 000h,004h,000h,0feh,079h	; 68b0
	defb 081h,0c4h,00fh,001h,05fh	; 68b5
	defb 081h,0c4h,00ah,004h,022h	; 68ba
	defb 081h,0c4h,00eh,0feh,013h	; 68bf
	defb 081h,0c4h,008h,0feh,012h	; 68c4
	defb 0c4h,00eh,00eh,008h,03dh	; 68c9
	defb 081h,0c4h,008h,001h,066h	; 68ce
	defb 081h,0c4h,00fh,028h,04ch	; 68d3
	defb 000h,000h,000h,0feh,000h	; 68d8
	defb 081h,0c4h,009h,001h,061h	; 68dd
	defb 081h,0c8h,00fh,007h,013h	; 68e2
	defb 081h,0c4h,00fh,001h,014h	; 68e7
	defb 081h,0c4h,00ah,002h,00fh	; 68ec
	defb 081h,0a8h,00fh,0ffh,005h	; 68f1
	defb 0c5h,004h,003h,023h,039h	; 68f6
	defb 081h,0a4h,00ah,0ffh,000h	; 68fb
	defb 0c4h,0c4h,00bh,00ah,03ch	; 6900
	defb 08ah,0d0h,002h,00ah,041h	; 6905
	defb 081h,0b4h,009h,0ffh,01ah	; 690a
	defb 081h,0a0h,00ah,0ffh,044h	; 690f
	defb 081h,0a0h,00ah,0ffh,044h	; 6914
	defb 0c4h,0c0h,00fh,0ffh,05ch	; 6919
	defb 081h,0d8h,00bh,0ffh,04ah	; 691e
	defb 08ah,0b4h,001h,005h,06ah	; 6923
	defb 081h,0cch,00bh,0ffh,00ah	; 6928
	defb 081h,0c4h,00ah,0ffh,00ah	; 692d
	defb 0c4h,006h,004h,014h,03dh	; 6932
	defb 081h,0c0h,001h,0ffh,054h	; 6937
	defb 081h,0a0h,00fh,000h,000h	; 693c
	defb 082h,0a4h,00fh,000h,000h	; 6941
	defb 000h,002h,000h,0feh,000h	; 6946
	defb 000h,005h,000h,0feh,079h	; 694b
	defb 081h,0ach,001h,003h,069h	; 6950
	defb 081h,0a4h,001h,001h,056h	; 6955
	defb 081h,0a0h,00fh,005h,000h	; 695a
	defb 081h,0a8h,00fh,001h,000h	; 695f
	defb 081h,0a0h,009h,001h,051h	; 6964
	defb 040h,000h,001h,0ffh,000h	; 6969
	defb 081h,0a0h,007h,001h,06fh	; 696e
	defb 081h,0a0h,008h,001h,070h	; 6973
	defb 081h,0a0h,002h,001h,06eh	; 6978
	defb 081h,090h,00fh,0ffh,000h	; 697d
	defb 000h,039h,000h,005h,000h	; 6982
	defb 040h,060h,007h,000h,000h	; 6987
	defb 040h,064h,007h,000h,000h	; 698c
	defb 040h,068h,007h,000h,000h	; 6991
	defb 0c7h,0d8h,00ah,004h,000h	; 6996
	defb 081h,0dch,007h,0ffh,00ah	; 699b
	defb 086h,0c4h,008h,004h,000h	; 69a0
	defb 0c4h,00ch,00dh,0ffh,000h	; 69a5
	defb 081h,0a0h,00eh,004h,000h	; 69aa
	defb 081h,0a0h,00fh,001h,071h	; 69af
	defb 081h,0a0h,002h,0ffh,06fh	; 69b4
	defb 081h,0a0h,008h,010h,055h	; 69b9
	defb 081h,0a0h,002h,001h,000h	; 69be
	defb 081h,0bch,00fh,0ffh,00eh	; 69c3
	defb 081h,0c4h,00fh,0ffh,00bh	; 69c8
	defb 000h,017h,000h,000h,000h	; 69cd

; ======================================================================
; CODIGO 0x69d2..0x69fb  (41 bytes)
; ======================================================================


L_69D2:
	ld hl,0e63fh		;69d2
	ld a,(hl)			;69d5
	or a			;69d6
	ret z			;69d7
	dec (hl)			;69d8
	ld a,(hl)			;69d9
	and 00fh		;69da
	ret nz			;69dc
	ld a,(hl)			;69dd
	rra			;69de
	rra			;69df
	rra			;69e0
	and 00eh		;69e1
	ld c,a			;69e3
	ld b,000h		;69e4
	ld hl,069fbh		;69e6
	add hl,bc			;69e9
	ld de,(0e6c0h)		;69ea
	ld a,e			;69ee
	add a,(hl)			;69ef
	ld e,a			;69f0
	inc hl			;69f1
	ld a,d			;69f2
	add a,(hl)			;69f3
	ld d,e			;69f4
	ld e,a			;69f5
	ld a,05bh		;69f6
	jp L_6551		;69f8

; ----------------------------------------------------------------------
; DATOS parejas_69fb: 10 bytes en parejas que p04:69E6 suma a la posicion de
;   0xE6C0 segun un contador de la ficha
;   0x69fb..0x6a05  (10 bytes)
DATA_parejas_69fb:
	defb 000h,000h	; 69fb
	defb 010h,010h	; 69fd
	defb 010h,000h	; 69ff
	defb 000h,010h	; 6a01
	defb 008h,008h	; 6a03

; ======================================================================
; CODIGO 0x6a05..0x6a31  (44 bytes)
; ======================================================================


L_6A05:
	ld (ix+008h),003h		;6a05
	ld (ix+001h),008h		;6a09
	ld a,(0e6c7h)		;6a0d
	ld (ix+011h),a		;6a10
L_6A13:
	ld (ix+002h),080h		;6a13
	ret			;6a17
L_6A18:
	dec (ix+008h)		;6a18
	ret nz			;6a1b
	dec (ix+001h)		;6a1c
	jr z,$+25		;6a1f
	ld (ix+008h),003h		;6a21
	ld a,(ix+001h)		;6a25
	ld hl,06a30h		;6a28
	call 04083h		;6a2b   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	jp L_7083		;6a2e

; ----------------------------------------------------------------------
; DATOS siete_bytes_6a31: un byte por paso (ix+1) = 1-7 que p04:6A28 lee en
;   0x6A30 + (ix+1) y pasa a p04:7083
;   0x6a31..0x6a38  (7 bytes)
DATA_siete_bytes_6a31:
	defb 094h,090h,098h,094h,090h,098h,094h	; 6a31

; ======================================================================
; CODIGO 0x6a38..0x6a6b  (51 bytes)
; ======================================================================


L_6A38:
	call 0b41ch		;6a38
	ld a,(ix+011h)		;6a3b
	ld (0e6c7h),a		;6a3e
	call 0b548h		;6a41
	ret c			;6a44
	call L_6A77		;6a45
	ld a,c			;6a48
	or a			;6a49
	ret z			;6a4a
	sub 05dh		;6a4b
	add a,a			;6a4d
	add a,a			;6a4e
	ld b,a			;6a4f
	ld a,(0e6c6h)		;6a50
	add a,b			;6a53
	ld hl,06a6bh		;6a54
	call 04083h		;6a57   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld b,a			;6a5a
	ld a,(ix+005h)		;6a5b
	and 0f8h		;6a5e
	ld d,a			;6a60
	ld a,(ix+007h)		;6a61
	and 0f8h		;6a64
	ld e,a			;6a66
	ld a,c			;6a67
	jp L_6551		;6a68

; ----------------------------------------------------------------------
; DATOS doce_bytes_6a6b: 12 bytes que p04:6A54 lee en 0x6A6B + 4 x (tipo -
;   0x5D) + (0xE6C6)
;   0x6a6b..0x6a77  (12 bytes)
DATA_doce_bytes_6a6b:
	defb 010h,020h,030h,040h,001h,004h,007h,010h,001h,001h,002h,002h	; 6a6b  . 0@........

; ======================================================================
; CODIGO 0x6a77..0x6a9e  (39 bytes)
; ======================================================================


L_6A77:
	ld a,(0e6c6h)		;6a77
	ld b,a			;6a7a
	add a,a			;6a7b
	add a,b			;6a7c
	ld c,a			;6a7d
	ld b,000h		;6a7e
	ld hl,06a9eh		;6a80
	add hl,bc			;6a83
	ld c,05eh		;6a84
	ld a,(0e604h)		;6a86   ; lee el contador de cuadros de partida
	ld b,a			;6a89
	ld a,r		;6a8a
	add a,b			;6a8c
	and 00fh		;6a8d
	cp (hl)			;6a8f
	ret c			;6a90
	ld c,05dh		;6a91
	inc hl			;6a93
	cp (hl)			;6a94
	ret c			;6a95
	ld c,05fh		;6a96
	inc hl			;6a98
	cp (hl)			;6a99
	ret c			;6a9a
	ld c,000h		;6a9b
	ret			;6a9d

; ----------------------------------------------------------------------
; DATOS doce_bytes_6a9e: 12 bytes, de tres en tres, que p04:6A80 elige con
;   (0xE6C6) x 3
;   0x6a9e..0x6aaa  (12 bytes)
DATA_doce_bytes_6a9e:
	defb 008h,00ah,00bh,009h,00bh,00ch,00ah,00dh,00fh,00ah,00dh,00fh	; 6a9e  ............

; ======================================================================
; CODIGO 0x6aaa..0x6cc4  (538 bytes)
; ======================================================================


L_6AAA:
	ld (ix+002h),0c0h		;6aaa
	ld l,(ix+005h)		;6aae
	ld h,(ix+007h)		;6ab1
	call 04056h		;6ab4   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+012h),l		;6ab7
	ld (ix+013h),h		;6aba
	ld a,(0e624h)		;6abd
	ld (ix+018h),a		;6ac0
L_6AC3:
	ret			;6ac3
L_6AC4:
	ld (ix+008h),00ah		;6ac4
	jp L_6A13		;6ac8
L_6ACB:
	dec (ix+008h)		;6acb
	ret nz			;6ace
	ld (ix+008h),00ah		;6acf
	inc (ix+001h)		;6ad3
	ld a,(ix+001h)		;6ad6
	cp 004h		;6ad9
	jp nc,0b41ch		;6adb
	bit 0,a		;6ade
	ld a,00ch		;6ae0
	jr z,L_6AE5		;6ae2
	inc a			;6ae4
L_6AE5:
	jp L_7083		;6ae5
L_6AE8:
	ld (ix+015h),078h		;6ae8
	ld a,r		;6aec
	and 001h		;6aee
	ld de,00100h		;6af0
	call nz,04068h		;6af3   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;6af6
L_6AF9:
	bit 7,(ix+00fh)		;6af9
	ld a,0a0h		;6afd
	jr z,L_6B03		;6aff
	ld a,0b0h		;6b01
L_6B03:
	jp L_7083		;6b03
L_6B06:
	ld hl,0b080h		;6b06
	push hl			;6b09
	ld a,(ix+001h)		;6b0a
	dec a			;6b0d
	jr z,L_6B7B		;6b0e
	dec a			;6b10
	jp z,L_6BA9		;6b11
	jp p,L_6BDA		;6b14
	call L_6C25		;6b17
	jr c,L_6B69		;6b1a
	call L_6BEE		;6b1c
	jp nc,L_6B63		;6b1f
	call L_6C04		;6b22
	jp c,L_6B63		;6b25
	dec (ix+015h)		;6b28
	jr z,L_6B4C		;6b2b
L_6B2D:
	inc (ix+01fh)		;6b2d
	ld a,(ix+01fh)		;6b30
	ld b,a			;6b33
	and 007h		;6b34
	ret nz			;6b36
	ld de,0a0a4h		;6b37
	bit 7,(ix+00fh)		;6b3a
	jr z,L_6B43		;6b3e
	ld de,0b0b4h		;6b40
L_6B43:
	bit 3,b		;6b43
	jr z,L_6B48		;6b45
	ld d,e			;6b47
L_6B48:
	ld (ix+00ah),d		;6b48
	ret			;6b4b
L_6B4C:
	ld (ix+015h),00ah		;6b4c
	inc (ix+001h)		;6b50
	call L_6B71		;6b53
L_6B56:
	bit 7,(ix+00fh)		;6b56
	ld a,0a8h		;6b5a
	jr z,L_6B60		;6b5c
	ld a,0b8h		;6b5e
L_6B60:
	jp L_7083		;6b60
L_6B63:
	call 0b15fh		;6b63
	jp L_6AF9		;6b66
L_6B69:
	ld (ix+001h),002h		;6b69
	ld (ix+008h),078h		;6b6d
L_6B71:
	res 4,(ix+002h)		;6b71
	ret			;6b75
L_6B76:
	set 4,(ix+002h)		;6b76
	ret			;6b7a
L_6B7B:
	dec (ix+015h)		;6b7b
	ret nz			;6b7e
	ld (ix+015h),078h		;6b7f
	dec (ix+001h)		;6b83
	call L_6B76		;6b86
	call L_6AF9		;6b89
L_6B8C:
	ld b,000h		;6b8c
	ld hl,00400h		;6b8e
	bit 7,(ix+00fh)		;6b91
	jr z,L_6B9B		;6b95
	inc b			;6b97
	ld hl,0fc00h		;6b98
L_6B9B:
	ld e,(ix+007h)		;6b9b
	ld a,(ix+005h)		;6b9e
	add a,004h		;6ba1
	ld d,a			;6ba3
	ld a,01ah		;6ba4
	jp L_6551		;6ba6
L_6BA9:
	dec (ix+008h)		;6ba9
	jr z,L_6BC7		;6bac
	ld a,(ix+008h)		;6bae
	and 01fh		;6bb1
	jr z,L_6B8C		;6bb3
	ld a,(0e507h)		;6bb5   ; lee la x del personaje
	cp (ix+007h)		;6bb8
	ld de,00100h		;6bbb
	call c,04068h		;6bbe   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;6bc1
	jp L_6B56		;6bc4
L_6BC7:
	ld (ix+001h),003h		;6bc7
	ld (ix+008h),03ch		;6bcb
	call L_6B76		;6bcf
	jp L_6AF9		;6bd2
L_6BD5:
	ld (ix+001h),000h		;6bd5
	ret			;6bd9
L_6BDA:
	dec (ix+008h)		;6bda
	jr z,L_6BD5		;6bdd
	call L_6BEE		;6bdf
	jp nc,L_6B63		;6be2
	call L_6C04		;6be5
	jp c,L_6B63		;6be8
	jp L_6B2D		;6beb
L_6BEE:
	ld a,(ix+005h)		;6bee
	add a,010h		;6bf1
	ld l,a			;6bf3
	bit 7,(ix+00fh)		;6bf4
	ld a,010h		;6bf8
	jr z,L_6BFD		;6bfa
	xor a			;6bfc
L_6BFD:
	add a,(ix+007h)		;6bfd
	ld h,a			;6c00
	jp 0406eh		;6c01   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
L_6C04:
	ld bc,0ffe0h		;6c04
	bit 7,(ix+00fh)		;6c07
	jr nz,L_6C10		;6c0b
	ld bc,0ffe0h		;6c0d
L_6C10:
	add hl,bc			;6c10
	ld a,0b9h		;6c11
	cp (hl)			;6c13
	ret c			;6c14
L_6C15:
	ld a,(ix+007h)		;6c15
	bit 7,(ix+00fh)		;6c18
	jr z,L_6C21		;6c1c
	cp 008h		;6c1e
	ret			;6c20
L_6C21:
	cp 0f0h		;6c21
	ccf			;6c23
	ret			;6c24
L_6C25:
	ld a,(0e505h)		;6c25   ; lee la y del personaje
	sub 010h		;6c28
	sub (ix+005h)		;6c2a
	add a,004h		;6c2d
	cp 009h		;6c2f
	ret			;6c31
L_6C32:
	call 08fc5h		;6c32
	ld (ix+008h),020h		;6c35
	ld a,(0e624h)		;6c39
	or a			;6c3c
	ret z			;6c3d
	ld (ix+00ah),0bch		;6c3e
L_6C42:
	set 6,(ix+003h)		;6c42
	ret			;6c46
L_6C47:
	dec (ix+008h)		;6c47
	jp nz,098a1h		;6c4a
	jp 0b41ch		;6c4d
L_6C50:
	ld a,r		;6c50
	and 001h		;6c52
	ld (ix+014h),a		;6c54
	ld de,00080h		;6c57
	jp 0968ch		;6c5a
L_6C5D:
	call L_6C90		;6c5d
	ld a,(ix+001h)		;6c60
	and a			;6c63
	jr nz,L_6C7D		;6c64
	call L_6BEE		;6c66
	jr nc,L_6C6F		;6c69
	call L_6C04		;6c6b
	ret nc			;6c6e
L_6C6F:
	ld a,(ix+01fh)		;6c6f
	dec a			;6c72
	cp 005h		;6c73
	jr nc,L_6C8A		;6c75
	call L_6B71		;6c77
	jp 09a07h		;6c7a
L_6C7D:
	ld a,(ix+01fh)		;6c7d
	dec a			;6c80
	cp 005h		;6c81
	ret c			;6c83
	call L_6B76		;6c84
	dec (ix+001h)		;6c87
L_6C8A:
	call L_6CD2		;6c8a
	jp 0b15fh		;6c8d
L_6C90:
	inc (ix+008h)		;6c90
	ld a,(ix+008h)		;6c93
	and 003h		;6c96
	ret nz			;6c98
	ld a,(ix+014h)		;6c99
	and a			;6c9c
	jr z,L_6CAD		;6c9d
	dec (ix+01fh)		;6c9f
	ld a,(ix+01fh)		;6ca2
	cp 0ffh		;6ca5
	jr nz,L_6CB8		;6ca7
	ld a,006h		;6ca9
	jr L_6CB8		;6cab
L_6CAD:
	inc (ix+01fh)		;6cad
	ld a,(ix+01fh)		;6cb0
	cp 007h		;6cb3
	jr nz,L_6CB8		;6cb5
	xor a			;6cb7
L_6CB8:
	ld (ix+01fh),a		;6cb8
	ld hl,06cc4h		;6cbb
L_6CBE:
	call 04053h		;6cbe   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	jp L_736F		;6cc1

; ----------------------------------------------------------------------
; DATOS tabla_6cc4: 7 palabras que p04:6CBB elige con 0x4053 y pasa a p04:736F
;   0x6cc4..0x6cd2  (14 bytes)
DATA_tabla_6cc4:
	defb 0a0h,01eh	; 6cc4
	defb 0a8h,00bh	; 6cc6
	defb 0ach,00bh	; 6cc8
	defb 0a4h,01fh	; 6cca
	defb 0b4h,025h	; 6ccc
	defb 0b0h,00bh	; 6cce
	defb 0a0h,01eh	; 6cd0

; ======================================================================
; CODIGO 0x6cd2..0x6dc6  (244 bytes)
; ======================================================================


L_6CD2:
	ld a,(ix+014h)		;6cd2
	xor 001h		;6cd5
	ld (ix+014h),a		;6cd7
	ret			;6cda
L_6CDB:
	ld hl,L_6DBD+1		;6cdb
	call L_6D7F		;6cde
	ld (ix+01ch),011h		;6ce1
	ld (ix+008h),002h		;6ce5
L_6CE9:
	call 081f1h		;6ce9
	and 02fh		;6cec
	add a,050h		;6cee
	ld (ix+01dh),a		;6cf0
	ret			;6cf3
L_6CF4:
	call L_6DBD		;6cf4
	call L_6D5A		;6cf7
	bit 0,(ix+01bh)		;6cfa
	jr nz,L_6D0A		;6cfe
	dec (ix+01dh)		;6d00
	jr nz,L_6D0A		;6d03
	call L_6CE9		;6d05
	jr L_6D76		;6d08
L_6D0A:
	call L_6D3B		;6d0a
	ld a,000h		;6d0d
	jr c,L_6D29		;6d0f
	bit 0,(ix+01bh)		;6d11
	jr z,L_6D23		;6d15
	dec (ix+01ch)		;6d17
	ret nz			;6d1a
	ld (ix+01bh),000h		;6d1b
	ld (ix+01ch),011h		;6d1f
L_6D23:
	call L_6D43		;6d23
	ld a,001h		;6d26
	ret c			;6d28
L_6D29:
	or a			;6d29
	ld a,(ix+018h)		;6d2a
	jr z,L_6D32		;6d2d
	ld a,(ix+019h)		;6d2f
L_6D32:
	ld (ix+001h),a		;6d32
	ld hl,L_6DBD+1		;6d35
	jp L_6D7F		;6d38
L_6D3B:
	ld b,(ix+014h)		;6d3b
	ld c,(ix+015h)		;6d3e
	jr L_6D49		;6d41
L_6D43:
	ld b,(ix+016h)		;6d43
	ld c,(ix+017h)		;6d46
L_6D49:
	ld a,(ix+007h)		;6d49
	add a,b			;6d4c
	ld h,a			;6d4d
	ld a,(ix+005h)		;6d4e
	add a,c			;6d51
	ld l,a			;6d52
	call 04056h		;6d53   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,0b9h		;6d56
	cp (hl)			;6d58
	ret			;6d59
L_6D5A:
	ld a,(ix+001h)		;6d5a
	cp 004h		;6d5d
	jr nc,L_6D67		;6d5f
	call L_6C15		;6d61
	ret nc			;6d64
	jr L_6D76		;6d65
L_6D67:
	bit 0,a		;6d67
	ld a,(ix+005h)		;6d69
	jr nz,L_6D73		;6d6c
	cp 0b0h		;6d6e
	ret c			;6d70
	jr L_6D76		;6d71
L_6D73:
	cp 018h		;6d73
	ret nc			;6d75
L_6D76:
	ld a,(ix+01ah)		;6d76
	ld (ix+001h),a		;6d79
	ld hl,L_6DBD+1		;6d7c
L_6D7F:
	ld (ix+01bh),001h		;6d7f
	ld b,007h		;6d83
	push ix		;6d85
	pop de			;6d87
	ld a,e			;6d88
	add a,013h		;6d89
	ld e,a			;6d8b
L_6D8C:
	inc de			;6d8c
	ld a,008h		;6d8d
	call 04062h		;6d8f   ; hl_mas_a (por 0x4062): HL += A
	push hl			;6d92
	ld a,(ix+001h)		;6d93
	call 04083h		;6d96   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (de),a			;6d99
	pop hl			;6d9a
	djnz L_6D8C		;6d9b
	call 0b124h		;6d9d
	ld a,(ix+001h)		;6da0
	cp 004h		;6da3
	jr nc,L_6DB2		;6da5
	bit 0,a		;6da7
	ld de,00100h		;6da9
	call nz,04068h		;6dac   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;6daf
L_6DB2:
	bit 0,a		;6db2
	ld de,00100h		;6db4
	call nz,04068h		;6db7   ; de_negado (por 0x4068): DE = -DE
	jp 0b137h		;6dba
L_6DBD:
	ld d,004h		;6dbd
	ld e,002h		;6dbf
	ld b,000h		;6dc1
	jp 0b0d6h		;6dc3

; ----------------------------------------------------------------------
; DATOS sin_nombrar_6dc6: 56 bytes que ninguna instruccion ni palabra de los
;   bancos 4-6 nombra (ni medidos en la demo): 16 parejas de pasos (0x10,
;   0xFF, 0x0F, 0...) y 24 bytes que son tres ordenaciones de 0-7 (5 7 4 6 1 3
;   0 2, 6 4 7 5 2 0 3 1, 1 0 3 2 5 4 7 6). Pueden ser restos sin uso o leerse
;   con una direccion calculada; no esta medido
;   0x6dc6..0x6dfe  (56 bytes)
DATA_sin_nombrar_6dc6:
	defb 010h,0ffh,010h,0ffh,00fh,00fh,000h,000h,00fh,00fh,000h,000h,010h,0ffh,010h,0ffh	; 6dc6  ................
	defb 000h,00fh,000h,00fh,010h,010h,0ffh,0ffh,010h,010h,0ffh,0ffh,000h,00fh,000h,00fh	; 6dd6  ................
	defb 005h,007h,004h,006h,001h,003h,000h,002h,006h,004h,007h,005h,002h,000h,003h,001h	; 6de6  ................
	defb 001h,000h,003h,002h,005h,004h,007h,006h	; 6df6  ........

; ======================================================================
; CODIGO 0x6dfe..0x6edd  (223 bytes)
; ======================================================================


L_6DFE:
	ld a,(0e604h)		;6dfe   ; lee el contador de cuadros de partida
	and 07fh		;6e01
	add a,040h		;6e03
	ld (ix+007h),a		;6e05
	ld a,r		;6e08
	and 03fh		;6e0a
	add a,030h		;6e0c
	ld (ix+008h),a		;6e0e
	ld de,0fc00h		;6e11
	call 0b137h		;6e14
	call L_6E90		;6e17
	ld (ix+013h),008h		;6e1a
L_6E1E:
	ld a,(0e604h)		;6e1e   ; lee el contador de cuadros de partida
	ld bc,0ccd4h		;6e21
	bit 3,a		;6e24
	jr z,L_6E2B		;6e26
	ld bc,0d0d8h		;6e28
L_6E2B:
	ld (ix+00ah),b		;6e2b
	ld (ix+012h),c		;6e2e
	ret			;6e31
L_6E32:
	ld hl,0b085h		;6e32
	push hl			;6e35
	ld a,(ix+001h)		;6e36
	or a			;6e39
	jr nz,L_6E4E		;6e3a
	ld a,(ix+005h)		;6e3c
	cp (ix+008h)		;6e3f
	jr nc,L_6E1E		;6e42
	ld (ix+015h),03ch		;6e44
	call L_6B71		;6e48
	jp 09a07h		;6e4b
L_6E4E:
	dec (ix+015h)		;6e4e
	jr z,L_6E65		;6e51
	call L_6E1E		;6e53
	ld a,(0e604h)		;6e56   ; lee el contador de cuadros de partida
	bit 2,a		;6e59
	jr nz,L_6E61		;6e5b
	inc (ix+005h)		;6e5d
	ret			;6e60
L_6E61:
	dec (ix+005h)		;6e61
	ret			;6e64
L_6E65:
	ld b,008h		;6e65
L_6E67:
	push bc			;6e67
	dec b			;6e68
	ld d,(ix+005h)		;6e69
	ld e,(ix+007h)		;6e6c
	ld a,01bh		;6e6f
	call L_6551		;6e71
	pop bc			;6e74
	djnz L_6E67		;6e75
	call 0b41ch		;6e77
	jp 08fc5h		;6e7a
L_6E7D:
	call L_6E98		;6e7d
	jp c,0b41ch		;6e80
	call 0b14ch		;6e83
	ld a,(ix+005h)		;6e86
	cp (ix+008h)		;6e89
	ret c			;6e8c
	call 0b41ch		;6e8d
L_6E90:
	ld d,(ix+005h)		;6e90
	ld b,001h		;6e93
	jp L_78B7		;6e95
L_6E98:
	ld hl,(0e041h)		;6e98   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld de,09301h		;6e9b
	rst 20h			;6e9e
	jr z,L_6EBB		;6e9f
	ld de,0050ah		;6ea1
	rst 20h			;6ea4
	jr z,L_6EBB		;6ea5
	ld de,09001h		;6ea7
	rst 20h			;6eaa
	jr z,L_6EB5		;6eab
	ld de,00f09h		;6ead
	rst 20h			;6eb0
	jr z,L_6EB5		;6eb1
	or a			;6eb3
	ret nz			;6eb4
L_6EB5:
	ld a,(ix+007h)		;6eb5
	cp 020h		;6eb8
	ret			;6eba
L_6EBB:
	ld a,(ix+007h)		;6ebb
	cp 0d8h		;6ebe
	ccf			;6ec0
	ret			;6ec1
L_6EC2:
	ld a,(0e041h)		;6ec2   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,06ee5h		;6ec5
	cp 00ah		;6ec8
	jr nc,L_6ECF		;6eca
	ld hl,06eddh		;6ecc
L_6ECF:
	ld a,(0e624h)		;6ecf
	call 04083h		;6ed2   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+008h),a		;6ed5
	ld bc,06f13h		;6ed8
	jr $+21		;6edb

; ----------------------------------------------------------------------
; DATOS ocho_bytes_6edd: 8 bytes, uno por (0xE624), que p04:6ECC pone en
;   (ix+8) en los mapas 1-9
;   0x6edd..0x6ee5  (8 bytes)
DATA_ocho_bytes_6edd:
	defb 0a8h,0a0h,090h,078h,078h,090h,0a0h,0a8h	; 6edd  ...xx...

; ----------------------------------------------------------------------
; DATOS ocho_bytes_6ee5: los mismos 8 bytes para los mapas 10 y 11 (p04:6EC5)
;   0x6ee5..0x6eed  (8 bytes)
DATA_ocho_bytes_6ee5:
	defb 0b0h,0a8h,0a4h,0a0h,0a0h,0a4h,0a8h,0b0h	; 6ee5  ........

; ======================================================================
; CODIGO 0x6eed..0x6f13  (38 bytes)
; ======================================================================


L_6EED:
	ld bc,06f43h		;6eed
L_6EF0:
	ld a,(0e624h)		;6ef0
	ld l,a			;6ef3
	ld h,000h		;6ef4
	add hl,hl			;6ef6
	ld d,h			;6ef7
	ld e,l			;6ef8
	add hl,hl			;6ef9
	add hl,de			;6efa
	add hl,bc			;6efb
	ld e,(hl)			;6efc
	inc hl			;6efd
	ld d,(hl)			;6efe
	call 0b13eh		;6eff
	inc hl			;6f02
	ld e,(hl)			;6f03
	inc hl			;6f04
	ld d,(hl)			;6f05
	call 0b137h		;6f06
	inc hl			;6f09
	ld e,(hl)			;6f0a
	inc hl			;6f0b
	ld d,(hl)			;6f0c
	call 0b145h		;6f0d
	jp L_6C42		;6f10

; ----------------------------------------------------------------------
; DATOS fichas_6f13: 8 fichas de 6 bytes (tres palabras) que p04:6EF0 elige
;   con (0xE624) x 6; la primera palabra va a p06:B13E
;   0x6f13..0x6f43  (48 bytes)
DATA_fichas_6f13:
	defb 040h,000h,000h,0fch,020h,000h	; 6f13
	defb 0c0h,000h,080h,0fch,022h,000h	; 6f19
	defb 040h,001h,000h,0fdh,024h,000h	; 6f1f
	defb 000h,002h,000h,0feh,020h,000h	; 6f25
	defb 000h,0feh,000h,0feh,020h,000h	; 6f2b
	defb 0c0h,0feh,000h,0fdh,024h,000h	; 6f31
	defb 040h,0ffh,080h,0fch,022h,000h	; 6f37
	defb 0c0h,0ffh,000h,0fch,020h,000h	; 6f3d

; ----------------------------------------------------------------------
; DATOS fichas_6f43: 3 fichas de 6 bytes con el mismo formato (p04:6EED)
;   0x6f43..0x6f55  (18 bytes)
DATA_fichas_6f43:
	defb 0c0h,0fdh,000h,0fch,030h,000h	; 6f43
	defb 0d0h,0feh,040h,0fch,030h,000h	; 6f49
	defb 0e0h,0ffh,080h,0fch,030h,000h	; 6f4f

; ======================================================================
; CODIGO 0x6f55..0x70b2  (349 bytes)
; ======================================================================


L_6F55:
	ld (ix+001h),002h		;6f55
	ld a,013h		;6f59
	jr L_6F5F		;6f5b
L_6F5D:
	ld a,012h		;6f5d
L_6F5F:
	ld (ix+00ah),a		;6f5f
	ld (ix+014h),000h		;6f62
	call L_6B71		;6f66
	ld l,(ix+005h)		;6f69
	ld h,(ix+007h)		;6f6c
	call 04056h		;6f6f   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+012h),l		;6f72
	ld (ix+013h),h		;6f75
	ld a,00fh		;6f78
L_6F7A:
	ld (ix+00ch),a		;6f7a
	jp L_71CF		;6f7d
L_6F80:
	ld a,(ix+001h)		;6f80
	dec a			;6f83
	jr z,L_6FBF		;6f84
	jp p,L_6FE3		;6f86
L_6F89:
	dec (ix+008h)		;6f89
	ret nz			;6f8c
	ld a,(ix+00ch)		;6f8d
	ld (ix+008h),a		;6f90
	ld a,(ix+005h)		;6f93
	cp 0b0h		;6f96
	jr nc,L_6FB6		;6f98
	add a,008h		;6f9a
	ld l,a			;6f9c
	ld h,(ix+007h)		;6f9d
	call 0406eh		;6fa0   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,L_6FB6		;6fa3
	call 04071h		;6fa5   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
	jr c,L_6FB6		;6fa8
	ld a,(ix+005h)		;6faa
	add a,008h		;6fad
	ld (ix+005h),a		;6faf
	inc (ix+014h)		;6fb2
	ret			;6fb5
L_6FB6:
	ld a,(ix+001h)		;6fb6
	cp 003h		;6fb9
	ret z			;6fbb
	jp 09a07h		;6fbc
L_6FBF:
	dec (ix+008h)		;6fbf
	ret nz			;6fc2
	ld a,(ix+00ch)		;6fc3
	ld (ix+008h),a		;6fc6
	ld a,(ix+014h)		;6fc9
	or a			;6fcc
	ret z			;6fcd
	ld a,(ix+005h)		;6fce
	sub 008h		;6fd1
	ld (ix+005h),a		;6fd3
	dec (ix+014h)		;6fd6
	ret nz			;6fd9
	ld a,(ix+001h)		;6fda
	cp 003h		;6fdd
	ret z			;6fdf
	jp 0aca6h		;6fe0
L_6FE3:
	dec a			;6fe3
	jr nz,L_7001		;6fe4
	call L_6FF6		;6fe6
	ret nc			;6fe9
	inc (ix+001h)		;6fea
	ld (ix+00ah),012h		;6fed
	ld a,00fh		;6ff1
	jp L_6F7A		;6ff3
L_6FF6:
	ld a,(0e505h)		;6ff6   ; lee la y del personaje
	sub (ix+005h)		;6ff9
	ccf			;6ffc
	ret nc			;6ffd
	cp 019h		;6ffe
	ret			;7000
L_7001:
	ld a,(0e505h)		;7001   ; lee la y del personaje
	cp (ix+005h)		;7004
	jp c,L_6FBF		;7007
	jp L_6F89		;700a
L_700D:
	ld de,00080h		;700d
	call 0b145h		;7010
L_7013:
	ld a,r		;7013
	bit 0,a		;7015
	ld de,00100h		;7017
	call nz,04068h		;701a   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;701d
L_7020:
	call L_7062		;7020
	call L_703E		;7023
	jr nc,L_702D		;7026
	ld a,009h		;7028
	jp 04059h		;702a   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_702D:
	ld a,(ix+00dh)		;702d
	or a			;7030
	jp m,0b14ch		;7031
	cp 006h		;7034
	jp c,0b14ch		;7036
	ld (ix+00dh),006h		;7039
	ret			;703d
L_703E:
	ld a,(ix+005h)		;703e
	cp (ix+008h)		;7041
	ccf			;7044
	ret nc			;7045
	add a,010h		;7046
	ld bc,0ffe0h		;7048
	call L_7087		;704b
	ret nc			;704e
	ld a,(ix+005h)		;704f
	add a,010h		;7052
	ld (ix+008h),a		;7054
	ld de,0fc00h		;7057
	call 0b137h		;705a
	call L_7013		;705d
	scf			;7060
	ret			;7061
L_7062:
	ld a,(0e604h)		;7062   ; lee el contador de cuadros de partida
	and 003h		;7065
	ret nz			;7067
	ld a,(ix+00ah)		;7068
	bit 7,(ix+00fh)		;706b
	jr z,L_707B		;706f
	add a,004h		;7071
	cp 0d4h		;7073
	jr nz,L_7083		;7075
	ld a,0c4h		;7077
	jr L_7083		;7079
L_707B:
	sub 004h		;707b
	cp 0c0h		;707d
	jr nz,L_7083		;707f
	ld a,0d0h		;7081
L_7083:
	ld (ix+00ah),a		;7083
	ret			;7086
L_7087:
	ld l,a			;7087
	ld h,(ix+007h)		;7088
	call 0406eh		;708b   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,L_7093		;708e
	inc hl			;7090
	cp (hl)			;7091
	ret nc			;7092
L_7093:
	add hl,bc			;7093
	cp (hl)			;7094
	ccf			;7095
	ret			;7096
L_7097:
	ld a,r		;7097
	and 03fh		;7099
	add a,060h		;709b
	ld (ix+008h),a		;709d
	call L_6B71		;70a0
L_70A3:
	set 2,(ix+002h)		;70a3
	ret			;70a7
L_70A8:
	ld hl,0b07bh		;70a8
	push hl			;70ab
	ld a,(ix+001h)		;70ac
	call 04050h		;70af   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_70B2: 5 destinos del despachador de 0x4140 (call en p04:70AF):
;   0x70BC, 0x70D2, 0x7123, 0x7158, 0x7180; lo leen p04:70AF (10 bytes)
;   0x70b2..0x70bc  (10 bytes)
DATA_tabla_70B2:
	defb 0bch,070h	; 70b2
	defb 0d2h,070h	; 70b4
	defb 023h,071h	; 70b6
	defb 058h,071h	; 70b8
	defb 080h,071h	; 70ba

; ======================================================================
; CODIGO 0x70bc..0x70ed  (49 bytes)
; ======================================================================


L_70BC:
	dec (ix+008h)		;70bc
	ret nz			;70bf
	ld bc,00100h		;70c0
L_70C3:
	ld (ix+001h),b		;70c3
	ld (ix+01fh),c		;70c6
	ld (ix+008h),01eh		;70c9
	call L_6B71		;70cd
	jr $-45		;70d0
L_70D2:
	dec (ix+008h)		;70d2
	ret nz			;70d5
	inc (ix+01fh)		;70d6
	ld a,(ix+01fh)		;70d9
	cp 003h		;70dc
	jr nc,$+18		;70de
L_70E0:
	ld (ix+008h),01eh		;70e0
	ld hl,070edh		;70e4
	call 04083h		;70e7   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	jp L_7083		;70ea

; ----------------------------------------------------------------------
; DATOS tres_bytes_70ed: 3 bytes que p04:70E4 lee con (ix+0x1F) = 0-2
;   0x70ed..0x70f0  (3 bytes)
DATA_tres_bytes_70ed:
	defb 0ach,0a8h,0a4h	; 70ed

; ======================================================================
; CODIGO 0x70f0..0x7245  (341 bytes)
; ======================================================================


L_70F0:
	inc (ix+001h)		;70f0
	call L_6B76		;70f3
	ld a,r		;70f6
	and 00fh		;70f8
	add a,005h		;70fa
	ld (ix+008h),a		;70fc
	ld a,(0e505h)		;70ff   ; lee la y del personaje
	cp (ix+007h)		;7102
	ld de,00100h		;7105
	ld a,0b0h		;7108
	jr nc,L_7111		;710a
	ld de,0ff00h		;710c
	ld a,0b8h		;710f
L_7111:
	ld (ix+00ah),a		;7111
	call 0b13eh		;7114
	ld (ix+01fh),00ah		;7117
	call L_7193		;711b
	res 2,(ix+002h)		;711e
	ret			;7122
L_7123:
	call L_71C3		;7123
	jr nz,L_7131		;7126
	dec (ix+008h)		;7128
	ld bc,00403h		;712b
	jp z,L_70C3		;712e
L_7131:
	dec (ix+015h)		;7131
	jr z,L_714E		;7134
	call L_719D		;7136
	call L_6BEE		;7139
	jr nc,L_7142		;713c
	call L_6C04		;713e
	ret nc			;7141
L_7142:
	call 0b15fh		;7142
	ld bc,0b0b4h		;7145
	ld de,0b8bch		;7148
	jp L_71AC		;714b
L_714E:
	inc (ix+001h)		;714e
	ld (ix+015h),01eh		;7151
	jp L_6B71		;7155
L_7158:
	dec (ix+015h)		;7158
	ret nz			;715b
	ld (ix+001h),002h		;715c
	call L_6B76		;7160
	call L_7193		;7163
	ld b,000h		;7166
	ld hl,00200h		;7168
	bit 7,(ix+00fh)		;716b
	jr z,L_7175		;716f
	inc b			;7171
	ld hl,0fe00h		;7172
L_7175:
	ld e,(ix+007h)		;7175
	ld d,(ix+005h)		;7178
	ld a,01eh		;717b
	jp L_6551		;717d
L_7180:
	dec (ix+008h)		;7180
	ret nz			;7183
	dec (ix+01fh)		;7184
	ld a,(ix+01fh)		;7187
	jp p,L_70E0		;718a
	call L_6BD5		;718d
	jp L_7097		;7190
L_7193:
	ld a,r		;7193
	and 03fh		;7195
	add a,080h		;7197
	ld (ix+015h),a		;7199
	ret			;719c
L_719D:
	ld bc,0b0b4h		;719d
	ld de,0b8bch		;71a0
	inc (ix+01fh)		;71a3
	ld a,(ix+01fh)		;71a6
	cp 00ah		;71a9
	ret c			;71ab
L_71AC:
	ld (ix+01fh),000h		;71ac
	bit 7,(ix+00fh)		;71b0
	jr z,L_71B8		;71b4
	ld b,d			;71b6
	ld c,e			;71b7
L_71B8:
	ld a,(ix+00ah)		;71b8
	cp b			;71bb
	jr nz,L_71BF		;71bc
	ld b,c			;71be
L_71BF:
	ld (ix+00ah),b		;71bf
	ret			;71c2
L_71C3:
	ld a,(0e604h)		;71c3   ; lee el contador de cuadros de partida
	and 01fh		;71c6
	ret			;71c8
L_71C9:
	call L_6B71		;71c9
	ld a,(ix+007h)		;71cc
L_71CF:
	ld (ix+008h),a		;71cf
	ret			;71d2
L_71D3:
	ld a,(ix+001h)		;71d3
	dec a			;71d6
	jr z,L_71F9		;71d7
	jp p,L_7218		;71d9
	call L_6C25		;71dc
	ret nc			;71df
	inc (ix+001h)		;71e0
	call L_6B76		;71e3
	ld (ix+00ah),0a0h		;71e6
	ld a,(0e507h)		;71ea   ; lee la x del personaje
	cp (ix+007h)		;71ed
	ld de,00200h		;71f0
	call c,04068h		;71f3   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;71f6
L_71F9:
	ld b,000h		;71f9
	call L_722D		;71fb
	call L_6BEE		;71fe
	jp nc,L_7208		;7201
	call L_6C04		;7204
	ret nc			;7207
L_7208:
	bit 7,(ix+00fh)		;7208
	ld de,00100h		;720c
	call z,04068h		;720f   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;7212
	jp 09a07h		;7215
L_7218:
	ld a,(ix+007h)		;7218
	cp (ix+008h)		;721b
	ld b,001h		;721e
	jr nz,L_722D		;7220
	call L_6BD5		;7222
	call L_6B71		;7225
	ld (ix+00ah),0a0h		;7228
	ret			;722c
L_722D:
	inc b			;722d
	inc b			;722e
	inc (ix+01fh)		;722f
	ld a,(ix+01fh)		;7232
L_7235:
	rra			;7235
	djnz L_7235		;7236
	and 003h		;7238
	ld c,a			;723a
	ld b,000h		;723b
	ld hl,07245h		;723d
	add hl,bc			;7240
	ld a,(hl)			;7241
	jp L_7083		;7242

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_7245: 4 bytes que p04:723D elige con los dos bits bajos
;   de un contador
;   0x7245..0x7249  (4 bytes)
DATA_cuatro_bytes_7245:
	defb 0a0h,0a4h,0a8h,0a4h	; 7245

; ======================================================================
; CODIGO 0x7249..0x725f  (22 bytes)
; ======================================================================


L_7249:
	call 096f5h		;7249
L_724C:
	ld a,r		;724c
	and 03fh		;724e
	add a,080h		;7250
	jp L_71CF		;7252
L_7255:
	ld hl,0b076h		;7255
	push hl			;7258
	ld a,(ix+001h)		;7259
	call 04050h		;725c   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_725F: 6 destinos del despachador de 0x4140 (call en p04:725C):
;   0x726B, 0x7286, 0x72C7, 0x72D4, 0x730D, 0x7328; lo leen p04:725C (12
;   bytes)
;   0x725f..0x726b  (12 bytes)
DATA_tabla_725F:
	defb 06bh,072h	; 725f
	defb 086h,072h	; 7261
	defb 0c7h,072h	; 7263
	defb 0d4h,072h	; 7265
	defb 00dh,073h	; 7267
	defb 028h,073h	; 7269

; ======================================================================
; CODIGO 0x726b..0x72a1  (54 bytes)
; ======================================================================


L_726B:
	dec (ix+008h)		;726b
	ret nz			;726e
	set 7,(ix+002h)		;726f
	ld (ix+00ah),0a0h		;7273
	ld (ix+01fh),000h		;7277
	ld (ix+008h),006h		;727b
	ld a,008h		;727f
	call 04059h		;7281   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jr $+77		;7284
L_7286:
	dec (ix+008h)		;7286
	ret nz			;7289
	ld (ix+008h),006h		;728a
	inc (ix+01fh)		;728e
	ld a,(ix+01fh)		;7291
	cp 003h		;7294
	jr nc,$+14		;7296
L_7298:
	ld hl,072a1h		;7298
	call 04083h		;729b   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	jp L_7083		;729e

; ----------------------------------------------------------------------
; DATOS tres_bytes_72a1: 3 bytes que p04:7298 lee con (ix+0x1F) = 0-2
;   0x72a1..0x72a4  (3 bytes)
DATA_tres_bytes_72a1:
	defb 0a0h,0a4h,0a8h	; 72a1

; ======================================================================
; CODIGO 0x72a4..0x73aa  (262 bytes)
; ======================================================================


L_72A4:
	ld (ix+008h),00ah		;72a4
	call L_733F		;72a8
	ld a,r		;72ab
	bit 0,a		;72ad
	ld a,0ach		;72af
	ld de,00100h		;72b1
	jr z,L_72BB		;72b4
	ld a,0b4h		;72b6
	ld de,0ff00h		;72b8
L_72BB:
	ld (ix+00ah),a		;72bb
	ld (ix+00bh),009h		;72be
	call 0b13eh		;72c2
	jr L_72D1		;72c5
L_72C7:
	dec (ix+008h)		;72c7
	ret nz			;72ca
	call L_724C		;72cb
	call L_6B76		;72ce
L_72D1:
	jp 09a07h		;72d1
L_72D4:
	dec (ix+008h)		;72d4
	jr z,L_7304		;72d7
	call L_6BEE		;72d9
	jr nc,L_72E3		;72dc
	call L_6C04		;72de
	jr nc,L_72E8		;72e1
L_72E3:
	call 0b15fh		;72e3
	jr L_72F1		;72e6
L_72E8:
	inc (ix+01fh)		;72e8
	ld a,(ix+01fh)		;72eb
	cp 00ah		;72ee
	ret c			;72f0
L_72F1:
	ld (ix+01fh),000h		;72f1
	bit 7,(ix+00fh)		;72f5
	ld bc,0acb0h		;72f9
	jr z,L_7301		;72fc
	ld bc,0b4b8h		;72fe
L_7301:
	jp L_71B8		;7301
L_7304:
	call L_6B71		;7304
	ld (ix+008h),00ah		;7307
	jr L_72D1		;730b
L_730D:
	dec (ix+008h)		;730d
	ret nz			;7310
	ld (ix+00ah),0a8h		;7311
	ld (ix+008h),006h		;7315
	ld (ix+00bh),00eh		;7319
	ld (ix+01fh),002h		;731d
	ld a,008h		;7321
	call 04059h		;7323   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jr L_72D1		;7326
L_7328:
	dec (ix+008h)		;7328
	ret nz			;732b
	ld (ix+008h),006h		;732c
	dec (ix+01fh)		;7330
	ld a,(ix+01fh)		;7333
	jp p,L_7298		;7336
	call L_6BD5		;7339
	jp L_7249		;733c
L_733F:
	ld a,(ix+002h)		;733f
	or 0e0h		;7342
	jp 096fah		;7344
L_7347:
	ld a,r		;7347
	and 001h		;7349
	ld de,00100h		;734b
	ld b,033h		;734e
	jr z,L_7356		;7350
	ld de,0ff00h		;7352
	dec b			;7355
L_7356:
	call 0b13eh		;7356
L_7359:
	ld hl,073aah		;7359
	bit 7,(ix+00fh)		;735c
	jr z,L_7365		;7360
	ld hl,073b2h		;7362
L_7365:
	ld a,(ix+01eh)		;7365
	call 04053h		;7368   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld (ix+008h),004h		;736b
L_736F:
	ld (ix+00ah),e		;736f
	ld (ix+011h),d		;7372
	ret			;7375
L_7376:
	ld a,(ix+01ch)		;7376
	and a			;7379
	call nz,L_7396		;737a
	call L_738E		;737d
	call L_6BEE		;7380
	jr nc,L_7389		;7383
	call L_6C04		;7385
	ret nc			;7388
L_7389:
	call 0b15fh		;7389
	jr L_7359		;738c
L_738E:
	ld de,00404h		;738e
	ld b,000h		;7391
	jp 0b0d6h		;7393
L_7396:
	ld (ix+01ch),000h		;7396
	inc (ix+01eh)		;739a
	ld a,(ix+01eh)		;739d
	cp 004h		;73a0
	jr c,L_7359		;73a2
	ld (ix+01eh),003h		;73a4
	jr L_7359		;73a8

; ----------------------------------------------------------------------
; DATOS cuatro_palabras_73aa: 4 palabras que p04:7365 elige con (ix+0x1E)
;   mirando a un lado
;   0x73aa..0x73b2  (8 bytes)
DATA_cuatro_palabras_73aa:
	defb 0c0h,033h	; 73aa
	defb 0c8h,035h	; 73ac
	defb 0d0h,036h	; 73ae
	defb 0d8h,000h	; 73b0

; ----------------------------------------------------------------------
; DATOS cuatro_palabras_73b2: las mismas 4 para el otro lado (bit 7 de
;   (ix+0x0F), p04:7362)
;   0x73b2..0x73ba  (8 bytes)
DATA_cuatro_palabras_73b2:
	defb 0a0h,032h	; 73b2
	defb 0a8h,034h	; 73b4
	defb 0b0h,036h	; 73b6
	defb 0b8h,000h	; 73b8

; ======================================================================
; CODIGO 0x73ba..0x7626  (620 bytes)
; ======================================================================


L_73BA:
	ld (ix+015h),078h		;73ba
	ld a,r		;73be
	and 001h		;73c0
	ld de,00200h		;73c2
	call nz,04068h		;73c5   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;73c8
L_73CB:
	ld (ix+011h),058h		;73cb
	bit 7,(ix+00fh)		;73cf
	ld a,0a4h		;73d3
	jr z,L_73D9		;73d5
	ld a,0b4h		;73d7
L_73D9:
	jp L_7083		;73d9
L_73DC:
	ld a,(ix+001h)		;73dc
	dec a			;73df
	jr z,L_743A		;73e0
	jp p,L_7463		;73e2
	call L_6BEE		;73e5
	jp nc,L_7419		;73e8
	call L_6C04		;73eb
	jr c,L_7419		;73ee
	ld d,00ch		;73f0
	ld b,000h		;73f2
	call 0b17fh		;73f4
	ld a,(ix+017h)		;73f7
	and a			;73fa
	jr z,L_7406		;73fb
	dec (ix+018h)		;73fd
	jr nz,L_740B		;7400
	ld (ix+017h),000h		;7402
L_7406:
	call L_74A8		;7406
	jr c,L_741F		;7409
L_740B:
	dec (ix+015h)		;740b
	ret nz			;740e
	ld (ix+015h),05ah		;740f
	call L_6B71		;7413
	jp 09a07h		;7416
L_7419:
	call 0b15fh		;7419
	jp L_73CB		;741c
L_741F:
	ld (ix+001h),003h		;741f
	ld (ix+008h),03ch		;7423
	call L_6B71		;7427
	bit 0,(ix+01dh)		;742a
	ld a,0ach		;742e
	jr z,L_7434		;7430
	ld a,0bch		;7432
L_7434:
	call L_7973		;7434
	jp L_7083		;7437
L_743A:
	dec (ix+015h)		;743a
	jr z,L_7453		;743d
	ld hl,0e604h		;743f   ; apunta a el contador de cuadros de partida
	bit 3,(hl)		;7442
L_7444:
	ld a,0b0h		;7444
	ld b,059h		;7446
	jr z,L_744D		;7448
	ld a,0c0h		;744a
	inc b			;744c
L_744D:
	ld (ix+011h),b		;744d
	jp L_7083		;7450
L_7453:
	ld (ix+015h),01eh		;7453
	inc (ix+001h)		;7457
	call L_74A8		;745a
	bit 0,(ix+01dh)		;745d
	jr L_7444		;7461
L_7463:
	dec a			;7463
	jr nz,L_7470		;7464
	dec (ix+015h)		;7466
	ret nz			;7469
	ld (ix+015h),078h		;746a
	jr L_749F		;746e
L_7470:
	dec (ix+008h)		;7470
	jr z,L_749F		;7473
	ld a,(ix+008h)		;7475
	and 01fh		;7478
	ret nz			;747a
	ld (ix+018h),028h		;747b
	ld (ix+017h),001h		;747f
	call 09154h		;7483
	ld de,00400h		;7486
	bit 0,(ix+01dh)		;7489
	call nz,04068h		;748d   ; de_negado (por 0x4068): DE = -DE
	ex de,hl			;7490
	ld e,(ix+007h)		;7491
	ld a,(ix+005h)		;7494
	add a,008h		;7497
	ld d,a			;7499
	ld a,01dh		;749a
	jp L_6551		;749c
L_749F:
	call L_6BD5		;749f
	call L_6B76		;74a2
	jp L_73CB		;74a5
L_74A8:
	ld a,(0e507h)		;74a8   ; lee la x del personaje
	sub (ix+007h)		;74ab
	ld b,000h		;74ae
	jr nc,L_74B5		;74b0
	inc b			;74b2
	neg		;74b3
L_74B5:
	ld (ix+01dh),b		;74b5
	cp 041h		;74b8
L_74BA:
	ret			;74ba
L_74BB:
	ld bc,(0e041h)		;74bb   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;74bf
	cp 00ah		;74c0
	jr nz,L_74CE		;74c2
	ld a,b			;74c4
	cp 019h		;74c5
	jr nz,L_74CE		;74c7
	ld a,001h		;74c9
	ld (ix+01dh),a		;74cb
L_74CE:
	set 2,(ix+002h)		;74ce
	ld a,(0e62ah)		;74d2
	ld (ix+015h),a		;74d5
	inc a			;74d8
	ld (0e62ah),a		;74d9
	dec a			;74dc
	jr nz,L_74EC		;74dd
	ld (0e62bh),a		;74df
	ld (ix+018h),a		;74e2
	ld (ix+016h),028h		;74e5
	call L_7646		;74e9
L_74EC:
	ld a,(ix+005h)		;74ec
	ld (ix+01bh),a		;74ef
	ld (ix+008h),008h		;74f2
	ld de,00080h		;74f6
	call 081f1h		;74f9
	and 001h		;74fc
	call nz,04068h		;74fe   ; de_negado (por 0x4068): DE = -DE
	call 0b137h		;7501
	ld de,00020h		;7504
	ld a,r		;7507
	and 001h		;7509
	call nz,04068h		;750b   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;750e
L_7511:
	call L_7630		;7511
	ld a,(ix+007h)		;7514
	add a,028h		;7517
	cp 038h		;7519
	call c,0b15fh		;751b
	ld de,00010h		;751e
	ld a,(ix+01bh)		;7521
	cp (ix+005h)		;7524
	call c,04068h		;7527   ; de_negado (por 0x4068): DE = -DE
	call 0821ch		;752a
	ld a,(0e62bh)		;752d
	dec a			;7530
	jp z,L_75D1		;7531
	ld a,(ix+015h)		;7534
	and a			;7537
	ret nz			;7538
	dec (ix+016h)		;7539
	ret nz			;753c
	ld a,001h		;753d
	ld (0e62bh),a		;753f
	ld a,(0e62ah)		;7542
	ld (ix+017h),a		;7545
	dec (ix+019h)		;7548
	call z,L_7638		;754b
	bit 0,(ix+018h)		;754e
	jr nz,L_757D		;7552
	ld b,(ix+017h)		;7554
	call 081f1h		;7557
	and 003h		;755a
	cp b			;755c
	jr c,L_7560		;755d
	xor a			;755f
L_7560:
	ld (0e629h),a		;7560
	push ix		;7563
	call L_765B		;7565
	ld (ix+016h),018h		;7568
	call 081f1h		;756c
	and 00fh		;756f
	cp 00ah		;7571
	jr c,L_7577		;7573
	sub 00ah		;7575
L_7577:
	ld (ix+01ah),a		;7577
	pop ix		;757a
	ret			;757c
L_757D:
	ld bc,0ff00h		;757d
L_7580:
	push ix		;7580
	push bc			;7582
	ld a,c			;7583
	call L_765B		;7584
	pop bc			;7587
	jr c,L_75A5		;7588
	ld a,(0e507h)		;758a   ; lee la x del personaje
	sub (ix+007h)		;758d
	jr nc,L_7594		;7590
	neg		;7592
L_7594:
	cp b			;7594
	jr nc,L_75A5		;7595
	ld b,a			;7597
	ld a,c			;7598
	ld (0e629h),a		;7599
	ld (ix+016h),018h		;759c
	push bc			;75a0
	call L_75AD		;75a1
	pop bc			;75a4
L_75A5:
	pop ix		;75a5
	inc c			;75a7
	ld a,c			;75a8
	cp 004h		;75a9
	jr nz,L_7580		;75ab
L_75AD:
	ld hl,07626h		;75ad
	ld a,(0e507h)		;75b0   ; lee la x del personaje
	sub (ix+007h)		;75b3
	jr c,L_75BC		;75b6
	ld de,00005h		;75b8
	add hl,de			;75bb
L_75BC:
	ld c,000h		;75bc
L_75BE:
	cp (hl)			;75be
	jr c,L_75CC		;75bf
	inc c			;75c1
	ex af,af'			;75c2
	ld a,c			;75c3
	cp 009h		;75c4
	jr z,L_75CC		;75c6
	ex af,af'			;75c8
	inc hl			;75c9
	jr L_75BE		;75ca
L_75CC:
	ex af,af'			;75cc
	ld (ix+01ah),c		;75cd
	ret			;75d0
L_75D1:
	ld a,(0e629h)		;75d1
	cp (ix+015h)		;75d4
	ret nz			;75d7
	dec (ix+016h)		;75d8
	jr z,L_75E6		;75db
	ld a,(ix+00bh)		;75dd
	xor 00ch		;75e0
	ld (ix+00bh),a		;75e2
	ret			;75e5
L_75E6:
	ld (ix+00bh),00fh		;75e6
	xor a			;75ea
	ld (0e62bh),a		;75eb
	push ix		;75ee
	call L_765B		;75f0
	ld (ix+016h),010h		;75f3
	pop ix		;75f7
	ld a,(ix+005h)		;75f9
	add a,00ah		;75fc
	ld d,a			;75fe
	ld a,(ix+01ah)		;75ff
	add a,a			;7602
	add a,a			;7603
	add a,a			;7604
	ld hl,077fbh		;7605
	call 04083h		;7608   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	sub 0a0h		;760b
	rra			;760d
	rra			;760e
	and 007h		;760f
	ld hl,077cah		;7611
	call 04062h		;7614   ; hl_mas_a (por 0x4062): HL += A
	ld a,(ix+007h)		;7617
	add a,008h		;761a
	sub (hl)			;761c
	ld e,a			;761d
	ld b,(ix+01ah)		;761e
	ld a,006h		;7621
	jp L_6551		;7623

; ----------------------------------------------------------------------
; DATOS diez_bytes_7626: 10 bytes que p04:75AD compara con la distancia en X
;   al jugador (0xE507 - (ix+7))
;   0x7626..0x7630  (10 bytes)
DATA_diez_bytes_7626:
	defb 0dbh,0e7h,0ech,0f6h,0ffh,004h,008h,00dh,018h,028h	; 7626  .........(

; ======================================================================
; CODIGO 0x7630..0x76da  (170 bytes)
; ======================================================================


L_7630:
	ld de,07c08h		;7630
	ld b,001h		;7633
	jp 0b0d6h		;7635
L_7638:
	ld a,(ix+01dh)		;7638
	or a			;763b
	jr nz,L_7643		;763c
	ld a,(ix+018h)		;763e
	xor 001h		;7641
L_7643:
	ld (ix+018h),a		;7643
L_7646:
	ld a,(ix+018h)		;7646
	and a			;7649
	ld b,003h		;764a
	jr nz,L_7650		;764c
	ld b,007h		;764e
L_7650:
	call 081f1h		;7650
	and b			;7653
	jr nz,L_7657		;7654
	ld a,b			;7656
L_7657:
	ld (ix+019h),a		;7657
	ret			;765a
L_765B:
	ld ix,0e800h		;765b   ; apunta a los huecos de figura (32 bytes cada uno)
	ld de,00020h		;765f
	ld b,010h		;7662
L_7664:
	ld c,a			;7664
	ld a,(ix+000h)		;7665   ; lee el tipo de la figura
	cp 069h		;7668
	ld a,c			;766a
	jr z,L_7673		;766b
L_766D:
	add ix,de		;766d
	djnz L_7664		;766f
	scf			;7671
	ret			;7672
L_7673:
	cp (ix+015h)		;7673
	jr nz,L_766D		;7676
	ret			;7678
L_7679:
	set 2,(ix+002h)		;7679
	ld (ix+014h),000h		;767d
	call 0b124h		;7681
	ld a,(0e624h)		;7684
	ld b,a			;7687
	ld a,(ix+007h)		;7688
	cp 027h		;768b
	jr c,L_769C		;768d
	cp 0d5h		;768f
	jr c,L_76A5		;7691
	ld a,b			;7693
	cp 005h		;7694
	jr c,L_76A6		;7696
	sub 005h		;7698
	jr L_76A6		;769a
L_769C:
	ld a,b			;769c
	cp 005h		;769d
	jr nc,L_76A6		;769f
	add a,005h		;76a1
	jr L_76A6		;76a3
L_76A5:
	ld a,b			;76a5
L_76A6:
	add a,a			;76a6
	add a,a			;76a7
	add a,a			;76a8
	ld hl,077fbh		;76a9
	call 04083h		;76ac   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+01eh),h		;76af
	ld (ix+01fh),l		;76b2
	ld (ix+00ah),a		;76b5
	ld (ix+016h),001h		;76b8
	ld a,(ix+005h)		;76bc
	ld (ix+012h),a		;76bf
	ld a,(ix+007h)		;76c2
	ld (ix+013h),a		;76c5
	ld a,007h		;76c8
	jp 04059h		;76ca   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_76CD:
	call L_77CF		;76cd
	ld hl,076e2h		;76d0
	push hl			;76d3
	ld a,(ix+001h)		;76d4
	call 04050h		;76d7   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_76DA: 4 destinos del despachador de 0x4140 (call en p04:76D7):
;   0x76FF, 0x771E, 0x7730, 0x776E; lo leen p04:76D7 (8 bytes)
;   0x76da..0x76e2  (8 bytes)
DATA_tabla_76DA:
	defb 0ffh,076h	; 76da
	defb 01eh,077h	; 76dc
	defb 030h,077h	; 76de
	defb 06eh,077h	; 76e0

; ======================================================================
; CODIGO 0x76e2..0x76f6  (20 bytes)
; ======================================================================


L_76E2:
	push ix		;76e2
	pop hl			;76e4
	ld a,017h		;76e5
	call 04062h		;76e7   ; hl_mas_a (por 0x4062): HL += A
	ld a,(ix+016h)		;76ea
	call 04083h		;76ed   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld hl,076f6h		;76f0
	jp 0b092h		;76f3

; ----------------------------------------------------------------------
; DATOS nueve_bytes_76f6: 9 bytes que p04:76EF pasa en HL a p06:B092
;   0x76f6..0x76ff  (9 bytes)
DATA_nueve_bytes_76f6:
	defb 010h,016h,017h,000h,018h,019h,019h,00eh,00fh	; 76f6  .........

; ======================================================================
; CODIGO 0x76ff..0x77c5  (198 bytes)
; ======================================================================


L_76FF:
	ld a,(ix+009h)		;76ff
	or 0c0h		;7702
	inc a			;7704
	ld (ix+009h),a		;7705
	ld (ix+00bh),010h		;7708
	inc (ix+016h)		;770c
	call L_77E5		;770f
	ld a,(ix+016h)		;7712
	sub 006h		;7715
	ret nz			;7717
	ld (ix+017h),a		;7718
	jp 09a07h		;771b
L_771E:
	call L_7782		;771e
	inc (ix+017h)		;7721
	call L_77E5		;7724
	ld a,(ix+012h)		;7727
	cp 090h		;772a
	ret c			;772c
	jp 09a07h		;772d
L_7730:
	call L_7782		;7730
	dec (ix+016h)		;7733
	ld a,(ix+016h)		;7736
	dec a			;7739
	jr nz,L_7767		;773a
	ld (ix+009h),081h		;773c
	ld (ix+00bh),002h		;7740
	ld l,0b8h		;7744
	ld h,(ix+013h)		;7746
	call 0406eh		;7749   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jp nc,0b41ch		;774c
	ld (ix+008h),030h		;774f
	ld (ix+00ah),0b4h		;7753
	ld (ix+00bh),008h		;7757
	ld (ix+005h),0a8h		;775b
	ld a,01ch		;775f
	call 04059h		;7761   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp 09a07h		;7764
L_7767:
	call L_77E5		;7767
	dec (ix+009h)		;776a
	ret			;776d
L_776E:
	dec (ix+008h)		;776e
	jp z,0b41ch		;7771
	ld a,(ix+008h)		;7774
	and 003h		;7777
	ret nz			;7779
	ld a,(ix+00ah)		;777a
	xor 00ch		;777d
	jp L_7083		;777f
L_7782:
	ld a,(ix+005h)		;7782
	add a,010h		;7785
	ld (ix+005h),a		;7787
	ld hl,077c5h		;778a
	ld d,(ix+01eh)		;778d
	ld e,(ix+01fh)		;7790
	ld a,(de)			;7793
	sub 0a0h		;7794
	rra			;7796
	rra			;7797
	and 007h		;7798
	call 04083h		;779a   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ex af,af'			;779d
	inc de			;779e
	ld hl,077cah		;779f
	ld a,(de)			;77a2
	sub 0a0h		;77a3
	rra			;77a5
	rra			;77a6
	and 007h		;77a7
	call 04083h		;77a9   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld h,a			;77ac
	ex af,af'			;77ad
	ld l,a			;77ae
	ld a,(ix+007h)		;77af
	add a,l			;77b2
	sub h			;77b3
	ld (ix+007h),a		;77b4
	ld h,(ix+01eh)		;77b7
	ld l,(ix+01fh)		;77ba
	inc hl			;77bd
	ld (ix+01eh),h		;77be
	ld (ix+01fh),l		;77c1
	ret			;77c4

; ----------------------------------------------------------------------
; DATOS cinco_bytes_77c5: 5 bytes que p04:778A lee con 0x4083
;   0x77c5..0x77ca  (5 bytes)
DATA_cinco_bytes_77c5:
	defb 001h,006h,00ah,00ah,00eh	; 77c5

; ----------------------------------------------------------------------
; DATOS cinco_bytes_77ca: 5 bytes que p04:7611 y p04:779F leen con 0x4083
;   0x77ca..0x77cf  (5 bytes)
DATA_cinco_bytes_77ca:
	defb 006h,007h,000h,00fh,004h	; 77ca

; ======================================================================
; CODIGO 0x77cf..0x77fb  (44 bytes)
; ======================================================================


L_77CF:
	ld a,(ix+014h)		;77cf
	inc a			;77d2
	cp 015h		;77d3
	jr nz,L_77D8		;77d5
	xor a			;77d7
L_77D8:
	ld (ix+014h),a		;77d8
	ld hl,082e4h		;77db
	call 04083h		;77de   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+015h),a		;77e1
	ret			;77e4
L_77E5:
	push ix		;77e5
	pop hl			;77e7
	ld de,00018h		;77e8
	add hl,de			;77eb
	ex de,hl			;77ec
	ld h,(ix+01eh)		;77ed
	ld l,(ix+01fh)		;77f0
	ld b,000h		;77f3
	ld c,(ix+016h)		;77f5
	ldir		;77f8
	ret			;77fa

; ----------------------------------------------------------------------
; DATOS ochenta_bytes_77fb: 80 bytes, de 8 en 8, que p04:7605 y p04:76A9 leen
;   en 0x77FB + 8 x n + m
;   0x77fb..0x784b  (80 bytes)
DATA_ochenta_bytes_77fb:
	defb 0ach,0a0h,0ach,0a0h,0a0h,0ach,0a0h,0ach	; 77fb  ........
	defb 0ach,0a0h,0ach,0a4h,0a0h,0ach,0ach,0a0h	; 7803  ........
	defb 0ach,0a4h,0ach,0a0h,0ach,0ach,0a0h,0a4h	; 780b  ........
	defb 0a0h,0ach,0a0h,0a8h,0ach,0a4h,0a0h,0ach	; 7813  ........
	defb 0a0h,0ach,0a8h,0ach,0b0h,0a0h,0a8h,0ach	; 781b  ........
	defb 0ach,0b0h,0a4h,0ach,0a0h,0a8h,0b0h,0a0h	; 7823  ........
	defb 0a8h,0ach,0a0h,0b0h,0b0h,0a0h,0a8h,0ach	; 782b  ........
	defb 0a0h,0a8h,0b0h,0a4h,0ach,0a8h,0b0h,0a0h	; 7833  ........
	defb 0b0h,0a0h,0ach,0a8h,0b0h,0a8h,0b0h,0a8h	; 783b  ........
	defb 0a8h,0b0h,0b0h,0a8h,0a4h,0a8h,0b0h,0a8h	; 7843  ........

; ======================================================================
; CODIGO 0x784b..0x791f  (212 bytes)
; ======================================================================


L_784B:
	ld a,r		;784b
	and 001h		;784d
	ld (ix+014h),a		;784f
	ld a,r		;7852
	bit 2,a		;7854
	jr nz,L_787F		;7856
	ld a,(ix+014h)		;7858
	ld b,0f0h		;785b
	and a			;785d
	jr z,L_7862		;785e
	ld b,010h		;7860
L_7862:
	ld a,(0e507h)		;7862   ; lee la x del personaje
	add a,b			;7865
	call L_78F2		;7866
	ld a,(0e505h)		;7869   ; lee la y del personaje
	ld b,000h		;786c
	cp 03dh		;786e
	jr c,L_7889		;7870
	inc b			;7872
	cp 05dh		;7873
	jr c,L_7889		;7875
	inc b			;7877
	cp 07dh		;7878
	jr c,L_7889		;787a
	inc b			;787c
	jr L_7889		;787d
L_787F:
	ld a,r		;787f
	call L_78F2		;7881
	ld a,r		;7884
	and 003h		;7886
	ld b,a			;7888
L_7889:
	ld (ix+01ch),b		;7889
	ld a,b			;788c
	ld hl,07927h		;788d
	call 04053h		;7890   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call 0968ch		;7893
	ld a,b			;7896
	ld hl,0792fh		;7897
	call 04053h		;789a   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call 0b137h		;789d
	ld de,00080h		;78a0
	call 0b145h		;78a3
	bit 0,(ix+014h)		;78a6
	ld a,0c8h		;78aa
	jr z,L_78B0		;78ac
	ld a,0d0h		;78ae
L_78B0:
	ld (ix+00ah),a		;78b0
L_78B3:
	ld d,090h		;78b3
	ld b,000h		;78b5
L_78B7:
	ld e,(ix+007h)		;78b7
L_78BA:
	ld a,06ah		;78ba
	call L_6551		;78bc
	ld a,(ix+000h)		;78bf
	cp 030h		;78c2
	ld a,024h		;78c4
	jr z,L_78CA		;78c6
	ld a,00dh		;78c8
L_78CA:
	jp 04059h		;78ca   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_78CD:
	call 0b14ch		;78cd
	ld d,(ix+00dh)		;78d0
	bit 7,d		;78d3
	call z,L_78E6		;78d5
	ld e,(ix+00ch)		;78d8
	ld a,d			;78db
	or e			;78dc
	ret nz			;78dd
	ld a,(ix+00ah)		;78de
	add a,004h		;78e1
	jp L_7083		;78e3
L_78E6:
	ld a,(ix+005h)		;78e6
	cp 090h		;78e9
	ret nz			;78eb
	call L_78B3		;78ec
	jp 0b41ch		;78ef
L_78F2:
	push af			;78f2
	ld a,(0e624h)		;78f3
	dec a			;78f6
	ld hl,0791fh		;78f7
	call 04053h		;78fa   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld a,d			;78fd
	add a,030h		;78fe
	ld b,a			;7900
	ld a,e			;7901
	sub 018h		;7902
	ld c,a			;7904
	pop af			;7905
	cp d			;7906
	jr c,L_790F		;7907
	cp e			;7909
	jr c,L_7910		;790a
	ld a,e			;790c
	jr L_7910		;790d
L_790F:
	ld a,d			;790f
L_7910:
	ld (ix+007h),a		;7910
	cp b			;7913
	ld e,000h		;7914
	jr c,L_791B		;7916
	cp c			;7918
	ret c			;7919
	inc e			;791a
L_791B:
	ld (ix+014h),e		;791b
	ret			;791e

; ----------------------------------------------------------------------
; DATOS tabla_791f: 4 palabras que p04:78F7 elige con (0xE624) - 1
;   0x791f..0x7927  (8 bytes)
DATA_tabla_791f:
	defb 0e0h,020h	; 791f
	defb 0e0h,000h	; 7921
	defb 0e0h,000h	; 7923
	defb 0d0h,000h	; 7925

; ----------------------------------------------------------------------
; DATOS tabla_7927: 4 palabras que p04:788D pasa a p05:968C
;   0x7927..0x792f  (8 bytes)
DATA_tabla_7927:
	defb 0aah,000h	; 7927
	defb 0c3h,000h	; 7929
	defb 0e3h,000h	; 792b
	defb 024h,001h	; 792d

; ----------------------------------------------------------------------
; DATOS tabla_792f: 4 palabras que p04:7897 pasa a p06:B137 (velocidades)
;   0x792f..0x7937  (8 bytes)
DATA_tabla_792f:
	defb 080h,0f9h	; 792f
	defb 080h,0f7h	; 7931
	defb 000h,0f6h	; 7933
	defb 080h,0f4h	; 7935

; ======================================================================
; CODIGO 0x7937..0x7d40  (1033 bytes)
; ======================================================================


L_7937:
	ld (ix+008h),00ah		;7937
	call L_6B71		;793b
	ld a,(0e624h)		;793e
	and a			;7941
	ret z			;7942
	dec a			;7943
	jr z,L_794B		;7944
	ld (ix+00ah),0c0h		;7946
	ret			;794a
L_794B:
	ld (ix+00bh),009h		;794b
	ret			;794f
L_7950:
	ld a,r		;7950
	and 001h		;7952
	ld de,00180h		;7954
	call nz,04068h		;7957   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;795a
	call L_7A3D		;795d
L_7960:
	bit 7,(ix+00fh)		;7960
	ld bc,0a0b0h		;7964
	jr z,L_796C		;7967
	ld bc,0b4c4h		;7969
L_796C:
	call L_6E2B		;796c
	ld (ix+013h),006h		;796f
L_7973:
	ld (ix+011h),000h		;7973
	ret			;7977
L_7978:
	ld a,(ix+001h)		;7978
	dec a			;797b
	jr z,L_79BF		;797c
	jp p,L_79E4		;797e
	call L_7A5F		;7981
	jr z,L_79A4		;7984
L_7986:
	call L_6BEE		;7986
	jp nc,L_79B5		;7989
	call L_6C04		;798c
	jr c,L_79B5		;798f
	ld (ix+01eh),000h		;7991
	ld d,004h		;7995
	ld b,013h		;7997
	bit 7,(ix+00fh)		;7999
	jr z,L_79A1		;799d
	ld d,00ch		;799f
L_79A1:
	jp 0b17fh		;79a1
L_79A4:
	ld (ix+015h),01eh		;79a4
	call L_7973		;79a8
	call L_6B71		;79ab
	ld (ix+00ah),0a8h		;79ae
	jp 09a07h		;79b2
L_79B5:
	ld (ix+01eh),001h		;79b5
	call 0b15fh		;79b9
	jp L_7960		;79bc
L_79BF:
	dec (ix+015h)		;79bf
	jr z,L_79CB		;79c2
	ld d,014h		;79c4
	ld b,000h		;79c6
	jp 0b17fh		;79c8
L_79CB:
	call L_7A56		;79cb
	bit 0,(ix+01dh)		;79ce
	ld de,00180h		;79d2
	call nz,04068h		;79d5   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;79d8
	call L_7960		;79db
	call L_6B76		;79de
	jp 09a07h		;79e1
L_79E4:
	dec a			;79e4
	jr nz,L_7A46		;79e5
	call L_7986		;79e7
	bit 0,(ix+01eh)		;79ea
	jr nz,L_7A03		;79ee
	ld a,(ix+007h)		;79f0
	bit 7,(ix+00fh)		;79f3
	jr nz,L_79FF		;79f7
	cp (ix+01fh)		;79f9
	ret c			;79fc
	jr L_7A03		;79fd
L_79FF:
	cp (ix+01fh)		;79ff
	ret nc			;7a02
L_7A03:
	ld a,(ix+01ch)		;7a03
	dec a			;7a06
	jr nz,L_7A4D		;7a07
	ld c,0f0h		;7a09
	bit 7,(ix+00fh)		;7a0b
	ld b,00ch		;7a0f
	jr z,L_7A15		;7a11
	ld b,004h		;7a13
L_7A15:
	call L_6D49		;7a15
	jr nc,L_7A4D		;7a18
	ld (ix+008h),00fh		;7a1a
	ld a,0ach		;7a1e
	bit 7,(ix+00fh)		;7a20
	jr z,L_7A28		;7a24
	ld a,0c0h		;7a26
L_7A28:
	ld (ix+00ah),a		;7a28
	ld (ix+011h),001h		;7a2b
	call L_6B71		;7a2f
	call L_7A76		;7a32
	ld a,021h		;7a35
	call 04059h		;7a37   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	inc (ix+001h)		;7a3a
L_7A3D:
	ld a,(ix+009h)		;7a3d
	xor 003h		;7a40
	ld (ix+009h),a		;7a42
	ret			;7a45
L_7A46:
	dec (ix+008h)		;7a46
	ret nz			;7a49
	call L_7A3D		;7a4a
L_7A4D:
	call L_6B76		;7a4d
	call L_6BD5		;7a50
	jp L_7960		;7a53
L_7A56:
	ld a,(0e507h)		;7a56   ; lee la x del personaje
	ld (ix+01fh),a		;7a59
	jp L_74A8		;7a5c
L_7A5F:
	ld hl,0e505h		;7a5f   ; apunta a la y del personaje
	ld b,001h		;7a62
	ld a,(ix+005h)		;7a64
	sub 010h		;7a67
	cp (hl)			;7a69
	jr z,L_7A71		;7a6a
	add a,020h		;7a6c
	cp (hl)			;7a6e
	ret nz			;7a6f
	inc b			;7a70
L_7A71:
	ld (ix+01ch),b		;7a71
	xor a			;7a74
	ret			;7a75
L_7A76:
	ld a,(0e505h)		;7a76   ; lee la y del personaje
	ld b,a			;7a79
	ld a,(ix+005h)		;7a7a
	sub b			;7a7d
	cp 010h		;7a7e
	ret nz			;7a80
	ld a,(0e507h)		;7a81   ; lee la x del personaje
	sub (ix+007h)		;7a84
	cp 010h		;7a87
	ret nc			;7a89
	ld a,(0e503h)		;7a8a
	ld (0e514h),a		;7a8d
	jp 04092h		;7a90
L_7A93:
	ld (ix+008h),008h		;7a93
	ld a,r		;7a97
	and 001h		;7a99
	ld a,0a0h		;7a9b
	ld b,03fh		;7a9d
	ld de,00400h		;7a9f
	jr z,L_7AAB		;7aa2
	ld a,0a8h		;7aa4
	ld b,005h		;7aa6
	ld de,0fc00h		;7aa8
L_7AAB:
	ld (ix+00ah),a		;7aab
	ld (ix+011h),b		;7aae
	call 0b13eh		;7ab1
L_7AB4:
	ld a,r		;7ab4
	and 02fh		;7ab6
	ld (ix+015h),a		;7ab8
	add a,050h		;7abb
	ld (ix+014h),a		;7abd
	ret			;7ac0
L_7AC1:
	ld a,(ix+001h)		;7ac1
	or a			;7ac4
	jr nz,L_7AEA		;7ac5
	call L_6BEE		;7ac7
	call L_6C04		;7aca
	jr nc,L_7AD5		;7acd
	call L_7AF7		;7acf
	call 0b15fh		;7ad2
L_7AD5:
	ld d,004h		;7ad5
	ld b,03ah		;7ad7
	ld e,008h		;7ad9
	call 0b0d6h		;7adb
	dec (ix+014h)		;7ade
	jr z,L_7AE4		;7ae1
	ret			;7ae3
L_7AE4:
	call L_6B71		;7ae4
	jp 09a07h		;7ae7
L_7AEA:
	dec (ix+015h)		;7aea
	ret nz			;7aed
	call L_6B76		;7aee
	call L_7AB4		;7af1
	jp 0aca6h		;7af4
L_7AF7:
	bit 7,(ix+00fh)		;7af7
	ld (ix+00ah),0a0h		;7afb
	ld (ix+011h),03eh		;7aff
	ret nz			;7b03
	ld (ix+00ah),0a8h		;7b04
	ld (ix+011h),005h		;7b08
	ret			;7b0c
L_7B0D:
	ld a,001h		;7b0d
	ld (0e62eh),a		;7b0f
	set 1,(ix+002h)		;7b12
	call 09af2h		;7b16
	call L_7CA9		;7b19
	ld de,00050h		;7b1c
	call 0b145h		;7b1f
L_7B22:
	ld (ix+018h),005h		;7b22
	bit 0,(ix+01dh)		;7b26
	ld de,00070h		;7b2a
	call nz,04068h		;7b2d   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;7b30
L_7B33:
	bit 0,(ix+01dh)		;7b33
	ld a,0b0h		;7b37
	ld bc,0bcaah		;7b39
	ld d,04eh		;7b3c
	jr z,L_7B4A		;7b3e
	ld a,0c0h		;7b40
	ld bc,0ccb2h		;7b42
	inc d			;7b45
	set 0,(ix+002h)		;7b46
L_7B4A:
	ld e,007h		;7b4a
	jp 098f9h		;7b4c
L_7B4F:
	ld a,(ix+001h)		;7b4f
	dec a			;7b52
	jr z,L_7BA1		;7b53
	jp p,L_7C0A		;7b55
	call L_7B68		;7b58
	dec (ix+008h)		;7b5b
	jr z,L_7B9B		;7b5e
	ld a,(ix+018h)		;7b60
	and a			;7b63
	jp z,0947dh		;7b64
	ret			;7b67
L_7B68:
	call L_7CFD		;7b68
	call L_6BEE		;7b6b
	jr nc,L_7B74		;7b6e
	call L_7C5E		;7b70
	ret nc			;7b73
L_7B74:
	bit 0,(ix+014h)		;7b74
	jr nz,L_7B88		;7b78
	call 09a74h		;7b7a
	jp c,L_7BFA		;7b7d
	call 0b15fh		;7b80
	call 09b01h		;7b83
	jr L_7B33		;7b86
L_7B88:
	bit 7,(ix+00fh)		;7b88
	ld a,(0ea63h)		;7b8c
	ld b,0f0h		;7b8f
	jr z,L_7B95		;7b91
	ld b,008h		;7b93
L_7B95:
	add a,b			;7b95
	ld (ix+007h),a		;7b96
	pop hl			;7b99
	ret			;7b9a
L_7B9B:
	call L_7C84		;7b9b
	jp 09489h		;7b9e
L_7BA1:
	ld a,r		;7ba1
	and 001h		;7ba3
	jr z,L_7BAE		;7ba5
	call 09a67h		;7ba7
	jr c,L_7BFA		;7baa
	jr $+7		;7bac
L_7BAE:
	call L_7CB7		;7bae
	jp c,L_7BBD		;7bb1
	call L_7B68		;7bb4
	call 094ffh		;7bb7
	jr nc,L_7C1B		;7bba
	ret			;7bbc
L_7BBD:
	ld a,(ix+01eh)		;7bbd
	dec a			;7bc0
	ld de,0ff00h		;7bc1
	ld a,0a0h		;7bc4
	jr z,L_7BD5		;7bc6
	ld de,00100h		;7bc8
	ld a,(ix+005h)		;7bcb
	add a,009h		;7bce
	ld (ix+005h),a		;7bd0
	ld a,0a8h		;7bd3
L_7BD5:
	ld (ix+00ah),a		;7bd5
	ld (ix+011h),055h		;7bd8
	call L_7A3D		;7bdc
	call 0b137h		;7bdf
	ld (ix+001h),003h		;7be2
	jp 0b12eh		;7be6
L_7BE9:
	ld (ix+001h),001h		;7be9
	inc (ix+01eh)		;7bed
	ld a,(ix+01eh)		;7bf0
	sub 003h		;7bf3
	ret nz			;7bf5
	ld (ix+01eh),a		;7bf6
	ret			;7bf9
L_7BFA:
	call 09988h		;7bfa
	bit 0,(ix+01dh)		;7bfd
	ld a,0b8h		;7c01
	jr z,L_7C07		;7c03
	ld a,0c8h		;7c05
L_7C07:
	jp L_7083		;7c07
L_7C0A:
	dec a			;7c0a
	jr nz,L_7C27		;7c0b
	call 09b1dh		;7c0d
	ret nz			;7c10
	call 099c9h		;7c11
	ret nc			;7c14
	call 09b15h		;7c15
L_7C18:
	call L_7B68		;7c18
L_7C1B:
	call 09af2h		;7c1b
	call 0b129h		;7c1e
	call L_6BD5		;7c21
	jp L_7B22		;7c24
L_7C27:
	ld d,004h		;7c27
	ld b,000h		;7c29
	call 0b17fh		;7c2b
	ld a,(ix+005h)		;7c2e
	sub 020h		;7c31
	cp 090h		;7c33
	call nc,L_7C53		;7c35
	call 099c9h		;7c38
	ret nc			;7c3b
	ld l,(ix+005h)		;7c3c
	ld h,(ix+007h)		;7c3f
	call 04056h		;7c42   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;7c45
	cp 0bah		;7c46
	jp nc,L_7C53		;7c48
	call 09b15h		;7c4b
	call L_7C99		;7c4e
	jr L_7C18		;7c51
L_7C53:
	ld a,(ix+00ah)		;7c53
	xor 008h		;7c56
	ld (ix+00ah),a		;7c58
	jp 0b16fh		;7c5b
L_7C5E:
	ld (ix+014h),000h		;7c5e
	ld bc,0ffe0h		;7c62
	add hl,bc			;7c65
	ld a,(hl)			;7c66
	cp 0d2h		;7c67
	jr z,L_7C7F		;7c69
	cp 0bah		;7c6b
	ccf			;7c6d
	ret c			;7c6e
	ld a,(ix+007h)		;7c6f
	bit 7,(ix+00fh)		;7c72
	jr z,L_7C7B		;7c76
	cp 010h		;7c78
	ret			;7c7a
L_7C7B:
	cp 0d8h		;7c7b
	ccf			;7c7d
	ret			;7c7e
L_7C7F:
	ld (ix+014h),001h		;7c7f
	ret			;7c83
L_7C84:
	ld a,(0e505h)		;7c84   ; lee la y del personaje
	sub 010h		;7c87
	cp (ix+005h)		;7c89
	ld b,000h		;7c8c
	jr z,L_7C95		;7c8e
	ld b,001h		;7c90
	jr c,L_7C95		;7c92
	inc b			;7c94
L_7C95:
	ld (ix+01eh),b		;7c95
	ret			;7c98
L_7C99:
	bit 0,(ix+01dh)		;7c99
	ld de,00070h		;7c9d
	call nz,04068h		;7ca0   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;7ca3
	jp L_7B33		;7ca6
L_7CA9:
	ld a,(0e507h)		;7ca9   ; lee la x del personaje
	cp (ix+007h)		;7cac
	ccf			;7caf
	ld a,000h		;7cb0
	rla			;7cb2
	ld (ix+01dh),a		;7cb3
	ret			;7cb6
L_7CB7:
	ld a,(ix+01eh)		;7cb7
	dec a			;7cba
	jr nz,L_7CC6		;7cbb
	ld a,(ix+005h)		;7cbd
	add a,00fh		;7cc0
	ld l,a			;7cc2
	jp L_7CCE		;7cc3
L_7CC6:
	dec a			;7cc6
	ret nz			;7cc7
	ld a,(ix+005h)		;7cc8
	add a,018h		;7ccb
	ld l,a			;7ccd
L_7CCE:
	ld h,(ix+007h)		;7cce
	ld c,004h		;7cd1
	push hl			;7cd3
	ld a,h			;7cd4
	add a,c			;7cd5
	ld h,a			;7cd6
	call 04056h		;7cd7   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;7cda
	pop hl			;7cdb
	sub 09ah		;7cdc
	cp 002h		;7cde
	ret nc			;7ce0
	ld a,010h		;7ce1
	sub c			;7ce3
	ld c,a			;7ce4
	ld a,h			;7ce5
	add a,c			;7ce6
	ld h,a			;7ce7
	push hl			;7ce8
	call 04056h		;7ce9   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;7cec
	pop hl			;7ced
	sub 09ah		;7cee
	cp 002h		;7cf0
	ret nc			;7cf2
	ld a,h			;7cf3
	sub 008h		;7cf4
	and 0f8h		;7cf6
	ld (ix+007h),a		;7cf8
	scf			;7cfb
	ret			;7cfc
L_7CFD:
	bit 7,(ix+00fh)		;7cfd
	ld a,0b0h		;7d01
	jr z,L_7D07		;7d03
	ld a,0c0h		;7d05
L_7D07:
	ld hl,0e604h		;7d07   ; apunta a el contador de cuadros de partida
	bit 2,(hl)		;7d0a
	jp z,L_7B33		;7d0c
	add a,004h		;7d0f
	res 5,(ix+009h)		;7d11
	jp L_7083		;7d15
L_7D18:
	ld (ix+008h),004h		;7d18
	ld (ix+018h),004h		;7d1c
	ld (ix+016h),00bh		;7d20
	call L_7D9E		;7d24
	call 0a103h		;7d27
	call L_7E17		;7d2a
	ret nc			;7d2d
	call 09706h		;7d2e
	ret nc			;7d31
	ld (ix+00ah),0a0h		;7d32
	inc (ix+019h)		;7d36
	ret			;7d39
L_7D3A:
	ld a,(ix+001h)		;7d3a
	call 04050h		;7d3d   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_7D40: 5 destinos del despachador de 0x4140 (call en p04:7D3D):
;   0x7D4A, 0x7D53, 0x7D71, 0x7D8E, 0x7DB3; lo leen p04:7D3D (10 bytes)
;   0x7d40..0x7d4a  (10 bytes)
DATA_tabla_7D40:
	defb 04ah,07dh	; 7d40
	defb 053h,07dh	; 7d42
	defb 071h,07dh	; 7d44
	defb 08eh,07dh	; 7d46
	defb 0b3h,07dh	; 7d48

; ======================================================================
; CODIGO 0x7d4a..0x7e49  (255 bytes)
; ======================================================================


L_7D4A:
	inc (ix+001h)		;7d4a
	bit 0,(ix+019h)		;7d4d
	jr nz,L_7D5F		;7d51
L_7D53:
	call L_7E17		;7d53
	jp nc,L_7DBD		;7d56
	call 09706h		;7d59
	jp nc,L_7DBD		;7d5c
L_7D5F:
	ld (ix+008h),050h		;7d5f
	ld (ix+00ah),0a0h		;7d63
	ld (ix+011h),067h		;7d67
	call 0b124h		;7d6b
	jp 09a07h		;7d6e
L_7D71:
	dec (ix+008h)		;7d71
	ret nz			;7d74
	ld (ix+014h),00ah		;7d75
	ld (ix+008h),006h		;7d79
	ld (ix+00ah),0ach		;7d7d
	ld (ix+011h),069h		;7d81
	ld de,00100h		;7d85
	call 0b137h		;7d88
	jp 09a07h		;7d8b
L_7D8E:
	ld e,006h		;7d8e
	call L_7DD6		;7d90
	dec (ix+014h)		;7d93
	ret nz			;7d96
	inc (ix+001h)		;7d97
	ld (ix+008h),004h		;7d9a
L_7D9E:
	call 081f1h		;7d9e
	and 01fh		;7da1
	add a,060h		;7da3
	ld (ix+017h),a		;7da5
L_7DA8:
	call 081f1h		;7da8
	and 00fh		;7dab
	add a,010h		;7dad
	ld (ix+015h),a		;7daf
	ret			;7db2
L_7DB3:
	dec (ix+017h)		;7db3
	jr nz,L_7DBD		;7db6
L_7DB8:
	ld (ix+001h),001h		;7db8
	ret			;7dbc
L_7DBD:
	call L_7DDD		;7dbd
	ld e,004h		;7dc0
	call L_7DD6		;7dc2
	dec (ix+015h)		;7dc5
	ret nz			;7dc8
	call L_7DA8		;7dc9
	call 081f1h		;7dcc
	and 00fh		;7dcf
	ld b,002h		;7dd1
	jp L_7E25		;7dd3
L_7DD6:
	ld d,01ch		;7dd6
	ld b,066h		;7dd8
	jp 0b0d6h		;7dda
L_7DDD:
	ld a,(ix+005h)		;7ddd
	bit 7,(ix+00dh)		;7de0
	jr nz,L_7DEC		;7de4
	cp 0b0h		;7de6
	jr c,L_7DFB		;7de8
	jr L_7DF0		;7dea
L_7DEC:
	cp 028h		;7dec
	jr nc,L_7DFB		;7dee
L_7DF0:
	ld (ix+015h),010h		;7df0
	ld (ix+01dh),001h		;7df4
	call 0b16fh		;7df8
L_7DFB:
	ld a,(ix+007h)		;7dfb
	bit 7,(ix+00fh)		;7dfe
	jr nz,L_7E09		;7e02
	cp 0e8h		;7e04
	ret c			;7e06
	jr L_7E0C		;7e07
L_7E09:
	cp 008h		;7e09
	ret nc			;7e0b
L_7E0C:
	ld (ix+015h),010h		;7e0c
	ld (ix+01ch),001h		;7e10
	jp 0b15fh		;7e14
L_7E17:
	ld h,(ix+007h)		;7e17
	ld l,(ix+005h)		;7e1a
	dec l			;7e1d
	call 0406eh		;7e1e   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret nc			;7e21
	jp 04071h		;7e22   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
L_7E25:
	push af			;7e25
	ld hl,07e49h		;7e26
	call 04053h		;7e29   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld hl,00000h		;7e2c
	push bc			;7e2f
L_7E30:
	add hl,de			;7e30
	djnz L_7E30		;7e31
	ex de,hl			;7e33
	call 0b13eh		;7e34
	pop bc			;7e37
	pop af			;7e38
	ld hl,07e69h		;7e39
	call 04053h		;7e3c   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld hl,00000h		;7e3f
L_7E42:
	add hl,de			;7e42
	djnz L_7E42		;7e43
	ex de,hl			;7e45
	jp 0b137h		;7e46

; ----------------------------------------------------------------------
; DATOS coseno_7e49: 16 palabras con signo, x 0x100, de una vuelta en 16 pasos
;   que empieza en 0x0100 (0x0100, 0x00DD, 0x00B5, 0x0080, 0, 0xFF80...): las
;   elige p04:7E26 con 0x4053
;   0x7e49..0x7e69  (32 bytes)
DATA_coseno_7e49:
	defb 000h,001h	; 7e49
	defb 0ddh,000h	; 7e4b
	defb 0b5h,000h	; 7e4d
	defb 080h,000h	; 7e4f
	defb 000h,000h	; 7e51
	defb 080h,0ffh	; 7e53
	defb 04bh,0ffh	; 7e55
	defb 023h,0ffh	; 7e57
	defb 000h,0ffh	; 7e59
	defb 023h,0ffh	; 7e5b
	defb 04bh,0ffh	; 7e5d
	defb 080h,0ffh	; 7e5f
	defb 000h,000h	; 7e61
	defb 080h,000h	; 7e63
	defb 0b5h,000h	; 7e65
	defb 0ddh,000h	; 7e67

; ----------------------------------------------------------------------
; DATOS seno_7e69: las mismas 16 desplazadas un cuarto de vuelta, empezando en
;   0 (p04:7E39)
;   0x7e69..0x7e89  (32 bytes)
DATA_seno_7e69:
	defb 000h,000h	; 7e69
	defb 080h,0ffh	; 7e6b
	defb 04bh,0ffh	; 7e6d
	defb 023h,0ffh	; 7e6f
	defb 000h,0ffh	; 7e71
	defb 023h,0ffh	; 7e73
	defb 04bh,0ffh	; 7e75
	defb 080h,0ffh	; 7e77
	defb 000h,000h	; 7e79
	defb 080h,000h	; 7e7b
	defb 0b5h,000h	; 7e7d
	defb 0ddh,000h	; 7e7f
	defb 000h,001h	; 7e81
	defb 0ddh,000h	; 7e83
	defb 0b5h,000h	; 7e85
	defb 080h,000h	; 7e87

; ======================================================================
; CODIGO 0x7e89..0x7f78  (239 bytes)
; ======================================================================


L_7E89:
	call 081f1h		;7e89
	sub 010h		;7e8c
	and 0dfh		;7e8e
	add a,010h		;7e90
	ld (ix+007h),a		;7e92
	cp 080h		;7e95
	ld b,000h		;7e97
	jr c,L_7E9C		;7e99
	inc b			;7e9b
L_7E9C:
	ld (ix+014h),b		;7e9c
L_7E9F:
	ld a,(ix+014h)		;7e9f
	and a			;7ea2
	ld de,00100h		;7ea3
	ld a,0a0h		;7ea6
	jr z,L_7EAF		;7ea8
	ld de,0ff00h		;7eaa
	ld a,0a8h		;7ead
L_7EAF:
	call 0b13eh		;7eaf
	jp L_7083		;7eb2
L_7EB5:
	ld a,(ix+001h)		;7eb5
	dec a			;7eb8
	jr z,L_7EFE		;7eb9
	call L_7F20		;7ebb
	call L_7F0E		;7ebe
	jr nc,L_7EF2		;7ec1
	bit 0,(ix+014h)		;7ec3
	ld a,(ix+007h)		;7ec7
	ld l,(ix+005h)		;7eca
	ld b,00eh		;7ecd
	jr z,L_7ED3		;7ecf
	ld b,001h		;7ed1
L_7ED3:
	add a,b			;7ed3
	ret c			;7ed4
	ld h,a			;7ed5
	ld e,008h		;7ed6
	call 0407ah		;7ed8   ; pared_en (por 0x407A): C si la casilla (y+E) llega al umbral de 0xF020
	ret nc			;7edb
	ld a,058h		;7edc
	ld (ix+011h),a		;7ede
	call 0b15fh		;7ee1
	call L_6CD2		;7ee4
	bit 0,a		;7ee7
	ld a,0a0h		;7ee9
	jr z,L_7EEF		;7eeb
	ld a,0a8h		;7eed
L_7EEF:
	jp L_7083		;7eef
L_7EF2:
	call 0b12eh		;7ef2
	ld de,00200h		;7ef5
	call 0b137h		;7ef8
	jp 09a07h		;7efb
L_7EFE:
	call L_7F0E		;7efe
	ret nc			;7f01
	dec (ix+001h)		;7f02
	call 09b15h		;7f05
	call 0b129h		;7f08
	jp L_7E9F		;7f0b
L_7F0E:
	ld b,010h		;7f0e
	ld h,(ix+007h)		;7f10
	ld a,(ix+005h)		;7f13
	cp 0b0h		;7f16
	ret nc			;7f18
	ld l,a			;7f19
	ld de,0020dh		;7f1a
	jp 04074h		;7f1d   ; pared_en_fila (por 0x4074): C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
L_7F20:
	ld d,004h		;7f20
	ld b,001h		;7f22
	bit 7,(ix+00fh)		;7f24
	jr z,L_7F2B		;7f28
	inc b			;7f2a
L_7F2B:
	jp 0b17fh		;7f2b
L_7F2E:
	ld a,r		;7f2e
	and 003h		;7f30
	ld (ix+01ch),a		;7f32
	call 081f1h		;7f35
	and 0bfh		;7f38
	add a,020h		;7f3a
	ld (ix+007h),a		;7f3c
	cp 080h		;7f3f
	ld b,000h		;7f41
	jr c,L_7F46		;7f43
	inc b			;7f45
L_7F46:
	ld (ix+014h),b		;7f46
	ld de,0fc00h		;7f49
	call 0b137h		;7f4c
	ld de,00080h		;7f4f
	call 0b145h		;7f52
	call 0801ch		;7f55
	ld (ix+018h),002h		;7f58
	call 080b7h		;7f5c
L_7F5F:
	bit 0,(ix+014h)		;7f5f
	ld bc,0c4c8h		;7f63
	jr z,L_7F6B		;7f66
	ld bc,0d8d4h		;7f68
L_7F6B:
	ld (ix+013h),009h		;7f6b
	jp L_6E2B		;7f6f
L_7F72:
	ld a,(ix+001h)		;7f72
	call 04050h		;7f75   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_7F78: 6 destinos del despachador de 0x4140 (call en p04:7F75):
;   0x7F84, 0x7F94, 0x7FA7, 0x7FCF, 0x7F94, 0x8010; lo leen p04:7F75 (12
;   bytes)
;   0x7f78..0x7f84  (12 bytes)
DATA_tabla_7F78:
	defb 084h,07fh	; 7f78
	defb 094h,07fh	; 7f7a
	defb 0a7h,07fh	; 7f7c
	defb 0cfh,07fh	; 7f7e
	defb 094h,07fh	; 7f80
	defb 010h,080h	; 7f82

; ======================================================================
; CODIGO 0x7f84..0x7fff  (123 bytes)
; ======================================================================


L_7F84:
	ld hl,080bch		;7f84
	ld a,(ix+01ch)		;7f87
	call 04083h		;7f8a   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	cp (ix+005h)		;7f8d
	ret nz			;7f90
	jp 09a07h		;7f91
L_7F94:
	inc (ix+01eh)		;7f94
	ld a,(ix+01eh)		;7f97
	cp 011h		;7f9a
	jr z,L_7FA1		;7f9c
	jp 0b14ch		;7f9e
L_7FA1:
	call 080b7h		;7fa1
	jp 09a07h		;7fa4
L_7FA7:
	ld a,(ix+005h)		;7fa7
	cp 090h		;7faa
	jp nc,08016h		;7fac
	call 08087h		;7faf
	ret c			;7fb2
	call 09b15h		;7fb3
	call 0b129h		;7fb6
	ld a,(ix+007h)		;7fb9
	ld (ix+01ah),a		;7fbc
	bit 0,(ix+014h)		;7fbf
	ld de,00200h		;7fc3
	call nz,04068h		;7fc6   ; de_negado (por 0x4068): DE = -DE
L_7FC9:
	call 0b13eh		;7fc9
	jp 09a07h		;7fcc
L_7FCF:
	ld a,(ix+018h)		;7fcf
	inc a			;7fd2
	jr z,$+50		;7fd3
	dec a			;7fd5
	jr nz,L_7FED		;7fd6
	ld a,(ix+007h)		;7fd8
	bit 7,(ix+00fh)		;7fdb
	jr z,L_7FE8		;7fdf
	cp (ix+01ah)		;7fe1
	jr c,$+33		;7fe4
	jr L_7FED		;7fe6
L_7FE8:
	cp (ix+01ah)		;7fe8
	jr nc,$+26		;7feb
L_7FED:
	call 08029h		;7fed
	call 0804ch		;7ff0
	jr nc,L_7FF9		;7ff3
	call 0806fh		;7ff5
	ret nc			;7ff8
L_7FF9:
	call 0b15fh		;7ff9
	call L_6CD2		;7ffc

; ----------------------------------------------------------------------
; DATOS partida_7FFF: la instruccion de p04:7FFF (DD | 35 18) empieza al final
;   del banco 4 y acaba al principio del 5, que el cartucho pone siempre a
;   continuacion: aqui el primer byte; lo leen p04:7FFF (1 bytes)
;   0x7fff..0x8000  (1 bytes)
DATA_partida_7FFF:
	defb 0ddh	; 7fff
