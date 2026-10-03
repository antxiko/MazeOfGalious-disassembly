; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l68e3h:	equ 0x068e3
l6c87h:	equ 0x06c87

; ----------------------------------------------------------------------
; DATOS partida_5FFF_cola: la instruccion de p00:5FFF (32 | 07 E5) empieza al
;   final del banco 0 y acaba al principio del 1, que el cartucho pone siempre
;   a continuacion: aqui el resto; lo leen p00:5FFF (2 bytes)
;   0x6000..0x6002  (2 bytes)
DATA_partida_5FFF_cola:
	defb 007h,0e5h	; 6000

; ======================================================================
; CODIGO 0x6002..0x601b  (25 bytes)
; ======================================================================


L_6002:
	ret			;6002
L_6003:
	ld hl,06017h		;6003
	ld a,(0e041h)		;6006
	call 0414ch		;6009
L_600C:
	ld a,e			;600c
	ld (0e505h),a		;600d
	ld a,d			;6010
	ld (0e507h),a		;6011
	ret			;6014
L_6015:
	ld de,(0e0d0h)		;6015
	jr L_600C		;6019

; ----------------------------------------------------------------------
; DATOS salida_por_mundo: 10 palabras, mapas 2-11, que p01:6003 lee en 0x6017
;   + 2 x mapa (0x414C): el byte bajo es la Y (0xE505) y el alto la X (0xE507)
;   donde aparece el jugador (la entrada del mapa 1 son los bytes del `jr` de
;   0x6019)
;   0x601b..0x602f  (20 bytes)
DATA_salida_por_mundo:
	defb 038h,080h	; 601b
	defb 098h,080h	; 601d
	defb 098h,080h	; 601f
	defb 0b8h,020h	; 6021
	defb 078h,0e0h	; 6023
	defb 038h,080h	; 6025
	defb 0b8h,088h	; 6027
	defb 038h,080h	; 6029
	defb 038h,020h	; 602b
	defb 038h,018h	; 602d

; ======================================================================
; CODIGO 0x602f..0x6261  (562 bytes)
; ======================================================================


L_602F:
	xor a			;602f
	ld (0e690h),a		;6030
	ld (0e603h),a		;6033
	ld (0e536h),a		;6036
	ld (0e539h),a		;6039
	ld (0e520h),a		;603c
	ld hl,0e620h		;603f
	ld de,0e621h		;6042
	ld bc,0001fh		;6045
	ld (hl),000h		;6048
	ldir		;604a
	ret			;604c
L_604D:
	ld de,07caeh		;604d
	call 05c25h		;6050
	call 05f79h		;6053
	call 05f84h		;6056
	call 05f8fh		;6059
	call L_606B		;605c
	call L_60A3		;605f
	call L_60AD		;6062
	call L_60B7		;6065
	jp L_60C1		;6068
L_606B:
	ld hl,0383ch		;606b
	call 05bc8h		;606e
	exx			;6071
	ld a,(0e510h)		;6072
	add a,a			;6075
	ld hl,05f6bh		;6076
	ld e,a			;6079
	ld d,000h		;607a
	add hl,de			;607c
	ld b,002h		;607d
L_607F:
	outi		;607f
	jp nz,L_607F		;6081
	ret			;6084
L_6085:
	ld a,(0e062h)		;6085
	or a			;6088
	ret z			;6089
	rra			;608a
	push af			;608b
	call c,L_60A3		;608c
	pop af			;608f
	rra			;6090
	push af			;6091
	call c,L_60B7		;6092
	pop af			;6095
	rra			;6096
	push af			;6097
	call c,L_60AD		;6098
	pop af			;609b
	rra			;609c
	push af			;609d
	call c,L_60C1		;609e
	pop af			;60a1
	ret			;60a2
L_60A3:
	ld de,0e056h		;60a3
	ld hl,03822h		;60a6
	ld b,02dh		;60a9
	jr L_60C9		;60ab
L_60AD:
	ld de,0e052h		;60ad
	ld hl,0382dh		;60b0
	ld b,038h		;60b3
	jr L_60C9		;60b5
L_60B7:
	ld de,0e054h		;60b7
	ld hl,03842h		;60ba
	ld b,02dh		;60bd
	jr L_60C9		;60bf
L_60C1:
	ld de,0e050h		;60c1
	ld hl,0384dh		;60c4
	ld b,038h		;60c7
L_60C9:
	ld (0f000h),hl		;60c9
	ld a,b			;60cc
	exx			;60cd
	ld b,a			;60ce
	exx			;60cf
	ld hl,0f008h		;60d0
	ld (hl),036h		;60d3
	ld bc,00635h		;60d5
L_60D8:
	inc l			;60d8
	ld (hl),c			;60d9
	djnz L_60D8		;60da
	ld hl,0f009h		;60dc
	ld a,(de)			;60df
	rra			;60e0
	rra			;60e1
	rra			;60e2
	and 01fh		;60e3
	jr z,L_60F1		;60e5
	ld b,a			;60e7
	exx			;60e8
	ld a,b			;60e9
	exx			;60ea
	add a,007h		;60eb
L_60ED:
	ld (hl),a			;60ed
	inc l			;60ee
	djnz L_60ED		;60ef
L_60F1:
	ld a,(de)			;60f1
	and 007h		;60f2
	jr z,L_60FB		;60f4
	dec a			;60f6
	exx			;60f7
	add a,b			;60f8
	exx			;60f9
	ld (hl),a			;60fa
L_60FB:
	inc e			;60fb
	ld a,(de)			;60fc
	rra			;60fd
	rra			;60fe
	rra			;60ff
	and 01fh		;6100
	ld hl,0f009h		;6102
	add a,l			;6105
	ld l,a			;6106
	ld a,02ch		;6107
	ld (hl),a			;6109
	ld hl,0f00fh		;610a
	ld (hl),037h		;610d
	call 054ddh		;610f
	ld hl,(0f000h)		;6112
	call 05bc8h		;6115
	exx			;6118
	ld hl,0f008h		;6119
	ld b,008h		;611c
L_611E:
	outi		;611e
	jp nz,L_611E		;6120
	jp 054e1h		;6123
L_6126:
	ld c,a			;6126
	ld a,(0f000h)		;6127
	jr L_6130		;612a
L_612C:
	ld c,a			;612c
	ld a,(0e501h)		;612d
L_6130:
	ld hl,0e05eh		;6130
	or a			;6133
	jr z,L_6138		;6134
	ld l,061h		;6136
L_6138:
	ld a,c			;6138
	or a			;6139
	jp m,L_6142		;613a
	add a,(hl)			;613d
	or a			;613e
	ret m			;613f
	jr L_6145		;6140
L_6142:
	add a,(hl)			;6142
	or a			;6143
	ret p			;6144
L_6145:
	ld a,c			;6145
	add a,(hl)			;6146
	ld (hl),a			;6147
	ld a,c			;6148
	or a			;6149
	ret z			;614a
	rl c		;614b
	ret c			;614d
	ld a,(0e61eh)		;614e
	or a			;6151
	ret nz			;6152
	ld a,029h		;6153
	jp 04e1fh		;6155
L_6158:
	ld d,a			;6158
	ld e,000h		;6159
	ld a,(0e501h)		;615b
	or a			;615e
	jr nz,L_6169		;615f
	ld hl,(0e05ch)		;6161
	add hl,de			;6164
	ld (0e05ch),hl		;6165
	ret			;6168
L_6169:
	ld hl,(0e05fh)		;6169
	add hl,de			;616c
	ld (0e05fh),hl		;616d
	ret			;6170
L_6171:
	xor a			;6171
	ld (0e062h),a		;6172
	ld a,(0e500h)		;6175
	cp 005h		;6178
	ret z			;617a
	ld a,(0e604h)		;617b
	inc a			;617e
	and 003h		;617f
	ret nz			;6181
	call L_618D		;6182
	call L_61B2		;6185
	ld a,c			;6188
	ld (0e062h),a		;6189
	ret			;618c
L_618D:
	xor a			;618d
	ld (0f000h),a		;618e
	ld hl,0e050h		;6191
	ld de,0e05dh		;6194
	call L_61D8		;6197
	ld hl,0e052h		;619a
	ld de,0e05eh		;619d
	call L_61F3		;61a0
	ld a,(0e052h)		;61a3
	or a			;61a6
	ret nz			;61a7
	push bc			;61a8
	ld a,(0e501h)		;61a9
	or a			;61ac
	call z,0b337h		;61ad
	pop bc			;61b0
	ret			;61b1
L_61B2:
	ld a,001h		;61b2
	ld (0f000h),a		;61b4
	ld hl,0e054h		;61b7
	ld de,0e060h		;61ba
	call L_61D8		;61bd
	ld hl,0e056h		;61c0
	ld de,0e061h		;61c3
	call L_61F3		;61c6
	ld a,(0e056h)		;61c9
	or a			;61cc
	ret nz			;61cd
	push bc			;61ce
	ld a,(0e501h)		;61cf
	or a			;61d2
	call nz,0b337h		;61d3
	pop bc			;61d6
	ret			;61d7
L_61D8:
	call L_6203		;61d8
	rl c		;61db
	bit 0,c		;61dd
	ret z			;61df
	ld a,(hl)			;61e0
	inc l			;61e1
	sub (hl)			;61e2
	ret c			;61e3
	dec l			;61e4
	ld (hl),a			;61e5
	inc l			;61e6
	inc l			;61e7
	ld a,(hl)			;61e8
	inc l			;61e9
	cp (hl)			;61ea
	ret nc			;61eb
	ld a,(hl)			;61ec
	exx			;61ed
	call L_6126		;61ee
	exx			;61f1
	ret			;61f2
L_61F3:
	call L_6203		;61f3
	rl c		;61f6
	bit 0,c		;61f8
	ret z			;61fa
	ld a,(hl)			;61fb
	inc l			;61fc
	cp (hl)			;61fd
	ret c			;61fe
	ld a,(hl)			;61ff
	dec l			;6200
	ld (hl),a			;6201
	ret			;6202
L_6203:
	ld a,(de)			;6203
	or a			;6204
	ret z			;6205
	jp p,L_620F		;6206
	dec (hl)			;6209
	ld a,(de)			;620a
	inc a			;620b
	ld (de),a			;620c
	scf			;620d
	ret			;620e
L_620F:
	inc (hl)			;620f
	ld a,(de)			;6210
	dec a			;6211
	ld (de),a			;6212
	scf			;6213
	ret			;6214
L_6215:
	call 05280h		;6215
	ld hl,093e7h		;6218
	ld de,0ec80h		;621b
	ld bc,00010h		;621e
	ldir		;6221
	ld de,0ed29h		;6223
	ld hl,0933fh		;6226
	ld bc,00c0eh		;6229
	call L_6D49		;622c
	ld de,07d51h		;622f
	call 05c25h		;6232
	xor a			;6235
	ld (0f01fh),a		;6236
	ld (0f020h),a		;6239
	ld (0f031h),a		;623c
	inc a			;623f
	ld (0e019h),a		;6240
	ld a,030h		;6243
	ld (0f02bh),a		;6245
L_6248:
	ld bc,001a0h		;6248
	call 054f6h		;624b
	jp 05474h		;624e
L_6251:
	call L_6248		;6251
	ld a,(0f031h)		;6254
	or a			;6257
	jp z,L_62DA		;6258
	ld a,(0f01fh)		;625b
	call 04140h		;625e

; ----------------------------------------------------------------------
; DATOS tabla_6261: 3 destinos del despachador de 0x4140 (call en p01:625E):
;   0x6267, 0x6298, 0x628E; lo leen p01:625E (6 bytes)
;   0x6261..0x6267  (6 bytes)
DATA_tabla_6261:
	defb 067h,062h	; 6261
	defb 098h,062h	; 6263
	defb 08eh,062h	; 6265

; ======================================================================
; CODIGO 0x6267..0x62a7  (64 bytes)
; ======================================================================


L_6267:
	ld hl,0ec99h		;6267
	inc (hl)			;626a
	inc (hl)			;626b
	ld a,(hl)			;626c
	cp 06eh		;626d
	jr z,L_6286		;626f
	cp 07ch		;6271
	jr z,L_6286		;6273
	cp 08ah		;6275
	jr z,L_6286		;6277
	cp 098h		;6279
	ret nz			;627b
	ld a,0e0h		;627c
	ld (0ec98h),a		;627e
L_6281:
	ld hl,0f01fh		;6281
	inc (hl)			;6284
	ret			;6285
L_6286:
	ld hl,0ec9ah		;6286
	ld a,(hl)			;6289
	add a,004h		;628a
	ld (hl),a			;628c
	ret			;628d
L_628E:
	ld hl,0f02ch		;628e
	dec (hl)			;6291
	ret nz			;6292
	xor a			;6293
	ld (0e019h),a		;6294
	ret			;6297
L_6298:
	ld a,(0e003h)		;6298
	and 00fh		;629b
	ret nz			;629d
	ld hl,0f020h		;629e
	inc (hl)			;62a1
	ld a,(hl)			;62a2
	dec a			;62a3
	call 04140h		;62a4

; ----------------------------------------------------------------------
; DATOS tabla_62A7: 5 destinos del despachador de 0x4140 (call en p01:62A4):
;   0x62B1, 0x62BD, 0x62BD, 0x62B1, 0x62C2; lo leen p01:62A4 (10 bytes)
;   0x62a7..0x62b1  (10 bytes)
DATA_tabla_62A7:
	defb 0b1h,062h	; 62a7
	defb 0bdh,062h	; 62a9
	defb 0bdh,062h	; 62ab
	defb 0b1h,062h	; 62ad
	defb 0c2h,062h	; 62af

; ======================================================================
; CODIGO 0x62b1..0x66bf  (1038 bytes)
; ======================================================================


L_62B1:
	ld hl,093f7h		;62b1
L_62B4:
	ld de,0ec98h		;62b4
	ld bc,00008h		;62b7
	ldir		;62ba
	ret			;62bc
L_62BD:
	ld hl,093ffh		;62bd
	jr L_62B4		;62c0
L_62C2:
	ld hl,0ec98h		;62c2
	ld b,002h		;62c5
	ld a,0e0h		;62c7
L_62C9:
	ld (hl),a			;62c9
	inc hl			;62ca
	inc hl			;62cb
	inc hl			;62cc
	inc hl			;62cd
	djnz L_62C9		;62ce
	call L_6248		;62d0
	ld a,078h		;62d3
	ld (0f02ch),a		;62d5
	jr $-87		;62d8
L_62DA:
	ld hl,0f02bh		;62da
	dec (hl)			;62dd
	ret nz			;62de
	ld hl,09407h		;62df
	ld de,0ec98h		;62e2
	ld bc,00004h		;62e5
	ldir		;62e8
	ld hl,0f031h		;62ea
	inc (hl)			;62ed
	ret			;62ee
L_62EF:
	xor a			;62ef
	ld (0e6a0h),a		;62f0
	ld bc,(0e041h)		;62f3
	dec c			;62f7
	ret nz			;62f8
	ld hl,0b8a2h		;62f9
	ld a,b			;62fc
	dec a			;62fd
	jr z,L_6309		;62fe
	ld b,a			;6300
L_6301:
	ld a,(hl)			;6301
	inc hl			;6302
	or a			;6303
	jr nz,L_6301		;6304
	dec b			;6306
	jr nz,L_6301		;6307
L_6309:
	ld a,(hl)			;6309
	or a			;630a
	ret z			;630b
	inc hl			;630c
	call L_635D		;630d
	jr nz,L_6309		;6310
	dec hl			;6312
	ld a,(hl)			;6313
	and 0e0h		;6314
	or 008h		;6316
	ld e,a			;6318
	ld a,(hl)			;6319
	and 01fh		;631a
	rlca			;631c
	rlca			;631d
	rlca			;631e
	ld d,a			;631f
	ld (0f002h),de		;6320
	push hl			;6324
	call L_632C		;6325
	pop hl			;6328
	inc hl			;6329
	jr L_6309		;632a
L_632C:
	ld hl,0ec30h		;632c
	ld b,003h		;632f
	ld de,00008h		;6331
	xor a			;6334
L_6335:
	cp (hl)			;6335
	jr z,L_633C		;6336
	add hl,de			;6338
	djnz L_6335		;6339
	ret			;633b
L_633C:
	ld (hl),001h		;633c
	inc l			;633e
	ld (hl),000h		;633f
	inc l			;6341
	ld de,(0f002h)		;6342
	ld (hl),e			;6346
	inc l			;6347
	ld (hl),d			;6348
	push hl			;6349
	ex de,hl			;634a
	call 04da1h		;634b
	ex de,hl			;634e
	pop hl			;634f
	inc l			;6350
	ld (hl),e			;6351
	inc l			;6352
	ld (hl),d			;6353
	inc l			;6354
	ld (hl),00fh		;6355
	inc l			;6357
	ld a,(0e6a0h)		;6358
	ld (hl),a			;635b
	ret			;635c
L_635D:
	exx			;635d
	ld hl,0e6a0h		;635e
	inc (hl)			;6361
	ld a,(hl)			;6362
	add a,005h		;6363
	ld b,a			;6365
	xor a			;6366
	scf			;6367
L_6368:
	rla			;6368
	djnz L_6368		;6369
	ld hl,(0e60eh)		;636b
	and (hl)			;636e
	exx			;636f
	ret			;6370
L_6371:
	ld ix,0ec30h		;6371
	exx			;6375
	ld b,003h		;6376
	ld de,00008h		;6378
L_637B:
	exx			;637b
	call L_6385		;637c
	exx			;637f
	add ix,de		;6380
	djnz L_637B		;6382
	ret			;6384
L_6385:
	ld a,(ix+000h)		;6385
	or a			;6388
	ret z			;6389
	ld a,(ix+001h)		;638a
	or a			;638d
	ret z			;638e
	dec (ix+006h)		;638f
	ret nz			;6392
	ld (ix+000h),000h		;6393
	ret			;6397
L_6398:
	ld a,(0e090h)		;6398
	or a			;639b
	ret z			;639c
	ld a,(0e008h)		;639d
	and 010h		;63a0
	ret z			;63a2
	ld hl,0e632h		;63a3
	ld a,(hl)			;63a6
	or a			;63a7
	ret nz			;63a8
	ld (hl),001h		;63a9
	ld ix,0ec30h		;63ab
	ld b,003h		;63af
	ld de,00008h		;63b1
L_63B4:
	ld a,(ix+000h)		;63b4
	or a			;63b7
	jr z,L_63BD		;63b8
	call 0b85ch		;63ba
L_63BD:
	add ix,de		;63bd
	djnz L_63B4		;63bf
	ret			;63c1
L_63C2:
	ld ix,0e4a0h		;63c2
	ld hl,0bb24h		;63c6
	exx			;63c9
	ld hl,0bb54h		;63ca
	ld b,006h		;63cd
L_63CF:
	ld a,(hl)			;63cf
	inc hl			;63d0
	ex af,af'			;63d1
	ld a,b			;63d2
	exx			;63d3
	ld b,000h		;63d4
	ld e,a			;63d6
	ex af,af'			;63d7
	ld c,080h		;63d8
	push hl			;63da
	call L_640B		;63db
	pop hl			;63de
	ld de,00008h		;63df
	add ix,de		;63e2
	add hl,de			;63e4
	exx			;63e5
	djnz L_63CF		;63e6
	exx			;63e8
	ret			;63e9
L_63EA:
	ld hl,(0e041h)		;63ea
	dec l			;63ed
	ret nz			;63ee
	ld c,000h		;63ef
	ld ix,0ec20h		;63f1
	ld a,h			;63f5
	ld hl,0ba53h		;63f6
	ld b,00fh		;63f9
L_63FB:
	cp (hl)			;63fb
	jr z,L_6404		;63fc
	inc hl			;63fe
	inc hl			;63ff
	inc hl			;6400
	djnz L_63FB		;6401
	ret			;6403
L_6404:
	inc hl			;6404
	ld e,(hl)			;6405
	inc hl			;6406
	ld d,(hl)			;6407
	ex de,hl			;6408
	ld e,001h		;6409
L_640B:
	ld (ix+000h),e		;640b
	ld (ix+001h),a		;640e
	ld (ix+002h),c		;6411
	ld (ix+003h),b		;6414
	xor a			;6417
	ld (ix+004h),a		;6418
	ld d,(hl)			;641b
	inc hl			;641c
	ld (ix+005h),d		;641d
	ld (ix+006h),a		;6420
	ld d,(hl)			;6423
	inc hl			;6424
	ld (ix+007h),d		;6425
	ld de,00008h		;6428
	add ix,de		;642b
	push ix		;642d
	pop de			;642f
	ldi		;6430
	ldi		;6432
	inc de			;6434
	inc de			;6435
	ld bc,00004h		;6436
	ldir		;6439
	ret			;643b
L_643C:
	ld ix,0e4a0h		;643c
	exx			;6440
	ld b,006h		;6441
	ld de,00010h		;6443
L_6446:
	exx			;6446
	call L_647A		;6447
	exx			;644a
	add ix,de		;644b
	djnz L_6446		;644d
	exx			;644f
	ld a,(0e041h)		;6450
	dec a			;6453
	ret nz			;6454
	ld hl,0e4a1h		;6455
	ld b,006h		;6458
	ld de,00010h		;645a
L_645D:
	ld a,(0e042h)		;645d
	cp (hl)			;6460
	jr z,L_6470		;6461
	add hl,de			;6463
	djnz L_645D		;6464
	xor a			;6466
	ld (0ec10h),a		;6467
	ld a,0e0h		;646a
	ld (0ec15h),a		;646c
	ret			;646f
L_6470:
	dec hl			;6470
	ld de,0ec10h		;6471
	ld bc,00010h		;6474
	ldir		;6477
	ret			;6479
L_647A:
	call L_64EE		;647a
	res 2,(ix+002h)		;647d
	bit 1,(ix+002h)		;6481
	jr z,L_64A2		;6485
	ld a,(0e52dh)		;6487
	cp (ix+000h)		;648a
	jr nz,L_6495		;648d
	ld a,(0e52ch)		;648f
	dec a			;6492
	jr z,L_649B		;6493
L_6495:
	ld a,(ix+005h)		;6495
	cp 028h		;6498
	ret nc			;649a
L_649B:
	dec (ix+003h)		;649b
	ld c,0b9h		;649e
	jr L_64AD		;64a0
L_64A2:
	ld a,(ix+005h)		;64a2
	cp 0c0h		;64a5
	ret c			;64a7
	inc (ix+003h)		;64a8
	ld c,028h		;64ab
L_64AD:
	ld a,(ix+000h)		;64ad
	dec a			;64b0
	ld hl,0ba80h		;64b1
	call 0414ch		;64b4
	ex de,hl			;64b7
	ld e,(ix+003h)		;64b8
	ld d,000h		;64bb
	add hl,de			;64bd
	ld a,(hl)			;64be
	ld (ix+001h),a		;64bf
	ld (ix+005h),c		;64c2
	ld a,(ix+002h)		;64c5
	and 087h		;64c8
	ld (ix+002h),a		;64ca
	ld a,(0ec10h)		;64cd
	cp (ix+000h)		;64d0
	ret nz			;64d3
	ld a,(0e52dh)		;64d4
	cp (ix+000h)		;64d7
	jr nz,L_64E3		;64da
	xor a			;64dc
	ld (0e52bh),a		;64dd
	ld (0e52dh),a		;64e0
L_64E3:
	ld a,(0ec12h)		;64e3
	bit 0,a		;64e6
	ret z			;64e8
	set 2,(ix+002h)		;64e9
	ret			;64ed
L_64EE:
	ld l,(ix+004h)		;64ee
	ld h,(ix+005h)		;64f1
	ld e,(ix+008h)		;64f4
	ld d,(ix+009h)		;64f7
	add hl,de			;64fa
	ld (ix+004h),l		;64fb
	ld (ix+005h),h		;64fe
	bit 1,(ix+002h)		;6501
	ld a,(ix+001h)		;6505
	jr z,L_6516		;6508
	cp (ix+00ch)		;650a
	ret nz			;650d
	ld a,h			;650e
	inc a			;650f
	cp (ix+00dh)		;6510
	ret nc			;6513
	jr L_651F		;6514
L_6516:
	cp (ix+00eh)		;6516
	ret nz			;6519
	ld a,h			;651a
	cp (ix+00fh)		;651b
	ret c			;651e
L_651F:
	call 0415ch		;651f
	ld (ix+008h),e		;6522
	ld (ix+009h),d		;6525
	ld a,(ix+002h)		;6528
	xor 002h		;652b
	ld (ix+002h),a		;652d
	ret			;6530
L_6531:
	ld ix,0ec20h		;6531
	ld a,(ix+000h)		;6535
	and a			;6538
	ret z			;6539
	ld hl,(0ec26h)		;653a
	ld (0ec2ah),hl		;653d
	ld bc,(0ec28h)		;6540
	add hl,bc			;6544
	ld (0ec26h),hl		;6545
	ld de,(0ec2ah)		;6548
	or a			;654c
	sbc hl,de		;654d
	ld (0ec2ah),hl		;654f
	ex de,hl			;6552
	ld e,c			;6553
	ld d,b			;6554
	bit 1,(ix+002h)		;6555
	jr z,L_6562		;6559
	ld a,(0ec2dh)		;655b
	cp h			;655e
	ret c			;655f
	jr L_6568		;6560
L_6562:
	ld a,(0ec2fh)		;6562
	dec a			;6565
	cp h			;6566
	ret nc			;6567
L_6568:
	ld (0ec2ah),a		;6568
	jp L_651F		;656b
L_656E:
	xor a			;656e
	ld (0e614h),a		;656f
	ld hl,01110h		;6572
	ld (0e635h),hl		;6575
	ld de,(0e041h)		;6578
	dec e			;657c
	ret nz			;657d
	ld c,d			;657e
	srl c		;657f
	srl c		;6581
	ld b,000h		;6583
	ld hl,0ba2eh		;6585
	add hl,bc			;6588
	ld a,d			;6589
	add a,a			;658a
	and 006h		;658b
	ld b,a			;658d
	ld a,(hl)			;658e
	jr z,L_6594		;658f
L_6591:
	rra			;6591
	djnz L_6591		;6592
L_6594:
	and 003h		;6594
	ret z			;6596
	cp 003h		;6597
	ret z			;6599
	ld (0e614h),a		;659a
	ld hl,0ba28h		;659d
	call 0414ch		;65a0
	ld (0e635h),de		;65a3
	ret			;65a7
L_65A8:
	call 0422bh		;65a8
	call L_660D		;65ab
	call 05280h		;65ae
	call L_65C6		;65b1
	call L_66C2		;65b4
	call L_6715		;65b7
	call L_677A		;65ba
	call L_661B		;65bd
	call 054bfh		;65c0
	jp 04215h		;65c3
L_65C6:
	ld a,(0e501h)		;65c6
	or a			;65c9
	ld hl,0e05eh		;65ca
	jr z,L_65D1		;65cd
	ld l,061h		;65cf
L_65D1:
	ld a,(hl)			;65d1
	or a			;65d2
	jp p,L_65D8		;65d3
	ld (hl),000h		;65d6
L_65D8:
	ld a,(0e501h)		;65d8
	ld hl,0e058h		;65db
	add a,l			;65de
	ld l,a			;65df
	ld a,(hl)			;65e0
	add a,001h		;65e1
	daa			;65e3
	ld (hl),a			;65e4
	ld hl,0e04ch		;65e5
	ld (hl),000h		;65e8
	ld a,(0e501h)		;65ea
	inc l			;65ed
	ld (hl),a			;65ee
	ld a,(0e510h)		;65ef
	inc l			;65f2
	ld (hl),a			;65f3
	or a			;65f4
	ret nz			;65f5
	ld c,001h		;65f6
	ld b,006h		;65f8
	ld de,0e070h		;65fa
L_65FD:
	ld a,(de)			;65fd
	or a			;65fe
	jr nz,L_6607		;65ff
	inc c			;6601
	inc e			;6602
	djnz L_65FD		;6603
	ld c,000h		;6605
L_6607:
	ld (hl),c			;6607
	ld a,c			;6608
	ld (0e510h),a		;6609
	ret			;660c
L_660D:
	ld hl,0ed80h		;660d
	ld de,0ed81h		;6610
	ld bc,0027fh		;6613
	ld (hl),000h		;6616
	ldir		;6618
	ret			;661a
L_661B:
	ld a,(0e079h)		;661b
	or a			;661e
	ret z			;661f
	ld de,0ef26h		;6620
	ld hl,066bfh		;6623
	ld bc,00003h		;6626
	ldir		;6629
	ld hl,0af2ah		;662b
	ld a,(0e041h)		;662e
	dec a			;6631
	ret z			;6632
	call 0414ch		;6633
	ex de,hl			;6636
	ld e,(hl)			;6637
	inc hl			;6638
	ld d,(hl)			;6639
	ld (0f000h),de		;663a
	inc hl			;663e
	ld c,(hl)			;663f
	inc hl			;6640
	ld b,(hl)			;6641
	ld (0f002h),bc		;6642
	inc hl			;6646
	ld (0f004h),hl		;6647
L_664A:
	ld de,(0f000h)		;664a
	ld a,(0f002h)		;664e
	ld c,a			;6651
	ld b,000h		;6652
	ld hl,(0f004h)		;6654
	ldir		;6657
	ld (0f004h),hl		;6659
	ld hl,(0f000h)		;665c
	ld bc,00020h		;665f
	add hl,bc			;6662
	ld (0f000h),hl		;6663
	ld hl,0f003h		;6666
	dec (hl)			;6669
	jr nz,L_664A		;666a
	ld a,(0e041h)		;666c
	ld hl,0b038h		;666f
	call 0414ch		;6672
	ex de,hl			;6675
	ld a,(0e042h)		;6676
	ld e,a			;6679
	ld d,000h		;667a
	add hl,de			;667c
	ex de,hl			;667d
	ld a,(0e041h)		;667e
	dec a			;6681
	ld hl,0e670h		;6682
	ld a,(de)			;6685
	ld (0f020h),a		;6686
	ret z			;6689
	ld c,008h		;668a
	call L_66A5		;668c
	ld a,(0e089h)		;668f
	and a			;6692
	ret z			;6693
	ld a,(0e041h)		;6694
	ld hl,0b0fch		;6697
	call 04155h		;669a
	ld (0f020h),a		;669d
	ld hl,0e674h		;66a0
	ld c,005h		;66a3
L_66A5:
	and 0f0h		;66a5
	rrca			;66a7
	rrca			;66a8
	and 03ch		;66a9
	add a,090h		;66ab
	ld (hl),a			;66ad
	ld a,(0f020h)		;66ae
	rla			;66b1
	rla			;66b2
	rla			;66b3
	and 078h		;66b4
	inc a			;66b6
	inc l			;66b7
	ld (hl),a			;66b8
	inc l			;66b9
	ld (hl),0a4h		;66ba
	inc l			;66bc
	ld (hl),c			;66bd
	ret			;66be

; ----------------------------------------------------------------------
; DATOS tres_bytes_66bf: 3 bytes que p01:6623 copia a 0xEF26 antes de pintar
;   el plano del mundo
;   0x66bf..0x66c2  (3 bytes)
DATA_tres_bytes_66bf:
	defb 017h,00bh,01ah	; 66bf

; ======================================================================
; CODIGO 0x66c2..0x66f7  (53 bytes)
; ======================================================================


L_66C2:
	ld hl,0e058h		;66c2
	ld c,000h		;66c5
	call L_66D5		;66c7
	ld hl,0e059h		;66ca
	ld c,002h		;66cd
	call L_66D5		;66cf
	jp L_688E		;66d2
L_66D5:
	ld a,(hl)			;66d5
	or a			;66d6
	jr z,L_66DA		;66d7
	inc c			;66d9
L_66DA:
	ld a,c			;66da
	add a,a			;66db
	ld c,a			;66dc
	add a,a			;66dd
	add a,c			;66de
	ld c,a			;66df
	ld b,000h		;66e0
	ld hl,066f7h		;66e2
	add hl,bc			;66e5
	ld e,(hl)			;66e6
	inc hl			;66e7
	ld d,(hl)			;66e8
	inc hl			;66e9
	ldi		;66ea
	ldi		;66ec
	ld a,01eh		;66ee
	add a,e			;66f0
	ld e,a			;66f1
	ldi		;66f2
	ldi		;66f4
	ret			;66f6

; ----------------------------------------------------------------------
; DATOS marcadores_de_vida: 4 fichas de 6 bytes, [direccion en la copia de la
;   tabla de nombres][4 caracteres], que p01:66D5 elige con el jugador (0xE058
;   y 0xE059) y si tiene algo: la 0 y la 2 son cuatro ceros (borran)
;   0x66f7..0x670f  (24 bytes)
DATA_marcadores_de_vida:
	defb 0b2h,0edh,000h,000h,000h,000h	; 66f7
	defb 0b2h,0edh,07eh,07fh,080h,081h	; 66fd
	defb 0ach,0edh,000h,000h,000h,000h	; 6703
	defb 0ach,0edh,076h,077h,078h,079h	; 6709

; ----------------------------------------------------------------------
; DATOS quinta_ficha: una quinta ficha con el mismo formato ([0xEDAF][7A 7B 7C
;   7D]) que p01:66D5 no puede elegir (C vale 0-3); nada la nombra
;   0x670f..0x6715  (6 bytes)
DATA_quinta_ficha:
	defb 0afh,0edh,07ah,07bh,07ch,07dh	; 670f

; ======================================================================
; CODIGO 0x6715..0x6776  (97 bytes)
; ======================================================================


L_6715:
	ld de,0ee2eh		;6715
	ld hl,06776h		;6718
	ld bc,00004h		;671b
	ldir		;671e
	ld hl,0ee46h		;6720
	exx			;6723
	ld de,0e07ch		;6724
	ld bc,0030ah		;6727
	ld l,081h		;672a
	exx			;672c
	call L_673D		;672d
	ld hl,0ef4fh		;6730
	exx			;6733
	ld de,0e076h		;6734
	ld bc,00106h		;6737
	ld l,056h		;673a
	exx			;673c
L_673D:
	call L_675A		;673d
	ld bc,00002h		;6740
	jr nc,L_6748		;6743
	ld bc,0ffe1h		;6745
L_6748:
	add hl,bc			;6748
	exx			;6749
	dec c			;674a
	exx			;674b
	jr nz,L_673D		;674c
	ld bc,0002ch		;674e
	add hl,bc			;6751
	exx			;6752
	ld c,00ah		;6753
	dec b			;6755
	exx			;6756
	jr nz,L_673D		;6757
	ret			;6759
L_675A:
	exx			;675a
	ld a,l			;675b
	add a,004h		;675c
	ld l,a			;675e
	ld a,(de)			;675f
	inc de			;6760
	exx			;6761
	or a			;6762
	ret z			;6763
	exx			;6764
	ld a,l			;6765
	exx			;6766
	ld (hl),a			;6767
	inc a			;6768
	inc hl			;6769
	ld (hl),a			;676a
	inc a			;676b
	ld bc,0001fh		;676c
	add hl,bc			;676f
	ld (hl),a			;6770
	inc a			;6771
	inc hl			;6772
	ld (hl),a			;6773
	scf			;6774
	ret			;6775

; ----------------------------------------------------------------------
; DATOS cuatro_caracteres_6776: 4 caracteres que p01:6718 copia a 0xEE2E
;   0x6776..0x677a  (4 bytes)
DATA_cuatro_caracteres_6776:
	defb 013h,01eh,00fh,017h	; 6776

; ======================================================================
; CODIGO 0x677a..0x68e4  (362 bytes)
; ======================================================================


L_677A:
	ld hl,0efaeh		;677a
	exx			;677d
	ld de,0e070h		;677e
	ld c,006h		;6781
	exx			;6783
L_6784:
	push hl			;6784
	call L_67B9		;6785
	pop hl			;6788
	exx			;6789
	ld a,c			;678a
	exx			;678b
	sub 003h		;678c
	cp 002h		;678e
	ld bc,00003h		;6790
	jr nc,L_6796		;6793
	dec c			;6795
L_6796:
	add hl,bc			;6796
	exx			;6797
	dec c			;6798
	exx			;6799
	jr nz,L_6784		;679a
	ld hl,0ef8dh		;679c
	ld de,04248h		;679f
	call L_67D6		;67a2
	ld hl,0efcdh		;67a5
	ld de,04349h		;67a8
	call L_67D6		;67ab
	ld a,041h		;67ae
	ld (0efadh),a		;67b0
	ld (0efbdh),a		;67b3
	jp L_68B6		;67b6
L_67B9:
	exx			;67b9
	ld a,(de)			;67ba
	inc de			;67bb
	exx			;67bc
	or a			;67bd
	ret z			;67be
	exx			;67bf
	ld a,c			;67c0
	exx			;67c1
	sub 007h		;67c2
	neg		;67c4
	ex de,hl			;67c6
	ld hl,05f6bh		;67c7
	add a,a			;67ca
	ld c,a			;67cb
	ld b,000h		;67cc
	add hl,bc			;67ce
	ldi		;67cf
	ldi		;67d1
	ex de,hl			;67d3
	scf			;67d4
	ret			;67d5
L_67D6:
	ld (hl),d			;67d6
	inc l			;67d7
	ld a,040h		;67d8
	ld b,00fh		;67da
L_67DC:
	ld (hl),a			;67dc
	inc l			;67dd
	djnz L_67DC		;67de
	ld (hl),e			;67e0
	ret			;67e1
L_67E2:
	call 0422bh		;67e2
	call 054bfh		;67e5
	call 04c68h		;67e8
	call L_67F4		;67eb
	call L_6885		;67ee
	jp 04215h		;67f1
L_67F4:
	ld a,(0e008h)		;67f4
	and 003h		;67f7
	call nz,L_686F		;67f9
	ld a,(0e04ch)		;67fc
	or a			;67ff
	jr z,L_683D		;6800
	ld a,(0e04eh)		;6802
	or a			;6805
	ret z			;6806
	ld hl,0e04eh		;6807
	ld a,(0e008h)		;680a
	and 00ch		;680d
	ret z			;680f
	bit 3,a		;6810
	jr nz,L_6829		;6812
L_6814:
	dec (hl)			;6814
	jr nz,L_6819		;6815
	ld (hl),006h		;6817
L_6819:
	ld a,(hl)			;6819
	ld de,0e06fh		;681a
	add a,e			;681d
	ld e,a			;681e
	ld a,(de)			;681f
	or a			;6820
	jr z,L_6814		;6821
L_6823:
	ld a,(hl)			;6823
	ld (0e510h),a		;6824
	jr L_686A		;6827
L_6829:
	inc (hl)			;6829
	ld a,(hl)			;682a
	cp 007h		;682b
	jr c,L_6831		;682d
	ld (hl),001h		;682f
L_6831:
	ld a,(hl)			;6831
	ld de,0e06fh		;6832
	add a,e			;6835
	ld e,a			;6836
	ld a,(de)			;6837
	or a			;6838
	jr z,L_6829		;6839
	jr L_6823		;683b
L_683D:
	ld a,(0e041h)		;683d
	cp 006h		;6840
	jr nz,L_684B		;6842
	ld a,(0e092h)		;6844
	or a			;6847
	ret z			;6848
	jr L_6854		;6849
L_684B:
	cp 008h		;684b
	jr nz,L_6854		;684d
	ld a,(0e07ch)		;684f
	or a			;6852
	ret z			;6853
L_6854:
	ld a,(0e008h)		;6854
	and 00ch		;6857
	ret z			;6859
	ld hl,0e04dh		;685a
	ld a,(hl)			;685d
	xor 001h		;685e
	ld c,a			;6860
	ld de,0e058h		;6861
	add a,e			;6864
	ld e,a			;6865
	ld a,(de)			;6866
	or a			;6867
	ret z			;6868
	ld (hl),c			;6869
L_686A:
	ld a,02ch		;686a
	jp 04e1fh		;686c
L_686F:
	ld hl,0e04ch		;686f
	ld a,(hl)			;6872
	xor 001h		;6873
	ld c,a			;6875
	jr nz,L_687B		;6876
	ld (hl),a			;6878
	jr L_686A		;6879
L_687B:
	inc l			;687b
	inc l			;687c
	ld a,(hl)			;687d
	or a			;687e
	ret z			;687f
	dec l			;6880
	dec l			;6881
	ld (hl),c			;6882
	jr L_686A		;6883
L_6885:
	call L_68EA		;6885
	call L_606B		;6888
	call L_68B6		;688b
L_688E:
	ld a,(0e04dh)		;688e
	or a			;6891
	ld a,091h		;6892
	jr z,L_6898		;6894
	ld a,061h		;6896
L_6898:
	ld b,a			;6898
	ld de,0ec80h		;6899
	ld a,(0e04ch)		;689c
	or a			;689f
	jr nz,L_68AA		;68a0
	ld a,(0e003h)		;68a2
	bit 3,a		;68a5
	jp z,L_6E23		;68a7
L_68AA:
	ex de,hl			;68aa
	ld (hl),027h		;68ab
	inc l			;68ad
	ld (hl),b			;68ae
	inc l			;68af
	ld (hl),0a0h		;68b0
	inc l			;68b2
	ld (hl),003h		;68b3
	ret			;68b5
L_68B6:
	ld de,0ec84h		;68b6
	ld a,(0e04eh)		;68b9
	or a			;68bc
	jp z,L_6E23		;68bd
	ld a,(0e04ch)		;68c0
	or a			;68c3
	jr z,L_68CE		;68c4
	ld a,(0e003h)		;68c6
	bit 3,a		;68c9
	jp z,L_6E23		;68cb
L_68CE:
	ex de,hl			;68ce
	ld (hl),0a3h		;68cf
	inc l			;68d1
	ld a,(0e04eh)		;68d2
	ld de,l68e3h		;68d5
	call 0413bh		;68d8
	ld a,(de)			;68db
	ld (hl),a			;68dc
	inc l			;68dd
	ld (hl),0a0h		;68de
	inc l			;68e0
	ld (hl),00fh		;68e1
L_68E3:
	ret			;68e3

; ----------------------------------------------------------------------
; DATOS seis_dibujos_68e4: 6 numeros de dibujo de sprite que p01:68D5 elige
;   con (0xE04E) = 1-6 (0x68E3 + n; el 0 seria el codigo de delante)
;   0x68e4..0x68ea  (6 bytes)
DATA_seis_dibujos_68e4:
	defb 070h,088h,09ch,0ach,0c0h,0d8h	; 68e4

; ======================================================================
; CODIGO 0x68ea..0x6c89  (927 bytes)
; ======================================================================


L_68EA:
	ld de,0ec88h		;68ea
	ld a,(0e003h)		;68ed
	bit 3,a		;68f0
	jr z,L_68FD		;68f2
	ld hl,0e670h		;68f4
	ld bc,00008h		;68f7
	ldir		;68fa
	ret			;68fc
L_68FD:
	call L_6E23		;68fd
	jp L_6E23		;6900
L_6903:
	ld de,0e04dh		;6903
	ld a,(de)			;6906
	ld (0e501h),a		;6907
	ld hl,0e058h		;690a
	add a,l			;690d
	ld l,a			;690e
	ld a,(hl)			;690f
	sub 001h		;6910
	daa			;6912
	ld (hl),a			;6913
	inc e			;6914
	ld a,(de)			;6915
	ld (0e510h),a		;6916
	ret			;6919
L_691A:
	ld bc,(0e041h)		;691a
	ld a,c			;691e
	cp 00ch		;691f
	ret z			;6921
	ld hl,0b25dh		;6922
	call 0414ch		;6925
	ld a,b			;6928
	cp 001h		;6929
	jr z,L_693E		;692b
	ex af,af'			;692d
	ld a,001h		;692e
	ex af,af'			;6930
L_6931:
	ld a,(de)			;6931
	or a			;6932
	inc de			;6933
	jr nz,L_6931		;6934
	ex af,af'			;6936
	inc a			;6937
	cp b			;6938
	jr z,L_693E		;6939
	ex af,af'			;693b
	jr L_6931		;693c
L_693E:
	ld a,c			;693e
	exx			;693f
	ld hl,0af09h		;6940
	call 0414ch		;6943
	dec de			;6946
	ld b,000h		;6947
	exx			;6949
L_694A:
	ld a,(de)			;694a
	or a			;694b
	ret z			;694c
	exx			;694d
	ld c,a			;694e
	ld h,d			;694f
	ld l,e			;6950
	add hl,bc			;6951
	ld (hl),b			;6952
	exx			;6953
	inc de			;6954
	jr L_694A		;6955
L_6957:
	ld hl,00000h		;6957
	ld (0e00eh),hl		;695a
	ld de,0bcefh		;695d
	call 05c40h		;6960
	ld hl,00a00h		;6963
	ld bc,003f0h		;6966
	xor a			;6969
	call 00056h		;696a   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;696d
	ld a,040h		;6970
	ld c,006h		;6972
	ld de,0000bh		;6974
L_6977:
	ld b,015h		;6977
L_6979:
	call 0004dh		;6979   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;697c
	inc a			;697d
	djnz L_6979		;697e
	add hl,de			;6980
	dec c			;6981
	jr nz,L_6977		;6982
	ret			;6984
L_6985:
	ld bc,(0e00eh)		;6985
	ld a,0ebh		;6989
	inc b			;698b
L_698C:
	add a,015h		;698c
	djnz L_698C		;698e
	ld l,a			;6990
	ld h,b			;6991
	add hl,hl			;6992
	add hl,hl			;6993
	add hl,hl			;6994
	ld de,00a00h		;6995
	add hl,de			;6998
	ld a,c			;6999
	call 04136h		;699a
	ld b,015h		;699d
	ld de,00008h		;699f
	ld a,0f0h		;69a2
L_69A4:
	call 0004dh		;69a4   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;69a7
	djnz L_69A4		;69a8
	ld hl,0e00eh		;69aa
	ld a,(hl)			;69ad
	inc a			;69ae
	and 007h		;69af
	ld (hl),a			;69b1
	ret nz			;69b2
	inc hl			;69b3
	inc (hl)			;69b4
	ld a,(hl)			;69b5
	cp 006h		;69b6
	ret			;69b8
L_69B9:
	xor a			;69b9
	ld de,0ed81h		;69ba
	ld hl,0ed80h		;69bd
	ld (hl),a			;69c0
	ld bc,0027fh		;69c1
	ldir		;69c4
	ld de,0ee04h		;69c6
	ld hl,0bbcfh		;69c9
	ld bc,00c18h		;69cc
	call L_6D49		;69cf
	call 054bfh		;69d2
	ld a,(0e678h)		;69d5
	or a			;69d8
	ret m			;69d9
	ld hl,0bb58h		;69da
	call 0414ch		;69dd
	jp 05c25h		;69e0
L_69E3:
	ld a,(0e041h)		;69e3
	sub 002h		;69e6
	ret m			;69e8
	ld hl,09c83h		;69e9
	call 0414ch		;69ec
	ld a,(0e042h)		;69ef
	ld b,a			;69f2
L_69F3:
	ld a,(de)			;69f3
	or a			;69f4
	ret z			;69f5
	inc de			;69f6
	cp b			;69f7
	jr z,L_69FE		;69f8
	inc de			;69fa
	inc de			;69fb
	jr L_69F3		;69fc
L_69FE:
	ex de,hl			;69fe
	ld a,(hl)			;69ff
	and 00fh		;6a00
	ld b,a			;6a02
	ld a,(hl)			;6a03
	inc hl			;6a04
	ld c,(hl)			;6a05
	rr c		;6a06
	rra			;6a08
	and 0f8h		;6a09
	ld e,a			;6a0b
	ld a,(hl)			;6a0c
	and 0f8h		;6a0d
	ld d,a			;6a0f
	ld hl,0e678h		;6a10
	ld a,b			;6a13
	or a			;6a14
	jr nz,L_6A18		;6a15
	dec a			;6a17
L_6A18:
	ld (hl),a			;6a18
	inc l			;6a19
	ld (hl),d			;6a1a
	inc l			;6a1b
	ld (hl),e			;6a1c
	ret			;6a1d
L_6A1E:
	call 054e6h		;6a1e
	call 05e6ch		;6a21
	call 05e7bh		;6a24
	ld hl,02008h		;6a27
	call L_6AB5		;6a2a
	ld hl,0e948h		;6a2d
	ld de,0e920h		;6a30
	ld bc,00028h		;6a33
	ldir		;6a36
	ld hl,0e838h		;6a38
	ld de,0e810h		;6a3b
	ld bc,00138h		;6a3e
	ldir		;6a41
	ld hl,0e808h		;6a43
	ld de,0e800h		;6a46
	ld bc,00140h		;6a49
	ldir		;6a4c
	ld bc,00120h		;6a4e
	ld hl,02008h		;6a51
	call L_6BA5		;6a54
	ld hl,02120h		;6a57
	call L_6ABE		;6a5a
	ld b,023h		;6a5d
L_6A5F:
	ld de,02000h		;6a5f
	ld h,000h		;6a62
	ld l,b			;6a64
	add hl,hl			;6a65
	add hl,hl			;6a66
	add hl,hl			;6a67
	add hl,de			;6a68
	push hl			;6a69
	or a			;6a6a
	sbc hl,de		;6a6b
	add hl,hl			;6a6d
	ld a,008h		;6a6e
	call 04136h		;6a70
	add hl,de			;6a73
	ex de,hl			;6a74
	pop hl			;6a75
	push bc			;6a76
	push de			;6a77
	ld bc,00008h		;6a78
	ld de,0f000h		;6a7b
	call 00059h		;6a7e   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop de			;6a81
	ld hl,0f000h		;6a82
	ex de,hl			;6a85
	ld bc,00008h		;6a86
	call 05bd8h		;6a89
	pop bc			;6a8c
	dec b			;6a8d
	jp p,L_6A5F		;6a8e
	ld d,024h		;6a91
	ld hl,02010h		;6a93
L_6A96:
	ld bc,00008h		;6a96
	push de			;6a99
	push hl			;6a9a
	call L_6AC1		;6a9b
	pop hl			;6a9e
	ld de,00010h		;6a9f
	add hl,de			;6aa2
	pop de			;6aa3
	dec d			;6aa4
	jr nz,L_6A96		;6aa5
	ld hl,00000h		;6aa7
	ld a,0f0h		;6aaa
	ld bc,007f8h		;6aac
	call 05bebh		;6aaf
	ld hl,02010h		;6ab2
L_6AB5:
	ld de,0e800h		;6ab5
	ld bc,002a0h		;6ab8
	jp 00059h		;6abb   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_6ABE:
	ld bc,006d8h		;6abe
L_6AC1:
	xor a			;6ac1
	jp 05bebh		;6ac2
L_6AC5:
	ld hl,0ae28h		;6ac5
	jr L_6ACD		;6ac8
L_6ACA:
	ld hl,0a84ah		;6aca
L_6ACD:
	ld (0f020h),hl		;6acd
	xor a			;6ad0
	ld (0f01fh),a		;6ad1
	ld (0f022h),a		;6ad4
	inc a			;6ad7
	ld (0f02bh),a		;6ad8
	ret			;6adb
L_6ADC:
	ld a,(0e003h)		;6adc
	bit 0,a		;6adf
	ret z			;6ae1
	ld a,(0f022h)		;6ae2
	or a			;6ae5
	jp nz,L_6B80		;6ae6
	call L_6B8A		;6ae9
	ld a,(0f02bh)		;6aec
	and 007h		;6aef
	jr nz,L_6B10		;6af1
	ld a,(0f01fh)		;6af3
	or a			;6af6
	jr nz,L_6B18		;6af7
	ld hl,0ed60h		;6af9
	ld de,0ed20h		;6afc
	call L_6B26		;6aff
	ld de,0efe0h		;6b02
L_6B05:
	call L_6B40		;6b05
	ld a,(0f01fh)		;6b08
	xor 001h		;6b0b
	ld (0f01fh),a		;6b0d
L_6B10:
	call 054f3h		;6b10
	ld hl,0f02bh		;6b13
	inc (hl)			;6b16
	ret			;6b17
L_6B18:
	ld hl,0ed40h		;6b18
	ld de,0ed00h		;6b1b
	call L_6B26		;6b1e
	ld de,0efc0h		;6b21
	jr L_6B05		;6b24
L_6B26:
	ld b,00bh		;6b26
L_6B28:
	push bc			;6b28
	push hl			;6b29
	push de			;6b2a
	ld bc,00020h		;6b2b
	ldir		;6b2e
	pop de			;6b30
	pop hl			;6b31
	ld a,040h		;6b32
	ld b,a			;6b34
	call 04136h		;6b35
	ld a,b			;6b38
	call 0413bh		;6b39
	pop bc			;6b3c
	djnz L_6B28		;6b3d
	ret			;6b3f
L_6B40:
	push de			;6b40
	xor a			;6b41
	ld b,020h		;6b42
L_6B44:
	ld (de),a			;6b44
	inc de			;6b45
	djnz L_6B44		;6b46
	pop de			;6b48
	ld hl,(0f020h)		;6b49
	ld a,(hl)			;6b4c
	inc hl			;6b4d
	cp 0fbh		;6b4e
	jr nz,L_6B59		;6b50
	ld a,0ffh		;6b52
	call 04e34h		;6b54
	ld a,(hl)			;6b57
	inc hl			;6b58
L_6B59:
	cp 0fdh		;6b59
	jr z,L_6B72		;6b5b
	cp 0feh		;6b5d
	jr z,L_6B6E		;6b5f
	cp 0ffh		;6b61
	jr z,L_6BAB		;6b63
	call 0413bh		;6b65
	ld c,(hl)			;6b68
	ld b,000h		;6b69
	inc hl			;6b6b
	ldir		;6b6c
L_6B6E:
	ld (0f020h),hl		;6b6e
	ret			;6b71
L_6B72:
	ld a,(hl)			;6b72
	ld (0f023h),a		;6b73
	inc hl			;6b76
	ld (0f020h),hl		;6b77
	ld a,001h		;6b7a
	ld (0f022h),a		;6b7c
	ret			;6b7f
L_6B80:
	ld hl,0f023h		;6b80
	dec (hl)			;6b83
	ret nz			;6b84
	xor a			;6b85
	ld (0f022h),a		;6b86
	ret			;6b89
L_6B8A:
	ld b,023h		;6b8a
	ld hl,0e801h		;6b8c
	ld de,0e800h		;6b8f
L_6B92:
	push bc			;6b92
	ld bc,0000fh		;6b93
	ld a,(de)			;6b96
	ldir		;6b97
	ld (de),a			;6b99
	inc hl			;6b9a
	inc de			;6b9b
	pop bc			;6b9c
	djnz L_6B92		;6b9d
	ld bc,00230h		;6b9f
	ld hl,02010h		;6ba2
L_6BA5:
	ld de,0e800h		;6ba5
	jp 05bd8h		;6ba8
L_6BAB:
	xor a			;6bab
	ld (0e02eh),a		;6bac
	ret			;6baf
L_6BB0:
	ld a,(0e0d2h)		;6bb0
	or a			;6bb3
	ret z			;6bb4
	ld ix,0e700h		;6bb5
	ld a,(0e700h)		;6bb9
	or a			;6bbc
	ret z			;6bbd
	cp 006h		;6bbe
	jr z,L_6BD5		;6bc0
	bit 7,(ix+002h)		;6bc2
	ret z			;6bc6
	ld a,(0e709h)		;6bc7
	rla			;6bca
	rla			;6bcb
	jr c,L_6BF9		;6bcc
	rla			;6bce
	jp nc,L_6D5E		;6bcf
	jp L_6DA0		;6bd2
L_6BD5:
	call L_6BEA		;6bd5
	exx			;6bd8
	ld b,009h		;6bd9
L_6BDB:
	exx			;6bdb
	ld bc,0000fh		;6bdc
	ldir		;6bdf
	ld a,011h		;6be1
	call 0413bh		;6be3
	exx			;6be6
	djnz L_6BDB		;6be7
	ret			;6be9
L_6BEA:
	ld a,(0e70ah)		;6bea
L_6BED:
	ld hl,09e0ah		;6bed
	call 0414ch		;6bf0
	ex de,hl			;6bf3
	ld de,(0e712h)		;6bf4
	ret			;6bf8
L_6BF9:
	call L_6BEA		;6bf9
	ld bc,0040ah		;6bfc
	ld a,004h		;6bff
	call 0413bh		;6c01
	ld a,00ah		;6c04
	call L_6C34		;6c06
	ld a,(0e719h)		;6c09
	call L_6BED		;6c0c
	ld bc,00402h		;6c0f
	ld a,022h		;6c12
	call 0413bh		;6c14
	ld a,002h		;6c17
	call L_6C34		;6c19
	ld a,(0e718h)		;6c1c
	call L_6BED		;6c1f
	ld bc,00102h		;6c22
	ld a,(0e71ch)		;6c25
	add a,a			;6c28
	rla			;6c29
	rla			;6c2a
	rla			;6c2b
	rla			;6c2c
	and 0f0h		;6c2d
	call 0413bh		;6c2f
	ld a,002h		;6c32
L_6C34:
	sub c			;6c34
	exx			;6c35
	ld c,a			;6c36
	exx			;6c37
	bit 4,(ix+009h)		;6c38
	jr z,L_6C41		;6c3c
	ld b,(ix+01ah)		;6c3e
L_6C41:
	push bc			;6c41
	push de			;6c42
	ld b,000h		;6c43
	ldir		;6c45
	pop de			;6c47
	ex de,hl			;6c48
	ld c,020h		;6c49
	add hl,bc			;6c4b
	ex de,hl			;6c4c
	exx			;6c4d
	ld a,c			;6c4e
	exx			;6c4f
	ld c,a			;6c50
	add hl,bc			;6c51
	pop bc			;6c52
	djnz L_6C41		;6c53
	ret			;6c55
L_6C56:
	ld a,(0e740h)		;6c56
	or a			;6c59
	ret z			;6c5a
	cp 007h		;6c5b
	jr c,L_6C7C		;6c5d
	sub 02dh		;6c5f
	jr nc,L_6C76		;6c61
	ld a,076h		;6c63
L_6C65:
	ld hl,(0e744h)		;6c65
	ld (hl),a			;6c68
	inc a			;6c69
	inc l			;6c6a
	ld (hl),a			;6c6b
	ld bc,0001fh		;6c6c
	add hl,bc			;6c6f
	inc a			;6c70
	ld (hl),a			;6c71
	inc l			;6c72
	inc a			;6c73
	ld (hl),a			;6c74
	ret			;6c75
L_6C76:
	add a,a			;6c76
	add a,a			;6c77
	add a,060h		;6c78
	jr L_6C65		;6c7a
L_6C7C:
	ld hl,l6c87h		;6c7c
	call 0414ch		;6c7f
	ld hl,(0e744h)		;6c82
	ld (hl),d			;6c85
	inc l			;6c86
L_6C87:
	ld (hl),e			;6c87
	ret			;6c88

; ----------------------------------------------------------------------
; DATOS seis_parejas_6c89: 6 parejas de caracteres que p01:6C7C lee en 0x6C87
;   + 2 x A (0x414C, A = 1-6) y escribe en (0xE744)
;   0x6c89..0x6c95  (12 bytes)
DATA_seis_parejas_6c89:
	defb 045h,044h	; 6c89
	defb 047h,046h	; 6c8b
	defb 000h,04eh	; 6c8d
	defb 000h,04fh	; 6c8f
	defb 051h,050h	; 6c91
	defb 053h,052h	; 6c93

; ======================================================================
; CODIGO 0x6c95..0x6cc7  (50 bytes)
; ======================================================================


L_6C95:
	ld hl,0e688h		;6c95
	ld a,(hl)			;6c98
	or a			;6c99
	ret z			;6c9a
	inc l			;6c9b
	inc l			;6c9c
	ld e,(hl)			;6c9d
	inc l			;6c9e
	ld d,(hl)			;6c9f
	ex de,hl			;6ca0
	call 04da1h		;6ca1
	ex de,hl			;6ca4
	ld hl,06cc7h		;6ca5
	ld a,(0e68ch)		;6ca8
	add a,a			;6cab
	add a,a			;6cac
	ld b,a			;6cad
	add a,a			;6cae
	add a,b			;6caf
	ld c,a			;6cb0
	ld b,000h		;6cb1
	add hl,bc			;6cb3
	exx			;6cb4
	ld b,003h		;6cb5
L_6CB7:
	exx			;6cb7
	ld bc,00004h		;6cb8
	ldir		;6cbb
	ld a,01ch		;6cbd
	call 0413bh		;6cbf
	exx			;6cc2
	djnz L_6CB7		;6cc3
	exx			;6cc5
	ret			;6cc6

; ----------------------------------------------------------------------
; DATOS tres_bloques_de_3x4: 3 bloques de 3 filas de 4 caracteres que p01:6CA5
;   elige con (0xE68C) x 12 y copia de 32 en 32
;   0x6cc7..0x6ceb  (36 bytes)
DATA_tres_bloques_de_3x4:
	defb 05ah,05ah,05ah,05ah	; 6cc7
	defb 05ah,05bh,05bh,05ah	; 6ccb
	defb 05ah,05bh,05bh,05ah	; 6ccf
	defb 05ah,05ah,05ah,05ah	; 6cd3
	defb 05ah,05bh,05bh,05ah	; 6cd7
	defb 05ah,06dh,06eh,05ah	; 6cdb
	defb 05ah,05ah,05ah,05ah	; 6cdf
	defb 05ah,06dh,06eh,05ah	; 6ce3
	defb 05ah,06dh,06eh,05ah	; 6ce7

; ======================================================================
; CODIGO 0x6ceb..0x6f32  (583 bytes)
; ======================================================================


L_6CEB:
	ld a,(ix+00ah)		;6ceb
	call L_6EA7		;6cee
	ld (ix+00bh),c		;6cf1
	call L_6DDC		;6cf4
	ld (ix+015h),c		;6cf7
	ld (ix+014h),b		;6cfa
	bit 4,(ix+009h)		;6cfd
	jr z,L_6D06		;6d01
	ld b,(ix+01ah)		;6d03
L_6D06:
	push bc			;6d06
	push hl			;6d07
	ld b,000h		;6d08
	ldir		;6d0a
	pop hl			;6d0c
	ld c,020h		;6d0d
	add hl,bc			;6d0f
	pop bc			;6d10
	djnz L_6D06		;6d11
	ret			;6d13
L_6D14:
	ld a,(ix+00ah)		;6d14
	call L_6EA7		;6d17
	ld (ix+015h),c		;6d1a
	ld (ix+014h),b		;6d1d
	ld l,(ix+005h)		;6d20
	ld h,(ix+007h)		;6d23
	call 04da1h		;6d26
	ld (ix+012h),l		;6d29
	ld (ix+013h),h		;6d2c
	ld c,(ix+00bh)		;6d2f
	jr L_6D06		;6d32
L_6D34:
	ld c,(ix+015h)		;6d34
L_6D37:
	ld b,(ix+014h)		;6d37
	ld e,(ix+012h)		;6d3a
	ld d,(ix+013h)		;6d3d
	bit 4,(ix+009h)		;6d40
	jr z,L_6D49		;6d44
	ld b,(ix+01ah)		;6d46
L_6D49:
	push bc			;6d49
	push de			;6d4a
	ld b,000h		;6d4b
	ldir		;6d4d
	pop de			;6d4f
	ex de,hl			;6d50
	ld c,020h		;6d51
	add hl,bc			;6d53
	ex de,hl			;6d54
	pop bc			;6d55
	djnz L_6D49		;6d56
	ret			;6d58
L_6D59:
	ld c,(ix+00bh)		;6d59
	jr L_6D37		;6d5c
L_6D5E:
	ld a,(ix+00ah)		;6d5e
	ld hl,09e0ah		;6d61
	call 0414ch		;6d64
	ex de,hl			;6d67
	ld e,(ix+012h)		;6d68
	ld d,(ix+013h)		;6d6b
	ld c,(ix+015h)		;6d6e
	ld b,(ix+014h)		;6d71
	ld a,(ix+00bh)		;6d74
	sub c			;6d77
	exx			;6d78
	ld c,a			;6d79
	exx			;6d7a
	bit 4,(ix+009h)		;6d7b
	jr z,L_6D84		;6d7f
	ld b,(ix+01ah)		;6d81
L_6D84:
	push bc			;6d84
	push de			;6d85
	ld b,c			;6d86
L_6D87:
	ld a,(hl)			;6d87
	or a			;6d88
	jr z,L_6D8C		;6d89
	ld (de),a			;6d8b
L_6D8C:
	inc hl			;6d8c
	inc de			;6d8d
	djnz L_6D87		;6d8e
	pop de			;6d90
	ex de,hl			;6d91
	ld bc,00020h		;6d92
	add hl,bc			;6d95
	ex de,hl			;6d96
	exx			;6d97
	ld a,c			;6d98
	exx			;6d99
	ld c,a			;6d9a
	add hl,bc			;6d9b
	pop bc			;6d9c
	djnz L_6D84		;6d9d
	ret			;6d9f
L_6DA0:
	ld a,(ix+00ah)		;6da0
	ld hl,09e0ah		;6da3
	call 0414ch		;6da6
	ex de,hl			;6da9
	ld e,(ix+012h)		;6daa
	ld d,(ix+013h)		;6dad
	ld a,(ix+015h)		;6db0
	ld b,(ix+014h)		;6db3
	ld c,(ix+00bh)		;6db6
	sub c			;6db9
	exx			;6dba
	ld c,a			;6dbb
	exx			;6dbc
L_6DBD:
	push bc			;6dbd
	push de			;6dbe
	exx			;6dbf
	ld a,c			;6dc0
	exx			;6dc1
	add a,l			;6dc2
	ld l,a			;6dc3
	jr nc,L_6DC7		;6dc4
	inc h			;6dc6
L_6DC7:
	ld b,c			;6dc7
L_6DC8:
	ld a,(hl)			;6dc8
	or a			;6dc9
	jr z,L_6DCD		;6dca
	ld (de),a			;6dcc
L_6DCD:
	inc hl			;6dcd
	inc de			;6dce
	djnz L_6DC8		;6dcf
	pop de			;6dd1
	ex de,hl			;6dd2
	ld bc,00020h		;6dd3
	add hl,bc			;6dd6
	ex de,hl			;6dd7
	pop bc			;6dd8
	djnz L_6DBD		;6dd9
	ret			;6ddb
L_6DDC:
	ld l,(ix+005h)		;6ddc
	ld h,(ix+007h)		;6ddf
	call 04da1h		;6de2
	ld (ix+012h),l		;6de5
	ld (ix+013h),h		;6de8
	ld a,l			;6deb
	and 01fh		;6dec
	add a,c			;6dee
	sub 020h		;6def
	ret c			;6df1
	neg		;6df2
	add a,c			;6df4
	ld c,a			;6df5
	ret			;6df6
L_6DF7:
	ld (0e630h),a		;6df7
	ld de,0ecbch		;6dfa
	ld ix,0e800h		;6dfd
	exx			;6e01
	ld hl,(0e635h)		;6e02
	ld b,l			;6e05
	ld c,h			;6e06
	ld de,00020h		;6e07
L_6E0A:
	exx			;6e0a
	call L_6E2B		;6e0b
	exx			;6e0e
	add ix,de		;6e0f
	djnz L_6E0A		;6e11
	ld a,c			;6e13
	exx			;6e14
	or a			;6e15
	ret z			;6e16
	ld b,a			;6e17
	ld a,(0e630h)		;6e18
	or a			;6e1b
	ret nz			;6e1c
L_6E1D:
	call L_6E23		;6e1d
	djnz L_6E1D		;6e20
	ret			;6e22
L_6E23:
	ld a,0e0h		;6e23
	ld (de),a			;6e25
	inc e			;6e26
	inc e			;6e27
	inc e			;6e28
	inc e			;6e29
	ret			;6e2a
L_6E2B:
	bit 7,(ix+002h)		;6e2b
	ret z			;6e2f
	bit 7,(ix+009h)		;6e30
	jr nz,L_6EB3		;6e34
	ld a,(0e630h)		;6e36
	or a			;6e39
	jr nz,L_6E46		;6e3a
	ld a,(ix+000h)		;6e3c
	sub 05dh		;6e3f
	cp 002h		;6e41
	jr nc,L_6E4E		;6e43
	ret			;6e45
L_6E46:
	ld a,(ix+000h)		;6e46
	sub 05dh		;6e49
	cp 002h		;6e4b
	ret nc			;6e4d
L_6E4E:
	bit 6,(ix+009h)		;6e4e
	jr nz,L_6EA1		;6e52
	ld a,(ix+000h)		;6e54
	cp 05ch		;6e57
	jr z,L_6E75		;6e59
	cp 06bh		;6e5b
	jr nz,L_6E79		;6e5d
	ld a,07ah		;6e5f
L_6E61:
	ld l,(ix+012h)		;6e61
	ld h,(ix+013h)		;6e64
	ld (hl),a			;6e67
	inc hl			;6e68
	inc a			;6e69
	ld (hl),a			;6e6a
	ld bc,0001fh		;6e6b
	add hl,bc			;6e6e
	inc a			;6e6f
	ld (hl),a			;6e70
	inc hl			;6e71
	inc a			;6e72
	ld (hl),a			;6e73
	ret			;6e74
L_6E75:
	ld a,0bah		;6e75
	jr L_6E61		;6e77
L_6E79:
	push de			;6e79
	ld a,(ix+00ah)		;6e7a
	ld d,a			;6e7d
	call L_6EA7		;6e7e
	ld a,d			;6e81
	ld hl,09e0ah		;6e82
	call 0414ch		;6e85
	ex de,hl			;6e88
	ld e,(ix+012h)		;6e89
	ld d,(ix+013h)		;6e8c
L_6E8F:
	push bc			;6e8f
	ld b,000h		;6e90
	ldir		;6e92
	pop bc			;6e94
	ld a,020h		;6e95
	sub c			;6e97
	add a,e			;6e98
	ld e,a			;6e99
	jr nc,L_6E9D		;6e9a
	inc d			;6e9c
L_6E9D:
	djnz L_6E8F		;6e9d
	pop de			;6e9f
	ret			;6ea0
L_6EA1:
	push de			;6ea1
	call L_6F2C		;6ea2
	pop de			;6ea5
	ret			;6ea6
L_6EA7:
	ld l,a			;6ea7
	ld h,000h		;6ea8
	add hl,hl			;6eaa
	ld bc,09d90h		;6eab
	add hl,bc			;6eae
	ld c,(hl)			;6eaf
	inc hl			;6eb0
	ld b,(hl)			;6eb1
	ret			;6eb2
L_6EB3:
	ld a,(0e630h)		;6eb3
	or a			;6eb6
	ret nz			;6eb7
	ld a,(ix+009h)		;6eb8
	ld l,a			;6ebb
	and 03fh		;6ebc
	ld b,a			;6ebe
	and 007h		;6ebf
	ld c,a			;6ec1
	exx			;6ec2
	sub c			;6ec3
	neg		;6ec4
	ld c,a			;6ec6
	exx			;6ec7
	bit 6,l		;6ec8
	jr nz,L_6F2C		;6eca
	dec c			;6ecc
	jr z,L_6F16		;6ecd
	dec c			;6ecf
	ret nz			;6ed0
	ld a,b			;6ed1
	srl a		;6ed2
	srl a		;6ed4
	srl a		;6ed6
	ld hl,00000h		;6ed8
	or a			;6edb
	jr z,L_6EFF		;6edc
	ld l,010h		;6ede
	dec a			;6ee0
	jr z,L_6EFF		;6ee1
	ld l,0f0h		;6ee3
	dec a			;6ee5
	jr z,L_6EFF		;6ee6
	ld hl,01000h		;6ee8
	dec a			;6eeb
	jr z,L_6EFF		;6eec
	ld h,0f0h		;6eee
	dec a			;6ef0
	jr z,L_6EFF		;6ef1
	ld hl,0ff10h		;6ef3
	dec a			;6ef6
	jr z,L_6EFF		;6ef7
	ld l,0f0h		;6ef9
	dec a			;6efb
	jr z,L_6EFF		;6efc
	ret nz			;6efe
L_6EFF:
	ld a,(ix+005h)		;6eff
	add a,h			;6f02
	dec a			;6f03
	ld (de),a			;6f04
	inc e			;6f05
	ld a,(ix+007h)		;6f06
	add a,l			;6f09
	ld (de),a			;6f0a
	inc e			;6f0b
	ld a,(ix+012h)		;6f0c
	ld (de),a			;6f0f
	inc e			;6f10
	ld a,(ix+013h)		;6f11
	ld (de),a			;6f14
	inc e			;6f15
L_6F16:
	ld a,(ix+005h)		;6f16
	dec a			;6f19
	ld (de),a			;6f1a
	inc e			;6f1b
	ld a,(ix+007h)		;6f1c
	ld (de),a			;6f1f
	inc e			;6f20
	ld a,(ix+00ah)		;6f21
	ld (de),a			;6f24
	inc e			;6f25
	ld a,(ix+00bh)		;6f26
	ld (de),a			;6f29
	inc e			;6f2a
	ret			;6f2b
L_6F2C:
	ld a,(ix+00bh)		;6f2c
	call 04140h		;6f2f

; ----------------------------------------------------------------------
; DATOS tabla_6F32: 17 destinos del despachador de 0x4140 (call en p01:6F2F):
;   0x6F54, 0x6F8A, 0x6FE2, 0x6FB5, 0x6FD6, 0x6FD2, 0x6FDA, 0x6F73 ...; lo
;   leen p01:6F2F (34 bytes)
;   0x6f32..0x6f54  (34 bytes)
DATA_tabla_6F32:
	defb 054h,06fh	; 6f32
	defb 08ah,06fh	; 6f34
	defb 0e2h,06fh	; 6f36
	defb 0b5h,06fh	; 6f38
	defb 0d6h,06fh	; 6f3a
	defb 0d2h,06fh	; 6f3c
	defb 0dah,06fh	; 6f3e
	defb 073h,06fh	; 6f40
	defb 079h,070h	; 6f42
	defb 07fh,070h	; 6f44
	defb 0c6h,070h	; 6f46
	defb 031h,071h	; 6f48
	defb 0c6h,070h	; 6f4a
	defb 0ceh,06fh	; 6f4c
	defb 0deh,06fh	; 6f4e
	defb 07ah,071h	; 6f50
	defb 07bh,071h	; 6f52

; ======================================================================
; CODIGO 0x6f54..0x7039  (229 bytes)
; ======================================================================


L_6F54:
	ld l,(ix+012h)		;6f54
	ld h,(ix+013h)		;6f57
	ld de,00020h		;6f5a
	ld a,(ix+014h)		;6f5d
	or a			;6f60
	jr z,L_6F6F		;6f61
	ld (hl),0b5h		;6f63
	add hl,de			;6f65
	dec a			;6f66
	jr z,L_6F6F		;6f67
	ld b,a			;6f69
L_6F6A:
	ld (hl),0b4h		;6f6a
	add hl,de			;6f6c
	djnz L_6F6A		;6f6d
L_6F6F:
	ld a,099h		;6f6f
	ld (hl),a			;6f71
	ret			;6f72
L_6F73:
	ld l,(ix+012h)		;6f73
	ld h,(ix+013h)		;6f76
	ld a,(ix+00ah)		;6f79
	ld (hl),a			;6f7c
	inc hl			;6f7d
	inc a			;6f7e
	ld (hl),a			;6f7f
	ld bc,0001fh		;6f80
	add hl,bc			;6f83
	inc a			;6f84
	ld (hl),a			;6f85
	inc hl			;6f86
	inc a			;6f87
	ld (hl),a			;6f88
	ret			;6f89
L_6F8A:
	ld a,(ix+00ah)		;6f8a
	ld hl,0a77eh		;6f8d
	call 0414ch		;6f90
	ld l,(ix+012h)		;6f93
	ld h,(ix+013h)		;6f96
	ld a,(0e041h)		;6f99
	cp 00ah		;6f9c
	jr z,L_6FA9		;6f9e
	ld c,(ix+01fh)		;6fa0
	ld b,000h		;6fa3
	ex de,hl			;6fa5
	ldir		;6fa6
	ret			;6fa8
L_6FA9:
	ld b,(ix+01fh)		;6fa9
L_6FAC:
	ld a,(de)			;6fac
	sub 022h		;6fad
	ld (hl),a			;6faf
	inc hl			;6fb0
	inc de			;6fb1
	djnz L_6FAC		;6fb2
	ret			;6fb4
L_6FB5:
	ld a,00fh		;6fb5
	call L_6FE4		;6fb7
	ld a,(ix+012h)		;6fba
	dec a			;6fbd
	ld (de),a			;6fbe
	inc e			;6fbf
	ld a,(ix+013h)		;6fc0
	ld (de),a			;6fc3
	inc e			;6fc4
	ld a,0a0h		;6fc5
	ld (de),a			;6fc7
	inc e			;6fc8
	ld a,00ch		;6fc9
	ld (de),a			;6fcb
	inc e			;6fcc
	ret			;6fcd
L_6FCE:
	ld a,00fh		;6fce
	jr L_6FE4		;6fd0
L_6FD2:
	ld a,005h		;6fd2
	jr L_6FE4		;6fd4
L_6FD6:
	ld a,001h		;6fd6
	jr L_6FE4		;6fd8
L_6FDA:
	ld a,00fh		;6fda
	jr L_6FE4		;6fdc
L_6FDE:
	ld a,00bh		;6fde
	jr L_6FE4		;6fe0
L_6FE2:
	ld a,009h		;6fe2
L_6FE4:
	ex af,af'			;6fe4
	ld a,(ix+00ah)		;6fe5
	add a,a			;6fe8
	add a,a			;6fe9
	ld c,a			;6fea
	ld b,000h		;6feb
	ld hl,07039h		;6fed
	add hl,bc			;6ff0
	ld c,(ix+005h)		;6ff1
	dec c			;6ff4
	ld b,(ix+007h)		;6ff5
	ex de,hl			;6ff8
	ld (hl),c			;6ff9
	inc l			;6ffa
	ld (hl),b			;6ffb
	inc l			;6ffc
	ex de,hl			;6ffd
	ldi		;6ffe
	inc bc			;7000
	ex de,hl			;7001
	ex af,af'			;7002
	ld (hl),a			;7003
	ex af,af'			;7004
	inc l			;7005
	ld (hl),c			;7006
	inc l			;7007
	ld a,b			;7008
	add a,010h		;7009
	ld (hl),a			;700b
	inc l			;700c
	ex de,hl			;700d
	ldi		;700e
	inc bc			;7010
	ex de,hl			;7011
	ex af,af'			;7012
	ld (hl),a			;7013
	ex af,af'			;7014
	inc l			;7015
	ld a,c			;7016
	add a,010h		;7017
	ld c,a			;7019
	ld (hl),c			;701a
	inc l			;701b
	ld (hl),b			;701c
	inc l			;701d
	ex de,hl			;701e
	ldi		;701f
	inc bc			;7021
	ex de,hl			;7022
	ex af,af'			;7023
	ld (hl),a			;7024
	ex af,af'			;7025
	inc l			;7026
	ld (hl),c			;7027
	inc l			;7028
	ld a,b			;7029
	add a,010h		;702a
	ld (hl),a			;702c
	inc l			;702d
	ex de,hl			;702e
	ldi		;702f
	inc bc			;7031
	ex de,hl			;7032
	ex af,af'			;7033
	ld (hl),a			;7034
	ex af,af'			;7035
	inc l			;7036
	ex de,hl			;7037
	ret			;7038

; ----------------------------------------------------------------------
; DATOS fichas_7039: 16 fichas de 4 bytes que p01:6FED elige con (ix+0x0A) x 4
;   0x7039..0x7079  (64 bytes)
DATA_fichas_7039:
	defb 0a4h,0a8h,0ach,0b0h	; 7039
	defb 0b4h,0b8h,0bch,0c0h	; 703d
	defb 0c8h,0c4h,0d0h,0cch	; 7041
	defb 0d8h,0d4h,0e0h,0dch	; 7045
	defb 0ach,0b0h,0b4h,0b8h	; 7049
	defb 0ach,0b0h,0c4h,0c0h	; 704d
	defb 0a0h,0a4h,0a8h,0ach	; 7051
	defb 0b0h,0b4h,0b8h,0bch	; 7055
	defb 0a4h,0b4h,0a8h,0b8h	; 7059
	defb 0ach,0bch,0b0h,0c0h	; 705d
	defb 0a0h,0a4h,0a8h,0ach	; 7061
	defb 0b0h,0b4h,0b8h,0bch	; 7065
	defb 0c4h,0cch,0c8h,0d0h	; 7069
	defb 0d4h,0dch,0d8h,0e0h	; 706d
	defb 0a0h,0a4h,0a8h,0ach	; 7071
	defb 0b0h,0b4h,0b8h,0bch	; 7075

; ======================================================================
; CODIGO 0x7079..0x70be  (69 bytes)
; ======================================================================


L_7079:
	ld a,006h		;7079
	ld b,003h		;707b
	jr L_7083		;707d
L_707F:
	ld a,006h		;707f
	ld b,0fdh		;7081
L_7083:
	ex af,af'			;7083
	ld a,b			;7084
	ld (0f005h),a		;7085
	ld a,(ix+00ah)		;7088
	add a,a			;708b
	ld c,a			;708c
	ld b,000h		;708d
	ld hl,070beh		;708f
	add hl,bc			;7092
	ld c,(ix+005h)		;7093
	dec c			;7096
	ld b,(ix+007h)		;7097
	ex de,hl			;709a
	ld (hl),c			;709b
	inc l			;709c
	ld (hl),b			;709d
	inc l			;709e
	ex de,hl			;709f
	ldi		;70a0
	inc bc			;70a2
	ex de,hl			;70a3
	ex af,af'			;70a4
	ld (hl),a			;70a5
	ex af,af'			;70a6
	inc l			;70a7
	ld a,c			;70a8
	add a,003h		;70a9
	ld (hl),a			;70ab
	inc l			;70ac
	ld a,(0f005h)		;70ad
	add a,b			;70b0
	ld (hl),a			;70b1
	inc l			;70b2
	ex de,hl			;70b3
	ldi		;70b4
	inc bc			;70b6
	ex de,hl			;70b7
	ld a,00bh		;70b8
	ld (hl),a			;70ba
	inc l			;70bb
	ex de,hl			;70bc
	ret			;70bd

; ----------------------------------------------------------------------
; DATOS parejas_70be: 4 parejas que p01:708F elige con (ix+0x0A) x 2
;   0x70be..0x70c6  (8 bytes)
DATA_parejas_70be:
	defb 0ach,0b4h	; 70be
	defb 0b0h,0b4h	; 70c0
	defb 0b8h,0c0h	; 70c2
	defb 0bch,0c0h	; 70c4

; ======================================================================
; CODIGO 0x70c6..0x71d9  (275 bytes)
; ======================================================================


L_70C6:
	ld a,008h		;70c6
	ex af,af'			;70c8
	ld a,(ix+009h)		;70c9
	and 007h		;70cc
	dec a			;70ce
	ld (0f007h),a		;70cf
	ld b,(ix+007h)		;70d2
	ex de,hl			;70d5
	call L_7111		;70d6
	ld a,(ix+00ah)		;70d9
	ld c,(ix+005h)		;70dc
	dec c			;70df
L_70E0:
	ld (hl),c			;70e0
	inc l			;70e1
	ld (hl),b			;70e2
	inc l			;70e3
	ld (hl),a			;70e4
	inc l			;70e5
	ex af,af'			;70e6
	ld (hl),a			;70e7
	ex af,af'			;70e8
	inc l			;70e9
	ld a,(0f007h)		;70ea
	dec a			;70ed
	jr z,L_710F		;70ee
	ld (0f007h),a		;70f0
	push bc			;70f3
	ld b,010h		;70f4
	ld a,(ix+015h)		;70f6
	and a			;70f9
	jr z,L_70FE		;70fa
	ld b,0f0h		;70fc
L_70FE:
	ld a,c			;70fe
	add a,b			;70ff
	pop bc			;7100
	ld c,a			;7101
	ld a,(ix+000h)		;7102
	cp 062h		;7105
	ld a,0d4h		;7107
	jr nz,L_70E0		;7109
	ld a,0c8h		;710b
	jr L_70E0		;710d
L_710F:
	ex de,hl			;710f
	ret			;7110
L_7111:
	ld a,(ix+016h)		;7111
	ld (hl),a			;7114
	inc l			;7115
	ld (hl),b			;7116
	inc l			;7117
	ld a,(ix+000h)		;7118
	cp 062h		;711b
	jr z,L_7128		;711d
	ld a,0d0h		;711f
	ld (hl),a			;7121
	inc l			;7122
	ld a,004h		;7123
	ld (hl),a			;7125
	inc l			;7126
	ret			;7127
L_7128:
	ld a,0c8h		;7128
	ld (hl),a			;712a
	inc l			;712b
	ld a,008h		;712c
	ld (hl),a			;712e
	inc l			;712f
	ret			;7130
L_7131:
	ld a,008h		;7131
	ex af,af'			;7133
	ld c,(ix+005h)		;7134
	dec c			;7137
	ld b,(ix+007h)		;7138
	ex de,hl			;713b
	ld a,(ix+016h)		;713c
	dec a			;713f
	ld (hl),a			;7140
	inc l			;7141
	ld (hl),b			;7142
	inc l			;7143
	ld a,0c4h		;7144
	ld (hl),a			;7146
	inc l			;7147
	ld a,004h		;7148
	ld (hl),a			;714a
	inc l			;714b
	ld a,(ix+016h)		;714c
	dec a			;714f
	ld (hl),a			;7150
	inc l			;7151
	ld a,b			;7152
	add a,010h		;7153
	ld (hl),a			;7155
	inc l			;7156
	ld a,0c4h		;7157
	ld (hl),a			;7159
	inc l			;715a
	ld a,004h		;715b
	ld (hl),a			;715d
	inc l			;715e
	ld (hl),c			;715f
	inc l			;7160
	ld (hl),b			;7161
	inc l			;7162
	ld a,0c8h		;7163
	ld (hl),a			;7165
	inc l			;7166
	ex af,af'			;7167
	ld (hl),a			;7168
	ex af,af'			;7169
	inc l			;716a
	ld (hl),c			;716b
	inc l			;716c
	ld a,b			;716d
	add a,010h		;716e
	ld (hl),a			;7170
	inc l			;7171
	ld a,0cch		;7172
	ld (hl),a			;7174
	inc l			;7175
	ex af,af'			;7176
	ld (hl),a			;7177
	inc l			;7178
	ex de,hl			;7179
L_717A:
	ret			;717a
L_717B:
	ld a,(ix+016h)		;717b
	ld (0f007h),a		;717e
	push ix		;7181
	pop hl			;7183
	ld bc,00018h		;7184
	add hl,bc			;7187
	ld c,(ix+005h)		;7188
	ld b,(ix+007h)		;718b
	ex de,hl			;718e
L_718F:
	ld (ix+012h),c		;718f
	ld (hl),c			;7192
	inc l			;7193
	ld (ix+013h),b		;7194
	ld (hl),b			;7197
	inc l			;7198
	ld a,(de)			;7199
	ld (hl),a			;719a
	inc l			;719b
	ld a,(ix+015h)		;719c
	ld (hl),a			;719f
	inc l			;71a0
	ld a,(0f007h)		;71a1
	dec a			;71a4
	jr z,L_71D7		;71a5
	ld (0f007h),a		;71a7
	push hl			;71aa
	ld hl,071d9h		;71ab
	ld a,(de)			;71ae
	sub 0a0h		;71af
	rra			;71b1
	rra			;71b2
	and 007h		;71b3
	call 04136h		;71b5
	ld a,(hl)			;71b8
	ex af,af'			;71b9
	inc de			;71ba
	ld hl,071deh		;71bb
	ld a,(de)			;71be
	sub 0a0h		;71bf
	rra			;71c1
	rra			;71c2
	and 007h		;71c3
	call 04136h		;71c5
	ld a,(hl)			;71c8
	ld h,a			;71c9
	ex af,af'			;71ca
	ld l,a			;71cb
	ld a,b			;71cc
	add a,l			;71cd
	sub h			;71ce
	ld b,a			;71cf
	pop hl			;71d0
	ld a,c			;71d1
	add a,010h		;71d2
	ld c,a			;71d4
	jr L_718F		;71d5
L_71D7:
	ex de,hl			;71d7
	ret			;71d8

; ----------------------------------------------------------------------
; DATOS cinco_bytes_71d9: 5 bytes que p01:71AB elige con ((DE) - 0xA0) / 4
;   0x71d9..0x71de  (5 bytes)
DATA_cinco_bytes_71d9:
	defb 001h,006h,00ah,00ah,00eh	; 71d9

; ----------------------------------------------------------------------
; DATOS cinco_bytes_71de: 5 bytes que p01:71BB elige igual con el byte
;   siguiente
;   0x71de..0x71e3  (5 bytes)
DATA_cinco_bytes_71de:
	defb 006h,007h,000h,00fh,004h	; 71de

; ======================================================================
; CODIGO 0x71e3..0x73af  (460 bytes)
; ======================================================================


L_71E3:
	call L_732F		;71e3
	call L_733C		;71e6
	call L_735F		;71e9
	call L_7219		;71ec
	call L_724C		;71ef
	call L_72B6		;71f2
	call L_7290		;71f5
	call L_72EC		;71f8
	call L_730B		;71fb
	call L_7214		;71fe
	call L_7355		;7201
	ld a,(0eac8h)		;7204
	or a			;7207
	ret z			;7208
	ld hl,0ee68h		;7209
	ld bc,010c4h		;720c
L_720F:
	ld (hl),c			;720f
	inc l			;7210
	djnz L_720F		;7211
	ret			;7213
L_7214:
	ld hl,0eaa0h		;7214
	jr L_7231		;7217
L_7219:
	ld ix,0ea00h		;7219
	exx			;721d
	ld b,002h		;721e
	ld de,00010h		;7220
L_7223:
	exx			;7223
	call L_722E		;7224
	exx			;7227
	add ix,de		;7228
	djnz L_7223		;722a
	exx			;722c
	ret			;722d
L_722E:
	push ix		;722e
	pop hl			;7230
L_7231:
	ld a,(hl)			;7231
	and a			;7232
	ret z			;7233
	inc hl			;7234
	inc hl			;7235
	inc hl			;7236
	inc hl			;7237
	ld a,(hl)			;7238
	and a			;7239
	ret z			;723a
	inc hl			;723b
	ld e,(hl)			;723c
	inc hl			;723d
	ld d,(hl)			;723e
	ld b,a			;723f
	inc hl			;7240
	inc hl			;7241
	ld a,(hl)			;7242
	ex de,hl			;7243
L_7244:
	ld (hl),a			;7244
	ld de,00020h		;7245
	add hl,de			;7248
	djnz L_7244		;7249
	ret			;724b
L_724C:
	ld ix,0ea30h		;724c
	exx			;7250
	ld b,002h		;7251
	ld de,00010h		;7253
L_7256:
	exx			;7256
	call L_7261		;7257
	exx			;725a
	add ix,de		;725b
	djnz L_7256		;725d
	exx			;725f
	ret			;7260
L_7261:
	ld a,(ix+000h)		;7261
	and a			;7264
	ret z			;7265
	ld a,(ix+004h)		;7266
	ld c,(ix+008h)		;7269
	ld b,(ix+009h)		;726c
	ld hl,0a6fbh		;726f
	call 0414ch		;7272
	ld l,(ix+006h)		;7275
	ld h,(ix+007h)		;7278
	ex de,hl			;727b
L_727C:
	push bc			;727c
	ld b,000h		;727d
	ldir		;727f
	ld a,(ix+008h)		;7281
	ld c,a			;7284
	ld a,020h		;7285
	sub c			;7287
	ld c,a			;7288
	ex de,hl			;7289
	add hl,bc			;728a
	ex de,hl			;728b
	pop bc			;728c
	djnz L_727C		;728d
	ret			;728f
L_7290:
	ld ix,0ea60h		;7290
	exx			;7294
	ld b,004h		;7295
	ld de,00010h		;7297
L_729A:
	exx			;729a
	call L_72A5		;729b
	exx			;729e
	add ix,de		;729f
	djnz L_729A		;72a1
	exx			;72a3
	ret			;72a4
L_72A5:
	ld a,(ix+000h)		;72a5
	and a			;72a8
	ret z			;72a9
	ld a,(ix+005h)		;72aa
	ld c,a			;72ad
	ld hl,0a74ch		;72ae
	call 0414ch		;72b1
	jr L_72C9		;72b4
L_72B6:
	ld ix,0ea50h		;72b6
	ld a,(ix+000h)		;72ba
	and a			;72bd
	ret z			;72be
	ld a,(ix+005h)		;72bf
	ld c,a			;72c2
	ld hl,0a726h		;72c3
	call 0414ch		;72c6
L_72C9:
	ld l,(ix+007h)		;72c9
	ld h,(ix+008h)		;72cc
	ex de,hl			;72cf
	ld a,c			;72d0
	ld b,003h		;72d1
	ld c,001h		;72d3
	and a			;72d5
	jr z,L_72DA		;72d6
	ld c,003h		;72d8
L_72DA:
	ld a,c			;72da
	push bc			;72db
	ld b,000h		;72dc
	ldir		;72de
	ld c,a			;72e0
	ld a,020h		;72e1
	sub c			;72e3
	ld c,a			;72e4
	ex de,hl			;72e5
	add hl,bc			;72e6
	ex de,hl			;72e7
	pop bc			;72e8
	djnz L_72DA		;72e9
	ret			;72eb
L_72EC:
	ld hl,0eab0h		;72ec
	ld a,(hl)			;72ef
	and a			;72f0
	ret z			;72f1
	ld hl,0eab8h		;72f2
	ld b,002h		;72f5
L_72F7:
	ld a,(hl)			;72f7
	and a			;72f8
	jr z,L_7305		;72f9
	inc hl			;72fb
	ld e,(hl)			;72fc
	inc hl			;72fd
	ld d,(hl)			;72fe
	ld a,0c2h		;72ff
	ld (de),a			;7301
	inc a			;7302
	inc de			;7303
	ld (de),a			;7304
L_7305:
	ld hl,0eabch		;7305
	djnz L_72F7		;7308
	ret			;730a
L_730B:
	ld a,(0ea20h)		;730b
	or a			;730e
	ret z			;730f
	ld hl,0a772h		;7310
	ld de,(0ea24h)		;7313
	exx			;7317
	ld b,003h		;7318
L_731A:
	exx			;731a
	ldi		;731b
	ldi		;731d
	ldi		;731f
	ldi		;7321
	ld a,01ch		;7323
	add a,e			;7325
	ld e,a			;7326
	jr nc,L_732A		;7327
	inc d			;7329
L_732A:
	exx			;732a
	djnz L_731A		;732b
	exx			;732d
	ret			;732e
L_732F:
	ld a,(0ec08h)		;732f
	or a			;7332
	ret z			;7333
	ld hl,(0ec0ah)		;7334
	ld a,(0ec09h)		;7337
	jr L_7347		;733a
L_733C:
	ld a,(0ec00h)		;733c
	or a			;733f
	ret z			;7340
	ld hl,(0ec05h)		;7341
	ld a,(0ec03h)		;7344
L_7347:
	ld de,09a9bh		;7347
	ld bc,0001fh		;734a
L_734D:
	ld (hl),d			;734d
	inc l			;734e
	ld (hl),e			;734f
	add hl,bc			;7350
	dec a			;7351
	jr nz,L_734D		;7352
	ret			;7354
L_7355:
	ld a,(0eac9h)		;7355
	or a			;7358
	ret z			;7359
	ld hl,0ed9ch		;735a
	jr L_7367		;735d
L_735F:
	ld a,(0eac0h)		;735f
	or a			;7362
	ret z			;7363
	ld hl,(0eac2h)		;7364
L_7367:
	ld de,0001ch		;7367
	ld c,003h		;736a
L_736C:
	ld b,004h		;736c
L_736E:
	ld (hl),0f0h		;736e
	inc hl			;7370
	djnz L_736E		;7371
	add hl,de			;7373
	dec c			;7374
	jr nz,L_736C		;7375
	ret			;7377
L_7378:
	ld hl,0ec30h		;7378
	ld b,003h		;737b
L_737D:
	push bc			;737d
	push hl			;737e
	call L_738B		;737f
	pop hl			;7382
	ld bc,00008h		;7383
	add hl,bc			;7386
	pop bc			;7387
	djnz L_737D		;7388
	ret			;738a
L_738B:
	ld a,(hl)			;738b
	or a			;738c
	ret z			;738d
	inc l			;738e
	ld a,(hl)			;738f
	inc l			;7390
	inc l			;7391
	inc l			;7392
	ld e,(hl)			;7393
	inc l			;7394
	ld d,(hl)			;7395
	ld hl,073afh		;7396
	or a			;7399
	jr z,L_739F		;739a
	ld hl,073b3h		;739c
L_739F:
	ldi		;739f
	ldi		;73a1
	ld a,01eh		;73a3
	add a,e			;73a5
	ld e,a			;73a6
	jr nc,L_73AA		;73a7
	inc d			;73a9
L_73AA:
	ldi		;73aa
	ldi		;73ac
	ret			;73ae

; ----------------------------------------------------------------------
; DATOS bloque_73af: 2 x 2 caracteres que p01:7396 copia (dos y dos, una fila
;   mas abajo)
;   0x73af..0x73b3  (4 bytes)
DATA_bloque_73af:
	defb 0bah,0bbh,0bch,0bdh	; 73af

; ----------------------------------------------------------------------
; DATOS bloque_73b3: 2 x 2 caracteres que p01:739C copia igual cuando A no es
;   0
;   0x73b3..0x73b7  (4 bytes)
DATA_bloque_73b3:
	defb 05ch,05dh,05eh,05fh	; 73b3

; ======================================================================
; CODIGO 0x73b7..0x73d2  (27 bytes)
; ======================================================================


L_73B7:
	ld a,(0e680h)		;73b7
	or a			;73ba
	ret z			;73bb
	ld de,(0e684h)		;73bc
	ld hl,073d2h		;73c0
	ldi		;73c3
	ldi		;73c5
	ex de,hl			;73c7
	ld bc,0001eh		;73c8
	add hl,bc			;73cb
	ex de,hl			;73cc
	ldi		;73cd
	ldi		;73cf
	ret			;73d1

; ----------------------------------------------------------------------
; DATOS bloque_73d2: 2 x 2 caracteres que p01:73C0 copia a (0xE684)
;   0x73d2..0x73d6  (4 bytes)
DATA_bloque_73d2:
	defb 08dh,093h,08eh,094h	; 73d2

; ======================================================================
; CODIGO 0x73d6..0x74d8  (258 bytes)
; ======================================================================


L_73D6:
	ld de,0ec80h		;73d6
	ld b,00fh		;73d9
	call L_6E1D		;73db
	ld hl,0ec80h		;73de
	ld (0e60ah),hl		;73e1
L_73E4:
	ld hl,07529h		;73e4
	ld a,(0e000h)		;73e7
	cp 009h		;73ea
	ld a,(0e53dh)		;73ec
	jr z,L_73F4		;73ef
	ld a,(0e502h)		;73f1
L_73F4:
	cp 0ffh		;73f4
	ret z			;73f6
	call 0414ch		;73f7
	ld hl,(0e60ah)		;73fa
	ex de,hl			;73fd
	ld b,(hl)			;73fe
	inc hl			;73ff
L_7400:
	ld a,(0e505h)		;7400
	add a,(hl)			;7403
	dec a			;7404
	ld (de),a			;7405
	inc hl			;7406
	inc de			;7407
	ld a,(0e507h)		;7408
	add a,(hl)			;740b
	ld c,a			;740c
	ld a,b			;740d
	cp 003h		;740e
	jr nz,L_741D		;7410
	ld a,(0e523h)		;7412
	and a			;7415
	jr z,L_741D		;7416
	ld a,0e0h		;7418
	dec de			;741a
	ld (de),a			;741b
	inc de			;741c
L_741D:
	ld a,c			;741d
	ld (de),a			;741e
	inc hl			;741f
	inc de			;7420
	ld a,(hl)			;7421
	ld (de),a			;7422
	inc hl			;7423
	inc de			;7424
	ld a,(0e000h)		;7425
	cp 009h		;7428
	jr z,L_743A		;742a
	ld a,(0e500h)		;742c
	cp 004h		;742f
	ld c,(hl)			;7431
	jr z,L_745C		;7432
	ld a,(0e533h)		;7434
	dec a			;7437
	jr z,L_745C		;7438
L_743A:
	ld a,b			;743a
	dec a			;743b
	dec a			;743c
	ld a,(hl)			;743d
	jr z,L_7456		;743e
	jp m,L_744B		;7440
	ld a,(0e000h)		;7443
	cp 009h		;7446
	ld a,(hl)			;7448
	jr z,L_7456		;7449
L_744B:
	push hl			;744b
	ld hl,0e501h		;744c
	bit 0,(hl)		;744f
	pop hl			;7451
	jr nz,L_7456		;7452
	ld a,009h		;7454
L_7456:
	ld (de),a			;7456
	inc hl			;7457
	inc de			;7458
	djnz L_7400		;7459
	ret			;745b
L_745C:
	ld a,(0e604h)		;745c
	bit 1,a		;745f
	jr nz,L_746A		;7461
	ld a,b			;7463
	cp 002h		;7464
	jr z,L_746A		;7466
	ld c,006h		;7468
L_746A:
	ld a,c			;746a
	jr L_7456		;746b
L_746D:
	ld ix,0e540h		;746d
	ld b,003h		;7471
	ld de,0ec8ch		;7473
L_7476:
	push de			;7476
	call L_74EA		;7477
	ld de,00020h		;747a
	add ix,de		;747d
	pop de			;747f
	inc e			;7480
	inc e			;7481
	inc e			;7482
	inc e			;7483
	djnz L_7476		;7484
	ld ix,0e5a0h		;7486
	ld b,003h		;748a
	ld de,0ec98h		;748c
L_748F:
	push de			;748f
	call L_74A1		;7490
	ld de,00020h		;7493
	add ix,de		;7496
	ld de,0000ch		;7498
	pop hl			;749b
	add hl,de			;749c
	ex de,hl			;749d
	djnz L_748F		;749e
	ret			;74a0
L_74A1:
	bit 2,(ix+002h)		;74a1
	jr nz,L_74AF		;74a5
	ld a,(ix+000h)		;74a7
	cp 005h		;74aa
	ret nz			;74ac
	jr $+103		;74ad
L_74AF:
	ld a,(0e604h)		;74af
	ld hl,074d8h		;74b2
	bit 2,a		;74b5
	jr z,L_74BC		;74b7
	ld hl,074e1h		;74b9
L_74BC:
	ld c,003h		;74bc
L_74BE:
	ld a,(ix+005h)		;74be
	add a,(hl)			;74c1
	ld (de),a			;74c2
	inc de			;74c3
	inc hl			;74c4
	ld a,(ix+007h)		;74c5
	add a,(hl)			;74c8
	ld (de),a			;74c9
	inc de			;74ca
	inc hl			;74cb
	ld a,(hl)			;74cc
	ld (de),a			;74cd
	inc de			;74ce
	ld a,00fh		;74cf
	ld (de),a			;74d1
	inc hl			;74d2
	inc de			;74d3
	dec c			;74d4
	jr nz,L_74BE		;74d5
	ret			;74d7

; ----------------------------------------------------------------------
; DATOS tres_sprites_74d8: tres ternas que p01:74B2 suma a la posicion de la
;   figura (3 sprites)
;   0x74d8..0x74e1  (9 bytes)
DATA_tres_sprites_74d8:
	defb 000h,000h,0ech,000h,010h,0f0h,0f0h,008h,0e8h	; 74d8  .........

; ----------------------------------------------------------------------
; DATOS tres_sprites_74e1: las mismas tres ternas para el otro cuadro (bit 2
;   de 0xE604, p01:74B9)
;   0x74e1..0x74ea  (9 bytes)
DATA_tres_sprites_74e1:
	defb 000h,000h,0f8h,000h,010h,0fch,0f0h,008h,0f4h	; 74e1  .........

; ======================================================================
; CODIGO 0x74ea..0x7529  (63 bytes)
; ======================================================================


L_74EA:
	bit 7,(ix+014h)		;74ea
	jr nz,L_750C		;74ee
	ld a,(ix+000h)		;74f0
	and a			;74f3
	ret z			;74f4
	ld a,(ix+00ah)		;74f5
	ld l,(ix+015h)		;74f8
	ld h,(ix+016h)		;74fb
	ld (hl),a			;74fe
	bit 0,(ix+010h)		;74ff
	jr nz,L_7508		;7503
	inc a			;7505
	jr L_7509		;7506
L_7508:
	dec a			;7508
L_7509:
	inc hl			;7509
	ld (hl),a			;750a
	ret			;750b
L_750C:
	ld a,(ix+000h)		;750c
	and a			;750f
	ret z			;7510
	cp 005h		;7511
	ret nc			;7513
L_7514:
	ld a,(ix+005h)		;7514
	ld (de),a			;7517
	inc e			;7518
	ld a,(ix+007h)		;7519
	ld (de),a			;751c
	inc e			;751d
	ld a,(ix+00ah)		;751e
	ld (de),a			;7521
	inc e			;7522
	ld a,(ix+00bh)		;7523
	ld (de),a			;7526
	inc e			;7527
	ret			;7528

; ----------------------------------------------------------------------
; DATOS tabla_de_poses_del_jugador: 32 punteros, uno por pose del jugador
;   (0xE502, o 0xE53D en el estado 9), que p01:73E4 elige con 0x414C (0xFF no
;   pinta nada)
;   0x7529..0x7569  (64 bytes)
DATA_tabla_de_poses_del_jugador:
	defb 069h,075h	; 7529
	defb 072h,075h	; 752b
	defb 07bh,075h	; 752d
	defb 084h,075h	; 752f
	defb 0c1h,075h	; 7531
	defb 0cah,075h	; 7533
	defb 0a7h,075h	; 7535
	defb 0b4h,075h	; 7537
	defb 08dh,075h	; 7539
	defb 09ah,075h	; 753b
	defb 0d3h,075h	; 753d
	defb 0dch,075h	; 753f
	defb 0e5h,075h	; 7541
	defb 0eeh,075h	; 7543
	defb 0f7h,075h	; 7545
	defb 0fch,075h	; 7547
	defb 001h,076h	; 7549
	defb 00ah,076h	; 754b
	defb 013h,076h	; 754d
	defb 018h,076h	; 754f
	defb 01dh,076h	; 7551
	defb 022h,076h	; 7553
	defb 027h,076h	; 7555
	defb 02ch,076h	; 7557
	defb 031h,076h	; 7559
	defb 036h,076h	; 755b
	defb 03bh,076h	; 755d
	defb 040h,076h	; 755f
	defb 045h,076h	; 7561
	defb 052h,076h	; 7563
	defb 052h,076h	; 7565
	defb 05fh,076h	; 7567

; ----------------------------------------------------------------------
; DATOS poses_del_jugador: las poses: [cuantos sprites] y, por sprite,
;   [dY][dX][dibujo][color] que p01:7400 suma a la posicion del jugador
;   (0xE505/0xE507) y copia a 0xEC80
;   0x7569..0x766c  (259 bytes)
DATA_poses_del_jugador:
	defb 002h,0e7h,0f6h,018h,00bh,0f0h,0f8h,000h,00fh,002h,0e8h,0f6h,018h,00bh,0f0h,0f8h	; 7569  ................
	defb 004h,00fh,002h,0e7h,0fah,070h,00bh,0f0h,0f8h,058h,00fh,002h,0e8h,0fah,070h,00bh	; 7579  .....p...X....p.
	defb 0f0h,0f8h,05ch,00fh,003h,0f9h,00bh,00ch,00fh,0e8h,0fah,01ch,00bh,0f0h,0fbh,008h	; 7589  ..\.............
	defb 00fh,003h,0f9h,0e5h,064h,00fh,0e8h,0f6h,074h,00bh,0f0h,0f5h,060h,00fh,003h,0f9h	; 7599  ....d...t...`...
	defb 008h,00ch,00fh,0e8h,0f7h,01ch,00bh,0f0h,0f8h,014h,00fh,003h,0f9h,0e8h,064h,00fh	; 75a9  ..............d.
	defb 0e8h,0f9h,074h,00bh,0f0h,0f8h,06ch,00fh,002h,0e8h,0f6h,018h,00bh,0f0h,0f8h,010h	; 75b9  ..t...l.........
	defb 00fh,002h,0e8h,0fah,070h,00bh,0f0h,0f8h,068h,00fh,002h,0e9h,0f4h,028h,00bh,0f0h	; 75c9  ....p...h....(..
	defb 0f8h,020h,00fh,002h,0eah,0f5h,02ch,00bh,0f0h,0f8h,024h,00fh,002h,0e9h,0fch,080h	; 75d9  . ....,...$.....
	defb 00bh,0f0h,0f8h,078h,00fh,002h,0eah,0fbh,084h,00bh,0f0h,0f8h,07ch,00fh,001h,0f0h	; 75e9  ...x........|...
	defb 0f8h,038h,00fh,001h,0f0h,0f8h,03ch,00fh,002h,0e7h,0f4h,048h,00bh,0f0h,0f8h,040h	; 75f9  .8....<....H...@
	defb 00fh,002h,0e7h,0f4h,048h,00bh,0f0h,0f8h,044h,00fh,001h,0f0h,0f8h,020h,00fh,001h	; 7609  ....H...D.... ..
	defb 0f0h,0f8h,024h,00fh,001h,0f0h,0f8h,028h,00fh,001h,0f0h,0f8h,02ch,00fh,001h,0f0h	; 7619  ..$....(....,...
	defb 0f8h,030h,00fh,001h,0f0h,0f8h,034h,00fh,001h,0f0h,0f8h,038h,00fh,001h,0f0h,0f8h	; 7629  .0....4....8....
	defb 03ch,00fh,001h,0f0h,0f8h,040h,00fh,001h,0f0h,0f8h,044h,00fh,003h,0f0h,0f5h,000h	; 7639  <....@....D.....
	defb 00fh,0e8h,0f8h,004h,00bh,0e8h,0f8h,008h,00fh,003h,0f0h,0f5h,000h,00fh,0e8h,0f7h	; 7649  ................
	defb 00ch,00bh,0e8h,0f7h,010h,00fh,003h,0f0h,0f5h,000h,00fh,0e9h,0f6h,014h,00bh,0efh	; 7659  ................
	defb 0f7h,018h,00fh	; 7669

; ======================================================================
; CODIGO 0x766c..0x78ba  (590 bytes)
; ======================================================================


L_766C:
	ld a,(0e614h)		;766c
	or a			;766f
	ret z			;7670
	exx			;7671
	ld b,a			;7672
	exx			;7673
	ld de,0ecf8h		;7674
	dec a			;7677
	jr z,L_767C		;7678
	ld e,0f0h		;767a
L_767C:
	ld hl,0ec10h		;767c
	call L_769C		;767f
	jr nc,L_7688		;7682
	exx			;7684
	dec b			;7685
	exx			;7686
	ret z			;7687
L_7688:
	ld hl,0ec20h		;7688
	call L_769C		;768b
	jr nc,L_7694		;768e
	exx			;7690
	dec b			;7691
	exx			;7692
	ret z			;7693
L_7694:
	exx			;7694
	ld a,b			;7695
	exx			;7696
	add a,a			;7697
	ld b,a			;7698
	jp L_6E1D		;7699
L_769C:
	ld a,(hl)			;769c
	or a			;769d
	ret z			;769e
	ld a,005h		;769f
	add a,l			;76a1
	ld l,a			;76a2
	ld a,(hl)			;76a3
	dec a			;76a4
	ld (de),a			;76a5
	ld c,a			;76a6
	inc e			;76a7
	inc l			;76a8
	inc l			;76a9
	ld a,(hl)			;76aa
	ld (de),a			;76ab
	add a,010h		;76ac
	ld b,a			;76ae
	inc e			;76af
	ld a,0e4h		;76b0
	ld (de),a			;76b2
	inc e			;76b3
	ld a,00fh		;76b4
	ld (de),a			;76b6
	inc e			;76b7
	ex de,hl			;76b8
	ld (hl),c			;76b9
	inc l			;76ba
	ld (hl),b			;76bb
	inc l			;76bc
	ld (hl),0e4h		;76bd
	inc l			;76bf
	ld (hl),00fh		;76c0
	inc l			;76c2
	ex de,hl			;76c3
	scf			;76c4
	ret			;76c5
L_76C6:
	ld de,0eb00h		;76c6
	call L_76D8		;76c9
	call L_77EE		;76cc
	call L_7761		;76cf
	call L_7794		;76d2
	jp L_77A9		;76d5
L_76D8:
	ld ix,0e800h		;76d8
	exx			;76dc
	ld b,010h		;76dd
	ld de,00020h		;76df
L_76E2:
	exx			;76e2
	call L_76ED		;76e3
	exx			;76e6
	add ix,de		;76e7
	djnz L_76E2		;76e9
	exx			;76eb
	ret			;76ec
L_76ED:
	bit 7,(ix+002h)		;76ed
	ret z			;76f1
	ld a,(ix+009h)		;76f2
	rla			;76f5
	ret c			;76f6
	rla			;76f7
	jr c,L_7720		;76f8
	ld a,(ix+00ah)		;76fa
	call L_6EA7		;76fd
	ld l,(ix+005h)		;7700
	ld h,(ix+007h)		;7703
	call 04da1h		;7706
	ld (ix+012h),l		;7709
	ld (ix+013h),h		;770c
L_770F:
	push bc			;770f
	ld b,000h		;7710
	ldir		;7712
	pop bc			;7714
	ld a,020h		;7715
	sub c			;7717
	add a,l			;7718
	ld l,a			;7719
	jr nc,L_771D		;771a
	inc h			;771c
L_771D:
	djnz L_770F		;771d
	ret			;771f
L_7720:
	ld a,(ix+00bh)		;7720
	or a			;7723
	jr z,L_773F		;7724
	dec a			;7726
	jr z,L_7753		;7727
	cp 006h		;7729
	ret nz			;772b
	ld l,(ix+012h)		;772c
	ld h,(ix+013h)		;772f
	ldi		;7732
	ldi		;7734
	ld bc,0001eh		;7736
	add hl,bc			;7739
	ldi		;773a
	ldi		;773c
	ret			;773e
L_773F:
	ld l,(ix+012h)		;773f
	ld h,(ix+013h)		;7742
	ld a,(ix+014h)		;7745
	inc a			;7748
L_7749:
	ldi		;7749
	ld bc,0001fh		;774b
	add hl,bc			;774e
	dec a			;774f
	jr nz,L_7749		;7750
	ret			;7752
L_7753:
	ld l,(ix+012h)		;7753
	ld h,(ix+013h)		;7756
	ld c,(ix+01fh)		;7759
	ld b,000h		;775c
	ldir		;775e
	ret			;7760
L_7761:
	ld ix,0e540h		;7761
	exx			;7765
	ld b,003h		;7766
	ld de,00020h		;7768
L_776B:
	exx			;776b
	call L_7776		;776c
	exx			;776f
	add ix,de		;7770
	djnz L_776B		;7772
	exx			;7774
	ret			;7775
L_7776:
	ld a,(ix+000h)		;7776
	or a			;7779
	ret z			;777a
	bit 7,(ix+014h)		;777b
	ret nz			;777f
	ld l,(ix+005h)		;7780
	ld h,(ix+007h)		;7783
	call 04da1h		;7786
	ld (ix+015h),l		;7789
	ld (ix+016h),h		;778c
	ldi		;778f
	ldi		;7791
	ret			;7793
L_7794:
	ld a,(0e740h)		;7794
	or a			;7797
	ret z			;7798
	ld hl,(0e744h)		;7799
	ldi		;779c
	ldi		;779e
	ld bc,0001eh		;77a0
	add hl,bc			;77a3
	ldi		;77a4
	ldi		;77a6
	ret			;77a8
L_77A9:
	ld a,(0e0d2h)		;77a9
	or a			;77ac
	ret z			;77ad
	ld ix,0e700h		;77ae
	ld a,(ix+000h)		;77b2
	or a			;77b5
	ret z			;77b6
	bit 7,(ix+002h)		;77b7
	ret z			;77bb
	ld a,(ix+009h)		;77bc
	rla			;77bf
	rla			;77c0
	jr c,L_77CA		;77c1
	rla			;77c3
	jp nc,L_6CEB		;77c4
	jp L_6D14		;77c7
L_77CA:
	ld b,005h		;77ca
	ld c,00eh		;77cc
	call L_6DDC		;77ce
	ld (ix+015h),c		;77d1
	ld (ix+014h),b		;77d4
	bit 4,(ix+009h)		;77d7
	jr z,L_77E0		;77db
	ld b,(ix+01ah)		;77dd
L_77E0:
	push bc			;77e0
	push hl			;77e1
	ld b,000h		;77e2
	ldir		;77e4
	pop hl			;77e6
	ld c,020h		;77e7
	add hl,bc			;77e9
	pop bc			;77ea
	djnz L_77E0		;77eb
	ret			;77ed
L_77EE:
	call L_796D		;77ee
	call L_797A		;77f1
	call L_799B		;77f4
	call L_7822		;77f7
	call L_7862		;77fa
	call L_78D9		;77fd
	call L_78C4		;7800
	call L_791E		;7803
	call L_794D		;7806
	call L_781D		;7809
	call L_7991		;780c
	ld a,(0eac8h)		;780f
	or a			;7812
	ret z			;7813
	ld hl,0ee68h		;7814
	ld bc,00010h		;7817
	ldir		;781a
	ret			;781c
L_781D:
	ld hl,0eaa0h		;781d
	jr L_783A		;7820
L_7822:
	ld ix,0ea00h		;7822
	exx			;7826
	ld b,002h		;7827
	ld de,00010h		;7829
L_782C:
	exx			;782c
	call L_7837		;782d
	exx			;7830
	add ix,de		;7831
	djnz L_782C		;7833
	exx			;7835
	ret			;7836
L_7837:
	push ix		;7837
	pop hl			;7839
L_783A:
	ld a,(hl)			;783a
	or a			;783b
	ret z			;783c
	push de			;783d
	ex de,hl			;783e
	inc de			;783f
	inc de			;7840
	ld a,(de)			;7841
	ld l,a			;7842
	inc de			;7843
	ld a,(de)			;7844
	ld h,a			;7845
	call 04da1h		;7846
	inc de			;7849
	inc de			;784a
	ld a,l			;784b
	ld (de),a			;784c
	inc de			;784d
	ld a,h			;784e
	ld (de),a			;784f
	dec de			;7850
	dec de			;7851
	ld a,(de)			;7852
	pop de			;7853
	and a			;7854
	ret z			;7855
	ld b,a			;7856
L_7857:
	push bc			;7857
	ldi		;7858
	ld bc,0001fh		;785a
	add hl,bc			;785d
	pop bc			;785e
	djnz L_7857		;785f
	ret			;7861
L_7862:
	ld ix,0ea30h		;7862
	exx			;7866
	ld b,002h		;7867
	ld de,00010h		;7869
L_786C:
	exx			;786c
	call L_7877		;786d
	exx			;7870
	add ix,de		;7871
	djnz L_786C		;7873
	exx			;7875
	ret			;7876
L_7877:
	ld a,(ix+000h)		;7877
	and a			;787a
	ret z			;787b
	push ix		;787c
	pop hl			;787e
	inc hl			;787f
	inc hl			;7880
	push de			;7881
	ex de,hl			;7882
	ld a,(de)			;7883
	ld l,a			;7884
	inc de			;7885
	ld a,(de)			;7886
	ld h,a			;7887
	call 04da1h		;7888
	inc de			;788b
	inc de			;788c
	inc de			;788d
	ld a,l			;788e
	ld (de),a			;788f
	inc de			;7890
	ld a,h			;7891
	ld (de),a			;7892
	push hl			;7893
	ld hl,078bah		;7894
	dec de			;7897
	dec de			;7898
	dec de			;7899
	ld a,(de)			;789a
	call 0414ch		;789b
	ld b,d			;789e
	ld c,e			;789f
	ld (ix+008h),c		;78a0
	ld (ix+009h),b		;78a3
	pop hl			;78a6
	pop de			;78a7
L_78A8:
	push bc			;78a8
	ld b,000h		;78a9
	ldir		;78ab
	ld a,(ix+008h)		;78ad
	ld c,a			;78b0
	ld a,020h		;78b1
	sub c			;78b3
	ld c,a			;78b4
	add hl,bc			;78b5
	pop bc			;78b6
	djnz L_78A8		;78b7
	ret			;78b9

; ----------------------------------------------------------------------
; DATOS tamanos_78ba: 5 parejas [ancho][alto] que p01:7894 elige con 0x414C y
;   pone en (ix+8) y (ix+9): las de los dibujos de la tabla p15:A6FB (1 x 3, 2
;   x 3, 3 x 3, 2 x 3 y 3 x 3)
;   0x78ba..0x78c4  (10 bytes)
DATA_tamanos_78ba:
	defb 001h,003h	; 78ba
	defb 002h,003h	; 78bc
	defb 003h,003h	; 78be
	defb 002h,003h	; 78c0
	defb 003h,003h	; 78c2

; ======================================================================
; CODIGO 0x78c4..0x7cae  (1002 bytes)
; ======================================================================


L_78C4:
	ld ix,0ea60h		;78c4
	exx			;78c8
	ld b,004h		;78c9
	ld de,00010h		;78cb
L_78CE:
	exx			;78ce
	call L_78DD		;78cf
	exx			;78d2
	add ix,de		;78d3
	djnz L_78CE		;78d5
	exx			;78d7
	ret			;78d8
L_78D9:
	ld ix,0ea50h		;78d9
L_78DD:
	push ix		;78dd
	pop hl			;78df
	ld a,(hl)			;78e0
	and a			;78e1
	ret z			;78e2
	inc hl			;78e3
	inc hl			;78e4
	push de			;78e5
	ld e,(hl)			;78e6
	inc hl			;78e7
	inc hl			;78e8
	inc hl			;78e9
	ld a,(hl)			;78ea
	dec hl			;78eb
	dec hl			;78ec
	ld c,a			;78ed
	and a			;78ee
	ld a,(hl)			;78ef
	jr z,L_78F4		;78f0
	sub 008h		;78f2
L_78F4:
	inc hl			;78f4
	ld (hl),a			;78f5
	ld d,a			;78f6
	ex de,hl			;78f7
	call 04da1h		;78f8
	ex de,hl			;78fb
	inc hl			;78fc
	inc hl			;78fd
	inc hl			;78fe
	ld (hl),e			;78ff
	inc hl			;7900
	ld (hl),d			;7901
	ex de,hl			;7902
	pop de			;7903
	ld a,c			;7904
	ld b,003h		;7905
	ld c,001h		;7907
	and a			;7909
	jr z,L_790E		;790a
	ld c,003h		;790c
L_790E:
	ld a,c			;790e
	push bc			;790f
	ld b,000h		;7910
	ldir		;7912
	ld c,a			;7914
	ld a,020h		;7915
	sub c			;7917
	ld c,a			;7918
	add hl,bc			;7919
	pop bc			;791a
	djnz L_790E		;791b
	ret			;791d
L_791E:
	ld hl,0eab0h		;791e
	ld a,(hl)			;7921
	and a			;7922
	ret z			;7923
	ld hl,0eab7h		;7924
	exx			;7927
	ld b,002h		;7928
L_792A:
	exx			;792a
	ld c,(hl)			;792b
	inc hl			;792c
	ld b,(hl)			;792d
	ld a,b			;792e
	and a			;792f
	jr z,L_7945		;7930
	push de			;7932
	ld e,c			;7933
	ld d,b			;7934
	ex de,hl			;7935
	call 04da1h		;7936
	ex de,hl			;7939
	inc hl			;793a
	ld (hl),e			;793b
	inc hl			;793c
	ld (hl),d			;793d
	pop hl			;793e
	ex de,hl			;793f
	ld bc,00002h		;7940
	ldir		;7943
L_7945:
	ld hl,0eabbh		;7945
	exx			;7948
	djnz L_792A		;7949
	exx			;794b
	ret			;794c
L_794D:
	ld a,(0ea20h)		;794d
	or a			;7950
	ret z			;7951
	ld hl,(0ea21h)		;7952
	call 04da1h		;7955
	ld (0ea24h),hl		;7958
	ld a,003h		;795b
L_795D:
	ldi		;795d
	ldi		;795f
	ldi		;7961
	ldi		;7963
	ld bc,0001ch		;7965
	add hl,bc			;7968
	dec a			;7969
	jr nz,L_795D		;796a
	ret			;796c
L_796D:
	ld a,(0ec08h)		;796d
	or a			;7970
	ret z			;7971
	ld hl,(0ec0ah)		;7972
	ld a,(0ec09h)		;7975
	jr L_7985		;7978
L_797A:
	ld a,(0ec00h)		;797a
	or a			;797d
	ret z			;797e
	ld hl,(0ec05h)		;797f
	ld a,(0ec03h)		;7982
L_7985:
	ldi		;7985
	ldi		;7987
	ld bc,0001eh		;7989
	add hl,bc			;798c
	dec a			;798d
	jr nz,L_7985		;798e
	ret			;7990
L_7991:
	ld a,(0eac9h)		;7991
	or a			;7994
	ret z			;7995
	ld hl,0ed9ch		;7996
	jr L_79A3		;7999
L_799B:
	ld a,(0eac0h)		;799b
	or a			;799e
	ret z			;799f
	ld hl,(0eac2h)		;79a0
L_79A3:
	ld a,003h		;79a3
L_79A5:
	ld bc,00004h		;79a5
	ldir		;79a8
	ld bc,0001ch		;79aa
	add hl,bc			;79ad
	dec a			;79ae
	jr nz,L_79A5		;79af
	ret			;79b1
L_79B2:
	ld hl,0ec30h		;79b2
	ld b,003h		;79b5
L_79B7:
	push bc			;79b7
	push hl			;79b8
	call L_79C5		;79b9
	pop hl			;79bc
	ld bc,00008h		;79bd
	add hl,bc			;79c0
	pop bc			;79c1
	djnz L_79B7		;79c2
	ret			;79c4
L_79C5:
	ld a,(hl)			;79c5
	or a			;79c6
	ret z			;79c7
	ld a,l			;79c8
	add a,004h		;79c9
	ld l,a			;79cb
	ld a,(hl)			;79cc
	inc l			;79cd
	ld h,(hl)			;79ce
	ld l,a			;79cf
	ldi		;79d0
	ldi		;79d2
	ld bc,0001eh		;79d4
	add hl,bc			;79d7
	ldi		;79d8
	ldi		;79da
	ret			;79dc
L_79DD:
	ld hl,0eb00h		;79dd
	call L_7A36		;79e0
	call L_7AFE		;79e3
	call L_7ABB		;79e6
	call L_7AE5		;79e9
	ld a,(0e0d2h)		;79ec
	or a			;79ef
	ret z			;79f0
	ld (0e644h),hl		;79f1
L_79F4:
	ld hl,(0e644h)		;79f4
	ld ix,0e700h		;79f7
	ld a,(0e700h)		;79fb
	or a			;79fe
	ret z			;79ff
	bit 7,(ix+002h)		;7a00
	ret z			;7a04
	ld a,(0e709h)		;7a05
	rla			;7a08
	rla			;7a09
	jr c,L_7A13		;7a0a
	rla			;7a0c
	jp nc,L_6D34		;7a0d
	jp L_6D59		;7a10
L_7A13:
	ld c,00eh		;7a13
	ld b,005h		;7a15
	ld e,(ix+012h)		;7a17
	ld d,(ix+013h)		;7a1a
	bit 4,(ix+009h)		;7a1d
	jr z,L_7A26		;7a21
	ld b,(ix+01ah)		;7a23
L_7A26:
	push bc			;7a26
	push de			;7a27
	ld b,000h		;7a28
	ldir		;7a2a
	pop de			;7a2c
	ex de,hl			;7a2d
	ld c,020h		;7a2e
	add hl,bc			;7a30
	ex de,hl			;7a31
	pop bc			;7a32
	djnz L_7A26		;7a33
	ret			;7a35
L_7A36:
	ld ix,0e800h		;7a36
	exx			;7a3a
	ld b,010h		;7a3b
	ld de,00020h		;7a3d
L_7A40:
	exx			;7a40
	call L_7A4B		;7a41
	exx			;7a44
	add ix,de		;7a45
	djnz L_7A40		;7a47
	exx			;7a49
	ret			;7a4a
L_7A4B:
	bit 7,(ix+002h)		;7a4b
	ret z			;7a4f
	ld a,(ix+009h)		;7a50
	rla			;7a53
	ret c			;7a54
	rla			;7a55
	jr c,L_7A77		;7a56
	ld e,(ix+012h)		;7a58
	ld d,(ix+013h)		;7a5b
	ld a,(ix+00ah)		;7a5e
	push hl			;7a61
	call L_6EA7		;7a62
	pop hl			;7a65
L_7A66:
	push bc			;7a66
	ld b,000h		;7a67
	ldir		;7a69
	pop bc			;7a6b
	ld a,020h		;7a6c
	sub c			;7a6e
	add a,e			;7a6f
	ld e,a			;7a70
	jr nc,L_7A74		;7a71
	inc d			;7a73
L_7A74:
	djnz L_7A66		;7a74
	ret			;7a76
L_7A77:
	ld a,(ix+00bh)		;7a77
	or a			;7a7a
	jr z,L_7A97		;7a7b
	dec a			;7a7d
	jr z,L_7AAD		;7a7e
	cp 006h		;7a80
	ret nz			;7a82
	ld e,(ix+012h)		;7a83
	ld d,(ix+013h)		;7a86
	ldi		;7a89
	ldi		;7a8b
	ld a,01eh		;7a8d
	call 0413bh		;7a8f
	ldi		;7a92
	ldi		;7a94
	ret			;7a96
L_7A97:
	ld e,(ix+012h)		;7a97
	ld d,(ix+013h)		;7a9a
	ld a,(ix+014h)		;7a9d
	inc a			;7aa0
L_7AA1:
	ldi		;7aa1
	ex de,hl			;7aa3
	ld bc,0001fh		;7aa4
	add hl,bc			;7aa7
	ex de,hl			;7aa8
	dec a			;7aa9
	jr nz,L_7AA1		;7aaa
	ret			;7aac
L_7AAD:
	ld e,(ix+012h)		;7aad
	ld d,(ix+013h)		;7ab0
	ld c,(ix+01fh)		;7ab3
	ld b,000h		;7ab6
	ldir		;7ab8
	ret			;7aba
L_7ABB:
	ld ix,0e540h		;7abb
	exx			;7abf
	ld b,003h		;7ac0
	ld de,00020h		;7ac2
L_7AC5:
	exx			;7ac5
	call L_7AD0		;7ac6
	exx			;7ac9
	add ix,de		;7aca
	djnz L_7AC5		;7acc
	exx			;7ace
	ret			;7acf
L_7AD0:
	ld a,(ix+000h)		;7ad0
	or a			;7ad3
	ret z			;7ad4
	bit 7,(ix+014h)		;7ad5
	ret nz			;7ad9
	ld e,(ix+015h)		;7ada
	ld d,(ix+016h)		;7add
	ldi		;7ae0
	ldi		;7ae2
	ret			;7ae4
L_7AE5:
	ld a,(0e740h)		;7ae5
	or a			;7ae8
	ret z			;7ae9
	ld de,(0e744h)		;7aea
	ldi		;7aee
	ldi		;7af0
	ld a,01eh		;7af2
	add a,e			;7af4
	ld e,a			;7af5
	jr nc,L_7AF9		;7af6
	inc d			;7af8
L_7AF9:
	ldi		;7af9
	ldi		;7afb
	ret			;7afd
L_7AFE:
	call L_7C32		;7afe
	call L_7C40		;7b01
	call L_7C64		;7b04
	call L_7B32		;7b07
	call L_7B69		;7b0a
	call L_7BB8		;7b0d
	call L_7BA3		;7b10
	call L_7BEB		;7b13
	call L_7C11		;7b16
	call L_7B2D		;7b19
	call L_7C5A		;7b1c
	ld a,(0eac8h)		;7b1f
	or a			;7b22
	ret z			;7b23
	ld de,0ee68h		;7b24
	ld bc,00010h		;7b27
	ldir		;7b2a
	ret			;7b2c
L_7B2D:
	ld de,0eaa0h		;7b2d
	jr L_7B4A		;7b30
L_7B32:
	ld ix,0ea00h		;7b32
	exx			;7b36
	ld b,002h		;7b37
	ld de,00010h		;7b39
L_7B3C:
	exx			;7b3c
	call L_7B47		;7b3d
	exx			;7b40
	add ix,de		;7b41
	djnz L_7B3C		;7b43
	exx			;7b45
	ret			;7b46
L_7B47:
	push ix		;7b47
	pop de			;7b49
L_7B4A:
	ld a,(de)			;7b4a
	and a			;7b4b
	ret z			;7b4c
	push hl			;7b4d
	ex de,hl			;7b4e
	inc hl			;7b4f
	inc hl			;7b50
	inc hl			;7b51
	inc hl			;7b52
	ld a,(hl)			;7b53
	inc hl			;7b54
	ld e,(hl)			;7b55
	inc hl			;7b56
	ld d,(hl)			;7b57
	pop hl			;7b58
	and a			;7b59
	ret z			;7b5a
	ld b,a			;7b5b
L_7B5C:
	push bc			;7b5c
	ldi		;7b5d
	ld bc,0001fh		;7b5f
	ex de,hl			;7b62
	add hl,bc			;7b63
	ex de,hl			;7b64
	pop bc			;7b65
	djnz L_7B5C		;7b66
	ret			;7b68
L_7B69:
	ld ix,0ea30h		;7b69
	exx			;7b6d
	ld b,002h		;7b6e
	ld de,00010h		;7b70
L_7B73:
	exx			;7b73
	call L_7B7E		;7b74
	exx			;7b77
	add ix,de		;7b78
	djnz L_7B73		;7b7a
	exx			;7b7c
	ret			;7b7d
L_7B7E:
	ld a,(ix+000h)		;7b7e
	and a			;7b81
	ret z			;7b82
	ld e,(ix+006h)		;7b83
	ld d,(ix+007h)		;7b86
	ld c,(ix+008h)		;7b89
	ld b,(ix+009h)		;7b8c
L_7B8F:
	push bc			;7b8f
	ld b,000h		;7b90
	ldir		;7b92
	ld a,(ix+008h)		;7b94
	ld c,a			;7b97
	ld a,020h		;7b98
	sub c			;7b9a
	ld c,a			;7b9b
	ex de,hl			;7b9c
	add hl,bc			;7b9d
	ex de,hl			;7b9e
	pop bc			;7b9f
	djnz L_7B8F		;7ba0
	ret			;7ba2
L_7BA3:
	ld ix,0ea60h		;7ba3
	exx			;7ba7
	ld b,004h		;7ba8
	ld de,00010h		;7baa
L_7BAD:
	exx			;7bad
	call L_7BBC		;7bae
	exx			;7bb1
	add ix,de		;7bb2
	djnz L_7BAD		;7bb4
	exx			;7bb6
	ret			;7bb7
L_7BB8:
	ld ix,0ea50h		;7bb8
L_7BBC:
	push ix		;7bbc
	pop de			;7bbe
	ld a,(de)			;7bbf
	and a			;7bc0
	ret z			;7bc1
	push hl			;7bc2
	ex de,hl			;7bc3
	inc hl			;7bc4
	inc hl			;7bc5
	inc hl			;7bc6
	inc hl			;7bc7
	inc hl			;7bc8
	ld a,(hl)			;7bc9
	inc hl			;7bca
	inc hl			;7bcb
	ld e,(hl)			;7bcc
	inc hl			;7bcd
	ld d,(hl)			;7bce
	pop hl			;7bcf
	ld b,003h		;7bd0
	ld c,001h		;7bd2
	and a			;7bd4
	jr z,L_7BD9		;7bd5
	ld c,003h		;7bd7
L_7BD9:
	ld a,c			;7bd9
	push bc			;7bda
	ld b,000h		;7bdb
	ldir		;7bdd
	ld c,a			;7bdf
	ld a,020h		;7be0
	sub c			;7be2
	ld c,a			;7be3
	ex de,hl			;7be4
	add hl,bc			;7be5
	ex de,hl			;7be6
	pop bc			;7be7
	djnz L_7BD9		;7be8
	ret			;7bea
L_7BEB:
	ld de,0eab0h		;7beb
	ld a,(de)			;7bee
	and a			;7bef
	ret z			;7bf0
	ld de,0eab8h		;7bf1
	exx			;7bf4
	ld b,002h		;7bf5
L_7BF7:
	exx			;7bf7
	ld a,(de)			;7bf8
	and a			;7bf9
	jr z,L_7C09		;7bfa
	inc de			;7bfc
	ld a,(de)			;7bfd
	ld c,a			;7bfe
	inc de			;7bff
	ld a,(de)			;7c00
	ld b,a			;7c01
	ld e,c			;7c02
	ld d,b			;7c03
	ld bc,00002h		;7c04
	ldir		;7c07
L_7C09:
	ld de,0eabch		;7c09
	exx			;7c0c
	djnz L_7BF7		;7c0d
	exx			;7c0f
	ret			;7c10
L_7C11:
	ld a,(0ea20h)		;7c11
	or a			;7c14
	ret z			;7c15
	ld de,(0ea24h)		;7c16
	exx			;7c1a
	ld b,003h		;7c1b
L_7C1D:
	exx			;7c1d
	ldi		;7c1e
	ldi		;7c20
	ldi		;7c22
	ldi		;7c24
	ld a,01ch		;7c26
	add a,e			;7c28
	ld e,a			;7c29
	jr nc,L_7C2D		;7c2a
	inc d			;7c2c
L_7C2D:
	exx			;7c2d
	djnz L_7C1D		;7c2e
	exx			;7c30
	ret			;7c31
L_7C32:
	ld a,(0ec08h)		;7c32
	or a			;7c35
	ret z			;7c36
	ld de,(0ec0ah)		;7c37
	ld a,(0ec09h)		;7c3b
	jr L_7C4C		;7c3e
L_7C40:
	ld a,(0ec00h)		;7c40
	or a			;7c43
	ret z			;7c44
	ld de,(0ec05h)		;7c45
	ld a,(0ec03h)		;7c49
L_7C4C:
	ldi		;7c4c
	ldi		;7c4e
	ld bc,0001eh		;7c50
	ex de,hl			;7c53
	add hl,bc			;7c54
	ex de,hl			;7c55
	dec a			;7c56
	jr nz,L_7C4C		;7c57
	ret			;7c59
L_7C5A:
	ld a,(0eac9h)		;7c5a
	or a			;7c5d
	ret z			;7c5e
	ld de,0ed9ch		;7c5f
	jr L_7C6D		;7c62
L_7C64:
	ld a,(0eac0h)		;7c64
	or a			;7c67
	ret z			;7c68
	ld de,(0eac2h)		;7c69
L_7C6D:
	ld a,003h		;7c6d
L_7C6F:
	ld bc,00004h		;7c6f
	ldir		;7c72
	ld bc,0001ch		;7c74
	ex de,hl			;7c77
	add hl,bc			;7c78
	ex de,hl			;7c79
	dec a			;7c7a
	jr nz,L_7C6F		;7c7b
	ret			;7c7d
L_7C7E:
	ld ix,0ec30h		;7c7e
	exx			;7c82
	ld de,00008h		;7c83
	ld b,003h		;7c86
L_7C88:
	exx			;7c88
	call L_7C93		;7c89
	exx			;7c8c
	add ix,de		;7c8d
	djnz L_7C88		;7c8f
	exx			;7c91
	ret			;7c92
L_7C93:
	ld a,(ix+000h)		;7c93
	or a			;7c96
	ret z			;7c97
	ld e,(ix+004h)		;7c98
	ld d,(ix+005h)		;7c9b
	ldi		;7c9e
	ldi		;7ca0
	ld a,01eh		;7ca2
	add a,e			;7ca4
	ld e,a			;7ca5
	jr nc,L_7CA9		;7ca6
	inc d			;7ca8
L_7CA9:
	ldi		;7ca9
	ldi		;7cab
	ret			;7cad

; ----------------------------------------------------------------------
; DATOS lista_vram_7CAE: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p01:6050 (72 bytes)
;   0x7cae..0x7cf6  (72 bytes)
DATA_lista_vram_7CAE:
	defb 003h,038h,01ah,019h,01ah,019h,016h,019h,018h,000h,000h,00bh,01ah,012h,01ch,019h	; 7cae  .8..............
	defb 00eh,013h,01eh,00fh,054h,055h,026h,0feh,035h,038h,056h,057h,026h,0feh,055h,038h	; 7cbe  ....TU&.58VW&.U8
	defb 058h,059h,026h,0feh,02ah,038h,020h,013h,01eh,0feh,04ah,038h,00fh,022h,01ah,025h	; 7cce  XY&.*8 ...J8.".%
	defb 038h,030h,0feh,01bh,038h,042h,040h,040h,048h,0feh,03bh,038h,041h,000h,000h,041h	; 7cde  80..8B@@H..8A..A
	defb 0feh,05bh,038h,043h,040h,040h,049h,0ffh	; 7cee  .[8C@@I.

; ----------------------------------------------------------------------
; DATOS aphrodite_out: la lista de la VRAM (0x5C25) APHRODITE OUT, que
;   p00:453C pinta cuando muere Afrodita (0xE501 = 0); con POPOLON va 0x7D06
;   0x7cf6..0x7d06  (16 bytes)
DATA_aphrodite_out:
	defb 00ah,039h,00bh,01ah,012h,01ch,019h,00eh,013h,01eh,00fh,000h,019h,01fh,01eh,0ffh	; 7cf6  .9..............

; ----------------------------------------------------------------------
; DATOS lista_vram_7D06: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:4544 (14 bytes)
;   0x7d06..0x7d14  (14 bytes)
DATA_lista_vram_7D06:
	defb 00bh,039h,01ah,019h,01ah,019h,016h,019h,018h,000h,019h,01fh,01eh,0ffh	; 7d06  .9............

; ----------------------------------------------------------------------
; DATOS lista_vram_7D14: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:45B2 (9 bytes)
;   0x7d14..0x7d1d  (9 bytes)
DATA_lista_vram_7D14:
	defb 0adh,039h,021h,019h,01ch,016h,00eh,000h,0ffh	; 7d14  .9!......

; ----------------------------------------------------------------------
; DATOS lista_vram_7D1D: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:472D (11 bytes)
;   0x7d1d..0x7d28  (11 bytes)
DATA_lista_vram_7D1D:
	defb 0adh,039h,00dh,00bh,01dh,01eh,016h,00fh,000h,028h,0ffh	; 7d1d  .9.......(.

; ----------------------------------------------------------------------
; DATOS lista_vram_7D28: la misma lista, que 0x5C3C recorre poniendo ceros
;   (borra); lo leen p00:45AC, p00:4716 (11 bytes)
;   0x7d28..0x7d33  (11 bytes)
DATA_lista_vram_7D28:
	defb 063h,038h,00dh,00bh,01dh,01eh,016h,00fh,000h,000h,0ffh	; 7d28  c8.........

; ----------------------------------------------------------------------
; DATOS lista_vram_7D33: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:51B2 (9 bytes)
;   0x7d33..0x7d3c  (9 bytes)
DATA_lista_vram_7D33:
	defb 063h,038h,021h,019h,01ch,016h,00eh,000h,0ffh	; 7d33  c8!......

; ----------------------------------------------------------------------
; DATOS lista_7d3c: una lista de la VRAM ([0x394C] y 5 caracteres de la fuente
;   grande, 0xFF) detras de la de 0x7D33; ninguna instruccion la nombra
;   0x7d3c..0x7d44  (8 bytes)
DATA_lista_7d3c:
	defb 04ch,039h,033h,034h,021h,027h,025h,0ffh	; 7d3c  L934!'%.

; ----------------------------------------------------------------------
; DATOS lista_vram_7D44: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:4589 (13 bytes)
;   0x7d44..0x7d51  (13 bytes)
DATA_lista_vram_7D44:
	defb 04bh,039h,011h,00bh,017h,00fh,000h,000h,019h,020h,00fh,01ch,0ffh	; 7d44  K9....... ...

; ----------------------------------------------------------------------
; DATOS lista_vram_7D51: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p01:6232 (32 bytes)
;   0x7d51..0x7d71  (32 bytes)
DATA_lista_vram_7D51:
	defb 0eah,039h,01ah,02bh,02fh,02eh,021h,02dh,029h,000h,011h,019h,018h,017h,0feh,029h	; 7d51  .9.+/.!-)......)
	defb 03ah,030h,035h,033h,028h,000h,033h,030h,021h,023h,025h,000h,02bh,025h,039h,0ffh	; 7d61  :053(.30!#%.+%9.

; ----------------------------------------------------------------------
; DATOS lista_vram_7D71: [destino] y bytes a la VRAM; 0xFE otro destino, 0xFF
;   acaba (0x5C25); lo leen p00:43FE, p00:4401 (17 bytes)
;   0x7d71..0x7d82  (17 bytes)
DATA_lista_vram_7D71:
	defb 029h,03ah,000h,000h,030h,02ch,021h,039h,000h,033h,034h,021h,032h,034h,000h,000h	; 7d71  ):..0,!9.34!24..
	defb 0ffh	; 7d81

; ======================================================================
; CODIGO 0x7d82..0x7dd9  (87 bytes)
; ======================================================================


L_7D82:
	ld hl,(0e022h)		;7d82
	exx			;7d85
	call 04cb0h		;7d86
	exx			;7d89
	ld (0e022h),hl		;7d8a
	ld a,(0e023h)		;7d8d
	ld hl,07dd9h		;7d90
	call 0414ch		;7d93
	ld (0e041h),de		;7d96
	xor a			;7d9a
	ld (0e604h),a		;7d9b
	call 0510bh		;7d9e
	ld a,001h		;7da1
	ld (0e070h),a		;7da3
	ld (0e510h),a		;7da6
	ld hl,00100h		;7da9
	ld (0e046h),hl		;7dac
	call L_604D		;7daf
	ld a,(0e023h)		;7db2
	ld hl,07de3h		;7db5
	call 04155h		;7db8
	ld (0e033h),a		;7dbb
	ld a,(0e00dh)		;7dbe
	or a			;7dc1
	jr nz,L_7DCA		;7dc2
	call 05d1ah		;7dc4
	call 05cafh		;7dc7
L_7DCA:
	xor a			;7dca
	ld (0e01ah),a		;7dcb
	ld (0e00bh),a		;7dce
	inc a			;7dd1
	ld (0e019h),a		;7dd2
	ld (0e00ch),a		;7dd5
	ret			;7dd8

; ----------------------------------------------------------------------
; DATOS salas_de_las_demos: 5 parejas [mapa][sala] donde empieza una demo
;   (p01:7D90, 0x414C con 0xE023): castillo 146, 1, 37 y 111 y mundo 1 sala 1;
;   0xE023 solo vale 0 o 1 (p00:43CB), asi que solo se usan las dos primeras
;   0x7dd9..0x7de3  (10 bytes)
DATA_salas_de_las_demos:
	defb 001h,092h	; 7dd9
	defb 001h,001h	; 7ddb
	defb 001h,025h	; 7ddd
	defb 001h,06fh	; 7ddf
	defb 002h,001h	; 7de1

; ----------------------------------------------------------------------
; DATOS cinco_bytes_7de3: 5 bytes, uno por demo, que p01:7DB5 pone en 0xE033
;   (solo se usan los dos primeros)
;   0x7de3..0x7de8  (5 bytes)
DATA_cinco_bytes_7de3:
	defb 01ch,020h,00eh,008h,010h	; 7de3

; ======================================================================
; CODIGO 0x7de8..0x7e88  (160 bytes)
; ======================================================================


L_7DE8:
	call 05488h		;7de8
	call 052f5h		;7deb
	ld a,(0e604h)		;7dee
	and 01fh		;7df1
	jr nz,L_7E04		;7df3
	ld hl,0e033h		;7df5
	ld a,(hl)			;7df8
	or a			;7df9
	jr z,L_7E04		;7dfa
	dec (hl)			;7dfc
	jr nz,L_7E04		;7dfd
	ld a,0ffh		;7dff
	call 04e1fh		;7e01
L_7E04:
	ld a,(0e01ah)		;7e04
	and a			;7e07
	ret z			;7e08
	call 04d38h		;7e09
	call 04d47h		;7e0c
	ld a,020h		;7e0f
	ld (0e004h),a		;7e11
	call 04792h		;7e14
	ld (0e042h),a		;7e17
	call 051cdh		;7e1a
	xor a			;7e1d
	ld (0e01ah),a		;7e1e
	ret			;7e21
L_7E22:
	ld hl,0e00ch		;7e22
	dec (hl)			;7e25
	jr z,L_7E35		;7e26
L_7E28:
	ld a,(0e022h)		;7e28
	cp 0ffh		;7e2b
	jp nz,04c6bh		;7e2d
	xor a			;7e30
	ld (0e019h),a		;7e31
	ret			;7e34
L_7E35:
	dec hl			;7e35
	ld c,(hl)			;7e36
	inc (hl)			;7e37
	call 04241h		;7e38
	ld hl,0bafdh		;7e3b
	ld a,(0e023h)		;7e3e
	call 0414ch		;7e41
	ld l,c			;7e44
	ld h,000h		;7e45
	add hl,hl			;7e47
	add hl,de			;7e48
	ld a,(hl)			;7e49
	ld (0e00ch),a		;7e4a
	inc hl			;7e4d
	ld a,(hl)			;7e4e
	ld (0e022h),a		;7e4f
	call 04215h		;7e52
	jr L_7E28		;7e55
L_7E57:
	ld hl,(0e041h)		;7e57
	ld de,00101h		;7e5a
	rst 20h			;7e5d
	ret nz			;7e5e
	call 09c13h		;7e5f
	ld hl,0e02ah		;7e62
	ld c,(hl)			;7e65
	ld (hl),a			;7e66
	xor c			;7e67
	and (hl)			;7e68
	ret z			;7e69
	ld b,a			;7e6a
	ld de,07e88h		;7e6b
	ld hl,0e028h		;7e6e
	ld a,(hl)			;7e71
	call 0413bh		;7e72
	ld a,(de)			;7e75
	cp b			;7e76
	jr z,L_7E7C		;7e77
	ld (hl),000h		;7e79
	ret			;7e7b
L_7E7C:
	inc (hl)			;7e7c
	ld a,(hl)			;7e7d
	cp 004h		;7e7e
	ret c			;7e80
	xor a			;7e81
	ld (hl),a			;7e82
	inc a			;7e83
	ld (0e027h),a		;7e84
	ret			;7e87

; ----------------------------------------------------------------------
; DATOS zeus: Z E U S en ASCII: p01:7E6B compara cada letra pulsada con la de
;   0x7E88 + (0xE028) y cuenta los aciertos (una palabra secreta)
;   0x7e88..0x7e8c  (4 bytes)
DATA_zeus:
	defb 05ah,045h,055h,053h	; 7e88

; ======================================================================
; CODIGO 0x7e8c..0x7ecf  (67 bytes)
; ======================================================================


L_7E8C:
	ld a,(0e026h)		;7e8c
	and a			;7e8f
	ret nz			;7e90
	ld a,(0e027h)		;7e91
	and a			;7e94
	ret z			;7e95
	call L_7EF1		;7e96
	ret nc			;7e99
	ld de,07ecfh		;7e9a
	call 05c3ch		;7e9d
	xor a			;7ea0
	ld h,a			;7ea1
	ld l,a			;7ea2
	ld (0e050h),a		;7ea3
	ld (0e05eh),a		;7ea6
	ld (0e054h),a		;7ea9
	ld (0e061h),a		;7eac
	ld (0e05ch),hl		;7eaf
	ld (0e05fh),hl		;7eb2
	ld (0e059h),a		;7eb5
	inc a			;7eb8
	ld (0e058h),a		;7eb9
	ld (0e501h),a		;7ebc
	ld (0e026h),a		;7ebf
	ld a,(0e053h)		;7ec2
	ld (0e052h),a		;7ec5
	ld a,(0e057h)		;7ec8
	ld (0e056h),a		;7ecb
	ret			;7ece

; ----------------------------------------------------------------------
; DATOS lista_vram_7ECF: la misma lista, que 0x5C3C recorre poniendo ceros
;   (borra); lo leen p00:4593, p01:7E9D (14 bytes)
;   0x7ecf..0x7edd  (14 bytes)
DATA_lista_vram_7ECF:
	defb 0abh,039h,010h,006h,000h,00dh,019h,018h,01eh,013h,018h,01fh,00fh,0ffh	; 7ecf  .9............

; ======================================================================
; CODIGO 0x7edd..0x7f40  (99 bytes)
; ======================================================================


L_7EDD:
	call L_7EF1		;7edd
	jr c,L_7EE7		;7ee0
	xor a			;7ee2
	ld (0e032h),a		;7ee3
	ret			;7ee6
L_7EE7:
	ld hl,0e032h		;7ee7
	ld a,(hl)			;7eea
	or a			;7eeb
	ret nz			;7eec
	ld (hl),001h		;7eed
	scf			;7eef
	ret			;7ef0
L_7EF1:
	ld a,007h		;7ef1
	call 00141h		;7ef3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;7ef6
	and 002h		;7ef7
	ret z			;7ef9
	scf			;7efa
	ret			;7efb
L_7EFC:
	ld hl,0e0d2h		;7efc
	ld a,(hl)			;7eff
	or a			;7f00
	ret z			;7f01
	dec a			;7f02
	jp z,L_7FD0		;7f03
	sub 002h		;7f06
	jp m,L_7FDB		;7f08
	jr z,$+75		;7f0b
	ld ix,0e700h		;7f0d
	call 04220h		;7f11
	call 0b3e7h		;7f14
	call 0b3f7h		;7f17
	call 04215h		;7f1a
	ld a,(0e0d5h)		;7f1d
	or a			;7f20
	ret nz			;7f21
	call L_7F38		;7f22
	ld a,(0e700h)		;7f25
	or a			;7f28
	ret z			;7f29
	bit 4,(ix+002h)		;7f2a
	ret z			;7f2e
	call 04220h		;7f2f
	call 0b0edh		;7f32
	jp 04215h		;7f35
L_7F38:
	ld a,(0e700h)		;7f38
	dec a			;7f3b
	ret m			;7f3c
	call 04140h		;7f3d

; ----------------------------------------------------------------------
; DATOS tabla_7F40: 11 destinos del despachador de 0x4140 (call en p01:7F3D):
;   0x802E, 0x8170, 0x83A7, 0x847B, 0x8002, 0x89A0, 0x864E, 0x8AA4 ...; lo
;   leen p01:7F3D (22 bytes)
;   0x7f40..0x7f56  (22 bytes)
DATA_tabla_7F40:
	defb 02eh,080h	; 7f40
	defb 070h,081h	; 7f42
	defb 0a7h,083h	; 7f44
	defb 07bh,084h	; 7f46
	defb 002h,080h	; 7f48
	defb 0a0h,089h	; 7f4a
	defb 04eh,086h	; 7f4c
	defb 0a4h,08ah	; 7f4e
	defb 02dh,08dh	; 7f50
	defb 035h,085h	; 7f52
	defb 015h,088h	; 7f54

; ======================================================================
; CODIGO 0x7f56..0x7f82  (44 bytes)
; ======================================================================


L_7F56:
	inc (hl)			;7f56
	inc l			;7f57
	ld a,(hl)			;7f58
	ld (0e700h),a		;7f59
	ld hl,07f97h		;7f5c
	call 04155h		;7f5f
	ld b,a			;7f62
	ld a,(0e076h)		;7f63
	or a			;7f66
	ld a,b			;7f67
	jr z,L_7F6C		;7f68
	srl a		;7f6a
L_7F6C:
	ld (0e710h),a		;7f6c
	ld ix,0e700h		;7f6f
	ld (ix+001h),000h		;7f73
	ld (ix+002h),0f0h		;7f77
	ld a,(0e700h)		;7f7b
	dec a			;7f7e
	call 04140h		;7f7f

; ----------------------------------------------------------------------
; DATOS tabla_7F82: 11 destinos del despachador de 0x4140 (call en p01:7F7F):
;   0x8013, 0x8279, 0x8384, 0x846E, 0x8002, 0x895C, 0x8627, 0x8A7A ...; lo
;   leen p01:7F7F (22 bytes)
;   0x7f82..0x7f98  (22 bytes)
DATA_tabla_7F82:
	defb 013h,080h	; 7f82
	defb 079h,082h	; 7f84
	defb 084h,083h	; 7f86
	defb 06eh,084h	; 7f88
	defb 002h,080h	; 7f8a
	defb 05ch,089h	; 7f8c
	defb 027h,086h	; 7f8e
	defb 07ah,08ah	; 7f90
	defb 0ddh,08ch	; 7f92
	defb 0f0h,084h	; 7f94
	defb 0e6h,087h	; 7f96

; ----------------------------------------------------------------------
; DATOS once_bytes_7f98: 11 bytes que p01:7F5C lee en 0x7F97 + (0xE700)
;   (0x4155), detras de la tabla de despacho de 0x7F82
;   0x7f98..0x7fa3  (11 bytes)
DATA_once_bytes_7f98:
	defb 018h,040h,038h,028h,000h,050h,040h,050h,0f8h,048h,070h	; 7f98  .@8(.P@P.Hp

; ======================================================================
; CODIGO 0x7fa3..0x7ffe  (91 bytes)
; ======================================================================


L_7FA3:
	call 04220h		;7fa3
	call 0b13eh		;7fa6
	jp 04215h		;7fa9
L_7FAC:
	call 04220h		;7fac
	call 0b15fh		;7faf
	jp 04215h		;7fb2
L_7FB5:
	call 04220h		;7fb5
	call 0b137h		;7fb8
	jp 04215h		;7fbb
L_7FBE:
	call 04220h		;7fbe
	call 0b145h		;7fc1
	jp 04215h		;7fc4
L_7FC7:
	call 04220h		;7fc7
	call 0b14ch		;7fca
	jp 04215h		;7fcd
L_7FD0:
	inc (hl)			;7fd0
	ld a,041h		;7fd1
	ld (0e640h),a		;7fd3
	ld a,090h		;7fd6
	jp 05cc4h		;7fd8
L_7FDB:
	ld hl,0e640h		;7fdb
	ld a,(hl)			;7fde
	or a			;7fdf
	jr z,L_7FF9		;7fe0
	dec (hl)			;7fe2
	ld a,(hl)			;7fe3
	and 007h		;7fe4
	ret nz			;7fe6
	ld hl,0e643h		;7fe7
	inc (hl)			;7fea
	ld a,(hl)			;7feb
	and 007h		;7fec
	ld hl,08003h		;7fee
	call 0414ch		;7ff1
	ld a,063h		;7ff4
	jp 0424ch		;7ff6
L_7FF9:
	ld a,(0e620h)		;7ff9
	or a			;7ffc
	ret nz			;7ffd

; ----------------------------------------------------------------------
; DATOS partida_7FFE: la instruccion de p01:7FFE (21 D2 | E0) empieza al final
;   del banco 1 y acaba al principio del 2, que el cartucho pone siempre a
;   continuacion: aqui los 2 primeros bytes; lo leen p01:7FFE (2 bytes)
;   0x7ffe..0x8000  (2 bytes)
DATA_partida_7FFE:
	defb 021h,0d2h	; 7ffe
