; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
lb8efh:	equ 0x0b8ef

; ======================================================================
; CODIGO 0xa000..0xa056  (86 bytes)
; ======================================================================


L_A000:
	jp L_A03F		;a000
L_A003:
	ld a,(0e094h)		;a003
	and a			;a006
	ret nz			;a007
	ld a,(0e068h)		;a008
	bit 2,a		;a00b
	ret z			;a00d
	ld c,025h		;a00e
	ld de,068d0h		;a010
L_A013:
	ld a,(0e61ch)		;a013
	and a			;a016
	ret z			;a017
	jr L_A049		;a018
L_A01A:
	ld a,(0e095h)		;a01a
	and a			;a01d
	ret nz			;a01e
	call L_A8CE		;a01f
	ret z			;a022
	ld b,004h		;a023
	ld hl,0a056h		;a025
	ld c,026h		;a028
	ld de,02860h		;a02a
	ld a,(0e536h)		;a02d
	cp b			;a030
	jr z,L_A049		;a031
	call 04155h		;a033
	ld d,a			;a036
	ld a,(0e008h)		;a037
	and a			;a03a
	ret z			;a03b
	and d			;a03c
	jr z,L_A044		;a03d
L_A03F:
	ld hl,0e536h		;a03f
	inc (hl)			;a042
	ret			;a043
L_A044:
	xor a			;a044
	ld (0e536h),a		;a045
	ret			;a048
L_A049:
	ld a,001h		;a049
	ld (0e539h),a		;a04b
	call 05d88h		;a04e
	ld a,02eh		;a051
	jp 04e1fh		;a053

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a056: 4 bytes que p03:A025 lee con 0x4155 y compara con
;   0xE536
;   0xa056..0xa05a  (4 bytes)
DATA_cuatro_bytes_a056:
	defb 008h,002h,004h,001h	; a056

; ======================================================================
; CODIGO 0xa05a..0xa134  (218 bytes)
; ======================================================================


L_A05A:
	ld hl,0ed80h		;a05a
	ld (0e6aah),hl		;a05d
	ld hl,02014h		;a060
	ld (0e6ach),hl		;a063
	ld hl,00a0ah		;a066
	ld (0e6aeh),hl		;a069
	ret			;a06c
L_A06D:
	ld hl,0e6afh		;a06d
	dec (hl)			;a070
	ret nz			;a071
	ld (hl),00ah		;a072
	ld hl,(0e6aah)		;a074
	call L_A0BC		;a077
	ld a,(0e6ach)		;a07a
	dec a			;a07d
	ld l,a			;a07e
	ld h,000h		;a07f
	add hl,hl			;a081
	add hl,hl			;a082
	add hl,hl			;a083
	add hl,hl			;a084
	add hl,hl			;a085
	ld de,(0e6aah)		;a086
	add hl,de			;a08a
	call L_A0BC		;a08b
	ld hl,(0e6aah)		;a08e
	call L_A0CB		;a091
	ld hl,(0e6aah)		;a094
	ld a,(0e6adh)		;a097
	dec a			;a09a
	call 04136h		;a09b
	call L_A0CB		;a09e
	ld hl,(0e6aah)		;a0a1
	ld bc,00021h		;a0a4
	add hl,bc			;a0a7
	ld (0e6aah),hl		;a0a8
	ld hl,(0e6ach)		;a0ab
	ld de,00202h		;a0ae
	or a			;a0b1
	sbc hl,de		;a0b2
	ld (0e6ach),hl		;a0b4
	ld hl,0e6aeh		;a0b7
	dec (hl)			;a0ba
	ret			;a0bb
L_A0BC:
	ld a,(0e6adh)		;a0bc
	ld b,a			;a0bf
L_A0C0:
	call L_A0E1		;a0c0
	jr z,L_A0C7		;a0c3
	ld (hl),000h		;a0c5
L_A0C7:
	inc hl			;a0c7
	djnz L_A0C0		;a0c8
	ret			;a0ca
L_A0CB:
	ld bc,00020h		;a0cb
	ld a,(0e6ach)		;a0ce
	exx			;a0d1
	ld b,a			;a0d2
L_A0D3:
	exx			;a0d3
	call L_A0E1		;a0d4
	jr z,L_A0DB		;a0d7
	ld (hl),000h		;a0d9
L_A0DB:
	add hl,bc			;a0db
	exx			;a0dc
	djnz L_A0D3		;a0dd
	exx			;a0df
	ret			;a0e0
L_A0E1:
	ld de,(0e6a8h)		;a0e1
	rst 20h			;a0e5
	ret z			;a0e6
	inc de			;a0e7
	rst 20h			;a0e8
	ret z			;a0e9
	ld a,01fh		;a0ea
	call 0413bh		;a0ec
	rst 20h			;a0ef
	ret z			;a0f0
	inc de			;a0f1
	rst 20h			;a0f2
	ret			;a0f3
L_A0F4:
	call L_B005		;a0f4
	call L_A103		;a0f7
	call L_A124		;a0fa
	call L_A715		;a0fd
	jp L_A7F8		;a100
L_A103:
	ld a,(0e501h)		;a103
	or a			;a106
	jr nz,L_A113		;a107
	ld hl,(0e041h)		;a109
	ld de,00b08h		;a10c
	or a			;a10f
	sbc hl,de		;a110
	ret z			;a112
L_A113:
	ld a,(0e511h)		;a113
	and a			;a116
	ret z			;a117
	ld hl,0e505h		;a118
	ld a,(hl)			;a11b
	cp 0b9h		;a11c
	ret c			;a11e
	ld (hl),0b9h		;a11f
	jp L_B051		;a121
L_A124:
	xor a			;a124
	ld (0e515h),a		;a125
	call L_A8D9		;a128
	call L_A8F2		;a12b
	ld a,(0e500h)		;a12e
	call 04140h		;a131

; ----------------------------------------------------------------------
; DATOS tabla_A134: 8 destinos del despachador de 0x4140 (call en p03:A131):
;   0xA144, 0xA2D2, 0xA3AC, 0xA608, 0xA460, 0xA566, 0xA6EA, 0xA5BA; lo leen
;   p03:A131 (16 bytes)
;   0xa134..0xa144  (16 bytes)
DATA_tabla_A134:
	defb 044h,0a1h	; a134
	defb 0d2h,0a2h	; a136
	defb 0ach,0a3h	; a138
	defb 008h,0a6h	; a13a
	defb 060h,0a4h	; a13c
	defb 066h,0a5h	; a13e
	defb 0eah,0a6h	; a140
	defb 0bah,0a5h	; a142

; ======================================================================
; CODIGO 0xa144..0xa2e4  (416 bytes)
; ======================================================================


L_A144:
	call L_A8CE		;a144
	jr nz,L_A150		;a147
	ld hl,0e519h		;a149
	bit 3,(hl)		;a14c
	jr z,L_A190		;a14e
L_A150:
	ld a,(0e508h)		;a150
	and a			;a153
	jp nz,L_A28B		;a154
	ld a,(0e52eh)		;a157
	rla			;a15a
	rla			;a15b
	rla			;a15c
	rla			;a15d
	rla			;a15e
	push af			;a15f
	call c,L_A1F5		;a160
	pop af			;a163
	rla			;a164
	push af			;a165
	call c,L_A1A7		;a166
	pop af			;a169
	rla			;a16a
	jp c,L_A2A6		;a16b
	rla			;a16e
	jp c,L_A256		;a16f
	ld a,(0e52eh)		;a172
	and 00ch		;a175
	ret nz			;a177
L_A178:
	ld a,(0e520h)		;a178
	and a			;a17b
	ret z			;a17c
	call L_A23F		;a17d
	ld a,(0e519h)		;a180
	and 003h		;a183
	ret z			;a185
	jp L_AF7D		;a186
L_A189:
	ld a,(0e50eh)		;a189
	dec a			;a18c
	ret nz			;a18d
	jr L_A178		;a18e
L_A190:
	ld a,(0e501h)		;a190
	and a			;a193
	ld a,00ch		;a194
	jr z,L_A19A		;a196
	ld a,00dh		;a198
L_A19A:
	ld d,000h		;a19a
	ld e,a			;a19c
	ld (0e509h),de		;a19d
	ld a,002h		;a1a1
	ld (0e500h),a		;a1a3
	ret			;a1a6
L_A1A7:
	ld a,001h		;a1a7
	ld (0e503h),a		;a1a9
	ld a,(0e502h)		;a1ac
	and 001h		;a1af
	or 002h		;a1b1
	ld (0e502h),a		;a1b3
L_A1B6:
	ld a,(0e520h)		;a1b6
	and a			;a1b9
	call nz,L_A23F		;a1ba
	ld a,(0e500h)		;a1bd
	dec a			;a1c0
	call nz,L_A2C4		;a1c1
	ld hl,(0e506h)		;a1c4
	ld a,(0e519h)		;a1c7
	ld c,a			;a1ca
	bit 1,a		;a1cb
	jp nz,L_AF7D		;a1cd
	ld a,(0e520h)		;a1d0
	cp 002h		;a1d3
	jr c,L_A1DE		;a1d5
	ld a,c			;a1d7
	bit 0,a		;a1d8
	jp nz,L_AF7D		;a1da
	ret			;a1dd
L_A1DE:
	ld a,(0e511h)		;a1de
	and a			;a1e1
	ld bc,0ff80h		;a1e2
	jr nz,L_A1F2		;a1e5
	ld bc,0fe00h		;a1e7
	call L_A5FE		;a1ea
	jr z,L_A1F2		;a1ed
	ld bc,0fd80h		;a1ef
L_A1F2:
	jp L_A94C		;a1f2
L_A1F5:
	xor a			;a1f5
	ld (0e503h),a		;a1f6
	ld a,(0e502h)		;a1f9
	and 001h		;a1fc
	ld (0e502h),a		;a1fe
L_A201:
	ld a,(0e520h)		;a201
	and a			;a204
	call nz,L_A23F		;a205
	ld a,(0e500h)		;a208
	dec a			;a20b
	call nz,L_A2C4		;a20c
	ld hl,(0e506h)		;a20f
	ld a,(0e519h)		;a212
	ld c,a			;a215
	bit 0,a		;a216
	jp nz,L_AF7D		;a218
	ld a,(0e520h)		;a21b
	bit 0,a		;a21e
	jr z,L_A229		;a220
	ld a,c			;a222
	bit 1,a		;a223
	jp nz,L_AF7D		;a225
	ret			;a228
L_A229:
	ld a,(0e511h)		;a229
	and a			;a22c
	ld bc,00080h		;a22d
	jr nz,L_A23D		;a230
	ld bc,00200h		;a232
	call L_A5FE		;a235
	jr z,L_A23D		;a238
	ld bc,00280h		;a23a
L_A23D:
	jr L_A1F2		;a23d
L_A23F:
	ld a,(0e519h)		;a23f
	and 003h		;a242
	ret nz			;a244
	ld hl,0e520h		;a245
	ld a,(hl)			;a248
	inc hl			;a249
	dec a			;a24a
	ld b,0f8h		;a24b
	jr z,L_A251		;a24d
	ld b,012h		;a24f
L_A251:
	ld a,(hl)			;a251
	add a,b			;a252
	jp L_A893		;a253
L_A256:
	ld a,(0e008h)		;a256
	and 001h		;a259
	ret z			;a25b
	call L_AEE1		;a25c
	jr nc,L_A28B		;a25f
	ld a,001h		;a261
	ld b,00eh		;a263
L_A265:
	ld (0e50ch),a		;a265
	xor a			;a268
	ld (0e50bh),a		;a269
	ld (0e522h),a		;a26c
	ld (0e530h),a		;a26f
	ld a,(0e502h)		;a272
	ld (0e50dh),a		;a275
	ld a,(0e503h)		;a278
	ld (0e516h),a		;a27b
	ld a,002h		;a27e
	ld (0e503h),a		;a280
	ld a,003h		;a283
	ld (0e500h),a		;a285
	jp L_A911		;a288
L_A28B:
	ld a,(0e008h)		;a28b
	and 001h		;a28e
	ret z			;a290
	ld a,(0e500h)		;a291
	dec a			;a294
	ret z			;a295
	xor a			;a296
	ld (0e509h),a		;a297
	ld (0e50ah),a		;a29a
	inc a			;a29d
	ld (0e500h),a		;a29e
	ld a,001h		;a2a1
	jp 04e1fh		;a2a3
L_A2A6:
	ld a,(0e008h)		;a2a6
	and 002h		;a2a9
	jp z,L_A178		;a2ab
	call L_AEF2		;a2ae
	jp nc,L_A178		;a2b1
	ld a,(0e505h)		;a2b4
	and 0f8h		;a2b7
	add a,008h		;a2b9
	ld (0e505h),a		;a2bb
	ld a,002h		;a2be
	ld b,010h		;a2c0
	jr L_A265		;a2c2
L_A2C4:
	ld a,(0e508h)		;a2c4
	and a			;a2c7
	ret nz			;a2c8
	ld a,(0e604h)		;a2c9
	and 003h		;a2cc
	ret nz			;a2ce
	jp L_A458		;a2cf
L_A2D2:
	ld hl,L_A189		;a2d2
	push hl			;a2d5
	xor a			;a2d6
	ld (0e537h),a		;a2d7
	inc a			;a2da
	ld (0e515h),a		;a2db
	ld a,(0e50eh)		;a2de
	call 04140h		;a2e1

; ----------------------------------------------------------------------
; DATOS tabla_A2E4: 4 destinos del despachador de 0x4140 (call en p03:A2E1):
;   0xA2EC, 0xA329, 0xA437, 0xA43D; lo leen p03:A2E1 (8 bytes)
;   0xa2e4..0xa2ec  (8 bytes)
DATA_tabla_A2E4:
	defb 0ech,0a2h	; a2e4
	defb 029h,0a3h	; a2e6
	defb 037h,0a4h	; a2e8
	defb 03dh,0a4h	; a2ea

; ======================================================================
; CODIGO 0xa2ec..0xa951  (1637 bytes)
; ======================================================================


L_A2EC:
	ld b,001h		;a2ec
	ld a,(0e009h)		;a2ee
	rra			;a2f1
	rra			;a2f2
	and 003h		;a2f3
	jr z,L_A304		;a2f5
	cp 003h		;a2f7
	jr z,L_A304		;a2f9
	dec a			;a2fb
	xor 001h		;a2fc
	ld (0e503h),a		;a2fe
	inc a			;a301
	inc a			;a302
	ld b,a			;a303
L_A304:
	ld hl,0e50eh		;a304
	ld (hl),b			;a307
	ld a,(0ec12h)		;a308
	and 001h		;a30b
	ld (0e52bh),a		;a30d
	ld a,(0ec10h)		;a310
	ld (0e52dh),a		;a313
	ld a,(0e508h)		;a316
	and a			;a319
	ld b,004h		;a31a
	jr z,L_A320		;a31c
	ld b,006h		;a31e
L_A320:
	call L_A90A		;a320
	ld a,001h		;a323
	ld (0e537h),a		;a325
	ret			;a328
L_A329:
	ld a,(0e501h)		;a329
	and a			;a32c
	ld a,(0e509h)		;a32d
	ld b,00ch		;a330
	jr z,L_A336		;a332
	ld b,00dh		;a334
L_A336:
	push bc			;a336
	cp b			;a337
	jr c,L_A376		;a338
	ld a,(0e009h)		;a33a
	rra			;a33d
	rra			;a33e
	and 003h		;a33f
	jr z,L_A376		;a341
	cp 003h		;a343
	jr z,L_A376		;a345
	dec a			;a347
	ld bc,00100h		;a348
	ld d,001h		;a34b
	jr nz,L_A353		;a34d
	ld bc,0ff00h		;a34f
	inc d			;a352
L_A353:
	call L_A44C		;a353
	ld a,(0e50eh)		;a356
	dec a			;a359
	ld e,a			;a35a
	jr z,L_A35E		;a35b
	ld d,a			;a35d
L_A35E:
	ld a,(0e519h)		;a35e
	and d			;a361
	jr nz,L_A376		;a362
	ld a,e			;a364
	and a			;a365
	jr nz,L_A36C		;a366
	sla c		;a368
	rl b		;a36a
L_A36C:
	ld a,(0e511h)		;a36c
	and a			;a36f
	call nz,L_A443		;a370
	call L_A949		;a373
L_A376:
	pop bc			;a376
	dec b			;a377
	dec b			;a378
	ld a,(0e509h)		;a379
	cp b			;a37c
	jr nc,L_A3AC		;a37d
	ld a,(0e501h)		;a37f
	and a			;a382
	jr z,L_A399		;a383
	ld a,(0e52bh)		;a385
	and a			;a388
	jr z,L_A392		;a389
	ld a,(0e509h)		;a38b
	cp 006h		;a38e
	jr c,L_A399		;a390
L_A392:
	ld a,(0e009h)		;a392
	and 001h		;a395
	jr z,L_A3A7		;a397
L_A399:
	ld a,(0e505h)		;a399
	cp 029h		;a39c
	jr c,L_A3A7		;a39e
	ld a,(0e519h)		;a3a0
	bit 2,a		;a3a3
	jr z,L_A3F0		;a3a5
L_A3A7:
	ld a,b			;a3a7
	ld (0e509h),a		;a3a8
	ret			;a3ab
L_A3AC:
	call L_A8CE		;a3ac
	jr nz,L_A3C8		;a3af
	ld a,(0e519h)		;a3b1
	bit 3,a		;a3b4
	jr z,L_A3F0		;a3b6
	call L_BF02		;a3b8
	ld a,(0e503h)		;a3bb
	inc a			;a3be
	xor 001h		;a3bf
	rla			;a3c1
	rla			;a3c2
	and 00ch		;a3c3
	ld (0e52eh),a		;a3c5
L_A3C8:
	ld a,(0e500h)		;a3c8
	dec a			;a3cb
	ld a,002h		;a3cc
	call nz,04e1fh		;a3ce
	xor a			;a3d1
	ld (0e500h),a		;a3d2
	ld (0e50eh),a		;a3d5
	ld (0e52bh),a		;a3d8
	call L_A560		;a3db
	ld a,(0e508h)		;a3de
	and a			;a3e1
	ret nz			;a3e2
L_A3E3:
	ld b,000h		;a3e3
	ld a,(0e503h)		;a3e5
	and a			;a3e8
	jr z,L_A3ED		;a3e9
	inc b			;a3eb
	inc b			;a3ec
L_A3ED:
	jp L_A911		;a3ed
L_A3F0:
	ld a,(0e501h)		;a3f0
	and a			;a3f3
	ld b,018h		;a3f4
	ld de,0a953h		;a3f6
	jr z,L_A400		;a3f9
	ld b,01ah		;a3fb
	ld de,0a951h		;a3fd
L_A400:
	ld hl,0e50ah		;a400
	inc (hl)			;a403
	ld a,(0e511h)		;a404
	and a			;a407
	jr z,L_A40F		;a408
	ld a,(hl)			;a40a
	and 003h		;a40b
	jr nz,L_A413		;a40d
L_A40F:
	ld hl,0e509h		;a40f
	inc (hl)			;a412
L_A413:
	ld a,(0e509h)		;a413
	cp b			;a416
	jr c,L_A41B		;a417
	ld a,b			;a419
	ld (hl),a			;a41a
L_A41B:
	dec a			;a41b
	ret m			;a41c
	ex de,hl			;a41d
	call 04155h		;a41e
	ld b,a			;a421
	ld c,000h		;a422
	ld a,(0e511h)		;a424
	and a			;a427
	call nz,L_A443		;a428
	ld (0e512h),bc		;a42b
	ld hl,(0e504h)		;a42f
	add hl,bc			;a432
	ld (0e504h),hl		;a433
	ret			;a436
L_A437:
	call L_A329		;a437
	jp L_A201		;a43a
L_A43D:
	call L_A329		;a43d
	jp L_A1B6		;a440
L_A443:
	sra b		;a443
	rr c		;a445
	sra b		;a447
	rr c		;a449
	ret			;a44b
L_A44C:
	xor 001h		;a44c
	ld e,a			;a44e
	ld a,(0e503h)		;a44f
	cp e			;a452
	ret z			;a453
	ld a,e			;a454
	ld (0e503h),a		;a455
L_A458:
	ld a,(0e502h)		;a458
	xor 001h		;a45b
	jp L_A912		;a45d
L_A460:
	ld a,001h		;a460
	ld (0e515h),a		;a462
	ld a,(0e50eh)		;a465
	and a			;a468
	jr nz,L_A4A8		;a469
	ld a,(0e514h)		;a46b
	ld b,00ch		;a46e
	and a			;a470
	jr nz,L_A475		;a471
	ld b,00ah		;a473
L_A475:
	call L_A911		;a475
	ld hl,0fe80h		;a478
	ld (0e512h),hl		;a47b
	ld a,(0e514h)		;a47e
	ld de,0fc00h		;a481
	and a			;a484
	jr z,L_A48A		;a485
	ld de,00400h		;a487
L_A48A:
	ld (0e51eh),de		;a48a
	ld a,0ffh		;a48e
	ld (0e50fh),a		;a490
	inc a			;a493
	ld (0e508h),a		;a494
	ld (0e530h),a		;a497
	ld (0e51bh),a		;a49a
	ld (0e526h),a		;a49d
	ld (0e538h),a		;a4a0
L_A4A3:
	ld hl,0e50eh		;a4a3
	inc (hl)			;a4a6
	ret			;a4a7
L_A4A8:
	dec a			;a4a8
	jp nz,L_A536		;a4a9
	ld a,(0e511h)		;a4ac
	and a			;a4af
	jr z,L_A4B8		;a4b0
	ld a,(0e604h)		;a4b2
	and 003h		;a4b5
	ret nz			;a4b7
L_A4B8:
	ld hl,0e50fh		;a4b8
	inc (hl)			;a4bb
	jr z,L_A4CA		;a4bc
	call L_A8CE		;a4be
	jr nz,L_A518		;a4c1
	ld a,(0e519h)		;a4c3
	bit 3,a		;a4c6
	jr nz,L_A515		;a4c8
L_A4CA:
	ld hl,(0e512h)		;a4ca
	ld de,00080h		;a4cd
	add hl,de			;a4d0
	ld a,h			;a4d1
	bit 7,a		;a4d2
	jr nz,L_A4DC		;a4d4
	ld b,006h		;a4d6
	cp b			;a4d8
	jr c,L_A4DC		;a4d9
	ld a,b			;a4db
L_A4DC:
	ld h,a			;a4dc
	ld (0e512h),hl		;a4dd
	ex de,hl			;a4e0
	ld e,000h		;a4e1
	ld hl,(0e504h)		;a4e3
	add hl,de			;a4e6
	ld a,h			;a4e7
	cp 028h		;a4e8
	jr nc,L_A4EE		;a4ea
	ld a,028h		;a4ec
L_A4EE:
	ld h,a			;a4ee
	ld (0e504h),hl		;a4ef
	ld a,(0e50ch)		;a4f2
	and a			;a4f5
	ret nz			;a4f6
	ld a,(0e514h)		;a4f7
	and a			;a4fa
	ld a,(0e519h)		;a4fb
	jr z,L_A504		;a4fe
	bit 0,a		;a500
	jr L_A506		;a502
L_A504:
	bit 1,a		;a504
L_A506:
	jp nz,L_AF7D		;a506
	ld hl,(0e506h)		;a509
	ld de,(0e51eh)		;a50c
	add hl,de			;a510
	ld (0e506h),hl		;a511
	ret			;a514
L_A515:
	call L_BF02		;a515
L_A518:
	xor a			;a518
	ld (0e515h),a		;a519
	ld a,(0e514h)		;a51c
	ld b,00dh		;a51f
	and a			;a521
	jr nz,L_A526		;a522
	ld b,00bh		;a524
L_A526:
	call L_A911		;a526
	ld a,004h		;a529
	ld (0e50fh),a		;a52b
	ld a,002h		;a52e
	call 04e1fh		;a530
	jp L_A4A3		;a533
L_A536:
	ld hl,0e515h		;a536
	ld (hl),000h		;a539
	ld hl,0e50fh		;a53b
	dec (hl)			;a53e
	ret nz			;a53f
	ld a,01eh		;a540
	ld (0e532h),a		;a542
	ld a,001h		;a545
	ld (0e533h),a		;a547
	ld a,(0e514h)		;a54a
	ld (0e503h),a		;a54d
	call L_A3E3		;a550
	xor a			;a553
	ld (0e500h),a		;a554
L_A557:
	ld (0e50eh),a		;a557
	ld (0e508h),a		;a55a
	ld (0e50ch),a		;a55d
L_A560:
	ld a,001h		;a560
	ld (0e530h),a		;a562
	ret			;a565
L_A566:
	ld a,(0e503h)		;a566
	and a			;a569
	ld b,017h		;a56a
	jr z,L_A570		;a56c
	ld b,01ch		;a56e
L_A570:
	ld a,(0e50eh)		;a570
	dec a			;a573
	ld hl,0e50fh		;a574
	jr z,L_A589		;a577
	jp p,L_A59F		;a579
	ld (hl),004h		;a57c
	call 05cc9h		;a57e
	ld a,094h		;a581
	call 04e1fh		;a583
L_A586:
	jp L_A4A3		;a586
L_A589:
	dec (hl)			;a589
	ret nz			;a58a
	ld a,(0e503h)		;a58b
	and a			;a58e
	ld a,012h		;a58f
	jr z,L_A595		;a591
	ld a,017h		;a593
L_A595:
	ld (0e502h),a		;a595
	ld a,006h		;a598
	ld (0e50fh),a		;a59a
	jr L_A586		;a59d
L_A59F:
	dec a			;a59f
	jr nz,L_A5B2		;a5a0
	dec (hl)			;a5a2
	ret nz			;a5a3
	ld (hl),006h		;a5a4
	ld hl,0e502h		;a5a6
	inc (hl)			;a5a9
	ld a,(hl)			;a5aa
	cp b			;a5ab
	ret nz			;a5ac
	dec (hl)			;a5ad
	ld a,0ffh		;a5ae
	jr L_A595		;a5b0
L_A5B2:
	dec (hl)			;a5b2
	ret nz			;a5b3
	xor a			;a5b4
	ld (0e019h),a		;a5b5
	jr L_A557		;a5b8
L_A5BA:
	ld a,(0ea01h)		;a5ba
	dec a			;a5bd
	jr nz,L_A5C6		;a5be
	ld a,(0e519h)		;a5c0
	and 003h		;a5c3
	ret nz			;a5c5
L_A5C6:
	ld a,(0e529h)		;a5c6
	and a			;a5c9
	ld de,00100h		;a5ca
	ld c,004h		;a5cd
	jr nz,L_A5D6		;a5cf
	ld de,00200h		;a5d1
	ld c,001h		;a5d4
L_A5D6:
	ld a,(0e503h)		;a5d6
	and a			;a5d9
	ld b,000h		;a5da
	jr z,L_A5E3		;a5dc
	ld b,002h		;a5de
	call 0415ch		;a5e0
L_A5E3:
	ld hl,(0e506h)		;a5e3
	add hl,de			;a5e6
	ld (0e506h),hl		;a5e7
	ld a,(0e604h)		;a5ea
	and c			;a5ed
	jr nz,L_A5F1		;a5ee
	inc b			;a5f0
L_A5F1:
	jp L_A911		;a5f1
L_A5F4:
	ld a,(hl)			;a5f4
	rra			;a5f5
	rra			;a5f6
	rra			;a5f7
	and 001h		;a5f8
	add a,b			;a5fa
	jp L_A912		;a5fb
L_A5FE:
	ld a,(0e080h)		;a5fe
	and a			;a601
	ret z			;a602
	ld a,(0e500h)		;a603
	dec a			;a606
	ret			;a607
L_A608:
	ld a,(0e522h)		;a608
	and a			;a60b
	jr z,L_A64E		;a60c
	ld a,(0e519h)		;a60e
	bit 3,a		;a611
	jr z,L_A652		;a613
	call L_BF02		;a615
	ld a,(0e525h)		;a618
	dec a			;a61b
	jr nz,L_A635		;a61c
	ld a,(0ec0fh)		;a61e
	cp 003h		;a621
	jr z,L_A62B		;a623
	ld hl,0e50ch		;a625
	cp (hl)			;a628
	jr nz,L_A635		;a629
L_A62B:
	ld a,001h		;a62b
	ld (0ec07h),a		;a62d
	ld a,02eh		;a630
	call 04e1fh		;a632
L_A635:
	xor a			;a635
	ld (0e50ch),a		;a636
	ld (0e50bh),a		;a639
	ld (0e500h),a		;a63c
	ld a,(0e516h)		;a63f
	ld (0e503h),a		;a642
	call L_A560		;a645
	ld a,(0e50dh)		;a648
	jp L_A912		;a64b
L_A64E:
	inc a			;a64e
	ld (0e522h),a		;a64f
L_A652:
	ld a,(0e508h)		;a652
	and a			;a655
	ret nz			;a656
	ld hl,0e50bh		;a657
	inc (hl)			;a65a
	ld a,(0e52eh)		;a65b
	and 00fh		;a65e
	ret z			;a660
	srl a		;a661
	ld b,001h		;a663
	ld c,002h		;a665
	jr c,L_A6B2		;a667
	inc b			;a669
	srl a		;a66a
	jr c,L_A6B2		;a66c
	cp 003h		;a66e
	ret z			;a670
	ld b,001h		;a671
	srl a		;a673
	jr c,L_A678		;a675
	dec b			;a677
L_A678:
	ld a,b			;a678
	ld e,a			;a679
	ld (0e503h),a		;a67a
	call L_A3E3		;a67d
	ld a,e			;a680
	and a			;a681
	ld hl,0e519h		;a682
	ld d,008h		;a685
	ld e,d			;a687
	jr z,L_A692		;a688
	ld d,0f7h		;a68a
	ld e,d			;a68c
	bit 1,(hl)		;a68d
	ret nz			;a68f
	jr L_A695		;a690
L_A692:
	bit 0,(hl)		;a692
	ret nz			;a694
L_A695:
	ld a,(0e505h)		;a695
	add a,005h		;a698
	ld l,a			;a69a
	ld a,(0e507h)		;a69b
	add a,d			;a69e
	ld h,a			;a69f
	call 04da1h		;a6a0
	ld a,(hl)			;a6a3
	cp 0bah		;a6a4
	ret c			;a6a6
	xor a			;a6a7
	ld (0e500h),a		;a6a8
	ld a,(0e507h)		;a6ab
	add a,e			;a6ae
	jp L_A893		;a6af
L_A6B2:
	ld a,c			;a6b2
	ld (0e503h),a		;a6b3
	ld a,(0e080h)		;a6b6
	ld de,00100h		;a6b9
	and a			;a6bc
	jr z,L_A6C2		;a6bd
	ld de,00140h		;a6bf
L_A6C2:
	ld a,b			;a6c2
	ld (0e50ch),a		;a6c3
	dec a			;a6c6
	call z,0415ch		;a6c7
	ld hl,(0e504h)		;a6ca
	add hl,de			;a6cd
	ld a,h			;a6ce
	ld b,027h		;a6cf
	cp b			;a6d1
	jr c,L_A6D9		;a6d2
	ld b,0c0h		;a6d4
	cp b			;a6d6
	jr c,L_A6DA		;a6d7
L_A6D9:
	ld h,b			;a6d9
L_A6DA:
	ld (0e504h),hl		;a6da
	ld a,(0e50ch)		;a6dd
	dec a			;a6e0
	ld b,00eh		;a6e1
	jr z,L_A6E7		;a6e3
	ld b,010h		;a6e5
L_A6E7:
	jp L_A5F4		;a6e7
L_A6EA:
	xor a			;a6ea
	ld (0e51bh),a		;a6eb
	ld (0e526h),a		;a6ee
	ld (0e538h),a		;a6f1
	ld a,(0e604h)		;a6f4
	bit 1,a		;a6f7
	ld a,(0e507h)		;a6f9
	ld b,001h		;a6fc
	jr z,L_A702		;a6fe
	ld b,0ffh		;a700
L_A702:
	add a,b			;a702
	ld (0e507h),a		;a703
	ld hl,0e50fh		;a706
	dec (hl)			;a709
	ret nz			;a70a
	xor a			;a70b
	ld (0e500h),a		;a70c
	ld (0e518h),a		;a70f
	jp L_A560		;a712
L_A715:
	call L_A71E		;a715
	call L_A76F		;a718
	jp L_A9CF		;a71b
L_A71E:
	ld a,(0e008h)		;a71e
	bit 4,a		;a721
	push af			;a723
	call nz,L_A747		;a724
	pop af			;a727
	bit 5,a		;a728
	ret z			;a72a
	ld a,(0e510h)		;a72b
	cp 006h		;a72e
	ret z			;a730
	cp 005h		;a731
	jr nz,L_A73A		;a733
	call L_A96D		;a735
	jr L_A73D		;a738
L_A73A:
	call L_A976		;a73a
L_A73D:
	ld a,b			;a73d
	and a			;a73e
	ret z			;a73f
	ld a,(0e510h)		;a740
	ld (iy+000h),a		;a743
	ret			;a746
L_A747:
	ld hl,0e508h		;a747
	ld a,(hl)			;a74a
	and a			;a74b
	ret nz			;a74c
	ld a,(0e500h)		;a74d
	cp 003h		;a750
	jr c,L_A75B		;a752
	ret nz			;a754
	ld a,(0e503h)		;a755
	cp 002h		;a758
	ret nc			;a75a
L_A75B:
	xor a			;a75b
	ld (0e530h),a		;a75c
	inc a			;a75f
	ld (hl),a			;a760
	ld (0e51bh),a		;a761
	ld (0e526h),a		;a764
	ld (0e538h),a		;a767
	ld a,013h		;a76a
	jp 04e1fh		;a76c
L_A76F:
	xor a			;a76f
	ld (0e523h),a		;a770
	ld hl,0e508h		;a773
	ld a,(hl)			;a776
	dec a			;a777
	jr nz,L_A7C8		;a778
	ld b,008h		;a77a
	ld a,(0e500h)		;a77c
	dec a			;a77f
	jr nz,L_A784		;a780
	ld b,006h		;a782
L_A784:
	call L_A90A		;a784
	ld a,004h		;a787
	ld (0e50fh),a		;a789
	ld a,001h		;a78c
	inc (hl)			;a78e
L_A78F:
	ld a,(0e500h)		;a78f
	ld c,012h		;a792
	dec a			;a794
	jr z,L_A799		;a795
	ld c,015h		;a797
L_A799:
	ld a,(0e503h)		;a799
	and a			;a79c
	jr z,L_A7A9		;a79d
	ld a,(0e507h)		;a79f
	sub c			;a7a2
	jr c,L_A7C1		;a7a3
	add a,006h		;a7a5
	jr L_A7B1		;a7a7
L_A7A9:
	ld a,(0e507h)		;a7a9
	add a,c			;a7ac
	jr c,L_A7C1		;a7ad
	sub 006h		;a7af
L_A7B1:
	ld h,a			;a7b1
	ld a,(0e505h)		;a7b2
	sub 008h		;a7b5
	ld l,a			;a7b7
	call 04dc8h		;a7b8
	ret nc			;a7bb
L_A7BC:
	xor a			;a7bc
	ld (0e51bh),a		;a7bd
	ret			;a7c0
L_A7C1:
	ld a,001h		;a7c1
	ld (0e523h),a		;a7c3
	jr L_A7BC		;a7c6
L_A7C8:
	ld hl,0e538h		;a7c8
	ld (hl),000h		;a7cb
	dec a			;a7cd
	ret nz			;a7ce
	call L_A78F		;a7cf
	ld hl,0e50fh		;a7d2
	dec (hl)			;a7d5
	ret nz			;a7d6
	xor a			;a7d7
	ld (0e508h),a		;a7d8
	ld (0e51bh),a		;a7db
	ld (0e526h),a		;a7de
	call L_A560		;a7e1
	ld a,(0e500h)		;a7e4
	dec a			;a7e7
	jp nz,L_A3E3		;a7e8
	ld a,(0e503h)		;a7eb
	ld b,004h		;a7ee
	and a			;a7f0
	jr z,L_A7F5		;a7f1
	ld b,005h		;a7f3
L_A7F5:
	jp L_A911		;a7f5
L_A7F8:
	xor a			;a7f8
	ld (0e52ch),a		;a7f9
	ld a,(0e500h)		;a7fc
	cp 005h		;a7ff
	ret z			;a801
	cp 006h		;a802
	ret z			;a804
	ld b,006h		;a805
	ld hl,0e4a2h		;a807
L_A80A:
	bit 2,(hl)		;a80a
	jr nz,L_A84A		;a80c
	ld de,00010h		;a80e
	add hl,de			;a811
	djnz L_A80A		;a812
	dec a			;a814
	jr nz,L_A81F		;a815
	ld a,(0e52bh)		;a817
	and a			;a81a
	jr z,L_A82A		;a81b
	jr L_A823		;a81d
L_A81F:
	cp 002h		;a81f
	jr nz,L_A82A		;a821
L_A823:
	ld a,(0e505h)		;a823
	cp 028h		;a826
	jr c,L_A84E		;a828
L_A82A:
	ld a,(0e505h)		;a82a
	cp 0c0h		;a82d
	jr nc,L_A865		;a82f
	ld a,(0e507h)		;a831
	cp 010h		;a834
	jr c,L_A874		;a836
	cp 0f8h		;a838
	ret c			;a83a
	ld a,(0e64bh)		;a83b
	inc a			;a83e
	jr z,L_A881		;a83f
	call L_A897		;a841
	ld a,004h		;a844
L_A846:
	ld (0e01ah),a		;a846
	ret			;a849
L_A84A:
	bit 1,(hl)		;a84a
	jr z,L_A865		;a84c
L_A84E:
	ld a,(0e648h)		;a84e
	inc a			;a851
	ret z			;a852
	ld b,a			;a853
	ld a,(0e52bh)		;a854
	and a			;a857
	jr z,L_A85D		;a858
	ld (0e52ch),a		;a85a
L_A85D:
	ld a,b			;a85d
	call L_A897		;a85e
	ld a,001h		;a861
	jr L_A846		;a863
L_A865:
	ld a,(0e649h)		;a865
	inc a			;a868
	ret z			;a869
	call L_A897		;a86a
	ld a,002h		;a86d
	jr L_A846		;a86f
L_A871:
	jp L_B337		;a871
L_A874:
	ld a,(0e64ah)		;a874
	inc a			;a877
	jr z,L_A88B		;a878
	call L_A897		;a87a
	ld a,003h		;a87d
	jr L_A846		;a87f
L_A881:
	ld a,(0e507h)		;a881
	cp 0f8h		;a884
	ret c			;a886
	ld a,0f8h		;a887
	jr L_A893		;a889
L_A88B:
	ld a,(0e507h)		;a88b
	cp 010h		;a88e
	ret nc			;a890
	ld a,00fh		;a891
L_A893:
	ld (0e507h),a		;a893
	ret			;a896
L_A897:
	cp 0f6h		;a897
	ret c			;a899
	ld a,002h		;a89a
	ld (0e01fh),a		;a89c
	ret			;a89f
L_A8A0:
	ld a,(0e041h)		;a8a0
	cp 009h		;a8a3
	ret nz			;a8a5
	ld a,(0e082h)		;a8a6
	or a			;a8a9
	ret nz			;a8aa
	ld a,(0e009h)		;a8ab
	call L_A8BE		;a8ae
	ld (0e009h),a		;a8b1
	ld a,(0e008h)		;a8b4
	call L_A8BE		;a8b7
	ld (0e008h),a		;a8ba
	ret			;a8bd
L_A8BE:
	ld b,a			;a8be
	rla			;a8bf
	and 008h		;a8c0
	ld c,a			;a8c2
	ld a,b			;a8c3
	rra			;a8c4
	and 004h		;a8c5
	or c			;a8c7
	ld c,a			;a8c8
	ld a,b			;a8c9
	and 0f3h		;a8ca
	or c			;a8cc
	ret			;a8cd
L_A8CE:
	ld a,(0ec12h)		;a8ce
	ld c,a			;a8d1
	ld a,(0ec22h)		;a8d2
	or c			;a8d5
	bit 0,a		;a8d6
	ret			;a8d8
L_A8D9:
	ld hl,0e52eh		;a8d9
	ld a,(0e009h)		;a8dc
	and 00fh		;a8df
	ld b,a			;a8e1
	jr z,L_A8F0		;a8e2
	ld a,(0e008h)		;a8e4
	and 00fh		;a8e7
	jr nz,L_A8F0		;a8e9
	ld a,b			;a8eb
	and (hl)			;a8ec
	jr nz,L_A8F0		;a8ed
	ld a,b			;a8ef
L_A8F0:
	ld (hl),a			;a8f0
	ret			;a8f1
L_A8F2:
	ld a,(0e533h)		;a8f2
	and a			;a8f5
	ret z			;a8f6
	ld hl,0e532h		;a8f7
	dec (hl)			;a8fa
	ret nz			;a8fb
L_A8FC:
	xor a			;a8fc
	ld (0e533h),a		;a8fd
	ld (0e518h),a		;a900
	ret			;a903
L_A904:
	ld a,(0e502h)		;a904
	ld (0e50dh),a		;a907
L_A90A:
	ld a,(0e503h)		;a90a
	and a			;a90d
	jr z,L_A911		;a90e
	inc b			;a910
L_A911:
	ld a,b			;a911
L_A912:
	ld (0e502h),a		;a912
	ret			;a915
L_A916:
	ld ix,0ec10h		;a916
	exx			;a91a
	ld b,002h		;a91b
	ld de,00010h		;a91d
L_A920:
	exx			;a920
	call L_A92B		;a921
	exx			;a924
	add ix,de		;a925
	djnz L_A920		;a927
	exx			;a929
	ret			;a92a
L_A92B:
	ld a,(ix+000h)		;a92b
	and a			;a92e
	ret z			;a92f
	bit 0,(ix+002h)		;a930
	ret z			;a934
	ld l,(ix+004h)		;a935
	ld h,(ix+005h)		;a938
	ld (0e504h),hl		;a93b
	bit 7,(ix+002h)		;a93e
	ret nz			;a942
	ld c,(ix+00ah)		;a943
	ld b,(ix+00bh)		;a946
L_A949:
	ld hl,(0e506h)		;a949
L_A94C:
	add hl,bc			;a94c
	ld (0e506h),hl		;a94d
	ret			;a950

; ----------------------------------------------------------------------
; DATOS curva_del_salto: los pasos en Y del salto (de 0xFA a 6: sube, para y
;   baja), uno por cuadro con 0xE50A: Afrodita los lee desde 0xA951 (26 pasos,
;   p03:A3FD) y Popolon desde 0xA953 (24, p03:A3F6)
;   0xa951..0xa96d  (28 bytes)
DATA_curva_del_salto:
	defb 0fah,0fah,0fah,0fah,0fah,0fbh,0fbh,0fch,0fch,0fdh,0feh,0ffh,000h,000h,000h,000h	; a951  ................
	defb 001h,002h,003h,004h,004h,005h,005h,006h,006h,006h,006h,006h	; a961  ............

; ======================================================================
; CODIGO 0xa96d..0xaa18  (171 bytes)
; ======================================================================


L_A96D:
	ld iy,0e5a0h		;a96d
	call L_A9AE		;a971
	jr L_A97D		;a974
L_A976:
	ld iy,0e540h		;a976
	call L_A995		;a97a
L_A97D:
	ret z			;a97d
	ld b,003h		;a97e
L_A980:
	ld a,(iy+000h)		;a980
	and a			;a983
	jr nz,L_A98D		;a984
	ld a,001h		;a986
	ld (iy+001h),a		;a988
	inc (hl)			;a98b
	ret			;a98c
L_A98D:
	ld de,00020h		;a98d
	add iy,de		;a990
	djnz L_A980		;a992
	ret			;a994
L_A995:
	ld hl,(0e046h)		;a995
	ld a,h			;a998
	or l			;a999
	jr z,L_A9CB		;a99a
	ld b,003h		;a99c
	ld de,0e08ch		;a99e
	ld hl,0e51ch		;a9a1
	ld a,(0e510h)		;a9a4
	dec a			;a9a7
	cp 002h		;a9a8
	jr nc,L_A9C1		;a9aa
	jr L_A9BD		;a9ac
L_A9AE:
	ld hl,(0e046h)		;a9ae
	ld a,h			;a9b1
	or l			;a9b2
	jr z,L_A9CB		;a9b3
	ld b,003h		;a9b5
	ld de,0e08dh		;a9b7
	ld hl,0e51dh		;a9ba
L_A9BD:
	ld a,(de)			;a9bd
	and a			;a9be
	jr nz,L_A9C8		;a9bf
L_A9C1:
	ld a,(0e501h)		;a9c1
	and a			;a9c4
	jr z,L_A9C8		;a9c5
	dec b			;a9c7
L_A9C8:
	ld a,(hl)			;a9c8
	cp b			;a9c9
	ret c			;a9ca
L_A9CB:
	ld b,000h		;a9cb
	xor a			;a9cd
	ret			;a9ce
L_A9CF:
	call L_AD3A		;a9cf
	ld iy,0e540h		;a9d2
	exx			;a9d6
	ld b,006h		;a9d7
	ld de,00020h		;a9d9
L_A9DC:
	exx			;a9dc
	call L_AA0A		;a9dd
	exx			;a9e0
	add iy,de		;a9e1
	djnz L_A9DC		;a9e3
	exx			;a9e5
	ld iy,0e540h		;a9e6
	ld hl,0e51ch		;a9ea
	call L_A9F7		;a9ed
	ld iy,0e5a0h		;a9f0
	ld hl,0e51dh		;a9f4
L_A9F7:
	ld (hl),000h		;a9f7
	ld b,003h		;a9f9
	ld de,00020h		;a9fb
L_A9FE:
	ld a,(iy+000h)		;a9fe
	and a			;aa01
	jr z,L_AA05		;aa02
	inc (hl)			;aa04
L_AA05:
	add iy,de		;aa05
	djnz L_A9FE		;aa07
	ret			;aa09
L_AA0A:
	bit 1,(iy+002h)		;aa0a
	ret nz			;aa0e
	ld a,(iy+000h)		;aa0f
	and a			;aa12
	ret z			;aa13
	dec a			;aa14
	call 04140h		;aa15

; ----------------------------------------------------------------------
; DATOS tabla_AA18: 5 destinos del despachador de 0x4140 (call en p03:AA15):
;   0xAA22, 0xAAC8, 0xAAF2, 0xABFB, 0xAC92; lo leen p03:AA15 (10 bytes)
;   0xaa18..0xaa22  (10 bytes)
DATA_tabla_AA18:
	defb 022h,0aah	; aa18
	defb 0c8h,0aah	; aa1a
	defb 0f2h,0aah	; aa1c
	defb 0fbh,0abh	; aa1e
	defb 092h,0ach	; aa20

; ======================================================================
; CODIGO 0xaa22..0xad2e  (780 bytes)
; ======================================================================


L_AA22:
	ld a,(iy+001h)		;aa22
	dec a			;aa25
	jp nz,L_AAA5		;aa26
	ld a,(0e500h)		;aa29
	cp 004h		;aa2c
	jp nc,L_AD76		;aa2e
	ld a,(0e503h)		;aa31
	cp 002h		;aa34
	jp nc,L_AD76		;aa36
	ld bc,00800h		;aa39
	ld de,0440fh		;aa3c
	ld a,(0e503h)		;aa3f
	and a			;aa42
	jr z,L_AA49		;aa43
	ld b,0f8h		;aa45
	ld d,04bh		;aa47
L_AA49:
	ld (iy+010h),a		;aa49
	ld (iy+00eh),c		;aa4c
	ld (iy+00fh),b		;aa4f
	ld a,001h		;aa52
	ld (iy+002h),a		;aa54
	ld (iy+00ah),d		;aa57
	ld (iy+00bh),e		;aa5a
	ld a,(0e505h)		;aa5d
	sub 008h		;aa60
	and 0f8h		;aa62
	cp 020h		;aa64
	jr nc,L_AA6A		;aa66
	ld a,020h		;aa68
L_AA6A:
	ld (iy+005h),a		;aa6a
	ld a,(0e503h)		;aa6d
	and a			;aa70
	ld b,0f8h		;aa71
	jr nz,L_AA77		;aa73
	ld b,000h		;aa75
L_AA77:
	ld a,(0e507h)		;aa77
	add a,b			;aa7a
	ld (iy+007h),a		;aa7b
	inc (iy+001h)		;aa7e
	ld a,(iy+000h)		;aa81
	dec a			;aa84
	ld a,015h		;aa85
	jr nz,L_AA8B		;aa87
	ld a,014h		;aa89
L_AA8B:
	call 04e1fh		;aa8b
L_AA8E:
	ld a,(0e0d2h)		;aa8e
	or a			;aa91
	jr z,L_AA99		;aa92
	ld a,(0e078h)		;aa94
	or a			;aa97
	ret nz			;aa98
L_AA99:
	ld hl,0e046h		;aa99
	ld bc,00001h		;aa9c
	call 09234h		;aa9f
	jp 05f79h		;aaa2
L_AAA5:
	ld a,(iy+007h)		;aaa5
	bit 7,(iy+00fh)		;aaa8
	jr z,L_AAAF		;aaac
	dec a			;aaae
L_AAAF:
	ld h,a			;aaaf
	ld l,(iy+005h)		;aab0
	call L_ADDA		;aab3
	jp c,L_AD76		;aab6
	inc hl			;aab9
	call L_ADDD		;aaba
	jp c,L_AD76		;aabd
	ret			;aac0
L_AAC1:
	inc hl			;aac1
	call L_ADDD		;aac2
	jp c,L_AD76		;aac5
L_AAC8:
	ld a,(iy+001h)		;aac8
	dec a			;aacb
	jr nz,L_AAA5		;aacc
	ld a,(0e500h)		;aace
	cp 004h		;aad1
	jp nc,L_AD76		;aad3
	ld a,(0e503h)		;aad6
	cp 002h		;aad9
	jp nc,L_AD76		;aadb
	ld bc,00400h		;aade
	ld de,0460fh		;aae1
	ld a,(0e503h)		;aae4
	and a			;aae7
	jp z,L_AA49		;aae8
	ld b,0fch		;aaeb
	ld d,04dh		;aaed
	jp L_AA49		;aaef
L_AAF2:
	ld b,04ch		;aaf2
	call L_AE27		;aaf4
	ld a,(iy+001h)		;aaf7
	dec a			;aafa
	jr nz,L_AB47		;aafb
	call L_AE8D		;aafd
	jp nz,L_AD76		;ab00
	ld hl,(0e504h)		;ab03
	ld (iy+004h),l		;ab06
	ld a,h			;ab09
	sub 008h		;ab0a
	ld (iy+005h),a		;ab0c
	ld hl,(0e506h)		;ab0f
	ld a,h			;ab12
	sub 004h		;ab13
	ld (iy+006h),l		;ab15
	ld (iy+007h),a		;ab18
	ld (iy+017h),a		;ab1b
	ld a,(0e503h)		;ab1e
	ld (iy+010h),a		;ab21
	ld b,004h		;ab24
	and a			;ab26
	jr z,L_AB2B		;ab27
	ld b,0fch		;ab29
L_AB2B:
	ld (iy+00fh),b		;ab2b
	ld (iy+019h),b		;ab2e
	ld a,001h		;ab31
	ld (iy+002h),a		;ab33
	ld (iy+01ah),a		;ab36
	ld (iy+014h),080h		;ab39
	ld (iy+00bh),00ah		;ab3d
	inc (iy+001h)		;ab41
	jp L_ACD6		;ab44
L_AB47:
	dec a			;ab47
	jr nz,L_AB81		;ab48
	call L_ADC5		;ab4a
	jp c,L_AD76		;ab4d
	ld a,(iy+01ah)		;ab50
	and a			;ab53
	jr nz,L_AB6D		;ab54
	ld a,(iy+007h)		;ab56
	bit 7,(iy+00fh)		;ab59
	jr z,L_AB67		;ab5d
	cp (iy+017h)		;ab5f
	jp c,L_AD76		;ab62
	jr L_AB6D		;ab65
L_AB67:
	cp (iy+017h)		;ab67
	jp nc,L_AD76		;ab6a
L_AB6D:
	ld b,008h		;ab6d
	call L_ADB9		;ab6f
	ret c			;ab72
	call L_AE3A		;ab73
	ld (iy+00dh),004h		;ab76
	ld (iy+00fh),000h		;ab7a
	jp L_AD00		;ab7e
L_AB81:
	dec a			;ab81
	jr nz,L_ABE0		;ab82
	ld a,(iy+01ah)		;ab84
	and a			;ab87
	jp z,L_AD76		;ab88
	bit 7,(iy+00dh)		;ab8b
	jr nz,L_AB98		;ab8f
	ld b,008h		;ab91
	call L_AE15		;ab93
	jr L_AB9D		;ab96
L_AB98:
	ld b,0ffh		;ab98
	call L_AE15		;ab9a
L_AB9D:
	jp c,L_AD76		;ab9d
	bit 7,(iy+019h)		;aba0
	jr nz,L_ABAE		;aba4
	ld b,0ffh		;aba6
	call L_ADE1		;aba8
	ret c			;abab
	jr L_ABB4		;abac
L_ABAE:
	ld b,008h		;abae
	call L_ADE1		;abb0
	ret c			;abb3
L_ABB4:
	call L_AC89		;abb4
	ld a,(iy+010h)		;abb7
	xor 001h		;abba
	ld (iy+010h),a		;abbc
	bit 7,(iy+00dh)		;abbf
	jr z,L_ABCD		;abc3
	dec (iy+001h)		;abc5
	dec (iy+01ah)		;abc8
	jr L_ABD0		;abcb
L_ABCD:
	inc (iy+001h)		;abcd
L_ABD0:
	ld a,(iy+019h)		;abd0
	neg		;abd3
	ld (iy+019h),a		;abd5
	ld (iy+00fh),a		;abd8
	ld (iy+00dh),000h		;abdb
	ret			;abdf
L_ABE0:
	call L_ADC5		;abe0
	jp c,L_AD76		;abe3
	ld b,0ffh		;abe6
	call L_ADB9		;abe8
	ret c			;abeb
	call L_AE3A		;abec
	ld (iy+00dh),0fch		;abef
	ld (iy+00fh),000h		;abf3
	dec (iy+001h)		;abf7
	ret			;abfa
L_ABFB:
	ld a,(iy+001h)		;abfb
	dec a			;abfe
	jr nz,L_AC40		;abff
	call L_AE92		;ac01
	jp nz,L_AD76		;ac04
	ld a,(0e505h)		;ac07
	sub 008h		;ac0a
	ld (iy+005h),a		;ac0c
	ld a,(0e507h)		;ac0f
	sub 008h		;ac12
	ld (iy+007h),a		;ac14
	ld bc,03004h		;ac17
	ld a,(0e503h)		;ac1a
	ld (iy+010h),a		;ac1d
	and a			;ac20
	jr z,L_AC26		;ac21
	ld bc,088fch		;ac23
L_AC26:
	ld (iy+019h),c		;ac26
	ld (iy+00ah),b		;ac29
	ld a,00ah		;ac2c
	ld (iy+00bh),a		;ac2e
	ld a,001h		;ac31
	ld (iy+002h),a		;ac33
	ld (iy+014h),080h		;ac36
	inc (iy+001h)		;ac3a
	jp L_ACD6		;ac3d
L_AC40:
	ex af,af'			;ac40
	ld a,(iy+010h)		;ac41
	ld b,030h		;ac44
	and a			;ac46
	jr z,L_AC4B		;ac47
	ld b,088h		;ac49
L_AC4B:
	call L_AE27		;ac4b
	ex af,af'			;ac4e
	dec a			;ac4f
	jr nz,L_AC80		;ac50
	call L_ADC5		;ac52
	jp c,L_AD76		;ac55
	ld a,(iy+018h)		;ac58
	ld (iy+00eh),a		;ac5b
	ld a,(iy+019h)		;ac5e
	ld (iy+00fh),a		;ac61
	xor a			;ac64
	ld (iy+00ch),a		;ac65
	ld (iy+00dh),a		;ac68
	ld b,004h		;ac6b
	call L_ADB9		;ac6d
	ret c			;ac70
	xor a			;ac71
	ld (iy+00eh),a		;ac72
	ld (iy+00fh),a		;ac75
	ld a,004h		;ac78
	ld (iy+00dh),a		;ac7a
	jp L_AD00		;ac7d
L_AC80:
	ld b,004h		;ac80
	call L_ADB9		;ac82
	ret nc			;ac85
	dec (iy+001h)		;ac86
L_AC89:
	ld a,(iy+005h)		;ac89
	and 0f8h		;ac8c
	ld (iy+005h),a		;ac8e
	ret			;ac91
L_AC92:
	ld a,(iy+001h)		;ac92
	dec a			;ac95
	jr nz,L_ACDE		;ac96
	call L_AE8D		;ac98
	jp nz,L_AD76		;ac9b
	ld a,(0e505h)		;ac9e
	ld l,a			;aca1
	sub 004h		;aca2
	ld (iy+005h),a		;aca4
	ld a,(0e507h)		;aca7
	sub 008h		;acaa
	ld (iy+007h),a		;acac
	ld h,a			;acaf
	push hl			;acb0
	ld a,002h		;acb1
	add a,h			;acb3
	ld h,a			;acb4
	call 04dc8h		;acb5
	pop hl			;acb8
	jp nc,L_AD76		;acb9
	ld a,00dh		;acbc
	add a,h			;acbe
	ld h,a			;acbf
	call 04dc8h		;acc0
	jp nc,L_AD76		;acc3
	ld (iy+014h),080h		;acc6
	inc (iy+001h)		;acca
	ld de,0540fh		;accd
	ld (iy+00ah),d		;acd0
	ld (iy+00bh),e		;acd3
L_ACD6:
	ld a,016h		;acd6
	call 04e1fh		;acd8
	jp L_AA8E		;acdb
L_ACDE:
	dec a			;acde
	jr nz,L_AD04		;acdf
	ld a,(0e505h)		;ace1
	sub (iy+005h)		;ace4
	jr c,L_ACF9		;ace7
	cp 015h		;ace9
	jr nc,L_ACF9		;aceb
	ld a,(0e507h)		;aced
	sub (iy+007h)		;acf0
	add a,008h		;acf3
	ret c			;acf5
	cp 021h		;acf6
	ret c			;acf8
L_ACF9:
	xor a			;acf9
	ld (iy+01ah),a		;acfa
	inc (iy+002h)		;acfd
L_AD00:
	inc (iy+001h)		;ad00
	ret			;ad03
L_AD04:
	bit 2,(iy+002h)		;ad04
	jr nz,$+44		;ad08
	inc (iy+008h)		;ad0a
	ld a,(iy+008h)		;ad0d
	and 003h		;ad10
	ret nz			;ad12
	inc (iy+01ah)		;ad13
	ld a,(iy+01ah)		;ad16
	cp 006h		;ad19
	jr nz,L_AD21		;ad1b
	xor a			;ad1d
	ld (iy+01ah),a		;ad1e
L_AD21:
	ld hl,0ad2eh		;ad21
	add a,l			;ad24
	ld l,a			;ad25
	jr nc,L_AD29		;ad26
	inc h			;ad28
L_AD29:
	ld a,(hl)			;ad29
	ld (iy+00bh),a		;ad2a
	ret			;ad2d

; ----------------------------------------------------------------------
; DATOS seis_colores_ad2e: 6 colores que p03:AD21 pone en (iy+0x0B) por turnos
;   ((iy+0x1A) = 0-5)
;   0xad2e..0xad34  (6 bytes)
DATA_seis_colores_ad2e:
	defb 00fh,007h,005h,004h,005h,007h	; ad2e

; ======================================================================
; CODIGO 0xad34..0xb3ae  (1658 bytes)
; ======================================================================


L_AD34:
	dec (iy+008h)		;ad34
	ret nz			;ad37
	jr L_AD76		;ad38
L_AD3A:
	ld a,(0e510h)		;ad3a
	cp 006h		;ad3d
	ret nz			;ad3f
	ld a,(0e008h)		;ad40
	and 020h		;ad43
	ret z			;ad45
	ld a,001h		;ad46
	ld (0e517h),a		;ad48
	ret			;ad4b
L_AD4C:
	ld iy,0e540h		;ad4c
	exx			;ad50
	ld b,006h		;ad51
	ld de,00020h		;ad53
L_AD56:
	exx			;ad56
	call L_AD61		;ad57
	exx			;ad5a
	add iy,de		;ad5b
	djnz L_AD56		;ad5d
	exx			;ad5f
	ret			;ad60
L_AD61:
	ld a,(iy+000h)		;ad61
	and a			;ad64
	ret z			;ad65
	call L_AD92		;ad66
	ld a,h			;ad69
	sub 008h		;ad6a
	cp 0f0h		;ad6c
	jr nc,L_AD76		;ad6e
	ld a,(iy+005h)		;ad70
	cp 0b8h		;ad73
	ret c			;ad75
L_AD76:
	ld a,(iy+000h)		;ad76
	cp 005h		;ad79
	ld hl,0e51ch		;ad7b
	jr nz,L_AD83		;ad7e
	ld hl,0e51dh		;ad80
L_AD83:
	dec (hl)			;ad83
	push iy		;ad84
	pop hl			;ad86
	ld e,l			;ad87
	ld d,h			;ad88
	inc de			;ad89
	ld (hl),000h		;ad8a
	ld bc,0001fh		;ad8c
	ldir		;ad8f
	ret			;ad91
L_AD92:
	ld l,(iy+004h)		;ad92
	ld h,(iy+005h)		;ad95
	ld e,(iy+00ch)		;ad98
	ld d,(iy+00dh)		;ad9b
	add hl,de			;ad9e
	ld (iy+004h),l		;ad9f
	ld (iy+005h),h		;ada2
	ld l,(iy+006h)		;ada5
	ld h,(iy+007h)		;ada8
	ld e,(iy+00eh)		;adab
	ld d,(iy+00fh)		;adae
	add hl,de			;adb1
	ld (iy+006h),l		;adb2
	ld (iy+007h),h		;adb5
	ret			;adb8
L_ADB9:
	ld h,(iy+007h)		;adb9
	ld l,(iy+005h)		;adbc
	ld de,00008h		;adbf
	jp 054ffh		;adc2
L_ADC5:
	ld a,(iy+007h)		;adc5
	bit 7,(iy+00fh)		;adc8
	ld b,008h		;adcc
	jr z,L_ADD2		;adce
	ld b,0ffh		;add0
L_ADD2:
	add a,b			;add2
	ld h,a			;add3
	ld a,(iy+005h)		;add4
	add a,002h		;add7
	ld l,a			;add9
L_ADDA:
	call 04da1h		;adda
L_ADDD:
	ld a,0b9h		;addd
	cp (hl)			;addf
	ret			;ade0
L_ADE1:
	ld h,(iy+007h)		;ade1
	ld l,(iy+005h)		;ade4
	ld a,(iy+000h)		;ade7
	ld de,00103h		;adea
	cp 003h		;aded
	jp nz,0551fh		;adef
	ld e,007h		;adf2
	jp 0551fh		;adf4
L_ADF7:
	ld b,010h		;adf7
	ld a,(iy+00fh)		;adf9
	and a			;adfc
	ret z			;adfd
	bit 7,a		;adfe
	jr z,L_AE04		;ae00
	ld b,000h		;ae02
L_AE04:
	ld l,(iy+005h)		;ae04
	ld h,(iy+007h)		;ae07
	or a			;ae0a
	bit 7,(iy+014h)		;ae0b
	ret nz			;ae0f
	ld e,000h		;ae10
	jp 0553eh		;ae12
L_AE15:
	ld a,(iy+007h)		;ae15
	add a,004h		;ae18
	ld h,a			;ae1a
	ld a,(iy+005h)		;ae1b
	add a,b			;ae1e
	ld l,a			;ae1f
	jp 04dc8h		;ae20
L_AE23:
	ld c,000h		;ae23
	jr L_AE29		;ae25
L_AE27:
	ld c,001h		;ae27
L_AE29:
	ld a,(0e604h)		;ae29
L_AE2C:
	dec c			;ae2c
	jp m,L_AE33		;ae2d
	rra			;ae30
	jr L_AE2C		;ae31
L_AE33:
	and 004h		;ae33
	add a,b			;ae35
	ld (iy+00ah),a		;ae36
	ret			;ae39
L_AE3A:
	ld a,(iy+007h)		;ae3a
	and 0f8h		;ae3d
	bit 7,(iy+00fh)		;ae3f
	jr z,L_AE47		;ae43
	add a,008h		;ae45
L_AE47:
	ld (iy+007h),a		;ae47
	ret			;ae4a
L_AE4B:
	set 2,(iy+002h)		;ae4b
	ld (iy+008h),046h		;ae4f
	ld a,(iy+005h)		;ae53
	sub 00ch		;ae56
	ld (iy+005h),a		;ae58
	ld a,(iy+007h)		;ae5b
	sub 008h		;ae5e
	ld (iy+007h),a		;ae60
	ld a,026h		;ae63
	jp 04e1fh		;ae65
L_AE68:
	set 1,(iy+002h)		;ae68
	res 0,(iy+002h)		;ae6c
	ld e,(iy+00eh)		;ae70
	ld d,(iy+00fh)		;ae73
	call 0415ch		;ae76
	ld (iy+00eh),e		;ae79
	ld (iy+00fh),d		;ae7c
	ld de,0f800h		;ae7f
	ld (iy+00ch),e		;ae82
	ld (iy+00dh),d		;ae85
L_AE88:
	ld a,01dh		;ae88
	jp 04e1fh		;ae8a
L_AE8D:
	ld a,(0e52ah)		;ae8d
	and a			;ae90
	ret nz			;ae91
L_AE92:
	ld a,(0e500h)		;ae92
	and a			;ae95
	ret nz			;ae96
	jp L_A8CE		;ae97
L_AE9A:
	ld a,(0e501h)		;ae9a
	or a			;ae9d
	ld hl,0e053h		;ae9e
	jr z,L_AEA5		;aea1
	ld l,057h		;aea3
L_AEA5:
	ld a,(hl)			;aea5
	cp 048h		;aea6
	ret nc			;aea8
	add a,008h		;aea9
	ld (hl),a			;aeab
	call 0604dh		;aeac
	ld a,001h		;aeaf
	ld (0e61eh),a		;aeb1
	call L_B301		;aeb4
	xor a			;aeb7
	ld (0e61eh),a		;aeb8
	ret			;aebb
L_AEBC:
	exx			;aebc
	ld b,000h		;aebd
	exx			;aebf
	call L_AFB5		;aec0
	exx			;aec3
	rl b		;aec4
	exx			;aec6
	call L_AFC5		;aec7
	exx			;aeca
	rl b		;aecb
	exx			;aecd
	call L_AFE7		;aece
	exx			;aed1
	rl b		;aed2
	exx			;aed4
	call L_AFD5		;aed5
	exx			;aed8
	rl b		;aed9
	ld a,b			;aedb
	ld (0e519h),a		;aedc
	exx			;aedf
	ret			;aee0
L_AEE1:
	ld a,(0e507h)		;aee1
	sub 008h		;aee4
	ld h,a			;aee6
	ld a,(0e505h)		;aee7
	dec a			;aeea
	ld l,a			;aeeb
	ld c,004h		;aeec
	ld b,000h		;aeee
	jr L_AF02		;aef0
L_AEF2:
	ld a,(0e507h)		;aef2
	sub 008h		;aef5
	ld h,a			;aef7
	ld a,(0e505h)		;aef8
	add a,008h		;aefb
	ld l,a			;aefd
	ld c,004h		;aefe
	ld b,001h		;af00
L_AF02:
	push hl			;af02
	ld a,h			;af03
	add a,c			;af04
	ld h,a			;af05
	call 04da1h		;af06
	ld a,(hl)			;af09
	pop hl			;af0a
	sub 09ah		;af0b
	cp 002h		;af0d
	ret nc			;af0f
	ld a,010h		;af10
	sub c			;af12
	ld c,a			;af13
	ld a,h			;af14
	add a,c			;af15
	ld h,a			;af16
	push hl			;af17
	call 04da1h		;af18
	ld a,(hl)			;af1b
	pop hl			;af1c
	sub 09ah		;af1d
	cp 002h		;af1f
	ret nc			;af21
	ld a,h			;af22
	and 0f8h		;af23
	ld (0e507h),a		;af25
	xor a			;af28
	ld (0e525h),a		;af29
	ld c,b			;af2c
	ld b,004h		;af2d
	ld hl,0e0b0h		;af2f
L_AF32:
	ld a,(hl)			;af32
	and a			;af33
	push hl			;af34
	push bc			;af35
	call z,L_AF41		;af36
	pop bc			;af39
	pop hl			;af3a
	inc hl			;af3b
	inc hl			;af3c
	djnz L_AF32		;af3d
	scf			;af3f
	ret			;af40
L_AF41:
	ld hl,0ec00h		;af41
	ld a,(hl)			;af44
	and a			;af45
	jr z,L_AF7B		;af46
	inc hl			;af48
	ld a,(hl)			;af49
	ld b,a			;af4a
	bit 0,c		;af4b
	jr nz,L_AF63		;af4d
	ld a,(0e505h)		;af4f
	sub b			;af52
	inc hl			;af53
	inc hl			;af54
	inc hl			;af55
	push af			;af56
	ld a,(hl)			;af57
	sub 008h		;af58
	ld b,a			;af5a
	pop af			;af5b
	cp b			;af5c
	jr nz,L_AF7B		;af5d
	dec hl			;af5f
	dec hl			;af60
	jr L_AF6E		;af61
L_AF63:
	ld a,b			;af63
	sub 008h		;af64
	ld b,a			;af66
	ld a,(0e505h)		;af67
	sub b			;af6a
	jr nz,L_AF7B		;af6b
	inc hl			;af6d
L_AF6E:
	ld a,(0e507h)		;af6e
	sub (hl)			;af71
	cp 011h		;af72
	ccf			;af74
	ret c			;af75
	ld a,001h		;af76
	ld (0e525h),a		;af78
L_AF7B:
	scf			;af7b
	ret			;af7c
L_AF7D:
	ld de,00000h		;af7d
	ld (0e51eh),de		;af80
	ld a,(0e515h)		;af84
	ld b,a			;af87
	ld a,(0e500h)		;af88
	cp 001h		;af8b
	call z,L_AFAD		;af8d
	add a,b			;af90
	dec a			;af91
	ret z			;af92
	ld a,(0e519h)		;af93
	bit 0,a		;af96
	ld a,(0e507h)		;af98
	ld c,a			;af9b
	jr nz,L_AFA7		;af9c
	ld a,(0e51ah)		;af9e
	and a			;afa1
	ld a,c			;afa2
	jr z,L_AFA7		;afa3
	add a,008h		;afa5
L_AFA7:
	and 0f8h		;afa7
	ld (0e507h),a		;afa9
	ret			;afac
L_AFAD:
	ex af,af'			;afad
	ld a,001h		;afae
	ld (0e50eh),a		;afb0
	ex af,af'			;afb3
	ret			;afb4
L_AFB5:
	ld a,(0e507h)		;afb5
	ld h,a			;afb8
	ld a,(0e505h)		;afb9
	ld l,a			;afbc
	ld b,000h		;afbd
	ld de,0fc04h		;afbf
	jp 054ffh		;afc2
L_AFC5:
	ld a,(0e507h)		;afc5
	ld h,a			;afc8
	ld a,(0e505h)		;afc9
	ld l,a			;afcc
	ld b,0f0h		;afcd
	ld de,0fc04h		;afcf
	jp 054ffh		;afd2
L_AFD5:
	ld a,(0e507h)		;afd5
	ld h,a			;afd8
	ld b,008h		;afd9
L_AFDB:
	ld a,(0e505h)		;afdb
	sub 008h		;afde
	ld l,a			;afe0
	ld de,0ff07h		;afe1
	jp 0551fh		;afe4
L_AFE7:
	xor a			;afe7
	ld (0e51ah),a		;afe8
	ld a,(0e507h)		;afeb
	ld h,a			;afee
	ld b,0f8h		;afef
	call L_AFDB		;aff1
	jr c,L_AFFF		;aff4
	ld a,(0e507h)		;aff6
	ld h,a			;aff9
	ld b,0f7h		;affa
	jp L_AFDB		;affc
L_AFFF:
	ld a,001h		;afff
	ld (0e51ah),a		;b001
	ret			;b004
L_B005:
	ld a,(0e511h)		;b005
	ld (0f030h),a		;b008
	xor a			;b00b
	ld (0e511h),a		;b00c
	ld (0e52ah),a		;b00f
	ld a,(0e507h)		;b012
	ld h,a			;b015
	ld a,(0e505h)		;b016
	ld l,a			;b019
	call 04da1h		;b01a
	ld a,(0e519h)		;b01d
	bit 3,a		;b020
	jr z,L_B028		;b022
	ld de,0ffe0h		;b024
	add hl,de			;b027
L_B028:
	ld a,(hl)			;b028
	sub 0b6h		;b029
	jr z,L_B037		;b02b
	dec a			;b02d
	jr z,L_B058		;b02e
	cp 003h		;b030
	ret nc			;b032
	ld a,002h		;b033
	jr L_B05A		;b035
L_B037:
	ld a,(0e07fh)		;b037
	and a			;b03a
	jr z,L_B058		;b03b
	ld hl,(0e041h)		;b03d
	ld a,l			;b040
	cp 006h		;b041
	jr nz,L_B058		;b043
	ld a,h			;b045
	sub 00ch		;b046
	cp 002h		;b048
	jr nc,L_B058		;b04a
	ld a,001h		;b04c
	ld (0e52ah),a		;b04e
L_B051:
	ld hl,0e519h		;b051
	set 3,(hl)		;b054
	xor a			;b056
	ret			;b057
L_B058:
	ld a,001h		;b058
L_B05A:
	ld (0e511h),a		;b05a
	ld hl,0f030h		;b05d
	cp (hl)			;b060
	jr z,L_B068		;b061
	ld a,024h		;b063
	call 04e1fh		;b065
L_B068:
	call 044eah		;b068
	ccf			;b06b
	ret nc			;b06c
	ld a,(0e501h)		;b06d
	or a			;b070
	ld bc,0fe03h		;b071
	jr z,L_B078		;b074
	ld b,000h		;b076
L_B078:
	ld a,(0e511h)		;b078
	dec a			;b07b
	ld a,b			;b07c
	jr z,L_B080		;b07d
	ld a,c			;b07f
L_B080:
	ld hl,0e524h		;b080
	inc (hl)			;b083
	cp (hl)			;b084
	jr nc,L_B093		;b085
	ld (hl),000h		;b087
	ld a,0ffh		;b089
	call 0612ch		;b08b
	ld a,025h		;b08e
	call 04e1fh		;b090
L_B093:
	xor a			;b093
	ret			;b094
L_B095:
	ld ix,0ec10h		;b095
	exx			;b099
	ld b,002h		;b09a
	ld de,00010h		;b09c
L_B09F:
	exx			;b09f
	call L_B0C2		;b0a0
	exx			;b0a3
	add ix,de		;b0a4
	djnz L_B09F		;b0a6
	exx			;b0a8
	ld a,(0ec10h)		;b0a9
	and a			;b0ac
	ret z			;b0ad
	ld c,a			;b0ae
	ld a,006h		;b0af
	sub c			;b0b1
	add a,a			;b0b2
	add a,a			;b0b3
	add a,a			;b0b4
	add a,a			;b0b5
	ld hl,0e4a2h		;b0b6
	ld c,a			;b0b9
	ld b,000h		;b0ba
	add hl,bc			;b0bc
	ld a,(0ec12h)		;b0bd
	ld (hl),a			;b0c0
	ret			;b0c1
L_B0C2:
	ld a,(ix+002h)		;b0c2
	ld (0f000h),a		;b0c5
	res 0,(ix+002h)		;b0c8
	ld a,(ix+000h)		;b0cc
	and a			;b0cf
	ret z			;b0d0
	bit 3,(ix+002h)		;b0d1
	jr z,L_B0E7		;b0d5
	ld a,(ix+002h)		;b0d7
	sub 010h		;b0da
	ld (ix+002h),a		;b0dc
	and 070h		;b0df
	ret nz			;b0e1
	res 3,(ix+002h)		;b0e2
	ret			;b0e6
L_B0E7:
	ld a,(0e505h)		;b0e7
	sub (ix+005h)		;b0ea
	dec a			;b0ed
	cp 01fh		;b0ee
	jr nc,L_B105		;b0f0
	ld a,(0e507h)		;b0f2
	sub (ix+007h)		;b0f5
	add a,008h		;b0f8
	cp 004h		;b0fa
	jr c,L_B15C		;b0fc
	sub 02dh		;b0fe
	cp 004h		;b100
	call c,L_B166		;b102
L_B105:
	ld a,(0e507h)		;b105
	add a,002h		;b108
	sub (ix+007h)		;b10a
	cp 025h		;b10d
	jr nc,L_B147		;b10f
	ld a,(0e505h)		;b111
	sub (ix+005h)		;b114
	sub 008h		;b117
	jr nc,L_B12D		;b119
	ld a,(0f000h)		;b11b
	bit 0,a		;b11e
	jr nz,L_B128		;b120
	ld hl,0e519h		;b122
	bit 3,(hl)		;b125
	ret nz			;b127
L_B128:
	set 0,(ix+002h)		;b128
	ret			;b12c
L_B12D:
	sub 010h		;b12d
	cp 008h		;b12f
	jr nc,L_B147		;b131
	ld hl,0e519h		;b133
	bit 3,(hl)		;b136
	ret nz			;b138
	ld l,(ix+004h)		;b139
	ld h,(ix+005h)		;b13c
	ld a,h			;b13f
	add a,020h		;b140
	ld h,a			;b142
	ld (0e504h),hl		;b143
	ret			;b146
L_B147:
	ld a,(0f000h)		;b147
	ld c,a			;b14a
	ld b,(ix+002h)		;b14b
	xor b			;b14e
	and c			;b14f
	bit 0,a		;b150
	ret z			;b152
	ld a,(ix+002h)		;b153
	or 078h		;b156
	ld (ix+002h),a		;b158
	ret			;b15b
L_B15C:
	ld a,(ix+007h)		;b15c
	sub 008h		;b15f
	ld (0e507h),a		;b161
	jr L_B105		;b164
L_B166:
	ld a,(ix+007h)		;b166
	add a,028h		;b169
	ld (0e507h),a		;b16b
	ret			;b16e
L_B16F:
	res 0,(ix+002h)		;b16f
	ld a,(0e500h)		;b173
	cp 002h		;b176
	ret nz			;b178
	set 3,(ix+002h)		;b179
	ret			;b17d
L_B17E:
	ld a,(0e52ah)		;b17e
	and a			;b181
	ret z			;b182
	ld hl,(0e506h)		;b183
	ld de,0ff00h		;b186
	add hl,de			;b189
	ld (0e506h),hl		;b18a
	call L_AFE7		;b18d
	ret nc			;b190
	jp L_AF7D		;b191
L_B194:
	ld hl,0e517h		;b194
	ld a,(hl)			;b197
	or a			;b198
	ret z			;b199
	ld (hl),000h		;b19a
	ld hl,0e678h		;b19c
	ld a,(hl)			;b19f
	or a			;b1a0
	ret z			;b1a1
	ld a,(0e505h)		;b1a2
	sub 010h		;b1a5
	inc l			;b1a7
	sub (hl)			;b1a8
	add a,010h		;b1a9
	cp 021h		;b1ab
	ret nc			;b1ad
	ld a,(0e507h)		;b1ae
	inc l			;b1b1
	sub 008h		;b1b2
	sub (hl)			;b1b4
	add a,010h		;b1b5
	cp 021h		;b1b7
	ret nc			;b1b9
	ld a,(0e678h)		;b1ba
	ld (0e01bh),a		;b1bd
	ret			;b1c0
L_B1C1:
	xor a			;b1c1
	ld (0e520h),a		;b1c2
	ld (0e61fh),a		;b1c5
	call L_B8A0		;b1c8
	ld ix,0e800h		;b1cb
	ld a,(0e635h)		;b1cf
	ld (0e623h),a		;b1d2
L_B1D5:
	bit 6,(ix+002h)		;b1d5
	call nz,L_B1ED		;b1d9
	ld a,(0e61fh)		;b1dc
	or a			;b1df
	ret nz			;b1e0
	ld bc,00020h		;b1e1
	add ix,bc		;b1e4
	ld hl,0e623h		;b1e6
	dec (hl)			;b1e9
	jr nz,L_B1D5		;b1ea
	ret			;b1ec
L_B1ED:
	ld a,(ix+000h)		;b1ed
	ld c,a			;b1f0
	sub 05dh		;b1f1
	cp 003h		;b1f3
	jr c,L_B23B		;b1f5
	ld a,(0e518h)		;b1f7
	or a			;b1fa
	ret nz			;b1fb
	ld a,c			;b1fc
	cp 008h		;b1fd
	jr nz,L_B206		;b1ff
	ld a,(0e093h)		;b201
	or a			;b204
	ret nz			;b205
L_B206:
	ld a,c			;b206
	cp 02ah		;b207
	jr nz,L_B210		;b209
	ld a,(0e07dh)		;b20b
	or a			;b20e
	ret nz			;b20f
L_B210:
	ld a,c			;b210
	cp 028h		;b211
	jr nz,L_B21A		;b213
	ld a,(0e07eh)		;b215
	or a			;b218
	ret nz			;b219
L_B21A:
	ld a,c			;b21a
	cp 02eh		;b21b
	jr nz,L_B224		;b21d
	ld a,(0e086h)		;b21f
	or a			;b222
	ret nz			;b223
L_B224:
	ld a,c			;b224
	cp 031h		;b225
	jr nz,L_B22E		;b227
	ld a,(0e091h)		;b229
	or a			;b22c
	ret nz			;b22d
L_B22E:
	ld a,c			;b22e
	cp 060h		;b22f
	jr z,L_B291		;b231
	cp 057h		;b233
	jr z,L_B296		;b235
	cp 062h		;b237
	jr z,L_B29B		;b239
L_B23B:
	call L_B954		;b23b
L_B23E:
	ld a,l			;b23e
	exx			;b23f
	add a,e			;b240
	inc a			;b241
	exx			;b242
	ld l,a			;b243
	ld a,h			;b244
	exx			;b245
	add a,d			;b246
	inc a			;b247
	exx			;b248
	ld h,a			;b249
	ld a,(ix+000h)		;b24a
	cp 006h		;b24d
	jr z,L_B2A0		;b24f
L_B251:
	call L_B96D		;b251
	ret nc			;b254
L_B255:
	ld a,001h		;b255
	ld (0e61fh),a		;b257
	ld a,(ix+000h)		;b25a
	ld c,a			;b25d
	sub 05dh		;b25e
	cp 003h		;b260
	jp c,L_B2CB		;b262
	ld a,c			;b265
	cp 04fh		;b266
	jp z,L_B2FE		;b268
	cp 06bh		;b26b
	jr z,L_B2AD		;b26d
	cp 023h		;b26f
	jp z,L_B310		;b271
	call L_B3E7		;b274
	jp c,04257h		;b277
	ld a,c			;b27a
	cp 03fh		;b27b
	jr z,L_B2E2		;b27d
	call L_B386		;b27f
	call L_B39A		;b282
	bit 6,(ix+003h)		;b285
	call nz,04257h		;b289
L_B28C:
	ld a,025h		;b28c
	jp 04e1fh		;b28e
L_B291:
	call L_B916		;b291
	jr L_B23E		;b294
L_B296:
	call L_B926		;b296
	jr L_B23E		;b299
L_B29B:
	call L_B933		;b29b
	jr L_B23E		;b29e
L_B2A0:
	ld a,(ix+001h)		;b2a0
	cp 004h		;b2a3
	jr z,L_B251		;b2a5
	call L_B99B		;b2a7
	ret nc			;b2aa
	jr L_B255		;b2ab
L_B2AD:
	ld l,(ix+012h)		;b2ad
	ld h,(ix+013h)		;b2b0
	ld (0e6a8h),hl		;b2b3
	ld a,07ah		;b2b6
	ld (hl),a			;b2b8
	inc hl			;b2b9
	inc a			;b2ba
	ld (hl),a			;b2bb
	ld bc,0001fh		;b2bc
	add hl,bc			;b2bf
	inc a			;b2c0
	ld (hl),a			;b2c1
	inc hl			;b2c2
	inc a			;b2c3
	ld (hl),a			;b2c4
	ld a,001h		;b2c5
	ld (0e024h),a		;b2c7
	ret			;b2ca
L_B2CB:
	push af			;b2cb
	call 04257h		;b2cc
	ld a,02dh		;b2cf
	call 04e1fh		;b2d1
	pop af			;b2d4
	dec a			;b2d5
	ld a,(ix+018h)		;b2d6
	jp m,04d5ah		;b2d9
	jp z,04d7bh		;b2dc
	jp 04d82h		;b2df
L_B2E2:
	call 04257h		;b2e2
	ld a,(0e500h)		;b2e5
	cp 003h		;b2e8
	jp z,L_B389		;b2ea
	ld a,03ch		;b2ed
	ld (0e50fh),a		;b2ef
	xor a			;b2f2
	ld (0e508h),a		;b2f3
	call L_A3E3		;b2f6
	ld a,006h		;b2f9
	jp L_B366		;b2fb
L_B2FE:
	call 04257h		;b2fe
L_B301:
	ld a,(0e501h)		;b301
	or a			;b304
	ld hl,0e053h		;b305
	jr z,L_B30C		;b308
	ld l,057h		;b30a
L_B30C:
	ld a,(hl)			;b30c
	jp 0612ch		;b30d
L_B310:
	ld a,(ix+007h)		;b310
	ld b,a			;b313
	sub d			;b314
	ld c,001h		;b315
	jr nc,L_B31A		;b317
	inc c			;b319
L_B31A:
	ld (0e520h),bc		;b31a
	dec c			;b31e
	jr z,L_B32C		;b31f
	ld a,(0e507h)		;b321
	sub (ix+007h)		;b324
	cp 00fh		;b327
	jr c,L_B337		;b329
	ret			;b32b
L_B32C:
	ld a,(0e507h)		;b32c
	sub (ix+007h)		;b32f
	neg		;b332
	cp 005h		;b334
	ret nc			;b336
L_B337:
	ld a,(0e501h)		;b337
	or a			;b33a
	ld a,000h		;b33b
	ld l,a			;b33d
	ld h,a			;b33e
	ld (0e1c5h),a		;b33f
	jr nz,L_B352		;b342
	ld (0e050h),a		;b344
	ld (0e052h),a		;b347
	ld (0e05ch),hl		;b34a
	ld (0e05eh),a		;b34d
	jr L_B35E		;b350
L_B352:
	ld (0e054h),a		;b352
	ld (0e056h),a		;b355
	ld (0e05fh),hl		;b358
	ld (0e061h),a		;b35b
L_B35E:
	ld a,005h		;b35e
	call L_B366		;b360
	jp 05832h		;b363
L_B366:
	ld (0e500h),a		;b366
	xor a			;b369
	ld (0e50eh),a		;b36a
	ld (0e533h),a		;b36d
	ld (0e508h),a		;b370
	ld (0e530h),a		;b373
	ld (0e51bh),a		;b376
	ld (0e526h),a		;b379
	ld (0e538h),a		;b37c
	inc a			;b37f
	ld (0e518h),a		;b380
	jp L_A3E3		;b383
L_B386:
	call L_B38D		;b386
L_B389:
	ld a,004h		;b389
	jr L_B366		;b38b
L_B38D:
	ld a,(ix+007h)		;b38d
	sub d			;b390
	ld a,000h		;b391
	jr nc,L_B396		;b393
	inc a			;b395
L_B396:
	ld (0e514h),a		;b396
	ret			;b399
L_B39A:
	ld a,(ix+000h)		;b39a
	ld c,a			;b39d
	cp 019h		;b39e
	jr nz,$+18		;b3a0
	ld a,(ix+01bh)		;b3a2
	ld hl,0b3aeh		;b3a5
	call 04155h		;b3a8
	ld b,a			;b3ab
	jr $+19		;b3ac

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_b3ae: 4 bytes que p03:B3A5 lee con (ix+0x1B) para el tipo
;   0x19
;   0xb3ae..0xb3b2  (4 bytes)
DATA_cuatro_bytes_b3ae:
	defb 001h,002h,004h,008h	; b3ae

; ======================================================================
; CODIGO 0xb3b2..0xb620  (622 bytes)
; ======================================================================


L_B3B2:
	call 041f4h		;b3b2
	ld b,000h		;b3b5
	ld hl,064e5h		;b3b7
	add hl,bc			;b3ba
	ld b,(hl)			;b3bb
	call 041e9h		;b3bc
L_B3BF:
	ld a,(0e088h)		;b3bf
	or a			;b3c2
	jr z,L_B3CE		;b3c3
	ld c,b			;b3c5
	dec c			;b3c6
	jr z,L_B3CE		;b3c7
	ld a,b			;b3c9
	rra			;b3ca
	and 07fh		;b3cb
	ld b,a			;b3cd
L_B3CE:
	ld a,(0e501h)		;b3ce
	or a			;b3d1
	ld hl,0e052h		;b3d2
	jr z,L_B3D9		;b3d5
	ld l,056h		;b3d7
L_B3D9:
	ld a,(hl)			;b3d9
	cp 006h		;b3da
	ld a,02ah		;b3dc
	call c,04e1fh		;b3de
	ld a,b			;b3e1
	neg		;b3e2
	jp 0612ch		;b3e4
L_B3E7:
	or a			;b3e7
	bit 7,(ix+003h)		;b3e8
	ret z			;b3ec
	ld a,(0e530h)		;b3ed
	or a			;b3f0
	ret z			;b3f1
	ld a,(0e507h)		;b3f2
	sub 008h		;b3f5
	sub (ix+007h)		;b3f7
	ld a,(0e503h)		;b3fa
	jr c,L_B403		;b3fd
	or a			;b3ff
	ret z			;b400
	jr L_B405		;b401
L_B403:
	or a			;b403
	ret nz			;b404
L_B405:
	ld a,01dh		;b405
	call 04e1fh		;b407
	scf			;b40a
	ret			;b40b
L_B40C:
	ld a,(0e518h)		;b40c
	or a			;b40f
	ret nz			;b410
	ld a,(0e505h)		;b411
	sub 010h		;b414
	ld c,a			;b416
	ld a,(0e507h)		;b417
	sub 008h		;b41a
	ld b,a			;b41c
	ld iy,0e5a0h		;b41d
	ld a,003h		;b421
	ld (0e623h),a		;b423
L_B426:
	call L_B438		;b426
	jp c,L_B466		;b429
	ld de,00020h		;b42c
	add iy,de		;b42f
	ld hl,0e623h		;b431
	dec (hl)			;b434
	jr nz,L_B426		;b435
	ret			;b437
L_B438:
	ld a,(iy+000h)		;b438
	or a			;b43b
	ret z			;b43c
	ld a,(iy+002h)		;b43d
	bit 0,a		;b440
	ret z			;b442
	and 008h		;b443
	ret nz			;b445
	call L_B8B2		;b446
	exx			;b449
	ld a,d			;b44a
	add a,011h		;b44b
	exx			;b44d
	ld h,a			;b44e
	exx			;b44f
	ld a,e			;b450
	add a,011h		;b451
	exx			;b453
	ld l,a			;b454
	ld a,d			;b455
	sub b			;b456
	exx			;b457
	add a,d			;b458
	exx			;b459
	jr c,L_B45E		;b45a
	cp h			;b45c
	ret nc			;b45d
L_B45E:
	ld a,e			;b45e
	sub c			;b45f
	exx			;b460
	add a,e			;b461
	exx			;b462
	ret c			;b463
	cp l			;b464
	ret			;b465
L_B466:
	bit 2,(iy+002h)		;b466
	push af			;b46a
	call z,L_AE4B		;b46b
	pop af			;b46e
	jr nz,L_B48B		;b46f
	call L_B8A0		;b471
	ld a,(iy+007h)		;b474
	sub d			;b477
	ld a,000h		;b478
	jr nc,L_B47D		;b47a
	inc a			;b47c
L_B47D:
	ld (0e514h),a		;b47d
	call L_B389		;b480
L_B483:
	ld a,0feh		;b483
	call 0612ch		;b485
	jp L_B28C		;b488
L_B48B:
	set 3,(iy+002h)		;b48b
	jp L_B483		;b48f
L_B492:
	ld iy,0e540h		;b492
	ld b,006h		;b496
L_B498:
	push bc			;b498
	call L_B4A5		;b499
	ld bc,00020h		;b49c
	add iy,bc		;b49f
	pop bc			;b4a1
	djnz L_B498		;b4a2
	ret			;b4a4
L_B4A5:
	ld a,(iy+000h)		;b4a5
	or a			;b4a8
	ret z			;b4a9
	cp 006h		;b4aa
	ret nc			;b4ac
	bit 0,(iy+002h)		;b4ad
	ret z			;b4b1
	call L_B8B2		;b4b2
	ld ix,0e800h		;b4b5
	ld a,(0e635h)		;b4b9
	ld (0e623h),a		;b4bc
L_B4BF:
	call L_B4D1		;b4bf
	jp c,L_B54D		;b4c2
	ld bc,00020h		;b4c5
	add ix,bc		;b4c8
	ld hl,0e623h		;b4ca
	dec (hl)			;b4cd
	jr nz,L_B4BF		;b4ce
	ret			;b4d0
L_B4D1:
	ld a,(ix+002h)		;b4d1
	and 020h		;b4d4
	ret z			;b4d6
	call L_B528		;b4d7
	ret nc			;b4da
	call L_B53D		;b4db
	ret nc			;b4de
	ld a,(ix+000h)		;b4df
	cp 060h		;b4e2
	jp z,L_B50B		;b4e4
	cp 057h		;b4e7
	jp z,L_B511		;b4e9
	cp 062h		;b4ec
	jp z,L_B517		;b4ee
	call L_B954		;b4f1
L_B4F4:
	ld a,l			;b4f4
	exx			;b4f5
	add a,e			;b4f6
	inc a			;b4f7
	exx			;b4f8
	ld l,a			;b4f9
	ld a,h			;b4fa
	exx			;b4fb
	add a,d			;b4fc
	inc a			;b4fd
	exx			;b4fe
	ld h,a			;b4ff
	ld a,(ix+000h)		;b500
	cp 006h		;b503
	jp z,L_B51D		;b505
	jp L_B96D		;b508
L_B50B:
	call L_B916		;b50b
	jp L_B4F4		;b50e
L_B511:
	call L_B926		;b511
	jp L_B4F4		;b514
L_B517:
	call L_B933		;b517
	jp L_B4F4		;b51a
L_B51D:
	ld a,(ix+001h)		;b51d
	cp 004h		;b520
	jp z,L_B96D		;b522
	jp L_B99B		;b525
L_B528:
	ld a,(iy+000h)		;b528
	sub 006h		;b52b
	cp 0ffh		;b52d
	ret c			;b52f
	scf			;b530
	bit 2,(iy+002h)		;b531
	ret z			;b535
	bit 4,(ix+003h)		;b536
	ret z			;b53a
	or a			;b53b
	ret			;b53c
L_B53D:
	ld a,(iy+000h)		;b53d
	sub 003h		;b540
	cp 0ffh		;b542
	ret c			;b544
	or a			;b545
	bit 5,(ix+003h)		;b546
	ret nz			;b54a
	scf			;b54b
	ret			;b54c
L_B54D:
	ld a,(iy+000h)		;b54d
	cp 005h		;b550
	jr z,L_B5B1		;b552
	ld a,(ix+002h)		;b554
	bit 2,a		;b557
	jp nz,L_AE68		;b559
	bit 1,a		;b55c
	jr z,L_B568		;b55e
	and 001h		;b560
	xor (iy+010h)		;b562
	jp nz,L_AE68		;b565
L_B568:
	ld a,(iy+000h)		;b568
	cp 002h		;b56b
	push af			;b56d
	call z,L_B5AC		;b56e
	pop af			;b571
	call nz,L_AD76		;b572
L_B575:
	call L_B592		;b575
	call z,L_B5A7		;b578
	ld a,01eh		;b57b
	call 04e1fh		;b57d
	dec (ix+010h)		;b580
	jp z,L_B604		;b583
	ld a,(0e094h)		;b586
	or a			;b589
	ret z			;b58a
	dec (ix+010h)		;b58b
	jp z,L_B604		;b58e
	ret			;b591
L_B592:
	ld a,(ix+000h)		;b592
	cp 00fh		;b595
	ret z			;b597
	cp 025h		;b598
	ret z			;b59a
	cp 049h		;b59b
	ret z			;b59d
	cp 052h		;b59e
	ret z			;b5a0
	cp 054h		;b5a1
	ret z			;b5a3
	cp 027h		;b5a4
	ret			;b5a6
L_B5A7:
	ld (ix+01ch),001h		;b5a7
	ret			;b5ab
L_B5AC:
	set 5,(ix+003h)		;b5ac
	ret			;b5b0
L_B5B1:
	bit 2,(iy+002h)		;b5b1
	call z,L_B5E2		;b5b5
	bit 2,(ix+002h)		;b5b8
	ret nz			;b5bc
	call L_B592		;b5bd
	call z,L_B5A7		;b5c0
	set 4,(ix+003h)		;b5c3
	dec (ix+010h)		;b5c7
	jr z,L_B5DF		;b5ca
	dec (ix+010h)		;b5cc
	jr z,L_B5DF		;b5cf
	ld a,(0e094h)		;b5d1
	or a			;b5d4
	ret z			;b5d5
	dec (ix+010h)		;b5d6
	jr z,L_B5DF		;b5d9
	dec (ix+010h)		;b5db
	ret nz			;b5de
L_B5DF:
	jp L_B604		;b5df
L_B5E2:
	call L_AE4B		;b5e2
	ld a,01eh		;b5e5
	jp 04e1fh		;b5e7
L_B5EA:
	ld ix,0e800h		;b5ea
	ld a,(0e635h)		;b5ee
L_B5F1:
	push af			;b5f1
	ld a,(ix+000h)		;b5f2
	cp 00eh		;b5f5
	call z,L_B604		;b5f7
	ld bc,00020h		;b5fa
	add ix,bc		;b5fd
	pop af			;b5ff
	dec a			;b600
	jr nz,L_B5F1		;b601
	ret			;b603
L_B604:
	ld a,020h		;b604
	call 04e1fh		;b606
	ld a,(ix+000h)		;b609
	cp 05ch		;b60c
	jp z,L_B69B		;b60e
	cp 019h		;b611
	jr nz,$+17		;b613
	ld a,(ix+01bh)		;b615
	ld hl,0b620h		;b618
	call 04136h		;b61b
	jr $+15		;b61e

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_b620: 4 bytes que p03:B618 lee con (ix+0x1B) para el tipo
;   0x19
;   0xb620..0xb624  (4 bytes)
DATA_cuatro_bytes_b620:
	defb 001h,002h,004h,004h	; b620

; ======================================================================
; CODIGO 0xb624..0xb8f1  (717 bytes)
; ======================================================================


L_B624:
	ld hl,0bf27h		;b624
	ld c,(ix+000h)		;b627
	ld b,000h		;b62a
	add hl,bc			;b62c
L_B62D:
	ld c,(hl)			;b62d
	ld a,(0e08ah)		;b62e
	or a			;b631
	ld a,c			;b632
	jr z,L_B636		;b633
	add a,a			;b635
L_B636:
	call 06158h		;b636
	call L_B6AA		;b639
	ld a,(ix+000h)		;b63c
	ld (0e6c7h),a		;b63f
	call 04257h		;b642
	ld a,(0e6c7h)		;b645
	cp 015h		;b648
	jr z,L_B66C		;b64a
	cp 016h		;b64c
	jr z,L_B66C		;b64e
	cp 040h		;b650
	jr z,L_B66C		;b652
	cp 04ch		;b654
	jr z,L_B66C		;b656
	cp 042h		;b658
	jr z,L_B66C		;b65a
	cp 043h		;b65c
	call z,L_B67B		;b65e
	ld a,05bh		;b661
L_B663:
	ld d,(ix+005h)		;b663
	ld e,(ix+007h)		;b666
	jp 0424ch		;b669
L_B66C:
	ld a,041h		;b66c
	ld (0e63fh),a		;b66e
	ld l,(ix+005h)		;b671
	ld h,(ix+007h)		;b674
	ld (0e6c0h),hl		;b677
	ret			;b67a
L_B67B:
	push ix		;b67b
	ld ix,0e800h		;b67d
	ld de,00020h		;b681
	ld a,(0e635h)		;b684
	ld b,a			;b687
	ld a,062h		;b688
L_B68A:
	cp (ix+000h)		;b68a
	jr z,L_B696		;b68d
	add ix,de		;b68f
	djnz L_B68A		;b691
L_B693:
	pop ix		;b693
	ret			;b695
L_B696:
	call 04257h		;b696
	jr L_B693		;b699
L_B69B:
	call 04257h		;b69b
	ld a,(ix+01fh)		;b69e
	or a			;b6a1
	ld a,039h		;b6a2
	jr z,L_B6A8		;b6a4
	ld a,06bh		;b6a6
L_B6A8:
	jr L_B663		;b6a8
L_B6AA:
	bit 3,(ix+002h)		;b6aa
	ret z			;b6ae
	ld hl,0e622h		;b6af
	dec (hl)			;b6b2
	ret nz			;b6b3
	ld a,(0e041h)		;b6b4
	dec a			;b6b7
	jp nz,04260h		;b6b8
	ld a,001h		;b6bb
	ld (0e61ch),a		;b6bd
	ret			;b6c0
L_B6C1:
	ld a,(0e51bh)		;b6c1
	or a			;b6c4
	ret z			;b6c5
	call L_B8FB		;b6c6
	ld ix,0e800h		;b6c9
	ld a,010h		;b6cd
	ld (0e623h),a		;b6cf
L_B6D2:
	call L_B4D1		;b6d2
	jr c,L_B6E3		;b6d5
	ld bc,00020h		;b6d7
	add ix,bc		;b6da
	ld hl,0e623h		;b6dc
	dec (hl)			;b6df
	jr nz,L_B6D2		;b6e0
	ret			;b6e2
L_B6E3:
	xor a			;b6e3
	ld (0e51bh),a		;b6e4
	ld a,(ix+002h)		;b6e7
	bit 1,a		;b6ea
	jr z,L_B6F6		;b6ec
	and 001h		;b6ee
	ld b,a			;b6f0
	ld a,(0e503h)		;b6f1
	xor b			;b6f4
	ret nz			;b6f5
L_B6F6:
	ld a,(ix+002h)		;b6f6
	bit 2,a		;b6f9
	jp nz,L_AE88		;b6fb
	jp L_B575		;b6fe
L_B701:
	call L_B8A0		;b701
	ld hl,0e740h		;b704
	ld a,(hl)			;b707
	or a			;b708
	ret z			;b709
	inc l			;b70a
	inc l			;b70b
	cp 007h		;b70c
	jr nc,L_B71D		;b70e
	ld a,(hl)			;b710
	add a,002h		;b711
	sub e			;b713
	add a,004h		;b714
	jr c,L_B728		;b716
	cp 011h		;b718
	jr c,L_B728		;b71a
	ret			;b71c
L_B71D:
	ld a,(hl)			;b71d
	add a,003h		;b71e
	sub e			;b720
	add a,00ah		;b721
	jr c,L_B728		;b723
	cp 017h		;b725
	ret nc			;b727
L_B728:
	inc l			;b728
	ld a,(hl)			;b729
	add a,003h		;b72a
	sub d			;b72c
	add a,008h		;b72d
	jr c,L_B734		;b72f
	cp 015h		;b731
	ret nc			;b733
L_B734:
	dec l			;b734
	dec l			;b735
	dec l			;b736
	ld a,(hl)			;b737
	ld c,a			;b738
	ld (hl),000h		;b739
	sub 02dh		;b73b
	jp nc,L_B7BE		;b73d
	ld b,000h		;b740
	ld hl,0e06fh		;b742
	add hl,bc			;b745
	ld (hl),001h		;b746
	ld a,c			;b748
	sub 02bh		;b749
	jr c,L_B75A		;b74b
	add a,002h		;b74d
	ld (0e097h),a		;b74f
	ld hl,0e098h		;b752
	call 04136h		;b755
	ld (hl),001h		;b758
L_B75A:
	ld hl,(0e60eh)		;b75a
	set 0,(hl)		;b75d
	ld a,c			;b75f
	cp 00ch		;b760
	jr z,L_B769		;b762
	ld a,02dh		;b764
	call 04e1fh		;b766
L_B769:
	ld hl,0e061h		;b769
	ld a,(0e041h)		;b76c
	call 04136h		;b76f
	ld a,c			;b772
	sub 007h		;b773
	jr nz,L_B77A		;b775
	set 5,(hl)		;b777
	ret			;b779
L_B77A:
	dec a			;b77a
	jr nz,L_B780		;b77b
	set 6,(hl)		;b77d
	ret			;b77f
L_B780:
	dec a			;b780
	jr nz,L_B786		;b781
	set 7,(hl)		;b783
	ret			;b785
L_B786:
	dec a			;b786
	jr nz,L_B78C		;b787
	set 4,(hl)		;b789
	ret			;b78b
L_B78C:
	sub 002h		;b78c
	ret nz			;b78e
	inc l			;b78f
	set 1,(hl)		;b790
	ld a,0fch		;b792
	call 04e1fh		;b794
	ld a,085h		;b797
	call 04e1fh		;b799
	ld a,(0e041h)		;b79c
	dec a			;b79f
	jr nz,L_B7A5		;b7a0
	call L_AE9A		;b7a2
L_B7A5:
	ld a,(0e041h)		;b7a5
	dec a			;b7a8
	ld a,088h		;b7a9
	ld b,000h		;b7ab
	jr z,L_B7B2		;b7ad
	ld a,08bh		;b7af
	inc b			;b7b1
L_B7B2:
	call 05d12h		;b7b2
	ld a,b			;b7b5
	ld (0e031h),a		;b7b6
	xor a			;b7b9
	ld (0e0d4h),a		;b7ba
	ret			;b7bd
L_B7BE:
	push af			;b7be
	call L_B75A		;b7bf
	pop af			;b7c2
	ld b,a			;b7c3
	dec b			;b7c4
	ld a,010h		;b7c5
	jp z,04d7bh		;b7c7
	dec b			;b7ca
	ld a,002h		;b7cb
	jp z,04d82h		;b7cd
	ld a,050h		;b7d0
	jp 04d5ah		;b7d2
L_B7D5:
	call L_B877		;b7d5
	ld iy,0e540h		;b7d8
	ld b,006h		;b7dc
L_B7DE:
	push bc			;b7de
	call L_B7EB		;b7df
	ld bc,00020h		;b7e2
	add iy,bc		;b7e5
	pop bc			;b7e7
	djnz L_B7DE		;b7e8
	ret			;b7ea
L_B7EB:
	ld a,(iy+000h)		;b7eb
	dec a			;b7ee
	cp 004h		;b7ef
	ret nc			;b7f1
	bit 0,(iy+002h)		;b7f2
	ret z			;b7f6
	call L_B8B2		;b7f7
	ld ix,0ec30h		;b7fa
	ld a,003h		;b7fe
	ld (0e623h),a		;b800
L_B803:
	call L_B814		;b803
	jr c,L_B833		;b806
	ld bc,00008h		;b808
	add ix,bc		;b80b
	ld hl,0e623h		;b80d
	dec (hl)			;b810
	jr nz,L_B803		;b811
	ret			;b813
L_B814:
	ld a,(ix+000h)		;b814
	or a			;b817
	ret z			;b818
	ld a,(ix+001h)		;b819
	dec a			;b81c
	ret z			;b81d
	ld bc,00000h		;b81e
	ld hl,01410h		;b821
	ld a,l			;b824
	exx			;b825
	add a,e			;b826
	inc a			;b827
	exx			;b828
	ld l,a			;b829
	ld a,h			;b82a
	exx			;b82b
	add a,d			;b82c
	inc a			;b82d
	exx			;b82e
	ld h,a			;b82f
	jp L_B984		;b830
L_B833:
	ld a,(iy+000h)		;b833
	cp 005h		;b836
	ret z			;b838
	call L_AD76		;b839
L_B83C:
	ld a,01eh		;b83c
	call 04e1fh		;b83e
	ld hl,0e08eh		;b841
	call 04ddbh		;b844
	ld b,001h		;b847
	jr z,L_B84D		;b849
	ld b,005h		;b84b
L_B84D:
	ld a,(ix+006h)		;b84d
	sub b			;b850
	ld (ix+006h),a		;b851
	jr z,L_B857		;b854
	ret nc			;b856
L_B857:
	ld a,020h		;b857
	call 04e1fh		;b859
L_B85C:
	ld (ix+001h),001h		;b85c
	ld (ix+006h),00ah		;b860
	ld a,(ix+007h)		;b864
	add a,005h		;b867
	push bc			;b869
	ld b,a			;b86a
	xor a			;b86b
	scf			;b86c
L_B86D:
	rla			;b86d
	djnz L_B86D		;b86e
	pop bc			;b870
	ld hl,(0e60eh)		;b871
	or (hl)			;b874
	ld (hl),a			;b875
	ret			;b876
L_B877:
	ld a,(0e526h)		;b877
	or a			;b87a
	ret z			;b87b
	call L_B8FB		;b87c
	ld ix,0ec30h		;b87f
	ld a,003h		;b883
	ld (0e623h),a		;b885
L_B888:
	call L_B814		;b888
	jr c,L_B899		;b88b
	ld bc,00008h		;b88d
	add ix,bc		;b890
	ld hl,0e623h		;b892
	dec (hl)			;b895
	jr nz,L_B888		;b896
	ret			;b898
L_B899:
	xor a			;b899
	ld (0e526h),a		;b89a
	jp L_B83C		;b89d
L_B8A0:
	ld a,(0e505h)		;b8a0
	sub 00eh		;b8a3
	ld e,a			;b8a5
	ld a,(0e507h)		;b8a6
	sub 006h		;b8a9
	ld d,a			;b8ab
	exx			;b8ac
	ld de,00c0ch		;b8ad
	exx			;b8b0
	ret			;b8b1
L_B8B2:
	ld e,(iy+005h)		;b8b2
	ld d,(iy+007h)		;b8b5
	ld a,(iy+000h)		;b8b8
	sub 003h		;b8bb
	jr nc,L_B8CB		;b8bd
	ld a,e			;b8bf
	and 0f8h		;b8c0
	add a,002h		;b8c2
	ld e,a			;b8c4
	ld a,d			;b8c5
	and 0f8h		;b8c6
	add a,002h		;b8c8
	ld d,a			;b8ca
L_B8CB:
	exx			;b8cb
	ld a,(iy+000h)		;b8cc
	ld hl,lb8efh		;b8cf
	call 0414ch		;b8d2
	exx			;b8d5
	ld a,(iy+000h)		;b8d6
	cp 005h		;b8d9
	ret nz			;b8db
	bit 2,(iy+002h)		;b8dc
	jr nz,L_B8E5		;b8e0
	inc d			;b8e2
	inc d			;b8e3
	ret			;b8e4
L_B8E5:
	ld a,d			;b8e5
	ld d,a			;b8e6
	ld a,e			;b8e7
	sub 010h		;b8e8
	ld e,a			;b8ea
	exx			;b8eb
	ld de,02020h		;b8ec
L_B8EF:
	exx			;b8ef
	ret			;b8f0

; ----------------------------------------------------------------------
; DATOS tamanos_b8f1: 5 parejas que p03:B8CF lee en 0xB8EF + 2 x (iy+0)
;   (0x414C, tipo 1-5): dos medidas (3 y 0x0C, 3 y 0x0C, 8 y 8, 4 y 8, 4 y
;   0x0C) que p03:B8E5 usa con la posicion de la figura
;   0xb8f1..0xb8fb  (10 bytes)
DATA_tamanos_b8f1:
	defb 003h,00ch	; b8f1
	defb 003h,00ch	; b8f3
	defb 008h,008h	; b8f5
	defb 004h,008h	; b8f7
	defb 004h,00ch	; b8f9

; ======================================================================
; CODIGO 0xb8fb..0xb9d9  (222 bytes)
; ======================================================================


L_B8FB:
	ld a,(0e503h)		;b8fb
	or a			;b8fe
	ld d,008h		;b8ff
	jr z,L_B905		;b901
	ld d,0eeh		;b903
L_B905:
	ld a,(0e507h)		;b905
	add a,d			;b908
	ld d,a			;b909
	ld a,(0e505h)		;b90a
	sub 007h		;b90d
	ld e,a			;b90f
	exx			;b910
	ld de,00a03h		;b911
	exx			;b914
	ret			;b915
L_B916:
	ld bc,00000h		;b916
	ld a,(ix+009h)		;b919
	and 007h		;b91c
	dec a			;b91e
	add a,a			;b91f
	add a,a			;b920
	add a,a			;b921
	ld l,a			;b922
	ld h,007h		;b923
	ret			;b925
L_B926:
	ld bc,00000h		;b926
	ld l,008h		;b929
	ld a,(ix+01fh)		;b92b
	add a,a			;b92e
	add a,a			;b92f
	add a,a			;b930
	ld h,a			;b931
	ret			;b932
L_B933:
	ld b,000h		;b933
	ld c,b			;b935
	ld a,(ix+009h)		;b936
	and 007h		;b939
	ld (0f020h),a		;b93b
	bit 0,(ix+015h)		;b93e
	jr z,L_B94A		;b942
	add a,a			;b944
	add a,a			;b945
	add a,a			;b946
	neg		;b947
	ld c,a			;b949
L_B94A:
	ld h,007h		;b94a
	ld a,(0f020h)		;b94c
	add a,a			;b94f
	add a,a			;b950
	add a,a			;b951
	ld l,a			;b952
	ret			;b953
L_B954:
	call 0420ah		;b954
	ld l,(ix+011h)		;b957
	ld h,000h		;b95a
	add hl,hl			;b95c
	add hl,hl			;b95d
	ld bc,09006h		;b95e
	add hl,bc			;b961
	ld c,(hl)			;b962
	inc hl			;b963
	ld b,(hl)			;b964
	inc hl			;b965
	ld a,(hl)			;b966
	inc hl			;b967
	ld h,(hl)			;b968
	ld l,a			;b969
	jp 041ffh		;b96a
L_B96D:
	ld a,e			;b96d
	sub (ix+005h)		;b96e
	sub c			;b971
	exx			;b972
	add a,e			;b973
	exx			;b974
	jr c,L_B979		;b975
	cp l			;b977
	ret nc			;b978
L_B979:
	ld a,d			;b979
	sub (ix+007h)		;b97a
	sub b			;b97d
	exx			;b97e
	add a,d			;b97f
	exx			;b980
	ret c			;b981
	cp h			;b982
	ret			;b983
L_B984:
	ld a,e			;b984
	sub (ix+002h)		;b985
	sub c			;b988
	exx			;b989
	add a,e			;b98a
	exx			;b98b
	jr c,L_B990		;b98c
	cp l			;b98e
	ret nc			;b98f
L_B990:
	ld a,d			;b990
	sub (ix+003h)		;b991
	sub b			;b994
	exx			;b995
	add a,d			;b996
	exx			;b997
	ret c			;b998
	cp h			;b999
	ret			;b99a
L_B99B:
	ld a,e			;b99b
	sub (ix+012h)		;b99c
	sub c			;b99f
	exx			;b9a0
	add a,e			;b9a1
	exx			;b9a2
	jr c,L_B9A7		;b9a3
	cp l			;b9a5
	ret nc			;b9a6
L_B9A7:
	ld a,d			;b9a7
	sub (ix+013h)		;b9a8
	sub b			;b9ab
	exx			;b9ac
	add a,d			;b9ad
	exx			;b9ae
	ret c			;b9af
	cp h			;b9b0
	ret			;b9b1
L_B9B2:
	ld a,(0e700h)		;b9b2
	or a			;b9b5
	ret z			;b9b6
	ld a,(0e518h)		;b9b7
	or a			;b9ba
	ret nz			;b9bb
	ld a,(0e702h)		;b9bc
	bit 6,a		;b9bf
	ret z			;b9c1
	call L_B8A0		;b9c2
	call L_B9D2		;b9c5
	ret nc			;b9c8
	call L_BA6E		;b9c9
	call L_BABA		;b9cc
	jp L_B28C		;b9cf
L_B9D2:
	ld a,(0e700h)		;b9d2
	dec a			;b9d5
	call 04140h		;b9d6

; ----------------------------------------------------------------------
; DATOS tabla_B9D9: 11 destinos del despachador de 0x4140 (call en p03:B9D6):
;   0xBADE, 0xB9EF, 0xBADE, 0xBADE, 0x0000, 0xB9FA, 0xBADE, 0xBADE ...; lo
;   leen p03:B9D6 (22 bytes)
;   0xb9d9..0xb9ef  (22 bytes)
DATA_tabla_B9D9:
	defb 0deh,0bah	; b9d9
	defb 0efh,0b9h	; b9db
	defb 0deh,0bah	; b9dd
	defb 0deh,0bah	; b9df
	defb 000h,000h	; b9e1
	defb 0fah,0b9h	; b9e3
	defb 0deh,0bah	; b9e5
	defb 0deh,0bah	; b9e7
	defb 0deh,0bah	; b9e9
	defb 01eh,0bah	; b9eb
	defb 042h,0bah	; b9ed

; ======================================================================
; CODIGO 0xb9ef..0xba12  (35 bytes)
; ======================================================================


L_B9EF:
	ld a,(0e505h)		;b9ef
	ld e,a			;b9f2
	ld a,(0e507h)		;b9f3
	ld d,a			;b9f6
	jp L_BD98		;b9f7
L_B9FA:
	call L_BADE		;b9fa
	ret c			;b9fd
	call L_BA04		;b9fe
	jp L_BAE1		;ba01
L_BA04:
	ld a,(0e70ah)		;ba04
	ld b,034h		;ba07
	ld hl,0ba12h		;ba09
L_BA0C:
	sub b			;ba0c
	add a,a			;ba0d
	add a,a			;ba0e
	jp 04136h		;ba0f

; ----------------------------------------------------------------------
; DATOS tres_fichas_ba12: 3 fichas de 4 bytes que p03:BA09 elige con (0xE70A)
;   - 0x34 y pasa a p03:BAE1
;   0xba12..0xba1e  (12 bytes)
DATA_tres_fichas_ba12:
	defb 010h,010h,010h,018h	; ba12
	defb 010h,008h,018h,024h	; ba16
	defb 030h,000h,010h,078h	; ba1a

; ======================================================================
; CODIGO 0xba1e..0xba32  (20 bytes)
; ======================================================================


L_BA1E:
	call L_BADE		;ba1e
	ret c			;ba21
	call L_BA28		;ba22
	jp L_BAE1		;ba25
L_BA28:
	ld a,(0e719h)		;ba28
	ld b,01eh		;ba2b
	ld hl,0ba32h		;ba2d
	jr $-36		;ba30

; ----------------------------------------------------------------------
; DATOS cuatro_fichas_ba32: 4 fichas de 4 bytes que p03:BA2D elige con
;   (0xE719) - 0x1E
;   0xba32..0xba42  (16 bytes)
DATA_cuatro_fichas_ba32:
	defb 008h,000h,008h,018h	; ba32
	defb 010h,000h,008h,018h	; ba36
	defb 018h,000h,008h,018h	; ba3a
	defb 020h,000h,008h,018h	; ba3e

; ======================================================================
; CODIGO 0xba42..0xba56  (20 bytes)
; ======================================================================


L_BA42:
	call L_BADE		;ba42
	ret c			;ba45
	call L_BA4C		;ba46
	jp L_BAE1		;ba49
L_BA4C:
	ld a,(0e70ah)		;ba4c
	ld b,02bh		;ba4f
	ld hl,0ba56h		;ba51
	jr $-72		;ba54

; ----------------------------------------------------------------------
; DATOS seis_fichas_ba56: 6 fichas de 4 bytes que p03:BA51 elige con (0xE70A)
;   - 0x2B
;   0xba56..0xba6e  (24 bytes)
DATA_seis_fichas_ba56:
	defb 018h,000h,010h,050h	; ba56
	defb 018h,008h,010h,040h	; ba5a
	defb 010h,00ch,018h,030h	; ba5e
	defb 010h,014h,018h,030h	; ba62
	defb 008h,014h,020h,020h	; ba66
	defb 008h,01ch,020h,020h	; ba6a

; ======================================================================
; CODIGO 0xba6e..0xba9a  (44 bytes)
; ======================================================================


L_BA6E:
	call L_BA82		;ba6e
	xor a			;ba71
	ld (0e50eh),a		;ba72
	ld (0e508h),a		;ba75
	inc a			;ba78
	ld (0e518h),a		;ba79
	ld a,004h		;ba7c
	ld (0e500h),a		;ba7e
	ret			;ba81
L_BA82:
	ld a,(0e70ah)		;ba82
	ld c,a			;ba85
	ld b,000h		;ba86
	ld hl,0ba9ah		;ba88
	add hl,bc			;ba8b
	ld a,(0e707h)		;ba8c
	add a,(hl)			;ba8f
	sub d			;ba90
	ld a,000h		;ba91
	jr nc,L_BA96		;ba93
	inc a			;ba95
L_BA96:
	ld (0e514h),a		;ba96
	ret			;ba99

; ----------------------------------------------------------------------
; DATOS altura_por_dibujo: 32 bytes que p03:BA88 suma a 0xE707 segun (0xE70A)
;   0xba9a..0xbaba  (32 bytes)
DATA_altura_por_dibujo:
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; ba9a
	defb 010h,010h,010h,010h,018h,018h,018h,018h,020h,020h,020h,020h,020h,020h,020h,020h	; baaa  ........

; ======================================================================
; CODIGO 0xbaba..0xbad3  (25 bytes)
; ======================================================================


L_BABA:
	ld hl,0bad2h		;baba
	ld a,(0e700h)		;babd
	ld c,a			;bac0
	ld b,000h		;bac1
	add hl,bc			;bac3
	ld a,(0e077h)		;bac4
	or a			;bac7
	ld a,(hl)			;bac8
	jr z,L_BACE		;bac9
	rra			;bacb
	and 07fh		;bacc
L_BACE:
	neg		;bace
	jp 0612ch		;bad0

; ----------------------------------------------------------------------
; DATOS once_bytes_bad3: 11 bytes que p03:BABA lee en 0xBAD2 + (0xE700) (1-11)
;   0xbad3..0xbade  (11 bytes)
DATA_once_bytes_bad3:
	defb 008h,00ch,014h,00ch,000h,024h,018h,020h,028h,010h,010h	; bad3  .....$. (..

; ======================================================================
; CODIGO 0xbade..0xbb7a  (156 bytes)
; ======================================================================


L_BADE:
	call L_BB04		;bade
L_BAE1:
	call 0420ah		;bae1
	call L_BAEA		;bae4
	jp 041ffh		;bae7
L_BAEA:
	ld a,(0e705h)		;baea
	add a,(hl)			;baed
	inc hl			;baee
	sub e			;baef
	cp 010h		;baf0
	jr c,L_BAF8		;baf2
	inc hl			;baf4
	add a,(hl)			;baf5
	dec hl			;baf6
	ret nc			;baf7
L_BAF8:
	ld a,(0e707h)		;baf8
	add a,(hl)			;bafb
	inc hl			;bafc
	sub d			;bafd
	cp 010h		;bafe
	ret c			;bb00
	inc hl			;bb01
	add a,(hl)			;bb02
	ret			;bb03
L_BB04:
	call 0420ah		;bb04
	ld hl,0928ah		;bb07
	ld a,(0e700h)		;bb0a
	add a,a			;bb0d
	call 04136h		;bb0e
	ld a,(hl)			;bb11
	inc hl			;bb12
	ld h,(hl)			;bb13
	ld l,a			;bb14
	ld b,(hl)			;bb15
	inc hl			;bb16
	ld a,(0e70ah)		;bb17
	sub b			;bb1a
	add a,a			;bb1b
	add a,a			;bb1c
	ld c,a			;bb1d
	ld b,000h		;bb1e
	add hl,bc			;bb20
	jp 041ffh		;bb21
L_BB24:
	ld iy,0e540h		;bb24
	ld b,006h		;bb28
L_BB2A:
	push bc			;bb2a
	call L_BB37		;bb2b
	ld bc,00020h		;bb2e
	add iy,bc		;bb31
	pop bc			;bb33
	djnz L_BB2A		;bb34
	ret			;bb36
L_BB37:
	ld a,(0e500h)		;bb37
	cp 005h		;bb3a
	ret z			;bb3c
	ld a,(0e02ch)		;bb3d
	or a			;bb40
	ret nz			;bb41
	ld a,(iy+000h)		;bb42
	or a			;bb45
	ret z			;bb46
	cp 006h		;bb47
	ret nc			;bb49
	bit 0,(iy+002h)		;bb4a
	ret z			;bb4e
	call L_B8B2		;bb4f
	ld ix,0e700h		;bb52
	call L_BB5D		;bb56
	jp c,L_BC75		;bb59
	ret			;bb5c
L_BB5D:
	ld a,(0e702h)		;bb5d
	and 020h		;bb60
	ret z			;bb62
	call L_B528		;bb63
	ret nc			;bb66
	call L_B53D		;bb67
	ret nc			;bb6a
	ld a,(iy+000h)		;bb6b
	cp 005h		;bb6e
	jp z,L_BC25		;bb70
L_BB73:
	ld a,(0e700h)		;bb73
	dec a			;bb76
	call 04140h		;bb77

; ----------------------------------------------------------------------
; DATOS tabla_BB7A: 11 destinos del despachador de 0x4140 (call en p03:BB77):
;   0xBBAD, 0xBB90, 0xBBAD, 0xBB96, 0x0000, 0xBBBF, 0xBB9F, 0xBBAD ...; lo
;   leen p03:BB77 (22 bytes)
;   0xbb7a..0xbb90  (22 bytes)
DATA_tabla_BB7A:
	defb 0adh,0bbh	; bb7a
	defb 090h,0bbh	; bb7c
	defb 0adh,0bbh	; bb7e
	defb 096h,0bbh	; bb80
	defb 000h,000h	; bb82
	defb 0bfh,0bbh	; bb84
	defb 09fh,0bbh	; bb86
	defb 0adh,0bbh	; bb88
	defb 0a8h,0bbh	; bb8a
	defb 002h,0bch	; bb8c
	defb 0adh,0bbh	; bb8e

; ======================================================================
; CODIGO 0xbb90..0xbbdb  (75 bytes)
; ======================================================================


L_BB90:
	call L_BC15		;bb90
	jp L_BDD7		;bb93
L_BB96:
	ld a,(0e70ah)		;bb96
	cp 012h		;bb99
	ccf			;bb9b
	ret nc			;bb9c
	jr L_BBAD		;bb9d
L_BB9F:
	ld a,(0e70ah)		;bb9f
	cp 019h		;bba2
	ccf			;bba4
	ret nc			;bba5
	jr L_BBAD		;bba6
L_BBA8:
	ld a,(0e07ah)		;bba8
	or a			;bbab
	ret z			;bbac
L_BBAD:
	call L_BD70		;bbad
L_BBB0:
	ld a,l			;bbb0
	exx			;bbb1
	add a,e			;bbb2
	inc a			;bbb3
	exx			;bbb4
	ld l,a			;bbb5
	ld a,h			;bbb6
	exx			;bbb7
	add a,d			;bbb8
	inc a			;bbb9
	exx			;bbba
	ld h,a			;bbbb
	jp L_B96D		;bbbc
L_BBBF:
	ld hl,0bbdbh		;bbbf
	call L_BD81		;bbc2
	call L_BBB0		;bbc5
	ret c			;bbc8
	ld hl,0bbe8h		;bbc9
	call L_BD81		;bbcc
	call L_BBB0		;bbcf
	ret c			;bbd2
	ld hl,0bbf5h		;bbd3
	call L_BD81		;bbd6
	jr L_BBB0		;bbd9

; ----------------------------------------------------------------------
; DATOS tres_fichas_de_13: 3 fichas de 13 bytes que p03:BBBF, p03:BBC9 y la
;   siguiente pasan en HL a p03:BD81
;   0xbbdb..0xbc02  (39 bytes)
DATA_tres_fichas_de_13:
	defb 034h,010h,010h,010h,018h,010h,008h,010h,018h,030h,000h,010h,018h	; bbdb  4........0...
	defb 034h,000h,028h,010h,018h,020h,018h,010h,018h,008h,010h,010h,018h	; bbe8  4.(.. .......
	defb 034h,008h,040h,010h,018h,000h,040h,010h,018h,000h,038h,010h,018h	; bbf5  4.@...@...8..

; ======================================================================
; CODIGO 0xbc02..0xbc33  (49 bytes)
; ======================================================================


L_BC02:
	ld a,(0e70ah)		;bc02
	push af			;bc05
	ld a,(0e719h)		;bc06
	ld (0e70ah),a		;bc09
	call L_BD70		;bc0c
	pop af			;bc0f
	ld (0e70ah),a		;bc10
	jr $-99		;bc13
L_BC15:
	ld a,(iy+010h)		;bc15
	and a			;bc18
	jr z,L_BC1F		;bc19
	ld a,d			;bc1b
	add a,008h		;bc1c
	ld d,a			;bc1e
L_BC1F:
	exx			;bc1f
	ex de,hl			;bc20
	push hl			;bc21
	exx			;bc22
	pop hl			;bc23
	ret			;bc24
L_BC25:
	bit 2,(iy+002h)		;bc25
	jp z,L_BB73		;bc29
	ld a,(0e700h)		;bc2c
	dec a			;bc2f
	call 04140h		;bc30

; ----------------------------------------------------------------------
; DATOS tabla_BC33: 12 destinos del despachador de 0x4140 (call en p03:BC30):
;   0xBC69, 0xBC4B, 0xBC69, 0xBC69, 0x0000, 0x0000, 0xBC4E, 0xBC69 ...; lo
;   leen p03:BC30 (24 bytes)
;   0xbc33..0xbc4b  (24 bytes)
DATA_tabla_BC33:
	defb 069h,0bch	; bc33
	defb 04bh,0bch	; bc35
	defb 069h,0bch	; bc37
	defb 069h,0bch	; bc39
	defb 000h,000h	; bc3b
	defb 000h,000h	; bc3d
	defb 04eh,0bch	; bc3f
	defb 069h,0bch	; bc41
	defb 069h,0bch	; bc43
	defb 069h,0bch	; bc45
	defb 057h,0bch	; bc47
	defb 060h,0bch	; bc49

; ======================================================================
; CODIGO 0xbc4b..0xbd0a  (191 bytes)
; ======================================================================


L_BC4B:
	jp L_BD9D		;bc4b
L_BC4E:
	call L_BC69		;bc4e
	ret c			;bc51
	call L_BA04		;bc52
	jr L_BC6F		;bc55
L_BC57:
	call L_BC69		;bc57
	ret c			;bc5a
	call L_BA28		;bc5b
	jr L_BC6F		;bc5e
L_BC60:
	call L_BC69		;bc60
	ret c			;bc63
	call L_BA4C		;bc64
	jr L_BC6F		;bc67
L_BC69:
	call L_BB04		;bc69
	call 0420ah		;bc6c
L_BC6F:
	call L_BD8D		;bc6f
	jp L_BBB0		;bc72
L_BC75:
	ld a,(iy+000h)		;bc75
	cp 005h		;bc78
	jp z,L_BD15		;bc7a
	ld a,(iy+000h)		;bc7d
	cp 002h		;bc80
	push af			;bc82
	call z,L_B5AC		;bc83
	pop af			;bc86
	ld c,(iy+000h)		;bc87
	push bc			;bc8a
	call nz,L_AD76		;bc8b
	pop bc			;bc8e
	xor a			;bc8f
L_BC90:
	call L_BCC1		;bc90
	ret c			;bc93
	ld a,027h		;bc94
	call 04e1fh		;bc96
	dec (ix+010h)		;bc99
	jp z,L_BD32		;bc9c
L_BC9F:
	ld a,(0e710h)		;bc9f
	ld b,a			;bca2
	ld c,000h		;bca3
	ld a,(0e700h)		;bca5
	ld hl,07f97h		;bca8
	call 04155h		;bcab
	srl a		;bcae
	srl a		;bcb0
	cp b			;bcb2
	jr c,L_BCBC		;bcb3
	inc c			;bcb5
	srl a		;bcb6
	cp b			;bcb8
	jr c,L_BCBC		;bcb9
	inc c			;bcbb
L_BCBC:
	ld a,c			;bcbc
	ld (0e1c5h),a		;bcbd
	ret			;bcc0
L_BCC1:
	or a			;bcc1
	ld b,001h		;bcc2
	jr nz,L_BCE1		;bcc4
	ld a,c			;bcc6
	cp 001h		;bcc7
	ld b,020h		;bcc9
	jr z,L_BCE1		;bccb
	cp 002h		;bccd
	ld b,010h		;bccf
	jr z,L_BCE1		;bcd1
	cp 003h		;bcd3
	ld b,004h		;bcd5
	jr z,L_BCE1		;bcd7
	cp 004h		;bcd9
	ld b,008h		;bcdb
	jr z,L_BCE1		;bcdd
	ld b,002h		;bcdf
L_BCE1:
	ld a,(0e700h)		;bce1
	dec a			;bce4
	ld hl,0bd0ah		;bce5
	call 04136h		;bce8
	ld a,(hl)			;bceb
	and b			;bcec
	jr nz,L_BCFB		;bced
	ld a,c			;bcef
	cp 005h		;bcf0
	scf			;bcf2
	ret z			;bcf3
	ld a,01dh		;bcf4
	call 04e1fh		;bcf6
	scf			;bcf9
	ret			;bcfa
L_BCFB:
	ld a,(0e700h)		;bcfb
	cp 006h		;bcfe
	scf			;bd00
	ccf			;bd01
	ret nz			;bd02
	ld a,001h		;bd03
	ld (0e71ch),a		;bd05
	or a			;bd08
	ret			;bd09

; ----------------------------------------------------------------------
; DATOS mascaras_bd0a: 11 bytes que p03:BCE5 lee con (0xE700) - 1 y prueba con
;   el bit 3 o el 1
;   0xbd0a..0xbd15  (11 bytes)
DATA_mascaras_bd0a:
	defb 021h,009h,029h,021h,000h,011h,011h,005h,03fh,021h,003h	; bd0a  !.)!....?!.

; ======================================================================
; CODIGO 0xbd15..0xbf0b  (502 bytes)
; ======================================================================


L_BD15:
	bit 2,(iy+002h)		;bd15
	call z,L_BD4D		;bd19
	set 4,(ix+003h)		;bd1c
	xor a			;bd20
	ld c,005h		;bd21
	call L_BCC1		;bd23
	ret c			;bd26
	dec (ix+010h)		;bd27
	jr z,L_BD32		;bd2a
	dec (ix+010h)		;bd2c
	jp nz,L_BC9F		;bd2f
L_BD32:
	xor a			;bd32
	ld (0e1c5h),a		;bd33
	inc a			;bd36
	ld (0e02ch),a		;bd37
	ld a,084h		;bd3a
	call 04e1fh		;bd3c
	ld a,(0e041h)		;bd3f
	cp 00bh		;bd42
	ld a,091h		;bd44
	jr nz,L_BD4A		;bd46
	ld a,08bh		;bd48
L_BD4A:
	jp 05d12h		;bd4a
L_BD4D:
	call L_AE4B		;bd4d
	ld a,027h		;bd50
	jp 04e1fh		;bd52
L_BD55:
	ld a,(0e51bh)		;bd55
	or a			;bd58
	ret z			;bd59
	call L_B8FB		;bd5a
	ld ix,0e700h		;bd5d
	call L_BB5D		;bd61
	ret nc			;bd64
	xor a			;bd65
	ld (0e51bh),a		;bd66
	ld c,000h		;bd69
	ld a,001h		;bd6b
	jp L_BC90		;bd6d
L_BD70:
	call 0420ah		;bd70
	ld hl,091ech		;bd73
	ld a,(0e700h)		;bd76
	add a,a			;bd79
	call 04136h		;bd7a
	ld a,(hl)			;bd7d
	inc hl			;bd7e
	ld h,(hl)			;bd7f
	ld l,a			;bd80
L_BD81:
	ld b,(hl)			;bd81
	inc hl			;bd82
	ld a,(0e70ah)		;bd83
	sub b			;bd86
	add a,a			;bd87
	add a,a			;bd88
	ld c,a			;bd89
	ld b,000h		;bd8a
	add hl,bc			;bd8c
L_BD8D:
	ld c,(hl)			;bd8d
	inc hl			;bd8e
	ld b,(hl)			;bd8f
	inc hl			;bd90
	ld a,(hl)			;bd91
	inc hl			;bd92
	ld h,(hl)			;bd93
	ld l,a			;bd94
	jp 041ffh		;bd95
L_BD98:
	ld hl,01010h		;bd98
	jr L_BDA0		;bd9b
L_BD9D:
	call L_BDCC		;bd9d
L_BDA0:
	ld a,l			;bda0
	add a,018h		;bda1
	ld l,a			;bda3
	ld a,(0e705h)		;bda4
	add a,000h		;bda7
	ld b,a			;bda9
	ld a,e			;bdaa
	sub b			;bdab
	cp 028h		;bdac
	ret nc			;bdae
	ld a,(0e709h)		;bdaf
	and 020h		;bdb2
	ld a,(0e70bh)		;bdb4
	jr nz,L_BDBC		;bdb7
	ld a,(0e715h)		;bdb9
L_BDBC:
	dec a			;bdbc
	add a,a			;bdbd
	add a,a			;bdbe
	add a,a			;bdbf
	add a,h			;bdc0
	ld c,a			;bdc1
	ld a,(0e707h)		;bdc2
	and 0f8h		;bdc5
	ld b,a			;bdc7
	ld a,d			;bdc8
	sub b			;bdc9
	cp c			;bdca
	ret			;bdcb
L_BDCC:
	ld hl,00c04h		;bdcc
	ld a,d			;bdcf
	add a,006h		;bdd0
	ld d,a			;bdd2
	ld a,e			;bdd3
	add a,l			;bdd4
	ld e,a			;bdd5
	ret			;bdd6
L_BDD7:
	ld a,l			;bdd7
	add a,018h		;bdd8
	ld l,a			;bdda
	ld a,(0e705h)		;bddb
	add a,000h		;bdde
	ld b,a			;bde0
	ld a,e			;bde1
	sub b			;bde2
	cp l			;bde3
	ret nc			;bde4
	ld b,040h		;bde5
	ld a,(0e709h)		;bde7
	and 020h		;bdea
	ld a,(0e715h)		;bdec
	jr z,L_BDF4		;bdef
	ld a,(0e70bh)		;bdf1
L_BDF4:
	add a,a			;bdf4
	add a,a			;bdf5
	add a,a			;bdf6
	ld c,a			;bdf7
	ld a,(0e709h)		;bdf8
	and 020h		;bdfb
	jr z,L_BE07		;bdfd
	ld a,c			;bdff
	sub b			;be00
	jr nc,L_BE04		;be01
	xor a			;be03
L_BE04:
	ld e,a			;be04
	jr L_BE1D		;be05
L_BE07:
	ld a,(0e707h)		;be07
	and 0f8h		;be0a
	ld e,a			;be0c
	ld a,(0e709h)		;be0d
	and 020h		;be10
	ld a,000h		;be12
	jr nz,L_BE1C		;be14
	ld a,d			;be16
	sub 0f8h		;be17
	ld d,a			;be19
	ld a,0f8h		;be1a
L_BE1C:
	add a,e			;be1c
L_BE1D:
	ld a,c			;be1d
	cp b			;be1e
	jr nc,L_BE22		;be1f
	ld b,c			;be21
L_BE22:
	ld a,d			;be22
	sub e			;be23
	cp b			;be24
	ret			;be25
L_BE26:
	ld a,01ch		;be26
	ld (0e53dh),a		;be28
	ld hl,00258h		;be2b
	ld (0e53ah),hl		;be2e
	xor a			;be31
	ld (0e53ch),a		;be32
	ret			;be35
L_BE36:
	ld a,(0e53ch)		;be36
	dec a			;be39
	jr z,L_BE50		;be3a
	ld hl,(0e53ah)		;be3c
	dec hl			;be3f
	ld (0e53ah),hl		;be40
	ld a,h			;be43
	or l			;be44
	ret nz			;be45
	ld a,01eh		;be46
	ld hl,0e53ch		;be48
	inc (hl)			;be4b
L_BE4C:
	ld (0e53dh),a		;be4c
	ret			;be4f
L_BE50:
	ld hl,0e53ah		;be50
	inc (hl)			;be53
	ld a,(hl)			;be54
	and 007h		;be55
	ret nz			;be57
	ld a,(0e53dh)		;be58
	xor 001h		;be5b
	jr L_BE4C		;be5d
L_BE5F:
	ld a,(0e505h)		;be5f
	ld (0e53eh),a		;be62
	ld a,004h		;be65
	ld (0e502h),a		;be67
	ld a,009h		;be6a
	ld (0e50fh),a		;be6c
	xor a			;be6f
	ld (0e50eh),a		;be70
	call L_A8FC		;be73
	inc a			;be76
	ld (0e53fh),a		;be77
L_BE7A:
	ld hl,0f600h		;be7a
	ld (0e512h),hl		;be7d
	ret			;be80
L_BE81:
	call 073d6h		;be81
	call 05435h		;be84
	ld a,(0e50eh)		;be87
	and a			;be8a
	jr nz,L_BEC7		;be8b
	ld de,00080h		;be8d
	ld hl,(0e512h)		;be90
	add hl,de			;be93
	ld (0e512h),hl		;be94
	ex de,hl			;be97
	ld hl,(0e504h)		;be98
	add hl,de			;be9b
	ld l,000h		;be9c
	ld (0e504h),hl		;be9e
	ld a,h			;bea1
	ld hl,0e53eh		;bea2
	cp (hl)			;bea5
	ret c			;bea6
	ld hl,0e50fh		;bea7
	dec (hl)			;beaa
	jr z,L_BEBB		;beab
	call L_BE7A		;bead
	ld a,(0e503h)		;beb0
	xor 001h		;beb3
	ld (0e503h),a		;beb5
	jp L_A458		;beb8
L_BEBB:
	ld hl,0e50eh		;bebb
	inc (hl)			;bebe
	ld a,078h		;bebf
	ld (0e50fh),a		;bec1
	jp L_A3E3		;bec4
L_BEC7:
	ld hl,0e50fh		;bec7
	dec (hl)			;beca
	jr z,L_BEF7		;becb
	ld de,0eb00h		;becd
	ld bc,0001dh		;bed0
	ld hl,0ee41h		;bed3
	ldir		;bed6
	ld de,0ee41h		;bed8
	ld hl,0bf0bh		;bedb
	ld c,01dh		;bede
	ldir		;bee0
	ld a,(0e041h)		;bee2
	ld (0ee55h),a		;bee5
	call 054bfh		;bee8
	ld hl,0eb00h		;beeb
	ld de,0ee41h		;beee
	ld bc,0001dh		;bef1
	ldir		;bef4
	ret			;bef6
L_BEF7:
	xor a			;bef7
	ld (0e53fh),a		;bef8
	call L_B366		;befb
	xor a			;befe
	ld (0e518h),a		;beff
L_BF02:
	ld a,(0e505h)		;bf02
	and 0f8h		;bf05
	ld (0e505h),a		;bf07
	ret			;bf0a

; ----------------------------------------------------------------------
; DATOS mundo_recuperado: I HAVE TAKEN WORLD   BACK con la fuente de los
;   mensajes (29 bytes): p03:BEDB lo copia a 0xEE41 y p03:BEE5 pone el numero
;   de mapa en el hueco (0xEE55)
;   0xbf0b..0xbf28  (29 bytes)
DATA_mundo_recuperado:
	defb 000h,013h,000h,012h,00bh,020h,00fh,000h,01eh,00bh,015h,00fh,018h,000h,021h,019h	; bf0b  ..... ........!.
	defb 01ch,016h,00eh,000h,000h,000h,00ch,00bh,00dh,015h,000h,028h,000h	; bf1b  ...........(.

; ----------------------------------------------------------------------
; DATOS byte_por_tipo_bf27: un byte por tipo de figura 0-0x6B que p03:B624 lee
;   en 0xBF27 + (ix+0) (el del tipo 0 es el ultimo byte del texto de delante)
;   0xbf28..0xbf93  (107 bytes)
DATA_byte_por_tipo_bf27:
	defb 006h,003h,001h,001h,005h,000h,002h,000h,000h,004h,004h,004h,002h,001h,004h,001h	; bf28  ................
	defb 002h,003h,003h,004h,008h,006h,003h,001h,001h,000h,000h,001h,000h,000h,004h,000h	; bf38  ................
	defb 001h,006h,004h,002h,004h,003h,005h,002h,000h,001h,004h,002h,002h,001h,001h,003h	; bf48  ................
	defb 000h,000h,000h,001h,000h,000h,000h,001h,008h,000h,000h,004h,000h,002h,000h,008h	; bf58  ................
	defb 000h,004h,008h,000h,000h,000h,000h,000h,003h,000h,000h,005h,000h,000h,000h,000h	; bf68  ................
	defb 000h,002h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,002h	; bf78  ................
	defb 000h,004h,000h,002h,000h,000h,000h,000h,000h,000h,000h	; bf88  ...........

; ----------------------------------------------------------------------
; DATOS relleno_b3: relleno: 93 bytes 0xFF entre los datos y la marca del
;   final del banco
;   0xbf93..0xbff0  (93 bytes)
DATA_relleno_b3:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf93  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfa3  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfb3  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfc3  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfd3  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfe3  .............

; ----------------------------------------------------------------------
; DATOS marca_de_konami: la marca de Konami del final del banco 3 (la destapo
;   Manuel Pazos): leyendo hacia atras, 0xAA, 0x49 (el RC-749 en BCD), 0x0D
;   (13 caracteres) y el titulo al reves con la fuente del juego (katakana
;   desde 0xBA): ガリウス ノ メイキュウ. Sus 6 ultimos bytes son los que otros cartuchos
;   de Konami buscan en 0xBFFA
;   0xbff0..0xc000  (16 bytes)
DATA_marca_de_konami:
	defb 0bch,0eah,0c0h,0bbh,0dbh,000h,0d2h,000h,0c6h,0bch,0e1h,0ech,0bfh,00dh,049h,0aah	; bff0  ..............I.
