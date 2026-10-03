; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l4bcdh:	equ 0x04bcd
l5dfbh:	equ 0x05dfb

; ----------------------------------------------------------------------
; DATOS cabecera_ab: la cabecera del cartucho: 'AB', INIT (0x4095) y
;   STATEMENT, DEVICE y TEXT a cero; lo leen la BIOS (16 bytes)
;   0x4000..0x4010  (16 bytes)
DATA_cabecera_ab:
	defb 041h,042h,095h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ----------------------------------------------------------------------
; DATOS cabecera_de_konami: la cabecera de Konami que lee el Game Master desde
;   la otra ranura: 'CD', 0x07 0x49 (RC-749) y, detras, direcciones de la RAM
;   del juego (0xE0FE, 0xE104, 0xE1C6...); el propio cartucho no la lee; lo
;   leen el Game Master (64 bytes)
;   0x4010..0x4050  (64 bytes)
DATA_cabecera_de_konami:
	defb 043h,044h,007h,049h,0feh,000h,0e0h,004h	; 4010  CD.I....
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 4018  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 4020  ........
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 4028  ........
	defb 0c6h,0e1h,0c7h,0e1h,0c7h,0e1h,0c7h,0e1h	; 4030  ........
	defb 00ch,0e1h,00dh,0e1h,027h,0e1h,028h,0e1h	; 4038  ....'.(.
	defb 042h,0e1h,043h,0e1h,0cah,0e1h,0c9h,0e1h	; 4040  B.C.....
	defb 0c8h,0e1h,0b0h,0e1h,069h,0e1h,06ah,0e1h	; 4048  ....i.j.

; ======================================================================
; CODIGO 0x4050..0x428e  (574 bytes)
; ======================================================================


L_4050:
	jp L_4140		;4050
L_4053:
	jp L_414C		;4053
L_4056:
	jp L_4DA1		;4056
L_4059:
	jp L_4E1F		;4059
L_405C:
	jp L_4164		;405c
L_405F:
	jp L_4DB5		;405f
L_4062:
	jp L_4136		;4062
L_4065:
	jp L_413B		;4065
L_4068:
	jp L_415C		;4068
L_406B:
	jp L_4DCF		;406b
L_406E:
	jp L_4DC8		;406e
L_4071:
	jp L_4DC5		;4071
L_4074:
	jp L_54FF		;4074
L_4077:
	jp L_551F		;4077
L_407A:
	jp L_553E		;407a
L_407D:
	jp L_424C		;407d
L_4080:
	jp L_5CC4		;4080
L_4083:
	jp L_4155		;4083
L_4086:
	jp L_5D12		;4086
L_4089:
	jp L_4DDB		;4089
L_408C:
	jp L_5F8F		;408c
L_408F:
	jp 06d49h		;408f
L_4092:
	jp L_4269		;4092
L_4095:
	di			;4095
	im 1		;4096
	call L_40D3		;4098
	ld h,080h		;409b
	call 00024h		;409d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,0c3h		;40a0
	ld (0fd9ah),a		;40a2
	ld hl,L_40EF		;40a5
	ld (0fd9bh),hl		;40a8
	ld sp,0f0f0h		;40ab
	ld hl,0e000h		;40ae
	ld de,0e001h		;40b1
	ld bc,010efh		;40b4
	ld (hl),000h		;40b7
	ldir		;40b9
	ld a,001h		;40bb
	ld (0e005h),a		;40bd
	call L_4C3D		;40c0
	call L_5ED0		;40c3
	call L_416C		;40c6
	xor a			;40c9
	ld (0e005h),a		;40ca
	call 0013eh		;40cd   ; BIOS RDVDP - Reads VDP status register
	ei			;40d0
L_40D1:
	jr L_40D1		;40d1
L_40D3:
	call 00138h		;40d3   ; BIOS RSLREG - Reads the primary slot register
	rrca			;40d6
	rrca			;40d7
	and 003h		;40d8
	ld c,a			;40da
	ld b,000h		;40db
	ld hl,0fcc1h		;40dd
	add hl,bc			;40e0
	ld a,(hl)			;40e1
	and 080h		;40e2
	or c			;40e4
	ld c,a			;40e5
	inc hl			;40e6
	inc hl			;40e7
	inc hl			;40e8
	inc hl			;40e9
	ld a,(hl)			;40ea
	and 00ch		;40eb
	or c			;40ed
	ret			;40ee
L_40EF:
	call 0013eh		;40ef   ; BIOS RDVDP - Reads VDP status register
	di			;40f2
	ld hl,0e006h		;40f3
	ld a,(hl)			;40f6
	and a			;40f7
	ld (hl),001h		;40f8
	jp nz,L_4131		;40fa
	call L_5435		;40fd
	di			;4100
	ld a,00dh		;4101
	ld (06000h),a		;4103
	inc a			;4106
	ld (08000h),a		;4107
	call 06004h		;410a
	xor a			;410d
	ld (0e006h),a		;410e
	di			;4111
	ld a,(0f0f1h)		;4112
	ld (06000h),a		;4115
	ld a,(0f0f2h)		;4118
	ld (08000h),a		;411b
	call L_5C9E		;411e
	ld hl,0e005h		;4121
	ld a,(hl)			;4124
	or a			;4125
	jr nz,L_4131		;4126
	inc (hl)			;4128
	ei			;4129
	call L_4277		;412a
	xor a			;412d
	ld (0e005h),a		;412e
L_4131:
	call 0013eh		;4131   ; BIOS RDVDP - Reads VDP status register
	ei			;4134
	ret			;4135
L_4136:
	add a,l			;4136
	ld l,a			;4137
	ret nc			;4138
	inc h			;4139
	ret			;413a
L_413B:
	add a,e			;413b
	ld e,a			;413c
	ret nc			;413d
	inc d			;413e
	ret			;413f
L_4140:
	pop hl			;4140
	add a,a			;4141
	add a,l			;4142
	ld l,a			;4143
	jr nc,L_4147		;4144
	inc h			;4146
L_4147:
	ld a,(hl)			;4147
	inc hl			;4148
	ld h,(hl)			;4149
	ld l,a			;414a
	jp (hl)			;414b
L_414C:
	add a,a			;414c
	ld e,a			;414d
	ld d,000h		;414e
	add hl,de			;4150
	ld e,(hl)			;4151
	inc hl			;4152
	ld d,(hl)			;4153
	ret			;4154
L_4155:
	add a,l			;4155
	ld l,a			;4156
	jr nc,L_415A		;4157
	inc h			;4159
L_415A:
	ld a,(hl)			;415a
	ret			;415b
L_415C:
	ld a,e			;415c
	cpl			;415d
	ld e,a			;415e
	ld a,d			;415f
	cpl			;4160
	ld d,a			;4161
	inc de			;4162
	ret			;4163
L_4164:
	ld a,l			;4164
	cpl			;4165
	ld l,a			;4166
	ld a,h			;4167
	cpl			;4168
	ld h,a			;4169
	inc hl			;416a
	ret			;416b
L_416C:
	di			;416c
	ld a,001h		;416d
	ld (06000h),a		;416f
	ld (0f0f1h),a		;4172
	inc a			;4175
	ld (08000h),a		;4176
	ld (0f0f2h),a		;4179
	inc a			;417c
	ld (0a000h),a		;417d
	ld (0f0f3h),a		;4180
	ei			;4183
	ret			;4184
L_4185:
	di			;4185
	ld a,004h		;4186
	ld (06000h),a		;4188
	ld (0f0f1h),a		;418b
	inc a			;418e
	ld (08000h),a		;418f
	ld (0f0f2h),a		;4192
	inc a			;4195
	ld (0a000h),a		;4196
	ld (0f0f3h),a		;4199
	ei			;419c
	ret			;419d
L_419E:
	di			;419e
	ld a,007h		;419f
	ld (06000h),a		;41a1
	ld (0f0f1h),a		;41a4
	inc a			;41a7
	ld (08000h),a		;41a8
	ld (0f0f2h),a		;41ab
	inc a			;41ae
	ld (0a000h),a		;41af
	ld (0f0f3h),a		;41b2
	ei			;41b5
	ret			;41b6
L_41B7:
	di			;41b7
	ld a,00ah		;41b8
	ld (06000h),a		;41ba
	ld (0f0f1h),a		;41bd
	inc a			;41c0
	ld (08000h),a		;41c1
	ld (0f0f2h),a		;41c4
	inc a			;41c7
	ld (0a000h),a		;41c8
	ld (0f0f3h),a		;41cb
	ei			;41ce
	ret			;41cf
L_41D0:
	di			;41d0
	ld a,00dh		;41d1
	ld (06000h),a		;41d3
	ld (0f0f1h),a		;41d6
	inc a			;41d9
	ld (08000h),a		;41da
	ld (0f0f2h),a		;41dd
	inc a			;41e0
	ld (0a000h),a		;41e1
	ld (0f0f3h),a		;41e4
	ei			;41e7
	ret			;41e8
L_41E9:
	di			;41e9
	ld a,001h		;41ea
	ld (06000h),a		;41ec
	ld (0f0f1h),a		;41ef
	ei			;41f2
	ret			;41f3
L_41F4:
	di			;41f4
	ld a,004h		;41f5
	ld (06000h),a		;41f7
	ld (0f0f1h),a		;41fa
	ei			;41fd
	ret			;41fe
L_41FF:
	di			;41ff
	ld a,002h		;4200
	ld (08000h),a		;4202
	ld (0f0f2h),a		;4205
	ei			;4208
	ret			;4209
L_420A:
	di			;420a
	ld a,00eh		;420b
	ld (08000h),a		;420d
	ld (0f0f2h),a		;4210
	ei			;4213
	ret			;4214
L_4215:
	di			;4215
	ld a,003h		;4216
	ld (0a000h),a		;4218
	ld (0f0f3h),a		;421b
	ei			;421e
	ret			;421f
L_4220:
	di			;4220
	ld a,006h		;4221
	ld (0a000h),a		;4223
	ld (0f0f3h),a		;4226
	ei			;4229
	ret			;422a
L_422B:
	di			;422b
	ld a,009h		;422c
	ld (0a000h),a		;422e
	ld (0f0f3h),a		;4231
	ei			;4234
	ret			;4235
L_4236:
	di			;4236
	ld a,00ch		;4237
	ld (0a000h),a		;4239
	ld (0f0f3h),a		;423c
	ei			;423f
	ret			;4240
L_4241:
	di			;4241
	ld a,00fh		;4242
	ld (0a000h),a		;4244
	ld (0f0f3h),a		;4247
	ei			;424a
	ret			;424b
L_424C:
	push af			;424c
	call L_4185		;424d
	pop af			;4250
	call 06551h		;4251
	jp L_416C		;4254
L_4257:
	call L_4185		;4257
	call 0b41ch		;425a
	jp L_416C		;425d
L_4260:
	call L_419E		;4260
	call 09d5fh		;4263
	jp L_416C		;4266
L_4269:
	call L_416C		;4269
	call 0b389h		;426c
	ld b,002h		;426f
	call 0b3ceh		;4271
	jp L_4185		;4274
L_4277:
	ld hl,0e003h		;4277
	inc (hl)			;427a
	ld a,(0e000h)		;427b
	cp 003h		;427e
	jr nc,L_4286		;4280
	ld hl,04bfah		;4282
	push hl			;4285
L_4286:
	ld bc,(0e000h)		;4286
	ld a,c			;428a
	call L_4140		;428b

; ----------------------------------------------------------------------
; DATOS tabla_428E: 21 destinos del despachador de 0x4140 (call en p00:428B):
;   0x42B8, 0x430C, 0x433C, 0x43F0, 0x4420, 0x4462, 0x44F2, 0x454F ...; lo
;   leen p00:428B (42 bytes)
;   0x428e..0x42b8  (42 bytes)
DATA_tabla_428E:
	defb 0b8h,042h	; 428e
	defb 00ch,043h	; 4290
	defb 03ch,043h	; 4292
	defb 0f0h,043h	; 4294
	defb 020h,044h	; 4296
	defb 062h,044h	; 4298
	defb 0f2h,044h	; 429a
	defb 04fh,045h	; 429c
	defb 099h,045h	; 429e
	defb 03ah,047h	; 42a0
	defb 069h,047h	; 42a2
	defb 0cfh,047h	; 42a4
	defb 04fh,048h	; 42a6
	defb 0adh,046h	; 42a8
	defb 08eh,048h	; 42aa
	defb 059h,049h	; 42ac
	defb 0c5h,048h	; 42ae
	defb 0bah,049h	; 42b0
	defb 069h,04ah	; 42b2
	defb 05bh,04bh	; 42b4
	defb 0d8h,04bh	; 42b6

; ======================================================================
; CODIGO 0x42b8..0x4340  (136 bytes)
; ======================================================================


L_42B8:
	djnz L_42C7		;42b8
	ld a,(0e003h)		;42ba
	rra			;42bd
	ret nc			;42be
	call 06985h		;42bf
	ret nz			;42c2
	xor a			;42c3
	jp L_435B		;42c4
L_42C7:
	djnz L_42D5		;42c7
	ld hl,0e004h		;42c9
	dec (hl)			;42cc
	ret nz			;42cd
	call L_42F1		;42ce
	xor a			;42d1
	jp L_443B		;42d2
L_42D5:
	call L_4C4A		;42d5
	call L_5BB5		;42d8
	call L_5E34		;42db
	call L_422B		;42de
	call 06957h		;42e1
	call L_4215		;42e4
	xor a			;42e7
	call L_4E1F		;42e8
	call L_5CC9		;42eb
	jp L_435E		;42ee
L_42F1:
	call L_54E6		;42f1
	call L_4D38		;42f4
	call L_5E34		;42f7
	call L_420A		;42fa
	call L_4241		;42fd
	call L_5772		;4300
	call 06215h		;4303
	call L_41FF		;4306
	jp L_4215		;4309
L_430C:
	push bc			;430c
	call 098e5h		;430d
	pop bc			;4310
	jr nc,L_4330		;4311
	call L_420A		;4313
	call L_4241		;4316
	call 06251h		;4319
	call L_41FF		;431c
	call L_4215		;431f
	ld a,(0e019h)		;4322
	or a			;4325
	ret nz			;4326
	call L_4D38		;4327
	call L_54E6		;432a
	jp L_4439		;432d
L_4330:
	ld a,012h		;4330
	jp L_43A9		;4332
L_4335:
	ld hl,00001h		;4335
	ld (0e698h),hl		;4338
	ret			;433b
L_433C:
	ld a,b			;433c
	call L_4140		;433d

; ----------------------------------------------------------------------
; DATOS tabla_4340: 4 destinos del despachador de 0x4140 (call en p00:433D):
;   0x4348, 0x437B, 0x43B4, 0x43C5; lo leen p00:433D (8 bytes)
;   0x4340..0x4348  (8 bytes)
DATA_tabla_4340:
	defb 048h,043h	; 4340
	defb 07bh,043h	; 4342
	defb 0b4h,043h	; 4344
	defb 0c5h,043h	; 4346

; ======================================================================
; CODIGO 0x4348..0x468d  (837 bytes)
; ======================================================================


L_4348:
	call L_4D1E		;4348
	ret p			;434b
	call L_5280		;434c
	ld a,(0e025h)		;434f
	bit 0,a		;4352
	jr nz,L_4363		;4354
	call 07d82h		;4356
L_4359:
	ld a,020h		;4359
L_435B:
	ld (0e004h),a		;435b
L_435E:
	ld hl,0e001h		;435e
	inc (hl)			;4361
	ret			;4362
L_4363:
	call L_568E		;4363
	call 06a1eh		;4366
	call 06ac5h		;4369
	ld a,001h		;436c
	ld (0e02eh),a		;436e
	ld a,086h		;4371
	call L_4E34		;4373
	ld a,002h		;4376
	jp L_4443		;4378
L_437B:
	call 07e22h		;437b
	call 07de8h		;437e
	call 07eddh		;4381
	call c,L_43D8		;4384
	ld a,(0e019h)		;4387
	or a			;438a
	ret nz			;438b
	xor a			;438c
	ld (0e070h),a		;438d
	ld (0e510h),a		;4390
	ld hl,00000h		;4393
	ld (0e046h),hl		;4396
	call L_43CB		;4399
L_439C:
	ld hl,0e025h		;439c
	inc (hl)			;439f
L_43A0:
	ld a,0ffh		;43a0
L_43A2:
	ld (0e000h),a		;43a2
	xor a			;43a5
	jp L_443B		;43a6
L_43A9:
	ld (0e000h),a		;43a9
	ld a,020h		;43ac
	ld (0e004h),a		;43ae
	jp L_4442		;43b1
L_43B4:
	call L_4241		;43b4
	call 06adch		;43b7
	call L_4215		;43ba
	ld a,(0e02eh)		;43bd
	or a			;43c0
	ret nz			;43c1
	jp L_435E		;43c2
L_43C5:
	call L_50F5		;43c5
	ret z			;43c8
	jr L_439C		;43c9
L_43CB:
	ld a,(0e023h)		;43cb
	inc a			;43ce
	cp 002h		;43cf
	jr c,L_43D4		;43d1
	xor a			;43d3
L_43D4:
	ld (0e023h),a		;43d4
	ret			;43d7
L_43D8:
	ld hl,0e00dh		;43d8
	ld a,(hl)			;43db
	xor 001h		;43dc
	ld (hl),a			;43de
	jr nz,L_43EC		;43df
	ld a,(0e033h)		;43e1
	or a			;43e4
	ret z			;43e5
	call L_5D1A		;43e6
	jp L_5CAF		;43e9
L_43EC:
	xor a			;43ec
	jp L_4E1F		;43ed
L_43F0:
	djnz L_4404		;43f0
	ld hl,0e004h		;43f2
	dec (hl)			;43f5
	jp z,L_435E		;43f6
	bit 2,(hl)		;43f9
	ld de,07d71h		;43fb
	jp z,L_5C25		;43fe
	jp L_5C3C		;4401
L_4404:
	djnz L_4416		;4404
	call L_54E6		;4406
	call L_4D38		;4409
	call L_4CB0		;440c
	ld a,001h		;440f
	ld (0e007h),a		;4411
	jr L_4439		;4414
L_4416:
	ld a,087h		;4416
	call L_5CAF		;4418
	ld a,02dh		;441b
	jp L_435B		;441d
L_4420:
	djnz L_4447		;4420
	call 0604dh		;4422
	call L_510B		;4425
	xor a			;4428
	ld (0e01ah),a		;4429
	inc a			;442c
	ld (0e019h),a		;442d
	ld a,(0e690h)		;4430
	or a			;4433
	ld a,00eh		;4434
	jp nz,L_43A9		;4436
L_4439:
	ld a,020h		;4439
L_443B:
	ld (0e004h),a		;443b
	ld hl,0e000h		;443e
	inc (hl)			;4441
L_4442:
	xor a			;4442
L_4443:
	ld (0e001h),a		;4443
	ret			;4446
L_4447:
	call L_4D1E		;4447
	ret p			;444a
	ld hl,0e007h		;444b
	ld a,(hl)			;444e
	or a			;444f
	ld (hl),001h		;4450
	jr nz,L_445F		;4452
	call L_4579		;4454
	jr nz,L_445F		;4457
	call L_5D1A		;4459
	call L_5CAF		;445c
L_445F:
	jp L_435E		;445f
L_4462:
	call L_52F5		;4462
	ld a,(0e019h)		;4465
	or a			;4468
	jr z,L_4439		;4469
	ld a,(0e020h)		;446b
	or a			;446e
	ld a,00fh		;446f
	jr nz,L_44D2		;4471
	ld a,(0e01fh)		;4473
	ld b,a			;4476
	dec b			;4477
	ld a,008h		;4478
	jr z,L_44D2		;447a
	dec b			;447c
	ld a,00dh		;447d
	jr z,L_44D2		;447f
	ld a,(0e01ch)		;4481
	or a			;4484
	ld a,010h		;4485
	jr nz,L_44D2		;4487
	ld a,(0e031h)		;4489
	or a			;448c
	ld a,014h		;448d
	jr nz,L_44D2		;448f
	ld a,(0e01ah)		;4491
	or a			;4494
	ld a,00ah		;4495
	jr nz,L_44D2		;4497
	ld a,(0e01bh)		;4499
	or a			;449c
	ld a,00ch		;449d
	jr nz,L_44D2		;449f
	ld a,(0e024h)		;44a1
	or a			;44a4
	ld a,011h		;44a5
	jr nz,L_44D2		;44a7
	ld a,(0e02ch)		;44a9
	or a			;44ac
	ld a,013h		;44ad
	jr nz,L_44D2		;44af
	call 09e07h		;44b1
	jr nc,L_44D5		;44b4
	ld a,(0e500h)		;44b6
	cp 005h		;44b9
	ret z			;44bb
	call 0a8ceh		;44bc
	jr z,L_44C5		;44bf
	ld hl,0e61dh		;44c1
	inc (hl)			;44c4
L_44C5:
	ld a,0fdh		;44c5
	call L_4E1F		;44c7
	call L_5917		;44ca
	call 0be26h		;44cd
	ld a,009h		;44d0
L_44D2:
	jp L_43A9		;44d2
L_44D5:
	call L_44EA		;44d5
	ret c			;44d8
	call 09e21h		;44d9
	ret nc			;44dc
	ld a,02bh		;44dd
	call L_4E1F		;44df
	call L_5280		;44e2
	ld a,00bh		;44e5
	jp L_43A9		;44e7
L_44EA:
	ld a,(0e500h)		;44ea
	sub 004h		;44ed
	cp 004h		;44ef
	ret			;44f1
L_44F2:
	djnz L_4502		;44f2
	ld hl,0e004h		;44f4
	dec (hl)			;44f7
	ret nz			;44f8
	xor a			;44f9
	ld (0e007h),a		;44fa
	ld a,004h		;44fd
	jp L_43A9		;44ff
L_4502:
	call L_4D38		;4502
	call L_4D1E		;4505
	ret p			;4508
	ld a,(0e501h)		;4509
	ld hl,0e058h		;450c
	add a,l			;450f
	ld l,a			;4510
	ld a,(hl)			;4511
	or a			;4512
	jr z,L_451F		;4513
	sub 001h		;4515
	daa			;4517
	ld (hl),a			;4518
	call L_4538		;4519
L_451C:
	jp L_4359		;451c
L_451F:
	ld a,l			;451f
	xor 001h		;4520
	ld l,a			;4522
	ld a,(hl)			;4523
	or a			;4524
	jr z,L_4547		;4525
	sub 001h		;4527
	daa			;4529
	ld (hl),a			;452a
	call L_4538		;452b
	ld a,(0e501h)		;452e
	xor 001h		;4531
	ld (0e501h),a		;4533
	jr L_451C		;4536
L_4538:
	ld a,(0e501h)		;4538
	or a			;453b
	ld de,07cf6h		;453c
	jr z,L_4544		;453f
	ld de,07d06h		;4541
L_4544:
	jp L_5C25		;4544
L_4547:
	ld a,095h		;4547
	call L_4E1F		;4549
	jp L_4439		;454c
L_454F:
	djnz L_4582		;454f
	call 07e8ch		;4551
	call L_50F5		;4554
	ret nz			;4557
	ld hl,0e026h		;4558
	ld a,(hl)			;455b
	and a			;455c
	jr nz,L_4567		;455d
L_455F:
	ld hl,0e002h		;455f
	res 6,(hl)		;4562
	jp L_43A0		;4564
L_4567:
	ld (hl),000h		;4567
	ld hl,00004h		;4569
	ld (0e000h),hl		;456c
	call L_4579		;456f
	ret nz			;4572
	call L_5D1A		;4573
	jp L_5CC4		;4576
L_4579:
	ld a,(0e0d4h)		;4579
	ld b,a			;457c
	ld a,(0e0d2h)		;457d
	or b			;4580
	ret			;4581
L_4582:
	call L_4D1E		;4582
	ret p			;4585
	ld de,07d44h		;4586
	call L_5C25		;4589
	ld a,(0e027h)		;458c
	and a			;458f
	ld de,07ecfh		;4590
	call nz,L_5C25		;4593
	jp L_435E		;4596
L_4599:
	djnz L_45E8		;4599
	call 09e6fh		;459b
	ld a,(0e608h)		;459e
	or a			;45a1
	ret nz			;45a2
	call L_5280		;45a3
	call L_4D47		;45a6
	ld de,07d28h		;45a9
	call L_5C3C		;45ac
	ld de,07d14h		;45af
	call L_5C25		;45b2
	ld a,(0e688h)		;45b5
	dec a			;45b8
	add a,001h		;45b9
	daa			;45bb
	ld de,0f000h		;45bc
	ld (de),a			;45bf
	ld b,001h		;45c0
	cp 010h		;45c2
	push af			;45c4
	call c,L_4D95		;45c5
	pop af			;45c8
	call nc,L_4D89		;45c9
	inc l			;45cc
	ld a,028h		;45cd
	call 0004dh		;45cf   ; BIOS WRTVRM - Writes data in VRAM
	call L_465A		;45d2
	call L_4614		;45d5
	call L_4646		;45d8
	call L_461F		;45db
	ld a,08eh		;45de
	call L_4E1F		;45e0
	ld a,060h		;45e3
	jp L_435B		;45e5
L_45E8:
	djnz L_4603		;45e8
	ld hl,0e004h		;45ea
	dec (hl)			;45ed
	ret nz			;45ee
	call L_528E		;45ef
	call L_51CD		;45f2
	ld a,08ah		;45f5
	call L_5CC4		;45f7
	xor a			;45fa
	ld (0e01fh),a		;45fb
	ld a,005h		;45fe
	jp L_43A9		;4600
L_4603:
	call L_5280		;4603
	call L_469F		;4606
	call 09e3bh		;4609
	ld a,001h		;460c
	ld (0e608h),a		;460e
	jp L_435E		;4611
L_4614:
	ld a,(0e688h)		;4614
	inc a			;4617
	ld l,a			;4618
	ld h,001h		;4619
	ld (0e041h),hl		;461b
	ret			;461e
L_461F:
	ld a,(0e041h)		;461f
	ld hl,0e061h		;4622
	call L_4136		;4625
	ld a,001h		;4628
	bit 7,(hl)		;462a
	jr z,L_4631		;462c
	ld (0e078h),a		;462e
L_4631:
	bit 6,(hl)		;4631
	jr z,L_4638		;4633
	ld (0e077h),a		;4635
L_4638:
	bit 5,(hl)		;4638
	jr z,L_463F		;463a
	ld (0e076h),a		;463c
L_463F:
	bit 4,(hl)		;463f
	ret z			;4641
	ld (0e079h),a		;4642
	ret			;4645
L_4646:
	ld a,(0e041h)		;4646
	cp 00bh		;4649
	ret z			;464b
	ld hl,04689h		;464c
	call L_414C		;464f
	ld h,0e0h		;4652
	ld l,d			;4654
	ld (hl),000h		;4655
	ld l,e			;4657
	ld (hl),000h		;4658
L_465A:
	call L_422B		;465a
	ld a,(0e041h)		;465d
	ld hl,0af09h		;4660
	call L_414C		;4663
	ld hl,0af20h		;4666
	ld a,(0e041h)		;4669
	call L_4155		;466c
	ld c,a			;466f
	dec c			;4670
	ld b,000h		;4671
	push de			;4673
	push bc			;4674
	ld h,d			;4675
	ld l,e			;4676
	inc de			;4677
	ld (hl),b			;4678
	ldir		;4679
	pop bc			;467b
	pop de			;467c
	ld hl,00150h		;467d
	add hl,de			;4680
	ld b,c			;4681
	inc b			;4682
L_4683:
	ld a,(hl)			;4683
	and 001h		;4684
	ld (hl),a			;4686
	inc hl			;4687
	djnz L_4683		;4688
	jp L_4215		;468a

; ----------------------------------------------------------------------
; DATOS dos_marcas_por_mundo: 9 palabras, mapas 2-10, que p00:464C lee en
;   0x4689 con 0x414C (mapa 11 sale antes): sus dos bytes son direcciones
;   0xE0xx que pone a 0
;   0x468d..0x469f  (18 bytes)
DATA_dos_marcas_por_mundo:
	defb 0a2h,0a2h	; 468d
	defb 0a3h,0a3h	; 468f
	defb 0a0h,0a1h	; 4691
	defb 0a4h,0a4h	; 4693
	defb 0a5h,0a5h	; 4695
	defb 0a6h,0a6h	; 4697
	defb 0a8h,0a9h	; 4699
	defb 0aah,0abh	; 469b
	defb 0ach,0ach	; 469d

; ======================================================================
; CODIGO 0x469f..0x48c9  (554 bytes)
; ======================================================================


L_469F:
	ld hl,0e800h		;469f
	ld de,0e801h		;46a2
	ld bc,001ffh		;46a5
	ld (hl),000h		;46a8
	ldir		;46aa
	ret			;46ac
L_46AD:
	djnz L_46EC		;46ad
	call L_50F5		;46af
	ret nz			;46b2
	ld a,(0e041h)		;46b3
	cp 00bh		;46b6
	jr nz,L_46C0		;46b8
	ld a,(0e06dh)		;46ba
	ld h,a			;46bd
	jr L_46D3		;46be
L_46C0:
	ld a,(0e01ah)		;46c0
	ld hl,0e647h		;46c3
	add a,l			;46c6
	ld l,a			;46c7
	ld a,(hl)			;46c8
	neg		;46c9
	ld c,a			;46cb
	ld b,000h		;46cc
	ld hl,0998eh		;46ce
	add hl,bc			;46d1
	ld h,(hl)			;46d2
L_46D3:
	ld l,001h		;46d3
	ld (0e041h),hl		;46d5
	call L_51CD		;46d8
	call 06c95h		;46db
	call 09e8fh		;46de
	xor a			;46e1
	ld (0e01ah),a		;46e2
	inc a			;46e5
	ld (0e608h),a		;46e6
	jp L_435E		;46e9
L_46EC:
	djnz L_470D		;46ec
	call L_54BF		;46ee
	call 09e97h		;46f1
	ld a,(0e608h)		;46f4
	or a			;46f7
	ret nz			;46f8
	call L_5280		;46f9
	xor a			;46fc
	ld (0e01fh),a		;46fd
	ld a,088h		;4700
	call L_5CC4		;4702
	call L_5956		;4705
	ld a,005h		;4708
	jp L_43A9		;470a
L_470D:
	call L_5280		;470d
	call L_4D47		;4710
	ld de,07d28h		;4713
	call L_5C3C		;4716
	call L_472A		;4719
	call L_4730		;471c
	call L_520B		;471f
	ld a,0fah		;4722
	call L_4E1F		;4724
	jp L_435E		;4727
L_472A:
	ld de,07d1dh		;472a
	jp L_5C25		;472d
L_4730:
	ld hl,00000h		;4730
	ld (0e076h),hl		;4733
	ld (0e078h),hl		;4736
	ret			;4739
L_473A:
	djnz L_474A		;473a
	ld a,005h		;473c
	call L_43A9		;473e
	call 073d6h		;4741
	call L_5474		;4744
	jp L_590E		;4747
L_474A:
	call 09e07h		;474a
	jr c,L_475E		;474d
	call 0be36h		;474f
	call 073d6h		;4752
	call 07e57h		;4755
	call L_5474		;4758
	jp L_5423		;475b
L_475E:
	ld a,0feh		;475e
	call L_4E1F		;4760
	call L_5280		;4763
	jp L_435E		;4766
L_4769:
	call L_4D38		;4769
	call L_4D47		;476c
	ld a,(0e041h)		;476f
	cp 004h		;4772
	call z,L_479C		;4774
	call L_4792		;4777
	ld (0e042h),a		;477a
	call L_51CD		;477d
	xor a			;4780
	ld (0e01ah),a		;4781
	ld a,(0e690h)		;4784
	or a			;4787
	ld a,00eh		;4788
	jp nz,L_43A9		;478a
	ld a,005h		;478d
	jp L_43A9		;478f
L_4792:
	ld a,(0e01ah)		;4792
	ld hl,0e647h		;4795
	add a,l			;4798
	ld l,a			;4799
	ld a,(hl)			;479a
	ret			;479b
L_479C:
	call L_4792		;479c
	cp 004h		;479f
	ret nz			;47a1
	ld a,(0e01ah)		;47a2
	dec a			;47a5
	jr z,L_47B9		;47a6
	dec a			;47a8
	ret z			;47a9
	dec a			;47aa
	ret nz			;47ab
	ld a,(0e505h)		;47ac
	cp 080h		;47af
	ret c			;47b1
	ld hl,00000h		;47b2
	ld (0e0a0h),hl		;47b5
	ret			;47b8
L_47B9:
	ld hl,0e0a1h		;47b9
	bit 0,(hl)		;47bc
	ret nz			;47be
	dec l			;47bf
	inc (hl)			;47c0
	ld a,(hl)			;47c1
	cp 005h		;47c2
	ret c			;47c4
	ld (hl),000h		;47c5
	inc l			;47c7
	ld (hl),001h		;47c8
	ld a,02eh		;47ca
	jp L_4E1F		;47cc
L_47CF:
	djnz L_4835		;47cf
	xor a			;47d1
	ld (0f000h),a		;47d2
	call 09a99h		;47d5
	ld a,(0f000h)		;47d8
	and a			;47db
	jr nz,L_480D		;47dc
	call 09ac9h		;47de
	jr nc,L_481E		;47e1
	ld a,(0e041h)		;47e3
	dec a			;47e6
	jr z,L_4807		;47e7
	call L_4730		;47e9
	call L_4D38		;47ec
	call L_4D47		;47ef
	call L_5280		;47f2
	call L_472A		;47f5
	ld a,0fah		;47f8
	call L_4E1F		;47fa
	ld a,078h		;47fd
	ld (0e004h),a		;47ff
	ld a,002h		;4802
	jp L_4443		;4804
L_4807:
	ld hl,04801h		;4807
	ld (0e041h),hl		;480a
L_480D:
	call L_4D38		;480d
	call L_4D47		;4810
	call L_5280		;4813
	call 06903h		;4816
	call L_51E8		;4819
	jr L_4830		;481c
L_481E:
	call 09e21h		;481e
	jp nc,067e2h		;4821
	call L_5280		;4824
	call L_4D47		;4827
	call 06903h		;482a
	call L_51DF		;482d
L_4830:
	ld a,005h		;4830
	jp L_43A9		;4832
L_4835:
	djnz L_4843		;4835
	ld hl,0e004h		;4837
	dec (hl)			;483a
	ret nz			;483b
	ld a,088h		;483c
	call L_5CAF		;483e
	jr L_4807		;4841
L_4843:
	call L_4D47		;4843
	call L_5711		;4846
	call 065a8h		;4849
	jp L_435E		;484c
L_484F:
	djnz L_486E		;484f
	call L_4C68		;4851
	ld a,(0e008h)		;4854
	bit 5,a		;4857
	ret z			;4859
	call L_4D47		;485a
	call L_51DF		;485d
	xor a			;4860
	ld (0e01bh),a		;4861
	ld a,08ah		;4864
	call L_5CC4		;4866
	ld a,005h		;4869
	jp L_43A9		;486b
L_486E:
	call L_4D38		;486e
	call L_4D47		;4871
	call L_5280		;4874
	ld a,08ch		;4877
	call L_5CC4		;4879
	call L_520B		;487c
	call L_575E		;487f
	call L_422B		;4882
	call 069b9h		;4885
	call L_4215		;4888
	jp L_435E		;488b
L_488E:
	djnz L_48B7		;488e
	call L_4C68		;4890
	call 08f43h		;4893
	call 0938eh		;4896
	ld a,(0e008h)		;4899
	and 002h		;489c
	ret z			;489e
	xor a			;489f
	ld (0e690h),a		;48a0
	ld a,010h		;48a3
	ld (0e502h),a		;48a5
	ld a,002h		;48a8
	ld (0e01ah),a		;48aa
	ld a,08ah		;48ad
	call L_5D0A		;48af
	ld a,00ah		;48b2
	jp L_43A9		;48b4
L_48B7:
	ld a,08dh		;48b7
	call L_5D0A		;48b9
	call L_57E1		;48bc
	call 08f1eh		;48bf
	jp L_435E		;48c2
L_48C5:
	ld a,b			;48c5
	call L_4140		;48c6

; ----------------------------------------------------------------------
; DATOS tabla_48C9: 5 destinos del despachador de 0x4140 (call en p00:48C6):
;   0x48D3, 0x48E4, 0x4909, 0x4922, 0x493D; lo leen p00:48C6 (10 bytes)
;   0x48c9..0x48d3  (10 bytes)
DATA_tabla_48C9:
	defb 0d3h,048h	; 48c9
	defb 0e4h,048h	; 48cb
	defb 009h,049h	; 48cd
	defb 022h,049h	; 48cf
	defb 03dh,049h	; 48d1

; ======================================================================
; CODIGO 0x48d3..0x49be  (235 bytes)
; ======================================================================


L_48D3:
	call L_5280		;48d3
	call L_520B		;48d6
	call 09f0fh		;48d9
	ld a,001h		;48dc
	ld (0e608h),a		;48de
	jp L_435E		;48e1
L_48E4:
	call 09f2eh		;48e4
	ld a,(0e608h)		;48e7
	or a			;48ea
	ret nz			;48eb
	call L_5280		;48ec
	call L_4D47		;48ef
	ld a,(0e680h)		;48f2
	ld (0e690h),a		;48f5
	call L_4901		;48f8
	call 08f1eh		;48fb
	jp L_435E		;48fe
L_4901:
	call L_57E1		;4901
	ld a,08dh		;4904
	jp L_5CAF		;4906
L_4909:
	call L_4C68		;4909
	call 08f43h		;490c
	call 0938eh		;490f
	ld a,(0e693h)		;4912
	dec a			;4915
	ret z			;4916
	dec a			;4917
	jr z,L_4920		;4918
	ld a,(0e008h)		;491a
	and 002h		;491d
	ret z			;491f
L_4920:
	jr L_493A		;4920
L_4922:
	call L_5280		;4922
	call L_4D47		;4925
	xor a			;4928
	ld (0e690h),a		;4929
	call L_51DF		;492c
	call 09f42h		;492f
	call 073b7h		;4932
	ld a,001h		;4935
	ld (0e608h),a		;4937
L_493A:
	jp L_435E		;493a
L_493D:
	call L_54BF		;493d
	call 09f56h		;4940
	ld a,(0e608h)		;4943
	or a			;4946
	ret nz			;4947
	ld a,088h		;4948
	call L_5CAF		;494a
	call L_5956		;494d
	xor a			;4950
	ld (0e01ch),a		;4951
	ld a,005h		;4954
	jp L_43A9		;4956
L_4959:
	djnz L_4969		;4959
	call 09f68h		;495b
	ld a,(0e64ch)		;495e
	or a			;4961
	ret nz			;4962
	call L_4335		;4963
	jp L_435E		;4966
L_4969:
	djnz L_4991		;4969
	call L_4241		;496b
	call 0be1ch		;496e
	call L_4215		;4971
	ld a,(0e698h)		;4974
	or a			;4977
	ret nz			;4978
	ld a,(0e041h)		;4979
	ld hl,05e05h		;497c
	call L_4136		;497f
	ld h,(hl)			;4982
	ld l,001h		;4983
	ld (0e0d2h),hl		;4985
	call L_5561		;4988
	call L_54BF		;498b
	jp L_435E		;498e
L_4991:
	djnz L_499B		;4991
	call L_5848		;4993
	ld a,005h		;4996
	jp L_43A9		;4998
L_499B:
	xor a			;499b
	ld (0e615h),a		;499c
	ld (0e020h),a		;499f
	call L_49B0		;49a2
	ld a,081h		;49a5
	call L_4E1F		;49a7
	call 09f61h		;49aa
	jp L_435E		;49ad
L_49B0:
	ld hl,0ffffh		;49b0
	ld (0e648h),hl		;49b3
	ld (0e64ah),hl		;49b6
	ret			;49b9
L_49BA:
	ld a,b			;49ba
	call L_4140		;49bb

; ----------------------------------------------------------------------
; DATOS tabla_49BE: 9 destinos del despachador de 0x4140 (call en p00:49BB):
;   0x49D0, 0x49DA, 0x49E5, 0x49F0, 0x49F9, 0x4A1E, 0x4A35, 0x4A51 ...; lo
;   leen p00:49BB (18 bytes)
;   0x49be..0x49d0  (18 bytes)
DATA_tabla_49BE:
	defb 0d0h,049h	; 49be
	defb 0dah,049h	; 49c0
	defb 0e5h,049h	; 49c2
	defb 0f0h,049h	; 49c4
	defb 0f9h,049h	; 49c6
	defb 01eh,04ah	; 49c8
	defb 035h,04ah	; 49ca
	defb 051h,04ah	; 49cc
	defb 062h,04ah	; 49ce

; ======================================================================
; CODIGO 0x49d0..0x4b4e  (382 bytes)
; ======================================================================


L_49D0:
	ld a,0ffh		;49d0
	call L_4E1F		;49d2
	ld a,028h		;49d5
	jp L_435B		;49d7
L_49DA:
	ld hl,0e004h		;49da
	dec (hl)			;49dd
	ret nz			;49de
	call 0a05ah		;49df
L_49E2:
	jp L_435E		;49e2
L_49E5:
	call 0a06dh		;49e5
	jp nz,L_54BF		;49e8
	ld a,078h		;49eb
	jp L_435B		;49ed
L_49F0:
	ld hl,0e004h		;49f0
	dec (hl)			;49f3
	jp nz,L_54BF		;49f4
	jr L_49E2		;49f7
L_49F9:
	call L_4D47		;49f9
	call L_5280		;49fc
	call L_54E6		;49ff
	call L_579A		;4a02
	call L_4241		;4a05
	call 0b7c0h		;4a08
	call L_4215		;4a0b
	xor a			;4a0e
	ld (0e024h),a		;4a0f
	inc a			;4a12
	ld (0e608h),a		;4a13
	ld a,092h		;4a16
	call L_4E34		;4a18
	jp L_435E		;4a1b
L_4A1E:
	call L_5474		;4a1e
	call L_54F3		;4a21
	call L_4241		;4a24
	call 0b847h		;4a27
	call L_4215		;4a2a
	ld a,(0e608h)		;4a2d
	or a			;4a30
	ret nz			;4a31
	jp L_4359		;4a32
L_4A35:
	call L_4D47		;4a35
	call L_5280		;4a38
	call L_568E		;4a3b
	call 06a1eh		;4a3e
	call 06acah		;4a41
	ld a,001h		;4a44
	ld (0e02eh),a		;4a46
	ld a,093h		;4a49
	call L_4E34		;4a4b
	jp L_435E		;4a4e
L_4A51:
	call L_4241		;4a51
	call 06adch		;4a54
	call L_4215		;4a57
	ld a,(0e02eh)		;4a5a
	or a			;4a5d
	ret nz			;4a5e
	jp L_435E		;4a5f
L_4A62:
	call L_50F5		;4a62
	ret z			;4a65
	jp L_455F		;4a66
L_4A69:
	push bc			;4a69
	call L_4C68		;4a6a
	pop bc			;4a6d
	djnz L_4A7F		;4a6e
	call 09716h		;4a70
	ld a,(0e02dh)		;4a73
	and a			;4a76
	ret z			;4a77
L_4A78:
	xor a			;4a78
	ld (0e02dh),a		;4a79
	jp L_435E		;4a7c
L_4A7F:
	djnz L_4AA5		;4a7f
	call 097ddh		;4a81
	ld a,(0e02dh)		;4a84
	and a			;4a87
	jr nz,L_4AA0		;4a88
	call 09926h		;4a8a
	ld a,0b4h		;4a8d
	ld (0e004h),a		;4a8f
	ld a,004h		;4a92
	call L_4443		;4a94
	call L_4D38		;4a97
	call L_5280		;4a9a
	jp L_5280		;4a9d
L_4AA0:
	call 09908h		;4aa0
	jr L_4A78		;4aa3
L_4AA5:
	djnz L_4AB8		;4aa5
	ld a,(0e008h)		;4aa7
	and a			;4aaa
	ret z			;4aab
	ld hl,0e001h		;4aac
	dec (hl)			;4aaf
	dec (hl)			;4ab0
	xor a			;4ab1
	ld (0e02dh),a		;4ab2
	jp 0990fh		;4ab5
L_4AB8:
	djnz L_4B27		;4ab8
	ld hl,0e004h		;4aba
	dec (hl)			;4abd
	ret nz			;4abe
	xor a			;4abf
	ld (0e007h),a		;4ac0
	ld hl,0e016h		;4ac3
	ld de,0e017h		;4ac6
	ld bc,000e9h		;4ac9
	ld (hl),000h		;4acc
	ldir		;4ace
	ld hl,0e200h		;4ad0
	ld de,0e201h		;4ad3
	ld bc,008feh		;4ad6
	ld (hl),000h		;4ad9
	ldir		;4adb
	ld hl,0ec00h		;4add
	ld de,0ec01h		;4ae0
	ld bc,0043fh		;4ae3
	ld (hl),000h		;4ae6
	ldir		;4ae8
	call 0982bh		;4aea
	call 099b3h		;4aed
	ld hl,00101h		;4af0
	ld (0e041h),hl		;4af3
	ld a,(0e501h)		;4af6
	and a			;4af9
	ld hl,0e053h		;4afa
	jr z,L_4B01		;4afd
	ld l,057h		;4aff
L_4B01:
	ld a,(hl)			;4b01
	dec l			;4b02
	ld (hl),a			;4b03
	ld a,(0e501h)		;4b04
	or a			;4b07
	ld hl,0e059h		;4b08
	ld de,0e057h		;4b0b
	jr z,L_4B13		;4b0e
	dec l			;4b10
	ld e,053h		;4b11
L_4B13:
	bit 0,(hl)		;4b13
	jr z,L_4B1A		;4b15
	ld a,(de)			;4b17
	dec e			;4b18
	ld (de),a			;4b19
L_4B1A:
	call L_4CF1		;4b1a
	ld a,040h		;4b1d
	ld (0e002h),a		;4b1f
	ld a,004h		;4b22
	jp L_43A9		;4b24
L_4B27:
	call L_54E6		;4b27
	call L_4D38		;4b2a
	call L_5280		;4b2d
	call L_568E		;4b30
	call L_5E95		;4b33
	call L_54DD		;4b36
	ld hl,01800h		;4b39
	ld de,04b4eh		;4b3c
	call L_5C46		;4b3f
	call L_54E1		;4b42
	call 09704h		;4b45
	call 098edh		;4b48
	jp L_4A78		;4b4b

; ----------------------------------------------------------------------
; DATOS rle_4B4E: rle a la VRAM (0x5C46); lo leen p00:4B3F (13 bytes)
;   0x4b4e..0x4b5b  (13 bytes)
DATA_rle_4B4E:
	defb 081h,0ffh,007h,080h,081h,0ffh,007h,000h,009h,080h,007h,000h,000h	; 4b4e  .............

; ======================================================================
; CODIGO 0x4b5b..0x4bcf  (116 bytes)
; ======================================================================


L_4B5B:
	djnz L_4B8E		;4b5b
	call L_4241		;4b5d
	call 0be1ch		;4b60
	call L_4215		;4b63
	ld a,(0e698h)		;4b66
	or a			;4b69
	ret nz			;4b6a
	call 079f4h		;4b6b
	call L_54BF		;4b6e
	xor a			;4b71
	ld h,a			;4b72
	ld l,a			;4b73
	ld (0e0d2h),hl		;4b74
	ld (0e700h),a		;4b77
	ld (0e702h),hl		;4b7a
	ld (0e02ch),a		;4b7d
	ld a,(0e041h)		;4b80
	ld hl,0e061h		;4b83
	call L_4136		;4b86
	set 2,(hl)		;4b89
L_4B8B:
	jp L_435E		;4b8b
L_4B8E:
	djnz L_4BCA		;4b8e
	ld a,(0e041h)		;4b90
	cp 00bh		;4b93
	jr z,L_4BA2		;4b95
	call L_58D3		;4b97
	call L_4BA9		;4b9a
L_4B9D:
	ld a,005h		;4b9d
	jp L_43A9		;4b9f
L_4BA2:
	ld a,006h		;4ba2
	ld (0e64bh),a		;4ba4
	jr L_4B9D		;4ba7
L_4BA9:
	ld a,(0e041h)		;4ba9
	ld hl,l4bcdh		;4bac
	call L_4155		;4baf
	and 0f0h		;4bb2
	sub 008h		;4bb4
	ld d,a			;4bb6
	ld a,(hl)			;4bb7
	rlca			;4bb8
	rlca			;4bb9
	rlca			;4bba
	rlca			;4bbb
	and 0f0h		;4bbc
	ld e,a			;4bbe
	ld c,00ch		;4bbf
	call L_5D88		;4bc1
	ld a,001h		;4bc4
	ld (0e0d4h),a		;4bc6
	ret			;4bc9
L_4BCA:
	call L_4335		;4bca
L_4BCD:
	jr L_4B8B		;4bcd

; ----------------------------------------------------------------------
; DATOS sitio_por_mundo: un byte por mapa 2-10 que p00:4BAC lee en 0x4BCD +
;   mapa (0x4155): el nibble alto - 8 da la Y y el bajo la X (los de los mapas
;   1 y 11 serian bytes del codigo de alrededor)
;   0x4bcf..0x4bd8  (9 bytes)
DATA_sitio_por_mundo:
	defb 098h,078h,078h,098h,097h,0b6h,0b8h,078h,0b8h	; 4bcf  .xx....x.

; ======================================================================
; CODIGO 0x4bd8..0x4c5b  (131 bytes)
; ======================================================================


L_4BD8:
	djnz L_4BF0		;4bd8
	call 0be81h		;4bda
	ld a,(0e53fh)		;4bdd
	and a			;4be0
	ret nz			;4be1
	call L_5218		;4be2
	call L_5561		;4be5
	call 0ae9ah		;4be8
	ld a,005h		;4beb
	jp L_43A9		;4bed
L_4BF0:
	xor a			;4bf0
	ld (0e031h),a		;4bf1
	call 0be5fh		;4bf4
	jp L_435E		;4bf7
L_4BFA:
	call L_4C75		;4bfa
	ld hl,0e012h		;4bfd
	call L_4C6E		;4c00
	or a			;4c03
	ret z			;4c04
	ld hl,0e004h		;4c05
	ld (hl),000h		;4c08
	ld hl,0e000h		;4c0a
	ld b,(hl)			;4c0d
	djnz L_4C1E		;4c0e
	and 030h		;4c10
	ret z			;4c12
	ld a,040h		;4c13
	ld (0e002h),a		;4c15
	ld (hl),003h		;4c18
	inc hl			;4c1a
	ld (hl),000h		;4c1b
	ret			;4c1d
L_4C1E:
	inc b			;4c1e
	ex af,af'			;4c1f
	xor a			;4c20
	call L_43A2		;4c21
	ex af,af'			;4c24
	jr z,L_4C33		;4c25
	ld a,(0e025h)		;4c27
	bit 0,a		;4c2a
	call z,L_43CB		;4c2c
	ld hl,0e025h		;4c2f
	inc (hl)			;4c32
L_4C33:
	xor a			;4c33
	call L_4E1F		;4c34
	call L_5CC9		;4c37
	jp L_42F1		;4c3a
L_4C3D:
	call L_4DED		;4c3d
	ld hl,00000h		;4c40
	ld bc,04000h		;4c43
	xor a			;4c46
	call 00056h		;4c47   ; BIOS FILVRM - Fills VRAM with value
L_4C4A:
	ld hl,04c5bh		;4c4a
	ld d,008h		;4c4d
	ld c,000h		;4c4f
L_4C51:
	ld b,(hl)			;4c51
	call 00047h		;4c52   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;4c55
	inc c			;4c56
	dec d			;4c57
	jr nz,L_4C51		;4c58
	ret			;4c5a

; ----------------------------------------------------------------------
; DATOS registros_del_vdp: los valores de los registros 0-7 del VDP que
;   p00:4C4A escribe con WRTVDP al arrancar: R0 = 2 y R1 = 0xE2: modo grafico
;   2 (SCREEN 2) y sprites de 16 x 16; tabla de nombres en 0x3800 (R2 = 0x0E),
;   colores en 0 (R3 = 0x7F), dibujos en 0x2000 (R4 = 7), atributos de sprite
;   en 0x3B00 (R5 = 0x76) y sus dibujos en 0x1800 (R6 = 3); R7 = 0xE4
;   0x4c5b..0x4c63  (8 bytes)
DATA_registros_del_vdp:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e4h	; 4c5b  .....v..

; ======================================================================
; CODIGO 0x4c63..0x4ce6  (131 bytes)
; ======================================================================


L_4C63:
	ld c,007h		;4c63
	jp 00047h		;4c65   ; BIOS WRTVDP - Writes data in the VDP-register
L_4C68:
	call L_4C75		;4c68
L_4C6B:
	ld hl,0e009h		;4c6b
L_4C6E:
	ld c,(hl)			;4c6e
	ld (hl),a			;4c6f
	xor c			;4c70
	and (hl)			;4c71
	dec hl			;4c72
	ld (hl),a			;4c73
	ret			;4c74
L_4C75:
	ld e,08fh		;4c75
	ld a,00fh		;4c77
	call 00093h		;4c79   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4c7c
	di			;4c7e
	call 00096h		;4c7f   ; BIOS RDPSG - Reads value from PSG-register
	ei			;4c82
	cpl			;4c83
	and 03fh		;4c84
	push af			;4c86
	ld a,004h		;4c87
	call 00141h		;4c89   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4c8c
	rlca			;4c8d
	rlca			;4c8e
	rlca			;4c8f
	and 020h		;4c90
	ld e,a			;4c92
	ld a,008h		;4c93
	call 00141h		;4c95   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4c98
	rrca			;4c99
	rrca			;4c9a
	ld b,a			;4c9b
	and 004h		;4c9c
	or e			;4c9e
	ld c,a			;4c9f
	ld a,b			;4ca0
	rrca			;4ca1
	rrca			;4ca2
	ld b,a			;4ca3
	and 018h		;4ca4
	or c			;4ca6
	ld c,a			;4ca7
	ld a,b			;4ca8
	rrca			;4ca9
	and 003h		;4caa
	or c			;4cac
	pop bc			;4cad
	or b			;4cae
	ret			;4caf
L_4CB0:
	ld hl,0e016h		;4cb0
	ld de,0e017h		;4cb3
	ld bc,000e9h		;4cb6
	ld (hl),000h		;4cb9
	ldir		;4cbb
	ld hl,0e200h		;4cbd
	ld de,0e201h		;4cc0
	ld bc,00e3fh		;4cc3
	ld (hl),000h		;4cc6
	ldir		;4cc8
	ld hl,00101h		;4cca
	ld (0e041h),hl		;4ccd
	ld a,001h		;4cd0
	ld (0e501h),a		;4cd2
	ld hl,04ce6h		;4cd5
	ld de,0e051h		;4cd8
	ld bc,0000bh		;4cdb
	ldir		;4cde
	call L_4CF1		;4ce0
	jp 099b3h		;4ce3

; ----------------------------------------------------------------------
; DATOS al_empezar: 11 bytes que p00:4CD5 copia a 0xE051-0xE05B al empezar la
;   partida (el mapa 1, sala 1, va a 0xE041 justo antes)
;   0x4ce6..0x4cf1  (11 bytes)
DATA_al_empezar:
	defb 030h,008h,008h,000h,030h,008h,008h,001h,000h,001h,001h	; 4ce6  0...0......

; ======================================================================
; CODIGO 0x4cf1..0x4ef7  (518 bytes)
; ======================================================================


L_4CF1:
	ld a,(0f0f8h)		;4cf1
	or a			;4cf4
	ret z			;4cf5
	rra			;4cf6
	jr c,L_4D15		;4cf7
	rra			;4cf9
	jr c,L_4CFF		;4cfa
	rra			;4cfc
	ret nc			;4cfd
	ret			;4cfe
L_4CFF:
	ld hl,00100h		;4cff
	ld (0e046h),hl		;4d02
	ld (0e04ah),hl		;4d05
	ld (0e048h),hl		;4d08
	ld hl,03030h		;4d0b
	ld (0e052h),hl		;4d0e
	ld (0e056h),hl		;4d11
	ret			;4d14
L_4D15:
	ld a,099h		;4d15
	ld (0e05ah),a		;4d17
	ld (0e05bh),a		;4d1a
	ret			;4d1d
L_4D1E:
	ld hl,0e004h		;4d1e
	dec (hl)			;4d21
	ret m			;4d22
	ld a,(hl)			;4d23
	ld h,038h		;4d24
	xor 01fh		;4d26
	add a,080h		;4d28
	ld l,a			;4d2a
	ld b,014h		;4d2b
	xor a			;4d2d
	ld de,00020h		;4d2e
L_4D31:
	call 0004dh		;4d31   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;4d34
	djnz L_4D31		;4d35
	ret			;4d37
L_4D38:
	call L_54DD		;4d38
	ld hl,03b00h		;4d3b
	ld a,0d0h		;4d3e
	call 0004dh		;4d40   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;4d43
	jp L_54E1		;4d44
L_4D47:
	call L_4D38		;4d47
	call L_54DD		;4d4a
	ld hl,03880h		;4d4d
	ld bc,00280h		;4d50
	xor a			;4d53
	call 00056h		;4d54   ; BIOS FILVRM - Fills VRAM with value
	jp L_54E1		;4d57
L_4D5A:
	ld b,000h		;4d5a
	ld hl,0e046h		;4d5c
L_4D5F:
	add a,(hl)			;4d5f
	daa			;4d60
	ld (hl),a			;4d61
	inc hl			;4d62
	ld a,(hl)			;4d63
	adc a,000h		;4d64
	daa			;4d66
	ld (hl),a			;4d67
	cp 010h		;4d68
	jr c,L_4D71		;4d6a
	ld (hl),009h		;4d6c
	dec l			;4d6e
	ld (hl),099h		;4d6f
L_4D71:
	dec b			;4d71
	jp m,L_5F79		;4d72
	jp z,L_5F84		;4d75
	jp L_5F8F		;4d78
L_4D7B:
	ld b,001h		;4d7b
	ld hl,0e048h		;4d7d
	jr L_4D5F		;4d80
L_4D82:
	ld b,002h		;4d82
	ld hl,0e04ah		;4d84
	jr L_4D5F		;4d87
L_4D89:
	ld a,(de)			;4d89
	rra			;4d8a
	rra			;4d8b
	rra			;4d8c
	rra			;4d8d
	and 00fh		;4d8e
	inc a			;4d90
	call 0004dh		;4d91   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;4d94
L_4D95:
	ld a,(de)			;4d95
	and 00fh		;4d96
	inc a			;4d98
	call 0004dh		;4d99   ; BIOS WRTVRM - Writes data in VRAM
	dec de			;4d9c
	inc hl			;4d9d
	djnz L_4D89		;4d9e
	ret			;4da0
L_4DA1:
	ld a,l			;4da1
	rra			;4da2
	rra			;4da3
	rra			;4da4
	rra			;4da5
	rr h		;4da6
	rra			;4da8
	rr h		;4da9
	rra			;4dab
	rr h		;4dac
	ld l,h			;4dae
	and 003h		;4daf
	add a,0edh		;4db1
	ld h,a			;4db3
	ret			;4db4
L_4DB5:
	ld h,(ix+007h)		;4db5
	ld a,(ix+005h)		;4db8
	add a,010h		;4dbb
	ld l,a			;4dbd
	call L_4DA1		;4dbe
	ld a,0b9h		;4dc1
	cp (hl)			;4dc3
	ret c			;4dc4
L_4DC5:
	inc hl			;4dc5
	cp (hl)			;4dc6
	ret			;4dc7
L_4DC8:
	call L_4DA1		;4dc8
	ld a,0b9h		;4dcb
	cp (hl)			;4dcd
	ret			;4dce
L_4DCF:
	ld b,008h		;4dcf
	ld l,000h		;4dd1
	ld d,l			;4dd3
L_4DD4:
	add hl,hl			;4dd4
	jr nc,L_4DD8		;4dd5
	add hl,de			;4dd7
L_4DD8:
	djnz L_4DD4		;4dd8
	ret			;4dda
L_4DDB:
	ld a,(hl)			;4ddb
	and a			;4ddc
	ret nz			;4ddd
	ld a,(0e501h)		;4dde
	and a			;4de1
	ret			;4de2
L_4DE3:
	ld a,r		;4de3
	rrca			;4de5
	rrca			;4de6
	rrca			;4de7
	ld hl,0e003h		;4de8
	xor (hl)			;4deb
	ret			;4dec
L_4DED:
	ld a,0bch		;4ded
	ld (0e1b1h),a		;4def
	xor a			;4df2
	ld (0e1c0h),a		;4df3
	ld (0e1c1h),a		;4df6
	ld (0e1c2h),a		;4df9
	ld (0e1c6h),a		;4dfc
	ld (0e1c5h),a		;4dff
L_4E02:
	xor a			;4e02
	ld (0e1c7h),a		;4e03
	ld (0e1b0h),a		;4e06
	ld (0e1b2h),a		;4e09
	ld (0e1c3h),a		;4e0c
	ld hl,06075h		;4e0f
	ld (0e100h),hl		;4e12
	ld (0e102h),hl		;4e15
	ld (0e104h),hl		;4e18
	ld (0e106h),hl		;4e1b
	ret			;4e1e
L_4E1F:
	or a			;4e1f
	jp p,L_4E34		;4e20
	push hl			;4e23
	ld hl,0e002h		;4e24
	bit 6,(hl)		;4e27
	pop hl			;4e29
	jr nz,L_4E34		;4e2a
	push hl			;4e2c
	ld hl,0e00dh		;4e2d
	bit 0,(hl)		;4e30
	pop hl			;4e32
	ret nz			;4e33
L_4E34:
	di			;4e34
	push hl			;4e35
	push de			;4e36
	push bc			;4e37
	push af			;4e38
	ld a,(0f0f1h)		;4e39
	ld (0f0f4h),a		;4e3c
	ld a,(0f0f2h)		;4e3f
	ld (0f0f5h),a		;4e42
	ld a,00dh		;4e45
	ld (06000h),a		;4e47
	inc a			;4e4a
	ld (08000h),a		;4e4b
	pop af			;4e4e
	push af			;4e4f
	call L_4E6B		;4e50
	ld a,(0f0f4h)		;4e53
	ld (0f0f1h),a		;4e56
	ld (06000h),a		;4e59
	ld a,(0f0f5h)		;4e5c
	ld (0f0f2h),a		;4e5f
	ld (08000h),a		;4e62
	pop af			;4e65
	pop bc			;4e66
	pop de			;4e67
	pop hl			;4e68
	ei			;4e69
	ret			;4e6a
L_4E6B:
	or a			;4e6b
	jp z,L_4E02		;4e6c
	cp 0fah		;4e6f
	jp nc,L_4F52		;4e71
	or a			;4e74
	jp p,L_4F12		;4e75
	ld (0e1c7h),a		;4e78
	cp 083h		;4e7b
	jr nz,L_4E86		;4e7d
	ld a,001h		;4e7f
	ld (0e1cbh),a		;4e81
	jr L_4E8A		;4e84
L_4E86:
	xor a			;4e86
	ld (0e1cbh),a		;4e87
L_4E8A:
	ld a,(0e1c7h)		;4e8a
	ld de,0e10ch		;4e8d
	ld hl,04ef7h		;4e90
	ld bc,0001bh		;4e93
	ldir		;4e96
	ld hl,04ef7h		;4e98
	ld bc,0001bh		;4e9b
	ldir		;4e9e
	ld hl,04ef7h		;4ea0
	ld bc,0001bh		;4ea3
	ldir		;4ea6
	and 07fh		;4ea8
	rlca			;4eaa
	ld e,a			;4eab
	rlca			;4eac
	add a,e			;4ead
	ld hl,0743eh		;4eae
	add a,l			;4eb1
	ld l,a			;4eb2
	jr nc,L_4EB6		;4eb3
	inc h			;4eb5
L_4EB6:
	ld e,(hl)			;4eb6
	inc hl			;4eb7
	ld d,(hl)			;4eb8
	inc hl			;4eb9
	ld (0e10ch),de		;4eba
	ld e,(hl)			;4ebe
	inc hl			;4ebf
	ld d,(hl)			;4ec0
	inc hl			;4ec1
	ld (0e127h),de		;4ec2
	ld e,(hl)			;4ec6
	inc hl			;4ec7
	ld d,(hl)			;4ec8
	ld (0e142h),de		;4ec9
	ld hl,0610bh		;4ecd
	ld (0e100h),hl		;4ed0
	ld hl,06112h		;4ed3
	ld (0e102h),hl		;4ed6
	ld hl,06119h		;4ed9
	ld (0e104h),hl		;4edc
	ld a,(0e1b2h)		;4edf
	and 0fdh		;4ee2
	ld (0e1b2h),a		;4ee4
L_4EE7:
	xor a			;4ee7
	ld (0e1c0h),a		;4ee8
	ld (0e1c1h),a		;4eeb
	ld (0e1c3h),a		;4eee
	ld a,007h		;4ef1
	ld (0e1c2h),a		;4ef3
	ret			;4ef6

; ----------------------------------------------------------------------
; DATOS canal_en_blanco: los 27 bytes con los que p00:4E90-4EA6, p00:4F33,
;   p00:5003 y p00:50A4 ponen a cero la ficha de cada canal del sonido antes
;   de arrancar una musica o un efecto
;   0x4ef7..0x4f12  (27 bytes)
DATA_canal_en_blanco:
	defb 000h,000h,001h,000h,000h,000h,000h,000h,000h,001h,000h,000h,000h,000h,001h,001h	; 4ef7  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4f07  ...........

; ======================================================================
; CODIGO 0x4f12..0x543b  (1321 bytes)
; ======================================================================


L_4F12:
	ld c,a			;4f12
	ld a,(0e1c3h)		;4f13
	or a			;4f16
	ret nz			;4f17
	ld a,(0e1b0h)		;4f18
	cp c			;4f1b
	jr z,L_4F1F		;4f1c
	ret nc			;4f1e
L_4F1F:
	cp 025h		;4f1f
	jr nz,L_4F2C		;4f21
	ld a,(0e511h)		;4f23
	or a			;4f26
	cp 001h		;4f27
	jr nz,L_4F2C		;4f29
	ret			;4f2b
L_4F2C:
	ld a,c			;4f2c
	ld (0e1b0h),a		;4f2d
	ld de,0e15dh		;4f30
	ld hl,04ef7h		;4f33
	ld bc,0001bh		;4f36
	ldir		;4f39
	rlca			;4f3b
	ld hl,073dch		;4f3c
	add a,l			;4f3f
	ld l,a			;4f40
	jr nc,L_4F44		;4f41
	inc h			;4f43
L_4F44:
	ld e,(hl)			;4f44
	inc hl			;4f45
	ld d,(hl)			;4f46
	ld (0e169h),de		;4f47
	ld hl,064a5h		;4f4b
	ld (0e106h),hl		;4f4e
	ret			;4f51
L_4F52:
	jr z,L_4F77		;4f52
	cp 0fbh		;4f54
	jp z,L_5064		;4f56
	cp 0fch		;4f59
	jp z,L_50B3		;4f5b
	cp 0fdh		;4f5e
	jr z,L_4F87		;4f60
	cp 0feh		;4f62
	jp z,L_5014		;4f64
	ld a,001h		;4f67
	ld (0e1c8h),a		;4f69
	ld a,0ffh		;4f6c
	ld (0e1c4h),a		;4f6e
	ld a,030h		;4f71
	ld (0e1c0h),a		;4f73
	ret			;4f76
L_4F77:
	ld a,001h		;4f77
	ld (0e1c8h),a		;4f79
	ld a,0fah		;4f7c
	ld (0e1c4h),a		;4f7e
	ld a,00ah		;4f81
	ld (0e1c0h),a		;4f83
	ret			;4f86
L_4F87:
	ld a,001h		;4f87
	ld (0e1c9h),a		;4f89
	ld a,(0e1b2h)		;4f8c
	or 001h		;4f8f
	ld (0e1b2h),a		;4f91
	ld a,(0e1c0h)		;4f94
	ld (0e1b3h),a		;4f97
	ld a,(0e1c1h)		;4f9a
	ld (0e1b4h),a		;4f9d
	ld a,(0e1b1h)		;4fa0
	ld (0e1b5h),a		;4fa3
	ld a,(0e1c2h)		;4fa6
	ld (0e1b6h),a		;4fa9
	xor a			;4fac
	ld (0e1c2h),a		;4fad
	ld a,0bfh		;4fb0
	ld (0e1b1h),a		;4fb2
	xor a			;4fb5
	call 00096h		;4fb6   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1b7h),a		;4fb9
	ld a,001h		;4fbc
	call 00096h		;4fbe   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1b8h),a		;4fc1
	ld a,008h		;4fc4
	call 00096h		;4fc6   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1b9h),a		;4fc9
	ld a,009h		;4fcc
	call 00096h		;4fce   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bah),a		;4fd1
	ld a,00ah		;4fd4
	call 00096h		;4fd6   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bbh),a		;4fd9
	ld a,008h		;4fdc
	ld e,000h		;4fde
	call 00093h		;4fe0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,009h		;4fe3
	ld e,000h		;4fe5
	call 00093h		;4fe7   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00ah		;4fea
	ld e,000h		;4fec
	call 00093h		;4fee   ; BIOS WRTPSG - Writes data to PSG-register
	xor a			;4ff1
	ld (0e1aeh),a		;4ff2
	ld a,005h		;4ff5
	ld (0e1afh),a		;4ff7
	ld hl,06104h		;4ffa
	ld (0e10ah),hl		;4ffd
	ld de,0e193h		;5000
	ld hl,04ef7h		;5003
	ld bc,0001bh		;5006
	ldir		;5009
	ld hl,07de5h		;500b
	ld (0e193h),hl		;500e
	jp L_4EE7		;5011
L_5014:
	xor a			;5014
	ld (0e1c9h),a		;5015
	ld a,(0e1b2h)		;5018
	and 0feh		;501b
	ld (0e1b2h),a		;501d
	ld a,(0e1b3h)		;5020
	ld (0e1c0h),a		;5023
	ld a,(0e1b4h)		;5026
	ld (0e1c1h),a		;5029
	ld a,(0e1b5h)		;502c
	ld (0e1b1h),a		;502f
	ld a,(0e1b6h)		;5032
	ld (0e1c2h),a		;5035
	ld a,(0e1b7h)		;5038
	ld e,a			;503b
	xor a			;503c
	call 00093h		;503d   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1b8h)		;5040
	ld e,a			;5043
	ld a,001h		;5044
	call 00093h		;5046   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1b9h)		;5049
	ld e,a			;504c
	ld a,008h		;504d
	call 00093h		;504f   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1bah)		;5052
	ld e,a			;5055
	ld a,009h		;5056
	call 00093h		;5058   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1bbh)		;505b
	ld e,a			;505e
	ld a,00ah		;505f
	jp 00093h		;5061   ; BIOS WRTPSG - Writes data to PSG-register
L_5064:
	ld a,(0e1b2h)		;5064
	or 002h		;5067
	ld (0e1b2h),a		;5069
	ld a,(0e1b1h)		;506c
	ld (0e1bch),a		;506f
	ld a,(0e1b0h)		;5072
	or a			;5075
	jr nz,L_507C		;5076
	ld a,0bfh		;5078
	jr L_5081		;507a
L_507C:
	ld a,(0e1b1h)		;507c
	or 01bh		;507f
L_5081:
	ld (0e1b1h),a		;5081
	xor a			;5084
	call 00096h		;5085   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bdh),a		;5088
	ld a,001h		;508b
	call 00096h		;508d   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1beh),a		;5090
	ld a,008h		;5093
	call 00096h		;5095   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bfh),a		;5098
	ld hl,0649eh		;509b
	ld (0e108h),hl		;509e
	ld de,0e178h		;50a1
	ld hl,04ef7h		;50a4
	ld bc,0001bh		;50a7
	ldir		;50aa
	ld hl,07df2h		;50ac
	ld (0e184h),hl		;50af
	ret			;50b2
L_50B3:
	ld a,(0e1b2h)		;50b3
	bit 1,a		;50b6
	ret z			;50b8
	ld a,(0e1b2h)		;50b9
	and 0fdh		;50bc
	ld (0e1b2h),a		;50be
	ld a,(0e1b0h)		;50c1
	or a			;50c4
	ld a,(0e1bch)		;50c5
	jr z,L_50D8		;50c8
	ld b,a			;50ca
	ld a,(0e1b1h)		;50cb
	or 0dbh		;50ce
	and b			;50d0
	ld b,a			;50d1
	ld a,(0e1b1h)		;50d2
	and 024h		;50d5
	or b			;50d7
L_50D8:
	ld (0e1b1h),a		;50d8
	ld a,(0e1bdh)		;50db
	ld e,a			;50de
	xor a			;50df
	call 00093h		;50e0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1beh)		;50e3
	ld e,a			;50e6
	ld a,001h		;50e7
	call 00093h		;50e9   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1bfh)		;50ec
	ld e,a			;50ef
	ld a,008h		;50f0
	jp 00093h		;50f2   ; BIOS WRTPSG - Writes data to PSG-register
L_50F5:
	ld a,(0e1c0h)		;50f5
	or a			;50f8
	jr nz,L_5100		;50f9
	ld a,(0e1c2h)		;50fb
	or a			;50fe
	ret			;50ff
L_5100:
	ld a,(0e1c1h)		;5100
	cp 0fbh		;5103
	ret nz			;5105
	xor a			;5106
	ld (0e1c8h),a		;5107
	ret			;510a
L_510B:
	call L_525E		;510b
	call L_526C		;510e
	call L_568E		;5111
	call L_528E		;5114
	call L_422B		;5117
	call 063c2h		;511a
	call L_4215		;511d
	call L_5FA8		;5120
	call L_51F7		;5123
	call L_5200		;5126
L_5129:
	call L_5280		;5129
	call 0602fh		;512c
	call L_5218		;512f
	call L_523E		;5132
	call L_4241		;5135
	call 0bcb9h		;5138
	call 0bd58h		;513b
	call L_4215		;513e
	call 09ae5h		;5141
	call L_520B		;5144
	call 08eefh		;5147
	call L_5561		;514a
	ld a,(0e690h)		;514d
	or a			;5150
	jr nz,L_51A6		;5151
	call L_422B		;5153
	call L_5D68		;5156
	call 0691ah		;5159
	call 0656eh		;515c
	call L_4215		;515f
	call L_4185		;5162
	call 06054h		;5165
	call 06000h		;5168
	xor a			;516b
	ld (0e612h),a		;516c
	call 06186h		;516f
	call L_416C		;5172
	xor a			;5175
	ld (0e6a1h),a		;5176
	call 0993dh		;5179
	call 09dafh		;517c
	call 069e3h		;517f
	call L_419E		;5182
	call 09cfah		;5185
	call 09f1ah		;5188
	call 09e61h		;518b
	call 0a746h		;518e
	call L_416C		;5191
	call L_422B		;5194
	call 062efh		;5197
	call 063eah		;519a
	call L_4215		;519d
	call L_5CD0		;51a0
	call L_5D24		;51a3
L_51A6:
	ld a,(0e041h)		;51a6
	dec a			;51a9
	ld de,07d28h		;51aa
	jr z,L_51B2		;51ad
	ld de,07d33h		;51af
L_51B2:
	call L_5C25		;51b2
	ld a,(0e041h)		;51b5
	sub 001h		;51b8
	ret z			;51ba
	cp 00ah		;51bb
	jr c,L_51C1		;51bd
	ld a,010h		;51bf
L_51C1:
	ld de,0f000h		;51c1
	ld (de),a			;51c4
	ld b,001h		;51c5
	jp nc,L_4D89		;51c7
	jp L_4D95		;51ca
L_51CD:
	call L_525E		;51cd
	call L_568E		;51d0
	call L_5FC3		;51d3
	call L_526C		;51d6
	call L_5F9A		;51d9
	jp L_5129		;51dc
L_51DF:
	call L_568E		;51df
	call L_5280		;51e2
	jp L_5561		;51e5
L_51E8:
	call L_525E		;51e8
	call L_526C		;51eb
	call L_568E		;51ee
	call L_528E		;51f1
	jp L_5129		;51f4
L_51F7:
	ld hl,0e0d2h		;51f7
	ld a,(hl)			;51fa
	or a			;51fb
	ret z			;51fc
	ld (hl),001h		;51fd
	ret			;51ff
L_5200:
	ld a,(0e0d4h)		;5200
	or a			;5203
	ret z			;5204
	call L_58D3		;5205
	jp L_4BA9		;5208
L_520B:
	ld hl,0e0d5h		;520b
	ld a,(hl)			;520e
	or a			;520f
	ret z			;5210
	ld (hl),000h		;5211
	ld a,0fch		;5213
	jp L_4E1F		;5215
L_5218:
	call L_4579		;5218
	jp nz,L_49B0		;521b
	call L_419E		;521e
	ld a,(0e041h)		;5221
	ld hl,0a9efh		;5224
	call L_414C		;5227
	ld a,(0e042h)		;522a
	ld l,a			;522d
	ld h,000h		;522e
	add hl,hl			;5230
	add hl,hl			;5231
	add hl,de			;5232
	ld de,0e648h		;5233
	ld bc,00004h		;5236
	ldir		;5239
	jp L_416C		;523b
L_523E:
	call L_422B		;523e
	ld bc,(0e041h)		;5241
	ld a,c			;5245
	ld hl,0af09h		;5246
	call L_414C		;5249
	ld l,b			;524c
	dec l			;524d
	ld h,000h		;524e
	add hl,de			;5250
	ld (0e60ch),hl		;5251
	ld de,00150h		;5254
	add hl,de			;5257
	ld (0e60eh),hl		;5258
	jp L_4215		;525b
L_525E:
	ld hl,0e600h		;525e
	ld de,0e601h		;5261
	ld bc,00a3fh		;5264
	ld (hl),000h		;5267
	ldir		;5269
	ret			;526b
L_526C:
	ld hl,00000h		;526c
	ld (0e51ch),hl		;526f
	ld hl,0e540h		;5272
	ld de,0e541h		;5275
	ld bc,000bfh		;5278
	ld (hl),000h		;527b
	ldir		;527d
	ret			;527f
L_5280:
	ld hl,0ec80h		;5280
	ld de,0ec81h		;5283
	ld (hl),0e0h		;5286
	ld bc,0007fh		;5288
	ldir		;528b
	ret			;528d
L_528E:
	call L_422B		;528e
	xor a			;5291
	ld (0e500h),a		;5292
	ld (0e503h),a		;5295
	ld (0e502h),a		;5298
	ld (0e508h),a		;529b
	ld (0e518h),a		;529e
	ld (0e533h),a		;52a1
	inc a			;52a4
	ld (0e518h),a		;52a5
	inc a			;52a8
	ld (0e533h),a		;52a9
	ld a,008h		;52ac
	ld (0e532h),a		;52ae
	ld hl,(0e041h)		;52b1
	ld de,08a01h		;52b4
	rst 20h			;52b7
	jr nz,L_52CD		;52b8
	ld a,(0e507h)		;52ba
	or a			;52bd
	jp p,L_52CD		;52be
	ld a,0a8h		;52c1
	ld (0e507h),a		;52c3
	ld a,058h		;52c6
	ld (0e505h),a		;52c8
	jr L_52F2		;52cb
L_52CD:
	ld a,(0e041h)		;52cd
	ld hl,0b106h		;52d0
	call L_414C		;52d3
	ex de,hl			;52d6
	ld a,(0e042h)		;52d7
	call L_4155		;52da
	or a			;52dd
	jr z,L_52F2		;52de
	ld b,a			;52e0
	and 0f0h		;52e1
	add a,008h		;52e3
	ld (0e505h),a		;52e5
	ld a,b			;52e8
	rla			;52e9
	rla			;52ea
	rla			;52eb
	rla			;52ec
	and 0f0h		;52ed
	ld (0e507h),a		;52ef
L_52F2:
	jp L_4215		;52f2
L_52F5:
	ld hl,0e604h		;52f5
	inc (hl)			;52f8
	call L_420A		;52f9
	call L_4241		;52fc
	call 076c6h		;52ff
	call 079b2h		;5302
	call 06c56h		;5305
	call 06c95h		;5308
	call 073b7h		;530b
	call 071e3h		;530e
	call L_54DD		;5311
	call 073d6h		;5314
	xor a			;5317
	call 06df7h		;5318
	call 0766ch		;531b
	call L_54E1		;531e
	call 07378h		;5321
	call L_41FF		;5324
	call L_4215		;5327
	call 0aebch		;532a
	call L_420A		;532d
	call L_4241		;5330
	ld a,001h		;5333
	call 06df7h		;5335
	call 06bb0h		;5338
	call L_54DD		;533b
	call 0746dh		;533e
	call L_54E1		;5341
	call L_54BF		;5344
	call 079ddh		;5347
	call 07c7eh		;534a
	call L_41FF		;534d
	call L_4215		;5350
	call 0a8a0h		;5353
	ld a,(0e002h)		;5356
	add a,a			;5359
	call m,L_4C68		;535a
	call 0a8a0h		;535d
	call 09b02h		;5360
	call 09bb6h		;5363
	call L_419E		;5366
	call 0a036h		;5369
	call 0a12eh		;536c
	call 0a22dh		;536f
	call 0a2b6h		;5372
	call 0a43ah		;5375
	call 0a541h		;5378
	call 0a661h		;537b
	call 0a6b5h		;537e
	call 0a7a4h		;5381
	call L_416C		;5384
	call 06371h		;5387
	call 06398h		;538a
	call L_422B		;538d
	call 0643ch		;5390
	call 06531h		;5393
	call L_4215		;5396
	call 0a916h		;5399
	call L_420A		;539c
	call L_4241		;539f
	ld de,0eb00h		;53a2
	call 077eeh		;53a5
	call 079b2h		;53a8
	call 071e3h		;53ab
	call 07378h		;53ae
	call L_41FF		;53b1
	call L_4215		;53b4
	call 0a0f4h		;53b7
	call 0ad4ch		;53ba
	call 0b095h		;53bd
	call L_4185		;53c0
	call 0b3b4h		;53c3
	call 0b3c5h		;53c6
	call 0aecch		;53c9
	call 0afe8h		;53cc
	call 062dbh		;53cf
	call 069d2h		;53d2
	call L_416C		;53d5
	call L_420A		;53d8
	call L_4241		;53db
	ld hl,0eb00h		;53de
	call 07afeh		;53e1
	call 07c7eh		;53e4
	call L_41FF		;53e7
	call L_4215		;53ea
	call 07efch		;53ed
	call 09f82h		;53f0
	call 09beeh		;53f3
	call 0b701h		;53f6
	call 0b492h		;53f9
	call 0b6c1h		;53fc
	call 0bb24h		;53ff
	call 0bd55h		;5402
	call 0b9b2h		;5405
	call 0b1c1h		;5408
	call 0b40ch		;540b
	call 0b194h		;540e
	call 0b7d5h		;5411
	call 099ffh		;5414
	call 099c8h		;5417
	call 09a76h		;541a
	call 06171h		;541d
	call 06085h		;5420
L_5423:
	call L_54DD		;5423
	call L_4241		;5426
	call 0bd06h		;5429
	call 0bda1h		;542c
	call L_4215		;542f
	jp L_54E1		;5432
L_5435:
	ld a,(0e000h)		;5435
	call L_4140		;5438

; ----------------------------------------------------------------------
; DATOS tabla_543B: 21 destinos del despachador de 0x4140 (call en p00:5438):
;   0x5487, 0x5487, 0x5465, 0x5465, 0x5487, 0x5488, 0x5465, 0x5465 ...; lo
;   leen p00:5438 (42 bytes)
;   0x543b..0x5465  (42 bytes)
DATA_tabla_543B:
	defb 087h,054h	; 543b
	defb 087h,054h	; 543d
	defb 065h,054h	; 543f
	defb 065h,054h	; 5441
	defb 087h,054h	; 5443
	defb 088h,054h	; 5445
	defb 065h,054h	; 5447
	defb 065h,054h	; 5449
	defb 065h,054h	; 544b
	defb 087h,054h	; 544d
	defb 087h,054h	; 544f
	defb 06fh,054h	; 5451
	defb 087h,054h	; 5453
	defb 065h,054h	; 5455
	defb 06fh,054h	; 5457
	defb 065h,054h	; 5459
	defb 06fh,054h	; 545b
	defb 087h,054h	; 545d
	defb 087h,054h	; 545f
	defb 087h,054h	; 5461
	defb 088h,054h	; 5463

; ======================================================================
; CODIGO 0x5465..0x581d  (952 bytes)
; ======================================================================


L_5465:
	ld a,(0e02eh)		;5465
	or a			;5468
	ret nz			;5469
	ld a,(0e608h)		;546a
	or a			;546d
	ret z			;546e
L_546F:
	ld a,(0e602h)		;546f
	or a			;5472
	ret nz			;5473
L_5474:
	ld hl,03b00h		;5474
	call L_5BC8		;5477
	di			;547a
	exx			;547b
	ld hl,0ec80h		;547c
	ld b,080h		;547f
L_5481:
	outi		;5481
	jp nz,L_5481		;5483
	ei			;5486
L_5487:
	ret			;5487
L_5488:
	ld a,(0e602h)		;5488
	or a			;548b
	ret nz			;548c
	ld a,(0e603h)		;548d
	or a			;5490
	jr nz,L_5474		;5491
	ld hl,03b00h		;5493
	call L_5BC8		;5496
	di			;5499
	exx			;549a
	ld hl,0e601h		;549b
	ld a,(hl)			;549e
	add a,01ch		;549f
	and 07ch		;54a1
	ld (hl),a			;54a3
	ld e,a			;54a4
	ld d,020h		;54a5
L_54A7:
	ld a,e			;54a7
	ld hl,0ec80h		;54a8
	add a,l			;54ab
	ld l,a			;54ac
	ld b,004h		;54ad
L_54AF:
	outi		;54af
	jp nz,L_54AF		;54b1
	ld a,e			;54b4
	add a,00ch		;54b5
	and 07ch		;54b7
	ld e,a			;54b9
	dec d			;54ba
	jr nz,L_54A7		;54bb
	ei			;54bd
	ret			;54be
L_54BF:
	di			;54bf
	ld hl,03880h		;54c0
	call L_5BC8		;54c3
	exx			;54c6
	ld hl,0ed80h		;54c7
	ld b,080h		;54ca
L_54CC:
	outi		;54cc
	jp nz,L_54CC		;54ce
L_54D1:
	outi		;54d1
	jp nz,L_54D1		;54d3
L_54D6:
	outi		;54d6
	jp nz,L_54D6		;54d8
	ei			;54db
	ret			;54dc
L_54DD:
	ld a,001h		;54dd
	jr L_54E2		;54df
L_54E1:
	xor a			;54e1
L_54E2:
	ld (0e602h),a		;54e2
	ret			;54e5
L_54E6:
	ld hl,0ed00h		;54e6
	ld de,0ed01h		;54e9
	ld bc,002ffh		;54ec
	xor a			;54ef
	ld (hl),a			;54f0
	ldir		;54f1
L_54F3:
	ld bc,00300h		;54f3
L_54F6:
	ld hl,03800h		;54f6
	ld de,0ed00h		;54f9
	jp L_5BD4		;54fc
L_54FF:
	call L_554D		;54ff
	ld a,l			;5502
	add a,b			;5503
	ld l,a			;5504
	push hl			;5505
	ld a,h			;5506
	add a,d			;5507
	ld h,a			;5508
	call L_4DA1		;5509
	ld a,(hl)			;550c
	pop hl			;550d
	exx			;550e
	cp (hl)			;550f
	exx			;5510
	ccf			;5511
	ret c			;5512
	ld a,h			;5513
	add a,e			;5514
	ld h,a			;5515
	call L_4DA1		;5516
	ld a,(hl)			;5519
	exx			;551a
	cp (hl)			;551b
	exx			;551c
	ccf			;551d
	ret			;551e
L_551F:
	call L_554D		;551f
	ld a,h			;5522
	add a,b			;5523
	ld h,a			;5524
	push hl			;5525
	call L_4DA1		;5526
	ld a,(hl)			;5529
	pop hl			;552a
	exx			;552b
	cp (hl)			;552c
	exx			;552d
	ccf			;552e
	ret c			;552f
	push hl			;5530
	ld a,l			;5531
	add a,d			;5532
	ld l,a			;5533
	call L_4DA1		;5534
	ld a,(hl)			;5537
	pop hl			;5538
	exx			;5539
	cp (hl)			;553a
	exx			;553b
	ccf			;553c
	ret c			;553d
L_553E:
	call L_554D		;553e
	ld a,l			;5541
	add a,e			;5542
	ld l,a			;5543
	call L_4DA1		;5544
	ld a,(hl)			;5547
	exx			;5548
	cp (hl)			;5549
	exx			;554a
	ccf			;554b
	ret			;554c
L_554D:
	exx			;554d
	ld hl,0f020h		;554e
	exx			;5551
	ld c,0bah		;5552
	ld a,(0e0d2h)		;5554
	and a			;5557
	jr z,L_555C		;5558
	ld c,0f0h		;555a
L_555C:
	ld a,c			;555c
	exx			;555d
	ld (hl),a			;555e
	exx			;555f
	ret			;5560
L_5561:
	ld a,(0e690h)		;5561
	or a			;5564
	ret nz			;5565
	call L_419E		;5566
	call L_55C6		;5569
	call L_5575		;556c
	call L_5590		;556f
	jp L_416C		;5572
L_5575:
	ld a,(0e087h)		;5575
	or a			;5578
	ret z			;5579
	ld a,(0e619h)		;557a
	or a			;557d
	ret z			;557e
	ld a,(0e041h)		;557f
	cp 009h		;5582
	ret nz			;5584
	ld b,000h		;5585
	ld hl,0ef00h		;5587
L_558A:
	ld (hl),0f0h		;558a
	inc hl			;558c
	djnz L_558A		;558d
	ret			;558f
L_5590:
	ld a,(0e041h)		;5590
	cp 004h		;5593
	ret nz			;5595
	ld a,(0e0d2h)		;5596
	or a			;5599
	jr nz,L_55A1		;559a
	ld a,(0e0d4h)		;559c
	or a			;559f
	ret z			;55a0
L_55A1:
	ld hl,0f0f0h		;55a1
	ld (0efe2h),hl		;55a4
	ld hl,0ed80h		;55a7
	call L_55B0		;55aa
	ld hl,0ed9eh		;55ad
L_55B0:
	xor a			;55b0
	ld c,005h		;55b1
L_55B3:
	ld b,003h		;55b3
L_55B5:
	ld (hl),a			;55b5
	inc hl			;55b6
	ld (hl),a			;55b7
	ld de,0001fh		;55b8
	add hl,de			;55bb
	djnz L_55B5		;55bc
	ld de,00020h		;55be
	add hl,de			;55c1
	dec c			;55c2
	jr nz,L_55B3		;55c3
	ret			;55c5
L_55C6:
	call L_55F7		;55c6
	ld a,(0e615h)		;55c9
	or a			;55cc
	ret z			;55cd
	ld hl,09be2h		;55ce
	ld a,(0e041h)		;55d1
	call L_414C		;55d4
	ex de,hl			;55d7
	ld de,0ee0ch		;55d8
	ld a,(0e041h)		;55db
	cp 007h		;55de
	jr nz,L_55E5		;55e0
	ld de,0ee4ch		;55e2
L_55E5:
	exx			;55e5
	ld b,008h		;55e6
L_55E8:
	exx			;55e8
	ld bc,00008h		;55e9
	ldir		;55ec
	ld a,018h		;55ee
	call L_413B		;55f0
	exx			;55f3
	djnz L_55E8		;55f4
	ret			;55f6
L_55F7:
	ld a,(0e085h)		;55f7
	or a			;55fa
	jr nz,L_560D		;55fb
	ld hl,(0e041h)		;55fd
	ld de,00606h		;5600
	or a			;5603
	sbc hl,de		;5604
	jr nz,L_560D		;5606
	ld hl,08daeh		;5608
	jr L_5626		;560b
L_560D:
	ld a,(0e041h)		;560d
	ld hl,06abeh		;5610
	call L_414C		;5613
	ld a,(0e042h)		;5616
	dec a			;5619
	ld l,a			;561a
	ld h,000h		;561b
	add hl,hl			;561d
	add hl,hl			;561e
	add hl,hl			;561f
	ld c,l			;5620
	ld b,h			;5621
	add hl,hl			;5622
	add hl,hl			;5623
	add hl,bc			;5624
	add hl,de			;5625
L_5626:
	ld (0f000h),hl		;5626
	ld de,0ed80h		;5629
	exx			;562c
	ld de,(0f000h)		;562d
	ld c,005h		;5631
L_5633:
	ld b,008h		;5633
L_5635:
	exx			;5635
	call L_5649		;5636
	exx			;5639
	djnz L_5635		;563a
	exx			;563c
	ld bc,00060h		;563d
	ex de,hl			;5640
	add hl,bc			;5641
	ex de,hl			;5642
	exx			;5643
	dec c			;5644
	jp nz,L_5633		;5645
	ret			;5648
L_5649:
	exx			;5649
	ld a,(de)			;564a
	inc de			;564b
	exx			;564c
	ld l,a			;564d
	ld h,000h		;564e
	add hl,hl			;5650
	add hl,hl			;5651
	add hl,hl			;5652
	add hl,hl			;5653
	ld bc,06000h		;5654
	add hl,bc			;5657
	ldi		;5658
	ldi		;565a
	ldi		;565c
	ldi		;565e
	ld a,01ch		;5660
	call L_413B		;5662
	ldi		;5665
	ldi		;5667
	ldi		;5669
	ldi		;566b
	ld a,01ch		;566d
	call L_413B		;566f
	ldi		;5672
	ldi		;5674
	ldi		;5676
	ldi		;5678
	ld a,01ch		;567a
	call L_413B		;567c
	ldi		;567f
	ldi		;5681
	ldi		;5683
	ldi		;5685
	ld bc,0ffa0h		;5687
	ex de,hl			;568a
	add hl,bc			;568b
	ex de,hl			;568c
	ret			;568d
L_568E:
	call L_54DD		;568e
	call L_5E11		;5691
	call L_41B7		;5694
	call L_59E9		;5697
	call L_422B		;569a
	call L_5DC9		;569d
	push af			;56a0
	call L_4236		;56a1
	pop af			;56a4
	call nz,L_58DE		;56a5
	call L_56FA		;56a8
	call L_56D5		;56ab
	ld a,(0e0d2h)		;56ae
	or a			;56b1
	call nz,L_5856		;56b2
	call L_592F		;56b5
L_56B8:
	call L_56C7		;56b8
	call L_54E1		;56bb
	jp L_416C		;56be
L_56C1:
	call L_41B7		;56c1
	jp L_54DD		;56c4
L_56C7:
	ld hl,0ed00h		;56c7
	ld de,0ed01h		;56ca
	ld (hl),000h		;56cd
	ld bc,0007fh		;56cf
	ldir		;56d2
	ret			;56d4
L_56D5:
	ld a,(0e0d4h)		;56d5
	or a			;56d8
	jr nz,L_56E0		;56d9
	ld a,(0e0d2h)		;56db
	or a			;56de
	ret z			;56df
L_56E0:
	exx			;56e0
	ld b,003h		;56e1
	exx			;56e3
	ld hl,004e0h		;56e4
L_56E7:
	ld bc,00050h		;56e7
	xor a			;56ea
	push hl			;56eb
	call 00056h		;56ec   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;56ef
	ld bc,00800h		;56f0
	add hl,bc			;56f3
	exx			;56f4
	dec b			;56f5
	exx			;56f6
	jr nz,L_56E7		;56f7
	ret			;56f9
L_56FA:
	call L_5DE4		;56fa
	ret nz			;56fd
	ld a,(0e0d2h)		;56fe
	or a			;5701
	ret nz			;5702
	ld ix,06121h		;5703
	call L_5AB3		;5707
	ld ix,06128h		;570a
	jp L_5A8D		;570e
L_5711:
	call L_56C1		;5711
	call L_571C		;5714
	call L_5755		;5717
	jr L_56B8		;571a
L_571C:
	ld de,06edah		;571c
	ld hl,022d0h		;571f
	call L_5C0C		;5722
	ld de,07385h		;5725
	ld hl,002d0h		;5728
	call L_5C0C		;572b
	ld de,06f91h		;572e
	ld hl,02428h		;5731
	call L_5C0C		;5734
	ld de,073e5h		;5737
	ld hl,00428h		;573a
	call L_5C0C		;573d
	ld ix,06365h		;5740
	call L_5AB3		;5744
	ld a,(0e097h)		;5747
	sub 002h		;574a
	ret m			;574c
	add a,02bh		;574d
	ld hl,02788h		;574f
	jp L_58E1		;5752
L_5755:
	ld de,07831h		;5755
	ld hl,01d00h		;5758
	jp L_5C46		;575b
L_575E:
	call L_56C1		;575e
	ld ix,06139h		;5761
	call L_5AB3		;5765
	ld ix,06140h		;5768
	call L_5A8D		;576c
	jp L_56B8		;576f
L_5772:
	call L_54DD		;5772
	ld b,0e0h		;5775
	call L_4C63		;5777
	call L_5BB5		;577a
	ld ix,09a96h		;577d
	call L_5AB3		;5781
	ld ix,09a9dh		;5784
	call L_5A8D		;5788
	ld hl,01800h		;578b
	ld de,099a9h		;578e
	call L_5C46		;5791
	call L_56C7		;5794
	jp L_54E1		;5797
L_579A:
	call L_56C1		;579a
	ld ix,06000h		;579d
	call L_5AB3		;57a1
	call L_5A33		;57a4
	call L_57C4		;57a7
	ld ix,0636ch		;57aa
	call L_5AB3		;57ae
	ld ix,0637fh		;57b1
	call L_5A8D		;57b5
	ld hl,01800h		;57b8
	ld de,0beafh		;57bb
	call L_5C46		;57be
	jp L_56B8		;57c1
L_57C4:
	ld hl,02510h		;57c4
	call L_57CD		;57c7
	ld hl,00510h		;57ca
L_57CD:
	ld de,0e800h		;57cd
	ld bc,000a0h		;57d0
	push hl			;57d3
	call 00059h		;57d4   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;57d7
	ld de,0e800h		;57d8
	ld bc,000a0h		;57db
	jp L_5BD8		;57de
L_57E1:
	call L_54DD		;57e1
	call L_5E95		;57e4
	call L_41B7		;57e7
	ld ix,06390h		;57ea
	call L_5A8D		;57ee
	ld ix,0635eh		;57f1
	call L_5AB3		;57f5
	ld hl,00780h		;57f8
	ld de,0581dh		;57fb
	ld bc,00008h		;57fe
	call L_5BD8		;5801
	ld a,(0e690h)		;5804
	cp 00eh		;5807
	jr nc,L_581A		;5809
	ld hl,05824h		;580b
	call L_4155		;580e
	or a			;5811
	jr z,L_581A		;5812
	ld hl,02470h		;5814
	call L_58E1		;5817
L_581A:
	jp L_56B8		;581a

; ----------------------------------------------------------------------
; DATOS dibujo_del_caracter_f0: 8 bytes de dibujo que p00:57FB copia con
;   LDIRVM a 0x0780 en los tres tercios (el caracter 0xF0)
;   0x581d..0x5825  (8 bytes)
DATA_dibujo_del_caracter_f0:
	defb 0f0h,0a0h,0a0h,000h,0f0h,0a0h,0a0h,000h	; 581d  ........

; ----------------------------------------------------------------------
; DATOS cosa_por_0xe690: 13 bytes: la cosa que p00:580B pinta en 0x2470 (con
;   p00:58E1) segun 0xE690 = 1-13 (el 0 lee el ultimo byte del dibujo de
;   delante, que es 0, y no pinta nada)
;   0x5825..0x5832  (13 bytes)
DATA_cosa_por_0xe690:
	defb 000h,000h,000h,028h,02bh,021h,023h,029h,02ch,019h,00dh,010h,018h	; 5825  ...(+!#),....

; ======================================================================
; CODIGO 0x5832..0x5a1e  (492 bytes)
; ======================================================================


L_5832:
	call L_56C1		;5832
	ld hl,01900h		;5835
	ld de,07b34h		;5838
	call L_5C46		;583b
	ld ix,07b30h		;583e
	call L_59BF		;5842
	jp L_56B8		;5845
L_5848:
	ld a,(0e0d2h)		;5848
	or a			;584b
	ret z			;584c
	call L_56C1		;584d
	call L_5856		;5850
	jp L_56B8		;5853
L_5856:
	ld a,(0e0d3h)		;5856
	cp 002h		;5859
	jr z,L_586C		;585b
	ld hl,06157h		;585d
	call L_5AAD		;5860
	ld a,(0e0d3h)		;5863
	ld hl,06202h		;5866
	jp L_5A87		;5869
L_586C:
	ld a,001h		;586c
	ld (0e61bh),a		;586e
L_5871:
	call L_5884		;5871
	ld a,(0e61bh)		;5874
	or a			;5877
	jr nz,L_5871		;5878
	ret			;587a
L_587B:
	call L_56C1		;587b
	call L_5884		;587e
	jp L_56B8		;5881
L_5884:
	ld a,(0e61bh)		;5884
	cp 008h		;5887
	jr nc,L_58B3		;5889
	ld l,a			;588b
	ld h,000h		;588c
	ld e,l			;588e
	ld d,h			;588f
	add hl,hl			;5890
	add hl,hl			;5891
	add hl,hl			;5892
	or a			;5893
	sbc hl,de		;5894
	ex de,hl			;5896
	ld ix,06175h		;5897
	add ix,de		;589b
	call L_5AB3		;589d
	ld a,(0e61bh)		;58a0
	cp 007h		;58a3
	jr c,L_58AE		;58a5
	ld a,(0e709h)		;58a7
	bit 5,a		;58aa
	jr z,L_58CE		;58ac
L_58AE:
	ld hl,0e61bh		;58ae
	inc (hl)			;58b1
	ret			;58b2
L_58B3:
	sub 008h		;58b3
	ld l,a			;58b5
	ld h,000h		;58b6
	ld e,l			;58b8
	ld d,h			;58b9
	add hl,hl			;58ba
	add hl,hl			;58bb
	add hl,de			;58bc
	ex de,hl			;58bd
	ld ix,0621ah		;58be
	add ix,de		;58c2
	call L_5A8D		;58c4
	ld a,(0e61bh)		;58c7
	cp 02ch		;58ca
	jr c,L_58AE		;58cc
L_58CE:
	xor a			;58ce
	ld (0e61bh),a		;58cf
	ret			;58d2
L_58D3:
	call L_56C1		;58d3
	ld a,00ch		;58d6
	call L_58DE		;58d8
	jp L_56B8		;58db
L_58DE:
	ld hl,023b0h		;58de
L_58E1:
	ld (0f000h),hl		;58e1
	cp 007h		;58e4
	ret c			;58e6
	cp 02dh		;58e7
	ret nc			;58e9
	ld l,a			;58ea
	ld h,000h		;58eb
	add hl,hl			;58ed
	push hl			;58ee
	ld de,06e34h		;58ef
	add hl,de			;58f2
	ld e,(hl)			;58f3
	inc hl			;58f4
	ld d,(hl)			;58f5
	ld hl,(0f000h)		;58f6
	call L_5BFC		;58f9
	pop hl			;58fc
	ld de,06e80h		;58fd
	add hl,de			;5900
	ld e,(hl)			;5901
	inc hl			;5902
	ld d,(hl)			;5903
	ld hl,(0f000h)		;5904
	ld bc,0e000h		;5907
	add hl,bc			;590a
	jp L_5BFC		;590b
L_590E:
	call L_56C1		;590e
	call L_5937		;5911
	jp L_56B8		;5914
L_5917:
	call L_4241		;5917
	call L_54DD		;591a
	ld hl,01800h		;591d
	ld de,0bf16h		;5920
	call L_5C46		;5923
	call L_56C7		;5926
	call L_54E1		;5929
	jp L_4215		;592c
L_592F:
	call L_5937		;592f
	call L_5944		;5932
	jr L_595F		;5935
L_5937:
	ld de,0790bh		;5937
	ld ix,07907h		;593a
	call L_5C40		;593e
	jp L_59BF		;5941
L_5944:
	ld de,07849h		;5944
	ld hl,01e20h		;5947
	call L_5C46		;594a
L_594D:
	ld de,07bb2h		;594d
	ld hl,01f20h		;5950
	jp L_5C46		;5953
L_5956:
	call L_56C1		;5956
	call L_594D		;5959
	jp L_56B8		;595c
L_595F:
	ld a,(0e041h)		;595f
	or a			;5962
	ret z			;5963
	ld hl,09737h		;5964
	call L_414C		;5967
	ex de,hl			;596a
	ld a,(0e042h)		;596b
	dec a			;596e
	jr z,L_597E		;596f
	ld b,a			;5971
L_5972:
	ld a,(hl)			;5972
	inc hl			;5973
	or a			;5974
	jr z,L_597A		;5975
	jp L_5972		;5977
L_597A:
	dec b			;597a
	jp nz,L_5972		;597b
L_597E:
	ld a,(hl)			;597e
	or a			;597f
	ret z			;5980
	inc hl			;5981
	push hl			;5982
	call L_5989		;5983
	pop hl			;5986
	jr L_597E		;5987
L_5989:
	push af			;5989
	ld hl,07c72h		;598a
	call L_414C		;598d
	ex de,hl			;5990
	call L_59A6		;5991
	inc hl			;5994
	push hl			;5995
	pop ix		;5996
	call L_59BF		;5998
	pop af			;599b
	cp 039h		;599c
	ret nz			;599e
	ld ix,06365h		;599f
	jp L_5AB3		;59a3
L_59A6:
	ld a,(hl)			;59a6
	or a			;59a7
	ret z			;59a8
	inc hl			;59a9
	ld e,(hl)			;59aa
	inc hl			;59ab
	ld d,(hl)			;59ac
	inc hl			;59ad
	push hl			;59ae
	ld l,a			;59af
	ld h,000h		;59b0
	add hl,hl			;59b2
	add hl,hl			;59b3
	add hl,hl			;59b4
	ld bc,01800h		;59b5
	add hl,bc			;59b8
	call L_5C46		;59b9
	pop hl			;59bc
	jr L_59A6		;59bd
L_59BF:
	ld l,(ix+000h)		;59bf
	inc l			;59c2
	ret z			;59c3
	dec l			;59c4
	ld h,000h		;59c5
	add hl,hl			;59c7
	add hl,hl			;59c8
	add hl,hl			;59c9
	ld bc,01810h		;59ca
	add hl,bc			;59cd
	ex de,hl			;59ce
	ld l,(ix+001h)		;59cf
	ld h,000h		;59d2
	add hl,hl			;59d4
	add hl,hl			;59d5
	add hl,hl			;59d6
	ld bc,01800h		;59d7
	add hl,bc			;59da
	ld c,(ix+002h)		;59db
	call L_5C6B		;59de
	ld bc,00003h		;59e1
	add ix,bc		;59e4
	jp L_59BF		;59e6
L_59E9:
	ld ix,06000h		;59e9
	call L_5AB3		;59ed
	ld ix,06037h		;59f0
	call L_5A8D		;59f4
	ld a,(0e041h)		;59f7
	dec a			;59fa
	ret m			;59fb
	jr z,L_5A05		;59fc
	ld ix,06044h		;59fe
	jp L_5AB3		;5a02
L_5A05:
	ld a,(0e042h)		;5a05
	ld b,a			;5a08
	or a			;5a09
	rra			;5a0a
	ld hl,060d7h		;5a0b
	call L_4155		;5a0e
	bit 0,b		;5a11
	jr nz,L_5A19		;5a13
	rra			;5a15
	rra			;5a16
	rra			;5a17
	rra			;5a18
L_5A19:
	and 00fh		;5a19
	call L_4140		;5a1b

; ----------------------------------------------------------------------
; DATOS tabla_5A1E: 7 destinos del despachador de 0x4140 (call en p00:5A1B):
;   0x5A2C, 0x5A33, 0x5A3A, 0x5A48, 0x5A5D, 0x5A72, 0x5A80; lo leen p00:5A1B
;   (14 bytes)
;   0x5a1e..0x5a2c  (14 bytes)
DATA_tabla_5A1E:
	defb 02ch,05ah	; 5a1e
	defb 033h,05ah	; 5a20
	defb 03ah,05ah	; 5a22
	defb 048h,05ah	; 5a24
	defb 05dh,05ah	; 5a26
	defb 072h,05ah	; 5a28
	defb 080h,05ah	; 5a2a

; ======================================================================
; CODIGO 0x5a2c..0x5dfc  (976 bytes)
; ======================================================================


L_5A2C:
	ld ix,06069h		;5a2c
	jp L_5AB3		;5a30
L_5A33:
	ld ix,06076h		;5a33
	jp L_5AB3		;5a37
L_5A3A:
	ld ix,06083h		;5a3a
	call L_5AB3		;5a3e
	ld ix,060a8h		;5a41
	jp L_5A8D		;5a45
L_5A48:
	ld ix,06083h		;5a48
	call L_5AB3		;5a4c
	ld ix,060c9h		;5a4f
	call L_5AB3		;5a53
	ld ix,060a8h		;5a56
	jp L_5A8D		;5a5a
L_5A5D:
	ld ix,060b1h		;5a5d
	call L_5AB3		;5a61
	ld ix,060a1h		;5a64
	call L_5AB3		;5a68
	ld ix,060ach		;5a6b
	jp L_5A8D		;5a6f
L_5A72:
	ld ix,060b1h		;5a72
	call L_5AB3		;5a76
	ld ix,060ach		;5a79
	jp L_5A8D		;5a7d
L_5A80:
	ld ix,060d0h		;5a80
	jp L_5AB3		;5a84
L_5A87:
	call L_414C		;5a87
	push de			;5a8a
	pop ix		;5a8b
L_5A8D:
	ld a,(ix+000h)		;5a8d
	and a			;5a90
	ret z			;5a91
	ld l,(ix+003h)		;5a92
	ld h,000h		;5a95
	add hl,hl			;5a97
	add hl,hl			;5a98
	add hl,hl			;5a99
	ld (0e03eh),hl		;5a9a
	call L_5B66		;5a9d
	call L_5B08		;5aa0
	call L_5B1E		;5aa3
	ld de,00004h		;5aa6
	add ix,de		;5aa9
	jr L_5A8D		;5aab
L_5AAD:
	call L_414C		;5aad
	push de			;5ab0
	pop ix		;5ab1
L_5AB3:
	ld a,(ix+000h)		;5ab3
	and a			;5ab6
	ret z			;5ab7
	rra			;5ab8
	ld de,01000h		;5ab9
	call c,L_5ADA		;5abc
	bit 1,(ix+000h)		;5abf
	ld de,00800h		;5ac3
	call nz,L_5ADA		;5ac6
	bit 2,(ix+000h)		;5ac9
	ld de,00000h		;5acd
	call nz,L_5ADA		;5ad0
	ld de,00006h		;5ad3
	add ix,de		;5ad6
	jr L_5AB3		;5ad8
L_5ADA:
	ld l,(ix+003h)		;5ada
	ld h,000h		;5add
	add hl,hl			;5adf
	add hl,hl			;5ae0
	add hl,hl			;5ae1
	add hl,de			;5ae2
	push hl			;5ae3
	ld de,02000h		;5ae4
	add hl,de			;5ae7
	ld e,(ix+001h)		;5ae8
	ld d,(ix+002h)		;5aeb
	push ix		;5aee
	call L_5C46		;5af0
	pop ix		;5af3
	pop hl			;5af5
	ld de,00000h		;5af6
	add hl,de			;5af9
	ld e,(ix+004h)		;5afa
	ld d,(ix+005h)		;5afd
	push ix		;5b00
	call L_5C46		;5b02
	pop ix		;5b05
	ret			;5b07
L_5B08:
	ld hl,0ed00h		;5b08
	ld de,(0e03eh)		;5b0b
L_5B0F:
	ld b,008h		;5b0f
L_5B11:
	rr (hl)		;5b11
	adc a,a			;5b13
	djnz L_5B11		;5b14
	ld (hl),a			;5b16
	inc hl			;5b17
	dec de			;5b18
	ld a,d			;5b19
	or e			;5b1a
	jr nz,L_5B0F		;5b1b
	ret			;5b1d
L_5B1E:
	bit 3,(ix+002h)		;5b1e
	ld de,01000h		;5b22
	call nz,L_5B3A		;5b25
	bit 4,(ix+002h)		;5b28
	ld de,00800h		;5b2c
	call nz,L_5B3A		;5b2f
	bit 5,(ix+002h)		;5b32
	ld de,00000h		;5b36
	ret z			;5b39
L_5B3A:
	push ix		;5b3a
	ld l,(ix+001h)		;5b3c
	ld h,000h		;5b3f
	add hl,hl			;5b41
	add hl,hl			;5b42
	add hl,hl			;5b43
	add hl,de			;5b44
	push hl			;5b45
	ld de,02000h		;5b46
	add hl,de			;5b49
	ld de,0ed00h		;5b4a
	ld bc,(0e03eh)		;5b4d
	call L_5BD4		;5b51
	pop hl			;5b54
	ld de,00000h		;5b55
	add hl,de			;5b58
	ld de,0ed40h		;5b59
	ld bc,(0e03eh)		;5b5c
	call L_5BD4		;5b60
	pop ix		;5b63
	ret			;5b65
L_5B66:
	ld bc,(0e03eh)		;5b66
	ld l,(ix+000h)		;5b6a
	ld h,000h		;5b6d
	add hl,hl			;5b6f
	add hl,hl			;5b70
	add hl,hl			;5b71
	push hl			;5b72
	ld de,02000h		;5b73
	bit 2,(ix+002h)		;5b76
	jr nz,L_5B86		;5b7a
	ld d,028h		;5b7c
	bit 1,(ix+002h)		;5b7e
	jr nz,L_5B86		;5b82
	ld d,030h		;5b84
L_5B86:
	add hl,de			;5b86
	ld de,0ed00h		;5b87
	push ix		;5b8a
	call 00059h		;5b8c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;5b8f
	pop hl			;5b91
	ld de,00000h		;5b92
	bit 2,(ix+002h)		;5b95
	jr nz,L_5BA5		;5b99
	ld d,008h		;5b9b
	bit 1,(ix+002h)		;5b9d
	jr nz,L_5BA5		;5ba1
	ld d,010h		;5ba3
L_5BA5:
	add hl,de			;5ba5
	ld de,0ed40h		;5ba6
	ld bc,(0e03eh)		;5ba9
	push ix		;5bad
	call 00059h		;5baf   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;5bb2
	ret			;5bb4
L_5BB5:
	call L_4D38		;5bb5
	call L_54DD		;5bb8
	ld hl,03800h		;5bbb
	ld bc,00300h		;5bbe
	xor a			;5bc1
	call 00056h		;5bc2   ; BIOS FILVRM - Fills VRAM with value
	jp L_54E1		;5bc5
L_5BC8:
	ex af,af'			;5bc8
	call 00053h		;5bc9   ; BIOS SETWRT - Enables VDP to write
	exx			;5bcc
	ld a,(00007h)		;5bcd
	ld c,a			;5bd0
	exx			;5bd1
	ex af,af'			;5bd2
	ret			;5bd3
L_5BD4:
	ex de,hl			;5bd4
	jp 0005ch		;5bd5   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_5BD8:
	exx			;5bd8
	ld b,003h		;5bd9
L_5BDB:
	exx			;5bdb
	push bc			;5bdc
	push de			;5bdd
	call L_5BD4		;5bde
	ld de,00800h		;5be1
	add hl,de			;5be4
	pop de			;5be5
	pop bc			;5be6
	exx			;5be7
	djnz L_5BDB		;5be8
	ret			;5bea
L_5BEB:
	ld d,003h		;5beb
L_5BED:
	push bc			;5bed
	push de			;5bee
	call 00056h		;5bef   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;5bf2
	add hl,de			;5bf5
	pop de			;5bf6
	pop bc			;5bf7
	dec d			;5bf8
	jr nz,L_5BED		;5bf9
	ret			;5bfb
L_5BFC:
	ld b,003h		;5bfc
L_5BFE:
	push bc			;5bfe
	push de			;5bff
	call L_5C46		;5c00
	ld de,00800h		;5c03
	add hl,de			;5c06
	pop de			;5c07
	pop bc			;5c08
	djnz L_5BFE		;5c09
	ret			;5c0b
L_5C0C:
	ld b,003h		;5c0c
L_5C0E:
	push bc			;5c0e
	push de			;5c0f
	call L_5C46		;5c10
	inc de			;5c13
L_5C14:
	call L_5C49		;5c14
	inc de			;5c17
	ld a,(de)			;5c18
	or a			;5c19
	jr nz,L_5C14		;5c1a
	ld de,00800h		;5c1c
	add hl,de			;5c1f
	pop de			;5c20
	pop bc			;5c21
	djnz L_5C0E		;5c22
	ret			;5c24
L_5C25:
	ld c,0ffh		;5c25
L_5C27:
	ex de,hl			;5c27
	ld e,(hl)			;5c28
	inc hl			;5c29
	ld d,(hl)			;5c2a
	ex de,hl			;5c2b
	inc de			;5c2c
L_5C2D:
	ld a,(de)			;5c2d
	inc de			;5c2e
	ld b,a			;5c2f
	inc b			;5c30
	ret z			;5c31
	inc b			;5c32
	jr z,L_5C27		;5c33
	and c			;5c35
	call 0004dh		;5c36   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;5c39
	jr L_5C2D		;5c3a
L_5C3C:
	ld c,000h		;5c3c
	jr L_5C27		;5c3e
L_5C40:
	ex de,hl			;5c40
	ld e,(hl)			;5c41
	inc hl			;5c42
	ld d,(hl)			;5c43
	ex de,hl			;5c44
	inc de			;5c45
L_5C46:
	call L_5BC8		;5c46
L_5C49:
	ld a,(de)			;5c49
	and a			;5c4a
	ret z			;5c4b
	inc de			;5c4c
	ld b,a			;5c4d
	and 07fh		;5c4e
	cp b			;5c50
	jr z,L_5C61		;5c51
	and a			;5c53
	jr z,L_5C40		;5c54
	ld b,a			;5c56
L_5C57:
	ld a,(de)			;5c57
	inc de			;5c58
	exx			;5c59
	out (c),a		;5c5a
	exx			;5c5c
	djnz L_5C57		;5c5d
	jr L_5C49		;5c5f
L_5C61:
	ld a,(de)			;5c61
	inc de			;5c62
L_5C63:
	exx			;5c63
	out (c),a		;5c64
	exx			;5c66
	djnz L_5C63		;5c67
	jr L_5C49		;5c69
L_5C6B:
	call L_5C77		;5c6b
	ld a,020h		;5c6e
	call L_413B		;5c70
	dec c			;5c73
	jr nz,L_5C6B		;5c74
	ret			;5c76
L_5C77:
	push de			;5c77
L_5C78:
	ld b,010h		;5c78
L_5C7A:
	call 0004ah		;5c7a   ; BIOS RDVRM - Reads the content of VRAM
	call L_5C93		;5c7d
	ex de,hl			;5c80
	call 0004dh		;5c81   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;5c84
	inc e			;5c85
	inc hl			;5c86
	djnz L_5C7A		;5c87
	ld a,e			;5c89
	sub 020h		;5c8a
	ld e,a			;5c8c
	bit 4,e		;5c8d
	jr z,L_5C78		;5c8f
	pop de			;5c91
	ret			;5c92
L_5C93:
	push bc			;5c93
	ld c,a			;5c94
	ld b,008h		;5c95
L_5C97:
	rr c		;5c97
	rla			;5c99
	djnz L_5C97		;5c9a
	pop bc			;5c9c
	ret			;5c9d
L_5C9E:
	ld a,(0e01dh)		;5c9e
	or a			;5ca1
	ret z			;5ca2
	call L_50F5		;5ca3
	ret nz			;5ca6
	di			;5ca7
	ld hl,0e01eh		;5ca8
	ld a,(hl)			;5cab
	dec l			;5cac
	ld (hl),000h		;5cad
L_5CAF:
	di			;5caf
	ld hl,0e021h		;5cb0
	ld (hl),000h		;5cb3
	ld b,a			;5cb5
	sub 087h		;5cb6
	cp 005h		;5cb8
	ld a,b			;5cba
	jr c,L_5CBF		;5cbb
	ld (hl),001h		;5cbd
L_5CBF:
	call L_4E1F		;5cbf
	ei			;5cc2
	ret			;5cc3
L_5CC4:
	call L_5CC9		;5cc4
	jr L_5CAF		;5cc7
L_5CC9:
	ld hl,00000h		;5cc9
	ld (0e01dh),hl		;5ccc
	ret			;5ccf
L_5CD0:
	call L_5CE0		;5cd0
	ret c			;5cd3
	call L_5CF6		;5cd4
	ld a,(0e615h)		;5cd7
	or a			;5cda
	ret z			;5cdb
	ld a,08fh		;5cdc
	jr L_5D0A		;5cde
L_5CE0:
	ld a,(0e0d4h)		;5ce0
	or a			;5ce3
	jr nz,L_5CEF		;5ce4
	ld a,(0e0d2h)		;5ce6
	or a			;5ce9
	ret z			;5cea
	ld a,090h		;5ceb
	jr L_5CF1		;5ced
L_5CEF:
	ld a,091h		;5cef
L_5CF1:
	call L_5CC4		;5cf1
	scf			;5cf4
	ret			;5cf5
L_5CF6:
	ld hl,(0e01dh)		;5cf6
	dec l			;5cf9
	jr nz,L_5D02		;5cfa
	ld a,h			;5cfc
	cp 08fh		;5cfd
	jr z,L_5D07		;5cff
	ret			;5d01
L_5D02:
	ld a,(0e021h)		;5d02
	or a			;5d05
	ret z			;5d06
L_5D07:
	call L_5D1A		;5d07
L_5D0A:
	di			;5d0a
	push af			;5d0b
	ld a,0fah		;5d0c
	call L_4E1F		;5d0e
	pop af			;5d11
L_5D12:
	ld h,a			;5d12
	ld l,001h		;5d13
	ld (0e01dh),hl		;5d15
	ei			;5d18
	ret			;5d19
L_5D1A:
	ld a,(0e041h)		;5d1a
	dec a			;5d1d
	ld a,088h		;5d1e
	ret z			;5d20
	ld a,08ah		;5d21
	ret			;5d23
L_5D24:
	ld a,(0e083h)		;5d24
	or a			;5d27
	ret z			;5d28
	ld a,(0e041h)		;5d29
	dec a			;5d2c
	ret nz			;5d2d
	call L_422B		;5d2e
	call L_5D37		;5d31
	jp L_4215		;5d34
L_5D37:
	ld hl,0e06ch		;5d37
	bit 1,(hl)		;5d3a
	jr z,L_5D46		;5d3c
	ld a,(0e06eh)		;5d3e
	ld hl,0be63h		;5d41
	jr L_5D55		;5d44
L_5D46:
	ld b,009h		;5d46
	dec l			;5d48
L_5D49:
	bit 1,(hl)		;5d49
	jr nz,L_5D51		;5d4b
	dec l			;5d4d
	djnz L_5D49		;5d4e
	ret			;5d50
L_5D51:
	ld hl,0be4fh		;5d51
	ld a,b			;5d54
L_5D55:
	call L_414C		;5d55
	ld a,(0e042h)		;5d58
	ld b,a			;5d5b
L_5D5C:
	ld a,(de)			;5d5c
	or a			;5d5d
	ret z			;5d5e
	inc de			;5d5f
	cp b			;5d60
	jr nz,L_5D5C		;5d61
	ld a,028h		;5d63
	jp L_4E1F		;5d65
L_5D68:
	ld hl,(0e60eh)		;5d68
	bit 0,(hl)		;5d6b
	ret nz			;5d6d
	call L_5DC9		;5d6e
	ret z			;5d71
	ld c,a			;5d72
	ld b,(hl)			;5d73
	inc hl			;5d74
	ld a,(hl)			;5d75
	and 0f8h		;5d76
	ld d,a			;5d78
	ld a,(hl)			;5d79
	and 007h		;5d7a
	rl b		;5d7c
	rla			;5d7e
	rl b		;5d7f
	rla			;5d81
	rla			;5d82
	rla			;5d83
	rla			;5d84
	and 0f8h		;5d85
	ld e,a			;5d87
L_5D88:
	ld a,d			;5d88
	or e			;5d89
	ret z			;5d8a
	ld a,c			;5d8b
	cp 02dh		;5d8c
	jr nc,L_5DAB		;5d8e
	ld b,000h		;5d90
	ld hl,0e06fh		;5d92
	add hl,bc			;5d95
	ld a,(hl)			;5d96
	or a			;5d97
	ret nz			;5d98
	ld a,c			;5d99
	cp 00ch		;5d9a
	jr nz,L_5DAB		;5d9c
	ld a,(0e041h)		;5d9e
	ld hl,0e062h		;5da1
	call L_4136		;5da4
	ld a,(hl)			;5da7
	and 003h		;5da8
	ret nz			;5daa
L_5DAB:
	ld hl,0e740h		;5dab
	ld a,(hl)			;5dae
	or a			;5daf
	ret nz			;5db0
	ld (hl),c			;5db1
	inc l			;5db2
	inc l			;5db3
	ld a,c			;5db4
	cp 007h		;5db5
	jr nc,L_5DBD		;5db7
	ld a,d			;5db9
	add a,008h		;5dba
	ld d,a			;5dbc
L_5DBD:
	ld (hl),d			;5dbd
	inc l			;5dbe
	ld (hl),e			;5dbf
	ld h,e			;5dc0
	ld l,d			;5dc1
	call L_4DA1		;5dc2
	ld (0e744h),hl		;5dc5
	ret			;5dc8
L_5DC9:
	ld bc,(0e041h)		;5dc9
	ld a,c			;5dcd
	ld hl,0b6fch		;5dce
	call L_414C		;5dd1
	ex de,hl			;5dd4
L_5DD5:
	ld a,(hl)			;5dd5
	or a			;5dd6
	ret z			;5dd7
	inc hl			;5dd8
	cp b			;5dd9
	jr nz,L_5DE0		;5dda
	ld a,(hl)			;5ddc
	and 03fh		;5ddd
	ret			;5ddf
L_5DE0:
	inc hl			;5de0
	inc hl			;5de1
	jr L_5DD5		;5de2
L_5DE4:
	ld a,(0e041h)		;5de4
	ld hl,0e061h		;5de7
	call L_4136		;5dea
	bit 2,(hl)		;5ded
	ret nz			;5def
	ld hl,(0e041h)		;5df0
	ld a,h			;5df3
	ld h,000h		;5df4
	ld de,l5dfbh		;5df6
	add hl,de			;5df9
	cp (hl)			;5dfa
L_5DFB:
	ret			;5dfb

; ----------------------------------------------------------------------
; DATOS sala_del_jefe: la sala del jefe de cada mapa, un byte por mapa 1-10
;   (p00:5DE4 la compara con 0xE042 leyendo 0x5DFB + mapa; el byte del mapa 0
;   es el `ret` de 0x5DFB): 0 el castillo, y 13, 9, 13, 14, 17, 13, 10, 7 y 25
;   en los mundos 1-9; el del mapa 11 es el primer byte de la tabla siguiente
;   (5)
;   0x5dfc..0x5e06  (10 bytes)
DATA_sala_del_jefe:
	defb 000h,00dh,009h,00dh,00eh,011h,00dh,00ah,007h,019h	; 5dfc  ..........

; ----------------------------------------------------------------------
; DATOS fichas_de_cada_mapa: el juego de fichas de cada mapa 1-11 (5, 1, 4, 2,
;   11, 10, 3, 7, 8, 6, 9) que p00:497C copia a 0xE0D3 leyendo 0x5E05 + mapa;
;   0xE0D3 elige las fichas de las tablas 0x6157 y 0x6202 del banco 10
;   (p00:5856)
;   0x5e06..0x5e11  (11 bytes)
DATA_fichas_de_cada_mapa:
	defb 005h,001h,004h,002h,00bh,00ah,003h,007h,008h,006h,009h	; 5e06  ...........

; ======================================================================
; CODIGO 0x5e11..0x5f59  (328 bytes)
; ======================================================================


L_5E11:
	call L_41D0		;5e11
	ld de,09ad3h		;5e14
	ld hl,02008h		;5e17
	call L_5BFC		;5e1a
	ld de,09b24h		;5e1d
	ld hl,02058h		;5e20
	call L_5BFC		;5e23
	ld a,0f0h		;5e26
	ld hl,00008h		;5e28
	ld bc,00120h		;5e2b
	call L_5BEB		;5e2e
	jp L_416C		;5e31
L_5E34:
	call L_41D0		;5e34
	call L_5EAF		;5e37
	ld de,09ad3h		;5e3a
	ld hl,02080h		;5e3d
	call L_5BFC		;5e40
	ld de,09aa2h		;5e43
	ld hl,020d0h		;5e46
	call L_5BFC		;5e49
	ld de,09acch		;5e4c
	ld hl,02100h		;5e4f
	call L_5BFC		;5e52
	ld de,09b24h		;5e55
	ld hl,02108h		;5e58
	call L_5BFC		;5e5b
	ld a,0f0h		;5e5e
	ld hl,00080h		;5e60
	ld bc,00158h		;5e63
	call L_5BEB		;5e66
	jp L_416C		;5e69
L_5E6C:
	call L_41D0		;5e6c
	ld de,09aa2h		;5e6f
	ld hl,02160h		;5e72
	call L_5BFC		;5e75
	jp L_416C		;5e78
L_5E7B:
	call L_41D0		;5e7b
	ld de,09abdh		;5e7e
	ld hl,02168h		;5e81
	call L_5BFC		;5e84
	ld a,0f0h		;5e87
	ld hl,00168h		;5e89
	ld bc,00010h		;5e8c
	call L_5BEB		;5e8f
	jp L_416C		;5e92
L_5E95:
	call L_41D0		;5e95
	ld de,09bech		;5e98
	ld hl,025d0h		;5e9b
	call L_5BFC		;5e9e
	ld a,0f0h		;5ea1
	ld hl,005d0h		;5ea3
	ld bc,001b0h		;5ea6
	call L_5BEB		;5ea9
	jp L_416C		;5eac
L_5EAF:
	ld hl,02000h		;5eaf
	ld bc,00080h		;5eb2
	xor a			;5eb5
	call L_5BEB		;5eb6
	ld hl,00000h		;5eb9
	ld de,00008h		;5ebc
	ld b,010h		;5ebf
L_5EC1:
	push bc			;5ec1
	ld bc,00008h		;5ec2
	push hl			;5ec5
	call L_5BEB		;5ec6
	pop hl			;5ec9
	add hl,de			;5eca
	inc a			;5ecb
	pop bc			;5ecc
	djnz L_5EC1		;5ecd
	ret			;5ecf
L_5ED0:
	xor a			;5ed0
	ld (0f0f8h),a		;5ed1
	ld bc,00400h		;5ed4
	ld hl,0fcc1h		;5ed7
L_5EDA:
	push bc			;5eda
	push hl			;5edb
	ld a,(hl)			;5edc
	bit 7,a		;5edd
	jr nz,L_5EF0		;5edf
	call L_5F0C		;5ee1
L_5EE4:
	pop hl			;5ee4
	pop bc			;5ee5
	ld a,(0f0f8h)		;5ee6
	and a			;5ee9
	ret nz			;5eea
	inc hl			;5eeb
	inc c			;5eec
	djnz L_5EDA		;5eed
	ret			;5eef
L_5EF0:
	call L_5EF5		;5ef0
	jr L_5EE4		;5ef3
L_5EF5:
	and 080h		;5ef5
	or c			;5ef7
	ld c,a			;5ef8
	ld b,004h		;5ef9
L_5EFB:
	push bc			;5efb
	call L_5F0C		;5efc
	pop bc			;5eff
	ld a,(0f0f8h)		;5f00
	and a			;5f03
	ret nz			;5f04
	ld a,c			;5f05
	add a,004h		;5f06
	ld c,a			;5f08
	djnz L_5EFB		;5f09
	ret			;5f0b
L_5F0C:
	ld de,05f59h		;5f0c
	ld hl,07ffah		;5f0f
	ld b,006h		;5f12
	call L_5F44		;5f14
	jr nc,L_5F1F		;5f17
	ld hl,0f0f8h		;5f19
	set 2,(hl)		;5f1c
	ret			;5f1e
L_5F1F:
	ld de,05f65h		;5f1f
	ld hl,0bffah		;5f22
	ld b,006h		;5f25
	call L_5F44		;5f27
	jr nc,L_5F32		;5f2a
	ld hl,0f0f8h		;5f2c
	set 1,(hl)		;5f2f
	ret			;5f31
L_5F32:
	ld de,05f5fh		;5f32
	ld hl,0bffah		;5f35
	ld b,006h		;5f38
	call L_5F44		;5f3a
	ret nc			;5f3d
	ld hl,0f0f8h		;5f3e
	set 0,(hl)		;5f41
	ret			;5f43
L_5F44:
	push bc			;5f44
	push de			;5f45
	ld a,c			;5f46
	call 0000ch		;5f47   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;5f4a
	pop bc			;5f4b
	ex de,hl			;5f4c
	cp (hl)			;5f4d
	ex de,hl			;5f4e
	jr nz,L_5F57		;5f4f
	inc hl			;5f51
	inc de			;5f52
	djnz L_5F44		;5f53
	scf			;5f55
	ret			;5f56
L_5F57:
	and a			;5f57
	ret			;5f58

; ----------------------------------------------------------------------
; DATOS firma_game_master: 6 bytes que p00:5F0C compara con los de 0x7FFA de
;   las otras ranuras (p00:5F44, RDSLT): son los ultimos de Konami's Game
;   Master (RC-735). Si estan, bit 2 de 0xF0F8
;   0x5f59..0x5f5f  (6 bytes)
DATA_firma_game_master:
	defb 000h,030h,031h,013h,035h,0aah	; 5f59

; ----------------------------------------------------------------------
; DATOS firma_knightmare: 6 bytes que p00:5F32 compara con los de 0xBFFA: los
;   ultimos de Knightmare (Majyo Densetsu, RC-739). Si estan, bit 0 de 0xF0F8
;   0x5f5f..0x5f65  (6 bytes)
DATA_firma_knightmare:
	defb 0b7h,08bh,09eh,00ah,039h,0aah	; 5f5f

; ----------------------------------------------------------------------
; DATOS firma_qbert: 6 bytes que p00:5F1F compara con los de 0xBFFA: los
;   ultimos de Q*bert (RC-746). Si estan, bit 1 de 0xF0F8
;   0x5f65..0x5f6b  (6 bytes)
DATA_firma_qbert:
	defb 0bah,0b2h,086h,007h,046h,0aah	; 5f65

; ----------------------------------------------------------------------
; DATOS iconos_de_arma: 7 parejas de caracteres, una por 0xE510 = 0-6, que
;   p01:6076 y p01:67C7 pintan (la 0 son dos ceros)
;   0x5f6b..0x5f79  (14 bytes)
DATA_iconos_de_arma:
	defb 000h,000h	; 5f6b
	defb 044h,045h	; 5f6d
	defb 046h,047h	; 5f6f
	defb 04eh,000h	; 5f71
	defb 04fh,000h	; 5f73
	defb 050h,051h	; 5f75
	defb 052h,053h	; 5f77

; ======================================================================
; CODIGO 0x5f79..0x5fba  (65 bytes)
; ======================================================================


L_5F79:
	ld de,0e047h		;5f79
	ld hl,03818h		;5f7c
	ld b,002h		;5f7f
	jp L_4D95		;5f81
L_5F84:
	ld de,0e049h		;5f84
	ld hl,03838h		;5f87
	ld b,002h		;5f8a
	jp L_4D95		;5f8c
L_5F8F:
	ld de,0e04bh		;5f8f
	ld hl,03858h		;5f92
	ld b,002h		;5f95
	jp L_4D95		;5f97
L_5F9A:
	ld a,(0e500h)		;5f9a
	cp 007h		;5f9d
	ret nz			;5f9f
	xor a			;5fa0
	ld (0e500h),a		;5fa1
	ld (0e518h),a		;5fa4
	ret			;5fa7
L_5FA8:
	ld a,(0e042h)		;5fa8
	cp 092h		;5fab
	ret nz			;5fad
	ld de,0e4a1h		;5fae
	ld hl,05fbah		;5fb1
	ld bc,00009h		;5fb4
	ldir		;5fb7
	ret			;5fb9

; ----------------------------------------------------------------------
; DATOS ficha_sala_92: 9 bytes que p00:5FB1 copia a 0xE4A1 cuando la sala es
;   la 0x92 (146)
;   0x5fba..0x5fc3  (9 bytes)
DATA_ficha_sala_92:
	defb 092h,082h,006h,000h,040h,000h,070h,000h,0feh	; 5fba  ....@.p..

; ======================================================================
; CODIGO 0x5fc3..0x5fff  (60 bytes)
; ======================================================================


L_5FC3:
	ld a,(0e01fh)		;5fc3
	dec a			;5fc6
	jr z,$+60		;5fc7
	dec a			;5fc9
	jr z,$+75		;5fca
	ld a,(0e01ah)		;5fcc
	dec a			;5fcf
	jr z,L_5FDC		;5fd0
	dec a			;5fd2
	jr z,L_5FE0		;5fd3
	dec a			;5fd5
	jr z,L_5FF9		;5fd6
	dec a			;5fd8
	jr z,L_5FFD		;5fd9
	ret			;5fdb
L_5FDC:
	ld a,0b9h		;5fdc
	jr L_5FE2		;5fde
L_5FE0:
	ld a,028h		;5fe0
L_5FE2:
	ld (0e505h),a		;5fe2
	ld hl,0ec12h		;5fe5
	bit 0,(hl)		;5fe8
	ret z			;5fea
	ld de,00006h		;5feb
	add hl,de			;5fee
	ld e,(hl)			;5fef
	ld d,(hl)			;5ff0
	ld h,a			;5ff1
	ld l,000h		;5ff2
	add hl,de			;5ff4
	ld (0e505h),hl		;5ff5
	ret			;5ff8
L_5FF9:
	ld a,0f7h		;5ff9
	jr $+4		;5ffb
L_5FFD:
	ld a,010h		;5ffd

; ----------------------------------------------------------------------
; DATOS partida_5FFF: la instruccion de p00:5FFF (32 | 07 E5) empieza al final
;   del banco 0 y acaba al principio del 1, que el cartucho pone siempre a
;   continuacion: aqui el primer byte; lo leen p00:5FFF (1 bytes)
;   0x5fff..0x6000  (1 bytes)
L_5FFF:
	defb 032h	; 5fff
