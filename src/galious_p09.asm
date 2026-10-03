; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 09 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS partida_9FFF_cola: la instruccion de p08:9FFF (3A | AB E0) empieza al
;   final del banco 8 y acaba al principio del 9, que el cartucho pone siempre
;   a continuacion: aqui el resto; lo leen p08:9FFF (2 bytes)
;   0xa000..0xa002  (2 bytes)
DATA_partida_9FFF_cola:
	defb 0abh,0e0h	; a000

; ======================================================================
; CODIGO 0xa002..0xa056  (84 bytes)
; ======================================================================


L_A002:
	or a			;a002
	ret nz			;a003
	ld de,0ee1ch		;a004
	jr $-51		;a007
L_A009:
	ld a,(0e0ach)		;a009
	or a			;a00c
	ret nz			;a00d
	ld de,0ed84h		;a00e
	jr $-61		;a011
L_A013:
	ld hl,(0f00ch)		;a013
	ld (hl),001h		;a016
	ld de,(0f002h)		;a018
	inc hl			;a01c
	ld (hl),000h		;a01d
	inc hl			;a01f
	ld (hl),d			;a020
	inc hl			;a021
	ld (hl),e			;a022
	inc hl			;a023
	ld (hl),003h		;a024
	inc hl			;a026
	inc hl			;a027
	inc hl			;a028
	ld (hl),01eh		;a029
	inc hl			;a02b
	ld (hl),0c5h		;a02c
	ld de,00010h		;a02e
	add hl,de			;a031
	ld (0f00ch),hl		;a032
	ret			;a035
L_A036:
	ld ix,0ea00h		;a036   ; apunta a las puertas del castillo (figura 1, dos de 16 bytes)
	exx			;a03a
	ld b,002h		;a03b
	ld de,00010h		;a03d
L_A040:
	exx			;a040
	call L_A04B		;a041
	exx			;a044
	add ix,de		;a045
	djnz L_A040		;a047
	exx			;a049
	ret			;a04a
L_A04B:
	ld a,(ix+000h)		;a04b
	and a			;a04e
	ret z			;a04f
	ld a,(ix+001h)		;a050
	call 04050h		;a053   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_A056: 4 destinos del despachador de 0x4140 (call en p09:A053):
;   0xA05E, 0xA0BB, 0xA0CE, 0xA0EA; lo leen p09:A053 (8 bytes)
;   0xa056..0xa05e  (8 bytes)
DATA_tabla_A056:
	defb 05eh,0a0h	; a056
	defb 0bbh,0a0h	; a058
	defb 0ceh,0a0h	; a05a
	defb 0eah,0a0h	; a05c

; ======================================================================
; CODIGO 0xa05e..0xa630  (1490 bytes)
; ======================================================================


L_A05E:
	ld de,(0e04ah)		;a05e   ; lee las llaves (BCD, 16 bits)
	ld a,d			;a062
	or e			;a063
	ret z			;a064
	ld a,(ix+002h)		;a065
	add a,018h		;a068
	ld c,a			;a06a
	ld a,(0e505h)		;a06b   ; lee la y del personaje
	cp c			;a06e
	ret nz			;a06f
	ld a,(0e503h)		;a070   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a073
	ld a,(ix+003h)		;a074
	ld b,0f8h		;a077
	ld c,008h		;a079
	jr z,L_A081		;a07b
	ld b,010h		;a07d
	ld c,004h		;a07f
L_A081:
	add a,b			;a081
	ld b,a			;a082
	ld a,(0e507h)		;a083   ; lee la x del personaje
	cp b			;a086
	ret nz			;a087
	call L_A109		;a088
	ret nz			;a08b
	ld a,(0e009h)		;a08c   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and c			;a08f
	jr z,L_A0F7		;a090
	dec (ix+007h)		;a092
	ret nz			;a095
	call L_A0FC		;a096
	call L_A0A7		;a099
	xor a			;a09c
	ld (0e529h),a		;a09d
	ld a,022h		;a0a0
	call 04059h		;a0a2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jr L_A0CA		;a0a5
L_A0A7:
	call L_A1F2		;a0a7
L_A0AA:
	ld a,007h		;a0aa
	ld (0e500h),a		;a0ac   ; guarda el estado del personaje (5 = hundirse)
	xor a			;a0af
	ld (0e533h),a		;a0b0   ; guarda parpadeando
	ld (0e508h),a		;a0b3   ; guarda la espada (1 empieza, 2 golpeando)
	inc a			;a0b6
	ld (0e518h),a		;a0b7   ; guarda sin daño (tras un golpe o al entrar)
	ret			;a0ba
L_A0BB:
	dec (ix+007h)		;a0bb
	ret nz			;a0be
	call L_A0FC		;a0bf
	dec (ix+004h)		;a0c2
	ld a,(ix+004h)		;a0c5
	dec a			;a0c8
	ret nz			;a0c9
L_A0CA:
	inc (ix+001h)		;a0ca
	ret			;a0cd
L_A0CE:
	ld a,(0e503h)		;a0ce   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a0d1
	ld a,(ix+003h)		;a0d2
	ld b,010h		;a0d5
	jr z,L_A0DB		;a0d7
	ld b,0f8h		;a0d9
L_A0DB:
	add a,b			;a0db
	ld b,a			;a0dc
	ld a,(0e507h)		;a0dd   ; lee la x del personaje
	cp b			;a0e0
	ret nz			;a0e1
	call L_A101		;a0e2
	ld (ix+004h),a		;a0e5
	jr L_A0CA		;a0e8
L_A0EA:
	ld (ix+001h),000h		;a0ea
	ld (ix+004h),003h		;a0ee
	ld a,021h		;a0f2
	call 04059h		;a0f4   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A0F7:
	ld (ix+007h),01eh		;a0f7
	ret			;a0fb
L_A0FC:
	ld (ix+007h),006h		;a0fc
	ret			;a100
L_A101:
	xor a			;a101
	ld (0e500h),a		;a102   ; guarda el estado del personaje (5 = hundirse)
	ld (0e518h),a		;a105   ; guarda sin daño (tras un golpe o al entrar)
	ret			;a108
L_A109:
	ld a,(0e500h)		;a109   ; lee el estado del personaje (5 = hundirse)
	and a			;a10c
	ret			;a10d
L_A10E:
	ld hl,(0f00ah)		;a10e
	ld (hl),001h		;a111
	ld de,(0f002h)		;a113
	inc hl			;a117
	xor a			;a118
	ld (hl),a			;a119
	inc hl			;a11a
	ld (hl),d			;a11b
	inc hl			;a11c
	ld (hl),e			;a11d
	inc hl			;a11e
	ld (hl),a			;a11f
	inc hl			;a120
	ld (hl),01eh		;a121
	ld hl,(0f00ah)		;a123
	ld de,00010h		;a126
	add hl,de			;a129
	ld (0f00ah),hl		;a12a
	ret			;a12d
L_A12E:
	ld ix,0ea30h		;a12e
	exx			;a132
	ld b,002h		;a133
	ld de,00010h		;a135
L_A138:
	exx			;a138
	call L_A143		;a139
	exx			;a13c
	add ix,de		;a13d
	djnz L_A138		;a13f
	exx			;a141
	ret			;a142
L_A143:
	ld a,(ix+000h)		;a143
	and a			;a146
	ret z			;a147
	ld a,(ix+001h)		;a148
	dec a			;a14b
	jr z,L_A1AF		;a14c
	jp p,L_A1C6		;a14e
	ld de,(0e04ah)		;a151   ; lee las llaves (BCD, 16 bits)
	ld a,d			;a155
	or e			;a156
	ret z			;a157
	ld a,(ix+002h)		;a158
	add a,018h		;a15b
	ld b,a			;a15d
	ld a,(0e505h)		;a15e   ; lee la y del personaje
	cp b			;a161
	ret nz			;a162
	ld a,(0e503h)		;a163   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld e,a			;a166
	and a			;a167
	ld a,(ix+003h)		;a168
	ld b,0f8h		;a16b
	ld c,008h		;a16d
	ld d,001h		;a16f
	jr z,L_A179		;a171
	ld b,010h		;a173
	ld c,004h		;a175
	ld d,003h		;a177
L_A179:
	add a,b			;a179
	ld b,a			;a17a
	ld a,(0e507h)		;a17b   ; lee la x del personaje
	cp b			;a17e
	ret nz			;a17f
	call L_A109		;a180
	ret nz			;a183
	ld a,(0e009h)		;a184   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and c			;a187
	jp z,L_A205		;a188
	dec (ix+005h)		;a18b
	ret nz			;a18e
	push de			;a18f
	call L_A0A7		;a190
	pop de			;a193
	xor a			;a194
	ld (0e529h),a		;a195
	ld (ix+004h),d		;a198
	ld a,021h		;a19b
	call 04059h		;a19d   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A1A0:
	inc (ix+001h)		;a1a0
	bit 0,e		;a1a3
	ret z			;a1a5
	ld a,(ix+003h)		;a1a6
	sub 008h		;a1a9
	ld (ix+003h),a		;a1ab
	ret			;a1ae
L_A1AF:
	ld a,(0e503h)		;a1af   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld e,a			;a1b2
	and a			;a1b3
	ld a,(ix+003h)		;a1b4
	jr z,L_A1BB		;a1b7
	add a,010h		;a1b9
L_A1BB:
	ld b,a			;a1bb
	ld a,(0e507h)		;a1bc   ; lee la x del personaje
	cp b			;a1bf
	ret nz			;a1c0
	inc (ix+004h)		;a1c1
	jr L_A1A0		;a1c4
L_A1C6:
	ld a,(0e503h)		;a1c6   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld c,a			;a1c9
	and a			;a1ca
	ld a,(ix+003h)		;a1cb
	jr nz,L_A1D2		;a1ce
	add a,018h		;a1d0
L_A1D2:
	ld b,a			;a1d2
	ld a,(0e507h)		;a1d3   ; lee la x del personaje
	cp b			;a1d6
	ret nz			;a1d7
	ld (ix+004h),000h		;a1d8
	call L_A205		;a1dc
	bit 0,c		;a1df
	jr z,L_A1EB		;a1e1
	ld a,(ix+003h)		;a1e3
	add a,010h		;a1e6
	ld (ix+003h),a		;a1e8
L_A1EB:
	call L_A101		;a1eb
	ld (ix+001h),a		;a1ee
	ret			;a1f1
L_A1F2:
	ld hl,0e04ah		;a1f2   ; apunta a las llaves (BCD)
	ld c,001h		;a1f5
	ld a,(hl)			;a1f7
	sub 001h		;a1f8
	daa			;a1fa
	ld (hl),a			;a1fb
	inc hl			;a1fc
	ld a,(hl)			;a1fd
	sbc a,000h		;a1fe
	daa			;a200
	ld (hl),a			;a201
	jp 0408ch		;a202   ; pinta_llaves (por 0x408C): las llaves en la fila 2, columna 24
L_A205:
	ld (ix+005h),01eh		;a205
	ret			;a209
L_A20A:
	ld a,(0f000h)		;a20a
	rra			;a20d
	rra			;a20e
	rra			;a20f
	rra			;a210
	and 001h		;a211
	xor 001h		;a213
	ld hl,0ea50h		;a215
	ld de,(0f002h)		;a218
	inc a			;a21c
	ld (hl),a			;a21d
L_A21E:
	inc hl			;a21e
	xor a			;a21f
	ld (hl),a			;a220
	inc hl			;a221
	ld (hl),d			;a222
	inc hl			;a223
	ld (hl),e			;a224
	inc hl			;a225
	ld (hl),e			;a226
	inc hl			;a227
	ld (hl),a			;a228
	inc hl			;a229
	ld (hl),01eh		;a22a
	ret			;a22c
L_A22D:
	ld hl,0ea50h		;a22d
	ld a,(hl)			;a230
	and a			;a231
	ret z			;a232
	dec a			;a233
	ld c,a			;a234
	inc hl			;a235
	ld a,(hl)			;a236
	dec a			;a237
	jr z,L_A27D		;a238
	inc hl			;a23a
	ld a,(hl)			;a23b
	add a,018h		;a23c
	ld b,a			;a23e
	ld a,(0e505h)		;a23f   ; lee la y del personaje
	cp b			;a242
	ret nz			;a243
	ld a,(0e503h)		;a244   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	cp c			;a247
	ret nz			;a248
	and a			;a249
	inc hl			;a24a
	inc hl			;a24b
	ld a,(hl)			;a24c
	ld b,0f8h		;a24d
	ld c,008h		;a24f
	jr z,L_A257		;a251
	ld b,010h		;a253
	ld c,004h		;a255
L_A257:
	add a,b			;a257
	ld b,a			;a258
	ld a,(0e507h)		;a259   ; lee la x del personaje
	cp b			;a25c
	ret nz			;a25d
	call L_A109		;a25e
	ret nz			;a261
	ld a,(0e009h)		;a262   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and c			;a265
	jr z,L_A299		;a266
	inc hl			;a268
	inc hl			;a269
	dec (hl)			;a26a
	ret nz			;a26b
	call L_A0AA		;a26c
	ld (0e529h),a		;a26f
	ld (hl),006h		;a272
	ld hl,0ea51h		;a274
	inc (hl)			;a277
	ld a,023h		;a278
	jp 04059h		;a27a   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A27D:
	ld hl,0ea56h		;a27d
	dec (hl)			;a280
	ret nz			;a281
	ld (hl),006h		;a282
	bit 0,c		;a284
	jr nz,L_A28C		;a286
	dec hl			;a288
	inc (hl)			;a289
	jr L_A28E		;a28a
L_A28C:
	dec hl			;a28c
	dec (hl)			;a28d
L_A28E:
	ld a,(hl)			;a28e
	and 003h		;a28f
	ld (hl),a			;a291
	ret nz			;a292
	call L_A101		;a293
	ld (0ea51h),a		;a296
L_A299:
	ld hl,0ea56h		;a299
	ld (hl),01eh		;a29c
	ret			;a29e
L_A29F:
	ld hl,(0f008h)		;a29f
	ld de,(0f002h)		;a2a2
	ld (hl),001h		;a2a6
	call L_A21E		;a2a8
	ld hl,(0f008h)		;a2ab
	ld de,00010h		;a2ae
	add hl,de			;a2b1
	ld (0f008h),hl		;a2b2
	ret			;a2b5
L_A2B6:
	ld iy,0ea60h		;a2b6
	ld b,004h		;a2ba
L_A2BC:
	push bc			;a2bc
	call L_A2C9		;a2bd
	ld de,00010h		;a2c0
	add iy,de		;a2c3
	pop bc			;a2c5
	djnz L_A2BC		;a2c6
	ret			;a2c8
L_A2C9:
	ld a,(iy+000h)		;a2c9
	and a			;a2cc
	ret z			;a2cd
	ld a,(iy+001h)		;a2ce
	dec a			;a2d1
	jp z,L_A376		;a2d2
	jp p,L_A3D3		;a2d5
	xor a			;a2d8
	ld (iy+009h),a		;a2d9
	ld ix,0e500h		;a2dc   ; apunta a el estado del personaje (5 = hundirse)
	call L_A345		;a2e0
	jr z,L_A30E		;a2e3
	ld a,001h		;a2e5
	ld (iy+009h),a		;a2e7
	ld a,(0e62eh)		;a2ea
	or a			;a2ed
	ret z			;a2ee
	ld ix,0e800h		;a2ef   ; apunta a los huecos de figura (32 bytes cada uno)
	exx			;a2f3
	ld de,00020h		;a2f4
	ld b,010h		;a2f7
L_A2F9:
	exx			;a2f9
	call L_A31F		;a2fa
	jr z,L_A306		;a2fd
	exx			;a2ff
	add ix,de		;a300
	djnz L_A2F9		;a302
	exx			;a304
	ret			;a305
L_A306:
	res 4,(ix+002h)		;a306
	ld (ix+014h),001h		;a30a
L_A30E:
	push ix		;a30e
	pop hl			;a310
	inc a			;a311
	ld (iy+000h),a		;a312
	ld (iy+00ah),l		;a315
	ld (iy+00bh),h		;a318
	inc (iy+001h)		;a31b
	ret			;a31e
L_A31F:
	ld a,(ix+000h)		;a31f
	cp 00ah		;a322
	ret nz			;a324
	ld a,(iy+002h)		;a325
	add a,008h		;a328
	cp (ix+005h)		;a32a
	ret nz			;a32d
	ld a,(iy+004h)		;a32e
	bit 7,(ix+00fh)		;a331
	ld b,0f0h		;a335
	ld c,001h		;a337
	jr z,L_A33F		;a339
	ld b,008h		;a33b
	ld c,000h		;a33d
L_A33F:
	add a,b			;a33f
	cp (ix+007h)		;a340
	ld a,c			;a343
	ret			;a344
L_A345:
	ld hl,0e098h		;a345   ; apunta a tiene el objeto 0x29
	call 04089h		;a348   ; tiene_o_popolon (por 0x4089): NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)
	jr z,L_A373		;a34b
	ld a,(iy+002h)		;a34d
	add a,018h		;a350
	ld b,a			;a352
	ld a,(0e505h)		;a353   ; lee la y del personaje
	cp b			;a356
	ret nz			;a357
	ld a,(0e503h)		;a358   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a35b
	ld a,(iy+004h)		;a35c
	ld b,0f8h		;a35f
	ld c,008h		;a361
	jr z,L_A369		;a363
	ld b,010h		;a365
	ld c,004h		;a367
L_A369:
	add a,b			;a369
	ld b,a			;a36a
	ld a,(0e507h)		;a36b   ; lee la x del personaje
	cp b			;a36e
	ld a,(0e503h)		;a36f   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ret			;a372
L_A373:
	xor a			;a373
	dec a			;a374
	ret			;a375
L_A376:
	ld l,(iy+00ah)		;a376
	ld h,(iy+00bh)		;a379
	push hl			;a37c
	pop ix		;a37d
	ld a,(iy+009h)		;a37f
	and a			;a382
	jr z,L_A398		;a383
	call L_A31F		;a385
	jr z,L_A3BD		;a388
	set 4,(ix+002h)		;a38a
L_A38E:
	xor a			;a38e
	ld (iy+001h),a		;a38f
	ld (iy+009h),a		;a392
	jp L_A40F		;a395
L_A398:
	call L_A345		;a398
	jr nz,L_A38E		;a39b
	call L_A109		;a39d
	ret nz			;a3a0
	ld a,(0e009h)		;a3a1   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and c			;a3a4
	jr z,L_A38E		;a3a5
	dec (iy+006h)		;a3a7
	ret nz			;a3aa
	call L_A0AA		;a3ab
	ld (0e529h),a		;a3ae
L_A3B1:
	ld (iy+006h),006h		;a3b1
	inc (iy+001h)		;a3b5
	ld a,023h		;a3b8
	jp 04059h		;a3ba   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A3BD:
	res 4,(ix+002h)		;a3bd
	ld (ix+014h),000h		;a3c1
	dec (iy+006h)		;a3c5
	ret nz			;a3c8
	set 4,(ix+002h)		;a3c9
	ld (ix+001h),000h		;a3cd
	jr L_A3B1		;a3d1
L_A3D3:
	dec (iy+006h)		;a3d3
	ret nz			;a3d6
	ld (iy+006h),006h		;a3d7
	bit 0,(iy+000h)		;a3db
	jr z,L_A3E6		;a3df
	inc (iy+005h)		;a3e1
	jr L_A3E9		;a3e4
L_A3E6:
	dec (iy+005h)		;a3e6
L_A3E9:
	ld a,(iy+005h)		;a3e9
	and 003h		;a3ec
	ld (iy+005h),a		;a3ee
	ret nz			;a3f1
	call L_A101		;a3f2
	ld (iy+001h),a		;a3f5
	ld a,(iy+009h)		;a3f8
	and a			;a3fb
	jr z,L_A40F		;a3fc
	ld l,(iy+00ah)		;a3fe
	ld h,(iy+00bh)		;a401
	push hl			;a404
	pop ix		;a405
	ld (ix+001h),001h		;a407
	xor a			;a40b
	ld (iy+009h),a		;a40c
L_A40F:
	ld a,01eh		;a40f
	ld (iy+006h),a		;a411
	ret			;a414
L_A415:
	ld a,0f0h		;a415
	ld (0eaa8h),a		;a417
	ld hl,(0e60eh)		;a41a   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	bit 1,(hl)		;a41d
	call nz,L_A431		;a41f
	ld hl,0eaa0h		;a422
	ld (hl),001h		;a425
	ld de,(0f002h)		;a427
	inc hl			;a42b
	inc hl			;a42c
	ld (hl),d			;a42d
	inc hl			;a42e
	ld (hl),e			;a42f
	ret			;a430
L_A431:
	ld a,003h		;a431
	ld (0eaa1h),a		;a433
	ld (0eaa4h),a		;a436
	ret			;a439
L_A43A:
	ld hl,0eaa0h		;a43a
	ld a,(hl)			;a43d
	and a			;a43e
	ret z			;a43f
	inc hl			;a440
	ld a,(hl)			;a441
	and a			;a442
	jr nz,L_A461		;a443
	ld hl,0eaa2h		;a445
	ld a,(0e505h)		;a448   ; lee la y del personaje
	sub (hl)			;a44b
	cp 019h		;a44c
	ret nc			;a44e
	inc hl			;a44f
	ld a,(0e507h)		;a450   ; lee la x del personaje
	sub 008h		;a453
	sub (hl)			;a455
	cp 003h		;a456
	ret nc			;a458
	ld a,(0e503h)		;a459   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld (0eaa9h),a		;a45c
	jr L_A4B7		;a45f
L_A461:
	dec a			;a461
	jr nz,L_A498		;a462
	ld hl,0eaa2h		;a464
	ld a,(0e505h)		;a467   ; lee la y del personaje
	sub (hl)			;a46a
	cp 019h		;a46b
	ret nc			;a46d
	ld a,(0e503h)		;a46e   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld b,a			;a471
	ld a,(0eaa9h)		;a472
	cp b			;a475
	ret nz			;a476
	inc hl			;a477
	and a			;a478
	ld a,(hl)			;a479
	ld b,010h		;a47a
	jr z,L_A480		;a47c
	ld b,0f7h		;a47e
L_A480:
	add a,b			;a480
	ld b,a			;a481
	ld a,(0e507h)		;a482   ; lee la x del personaje
	sub b			;a485
	cp 003h		;a486
	ret nc			;a488
	ld a,001h		;a489
	ld (0eaa4h),a		;a48b
	ld hl,0eaa1h		;a48e
	inc (hl)			;a491
L_A492:
	ld a,00fh		;a492
	ld (0eaa7h),a		;a494
	ret			;a497
L_A498:
	dec a			;a498
	ret nz			;a499
	ld a,(0eaa4h)		;a49a
	cp 002h		;a49d
	call z,L_A4BC		;a49f
	ld hl,0eaa7h		;a4a2
	dec (hl)			;a4a5
	ret nz			;a4a6
	call L_A492		;a4a7
	ld hl,0eaa4h		;a4aa
	inc (hl)			;a4ad
	ld a,(hl)			;a4ae
	cp 003h		;a4af
	ret nz			;a4b1
	ld hl,(0e60eh)		;a4b2   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	set 1,(hl)		;a4b5
L_A4B7:
	ld hl,0eaa1h		;a4b7
	inc (hl)			;a4ba
	ret			;a4bb
L_A4BC:
	ld hl,0eaa2h		;a4bc
	ld a,(hl)			;a4bf
	add a,018h		;a4c0
	ld b,a			;a4c2
	ld a,(0e505h)		;a4c3   ; lee la y del personaje
	cp b			;a4c6
	jr nz,L_A4EC		;a4c7
	inc hl			;a4c9
	ld a,(hl)			;a4ca
	add a,004h		;a4cb
	ld b,a			;a4cd
	ld a,(0e507h)		;a4ce   ; lee la x del personaje
	sub b			;a4d1
	jr nc,L_A4E2		;a4d2
	neg		;a4d4
	cp 00ch		;a4d6
	jr nc,L_A4EC		;a4d8
	ld a,(hl)			;a4da
	sub 008h		;a4db
	ld (0e507h),a		;a4dd   ; guarda la x del personaje
	jr L_A4EC		;a4e0
L_A4E2:
	cp 004h		;a4e2
	jr nc,L_A4EC		;a4e4
	ld a,(hl)			;a4e6
	add a,010h		;a4e7
	ld (0e507h),a		;a4e9   ; guarda la x del personaje
L_A4EC:
	ld ix,0e800h		;a4ec   ; apunta a los huecos de figura (32 bytes cada uno)
	exx			;a4f0
	ld b,010h		;a4f1
	ld de,00020h		;a4f3
L_A4F6:
	exx			;a4f6
	ld hl,0eaa2h		;a4f7
	ld a,(hl)			;a4fa
	add a,008h		;a4fb
	ld b,a			;a4fd
	ld a,(ix+005h)		;a4fe   ; lee la y de la figura
	cp b			;a501
	jr nz,L_A527		;a502
	inc hl			;a504
	ld a,(hl)			;a505
	add a,004h		;a506
	ld b,a			;a508
	ld a,(ix+007h)		;a509   ; lee la x de la figura
	sub b			;a50c
	jr nc,L_A51D		;a50d
	neg		;a50f
	cp 014h		;a511
	jr nc,L_A527		;a513
	ld a,(hl)			;a515
	sub 010h		;a516
	ld (ix+007h),a		;a518   ; guarda la x de la figura
	jr L_A527		;a51b
L_A51D:
	cp 004h		;a51d
	jr nc,L_A527		;a51f
	ld a,(hl)			;a521
	add a,008h		;a522
	ld (ix+007h),a		;a524   ; guarda la x de la figura
L_A527:
	exx			;a527
	add ix,de		;a528
	djnz L_A4F6		;a52a
	exx			;a52c
	ret			;a52d
L_A52E:
	ld hl,0eab0h		;a52e
	ld (hl),001h		;a531
	inc hl			;a533
	inc hl			;a534
	inc hl			;a535
	ld (hl),02ch		;a536
	inc hl			;a538
	ld (hl),001h		;a539
	inc hl			;a53b
	inc hl			;a53c
	inc hl			;a53d
	ld (hl),078h		;a53e
	ret			;a540
L_A541:
	ld hl,0eab0h		;a541
	ld a,(hl)			;a544
	and a			;a545
	ret z			;a546
	inc hl			;a547
	ld a,(hl)			;a548
	and a			;a549
	jr nz,L_A58C		;a54a
	ld a,(0e505h)		;a54c   ; lee la y del personaje
	sub 078h		;a54f
	ret nz			;a551
	ld b,a			;a552
	ld a,(0e507h)		;a553   ; lee la x del personaje
	sub 018h		;a556
	cp 008h		;a558
	jr c,L_A565		;a55a
	inc b			;a55c
	ld a,(0e507h)		;a55d   ; lee la x del personaje
	sub 0e0h		;a560
	cp 008h		;a562
	ret nc			;a564
L_A565:
	ld a,b			;a565
	ld (0eab2h),a		;a566
	and a			;a569
	jr z,L_A56E		;a56a
	ld a,003h		;a56c
L_A56E:
	ld (0eab5h),a		;a56e
	ld hl,(0eab3h)		;a571
	dec hl			;a574
	ld (0eab3h),hl		;a575
	ld a,h			;a578
	or l			;a579
	ret nz			;a57a
	ld a,(0eab5h)		;a57b
	ld c,a			;a57e
	ld b,000h		;a57f
	ld hl,0a630h		;a581
	add hl,bc			;a584
	ld a,(hl)			;a585
	ld (0eab8h),a		;a586
	jp L_A5E6		;a589
L_A58C:
	ld hl,0eab6h		;a58c
	bit 0,(hl)		;a58f
	jr z,L_A59C		;a591
	ld hl,0eab3h		;a593
	dec (hl)			;a596
	jp p,L_A59C		;a597
	ld (hl),000h		;a59a
L_A59C:
	cp 005h		;a59c
	jr z,L_A601		;a59e
	ld hl,0eab7h		;a5a0
	ld a,(0e505h)		;a5a3   ; lee la y del personaje
	cp (hl)			;a5a6
	ret nz			;a5a7
	inc hl			;a5a8
	ld a,(0e507h)		;a5a9   ; lee la x del personaje
	sub (hl)			;a5ac
	add a,007h		;a5ad
	cp 01fh		;a5af
	ret nc			;a5b1
	ld a,001h		;a5b2
	ld (0eab6h),a		;a5b4
	ld a,(0eab3h)		;a5b7
	and a			;a5ba
	ret nz			;a5bb
	ld hl,0eab7h		;a5bc
	ld de,0eabbh		;a5bf
	ld bc,00002h		;a5c2
	ldir		;a5c5
	ld a,(0eab1h)		;a5c7
	cp 004h		;a5ca
	jr z,L_A5ED		;a5cc
	ld hl,0eab5h		;a5ce
	ld a,(0eab2h)		;a5d1
	and a			;a5d4
	jr nz,L_A5DA		;a5d5
	inc (hl)			;a5d7
	jr L_A5DB		;a5d8
L_A5DA:
	dec (hl)			;a5da
L_A5DB:
	ld c,(hl)			;a5db
	ld b,000h		;a5dc
	ld hl,0a630h		;a5de
	add hl,bc			;a5e1
	ld a,(hl)			;a5e2
	ld (0eab8h),a		;a5e3
L_A5E6:
	ld a,004h		;a5e6
	call 04059h		;a5e8   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jr L_A5F3		;a5eb
L_A5ED:
	ld hl,00000h		;a5ed
	ld (0eab7h),hl		;a5f0
L_A5F3:
	ld a,080h		;a5f3
	ld (0eab3h),a		;a5f5
	xor a			;a5f8
	ld (0eab6h),a		;a5f9
	ld hl,0eab1h		;a5fc
	inc (hl)			;a5ff
	ret			;a600
L_A601:
	ld a,(0eab2h)		;a601
	and a			;a604
	ld a,(0e507h)		;a605   ; lee la x del personaje
	jr z,L_A60F		;a608
	cp 018h		;a60a
	ret nc			;a60c
	jr L_A612		;a60d
L_A60F:
	cp 0d9h		;a60f
	ret c			;a611
L_A612:
	ld a,001h		;a612
	ld (0eab6h),a		;a614
	ld a,(0eab3h)		;a617
	and a			;a61a
	ret nz			;a61b
	ld hl,00000h		;a61c
	ld (0eabbh),hl		;a61f
	ld hl,0012ch		;a622
	ld (0eab3h),hl		;a625
	xor a			;a628
	ld (0eab1h),a		;a629
	ld (0eab6h),a		;a62c
	ret			;a62f

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a630: 4 bytes que p09:A581 y p09:A5DE ponen en 0xEAB8
;   segun 0xEAB5 / 0xEAB6
;   0xa630..0xa634  (4 bytes)
DATA_cuatro_bytes_a630:
	defb 038h,060h,090h,0b8h	; a630

; ======================================================================
; CODIGO 0xa634..0xa65d  (41 bytes)
; ======================================================================


L_A634:
	ld hl,(0e60eh)		;a634   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	ld a,(hl)			;a637
	rra			;a638
	rra			;a639
	and 001h		;a63a
	xor 001h		;a63c
	ld hl,0ea20h		;a63e
	ld (hl),a			;a641
	ld de,(0f002h)		;a642
	inc hl			;a646
	ld (hl),d			;a647
	inc hl			;a648
	ld (hl),e			;a649
	inc hl			;a64a
	ld a,(0f000h)		;a64b
	rra			;a64e
	rra			;a64f
	rra			;a650
	rra			;a651
	and 00fh		;a652
	ex de,hl			;a654
	ld hl,0a65dh		;a655
	call 04083h		;a658   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (de),a			;a65b
	ret			;a65c

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a65d: 4 bytes que p09:A655 elige con un nibble y guarda
;   en (DE)
;   0xa65d..0xa661  (4 bytes)
DATA_cuatro_bytes_a65d:
	defb 01eh,014h,00ah,003h	; a65d

; ======================================================================
; CODIGO 0xa661..0xa6eb  (138 bytes)
; ======================================================================


L_A661:
	ld hl,0ea20h		;a661
	ld a,(hl)			;a664
	and a			;a665
	ret z			;a666
	ex de,hl			;a667
	ld hl,0e08bh		;a668   ; apunta a tiene el objeto 0x1C
	call 04089h		;a66b   ; tiene_o_popolon (por 0x4089): NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)
	ret z			;a66e
	ex de,hl			;a66f
	ld a,(0e526h)		;a670
	and a			;a673
	ret z			;a674
	xor a			;a675
	ld (0e526h),a		;a676
	inc hl			;a679
	ld a,(0e505h)		;a67a   ; lee la y del personaje
	sub (hl)			;a67d
	sub 005h		;a67e
	cp 01ch		;a680
	ret nc			;a682
	inc hl			;a683
	ld a,(0e503h)		;a684   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a687
	ld a,(0e507h)		;a688   ; lee la x del personaje
	jr z,L_A695		;a68b
	sub (hl)			;a68d
	sub 028h		;a68e
	cp 00eh		;a690
	ret nc			;a692
	jr L_A69D		;a693
L_A695:
	sub (hl)			;a695
	neg		;a696
	sub 008h		;a698
	cp 00eh		;a69a
	ret nc			;a69c
L_A69D:
	push hl			;a69d
	ld a,01eh		;a69e
	call 04059h		;a6a0   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	pop hl			;a6a3
	inc hl			;a6a4
	dec (hl)			;a6a5
	ret nz			;a6a6
	ld hl,(0e60eh)		;a6a7   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	set 2,(hl)		;a6aa
	xor a			;a6ac
	ld (0ea20h),a		;a6ad
	ld a,02eh		;a6b0
	jp 04059h		;a6b2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A6B5:
	ld hl,0e0b0h		;a6b5
	ld b,00fh		;a6b8
L_A6BA:
	ld a,(hl)			;a6ba
	cp 002h		;a6bb
	ld (0f000h),hl		;a6bd
	call z,L_A6CB		;a6c0
	ld hl,(0f000h)		;a6c3
	inc l			;a6c6
	inc l			;a6c7
	djnz L_A6BA		;a6c8
	ret			;a6ca
L_A6CB:
	ld a,(0e604h)		;a6cb   ; lee el contador de cuadros de partida
	and 01fh		;a6ce
	ret nz			;a6d0
	inc l			;a6d1
	dec (hl)			;a6d2
	ret nz			;a6d3
	ld a,00fh		;a6d4
	sub b			;a6d6
	ld hl,0a6ebh		;a6d7
	call 04053h		;a6da   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld hl,(0e041h)		;a6dd   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	xor a			;a6e0
	sbc hl,de		;a6e1
	jr nz,L_A6E6		;a6e3
	inc a			;a6e5
L_A6E6:
	ld hl,(0f000h)		;a6e6
	ld (hl),a			;a6e9
	ret			;a6ea

; ----------------------------------------------------------------------
; DATOS salas_con_figura: 13 parejas [mapa][sala], todas del castillo (salas
;   13, 19, 21, 60, 70, 73, 86, 102, 106, 116, 124, 133 y 136), que p09:A6D7 y
;   p09:A764 comparan con 0xE041/0xE042 para cada uno de los 15 huecos de
;   0xE0B0 (el hueco n mira la entrada n; los dos ultimos leerian ya las
;   fichas de 0xA705, que no coinciden con ninguna sala)
;   0xa6eb..0xa705  (26 bytes)
DATA_salas_con_figura:
	defb 001h,00dh	; a6eb
	defb 001h,013h	; a6ed
	defb 001h,015h	; a6ef
	defb 001h,03ch	; a6f1
	defb 001h,046h	; a6f3
	defb 001h,049h	; a6f5
	defb 001h,056h	; a6f7
	defb 001h,066h	; a6f9
	defb 001h,06ah	; a6fb
	defb 001h,074h	; a6fd
	defb 001h,07ch	; a6ff
	defb 001h,085h	; a701
	defb 001h,088h	; a703

; ----------------------------------------------------------------------
; DATOS fichas_de_la_figura: 13 fichas de 5 bytes, una por sala de 0xA6EB, que
;   p09:A783 lee en 0xA700 + 5 x n: las 4 primeras van a 0xEC01-0xEC04 (de
;   0xEC01/0xEC02 sale la posicion en la tabla de nombres, p09:A79C) y la
;   quinta a 0xEC0F
;   0xa705..0xa746  (65 bytes)
DATA_fichas_de_la_figura:
	defb 040h,0b0h,007h,040h,003h,080h,0a0h,007h,040h,001h,060h,080h,003h,020h,003h,040h	; a705  @..@....@.`.. .@
	defb 050h,007h,040h,002h,080h,030h,007h,040h,002h,040h,030h,00fh,080h,002h,080h,060h	; a715  P.@..0.@.@0....`
	defb 007h,040h,002h,060h,0e0h,007h,040h,001h,060h,070h,007h,040h,003h,060h,020h,007h	; a725  .@.`..@.`p.@.` .
	defb 040h,002h,040h,0a0h,00bh,060h,003h,080h,0b0h,007h,040h,003h,060h,030h,00bh,060h	; a735  @.@..`....@.`0.`
	defb 002h	; a745

; ======================================================================
; CODIGO 0xa746..0xa7be  (120 bytes)
; ======================================================================


L_A746:
	ld hl,0e0b0h		;a746
	ld b,00fh		;a749
L_A74B:
	ld (0f000h),hl		;a74b
	ld a,(hl)			;a74e
	cp 001h		;a74f
	jr nz,L_A755		;a751
	xor a			;a753
	ld (hl),a			;a754
L_A755:
	or a			;a755
	call z,L_A761		;a756
	ld hl,(0f000h)		;a759
	inc l			;a75c
	inc l			;a75d
	djnz L_A74B		;a75e
	ret			;a760
L_A761:
	ld a,00fh		;a761
	sub b			;a763
	ld hl,0a6ebh		;a764
	call 04053h		;a767   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld hl,(0e041h)		;a76a   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	xor a			;a76d
	sbc hl,de		;a76e
	ret nz			;a770
	ld a,b			;a771
	exx			;a772
	ld b,a			;a773
	ld a,010h		;a774
	sub b			;a776
	ld de,0ec00h		;a777
	ld (de),a			;a77a
	inc e			;a77b
	ld c,a			;a77c
	add a,a			;a77d
	add a,a			;a77e
	add a,c			;a77f
	ld c,a			;a780
	ld b,000h		;a781
	ld hl,0a700h		;a783
	add hl,bc			;a786
	ld bc,00004h		;a787
	ldir		;a78a
	ld a,(hl)			;a78c
	ld (0ec0fh),a		;a78d
	inc e			;a790
	inc e			;a791
	xor a			;a792
	ld (de),a			;a793
	ld a,(0ec01h)		;a794
	ld l,a			;a797
	ld a,(0ec02h)		;a798
	ld h,a			;a79b
	call 04056h		;a79c   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (0ec05h),hl		;a79f
	exx			;a7a2
	ret			;a7a3
L_A7A4:
	ld a,(0ec07h)		;a7a4
	or a			;a7a7
	ret z			;a7a8
	ld a,(0ec00h)		;a7a9
	add a,a			;a7ac
	ld c,a			;a7ad
	ld b,000h		;a7ae
	ld hl,0e0aeh		;a7b0
	add hl,bc			;a7b3
	ld (hl),002h		;a7b4
	inc l			;a7b6
	ld (hl),03ch		;a7b7
	xor a			;a7b9
	ld (0ec00h),a		;a7ba
	ret			;a7bd

; ----------------------------------------------------------------------
; DATOS tabla_figuras_9d1d: 11 punteros, uno por mapa (0xE041) desde el 1, a
;   las figuras que p08:9D2A pone en cada sala: [tipo][y:3 bits, x:5 bits] y
;   un 0 al final (p08:9D1D); la tabla se lee desde 0xA7BC, pero el mapa 0 no
;   existe; lo leen p08:9D1D (22 bytes)
;   0xa7be..0xa7d4  (22 bytes)
DATA_tabla_figuras_9d1d:
	defb 0d4h,0a7h	; a7be
	defb 0a7h,0a8h	; a7c0
	defb 0c0h,0a8h	; a7c2
	defb 0e3h,0a8h	; a7c4
	defb 005h,0a9h	; a7c6
	defb 020h,0a9h	; a7c8
	defb 03eh,0a9h	; a7ca
	defb 067h,0a9h	; a7cc
	defb 097h,0a9h	; a7ce
	defb 0b4h,0a9h	; a7d0
	defb 0ebh,0a9h	; a7d2

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_1: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 1: una
;   lista por sala (147); lo leen p08:9D1D (211 bytes)
;   0xa7d4..0xa8a7  (211 bytes)
DATA_figuras_9d1d_mapa_1:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a7d4  ........
	defb 000h,000h,001h,034h,000h,000h,000h,000h	; a7dc  ...4....
	defb 005h,08bh,000h,001h,074h,000h,005h,054h	; a7e4  ....t..T
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a7ec  ........
	defb 000h,000h,000h,000h,005h,048h,000h,000h	; a7f4  .....H..
	defb 000h,005h,028h,000h,000h,000h,000h,000h	; a7fc  ..(.....
	defb 001h,043h,000h,000h,000h,001h,073h,000h	; a804  .C....s.
	defb 001h,05ch,005h,04bh,000h,001h,091h,000h	; a80c  .\.K....
	defb 000h,005h,06dh,000h,005h,08dh,000h,000h	; a814  ..m.....
	defb 000h,005h,054h,000h,000h,000h,000h,000h	; a81c  ..T.....
	defb 000h,000h,000h,000h,000h,000h,001h,030h	; a824  .......0
	defb 000h,000h,005h,06eh,000h,000h,000h,001h	; a82c  ...n....
	defb 0ach,000h,000h,000h,005h,073h,000h,000h	; a834  .....s..
	defb 000h,005h,094h,000h,000h,000h,000h,000h	; a83c  ........
	defb 000h,001h,030h,005h,093h,000h,001h,092h	; a844  ..0.....
	defb 000h,000h,005h,094h,000h,000h,000h,000h	; a84c  ........
	defb 000h,000h,000h,000h,000h,000h,000h,005h	; a854  ........
	defb 058h,000h,000h,001h,0a4h,000h,000h,000h	; a85c  X.......
	defb 000h,000h,037h,070h,000h,000h,001h,03ah	; a864  ..7p...:
	defb 005h,0b8h,000h,000h,000h,000h,000h,000h	; a86c  ........
	defb 000h,000h,000h,000h,001h,058h,000h,000h	; a874  .....X..
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a87c  ........
	defb 000h,000h,001h,093h,000h,000h,001h,090h	; a884  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a88c  ........
	defb 000h,005h,074h,000h,000h,000h,000h,000h	; a894  ..t.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a89c  ........
	defb 000h,000h,000h	; a8a4

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_2: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 2: una
;   lista por sala (15); lo leen p08:9D1D (25 bytes)
;   0xa8a7..0xa8c0  (25 bytes)
DATA_figuras_9d1d_mapa_2:
	defb 000h,000h,000h,002h,0bch,000h,000h,000h	; a8a7  ........
	defb 004h,04dh,004h,090h,000h,000h,002h,0afh	; a8af  .M......
	defb 000h,000h,000h,000h,000h,002h,0afh,000h	; a8b7  ........
	defb 000h	; a8bf

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_3: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 3: una
;   lista por sala (15); lo leen p08:9D1D (35 bytes)
;   0xa8c0..0xa8e3  (35 bytes)
DATA_figuras_9d1d_mapa_3:
	defb 000h,013h,03ch,000h,000h,007h,02ch,000h	; a8c0  ..<...,.
	defb 003h,05bh,000h,003h,04fh,000h,003h,058h	; a8c8  .[..O..X
	defb 000h,002h,074h,002h,0ach,000h,000h,000h	; a8d0  ..t.....
	defb 000h,002h,038h,004h,078h,004h,0b8h,000h	; a8d8  ..8.x...
	defb 000h,000h,000h	; a8e0

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_4: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 4: una
;   lista por sala (16); lo leen p08:9D1D (34 bytes)
;   0xa8e3..0xa905  (34 bytes)
DATA_figuras_9d1d_mapa_4:
	defb 000h,000h,002h,030h,002h,050h,000h,003h	; a8e3  ...0.P..
	defb 0b8h,000h,000h,000h,000h,000h,003h,07ch	; a8eb  .......|
	defb 000h,000h,000h,002h,0abh,000h,000h,003h	; a8f3  ........
	defb 049h,004h,036h,004h,06fh,004h,0aah,000h	; a8fb  I.6.o...
	defb 000h,000h	; a903

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_5: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 5: una
;   lista por sala (17); lo leen p08:9D1D (27 bytes)
;   0xa905..0xa920  (27 bytes)
DATA_figuras_9d1d_mapa_5:
	defb 004h,0b0h,000h,000h,002h,030h,000h,002h	; a905  .....0..
	defb 070h,000h,002h,0a8h,000h,000h,000h,000h	; a90d  p.......
	defb 000h,000h,000h,000h,000h,000h,000h,017h	; a915  ........
	defb 094h,000h,000h	; a91d

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_6: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 6: una
;   lista por sala (18); lo leen p08:9D1D (30 bytes)
;   0xa920..0xa93e  (30 bytes)
DATA_figuras_9d1d_mapa_6:
	defb 000h,000h,000h,000h,000h,002h,08fh,000h	; a920  ........
	defb 003h,027h,027h,07ch,000h,000h,002h,048h	; a928  .''|...H
	defb 000h,000h,006h,000h,000h,000h,000h,002h	; a930  ........
	defb 073h,000h,000h,000h,000h,000h	; a938

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_7: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 7: una
;   lista por sala (19); lo leen p08:9D1D (41 bytes)
;   0xa93e..0xa967  (41 bytes)
DATA_figuras_9d1d_mapa_7:
	defb 000h,003h,03bh,002h,07bh,002h,09bh,000h	; a93e  ....{...
	defb 000h,000h,000h,027h,0a4h,000h,000h,000h	; a946  ...'....
	defb 000h,004h,06ah,004h,084h,004h,0aah,000h	; a94e  ..j.....
	defb 002h,072h,002h,0b8h,000h,000h,000h,002h	; a956  .r......
	defb 043h,000h,000h,002h,068h,000h,000h,000h	; a95e  C...h...
	defb 000h	; a966

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_8: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 8: una
;   lista por sala (20); lo leen p08:9D1D (48 bytes)
;   0xa967..0xa997  (48 bytes)
DATA_figuras_9d1d_mapa_8:
	defb 000h,003h,02fh,000h,000h,000h,000h,004h	; a967  ../.....
	defb 057h,004h,065h,004h,090h,004h,0b3h,000h	; a96f  W.e.....
	defb 002h,06fh,000h,013h,065h,000h,000h,000h	; a977  .o..e...
	defb 000h,004h,068h,004h,074h,004h,08eh,004h	; a97f  ..h.t...
	defb 0b7h,000h,002h,0bch,000h,003h,04bh,000h	; a987  ......K.
	defb 000h,000h,000h,002h,028h,000h,000h,000h	; a98f  ....(...

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_9: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 9: una
;   lista por sala (21); lo leen p08:9D1D (29 bytes)
;   0xa997..0xa9b4  (29 bytes)
DATA_figuras_9d1d_mapa_9:
	defb 000h,000h,000h,004h,0afh,000h,003h,0a3h	; a997  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a99f  ........
	defb 000h,000h,000h,000h,000h,000h,002h,04fh	; a9a7  .......O
	defb 000h,004h,057h,000h,000h	; a9af

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_10: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 10: una
;   lista por sala (27); lo leen p08:9D1D (55 bytes)
;   0xa9b4..0xa9eb  (55 bytes)
DATA_figuras_9d1d_mapa_10:
	defb 002h,0ach,000h,000h,000h,000h,000h,000h	; a9b4  ........
	defb 002h,091h,002h,0b1h,000h,000h,000h,000h	; a9bc  ........
	defb 013h,068h,000h,004h,06bh,000h,000h,002h	; a9c4  .h..k...
	defb 066h,002h,0b4h,000h,002h,028h,000h,003h	; a9cc  f....(..
	defb 0a8h,000h,004h,0a7h,000h,000h,000h,000h	; a9d4  ........
	defb 002h,070h,000h,000h,000h,000h,000h,002h	; a9dc  .p......
	defb 050h,002h,070h,007h,020h,000h,000h	; a9e4

; ----------------------------------------------------------------------
; DATOS figuras_9d1d_mapa_11: las figuras que p08:9D2A pone en cada sala:
;   [tipo][y:3 bits, x:5 bits] y un 0 al final (p08:9D1D) del mapa 11: una
;   lista por sala (6); se solapan 2 bloques (0xA9EB-0xA9F1, 0xA9EF-0xAA07);
;   lo leen p00:5227, p08:9D1D (28 bytes)
;   0xa9eb..0xaa07  (28 bytes)
DATA_figuras_9d1d_mapa_11:
	defb 000h,000h,000h,000h,000h,000h,003h,0aah	; a9eb  ........
	defb 04fh,0ach,08bh,0ach,0c7h,0ach,007h,0adh	; a9f3  O.......
	defb 04bh,0adh,093h,0adh,0dfh,0adh,02fh,0aeh	; a9fb  K...../.
	defb 083h,0aeh,0efh,0aeh	; aa03

; ----------------------------------------------------------------------
; DATOS vecinas: las vecinas de cada sala,
;   [arriba][abajo][izquierda][derecha], 0xFF sin salida; las de la sala n del
;   mapa m en la palabra m de 0xA9EF + 4 x n, y la entrada 0 de cada mapa es
;   la ultima sala del anterior (p00:5232 las copia a 0xE648); lo leen
;   p00:5239 (1284 bytes)
;   0xaa07..0xaf0b  (1284 bytes)
DATA_vecinas:
	defb 05dh,077h,069h,06bh	; aa07
	defb 0ffh,007h,0ffh,003h	; aa0b
	defb 06ch,0ffh,002h,004h	; aa0f
	defb 0ffh,008h,003h,0ffh	; aa13
	defb 0ffh,00ch,0ffh,0ffh	; aa17
	defb 0ffh,0ffh,0ffh,007h	; aa1b
	defb 002h,00eh,006h,0ffh	; aa1f
	defb 004h,010h,0ffh,009h	; aa23
	defb 0ffh,0ffh,008h,0ffh	; aa27
	defb 0ffh,012h,0ffh,0ffh	; aa2b
	defb 0ffh,015h,0ffh,00ch	; aa2f
	defb 005h,0ffh,00bh,00dh	; aa33
	defb 0ffh,016h,00ch,0ffh	; aa37
	defb 007h,018h,0ffh,00fh	; aa3b
	defb 0ffh,019h,00eh,010h	; aa3f
	defb 008h,01ah,00fh,0ffh	; aa43
	defb 0ffh,01ch,0ffh,012h	; aa47
	defb 00ah,0ffh,011h,013h	; aa4b
	defb 0ffh,01dh,012h,0ffh	; aa4f
	defb 0ffh,0ffh,0ffh,015h	; aa53
	defb 00bh,01fh,014h,0ffh	; aa57
	defb 00dh,021h,0ffh,017h	; aa5b
	defb 0ffh,0ffh,016h,0ffh	; aa5f
	defb 00eh,022h,0ffh,019h	; aa63
	defb 00fh,0ffh,018h,01ah	; aa67
	defb 010h,023h,019h,0ffh	; aa6b
	defb 0ffh,0ffh,0ffh,01ch	; aa6f
	defb 011h,024h,01bh,0ffh	; aa73
	defb 013h,026h,0ffh,01eh	; aa77
	defb 0ffh,0ffh,01dh,0ffh	; aa7b
	defb 015h,027h,0ffh,020h	; aa7f
	defb 0ffh,028h,01fh,021h	; aa83
	defb 016h,029h,020h,0ffh	; aa87
	defb 018h,02ch,0ffh,0ffh	; aa8b
	defb 01ah,02eh,0ffh,0ffh	; aa8f
	defb 01ch,031h,0ffh,025h	; aa93
	defb 0ffh,032h,024h,026h	; aa97
	defb 01dh,033h,025h,0ffh	; aa9b
	defb 01fh,0ffh,0ffh,028h	; aa9f
	defb 020h,0ffh,027h,029h	; aaa3
	defb 021h,034h,028h,02ah	; aaa7
	defb 0ffh,0ffh,029h,02bh	; aaab
	defb 0ffh,035h,02ah,02ch	; aaaf
	defb 022h,0ffh,02bh,02dh	; aab3
	defb 0ffh,036h,02ch,02eh	; aab7
	defb 023h,0ffh,02dh,02fh	; aabb
	defb 0ffh,037h,02eh,030h	; aabf
	defb 0ffh,0ffh,02fh,031h	; aac3
	defb 024h,038h,030h,032h	; aac7
	defb 025h,0ffh,031h,033h	; aacb
	defb 026h,0ffh,032h,0ffh	; aacf
	defb 029h,03bh,0ffh,0ffh	; aad3
	defb 02bh,0ffh,0ffh,0ffh	; aad7
	defb 02dh,0ffh,0ffh,0ffh	; aadb
	defb 02fh,0ffh,0ffh,0ffh	; aadf
	defb 031h,040h,0ffh,0ffh	; aae3
	defb 0ffh,043h,0ffh,0ffh	; aae7
	defb 0ffh,045h,0ffh,03bh	; aaeb
	defb 034h,046h,03ah,03ch	; aaef
	defb 0ffh,047h,03bh,0ffh	; aaf3
	defb 0ffh,049h,0ffh,0ffh	; aaf7
	defb 0ffh,04bh,0ffh,0ffh	; aafb
	defb 0ffh,04dh,0ffh,040h	; aaff
	defb 038h,04eh,03fh,041h	; ab03
	defb 0ffh,04fh,040h,0ffh	; ab07
	defb 0ffh,051h,0ffh,0ffh	; ab0b
	defb 039h,0ffh,0ffh,044h	; ab0f
	defb 0ffh,052h,043h,045h	; ab13
	defb 03ah,0ffh,044h,046h	; ab17
	defb 03bh,053h,045h,047h	; ab1b
	defb 03ch,0ffh,046h,048h	; ab1f
	defb 0ffh,054h,047h,049h	; ab23
	defb 03dh,0ffh,048h,04ah	; ab27
	defb 0ffh,055h,049h,04bh	; ab2b
	defb 03eh,0ffh,04ah,04ch	; ab2f
	defb 0ffh,056h,04bh,04dh	; ab33
	defb 03fh,0ffh,04ch,04eh	; ab37
	defb 040h,057h,04dh,04fh	; ab3b
	defb 041h,0ffh,04eh,050h	; ab3f
	defb 0ffh,058h,04fh,051h	; ab43
	defb 042h,0ffh,050h,0ffh	; ab47
	defb 044h,059h,0ffh,0ffh	; ab4b
	defb 046h,05bh,0ffh,0ffh	; ab4f
	defb 048h,05dh,0ffh,0ffh	; ab53
	defb 04ah,05fh,0ffh,0ffh	; ab57
	defb 04ch,061h,0ffh,0ffh	; ab5b
	defb 04eh,063h,0ffh,0ffh	; ab5f
	defb 050h,065h,0ffh,0ffh	; ab63
	defb 052h,067h,0ffh,05ah	; ab67
	defb 0ffh,0ffh,059h,05bh	; ab6b
	defb 053h,068h,05ah,05ch	; ab6f
	defb 0ffh,069h,05bh,05dh	; ab73
	defb 054h,001h,05ch,0ffh	; ab77
	defb 0ffh,0ffh,0ffh,0ffh	; ab7b
	defb 055h,06ah,0ffh,060h	; ab7f
	defb 0ffh,06dh,05fh,061h	; ab83
	defb 056h,06eh,060h,062h	; ab87
	defb 0ffh,06fh,061h,063h	; ab8b
	defb 057h,070h,062h,064h	; ab8f
	defb 0ffh,0ffh,063h,065h	; ab93
	defb 058h,071h,064h,0ffh	; ab97
	defb 0ffh,073h,0ffh,067h	; ab9b
	defb 059h,074h,066h,0ffh	; ab9f
	defb 05bh,0ffh,0ffh,069h	; aba3
	defb 05ch,076h,068h,001h	; aba7
	defb 05fh,079h,06bh,06dh	; abab
	defb 0ffh,078h,001h,06ah	; abaf
	defb 0ffh,003h,0ffh,0ffh	; abb3
	defb 060h,07ah,06ah,06eh	; abb7
	defb 061h,07bh,06dh,06fh	; abbb
	defb 062h,07ch,06eh,070h	; abbf
	defb 063h,0ffh,06fh,0ffh	; abc3
	defb 065h,07eh,0ffh,072h	; abc7
	defb 0ffh,07fh,071h,0ffh	; abcb
	defb 066h,080h,0ffh,074h	; abcf
	defb 067h,081h,073h,075h	; abd3
	defb 0ffh,082h,074h,0ffh	; abd7
	defb 069h,0ffh,0ffh,077h	; abdb
	defb 001h,0ffh,076h,078h	; abdf
	defb 06bh,083h,077h,079h	; abe3
	defb 06ah,084h,078h,07ah	; abe7
	defb 06dh,085h,079h,07bh	; abeb
	defb 06eh,0ffh,07ah,07ch	; abef
	defb 06fh,0ffh,07bh,0ffh	; abf3
	defb 0ffh,086h,0ffh,07eh	; abf7
	defb 071h,087h,07dh,07fh	; abfb
	defb 072h,088h,07eh,0ffh	; abff
	defb 073h,089h,0ffh,081h	; ac03
	defb 074h,08ah,080h,082h	; ac07
	defb 075h,08bh,081h,0ffh	; ac0b
	defb 078h,08dh,0ffh,084h	; ac0f
	defb 079h,08eh,083h,085h	; ac13
	defb 07ah,08fh,084h,0ffh	; ac17
	defb 07dh,091h,0ffh,087h	; ac1b
	defb 07eh,092h,086h,088h	; ac1f
	defb 07fh,093h,087h,0ffh	; ac23
	defb 080h,0ffh,0ffh,08ah	; ac27
	defb 081h,0ffh,089h,08bh	; ac2b
	defb 082h,0ffh,08ah,08ch	; ac2f
	defb 0ffh,0ffh,08bh,0ffh	; ac33
	defb 083h,0ffh,0ffh,08eh	; ac37
	defb 084h,0ffh,08dh,08fh	; ac3b
	defb 085h,0ffh,08eh,0ffh	; ac3f
	defb 0ffh,0ffh,0ffh,091h	; ac43
	defb 086h,0ffh,090h,092h	; ac47
	defb 087h,0ffh,091h,093h	; ac4b
	defb 088h,0ffh,092h,0ffh	; ac4f
	defb 0feh,0ffh,002h,0ffh	; ac53
	defb 0ffh,003h,0ffh,001h	; ac57
	defb 002h,004h,0ffh,0ffh	; ac5b
	defb 003h,006h,0ffh,005h	; ac5f
	defb 0ffh,0ffh,004h,0ffh	; ac63
	defb 004h,007h,0ffh,0ffh	; ac67
	defb 006h,008h,0ffh,0ffh	; ac6b
	defb 007h,0ffh,009h,00ah	; ac6f
	defb 0ffh,00fh,0ffh,008h	; ac73
	defb 0ffh,00bh,008h,0ffh	; ac77
	defb 00ah,00ch,0ffh,0ffh	; ac7b
	defb 00bh,0ffh,00dh,0ffh	; ac7f
	defb 0ffh,0ffh,00eh,00ch	; ac83
	defb 00fh,0ffh,0ffh,00dh	; ac87
	defb 009h,00eh,0ffh,0ffh	; ac8b
	defb 003h,0fdh,002h,0ffh	; ac8f
	defb 004h,0ffh,0ffh,001h	; ac93
	defb 005h,001h,004h,0ffh	; ac97
	defb 0ffh,002h,0ffh,003h	; ac9b
	defb 0ffh,003h,0ffh,006h	; ac9f
	defb 0ffh,0ffh,005h,007h	; aca3
	defb 00fh,0ffh,006h,008h	; aca7
	defb 00ah,0ffh,007h,0ffh	; acab
	defb 0ffh,0ffh,00dh,0ffh	; acaf
	defb 0ffh,008h,00fh,00bh	; acb3
	defb 0ffh,0ffh,00ah,00ch	; acb7
	defb 0ffh,0ffh,00bh,00dh	; acbb
	defb 00eh,0ffh,00ch,009h	; acbf
	defb 0ffh,00dh,0ffh,0ffh	; acc3
	defb 0ffh,007h,0ffh,00ah	; acc7
	defb 002h,0fch,0ffh,0ffh	; accb
	defb 007h,001h,0ffh,0ffh	; accf
	defb 0ffh,0ffh,004h,007h	; acd3
	defb 004h,0ffh,0ffh,003h	; acd7
	defb 0ffh,0ffh,007h,006h	; acdb
	defb 0ffh,0ffh,005h,0ffh	; acdf
	defb 008h,002h,003h,005h	; ace3
	defb 009h,007h,0ffh,0ffh	; ace7
	defb 00ah,008h,0ffh,00ch	; aceb
	defb 00bh,009h,0ffh,010h	; acef
	defb 0ffh,00ah,0ffh,00eh	; acf3
	defb 010h,0ffh,009h,0ffh	; acf7
	defb 0ffh,00fh,0ffh,0ffh	; acfb
	defb 00fh,010h,00bh,0ffh	; acff
	defb 00dh,00eh,0ffh,0ffh	; ad03
	defb 00eh,00ch,00ah,0ffh	; ad07
	defb 0ffh,0ffh,0fbh,002h	; ad0b
	defb 003h,0ffh,001h,006h	; ad0f
	defb 0ffh,002h,0ffh,004h	; ad13
	defb 00ch,006h,003h,005h	; ad17
	defb 007h,0ffh,004h,010h	; ad1b
	defb 004h,0ffh,002h,0ffh	; ad1f
	defb 008h,005h,00ch,00fh	; ad23
	defb 009h,007h,00bh,011h	; ad27
	defb 0ffh,008h,00ah,00dh	; ad2b
	defb 0ffh,00bh,0ffh,009h	; ad2f
	defb 00ah,00ch,0ffh,008h	; ad33
	defb 00bh,004h,0ffh,007h	; ad37
	defb 0ffh,011h,009h,0ffh	; ad3b
	defb 010h,0ffh,0ffh,0ffh	; ad3f
	defb 011h,010h,007h,0ffh	; ad43
	defb 00fh,00eh,005h,0ffh	; ad47
	defb 00dh,00fh,008h,0ffh	; ad4b
	defb 0ffh,002h,0ffh,0fah	; ad4f
	defb 001h,0ffh,003h,0ffh	; ad53
	defb 0ffh,004h,0ffh,002h	; ad57
	defb 003h,0ffh,005h,0ffh	; ad5b
	defb 0ffh,006h,0ffh,004h	; ad5f
	defb 005h,007h,0ffh,0ffh	; ad63
	defb 006h,0ffh,008h,009h	; ad67
	defb 0ffh,0ffh,0ffh,007h	; ad6b
	defb 0ffh,0ffh,007h,00ah	; ad6f
	defb 0ffh,0ffh,009h,00bh	; ad73
	defb 0ffh,0ffh,00ah,00ch	; ad77
	defb 0ffh,0ffh,00bh,00dh	; ad7b
	defb 00eh,0ffh,00ch,011h	; ad7f
	defb 00fh,00dh,0ffh,0ffh	; ad83
	defb 0ffh,00eh,010h,0ffh	; ad87
	defb 012h,0ffh,0ffh,00fh	; ad8b
	defb 0ffh,0ffh,00dh,0ffh	; ad8f
	defb 0ffh,010h,0ffh,0ffh	; ad93
	defb 0f9h,002h,0ffh,0ffh	; ad97
	defb 001h,005h,003h,004h	; ad9b
	defb 0ffh,0ffh,0ffh,002h	; ad9f
	defb 0ffh,0ffh,002h,0ffh	; ada3
	defb 002h,006h,0ffh,0ffh	; ada7
	defb 005h,007h,0ffh,0ffh	; adab
	defb 006h,008h,0ffh,0ffh	; adaf
	defb 007h,00dh,00eh,009h	; adb3
	defb 0ffh,0ffh,008h,00ah	; adb7
	defb 00bh,0ffh,009h,0ffh	; adbb
	defb 013h,00ah,0ffh,00ch	; adbf
	defb 0ffh,0ffh,00bh,0ffh	; adc3
	defb 008h,0ffh,0ffh,0ffh	; adc7
	defb 0ffh,0ffh,00fh,008h	; adcb
	defb 010h,0ffh,0ffh,00eh	; adcf
	defb 012h,00fh,011h,0ffh	; add3
	defb 0ffh,0ffh,0ffh,010h	; add7
	defb 0ffh,010h,0ffh,0ffh	; addb
	defb 0ffh,00bh,0ffh,0ffh	; addf
	defb 0f8h,002h,0ffh,0ffh	; ade3
	defb 001h,005h,003h,006h	; ade7
	defb 0ffh,004h,0ffh,002h	; adeb
	defb 003h,00dh,00eh,005h	; adef
	defb 002h,00ch,004h,007h	; adf3
	defb 0ffh,007h,002h,0ffh	; adf7
	defb 006h,00bh,005h,008h	; adfb
	defb 0ffh,0ffh,007h,009h	; adff
	defb 014h,0ffh,008h,0ffh	; ae03
	defb 012h,0ffh,0ffh,0ffh	; ae07
	defb 007h,013h,00ch,0ffh	; ae0b
	defb 005h,012h,00dh,00bh	; ae0f
	defb 004h,011h,0ffh,00ch	; ae13
	defb 0ffh,0ffh,00fh,004h	; ae17
	defb 010h,0ffh,0ffh,00eh	; ae1b
	defb 0ffh,00fh,0ffh,0ffh	; ae1f
	defb 00dh,0ffh,0ffh,012h	; ae23
	defb 00ch,00ah,011h,013h	; ae27
	defb 00bh,0ffh,012h,0ffh	; ae2b
	defb 0ffh,009h,0ffh,0ffh	; ae2f
	defb 0f7h,002h,0ffh,0ffh	; ae33
	defb 001h,003h,0ffh,0ffh	; ae37
	defb 002h,009h,004h,00ah	; ae3b
	defb 0ffh,0ffh,005h,003h	; ae3f
	defb 015h,008h,006h,004h	; ae43
	defb 0ffh,0ffh,0ffh,005h	; ae47
	defb 0ffh,0ffh,014h,0ffh	; ae4b
	defb 005h,010h,0ffh,0ffh	; ae4f
	defb 003h,012h,0ffh,0ffh	; ae53
	defb 0ffh,0ffh,003h,00bh	; ae57
	defb 00dh,00eh,00ah,00ch	; ae5b
	defb 0ffh,0ffh,00bh,0ffh	; ae5f
	defb 0ffh,00bh,0ffh,0ffh	; ae63
	defb 00bh,014h,0ffh,0ffh	; ae67
	defb 0ffh,0ffh,0ffh,010h	; ae6b
	defb 008h,0ffh,00fh,011h	; ae6f
	defb 0ffh,0ffh,010h,012h	; ae73
	defb 009h,0ffh,011h,013h	; ae77
	defb 0ffh,0ffh,012h,014h	; ae7b
	defb 00eh,0ffh,013h,007h	; ae7f
	defb 0ffh,005h,0ffh,0ffh	; ae83
	defb 0ffh,0ffh,0f6h,002h	; ae87
	defb 018h,0ffh,001h,003h	; ae8b
	defb 0ffh,0ffh,002h,004h	; ae8f
	defb 006h,0ffh,003h,005h	; ae93
	defb 0ffh,0ffh,004h,0ffh	; ae97
	defb 007h,004h,0ffh,0ffh	; ae9b
	defb 008h,006h,0ffh,00bh	; ae9f
	defb 009h,007h,0ffh,0ffh	; aea3
	defb 00ah,008h,0ffh,0ffh	; aea7
	defb 011h,009h,0ffh,010h	; aeab
	defb 0ffh,0ffh,007h,00ch	; aeaf
	defb 00dh,0ffh,00bh,0ffh	; aeb3
	defb 00eh,00ch,0ffh,0ffh	; aeb7
	defb 00fh,00dh,0ffh,0ffh	; aebb
	defb 0ffh,00eh,010h,0ffh	; aebf
	defb 0ffh,0ffh,00ah,00fh	; aec3
	defb 0ffh,00ah,012h,0ffh	; aec7
	defb 01bh,0ffh,013h,011h	; aecb
	defb 01ah,014h,0ffh,012h	; aecf
	defb 013h,015h,0ffh,0ffh	; aed3
	defb 014h,016h,0ffh,0ffh	; aed7
	defb 015h,017h,0ffh,0ffh	; aedb
	defb 016h,018h,0ffh,0ffh	; aedf
	defb 017h,002h,0ffh,0ffh	; aee3
	defb 0ffh,0ffh,0ffh,01ah	; aee7
	defb 0ffh,013h,019h,01bh	; aeeb
	defb 0ffh,012h,01ah,0ffh	; aeef
	defb 0ffh,0ffh,0f5h,002h	; aef3
	defb 0ffh,0ffh,001h,003h	; aef7
	defb 0ffh,0ffh,002h,004h	; aefb
	defb 0ffh,0ffh,003h,005h	; aeff
	defb 0ffh,0ffh,004h,0ffh	; af03
	defb 0ffh,0ffh,0ffh,0ffh	; af07

; ----------------------------------------------------------------------
; DATOS estado_de_las_salas: 11 punteros a la RAM, uno por mapa (p00:5246,
;   p01:6940): el byte de estado de cada sala (el castillo en 0xE200, sus 147
;   salas, el mapa 2 en 0xE293...); la palabra 0 de la tabla son los 0xFF de
;   la ultima vecina; lo leen p00:5249 (22 bytes)
;   0xaf0b..0xaf21  (22 bytes)
DATA_estado_de_las_salas:
	defb 000h,0e2h	; af0b
	defb 093h,0e2h	; af0d
	defb 0a2h,0e2h	; af0f
	defb 0b1h,0e2h	; af11
	defb 0c1h,0e2h	; af13
	defb 0d2h,0e2h	; af15
	defb 0e4h,0e2h	; af17
	defb 0f8h,0e2h	; af19
	defb 00ch,0e3h	; af1b
	defb 021h,0e3h	; af1d
	defb 03ch,0e3h	; af1f

; ----------------------------------------------------------------------
; DATOS bytes_de_estado_por_mapa: cuantos bytes de estado tiene cada mapa 1-11
;   (147, 15, 15, 16, 17, 18, 20, 20, 21, 27 y 3), que p00:4666 lee en 0xAF20
;   + mapa para borrarlos (el byte del mapa 0 es el ultimo de la tabla
;   0xAF09); el mapa 7 tiene 20 aunque tenga 19 salas
;   0xaf21..0xaf2c  (11 bytes)
DATA_bytes_de_estado_por_mapa:
	defb 093h,00fh,00fh,010h,011h,012h,014h,014h,015h,01bh,003h	; af21  ...........

; ----------------------------------------------------------------------
; DATOS tabla_de_planos: punteros al plano de cada mundo (mapas 2-10) que
;   p01:662B lee en 0xAF2A + 2 x mapa (el mapa 1 sale antes, p01:6632); la
;   entrada de los mapas 0 y 1 son los bytes de 0xAF2A-0xAF2D (las cuentas de
;   los mapas 10 y 11 y esta tabla)
;   0xaf2c..0xaf40  (20 bytes)
DATA_tabla_de_planos:
	defb 040h,0afh	; af2c
	defb 053h,0afh	; af2e
	defb 072h,0afh	; af30
	defb 08fh,0afh	; af32
	defb 0a2h,0afh	; af34
	defb 0beh,0afh	; af36
	defb 0deh,0afh	; af38
	defb 0f7h,0afh	; af3a
	defb 010h,0b0h	; af3c
	defb 032h,0b0h	; af3e

; ----------------------------------------------------------------------
; DATOS plano_sin_puntero: un plano mas con el mismo formato ([destino
;   0xEF46][3 de ancho][5 de alto] y 15 casillas) que no apunta ninguna tabla:
;   su sitio es justo la entrada del mapa 11 en 0xAF2A, que leida como puntero
;   da 0xEF46. No esta medido si el juego lo ensena
;   0xaf40..0xaf53  (19 bytes)
DATA_plano_sin_puntero:
	defb 046h,0efh,003h,005h,000h,083h,083h,000h,084h,083h,000h,084h,000h,084h,082h,084h	; af40  F...............
	defb 082h,082h,082h	; af50

; ----------------------------------------------------------------------
; DATOS planos: los planos de los mundos 1-9 (mapas 2-10): [destino en
;   0xEF00][ancho][alto] y ancho x alto casillas, que p01:664A copia por filas
;   de 32 (p01:6637-6666)
;   0xaf53..0xb03c  (233 bytes)
DATA_planos:
	defb 063h,0efh,009h,003h,000h,000h,000h,000h,000h,000h,000h,083h,000h,000h,083h,083h	; af53  c...............
	defb 084h,084h,082h,082h,082h,082h,084h,084h,000h,000h,000h,000h,000h,000h,000h,045h	; af63  ...............E
	defb 0efh,005h,005h,000h,000h,000h,083h,000h,000h,000h,083h,084h,000h,000h,000h,084h	; af73  ................
	defb 084h,000h,083h,083h,084h,083h,083h,000h,000h,084h,000h,000h,065h,0efh,005h,003h	; af83  ............e...
	defb 000h,000h,083h,083h,083h,000h,000h,084h,084h,084h,083h,084h,084h,082h,084h,064h	; af93  ...............d
	defb 0efh,008h,003h,000h,000h,000h,083h,000h,000h,000h,000h,000h,083h,084h,082h,000h	; afa3  ................
	defb 084h,083h,000h,083h,084h,083h,083h,083h,083h,084h,083h,064h,0efh,007h,004h,000h	; afb3  ...........d....
	defb 000h,083h,084h,083h,000h,000h,000h,083h,000h,084h,000h,083h,000h,082h,084h,083h	; afc3  ................
	defb 084h,083h,084h,082h,000h,000h,000h,082h,000h,000h,000h,064h,0efh,007h,003h,083h	; afd3  ...........d....
	defb 000h,083h,084h,083h,000h,083h,082h,082h,084h,084h,084h,082h,082h,000h,000h,082h	; afe3  ................
	defb 084h,082h,000h,000h,064h,0efh,007h,003h,000h,000h,000h,083h,000h,000h,000h,083h	; aff3  ....d...........
	defb 084h,083h,084h,083h,084h,083h,083h,084h,083h,084h,083h,084h,083h,045h,0efh,006h	; b003  .............E..
	defb 005h,083h,083h,083h,000h,000h,000h,000h,084h,082h,084h,083h,083h,000h,084h,000h	; b013  ................
	defb 084h,000h,084h,000h,084h,000h,084h,082h,082h,082h,082h,082h,082h,082h,000h,084h	; b023  ................
	defb 0efh,006h,001h,083h,083h,083h,083h,083h,083h	; b033  .........

; ----------------------------------------------------------------------
; DATOS tabla_de_salas_en_el_plano: 10 punteros, mapas 2-11, a un byte por
;   sala con su sitio en el plano (p01:666F); la palabra del mapa 0 y la del 1
;   (0x8383, leida y descartada en p01:6689) son los ultimos bytes del plano
;   del mundo 9; el ultimo byte es el primero de la lista del mapa 2
;   0xb03c..0xb04f  (19 bytes)
DATA_tabla_de_salas_en_el_plano:
	defb 04fh,0b0h	; b03c
	defb 05eh,0b0h	; b03e
	defb 06dh,0b0h	; b040
	defb 07dh,0b0h	; b042
	defb 08eh,0b0h	; b044
	defb 0a0h,0b0h	; b046
	defb 0b3h,0b0h	; b048
	defb 0c7h,0b0h	; b04a
	defb 0dch,0b0h	; b04c
	defb 0f7h	; b04e

; ----------------------------------------------------------------------
; DATOS salas_en_el_plano: por mapa 2-11, un byte por sala (y uno delante para
;   la sala 0, que es el ultimo del mapa anterior): nibble alto y bajo, la
;   casilla del plano donde p01:66A5 pone la marca de la sala
;   0xb04f..0xb0fc  (173 bytes)
DATA_salas_en_el_plano:
	defb 0b0h,018h,017h,027h,037h,038h,047h,057h,067h,066h,068h,078h,088h,087h,086h,076h	; b04f  ...'78GWgfhx...v
	defb 074h,073h,064h,063h,054h,055h,056h,057h,04bh,047h,048h,049h,04ah,03ah,046h,097h	; b05f  tsdcTUVWKGHIJ:F.
	defb 087h,076h,075h,078h,079h,077h,067h,057h,047h,037h,058h,018h,038h,028h,048h,075h	; b06f  .vuxywgWG7X.8(Hu
	defb 076h,066h,067h,068h,077h,058h,048h,038h,037h,047h,057h,039h,079h,059h,069h,049h	; b07f  vfghwXH87GW9yYiI
	defb 037h,047h,046h,056h,055h,065h,075h,074h,076h,077h,078h,079h,07ah,06ah,05ah,059h	; b08f  7GFVUeutvwxyzjZY
	defb 07bh,049h,027h,037h,036h,038h,047h,057h,067h,077h,078h,079h,069h,06ah,087h,076h	; b09f  {I'768GWgwxyij.v
	defb 075h,065h,064h,055h,059h,027h,037h,036h,046h,047h,038h,048h,049h,04ah,077h,058h	; b0af  uedUY'76FG8HIJwX
	defb 057h,056h,045h,044h,034h,066h,067h,068h,03ah,037h,047h,057h,056h,055h,054h,07ah	; b0bf  WVED4fgh:7GWVUTz
	defb 065h,067h,058h,059h,05ah,049h,069h,074h,075h,076h,077h,078h,079h,045h,085h,086h	; b0cf  egXYZIituvwxyE..
	defb 087h,088h,089h,078h,068h,058h,048h,038h,069h,06ah,05ah,04ah,03ah,039h,028h,027h	; b0df  ...xhXH8ijZJ:9('
	defb 026h,036h,046h,056h,066h,076h,015h,016h,017h,054h,055h,056h,057h	; b0ef  &6FVfv...TUVW

; ----------------------------------------------------------------------
; DATOS sitio_especial_del_plano: un byte por mapa (p01:6697 lee 0xB0FC +
;   mapa) con la casilla de una segunda marca del plano (0xE674) cuando 0xE089
;   no es 0; el byte del mapa 0 es el ultimo de la lista anterior
;   0xb0fc..0xb108  (12 bytes)
DATA_sitio_especial_del_plano:
	defb 058h,059h,087h,04bh,018h,079h,07bh,087h,077h,07ah,015h,058h	; b0fc  XY.K.y{.wz.X

; ----------------------------------------------------------------------
; DATOS tabla_de_entradas: 11 punteros, uno por mapa, a un byte por sala
;   (p00:52D0); el puntero va un byte antes de la sala 1, porque p00:4155 suma
;   la sala tal cual; lo leen p00:52D3 (22 bytes)
;   0xb108..0xb11e  (22 bytes)
DATA_tabla_de_entradas:
	defb 01dh,0b1h	; b108
	defb 0b0h,0b1h	; b10a
	defb 0bfh,0b1h	; b10c
	defb 0ceh,0b1h	; b10e
	defb 0deh,0b1h	; b110
	defb 0efh,0b1h	; b112
	defb 001h,0b2h	; b114
	defb 014h,0b2h	; b116
	defb 028h,0b2h	; b118
	defb 03dh,0b2h	; b11a
	defb 058h,0b2h	; b11c

; ----------------------------------------------------------------------
; DATOS entradas: un byte por sala, los 11 mapas seguidos (p00:52DA): 0 no
;   cambia nada; si no, el nibble alto + 8 es la Y (0xE505) y el bajo x 16 la
;   X (0xE507) del jugador al entrar; lo leen p00:52DA (321 bytes)
;   0xb11e..0xb25f  (321 bytes)
DATA_entradas:
	defb 07ch,05bh,0beh,0b1h,098h,0b3h,035h,0b3h,033h,052h,000h,000h,000h,03bh,07ch,073h	; b11e  |[....5.3R....|s
	defb 094h,000h,000h,03eh,000h,07fh,0b7h,07fh,000h,092h,05dh,031h,000h,074h,000h,05dh	; b12e  ...>......]1.t.]
	defb 0bdh,0bdh,05ch,05fh,07eh,072h,07ah,03ch,09fh,0b4h,071h,074h,053h,05fh,05dh,052h	; b13e  ..\_~rz<..qtS_]R
	defb 0b4h,0b5h,094h,0b3h,0b4h,0bah,0bah,07dh,075h,09bh,078h,0b3h,095h,055h,05bh,052h	; b14e  .......}u.x..U[R
	defb 000h,0b3h,073h,054h,033h,0b5h,05bh,058h,000h,07ch,000h,000h,0bdh,000h,000h,09dh	; b15e  ..sT3.[X.|......
	defb 091h,07ah,05eh,0bch,09bh,000h,037h,032h,07ch,000h,099h,000h,098h,073h,094h,07fh	; b16e  .z^...72|....s..
	defb 09ch,05dh,000h,079h,032h,000h,09dh,055h,078h,095h,094h,057h,000h,057h,07bh,096h	; b17e  .].y2..Ux..W.W{.
	defb 096h,05bh,099h,093h,0b2h,073h,05dh,07ah,000h,05dh,000h,000h,0b4h,071h,0b9h,07fh	; b18e  .[...s]z.]...q..
	defb 071h,072h,074h,073h,000h,000h,031h,000h,07dh,035h,03dh,037h,05dh,075h,078h,057h	; b19e  qrts..1.}5=7]uxW
	defb 057h,038h,039h,037h,05eh,075h,034h,03dh,03ah,000h,000h,072h,0bah,078h,059h,09bh	; b1ae  W897^u4=:..r.xY.
	defb 000h,07bh,09bh,057h,000h,07dh,000h,000h,000h,000h,072h,0b2h,052h,000h,000h,05ch	; b1be  .{.W.}....r.R..\
	defb 0b8h,055h,032h,000h,000h,092h,092h,000h,000h,0b8h,095h,0b5h,000h,09bh,000h,03dh	; b1ce  .U2............=
	defb 0b8h,0b4h,0b8h,000h,000h,000h,039h,000h,000h,000h,073h,05eh,038h,0b2h,09ch,000h	; b1de  ......9...s^8...
	defb 000h,098h,078h,000h,07fh,059h,03eh,000h,05ah,07dh,05dh,072h,071h,071h,031h,000h	; b1ee  ..x..Y>.Z}]rqq1.
	defb 000h,0beh,071h,05ch,098h,000h,076h,07bh,0b7h,000h,078h,053h,07fh,000h,000h,0b2h	; b1fe  ..q\..v{..xS....
	defb 03bh,000h,038h,000h,07ch,078h,0b8h,094h,000h,0bdh,000h,000h,000h,000h,0bbh,039h	; b20e  ..8.|x.........9
	defb 0b8h,072h,000h,000h,000h,054h,05dh,03dh,000h,072h,038h,058h,0bah,09ch,075h,09dh	; b21e  .r...T]=.r8X..u.
	defb 054h,0b8h,076h,05bh,0b5h,0b7h,000h,099h,038h,039h,059h,054h,054h,05ch,052h,038h	; b22e  T.v[....89YTT\R8
	defb 096h,051h,051h,031h,034h,053h,07ch,055h,0b8h,034h,000h,0b6h,0bdh,000h,000h,09eh	; b23e  .QQ14S|U.4......
	defb 0b8h,000h,094h,0b9h,03ah,038h,092h,032h,0b8h,000h,038h,031h,051h,091h,051h,0b8h	; b24e  ....:8.2..81Q.Q.
	defb 0b8h	; b25e

; ----------------------------------------------------------------------
; DATOS tabla_de_reinicios: 10 punteros, uno por mapa del 1 al 10, a las
;   listas de 0xB25D (p01:6922); la del 11 seria la palabra 0x6A55 que hacen
;   los dos primeros bytes de la lista del castillo (p01:691F solo descarta el
;   12); lo leen p01:6925 (20 bytes)
;   0xb25f..0xb273  (20 bytes)
DATA_tabla_de_reinicios:
	defb 073h,0b2h	; b25f
	defb 0e3h,0b4h	; b261
	defb 001h,0b5h	; b263
	defb 01eh,0b5h	; b265
	defb 046h,0b5h	; b267
	defb 08ah,0b5h	; b269
	defb 0bfh,0b5h	; b26b
	defb 0ffh,0b5h	; b26d
	defb 040h,0b6h	; b26f
	defb 090h,0b6h	; b271

; ----------------------------------------------------------------------
; DATOS reinicios: por sala, la lista de salas cuyo byte de estado (0xAF09) se
;   pone a 0 al entrar, acabada en 0; los mapas 1-10 seguidos (p01:6931,
;   p01:694A); lo leen p01:694A (1163 bytes)
;   0xb273..0xb6fe  (1163 bytes)
DATA_reinicios:
	defb 055h,06ah,000h,00eh,000h,00eh,000h,00eh,000h,014h,016h,017h,000h,018h,000h,018h	; b273  Uj..............
	defb 000h,00eh,018h,01ah,000h,01ah,000h,01dh,000h,021h,016h,000h,021h,017h,014h,000h	; b283  .........!..!...
	defb 021h,000h,01ah,023h,000h,023h,000h,00eh,018h,023h,000h,025h,01dh,000h,025h,000h	; b293  !..#.#...#.%..%.
	defb 025h,000h,00ch,028h,000h,016h,021h,028h,000h,028h,02bh,000h,028h,00ch,02bh,000h	; b2a3  %..(..!(.(+.(.+.
	defb 02bh,02ch,02dh,02eh,023h,01ah,000h,02bh,02ch,02dh,02eh,000h,018h,02ch,02dh,02eh	; b2b3  +,-.#..+,-...,-.
	defb 00eh,030h,000h,023h,02eh,025h,030h,031h,000h,01dh,030h,031h,000h,031h,000h,025h	; b2c3  .0.#.%01..01.1.%
	defb 000h,00ch,016h,021h,000h,014h,00ch,017h,000h,00ch,035h,02bh,000h,035h,02eh,023h	; b2d3  ...!......5+.5.#
	defb 01ah,00eh,000h,02ch,00eh,018h,030h,000h,01dh,000h,030h,000h,031h,000h,014h,016h	; b2e3  ...,..0...0.1...
	defb 021h,000h,014h,016h,017h,03ch,000h,016h,017h,02bh,035h,03ch,000h,028h,017h,03ch	; b2f3  !....<...+5<.(.<
	defb 03dh,02ch,018h,016h,000h,03ch,03dh,02dh,018h,016h,021h,000h,03ch,03dh,02eh,023h	; b303  =,...<=-..!.<=.#
	defb 01ah,018h,000h,02bh,035h,03dh,01ah,018h,000h,02ch,03dh,01ah,018h,030h,000h,040h	; b313  ...+5=...,=..0.@
	defb 01ah,031h,02dh,000h,02eh,040h,025h,01ah,023h,000h,040h,01dh,000h,040h,01dh,030h	; b323  .1-..@%.#.@..@.0
	defb 000h,040h,01dh,031h,000h,045h,035h,02bh,021h,000h,021h,02dh,000h,035h,04bh,023h	; b333  .@.1.E5+!.!-.5K#
	defb 02bh,000h,04bh,04dh,040h,02dh,031h,023h,000h,04dh,04fh,025h,000h,045h,052h,000h	; b343  +.KM@-1#.MO%.ER.
	defb 028h,03ch,052h,043h,000h,028h,035h,02bh,052h,000h,02bh,028h,02ch,03dh,045h,000h	; b353  (<RC.(5+R.+(,=E.
	defb 03ch,04bh,02eh,02dh,02ch,02bh,055h,000h,03dh,04dh,02eh,02dh,02ch,055h,030h,000h	; b363  <K.-,+U.=M.-,U0.
	defb 02eh,04fh,04bh,030h,031h,000h,058h,030h,031h,000h,030h,031h,04dh,051h,058h,000h	; b373  .OK01.X01.01MQX.
	defb 058h,04fh,000h,045h,059h,000h,059h,000h,043h,03ch,05ch,059h,000h,052h,059h,05ch	; b383  XO.EY.Y.C<\Y.RY\
	defb 05dh,035h,000h,045h,05ch,05dh,03dh,035h,000h,05ch,05dh,035h,055h,000h,05ch,05dh	; b393  ]5.E\]=5.\]5U.\]
	defb 04bh,035h,03ch,000h,05dh,035h,000h,04dh,03dh,000h,063h,040h,055h,000h,04bh,063h	; b3a3  K5<.]5.M=.c@U.Kc
	defb 04fh,000h,063h,065h,058h,000h,04dh,063h,065h,051h,000h,040h,065h,063h,000h,04fh	; b3b3  O.ceX.MceQ.@ec.O
	defb 065h,000h,067h,000h,052h,059h,067h,069h,05dh,03ch,000h,069h,06bh,06ah,03dh,03ch	; b3c3  e.g.RYgi]<.ikj=<
	defb 055h,000h,05dh,06bh,06ah,06dh,03dh,000h,06dh,06ah,055h,063h,040h,000h,065h,058h	; b3d3  U.]kjm=.mjUc@.eX
	defb 040h,000h,040h,063h,000h,043h,045h,074h,000h,074h,076h,069h,05ch,045h,043h,000h	; b3e3  @.@c.CEt.tvi\EC.
	defb 074h,067h,059h,052h,045h,05dh,079h,076h,000h,045h,06bh,078h,077h,076h,000h,055h	; b3f3  tgYRE]yv.Ekxwv.U
	defb 06ah,078h,077h,076h,000h,05ch,069h,076h,077h,078h,06dh,04bh,000h,05dh,077h,078h	; b403  jxwv.\ivwxmK.]wx
	defb 04bh,000h,06bh,078h,04dh,04bh,06fh,000h,063h,04dh,04bh,055h,06ah,000h,06dh,04fh	; b413  K.kxMKo.cMKUj.mO
	defb 04dh,04bh,000h,07eh,065h,058h,04fh,04dh,000h,07eh,07fh,051h,04fh,04dh,06fh,000h	; b423  MK.~eXOM.~.QOMo.
	defb 063h,07eh,07fh,051h,04fh,000h,052h,081h,000h,052h,081h,000h,067h,074h,081h,077h	; b433  c~.QO.R..R..gt.w
	defb 05dh,052h,059h,000h,06bh,078h,000h,077h,085h,055h,05dh,000h,069h,076h,085h,06dh	; b443  ]RY.kx.w.U].iv.m
	defb 055h,05ch,000h,00eh,000h,06bh,078h,085h,06fh,055h,000h,085h,063h,055h,06ah,000h	; b453  U\...kx.oU..cUj.
	defb 06dh,085h,000h,07eh,065h,058h,000h,063h,058h,000h,058h,000h,059h,000h,059h,000h	; b463  m..~eX.cX.X.Y.Y.
	defb 059h,05ch,000h,06bh,05dh,05ch,08dh,000h,05ch,05dh,08dh,08eh,000h,085h,06dh,05dh	; b473  Y\.k]\..\]....m]
	defb 05ch,069h,076h,08dh,08eh,000h,077h,05dh,08eh,08dh,000h,06bh,078h,08dh,08eh,06fh	; b483  \iv...w]...kx..o
	defb 000h,06ah,08eh,063h,000h,085h,06dh,063h,000h,07fh,065h,063h,06fh,000h,063h,065h	; b493  .j.c..mc..eco.ce
	defb 000h,065h,000h,067h,000h,067h,000h,067h,069h,000h,085h,06dh,06bh,069h,076h,000h	; b4a3  .e.g.g.gi..mkiv.
	defb 077h,06bh,06ah,06dh,000h,06ah,06bh,06dh,06fh,078h,08dh,000h,06fh,07fh,000h,000h	; b4b3  wkjm.jkmox..o...
	defb 000h,074h,000h,074h,000h,074h,000h,074h,081h,000h,085h,076h,077h,078h,000h,077h	; b4c3  .t.t.t.t...vwx.w
	defb 078h,000h,078h,08dh,000h,07eh,000h,07eh,07fh,000h,07eh,07fh,000h,07eh,07fh,000h	; b4d3  x.x..~.~..~..~..
	defb 005h,000h,005h,000h,000h,002h,000h,002h,000h,003h,00ah,000h,005h,000h,00dh,000h	; b4e3  ................
	defb 00ah,00dh,000h,00dh,000h,000h,00ah,000h,00ah,000h,00ah,000h,00ah,000h,005h,006h	; b4f3  ................
	defb 000h,005h,006h,000h,000h,006h,000h,000h,002h,00ah,000h,003h,005h,000h,006h,000h	; b503  ................
	defb 000h,006h,000h,000h,00ah,000h,000h,000h,003h,005h,000h,004h,005h,000h,004h,008h	; b513  ................
	defb 000h,005h,000h,002h,008h,000h,000h,002h,008h,000h,004h,000h,002h,004h,00ah,000h	; b523  ................
	defb 004h,005h,00eh,000h,008h,000h,010h,000h,005h,00eh,000h,00eh,000h,010h,000h,00ah	; b533  ................
	defb 000h,008h,000h,004h,006h,000h,007h,000h,00bh,008h,007h,000h,00bh,008h,00eh,000h	; b543  ................
	defb 00bh,008h,003h,002h,000h,007h,00eh,000h,003h,002h,006h,00eh,009h,00dh,000h,003h	; b553  ................
	defb 004h,000h,007h,000h,007h,00dh,000h,003h,004h,00dh,000h,002h,006h,00eh,00dh,009h	; b563  ................
	defb 000h,00bh,007h,000h,004h,006h,007h,000h,004h,006h,00eh,00bh,009h,00dh,000h,004h	; b573  ................
	defb 006h,00bh,008h,000h,004h,00bh,000h,005h,000h,005h,006h,000h,006h,000h,00bh,000h	; b583  ................
	defb 002h,000h,002h,003h,000h,004h,005h,000h,004h,005h,000h,004h,005h,00bh,000h,004h	; b593  ................
	defb 005h,006h,00ch,000h,004h,00eh,00fh,000h,00fh,000h,00bh,00fh,000h,00bh,000h,00bh	; b5a3  ................
	defb 00ch,000h,002h,00bh,00ch,000h,00ch,00fh,000h,002h,00eh,000h,005h,000h,006h,000h	; b5b3  ................
	defb 006h,000h,003h,006h,000h,010h,000h,003h,010h,00fh,00eh,00ah,009h,000h,00ah,005h	; b5c3  ................
	defb 010h,00fh,000h,006h,00ah,010h,00fh,000h,006h,00eh,00ch,000h,006h,000h,005h,006h	; b5d3  ................
	defb 000h,009h,000h,00ah,00fh,010h,000h,006h,009h,000h,006h,000h,005h,006h,000h,00eh	; b5e3  ................
	defb 000h,003h,005h,006h,00eh,00fh,000h,005h,006h,00ah,009h,000h,004h,007h,008h,000h	; b5f3  ................
	defb 00dh,008h,000h,007h,00dh,000h,007h,000h,008h,000h,003h,004h,00dh,000h,003h,004h	; b603  ................
	defb 00dh,000h,002h,000h,007h,000h,00dh,000h,002h,003h,004h,00dh,000h,002h,003h,008h	; b613  ................
	defb 000h,003h,007h,002h,000h,002h,000h,003h,004h,00dh,000h,004h,003h,00dh,000h,004h	; b623  ................
	defb 007h,000h,004h,007h,008h,000h,004h,007h,008h,00dh,000h,007h,000h,003h,004h,00ah	; b633  ................
	defb 00bh,00dh,000h,008h,009h,00bh,00dh,000h,008h,00bh,00dh,000h,00ah,000h,009h,003h	; b643  ................
	defb 000h,004h,000h,00ah,00bh,00ch,000h,009h,003h,000h,008h,00bh,00dh,000h,004h,00ch	; b653  ................
	defb 000h,009h,003h,000h,00ah,000h,003h,009h,000h,003h,009h,00dh,000h,004h,000h,003h	; b663  ................
	defb 004h,009h,000h,003h,004h,00ah,000h,003h,004h,008h,00ah,00bh,000h,003h,004h,00ah	; b673  ................
	defb 00bh,00ch,000h,003h,009h,00ah,00bh,00ch,000h,003h,009h,008h,000h,017h,000h,017h	; b683  ................
	defb 000h,00bh,017h,000h,002h,00bh,017h,018h,000h,00bh,000h,008h,00dh,002h,017h,016h	; b693  ................
	defb 018h,000h,002h,00eh,00dh,015h,016h,017h,018h,000h,015h,016h,017h,018h,00dh,00eh	; b6a3  ................
	defb 00fh,010h,00ah,000h,015h,016h,017h,00bh,00dh,00eh,00fh,000h,015h,016h,008h,00dh	; b6b3  ................
	defb 00eh,00fh,000h,00eh,000h,008h,00eh,000h,008h,00ah,00fh,010h,000h,00ah,00bh,008h	; b6c3  ................
	defb 000h,00ah,008h,00dh,000h,008h,00dh,000h,015h,00fh,00eh,000h,015h,010h,000h,015h	; b6d3  ................
	defb 00ah,000h,008h,00ah,016h,000h,008h,00ah,017h,000h,008h,00ah,018h,000h,008h,015h	; b6e3  ................
	defb 002h,000h,016h,008h,000h,000h,00ah,000h,00ah,010h,000h	; b6f3  ...........

; ----------------------------------------------------------------------
; DATOS tabla_de_cosas: 11 punteros, uno por mapa, a las cosas que hay en las
;   salas (p00:5DCE); la palabra 0 son los dos ultimos bytes de las listas de
;   0xB25D; lo leen p00:5DD1 (22 bytes)
;   0xb6fe..0xb714  (22 bytes)
DATA_tabla_de_cosas:
	defb 014h,0b7h	; b6fe
	defb 005h,0b8h	; b700
	defb 015h,0b8h	; b702
	defb 028h,0b8h	; b704
	defb 038h,0b8h	; b706
	defb 048h,0b8h	; b708
	defb 058h,0b8h	; b70a
	defb 068h,0b8h	; b70c
	defb 078h,0b8h	; b70e
	defb 088h,0b8h	; b710
	defb 098h,0b8h	; b712

; ----------------------------------------------------------------------
; DATOS cosas: por mapa, las cosas de las salas: [sala][cosa (6 bits) y dos
;   marcas][sitio], 3 bytes cada una, y un 0 al final (p00:5DD5 busca la de la
;   sala 0xE042); la 0x0C esta en la sala del jefe de cada mundo (0x5DFC); lo
;   leen p00:5DD5 (398 bytes)
;   0xb714..0xb8a2  (398 bytes)
DATA_cosas:
	defb 002h,0a7h,028h	; b714
	defb 003h,02dh,029h	; b717
	defb 00bh,0a0h,04ah	; b71a
	defb 00ch,0edh,06bh	; b71d
	defb 00dh,01dh,02ch	; b720
	defb 010h,02dh,06eh	; b723
	defb 011h,097h,088h	; b726
	defb 012h,02eh,04bh	; b729
	defb 013h,024h,02bh	; b72c
	defb 014h,0aeh,04dh	; b72f
	defb 018h,025h,000h	; b732
	defb 01bh,0eeh,0aah	; b735
	defb 01dh,0afh,02eh	; b738
	defb 01fh,06eh,04eh	; b73b
	defb 021h,06eh,08eh	; b73e
	defb 023h,09fh,06eh	; b741
	defb 026h,0aeh,0abh	; b744
	defb 028h,01bh,000h	; b747
	defb 02ah,02fh,029h	; b74a
	defb 02bh,026h,000h	; b74d
	defb 02ch,02fh,06fh	; b750
	defb 02dh,0aeh,029h	; b753
	defb 02fh,0aeh,04ch	; b756
	defb 030h,013h,000h	; b759
	defb 031h,0aeh,0adh	; b75c
	defb 032h,00eh,0ach	; b75f
	defb 033h,0edh,08bh	; b762
	defb 034h,00fh,06eh	; b765
	defb 03ah,02fh,02ah	; b768
	defb 03ch,0aeh,0abh	; b76b
	defb 03dh,0afh,02dh	; b76e
	defb 040h,02dh,04bh	; b771
	defb 042h,09eh,06ch	; b774
	defb 045h,0edh,0aah	; b777
	defb 046h,02dh,02ch	; b77a
	defb 047h,0c2h,08ah	; b77d
	defb 04ah,0eeh,069h	; b780
	defb 04bh,016h,000h	; b783
	defb 04ch,02eh,08ch	; b786
	defb 04dh,0afh,0abh	; b789
	defb 04eh,02eh,02fh	; b78c
	defb 04fh,003h,029h	; b78f
	defb 050h,02dh,04eh	; b792
	defb 052h,0aeh,0a9h	; b795
	defb 053h,0aeh,02dh	; b798
	defb 054h,02eh,06ch	; b79b
	defb 055h,02fh,04fh	; b79e
	defb 05ah,02eh,08ah	; b7a1
	defb 05ch,0aeh,02ah	; b7a4
	defb 05dh,02dh,029h	; b7a7
	defb 05eh,02eh,02ah	; b7aa
	defb 05fh,02fh,04ch	; b7ad
	defb 060h,08bh,04ah	; b7b0
	defb 061h,06eh,06ch	; b7b3
	defb 063h,0efh,06bh	; b7b6
	defb 064h,02dh,06fh	; b7b9
	defb 065h,0aeh,0a9h	; b7bc
	defb 066h,0a9h,02dh	; b7bf
	defb 067h,02dh,08fh	; b7c2
	defb 069h,095h,04ch	; b7c5
	defb 06bh,00ch,02eh	; b7c8
	defb 06dh,02eh,04ch	; b7cb
	defb 070h,0afh,04dh	; b7ce
	defb 075h,0afh,02bh	; b7d1
	defb 076h,0afh,0ach	; b7d4
	defb 077h,0eeh,08ch	; b7d7
	defb 079h,001h,04eh	; b7da
	defb 07ah,0afh,06dh	; b7dd
	defb 07bh,09ah,06bh	; b7e0
	defb 07fh,0aeh,06eh	; b7e3
	defb 082h,0adh,02ah	; b7e6
	defb 083h,094h,02ch	; b7e9
	defb 086h,0afh,06bh	; b7ec
	defb 087h,02eh,04eh	; b7ef
	defb 089h,01ch,029h	; b7f2
	defb 08ch,0a2h,02eh	; b7f5
	defb 08dh,011h,049h	; b7f8
	defb 090h,02ah,02ah	; b7fb
	defb 091h,02dh,02bh	; b7fe
	defb 093h,004h,04ah	; b801
	defb 000h,002h,04ah	; b804
	defb 0aeh,004h,007h	; b807
	defb 02fh,00ah,049h	; b80a
	defb 02bh,00dh,00ch	; b80d
	defb 000h,00eh,008h	; b810
	defb 08dh,000h,001h	; b813
	defb 0cah,04ch,002h	; b816
	defb 007h,0aah,004h	; b819
	defb 012h,02bh,009h	; b81c
	defb 00ch,000h,00bh	; b81f
	defb 0c9h,04eh,00eh	; b822
	defb 088h,029h,000h	; b825
	defb 004h,0c8h,049h	; b828
	defb 006h,087h,02ah	; b82b
	defb 009h,04ah,0afh	; b82e
	defb 00ah,089h,06ch	; b831
	defb 00dh,00ch,000h	; b834
	defb 000h,003h,088h	; b837
	defb 029h,006h,089h	; b83a
	defb 089h,00ah,08ah	; b83d
	defb 02dh,00eh,00ch	; b840
	defb 000h,010h,007h	; b843
	defb 08dh,000h,006h	; b846
	defb 049h,089h,009h	; b849
	defb 08ah,069h,00ch	; b84c
	defb 007h,06eh,00fh	; b84f
	defb 008h,02eh,011h	; b852
	defb 00ch,000h,000h	; b855
	defb 004h,008h,04bh	; b858
	defb 006h,049h,0a9h	; b85b
	defb 00ch,0cah,04ch	; b85e
	defb 00dh,00ch,000h	; b861
	defb 011h,007h,04dh	; b864
	defb 000h,001h,087h	; b867
	defb 029h,005h,009h	; b86a
	defb 089h,009h,00ah	; b86d
	defb 08ch,00ah,00ch	; b870
	defb 000h,010h,008h	; b873
	defb 02bh,000h,005h	; b876
	defb 0cah,04bh,007h	; b879
	defb 00ch,000h,00ah	; b87c
	defb 088h,02bh,00ch	; b87f
	defb 007h,04ch,00fh	; b882
	defb 0c9h,073h,000h	; b885
	defb 00bh,047h,02eh	; b888
	defb 00dh,089h,06ch	; b88b
	defb 017h,00ah,06eh	; b88e
	defb 018h,088h,06ah	; b891
	defb 019h,00ch,000h	; b894
	defb 000h,001h,008h	; b897
	defb 06eh,002h,087h	; b89a
	defb 04bh,003h,009h	; b89d
	defb 02ch,000h	; b8a0

; ----------------------------------------------------------------------
; DATOS castillo_b8a2: solo el castillo: por sala, una lista de bytes [y:3
;   bits][x:5 bits] acabada en 0 que p01:6309 convierte en una posicion
;   (0xF002) para p01:632C; lo leen p01:6301 (392 bytes)
;   0xb8a2..0xba2a  (392 bytes)
DATA_castillo_b8a2:
	defb 000h,022h,0bch,000h,024h,078h,0b2h,000h,071h,098h,0a8h,000h,03ch,098h,000h,000h	; b8a2  ."..$x..q...<...
	defb 000h,000h,000h,029h,034h,05ch,000h,04ah,07ah,0b7h,000h,038h,06fh,0a7h,000h,030h	; b8b2  ...)4\.Jz..8o..0
	defb 064h,0a4h,000h,000h,042h,084h,0bch,000h,036h,078h,088h,000h,058h,082h,000h,04ch	; b8c2  d...B...6x..X..L
	defb 097h,0aeh,000h,02ch,06eh,0aah,000h,056h,06ah,0aah,000h,053h,000h,0a8h,000h,000h	; b8d2  ...,n..Vj..S....
	defb 000h,051h,053h,0b9h,000h,000h,0abh,0afh,0b3h,000h,000h,03ah,04ch,0b8h,000h,000h	; b8e2  .QS........:L...
	defb 027h,059h,000h,04eh,0aah,0ach,000h,054h,099h,0a5h,000h,0a8h,000h,07ah,000h,000h	; b8f2  'Y.N...T.....z..
	defb 000h,02eh,04fh,0aeh,000h,000h,04ah,05ah,0a7h,000h,047h,000h,024h,097h,0aah,000h	; b902  ..O...JZ..G.$...
	defb 02ch,000h,050h,07ch,08ch,000h,026h,05ah,000h,000h,050h,052h,054h,000h,0b2h,000h	; b912  ,.P|..&Z..PRT...
	defb 0b6h,000h,0b0h,000h,077h,08fh,000h,078h,000h,0b2h,000h,032h,04ah,0bah,000h,04bh	; b922  ....w..x...2J..K
	defb 077h,0a9h,000h,048h,000h,000h,028h,09ah,000h,04ah,09ah,000h,0aeh,000h,036h,04ch	; b932  w..H..(..J....6L
	defb 000h,000h,000h,04ch,078h,0a4h,000h,070h,0aah,029h,000h,088h,072h,0b8h,000h,03ah	; b942  ...Lx..p.)..r..:
	defb 04bh,0b3h,000h,000h,047h,0abh,0afh,000h,030h,068h,0b7h,000h,087h,08bh,000h,026h	; b952  K...G...0h.....&
	defb 0b2h,000h,072h,000h,04bh,067h,0b6h,000h,0a4h,0b4h,000h,02ah,090h,098h,000h,044h	; b962  ..r.Kg.....*...D
	defb 0aeh,000h,02ah,03ch,068h,000h,09bh,0abh,000h,058h,000h,06bh,0b1h,000h,0a6h,000h	; b972  ..*<h....X.k....
	defb 036h,068h,0a5h,000h,042h,058h,070h,000h,05ch,04ah,000h,044h,073h,000h,02ah,072h	; b982  6h..BXp.\J.Ds.*r
	defb 085h,000h,000h,06ah,000h,053h,093h,088h,000h,034h,08ah,000h,02ah,0bah,000h,024h	; b992  ...j.S...4..*..$
	defb 054h,000h,000h,050h,06ch,000h,04ah,000h,000h,052h,08ch,000h,06fh,000h,029h,07ch	; b9a2  T..Pl.J..R..o.)|
	defb 0a7h,000h,0a6h,000h,036h,000h,09ch,000h,000h,052h,000h,04ah,099h,000h,038h,0ach	; b9b2  ....6....R.J..8.
	defb 000h,000h,050h,07ah,08ch,000h,064h,07ah,000h,08bh,000h,056h,06ah,0b1h,000h,000h	; b9c2  ..Pz..dz...Vj...
	defb 000h,04ch,076h,0a8h,000h,048h,000h,02eh,0aah,0b5h,000h,0b2h,0b0h,000h,093h,082h	; b9d2  .Lv..H..........
	defb 000h,036h,0a7h,000h,06eh,088h,058h,000h,052h,076h,0bah,000h,030h,06eh,0b1h,000h	; b9e2  .6..n.X.Rv..0n..
	defb 0aah,000h,034h,04ch,064h,000h,000h,048h,07ah,088h,000h,07ah,000h,000h,02ah,05ah	; b9f2  ..4Ld..Hz..z..*Z
	defb 08ch,000h,032h,094h,000h,000h,06bh,0b4h,000h,06eh,000h,058h,000h,02ch,044h,000h	; ba02  ..2...k..n.X.,D.
	defb 04eh,000h,044h,000h,02dh,000h,03ah,000h,044h,04bh,052h,000h,000h,02eh,030h,000h	; ba12  N.D.-.:.DKR...0.
	defb 028h,038h,000h,02ch,000h,000h,048h,000h	; ba22  (8.,..H.

; ----------------------------------------------------------------------
; DATOS pareja_e635: las palabras 1 y 2 de la tabla que p01:659D lee en 0xBA28
;   (0x0F0E y 0x0D0C), que van a 0xE635 segun el valor 1 o 2 de la sala en
;   0xBA2E (la palabra 0 no se lee: ese valor sale antes)
;   0xba2a..0xba2e  (4 bytes)
DATA_pareja_e635:
	defb 00eh,00fh	; ba2a
	defb 00ch,00dh	; ba2c

; ----------------------------------------------------------------------
; DATOS dos_bits_por_sala_del_castillo: dos bits por sala del castillo, cuatro
;   salas por byte (37 bytes para las salas 0-147): p01:6585 coge el byte sala
;   / 4 y lo desplaza 2 x (sala mod 4); 0 y 3 no hacen nada, 1 y 2 van a
;   0xE614 y eligen la pareja de 0xBA28
;   0xba2e..0xba53  (37 bytes)
DATA_dos_bits_por_sala_del_castillo:
	defb 000h,044h,012h,014h,005h,020h,012h,002h,054h,006h,044h,021h,004h,001h,001h,000h	; ba2e  .D... ..T.D!....
	defb 000h,001h,000h,000h,011h,000h,005h,000h,000h,054h,000h,000h,004h,001h,000h,020h	; ba3e  .........T.....
	defb 008h,040h,010h,001h,010h	; ba4e

; ----------------------------------------------------------------------
; DATOS salas_con_ficha_de_8: 15 ternas [sala del castillo][puntero a una
;   ficha de 8 bytes] que p01:63FB recorre buscando la sala 0xE042; la ficha
;   va a 0xEC20 (p01:640B)
;   0xba53..0xba80  (45 bytes)
DATA_salas_con_ficha_de_8:
	defb 005h,0ach,0bah	; ba53
	defb 007h,0b4h,0bah	; ba56
	defb 008h,0bch,0bah	; ba59
	defb 00ah,0c4h,0bah	; ba5c
	defb 016h,0cch,0bah	; ba5f
	defb 018h,0d4h,0bah	; ba62
	defb 01ch,0dch,0bah	; ba65
	defb 024h,0e4h,0bah	; ba68
	defb 025h,0ech,0bah	; ba6b
	defb 02bh,0f4h,0bah	; ba6e
	defb 02eh,0fch,0bah	; ba71
	defb 066h,004h,0bbh	; ba74
	defb 07eh,00ch,0bbh	; ba77
	defb 081h,014h,0bbh	; ba7a
	defb 08ch,01ch,0bbh	; ba7d

; ----------------------------------------------------------------------
; DATOS tabla_de_recorridos: 6 punteros, uno por figura de 0xE4A0 ((ix+0) - 1,
;   p01:64B1), a las listas de 0xBA8C
;   0xba80..0xba8c  (12 bytes)
DATA_tabla_de_recorridos:
	defb 08ch,0bah	; ba80
	defb 091h,0bah	; ba82
	defb 094h,0bah	; ba84
	defb 099h,0bah	; ba86
	defb 09eh,0bah	; ba88
	defb 0a5h,0bah	; ba8a

; ----------------------------------------------------------------------
; DATOS recorridos: las 6 listas de 0xBA80 (5, 3, 5, 5, 7 y 7 bytes): p01:64BE
;   coge el byte (ix+3) y lo pone en (ix+1)
;   0xba8c..0xbaac  (32 bytes)
DATA_recorridos:
	defb 00dh,016h,021h,029h,034h,00eh,018h,022h,008h,010h,01ah,023h,02eh,011h,01ch,024h	; ba8c  ..!)4.."...#...$
	defb 031h,038h,044h,052h,059h,067h,074h,081h,08ah,050h,058h,065h,071h,07eh,087h,092h	; ba9c  18DRYgt..PXeq~..

; ----------------------------------------------------------------------
; DATOS fichas_de_8: las 15 fichas de 8 bytes de las salas de 0xBA53
;   (p01:640B: dos bytes a (ix+5) y (ix+7) y seis a (ix+8)-(ix+0x0F))
;   0xbaac..0xbb24  (120 bytes)
DATA_fichas_de_8:
	defb 058h,040h,000h,002h,000h,040h,000h,0a0h	; baac  X@...@..
	defb 058h,020h,000h,002h,000h,020h,000h,0c0h	; bab4  X ... ..
	defb 038h,020h,000h,002h,000h,030h,000h,0c0h	; babc  8 ...0..
	defb 058h,050h,000h,002h,000h,050h,000h,090h	; bac4  XP...P..
	defb 058h,020h,000h,002h,000h,020h,000h,0c0h	; bacc  X ... ..
	defb 058h,030h,000h,002h,000h,030h,000h,0c0h	; bad4  X0...0..
	defb 078h,020h,000h,002h,000h,020h,000h,0c0h	; badc  x ... ..
	defb 058h,030h,000h,002h,000h,030h,000h,0b0h	; bae4  X0...0..
	defb 078h,020h,000h,002h,000h,030h,000h,0a0h	; baec  x ...0..
	defb 078h,030h,000h,002h,000h,030h,000h,0b0h	; baf4  x0...0..
	defb 058h,020h,000h,002h,000h,020h,000h,0c0h	; bafc  X ... ..
	defb 058h,040h,000h,002h,000h,040h,000h,090h	; bb04  X@...@..
	defb 078h,020h,000h,002h,000h,030h,000h,0b0h	; bb0c  x ...0..
	defb 078h,030h,000h,002h,000h,030h,000h,0b0h	; bb14  x0...0..
	defb 058h,020h,000h,002h,000h,020h,000h,090h	; bb1c  X ... ..

; ----------------------------------------------------------------------
; DATOS seis_fichas_de_8: 6 fichas de 8 bytes con el mismo formato, una por
;   figura de 0xE4A0, que p01:63C2 copia de punta a punta (p01:63DB)
;   0xbb24..0xbb54  (48 bytes)
DATA_seis_fichas_de_8:
	defb 078h,070h,000h,002h,050h,078h,092h,090h	; bb24  xp..Px..
	defb 058h,070h,000h,002h,044h,058h,08ah,078h	; bb2c  Xp..DX.x
	defb 038h,070h,000h,002h,011h,038h,038h,078h	; bb34  8p...88x
	defb 058h,070h,000h,002h,008h,058h,02eh,090h	; bb3c  Xp...X..
	defb 058h,070h,000h,002h,00eh,058h,022h,098h	; bb44  Xp...X".
	defb 098h,070h,000h,002h,00dh,098h,034h,078h	; bb4c  .p....4x

; ----------------------------------------------------------------------
; DATOS seis_bytes: un byte por cada una de las 6 figuras de p01:63C2, que va
;   a (ix+1) (p01:63CF); los dos ultimos son a la vez la palabra 0 de la tabla
;   0xBB58
;   0xbb54..0xbb5a  (6 bytes)
DATA_seis_bytes:
	defb 050h,044h,011h,008h,00eh,00dh	; bb54

; ----------------------------------------------------------------------
; DATOS tabla_de_hechizos: 10 punteros, uno por hechizo (0xE678 = 1-10), a su
;   nombre en la lista de la VRAM que pinta p00:5C25 (p01:69DA)
;   0xbb5a..0xbb6e  (20 bytes)
DATA_tabla_de_hechizos:
	defb 06eh,0bbh	; bb5a
	defb 076h,0bbh	; bb5c
	defb 07fh,0bbh	; bb5e
	defb 089h,0bbh	; bb60
	defb 094h,0bbh	; bb62
	defb 09fh,0bbh	; bb64
	defb 0a7h,0bbh	; bb66
	defb 0b1h,0bbh	; bb68
	defb 0bah,0bbh	; bb6a
	defb 0c4h,0bbh	; bb6c

; ----------------------------------------------------------------------
; DATOS nombres_de_los_hechizos: los diez hechizos como listas de 0x5C25
;   ([destino 0x398C/0x398D] y letras, A = 0x0B; 0xFF acaba): YOMAR, ELOHIM,
;   HAHAKLA, BARECHET, HEOTYMEO, LEPHA, NAWABRA, ASCHER, XYWOLEH y HAMALECH
;   0xbb6e..0xbbcf  (97 bytes)
DATA_nombres_de_los_hechizos:
	defb 08dh,039h,023h,019h,017h,00bh,01ch,0ffh,08dh,039h,00fh,016h,019h,012h,013h,017h	; bb6e  .9#......9......
	defb 0ffh,08ch,039h,012h,00bh,012h,00bh,015h,016h,00bh,0ffh,08ch,039h,00ch,00bh,01ch	; bb7e  ..9.........9...
	defb 00fh,00dh,012h,00fh,01eh,0ffh,08ch,039h,012h,00fh,019h,01eh,023h,017h,00fh,019h	; bb8e  .......9....#...
	defb 0ffh,08dh,039h,016h,00fh,01ah,012h,00bh,0ffh,08ch,039h,018h,00bh,021h,00bh,00ch	; bb9e  ..9.......9..!..
	defb 01ch,00bh,0ffh,08dh,039h,00bh,01dh,00dh,012h,00fh,01ch,0ffh,08ch,039h,022h,023h	; bbae  ....9........9"#
	defb 021h,019h,016h,00fh,012h,0ffh,08ch,039h,012h,00bh,017h,00bh,016h,00fh,00dh,012h	; bbbe  !......9........
	defb 0ffh	; bbce

; ----------------------------------------------------------------------
; DATOS recuadro_de_24x12: un recuadro de 24 x 12 caracteres que p01:69C9
;   copia por filas a 0xEE04 con p01:6D49 (el de los hechizos)
;   0xbbcf..0xbcef  (288 bytes)
DATA_recuadro_de_24x12:
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,084h,08dh,073h,06fh,093h,097h,0d1h,0c8h,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bbcf  ZZZZZZZZ..so....ZZZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,081h,071h,067h,065h,05ah,05ah,064h,069h,095h,0c5h,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bbe7  ZZZZZZZ.qgeZZdi..ZZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,07bh,078h,06ch,05eh,05ch,05ah,05ah,05ah,05ah,090h,0bch,0bfh,05ah,05ah,05ah,05ah,05ah,05ah	; bbff  ZZZZZZ{xl^\ZZZZ...ZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,085h,077h,079h,05dh,05bh,05ah,05ah,05ah,05ah,0bdh,0bbh,0c9h,05ah,05ah,05ah,05ah,05ah,05ah	; bc17  ZZZZZZ.wy][ZZZZ...ZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,07dh,089h,06dh,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,091h,0cdh,0c1h,05ah,05ah,05ah,05ah,05ah	; bc2f  ZZZZZ}.mZZZZZZZZ...ZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,07eh,08ah,06eh,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,092h,0ceh,0c2h,05ah,05ah,05ah,05ah,05ah	; bc47  ZZZZZ~.nZZZZZZZZ...ZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,086h,076h,07ah,05ah,05ah,05ah,05ah,05fh,061h,0beh,0bah,0cah,05ah,05ah,05ah,05ah,05ah,05ah	; bc5f  ZZZZZZ.vzZZZZ_a...ZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,07ch,075h,06bh,05ah,05ah,05ah,05ah,060h,062h,08fh,099h,0c0h,05ah,05ah,05ah,05ah,05ah,05ah	; bc77  ZZZZZZ|ukZZZZ`b...ZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,082h,072h,06ah,063h,05ah,05ah,066h,068h,096h,0c6h,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bc8f  ZZZZZZZ.rjcZZfh..ZZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,07fh,08eh,074h,070h,094h,098h,0d2h,0c3h,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bca7  ZZZZZZZZ..tp....ZZZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,080h,087h,088h,08bh,0cfh,0cch,0cbh,0c4h,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bcbf  ZZZZZZZZ........ZZZZZZZZ
	defb 05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,083h,08ch,0d0h,0c7h,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah	; bcd7  ZZZZZZZZZZ....ZZZZZZZZZZ

; ----------------------------------------------------------------------
; DATOS rle_BCEF: rle a la VRAM con el destino delante (0x5C40); lo leen
;   p01:6960 (354 bytes)
;   0xbcef..0xbe51  (354 bytes)
DATA_rle_BCEF:
	defb 000h,02ah,018h,000h,002h,007h,003h,00fh,002h,01fh,081h,03fh,008h,0ffh,002h,0f8h	; bcef  .*.........?....
	defb 003h,0f0h,003h,0e0h,07fh,000h,00dh,000h,087h,001h,003h,00fh,07fh,03fh,07fh,07fh	; bcff  .............?..
	defb 00ah,0ffh,082h,0fch,0f0h,003h,0c0h,002h,080h,07fh,000h,083h,001h,003h,007h,003h	; bd0f  ................
	defb 00fh,081h,03fh,009h,0ffh,087h,0feh,0fch,0f8h,0f8h,0f0h,0f8h,0c0h,00bh,000h,002h	; bd1f  ..?.............
	defb 001h,083h,003h,07fh,07fh,00bh,0ffh,002h,0feh,083h,0fch,080h,080h,006h,000h,002h	; bd2f  ................
	defb 03ch,002h,078h,092h,079h,0f3h,0f7h,0ffh,01fh,03eh,07ch,0f9h,0f3h,0e3h,0c3h,087h	; bd3f  <.x.y....>|.....
	defb 01fh,07fh,0f8h,0f0h,0e0h,0e0h,003h,0c0h,084h,0f0h,0f8h,078h,078h,003h,079h,002h	; bd4f  ...........xx.y.
	defb 07fh,083h,0ffh,0f7h,0f7h,003h,0e7h,002h,00fh,003h,01eh,003h,03ch,088h,003h,007h	; bd5f  ............<...
	defb 00fh,00eh,01eh,03ch,038h,078h,005h,0e0h,003h,0e1h,002h,07eh,083h,0feh,0f6h,0f6h	; bd6f  ...<8x.....~....
	defb 003h,0eeh,002h,00fh,088h,01fh,01dh,03dh,03bh,07bh,073h,0f1h,0f1h,003h,0e3h,003h	; bd7f  .......=.{s.....
	defb 0c7h,002h,0e0h,003h,0c0h,003h,080h,008h,000h,003h,01fh,003h,03fh,002h,07fh,008h	; bd8f  ............?...
	defb 0ffh,083h,0f0h,0e0h,0e0h,003h,0c0h,002h,080h,007h,000h,087h,007h,003h,007h,007h	; bd9f  ................
	defb 00fh,01fh,03fh,009h,0ffh,089h,0f8h,0fch,0f8h,0f8h,0f0h,0e0h,0c0h,000h,000h,003h	; bdaf  ..?.............
	defb 001h,003h,003h,002h,007h,088h,0efh,0e7h,0e7h,0c7h,0c7h,0c3h,083h,083h,003h,087h	; bdbf  ................
	defb 003h,0c7h,092h,0e3h,0e0h,080h,080h,081h,081h,083h,0c7h,0ffh,0feh,0fbh,0f3h,0f3h	; bdcf  ................
	defb 0f7h,0e7h,0c7h,08fh,00fh,003h,0c7h,003h,087h,002h,007h,002h,078h,088h,079h,0f1h	; bddf  ............x.y.
	defb 0f3h,0f7h,0e7h,0efh,070h,0f0h,003h,0ffh,002h,081h,081h,001h,003h,0e3h,003h,0e7h	; bdef  ....p...........
	defb 002h,0efh,002h,0ceh,081h,0cfh,003h,08fh,002h,00fh,088h,0f7h,0e7h,0c7h,0cfh,08fh	; bdff  ................
	defb 08fh,01eh,01eh,003h,08fh,003h,01eh,002h,03ch,090h,007h,008h,017h,014h,017h,014h	; be0f  ........<.......
	defb 008h,007h,080h,040h,020h,0a0h,020h,0a0h,040h,080h,011h,000h,085h,003h,00fh,01fh	; be1f  ...@ . .@.......
	defb 03fh,07fh,00bh,0ffh,086h,0fch,0f0h,0e0h,0c0h,080h,080h,07fh,000h,00ah,000h,003h	; be2f  ?...............
	defb 001h,003h,003h,002h,007h,009h,0ffh,002h,0feh,003h,0fch,002h,0f8h,07fh,000h,009h	; be3f  ................
	defb 000h,000h	; be4f

; ----------------------------------------------------------------------
; DATOS tablas_de_salas_con_aviso: 13 palabras: las 9 de la tabla que p00:5D51
;   lee en 0xBE4F con B = 1-9 (el primer bit 1 de 0xE064-0xE06C) y las 4 de la
;   que p00:5D41 lee en 0xBE63 con (0xE06E) cuando lo tiene 0xE06C (la palabra
;   0 de esta es la 9 de la otra)
;   0xbe51..0xbe6b  (26 bytes)
DATA_tablas_de_salas_con_aviso:
	defb 06bh,0beh	; be51
	defb 073h,0beh	; be53
	defb 07ch,0beh	; be55
	defb 084h,0beh	; be57
	defb 088h,0beh	; be59
	defb 08fh,0beh	; be5b
	defb 095h,0beh	; be5d
	defb 09ah,0beh	; be5f
	defb 09fh,0beh	; be61
	defb 0a4h,0beh	; be63
	defb 0a9h,0beh	; be65
	defb 0aeh,0beh	; be67
	defb 0b3h,0beh	; be69

; ----------------------------------------------------------------------
; DATOS salas_con_aviso: las listas de salas de 0xBE4F y 0xBE63, acabadas en
;   0: si la sala 0xE042 esta, p00:5D63 toca el sonido 0x28
;   0xbe6b..0xbebd  (82 bytes)
DATA_salas_con_aviso:
	defb 068h,05ah,05bh,05ch,069h,075h,076h,000h,062h,056h,057h,061h,063h,06eh,06fh,070h	; be6b  hZ[\iuv.bVWacnop
	defb 000h,03fh,037h,038h,040h,04ch,04dh,04eh,000h,039h,043h,044h,000h,03eh,036h,037h	; be7b  .?78@LMN.9CD.>67
	defb 04ah,04bh,04ch,000h,072h,065h,071h,07eh,07fh,000h,006h,002h,007h,00eh,000h,017h	; be8b  JKL.req~........
	defb 00dh,016h,021h,000h,06ch,002h,003h,004h,000h,009h,004h,008h,010h,000h,01eh,013h	; be9b  ..!.l...........
	defb 01dh,026h,000h,027h,01fh,020h,028h,000h,001h,05ch,05dh,05eh,069h,06bh,076h,077h	; beab  .&.'. (..\]^ikvw
	defb 078h,000h	; bebb

; ----------------------------------------------------------------------
; DATOS texto_contrasena_jp: el texto de pedir la contrasena en japones
;   (katakana desde 0xBA y RETURN KEY), una lista sin destino de p00:5C2D que
;   p02:98FA elige si la BIOS es japonesa (nibble alto de 0x002B)
;   0xbebd..0xbee3  (38 bytes)
DATA_texto_contrasena_jp:
	defb 0d4h,0d9h,0cbh,0d2h,000h,0bah,0e7h,0c3h,0ech,0bch,0e6h,000h,0bbh,0e3h,0cch,0eeh	; bebd  ................
	defb 0feh,0c7h,038h,01ch,00fh,01eh,01fh,01ch,018h,025h,015h,00fh,023h,0e6h,000h,0beh	; becd  ..8......%..#...
	defb 0c5h,0ceh,0c4h,0bbh,0efh,0ffh	; bedd

; ----------------------------------------------------------------------
; DATOS texto_contrasena_mala_jp: el de la contrasena equivocada en japones
;   (p02:991C)
;   0xbee3..0xbef6  (19 bytes)
DATA_texto_contrasena_mala_jp:
	defb 0c3h,0d2h,0bah,0e7h,0c3h,0ech,0bch,0d3h,000h,0d8h,0cah,0bfh,0ech,0e8h,0cch,0bbh	; bee3  ................
	defb 0e2h,0efh,0ffh	; bef3

; ----------------------------------------------------------------------
; DATOS texto_memoria_jp: el de la contrasena buena en japones, que nombra a
;   GALIOUS y a PAMPERSE (p02:9933)
;   0xbef6..0xbf3c  (70 bytes)
DATA_texto_memoria_jp:
	defb 0dfh,0d2h,0c0h,0beh,0c1h,0bfh,0ech,000h,0bbh,0d8h,0dch,0cdh,0ech,0e8h,0c9h,0efh	; bef6  ................
	defb 0feh,007h,03ah,0c4h,0bah,0eeh,0bbh,0e8h,0c3h,0c1h,0dch,0d3h,0ddh,0c1h,000h,011h	; bf06  ..:.............
	defb 00bh,016h,013h,019h,01fh,01dh,0e6h,0feh,047h,03ah,0c9h,0beh,0c5h,0eeh,01ah,00bh	; bf16  ........G:......
	defb 017h,01ah,00fh,01ch,01dh,00fh,0e6h,0feh,087h,03ah,0c9h,0c6h,0c2h,0e2h,0d2h,0c9h	; bf26  .........:......
	defb 0ech,0efh,0deh,0c2h,027h,0ffh	; bf36

; ----------------------------------------------------------------------
; DATOS texto_contrasena_en: ENTER THE SECRET / CODE AND PRESS / RETURN KEY.
;   (p02:98FF; 0xFE con dos bytes cambia de linea)
;   0xbf3c..0xbf6c  (48 bytes)
DATA_texto_contrasena_en:
	defb 00fh,018h,01eh,00fh,01ch,000h,01eh,012h,00fh,000h,01dh,00fh,00dh,01ch,00fh,01eh	; bf3c  ................
	defb 0feh,0a7h,038h,00dh,019h,00eh,00fh,000h,00bh,018h,00eh,000h,01ah,01ch,00fh,01dh	; bf4c  ..8.............
	defb 01dh,0feh,0c7h,038h,01ch,00fh,01eh,01fh,01ch,018h,000h,015h,00fh,023h,02ah,0ffh	; bf5c  ...8.........#*.

; ----------------------------------------------------------------------
; DATOS texto_contrasena_mala_en: THAT IS THE WRONG / CODE. (p02:9921)
;   0xbf6c..0xbf86  (26 bytes)
DATA_texto_contrasena_mala_en:
	defb 01eh,012h,00bh,01eh,000h,013h,01dh,000h,01eh,012h,00fh,000h,021h,01ch,019h,018h	; bf6c  ............!...
	defb 011h,0feh,0a7h,03ah,00dh,019h,00eh,00fh,02ah,0ffh	; bf7c  ...:....*.

; ----------------------------------------------------------------------
; DATOS texto_memoria_en: MY MEMORY HAS BEEN / BROUGHT BACK! / DEFEAT GALIOUS
;   AND / SAVE PAMPERSE AS / SOON AS POSSIBLE! GO! (p02:9938); su 0xFF es el
;   de 0xBFE8
;   0xbf86..0xbfe9  (99 bytes)
DATA_texto_memoria_en:
	defb 017h,023h,000h,017h,00fh,017h,019h,01ch,023h,000h,012h,00bh,01dh,000h,00ch,00fh	; bf86  .#......#.......
	defb 00fh,018h,0feh,0e7h,039h,00ch,01ch,019h,01fh,011h,012h,01eh,000h,00ch,00bh,00dh	; bf96  ....9...........
	defb 015h,027h,0feh,007h,03ah,00eh,00fh,010h,00fh,00bh,01eh,000h,011h,00bh,016h,013h	; bfa6  .'..:...........
	defb 019h,01fh,01dh,000h,00bh,018h,00eh,0feh,027h,03ah,01dh,00bh,020h,00fh,000h,01ah	; bfb6  ........':.. ...
	defb 00bh,017h,01ah,00fh,01ch,01dh,00fh,000h,00bh,01dh,0feh,047h,03ah,01dh,019h,019h	; bfc6  ...........G:...
	defb 018h,000h,00bh,01dh,000h,01ah,019h,01dh,01dh,013h,00ch,016h,00fh,027h,000h,011h	; bfd6  .............'..
	defb 019h,027h,0ffh	; bfe6

; ----------------------------------------------------------------------
; DATOS relleno_p09: relleno: 23 bytes 0xFF hasta el final del banco, sin nada
;   que los lea ni los ejecute (23 bytes)
;   0xbfe9..0xc000  (23 bytes)
DATA_relleno_p09:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe9  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bff9
