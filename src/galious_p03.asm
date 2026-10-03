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
	ld a,(0e094h)		;a003   ; lee tiene el objeto 0x25
	and a			;a006
	ret nz			;a007
	ld a,(0e068h)		;a008   ; lee las marcas del mapa 7 (bits 7-4: objetos 09 08 07 0A; bit 2: jefe vencido)
	bit 2,a		;a00b
	ret z			;a00d
	ld c,025h		;a00e
	ld de,068d0h		;a010
L_A013:
	ld a,(0e61ch)		;a013   ; lee vencidas las de la sala del castillo (salen los objetos escondidos)
	and a			;a016
	ret z			;a017
	jr L_A049		;a018
L_A01A:
	ld a,(0e095h)		;a01a   ; lee tiene el objeto 0x26
	and a			;a01d
	ret nz			;a01e
	call subido_a_figura		;a01f   ; subido_a_figura: NZ si el personaje esta subido a una figura que se mueve
	ret z			;a022
	ld b,004h		;a023
	ld hl,0a056h		;a025
	ld c,026h		;a028
	ld de,02860h		;a02a
	ld a,(0e536h)		;a02d
	cp b			;a030
	jr z,L_A049		;a031
	call 04155h		;a033   ; byte_de_tabla: A = el byte HL + A
	ld d,a			;a036
	ld a,(0e008h)		;a037   ; lee lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
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
	call 05d88h		;a04e   ; pon_cosa: la cosa C en la y D, x E (hueco 0xE740)
	ld a,02eh		;a051
	jp 04e1fh		;a053   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)

; ----------------------------------------------------------------------
; DATOS cuatro_bytes_a056: 4 bytes que p03:A025 lee con 0x4155 y compara con
;   0xE536
;   0xa056..0xa05a  (4 bytes)
DATA_cuatro_bytes_a056:
	defb 008h,002h,004h,001h	; a056

; ======================================================================
; CODIGO 0xa05a..0xa134  (218 bytes)
; ======================================================================


empieza_el_cierre:		; el recuadro que se cierra en el final
	ld hl,0ed80h		;a05a   ; el final: un recuadro que se cierra desde la pantalla entera (0x20 x 0x14, 10 vueltas)
	ld (0e6aah),hl		;a05d
	ld hl,02014h		;a060
	ld (0e6ach),hl		;a063
	ld hl,00a0ah		;a066
	ld (0e6aeh),hl		;a069
	ret			;a06c
cierre:		; cada 10 cuadros el recuadro se cierra una casilla; Z al acabar
	ld hl,0e6afh		;a06d   ; cada 10 cuadros una vuelta: la fila de arriba...
	dec (hl)			;a070
	ret nz			;a071
	ld (hl),00ah		;a072
	ld hl,(0e6aah)		;a074
	call cierre_fila		;a077   ; cierre_fila: una fila a 0 salvo las casillas de 0xE6A8
	ld a,(0e6ach)		;a07a   ; ...la de abajo...
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
	call cierre_fila		;a08b   ; cierre_fila: una fila a 0 salvo las casillas de 0xE6A8
	ld hl,(0e6aah)		;a08e   ; ...la columna de la izquierda...
	call cierre_columna		;a091   ; cierre_columna: una columna a 0 salvo las casillas de 0xE6A8
	ld hl,(0e6aah)		;a094   ; ...y la de la derecha, a 0...
	ld a,(0e6adh)		;a097
	dec a			;a09a
	call 04136h		;a09b   ; hl_mas_a: HL += A
	call cierre_columna		;a09e   ; cierre_columna: una columna a 0 salvo las casillas de 0xE6A8
	ld hl,(0e6aah)		;a0a1   ; ...y el recuadro una casilla mas dentro
	ld bc,00021h		;a0a4
	add hl,bc			;a0a7
	ld (0e6aah),hl		;a0a8
	ld hl,(0e6ach)		;a0ab
	ld de,00202h		;a0ae
	or a			;a0b1
	sbc hl,de		;a0b2
	ld (0e6ach),hl		;a0b4
	ld hl,0e6aeh		;a0b7   ; Z al acabar las 10
	dec (hl)			;a0ba
	ret			;a0bb
cierre_fila:		; una fila a 0 salvo las casillas de 0xE6A8
	ld a,(0e6adh)		;a0bc   ; una fila de 0xE6AD casillas a 0, salvo las de 0xE6A8
	ld b,a			;a0bf
L_A0C0:
	call casilla_que_queda		;a0c0   ; casilla_que_queda: Z si HL es una de las 2 x 2 casillas de 0xE6A8
	jr z,L_A0C7		;a0c3
	ld (hl),000h		;a0c5
L_A0C7:
	inc hl			;a0c7
	djnz L_A0C0		;a0c8
	ret			;a0ca
cierre_columna:		; una columna a 0 salvo las casillas de 0xE6A8
	ld bc,00020h		;a0cb   ; una columna de 0xE6AC casillas a 0, salvo las de 0xE6A8
	ld a,(0e6ach)		;a0ce
	exx			;a0d1
	ld b,a			;a0d2
L_A0D3:
	exx			;a0d3
	call casilla_que_queda		;a0d4   ; casilla_que_queda: Z si HL es una de las 2 x 2 casillas de 0xE6A8
	jr z,L_A0DB		;a0d7
	ld (hl),000h		;a0d9
L_A0DB:
	add hl,bc			;a0db
	exx			;a0dc
	djnz L_A0D3		;a0dd
	exx			;a0df
	ret			;a0e0
casilla_que_queda:		; Z si HL es una de las 2 x 2 casillas de 0xE6A8
	ld de,(0e6a8h)		;a0e1   ; Z si HL es una de las 2 x 2 casillas de 0xE6A8 (las que se quedan)
	rst 20h			;a0e5
	ret z			;a0e6
	inc de			;a0e7
	rst 20h			;a0e8
	ret z			;a0e9
	ld a,01fh		;a0ea
	call 0413bh		;a0ec   ; de_mas_a: DE += A
	rst 20h			;a0ef
	ret z			;a0f0
	inc de			;a0f1
	rst 20h			;a0f2
	ret			;a0f3
personaje:		; el personaje cada cuadro
	call agua		;a0f4   ; el personaje cada cuadro: el suelo, el agua, lo del mando, las armas
	call agua_tope		;a0f7   ; agua_tope: en el agua no se baja de la y 0xB9 (salvo Afrodita en la sala 0x0B del mapa 8)
	call estado_del_personaje		;a0fa   ; estado_del_personaje: por el estado del personaje (0 en pie, 1 salto, 2 caida, 3 escalera...)
	call armas		;a0fd   ; armas: la espada (boton A) y el arma elegida (boton B)
	jp sale_de_la_sala		;a100   ; sale_de_la_sala: por que lado sale de la sala (0xE01A)
agua_tope:		; en el agua no se baja de la y 0xB9 (salvo Afrodita en la sala 0x0B del mapa 8)
	ld a,(0e501h)		;a103   ; Afrodita en la sala 0x0B del mapa 8 se hunde...
	or a			;a106
	jr nz,L_A113		;a107
	ld hl,(0e041h)		;a109   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld de,00b08h		;a10c
	or a			;a10f
	sbc hl,de		;a110
	ret z			;a112
L_A113:
	ld a,(0e511h)		;a113   ; ...si no, en el agua (0xE511)...
	and a			;a116
	ret z			;a117
	ld hl,0e505h		;a118   ; ...no baja de la y 0xB9
	ld a,(hl)			;a11b
	cp 0b9h		;a11c
	ret c			;a11e
	ld (hl),0b9h		;a11f
	jp L_B051		;a121
estado_del_personaje:		; por el estado del personaje (0 en pie, 1 salto, 2 caida, 3 escalera...)
	xor a			;a124   ; p03:A8D9 y p03:A8F2...
	ld (0e515h),a		;a125
	call mando_del_personaje		;a128   ; mando_del_personaje: el mando del personaje en 0xE52E
	call parpadeo		;a12b   ; parpadeo: cuenta el parpadeo tras un golpe
	ld a,(0e500h)		;a12e   ; ...y por el estado del personaje (tabla que sigue)
	call 04140h		;a131   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call subido_a_figura		;a144   ; estado 0, en pie: sin suelo debajo...
	jr nz,L_A150		;a147
	ld hl,0e519h		;a149   ; ...y sin el bit 3 de 0xE519, a caer
	bit 3,(hl)		;a14c
	jr z,L_A190		;a14e
L_A150:
	ld a,(0e508h)		;a150   ; con 0xE508, arriba es saltar
	and a			;a153
	jp nz,L_A28B		;a154
	ld a,(0e52eh)		;a157   ; el mando de 0xE52E: derecha (bit 3)...
	rla			;a15a
	rla			;a15b
	rla			;a15c
	rla			;a15d
	rla			;a15e
	push af			;a15f
	call c,anda_a_la_derecha		;a160   ; anda_a_la_derecha: anda a la derecha
	pop af			;a163
	rla			;a164   ; ...izquierda (bit 2)...
	push af			;a165
	call c,anda_a_la_izquierda		;a166   ; anda_a_la_izquierda: anda a la izquierda (0x200, 0x280 con el objeto 0x11, 0x80 en el agua)
	pop af			;a169
	rla			;a16a   ; ...abajo (bit 1)...
	jp c,L_A2A6		;a16b
	rla			;a16e   ; ...arriba (bit 0)
	jp c,L_A256		;a16f
	ld a,(0e52eh)		;a172   ; sin derecha ni izquierda...
	and 00ch		;a175
	ret nz			;a177
L_A178:
	ld a,(0e520h)		;a178   ; ...con 0xE520, empujado
	and a			;a17b
	ret z			;a17c
	call empujado		;a17d   ; empujado: empujado a un lado (0xE520)
	ld a,(0e519h)		;a180   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	and 003h		;a183
	ret z			;a185
	jp para_contra_pared		;a186   ; para_contra_pared: se para y se ajusta a la casilla
L_A189:
	ld a,(0e50eh)		;a189   ; lee el paso en la escalera
	dec a			;a18c
	ret nz			;a18d
	jr L_A178		;a18e
L_A190:
	ld a,(0e501h)		;a190   ; a caer: la velocidad de caida 0x0C (Afrodita) o 0x0D (Popolon)...
	and a			;a193
	ld a,00ch		;a194
	jr z,L_A19A		;a196
	ld a,00dh		;a198
L_A19A:
	ld d,000h		;a19a
	ld e,a			;a19c
	ld (0e509h),de		;a19d   ; guarda la velocidad vertical del personaje y el byte siguiente (16 bits)
	ld a,002h		;a1a1   ; ...estado 2
	ld (0e500h),a		;a1a3   ; guarda el estado del personaje (5 = hundirse)
	ret			;a1a6
anda_a_la_izquierda:		; anda a la izquierda (0x200, 0x280 con el objeto 0x11, 0x80 en el agua)
	ld a,001h		;a1a7   ; a la izquierda: mirando a la izquierda (0xE503 = 1)...
	ld (0e503h),a		;a1a9   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld a,(0e502h)		;a1ac   ; ...la pose de andar
	and 001h		;a1af
	or 002h		;a1b1
	ld (0e502h),a		;a1b3   ; guarda la pose del personaje
L_A1B6:
	ld a,(0e520h)		;a1b6   ; lee empujado (1 a la izquierda, 2 a la derecha)
	and a			;a1b9
	call nz,empujado		;a1ba   ; empujado: empujado a un lado (0xE520)
	ld a,(0e500h)		;a1bd   ; lee el estado del personaje (5 = hundirse)
	dec a			;a1c0
	call nz,pasos		;a1c1   ; los pasos (p03:A2C4)
	ld hl,(0e506h)		;a1c4   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,(0e519h)		;a1c7   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	ld c,a			;a1ca
	bit 1,a		;a1cb   ; pared a la izquierda: se para
	jp nz,para_contra_pared		;a1cd   ; para_contra_pared: se para y se ajusta a la casilla
	ld a,(0e520h)		;a1d0   ; lee empujado (1 a la izquierda, 2 a la derecha)
	cp 002h		;a1d3
	jr c,L_A1DE		;a1d5
	ld a,c			;a1d7
	bit 0,a		;a1d8
	jp nz,para_contra_pared		;a1da   ; para_contra_pared: se para y se ajusta a la casilla
	ret			;a1dd
L_A1DE:
	ld a,(0e511h)		;a1de   ; la velocidad: en el agua -0x80...
	and a			;a1e1
	ld bc,0ff80h		;a1e2
	jr nz,L_A1F2		;a1e5
	ld bc,0fe00h		;a1e7   ; ...normal -0x200...
	call tiene_11		;a1ea   ; ...con el objeto 0x11, -0x280
	jr z,L_A1F2		;a1ed
	ld bc,0fd80h		;a1ef
L_A1F2:
	jp L_A94C		;a1f2   ; se mueve en x
anda_a_la_derecha:		; anda a la derecha
	xor a			;a1f5   ; a la derecha: mirando a la derecha (0xE503 = 0)
	ld (0e503h),a		;a1f6   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld a,(0e502h)		;a1f9   ; lee la pose del personaje
	and 001h		;a1fc
	ld (0e502h),a		;a1fe   ; guarda la pose del personaje
L_A201:
	ld a,(0e520h)		;a201   ; lee empujado (1 a la izquierda, 2 a la derecha)
	and a			;a204
	call nz,empujado		;a205   ; empujado: empujado a un lado (0xE520)
	ld a,(0e500h)		;a208   ; lee el estado del personaje (5 = hundirse)
	dec a			;a20b
	call nz,pasos		;a20c   ; pasos: cada 4 cuadros el paso siguiente de la pose
	ld hl,(0e506h)		;a20f   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,(0e519h)		;a212   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	ld c,a			;a215
	bit 0,a		;a216   ; pared a la derecha: se para
	jp nz,para_contra_pared		;a218   ; para_contra_pared: se para y se ajusta a la casilla
	ld a,(0e520h)		;a21b   ; lee empujado (1 a la izquierda, 2 a la derecha)
	bit 0,a		;a21e
	jr z,L_A229		;a220
	ld a,c			;a222
	bit 1,a		;a223
	jp nz,para_contra_pared		;a225   ; para_contra_pared: se para y se ajusta a la casilla
	ret			;a228
L_A229:
	ld a,(0e511h)		;a229   ; en el agua 0x80, normal 0x200, con el objeto 0x11 0x280
	and a			;a22c
	ld bc,00080h		;a22d
	jr nz,L_A23D		;a230
	ld bc,00200h		;a232
	call tiene_11		;a235   ; tiene_11: NZ con el objeto 0x11 (y el estado del personaje - 1)
	jr z,L_A23D		;a238
	ld bc,00280h		;a23a
L_A23D:
	jr L_A1F2		;a23d
empujado:		; empujado a un lado (0xE520)
	ld a,(0e519h)		;a23f   ; empujado: 0xE520 = 1 a la izquierda (-8), 2 a la derecha (+0x12)...
	and 003h		;a242
	ret nz			;a244
	ld hl,0e520h		;a245   ; apunta a empujado (1 a la izquierda, 2 a la derecha)
	ld a,(hl)			;a248
	inc hl			;a249
	dec a			;a24a
	ld b,0f8h		;a24b
	jr z,L_A251		;a24d
	ld b,012h		;a24f
L_A251:
	ld a,(hl)			;a251   ; ...desde la x de 0xE521
	add a,b			;a252
	jp L_A893		;a253
L_A256:
	ld a,(0e008h)		;a256   ; arriba recien apretado...
	and 001h		;a259
	ret z			;a25b
	call escalera_arriba		;a25c   ; ...con escalera delante (p03:AEE1)...
	jr nc,L_A28B		;a25f
	ld a,001h		;a261   ; ...a subir: sentido 1, pose 0x0E
	ld b,00eh		;a263
a_la_escalera:		; a la escalera: sentido A, pose B, estado 3
	ld (0e50ch),a		;a265   ; a la escalera: el sentido en 0xE50C...
	xor a			;a268
	ld (0e50bh),a		;a269
	ld (0e522h),a		;a26c
	ld (0e530h),a		;a26f   ; guarda el personaje en guardia (quieto, para los disparos)
	ld a,(0e502h)		;a272   ; ...guarda la pose y hacia donde mira...
	ld (0e50dh),a		;a275
	ld a,(0e503h)		;a278   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld (0e516h),a		;a27b
	ld a,002h		;a27e   ; ...de espaldas (2)...
	ld (0e503h),a		;a280   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld a,003h		;a283   ; ...estado 3
	ld (0e500h),a		;a285   ; guarda el estado del personaje (5 = hundirse)
	jp pose_a_b		;a288   ; pose_a_b: la pose B
L_A28B:
	ld a,(0e008h)		;a28b   ; arriba recien apretado: saltar...
	and 001h		;a28e
	ret z			;a290
	ld a,(0e500h)		;a291   ; lee el estado del personaje (5 = hundirse)
	dec a			;a294
	ret z			;a295
	xor a			;a296   ; ...desde velocidad 0...
	ld (0e509h),a		;a297   ; guarda la velocidad vertical del personaje
	ld (0e50ah),a		;a29a   ; guarda los pasos de la caida
	inc a			;a29d
	ld (0e500h),a		;a29e   ; ...estado 1, con el sonido 1
	ld a,001h		;a2a1
	jp 04e1fh		;a2a3   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A2A6:
	ld a,(0e008h)		;a2a6   ; abajo recien apretado...
	and 002h		;a2a9
	jp z,L_A178		;a2ab
	call escalera_abajo		;a2ae   ; ...con escalera debajo (p03:AEF2)...
	jp nc,L_A178		;a2b1
	ld a,(0e505h)		;a2b4   ; ...ajustado a la casilla...
	and 0f8h		;a2b7
	add a,008h		;a2b9
	ld (0e505h),a		;a2bb   ; guarda la y del personaje
	ld a,002h		;a2be   ; ...a bajar: sentido 2, pose 0x10
	ld b,010h		;a2c0
	jr a_la_escalera		;a2c2
pasos:		; cada 4 cuadros el paso siguiente de la pose
	ld a,(0e508h)		;a2c4   ; cada 4 cuadros el paso siguiente de la pose
	and a			;a2c7
	ret nz			;a2c8
	ld a,(0e604h)		;a2c9   ; lee el contador de cuadros de partida
	and 003h		;a2cc
	ret nz			;a2ce
	jp pose_vuelta		;a2cf   ; pose_vuelta: la pose con el bit 0 cambiado
en_la_escalera:		; estado 3: en la escalera
	ld hl,L_A189		;a2d2   ; estado 3, en la escalera: por el paso 0xE50E
	push hl			;a2d5
	xor a			;a2d6
	ld (0e537h),a		;a2d7
	inc a			;a2da
	ld (0e515h),a		;a2db
	ld a,(0e50eh)		;a2de   ; lee el paso en la escalera
	call 04140h		;a2e1   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld b,001h		;a2ec   ; arriba o abajo apretados...
	ld a,(0e009h)		;a2ee   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	rra			;a2f1
	rra			;a2f2
	and 003h		;a2f3
	jr z,L_A304		;a2f5
	cp 003h		;a2f7
	jr z,L_A304		;a2f9
	dec a			;a2fb
	xor 001h		;a2fc
	ld (0e503h),a		;a2fe   ; ...hacia donde mira...
	inc a			;a301   ; ...y el paso 2 o 3
	inc a			;a302
	ld b,a			;a303
L_A304:
	ld hl,0e50eh		;a304   ; el paso
	ld (hl),b			;a307
	ld a,(0ec12h)		;a308   ; si esta en la figura que sube y baja (0xEC12), la lleva
	and 001h		;a30b
	ld (0e52bh),a		;a30d
	ld a,(0ec10h)		;a310   ; lee la figura de sala en sala que esta en esta sala
	ld (0e52dh),a		;a313   ; guarda la figura que lleva al personaje
	ld a,(0e508h)		;a316   ; la pose de escalera: 4, o 6 con 0xE508
	and a			;a319
	ld b,004h		;a31a
	jr z,L_A320		;a31c
	ld b,006h		;a31e
L_A320:
	call pose_b		;a320   ; pose_b: la pose B, +1 mirando a la izquierda
	ld a,001h		;a323
	ld (0e537h),a		;a325
	ret			;a328
salto:		; estado 1: el salto (control de lado, techo, caida)
	ld a,(0e501h)		;a329   ; estado 1, el salto: Afrodita llega a 0x0C, Popolon a 0x0D...
	and a			;a32c
	ld a,(0e509h)		;a32d   ; lee la velocidad vertical del personaje
	ld b,00ch		;a330
	jr z,L_A336		;a332
	ld b,00dh		;a334
L_A336:
	push bc			;a336   ; ...subiendo aun...
	cp b			;a337
	jr c,L_A376		;a338
	ld a,(0e009h)		;a33a   ; ...izquierda o derecha apretadas...
	rra			;a33d
	rra			;a33e
	and 003h		;a33f
	jr z,L_A376		;a341
	cp 003h		;a343
	jr z,L_A376		;a345
	dec a			;a347   ; ...velocidad 0x100 a un lado...
	ld bc,00100h		;a348
	ld d,001h		;a34b
	jr nz,L_A353		;a34d
	ld bc,0ff00h		;a34f
	inc d			;a352
L_A353:
	call mira_a		;a353   ; ...mirando hacia alli...
	ld a,(0e50eh)		;a356   ; lee el paso en la escalera
	dec a			;a359
	ld e,a			;a35a
	jr z,L_A35E		;a35b
	ld d,a			;a35d
L_A35E:
	ld a,(0e519h)		;a35e   ; ...si no hay pared...
	and d			;a361
	jr nz,L_A376		;a362
	ld a,e			;a364   ; ...al principio del salto, el doble...
	and a			;a365
	jr nz,L_A36C		;a366
	sla c		;a368
	rl b		;a36a
L_A36C:
	ld a,(0e511h)		;a36c   ; ...en el agua, la cuarta parte...
	and a			;a36f
	call nz,cuarta_parte		;a370   ; cuarta_parte: BC / 4
	call x_mas_bc		;a373   ; ...y se mueve
L_A376:
	pop bc			;a376   ; en lo alto del salto...
	dec b			;a377
	dec b			;a378
	ld a,(0e509h)		;a379   ; lee la velocidad vertical del personaje
	cp b			;a37c
	jr nc,L_A3AC		;a37d
	ld a,(0e501h)		;a37f   ; ...Popolon llevado por la figura, hasta 6...
	and a			;a382
	jr z,L_A399		;a383
	ld a,(0e52bh)		;a385
	and a			;a388
	jr z,L_A392		;a389
	ld a,(0e509h)		;a38b   ; lee la velocidad vertical del personaje
	cp 006h		;a38e
	jr c,L_A399		;a390
L_A392:
	ld a,(0e009h)		;a392   ; ...sin arriba apretado se corta el salto...
	and 001h		;a395
	jr z,L_A3A7		;a397
L_A399:
	ld a,(0e505h)		;a399   ; ...y en el techo (y < 0x29 o el bit 2 de 0xE519)
	cp 029h		;a39c
	jr c,L_A3A7		;a39e
	ld a,(0e519h)		;a3a0   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 2,a		;a3a3
	jr z,L_A3F0		;a3a5
L_A3A7:
	ld a,b			;a3a7   ; la velocidad
	ld (0e509h),a		;a3a8   ; guarda la velocidad vertical del personaje
	ret			;a3ab
L_A3AC:
	call subido_a_figura		;a3ac   ; bajando: con suelo debajo...
	jr nz,L_A3C8		;a3af
	ld a,(0e519h)		;a3b1   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 3,a		;a3b4
	jr z,L_A3F0		;a3b6
	call y_a_la_casilla_del_personaje		;a3b8   ; ...p03:BF02 y el mando segun hacia donde mira
	ld a,(0e503h)		;a3bb   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	inc a			;a3be
	xor 001h		;a3bf
	rla			;a3c1
	rla			;a3c2
	and 00ch		;a3c3
	ld (0e52eh),a		;a3c5   ; guarda el mando del personaje (bits 0-3: arriba, abajo, izquierda, derecha)
L_A3C8:
	ld a,(0e500h)		;a3c8   ; al caer al suelo: el sonido 2 (si no venia saltando)...
	dec a			;a3cb
	ld a,002h		;a3cc
	call nz,04e1fh		;a3ce   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	xor a			;a3d1   ; ...en pie
	ld (0e500h),a		;a3d2   ; guarda el estado del personaje (5 = hundirse)
	ld (0e50eh),a		;a3d5   ; guarda el paso en la escalera
	ld (0e52bh),a		;a3d8
	call e530_a_uno		;a3db   ; e530_a_uno: 0xE530 = 1
	ld a,(0e508h)		;a3de   ; lee la espada (1 empieza, 2 golpeando)
	and a			;a3e1
	ret nz			;a3e2
pose_en_pie:		; la pose 0 o 2 segun hacia donde mira
	ld b,000h		;a3e3   ; la pose 0 (derecha) o 2 (izquierda)
	ld a,(0e503h)		;a3e5   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a3e8
	jr z,L_A3ED		;a3e9
	inc b			;a3eb
	inc b			;a3ec
L_A3ED:
	jp pose_a_b		;a3ed   ; pose_a_b: la pose B
L_A3F0:
	ld a,(0e501h)		;a3f0   ; cayendo: la tabla de velocidades 0xA953 (Afrodita, hasta 0x18) o 0xA951 (Popolon, 0x1A)...
	and a			;a3f3
	ld b,018h		;a3f4
	ld de,0a953h		;a3f6
	jr z,L_A400		;a3f9
	ld b,01ah		;a3fb
	ld de,0a951h		;a3fd
L_A400:
	ld hl,0e50ah		;a400   ; ...el paso siguiente...
	inc (hl)			;a403
	ld a,(0e511h)		;a404   ; ...en el agua uno de cada cuatro...
	and a			;a407
	jr z,L_A40F		;a408
	ld a,(hl)			;a40a
	and 003h		;a40b
	jr nz,L_A413		;a40d
L_A40F:
	ld hl,0e509h		;a40f   ; apunta a la velocidad vertical del personaje
	inc (hl)			;a412
L_A413:
	ld a,(0e509h)		;a413   ; ...hasta el tope...
	cp b			;a416
	jr c,L_A41B		;a417
	ld a,b			;a419
	ld (hl),a			;a41a
L_A41B:
	dec a			;a41b
	ret m			;a41c
	ex de,hl			;a41d   ; ...la velocidad de la tabla...
	call 04155h		;a41e   ; byte_de_tabla: A = el byte HL + A
	ld b,a			;a421
	ld c,000h		;a422
	ld a,(0e511h)		;a424   ; ...la cuarta parte en el agua...
	and a			;a427
	call nz,cuarta_parte		;a428   ; cuarta_parte: BC / 4
	ld (0e512h),bc		;a42b   ; ...y la y baja
	ld hl,(0e504h)		;a42f   ; lee la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	add hl,bc			;a432
	ld (0e504h),hl		;a433   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ret			;a436
salto_derecha:		; el salto y a la derecha
	call salto		;a437   ; salto hacia la derecha
	jp L_A201		;a43a
salto_izquierda:		; el salto y a la izquierda
	call salto		;a43d   ; salto hacia la izquierda
	jp L_A1B6		;a440
cuarta_parte:		; BC / 4
	sra b		;a443   ; BC / 4
	rr c		;a445
	sra b		;a447
	rr c		;a449
	ret			;a44b
mira_a:		; mira hacia el lado A
	xor 001h		;a44c   ; mira hacia el lado A (0 derecha, 1 izquierda)...
	ld e,a			;a44e
	ld a,(0e503h)		;a44f   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	cp e			;a452
	ret z			;a453
	ld a,e			;a454
	ld (0e503h),a		;a455   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
pose_vuelta:		; la pose con el bit 0 cambiado
	ld a,(0e502h)		;a458   ; ...y la pose con el bit 0 cambiado
	xor 001h		;a45b
	jp pose_a		;a45d   ; pose_a: la pose A
golpeado:		; golpeado: sale despedido hacia atras y parpadea
	ld a,001h		;a460   ; golpeado: paso 0...
	ld (0e515h),a		;a462
	ld a,(0e50eh)		;a465   ; lee el paso en la escalera
	and a			;a468
	jr nz,L_A4A8		;a469
	ld a,(0e514h)		;a46b   ; ...la pose 0x0C o 0x0A segun el lado del golpe (0xE514)...
	ld b,00ch		;a46e
	and a			;a470
	jr nz,L_A475		;a471
	ld b,00ah		;a473
L_A475:
	call pose_a_b		;a475   ; pose_a_b: la pose B
	ld hl,0fe80h		;a478   ; ...hacia arriba -0x180...
	ld (0e512h),hl		;a47b   ; guarda la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	ld a,(0e514h)		;a47e   ; ...y hacia atras 0x400...
	ld de,0fc00h		;a481
	and a			;a484
	jr z,L_A48A		;a485
	ld de,00400h		;a487
L_A48A:
	ld (0e51eh),de		;a48a   ; guarda la velocidad hacia atras del golpe y el byte siguiente (16 bits)
	ld a,0ffh		;a48e   ; ...0xFF cuadros...
	ld (0e50fh),a		;a490   ; guarda la cuenta del golpe
	inc a			;a493   ; ...todo a cero
	ld (0e508h),a		;a494   ; guarda la espada (1 empieza, 2 golpeando)
	ld (0e530h),a		;a497   ; guarda el personaje en guardia (quieto, para los disparos)
	ld (0e51bh),a		;a49a   ; guarda la espada da en algo
	ld (0e526h),a		;a49d
	ld (0e538h),a		;a4a0
paso_del_personaje:		; sube el paso 0xE50E
	ld hl,0e50eh		;a4a3   ; el paso siguiente
	inc (hl)			;a4a6
	ret			;a4a7
L_A4A8:
	dec a			;a4a8   ; paso 1: en el aire...
	jp nz,L_A536		;a4a9
	ld a,(0e511h)		;a4ac   ; ...en el agua cada 4 cuadros
	and a			;a4af
	jr z,L_A4B8		;a4b0
	ld a,(0e604h)		;a4b2   ; lee el contador de cuadros de partida
	and 003h		;a4b5
	ret nz			;a4b7
L_A4B8:
	ld hl,0e50fh		;a4b8   ; hasta el suelo...
	inc (hl)			;a4bb
	jr z,L_A4CA		;a4bc
	call subido_a_figura		;a4be   ; subido_a_figura: NZ si el personaje esta subido a una figura que se mueve
	jr nz,L_A518		;a4c1
	ld a,(0e519h)		;a4c3   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 3,a		;a4c6
	jr nz,L_A515		;a4c8
L_A4CA:
	ld hl,(0e512h)		;a4ca   ; ...la gravedad 0x80...
	ld de,00080h		;a4cd
	add hl,de			;a4d0
	ld a,h			;a4d1
	bit 7,a		;a4d2
	jr nz,L_A4DC		;a4d4
	ld b,006h		;a4d6   ; ...hasta 6...
	cp b			;a4d8
	jr c,L_A4DC		;a4d9
	ld a,b			;a4db
L_A4DC:
	ld h,a			;a4dc
	ld (0e512h),hl		;a4dd   ; guarda la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	ex de,hl			;a4e0
	ld e,000h		;a4e1
	ld hl,(0e504h)		;a4e3   ; ...la y, no mas arriba de 0x28...
	add hl,de			;a4e6
	ld a,h			;a4e7
	cp 028h		;a4e8
	jr nc,L_A4EE		;a4ea
	ld a,028h		;a4ec
L_A4EE:
	ld h,a			;a4ee
	ld (0e504h),hl		;a4ef   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,(0e50ch)		;a4f2   ; ...y hacia atras, salvo en la escalera...
	and a			;a4f5
	ret nz			;a4f6
	ld a,(0e514h)		;a4f7   ; lee el lado del golpe
	and a			;a4fa
	ld a,(0e519h)		;a4fb   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	jr z,L_A504		;a4fe
	bit 0,a		;a500
	jr L_A506		;a502
L_A504:
	bit 1,a		;a504
L_A506:
	jp nz,para_contra_pared		;a506   ; ...o con pared
	ld hl,(0e506h)		;a509   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld de,(0e51eh)		;a50c   ; lee la velocidad hacia atras del golpe y el byte siguiente (16 bits)
	add hl,de			;a510
	ld (0e506h),hl		;a511   ; guarda la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ret			;a514
L_A515:
	call y_a_la_casilla_del_personaje		;a515   ; y_a_la_casilla_del_personaje: la y del personaje ajustada a la casilla
L_A518:
	xor a			;a518   ; en el suelo: la pose 0x0D o 0x0B...
	ld (0e515h),a		;a519
	ld a,(0e514h)		;a51c   ; lee el lado del golpe
	ld b,00dh		;a51f
	and a			;a521
	jr nz,L_A526		;a522
	ld b,00bh		;a524
L_A526:
	call pose_a_b		;a526   ; pose_a_b: la pose B
	ld a,004h		;a529   ; ...4 cuadros y el sonido 2
	ld (0e50fh),a		;a52b   ; guarda la cuenta del golpe
	ld a,002h		;a52e
	call 04e1fh		;a530   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp paso_del_personaje		;a533   ; paso_del_personaje: sube el paso 0xE50E
L_A536:
	ld hl,0e515h		;a536   ; paso 2: 4 cuadros...
	ld (hl),000h		;a539
	ld hl,0e50fh		;a53b   ; apunta a la cuenta del golpe
	dec (hl)			;a53e
	ret nz			;a53f
	ld a,01eh		;a540   ; ...y queda parpadeando 0x1E cuadros (0xE532, 0xE533)...
	ld (0e532h),a		;a542   ; guarda los cuadros de parpadeo tras un golpe
	ld a,001h		;a545
	ld (0e533h),a		;a547   ; guarda parpadeando
	ld a,(0e514h)		;a54a   ; ...mirando al golpe...
	ld (0e503h),a		;a54d   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	call pose_en_pie		;a550   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
	xor a			;a553   ; ...en pie
	ld (0e500h),a		;a554   ; guarda el estado del personaje (5 = hundirse)
pasos_a_cero:		; 0xE50E, 0xE508 y 0xE50C a cero
	ld (0e50eh),a		;a557   ; guarda el paso en la escalera
	ld (0e508h),a		;a55a   ; guarda la espada (1 empieza, 2 golpeando)
	ld (0e50ch),a		;a55d   ; guarda el sentido en la escalera (1 sube, 2 baja)
e530_a_uno:		; 0xE530 = 1
	ld a,001h		;a560   ; 0xE530 = 1
	ld (0e530h),a		;a562   ; guarda el personaje en guardia (quieto, para los disparos)
	ret			;a565
muerte:		; la muerte: la musica 0x94 y las poses de caer
	ld a,(0e503h)		;a566   ; la muerte: la ultima pose 0x17 o 0x1C segun hacia donde mira...
	and a			;a569
	ld b,017h		;a56a
	jr z,L_A570		;a56c
	ld b,01ch		;a56e
L_A570:
	ld a,(0e50eh)		;a570   ; ...paso 0: la musica 0x94...
	dec a			;a573
	ld hl,0e50fh		;a574   ; apunta a la cuenta del golpe
	jr z,L_A589		;a577
	jp p,L_A59F		;a579
	ld (hl),004h		;a57c
	call 05cc9h		;a57e   ; sin_musica_esperando: 0xE01D-0xE01E a cero
	ld a,094h		;a581
	call 04e1fh		;a583   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A586:
	jp paso_del_personaje		;a586   ; paso_del_personaje: sube el paso 0xE50E
L_A589:
	dec (hl)			;a589   ; ...paso 1: la pose 0x12 o 0x17...
	ret nz			;a58a
	ld a,(0e503h)		;a58b   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a58e
	ld a,012h		;a58f
	jr z,L_A595		;a591
	ld a,017h		;a593
L_A595:
	ld (0e502h),a		;a595   ; guarda la pose del personaje
	ld a,006h		;a598
	ld (0e50fh),a		;a59a   ; guarda la cuenta del golpe
	jr L_A586		;a59d
L_A59F:
	dec a			;a59f   ; ...paso 2: cada 6 cuadros la pose siguiente hasta la ultima...
	jr nz,L_A5B2		;a5a0
	dec (hl)			;a5a2
	ret nz			;a5a3
	ld (hl),006h		;a5a4
	ld hl,0e502h		;a5a6   ; apunta a la pose del personaje
	inc (hl)			;a5a9
	ld a,(hl)			;a5aa
	cp b			;a5ab
	ret nz			;a5ac
	dec (hl)			;a5ad
	ld a,0ffh		;a5ae
	jr L_A595		;a5b0
L_A5B2:
	dec (hl)			;a5b2   ; ...paso 3: se acaba la vida
	ret nz			;a5b3
	xor a			;a5b4
	ld (0e019h),a		;a5b5   ; guarda en juego (a 0 se acaba la vida: estado 6)
	jr pasos_a_cero		;a5b8
llevado:		; llevado por la figura 1 del castillo
	ld a,(0ea01h)		;a5ba   ; en la figura 1 del castillo (0xEA01 = 1), con pared nada...
	dec a			;a5bd
	jr nz,L_A5C6		;a5be
	ld a,(0e519h)		;a5c0   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	and 003h		;a5c3
	ret nz			;a5c5
L_A5C6:
	ld a,(0e529h)		;a5c6   ; ...con 0xE529 despacio (0x100, pose cada 4 cuadros)...
	and a			;a5c9
	ld de,00100h		;a5ca
	ld c,004h		;a5cd
	jr nz,L_A5D6		;a5cf
	ld de,00200h		;a5d1   ; ...si no 0x200...
	ld c,001h		;a5d4
L_A5D6:
	ld a,(0e503h)		;a5d6   ; ...hacia donde mira
	and a			;a5d9
	ld b,000h		;a5da
	jr z,L_A5E3		;a5dc
	ld b,002h		;a5de
	call 0415ch		;a5e0   ; de_negado: DE = -DE
L_A5E3:
	ld hl,(0e506h)		;a5e3   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	add hl,de			;a5e6
	ld (0e506h),hl		;a5e7   ; guarda la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,(0e604h)		;a5ea   ; lee el contador de cuadros de partida
	and c			;a5ed
	jr nz,L_A5F1		;a5ee
	inc b			;a5f0
L_A5F1:
	jp pose_a_b		;a5f1   ; pose_a_b: la pose B
pose_b_mas_bit:		; la pose B + el bit 3 de (HL)
	ld a,(hl)			;a5f4   ; la pose B + el bit 3 de (HL)
	rra			;a5f5
	rra			;a5f6
	rra			;a5f7
	and 001h		;a5f8
	add a,b			;a5fa
	jp pose_a		;a5fb   ; pose_a: la pose A
tiene_11:		; NZ con el objeto 0x11 (y el estado del personaje - 1)
	ld a,(0e080h)		;a5fe   ; NZ con el objeto 0x11 (y si no esta saltando)
	and a			;a601
	ret z			;a602
	ld a,(0e500h)		;a603   ; lee el estado del personaje (5 = hundirse)
	dec a			;a606
	ret			;a607
escalera:		; subir y bajar por la escalera, y bajarse a un lado
	ld a,(0e522h)		;a608   ; en la escalera: el primer cuadro...
	and a			;a60b
	jr z,L_A64E		;a60c
	ld a,(0e519h)		;a60e   ; ...al pisar suelo se baja de ella...
	bit 3,a		;a611
	jr z,L_A652		;a613
	call y_a_la_casilla_del_personaje		;a615   ; y_a_la_casilla_del_personaje: la y del personaje ajustada a la casilla
	ld a,(0e525h)		;a618   ; ...si la figura de 0xEC0F lo pide, 0xEC07 = 1 y el sonido 0x2E...
	dec a			;a61b
	jr nz,L_A635		;a61c
	ld a,(0ec0fh)		;a61e
	cp 003h		;a621
	jr z,L_A62B		;a623
	ld hl,0e50ch		;a625   ; apunta a el sentido en la escalera (1 sube, 2 baja)
	cp (hl)			;a628
	jr nz,L_A635		;a629
L_A62B:
	ld a,001h		;a62b
	ld (0ec07h),a		;a62d
	ld a,02eh		;a630
	call 04e1fh		;a632   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_A635:
	xor a			;a635   ; ...en pie, como estaba antes
	ld (0e50ch),a		;a636   ; guarda el sentido en la escalera (1 sube, 2 baja)
	ld (0e50bh),a		;a639
	ld (0e500h),a		;a63c   ; guarda el estado del personaje (5 = hundirse)
	ld a,(0e516h)		;a63f
	ld (0e503h),a		;a642   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	call e530_a_uno		;a645   ; e530_a_uno: 0xE530 = 1
	ld a,(0e50dh)		;a648
	jp pose_a		;a64b   ; pose_a: la pose A
L_A64E:
	inc a			;a64e
	ld (0e522h),a		;a64f
L_A652:
	ld a,(0e508h)		;a652   ; subiendo o bajando: el mando...
	and a			;a655
	ret nz			;a656
	ld hl,0e50bh		;a657
	inc (hl)			;a65a
	ld a,(0e52eh)		;a65b   ; lee el mando del personaje (bits 0-3: arriba, abajo, izquierda, derecha)
	and 00fh		;a65e
	ret z			;a660
	srl a		;a661   ; ...arriba (bit 0): sube...
	ld b,001h		;a663
	ld c,002h		;a665
	jr c,L_A6B2		;a667
	inc b			;a669   ; ...abajo (bit 1): baja...
	srl a		;a66a
	jr c,L_A6B2		;a66c
	cp 003h		;a66e
	ret z			;a670
	ld b,001h		;a671   ; ...izquierda o derecha: se baja de la escalera hacia ese lado...
	srl a		;a673
	jr c,L_A678		;a675
	dec b			;a677
L_A678:
	ld a,b			;a678
	ld e,a			;a679
	ld (0e503h),a		;a67a   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	call pose_en_pie		;a67d   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
	ld a,e			;a680
	and a			;a681
	ld hl,0e519h		;a682   ; apunta a las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
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
	ld a,(0e505h)		;a695   ; ...si la casilla de al lado es pared (>= 0xBA) no
	add a,005h		;a698
	ld l,a			;a69a
	ld a,(0e507h)		;a69b   ; lee la x del personaje
	add a,d			;a69e
	ld h,a			;a69f
	call 04da1h		;a6a0   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;a6a3
	cp 0bah		;a6a4
	ret c			;a6a6
	xor a			;a6a7   ; en pie, a un lado de la escalera
	ld (0e500h),a		;a6a8   ; guarda el estado del personaje (5 = hundirse)
	ld a,(0e507h)		;a6ab   ; lee la x del personaje
	add a,e			;a6ae
	jp L_A893		;a6af
L_A6B2:
	ld a,c			;a6b2   ; de espaldas...
	ld (0e503h),a		;a6b3   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld a,(0e080h)		;a6b6   ; ...a 0x100, o 0x140 con el objeto 0x11...
	ld de,00100h		;a6b9
	and a			;a6bc
	jr z,L_A6C2		;a6bd
	ld de,00140h		;a6bf
L_A6C2:
	ld a,b			;a6c2   ; ...hacia arriba o hacia abajo...
	ld (0e50ch),a		;a6c3   ; guarda el sentido en la escalera (1 sube, 2 baja)
	dec a			;a6c6
	call z,0415ch		;a6c7   ; de_negado: DE = -DE
	ld hl,(0e504h)		;a6ca   ; ...entre la y 0x27 y la 0xC0
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
	ld (0e504h),hl		;a6da   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,(0e50ch)		;a6dd   ; la pose 0x0E (sube) o 0x10 (baja), un paso cada 8 pixeles
	dec a			;a6e0
	ld b,00eh		;a6e1
	jr z,L_A6E7		;a6e3
	ld b,010h		;a6e5
L_A6E7:
	jp pose_b_mas_bit		;a6e7   ; pose_b_mas_bit: la pose B + el bit 3 de (HL)
tiembla:		; un pixel a cada lado cada 2 cuadros
	xor a			;a6ea   ; temblando: un pixel a cada lado cada 2 cuadros...
	ld (0e51bh),a		;a6eb   ; guarda la espada da en algo
	ld (0e526h),a		;a6ee
	ld (0e538h),a		;a6f1
	ld a,(0e604h)		;a6f4   ; lee el contador de cuadros de partida
	bit 1,a		;a6f7
	ld a,(0e507h)		;a6f9   ; lee la x del personaje
	ld b,001h		;a6fc
	jr z,L_A702		;a6fe
	ld b,0ffh		;a700
L_A702:
	add a,b			;a702
	ld (0e507h),a		;a703   ; guarda la x del personaje
	ld hl,0e50fh		;a706   ; ...hasta que acaba la cuenta
	dec (hl)			;a709
	ret nz			;a70a
	xor a			;a70b
	ld (0e500h),a		;a70c   ; guarda el estado del personaje (5 = hundirse)
	ld (0e518h),a		;a70f   ; guarda sin daño (tras un golpe o al entrar)
	jp e530_a_uno		;a712   ; e530_a_uno: 0xE530 = 1
armas:		; la espada (boton A) y el arma elegida (boton B)
	call botones		;a715   ; las armas: el boton A, la espada; el B, el arma elegida
	call golpe_de_espada		;a718   ; golpe_de_espada: el golpe de espada cada cuadro
	jp armas_cada_cuadro		;a71b   ; armas_cada_cuadro: las armas en pantalla cada cuadro
botones:		; boton A la espada, boton B el arma
	ld a,(0e008h)		;a71e   ; boton A (bit 4): la espada
	bit 4,a		;a721
	push af			;a723
	call nz,espada		;a724   ; espada: empieza un golpe de espada (sonido 0x13)
	pop af			;a727
	bit 5,a		;a728   ; boton B (bit 5): el arma...
	ret z			;a72a
	ld a,(0e510h)		;a72b   ; ...la 6 no se dispara...
	cp 006h		;a72e
	ret z			;a730
	cp 005h		;a731   ; ...la 5 por p03:A96D...
	jr nz,L_A73A		;a733
	call dispara_arma_5		;a735   ; dispara_arma_5: el arma 5 en un hueco de 0xE5A0
	jr L_A73D		;a738
L_A73A:
	call dispara_arma		;a73a   ; ...las demas por p03:A976
L_A73D:
	ld a,b			;a73d   ; con hueco libre (IY), su tipo
	and a			;a73e
	ret z			;a73f
	ld a,(0e510h)		;a740   ; lee el arma elegida
	ld (iy+000h),a		;a743
	ret			;a746
espada:		; empieza un golpe de espada (sonido 0x13)
	ld hl,0e508h		;a747   ; la espada: no si ya esta dando...
	ld a,(hl)			;a74a
	and a			;a74b
	ret nz			;a74c
	ld a,(0e500h)		;a74d   ; ...ni en los estados 4 y siguientes, ni de espaldas en la escalera
	cp 003h		;a750
	jr c,L_A75B		;a752
	ret nz			;a754
	ld a,(0e503h)		;a755   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	cp 002h		;a758
	ret nc			;a75a
L_A75B:
	xor a			;a75b   ; el golpe: 0xE508 = 1...
	ld (0e530h),a		;a75c   ; guarda el personaje en guardia (quieto, para los disparos)
	inc a			;a75f
	ld (hl),a			;a760
	ld (0e51bh),a		;a761   ; guarda la espada da en algo
	ld (0e526h),a		;a764
	ld (0e538h),a		;a767
	ld a,013h		;a76a   ; ...con el sonido 0x13
	jp 04e1fh		;a76c   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
golpe_de_espada:		; el golpe de espada cada cuadro
	xor a			;a76f   ; la espada cada cuadro...
	ld (0e523h),a		;a770   ; guarda el tercer sprite escondido
	ld hl,0e508h		;a773   ; apunta a la espada (1 empieza, 2 golpeando)
	ld a,(hl)			;a776
	dec a			;a777   ; ...el primero: la pose de golpe (8, o 6 saltando)...
	jr nz,L_A7C8		;a778
	ld b,008h		;a77a
	ld a,(0e500h)		;a77c   ; lee el estado del personaje (5 = hundirse)
	dec a			;a77f
	jr nz,L_A784		;a780
	ld b,006h		;a782
L_A784:
	call pose_b		;a784   ; pose_b: la pose B, +1 mirando a la izquierda
	ld a,004h		;a787   ; ...4 cuadros
	ld (0e50fh),a		;a789   ; guarda la cuenta del golpe
	ld a,001h		;a78c
	inc (hl)			;a78e
punta_de_la_espada:		; la punta de la espada; en pared, nada
	ld a,(0e500h)		;a78f   ; la punta de la espada: 0x12 delante (0x15 en el suelo)...
	ld c,012h		;a792
	dec a			;a794
	jr z,L_A799		;a795
	ld c,015h		;a797
L_A799:
	ld a,(0e503h)		;a799   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;a79c
	jr z,L_A7A9		;a79d
	ld a,(0e507h)		;a79f   ; lee la x del personaje
	sub c			;a7a2
	jr c,L_A7C1		;a7a3
	add a,006h		;a7a5
	jr L_A7B1		;a7a7
L_A7A9:
	ld a,(0e507h)		;a7a9   ; lee la x del personaje
	add a,c			;a7ac
	jr c,L_A7C1		;a7ad
	sub 006h		;a7af
L_A7B1:
	ld h,a			;a7b1
	ld a,(0e505h)		;a7b2   ; ...a la altura de la y - 8...
	sub 008h		;a7b5
	ld l,a			;a7b7
	call 04dc8h		;a7b8   ; ...si da en pared (> 0xB9), 0xE51B a 0
	ret nc			;a7bb
L_A7BC:
	xor a			;a7bc
	ld (0e51bh),a		;a7bd   ; guarda la espada da en algo
	ret			;a7c0
L_A7C1:
	ld a,001h		;a7c1   ; fuera de la pantalla: 0xE523 = 1 (el tercer sprite se esconde)
	ld (0e523h),a		;a7c3   ; guarda el tercer sprite escondido
	jr L_A7BC		;a7c6
L_A7C8:
	ld hl,0e538h		;a7c8   ; los siguientes cuadros...
	ld (hl),000h		;a7cb
	dec a			;a7cd
	ret nz			;a7ce
	call punta_de_la_espada		;a7cf   ; punta_de_la_espada: la punta de la espada; en pared, nada
	ld hl,0e50fh		;a7d2   ; ...a los 4, se acaba el golpe
	dec (hl)			;a7d5
	ret nz			;a7d6
	xor a			;a7d7
	ld (0e508h),a		;a7d8   ; guarda la espada (1 empieza, 2 golpeando)
	ld (0e51bh),a		;a7db   ; guarda la espada da en algo
	ld (0e526h),a		;a7de
	call e530_a_uno		;a7e1   ; e530_a_uno: 0xE530 = 1
	ld a,(0e500h)		;a7e4   ; lee el estado del personaje (5 = hundirse)
	dec a			;a7e7
	jp nz,pose_en_pie		;a7e8   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
	ld a,(0e503h)		;a7eb   ; saltando: la pose 4 o 5
	ld b,004h		;a7ee
	and a			;a7f0
	jr z,L_A7F5		;a7f1
	ld b,005h		;a7f3
L_A7F5:
	jp pose_a_b		;a7f5   ; pose_a_b: la pose B
sale_de_la_sala:		; por que lado sale de la sala (0xE01A)
	xor a			;a7f8   ; salir de la sala: no hundiendose ni en el estado 6
	ld (0e52ch),a		;a7f9   ; guarda la figura que lo lleva al salir de la sala
	ld a,(0e500h)		;a7fc   ; lee el estado del personaje (5 = hundirse)
	cp 005h		;a7ff
	ret z			;a801
	cp 006h		;a802
	ret z			;a804
	ld b,006h		;a805   ; llevado por una de las figuras de 0xE4A0 (bit 2)...
	ld hl,0e4a2h		;a807
L_A80A:
	bit 2,(hl)		;a80a
	jr nz,L_A84A		;a80c
	ld de,00010h		;a80e   ; ...las seis
	add hl,de			;a811
	djnz L_A80A		;a812
	dec a			;a814   ; saltando sin figura, o en la escalera subiendo...
	jr nz,L_A81F		;a815
	ld a,(0e52bh)		;a817
	and a			;a81a
	jr z,L_A82A		;a81b
	jr L_A823		;a81d
L_A81F:
	cp 002h		;a81f
	jr nz,L_A82A		;a821
L_A823:
	ld a,(0e505h)		;a823   ; ...por arriba (y < 0x28)
	cp 028h		;a826
	jr c,L_A84E		;a828
L_A82A:
	ld a,(0e505h)		;a82a   ; por abajo (y >= 0xC0)
	cp 0c0h		;a82d
	jr nc,L_A865		;a82f
	ld a,(0e507h)		;a831   ; por la izquierda (x < 0x10)
	cp 010h		;a834
	jr c,L_A874		;a836
	cp 0f8h		;a838   ; por la derecha (x >= 0xF8)...
	ret c			;a83a
	ld a,(0e64bh)		;a83b   ; ...si hay vecina (0xFF: no)...
	inc a			;a83e
	jr z,L_A881		;a83f
	call fuera_del_mundo		;a841   ; ...lado 4
	ld a,004h		;a844
L_A846:
	ld (0e01ah),a		;a846   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	ret			;a849
L_A84A:
	bit 1,(hl)		;a84a   ; la figura sube o baja
	jr z,L_A865		;a84c
L_A84E:
	ld a,(0e648h)		;a84e   ; arriba: la vecina 0xE648...
	inc a			;a851
	ret z			;a852
	ld b,a			;a853
	ld a,(0e52bh)		;a854   ; ...con la figura (0xE52C)...
	and a			;a857
	jr z,L_A85D		;a858
	ld (0e52ch),a		;a85a   ; guarda la figura que lo lleva al salir de la sala
L_A85D:
	ld a,b			;a85d   ; ...lado 1
	call fuera_del_mundo		;a85e   ; fuera_del_mundo: vecina 0xF6 o mas: estado 0x0D
	ld a,001h		;a861
	jr L_A846		;a863
L_A865:
	ld a,(0e649h)		;a865   ; abajo: 0xE649, lado 2
	inc a			;a868
	ret z			;a869
	call fuera_del_mundo		;a86a   ; fuera_del_mundo: vecina 0xF6 o mas: estado 0x0D
	ld a,002h		;a86d
	jr L_A846		;a86f
L_A871:
	jp muere		;a871   ; muere: la vida y la experiencia del que juega a cero
L_A874:
	ld a,(0e64ah)		;a874   ; izquierda: 0xE64A, lado 3
	inc a			;a877
	jr z,L_A88B		;a878
	call fuera_del_mundo		;a87a   ; fuera_del_mundo: vecina 0xF6 o mas: estado 0x0D
	ld a,003h		;a87d
	jr L_A846		;a87f
L_A881:
	ld a,(0e507h)		;a881   ; sin vecina a la derecha, tope en 0xF8
	cp 0f8h		;a884
	ret c			;a886
	ld a,0f8h		;a887
	jr L_A893		;a889
L_A88B:
	ld a,(0e507h)		;a88b   ; sin vecina a la izquierda, tope en 0x0F
	cp 010h		;a88e
	ret nc			;a890
	ld a,00fh		;a891
L_A893:
	ld (0e507h),a		;a893   ; guarda la x del personaje
	ret			;a896
fuera_del_mundo:		; vecina 0xF6 o mas: estado 0x0D
	cp 0f6h		;a897   ; una vecina 0xF6 o mas: fuera del mundo (estado 0x0D)
	ret c			;a899
	ld a,002h		;a89a
	ld (0e01fh),a		;a89c   ; guarda 1 = estado 8, 2 = estado 0x0D
	ret			;a89f
cambia_izquierda_derecha:		; en el mapa 9 sin el objeto 0x13 cambia los bits 2 y 3 del mando
	ld a,(0e041h)		;a8a0   ; en el mapa 9...
	cp 009h		;a8a3
	ret nz			;a8a5
	ld a,(0e082h)		;a8a6   ; ...sin el objeto 0x13...
	or a			;a8a9
	ret nz			;a8aa
	ld a,(0e009h)		;a8ab   ; ...lo apretado...
	call cambia_bits_2_3		;a8ae   ; cambia_bits_2_3: los bits 2 y 3 de A cambiados
	ld (0e009h),a		;a8b1   ; guarda lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	ld a,(0e008h)		;a8b4   ; ...y lo recien apretado, con izquierda y derecha cambiadas
	call cambia_bits_2_3		;a8b7   ; cambia_bits_2_3: los bits 2 y 3 de A cambiados
	ld (0e008h),a		;a8ba   ; guarda lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	ret			;a8bd
cambia_bits_2_3:		; los bits 2 y 3 de A cambiados
	ld b,a			;a8be   ; el bit 2 al 3...
	rla			;a8bf
	and 008h		;a8c0
	ld c,a			;a8c2
	ld a,b			;a8c3   ; ...el 3 al 2...
	rra			;a8c4
	and 004h		;a8c5
	or c			;a8c7
	ld c,a			;a8c8
	ld a,b			;a8c9   ; ...y los demas como estaban
	and 0f3h		;a8ca
	or c			;a8cc
	ret			;a8cd
subido_a_figura:		; NZ si el personaje esta subido a una figura que se mueve
	ld a,(0ec12h)		;a8ce   ; NZ si el personaje esta subido a una figura que se mueve (0xEC12, 0xEC22)
	ld c,a			;a8d1
	ld a,(0ec22h)		;a8d2
	or c			;a8d5
	bit 0,a		;a8d6
	ret			;a8d8
mando_del_personaje:		; el mando del personaje en 0xE52E
	ld hl,0e52eh		;a8d9   ; el mando del personaje: lo apretado...
	ld a,(0e009h)		;a8dc   ; lee lo apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and 00fh		;a8df
	ld b,a			;a8e1
	jr z,L_A8F0		;a8e2
	ld a,(0e008h)		;a8e4   ; ...si no hay nada nuevo y ya iba en esa direccion, sigue
	and 00fh		;a8e7
	jr nz,L_A8F0		;a8e9
	ld a,b			;a8eb
	and (hl)			;a8ec
	jr nz,L_A8F0		;a8ed
	ld a,b			;a8ef
L_A8F0:
	ld (hl),a			;a8f0
	ret			;a8f1
parpadeo:		; cuenta el parpadeo tras un golpe
	ld a,(0e533h)		;a8f2   ; el parpadeo tras un golpe: cuenta 0xE532...
	and a			;a8f5
	ret z			;a8f6
	ld hl,0e532h		;a8f7   ; apunta a los cuadros de parpadeo tras un golpe
	dec (hl)			;a8fa
	ret nz			;a8fb
sin_parpadeo:		; 0xE533 y 0xE518 a 0
	xor a			;a8fc   ; sin parpadeo
	ld (0e533h),a		;a8fd   ; guarda parpadeando
	ld (0e518h),a		;a900   ; guarda sin daño (tras un golpe o al entrar)
	ret			;a903
guarda_pose:		; guarda la pose y pone la B
	ld a,(0e502h)		;a904   ; guarda la pose...
	ld (0e50dh),a		;a907
pose_b:		; la pose B, +1 mirando a la izquierda
	ld a,(0e503h)		;a90a   ; ...la pose B, +1 mirando a la izquierda
	and a			;a90d
	jr z,pose_a_b		;a90e
	inc b			;a910
pose_a_b:		; la pose B
	ld a,b			;a911
pose_a:		; la pose A
	ld (0e502h),a		;a912   ; guarda la pose del personaje
	ret			;a915
llevado_por_figura:		; subido a una figura, se mueve con ella
	ld ix,0ec10h		;a916   ; subido a una figura que se mueve (0xEC10 y 0xEC20)...
	exx			;a91a
	ld b,002h		;a91b
	ld de,00010h		;a91d
L_A920:
	exx			;a920
	call llevado_por_una		;a921   ; una figura...
	exx			;a924
	add ix,de		;a925   ; ...y la siguiente
	djnz L_A920		;a927
	exx			;a929
	ret			;a92a
llevado_por_una:		; si la figura IX lo lleva, su y y su velocidad
	ld a,(ix+000h)		;a92b
	and a			;a92e
	ret z			;a92f
	bit 0,(ix+002h)		;a930   ; ...la que lo lleva (bit 0)...
	ret z			;a934
	ld l,(ix+004h)		;a935   ; ...le da su y...
	ld h,(ix+005h)		;a938
	ld (0e504h),hl		;a93b   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	bit 7,(ix+002h)		;a93e   ; ...y si se mueve de lado, su velocidad
	ret nz			;a942
	ld c,(ix+00ah)		;a943
	ld b,(ix+00bh)		;a946
x_mas_bc:		; la x del personaje + BC
	ld hl,(0e506h)		;a949   ; la x + BC
L_A94C:
	add hl,bc			;a94c
	ld (0e506h),hl		;a94d   ; guarda la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
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


dispara_arma_5:		; el arma 5 en un hueco de 0xE5A0
	ld iy,0e5a0h		;a96d   ; el arma 5: en los huecos de 0xE5A0
	call cabe_arma_5		;a971   ; cabe_arma_5: Z si no hay flechas o ya hay tres (dos con Popolon sin el objeto 0x1E)
	jr L_A97D		;a974
dispara_arma:		; las armas 1-4 en un hueco de 0xE540
	ld iy,0e540h		;a976   ; las demas: en los de 0xE540
	call cabe_arma		;a97a   ; cabe_arma: Z si no hay flechas o ya hay tres (dos con Popolon sin el objeto 0x1D)
L_A97D:
	ret z			;a97d   ; sin sitio, nada
	ld b,003h		;a97e   ; el primer hueco libre de los tres...
L_A980:
	ld a,(iy+000h)		;a980
	and a			;a983
	jr nz,L_A98D		;a984
	ld a,001h		;a986   ; ...paso 1, y una mas en pantalla
	ld (iy+001h),a		;a988
	inc (hl)			;a98b
	ret			;a98c
L_A98D:
	ld de,00020h		;a98d
	add iy,de		;a990
	djnz L_A980		;a992
	ret			;a994
cabe_arma:		; Z si no hay flechas o ya hay tres (dos con Popolon sin el objeto 0x1D)
	ld hl,(0e046h)		;a995   ; sin flechas no se dispara
	ld a,h			;a998
	or l			;a999
	jr z,L_A9CB		;a99a
	ld b,003h		;a99c   ; tres a la vez...
	ld de,0e08ch		;a99e   ; apunta a tiene el objeto 0x1D
	ld hl,0e51ch		;a9a1   ; apunta a las armas 1-4 en pantalla
	ld a,(0e510h)		;a9a4   ; ...las armas 1 y 2 con el objeto 0x1D...
	dec a			;a9a7
	cp 002h		;a9a8
	jr nc,L_A9C1		;a9aa
	jr L_A9BD		;a9ac
cabe_arma_5:		; Z si no hay flechas o ya hay tres (dos con Popolon sin el objeto 0x1E)
	ld hl,(0e046h)		;a9ae   ; el arma 5: sin flechas no...
	ld a,h			;a9b1
	or l			;a9b2
	jr z,L_A9CB		;a9b3
	ld b,003h		;a9b5
	ld de,0e08dh		;a9b7   ; ...tres con el objeto 0x1E
	ld hl,0e51dh		;a9ba   ; apunta a las armas 5 en pantalla
L_A9BD:
	ld a,(de)			;a9bd
	and a			;a9be
	jr nz,L_A9C8		;a9bf
L_A9C1:
	ld a,(0e501h)		;a9c1   ; sin el objeto, Popolon solo dos
	and a			;a9c4
	jr z,L_A9C8		;a9c5
	dec b			;a9c7
L_A9C8:
	ld a,(hl)			;a9c8   ; Z si ya hay tantas en pantalla
	cp b			;a9c9
	ret c			;a9ca
L_A9CB:
	ld b,000h		;a9cb
	xor a			;a9cd
	ret			;a9ce
armas_cada_cuadro:		; las armas en pantalla cada cuadro
	call arma_6		;a9cf   ; las armas cada cuadro: los seis huecos...
	ld iy,0e540h		;a9d2   ; apunta a tres huecos de 32 bytes (armas)
	exx			;a9d6
	ld b,006h		;a9d7
	ld de,00020h		;a9d9
L_A9DC:
	exx			;a9dc
	call arma		;a9dd   ; arma: un arma por su tipo
	exx			;a9e0
	add iy,de		;a9e1
	djnz L_A9DC		;a9e3
	exx			;a9e5
	ld iy,0e540h		;a9e6   ; ...y cuantas hay en cada grupo (0xE51C, 0xE51D)
	ld hl,0e51ch		;a9ea   ; apunta a las armas 1-4 en pantalla
	call cuenta_armas		;a9ed   ; cuenta_armas: cuantas armas hay en los tres huecos de IY
	ld iy,0e5a0h		;a9f0   ; apunta a tres huecos de 32 bytes de tres sprites
	ld hl,0e51dh		;a9f4   ; apunta a las armas 5 en pantalla
cuenta_armas:		; cuantas armas hay en los tres huecos de IY
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
arma:		; un arma por su tipo
	bit 1,(iy+002h)		;aa0a   ; por su tipo (tabla que sigue)
	ret nz			;aa0e
	ld a,(iy+000h)		;aa0f
	and a			;aa12
	ret z			;aa13
	dec a			;aa14
	call 04140h		;aa15   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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


arma_1:		; el arma 1: vuela recta a 0x800
	ld a,(iy+001h)		;aa22   ; el arma 1, paso 1: sale...
	dec a			;aa25
	jp nz,L_AAA5		;aa26
	ld a,(0e500h)		;aa29   ; ...no en los estados 4 y siguientes ni de espaldas...
	cp 004h		;aa2c
	jp nc,acaba_arma		;aa2e   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(0e503h)		;aa31   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	cp 002h		;aa34
	jp nc,acaba_arma		;aa36   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld bc,00800h		;aa39   ; ...velocidad 0x800, dibujo 0x44, color 15...
	ld de,0440fh		;aa3c
	ld a,(0e503h)		;aa3f   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;aa42
	jr z,L_AA49		;aa43
	ld b,0f8h		;aa45   ; ...a la izquierda -0x800 y dibujo 0x4B
	ld d,04bh		;aa47
L_AA49:
	ld (iy+010h),a		;aa49   ; hacia donde mira...
	ld (iy+00eh),c		;aa4c   ; ...la velocidad de lado...
	ld (iy+00fh),b		;aa4f
	ld a,001h		;aa52   ; ...en vuelo (bit 0)...
	ld (iy+002h),a		;aa54
	ld (iy+00ah),d		;aa57   ; ...su dibujo y color
	ld (iy+00bh),e		;aa5a
	ld a,(0e505h)		;aa5d   ; ...a la altura del personaje - 8 (desde la fila 0x20)...
	sub 008h		;aa60
	and 0f8h		;aa62   ; a la casilla
	cp 020h		;aa64
	jr nc,L_AA6A		;aa66
	ld a,020h		;aa68
L_AA6A:
	ld (iy+005h),a		;aa6a
	ld a,(0e503h)		;aa6d   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;aa70
	ld b,0f8h		;aa71
	jr nz,L_AA77		;aa73
	ld b,000h		;aa75
L_AA77:
	ld a,(0e507h)		;aa77   ; ...desde su x...
	add a,b			;aa7a
	ld (iy+007h),a		;aa7b
	inc (iy+001h)		;aa7e
	ld a,(iy+000h)		;aa81   ; ...el sonido 0x14 (0x15 las demas)
	dec a			;aa84
	ld a,015h		;aa85
	jr nz,L_AA8B		;aa87
	ld a,014h		;aa89
L_AA8B:
	call 04e1fh		;aa8b   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
gasta_flecha:		; una flecha menos, salvo con el jefe y el objeto 0x09
	ld a,(0e0d2h)		;aa8e   ; gasta una flecha, salvo con el jefe y el objeto 0x09
	or a			;aa91
	jr z,L_AA99		;aa92
	ld a,(0e078h)		;aa94   ; lee tiene el objeto 0x09
	or a			;aa97
	ret nz			;aa98
L_AA99:
	ld hl,0e046h		;aa99   ; apunta a las flechas (BCD)
	ld bc,00001h		;aa9c
	call 09234h		;aa9f   ; resta_bcd: (HL) -= BC en BCD
	jp 05f79h		;aaa2   ; pinta_flechas: las flechas en la fila 0, columna 24
L_AAA5:
	ld a,(iy+007h)		;aaa5   ; volando: en pared se acaba
	bit 7,(iy+00fh)		;aaa8
	jr z,L_AAAF		;aaac
	dec a			;aaae
L_AAAF:
	ld h,a			;aaaf
	ld l,(iy+005h)		;aab0
	call casilla_mayor_b9		;aab3   ; casilla_mayor_b9: C si el caracter de la casilla (y L, x H) pasa de 0xB9
	jp c,acaba_arma		;aab6   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	inc hl			;aab9
	call caracter_mayor_b9		;aaba   ; caracter_mayor_b9: C si (HL) pasa de 0xB9
	jp c,acaba_arma		;aabd   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ret			;aac0
L_AAC1:
	inc hl			;aac1
	call caracter_mayor_b9		;aac2   ; caracter_mayor_b9: C si (HL) pasa de 0xB9
	jp c,acaba_arma		;aac5   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
arma_2:		; el arma 2: vuela recta a 0x400
	ld a,(iy+001h)		;aac8   ; el arma 2: como la 1, a 0x400, dibujos 0x46 y 0x4D
	dec a			;aacb
	jr nz,L_AAA5		;aacc
	ld a,(0e500h)		;aace   ; lee el estado del personaje (5 = hundirse)
	cp 004h		;aad1
	jp nc,acaba_arma		;aad3   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(0e503h)		;aad6   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	cp 002h		;aad9
	jp nc,acaba_arma		;aadb   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld bc,00400h		;aade
	ld de,0460fh		;aae1
	ld a,(0e503h)		;aae4   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	and a			;aae7
	jp z,L_AA49		;aae8
	ld b,0fch		;aaeb
	ld d,04dh		;aaed
	jp L_AA49		;aaef
arma_3:		; el arma 3: rueda por el suelo y las paredes
	ld b,04ch		;aaf2   ; el arma 3: su dibujo...
	call dibujo_cada_8		;aaf4   ; dibujo_cada_8: el dibujo B cambiando cada 8 cuadros
	ld a,(iy+001h)		;aaf7
	dec a			;aafa
	jr nz,L_AB47		;aafb
	call se_puede_poner		;aafd   ; ...paso 1: si hay sitio...
	jp nz,acaba_arma		;ab00   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld hl,(0e504h)		;ab03   ; ...sale del personaje...
	ld (iy+004h),l		;ab06
	ld a,h			;ab09
	sub 008h		;ab0a
	ld (iy+005h),a		;ab0c
	ld hl,(0e506h)		;ab0f   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,h			;ab12
	sub 004h		;ab13
	ld (iy+006h),l		;ab15
	ld (iy+007h),a		;ab18
	ld (iy+017h),a		;ab1b
	ld a,(0e503h)		;ab1e   ; ...hacia donde mira, 4 o -4...
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
	ld (iy+014h),080h		;ab39   ; ...rodando por el suelo
	ld (iy+00bh),00ah		;ab3d
	inc (iy+001h)		;ab41
	jp L_ACD6		;ab44
L_AB47:
	dec a			;ab47   ; paso 2: avanza hasta el borde del suelo...
	jr nz,L_AB81		;ab48
	call pared_delante_arma		;ab4a   ; pared_delante_arma: C con pared delante del arma
	jp c,acaba_arma		;ab4d   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(iy+01ah)		;ab50
	and a			;ab53
	jr nz,L_AB6D		;ab54
	ld a,(iy+007h)		;ab56
	bit 7,(iy+00fh)		;ab59
	jr z,L_AB67		;ab5d
	cp (iy+017h)		;ab5f
	jp c,acaba_arma		;ab62   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	jr L_AB6D		;ab65
L_AB67:
	cp (iy+017h)		;ab67
	jp nc,acaba_arma		;ab6a   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
L_AB6D:
	ld b,008h		;ab6d   ; ...y baja por el
	call pared_debajo_arma		;ab6f   ; pared_debajo_arma: C con pared debajo del arma
	ret c			;ab72
	call x_a_la_casilla		;ab73   ; x_a_la_casilla: la x del arma ajustada a la casilla
	ld (iy+00dh),004h		;ab76
	ld (iy+00fh),000h		;ab7a
	jp L_AD00		;ab7e
L_AB81:
	dec a			;ab81   ; paso 3: rodea las paredes...
	jr nz,L_ABE0		;ab82
	ld a,(iy+01ah)		;ab84
	and a			;ab87
	jp z,acaba_arma		;ab88   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	bit 7,(iy+00dh)		;ab8b
	jr nz,L_AB98		;ab8f
	ld b,008h		;ab91
	call casilla_arma_b		;ab93   ; casilla_arma_b: C si la casilla (x + 4, y + B) pasa de 0xB9
	jr L_AB9D		;ab96
L_AB98:
	ld b,0ffh		;ab98
	call casilla_arma_b		;ab9a   ; casilla_arma_b: C si la casilla (x + 4, y + B) pasa de 0xB9
L_AB9D:
	jp c,acaba_arma		;ab9d   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	bit 7,(iy+019h)		;aba0
	jr nz,L_ABAE		;aba4
	ld b,0ffh		;aba6
	call pared_columna_arma		;aba8   ; pared_columna_arma: C con pared en la columna del arma
	ret c			;abab
	jr L_ABB4		;abac
L_ABAE:
	ld b,008h		;abae
	call pared_columna_arma		;abb0   ; pared_columna_arma: C con pared en la columna del arma
	ret c			;abb3
L_ABB4:
	call y_a_la_casilla		;abb4   ; ...y da la vuelta
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
	ld a,(iy+019h)		;abd0   ; la vuelta: la velocidad de lado al reves...
	neg		;abd3
	ld (iy+019h),a		;abd5
	ld (iy+00fh),a		;abd8
	ld (iy+00dh),000h		;abdb   ; ...y sin la vertical
	ret			;abdf
L_ABE0:
	call pared_delante_arma		;abe0   ; paso 4: sube
	jp c,acaba_arma		;abe3   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld b,0ffh		;abe6
	call pared_debajo_arma		;abe8   ; pared_debajo_arma: C con pared debajo del arma
	ret c			;abeb
	call x_a_la_casilla		;abec   ; x_a_la_casilla: la x del arma ajustada a la casilla
	ld (iy+00dh),0fch		;abef
	ld (iy+00fh),000h		;abf3
	dec (iy+001h)		;abf7
	ret			;abfa
arma_4:		; el arma 4: sale delante, cae y rueda
	ld a,(iy+001h)		;abfb   ; el arma 4, paso 1: si hay sitio...
	dec a			;abfe
	jr nz,L_AC40		;abff
	call en_suelo_firme		;ac01   ; en_suelo_firme: Z en pie y no subido a una figura
	jp nz,acaba_arma		;ac04   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(0e505h)		;ac07   ; ...sale delante del personaje...
	sub 008h		;ac0a
	ld (iy+005h),a		;ac0c
	ld a,(0e507h)		;ac0f   ; lee la x del personaje
	sub 008h		;ac12
	ld (iy+007h),a		;ac14
	ld bc,03004h		;ac17   ; ...dibujo 0x30 y 4 a la derecha, o 0x88 y -4...
	ld a,(0e503h)		;ac1a   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
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
	ld (iy+014h),080h		;ac36   ; ...y al paso siguiente con el sonido 0x16
	inc (iy+001h)		;ac3a
	jp L_ACD6		;ac3d
L_AC40:
	ex af,af'			;ac40   ; vuela: su dibujo segun el lado...
	ld a,(iy+010h)		;ac41
	ld b,030h		;ac44
	and a			;ac46
	jr z,L_AC4B		;ac47
	ld b,088h		;ac49
L_AC4B:
	call dibujo_cada_8		;ac4b   ; dibujo_cada_8: el dibujo B cambiando cada 8 cuadros
	ex af,af'			;ac4e
	dec a			;ac4f   ; ...paso 2: avanza y cae hasta el suelo...
	jr nz,L_AC80		;ac50
	call pared_delante_arma		;ac52   ; pared_delante_arma: C con pared delante del arma
	jp c,acaba_arma		;ac55   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(iy+018h)		;ac58
	ld (iy+00eh),a		;ac5b
	ld a,(iy+019h)		;ac5e
	ld (iy+00fh),a		;ac61
	xor a			;ac64
	ld (iy+00ch),a		;ac65
	ld (iy+00dh),a		;ac68
	ld b,004h		;ac6b
	call pared_debajo_arma		;ac6d   ; pared_debajo_arma: C con pared debajo del arma
	ret c			;ac70
	xor a			;ac71
	ld (iy+00eh),a		;ac72
	ld (iy+00fh),a		;ac75
	ld a,004h		;ac78   ; ...paso 3: rueda por el suelo
	ld (iy+00dh),a		;ac7a
	jp L_AD00		;ac7d
L_AC80:
	ld b,004h		;ac80
	call pared_debajo_arma		;ac82   ; pared_debajo_arma: C con pared debajo del arma
	ret nc			;ac85
	dec (iy+001h)		;ac86
y_a_la_casilla:		; la y del arma ajustada a la casilla
	ld a,(iy+005h)		;ac89   ; la y ajustada a la casilla
	and 0f8h		;ac8c
	ld (iy+005h),a		;ac8e
	ret			;ac91
arma_5:		; el arma 5: se pone en el suelo, se arma y estalla
	ld a,(iy+001h)		;ac92   ; el arma 5, paso 1: si hay sitio...
	dec a			;ac95
	jr nz,L_ACDE		;ac96
	call se_puede_poner		;ac98   ; se_puede_poner: Z si se puede poner el arma (no en el agua, en el aire ni en una figura)
	jp nz,acaba_arma		;ac9b   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,(0e505h)		;ac9e   ; ...a los pies del personaje...
	ld l,a			;aca1
	sub 004h		;aca2
	ld (iy+005h),a		;aca4
	ld a,(0e507h)		;aca7   ; lee la x del personaje
	sub 008h		;acaa
	ld (iy+007h),a		;acac
	ld h,a			;acaf   ; ...solo con suelo debajo (las dos casillas)...
	push hl			;acb0
	ld a,002h		;acb1
	add a,h			;acb3
	ld h,a			;acb4
	call 04dc8h		;acb5   ; casilla_b9: C si el caracter de la casilla de HL pasa de 0xB9
	pop hl			;acb8
	jp nc,acaba_arma		;acb9   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld a,00dh		;acbc
	add a,h			;acbe
	ld h,a			;acbf
	call 04dc8h		;acc0   ; casilla_b9: C si el caracter de la casilla de HL pasa de 0xB9
	jp nc,acaba_arma		;acc3   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	ld (iy+014h),080h		;acc6   ; ...queda puesta: dibujo 0x54, color 15
	inc (iy+001h)		;acca
	ld de,0540fh		;accd
	ld (iy+00ah),d		;acd0
	ld (iy+00bh),e		;acd3
L_ACD6:
	ld a,016h		;acd6   ; el sonido 0x16 y una flecha menos
	call 04e1fh		;acd8   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp gasta_flecha		;acdb   ; gasta_flecha: una flecha menos, salvo con el jefe y el objeto 0x09
L_ACDE:
	dec a			;acde   ; paso 2: espera a que el personaje se aparte (0x15 de alto, 0x21 de lado)...
	jr nz,L_AD04		;acdf
	ld a,(0e505h)		;ace1   ; lee la y del personaje
	sub (iy+005h)		;ace4
	jr c,L_ACF9		;ace7
	cp 015h		;ace9
	jr nc,L_ACF9		;aceb
	ld a,(0e507h)		;aced   ; lee la x del personaje
	sub (iy+007h)		;acf0
	add a,008h		;acf3
	ret c			;acf5
	cp 021h		;acf6
	ret c			;acf8
L_ACF9:
	xor a			;acf9   ; ...y se arma
	ld (iy+01ah),a		;acfa
	inc (iy+002h)		;acfd
L_AD00:
	inc (iy+001h)		;ad00
	ret			;ad03
L_AD04:
	bit 2,(iy+002h)		;ad04   ; paso 3: parpadea (tabla de colores 0xAD2E) hasta que estalla
	jr nz,$+44		;ad08
	inc (iy+008h)		;ad0a   ; cada 4 cuadros...
	ld a,(iy+008h)		;ad0d
	and 003h		;ad10
	ret nz			;ad12
	inc (iy+01ah)		;ad13   ; ...el color siguiente de 6
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


cuenta_arma:		; cuenta (iy+8) y se acaba
	dec (iy+008h)		;ad34   ; cuenta y se acaba
	ret nz			;ad37
	jr acaba_arma		;ad38
arma_6:		; el arma 6: con el boton B, 0xE517 = 1
	ld a,(0e510h)		;ad3a   ; el arma 6: con el boton B, 0xE517 = 1
	cp 006h		;ad3d
	ret nz			;ad3f
	ld a,(0e008h)		;ad40   ; lee lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and 020h		;ad43
	ret z			;ad45
	ld a,001h		;ad46
	ld (0e517h),a		;ad48   ; guarda el arma 6 usada
	ret			;ad4b
mueve_armas:		; las armas se mueven y se acaban fuera de la pantalla
	ld iy,0e540h		;ad4c   ; las armas se mueven: los seis huecos
	exx			;ad50
	ld b,006h		;ad51
	ld de,00020h		;ad53
L_AD56:
	exx			;ad56
	call mueve_arma		;ad57   ; mueve_arma: un arma se mueve
	exx			;ad5a
	add iy,de		;ad5b
	djnz L_AD56		;ad5d
	exx			;ad5f
	ret			;ad60
mueve_arma:		; un arma se mueve
	ld a,(iy+000h)		;ad61   ; la y y la x mas la velocidad...
	and a			;ad64
	ret z			;ad65
	call arma_mas_velocidad		;ad66   ; arma_mas_velocidad: la y y la x del arma mas su velocidad
	ld a,h			;ad69   ; ...fuera de la pantalla por los lados...
	sub 008h		;ad6a
	cp 0f0h		;ad6c
	jr nc,acaba_arma		;ad6e
	ld a,(iy+005h)		;ad70   ; ...o por abajo (0xB8)...
	cp 0b8h		;ad73
	ret c			;ad75
acaba_arma:		; el arma se acaba: una menos y el hueco a cero
	ld a,(iy+000h)		;ad76   ; ...se acaba: una menos en su grupo...
	cp 005h		;ad79
	ld hl,0e51ch		;ad7b   ; apunta a las armas 1-4 en pantalla
	jr nz,L_AD83		;ad7e
	ld hl,0e51dh		;ad80   ; apunta a las armas 5 en pantalla
L_AD83:
	dec (hl)			;ad83
	push iy		;ad84   ; ...y el hueco a cero
	pop hl			;ad86
	ld e,l			;ad87
	ld d,h			;ad88
	inc de			;ad89
	ld (hl),000h		;ad8a
	ld bc,0001fh		;ad8c
	ldir		;ad8f
	ret			;ad91
arma_mas_velocidad:		; la y y la x del arma mas su velocidad
	ld l,(iy+004h)		;ad92   ; la y (16 bits) + su velocidad y la x + la suya
	ld h,(iy+005h)		;ad95   ; la y...
	ld e,(iy+00ch)		;ad98   ; ...+ la velocidad vertical
	ld d,(iy+00dh)		;ad9b
	add hl,de			;ad9e
	ld (iy+004h),l		;ad9f
	ld (iy+005h),h		;ada2
	ld l,(iy+006h)		;ada5   ; la x...
	ld h,(iy+007h)		;ada8
	ld e,(iy+00eh)		;adab   ; ...+ la de lado
	ld d,(iy+00fh)		;adae
	add hl,de			;adb1
	ld (iy+006h),l		;adb2
	ld (iy+007h),h		;adb5
	ret			;adb8
pared_debajo_arma:		; C con pared debajo del arma
	ld h,(iy+007h)		;adb9   ; C si hay pared en la fila de debajo
	ld l,(iy+005h)		;adbc
	ld de,00008h		;adbf
	jp 054ffh		;adc2   ; pared_en_fila: C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
pared_delante_arma:		; C con pared delante del arma
	ld a,(iy+007h)		;adc5   ; la casilla de delante (8 a la derecha o 1 a la izquierda)...
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
casilla_mayor_b9:		; C si el caracter de la casilla (y L, x H) pasa de 0xB9
	call 04da1h		;adda   ; ...su caracter...
caracter_mayor_b9:		; C si (HL) pasa de 0xB9
	ld a,0b9h		;addd   ; ...C si pasa de 0xB9
	cp (hl)			;addf
	ret			;ade0
pared_columna_arma:		; C con pared en la columna del arma
	ld h,(iy+007h)		;ade1   ; C si hay pared en la columna (el arma 3, mas alta)
	ld l,(iy+005h)		;ade4
	ld a,(iy+000h)		;ade7
	ld de,00103h		;adea
	cp 003h		;aded
	jp nz,0551fh		;adef   ; pared_en_columna: C si una de las casillas (x+B) o (y+D) llega al umbral de 0xF020
	ld e,007h		;adf2
	jp 0551fh		;adf4   ; pared_en_columna: C si una de las casillas (x+B) o (y+D) llega al umbral de 0xF020
pared_segun_velocidad:		; C con pared delante segun la velocidad
	ld b,010h		;adf7   ; C si hay pared delante segun la velocidad
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
	jp 0553eh		;ae12   ; pared_en: C si la casilla (y+E) llega al umbral de 0xF020
casilla_arma_b:		; C si la casilla (x + 4, y + B) pasa de 0xB9
	ld a,(iy+007h)		;ae15   ; C si la casilla (x + 4, y + B) pasa de 0xB9
	add a,004h		;ae18
	ld h,a			;ae1a
	ld a,(iy+005h)		;ae1b
	add a,b			;ae1e
	ld l,a			;ae1f
	jp 04dc8h		;ae20   ; casilla_b9: C si el caracter de la casilla de HL pasa de 0xB9
dibujo_cada_4:		; el dibujo B cambiando cada 4 cuadros
	ld c,000h		;ae23   ; el dibujo B, cambiando cada 4 cuadros...
	jr L_AE29		;ae25
dibujo_cada_8:		; el dibujo B cambiando cada 8 cuadros
	ld c,001h		;ae27   ; ...o cada 8
L_AE29:
	ld a,(0e604h)		;ae29   ; lee el contador de cuadros de partida
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
x_a_la_casilla:		; la x del arma ajustada a la casilla
	ld a,(iy+007h)		;ae3a   ; la x ajustada a la casilla
	and 0f8h		;ae3d
	bit 7,(iy+00fh)		;ae3f
	jr z,L_AE47		;ae43
	add a,008h		;ae45
L_AE47:
	ld (iy+007h),a		;ae47
	ret			;ae4a
estalla:		; el arma estalla (sonido 0x26)
	set 2,(iy+002h)		;ae4b   ; estalla: 0x46 cuadros, el dibujo mas arriba y el sonido 0x26
	ld (iy+008h),046h		;ae4f
	ld a,(iy+005h)		;ae53
	sub 00ch		;ae56
	ld (iy+005h),a		;ae58
	ld a,(iy+007h)		;ae5b
	sub 008h		;ae5e
	ld (iy+007h),a		;ae60
	ld a,026h		;ae63
	jp 04e1fh		;ae65   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
rebota:		; el arma rebota (sonido 0x1D)
	set 1,(iy+002h)		;ae68   ; rebota: la velocidad de lado al reves, -0x800 hacia arriba y el sonido 0x1D
	res 0,(iy+002h)		;ae6c
	ld e,(iy+00eh)		;ae70
	ld d,(iy+00fh)		;ae73
	call 0415ch		;ae76   ; de_negado: DE = -DE
	ld (iy+00eh),e		;ae79
	ld (iy+00fh),d		;ae7c
	ld de,0f800h		;ae7f
	ld (iy+00ch),e		;ae82
	ld (iy+00dh),d		;ae85
L_AE88:
	ld a,01dh		;ae88
	jp 04e1fh		;ae8a   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
se_puede_poner:		; Z si se puede poner el arma (no en el agua, en el aire ni en una figura)
	ld a,(0e52ah)		;ae8d   ; no en el agua de 0xE52A...
	and a			;ae90
	ret nz			;ae91
en_suelo_firme:		; Z en pie y no subido a una figura
	ld a,(0e500h)		;ae92   ; ...ni en el aire, ni subido a una figura
	and a			;ae95
	ret nz			;ae96
	jp subido_a_figura		;ae97   ; subido_a_figura: NZ si el personaje esta subido a una figura que se mueve
mas_vida:		; el tope de la vida + 8 (hasta 0x48) y la vida llena
	ld a,(0e501h)		;ae9a   ; el tope de la vida del que juega + 8, hasta 0x48...
	or a			;ae9d
	ld hl,0e053h		;ae9e   ; apunta a el tope de la vida de Afrodita
	jr z,L_AEA5		;aea1
	ld l,057h		;aea3
L_AEA5:
	ld a,(hl)			;aea5
	cp 048h		;aea6
	ret nc			;aea8
	add a,008h		;aea9
	ld (hl),a			;aeab
	call 0604dh		;aeac   ; ...la cabecera...
	ld a,001h		;aeaf   ; ...y la vida llena
	ld (0e61eh),a		;aeb1   ; guarda sin el sonido del golpe
	call vida_llena		;aeb4   ; vida_llena: la vida del que juega a su tope
	xor a			;aeb7
	ld (0e61eh),a		;aeb8   ; guarda sin el sonido del golpe
	ret			;aebb
paredes_del_personaje:		; las cuatro paredes del personaje a 0xE519
	exx			;aebc   ; las cuatro paredes del personaje a 0xE519: suelo...
	ld b,000h		;aebd
	exx			;aebf
	call suelo		;aec0   ; suelo: C con suelo debajo
	exx			;aec3
	rl b		;aec4
	exx			;aec6
	call techo		;aec7   ; ...techo...
	exx			;aeca
	rl b		;aecb
	exx			;aecd
	call pared_derecha		;aece   ; ...derecha...
	exx			;aed1
	rl b		;aed2
	exx			;aed4
	call pared_izquierda		;aed5   ; ...izquierda
	exx			;aed8
	rl b		;aed9
	ld a,b			;aedb
	ld (0e519h),a		;aedc   ; guarda las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	exx			;aedf
	ret			;aee0
escalera_arriba:		; C con escalera para subir
	ld a,(0e507h)		;aee1   ; escalera para subir: delante y arriba del personaje
	sub 008h		;aee4
	ld h,a			;aee6
	ld a,(0e505h)		;aee7   ; lee la y del personaje
	dec a			;aeea
	ld l,a			;aeeb
	ld c,004h		;aeec
	ld b,000h		;aeee
	jr escalera_en		;aef0
escalera_abajo:		; C con escalera para bajar
	ld a,(0e507h)		;aef2   ; escalera para bajar: debajo de los pies
	sub 008h		;aef5
	ld h,a			;aef7
	ld a,(0e505h)		;aef8   ; lee la y del personaje
	add a,008h		;aefb
	ld l,a			;aefd
	ld c,004h		;aefe
	ld b,001h		;af00
escalera_en:		; C si las casillas H + C y H + 16 son escalera (0x9A, 0x9B)
	push hl			;af02   ; la casilla a C de la x...
	ld a,h			;af03
	add a,c			;af04
	ld h,a			;af05
	call 04da1h		;af06   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;af09
	pop hl			;af0a
	sub 09ah		;af0b   ; ...es escalera (0x9A o 0x9B)?...
	cp 002h		;af0d
	ret nc			;af0f
	ld a,010h		;af10   ; ...y la de 16 - C mas alla...
	sub c			;af12
	ld c,a			;af13
	ld a,h			;af14
	add a,c			;af15
	ld h,a			;af16
	push hl			;af17
	call 04da1h		;af18   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;af1b
	pop hl			;af1c
	sub 09ah		;af1d
	cp 002h		;af1f
	ret nc			;af21
	ld a,h			;af22   ; ...el personaje ajustado a la escalera
	and 0f8h		;af23
	ld (0e507h),a		;af25   ; guarda la x del personaje
	xor a			;af28
	ld (0e525h),a		;af29   ; guarda la escalera de 0xEC00 al lado
	ld c,b			;af2c   ; las escaleras de 0xE0B0 que no estan...
	ld b,004h		;af2d
	ld hl,0e0b0h		;af2f
L_AF32:
	ld a,(hl)			;af32
	and a			;af33
	push hl			;af34
	push bc			;af35
	call z,escalera_ec00		;af36   ; escalera_ec00: la escalera de 0xEC00
	pop bc			;af39
	pop hl			;af3a
	inc hl			;af3b
	inc hl			;af3c
	djnz L_AF32		;af3d
	scf			;af3f   ; C: hay escalera
	ret			;af40
escalera_ec00:		; mira la escalera de 0xEC00 junto al personaje
	ld hl,0ec00h		;af41   ; la escalera de 0xEC00, si esta...
	ld a,(hl)			;af44
	and a			;af45
	jr z,L_AF7B		;af46
	inc hl			;af48
	ld a,(hl)			;af49
	ld b,a			;af4a
	bit 0,c		;af4b   ; ...arriba o abajo de ella...
	jr nz,L_AF63		;af4d
	ld a,(0e505h)		;af4f   ; lee la y del personaje
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
	ld a,(0e505h)		;af67   ; lee la y del personaje
	sub b			;af6a
	jr nz,L_AF7B		;af6b
	inc hl			;af6d
L_AF6E:
	ld a,(0e507h)		;af6e   ; ...y a menos de 0x11 de lado: 0xE525 = 1
	sub (hl)			;af71
	cp 011h		;af72
	ccf			;af74
	ret c			;af75
	ld a,001h		;af76
	ld (0e525h),a		;af78   ; guarda la escalera de 0xEC00 al lado
L_AF7B:
	scf			;af7b
	ret			;af7c
para_contra_pared:		; se para y se ajusta a la casilla
	ld de,00000h		;af7d   ; contra la pared: sin velocidad de lado...
	ld (0e51eh),de		;af80   ; guarda la velocidad hacia atras del golpe y el byte siguiente (16 bits)
	ld a,(0e515h)		;af84
	ld b,a			;af87
	ld a,(0e500h)		;af88   ; ...saltando, paso 1...
	cp 001h		;af8b
	call z,salto_paso_1		;af8d   ; salto_paso_1: 0xE50E = 1
	add a,b			;af90
	dec a			;af91
	ret z			;af92
	ld a,(0e519h)		;af93   ; ...la x ajustada a la casilla
	bit 0,a		;af96
	ld a,(0e507h)		;af98   ; lee la x del personaje
	ld c,a			;af9b
	jr nz,L_AFA7		;af9c
	ld a,(0e51ah)		;af9e   ; lee pared a la derecha
	and a			;afa1
	ld a,c			;afa2
	jr z,L_AFA7		;afa3
	add a,008h		;afa5
L_AFA7:
	and 0f8h		;afa7
	ld (0e507h),a		;afa9   ; guarda la x del personaje
	ret			;afac
salto_paso_1:		; 0xE50E = 1
	ex af,af'			;afad
	ld a,001h		;afae
	ld (0e50eh),a		;afb0   ; guarda el paso en la escalera
	ex af,af'			;afb3
	ret			;afb4
suelo:		; C con suelo debajo
	ld a,(0e507h)		;afb5   ; el suelo: la fila de los pies
	ld h,a			;afb8
	ld a,(0e505h)		;afb9   ; lee la y del personaje
	ld l,a			;afbc
	ld b,000h		;afbd
	ld de,0fc04h		;afbf
	jp 054ffh		;afc2   ; pared_en_fila: C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
techo:		; C con techo encima
	ld a,(0e507h)		;afc5   ; el techo: 0x10 mas arriba
	ld h,a			;afc8
	ld a,(0e505h)		;afc9   ; lee la y del personaje
	ld l,a			;afcc
	ld b,0f0h		;afcd
	ld de,0fc04h		;afcf
	jp 054ffh		;afd2   ; pared_en_fila: C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
pared_izquierda:		; C con pared a la izquierda
	ld a,(0e507h)		;afd5   ; la columna de la izquierda
	ld h,a			;afd8
	ld b,008h		;afd9
pared_en_x_b:		; C con pared en la columna x + B
	ld a,(0e505h)		;afdb   ; lee la y del personaje
	sub 008h		;afde
	ld l,a			;afe0
	ld de,0ff07h		;afe1
	jp 0551fh		;afe4   ; pared_en_columna: C si una de las casillas (x+B) o (y+D) llega al umbral de 0xF020
pared_derecha:		; C con pared a la derecha (0xE51A)
	xor a			;afe7   ; la de la derecha (dos columnas)
	ld (0e51ah),a		;afe8   ; guarda pared a la derecha
	ld a,(0e507h)		;afeb   ; lee la x del personaje
	ld h,a			;afee
	ld b,0f8h		;afef
	call pared_en_x_b		;aff1   ; pared_en_x_b: C con pared en la columna x + B
	jr c,L_AFFF		;aff4
	ld a,(0e507h)		;aff6   ; lee la x del personaje
	ld h,a			;aff9
	ld b,0f7h		;affa
	jp pared_en_x_b		;affc   ; pared_en_x_b: C con pared en la columna x + B
L_AFFF:
	ld a,001h		;afff
	ld (0e51ah),a		;b001   ; guarda pared a la derecha
	ret			;b004
agua:		; el agua: 0xB6/0xB7 (Popolon pierde vida cada cuadro, Afrodita cada 255) y 0xB8 (los dos cada 4)
	ld a,(0e511h)		;b005   ; el agua: la de antes en 0xF030...
	ld (0f030h),a		;b008
	xor a			;b00b
	ld (0e511h),a		;b00c   ; guarda en el agua
	ld (0e52ah),a		;b00f   ; guarda en el agua que deja el objeto 0x10
	ld a,(0e507h)		;b012   ; ...la casilla de los pies (una mas arriba con suelo)...
	ld h,a			;b015
	ld a,(0e505h)		;b016   ; lee la y del personaje
	ld l,a			;b019
	call 04da1h		;b01a   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(0e519h)		;b01d   ; lee las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 3,a		;b020
	jr z,L_B028		;b022
	ld de,0ffe0h		;b024
	add hl,de			;b027
L_B028:
	ld a,(hl)			;b028   ; ...0xB6: agua...
	sub 0b6h		;b029
	jr z,L_B037		;b02b
	dec a			;b02d   ; ...0xB7: agua...
	jr z,L_B058		;b02e
	cp 003h		;b030   ; ...0xB8: 2...
	ret nc			;b032
	ld a,002h		;b033
	jr L_B05A		;b035
L_B037:
	ld a,(0e07fh)		;b037   ; en el agua 0xB6, con el objeto 0x10...
	and a			;b03a
	jr z,L_B058		;b03b
	ld hl,(0e041h)		;b03d   ; ...en el mapa 6, salas 12 y 13...
	ld a,l			;b040
	cp 006h		;b041
	jr nz,L_B058		;b043
	ld a,h			;b045
	sub 00ch		;b046
	cp 002h		;b048
	jr nc,L_B058		;b04a
	ld a,001h		;b04c   ; ...se anda por encima: 0xE52A = 1...
	ld (0e52ah),a		;b04e   ; guarda en el agua que deja el objeto 0x10
L_B051:
	ld hl,0e519h		;b051   ; ...y hace de suelo
	set 3,(hl)		;b054
	xor a			;b056
	ret			;b057
L_B058:
	ld a,001h		;b058   ; en el agua: 0xE511 = 1
L_B05A:
	ld (0e511h),a		;b05a   ; guarda en el agua
	ld hl,0f030h		;b05d   ; al entrar, el sonido 0x24
	cp (hl)			;b060
	jr z,L_B068		;b061
	ld a,024h		;b063
	call 04e1fh		;b065   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_B068:
	call 044eah		;b068   ; en los estados 4-7 nada
	ccf			;b06b
	ret nc			;b06c
	ld a,(0e501h)		;b06d   ; Popolon: cada cuadro en el agua...
	or a			;b070
	ld bc,0fe03h		;b071
	jr z,L_B078		;b074
	ld b,000h		;b076   ; ...Afrodita cada 0xFF...
L_B078:
	ld a,(0e511h)		;b078   ; ...y en el 0xB8 los dos cada 4...
	dec a			;b07b
	ld a,b			;b07c
	jr z,L_B080		;b07d
	ld a,c			;b07f
L_B080:
	ld hl,0e524h		;b080   ; ...cuenta...
	inc (hl)			;b083
	cp (hl)			;b084
	jr nc,L_B093		;b085
	ld (hl),000h		;b087   ; ...una de vida menos con el sonido 0x25
	ld a,0ffh		;b089
	call 0612ch		;b08b   ; cambia_vida: suma A (con signo) al cambio de vida pendiente del que juega
	ld a,025h		;b08e
	call 04e1fh		;b090   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_B093:
	xor a			;b093
	ret			;b094
figuras_que_llevan:		; las figuras de 0xEC10 y 0xEC20 con el personaje
	ld ix,0ec10h		;b095   ; las dos figuras que llevan (0xEC10 y 0xEC20)...
	exx			;b099
	ld b,002h		;b09a
	ld de,00010h		;b09c
L_B09F:
	exx			;b09f
	call figura_que_lleva		;b0a0   ; figura_que_lleva: si el personaje esta encima, al lado o debajo de la figura
	exx			;b0a3
	add ix,de		;b0a4   ; la siguiente (16 bytes)
	djnz L_B09F		;b0a6
	exx			;b0a8
	ld a,(0ec10h)		;b0a9   ; ...y la de sala en sala guarda si lo lleva
	and a			;b0ac
	ret z			;b0ad
	ld c,a			;b0ae   ; la de sala en sala que esta aqui...
	ld a,006h		;b0af
	sub c			;b0b1
	add a,a			;b0b2
	add a,a			;b0b3
	add a,a			;b0b4
	add a,a			;b0b5
	ld hl,0e4a2h		;b0b6   ; ...su ficha en 0xE4A0 + 0x10 x (6 - numero)...
	ld c,a			;b0b9
	ld b,000h		;b0ba
	add hl,bc			;b0bc
	ld a,(0ec12h)		;b0bd   ; ...guarda si lo lleva
	ld (hl),a			;b0c0
	ret			;b0c1
figura_que_lleva:		; si el personaje esta encima, al lado o debajo de la figura
	ld a,(ix+002h)		;b0c2   ; la figura: guarda sus banderas y quita el bit 0...
	ld (0f000h),a		;b0c5
	res 0,(ix+002h)		;b0c8
	ld a,(ix+000h)		;b0cc
	and a			;b0cf
	ret z			;b0d0
	bit 3,(ix+002h)		;b0d1   ; ...con el bit 3, cuenta y nada mas...
	jr z,L_B0E7		;b0d5
	ld a,(ix+002h)		;b0d7
	sub 010h		;b0da
	ld (ix+002h),a		;b0dc
	and 070h		;b0df
	ret nz			;b0e1
	res 3,(ix+002h)		;b0e2
	ret			;b0e6
L_B0E7:
	ld a,(0e505h)		;b0e7   ; ...el personaje a su altura...
	sub (ix+005h)		;b0ea
	dec a			;b0ed
	cp 01fh		;b0ee
	jr nc,L_B105		;b0f0
	ld a,(0e507h)		;b0f2   ; ...pegado a su izquierda, se para...
	sub (ix+007h)		;b0f5
	add a,008h		;b0f8
	cp 004h		;b0fa
	jr c,L_B15C		;b0fc
	sub 02dh		;b0fe   ; ...pegado a su derecha, tambien...
	cp 004h		;b100
	call c,a_la_derecha_de_figura		;b102   ; a_la_derecha_de_figura: el personaje en x + 0x28 de la figura
L_B105:
	ld a,(0e507h)		;b105   ; ...encima de ella (0x25 de ancho)...
	add a,002h		;b108
	sub (ix+007h)		;b10a
	cp 025h		;b10d
	jr nc,L_B147		;b10f
	ld a,(0e505h)		;b111   ; ...un poco por encima: la lleva (bit 0)...
	sub (ix+005h)		;b114
	sub 008h		;b117
	jr nc,L_B12D		;b119
	ld a,(0f000h)		;b11b
	bit 0,a		;b11e
	jr nz,L_B128		;b120
	ld hl,0e519h		;b122   ; apunta a las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 3,(hl)		;b125
	ret nz			;b127
L_B128:
	set 0,(ix+002h)		;b128
	ret			;b12c
L_B12D:
	sub 010h		;b12d   ; ...un poco por debajo: le da en la cabeza (la y + 0x20)
	cp 008h		;b12f
	jr nc,L_B147		;b131
	ld hl,0e519h		;b133   ; apunta a las paredes del personaje (bit 0 derecha, bit 1 izquierda, bit 3 suelo)
	bit 3,(hl)		;b136
	ret nz			;b138
	ld l,(ix+004h)		;b139
	ld h,(ix+005h)		;b13c
	ld a,h			;b13f
	add a,020h		;b140
	ld h,a			;b142
	ld (0e504h),hl		;b143   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ret			;b146
L_B147:
	ld a,(0f000h)		;b147   ; si lo llevaba y ya no, el bit 3 y la cuenta
	ld c,a			;b14a
	ld b,(ix+002h)		;b14b   ; si ha dejado de llevarlo...
	xor b			;b14e
	and c			;b14f
	bit 0,a		;b150
	ret z			;b152
	ld a,(ix+002h)		;b153   ; ...el bit 3 y la cuenta (0x70)
	or 078h		;b156
	ld (ix+002h),a		;b158
	ret			;b15b
L_B15C:
	ld a,(ix+007h)		;b15c   ; a su izquierda (x - 8)
	sub 008h		;b15f
	ld (0e507h),a		;b161   ; guarda la x del personaje
	jr L_B105		;b164
a_la_derecha_de_figura:		; el personaje en x + 0x28 de la figura
	ld a,(ix+007h)		;b166   ; a su derecha (x + 0x28)
	add a,028h		;b169
	ld (0e507h),a		;b16b   ; guarda la x del personaje
	ret			;b16e
suelta_figura:		; la figura deja de llevarlo
	res 0,(ix+002h)		;b16f   ; cayendo, deja de llevarlo (bit 3)
	ld a,(0e500h)		;b173   ; lee el estado del personaje (5 = hundirse)
	cp 002h		;b176
	ret nz			;b178
	set 3,(ix+002h)		;b179
	ret			;b17d
corriente:		; en el agua del objeto 0x10, la x - 0x100 cada cuadro
	ld a,(0e52ah)		;b17e   ; en el agua del objeto 0x10, la x - 0x100 cada cuadro...
	and a			;b181
	ret z			;b182
	ld hl,(0e506h)		;b183   ; lee la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld de,0ff00h		;b186
	add hl,de			;b189
	ld (0e506h),hl		;b18a   ; guarda la x del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	call pared_derecha		;b18d   ; ...hasta la pared
	ret nc			;b190
	jp para_contra_pared		;b191   ; para_contra_pared: se para y se ajusta a la casilla
lee_el_monumento:		; el arma 6 junto a la cosa 0xE678 de la sala: estado 0x0C
	ld hl,0e517h		;b194   ; el arma 6 usada...
	ld a,(hl)			;b197
	or a			;b198
	ret z			;b199
	ld (hl),000h		;b19a
	ld hl,0e678h		;b19c   ; ...con la cosa de 0xE678 en la sala...
	ld a,(hl)			;b19f
	or a			;b1a0
	ret z			;b1a1
	ld a,(0e505h)		;b1a2   ; ...a menos de 0x10 de alto...
	sub 010h		;b1a5
	inc l			;b1a7
	sub (hl)			;b1a8
	add a,010h		;b1a9
	cp 021h		;b1ab
	ret nc			;b1ad
	ld a,(0e507h)		;b1ae   ; ...y de lado...
	inc l			;b1b1
	sub 008h		;b1b2
	sub (hl)			;b1b4
	add a,010h		;b1b5
	cp 021h		;b1b7
	ret nc			;b1b9
	ld a,(0e678h)		;b1ba   ; ...pide el estado 0x0C con esa cosa
	ld (0e01bh),a		;b1bd   ; guarda estado 0x0C pedido
	ret			;b1c0
choques_con_figuras:		; el personaje contra las figuras de los huecos
	xor a			;b1c1   ; los choques: nada aun...
	ld (0e520h),a		;b1c2   ; guarda empujado (1 a la izquierda, 2 a la derecha)
	ld (0e61fh),a		;b1c5   ; guarda ya ha chocado este cuadro
	call tamano_del_personaje		;b1c8   ; ...p03:B8A0...
	ld ix,0e800h		;b1cb   ; ...las figuras de los huecos con el bit 6...
	ld a,(0e635h)		;b1cf   ; lee cuantos huecos de figura hay
	ld (0e623h),a		;b1d2
L_B1D5:
	bit 6,(ix+002h)		;b1d5   ; mira el bit 6 de las banderas de la figura (bit 7: en pantalla)
	call nz,choque_con_figura		;b1d9   ; choque_con_figura: el personaje contra una figura (salvo las que no tocan con ciertos objetos)
	ld a,(0e61fh)		;b1dc   ; ...hasta el primer choque
	or a			;b1df
	ret nz			;b1e0
	ld bc,00020h		;b1e1
	add ix,bc		;b1e4
	ld hl,0e623h		;b1e6
	dec (hl)			;b1e9
	jr nz,L_B1D5		;b1ea
	ret			;b1ec
choque_con_figura:		; el personaje contra una figura (salvo las que no tocan con ciertos objetos)
	ld a,(ix+000h)		;b1ed   ; el tipo; los 0x5D-0x5F aparte
	ld c,a			;b1f0
	sub 05dh		;b1f1
	cp 003h		;b1f3
	jr c,L_B23B		;b1f5
	ld a,(0e518h)		;b1f7   ; parpadeando, nada
	or a			;b1fa
	ret nz			;b1fb
	ld a,c			;b1fc   ; el tipo 8 no toca con el objeto 0x24
	cp 008h		;b1fd
	jr nz,L_B206		;b1ff
	ld a,(0e093h)		;b201   ; lee tiene el objeto 0x24
	or a			;b204
	ret nz			;b205
L_B206:
	ld a,c			;b206   ; el 0x2A no toca con el 0x0E
	cp 02ah		;b207
	jr nz,L_B210		;b209
	ld a,(0e07dh)		;b20b   ; lee tiene el objeto 0x0E
	or a			;b20e
	ret nz			;b20f
L_B210:
	ld a,c			;b210   ; el 0x28 no toca con el 0x0F
	cp 028h		;b211
	jr nz,L_B21A		;b213
	ld a,(0e07eh)		;b215   ; lee tiene el objeto 0x0F
	or a			;b218
	ret nz			;b219
L_B21A:
	ld a,c			;b21a   ; el 0x2E no toca con el 0x17
	cp 02eh		;b21b
	jr nz,L_B224		;b21d
	ld a,(0e086h)		;b21f   ; lee tiene el objeto 0x17
	or a			;b222
	ret nz			;b223
L_B224:
	ld a,c			;b224   ; el 0x31 no toca con el 0x22
	cp 031h		;b225
	jr nz,L_B22E		;b227
	ld a,(0e091h)		;b229   ; lee tiene el objeto 0x22
	or a			;b22c
	ret nz			;b22d
L_B22E:
	ld a,c			;b22e   ; los 0x60, 0x57 y 0x62 tienen su propio tamaño
	cp 060h		;b22f
	jr z,L_B291		;b231
	cp 057h		;b233
	jr z,L_B296		;b235
	cp 062h		;b237
	jr z,L_B29B		;b239
L_B23B:
	call tamano_de_figura		;b23b   ; el tamaño de la figura
L_B23E:
	ld a,l			;b23e   ; la otra esquina
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
	cp 006h		;b24d   ; el tipo 6 aparte
	jr z,L_B2A0		;b24f
L_B251:
	call se_tocan		;b251   ; C si se tocan
	ret nc			;b254
choca:		; el personaje toca la figura IX: recoge, se cura, acaba el juego o le hace daño
	ld a,001h		;b255   ; chocado: 0xE61F = 1
	ld (0e61fh),a		;b257   ; guarda ya ha chocado este cuadro
	ld a,(ix+000h)		;b25a
	ld c,a			;b25d
	sub 05dh		;b25e   ; 0x5D-0x5F: algo que se recoge
	cp 003h		;b260
	jp c,recoge		;b262   ; recoge: las figuras 0x5D-0x5F: flechas, monedas o llaves
	ld a,c			;b265   ; 0x4F: la vida llena
	cp 04fh		;b266
	jp z,L_B2FE		;b268
	cp 06bh		;b26b   ; 0x6B: el final
	jr z,toca_el_final		;b26d
	cp 023h		;b26f   ; 0x23: aplasta
	jp z,aplasta		;b271   ; aplasta: la figura 0x23 empuja y, muy cerca, mata
	call para_con_escudo		;b274   ; si el personaje lo para, la figura se va
	jp c,04257h		;b277
	ld a,c			;b27a   ; 0x3F: paraliza
	cp 03fh		;b27b
	jr z,paraliza		;b27d
	call golpe_de_figura		;b27f   ; los demas: golpeado y la vida que quitan...
	call dano_de_figura		;b282   ; dano_de_figura: resta la vida que quita la figura (p04:64E5; la mitad con el objeto 0x19)
	bit 6,(ix+003h)		;b285   ; ...con el bit 6 la figura se va...
	call nz,04257h		;b289
L_B28C:
	ld a,025h		;b28c   ; ...y el sonido 0x25
	jp 04e1fh		;b28e   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_B291:
	call tamano_60		;b291   ; tamano_60: el tamaño del tipo 0x60
	jr L_B23E		;b294
L_B296:
	call tamano_57		;b296   ; tamano_57: el tamaño del tipo 0x57
	jr L_B23E		;b299
L_B29B:
	call tamano_62		;b29b   ; tamano_62: el tamaño del tipo 0x62
	jr L_B23E		;b29e
L_B2A0:
	ld a,(ix+001h)		;b2a0   ; el 6 en el paso 4 toca normal; si no, p03:B99B
	cp 004h		;b2a3
	jr z,L_B251		;b2a5
	call se_tocan_12_13		;b2a7   ; se_tocan_12_13: C si el recuadro toca el de (ix+0x12, ix+0x13)
	ret nc			;b2aa
	jr choca		;b2ab
toca_el_final:		; la figura 0x6B: el final (0xE024 = 1)
	ld l,(ix+012h)		;b2ad   ; el final: sus caracteres 0x7A-0x7D se quedan (0xE6A8)...
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
	ld a,001h		;b2c5   ; ...y 0xE024 = 1
	ld (0e024h),a		;b2c7   ; guarda el final (estado 0x11)
	ret			;b2ca
recoge:		; las figuras 0x5D-0x5F: flechas, monedas o llaves
	push af			;b2cb   ; recoger: la figura se va, el sonido 0x2D...
	call 04257h		;b2cc
	ld a,02dh		;b2cf
	call 04e1fh		;b2d1   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	pop af			;b2d4
	dec a			;b2d5   ; ...0x5D flechas, 0x5E monedas, 0x5F llaves: (ix+0x18)
	ld a,(ix+018h)		;b2d6
	jp m,04d5ah		;b2d9   ; suma_flechas: suma A (BCD) a las flechas de 0xE046, hasta 999
	jp z,04d7bh		;b2dc   ; suma_monedas: suma A (BCD) a las monedas de 0xE048, hasta 999
	jp 04d82h		;b2df   ; suma_llaves: suma A (BCD) a las llaves de 0xE04A, hasta 999
paraliza:		; la figura 0x3F paraliza 0x3C cuadros
	call 04257h		;b2e2   ; paralizado: en la escalera, golpeado...
	ld a,(0e500h)		;b2e5   ; lee el estado del personaje (5 = hundirse)
	cp 003h		;b2e8
	jp z,estado_4		;b2ea   ; estado_4: el estado 4 (golpeado)
	ld a,03ch		;b2ed   ; ...si no, 0x3C cuadros temblando (estado 6)
	ld (0e50fh),a		;b2ef   ; guarda la cuenta del golpe
	xor a			;b2f2
	ld (0e508h),a		;b2f3   ; guarda la espada (1 empieza, 2 golpeando)
	call pose_en_pie		;b2f6   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
	ld a,006h		;b2f9
	jp estado_del_personaje_a		;b2fb   ; estado_del_personaje_a: el estado A del personaje y lo demas a cero
L_B2FE:
	call 04257h		;b2fe
vida_llena:		; la vida del que juega a su tope
	ld a,(0e501h)		;b301   ; la vida del que juega, su tope...
	or a			;b304
	ld hl,0e053h		;b305   ; apunta a el tope de la vida de Afrodita
	jr z,L_B30C		;b308
	ld l,057h		;b30a
L_B30C:
	ld a,(hl)			;b30c
	jp 0612ch		;b30d   ; ...entera
aplasta:		; la figura 0x23 empuja y, muy cerca, mata
	ld a,(ix+007h)		;b310   ; empujado hacia el lado contrario de la figura...
	ld b,a			;b313
	sub d			;b314
	ld c,001h		;b315
	jr nc,L_B31A		;b317
	inc c			;b319
L_B31A:
	ld (0e520h),bc		;b31a   ; guarda empujado (1 a la izquierda, 2 a la derecha) y el byte siguiente (16 bits)
	dec c			;b31e
	jr z,L_B32C		;b31f
	ld a,(0e507h)		;b321   ; ...y a menos de 0x0F...
	sub (ix+007h)		;b324
	cp 00fh		;b327
	jr c,muere		;b329
	ret			;b32b
L_B32C:
	ld a,(0e507h)		;b32c   ; ...o de 5 por el otro lado...
	sub (ix+007h)		;b32f
	neg		;b332
	cp 005h		;b334
	ret nc			;b336
muere:		; la vida y la experiencia del que juega a cero
	ld a,(0e501h)		;b337   ; muere: el que juega sin experiencia ni vida
	or a			;b33a
	ld a,000h		;b33b
	ld l,a			;b33d
	ld h,a			;b33e
	ld (0e1c5h),a		;b33f   ; guarda lo herido que esta el jefe (0, 1, 2)
	jr nz,L_B352		;b342
	ld (0e050h),a		;b344   ; guarda la experiencia de Afrodita (barra)
	ld (0e052h),a		;b347   ; guarda la vida de Afrodita
	ld (0e05ch),hl		;b34a   ; guarda la experiencia de Afrodita
	ld (0e05eh),a		;b34d   ; guarda el cambio de vida pendiente de Afrodita (con signo)
	jr L_B35E		;b350
L_B352:
	ld (0e054h),a		;b352   ; guarda la experiencia de Popolon (barra)
	ld (0e056h),a		;b355   ; guarda la vida de Popolon
	ld (0e05fh),hl		;b358   ; guarda la experiencia de Popolon
	ld (0e061h),a		;b35b   ; guarda el cambio de vida pendiente de Popolon (con signo)
L_B35E:
	ld a,005h		;b35e   ; estado 5, hundirse
	call estado_del_personaje_a		;b360   ; estado_del_personaje_a: el estado A del personaje y lo demas a cero
	jp 05832h		;b363   ; dibujos_de_hundirse: los dibujos de sprite de hundirse (0x7B34 en 0x1900)
estado_del_personaje_a:		; el estado A del personaje y lo demas a cero
	ld (0e500h),a		;b366   ; el estado A y lo demas a cero
	xor a			;b369
	ld (0e50eh),a		;b36a   ; guarda el paso en la escalera
	ld (0e533h),a		;b36d   ; guarda parpadeando
	ld (0e508h),a		;b370   ; guarda la espada (1 empieza, 2 golpeando)
	ld (0e530h),a		;b373   ; guarda el personaje en guardia (quieto, para los disparos)
	ld (0e51bh),a		;b376   ; guarda la espada da en algo
	ld (0e526h),a		;b379
	ld (0e538h),a		;b37c
	inc a			;b37f   ; 0xE518 = 1
	ld (0e518h),a		;b380   ; guarda sin daño (tras un golpe o al entrar)
	jp pose_en_pie		;b383   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
golpe_de_figura:		; el golpe: el lado y el estado 4
	call lado_del_golpe		;b386   ; lado_del_golpe: 0xE514 = el lado de la figura
estado_4:		; el estado 4 (golpeado)
	ld a,004h		;b389
	jr estado_del_personaje_a		;b38b
lado_del_golpe:		; 0xE514 = el lado de la figura
	ld a,(ix+007h)		;b38d   ; el lado del golpe: la x de la figura contra la de D
	sub d			;b390
	ld a,000h		;b391
	jr nc,L_B396		;b393
	inc a			;b395
L_B396:
	ld (0e514h),a		;b396   ; guarda el lado del golpe
	ret			;b399
dano_de_figura:		; resta la vida que quita la figura (p04:64E5; la mitad con el objeto 0x19)
	ld a,(ix+000h)		;b39a   ; lo que quita la figura: el tipo 0x19 de la tabla 0xB3AE...
	ld c,a			;b39d
	cp 019h		;b39e
	jr nz,$+18		;b3a0
	ld a,(ix+01bh)		;b3a2
	ld hl,0b3aeh		;b3a5
	call 04155h		;b3a8   ; byte_de_tabla: A = el byte HL + A
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
	call 041f4h		;b3b2   ; ...los demas de la tabla 0x64E5 (banco 4)
	ld b,000h		;b3b5
	ld hl,064e5h		;b3b7
	add hl,bc			;b3ba
	ld b,(hl)			;b3bb
	call 041e9h		;b3bc   ; p6000_banco_1: pone el banco 1 en 0x6000
L_B3BF:
	ld a,(0e088h)		;b3bf   ; con el objeto 0x19, la mitad (si es mas de 1)
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
	ld a,(0e501h)		;b3ce   ; con poca vida (< 6), el sonido 0x2A
	or a			;b3d1
	ld hl,0e052h		;b3d2   ; apunta a la vida de Afrodita
	jr z,L_B3D9		;b3d5
	ld l,056h		;b3d7
L_B3D9:
	ld a,(hl)			;b3d9
	cp 006h		;b3da
	ld a,02ah		;b3dc
	call c,04e1fh		;b3de   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,b			;b3e1   ; y se resta
	neg		;b3e2
	jp 0612ch		;b3e4   ; cambia_vida: suma A (con signo) al cambio de vida pendiente del que juega
para_con_escudo:		; C si el personaje quieto para el disparo mirando hacia el (sonido 0x1D)
	or a			;b3e7   ; un disparo (bit 7)...
	bit 7,(ix+003h)		;b3e8
	ret z			;b3ec
	ld a,(0e530h)		;b3ed   ; ...con el personaje en guardia...
	or a			;b3f0
	ret z			;b3f1
	ld a,(0e507h)		;b3f2   ; ...y mirando hacia el...
	sub 008h		;b3f5
	sub (ix+007h)		;b3f7
	ld a,(0e503h)		;b3fa   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	jr c,L_B403		;b3fd
	or a			;b3ff
	ret z			;b400
	jr L_B405		;b401
L_B403:
	or a			;b403
	ret nz			;b404
L_B405:
	ld a,01dh		;b405   ; ...lo para: el sonido 0x1D y C
	call 04e1fh		;b407   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	scf			;b40a
	ret			;b40b
mina_hiere:		; la explosion del arma 5 hiere al personaje
	ld a,(0e518h)		;b40c   ; la explosion del arma 5...
	or a			;b40f
	ret nz			;b410
	ld a,(0e505h)		;b411   ; lee la y del personaje
	sub 010h		;b414
	ld c,a			;b416
	ld a,(0e507h)		;b417   ; lee la x del personaje
	sub 008h		;b41a
	ld b,a			;b41c
	ld iy,0e5a0h		;b41d   ; ...las tres de 0xE5A0
	ld a,003h		;b421
	ld (0e623h),a		;b423
L_B426:
	call cerca_de_mina		;b426   ; cerca_de_mina: C si el personaje esta en la explosion
	jp c,L_B466		;b429
	ld de,00020h		;b42c
	add iy,de		;b42f
	ld hl,0e623h		;b431
	dec (hl)			;b434
	jr nz,L_B426		;b435
	ret			;b437
cerca_de_mina:		; C si el personaje esta en la explosion
	ld a,(iy+000h)		;b438   ; estallando (bit 0) y aun sin hacer daño (bit 3)...
	or a			;b43b
	ret z			;b43c
	ld a,(iy+002h)		;b43d
	bit 0,a		;b440
	ret z			;b442
	and 008h		;b443
	ret nz			;b445
	call tamano_del_arma		;b446   ; ...su tamaño...
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
	ld a,d			;b455   ; ...C si el personaje esta dentro
	sub b			;b456
	exx			;b457
	add a,d			;b458
	exx			;b459
	jr c,L_B45E		;b45a
	cp h			;b45c
	ret nc			;b45d
L_B45E:
	ld a,e			;b45e
	sub c			;b45f   ; la distancia en x...
	exx			;b460
	add a,e			;b461
	exx			;b462
	ret c			;b463   ; ...dentro del ancho?
	cp l			;b464
	ret			;b465
L_B466:
	bit 2,(iy+002h)		;b466   ; dentro: si aun no estalla, estalla...
	push af			;b46a
	call z,estalla		;b46b   ; estalla: el arma estalla (sonido 0x26)
	pop af			;b46e
	jr nz,L_B48B		;b46f
	call tamano_del_personaje		;b471   ; ...golpeado hacia el otro lado...
	ld a,(iy+007h)		;b474
	sub d			;b477
	ld a,000h		;b478
	jr nc,L_B47D		;b47a
	inc a			;b47c
L_B47D:
	ld (0e514h),a		;b47d   ; guarda el lado del golpe
	call estado_4		;b480   ; estado_4: el estado 4 (golpeado)
L_B483:
	ld a,0feh		;b483   ; ...y 2 de vida menos
	call 0612ch		;b485   ; cambia_vida: suma A (con signo) al cambio de vida pendiente del que juega
	jp L_B28C		;b488
L_B48B:
	set 3,(iy+002h)		;b48b   ; ya hizo daño (bit 3)
	jp L_B483		;b48f
armas_contra_figuras:		; las armas contra las figuras
	ld iy,0e540h		;b492   ; las armas contra las figuras: los seis huecos
	ld b,006h		;b496
L_B498:
	push bc			;b498
	call arma_contra_figuras		;b499   ; arma_contra_figuras: un arma contra las figuras
	ld bc,00020h		;b49c
	add iy,bc		;b49f
	pop bc			;b4a1
	djnz L_B498		;b4a2
	ret			;b4a4
arma_contra_figuras:		; un arma contra las figuras
	ld a,(iy+000h)		;b4a5   ; las armas 1-5 en vuelo...
	or a			;b4a8
	ret z			;b4a9
	cp 006h		;b4aa
	ret nc			;b4ac
	bit 0,(iy+002h)		;b4ad
	ret z			;b4b1
	call tamano_del_arma		;b4b2   ; ...su tamaño...
	ld ix,0e800h		;b4b5   ; ...contra cada figura
	ld a,(0e635h)		;b4b9   ; lee cuantos huecos de figura hay
	ld (0e623h),a		;b4bc
L_B4BF:
	call arma_contra_figura		;b4bf   ; arma_contra_figura: un arma contra una figura
	jp c,arma_da		;b4c2   ; arma_da: el arma da en la figura: rebota o la hiere
	ld bc,00020h		;b4c5
	add ix,bc		;b4c8
	ld hl,0e623h		;b4ca
	dec (hl)			;b4cd
	jr nz,L_B4BF		;b4ce
	ret			;b4d0
arma_contra_figura:		; un arma contra una figura
	ld a,(ix+002h)		;b4d1   ; las que se pueden herir (bit 5)...
	and 020h		;b4d4
	ret z			;b4d6
	call arma_en_fila		;b4d7   ; ...en su fila...
	ret nc			;b4da
	call arma_en_columna		;b4db   ; ...y en su columna
	ret nc			;b4de
	ld a,(ix+000h)		;b4df
	cp 060h		;b4e2
	jp z,L_B50B		;b4e4
	cp 057h		;b4e7
	jp z,L_B511		;b4e9
	cp 062h		;b4ec
	jp z,L_B517		;b4ee
	call tamano_de_figura		;b4f1   ; tamano_de_figura: BC y HL = el tamaño del tipo (tabla 0x9006, banco 14)
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
	ld a,(ix+000h)		;b500   ; el tipo 6 aparte
	cp 006h		;b503
	jp z,L_B51D		;b505
	jp se_tocan		;b508   ; se_tocan: C si el recuadro DE/DE' toca a la figura IX (y 5, x 7)
L_B50B:
	call tamano_60		;b50b   ; tamano_60: el tamaño del tipo 0x60
	jp L_B4F4		;b50e
L_B511:
	call tamano_57		;b511   ; tamano_57: el tamaño del tipo 0x57
	jp L_B4F4		;b514
L_B517:
	call tamano_62		;b517   ; tamano_62: el tamaño del tipo 0x62
	jp L_B4F4		;b51a
L_B51D:
	ld a,(ix+001h)		;b51d
	cp 004h		;b520
	jp z,se_tocan		;b522   ; se_tocan: C si el recuadro DE/DE' toca a la figura IX (y 5, x 7)
	jp se_tocan_12_13		;b525   ; se_tocan_12_13: C si el recuadro toca el de (ix+0x12, ix+0x13)
arma_en_fila:		; C si el arma alcanza a la figura en su fila
	ld a,(iy+000h)		;b528   ; las armas 0-5 siempre...
	sub 006h		;b52b
	cp 0ffh		;b52d
	ret c			;b52f
	scf			;b530
	bit 2,(iy+002h)		;b531   ; ...las demas, si estallan, solo con el bit 4 de la figura
	ret z			;b535
	bit 4,(ix+003h)		;b536
	ret z			;b53a
	or a			;b53b
	ret			;b53c
arma_en_columna:		; C si el arma alcanza a la figura en su columna
	ld a,(iy+000h)		;b53d   ; las armas 3 y siguientes no hieren a las de bit 5
	sub 003h		;b540
	cp 0ffh		;b542
	ret c			;b544
	or a			;b545
	bit 5,(ix+003h)		;b546
	ret nz			;b54a
	scf			;b54b
	ret			;b54c
arma_da:		; el arma da en la figura: rebota o la hiere
	ld a,(iy+000h)		;b54d   ; el arma 5 aparte
	cp 005h		;b550
	jr z,mina_da		;b552
	ld a,(ix+002h)		;b554   ; la figura con escudo (bit 2) la hace rebotar...
	bit 2,a		;b557
	jp nz,rebota		;b559   ; rebota: el arma rebota (sonido 0x1D)
	bit 1,a		;b55c   ; ...o con el bit 1, si viene de frente
	jr z,L_B568		;b55e
	and 001h		;b560
	xor (iy+010h)		;b562
	jp nz,rebota		;b565   ; rebota: el arma rebota (sonido 0x1D)
L_B568:
	ld a,(iy+000h)		;b568   ; el arma 2 la atraviesa (bit 5); las demas se acaban
	cp 002h		;b56b
	push af			;b56d
	call z,atravesada		;b56e   ; atravesada: el bit 5 de (ix+3)
	pop af			;b571
	call nz,acaba_arma		;b572   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
hiere:		; la figura pierde una de vida (dos con el objeto 0x25)
	call tipo_que_se_enfada		;b575   ; herida: los tipos que se enfadan, (ix+0x1C) = 1...
	call z,se_enfada		;b578   ; se_enfada: (ix+0x1C) = 1
	ld a,01eh		;b57b   ; ...el sonido 0x1E...
	call 04e1fh		;b57d   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	dec (ix+010h)		;b580   ; ...una de vida menos...
	jp z,vence		;b583   ; vence: la figura vencida: experiencia (0xBF27, doble con el objeto 0x1B) y lo que deja
	ld a,(0e094h)		;b586   ; ...y otra con el objeto 0x25
	or a			;b589
	ret z			;b58a
	dec (ix+010h)		;b58b
	jp z,vence		;b58e   ; vence: la figura vencida: experiencia (0xBF27, doble con el objeto 0x1B) y lo que deja
	ret			;b591
tipo_que_se_enfada:		; Z en los tipos 0x0F, 0x25, 0x49, 0x52, 0x54 y 0x27
	ld a,(ix+000h)		;b592   ; Z en los tipos 0x0F, 0x25, 0x49, 0x52, 0x54 y 0x27
	cp 00fh		;b595   ; 0x0F...
	ret z			;b597
	cp 025h		;b598   ; ...0x25...
	ret z			;b59a
	cp 049h		;b59b   ; ...0x49...
	ret z			;b59d
	cp 052h		;b59e   ; ...0x52...
	ret z			;b5a0
	cp 054h		;b5a1   ; ...0x54...
	ret z			;b5a3
	cp 027h		;b5a4   ; ...0x27
	ret			;b5a6
se_enfada:		; (ix+0x1C) = 1
	ld (ix+01ch),001h		;b5a7
	ret			;b5ab
atravesada:		; el bit 5 de (ix+3)
	set 5,(ix+003h)		;b5ac
	ret			;b5b0
mina_da:		; la explosion del arma 5 quita 2 (4 con el objeto 0x25)
	bit 2,(iy+002h)		;b5b1   ; la explosion: estalla si aun no...
	call z,mina_estalla		;b5b5   ; mina_estalla: el arma estalla con el sonido 0x1E
	bit 2,(ix+002h)		;b5b8
	ret nz			;b5bc
	call tipo_que_se_enfada		;b5bd   ; tipo_que_se_enfada: Z en los tipos 0x0F, 0x25, 0x49, 0x52, 0x54 y 0x27
	call z,se_enfada		;b5c0   ; se_enfada: (ix+0x1C) = 1
	set 4,(ix+003h)		;b5c3   ; ...dos de vida menos...
	dec (ix+010h)		;b5c7
	jr z,L_B5DF		;b5ca
	dec (ix+010h)		;b5cc
	jr z,L_B5DF		;b5cf
	ld a,(0e094h)		;b5d1   ; ...cuatro con el objeto 0x25
	or a			;b5d4
	ret z			;b5d5
	dec (ix+010h)		;b5d6
	jr z,L_B5DF		;b5d9
	dec (ix+010h)		;b5db
	ret nz			;b5de
L_B5DF:
	jp vence		;b5df   ; vence: la figura vencida: experiencia (0xBF27, doble con el objeto 0x1B) y lo que deja
mina_estalla:		; el arma estalla con el sonido 0x1E
	call estalla		;b5e2   ; estalla: el arma estalla (sonido 0x26)
	ld a,01eh		;b5e5
	jp 04e1fh		;b5e7   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
umbrella:		; acaba con todas las figuras de tipo 0x0E (p03:B604)
	ld ix,0e800h		;b5ea   ; UMBRELLA: todas las figuras de tipo 0x0E...
	ld a,(0e635h)		;b5ee   ; lee cuantos huecos de figura hay
L_B5F1:
	push af			;b5f1
	ld a,(ix+000h)		;b5f2   ; lee el tipo de la figura
	cp 00eh		;b5f5
	call z,vence		;b5f7   ; ...vencidas
	ld bc,00020h		;b5fa
	add ix,bc		;b5fd
	pop af			;b5ff
	dec a			;b600
	jr nz,L_B5F1		;b601
	ret			;b603
vence:		; la figura vencida: experiencia (0xBF27, doble con el objeto 0x1B) y lo que deja
	ld a,020h		;b604   ; vencida: el sonido 0x20...
	call 04e1fh		;b606   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,(ix+000h)		;b609
	cp 05ch		;b60c   ; ...el tipo 0x5C deja otra figura...
	jp z,L_B69B		;b60e
	cp 019h		;b611   ; ...el 0x19, su experiencia segun (ix+0x1B)...
	jr nz,$+17		;b613
	ld a,(ix+01bh)		;b615
	ld hl,0b620h		;b618
	call 04136h		;b61b   ; hl_mas_a: HL += A
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
	ld hl,0bf27h		;b624   ; ...los demas, de la tabla 0xBF27...
	ld c,(ix+000h)		;b627
	ld b,000h		;b62a
	add hl,bc			;b62c
L_B62D:
	ld c,(hl)			;b62d
	ld a,(0e08ah)		;b62e   ; ...el doble con el objeto 0x1B
	or a			;b631
	ld a,c			;b632
	jr z,L_B636		;b633
	add a,a			;b635
L_B636:
	call 06158h		;b636   ; suma_experiencia: suma A x 256 a la experiencia del que juega
	call cuenta_vencidas		;b639   ; la cuenta del castillo
	ld a,(ix+000h)		;b63c   ; se va...
	ld (0e6c7h),a		;b63f
	call 04257h		;b642
	ld a,(0e6c7h)		;b645   ; ...los 0x15, 0x16, 0x40, 0x4C y 0x42 dejan algo en su sitio (0xE63F, 0xE6C0)...
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
	cp 043h		;b65c   ; ...el 0x43 se lleva a los 0x62...
	call z,acaba_los_62		;b65e   ; acaba_los_62: acaba con las figuras de tipo 0x62
	ld a,05bh		;b661   ; ...los demas dejan la figura 0x5B (el humo)
L_B663:
	ld d,(ix+005h)		;b663   ; la figura A en el sitio de IX
	ld e,(ix+007h)		;b666
	jp 0424ch		;b669
L_B66C:
	ld a,041h		;b66c
	ld (0e63fh),a		;b66e   ; guarda los cuadros de lo que deja la figura vencida
	ld l,(ix+005h)		;b671
	ld h,(ix+007h)		;b674
	ld (0e6c0h),hl		;b677   ; guarda donde deja algo la figura vencida y el byte siguiente (16 bits)
	ret			;b67a
acaba_los_62:		; acaba con las figuras de tipo 0x62
	push ix		;b67b
	ld ix,0e800h		;b67d   ; apunta a los huecos de figura (32 bytes cada uno)
	ld de,00020h		;b681
	ld a,(0e635h)		;b684   ; lee cuantos huecos de figura hay
	ld b,a			;b687
	ld a,062h		;b688
L_B68A:
	cp (ix+000h)		;b68a   ; compara con el tipo de la figura
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
	call 04257h		;b69b   ; el 0x5C deja la figura 0x39, o la 0x6B (el final) con (ix+0x1F)
	ld a,(ix+01fh)		;b69e
	or a			;b6a1
	ld a,039h		;b6a2
	jr z,L_B6A8		;b6a4
	ld a,06bh		;b6a6
L_B6A8:
	jr L_B663		;b6a8
cuenta_vencidas:		; en el castillo, las figuras con el bit 3 cuentan 0xE622; a 0, 0xE61C = 1
	bit 3,(ix+002h)		;b6aa   ; con el bit 3, una menos...
	ret z			;b6ae
	ld hl,0e622h		;b6af   ; apunta a las figuras que quedan por vencer en la sala del castillo
	dec (hl)			;b6b2
	ret nz			;b6b3
	ld a,(0e041h)		;b6b4   ; ...en los mundos, p09:9D5F...
	dec a			;b6b7
	jp nz,04260h		;b6b8
	ld a,001h		;b6bb   ; ...en el castillo, 0xE61C = 1
	ld (0e61ch),a		;b6bd   ; guarda vencidas las de la sala del castillo (salen los objetos escondidos)
	ret			;b6c0
espada_contra_figuras:		; la espada contra las figuras
	ld a,(0e51bh)		;b6c1   ; la espada dando...
	or a			;b6c4
	ret z			;b6c5
	call tamano_de_la_espada		;b6c6   ; ...su tamaño, contra las 16 figuras
	ld ix,0e800h		;b6c9   ; apunta a los huecos de figura (32 bytes cada uno)
	ld a,010h		;b6cd
	ld (0e623h),a		;b6cf
L_B6D2:
	call arma_contra_figura		;b6d2   ; arma_contra_figura: un arma contra una figura
	jr c,L_B6E3		;b6d5
	ld bc,00020h		;b6d7
	add ix,bc		;b6da
	ld hl,0e623h		;b6dc
	dec (hl)			;b6df
	jr nz,L_B6D2		;b6e0
	ret			;b6e2
L_B6E3:
	xor a			;b6e3   ; da: una vez...
	ld (0e51bh),a		;b6e4   ; guarda la espada da en algo
	ld a,(ix+002h)		;b6e7   ; ...si la figura tiene el bit 1, solo de frente...
	bit 1,a		;b6ea
	jr z,L_B6F6		;b6ec
	and 001h		;b6ee
	ld b,a			;b6f0
	ld a,(0e503h)		;b6f1   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	xor b			;b6f4
	ret nz			;b6f5
L_B6F6:
	ld a,(ix+002h)		;b6f6   ; ...con escudo rebota; si no, herida
	bit 2,a		;b6f9
	jp nz,L_AE88		;b6fb
	jp hiere		;b6fe   ; hiere: la figura pierde una de vida (dos con el objeto 0x25)
recoge_la_cosa:		; recoger la cosa de la sala: objeto, marcas y lo del 0x0C
	call tamano_del_personaje		;b701   ; la cosa de la sala: el personaje...
	ld hl,0e740h		;b704   ; apunta a el hueco de la cosa de la sala: tipo, y, x
	ld a,(hl)			;b707
	or a			;b708
	ret z			;b709
	inc l			;b70a
	inc l			;b70b
	cp 007h		;b70c   ; ...las de 1-6 son mas bajas...
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
	ld a,(hl)			;b71d   ; ...las demas 0x17 de alto...
	add a,003h		;b71e
	sub e			;b720
	add a,00ah		;b721
	jr c,L_B728		;b723
	cp 017h		;b725
	ret nc			;b727
L_B728:
	inc l			;b728   ; ...y 0x15 de ancho
	ld a,(hl)			;b729
	add a,003h		;b72a
	sub d			;b72c
	add a,008h		;b72d
	jr c,L_B734		;b72f
	cp 015h		;b731
	ret nc			;b733
L_B734:
	dec l			;b734   ; tocada: el hueco vacio...
	dec l			;b735
	dec l			;b736
	ld a,(hl)			;b737
	ld c,a			;b738
	ld (hl),000h		;b739
	sub 02dh		;b73b   ; ...0x2D-0x2F aparte...
	jp nc,cosa_de_reserva		;b73d   ; cosa_de_reserva: 0x2D: 50 flechas, 0x2E: 10 monedas, 0x2F: 2 llaves
	ld b,000h		;b740   ; ...los objetos: su marca a 1...
	ld hl,0e06fh		;b742
	add hl,bc			;b745
	ld (hl),001h		;b746
	ld a,c			;b748   ; ...0x2B y 0x2C: el nivel 2 o 3 de 0xE097 y su marca
	sub 02bh		;b749
	jr c,cosa_cogida		;b74b
	add a,002h		;b74d
	ld (0e097h),a		;b74f   ; guarda el nivel de los objetos 0x28/0x2B/0x2C
	ld hl,0e098h		;b752   ; apunta a tiene el objeto 0x29
	call 04136h		;b755   ; hl_mas_a: HL += A
	ld (hl),001h		;b758
cosa_cogida:		; la marca de la sala y lo de cada objeto
	ld hl,(0e60eh)		;b75a   ; cogida (bit 0 de las marcas de la sala)...
	set 0,(hl)		;b75d
	ld a,c			;b75f   ; ...con el sonido 0x2D (no la 0x0C)
	cp 00ch		;b760
	jr z,L_B769		;b762
	ld a,02dh		;b764
	call 04e1fh		;b766   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_B769:
	ld hl,0e061h		;b769   ; las marcas del mapa: 0x07 el bit 5...
	ld a,(0e041h)		;b76c   ; lee el mapa (1 el castillo, 2-11 los mundos)
	call 04136h		;b76f   ; hl_mas_a: HL += A
	ld a,c			;b772
	sub 007h		;b773
	jr nz,L_B77A		;b775
	set 5,(hl)		;b777
	ret			;b779
L_B77A:
	dec a			;b77a   ; ...0x08 el 6...
	jr nz,L_B780		;b77b
	set 6,(hl)		;b77d
	ret			;b77f
L_B780:
	dec a			;b780   ; ...0x09 el 7...
	jr nz,L_B786		;b781
	set 7,(hl)		;b783
	ret			;b785
L_B786:
	dec a			;b786   ; ...0x0A el 4...
	jr nz,L_B78C		;b787
	set 4,(hl)		;b789
	ret			;b78b
L_B78C:
	sub 002h		;b78c   ; ...0x0C: en las marcas siguientes el bit 1 (la puerta del mundo siguiente se puede abrir)...
	ret nz			;b78e
	inc l			;b78f
	set 1,(hl)		;b790
	ld a,0fch		;b792   ; ...los sonidos 0xFC y 0x85...
	call 04e1fh		;b794   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,085h		;b797
	call 04e1fh		;b799   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,(0e041h)		;b79c   ; ...en el castillo, mas vida...
	dec a			;b79f
	jr nz,L_B7A5		;b7a0
	call mas_vida		;b7a2   ; mas_vida: el tope de la vida + 8 (hasta 0x48) y la vida llena
L_B7A5:
	ld a,(0e041h)		;b7a5   ; ...la musica 0x88 (castillo) o 0x8B (mundo, con el estado 0x14)...
	dec a			;b7a8
	ld a,088h		;b7a9
	ld b,000h		;b7ab
	jr z,L_B7B2		;b7ad
	ld a,08bh		;b7af
	inc b			;b7b1
L_B7B2:
	call 05d12h		;b7b2   ; musica_espera: deja esperando la musica A
	ld a,b			;b7b5
	ld (0e031h),a		;b7b6   ; guarda estado 0x14 pedido
	xor a			;b7b9   ; ...y sin la cosa del jefe vencido
	ld (0e0d4h),a		;b7ba   ; guarda la cosa del jefe vencido puesta
	ret			;b7bd
cosa_de_reserva:		; 0x2D: 50 flechas, 0x2E: 10 monedas, 0x2F: 2 llaves
	push af			;b7be   ; 0x2E: 10 monedas
	call cosa_cogida		;b7bf   ; cosa_cogida: la marca de la sala y lo de cada objeto
	pop af			;b7c2
	ld b,a			;b7c3
	dec b			;b7c4
	ld a,010h		;b7c5
	jp z,04d7bh		;b7c7   ; suma_monedas: suma A (BCD) a las monedas de 0xE048, hasta 999
	dec b			;b7ca   ; 0x2F: 2 llaves
	ld a,002h		;b7cb
	jp z,04d82h		;b7cd   ; suma_llaves: suma A (BCD) a las llaves de 0xE04A, hasta 999
	ld a,050h		;b7d0   ; 0x2D: 50 flechas
	jp 04d5ah		;b7d2   ; suma_flechas: suma A (BCD) a las flechas de 0xE046, hasta 999
armas_contra_ec30:		; las armas contra los huecos de 0xEC30
	call espada_contra_tinajas		;b7d5   ; las armas 1-4 contra los huecos de 0xEC30
	ld iy,0e540h		;b7d8   ; apunta a tres huecos de 32 bytes (armas)
	ld b,006h		;b7dc
L_B7DE:
	push bc			;b7de
	call arma_contra_ec30		;b7df   ; un arma...
	ld bc,00020h		;b7e2   ; ...y la siguiente
	add iy,bc		;b7e5
	pop bc			;b7e7
	djnz L_B7DE		;b7e8
	ret			;b7ea
arma_contra_ec30:		; un arma contra las tinajas
	ld a,(iy+000h)		;b7eb
	dec a			;b7ee
	cp 004h		;b7ef
	ret nc			;b7f1
	bit 0,(iy+002h)		;b7f2
	ret z			;b7f6
	call tamano_del_arma		;b7f7   ; tamano_del_arma: DE = la esquina del arma, DE' = su tamaño (0xB8EF)
	ld ix,0ec30h		;b7fa   ; apunta a tres huecos de 8 bytes de la lista de la sala (0xB8A2)
	ld a,003h		;b7fe
	ld (0e623h),a		;b800
L_B803:
	call toca_ec30		;b803   ; las tres tinajas
	jr c,L_B833		;b806
	ld bc,00008h		;b808
	add ix,bc		;b80b
	ld hl,0e623h		;b80d
	dec (hl)			;b810
	jr nz,L_B803		;b811
	ret			;b813
toca_ec30:		; C si el arma toca el hueco de 0xEC30
	ld a,(ix+000h)		;b814   ; si esta entera (byte 1 a 0)...
	or a			;b817
	ret z			;b818
	ld a,(ix+001h)		;b819
	dec a			;b81c
	ret z			;b81d
	ld bc,00000h		;b81e   ; ...su recuadro de 0x10 x 0x14...
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
	jp se_tocan_2_3		;b830   ; ...C si el arma la toca
L_B833:
	ld a,(iy+000h)		;b833   ; el arma 5 no; las demas se acaban al darle
	cp 005h		;b836
	ret z			;b838
	call acaba_arma		;b839   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
golpe_a_tinaja:		; la tinaja pierde 1 (5 con Popolon o el objeto 0x1F)
	ld a,01eh		;b83c   ; el golpe: el sonido 0x1E...
	call 04e1fh		;b83e   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld hl,0e08eh		;b841   ; ...1 menos, 5 con Popolon o con el objeto 0x1F...
	call 04ddbh		;b844   ; tiene_o_popolon: NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)
	ld b,001h		;b847
	jr z,L_B84D		;b849
	ld b,005h		;b84b
L_B84D:
	ld a,(ix+006h)		;b84d   ; ...de su vida (byte 6)
	sub b			;b850
	ld (ix+006h),a		;b851
	jr z,L_B857		;b854
	ret nc			;b856
L_B857:
	ld a,020h		;b857   ; rota: el sonido 0x20...
	call 04e1fh		;b859   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
rompe_tinaja:		; la tinaja se rompe y queda rota en las marcas de la sala
	ld (ix+001h),001h		;b85c   ; ...el byte 1 a 1 y 10 cuadros...
	ld (ix+006h),00ah		;b860
	ld a,(ix+007h)		;b864   ; ...y su bit (numero + 5) en las marcas de la sala: queda rota
	add a,005h		;b867
	push bc			;b869
	ld b,a			;b86a
	xor a			;b86b
	scf			;b86c
L_B86D:
	rla			;b86d
	djnz L_B86D		;b86e
	pop bc			;b870
	ld hl,(0e60eh)		;b871   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	or (hl)			;b874
	ld (hl),a			;b875
	ret			;b876
espada_contra_tinajas:		; la espada contra las tinajas
	ld a,(0e526h)		;b877   ; la espada contra las tinajas
	or a			;b87a
	ret z			;b87b
	call tamano_de_la_espada		;b87c   ; tamano_de_la_espada: DE = la esquina de la espada, DE' = su tamaño
	ld ix,0ec30h		;b87f   ; apunta a tres huecos de 8 bytes de la lista de la sala (0xB8A2)
	ld a,003h		;b883
	ld (0e623h),a		;b885
L_B888:
	call toca_ec30		;b888   ; toca_ec30: C si el arma toca el hueco de 0xEC30
	jr c,L_B899		;b88b
	ld bc,00008h		;b88d
	add ix,bc		;b890
	ld hl,0e623h		;b892
	dec (hl)			;b895
	jr nz,L_B888		;b896
	ret			;b898
L_B899:
	xor a			;b899   ; una vez por golpe
	ld (0e526h),a		;b89a
	jp golpe_a_tinaja		;b89d   ; golpe_a_tinaja: la tinaja pierde 1 (5 con Popolon o el objeto 0x1F)
tamano_del_personaje:		; DE = la esquina del personaje, DE' = su tamaño
	ld a,(0e505h)		;b8a0   ; el personaje: su esquina (y - 0x0E, x - 6) y 0x0C x 0x0C
	sub 00eh		;b8a3
	ld e,a			;b8a5
	ld a,(0e507h)		;b8a6   ; lee la x del personaje
	sub 006h		;b8a9
	ld d,a			;b8ab
	exx			;b8ac
	ld de,00c0ch		;b8ad
	exx			;b8b0
	ret			;b8b1
tamano_del_arma:		; DE = la esquina del arma, DE' = su tamaño (0xB8EF)
	ld e,(iy+005h)		;b8b2   ; el arma: su sitio...
	ld d,(iy+007h)		;b8b5
	ld a,(iy+000h)		;b8b8
	sub 003h		;b8bb
	jr nc,L_B8CB		;b8bd
	ld a,e			;b8bf   ; ...las 1 y 2 ajustadas a la casilla...
	and 0f8h		;b8c0
	add a,002h		;b8c2
	ld e,a			;b8c4
	ld a,d			;b8c5
	and 0f8h		;b8c6
	add a,002h		;b8c8
	ld d,a			;b8ca
L_B8CB:
	exx			;b8cb   ; ...su tamaño de la tabla 0xB8EF...
	ld a,(iy+000h)		;b8cc
	ld hl,lb8efh		;b8cf
	call 0414ch		;b8d2   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	exx			;b8d5
	ld a,(iy+000h)		;b8d6   ; ...el arma 5 estallando, mas grande (0x20 x 0x20)
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
	ld a,e			;b8e7   ; 16 mas arriba...
	sub 010h		;b8e8
	ld e,a			;b8ea
	exx			;b8eb
	ld de,02020h		;b8ec   ; ...y 0x20 x 0x20
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


tamano_de_la_espada:		; DE = la esquina de la espada, DE' = su tamaño
	ld a,(0e503h)		;b8fb   ; la espada: delante del personaje (8 o -0x12)...
	or a			;b8fe
	ld d,008h		;b8ff
	jr z,L_B905		;b901
	ld d,0eeh		;b903
L_B905:
	ld a,(0e507h)		;b905   ; lee la x del personaje
	add a,d			;b908
	ld d,a			;b909
	ld a,(0e505h)		;b90a   ; lee la y del personaje
	sub 007h		;b90d
	ld e,a			;b90f
	exx			;b910   ; ...0x0A x 3
	ld de,00a03h		;b911
	exx			;b914
	ret			;b915
tamano_60:		; el tamaño del tipo 0x60
	ld bc,00000h		;b916   ; el tipo 0x60: alto 7, ancho 8 x (cuantos)
	ld a,(ix+009h)		;b919
	and 007h		;b91c
	dec a			;b91e
	add a,a			;b91f
	add a,a			;b920
	add a,a			;b921
	ld l,a			;b922
	ld h,007h		;b923
	ret			;b925
tamano_57:		; el tamaño del tipo 0x57
	ld bc,00000h		;b926   ; el 0x57: 8 de alto, 8 x (ix+0x1F) de ancho
	ld l,008h		;b929
	ld a,(ix+01fh)		;b92b
	add a,a			;b92e
	add a,a			;b92f
	add a,a			;b930
	ld h,a			;b931
	ret			;b932
tamano_62:		; el tamaño del tipo 0x62
	ld b,000h		;b933   ; el 0x62: la cadena, hacia arriba o hacia abajo
	ld c,b			;b935
	ld a,(ix+009h)		;b936   ; cuantos eslabones
	and 007h		;b939
	ld (0f020h),a		;b93b
	bit 0,(ix+015h)		;b93e   ; hacia arriba: el desplazamiento negativo
	jr z,L_B94A		;b942
	add a,a			;b944
	add a,a			;b945
	add a,a			;b946
	neg		;b947
	ld c,a			;b949
L_B94A:
	ld h,007h		;b94a
	ld a,(0f020h)		;b94c   ; ancho: cuantos x 8
	add a,a			;b94f
	add a,a			;b950
	add a,a			;b951
	ld l,a			;b952
	ret			;b953
tamano_de_figura:		; BC y HL = el tamaño del tipo (tabla 0x9006, banco 14)
	call 0420ah		;b954   ; el tamaño del tipo: tabla 0x9006 (banco 14)...
	ld l,(ix+011h)		;b957
	ld h,000h		;b95a
	add hl,hl			;b95c
	add hl,hl			;b95d
	ld bc,09006h		;b95e
	add hl,bc			;b961
	ld c,(hl)			;b962   ; ...BC el desplazamiento, HL el tamaño
	inc hl			;b963
	ld b,(hl)			;b964
	inc hl			;b965
	ld a,(hl)			;b966
	inc hl			;b967
	ld h,(hl)			;b968
	ld l,a			;b969
	jp 041ffh		;b96a   ; p8000_banco_2: pone el banco 2 en 0x8000
se_tocan:		; C si el recuadro DE/DE' toca a la figura IX (y 5, x 7)
	ld a,e			;b96d   ; C si se solapan: en la y...
	sub (ix+005h)		;b96e
	sub c			;b971
	exx			;b972
	add a,e			;b973
	exx			;b974
	jr c,L_B979		;b975
	cp l			;b977
	ret nc			;b978
L_B979:
	ld a,d			;b979   ; ...y en la x
	sub (ix+007h)		;b97a
	sub b			;b97d
	exx			;b97e
	add a,d			;b97f
	exx			;b980
	ret c			;b981
	cp h			;b982
	ret			;b983
se_tocan_2_3:		; C si el recuadro toca el de (ix+2, ix+3)
	ld a,e			;b984
	sub (ix+002h)		;b985   ; la distancia en y...
	sub c			;b988
	exx			;b989
	add a,e			;b98a
	exx			;b98b
	jr c,L_B990		;b98c   ; ...dentro del alto?
	cp l			;b98e
	ret nc			;b98f
L_B990:
	ld a,d			;b990
	sub (ix+003h)		;b991   ; la distancia en x...
	sub b			;b994
	exx			;b995
	add a,d			;b996
	exx			;b997
	ret c			;b998   ; ...dentro del ancho?
	cp h			;b999
	ret			;b99a
se_tocan_12_13:		; C si el recuadro toca el de (ix+0x12, ix+0x13)
	ld a,e			;b99b
	sub (ix+012h)		;b99c   ; la distancia en y...
	sub c			;b99f
	exx			;b9a0
	add a,e			;b9a1
	exx			;b9a2
	jr c,L_B9A7		;b9a3   ; ...dentro del alto?
	cp l			;b9a5
	ret nc			;b9a6
L_B9A7:
	ld a,d			;b9a7
	sub (ix+013h)		;b9a8   ; la distancia en x...
	sub b			;b9ab
	exx			;b9ac
	add a,d			;b9ad
	exx			;b9ae
	ret c			;b9af   ; ...dentro del ancho?
	cp h			;b9b0
	ret			;b9b1
choque_con_el_jefe:		; el personaje contra el jefe: golpeado y el daño de 0xBAD2
	ld a,(0e700h)		;b9b2   ; con jefe...
	or a			;b9b5
	ret z			;b9b6
	ld a,(0e518h)		;b9b7   ; ...sin parpadeo...
	or a			;b9ba
	ret nz			;b9bb
	ld a,(0e702h)		;b9bc   ; ...y el jefe que hace daño (bit 6)...
	bit 6,a		;b9bf
	ret z			;b9c1
	call tamano_del_personaje		;b9c2   ; tamano_del_personaje: DE = la esquina del personaje, DE' = su tamaño
	call toca_al_jefe		;b9c5   ; ...si lo toca...
	ret nc			;b9c8
	call golpeado_por_el_jefe		;b9c9   ; ...golpeado, el daño y el sonido
	call dano_del_jefe		;b9cc   ; dano_del_jefe: lo que quita el jefe (0xBAD2; la mitad con el objeto 0x08)
	jp L_B28C		;b9cf
toca_al_jefe:		; C si el personaje toca al jefe (por tipo)
	ld a,(0e700h)		;b9d2   ; por el tipo de jefe (tabla que sigue)
	dec a			;b9d5
	call 04140h		;b9d6   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld a,(0e505h)		;b9ef   ; el jefe 2: p03:BD98
	ld e,a			;b9f2
	ld a,(0e507h)		;b9f3   ; lee la x del personaje
	ld d,a			;b9f6
	jp toca_jefe_2		;b9f7   ; toca_jefe_2: C si toca la cabeza del jefe 2
L_B9FA:
	call recuadro_del_jefe_toca		;b9fa   ; el jefe 6: su recuadro de la tabla 0xBA12 segun el mosaico
	ret c			;b9fd
	call recuadro_jefe_6		;b9fe   ; recuadro_jefe_6: HL = el recuadro del jefe 6 segun su mosaico (0xBA12)
	jp L_BAE1		;ba01
recuadro_jefe_6:		; HL = el recuadro del jefe 6 segun su mosaico (0xBA12)
	ld a,(0e70ah)		;ba04   ; lee el mosaico del jefe
	ld b,034h		;ba07
	ld hl,0ba12h		;ba09
L_BA0C:
	sub b			;ba0c
	add a,a			;ba0d
	add a,a			;ba0e
	jp 04136h		;ba0f   ; hl_mas_a: HL += A

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
	call recuadro_del_jefe_toca		;ba1e   ; el jefe 10: segun la cola (0xBA32)
	ret c			;ba21
	call recuadro_jefe_10		;ba22   ; recuadro_jefe_10: HL = el recuadro del jefe 10 segun la cola (0xBA32)
	jp L_BAE1		;ba25
recuadro_jefe_10:		; HL = el recuadro del jefe 10 segun la cola (0xBA32)
	ld a,(0e719h)		;ba28   ; lee las veces que el jefe ha cambiado de sitio
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
	call recuadro_del_jefe_toca		;ba42   ; el jefe 11: segun el mosaico (0xBA56)
	ret c			;ba45
	call recuadro_jefe_11		;ba46   ; recuadro_jefe_11: HL = el recuadro del jefe 11 segun el mosaico (0xBA56)
	jp L_BAE1		;ba49
recuadro_jefe_11:		; HL = el recuadro del jefe 11 segun el mosaico (0xBA56)
	ld a,(0e70ah)		;ba4c   ; lee el mosaico del jefe
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


golpeado_por_el_jefe:		; golpeado por el jefe
	call lado_del_jefe		;ba6e   ; golpeado: estado 4, sin daño un rato
	xor a			;ba71
	ld (0e50eh),a		;ba72   ; guarda el paso en la escalera
	ld (0e508h),a		;ba75   ; guarda la espada (1 empieza, 2 golpeando)
	inc a			;ba78
	ld (0e518h),a		;ba79   ; guarda sin daño (tras un golpe o al entrar)
	ld a,004h		;ba7c
	ld (0e500h),a		;ba7e   ; guarda el estado del personaje (5 = hundirse)
	ret			;ba81
lado_del_jefe:		; 0xE514 = el lado del jefe
	ld a,(0e70ah)		;ba82   ; el lado del golpe: la x del jefe mas lo del mosaico (0xBA9A)
	ld c,a			;ba85
	ld b,000h		;ba86
	ld hl,0ba9ah		;ba88
	add hl,bc			;ba8b
	ld a,(0e707h)		;ba8c   ; lee la x del jefe
	add a,(hl)			;ba8f
	sub d			;ba90
	ld a,000h		;ba91
	jr nc,L_BA96		;ba93
	inc a			;ba95
L_BA96:
	ld (0e514h),a		;ba96   ; guarda el lado del golpe
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


dano_del_jefe:		; lo que quita el jefe (0xBAD2; la mitad con el objeto 0x08)
	ld hl,0bad2h		;baba   ; el daño del tipo de jefe (0xBAD2)...
	ld a,(0e700h)		;babd   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	ld c,a			;bac0
	ld b,000h		;bac1
	add hl,bc			;bac3
	ld a,(0e077h)		;bac4   ; ...la mitad con el objeto 0x08...
	or a			;bac7
	ld a,(hl)			;bac8
	jr z,L_BACE		;bac9
	rra			;bacb
	and 07fh		;bacc
L_BACE:
	neg		;bace   ; ...y se resta
	jp 0612ch		;bad0   ; cambia_vida: suma A (con signo) al cambio de vida pendiente del que juega

; ----------------------------------------------------------------------
; DATOS once_bytes_bad3: 11 bytes que p03:BABA lee en 0xBAD2 + (0xE700) (1-11)
;   0xbad3..0xbade  (11 bytes)
DATA_once_bytes_bad3:
	defb 008h,00ch,014h,00ch,000h,024h,018h,020h,028h,010h,010h	; bad3  .....$. (..

; ======================================================================
; CODIGO 0xbade..0xbb7a  (156 bytes)
; ======================================================================


recuadro_del_jefe_toca:		; C si toca el recuadro del mosaico del jefe
	call recuadro_del_mosaico		;bade   ; el recuadro del mosaico...
L_BAE1:
	call 0420ah		;bae1   ; p8000_banco_14: pone el banco 14 en 0x8000
	call toca_recuadro		;bae4   ; toca_recuadro: C si DE esta en el recuadro de HL
	jp 041ffh		;bae7   ; p8000_banco_2: pone el banco 2 en 0x8000
toca_recuadro:		; C si DE esta en el recuadro de HL
	ld a,(0e705h)		;baea   ; C si la y y la x estan dentro del recuadro [dy][alto][dx][ancho]
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
	ld a,(0e707h)		;baf8   ; lee la x del jefe
	add a,(hl)			;bafb
	inc hl			;bafc
	sub d			;bafd
	cp 010h		;bafe
	ret c			;bb00
	inc hl			;bb01
	add a,(hl)			;bb02
	ret			;bb03
recuadro_del_mosaico:		; HL = el recuadro del mosaico del jefe (0x928A, banco 14)
	call 0420ah		;bb04   ; el recuadro: tabla 0x928A por tipo (banco 14)...
	ld hl,0928ah		;bb07
	ld a,(0e700h)		;bb0a   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	add a,a			;bb0d
	call 04136h		;bb0e   ; hl_mas_a: HL += A
	ld a,(hl)			;bb11
	inc hl			;bb12
	ld h,(hl)			;bb13
	ld l,a			;bb14
	ld b,(hl)			;bb15
	inc hl			;bb16
	ld a,(0e70ah)		;bb17   ; ...4 bytes por mosaico
	sub b			;bb1a
	add a,a			;bb1b
	add a,a			;bb1c
	ld c,a			;bb1d
	ld b,000h		;bb1e
	add hl,bc			;bb20
	jp 041ffh		;bb21   ; p8000_banco_2: pone el banco 2 en 0x8000
armas_contra_el_jefe:		; las armas contra el jefe
	ld iy,0e540h		;bb24   ; las armas contra el jefe
	ld b,006h		;bb28
L_BB2A:
	push bc			;bb2a
	call arma_contra_el_jefe		;bb2b   ; arma_contra_el_jefe: un arma contra el jefe
	ld bc,00020h		;bb2e
	add iy,bc		;bb31
	pop bc			;bb33
	djnz L_BB2A		;bb34
	ret			;bb36
arma_contra_el_jefe:		; un arma contra el jefe
	ld a,(0e500h)		;bb37   ; no hundiendose, ni con el jefe vencido...
	cp 005h		;bb3a
	ret z			;bb3c
	ld a,(0e02ch)		;bb3d   ; lee el jefe vencido (estado 0x13)
	or a			;bb40
	ret nz			;bb41
	ld a,(iy+000h)		;bb42   ; ...las armas 1-5 en vuelo...
	or a			;bb45
	ret z			;bb46
	cp 006h		;bb47
	ret nc			;bb49
	bit 0,(iy+002h)		;bb4a
	ret z			;bb4e
	call tamano_del_arma		;bb4f   ; tamano_del_arma: DE = la esquina del arma, DE' = su tamaño (0xB8EF)
	ld ix,0e700h		;bb52   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	call arma_toca_al_jefe		;bb56   ; ...si le da: herido
	jp c,arma_da_al_jefe		;bb59   ; arma_da_al_jefe: el arma da al jefe: si esa arma le hiere, una de vida menos
	ret			;bb5c
arma_toca_al_jefe:		; C si el arma hiere al jefe (tabla 0xBB7A por tipo)
	ld a,(0e702h)		;bb5d   ; el jefe se puede herir (bit 5)...
	and 020h		;bb60
	ret z			;bb62
	call arma_en_fila		;bb63   ; arma_en_fila: C si el arma alcanza a la figura en su fila
	ret nc			;bb66
	call arma_en_columna		;bb67   ; arma_en_columna: C si el arma alcanza a la figura en su columna
	ret nc			;bb6a
	ld a,(iy+000h)		;bb6b   ; ...el arma 5 aparte...
	cp 005h		;bb6e
	jp z,L_BC25		;bb70
L_BB73:
	ld a,(0e700h)		;bb73   ; ...por el tipo (tabla que sigue)
	dec a			;bb76
	call 04140h		;bb77   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call arma_desde_lado		;bb90   ; el jefe 2
	jp cuerpo_jefe_2		;bb93   ; cuerpo_jefe_2: C si toca el cuerpo del jefe 2
L_BB96:
	ld a,(0e70ah)		;bb96   ; el jefe 4 solo abierto (mosaico >= 0x12)
	cp 012h		;bb99
	ccf			;bb9b
	ret nc			;bb9c
	jr L_BBAD		;bb9d
L_BB9F:
	ld a,(0e70ah)		;bb9f   ; el jefe 7 solo con la boca abierta (>= 0x19)
	cp 019h		;bba2
	ccf			;bba4
	ret nc			;bba5
	jr L_BBAD		;bba6
galious_se_hiere:		; a GALIOUS solo se le hiere con el objeto 0x0B
	ld a,(0e07ah)		;bba8   ; GALIOUS solo con el objeto 0x0B
	or a			;bbab
	ret z			;bbac
L_BBAD:
	call recuadro_del_jefe		;bbad   ; su recuadro...
arma_en_recuadro:		; C si el arma esta en el recuadro BC/HL
	ld a,l			;bbb0   ; ...y si lo toca el arma
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
	jp se_tocan		;bbbc   ; se_tocan: C si el recuadro DE/DE' toca a la figura IX (y 5, x 7)
L_BBBF:
	ld hl,0bbdbh		;bbbf   ; el jefe 6: sus tres cabezas (0xBBDB, 0xBBE8, 0xBBF5)
	call recuadro_de_mosaico		;bbc2   ; recuadro_de_mosaico: BC y HL del recuadro del mosaico de la tabla HL
	call arma_en_recuadro		;bbc5   ; la primera cabeza
	ret c			;bbc8
	ld hl,0bbe8h		;bbc9
	call recuadro_de_mosaico		;bbcc   ; recuadro_de_mosaico: BC y HL del recuadro del mosaico de la tabla HL
	call arma_en_recuadro		;bbcf   ; la segunda
	ret c			;bbd2
	ld hl,0bbf5h		;bbd3
	call recuadro_de_mosaico		;bbd6   ; la tercera
	jr arma_en_recuadro		;bbd9

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
	ld a,(0e70ah)		;bc02   ; el jefe 9: con el mosaico de 0xE719 un momento
	push af			;bc05
	ld a,(0e719h)		;bc06   ; lee las veces que el jefe ha cambiado de sitio
	ld (0e70ah),a		;bc09   ; guarda el mosaico del jefe
	call recuadro_del_jefe		;bc0c   ; recuadro_del_jefe: en la sala del jefe sin jefe, 0xE615 = 1 y las letras a cero
	pop af			;bc0f
	ld (0e70ah),a		;bc10   ; guarda el mosaico del jefe
	jr $-99		;bc13
arma_desde_lado:		; el recuadro del arma segun su lado
	ld a,(iy+010h)		;bc15   ; el arma hacia la izquierda, 8 mas alla
	and a			;bc18
	jr z,L_BC1F		;bc19
	ld a,d			;bc1b
	add a,008h		;bc1c
	ld d,a			;bc1e
L_BC1F:
	exx			;bc1f   ; HL = el tamaño, DE' = la esquina
	ex de,hl			;bc20
	push hl			;bc21
	exx			;bc22
	pop hl			;bc23
	ret			;bc24
L_BC25:
	bit 2,(iy+002h)		;bc25   ; el arma 5 estallando: por el tipo de jefe
	jp z,L_BB73		;bc29
	ld a,(0e700h)		;bc2c   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	dec a			;bc2f
	call 04140h		;bc30   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call recuadro_jefe_14		;bc4e   ; recuadro_jefe_14: el recuadro del mosaico con el banco 14
	ret c			;bc51
	call recuadro_jefe_6		;bc52   ; recuadro_jefe_6: HL = el recuadro del jefe 6 segun su mosaico (0xBA12)
	jr L_BC6F		;bc55
L_BC57:
	call recuadro_jefe_14		;bc57   ; recuadro_jefe_14: el recuadro del mosaico con el banco 14
	ret c			;bc5a
	call recuadro_jefe_10		;bc5b   ; recuadro_jefe_10: HL = el recuadro del jefe 10 segun la cola (0xBA32)
	jr L_BC6F		;bc5e
L_BC60:
	call recuadro_jefe_14		;bc60   ; recuadro_jefe_14: el recuadro del mosaico con el banco 14
	ret c			;bc63
	call recuadro_jefe_11		;bc64   ; recuadro_jefe_11: HL = el recuadro del jefe 11 segun el mosaico (0xBA56)
	jr L_BC6F		;bc67
recuadro_jefe_14:		; el recuadro del mosaico con el banco 14
	call recuadro_del_mosaico		;bc69   ; el recuadro del mosaico
	call 0420ah		;bc6c   ; p8000_banco_14: pone el banco 14 en 0x8000
L_BC6F:
	call lee_recuadro		;bc6f   ; lee_recuadro: BC y HL de (HL), y el banco 2
	jp arma_en_recuadro		;bc72   ; arma_en_recuadro: C si el arma esta en el recuadro BC/HL
arma_da_al_jefe:		; el arma da al jefe: si esa arma le hiere, una de vida menos
	ld a,(iy+000h)		;bc75   ; el arma da al jefe: la 5 aparte...
	cp 005h		;bc78
	jp z,mina_al_jefe		;bc7a   ; mina_al_jefe: el arma 5 estalla junto al jefe: dos de vida
	ld a,(iy+000h)		;bc7d   ; ...la 2 atraviesa, las demas se acaban
	cp 002h		;bc80
	push af			;bc82
	call z,atravesada		;bc83   ; atravesada: el bit 5 de (ix+3)
	pop af			;bc86
	ld c,(iy+000h)		;bc87
	push bc			;bc8a
	call nz,acaba_arma		;bc8b   ; acaba_arma: el arma se acaba: una menos y el hueco a cero
	pop bc			;bc8e
	xor a			;bc8f
hiere_al_jefe:		; una de vida menos si el arma le hiere (tabla 0xBD0A)
	call arma_que_hiere		;bc90   ; si esa arma no le hace nada, nada...
	ret c			;bc93
	ld a,027h		;bc94   ; ...si no, el sonido 0x27 y una de vida menos...
	call 04e1fh		;bc96   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	dec (ix+010h)		;bc99
	jp z,jefe_vencido		;bc9c   ; ...a 0, vencido
jefe_herido:		; 0xE1C5 = 0, 1 o 2 segun la vida que le queda
	ld a,(0e710h)		;bc9f   ; lo herido que esta para la musica: vida < 1/4 de la de partida...
	ld b,a			;bca2
	ld c,000h		;bca3
	ld a,(0e700h)		;bca5   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	ld hl,07f97h		;bca8
	call 04155h		;bcab   ; byte_de_tabla: A = el byte HL + A
	srl a		;bcae
	srl a		;bcb0
	cp b			;bcb2
	jr c,L_BCBC		;bcb3
	inc c			;bcb5
	srl a		;bcb6   ; ...o < 1/8 (0xE1C5 = 0, 1 o 2)
	cp b			;bcb8
	jr c,L_BCBC		;bcb9
	inc c			;bcbb
L_BCBC:
	ld a,c			;bcbc
	ld (0e1c5h),a		;bcbd   ; guarda lo herido que esta el jefe (0, 1, 2)
	ret			;bcc0
arma_que_hiere:		; C si esa arma no hiere a ese jefe (tabla 0xBD0A; rebota)
	or a			;bcc1   ; que arma: la espada (A no 0) el bit 0...
	ld b,001h		;bcc2
	jr nz,L_BCE1		;bcc4
	ld a,c			;bcc6   ; ...el arma 1 el bit 5, la 2 el 4, la 3 el 2, la 4 el 3, la 5 el 1
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
	ld a,(0e700h)		;bce1   ; los bits de las armas que hieren a cada jefe (tabla 0xBD0A)...
	dec a			;bce4
	ld hl,0bd0ah		;bce5
	call 04136h		;bce8   ; hl_mas_a: HL += A
	ld a,(hl)			;bceb
	and b			;bcec
	jr nz,L_BCFB		;bced
	ld a,c			;bcef   ; ...si no le hace nada, rebota con el sonido 0x1D (la 5 en silencio)
	cp 005h		;bcf0
	scf			;bcf2
	ret z			;bcf3
	ld a,01dh		;bcf4
	call 04e1fh		;bcf6   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	scf			;bcf9
	ret			;bcfa
L_BCFB:
	ld a,(0e700h)		;bcfb   ; al jefe 6 se le cierra la boca (0xE71C = 1)
	cp 006h		;bcfe
	scf			;bd00
	ccf			;bd01
	ret nz			;bd02
	ld a,001h		;bd03
	ld (0e71ch),a		;bd05   ; guarda la fila de la cola del jefe 10
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


mina_al_jefe:		; el arma 5 estalla junto al jefe: dos de vida
	bit 2,(iy+002h)		;bd15   ; el arma 5 estalla junto al jefe...
	call z,estalla_27		;bd19   ; estalla_27: estalla con el sonido 0x27
	set 4,(ix+003h)		;bd1c
	xor a			;bd20
	ld c,005h		;bd21   ; ...si le hace algo, dos de vida menos
	call arma_que_hiere		;bd23   ; arma_que_hiere: C si esa arma no hiere a ese jefe (tabla 0xBD0A; rebota)
	ret c			;bd26
	dec (ix+010h)		;bd27
	jr z,jefe_vencido		;bd2a
	dec (ix+010h)		;bd2c
	jp nz,jefe_herido		;bd2f   ; jefe_herido: 0xE1C5 = 0, 1 o 2 segun la vida que le queda
jefe_vencido:		; el jefe vencido: 0xE02C = 1 y las musicas 0x84 y 0x91
	xor a			;bd32   ; vencido: 0xE02C = 1...
	ld (0e1c5h),a		;bd33   ; guarda lo herido que esta el jefe (0, 1, 2)
	inc a			;bd36
	ld (0e02ch),a		;bd37   ; guarda el jefe vencido (estado 0x13)
	ld a,084h		;bd3a   ; ...la musica 0x84...
	call 04e1fh		;bd3c   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,(0e041h)		;bd3f   ; ...y luego la 0x91 (0x8B en el mapa 11)
	cp 00bh		;bd42
	ld a,091h		;bd44
	jr nz,L_BD4A		;bd46
	ld a,08bh		;bd48
L_BD4A:
	jp 05d12h		;bd4a   ; musica_espera: deja esperando la musica A
estalla_27:		; estalla con el sonido 0x27
	call estalla		;bd4d   ; estalla con el sonido 0x27
	ld a,027h		;bd50
	jp 04e1fh		;bd52   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
espada_al_jefe:		; la espada contra el jefe
	ld a,(0e51bh)		;bd55   ; la espada contra el jefe...
	or a			;bd58
	ret z			;bd59
	call tamano_de_la_espada		;bd5a   ; tamano_de_la_espada: DE = la esquina de la espada, DE' = su tamaño
	ld ix,0e700h		;bd5d   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	call arma_toca_al_jefe		;bd61   ; arma_toca_al_jefe: C si el arma hiere al jefe (tabla 0xBB7A por tipo)
	ret nc			;bd64
	xor a			;bd65   ; ...una vez por golpe
	ld (0e51bh),a		;bd66   ; guarda la espada da en algo
	ld c,000h		;bd69
	ld a,001h		;bd6b
	jp hiere_al_jefe		;bd6d   ; hiere_al_jefe: una de vida menos si el arma le hiere (tabla 0xBD0A)
recuadro_del_jefe:		; el recuadro del mosaico del jefe (0x91EC, banco 14)
	call 0420ah		;bd70   ; el recuadro del mosaico del jefe: tabla 0x91EC (banco 14)
	ld hl,091ech		;bd73
	ld a,(0e700h)		;bd76   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	add a,a			;bd79
	call 04136h		;bd7a   ; hl_mas_a: HL += A
	ld a,(hl)			;bd7d
	inc hl			;bd7e
	ld h,(hl)			;bd7f
	ld l,a			;bd80
recuadro_de_mosaico:		; BC y HL del recuadro del mosaico de la tabla HL
	ld b,(hl)			;bd81
	inc hl			;bd82
	ld a,(0e70ah)		;bd83   ; lee el mosaico del jefe
	sub b			;bd86
	add a,a			;bd87
	add a,a			;bd88
	ld c,a			;bd89
	ld b,000h		;bd8a
	add hl,bc			;bd8c
lee_recuadro:		; BC y HL de (HL), y el banco 2
	ld c,(hl)			;bd8d   ; BC y HL del recuadro
	inc hl			;bd8e
	ld b,(hl)			;bd8f
	inc hl			;bd90
	ld a,(hl)			;bd91
	inc hl			;bd92
	ld h,(hl)			;bd93
	ld l,a			;bd94
	jp 041ffh		;bd95   ; p8000_banco_2: pone el banco 2 en 0x8000
toca_jefe_2:		; C si toca la cabeza del jefe 2
	ld hl,01010h		;bd98   ; el jefe 2: el recuadro de 0x10 x 0x10...
	jr L_BDA0		;bd9b
L_BD9D:
	call cabeza_jefe_2		;bd9d   ; cabeza_jefe_2: A = la x de la cabeza del jefe 2
L_BDA0:
	ld a,l			;bda0   ; ...de alto 0x28...
	add a,018h		;bda1
	ld l,a			;bda3
	ld a,(0e705h)		;bda4   ; lee la y del jefe
	add a,000h		;bda7
	ld b,a			;bda9
	ld a,e			;bdaa
	sub b			;bdab
	cp 028h		;bdac
	ret nc			;bdae
	ld a,(0e709h)		;bdaf   ; ...de ancho segun lo crecido
	and 020h		;bdb2
	ld a,(0e70bh)		;bdb4
	jr nz,L_BDBC		;bdb7
	ld a,(0e715h)		;bdb9
L_BDBC:
	dec a			;bdbc   ; ancho x 8 + H
	add a,a			;bdbd
	add a,a			;bdbe
	add a,a			;bdbf
	add a,h			;bdc0
	ld c,a			;bdc1
	ld a,(0e707h)		;bdc2   ; lee la x del jefe
	and 0f8h		;bdc5
	ld b,a			;bdc7
	ld a,d			;bdc8   ; C si esta dentro
	sub b			;bdc9
	cp c			;bdca
	ret			;bdcb
cabeza_jefe_2:		; la cabeza del jefe 2
	ld hl,00c04h		;bdcc   ; la cabeza del jefe 2
	ld a,d			;bdcf
	add a,006h		;bdd0
	ld d,a			;bdd2
	ld a,e			;bdd3
	add a,l			;bdd4
	ld e,a			;bdd5
	ret			;bdd6
cuerpo_jefe_2:		; C si toca el cuerpo del jefe 2
	ld a,l			;bdd7   ; C si toca el cuerpo crecido del jefe 2
	add a,018h		;bdd8
	ld l,a			;bdda
	ld a,(0e705h)		;bddb   ; lee la y del jefe
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
	add a,a			;bdf4   ; el ancho x 8
	add a,a			;bdf5
	add a,a			;bdf6
	ld c,a			;bdf7
	ld a,(0e709h)		;bdf8   ; creciendo hacia la izquierda...
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
	ld a,(0e707h)		;be07   ; lee la x del jefe
	and 0f8h		;be0a
	ld e,a			;be0c
	ld a,(0e709h)		;be0d   ; ...o hacia la derecha
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
empieza_la_taza:		; la pausa: sentado en la taza 600 cuadros
	ld a,01ch		;be26   ; la pausa: la pose 0x1C (sentado en la taza) 600 cuadros...
	ld (0e53dh),a		;be28   ; guarda la pose del personaje en la pausa
	ld hl,00258h		;be2b
	ld (0e53ah),hl		;be2e   ; guarda la cuenta de la taza y el byte siguiente (16 bits)
	xor a			;be31
	ld (0e53ch),a		;be32
	ret			;be35
taza:		; las poses de la taza
	ld a,(0e53ch)		;be36   ; ...luego la 0x1E...
	dec a			;be39
	jr z,L_BE50		;be3a
	ld hl,(0e53ah)		;be3c   ; lee la cuenta de la taza y el byte siguiente (16 bits)
	dec hl			;be3f
	ld (0e53ah),hl		;be40   ; guarda la cuenta de la taza y el byte siguiente (16 bits)
	ld a,h			;be43
	or l			;be44
	ret nz			;be45
	ld a,01eh		;be46
	ld hl,0e53ch		;be48
	inc (hl)			;be4b
L_BE4C:
	ld (0e53dh),a		;be4c   ; guarda la pose del personaje en la pausa
	ret			;be4f
L_BE50:
	ld hl,0e53ah		;be50   ; ...y cada 8 cuadros la 0x1E o la 0x1F
	inc (hl)			;be53
	ld a,(hl)			;be54
	and 007h		;be55
	ret nz			;be57
	ld a,(0e53dh)		;be58   ; lee la pose del personaje en la pausa
	xor 001h		;be5b
	jr L_BE4C		;be5d
empieza_la_alegria:		; estado 0x14: 9 saltos de alegria
	ld a,(0e505h)		;be5f   ; el estado 0x14: salta de alegria 9 veces...
	ld (0e53eh),a		;be62
	ld a,004h		;be65
	ld (0e502h),a		;be67   ; guarda la pose del personaje
	ld a,009h		;be6a
	ld (0e50fh),a		;be6c   ; guarda la cuenta del golpe
	xor a			;be6f
	ld (0e50eh),a		;be70   ; guarda el paso en la escalera
	call sin_parpadeo		;be73   ; sin_parpadeo: 0xE533 y 0xE518 a 0
	inc a			;be76   ; ...0xE53F = 1
	ld (0e53fh),a		;be77   ; guarda los saltos de alegria
salto_de_alegria:		; velocidad -0xA00
	ld hl,0f600h		;be7a   ; la velocidad de cada salto: -0xA00
	ld (0e512h),hl		;be7d   ; guarda la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	ret			;be80
alegria:		; los saltos y el rotulo del estado 0x14
	call 073d6h		;be81   ; cada cuadro: los sprites y la VRAM...
	call 05435h		;be84   ; vram_del_estado: lo de la VRAM en la interrupcion segun el estado (tabla 0x543B)
	ld a,(0e50eh)		;be87   ; lee el paso en la escalera
	and a			;be8a
	jr nz,L_BEC7		;be8b
	ld de,00080h		;be8d   ; ...la gravedad 0x80...
	ld hl,(0e512h)		;be90   ; lee la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	add hl,de			;be93
	ld (0e512h),hl		;be94   ; guarda la velocidad vertical del golpe o la caida (16 bits) y el byte siguiente (16 bits)
	ex de,hl			;be97
	ld hl,(0e504h)		;be98   ; lee la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	add hl,de			;be9b
	ld l,000h		;be9c
	ld (0e504h),hl		;be9e   ; guarda la y del personaje con su fraccion (16 bits) y el byte siguiente (16 bits)
	ld a,h			;bea1
	ld hl,0e53eh		;bea2   ; ...en el suelo...
	cp (hl)			;bea5
	ret c			;bea6
	ld hl,0e50fh		;bea7   ; ...otro salto mirando al otro lado...
	dec (hl)			;beaa
	jr z,L_BEBB		;beab
	call salto_de_alegria		;bead   ; salto_de_alegria: velocidad -0xA00
	ld a,(0e503h)		;beb0   ; lee hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	xor 001h		;beb3
	ld (0e503h),a		;beb5   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	jp pose_vuelta		;beb8   ; pose_vuelta: la pose con el bit 0 cambiado
L_BEBB:
	ld hl,0e50eh		;bebb   ; ...al acabar, 0x78 cuadros de rotulo
	inc (hl)			;bebe
	ld a,078h		;bebf
	ld (0e50fh),a		;bec1   ; guarda la cuenta del golpe
	jp pose_en_pie		;bec4   ; pose_en_pie: la pose 0 o 2 segun hacia donde mira
L_BEC7:
	ld hl,0e50fh		;bec7   ; el rotulo de 0xBF0B con el numero del mapa, encima de lo que habia...
	dec (hl)			;beca
	jr z,L_BEF7		;becb
	ld de,0eb00h		;becd   ; apunta a el tampon de 0xEB00 (lo de debajo de las figuras; la contraseña)
	ld bc,0001dh		;bed0
	ld hl,0ee41h		;bed3
	ldir		;bed6
	ld de,0ee41h		;bed8
	ld hl,0bf0bh		;bedb
	ld c,01dh		;bede
	ldir		;bee0
	ld a,(0e041h)		;bee2   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld (0ee55h),a		;bee5
	call 054bfh		;bee8   ; ...a la VRAM...
	ld hl,0eb00h		;beeb   ; ...y lo de debajo de vuelta
	ld de,0ee41h		;beee
	ld bc,0001dh		;bef1
	ldir		;bef4
	ret			;bef6
L_BEF7:
	xor a			;bef7   ; se acabo: en pie
	ld (0e53fh),a		;bef8   ; guarda los saltos de alegria
	call estado_del_personaje_a		;befb   ; estado_del_personaje_a: el estado A del personaje y lo demas a cero
	xor a			;befe
	ld (0e518h),a		;beff   ; guarda sin daño (tras un golpe o al entrar)
y_a_la_casilla_del_personaje:		; la y del personaje ajustada a la casilla
	ld a,(0e505h)		;bf02   ; la y ajustada a la casilla
	and 0f8h		;bf05
	ld (0e505h),a		;bf07   ; guarda la y del personaje
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
