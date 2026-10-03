; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l9253h:	equ 0x09253

; ----------------------------------------------------------------------
; DATOS partida_7FFE_cola: la instruccion de p01:7FFE (21 D2 | E0) empieza al
;   final del banco 1 y acaba al principio del 2, que el cartucho pone siempre
;   a continuacion: aqui el resto; lo leen p01:7FFE (1 bytes)
;   0x8000..0x8001  (1 bytes)
DATA_partida_7FFE_cola:
	defb 0e0h	; 8000

; ======================================================================
; CODIGO 0x8001..0x8003  (2 bytes)
; ======================================================================


L_8001:
	inc (hl)			;8001
jefe_5:		; el jefe 5: nada (ningun mapa lo usa)
	ret			;8002   ; el jefe 5 no hace nada: ningun mapa lo usa (0x5E05) y su vida es 0 (p01:7F97)

; ----------------------------------------------------------------------
; DATOS sitios_8003: 8 parejas [Y][X] que p01:7FEE elige con (0xE643) mod 8
;   (0x414C) para crear la figura 0x63 con p00:424C
;   0x8003..0x8013  (16 bytes)
DATA_sitios_8003:
	defb 070h,040h	; 8003
	defb 098h,060h	; 8005
	defb 090h,080h	; 8007
	defb 050h,060h	; 8009
	defb 040h,040h	; 800b
	defb 0b0h,040h	; 800d
	defb 060h,080h	; 800f
	defb 080h,060h	; 8011

; ======================================================================
; CODIGO 0x8013..0x8176  (355 bytes)
; ======================================================================


sale_jefe_1:		; el jefe 1 sale (y 0x68, x 0x98)
	ld a,068h		;8013   ; el jefe 1 sale: y = 0x68 (tambien su suelo, (ix+0x1E)), x = 0x98
	ld (ix+005h),a		;8015
	ld (ix+01eh),a		;8018
	ld (ix+007h),098h		;801b
	call espera_de_saltar		;801f   ; esperas al azar
	call espera_de_escupir		;8022   ; espera_de_escupir: 0xE71F = 0x10-0x2F al azar
	ld de,00080h		;8025   ; velocidad 0x80 hacia el personaje
	call 07fbeh		;8028
	jp L_80C9		;802b
jefe_1:		; el jefe 1 (mundo 1): anda, salta y escupe
	ld a,(0e701h)		;802e   ; el jefe 1 (mundo 1): por el paso (ix+1)
	dec a			;8031
	jr z,L_806C		;8032
	jp p,L_80AF		;8034
	dec (ix+01dh)		;8037   ; paso 0: andando hasta que vence (ix+0x1D)...
	jr z,L_804C		;803a
	call cabeza_jefe_1		;803c   ; ...la cabeza sube y baja...
	dec (ix+01fh)		;803f   ; ...cada (ix+0x1F) cuadros escupe (p02:80DC)...
	call z,escupe_jefe_1		;8042   ; escupe_jefe_1: tres figuras 0x54 desde la boca y el sonido 0x11
	call borde_jefe_1		;8045   ; ...y en el borde da la vuelta
	call c,07fach		;8048
	ret			;804b
L_804C:
	inc (ix+001h)		;804c   ; al paso 1: el salto
	ld (ix+00ah),00dh		;804f   ; mosaico 13
	call quieto_en_x		;8053   ; quieto_en_x: velocidad de lado 0
	ld a,r		;8056   ; la altura del salto al azar: 0x35, 0x45, 0x55 o 0x65
	and 003h		;8058
	inc a			;805a
	inc a			;805b
	inc a			;805c
	add a,a			;805d
	add a,a			;805e
	add a,a			;805f
	add a,a			;8060
	add a,005h		;8061
	ld (ix+018h),a		;8063
	ld de,0f900h		;8066   ; velocidad vertical -7
	jp 07fb5h		;8069
L_806C:
	call mosaico_cada_4		;806c   ; paso 1, saltando: los mosaicos y el sonido...
	call sonido_cada_16		;806f   ; sonido_cada_16: cada 16 cuadros el sonido 0x0A
	call 07fc7h		;8072   ; ...se mueve...
	ld a,(0e705h)		;8075   ; ...subiendo (bit 7 de la velocidad)...
	bit 7,(ix+00dh)		;8078
	jr nz,L_8084		;807c
	cp (ix+01eh)		;807e   ; ...bajando, hasta su suelo
	jr nc,L_8095		;8081
	ret			;8083
L_8084:
	cp (ix+018h)		;8084   ; subiendo, hasta la altura del salto...
	ret nc			;8087
	ld de,(0e70ch)		;8088   ; ...y empieza a bajar
	call 0415ch		;808c   ; de_negado: DE = -DE
	ld (0e70ch),de		;808f
	jr escupe_jefe_1		;8093
L_8095:
	call espera_de_saltar		;8095   ; en el suelo: espera al azar, mosaico 12, 0x3C cuadros quieto, paso 2
	ld (ix+00ah),00ch		;8098
	ld (ix+008h),03ch		;809c
	ld (ix+001h),002h		;80a0
	call quita_bit_4		;80a4   ; p02:8775 y p02:871A
	call quieto_en_y		;80a7   ; quieto_en_y: velocidad vertical 0
	ld a,021h		;80aa   ; el sonido 0x21 al caer
	jp 04e1fh		;80ac   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_80AF:
	dec (ix+008h)		;80af   ; paso 2: espera...
	ret nz			;80b2
	call paso_0_del_jefe		;80b3   ; ...p02:86F8 y el bit 4...
	set 4,(ix+002h)		;80b6
	inc (ix+019h)		;80ba
	ld a,(0e719h)		;80bd   ; ...una de cada cuatro veces hacia donde caiga...
	and 003h		;80c0
	jr nz,L_80C9		;80c2
	ld a,r		;80c4
	rra			;80c6
	jr L_80CF		;80c7
L_80C9:
	ld a,(0e507h)		;80c9   ; ...las demas hacia el personaje
	cp (ix+007h)		;80cc
L_80CF:
	ld de,00080h		;80cf   ; velocidad 0x80, hacia la izquierda si el personaje esta a la izquierda
	call c,0415ch		;80d2   ; de_negado: DE = -DE
	ld (ix+00ah),00ch		;80d5   ; mosaico 12, a andar
	jp 07fa3h		;80d9
escupe_jefe_1:		; tres figuras 0x54 desde la boca y el sonido 0x11
	call espera_de_escupir		;80dc   ; escupe: la espera siguiente al azar...
	ld b,003h		;80df   ; ...y tres figuras 0x54 desde la boca
L_80E1:
	push bc			;80e1
	ld e,(ix+007h)		;80e2
	ld d,(ix+005h)		;80e5
	dec b			;80e8
	ld a,054h		;80e9
	call 0407dh		;80eb
	pop bc			;80ee
	djnz L_80E1		;80ef
	ld a,011h		;80f1   ; con el sonido 0x11
	jp 04059h		;80f3   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
espera_de_escupir:		; 0xE71F = 0x10-0x2F al azar
	ld a,r		;80f6   ; la espera hasta escupir: 0x10-0x2F cuadros
	and 01fh		;80f8
	add a,010h		;80fa
	ld (0e71fh),a		;80fc   ; guarda la espera hasta que el jefe escupe
	ret			;80ff
azar_50_cf:		; A al azar entre 0x50 y 0xCF
	ld a,r		;8100   ; A al azar entre 0x50 y 0xCF
	and 07fh		;8102
	add a,050h		;8104
	ret			;8106
espera_de_saltar:		; 0xE71D al azar
	call azar_50_cf		;8107   ; la espera hasta saltar
	ld (0e71dh),a		;810a   ; guarda la espera o el sitio siguiente del jefe
	ret			;810d
cabeza_jefe_1:		; la cabeza del jefe 1 sube y baja (mosaicos 12-14)
	ld (ix+005h),068h		;810e   ; la cabeza: abajo (mosaico 12)...
	ld (ix+00ah),00ch		;8112
	bit 7,(ix+00fh)		;8116   ; ...hacia la izquierda...
	jr nz,L_812B		;811a
	ld a,(0e604h)		;811c   ; ...cada 16 cuadros arriba (mosaico 14, y = 0x60)
	bit 4,a		;811f
	ret nz			;8121
	ld (ix+00ah),00eh		;8122
	ld (ix+005h),060h		;8126
	ret			;812a
L_812B:
	ld a,(0e604h)		;812b   ; hacia la derecha, cada 16 cuadros el 13
	bit 4,a		;812e
	ret nz			;8130
	ld (ix+00ah),00dh		;8131
	ret			;8135
borde_jefe_1:		; C al llegar a su borde
	bit 7,(ix+00fh)		;8136   ; C al llegar a su borde: x < 0x92 yendo a la izquierda...
	ld a,(0e707h)		;813a   ; lee la x del jefe
	jr z,L_8142		;813d
	cp 092h		;813f
	ret			;8141
L_8142:
	cp 0a0h		;8142   ; ...x >= 0xA0 yendo a la derecha
	ccf			;8144
	ret			;8145
mosaico_cada_4:		; cada 4 cuadros el bit 1 del mosaico
	ld a,(0e604h)		;8146   ; cada 4 cuadros el mosaico cambia de pareja (bit 1)
	and 003h		;8149
	ret nz			;814b
	ld a,(0e70ah)		;814c   ; lee el mosaico del jefe
	xor 002h		;814f
	jr L_816C		;8151
mosaico_y_sonido:		; el mosaico cada 8 y el sonido 0x0A cada 16
	call mosaico_cada_8		;8153   ; mosaico_cada_8: cada 8 cuadros el bit 0 del mosaico
sonido_cada_16:		; cada 16 cuadros el sonido 0x0A
	ld a,(0e604h)		;8156   ; cada 16 cuadros el sonido 0x0A
	and 00fh		;8159
	ret nz			;815b
	ld a,00ah		;815c
	jp 04e1fh		;815e   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
mosaico_cada_8:		; cada 8 cuadros el bit 0 del mosaico
	ld a,(0e604h)		;8161   ; cada 8 cuadros el mosaico cambia (bit 0)
	and 007h		;8164
	ret nz			;8166
	ld a,(0e70ah)		;8167   ; lee el mosaico del jefe
	xor 001h		;816a
L_816C:
	ld (0e70ah),a		;816c   ; guarda el mosaico del jefe
	ret			;816f
jefe_2:		; el jefe 2 (mundo 3): crece, escupe, encoge y cambia de sitio
	ld a,(0e701h)		;8170   ; el jefe 2 (mundo 3): por el paso
	call 04140h		;8173   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8176: 6 destinos del despachador de 0x4140 (call en p02:8173):
;   0x8182, 0x8201, 0x822F, 0x824B, 0x8276, 0x8325; lo leen p02:8173 (12
;   bytes)
;   0x8176..0x8182  (12 bytes)
DATA_tabla_8176:
	defb 082h,081h	; 8176
	defb 001h,082h	; 8178
	defb 02fh,082h	; 817a
	defb 04bh,082h	; 817c
	defb 076h,082h	; 817e
	defb 025h,083h	; 8180

; ======================================================================
; CODIGO 0x8182..0x81c4  (66 bytes)
; ======================================================================


L_8182:
	ld a,(0e505h)		;8182   ; paso 0: el personaje a menos de 0x19 de alto...
	sub (ix+005h)		;8185
	cp 019h		;8188
	jr nc,$+66		;818a
	bit 5,(ix+009h)		;818c   ; ...y cerca de la cabeza (bit 5: hacia donde mira)...
	jr z,L_819D		;8190
	call cabeza_jefe_2		;8192   ; cabeza_jefe_2: A = la x de la cabeza del jefe 2
	ld b,a			;8195
	ld a,(0e507h)		;8196   ; lee la x del personaje
	sub 008h		;8199
	jr L_81A8		;819b
L_819D:
	ld a,(0e507h)		;819d   ; lee la x del personaje
	sub 008h		;81a0
	ld b,a			;81a2
	ld a,(0e707h)		;81a3   ; lee la x del jefe
	and 0f8h		;81a6
L_81A8:
	sub b			;81a8
	cp 068h		;81a9   ; ...a menos de 0x68...
	jr nc,$+33		;81ab
	ld a,(0e70bh)		;81ad   ; ...con el cuerpo crecido 0x0C o mas...
	bit 5,(ix+009h)		;81b0
	jr nz,L_81B9		;81b4
	ld a,(0e715h)		;81b6
L_81B9:
	cp 00ch		;81b9
	jr c,$+17		;81bb
	ld a,r		;81bd   ; ...elige al azar una de cuatro (tabla que sigue)
	and 003h		;81bf
	call 04140h		;81c1   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_81C4: 4 destinos del despachador de 0x4140 (call en p02:81C1):
;   0x81CC, 0x81E9, 0x8244, 0x81E9; lo leen p02:81C1 (8 bytes)
;   0x81c4..0x81cc  (8 bytes)
DATA_tabla_81C4:
	defb 0cch,081h	; 81c4
	defb 0e9h,081h	; 81c6
	defb 044h,082h	; 81c8
	defb 0e9h,081h	; 81ca

; ======================================================================
; CODIGO 0x81cc..0x8287  (187 bytes)
; ======================================================================


L_81CC:
	call mosaico_cada_8		;81cc   ; crece: cada 4 cuadros una columna mas...
	bit 5,(ix+009h)		;81cf
	jr z,L_81E3		;81d3
	ld a,(0e604h)		;81d5   ; lee el contador de cuadros de partida
	and 003h		;81d8
	ret nz			;81da
	inc (ix+00bh)		;81db
	ld a,(0e70bh)		;81de
	jr L_81E6		;81e1
L_81E3:
	ld a,(0e715h)		;81e3
L_81E6:
	cp 010h		;81e6   ; ...hasta 16
	ret nz			;81e8
L_81E9:
	inc (ix+001h)		;81e9   ; entero: al paso siguiente, 0x1E cuadros
	ld (ix+008h),01eh		;81ec
	call quita_bit_4		;81f0   ; quita_bit_4: quita el bit 4 de las banderas
	ld b,00ah		;81f3   ; mosaico 10 u 11 segun hacia donde mira
	bit 5,(ix+009h)		;81f5
	jr z,L_81FD		;81f9
	ld b,00bh		;81fb
L_81FD:
	ld (ix+00ah),b		;81fd
	ret			;8200
L_8201:
	dec (ix+008h)		;8201   ; paso: espera y escupe una figura 0x57 desde la boca
	ret nz			;8204
	inc (ix+001h)		;8205
	ld (ix+008h),060h		;8208   ; 0x60 cuadros
	ld b,000h		;820c
	bit 5,(ix+009h)		;820e
	jr z,L_821B		;8212
	call cabeza_jefe_2		;8214   ; cabeza_jefe_2: A = la x de la cabeza del jefe 2
	add a,008h		;8217
	jr L_8223		;8219
L_821B:
	inc b			;821b
	ld a,(0e707h)		;821c   ; lee la x del jefe
	and 0f8h		;821f
	sub 010h		;8221
L_8223:
	ld e,a			;8223
	ld a,(0e705h)		;8224   ; lee la y del jefe
	add a,008h		;8227
	ld d,a			;8229
	ld a,057h		;822a
	jp 0407dh		;822c
L_822F:
	dec (ix+008h)		;822f   ; paso: espera; mosaico 8 o 6
	ret nz			;8232
	ld b,008h		;8233
	bit 5,(ix+009h)		;8235
	jr nz,L_8241		;8239
	ld b,006h		;823b
	set 4,(ix+002h)		;823d
L_8241:
	ld (ix+00ah),b		;8241
L_8244:
	ld (ix+001h),003h		;8244   ; al paso 3
	jp 07fach		;8248
L_824B:
	call mosaico_cada_8		;824b   ; encoge: cada 4 cuadros una columna menos...
	bit 5,(ix+009h)		;824e
	jr z,L_825D		;8252
	ld a,(0e604h)		;8254   ; lee el contador de cuadros de partida
	and 003h		;8257
	ret nz			;8259
	dec (ix+00bh)		;825a
L_825D:
	call jefe_2_encogido		;825d   ; ...hasta p02:8351
	ret nc			;8260
	bit 5,(ix+009h)		;8261
	jr z,L_826B		;8265
	ld (ix+00bh),001h		;8267
L_826B:
	ld (ix+008h),01eh		;826b   ; 0x1E cuadros, banderas a 0 y p02:84DA
	ld (ix+002h),000h		;826f
	jp paso_del_jefe		;8273   ; paso_del_jefe: sube el paso del jefe (ix+1)
L_8276:
	inc (ix+019h)		;8276   ; al paso 5: el sitio siguiente...
L_8279:
	ld (ix+001h),005h		;8279
	ld a,(0e719h)		;827d   ; ...segun los bits 2-3 de 0xE719 (tabla que sigue)
	rra			;8280
	rra			;8281
	and 003h		;8282
	call 04140h		;8284   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8287: 4 destinos del despachador de 0x4140 (call en p02:8284):
;   0x828F, 0x829B, 0x82C6, 0x82DB; lo leen p02:8284 (8 bytes)
;   0x8287..0x828f  (8 bytes)
DATA_tabla_8287:
	defb 08fh,082h	; 8287
	defb 09bh,082h	; 8289
	defb 0c6h,082h	; 828b
	defb 0dbh,082h	; 828d

; ======================================================================
; CODIGO 0x828f..0x8341  (178 bytes)
; ======================================================================


L_828F:
	call franja_del_personaje		;828f   ; cerca del personaje...
	ld a,(0e503h)		;8292
	rra			;8295
	rl c		;8296
	ld a,c			;8298
	jr L_82DF		;8299
L_829B:
	call franja_del_personaje		;829b   ; ...al azar alrededor...
	dec c			;829e   ; una franja menos...
	ld a,r		;829f   ; ...y un salto al azar de la tabla 0x8349...
	and 007h		;82a1
	ld hl,08349h		;82a3
	ld e,a			;82a6
	ld d,000h		;82a7
	add hl,de			;82a9
	ld a,(hl)			;82aa
	add a,c			;82ab
	jr z,L_82B9		;82ac   ; ...entre 1 y 4
	jp m,L_82B9		;82ae
	cp 005h		;82b1
	jr c,L_82BA		;82b3
	ld a,004h		;82b5
	jr L_82BA		;82b7
L_82B9:
	inc a			;82b9
L_82BA:
	ld b,a			;82ba
	ld a,(0e507h)		;82bb   ; lee la x del personaje
	cp 080h		;82be
	ccf			;82c0
	rl b		;82c1
	ld a,b			;82c3
	jr L_82DF		;82c4
L_82C6:
	ld a,(0e505h)		;82c6   ; ...en el cuarto de la pantalla del personaje...
	ld c,000h		;82c9
	cp 070h		;82cb
	jr c,L_82D1		;82cd
	ld c,004h		;82cf
L_82D1:
	ld a,(0e507h)		;82d1   ; lee la x del personaje
	cp 080h		;82d4
	rl c		;82d6
	ld a,c			;82d8
	jr L_82DF		;82d9
L_82DB:
	ld a,r		;82db   ; ...o del todo al azar (0-15)
	and 00fh		;82dd
L_82DF:
	ld (0e71dh),a		;82df   ; el sitio en 0xE71D
	res 5,(ix+009h)		;82e2
	bit 0,(ix+01dh)		;82e6   ; hacia un lado o al otro segun el bit 0 de (ix+0x1D)
	ld bc,0f806h		;82ea
	ld de,0fe00h		;82ed
	jr nz,L_8305		;82f0
	ld bc,00008h		;82f2
	ld de,00200h		;82f5
	set 5,(ix+009h)		;82f8
	ld (ix+00bh),001h		;82fc
	call quita_bit_4		;8300   ; quita_bit_4: quita el bit 4 de las banderas
	jr L_8309		;8303
L_8305:
	ld (ix+015h),001h		;8305   ; mirando a la izquierda
L_8309:
	ld (ix+00ah),c		;8309   ; el mosaico C y la x B
	ld (ix+007h),b		;830c
	call 07fa3h		;830f
	ld a,(0e71dh)		;8312   ; la y del sitio de la tabla 0x8341
	rra			;8315
	ld hl,08341h		;8316
	call 04155h		;8319   ; byte_de_tabla: A = el byte HL + A
	ld (0e705h),a		;831c   ; guarda la y del jefe
	ld a,001h		;831f   ; los graficos del jefe 2 vuelven a cargarse (vuelto del otro lado)
	ld (0e61bh),a		;8321   ; guarda el paso de los graficos del jefe 2
	ret			;8324
jefe_2_vuelta:		; el jefe 2 se vuelve a dibujar paso a paso
	push ix		;8325   ; paso 5: los graficos, paso a paso...
	call 0587bh		;8327   ; un_paso_del_jefe_2: un paso de los graficos del jefe 2
	pop ix		;832a
	ld a,(0e61bh)		;832c   ; lee el paso de los graficos del jefe 2
	and a			;832f
	ret nz			;8330
	bit 0,(ix+01dh)		;8331   ; ...y al acabar, banderas 0xF0 o 0xE0 segun hacia donde mira
	ld a,0f0h		;8335
	jr nz,L_833B		;8337
	ld a,0e0h		;8339
L_833B:
	ld (0e702h),a		;833b
	jp paso_0_del_jefe		;833e   ; paso_0_del_jefe: el paso del jefe a 0

; ----------------------------------------------------------------------
; DATOS ocho_bytes_8341: 8 bytes que p02:8316 elige con (0xE71D) / 2 y guarda
;   en 0xE705
;   0x8341..0x8349  (8 bytes)
DATA_ocho_bytes_8341:
	defb 020h,040h,060h,080h,0a0h,020h,0a0h,040h	; 8341   @`.. .@

; ----------------------------------------------------------------------
; DATOS ocho_bytes_8349: 8 bytes que p02:82A3 elige al azar (R mod 8) y suma a
;   C
;   0x8349..0x8351  (8 bytes)
DATA_ocho_bytes_8349:
	defb 000h,002h,001h,000h,001h,000h,002h,001h	; 8349  ........

; ======================================================================
; CODIGO 0x8351..0x8608  (695 bytes)
; ======================================================================


jefe_2_encogido:		; C si el jefe 2 esta encogido
	bit 5,(ix+009h)		;8351   ; C al estar encogido: x >= 0xF8 o ancho < 2
	jr nz,L_835E		;8355
	ld a,(0e707h)		;8357   ; lee la x del jefe
	cp 0f8h		;835a
	ccf			;835c
	ret			;835d
L_835E:
	ld a,(0e70bh)		;835e
	cp 002h		;8361
	ret			;8363
franja_del_personaje:		; C = la franja de la y del personaje (0-4)
	ld c,000h		;8364   ; C = la franja de la y del personaje: 0-4 (corte en 0x40, 0x60, 0x80, 0xA0)
	ld a,(0e505h)		;8366   ; lee la y del personaje
	cp 040h		;8369
	ret c			;836b
	inc c			;836c
	cp 060h		;836d
	ret c			;836f
	inc c			;8370
	cp 080h		;8371
	ret c			;8373
	inc c			;8374
	cp 0a0h		;8375
	ret c			;8377
	inc c			;8378
	ret			;8379
cabeza_jefe_2:		; A = la x de la cabeza del jefe 2
	ld a,(0e70bh)		;837a   ; la x de la cabeza: x + 8 x ancho
	add a,a			;837d
	add a,a			;837e
	add a,a			;837f
	add a,(ix+007h)		;8380
	ret			;8383
sale_jefe_3:		; el jefe 3 sale (y 0x90, x 0x60)
	call espera_de_soplar		;8384   ; el jefe 3 sale: y 0x90, x 0x60, mosaico 58
	ld (ix+005h),090h		;8387
	ld (ix+007h),060h		;838b
	ld (ix+00ah),03ah		;838f
jefe_3_a_un_lado:		; espera y velocidad al azar a un lado
	ld a,r		;8393   ; espera al azar...
	and 01fh		;8395
	ld (0e708h),a		;8397   ; guarda la espera del jefe
	ld a,r		;839a
L_839C:
	and 001h		;839c   ; ...y velocidad 0x100 a un lado o al otro
	ld de,0ff00h		;839e
	call z,0415ch		;83a1   ; de_negado: DE = -DE
	jp 07fa3h		;83a4
jefe_3:		; el jefe 3 (mundo 6): anda de lado y sopla burbujas
	ld a,(0e701h)		;83a7   ; el jefe 3 (mundo 6): por el paso
	dec a			;83aa
	jr z,L_83FC		;83ab
	call bordes_jefe_3		;83ad   ; paso 0: anda de lado entre sus bordes...
	dec (ix+01fh)		;83b0   ; ...hasta que vence la espera de soplar...
	jr z,L_83E2		;83b3
	call patas_jefe_3		;83b5   ; ...con las patas moviendose...
	ld a,(0e505h)		;83b8   ; ...el personaje encima: cambia de lado al azar...
	cp (ix+005h)		;83bb
	jr nc,L_83C6		;83be
	dec (ix+008h)		;83c0
	ret nz			;83c3
	jr jefe_3_a_un_lado		;83c4
L_83C6:
	ld a,(0e604h)		;83c6   ; ...si no, cada 32 cuadros va hacia el
	and 01fh		;83c9
	ret nz			;83cb
	ld a,(0e707h)		;83cc   ; lee la x del jefe
	and 0f8h		;83cf
	add a,028h		;83d1
	ld b,a			;83d3
	ld a,(0e507h)		;83d4   ; lee la x del personaje
	sub 008h		;83d7
	cp b			;83d9
	ld a,000h		;83da
	jr nc,L_83DF		;83dc
	inc a			;83de
L_83DF:
	jp L_839C		;83df
L_83E2:
	ld a,r		;83e2   ; sopla: la espera al azar...
	and 003h		;83e4
	inc a			;83e6
	add a,a			;83e7
	add a,a			;83e8
	add a,a			;83e9
	add a,a			;83ea
	and 030h		;83eb
	add a,00fh		;83ed
	ld (0e71fh),a		;83ef   ; guarda la espera hasta que el jefe escupe
	call quita_bit_4		;83f2   ; quita_bit_4: quita el bit 4 de las banderas
	call paso_del_jefe		;83f5   ; paso_del_jefe: sube el paso del jefe (ix+1)
	ld a,03ch		;83f8   ; ...mosaico 60 y al paso 1
	jr L_846B		;83fa
L_83FC:
	dec (ix+01fh)		;83fc   ; paso 1: soplando...
	jr z,L_8424		;83ff
	ld a,(0e71fh)		;8401   ; ...cada 16 cuadros...
	and 00fh		;8404
	ret nz			;8406
	ld b,006h		;8407   ; ...seis burbujas (figura 0x58) desde la boca
L_8409:
	push bc			;8409
	ld a,(0e707h)		;840a   ; lee la x del jefe
	add a,020h		;840d
	ld e,a			;840f
	ld a,(0e705h)		;8410   ; lee la y del jefe
	add a,010h		;8413
	ld d,a			;8415
	dec b			;8416
	ld a,058h		;8417
	call 0407dh		;8419
	pop bc			;841c
	djnz L_8409		;841d
	ld a,012h		;841f   ; con el sonido 0x12
	jp 04e1fh		;8421   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_8424:
	dec (ix+001h)		;8424   ; se acabo: al paso 0
	set 4,(ix+002h)		;8427
espera_de_soplar:		; 0xE71F = 0x1F-0x9E al azar
	call azar_50_cf		;842b   ; la espera de soplar: 0x1F-0x9E
	and 07fh		;842e
	add a,01fh		;8430
	ld (0e71fh),a		;8432   ; guarda la espera hasta que el jefe escupe
	ret			;8435
bordes_jefe_3:		; da la vuelta en la x 0x29 y 0x8C
	bit 7,(ix+00fh)		;8436   ; los bordes: x 0x29 por la izquierda...
	ld a,(0e707h)		;843a   ; lee la x del jefe
	jr z,L_8448		;843d
	ld b,029h		;843f
	cp b			;8441
	ret nc			;8442
	ld de,00100h		;8443
	jr L_844F		;8446
L_8448:
	ld b,08ch		;8448   ; ...0x8C por la derecha...
	cp b			;844a
	ret c			;844b
	ld de,0ff00h		;844c
L_844F:
	ld (ix+007h),b		;844f   ; ...y da la vuelta
	jp 07fa3h		;8452
patas_jefe_3:		; cada 8 cuadros los mosaicos 58-60
	ld a,(0e604h)		;8455   ; cada 8 cuadros las patas: mosaicos 58 59 60 59
	and 007h		;8458
	ret nz			;845a
	inc (ix+019h)		;845b
	ld a,(0e719h)		;845e   ; lee las veces que el jefe ha cambiado de sitio
	and 003h		;8461
	cp 003h		;8463
	jr nz,L_8469		;8465
	ld a,001h		;8467
L_8469:
	add a,03ah		;8469
L_846B:
	jp L_816C		;846b
sale_jefe_4:		; el jefe 4 sale (y 0x48, x 0x68)
	call quita_bit_4		;846e   ; el jefe 4 sale: y 0x48, x 0x68
	ld (ix+005h),048h		;8471
	ld (ix+007h),068h		;8475
	jr L_84E5		;8479
jefe_4:		; el jefe 4 (mundo 2): se abre y suelta semillas
	ld a,(0e701h)		;847b   ; el jefe 4 (mundo 2): por el paso
	dec a			;847e
	jr z,L_84A0		;847f
	jp p,L_84DE		;8481
	dec (ix+008h)		;8484   ; paso 0: cerrado (mosaico 16), a ratos 17
	jr z,L_8494		;8487
	ld a,(0e708h)		;8489   ; lee la espera del jefe
	cp 014h		;848c
	ret nc			;848e
	ld (ix+00ah),011h		;848f
	ret			;8493
L_8494:
	call azar_50_cf		;8494   ; abre: mosaico 18
	ld (0e708h),a		;8497   ; guarda la espera del jefe
	ld (ix+00ah),012h		;849a
	jr paso_del_jefe		;849e
L_84A0:
	dec (ix+008h)		;84a0   ; paso 1: abierto...
	jr z,L_84D2		;84a3
	ld a,(0e708h)		;84a5   ; ...cada 4 cuadros 18 o 19...
	and 003h		;84a8
	ret nz			;84aa
	ld a,(0e70ah)		;84ab   ; lee el mosaico del jefe
	xor 001h		;84ae
	ld (0e70ah),a		;84b0   ; guarda el mosaico del jefe
	cp 013h		;84b3   ; ...con el 19...
	ret nz			;84b5
	call azar_50_cf		;84b6   ; ...suelta una semilla (figura 0x59) al azar...
	and 00fh		;84b9
	ld b,a			;84bb
	ld a,010h		;84bc
	add a,(ix+007h)		;84be
	ld e,a			;84c1
	ld a,(ix+005h)		;84c2
	sub 008h		;84c5
	ld d,a			;84c7
	ld a,059h		;84c8
	call 0407dh		;84ca
	ld a,012h		;84cd   ; ...con el sonido 0x12
	jp 04059h		;84cf   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_84D2:
	ld (ix+00ah),011h		;84d2   ; se cierra: mosaico 17 y 0x14 cuadros
	ld (ix+008h),014h		;84d6
paso_del_jefe:		; sube el paso del jefe (ix+1)
	inc (ix+001h)		;84da   ; al paso siguiente
	ret			;84dd
L_84DE:
	dec (ix+008h)		;84de   ; paso 2: espera...
	ret nz			;84e1
	call paso_0_del_jefe		;84e2   ; paso_0_del_jefe: el paso del jefe a 0
L_84E5:
	call azar_50_cf		;84e5   ; ...y vuelve a empezar, mosaico 16
	ld (0e708h),a		;84e8   ; guarda la espera del jefe
	ld (ix+00ah),010h		;84eb
	ret			;84ef
sale_jefe_10:		; el jefe 10 sale (y 0x60, x 0x70, mosaico 28)
	set 6,(ix+009h)		;84f0   ; el jefe 10 sale: de mosaico (bit 6), y 0x60, x 0x70, mosaico 28
	ld (ix+00bh),000h		;84f4
	ld (ix+002h),0f0h		;84f8
	ld (ix+005h),060h		;84fc
	ld (ix+007h),070h		;8500
	ld (ix+00ah),01ch		;8504
	ld (ix+018h),023h		;8508   ; su cola: 0x23 y 0x1E en 0xE718 y 0xE719
	ld (ix+019h),01eh		;850c
	ld (ix+01ch),001h		;8510
	ld (ix+01ah),003h		;8514
	ld (ix+01dh),008h		;8518
	ld (ix+01bh),001h		;851c
	ld (ix+01eh),004h		;8520
	ld a,(0e705h)		;8524   ; la y en 0xE71F
	ld (0e71fh),a		;8527   ; guarda la espera hasta que el jefe escupe
	ld de,00400h		;852a   ; velocidad 4 abajo y -4 de lado
	call 07fb5h		;852d
	ld d,0fch		;8530
	jp 07fa3h		;8532
jefe_10:		; el jefe 10 (mundo 5): vuela, mueve la cola y escupe fuego
	call alas_jefe_10		;8535   ; el jefe 10 (mundo 5): las alas...
	ld a,(0e701h)		;8538   ; ...por el paso
	dec a			;853b
	jp z,L_85E1		;853c
	dec a			;853f
	jp z,L_860C		;8540
	dec (ix+01eh)		;8543   ; paso 0: volando un rato...
	jp z,L_85D1		;8546
	call rebote_y_jefe_10		;8549   ; ...rebotando arriba y abajo...
	call rebote_x_jefe_10		;854c   ; ...y a los lados
	dec (ix+01ah)		;854f   ; cada 8 cuadros la cola...
	ret nz			;8552
	ld (ix+01ah),008h		;8553
	ld a,(0e505h)		;8557   ; ...hacia la altura del personaje...
	ld b,a			;855a
	ld a,(0e71ch)		;855b   ; lee la fila de la cola del jefe 10
	rla			;855e
	rla			;855f
	rla			;8560
	and 0f8h		;8561
	add a,(ix+005h)		;8563
	ld c,001h		;8566
	cp b			;8568
	jr c,L_856D		;8569
	ld c,0ffh		;856b
L_856D:
	ld a,(0e719h)		;856d   ; lee las veces que el jefe ha cambiado de sitio
	add a,c			;8570
	cp 022h		;8571   ; ...entre 0x1D y 0x21 (0xE719)...
	jr nz,L_857F		;8573
	dec a			;8575
L_8576:
	ld (0e719h),a		;8576   ; ...y su fila en 0xE71C
	sub 01dh		;8579
	ld (0e71ch),a		;857b   ; guarda la fila de la cola del jefe 10
	ret			;857e
L_857F:
	cp 01dh		;857f
	jr nz,L_8576		;8581
	inc a			;8583
	jr L_8576		;8584
rebote_y_jefe_10:		; rebota entre la y 0x40 y 0x78
	ld a,(0e705h)		;8586   ; rebota entre la y 0x40 y la 0x78
	add a,(ix+00dh)		;8589
	cp 078h		;858c
	jr c,L_8598		;858e
	ld (ix+00dh),0ffh		;8590
	ld (ix+01dh),001h		;8594
L_8598:
	cp 040h		;8598
	ret nc			;859a
	ld (ix+00dh),002h		;859b
	ld (ix+01dh),001h		;859f
	ret			;85a3
rebote_x_jefe_10:		; rebota entre la x 0x40 y 0x88
	ld a,(0e707h)		;85a4   ; rebota entre la x 0x40 y la 0x88
	add a,(ix+00fh)		;85a7
	cp 088h		;85aa
	jr c,L_85B3		;85ac
	ld (ix+00fh),0ffh		;85ae
	ret			;85b2
L_85B3:
	cp 040h		;85b3
	ret nc			;85b5
	ld (ix+00fh),001h		;85b6
	ret			;85ba
alas_jefe_10:		; las alas cada 4 o 10 cuadros (p02:8ACD)
	dec (ix+01dh)		;85bb   ; las alas: cada 4 cuadros subiendo, cada 10 bajando
	ret nz			;85be
	ld (ix+01dh),004h		;85bf
	bit 7,(ix+00dh)		;85c3
	jp nz,mosaico_bit_0		;85c7   ; mosaico_bit_0: el mosaico del jefe cambia el bit 0
	ld (ix+01dh),00ah		;85ca
	jp mosaico_bit_0		;85ce   ; mosaico_bit_0: el mosaico del jefe cambia el bit 0
L_85D1:
	inc (ix+001h)		;85d1   ; al paso 1: quieto, cola 0x22, 0x10 cuadros
	res 4,(ix+002h)		;85d4
	ld (ix+018h),022h		;85d8
	ld (ix+01eh),010h		;85dc
	ret			;85e0
L_85E1:
	dec (ix+01eh)		;85e1   ; paso 1: espera...
	ret nz			;85e4
	inc (ix+001h)		;85e5   ; ...y escupe fuego: la boca segun la cola (tabla 0x8608)
	ld (ix+01eh),020h		;85e8
	ld a,(0e71ch)		;85ec   ; lee la fila de la cola del jefe 10
	dec a			;85ef
	ld hl,08608h		;85f0
	call 04155h		;85f3   ; byte_de_tabla: A = el byte HL + A
	ld c,(ix+005h)		;85f6
	add a,c			;85f9
	ld d,a			;85fa
	ld a,(0e707h)		;85fb   ; lee la x del jefe
	sub 010h		;85fe
	ld e,a			;8600
	ld b,002h		;8601   ; dos llamaradas (figura 0x57)
	ld a,057h		;8603
	jp 0407dh		;8605

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_8608: 4 bytes que p02:85F0 elige con (0xE71C) - 1 y suma
;   a (ix+5)
;   0x8608..0x860c  (4 bytes)
DATA_cuatro_bytes_8608:
	defb 008h,010h,018h,020h	; 8608

; ======================================================================
; CODIGO 0x860c..0x869c  (144 bytes)
; ======================================================================


L_860C:
	dec (ix+01eh)		;860c   ; paso 2: espera...
	ret nz			;860f
	set 4,(ix+002h)		;8610   ; ...y vuelve a volar 0x08-0x27 cuadros
	call 04de3h		;8614   ; azar: A = R con el contador de cuadros
	and 01fh		;8617
	add a,008h		;8619
	ld (ix+01eh),a		;861b
	ld (ix+001h),000h		;861e
	ld (ix+018h),023h		;8622
	ret			;8626
sale_jefe_7:		; el jefe 7 sale (y 0x40, x 0x68, mosaico 24)
	ld a,0f0h		;8627   ; el jefe 7 sale: y 0x40, x 0x68, mosaico 24
	and (ix+002h)		;8629
	ld (0e702h),a		;862c
	ld (ix+007h),068h		;862f
	ld (ix+005h),040h		;8633
	ld (ix+024h),030h		;8637   ; su ancho, 0x30
	ld (ix+00ah),018h		;863b
	inc (ix+01eh)		;863f
	inc (ix+01fh)		;8642
	ld (ix+030h),010h		;8645   ; 0x10 cuadros hasta sacar la lengua; 0xB0 hasta morder
	ld (ix+023h),0b0h		;8649
	ret			;864d
jefe_7:		; el jefe 7 (mundo 7): se mueve, saca la lengua y muerde
	bit 0,(ix+020h)		;864e   ; el jefe 7 (mundo 7): con la boca abierta (bit 0 de (ix+0x20))...
	jr z,L_868D		;8652
	dec (ix+021h)		;8654   ; ...cuenta (ix+0x21)...
	jr nz,L_868D		;8657
	ld a,(0e722h)		;8659   ; ...con 0xE722, mosaico 27 o 26 un rato mas...
	or a			;865c
	jr z,L_867D		;865d
	dec (ix+022h)		;865f
	jr z,L_867D		;8662
	ld a,(0e722h)		;8664   ; lee el jefe 7 ha mordido
	cp 002h		;8667
	ld (ix+021h),020h		;8669
	ld (ix+00ah),01bh		;866d
	jr z,L_868D		;8671
	ld (ix+021h),020h		;8673
	ld (ix+00ah),01ah		;8677
	jr L_868D		;867b
L_867D:
	ld (ix+020h),000h		;867d   ; ...luego cierra: mosaico 24
	ld (ix+022h),000h		;8681
	ld (ix+00ah),018h		;8685
	set 4,(ix+002h)		;8689
L_868D:
	ld hl,0e500h		;868d   ; hundiendose el personaje, muerde (p02:8765)
	ld a,(hl)			;8690
	cp 004h		;8691
	jp z,muerde_jefe_7		;8693   ; muerde_jefe_7: el jefe 7 muerde
	ld a,(0e701h)		;8696   ; por el paso
	call 04140h		;8699   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_869C: 4 destinos del despachador de 0x4140 (call en p02:8699):
;   0x86A4, 0x86C1, 0x86E0, 0x86FD; lo leen p02:8699 (8 bytes)
;   0x869c..0x86a4  (8 bytes)
DATA_tabla_869C:
	defb 0a4h,086h	; 869c
	defb 0c1h,086h	; 869e
	defb 0e0h,086h	; 86a0
	defb 0fdh,086h	; 86a2

; ======================================================================
; CODIGO 0x86a4..0x881b  (375 bytes)
; ======================================================================


L_86A4:
	bit 0,(ix+01eh)		;86a4   ; paso 0: a veces se mueve de lado (p02:877A)...
	jr z,L_86BC		;86a8
	call 04de3h		;86aa   ; azar: A = R con el contador de cuadros
	and 001h		;86ad
	jr z,L_86BC		;86af
	call 04de3h		;86b1   ; azar: A = R con el contador de cuadros
	and 001h		;86b4
	ld (0e71ch),a		;86b6   ; guarda la fila de la cola del jefe 10
	jp jefe_de_lado		;86b9   ; jefe_de_lado: 8 pasos de lado
L_86BC:
	ld (ix+001h),002h		;86bc   ; ...si no, al paso 2
	ret			;86c0
L_86C1:
	dec (ix+01bh)		;86c1   ; paso 1: de lado hasta el borde...
	call z,tope_x_paso		;86c4   ; tope_x_paso: un paso mas y C al llegar a un lado
	call c,07fach		;86c7
	ld a,(0e707h)		;86ca   ; ...o hasta la x 0x68 (el centro)
	cp 068h		;86cd
	jp nz,lengua_jefe_7		;86cf   ; lengua_jefe_7: cada 0x10 cuadros saca la lengua (figura 0x65)
	ld (ix+01fh),001h		;86d2
	ld (ix+001h),002h		;86d6
quieto_en_x:		; velocidad de lado 0
	ld de,00000h		;86da   ; quieto en x
	jp 07fa3h		;86dd
L_86E0:
	bit 0,(ix+01fh)		;86e0   ; paso 2: a veces arriba o abajo (p02:8795)...
	jr z,paso_0_del_jefe		;86e4
	call 04de3h		;86e6   ; azar: A = R con el contador de cuadros
	and 001h		;86e9
	jr z,paso_0_del_jefe		;86eb
	ld a,(0e71dh)		;86ed   ; lee la espera o el sitio siguiente del jefe
	xor 001h		;86f0
	ld (0e71dh),a		;86f2   ; guarda la espera o el sitio siguiente del jefe
	jp jefe_arriba_abajo		;86f5   ; jefe_arriba_abajo: 8 pasos arriba o abajo
paso_0_del_jefe:		; el paso del jefe a 0
	ld (ix+001h),000h		;86f8   ; ...si no, al paso 0
	ret			;86fc
L_86FD:
	dec (ix+01bh)		;86fd   ; paso 3: arriba o abajo hasta la y 0x40 o 0x70
	call z,tope_y_jefe_7		;8700   ; tope_y_jefe_7: C al llegar arriba o abajo
	call c,jefe_vertical		;8703   ; jefe_vertical: velocidad 0x100 arriba o abajo
	ld a,(0e705h)		;8706   ; lee la y del jefe
	cp 070h		;8709
	jr z,L_8712		;870b
	cp 040h		;870d
	jp nz,lengua_jefe_7		;870f   ; lengua_jefe_7: cada 0x10 cuadros saca la lengua (figura 0x65)
L_8712:
	ld (ix+01eh),001h		;8712
	ld (ix+001h),000h		;8716
quieto_en_y:		; velocidad vertical 0
	ld de,00000h		;871a   ; quieto en y
	jp 07fb5h		;871d
lengua_jefe_7:		; cada 0x10 cuadros saca la lengua (figura 0x65)
	ld a,(0e722h)		;8720   ; sin 0xE722, cada 0x10 cuadros abre la boca...
	or a			;8723
	ret nz			;8724
	dec (ix+030h)		;8725
	jr nz,L_8752		;8728
	ld (ix+030h),010h		;872a   ; ...mosaico 25...
	ld (ix+00ah),019h		;872e
	ld (ix+020h),001h		;8732
	ld (ix+021h),018h		;8736
	ld a,(0e707h)		;873a   ; ...y saca una lengua (figura 0x65)...
	add a,018h		;873d
	ld e,a			;873f
	ld a,(0e705h)		;8740   ; lee la y del jefe
	add a,018h		;8743
	ld d,a			;8745
	ld b,000h		;8746
	ld a,065h		;8748
	call 0407dh		;874a
	ld a,011h		;874d   ; ...con el sonido 0x11
	jp 04059h		;874f   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_8752:
	ld a,(0e722h)		;8752   ; y al azar cada 0xB0 veces...
	or a			;8755
	ret nz			;8756
	call 04de3h		;8757   ; azar: A = R con el contador de cuadros
	and 001h		;875a
	ret nz			;875c
	dec (ix+023h)		;875d
	ret nz			;8760
	ld (ix+023h),0b0h		;8761
muerde_jefe_7:		; el jefe 7 muerde
	ld (ix+020h),001h		;8765   ; ...muerde: mosaico 26 tres veces
	ld (ix+022h),003h		;8769
	ld (ix+021h),020h		;876d
	ld (ix+00ah),01ah		;8771
quita_bit_4:		; quita el bit 4 de las banderas
	res 4,(ix+002h)		;8775   ; quita el bit 4
	ret			;8779
jefe_de_lado:		; 8 pasos de lado
	ld (ix+01bh),008h		;877a   ; de lado: 8 pasos de velocidad 0x100 segun (ix+0x1C)
	ld (ix+001h),001h		;877e
	ld (ix+01fh),000h		;8782
	bit 0,(ix+01ch)		;8786
	ld de,00100h		;878a
	jr z,L_8792		;878d
	ld de,0ff00h		;878f
L_8792:
	jp 07fa3h		;8792
jefe_arriba_abajo:		; 8 pasos arriba o abajo
	ld (ix+01bh),008h		;8795   ; arriba o abajo: 8 pasos de 0x100 segun (ix+0x1D)
	ld (ix+001h),003h		;8799
	ld (ix+01eh),000h		;879d
	bit 0,(ix+01dh)		;87a1
	ld de,00100h		;87a5
	jr z,L_87AD		;87a8
	ld de,0ff00h		;87aa
L_87AD:
	jp 07fb5h		;87ad
tope_y_jefe_7:		; C al llegar arriba o abajo
	inc (ix+01bh)		;87b0   ; C al llegar arriba (0x40) o abajo (0x70)
	ld a,(0e705h)		;87b3   ; lee la y del jefe
	bit 7,(ix+00dh)		;87b6
	jr z,L_87BF		;87ba
	cp 040h		;87bc
	ret			;87be
L_87BF:
	cp 070h		;87bf
	ccf			;87c1
	ret			;87c2
tope_x_paso:		; un paso mas y C al llegar a un lado
	inc (ix+01bh)		;87c3
tope_x_jefe:		; C al llegar a la izquierda o a la derecha
	ld a,(0e707h)		;87c6   ; C al llegar a la izquierda (0x18) o a la derecha (x + ancho >= 0xE0)
	bit 7,(ix+00fh)		;87c9
	jr z,L_87D2		;87cd
	cp 018h		;87cf
	ret			;87d1
L_87D2:
	add a,(ix+024h)		;87d2
	cp 0e0h		;87d5
	ccf			;87d7
	ret			;87d8
jefe_vertical:		; velocidad 0x100 arriba o abajo
	bit 7,(ix+00dh)		;87d9   ; velocidad 0x100 hacia arriba o hacia abajo
	ld de,00100h		;87dd
	call z,0415ch		;87e0   ; de_negado: DE = -DE
	jp 07fb5h		;87e3
sale_jefe_11:		; el jefe 11 sale (x 0x80, y 0x70, mosaico 43)
	ld a,0f0h		;87e6   ; el jefe 11 sale: x 0x80, y 0x70 (tambien su suelo, 0xE71B), mosaico 43
	or (ix+002h)		;87e8
	ld (0e702h),a		;87eb
	ld (ix+007h),080h		;87ee
	ld a,070h		;87f2
	ld (0e705h),a		;87f4   ; guarda la y del jefe
	ld (0e71bh),a		;87f7   ; guarda el suelo del jefe 11
	ld (ix+00ah),02bh		;87fa
	ld (ix+018h),008h		;87fe   ; 8 y su ancho 0x40
	ld (ix+024h),040h		;8802
	ld a,r		;8806   ; velocidad 0x80 a un lado al azar
	and 001h		;8808
	ld de,00080h		;880a
	jr z,L_8812		;880d
	ld de,0ff80h		;880f
L_8812:
	jp 07fa3h		;8812
jefe_11:		; el jefe 11 (mundo 4): se arrastra, se encoge y salta
	ld a,(0e701h)		;8815   ; el jefe 11 (mundo 4): por el paso
	call 04140h		;8818   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_881B: 5 destinos del despachador de 0x4140 (call en p02:8818):
;   0x8825, 0x885F, 0x8883, 0x88BA, 0x890E; lo leen p02:8818 (10 bytes)
;   0x881b..0x8825  (10 bytes)
DATA_tabla_881B:
	defb 025h,088h	; 881b
	defb 05fh,088h	; 881d
	defb 083h,088h	; 881f
	defb 0bah,088h	; 8821
	defb 00eh,089h	; 8823

; ======================================================================
; CODIGO 0x8825..0x8a1e  (505 bytes)
; ======================================================================


L_8825:
	call mosaico_jefe_11		;8825   ; paso 0: se arrastra (mosaicos)...
	call tope_x_jefe		;8828   ; ...y en el borde da la vuelta
	jr nc,L_8830		;882b
	call 07fach		;882d
L_8830:
	ld hl,0e507h		;8830   ; si el personaje queda delante, cerca...
	bit 7,(ix+00fh)		;8833
	ld a,(0e707h)		;8837   ; lee la x del jefe
	jr nz,L_8844		;883a
	add a,070h		;883c
	cp (hl)			;883e
	ld b,02dh		;883f
	ret c			;8841
	jr L_884A		;8842
L_8844:
	add a,0e0h		;8844
	cp (hl)			;8846
	ld b,02eh		;8847
	ret nc			;8849
L_884A:
	call 04de3h		;884a   ; ...tres de cada cuatro veces se encoge (mosaico 45 o 46)...
	and 003h		;884d
	ret z			;884f
	ld a,b			;8850
	ld (0e70ah),a		;8851   ; guarda el mosaico del jefe
	ld (0e71dh),a		;8854   ; guarda la espera o el sitio siguiente del jefe
	ld (ix+018h),008h		;8857
	inc (ix+001h)		;885b   ; ...y al paso 1
	ret			;885e
L_885F:
	res 4,(ix+002h)		;885f   ; paso 1: espera; luego mosaico 47 o 48 y al paso 2
	dec (ix+018h)		;8863
	ret nz			;8866
	bit 7,(ix+00fh)		;8867
	ld a,02fh		;886b
	jr z,L_8871		;886d
	ld a,030h		;886f
L_8871:
	ld (0e70ah),a		;8871   ; guarda el mosaico del jefe
	ld (0e71ch),a		;8874   ; guarda la fila de la cola del jefe 10
	ld (ix+018h),008h		;8877
	set 4,(ix+002h)		;887b
	inc (ix+001h)		;887f
	ret			;8882
L_8883:
	dec (ix+018h)		;8883   ; paso 2: espera; salta...
	ret nz			;8886
	inc (ix+001h)		;8887
	ld (ix+008h),008h		;888a
	ld (ix+019h),000h		;888e
	bit 7,(ix+00fh)		;8892   ; ...de lado 0x180...
	ld de,00180h		;8896
	jr z,L_889E		;8899
	ld de,0fe80h		;889b
L_889E:
	call 07fa3h		;889e
	ld de,00040h		;88a1   ; ...con gravedad 0x40...
	call 07fbeh		;88a4
	call 04de3h		;88a7   ; ...hacia arriba -0x480 (o -0x600 una de cada cuatro)
	and 003h		;88aa
	cp 001h		;88ac
	ld de,0fb80h		;88ae
	jp nz,07fb5h		;88b1
	ld de,0fa00h		;88b4
	jp 07fb5h		;88b7
L_88BA:
	call tope_x_jefe		;88ba   ; paso 3: en el aire...
	jr nc,L_88C5		;88bd
	ld de,00000h		;88bf
	call 07fa3h		;88c2
L_88C5:
	call 07fc7h		;88c5   ; ...cae...
	inc (ix+019h)		;88c8
	ld a,(0e719h)		;88cb   ; ...los primeros 0x20 cuadros, mosaico 43...
	cp 030h		;88ce
	jr nc,L_88DB		;88d0
	cp 020h		;88d2
	jr nc,L_88DB		;88d4
	ld (ix+00ah),02bh		;88d6
	ret			;88da
L_88DB:
	ld a,(0e71ch)		;88db   ; ...luego el contrario...
	xor 01fh		;88de
	ld (0e70ah),a		;88e0   ; guarda el mosaico del jefe
	ld a,(0e71bh)		;88e3   ; ...hasta el suelo
	cp (ix+005h)		;88e6
	ret nc			;88e9
	ld (ix+005h),070h		;88ea   ; en el suelo: 0x20 cuadros quieto
	ld (ix+008h),020h		;88ee
	ld a,(0e71dh)		;88f2   ; lee la espera o el sitio siguiente del jefe
	xor 003h		;88f5
	ld (0e70ah),a		;88f7   ; guarda el mosaico del jefe
	inc (ix+001h)		;88fa
	ld de,00000h		;88fd   ; quieto del todo
	call 07fa3h		;8900
	ld de,00000h		;8903
	call 07fb5h		;8906
	ld a,01ah		;8909   ; con el sonido 0x1A al caer
	jp 04059h		;890b   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_890E:
	dec (ix+008h)		;890e   ; paso 4: espera...
	ret nz			;8911
	inc (ix+01eh)		;8912   ; ...cada cuatro saltos, hacia un lado al azar...
	ld a,(0e71eh)		;8915
	cp 004h		;8918
	jr nz,L_8928		;891a
	ld (ix+01eh),000h		;891c
	ld a,r		;8920
	and 001h		;8922
	sub 001h		;8924
	jr L_892E		;8926
L_8928:
	ld a,(0e507h)		;8928   ; ...si no, hacia el personaje
	cp (ix+007h)		;892b
L_892E:
	ld de,0ff80h		;892e
	jr c,L_8936		;8931
	ld de,00080h		;8933
L_8936:
	ld (ix+001h),000h		;8936   ; y al paso 0, arrastrandose a 0x80
	ld (ix+008h),001h		;893a
	ld (ix+018h),008h		;893e
	jp 07fa3h		;8942
mosaico_jefe_11:		; cada 8 cuadros, mosaico 43 o 44
	dec (ix+018h)		;8945   ; cada 8 cuadros, mosaico 43 o 44
	ret nz			;8948
	ld (ix+018h),008h		;8949
	ld a,(0e70ah)		;894d   ; lee el mosaico del jefe
	cp 02bh		;8950
	ld a,02ch		;8952
	jr z,L_8958		;8954
	ld a,02bh		;8956
L_8958:
	ld (0e70ah),a		;8958   ; guarda el mosaico del jefe
	ret			;895b
sale_jefe_6:		; el jefe 6 sale (y 0x70, x 0x58) y las cuatro figuras 0x69
	ld (ix+002h),0f0h		;895c   ; el jefe 6 sale: y 0x70, x 0x58, mosaico 52
	ld (ix+005h),070h		;8960
	ld (ix+007h),058h		;8964
	ld (ix+00ah),034h		;8968
	ld (ix+016h),010h		;896c
	xor a			;8970   ; sin velocidad
	ld (0e70ch),a		;8971
	ld (0e70dh),a		;8974
	ld (0e71bh),a		;8977   ; guarda el suelo del jefe 11
	ld (0e717h),a		;897a
	ld (ix+00eh),080h		;897d
	ld (ix+00fh),a		;8981
	ld (ix+019h),002h		;8984   ; 2 y 0x30 para el fuego
	ld (ix+01ah),030h		;8988
	ld bc,00440h		;898c   ; cuatro figuras 0x69 en la fila 0x28, de 0x40 en 0x40 (las paredes)
L_898F:
	push bc			;898f
	ld d,028h		;8990   ; en la fila 0x28...
	ld e,c			;8992
	ld a,069h		;8993   ; ...la figura 0x69...
	call 0407dh		;8995
	pop bc			;8998
	ld a,c			;8999   ; ...cada 0x20 de x
	add a,020h		;899a
	ld c,a			;899c
	djnz L_898F		;899d
	ret			;899f
jefe_6:		; el jefe 6 (mundo 9): cambia de cabezas y escupe fuego
	call cabezas_jefe_6		;89a0   ; el jefe 6 (mundo 9): las cabezas y el fuego cada cuadro
	call fuego_jefe_6		;89a3   ; fuego_jefe_6: cada 0x10 cuadros dos llamaradas desde una boca (tabla 0x8A6E)
	ld a,(0e701h)		;89a6   ; paso 0...
	dec a			;89a9
	jr z,L_89D7		;89aa
	ld a,(0e71ch)		;89ac   ; ...con 0xE71C, para y al paso 1...
	and a			;89af
	jr nz,L_89C8		;89b0
	ld a,(0e707h)		;89b2   ; ...si no, cada 8 pixeles...
	and 007h		;89b5
	ret nz			;89b7
	ld a,(0e707h)		;89b8   ; ...dentro de la pantalla...
	add a,088h		;89bb
	cp 0d8h		;89bd
	ret nc			;89bf
	ld a,(0e70fh)		;89c0   ; ...cambia de sentido (0xE70F)
	cpl			;89c3
	ld (0e70fh),a		;89c4
	ret			;89c7
L_89C8:
	xor a			;89c8
	ld (0e71ch),a		;89c9   ; guarda la fila de la cola del jefe 10
	call quieto_en_x		;89cc   ; quieto_en_x: velocidad de lado 0
	ld (ix+018h),020h		;89cf   ; 0x20 cuadros
	inc (ix+001h)		;89d3
	ret			;89d6
L_89D7:
	dec (ix+018h)		;89d7   ; paso 1: espera mirando...
	jr z,L_89EB		;89da
	ld (ix+00eh),000h		;89dc
	ld a,(0e707h)		;89e0   ; lee la x del jefe
	cp 078h		;89e3   ; ...hacia el centro (x 0x78)
	ret nc			;89e5
	ld (ix+00eh),080h		;89e6
	ret			;89ea
L_89EB:
	ld (ix+001h),000h		;89eb   ; y al paso 0, hacia la izquierda
	ld de,0ff80h		;89ef
	jp 07fa3h		;89f2
cabezas_jefe_6:		; otras cabezas al azar (tabla 0x8A1E)
	dec (ix+016h)		;89f5   ; cada (ix+0x16) cuadros otras cabezas: la espera siguiente al azar...
	ret nz			;89f8
	call 04de3h		;89f9   ; azar: A = R con el contador de cuadros
	and 01fh		;89fc
	add a,003h		;89fe
	ld (0e716h),a		;8a00
	ld hl,08a1eh		;8a03   ; ...el mosaico de la tabla 0x8A1E (52, 53 o 54)...
	dec (ix+017h)		;8a06
	jr z,L_8A0D		;8a09
	inc hl			;8a0b
	inc hl			;8a0c
L_8A0D:
	ld a,r		;8a0d
	and 001h		;8a0f
	jr z,L_8A14		;8a11
	inc hl			;8a13
L_8A14:
	ld a,(hl)			;8a14
	ld (0e70ah),a		;8a15   ; guarda el mosaico del jefe
	sub 034h		;8a18   ; ...y cual en 0xE717
	ld (0e717h),a		;8a1a
	ret			;8a1d

; ----------------------------------------------------------------------
; DATOS dos_parejas_8a1e: dos parejas: p02:8A03 coge una u otra segun
;   (ix+0x17) y dentro un byte al azar
;   0x8a1e..0x8a22  (4 bytes)
DATA_dos_parejas_8a1e:
	defb 034h,036h,035h,035h	; 8a1e

; ======================================================================
; CODIGO 0x8a22..0x8a6e  (76 bytes)
; ======================================================================


fuego_jefe_6:		; cada 0x10 cuadros dos llamaradas desde una boca (tabla 0x8A6E)
	dec (ix+01ah)		;8a22   ; cada 0x30 cuadros escupe o no (0xE71B)
	jr nz,L_8A33		;8a25
	ld (ix+01ah),030h		;8a27
	ld a,(0e71bh)		;8a2b   ; lee el suelo del jefe 11
	xor 001h		;8a2e
	ld (0e71bh),a		;8a30   ; guarda el suelo del jefe 11
L_8A33:
	set 4,(ix+002h)		;8a33
	ld a,(0e71bh)		;8a37   ; lee el suelo del jefe 11
	and a			;8a3a
	ret z			;8a3b
	res 4,(ix+002h)		;8a3c   ; escupiendo, cada 0x10 cuadros...
	dec (ix+019h)		;8a40
	ret nz			;8a43
	ld (ix+019h),010h		;8a44
	ld (ix+016h),018h		;8a48
	ld a,(0e717h)		;8a4c   ; ...desde la boca de la cabeza de la tabla 0x8A6E...
	cp 003h		;8a4f
	jr nz,L_8A55		;8a51
	ld a,001h		;8a53
L_8A55:
	ld hl,08a6eh		;8a55
	call 0414ch		;8a58   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;8a5b
	ld a,(hl)			;8a5c
	add a,(ix+005h)		;8a5d
	ld d,a			;8a60
	inc hl			;8a61
	ld a,(hl)			;8a62
	add a,(ix+007h)		;8a63
	ld e,a			;8a66
	ld b,002h		;8a67   ; ...dos llamaradas (figura 0x57)
	ld a,057h		;8a69
	jp 0407dh		;8a6b

; ----------------------------------------------------------------------
; DATOS tabla_8a6e: 3 punteros que p02:8A55 elige con (0xE717) (el 3 vale 1) a
;   las parejas de 0x8A74
;   0x8a6e..0x8a74  (6 bytes)
DATA_tabla_8a6e:
	defb 074h,08ah	; 8a6e
	defb 076h,08ah	; 8a70
	defb 078h,08ah	; 8a72

; ----------------------------------------------------------------------
; DATOS parejas_8a74: 3 parejas [dY][dX] que p02:8A5C suma a la posicion
;   0x8a74..0x8a7a  (6 bytes)
DATA_parejas_8a74:
	defb 018h,0f8h	; 8a74
	defb 018h,0f0h	; 8a76
	defb 038h,0e8h	; 8a78

; ======================================================================
; CODIGO 0x8a7a..0x8ab0  (54 bytes)
; ======================================================================


sale_jefe_8:		; el jefe 8 sale (y 0x20, x 0x68, mosaico 40)
	ld (ix+01ah),00fh		;8a7a   ; el jefe 8 sale: y 0x20, x 0x68, mosaico 40
	ld (ix+019h),004h		;8a7e
	ld (ix+002h),0f0h		;8a82
	ld (ix+005h),020h		;8a86
	ld (ix+007h),068h		;8a8a
	ld (ix+00ah),028h		;8a8e
	ld (ix+018h),030h		;8a92
	ld (ix+01ch),080h		;8a96
	ld (ix+01eh),00ah		;8a9a
	call quieto_en_x		;8a9e   ; quieto
	jp quieto_en_y		;8aa1   ; quieto_en_y: velocidad vertical 0
jefe_8:		; el jefe 8 (mundo 8): va de lado y de arriba abajo hacia el personaje
	call jefe_8_vida		;8aa4   ; el jefe 8 (mundo 8): la cara (p02:8C8C) y por el paso
	ld a,(0e701h)		;8aa7   ; lee el paso del jefe
	ld hl,08ab0h		;8aaa
	call 04140h		;8aad   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8AB0: 8 destinos del despachador de 0x4140 (call en p02:8AAD):
;   0x8AC0, 0x8B14, 0x8B3A, 0x8B96, 0x8BAC, 0x8BBE, 0x8BE6, 0x8C00; lo leen
;   p02:8AAD (16 bytes)
;   0x8ab0..0x8ac0  (16 bytes)
DATA_tabla_8AB0:
	defb 0c0h,08ah	; 8ab0
	defb 014h,08bh	; 8ab2
	defb 03ah,08bh	; 8ab4
	defb 096h,08bh	; 8ab6
	defb 0ach,08bh	; 8ab8
	defb 0beh,08bh	; 8aba
	defb 0e6h,08bh	; 8abc
	defb 000h,08ch	; 8abe

; ======================================================================
; CODIGO 0x8ac0..0x8d33  (627 bytes)
; ======================================================================


L_8AC0:
	dec (ix+018h)		;8ac0   ; paso 0: espera moviendo la boca...
	jr z,L_8AD6		;8ac3
	dec (ix+01ah)		;8ac5
	ret nz			;8ac8
	ld (ix+01ah),00fh		;8ac9
mosaico_bit_0:		; el mosaico del jefe cambia el bit 0
	ld a,(0e70ah)		;8acd   ; ...el mosaico cambia (bit 0)
	xor 001h		;8ad0
	ld (0e70ah),a		;8ad2   ; guarda el mosaico del jefe
	ret			;8ad5
L_8AD6:
	ld (ix+00ah),025h		;8ad6   ; al acabar: mosaico 37...
	inc (ix+001h)		;8ada
	ld a,(0e507h)		;8add   ; ...apunta al personaje (su x y su fila)...
	ld (0e717h),a		;8ae0
	ld a,(0e505h)		;8ae3   ; lee la y del personaje
	and 0e0h		;8ae6
	sub 008h		;8ae8
	ld (0e716h),a		;8aea
	ld a,(0e707h)		;8aed   ; ...y se va a la izquierda o a la derecha segun donde este cada uno
	cp 080h		;8af0
	jr c,L_8B04		;8af2
	cp 098h		;8af4
	jp nc,jefe_a_la_izquierda		;8af6   ; jefe_a_la_izquierda: velocidad de lado 0x80 a la izquierda
	ld a,(0e717h)		;8af9
	cp 080h		;8afc
	jp c,jefe_a_la_izquierda		;8afe   ; jefe_a_la_izquierda: velocidad de lado 0x80 a la izquierda
	jp jefe_a_la_derecha		;8b01   ; jefe_a_la_derecha: velocidad de lado 0x80 a la derecha
L_8B04:
	cp 038h		;8b04
	jp c,jefe_a_la_derecha		;8b06   ; jefe_a_la_derecha: velocidad de lado 0x80 a la derecha
	ld a,(0e717h)		;8b09
	cp 080h		;8b0c
	jp c,jefe_a_la_izquierda		;8b0e   ; jefe_a_la_izquierda: velocidad de lado 0x80 a la izquierda
	jp jefe_a_la_derecha		;8b11   ; jefe_a_la_derecha: velocidad de lado 0x80 a la derecha
L_8B14:
	call mosaicos_cada_4		;8b14   ; paso 1: de lado hasta la x 0x38 o la 0x98...
	ld a,(0e707h)		;8b17   ; lee la x del jefe
	cp 038h		;8b1a
	jr z,L_8B21		;8b1c
	cp 098h		;8b1e
	ret nz			;8b20
L_8B21:
	inc (ix+001h)		;8b21
	ld a,(0e705h)		;8b24   ; ...si no esta abajo del todo, baja (mosaico 42)
	cp 0a0h		;8b27
	jr z,L_8B38		;8b29
	call jefe_8_ancho		;8b2b   ; jefe_8_ancho: y - 8, x + 8
	call quieto_en_x		;8b2e   ; quieto_en_x: velocidad de lado 0
	ld (ix+00ah),02ah		;8b31
	jp jefe_baja		;8b35   ; jefe_baja: velocidad vertical 4
L_8B38:
	jr L_8B6C		;8b38
L_8B3A:
	ld a,(0e705h)		;8b3a   ; paso 2: bajando hasta la y 0x98...
	cp 098h		;8b3d
	ret nz			;8b3f
	call jefe_8_estrecho		;8b40   ; jefe_8_estrecho: y + 8, x - 8
	call quieto_en_y		;8b43   ; quieto_en_y: velocidad vertical 0
	ld a,(0e707h)		;8b46   ; ...luego hacia el lado del personaje
	cp 038h		;8b49
	ld a,(0e717h)		;8b4b
	jr nz,L_8B5E		;8b4e
	cp 080h		;8b50
	jr c,L_8B6C		;8b52
	ld (ix+00ah),025h		;8b54
	inc (ix+001h)		;8b58
	jp jefe_a_la_derecha		;8b5b   ; jefe_a_la_derecha: velocidad de lado 0x80 a la derecha
L_8B5E:
	cp 080h		;8b5e
	jr nc,L_8B6C		;8b60
	ld (ix+00ah),025h		;8b62
	inc (ix+001h)		;8b66
	jp jefe_a_la_izquierda		;8b69   ; jefe_a_la_izquierda: velocidad de lado 0x80 a la izquierda
L_8B6C:
	res 4,(ix+002h)		;8b6c   ; al paso 4: 8 cuadros, mosaico 36, quieto
	ld (ix+020h),008h		;8b70
	ld (ix+001h),004h		;8b74
	xor a			;8b78
	ld (0e704h),a		;8b79
	ld (0e706h),a		;8b7c
	ld d,a			;8b7f
	ld e,a			;8b80
	call quieto_en_x		;8b81   ; quieto_en_x: velocidad de lado 0
	ld (ix+00ah),024h		;8b84
	call jefe_sube		;8b88   ; jefe_sube: velocidad vertical -2
	ld a,(0e705h)		;8b8b   ; si ya esta a la altura del personaje, al paso 6
	sub 008h		;8b8e
	cp (ix+016h)		;8b90
	jr z,L_8BC8		;8b93
	ret			;8b95
L_8B96:
	call mosaicos_cada_4		;8b96   ; paso 3: de lado hasta el borde
	ld a,(0e70fh)		;8b99
	and 080h		;8b9c
	ld a,(0e707h)		;8b9e   ; lee la x del jefe
	jr z,L_8BA7		;8ba1
	cp 038h		;8ba3
	jr z,L_8B6C		;8ba5
L_8BA7:
	cp 098h		;8ba7
	ret nz			;8ba9
	jr L_8B6C		;8baa
L_8BAC:
	dec (ix+020h)		;8bac   ; paso 4: espera; luego mosaico 42 y sube
	ret nz			;8baf
	inc (ix+001h)		;8bb0
	ld (ix+00ah),02ah		;8bb3
	set 4,(ix+002h)		;8bb7
	jp jefe_8_ancho		;8bbb   ; jefe_8_ancho: y - 8, x + 8
L_8BBE:
	ld a,(0e705h)		;8bbe   ; paso 5: hasta la fila del personaje
	cp (ix+016h)		;8bc1
	ret nz			;8bc4
	call jefe_8_estrecho		;8bc5   ; jefe_8_estrecho: y + 8, x - 8
L_8BC8:
	set 4,(ix+002h)		;8bc8   ; al paso 6: mosaico 37, 0x50 cuadros, hacia el personaje
	ld (ix+00ah),025h		;8bcc
	call quieto_en_y		;8bd0   ; quieto_en_y: velocidad vertical 0
	ld (ix+018h),050h		;8bd3
	ld (ix+001h),006h		;8bd7
	ld a,(0e707h)		;8bdb   ; lee la x del jefe
	cp (ix+017h)		;8bde
	jp nc,jefe_a_la_izquierda		;8be1   ; jefe_a_la_izquierda: velocidad de lado 0x80 a la izquierda
	jr jefe_a_la_derecha		;8be4
L_8BE6:
	call mosaicos_cada_4		;8be6   ; paso 6: de lado hasta que vence; luego mosaico 40, quieto y al paso 0
	dec (ix+018h)		;8be9
	ret nz			;8bec
	ld (ix+00ah),028h		;8bed
	ld de,00000h		;8bf1
	call 07fa3h		;8bf4
	ld (ix+018h),030h		;8bf7
	ld (ix+001h),000h		;8bfb
	ret			;8bff
jefe_8_herido:		; el jefe 8 herido escupe figuras 0x68
	dec (ix+01dh)		;8c00   ; paso 7, herido: cuenta (ix+0x1D)...
	jr z,L_8C42		;8c03
	ld a,(0e71dh)		;8c05   ; ...a 0x20, mosaico 39...
	cp 020h		;8c08
	jr nz,L_8C10		;8c0a
	ld (ix+00ah),027h		;8c0c
L_8C10:
	cp 010h		;8c10   ; ...por debajo de 0x10, mosaico 36...
	jr nc,L_8C20		;8c12
	ld (ix+00ah),024h		;8c14
	cp 009h		;8c18   ; ...y en el 9 el sonido 0x1B
	ld a,01bh		;8c1a
	jp z,04e1fh		;8c1c   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ret			;8c1f
L_8C20:
	cp 016h		;8c20   ; entre 0x11 y 0x15 escupe una figura 0x68 desde la boca...
	ret nc			;8c22
	cp 011h		;8c23
	ret c			;8c25
	ld a,(0e705h)		;8c26   ; lee la y del jefe
	add a,004h		;8c29
	ld d,a			;8c2b
	ld a,(0e707h)		;8c2c   ; lee la x del jefe
	and 0f8h		;8c2f
	add a,(ix+01eh)		;8c31
	ld e,a			;8c34
	ld a,(0e71eh)		;8c35   ; ...alternando el lado (0xE71E)
	xor 01ch		;8c38
	ld (0e71eh),a		;8c3a
	ld a,068h		;8c3d
	jp 0407dh		;8c3f
L_8C42:
	ld (ix+01ch),080h		;8c42   ; al acabar, vuelve al paso y al mosaico de antes
	set 4,(ix+002h)		;8c46
	ld a,(0e71bh)		;8c4a   ; lee el suelo del jefe 11
	ld (0e701h),a		;8c4d   ; guarda el paso del jefe
	ld a,(0e71fh)		;8c50   ; lee la espera hasta que el jefe escupe
	ld (0e70ah),a		;8c53   ; guarda el mosaico del jefe
	ret			;8c56
jefe_a_la_derecha:		; velocidad de lado 0x80 a la derecha
	ld (ix+00fh),000h		;8c57   ; de lado: velocidad 0x80 a la derecha...
	ld (ix+00eh),080h		;8c5b
	ret			;8c5f
jefe_a_la_izquierda:		; velocidad de lado 0x80 a la izquierda
	ld (ix+00fh),0ffh		;8c60   ; ...o a la izquierda
	ld (ix+00eh),080h		;8c64
	ret			;8c68
jefe_baja:		; velocidad vertical 4
	ld (ix+00dh),004h		;8c69   ; bajando: 4
	ld (ix+00ch),000h		;8c6d
	ret			;8c71
jefe_sube:		; velocidad vertical -2
	ld (ix+00dh),0feh		;8c72   ; subiendo: -2
	ld (ix+00ch),000h		;8c76
	ret			;8c7a
mosaicos_cada_4:		; cada 4 cuadros los mosaicos se alternan
	dec (ix+019h)		;8c7b   ; cada 4 cuadros los mosaicos se alternan (bits 0-1)
	ret nz			;8c7e
	ld (ix+019h),004h		;8c7f
	ld a,(0e70ah)		;8c83   ; lee el mosaico del jefe
	xor 003h		;8c86
	ld (0e70ah),a		;8c88   ; guarda el mosaico del jefe
	ret			;8c8b
jefe_8_vida:		; si baja la vida, el jefe 8 queda herido
	dec (ix+01ch)		;8c8c   ; la vida baja (0xE70D)...
	ret nz			;8c8f
	ld (ix+01ch),001h		;8c90
	ld a,(0e70dh)		;8c94
	add a,(ix+00ch)		;8c97   ; ...si ha cambiado...
	ret nz			;8c9a
	ld (0e71ch),a		;8c9b   ; ...queda herido: guarda paso y mosaico y al paso 7
	ld (ix+01dh),030h		;8c9e
	res 4,(ix+002h)		;8ca2
	ld a,(0e701h)		;8ca6   ; lee el paso del jefe
	ld (0e71bh),a		;8ca9   ; guarda el suelo del jefe 11
	ld (ix+001h),007h		;8cac
	ld a,(0e70ah)		;8cb0   ; lee el mosaico del jefe
	ld (0e71fh),a		;8cb3   ; guarda la espera hasta que el jefe escupe
	ld (ix+00ah),024h		;8cb6
	ret			;8cba
jefe_8_estrecho:		; y + 8, x - 8
	ld a,(0e705h)		;8cbb   ; y + 8, x - 8 (el mosaico estrecho)
	add a,008h		;8cbe
	ld (0e705h),a		;8cc0   ; guarda la y del jefe
	ld a,(0e707h)		;8cc3   ; lee la x del jefe
	sub 008h		;8cc6
	ld (0e707h),a		;8cc8   ; guarda la x del jefe
	ret			;8ccb
jefe_8_ancho:		; y - 8, x + 8
	ld a,(0e705h)		;8ccc   ; y - 8, x + 8 (el mosaico ancho)
	sub 008h		;8ccf
	ld (0e705h),a		;8cd1   ; guarda la y del jefe
	ld a,(0e707h)		;8cd4   ; lee la x del jefe
	add a,008h		;8cd7
	ld (0e707h),a		;8cd9   ; guarda la x del jefe
	ret			;8cdc
sale_jefe_9:		; GALIOUS sale (y 0x40, x 0x60) con ocho figuras 0x67
	ld (ix+017h),030h		;8cdd   ; el jefe 9 sale: 0x30 cuadros, mosaico 55, x 0x60, y 0x40
	ld (ix+034h),001h		;8ce1
	ld (ix+008h),0fah		;8ce5
	ld (ix+00ah),037h		;8ce9
	ld (ix+033h),001h		;8ced
	ld (ix+007h),060h		;8cf1
	ld (ix+005h),040h		;8cf5
	ld (ix+01dh),074h		;8cf9   ; su sitio de disparo, (0x74, 0x58)
	ld (ix+01eh),058h		;8cfd
	ld (ix+019h),008h		;8d01   ; ocho figuras 0x67 en (0x40, 0x60)...
L_8D05:
	ld a,(ix+018h)		;8d05   ; ...cada una con su byte de la tabla 0x8ED7
	ld hl,08ed7h		;8d08
	call 04083h		;8d0b   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+01ah),a		;8d0e
	ld e,060h		;8d11
	ld d,040h		;8d13
	ld b,000h		;8d15
	ld a,067h		;8d17
	call 0407dh		;8d19
	inc (ix+018h)		;8d1c
	dec (ix+019h)		;8d1f
	jr nz,L_8D05		;8d22
banderas_e0:		; banderas 0xE0
	ld a,0e0h		;8d24   ; banderas 0xE0
	or (ix+002h)		;8d26
	ld (ix+002h),a		;8d29
	ret			;8d2c
jefe_9:		; el jefe 9 (mundo 10, GALIOUS): lanza, desaparece y reaparece
	ld a,(ix+001h)		;8d2d   ; el jefe 9 (mundo 10, GALIOUS): por el paso
	call 04140h		;8d30   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8D33: 5 destinos del despachador de 0x4140 (call en p02:8D30):
;   0x8D3D, 0x8D65, 0x8D8B, 0x8DC1, 0x8DF7; lo leen p02:8D30 (10 bytes)
;   0x8d33..0x8d3d  (10 bytes)
DATA_tabla_8D33:
	defb 03dh,08dh	; 8d33
	defb 065h,08dh	; 8d35
	defb 08bh,08dh	; 8d37
	defb 0c1h,08dh	; 8d39
	defb 0f7h,08dh	; 8d3b

; ======================================================================
; CODIGO 0x8d3d..0x8ed7  (410 bytes)
; ======================================================================


L_8D3D:
	ld (ix+01bh),000h		;8d3d   ; paso 0: con figuras en marcha (p02:8E6D)...
	call quedan_figuras		;8d41   ; quedan_figuras: Z si no queda ninguna de las 8 primeras figuras
	jr z,L_8D5C		;8d44
	call mira_jefe_9		;8d46   ; ...mira al personaje...
	call cuenta_jefe_9		;8d49   ; ...y mientras no dispare...
	jr nz,L_8D58		;8d4c
	dec (ix+017h)		;8d4e   ; ...cuenta (ix+0x17); a 0, al paso 4
	jr nz,L_8D5C		;8d51
	ld (ix+001h),004h		;8d53
	ret			;8d57
L_8D58:
	call lanza_jefe_9		;8d58   ; lanza (p02:8E3E)
	ret nz			;8d5b
L_8D5C:
	dec (ix+008h)		;8d5c   ; espera; luego al paso 1
	ret nz			;8d5f
	ld (ix+001h),001h		;8d60
	ret			;8d64
L_8D65:
	call quedan_figuras		;8d65   ; paso 1: igual, y al acabar...
	jr z,L_8D76		;8d68
	call mira_jefe_9		;8d6a   ; mira_jefe_9: si el personaje esta cerca de su sitio de disparo
	call cuenta_jefe_9		;8d6d   ; cuenta_jefe_9: cuenta (ix+0x34); NZ si dispara
	jr z,L_8D76		;8d70
	call lanza_jefe_9		;8d72   ; lanza_jefe_9: las cuatro figuras desde (ix+0x25)
	ret nz			;8d75
L_8D76:
	ld (ix+008h),03fh		;8d76   ; ...0x3F cuadros y al paso 2
	ld (ix+001h),002h		;8d7a
	ld (ix+01bh),001h		;8d7e
banderas_a_cero:		; las banderas altas a 0: no se ve
	ld a,00fh		;8d82   ; banderas a 0 (no se ve)
	and (ix+002h)		;8d84
	ld (ix+002h),a		;8d87
	ret			;8d8a
L_8D8B:
	dec (ix+008h)		;8d8b   ; paso 2: espera; luego aparece en otro sitio al azar (tabla 0x8EDF)...
	ret nz			;8d8e
	call 04de3h		;8d8f   ; azar: A = R con el contador de cuadros
	and 007h		;8d92
	ld hl,08edfh		;8d94
	call 0414ch		;8d97   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld (ix+007h),e		;8d9a
	ld (ix+005h),d		;8d9d
	ld a,e			;8da0   ; ...con su sitio de disparo al lado...
	add a,014h		;8da1
	ld (ix+01dh),a		;8da3
	ld a,d			;8da6
	add a,018h		;8da7
	ld (ix+01eh),a		;8da9
	ld (ix+01bh),002h		;8dac
	ld (ix+008h),018h		;8db0   ; ...0x18 cuadros y al paso 3
	ld (ix+001h),003h		;8db4
	ld (ix+018h),003h		;8db8
	ld (ix+019h),000h		;8dbc
	ret			;8dc0
L_8DC1:
	dec (ix+018h)		;8dc1   ; paso 3: parpadea cada 3 cuadros...
	ret nz			;8dc4
	ld (ix+018h),003h		;8dc5
	bit 0,(ix+019h)		;8dc9
	jr z,L_8DD9		;8dcd
	ld a,0a0h		;8dcf
	or (ix+002h)		;8dd1
	ld (ix+002h),a		;8dd4
	jr L_8DDC		;8dd7
L_8DD9:
	call banderas_a_cero		;8dd9   ; banderas_a_cero: las banderas altas a 0: no se ve
L_8DDC:
	ld a,(ix+019h)		;8ddc
	xor 001h		;8ddf
	ld (ix+019h),a		;8de1
	dec (ix+008h)		;8de4   ; ...y al acabar, 0xFA cuadros y al paso 0
	ret nz			;8de7
	ld (ix+017h),030h		;8de8
	ld (ix+008h),0fah		;8dec
	ld (ix+001h),000h		;8df0
	jp banderas_e0		;8df4   ; banderas_e0: banderas 0xE0
L_8DF7:
	ld (ix+017h),030h		;8df7   ; paso 4: el ataque: 0x30 cuadros...
	call 04de3h		;8dfb   ; ...hacia un lado al azar...
	and 001h		;8dfe
	ld a,080h		;8e00
	jr nz,L_8E05		;8e02
	xor a			;8e04
L_8E05:
	ld (ix+024h),a		;8e05
	ld (ix+025h),a		;8e08
	ld a,004h		;8e0b
	ld (ix+022h),a		;8e0d
	ld (ix+01bh),a		;8e10
	call 04de3h		;8e13   ; ...un tiempo al azar...
	and 00fh		;8e16
	ld (ix+020h),a		;8e18
	xor a			;8e1b
	ld (ix+001h),a		;8e1c
	ld (ix+032h),a		;8e1f
	ld (ix+00ah),038h		;8e22   ; ...mosaico 56...
	ld (ix+034h),020h		;8e26
	ld (ix+023h),001h		;8e2a
	push ix		;8e2e   ; ...y 12 bytes de la ficha a cero (0x26-0x31)
	pop hl			;8e30
	ld a,026h		;8e31
	call 04136h		;8e33   ; hl_mas_a: HL += A
	ld b,00ch		;8e36
	xor a			;8e38
L_8E39:
	ld (hl),a			;8e39
	inc l			;8e3a
	djnz L_8E39		;8e3b
	ret			;8e3d
lanza_jefe_9:		; las cuatro figuras desde (ix+0x25)
	ld a,(ix+025h)		;8e3e   ; las cuatro figuras desde (ix+0x25)...
	ld hl,0e800h		;8e41   ; apunta a los huecos de figura (32 bytes cada uno)
	call 04136h		;8e44   ; hl_mas_a: HL += A
	ld b,004h		;8e47
L_8E49:
	ld a,(hl)			;8e49
	or a			;8e4a
	call z,quita_marca		;8e4b   ; ...las vacias quitan su marca...
	push hl			;8e4e
	ld a,01fh		;8e4f
	call 04136h		;8e51   ; hl_mas_a: HL += A
	bit 0,(hl)		;8e54   ; ...con la marca (byte 0x1F) se para
	pop hl			;8e56
	ret nz			;8e57
	ld a,020h		;8e58
	call 04136h		;8e5a   ; hl_mas_a: HL += A
	djnz L_8E49		;8e5d
	ld (ix+023h),b		;8e5f   ; ninguna: 0x23 a 0
	ret			;8e62
quita_marca:		; el byte 0x1F de la figura a 0
	push hl			;8e63
	ld a,01fh		;8e64
	call 04136h		;8e66   ; hl_mas_a: HL += A
	ld (hl),000h		;8e69
	pop hl			;8e6b
	ret			;8e6c
quedan_figuras:		; Z si no queda ninguna de las 8 primeras figuras
	xor a			;8e6d   ; Z si no queda ninguna de las 8 primeras figuras...
	ld b,008h		;8e6e
	ld hl,0e800h		;8e70   ; apunta a los huecos de figura (32 bytes cada uno)
L_8E73:
	call 04136h		;8e73   ; hl_mas_a: HL += A
	ld a,(hl)			;8e76
	or a			;8e77
	ret nz			;8e78
	ld a,020h		;8e79
	djnz L_8E73		;8e7b
	ld (ix+00ah),037h		;8e7d   ; ...y entonces mosaico 55
	ret			;8e81
cuenta_jefe_9:		; cuenta (ix+0x34); NZ si dispara
	dec (ix+034h)		;8e82   ; cuenta (ix+0x34); a 0, mosaico 55...
	ret nz			;8e85
	inc (ix+034h)		;8e86
	ld (ix+00ah),037h		;8e89
	bit 0,(ix+023h)		;8e8d   ; ...NZ con 0x23 o con la marca 0x1F
	ret nz			;8e91
	bit 0,(ix+01fh)		;8e92
	ret			;8e96
mira_jefe_9:		; si el personaje esta cerca de su sitio de disparo
	inc (ix+033h)		;8e97   ; (ix+0x33) da vueltas de 2 a 15
	ld a,(ix+033h)		;8e9a
	and 00fh		;8e9d
	cp 002h		;8e9f
	jr nc,L_8EA5		;8ea1
	ld a,002h		;8ea3
L_8EA5:
	ld (ix+033h),a		;8ea5
	ld a,(ix+023h)		;8ea8
	or a			;8eab
	ret nz			;8eac
	ld a,(0e507h)		;8ead   ; el personaje a menos de 0x1E de su sitio de disparo, de lado...
	sub (ix+01dh)		;8eb0
	jr nc,L_8EB6		;8eb3
	cpl			;8eb5
L_8EB6:
	cp 01eh		;8eb6
	jr nc,L_8ED2		;8eb8
	ld a,(0e505h)		;8eba   ; ...y de alto...
	sub 010h		;8ebd
	sub (ix+01eh)		;8ebf
	jr nc,L_8EC5		;8ec2
	cpl			;8ec4
L_8EC5:
	cp 01eh		;8ec5
	jr nc,L_8ED2		;8ec7
	ld (ix+01ch),090h		;8ec9   ; ...0x90 y dispara
	ld (ix+01fh),001h		;8ecd
	ret			;8ed1
L_8ED2:
	ld (ix+01ch),070h		;8ed2   ; si no, 0x70
	ret			;8ed6

; ----------------------------------------------------------------------
; DATOS ocho_bytes_8ed7: 8 bytes que p02:8D08 pone en (ix+0x1A) segun
;   (ix+0x18)
;   0x8ed7..0x8edf  (8 bytes)
DATA_ocho_bytes_8ed7:
	defb 000h,040h,080h,0c0h,020h,060h,0a0h,0e0h	; 8ed7  .@.. `..

; ----------------------------------------------------------------------
; DATOS ocho_sitios_8edf: 8 parejas que p02:8D94 elige al azar para (ix+7) y
;   (ix+5)
;   0x8edf..0x8eef  (16 bytes)
DATA_ocho_sitios_8edf:
	defb 060h,020h	; 8edf
	defb 080h,020h	; 8ee1
	defb 060h,040h	; 8ee3
	defb 070h,040h	; 8ee5
	defb 0a0h,040h	; 8ee7
	defb 030h,060h	; 8ee9
	defb 040h,060h	; 8eeb
	defb 0b0h,060h	; 8eed

; ======================================================================
; CODIGO 0x8eef..0x8f0a  (27 bytes)
; ======================================================================


sala_especial:		; la sala especial del mapa (0x8F0A): pista o tienda
	ld a,(0e041h)		;8eef   ; la sala especial: en los mundos...
	sub 002h		;8ef2
	ret c			;8ef4
	ld c,a			;8ef5
	ld b,000h		;8ef6
	ld hl,08f0ah		;8ef8   ; ...la sala de 0x8F0A del mapa
	add hl,bc			;8efb
	ld a,(0e042h)		;8efc   ; lee la sala
	cp (hl)			;8eff
	ret nz			;8f00
	ld hl,08f14h		;8f01   ; su tipo de 0x8F14 a 0xE690
	add hl,bc			;8f04
	ld a,(hl)			;8f05
	ld (0e690h),a		;8f06   ; guarda la sala especial (pista o tienda)
	ret			;8f09

; ----------------------------------------------------------------------
; DATOS sala_especial_por_mundo: una sala por mapa 2-11 que p02:8EF8 compara
;   con 0xE042
;   0x8f0a..0x8f14  (10 bytes)
DATA_sala_especial_por_mundo:
	defb 00fh,00fh,010h,011h,012h,013h,014h,015h,01bh,000h	; 8f0a  ..........

; ----------------------------------------------------------------------
; DATOS cosa_de_la_sala_especial: y lo que p02:8F01 pone en 0xE690 cuando se
;   esta en ella
;   0x8f14..0x8f1e  (10 bytes)
DATA_cosa_de_la_sala_especial:
	defb 00eh,00fh,010h,011h,00ch,012h,013h,00dh,014h,000h	; 8f14  ..........

; ======================================================================
; CODIGO 0x8f1e..0x8f4a  (44 bytes)
; ======================================================================


entra_en_sala_especial:		; todo a cero y la pantalla de la sala especial
	xor a			;8f1e   ; al entrar en la sala especial: todo a cero...
	ld h,a			;8f1f
	ld l,a			;8f20
	ld (0e691h),a		;8f21   ; guarda el paso de la sala especial
	ld (0e693h),a		;8f24   ; guarda se puede salir de la sala especial (2)
	ld (0e6cch),hl		;8f27
	ld (0e6ceh),a		;8f2a
	ld (0e695h),a		;8f2d
	call 0a8fch		;8f30   ; ...p03:A8FC...
	inc a			;8f33
	ld (0e692h),a		;8f34   ; ...el articulo del medio...
	call personaje_en_la_puerta		;8f37   ; ...el personaje, la pantalla, el titulo y los articulos
	call pantalla_de_sala_especial		;8f3a   ; pantalla_de_sala_especial: paredes, techo, suelo, puerta y recuadros
	call el_que_atiende		;8f3d   ; el_que_atiende: el nombre y el dibujo de quien atiende la sala especial (tabla 0x954C)
	jp articulos		;8f40   ; articulos: los dibujos de los tres articulos de la tienda
cuadro_de_sala_especial:		; cada cuadro, por el tipo de sala especial (tabla 0x8F4A)
	ld a,(0e690h)		;8f43   ; cada cuadro, por el tipo (tabla 0x8F4A)
	dec a			;8f46
	call 04140h		;8f47   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8F4A: 20 destinos del despachador de 0x4140 (call en p02:8F47):
;   0x90C0, 0x9126, 0x8F72, 0x9126, 0x9126, 0x9126, 0x9126, 0x92E8 ...; lo
;   leen p02:8F47 (40 bytes)
;   0x8f4a..0x8f72  (40 bytes)
DATA_tabla_8F4A:
	defb 0c0h,090h	; 8f4a
	defb 026h,091h	; 8f4c
	defb 072h,08fh	; 8f4e
	defb 026h,091h	; 8f50
	defb 026h,091h	; 8f52
	defb 026h,091h	; 8f54
	defb 026h,091h	; 8f56
	defb 0e8h,092h	; 8f58
	defb 026h,091h	; 8f5a
	defb 026h,091h	; 8f5c
	defb 026h,091h	; 8f5e
	defb 026h,091h	; 8f60
	defb 026h,091h	; 8f62
	defb 0e8h,092h	; 8f64
	defb 0e8h,092h	; 8f66
	defb 0e8h,092h	; 8f68
	defb 0e8h,092h	; 8f6a
	defb 0e8h,092h	; 8f6c
	defb 0e8h,092h	; 8f6e
	defb 0e8h,092h	; 8f70

; ======================================================================
; CODIGO 0x8f72..0x8f78  (6 bytes)
; ======================================================================


revivir:		; tipo 3: revivir al otro por 100 monedas, 100 flechas y 20 llaves
	ld a,(0e691h)		;8f72   ; tipo 3, revivir al otro personaje: por el paso
	call 04140h		;8f75   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8F78: 6 destinos del despachador de 0x4140 (call en p02:8F75):
;   0x8F84, 0x8FE9, 0x8FE9, 0x8FEA, 0x9075, 0x906E; lo leen p02:8F75 (12
;   bytes)
;   0x8f78..0x8f84  (12 bytes)
DATA_tabla_8F78:
	defb 084h,08fh	; 8f78
	defb 0e9h,08fh	; 8f7a
	defb 0e9h,08fh	; 8f7c
	defb 0eah,08fh	; 8f7e
	defb 075h,090h	; 8f80
	defb 06eh,090h	; 8f82

; ======================================================================
; CODIGO 0x8f84..0x9066  (226 bytes)
; ======================================================================


L_8F84:
	call cursor_al_primero		;8f84   ; paso 0: el nombre...
	ld hl,0e058h		;8f87   ; ...las vidas del otro (B) y 0xE05A + el otro (C)...
	ld a,(0e501h)		;8f8a   ; lee quien juega (0 Afrodita)
	xor 001h		;8f8d
	add a,l			;8f8f
	ld l,a			;8f90
	ld b,(hl)			;8f91
	inc l			;8f92
	inc l			;8f93
	ld c,(hl)			;8f94
	ld a,c			;8f95
	or a			;8f96
	jr nz,L_8FA5		;8f97
	ld a,b			;8f99   ; ...sin vidas ni C: el mensaje 0 (30: vuelve con 100, 100 y 20)
	or a			;8f9a
	jr z,L_8F9D		;8f9b
L_8F9D:
	xor a			;8f9d
	call mensaje		;8f9e   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,001h		;8fa1
	jr L_8FBC		;8fa3
L_8FA5:
	ld a,b			;8fa5   ; ...con vidas: el mensaje 0 y al paso 2
	or a			;8fa6
	jr z,L_8FB1		;8fa7
	xor a			;8fa9
	call mensaje		;8faa   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,002h		;8fad
	jr L_8FBC		;8faf
L_8FB1:
	call llega_para_revivir		;8fb1   ; ...sin vidas: si no llega (p02:8FCE), el mensaje 0...
	jr nc,L_8FC0		;8fb4
	xor a			;8fb6
	call mensaje		;8fb7   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,002h		;8fba
L_8FBC:
	ld (0e691h),a		;8fbc   ; el paso
	ret			;8fbf
L_8FC0:
	ld a,002h		;8fc0   ; ...si llega, el 2 (34: dame 100, 100 y 20) y SI/NO (13)
	call mensaje		;8fc2   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,00dh		;8fc5
	call mensaje		;8fc7   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,003h		;8fca
	jr L_8FBC		;8fcc
llega_para_revivir:		; acarreo si no hay 20 llaves, 100 monedas y 100 flechas
	ld hl,(0e04ah)		;8fce   ; acarreo si no hay 20 llaves, 100 monedas y 100 flechas
	ld bc,00020h		;8fd1
	or a			;8fd4
	sbc hl,bc		;8fd5
	ret c			;8fd7
	ld hl,(0e048h)		;8fd8   ; lee las monedas (BCD, 16 bits)
	ld bc,00100h		;8fdb
	sbc hl,bc		;8fde
	ret c			;8fe0
	ld hl,(0e046h)		;8fe1   ; lee las flechas (BCD, 16 bits)
	ld bc,00100h		;8fe4
	sbc hl,bc		;8fe7
L_8FE9:
	ret			;8fe9
L_8FEA:
	call cursor_de_tienda		;8fea   ; paso 3: el cursor...
	ld a,(0e008h)		;8fed   ; ...hasta el boton A
	and 010h		;8ff0
	ret z			;8ff2
	ld a,(0e692h)		;8ff3   ; SI (0) o NO (2)
	or a			;8ff6
	jr z,L_900F		;8ff7
	cp 002h		;8ff9
	jr z,L_8FFE		;8ffb
	ret z			;8ffd
L_8FFE:
	call borra_mensajes		;8ffe   ; NO: el mensaje 4 (36: entonces lucha solo) y 0xB4 cuadros
	ld a,004h		;9001
	call mensaje		;9003   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,0b4h		;9006
	ld (0e694h),a		;9008   ; guarda la espera de la sala especial
	ld a,005h		;900b
	jr L_8FBC		;900d
L_900F:
	ld bc,00100h		;900f   ; SI: paga 100 monedas...
	call paga		;9012   ; paga: resta BC (BCD) de las monedas de 0xE048 y las repinta
	ld hl,0e04ah		;9015   ; ...20 llaves...
	ld bc,00020h		;9018
	call resta_bcd		;901b   ; resta_bcd: (HL) -= BC en BCD
	ld hl,0e046h		;901e   ; ...y 100 flechas
	ld bc,00100h		;9021
	call resta_bcd		;9024   ; resta_bcd: (HL) -= BC en BCD
	call 05f8fh		;9027   ; pinta_llaves: las llaves en la fila 2, columna 24
	call 05f79h		;902a   ; pinta_flechas: las flechas en la fila 0, columna 24
	ld a,(0e501h)		;902d   ; la experiencia del que juega a 0
	or a			;9030
	ld hl,0e050h		;9031   ; apunta a la experiencia de Afrodita (barra)
	jr nz,L_9038		;9034
	ld l,054h		;9036
L_9038:
	xor a			;9038   ; 0xE693 = 1, 0x50 cuadros
	ld (hl),a			;9039
	inc a			;903a
	ld (0e693h),a		;903b   ; guarda se puede salir de la sala especial (2)
	ld a,050h		;903e
	ld (0e694h),a		;9040   ; guarda la espera de la sala especial
	ld de,0ecbch		;9043   ; los dos sprites de 0x9066...
	ld hl,09066h		;9046
	ld bc,00008h		;9049
	ldir		;904c
	ld a,(0e501h)		;904e   ; ...el de Popolon con color 9
	and a			;9051
	jr z,L_9059		;9052
	ld a,009h		;9054
	ld (0ecc3h),a		;9056
L_9059:
	call borra_mensajes		;9059   ; el mensaje 3 (35: ha revivido) y al paso 4
	ld a,003h		;905c
	call mensaje		;905e   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,004h		;9061
	jp L_8FBC		;9063

; ----------------------------------------------------------------------
; DATOS sprites_9066: 8 bytes de atributos de sprite que p02:9046 copia a
;   0xECBC
;   0x9066..0x906e  (8 bytes)
DATA_sprites_9066:
	defb 040h,074h,048h,00bh,049h,078h,040h,00fh	; 9066  @tH.Ix@.

; ======================================================================
; CODIGO 0x906e..0x90c6  (88 bytes)
; ======================================================================


L_906E:
	ld hl,0e694h		;906e   ; paso 5: espera y fuera
	dec (hl)			;9071
	ret nz			;9072
	jr L_90BA		;9073
L_9075:
	ld a,(0e003h)		;9075   ; paso 4: cada dos cuadros los sprites bajan...
	and 001h		;9078
	ret nz			;907a
	ld hl,0ecbch		;907b
	inc (hl)			;907e
	ld de,00004h		;907f
	add hl,de			;9082
	inc (hl)			;9083
	ld hl,0e694h		;9084   ; ...y al acabar...
	dec (hl)			;9087
	ret nz			;9088
	ld a,(0e501h)		;9089   ; ...el otro: 0xE05A/0xE05B menos uno...
	or a			;908c
	ld hl,0e05ah		;908d   ; apunta a de Afrodita: baja uno al revivirla (Knightmare lo pone a 99)
	ld de,0e053h		;9090   ; apunta a el tope de la vida de Afrodita
	jr nz,L_9099		;9093
	ld l,05bh		;9095
	ld e,057h		;9097
L_9099:
	ld a,(hl)			;9099
	sub 001h		;909a
	daa			;909c
	ld (hl),a			;909d
	dec l			;909e   ; ...una vida mas...
	dec l			;909f
	ld a,(hl)			;90a0
	add a,001h		;90a1
	daa			;90a3
	ld (hl),a			;90a4
	ld a,(de)			;90a5   ; ...y la vida llena
	dec e			;90a6
	ld (de),a			;90a7
	call 0604dh		;90a8   ; la cabecera y el sonido 0x30
	ld a,030h		;90ab
	call 04e1fh		;90ad   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,0b4h		;90b0   ; 0xB4 cuadros y al paso 5
	ld (0e694h),a		;90b2   ; guarda la espera de la sala especial
	ld a,005h		;90b5
	jp L_8FBC		;90b7
L_90BA:
	ld a,002h		;90ba   ; 0xE693 = 2: se puede salir
	ld (0e693h),a		;90bc   ; guarda se puede salir de la sala especial (2)
L_90BF:
	ret			;90bf
contrasena:		; tipo 1: la contraseña
	ld a,(0e691h)		;90c0   ; tipo 1, la contraseña: por el paso
	call 04140h		;90c3   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_90C6: 4 destinos del despachador de 0x4140 (call en p02:90C3):
;   0x90CE, 0x90DE, 0x910D, 0x90BF; lo leen p02:90C3 (8 bytes)
;   0x90c6..0x90ce  (8 bytes)
DATA_tabla_90C6:
	defb 0ceh,090h	; 90c6
	defb 0deh,090h	; 90c8
	defb 00dh,091h	; 90ca
	defb 0bfh,090h	; 90cc

; ======================================================================
; CODIGO 0x90ce..0x912c  (94 bytes)
; ======================================================================


L_90CE:
	ld a,00ch		;90ce   ; paso 0: los mensajes 12 (44: quieres el codigo?) y 13 (SI/NO), y el nombre
	call mensaje		;90d0   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,00dh		;90d3
	call mensaje		;90d5   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	call cursor_al_primero		;90d8   ; cursor_al_primero: el cursor en el primer articulo que queda
	jp paso_de_sala_especial		;90db   ; paso_de_sala_especial: sube el paso 0xE691
L_90DE:
	call cursor_de_tienda		;90de   ; paso 1: el cursor hasta el boton A...
	ld a,(0e008h)		;90e1   ; lee lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and 010h		;90e4
	ret z			;90e6
	ld a,(0e692h)		;90e7   ; lee el articulo elegido en la tienda
	or a			;90ea
	jr z,L_90F2		;90eb
	cp 002h		;90ed
	jr z,L_9100		;90ef
	ret z			;90f1
L_90F2:
	call borra_mensajes		;90f2   ; ...SI: el mensaje 15 y la contraseña (p02:95A0)
	ld a,00fh		;90f5
	call mensaje		;90f7   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	call hace_la_contrasena		;90fa   ; hace_la_contrasena: la contraseña: 43 caracteres del estado de la partida y 2 de suma, en 11 grupos de 4 y 1
	jp paso_de_sala_especial		;90fd   ; paso_de_sala_especial: sube el paso 0xE691
L_9100:
	call borra_mensajes		;9100   ; ...NO: el mensaje 14 y al paso 3
	ld a,00eh		;9103
	call mensaje		;9105   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,003h		;9108
	jp L_8FBC		;910a
L_910D:
	ld a,(0e008h)		;910d   ; paso 2: con el boton A...
	and 010h		;9110
	ret z			;9112
	ld hl,00000h		;9113   ; ...0x80 cuadros y el mensaje 16
	ld a,080h		;9116
	ld (0e694h),a		;9118   ; guarda la espera de la sala especial
	call borra_mensajes		;911b   ; borra_mensajes: 5 filas de 20 desde 0xEE26 a cero
	ld a,010h		;911e
	call mensaje		;9120   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	jp paso_de_sala_especial		;9123   ; paso_de_sala_especial: sube el paso 0xE691
tienda:		; las tiendas: por el paso 0xE691
	ld a,(0e691h)		;9126   ; la tienda: por el paso (tabla que sigue)
	call 04140h		;9129   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_912C: 4 destinos del despachador de 0x4140 (call en p02:9129):
;   0x9134, 0x917C, 0x918C, 0x922A; lo leen p02:9129 (8 bytes)
;   0x912c..0x9134  (8 bytes)
DATA_tabla_912C:
	defb 034h,091h	; 912c
	defb 07ch,091h	; 912e
	defb 08ch,091h	; 9130
	defb 02ah,092h	; 9132

; ======================================================================
; CODIGO 0x9134..0x9255  (289 bytes)
; ======================================================================


L_9134:
	call precios		;9134   ; paso 0: los precios, el mensaje 5 (37: puedes comprar mi tesoro) y el cursor
	ld a,005h		;9137
	call mensaje		;9139   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	call cursor_al_primero		;913c   ; cursor_al_primero: el cursor en el primer articulo que queda
	jp paso_de_sala_especial		;913f   ; paso_de_sala_especial: sube el paso 0xE691
precios:		; los tres precios de la tienda en pantalla
	ld a,(0e690h)		;9142   ; los tres precios BCD de la ficha de la tienda...
	ld hl,l9253h		;9145
	call 0414ch		;9148   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld hl,0eea9h		;914b   ; ...en las filas de 0xEEA9, 0xEEAF y 0xEEB5
	call precio		;914e   ; precio: un precio BCD en dos cifras
	ld hl,0eeafh		;9151
	call precio		;9154   ; precio: un precio BCD en dos cifras
	ld hl,0eeb5h		;9157
precio:		; un precio BCD en dos cifras
	ld a,(de)			;915a   ; dos cifras (cifra + 1) si el precio no es 0
	or a			;915b
	jr z,L_916C		;915c
	rra			;915e   ; la cifra alta + 1...
	rra			;915f
	rra			;9160
	rra			;9161
	and 00fh		;9162
	inc a			;9164
	ld (hl),a			;9165
	inc hl			;9166
	ld a,(de)			;9167   ; ...y la baja + 1
	and 00fh		;9168
	inc a			;916a
	ld (hl),a			;916b
L_916C:
	inc de			;916c
	inc de			;916d
	ret			;916e
cursor_al_primero:		; el cursor en el primer articulo que queda
	ld a,001h		;916f   ; el cursor en el primer articulo que queda
	ld (0e695h),a		;9171
	call cursor_izquierda		;9174   ; cursor_izquierda: el articulo anterior que quede
	xor a			;9177
	ld (0e695h),a		;9178
	ret			;917b
L_917C:
	call cursor_de_tienda		;917c   ; paso 1: el cursor con izquierda y derecha...
	ld a,005h		;917f
	call c,mensaje		;9181   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld a,(0e008h)		;9184   ; ...hasta el boton A
	and 010h		;9187
	ret z			;9189
	jr paso_de_sala_especial		;918a
L_918C:
	ld a,(0e692h)		;918c   ; paso 2: si el articulo ya se compro, fuera
	ld hl,0e6cch		;918f
	call 04155h		;9192   ; byte_de_tabla: A = el byte HL + A
	or a			;9195
	jr nz,paso_de_sala_especial		;9196
	call articulo_de_tienda		;9198   ; el precio (C) y el objeto (D)
	ld a,d			;919b
	or a			;919c
	jp z,L_9225		;919d
	cp 02ch		;91a0   ; los niveles 0x2B y 0x2C piden el anterior
	jr z,L_91F4		;91a2
	cp 02bh		;91a4
	jr z,L_91F4		;91a6
L_91A8:
	ld hl,(0e048h)		;91a8   ; sin monedas bastantes, fuera (mensaje 18)
	or a			;91ab
	sbc hl,bc		;91ac
	jr c,L_9216		;91ae
	push de			;91b0
	call paga		;91b1   ; paga
	pop de			;91b4
	ld hl,0e06fh		;91b5   ; lo comprado: el objeto 0xE06F + D...
	ld a,d			;91b8
	cp 02ch		;91b9   ; ...los niveles 0x28/0x2B/0x2C en 0xE097...
	jr z,L_91EA		;91bb
	cp 02bh		;91bd
	jr z,L_91EA		;91bf
	cp 02dh		;91c1   ; ...0x2D: 100 flechas...
	jr z,L_9203		;91c3
	cp 02fh		;91c5   ; ...0x2F: una llave...
	jr z,L_920F		;91c7
	call 04136h		;91c9   ; ...los demas: su marca a 1
	ld a,001h		;91cc
L_91CE:
	ld (hl),a			;91ce
L_91CF:
	ld a,02dh		;91cf   ; el sonido 0x2D...
	call 04e1fh		;91d1   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call articulo_comprado		;91d4   ; ...el articulo se borra...
	ld a,001h		;91d7   ; ...y el cursor al siguiente
	ld (0e695h),a		;91d9
	call cursor_izquierda		;91dc   ; cursor_izquierda: el articulo anterior que quede
	xor a			;91df
	ld (0e695h),a		;91e0
	jr L_9225		;91e3
paso_de_sala_especial:		; sube el paso 0xE691
	ld hl,0e691h		;91e5   ; al paso siguiente
	inc (hl)			;91e8
	ret			;91e9
L_91EA:
	ld a,028h		;91ea   ; el nivel: 0x28 -> 1, 0x2B -> 2, 0x2C -> 3
	call 04136h		;91ec   ; hl_mas_a: HL += A
	ld a,d			;91ef
	sub 029h		;91f0
	jr L_91CE		;91f2
L_91F4:
	ld e,a			;91f4   ; pide el nivel anterior (0xE097 + 0x2A)
	ld hl,0e097h		;91f5   ; apunta a el nivel de los objetos 0x28/0x2B/0x2C
	ld a,(hl)			;91f8
	add a,02ah		;91f9
	cp e			;91fb
	jr c,L_9220		;91fc
	call articulo_de_tienda		;91fe   ; articulo_de_tienda: C = precio y D = objeto del articulo 0xE692 de la tienda 0xE690
	jr L_91A8		;9201
L_9203:
	ld a,050h		;9203   ; 0x2D: dos veces 50 flechas
	call 04d5ah		;9205   ; suma_flechas: suma A (BCD) a las flechas de 0xE046, hasta 999
	ld a,050h		;9208
	call 04d5ah		;920a   ; suma_flechas: suma A (BCD) a las flechas de 0xE046, hasta 999
	jr L_91CF		;920d
L_920F:
	ld a,001h		;920f   ; 0x2F: una llave
	call 04d82h		;9211   ; suma_llaves: suma A (BCD) a las llaves de 0xE04A, hasta 999
	jr L_91CF		;9214
L_9216:
	ld c,002h		;9216   ; sin monedas: el mensaje 18 (50: no hay monedas bastantes)
	call borra_filas		;9218   ; borra_filas: C filas de 20 desde 0xEE26 a cero
	ld a,012h		;921b
	call mensaje		;921d   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
L_9220:
	ld a,02fh		;9220   ; el sonido 0x2F
	call 04e1fh		;9222   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_9225:
	ld hl,0e691h		;9225   ; vuelve al paso de antes
	dec (hl)			;9228
	ret			;9229
L_922A:
	ret			;922a
paga:		; resta BC (BCD) de las monedas de 0xE048 y las repinta
	ld hl,0e048h		;922b   ; las monedas - BC y repintadas
	call resta_bcd		;922e   ; resta_bcd: (HL) -= BC en BCD
	jp 05f84h		;9231   ; pinta_monedas: las monedas en la fila 1, columna 24
resta_bcd:		; (HL) -= BC en BCD
	ld a,(hl)			;9234   ; el byte bajo...
	sub c			;9235
	daa			;9236
	ld (hl),a			;9237
	inc hl			;9238
	ld a,(hl)			;9239   ; ...y el alto con acarreo
	sbc a,b			;923a
	daa			;923b
	ld (hl),a			;923c
	ret			;923d
articulo_de_tienda:		; C = precio y D = objeto del articulo 0xE692 de la tienda 0xE690
	ld a,(0e690h)		;923e   ; la ficha de la tienda (0x9255)...
	ld hl,l9253h		;9241
	call 0414ch		;9244   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;9247
	ld a,(0e692h)		;9248   ; ...el articulo 0xE692: [precio][objeto]
	add a,a			;924b
	call 04136h		;924c   ; hl_mas_a: HL += A
	ld c,(hl)			;924f
	ld b,000h		;9250
	inc hl			;9252
L_9253:
	ld d,(hl)			;9253
	ret			;9254

; ----------------------------------------------------------------------
; DATOS tabla_9255: 13 punteros que p02:9483 elige con (0xE690) - 1 (0x414C) a
;   fichas de 6 bytes
;   0x9255..0x926f  (26 bytes)
DATA_tabla_9255:
	defb 06fh,092h	; 9255
	defb 075h,092h	; 9257
	defb 07bh,092h	; 9259
	defb 081h,092h	; 925b
	defb 087h,092h	; 925d
	defb 08dh,092h	; 925f
	defb 093h,092h	; 9261
	defb 099h,092h	; 9263
	defb 09fh,092h	; 9265
	defb 0a5h,092h	; 9267
	defb 0abh,092h	; 9269
	defb 0b1h,092h	; 926b
	defb 0b7h,092h	; 926d

; ----------------------------------------------------------------------
; DATOS fichas_926f: las 13 fichas de 6 bytes de 0x9255, de las que p02:9489
;   coge el byte C (y el siguiente)
;   0x926f..0x92bd  (78 bytes)
DATA_fichas_926f:
	defb 000h,0ffh,000h,000h,000h,0ffh	; 926f
	defb 030h,005h,005h,02fh,020h,02dh	; 9275
	defb 000h,0ffh,000h,000h,000h,0ffh	; 927b
	defb 020h,02dh,030h,028h,020h,006h	; 9281
	defb 020h,02dh,040h,02bh,005h,02fh	; 9287
	defb 030h,021h,020h,02dh,005h,02fh	; 928d
	defb 020h,02dh,025h,023h,005h,02fh	; 9293
	defb 000h,000h,000h,000h,000h,000h	; 9299
	defb 020h,02dh,050h,02ch,005h,02fh	; 929f
	defb 020h,02dh,050h,019h,005h,02fh	; 92a5
	defb 020h,02dh,025h,00dh,005h,02fh	; 92ab
	defb 000h,000h,030h,010h,000h,000h	; 92b1
	defb 000h,000h,030h,018h,000h,000h	; 92b7

; ======================================================================
; CODIGO 0x92bd..0x9308  (75 bytes)
; ======================================================================


articulo_comprado:		; marca el articulo y borra su dibujo
	ld hl,0e6cch		;92bd   ; el articulo comprado: su marca en 0xE6CC...
	ld a,(0e692h)		;92c0   ; lee el articulo elegido en la tienda
	call 04136h		;92c3   ; hl_mas_a: HL += A
	ld a,001h		;92c6
	ld (hl),a			;92c8
	ld a,(0e692h)		;92c9   ; ...y su dibujo de 2 x 2 se borra (0xEE69, 0xEE6F o 0xEE75)
	cp 001h		;92cc
	ld hl,0ee69h		;92ce
	jr c,L_92DB		;92d1
	ld hl,0ee6fh		;92d3
	jr z,L_92DB		;92d6
	ld hl,0ee75h		;92d8
L_92DB:
	ld b,002h		;92db
	xor a			;92dd
L_92DE:
	ld (hl),a			;92de   ; 2 casillas...
	inc hl			;92df
	ld (hl),a			;92e0
	ld de,0001fh		;92e1   ; ...y la fila de abajo
	add hl,de			;92e4
	djnz L_92DE		;92e5
	ret			;92e7
pista:		; las salas de pista: su mensaje (tabla 0x9308)
	ld a,(0e691h)		;92e8   ; las salas de pista: una vez...
	or a			;92eb
	ret nz			;92ec
	ld a,(0e690h)		;92ed   ; ...la 8 dice el mensaje 1...
	cp 008h		;92f0
	ld a,001h		;92f2
	jr z,L_9302		;92f4
	ld a,(0e690h)		;92f6   ; ...las 14-20 el de la tabla 0x9308
	sub 00eh		;92f9
	ld hl,09308h		;92fb
	call 04136h		;92fe   ; hl_mas_a: HL += A
	ld a,(hl)			;9301
L_9302:
	call mensaje		;9302   ; mensaje: pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	jp paso_de_sala_especial		;9305   ; paso_de_sala_especial: sube el paso 0xE691

; ----------------------------------------------------------------------
; DATOS siete_mensajes: 7 numeros de mensaje que p02:92FB elige con (0xE690) -
;   0x0E y pasa a p02:94EF (el texto, banco 15)
;   0x9308..0x930f  (7 bytes)
DATA_siete_mensajes:
	defb 006h,007h,008h,009h,00ah,013h,00bh	; 9308

; ======================================================================
; CODIGO 0x930f..0x94bd  (430 bytes)
; ======================================================================


cursor_de_tienda:		; el cursor con izquierda y derecha
	ld a,(0e008h)		;930f   ; el cursor: izquierda (bit 2)...
	bit 2,a		;9312
	jr nz,cursor_izquierda		;9314
	bit 3,a		;9316   ; ...o derecha (bit 3)
	jr nz,cursor_derecha		;9318
	ret			;931a
cursor_izquierda:		; el articulo anterior que quede
	ld b,003h		;931b   ; a la izquierda: el anterior que quede (de 0 vuelve al 2)
L_931D:
	ld hl,0e692h		;931d   ; apunta a el articulo elegido en la tienda
	dec (hl)			;9320
	call m,cursor_al_2		;9321   ; cursor_al_2: el articulo 2
	ld a,(0e692h)		;9324   ; lee el articulo elegido en la tienda
	ld de,0e6cch		;9327
	call 0413bh		;932a   ; si ya se compro, otro
	ld a,(de)			;932d
	or a			;932e
	jr nz,L_933A		;932f
	push bc			;9331
	call articulo_de_tienda		;9332   ; si tiene objeto, se queda
	pop bc			;9335
	ld a,d			;9336
	or a			;9337
	jr nz,L_9341		;9338
L_933A:
	djnz L_931D		;933a
	or a			;933c
	ret			;933d
cursor_al_2:		; el articulo 2
	ld (hl),002h		;933e
	ret			;9340
L_9341:
	ld a,001h		;9341   ; si se ha movido, el sonido 0x2C
	cp b			;9343
	ret z			;9344
	ld a,(0e695h)		;9345
	or a			;9348
	ret nz			;9349
	ld a,02ch		;934a
	call 04e1fh		;934c   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	scf			;934f
	ret			;9350
cursor_derecha:		; el articulo siguiente que quede
	ld b,003h		;9351   ; a la derecha: el siguiente que quede (de 2 vuelve al 0)
L_9353:
	ld hl,0e692h		;9353   ; apunta a el articulo elegido en la tienda
	inc (hl)			;9356
	ld a,(hl)			;9357
	cp 003h		;9358
	call nc,cursor_al_0		;935a   ; cursor_al_0: el articulo 0
	ld a,(0e692h)		;935d   ; lee el articulo elegido en la tienda
	ld de,0e6cch		;9360
	call 0413bh		;9363   ; de_mas_a: DE += A
	ld a,(de)			;9366
	or a			;9367
	jr nz,L_9373		;9368
	push bc			;936a
	call articulo_de_tienda		;936b   ; articulo_de_tienda: C = precio y D = objeto del articulo 0xE692 de la tienda 0xE690
	pop bc			;936e
	ld a,d			;936f
	or a			;9370
	jr nz,L_9341		;9371
L_9373:
	djnz L_9353		;9373
	or a			;9375
	ret			;9376
cursor_al_0:		; el articulo 0
	ld (hl),000h		;9377
	ret			;9379
borra_mensajes:		; 5 filas de 20 desde 0xEE26 a cero
	ld c,005h		;937a   ; borra los mensajes: 5 filas de 20 desde 0xEE26
borra_filas:		; C filas de 20 desde 0xEE26 a cero
	ld hl,0ee26h		;937c
	xor a			;937f
L_9380:
	ld b,014h		;9380
L_9382:
	ld (hl),a			;9382   ; 20 a cero...
	inc hl			;9383
	djnz L_9382		;9384
	ld de,0000ch		;9386   ; ...y la fila siguiente
	add hl,de			;9389
	dec c			;938a
	jr nz,L_9380		;938b
	ret			;938d
sprites_de_sala_especial:		; el personaje, el cursor y el que atiende
	ld hl,0ec80h		;938e   ; los sprites de la sala especial: el personaje...
	ld (0e60ah),hl		;9391
	call 073e4h		;9394   ; pose_del_personaje: la pose 0xE502 (0xE53D en la pausa) de la tabla 0x7529
	call guarda_bajo_cursor		;9397   ; ...el cursor y el que atiende
	call cursor_de_articulo		;939a   ; cursor_de_articulo: el cursor 0x6E sobre el articulo elegido
	call 054bfh		;939d   ; y la pantalla a la VRAM
	jp repone_bajo_cursor		;93a0   ; repone_bajo_cursor: vuelve a poner lo de debajo del cursor
personaje_en_la_puerta:		; el personaje en y 0xAF, x 0x80
	ld a,0afh		;93a3   ; el personaje en y 0xAF, x 0x80
	ld (0e505h),a		;93a5   ; guarda la y del personaje
	ld a,080h		;93a8
	ld (0e507h),a		;93aa   ; guarda la x del personaje
	ret			;93ad
pantalla_de_sala_especial:		; paredes, techo, suelo, puerta y recuadros
	ld hl,0ed80h		;93ae   ; la pantalla de la sala especial: a cero...
	ld de,0ed81h		;93b1
	ld bc,0027fh		;93b4
	ld (hl),000h		;93b7
	ldir		;93b9
	ld hl,0ed80h		;93bb   ; ...las paredes de los lados (0xF0 con 0x13 de alto)...
	ld bc,013f0h		;93be
	call columna_de_c		;93c1   ; columna_de_c: B veces C en columna
	ld hl,0ed81h		;93c4
	ld b,013h		;93c7
	call columna_de_c		;93c9   ; columna_de_c: B veces C en columna
	ld hl,0ed9eh		;93cc
	ld b,013h		;93cf
	call columna_de_c		;93d1   ; columna_de_c: B veces C en columna
	ld hl,0ed9fh		;93d4
	ld b,013h		;93d7
	call columna_de_c		;93d9   ; columna_de_c: B veces C en columna
	ld hl,0ed80h		;93dc   ; ...el techo...
	ld de,0ed81h		;93df
	ld (hl),c			;93e2
	ld bc,0001fh		;93e3
	ldir		;93e6
	ld hl,0efc0h		;93e8   ; ...el suelo de 0xF0...
	ld de,0efc1h		;93eb
	ld (hl),0f0h		;93ee
	ld bc,0001fh		;93f0
	ldir		;93f3
	ld hl,09b9ah		;93f5   ; ...la puerta (0x9B9A) abajo...
	ld (0efefh),hl		;93f8
	ld hl,0ee05h		;93fb   ; ...las lineas de los recuadros (0x6C)...
	call linea_6c		;93fe   ; linea_6c: 22 caracteres 0x6C
	ld hl,0eec5h		;9401
	call linea_6c		;9404   ; linea_6c: 22 caracteres 0x6C
	ld hl,0eee5h		;9407
	call linea_6c		;940a   ; linea_6c: 22 caracteres 0x6C
	ld hl,0ef65h		;940d
	call linea_6c		;9410   ; linea_6c: 22 caracteres 0x6C
	ld hl,0ee24h		;9413   ; ...sus lados (0x6D, 0x0A de alto)...
	call columna_6d		;9416   ; columna_6d: una columna de 10 caracteres 0x6D
	ld hl,0ee3bh		;9419
	call columna_6d		;941c   ; columna_6d: una columna de 10 caracteres 0x6D
	ld a,072h		;941f   ; ...y sus esquinas (0x72-0x75, 0x6A-0x6B)
	ld (0ee04h),a		;9421
	ld (0eee4h),a		;9424
	inc a			;9427
	ld (0eec4h),a		;9428
	ld (0ef64h),a		;942b
	inc a			;942e
	ld (0ee1bh),a		;942f
	ld (0eefbh),a		;9432
	inc a			;9435
	ld (0eedbh),a		;9436
	ld (0ef7bh),a		;9439
	ld a,06ah		;943c
	ld (0ee0bh),a		;943e
	inc a			;9441
	ld (0ef74h),a		;9442
	ret			;9445
linea_6c:		; 22 caracteres 0x6C
	ld d,h			;9446   ; 22 caracteres 0x6C
	ld e,l			;9447
	inc de			;9448
	ld bc,00015h		;9449
	ld (hl),06ch		;944c
	ldir		;944e
	ret			;9450
columna_6d:		; una columna de 10 caracteres 0x6D
	ld bc,00a6dh		;9451   ; una columna de 0x0A caracteres 0x6D
columna_de_c:		; B veces C en columna
	ld de,00020h		;9454   ; B veces C, de fila en fila
L_9457:
	ld (hl),c			;9457
	add hl,de			;9458
	djnz L_9457		;9459
	ret			;945b
articulos:		; los dibujos de los tres articulos de la tienda
	ld a,(0e690h)		;945c   ; en las tiendas (tipo < 14), los tres articulos...
	cp 00eh		;945f
	ret nc			;9461
	ld hl,0ee69h		;9462   ; ...en 0xEE69...
	ld a,08eh		;9465
	ld c,000h		;9467
	call articulo		;9469   ; articulo: el dibujo de un articulo
	ld hl,0ee6fh		;946c   ; ...0xEE6F...
	ld a,08eh		;946f
	ld c,002h		;9471
	call articulo		;9473   ; articulo: el dibujo de un articulo
	ld hl,0ee75h		;9476   ; ...y 0xEE75
	ld a,08eh		;9479
	ld c,004h		;947b
articulo:		; el dibujo de un articulo
	push hl			;947d   ; el objeto del articulo C...
	ld b,a			;947e
	ld a,(0e690h)		;947f   ; lee la sala especial (pista o tienda)
	dec a			;9482
	ld hl,09255h		;9483
	call 0414ch		;9486   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,c			;9489
	call 0413bh		;948a   ; de_mas_a: DE += A
	inc de			;948d
	ld a,(de)			;948e
	ld c,a			;948f
	pop hl			;9490
	or a			;9491   ; ...0 o 0xFF: nada
	ret z			;9492
	cp 0ffh		;9493
	ret z			;9495
	cp 02dh		;9496   ; ...0x2D-0x2F: 2 x 2 de la tabla 0x94BD (7-9)...
	jr nc,L_94B9		;9498
	cp 007h		;949a   ; ...7-0x2C: los caracteres 0x8E-0x91 (su dibujo, p00:5814)...
	ld a,b			;949c
	jr nc,$+68		;949d
	ld a,c			;949f   ; ...1-6: 2 x 2 de la tabla 0x94BD
L_94A0:
	dec a			;94a0   ; 4 bytes por dibujo: 2 arriba y 2 abajo
	add a,a			;94a1
	add a,a			;94a2
	ld de,094bdh		;94a3
	call 0413bh		;94a6   ; de_mas_a: DE += A
	ex de,hl			;94a9
	ldi		;94aa
	ldi		;94ac
	ld bc,0001eh		;94ae
	ex de,hl			;94b1
	add hl,bc			;94b2
	ex de,hl			;94b3
	ldi		;94b4
	ldi		;94b6
	ret			;94b8
L_94B9:
	sub 026h		;94b9
	jr L_94A0		;94bb

; ----------------------------------------------------------------------
; DATOS nueve_bloques_2x2: 9 bloques de 2 x 2 caracteres que p02:94A3 elige
;   con (C - 1) x 4 y copia en dos filas
;   0x94bd..0x94e1  (36 bytes)
DATA_nueve_bloques_2x2:
	defb 000h,000h,044h,045h	; 94bd
	defb 000h,000h,046h,047h	; 94c1
	defb 000h,000h,04eh,000h	; 94c5
	defb 000h,000h,04fh,000h	; 94c9
	defb 000h,000h,050h,051h	; 94cd
	defb 000h,000h,052h,053h	; 94d1
	defb 060h,061h,062h,063h	; 94d5
	defb 064h,065h,066h,067h	; 94d9
	defb 064h,065h,066h,067h	; 94dd

; ======================================================================
; CODIGO 0x94e1..0x954d  (108 bytes)
; ======================================================================


dos_por_dos_a:		; 2 x 2 caracteres seguidos desde A en HL
	ld (hl),a			;94e1   ; 2 x 2 caracteres seguidos desde A
	inc l			;94e2   ; A + 1 a la derecha
	inc a			;94e3
	ld (hl),a			;94e4
	ld bc,0001fh		;94e5   ; la fila de abajo
	add hl,bc			;94e8
	inc a			;94e9
	ld (hl),a			;94ea
	inc l			;94eb
	inc a			;94ec
	ld (hl),a			;94ed
	ret			;94ee
mensaje:		; pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)
	ld b,a			;94ef   ; el mensaje A, en japones; con 0x002B (el idioma del MSX) distinto de 0, el A + 0x20 en ingles
	ld a,(0002bh)		;94f0
	and 00fh		;94f3
	ld a,b			;94f5
	jr z,mensaje_a		;94f6
	add a,020h		;94f8
mensaje_a:		; pinta el mensaje A ya con su idioma
	push af			;94fa
	call 04241h		;94fb   ; con el banco 15
	pop af			;94fe
	call mensaje_sin_idioma		;94ff   ; mensaje_sin_idioma: pinta el mensaje A de la tabla 0xB09E
	jp 04215h		;9502   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
mensaje_sin_idioma:		; pinta el mensaje A de la tabla 0xB09E
	ld hl,0b09eh		;9505   ; la tabla 0xB09E: [destino] y los caracteres...
	call 0414ch		;9508   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;950b
	ld e,(hl)			;950c
	inc hl			;950d
	ld d,(hl)			;950e
	inc hl			;950f
	ld b,d			;9510
	ld c,e			;9511
L_9512:
	ld a,(hl)			;9512   ; ...0xFF acaba...
	inc a			;9513
	ret z			;9514
	inc a			;9515   ; ...0xFE salta de fila
	jr z,L_951E		;9516
	ld a,(hl)			;9518
	ld (de),a			;9519
	inc hl			;951a
	inc de			;951b
	jr L_9512		;951c
L_951E:
	inc hl			;951e
	ex de,hl			;951f   ; la fila siguiente desde el principio de la linea
	ld h,b			;9520
	ld l,c			;9521
	ld bc,00020h		;9522
	add hl,bc			;9525
	ld b,h			;9526
	ld c,l			;9527
	ex de,hl			;9528
	jr L_9512		;9529
el_que_atiende:		; el nombre y el dibujo de quien atiende la sala especial (tabla 0x954C)
	ld a,(0e690h)		;952b   ; el nombre de quien atiende: mensaje 0x18 + el de la tabla 0x954C...
	ld hl,0954ch		;952e
	call 04136h		;9531   ; hl_mas_a: HL += A
	ld a,(hl)			;9534
	add a,018h		;9535
	call mensaje_a		;9537   ; mensaje_a: pinta el mensaje A ya con su idioma
	ld a,(0e690h)		;953a   ; ...y su dibujo de 2 x 2 desde 0x76 + 4 x ese numero en 0xEDCF
	ld hl,0954ch		;953d
	call 04136h		;9540   ; hl_mas_a: HL += A
	ld a,(hl)			;9543
	add a,a			;9544
	add a,a			;9545
	add a,076h		;9546
	ld hl,0edcfh		;9548
	jr dos_por_dos_a		;954b

; ----------------------------------------------------------------------
; DATOS mensaje_por_cosa: 20 bytes que p02:952E y p02:953D leen en 0x954C +
;   (0xE690): el numero de mensaje (+ 0x18) y un dibujo (x 4 + 0x76) en 0xEDCF
;   0x954d..0x9561  (20 bytes)
DATA_mensaje_por_cosa:
	defb 003h,001h,000h,004h,004h,001h,001h,002h,004h,004h,003h,003h,003h,003h,005h,005h	; 954d  ................
	defb 003h,005h,003h,003h	; 955d

; ======================================================================
; CODIGO 0x9561..0x9671  (272 bytes)
; ======================================================================


cursor_de_articulo:		; el cursor 0x6E sobre el articulo elegido
	call sitio_del_cursor		;9561   ; el cursor (0x6E) en su sitio
	ld a,06eh		;9564
	jp dos_por_dos_a		;9566   ; dos_por_dos_a: 2 x 2 caracteres seguidos desde A en HL
sitio_del_cursor:		; HL = la casilla del cursor del articulo 0xE692
	ld a,(0e692h)		;9569   ; la casilla del articulo: 0xEF09, 0xEF0F o 0xEF15
	ld hl,0ef09h		;956c
	or a			;956f
	ret z			;9570
	ld l,00fh		;9571
	dec a			;9573
	ret z			;9574
	ld l,015h		;9575
	ret			;9577
guarda_bajo_cursor:		; guarda en 0xE6C8 lo de debajo del cursor
	call sitio_del_cursor		;9578   ; lo de debajo del cursor a 0xE6C8
	ld de,0e6c8h		;957b
	ldi		;957e
	ldi		;9580
	ld bc,0001eh		;9582
	add hl,bc			;9585
	ldi		;9586
	ldi		;9588
	ret			;958a
repone_bajo_cursor:		; vuelve a poner lo de debajo del cursor
	call sitio_del_cursor		;958b   ; y de vuelta
	ex de,hl			;958e
	ld hl,0e6c8h		;958f
	ldi		;9592
	ldi		;9594
	ld a,01eh		;9596
	call 0413bh		;9598   ; de_mas_a: DE += A
	ldi		;959b
	ldi		;959d
	ret			;959f
hace_la_contrasena:		; la contraseña: 43 caracteres del estado de la partida y 2 de suma, en 11 grupos de 4 y 1
	call tampon_a_cero		;95a0   ; la contraseña, en el tampon 0xEB00
	call objetos_del_nivel		;95a3   ; el objeto del nivel de 0xE097
	ld hl,0eb00h		;95a6   ; 6 valores de 0xE046: flechas, monedas y llaves (BCD)...
	ld de,0e046h		;95a9   ; apunta a las flechas (BCD)
	ld a,006h		;95ac
	ld c,000h		;95ae
	call empaqueta_bits		;95b0   ; empaqueta_bits: A valores de DE en grupos de 5 bits a HL
	ld de,0e051h		;95b3   ; ...4 de 0xE051 de dos en dos (los topes)...
	ld a,004h		;95b6
	ld c,001h		;95b8
	call empaqueta_bits		;95ba   ; empaqueta_bits: A valores de DE en grupos de 5 bits a HL
	ld de,0e063h		;95bd   ; ...las marcas de los 10 mundos (0xE063)...
	ld a,00ah		;95c0
	ld c,000h		;95c2
	call empaqueta_bits		;95c4   ; empaqueta_bits: A valores de DE en grupos de 5 bits a HL
	ld de,0e070h		;95c7   ; ...y los 44 objetos 0x01-0x2C, un bit cada uno, 5 por letra
	ld c,02ch		;95ca
L_95CC:
	ld b,005h		;95cc
	ld (hl),000h		;95ce
L_95D0:
	ld a,(de)			;95d0
	and a			;95d1
	jr z,L_95D5		;95d2
	scf			;95d4
L_95D5:
	rl (hl)		;95d5   ; el bit al byte...
	inc de			;95d7
	dec c			;95d8   ; ...hasta los 44 objetos...
	jr z,L_95E0		;95d9
	djnz L_95D0		;95db
	inc hl			;95dd   ; ...5 por letra
	jr L_95CC		;95de
L_95E0:
	sla (hl)		;95e0   ; la ultima letra, ajustada
	inc hl			;95e2
	push hl			;95e3
	call vidas_en_bits		;95e4   ; vidas y quien juega
	pop hl			;95e7
	ld (hl),a			;95e8
	ld hl,0eb00h		;95e9   ; cada valor de 5 bits a su letra (tabla 0x9671 corrida segun la posicion)...
	ld de,0eb40h		;95ec
	ld b,02bh		;95ef
L_95F1:
	ld a,(hl)			;95f1
	push de			;95f2
	call letra_de_contrasena		;95f3   ; letra_de_contrasena: A = la letra de la tabla 0x9671 para el valor A en la posicion B
	pop de			;95f6
	ld (de),a			;95f7
	inc hl			;95f8
	inc de			;95f9
	djnz L_95F1		;95fa   ; ...43 letras...
	push de			;95fc
	call suma_de_contrasena		;95fd   ; ...y la suma, en dos letras mas
	pop de			;9600
	ld a,l			;9601
	and 0f0h		;9602
	rrca			;9604
	rrca			;9605
	rrca			;9606
	rrca			;9607
	inc a			;9608
	ld (de),a			;9609
	inc de			;960a
	ld a,l			;960b
	and 00fh		;960c
	inc a			;960e
	ld (de),a			;960f
	call contrasena_en_grupos		;9610   ; en grupos de 4 a 0xEB80...
	ld de,0eb80h		;9613   ; ...y a la pantalla desde 0xEE27
	ld hl,0ee27h		;9616
L_9619:
	ld a,(de)			;9619   ; 0xFF acaba, 0xFE salta de fila
	ld c,a			;961a
	inc c			;961b
	ret z			;961c
	inc c			;961d
	jr nz,L_9626		;961e
	push de			;9620
	ld de,0000ch		;9621
	add hl,de			;9624
	pop de			;9625
L_9626:
	ld (hl),a			;9626
	inc hl			;9627
	inc de			;9628
	djnz L_9619		;9629
	ret			;962b
contrasena_en_grupos:		; la contraseña en grupos de 4 con saltos de linea
	ld hl,0eb40h		;962c   ; 11 grupos de 4...
	ld de,0eb80h		;962f
	ld bc,00b00h		;9632
L_9635:
	push bc			;9635
	ldi		;9636   ; 4 letras...
	ldi		;9638
	ldi		;963a
	ldi		;963c
	pop bc			;963e
	dec c			;963f   ; ...con un 0 entre grupos y un salto de fila cada 4 grupos...
	ld a,c			;9640
	and 003h		;9641
	ld a,0feh		;9643   ; ...y un salto de fila cada 4 grupos, si no un 0
	jr z,L_9648		;9645
	xor a			;9647
L_9648:
	ld (de),a			;9648
	inc de			;9649
	dec b			;964a
	jr nz,L_9635		;964b
	ldi		;964d   ; ...la ultima letra y 0xFF
	ld a,0ffh		;964f
	ld (de),a			;9651
	ret			;9652
objetos_del_nivel:		; con el nivel 2 o 3 de 0xE097, el objeto 0x2B o 0x2C
	ld a,(0e097h)		;9653   ; con el nivel 2, el objeto 0x2B; con el 3, el 0x2C
	and a			;9656
	ret z			;9657
	dec a			;9658
	ret z			;9659
	ld hl,0e09ah		;965a   ; apunta a tiene el objeto 0x2B
	dec a			;965d
	jr z,L_9661		;965e
	inc hl			;9660
L_9661:
	ld (hl),001h		;9661
	ret			;9663
letra_de_contrasena:		; A = la letra de la tabla 0x9671 para el valor A en la posicion B
	ld d,a			;9664   ; la letra: valor + posicion mod 4...
	ld a,b			;9665
	and 003h		;9666
	add a,d			;9668
	ld de,09671h		;9669   ; ...en la tabla 0x9671
	call 0413bh		;966c   ; de_mas_a: DE += A
	ld a,(de)			;966f
	ret			;9670

; ----------------------------------------------------------------------
; DATOS alfabeto_de_la_contrasena: los 36 simbolos de la contrasena,
;   desordenados: p02:9669 convierte un valor en simbolo y p02:97F5 un simbolo
;   en valor (su posicion + 1)
;   0x9671..0x9695  (36 bytes)
DATA_alfabeto_de_la_contrasena:
	defb 010h,004h,01ch,01fh,008h,003h,011h,005h,022h,006h,00ch,015h,018h,00ah,001h,01ah	; 9671  ........".......
	defb 01bh,01eh,012h,020h,00fh,007h,019h,017h,021h,00bh,014h,002h,009h,00eh,01dh,013h	; 9681  ... ....!.......
	defb 016h,023h,00dh,024h	; 9691

; ======================================================================
; CODIGO 0x9695..0x9990  (763 bytes)
; ======================================================================


suma_de_contrasena:		; L = la suma de los 43 caracteres
	ld de,0eb40h		;9695   ; la suma de las 43 letras
	ld l,000h		;9698
	ld b,02bh		;969a
L_969C:
	ld a,(de)			;969c   ; la suma de las letras
	add a,l			;969d
	ld l,a			;969e
	inc de			;969f
	djnz L_969C		;96a0
	ret			;96a2
vidas_en_bits:		; A = las vidas, 0xE05A/0xE05B y quien juega en bits
	ld hl,(0e058h)		;96a3   ; las vidas: bits 0-1...
	ld de,(0e05ah)		;96a6   ; lee de Afrodita: baja uno al revivirla (Knightmare lo pone a 99) y el byte siguiente (16 bits)
	ld a,h			;96aa
	rlca			;96ab
	or l			;96ac
	ld b,a			;96ad
	ld a,e			;96ae   ; ...0xE05A al bit 2...
	and a			;96af
	jr z,L_96B4		;96b0
	set 2,b		;96b2
L_96B4:
	ld a,d			;96b4   ; ...0xE05B al 3...
	and a			;96b5
	jr z,L_96BA		;96b6
	set 3,b		;96b8
L_96BA:
	ld a,(0e501h)		;96ba   ; ...y Popolon jugando al 4
	and a			;96bd
	jr z,L_96C2		;96be
	set 4,b		;96c0
L_96C2:
	ld a,b			;96c2
	ret			;96c3
empaqueta_bits:		; A valores de DE en grupos de 5 bits a HL
	ld (0f000h),a		;96c4   ; A valores de DE (de dos en dos con C = 1)...
	ld a,c			;96c7
	ld (0f001h),a		;96c8
	exx			;96cb
	ld b,008h		;96cc
	exx			;96ce
	ld a,(de)			;96cf
	ld c,a			;96d0
L_96D1:
	ld b,005h		;96d1   ; ...de 5 bits por letra...
L_96D3:
	or a			;96d3   ; ...bit a bit, del alto al bajo
	rl c		;96d4   ; el bit mas alto de C a (HL)
	rl (hl)		;96d6
	exx			;96d8
	dec b			;96d9
	exx			;96da
	jr nz,L_96F1		;96db
	inc de			;96dd   ; la letra siguiente de DE (con C, de dos en dos)
	ld a,(0f001h)		;96de
	and a			;96e1
	jr z,L_96E5		;96e2
	inc de			;96e4
L_96E5:
	ld a,(de)			;96e5   ; la letra siguiente, 8 bits...
	ld c,a			;96e6
	exx			;96e7
	ld b,008h		;96e8
	ld hl,0f000h		;96ea
	dec (hl)			;96ed   ; ...hasta los A valores
	exx			;96ee
	jr z,L_96F6		;96ef
L_96F1:
	djnz L_96D3		;96f1
	inc hl			;96f3
	jr L_96D1		;96f4
L_96F6:
	ld a,001h		;96f6   ; la ultima letra se ajusta a la izquierda
	sub b			;96f8
	jr z,L_9702		;96f9
	neg		;96fb
	ld b,a			;96fd
L_96FE:
	sla (hl)		;96fe
	djnz L_96FE		;9700
L_9702:
	inc hl			;9702
	ret			;9703
contrasena_a_cero:		; 0xE02B a 0 y el tampon a cero
	xor a			;9704   ; la posicion a 0 y el tampon vacio
	ld (0e02bh),a		;9705   ; guarda la posicion del cursor en la contraseña
tampon_a_cero:		; 0xEB00-0xEBFF a cero
	ld hl,0eb00h		;9708   ; apunta a el tampon de 0xEB00 (lo de debajo de las figuras; la contraseña)
	ld de,0eb01h		;970b
	ld (hl),000h		;970e
	ld bc,000ffh		;9710
	ldir		;9713
	ret			;9715
teclea_contrasena:		; un cuadro de la pantalla de teclear la contraseña (estado 0x12)
	call cursor_de_contrasena		;9716   ; la pantalla de la contraseña: el cursor, su sprite, la tecla y la pantalla
	call sprite_del_cursor		;9719   ; sprite_del_cursor: el sprite del cursor en su sitio
	call tecla_de_contrasena		;971c   ; tecla_de_contrasena: la tecla recien apretada a la contraseña; RETURN acaba
	jp pinta_contrasena		;971f   ; pinta_contrasena: la contraseña tecleada en tres filas
tecla_de_contrasena:		; la tecla recien apretada a la contraseña; RETURN acaba
	call tecla_ascii		;9722   ; la tecla recien apretada...
	ld hl,0e02fh		;9725   ; apunta a la tecla de la contraseña
	ld c,(hl)			;9728
	ld (hl),a			;9729
	xor c			;972a
	and (hl)			;972b
	inc hl			;972c
	ld (hl),a			;972d
	and a			;972e
	ret z			;972f
	ld hl,0e02bh		;9730   ; ...en la posicion del cursor...
	ld a,(hl)			;9733
	ld de,0eb00h		;9734   ; apunta a el tampon de 0xEB00 (lo de debajo de las figuras; la contraseña)
	call 0413bh		;9737   ; de_mas_a: DE += A
	ld a,(0e030h)		;973a   ; ...RETURN (0x0D) acaba...
	cp 00dh		;973d
	jr z,L_9751		;973f
	sub 02fh		;9741   ; ...'0'-'9' son 1-10...
	ret c			;9743
	cp 00bh		;9744
	jr c,L_974A		;9746
	sub 007h		;9748   ; ...y 'A'-'Z' 11-36...
L_974A:
	ld (de),a			;974a
	ld a,(hl)			;974b   ; ...y el cursor avanza (hasta 0x2C)
	cp 02ch		;974c
	ret nc			;974e
	inc (hl)			;974f
	ret			;9750
L_9751:
	ld a,001h		;9751
	ld (0e02dh),a		;9753   ; guarda hecho (estado 0x12)
	ret			;9756
cursor_de_contrasena:		; el cursor con izquierda y derecha (0-0x2C)
	ld a,(0e008h)		;9757   ; izquierda o derecha mueven el cursor (0-0x2C)
	and 00ch		;975a
	ret z			;975c
	and 008h		;975d
	ld hl,0e02bh		;975f   ; apunta a la posicion del cursor en la contraseña
	jr nz,L_9769		;9762
	ld a,(hl)			;9764
	and a			;9765
	ret z			;9766
	dec (hl)			;9767
	ret			;9768
L_9769:
	ld a,(hl)			;9769
	cp 02ch		;976a
	ret nc			;976c
	inc (hl)			;976d
	ret			;976e
sprite_del_cursor:		; el sprite del cursor en su sitio
	ld a,(0e02bh)		;976f   ; el sprite del cursor: columna (con un hueco cada 4)...
	ld b,a			;9772
	and 00fh		;9773   ; la columna, 4 por grupo...
	cp 004h		;9775
	ld c,000h		;9777
	jr c,L_9786		;9779   ; ...mas un hueco por grupo
	cp 008h		;977b
	inc c			;977d
	jr c,L_9786		;977e
	cp 00ch		;9780
	inc c			;9782
	jr c,L_9786		;9783
	inc c			;9785
L_9786:
	add a,c			;9786   ; x = 8 x columna + 0x3F
	add a,a			;9787
	add a,a			;9788
	add a,a			;9789
	add a,03fh		;978a
	ld d,a			;978c
	ld a,b			;978d   ; ...y fila (0x3E, 0x4E o 0x5E de 16 en 16)
	cp 010h		;978e
	jr c,L_979E		;9790
	cp 020h		;9792
	jr c,L_979A		;9794
	ld e,05eh		;9796   ; tercera fila
	jr L_97A0		;9798
L_979A:
	ld e,04eh		;979a
	jr L_97A0		;979c
L_979E:
	ld e,03eh		;979e
L_97A0:
	ld hl,0ec80h		;97a0   ; [y][x][dibujo 0][color 8]
	ld (hl),e			;97a3
	inc hl			;97a4
	ld (hl),d			;97a5
	inc hl			;97a6
	ld (hl),000h		;97a7
	inc hl			;97a9
	ld (hl),008h		;97aa
	jp 05474h		;97ac   ; sprites_a_vram: la copia de la tabla de sprites (0xEC80) a 0x3B00
pinta_contrasena:		; la contraseña tecleada en tres filas
	ld hl,03908h		;97af   ; las tres filas de 16 en 0x3908, 0x3948 y 0x3988
	ld de,0eb00h		;97b2   ; apunta a el tampon de 0xEB00 (lo de debajo de las figuras; la contraseña)
	call fila_de_contrasena		;97b5   ; fila_de_contrasena: 16 letras en grupos de 4
	ld hl,03948h		;97b8
	ld de,0eb10h		;97bb
	call fila_de_contrasena		;97be   ; fila_de_contrasena: 16 letras en grupos de 4
	ld hl,03988h		;97c1
	ld de,0eb20h		;97c4
fila_de_contrasena:		; 16 letras en grupos de 4
	ld bc,01000h		;97c7   ; 16 letras, con un hueco cada 4
L_97CA:
	ld a,(de)			;97ca
	call 0004dh		;97cb   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;97ce
	inc de			;97cf
	inc c			;97d0
	ld a,c			;97d1
	and 003h		;97d2
	jr nz,L_97DA		;97d4
	call 0004dh		;97d6   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;97d9
L_97DA:
	djnz L_97CA		;97da
	ret			;97dc
mira_contrasena:		; descifra y comprueba la contraseña; buena, 0xE02D = 1
	call letras_a_valores		;97dd   ; la contraseña tecleada: a valores...
	call suma_buena		;97e0   ; ...y comprobada...
	ret z			;97e3
	ld a,001h		;97e4   ; ...buena: hecho
	ld (0e02dh),a		;97e6   ; guarda hecho (estado 0x12)
	ret			;97e9
letras_a_valores:		; cada letra de la contraseña a su valor
	ld hl,0eb00h		;97ea   ; cada letra a su valor: su posicion en la tabla 0x9671
	ld de,0eb40h		;97ed
	ld b,02bh		;97f0
L_97F2:
	push de			;97f2
	ld c,000h		;97f3
	ld de,09671h		;97f5
L_97F8:
	inc c			;97f8   ; busca la letra en la tabla
	ld a,(de)			;97f9
	cp (hl)			;97fa
	jr z,L_9800		;97fb
	inc de			;97fd
	jr L_97F8		;97fe
L_9800:
	ld a,b			;9800   ; menos la posicion mod 4
	and 003h		;9801   ; el valor: posicion en la tabla - (posicion mod 4) - 1
	ld d,a			;9803
	ld a,c			;9804
	sub d			;9805
	dec a			;9806
	pop de			;9807
	ld (de),a			;9808
	inc hl			;9809
	inc de			;980a
	djnz L_97F2		;980b   ; las 43
	ret			;980d
suma_buena:		; Z si la suma de las 43 letras es la de las dos ultimas
	ld de,0eb00h		;980e   ; la suma de las 43 letras...
	ld l,000h		;9811
	ld b,02bh		;9813
L_9815:
	ld a,(de)			;9815   ; la suma...
	add a,l			;9816
	ld l,a			;9817
	inc de			;9818
	djnz L_9815		;9819
	ld e,l			;981b
	ld hl,0eb2bh		;981c   ; ...contra las dos ultimas (nibble alto y bajo)
	ld a,(hl)			;981f   ; ...la primera letra de la suma - 1, arriba...
	dec a			;9820
	rlca			;9821
	rlca			;9822
	rlca			;9823
	rlca			;9824
	inc hl			;9825
	ld b,(hl)			;9826   ; ...la segunda - 1, abajo...
	dec b			;9827
	or b			;9828
	cp e			;9829   ; ...Z si coinciden
	ret			;982a
contrasena_a_la_partida:		; los valores de la contraseña a la RAM de la partida
	ld de,0eb40h		;982b   ; la contraseña a la partida: flechas, monedas y llaves...
	ld hl,0e046h		;982e   ; apunta a las flechas (BCD)
	ld a,006h		;9831
	ld c,000h		;9833
	call desempaqueta_bits		;9835   ; desempaqueta_bits: A valores de 5 bits por letra de DE a HL
	ld de,0eb4ah		;9838   ; ...los topes...
	ld hl,0e051h		;983b   ; apunta a el tope de la experiencia de Afrodita
	ld a,004h		;983e
	ld c,001h		;9840
	call desempaqueta_bits		;9842   ; desempaqueta_bits: A valores de 5 bits por letra de DE a HL
	ld de,0eb51h		;9845   ; ...las marcas de los mundos...
	ld hl,0e063h		;9848   ; apunta a las marcas del mapa 2 (bits 7-4: objetos 09 08 07 0A; bit 2: jefe vencido)
	ld a,00ah		;984b
	ld c,000h		;984d
	call desempaqueta_bits		;984f   ; desempaqueta_bits: A valores de 5 bits por letra de DE a HL
	ld hl,0eb61h		;9852   ; ...y los 44 objetos
	ld de,0e070h		;9855   ; apunta a tiene el objeto 0x01
	exx			;9858
	ld c,02ch		;9859
	exx			;985b
L_985C:
	ld b,005h		;985c
	ld c,(hl)			;985e   ; 5 bits por letra
	rlc c		;985f
	rlc c		;9861
	rlc c		;9863
L_9865:
	rl c		;9865
	ld a,001h		;9867
	jr c,L_986C		;9869
	xor a			;986b
L_986C:
	ld (de),a			;986c   ; el bit (0 o 1) al objeto...
	inc de			;986d
	exx			;986e
	dec c			;986f   ; ...hasta los 44
	exx			;9870
	jr z,L_9878		;9871
	djnz L_9865		;9873
	inc hl			;9875
	jr L_985C		;9876
L_9878:
	ld a,(0e097h)		;9878   ; el nivel de 0xE097 segun los objetos 0x2C o 0x2B
	and a			;987b
	jr z,L_9891		;987c
	ld hl,0e09bh		;987e   ; apunta a tiene el objeto 0x2C
	ld b,003h		;9881
	ld a,(hl)			;9883
	and a			;9884
	jr nz,L_988D		;9885
	dec b			;9887
	dec hl			;9888
	ld a,(hl)			;9889
	and a			;988a
	jr z,L_9891		;988b
L_988D:
	ld a,b			;988d
	ld (0e097h),a		;988e   ; guarda el nivel de los objetos 0x28/0x2B/0x2C
L_9891:
	ld a,(0eb6ah)		;9891   ; las vidas y 0xE05A/0xE05B: un bit cada uno...
	ld hl,0e058h		;9894   ; apunta a las vidas de Afrodita (BCD)
	ld b,004h		;9897
L_9899:
	ld (hl),000h		;9899
	rra			;989b
	jr nc,L_98A0		;989c
	ld (hl),001h		;989e
L_98A0:
	inc hl			;98a0
	djnz L_9899		;98a1
	rra			;98a3   ; ...y quien juega
	ld a,001h		;98a4
	jr c,L_98A9		;98a6
	xor a			;98a8
L_98A9:
	ld (0e501h),a		;98a9   ; guarda quien juega (0 Afrodita)
	ret			;98ac
desempaqueta_bits:		; A valores de 5 bits por letra de DE a HL
	ld (0f000h),a		;98ad   ; A valores (de dos en dos con C = 1) de 5 bits por letra
	ld a,c			;98b0
	ld (0f001h),a		;98b1
	exx			;98b4
	ld b,005h		;98b5
	exx			;98b7
	ld a,(de)			;98b8   ; los 5 bits de la letra arriba
	rlca			;98b9
	rlca			;98ba
	rlca			;98bb
	ld c,a			;98bc
L_98BD:
	ld b,008h		;98bd
L_98BF:
	rl c		;98bf   ; un bit mas...
	rl (hl)		;98c1
	exx			;98c3
	dec b			;98c4
	exx			;98c5
	jr nz,L_98D2		;98c6
	inc de			;98c8   ; ...y a la letra siguiente
	ld a,(de)			;98c9
	rlca			;98ca
	rlca			;98cb
	rlca			;98cc
	ld c,a			;98cd
	exx			;98ce
	ld b,005h		;98cf
	exx			;98d1
L_98D2:
	djnz L_98BF		;98d2
	inc hl			;98d4   ; el byte siguiente (dos con C)
	ld a,(0f001h)		;98d5
	and a			;98d8
	jr z,L_98DC		;98d9
	inc hl			;98db
L_98DC:
	exx			;98dc   ; A valores
	ld hl,0f000h		;98dd
	dec (hl)			;98e0
	exx			;98e1
	jr nz,L_98BD		;98e2
	ret			;98e4
tecla_l:		; C si la L (fila 4, bit 1) no esta apretada
	ld a,004h		;98e5   ; la L (fila 4, bit 1): sin apretar, acarreo
	call 00141h		;98e7   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;98ea
	rra			;98eb
	ret			;98ec
texto_de_contrasena:		; el rotulo de la pantalla de la contraseña (banco 9)
	call 0422bh		;98ed   ; el rotulo de la contraseña, en japones o en ingles segun 0x002B
	ld c,0ffh		;98f0
	ld hl,03887h		;98f2
	ld a,(0002bh)		;98f5
	and 0f0h		;98f8
	ld de,0bebdh		;98fa
	jr z,L_9902		;98fd
	ld de,0bf3ch		;98ff
L_9902:
	call 05c2dh		;9902
	jp 04215h		;9905   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
texto_mala:		; el rotulo de contraseña mala
	call 0422bh		;9908   ; contraseña mala: el rotulo...
	ld c,0ffh		;990b
	jr L_9914		;990d
borra_texto_mala:		; borra el rotulo de contraseña mala
	call 0422bh		;990f   ; ...o borrarlo
	ld c,000h		;9912
L_9914:
	ld hl,03a47h		;9914   ; el rotulo en la fila 18, columna 7
	ld a,(0002bh)		;9917
	and 0f0h		;991a
	ld de,0bee3h		;991c
	jr z,L_9924		;991f
	ld de,0bf6ch		;9921
L_9924:
	jr L_9902		;9924
texto_buena:		; el rotulo de contraseña buena
	call 0422bh		;9926   ; el rotulo de contraseña buena
	ld c,0ffh		;9929
	ld hl,039c7h		;992b
	ld a,(0002bh)		;992e
	and 0f0h		;9931
	ld de,0bef6h		;9933
	jr z,L_993B		;9936
	ld de,0bf86h		;9938
L_993B:
	jr L_9902		;993b
puerta_de_mundo:		; en el castillo, la puerta de mundo de la sala (0x9990) en 0xE688-0xE68B
	ld hl,(0e041h)		;993d   ; en el castillo...
	dec l			;9940
	ret nz			;9941
	ld a,h			;9942
	ld hl,09990h		;9943   ; ...la sala tiene puerta de mundo (0x9990, 9 salas)?
	ld bc,00901h		;9946
L_9949:
	cp (hl)			;9949
	jr z,L_996A		;994a
	inc hl			;994c
	inc c			;994d
	djnz L_9949		;994e
	ld a,(0e06ch)		;9950   ; si no, la del mapa 11: solo con los bits 0-1 de sus marcas...
	and 003h		;9953
	ret z			;9955
	ld a,(0e06dh)		;9956   ; ...en su sala (0xE06D)...
	ld b,a			;9959
	ld a,(0e042h)		;995a   ; lee la sala
	cp b			;995d
	ret nz			;995e
	ld a,(0e06eh)		;995f   ; ...en su sitio (0x99AB)
	ld hl,099abh		;9962
	call 0414ch		;9965   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	jr L_9971		;9968
L_996A:
	ld a,c			;996a   ; el sitio de la puerta C (0x9997)
	ld hl,09997h		;996b
	call 0414ch		;996e   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
L_9971:
	ld hl,0e688h		;9971   ; el mundo, y su sitio en 0xE68A-0xE68B
	ld (hl),c			;9974
	inc l			;9975
	inc l			;9976
	ld (hl),e			;9977
	inc l			;9978
	ld (hl),d			;9979
	inc l			;997a
	ld b,000h		;997b
	ld hl,0e062h		;997d   ; los bits 0-1 de sus marcas: abierta y se puede abrir
	add hl,bc			;9980
	ld a,(hl)			;9981
	and 003h		;9982
	ld (0e689h),a		;9984   ; guarda la puerta del mundo: bit 0 abierta, bit 1 se puede abrir
	bit 0,a		;9987   ; abierta: el dibujo 2
	ret z			;9989
	ld a,002h		;998a
	ld (0e68ch),a		;998c   ; guarda el dibujo de la puerta del mundo elegido
	ret			;998f

; ----------------------------------------------------------------------
; DATOS salas_de_las_puertas: 9 salas del castillo (104, 98, 63, 57, 62, 114,
;   6, 23 y 108): p02:9943 busca en ellas la sala 0xE042 y p02:9AB9 lleva a la
;   n cuando se pulsa la cifra n en el castillo con 0xE096 puesto y el mundo n
;   ya visitado (bit 0 de 0xE063 + n)
;   0x9990..0x9999  (9 bytes)
DATA_salas_de_las_puertas:
	defb 068h,062h,03fh,039h,03eh,072h,006h,017h,06ch	; 9990  hb?9>r..l

; ----------------------------------------------------------------------
; DATOS sitios_de_las_puertas: 9 parejas [Y][X], una por sala de 0x9990, que
;   p02:996B lee en 0x9997 + 2 x C y pone en 0xE68A
;   0x9999..0x99ab  (18 bytes)
DATA_sitios_de_las_puertas:
	defb 040h,040h	; 9999
	defb 040h,0c0h	; 999b
	defb 040h,0a0h	; 999d
	defb 060h,040h	; 999f
	defb 040h,040h	; 99a1
	defb 040h,0a0h	; 99a3
	defb 0a0h,020h	; 99a5
	defb 0a0h,060h	; 99a7
	defb 040h,060h	; 99a9

; ----------------------------------------------------------------------
; DATOS cuatro_sitios_99ab: 4 parejas [Y][X] que p02:9962 elige con (0xE06E)
;   0x99ab..0x99b3  (8 bytes)
DATA_cuatro_sitios_99ab:
	defb 0a0h,040h	; 99ab
	defb 020h,0a0h	; 99ad
	defb 0a0h,060h	; 99af
	defb 060h,0a0h	; 99b1

; ======================================================================
; CODIGO 0x99b3..0x99c4  (17 bytes)
; ======================================================================


puerta_del_mapa_11:		; el sitio al azar de la puerta del mapa 11 (0xE06D, 0xE06E)
	ld a,r		;99b3   ; la puerta del mapa 11 en uno de 4 sitios al azar
	and 003h		;99b5
	ld (0e06eh),a		;99b7   ; guarda el sitio de la puerta del mapa 11 (0-3)
	ld hl,099c4h		;99ba
	call 04155h		;99bd   ; byte_de_tabla: A = el byte HL + A
	ld (0e06dh),a		;99c0   ; guarda la sala de la puerta del mapa 11
	ret			;99c3

; ----------------------------------------------------------------------
; DATOS cuatro_salas_99c4: 4 salas que p02:99BA elige al azar (R mod 4, el
;   mismo de 0xE06E) para 0xE06D
;   0x99c4..0x99c8  (4 bytes)
DATA_cuatro_salas_99c4:
	defb 009h,01eh,027h,001h	; 99c4

; ======================================================================
; CODIGO 0x99c8..0x9b55  (397 bytes)
; ======================================================================


abre_la_puerta:		; la puerta del mundo se abre poco a poco; abierta, se gasta el objeto 0x0C
	ld hl,(0e688h)		;99c8   ; con puerta de mundo cerrada...
	ld a,l			;99cb
	or a			;99cc
	ret z			;99cd
	bit 0,h		;99ce
	ret nz			;99d0
	ld hl,0e68dh		;99d1   ; ...abriendose (0xE68D)...
	ld a,(hl)			;99d4
	or a			;99d5
	ret z			;99d6
	inc l			;99d7   ; ...cada 6 cuadros el dibujo siguiente...
	dec (hl)			;99d8
	ret nz			;99d9
	dec l			;99da
	inc (hl)			;99db
	ld a,(hl)			;99dc
	cp 004h		;99dd
	jr nc,L_99E9		;99df
	inc l			;99e1
	ld (hl),006h		;99e2
	dec a			;99e4
	ld (0e68ch),a		;99e5   ; guarda el dibujo de la puerta del mundo elegido
	ret			;99e8
L_99E9:
	ld hl,0e689h		;99e9   ; ...abierta: el bit 0 en 0xE689 y en las marcas del mundo...
	set 0,(hl)		;99ec
	dec l			;99ee
	ld c,(hl)			;99ef
	ld b,000h		;99f0
	ld hl,0e062h		;99f2   ; apunta a las barras que repintar (bits 0-3)
	add hl,bc			;99f5
	set 0,(hl)		;99f6
	res 1,(hl)		;99f8
	xor a			;99fa   ; ...y se gasta el objeto 0x0C
	ld (0e07bh),a		;99fb   ; guarda tiene el objeto 0x0C
	ret			;99fe
entra_en_el_mundo:		; con abajo delante de la puerta abierta: al estado 8
	call 044eah		;99ff   ; no en los estados 4-7 del personaje
	ret c			;9a02
	ld hl,0e688h		;9a03   ; apunta a el mundo elegido (mapa - 1)
	ld a,(hl)			;9a06
	or a			;9a07
	ret z			;9a08
	inc l			;9a09   ; abierta: a entrar...
	bit 0,(hl)		;9a0a
	jr nz,L_9A25		;9a0c
	bit 1,(hl)		;9a0e   ; ...cerrada pero se puede abrir (bit 1)...
	ret z			;9a10
	ld a,(0e68dh)		;9a11   ; lee abriendo la puerta del mundo
	or a			;9a14
	ret nz			;9a15
	call delante_de_la_puerta		;9a16   ; ...delante de ella, empieza a abrirse con el sonido 0x22
	ret nc			;9a19
	ld hl,00601h		;9a1a
	ld (0e68dh),hl		;9a1d   ; guarda abriendo la puerta del mundo y el byte siguiente (16 bits)
	ld a,022h		;9a20
	jp 04e1fh		;9a22   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_9A25:
	ld a,(0e501h)		;9a25   ; el mundo 5: Afrodita necesita el objeto 0x23
	ld b,a			;9a28
	ld a,(0e688h)		;9a29   ; lee el mundo elegido (mapa - 1)
	cp 005h		;9a2c
	jr nz,L_9A3A		;9a2e
	dec b			;9a30
	jr z,L_9A46		;9a31
	ld a,(0e092h)		;9a33   ; lee tiene el objeto 0x23
	or a			;9a36
	ret z			;9a37
	jr L_9A46		;9a38
L_9A3A:
	cp 007h		;9a3a   ; el mundo 7: Popolon necesita el 0x0D
	jr nz,L_9A46		;9a3c
	dec b			;9a3e
	jr nz,L_9A46		;9a3f
	ld a,(0e07ch)		;9a41   ; lee tiene el objeto 0x0D
	or a			;9a44
	ret z			;9a45
L_9A46:
	ld a,(0e009h)		;9a46   ; con abajo apretado...
	and 002h		;9a49
	ret z			;9a4b
	call delante_de_la_puerta		;9a4c   ; ...delante de la puerta...
	ret nc			;9a4f
	ld a,001h		;9a50   ; ...al estado 8 (entrar en el mundo)
	ld (0e01fh),a		;9a52   ; guarda 1 = estado 8, 2 = estado 0x0D
	ret			;9a55
delante_de_la_puerta:		; C si el personaje esta delante de la puerta de mundo
	ld hl,0e68ah		;9a56   ; la puerta del mundo: 0x18 de alto, 0x0E de lado
	ld de,0180eh		;9a59
	jp delante_de		;9a5c   ; delante_de: C si el personaje esta a D, E de la y, x de HL
delante_de_la_vuelta:		; C si el personaje esta delante de la puerta de vuelta
	ld hl,0e682h		;9a5f   ; la de vuelta: 0x10 y 6
	ld de,01006h		;9a62
delante_de:		; C si el personaje esta a D, E de la y, x de HL
	ld a,(0e505h)		;9a65   ; C si la y del personaje esta a 0-1 de la de HL + D...
	sub (hl)			;9a68
	sub d			;9a69
	cp 002h		;9a6a
	ret nc			;9a6c
	ld a,(0e507h)		;9a6d   ; ...y la x a 0-4 de la de HL + E
	inc l			;9a70
	sub (hl)			;9a71
	sub e			;9a72
	cp 005h		;9a73
	ret			;9a75
sale_del_mundo:		; con abajo delante de la puerta de vuelta: estado 0x10
	call 044eah		;9a76   ; la puerta de vuelta de la sala...
	ret c			;9a79
	ld hl,0e680h		;9a7a   ; apunta a hay puerta de vuelta en la sala
	ld a,(hl)			;9a7d
	or a			;9a7e
	ret z			;9a7f
	cp 003h		;9a80   ; ...la de tipo 3 pide el objeto 0x2A...
	jr nz,L_9A89		;9a82
	ld a,(0e099h)		;9a84   ; lee tiene el objeto 0x2A
	or a			;9a87
	ret z			;9a88
L_9A89:
	ld a,(0e009h)		;9a89   ; ...con abajo apretado delante: al estado 0x10
	and 002h		;9a8c
	ret z			;9a8e
	call delante_de_la_vuelta		;9a8f   ; delante_de_la_vuelta: C si el personaje esta delante de la puerta de vuelta
	ret nc			;9a92
	ld a,001h		;9a93
	ld (0e01ch),a		;9a95   ; guarda estado 0x10 pedido
	ret			;9a98
cifra_del_castillo:		; con el objeto 0x27, la cifra 1-9 lleva a la puerta de ese mundo
	ld a,(0e096h)		;9a99   ; con el objeto 0x27, en el castillo...
	and a			;9a9c
	ret z			;9a9d
	ld a,(0e041h)		;9a9e   ; lee el mapa (1 el castillo, 2-11 los mundos)
	dec a			;9aa1
	ret nz			;9aa2
	call tecla_ascii		;9aa3   ; ...una cifra 1-9...
	and a			;9aa6
	ret z			;9aa7
	sub 031h		;9aa8
	cp 009h		;9aaa
	ret nc			;9aac
	ld b,a			;9aad
	ld hl,0e063h		;9aae   ; ...si la puerta de ese mundo esta abierta...
	call 04136h		;9ab1   ; hl_mas_a: HL += A
	ld a,(hl)			;9ab4
	rr a		;9ab5
	ret nc			;9ab7
	ld a,b			;9ab8   ; ...a su sala (0x9990)
	ld hl,09990h		;9ab9
	call 04136h		;9abc   ; hl_mas_a: HL += A
	ld a,(hl)			;9abf
	ld (0e042h),a		;9ac0   ; guarda la sala
	ld a,001h		;9ac3
	ld (0f000h),a		;9ac5
	ret			;9ac8
return_al_castillo:		; con el objeto 0x15 y sin jefe, C con RETURN
	ld a,(0e084h)		;9ac9   ; con el objeto 0x15, sin jefe...
	and a			;9acc
	ret z			;9acd
	ld a,(0e0d2h)		;9ace   ; lee el estado del jefe
	and a			;9ad1
	ret nz			;9ad2
	ld a,(0e0d4h)		;9ad3   ; lee la cosa del jefe vencido puesta
	and a			;9ad6
	ret nz			;9ad7
	call tecla_ascii		;9ad8   ; ...C con RETURN
	and a			;9adb
	ret z			;9adc
	cp 00dh		;9add
	jr z,L_9AE3		;9adf
	or a			;9ae1
	ret			;9ae2
L_9AE3:
	scf			;9ae3
	ret			;9ae4
recuadro_del_jefe:		; en la sala del jefe sin jefe, 0xE615 = 1 y las letras a cero
	xor a			;9ae5   ; en la sala del jefe del mapa, sin jefe ni vencido...
	ld (0e615h),a		;9ae6   ; guarda en la sala del jefe sin jefe (el recuadro)
	call 05de4h		;9ae9   ; sala_del_jefe: Z en la sala del jefe del mapa sin vencer
	ret nz			;9aec
	ld a,(0e0d2h)		;9aed   ; lee el estado del jefe
	or a			;9af0
	ret nz			;9af1
	ld a,001h		;9af2   ; ...el recuadro (0xE615) y las 16 letras de 0xE6B0 a cero
	ld (0e615h),a		;9af4   ; guarda en la sala del jefe sin jefe (el recuadro)
	ld hl,0e6b0h		;9af7   ; apunta a las 16 ultimas letras tecleadas
	ld b,010h		;9afa
L_9AFC:
	ld (hl),000h		;9afc
	inc l			;9afe
	djnz L_9AFC		;9aff
	ret			;9b01
nombre_del_jefe:		; las teclas contra el nombre del jefe del mapa (0x9B4F); acertado, 0xE020
	ld a,(0e615h)		;9b02   ; con el recuadro del jefe...
	or a			;9b05
	ret z			;9b06
	call letra_tecleada		;9b07   ; ...una letra nueva...
	ret z			;9b0a
	call compara_nombre		;9b0b   ; ...y el nombre acertado...
	ret nz			;9b0e
	xor a			;9b0f   ; ...sale el jefe (0xE020 = 1)
	ld (0e615h),a		;9b10   ; guarda en la sala del jefe sin jefe (el recuadro)
	inc a			;9b13
	ld (0e020h),a		;9b14   ; guarda el nombre del jefe acertado
	ret			;9b17
compara_nombre:		; Z si las ultimas letras tecleadas son el nombre del jefe del mapa
	ld hl,09b4fh		;9b18   ; el nombre del mapa en 0x9B4F: [texto][largo] (3 bytes por mapa)...
	ld a,(0e041h)		;9b1b   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld c,a			;9b1e
	add a,a			;9b1f
	add a,c			;9b20
	ld c,a			;9b21
	ld b,000h		;9b22
	add hl,bc			;9b24
	ld e,(hl)			;9b25
	inc hl			;9b26
	ld d,(hl)			;9b27
	inc hl			;9b28
	ld a,010h		;9b29   ; ...contra las ultimas (largo) de las 16 letras
	sub (hl)			;9b2b
	ld c,a			;9b2c
	ld a,(hl)			;9b2d
	ld hl,0e6b0h		;9b2e   ; apunta a las 16 ultimas letras tecleadas
	add hl,bc			;9b31
	ld b,a			;9b32
compara_b:		; Z si los B bytes de DE y HL son iguales
	ld a,(de)			;9b33   ; letra a letra
	cp (hl)			;9b34
	ret nz			;9b35
	inc de			;9b36
	inc hl			;9b37
	djnz compara_b		;9b38
	xor a			;9b3a
	ret			;9b3b
letra_tecleada:		; la tecla nueva entra al final de las 16 letras de 0xE6B0
	call tecla_ascii		;9b3c   ; la tecla...
	or a			;9b3f
	ret z			;9b40
	ld hl,0e616h		;9b41   ; ...si es otra que la de antes...
	cp (hl)			;9b44
	ret z			;9b45
	ld (hl),a			;9b46
	ld hl,0e6b1h		;9b47   ; ...las 16 letras se corren y entra al final
	ld de,0e6b0h		;9b4a   ; apunta a las 16 ultimas letras tecleadas
	ld bc,0000fh		;9b4d
	ldir		;9b50
	ld (de),a			;9b52
	or a			;9b53
	ret			;9b54

; ----------------------------------------------------------------------
; DATOS tabla_de_hechizos_ascii: 10 ternas [puntero][largo], una por hechizo,
;   a sus letras en ASCII (p02:93F5 y la rutina de escribirlos)
;   0x9b55..0x9b73  (30 bytes)
DATA_tabla_de_hechizos_ascii:
	defb 073h,09bh,005h	; 9b55
	defb 078h,09bh,006h	; 9b58
	defb 07eh,09bh,007h	; 9b5b
	defb 085h,09bh,008h	; 9b5e
	defb 08dh,09bh,008h	; 9b61
	defb 095h,09bh,005h	; 9b64
	defb 09ah,09bh,007h	; 9b67
	defb 0a1h,09bh,006h	; 9b6a
	defb 0a7h,09bh,007h	; 9b6d
	defb 0aeh,09bh,008h	; 9b70

; ----------------------------------------------------------------------
; DATOS hechizos_ascii: YOMAR ELOHIM HAHAKLA BARECHET HEOTYMEO LEPHA NAWABRA
;   ASCHER XYWOLEH HAMALECH en ASCII, seguidos (67 bytes)
;   0x9b73..0x9bb6  (67 bytes)
DATA_hechizos_ascii:
	defb 059h,04fh,04dh,041h,052h,045h,04ch,04fh,048h,049h,04dh,048h,041h,048h,041h,04bh	; 9b73  YOMARELOHIMHAHAK
	defb 04ch,041h,042h,041h,052h,045h,043h,048h,045h,054h,048h,045h,04fh,054h,059h,04dh	; 9b83  LABARECHETHEOTYM
	defb 045h,04fh,04ch,045h,050h,048h,041h,04eh,041h,057h,041h,042h,052h,041h,041h,053h	; 9b93  EOLEPHANAWABRAAS
	defb 043h,048h,045h,052h,058h,059h,057h,04fh,04ch,045h,048h,048h,041h,04dh,041h,04ch	; 9ba3  CHERXYWOLEHHAMAL
	defb 045h,043h,048h	; 9bb3

; ======================================================================
; CODIGO 0x9bb6..0x9c0b  (85 bytes)
; ======================================================================


objeto_20:		; con el objeto 0x20 y CTRL, todo se para un rato (hasta 16 veces)
	ld a,(0e08fh)		;9bb6   ; con el objeto 0x20...
	or a			;9bb9
	ret z			;9bba
	ld a,(0e500h)		;9bbb   ; ...no hundiendose, sin recuadro del jefe, sin 0xE1CB...
	cp 005h		;9bbe
	ret z			;9bc0
	ld a,(0e615h)		;9bc1   ; lee en la sala del jefe sin jefe (el recuadro)
	or a			;9bc4
	ret nz			;9bc5
	ld a,(0e1cbh)		;9bc6
	or a			;9bc9
	ret nz			;9bca
	ld a,(0e0d5h)		;9bcb   ; ...ni ya parado...
	or a			;9bce
	ret nz			;9bcf
	ld a,(0e531h)		;9bd0   ; ...hasta 16 veces...
	cp 010h		;9bd3
	ret nc			;9bd5
	ld a,006h		;9bd6   ; ...CTRL (fila 6, bit 1)...
	call 00141h		;9bd8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9bdb
	and 002h		;9bdc
	ret z			;9bde
	ld hl,09601h		;9bdf   ; ...todo parado 0x96...
	ld (0e0d5h),hl		;9be2   ; guarda todo parado (objeto 0x20) y el byte siguiente (16 bits)
	ld hl,0e531h		;9be5   ; ...una vez mas...
	inc (hl)			;9be8
	ld a,0fbh		;9be9   ; ...y el sonido 0xFB
	jp 04e1fh		;9beb   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
mira_umbrella:		; con el objeto 0x26, las 8 ultimas letras contra UMBRELLA
	ld a,(0e095h)		;9bee   ; con el objeto 0x26 y 0xE63E...
	or a			;9bf1
	ret z			;9bf2
	ld a,(0e63eh)		;9bf3
	or a			;9bf6
	ret z			;9bf7
	call letra_tecleada		;9bf8   ; ...una letra nueva...
	ret z			;9bfb
	ld hl,0e6b8h		;9bfc   ; ...y las 8 ultimas son UMBRELLA (0x9C0B)...
	ld de,09c0bh		;9bff
	ld b,008h		;9c02
	call compara_b		;9c04   ; compara_b: Z si los B bytes de DE y HL son iguales
	ret nz			;9c07
	jp 0b5eah		;9c08   ; ...acaba con las figuras de tipo 0x0E

; ----------------------------------------------------------------------
; DATOS umbrella: UMBRELLA en ASCII: p02:9BFF lo compara con las 8 letras
;   escritas en 0xE6B8 (p02:9B33) y, si coincide, salta a p03:B5EA
;   0x9c0b..0x9c13  (8 bytes)
DATA_umbrella:
	defb 055h,04dh,042h,052h,045h,04ch,04ch,041h	; 9c0b  UMBRELLA

; ======================================================================
; CODIGO 0x9c13..0x9c3b  (40 bytes)
; ======================================================================


tecla_ascii:		; A = el ASCII de la primera tecla apretada (0 si ninguna)
	ld b,008h		;9c13   ; las filas 0-7 del teclado...
	ld e,000h		;9c15
L_9C17:
	ld a,e			;9c17
	call 00141h		;9c18   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9c1b   ; ...la primera con una tecla...
	and a			;9c1c
	jr nz,L_9C27		;9c1d
	inc e			;9c1f
	djnz L_9C17		;9c20
	xor a			;9c22   ; ...ninguna: 0
	ld (0e616h),a		;9c23   ; guarda la ultima tecla
	ret			;9c26
L_9C27:
	ld b,a			;9c27   ; el ASCII de la tabla 0x9C3B: 8 por fila...
	ld a,e			;9c28
	add a,a			;9c29
	add a,a			;9c2a
	add a,a			;9c2b
	ld hl,09c3bh		;9c2c
	call 04136h		;9c2f   ; hl_mas_a: HL += A
	ld a,b			;9c32
L_9C33:
	rra			;9c33   ; ...el primer bit apretado
	jr c,L_9C39		;9c34
	inc hl			;9c36
	jr L_9C33		;9c37
L_9C39:
	ld a,(hl)			;9c39
	ret			;9c3a

; ----------------------------------------------------------------------
; DATOS teclado_ascii: el ASCII de cada tecla de las filas 0-7 de la matriz
;   del teclado (8 x 8), que p02:9C2C usa para convertir la primera tecla
;   pulsada (p02:9C13)
;   0x9c3b..0x9c7b  (64 bytes)
DATA_teclado_ascii:
	defb 030h,031h,032h,033h,034h,035h,036h,037h	; 9c3b  01234567
	defb 038h,039h,000h,000h,000h,000h,000h,000h	; 9c43  89......
	defb 000h,000h,000h,000h,000h,000h,041h,042h	; 9c4b  ......AB
	defb 043h,044h,045h,046h,047h,048h,049h,04ah	; 9c53  CDEFGHIJ
	defb 04bh,04ch,04dh,04eh,04fh,050h,051h,052h	; 9c5b  KLMNOPQR
	defb 053h,054h,055h,056h,057h,058h,059h,05ah	; 9c63  STUVWXYZ
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 9c6b  ........
	defb 000h,000h,000h,000h,000h,000h,000h,00dh	; 9c73  ........

; ----------------------------------------------------------------------
; DATOS fila_8: 8 ceros: una fila mas de la tabla del teclado que p02:9C13 no
;   mira (solo las filas 0-7)
;   0x9c7b..0x9c83  (8 bytes)
DATA_fila_8:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; 9c7b  ........

; ----------------------------------------------------------------------
; DATOS tabla_de_monumentos: 10 punteros, mapas 2-11, que p01:69E9 elige con
;   mapa - 2 (0x414C), a las piedras con hechizo
;   0x9c83..0x9c97  (20 bytes)
DATA_tabla_de_monumentos:
	defb 097h,09ch	; 9c83
	defb 0a7h,09ch	; 9c85
	defb 0bdh,09ch	; 9c87
	defb 0d9h,09ch	; 9c89
	defb 0f2h,09ch	; 9c8b
	defb 00eh,09dh	; 9c8d
	defb 02dh,09dh	; 9c8f
	defb 058h,09dh	; 9c91
	defb 077h,09dh	; 9c93
	defb 0abh,09dh	; 9c95

; ----------------------------------------------------------------------
; DATOS monumentos: por mundo, las piedras: [sala][hechizo en el nibble bajo y
;   la Y][X] (3 bytes), acabadas en 0 (p01:69F3)
;   0x9c97..0x9daf  (280 bytes)
DATA_monumentos:
	defb 003h,050h,028h	; 9c97
	defb 005h,010h,089h	; 9c9a
	defb 00ah,0d0h,048h	; 9c9d
	defb 00ch,011h,0a9h	; 9ca0
	defb 00eh,090h,029h	; 9ca3
	defb 000h,004h,050h	; 9ca6
	defb 028h,005h,050h	; 9ca9
	defb 048h,007h,010h	; 9cac
	defb 0a9h,008h,090h	; 9caf
	defb 029h,00ah,012h	; 9cb2
	defb 029h,00ch,010h	; 9cb5
	defb 029h,00dh,010h	; 9cb8
	defb 0a9h,000h,002h	; 9cbb
	defb 010h,029h,003h	; 9cbe
	defb 050h,029h,006h	; 9cc1
	defb 050h,0a9h,007h	; 9cc4
	defb 050h,089h,009h	; 9cc7
	defb 093h,068h,00bh	; 9cca
	defb 050h,068h,00ch	; 9ccd
	defb 050h,069h,00eh	; 9cd0
	defb 090h,068h,00fh	; 9cd3
	defb 0d0h,028h,000h	; 9cd6
	defb 002h,090h,0a9h	; 9cd9
	defb 004h,050h,0a9h	; 9cdc
	defb 005h,090h,029h	; 9cdf
	defb 007h,050h,068h	; 9ce2
	defb 008h,050h,048h	; 9ce5
	defb 009h,050h,029h	; 9ce8
	defb 00ch,050h,028h	; 9ceb
	defb 00dh,0d4h,0a8h	; 9cee
	defb 000h,002h,090h	; 9cf1
	defb 069h,003h,050h	; 9cf4
	defb 088h,004h,050h	; 9cf7
	defb 088h,005h,0d5h	; 9cfa
	defb 088h,008h,0d0h	; 9cfd
	defb 068h,00ah,0d0h	; 9d00
	defb 068h,00dh,0d0h	; 9d03
	defb 028h,00eh,090h	; 9d06
	defb 048h,010h,050h	; 9d09
	defb 0a9h,000h,001h	; 9d0c
	defb 010h,089h,003h	; 9d0f
	defb 0d0h,088h,005h	; 9d12
	defb 050h,0a9h,007h	; 9d15
	defb 050h,069h,008h	; 9d18
	defb 090h,088h,009h	; 9d1b
	defb 050h,049h,00ah	; 9d1e
	defb 010h,049h,00eh	; 9d21
	defb 090h,028h,00fh	; 9d24
	defb 090h,089h,012h	; 9d27
	defb 016h,069h,000h	; 9d2a
	defb 002h,090h,0a9h	; 9d2d
	defb 003h,090h,028h	; 9d30
	defb 004h,090h,049h	; 9d33
	defb 006h,050h,069h	; 9d36
	defb 007h,090h,048h	; 9d39
	defb 008h,090h,028h	; 9d3c
	defb 00bh,010h,069h	; 9d3f
	defb 00ch,050h,028h	; 9d42
	defb 00dh,090h,068h	; 9d45
	defb 00eh,090h,029h	; 9d48
	defb 00fh,090h,0a8h	; 9d4b
	defb 011h,010h,0a9h	; 9d4e
	defb 012h,090h,089h	; 9d51
	defb 013h,097h,0a8h	; 9d54
	defb 000h,002h,090h	; 9d57
	defb 0a8h,003h,050h	; 9d5a
	defb 088h,004h,050h	; 9d5d
	defb 069h,006h,050h	; 9d60
	defb 049h,009h,098h	; 9d63
	defb 048h,00bh,0d0h	; 9d66
	defb 048h,010h,0d0h	; 9d69
	defb 048h,012h,050h	; 9d6c
	defb 049h,013h,050h	; 9d6f
	defb 049h,014h,010h	; 9d72
	defb 049h,000h,001h	; 9d75
	defb 050h,0a9h,005h	; 9d78
	defb 090h,028h,006h	; 9d7b
	defb 050h,068h,007h	; 9d7e
	defb 050h,049h,009h	; 9d81
	defb 090h,088h,00ah	; 9d84
	defb 050h,0a8h,00bh	; 9d87
	defb 0d0h,028h,00ch	; 9d8a
	defb 090h,0a8h,00dh	; 9d8d
	defb 050h,028h,00eh	; 9d90
	defb 090h,069h,00fh	; 9d93
	defb 0d0h,068h,010h	; 9d96
	defb 050h,028h,011h	; 9d99
	defb 050h,049h,012h	; 9d9c
	defb 090h,029h,013h	; 9d9f
	defb 0d0h,028h,015h	; 9da2
	defb 010h,089h,01ah	; 9da5
	defb 019h,028h,000h	; 9da8
	defb 004h,09ah,069h	; 9dab
	defb 000h	; 9dae

; ======================================================================
; CODIGO 0x9daf..0x9dda  (43 bytes)
; ======================================================================


puerta_de_vuelta_de_la_sala:		; en el castillo, la puerta de vuelta de la sala (0x9DDA) en 0xE680-0xE685
	ld bc,(0e041h)		;9daf   ; en el castillo, la puerta de vuelta de la sala: tabla 0x9DDA [sala][tipo][y][x]
	dec c			;9db3
	ret nz			;9db4
	ld hl,09ddah		;9db5
	ld de,00004h		;9db8
L_9DBB:
	ld a,(hl)			;9dbb   ; [sala] 0 acaba...
	or a			;9dbc
	ret z			;9dbd
	cp b			;9dbe
	jr z,L_9DC5		;9dbf
	add hl,de			;9dc1   ; ...4 bytes por entrada
	jp L_9DBB		;9dc2
L_9DC5:
	inc hl			;9dc5   ; a 0xE680 (tipo) y 0xE682-0xE683 (y, x)...
	ld de,0e680h		;9dc6   ; apunta a hay puerta de vuelta en la sala
	ldi		;9dc9
	inc e			;9dcb
	ldi		;9dcc
	ldi		;9dce
	ld hl,(0e682h)		;9dd0   ; ...y su casilla en 0xE684
	call 04da1h		;9dd3   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (0e684h),hl		;9dd6
	ret			;9dd9

; ----------------------------------------------------------------------
; DATOS fichas_del_castillo_9dda: 11 fichas de 4 bytes [sala]... del castillo
;   que p02:9DB5 recorre buscando la sala 0xE042, y un 0 al final
;   0x9dda..0x9e07  (45 bytes)
DATA_fichas_del_castillo_9dda:
	defb 004h,009h,068h,088h	; 9dda
	defb 00ah,00ah,028h,048h	; 9dde
	defb 005h,006h,028h,0e0h	; 9de2
	defb 036h,008h,0a8h,0d0h	; 9de6
	defb 037h,007h,0a8h,048h	; 9dea
	defb 041h,005h,028h,048h	; 9dee
	defb 048h,001h,068h,070h	; 9df2
	defb 057h,003h,088h,028h	; 9df6
	defb 073h,002h,068h,0b0h	; 9dfa
	defb 08fh,004h,048h,048h	; 9dfe
	defb 020h,00bh,048h,070h	; 9e02
	defb 000h	; 9e06

; ======================================================================
; CODIGO 0x9e07..0x9e6a  (99 bytes)
; ======================================================================


tecla_f2:		; C al apretar F2 (fila 6, bit 6) si 0xE002 tiene el bit 6
	ld a,(0e002h)		;9e07   ; solo con el bit 6 de 0xE002
	and 040h		;9e0a
	ret z			;9e0c
	ld a,006h		;9e0d   ; F2 (fila 6, bit 6)...
	call 00141h		;9e0f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9e12
	and 040h		;9e13
	ld hl,0e606h		;9e15   ; ...recien apretada: C
	ld c,(hl)			;9e18
	ld (hl),a			;9e19
	xor c			;9e1a
	ret z			;9e1b
	bit 6,(hl)		;9e1c
	ret z			;9e1e
	scf			;9e1f
	ret			;9e20
tecla_f1:		; C al apretar F1 (fila 6, bit 5) si 0xE002 tiene el bit 6
	ld a,(0e002h)		;9e21   ; solo con el bit 6 de 0xE002
	and 040h		;9e24
	ret z			;9e26
	ld a,006h		;9e27   ; F1 (fila 6, bit 5)
	call 00141h		;9e29   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9e2c
	and 020h		;9e2d
	ld hl,0e607h		;9e2f   ; apunta a F1 apretada
	ld c,(hl)			;9e32
	ld (hl),a			;9e33
	xor c			;9e34
	ret z			;9e35
	bit 5,(hl)		;9e36
	ret z			;9e38
	scf			;9e39
	ret			;9e3a
entra_por_la_puerta:		; al entrar en el mundo: la pose de espaldas, la musica 0x82 y los sprites de la puerta
	ld a,080h		;9e3b   ; al entrar en el mundo: 0x80 cuadros...
	ld (0e50fh),a		;9e3d
	xor a			;9e40
	ld (0e50bh),a		;9e41
	ld hl,0e68ah		;9e44   ; ...desde la puerta (su y + 8, guardada en 0xE0D0)...
	ld a,(hl)			;9e47
	add a,008h		;9e48
	ld (0e0d0h),a		;9e4a
	inc hl			;9e4d   ; ...y su x + 0x10 (0xE0D1)
	ld a,(hl)			;9e4e
	add a,010h		;9e4f
	ld (0e507h),a		;9e51   ; guarda la x del personaje
	ld (0e0d1h),a		;9e54
	ld a,00eh		;9e57   ; la pose 0x0E (de espaldas)...
L_9E59:
	ld (0e502h),a		;9e59   ; ...la musica 0x82...
	ld a,082h		;9e5c
	call 04e1fh		;9e5e   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld hl,01f80h		;9e61   ; ...y los sprites de la puerta (0x9E6A a 0x1F80)
	ld de,09e6ah		;9e64
	jp 05c46h		;9e67   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL

; ----------------------------------------------------------------------
; DATOS rle_9E6A: rle a la VRAM (0x5C46); lo leen p02:9E67 (5 bytes)
;   0x9e6a..0x9e6f  (5 bytes)
DATA_rle_9E6A:
	defb 040h,0ffh,040h,0ffh,000h	; 9e6a

; ======================================================================
; CODIGO 0x9e6f..0x9eff  (144 bytes)
; ======================================================================


sube_por_la_puerta:		; cada cuadro el personaje entra en la puerta del mundo
	ld hl,(0e504h)		;9e6f   ; cada cuadro sube 0x40...
	ld de,00040h		;9e72
	or a			;9e75
	sbc hl,de		;9e76
	ld (0e504h),hl		;9e78
	ld hl,0e50bh		;9e7b
	inc (hl)			;9e7e
	ld b,00eh		;9e7f   ; ...con la pose 0x0E (p03:A5F4)...
	call 0a5f4h		;9e81
	ld hl,0e50fh		;9e84   ; ...hasta que acaba la cuenta
	dec (hl)			;9e87
	jr nz,L_9EC0		;9e88
fin_del_paso:		; 0xE608 a 0
	xor a			;9e8a   ; se acabo el paso de varios cuadros
	ld (0e608h),a		;9e8b   ; guarda un paso de varios cuadros en marcha
	ret			;9e8e
sale_de_sala_especial:		; al salir de la sala especial, pose 0x10
	xor a			;9e8f   ; al salir de la sala especial: pose 0x10...
	ld (0e50bh),a		;9e90
	ld a,010h		;9e93
	jr $-60		;9e95
baja_hasta_el_suelo:		; cada cuadro baja hasta pisar suelo
	ld hl,(0e504h)		;9e97   ; ...baja 0x40 cada cuadro...
	ld de,00040h		;9e9a
	add hl,de			;9e9d
	ld (0e504h),hl		;9e9e
	ld hl,0e50bh		;9ea1
	inc (hl)			;9ea4
	ld b,010h		;9ea5
	call 0a5f4h		;9ea7
	call 0afb5h		;9eaa   ; ...hasta pisar suelo (p03:AFB5)...
	jr nc,L_9EC0		;9ead
	ld a,(0e505h)		;9eaf   ; ...y queda en pie
	and 0f8h		;9eb2
	ld (0e505h),a		;9eb4   ; guarda la y del personaje
	xor a			;9eb7
	ld (0e500h),a		;9eb8   ; guarda el estado del personaje (5 = hundirse)
	ld (0e50eh),a		;9ebb
	jr fin_del_paso		;9ebe
L_9EC0:
	exx			;9ec0   ; los sprites de la puerta del mundo...
	ld hl,(0e68ah)		;9ec1   ; lee la y, x de la puerta del mundo y el byte siguiente (16 bits)
	exx			;9ec4
	jr L_9ED5		;9ec5
sprites_puerta_de_vuelta:		; los 8 sprites de la puerta de vuelta
	exx			;9ec7   ; ...o de la de vuelta
	ld a,(0e682h)		;9ec8
	add a,028h		;9ecb
	ld l,a			;9ecd
	ld a,(0e683h)		;9ece
	sub 008h		;9ed1
	ld h,a			;9ed3
	exx			;9ed4
L_9ED5:
	ld hl,0ec80h		;9ed5   ; 8 sprites de la tabla 0x9EFD alrededor de la puerta, dibujo 0xF0 color 0...
	ld b,008h		;9ed8
L_9EDA:
	push hl			;9eda
	ld a,b			;9edb
	ld hl,09efdh		;9edc
	call 0414ch		;9edf   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	exx			;9ee2
	ld a,l			;9ee3
	exx			;9ee4
	add a,e			;9ee5
	ld e,a			;9ee6
	exx			;9ee7
	ld a,h			;9ee8
	exx			;9ee9
	add a,d			;9eea
	ld d,a			;9eeb
	pop hl			;9eec
	ld (hl),e			;9eed
	inc l			;9eee
	ld (hl),d			;9eef
	inc l			;9ef0
	ld (hl),0f0h		;9ef1
	inc l			;9ef3
	ld (hl),000h		;9ef4
	inc l			;9ef6
	djnz L_9EDA		;9ef7
	ld (0e60ah),hl		;9ef9   ; ...y el personaje detras
	jp 073e4h		;9efc   ; pose_del_personaje: la pose 0xE502 (0xE53D en la pausa) de la tabla 0x7529

; ----------------------------------------------------------------------
; DATOS ocho_direcciones: 8 parejas [dX][dY] (0xE8, 0, 0x10, 0xF8...), una por
;   cada uno de los 8 sprites, que p02:9EDC lee en 0x9EFD + 2 x B (B = 8..1)
;   0x9eff..0x9f0f  (16 bytes)
DATA_ocho_direcciones:
	defb 0e8h,000h	; 9eff
	defb 0e8h,000h	; 9f01
	defb 0e8h,010h	; 9f03
	defb 0e8h,010h	; 9f05
	defb 0f8h,000h	; 9f07
	defb 0f8h,000h	; 9f09
	defb 0f8h,010h	; 9f0b
	defb 0f8h,010h	; 9f0d

; ======================================================================
; CODIGO 0x9f0f..0xa000  (241 bytes)
; ======================================================================


entra_en_la_vuelta:		; al entrar en la puerta de vuelta
	ld a,(0e505h)		;9f0f   ; al salir por la puerta de vuelta: su sitio guardado...
	add a,010h		;9f12
	ld (0e0d0h),a		;9f14
	ld hl,0e683h		;9f17
	ld a,(hl)			;9f1a
	add a,008h		;9f1b
	ld (0e507h),a		;9f1d   ; guarda la x del personaje
	ld (0e0d1h),a		;9f20
	ld b,00eh		;9f23   ; ...la pose 0x0E y 0x40 cuadros
L_9F25:
	ld a,040h		;9f25
	ld (0e50fh),a		;9f27
	ld a,b			;9f2a
	jp L_9E59		;9f2b
baja_por_la_vuelta:		; cada cuadro entra en la puerta de vuelta
	ld hl,(0e504h)		;9f2e   ; cada cuadro baja 0x40 (entrando en la puerta)
	ld de,00040h		;9f31
	add hl,de			;9f34
L_9F35:
	ld (0e504h),hl		;9f35
	ld hl,0e50fh		;9f38
	dec (hl)			;9f3b
	jp nz,sprites_puerta_de_vuelta		;9f3c   ; sprites_puerta_de_vuelta: los 8 sprites de la puerta de vuelta
	jp fin_del_paso		;9f3f   ; fin_del_paso: 0xE608 a 0
sale_de_la_vuelta:		; al volver al castillo, delante de la puerta guardada
	ld a,(0e0d0h)		;9f42   ; al volver: delante de la puerta guardada (0xE0D0, 0xE0D1), pose 0x10
	ld c,000h		;9f45
	ld b,a			;9f47
	ld (0e504h),bc		;9f48
	ld a,(0e0d1h)		;9f4c
	ld (0e507h),a		;9f4f   ; guarda la x del personaje
	ld b,010h		;9f52
	jr L_9F25		;9f54
sube_de_la_vuelta:		; cada cuadro sale de la puerta
	ld hl,(0e504h)		;9f56   ; cada cuadro sube 0x40 (saliendo de la puerta)
	ld de,00040h		;9f59
	or a			;9f5c
	sbc hl,de		;9f5d
	jr L_9F35		;9f5f
empiezan_destellos:		; 0x3C cuadros de destellos del fondo
	ld hl,03c01h		;9f61   ; 0x3C cuadros de destellos (0xE64C)
	ld (0e64ch),hl		;9f64
	ret			;9f67
destellos:		; el color de fondo parpadea
	ld hl,0e64dh		;9f68   ; el color de fondo parpadea: negro o gris...
	dec (hl)			;9f6b
	jr z,L_9F79		;9f6c
	bit 1,(hl)		;9f6e
	ld b,001h		;9f70
	jr z,L_9F76		;9f72
	ld b,00eh		;9f74
L_9F76:
	jp 04c63h		;9f76   ; color_de_fondo: el registro 7 del VDP = B
L_9F79:
	xor a			;9f79   ; ...y al acabar, negro
	ld (0e64ch),a		;9f7a
	ld b,001h		;9f7d
	jp 04c63h		;9f7f   ; color_de_fondo: el registro 7 del VDP = B
objetos_escondidos:		; los objetos escondidos del castillo (salas 0x30, 0x4B, 0x28, 0x18 y 0x2B)
	ld a,(0e539h)		;9f82   ; los objetos escondidos del castillo: uno a la vez (0xE539)...
	and a			;9f85
	ret nz			;9f86
	ld hl,(0e041h)		;9f87   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	dec l			;9f8a
	ret nz			;9f8b
	ld a,h			;9f8c   ; ...en la sala 0x30 el 0x13, en la 0x4B el 0x16, en la 0x28 el 0x1B, en la 0x18 el 0x25 y en la 0x2B el 0x26
	cp 030h		;9f8d
	jp z,L_9FA7		;9f8f
	cp 04bh		;9f92
	jp z,L_9FB4		;9f94
	cp 028h		;9f97
	jp z,L_9FC1		;9f99
	cp 018h		;9f9c
	jp z,0a003h		;9f9e
	cp 02bh		;9fa1
	jp z,0a01ah		;9fa3
	ret			;9fa6
L_9FA7:
	ld a,(0e082h)		;9fa7   ; el 0x13 sale en (0x28, 0x50) con 0xE61C
	and a			;9faa
	ret nz			;9fab
	ld c,013h		;9fac
	ld de,02850h		;9fae
	jp 0a013h		;9fb1
L_9FB4:
	ld a,(0e085h)		;9fb4   ; el 0x16 sale en (0xA8, 0x20) con 0xE61C
	and a			;9fb7
	ret nz			;9fb8
	ld c,016h		;9fb9
	ld de,0a820h		;9fbb
	jp 0a013h		;9fbe
L_9FC1:
	ld a,(0e08ah)		;9fc1   ; el 0x1B: con el jefe del mapa 5 vencido...
	and a			;9fc4
	ret nz			;9fc5
	ld a,(0e066h)		;9fc6   ; lee las marcas del mapa 5 (bits 7-4: objetos 09 08 07 0A; bit 2: jefe vencido)
	bit 2,a		;9fc9
	ret z			;9fcb
	ld a,(0e536h)		;9fcc   ; ...y nueve pasos de 0xE536 sale en (0x88, 0x80)
	cp 009h		;9fcf
	ld c,01bh		;9fd1
	ld de,08880h		;9fd3
	jp z,0a049h		;9fd6
	cp 006h		;9fd9
	jr nc,L_9FF4		;9fdb
	ld b,a			;9fdd
	ld a,(0e538h)		;9fde
	and a			;9fe1
	ret z			;9fe2
	ld a,b			;9fe3
	cp 003h		;9fe4
	ccf			;9fe6
	ld a,(0e503h)		;9fe7
	jr c,L_9FEF		;9fea
	and a			;9fec
	jr L_9FF0		;9fed
L_9FEF:
	dec a			;9fef
L_9FF0:
	jr nz,$+84		;9ff0
	jr $+77		;9ff2
L_9FF4:
	ld a,(0e538h)		;9ff4   ; con 0xE538, a cero...
	and a			;9ff7
	jp nz,0a044h		;9ff8
	ld a,(0e537h)		;9ffb   ; ...sin 0xE537, nada
	and a			;9ffe
	ret z			;9fff
