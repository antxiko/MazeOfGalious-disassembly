; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 05 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Etiquetas que no caen en ninguna posicion emitida del listado
; (destinos fuera del binario o dentro de una instruccion).
; ----------------------------------------------------------------------
L_91C5:	equ 0x091c5

; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l88f5h:	equ 0x088f5

; ----------------------------------------------------------------------
; DATOS partida_7FFF_cola: la instruccion de p04:7FFF (DD | 35 18) empieza al
;   final del banco 4 y acaba al principio del 5, que el cartucho pone siempre
;   a continuacion: aqui el resto; lo leen p04:7FFF (2 bytes)
;   0x8000..0x8002  (2 bytes)
DATA_partida_7FFF_cola:
	defb 035h,018h	; 8000

; ======================================================================
; CODIGO 0x8002..0x80bc  (186 bytes)
; ======================================================================


L_8002:
	jp 07f5fh		;8002
L_8005:
	ld de,0fc00h		;8005
	call 0b137h		;8008   ; velocidad_vertical: la velocidad vertical = DE
	ld de,00000h		;800b
	jr $-69		;800e
L_8010:
	ld a,(ix+005h)		;8010   ; lee la y de la figura
	cp 090h		;8013
	ret c			;8015
L_8016:
	call crea_6a_bajo		;8016   ; crea_6a_bajo: crea dos figuras 0x6A en y 0x90, x + 4
	jp 0b41ch		;8019   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
crea_6a_bajo:		; crea dos figuras 0x6A en y 0x90, x + 4
	ld a,(ix+007h)		;801c   ; lee la x de la figura
	add a,004h		;801f
	ld e,a			;8021
	ld d,090h		;8022
	ld b,002h		;8024
	jp 078bah		;8026
L_8029:
	bit 0,(ix+014h)		;8029
	ld b,0c4h		;802d
	ld d,0c8h		;802f
	jr z,L_8037		;8031
	ld b,0d8h		;8033
	ld d,0d4h		;8035
L_8037:
	call dibujo_cada_8		;8037   ; dibujo_cada_8: el dibujo B cambiando cada 8 cuadros
	ld (ix+00ah),a		;803a   ; guarda el dibujo (o el mosaico) de la figura
	ld b,d			;803d
	call dibujo_cada_8		;803e   ; dibujo_cada_8: el dibujo B cambiando cada 8 cuadros
	ld (ix+012h),a		;8041
	ret			;8044
dibujo_cada_8:		; A = B + 8 cada 8 cuadros
	ld a,(0e604h)		;8045   ; lee el contador de cuadros de partida
	and 008h		;8048
	add a,b			;804a
	ret			;804b
casilla_delante_abajo:		; HL = la casilla de delante, a los pies
	ld a,(ix+005h)		;804c   ; lee la y de la figura
	add a,010h		;804f
	ld l,a			;8051
	ld a,(ix+000h)		;8052   ; lee el tipo de la figura
	cp 030h		;8055
	jr z,L_805F		;8057
	bit 7,(ix+00fh)		;8059   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr L_8063		;805d
L_805F:
	bit 0,(ix+014h)		;805f
L_8063:
	ld a,020h		;8063
	jr z,L_8068		;8065
	xor a			;8067
L_8068:
	add a,(ix+007h)		;8068   ; le suma la x de la figura
	ld h,a			;806b
	jp 0406eh		;806c   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
pared_o_borde:		; C con pared encima de HL o en el borde
	ld bc,0ffdfh		;806f
	add hl,bc			;8072
	ld a,0b9h		;8073
	cp (hl)			;8075
	ret c			;8076
	ld a,(ix+007h)		;8077   ; lee la x de la figura
	bit 7,(ix+00fh)		;807a   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_8083		;807e
	cp 010h		;8080
	ret			;8082
L_8083:
	cp 0e0h		;8083
	ccf			;8085
	ret			;8086
L_8087:
	ld (ix+01fh),000h		;8087
	ld a,(ix+005h)		;808b   ; lee la y de la figura
	add a,010h		;808e
	ld l,a			;8090
	ld b,005h		;8091
	ld h,(ix+007h)		;8093   ; lee la x de la figura
	call 04056h		;8096   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
L_8099:
	ld a,0b9h		;8099
	cp (hl)			;809b
	jr nc,L_80A2		;809c
	ld (ix+01fh),001h		;809e
L_80A2:
	ld de,0ffe0h		;80a2
	add hl,de			;80a5
	ld a,0b9h		;80a6
	cp (hl)			;80a8
	ret c			;80a9
	ld de,00021h		;80aa
	add hl,de			;80ad
	djnz L_8099		;80ae
	ld a,(ix+01fh)		;80b0
	and a			;80b3
	ret nz			;80b4
	scf			;80b5
	ret			;80b6
L_80B7:
	ld (ix+01eh),000h		;80b7
	ret			;80bb

; ----------------------------------------------------------------------
; DATOS cuatro_alturas: 4 alturas (0x24, 0x44, 0x64, 0x84) que p04:7F84
;   compara con (ix+5) segun (ix+0x1C)
;   0x80bc..0x80c0  (4 bytes)
DATA_cuatro_alturas:
	defb 024h,044h,064h,084h	; 80bc

; ======================================================================
; CODIGO 0x80c0..0x8141  (129 bytes)
; ======================================================================


tipo_22_entra:		; al entrar el tipo 0x22
	ld (ix+008h),040h		;80c0   ; El tipo 0x22: al entrar
	ld (ix+015h),004h		;80c4   ; las columnas de la figura que se pintan = 0x04
	ret			;80c8
tipo_22_cuadro:		; cada cuadro el tipo 0x22
	ld de,00c40h		;80c9   ; El tipo 0x22: cada cuadro
	ld b,000h		;80cc
	call 0b0d6h		;80ce   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
	ld a,(ix+00ah)		;80d1   ; lee el dibujo (o el mosaico) de la figura
	jr nz,L_80DD		;80d4
	cp 0c8h		;80d6
	ld a,00fh		;80d8
	call z,04059h		;80da   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_80DD:
	dec (ix+015h)		;80dd   ; baja las columnas de la figura que se pintan
	jp nz,por_el_paso		;80e0   ; por_el_paso: por el paso de la figura
	ld (ix+015h),004h		;80e3   ; las columnas de la figura que se pintan = 0x04
	ld a,(ix+00ah)		;80e7   ; lee el dibujo (o el mosaico) de la figura
	and 008h		;80ea
	ret z			;80ec
	ld d,(ix+005h)		;80ed   ; lee la y de la figura
	ld a,(ix+007h)		;80f0   ; lee la x de la figura
	add a,008h		;80f3
	ld e,a			;80f5
	ld a,04ah		;80f6
	jp 06551h		;80f8   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
tipo_4a_entra:		; al entrar el tipo 0x4A
	call 06c42h		;80fb   ; El tipo 0x4A: al entrar
	ld de,0fc00h		;80fe
	call 0b137h		;8101   ; velocidad_vertical: la velocidad vertical = DE
	call azar_5		;8104   ; azar_5: A = R con el contador de cuadros
	and 003h		;8107
	ld hl,08141h		;8109
	call 04062h		;810c   ; hl_mas_a (por 0x4062): HL += A
	ld d,(hl)			;810f
	ld e,000h		;8110
	call azar_5		;8112   ; azar_5: A = R con el contador de cuadros
	and 001h		;8115
	jr z,L_811D		;8117
	ld a,d			;8119
	neg		;811a
	ld d,a			;811c
L_811D:
	call 0b13eh		;811d   ; velocidad_de_lado: la velocidad de lado = DE
	call azar_5		;8120   ; azar_5: A = R con el contador de cuadros
	and 003h		;8123
	rra			;8125
	rra			;8126
	rra			;8127
	rra			;8128
	and 00fh		;8129
	add a,040h		;812b
	ld (ix+014h),a		;812d
	ret			;8130
tipo_4a_cuadro:		; cada cuadro el tipo 0x4A
	ld a,(ix+00ch)		;8131   ; El tipo 0x4A: cada cuadro
	ld d,(ix+00dh)		;8134   ; lee la velocidad vertical de la figura (alta)
	add a,(ix+014h)		;8137
	ld e,a			;813a
	jr nc,L_813E		;813b
	inc d			;813d
L_813E:
	jp 0b137h		;813e   ; velocidad_vertical: la velocidad vertical = DE

; ----------------------------------------------------------------------
; DATOS cuatro_velocidades: 4 bytes que p05:8109 elige al azar (p05:81F1, dos
;   bits) y usa como parte alta de una velocidad
;   0x8141..0x8145  (4 bytes)
DATA_cuatro_velocidades:
	defb 000h,002h,004h,003h	; 8141

; ======================================================================
; CODIGO 0x8145..0x819e  (89 bytes)
; ======================================================================


por_el_paso:		; por el paso de la figura
	ld a,(ix+001h)		;8145   ; lee el paso de la figura
	dec a			;8148
	jr z,L_816A		;8149
	dec a			;814b
	jr z,L_8175		;814c
	dec a			;814e
	jr z,L_8197		;814f
	ld b,001h		;8151
	call azar_5		;8153   ; azar_5: A = R con el contador de cuadros
	and 00fh		;8156
	call 07e25h		;8158
L_815B:
	call azar_5		;815b   ; azar_5: A = R con el contador de cuadros
	and 01fh		;815e
	cp 003h		;8160
	jr c,L_815B		;8162
	ld (ix+017h),a		;8164
	jp paso_siguiente_de_figura		;8167   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_816A:
	call en_el_recuadro		;816a   ; en_el_recuadro: C si la figura esta dentro de su recuadro de la sala
	dec (ix+017h)		;816d
	ret nz			;8170
	dec (ix+001h)		;8171   ; baja el paso de la figura
	ret			;8174
L_8175:
	inc (ix+001h)		;8175   ; sube el paso de la figura
	ld (ix+017h),018h		;8178
	ld a,(ix+016h)		;817c
	ld hl,0819eh		;817f
	call 04053h		;8182   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
L_8185:
	call azar_5		;8185   ; azar_5: A = R con el contador de cuadros
	and 003h		;8188
	cp 003h		;818a
	jr z,L_8185		;818c
	call 04065h		;818e   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;8191
	ld b,001h		;8192
	jp 07e25h		;8194
L_8197:
	dec (ix+017h)		;8197
	ret nz			;819a
	jp 07db8h		;819b

; ----------------------------------------------------------------------
; DATOS tabla_819e: 4 punteros que p05:817F elige con (ix+0x16) a las ternas
;   de 0x81A6
;   0x819e..0x81a6  (8 bytes)
DATA_tabla_819e:
	defb 0a6h,081h	; 819e
	defb 0a9h,081h	; 81a0
	defb 0ach,081h	; 81a2
	defb 0afh,081h	; 81a4

; ----------------------------------------------------------------------
; DATOS ternas_81a6: 4 ternas de bytes (p05:8185 elige una de las tres al
;   azar)
;   0x81a6..0x81b2  (12 bytes)
DATA_ternas_81a6:
	defb 00dh,00eh,00fh	; 81a6
	defb 009h,00ah,00bh	; 81a9
	defb 003h,002h,001h	; 81ac
	defb 005h,006h,007h	; 81af

; ======================================================================
; CODIGO 0x81b2..0x82e4  (306 bytes)
; ======================================================================


en_el_recuadro:		; C si la figura esta dentro de su recuadro de la sala
	ld bc,02838h		;81b2
	ld de,05071h		;81b5
	bit 2,(ix+009h)		;81b8   ; mira el bit 2 de la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	jr z,L_81C4		;81bc
	ld bc,03848h		;81be
	ld de,06081h		;81c1
L_81C4:
	ld a,(ix+007h)		;81c4   ; lee la x de la figura
	add a,b			;81c7
	cp c			;81c8
	jr c,L_81D1		;81c9
	ld a,(ix+005h)		;81cb   ; lee la y de la figura
	add a,d			;81ce
	cp e			;81cf
	ret nc			;81d0
L_81D1:
	ld (ix+016h),000h		;81d1
	ld a,(ix+005h)		;81d5   ; lee la y de la figura
	cp 070h		;81d8
	jr c,L_81E0		;81da
	ld (ix+016h),002h		;81dc
L_81E0:
	ld a,(ix+007h)		;81e0   ; lee la x de la figura
	cp 080h		;81e3
	jr c,L_81EA		;81e5
	inc (ix+016h)		;81e7
L_81EA:
	ld (ix+017h),002h		;81ea
	jp paso_siguiente_de_figura		;81ee   ; paso_siguiente_de_figura: sube el paso (ix+1)
azar_5:		; A = R con el contador de cuadros
	ld a,r		;81f1
	rrca			;81f3
	rrca			;81f4
	rrca			;81f5
	ld hl,0e003h		;81f6   ; apunta a el contador de cuadros
	xor (hl)			;81f9
	ret			;81fa
hacia_el_personaje_5:		; las velocidades hacia el personaje (0x80)
	ld a,080h		;81fb
hacia_el_personaje_5a:		; las velocidades hacia el personaje (A)
	ld e,(ix+005h)		;81fd   ; lee la y de la figura
	ld d,(ix+007h)		;8200   ; lee la x de la figura
	ld c,a			;8203
	ld a,(0e045h)		;8204   ; lee la velocidad de las figuras que apuntan (y los generadores)
	add a,a			;8207
	add a,a			;8208
	add a,a			;8209
	add a,c			;820a
	ld (0e609h),a		;820b
	ld a,h			;820e
	ld (0f000h),a		;820f
	ld a,l			;8212
	ld (0f001h),a		;8213
	call 0b233h		;8216
	jp 0b1a3h		;8219   ; velocidades_del_angulo: las velocidades del angulo de 0xF017
L_821C:
	ld h,(ix+00dh)		;821c   ; lee la velocidad vertical de la figura (alta)
	ld l,(ix+00ch)		;821f   ; lee la velocidad vertical de la figura
	add hl,de			;8222
	ld (ix+00dh),h		;8223   ; guarda la velocidad vertical de la figura (alta)
	ld (ix+00ch),l		;8226   ; guarda la velocidad vertical de la figura
	ret			;8229
tipo_4e_entra:		; al entrar el tipo 0x4E
	ld (ix+01ah),002h		;822a   ; El tipo 0x4E: al entrar
	ld a,(ix+002h)		;822e   ; lee las banderas de la figura (bit 7: en pantalla)
	and 09fh		;8231
	ld (ix+002h),a		;8233   ; guarda las banderas de la figura (bit 7: en pantalla)
	ld (ix+00ah),0a0h		;8236   ; el dibujo (o el mosaico) de la figura = 0xA0
	ld (ix+018h),070h		;823a
	call azar_5		;823e   ; azar_5: A = R con el contador de cuadros
	and 00fh		;8241
	ld (ix+019h),a		;8243
	ret			;8246
tipo_4e_cuadro:		; cada cuadro el tipo 0x4E
	call crece		;8247   ; El tipo 0x4E: cada cuadro
	ld a,(ix+001h)		;824a   ; lee el paso de la figura
	cp 004h		;824d
	jr nc,L_82A1		;824f
	ld de,03058h		;8251
	ld a,(0e042h)		;8254   ; lee la sala
	cp 06eh		;8257
	jr z,L_8264		;8259
	ld de,09058h		;825b
	cp 019h		;825e
	jr z,L_8264		;8260
	ld e,078h		;8262
L_8264:
	ld a,(0e507h)		;8264   ; lee la x del personaje
	add a,d			;8267
	cp 0f0h		;8268
	jr c,L_829A		;826a
	ld a,(0e505h)		;826c   ; lee la y del personaje
	cp e			;826f
	jr nz,L_829A		;8270
	dec (ix+018h)		;8272
	jp nz,por_el_paso		;8275   ; por_el_paso: por el paso de la figura
	ld a,(0e63dh)		;8278
	and a			;827b
	jr nz,L_828D		;827c
	ld a,083h		;827e
	call 04059h		;8280   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,088h		;8283
	call 04086h		;8285   ; musica_espera (por 0x4086): deja esperando la musica A
	ld a,001h		;8288
	ld (0e63dh),a		;828a
L_828D:
	ld (ix+001h),004h		;828d   ; el paso de la figura = 0x04
	ld hl,07080h		;8291
	call hacia_el_personaje_5		;8294   ; hacia_el_personaje_5: las velocidades hacia el personaje (0x80)
	jp 0b133h		;8297   ; velocidades: la de lado = DE y la vertical = HL
L_829A:
	ld (ix+018h),070h		;829a
	jp por_el_paso		;829e   ; por_el_paso: por el paso de la figura
L_82A1:
	ld a,(ix+005h)		;82a1   ; lee la y de la figura
	cp 066h		;82a4
	ret c			;82a6
	cp 07ah		;82a7
	ret nc			;82a9
	ld a,(ix+007h)		;82aa   ; lee la x de la figura
	cp 076h		;82ad
	ret c			;82af
	cp 08ah		;82b0
	ret nc			;82b2
	call 0b41ch		;82b3   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	ld a,(0e620h)		;82b6   ; lee cuantas figuras hay
	and a			;82b9
	ret nz			;82ba
	ld de,07080h		;82bb
	ld a,04fh		;82be
	jp 06551h		;82c0   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
crece:		; cada 2 cuadros el ancho siguiente de la tabla 0x82E4
	dec (ix+01ah)		;82c3
	ret nz			;82c6
	ld (ix+01ah),002h		;82c7
	ld a,(ix+019h)		;82cb
	ld hl,082e4h		;82ce
	call 04083h		;82d1   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+00bh),a		;82d4   ; guarda el ancho del mosaico
	inc (ix+019h)		;82d7
	ld a,015h		;82da
	sub (ix+019h)		;82dc
	ret nz			;82df
	ld (ix+019h),a		;82e0
	ret			;82e3

; ----------------------------------------------------------------------
; DATOS colores_82e4: 21 bytes que p05:82CE va poniendo en (ix+0x0B), el
;   color, uno cada dos cuadros con (ix+0x19)
;   0x82e4..0x82f9  (21 bytes)
DATA_colores_82e4:
	defb 006h,008h,009h,00fh,009h,008h,006h,004h,005h,007h,00fh,007h,005h,004h,00ch,002h	; 82e4  ................
	defb 003h,00fh,003h,002h,00ch	; 82f4

; ======================================================================
; CODIGO 0x82f9..0x83be  (197 bytes)
; ======================================================================


tipo_4f_entra:		; al entrar el tipo 0x4F
	ld (ix+009h),081h		;82f9   ; El tipo 0x4F: al entrar
	res 5,(ix+002h)		;82fd   ; pone a cero el bit 5 de las banderas de la figura (bit 7: en pantalla)
	res 6,(ix+002h)		;8301   ; pone a cero el bit 6 de las banderas de la figura (bit 7: en pantalla)
	ld (ix+019h),050h		;8305
	ld (ix+01ah),002h		;8309
	ld (ix+018h),000h		;830d
	jp 0b124h		;8311   ; solo_vertical: sin velocidad de lado y la vertical = DE
tipo_4f_cuadro:		; cada cuadro el tipo 0x4F
	ld a,(ix+018h)		;8314   ; El tipo 0x4F: cada cuadro
	dec a			;8317
	jr z,L_8354		;8318
	dec (ix+019h)		;831a
	jr z,L_8330		;831d
	dec (ix+01ah)		;831f
	ret nz			;8322
	ld (ix+01ah),002h		;8323
	ld a,(ix+00ah)		;8327   ; lee el dibujo (o el mosaico) de la figura
	xor 00ch		;832a
	ld (ix+00ah),a		;832c   ; guarda el dibujo (o el mosaico) de la figura
	ret			;832f
L_8330:
	ld (ix+011h),013h		;8330   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x13
	set 6,(ix+002h)		;8334   ; pone a uno el bit 6 de las banderas de la figura (bit 7: en pantalla)
	inc (ix+018h)		;8338
	ld (ix+009h),0c2h		;833b   ; la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A) = 0xC2
	ld (ix+00ah),000h		;833f   ; el dibujo (o el mosaico) de la figura = 0x00
	ld (ix+00bh),008h		;8343   ; el ancho del mosaico = 0x08
	ld (ix+01ah),004h		;8347
	ld (ix+01bh),080h		;834b
	ld a,089h		;834f
	jp 04080h		;8351   ; musica_ya (por 0x4080): sin musica esperando, la musica A
L_8354:
	ld a,(ix+01bh)		;8354
	xor (ix+00fh)		;8357   ; XOR con la velocidad de lado de la figura (alta)
	and 080h		;835a
	jr z,L_8378		;835c
	ld (ix+01ah),001h		;835e
	ld bc,00008h		;8362
	ld a,(ix+00fh)		;8365   ; lee la velocidad de lado de la figura (alta)
	ld (ix+01bh),a		;8368
	and 080h		;836b
	jr z,L_8372		;836d
	ld bc,00209h		;836f
L_8372:
	ld (ix+00ah),b		;8372   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+00bh),c		;8375   ; guarda el ancho del mosaico
L_8378:
	dec (ix+01ah)		;8378
	jp nz,por_el_paso		;837b   ; por_el_paso: por el paso de la figura
	ld (ix+01ah),002h		;837e
	ld a,(ix+00ah)		;8382   ; lee el dibujo (o el mosaico) de la figura
	xor 001h		;8385
	ld (ix+00ah),a		;8387   ; guarda el dibujo (o el mosaico) de la figura
	jp por_el_paso		;838a   ; por_el_paso: por el paso de la figura
tipo_42_entra:		; al entrar el tipo 0x42
	ld a,001h		;838d   ; El tipo 0x42: al entrar
	ld (0e603h),a		;838f
	call 0b124h		;8392   ; solo_vertical: sin velocidad de lado y la vertical = DE
	ld (ix+016h),0a0h		;8395
	xor a			;8399
	ld (0e628h),a		;839a
	call azar_5		;839d   ; azar_5: A = R con el contador de cuadros
	and 003h		;83a0
	ld hl,083beh		;83a2
	call 04083h		;83a5   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+007h),a		;83a8   ; guarda la x de la figura
	ld de,0ff80h		;83ab
	call 0b137h		;83ae   ; velocidad_vertical: la velocidad vertical = DE
	ld a,(ix+002h)		;83b1   ; lee las banderas de la figura (bit 7: en pantalla)
	and 00fh		;83b4
	ld (ix+002h),a		;83b6   ; guarda las banderas de la figura (bit 7: en pantalla)
L_83B9:
	ld (ix+014h),020h		;83b9
	ret			;83bd

; ----------------------------------------------------------------------
; DATOS cuatro_x: 4 posiciones X que p05:83A2 elige al azar para (ix+7)
;   0x83be..0x83c2  (4 bytes)
DATA_cuatro_x:
	defb 030h,060h,080h,090h	; 83be

; ======================================================================
; CODIGO 0x83c2..0x88fd  (1339 bytes)
; ======================================================================


tipo_42_cuadro:		; cada cuadro el tipo 0x42
	ld a,(ix+001h)		;83c2   ; El tipo 0x42: cada cuadro
	dec a			;83c5
	jr z,L_83E3		;83c6
	dec a			;83c8
	jr z,L_8418		;83c9
	dec a			;83cb
	jr z,L_8449		;83cc
	ld a,(0e511h)		;83ce   ; lee en el agua
	dec a			;83d1
	jr z,$-25		;83d2
	dec (ix+014h)		;83d4
	ret nz			;83d7
	ld a,(ix+002h)		;83d8   ; lee las banderas de la figura (bit 7: en pantalla)
	or 0f0h		;83db
	ld (ix+002h),a		;83dd   ; guarda las banderas de la figura (bit 7: en pantalla)
	jp paso_siguiente_de_figura		;83e0   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_83E3:
	ld a,(ix+005h)		;83e3   ; lee la y de la figura
	cp 094h		;83e6
	ret nz			;83e8
	ld (ix+014h),001h		;83e9
	xor a			;83ed
	ld (0e628h),a		;83ee
	call 0b124h		;83f1   ; solo_vertical: sin velocidad de lado y la vertical = DE
	inc (ix+001h)		;83f4   ; sube el paso de la figura
	ld b,008h		;83f7
	ld a,(0e507h)		;83f9   ; lee la x del personaje
	cp 030h		;83fc
	jr c,L_840C		;83fe
	cp 0c8h		;8400
	jr nc,L_840A		;8402
	ld a,r		;8404
	and 001h		;8406
	jr z,L_840C		;8408
L_840A:
	ld b,0f0h		;840a
L_840C:
	ld a,(0e507h)		;840c   ; lee la x del personaje
	add a,b			;840f
	ld e,a			;8410
	ld d,0a0h		;8411
	ld a,060h		;8413
	jp 06551h		;8415   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_8418:
	ld a,(0e628h)		;8418
	and a			;841b
	jr nz,L_8440		;841c
	ld a,(0e511h)		;841e   ; lee en el agua
	or a			;8421
	jr nz,L_8440		;8422
	ld a,(0e505h)		;8424   ; lee la y del personaje
	cp 094h		;8427
	ret nc			;8429
	dec (ix+014h)		;842a
	ret nz			;842d
	ld (ix+014h),020h		;842e
	ld d,(ix+005h)		;8432   ; lee la y de la figura
	ld a,(ix+007h)		;8435   ; lee la x de la figura
	add a,010h		;8438
	ld e,a			;843a
	ld a,061h		;843b
	jp 06551h		;843d   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_8440:
	ld de,00080h		;8440
	call 0b137h		;8443   ; velocidad_vertical: la velocidad vertical = DE
	jp paso_siguiente_de_figura		;8446   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_8449:
	ld a,(ix+005h)		;8449   ; lee la y de la figura
	sub 0a0h		;844c
	ret nz			;844e
	ld (ix+004h),a		;844f
	ld (ix+001h),a		;8452   ; guarda el paso de la figura
	jp tipo_42_entra		;8455   ; tipo_42_entra: al entrar el tipo 0x42
tipo_60_entra:		; al entrar el tipo 0x60
	ld a,(ix+009h)		;8458   ; El tipo 0x60: al entrar
	and 0fah		;845b
	ld (ix+009h),a		;845d   ; guarda la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	ld (ix+016h),0a0h		;8460
	ld (ix+015h),000h		;8464   ; las columnas de la figura que se pintan = 0x00
	ld a,017h		;8468
	call 04059h		;846a   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld hl,0fc00h		;846d
	ld de,00000h		;8470
	jp 0b133h		;8473   ; velocidades: la de lado = DE y la vertical = HL
tipo_60_cuadro:		; cada cuadro el tipo 0x60
	ld a,(ix+001h)		;8476   ; El tipo 0x60: cada cuadro
	dec a			;8479
	jr z,L_848C		;847a
	dec a			;847c
	jr z,L_84A8		;847d
	ld a,(ix+005h)		;847f   ; lee la y de la figura
	cp 090h		;8482
	ret nz			;8484
	ld (ix+009h),0c3h		;8485   ; la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A) = 0xC3
	jp paso_siguiente_de_figura		;8489   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_848C:
	ld a,(ix+005h)		;848c   ; lee la y de la figura
	and 00fh		;848f
	ret nz			;8491
	ld a,(ix+009h)		;8492   ; lee la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	and 007h		;8495
	xor 007h		;8497
	jr nz,L_84A4		;8499
	ld de,00400h		;849b
	call 0b137h		;849e   ; velocidad_vertical: la velocidad vertical = DE
	jp paso_siguiente_de_figura		;84a1   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_84A4:
	inc (ix+009h)		;84a4   ; sube la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	ret			;84a7
L_84A8:
	ld a,(ix+005h)		;84a8   ; lee la y de la figura
	sub 090h		;84ab
	jr nz,L_84B3		;84ad
	inc a			;84af
	ld (0e628h),a		;84b0
L_84B3:
	ld a,(ix+005h)		;84b3   ; lee la y de la figura
	and 00fh		;84b6
	ret nz			;84b8
	ld a,(ix+005h)		;84b9   ; lee la y de la figura
	cp 0a0h		;84bc
	jp z,0b41ch		;84be   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	dec (ix+009h)		;84c1   ; baja la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
tipo_61_cuadro:		; cada cuadro el tipo 0x61
	ret			;84c4   ; El tipo 0x61: cada cuadro
tipo_61_entra:		; al entrar el tipo 0x61
	call 06c42h		;84c5   ; El tipo 0x61: al entrar
	ld a,040h		;84c8
	call 0b18fh		;84ca   ; hacia_el_personaje: HL, DE = las velocidades hacia el personaje (A + 8 x 0xE045)
	call 0b133h		;84cd   ; velocidades: la de lado = DE y la vertical = HL
	ld a,00fh		;84d0
	jp 04059h		;84d2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
tipo_43_entra:		; al entrar el tipo 0x43
	ld a,001h		;84d5   ; El tipo 0x43: al entrar
	ld (0e603h),a		;84d7
	ld (ix+014h),a		;84da
	ld (ix+012h),0d8h		;84dd
	ld (ix+013h),003h		;84e1
	jp L_8623		;84e5
tipo_43_cuadro:		; cada cuadro el tipo 0x43
	ld a,(ix+001h)		;84e8   ; El tipo 0x43: cada cuadro
	dec a			;84eb
	jr z,L_8539		;84ec
	call anima_2_sprites		;84ee   ; anima_2_sprites: cuenta (ix+0x14) y cambia los dos dibujos (XOR 4)
	ld a,(0e507h)		;84f1   ; lee la x del personaje
	ld b,a			;84f4
	ld a,(ix+007h)		;84f5   ; lee la x de la figura
	cp b			;84f8
	jr nc,L_8500		;84f9
	add a,020h		;84fb
	cp b			;84fd
	jr nc,L_8525		;84fe
L_8500:
	ld a,(ix+007h)		;8500   ; lee la x de la figura
	add a,01ch		;8503
	cp 022h		;8505
	call c,0b15fh		;8507   ; vuelta_de_lado: la velocidad de lado al reves
	jp L_8630		;850a
anima_2_sprites:		; cuenta (ix+0x14) y cambia los dos dibujos (XOR 4)
	dec (ix+014h)		;850d
	ret nz			;8510
	inc (ix+014h)		;8511
	ld a,(ix+00ah)		;8514   ; lee el dibujo (o el mosaico) de la figura
	xor 004h		;8517
	ld (ix+00ah),a		;8519   ; guarda el dibujo (o el mosaico) de la figura
	ld a,(ix+012h)		;851c
	xor 004h		;851f
	ld (ix+012h),a		;8521
	ret			;8524
L_8525:
	inc (ix+001h)		;8525   ; sube el paso de la figura
	call 0b124h		;8528   ; solo_vertical: sin velocidad de lado y la vertical = DE
	ld d,(ix+005h)		;852b   ; lee la y de la figura
	ld a,(ix+007h)		;852e   ; lee la x de la figura
	add a,00eh		;8531
	ld e,a			;8533
	ld a,062h		;8534
	jp 06551h		;8536   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_8539:
	ld a,(0e620h)		;8539   ; lee cuantas figuras hay
	dec a			;853c
	ret nz			;853d
	ld (ix+001h),a		;853e   ; guarda el paso de la figura
	jp L_8623		;8541
tipo_62_entra:		; al entrar el tipo 0x62
	ld (ix+009h),081h		;8544   ; El tipo 0x62: al entrar
	res 4,(ix+002h)		;8548   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ld bc,0fcc4h		;854c
	ld hl,0fc00h		;854f
	ld d,000h		;8552
	ld a,(ix+005h)		;8554   ; lee la y de la figura
	cp 030h		;8557
	jr c,L_8567		;8559
	cp 0a0h		;855b
	jr nc,L_856E		;855d
	ld a,(0e505h)		;855f   ; lee la y del personaje
	cp (ix+005h)		;8562   ; compara con la y de la figura
	jr c,L_856E		;8565
L_8567:
	ld bc,00ccch		;8567
	inc d			;856a
	call 0405ch		;856b   ; hl_negado (por 0x405C): HL = -HL
L_856E:
	ld a,(ix+005h)		;856e   ; lee la y de la figura
	add a,b			;8571
	ld (ix+005h),a		;8572   ; guarda la y de la figura
	ld (ix+00ah),c		;8575   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+015h),d		;8578   ; guarda las columnas de la figura que se pintan
	ld de,00000h		;857b
	jp 0b133h		;857e   ; velocidades: la de lado = DE y la vertical = HL
tipo_62_cuadro:		; cada cuadro el tipo 0x62
	ld a,(ix+001h)		;8581   ; El tipo 0x62: cada cuadro
	dec a			;8584
	jr z,L_85B1		;8585
	dec a			;8587
	jr z,L_85FD		;8588
	dec a			;858a
	jp z,L_860B		;858b
	ld a,017h		;858e
	call 04059h		;8590   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	inc (ix+001h)		;8593   ; sube el paso de la figura
	ld (ix+018h),000h		;8596
	ld (ix+019h),000h		;859a
	ld (ix+009h),0c2h		;859e   ; la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A) = 0xC2
	ld (ix+00bh),00ch		;85a2   ; el ancho del mosaico = 0x0C
	ld a,(ix+005h)		;85a6   ; lee la y de la figura
	ld (ix+016h),a		;85a9
	set 4,(ix+002h)		;85ac   ; pone a uno el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ret			;85b0
L_85B1:
	ld a,(ix+015h)		;85b1   ; lee las columnas de la figura que se pintan
	dec a			;85b4
	ld a,(ix+005h)		;85b5   ; lee la y de la figura
	jr z,L_85C0		;85b8
	cp 020h		;85ba
	jr c,L_85DE		;85bc
	jr L_85C4		;85be
L_85C0:
	cp 0b0h		;85c0
	jr nc,L_85DE		;85c2
L_85C4:
	inc (ix+018h)		;85c4
	ld a,(ix+018h)		;85c7
	sub 004h		;85ca
	ret nz			;85cc
	ld (ix+018h),a		;85cd
	inc (ix+019h)		;85d0
	ld a,(ix+019h)		;85d3
	cp 005h		;85d6
	jr z,L_85F2		;85d8
	inc (ix+009h)		;85da   ; sube la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	ret			;85dd
L_85DE:
	inc (ix+019h)		;85de
	ld a,004h		;85e1
	inc (ix+018h)		;85e3
	ld b,(ix+018h)		;85e6
	sub b			;85e9
	ld (ix+018h),a		;85ea
	jr nz,L_85F2		;85ed
	inc (ix+019h)		;85ef
L_85F2:
	ld (ix+008h),010h		;85f2
	res 4,(ix+002h)		;85f6   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	jp paso_siguiente_de_figura		;85fa   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_85FD:
	dec (ix+008h)		;85fd
	ret nz			;8600
	inc (ix+001h)		;8601   ; sube el paso de la figura
	set 4,(ix+002h)		;8604   ; pone a uno el bit 4 de las banderas de la figura (bit 7: en pantalla)
	jp 0b16fh		;8608   ; vuelta_vertical: la velocidad vertical al reves
L_860B:
	inc (ix+018h)		;860b
	ld a,(ix+018h)		;860e
	sub 004h		;8611
	ret nz			;8613
	ld (ix+018h),a		;8614
	dec (ix+019h)		;8617
	jr z,L_8620		;861a
	dec (ix+009h)		;861c   ; baja la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	ret			;861f
L_8620:
	jp 0b41ch		;8620   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
L_8623:
	ld de,00200h		;8623
	call azar_5		;8626   ; azar_5: A = R con el contador de cuadros
	and 001h		;8629
	ld d,0feh		;862b
	call 0b13eh		;862d   ; velocidad_de_lado: la velocidad de lado = DE
L_8630:
	call casilla_delante_abajo		;8630   ; casilla_delante_abajo: HL = la casilla de delante, a los pies
	jp nc,0b15fh		;8633   ; vuelta_de_lado: la velocidad de lado al reves
	call pared_o_borde		;8636   ; pared_o_borde: C con pared encima de HL o en el borde
	jp c,0b15fh		;8639   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;863c
tipo_19_entra:		; al entrar el tipo 0x19
	ld (ix+019h),080h		;863d   ; El tipo 0x19: al entrar
	ld (ix+008h),004h		;8641
	ld (ix+01ch),050h		;8645
	ld a,(0e62fh)		;8649
	ld (ix+01bh),a		;864c
	or a			;864f
	jr nz,L_8660		;8650
	ld a,(0e62ch)		;8652
	inc a			;8655
	ld (0e62ch),a		;8656
	dec a			;8659
	srl a		;865a
	ld (ix+018h),a		;865c
	ret			;865f
L_8660:
	ld de,0c848h		;8660
	ld c,002h		;8663
	dec a			;8665
	jr z,L_866D		;8666
	ld de,0c046h		;8668
	sla c		;866b
L_866D:
	ld (ix+00ah),d		;866d   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+011h),e		;8670   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	ld (ix+010h),c		;8673   ; guarda la vida de la figura
	ld (ix+001h),006h		;8676   ; el paso de la figura = 0x06
	ld a,(0e624h)		;867a
	ld (ix+018h),a		;867d
	ret			;8680
tipo_37_entra:		; al entrar el tipo 0x37
	ld (ix+01bh),003h		;8681   ; El tipo 0x37: al entrar
	ld (ix+008h),004h		;8685
	ld (ix+01ch),030h		;8689
	jr L_86E8		;868d
tipos_19_y_mas_cuadro:		; cada cuadro los tipos 0x19, 0x37
	call anima_19		;868f   ; Los tipos 0x19, 0x37: cada cuadro
	ld a,(ix+001h)		;8692   ; lee el paso de la figura
	cp 004h		;8695
	jr nc,L_86CA		;8697
	bit 7,(ix+018h)		;8699
	jr nz,L_86A9		;869d
	dec (ix+019h)		;869f
	jr nz,L_86A9		;86a2
	ld (ix+001h),004h		;86a4   ; el paso de la figura = 0x04
	ret			;86a8
L_86A9:
	call por_el_paso		;86a9   ; por_el_paso: por el paso de la figura
	dec (ix+01ch)		;86ac
	ret nz			;86af
	ld (ix+01ch),040h		;86b0
	ld a,(0e62fh)		;86b4
	or a			;86b7
	ret z			;86b8
	ld a,(ix+005h)		;86b9   ; lee la y de la figura
	add a,010h		;86bc
	ld d,a			;86be
	ld a,(ix+007h)		;86bf   ; lee la x de la figura
	add a,010h		;86c2
	ld e,a			;86c4
	ld a,048h		;86c5
	jp 06551h		;86c7   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_86CA:
	ld a,(ix+001h)		;86ca   ; lee el paso de la figura
	sub 005h		;86cd
	jr z,L_86F1		;86cf
	dec a			;86d1
	jr z,L_872C		;86d2
	call cuenta_19		;86d4   ; cuenta_19: busca otra figura de tipo 0x19
	jr nc,L_86E8		;86d7
	call hacia_el_personaje_5		;86d9   ; hacia_el_personaje_5: las velocidades hacia el personaje (0x80)
	call 0b133h		;86dc   ; velocidades: la de lado = DE y la vertical = HL
	inc (ix+001h)		;86df   ; sube el paso de la figura
	ld a,001h		;86e2
	ld (0e62dh),a		;86e4
	ret			;86e7
L_86E8:
	ld (ix+001h),000h		;86e8   ; el paso de la figura = 0x00
	set 7,(ix+018h)		;86ec
	ret			;86f0
L_86F1:
	call cuenta_19		;86f1   ; cuenta_19: busca otra figura de tipo 0x19
	jr nc,L_86FE		;86f4
	ld a,(ix+01dh)		;86f6
	and a			;86f9
	ret z			;86fa
	jp 0b41ch		;86fb   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
L_86FE:
	ld a,(ix+01dh)		;86fe
	and a			;8701
	jr z,L_86E8		;8702
	ld a,00bh		;8704
	call 04059h		;8706   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call 0b124h		;8709   ; solo_vertical: sin velocidad de lado y la vertical = DE
	call 0b41ch		;870c   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	inc (ix+01bh)		;870f
	ld a,(ix+01bh)		;8712
	ld (0e62fh),a		;8715
	cp 003h		;8718
	ld a,037h		;871a
	jr z,L_8720		;871c
	ld a,019h		;871e
L_8720:
	ld b,(ix+018h)		;8720
	ld d,(ix+005h)		;8723   ; lee la y de la figura
	ld e,(ix+007h)		;8726   ; lee la x de la figura
	jp 065dah		;8729   ; crea_figura: crea la figura A en la y D, x E
L_872C:
	push ix		;872c
	call busca_19		;872e   ; busca_19: NZ si hay una figura de tipo 0x19
	pop ix		;8731
	ret c			;8733
	ld a,(ix+018h)		;8734
	srl a		;8737
	ld (ix+018h),a		;8739
	xor a			;873c
	ld (ix+001h),a		;873d
	ld (ix+01dh),a		;8740
	ld (0e62dh),a		;8743
	ret			;8746
busca_19:		; NZ si hay una figura de tipo 0x19
	ld b,010h		;8747
	ld ix,0e800h		;8749   ; apunta a los huecos de figura (32 bytes cada uno)
L_874D:
	ld a,(ix+000h)		;874d   ; lee el tipo de la figura
	cp 019h		;8750
	jr z,L_875D		;8752
L_8754:
	ld de,00020h		;8754
	add ix,de		;8757
	djnz L_874D		;8759
	xor a			;875b
	ret			;875c
L_875D:
	ld a,(ix+001h)		;875d   ; lee el paso de la figura
	cp 005h		;8760
	jr nz,L_8754		;8762
	scf			;8764
	ret			;8765
anima_19:		; anima segun (ix+0x1B)
	ld de,00404h		;8766
	ld b,001h		;8769
	ld a,(ix+01bh)		;876b
	cp 003h		;876e
	jp nz,0b0d6h		;8770   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
	ld de,00108h		;8773
	jp 0b0d6h		;8776   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
cuenta_19:		; busca otra figura de tipo 0x19
	push ix		;8779
	pop hl			;877b
	ld b,010h		;877c
	ld de,0e800h		;877e   ; apunta a los huecos de figura (32 bytes cada uno)
L_8781:
	ld a,(de)			;8781
	cp 019h		;8782
	jr z,L_878F		;8784
L_8786:
	ld a,020h		;8786
L_8788:
	call 04065h		;8788   ; de_mas_a (por 0x4065): DE += A
	djnz L_8781		;878b
	xor a			;878d
	ret			;878e
L_878F:
	ld a,h			;878f
	cp d			;8790
	jr nz,L_8797		;8791
	ld a,l			;8793
	cp e			;8794
	jr z,L_8786		;8795
L_8797:
	ld a,018h		;8797
	call 04065h		;8799   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;879c
	cp (ix+018h)		;879d
	jr nz,L_87B6		;87a0
	ld a,e			;87a2
	sub 018h		;87a3
	ld e,a			;87a5
	jr nc,L_87A9		;87a6
	dec d			;87a8
L_87A9:
	ex de,hl			;87a9
	ld a,005h		;87aa
	call 04062h		;87ac   ; hl_mas_a (por 0x4062): HL += A
	ld d,(hl)			;87af
	inc hl			;87b0
	inc hl			;87b1
	ld e,(hl)			;87b2
	ex de,hl			;87b3
	scf			;87b4
	ret			;87b5
L_87B6:
	ld a,008h		;87b6
	jr L_8788		;87b8
tipo_48_cuadro:		; cada cuadro el tipo 0x48
	ld a,(ix+001h)		;87ba   ; El tipo 0x48: cada cuadro
	dec a			;87bd
	jr z,L_87D2		;87be
	call azar_5		;87c0   ; azar_5: A = R con el contador de cuadros
	and 00fh		;87c3
	ld b,001h		;87c5
	call 07e25h		;87c7
	ld (ix+014h),010h		;87ca
	inc (ix+001h)		;87ce   ; sube el paso de la figura
	ret			;87d1
L_87D2:
	dec (ix+014h)		;87d2
	ret nz			;87d5
	dec (ix+001h)		;87d6   ; baja el paso de la figura
	ret			;87d9
tipo_2b_entra:		; al entrar el tipo 0x2B
	call 06bd5h		;87da   ; El tipo 0x2B: al entrar
	ld (ix+01ch),011h		;87dd
	ld (ix+01dh),000h		;87e1
	ld (ix+01fh),001h		;87e5
	ld (ix+00ah),0c4h		;87e9   ; el dibujo (o el mosaico) de la figura = 0xC4
	ld (ix+008h),0c4h		;87ed
	ld (ix+01eh),0c8h		;87f1
	ld hl,l88f5h		;87f5
	jp 06d7fh		;87f8   ; tipo_02_cola: el tipo 2: los 7 trozos de su cola
tipo_2b_cuadro:		; cada cuadro el tipo 0x2B
	call dibujo_cada_6		;87fb   ; El tipo 0x2B: cada cuadro
	call en_el_borde_paso		;87fe   ; en_el_borde_paso: C en el borde segun el paso
	call pared_14_15_paso		;8801   ; pared_14_15_paso: C con pared segun el paso y (ix+0x14, 0x15)
	ld a,000h		;8804
	jr c,L_8825		;8806
	bit 0,(ix+01bh)		;8808
	jr z,L_881A		;880c
	dec (ix+01ch)		;880e
	ret nz			;8811
	ld (ix+01bh),000h		;8812
	ld (ix+01ch),010h		;8816
L_881A:
	call pared_16_17_paso		;881a   ; pared_16_17_paso: C con pared segun el paso y (ix+0x16, 0x17)
	ld a,001h		;881d
	ret c			;881f
	bit 0,(ix+01dh)		;8820
	ret nz			;8824
L_8825:
	ld (ix+01dh),000h		;8825
	or a			;8829
	ld a,(ix+018h)		;882a
	jr z,L_8832		;882d
	ld a,(ix+019h)		;882f
L_8832:
	ld (ix+001h),a		;8832   ; guarda el paso de la figura
	ld hl,l88f5h		;8835
	call 06d7fh		;8838   ; tipo_02_cola: el tipo 2: los 7 trozos de su cola
	jp L_88CB		;883b
pared_14_15_paso:		; C con pared segun el paso y (ix+0x14, 0x15)
	call 06d3bh		;883e   ; pared_en_14_15: C si la casilla (x + (ix+0x14), y + (ix+0x15)) es pared
	ret c			;8841
	ld a,(ix+001h)		;8842   ; lee el paso de la figura
	cp 004h		;8845
	ld a,008h		;8847
	jr nc,L_8858		;8849
	call mas_7_impar		;884b   ; mas_7_impar: A + 7 en los pasos impares
	add a,(ix+015h)		;884e   ; le suma las columnas de la figura que se pintan
	ld c,a			;8851
	ld b,(ix+014h)		;8852
	jp 06d49h		;8855   ; pared_en_bc: C si la casilla (x + B, y + C) es pared
L_8858:
	call mas_7_impar		;8858   ; mas_7_impar: A + 7 en los pasos impares
	add a,(ix+014h)		;885b
	ld b,a			;885e
	ld c,(ix+015h)		;885f   ; lee las columnas de la figura que se pintan
	jp 06d49h		;8862   ; pared_en_bc: C si la casilla (x + B, y + C) es pared
pared_16_17_paso:		; C con pared segun el paso y (ix+0x16, 0x17)
	call 06d43h		;8865   ; pared_en_16_17: C si la casilla (x + (ix+0x16), y + (ix+0x17)) es pared
	ret c			;8868
	ld a,(ix+001h)		;8869   ; lee el paso de la figura
	cp 004h		;886c
	ld a,008h		;886e
	jr nc,L_887F		;8870
	call mas_7_impar		;8872   ; mas_7_impar: A + 7 en los pasos impares
	add a,(ix+016h)		;8875
	ld b,a			;8878
	ld c,(ix+017h)		;8879
	jp 06d49h		;887c   ; pared_en_bc: C si la casilla (x + B, y + C) es pared
L_887F:
	call mas_7_impar		;887f   ; mas_7_impar: A + 7 en los pasos impares
	add a,(ix+017h)		;8882
	ld c,a			;8885
	ld b,(ix+016h)		;8886
	jp 06d49h		;8889   ; pared_en_bc: C si la casilla (x + B, y + C) es pared
mas_7_impar:		; A + 7 en los pasos impares
	bit 0,(ix+001h)		;888c   ; mira el bit 0 de el paso de la figura
	ret z			;8890
	add a,007h		;8891
	ret			;8893
en_el_borde_paso:		; C en el borde segun el paso
	ld a,(ix+001h)		;8894   ; lee el paso de la figura
	cp 004h		;8897
	jr nc,L_88AC		;8899
	bit 0,a		;889b
	ld a,(ix+007h)		;889d   ; lee la x de la figura
	jr nz,L_88A7		;88a0
	cp 0f0h		;88a2
	ret c			;88a4
	jr L_88BB		;88a5
L_88A7:
	cp 008h		;88a7
	ret nc			;88a9
	jr L_88BB		;88aa
L_88AC:
	bit 0,a		;88ac
	ld a,(ix+005h)		;88ae   ; lee la y de la figura
	jr nz,L_88B8		;88b1
	cp 0a8h		;88b3
	ret c			;88b5
	jr L_88BB		;88b6
L_88B8:
	cp 020h		;88b8
	ret nc			;88ba
L_88BB:
	ld (ix+01dh),001h		;88bb
	ld a,(ix+018h)		;88bf
	ld (ix+001h),a		;88c2   ; guarda el paso de la figura
	ld hl,l88f5h		;88c5
	call 06d7fh		;88c8   ; tipo_02_cola: el tipo 2: los 7 trozos de su cola
L_88CB:
	ld a,(ix+00fh)		;88cb   ; lee la velocidad de lado de la figura (alta)
	or a			;88ce
	ret z			;88cf
	bit 7,a		;88d0
	ld (ix+008h),0c4h		;88d2
	ld (ix+01eh),0c8h		;88d6
	jr z,L_88EC		;88da
	ld (ix+008h),0cch		;88dc
	ld (ix+01eh),0d0h		;88e0
dibujo_cada_6:		; cada 6 cuadros el otro dibujo
	dec (ix+01fh)		;88e4
	ret nz			;88e7
	ld (ix+01fh),006h		;88e8
L_88EC:
	ld a,(ix+00ah)		;88ec   ; lee el dibujo (o el mosaico) de la figura
	cp (ix+008h)		;88ef
	ld a,(ix+01eh)		;88f2
L_88F5:
	jr z,L_88FA		;88f5
	ld a,(ix+008h)		;88f7
L_88FA:
	jp 07083h		;88fa

; ----------------------------------------------------------------------
; DATOS sin_nombrar_88fd: los mismos 56 bytes que p04:6DC6 (16 parejas de
;   pasos y tres ordenaciones de 0-7), otra vez sin que nada los nombre en los
;   bancos 4-6
;   0x88fd..0x8935  (56 bytes)
DATA_sin_nombrar_88fd:
	defb 010h,0ffh,010h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,010h,0ffh,010h,0ffh	; 88fd  ................
	defb 000h,000h,000h,000h,010h,010h,0ffh,0ffh,010h,010h,0ffh,0ffh,000h,000h,000h,000h	; 890d  ................
	defb 005h,007h,004h,006h,001h,003h,000h,002h,006h,004h,007h,005h,002h,000h,003h,001h	; 891d  ................
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh	; 892d  ........

; ======================================================================
; CODIGO 0x8935..0x8b45  (528 bytes)
; ======================================================================


tipo_27_entra:		; al entrar el tipo 0x27
	ld (ix+008h),004h		;8935   ; El tipo 0x27: al entrar
espera_0_f:		; (ix+0x1F) al azar 0-15
	call azar_5		;8939   ; azar_5: A = R con el contador de cuadros
	and 00fh		;893c
	ld (ix+01fh),a		;893e
	ret			;8941
tipo_27_cuadro:		; cada cuadro el tipo 0x27
	ld a,(0e003h)		;8942   ; El tipo 0x27: cada cuadro
	and 03fh		;8945
	jr nz,L_894E		;8947
	ld a,006h		;8949
	call 04059h		;894b   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_894E:
	ld a,0c4h		;894e
	cp (ix+00ah)		;8950   ; compara con el dibujo (o el mosaico) de la figura
	jr nz,L_8963		;8953
	ld a,(ix+01ch)		;8955
	rra			;8958
	jr nc,L_896B		;8959
	ld (ix+011h),000h		;895b   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x00
	ld (ix+00ah),0c8h		;895f   ; el dibujo (o el mosaico) de la figura = 0xC8
L_8963:
	ld de,00404h		;8963
	ld b,000h		;8966
	call 0b0d6h		;8968   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
L_896B:
	ld a,(ix+001h)		;896b   ; lee el paso de la figura
	cp 004h		;896e
	jr z,L_89D5		;8970
	cp 005h		;8972
	jp z,L_8A00		;8974
	dec (ix+01fh)		;8977
	jr nz,L_8987		;897a
	call espera_0_f		;897c   ; espera_0_f: (ix+0x1F) al azar 0-15
	ld a,(ix+01ah)		;897f
	xor 001h		;8982
	ld (ix+01ah),a		;8984
L_8987:
	ld a,(ix+01ah)		;8987
	and a			;898a
	jp nz,por_el_paso		;898b   ; por_el_paso: por el paso de la figura
	ld a,(0e505h)		;898e   ; lee la y del personaje
	ld b,a			;8991
	ld a,(ix+005h)		;8992   ; lee la y de la figura
	sub 030h		;8995
	cp b			;8997
	jp nc,por_el_paso		;8998   ; por_el_paso: por el paso de la figura
	add a,070h		;899b
	cp b			;899d
	jp c,por_el_paso		;899e   ; por_el_paso: por el paso de la figura
	ld a,(0e507h)		;89a1   ; lee la x del personaje
	ld b,a			;89a4
	ld a,(ix+007h)		;89a5   ; lee la x de la figura
	sub 038h		;89a8
	cp b			;89aa
	jp nc,por_el_paso		;89ab   ; por_el_paso: por el paso de la figura
	add a,070h		;89ae
	cp b			;89b0
	jp c,por_el_paso		;89b1   ; por_el_paso: por el paso de la figura
	ld a,(ix+005h)		;89b4   ; lee la y de la figura
	add a,058h		;89b7
	cp 088h		;89b9
	jp c,por_el_paso		;89bb   ; por_el_paso: por el paso de la figura
	ld a,(ix+005h)		;89be   ; lee la y de la figura
	ld (ix+019h),a		;89c1
	ld (ix+001h),004h		;89c4   ; el paso de la figura = 0x04
	ld (ix+01bh),020h		;89c8
	ld de,00000h		;89cc
	ld hl,00300h		;89cf
	jp 0b133h		;89d2   ; velocidades: la de lado = DE y la vertical = HL
L_89D5:
	dec (ix+01bh)		;89d5
	jr z,L_89E9		;89d8
	ld de,00080h		;89da
	ld a,(ix+019h)		;89dd
	cp (ix+005h)		;89e0   ; compara con la y de la figura
	call c,04068h		;89e3   ; de_negado (por 0x4068): DE = -DE
	jp L_821C		;89e6
L_89E9:
	inc (ix+001h)		;89e9   ; sube el paso de la figura
	ld a,(0e505h)		;89ec   ; lee la y del personaje
	ld (ix+01dh),a		;89ef
	ld h,a			;89f2
	ld a,(0e507h)		;89f3   ; lee la x del personaje
	ld (ix+01eh),a		;89f6
	ld l,a			;89f9
	call hacia_el_personaje_5		;89fa   ; hacia_el_personaje_5: las velocidades hacia el personaje (0x80)
	jp 0b133h		;89fd   ; velocidades: la de lado = DE y la vertical = HL
L_8A00:
	ld a,(ix+005h)		;8a00   ; lee la y de la figura
	add a,058h		;8a03
	cp 078h		;8a05
	jr c,L_8A30		;8a07
	ld a,(ix+007h)		;8a09   ; lee la x de la figura
	add a,010h		;8a0c
	cp 018h		;8a0e
	jr c,L_8A30		;8a10
	ld a,(ix+01dh)		;8a12
	sub 014h		;8a15
	cp (ix+005h)		;8a17   ; compara con la y de la figura
	ret nc			;8a1a
	add a,028h		;8a1b
	cp (ix+005h)		;8a1d   ; compara con la y de la figura
	ret c			;8a20
	ld a,(ix+01eh)		;8a21
	sub 014h		;8a24
	cp (ix+007h)		;8a26   ; compara con la x de la figura
	ret nc			;8a29
	add a,028h		;8a2a
	cp (ix+007h)		;8a2c   ; compara con la x de la figura
	ret c			;8a2f
L_8A30:
	ld (ix+001h),000h		;8a30   ; el paso de la figura = 0x00
	ld (ix+01ah),001h		;8a34
	ret			;8a38
tipo_36_entra:		; al entrar el tipo 0x36
	set 2,(ix+002h)		;8a39   ; El tipo 0x36: al entrar
	call azar_5		;8a3d   ; azar_5: A = R con el contador de cuadros
	and 003h		;8a40
	inc a			;8a42
	ld (ix+008h),a		;8a43
	ld a,(ix+005h)		;8a46   ; lee la y de la figura
	ld (ix+018h),a		;8a49
	ld a,(ix+007h)		;8a4c   ; lee la x de la figura
	ld (ix+019h),a		;8a4f
	ld de,00000h		;8a52
	ld hl,00200h		;8a55
	call 0b133h		;8a58   ; velocidades: la de lado = DE y la vertical = HL
	ld a,(0e633h)		;8a5b
	ld (ix+014h),a		;8a5e
	inc a			;8a61
	ld (0e633h),a		;8a62
	add a,002h		;8a65
	ld (ix+00bh),a		;8a67   ; guarda el ancho del mosaico
	cp 00ah		;8a6a
	jr nz,L_8A74		;8a6c
	call 0b124h		;8a6e   ; solo_vertical: sin velocidad de lado y la vertical = DE
	inc (ix+001h)		;8a71   ; sube el paso de la figura
L_8A74:
	ld a,008h		;8a74
	ld (0e634h),a		;8a76
	ret			;8a79
tipo_36_cuadro:		; cada cuadro el tipo 0x36
	ld de,00c04h		;8a7a   ; El tipo 0x36: cada cuadro
	ld b,003h		;8a7d
	call 0b0d6h		;8a7f   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
	ld a,(ix+001h)		;8a82   ; lee el paso de la figura
	dec a			;8a85
	jr z,L_8A9A		;8a86
	dec a			;8a88
	jr z,L_8AC7		;8a89
	ld de,00080h		;8a8b
	ld a,(ix+018h)		;8a8e
	cp (ix+005h)		;8a91   ; compara con la y de la figura
	call c,04068h		;8a94   ; de_negado (por 0x4068): DE = -DE
	jp L_821C		;8a97
L_8A9A:
	ld a,(0e634h)		;8a9a
	ld b,a			;8a9d
	call azar_5		;8a9e   ; azar_5: A = R con el contador de cuadros
	and 007h		;8aa1
	cp b			;8aa3
	jr z,L_8A9A		;8aa4
	ld (0e634h),a		;8aa6
	inc (ix+001h)		;8aa9   ; sube el paso de la figura
	push ix		;8aac
	call busca_36		;8aae   ; busca_36: busca una figura de tipo 0x36
	ld h,(ix+018h)		;8ab1
	ld l,(ix+019h)		;8ab4
	pop ix		;8ab7
	ld (ix+015h),h		;8ab9
	ld (ix+016h),l		;8abc
	ld a,0c0h		;8abf
	call hacia_el_personaje_5a		;8ac1   ; hacia_el_personaje_5a: las velocidades hacia el personaje (A)
	jp 0b133h		;8ac4   ; velocidades: la de lado = DE y la vertical = HL
L_8AC7:
	ld a,(ix+015h)		;8ac7   ; lee las columnas de la figura que se pintan
	sub 018h		;8aca
	cp (ix+005h)		;8acc   ; compara con la y de la figura
	ret nc			;8acf
	add a,030h		;8ad0
	cp (ix+005h)		;8ad2   ; compara con la y de la figura
	ret c			;8ad5
	ld a,(ix+016h)		;8ad6
	sub 012h		;8ad9
	cp (ix+007h)		;8adb   ; compara con la x de la figura
	ret nc			;8ade
	add a,024h		;8adf
	cp (ix+007h)		;8ae1   ; compara con la x de la figura
	ret c			;8ae4
	ld a,00ch		;8ae5
	call 04059h		;8ae7   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	xor a			;8aea
	ld (ix+001h),a		;8aeb   ; guarda el paso de la figura
	ld d,a			;8aee
	ld e,a			;8aef
	ld l,a			;8af0
	ld h,002h		;8af1
	call 0b133h		;8af3   ; velocidades: la de lado = DE y la vertical = HL
	ld h,(ix+015h)		;8af6   ; lee las columnas de la figura que se pintan
	ld l,(ix+016h)		;8af9
	ld (ix+005h),h		;8afc   ; guarda la y de la figura
	ld (ix+007h),l		;8aff   ; guarda la x de la figura
	ld (ix+018h),h		;8b02
	ld (ix+019h),l		;8b05
	push ix		;8b08
	call busca_36		;8b0a   ; busca_36: busca una figura de tipo 0x36
	ld (ix+001h),001h		;8b0d   ; el paso de la figura = 0x01
	pop ix		;8b11
	ret			;8b13
busca_36:		; busca una figura de tipo 0x36
	ld ix,0e800h		;8b14   ; apunta a los huecos de figura (32 bytes cada uno)
	ld b,008h		;8b18
	ld de,00020h		;8b1a
L_8B1D:
	ld a,(ix+000h)		;8b1d   ; lee el tipo de la figura
	cp 036h		;8b20
	jr z,L_8B29		;8b22
L_8B24:
	add ix,de		;8b24
	djnz L_8B1D		;8b26
	ret			;8b28
L_8B29:
	ld a,(0e634h)		;8b29
	cp (ix+014h)		;8b2c
	jr nz,L_8B24		;8b2f
	ret			;8b31
tipo_31_entra:		; al entrar el tipo 0x31
	call banderas_bajas		;8b32   ; El tipo 0x31: al entrar
	ld (ix+018h),003h		;8b35
espera_azar_71cf:		; una espera al azar
	call azar_5		;8b39   ; azar_5: A = R con el contador de cuadros
	jp 071cfh		;8b3c
tipo_31_cuadro:		; cada cuadro el tipo 0x31
	ld a,(ix+001h)		;8b3f   ; El tipo 0x31: cada cuadro
	call 04050h		;8b42   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_8B45: 3 destinos del despachador de 0x4140 (call en p05:8B42):
;   0x8B4B, 0x8B68, 0x8B8D; lo leen p05:8B42 (6 bytes)
;   0x8b45..0x8b4b  (6 bytes)
DATA_tabla_8B45:
	defb 04bh,08bh	; 8b45
	defb 068h,08bh	; 8b47
	defb 08dh,08bh	; 8b49

; ======================================================================
; CODIGO 0x8b4b..0x8c05  (186 bytes)
; ======================================================================


L_8B4B:
	dec (ix+008h)		;8b4b
	ret nz			;8b4e
	ld a,(ix+005h)		;8b4f   ; lee la y de la figura
	add a,010h		;8b52
	ld l,a			;8b54
	ld h,(ix+007h)		;8b55   ; lee la x de la figura
	call 0406eh		;8b58   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr nc,L_8B60		;8b5b
	inc (ix+017h)		;8b5d
L_8B60:
	inc (ix+001h)		;8b60   ; sube el paso de la figura
	call dibujo_de_tabla_16		;8b63   ; dibujo_de_tabla_16: el dibujo y el ancho de la tabla 0x8C05/0x8C0E
	jr L_8BB7		;8b66
L_8B68:
	dec (ix+008h)		;8b68
	jr nz,L_8B98		;8b6b
	ld (ix+008h),020h		;8b6d
	inc (ix+016h)		;8b71
	call dibujo_de_tabla_16		;8b74   ; dibujo_de_tabla_16: el dibujo y el ancho de la tabla 0x8C05/0x8C0E
	ld a,(ix+016h)		;8b77
	cp 008h		;8b7a
	ret c			;8b7c
	ld (ix+016h),000h		;8b7d
	call espera_azar_71cf		;8b81   ; espera_azar_71cf: una espera al azar
	call banderas_bajas		;8b84   ; banderas_bajas: solo los 4 bits bajos de las banderas
	call dibujo_de_tabla_16		;8b87   ; dibujo_de_tabla_16: el dibujo y el ancho de la tabla 0x8C05/0x8C0E
	jp paso_siguiente_de_figura		;8b8a   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_8B8D:
	dec (ix+008h)		;8b8d
	ret nz			;8b90
	ld (ix+008h),020h		;8b91
	jp 07db8h		;8b95
L_8B98:
	dec (ix+018h)		;8b98
	ret nz			;8b9b
	ld (ix+018h),003h		;8b9c
	ld a,(ix+00ah)		;8ba0   ; lee el dibujo (o el mosaico) de la figura
	cp (ix+014h)		;8ba3
	ld a,(ix+015h)		;8ba6   ; lee las columnas de la figura que se pintan
	jr z,L_8BAE		;8ba9
	ld a,(ix+014h)		;8bab
L_8BAE:
	ld (ix+00ah),a		;8bae   ; guarda el dibujo (o el mosaico) de la figura
	ld hl,08c17h		;8bb1
	call 0b088h		;8bb4   ; tamano_c4: el tamaño (ix+0x11) del dibujo - 0xC4 de la tabla HL
L_8BB7:
	ld a,(ix+00ah)		;8bb7   ; lee el dibujo (o el mosaico) de la figura
	cp 0c4h		;8bba
	jr z,L_8BCD		;8bbc
	cp 0d4h		;8bbe
	jr z,L_8BCD		;8bc0
	or a			;8bc2
	jp z,banderas_bajas		;8bc3   ; banderas_bajas: solo los 4 bits bajos de las banderas
	ld a,0c0h		;8bc6
	or (ix+002h)		;8bc8   ; OR con las banderas de la figura (bit 7: en pantalla)
	jr L_8BD7		;8bcb
L_8BCD:
	ld a,00fh		;8bcd
	and (ix+002h)		;8bcf   ; AND con las banderas de la figura (bit 7: en pantalla)
	ld a,080h		;8bd2
	or (ix+002h)		;8bd4   ; OR con las banderas de la figura (bit 7: en pantalla)
L_8BD7:
	jp L_96FA		;8bd7
dibujo_de_tabla_16:		; el dibujo y el ancho de la tabla 0x8C05/0x8C0E
	bit 0,(ix+017h)		;8bda
	ld hl,08c0eh		;8bde
	jr z,L_8BE6		;8be1
	ld hl,08c05h		;8be3
L_8BE6:
	ld a,(ix+016h)		;8be6
	call 04083h		;8be9   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+014h),a		;8bec
	ld (ix+00ah),a		;8bef   ; guarda el dibujo (o el mosaico) de la figura
	inc hl			;8bf2
	ld a,(hl)			;8bf3
	ld (ix+015h),a		;8bf4   ; guarda las columnas de la figura que se pintan
	ld (ix+008h),020h		;8bf7
	ld (ix+018h),003h		;8bfb
	ld hl,08c17h		;8bff
	jp 0b088h		;8c02   ; tamano_c4: el tamaño (ix+0x11) del dibujo - 0xC4 de la tabla HL

; ----------------------------------------------------------------------
; DATOS nueve_bytes_8c05: 9 bytes que p05:8BE3 lee con (ix+0x16): el que toca
;   va a (ix+0x14) y (ix+0x0A) y el siguiente a (ix+0x15)
;   0x8c05..0x8c0e  (9 bytes)
DATA_nueve_bytes_8c05:
	defb 000h,0c4h,0c8h,0cch,0d0h,0cch,0c8h,0c4h,000h	; 8c05  .........

; ----------------------------------------------------------------------
; DATOS nueve_bytes_8c0e: lo mismo para el otro lado (bit 0 de (ix+0x17),
;   p05:8BDE)
;   0x8c0e..0x8c17  (9 bytes)
DATA_nueve_bytes_8c0e:
	defb 000h,0d4h,0d8h,0dch,0e0h,0dch,0d8h,0d4h,000h	; 8c0e  .........

; ----------------------------------------------------------------------
; DATOS ocho_bytes_8c17: 8 bytes que p05:8BB1 y p05:8BFF pasan en HL a
;   p06:B088
;   0x8c17..0x8c1f  (8 bytes)
DATA_ocho_bytes_8c17:
	defb 072h,073h,074h,075h,076h,077h,074h,075h	; 8c17  rstuvwtu

; ======================================================================
; CODIGO 0x8c1f..0x8dc5  (422 bytes)
; ======================================================================


tipo_16_entra:		; al entrar el tipo 0x16
	call espera_1e		;8c1f   ; El tipo 0x16: al entrar
	res 4,(ix+002h)		;8c22   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ld a,(0e507h)		;8c26   ; lee la x del personaje
	cp (ix+007h)		;8c29   ; compara con la x de la figura
	ld a,000h		;8c2c
	jr nc,L_8C32		;8c2e
	ld a,002h		;8c30
L_8C32:
	ld (ix+00ah),a		;8c32   ; guarda el dibujo (o el mosaico) de la figura
	ret			;8c35
tipo_16_cuadro:		; cada cuadro el tipo 0x16
	ld a,(ix+001h)		;8c36   ; El tipo 0x16: cada cuadro
	dec a			;8c39
	jr z,L_8C7A		;8c3a
	dec a			;8c3c
	jr z,L_8C9D		;8c3d
	jp p,L_8CAE		;8c3f
	dec (ix+008h)		;8c42
	jr z,L_8C57		;8c45
L_8C47:
	bit 1,(ix+008h)		;8c47
	jr z,L_8C52		;8c4b
L_8C4D:
	set 7,(ix+002h)		;8c4d   ; pone a uno el bit 7 de las banderas de la figura (bit 7: en pantalla)
	ret			;8c51
L_8C52:
	res 7,(ix+002h)		;8c52   ; pone a cero el bit 7 de las banderas de la figura (bit 7: en pantalla)
	ret			;8c56
L_8C57:
	inc (ix+001h)		;8c57   ; sube el paso de la figura
	set 7,(ix+002h)		;8c5a   ; pone a uno el bit 7 de las banderas de la figura (bit 7: en pantalla)
	set 4,(ix+002h)		;8c5e   ; pone a uno el bit 4 de las banderas de la figura (bit 7: en pantalla)
	call hacia_el_personaje_40		;8c62   ; hacia_el_personaje_40: las velocidades hacia el personaje (0x40)
	xor a			;8c65
	bit 7,(ix+00fh)		;8c66   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_8C6E		;8c6a
	ld a,002h		;8c6c
L_8C6E:
	ld (ix+00ah),a		;8c6e   ; guarda el dibujo (o el mosaico) de la figura
	ret			;8c71
hacia_el_personaje_40:		; las velocidades hacia el personaje (0x40)
	ld a,040h		;8c72
	call 0b18fh		;8c74   ; hacia_el_personaje: HL, DE = las velocidades hacia el personaje (A + 8 x 0xE045)
	jp 0b133h		;8c77   ; velocidades: la de lado = DE y la vertical = HL
L_8C7A:
	call parpadeo_bit_0		;8c7a   ; parpadeo_bit_0: cada 4 cuadros el bit 0 del dibujo
	call en_la_pantalla		;8c7d   ; en_la_pantalla: C si la figura esta dentro de la pantalla
	ret c			;8c80
	inc (ix+001h)		;8c81   ; sube el paso de la figura
	call espera_1e		;8c84   ; espera_1e: la espera 0x1E
	res 4,(ix+002h)		;8c87   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ret			;8c8b
parpadeo_bit_0:		; cada 4 cuadros el bit 0 del dibujo
	ld a,(0e604h)		;8c8c   ; lee el contador de cuadros de partida
	bit 2,a		;8c8f
	jr z,L_8C98		;8c91
	set 0,(ix+00ah)		;8c93   ; pone a uno el bit 0 de el dibujo (o el mosaico) de la figura
	ret			;8c97
L_8C98:
	res 0,(ix+00ah)		;8c98   ; pone a cero el bit 0 de el dibujo (o el mosaico) de la figura
	ret			;8c9c
L_8C9D:
	dec (ix+008h)		;8c9d
	jr nz,L_8C47		;8ca0
	inc (ix+001h)		;8ca2   ; sube el paso de la figura
	call espera_1e		;8ca5   ; espera_1e: la espera 0x1E
	ld (ix+015h),00ah		;8ca8   ; las columnas de la figura que se pintan = 0x0A
	jr L_8C52		;8cac
L_8CAE:
	dec (ix+008h)		;8cae
	jr z,L_8CC9		;8cb1
	dec (ix+015h)		;8cb3   ; baja las columnas de la figura que se pintan
	ret nz			;8cb6
	ld (ix+015h),00ah		;8cb7   ; las columnas de la figura que se pintan = 0x0A
	ld d,(ix+005h)		;8cbb   ; lee la y de la figura
	ld e,(ix+007h)		;8cbe   ; lee la x de la figura
	ld a,046h		;8cc1
	ld b,000h		;8cc3
	ld c,b			;8cc5
	jp 06551h		;8cc6   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_8CC9:
	ld a,r		;8cc9
	and 07fh		;8ccb
	add a,030h		;8ccd
	ld (ix+007h),a		;8ccf   ; guarda la x de la figura
	ld a,(0e604h)		;8cd2   ; lee el contador de cuadros de partida
	and 07fh		;8cd5
	add a,020h		;8cd7
	ld (ix+005h),a		;8cd9   ; guarda la y de la figura
	call espera_1e		;8cdc   ; espera_1e: la espera 0x1E
	ld (ix+001h),000h		;8cdf   ; el paso de la figura = 0x00
	jp L_8C4D		;8ce3
tipo_46_entra:		; al entrar el tipo 0x46
	call 0b18dh		;8ce6   ; El tipo 0x46: al entrar
	call 0b133h		;8ce9   ; velocidades: la de lado = DE y la vertical = HL
tipo_1e_entra:		; al entrar el tipo 0x1E
	call 06c42h		;8cec   ; El tipo 0x1E: al entrar
	ld a,00fh		;8cef
	jp 04059h		;8cf1   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
en_la_pantalla:		; C si la figura esta dentro de la pantalla
	ld a,(ix+007h)		;8cf4   ; lee la x de la figura
	sub 010h		;8cf7
	cp 0d1h		;8cf9
	ret nc			;8cfb
	ld a,(ix+005h)		;8cfc   ; lee la y de la figura
	sub 020h		;8cff
	cp 081h		;8d01
tipo_46_cuadro:		; cada cuadro el tipo 0x46
	ret			;8d03   ; El tipo 0x46: cada cuadro
tipo_40_entra:		; al entrar el tipo 0x40
	ld (ix+015h),078h		;8d04   ; El tipo 0x40: al entrar
	call dos_sprites_4_5		;8d08   ; dos_sprites_4_5: el dibujo 4 o 5 y el segundo sprite al lado
	jr L_8D4F		;8d0b
tipo_40_cuadro:		; cada cuadro el tipo 0x40
	call dos_sprites_4_5		;8d0d   ; El tipo 0x40: cada cuadro
	ld a,(ix+001h)		;8d10   ; lee el paso de la figura
	dec a			;8d13
	jr z,L_8D29		;8d14
	call rebota_en_la_pantalla		;8d16   ; rebota_en_la_pantalla: fuera de la pantalla da la vuelta; si no, cada 0x3C cuadros hacia el personaje
	dec (ix+015h)		;8d19   ; baja las columnas de la figura que se pintan
	ret nz			;8d1c
	inc (ix+001h)		;8d1d   ; sube el paso de la figura
	res 4,(ix+002h)		;8d20   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ld (ix+015h),01eh		;8d24   ; las columnas de la figura que se pintan = 0x1E
tipo_41_cuadro:		; cada cuadro el tipo 0x41
	ret			;8d28   ; El tipo 0x41: cada cuadro
L_8D29:
	dec (ix+015h)		;8d29   ; baja las columnas de la figura que se pintan
	ret nz			;8d2c
	dec (ix+001h)		;8d2d   ; baja el paso de la figura
	set 4,(ix+002h)		;8d30   ; pone a uno el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ld (ix+015h),078h		;8d34   ; las columnas de la figura que se pintan = 0x78
	ld d,(ix+005h)		;8d38   ; lee la y de la figura
	ld e,(ix+007h)		;8d3b   ; lee la x de la figura
	ld b,000h		;8d3e
	ld c,b			;8d40
	ld a,041h		;8d41
	jp 06551h		;8d43   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
rebota_en_la_pantalla:		; fuera de la pantalla da la vuelta; si no, cada 0x3C cuadros hacia el personaje
	call en_la_pantalla		;8d46   ; en_la_pantalla: C si la figura esta dentro de la pantalla
	jr nc,L_8D5B		;8d49
	dec (ix+008h)		;8d4b
	ret nz			;8d4e
L_8D4F:
	ld (ix+008h),03ch		;8d4f
	ld a,010h		;8d53
	call 0b18fh		;8d55   ; hacia_el_personaje: HL, DE = las velocidades hacia el personaje (A + 8 x 0xE045)
	jp 0b133h		;8d58   ; velocidades: la de lado = DE y la vertical = HL
L_8D5B:
	call 0b15fh		;8d5b   ; vuelta_de_lado: la velocidad de lado al reves
	jp 0b16fh		;8d5e   ; vuelta_vertical: la velocidad vertical al reves
dos_sprites_4_5:		; el dibujo 4 o 5 y el segundo sprite al lado
	ld a,(0e604h)		;8d61   ; lee el contador de cuadros de partida
	bit 3,a		;8d64
	ld a,004h		;8d66
	jr z,L_8D6B		;8d68
	inc a			;8d6a
L_8D6B:
	ld (ix+00ah),a		;8d6b   ; guarda el dibujo (o el mosaico) de la figura
	ld a,(ix+005h)		;8d6e   ; lee la y de la figura
	add a,00ah		;8d71
	ld (ix+012h),a		;8d73
	ld a,(ix+007h)		;8d76   ; lee la x de la figura
	add a,00dh		;8d79
	ld (ix+013h),a		;8d7b
	ret			;8d7e
tipo_41_entra:		; al entrar el tipo 0x41
	call 06c42h		;8d7f   ; El tipo 0x41: al entrar
	ld de,00808h		;8d82
	call 0b1dbh		;8d85   ; angulo_hacia: 0xF018 = el angulo hacia el personaje desde la figura + DE
	add a,010h		;8d88
	rlca			;8d8a
	rlca			;8d8b
	rlca			;8d8c
	and 007h		;8d8d
	add a,a			;8d8f
	add a,a			;8d90
	add a,a			;8d91
	ld c,a			;8d92
	ld b,000h		;8d93
	ld hl,08dc5h		;8d95
	add hl,bc			;8d98
	ld a,(hl)			;8d99
	ld (ix+00ah),a		;8d9a   ; guarda el dibujo (o el mosaico) de la figura
	inc hl			;8d9d
	ld e,(hl)			;8d9e
	inc hl			;8d9f
	ld d,(hl)			;8da0
	call 0b137h		;8da1   ; velocidad_vertical: la velocidad vertical = DE
	inc hl			;8da4
	ld e,(hl)			;8da5
	inc hl			;8da6
	ld d,(hl)			;8da7
	inc hl			;8da8
	call 0b13eh		;8da9   ; velocidad_de_lado: la velocidad de lado = DE
	ld a,(hl)			;8dac
	inc hl			;8dad
	add a,(ix+005h)		;8dae   ; le suma la y de la figura
	ld (ix+005h),a		;8db1   ; guarda la y de la figura
	ld a,(hl)			;8db4
	add a,(ix+007h)		;8db5   ; le suma la x de la figura
	ld (ix+007h),a		;8db8   ; guarda la x de la figura
	inc hl			;8dbb
	ld a,(hl)			;8dbc
	ld (ix+011h),a		;8dbd   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	ld a,019h		;8dc0
	jp 04059h		;8dc2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)

; ----------------------------------------------------------------------
; DATOS fichas_8dc5: 8 fichas de 8 bytes que p05:8D95 elige con n x 8: el
;   primer byte va a (ix+0x0A)
;   0x8dc5..0x8e05  (64 bytes)
DATA_fichas_8dc5:
	defb 0a4h,000h,000h,000h,004h,00dh,010h,03ah	; 8dc5  .......:
	defb 0c8h,000h,004h,000h,004h,00dh,010h,075h	; 8dcd  .......u
	defb 0a8h,000h,004h,000h,000h,00dh,010h,03bh	; 8dd5  ........
	defb 0bch,000h,004h,000h,0fch,00dh,000h,075h	; 8ddd  .......u
	defb 0a4h,000h,000h,000h,0fch,00dh,000h,03ah	; 8de5  .......:
	defb 0c8h,000h,0fch,000h,0fch,0fdh,000h,075h	; 8ded  .......u
	defb 0a8h,000h,0fch,000h,000h,0fdh,010h,03bh	; 8df5  ........
	defb 0bch,000h,0fch,000h,004h,0fdh,010h,075h	; 8dfd  .......u

; ======================================================================
; CODIGO 0x8e05..0x9064  (607 bytes)
; ======================================================================


tipo_15_entra:		; al entrar el tipo 0x15
	res 4,(ix+002h)		;8e05   ; El tipo 0x15: al entrar
	ld (ix+017h),060h		;8e09
	ld (ix+019h),080h		;8e0d
	xor a			;8e11
	ld (ix+01ah),a		;8e12
	ld (ix+01dh),a		;8e15
	ld (ix+01bh),001h		;8e18
	ld (ix+01ch),03ch		;8e1c
	ld a,r		;8e20
	and 07fh		;8e22
	add a,080h		;8e24
	ld (ix+008h),a		;8e26
	ld (ix+01eh),03ch		;8e29
	call gira_y_dispara		;8e2d   ; gira_y_dispara: gira, se mueve y dispara cada cierto tiempo
	call dibujo_42		;8e30   ; dibujo_42: cada 8 cuadros el dibujo 8/9 y el tamaño 0x42/0x43
espera_20_5f:		; (ix+0x15) = 0x20 + azar
	ld a,r		;8e33
	and 03fh		;8e35
	add a,020h		;8e37
	ld (ix+015h),a		;8e39   ; guarda las columnas de la figura que se pintan
	ret			;8e3c
tipo_15_cuadro:		; cada cuadro el tipo 0x15
	ld a,(ix+01eh)		;8e3d   ; El tipo 0x15: cada cuadro
	or a			;8e40
	jr z,L_8E4D		;8e41
	ld a,(0e604h)		;8e43   ; lee el contador de cuadros de partida
	and 01fh		;8e46
	jr nz,L_8E4D		;8e48
	dec (ix+01eh)		;8e4a
L_8E4D:
	ld a,(ix+001h)		;8e4d   ; lee el paso de la figura
	dec a			;8e50
	jr z,L_8EAA		;8e51
	dec (ix+008h)		;8e53
	jr nz,gira_y_dispara		;8e56
	inc (ix+001h)		;8e58   ; sube el paso de la figura
	ld a,r		;8e5b
	and 03fh		;8e5d
	add a,030h		;8e5f
	ld (ix+008h),a		;8e61
	ld a,(ix+01eh)		;8e64
	or a			;8e67
	jr nz,L_8E78		;8e68
	ld a,010h		;8e6a
	ld e,(ix+017h)		;8e6c
	ld d,(ix+019h)		;8e6f
	call 0b195h		;8e72   ; hacia_el_personaje_de: las velocidades desde DE hacia el personaje
	jp 0b133h		;8e75   ; velocidades: la de lado = DE y la vertical = HL
L_8E78:
	ld a,010h		;8e78
	ld (0e609h),a		;8e7a
	ld b,000h		;8e7d
	ld a,(ix+017h)		;8e7f
	cp 040h		;8e82
	jr c,L_8E90		;8e84
	cp 080h		;8e86
	ld b,080h		;8e88
	jr nc,L_8E90		;8e8a
	ld a,r		;8e8c
	jr L_8E95		;8e8e
L_8E90:
	ld a,r		;8e90
	and 07fh		;8e92
	add a,b			;8e94
L_8E95:
	call 0b1ffh		;8e95   ; cuadrante: el cuadrante y el angulo de A a 0xF010 y 0xF017
	call 0b1a6h		;8e98
	jp 0b133h		;8e9b   ; velocidades: la de lado = DE y la vertical = HL
L_8E9E:
	dec (ix+001h)		;8e9e   ; baja el paso de la figura
	ld a,r		;8ea1
	and 07fh		;8ea3
	add a,080h		;8ea5
	jp 071cfh		;8ea7
L_8EAA:
	dec (ix+008h)		;8eaa
	jr z,L_8E9E		;8ead
	call oscila		;8eaf   ; oscila: (ix+0x16) mas la velocidad vertical
gira_y_dispara:		; gira, se mueve y dispara cada cierto tiempo
	call gira		;8eb2   ; gira: el angulo (ix+0x1A) gira
	call velocidad_del_angulo		;8eb5   ; velocidad_del_angulo: las velocidades del angulo (ix+0x1A)
	call dispara_al_azar		;8eb8   ; dispara_al_azar: cada (ix+0x15) cuadros una figura desde el centro
dibujo_42:		; cada 8 cuadros el dibujo 8/9 y el tamaño 0x42/0x43
	ld a,(0e604h)		;8ebb   ; lee el contador de cuadros de partida
	ld b,a			;8ebe
	and 007h		;8ebf
	ret nz			;8ec1
	ld de,00842h		;8ec2
	bit 3,b		;8ec5
	jr z,L_8ECB		;8ec7
	inc d			;8ec9
	inc e			;8eca
L_8ECB:
	ld (ix+00ah),d		;8ecb   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+011h),e		;8ece   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	ret			;8ed1
dispara_al_azar:		; cada (ix+0x15) cuadros una figura desde el centro
	dec (ix+015h)		;8ed2   ; baja las columnas de la figura que se pintan
	ret nz			;8ed5
	call espera_20_5f		;8ed6   ; espera_20_5f: (ix+0x15) = 0x20 + azar
	ld a,(ix+005h)		;8ed9   ; lee la y de la figura
	add a,008h		;8edc
	ld d,a			;8ede
	ld a,(ix+007h)		;8edf   ; lee la x de la figura
	add a,008h		;8ee2
	ld e,a			;8ee4
	ld b,000h		;8ee5
	ld c,b			;8ee7
	ld a,045h		;8ee8
	jp 06551h		;8eea   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
oscila:		; (ix+0x16) mas la velocidad vertical
	ld a,(ix+01bh)		;8eed
	or a			;8ef0
	ret z			;8ef1
	ld a,(ix+016h)		;8ef2
	add a,(ix+00ch)		;8ef5   ; le suma la velocidad vertical de la figura
	ld (ix+016h),a		;8ef8
	ld a,(ix+017h)		;8efb
	adc a,(ix+00dh)		;8efe   ; le suma la velocidad vertical de la figura (alta)
	ld (ix+017h),a		;8f01
	ld bc,02080h		;8f04
	ld a,(ix+017h)		;8f07
	cp b			;8f0a
	jr nc,L_8F10		;8f0b
	ld (ix+017h),b		;8f0d
L_8F10:
	cp c			;8f10
	jr c,L_8F16		;8f11
	ld (ix+017h),c		;8f13
L_8F16:
	ld a,(ix+018h)		;8f16
	add a,(ix+00eh)		;8f19   ; le suma la velocidad de lado de la figura
	ld (ix+018h),a		;8f1c
	ld a,(ix+019h)		;8f1f
	adc a,(ix+00fh)		;8f22   ; le suma la velocidad de lado de la figura (alta)
	ld (ix+019h),a		;8f25
	ld bc,020c0h		;8f28
	ld a,(ix+019h)		;8f2b
	cp b			;8f2e
	jr nc,L_8F34		;8f2f
	ld (ix+019h),b		;8f31
L_8F34:
	cp c			;8f34
	ret c			;8f35
	ld (ix+019h),c		;8f36
	ret			;8f39
gira:		; el angulo (ix+0x1A) gira
	ld a,(ix+01ah)		;8f3a
	add a,(ix+01bh)		;8f3d
	ld (ix+01ah),a		;8f40
	dec (ix+01ch)		;8f43
	ret nz			;8f46
	ld (ix+01ch),03ch		;8f47
	bit 0,(ix+01dh)		;8f4b
	jr z,L_8F64		;8f4f
	ld a,(ix+01bh)		;8f51
	sub 008h		;8f54
	neg		;8f56
	cp 010h		;8f58
	jr c,L_8F71		;8f5a
	ld (ix+01dh),000h		;8f5c
L_8F60:
	inc (ix+01bh)		;8f60
	ret			;8f63
L_8F64:
	ld a,(ix+01bh)		;8f64
	add a,008h		;8f67
	cp 010h		;8f69
	jr c,L_8F60		;8f6b
	ld (ix+01dh),001h		;8f6d
L_8F71:
	dec (ix+01bh)		;8f71
	ret			;8f74
velocidad_del_angulo:		; las velocidades del angulo (ix+0x1A)
	ld a,(ix+01ah)		;8f75
	call 0b1ffh		;8f78   ; cuadrante: el cuadrante y el angulo de A a 0xF010 y 0xF017
	ld e,a			;8f7b
	ld d,000h		;8f7c
	sub 03fh		;8f7e
	neg		;8f80
	ld hl,0b374h		;8f82
	push hl			;8f85
	add hl,de			;8f86
	ld c,(hl)			;8f87
	pop hl			;8f88
	ld e,a			;8f89
	add hl,de			;8f8a
	ld a,(hl)			;8f8b
	ld (0f016h),a		;8f8c
	ld a,c			;8f8f
	rra			;8f90
	rra			;8f91
	rra			;8f92
	and 01fh		;8f93
	ld hl,0f010h		;8f95
	bit 0,(hl)		;8f98
	jr z,L_8F9E		;8f9a
	neg		;8f9c
L_8F9E:
	add a,(ix+017h)		;8f9e
	ld (ix+005h),a		;8fa1   ; guarda la y de la figura
	ld a,(0f016h)		;8fa4
	rra			;8fa7
	rra			;8fa8
	rra			;8fa9
	and 01fh		;8faa
	inc l			;8fac
	bit 0,(hl)		;8fad
	jr z,L_8FB3		;8faf
	neg		;8fb1
L_8FB3:
	add a,(ix+019h)		;8fb3
	ld (ix+007h),a		;8fb6   ; guarda la x de la figura
tipo_45_cuadro:		; cada cuadro el tipo 0x45
	ret			;8fb9   ; El tipo 0x45: cada cuadro
tipo_45_entra:		; al entrar el tipo 0x45
	call 06c42h		;8fba   ; El tipo 0x45: al entrar
	ld a,040h		;8fbd
	call 0b18fh		;8fbf   ; hacia_el_personaje: HL, DE = las velocidades hacia el personaje (A + 8 x 0xE045)
	call 0b133h		;8fc2   ; velocidades: la de lado = DE y la vertical = HL
L_8FC5:
	ld a,00eh		;8fc5
	jp 04059h		;8fc7   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
tipo_4c_entra:		; al entrar el tipo 0x4C
	ld (ix+015h),010h		;8fca   ; El tipo 0x4C: al entrar
	ld (ix+008h),008h		;8fce
	ret			;8fd2
tipo_4c_cuadro:		; cada cuadro el tipo 0x4C
	ld de,00108h		;8fd3   ; El tipo 0x4C: cada cuadro
	ld b,000h		;8fd6
	call 0b0d6h		;8fd8   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
	dec (ix+015h)		;8fdb   ; baja las columnas de la figura que se pintan
	jp nz,por_el_paso		;8fde   ; por_el_paso: por el paso de la figura
	ld (ix+015h),010h		;8fe1   ; las columnas de la figura que se pintan = 0x10
	ld d,(ix+005h)		;8fe5   ; lee la y de la figura
	ld a,(ix+007h)		;8fe8   ; lee la x de la figura
	add a,010h		;8feb
	ld e,a			;8fed
	ld a,d			;8fee
	add a,010h		;8fef
	ld d,a			;8ff1
	ld a,04dh		;8ff2
	jp 06551h		;8ff4   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
tipo_4d_entra:		; al entrar el tipo 0x4D
	call 06c42h		;8ff7   ; El tipo 0x4D: al entrar
	ld (ix+00bh),001h		;8ffa   ; el ancho del mosaico = 0x01
	call azar_5		;8ffe   ; azar_5: A = R con el contador de cuadros
	and 00fh		;9001
	ld (ix+015h),a		;9003   ; guarda las columnas de la figura que se pintan
	ld (ix+018h),004h		;9006
	ret			;900a
tipo_4d_cuadro:		; cada cuadro el tipo 0x4D
	call dibujo_c0_cada_4		;900b   ; El tipo 0x4D: cada cuadro
	ld a,(ix+001h)		;900e   ; lee el paso de la figura
	dec a			;9011
	jr z,L_9047		;9012
	ld a,(ix+014h)		;9014
	cp 004h		;9017
	jr nz,L_901F		;9019
	ld (ix+016h),0ffh		;901b
L_901F:
	and a			;901f
	jr nz,L_9026		;9020
	ld (ix+016h),001h		;9022
L_9026:
	ld a,(ix+015h)		;9026   ; lee las columnas de la figura que se pintan
	ld hl,09064h		;9029
	call 04062h		;902c   ; hl_mas_a (por 0x4062): HL += A
	ld a,(ix+014h)		;902f
	add a,(ix+016h)		;9032
	ld (ix+014h),a		;9035
	call 04083h		;9038   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld b,001h		;903b
	call 07e25h		;903d
	ld (ix+017h),008h		;9040
	jp paso_siguiente_de_figura		;9044   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9047:
	dec (ix+017h)		;9047
	ret nz			;904a
	dec (ix+001h)		;904b   ; baja el paso de la figura
	ret			;904e
dibujo_c0_cada_4:		; cada 4 cuadros el dibujo siguiente 0xC0-0xCF
	dec (ix+018h)		;904f
	ret nz			;9052
	ld (ix+018h),004h		;9053
	ld a,(ix+00ah)		;9057   ; lee el dibujo (o el mosaico) de la figura
	add a,004h		;905a
	and 00fh		;905c
	or 0c0h		;905e
	ld (ix+00ah),a		;9060   ; guarda el dibujo (o el mosaico) de la figura
	ret			;9063

; ----------------------------------------------------------------------
; DATOS veinte_bytes_9064: 20 bytes que p05:9029 recorre desde (ix+0x15) con
;   el paso (ix+0x14)
;   0x9064..0x9078  (20 bytes)
DATA_veinte_bytes_9064:
	defb 001h,002h,003h,004h,005h,006h,007h,008h,009h,00ah,00bh,00ch,00dh,00eh,00fh,000h	; 9064  ................
	defb 001h,002h,003h,004h	; 9074

; ======================================================================
; CODIGO 0x9078..0x9225  (429 bytes)
; ======================================================================


tipos_32_y_mas_entra:		; al entrar los tipos 0x32, 0x51
	call espera_1e		;9078   ; Los tipos 0x32, 0x51: al entrar
	ld (ix+015h),01eh		;907b   ; las columnas de la figura que se pintan = 0x1E
L_907F:
	res 6,(ix+002h)		;907f   ; pone a cero el bit 6 de las banderas de la figura (bit 7: en pantalla)
	ret			;9083
tipos_32_y_mas_cuadro:		; cada cuadro los tipos 0x32, 0x51
	ld a,(ix+001h)		;9084   ; Los tipos 0x32, 0x51: cada cuadro
	dec a			;9087
	jr z,L_90D7		;9088
	dec (ix+008h)		;908a
	ret nz			;908d
	ld a,(0e505h)		;908e   ; lee la y del personaje
	ld c,a			;9091
	ld a,(ix+005h)		;9092   ; lee la y de la figura
	sub c			;9095
	ret nc			;9096
	cp 0e0h		;9097
	ret c			;9099
	ld a,(0e507h)		;909a   ; lee la x del personaje
	ld b,a			;909d
	ld a,(ix+000h)		;909e   ; lee el tipo de la figura
	sub 032h		;90a1
	jr z,L_90B9		;90a3
	ld a,(ix+007h)		;90a5   ; lee la x de la figura
	sub b			;90a8
	ret c			;90a9
	sub 010h		;90aa
	ret c			;90ac
	sub 020h		;90ad
	jr c,L_90CB		;90af
	sub 010h		;90b1
	ret c			;90b3
	sub 020h		;90b4
	jr c,L_90CB		;90b6
	ret			;90b8
L_90B9:
	ld a,b			;90b9
	sub (ix+007h)		;90ba   ; le resta la x de la figura
	ret c			;90bd
	sub 028h		;90be
	ret c			;90c0
	sub 020h		;90c1
	jr c,L_90CB		;90c3
	sub 010h		;90c5
	ret c			;90c7
	sub 020h		;90c8
	ret nc			;90ca
L_90CB:
	inc (ix+001h)		;90cb   ; sube el paso de la figura
	ret			;90ce
L_90CF:
	dec (ix+001h)		;90cf   ; baja el paso de la figura
espera_1e:		; la espera 0x1E
	ld (ix+008h),01eh		;90d2
	ret			;90d6
L_90D7:
	ld a,(0e505h)		;90d7   ; lee la y del personaje
	ld c,a			;90da
	ld a,(ix+005h)		;90db   ; lee la y de la figura
	sub c			;90de
	jr nc,L_90CF		;90df
	cp 0e0h		;90e1
	jr c,L_90CF		;90e3
	ld a,(0e507h)		;90e5   ; lee la x del personaje
	ld b,a			;90e8
	ld a,(ix+000h)		;90e9   ; lee el tipo de la figura
	sub 032h		;90ec
	jr z,L_9104		;90ee
	ld a,(ix+007h)		;90f0   ; lee la x de la figura
	sub b			;90f3
	ret c			;90f4
	sub 010h		;90f5
	ret c			;90f7
	sub 020h		;90f8
	jr c,L_9116		;90fa
	sub 010h		;90fc
	ret c			;90fe
	sub 020h		;90ff
	jr c,L_9116		;9101
	ret			;9103
L_9104:
	ld a,b			;9104
	sub (ix+007h)		;9105   ; le resta la x de la figura
	ret c			;9108
	sub 028h		;9109
	ret c			;910b
	sub 020h		;910c
	jr c,L_9116		;910e
	sub 010h		;9110
	ret c			;9112
	sub 020h		;9113
	ret nc			;9115
L_9116:
	dec (ix+015h)		;9116   ; baja las columnas de la figura que se pintan
	ret nz			;9119
	ld a,r		;911a
	and 01fh		;911c
	inc a			;911e
	ld (ix+015h),a		;911f   ; guarda las columnas de la figura que se pintan
	ld a,(ix+000h)		;9122   ; lee el tipo de la figura
	sub 032h		;9125
	ld de,00410h		;9127
	ld hl,00400h		;912a
	jr z,L_9134		;912d
	ld e,000h		;912f
	ld hl,0fc00h		;9131
L_9134:
	ld a,(ix+005h)		;9134   ; lee la y de la figura
	add a,d			;9137
	ld d,a			;9138
	ld a,(ix+007h)		;9139   ; lee la x de la figura
	add a,e			;913c
	ld e,a			;913d
	ld a,033h		;913e
	jp 06551h		;9140   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
tipo_33_entra:		; al entrar el tipo 0x33
	call 06c42h		;9143   ; El tipo 0x33: al entrar
	bit 7,(ix+00fh)		;9146   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_9154		;914a
	ld (ix+00ah),0c8h		;914c   ; el dibujo (o el mosaico) de la figura = 0xC8
	ld (ix+011h),060h		;9150   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x60
L_9154:
	ld a,010h		;9154
	jp 04059h		;9156   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
tipos_3a_y_mas_entra:		; al entrar los tipos 0x3A, 0x50
	ld (ix+008h),03ch		;9159   ; Los tipos 0x3A, 0x50: al entrar
	jp L_907F		;915d
tipos_3a_y_mas_cuadro:		; cada cuadro los tipos 0x3A, 0x50
	ld a,(ix+001h)		;9160   ; Los tipos 0x3A, 0x50: cada cuadro
	dec a			;9163
	jr z,L_9198		;9164
	dec (ix+008h)		;9166
	ret nz			;9169
	ld a,(0e507h)		;916a   ; lee la x del personaje
	ld b,a			;916d
	ld a,(0e505h)		;916e   ; lee la y del personaje
	ld c,a			;9171
	ld a,(ix+000h)		;9172   ; lee el tipo de la figura
	sub 03ah		;9175
	jr z,L_917B		;9177
	ld a,001h		;9179
L_917B:
	ld d,a			;917b
	ld a,(ix+005h)		;917c   ; lee la y de la figura
	sub c			;917f
	ret nc			;9180
	cp 0e0h		;9181
	ret c			;9183
	ld a,(ix+007h)		;9184   ; lee la x de la figura
	sub b			;9187
	dec d			;9188
	jr nz,L_918C		;9189
	ccf			;918b
L_918C:
	ret nc			;918c
	inc (ix+001h)		;918d   ; sube el paso de la figura
	inc (ix+00ah)		;9190   ; sube el dibujo (o el mosaico) de la figura
	ld (ix+008h),078h		;9193
	ret			;9197
L_9198:
	dec (ix+008h)		;9198
	jr z,L_91D5		;919b
	ld a,(0e604h)		;919d   ; lee el contador de cuadros de partida
	and 007h		;91a0
	ret nz			;91a2
	ld a,(0e507h)		;91a3   ; lee la x del personaje
	ld b,a			;91a6
	ld a,(ix+000h)		;91a7   ; lee el tipo de la figura
	sub 03ah		;91aa
	jr z,L_91B0		;91ac
	ld a,001h		;91ae
L_91B0:
	ld d,a			;91b0
	ld a,(ix+007h)		;91b1   ; lee la x de la figura
	sub b			;91b4
	dec d			;91b5
	jr nz,L_91B9		;91b6
	ccf			;91b8
L_91B9:
	ret nc			;91b9
	ld a,(ix+000h)		;91ba   ; lee el tipo de la figura
	sub 03ah		;91bd
	ld de,00410h		;91bf
	jr z,$+3		;91c2
	ld e,000h		;91c4
	ld a,(ix+005h)		;91c6   ; lee la y de la figura
	add a,d			;91c9
	ld d,a			;91ca
	ld a,(ix+007h)		;91cb   ; lee la x de la figura
	add a,e			;91ce
	ld e,a			;91cf
	ld a,03bh		;91d0
	jp 06551h		;91d2   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_91D5:
	dec (ix+001h)		;91d5   ; baja el paso de la figura
	ld (ix+008h),078h		;91d8
	dec (ix+00ah)		;91dc   ; baja el dibujo (o el mosaico) de la figura
tipo_3b_cuadro:		; cada cuadro el tipo 0x3B
	ret			;91df   ; El tipo 0x3B: cada cuadro
tipo_3b_entra:		; al entrar el tipo 0x3B
	call 06c42h		;91e0   ; El tipo 0x3B: al entrar
	ld a,(0e604h)		;91e3   ; lee el contador de cuadros de partida
	and 01fh		;91e6
	sub 008h		;91e8
	add a,(ix+005h)		;91ea   ; le suma la y de la figura
	ld e,a			;91ed
	ld d,(ix+007h)		;91ee   ; lee la x de la figura
	ld a,060h		;91f1
	call 0b195h		;91f3   ; hacia_el_personaje_de: las velocidades desde DE hacia el personaje
	call 0b133h		;91f6   ; velocidades: la de lado = DE y la vertical = HL
	ld a,012h		;91f9
	jp 04059h		;91fb   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
tipo_2f_entra:		; al entrar el tipo 0x2F
	ld a,(0e515h)		;91fe   ; El tipo 0x2F: al entrar
	and a			;9201
	jr z,L_920C		;9202
	inc a			;9204
	ld hl,0e513h		;9205
	bit 7,(hl)		;9208
	jr z,L_920D		;920a
L_920C:
	xor a			;920c
L_920D:
	ld (ix+001h),a		;920d   ; guarda el paso de la figura
	ld a,(ix+005h)		;9210   ; lee la y de la figura
	ld (ix+01fh),a		;9213
	jp 0b12eh		;9216   ; sin_lado: la velocidad de lado a 0
tipo_2f_cuadro:		; cada cuadro el tipo 0x2F
	ld a,(0e515h)		;9219   ; El tipo 0x2F: cada cuadro
	dec a			;921c
	jr nz,$+16		;921d
	ld a,(ix+001h)		;921f   ; lee el paso de la figura
	call 04050h		;9222   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9225: 4 destinos del despachador de 0x4140 (call en p05:9222):
;   0x927A, 0x9243, 0x9288, 0x9243; lo leen p05:9222 (8 bytes)
;   0x9225..0x922d  (8 bytes)
DATA_tabla_9225:
	defb 07ah,092h	; 9225
	defb 043h,092h	; 9227
	defb 088h,092h	; 9229
	defb 043h,092h	; 922b

; ======================================================================
; CODIGO 0x922d..0x939c  (367 bytes)
; ======================================================================


L_922D:
	bit 7,(ix+00dh)		;922d   ; mira el bit 7 de la velocidad vertical de la figura (alta)
	call nz,0b16fh		;9231   ; vuelta_vertical: la velocidad vertical al reves
	call 06bd5h		;9234   ; paso_0_figura: el paso a 0
	call llega_a_1f		;9237   ; llega_a_1f: C si la y aun no llega a (ix+0x1F)
	ret nc			;923a
	ld a,(ix+01fh)		;923b
	ld (ix+005h),a		;923e   ; guarda la y de la figura
	jr sin_vertical_5		;9241
L_9243:
	ld a,(0e515h)		;9243
	dec a			;9246
	jr nz,sin_vertical_5		;9247
	ld a,(0e50ah)		;9249   ; lee los pasos de la caida
	and a			;924c
	jr z,sin_vertical_5		;924d
	ld de,(0e512h)		;924f   ; lee la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	call 0b137h		;9253   ; velocidad_vertical: la velocidad vertical = DE
	ld a,(ix+001h)		;9256   ; lee el paso de la figura
	dec a			;9259
	jr nz,L_926A		;925a
	call pared_debajo_5		;925c   ; pared_debajo_5: C con pared debajo
	jr c,L_92AB		;925f
	ld a,(ix+005h)		;9261   ; lee la y de la figura
	cp 008h		;9264
	jr c,L_92B5		;9266
	jr L_9288		;9268
L_926A:
	call llega_a_1f		;926a   ; llega_a_1f: C si la y aun no llega a (ix+0x1F)
	ret nc			;926d
	call 06bd5h		;926e   ; paso_0_figura: el paso a 0
	ld a,(ix+01fh)		;9271
	ld (ix+005h),a		;9274   ; guarda la y de la figura
	call sin_vertical_5		;9277   ; sin_vertical_5: sin velocidad vertical
L_927A:
	ld a,(0e513h)		;927a
	bit 7,a		;927d
	ret z			;927f
	ld a,003h		;9280
	call 04059h		;9282   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp paso_siguiente_de_figura		;9285   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9288:
	ld a,(0e513h)		;9288
	and a			;928b
	ret nz			;928c
	jp paso_siguiente_de_figura		;928d   ; paso_siguiente_de_figura: sube el paso (ix+1)
sin_vertical_5:		; sin velocidad vertical
	jp 0b129h		;9290   ; sin_vertical: la velocidad vertical a 0
pared_debajo_5:		; C con pared debajo
	ld b,000h		;9293
	ld h,(ix+007h)		;9295   ; lee la x de la figura
	ld l,(ix+005h)		;9298   ; lee la y de la figura
	ld de,0000fh		;929b
	jp 04074h		;929e   ; pared_en_fila (por 0x4074): C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
llega_a_1f:		; C si la y aun no llega a (ix+0x1F)
	ld a,(ix+005h)		;92a1   ; lee la y de la figura
	ld b,a			;92a4
	inc b			;92a5
	ld a,(ix+01fh)		;92a6
	cp b			;92a9
	ret			;92aa
L_92AB:
	ld a,(ix+005h)		;92ab   ; lee la y de la figura
	and 0f8h		;92ae
	add a,008h		;92b0
	ld (ix+005h),a		;92b2   ; guarda la y de la figura
L_92B5:
	inc (ix+001h)		;92b5   ; sube el paso de la figura
	jr sin_vertical_5		;92b8
tipo_29_entra:		; al entrar el tipo 0x29
	ld a,001h		;92ba   ; El tipo 0x29: al entrar
	ld (0e627h),a		;92bc
	call azar_5		;92bf   ; azar_5: A = R con el contador de cuadros
	and 07fh		;92c2
	add a,040h		;92c4
	ld (ix+007h),a		;92c6   ; guarda la x de la figura
	call azar_5		;92c9   ; azar_5: A = R con el contador de cuadros
	and 03fh		;92cc
	add a,040h		;92ce
	ld (ix+005h),a		;92d0   ; guarda la y de la figura
	call azar_5		;92d3   ; azar_5: A = R con el contador de cuadros
	and 00fh		;92d6
	ld (ix+01fh),a		;92d8
	ld a,001h		;92db
	ld (ix+01eh),a		;92dd
	jp 071cfh		;92e0
tipo_29_cuadro:		; cada cuadro el tipo 0x29
	call anima_0c_66		;92e3   ; El tipo 0x29: cada cuadro
	ld a,(ix+01dh)		;92e6
	and a			;92e9
	jr z,L_9305		;92ea
	ld a,(ix+01eh)		;92ec
	and a			;92ef
	jr z,L_930E		;92f0
	ld a,(ix+01fh)		;92f2
	ld b,001h		;92f5
	call 07e25h		;92f7
	xor a			;92fa
	ld (ix+01eh),a		;92fb
	ld (ix+01dh),a		;92fe
	ld (ix+008h),010h		;9301
L_9305:
	dec (ix+008h)		;9305
	jr nz,L_930E		;9308
	ld (ix+01dh),001h		;930a
L_930E:
	ld a,(ix+005h)		;930e   ; lee la y de la figura
	bit 7,(ix+00dh)		;9311   ; mira el bit 7 de la velocidad vertical de la figura (alta)
	jr z,L_931E		;9315
	cp 020h		;9317
	call c,0b16fh		;9319   ; vuelta_vertical: la velocidad vertical al reves
	jr L_9323		;931c
L_931E:
	cp 0b0h		;931e
	call nc,0b16fh		;9320   ; vuelta_vertical: la velocidad vertical al reves
L_9323:
	ld a,(ix+007h)		;9323   ; lee la x de la figura
	bit 7,(ix+00fh)		;9326   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_9332		;932a
	cp 008h		;932c
	call c,0b15fh		;932e   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;9331
L_9332:
	cp 0e0h		;9332
	call nc,0b15fh		;9334   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;9337
anima_0c_66:		; cada 8 cuadros, dibujo XOR 0x0C y tamaño XOR 0x66
	ld a,(0e604h)		;9338   ; lee el contador de cuadros de partida
	and 007h		;933b
	ret nz			;933d
	ld d,00ch		;933e
	ld b,066h		;9340
	jp 0b0ddh		;9342   ; anima: el dibujo XOR D y el tamaño XOR B
tipo_28_cuadro:		; cada cuadro el tipo 0x28
	xor a			;9345   ; El tipo 0x28: cada cuadro
	ld (ix+01ch),a		;9346
	ld (ix+01dh),a		;9349
	call 07dddh		;934c   ; rebota_arriba_abajo: entre la y 0x28 y 0xB0 da la vuelta
	call tipo_28_vueltas		;934f   ; tipo_28_vueltas: los cambios de (ix+0x18) segun los choques (tablas 0x93AC, 0x93BC)
	dec (ix+015h)		;9352   ; baja las columnas de la figura que se pintan
	jr nz,L_936E		;9355
tipo_28_entra:		; al entrar el tipo 0x28
	call azar_5		;9357   ; El tipo 0x28: al entrar
	and 03fh		;935a
	add a,007h		;935c
	ld (ix+015h),a		;935e   ; guarda las columnas de la figura que se pintan
	call azar_5		;9361   ; azar_5: A = R con el contador de cuadros
	and 00fh		;9364
	ld (ix+018h),a		;9366
	ld b,003h		;9369
	call 07e25h		;936b
L_936E:
	ld a,(ix+018h)		;936e
	ld hl,0939ch		;9371
	call 04083h		;9374   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+00ah),a		;9377   ; guarda el dibujo (o el mosaico) de la figura
	ld hl,093cch		;937a
	jp 0b088h		;937d   ; tamano_c4: el tamaño (ix+0x11) del dibujo - 0xC4 de la tabla HL
tipo_28_vueltas:		; los cambios de (ix+0x18) segun los choques (tablas 0x93AC, 0x93BC)
	bit 0,(ix+01ch)		;9380
	ld hl,093ach		;9384
	call nz,siguiente_de_tabla		;9387   ; siguiente_de_tabla: (ix+0x18) = la tabla HL en (ix+0x18)
	bit 0,(ix+01dh)		;938a
	ret z			;938e
	ld hl,093bch		;938f
siguiente_de_tabla:		; (ix+0x18) = la tabla HL en (ix+0x18)
	ld a,(ix+018h)		;9392
	call 04083h		;9395   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+018h),a		;9398
	ret			;939b

; ----------------------------------------------------------------------
; DATOS dibujos_939c: 16 bytes que p05:9371 pone en (ix+0x0A) segun (ix+0x18)
;   0x939c..0x93ac  (16 bytes)
DATA_dibujos_939c:
	defb 0cch,0d0h,0d0h,0d0h,0c4h,0dch,0dch,0dch,0d8h,0e0h,0e0h,0e0h,0c8h,0d4h,0d4h,0d4h	; 939c  ................

; ----------------------------------------------------------------------
; DATOS siguiente_93ac: 16 bytes: el (ix+0x18) siguiente cuando el bit 0 de
;   (ix+0x1C) esta puesto (p05:9384)
;   0x93ac..0x93bc  (16 bytes)
DATA_siguiente_93ac:
	defb 008h,007h,006h,005h,00ch,003h,002h,001h,000h,00fh,00eh,00dh,004h,00bh,00ah,009h	; 93ac  ................

; ----------------------------------------------------------------------
; DATOS siguiente_93bc: 16 bytes: el (ix+0x18) siguiente cuando el bit 0 de
;   (ix+0x1D) esta puesto (p05:938F)
;   0x93bc..0x93cc  (16 bytes)
DATA_siguiente_93bc:
	defb 000h,00fh,00eh,00dh,00ch,00bh,00ah,009h,000h,007h,006h,005h,004h,003h,002h,001h	; 93bc  ................

; ----------------------------------------------------------------------
; DATOS ocho_bytes_93cc: 8 bytes que p05:937A pasa en HL a p06:B088
;   0x93cc..0x93d4  (8 bytes)
DATA_ocho_bytes_93cc:
	defb 062h,062h,063h,00dh,064h,063h,00ch,065h	; 93cc  bbc.dc.e

; ======================================================================
; CODIGO 0x93d4..0x9510  (316 bytes)
; ======================================================================


tipo_20_entra:		; al entrar el tipo 0x20
	ld de,00040h		;93d4   ; El tipo 0x20: al entrar
	call 0b13eh		;93d7   ; velocidad_de_lado: la velocidad de lado = DE
	ld a,r		;93da
	and 001h		;93dc
	call nz,0b15fh		;93de   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;93e1
tipo_20_cuadro:		; cada cuadro el tipo 0x20
	call 06beeh		;93e2   ; El tipo 0x20: cada cuadro
	jr nc,L_93EC		;93e5
	call 06c04h		;93e7   ; pared_delante: C con pared delante o en el borde
	jr nc,L_93FA		;93ea
L_93EC:
	bit 7,(ix+00fh)		;93ec   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld de,00040h		;93f0
	call 0b13eh		;93f3   ; velocidad_de_lado: la velocidad de lado = DE
	ret nz			;93f6
	jp 0b15fh		;93f7   ; vuelta_de_lado: la velocidad de lado al reves
L_93FA:
	ld a,(0e507h)		;93fa   ; lee la x del personaje
	sub (ix+007h)		;93fd   ; le resta la x de la figura
	jr nc,L_9404		;9400
	neg		;9402
L_9404:
	cp 050h		;9404
	ret nc			;9406
	bit 7,(ix+00fh)		;9407   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_941E		;940b
	call 06c25h		;940d   ; a_la_altura: C si el personaje esta a la altura de la figura (+-4)
	ret nc			;9410
	ld a,(0e507h)		;9411   ; lee la x del personaje
	cp (ix+007h)		;9414   ; compara con la x de la figura
	call c,velocidad_100		;9417   ; velocidad_100: velocidad de lado 0x100
	call c,0b15fh		;941a   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;941d
L_941E:
	ld a,(0e507h)		;941e   ; lee la x del personaje
	cp (ix+007h)		;9421   ; compara con la x de la figura
	ret c			;9424
	call 06c25h		;9425   ; a_la_altura: C si el personaje esta a la altura de la figura (+-4)
	ret nc			;9428
velocidad_100:		; velocidad de lado 0x100
	ld de,00100h		;9429
	jp 0b13eh		;942c   ; velocidad_de_lado: la velocidad de lado = DE
tipo_1f_entra:		; al entrar el tipo 0x1F
	call espera_azar_7f		;942f   ; El tipo 0x1F: al entrar
	call lado_al_azar		;9432   ; lado_al_azar: (ix+0x1D) al azar
	ld de,00100h		;9435
	call 0b145h		;9438   ; gravedad: la gravedad = DE
L_943B:
	ld a,0a0h		;943b
	ld de,003a0h		;943d
	bit 0,(ix+01dh)		;9440
	jr z,L_944F		;9444
	ld a,0ach		;9446
	ld de,0fc60h		;9448
	ld (ix+011h),013h		;944b   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x13
L_944F:
	ld (ix+00ah),a		;944f   ; guarda el dibujo (o el mosaico) de la figura
	jp 0b13eh		;9452   ; velocidad_de_lado: la velocidad de lado = DE
tipo_1f_cuadro:		; cada cuadro el tipo 0x1F
	ld a,(ix+001h)		;9455   ; El tipo 0x1F: cada cuadro
	dec a			;9458
	jr z,L_9490		;9459
	jp p,L_94D0		;945b
	call anda_o_salta		;945e   ; anda_o_salta: anda; en el borde o la pared, salta o da la vuelta
	dec (ix+008h)		;9461
	jr z,L_947D		;9464
	ret			;9466
anda_o_salta:		; anda; en el borde o la pared, salta o da la vuelta
	call anima_lado_13		;9467   ; anima_lado_13: cada 8 cuadros el dibujo segun el lado
	call 06beeh		;946a   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_9473		;946d
	call 06c04h		;946f   ; pared_delante: C con pared delante o en el borde
	ret nc			;9472
L_9473:
	call salto_2c_e2		;9473   ; salto_2c_e2: el salto con D = 0x2C, E = 0xE2
	jr c,L_949E		;9476
	call cuenta_y_lado		;9478   ; cuenta_y_lado: (ix+0x18) menos uno y el lado al reves
	jr L_943B		;947b
L_947D:
	ld a,r		;947d
	and 003h		;947f
	cp 003h		;9481
	jr nz,L_9486		;9483
	xor a			;9485
L_9486:
	ld (ix+01eh),a		;9486
L_9489:
	ld (ix+018h),006h		;9489
	jp paso_siguiente_de_figura		;948d   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9490:
	call salta_si_puede		;9490   ; salta_si_puede: salta si la tabla 0x9ADF lo deja
	jr c,L_949F		;9493
	call anda_o_salta		;9495   ; anda_o_salta: anda; en el borde o la pared, salta o da la vuelta
	call puede_saltar		;9498   ; puede_saltar: C si (ix+0x18) deja saltar
	jr nc,L_94DD		;949b
	ret			;949d
L_949E:
	pop hl			;949e
L_949F:
	ld a,(ix+01eh)		;949f
	bit 0,a		;94a2
	ld de,0f700h		;94a4
	jr nz,L_94AC		;94a7
	ld de,0fc00h		;94a9
L_94AC:
	call 0b137h		;94ac   ; velocidad_vertical: la velocidad vertical = DE
	add a,a			;94af
	add a,(ix+01dh)		;94b0
	ld hl,09510h		;94b3
	call 04053h		;94b6   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call 0b13eh		;94b9   ; velocidad_de_lado: la velocidad de lado = DE
	ld a,0a8h		;94bc
	bit 0,(ix+01dh)		;94be
	jr z,L_94C6		;94c2
	ld a,0b4h		;94c4
L_94C6:
	call 07973h		;94c6   ; tamano_0: el tamaño 0
	ld (ix+001h),002h		;94c9   ; el paso de la figura = 0x02
	jp 07083h		;94cd
L_94D0:
	call cae_hasta_6		;94d0   ; cae_hasta_6: cae hasta la velocidad 6
	call suelo_delante_5		;94d3   ; suelo_delante_5: C si hay suelo delante
	ret nc			;94d6
	call y_a_la_casilla_5		;94d7   ; y_a_la_casilla_5: la y ajustada a la casilla
	call anda_o_salta		;94da   ; anda_o_salta: anda; en el borde o la pared, salta o da la vuelta
L_94DD:
	call espera_azar_7f		;94dd   ; espera_azar_7f: una espera al azar 0-0x7F
	call 06bd5h		;94e0   ; paso_0_figura: el paso a 0
	call 0b129h		;94e3   ; sin_vertical: la velocidad vertical a 0
	jp L_943B		;94e6
anima_lado_13:		; cada 8 cuadros el dibujo segun el lado
	ld d,004h		;94e9
	ld a,(ix+01dh)		;94eb
	and a			;94ee
	jr z,L_94F3		;94ef
	ld d,01ch		;94f1
L_94F3:
	ld b,013h		;94f3
	jp 0b17fh		;94f5   ; anima_cada_8: cada 8 cuadros, el dibujo XOR D
salto_2c_e2:		; el salto con D = 0x2C, E = 0xE2
	ld d,02ch		;94f8
	ld e,0e2h		;94fa
	jp L_9A77		;94fc
puede_saltar:		; C si (ix+0x18) deja saltar
	ld a,(ix+018h)		;94ff
	cp 0ffh		;9502
	ret z			;9504
	cp 005h		;9505
	ccf			;9507
	ret c			;9508
	rra			;9509
	ret c			;950a
	call 07be9h		;950b
	scf			;950e
	ret			;950f

; ----------------------------------------------------------------------
; DATOS seis_velocidades: 6 palabras que p05:94B3 elige con 2 x n + (ix+0x1D)
;   y pasa a p06:B13E
;   0x9510..0x951c  (12 bytes)
DATA_seis_velocidades:
	defb 030h,003h	; 9510
	defb 0d0h,0fch	; 9512
	defb 060h,003h	; 9514
	defb 0c0h,0fch	; 9516
	defb 030h,003h	; 9518
	defb 0d0h,0fch	; 951a

; ======================================================================
; CODIGO 0x951c..0x9720  (516 bytes)
; ======================================================================


tipo_17_entra:		; al entrar el tipo 0x17
	ld a,r		;951c   ; El tipo 0x17: al entrar
	and 001h		;951e
	ld de,00200h		;9520
	call nz,04068h		;9523   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;9526   ; velocidad_de_lado: la velocidad de lado = DE
L_9529:
	bit 7,(ix+00fh)		;9529   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld a,0c8h		;952d
	ld b,000h		;952f
	jr z,L_9536		;9531
	ld a,0d0h		;9533
	inc b			;9535
L_9536:
	ld (ix+014h),b		;9536
	ld (ix+011h),013h		;9539   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x13
	jp 07083h		;953d
tipo_17_cuadro:		; cada cuadro el tipo 0x17
	ld a,(ix+001h)		;9540   ; El tipo 0x17: cada cuadro
	dec a			;9543
	jr z,L_9579		;9544
	jp p,L_9598		;9546
	call anima_1a_4		;9549   ; anima_1a_4: cada 8 cuadros, dibujo XOR 4
	call 06beeh		;954c   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_9592		;954f
	call 06c04h		;9551   ; pared_delante: C con pared delante o en el borde
	jr c,L_9592		;9554
	call 06c25h		;9556   ; a_la_altura: C si el personaje esta a la altura de la figura (+-4)
	ret nc			;9559
	ld (ix+015h),01eh		;955a   ; las columnas de la figura que se pintan = 0x1E
	call 06b71h		;955e   ; quita_bit_4_figura: quita el bit 4 de las banderas
	ld b,000h		;9561
	ld c,0c8h		;9563
	ld a,(0e507h)		;9565   ; lee la x del personaje
	cp (ix+007h)		;9568   ; compara con la x de la figura
	jr nc,L_9570		;956b
	inc b			;956d
	ld c,0d0h		;956e
L_9570:
	ld (ix+00ah),c		;9570   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+014h),b		;9573
	jp paso_siguiente_de_figura		;9576   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9579:
	dec (ix+015h)		;9579   ; baja las columnas de la figura que se pintan
	ret nz			;957c
	ld (ix+015h),078h		;957d   ; las columnas de la figura que se pintan = 0x78
	ld b,(ix+014h)		;9581
	ld e,(ix+007h)		;9584   ; lee la x de la figura
	ld d,(ix+005h)		;9587   ; lee la y de la figura
	ld a,047h		;958a
	call 06551h		;958c   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
	jp paso_siguiente_de_figura		;958f   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9592:
	call 0b15fh		;9592   ; vuelta_de_lado: la velocidad de lado al reves
	jp L_9529		;9595
L_9598:
	dec (ix+015h)		;9598   ; baja las columnas de la figura que se pintan
	ret nz			;959b
	call 06b76h		;959c   ; pon_bit_4_figura: pone el bit 4 de las banderas
	call 06bd5h		;959f   ; paso_0_figura: el paso a 0
	jp L_9529		;95a2
anima_1a_4:		; cada 8 cuadros, dibujo XOR 4
	ld b,01ah		;95a5
	ld d,004h		;95a7
	jp 0b17fh		;95a9   ; anima_cada_8: cada 8 cuadros, el dibujo XOR D
tipo_47_entra:		; al entrar el tipo 0x47
	ld a,(0e624h)		;95ac   ; El tipo 0x47: al entrar
	ld (ix+014h),a		;95af
	ld a,(0e507h)		;95b2   ; lee la x del personaje
	ld (ix+01ah),a		;95b5
	ld a,(ix+009h)		;95b8   ; lee la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	xor 045h		;95bb
	ld (ix+009h),a		;95bd   ; guarda la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	call velocidad_por_distancia		;95c0   ; velocidad_por_distancia: la velocidad segun la distancia al personaje
	ld (ix+008h),c		;95c3
	ret			;95c6
tipo_47_cuadro:		; cada cuadro el tipo 0x47
	ld a,(ix+001h)		;95c7   ; El tipo 0x47: cada cuadro
	dec a			;95ca
	jr z,L_9603		;95cb
	jp p,L_9633		;95cd
	ld a,(ix+007h)		;95d0   ; lee la x de la figura
	bit 7,(ix+00fh)		;95d3   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr nz,L_95E0		;95d7
	cp (ix+01ah)		;95d9
	jr nc,L_95F4		;95dc
	jr L_95E5		;95de
L_95E0:
	cp (ix+01ah)		;95e0
	jr c,L_95F4		;95e3
L_95E5:
	call velocidad_por_distancia		;95e5   ; velocidad_por_distancia: la velocidad segun la distancia al personaje
	call anima_4_c		;95e8   ; anima_4_c: anima con D = 4, E = C
	call 06beeh		;95eb   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_95F4		;95ee
	call 06c04h		;95f0   ; pared_delante: C con pared delante o en el borde
	ret nc			;95f3
L_95F4:
	call 06b71h		;95f4   ; quita_bit_4_figura: quita el bit 4 de las banderas
	ld a,r		;95f7
	and 01fh		;95f9
	add a,020h		;95fb
	ld (ix+015h),a		;95fd   ; guarda las columnas de la figura que se pintan
	jp paso_siguiente_de_figura		;9600   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9603:
	dec (ix+015h)		;9603   ; baja las columnas de la figura que se pintan
	ret nz			;9606
	ld (ix+009h),0c4h		;9607   ; la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A) = 0xC4
	ld (ix+00bh),006h		;960b   ; el ancho del mosaico = 0x06
	ld (ix+00ah),00ah		;960f   ; el dibujo (o el mosaico) de la figura = 0x0A
	ld (ix+011h),03dh		;9613   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x3D
	ld (ix+015h),010h		;9617   ; las columnas de la figura que se pintan = 0x10
	ld a,(ix+007h)		;961b   ; lee la x de la figura
	sub 008h		;961e
	ld (ix+007h),a		;9620   ; guarda la x de la figura
	ld a,(ix+005h)		;9623   ; lee la y de la figura
	sub 008h		;9626
	ld (ix+005h),a		;9628   ; guarda la y de la figura
	ld a,018h		;962b
	call 04059h		;962d   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp paso_siguiente_de_figura		;9630   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9633:
	dec (ix+015h)		;9633   ; baja las columnas de la figura que se pintan
	jp z,0b41ch		;9636   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	ld a,(ix+015h)		;9639   ; lee las columnas de la figura que se pintan
	cp 008h		;963c
	ret nz			;963e
	ld (ix+00ah),00bh		;963f   ; el dibujo (o el mosaico) de la figura = 0x0B
	ld (ix+011h),05bh		;9643   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x5B
	ret			;9647
anima_4_c:		; anima con D = 4, E = C
	ld d,004h		;9648
	ld e,c			;964a
	ld b,001h		;964b
	jp 0b0d6h		;964d   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
velocidad_por_distancia:		; la velocidad segun la distancia al personaje
	ld a,(ix+007h)		;9650   ; lee la x de la figura
	sub (ix+01ah)		;9653
	jr nc,L_965A		;9656
	neg		;9658
L_965A:
	ld c,012h		;965a
	ld de,00100h		;965c
	cp 028h		;965f
	jr c,L_968C		;9661
	ld c,00fh		;9663
	ld de,00180h		;9665
	cp 048h		;9668
	jr c,L_968C		;966a
	ld c,00ch		;966c
	ld de,00200h		;966e
	cp 060h		;9671
	jr c,L_968C		;9673
	ld c,009h		;9675
	ld de,00280h		;9677
	cp 074h		;967a
	jr c,L_968C		;967c
	ld c,006h		;967e
	ld de,00300h		;9680
	cp 084h		;9683
	jr c,L_968C		;9685
	ld c,003h		;9687
	ld de,00380h		;9689
L_968C:
	bit 0,(ix+014h)		;968c
	call nz,04068h		;9690   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;9693   ; velocidad_de_lado: la velocidad de lado = DE
tipo_2a_cuadro:		; cada cuadro el tipo 0x2A
	dec (ix+008h)		;9696   ; El tipo 0x2A: cada cuadro
	ret nz			;9699
tipo_2a_entra:		; al entrar el tipo 0x2A
	ld (ix+008h),010h		;969a   ; El tipo 0x2A: al entrar
	bit 7,(ix+002h)		;969e   ; mira el bit 7 de las banderas de la figura (bit 7: en pantalla)
	call nz,banderas_bajas		;96a2   ; banderas_bajas: solo los 4 bits bajos de las banderas
	call sitio_al_azar		;96a5   ; sitio_al_azar: un sitio al azar de la tabla 0x9720
	ret nc			;96a8
	jr L_96EE		;96a9
sitio_al_azar:		; un sitio al azar de la tabla 0x9720
	call azar_5		;96ab   ; azar_5: A = R con el contador de cuadros
	and 003h		;96ae
	ld b,a			;96b0
	call azar_5		;96b1   ; azar_5: A = R con el contador de cuadros
	and 001h		;96b4
	add a,b			;96b6
	ld hl,09720h		;96b7
	call 04083h		;96ba   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	push af			;96bd
L_96BE:
	call azar_5		;96be   ; azar_5: A = R con el contador de cuadros
	or 010h		;96c1
	and 0f0h		;96c3
	ld h,a			;96c5
	sub 020h		;96c6
	cp 0b0h		;96c8
	jr nc,L_96BE		;96ca
	ld (ix+01eh),h		;96cc
	pop af			;96cf
	ld (ix+01fh),a		;96d0
	add a,010h		;96d3
	ld l,a			;96d5
	call 0406eh		;96d6   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret nc			;96d9
	inc hl			;96da
	cp (hl)			;96db
	ret nc			;96dc
	call suelo_en_1e_1f		;96dd   ; suelo_en_1e_1f: C si hay suelo en la casilla de (ix+0x1E, 0x1F)
	ret nc			;96e0
	ld a,(ix+01eh)		;96e1
	ld (ix+007h),a		;96e4   ; guarda la x de la figura
	ld a,(ix+01fh)		;96e7
L_96EA:
	ld (ix+005h),a		;96ea   ; guarda la y de la figura
	ret			;96ed
L_96EE:
	ld a,0f0h		;96ee
	or (ix+002h)		;96f0   ; OR con las banderas de la figura (bit 7: en pantalla)
	jr L_96FA		;96f3
banderas_bajas:		; solo los 4 bits bajos de las banderas
	ld a,(ix+002h)		;96f5   ; lee las banderas de la figura (bit 7: en pantalla)
	and 00fh		;96f8
L_96FA:
	ld (ix+002h),a		;96fa   ; guarda las banderas de la figura (bit 7: en pantalla)
	ret			;96fd
suelo_en_1e_1f:		; C si hay suelo en la casilla de (ix+0x1E, 0x1F)
	ld h,(ix+01eh)		;96fe
	ld l,(ix+01fh)		;9701
	jr L_970C		;9704
L_9706:
	ld h,(ix+007h)		;9706   ; lee la x de la figura
	ld l,(ix+005h)		;9709   ; lee la y de la figura
L_970C:
	call 0406eh		;970c   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ccf			;970f
	ret nc			;9710
	inc hl			;9711
	cp (hl)			;9712
	ccf			;9713
	ret nc			;9714
	ld bc,0001fh		;9715
	add hl,bc			;9718
	cp (hl)			;9719
	ccf			;971a
	ret nc			;971b
	inc hl			;971c
	cp (hl)			;971d
	ccf			;971e
	ret			;971f

; ----------------------------------------------------------------------
; DATOS cinco_bytes_9720: 5 bytes que p05:96B7 elige al azar (0-4)
;   0x9720..0x9725  (5 bytes)
DATA_cinco_bytes_9720:
	defb 028h,048h,068h,088h,0a8h	; 9720

; ======================================================================
; CODIGO 0x9725..0x975a  (53 bytes)
; ======================================================================


tipo_2d_entra:		; al entrar el tipo 0x2D
	call espera_azar_7f		;9725   ; El tipo 0x2D: al entrar
	ld a,r		;9728
	and 001h		;972a
salta_hacia_a:		; salta hacia el lado A: velocidad 0x180 y gravedad 0x40
	ld (ix+01dh),a		;972c
	ld de,00180h		;972f
	call nz,04068h		;9732   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;9735   ; velocidad_de_lado: la velocidad de lado = DE
	ld de,00040h		;9738
	call 0b145h		;973b   ; gravedad: la gravedad = DE
L_973E:
	bit 7,(ix+00fh)		;973e   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld a,0a0h		;9742
	ld b,00ch		;9744
	jr z,L_974C		;9746
	ld a,0ach		;9748
	ld b,00dh		;974a
L_974C:
	ld (ix+00ah),a		;974c   ; guarda el dibujo (o el mosaico) de la figura
	ld (ix+011h),b		;974f   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	and a			;9752
	ret			;9753
tipo_2d_cuadro:		; cada cuadro el tipo 0x2D
	ld a,(ix+001h)		;9754   ; El tipo 0x2D: cada cuadro
	call 04050h		;9757   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_975A: 6 destinos del despachador de 0x4140 (call en p05:9757):
;   0x9766, 0x97E7, 0x980A, 0x9834, 0x985C, 0x97B3; lo leen p05:9757 (12
;   bytes)
;   0x975a..0x9766  (12 bytes)
DATA_tabla_975A:
	defb 066h,097h	; 975a
	defb 0e7h,097h	; 975c
	defb 00ah,098h	; 975e
	defb 034h,098h	; 9760
	defb 05ch,098h	; 9762
	defb 0b3h,097h	; 9764

; ======================================================================
; CODIGO 0x9766..0x991f  (441 bytes)
; ======================================================================


L_9766:
	dec (ix+008h)		;9766
	jp z,L_947D		;9769
anda_y_mira:		; anda; si el personaje esta a su altura, va hacia el
	call anima_cada_8_lado		;976c   ; anima_cada_8_lado: cada 8 cuadros el dibujo segun el lado
	call 06beeh		;976f   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_978A		;9772
	call 06c04h		;9774   ; pared_delante: C con pared delante o en el borde
	jr c,L_978A		;9777
	ld a,(0e500h)		;9779   ; lee el estado del personaje (5 = hundirse)
	cp 006h		;977c
	ret z			;977e
	ld a,(0e505h)		;977f   ; lee la y del personaje
	sub 010h		;9782
	cp (ix+005h)		;9784   ; compara con la y de la figura
	jr z,L_9798		;9787
	ret			;9789
L_978A:
	call salto_24_dc		;978a   ; salto_24_dc: el salto con D = 0x24, E = 0xDC
	jp c,L_97F6		;978d
vuelta_y_paso:		; da la vuelta
	call 0b15fh		;9790   ; vuelta_de_lado: la velocidad de lado al reves
	call cuenta_y_lado		;9793   ; cuenta_y_lado: (ix+0x18) menos uno y el lado al reves
	jr $-88		;9796
L_9798:
	ld (ix+015h),01eh		;9798   ; las columnas de la figura que se pintan = 0x1E
	ld (ix+001h),005h		;979c   ; el paso de la figura = 0x05
	call 06b71h		;97a0   ; quita_bit_4_figura: quita el bit 4 de las banderas
	ld a,(0e507h)		;97a3   ; lee la x del personaje
	cp (ix+007h)		;97a6   ; compara con la x de la figura
	ld a,001h		;97a9
	jr c,L_97AE		;97ab
	xor a			;97ad
L_97AE:
	call salta_hacia_a		;97ae   ; salta_hacia_a: salta hacia el lado A: velocidad 0x180 y gravedad 0x40
	scf			;97b1
	ret			;97b2
L_97B3:
	dec (ix+015h)		;97b3   ; baja las columnas de la figura que se pintan
	ret nz			;97b6
	ld (ix+015h),03ch		;97b7   ; las columnas de la figura que se pintan = 0x3C
	ld (ix+001h),003h		;97bb   ; el paso de la figura = 0x03
	ld b,000h		;97bf
	ld hl,00400h		;97c1
	ld c,0a4h		;97c4
	bit 7,(ix+00fh)		;97c6   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_97D2		;97ca
	inc b			;97cc
	ld hl,0fc00h		;97cd
	ld c,0b0h		;97d0
L_97D2:
	ld (ix+00ah),c		;97d2   ; guarda el dibujo (o el mosaico) de la figura
	ld e,(ix+007h)		;97d5   ; lee la x de la figura
	ld d,(ix+005h)		;97d8   ; lee la y de la figura
	ld a,03fh		;97db
	call 06551h		;97dd   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
	ld a,005h		;97e0
	call 04059h		;97e2   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	scf			;97e5
	ret			;97e6
L_97E7:
	call salta_si_puede		;97e7   ; salta_si_puede: salta si la tabla 0x9ADF lo deja
	jr c,L_97F6		;97ea
	call anda_y_mira		;97ec   ; anda_y_mira: anda; si el personaje esta a su altura, va hacia el
	ret c			;97ef
	call puede_saltar		;97f0   ; puede_saltar: C si (ix+0x18) deja saltar
	jr nc,L_9818		;97f3
	ret			;97f5
L_97F6:
	bit 0,(ix+01eh)		;97f6
	ld de,0fb80h		;97fa
	jr nz,L_9802		;97fd
	ld de,0fd80h		;97ff
L_9802:
	call 0b137h		;9802   ; velocidad_vertical: la velocidad vertical = DE
	ld (ix+001h),002h		;9805   ; el paso de la figura = 0x02
	ret			;9809
L_980A:
	call cae_hasta_6		;980a   ; cae_hasta_6: cae hasta la velocidad 6
	ret nz			;980d
	call suelo_delante_5		;980e   ; suelo_delante_5: C si hay suelo delante
	ret nc			;9811
	call y_a_la_casilla_5		;9812   ; y_a_la_casilla_5: la y ajustada a la casilla
	call anda_y_mira		;9815   ; anda_y_mira: anda; si el personaje esta a su altura, va hacia el
L_9818:
	call 06b76h		;9818   ; pon_bit_4_figura: pone el bit 4 de las banderas
	call espera_azar_7f		;981b   ; espera_azar_7f: una espera al azar 0-0x7F
	call 06bd5h		;981e   ; paso_0_figura: el paso a 0
	call 0b129h		;9821   ; sin_vertical: la velocidad vertical a 0
	bit 7,(ix+00fh)		;9824   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld de,00180h		;9828
	call nz,04068h		;982b   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;982e   ; velocidad_de_lado: la velocidad de lado = DE
	jp L_973E		;9831
L_9834:
	dec (ix+015h)		;9834   ; baja las columnas de la figura que se pintan
	jr z,L_9818		;9837
	ld a,(0e500h)		;9839   ; lee el estado del personaje (5 = hundirse)
	cp 006h		;983c
	ret nz			;983e
	call 06b76h		;983f   ; pon_bit_4_figura: pone el bit 4 de las banderas
	ld a,(0e507h)		;9842   ; lee la x del personaje
	cp (ix+007h)		;9845   ; compara con la x de la figura
	ld a,000h		;9848
	ld de,00400h		;984a
	jr nc,L_9853		;984d
	inc a			;984f
	ld de,0fc00h		;9850
L_9853:
	ld (ix+01dh),a		;9853
	call 0b13eh		;9856   ; velocidad_de_lado: la velocidad de lado = DE
	jp paso_siguiente_de_figura		;9859   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_985C:
	call anima_cada_4_lado		;985c   ; anima_cada_4_lado: cada 4 cuadros el dibujo segun el lado
	call 06beeh		;985f   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_9868		;9862
	call 06c04h		;9864   ; pared_delante: C con pared delante o en el borde
	ret nc			;9867
L_9868:
	call vuelta_y_paso		;9868   ; vuelta_y_paso: da la vuelta
	jr L_9818		;986b
anima_cada_8_lado:		; cada 8 cuadros el dibujo segun el lado
	ld c,007h		;986d
	jr L_9873		;986f
anima_cada_4_lado:		; cada 4 cuadros el dibujo segun el lado
	ld c,003h		;9871
L_9873:
	ld a,(0e604h)		;9873   ; lee el contador de cuadros de partida
	and c			;9876
	ret nz			;9877
	bit 7,(ix+00fh)		;9878   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld b,00ch		;987c
	ld d,004h		;987e
	jr z,L_9886		;9880
	ld b,00dh		;9882
	ld d,01ch		;9884
L_9886:
	jp 0b0ddh		;9886   ; anima: el dibujo XOR D y el tamaño XOR B
salto_24_dc:		; el salto con D = 0x24, E = 0xDC
	ld d,024h		;9889
	ld e,0dch		;988b
	jp L_9A77		;988d
tipo_3f_entra:		; al entrar el tipo 0x3F
	call 06c42h		;9890   ; El tipo 0x3F: al entrar
	ld a,(0e624h)		;9893
	or a			;9896
	ret z			;9897
	ld (ix+00ah),0b4h		;9898   ; el dibujo (o el mosaico) de la figura = 0xB4
	ld (ix+011h),021h		;989c   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x21
	ret			;98a0
L_98A1:
	ld a,(ix+000h)		;98a1   ; lee el tipo de la figura
	cp 06ah		;98a4
	ret z			;98a6
tipos_1d_y_mas_cuadro:		; cada cuadro los tipos 0x1D, 0x1E, 0x33, 0x3F
	bit 7,(ix+00fh)		;98a7   ; Los tipos 0x1D, 0x1E, 0x33, 0x3F: cada cuadro
	ld b,0ffh		;98ab
	jr nz,L_98B1		;98ad
	ld b,010h		;98af
L_98B1:
	ld a,(ix+007h)		;98b1   ; lee la x de la figura
	add a,b			;98b4
	ld h,a			;98b5
	ld l,(ix+005h)		;98b6   ; lee la y de la figura
	call 0406eh		;98b9   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jp c,0b41ch		;98bc   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	ret			;98bf
tipo_25_entra:		; al entrar el tipo 0x25
	set 1,(ix+002h)		;98c0   ; El tipo 0x25: al entrar
	call espera_azar_7f		;98c4   ; espera_azar_7f: una espera al azar 0-0x7F
	call 07ca9h		;98c7   ; lado_del_personaje_1d: (ix+0x1D) = 1 si el personaje esta a la derecha
	ld de,00050h		;98ca
	call 0b145h		;98cd   ; gravedad: la gravedad = DE
	call espera_20_9f		;98d0   ; espera_20_9f: (ix+0x1A) = 0x20 + azar
L_98D3:
	bit 0,(ix+01dh)		;98d3
	ld de,00120h		;98d7
	call nz,04068h		;98da   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;98dd   ; velocidad_de_lado: la velocidad de lado = DE
L_98E0:
	bit 0,(ix+01dh)		;98e0
	ld a,0ach		;98e4
	ld bc,0b4aah		;98e6
	ld d,04eh		;98e9
	jr z,L_98F7		;98eb
	ld a,0b8h		;98ed
	ld bc,0c0b2h		;98ef
	inc d			;98f2
	set 0,(ix+002h)		;98f3   ; pone a uno el bit 0 de las banderas de la figura (bit 7: en pantalla)
L_98F7:
	ld e,00fh		;98f7
L_98F9:
	ld (ix+012h),b		;98f9
	ld (ix+009h),c		;98fc   ; guarda la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	ld (ix+011h),d		;98ff   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	ld (ix+013h),e		;9902
	jp 07083h		;9905
tipo_25_cuadro:		; cada cuadro el tipo 0x25
	ld a,(ix+001h)		;9908   ; El tipo 0x25: cada cuadro
	cp 006h		;990b
	jr z,L_9913		;990d
	cp 002h		;990f
	jr nc,L_9919		;9911
L_9913:
	ld a,(ix+01ch)		;9913
	and a			;9916
	jr nz,$+73		;9917
L_9919:
	ld a,(ix+001h)		;9919   ; lee el paso de la figura
	call 04050h		;991c   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_991F: 7 destinos del despachador de 0x4140 (call en p05:991C):
;   0x992D, 0x997A, 0x99A8, 0x99E1, 0x9A0B, 0x9A18, 0x9A39; lo leen p05:991C
;   (14 bytes)
;   0x991f..0x992d  (14 bytes)
DATA_tabla_991F:
	defb 02dh,099h	; 991f
	defb 07ah,099h	; 9921
	defb 0a8h,099h	; 9923
	defb 0e1h,099h	; 9925
	defb 00bh,09ah	; 9927
	defb 018h,09ah	; 9929
	defb 039h,09ah	; 992b

; ======================================================================
; CODIGO 0x992d..0x9a61  (308 bytes)
; ======================================================================


L_992D:
	call anda_tipo_3f		;992d   ; anda_tipo_3f: anda; en el borde baja o da la vuelta
	dec (ix+008h)		;9930
	jp z,L_947D		;9933
	dec (ix+01ah)		;9936
	jr z,L_9955		;9939
	ret			;993b
anda_tipo_3f:		; anda; en el borde baja o da la vuelta
	call dibujo_ac_b8		;993c   ; dibujo_ac_b8: cada 4 cuadros el dibujo 0xAC o 0xB8
	call 06beeh		;993f   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_9948		;9942
	call 07c5eh		;9944   ; suelo_o_escalera: C si debajo hay suelo (0xBA o mas) o escalera (0xD2)
	ret nc			;9947
L_9948:
	call salto_30_e0		;9948   ; salto_30_e0: el salto con D = 0x30, E = 0xE0
	jr c,L_9988		;994b
	call 0b15fh		;994d   ; vuelta_de_lado: la velocidad de lado al reves
	call cambia_banderas_y_lado		;9950   ; cambia_banderas_y_lado: el bit 0 de las banderas y el lado (ix+0x1D)
	jr $-115		;9953
L_9955:
	call 06b71h		;9955   ; quita_bit_4_figura: quita el bit 4 de las banderas
	call espera_20_9f		;9958   ; espera_20_9f: (ix+0x1A) = 0x20 + azar
	ld (ix+001h),006h		;995b   ; el paso de la figura = 0x06
	ret			;995f
L_9960:
	ld (ix+019h),003h		;9960
	ld (ix+01bh),03ch		;9964
	ld (ix+001h),003h		;9968   ; el paso de la figura = 0x03
	ld a,(ix+002h)		;996c   ; lee las banderas de la figura (bit 7: en pantalla)
	and 0afh		;996f
	ld (ix+002h),a		;9971   ; guarda las banderas de la figura (bit 7: en pantalla)
	call 07a3dh		;9974   ; cambia_ficha_3: la ficha XOR 3
	jp L_99E7		;9977
L_997A:
	call salta_si_puede		;997a   ; salta_si_puede: salta si la tabla 0x9ADF lo deja
	jr c,L_9988		;997d
	call anda_tipo_3f		;997f   ; anda_tipo_3f: anda; en el borde baja o da la vuelta
	call puede_saltar		;9982   ; puede_saltar: C si (ix+0x18) deja saltar
	jr nc,L_99B6		;9985
	ret			;9987
L_9988:
	ld (ix+001h),002h		;9988   ; el paso de la figura = 0x02
	bit 0,(ix+01eh)		;998c
	ld de,0fbb0h		;9990
	jr nz,L_9998		;9993
	ld de,0fe30h		;9995
L_9998:
	call 0b137h		;9998   ; velocidad_vertical: la velocidad vertical = DE
	ld de,00200h		;999b
	bit 0,(ix+01dh)		;999e
	call nz,04068h		;99a2   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;99a5   ; velocidad_de_lado: la velocidad de lado = DE
L_99A8:
	call cae_hasta_6		;99a8   ; cae_hasta_6: cae hasta la velocidad 6
	ret nz			;99ab
	call suelo_delante_5		;99ac   ; suelo_delante_5: C si hay suelo delante
	ret nc			;99af
	call y_a_la_casilla_5		;99b0   ; y_a_la_casilla_5: la y ajustada a la casilla
L_99B3:
	call anda_tipo_3f		;99b3   ; anda_tipo_3f: anda; en el borde baja o da la vuelta
L_99B6:
	call 06b76h		;99b6   ; pon_bit_4_figura: pone el bit 4 de las banderas
	set 6,(ix+002h)		;99b9   ; pone a uno el bit 6 de las banderas de la figura (bit 7: en pantalla)
	call espera_azar_7f		;99bd   ; espera_azar_7f: una espera al azar 0-0x7F
	call 06bd5h		;99c0   ; paso_0_figura: el paso a 0
	call 0b129h		;99c3   ; sin_vertical: la velocidad vertical a 0
	jp L_98D3		;99c6
suelo_delante_5:		; C si hay suelo delante
	ld a,(ix+005h)		;99c9   ; lee la y de la figura
	add a,010h		;99cc
	ld l,a			;99ce
	bit 0,(ix+01dh)		;99cf
	ld e,004h		;99d3
	jr z,L_99D9		;99d5
	ld e,00ch		;99d7
L_99D9:
	ld a,(ix+007h)		;99d9   ; lee la x de la figura
	add a,e			;99dc
	ld h,a			;99dd
	jp 0406eh		;99de   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
L_99E1:
	ld a,(ix+01ch)		;99e1
	and a			;99e4
	jr z,L_9A0B		;99e5
L_99E7:
	ld a,01fh		;99e7
	call 04059h		;99e9   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld (ix+01ch),000h		;99ec
	dec (ix+019h)		;99f0
	push af			;99f3
L_99F4:
	ld a,(ix+019h)		;99f4
	ld hl,09a61h		;99f7
	call 04053h		;99fa   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	call 0736fh		;99fd
	pop af			;9a00
	ld (ix+01bh),03ch		;9a01
	jr nz,L_9A0B		;9a05
paso_siguiente_de_figura:		; sube el paso (ix+1)
	inc (ix+001h)		;9a07   ; sube el paso de la figura
	ret			;9a0a
L_9A0B:
	dec (ix+01bh)		;9a0b
	ret nz			;9a0e
	ld (ix+001h),005h		;9a0f   ; el paso de la figura = 0x05
	ld (ix+01bh),018h		;9a13
	ret			;9a17
L_9A18:
	ld (ix+01ch),000h		;9a18
	dec (ix+01bh)		;9a1c
	ld a,(ix+01bh)		;9a1f
	and 007h		;9a22
	ret nz			;9a24
	inc (ix+019h)		;9a25
	ld a,(ix+019h)		;9a28
	cp 003h		;9a2b
	jr z,L_9A32		;9a2d
	push af			;9a2f
	jr L_99F4		;9a30
L_9A32:
	ld (ix+010h),008h		;9a32   ; la vida de la figura = 0x08
	jp L_99B3		;9a36
L_9A39:
	dec (ix+01ah)		;9a39
	ret nz			;9a3c
	call espera_20_9f		;9a3d   ; espera_20_9f: (ix+0x1A) = 0x20 + azar
	call 06b76h		;9a40   ; pon_bit_4_figura: pone el bit 4 de las banderas
	jp 06bd5h		;9a43   ; paso_0_figura: el paso a 0
dibujo_ac_b8:		; cada 4 cuadros el dibujo 0xAC o 0xB8
	bit 7,(ix+00fh)		;9a46   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld a,0ach		;9a4a
	jr z,L_9A50		;9a4c
	ld a,0b8h		;9a4e
L_9A50:
	ld hl,0e604h		;9a50   ; apunta a el contador de cuadros de partida
	bit 2,(hl)		;9a53
	jp z,L_98E0		;9a55
	add a,004h		;9a58
	res 5,(ix+009h)		;9a5a   ; pone a cero el bit 5 de la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	jp 07083h		;9a5e

; ----------------------------------------------------------------------
; DATOS tres_palabras_9a61: 3 palabras que p05:99F7 elige con (ix+0x19) y pasa
;   a p04:736F
;   0x9a61..0x9a67  (6 bytes)
DATA_tres_palabras_9a61:
	defb 0a8h,019h	; 9a61
	defb 0a4h,00bh	; 9a63
	defb 0a0h,04dh	; 9a65

; ======================================================================
; CODIGO 0x9a67..0x9adf  (120 bytes)
; ======================================================================


salta_si_puede:		; salta si la tabla 0x9ADF lo deja
	ld hl,09adfh		;9a67
	call hueco_para_saltar		;9a6a   ; hueco_para_saltar: C si hay sitio para el salto (ix+0x1E)
	ret nc			;9a6d
	ld de,040d0h		;9a6e
	jp L_9CA3		;9a71
salto_30_e0:		; el salto con D = 0x30, E = 0xE0
	ld de,030e0h		;9a74
L_9A77:
	ld a,(ix+01eh)		;9a77
	and a			;9a7a
	ret nz			;9a7b
	ld l,(ix+005h)		;9a7c   ; lee la y de la figura
	ld a,(ix+007h)		;9a7f   ; lee la x de la figura
	ld c,010h		;9a82
	bit 7,(ix+00fh)		;9a84   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_9A8C		;9a88
	ld c,0ffh		;9a8a
L_9A8C:
	add a,c			;9a8c
	ld h,a			;9a8d
	call 04056h		;9a8e   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;9a91
	cp 0bah		;9a92
	ret nc			;9a94
	ld hl,09ae6h		;9a95
	jp L_9CB0		;9a98
hueco_para_saltar:		; C si hay sitio para el salto (ix+0x1E)
	ld a,(ix+01eh)		;9a9b
	and a			;9a9e
	ret z			;9a9f
	dec a			;9aa0
	add a,a			;9aa1
	add a,(ix+01dh)		;9aa2
	call 04053h		;9aa5   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld a,(ix+005h)		;9aa8   ; lee la y de la figura
	add a,d			;9aab
	ld l,a			;9aac
	sub 030h		;9aad
	cp 081h		;9aaf
	ret nc			;9ab1
	ld a,(ix+007h)		;9ab2   ; lee la x de la figura
	bit 0,(ix+01dh)		;9ab5
	jr z,L_9ABF		;9ab9
	add a,e			;9abb
	ret nc			;9abc
	jr L_9AC2		;9abd
L_9ABF:
	add a,e			;9abf
	ccf			;9ac0
	ret nc			;9ac1
L_9AC2:
	ld h,a			;9ac2
	sub 008h		;9ac3
	cp 0e8h		;9ac5
	ret nc			;9ac7
	call 0406eh		;9ac8   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ccf			;9acb
	ret nc			;9acc
	call casilla_lado_ba		;9acd   ; casilla_lado_ba: C si la casilla de al lado es menor que 0xBA
	ret nc			;9ad0
casilla_lado_ba:		; C si la casilla de al lado es menor que 0xBA
	bit 0,(ix+01dh)		;9ad1
	jr z,L_9ADA		;9ad5
	inc hl			;9ad7
	jr L_9ADB		;9ad8
L_9ADA:
	dec hl			;9ada
L_9ADB:
	ld a,(hl)			;9adb
	cp 0bah		;9adc
	ret			;9ade

; ----------------------------------------------------------------------
; DATOS palabras_9adf: las palabras que p05:9A9B elige con 2 x ((ix+0x1E) - 1)
;   + (ix+0x1D) desde 0x9ADF (p05:9A67): parejas de desplazamientos de Y y X
;   0x9adf..0x9ae6  (7 bytes)
DATA_palabras_9adf:
	defb 020h,0f0h,0f0h,0f0h,028h,010h,0e8h	; 9adf

; ----------------------------------------------------------------------
; DATOS desplazamiento_9ae6: un desplazamiento con signo que p05:9A95 pasa a
;   p05:9CB0
;   0x9ae6..0x9ae7  (1 bytes)
DATA_desplazamiento_9ae6:
	defb 010h	; 9ae6

; ======================================================================
; CODIGO 0x9ae7..0x9bbc  (213 bytes)
; ======================================================================


espera_20_9f:		; (ix+0x1A) = 0x20 + azar
	call azar_5		;9ae7   ; azar_5: A = R con el contador de cuadros
	and 07fh		;9aea
	add a,020h		;9aec
	ld (ix+01ah),a		;9aee
	ret			;9af1
espera_azar_7f:		; una espera al azar 0-0x7F
	ld a,r		;9af2
	and 07fh		;9af4
	jp 071cfh		;9af6
lado_al_azar:		; (ix+0x1D) al azar
	ld a,r		;9af9
	and 001h		;9afb
	ld (ix+01dh),a		;9afd
	ret			;9b00
cambia_banderas_y_lado:		; el bit 0 de las banderas y el lado (ix+0x1D)
	ld a,(ix+002h)		;9b01   ; lee las banderas de la figura (bit 7: en pantalla)
	xor 001h		;9b04
	ld (ix+002h),a		;9b06   ; guarda las banderas de la figura (bit 7: en pantalla)
cuenta_y_lado:		; (ix+0x18) menos uno y el lado al reves
	dec (ix+018h)		;9b09
lado_al_reves:		; el lado (ix+0x1D) al reves
	ld a,(ix+01dh)		;9b0c
	xor 001h		;9b0f
	ld (ix+01dh),a		;9b11
	ret			;9b14
y_a_la_casilla_5:		; la y ajustada a la casilla
	ld a,(ix+005h)		;9b15   ; lee la y de la figura
	and 0f8h		;9b18
	jp L_96EA		;9b1a
cae_hasta_6:		; cae hasta la velocidad 6
	call 0b14ch		;9b1d   ; cae: la velocidad vertical mas la gravedad
	ld a,(ix+00dh)		;9b20   ; lee la velocidad vertical de la figura (alta)
	bit 7,a		;9b23
	ret nz			;9b25
	cp 006h		;9b26
	jr c,L_9B2E		;9b28
	ld (ix+00dh),006h		;9b2a   ; la velocidad vertical de la figura (alta) = 0x06
L_9B2E:
	xor a			;9b2e
	ret			;9b2f
tipo_24_entra:		; al entrar el tipo 0x24
	call espera_azar_9bab		;9b30   ; El tipo 0x24: al entrar
	ld a,(ix+005h)		;9b33   ; lee la y de la figura
	and 0e0h		;9b36
	rra			;9b38
	rra			;9b39
	rra			;9b3a
	rra			;9b3b
	rra			;9b3c
	dec a			;9b3d
	ld (ix+019h),a		;9b3e
	call lado_al_azar		;9b41   ; lado_al_azar: (ix+0x1D) al azar
	call velocidad_200		;9b44   ; velocidad_200: velocidad de lado 0x200 segun el lado
L_9B47:
	bit 0,(ix+01dh)		;9b47
	ld a,0a0h		;9b4b
	jr z,L_9B51		;9b4d
	ld a,0ach		;9b4f
L_9B51:
	jp 07083h		;9b51
tipo_24_cuadro:		; cada cuadro el tipo 0x24
	ld a,(ix+001h)		;9b54   ; El tipo 0x24: cada cuadro
	dec a			;9b57
	jr z,L_9B8F		;9b58
	jp p,L_9C3E		;9b5a
	dec (ix+008h)		;9b5d
	jr z,L_9B89		;9b60
	call elige_al_azar		;9b62   ; elige_al_azar: cada 32 cuadros una de 5 al azar
L_9B65:
	call 06beeh		;9b65   ; suelo_delante: C si hay suelo delante de los pies
	jp nc,L_9B80		;9b68
	call 06c04h		;9b6b   ; pared_delante: C con pared delante o en el borde
	jp c,L_9B80		;9b6e
	bit 0,(ix+01dh)		;9b71
	ld d,004h		;9b75
	jr z,L_9B7B		;9b77
	ld d,01ch		;9b79
L_9B7B:
	ld b,000h		;9b7b
	jp 0b17fh		;9b7d   ; anima_cada_8: cada 8 cuadros, el dibujo XOR D
L_9B80:
	call lado_al_reves		;9b80   ; lado_al_reves: el lado (ix+0x1D) al reves
	call 0b15fh		;9b83   ; vuelta_de_lado: la velocidad de lado al reves
	jp L_9B47		;9b86
L_9B89:
	call espera_azar_9bab		;9b89   ; espera_azar_9bab: una espera al azar
	jp paso_siguiente_de_figura		;9b8c   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9B8F:
	dec (ix+008h)		;9b8f
	jr z,L_9BA8		;9b92
	ld a,(ix+008h)		;9b94
	and 020h		;9b97
	jr nz,L_9B65		;9b99
	call mira_al_personaje		;9b9b   ; mira_al_personaje: cada 8 cuadros mira hacia el personaje y su altura
	call salto_38_d8		;9b9e   ; salto_38_d8: si el personaje esta en pie, el salto con D = 0x38, E = 0xD8
	jr c,L_9BB1		;9ba1
	call velocidad_200		;9ba3   ; velocidad_200: velocidad de lado 0x200 segun el lado
	jr L_9B65		;9ba6
L_9BA8:
	dec (ix+001h)		;9ba8   ; baja el paso de la figura
espera_azar_9bab:		; una espera al azar
	call azar_5		;9bab   ; azar_5: A = R con el contador de cuadros
	jp 071cfh		;9bae
L_9BB1:
	ld a,(ix+01eh)		;9bb1
	dec a			;9bb4
	ld hl,09c1ch		;9bb5
	push hl			;9bb8
	call 04050h		;9bb9   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9BBC: 4 destinos del despachador de 0x4140 (call en p05:9BB9):
;   0x9BC4, 0x9BCC, 0x9BE6, 0x9BFD; lo leen p05:9BB9 (8 bytes)
;   0x9bbc..0x9bc4  (8 bytes)
DATA_tabla_9BBC:
	defb 0c4h,09bh	; 9bbc
	defb 0cch,09bh	; 9bbe
	defb 0e6h,09bh	; 9bc0
	defb 0fdh,09bh	; 9bc2

; ======================================================================
; CODIGO 0x9bc4..0x9c63  (159 bytes)
; ======================================================================


L_9BC4:
	dec (ix+019h)		;9bc4
	ld de,0fa00h		;9bc7
	jr L_9BDA		;9bca
L_9BCC:
	inc (ix+019h)		;9bcc
	ld a,(ix+005h)		;9bcf   ; lee la y de la figura
	add a,002h		;9bd2
	ld (ix+005h),a		;9bd4   ; guarda la y de la figura
	ld de,0fd00h		;9bd7
L_9BDA:
	call 0b137h		;9bda   ; velocidad_vertical: la velocidad vertical = DE
	ld de,00080h		;9bdd
	call 0b145h		;9be0   ; gravedad: la gravedad = DE
	jp velocidad_200		;9be3   ; velocidad_200: velocidad de lado 0x200 segun el lado
L_9BE6:
	dec (ix+019h)		;9be6
	dec (ix+019h)		;9be9
	ld de,0f9b0h		;9bec
	call 0b137h		;9bef   ; velocidad_vertical: la velocidad vertical = DE
	ld de,00050h		;9bf2
	call 0b145h		;9bf5   ; gravedad: la gravedad = DE
	ld de,00180h		;9bf8
	jr L_9C12		;9bfb
L_9BFD:
	inc (ix+019h)		;9bfd
	inc (ix+019h)		;9c00
	ld de,0fd40h		;9c03
	call 0b137h		;9c06   ; velocidad_vertical: la velocidad vertical = DE
	ld de,00040h		;9c09
	call 0b145h		;9c0c   ; gravedad: la gravedad = DE
	ld de,00100h		;9c0f
L_9C12:
	bit 0,(ix+01dh)		;9c12
	call nz,04068h		;9c16   ; de_negado (por 0x4068): DE = -DE
	jp 0b13eh		;9c19   ; velocidad_de_lado: la velocidad de lado = DE
L_9C1C:
	bit 0,(ix+01dh)		;9c1c
	ld a,0a8h		;9c20
	jr z,L_9C26		;9c22
	ld a,0b4h		;9c24
L_9C26:
	ld (ix+00ah),a		;9c26   ; guarda el dibujo (o el mosaico) de la figura
	ld a,(ix+019h)		;9c29
	ld hl,09c63h		;9c2c
	call 04083h		;9c2f   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+01ah),a		;9c32
	ld (ix+011h),009h		;9c35   ; el tamaño de la figura (tabla 0x9006, banco 14) = 0x09
	ld (ix+001h),002h		;9c39   ; el paso de la figura = 0x02
	ret			;9c3d
L_9C3E:
	call cae_hasta_6		;9c3e   ; cae_hasta_6: cae hasta la velocidad 6
	ret nz			;9c41
	ld a,(ix+005h)		;9c42   ; lee la y de la figura
	cp (ix+01ah)		;9c45
	ret c			;9c48
	call suelo_delante_5		;9c49   ; suelo_delante_5: C si hay suelo delante
	ret nc			;9c4c
	call y_a_la_casilla_5		;9c4d   ; y_a_la_casilla_5: la y ajustada a la casilla
	call 0b129h		;9c50   ; sin_vertical: la velocidad vertical a 0
	xor a			;9c53
	ld (ix+001h),a		;9c54   ; guarda el paso de la figura
	ld (ix+011h),a		;9c57   ; guarda el tamaño de la figura (tabla 0x9006, banco 14)
	call espera_azar_9bab		;9c5a   ; espera_azar_9bab: una espera al azar
	call velocidad_200		;9c5d   ; velocidad_200: velocidad de lado 0x200 segun el lado
	jp L_9B47		;9c60

; ----------------------------------------------------------------------
; DATOS cinco_bytes_9c63: 5 bytes que p05:9C2C pone en (ix+0x1A) segun
;   (ix+0x19)
;   0x9c63..0x9c68  (5 bytes)
DATA_cinco_bytes_9c63:
	defb 028h,048h,068h,088h,0a8h	; 9c63

; ----------------------------------------------------------------------
; DATOS desplazamientos_9c68: 4 desplazamientos con signo de Y que p05:9CAC
;   suma a (ix+5)
;   0x9c68..0x9c6c  (4 bytes)
DATA_desplazamientos_9c68:
	defb 0f0h,030h,0d0h,050h	; 9c68

; ======================================================================
; CODIGO 0x9c6c..0x9d62  (246 bytes)
; ======================================================================


mira_al_personaje:		; cada 8 cuadros mira hacia el personaje y su altura
	ld a,(ix+008h)		;9c6c
	and 007h		;9c6f
	ret nz			;9c71
	ld a,(0e507h)		;9c72   ; lee la x del personaje
	cp (ix+007h)		;9c75   ; compara con la x de la figura
	ld a,000h		;9c78
	rla			;9c7a
	ld (ix+01dh),a		;9c7b
	ld a,(ix+005h)		;9c7e   ; lee la y de la figura
	add a,010h		;9c81
	ld hl,0e505h		;9c83   ; apunta a la y del personaje
	sub (hl)			;9c86
	jr z,L_9C97		;9c87
	ld b,003h		;9c89
	jr nc,L_9C90		;9c8b
	neg		;9c8d
	inc b			;9c8f
L_9C90:
	cp 021h		;9c90
	jr nc,L_9C96		;9c92
	dec b			;9c94
	dec b			;9c95
L_9C96:
	ld a,b			;9c96
L_9C97:
	ld (ix+01eh),a		;9c97
	ret			;9c9a
salto_38_d8:		; si el personaje esta en pie, el salto con D = 0x38, E = 0xD8
	ld a,(0e500h)		;9c9b   ; lee el estado del personaje (5 = hundirse)
	and a			;9c9e
	ret nz			;9c9f
	ld de,038d8h		;9ca0
L_9CA3:
	ld a,(ix+01eh)		;9ca3
	and a			;9ca6
	ret z			;9ca7
	ld c,a			;9ca8
	dec c			;9ca9
	ld b,000h		;9caa
	ld hl,09c68h		;9cac
	add hl,bc			;9caf
L_9CB0:
	ld a,(ix+005h)		;9cb0   ; lee la y de la figura
	bit 7,(hl)		;9cb3
	jr nz,L_9CBC		;9cb5
	add a,(hl)			;9cb7
	ccf			;9cb8
	ret nc			;9cb9
	jr L_9CBE		;9cba
L_9CBC:
	add a,(hl)			;9cbc
	ret nc			;9cbd
L_9CBE:
	ld l,a			;9cbe
	sub 028h		;9cbf
	cp 091h		;9cc1
	ret nc			;9cc3
	ld a,(ix+007h)		;9cc4   ; lee la x de la figura
	bit 0,(ix+01dh)		;9cc7
	jr z,L_9CD1		;9ccb
	add a,e			;9ccd
	ret nc			;9cce
	jr L_9CD4		;9ccf
L_9CD1:
	add a,d			;9cd1
	ccf			;9cd2
	ret nc			;9cd3
L_9CD4:
	ld h,a			;9cd4
	sub 010h		;9cd5
	cp 0e0h		;9cd7
	ret nc			;9cd9
	call 0406eh		;9cda   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	ret nc			;9cdd
	call casilla_de_encima		;9cde   ; casilla_de_encima: la casilla de encima menor que 0xBA
	ret nc			;9ce1
	call casilla_diagonal		;9ce2   ; casilla_diagonal: C segun la casilla de abajo a un lado
	ret nc			;9ce5
	call casilla_diagonal		;9ce6   ; casilla_diagonal: C segun la casilla de abajo a un lado
	ret nc			;9ce9
	ld a,(ix+000h)		;9cea   ; lee el tipo de la figura
	cp 024h		;9ced
	jr z,L_9D35		;9cef
	ld a,(ix+01eh)		;9cf1
	dec a			;9cf4
	jr z,L_9D35		;9cf5
	ld a,(ix+005h)		;9cf7   ; lee la y de la figura
	add a,010h		;9cfa
	ld l,a			;9cfc
	ld a,(ix+007h)		;9cfd   ; lee la x de la figura
	ld c,010h		;9d00
	bit 0,(ix+01dh)		;9d02
	jr z,L_9D0A		;9d06
	ld c,0f0h		;9d08
L_9D0A:
	add a,c			;9d0a
	ld h,a			;9d0b
	call 04056h		;9d0c   ; casilla_de_yx (por 0x4056): HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	push hl			;9d0f
	call pared_en_hl		;9d10   ; pared_en_hl: C si (HL) es menor que 0xBA
	pop hl			;9d13
	ret nc			;9d14
	inc hl			;9d15
pared_en_hl:		; C si (HL) es menor que 0xBA
	ld a,(hl)			;9d16
	cp 0bah		;9d17
	ret nc			;9d19
	jr casilla_de_encima		;9d1a
casilla_diagonal:		; C segun la casilla de abajo a un lado
	ld de,00021h		;9d1c
	bit 0,(ix+01dh)		;9d1f
	jr nz,L_9D28		;9d23
	ld de,0001fh		;9d25
L_9D28:
	add hl,de			;9d28
	ld a,0b9h		;9d29
	cp (hl)			;9d2b
	ret nc			;9d2c
casilla_de_encima:		; la casilla de encima menor que 0xBA
	ld de,0ffe0h		;9d2d
	add hl,de			;9d30
	ld a,(hl)			;9d31
	cp 0bah		;9d32
	ret			;9d34
L_9D35:
	scf			;9d35
	ret			;9d36
velocidad_200:		; velocidad de lado 0x200 segun el lado
	bit 0,(ix+01dh)		;9d37
	ld de,00200h		;9d3b
	call nz,04068h		;9d3e   ; de_negado (por 0x4068): DE = -DE
	call 0b13eh		;9d41   ; velocidad_de_lado: la velocidad de lado = DE
	jp L_9B47		;9d44
elige_al_azar:		; cada 32 cuadros una de 5 al azar
	ld a,(ix+008h)		;9d47
	and 01fh		;9d4a
	ret nz			;9d4c
	call azar_5		;9d4d   ; azar_5: A = R con el contador de cuadros
	and 007h		;9d50
	cp 005h		;9d52
	jr c,L_9D58		;9d54
	sub 005h		;9d56
L_9D58:
	ld c,a			;9d58
	and a			;9d59
	jr z,$+48		;9d5a
	ld a,(ix+019h)		;9d5c
	call 04050h		;9d5f   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9D62: 5 destinos del despachador de 0x4140 (call en p05:9D5F):
;   0x9D85, 0x9D7C, 0x9D8A, 0x9D73, 0x9D6C; lo leen p05:9D5F (10 bytes)
;   0x9d62..0x9d6c  (10 bytes)
DATA_tabla_9D62:
	defb 085h,09dh	; 9d62
	defb 07ch,09dh	; 9d64
	defb 08ah,09dh	; 9d66
	defb 073h,09dh	; 9d68
	defb 06ch,09dh	; 9d6a

; ======================================================================
; CODIGO 0x9d6c..0x9dcf  (99 bytes)
; ======================================================================


L_9D6C:
	bit 0,c		;9d6c
	jr nz,L_9D8A		;9d6e
	dec c			;9d70
	jr L_9D8A		;9d71
L_9D73:
	ld a,c			;9d73
	cp 004h		;9d74
	jr nz,L_9D8A		;9d76
	ld c,000h		;9d78
	jr L_9D8A		;9d7a
L_9D7C:
	ld a,c			;9d7c
	cp 003h		;9d7d
	jr nz,L_9D8A		;9d7f
	ld c,000h		;9d81
	jr L_9D8A		;9d83
L_9D85:
	bit 0,c		;9d85
	jr z,L_9D8A		;9d87
	inc c			;9d89
L_9D8A:
	ld (ix+01eh),c		;9d8a
	call salto_38_d8		;9d8d   ; salto_38_d8: si el personaje esta en pie, el salto con D = 0x38, E = 0xD8
	jp nc,velocidad_200		;9d90   ; velocidad_200: velocidad de lado 0x200 segun el lado
	pop hl			;9d93
	jp L_9BB1		;9d94
tipo_0c_entra:		; al entrar el tipo 0x0C
	ld (ix+017h),00ah		;9d97   ; El tipo 0x0C: al entrar
	ld (ix+008h),008h		;9d9b
	ld (ix+018h),008h		;9d9f
	ld (ix+015h),001h		;9da3   ; las columnas de la figura que se pintan = 0x01
	ld (ix+016h),00ah		;9da7
	ld (ix+013h),004h		;9dab
	ld (ix+012h),000h		;9daf
espera_30_7f:		; (ix+0x1B) = 0x30 + azar
	call azar_5		;9db3   ; azar_5: A = R con el contador de cuadros
	and 04fh		;9db6
	add a,030h		;9db8
	ld (ix+01bh),a		;9dba
tipos_44_y_mas_cuadro:		; cada cuadro los tipos 0x44, 0x56
	ret			;9dbd   ; Los tipos 0x44, 0x56: cada cuadro
tipo_0c_cuadro:		; cada cuadro el tipo 0x0C
	ld hl,0b067h		;9dbe   ; El tipo 0x0C: cada cuadro
	push hl			;9dc1
	ld a,(ix+01ah)		;9dc2
	or a			;9dc5
	jp nz,L_9E54		;9dc6
	ld a,(ix+001h)		;9dc9   ; lee el paso de la figura
	call 04050h		;9dcc   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_9DCF: 3 destinos del despachador de 0x4140 (call en p05:9DCC):
;   0x9DD5, 0x9DFE, 0x9E2A; lo leen p05:9DCC (6 bytes)
;   0x9dcf..0x9dd5  (6 bytes)
DATA_tabla_9DCF:
	defb 0d5h,09dh	; 9dcf
	defb 0feh,09dh	; 9dd1
	defb 02ah,09eh	; 9dd3

; ======================================================================
; CODIGO 0x9dd5..0x9f37  (354 bytes)
; ======================================================================


L_9DD5:
	ld hl,09f37h		;9dd5
L_9DD8:
	dec (ix+017h)		;9dd8
	ret nz			;9ddb
	ld (ix+017h),00ah		;9ddc
	ld a,(ix+014h)		;9de0
	inc (ix+014h)		;9de3
	cp (ix+013h)		;9de6
	jr z,L_9DF1		;9de9
L_9DEB:
	call 04083h		;9deb   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	jp 07083h		;9dee
L_9DF1:
	call ancho_xor_12		;9df1   ; ancho_xor_12: el ancho XOR (ix+0x12)
	call anda_al_azar		;9df4   ; anda_al_azar: velocidad 0x100 a un lado al azar
	ld (ix+017h),000h		;9df7
	jp paso_siguiente_de_figura		;9dfb   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9DFE:
	dec (ix+017h)		;9dfe
	jr z,L_9E19		;9e01
	call 06beeh		;9e03   ; suelo_delante: C si hay suelo delante de los pies
	jr nc,L_9E0D		;9e06
	call 06c04h		;9e08   ; pared_delante: C con pared delante o en el borde
	jr nc,L_9E13		;9e0b
L_9E0D:
	call 0b15fh		;9e0d   ; vuelta_de_lado: la velocidad de lado al reves
	call dibujo_tipo_0c		;9e10   ; dibujo_tipo_0c: el dibujo del tipo 0x0C segun el lado
L_9E13:
	call anima_19_8		;9e13   ; anima_19_8: anima con D = (ix+0x19), E = 8
	jp L_9EE0		;9e16
L_9E19:
	call ancho_xor_12		;9e19   ; ancho_xor_12: el ancho XOR (ix+0x12)
	call 0b12eh		;9e1c   ; sin_lado: la velocidad de lado a 0
	ld (ix+017h),00ah		;9e1f
	ld (ix+014h),000h		;9e23
	jp paso_siguiente_de_figura		;9e27   ; paso_siguiente_de_figura: sube el paso (ix+1)
L_9E2A:
	ld hl,09f3bh		;9e2a
L_9E2D:
	dec (ix+017h)		;9e2d
	ret nz			;9e30
	ld (ix+017h),00ah		;9e31
	ld a,(ix+014h)		;9e35
	inc (ix+014h)		;9e38
	cp (ix+013h)		;9e3b
	jr z,L_9E42		;9e3e
	jr L_9DEB		;9e40
L_9E42:
	ld (ix+019h),01ch		;9e42
	ld (ix+00ah),0b0h		;9e46   ; el dibujo (o el mosaico) de la figura = 0xB0
	ld (ix+017h),030h		;9e4a
	inc (ix+01ah)		;9e4e
	jp 06bd5h		;9e51   ; paso_0_figura: el paso a 0
L_9E54:
	call anima_19_8		;9e54   ; anima_19_8: anima con D = (ix+0x19), E = 8
	dec (ix+017h)		;9e57
	jp nz,07dbdh		;9e5a
	ld h,(ix+007h)		;9e5d   ; lee la x de la figura
	ld (ix+01eh),h		;9e60
	ld a,(ix+005h)		;9e63   ; lee la y de la figura
	add a,007h		;9e66
	ld (ix+01fh),a		;9e68
	add a,009h		;9e6b
	ld l,a			;9e6d
	call 0406eh		;9e6e   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr nc,L_9E8B		;9e71
	call 04071h		;9e73   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
	jr nc,L_9E8B		;9e76
	call suelo_en_1e_1f		;9e78   ; suelo_en_1e_1f: C si hay suelo en la casilla de (ix+0x1E, 0x1F)
	jr nc,L_9E8B		;9e7b
	ld (ix+014h),000h		;9e7d
	ld (ix+017h),00ah		;9e81
	dec (ix+01ah)		;9e85
	jp 0b124h		;9e88   ; solo_vertical: sin velocidad de lado y la vertical = DE
L_9E8B:
	inc (ix+017h)		;9e8b
	jp 07dbdh		;9e8e
dibujo_tipo_0c:		; el dibujo del tipo 0x0C segun el lado
	ld a,(ix+000h)		;9e91   ; lee el tipo de la figura
	cp 00ch		;9e94
	jr nz,L_9EAC		;9e96
	bit 7,(ix+00fh)		;9e98   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld a,0b8h		;9e9c
	ld b,00ch		;9e9e
	jr z,L_9EA6		;9ea0
	ld a,0c0h		;9ea2
	ld b,07ch		;9ea4
L_9EA6:
	ld (ix+019h),b		;9ea6
L_9EA9:
	jp 07083h		;9ea9
L_9EAC:
	bit 7,(ix+00fh)		;9eac   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	ld a,0bch		;9eb0
	jr z,L_9EB6		;9eb2
	ld a,0c4h		;9eb4
L_9EB6:
	ld (ix+019h),004h		;9eb6
	jr L_9EA9		;9eba
anima_19_8:		; anima con D = (ix+0x19), E = 8
	ld d,(ix+019h)		;9ebc
	ld e,008h		;9ebf
	ld b,000h		;9ec1
	jp 0b0d6h		;9ec3   ; anima_cada: cada (ix+8) cuadros: el dibujo XOR D y el tamaño XOR B
ancho_xor_12:		; el ancho XOR (ix+0x12)
	ld a,(ix+00bh)		;9ec6   ; lee el ancho del mosaico
	xor (ix+012h)		;9ec9
	ld (ix+00bh),a		;9ecc   ; guarda el ancho del mosaico
	ret			;9ecf
anda_al_azar:		; velocidad 0x100 a un lado al azar
	ld de,00100h		;9ed0
	call 0b13eh		;9ed3   ; velocidad_de_lado: la velocidad de lado = DE
	ld a,r		;9ed6
	and 001h		;9ed8
	call z,0b15fh		;9eda   ; vuelta_de_lado: la velocidad de lado al reves
	jp dibujo_tipo_0c		;9edd   ; dibujo_tipo_0c: el dibujo del tipo 0x0C segun el lado
L_9EE0:
	dec (ix+01bh)		;9ee0
	ret nz			;9ee3
	call espera_30_7f		;9ee4   ; espera_30_7f: (ix+0x1B) = 0x30 + azar
	ld a,(0e507h)		;9ee7   ; lee la x del personaje
	cp (ix+007h)		;9eea   ; compara con la x de la figura
	jr c,L_9EF7		;9eed
	bit 7,(ix+00fh)		;9eef   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_9EFD		;9ef3
	jr L_9F19		;9ef5
L_9EF7:
	bit 7,(ix+00fh)		;9ef7   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr z,L_9F19		;9efb
L_9EFD:
	ld a,(ix+005h)		;9efd   ; lee la y de la figura
	add a,008h		;9f00
	ld d,a			;9f02
	ld a,(ix+007h)		;9f03   ; lee la x de la figura
	add a,008h		;9f06
	ld e,a			;9f08
	ld b,000h		;9f09
	ld a,(ix+000h)		;9f0b   ; lee el tipo de la figura
	cp 013h		;9f0e
	ld a,044h		;9f10
	jr z,L_9F16		;9f12
	ld a,056h		;9f14
L_9F16:
	jp 06551h		;9f16   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
L_9F19:
	ld (ix+01bh),001h		;9f19
	ret			;9f1d
tipos_44_y_mas_entra:		; al entrar los tipos 0x44, 0x56
	call 06c42h		;9f1e   ; Los tipos 0x44, 0x56: al entrar
	ld a,040h		;9f21
	call 0b18fh		;9f23   ; hacia_el_personaje: HL, DE = las velocidades hacia el personaje (A + 8 x 0xE045)
	call 0b133h		;9f26   ; velocidades: la de lado = DE y la vertical = HL
	ld a,(ix+000h)		;9f29   ; lee el tipo de la figura
	cp 044h		;9f2c
	ld a,00fh		;9f2e
	jr z,L_9F34		;9f30
	ld a,00eh		;9f32
L_9F34:
	jp 04059h		;9f34   ; pide_sonido (por 0x4059): pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)

; ----------------------------------------------------------------------
; DATOS secuencia_9f37: 4 bytes que p05:9DD5 recorre con (ix+0x14), uno cada
;   10 cuadros
;   0x9f37..0x9f3b  (4 bytes)
DATA_secuencia_9f37:
	defb 0b0h,0ach,0a8h,0a4h	; 9f37

; ----------------------------------------------------------------------
; DATOS secuencia_9f3b: 4 bytes que p05:9E2A recorre igual
;   0x9f3b..0x9f3f  (4 bytes)
DATA_secuencia_9f3b:
	defb 0a4h,0a8h,0ach,0b0h	; 9f3b

; ======================================================================
; CODIGO 0x9f3f..0x9f66  (39 bytes)
; ======================================================================


tipo_68_entra:		; al entrar el tipo 0x68
	ld a,(0e62fh)		;9f3f   ; El tipo 0x68: al entrar
	inc a			;9f42
	ld (0e62fh),a		;9f43
	and 003h		;9f46
	ld hl,09f66h		;9f48
	call 04083h		;9f4b   ; byte_de_tabla (por 0x4083): A = el byte HL + A
	ld (ix+00dh),a		;9f4e   ; guarda la velocidad vertical de la figura (alta)
	inc hl			;9f51
	ld a,(hl)			;9f52
	ld (ix+00fh),a		;9f53   ; guarda la velocidad de lado de la figura (alta)
	xor a			;9f56
	ld (ix+00eh),a		;9f57   ; guarda la velocidad de lado de la figura
	ld (ix+00ch),a		;9f5a   ; guarda la velocidad vertical de la figura
	ld (ix+008h),008h		;9f5d
	res 4,(ix+002h)		;9f61   ; pone a cero el bit 4 de las banderas de la figura (bit 7: en pantalla)
	ret			;9f65

; ----------------------------------------------------------------------
; DATOS cinco_bytes_9f66: 5 bytes: p05:9F48 coge el (0xE62F) mod 4 para
;   (ix+0x0D) y el siguiente para (ix+0x0F)
;   0x9f66..0x9f6b  (5 bytes)
DATA_cinco_bytes_9f66:
	defb 0fch,0fch,004h,004h,0fch	; 9f66

; ======================================================================
; CODIGO 0x9f6b..0xa000  (149 bytes)
; ======================================================================


tipo_68_cuadro:		; cada cuadro el tipo 0x68
	ld a,(ix+001h)		;9f6b   ; El tipo 0x68: cada cuadro
	dec a			;9f6e
	jr z,L_9F84		;9f6f
	dec (ix+008h)		;9f71
	ret nz			;9f74
	call 0a049h		;9f75
	set 4,(ix+002h)		;9f78   ; pone a uno el bit 4 de las banderas de la figura (bit 7: en pantalla)
	inc (ix+001h)		;9f7c   ; sube el paso de la figura
	ld (ix+008h),0c0h		;9f7f
	ret			;9f83
L_9F84:
	dec (ix+008h)		;9f84
	jp z,0b41ch		;9f87   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	call techo_o_borde		;9f8a   ; techo_o_borde: C con techo o arriba del todo
	call 0a011h		;9f8d
	ld a,0ffh		;9f90
	ld b,000h		;9f92
	bit 7,(ix+00dh)		;9f94   ; mira el bit 7 de la velocidad vertical de la figura (alta)
	jr nz,L_9F9D		;9f98
	inc b			;9f9a
	ld a,011h		;9f9b
L_9F9D:
	add a,(ix+005h)		;9f9d   ; le suma la y de la figura
	ld l,a			;9fa0
	ld (ix+016h),b		;9fa1
	ld a,0ffh		;9fa4
	ld b,000h		;9fa6
	bit 7,(ix+00fh)		;9fa8   ; mira el bit 7 de la velocidad de lado de la figura (alta)
	jr nz,L_9FB1		;9fac
	inc b			;9fae
	ld a,011h		;9faf
L_9FB1:
	add a,(ix+007h)		;9fb1   ; le suma la x de la figura
	ld h,a			;9fb4
	ld (ix+017h),b		;9fb5
	call 0406eh		;9fb8   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr nc,L_9FCB		;9fbb
	ld a,(ix+015h)		;9fbd   ; lee las columnas de la figura que se pintan
	add a,(ix+014h)		;9fc0
	jr nz,L_9FCB		;9fc3
	inc (ix+015h)		;9fc5   ; sube las columnas de la figura que se pintan
	inc (ix+014h)		;9fc8
L_9FCB:
	dec (ix+014h)		;9fcb
	call z,0b16fh		;9fce   ; vuelta_vertical: la velocidad vertical al reves
	dec (ix+015h)		;9fd1   ; baja las columnas de la figura que se pintan
	jp z,0b15fh		;9fd4   ; vuelta_de_lado: la velocidad de lado al reves
	ret			;9fd7
techo_o_borde:		; C con techo o arriba del todo
	ld (ix+014h),000h		;9fd8
	bit 7,(ix+00dh)		;9fdc   ; mira el bit 7 de la velocidad vertical de la figura (alta)
	jr z,L_9FFB		;9fe0
	ld a,(ix+005h)		;9fe2   ; lee la y de la figura
	cp 020h		;9fe5
	jr c,$+38		;9fe7
	ld l,(ix+005h)		;9fe9   ; lee la y de la figura
	dec l			;9fec
	ld h,(ix+007h)		;9fed   ; lee la x de la figura
	call 0406eh		;9ff0   ; casilla_b9 (por 0x406E): C si el caracter de la casilla de HL pasa de 0xB9
	jr c,$+26		;9ff3
	call 04071h		;9ff5   ; casilla_derecha (por 0x4071): compara 0xB9 con el caracter de HL + 1
	jr c,$+21		;9ff8
	ret			;9ffa
L_9FFB:
	ld a,(ix+005h)		;9ffb   ; lee la y de la figura
	add a,011h		;9ffe
