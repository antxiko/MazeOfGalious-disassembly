; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 13 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ======================================================================
; CODIGO 0x6000..0x60ec  (236 bytes)
; ======================================================================


L_6000:
	ld a,00ah		;6000   ; apagandose rapido: 0x0A
	jr L_6049		;6002
sonido_cada_cuadro:		; cada cuadro: el mezclador, el apagado y los cuatro canales
	ld a,(0e1b1h)		;6004   ; cada cuadro: el mezclador (registro 7) desde 0xE1B1...
	ld e,a			;6007
	ld a,007h		;6008
	call 00093h		;600a   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0e1b2h)		;600d   ; ...en la pausa (bit 0 de 0xE1B2), solo su programa...
	bit 0,a		;6010
	jp nz,L_6099		;6012
	bit 1,a		;6015   ; ...con el 0xFB (bit 1), su canal...
	jp nz,L_609D		;6017
	ld a,(0e1c0h)		;601a   ; ...apagandose (0xE1C0): cada paso...
	dec a			;601d
	jp m,L_604C		;601e
	jp nz,L_6049		;6021
	ld a,(0e1c1h)		;6024   ; ...el volumen general (0xE1C1) baja...
	dec a			;6027
	ld (0e1c1h),a		;6028   ; guarda el volumen general (baja al apagarse)
	cp 0f0h		;602b   ; ...a -16, los tres canales callados
	jp nz,L_6040		;602d
	ld hl,canal_vacio		;6030
	ld (0e100h),hl		;6033   ; guarda los programas de los cuatro canales de sonido (0xE100-0xE107) y el byte siguiente (16 bits)
	ld (0e102h),hl		;6036
	ld (0e104h),hl		;6039
	xor a			;603c
	jp L_6049		;603d
L_6040:
	ld a,(0e1c4h)		;6040   ; la espera entre pasos: 0x0A (0xFA) o 0x30 (0xFF)
	cp 0fah		;6043
	jr z,L_6000		;6045
	ld a,030h		;6047
L_6049:
	ld (0e1c0h),a		;6049   ; guarda apagandose: la espera entre pasos
L_604C:
	xor a			;604c   ; los tres canales de musica (A, B, C)...
	ld b,a			;604d
	ld hl,(0e100h)		;604e   ; lee los programas de los cuatro canales de sonido (0xE100-0xE107) y el byte siguiente (16 bits)
	call toca_canal		;6051   ; toca_canal: el canal A y el programa B: salta a su programa HL
	ld a,001h		;6054
	ld b,a			;6056
	ld hl,(0e102h)		;6057
	call toca_canal		;605a   ; toca_canal: el canal A y el programa B: salta a su programa HL
	ld a,002h		;605d
	ld b,a			;605f
	ld hl,(0e104h)		;6060
L_6063:
	call toca_canal		;6063   ; ...y el de efectos, en el C
	ld a,002h		;6066
	ld b,003h		;6068
	ld hl,(0e106h)		;606a
toca_canal:		; el canal A y el programa B: salta a su programa HL
	ld (0e1aeh),a		;606d   ; el canal (0xE1AE) y el programa (0xE1AF)
	ld a,b			;6070
	ld (0e1afh),a		;6071   ; guarda el programa que se toca (0-3)
	jp (hl)			;6074
canal_vacio:		; el programa vacio: calla el canal
	ld a,(0e1afh)		;6075   ; el programa vacio: con el de efectos acabado, sin efecto (0xE1B0)...
	cp 003h		;6078
	jp nz,L_6084		;607a
	xor a			;607d
	ld (0e1b0h),a		;607e   ; guarda el efecto que suena
	ld a,(0e1afh)		;6081   ; lee el programa que se toca (0-3)
L_6084:
	rlca			;6084   ; ...su programa pasa a ser un ret...
	ld hl,0e100h		;6085   ; apunta a los programas de los cuatro canales de sonido (0xE100-0xE107)
	add a,l			;6088
	ld l,a			;6089
	jr nc,L_608D		;608a
	inc h			;608c
L_608D:
	ld de,L_6098		;608d
	ld (hl),e			;6090
	inc hl			;6091
	ld (hl),d			;6092
	ld e,000h		;6093   ; ...y su volumen a 0
	jp volumen		;6095   ; volumen: el volumen E del canal
L_6098:
	ret			;6098
L_6099:
	ld hl,(0e10ah)		;6099   ; la pausa: su programa (0xE10A)
	jp (hl)			;609c
L_609D:
	xor a			;609d   ; el 0xFB: su canal 0xE108 como cuarto
	ld b,004h		;609e
	ld hl,(0e108h)		;60a0
	jp L_6063		;60a3
periodo:		; el periodo D, E en los registros del canal
	ld a,(0e1aeh)		;60a6   ; el periodo D, E en los registros del canal
	rlca			;60a9
	call 00093h		;60aa   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;60ad
	ld e,d			;60ae
	jp 00093h		;60af   ; BIOS WRTPSG - Writes data to PSG-register
volumen:		; el volumen E del canal
	ld a,(0e1aeh)		;60b2   ; el volumen E (registro 8 + canal)
	add a,008h		;60b5
	jp 00093h		;60b7   ; BIOS WRTPSG - Writes data to PSG-register
mezcla_ruido:		; el canal con ruido y sin tono
	push hl			;60ba   ; el mezclador: el canal con ruido y sin tono...
	ld hl,060feh		;60bb
	jp mezcla		;60be   ; mezcla: el registro 7 con la mascara del canal de la tabla HL
mezcla_los_dos:		; el canal con tono y ruido
	push hl			;60c1   ; ...con los dos...
	ld hl,060f8h		;60c2
	jp mezcla		;60c5   ; mezcla: el registro 7 con la mascara del canal de la tabla HL
mezcla_nada:		; el canal sin tono ni ruido
	push hl			;60c8   ; ...sin ninguno...
	ld hl,060f2h		;60c9
	jp mezcla		;60cc   ; mezcla: el registro 7 con la mascara del canal de la tabla HL
mezcla_tono:		; el canal con tono y sin ruido
	push hl			;60cf   ; ...con tono y sin ruido
	ld hl,060ech		;60d0
mezcla:		; el registro 7 con la mascara del canal de la tabla HL
	ld a,(0e1aeh)		;60d3   ; la mascara del canal (AND) y lo que se pone (OR)...
	rlca			;60d6
	add a,l			;60d7
	ld l,a			;60d8
	jr nc,L_60DC		;60d9
	inc h			;60db
L_60DC:
	ld a,(0e1b1h)		;60dc   ; lee la copia del mezclador del PSG (registro 7)
	and (hl)			;60df
	inc hl			;60e0
	or (hl)			;60e1
	ld (0e1b1h),a		;60e2   ; ...al registro 7
	pop hl			;60e5
	ld e,a			;60e6
	ld a,007h		;60e7
	jp 00093h		;60e9   ; BIOS WRTPSG - Writes data to PSG-register

; ----------------------------------------------------------------------
; DATOS mezclador_0: tres parejas [and][or], una por canal (0xE1AE), para el
;   registro 7 del PSG (p13:60DF); la pide p13:60CF; lo leen p13:60DF (6
;   bytes)
;   0x60ec..0x60f2  (6 bytes)
DATA_mezclador_0:
	defb 0feh,008h	; 60ec
	defb 0fdh,010h	; 60ee
	defb 0fbh,020h	; 60f0

; ----------------------------------------------------------------------
; DATOS mezclador_1: tres parejas [and][or], una por canal (0xE1AE), para el
;   registro 7 del PSG (p13:60DF); la pide p13:60C8; lo leen p13:60DF (6
;   bytes)
;   0x60f2..0x60f8  (6 bytes)
DATA_mezclador_1:
	defb 0f7h,001h	; 60f2
	defb 0efh,002h	; 60f4
	defb 0dfh,004h	; 60f6

; ----------------------------------------------------------------------
; DATOS mezclador_2: tres parejas [and][or], una por canal (0xE1AE), para el
;   registro 7 del PSG (p13:60DF); la pide p13:60C1; lo leen p13:60DF (6
;   bytes)
;   0x60f8..0x60fe  (6 bytes)
DATA_mezclador_2:
	defb 0f6h,000h	; 60f8
	defb 0edh,000h	; 60fa
	defb 0dbh,000h	; 60fc

; ----------------------------------------------------------------------
; DATOS mezclador_3: tres parejas [and][or], una por canal (0xE1AE), para el
;   registro 7 del PSG (p13:60DF); la pide p13:60BA; lo leen p13:60DF (6
;   bytes)
;   0x60fe..0x6104  (6 bytes)
DATA_mezclador_3:
	defb 0ffh,009h	; 60fe
	defb 0ffh,012h	; 6100
	defb 0ffh,024h	; 6102

; ======================================================================
; CODIGO 0x6104..0x62d0  (460 bytes)
; ======================================================================


canal_de_pausa:		; el canal de la pausa (0xE193)
	ld ix,0e193h		;6104   ; los canales: el de la pausa (0xE193)...
	jp canal		;6108   ; canal: un canal: la nota que suena o la siguiente de la partitura
canal_a:		; el canal A de la musica (0xE10C)
	ld ix,0e10ch		;610b   ; ...A (0xE10C)...
	jp canal		;610f   ; canal: un canal: la nota que suena o la siguiente de la partitura
canal_b:		; el canal B (0xE127)
	ld ix,0e127h		;6112   ; ...B (0xE127)...
	jp canal		;6116   ; canal: un canal: la nota que suena o la siguiente de la partitura
canal_c:		; el canal C (0xE142)
	ld ix,0e142h		;6119   ; ...C (0xE142)
canal:		; un canal: la nota que suena o la siguiente de la partitura
	ld a,(0e1afh)		;611d   ; el canal C con un efecto sonando se calla (bit 5)
	cp 002h		;6120
	jp nz,L_6130		;6122
	ld a,(0e1b0h)		;6125   ; lee el efecto que suena
	or a			;6128
	jp z,L_6130		;6129
	set 5,(ix+002h)		;612c
L_6130:
	dec (ix+009h)		;6130   ; la nota sigue? (0x09 la cuenta)...
	jp z,nota_siguiente		;6133   ; nota_siguiente: la nota siguiente de la partitura
	bit 0,(ix+002h)		;6136   ; ...tono: el vibrato (0x16)...
	jp z,L_616F		;613a
	ld a,(ix+016h)		;613d
	or a			;6140
	call nz,vibrato		;6141   ; vibrato: el vibrato del canal
	ld a,(ix+009h)		;6144   ; ...el final de la nota: el volumen baja...
	cp (ix+00bh)		;6147
	jp nc,L_6151		;614a
	cp (ix+006h)		;614d
	ret nc			;6150
L_6151:
	ld e,(ix+00ah)		;6151
	dec e			;6154   ; byte 0x0A - 1...
	ret m			;6155   ; ...negativo: nada
	ld (ix+00ah),e		;6156
	bit 5,(ix+002h)		;6159   ; ...callado, nada...
	ret nz			;615d   ; con el bit 5: nada
	ld a,(0e1c6h)		;615e   ; ...con 0xE1C6 y sin pausa, a 0
	or a			;6161
	jr z,L_616C		;6162   ; 0xE1C6 a 0: L_616C
	ld a,(0e1c9h)		;6164
	or a			;6167
	jr nz,L_616C		;6168   ; 0xE1C9 no 0: L_616C
	ld e,000h		;616a   ; E = 0
L_616C:
	jp volumen		;616c   ; volumen: el volumen E del canal
L_616F:
	bit 5,(ix+002h)		;616f   ; ruido: la envolvente (p13:64B0)...
	ret nz			;6173
	bit 7,(ix+002h)		;6174
	ret nz			;6178
	ld a,(0e1c6h)		;6179
	or a			;617c
	jr z,L_6184		;617d
	ld a,001h		;617f
	ld (ix+01ah),a		;6181
L_6184:
	call paso_de_envolvente		;6184   ; paso_de_envolvente: un paso de la envolvente o del efecto; C al acabar
	ret nc			;6187
	set 7,(ix+002h)		;6188   ; ...acabada, volumen 0
	ld e,000h		;618c
	jp volumen		;618e   ; volumen: el volumen E del canal
nota_siguiente:		; la nota siguiente de la partitura
	ld l,(ix+000h)		;6191   ; la nota siguiente de la partitura (0x00-0x01)...
	ld h,(ix+001h)		;6194
L_6197:
	ld a,(hl)			;6197
	inc hl			;6198
	ld c,a			;6199
	cp 0d0h		;619a   ; ...0xD0 y mas: ordenes (p13:6348)...
	jp nc,L_6348		;619c
	ld (ix+000h),l		;619f   ; el puntero a los bytes 0-1
	ld (ix+001h),h		;61a2
	cp 0c0h		;61a5   ; ...0xC0-0xCF: silencio...
	jp nc,L_6318		;61a7
	and 00fh		;61aa   ; ...0x00-0xBF: el nibble bajo + 1 es la duracion...
	inc a			;61ac
	ld b,a			;61ad   ; B = el nibble bajo + 1
	ld e,(ix+003h)		;61ae   ; ...x la base (0x03)...
	ld a,(0e1c5h)		;61b1   ; ...con el jefe herido (0xE1C5), la base 1 o 2 menos: mas deprisa
	or a			;61b4
	jr z,L_61C6		;61b5   ; 0xE1C5 a 0: L_61C6
	ld a,(0e1c9h)		;61b7
	or a			;61ba
	jr nz,L_61C6		;61bb   ; 0xE1C9 no 0: L_61C6
	ld a,(0e1c5h)		;61bd   ; lee lo herido que esta el jefe (0, 1, 2)
	cp 002h		;61c0   ; 2: E - 1
	jr nz,L_61C5		;61c2
	dec e			;61c4
L_61C5:
	dec e			;61c5
L_61C6:
	xor a			;61c6
L_61C7:
	add a,e			;61c7
	djnz L_61C7		;61c8
	ld (ix+009h),a		;61ca   ; la cuenta de la nota
	ld a,(0e1afh)		;61cd   ; lee el programa que se toca (0-3)
	cp 002h		;61d0
	jp nz,L_61E0		;61d2
	ld a,(0e1b0h)		;61d5   ; lee el efecto que suena
	or a			;61d8
	jp nz,L_61E0		;61d9
	res 5,(ix+002h)		;61dc
L_61E0:
	bit 0,(ix+002h)		;61e0   ; tono: el nibble alto es la nota...
	jp z,L_627A		;61e4   ; sin el bit 0: L_627A
	ld a,(ix+009h)		;61e7   ; ...cuando empieza a bajar (0x0B)...
	sub (ix+005h)		;61ea   ; byte 9 - byte 5...
	ld (ix+00bh),a		;61ed   ; ...al byte 0x0B
	bit 5,(ix+002h)		;61f0
	ret nz			;61f4   ; con el bit 5: nada
	ld a,(0e1c5h)		;61f5   ; ...con el jefe herido, la tabla de periodos 0x62E8 (1) o 0x6300 (2)...
	or a			;61f8
	jr z,L_621E		;61f9   ; 0xE1C5 a 0: L_621E
	ld a,(0e1c9h)		;61fb
	or a			;61fe
	jr nz,L_621E		;61ff   ; 0xE1C9 no 0: L_621E
	ld a,(0e1c5h)		;6201   ; lee lo herido que esta el jefe (0, 1, 2)
	cp 002h		;6204   ; no 2: L_6213
	jr nz,L_6213		;6206
	ld a,c			;6208
	and 0f0h		;6209   ; (C / 16) x 2 en la tabla 0x6300
	rrca			;620b
	rrca			;620c
	rrca			;620d
	ld hl,06300h		;620e
	jr L_6227		;6211
L_6213:
	ld a,c			;6213   ; herido 1: la tabla 0x62E8
	and 0f0h		;6214
	rrca			;6216
	rrca			;6217
	rrca			;6218
	ld hl,062e8h		;6219   ; su periodo
	jr L_6227		;621c
L_621E:
	ld a,c			;621e   ; ...si no, la 0x62D0
	and 0f0h		;621f
	rrca			;6221
	rrca			;6222
	rrca			;6223
	ld hl,062d0h		;6224
L_6227:
	add a,l			;6227
	ld l,a			;6228
	jr nc,L_622C		;6229
	inc h			;622b
L_622C:
	ld e,(hl)			;622c   ; el periodo de la nota...
	inc hl			;622d
	ld d,(hl)			;622e
	ld b,(ix+007h)		;622f   ; ...en su octava (0x07 desplazamientos)
L_6232:
	srl d		;6232
	rr e		;6234
	djnz L_6232		;6236
	xor a			;6238   ; vibrato desde 0
	ld (ix+018h),a		;6239
	ld a,(ix+016h)		;623c
	or a			;623f
	jr z,L_6247		;6240
	ld a,0ech		;6242
	ld (ix+016h),a		;6244
L_6247:
	bit 6,(ix+002h)		;6247   ; con el bit 6, un punto mas
	jp z,L_624F		;624b
	inc de			;624e
L_624F:
	ld (ix+014h),d		;624f   ; el periodo a la ficha y al PSG
	ld (ix+015h),e		;6252
	call periodo		;6255   ; periodo: el periodo D, E en los registros del canal
	ld a,(0e1c1h)		;6258   ; el volumen: el general (0xE1C1) + el del canal (0x04)...
	add a,(ix+004h)		;625b
	jp p,L_6262		;625e
	xor a			;6261
L_6262:
	ld (ix+00ah),a		;6262
	ld e,a			;6265
	ld a,(0e1c6h)		;6266   ; ...0 con 0xE1C6 y sin pausa
	or a			;6269
	jr z,L_6274		;626a
	ld a,(0e1c9h)		;626c
	or a			;626f
	jr nz,L_6274		;6270
	ld e,000h		;6272
L_6274:
	call volumen		;6274   ; y con tono
	jp mezcla_tono		;6277   ; mezcla_tono: el canal con tono y sin ruido
L_627A:
	ld a,(ix+008h)		;627a   ; ruido: la envolvente del instrumento (0x08): 1-5 o la de 0x661F...
	cp 001h		;627d   ; instrumento 1 (0x65A7)...
	jr z,L_62B2		;627f
	cp 002h		;6281   ; 2: L_62B8
	jr z,L_62B8		;6283
	cp 003h		;6285   ; 3: L_62BE
	jr z,L_62BE		;6287
	cp 004h		;6289   ; ...4 (0x65EF)...
	jr z,L_62C4		;628b
	cp 005h		;628d   ; 5: L_62CA
	jr z,L_62CA		;628f
	ld hl,0661fh		;6291   ; los demas: 0x661F
L_6294:
	ld a,c			;6294   ; ...la de la nota...
	and 0f0h		;6295
	rrca			;6297
	rrca			;6298
	rrca			;6299
	add a,l			;629a
	ld l,a			;629b
	jr nc,L_629F		;629c
	inc h			;629e
L_629F:
	ld a,(hl)			;629f   ; ...en 0x0C-0x0D...
	ld (ix+00ch),a		;62a0
	inc hl			;62a3
	ld a,(hl)			;62a4
	ld (ix+00dh),a		;62a5
	res 7,(ix+002h)		;62a8   ; ...desde el principio
	ld a,001h		;62ac
	ld (ix+00eh),a		;62ae
	ret			;62b1
L_62B2:
	ld hl,065a7h		;62b2
	jp L_6294		;62b5
L_62B8:
	ld hl,065bfh		;62b8
	jp L_6294		;62bb
L_62BE:
	ld hl,065d7h		;62be
	jp L_6294		;62c1
L_62C4:
	ld hl,065efh		;62c4
	jp L_6294		;62c7
L_62CA:
	ld hl,06607h		;62ca
	jp L_6294		;62cd

; ----------------------------------------------------------------------
; DATOS notas_62D0: 12 periodos del PSG, uno por nota (el nibble alto del byte
;   de la partitura x 2), que p13:6224 elige segun 0xE1C5; lo leen p13:622C
;   (24 bytes)
;   0x62d0..0x62e8  (24 bytes)
DATA_notas_62D0:
	defb 0b8h,01ah	; 62d0
	defb 038h,019h	; 62d2
	defb 0d0h,017h	; 62d4
	defb 078h,016h	; 62d6
	defb 034h,015h	; 62d8
	defb 004h,014h	; 62da
	defb 0e4h,012h	; 62dc
	defb 0d4h,011h	; 62de
	defb 0d4h,010h	; 62e0
	defb 0e4h,00fh	; 62e2
	defb 000h,00fh	; 62e4
	defb 028h,00eh	; 62e6

; ----------------------------------------------------------------------
; DATOS notas_62E8: 12 periodos del PSG, uno por nota (el nibble alto del byte
;   de la partitura x 2), que p13:6219 elige segun 0xE1C5; lo leen p13:622C
;   (24 bytes)
;   0x62e8..0x6300  (24 bytes)
DATA_notas_62E8:
	defb 078h,016h	; 62e8
	defb 034h,015h	; 62ea
	defb 004h,014h	; 62ec
	defb 0e4h,012h	; 62ee
	defb 0d4h,011h	; 62f0
	defb 0d4h,010h	; 62f2
	defb 0e4h,00fh	; 62f4
	defb 000h,00fh	; 62f6
	defb 028h,00eh	; 62f8
	defb 05ch,00dh	; 62fa
	defb 09ch,00ch	; 62fc
	defb 0e8h,00bh	; 62fe

; ----------------------------------------------------------------------
; DATOS notas_6300: 12 periodos del PSG, uno por nota (el nibble alto del byte
;   de la partitura x 2), que p13:620E elige segun 0xE1C5; lo leen p13:622C
;   (24 bytes)
;   0x6300..0x6318  (24 bytes)
DATA_notas_6300:
	defb 0e4h,012h	; 6300
	defb 0d4h,011h	; 6302
	defb 0d4h,010h	; 6304
	defb 0e4h,00fh	; 6306
	defb 000h,00fh	; 6308
	defb 028h,00eh	; 630a
	defb 05ch,00dh	; 630c
	defb 09ch,00ch	; 630e
	defb 0e8h,00bh	; 6310
	defb 03ch,00bh	; 6312
	defb 09ch,00ah	; 6314
	defb 004h,00ah	; 6316

; ======================================================================
; CODIGO 0x6318..0x65a7  (655 bytes)
; ======================================================================


L_6318:
	and 00fh		;6318   ; silencio: su duracion como la de una nota...
	inc a			;631a
	ld b,a			;631b   ; B = + 1
	ld e,(ix+003h)		;631c
	ld a,(0e1c5h)		;631f   ; ...mas corta con el jefe herido...
	or a			;6322
	jr z,L_6334		;6323   ; 0xE1C5 a 0: L_6334
	ld a,(0e1c9h)		;6325
	or a			;6328
	jr nz,L_6334		;6329   ; 0xE1C9 no 0: L_6334
	ld a,(0e1c5h)		;632b   ; lee lo herido que esta el jefe (0, 1, 2)
	cp 002h		;632e
	jr nz,L_6333		;6330   ; 2: E - 1
	dec e			;6332
L_6333:
	dec e			;6333
L_6334:
	xor a			;6334
L_6335:
	add a,e			;6335
	djnz L_6335		;6336
	ld (ix+009h),a		;6338   ; ...la cuenta...
	bit 5,(ix+002h)		;633b   ; ...y volumen 0
	ret nz			;633f
	ld e,000h		;6340
	ld (ix+00ah),e		;6342
	jp volumen		;6345   ; volumen: el volumen E del canal
L_6348:
	and 0f0h		;6348   ; ordenes: 0xD0-0xDF la base de duracion...
	cp 0d0h		;634a
	jp z,L_639A		;634c
	cp 0e0h		;634f   ; ...0xE0-0xEF...
	jp z,L_63A3		;6351
	ld a,c			;6354   ; ...0xFF acaba el canal...
	and 00fh		;6355
	cp 00fh		;6357
	jp z,L_6434		;6359
	cp 00eh		;635c   ; ...0xFE repite: [veces][dir]...
	jp nz,L_6381		;635e
	ld a,(ix+010h)		;6361   ; ...cuenta las vueltas (0x10)...
	dec a			;6364
	jp z,L_6378		;6365
	jp p,L_636D		;6368
	ld a,(hl)			;636b   ; ...la primera vez, las veces del byte...
	dec a			;636c
L_636D:
	inc hl			;636d
	ld (ix+010h),a		;636e
	ld a,(hl)			;6371   ; ...y salta a la direccion...
	inc hl			;6372
	ld h,(hl)			;6373
	ld l,a			;6374
	jp L_6197		;6375
L_6378:
	ld (ix+010h),a		;6378   ; ...acabadas, sigue detras
	inc hl			;637b
	inc hl			;637c
	inc hl			;637d
	jp L_6197		;637e
L_6381:
	inc a			;6381   ; 0xF0-0xFD: el volumen (nibble + 1) y [caida][corte] en 0x05 y 0x06
	ld (ix+004h),a		;6382   ; byte 4 = A + 1
	ld a,(hl)			;6385   ; el byte de detras...
	rrca			;6386   ; el nibble alto - 1...
	rrca			;6387
	rrca			;6388
	rrca			;6389
	and 00fh		;638a
	dec a			;638c
	ld (ix+005h),a		;638d   ; ...la caida (nibble alto - 1)...
	ld a,(hl)			;6390
	inc hl			;6391
	and 00fh		;6392
	ld (ix+006h),a		;6394   ; ...el corte (nibble bajo)
	jp L_6197		;6397
L_639A:
	ld a,c			;639a   ; 0xD0-0xDF: la base de duracion (0x03)
	and 00fh		;639b
	ld (ix+003h),a		;639d
	jp L_6197		;63a0
L_63A3:
	ld a,c			;63a3   ; 0xE0-0xEF: 0xEC vibrato...
	and 00fh		;63a4
	cp 00ch		;63a6   ; 0x0C: L_6409
	jr z,L_6409		;63a8
	cp 006h		;63aa   ; ...0xE0-0xE5 la octava...
	jp c,L_63E9		;63ac
	jp z,L_63F3		;63af   ; ...0xE6 y 0xEB 0xE1C3...
	cp 007h		;63b2   ; ...0xE7 el bit 6...
	jp z,L_6402		;63b4
	cp 00ah		;63b7   ; ...0xEA salta...
	jp z,L_6416		;63b9
	cp 00bh		;63bc   ; 0x0B: L_63FB
	jp z,L_63FB		;63be
	cp 00dh		;63c1   ; ...0xED llama, 0xEE vuelve...
	jp z,L_641D		;63c3
	cp 00eh		;63c6   ; 0x0E: L_642B
	jp z,L_642B		;63c8
	and 007h		;63cb   ; ...0xE8 y 0xE9: el instrumento (bits 0-2 de las banderas)...
	ld b,a			;63cd   ; los bits 0-2...
	ld a,(ix+002h)		;63ce
	and 0f8h		;63d1
	or b			;63d3   ; ...a los bits 0-2 del byte 2
	ld (ix+002h),a		;63d4
	ld a,c			;63d7
	and 00fh		;63d8
	cp 008h		;63da   ; ...0xE8 lleva la envolvente de ruido detras
	jr z,L_63E1		;63dc
	jp L_6197		;63de   ; no es 8: sigue leyendo
L_63E1:
	ld a,(hl)			;63e1
	inc hl			;63e2
	ld (ix+008h),a		;63e3
	jp L_6197		;63e6
L_63E9:
	neg		;63e9   ; la octava: 6 - n
	add a,006h		;63eb
	ld (ix+007h),a		;63ed
	jp L_6197		;63f0
L_63F3:
	ld a,001h		;63f3   ; 0xE6: 0xE1C3 = 1 (no entran efectos)
	ld (0e1c3h),a		;63f5
	jp L_6197		;63f8
L_63FB:
	xor a			;63fb   ; 0xEB: 0xE1C3 = 0
	ld (0e1c3h),a		;63fc
	jp L_6197		;63ff
L_6402:
	set 6,(ix+002h)		;6402   ; 0xE7: el periodo un punto mas
	jp L_6197		;6406
L_6409:
	ld a,0ech		;6409   ; 0xEC: vibrato con su byte
	ld (ix+016h),a		;640b
	ld a,(hl)			;640e
	inc hl			;640f
	ld (ix+017h),a		;6410
	jp L_6197		;6413
L_6416:
	ld a,(hl)			;6416   ; 0xEA: salta
	inc hl			;6417
	ld h,(hl)			;6418
	ld l,a			;6419
	jp L_6197		;641a
L_641D:
	ld e,(hl)			;641d   ; 0xED: llama, guardando la vuelta en 0x12-0x13
	inc hl			;641e
	ld d,(hl)			;641f
	inc hl			;6420
	ld (ix+012h),l		;6421
	ld (ix+013h),h		;6424
	ex de,hl			;6427
	jp L_6197		;6428
L_642B:
	ld l,(ix+012h)		;642b   ; 0xEE: vuelve
	ld h,(ix+013h)		;642e
	jp L_6197		;6431
L_6434:
	ld a,(0e1afh)		;6434   ; se acabo el canal: su bit fuera de 0xE1C2...
	inc a			;6437
	ld b,a			;6438
	ld a,07fh		;6439
L_643B:
	rlca			;643b
	djnz L_643B		;643c
	ld b,a			;643e
	ld a,(0e1c2h)		;643f
	and b			;6442
	ld (0e1c2h),a		;6443
	jp canal_vacio		;6446   ; ...y su programa, el vacio
vibrato:		; el vibrato del canal
	bit 0,(ix+016h)		;6449   ; el vibrato: primero espera 10 cuadros...
	jr nz,L_645D		;644d
	ld a,(ix+018h)		;644f
	inc a			;6452
	cp 00ah		;6453
	jr c,L_649A		;6455
	inc (ix+016h)		;6457
	xor a			;645a
	jr L_649A		;645b
L_645D:
	ld a,(ix+017h)		;645d   ; ...luego cada (nibble alto) cuadros...
	and 0f0h		;6460   ; el nibble alto del byte 0x17...
	rrca			;6462
	rrca			;6463
	rrca			;6464
	rrca			;6465
	ld e,a			;6466   ; ...en E
	ld a,(ix+018h)		;6467   ; la cuenta del vibrato
	inc a			;646a   ; byte 0x18 + 1...
	cp e			;646b   ; ...menor que E: L_649A
	jr c,L_649A		;646c
	ld e,(ix+015h)		;646e   ; ...el periodo sube o baja (nibble bajo) alternando...
	ld d,(ix+014h)		;6471   ; DE = bytes 0x14-0x15
	ld a,(ix+017h)		;6474
	and 00fh		;6477   ; B = el nibble bajo del byte 0x17
	ld b,a			;6479
	ld a,(ix+019h)		;647a   ; el sentido cambia cada vez
	cpl			;647d   ; byte 0x19 al reves
	ld (ix+019h),a		;647e
	and a			;6481
	ld a,e			;6482
	jr nz,L_648C		;6483   ; ahora no 0: L_648C
	add a,b			;6485   ; 0: DE + B
	ld e,a			;6486
	jr nc,L_6491		;6487
	inc d			;6489
	jr L_6491		;648a
L_648C:
	sub b			;648c
	ld e,a			;648d
	jr nc,L_6491		;648e
	dec d			;6490
L_6491:
	bit 5,(ix+002h)		;6491   ; ...al PSG
	ret nz			;6495
	call periodo		;6496   ; al PSG
	xor a			;6499
L_649A:
	ld (ix+018h),a		;649a
	ret			;649d
canal_fb:		; el programa del 0xFB (0xE178)
	ld ix,0e178h		;649e   ; el programa del 0xFB: su canal 0xE178
	jp L_64A9		;64a2
canal_de_efectos:		; el programa de los efectos (0xE15D)
	ld ix,0e15dh		;64a5   ; el de los efectos: 0xE15D
L_64A9:
	call paso_de_envolvente		;64a9   ; un paso del efecto; acabado, el programa vacio
	ret nc			;64ac
	jp canal_vacio		;64ad   ; canal_vacio: el programa vacio: calla el canal
paso_de_envolvente:		; un paso de la envolvente o del efecto; C al acabar
	dec (ix+00eh)		;64b0   ; un paso de la envolvente: cada (0x0F) cuadros...
	jp nz,L_65A3		;64b3
	ld a,(ix+00fh)		;64b6
	ld (ix+00eh),a		;64b9
	ld l,(ix+00ch)		;64bc
	ld h,(ix+00dh)		;64bf
L_64C2:
	ld a,(hl)			;64c2   ; ...el byte: 0xFF acaba (C)...
	cp 0ffh		;64c3   ; 0xFF: L_65A5
	jp z,L_65A5		;64c5
	inc hl			;64c8
	ld c,a			;64c9
	cp 0feh		;64ca   ; ...0xFE repite...
	jp z,L_6530		;64cc
	and 0f0h		;64cf   ; ...0x2x mezcla...
	cp 020h		;64d1   ; 0x2x: L_6550
	jp z,L_6550		;64d3
	cp 010h		;64d6   ; ...0x1x: el ruido (registro 6) y sigue...
	jp nz,L_64EA		;64d8   ; no 0x1x: L_64EA
	ld a,c			;64db
	and 00fh		;64dc
	rlca			;64de   ; el nibble bajo x 2
	ld e,a			;64df
	ld a,006h		;64e0
	call 00093h		;64e2   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(hl)			;64e5
	inc hl			;64e6
	ld c,a			;64e7
	and 0f0h		;64e8
L_64EA:
	rrca			;64ea   ; ...el volumen (nibble alto)...
	rrca			;64eb
	rrca			;64ec
	rrca			;64ed
	ld e,a			;64ee
	bit 4,(ix+00ah)		;64ef   ; ...con la envolvente del PSG, el registro 13...
	jp z,L_64FE		;64f3
	ld a,00dh		;64f6
	call 00093h		;64f8   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_6521		;64fb
L_64FE:
	ld a,(0e1afh)		;64fe   ; ...si no, mas el volumen general (musica)...
	cp 003h		;6501
	jp nc,L_650F		;6503
	ld a,(0e1c1h)		;6506   ; lee el volumen general (baja al apagarse)
	add a,e			;6509
	jp p,L_650E		;650a
	xor a			;650d
L_650E:
	ld e,a			;650e
L_650F:
	ld a,(ix+01ah)		;650f   ; ...callado con las musicas 0x86 y siguientes y 0x1A...
	or a			;6512
	jr z,L_651E		;6513
	ld a,(0e1c7h)		;6515   ; lee la musica que suena
	cp 086h		;6518
	jr c,L_651E		;651a
	ld e,000h		;651c
L_651E:
	call volumen		;651e   ; volumen: el volumen E del canal
L_6521:
	ld a,c			;6521   ; ...y el periodo (nibble bajo y el byte siguiente)
	and 00fh		;6522
	ld d,a			;6524
	ld e,(hl)			;6525
	inc hl			;6526
	ld (ix+00ch),l		;6527
	ld (ix+00dh),h		;652a
	jp periodo		;652d   ; periodo: el periodo D, E en los registros del canal
L_6530:
	ld a,(ix+011h)		;6530   ; 0xFE: repite como en las partituras
	dec a			;6533
	jp z,L_6547		;6534
	jp p,L_653C		;6537
	ld a,(hl)			;653a
	dec a			;653b
L_653C:
	inc hl			;653c   ; la cuenta de vueltas...
	ld (ix+011h),a		;653d
	ld a,(hl)			;6540   ; ...y salta
	inc hl			;6541
	ld h,(hl)			;6542
	ld l,a			;6543
	jp L_64C2		;6544
L_6547:
	ld (ix+011h),a		;6547
	inc hl			;654a
	inc hl			;654b
	inc hl			;654c
	jp L_64C2		;654d
L_6550:
	bit 0,c		;6550   ; 0x2x: tono y ruido segun los bits 0 y 1...
	jp nz,L_6566		;6552
	bit 1,c		;6555
	jp nz,L_6560		;6557
	call mezcla_ruido		;655a   ; mezcla_ruido: el canal con ruido y sin tono
	jp L_6574		;655d
L_6560:
	call mezcla_tono		;6560   ; mezcla_tono: el canal con tono y sin ruido
	jp L_6574		;6563
L_6566:
	bit 1,c		;6566
	jp nz,L_6571		;6568
	call mezcla_nada		;656b   ; mezcla_nada: el canal sin tono ni ruido
	jp L_6574		;656e
L_6571:
	call mezcla_los_dos		;6571   ; mezcla_los_dos: el canal con tono y ruido
L_6574:
	ld a,c			;6574   ; ...el bit 3 a la envolvente del PSG (bit 4 del volumen)...
	rlca			;6575   ; el bit 3 de C al bit 4...
	and 010h		;6576
	ld (ix+00ah),a		;6578   ; ...al byte 0x0A
	ld e,a			;657b
	call volumen		;657c   ; volumen: el volumen E del canal
	ld a,(hl)			;657f   ; ...la duracion de cada paso...
	inc hl			;6580
	ld (ix+00eh),a		;6581   ; bytes 0x0E y 0x0F = el siguiente
	ld (ix+00fh),a		;6584
	ld a,c			;6587   ; ...0x28 y mas: el periodo de la envolvente (registros 12 y 11)
	cp 020h		;6588   ; 0x20: L_65A3
	jp z,L_65A3		;658a
	cp 028h		;658d   ; menos de 0x28: L_64C2
	jp c,L_64C2		;658f
	ld e,(hl)			;6592
	inc hl			;6593
	ld a,00ch		;6594   ; al PSG 12 (periodo de la envolvente, alto)
	call 00093h		;6596   ; BIOS WRTPSG - Writes data to PSG-register
	ld e,(hl)			;6599
	inc hl			;659a
	ld a,00bh		;659b   ; al PSG 11 (periodo de la envolvente, bajo)
	call 00093h		;659d   ; BIOS WRTPSG - Writes data to PSG-register
	jp L_64C2		;65a0
L_65A3:
	or a			;65a3   ; NC: sigue
	ret			;65a4
L_65A5:
	scf			;65a5   ; C: acabado
	ret			;65a6

; ----------------------------------------------------------------------
; DATOS instrumento_1: 12 punteros, uno por nota, a la envolvente del
;   instrumento 1 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x65a7..0x65bf  (24 bytes)
DATA_instrumento_1:
	defb 037h,066h	; 65a7
	defb 03dh,066h	; 65a9
	defb 04dh,066h	; 65ab
	defb 063h,066h	; 65ad
	defb 063h,066h	; 65af
	defb 063h,066h	; 65b1
	defb 063h,066h	; 65b3
	defb 092h,066h	; 65b5
	defb 0cbh,066h	; 65b7
	defb 04eh,067h	; 65b9
	defb 0d1h,067h	; 65bb
	defb 0d1h,067h	; 65bd

; ----------------------------------------------------------------------
; DATOS instrumento_2: 12 punteros, uno por nota, a la envolvente del
;   instrumento 2 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x65bf..0x65d7  (24 bytes)
DATA_instrumento_2:
	defb 0d1h,067h	; 65bf
	defb 0e4h,067h	; 65c1
	defb 0e4h,067h	; 65c3
	defb 0f7h,067h	; 65c5
	defb 0f7h,067h	; 65c7
	defb 00ah,068h	; 65c9
	defb 00ah,068h	; 65cb
	defb 0d3h,068h	; 65cd
	defb 0e6h,068h	; 65cf
	defb 0f9h,068h	; 65d1
	defb 0f9h,068h	; 65d3
	defb 00ch,069h	; 65d5

; ----------------------------------------------------------------------
; DATOS instrumento_3: 12 punteros, uno por nota, a la envolvente del
;   instrumento 3 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x65d7..0x65ef  (24 bytes)
DATA_instrumento_3:
	defb 01fh,069h	; 65d7
	defb 032h,069h	; 65d9
	defb 032h,069h	; 65db
	defb 045h,069h	; 65dd
	defb 058h,069h	; 65df
	defb 06bh,069h	; 65e1
	defb 07eh,069h	; 65e3
	defb 07eh,069h	; 65e5
	defb 091h,069h	; 65e7
	defb 0a4h,069h	; 65e9
	defb 0a4h,069h	; 65eb
	defb 0b7h,069h	; 65ed

; ----------------------------------------------------------------------
; DATOS instrumento_4: 12 punteros, uno por nota, a la envolvente del
;   instrumento 4 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x65ef..0x6607  (24 bytes)
DATA_instrumento_4:
	defb 0cah,069h	; 65ef
	defb 037h,06ah	; 65f1
	defb 037h,06ah	; 65f3
	defb 037h,06ah	; 65f5
	defb 037h,06ah	; 65f7
	defb 037h,06ah	; 65f9
	defb 037h,06ah	; 65fb
	defb 0a4h,06ah	; 65fd
	defb 0a4h,06ah	; 65ff
	defb 011h,06bh	; 6601
	defb 07eh,06bh	; 6603
	defb 0ebh,06bh	; 6605

; ----------------------------------------------------------------------
; DATOS instrumento_5: 12 punteros, uno por nota, a la envolvente del
;   instrumento 5 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x6607..0x661f  (24 bytes)
DATA_instrumento_5:
	defb 058h,06ch	; 6607
	defb 0c5h,06ch	; 6609
	defb 0c5h,06ch	; 660b
	defb 032h,06dh	; 660d
	defb 09fh,06dh	; 660f
	defb 00ch,06eh	; 6611
	defb 079h,06eh	; 6613
	defb 079h,06eh	; 6615
	defb 0e6h,06eh	; 6617
	defb 053h,06fh	; 6619
	defb 053h,06fh	; 661b
	defb 053h,06fh	; 661d

; ----------------------------------------------------------------------
; DATOS instrumento_0: 12 punteros, uno por nota, a la envolvente del
;   instrumento 0 ((ix+8), p13:627A); lo leen p13:629F (24 bytes)
;   0x661f..0x6637  (24 bytes)
DATA_instrumento_0:
	defb 0c0h,06fh	; 661f
	defb 02dh,070h	; 6621
	defb 09ah,070h	; 6623
	defb 007h,071h	; 6625
	defb 098h,071h	; 6627
	defb 098h,071h	; 6629
	defb 098h,071h	; 662b
	defb 005h,072h	; 662d
	defb 072h,072h	; 662f
	defb 0d5h,072h	; 6631
	defb 038h,073h	; 6633
	defb 0d3h,073h	; 6635

; ----------------------------------------------------------------------
; DATOS envolventes_6637: envolventes de los instrumentos, con el formato de
;   los efectos (p13:64C2); lo leen p13:64C2 (3495 bytes)
;   0x6637..0x73de  (3495 bytes)
DATA_envolventes_6637:
	defb 021h,001h,010h,0d0h,000h,0ffh,021h,002h,010h,0d0h,000h,021h,010h,010h,0b0h,000h	; 6637  !.....!....!....
	defb 021h,010h,010h,090h,000h,0ffh,021h,001h,015h,0c0h,006h,022h,001h,0c2h,000h,021h	; 6647  !.....!...."...!
	defb 002h,018h,080h,006h,070h,006h,021h,001h,013h,060h,006h,0ffh,022h,001h,0c2h,000h	; 6657  ....p.!..`.."...
	defb 0b2h,00ah,0b2h,015h,0a2h,020h,0a2h,02ah,0a2h,035h,092h,040h,092h,04ah,092h,055h	; 6667  ..... .*.5.@.J.U
	defb 092h,060h,082h,06ah,082h,075h,082h,080h,082h,08ah,082h,095h,072h,0a0h,072h,0aah	; 6677  .`.j.u......r.r.
	defb 072h,0b5h,075h,0c0h,062h,0cah,062h,0d5h,052h,0e0h,0ffh,022h,004h,0d0h,080h,0d0h	; 6687  r.u.b.b.R.."....
	defb 060h,0d0h,048h,0c0h,080h,0c0h,060h,0c0h,048h,0b0h,080h,0b0h,060h,0b0h,048h,0a0h	; 6697  `.H...`.H...`.H.
	defb 080h,0a0h,060h,0a0h,048h,090h,080h,090h,060h,090h,048h,080h,080h,080h,060h,080h	; 66a7  ..`.H...`.H...`.
	defb 048h,070h,080h,070h,060h,070h,048h,060h,080h,060h,060h,060h,048h,050h,080h,050h	; 66b7  Hp.p`pH`.```HP.P
	defb 060h,050h,048h,0ffh,022h,001h,0e0h,030h,0e0h,02ah,0e0h,024h,0e0h,020h,0e0h,01ch	; 66c7  `PH."..0.*.$. ..
	defb 0e0h,018h,0e0h,015h,0f0h,090h,0f0h,07eh,0f0h,06eh,0f0h,060h,0f0h,054h,0f0h,049h	; 66d7  .......~.n.`.T.I
	defb 0f0h,040h,0feh,006h,0cbh,066h,0d0h,030h,0d0h,02ah,0d0h,024h,0d0h,020h,0d0h,01ch	; 66e7  .@...f.0.*.$. ..
	defb 0d0h,018h,0d0h,015h,0e0h,090h,0e0h,07eh,0e0h,06eh,0e0h,060h,0e0h,054h,0e0h,049h	; 66f7  .......~.n.`.T.I
	defb 0e0h,040h,0feh,002h,0edh,066h,0b0h,030h,0b0h,02ah,0b0h,024h,0b0h,020h,0b0h,01ch	; 6707  .@...f.0.*.$. ..
	defb 0b0h,018h,0b0h,015h,0c0h,090h,0c0h,07eh,0c0h,06eh,0c0h,060h,0c0h,054h,0c0h,049h	; 6717  .......~.n.`.T.I
	defb 0c0h,040h,0feh,002h,00dh,067h,0a0h,030h,0a0h,02ah,0a0h,024h,0a0h,020h,0a0h,01ch	; 6727  .@...g.0.*.$. ..
	defb 0a0h,018h,0a0h,015h,090h,090h,090h,07eh,090h,06eh,090h,060h,090h,054h,090h,049h	; 6737  .......~.n.`.T.I
	defb 090h,040h,0feh,004h,02dh,067h,0ffh,022h,001h,0e0h,018h,0e0h,015h,0e0h,012h,0e0h	; 6747  .@..-g."........
	defb 010h,0e0h,00eh,0e0h,00ch,0e0h,00ah,0f0h,047h,0f0h,03eh,0f0h,036h,0f0h,02fh,0f0h	; 6757  ........G.>.6./.
	defb 029h,0f0h,024h,0f0h,01fh,0feh,006h,04eh,067h,0d0h,018h,0d0h,015h,0d0h,012h,0d0h	; 6767  ).$....Ng.......
	defb 010h,0d0h,00eh,0d0h,00ch,0d0h,00ah,0e0h,047h,0e0h,03eh,0e0h,036h,0e0h,02fh,0e0h	; 6777  ........G.>.6./.
	defb 029h,0e0h,024h,0e0h,01fh,0feh,002h,070h,067h,0b0h,018h,0b0h,015h,0b0h,012h,0b0h	; 6787  ).$....pg.......
	defb 010h,0b0h,00eh,0b0h,00ch,0b0h,00ah,0c0h,047h,0c0h,03eh,0c0h,036h,0c0h,02fh,0c0h	; 6797  ........G.>.6./.
	defb 029h,0c0h,024h,0c0h,01fh,0feh,002h,090h,067h,0a0h,018h,0a0h,015h,0a0h,012h,0a0h	; 67a7  ).$.....g.......
	defb 010h,0a0h,00eh,0a0h,00ch,0a0h,00ah,090h,047h,090h,03eh,090h,036h,090h,02fh,090h	; 67b7  ........G.>.6./.
	defb 029h,090h,024h,090h,01fh,0feh,004h,0b0h,067h,0ffh,022h,004h,0b0h,06bh,0a0h,06bh	; 67c7  ).$.....g."..k.k
	defb 090h,06bh,080h,06bh,070h,06bh,060h,06bh,050h,06bh,040h,06bh,0ffh,022h,004h,0b0h	; 67d7  .k.kpk`kPk@k."..
	defb 05fh,0a0h,05fh,090h,05fh,080h,05fh,070h,05fh,060h,05fh,050h,05fh,040h,05fh,0ffh	; 67e7  _._._._p_`_P_@_.
	defb 022h,004h,0b0h,055h,0a0h,055h,090h,055h,080h,055h,070h,055h,060h,055h,050h,055h	; 67f7  "..U.U.U.UpU`UPU
	defb 040h,055h,0ffh,022h,001h,0f1h,040h,0f1h,080h,0f1h,0c0h,0f2h,000h,0f2h,040h,0f2h	; 6807  @U."..@.......@.
	defb 080h,0f2h,0c0h,0f3h,000h,0f3h,040h,0f3h,080h,0f3h,0c0h,0feh,003h,00ah,068h,0e0h	; 6817  ......@.......h.
	defb 080h,0e0h,0c0h,0e1h,000h,0e1h,040h,0e1h,080h,0e1h,0c0h,0e2h,000h,0e2h,040h,0e2h	; 6827  ......@.......@.
	defb 080h,0e2h,0c0h,0e3h,000h,0e3h,040h,0e3h,080h,0e3h,0c0h,0feh,002h,026h,068h,0d0h	; 6837  ......@......&h.
	defb 080h,0d0h,0c0h,0d1h,000h,0d1h,040h,0d1h,080h,0d1h,0c0h,0d2h,000h,0d2h,040h,0d2h	; 6847  ......@.......@.
	defb 080h,0d2h,0c0h,0d3h,000h,0d3h,040h,0d3h,080h,0d3h,0c0h,0c0h,080h,0c0h,0c0h,0c1h	; 6857  ......@.........
	defb 000h,0c1h,040h,0c1h,080h,0c1h,0c0h,0c2h,000h,0c2h,040h,0c2h,080h,0c2h,0c0h,0c3h	; 6867  ..@.......@.....
	defb 000h,0c3h,040h,0c3h,080h,0c3h,0c0h,0b0h,080h,0b0h,0c0h,0b1h,000h,0b1h,040h,0b1h	; 6877  ..@...........@.
	defb 080h,0b1h,0c0h,0b2h,000h,0a2h,040h,0a2h,080h,0a2h,0c0h,0a3h,000h,0a3h,040h,0a3h	; 6887  ......@.......@.
	defb 080h,0a3h,0c0h,090h,080h,090h,0c0h,091h,000h,091h,040h,091h,080h,091h,0c0h,092h	; 6897  ..........@.....
	defb 000h,082h,040h,082h,080h,082h,0c0h,083h,000h,083h,040h,083h,080h,083h,0c0h,070h	; 68a7  ..@.......@....p
	defb 080h,070h,0c0h,071h,000h,071h,040h,071h,080h,071h,0c0h,072h,000h,062h,040h,062h	; 68b7  .p.q.q@q.q.r.b@b
	defb 080h,062h,0c0h,063h,000h,063h,040h,063h,080h,063h,0c0h,0ffh,022h,004h,0b0h,047h	; 68c7  .b.c.c@c.c.."..G
	defb 0a0h,047h,090h,047h,080h,047h,070h,047h,060h,047h,050h,047h,040h,047h,0ffh,022h	; 68d7  .G.G.GpG`GPG@G."
	defb 004h,0b0h,043h,0a0h,043h,090h,043h,080h,043h,070h,043h,060h,043h,050h,043h,040h	; 68e7  ..C.C.C.CpC`CPC@
	defb 043h,0ffh,022h,004h,0b0h,03ch,0a0h,03ch,090h,03ch,080h,03ch,070h,03ch,060h,03ch	; 68f7  C."..<.<.<.<p<`<
	defb 050h,03ch,040h,03ch,0ffh,022h,004h,0b0h,039h,0a0h,039h,090h,039h,080h,039h,070h	; 6907  P<@<."..9.9.9.9p
	defb 039h,060h,039h,050h,039h,040h,039h,0ffh,022h,004h,0b0h,036h,0a0h,036h,090h,036h	; 6917  9`9P9@9."..6.6.6
	defb 080h,036h,070h,036h,060h,036h,050h,036h,040h,036h,0ffh,022h,004h,0b0h,02fh,0a0h	; 6927  .6p6`6P6@6."../.
	defb 02fh,090h,02fh,080h,02fh,070h,02fh,060h,02fh,050h,02fh,040h,02fh,0ffh,022h,004h	; 6937  /././p/`/P/@/.".
	defb 0b0h,02dh,0a0h,02dh,090h,02dh,080h,02dh,070h,02dh,060h,02dh,050h,02dh,040h,02dh	; 6947  .-.-.-.-p-`-P-@-
	defb 0ffh,022h,004h,0b0h,02ah,0a0h,02ah,090h,02ah,080h,02ah,070h,02ah,060h,02ah,050h	; 6957  ."..*.*.*.*p*`*P
	defb 02ah,040h,02ah,0ffh,022h,004h,0b0h,028h,0a0h,028h,090h,028h,080h,028h,070h,028h	; 6967  *@*."..(.(.(.(p(
	defb 060h,028h,050h,028h,040h,028h,0ffh,022h,004h,0b0h,024h,0a0h,024h,090h,024h,080h	; 6977  `(P(@(."..$.$.$.
	defb 024h,070h,024h,060h,024h,050h,024h,040h,024h,0ffh,022h,004h,0b0h,022h,0a0h,022h	; 6987  $p$`$P$@$.".."."
	defb 090h,022h,080h,022h,070h,022h,060h,022h,050h,022h,040h,022h,0ffh,022h,004h,0b0h	; 6997  ."."p"`"P"@"."..
	defb 01eh,0a0h,01eh,090h,01eh,080h,01eh,070h,01eh,060h,01eh,050h,01eh,040h,01eh,0ffh	; 69a7  .......p.`.P.@..
	defb 022h,004h,0b0h,01ch,0a0h,01ch,090h,01ch,080h,01ch,070h,01ch,060h,01ch,050h,01ch	; 69b7  ".........p.`.P.
	defb 040h,01ch,0ffh,022h,001h,0c0h,0d6h,0d0h,0d6h,0d0h,0d6h,0b0h,0d6h,0a0h,0d6h,080h	; 69c7  @.."............
	defb 0d6h,070h,0d6h,080h,0d6h,090h,0d6h,0a0h,0d6h,0a0h,0d6h,0b0h,0d6h,0c0h,0d6h,0b0h	; 69d7  .p..............
	defb 0d6h,0a0h,0d6h,090h,0d6h,080h,0d6h,070h,0d6h,060h,0d6h,070h,0d6h,080h,0d6h,080h	; 69e7  .......p.`.p....
	defb 0d6h,090h,0d6h,0a0h,0d6h,0b0h,0d6h,0a0h,0d6h,080h,0d6h,070h,0d6h,060h,0d6h,050h	; 69f7  ...........p.`.P
	defb 0d6h,040h,0d6h,050h,0d6h,060h,0d6h,070h,0d6h,080h,0d6h,090h,0d6h,0a0h,0d6h,090h	; 6a07  .@.P.`.p........
	defb 0d6h,080h,0d6h,060h,0d6h,050h,0d6h,040h,0d6h,030h,0d6h,040h,0d6h,050h,0d6h,060h	; 6a17  ...`.P.@.0.@.P.`
	defb 0d6h,070h,0d6h,080h,0d6h,090h,0d6h,080h,0d6h,070h,0d6h,050h,0d6h,040h,0d6h,0ffh	; 6a27  .p.......p.P.@..
	defb 022h,001h,0c0h,097h,0d0h,097h,0d0h,097h,0b0h,097h,0a0h,097h,080h,097h,070h,097h	; 6a37  ".............p.
	defb 080h,097h,090h,097h,0a0h,097h,0a0h,097h,0b0h,097h,0c0h,097h,0b0h,097h,0a0h,097h	; 6a47  ................
	defb 090h,097h,080h,097h,070h,097h,060h,097h,070h,097h,080h,097h,080h,097h,090h,097h	; 6a57  ....p.`.p.......
	defb 0a0h,097h,0b0h,097h,0a0h,097h,080h,097h,070h,097h,060h,097h,050h,097h,040h,097h	; 6a67  ........p.`.P.@.
	defb 050h,097h,060h,097h,070h,097h,080h,097h,090h,097h,0a0h,097h,090h,097h,080h,097h	; 6a77  P.`.p...........
	defb 060h,097h,050h,097h,040h,097h,030h,097h,040h,097h,050h,097h,060h,097h,070h,097h	; 6a87  `.P.@.0.@.P.`.p.
	defb 080h,097h,090h,097h,080h,097h,070h,097h,050h,097h,040h,097h,0ffh,022h,001h,0c0h	; 6a97  ......p.P.@.."..
	defb 087h,0d0h,087h,0d0h,087h,0b0h,087h,0a0h,087h,080h,087h,070h,087h,080h,087h,090h	; 6aa7  ...........p....
	defb 087h,0a0h,087h,0a0h,087h,0b0h,087h,0c0h,087h,0b0h,087h,0a0h,087h,090h,087h,080h	; 6ab7  ................
	defb 087h,070h,087h,060h,087h,070h,087h,080h,087h,080h,087h,090h,087h,0a0h,087h,0b0h	; 6ac7  .p.`.p..........
	defb 087h,0a0h,087h,080h,087h,070h,087h,060h,087h,050h,087h,040h,087h,050h,087h,060h	; 6ad7  .....p.`.P.@.P.`
	defb 087h,070h,087h,080h,087h,090h,087h,0a0h,087h,090h,087h,080h,087h,060h,087h,050h	; 6ae7  .p...........`.P
	defb 087h,040h,087h,030h,087h,040h,087h,050h,087h,060h,087h,070h,087h,080h,087h,090h	; 6af7  .@.0.@.P.`.p....
	defb 087h,080h,087h,070h,087h,050h,087h,040h,087h,0ffh,022h,001h,0c0h,07fh,0d0h,07fh	; 6b07  ...p.P.@..".....
	defb 0d0h,07fh,0b0h,07fh,0a0h,07fh,080h,07fh,070h,07fh,080h,07fh,090h,07fh,0a0h,07fh	; 6b17  ........p.......
	defb 0a0h,07fh,0b0h,07fh,0c0h,07fh,0b0h,07fh,0a0h,07fh,090h,07fh,080h,07fh,070h,07fh	; 6b27  ..............p.
	defb 060h,07fh,070h,07fh,080h,07fh,080h,07fh,090h,07fh,0a0h,07fh,0b0h,07fh,0a0h,07fh	; 6b37  `.p.............
	defb 080h,07fh,070h,07fh,060h,07fh,050h,07fh,040h,07fh,050h,07fh,060h,07fh,070h,07fh	; 6b47  ..p.`.P.@.P.`.p.
	defb 080h,07fh,090h,07fh,0a0h,07fh,090h,07fh,080h,07fh,060h,07fh,050h,07fh,040h,07fh	; 6b57  ..........`.P.@.
	defb 030h,07fh,040h,07fh,050h,07fh,060h,07fh,070h,07fh,080h,07fh,090h,07fh,080h,07fh	; 6b67  0.@.P.`.p.......
	defb 070h,07fh,050h,07fh,040h,07fh,0ffh,022h,001h,0c0h,078h,0d0h,078h,0d0h,078h,0b0h	; 6b77  p.P.@.."..x.x.x.
	defb 078h,0a0h,078h,080h,078h,070h,078h,080h,078h,090h,078h,0a0h,078h,0a0h,078h,0b0h	; 6b87  x.x.xpx.x.x.x.x.
	defb 078h,0c0h,078h,0b0h,078h,0a0h,078h,090h,078h,080h,078h,070h,078h,060h,078h,070h	; 6b97  x.x.x.x.x.xpx`xp
	defb 078h,080h,078h,080h,078h,090h,078h,0a0h,078h,0b0h,078h,0a0h,078h,080h,078h,070h	; 6ba7  x.x.x.x.x.x.x.xp
	defb 078h,060h,078h,050h,078h,040h,078h,050h,078h,060h,078h,070h,078h,080h,078h,090h	; 6bb7  x`xPx@xPx`xpx.x.
	defb 078h,0a0h,078h,090h,078h,080h,078h,060h,078h,050h,078h,040h,078h,030h,078h,040h	; 6bc7  x.x.x.x`xPx@x0x@
	defb 078h,050h,078h,060h,078h,070h,078h,080h,078h,090h,078h,080h,078h,070h,078h,050h	; 6bd7  xPx`xpx.x.x.xpxP
	defb 078h,040h,078h,0ffh,022h,001h,0c0h,071h,0d0h,071h,0d0h,071h,0b0h,071h,0a0h,071h	; 6be7  x@x."..q.q.q.q.q
	defb 080h,071h,070h,071h,080h,071h,090h,071h,0a0h,071h,0a0h,071h,0b0h,071h,0c0h,071h	; 6bf7  .qpq.q.q.q.q.q.q
	defb 0b0h,071h,0a0h,071h,090h,071h,080h,071h,070h,071h,060h,071h,070h,071h,080h,071h	; 6c07  .q.q.q.qpq`qpq.q
	defb 080h,071h,090h,071h,0a0h,071h,0b0h,071h,0a0h,071h,080h,071h,070h,071h,060h,071h	; 6c17  .q.q.q.q.q.qpq`q
	defb 050h,071h,040h,071h,050h,071h,060h,071h,070h,071h,080h,071h,090h,071h,0a0h,071h	; 6c27  Pq@qPq`qpq.q.q.q
	defb 090h,071h,080h,071h,060h,071h,050h,071h,040h,071h,030h,071h,040h,071h,050h,071h	; 6c37  .q.q`qPq@q0q@qPq
	defb 060h,071h,070h,071h,080h,071h,090h,071h,080h,071h,070h,071h,050h,071h,040h,071h	; 6c47  `qpq.q.q.qpqPq@q
	defb 0ffh,022h,001h,0c0h,06bh,0d0h,06bh,0d0h,06bh,0b0h,06bh,0a0h,06bh,080h,06bh,070h	; 6c57  ."..k.k.k.k.k.kp
	defb 06bh,080h,06bh,090h,06bh,0a0h,06bh,0a0h,06bh,0b0h,06bh,0c0h,06bh,0b0h,06bh,0a0h	; 6c67  k.k.k.k.k.k.k.k.
	defb 06bh,090h,06bh,080h,06bh,070h,06bh,060h,06bh,070h,06bh,080h,06bh,080h,06bh,090h	; 6c77  k.k.kpk`kpk.k.k.
	defb 06bh,0a0h,06bh,0b0h,06bh,0a0h,06bh,080h,06bh,070h,06bh,060h,06bh,050h,06bh,040h	; 6c87  k.k.k.k.kpk`kPk@
	defb 06bh,050h,06bh,060h,06bh,070h,06bh,080h,06bh,090h,06bh,0a0h,06bh,090h,06bh,080h	; 6c97  kPk`kpk.k.k.k.k.
	defb 06bh,060h,06bh,050h,06bh,040h,06bh,030h,06bh,040h,06bh,050h,06bh,060h,06bh,070h	; 6ca7  k`kPk@k0k@kPk`kp
	defb 06bh,080h,06bh,090h,06bh,080h,06bh,070h,06bh,050h,06bh,040h,06bh,0ffh,022h,001h	; 6cb7  k.k.k.kpkPk@k.".
	defb 0c0h,05fh,0d0h,05fh,0d0h,05fh,0b0h,05fh,0a0h,05fh,080h,05fh,070h,05fh,080h,05fh	; 6cc7  ._._._._._._p_._
	defb 090h,05fh,0a0h,05fh,0a0h,05fh,0b0h,05fh,0c0h,05fh,0b0h,05fh,0a0h,05fh,090h,05fh	; 6cd7  ._._._._._._._._
	defb 080h,05fh,070h,05fh,060h,05fh,070h,05fh,080h,05fh,080h,05fh,090h,05fh,0a0h,05fh	; 6ce7  ._p_`_p_._._._._
	defb 0b0h,05fh,0a0h,05fh,080h,05fh,070h,05fh,060h,05fh,050h,05fh,040h,05fh,050h,05fh	; 6cf7  ._._._p_`_P_@_P_
	defb 060h,05fh,070h,05fh,080h,05fh,090h,05fh,0a0h,05fh,090h,05fh,080h,05fh,060h,05fh	; 6d07  `_p_._._._._._`_
	defb 050h,05fh,040h,05fh,030h,05fh,040h,05fh,050h,05fh,060h,05fh,070h,05fh,080h,05fh	; 6d17  P_@_0_@_P_`_p_._
	defb 090h,05fh,080h,05fh,070h,05fh,050h,05fh,040h,05fh,0ffh,022h,001h,0c0h,05ah,0d0h	; 6d27  ._._p_P_@_."..Z.
	defb 05ah,0d0h,05ah,0b0h,05ah,0a0h,05ah,080h,05ah,070h,05ah,080h,05ah,090h,05ah,0a0h	; 6d37  Z.Z.Z.Z.ZpZ.Z.Z.
	defb 05ah,0a0h,05ah,0b0h,05ah,0c0h,05ah,0b0h,05ah,0a0h,05ah,090h,05ah,080h,05ah,070h	; 6d47  Z.Z.Z.Z.Z.Z.Z.Zp
	defb 05ah,060h,05ah,070h,05ah,080h,05ah,080h,05ah,090h,05ah,0a0h,05ah,0b0h,05ah,0a0h	; 6d57  Z`ZpZ.Z.Z.Z.Z.Z.
	defb 05ah,080h,05ah,070h,05ah,060h,05ah,050h,05ah,040h,05ah,050h,05ah,060h,05ah,070h	; 6d67  Z.ZpZ`ZPZ@ZPZ`Zp
	defb 05ah,080h,05ah,090h,05ah,0a0h,05ah,090h,05ah,080h,05ah,060h,05ah,050h,05ah,040h	; 6d77  Z.Z.Z.Z.Z.Z`ZPZ@
	defb 05ah,030h,05ah,040h,05ah,050h,05ah,060h,05ah,070h,05ah,080h,05ah,090h,05ah,080h	; 6d87  Z0Z@ZPZ`ZpZ.Z.Z.
	defb 05ah,070h,05ah,050h,05ah,040h,05ah,0ffh,022h,001h,0c0h,055h,0d0h,055h,0d0h,055h	; 6d97  ZpZPZ@Z."..U.U.U
	defb 0b0h,055h,0a0h,055h,080h,055h,070h,055h,080h,055h,090h,055h,0a0h,055h,0a0h,055h	; 6da7  .U.U.UpU.U.U.U.U
	defb 0b0h,055h,0c0h,055h,0b0h,055h,0a0h,055h,090h,055h,080h,055h,070h,055h,060h,055h	; 6db7  .U.U.U.U.U.UpU`U
	defb 070h,055h,080h,055h,080h,055h,090h,055h,0a0h,055h,0b0h,055h,0a0h,055h,080h,055h	; 6dc7  pU.U.U.U.U.U.U.U
	defb 070h,055h,060h,055h,050h,055h,040h,055h,050h,055h,060h,055h,070h,055h,080h,055h	; 6dd7  pU`UPU@UPU`UpU.U
	defb 090h,055h,0a0h,055h,090h,055h,080h,055h,060h,055h,050h,055h,040h,055h,030h,055h	; 6de7  .U.U.U.U`UPU@U0U
	defb 040h,055h,050h,055h,060h,055h,070h,055h,080h,055h,090h,055h,080h,055h,070h,055h	; 6df7  @UPU`UpU.U.U.UpU
	defb 050h,055h,040h,055h,0ffh,022h,001h,0c0h,050h,0d0h,050h,0d0h,050h,0b0h,050h,0a0h	; 6e07  PU@U."..P.P.P.P.
	defb 050h,080h,050h,070h,050h,080h,050h,090h,050h,0a0h,050h,0a0h,050h,0b0h,050h,0c0h	; 6e17  P.PpP.P.P.P.P.P.
	defb 050h,0b0h,050h,0a0h,050h,090h,050h,080h,050h,070h,050h,060h,050h,070h,050h,080h	; 6e27  P.P.P.P.PpP`PpP.
	defb 050h,080h,050h,090h,050h,0a0h,050h,0b0h,050h,0a0h,050h,080h,050h,070h,050h,060h	; 6e37  P.P.P.P.P.P.PpP`
	defb 050h,050h,050h,040h,050h,050h,050h,060h,050h,070h,050h,080h,050h,090h,050h,0a0h	; 6e47  PPP@PPP`PpP.P.P.
	defb 050h,090h,050h,080h,050h,060h,050h,050h,050h,040h,050h,030h,050h,040h,050h,050h	; 6e57  P.P.P`PPP@P0P@PP
	defb 050h,060h,050h,070h,050h,080h,050h,090h,050h,080h,050h,070h,050h,050h,050h,040h	; 6e67  P`PpP.P.P.PpPPP@
	defb 050h,0ffh,022h,001h,0c0h,047h,0d0h,047h,0d0h,047h,0b0h,047h,0a0h,047h,080h,047h	; 6e77  P."..G.G.G.G.G.G
	defb 070h,047h,080h,047h,090h,047h,0a0h,047h,0a0h,047h,0b0h,047h,0c0h,047h,0b0h,047h	; 6e87  pG.G.G.G.G.G.G.G
	defb 0a0h,047h,090h,047h,080h,047h,070h,047h,060h,047h,070h,047h,080h,047h,080h,047h	; 6e97  .G.G.GpG`GpG.G.G
	defb 090h,047h,0a0h,047h,0b0h,047h,0a0h,047h,080h,047h,070h,047h,060h,047h,050h,047h	; 6ea7  .G.G.G.G.GpG`GPG
	defb 040h,047h,050h,047h,060h,047h,070h,047h,080h,047h,090h,047h,0a0h,047h,090h,047h	; 6eb7  @GPG`GpG.G.G.G.G
	defb 080h,047h,060h,047h,050h,047h,040h,047h,030h,047h,040h,047h,050h,047h,060h,047h	; 6ec7  .G`GPG@G0G@GPG`G
	defb 070h,047h,080h,047h,090h,047h,080h,047h,070h,047h,050h,047h,040h,047h,0ffh,022h	; 6ed7  pG.G.G.GpGPG@G."
	defb 001h,0c0h,043h,0d0h,043h,0d0h,043h,0b0h,043h,0a0h,043h,080h,043h,070h,043h,080h	; 6ee7  ..C.C.C.C.C.CpC.
	defb 043h,090h,043h,0a0h,043h,0a0h,043h,0b0h,043h,0c0h,043h,0b0h,043h,0a0h,043h,090h	; 6ef7  C.C.C.C.C.C.C.C.
	defb 043h,080h,043h,070h,043h,060h,043h,070h,043h,080h,043h,080h,043h,090h,043h,0a0h	; 6f07  C.CpC`CpC.C.C.C.
	defb 043h,0b0h,043h,0a0h,043h,080h,043h,070h,043h,060h,043h,050h,043h,040h,043h,050h	; 6f17  C.C.C.CpC`CPC@CP
	defb 043h,060h,043h,070h,043h,080h,043h,090h,043h,0a0h,043h,090h,043h,080h,043h,060h	; 6f27  C`CpC.C.C.C.C.C`
	defb 043h,050h,043h,040h,043h,030h,043h,040h,043h,050h,043h,060h,043h,070h,043h,080h	; 6f37  CPC@C0C@CPC`CpC.
	defb 043h,090h,043h,080h,043h,070h,043h,050h,043h,040h,043h,0ffh,022h,001h,0c0h,039h	; 6f47  C.C.CpCPC@C."..9
	defb 0d0h,039h,0d0h,039h,0b0h,039h,0a0h,039h,080h,039h,070h,039h,080h,039h,090h,039h	; 6f57  .9.9.9.9.9p9.9.9
	defb 0a0h,039h,0a0h,039h,0b0h,039h,0c0h,039h,0b0h,039h,0a0h,039h,090h,039h,080h,039h	; 6f67  .9.9.9.9.9.9.9.9
	defb 070h,039h,060h,039h,070h,039h,080h,039h,080h,039h,090h,039h,0a0h,039h,0b0h,039h	; 6f77  p9`9p9.9.9.9.9.9
	defb 0a0h,039h,080h,039h,070h,039h,060h,039h,050h,039h,040h,039h,050h,039h,060h,039h	; 6f87  .9.9p9`9P9@9P9`9
	defb 070h,039h,080h,039h,090h,039h,0a0h,039h,090h,039h,080h,039h,060h,039h,050h,039h	; 6f97  p9.9.9.9.9.9`9P9
	defb 040h,039h,030h,039h,040h,039h,050h,039h,060h,039h,070h,039h,080h,039h,090h,039h	; 6fa7  @909@9P9`9p9.9.9
	defb 080h,039h,070h,039h,050h,039h,040h,039h,0ffh,022h,001h,0c0h,036h,0d0h,036h,0d0h	; 6fb7  .9p9P9@9."..6.6.
	defb 036h,0b0h,036h,0a0h,036h,080h,036h,070h,036h,080h,036h,090h,036h,0a0h,036h,0a0h	; 6fc7  6.6.6.6p6.6.6.6.
	defb 036h,0b0h,036h,0c0h,036h,0b0h,036h,0a0h,036h,090h,036h,080h,036h,070h,036h,060h	; 6fd7  6.6.6.6.6.6.6p6`
	defb 036h,070h,036h,080h,036h,080h,036h,090h,036h,0a0h,036h,0b0h,036h,0a0h,036h,080h	; 6fe7  6p6.6.6.6.6.6.6.
	defb 036h,070h,036h,060h,036h,050h,036h,040h,036h,050h,036h,060h,036h,070h,036h,080h	; 6ff7  6p6`6P6@6P6`6p6.
	defb 036h,090h,036h,0a0h,036h,090h,036h,080h,036h,060h,036h,050h,036h,040h,036h,030h	; 7007  6.6.6.6.6`6P6@60
	defb 036h,040h,036h,050h,036h,060h,036h,070h,036h,080h,036h,090h,036h,080h,036h,070h	; 7017  6@6P6`6p6.6.6.6p
	defb 036h,050h,036h,040h,036h,0ffh,022h,001h,0b0h,028h,0c0h,028h,0c0h,028h,0a0h,028h	; 7027  6P6@6."..(.(.(.(
	defb 090h,028h,070h,028h,060h,028h,070h,028h,080h,028h,090h,028h,090h,028h,0a0h,028h	; 7037  .(p(`(p(.(.(.(.(
	defb 0b0h,028h,0a0h,028h,090h,028h,080h,028h,070h,028h,060h,028h,050h,028h,060h,028h	; 7047  .(.(.(.(p(`(P(`(
	defb 070h,028h,070h,028h,080h,028h,090h,028h,0a0h,028h,090h,028h,070h,028h,060h,028h	; 7057  p(p(.(.(.(.(p(`(
	defb 050h,028h,040h,028h,030h,028h,040h,028h,050h,028h,060h,028h,070h,028h,080h,028h	; 7067  P(@(0(@(P(`(p(.(
	defb 090h,028h,080h,028h,070h,028h,050h,028h,040h,028h,030h,028h,030h,028h,030h,028h	; 7077  .(.(p(P(@(0(0(0(
	defb 040h,028h,050h,028h,060h,028h,070h,028h,080h,028h,070h,028h,060h,028h,040h,028h	; 7087  @(P(`(p(.(p(`(@(
	defb 030h,028h,0ffh,022h,001h,0c0h,02fh,0d0h,02fh,0d0h,02fh,0b0h,02fh,0a0h,02fh,080h	; 7097  0(."../././././.
	defb 02fh,070h,02fh,080h,02fh,090h,02fh,0a0h,02fh,0a0h,02fh,0b0h,02fh,0c0h,02fh,0b0h	; 70a7  /p/././././././.
	defb 02fh,0a0h,02fh,090h,02fh,080h,02fh,070h,02fh,060h,02fh,070h,02fh,080h,02fh,080h	; 70b7  /./././p/`/p/./.
	defb 02fh,090h,02fh,0a0h,02fh,0b0h,02fh,0a0h,02fh,080h,02fh,070h,02fh,060h,02fh,050h	; 70c7  /./././././p/`/P
	defb 02fh,040h,02fh,050h,02fh,060h,02fh,070h,02fh,080h,02fh,090h,02fh,0a0h,02fh,090h	; 70d7  /@/P/`/p/./././.
	defb 02fh,080h,02fh,060h,02fh,050h,02fh,040h,02fh,030h,02fh,040h,02fh,050h,02fh,060h	; 70e7  /./`/P/@/0/@/P/`
	defb 02fh,070h,02fh,080h,02fh,090h,02fh,080h,02fh,070h,02fh,050h,02fh,040h,02fh,0ffh	; 70f7  /p/./././p/P/@/.
	defb 022h,001h,090h,040h,090h,038h,090h,031h,090h,02bh,0a0h,026h,0a0h,021h,0a0h,01dh	; 7107  "..@.8.1.+.&.!..
	defb 0a0h,019h,0a0h,016h,0b0h,060h,0b0h,054h,0b0h,04ah,0b0h,041h,0c0h,039h,0c0h,032h	; 7117  .....`.T.J.A.9.2
	defb 0c0h,02ch,0c0h,026h,0c0h,022h,0d0h,080h,0d0h,070h,0d0h,062h,0d0h,056h,0e0h,04ch	; 7127  .,.&."...p.b.V.L
	defb 0e0h,043h,0e0h,03bh,0e0h,033h,0e0h,02dh,0e0h,0a0h,0e0h,08ch,0e0h,07bh,0e0h,06ch	; 7137  .C...3.-.....{.l
	defb 0e0h,05fh,0e0h,053h,0e0h,049h,0e0h,040h,0e0h,038h,0d0h,0c0h,0d0h,0a8h,0d0h,094h	; 7147  ._.S.I.@.8......
	defb 0d0h,082h,0c0h,072h,0c0h,064h,0c0h,058h,0c0h,04dh,0c0h,044h,0b0h,0e0h,0b0h,0c4h	; 7157  ...r.d.X.M.D....
	defb 0b0h,0adh,0b0h,098h,0a0h,085h,0a0h,075h,0a0h,067h,0a0h,05ah,0a0h,04fh,091h,000h	; 7167  .......u.g.Z.O..
	defb 090h,0e1h,090h,0c5h,090h,0adh,090h,098h,090h,086h,090h,076h,090h,067h,090h,05bh	; 7177  ...........v.g.[
	defb 081h,020h,080h,0fdh,080h,0c3h,080h,0abh,070h,097h,070h,084h,070h,06dh,070h,060h	; 7187  . ......p.p.pmp`
	defb 0ffh,022h,001h,0b0h,032h,0c0h,032h,0c0h,032h,0a0h,032h,090h,032h,070h,032h,060h	; 7197  ."..2.2.2.2.2p2`
	defb 032h,070h,032h,080h,032h,090h,032h,090h,032h,0a0h,032h,0b0h,032h,0a0h,032h,090h	; 71a7  2p2.2.2.2.2.2.2.
	defb 032h,080h,032h,070h,032h,060h,032h,050h,032h,060h,032h,070h,032h,070h,032h,080h	; 71b7  2.2p2`2P2`2p2p2.
	defb 032h,090h,032h,0a0h,032h,090h,032h,070h,032h,060h,032h,050h,032h,040h,032h,030h	; 71c7  2.2.2.2p2`2P2@20
	defb 032h,040h,032h,050h,032h,060h,032h,070h,032h,080h,032h,090h,032h,080h,032h,070h	; 71d7  2@2P2`2p2.2.2.2p
	defb 032h,050h,032h,040h,032h,030h,032h,030h,032h,030h,032h,040h,032h,050h,032h,060h	; 71e7  2P2@2020202@2P2`
	defb 032h,070h,032h,080h,032h,070h,032h,060h,032h,040h,032h,030h,032h,0ffh,022h,001h	; 71f7  2p2.2p2`2@202.".
	defb 0b0h,02ah,0c0h,02ah,0c0h,02ah,0a0h,02ah,090h,02ah,070h,02ah,060h,02ah,070h,02ah	; 7207  .*.*.*.*.*p*`*p*
	defb 080h,02ah,090h,02ah,090h,02ah,0a0h,02ah,0b0h,02ah,0a0h,02ah,090h,02ah,080h,02ah	; 7217  .*.*.*.*.*.*.*.*
	defb 070h,02ah,060h,02ah,050h,02ah,060h,02ah,070h,02ah,070h,02ah,080h,02ah,090h,02ah	; 7227  p*`*P*`*p*p*.*.*
	defb 0a0h,02ah,090h,02ah,070h,02ah,060h,02ah,050h,02ah,040h,02ah,030h,02ah,040h,02ah	; 7237  .*.*p*`*P*@*0*@*
	defb 050h,02ah,060h,02ah,070h,02ah,080h,02ah,090h,02ah,080h,02ah,070h,02ah,050h,02ah	; 7247  P*`*p*.*.*.*p*P*
	defb 040h,02ah,030h,02ah,030h,02ah,030h,02ah,040h,02ah,050h,02ah,060h,02ah,070h,02ah	; 7257  @*0*0*0*@*P*`*p*
	defb 080h,02ah,070h,02ah,060h,02ah,040h,02ah,030h,02ah,0ffh,022h,001h,0b1h,0eeh,0b1h	; 7267  .*p*`*@*0*."....
	defb 0cfh,0b1h,0b2h,0b1h,097h,0b1h,07dh,0b1h,065h,0b1h,04fh,0b1h,03ah,0b1h,026h,0b1h	; 7277  ......}.e.O.:.&.
	defb 014h,0b1h,003h,0b0h,0f2h,0d1h,088h,0d1h,06fh,0d1h,058h,0d1h,042h,0d1h,02eh,0d1h	; 7287  ........o.X.B...
	defb 01bh,0d1h,00ah,0d0h,0f9h,0d0h,0e9h,0d0h,0dbh,0d0h,0cdh,0d0h,0c0h,0b1h,055h,0b1h	; 7297  ..............U.
	defb 03fh,0b1h,02bh,0b1h,018h,0b1h,007h,0b0h,0f6h,0b0h,0e7h,0b0h,0d9h,0b0h,0cbh,0b0h	; 72a7  ?.+.............
	defb 0beh,0b0h,0b2h,0b0h,0a7h,091h,033h,091h,01fh,091h,00dh,090h,0fch,090h,0edh,090h	; 72b7  ......3.........
	defb 0deh,090h,0d0h,090h,0c3h,090h,0b7h,090h,0abh,090h,0a1h,090h,096h,0ffh,022h,001h	; 72c7  ..............".
	defb 0d0h,0f0h,0d0h,0e1h,0d0h,0d6h,0d0h,0cah,0d0h,0beh,0d0h,0b4h,0d0h,0aah,0d0h,0a0h	; 72d7  ................
	defb 0d0h,097h,0d0h,087h,0d0h,087h,0d0h,078h,0f0h,0beh,0f0h,0b4h,0f0h,0aah,0f0h,0a0h	; 72e7  .......x........
	defb 0f0h,097h,0f0h,08fh,0f0h,087h,0f0h,07fh,0f0h,078h,0f0h,06bh,0f0h,065h,0f0h,05fh	; 72f7  .........x.k.e._
	defb 0d0h,08fh,0d0h,0a0h,0d0h,097h,0d0h,08fh,0d0h,087h,0d0h,078h,0d0h,071h,0d0h,06bh	; 7307  ...........x.q.k
	defb 0d0h,065h,0d0h,05fh,0d0h,05ah,0d0h,055h,0b0h,097h,0b0h,08fh,0b0h,087h,0b0h,07fh	; 7317  .e._.Z.U........
	defb 0b0h,078h,0b0h,071h,0b0h,06bh,0b0h,05fh,0b0h,05ah,0b0h,055h,0b0h,050h,0b0h,04ch	; 7327  .x.q.k._.Z.U.P.L
	defb 0ffh,022h,002h,0b0h,033h,0b0h,026h,0b0h,01ch,0b0h,015h,0b0h,010h,0b0h,00ch,0c0h	; 7337  ."..3.&.........
	defb 044h,0c0h,033h,0c0h,026h,0c0h,01ch,0c0h,015h,0c0h,010h,0c0h,00ch,0a0h,033h,0a0h	; 7347  D.3.&.........3.
	defb 026h,0a0h,01ch,0a0h,015h,0a0h,010h,0a0h,00ch,0b0h,044h,0b0h,033h,0b0h,026h,0b0h	; 7357  &.........D.3.&.
	defb 01ch,0b0h,015h,0b0h,010h,0b0h,00ch,090h,026h,090h,01ch,090h,015h,090h,010h,090h	; 7367  ........&.......
	defb 00ch,0a0h,044h,0a0h,033h,0a0h,026h,0a0h,01ch,0a0h,015h,0a0h,010h,0a0h,00ch,080h	; 7377  ..D.3.&.........
	defb 026h,080h,01ch,080h,015h,080h,010h,080h,00ch,090h,044h,090h,033h,090h,026h,090h	; 7387  &.........D.3.&.
	defb 01ch,090h,015h,090h,010h,090h,00ch,070h,033h,070h,026h,070h,01ch,070h,015h,070h	; 7397  .......p3p&p.p.p
	defb 010h,070h,00ch,080h,044h,080h,033h,080h,026h,080h,01ch,080h,015h,080h,010h,080h	; 73a7  .p..D.3.&.......
	defb 00ch,060h,033h,060h,026h,060h,01ch,060h,015h,060h,010h,060h,00ch,070h,044h,070h	; 73b7  .`3`&`.`.`.`.pDp
	defb 033h,070h,026h,070h,01ch,070h,015h,070h,010h,070h,00ch,0ffh,022h,026h,060h,028h	; 73c7  3p&p.p.p.p.."&`(
	defb 050h,028h,040h,028h,030h,028h,0ffh	; 73d7

; ----------------------------------------------------------------------
; DATOS efectos: 48 punteros, uno por efecto de sonido (1-0x30), que p00:4F3C
;   lee con el banco 13 en 0x6000; lo leen p00:4F44 (96 bytes)
;   0x73de..0x743e  (96 bytes)
DATA_efectos:
	defb 0cah,074h	; 73de
	defb 0e9h,074h	; 73e0
	defb 0fch,074h	; 73e2
	defb 011h,075h	; 73e4
	defb 022h,075h	; 73e6
	defb 047h,075h	; 73e8
	defb 07eh,075h	; 73ea
	defb 0d7h,075h	; 73ec
	defb 02ah,076h	; 73ee
	defb 057h,076h	; 73f0
	defb 093h,076h	; 73f2
	defb 0b6h,076h	; 73f4
	defb 0d9h,076h	; 73f6
	defb 01eh,077h	; 73f8
	defb 059h,077h	; 73fa
	defb 080h,077h	; 73fc
	defb 0a3h,077h	; 73fe
	defb 0dah,077h	; 7400
	defb 012h,078h	; 7402
	defb 02fh,078h	; 7404
	defb 04ah,078h	; 7406
	defb 06dh,078h	; 7408
	defb 080h,078h	; 740a
	defb 0afh,078h	; 740c
	defb 004h,079h	; 740e
	defb 01bh,079h	; 7410
	defb 0a3h,077h	; 7412
	defb 06eh,079h	; 7414
	defb 0a4h,079h	; 7416
	defb 0c6h,079h	; 7418
	defb 0f7h,079h	; 741a
	defb 021h,07ah	; 741c
	defb 064h,07ah	; 741e
	defb 0cdh,07ah	; 7420
	defb 021h,07bh	; 7422
	defb 082h,07bh	; 7424
	defb 0b2h,07bh	; 7426
	defb 0c1h,07bh	; 7428
	defb 00ch,07ch	; 742a
	defb 08ah,07ch	; 742c
	defb 0b9h,07ch	; 742e
	defb 0f8h,07ch	; 7430
	defb 003h,07dh	; 7432
	defb 01ah,07dh	; 7434
	defb 031h,07dh	; 7436
	defb 07ch,07dh	; 7438
	defb 09fh,07dh	; 743a
	defb 0b0h,07dh	; 743c

; ----------------------------------------------------------------------
; DATOS musicas: 23 musicas (0x80-0x96), tres punteros cada una: los canales
;   A, B y C (p00:4EAE); lo leen p00:4EB6 (138 bytes)
;   0x743e..0x74c8  (138 bytes)
DATA_musicas:
	defb 002h,07eh,002h,07eh,002h,07eh	; 743e
	defb 003h,07eh,006h,07eh,00ch,07eh	; 7444
	defb 012h,07eh,014h,07eh,01bh,07eh	; 744a
	defb 01ch,07eh,02fh,07eh,03fh,07eh	; 7450
	defb 050h,07eh,053h,07eh,059h,07eh	; 7456
	defb 05ah,07eh,05dh,07eh,063h,07eh	; 745c
	defb 064h,07eh,0a4h,07eh,02ch,07fh	; 7462
	defb 040h,07fh,036h,080h,0f0h,081h	; 7468
	defb 04bh,07fh,043h,080h,0fah,081h	; 746e
	defb 05ch,083h,08ch,083h,0bbh,083h	; 7474
	defb 090h,085h,087h,086h,045h,087h	; 747a
	defb 07fh,08bh,0a8h,08bh,0eah,08bh	; 7480
	defb 0e0h,083h,022h,084h,03dh,084h	; 7486
	defb 053h,084h,09ah,084h,01eh,085h	; 748c
	defb 06bh,085h,077h,085h,085h,085h	; 7492
	defb 055h,088h,0d2h,088h,058h,089h	; 7498
	defb 0d7h,089h,07bh,08ah,006h,08bh	; 749e
	defb 035h,08bh,058h,08bh,062h,08bh	; 74a4
	defb 01ah,08ch,08ch,08ch,0b8h,08ch	; 74aa
	defb 0ddh,08ch,075h,08dh,003h,08fh	; 74b0
	defb 01fh,08fh,03fh,08fh,05fh,08fh	; 74b6
	defb 07fh,08fh,0a1h,08fh,0dch,08fh	; 74bc
	defb 005h,090h,005h,090h,005h,090h	; 74c2

; ----------------------------------------------------------------------
; DATOS palabra_tras_las_musicas: una palabra mas (0x9005, como las tres de la
;   musica 0x96) detras de las 23 musicas y antes del primer efecto: seria el
;   canal A de una musica 0x97, que no tiene B ni C (sus bytes son ya el
;   efecto 1) y que ningun `ld a,0x97` pide
;   0x74c8..0x74ca  (2 bytes)
DATA_palabra_tras_las_musicas:
	defb 005h,090h	; 74c8

; ----------------------------------------------------------------------
; DATOS efectos_74CA: los efectos de sonido (p13:64C2); lo leen p13:64C2 (2331
;   bytes)
;   0x74ca..0x7de5  (2331 bytes)
DATA_efectos_74CA:
	defb 023h,001h,01ch,0d0h,010h,022h,001h,0d0h,0b7h,0c0h,0a0h,0b0h,08ch,0d0h,07ah,0c0h	; 74ca  #...."........z.
	defb 06bh,0b0h,05dh,000h,000h,023h,001h,017h,0a0h,010h,000h,000h,090h,020h,0ffh,023h	; 74da  k.]..#....... .#
	defb 002h,018h,0c0h,040h,022h,001h,000h,000h,000h,000h,023h,001h,01dh,0e0h,020h,0d0h	; 74ea  ...@".....#... .
	defb 010h,0ffh,022h,002h,000h,000h,022h,001h,0d0h,0b7h,0d0h,0a0h,0d0h,08ch,0d0h,07ah	; 74fa  .."..."........z
	defb 0d0h,06bh,0d0h,05dh,0d0h,052h,0ffh,022h,001h,0c0h,033h,0d0h,02fh,0e0h,02ah,0b0h	; 750a  .k.].R."..3./.*.
	defb 028h,0a0h,023h,090h,020h,080h,01eh,0ffh,023h,001h,018h,0a0h,030h,01dh,0b0h,030h	; 751a  (.#. ...#...0..0
	defb 01eh,0b0h,030h,01ch,0e0h,030h,01fh,0d0h,030h,0d0h,030h,0e0h,030h,0f0h,030h,0c0h	; 752a  ..0..0..0.0.0.0.
	defb 030h,0b0h,030h,023h,005h,01fh,090h,030h,080h,030h,070h,030h,0ffh,022h,001h,070h	; 753a  0.0#...0.0p0.".p
	defb 0a8h,080h,0b7h,090h,0a6h,0a0h,0b5h,0b0h,0a4h,0c0h,0b3h,0d0h,0b2h,0e0h,0b1h,0e0h	; 754a  ................
	defb 0a0h,0e0h,0b1h,0e0h,0a2h,0e0h,0b3h,0e0h,0a4h,0e0h,0ach,0e0h,0beh,0d0h,0b0h,0d0h	; 755a  ................
	defb 0c2h,0c0h,0b4h,0c0h,0c6h,0b0h,0b8h,0b0h,0cah,0a0h,0bch,0a0h,0ceh,090h,0c0h,090h	; 756a  ................
	defb 0d2h,080h,0d6h,0ffh,023h,001h,013h,0f0h,020h,0f0h,030h,021h,001h,01eh,0d0h,000h	; 757a  ....#... .0!....
	defb 0d0h,000h,023h,001h,013h,0e0h,020h,0e0h,030h,021h,001h,01fh,0d0h,000h,0d0h,000h	; 758a  ..#... .0!......
	defb 000h,000h,023h,001h,013h,0d0h,020h,0d0h,030h,021h,001h,01eh,0b0h,000h,0b0h,000h	; 759a  ..#... .0!......
	defb 023h,001h,013h,0d0h,020h,0d0h,030h,021h,001h,01fh,0b0h,000h,0b0h,000h,000h,000h	; 75aa  #... .0!........
	defb 023h,001h,013h,0b0h,020h,0b0h,030h,021h,001h,01eh,090h,000h,090h,000h,023h,001h	; 75ba  #... .0!......#.
	defb 013h,0b0h,020h,0b0h,030h,021h,001h,01fh,090h,000h,080h,000h,0ffh,022h,001h,0c4h	; 75ca  .. .0!......."..
	defb 090h,0c3h,0fdh,0c3h,07fh,0c3h,010h,0c2h,0aeh,0c2h,059h,0c2h,00ch,083h,090h,083h	; 75da  ..........Y.....
	defb 017h,082h,0b5h,082h,05fh,082h,014h,081h,0d2h,081h,0dah,0d3h,0b8h,0d3h,041h,0d2h	; 75ea  ...._.........A.
	defb 0d9h,0d2h,07eh,0d2h,02fh,0d1h,0eah,082h,0d8h,082h,07dh,082h,02eh,081h,0e9h,081h	; 75fa  ..~./.....}.....
	defb 0ach,081h,077h,0e3h,0d0h,0e3h,056h,0e2h,0ech,0e2h,08fh,0e2h,03eh,0e1h,0f7h,0e1h	; 760a  ..w...V.....>...
	defb 0d9h,082h,0d0h,082h,076h,082h,028h,081h,0e3h,081h,0a7h,081h,073h,081h,045h,0ffh	; 761a  ....v.(.....s.E.
	defb 022h,001h,0f3h,08ch,000h,000h,0e3h,015h,000h,000h,0e3h,08ch,000h,000h,0d3h,015h	; 762a  "...............
	defb 000h,000h,0d3h,08ch,0b3h,015h,000h,000h,0c3h,050h,000h,000h,000h,000h,0c4h,000h	; 763a  .........P......
	defb 000h,000h,000h,000h,0c2h,000h,000h,000h,000h,000h,0c3h,050h,0ffh,022h,001h,0a3h	; 764a  ...........P."..
	defb 000h,023h,001h,012h,0b6h,000h,000h,000h,0d6h,000h,022h,001h,0a3h,000h,021h,002h	; 765a  .#........"...!.
	defb 014h,0a0h,000h,0c0h,000h,022h,001h,093h,000h,021h,002h,016h,0a0h,000h,0c0h,000h	; 766a  ....."...!......
	defb 022h,001h,083h,000h,021h,002h,016h,090h,000h,0b0h,000h,022h,001h,073h,000h,021h	; 767a  "...!......".s.!
	defb 002h,016h,080h,000h,090h,000h,070h,000h,0ffh,022h,001h,0d0h,010h,0c0h,030h,0b0h	; 768a  ......p.."....0.
	defb 050h,0a1h,000h,091h,0c0h,092h,000h,082h,080h,063h,000h,063h,000h,0c0h,080h,0b1h	; 769a  P........c.c....
	defb 000h,0a1h,080h,091h,0c0h,082h,000h,091h,000h,080h,080h,0ffh,022h,001h,0d0h,01bh	; 76aa  ............"...
	defb 0c0h,01bh,022h,002h,0b0h,01bh,0a0h,01bh,090h,01bh,000h,000h,000h,000h,0a0h,01bh	; 76ba  ..".............
	defb 090h,01bh,080h,01bh,000h,000h,000h,000h,000h,000h,000h,000h,070h,01bh,0ffh,021h	; 76ca  ............p..!
	defb 001h,01fh,0f0h,000h,010h,0d0h,000h,013h,0c0h,000h,016h,0b0h,000h,01ah,0a0h,000h	; 76da  ................
	defb 021h,002h,010h,0d0h,000h,013h,0c0h,000h,016h,0b0h,000h,01ah,0a0h,000h,01eh,0b0h	; 76ea  !...............
	defb 000h,000h,000h,010h,0a0h,000h,013h,090h,000h,016h,080h,000h,01ah,070h,000h,01eh	; 76fa  .............p..
	defb 060h,000h,000h,000h,010h,0a0h,000h,013h,090h,000h,016h,080h,000h,01ah,070h,000h	; 770a  `.............p.
	defb 01eh,060h,000h,0ffh,022h,001h,0e2h,070h,023h,001h,016h,0a3h,000h,01dh,0b2h,000h	; 771a  .`.."..p#.......
	defb 01eh,0c3h,000h,01ch,0d1h,080h,000h,000h,022h,001h,0b2h,0a0h,0d1h,0c0h,0c2h,01ah	; 772a  ........".......
	defb 0d2h,040h,0c2h,06ah,0b2h,0d0h,0a5h,000h,096h,060h,082h,000h,083h,000h,000h,000h	; 773a  .@.j.....`......
	defb 0a2h,040h,0a2h,06ah,092h,0d0h,095h,000h,086h,060h,072h,000h,063h,000h,0ffh,022h	; 774a  .@.j.....`r.c.."
	defb 001h,0d0h,0cch,0b0h,035h,0d0h,088h,0d0h,046h,0b0h,035h,000h,000h,000h,000h,0a0h	; 775a  ....5...F.5.....
	defb 0cch,080h,035h,0a0h,088h,0a0h,046h,080h,035h,000h,000h,090h,0cch,070h,035h,090h	; 776a  ..5...F.5....p5.
	defb 088h,080h,046h,070h,035h,0ffh,022h,001h,0e1h,000h,0e2h,000h,0e3h,000h,0e4h,000h	; 777a  ..Fp5.".........
	defb 0d0h,04ah,0d1h,04ah,0c0h,04bh,0c1h,04bh,0b0h,0aah,0b1h,04ah,0a2h,04ah,093h,04ah	; 778a  .J.J.K.K...J.J.J
	defb 080h,04ah,071h,04ah,062h,04ah,053h,04ah,0ffh,022h,001h,0e0h,038h,0e0h,07eh,0e1h	; 779a  .JqJbJSJ."..8.~.
	defb 01bh,0e2h,07dh,0e5h,09bh,000h,000h,0c0h,038h,0c0h,07eh,0c1h,01bh,0c2h,07dh,0c5h	; 77aa  ..}.....8.~...}.
	defb 09bh,000h,000h,000h,000h,0b0h,038h,0b0h,07eh,0b1h,01bh,0b2h,07dh,0b5h,09bh,022h	; 77ba  ......8.~...}.."
	defb 003h,000h,000h,022h,001h,0a0h,038h,0a0h,07eh,091h,01bh,092h,07dh,085h,09bh,0ffh	; 77ca  ..."..8.~...}...
	defb 022h,001h,0c1h,0f0h,023h,001h,01ch,0f0h,0a0h,022h,004h,000h,000h,022h,001h,0c2h	; 77da  "...#...."..."..
	defb 020h,0e1h,040h,0d1h,09ah,0e1h,0c0h,0d1h,0eah,0c2h,050h,0b4h,080h,0a5h,0e0h,091h	; 77ea   .@.......P.....
	defb 080h,092h,080h,000h,000h,000h,000h,0a1h,09ah,0b1h,0c0h,0b1h,0eah,0a2h,050h,0a4h	; 77fa  ..............P.
	defb 080h,095h,0e0h,081h,0c0h,072h,080h,0ffh,023h,001h,01ch,0d0h,010h,01ah,0e0h,010h	; 780a  .....r..#.......
	defb 017h,0f0h,010h,016h,0e0h,010h,018h,0d0h,018h,014h,0c0h,018h,0b0h,020h,013h,0a0h	; 781a  ............. ..
	defb 020h,011h,090h,020h,0ffh,023h,001h,010h,0f0h,030h,0e0h,02eh,0d0h,01ch,0c0h,02ah	; 782a   .. .#...0.....*
	defb 0c0h,028h,0b0h,026h,0a0h,024h,023h,002h,010h,090h,020h,080h,020h,070h,020h,0ffh	; 783a  .(.&.$#... . p .
	defb 023h,001h,016h,0e0h,013h,0d0h,016h,0c0h,019h,0e0h,016h,0d0h,01ch,022h,001h,0e0h	; 784a  #............"..
	defb 030h,0d0h,040h,023h,002h,012h,0c0h,028h,0b0h,02ah,0a0h,030h,090h,030h,080h,030h	; 785a  0.@#...(.*.0.0.0
	defb 070h,030h,0ffh,023h,001h,016h,0e0h,045h,022h,001h,0c0h,040h,023h,001h,010h,0d0h	; 786a  p0.#...E"..@#...
	defb 035h,022h,002h,0b0h,030h,0ffh,022h,002h,061h,0c0h,071h,0b0h,081h,0a0h,091h,090h	; 787a  5"..0.".a.q.....
	defb 0a1h,080h,0b1h,070h,0c1h,060h,0c1h,050h,0d1h,040h,0d1h,030h,0d1h,020h,0d1h,010h	; 788a  ...p.`.P.@.0. ..
	defb 0d1h,000h,0d0h,0f0h,0d0h,0e0h,022h,003h,0a1h,030h,0a1h,020h,091h,010h,091h,000h	; 789a  ......"..0. ....
	defb 080h,0f0h,070h,0e0h,0ffh,022h,001h,080h,060h,080h,090h,080h,0d8h,091h,044h,0a1h	; 78aa  ..p.."..`.....D.
	defb 0e6h,0b2h,0d9h,0c4h,045h,0d6h,068h,0e0h,01bh,0e0h,028h,0e0h,03ch,0e0h,05bh,0e0h	; 78ba  ....E.h...(.<.[.
	defb 088h,0e0h,0cdh,0e1h,033h,0e1h,0cdh,0e2h,0b3h,0e4h,00dh,0e6h,014h,0d0h,01bh,0d0h	; 78ca  ....3...........
	defb 028h,0d0h,03ch,0d0h,05bh,0d0h,088h,0c0h,0cdh,0c1h,033h,0c1h,0cdh,0c2h,0b3h,0c4h	; 78da  (.<.[.....3.....
	defb 00dh,0c6h,014h,0b0h,01bh,0b0h,028h,0b0h,03ch,0b0h,05bh,0a0h,088h,0a0h,0cdh,0b1h	; 78ea  ......(.<.[.....
	defb 033h,091h,0cdh,082h,0b3h,074h,00dh,076h,014h,0ffh,02ah,002h,000h,007h,0e0h,01ch	; 78fa  3....t.v..*.....
	defb 0e0h,01ah,0e0h,018h,0e0h,016h,0e0h,014h,0e0h,012h,0e0h,010h,0e0h,00eh,0e0h,00ch	; 790a  ................
	defb 0ffh,022h,001h,0f3h,0a0h,0f3h,0aeh,0f3h,0cch,0f3h,0bdh,0f3h,0cch,0f3h,0eah,0f3h	; 791a  ."..............
	defb 0fah,0f4h,00ah,0f4h,01ah,0f4h,02ah,0e2h,0c0h,0e2h,0cbh,0e2h,0d6h,0e2h,0e1h,0e2h	; 792a  ......*.........
	defb 0edh,0e2h,0f8h,0e3h,004h,0e3h,010h,0e3h,01ch,0e3h,029h,0d2h,0c0h,0d2h,0cbh,0d2h	; 793a  ..........).....
	defb 0d6h,0d2h,0e1h,0d2h,0edh,0d2h,0f8h,0d3h,004h,0d3h,010h,0d3h,01ch,0d3h,029h,0c2h	; 794a  ..............).
	defb 0c0h,0c2h,0cbh,0c2h,0d6h,0c2h,0e1h,0b2h,0edh,0b2h,0f8h,0b3h,004h,0a3h,010h,0a3h	; 795a  ................
	defb 01ch,093h,029h,0ffh,023h,001h,013h,093h,000h,014h,0a2h,000h,015h,0b3h,000h,016h	; 796a  ..).#...........
	defb 0b2h,000h,017h,0b3h,000h,018h,0a3h,000h,01dh,0b2h,000h,01eh,0b3h,000h,01ch,0e1h	; 797a  ................
	defb 080h,023h,003h,01fh,0d3h,000h,0d1h,080h,0e2h,000h,0f2h,080h,0c1h,080h,0b2h,000h	; 798a  .#..............
	defb 023h,006h,01fh,091h,0c0h,082h,060h,073h,000h,0ffh,023h,003h,010h,0f0h,010h,000h	; 799a  #.....`s..#.....
	defb 000h,0d0h,020h,000h,000h,0c0h,030h,022h,003h,0e0h,030h,000h,000h,0c0h,030h,000h	; 79aa  .. ...0"..0...0.
	defb 000h,0a0h,030h,000h,000h,080h,030h,000h,000h,070h,030h,0ffh,022h,001h,0e1h,010h	; 79ba  ..0...0..p0."...
	defb 0e1h,0a9h,0d2h,098h,0d4h,00dh,0d6h,055h,0e0h,06dh,0e0h,0aah,0d1h,004h,0d1h,09fh	; 79ca  .......U.m......
	defb 0c2h,089h,0b0h,071h,0b0h,0b0h,0a1h,013h,000h,000h,0a1h,0afh,092h,0a1h,090h,078h	; 79da  ...q...........x
	defb 000h,000h,080h,0bbh,081h,024h,071h,0c9h,000h,000h,072h,0cbh,0ffh,023h,001h,01dh	; 79ea  .....$q...r..#..
	defb 0e0h,010h,0e0h,020h,0e0h,010h,000h,000h,023h,002h,01dh,0e0h,01fh,0e0h,01ah,0e0h	; 79fa  ... ....#.......
	defb 000h,01dh,0b0h,000h,01eh,0c0h,01fh,0b0h,000h,01eh,0a0h,01dh,0a0h,000h,01fh,090h	; 7a0a  ................
	defb 01dh,090h,000h,01eh,080h,010h,0ffh,022h,001h,0f1h,040h,0f1h,090h,0f1h,0f0h,0f2h	; 7a1a  ......."..@.....
	defb 071h,0f3h,00dh,0f3h,0d0h,0f4h,0c4h,0f5h,0f5h,0d0h,060h,0d0h,078h,0d0h,096h,0d0h	; 7a2a  q.........`.x...
	defb 0bbh,0d0h,0eah,0d1h,024h,0d1h,06eh,0d1h,0c9h,0b0h,060h,0b0h,078h,0b0h,096h,0b0h	; 7a3a  ....$.n...`.x...
	defb 0bbh,0b0h,0eah,0b1h,024h,0b1h,06eh,0b1h,0c9h,090h,060h,090h,078h,090h,096h,090h	; 7a4a  ....$.n...`.x...
	defb 0bbh,090h,0eah,091h,024h,091h,06eh,091h,0c9h,0ffh,022h,001h,0f4h,08ch,0e4h,015h	; 7a5a  ....$.n...".....
	defb 0e4h,08ch,0d4h,015h,0d4h,08ch,0b4h,015h,0f2h,026h,0f2h,09fh,0f3h,01dh,0e2h,059h	; 7a6a  .........&.....Y
	defb 0e2h,0bdh,0e3h,03dh,0f2h,0b6h,0f3h,09eh,0f4h,0e9h,0f2h,0e9h,0f3h,0ceh,0f5h,034h	; 7a7a  ...=...........4
	defb 0f2h,0b6h,0f3h,09eh,0f4h,0e9h,0f2h,0e9h,0e3h,0ceh,0e5h,034h,0e2h,0b6h,0e3h,09eh	; 7a8a  ...........4....
	defb 0d4h,0e9h,0d2h,0e9h,0d3h,0ceh,0d5h,034h,0c2h,0b6h,0c3h,09eh,0c4h,0e9h,0c2h,0e9h	; 7a9a  .......4........
	defb 0c3h,0ceh,0b5h,034h,0b2h,0b6h,0b3h,09eh,0b4h,0e9h,0a2h,0e9h,0a3h,0ceh,0a5h,034h	; 7aaa  ...4...........4
	defb 092h,0b6h,093h,09eh,084h,0e9h,082h,0e9h,073h,0ceh,075h,034h,062h,0b6h,063h,09eh	; 7aba  ........s.u4b.c.
	defb 064h,0e9h,0ffh,023h,001h,01eh,0f0h,010h,0f0h,020h,000h,000h,0e0h,01ah,0e0h,027h	; 7aca  d..#..... .....'
	defb 000h,000h,0e0h,018h,0e0h,020h,0d0h,000h,0d0h,023h,0d0h,026h,0c0h,018h,0c0h,020h	; 7ada  ..... ...#.&...
	defb 000h,000h,0c0h,01ah,0c0h,027h,000h,000h,0c0h,023h,0c0h,026h,0b0h,018h,0b0h,020h	; 7aea  .....'...#.&...
	defb 000h,000h,0b0h,01ah,0b0h,027h,000h,000h,0b0h,023h,0b0h,026h,0a0h,018h,0a0h,020h	; 7afa  .....'...#.&...
	defb 000h,000h,0a0h,01ah,0a0h,027h,000h,000h,0a0h,023h,0a0h,016h,0a0h,018h,000h,000h	; 7b0a  .....'...#......
	defb 090h,023h,090h,026h,090h,018h,0ffh,022h,001h,0b2h,0fah,090h,010h,0b2h,0a7h,090h	; 7b1a  .#.&..."........
	defb 020h,0c2h,03bh,080h,010h,0d1h,0fdh,080h,020h,0f1h,0ach,080h,010h,0f1h,067h,080h	; 7b2a   ....... .....g.
	defb 020h,0f1h,02eh,080h,010h,0e0h,0fdh,0feh,002h,023h,07bh,080h,020h,0e0h,0e3h,080h	; 7b3a   ........#{. ...
	defb 010h,0e0h,0beh,080h,020h,0d3h,057h,080h,010h,0d0h,0aah,080h,020h,0d2h,0fah,080h	; 7b4a  .... .W..... ...
	defb 010h,0c0h,08fh,080h,020h,0c2h,0a7h,080h,010h,0c0h,07fh,080h,020h,0b2h,03bh,080h	; 7b5a  .... ....... ...
	defb 010h,0b0h,06bh,080h,020h,0b1h,0fdh,080h,010h,0a0h,04ch,080h,020h,0a1h,0ach,080h	; 7b6a  ..k. .....L. ...
	defb 010h,0a0h,039h,080h,020h,091h,067h,0ffh,022h,001h,0c2h,000h,0c2h,080h,021h,002h	; 7b7a  ..9. .g.".....!.
	defb 013h,0e0h,000h,000h,000h,019h,0e0h,000h,018h,0e0h,000h,017h,0d0h,000h,016h,0d0h	; 7b8a  ................
	defb 000h,015h,0c0h,000h,014h,0c0h,000h,013h,0b0h,000h,021h,005h,013h,0a0h,000h,090h	; 7b9a  ..........!.....
	defb 000h,070h,000h,060h,000h,050h,000h,0ffh,022h,001h,0c3h,0f0h,0c1h,0f8h,0c0h,0fch	; 7baa  .p.`.P..".......
	defb 0c0h,07eh,0c0h,03fh,0c0h,01fh,0ffh,022h,001h,0f0h,0a0h,0f1h,000h,0f1h,040h,0f1h	; 7bba  .~.?..."......@.
	defb 090h,0f1h,0f4h,0f2h,071h,0f3h,00dh,0f3h,0d0h,0f4h,0c4h,0feh,002h,0c3h,07bh,0e1h	; 7bca  ....q.........{.
	defb 000h,0e0h,0a0h,0e1h,040h,0e1h,090h,0e1h,0f0h,0e2h,071h,0e3h,00dh,0e3h,0d0h,0e4h	; 7bda  ....@.....q.....
	defb 0c4h,0d0h,0a0h,0d1h,000h,0d1h,040h,0d1h,090h,0d1h,0f4h,0c2h,071h,0c3h,00dh,0c3h	; 7bea  ......@.....q...
	defb 0d0h,0c4h,0c4h,0b1h,000h,0b1h,040h,0b1h,090h,0a1h,0f4h,0a2h,071h,0a3h,00dh,093h	; 7bfa  ......@.....q...
	defb 0d0h,0ffh,022h,001h,0d1h,0c0h,023h,001h,016h,0f3h,000h,022h,001h,0c1h,080h,023h	; 7c0a  .."...#...."...#
	defb 001h,016h,0c0h,04ch,022h,001h,0d1h,050h,023h,001h,016h,0d0h,04eh,01ah,0e1h,000h	; 7c1a  ...L"..P#...N...
	defb 022h,001h,0f0h,0b0h,022h,003h,000h,000h,023h,001h,01ah,0e3h,000h,022h,001h,0f1h	; 7c2a  "..."...#...."..
	defb 000h,0f1h,040h,0f1h,090h,0f1h,0f4h,0f2h,071h,0f3h,00dh,0f4h,0c4h,022h,003h,000h	; 7c3a  ..@.....q...."..
	defb 000h,023h,001h,01ah,0d3h,000h,022h,001h,0d4h,000h,022h,003h,000h,000h,022h,001h	; 7c4a  .#...."..."...".
	defb 0d1h,000h,0d1h,040h,0d1h,090h,0c1h,0f4h,0c2h,071h,0b3h,00dh,0b4h,0c4h,022h,003h	; 7c5a  ...@.....q....".
	defb 000h,000h,023h,001h,01ah,0b3h,000h,022h,001h,0c4h,000h,022h,003h,000h,000h,022h	; 7c6a  ..#...."..."..."
	defb 001h,0d1h,000h,0d1h,040h,0c1h,090h,0c1h,0f4h,0b2h,071h,0b3h,00dh,0a4h,0c4h,0ffh	; 7c7a  ....@.....q.....
	defb 022h,004h,070h,020h,090h,018h,0d0h,020h,0d0h,018h,0c0h,020h,0d0h,018h,0c0h,020h	; 7c8a  ".p ... ... ...
	defb 0d0h,018h,0c0h,020h,0b0h,018h,022h,005h,0a0h,020h,0a0h,018h,090h,020h,090h,018h	; 7c9a  ... ..".. ... ..
	defb 080h,020h,080h,018h,070h,020h,070h,018h,060h,020h,060h,018h,050h,020h,0ffh,022h	; 7caa  . ..p p.` `.P ."
	defb 001h,0e0h,0c6h,0d0h,0afh,0c0h,098h,0b0h,086h,0a0h,076h,0e0h,0beh,0d0h,0a6h,0c0h	; 7cba  ..........v.....
	defb 092h,0b0h,080h,0a0h,071h,0f0h,0aah,0e0h,095h,0d0h,083h,0c0h,073h,0b0h,065h,0f0h	; 7cca  ....q.......s.e.
	defb 0a0h,0e0h,08ch,0d0h,07bh,0c0h,06ch,0b0h,05fh,0e0h,08fh,0d0h,07dh,0c0h,06eh,0b0h	; 7cda  ....{.l._...}.n.
	defb 061h,0a0h,055h,0e0h,07fh,0d0h,06fh,0c0h,062h,0b0h,056h,0a0h,04bh,0ffh,022h,004h	; 7cea  a.U...o.b.V.K.".
	defb 0c0h,030h,0c0h,060h,0feh,004h,0fah,07ch,0ffh,022h,004h,0d0h,0aah,0e0h,08fh,0e0h	; 7cfa  .0.`...|."......
	defb 06bh,0e0h,055h,0d0h,047h,022h,003h,0c0h,035h,0b0h,035h,0a0h,035h,090h,035h,0ffh	; 7d0a  k.U.G"..5.5.5.5.
	defb 022h,005h,0c0h,040h,022h,003h,0c0h,025h,0b0h,025h,022h,005h,0a0h,025h,090h,025h	; 7d1a  "..@"..%.%"..%.%
	defb 080h,025h,070h,025h,060h,025h,0ffh,022h,001h,0b0h,0c0h,0b0h,0a8h,0b0h,093h,0b0h	; 7d2a  .%p%`%."........
	defb 080h,0b0h,070h,0b0h,062h,0b0h,056h,0b0h,04bh,0b0h,041h,0e0h,05ah,0e0h,04eh,0e0h	; 7d3a  ..p.b.V.K.A.Z.N.
	defb 044h,0e0h,03ch,0e0h,034h,0e0h,02eh,0e0h,028h,0e0h,023h,0e0h,01eh,0a0h,05ah,0a0h	; 7d4a  D.<.4...(.#...Z.
	defb 04eh,0a0h,044h,0a0h,03ch,0a0h,034h,0a0h,02eh,0a0h,028h,0a0h,023h,0a0h,01eh,080h	; 7d5a  N.D.<.4...(.#...
	defb 05ah,080h,04eh,080h,044h,080h,03ch,080h,034h,080h,02eh,080h,028h,080h,023h,080h	; 7d6a  Z.N.D.<.4...(.#.
	defb 01eh,0ffh,022h,004h,0a0h,035h,0b0h,02ah,0c0h,023h,0d0h,02ah,0c0h,023h,0b0h,01fh	; 7d7a  .."..5.*.#.*.#..
	defb 0b0h,01ch,0b0h,035h,022h,005h,0b0h,02ah,0a0h,023h,090h,02ah,080h,023h,070h,02ah	; 7d8a  ...5"..*.#.*.#p*
	defb 060h,023h,050h,02ah,0ffh,02ah,005h,000h,013h,0a0h,070h,022h,002h,000h,000h,02ah	; 7d9a  `#P*.*....p"...*
	defb 00eh,000h,013h,0a0h,070h,0ffh,022h,003h,0b0h,097h,0c0h,06ah,0d0h,07fh,0e0h,059h	; 7daa  ....p."....j...Y
	defb 0f0h,06ah,0f0h,04bh,0f0h,059h,0f0h,03fh,0f0h,04bh,0e0h,035h,0e0h,03fh,0d0h,02ch	; 7dba  .j.K.Y.?.K.5.?.,
	defb 022h,004h,000h,000h,0c0h,025h,000h,000h,0b0h,025h,000h,000h,0a0h,025h,000h,000h	; 7dca  "....%...%...%..
	defb 090h,025h,000h,000h,080h,025h,000h,000h,070h,025h,0ffh	; 7dda  .%...%..p%.

; ----------------------------------------------------------------------
; DATOS partitura_7DE5: la partitura del canal de 0xE193, que p00:500B pone a
;   mano (y p13:6104 toca); lo leen p00:500E (13 bytes)
;   0x7de5..0x7df2  (13 bytes)
DATA_partitura_7DE5:
	defb 0d1h,0fdh,088h,0e1h,004h,074h,044h,074h,0fdh,023h,0e0h,009h,0ffh	; 7de5  .....tDt.#...

; ----------------------------------------------------------------------
; DATOS efecto_7DF2: la envolvente del canal de 0xE178, que p00:50AC pone a
;   mano en 0xE184; se solapan 2 bloques (0x7DF2-0x7E03, 0x7E02-0x8000); lo
;   leen p00:50AF, p13:6197 (526 bytes)
;   0x7df2..0x8000  (526 bytes)
DATA_efecto_7DF2:
	defb 022h,001h,0e0h,05fh,090h,05fh,0d0h,05fh,022h,02dh,000h,000h,0feh,0feh,0f2h,07dh	; 7df2  ".._._._"-.....}
	defb 0ffh,0e9h,0d1h,0c0h,0e9h,0deh,0e8h,001h,08dh,0ffh,0e9h,0deh,0e8h,001h,09dh,0ffh	; 7e02  ................
	defb 0d1h,0c0h,0d5h,0e8h,006h,03fh,0d1h,0c1h,0ffh,0ffh,0e6h,0dch,0e8h,006h,083h,0e9h	; 7e12  .....?..........
	defb 0d1h,0c0h,0dbh,0e8h,006h,0adh,0e9h,0d1h,0c0h,0dbh,0c2h,0ebh,0ffh,0e6h,0dch,0e8h	; 7e22  ................
	defb 006h,093h,0e9h,0d1h,0c1h,0dbh,0e8h,006h,0adh,0e9h,0c2h,0ebh,0ffh,0e6h,0d1h,0e1h	; 7e32  ................
	defb 0c0h,0dch,0e8h,006h,093h,0e9h,0dbh,0e8h,006h,0bdh,0e9h,0c2h,0ebh,0ffh,0e9h,0d1h	; 7e42  ................
	defb 0c0h,0e9h,0dbh,0e8h,002h,06dh,0ffh,0ffh,0e9h,0d4h,0c0h,0e9h,0d9h,0e8h,001h,07bh	; 7e52  .....m.........{
	defb 0ffh,0ffh,0e9h,0ech,031h,0d7h,0fbh,023h,0edh,072h,07eh,081h,041h,0eah,064h,07eh	; 7e62  ....1..#.r~.A.d~
	defb 0e2h,043h,091h,081h,0ech,000h,093h,0ech,031h,081h,091h,0b1h,041h,061h,081h,091h	; 7e72  .C......1...Aa..
	defb 0e1h,041h,097h,0e2h,091h,0e1h,041h,091h,071h,051h,041h,053h,051h,021h,0e2h,091h	; 7e82  .A....A.qQASQ!..
	defb 0e1h,021h,073h,071h,051h,041h,021h,043h,041h,001h,051h,041h,021h,001h,0e2h,0b1h	; 7e92  .!sqQA!CA.QA!...
	defb 091h,0eeh,0e9h,0e7h,0d7h,0fch,025h,0e4h,091h,0b1h,0e3h,001h,0fah,025h,001h,0fch	; 7ea2  ......%......%..
	defb 025h,0e4h,091h,0fah,025h,091h,0fch,025h,041h,0fah,025h,041h,0fch,025h,061h,0fah	; 7eb2  %...%..%A.%A.%a.
	defb 025h,061h,0fch,025h,081h,0fah,025h,081h,0fch,025h,091h,0fah,025h,091h,0fch,025h	; 7ec2  %a.%..%..%..%..%
	defb 0b1h,0fah,025h,0b1h,0fch,025h,0e3h,001h,0fah,025h,001h,0fch,025h,011h,021h,041h	; 7ed2  ..%..%...%..%.!A
	defb 0fah,025h,041h,0fch,025h,0e4h,091h,0fah,025h,091h,0fch,025h,0e3h,021h,041h,051h	; 7ee2  .%A.%...%..%.!AQ
	defb 0fah,025h,051h,0fch,025h,021h,0fah,025h,021h,0fch,025h,0e4h,071h,091h,0b1h,0fah	; 7ef2  .%Q.%!.%!.%.q...
	defb 025h,0b1h,0fch,025h,0e4h,071h,0fah,025h,071h,0fch,025h,0e3h,001h,021h,041h,0fah	; 7f02  %..%.q.%q.%..!A.
	defb 025h,041h,0fch,025h,001h,0fah,025h,001h,0fch,025h,0e4h,0b1h,091h,081h,0fah,025h	; 7f12  %A.%..%..%.....%
	defb 081h,0fch,025h,041h,0fah,025h,041h,0eah,0a4h,07eh,0e9h,0e7h,0ech,031h,0d7h,0f9h	; 7f22  ..%A.%A..~...1..
	defb 020h,0e2h,0c3h,0edh,072h,07eh,081h,041h,0edh,072h,07eh,0eah,038h,07fh,0e6h,0d6h	; 7f32   ...r~.A.r~.8...
	defb 0fch,051h,0e8h,004h,092h,0e8h,006h,06ch,0ebh,0edh,05dh,07fh,0edh,087h,07fh,0edh	; 7f42  .Q.....l..].....
	defb 05dh,07fh,0edh,087h,07fh,0edh,00ch,080h,0eah,04bh,07fh,0e9h,0d6h,0fch,051h,0e2h	; 7f52  ]........K....Q.
	defb 025h,050h,070h,093h,0e1h,023h,003h,0e2h,07bh,0a5h,090h,070h,0a5h,090h,070h,093h	; 7f62  %Pp..#..{..p..p.
	defb 02bh,0e2h,025h,050h,070h,093h,0e1h,023h,043h,0e2h,09bh,0a5h,090h,070h,0a5h,090h	; 7f72  +.%Pp..#C....p..
	defb 070h,093h,0e1h,02bh,0eeh,0e9h,0d6h,0fch,051h,0e2h,0a3h,0a0h,090h,070h,050h,073h	; 7f82  p..+....Q....pPs
	defb 0a3h,093h,027h,030h,050h,071h,083h,080h,070h,050h,030h,053h,083h,073h,00bh,0e2h	; 7f92  ..'0Pq..pP0S.s..
	defb 0a3h,0a0h,090h,070h,050h,073h,0a3h,093h,090h,070h,050h,040h,053h,093h,073h,070h	; 7fa2  ...pPs...pP@S.sp
	defb 050h,040h,020h,083h,080h,070h,050h,040h,09bh,0fch,023h,040h,050h,070h,090h,0fch	; 7fb2  P@ ..pP@..#@Pp..
	defb 051h,0e1h,021h,0e2h,091h,0e1h,041h,0e2h,091h,0e1h,051h,040h,020h,041h,0e2h,091h	; 7fc2  Q.!...A...Q@ A..
	defb 0e1h,001h,0e2h,071h,0e1h,021h,0e2h,071h,0e1h,041h,020h,000h,021h,0e2h,071h,0e1h	; 7fd2  ...q.!.q.A .!.q.
	defb 031h,0e2h,0a1h,0e1h,051h,0e2h,0a1h,0e1h,071h,050h,030h,051h,0e2h,0a1h,0e1h,020h	; 7fe2  1...Q...qP0Q...
	defb 040h,050h,070h,0fbh,051h,020h,040h,050h,070h,0fah,051h,020h,040h,050h	; 7ff2  @Pp.Q @Pp.Q @P
