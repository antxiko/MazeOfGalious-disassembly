; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 06 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ======================================================================
; CODIGO 0xa000..0xa0d1  (209 bytes)
; ======================================================================


L_A000:
	ld l,a			;a000
	ld h,(ix+007h)		;a001
	call 0406eh		;a004   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,L_A00D		;a007
	call 04071h		;a009   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
	ret nc			;a00c
L_A00D:
	inc (ix+014h)		;a00d
	ret			;a010
L_A011:
	ld (ix+015h),000h		;a011
	bit 7,(ix+00fh)		;a015
	jr z,L_A02D		;a019
	ld h,(ix+007h)		;a01b
	dec h			;a01e
	ld l,(ix+005h)		;a01f
	call 0406eh		;a022   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,L_A03F		;a025
	call L_A043		;a027
	jr c,L_A03F		;a02a
	ret			;a02c
L_A02D:
	ld a,(ix+007h)		;a02d
	add a,011h		;a030
	ld h,a			;a032
	ld l,(ix+005h)		;a033
	call 0406eh		;a036   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,L_A03F		;a039
	call L_A043		;a03b
	ret nc			;a03e
L_A03F:
	inc (ix+015h)		;a03f
	ret			;a042
L_A043:
	ld de,00020h		;a043
	add hl,de			;a046
	cp (hl)			;a047
	ret			;a048
L_A049:
	ld a,(ix+005h)		;a049
	and 003h		;a04c
	cp 002h		;a04e
	ld a,(ix+005h)		;a050
	jr c,L_A057		;a053
	add a,004h		;a055
L_A057:
	and 0fch		;a057
	ld (ix+005h),a		;a059
	ld a,(ix+007h)		;a05c
	and 003h		;a05f
	cp 002h		;a061
	ld a,(ix+007h)		;a063
	jr c,L_A06A		;a066
	add a,004h		;a068
L_A06A:
	and 0fch		;a06a
	ld (ix+007h),a		;a06c
	ret			;a06f
L_A070:
	call 081f1h		;a070
	ld (ix+008h),a		;a073
	xor a			;a076
	ld (ix+001h),a		;a077
	dec a			;a07a
	ld (ix+01eh),a		;a07b
	jp 096f5h		;a07e
L_A081:
	ld a,(ix+001h)		;a081
	dec a			;a084
	jr z,L_A090		;a085
	dec (ix+008h)		;a087
	ret nz			;a08a
	inc (ix+001h)		;a08b
	jr L_A094		;a08e
L_A090:
	dec (ix+008h)		;a090
	ret nz			;a093
L_A094:
	call 0733fh		;a094
	inc (ix+01eh)		;a097
	ld a,(ix+01eh)		;a09a
	and a			;a09d
	jr z,L_A0A2		;a09e
	sub 008h		;a0a0
L_A0A2:
	call nc,L_A0C6		;a0a2
	dec a			;a0a5
	jr z,L_A070		;a0a6
	ld a,(ix+01eh)		;a0a8
	ld c,010h		;a0ab
	and a			;a0ad
	jr z,L_A0BA		;a0ae
	cp 004h		;a0b0
	jr z,L_A0BA		;a0b2
	cp 008h		;a0b4
	jr z,L_A0BA		;a0b6
	ld c,004h		;a0b8
L_A0BA:
	ld hl,0a0d1h		;a0ba
	call 04053h		;a0bd   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld (ix+008h),c		;a0c0
	jp 0736fh		;a0c3
L_A0C6:
	ex af,af'			;a0c6
	ld a,(ix+002h)		;a0c7
	and 08fh		;a0ca
	ld (ix+002h),a		;a0cc
	ex af,af'			;a0cf
	ret			;a0d0

; ----------------------------------------------------------------------
; DATOS tabla_a0d1: 9 palabras que p06:A0BA elige con 0x4053 y pasa a p04:736F
;   0xa0d1..0xa0e3  (18 bytes)
DATA_tabla_a0d1:
	defb 0c4h,026h	; a0d1
	defb 0c8h,027h	; a0d3
	defb 0cch,028h	; a0d5
	defb 0d0h,029h	; a0d7
	defb 0d4h,029h	; a0d9
	defb 0d0h,029h	; a0db
	defb 0cch,028h	; a0dd
	defb 0c8h,027h	; a0df
	defb 0c4h,026h	; a0e1

; ======================================================================
; CODIGO 0xa0e3..0xa1be  (219 bytes)
; ======================================================================


L_A0E3:
	ld (ix+012h),0bch		;a0e3
	ld (ix+013h),001h		;a0e7
	ld (ix+014h),001h		;a0eb
	jr L_A0F5		;a0ef
L_A0F1:
	ld (ix+014h),008h		;a0f1
L_A0F5:
	res 5,(ix+002h)		;a0f5
	ld (ix+015h),001h		;a0f9
	ld de,00000h		;a0fd
	call L_B133		;a100
L_A103:
	ld a,001h		;a103
	ld (0e63eh),a		;a105
	ret			;a108
L_A109:
	call L_A16B		;a109
	call L_A15A		;a10c
	call 0930eh		;a10f
	dec (ix+015h)		;a112
	jr nz,L_A124		;a115
	call 07da8h		;a117
	call 081f1h		;a11a
	and 00fh		;a11d
	ld b,002h		;a11f
	call 07e25h		;a121
L_A124:
	dec (ix+014h)		;a124
	jr nz,L_A12D		;a127
	set 5,(ix+002h)		;a129
L_A12D:
	bit 5,(ix+002h)		;a12d
	ret z			;a131
	ld a,(ix+01ch)		;a132
	and a			;a135
	ret z			;a136
	ld a,(ix+000h)		;a137
	cp 053h		;a13a
	ret z			;a13c
	cp 049h		;a13d
	ld a,052h		;a13f
	jr z,L_A145		;a141
	ld a,053h		;a143
L_A145:
	ld b,002h		;a145
L_A147:
	push af			;a147
	push bc			;a148
	dec b			;a149
	ld d,(ix+005h)		;a14a
	ld e,(ix+007h)		;a14d
	call 06551h		;a150
	pop bc			;a153
	pop af			;a154
	djnz L_A147		;a155
	jp L_B41C		;a157
L_A15A:
	ld a,(ix+000h)		;a15a
	cp 049h		;a15d
	ret nz			;a15f
	ld a,(0e604h)		;a160   ; lee el contador de cuadros de partida
	and 00fh		;a163
	ret nz			;a165
	ld a,00ah		;a166
	jp 04059h		;a168   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A16B:
	ld a,(0e604h)		;a16b   ; lee el contador de cuadros de partida
	and 007h		;a16e
	ret nz			;a170
	ld a,(ix+000h)		;a171
	cp 049h		;a174
	jr z,L_A187		;a176
	ld d,01ch		;a178
	ld b,066h		;a17a
	cp 052h		;a17c
	jr z,L_A184		;a17e
	ld d,00ch		;a180
	ld b,01eh		;a182
L_A184:
	jp L_B0DD		;a184
L_A187:
	ld d,00ch		;a187
	ld b,001h		;a189
	call L_B0DD		;a18b
	ret nz			;a18e
	ld a,(ix+012h)		;a18f
	xor 07ch		;a192
	ld (ix+012h),a		;a194
	ret			;a197
L_A198:
	ld (ix+012h),0a4h		;a198
	ld (ix+013h),00eh		;a19c
	ld a,(ix+005h)		;a1a0
	add a,008h		;a1a3
	ld (ix+016h),a		;a1a5
	ld a,(ix+007h)		;a1a8
	sub 00dh		;a1ab
	ld (ix+014h),a		;a1ad
	add a,024h		;a1b0
	ld (ix+015h),a		;a1b2
	jp 096f5h		;a1b5
L_A1B8:
	ld a,(ix+001h)		;a1b8
	call 04050h		;a1bb   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A1BE: 3 destinos del despachador de 0x4140 (call en p06:A1BB):
;   0xA1C4, 0xA1FD, 0xA226; lo leen p06:A1BB (6 bytes)
;   0xa1be..0xa1c4  (6 bytes)
DATA_tabla_A1BE:
	defb 0c4h,0a1h	; a1be
	defb 0fdh,0a1h	; a1c0
	defb 026h,0a2h	; a1c2

; ======================================================================
; CODIGO 0xa1c4..0xa2ad  (233 bytes)
; ======================================================================


L_A1C4:
	call L_A258		;a1c4
	call L_A24E		;a1c7
	ret nc			;a1ca
	set 0,(ix+017h)		;a1cb
	call L_A261		;a1cf
	call L_A24C		;a1d2
	jr nc,L_A1E0		;a1d5
	set 1,(ix+017h)		;a1d7
	call L_A27D		;a1db
	jr z,L_A1EF		;a1de
L_A1E0:
	call L_A26D		;a1e0
	call L_A24C		;a1e3
	ret nc			;a1e6
	set 2,(ix+017h)		;a1e7
	call L_A27D		;a1eb
	ret nz			;a1ee
L_A1EF:
	call 096eeh		;a1ef
	call L_B13E		;a1f2
	jp 09a07h		;a1f5
L_A1F8:
	ld (ix+017h),000h		;a1f8
	ret			;a1fc
L_A1FD:
	ld a,(ix+007h)		;a1fd
	bit 7,(ix+00fh)		;a200
	jr nz,L_A208		;a204
	add a,00ah		;a206
L_A208:
	ld h,a			;a208
	ld a,(ix+005h)		;a209
	add a,018h		;a20c
	ld l,a			;a20e
	call 0406eh		;a20f   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr nc,L_A218		;a212
	call 06c04h		;a214
	ret nc			;a217
L_A218:
	ld a,(ix+018h)		;a218
	xor 001h		;a21b
	ld (ix+018h),a		;a21d
	call L_B124		;a220
	jp 09a07h		;a223
L_A226:
	call L_A258		;a226
	call L_A24E		;a229
	ret nc			;a22c
	ld a,(ix+018h)		;a22d
	or a			;a230
	ld a,(0e507h)		;a231   ; lee la x del personaje
	jr z,L_A23F		;a234
	cp (ix+007h)		;a236
	ld de,0ffc0h		;a239
	jr c,L_A246		;a23c
	ret			;a23e
L_A23F:
	cp (ix+007h)		;a23f
	ld de,00040h		;a242
	ret c			;a245
L_A246:
	call L_B13E		;a246
	jp 07db8h		;a249
L_A24C:
	add a,0fdh		;a24c
L_A24E:
	cp (hl)			;a24e
	jr z,L_A256		;a24f
	inc a			;a251
	djnz L_A24E		;a252
	xor a			;a254
	ret			;a255
L_A256:
	scf			;a256
	ret			;a257
L_A258:
	ld a,(ix+016h)		;a258
	ld b,011h		;a25b
	ld hl,0e505h		;a25d   ; apunta a la y del personaje
	ret			;a260
L_A261:
	ld (ix+018h),001h		;a261
	ld a,(ix+014h)		;a265
	ld de,0ffc0h		;a268
	jr L_A277		;a26b
L_A26D:
	ld (ix+018h),000h		;a26d
	ld a,(ix+015h)		;a271
	ld de,00040h		;a274
L_A277:
	ld b,006h		;a277
	ld hl,0e507h		;a279   ; apunta a la x del personaje
	ret			;a27c
L_A27D:
	ld a,(ix+017h)		;a27d
	cp 007h		;a280
	ret			;a282
L_A283:
	ld a,(0e669h)		;a283
	cp 005h		;a286
	ld (ix+007h),0b0h		;a288
	jr nc,L_A292		;a28c
	ld (ix+007h),040h		;a28e
L_A292:
	ld (ix+005h),028h		;a292
	ld (ix+01bh),00ch		;a296
	ld (ix+008h),006h		;a29a
	ld de,00200h		;a29e
	jp L_B137		;a2a1
L_A2A4:
	call L_A3B0		;a2a4
	ld a,(ix+001h)		;a2a7
	call 04050h		;a2aa   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A2AD: 3 destinos del despachador de 0x4140 (call en p06:A2AA):
;   0xA2B3, 0xA2E7, 0xA305; lo leen p06:A2AA (6 bytes)
;   0xa2ad..0xa2b3  (6 bytes)
DATA_tabla_A2AD:
	defb 0b3h,0a2h	; a2ad
	defb 0e7h,0a2h	; a2af
	defb 005h,0a3h	; a2b1

; ======================================================================
; CODIGO 0xa2b3..0xa3ba  (263 bytes)
; ======================================================================


L_A2B3:
	ld a,(ix+018h)		;a2b3
	and 007h		;a2b6
	push af			;a2b8
	ld hl,0a3d2h		;a2b9
	call 04083h		;a2bc   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+017h),a		;a2bf
	pop af			;a2c2
	ld hl,0a3dah		;a2c3
	call 04083h		;a2c6   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	bit 0,(ix+015h)		;a2c9
	ld hl,0a3ceh		;a2cd
	jr z,L_A2D5		;a2d0
	ld hl,0a3cah		;a2d2
L_A2D5:
	call 04083h		;a2d5   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+016h),a		;a2d8
	call L_A36A		;a2db
	call c,L_A37A		;a2de
	inc (ix+018h)		;a2e1
	jp 09a07h		;a2e4
L_A2E7:
	ld a,(ix+016h)		;a2e7
	cp (ix+005h)		;a2ea
	ret nz			;a2ed
	call L_B129		;a2ee
	bit 0,(ix+014h)		;a2f1
	ld de,00100h		;a2f5
	call nz,04068h		;a2f8   ; de_negado (por 0x4068): DE = -DE
	call L_B13E		;a2fb
	ld (ix+019h),000h		;a2fe
	jp 09a07h		;a302
L_A305:
	ld a,(ix+019h)		;a305
	ld hl,0a3bah		;a308
	call 04083h		;a30b   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	bit 0,(ix+015h)		;a30e
	ld (ix+01ah),a		;a312
	call nz,L_A3A1		;a315
	inc (ix+019h)		;a318
	bit 0,(ix+017h)		;a31b
	jr z,L_A33F		;a31f
	ld a,(ix+019h)		;a321
	cp 00eh		;a324
	jr nz,L_A33F		;a326
	dec (ix+017h)		;a328
	call L_A3A7		;a32b
	ld a,002h		;a32e
	ld (ix+019h),a		;a330
	ld hl,0a3bah		;a333
	call 04083h		;a336   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+01ah),a		;a339
	call L_A3A1		;a33c
L_A33F:
	ld a,(ix+019h)		;a33f
	cp 00fh		;a342
	jr nc,L_A354		;a344
	cp 009h		;a346
	call nc,L_A39E		;a348
	ld a,(ix+005h)		;a34b
	add a,(ix+01ah)		;a34e
	jp 096eah		;a351
L_A354:
	call L_A3A7		;a354
	call 06bd5h		;a357
	call L_B12E		;a35a
	bit 0,(ix+015h)		;a35d
	ld de,00200h		;a361
	call nz,04068h		;a364   ; de_negado (por 0x4068): DE = -DE
	jp L_B137		;a367
L_A36A:
	ld a,(ix+007h)		;a36a
	bit 0,(ix+014h)		;a36d
	jr z,L_A376		;a371
	cp 028h		;a373
	ret			;a375
L_A376:
	cp 0c8h		;a376
	ccf			;a378
	ret			;a379
L_A37A:
	ld (ix+011h),00fh		;a37a
	bit 0,(ix+014h)		;a37e
	jr z,L_A391		;a382
	res 0,(ix+014h)		;a384
	ld (ix+00ah),0c4h		;a388
	ld (ix+01bh),00ch		;a38c
	ret			;a390
L_A391:
	set 0,(ix+014h)		;a391
	ld (ix+00ah),0cch		;a395
	ld (ix+01bh),01ch		;a399
	ret			;a39d
L_A39E:
	ld a,(ix+01ah)		;a39e
L_A3A1:
	neg		;a3a1
	ld (ix+01ah),a		;a3a3
	ret			;a3a6
L_A3A7:
	ld a,(ix+015h)		;a3a7
	xor 001h		;a3aa
	ld (ix+015h),a		;a3ac
	ret			;a3af
L_A3B0:
	ld d,(ix+01bh)		;a3b0
	ld e,006h		;a3b3
	ld b,001h		;a3b5
	jp L_B0D6		;a3b7

; ----------------------------------------------------------------------
; DATOS dieciseis_bytes_a3ba: 16 bytes que p06:A308 y p06:A333 ponen en
;   (ix+0x1A) segun (ix+0x19)
;   0xa3ba..0xa3ca  (16 bytes)
DATA_dieciseis_bytes_a3ba:
	defb 003h,003h,002h,001h,001h,000h,000h,000h,000h,000h,000h,001h,001h,002h,003h,003h	; a3ba  ................

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a3ca: 4 bytes para (ix+0x16) cuando el bit 0 de (ix+0x15)
;   esta puesto (p06:A2D2)
;   0xa3ca..0xa3ce  (4 bytes)
DATA_cuatro_bytes_a3ca:
	defb 02ch,04ch,06ch,08ch	; a3ca

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a3ce: 4 bytes para (ix+0x16) cuando no lo esta (p06:A2CD)
;   0xa3ce..0xa3d2  (4 bytes)
DATA_cuatro_bytes_a3ce:
	defb 03ch,05ch,07ch,09ch	; a3ce

; ----------------------------------------------------------------------
; DATOS ocho_bytes_a3d2: 8 bytes que p06:A2B9 pone en (ix+0x17) segun
;   (ix+0x18) mod 8
;   0xa3d2..0xa3da  (8 bytes)
DATA_ocho_bytes_a3d2:
	defb 000h,000h,001h,000h,000h,000h,000h,001h	; a3d2  ........

; ----------------------------------------------------------------------
; DATOS ocho_bytes_a3da: 8 bytes que p06:A2C3 elige igual
;   0xa3da..0xa3e2  (8 bytes)
DATA_ocho_bytes_a3da:
	defb 003h,001h,002h,003h,001h,003h,000h,001h	; a3da  ........

; ======================================================================
; CODIGO 0xa3e2..0xa412  (48 bytes)
; ======================================================================


L_A3E2:
	ld (ix+017h),00ah		;a3e2
	ld (ix+008h),008h		;a3e6
	ld (ix+018h),004h		;a3ea
	ld (ix+015h),001h		;a3ee
	ld (ix+013h),003h		;a3f2
	ld (ix+016h),00ah		;a3f6
	ld (ix+012h),005h		;a3fa
	jp 09db3h		;a3fe
L_A401:
	ld hl,0b071h		;a401
	push hl			;a404
	ld a,(ix+01ah)		;a405
	or a			;a408
	jp nz,09e54h		;a409
	ld a,(ix+001h)		;a40c
	call 04050h		;a40f   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A412: 3 destinos del despachador de 0x4140 (call en p06:A40F):
;   0xA418, 0xA41E, 0xA421; lo leen p06:A40F (6 bytes)
;   0xa412..0xa418  (6 bytes)
DATA_tabla_A412:
	defb 018h,0a4h	; a412
	defb 01eh,0a4h	; a414
	defb 021h,0a4h	; a416

; ======================================================================
; CODIGO 0xa418..0xa427  (15 bytes)
; ======================================================================


L_A418:
	ld hl,0a427h		;a418
	jp 09dd8h		;a41b
L_A41E:
	jp 09dfeh		;a41e
L_A421:
	ld hl,0a427h		;a421
	jp 09e2dh		;a424

; ----------------------------------------------------------------------
; DATOS tres_bytes_a427: 3 bytes que p06:A418 y p06:A421 pasan en HL a
;   p05:9DD8 y p05:9E2D
;   0xa427..0xa42a  (3 bytes)
DATA_tres_bytes_a427:
	defb 0a0h,0a4h,0a8h	; a427

; ======================================================================
; CODIGO 0xa42a..0xa558  (302 bytes)
; ======================================================================


L_A42A:
	call 06b71h		;a42a
	ld (ix+00ah),0cch		;a42d
	ld a,(ix+007h)		;a431
	ld (ix+014h),a		;a434
	ld a,(ix+005h)		;a437
	ld (ix+015h),a		;a43a
	ld (ix+01bh),010h		;a43d
	ld (ix+018h),006h		;a441
	ld (ix+01ah),030h		;a445
	ld (ix+01fh),008h		;a449
L_A44D:
	call 081f1h		;a44d
	and 02fh		;a450
	add a,010h		;a452
	ld (ix+012h),a		;a454
	ret			;a457
L_A458:
	call L_A527		;a458
	dec (ix+01fh)		;a45b
	jr nz,L_A47A		;a45e
	call 081f1h		;a460
	and 020h		;a463
	add a,020h		;a465
	ld (ix+01fh),a		;a467
	ld a,r		;a46a
	and 003h		;a46c
	ld hl,0a558h		;a46e
	call 04053h		;a471   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld (ix+00fh),e		;a474
	ld (ix+00dh),d		;a477
L_A47A:
	call L_A4E4		;a47a
	ld a,(ix+001h)		;a47d
	or a			;a480
	jr nz,L_A490		;a481
	ld bc,00010h		;a483
	call L_A4AD		;a486
	ld a,028h		;a489
	call L_A4BB		;a48b
	jr L_A49B		;a48e
L_A490:
	ld bc,0fff0h		;a490
	call L_A4AD		;a493
	ld a,005h		;a496
	call L_A4BB		;a498
L_A49B:
	call L_A92F		;a49b
	ld a,(ix+01ch)		;a49e
	ld (ix+005h),a		;a4a1
	ld a,(ix+01dh)		;a4a4
	ld (ix+007h),a		;a4a7
	jp L_A530		;a4aa
L_A4AD:
	ld h,(ix+017h)		;a4ad
	ld l,(ix+016h)		;a4b0
	add hl,bc			;a4b3
	ld (ix+017h),h		;a4b4
	ld (ix+016h),l		;a4b7
	ret			;a4ba
L_A4BB:
	bit 0,(ix+001h)		;a4bb
	jr nz,L_A4CB		;a4bf
	cp (ix+017h)		;a4c1
	ret nc			;a4c4
	ld (ix+017h),028h		;a4c5
	jr L_A4D3		;a4c9
L_A4CB:
	cp (ix+017h)		;a4cb
	ret c			;a4ce
	ld (ix+017h),005h		;a4cf
L_A4D3:
	dec (ix+01ah)		;a4d3
	ret nz			;a4d6
	ld (ix+01ah),030h		;a4d7
	ld a,(ix+001h)		;a4db
	xor 001h		;a4de
	ld (ix+001h),a		;a4e0
	ret			;a4e3
L_A4E4:
	dec (ix+01fh)		;a4e4
	ret nz			;a4e7
	ld (ix+01fh),008h		;a4e8
	ld a,(ix+00fh)		;a4ec
	add a,(ix+014h)		;a4ef
	ld (ix+014h),a		;a4f2
	ld a,(ix+00dh)		;a4f5
	add a,(ix+015h)		;a4f8
	ld (ix+015h),a		;a4fb
	ld a,(ix+014h)		;a4fe
	cp 040h		;a501
	jr nc,L_A50B		;a503
	ld (ix+014h),030h		;a505
	jr L_A513		;a509
L_A50B:
	cp 0c0h		;a50b
	jr c,L_A513		;a50d
	ld (ix+014h),0d0h		;a50f
L_A513:
	ld a,(ix+015h)		;a513
	cp 048h		;a516
	jr nc,L_A51F		;a518
	ld (ix+015h),050h		;a51a
	ret			;a51e
L_A51F:
	cp 080h		;a51f
	ret c			;a521
	ld (ix+015h),088h		;a522
L_A526:
	ret			;a526
L_A527:
	ld d,004h		;a527
	ld b,000h		;a529
	ld e,008h		;a52b
	jp L_B0D6		;a52d
L_A530:
	dec (ix+012h)		;a530
	ret nz			;a533
	call L_A44D		;a534
	ld a,(ix+005h)		;a537
	add a,008h		;a53a
	ld d,a			;a53c
	ld a,(ix+007h)		;a53d
	add a,008h		;a540
	ld e,a			;a542
	ld a,04bh		;a543
	jp 06551h		;a545
L_A548:
	call 06c42h		;a548
	ld a,060h		;a54b
L_A54D:
	call L_B18F		;a54d
	call L_B133		;a550
	ld a,00fh		;a553
	jp 04059h		;a555   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)

; ----------------------------------------------------------------------
; DATOS cuatro_palabras_a558: 4 palabras que p06:A46E elige al azar (R) para
;   (ix+0x0F) y (ix+0x0D)
;   0xa558..0xa560  (8 bytes)
DATA_cuatro_palabras_a558:
	defb 001h,000h	; a558
	defb 000h,0ffh	; a55a
	defb 0ffh,000h	; a55c
	defb 000h,001h	; a55e

; ======================================================================
; CODIGO 0xa560..0xa5b3  (83 bytes)
; ======================================================================


L_A560:
	ld hl,0e507h		;a560   ; apunta a la x del personaje
	ld a,(0e707h)		;a563   ; lee la x del jefe
	cp (hl)			;a566
	jr c,L_A56C		;a567
	xor a			;a569
	jr L_A578		;a56a
L_A56C:
	ld a,(0e707h)		;a56c   ; lee la x del jefe
	add a,040h		;a56f
	cp (hl)			;a571
	ld a,003h		;a572
	jr nc,L_A578		;a574
	ld a,006h		;a576
L_A578:
	ld (ix+014h),a		;a578
	ld hl,0e505h		;a57b   ; apunta a la y del personaje
	ld a,(0e705h)		;a57e   ; lee la y del jefe
	cp (hl)			;a581
	jr nc,L_A58F		;a582
	add a,040h		;a584
	cp (hl)			;a586
	jr nc,L_A58C		;a587
	inc (ix+014h)		;a589
L_A58C:
	inc (ix+014h)		;a58c
L_A58F:
	ld a,(ix+014h)		;a58f
	ld hl,0a5d7h		;a592
	call 04083h		;a595   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+00ah),a		;a598
	ld a,(ix+014h)		;a59b
	ld hl,0a5b3h		;a59e
	call 04053h		;a5a1   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call L_B13E		;a5a4
	ld a,(ix+014h)		;a5a7
	ld hl,0a5c5h		;a5aa
	call 04053h		;a5ad   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	jp L_B137		;a5b0

; ----------------------------------------------------------------------
; DATOS nueve_palabras_a5b3: 9 palabras que p06:A59E elige con (ix+0x14) y
;   pasa a p06:B13E
;   0xa5b3..0xa5c5  (18 bytes)
DATA_nueve_palabras_a5b3:
	defb 096h,0feh	; a5b3
	defb 000h,0feh	; a5b5
	defb 096h,0feh	; a5b7
	defb 000h,000h	; a5b9
	defb 000h,000h	; a5bb
	defb 000h,000h	; a5bd
	defb 06ah,001h	; a5bf
	defb 000h,002h	; a5c1
	defb 06ah,001h	; a5c3

; ----------------------------------------------------------------------
; DATOS nueve_palabras_a5c5: 9 palabras que p06:A5AA elige igual
;   0xa5c5..0xa5d7  (18 bytes)
DATA_nueve_palabras_a5c5:
	defb 096h,0feh	; a5c5
	defb 000h,000h	; a5c7
	defb 06ah,001h	; a5c9
	defb 000h,0feh	; a5cb
	defb 000h,002h	; a5cd
	defb 000h,002h	; a5cf
	defb 096h,0feh	; a5d1
	defb 000h,000h	; a5d3
	defb 06ah,001h	; a5d5

; ----------------------------------------------------------------------
; DATOS nueve_bytes_a5d7: 9 bytes que p06:A592 pone en (ix+0x0A) segun
;   (ix+0x14)
;   0xa5d7..0xa5e0  (9 bytes)
DATA_nueve_bytes_a5d7:
	defb 0b0h,0a8h,0ach,0a0h,0a4h,0a4h,0bch,0b4h,0b8h	; a5d7  .........

; ======================================================================
; CODIGO 0xa5e0..0xa601  (33 bytes)
; ======================================================================


L_A5E0:
	call 06b71h		;a5e0
	ld (ix+018h),008h		;a5e3
	ld (ix+017h),032h		;a5e7
	ld a,(0e71ah)		;a5eb
	ld (ix+01ah),a		;a5ee
	jr $+86		;a5f1
L_A5F3:
	bit 0,(ix+01fh)		;a5f3
	ld a,(0e71bh)		;a5f7   ; lee el suelo del jefe 11
	jr z,L_A5FE		;a5fa
	ld a,003h		;a5fc
L_A5FE:
	call 04050h		;a5fe   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A601: 5 destinos del despachador de 0x4140 (call en p06:A5FE):
;   0xA60B, 0xA644, 0xA647, 0xA65A, 0xA6D1; lo leen p06:A5FE (10 bytes)
;   0xa601..0xa60b  (10 bytes)
DATA_tabla_A601:
	defb 00bh,0a6h	; a601
	defb 044h,0a6h	; a603
	defb 047h,0a6h	; a605
	defb 05ah,0a6h	; a607
	defb 0d1h,0a6h	; a609

; ======================================================================
; CODIGO 0xa60b..0xa798  (397 bytes)
; ======================================================================


L_A60B:
	call L_A791		;a60b
	ld a,(0e71ch)		;a60e   ; lee la fila de la cola del jefe 10
	ld c,a			;a611
	rlc a		;a612
	sbc a,a			;a614
	ld b,a			;a615
	ld h,(ix+017h)		;a616
	ld l,(ix+016h)		;a619
	add hl,bc			;a61c
	ld (ix+017h),h		;a61d
	ld (ix+016h),l		;a620
	call L_A73D		;a623
L_A626:
	ld a,0e0h		;a626
	or (ix+002h)		;a628
	ld (ix+002h),a		;a62b
	call L_A92F		;a62e
	call L_A756		;a631
	jp c,096f5h		;a634
	ld a,(ix+01ch)		;a637
	ld (ix+005h),a		;a63a
	ld a,(ix+01dh)		;a63d
	ld (ix+007h),a		;a640
	ret			;a643
L_A644:
	jp 096f5h		;a644
L_A647:
	ld a,(ix+01ah)		;a647
	ld (ix+019h),a		;a64a
L_A64D:
	ld a,(0e71dh)		;a64d   ; lee la espera o el sitio siguiente del jefe
	ld (ix+014h),a		;a650
	ld a,(0e71eh)		;a653
	ld (ix+015h),a		;a656
	ret			;a659
L_A65A:
	call L_A791		;a65a
	ld a,(ix+001h)		;a65d
	ld hl,0e72eh		;a660
	call 04062h		;a663   ; hl_mas_a (por 0x4062): HL += A
	bit 0,(hl)		;a666
	jr nz,L_A678		;a668
	push hl			;a66a
	ld a,l			;a66b
	add a,0fch		;a66c
	ld l,a			;a66e
	ld a,(hl)			;a66f
	cp (ix+019h)		;a670
	pop hl			;a673
	jr nz,L_A6C4		;a674
	set 0,(hl)		;a676
L_A678:
	bit 1,(hl)		;a678
	jr nz,L_A68F		;a67a
	push hl			;a67c
	ld a,l			;a67d
	add a,0f8h		;a67e
	ld l,a			;a680
	ld a,(hl)			;a681
	cp 009h		;a682
	pop hl			;a684
	jr c,L_A68F		;a685
	call L_B15F		;a687
	call L_B16F		;a68a
	set 1,(hl)		;a68d
L_A68F:
	ld a,(ix+001h)		;a68f
	ld hl,0e726h		;a692
	call 04062h		;a695   ; hl_mas_a (por 0x4062): HL += A
	inc (hl)			;a698
	ld a,(hl)			;a699
	cp 011h		;a69a
	jr nc,L_A6C7		;a69c
	ld e,(ix+012h)		;a69e
	ld d,(ix+014h)		;a6a1
	ld l,(ix+00eh)		;a6a4
	ld h,(ix+00fh)		;a6a7
	add hl,de			;a6aa
	ld (ix+012h),l		;a6ab
	ld (ix+014h),h		;a6ae
	ld e,(ix+013h)		;a6b1
	ld d,(ix+015h)		;a6b4
	ld l,(ix+00ch)		;a6b7
	ld h,(ix+00dh)		;a6ba
	add hl,de			;a6bd
	ld (ix+013h),l		;a6be
	ld (ix+015h),h		;a6c1
L_A6C4:
	jp L_A626		;a6c4
L_A6C7:
	ld (ix+01fh),000h		;a6c7
	call L_A64D		;a6cb
	jp L_A626		;a6ce
L_A6D1:
	call L_A791		;a6d1
	ld a,(0e722h)		;a6d4   ; lee el jefe 7 ha mordido
	or a			;a6d7
	ret z			;a6d8
	push ix		;a6d9
	pop de			;a6db
	ld b,004h		;a6dc
L_A6DE:
	ld hl,0e724h		;a6de
	ld a,(hl)			;a6e1
	cp e			;a6e2
	jr z,L_A6EC		;a6e3
	ret nc			;a6e5
	call L_A727		;a6e6
	djnz L_A6DE		;a6e9
	ret			;a6eb
L_A6EC:
	ld hl,0e723h		;a6ec
	ld (hl),001h		;a6ef
	ld hl,0e732h		;a6f1
	ld a,(hl)			;a6f4
	ld (ix+001h),a		;a6f5
	inc (hl)			;a6f8
	ld (ix+01fh),001h		;a6f9
	ld a,(0e720h)		;a6fd
	push af			;a700
	ld b,008h		;a701
	call 07e25h		;a703
	bit 7,(ix+00fh)		;a706
	res 1,(ix+01eh)		;a70a
	jr z,L_A714		;a70e
	set 1,(ix+01eh)		;a710
L_A714:
	pop af			;a714
	ld hl,0a798h		;a715
	call 04083h		;a718   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	push af			;a71b
	ld a,(ix+001h)		;a71c
	ld hl,0e72ah		;a71f
	call 04062h		;a722   ; hl_mas_a (por 0x4062): HL += A
	pop af			;a725
	ld (hl),a			;a726
L_A727:
	ld hl,0e722h		;a727   ; apunta a el jefe 7 ha mordido
	dec (hl)			;a72a
	ld hl,0e724h		;a72b
	ld a,(hl)			;a72e
	add a,020h		;a72f
	ld (hl),a			;a731
	ld a,(0e720h)		;a732
	sub 004h		;a735
	and 00fh		;a737
	ld (0e720h),a		;a739
	ret			;a73c
L_A73D:
	ld a,(ix+017h)		;a73d
	cp 018h		;a740
	jr nc,L_A749		;a742
	ld (ix+017h),018h		;a744
	ret			;a748
L_A749:
	cp 032h		;a749
	ret c			;a74b
	ld (ix+017h),032h		;a74c
	ld hl,0e71fh		;a750   ; apunta a la espera hasta que el jefe escupe
	ld (hl),000h		;a753
	ret			;a755
L_A756:
	ld a,(ix+01ch)		;a756
	cp 008h		;a759
	ret c			;a75b
	cp 0b8h		;a75c
	ccf			;a75e
	ret c			;a75f
	ld a,(ix+01dh)		;a760
	bit 7,(ix+014h)		;a763
	jr z,L_A76B		;a767
	add a,007h		;a769
L_A76B:
	sub (ix+014h)		;a76b
	ld c,a			;a76e
	ld a,(ix+014h)		;a76f
	add a,c			;a772
	rra			;a773
	xor c			;a774
	rla			;a775
	ret nc			;a776
	xor a			;a777
	bit 0,(ix+01fh)		;a778
	ret z			;a77c
	bit 7,(ix+014h)		;a77d
	jr nz,L_A78A		;a781
	bit 1,(ix+01eh)		;a783
	ret z			;a787
	scf			;a788
	ret			;a789
L_A78A:
	bit 1,(ix+01eh)		;a78a
	ret nz			;a78e
	scf			;a78f
	ret			;a790
L_A791:
	ld a,(0e733h)		;a791
	ld (ix+00bh),a		;a794
	ret			;a797

; ----------------------------------------------------------------------
; DATOS dieciseis_bytes_a798: 16 bytes que p06:A715 lee con 0x4083
;   0xa798..0xa7a8  (16 bytes)
DATA_dieciseis_bytes_a798:
	defb 0c0h,0b0h,0a0h,090h,080h,070h,060h,050h,040h,030h,020h,010h,000h,0f0h,0e0h,0d0h	; a798  .....p`P@0 .....

; ======================================================================
; CODIGO 0xa7a8..0xad41  (1433 bytes)
; ======================================================================


L_A7A8:
	ld (ix+01eh),0a1h		;a7a8
	ld (ix+001h),001h		;a7ac
	ld de,0ff80h		;a7b0
	call L_B145		;a7b3
L_A7B6:
	ld a,r		;a7b6
	bit 0,a		;a7b8
	ld de,00100h		;a7ba
	call nz,04068h		;a7bd   ; de_negado (por 0x4068): DE = -DE
	jp L_B13E		;a7c0
L_A7C3:
	ld a,(ix+001h)		;a7c3
	dec a			;a7c6
	jr z,L_A7E2		;a7c7
	dec (ix+008h)		;a7c9
	ret nz			;a7cc
	set 4,(ix+002h)		;a7cd
	ld (ix+00ah),0c8h		;a7d1
	ld (ix+011h),067h		;a7d5
	ld de,00400h		;a7d9
	call L_B137		;a7dc
	jp 09a07h		;a7df
L_A7E2:
	call L_A7F7		;a7e2
	ret c			;a7e5
	ld a,(ix+00dh)		;a7e6
	or a			;a7e9
	jp p,L_B14C		;a7ea
	cp 0fah		;a7ed
	jp c,L_B14C		;a7ef
	ld (ix+00dh),0fah		;a7f2
	ret			;a7f6
L_A7F7:
	ld a,(ix+005h)		;a7f7
	cp (ix+01eh)		;a7fa
	ret nc			;a7fd
	ld bc,00020h		;a7fe
	call 07087h		;a801
	ret nc			;a804
	ld a,(ix+005h)		;a805
	and 0f8h		;a808
	add a,008h		;a80a
	ld (ix+005h),a		;a80c
	sub 020h		;a80f
	ld (ix+01eh),a		;a811
	call L_A7B6		;a814
	call 06b71h		;a817
	ld (ix+00ah),0c4h		;a81a
	ld (ix+011h),066h		;a81e
	dec (ix+001h)		;a822
	ld (ix+008h),03ch		;a825
	ld a,00bh		;a829
	call 04059h		;a82b   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	scf			;a82e
	ret			;a82f
L_A830:
	ld de,00080h		;a830
	call L_B13E		;a833
	ld a,r		;a836
	and 001h		;a838
	call z,L_B15F		;a83a
	ld a,(ix+005h)		;a83d
	ld (ix+016h),a		;a840
	ld (ix+008h),00ah		;a843
	ret			;a847
L_A848:
	ld a,(ix+001h)		;a848
	or a			;a84b
	jr nz,L_A8AE		;a84c
	call L_A8D6		;a84e
	call 06beeh		;a851
	jr nc,L_A85D		;a854
	call 06c04h		;a856
	call c,L_B15F		;a859
	ret			;a85c
L_A85D:
	bit 7,(ix+00fh)		;a85d
	jr z,L_A86F		;a861
	ld a,(ix+007h)		;a863
	cp 038h		;a866
	jp c,L_B15F		;a868
	add a,0d3h		;a86b
	jr L_A879		;a86d
L_A86F:
	ld a,(ix+007h)		;a86f
	cp 0b8h		;a872
	jp nc,L_B15F		;a874
	add a,030h		;a877
L_A879:
	ld h,a			;a879
	ld (ix+01eh),a		;a87a
	ld a,(ix+005h)		;a87d
	ld (ix+01fh),a		;a880
	add a,010h		;a883
	ld l,a			;a885
	call 0406eh		;a886   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jp nc,L_B15F		;a889
	call 04071h		;a88c   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
	jp nc,L_B15F		;a88f
	call 096feh		;a892
	jp nc,L_B15F		;a895
	inc (ix+001h)		;a898
	ld de,0fde0h		;a89b
	call L_B137		;a89e
	ld de,00160h		;a8a1
L_A8A4:
	bit 7,(ix+00fh)		;a8a4
	call nz,04068h		;a8a8   ; de_negado (por 0x4068): DE = -DE
	jp L_B13E		;a8ab
L_A8AE:
	ld a,(ix+016h)		;a8ae
	cp (ix+005h)		;a8b1
	jr c,L_A8C8		;a8b4
	ld (ix+00ah),0a4h		;a8b6
	ld de,00022h		;a8ba
	ld h,(ix+00dh)		;a8bd
	ld l,(ix+00ch)		;a8c0
	add hl,de			;a8c3
	ex de,hl			;a8c4
	jp L_B137		;a8c5
L_A8C8:
	dec (ix+001h)		;a8c8
	ld (ix+005h),a		;a8cb
	call L_B129		;a8ce
	ld de,00080h		;a8d1
	jr L_A8A4		;a8d4
L_A8D6:
	ld d,004h		;a8d6
	ld e,00ah		;a8d8
	ld b,001h		;a8da
	jp L_B0D6		;a8dc
L_A8DF:
	call 06b71h		;a8df
	ld a,(ix+005h)		;a8e2
	ld (ix+015h),a		;a8e5
	xor a			;a8e8
	ld (ix+016h),a		;a8e9
	ld (ix+017h),a		;a8ec
	ld (ix+018h),008h		;a8ef
	ld (ix+01bh),080h		;a8f3
	call 081f1h		;a8f7
	and 001h		;a8fa
	ld (ix+01eh),a		;a8fc
	ld b,(ix+007h)		;a8ff
	ld a,00ah		;a902
	jr z,L_A908		;a904
	neg		;a906
L_A908:
	add a,b			;a908
	ld (ix+014h),a		;a909
	ret			;a90c
L_A90D:
	ld l,(ix+016h)		;a90d
	ld h,(ix+017h)		;a910
	ld b,000h		;a913
	ld c,(ix+01bh)		;a915
	add hl,bc			;a918
	ld (ix+016h),l		;a919
	ld (ix+017h),h		;a91c
	call L_A92F		;a91f
	ld a,(ix+01ch)		;a922
	ld (ix+005h),a		;a925
	ld a,(ix+01dh)		;a928
	ld (ix+007h),a		;a92b
	ret			;a92e
L_A92F:
	ld a,(ix+018h)		;a92f
	add a,(ix+019h)		;a932
	ld (ix+019h),a		;a935
	call L_A958		;a938
	add a,(ix+015h)		;a93b
	ld (ix+01ch),a		;a93e
	bit 0,(ix+01eh)		;a941
	ld a,040h		;a945
	jr z,L_A94B		;a947
	ld a,0c0h		;a949
L_A94B:
	add a,(ix+019h)		;a94b
	call L_A958		;a94e
	add a,(ix+014h)		;a951
	ld (ix+01dh),a		;a954
	ret			;a957
L_A958:
	ld c,a			;a958
	bit 6,a		;a959
	jr z,L_A95E		;a95b
	cpl			;a95d
L_A95E:
	and 03fh		;a95e
	ld hl,0b374h		;a960
	call 04062h		;a963   ; hl_mas_a (por 0x4062): HL += A
	ld e,(hl)			;a966
	ld h,(ix+017h)		;a967
	call 0406bh		;a96a   ; multiplica (por 0x406B): HL = H x E
	ld a,h			;a96d
	bit 7,c		;a96e
	ret z			;a970
	neg		;a971
	ret			;a973
L_A974:
	ld hl,0e637h		;a974
	ld a,(hl)			;a977
	ld (ix+014h),a		;a978
	inc (hl)			;a97b
	call 07da8h		;a97c
L_A97F:
	call 06b71h		;a97f
	ld (ix+01dh),01ah		;a982
	ld (ix+01eh),008h		;a986
	ld (ix+01fh),020h		;a98a
	ld de,00100h		;a98e
	call L_B13E		;a991
	call L_AA6C		;a994
	ld a,(ix+016h)		;a997
	jp 07083h		;a99a   ; dos_sprites_tabla: dos sprites de la tabla 0x70BE
L_A99D:
	dec (ix+015h)		;a99d
	ret nz			;a9a0
	inc (ix+015h)		;a9a1
	ld hl,0b06ch		;a9a4
	push hl			;a9a7
	call L_AA9E		;a9a8
	dec a			;a9ab
	jr z,L_A9C7		;a9ac
	jp p,L_AA1C		;a9ae
	jr L_A9DE		;a9b1
L_A9B3:
	dec (ix+015h)		;a9b3
	ret nz			;a9b6
	inc (ix+015h)		;a9b7
	ld hl,0b06ch		;a9ba
	push hl			;a9bd
	call L_AA9E		;a9be
	dec a			;a9c1
	jr z,L_A9DE		;a9c2
	jp p,L_AA1C		;a9c4
L_A9C7:
	call 06b76h		;a9c7
	call L_A9E1		;a9ca
	bit 0,(ix+01ah)		;a9cd
	jr nz,L_A9F8		;a9d1
	call L_AA1C		;a9d3
	ld a,(ix+01bh)		;a9d6
	or a			;a9d9
	ret nz			;a9da
	jp L_AA65		;a9db
L_A9DE:
	call 06b71h		;a9de
L_A9E1:
	ld a,(ix+000h)		;a9e1
	cp 02ch		;a9e4
	jr z,L_A9F0		;a9e6
	ld a,(ix-020h)		;a9e8
	or a			;a9eb
	jp z,L_A9F8		;a9ec
	ret			;a9ef
L_A9F0:
	ld a,(ix+020h)		;a9f0
	or a			;a9f3
	jp z,L_A9F8		;a9f4
	ret			;a9f7
L_A9F8:
	ld (ix+01ah),001h		;a9f8
	ld (ix+01dh),00dh		;a9fc
	ld (ix+01eh),006h		;aa00
	ld (ix+01fh),011h		;aa04
	bit 7,(ix+00fh)		;aa08
	ld de,00200h		;aa0c
	call nz,04068h		;aa0f   ; de_negado (por 0x4068): DE = -DE
	call L_B13E		;aa12
	ld a,002h		;aa15
L_AA17:
	call L_AA94		;aa17
	ld (hl),a			;aa1a
	ret			;aa1b
L_AA1C:
	call 06b76h		;aa1c
	call 06beeh		;aa1f
	jr nc,L_AA29		;aa22
	call 06c04h		;aa24
	jr nc,L_AA2F		;aa27
L_AA29:
	call L_B15F		;aa29
	call L_AA6C		;aa2c
L_AA2F:
	inc (ix+01bh)		;aa2f
	ld a,(ix+01bh)		;aa32
	cp (ix+01dh)		;aa35
	jr c,L_AA45		;aa38
	call 06b71h		;aa3a
	ld a,(ix+019h)		;aa3d
	ld (ix+00ah),a		;aa40
	jr L_AA56		;aa43
L_AA45:
	cp (ix+01eh)		;aa45
	jr c,L_AA50		;aa48
	ld a,(ix+018h)		;aa4a
L_AA4D:
	jp 07083h		;aa4d   ; dos_sprites_tabla: dos sprites de la tabla 0x70BE
L_AA50:
	ld a,(ix+017h)		;aa50
	ld (ix+00ah),a		;aa53
L_AA56:
	ld a,(ix+01bh)		;aa56
	sub (ix+01fh)		;aa59
	ret nz			;aa5c
	ld (ix+01bh),a		;aa5d
	ld a,(ix+016h)		;aa60
	jr L_AA4D		;aa63
L_AA65:
	call L_AA9E		;aa65
	xor 001h		;aa68
	jr L_AA17		;aa6a
L_AA6C:
	bit 7,(ix+00fh)		;aa6c
	jr nz,L_AA83		;aa70
	ld (ix+016h),0a0h		;aa72
	ld (ix+017h),0a4h		;aa76
	ld (ix+018h),0a8h		;aa7a
	ld (ix+019h),0ach		;aa7e
	ret			;aa82
L_AA83:
	ld (ix+016h),0b0h		;aa83
	ld (ix+017h),0b4h		;aa87
	ld (ix+018h),0b8h		;aa8b
	ld (ix+019h),0bch		;aa8f
	ret			;aa93
L_AA94:
	ld b,000h		;aa94
	ld c,(ix+014h)		;aa96
	ld hl,0e638h		;aa99
	add hl,bc			;aa9c
	ret			;aa9d
L_AA9E:
	call L_AA94		;aa9e
	ld a,(hl)			;aaa1
	ret			;aaa2
L_AAA3:
	call 06b71h		;aaa3
	ld a,(ix-00ch)		;aaa6
	ld (ix+014h),a		;aaa9
	ld a,(ix-00bh)		;aaac
	ld (ix+015h),a		;aaaf
	jp L_A97F		;aab2
L_AAB5:
	ld a,(ix+002h)		;aab5
	and 0cfh		;aab8
	ld (ix+002h),a		;aaba
L_AABD:
	ret			;aabd
L_AABE:
	call 0907fh		;aabe
	ld a,(0f031h)		;aac1
	or a			;aac4
	ret nz			;aac5
	ld a,(0f030h)		;aac6
	or a			;aac9
	jr nz,L_AAE0		;aaca
	call 081f1h		;aacc
	and 003h		;aacf
	ld b,a			;aad1
	call 081f1h		;aad2
	and 007h		;aad5
	add a,b			;aad7
	ld (0f033h),a		;aad8
	ld a,001h		;aadb
	ld (0f030h),a		;aadd
L_AAE0:
	ld hl,0f032h		;aae0
	ld a,(0f033h)		;aae3
	cp (hl)			;aae6
	jr z,L_AAEB		;aae7
	inc (hl)			;aae9
	ret			;aaea
L_AAEB:
	inc (ix+01fh)		;aaeb
	ld a,001h		;aaee
	ld (0f031h),a		;aaf0
L_AAF3:
	ret			;aaf3
L_AAF4:
	ld de,00100h		;aaf4
	call L_B137		;aaf7
L_AAFA:
	ld a,(ix+005h)		;aafa
	cp 020h		;aafd
	jr nc,L_AB0B		;aaff
	ld (ix+014h),000h		;ab01
	call L_AB33		;ab05
	jp L_B137		;ab08
L_AB0B:
	call L_AB20		;ab0b
	jr nc,L_AB1B		;ab0e
	call L_B16F		;ab10
	ld a,(ix+014h)		;ab13
	xor 001h		;ab16
	ld (ix+014h),a		;ab18
L_AB1B:
	call L_AB33		;ab1b
	jr L_AB7B		;ab1e
L_AB20:
	ld h,(ix+007h)		;ab20
	ld a,(ix+005h)		;ab23
	bit 7,(ix+00dh)		;ab26
	jr nz,L_AB2E		;ab2a
	add a,008h		;ab2c
L_AB2E:
	ld l,a			;ab2e
	call 0406eh		;ab2f   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret			;ab32
L_AB33:
	ld a,(0e507h)		;ab33   ; lee la x del personaje
	sub (ix+007h)		;ab36
	jr nc,L_AB3D		;ab39
	neg		;ab3b
L_AB3D:
	cp 040h		;ab3d
	ld de,00100h		;ab3f
	jr nc,L_AB55		;ab42
	cp 028h		;ab44
	ld de,00180h		;ab46
	jr nc,L_AB55		;ab49
	cp 018h		;ab4b
	ld de,00200h		;ab4d
	jr nc,L_AB55		;ab50
	ld de,00280h		;ab52
L_AB55:
	ld a,(0e505h)		;ab55   ; lee la y del personaje
	sub (ix+005h)		;ab58
	jr nc,L_AB5F		;ab5b
	neg		;ab5d
L_AB5F:
	cp 080h		;ab5f
	ld hl,00100h		;ab61
	ret nc			;ab64
	cp 060h		;ab65
	ld hl,00180h		;ab67
	ret nc			;ab6a
	cp 040h		;ab6b
	ld hl,00200h		;ab6d
	ret nc			;ab70
	cp 020h		;ab71
	ld hl,00280h		;ab73
	ret nc			;ab76
	ld hl,00300h		;ab77
	ret			;ab7a
L_AB7B:
	add hl,de			;ab7b
	ex de,hl			;ab7c
	call L_B137		;ab7d
	bit 0,(ix+014h)		;ab80
	ret z			;ab84
	jp L_B16F		;ab85
L_AB88:
	ld de,00040h		;ab88
	call L_B145		;ab8b
	call 081f1h		;ab8e
	sub 010h		;ab91
	and 0dfh		;ab93
	add a,010h		;ab95
	ld (ix+007h),a		;ab97
	rla			;ab9a
	ld de,00180h		;ab9b
	call c,04068h		;ab9e   ; de_negado (por 0x4068): DE = -DE
	call L_B13E		;aba1
	jp L_B129		;aba4
L_ABA7:
	call 07062h		;aba7
	bit 0,(ix+001h)		;abaa
	jr nz,L_ABCE		;abae
	call L_ABF1		;abb0
	call c,L_B15F		;abb3
	call L_ABE1		;abb6
	jr c,L_ABBE		;abb9
	jp L_B14C		;abbb
L_ABBE:
	inc (ix+001h)		;abbe
	call 09b15h		;abc1
	cp 0b0h		;abc4
	call c,L_B129		;abc6
	ld a,009h		;abc9
	jp 04059h		;abcb   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_ABCE:
	call L_ABF1		;abce
	call c,L_B15F		;abd1
	call L_ABE1		;abd4
	ret c			;abd7
	dec (ix+001h)		;abd8
	ld de,00040h		;abdb
	jp L_B145		;abde
L_ABE1:
	ld a,(ix+005h)		;abe1
	add a,010h		;abe4
	ld l,a			;abe6
	ld a,(ix+007h)		;abe7
	add a,008h		;abea
	ld h,a			;abec
	call 0406eh		;abed   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret			;abf0
L_ABF1:
	call 06c15h		;abf1
	jr nc,L_ABF8		;abf4
	ccf			;abf6
	ret			;abf7
L_ABF8:
	call 06beeh		;abf8
	jp 06c04h		;abfb
L_ABFE:
	call 081f1h		;abfe
	and 001h		;ac01
	dec a			;ac03
	ld (ix+001h),a		;ac04
	jr z,L_AC0C		;ac07
	call 06b71h		;ac09
L_AC0C:
	ld (ix+008h),018h		;ac0c
	ld (ix+011h),066h		;ac10
	ld (ix+014h),000h		;ac14
	call 081f1h		;ac18
	and 001h		;ac1b
	ld de,00100h		;ac1d
	jr z,L_AC25		;ac20
	ld de,00100h		;ac22
L_AC25:
	jp L_B13E		;ac25
L_AC28:
	ld a,(ix+001h)		;ac28
	cp 0ffh		;ac2b
	jp z,L_ACC8		;ac2d
	ld a,(ix+001h)		;ac30
	and a			;ac33
	jr nz,L_AC9B		;ac34
	call L_ACAA		;ac36
	call nc,L_B15F		;ac39
	inc (ix+014h)		;ac3c
	ld a,(ix+014h)		;ac3f
	cp 018h		;ac42
	jr c,L_AC5C		;ac44
	call 06b71h		;ac46
	bit 7,(ix+00fh)		;ac49
	ld a,0cch		;ac4d
	jr nz,L_AC53		;ac4f
	ld a,0d0h		;ac51
L_AC53:
	ld (ix+00ah),a		;ac53
	ld (ix+011h),077h		;ac56
	jr L_AC81		;ac5a
L_AC5C:
	cp 008h		;ac5c
	jr c,L_AC6C		;ac5e
	call 06b76h		;ac60
	ld (ix+00ah),0c8h		;ac63
	ld (ix+011h),074h		;ac67
	ret			;ac6b
L_AC6C:
	call 06b71h		;ac6c
	bit 7,(ix+00fh)		;ac6f
	ld a,0cch		;ac73
	jr z,L_AC79		;ac75
	ld a,0d0h		;ac77
L_AC79:
	ld (ix+00ah),a		;ac79
	ld (ix+011h),077h		;ac7c
	ret			;ac80
L_AC81:
	ld a,(ix+014h)		;ac81
	cp 01ch		;ac84
	ret nz			;ac86
	ld (ix+00ah),0c4h		;ac87
	ld (ix+011h),066h		;ac8b
	ld (ix+008h),018h		;ac8f
	ld a,00bh		;ac93
	call 04059h		;ac95   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_AC98:
	jp 09a07h		;ac98
L_AC9B:
	dec (ix+008h)		;ac9b
	ret nz			;ac9e
	ld (ix+014h),000h		;ac9f
	call 06b76h		;aca3
L_ACA6:
	dec (ix+001h)		;aca6
	ret			;aca9
L_ACAA:
	bit 7,(ix+00fh)		;acaa
	ld a,(ix+007h)		;acae
	jr nz,L_ACB5		;acb1
	add a,010h		;acb3
L_ACB5:
	ld h,a			;acb5
	ld a,(ix+005h)		;acb6
	add a,0feh		;acb9
	ld l,a			;acbb
	call 0406eh		;acbc   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret nc			;acbf
	call 06beeh		;acc0
	call 06c04h		;acc3
	ccf			;acc6
	ret			;acc7
L_ACC8:
	ld a,(0e505h)		;acc8   ; lee la y del personaje
	add a,0e8h		;accb
	cp (ix+005h)		;accd
	ret nz			;acd0
	ld a,(0e507h)		;acd1   ; lee la x del personaje
	add a,0fah		;acd4
	sub (ix+007h)		;acd6
	jr nc,L_ACDD		;acd9
	neg		;acdb
L_ACDD:
	cp 020h		;acdd
	ret nc			;acdf
	jr L_AC98		;ace0
L_ACE2:
	call 04083h		;ace2   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	jp 07083h		;ace5   ; dos_sprites_tabla: dos sprites de la tabla 0x70BE
L_ACE8:
	call L_AD1C		;ace8
	ld a,(ix+01ch)		;aceb
	and a			;acee
	ret z			;acef
	ld b,002h		;acf0
L_ACF2:
	push bc			;acf2
	dec b			;acf3
	ld d,(ix+005h)		;acf4
	ld e,(ix+007h)		;acf7
	ld a,055h		;acfa
	call 06551h		;acfc
	pop bc			;acff
	djnz L_ACF2		;ad00
	jp L_B41C		;ad02
L_AD05:
	ld (ix+014h),008h		;ad05
	res 5,(ix+002h)		;ad09
	ld bc,06f49h		;ad0d
	jp 06ef0h		;ad10
L_AD13:
	dec (ix+014h)		;ad13
	jr nz,L_AD1C		;ad16
	set 5,(ix+002h)		;ad18
L_AD1C:
	call L_AD22		;ad1c
	jp L_B14C		;ad1f
L_AD22:
	ld a,(0e604h)		;ad22   ; lee el contador de cuadros de partida
	and 001h		;ad25
	ret nz			;ad27
	inc (ix+01eh)		;ad28
	ld a,(ix+01eh)		;ad2b
	and 003h		;ad2e
	ld c,a			;ad30
	ld a,(ix+000h)		;ad31
	cp 055h		;ad34
	ld a,c			;ad36
	jr nz,L_AD3B		;ad37
	add a,004h		;ad39
L_AD3B:
	ld hl,0ad41h		;ad3b
	jp 06cbeh		;ad3e

; ----------------------------------------------------------------------
; DATOS ocho_palabras_ad41: 8 palabras que p06:AD3B pasa a p04:6CBE (0x4053
;   con C, mas 4 si el tipo es 0x55)
;   0xad41..0xad51  (16 bytes)
DATA_ocho_palabras_ad41:
	defb 0a0h,06eh	; ad41
	defb 0b4h,06eh	; ad43
	defb 0a4h,06eh	; ad45
	defb 0bch,06eh	; ad47
	defb 0a8h,078h	; ad49
	defb 0b0h,078h	; ad4b
	defb 0ach,078h	; ad4d
	defb 0b8h,078h	; ad4f

; ======================================================================
; CODIGO 0xad51..0xadfb  (170 bytes)
; ======================================================================


L_AD51:
	res 4,(ix+002h)		;ad51
	ld a,(0e624h)		;ad55
	ld (ix+014h),a		;ad58
	and a			;ad5b
	ld b,00ch		;ad5c
	jr z,L_AD62		;ad5e
	ld b,000h		;ad60
L_AD62:
	ld (ix+00ah),b		;ad62
	ld (ix+01fh),001h		;ad65
	bit 1,(ix+014h)		;ad69
	ld (ix+01ch),00dh		;ad6d
	jr z,L_AD77		;ad71
	ld (ix+01ch),009h		;ad73
L_AD77:
	ld a,01ch		;ad77
	call 04059h		;ad79   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld l,(ix+005h)		;ad7c
	ld h,(ix+007h)		;ad7f
	call 04056h		;ad82   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
L_AD85:
	ld (ix+012h),l		;ad85
	ld (ix+013h),h		;ad88
	ret			;ad8b
L_AD8C:
	inc (ix+00ah)		;ad8c
	inc (ix+01fh)		;ad8f
	ld a,(ix+01fh)		;ad92
	cp (ix+01ch)		;ad95
	jp z,L_B41C		;ad98
	ld l,(ix+012h)		;ad9b
	ld h,(ix+013h)		;ad9e
	ld a,(ix+014h)		;ada1
	and a			;ada4
	ret z			;ada5
	ld a,(ix+007h)		;ada6
	sub 008h		;ada9
	ld (ix+007h),a		;adab
	dec hl			;adae
	jp L_AD85		;adaf
L_ADB2:
	call 06c42h		;adb2
	ld a,070h		;adb5
	ld c,a			;adb7
	ld a,(0e045h)		;adb8
	add a,a			;adbb
	add a,a			;adbc
	add a,a			;adbd
	add a,c			;adbe
	ld (0e609h),a		;adbf
	ld de,00808h		;adc2
	call L_B1DB		;adc5
	push af			;adc8
	ld a,(0e624h)		;adc9
	sub 003h		;adcc
	add a,a			;adce
	add a,a			;adcf
	add a,a			;add0
	ld b,a			;add1
	ld a,r		;add2
	and 00fh		;add4
	sub 008h		;add6
	add a,b			;add8
	ld b,a			;add9
	pop af			;adda
	add a,b			;addb
	call L_B1FF		;addc
	call L_B1A3		;addf
	jp L_B133		;ade2
L_ADE5:
	ld b,a			;ade5
	call 081f1h		;ade6
	and 007h		;ade9
	ld hl,0adfbh		;adeb
	call 04083h		;adee   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	add a,b			;adf1
	inc c			;adf2
	ret			;adf3
L_ADF4:
	ld d,004h		;adf4
	ld b,062h		;adf6
	jp L_B17F		;adf8

; ----------------------------------------------------------------------
; DATOS ocho_bytes_adfb: 8 bytes que solo lee el codigo huerfano de p06:ADE5
;   (uno al azar)
;   0xadfb..0xae03  (8 bytes)
DATA_ocho_bytes_adfb:
	defb 000h,010h,018h,020h,0f0h,0e8h,0e0h,000h	; adfb  ... ....

; ======================================================================
; CODIGO 0xae03..0xae2c  (41 bytes)
; ======================================================================


L_AE03:
	call 06c42h		;ae03
	ld a,(0e624h)		;ae06
	rra			;ae09
	push af			;ae0a
	ld b,a			;ae0b
	ld hl,0ae2ch		;ae0c
	call 04053h		;ae0f   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call L_B137		;ae12
	ld a,b			;ae15
	ld hl,0ae3ch		;ae16
	call 04053h		;ae19   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	pop af			;ae1c
	call c,04068h		;ae1d   ; de_negado (por 0x4068): DE = -DE
	call L_B13E		;ae20
	ld de,00080h		;ae23
	jp L_B145		;ae26
L_AE29:
	jp L_B14C		;ae29

; ----------------------------------------------------------------------
; DATOS ocho_palabras_ae2c: 8 palabras que p06:AE0C elige con (0xE624) / 2 y
;   pasa a p06:B137
;   0xae2c..0xae3c  (16 bytes)
DATA_ocho_palabras_ae2c:
	defb 080h,0fbh	; ae2c
	defb 000h,0f8h	; ae2e
	defb 080h,0f8h	; ae30
	defb 000h,0f9h	; ae32
	defb 080h,0f9h	; ae34
	defb 000h,0fah	; ae36
	defb 080h,0fah	; ae38
	defb 000h,0fbh	; ae3a

; ----------------------------------------------------------------------
; DATOS ocho_palabras_ae3c: 8 palabras que p06:AE16 elige igual y pasa a
;   p06:B13E
;   0xae3c..0xae4c  (16 bytes)
DATA_ocho_palabras_ae3c:
	defb 000h,003h	; ae3c
	defb 000h,000h	; ae3e
	defb 000h,002h	; ae40
	defb 000h,003h	; ae42
	defb 000h,001h	; ae44
	defb 000h,004h	; ae46
	defb 000h,003h	; ae48
	defb 000h,002h	; ae4a

; ======================================================================
; CODIGO 0xae4c..0xae5f  (19 bytes)
; ======================================================================


L_AE4C:
	ld (ix+016h),020h		;ae4c
	ld (ix+017h),006h		;ae50
	ld (ix+008h),040h		;ae54
L_AE58:
	ret			;ae58
L_AE59:
	ld a,(ix+001h)		;ae59
	call 04050h		;ae5c   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_AE5F: 3 destinos del despachador de 0x4140 (call en p06:AE5C):
;   0xAE65, 0xAE74, 0xAE8C; lo leen p06:AE5C (6 bytes)
;   0xae5f..0xae65  (6 bytes)
DATA_tabla_AE5F:
	defb 065h,0aeh	; ae5f
	defb 074h,0aeh	; ae61
	defb 08ch,0aeh	; ae63

; ======================================================================
; CODIGO 0xae65..0xaf78  (275 bytes)
; ======================================================================


L_AE65:
	call L_AE9A		;ae65
	dec (ix+008h)		;ae68
	jr nz,L_AEA9		;ae6b
	ld (ix+008h),008h		;ae6d
L_AE71:
	jp 09a07h		;ae71
L_AE74:
	bit 7,(ix+002h)		;ae74
	jr z,L_AE7F		;ae78
	call 096f5h		;ae7a
	jr L_AE82		;ae7d
L_AE7F:
	call 096eeh		;ae7f
L_AE82:
	dec (ix+008h)		;ae82
	jr nz,L_AE9A		;ae85
	call 096f5h		;ae87
	jr L_AE71		;ae8a
L_AE8C:
	call 096abh		;ae8c
	ret nc			;ae8f
	call 096eeh		;ae90
	ld (ix+008h),040h		;ae93
	jp 06bd5h		;ae97
L_AE9A:
	dec (ix+017h)		;ae9a
	ret nz			;ae9d
	ld (ix+017h),006h		;ae9e
	ld d,004h		;aea2
	ld b,000h		;aea4
	jp L_B0DD		;aea6
L_AEA9:
	dec (ix+016h)		;aea9
	ret nz			;aeac
	ld (ix+016h),020h		;aead
	ld a,(ix+005h)		;aeb1
	add a,008h		;aeb4
	ld d,a			;aeb6
	ld a,(ix+007h)		;aeb7
	add a,008h		;aeba
	ld e,a			;aebc
	ld b,000h		;aebd
	ld a,03dh		;aebf
	jp 06551h		;aec1
L_AEC4:
	call 06c42h		;aec4
	ld a,040h		;aec7
	jp L_A54D		;aec9
L_AECC:
	ld a,(0e627h)		;aecc
	or a			;aecf
	ret z			;aed0
	ld hl,0e800h		;aed1   ; apunta a los huecos de figura (32 bytes cada uno)
	ld b,008h		;aed4
L_AED6:
	ld d,h			;aed6
	ld e,l			;aed7
	ld a,020h		;aed8
	add a,e			;aeda
	ld e,a			;aedb
	ld c,b			;aedc
	dec c			;aedd
	ret z			;aede
L_AEDF:
	push hl			;aedf
	push de			;aee0
	ld a,(de)			;aee1
	or a			;aee2
	jr z,L_AF44		;aee3
	ld a,007h		;aee5
	add a,l			;aee7
	ld l,a			;aee8
	ld a,007h		;aee9
	add a,e			;aeeb
	ld e,a			;aeec
	ld a,(de)			;aeed
	sub (hl)			;aeee
	add a,010h		;aeef
	cp 021h		;aef1
	jp nc,L_AF00		;aef3
	cp 005h		;aef6
	jp c,L_AF57		;aef8
	cp 01ch		;aefb
	jp nc,L_AF57		;aefd
L_AF00:
	dec l			;af00
	dec l			;af01
	dec e			;af02
	dec e			;af03
	ld a,(de)			;af04
	sub (hl)			;af05
	add a,010h		;af06
	cp 021h		;af08
	jr nc,L_AF44		;af0a
	exx			;af0c
	cp 010h		;af0d
	ld hl,0afbah		;af0f
	jr nc,L_AF17		;af12
	ld hl,0afd1h		;af14
L_AF17:
	exx			;af17
	inc l			;af18
	inc l			;af19
	inc e			;af1a
	inc e			;af1b
	ld a,(de)			;af1c
	sub (hl)			;af1d
	add a,00bh		;af1e
	cp 017h		;af20
	jr nc,L_AF44		;af22
L_AF24:
	ex af,af'			;af24
	ld a,017h		;af25
	add a,l			;af27
	ld l,a			;af28
	ld a,017h		;af29
	add a,e			;af2b
	ld e,a			;af2c
	ld a,001h		;af2d
	ld (de),a			;af2f
	ld (hl),a			;af30
	ex af,af'			;af31
	exx			;af32
	ld c,a			;af33
	ld b,000h		;af34
	add hl,bc			;af36
	ld a,(hl)			;af37
	exx			;af38
	inc l			;af39
	inc e			;af3a
	ld (hl),a			;af3b
	add a,008h		;af3c
	and 00fh		;af3e
	ld (de),a			;af40
	pop hl			;af41
	pop de			;af42
	ret			;af43
L_AF44:
	pop de			;af44
	pop hl			;af45
	ld a,020h		;af46
	add a,e			;af48
	ld e,a			;af49
	dec c			;af4a
	jp nz,L_AEDF		;af4b
	ld a,020h		;af4e
	add a,l			;af50
	ld l,a			;af51
	dec b			;af52
	jp nz,L_AED6		;af53
	ret			;af56
L_AF57:
	exx			;af57
	cp 005h		;af58
	ld hl,0af78h		;af5a
	jp nc,L_AF63		;af5d
	ld hl,0af99h		;af60
L_AF63:
	exx			;af63
	dec l			;af64
	dec l			;af65
	dec e			;af66
	dec e			;af67
	ld a,(de)			;af68
	sub (hl)			;af69
	add a,010h		;af6a
	cp 021h		;af6c
	jp nc,L_AF44		;af6e
	inc l			;af71
	inc l			;af72
	inc e			;af73
	inc e			;af74
	jp L_AF24		;af75

; ----------------------------------------------------------------------
; DATOS pasos_af78: 33 bytes que p06:AF5A recorre hacia atras (dec l) cuando
;   el valor es 5 o mas
;   0xaf78..0xaf99  (33 bytes)
DATA_pasos_af78:
	defb 005h,005h,005h,005h,005h,005h,005h,005h,006h,006h,006h,007h,007h,007h,008h,008h	; af78  ................
	defb 008h,008h,008h,009h,009h,009h,00ah,00ah,00ah,00bh,00bh,00bh,00bh,00bh,00bh,00bh	; af88  ................
	defb 00bh	; af98

; ----------------------------------------------------------------------
; DATOS pasos_af99: 33 bytes que p06:AF60 recorre igual cuando es menor
;   0xaf99..0xafba  (33 bytes)
DATA_pasos_af99:
	defb 003h,003h,003h,003h,003h,003h,003h,003h,002h,002h,002h,001h,001h,001h,000h,000h	; af99  ................
	defb 000h,000h,000h,00fh,00fh,00fh,00eh,00eh,00eh,00dh,00dh,00dh,00dh,00dh,00dh,00dh	; afa9  ................
	defb 00dh	; afb9

; ----------------------------------------------------------------------
; DATOS pasos_afba: 23 bytes que p06:AF0F recorre hacia delante (inc l) cuando
;   el valor es 0x10 o mas
;   0xafba..0xafd1  (23 bytes)
DATA_pasos_afba:
	defb 007h,007h,007h,006h,006h,006h,005h,005h,005h,004h,004h,004h,004h,004h,003h,003h	; afba  ................
	defb 003h,002h,002h,002h,001h,001h,001h	; afca

; ----------------------------------------------------------------------
; DATOS pasos_afd1: 23 bytes que p06:AF14 recorre igual cuando es menor
;   0xafd1..0xafe8  (23 bytes)
DATA_pasos_afd1:
	defb 009h,009h,009h,00ah,00ah,00ah,00bh,00bh,00bh,00ch,00ch,00ch,00ch,00ch,00dh,00dh	; afd1  ................
	defb 00dh,00eh,00eh,00eh,00fh,00fh,00fh	; afe1

; ======================================================================
; CODIGO 0xafe8..0xb09f  (183 bytes)
; ======================================================================


L_AFE8:
	ld a,(0e62dh)		;afe8
	or a			;afeb
	ret z			;afec
	ld ix,0e800h		;afed   ; apunta a los huecos de figura (32 bytes cada uno)
	ld b,008h		;aff1
L_AFF3:
	push bc			;aff3
	call L_B000		;aff4
	pop bc			;aff7
	ld de,00020h		;aff8
	add ix,de		;affb
	djnz L_AFF3		;affd
	ret			;afff
L_B000:
	ld a,(ix+01dh)		;b000
	and a			;b003
	ret nz			;b004
	ld (ix+01dh),000h		;b005
	call L_B027		;b009
	ret nc			;b00c
	ld a,(ix+005h)		;b00d
	sub d			;b010
	jr nc,L_B015		;b011
	neg		;b013
L_B015:
	cp 012h		;b015
	ret nc			;b017
	ld a,(ix+007h)		;b018
	sub e			;b01b
	jr nc,L_B020		;b01c
	neg		;b01e
L_B020:
	cp 012h		;b020
	ret nc			;b022
	inc (ix+01dh)		;b023
	ret			;b026
L_B027:
	push ix		;b027
	pop hl			;b029
	ld b,010h		;b02a
	ld de,0e800h		;b02c   ; apunta a los huecos de figura (32 bytes cada uno)
L_B02F:
	ld a,(de)			;b02f
	cp 019h		;b030
	jr z,L_B03D		;b032
L_B034:
	ld a,020h		;b034
L_B036:
	call 04065h		;b036   ; de_mas_a (por 0x4065): DE += A
	djnz L_B02F		;b039
	xor a			;b03b
	ret			;b03c
L_B03D:
	ld a,h			;b03d
	cp d			;b03e
	jr nz,L_B045		;b03f
	ld a,l			;b041
	cp e			;b042
	jr z,L_B034		;b043
L_B045:
	ld a,018h		;b045
	call 04065h		;b047   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;b04a
	cp (ix+018h)		;b04b
	jr nz,L_B063		;b04e
	ld a,e			;b050
	sub 018h		;b051
	ld e,a			;b053
	jr nc,L_B057		;b054
	dec d			;b056
L_B057:
	ex de,hl			;b057
	ld a,005h		;b058
	call 04062h		;b05a   ; hl_mas_a (por 0x4062): HL += A
	ld d,(hl)			;b05d
	inc hl			;b05e
	inc hl			;b05f
	ld e,(hl)			;b060
	scf			;b061
	ret			;b062
L_B063:
	ld a,008h		;b063
	jr L_B036		;b065
L_B067:
	ld hl,0b0a7h		;b067
	jr L_B08F		;b06a
L_B06C:
	ld hl,0b0b0h		;b06c
	jr L_B08F		;b06f
L_B071:
	ld hl,0b0b6h		;b071
	jr L_B08F		;b074
L_B076:
	ld hl,0b0c1h		;b076
	jr L_B08F		;b079
L_B07B:
	ld hl,0b0c8h		;b07b
	jr L_B08F		;b07e
L_B080:
	ld hl,0b09fh		;b080
	jr L_B08F		;b083
L_B085:
	ld hl,0b0d0h		;b085
L_B088:
	ld a,(ix+00ah)		;b088
	sub 0c4h		;b08b
	jr L_B094		;b08d
L_B08F:
	ld a,(ix+00ah)		;b08f
L_B092:
	sub 0a0h		;b092
L_B094:
	rra			;b094
	rra			;b095
	and 03fh		;b096
	call 04083h		;b098   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+011h),a		;b09b
	ret			;b09e

; ----------------------------------------------------------------------
; DATOS choque_por_pose: listas de un byte por pose que p06:B08F/B092 pone en
;   (ix+0x11), el indice de las fichas de choque del banco 14: ((ix+0x0A) -
;   0xA0) / 4 (o - 0xC4 desde p06:B088). Empiezan en 0xB09F (p06:B080), 0xB0A7
;   (B067), 0xB0B0 (B06C), 0xB0B6 (B071), 0xB0C1 (B076), 0xB0C8 (B07B) y
;   0xB0D0 (B085)
;   0xb09f..0xb0d6  (55 bytes)
DATA_choque_por_pose:
	defb 02ah,000h,02ah,002h,016h,000h,016h,056h,051h,052h,052h,053h,054h,02ah,02ah,016h	; b09f  *.*....VQRRST**.
	defb 016h,00bh,00ch,00ch,00bh,00dh,00dh,02dh,02eh,01ah,02fh,02fh,030h,01ah,015h,031h	; b0af  .......-..//0..1
	defb 00ch,000h,038h,01eh,019h,016h,013h,02ah,013h,00ah,013h,013h,013h,013h,016h,013h	; b0bf  ..8....*........
	defb 02ah,04dh,00ch,00ch,050h,050h,007h	; b0cf

; ======================================================================
; CODIGO 0xb0d6..0xb274  (414 bytes)
; ======================================================================


L_B0D6:
	dec (ix+008h)		;b0d6
	ret nz			;b0d9
	ld (ix+008h),e		;b0da
L_B0DD:
	ld a,(ix+00ah)		;b0dd
	xor d			;b0e0
	ld (ix+00ah),a		;b0e1
	ld a,(ix+011h)		;b0e4
	xor b			;b0e7
	ld (ix+011h),a		;b0e8
	xor a			;b0eb
	ret			;b0ec
L_B0ED:
	push ix		;b0ed
	pop hl			;b0ef
	ld a,l			;b0f0
	add a,004h		;b0f1
	ld l,a			;b0f3
	ld d,h			;b0f4
	ld e,l			;b0f5
	ld a,e			;b0f6
	add a,008h		;b0f7
	ld e,a			;b0f9
	ld a,(ix+000h)		;b0fa
	cp 024h		;b0fd
	jr z,L_B11F		;b0ff
	cp 025h		;b101
	jr z,L_B11F		;b103
	cp 00dh		;b105
	jr z,L_B11F		;b107
	cp 02dh		;b109
	jr z,L_B11F		;b10b
	cp 00ah		;b10d
	jr z,L_B11F		;b10f
	call L_B114		;b111
L_B114:
	ld a,(de)			;b114
	add a,(hl)			;b115
	ld (hl),a			;b116
L_B117:
	inc l			;b117
	inc e			;b118
	ld a,(de)			;b119
	adc a,(hl)			;b11a
	ld (hl),a			;b11b
	inc l			;b11c
	inc e			;b11d
	ret			;b11e
L_B11F:
	call L_B117		;b11f
	jr L_B114		;b122
L_B124:
	call L_B12E		;b124
	jr L_B137		;b127
L_B129:
	ld d,000h		;b129
	ld e,d			;b12b
	jr L_B137		;b12c
L_B12E:
	ld d,000h		;b12e
	ld e,d			;b130
	jr L_B13E		;b131
L_B133:
	call L_B13E		;b133
	ex de,hl			;b136
L_B137:
	ld (ix+00ch),e		;b137
	ld (ix+00dh),d		;b13a
	ret			;b13d
L_B13E:
	ld (ix+00eh),e		;b13e
	ld (ix+00fh),d		;b141
	ret			;b144
L_B145:
	ld (ix+016h),e		;b145
	ld (ix+017h),d		;b148
	ret			;b14b
L_B14C:
	ld a,(ix+00ch)		;b14c
	add a,(ix+016h)		;b14f
	ld (ix+00ch),a		;b152
	ld a,(ix+00dh)		;b155
	adc a,(ix+017h)		;b158
	ld (ix+00dh),a		;b15b
	ret			;b15e
L_B15F:
	ld e,(ix+00eh)		;b15f
	ld d,(ix+00fh)		;b162
	call 04068h		;b165   ; de_negado (por 0x4068): DE = -DE
	ld (ix+00eh),e		;b168
	ld (ix+00fh),d		;b16b
	ret			;b16e
L_B16F:
	ld e,(ix+00ch)		;b16f
	ld d,(ix+00dh)		;b172
	call 04068h		;b175   ; de_negado (por 0x4068): DE = -DE
	ld (ix+00ch),e		;b178
	ld (ix+00dh),d		;b17b
	ret			;b17e
L_B17F:
	ld c,007h		;b17f
	jr L_B185		;b181
L_B183:
	ld c,003h		;b183
L_B185:
	ld a,(0e604h)		;b185   ; lee el contador de cuadros de partida
	and c			;b188
	ret nz			;b189
	jp L_B0DD		;b18a
L_B18D:
	ld a,080h		;b18d
L_B18F:
	ld e,(ix+005h)		;b18f
	ld d,(ix+007h)		;b192
L_B195:
	ld c,a			;b195
	ld a,(0e045h)		;b196
	add a,a			;b199
	add a,a			;b19a
	add a,a			;b19b
	add a,c			;b19c
	ld (0e609h),a		;b19d
	call L_B223		;b1a0
L_B1A3:
	ld a,(0f017h)		;b1a3
L_B1A6:
	ld e,a			;b1a6
	ld d,000h		;b1a7
	sub 03fh		;b1a9
	neg		;b1ab
	ld hl,0b374h		;b1ad
	push hl			;b1b0
	add hl,de			;b1b1
	ld c,(hl)			;b1b2
	pop hl			;b1b3
	ld e,a			;b1b4
	add hl,de			;b1b5
	ld a,(hl)			;b1b6
	ld (0f016h),a		;b1b7
	ld e,c			;b1ba
	call L_B262		;b1bb
	ld a,(0f010h)		;b1be
	and a			;b1c1
	call nz,04068h		;b1c2   ; de_negado (por 0x4068): DE = -DE
	ld (0f012h),de		;b1c5
	ld a,(0f016h)		;b1c9
	ld e,a			;b1cc
	call L_B262		;b1cd
	ld a,(0f011h)		;b1d0
	and a			;b1d3
	call nz,04068h		;b1d4   ; de_negado (por 0x4068): DE = -DE
	ld hl,(0f012h)		;b1d7
	ret			;b1da
L_B1DB:
	ld a,(ix+005h)		;b1db
	add a,e			;b1de
	ld e,a			;b1df
	ld a,(ix+007h)		;b1e0
	add a,d			;b1e3
	ld d,a			;b1e4
	call L_B223		;b1e5
	ld c,a			;b1e8
	ld hl,(0f010h)		;b1e9
	ld a,h			;b1ec
	ld b,000h		;b1ed
	and a			;b1ef
	jr z,L_B1F4		;b1f0
	ld b,080h		;b1f2
L_B1F4:
	cp l			;b1f4
	ld a,c			;b1f5
	jr z,L_B1FA		;b1f6
	neg		;b1f8
L_B1FA:
	add a,b			;b1fa
	ld (0f018h),a		;b1fb
	ret			;b1fe
L_B1FF:
	ld c,a			;b1ff
	add a,a			;b200
	rla			;b201
	and 001h		;b202
	ld l,a			;b204
	ld a,c			;b205
	add a,040h		;b206
	add a,a			;b208
	rla			;b209
	and 001h		;b20a
	ld h,a			;b20c
	ld (0f010h),hl		;b20d
	ld a,c			;b210
	cp 080h		;b211
	jr c,L_B217		;b213
	sub 080h		;b215
L_B217:
	cp 040h		;b217
	jr c,L_B21F		;b219
	sub 07fh		;b21b
	neg		;b21d
L_B21F:
	ld (0f017h),a		;b21f
	ret			;b222
L_B223:
	ld a,(0e505h)		;b223   ; lee la y del personaje
	sub 010h		;b226
	ld (0f000h),a		;b228
	ld a,(0e507h)		;b22b   ; lee la x del personaje
	sub 008h		;b22e
	ld (0f001h),a		;b230
L_B233:
	ld hl,0f010h		;b233
	ld (hl),000h		;b236
	ld a,(0f000h)		;b238
	sub e			;b23b
	jr nc,L_B241		;b23c
	neg		;b23e
	inc (hl)			;b240
L_B241:
	inc hl			;b241
	ld (hl),000h		;b242
	and 0f0h		;b244
	ld e,a			;b246
	ld a,(0f001h)		;b247
	sub d			;b24a
	jr nc,L_B250		;b24b
	neg		;b24d
	inc (hl)			;b24f
L_B250:
	rra			;b250
	rra			;b251
	rra			;b252
	rra			;b253
	and 00fh		;b254
	add a,e			;b256
	ld hl,0b274h		;b257
	call 04062h		;b25a   ; hl_mas_a (por 0x4062): HL += A
	ld a,(hl)			;b25d
	ld (0f017h),a		;b25e
	ret			;b261
L_B262:
	ld a,(0e609h)		;b262
	ld h,a			;b265
	call 0406bh		;b266   ; multiplica (por 0x406B): HL = H x E
	xor a			;b269
	add hl,hl			;b26a
	adc a,a			;b26b
	add hl,hl			;b26c
	adc a,a			;b26d
	add hl,hl			;b26e
	adc a,a			;b26f
	ld l,h			;b270
	ld h,a			;b271
	ex de,hl			;b272
	ret			;b273

; ----------------------------------------------------------------------
; DATOS direcciones_16x16: 16 x 16 angulos (0-0x3F, 0x20 en la diagonal) que
;   p06:B257 lee en 0xB274 + 16 x (|dY| / 16) + |dX| / 16: la direccion de una
;   figura al jugador
;   0xb274..0xb374  (256 bytes)
DATA_direcciones_16x16:
	defb 020h,00dh,008h,006h,004h,004h,003h,003h,002h,002h,002h,002h,001h,001h,001h,001h	; b274   ...............
	defb 033h,020h,016h,010h,00dh,00bh,009h,008h,007h,006h,006h,005h,005h,004h,004h,004h	; b284  3 ..............
	defb 038h,02ah,020h,019h,015h,011h,00fh,00dh,00ch,00ah,009h,009h,008h,007h,007h,006h	; b294  8* .............
	defb 03ah,02fh,027h,020h,01bh,017h,014h,012h,010h,00eh,00dh,00ch,00bh,00ah,00ah,009h	; b2a4  :/' ............
	defb 03bh,033h,02bh,025h,020h,01ch,019h,016h,014h,012h,010h,00fh,00eh,00dh,00ch,00bh	; b2b4  .3+% ...........
	defb 03ch,035h,02eh,029h,024h,020h,01ch,01ah,017h,015h,014h,012h,011h,010h,00fh,00eh	; b2c4  <5.)$ ..........
	defb 03dh,037h,031h,02ch,027h,023h,020h,01dh,01ah,018h,016h,015h,013h,012h,011h,010h	; b2d4  =71,'# .........
	defb 03dh,038h,033h,02eh,02ah,026h,023h,020h,01dh,01bh,019h,017h,016h,015h,013h,012h	; b2e4  =83.*&# ........
	defb 03dh,039h,034h,030h,02ch,028h,025h,022h,020h,01eh,01ch,01ah,018h,017h,015h,014h	; b2f4  =940,(%" .......
	defb 03eh,039h,035h,031h,02eh,02ah,027h,025h,022h,020h,01eh,01ch,01ah,019h,017h,016h	; b304  >951.*'%" ......
	defb 03eh,03ah,036h,033h,02fh,02ch,029h,027h,024h,022h,020h,01eh,01ch,01bh,019h,018h	; b314  >:63/,)'$" .....
	defb 03eh,03bh,037h,034h,031h,02eh,02bh,028h,026h,024h,022h,020h,01eh,01dh,01bh,01ah	; b324  >.741.+(&$" ....
	defb 03eh,03bh,038h,035h,032h,02fh,02ch,02ah,028h,025h,023h,022h,020h,01eh,01dh,01ch	; b334  >.852/,*(%#" ...
	defb 03eh,03bh,038h,036h,033h,030h,02eh,02bh,029h,027h,025h,023h,021h,020h,01eh,01dh	; b344  >.8630.+)'%#! ..
	defb 03eh,03ch,039h,036h,034h,031h,02fh,02ch,02ah,028h,026h,025h,023h,021h,020h,01eh	; b354  ><9641/,*(&%#! .
	defb 03fh,03ch,039h,037h,034h,032h,030h,02dh,02bh,029h,028h,026h,024h,023h,021h,020h	; b364  ?<97420-+)(&$#!

; ----------------------------------------------------------------------
; DATOS seno_64: 64 pasos de un cuarto de seno, de 0 a 0xFF (p06:B1AD,
;   p06:A960)
;   0xb374..0xb3b4  (64 bytes)
DATA_seno_64:
	defb 000h,006h,00ch,012h,019h,01fh,026h,02ch,032h,038h,03eh,044h,04ah,050h,056h,05ch	; b374  ......&,28>DJPV\
	defb 062h,068h,06dh,073h,079h,07eh,084h,089h,08eh,093h,099h,09eh,0a2h,0a7h,0ach,0b1h	; b384  bhmsy~..........
	defb 0b5h,0b9h,0beh,0c2h,0c6h,0cah,0ceh,0d1h,0d5h,0d8h,0dch,0dfh,0e2h,0e5h,0e7h,0eah	; b394  ................
	defb 0edh,0efh,0f1h,0f3h,0f5h,0f7h,0f8h,0fah,0fbh,0fch,0fdh,0feh,0feh,0ffh,0ffh,0ffh	; b3a4  ................

; ======================================================================
; CODIGO 0xb3b4..0xb472  (190 bytes)
; ======================================================================


L_B3B4:
	ld hl,0e0d5h		;b3b4   ; apunta a todo parado (objeto 0x20)
	ld a,(hl)			;b3b7
	or a			;b3b8
	ret z			;b3b9
	inc l			;b3ba
	dec (hl)			;b3bb
	ret nz			;b3bc
	dec l			;b3bd
	ld (hl),000h		;b3be
	ld a,0fch		;b3c0
	jp 04059h		;b3c2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_B3C5:
	ld ix,0e800h		;b3c5   ; apunta a los huecos de figura (32 bytes cada uno)
	ld a,(0e635h)		;b3c9   ; lee cuantos huecos de figura hay
	ld (0e623h),a		;b3cc
L_B3CF:
	call L_B3F7		;b3cf
	call L_B3E7		;b3d2
	call L_B45E		;b3d5
	call L_B407		;b3d8
	ld de,00020h		;b3db
	add ix,de		;b3de
	ld hl,0e623h		;b3e0
	dec (hl)			;b3e3
	jr nz,L_B3CF		;b3e4
	ret			;b3e6
L_B3E7:
	bit 5,(ix+003h)		;b3e7
	ret z			;b3eb
	ld a,(0e604h)		;b3ec   ; lee el contador de cuadros de partida
	and 00fh		;b3ef
	ret nz			;b3f1
	res 5,(ix+003h)		;b3f2
	ret			;b3f6
L_B3F7:
	bit 4,(ix+003h)		;b3f7
	ret z			;b3fb
	ld a,(0e604h)		;b3fc   ; lee el contador de cuadros de partida
	and 01fh		;b3ff
	ret nz			;b401
	res 4,(ix+003h)		;b402
	ret			;b406
L_B407:
	ld a,(0e0d5h)		;b407   ; lee todo parado (objeto 0x20)
	or a			;b40a
	ret nz			;b40b
	ld a,(ix+000h)		;b40c
	or a			;b40f
	ret z			;b410
	bit 4,(ix+002h)		;b411
	call nz,L_B0ED		;b415
	call L_B452		;b418
	ret c			;b41b
L_B41C:
	call L_B43D		;b41c
	ld l,(ix+000h)		;b41f
	call 067afh		;b422
	ex de,hl			;b425
	xor a			;b426
	ld (ix+000h),a		;b427
	ld (ix+002h),a		;b42a
	ld hl,0e620h		;b42d
	dec (hl)			;b430
	inc l			;b431
	ld a,(de)			;b432
	bit 7,a		;b433
	ret z			;b435
	and 007h		;b436
	ld b,a			;b438
	ld a,(hl)			;b439
	sub b			;b43a
	ld (hl),a			;b43b
	ret			;b43c
L_B43D:
	ld a,(ix+003h)		;b43d
	bit 3,a		;b440
	ret z			;b442
	and 007h		;b443
	inc a			;b445
	ld b,a			;b446
	xor a			;b447
	scf			;b448
L_B449:
	rla			;b449
	djnz L_B449		;b44a
	ld hl,(0e60ch)		;b44c   ; lee la direccion del byte de la sala en el tramo del mapa y el byte siguiente (16 bits)
	or (hl)			;b44f
	ld (hl),a			;b450
	ret			;b451
L_B452:
	ld a,(ix+005h)		;b452
	cp 0b8h		;b455
	ret nc			;b457
	ld a,(ix+007h)		;b458
	cp 0f9h		;b45b
L_B45D:
	ret			;b45d
L_B45E:
	ld a,(ix+000h)		;b45e
	or a			;b461
	ret z			;b462
	cp 05bh		;b463
	jr z,L_B46E		;b465
	ld b,a			;b467
	ld a,(0e0d5h)		;b468   ; lee todo parado (objeto 0x20)
	or a			;b46b
	ret nz			;b46c
	ld a,b			;b46d
L_B46E:
	dec a			;b46e
	call 04050h		;b46f   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B472: 107 destinos del despachador de 0x4140 (call en p06:B46F):
;   0x7978, 0x6CF4, 0xAC28, 0x6F80, 0x6B06, 0x76CD, 0xA848, 0x6E32 ...; lo
;   leen p06:B46F (214 bytes)
;   0xb472..0xb548  (214 bytes)
DATA_tabla_B472:
	defb 078h,079h	; b472
	defb 0f4h,06ch	; b474
	defb 028h,0ach	; b476
	defb 080h,06fh	; b478
	defb 006h,06bh	; b47a
	defb 0cdh,076h	; b47c
	defb 048h,0a8h	; b47e
	defb 032h,06eh	; b480
	defb 020h,070h	; b482
	defb 04fh,07bh	; b484
	defb 0c1h,07ah	; b486
	defb 0beh,09dh	; b488
	defb 0cdh,078h	; b48a
	defb 03ah,07dh	; b48c
	defb 076h,073h	; b48e
	defb 0d3h,071h	; b490
	defb 0dch,073h	; b492
	defb 0a8h,070h	; b494
	defb 001h,0a4h	; b496
	defb 055h,072h	; b498
	defb 03dh,08eh	; b49a
	defb 036h,08ch	; b49c
	defb 040h,095h	; b49e
	defb 05dh,06ch	; b4a0
	defb 08fh,086h	; b4a2
	defb 047h,06ch	; b4a4
	defb 07dh,06eh	; b4a6
	defb 080h,06fh	; b4a8
	defb 0a7h,098h	; b4aa
	defb 0a7h,098h	; b4ac
	defb 055h,094h	; b4ae
	defb 0e2h,093h	; b4b0
	defb 0b5h,07eh	; b4b2
	defb 0c9h,080h	; b4b4
	defb 0b8h,0a1h	; b4b6
	defb 054h,09bh	; b4b8
	defb 008h,099h	; b4ba
	defb 058h,0a4h	; b4bc
	defb 042h,089h	; b4be
	defb 045h,093h	; b4c0
	defb 0e3h,092h	; b4c2
	defb 096h,096h	; b4c4
	defb 0fbh,087h	; b4c6
	defb 0b3h,0a9h	; b4c8
	defb 054h,097h	; b4ca
	defb 081h,0a0h	; b4cc
	defb 019h,092h	; b4ce
	defb 072h,07fh	; b4d0
	defb 03fh,08bh	; b4d2
	defb 084h,090h	; b4d4
	defb 0a7h,098h	; b4d6
	defb 0fah,0aah	; b4d8
	defb 0a7h,0abh	; b4da
	defb 07ah,08ah	; b4dc
	defb 08fh,086h	; b4de
	defb 0c3h,0a7h	; b4e0
	defb 00dh,0a9h	; b4e2
	defb 060h,091h	; b4e4
	defb 0dfh,091h	; b4e6
	defb 059h,0aeh	; b4e8
	defb 058h,0aeh	; b4ea
	defb 0a4h,0a2h	; b4ec
	defb 0a7h,098h	; b4ee
	defb 00dh,08dh	; b4f0
	defb 028h,08dh	; b4f2
	defb 0c2h,083h	; b4f4
	defb 0e8h,084h	; b4f6
	defb 0bdh,09dh	; b4f8
	defb 0b9h,08fh	; b4fa
	defb 003h,08dh	; b4fc
	defb 0c7h,095h	; b4fe
	defb 0bah,087h	; b500
	defb 009h,0a1h	; b502
	defb 031h,081h	; b504
	defb 026h,0a5h	; b506
	defb 0d3h,08fh	; b508
	defb 00bh,090h	; b50a
	defb 047h,082h	; b50c
	defb 014h,083h	; b50e
	defb 060h,091h	; b510
	defb 084h,090h	; b512
	defb 009h,0a1h	; b514
	defb 009h,0a1h	; b516
	defb 0e8h,0ach	; b518
	defb 013h,0adh	; b51a
	defb 0bdh,09dh	; b51c
	defb 08ch,0adh	; b51e
	defb 0f4h,0adh	; b520
	defb 029h,0aeh	; b522
	defb 0bah,074h	; b524
	defb 018h,06ah	; b526
	defb 0f3h,0aah	; b528
	defb 0c3h,06ah	; b52a
	defb 0c3h,06ah	; b52c
	defb 0c3h,06ah	; b52e
	defb 076h,084h	; b530
	defb 0c4h,084h	; b532
	defb 081h,085h	; b534
	defb 0cbh,06ah	; b536
	defb 09dh,0a9h	; b538
	defb 0bah,074h	; b53a
	defb 05dh,0b4h	; b53c
	defb 0f3h,0a5h	; b53e
	defb 06bh,09fh	; b540
	defb 011h,075h	; b542
	defb 047h,06ch	; b544
	defb 0bdh,0aah	; b546

; ======================================================================
; CODIGO 0xb548..0xb5cd  (133 bytes)
; ======================================================================


L_B548:
	ld a,(0e6c7h)		;b548
	ld hl,0647bh		;b54b
	call 04083h		;b54e   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	cp 004h		;b551
	scf			;b553
	ret z			;b554
	ld c,a			;b555
	call L_B57A		;b556
	ret c			;b559
	ld a,(0e6c7h)		;b55a
	ld hl,064e5h		;b55d
	call 04083h		;b560   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld b,000h		;b563
	cp 003h		;b565
	jr c,L_B574		;b567
	inc b			;b569
	cp 006h		;b56a
	jr c,L_B574		;b56c
	inc b			;b56e
	cp 009h		;b56f
	jr c,L_B574		;b571
	inc b			;b573
L_B574:
	ld a,b			;b574
	ld (0e6c6h),a		;b575
	or a			;b578
	ret			;b579
L_B57A:
	ld hl,0e6c2h		;b57a
	ld a,(0e6c7h)		;b57d
	ld b,002h		;b580
L_B582:
	cp (hl)			;b582
	jr z,L_B59A		;b583
	inc hl			;b585
	djnz L_B582		;b586
	ld hl,0e6c2h		;b588
	ld b,002h		;b58b
L_B58D:
	ld a,(hl)			;b58d
	or a			;b58e
	jr z,L_B596		;b58f
	inc hl			;b591
	djnz L_B58D		;b592
	scf			;b594
	ret			;b595
L_B596:
	ld a,(0e6c7h)		;b596
	ld (hl),a			;b599
L_B59A:
	inc hl			;b59a
	inc hl			;b59b
	inc (hl)			;b59c
	ld a,c			;b59d
	or a			;b59e
	ld de,00103h		;b59f
	jr z,L_B5C5		;b5a2
	cp 002h		;b5a4
	ld de,00205h		;b5a6
	jr c,L_B5C5		;b5a9
	ld de,00406h		;b5ab
	jr z,L_B5C5		;b5ae
	ld hl,0e800h		;b5b0   ; apunta a los huecos de figura (32 bytes cada uno)
	ld de,00020h		;b5b3
	ld a,(0e635h)		;b5b6   ; lee cuantos huecos de figura hay
	ld b,a			;b5b9
	ld a,(0e6c7h)		;b5ba
L_B5BD:
	cp (hl)			;b5bd
	jr z,L_B5CB		;b5be
	add hl,de			;b5c0
	djnz L_B5BD		;b5c1
	or a			;b5c3
	ret			;b5c4
L_B5C5:
	ld a,d			;b5c5
	cp (hl)			;b5c6
	ret z			;b5c7
	ld a,e			;b5c8
	cp (hl)			;b5c9
	ret z			;b5ca
L_B5CB:
	scf			;b5cb
	ret			;b5cc

; ----------------------------------------------------------------------
; DATOS tabla_objetos: 11 punteros, uno por mapa (0xE041) desde el 1, a los
;   objetos de cada sala, [tipo][sitio] y un byte con los 7 bits bajos a 0 al
;   final (p04:6014); la tabla se lee desde 0xB5CB, pero el mapa 0 no existe;
;   lo leen p04:6014 (22 bytes)
;   0xb5cd..0xb5e3  (22 bytes)
DATA_tabla_objetos:
	defb 0e3h,0b5h	; b5cd
	defb 042h,0bbh	; b5cf
	defb 0c3h,0bbh	; b5d1
	defb 028h,0bch	; b5d3
	defb 098h,0bch	; b5d5
	defb 017h,0bdh	; b5d7
	defb 081h,0bdh	; b5d9
	defb 0e8h,0bdh	; b5db
	defb 07eh,0beh	; b5dd
	defb 0e7h,0beh	; b5df
	defb 0aeh,0bfh	; b5e1

; ----------------------------------------------------------------------
; DATOS objetos_mapa_1: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 1: una lista por sala
;   (147); lo leen p04:6014 (1375 bytes)
;   0xb5e3..0xbb42  (1375 bytes)
DATA_objetos_mapa_1:
	defb 000h,023h,024h,023h,0a4h,000h,018h,08ah	; b5e3  .#$#....
	defb 018h,08dh,098h,06ch,098h,04eh,0bah,029h	; b5eb  ...l.N.)
	defb 0bah,0a8h,050h,02eh,0d0h,08dh,000h,026h	; b5f3  ..P....&
	defb 063h,000h,091h,089h,011h,0adh,091h,08eh	; b5fb  c.......
	defb 02eh,069h,02eh,08bh,02eh,08dh,02eh,0abh	; b603  .i......
	defb 000h,03ch,02ch,025h,04ah,025h,06ch,025h	; b60b  .<,%J%l%
	defb 08eh,025h,0ach,000h,002h,02bh,000h,026h	; b613  .%...+.&
	defb 063h,000h,025h,02ch,025h,08dh,0a5h,0a9h	; b61b  c.%,%...
	defb 0d1h,025h,0d1h,065h,0d1h,085h,0b2h,0a0h	; b623  .%.e....
	defb 000h,000h,091h,04bh,091h,069h,091h,0a9h	; b62b  ...K.i..
	defb 02eh,02eh,0aeh,049h,02eh,08ah,02eh,08dh	; b633  ...I....
	defb 0aeh,0aeh,000h,025h,02ah,025h,06ch,0a5h	; b63b  ...%*%l.
	defb 0adh,000h,02eh,029h,0aeh,02ah,02eh,02dh	; b643  ...).*.-
	defb 00eh,081h,08eh,085h,00eh,042h,00eh,046h	; b64b  .....B.F
	defb 000h,00eh,0a6h,08eh,045h,000h,023h,046h	; b653  ....E.#F
	defb 0a3h,064h,0a3h,0a4h,000h,00eh,063h,00eh	; b65b  .d....c.
	defb 0a2h,00eh,0a6h,08eh,064h,03ah,029h,050h	; b663  ....d:)P
	defb 04fh,050h,08eh,000h,0b4h,08ah,0b4h,04eh	; b66b  OP.....N
	defb 000h,019h,051h,019h,053h,019h,055h,019h	; b673  ..Q.S.U.
	defb 056h,019h,091h,019h,093h,019h,095h,019h	; b67b  V.......
	defb 096h,000h,034h,02ah,0b4h,02bh,034h,0aah	; b683  ..4*.+4.
	defb 0b4h,06ch,000h,08ah,0a9h,00ah,08ch,00ah	; b68b  .l......
	defb 04eh,08ah,06ah,08ah,06dh,000h,0a5h,04ah	; b693  N.j.m..J
	defb 025h,0adh,0a5h,06bh,02eh,029h,02eh,04eh	; b69b  %..k.).N
	defb 0aeh,06dh,0aeh,08ah,000h,00eh,021h,00eh	; b6a3  .m....!.
	defb 021h,000h,011h,02ah,011h,02eh,091h,06ah	; b6ab  !..*...j
	defb 091h,06dh,011h,08ah,011h,08eh,011h,0aah	; b6b3  .m......
	defb 011h,0aeh,000h,08eh,046h,08eh,080h,08eh	; b6bb  ....F...
	defb 080h,08eh,086h,000h,04eh,041h,04eh,043h	; b6c3  ....NANC
	defb 04eh,044h,04eh,045h,04eh,071h,04eh,073h	; b6cb  NDNENqNs
	defb 04eh,074h,04eh,075h,04eh,0a1h,04eh,0a3h	; b6d3  NtNuN.N.
	defb 04eh,0a4h,04eh,0a5h,000h,08eh,0a0h,08eh	; b6db  N.N.....
	defb 0a0h,00eh,0a1h,00eh,062h,00eh,062h,00eh	; b6e3  ....b.b.
	defb 062h,000h,019h,051h,019h,053h,019h,055h	; b6eb  b..Q.S.U
	defb 019h,056h,019h,091h,019h,093h,019h,095h	; b6f3  .V......
	defb 019h,096h,000h,000h,00eh,025h,00eh,044h	; b6fb  .....%.D
	defb 00eh,063h,08eh,082h,08eh,0a1h,00eh,0a7h	; b703  .c......
	defb 08eh,081h,08eh,040h,000h,019h,051h,019h	; b70b  ...@..Q.
	defb 053h,019h,055h,019h,056h,019h,091h,019h	; b713  S.U.V...
	defb 093h,019h,095h,019h,096h,000h,011h,02bh	; b71b  .......+
	defb 091h,06ch,011h,04eh,0aeh,02ah,0aeh,02eh	; b723  .l.N.*..
	defb 0aeh,04dh,02eh,06dh,000h,0a5h,02ah,025h	; b72b  .M.m..*%
	defb 06ch,025h,08dh,000h,00ah,02eh,00ah,04ah	; b733  l%.....J
	defb 00ah,06eh,00ah,08ah,000h,08eh,0adh,00eh	; b73b  .n......
	defb 04bh,00eh,061h,08eh,061h,00eh,073h,08eh	; b743  K.a.a.s.
	defb 085h,0b2h,041h,032h,0a1h,000h,08eh,065h	; b74b  ..A2...e
	defb 08eh,065h,00eh,066h,08eh,086h,00eh,087h	; b753  .e.f....
	defb 000h,00eh,042h,00eh,086h,000h,00eh,044h	; b75b  ..B....D
	defb 00eh,045h,000h,00eh,044h,08eh,061h,00eh	; b763  .E..D.a.
	defb 0a3h,00eh,066h,0b4h,02ah,034h,02ch,0b4h	; b76b  ..f.*4,.
	defb 04ah,0b4h,04dh,0b4h,06ah,000h,0aeh,02ah	; b773  J.M.j..*
	defb 02eh,06dh,02eh,06fh,0aeh,08dh,0aeh,0ach	; b77b  .m.o....
	defb 00eh,047h,00eh,087h,08eh,0a3h,08eh,04ah	; b783  .G.....J
	defb 000h,00ah,04bh,08ah,06bh,08ah,08bh,00ah	; b78b  ..K.k...
	defb 0ach,000h,0a5h,02dh,0a5h,06ch,0a5h,04ah	; b793  ...-.l.J
	defb 02eh,049h,0aeh,06ah,02eh,089h,0aeh,08eh	; b79b  .I.j....
	defb 000h,00eh,041h,08eh,043h,08eh,046h,00eh	; b7a3  ..A.C.F.
	defb 064h,00eh,066h,08eh,083h,08eh,086h,00eh	; b7ab  d.f.....
	defb 0a1h,000h,00eh,026h,08eh,044h,00eh,052h	; b7b3  ...&.D.R
	defb 00eh,064h,00eh,087h,00eh,094h,00eh,083h	; b7bb  .d......
	defb 00eh,084h,000h,08ah,04ah,00ah,06eh,00ah	; b7c3  ....J.n.
	defb 08ah,000h,025h,02ah,025h,02eh,025h,08ch	; b7cb  ..%*%.%.
	defb 025h,04ch,000h,00ah,0ach,08ah,0a8h,000h	; b7d3  %L......
	defb 00eh,042h,00eh,046h,00eh,0a2h,00eh,0a4h	; b7db  .B.F....
	defb 000h,0b4h,02bh,034h,02eh,0b4h,04dh,0b4h	; b7e3  ..+4..M.
	defb 049h,034h,0aah,0b4h,0abh,034h,0aeh,000h	; b7eb  I4...4..
	defb 08eh,020h,00eh,087h,00eh,047h,031h,0aah	; b7f3  . ...G1.
	defb 031h,0abh,031h,0adh,000h,00ah,0aah,08ah	; b7fb  1.1.....
	defb 0adh,000h,025h,02ah,025h,04ah,025h,08eh	; b803  ..%*%J%.
	defb 0b4h,02ch,034h,06dh,034h,08bh,000h,00eh	; b80b  .,4m4...
	defb 032h,08eh,085h,00eh,086h,00eh,046h,00eh	; b813  2.....F.
	defb 062h,00eh,082h,00eh,044h,00eh,044h,031h	; b81b  b...D.D1
	defb 06fh,031h,0aah,0b1h,0abh,0b1h,0ach,000h	; b823  o1......
	defb 08eh,020h,08eh,020h,08eh,020h,08eh,020h	; b82b  . . . .
	defb 08eh,020h,08eh,020h,08eh,020h,08eh,020h	; b833  . . . .
	defb 000h,025h,04eh,0a5h,069h,025h,08eh,025h	; b83b  .%N.i%.%
	defb 08ah,000h,025h,04ch,025h,0ach,0a5h,06bh	; b843  ..%L%..k
	defb 000h,031h,08ch,000h,0b1h,06bh,031h,065h	; b84b  .1...k1e
	defb 031h,06eh,0b1h,089h,031h,085h,0b1h,0a3h	; b853  1n..1...
	defb 031h,0aeh,000h,025h,02ah,025h,06ch,000h	; b85b  1..%*%l.
	defb 00eh,044h,00eh,084h,000h,00ah,02ah,00ah	; b863  .D....*.
	defb 06ah,000h,00ah,049h,08ah,069h,000h,019h	; b86b  j..I.i..
	defb 051h,019h,053h,019h,055h,019h,056h,019h	; b873  Q.S.U.V.
	defb 091h,019h,093h,019h,095h,019h,096h,000h	; b87b  ........
	defb 025h,04eh,02eh,049h,0aeh,04ah,02eh,04ch	; b883  %N.I.J.L
	defb 000h,025h,04ch,025h,08ah,025h,0adh,000h	; b88b  .%L%.%..
	defb 019h,051h,019h,053h,019h,055h,019h,056h	; b893  .Q.S.U.V
	defb 019h,091h,019h,093h,019h,095h,019h,096h	; b89b  ........
	defb 000h,0a5h,069h,025h,06eh,025h,08eh,0b4h	; b8a3  ..i%n%..
	defb 08ah,0b4h,0adh,000h,00ah,02ah,00ah,04ch	; b8ab  .....*.L
	defb 00ah,06eh,000h,0b1h,049h,031h,04eh,031h	; b8b3  .n..I1N1
	defb 0a9h,00eh,062h,08eh,061h,000h,08ah,04ah	; b8bb  ..b.a..J
	defb 08ah,08dh,08ah,0adh,000h,031h,02dh,031h	; b8c3  .....1-1
	defb 02eh,031h,06bh,0b1h,0a6h,00eh,041h,08eh	; b8cb  .1k...A.
	defb 062h,08eh,085h,08eh,0a5h,000h,00eh,046h	; b8d3  b......F
	defb 08eh,061h,00eh,087h,08eh,0a3h,000h,00eh	; b8db  .a......
	defb 041h,08eh,046h,00eh,065h,00eh,081h,08eh	; b8e3  A.F.e...
	defb 085h,000h,034h,04eh,0b4h,0adh,000h,025h	; b8eb  ..4N...%
	defb 02ch,025h,08ch,0b4h,049h,034h,0aeh,034h	; b8f3  ,%..I4.4
	defb 06bh,000h,08ah,04ah,00ah,0aah,000h,08eh	; b8fb  k..J....
	defb 041h,00eh,056h,08eh,084h,08eh,0a3h,0aeh	; b903  A.V.....
	defb 029h,02eh,08bh,0aeh,08eh,000h,08ah,02ch	; b90b  )......,
	defb 08ah,049h,08ah,06eh,000h,02eh,02ah,0aeh	; b913  .I.n..*.
	defb 06ah,02eh,02eh,02eh,04eh,0aeh,08eh,00eh	; b91b  j...N...
	defb 042h,08eh,043h,00eh,061h,00eh,0a6h,000h	; b923  B.C.a...
	defb 00ah,02eh,08ah,04ch,00ah,08eh,00ah,0aeh	; b92b  ...L....
	defb 000h,000h,08ah,049h,08ah,06dh,08ah,08bh	; b933  ...I.m..
	defb 08ah,0aah,000h,00ah,0aeh,000h,025h,0afh	; b93b  ......%.
	defb 031h,0abh,0b1h,06dh,000h,031h,02ch,0b1h	; b943  1..m.1,.
	defb 049h,0b1h,04eh,0b1h,083h,000h,098h,029h	; b94b  I.N....)
	defb 018h,02eh,018h,04ah,018h,04eh,098h,08ah	; b953  ...J.N..
	defb 000h,091h,02ah,091h,0a9h,011h,06eh,02eh	; b95b  ..*...n.
	defb 02ah,02eh,06bh,0aeh,06dh,02eh,0ach,000h	; b963  *.k.m...
	defb 02eh,02ah,0aeh,08ah,02eh,08eh,025h,08bh	; b96b  .*....%.
	defb 0a5h,049h,000h,00eh,042h,00eh,062h,00eh	; b973  .I..B.b.
	defb 0a2h,000h,08eh,041h,00eh,044h,00eh,046h	; b97b  ...A.D.F
	defb 031h,06dh,000h,0b1h,02ch,0b1h,04eh,031h	; b983  1m..,.N1
	defb 069h,0b1h,0aah,0b1h,0a5h,000h,04eh,041h	; b98b  i.....NA
	defb 04eh,043h,04eh,044h,04eh,045h,04eh,071h	; b993  NCNDNENq
	defb 04eh,073h,04eh,074h,04eh,075h,04eh,0a1h	; b99b  NsNtNuN.
	defb 04eh,0a3h,04eh,0a4h,04eh,0a5h,000h,00eh	; b9a3  N.N.N...
	defb 042h,08eh,082h,08eh,086h,00eh,0a5h,000h	; b9ab  B.......
	defb 0a5h,06ah,000h,000h,08eh,043h,08eh,083h	; b9b3  .j...C..
	defb 000h,000h,000h,025h,02eh,0a5h,049h,025h	; b9bb  ...%..I%
	defb 04ch,025h,08ah,000h,00ah,02bh,00ah,04eh	; b9c3  L%...+.N
	defb 00ah,06ch,08ah,08dh,000h,08eh,041h,00eh	; b9cb  .l....A.
	defb 047h,00eh,065h,00eh,085h,0b4h,029h,0b4h	; b9d3  G.e...).
	defb 02bh,034h,0abh,000h,08eh,042h,08eh,045h	; b9db  +4...B.E
	defb 00eh,062h,00eh,066h,08eh,081h,08eh,086h	; b9e3  .b.f....
	defb 000h,000h,08eh,081h,00eh,085h,00eh,0a6h	; b9eb  ........
	defb 00eh,087h,000h,025h,02ah,025h,08ch,025h	; b9f3  ...%*%.%
	defb 0aeh,0b2h,0a0h,051h,0a7h,000h,08eh,043h	; b9fb  ...Q...C
	defb 00eh,084h,000h,025h,0abh,000h,00eh,046h	; ba03  ...%...F
	defb 000h,03ch,04ch,000h,00eh,045h,08eh,066h	; ba0b  .<L..E.f
	defb 00eh,083h,00eh,0a3h,000h,04eh,041h,04eh	; ba13  .....NAN
	defb 043h,04eh,044h,04eh,045h,04eh,071h,04eh	; ba1b  CNDNENqN
	defb 073h,04eh,074h,04eh,075h,04eh,0a1h,04eh	; ba23  sNtNuN.N
	defb 0a3h,04eh,0a4h,04eh,0a5h,000h,011h,02ah	; ba2b  .N.N...*
	defb 011h,04ch,091h,06ah,011h,08eh,011h,0ach	; ba33  .L.j....
	defb 000h,08eh,042h,08eh,063h,00eh,081h,08eh	; ba3b  ..B.c...
	defb 0a4h,02eh,04eh,0aeh,069h,02eh,0aah,000h	; ba43  ..N.i...
	defb 00eh,086h,00eh,0a5h,000h,025h,02ch,025h	; ba4b  .....%,%
	defb 089h,025h,06ch,000h,025h,04ah,025h,06ch	; ba53  .%l.%J%l
	defb 025h,0abh,0b2h,040h,0b2h,080h,000h,08eh	; ba5b  %..@....
	defb 061h,00eh,086h,000h,018h,02ah,018h,02fh	; ba63  a....*./
	defb 018h,04fh,018h,06fh,098h,06bh,018h,08ch	; ba6b  .O.o.k..
	defb 098h,08dh,098h,0aah,018h,0aeh,018h,0adh	; ba73  ........
	defb 004h,024h,084h,083h,084h,0a1h,004h,0a4h	; ba7b  .$......
	defb 000h,018h,02eh,098h,02bh,098h,0a9h,098h	; ba83  ....+...
	defb 0adh,000h,018h,02fh,018h,04ah,018h,06ch	; ba8b  .../.J.l
	defb 098h,08ah,018h,0aeh,000h,018h,029h,018h	; ba93  ......).
	defb 0aah,018h,0ach,000h,0b2h,040h,0b2h,080h	; ba9b  .....@..
	defb 051h,0a7h,018h,06ch,098h,0adh,000h,0b4h	; baa3  Q..l....
	defb 02ch,034h,04dh,034h,08dh,0b4h,0ach,000h	; baab  ,4M4....
	defb 0aeh,02bh,02eh,08ah,0aeh,0abh,000h,0aeh	; bab3  .+......
	defb 029h,02eh,02ch,0aeh,089h,02eh,08ch,0aeh	; babb  ).,.....
	defb 0abh,000h,00ah,02ah,00ah,04eh,08ah,0adh	; bac3  ...*.N..
	defb 00ah,08bh,000h,00eh,063h,00eh,063h,08eh	; bacb  ....c.c.
	defb 080h,00eh,087h,000h,00ah,08ah,00ah,0aah	; bad3  ........
	defb 000h,098h,02dh,018h,04dh,018h,06ah,098h	; badb  ..-.M.j.
	defb 06bh,018h,06eh,084h,023h,084h,044h,084h	; bae3  k.n.#.D.
	defb 045h,000h,08eh,040h,00eh,047h,00eh,081h	; baeb  E..@.G..
	defb 08eh,0a5h,000h,0a6h,053h,018h,02ah,018h	; baf3  ....S.*.
	defb 0ach,098h,06dh,000h,000h,000h,034h,02dh	; bafb  ..m...4-
	defb 0b4h,069h,0b4h,06bh,000h,0b1h,02bh,0b1h	; bb03  .i.k..+.
	defb 04dh,031h,06ch,031h,085h,031h,0aeh,000h	; bb0b  M1l1.1..
	defb 0b1h,04dh,031h,049h,00eh,063h,00eh,0a2h	; bb13  .M1I.c..
	defb 000h,0b1h,02bh,0b1h,0a9h,0b1h,06bh,031h	; bb1b  ..+...k1
	defb 06eh,000h,002h,02dh,002h,08dh,000h,000h	; bb23  n..-....
	defb 082h,06ch,002h,04eh,000h,000h,042h,0a4h	; bb2b  .l.N..B.
	defb 000h,042h,0a4h,000h,042h,0a4h,000h,00eh	; bb33  .B..B...
	defb 041h,00eh,064h,000h,000h,000h,000h	; bb3b

; ----------------------------------------------------------------------
; DATOS objetos_mapa_2: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 2: una lista por sala
;   (15); lo leen p04:6014 (129 bytes)
;   0xbb42..0xbbc3  (129 bytes)
DATA_objetos_mapa_2:
	defb 000h,02fh,029h,02fh,04ah,0afh,04dh,000h	; bb42  ./)/J.M.
	defb 02fh,02ah,02fh,02eh,0afh,06eh,0afh,0a9h	; bb4a  /*/..n..
	defb 02fh,0ach,000h,090h,04ah,010h,06bh,090h	; bb52  /...J.k.
	defb 06eh,090h,08ch,000h,010h,08ch,090h,02bh	; bb5a  n......+
	defb 010h,049h,090h,06ch,010h,0ach,010h,0afh	; bb62  .I.l....
	defb 000h,028h,064h,028h,064h,028h,064h,028h	; bb6a  .(d(d(d(
	defb 064h,000h,00eh,084h,00eh,084h,000h,00eh	; bb72  d.......
	defb 084h,00eh,084h,00eh,084h,00eh,084h,028h	; bb7a  .......(
	defb 08bh,028h,08bh,028h,08bh,028h,08bh,000h	; bb82  .(.(.(..
	defb 090h,074h,090h,08ah,010h,0abh,000h,0afh	; bb8a  .t......
	defb 04eh,0afh,049h,02fh,06ch,0afh,0a9h,000h	; bb92  N.I/l...
	defb 02fh,02eh,0afh,06ch,090h,04dh,010h,0adh	; bb9a  /..l.M..
	defb 000h,010h,029h,090h,06bh,090h,06ah,010h	; bba2  ..).k.j.
	defb 06ah,000h,000h,010h,02dh,090h,08eh,090h	; bbaa  j...-...
	defb 08ah,010h,06bh,028h,074h,028h,074h,028h	; bbb2  ..k(t(t(
	defb 074h,028h,074h,028h,074h,028h,074h,000h	; bbba  t(t(t(t.
	defb 000h	; bbc2

; ----------------------------------------------------------------------
; DATOS objetos_mapa_3: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 3: una lista por sala
;   (15); lo leen p04:6014 (101 bytes)
;   0xbbc3..0xbc28  (101 bytes)
DATA_objetos_mapa_3:
	defb 000h,0a0h,029h,020h,069h,020h,0abh,000h	; bbc3  ..) i ..
	defb 020h,02ah,020h,04bh,0a0h,06bh,020h,0ach	; bbcb   * K.k .
	defb 000h,02ah,06dh,000h,02dh,02dh,0adh,04bh	; bbd3  .*m.--.K
	defb 0adh,08bh,000h,0adh,02dh,0adh,049h,0adh	; bbdb  ....-.I.
	defb 06dh,02dh,08bh,02dh,0aeh,000h,02ah,04ch	; bbe3  m-.-..*L
	defb 000h,02ah,06ch,0a0h,02dh,020h,04dh,020h	; bbeb  .*l.- M
	defb 06eh,0a0h,08bh,020h,0aeh,000h,000h,0ach	; bbf3  n.. ....
	defb 029h,064h,02ah,0ach,06ah,064h,06bh,000h	; bbfb  )d*.jdk.
	defb 000h,02ch,02bh,0e4h,02bh,0ach,04ch,064h	; bc03  .,+.+.Ld
	defb 04dh,0ach,06bh,064h,06ch,02ch,08dh,0e4h	; bc0b  M.kdl,..
	defb 08dh,02ch,0aah,0e4h,0aah,02ah,06ch,000h	; bc13  .,...*l.
	defb 02ah,06ch,000h,0adh,06ah,02dh,06eh,02dh	; bc1b  *l..j-n-
	defb 08dh,0adh,0aah,000h,000h	; bc23

; ----------------------------------------------------------------------
; DATOS objetos_mapa_4: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 4: una lista por sala
;   (16); lo leen p04:6014 (112 bytes)
;   0xbc28..0xbc98  (112 bytes)
DATA_objetos_mapa_4:
	defb 000h,0afh,02ah,0afh,04dh,02fh,06bh,0afh	; bc28  ..*.M/k.
	defb 089h,02fh,08dh,000h,083h,0a5h,003h,046h	; bc30  ./.....F
	defb 083h,063h,003h,085h,000h,02fh,02bh,02fh	; bc38  .c.../+/
	defb 02eh,0afh,08ah,0afh,0aeh,000h,083h,082h	; bc40  ........
	defb 003h,086h,000h,024h,02ah,083h,046h,083h	; bc48  ...$*.F.
	defb 063h,003h,061h,083h,084h,000h,0a4h,08bh	; bc50  c.a.....
	defb 000h,00eh,04ah,00eh,06dh,00eh,08ah,00eh	; bc58  ..J.m...
	defb 0afh,000h,024h,0a9h,0afh,04ah,02fh,06bh	; bc60  ..$..J/k
	defb 02fh,0aah,000h,00eh,044h,00eh,084h,00eh	; bc68  /...D...
	defb 085h,08eh,0a2h,00eh,0a5h,08eh,061h,000h	; bc70  ......a.
	defb 023h,063h,023h,083h,000h,024h,04ch,0a4h	; bc78  #c#..$L.
	defb 06dh,0a4h,08dh,024h,0ach,000h,000h,0c9h	; bc80  m..$....
	defb 02ch,000h,024h,02ch,024h,04ah,0a4h,06ah	; bc88  ,.$,$J.j
	defb 0a4h,06dh,024h,08ah,0a4h,0aah,000h,000h	; bc90  .m$.....

; ----------------------------------------------------------------------
; DATOS objetos_mapa_5: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 5: una lista por sala
;   (17); lo leen p04:6014 (127 bytes)
;   0xbc98..0xbd17  (127 bytes)
DATA_objetos_mapa_5:
	defb 000h,097h,049h,017h,0afh,000h,094h,02ah	; bc98  ..I....*
	defb 014h,06dh,094h,08bh,000h,097h,06bh,000h	; bca0  .m....k.
	defb 029h,04ah,0a9h,04bh,029h,06ch,029h,0aah	; bca8  )J.K)l).
	defb 0a9h,0ach,000h,00eh,042h,08eh,042h,08eh	; bcb0  ....B.B.
	defb 061h,08eh,065h,08eh,082h,00eh,085h,00eh	; bcb8  a.e.....
	defb 023h,00eh,08ch,000h,094h,049h,014h,04dh	; bcc0  #....I.M
	defb 014h,06eh,094h,089h,014h,08dh,000h,097h	; bcc8  .n......
	defb 08ah,017h,04fh,097h,049h,097h,02eh,000h	; bcd0  ..O.I...
	defb 014h,02bh,094h,049h,014h,04eh,014h,06bh	; bcd8  .+.I.N.k
	defb 094h,06eh,094h,0aah,014h,0aeh,000h,000h	; bce0  .n......
	defb 00eh,065h,00eh,044h,00eh,054h,00eh,064h	; bce8  .e.D.T.d
	defb 00eh,074h,00eh,084h,00eh,094h,00eh,042h	; bcf0  .t.....B
	defb 000h,000h,017h,06ch,097h,08bh,017h,0afh	; bcf8  ...l....
	defb 000h,000h,029h,06ch,029h,06ch,029h,06ch	; bd00  ..)l)l)l
	defb 029h,06ch,000h,029h,04bh,029h,04dh,029h	; bd08  )l.)K)M)
	defb 089h,029h,089h,029h,0afh,000h,000h	; bd10

; ----------------------------------------------------------------------
; DATOS objetos_mapa_6: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 6: una lista por sala
;   (18); lo leen p04:6014 (106 bytes)
;   0xbd17..0xbd81  (106 bytes)
DATA_objetos_mapa_6:
	defb 000h,087h,049h,087h,06ah,007h,0ach,000h	; bd17  ..I.j...
	defb 007h,049h,087h,04ch,007h,06bh,007h,08eh	; bd1f  .I.L.k..
	defb 007h,0aah,000h,007h,06ah,087h,0abh,000h	; bd27  ....j...
	defb 0b6h,022h,0b6h,03ch,0b6h,05ah,036h,05eh	; bd2f  .".<.Z6^
	defb 0b6h,079h,036h,09eh,036h,0a3h,0b6h,0a4h	; bd37  .y6.6...
	defb 000h,04ch,06bh,000h,000h,007h,02bh,007h	; bd3f  .Lk...+.
	defb 04ch,087h,06ah,000h,007h,049h,087h,069h	; bd47  L.j..I.i
	defb 087h,06eh,000h,000h,000h,08bh,09ah,00bh	; bd4f  .n......
	defb 09dh,000h,08bh,099h,08bh,09bh,08bh,09dh	; bd57  ........
	defb 000h,04ch,074h,000h,007h,02ah,087h,048h	; bd5f  .Lt..*.H
	defb 087h,06ah,007h,06eh,087h,088h,000h,036h	; bd67  .j.n...6
	defb 022h,036h,026h,0b6h,041h,0b6h,046h,0b6h	; bd6f  "6&.A.F.
	defb 081h,0b6h,086h,036h,0a3h,0b6h,0a4h,000h	; bd77  ...6....
	defb 000h,000h	; bd7f

; ----------------------------------------------------------------------
; DATOS objetos_mapa_7: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 7: una lista por sala
;   (19); lo leen p04:6014 (103 bytes)
;   0xbd81..0xbde8  (103 bytes)
DATA_objetos_mapa_7:
	defb 000h,00eh,08ch,000h,000h,00eh,06bh,00eh	; bd81  ......k.
	defb 06bh,000h,092h,04bh,012h,08ch,000h,08eh	; bd89  k..K....
	defb 040h,00eh,063h,00eh,047h,08eh,080h,00eh	; bd91  @.c.G...
	defb 087h,000h,000h,000h,00fh,0aah,00fh,08dh	; bd99  ........
	defb 08fh,06bh,08fh,04dh,000h,00fh,02bh,08fh	; bda1  .k.M..+.
	defb 04ah,00fh,06ch,08fh,08bh,00fh,0abh,00fh	; bda9  J.l.....
	defb 029h,000h,016h,084h,000h,00fh,04ah,00fh	; bdb1  ).....J.
	defb 04eh,00fh,06ch,00fh,08eh,000h,000h,00fh	; bdb9  N.l.....
	defb 06ah,00fh,08ch,00fh,0ach,00fh,04eh,000h	; bdc1  j.....N.
	defb 00fh,02bh,00fh,04ah,08fh,06bh,00fh,08eh	; bdc9  .+.J.k..
	defb 00fh,08ah,00fh,06eh,000h,012h,06bh,000h	; bdd1  ...n..k.
	defb 092h,049h,012h,096h,012h,094h,012h,06ch	; bdd9  .I.....l
	defb 000h,092h,08ch,092h,0abh,000h,000h	; bde1

; ----------------------------------------------------------------------
; DATOS objetos_mapa_8: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 8: una lista por sala
;   (20); lo leen p04:6014 (150 bytes)
;   0xbde8..0xbe7e  (150 bytes)
DATA_objetos_mapa_8:
	defb 000h,08eh,044h,08eh,045h,000h,08eh,044h	; bde8  ..D.E..D
	defb 08eh,042h,08eh,084h,000h,027h,064h,000h	; bdf0  .B...'d.
	defb 027h,064h,000h,0a7h,081h,00eh,045h,00eh	; bdf8  'd....E.
	defb 065h,00eh,085h,00eh,0a5h,000h,09fh,029h	; be00  e......)
	defb 01fh,04ah,01fh,06ch,000h,01fh,02dh,01fh	; be08  .J.l..-.
	defb 04ch,01fh,08dh,000h,08eh,041h,00eh,045h	; be10  L....A.E
	defb 08eh,045h,08eh,062h,00eh,065h,00eh,066h	; be18  .E.b.e.f
	defb 00eh,082h,00eh,085h,08eh,085h,000h,000h	; be20  ........
	defb 0a8h,063h,0a8h,063h,0a8h,063h,000h,00eh	; be28  .c.c.c..
	defb 042h,08eh,064h,00eh,083h,08eh,0a5h,028h	; be30  B.d....(
	defb 04ah,028h,08dh,000h,09fh,04bh,09fh,06ch	; be38  J(...K.l
	defb 09fh,08ch,09fh,0aah,000h,028h,044h,028h	; be40  .....(D(
	defb 044h,028h,044h,028h,044h,000h,00eh,044h	; be48  D(D(D..D
	defb 00eh,062h,08eh,065h,08eh,080h,00eh,084h	; be50  .b.e....
	defb 00eh,087h,00eh,0a2h,00eh,0a5h,000h,0a2h	; be58  ........
	defb 08bh,000h,00eh,064h,08eh,085h,00eh,0a3h	; be60  ...d....
	defb 00eh,0a4h,0a8h,041h,028h,04eh,0a8h,08ah	; be68  ...A(N..
	defb 0a8h,0a5h,000h,0a2h,064h,000h,09fh,06bh	; be70  ....d..k
	defb 01fh,0ach,027h,07bh,000h,000h	; be78

; ----------------------------------------------------------------------
; DATOS objetos_mapa_9: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 9: una lista por sala
;   (21); lo leen p04:6014 (105 bytes)
;   0xbe7e..0xbee7  (105 bytes)
DATA_objetos_mapa_9:
	defb 000h,000h,013h,04ah,013h,06dh,013h,069h	; be7e  ...J.m.i
	defb 093h,08ah,000h,0abh,06bh,000h,093h,088h	; be86  ....k...
	defb 013h,0aeh,093h,04ah,093h,04ch,000h,00ch	; be8e  ...J.L..
	defb 02bh,08ch,04dh,00ch,08ah,08ch,0a9h,0abh	; be96  +.M.....
	defb 02bh,02bh,08dh,000h,000h,08ch,02bh,00ch	; be9e  ++....+.
	defb 04bh,00ch,08ch,08ch,0abh,000h,08ch,04ch	; bea6  K......L
	defb 00ch,04ah,00ch,06ah,00ch,0adh,08ch,089h	; beae  .J.j....
	defb 000h,02bh,04eh,02bh,08bh,000h,02bh,042h	; beb6  .+N+..+B
	defb 0abh,044h,02bh,0afh,0abh,044h,000h,093h	; bebe  .D+..D..
	defb 04dh,013h,06ch,093h,08bh,093h,0a9h,000h	; bec6  M.l.....
	defb 00ch,02ah,00ch,02ch,08ch,02dh,00ch,06dh	; bece  .*.,.-.m
	defb 000h,000h,00ch,02ah,00ch,04ah,000h,000h	; bed6  ...*.J..
	defb 000h,000h,08ch,04bh,000h,0c0h,045h,000h	; bede  ...K..E.
	defb 000h	; bee6

; ----------------------------------------------------------------------
; DATOS objetos_mapa_10: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 10: una lista por sala
;   (27); lo leen p04:6014 (199 bytes)
;   0xbee7..0xbfae  (199 bytes)
DATA_objetos_mapa_10:
	defb 000h,08eh,062h,08eh,062h,08eh,062h,08eh	; bee7  ..b.b.b.
	defb 062h,08eh,062h,08eh,062h,08eh,062h,08eh	; beef  b.b.b.b.
	defb 062h,00eh,065h,00eh,065h,00eh,065h,000h	; bef7  b.e.e.e.
	defb 000h,00eh,062h,00eh,066h,000h,08eh,061h	; beff  ..b.f..a
	defb 08eh,062h,08eh,063h,08eh,065h,000h,0c3h	; bf07  .b.c.e..
	defb 06ch,000h,069h,02bh,0e9h,03bh,069h,02eh	; bf0f  l.i+..i.
	defb 000h,0c3h,02bh,000h,069h,02ch,0e9h,02eh	; bf17  ..+.i,..
	defb 000h,043h,0ach,000h,001h,0abh,081h,06ch	; bf1f  .C.....l
	defb 000h,0e9h,029h,0e9h,02ah,069h,02eh,000h	; bf27  ..).*i..
	defb 08eh,041h,00eh,045h,08eh,061h,00eh,063h	; bf2f  .A.E.a.c
	defb 00eh,065h,08eh,082h,00eh,084h,00eh,0a2h	; bf37  .e......
	defb 08eh,0a4h,000h,085h,04dh,005h,08ch,085h	; bf3f  ....M...
	defb 0a9h,000h,085h,029h,085h,04bh,005h,04dh	; bf47  ...).K.M
	defb 085h,06ah,085h,08ch,000h,001h,02eh,081h	; bf4f  .j......
	defb 049h,081h,04bh,081h,08ch,001h,0abh,000h	; bf57  I.K.....
	defb 069h,02ah,069h,02bh,069h,02ch,069h,02dh	; bf5f  i*i+i,i-
	defb 000h,043h,02ah,000h,069h,029h,0e9h,039h	; bf67  .C*.i).9
	defb 069h,03eh,0e9h,02eh,000h,069h,02ch,0e9h	; bf6f  i>...i,.
	defb 02eh,000h,085h,069h,005h,08dh,085h,04ch	; bf77  ...i...L
	defb 000h,08eh,043h,08eh,043h,08eh,043h,08eh	; bf7f  ..C.C.C.
	defb 043h,00eh,064h,00eh,064h,00eh,064h,00eh	; bf87  C.d.d.d.
	defb 064h,000h,069h,029h,0e9h,03bh,0e9h,02eh	; bf8f  d.i)....
	defb 000h,00eh,067h,00eh,067h,00eh,067h,00eh	; bf97  ..g.g.g.
	defb 067h,00eh,067h,00eh,067h,00eh,067h,00eh	; bf9f  g.g.g.g.
	defb 067h,000h,000h,015h,043h,000h,000h	; bfa7

; ----------------------------------------------------------------------
; DATOS objetos_mapa_11: los objetos de cada sala, [tipo][sitio] y un byte con
;   los 7 bits bajos a 0 al final (p04:6014) del mapa 11: una lista por sala
;   (6); lo leen p04:6014 (42 bytes)
;   0xbfae..0xbfd8  (42 bytes)
DATA_objetos_mapa_11:
	defb 000h,000h,00eh,043h,00eh,044h,08eh,064h	; bfae  ...C.D.d
	defb 00eh,086h,000h,00eh,066h,08eh,085h,00eh	; bfb6  ....f...
	defb 063h,08eh,064h,000h,000h,05ch,029h,0dch	; bfbe  c.d..\).
	defb 02dh,05ch,04ah,0dch,04ch,05ch,069h,0dch	; bfc6  -\J.L\i.
	defb 06ch,0dch,06eh,05ch,08bh,0dch,08dh,0dch	; bfce  l.n\....
	defb 0ach,000h	; bfd6

; ----------------------------------------------------------------------
; DATOS relleno_p06: relleno: 40 bytes 0xFF hasta el final del banco, sin nada
;   que los lea ni los ejecute (40 bytes)
;   0xbfd8..0xc000  (40 bytes)
DATA_relleno_p06:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe8  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff8  ........
