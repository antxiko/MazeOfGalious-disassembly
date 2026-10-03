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
sitio_de_partida:		; la y y la x de partida del mapa (tabla 0x6017)
	ld hl,06017h		;6003   ; el sitio de partida del mapa: tabla 0x6017...
	ld a,(0e041h)		;6006   ; lee el mapa (1 el castillo, 2-11 los mundos)
	call 0414ch		;6009   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
L_600C:
	ld a,e			;600c   ; ...E = la y, D = la x
	ld (0e505h),a		;600d   ; guarda la y del personaje
	ld a,d			;6010
	ld (0e507h),a		;6011   ; guarda la x del personaje
	ret			;6014
sitio_guardado:		; la y y la x de 0xE0D0
	ld de,(0e0d0h)		;6015   ; el sitio guardado en 0xE0D0
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


borra_al_entrar:		; 0xE690, 0xE603, 0xE536, 0xE539, 0xE520 y 0xE620-0xE63F a cero
	xor a			;602f   ; al entrar en una sala: sin sala especial...
	ld (0e690h),a		;6030   ; guarda la sala especial (pista o tienda)
	ld (0e603h),a		;6033   ; ...0xE603, 0xE536, 0xE539 y 0xE520 a 0...
	ld (0e536h),a		;6036
	ld (0e539h),a		;6039
	ld (0e520h),a		;603c   ; guarda empujado (1 a la izquierda, 2 a la derecha)
	ld hl,0e620h		;603f   ; ...y 0xE620-0xE63F a cero
	ld de,0e621h		;6042
	ld bc,0001fh		;6045
	ld (hl),000h		;6048
	ldir		;604a
	ret			;604c
cabecera:		; los rotulos, flechas, monedas, llaves, arma y las cuatro barras
	ld de,07caeh		;604d   ; la cabecera: los rotulos (POPOLON, APHRODITE, VIT, EXP)...
	call 05c25h		;6050   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	call 05f79h		;6053   ; ...flechas, monedas y llaves...
	call 05f84h		;6056   ; pinta_monedas: las monedas en la fila 1, columna 24
	call 05f8fh		;6059   ; pinta_llaves: las llaves en la fila 2, columna 24
	call pinta_arma		;605c   ; ...el arma elegida y las cuatro barras
	call barra_vida_popolon		;605f   ; barra_vida_popolon: la barra de vida de Popolon
	call barra_vida_afrodita		;6062   ; barra_vida_afrodita: la barra de vida de Afrodita
	call barra_exp_popolon		;6065   ; barra_exp_popolon: la barra de experiencia de Popolon
	jp barra_exp_afrodita		;6068   ; barra_exp_afrodita: la barra de experiencia de Afrodita
pinta_arma:		; el arma elegida (0xE510) en la fila 1, columna 28
	ld hl,0383ch		;606b   ; el arma elegida (0xE510): dos caracteres de 0x5F6B en la fila 1, columna 28
	call 05bc8h		;606e   ; vram_para_escribir: SETWRT de HL y C' = el puerto de datos del VDP
	exx			;6071
	ld a,(0e510h)		;6072   ; lee el arma elegida
	add a,a			;6075
	ld hl,05f6bh		;6076
	ld e,a			;6079
	ld d,000h		;607a
	add hl,de			;607c
	ld b,002h		;607d
L_607F:
	outi		;607f   ; al puerto del VDP
	jp nz,L_607F		;6081
	ret			;6084
repinta_barras:		; las barras de los bits de 0xE062
	ld a,(0e062h)		;6085   ; las barras que hay que repintar (bits de 0xE062)
	or a			;6088
	ret z			;6089
	rra			;608a   ; bit 0: la vida de Popolon
	push af			;608b
	call c,barra_vida_popolon		;608c   ; barra_vida_popolon: la barra de vida de Popolon
	pop af			;608f
	rra			;6090   ; bit 1: la experiencia de Popolon
	push af			;6091
	call c,barra_exp_popolon		;6092   ; barra_exp_popolon: la barra de experiencia de Popolon
	pop af			;6095
	rra			;6096   ; bit 2: la vida de Afrodita
	push af			;6097
	call c,barra_vida_afrodita		;6098   ; barra_vida_afrodita: la barra de vida de Afrodita
	pop af			;609b
	rra			;609c   ; bit 3: la experiencia de Afrodita
	push af			;609d
	call c,barra_exp_afrodita		;609e   ; barra_exp_afrodita: la barra de experiencia de Afrodita
	pop af			;60a1
	ret			;60a2
barra_vida_popolon:		; la barra de vida de Popolon
	ld de,0e056h		;60a3   ; la vida de Popolon: fila 1, columna 2, caracteres azules (0x2D)
	ld hl,03822h		;60a6
	ld b,02dh		;60a9
	jr barra		;60ab
barra_vida_afrodita:		; la barra de vida de Afrodita
	ld de,0e052h		;60ad   ; la de Afrodita: fila 1, columna 13, rojos (0x38)
	ld hl,0382dh		;60b0
	ld b,038h		;60b3
	jr barra		;60b5
barra_exp_popolon:		; la barra de experiencia de Popolon
	ld de,0e054h		;60b7   ; la experiencia de Popolon: fila 2, columna 2
	ld hl,03842h		;60ba
	ld b,02dh		;60bd
	jr barra		;60bf
barra_exp_afrodita:		; la barra de experiencia de Afrodita
	ld de,0e050h		;60c1   ; la de Afrodita: fila 2, columna 13
	ld hl,0384dh		;60c4
	ld b,038h		;60c7
barra:		; la barra de DE (valor y tope) en la VRAM de HL
	ld (0f000h),hl		;60c9   ; la barra se monta en 0xF008: B' = los caracteres de color
	ld a,b			;60cc
	exx			;60cd
	ld b,a			;60ce
	exx			;60cf
	ld hl,0f008h		;60d0   ; el extremo izquierdo (0x36)...
	ld (hl),036h		;60d3
	ld bc,00635h		;60d5   ; ...y 6 vacios (0x35)
L_60D8:
	inc l			;60d8   ; 6 vacios
	ld (hl),c			;60d9
	djnz L_60D8		;60da
	ld hl,0f009h		;60dc
	ld a,(de)			;60df   ; el valor / 8: caracteres llenos (B' + 7)
	rra			;60e0
	rra			;60e1
	rra			;60e2
	and 01fh		;60e3   ; los llenos
	jr z,L_60F1		;60e5
	ld b,a			;60e7
	exx			;60e8   ; B' (el color)...
	ld a,b			;60e9
	exx			;60ea
	add a,007h		;60eb   ; ...+ 7: lleno
L_60ED:
	ld (hl),a			;60ed
	inc l			;60ee
	djnz L_60ED		;60ef
L_60F1:
	ld a,(de)			;60f1   ; el resto: un caracter a medias (B' - 1 + resto)
	and 007h		;60f2
	jr z,L_60FB		;60f4
	dec a			;60f6
	exx			;60f7
	add a,b			;60f8
	exx			;60f9
	ld (hl),a			;60fa
L_60FB:
	inc e			;60fb   ; el tope / 8...
	ld a,(de)			;60fc
	rra			;60fd
	rra			;60fe
	rra			;60ff
	and 01fh		;6100
	ld hl,0f009h		;6102
	add a,l			;6105
	ld l,a			;6106
	ld a,02ch		;6107   ; ...lleva la marca 0x2C
	ld (hl),a			;6109
	ld hl,0f00fh		;610a
	ld (hl),037h		;610d   ; y el extremo derecho (0x37)
	call 054ddh		;610f   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	ld hl,(0f000h)		;6112   ; los 8 a la VRAM
	call 05bc8h		;6115   ; vram_para_escribir: SETWRT de HL y C' = el puerto de datos del VDP
	exx			;6118
	ld hl,0f008h		;6119
	ld b,008h		;611c
L_611E:
	outi		;611e
	jp nz,L_611E		;6120
	jp 054e1h		;6123   ; figuras_sueltas: 0xE602 = 0
cambia_vida_de:		; como cambia_vida, para el personaje de 0xF000
	ld c,a			;6126   ; con el personaje de 0xF000
	ld a,(0f000h)		;6127
	jr L_6130		;612a
cambia_vida:		; suma A (con signo) al cambio de vida pendiente del que juega
	ld c,a			;612c
	ld a,(0e501h)		;612d   ; lee quien juega (0 Afrodita)
L_6130:
	ld hl,0e05eh		;6130   ; el cambio pendiente del que juega: 0xE05E Afrodita, 0xE061 Popolon
	or a			;6133
	jr z,L_6138		;6134
	ld l,061h		;6136
L_6138:
	ld a,c			;6138   ; sumar...
	or a			;6139
	jp m,L_6142		;613a
	add a,(hl)			;613d   ; ...sin pasar de 0x7F
	or a			;613e
	ret m			;613f
	jr L_6145		;6140
L_6142:
	add a,(hl)			;6142   ; restar sin pasar de -0x80
	or a			;6143
	ret p			;6144
L_6145:
	ld a,c			;6145   ; se suma al pendiente
	add a,(hl)			;6146
	ld (hl),a			;6147
	ld a,c			;6148
	or a			;6149
	ret z			;614a
	rl c		;614b   ; si es un golpe (negativo)...
	ret c			;614d
	ld a,(0e61eh)		;614e   ; ...y no hay 0xE61E...
	or a			;6151
	ret nz			;6152
	ld a,029h		;6153   ; ...el sonido 0x29
	jp 04e1fh		;6155   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
suma_experiencia:		; suma A x 256 a la experiencia del que juega
	ld d,a			;6158   ; A x 256...
	ld e,000h		;6159
	ld a,(0e501h)		;615b   ; lee quien juega (0 Afrodita)
	or a			;615e
	jr nz,L_6169		;615f
	ld hl,(0e05ch)		;6161   ; ...a la de Afrodita...
	add hl,de			;6164
	ld (0e05ch),hl		;6165   ; guarda la experiencia de Afrodita
	ret			;6168
L_6169:
	ld hl,(0e05fh)		;6169   ; ...o a la de Popolon
	add hl,de			;616c
	ld (0e05fh),hl		;616d   ; guarda la experiencia de Popolon
	ret			;6170
vida_y_experiencia:		; cada 4 cuadros, lo pendiente de vida y experiencia de los dos
	xor a			;6171   ; cada 4 cuadros, salvo hundiendose...
	ld (0e062h),a		;6172   ; guarda las barras que repintar (bits 0-3)
	ld a,(0e500h)		;6175   ; lee el estado del personaje (5 = hundirse)
	cp 005h		;6178
	ret z			;617a
	ld a,(0e604h)		;617b   ; lee el contador de cuadros de partida
	inc a			;617e
	and 003h		;617f
	ret nz			;6181
	call pendiente_afrodita		;6182   ; ...lo pendiente de los dos...
	call pendiente_popolon		;6185   ; pendiente_popolon: la experiencia y la vida pendientes de Popolon
	ld a,c			;6188   ; ...y las barras que han cambiado a 0xE062
	ld (0e062h),a		;6189   ; guarda las barras que repintar (bits 0-3)
	ret			;618c
pendiente_afrodita:		; la experiencia y la vida pendientes de Afrodita
	xor a			;618d   ; Afrodita: la experiencia (0xE050) con su pendiente (0xE05D)...
	ld (0f000h),a		;618e
	ld hl,0e050h		;6191   ; apunta a la experiencia de Afrodita (barra)
	ld de,0e05dh		;6194   ; apunta a la experiencia pendiente de Afrodita
	call paso_de_experiencia		;6197   ; paso_de_experiencia: un paso de la experiencia; llena, rellena la vida
	ld hl,0e052h		;619a   ; ...la vida (0xE052) con la suya (0xE05E)
	ld de,0e05eh		;619d   ; apunta a el cambio de vida pendiente de Afrodita (con signo)
	call paso_de_vida		;61a0   ; paso_de_vida: un paso de la vida hasta su tope
	ld a,(0e052h)		;61a3   ; sin vida, si es la que juega, muere
	or a			;61a6
	ret nz			;61a7
	push bc			;61a8
	ld a,(0e501h)		;61a9   ; lee quien juega (0 Afrodita)
	or a			;61ac
	call z,0b337h		;61ad   ; muere: la vida y la experiencia del que juega a cero
	pop bc			;61b0
	ret			;61b1
pendiente_popolon:		; la experiencia y la vida pendientes de Popolon
	ld a,001h		;61b2   ; Popolon: la experiencia (0xE054) con 0xE060...
	ld (0f000h),a		;61b4
	ld hl,0e054h		;61b7   ; apunta a la experiencia de Popolon (barra)
	ld de,0e060h		;61ba   ; apunta a la experiencia pendiente de Popolon
	call paso_de_experiencia		;61bd   ; paso_de_experiencia: un paso de la experiencia; llena, rellena la vida
	ld hl,0e056h		;61c0   ; ...la vida (0xE056) con 0xE061
	ld de,0e061h		;61c3   ; apunta a el cambio de vida pendiente de Popolon (con signo)
	call paso_de_vida		;61c6   ; paso_de_vida: un paso de la vida hasta su tope
	ld a,(0e056h)		;61c9   ; sin vida, si es el que juega, muere
	or a			;61cc
	ret nz			;61cd
	push bc			;61ce
	ld a,(0e501h)		;61cf   ; lee quien juega (0 Afrodita)
	or a			;61d2
	call nz,0b337h		;61d3   ; muere: la vida y la experiencia del que juega a cero
	pop bc			;61d6
	ret			;61d7
paso_de_experiencia:		; un paso de la experiencia; llena, rellena la vida
	call paso_pendiente		;61d8   ; un paso de la experiencia...
	rl c		;61db
	bit 0,c		;61dd
	ret z			;61df
	ld a,(hl)			;61e0   ; ...si llega al tope (el byte siguiente)...
	inc l			;61e1
	sub (hl)			;61e2
	ret c			;61e3
	dec l			;61e4
	ld (hl),a			;61e5   ; ...vuelve a empezar desde lo que sobra...
	inc l			;61e6
	inc l			;61e7
	ld a,(hl)			;61e8   ; ...y si la vida no esta en su tope...
	inc l			;61e9
	cp (hl)			;61ea
	ret nc			;61eb
	ld a,(hl)			;61ec   ; ...se le suma el tope de la vida: barra de experiencia llena = vida
	exx			;61ed
	call cambia_vida_de		;61ee   ; cambia_vida_de: como cambia_vida, para el personaje de 0xF000
	exx			;61f1
	ret			;61f2
paso_de_vida:		; un paso de la vida hasta su tope
	call paso_pendiente		;61f3   ; un paso de la vida...
	rl c		;61f6
	bit 0,c		;61f8
	ret z			;61fa
	ld a,(hl)			;61fb   ; ...sin pasar del tope
	inc l			;61fc
	cp (hl)			;61fd
	ret c			;61fe
	ld a,(hl)			;61ff
	dec l			;6200
	ld (hl),a			;6201
	ret			;6202
paso_pendiente:		; uno arriba o abajo de (HL) segun el pendiente (DE)
	ld a,(de)			;6203   ; el pendiente: negativo, uno menos y el pendiente sube...
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
	inc (hl)			;620f   ; ...positivo, uno mas y el pendiente baja
	ld a,(de)			;6210
	dec a			;6211
	ld (de),a			;6212
	scf			;6213
	ret			;6214
empieza_titulo:		; el titulo: sprites, rotulo y espera
	call 05280h		;6215   ; el titulo: sin sprites...
	ld hl,093e7h		;6218   ; ...4 sprites de 0x93E7...
	ld de,0ec80h		;621b   ; apunta a la copia de la tabla de sprites (128 bytes)
	ld bc,00010h		;621e
	ldir		;6221
	ld de,0ed29h		;6223   ; ...el rotulo de 0x933F (14 x 12) en la fila 1...
	ld hl,0933fh		;6226
	ld bc,00c0eh		;6229
	call copia_filas		;622c   ; copia_filas: B filas de C bytes de HL a DE, en filas de 32
	ld de,07d51h		;622f   ; ...y la lista de 0x7D51
	call 05c25h		;6232   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	xor a			;6235   ; los pasos del titulo a 0
	ld (0f01fh),a		;6236   ; guarda el paso del titulo
	ld (0f020h),a		;6239
	ld (0f031h),a		;623c
	inc a			;623f
	ld (0e019h),a		;6240   ; guarda en juego (a 0 se acaba la vida: estado 6)
	ld a,030h		;6243   ; 0x30 cuadros antes de empezar
	ld (0f02bh),a		;6245
titulo_a_vram:		; la mitad de arriba y los sprites a la VRAM
	ld bc,001a0h		;6248   ; la mitad de arriba de la pantalla y los sprites a la VRAM
	call 054f6h		;624b   ; nombres_a_vram_bc: BC bytes de 0xED00 a 0x3800
	jp 05474h		;624e   ; sprites_a_vram: la copia de la tabla de sprites (0xEC80) a 0x3B00
cuadro_del_titulo:		; un cuadro de la animacion del titulo
	call titulo_a_vram		;6251   ; cada cuadro del titulo
	ld a,(0f031h)		;6254
	or a			;6257
	jp z,L_62DA		;6258
	ld a,(0f01fh)		;625b   ; el paso 0xF01F (tabla que sigue)
	call 04140h		;625e   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld hl,0ec99h		;6267   ; el sprite baja de 2 en 2...
	inc (hl)			;626a
	inc (hl)			;626b
	ld a,(hl)			;626c
	cp 06eh		;626d   ; ...en las y 0x6E, 0x7C y 0x8A cambia de dibujo...
	jr z,L_6286		;626f
	cp 07ch		;6271
	jr z,L_6286		;6273
	cp 08ah		;6275
	jr z,L_6286		;6277
	cp 098h		;6279   ; ...y en la 0x98 se esconde: paso siguiente
	ret nz			;627b
	ld a,0e0h		;627c
	ld (0ec98h),a		;627e
L_6281:
	ld hl,0f01fh		;6281   ; apunta a el paso del titulo
	inc (hl)			;6284
	ret			;6285
L_6286:
	ld hl,0ec9ah		;6286   ; el dibujo siguiente (+4)
	ld a,(hl)			;6289
	add a,004h		;628a
	ld (hl),a			;628c
	ret			;628d
L_628E:
	ld hl,0f02ch		;628e   ; cuenta 0xF02C; a 0 acaba el titulo (0xE019 = 0)
	dec (hl)			;6291
	ret nz			;6292
	xor a			;6293
	ld (0e019h),a		;6294   ; guarda en juego (a 0 se acaba la vida: estado 6)
	ret			;6297
L_6298:
	ld a,(0e003h)		;6298   ; cada 16 cuadros, el paso siguiente de 0xF020
	and 00fh		;629b
	ret nz			;629d
	ld hl,0f020h		;629e
	inc (hl)			;62a1
	ld a,(hl)			;62a2
	dec a			;62a3
	call 04140h		;62a4   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld hl,093f7h		;62b1   ; 8 bytes de sprites de 0x93F7...
L_62B4:
	ld de,0ec98h		;62b4   ; ...a la copia de la tabla de sprites
	ld bc,00008h		;62b7
	ldir		;62ba
	ret			;62bc
L_62BD:
	ld hl,093ffh		;62bd   ; o los de 0x93FF
	jr L_62B4		;62c0
L_62C2:
	ld hl,0ec98h		;62c2   ; los dos sprites escondidos (y = 0xE0)...
	ld b,002h		;62c5
	ld a,0e0h		;62c7
L_62C9:
	ld (hl),a			;62c9
	inc hl			;62ca
	inc hl			;62cb
	inc hl			;62cc
	inc hl			;62cd
	djnz L_62C9		;62ce
	call titulo_a_vram		;62d0   ; titulo_a_vram: la mitad de arriba y los sprites a la VRAM
	ld a,078h		;62d3   ; ...y 0x78 cuadros
	ld (0f02ch),a		;62d5
	jr $-87		;62d8
L_62DA:
	ld hl,0f02bh		;62da   ; espera 0xF02B cuadros...
	dec (hl)			;62dd
	ret nz			;62de
	ld hl,09407h		;62df   ; ...y el sprite de 0x9407
	ld de,0ec98h		;62e2
	ld bc,00004h		;62e5
	ldir		;62e8
	ld hl,0f031h		;62ea
	inc (hl)			;62ed
	ret			;62ee
cosas_del_castillo:		; 0xE6A0 a 0 y lo de la sala del castillo (tabla 0xB8A2)
	xor a			;62ef   ; 0xE6A0 a 0; solo en el castillo
	ld (0e6a0h),a		;62f0   ; guarda el numero en la lista de la sala
	ld bc,(0e041h)		;62f3   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	dec c			;62f7
	ret nz			;62f8
	ld hl,0b8a2h		;62f9   ; la lista de la sala en 0xB8A2 (listas acabadas en 0, una por sala)
	ld a,b			;62fc
	dec a			;62fd
	jr z,L_6309		;62fe
	ld b,a			;6300
L_6301:
	ld a,(hl)			;6301   ; hasta el 0 de la lista...
	inc hl			;6302
	or a			;6303
	jr nz,L_6301		;6304
	dec b			;6306   ; ...una por sala anterior
	jr nz,L_6301		;6307
L_6309:
	ld a,(hl)			;6309   ; cada entrada...
	or a			;630a
	ret z			;630b
	inc hl			;630c
	call marca_de_la_lista		;630d   ; ...si su bit en las marcas de la sala esta puesto, no sale
	jr nz,L_6309		;6310
	dec hl			;6312
	ld a,(hl)			;6313   ; [y:3 x:5]: y en los 3 bits altos (+8)...
	and 0e0h		;6314
	or 008h		;6316
	ld e,a			;6318
	ld a,(hl)			;6319   ; ...x en los 5 bajos (x 8)
	and 01fh		;631a
	rlca			;631c
	rlca			;631d
	rlca			;631e
	ld d,a			;631f
	ld (0f002h),de		;6320
	push hl			;6324
	call hueco_ec30		;6325   ; a un hueco de 0xEC30
	pop hl			;6328
	inc hl			;6329
	jr L_6309		;632a
hueco_ec30:		; pone en el primer hueco libre de 0xEC30 lo de la y, x de 0xF002
	ld hl,0ec30h		;632c   ; tres huecos de 8 bytes en 0xEC30: el primero libre
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
	ld (hl),001h		;633c   ; [1][0][y][x]...
	inc l			;633e
	ld (hl),000h		;633f
	inc l			;6341
	ld de,(0f002h)		;6342
	ld (hl),e			;6346
	inc l			;6347
	ld (hl),d			;6348
	push hl			;6349
	ex de,hl			;634a
	call 04da1h		;634b   ; ...[casilla de la copia de nombres]...
	ex de,hl			;634e
	pop hl			;634f
	inc l			;6350
	ld (hl),e			;6351
	inc l			;6352
	ld (hl),d			;6353
	inc l			;6354
	ld (hl),00fh		;6355   ; ...[0x0F][numero en la lista]
	inc l			;6357
	ld a,(0e6a0h)		;6358   ; lee el numero en la lista de la sala
	ld (hl),a			;635b
	ret			;635c
marca_de_la_lista:		; NZ si la entrada siguiente de la lista ya esta en las marcas de la sala
	exx			;635d   ; el numero siguiente (0xE6A0)...
	ld hl,0e6a0h		;635e   ; apunta a el numero en la lista de la sala
	inc (hl)			;6361
	ld a,(hl)			;6362
	add a,005h		;6363   ; ...su bit (numero + 5) en las marcas de la sala
	ld b,a			;6365
	xor a			;6366
	scf			;6367
L_6368:
	rla			;6368
	djnz L_6368		;6369
	ld hl,(0e60eh)		;636b   ; lee la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	and (hl)			;636e
	exx			;636f
	ret			;6370
cuenta_huecos_ec30:		; los tres huecos de 0xEC30: cuentan y se vacian
	ld ix,0ec30h		;6371   ; los tres huecos de 0xEC30
	exx			;6375
	ld b,003h		;6376
	ld de,00008h		;6378
L_637B:
	exx			;637b
	call cuenta_hueco_ec30		;637c   ; cuenta_hueco_ec30: el hueco IX cuenta su byte 6; a 0 se vacia
	exx			;637f
	add ix,de		;6380
	djnz L_637B		;6382
	ret			;6384
cuenta_hueco_ec30:		; el hueco IX cuenta su byte 6; a 0 se vacia
	ld a,(ix+000h)		;6385   ; los que estan en marcha (byte 1)...
	or a			;6388
	ret z			;6389
	ld a,(ix+001h)		;638a
	or a			;638d
	ret z			;638e
	dec (ix+006h)		;638f   ; ...cuentan el byte 6; a 0 se vacian
	ret nz			;6392
	ld (ix+000h),000h		;6393
	ret			;6397
objeto_21:		; con el objeto 0x21 y el boton A, p15:B85C con cada hueco de 0xEC30
	ld a,(0e090h)		;6398   ; con el objeto 0x21...
	or a			;639b
	ret z			;639c
	ld a,(0e008h)		;639d   ; ...el boton A...
	and 010h		;63a0
	ret z			;63a2
	ld hl,0e632h		;63a3   ; ...una sola vez (0xE632)...
	ld a,(hl)			;63a6
	or a			;63a7
	ret nz			;63a8
	ld (hl),001h		;63a9
	ld ix,0ec30h		;63ab   ; ...llama a p15:B85C con cada hueco de 0xEC30 en uso
	ld b,003h		;63af
	ld de,00008h		;63b1
L_63B4:
	ld a,(ix+000h)		;63b4
	or a			;63b7
	jr z,L_63BD		;63b8
	call 0b85ch		;63ba   ; rompe_tinaja: la tinaja se rompe y queda rota en las marcas de la sala
L_63BD:
	add ix,de		;63bd
	djnz L_63B4		;63bf
	ret			;63c1
figuras_de_sala_en_sala:		; las seis figuras de 0xE4A0 (tablas 0xBB24, 0xBB54)
	ld ix,0e4a0h		;63c2   ; las seis figuras de 0xE4A0 que van de sala en sala: tablas 0xBB24 y 0xBB54
	ld hl,0bb24h		;63c6
	exx			;63c9
	ld hl,0bb54h		;63ca
	ld b,006h		;63cd
L_63CF:
	ld a,(hl)			;63cf   ; la sala de partida...
	inc hl			;63d0
	ex af,af'			;63d1
	ld a,b			;63d2
	exx			;63d3
	ld b,000h		;63d4
	ld e,a			;63d6
	ex af,af'			;63d7
	ld c,080h		;63d8   ; ...con C = 0x80
	push hl			;63da
	call pon_figura_movil		;63db   ; pon_figura_movil: rellena la ficha de IX
	pop hl			;63de
	ld de,00008h		;63df
	add ix,de		;63e2
	add hl,de			;63e4
	exx			;63e5
	djnz L_63CF		;63e6
	exx			;63e8
	ret			;63e9
figura_ec20:		; en el castillo, la figura de la tabla 0xBA53 en 0xEC20
	ld hl,(0e041h)		;63ea   ; en el castillo, la sala en la tabla 0xBA53 (15 de [sala][ficha])...
	dec l			;63ed
	ret nz			;63ee
	ld c,000h		;63ef
	ld ix,0ec20h		;63f1   ; apunta a la figura que sube y baja del castillo
	ld a,h			;63f5
	ld hl,0ba53h		;63f6
	ld b,00fh		;63f9
L_63FB:
	cp (hl)			;63fb   ; la sala de la tabla?
	jr z,L_6404		;63fc
	inc hl			;63fe   ; no: la entrada siguiente (3 bytes)
	inc hl			;63ff
	inc hl			;6400
	djnz L_63FB		;6401
	ret			;6403
L_6404:
	inc hl			;6404   ; ...su ficha en 0xEC20
	ld e,(hl)			;6405
	inc hl			;6406
	ld d,(hl)			;6407
	ex de,hl			;6408
	ld e,001h		;6409
pon_figura_movil:		; rellena la ficha de IX
	ld (ix+000h),e		;640b   ; [E][sala][C][B][0][y][0][x]...
	ld (ix+001h),a		;640e   ; la sala
	ld (ix+002h),c		;6411   ; las banderas (C)
	ld (ix+003h),b		;6414   ; B
	xor a			;6417   ; la y: fraccion 0...
	ld (ix+004h),a		;6418
	ld d,(hl)			;641b   ; ...y la de la tabla
	inc hl			;641c
	ld (ix+005h),d		;641d
	ld (ix+006h),a		;6420   ; la x: fraccion 0...
	ld d,(hl)			;6423   ; ...y la de la tabla
	inc hl			;6424
	ld (ix+007h),d		;6425
	ld de,00008h		;6428   ; la segunda mitad de la ficha (+8)...
	add ix,de		;642b
	push ix		;642d   ; ...y 6 bytes de la ficha detras
	pop de			;642f
	ldi		;6430   ; ...la velocidad (2 bytes)...
	ldi		;6432
	inc de			;6434   ; ...y los topes (4 bytes, desde +0x0C)
	inc de			;6435
	ld bc,00004h		;6436
	ldir		;6439
	ret			;643b
mueve_de_sala_en_sala:		; mueve las seis de 0xE4A0 y copia en 0xEC10 la de esta sala
	ld ix,0e4a0h		;643c   ; mueve las seis de 0xE4A0
	exx			;6440
	ld b,006h		;6441
	ld de,00010h		;6443
L_6446:
	exx			;6446
	call mueve_una		;6447   ; mueve_una: mueve una de 0xE4A0 y la cambia de sala por arriba o por abajo
	exx			;644a
	add ix,de		;644b
	djnz L_6446		;644d
	exx			;644f
	ld a,(0e041h)		;6450   ; en el castillo, la que esta en esta sala...
	dec a			;6453
	ret nz			;6454
	ld hl,0e4a1h		;6455
	ld b,006h		;6458
	ld de,00010h		;645a
L_645D:
	ld a,(0e042h)		;645d   ; lee la sala
	cp (hl)			;6460
	jr z,L_6470		;6461
	add hl,de			;6463
	djnz L_645D		;6464
	xor a			;6466   ; ...ninguna: 0xEC10 a 0 y su sprite escondido
	ld (0ec10h),a		;6467   ; guarda la figura de sala en sala que esta en esta sala
	ld a,0e0h		;646a
	ld (0ec15h),a		;646c
	ret			;646f
L_6470:
	dec hl			;6470   ; ...se copia en 0xEC10
	ld de,0ec10h		;6471   ; apunta a la figura de sala en sala que esta en esta sala
	ld bc,00010h		;6474
	ldir		;6477
	ret			;6479
mueve_una:		; mueve una de 0xE4A0 y la cambia de sala por arriba o por abajo
	call mueve_y		;647a   ; la mueve (p01:64EE)
	res 2,(ix+002h)		;647d
	bit 1,(ix+002h)		;6481   ; subiendo (bit 1)...
	jr z,L_64A2		;6485
	ld a,(0e52dh)		;6487   ; ...si lleva al personaje (0xE52D)...
	cp (ix+000h)		;648a
	jr nz,L_6495		;648d
	ld a,(0e52ch)		;648f   ; lee la figura que lo lleva al salir de la sala
	dec a			;6492
	jr z,L_649B		;6493
L_6495:
	ld a,(ix+005h)		;6495   ; ...al pasar por arriba de la pantalla (y < 0x28)...
	cp 028h		;6498
	ret nc			;649a
L_649B:
	dec (ix+003h)		;649b   ; ...a la sala de encima, por abajo (y = 0xB9)
	ld c,0b9h		;649e
	jr L_64AD		;64a0
L_64A2:
	ld a,(ix+005h)		;64a2   ; bajando, al pasar por abajo (y >= 0xC0)...
	cp 0c0h		;64a5
	ret c			;64a7
	inc (ix+003h)		;64a8   ; ...a la de debajo, por arriba (y = 0x28)
	ld c,028h		;64ab
L_64AD:
	ld a,(ix+000h)		;64ad   ; la sala nueva: lista de 0xBA80 de la figura
	dec a			;64b0
	ld hl,0ba80h		;64b1
	call 0414ch		;64b4   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
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
	ld a,(0ec10h)		;64cd   ; si es la que se ve en esta sala...
	cp (ix+000h)		;64d0
	ret nz			;64d3
	ld a,(0e52dh)		;64d4   ; ...y lleva al personaje, lo suelta (0xE52B, 0xE52D)
	cp (ix+000h)		;64d7
	jr nz,L_64E3		;64da
	xor a			;64dc
	ld (0e52bh),a		;64dd
	ld (0e52dh),a		;64e0   ; guarda la figura que lleva al personaje
L_64E3:
	ld a,(0ec12h)		;64e3   ; con el bit 0 de 0xEC12, el bit 2
	bit 0,a		;64e6
	ret z			;64e8
	set 2,(ix+002h)		;64e9
	ret			;64ed
mueve_y:		; la y mas la velocidad y la vuelta en sus topes
	ld l,(ix+004h)		;64ee   ; la y (16 bits) mas la velocidad...
	ld h,(ix+005h)		;64f1
	ld e,(ix+008h)		;64f4
	ld d,(ix+009h)		;64f7
	add hl,de			;64fa
	ld (ix+004h),l		;64fb
	ld (ix+005h),h		;64fe
	bit 1,(ix+002h)		;6501   ; ...subiendo: hasta la sala y la y de arriba (bytes 0x0C-0x0D)...
	ld a,(ix+001h)		;6505
	jr z,L_6516		;6508
	cp (ix+00ch)		;650a
	ret nz			;650d
	ld a,h			;650e
	inc a			;650f
	cp (ix+00dh)		;6510
	ret nc			;6513
	jr da_la_vuelta		;6514
L_6516:
	cp (ix+00eh)		;6516   ; ...bajando: hasta las de abajo (0x0E-0x0F)
	ret nz			;6519
	ld a,h			;651a
	cp (ix+00fh)		;651b
	ret c			;651e
da_la_vuelta:		; la velocidad negada y el bit 1 cambiado
	call 0415ch		;651f   ; y da la vuelta: velocidad negada...
	ld (ix+008h),e		;6522
	ld (ix+009h),d		;6525
	ld a,(ix+002h)		;6528   ; ...y el bit 1 cambiado
	xor 002h		;652b
	ld (ix+002h),a		;652d
	ret			;6530
mueve_ec20:		; la figura de 0xEC20 sube y baja entre sus topes
	ld ix,0ec20h		;6531   ; la figura de 0xEC20: la y mas la velocidad...
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
	ld (0ec2ah),hl		;654f   ; ...lo que se ha movido en 0xEC2A
	ex de,hl			;6552
	ld e,c			;6553
	ld d,b			;6554
	bit 1,(ix+002h)		;6555   ; subiendo, hasta 0xEC2D...
	jr z,L_6562		;6559
	ld a,(0ec2dh)		;655b
	cp h			;655e
	ret c			;655f
	jr L_6568		;6560
L_6562:
	ld a,(0ec2fh)		;6562   ; ...bajando, hasta 0xEC2F
	dec a			;6565
	cp h			;6566
	ret nc			;6567
L_6568:
	ld (0ec2ah),a		;6568
	jp da_la_vuelta		;656b   ; da_la_vuelta: la velocidad negada y el bit 1 cambiado
huecos_de_la_sala:		; 0xE614 y cuantos huecos de figura (tablas 0xBA2E, 0xBA28)
	xor a			;656e   ; 0xE614 a 0 y 16 + 17 huecos de figura
	ld (0e614h),a		;656f   ; guarda el tipo de sala del castillo (tabla 0xBA2E)
	ld hl,01110h		;6572
	ld (0e635h),hl		;6575   ; guarda cuantos huecos de figura hay y el byte siguiente (16 bits)
	ld de,(0e041h)		;6578   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	dec e			;657c   ; en el castillo...
	ret nz			;657d
	ld c,d			;657e   ; ...dos bits por sala en 0xBA2E...
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
	and 003h		;6594   ; ...0 y 3: nada
	ret z			;6596
	cp 003h		;6597
	ret z			;6599
	ld (0e614h),a		;659a   ; 1 o 2: en 0xE614, y los huecos de la tabla 0xBA28
	ld hl,0ba28h		;659d
	call 0414ch		;65a0   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld (0e635h),de		;65a3   ; guarda cuantos huecos de figura hay y el byte siguiente (16 bits)
	ret			;65a7
pantalla_de_objetos:		; monta la pantalla de objetos (estado 0x0B)
	call 0422bh		;65a8   ; con el banco 9
	call borra_pantalla_de_sala		;65ab   ; borra_pantalla_de_sala: la pantalla de la sala en la copia a cero
	call 05280h		;65ae   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call vidas_mas_una		;65b1   ; vidas_mas_una: sin pendiente negativo, una vida mas, 0xE04C-0xE04E y el arma
	call personajes_de_objetos		;65b4   ; personajes_de_objetos: los dibujos de Afrodita y Popolon (con o sin vidas)
	call objetos_que_se_tienen		;65b7   ; objetos_que_se_tienen: los objetos 0x0D-0x2A y 0x07-0x0A que se tienen
	call armas_que_se_tienen		;65ba   ; armas_que_se_tienen: las armas 0x01-0x06 que se tienen y su marco
	call mapa_del_mundo		;65bd   ; mapa_del_mundo: mapa = 0xE688 + 1, sala 1
	call 054bfh		;65c0   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	jp 04215h		;65c3   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
vidas_mas_una:		; sin pendiente negativo, una vida mas, 0xE04C-0xE04E y el arma
	ld a,(0e501h)		;65c6   ; el pendiente de vida del que juega...
	or a			;65c9
	ld hl,0e05eh		;65ca   ; apunta a el cambio de vida pendiente de Afrodita (con signo)
	jr z,L_65D1		;65cd
	ld l,061h		;65cf
L_65D1:
	ld a,(hl)			;65d1   ; ...si es negativo, a 0
	or a			;65d2
	jp p,L_65D8		;65d3
	ld (hl),000h		;65d6
L_65D8:
	ld a,(0e501h)		;65d8   ; las vidas del que juega + 1 (BCD)
	ld hl,0e058h		;65db   ; apunta a las vidas de Afrodita (BCD)
	add a,l			;65de
	ld l,a			;65df
	ld a,(hl)			;65e0
	add a,001h		;65e1
	daa			;65e3
	ld (hl),a			;65e4
	ld hl,0e04ch		;65e5   ; 0xE04C = 0, 0xE04D = quien juega, 0xE04E = el arma
	ld (hl),000h		;65e8
	ld a,(0e501h)		;65ea   ; lee quien juega (0 Afrodita)
	inc l			;65ed
	ld (hl),a			;65ee
	ld a,(0e510h)		;65ef   ; lee el arma elegida
	inc l			;65f2
	ld (hl),a			;65f3
	or a			;65f4   ; sin arma, la primera de 1-6 que se tenga
	ret nz			;65f5
	ld c,001h		;65f6
	ld b,006h		;65f8
	ld de,0e070h		;65fa   ; apunta a tiene el objeto 0x01
L_65FD:
	ld a,(de)			;65fd   ; la primera arma que se tenga...
	or a			;65fe
	jr nz,L_6607		;65ff
	inc c			;6601
	inc e			;6602
	djnz L_65FD		;6603
	ld c,000h		;6605   ; ...o ninguna
L_6607:
	ld (hl),c			;6607   ; sin ninguna, 0
	ld a,c			;6608
	ld (0e510h),a		;6609   ; guarda el arma elegida
	ret			;660c
borra_pantalla_de_sala:		; la pantalla de la sala en la copia a cero
	ld hl,0ed80h		;660d   ; la pantalla de la sala en la copia, a cero
	ld de,0ed81h		;6610
	ld bc,0027fh		;6613
	ld (hl),000h		;6616
	ldir		;6618
	ret			;661a
mapa_del_mundo:		; con el objeto 0x0A, el mapa del mundo (0xAF2A) y sus marcas
	ld a,(0e079h)		;661b   ; con el objeto 0x0A del mundo...
	or a			;661e
	ret z			;661f
	ld de,0ef26h		;6620   ; ...el rotulo de 0x66BF...
	ld hl,066bfh		;6623
	ld bc,00003h		;6626
	ldir		;6629
	ld hl,0af2ah		;662b   ; ...y el mapa del mundo: tabla 0xAF2A...
	ld a,(0e041h)		;662e   ; lee el mapa (1 el castillo, 2-11 los mundos)
	dec a			;6631
	ret z			;6632
	call 0414ch		;6633   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;6636
	ld e,(hl)			;6637   ; ...[destino][ancho][alto] y las filas
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
	ld de,(0f000h)		;664a   ; una fila del mapa...
	ld a,(0f002h)		;664e   ; el ancho...
	ld c,a			;6651
	ld b,000h		;6652
	ld hl,(0f004h)		;6654   ; ...los caracteres de la fila...
	ldir		;6657
	ld (0f004h),hl		;6659   ; ...y sigue la tabla
	ld hl,(0f000h)		;665c   ; ...y a la siguiente
	ld bc,00020h		;665f   ; la fila siguiente de la pantalla
	add hl,bc			;6662
	ld (0f000h),hl		;6663
	ld hl,0f003h		;6666   ; cuantas filas
	dec (hl)			;6669
	jr nz,L_664A		;666a
	ld a,(0e041h)		;666c   ; el sitio de la sala en el mapa: tabla 0xB038...
	ld hl,0b038h		;666f
	call 0414ch		;6672   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;6675
	ld a,(0e042h)		;6676   ; la sala...
	ld e,a			;6679
	ld d,000h		;667a
	add hl,de			;667c   ; ...su byte en la tabla
	ex de,hl			;667d
	ld a,(0e041h)		;667e   ; lee el mapa (1 el castillo, 2-11 los mundos)
	dec a			;6681
	ld hl,0e670h		;6682   ; apunta a los sprites de las marcas del mapa
	ld a,(de)			;6685   ; ...a 0xF020
	ld (0f020h),a		;6686   ; el sitio, en 0xF020
	ret z			;6689   ; en el castillo nada mas
	ld c,008h		;668a   ; su marca: los sprites de 0xE670
	call marca_del_mapa		;668c   ; marca_del_mapa: el sprite de marca en el sitio de 0xF020
	ld a,(0e089h)		;668f   ; con el objeto 0x1A, otra marca: el sitio de 0xB0FC del mapa, en 0xE674
	and a			;6692
	ret z			;6693
	ld a,(0e041h)		;6694   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,0b0fch		;6697
	call 04155h		;669a   ; byte_de_tabla: A = el byte HL + A
	ld (0f020h),a		;669d   ; el sitio de la marca 2
	ld hl,0e674h		;66a0
	ld c,005h		;66a3   ; color 5
marca_del_mapa:		; el sprite de marca en el sitio de 0xF020
	and 0f0h		;66a5   ; la y del sprite: nibble alto x 4 + 0x90...
	rrca			;66a7
	rrca			;66a8
	and 03ch		;66a9
	add a,090h		;66ab
	ld (hl),a			;66ad
	ld a,(0f020h)		;66ae   ; ...la x: nibble bajo x 8 + 1...
	rla			;66b1
	rla			;66b2
	rla			;66b3
	and 078h		;66b4
	inc a			;66b6
	inc l			;66b7
	ld (hl),a			;66b8
	inc l			;66b9   ; ...el dibujo 0xA4 y el color C
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


personajes_de_objetos:		; los dibujos de Afrodita y Popolon (con o sin vidas)
	ld hl,0e058h		;66c2   ; los dos personajes: Afrodita...
	ld c,000h		;66c5
	call personaje_de_objetos		;66c7   ; personaje_de_objetos: un dibujo de 2 x 2 de la tabla 0x66F7
	ld hl,0e059h		;66ca   ; ...y Popolon
	ld c,002h		;66cd
	call personaje_de_objetos		;66cf   ; personaje_de_objetos: un dibujo de 2 x 2 de la tabla 0x66F7
	jp mano_del_personaje		;66d2   ; mano_del_personaje: la mano que señala al personaje
personaje_de_objetos:		; un dibujo de 2 x 2 de la tabla 0x66F7
	ld a,(hl)			;66d5   ; con vidas o sin ellas (+1)...
	or a			;66d6
	jr z,L_66DA		;66d7
	inc c			;66d9
L_66DA:
	ld a,c			;66da   ; ...su dibujo de 2 x 2 de la tabla 0x66F7
	add a,a			;66db   ; 6 bytes por dibujo...
	ld c,a			;66dc
	add a,a			;66dd
	add a,c			;66de
	ld c,a			;66df
	ld b,000h		;66e0
	ld hl,066f7h		;66e2   ; ...en 0x66F7: [casilla]...
	add hl,bc			;66e5
	ld e,(hl)			;66e6
	inc hl			;66e7
	ld d,(hl)			;66e8
	inc hl			;66e9
	ldi		;66ea   ; ...[2 caracteres arriba]...
	ldi		;66ec
	ld a,01eh		;66ee
	add a,e			;66f0
	ld e,a			;66f1
	ldi		;66f2   ; ...[2 abajo]
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


objetos_que_se_tienen:		; los objetos 0x0D-0x2A y 0x07-0x0A que se tienen
	ld de,0ee2eh		;6715   ; la pantalla de objetos: el rotulo de 0x6776...
	ld hl,06776h		;6718
	ld bc,00004h		;671b
	ldir		;671e
	ld hl,0ee46h		;6720   ; ...los objetos 0x0D-0x2A, tres filas de diez...
	exx			;6723
	ld de,0e07ch		;6724   ; apunta a tiene el objeto 0x0D
	ld bc,0030ah		;6727
	ld l,081h		;672a
	exx			;672c
	call fila_de_objetos		;672d   ; fila_de_objetos: las filas de objetos de 2 x 2
	ld hl,0ef4fh		;6730   ; ...y los 0x07-0x0A, una de seis
	exx			;6733
	ld de,0e076h		;6734   ; apunta a tiene el objeto 0x07
	ld bc,00106h		;6737
	ld l,056h		;673a
	exx			;673c
fila_de_objetos:		; las filas de objetos de 2 x 2
	call objeto_si_se_tiene		;673d   ; el objeto: si se tiene, 2 x 2 caracteres...
	ld bc,00002h		;6740
	jr nc,L_6748		;6743
	ld bc,0ffe1h		;6745   ; ...y la casilla siguiente
L_6748:
	add hl,bc			;6748   ; la casilla siguiente
	exx			;6749
	dec c			;674a   ; C por fila
	exx			;674b
	jr nz,fila_de_objetos		;674c
	ld bc,0002ch		;674e   ; la fila siguiente (2 filas mas abajo)
	add hl,bc			;6751
	exx			;6752
	ld c,00ah		;6753   ; 10 por fila
	dec b			;6755   ; B filas
	exx			;6756
	jr nz,fila_de_objetos		;6757
	ret			;6759
objeto_si_se_tiene:		; C y sus 2 x 2 caracteres si se tiene el objeto
	exx			;675a   ; los caracteres del objeto, de 4 en 4 desde L...
	ld a,l			;675b
	add a,004h		;675c
	ld l,a			;675e
	ld a,(de)			;675f   ; ...si se tiene
	inc de			;6760
	exx			;6761
	or a			;6762
	ret z			;6763
	exx			;6764
	ld a,l			;6765
	exx			;6766
	ld (hl),a			;6767   ; 2 x 2
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


armas_que_se_tienen:		; las armas 0x01-0x06 que se tienen y su marco
	ld hl,0efaeh		;677a   ; las armas 0x01-0x06...
	exx			;677d
	ld de,0e070h		;677e   ; apunta a tiene el objeto 0x01
	ld c,006h		;6781
	exx			;6783
L_6784:
	push hl			;6784   ; ...las que se tengan...
	call arma_si_se_tiene		;6785   ; arma_si_se_tiene: C y sus dos caracteres si se tiene el arma
	pop hl			;6788
	exx			;6789
	ld a,c			;678a
	exx			;678b
	sub 003h		;678c   ; ...separadas 3 casillas (2 en medio)
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
	ld hl,0ef8dh		;679c   ; el marco de las armas: dos filas de 0x40 entre 0x42/0x48 y 0x43/0x49
	ld de,04248h		;679f
	call fila_de_marco		;67a2   ; fila_de_marco: D, 15 x 0x40 y E
	ld hl,0efcdh		;67a5
	ld de,04349h		;67a8
	call fila_de_marco		;67ab   ; fila_de_marco: D, 15 x 0x40 y E
	ld a,041h		;67ae   ; y sus esquinas (0x41)
	ld (0efadh),a		;67b0
	ld (0efbdh),a		;67b3
	jp mano_del_arma		;67b6   ; mano_del_arma: la mano que señala el arma
arma_si_se_tiene:		; C y sus dos caracteres si se tiene el arma
	exx			;67b9   ; el arma: sus dos caracteres de 0x5F6B
	ld a,(de)			;67ba   ; el arma siguiente...
	inc de			;67bb
	exx			;67bc
	or a			;67bd   ; ...si se tiene...
	ret z			;67be
	exx			;67bf
	ld a,c			;67c0   ; ...su numero (7 - lo que queda)...
	exx			;67c1
	sub 007h		;67c2
	neg		;67c4
	ex de,hl			;67c6
	ld hl,05f6bh		;67c7   ; ...sus dos caracteres de 0x5F6B...
	add a,a			;67ca
	ld c,a			;67cb
	ld b,000h		;67cc
	add hl,bc			;67ce
	ldi		;67cf   ; ...a la pantalla
	ldi		;67d1
	ex de,hl			;67d3
	scf			;67d4   ; C: se tiene
	ret			;67d5
fila_de_marco:		; D, 15 x 0x40 y E
	ld (hl),d			;67d6   ; D, 15 x 0x40 y E
	inc l			;67d7
	ld a,040h		;67d8
	ld b,00fh		;67da
L_67DC:
	ld (hl),a			;67dc
	inc l			;67dd
	djnz L_67DC		;67de
	ld (hl),e			;67e0
	ret			;67e1
cuadro_de_objetos:		; un cuadro de la pantalla de objetos
	call 0422bh		;67e2   ; cada cuadro de la pantalla de objetos
	call 054bfh		;67e5   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	call 04c68h		;67e8   ; lee_el_mando: el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	call elige_en_objetos		;67eb   ; elige_en_objetos: fila, arma o personaje con el mando
	call sprites_de_objetos		;67ee   ; sprites_de_objetos: las marcas y las manos de la pantalla de objetos
	jp 04215h		;67f1   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
elige_en_objetos:		; fila, arma o personaje con el mando
	ld a,(0e008h)		;67f4   ; arriba o abajo: de fila (personaje o arma)
	and 003h		;67f7
	call nz,cambia_de_fila		;67f9   ; cambia_de_fila: de la fila del personaje a la de armas y vuelta
	ld a,(0e04ch)		;67fc   ; en la fila de las armas...
	or a			;67ff
	jr z,L_683D		;6800
	ld a,(0e04eh)		;6802   ; lee el arma elegida en la pantalla de objetos
	or a			;6805
	ret z			;6806
	ld hl,0e04eh		;6807   ; ...izquierda o derecha...
	ld a,(0e008h)		;680a   ; lee lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and 00ch		;680d
	ret z			;680f
	bit 3,a		;6810   ; ...a la derecha (bit 3)...
	jr nz,L_6829		;6812
L_6814:
	dec (hl)			;6814   ; ...a la izquierda: la anterior que se tenga (de 6 vuelve a dar la vuelta)
	jr nz,L_6819		;6815
	ld (hl),006h		;6817
L_6819:
	ld a,(hl)			;6819   ; la anterior...
	ld de,0e06fh		;681a
	add a,e			;681d
	ld e,a			;681e
	ld a,(de)			;681f   ; ...si no se tiene, otra
	or a			;6820
	jr z,L_6814		;6821
L_6823:
	ld a,(hl)			;6823   ; el arma elegida
	ld (0e510h),a		;6824   ; guarda el arma elegida
	jr L_686A		;6827
L_6829:
	inc (hl)			;6829   ; a la derecha: la siguiente que se tenga
	ld a,(hl)			;682a
	cp 007h		;682b
	jr c,L_6831		;682d
	ld (hl),001h		;682f
L_6831:
	ld a,(hl)			;6831   ; el arma de HL...
	ld de,0e06fh		;6832
	add a,e			;6835
	ld e,a			;6836
	ld a,(de)			;6837   ; ...si no se tiene, la siguiente
	or a			;6838
	jr z,L_6829		;6839
	jr L_6823		;683b
L_683D:
	ld a,(0e041h)		;683d   ; en la fila del personaje: en el mapa 6 hace falta el objeto 0x23...
	cp 006h		;6840
	jr nz,L_684B		;6842
	ld a,(0e092h)		;6844   ; lee tiene el objeto 0x23
	or a			;6847
	ret z			;6848
	jr L_6854		;6849
L_684B:
	cp 008h		;684b   ; ...y en el mapa 8 el 0x0D
	jr nz,L_6854		;684d
	ld a,(0e07ch)		;684f   ; lee tiene el objeto 0x0D
	or a			;6852
	ret z			;6853
L_6854:
	ld a,(0e008h)		;6854   ; izquierda o derecha...
	and 00ch		;6857
	ret z			;6859
	ld hl,0e04dh		;685a   ; ...el otro personaje...
	ld a,(hl)			;685d
	xor 001h		;685e
	ld c,a			;6860
	ld de,0e058h		;6861   ; apunta a las vidas de Afrodita (BCD)
	add a,e			;6864
	ld e,a			;6865
	ld a,(de)			;6866   ; ...si le quedan vidas
	or a			;6867
	ret z			;6868
	ld (hl),c			;6869
L_686A:
	ld a,02ch		;686a   ; el sonido 0x2C
	jp 04e1fh		;686c   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
cambia_de_fila:		; de la fila del personaje a la de armas y vuelta
	ld hl,0e04ch		;686f   ; cambia de fila (0xE04C)...
	ld a,(hl)			;6872
	xor 001h		;6873
	ld c,a			;6875
	jr nz,L_687B		;6876
	ld (hl),a			;6878
	jr L_686A		;6879
L_687B:
	inc l			;687b   ; ...a la de armas solo si hay alguna
	inc l			;687c
	ld a,(hl)			;687d
	or a			;687e
	ret z			;687f
	dec l			;6880
	dec l			;6881
	ld (hl),c			;6882
	jr L_686A		;6883
sprites_de_objetos:		; las marcas y las manos de la pantalla de objetos
	call marcas_del_mapa		;6885   ; los sprites de la pantalla de objetos
	call pinta_arma		;6888   ; pinta_arma: el arma elegida (0xE510) en la fila 1, columna 28
	call mano_del_arma		;688b   ; mano_del_arma: la mano que señala el arma
mano_del_personaje:		; la mano que señala al personaje
	ld a,(0e04dh)		;688e   ; la mano que señala: en Afrodita (0x91) o en Popolon (0x61)...
	or a			;6891
	ld a,091h		;6892
	jr z,L_6898		;6894
	ld a,061h		;6896
L_6898:
	ld b,a			;6898
	ld de,0ec80h		;6899   ; apunta a la copia de la tabla de sprites (128 bytes)
	ld a,(0e04ch)		;689c   ; ...parpadea si su fila esta elegida
	or a			;689f
	jr nz,L_68AA		;68a0
	ld a,(0e003h)		;68a2   ; lee el contador de cuadros
	bit 3,a		;68a5
	jp z,sprite_escondido		;68a7   ; sprite_escondido: el sprite de DE con y = 0xE0
L_68AA:
	ex de,hl			;68aa   ; [y 0x27][x][dibujo 0xA0][color 3]
	ld (hl),027h		;68ab
	inc l			;68ad
	ld (hl),b			;68ae
	inc l			;68af
	ld (hl),0a0h		;68b0
	inc l			;68b2
	ld (hl),003h		;68b3
	ret			;68b5
mano_del_arma:		; la mano que señala el arma
	ld de,0ec84h		;68b6   ; la mano de las armas...
	ld a,(0e04eh)		;68b9   ; lee el arma elegida en la pantalla de objetos
	or a			;68bc
	jp z,sprite_escondido		;68bd   ; sprite_escondido: el sprite de DE con y = 0xE0
	ld a,(0e04ch)		;68c0   ; lee la fila elegida en la pantalla de objetos (0 personaje, 1 arma)
	or a			;68c3
	jr z,L_68CE		;68c4
	ld a,(0e003h)		;68c6   ; ...parpadea si su fila esta elegida
	bit 3,a		;68c9
	jp z,sprite_escondido		;68cb   ; sprite_escondido: el sprite de DE con y = 0xE0
L_68CE:
	ex de,hl			;68ce   ; [y 0xA3][x del arma, tabla 0x68E3][dibujo 0xA0][color 15]
	ld (hl),0a3h		;68cf
	inc l			;68d1
	ld a,(0e04eh)		;68d2   ; lee el arma elegida en la pantalla de objetos
	ld de,l68e3h		;68d5
	call 0413bh		;68d8   ; de_mas_a: DE += A
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


marcas_del_mapa:		; las marcas del mapa, parpadeando
	ld de,0ec88h		;68ea   ; las marcas del mapa parpadean (bit 3 del contador)
	ld a,(0e003h)		;68ed   ; lee el contador de cuadros
	bit 3,a		;68f0
	jr z,L_68FD		;68f2
	ld hl,0e670h		;68f4   ; apunta a los sprites de las marcas del mapa
	ld bc,00008h		;68f7
	ldir		;68fa
	ret			;68fc
L_68FD:
	call sprite_escondido		;68fd   ; sprite_escondido: el sprite de DE con y = 0xE0
	jp sprite_escondido		;6900   ; sprite_escondido: el sprite de DE con y = 0xE0
sale_de_objetos:		; juega el elegido, con una vida menos y su arma
	ld de,0e04dh		;6903   ; al salir de la pantalla de objetos: juega el elegido...
	ld a,(de)			;6906
	ld (0e501h),a		;6907   ; guarda quien juega (0 Afrodita)
	ld hl,0e058h		;690a   ; ...con una vida menos...
	add a,l			;690d
	ld l,a			;690e
	ld a,(hl)			;690f
	sub 001h		;6910
	daa			;6912
	ld (hl),a			;6913
	inc e			;6914   ; ...y el arma elegida
	ld a,(de)			;6915
	ld (0e510h),a		;6916   ; guarda el arma elegida
	ret			;6919
borra_marcas_de_la_sala:		; los sitios de la lista 0xB25D de la sala a 0 en el tramo del mapa
	ld bc,(0e041h)		;691a   ; no en el mapa 12
	ld a,c			;691e
	cp 00ch		;691f
	ret z			;6921
	ld hl,0b25dh		;6922   ; la lista de la sala en 0xB25D (listas acabadas en 0)...
	call 0414ch		;6925   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,b			;6928
	cp 001h		;6929
	jr z,L_693E		;692b
	ex af,af'			;692d
	ld a,001h		;692e
	ex af,af'			;6930
L_6931:
	ld a,(de)			;6931   ; salta una lista (hasta su 0)...
	or a			;6932
	inc de			;6933
	jr nz,L_6931		;6934
	ex af,af'			;6936   ; ...hasta la de la sala B
	inc a			;6937
	cp b			;6938
	jr z,L_693E		;6939
	ex af,af'			;693b
	jr L_6931		;693c
L_693E:
	ld a,c			;693e   ; ...cada byte es un sitio del tramo de RAM del mapa (0xAF09)...
	exx			;693f
	ld hl,0af09h		;6940
	call 0414ch		;6943   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	dec de			;6946
	ld b,000h		;6947
	exx			;6949
L_694A:
	ld a,(de)			;694a   ; el sitio...
	or a			;694b
	ret z			;694c   ; ...0 acaba
	exx			;694d
	ld c,a			;694e
	ld h,d			;694f
	ld l,e			;6950
	add hl,bc			;6951
	ld (hl),b			;6952   ; ...que se pone a 0
	exx			;6953
	inc de			;6954
	jr L_694A		;6955
logotipo_de_konami:		; el logotipo: sus dibujos y 6 x 21 caracteres en la fila 8
	ld hl,00000h		;6957   ; el logotipo de Konami: el rle de 0xBCEF...
	ld (0e00eh),hl		;695a   ; guarda la columna del logotipo y el byte siguiente (16 bits)
	ld de,0bcefh		;695d
	call 05c40h		;6960   ; rle_con_destino: el rle de la direccion que hay en DE
	ld hl,00a00h		;6963   ; ...sus colores a 0...
	ld bc,003f0h		;6966
	xor a			;6969
	call 00056h		;696a   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03907h		;696d   ; ...y 6 filas de 21 caracteres desde el 0x40 en la fila 8, columna 7
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
columna_del_logotipo:		; una columna mas del logotipo; Z al acabar
	ld bc,(0e00eh)		;6985   ; cada cuadro una columna mas del logotipo (0xE00E/0xE00F)...
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
	call 04136h		;699a   ; hl_mas_a: HL += A
	ld b,015h		;699d
	ld de,00008h		;699f
	ld a,0f0h		;69a2   ; ...sus 21 caracteres en color 0xF0
L_69A4:
	call 0004dh		;69a4   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;69a7
	djnz L_69A4		;69a8
	ld hl,0e00eh		;69aa   ; 8 por columna...
	ld a,(hl)			;69ad
	inc a			;69ae
	and 007h		;69af
	ld (hl),a			;69b1
	ret nz			;69b2
	inc hl			;69b3   ; ...y 6 columnas: Z al acabar
	inc (hl)			;69b4
	ld a,(hl)			;69b5
	cp 006h		;69b6
	ret			;69b8
pantalla_del_estado_0c:		; el dibujo de 0xBBCF y la lista de 0xBB58 segun 0xE678
	xor a			;69b9   ; la pantalla del estado 0x0C: la sala a 0...
	ld de,0ed81h		;69ba
	ld hl,0ed80h		;69bd   ; apunta a la pantalla de la sala en la copia (filas 4-23)
	ld (hl),a			;69c0
	ld bc,0027fh		;69c1
	ldir		;69c4
	ld de,0ee04h		;69c6   ; ...el dibujo de 0xBBCF (24 x 12) en la fila 4...
	ld hl,0bbcfh		;69c9
	ld bc,00c18h		;69cc
	call copia_filas		;69cf   ; copia_filas: B filas de C bytes de HL a DE, en filas de 32
	call 054bfh		;69d2   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	ld a,(0e678h)		;69d5   ; ...y con 0xE678 la lista de 0xBB58
	or a			;69d8
	ret m			;69d9
	ld hl,0bb58h		;69da
	call 0414ch		;69dd   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	jp 05c25h		;69e0   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
cosa_e678:		; en los mundos, 0xE678-0xE67A de la lista 0x9C83 de la sala
	ld a,(0e041h)		;69e3   ; en los mundos, la lista de 0x9C83 del mapa: [sala][b][c]...
	sub 002h		;69e6
	ret m			;69e8
	ld hl,09c83h		;69e9
	call 0414ch		;69ec   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,(0e042h)		;69ef   ; lee la sala
	ld b,a			;69f2
L_69F3:
	ld a,(de)			;69f3   ; [sala][b][c]: 0 acaba
	or a			;69f4
	ret z			;69f5
	inc de			;69f6
	cp b			;69f7   ; la de esta sala?
	jr z,L_69FE		;69f8
	inc de			;69fa   ; no: la siguiente
	inc de			;69fb
	jr L_69F3		;69fc
L_69FE:
	ex de,hl			;69fe   ; ...la de esta sala: 0xE678 = el nibble bajo (0xFF si es 0)...
	ld a,(hl)			;69ff
	and 00fh		;6a00
	ld b,a			;6a02
	ld a,(hl)			;6a03   ; ...y y, x en 0xE679-0xE67A
	inc hl			;6a04
	ld c,(hl)			;6a05
	rr c		;6a06
	rra			;6a08
	and 0f8h		;6a09
	ld e,a			;6a0b
	ld a,(hl)			;6a0c
	and 0f8h		;6a0d
	ld d,a			;6a0f
	ld hl,0e678h		;6a10   ; apunta a lo de la sala del estado 0x0C (0xE678-0xE67A)
	ld a,b			;6a13
	or a			;6a14
	jr nz,L_6A18		;6a15
	dec a			;6a17
L_6A18:
	ld (hl),a			;6a18   ; [lo de la sala][y][x]
	inc l			;6a19
	ld (hl),d			;6a1a
	inc l			;6a1b
	ld (hl),e			;6a1c
	ret			;6a1d
fuente_de_los_textos:		; la fuente de dos medias filas de los textos que suben
	call 054e6h		;6a1e   ; los textos que suben: la fuente grande...
	call 05e6ch		;6a21   ; caracteres_2160: el rle de 0x9AA2 en 0x2160
	call 05e7bh		;6a24   ; caracteres_2168: el rle de 0x9ABD en 0x2168 en color 0xF0
	ld hl,02008h		;6a27   ; ...0x2A0 bytes de dibujos a 0xE800...
	call fuente_a_e800		;6a2a   ; fuente_a_e800: 0x2A0 bytes de dibujos de HL a 0xE800
	ld hl,0e948h		;6a2d   ; ...corridos para hacer las letras de dos medias filas...
	ld de,0e920h		;6a30
	ld bc,00028h		;6a33
	ldir		;6a36
	ld hl,0e838h		;6a38
	ld de,0e810h		;6a3b
	ld bc,00138h		;6a3e
	ldir		;6a41
	ld hl,0e808h		;6a43
	ld de,0e800h		;6a46   ; apunta a los huecos de figura (32 bytes cada uno)
	ld bc,00140h		;6a49
	ldir		;6a4c
	ld bc,00120h		;6a4e   ; ...de vuelta a la VRAM
	ld hl,02008h		;6a51
	call e800_a_vram		;6a54   ; e800_a_vram: BC bytes de 0xE800 a los tres tercios
	ld hl,02120h		;6a57
	call dibujos_a_cero		;6a5a   ; dibujos_a_cero: 0x6D8 bytes de dibujos a 0 en los tres tercios
	ld b,023h		;6a5d   ; 36 caracteres...
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
	call 04136h		;6a70   ; hl_mas_a: HL += A
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
	call 05bd8h		;6a89   ; ldirvm_tres_tercios: LDIRVM en los tres tercios
	pop bc			;6a8c
	dec b			;6a8d
	jp p,L_6A5F		;6a8e   ; ...a sus sitios nuevos (2 x caracter + 8)
	ld d,024h		;6a91
	ld hl,02010h		;6a93
L_6A96:
	ld bc,00008h		;6a96
	push de			;6a99
	push hl			;6a9a
	call filvrm_bc		;6a9b   ; filvrm_bc: BC bytes a 0 en los tres tercios
	pop hl			;6a9e
	ld de,00010h		;6a9f
	add hl,de			;6aa2
	pop de			;6aa3
	dec d			;6aa4
	jr nz,L_6A96		;6aa5
	ld hl,00000h		;6aa7   ; todo en color 0xF0
	ld a,0f0h		;6aaa
	ld bc,007f8h		;6aac
	call 05bebh		;6aaf   ; filvrm_tres_tercios: FILVRM en los tres tercios
	ld hl,02010h		;6ab2
fuente_a_e800:		; 0x2A0 bytes de dibujos de HL a 0xE800
	ld de,0e800h		;6ab5   ; apunta a los huecos de figura (32 bytes cada uno)
	ld bc,002a0h		;6ab8
	jp 00059h		;6abb   ; BIOS LDIRMV - Block transfers to memory from VRAM
dibujos_a_cero:		; 0x6D8 bytes de dibujos a 0 en los tres tercios
	ld bc,006d8h		;6abe
filvrm_bc:		; BC bytes a 0 en los tres tercios
	xor a			;6ac1
	jp 05bebh		;6ac2   ; filvrm_tres_tercios: FILVRM en los tres tercios
texto_story:		; el texto STORY (0xAE28)
	ld hl,0ae28h		;6ac5   ; STORY (0xAE28)
	jr L_6ACD		;6ac8
texto_epilogue:		; el texto EPILOGUE (0xA84A)
	ld hl,0a84ah		;6aca   ; EPILOGUE (0xA84A)
L_6ACD:
	ld (0f020h),hl		;6acd   ; el texto en 0xF020, sin espera
	xor a			;6ad0
	ld (0f01fh),a		;6ad1   ; guarda el paso del titulo
	ld (0f022h),a		;6ad4
	inc a			;6ad7
	ld (0f02bh),a		;6ad8
	ret			;6adb
sube_el_texto:		; un paso del texto que sube
	ld a,(0e003h)		;6adc   ; cada dos cuadros...
	bit 0,a		;6adf
	ret z			;6ae1
	ld a,(0f022h)		;6ae2   ; ...si no hay espera...
	or a			;6ae5
	jp nz,L_6B80		;6ae6
	call letras_un_pixel		;6ae9   ; ...las letras suben un pixel...
	ld a,(0f02bh)		;6aec   ; ...y cada 8, media fila de caracteres
	and 007h		;6aef
	jr nz,L_6B10		;6af1
	ld a,(0f01fh)		;6af3   ; lee el paso del titulo
	or a			;6af6
	jr nz,L_6B18		;6af7
	ld hl,0ed60h		;6af9   ; las filas impares suben...
	ld de,0ed20h		;6afc
	call sube_medias_filas		;6aff   ; sube_medias_filas: 11 filas de la copia de nombres, de dos en dos
	ld de,0efe0h		;6b02   ; ...y la linea nueva abajo
L_6B05:
	call linea_del_texto		;6b05   ; una media fila o la otra
	ld a,(0f01fh)		;6b08   ; lee el paso del titulo
	xor 001h		;6b0b
	ld (0f01fh),a		;6b0d   ; guarda el paso del titulo
L_6B10:
	call 054f3h		;6b10   ; la pantalla a la VRAM
	ld hl,0f02bh		;6b13
	inc (hl)			;6b16
	ret			;6b17
L_6B18:
	ld hl,0ed40h		;6b18
	ld de,0ed00h		;6b1b   ; apunta a la copia de la tabla de nombres (0x300 bytes)
	call sube_medias_filas		;6b1e   ; sube_medias_filas: 11 filas de la copia de nombres, de dos en dos
	ld de,0efc0h		;6b21
	jr L_6B05		;6b24
sube_medias_filas:		; 11 filas de la copia de nombres, de dos en dos
	ld b,00bh		;6b26   ; 11 filas de 32, de dos en dos
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
	call 04136h		;6b35   ; hl_mas_a: HL += A
	ld a,b			;6b38
	call 0413bh		;6b39   ; de_mas_a: DE += A
	pop bc			;6b3c
	djnz L_6B28		;6b3d
	ret			;6b3f
linea_del_texto:		; la linea siguiente del texto (0xFB, 0xFD, 0xFE, 0xFF)
	push de			;6b40   ; la linea nueva: a cero...
	xor a			;6b41
	ld b,020h		;6b42
L_6B44:
	ld (de),a			;6b44
	inc de			;6b45
	djnz L_6B44		;6b46
	pop de			;6b48
	ld hl,(0f020h)		;6b49   ; ...del texto: 0xFB delante calla la musica...
	ld a,(hl)			;6b4c
	inc hl			;6b4d
	cp 0fbh		;6b4e
	jr nz,L_6B59		;6b50
	ld a,0ffh		;6b52
	call 04e34h		;6b54   ; pide_sonido_ya: como pide_sonido, sin mirar la pausa
	ld a,(hl)			;6b57
	inc hl			;6b58
L_6B59:
	cp 0fdh		;6b59   ; ...0xFD n espera n...
	jr z,L_6B72		;6b5b
	cp 0feh		;6b5d   ; ...0xFE linea vacia...
	jr z,L_6B6E		;6b5f
	cp 0ffh		;6b61   ; ...0xFF acaba...
	jr z,L_6BAB		;6b63
	call 0413bh		;6b65   ; ...[columna][largo][caracteres]
	ld c,(hl)			;6b68
	ld b,000h		;6b69
	inc hl			;6b6b
	ldir		;6b6c
L_6B6E:
	ld (0f020h),hl		;6b6e
	ret			;6b71
L_6B72:
	ld a,(hl)			;6b72   ; la espera en 0xF023
	ld (0f023h),a		;6b73
	inc hl			;6b76
	ld (0f020h),hl		;6b77
	ld a,001h		;6b7a
	ld (0f022h),a		;6b7c
	ret			;6b7f
L_6B80:
	ld hl,0f023h		;6b80   ; cuenta la espera
	dec (hl)			;6b83
	ret nz			;6b84
	xor a			;6b85
	ld (0f022h),a		;6b86
	ret			;6b89
letras_un_pixel:		; los dibujos de las letras suben un pixel
	ld b,023h		;6b8a   ; los dibujos de las letras suben un pixel: 35 caracteres de 16 bytes...
	ld hl,0e801h		;6b8c
	ld de,0e800h		;6b8f   ; apunta a los huecos de figura (32 bytes cada uno)
L_6B92:
	push bc			;6b92
	ld bc,0000fh		;6b93
	ld a,(de)			;6b96   ; ...el byte de arriba pasa abajo
	ldir		;6b97
	ld (de),a			;6b99
	inc hl			;6b9a
	inc de			;6b9b
	pop bc			;6b9c
	djnz L_6B92		;6b9d
	ld bc,00230h		;6b9f   ; y a la VRAM
	ld hl,02010h		;6ba2
e800_a_vram:		; BC bytes de 0xE800 a los tres tercios
	ld de,0e800h		;6ba5   ; apunta a los huecos de figura (32 bytes cada uno)
	jp 05bd8h		;6ba8   ; ldirvm_tres_tercios: LDIRVM en los tres tercios
L_6BAB:
	xor a			;6bab   ; el texto se acabo
	ld (0e02eh),a		;6bac   ; guarda los textos estan subiendo
	ret			;6baf
jefe_en_la_copia:		; el mosaico del jefe en la copia de nombres
	ld a,(0e0d2h)		;6bb0   ; el jefe en la copia de nombres: con jefe...
	or a			;6bb3
	ret z			;6bb4
	ld ix,0e700h		;6bb5   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	ld a,(0e700h)		;6bb9   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	or a			;6bbc
	ret z			;6bbd
	cp 006h		;6bbe   ; ...el 6 va aparte...
	jr z,L_6BD5		;6bc0
	bit 7,(ix+002h)		;6bc2   ; ...los demas, con el bit 7...
	ret z			;6bc6
	ld a,(0e709h)		;6bc7   ; ...segun los bits 6 y 5 de 0xE709
	rla			;6bca
	rla			;6bcb
	jr c,jefe_en_trozos		;6bcc
	rla			;6bce
	jp nc,pinta_mosaico		;6bcf   ; pinta_mosaico: el mosaico de la figura en la copia, sin los 0
	jp pinta_mosaico_cortado		;6bd2   ; pinta_mosaico_cortado: el mosaico cortado por la izquierda
L_6BD5:
	call mosaico_del_jefe		;6bd5   ; el jefe 6: 9 filas de 15 caracteres
	exx			;6bd8
	ld b,009h		;6bd9
L_6BDB:
	exx			;6bdb
	ld bc,0000fh		;6bdc
	ldir		;6bdf
	ld a,011h		;6be1
	call 0413bh		;6be3   ; de_mas_a: DE += A
	exx			;6be6
	djnz L_6BDB		;6be7
	ret			;6be9
mosaico_del_jefe:		; HL = el mosaico 0xE70A, DE = su sitio 0xE712
	ld a,(0e70ah)		;6bea   ; el mosaico del jefe (0x9E0A) y su sitio en la copia (0xE712)
mosaico_a:		; HL = el mosaico A (0x9E0A), DE = el sitio del jefe (0xE712)
	ld hl,09e0ah		;6bed
	call 0414ch		;6bf0   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;6bf3
	ld de,(0e712h)		;6bf4   ; lee el sitio del jefe en la copia de nombres y el byte siguiente (16 bits)
	ret			;6bf8
jefe_en_trozos:		; el jefe de tres mosaicos (0xE70A, 0xE719, 0xE718)
	call mosaico_del_jefe		;6bf9   ; el jefe en tres trozos: el mosaico de 0xE70A (4 filas de 6, desde la columna 4)...
	ld bc,0040ah		;6bfc
	ld a,004h		;6bff
	call 0413bh		;6c01   ; de_mas_a: DE += A
	ld a,00ah		;6c04
	call trozo_de_mosaico		;6c06   ; trozo_de_mosaico: B filas del mosaico de HL en DE
	ld a,(0e719h)		;6c09   ; ...el de 0xE719 (4 de 2, fila 1 columna 2)...
	call mosaico_a		;6c0c   ; mosaico_a: HL = el mosaico A (0x9E0A), DE = el sitio del jefe (0xE712)
	ld bc,00402h		;6c0f
	ld a,022h		;6c12
	call 0413bh		;6c14   ; de_mas_a: DE += A
	ld a,002h		;6c17
	call trozo_de_mosaico		;6c19   ; trozo_de_mosaico: B filas del mosaico de HL en DE
	ld a,(0e718h)		;6c1c   ; ...y el de 0xE718 (1 de 2, en la fila de 0xE71C)
	call mosaico_a		;6c1f   ; mosaico_a: HL = el mosaico A (0x9E0A), DE = el sitio del jefe (0xE712)
	ld bc,00102h		;6c22
	ld a,(0e71ch)		;6c25   ; lee la fila de la cola del jefe 10
	add a,a			;6c28
	rla			;6c29
	rla			;6c2a
	rla			;6c2b
	rla			;6c2c
	and 0f0h		;6c2d
	call 0413bh		;6c2f   ; de_mas_a: DE += A
	ld a,002h		;6c32
trozo_de_mosaico:		; B filas del mosaico de HL en DE
	sub c			;6c34   ; C' = lo que sobra de cada fila del mosaico
	exx			;6c35
	ld c,a			;6c36
	exx			;6c37
	bit 4,(ix+009h)		;6c38   ; con el bit 4 de la ficha, las filas de (ix+0x1A)
	jr z,L_6C41		;6c3c
	ld b,(ix+01ah)		;6c3e
L_6C41:
	push bc			;6c41   ; una fila...
	push de			;6c42
	ld b,000h		;6c43
	ldir		;6c45
	pop de			;6c47
	ex de,hl			;6c48   ; ...y a la siguiente de la pantalla y del mosaico
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
cosa_en_la_copia:		; los caracteres de la cosa de la sala en su casilla
	ld a,(0e740h)		;6c56   ; la cosa de la sala en la copia de nombres...
	or a			;6c59
	ret z			;6c5a
	cp 007h		;6c5b   ; ...7-0x2C: 2 x 2 desde el caracter 0x76...
	jr c,L_6C7C		;6c5d
	sub 02dh		;6c5f   ; ...0x2D-0x2F: 2 x 2 desde 0x60 + 4 x (tipo - 0x2D)
	jr nc,L_6C76		;6c61
	ld a,076h		;6c63
L_6C65:
	ld hl,(0e744h)		;6c65   ; la casilla de la cosa: A...
	ld (hl),a			;6c68
	inc a			;6c69   ; ...A + 1 a la derecha...
	inc l			;6c6a
	ld (hl),a			;6c6b
	ld bc,0001fh		;6c6c   ; ...y los dos de abajo
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
	ld hl,l6c87h		;6c7c   ; ...1-6: una pareja de la tabla 0x6C87
	call 0414ch		;6c7f   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld hl,(0e744h)		;6c82   ; lee la casilla de la cosa de la sala y el byte siguiente (16 bits)
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


puerta_del_mundo_elegido:		; la puerta de 3 x 4 del mundo elegido (0x6CC7)
	ld hl,0e688h		;6c95   ; la puerta del mundo elegido...
	ld a,(hl)			;6c98
	or a			;6c99
	ret z			;6c9a
	inc l			;6c9b
	inc l			;6c9c
	ld e,(hl)			;6c9d   ; ...en su sitio (0xE68A-0xE68B)...
	inc l			;6c9e
	ld d,(hl)			;6c9f
	ex de,hl			;6ca0
	call 04da1h		;6ca1   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ex de,hl			;6ca4
	ld hl,06cc7h		;6ca5   ; ...el dibujo 0xE68C de 0x6CC7 (12 caracteres)...
	ld a,(0e68ch)		;6ca8   ; lee el dibujo de la puerta del mundo elegido
	add a,a			;6cab
	add a,a			;6cac
	ld b,a			;6cad
	add a,a			;6cae
	add a,b			;6caf
	ld c,a			;6cb0
	ld b,000h		;6cb1
	add hl,bc			;6cb3
	exx			;6cb4   ; ...3 filas de 4
	ld b,003h		;6cb5
L_6CB7:
	exx			;6cb7
	ld bc,00004h		;6cb8
	ldir		;6cbb
	ld a,01ch		;6cbd
	call 0413bh		;6cbf   ; de_mas_a: DE += A
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


guarda_debajo:		; guarda lo que tapa la figura de mosaico
	ld a,(ix+00ah)		;6ceb   ; una figura de mosaico entra: su tamaño (0x9D90)...
	call tamano_de_mosaico		;6cee   ; tamano_de_mosaico: C = ancho, B = alto del mosaico A (0x9D90)
	ld (ix+00bh),c		;6cf1
	call casilla_y_ancho		;6cf4   ; ...lo que cabe en pantalla...
	ld (ix+015h),c		;6cf7
	ld (ix+014h),b		;6cfa
	bit 4,(ix+009h)		;6cfd   ; ...con el bit 4 de la ficha, las filas de (ix+0x1A)
	jr z,L_6D06		;6d01
	ld b,(ix+01ah)		;6d03
L_6D06:
	push bc			;6d06   ; guarda lo que hay debajo
	push hl			;6d07
	ld b,000h		;6d08
	ldir		;6d0a
	pop hl			;6d0c
	ld c,020h		;6d0d
	add hl,bc			;6d0f
	pop bc			;6d10
	djnz L_6D06		;6d11
	ret			;6d13
guarda_debajo_yx:		; guarda lo que tapa la figura, con su casilla desde la y y la x
	ld a,(ix+00ah)		;6d14   ; lo mismo, con su casilla desde la y y la x
	call tamano_de_mosaico		;6d17   ; tamano_de_mosaico: C = ancho, B = alto del mosaico A (0x9D90)
	ld (ix+015h),c		;6d1a
	ld (ix+014h),b		;6d1d
	ld l,(ix+005h)		;6d20
	ld h,(ix+007h)		;6d23
	call 04da1h		;6d26   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+012h),l		;6d29
	ld (ix+013h),h		;6d2c
	ld c,(ix+00bh)		;6d2f
	jr L_6D06		;6d32
repone_debajo:		; vuelve a poner lo que tapaba la figura
	ld c,(ix+015h)		;6d34   ; vuelve a poner lo que habia debajo
L_6D37:
	ld b,(ix+014h)		;6d37   ; B filas de C desde la casilla de la figura
	ld e,(ix+012h)		;6d3a
	ld d,(ix+013h)		;6d3d
	bit 4,(ix+009h)		;6d40   ; con el bit 4 de la ficha, (ix+0x1A) filas
	jr z,copia_filas		;6d44
	ld b,(ix+01ah)		;6d46
copia_filas:		; B filas de C bytes de HL a DE, en filas de 32
	push bc			;6d49   ; B filas de C bytes de HL a DE (filas de 32)
	push de			;6d4a
	ld b,000h		;6d4b
	ldir		;6d4d   ; una fila...
	pop de			;6d4f
	ex de,hl			;6d50
	ld c,020h		;6d51   ; ...y la siguiente de 32
	add hl,bc			;6d53
	ex de,hl			;6d54
	pop bc			;6d55
	djnz copia_filas		;6d56
	ret			;6d58
repone_debajo_ancho:		; vuelve a poner lo que tapaba, con el ancho entero
	ld c,(ix+00bh)		;6d59
	jr L_6D37		;6d5c
pinta_mosaico:		; el mosaico de la figura en la copia, sin los 0
	ld a,(ix+00ah)		;6d5e   ; el mosaico (ix+0x0A) encima, sin los 0...
	ld hl,09e0ah		;6d61
	call 0414ch		;6d64   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;6d67
	ld e,(ix+012h)		;6d68
	ld d,(ix+013h)		;6d6b
	ld c,(ix+015h)		;6d6e
	ld b,(ix+014h)		;6d71
	ld a,(ix+00bh)		;6d74   ; ...lo que sobra de cada fila del mosaico
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
	ld a,(hl)			;6d87   ; los 0 no se pintan
	or a			;6d88
	jr z,L_6D8C		;6d89
	ld (de),a			;6d8b
L_6D8C:
	inc hl			;6d8c   ; el siguiente
	inc de			;6d8d
	djnz L_6D87		;6d8e
	pop de			;6d90   ; fila siguiente de la pantalla...
	ex de,hl			;6d91
	ld bc,00020h		;6d92
	add hl,bc			;6d95
	ex de,hl			;6d96
	exx			;6d97   ; ...y del mosaico (lo que sobra)
	ld a,c			;6d98
	exx			;6d99
	ld c,a			;6d9a
	add hl,bc			;6d9b
	pop bc			;6d9c
	djnz L_6D84		;6d9d   ; B filas
	ret			;6d9f
pinta_mosaico_cortado:		; el mosaico cortado por la izquierda
	ld a,(ix+00ah)		;6da0   ; lo mismo empezando mas a la derecha en el mosaico (lo que no cabe por la izquierda)
	ld hl,09e0ah		;6da3
	call 0414ch		;6da6   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
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
	push bc			;6dbd   ; una fila: desde lo que no cabe...
	push de			;6dbe
	exx			;6dbf
	ld a,c			;6dc0
	exx			;6dc1
	add a,l			;6dc2
	ld l,a			;6dc3
	jr nc,L_6DC7		;6dc4   ; ...del mosaico
	inc h			;6dc6
L_6DC7:
	ld b,c			;6dc7
L_6DC8:
	ld a,(hl)			;6dc8
	or a			;6dc9
	jr z,L_6DCD		;6dca
	ld (de),a			;6dcc
L_6DCD:
	inc hl			;6dcd   ; el siguiente
	inc de			;6dce
	djnz L_6DC8		;6dcf
	pop de			;6dd1   ; la fila siguiente de 32
	ex de,hl			;6dd2
	ld bc,00020h		;6dd3
	add hl,bc			;6dd6
	ex de,hl			;6dd7
	pop bc			;6dd8
	djnz L_6DBD		;6dd9   ; B filas
	ret			;6ddb
casilla_y_ancho:		; la casilla de la figura y las columnas que caben
	ld l,(ix+005h)		;6ddc   ; la casilla de la figura (y, x)...
	ld h,(ix+007h)		;6ddf
	call 04da1h		;6de2   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+012h),l		;6de5
	ld (ix+013h),h		;6de8
	ld a,l			;6deb   ; ...y las columnas que caben antes del borde derecho
	and 01fh		;6dec
	add a,c			;6dee
	sub 020h		;6def
	ret c			;6df1
	neg		;6df2
	add a,c			;6df4
	ld c,a			;6df5
	ret			;6df6
pinta_figuras:		; las figuras de los huecos: A = 0 las de detras, 1 las de delante
	ld (0e630h),a		;6df7   ; las figuras de los huecos: A = 0 las de detras, 1 las de delante
	ld de,0ecbch		;6dfa   ; sus sprites desde 0xECBC
	ld ix,0e800h		;6dfd   ; apunta a los huecos de figura (32 bytes cada uno)
	exx			;6e01
	ld hl,(0e635h)		;6e02   ; los huecos de 0xE635 (B), y C mas
	ld b,l			;6e05
	ld c,h			;6e06
	ld de,00020h		;6e07
L_6E0A:
	exx			;6e0a
	call pinta_figura		;6e0b   ; pinta_figura: una figura: sprites, 2 x 2 o mosaico
	exx			;6e0e
	add ix,de		;6e0f
	djnz L_6E0A		;6e11
	ld a,c			;6e13   ; los sprites que sobran...
	exx			;6e14
	or a			;6e15
	ret z			;6e16
	ld b,a			;6e17
	ld a,(0e630h)		;6e18   ; lee la pasada de figuras (0 detras, 1 delante)
	or a			;6e1b
	ret nz			;6e1c
esconde_b_sprites:		; B sprites desde DE con y = 0xE0
	call sprite_escondido		;6e1d   ; ...escondidos
	djnz esconde_b_sprites		;6e20
	ret			;6e22
sprite_escondido:		; el sprite de DE con y = 0xE0
	ld a,0e0h		;6e23   ; el sprite de DE escondido (y = 0xE0)
	ld (de),a			;6e25
	inc e			;6e26
	inc e			;6e27
	inc e			;6e28
	inc e			;6e29
	ret			;6e2a
pinta_figura:		; una figura: sprites, 2 x 2 o mosaico
	bit 7,(ix+002h)		;6e2b   ; solo las que estan en pantalla (bit 7)
	ret z			;6e2f
	bit 7,(ix+009h)		;6e30   ; bit 7 de la ficha: de sprites
	jr nz,sprites_de_figura		;6e34
	ld a,(0e630h)		;6e36   ; los tipos 0x5D-0x5E van en la otra pasada
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
	bit 6,(ix+009h)		;6e4e   ; bit 6 de la ficha: p01:6F2C
	jr nz,L_6EA1		;6e52
	ld a,(ix+000h)		;6e54   ; el tipo 0x5C: 2 x 2 desde 0xBA
	cp 05ch		;6e57
	jr z,L_6E75		;6e59
	cp 06bh		;6e5b   ; el 0x6B: 2 x 2 desde 0x7A
	jr nz,L_6E79		;6e5d
	ld a,07ah		;6e5f
L_6E61:
	ld l,(ix+012h)		;6e61   ; 2 x 2 caracteres seguidos en su casilla
	ld h,(ix+013h)		;6e64
	ld (hl),a			;6e67   ; el caracter A...
	inc hl			;6e68
	inc a			;6e69   ; ...el siguiente a la derecha...
	ld (hl),a			;6e6a
	ld bc,0001fh		;6e6b   ; ...y los dos de abajo
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
	push de			;6e79   ; los demas: su mosaico (ix+0x0A)...
	ld a,(ix+00ah)		;6e7a
	ld d,a			;6e7d
	call tamano_de_mosaico		;6e7e   ; tamano_de_mosaico: C = ancho, B = alto del mosaico A (0x9D90)
	ld a,d			;6e81
	ld hl,09e0ah		;6e82
	call 0414ch		;6e85   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;6e88
	ld e,(ix+012h)		;6e89
	ld d,(ix+013h)		;6e8c
L_6E8F:
	push bc			;6e8f   ; ...fila a fila
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
	call figura_especial		;6ea2   ; figura_especial: las figuras de bit 6: por (ix+0x0B)
	pop de			;6ea5
	ret			;6ea6
tamano_de_mosaico:		; C = ancho, B = alto del mosaico A (0x9D90)
	ld l,a			;6ea7   ; C = ancho y B = alto del mosaico A (0x9D90)
	ld h,000h		;6ea8
	add hl,hl			;6eaa
	ld bc,09d90h		;6eab
	add hl,bc			;6eae
	ld c,(hl)			;6eaf
	inc hl			;6eb0
	ld b,(hl)			;6eb1
	ret			;6eb2
sprites_de_figura:		; los sprites de la figura segun su ficha
	ld a,(0e630h)		;6eb3   ; de sprites, solo en la primera pasada
	or a			;6eb6
	ret nz			;6eb7   ; en la de delante no
	ld a,(ix+009h)		;6eb8   ; la ficha: bits 0-2 cuantos sprites, 3-5 como se ponen
	ld l,a			;6ebb
	and 03fh		;6ebc   ; bits 0-5: como se ponen y cuantos
	ld b,a			;6ebe
	and 007h		;6ebf   ; C' = 7 - cuantos
	ld c,a			;6ec1
	exx			;6ec2
	sub c			;6ec3
	neg		;6ec4
	ld c,a			;6ec6
	exx			;6ec7
	bit 6,l		;6ec8   ; bit 6: p01:6F2C
	jr nz,figura_especial		;6eca
	dec c			;6ecc   ; 1: un sprite
	jr z,un_sprite		;6ecd
	dec c			;6ecf   ; 2: dos, el segundo desplazado...
	ret nz			;6ed0
	ld a,b			;6ed1   ; los desplazamientos de cada sprite segun los bits 3-5
	srl a		;6ed2   ; ...segun los bits 3-5:
	srl a		;6ed4
	srl a		;6ed6
	ld hl,00000h		;6ed8   ; 0: encima
	or a			;6edb
	jr z,dos_sprites		;6edc
	ld l,010h		;6ede   ; 1: 16 a la derecha
	dec a			;6ee0
	jr z,dos_sprites		;6ee1
	ld l,0f0h		;6ee3   ; 2: 16 a la izquierda
	dec a			;6ee5
	jr z,dos_sprites		;6ee6
	ld hl,01000h		;6ee8   ; 3: 16 abajo
	dec a			;6eeb
	jr z,dos_sprites		;6eec
	ld h,0f0h		;6eee   ; 4: 16 arriba
	dec a			;6ef0
	jr z,dos_sprites		;6ef1
	ld hl,0ff10h		;6ef3   ; 5: 16 arriba y 16 a la derecha
	dec a			;6ef6
	jr z,dos_sprites		;6ef7
	ld l,0f0h		;6ef9   ; 6: 16 arriba y 16 a la izquierda
	dec a			;6efb
	jr z,dos_sprites		;6efc
	ret nz			;6efe
dos_sprites:		; dos sprites: el desplazado (ix+0x12, 0x13) y el de (ix+0x0A, 0x0B)
	ld a,(ix+005h)		;6eff   ; el segundo sprite, desplazado: y - 1 + H...
	add a,h			;6f02
	dec a			;6f03
	ld (de),a			;6f04
	inc e			;6f05
	ld a,(ix+007h)		;6f06   ; ...x + L...
	add a,l			;6f09
	ld (de),a			;6f0a
	inc e			;6f0b
	ld a,(ix+012h)		;6f0c   ; ...y el dibujo y color de (ix+0x12) y (ix+0x13)
	ld (de),a			;6f0f
	inc e			;6f10
	ld a,(ix+013h)		;6f11
	ld (de),a			;6f14
	inc e			;6f15
un_sprite:		; un sprite: [y - 1][x][dibujo (ix+0x0A)][color (ix+0x0B)]
	ld a,(ix+005h)		;6f16   ; el primero: [y - 1][x][dibujo (ix+0x0A)][color (ix+0x0B)]
	dec a			;6f19   ; la y - 1...
	ld (de),a			;6f1a
	inc e			;6f1b
	ld a,(ix+007h)		;6f1c   ; ...la x...
	ld (de),a			;6f1f
	inc e			;6f20
	ld a,(ix+00ah)		;6f21   ; ...el dibujo (ix+0x0A)...
	ld (de),a			;6f24
	inc e			;6f25
	ld a,(ix+00bh)		;6f26   ; ...y el color (ix+0x0B)
	ld (de),a			;6f29
	inc e			;6f2a
	ret			;6f2b
figura_especial:		; las figuras de bit 6: por (ix+0x0B)
	ld a,(ix+00bh)		;6f2c   ; bit 6 de la ficha: por el ancho (ix+0x0B), tabla que sigue
	call 04140h		;6f2f   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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


columna_b4:		; una columna de 0xB5, 0xB4... y 0x99
	ld l,(ix+012h)		;6f54   ; una columna: 0xB5 arriba...
	ld h,(ix+013h)		;6f57
	ld de,00020h		;6f5a   ; filas de 32
	ld a,(ix+014h)		;6f5d   ; (ix+0x14) caracteres...
	or a			;6f60
	jr z,L_6F6F		;6f61
	ld (hl),0b5h		;6f63   ; ...el primero 0xB5
	add hl,de			;6f65
	dec a			;6f66
	jr z,L_6F6F		;6f67
	ld b,a			;6f69
L_6F6A:
	ld (hl),0b4h		;6f6a   ; ...0xB4 en medio...
	add hl,de			;6f6c
	djnz L_6F6A		;6f6d
L_6F6F:
	ld a,099h		;6f6f   ; ...y 0x99 abajo (el tipo 4)
	ld (hl),a			;6f71
	ret			;6f72
dos_por_dos:		; 2 x 2 caracteres desde (ix+0x0A)
	ld l,(ix+012h)		;6f73   ; 2 x 2 caracteres desde (ix+0x0A)
	ld h,(ix+013h)		;6f76
	ld a,(ix+00ah)		;6f79   ; el caracter de (ix+0x0A)...
	ld (hl),a			;6f7c
	inc hl			;6f7d
	inc a			;6f7e   ; ...y los tres siguientes
	ld (hl),a			;6f7f
	ld bc,0001fh		;6f80   ; la fila de abajo
	add hl,bc			;6f83
	inc a			;6f84
	ld (hl),a			;6f85
	inc hl			;6f86
	inc a			;6f87
	ld (hl),a			;6f88
	ret			;6f89
fila_de_a77e:		; una fila de la tabla 0xA77E
	ld a,(ix+00ah)		;6f8a   ; una fila de (ix+0x1F) caracteres de la tabla 0xA77E...
	ld hl,0a77eh		;6f8d
	call 0414ch		;6f90   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld l,(ix+012h)		;6f93
	ld h,(ix+013h)		;6f96
	ld a,(0e041h)		;6f99   ; ...en el mapa 10, con 0x22 menos
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
	ld a,(de)			;6fac   ; cada caracter menos 0x22
	sub 022h		;6fad
	ld (hl),a			;6faf
	inc hl			;6fb0
	inc de			;6fb1
	djnz L_6FAC		;6fb2   ; B de ellos
	ret			;6fb4
cuatro_y_uno:		; cuatro sprites de color 15 y uno mas
	ld a,00fh		;6fb5   ; cuatro sprites de color 15 y uno mas (dibujo 0xA0, color 12)
	call cuatro_sprites		;6fb7   ; cuatro_sprites: cuatro sprites de 16 x 16 en cuadro (tabla 0x7039) del color de A
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
	ld a,00fh		;6fce   ; cuatro sprites de 16 x 16 en cuadro, del color de A:
	jr cuatro_sprites		;6fd0
L_6FD2:
	ld a,005h		;6fd2
	jr cuatro_sprites		;6fd4
L_6FD6:
	ld a,001h		;6fd6
	jr cuatro_sprites		;6fd8
L_6FDA:
	ld a,00fh		;6fda
	jr cuatro_sprites		;6fdc
L_6FDE:
	ld a,00bh		;6fde
	jr cuatro_sprites		;6fe0
L_6FE2:
	ld a,009h		;6fe2
cuatro_sprites:		; cuatro sprites de 16 x 16 en cuadro (tabla 0x7039) del color de A
	ex af,af'			;6fe4   ; sus dibujos de la tabla 0x7039 (4 por figura)...
	ld a,(ix+00ah)		;6fe5   ; 4 dibujos por figura (ix+0x0A)
	add a,a			;6fe8   ; x 4...
	add a,a			;6fe9
	ld c,a			;6fea
	ld b,000h		;6feb
	ld hl,07039h		;6fed   ; ...en 0x7039
	add hl,bc			;6ff0
	ld c,(ix+005h)		;6ff1   ; ...el de arriba a la izquierda...
	dec c			;6ff4   ; la y - 1
	ld b,(ix+007h)		;6ff5   ; la x
	ex de,hl			;6ff8
	ld (hl),c			;6ff9   ; [y]...
	inc l			;6ffa
	ld (hl),b			;6ffb   ; ...[x]...
	inc l			;6ffc   ; DE = la tabla, HL = los sprites
	ex de,hl			;6ffd
	ldi		;6ffe   ; ...[dibujo]...
	inc bc			;7000   ; (BC solo de paso)
	ex de,hl			;7001
	ex af,af'			;7002
	ld (hl),a			;7003   ; ...[color]
	ex af,af'			;7004
	inc l			;7005   ; el segundo: [y]...
	ld (hl),c			;7006   ; ...arriba a la derecha (x + 16)...
	inc l			;7007
	ld a,b			;7008   ; x + 16
	add a,010h		;7009
	ld (hl),a			;700b   ; ...[x + 16]...
	inc l			;700c
	ex de,hl			;700d
	ldi		;700e   ; su dibujo
	inc bc			;7010
	ex de,hl			;7011
	ex af,af'			;7012
	ld (hl),a			;7013   ; y el color
	ex af,af'			;7014
	inc l			;7015
	ld a,c			;7016   ; ...abajo a la izquierda (y + 16)...
	add a,010h		;7017
	ld c,a			;7019   ; el tercero: y + 16...
	ld (hl),c			;701a   ; ...[y]...
	inc l			;701b
	ld (hl),b			;701c   ; la x de partida
	inc l			;701d
	ex de,hl			;701e   ; ...su dibujo...
	ldi		;701f   ; su dibujo
	inc bc			;7021
	ex de,hl			;7022
	ex af,af'			;7023
	ld (hl),a			;7024   ; ...[color]
	ex af,af'			;7025
	inc l			;7026   ; ...y abajo a la derecha
	ld (hl),c			;7027   ; el cuarto: [y + 16]...
	inc l			;7028
	ld a,b			;7029   ; x + 16 otra vez
	add a,010h		;702a
	ld (hl),a			;702c   ; ...[x + 16]
	inc l			;702d
	ex de,hl			;702e
	ldi		;702f   ; el cuarto dibujo
	inc bc			;7031
	ex de,hl			;7032
	ex af,af'			;7033
	ld (hl),a			;7034   ; y el color
	ex af,af'			;7035
	inc l			;7036
	ex de,hl			;7037
	ret			;7038   ; DE queda tras los cuatro

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


dos_sprites_derecha:		; dos sprites de color 6, el segundo a la derecha
	ld a,006h		;7079   ; dos sprites de color 6, el segundo 3 mas a la derecha...
	ld b,003h		;707b
	jr dos_sprites_tabla		;707d
dos_sprites_izquierda:		; dos sprites de color 6, el segundo a la izquierda
	ld a,006h		;707f   ; ...o 3 mas a la izquierda
	ld b,0fdh		;7081
dos_sprites_tabla:		; dos sprites de la tabla 0x70BE
	ex af,af'			;7083   ; sus dibujos de la tabla 0x70BE (2 por figura)
	ld a,b			;7084   ; B: lo que se mueve
	ld (0f005h),a		;7085   ; lo que se mueve el segundo, en 0xF005
	ld a,(ix+00ah)		;7088   ; 2 dibujos por figura (ix+0x0A)
	add a,a			;708b   ; x 2...
	ld c,a			;708c
	ld b,000h		;708d
	ld hl,070beh		;708f   ; ...en 0x70BE
	add hl,bc			;7092
	ld c,(ix+005h)		;7093   ; la y - 1 y la x
	dec c			;7096   ; - 1
	ld b,(ix+007h)		;7097   ; la x
	ex de,hl			;709a
	ld (hl),c			;709b   ; [y][x]...
	inc l			;709c
	ld (hl),b			;709d   ; [x]
	inc l			;709e
	ex de,hl			;709f
	ldi		;70a0   ; ...[dibujo]...
	inc bc			;70a2
	ex de,hl			;70a3
	ex af,af'			;70a4
	ld (hl),a			;70a5   ; ...[color 6]
	ex af,af'			;70a6
	inc l			;70a7   ; el segundo: y + 3, x + 0xF005, color 11
	ld a,c			;70a8   ; el segundo 3 mas abajo...
	add a,003h		;70a9
	ld (hl),a			;70ab   ; [y + 3]
	inc l			;70ac
	ld a,(0f005h)		;70ad   ; ...y movido
	add a,b			;70b0   ; x + lo de 0xF005
	ld (hl),a			;70b1
	inc l			;70b2
	ex de,hl			;70b3
	ldi		;70b4   ; su dibujo...
	inc bc			;70b6
	ex de,hl			;70b7
	ld a,00bh		;70b8   ; ...de color 11
	ld (hl),a			;70ba   ; [color 11]
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


cadena:		; una cadena de sprites (bits 0-2 de la ficha)
	ld a,008h		;70c6   ; una cadena de sprites de color 8: (bits 0-2 de la ficha) - 1 eslabones...
	ex af,af'			;70c8
	ld a,(ix+009h)		;70c9
	and 007h		;70cc
	dec a			;70ce
	ld (0f007h),a		;70cf
	ld b,(ix+007h)		;70d2
	ex de,hl			;70d5
	call cabeza_de_cadena		;70d6   ; ...la cabeza...
	ld a,(ix+00ah)		;70d9
	ld c,(ix+005h)		;70dc
	dec c			;70df
L_70E0:
	ld (hl),c			;70e0   ; [y]...
	inc l			;70e1
	ld (hl),b			;70e2   ; ...[x]...
	inc l			;70e3
	ld (hl),a			;70e4   ; ...[dibujo]...
	inc l			;70e5
	ex af,af'			;70e6
	ld (hl),a			;70e7   ; ...[color 8]
	ex af,af'			;70e8
	inc l			;70e9
	ld a,(0f007h)		;70ea   ; mas eslabones?
	dec a			;70ed
	jr z,L_710F		;70ee
	ld (0f007h),a		;70f0
	push bc			;70f3
	ld b,010h		;70f4   ; ...cada uno 16 mas abajo (o mas arriba con (ix+0x15))...
	ld a,(ix+015h)		;70f6   ; hacia arriba con (ix+0x15)
	and a			;70f9
	jr z,L_70FE		;70fa
	ld b,0f0h		;70fc
L_70FE:
	ld a,c			;70fe
	add a,b			;70ff
	pop bc			;7100
	ld c,a			;7101
	ld a,(ix+000h)		;7102   ; ...dibujo 0xD4 (0xC8 en el tipo 0x62)
	cp 062h		;7105
	ld a,0d4h		;7107
	jr nz,L_70E0		;7109
	ld a,0c8h		;710b
	jr L_70E0		;710d
L_710F:
	ex de,hl			;710f
	ret			;7110
cabeza_de_cadena:		; la cabeza de la cadena
	ld a,(ix+016h)		;7111   ; la cabeza: dibujo 0xD0 color 4 (0xC8 color 8 en el tipo 0x62)
	ld (hl),a			;7114   ; [y (ix+0x16)]...
	inc l			;7115
	ld (hl),b			;7116   ; ...[x]...
	inc l			;7117
	ld a,(ix+000h)		;7118
	cp 062h		;711b
	jr z,L_7128		;711d
	ld a,0d0h		;711f   ; ...[0xD0][4]
	ld (hl),a			;7121
	inc l			;7122
	ld a,004h		;7123
	ld (hl),a			;7125
	inc l			;7126
	ret			;7127
L_7128:
	ld a,0c8h		;7128   ; el tipo 0x62: [0xC8][8]
	ld (hl),a			;712a
	inc l			;712b
	ld a,008h		;712c
	ld (hl),a			;712e
	inc l			;712f
	ret			;7130
cuatro_c4_c8:		; cuatro sprites 0xC4, 0xC8, 0xCC
	ld a,008h		;7131   ; cuatro sprites: dos 0xC4 de color 4 encima y 0xC8/0xCC debajo
	ex af,af'			;7133   ; el color de abajo, 8
	ld c,(ix+005h)		;7134   ; la y - 1...
	dec c			;7137
	ld b,(ix+007h)		;7138   ; ...y la x
	ex de,hl			;713b
	ld a,(ix+016h)		;713c   ; arriba: la y de (ix+0x16) - 1...
	dec a			;713f   ; - 1
	ld (hl),a			;7140   ; [y]...
	inc l			;7141
	ld (hl),b			;7142   ; ...[x]...
	inc l			;7143
	ld a,0c4h		;7144   ; ...dibujo 0xC4 color 4...
	ld (hl),a			;7146
	inc l			;7147
	ld a,004h		;7148   ; ...[color 4]
	ld (hl),a			;714a
	inc l			;714b
	ld a,(ix+016h)		;714c   ; ...y otro a su derecha (x + 16)
	dec a			;714f
	ld (hl),a			;7150   ; [y]...
	inc l			;7151
	ld a,b			;7152   ; ...[x + 16]...
	add a,010h		;7153
	ld (hl),a			;7155
	inc l			;7156
	ld a,0c4h		;7157   ; ...[0xC4]...
	ld (hl),a			;7159
	inc l			;715a
	ld a,004h		;715b   ; ...[4]
	ld (hl),a			;715d
	inc l			;715e
	ld (hl),c			;715f   ; abajo: dibujo 0xC8 de color 8...
	inc l			;7160
	ld (hl),b			;7161   ; [x]...
	inc l			;7162
	ld a,0c8h		;7163   ; ...[0xC8]...
	ld (hl),a			;7165
	inc l			;7166
	ex af,af'			;7167   ; ...[8]
	ld (hl),a			;7168
	ex af,af'			;7169
	inc l			;716a
	ld (hl),c			;716b   ; ...y a su derecha...
	inc l			;716c
	ld a,b			;716d   ; [x + 16]...
	add a,010h		;716e
	ld (hl),a			;7170
	inc l			;7171
	ld a,0cch		;7172   ; ...el 0xCC
	ld (hl),a			;7174
	inc l			;7175
	ex af,af'			;7176   ; ...[8]
	ld (hl),a			;7177
	inc l			;7178
	ex de,hl			;7179
L_717A:
	ret			;717a
fila_de_sprites:		; una fila de (ix+0x16) sprites
	ld a,(ix+016h)		;717b   ; una fila de (ix+0x16) sprites con sus dibujos desde (ix+0x18)...
	ld (0f007h),a		;717e
	push ix		;7181
	pop hl			;7183
	ld bc,00018h		;7184
	add hl,bc			;7187
	ld c,(ix+005h)		;7188
	ld b,(ix+007h)		;718b
	ex de,hl			;718e
L_718F:
	ld (ix+012h),c		;718f   ; ...[y][x][dibujo][color (ix+0x15)]...
	ld (hl),c			;7192   ; [y]...
	inc l			;7193
	ld (ix+013h),b		;7194   ; la x tambien a (ix+0x13)
	ld (hl),b			;7197   ; ...[x]...
	inc l			;7198
	ld a,(de)			;7199   ; ...[dibujo de la lista]...
	ld (hl),a			;719a
	inc l			;719b
	ld a,(ix+015h)		;719c   ; ...[color (ix+0x15)]
	ld (hl),a			;719f
	inc l			;71a0
	ld a,(0f007h)		;71a1   ; quedan sprites?
	dec a			;71a4
	jr z,L_71D7		;71a5   ; el ultimo: se acabo
	ld (0f007h),a		;71a7
	push hl			;71aa   ; ...la x del siguiente segun los anchos de las tablas 0x71D9 y 0x71DE
	ld hl,071d9h		;71ab   ; el ancho por la derecha del dibujo (0x71D9)...
	ld a,(de)			;71ae   ; el dibujo - 0xA0...
	sub 0a0h		;71af
	rra			;71b1   ; ...entre 4: una de 8 formas
	rra			;71b2
	and 007h		;71b3
	call 04136h		;71b5   ; hl_mas_a: HL += A
	ld a,(hl)			;71b8   ; lo que sobra por la derecha
	ex af,af'			;71b9
	inc de			;71ba   ; el dibujo siguiente
	ld hl,071deh		;71bb   ; ...y por la izquierda del siguiente (0x71DE)...
	ld a,(de)			;71be
	sub 0a0h		;71bf
	rra			;71c1
	rra			;71c2
	and 007h		;71c3
	call 04136h		;71c5   ; hl_mas_a: HL += A
	ld a,(hl)			;71c8   ; lo que sobra por la izquierda
	ld h,a			;71c9
	ex af,af'			;71ca
	ld l,a			;71cb
	ld a,b			;71cc   ; ...dan la x del siguiente...
	add a,l			;71cd   ; x + derecha - izquierda
	sub h			;71ce
	ld b,a			;71cf
	pop hl			;71d0   ; HL vuelve a los sprites
	ld a,c			;71d1   ; ...16 mas abajo
	add a,010h		;71d2
	ld c,a			;71d4
	jr L_718F		;71d5   ; y el siguiente
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


figuras_del_castillo:		; las figuras del castillo de cada cuadro
	call escalera_ec08		;71e3   ; las figuras del castillo de cada cuadro
	call escalera_ec00		;71e6   ; escalera_ec00: la escalera de 0xEC00
	call bloque_eac0		;71e9   ; bloque_eac0: con 0xEAC0, 3 x 4 de 0xF0
	call puertas_del_castillo		;71ec   ; puertas_del_castillo: las dos puertas de 0xEA00 (figura 1)
	call figuras_2		;71ef   ; figuras_2: las dos de 0xEA30 (figura 2, dibujos 0xA6FB)
	call figura_3		;71f2   ; figura_3: la de 0xEA50 (figura 3, dibujos 0xA726)
	call figuras_4		;71f5   ; figuras_4: las cuatro de 0xEA60 (figura 4, dibujos 0xA74C)
	call figuras_eab0		;71f8   ; figuras_eab0: las dos de 0xEAB8: 0xC2 0xC3
	call figura_7		;71fb   ; figura_7: los 3 x 4 de 0xA772 (figura 7)
	call columna_eaa0		;71fe   ; columna_eaa0: la columna de 0xEAA0
	call bloque_eac9		;7201   ; bloque_eac9: con 0xEAC9, 3 x 4 de 0xF0
	ld a,(0eac8h)		;7204   ; con 0xEAC8 (lo que abre el objeto 0x12)...
	or a			;7207
	ret z			;7208
	ld hl,0ee68h		;7209   ; ...16 caracteres 0xC4 en la fila 11
	ld bc,010c4h		;720c
L_720F:
	ld (hl),c			;720f
	inc l			;7210
	djnz L_720F		;7211
	ret			;7213
columna_eaa0:		; la columna de 0xEAA0
	ld hl,0eaa0h		;7214   ; la columna de 0xEAA0
	jr L_7231		;7217
puertas_del_castillo:		; las dos puertas de 0xEA00 (figura 1)
	ld ix,0ea00h		;7219   ; las dos puertas de 0xEA00 (figura 1)
	exx			;721d
	ld b,002h		;721e
	ld de,00010h		;7220
L_7223:
	exx			;7223
	call columna_de_figura		;7224   ; columna_de_figura: la columna de la figura IX
	exx			;7227
	add ix,de		;7228
	djnz L_7223		;722a
	exx			;722c
	ret			;722d
columna_de_figura:		; la columna de la figura IX
	push ix		;722e
	pop hl			;7230
L_7231:
	ld a,(hl)			;7231   ; si esta y tiene alto (byte 4)...
	and a			;7232
	ret z			;7233
	inc hl			;7234
	inc hl			;7235
	inc hl			;7236
	inc hl			;7237
	ld a,(hl)			;7238
	and a			;7239
	ret z			;723a
	inc hl			;723b   ; ...su casilla (bytes 5-6) y su caracter (byte 8)...
	ld e,(hl)			;723c
	inc hl			;723d
	ld d,(hl)			;723e
	ld b,a			;723f
	inc hl			;7240
	inc hl			;7241
	ld a,(hl)			;7242
	ex de,hl			;7243
L_7244:
	ld (hl),a			;7244   ; ...en columna
	ld de,00020h		;7245
	add hl,de			;7248
	djnz L_7244		;7249
	ret			;724b
figuras_2:		; las dos de 0xEA30 (figura 2, dibujos 0xA6FB)
	ld ix,0ea30h		;724c   ; las dos de 0xEA30 (figura 2): dibujos de 0xA6FB
	exx			;7250
	ld b,002h		;7251
	ld de,00010h		;7253
L_7256:
	exx			;7256
	call figura_2		;7257   ; figura_2: una de 0xEA30
	exx			;725a
	add ix,de		;725b
	djnz L_7256		;725d
	exx			;725f
	ret			;7260
figura_2:		; una de 0xEA30
	ld a,(ix+000h)		;7261   ; el dibujo (byte 4), ancho y alto (bytes 8-9), en su casilla (6-7)
	and a			;7264
	ret z			;7265
	ld a,(ix+004h)		;7266
	ld c,(ix+008h)		;7269
	ld b,(ix+009h)		;726c
	ld hl,0a6fbh		;726f
	call 0414ch		;7272   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld l,(ix+006h)		;7275
	ld h,(ix+007h)		;7278
	ex de,hl			;727b
L_727C:
	push bc			;727c   ; fila a fila
	ld b,000h		;727d   ; una fila...
	ldir		;727f
	ld a,(ix+008h)		;7281   ; ...y a la siguiente: 32 - ancho
	ld c,a			;7284
	ld a,020h		;7285
	sub c			;7287
	ld c,a			;7288
	ex de,hl			;7289
	add hl,bc			;728a
	ex de,hl			;728b
	pop bc			;728c
	djnz L_727C		;728d   ; B filas
	ret			;728f
figuras_4:		; las cuatro de 0xEA60 (figura 4, dibujos 0xA74C)
	ld ix,0ea60h		;7290   ; las cuatro de 0xEA60 (figura 4): dibujos de 0xA74C
	exx			;7294
	ld b,004h		;7295
	ld de,00010h		;7297
L_729A:
	exx			;729a
	call figura_4		;729b   ; figura_4: una de 0xEA60
	exx			;729e
	add ix,de		;729f
	djnz L_729A		;72a1
	exx			;72a3
	ret			;72a4
figura_4:		; una de 0xEA60
	ld a,(ix+000h)		;72a5
	and a			;72a8
	ret z			;72a9
	ld a,(ix+005h)		;72aa
	ld c,a			;72ad
	ld hl,0a74ch		;72ae
	call 0414ch		;72b1   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	jr L_72C9		;72b4
figura_3:		; la de 0xEA50 (figura 3, dibujos 0xA726)
	ld ix,0ea50h		;72b6   ; la de 0xEA50 (figura 3): dibujos de 0xA726
	ld a,(ix+000h)		;72ba
	and a			;72bd
	ret z			;72be
	ld a,(ix+005h)		;72bf
	ld c,a			;72c2
	ld hl,0a726h		;72c3
	call 0414ch		;72c6   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
L_72C9:
	ld l,(ix+007h)		;72c9   ; en su casilla, 3 filas de 1 (dibujo 0) o de 3
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
	ld b,000h		;72dc   ; una fila de C...
	ldir		;72de
	ld c,a			;72e0   ; ...y a la siguiente
	ld a,020h		;72e1
	sub c			;72e3
	ld c,a			;72e4
	ex de,hl			;72e5
	add hl,bc			;72e6
	ex de,hl			;72e7
	pop bc			;72e8
	djnz L_72DA		;72e9   ; 3 filas
	ret			;72eb
figuras_eab0:		; las dos de 0xEAB8: 0xC2 0xC3
	ld hl,0eab0h		;72ec   ; con 0xEAB0, las dos de 0xEAB8: 0xC2 0xC3 en su casilla
	ld a,(hl)			;72ef
	and a			;72f0
	ret z			;72f1
	ld hl,0eab8h		;72f2
	ld b,002h		;72f5
L_72F7:
	ld a,(hl)			;72f7   ; si esta...
	and a			;72f8
	jr z,L_7305		;72f9
	inc hl			;72fb
	ld e,(hl)			;72fc   ; ...su casilla...
	inc hl			;72fd
	ld d,(hl)			;72fe
	ld a,0c2h		;72ff   ; ...0xC2 y 0xC3
	ld (de),a			;7301
	inc a			;7302
	inc de			;7303
	ld (de),a			;7304
L_7305:
	ld hl,0eabch		;7305
	djnz L_72F7		;7308
	ret			;730a
figura_7:		; los 3 x 4 de 0xA772 (figura 7)
	ld a,(0ea20h)		;730b   ; con 0xEA20 (figura 7), los 3 x 4 de 0xA772 en 0xEA24
	or a			;730e
	ret z			;730f
	ld hl,0a772h		;7310
	ld de,(0ea24h)		;7313
	exx			;7317
	ld b,003h		;7318
L_731A:
	exx			;731a
	ldi		;731b   ; una fila de 4...
	ldi		;731d
	ldi		;731f
	ldi		;7321
	ld a,01ch		;7323   ; ...y la siguiente (28 mas alla)
	add a,e			;7325
	ld e,a			;7326
	jr nc,L_732A		;7327
	inc d			;7329
L_732A:
	exx			;732a
	djnz L_731A		;732b
	exx			;732d
	ret			;732e
escalera_ec08:		; la escalera de 0xEC08
	ld a,(0ec08h)		;732f   ; las escaleras de 0xEC08...
	or a			;7332
	ret z			;7333
	ld hl,(0ec0ah)		;7334
	ld a,(0ec09h)		;7337
	jr L_7347		;733a
escalera_ec00:		; la escalera de 0xEC00
	ld a,(0ec00h)		;733c   ; ...y 0xEC00: columnas de 0x9A 0x9B
	or a			;733f
	ret z			;7340
	ld hl,(0ec05h)		;7341
	ld a,(0ec03h)		;7344
L_7347:
	ld de,09a9bh		;7347
	ld bc,0001fh		;734a
L_734D:
	ld (hl),d			;734d   ; 0x9A 0x9B...
	inc l			;734e
	ld (hl),e			;734f
	add hl,bc			;7350   ; ...fila a fila
	dec a			;7351
	jr nz,L_734D		;7352
	ret			;7354
bloque_eac9:		; con 0xEAC9, 3 x 4 de 0xF0
	ld a,(0eac9h)		;7355   ; con 0xEAC9, 3 x 4 de 0xF0 en la fila 4, columna 28
	or a			;7358
	ret z			;7359
	ld hl,0ed9ch		;735a
	jr L_7367		;735d
bloque_eac0:		; con 0xEAC0, 3 x 4 de 0xF0
	ld a,(0eac0h)		;735f   ; con 0xEAC0, 3 x 4 de 0xF0 en 0xEAC2
	or a			;7362
	ret z			;7363
	ld hl,(0eac2h)		;7364
L_7367:
	ld de,0001ch		;7367
	ld c,003h		;736a
L_736C:
	ld b,004h		;736c
L_736E:
	ld (hl),0f0h		;736e   ; 4 x 0xF0...
	inc hl			;7370
	djnz L_736E		;7371
	add hl,de			;7373   ; ...y la fila siguiente
	dec c			;7374
	jr nz,L_736C		;7375
	ret			;7377
huecos_ec30_en_la_copia:		; los tres huecos de 0xEC30 en la copia de nombres
	ld hl,0ec30h		;7378   ; los tres huecos de 0xEC30 en la copia de nombres
	ld b,003h		;737b
L_737D:
	push bc			;737d
	push hl			;737e
	call hueco_ec30_a_la_copia		;737f   ; un hueco de 0xEC30...
	pop hl			;7382
	ld bc,00008h		;7383   ; ...y el siguiente (8 bytes)
	add hl,bc			;7386
	pop bc			;7387
	djnz L_737D		;7388
	ret			;738a
hueco_ec30_a_la_copia:		; los 2 x 2 de un hueco de 0xEC30 (0x73AF entero, 0x73B3 si no)
	ld a,(hl)			;738b   ; su casilla (bytes 4-5)...
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
	ld hl,073afh		;7396   ; ...2 x 2 de 0x73AF, o de 0x73B3 si el byte 1 no es 0
	or a			;7399
	jr z,L_739F		;739a
	ld hl,073b3h		;739c
L_739F:
	ldi		;739f   ; los dos de arriba...
	ldi		;73a1
	ld a,01eh		;73a3   ; ...y los dos de abajo
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


puerta_de_vuelta:		; la puerta de vuelta (0xE680) en 0xE684
	ld a,(0e680h)		;73b7   ; la puerta de vuelta (0xE680): 2 x 2 de 0x73D2 en 0xE684
	or a			;73ba
	ret z			;73bb
	ld de,(0e684h)		;73bc   ; la casilla de la puerta...
	ld hl,073d2h		;73c0   ; ...2 x 2 de 0x73D2...
	ldi		;73c3
	ldi		;73c5
	ex de,hl			;73c7
	ld bc,0001eh		;73c8   ; ...la fila de abajo
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


sprites_del_personaje:		; 15 sprites escondidos y la pose del personaje
	ld de,0ec80h		;73d6   ; 15 sprites escondidos y el personaje en los primeros
	ld b,00fh		;73d9
	call esconde_b_sprites		;73db   ; esconde_b_sprites: B sprites desde DE con y = 0xE0
	ld hl,0ec80h		;73de   ; apunta a la copia de la tabla de sprites (128 bytes)
	ld (0e60ah),hl		;73e1
pose_del_personaje:		; la pose 0xE502 (0xE53D en la pausa) de la tabla 0x7529
	ld hl,07529h		;73e4   ; la pose del personaje: tabla 0x7529...
	ld a,(0e000h)		;73e7   ; lee el ESTADO del juego
	cp 009h		;73ea
	ld a,(0e53dh)		;73ec   ; ...0xE53D en la pausa, 0xE502 si no...
	jr z,L_73F4		;73ef
	ld a,(0e502h)		;73f1   ; lee la pose del personaje
L_73F4:
	cp 0ffh		;73f4   ; ...0xFF: ninguna
	ret z			;73f6
	call 0414ch		;73f7   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld hl,(0e60ah)		;73fa
	ex de,hl			;73fd
	ld b,(hl)			;73fe   ; [cuantos] y [dy][dx][dibujo][color] cada sprite
	inc hl			;73ff
L_7400:
	ld a,(0e505h)		;7400   ; la y + dy - 1
	add a,(hl)			;7403
	dec a			;7404
	ld (de),a			;7405
	inc hl			;7406
	inc de			;7407
	ld a,(0e507h)		;7408   ; la x + dx
	add a,(hl)			;740b
	ld c,a			;740c
	ld a,b			;740d   ; el tercero se esconde con 0xE523
	cp 003h		;740e
	jr nz,L_741D		;7410
	ld a,(0e523h)		;7412   ; lee el tercer sprite escondido
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
	ld a,(hl)			;7421   ; el dibujo
	ld (de),a			;7422
	inc hl			;7423
	inc de			;7424
	ld a,(0e000h)		;7425   ; lee el ESTADO del juego
	cp 009h		;7428
	jr z,L_743A		;742a
	ld a,(0e500h)		;742c   ; al hundirse (4) o con 0xE533 = 1, parpadea
	cp 004h		;742f
	ld c,(hl)			;7431
	jr z,L_745C		;7432
	ld a,(0e533h)		;7434   ; lee parpadeando
	dec a			;7437
	jr z,L_745C		;7438
L_743A:
	ld a,b			;743a   ; el color: el segundo sprite (y el tercero en la pausa) siempre el de la tabla
	dec a			;743b
	dec a			;743c
	ld a,(hl)			;743d
	jr z,L_7456		;743e
	jp m,L_744B		;7440
	ld a,(0e000h)		;7443   ; lee el ESTADO del juego
	cp 009h		;7446
	ld a,(hl)			;7448
	jr z,L_7456		;7449
L_744B:
	push hl			;744b   ; Afrodita (bit 0 de 0xE501 a 0) lleva el 9
	ld hl,0e501h		;744c   ; apunta a quien juega (0 Afrodita)
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
	ld a,(0e604h)		;745c   ; parpadeo: cada dos cuadros el 6 (salvo el segundo sprite)
	bit 1,a		;745f
	jr nz,L_746A		;7461
	ld a,b			;7463
	cp 002h		;7464
	jr z,L_746A		;7466
	ld c,006h		;7468
L_746A:
	ld a,c			;746a
	jr L_7456		;746b
sprites_de_armas:		; los huecos de 0xE540 y 0xE5A0 a sus sprites
	ld ix,0e540h		;746d   ; los tres huecos de 0xE540 a los sprites de 0xEC8C
	ld b,003h		;7471
	ld de,0ec8ch		;7473
L_7476:
	push de			;7476
	call hueco_e540		;7477   ; hueco_e540: un hueco de 0xE540
	ld de,00020h		;747a
	add ix,de		;747d
	pop de			;747f
	inc e			;7480
	inc e			;7481
	inc e			;7482
	inc e			;7483
	djnz L_7476		;7484
	ld ix,0e5a0h		;7486   ; y los tres de 0xE5A0, tres sprites cada uno, desde 0xEC98
	ld b,003h		;748a
	ld de,0ec98h		;748c
L_748F:
	push de			;748f
	call tres_sprites		;7490   ; tres_sprites: tres sprites de la tabla 0x74D8/0x74E1
	ld de,00020h		;7493
	add ix,de		;7496
	ld de,0000ch		;7498
	pop hl			;749b
	add hl,de			;749c
	ex de,hl			;749d
	djnz L_748F		;749e
	ret			;74a0
tres_sprites:		; tres sprites de la tabla 0x74D8/0x74E1
	bit 2,(ix+002h)		;74a1   ; con el bit 2...
	jr nz,L_74AF		;74a5
	ld a,(ix+000h)		;74a7   ; ...o el tipo 5
	cp 005h		;74aa
	ret nz			;74ac
	jr $+103		;74ad
L_74AF:
	ld a,(0e604h)		;74af   ; tres sprites de la tabla 0x74D8 o 0x74E1 (bit 2 del contador)...
	ld hl,074d8h		;74b2
	bit 2,a		;74b5
	jr z,L_74BC		;74b7
	ld hl,074e1h		;74b9
L_74BC:
	ld c,003h		;74bc
L_74BE:
	ld a,(ix+005h)		;74be   ; ...[dy][dx][dibujo], color 15
	add a,(hl)			;74c1   ; + dy
	ld (de),a			;74c2
	inc de			;74c3
	inc hl			;74c4
	ld a,(ix+007h)		;74c5   ; la x...
	add a,(hl)			;74c8   ; ...+ dx
	ld (de),a			;74c9
	inc de			;74ca
	inc hl			;74cb
	ld a,(hl)			;74cc   ; el dibujo
	ld (de),a			;74cd
	inc de			;74ce
	ld a,00fh		;74cf   ; color 15
	ld (de),a			;74d1
	inc hl			;74d2
	inc de			;74d3
	dec c			;74d4   ; los tres
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


hueco_e540:		; un hueco de 0xE540
	bit 7,(ix+014h)		;74ea   ; un hueco de 0xE540: con el bit 7 de (ix+0x14) aparte
	jr nz,hueco_e540_sprite		;74ee
	ld a,(ix+000h)		;74f0
	and a			;74f3
	ret z			;74f4
	ld a,(ix+00ah)		;74f5   ; el caracter (ix+0x0A) en la casilla (ix+0x15)
	ld l,(ix+015h)		;74f8
	ld h,(ix+016h)		;74fb
	ld (hl),a			;74fe
	bit 0,(ix+010h)		;74ff   ; y el siguiente caracter (+1 o -1 segun el bit 0 de (ix+0x10)) al lado
	jr nz,L_7508		;7503
	inc a			;7505
	jr L_7509		;7506
L_7508:
	dec a			;7508
L_7509:
	inc hl			;7509
	ld (hl),a			;750a
	ret			;750b
hueco_e540_sprite:		; los tipos 1-4 de 0xE540 como un sprite
	ld a,(ix+000h)		;750c   ; con el bit 7 de (ix+0x14), los tipos 1-4 son un sprite
	and a			;750f
	ret z			;7510
	cp 005h		;7511
	ret nc			;7513
sprite_de_figura:		; [y][x][dibujo (ix+0x0A)][color (ix+0x0B)] en DE
	ld a,(ix+005h)		;7514   ; [y]...
	ld (de),a			;7517
	inc e			;7518
	ld a,(ix+007h)		;7519   ; ...[x]...
	ld (de),a			;751c
	inc e			;751d
	ld a,(ix+00ah)		;751e   ; ...[dibujo]...
	ld (de),a			;7521
	inc e			;7522
	ld a,(ix+00bh)		;7523   ; ...[color]
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


sprites_de_sala_en_sala:		; los sprites de las figuras de sala en sala de esta sala
	ld a,(0e614h)		;766c   ; las figuras de sala en sala de esta sala (0xE614 de ellas)...
	or a			;766f
	ret z			;7670
	exx			;7671
	ld b,a			;7672
	exx			;7673
	ld de,0ecf8h		;7674   ; ...sus sprites en 0xECF8 (o 0xECF0 con dos)
	dec a			;7677
	jr z,L_767C		;7678
	ld e,0f0h		;767a
L_767C:
	ld hl,0ec10h		;767c   ; la de 0xEC10...
	call dos_sprites_e4		;767f   ; dos_sprites_e4: dos sprites 0xE4 de color 15, uno al lado del otro
	jr nc,L_7688		;7682
	exx			;7684
	dec b			;7685
	exx			;7686
	ret z			;7687
L_7688:
	ld hl,0ec20h		;7688   ; ...y la de 0xEC20
	call dos_sprites_e4		;768b   ; dos_sprites_e4: dos sprites 0xE4 de color 15, uno al lado del otro
	jr nc,L_7694		;768e
	exx			;7690
	dec b			;7691
	exx			;7692
	ret z			;7693
L_7694:
	exx			;7694   ; y las que no estan, escondidas
	ld a,b			;7695
	exx			;7696
	add a,a			;7697
	ld b,a			;7698
	jp esconde_b_sprites		;7699   ; esconde_b_sprites: B sprites desde DE con y = 0xE0
dos_sprites_e4:		; dos sprites 0xE4 de color 15, uno al lado del otro
	ld a,(hl)			;769c   ; dos sprites 0xE4 de color 15, uno al lado del otro (x + 16)
	or a			;769d
	ret z			;769e
	ld a,005h		;769f   ; la y (byte 5)...
	add a,l			;76a1   ; HL al byte 5 de la ficha
	ld l,a			;76a2
	ld a,(hl)			;76a3
	dec a			;76a4
	ld (de),a			;76a5   ; ...- 1
	ld c,a			;76a6   ; C = la y
	inc e			;76a7
	inc l			;76a8   ; HL al byte 7
	inc l			;76a9
	ld a,(hl)			;76aa   ; la x (byte 7)...
	ld (de),a			;76ab
	add a,010h		;76ac   ; ...y la del de al lado
	ld b,a			;76ae   ; B = x + 16
	inc e			;76af
	ld a,0e4h		;76b0   ; dibujo 0xE4...
	ld (de),a			;76b2
	inc e			;76b3
	ld a,00fh		;76b4   ; ...color 15
	ld (de),a			;76b6
	inc e			;76b7
	ex de,hl			;76b8
	ld (hl),c			;76b9   ; el de la derecha, igual
	inc l			;76ba
	ld (hl),b			;76bb   ; [x + 16]
	inc l			;76bc
	ld (hl),0e4h		;76bd   ; [0xE4]
	inc l			;76bf
	ld (hl),00fh		;76c0   ; [15]
	inc l			;76c2
	ex de,hl			;76c3
	scf			;76c4   ; C: estaba
	ret			;76c5
guarda_lo_de_debajo:		; lo que hay debajo de cada figura, a 0xEB00
	ld de,0eb00h		;76c6   ; lo que hay debajo de las figuras, a 0xEB00
	call debajo_de_los_huecos		;76c9   ; debajo_de_los_huecos: lo de debajo de los 16 huecos de figura
	call debajo_del_castillo		;76cc   ; debajo_del_castillo: lo de debajo de las figuras del castillo
	call debajo_de_e540		;76cf   ; debajo_de_e540: lo de debajo de los huecos de 0xE540
	call debajo_de_la_cosa		;76d2   ; debajo_de_la_cosa: lo de debajo de la cosa de la sala
	jp debajo_del_jefe		;76d5   ; debajo_del_jefe: lo de debajo del jefe
debajo_de_los_huecos:		; lo de debajo de los 16 huecos de figura
	ld ix,0e800h		;76d8   ; los 16 huecos de figura
	exx			;76dc
	ld b,010h		;76dd
	ld de,00020h		;76df
L_76E2:
	exx			;76e2
	call debajo_de_figura		;76e3   ; debajo_de_figura: lo de debajo de una figura de caracteres
	exx			;76e6
	add ix,de		;76e7
	djnz L_76E2		;76e9
	exx			;76eb
	ret			;76ec
debajo_de_figura:		; lo de debajo de una figura de caracteres
	bit 7,(ix+002h)		;76ed   ; solo en pantalla y de caracteres (sin el bit 7 de la ficha)
	ret z			;76f1
	ld a,(ix+009h)		;76f2
	rla			;76f5
	ret c			;76f6
	rla			;76f7   ; bit 6: aparte
	jr c,L_7720		;76f8
	ld a,(ix+00ah)		;76fa   ; el tamaño del mosaico...
	call tamano_de_mosaico		;76fd   ; tamano_de_mosaico: C = ancho, B = alto del mosaico A (0x9D90)
	ld l,(ix+005h)		;7700   ; ...su casilla...
	ld h,(ix+007h)		;7703
	call 04da1h		;7706   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+012h),l		;7709
	ld (ix+013h),h		;770c
L_770F:
	push bc			;770f   ; ...y lo que hay debajo, fila a fila
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
	ld a,(ix+00bh)		;7720   ; los de bit 6, por el ancho: 0 una columna, 1 una fila, 6 un cuadro de 2 x 2
	or a			;7723
	jr z,L_773F		;7724   ; 0: una columna
	dec a			;7726
	jr z,L_7753		;7727   ; 1: una fila
	cp 006h		;7729   ; 6: 2 x 2
	ret nz			;772b
	ld l,(ix+012h)		;772c   ; de su casilla...
	ld h,(ix+013h)		;772f
	ldi		;7732
	ldi		;7734
	ld bc,0001eh		;7736   ; ...la fila de abajo
	add hl,bc			;7739
	ldi		;773a
	ldi		;773c
	ret			;773e
L_773F:
	ld l,(ix+012h)		;773f   ; una columna de (ix+0x14) + 1
	ld h,(ix+013h)		;7742
	ld a,(ix+014h)		;7745
	inc a			;7748
L_7749:
	ldi		;7749   ; una columna
	ld bc,0001fh		;774b   ; la fila de abajo
	add hl,bc			;774e
	dec a			;774f
	jr nz,L_7749		;7750
	ret			;7752
L_7753:
	ld l,(ix+012h)		;7753   ; una fila de (ix+0x1F)
	ld h,(ix+013h)		;7756
	ld c,(ix+01fh)		;7759
	ld b,000h		;775c
	ldir		;775e
	ret			;7760
debajo_de_e540:		; lo de debajo de los huecos de 0xE540
	ld ix,0e540h		;7761   ; los tres huecos de 0xE540
	exx			;7765
	ld b,003h		;7766
	ld de,00020h		;7768
L_776B:
	exx			;776b
	call debajo_de_un_e540		;776c   ; debajo_de_un_e540: lo de debajo de un hueco de 0xE540
	exx			;776f
	add ix,de		;7770
	djnz L_776B		;7772
	exx			;7774
	ret			;7775
debajo_de_un_e540:		; lo de debajo de un hueco de 0xE540
	ld a,(ix+000h)		;7776   ; los de caracteres (sin el bit 7 de (ix+0x14)): su casilla y dos caracteres
	or a			;7779
	ret z			;777a
	bit 7,(ix+014h)		;777b
	ret nz			;777f
	ld l,(ix+005h)		;7780
	ld h,(ix+007h)		;7783
	call 04da1h		;7786   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (ix+015h),l		;7789
	ld (ix+016h),h		;778c
	ldi		;778f
	ldi		;7791
	ret			;7793
debajo_de_la_cosa:		; lo de debajo de la cosa de la sala
	ld a,(0e740h)		;7794   ; la cosa de la sala: sus 2 x 2
	or a			;7797
	ret z			;7798
	ld hl,(0e744h)		;7799   ; lee la casilla de la cosa de la sala y el byte siguiente (16 bits)
	ldi		;779c
	ldi		;779e
	ld bc,0001eh		;77a0
	add hl,bc			;77a3
	ldi		;77a4
	ldi		;77a6
	ret			;77a8
debajo_del_jefe:		; lo de debajo del jefe
	ld a,(0e0d2h)		;77a9   ; el jefe
	or a			;77ac
	ret z			;77ad
	ld ix,0e700h		;77ae   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	ld a,(ix+000h)		;77b2   ; lee el tipo de la figura
	or a			;77b5
	ret z			;77b6
	bit 7,(ix+002h)		;77b7   ; mira el bit 7 de las banderas de la figura (bit 7: en pantalla)
	ret z			;77bb
	ld a,(ix+009h)		;77bc   ; lee la ficha del tipo (bit 7 sprites, bit 6, bit 4 filas de 0x1A)
	rla			;77bf
	rla			;77c0
	jr c,L_77CA		;77c1
	rla			;77c3
	jp nc,guarda_debajo		;77c4   ; guarda_debajo: guarda lo que tapa la figura de mosaico
	jp guarda_debajo_yx		;77c7   ; guarda_debajo_yx: guarda lo que tapa la figura, con su casilla desde la y y la x
L_77CA:
	ld b,005h		;77ca   ; de 5 x 14
	ld c,00eh		;77cc
	call casilla_y_ancho		;77ce   ; casilla_y_ancho: la casilla de la figura y las columnas que caben
	ld (ix+015h),c		;77d1
	ld (ix+014h),b		;77d4
	bit 4,(ix+009h)		;77d7
	jr z,L_77E0		;77db
	ld b,(ix+01ah)		;77dd
L_77E0:
	push bc			;77e0
	push hl			;77e1
	ld b,000h		;77e2
	ldir		;77e4   ; una fila de 14...
	pop hl			;77e6
	ld c,020h		;77e7   ; ...y la siguiente de 32
	add hl,bc			;77e9
	pop bc			;77ea
	djnz L_77E0		;77eb
	ret			;77ed
debajo_del_castillo:		; lo de debajo de las figuras del castillo
	call debajo_escalera_ec08		;77ee   ; las figuras del castillo: lo de debajo
	call debajo_escalera_ec00		;77f1   ; debajo_escalera_ec00: lo de debajo de la escalera de 0xEC00
	call debajo_bloque_eac0		;77f4   ; debajo_bloque_eac0: lo de debajo del bloque de 0xEAC0
	call debajo_de_las_puertas		;77f7   ; debajo_de_las_puertas: lo de debajo de las puertas de 0xEA00
	call debajo_figuras_2		;77fa   ; debajo_figuras_2: lo de debajo de las de 0xEA30
	call debajo_figura_3		;77fd   ; debajo_figura_3: lo de debajo de la de 0xEA50
	call debajo_figuras_4		;7800   ; debajo_figuras_4: lo de debajo de las de 0xEA60
	call debajo_eab0		;7803   ; debajo_eab0: lo de debajo de las de 0xEAB7
	call debajo_figura_7		;7806   ; debajo_figura_7: lo de debajo de la de 0xEA20
	call debajo_eaa0		;7809   ; debajo_eaa0: lo de debajo de la columna de 0xEAA0
	call debajo_bloque_eac9		;780c   ; debajo_bloque_eac9: lo de debajo del bloque de 0xEAC9
	ld a,(0eac8h)		;780f   ; con 0xEAC8, la fila 11 entera (16 casillas)
	or a			;7812
	ret z			;7813
	ld hl,0ee68h		;7814
	ld bc,00010h		;7817
	ldir		;781a
	ret			;781c
debajo_eaa0:		; lo de debajo de la columna de 0xEAA0
	ld hl,0eaa0h		;781d   ; la columna de 0xEAA0
	jr L_783A		;7820
debajo_de_las_puertas:		; lo de debajo de las puertas de 0xEA00
	ld ix,0ea00h		;7822   ; las dos puertas de 0xEA00
	exx			;7826
	ld b,002h		;7827
	ld de,00010h		;7829
L_782C:
	exx			;782c
	call debajo_de_columna		;782d   ; debajo_de_columna: lo de debajo de la columna de IX
	exx			;7830
	add ix,de		;7831
	djnz L_782C		;7833
	exx			;7835
	ret			;7836
debajo_de_columna:		; lo de debajo de la columna de IX
	push ix		;7837
	pop hl			;7839
L_783A:
	ld a,(hl)			;783a   ; si esta: su casilla desde la y y la x (bytes 2-3)...
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
	call 04da1h		;7846   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	inc de			;7849   ; ...a los bytes 5-6...
	inc de			;784a
	ld a,l			;784b
	ld (de),a			;784c
	inc de			;784d
	ld a,h			;784e
	ld (de),a			;784f
	dec de			;7850
	dec de			;7851
	ld a,(de)			;7852   ; ...y su columna de (byte 4) casillas
	pop de			;7853
	and a			;7854
	ret z			;7855
	ld b,a			;7856
L_7857:
	push bc			;7857   ; un caracter...
	ldi		;7858
	ld bc,0001fh		;785a   ; ...y el de debajo
	add hl,bc			;785d
	pop bc			;785e
	djnz L_7857		;785f
	ret			;7861
debajo_figuras_2:		; lo de debajo de las de 0xEA30
	ld ix,0ea30h		;7862   ; las dos de 0xEA30
	exx			;7866
	ld b,002h		;7867
	ld de,00010h		;7869
L_786C:
	exx			;786c
	call debajo_figura_2		;786d   ; debajo_figura_2: lo de debajo de una de 0xEA30
	exx			;7870
	add ix,de		;7871
	djnz L_786C		;7873
	exx			;7875
	ret			;7876
debajo_figura_2:		; lo de debajo de una de 0xEA30
	ld a,(ix+000h)		;7877   ; su casilla (bytes 2-3 a 6-7)...
	and a			;787a
	ret z			;787b
	push ix		;787c   ; HL = la ficha + 2...
	pop hl			;787e
	inc hl			;787f
	inc hl			;7880
	push de			;7881
	ex de,hl			;7882
	ld a,(de)			;7883   ; ...la y...
	ld l,a			;7884
	inc de			;7885
	ld a,(de)			;7886   ; ...la x
	ld h,a			;7887
	call 04da1h		;7888   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	inc de			;788b
	inc de			;788c
	inc de			;788d
	ld a,l			;788e   ; la casilla en los bytes 6-7
	ld (de),a			;788f
	inc de			;7890
	ld a,h			;7891
	ld (de),a			;7892
	push hl			;7893
	ld hl,078bah		;7894   ; ...su ancho y alto de la tabla 0x78BA a (ix+8) y (ix+9)...
	dec de			;7897
	dec de			;7898
	dec de			;7899   ; el dibujo (byte 4)
	ld a,(de)			;789a
	call 0414ch		;789b   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld b,d			;789e
	ld c,e			;789f
	ld (ix+008h),c		;78a0   ; ancho y alto a (ix+8) y (ix+9)
	ld (ix+009h),b		;78a3
	pop hl			;78a6
	pop de			;78a7
L_78A8:
	push bc			;78a8   ; ...y lo de debajo, fila a fila
	ld b,000h		;78a9
	ldir		;78ab   ; una fila...
	ld a,(ix+008h)		;78ad   ; ...y a la siguiente: 32 - ancho
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


debajo_figuras_4:		; lo de debajo de las de 0xEA60
	ld ix,0ea60h		;78c4   ; las cuatro de 0xEA60
	exx			;78c8
	ld b,004h		;78c9
	ld de,00010h		;78cb
L_78CE:
	exx			;78ce
	call debajo_figura_3_4		;78cf   ; debajo_figura_3_4: lo de debajo de una de 0xEA50/0xEA60
	exx			;78d2
	add ix,de		;78d3
	djnz L_78CE		;78d5
	exx			;78d7
	ret			;78d8
debajo_figura_3:		; lo de debajo de la de 0xEA50
	ld ix,0ea50h		;78d9   ; la de 0xEA50
debajo_figura_3_4:		; lo de debajo de una de 0xEA50/0xEA60
	push ix		;78dd
	pop hl			;78df
	ld a,(hl)			;78e0   ; si esta...
	and a			;78e1
	ret z			;78e2
	inc hl			;78e3
	inc hl			;78e4
	push de			;78e5
	ld e,(hl)			;78e6   ; la x (byte 2) y la y (byte 4), 8 mas arriba si el dibujo no es el 0...
	inc hl			;78e7
	inc hl			;78e8
	inc hl			;78e9
	ld a,(hl)			;78ea   ; ...el dibujo (byte 5)...
	dec hl			;78eb
	dec hl			;78ec
	ld c,a			;78ed
	and a			;78ee
	ld a,(hl)			;78ef   ; ...la y (byte 4)
	jr z,L_78F4		;78f0
	sub 008h		;78f2   ; 8 mas arriba
L_78F4:
	inc hl			;78f4
	ld (hl),a			;78f5
	ld d,a			;78f6
	ex de,hl			;78f7
	call 04da1h		;78f8   ; ...su casilla a los bytes 7-8
	ex de,hl			;78fb
	inc hl			;78fc
	inc hl			;78fd
	inc hl			;78fe
	ld (hl),e			;78ff
	inc hl			;7900
	ld (hl),d			;7901
	ex de,hl			;7902
	pop de			;7903
	ld a,c			;7904   ; 3 filas de 1 o de 3
	ld b,003h		;7905
	ld c,001h		;7907
	and a			;7909
	jr z,L_790E		;790a
	ld c,003h		;790c
L_790E:
	ld a,c			;790e
	push bc			;790f
	ld b,000h		;7910
	ldir		;7912   ; una fila de C...
	ld c,a			;7914   ; ...y a la siguiente
	ld a,020h		;7915
	sub c			;7917
	ld c,a			;7918
	add hl,bc			;7919
	pop bc			;791a
	djnz L_790E		;791b
	ret			;791d
debajo_eab0:		; lo de debajo de las de 0xEAB7
	ld hl,0eab0h		;791e   ; con 0xEAB0, las dos de 0xEAB7: su casilla y dos caracteres
	ld a,(hl)			;7921
	and a			;7922
	ret z			;7923
	ld hl,0eab7h		;7924
	exx			;7927
	ld b,002h		;7928
L_792A:
	exx			;792a
	ld c,(hl)			;792b   ; la y y la x...
	inc hl			;792c
	ld b,(hl)			;792d
	ld a,b			;792e   ; ...sin x, no esta
	and a			;792f
	jr z,L_7945		;7930
	push de			;7932
	ld e,c			;7933
	ld d,b			;7934
	ex de,hl			;7935
	call 04da1h		;7936   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ex de,hl			;7939
	inc hl			;793a   ; su casilla a la ficha
	ld (hl),e			;793b
	inc hl			;793c
	ld (hl),d			;793d
	pop hl			;793e
	ex de,hl			;793f
	ld bc,00002h		;7940   ; y sus dos caracteres de debajo
	ldir		;7943
L_7945:
	ld hl,0eabbh		;7945
	exx			;7948
	djnz L_792A		;7949
	exx			;794b
	ret			;794c
debajo_figura_7:		; lo de debajo de la de 0xEA20
	ld a,(0ea20h)		;794d   ; con 0xEA20: su casilla (0xEA24) y 3 x 4
	or a			;7950
	ret z			;7951
	ld hl,(0ea21h)		;7952
	call 04da1h		;7955   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (0ea24h),hl		;7958
	ld a,003h		;795b
L_795D:
	ldi		;795d   ; 4 caracteres...
	ldi		;795f
	ldi		;7961
	ldi		;7963
	ld bc,0001ch		;7965   ; ...y la fila siguiente
	add hl,bc			;7968
	dec a			;7969
	jr nz,L_795D		;796a
	ret			;796c
debajo_escalera_ec08:		; lo de debajo de la escalera de 0xEC08
	ld a,(0ec08h)		;796d   ; las escaleras de 0xEC08 y 0xEC00: columnas de 2
	or a			;7970
	ret z			;7971
	ld hl,(0ec0ah)		;7972
	ld a,(0ec09h)		;7975
	jr L_7985		;7978
debajo_escalera_ec00:		; lo de debajo de la escalera de 0xEC00
	ld a,(0ec00h)		;797a
	or a			;797d
	ret z			;797e
	ld hl,(0ec05h)		;797f
	ld a,(0ec03h)		;7982
L_7985:
	ldi		;7985   ; dos caracteres...
	ldi		;7987
	ld bc,0001eh		;7989   ; ...y la fila siguiente
	add hl,bc			;798c
	dec a			;798d
	jr nz,L_7985		;798e
	ret			;7990
debajo_bloque_eac9:		; lo de debajo del bloque de 0xEAC9
	ld a,(0eac9h)		;7991   ; los bloques de 0xEAC9 y 0xEAC0: 3 x 4
	or a			;7994
	ret z			;7995
	ld hl,0ed9ch		;7996
	jr L_79A3		;7999
debajo_bloque_eac0:		; lo de debajo del bloque de 0xEAC0
	ld a,(0eac0h)		;799b
	or a			;799e
	ret z			;799f
	ld hl,(0eac2h)		;79a0
L_79A3:
	ld a,003h		;79a3
L_79A5:
	ld bc,00004h		;79a5   ; 4 caracteres...
	ldir		;79a8
	ld bc,0001ch		;79aa   ; ...y la fila siguiente
	add hl,bc			;79ad
	dec a			;79ae
	jr nz,L_79A5		;79af
	ret			;79b1
debajo_ec30:		; lo de debajo de los huecos de 0xEC30
	ld hl,0ec30h		;79b2   ; los tres huecos de 0xEC30: 2 x 2 de su casilla
	ld b,003h		;79b5
L_79B7:
	push bc			;79b7
	push hl			;79b8
	call debajo_un_ec30		;79b9   ; debajo_un_ec30: lo de debajo de un hueco de 0xEC30
	pop hl			;79bc
	ld bc,00008h		;79bd
	add hl,bc			;79c0
	pop bc			;79c1
	djnz L_79B7		;79c2
	ret			;79c4
debajo_un_ec30:		; lo de debajo de un hueco de 0xEC30
	ld a,(hl)			;79c5   ; si esta...
	or a			;79c6
	ret z			;79c7
	ld a,l			;79c8   ; ...su casilla (bytes 4-5)...
	add a,004h		;79c9
	ld l,a			;79cb
	ld a,(hl)			;79cc
	inc l			;79cd
	ld h,(hl)			;79ce
	ld l,a			;79cf
	ldi		;79d0   ; ...y sus 2 x 2 de debajo
	ldi		;79d2
	ld bc,0001eh		;79d4
	add hl,bc			;79d7
	ldi		;79d8
	ldi		;79da
	ret			;79dc
repone_lo_de_debajo:		; vuelve a poner lo de 0xEB00 donde estaban las figuras
	ld hl,0eb00h		;79dd   ; vuelve a poner lo que habia debajo de las figuras (0xEB00)
	call repone_huecos		;79e0   ; repone_huecos: lo de debajo de los 16 huecos
	call repone_el_castillo		;79e3   ; repone_el_castillo: lo de 0xEB00 de vuelta en las figuras del castillo
	call repone_e540		;79e6   ; repone_e540: lo de debajo de los huecos de 0xE540
	call repone_la_cosa		;79e9   ; repone_la_cosa: lo de debajo de la cosa de la sala
	ld a,(0e0d2h)		;79ec   ; y debajo del jefe
	or a			;79ef
	ret z			;79f0
	ld (0e644h),hl		;79f1
repone_debajo_del_jefe:		; vuelve a poner lo de debajo del jefe
	ld hl,(0e644h)		;79f4
	ld ix,0e700h		;79f7   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	ld a,(0e700h)		;79fb   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	or a			;79fe
	ret z			;79ff
	bit 7,(ix+002h)		;7a00   ; mira el bit 7 de las banderas de la figura (bit 7: en pantalla)
	ret z			;7a04
	ld a,(0e709h)		;7a05   ; segun los bits 6 y 5 de 0xE709
	rla			;7a08
	rla			;7a09
	jr c,L_7A13		;7a0a
	rla			;7a0c
	jp nc,repone_debajo		;7a0d   ; repone_debajo: vuelve a poner lo que tapaba la figura
	jp repone_debajo_ancho		;7a10   ; repone_debajo_ancho: vuelve a poner lo que tapaba, con el ancho entero
L_7A13:
	ld c,00eh		;7a13   ; el de 5 x 14
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
	ldir		;7a2a   ; una fila de 14...
	pop de			;7a2c   ; ...y la siguiente de 32
	ex de,hl			;7a2d
	ld c,020h		;7a2e
	add hl,bc			;7a30
	ex de,hl			;7a31
	pop bc			;7a32
	djnz L_7A26		;7a33
	ret			;7a35
repone_huecos:		; lo de debajo de los 16 huecos
	ld ix,0e800h		;7a36   ; los 16 huecos de figura
	exx			;7a3a
	ld b,010h		;7a3b
	ld de,00020h		;7a3d
L_7A40:
	exx			;7a40
	call repone_hueco		;7a41   ; repone_hueco: lo de debajo de un hueco
	exx			;7a44
	add ix,de		;7a45
	djnz L_7A40		;7a47
	exx			;7a49
	ret			;7a4a
repone_hueco:		; lo de debajo de un hueco
	bit 7,(ix+002h)		;7a4b   ; en pantalla y de caracteres...
	ret z			;7a4f
	ld a,(ix+009h)		;7a50
	rla			;7a53
	ret c			;7a54
	rla			;7a55
	jr c,L_7A77		;7a56
	ld e,(ix+012h)		;7a58   ; ...el mosaico entero en su casilla
	ld d,(ix+013h)		;7a5b
	ld a,(ix+00ah)		;7a5e
	push hl			;7a61
	call tamano_de_mosaico		;7a62   ; tamano_de_mosaico: C = ancho, B = alto del mosaico A (0x9D90)
	pop hl			;7a65
L_7A66:
	push bc			;7a66
	ld b,000h		;7a67
	ldir		;7a69   ; una fila...
	pop bc			;7a6b
	ld a,020h		;7a6c   ; ...y la siguiente: 32 - ancho
	sub c			;7a6e
	add a,e			;7a6f
	ld e,a			;7a70
	jr nc,L_7A74		;7a71
	inc d			;7a73
L_7A74:
	djnz L_7A66		;7a74
	ret			;7a76
L_7A77:
	ld a,(ix+00bh)		;7a77   ; los de bit 6: columna, fila o 2 x 2
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
	call 0413bh		;7a8f   ; de_mas_a: DE += A
	ldi		;7a92
	ldi		;7a94
	ret			;7a96
L_7A97:
	ld e,(ix+012h)		;7a97
	ld d,(ix+013h)		;7a9a
	ld a,(ix+014h)		;7a9d
	inc a			;7aa0
L_7AA1:
	ldi		;7aa1   ; un caracter...
	ex de,hl			;7aa3
	ld bc,0001fh		;7aa4   ; ...y el de debajo
	add hl,bc			;7aa7
	ex de,hl			;7aa8
	dec a			;7aa9
	jr nz,L_7AA1		;7aaa
	ret			;7aac
L_7AAD:
	ld e,(ix+012h)		;7aad   ; una fila de (ix+0x1F) en su casilla
	ld d,(ix+013h)		;7ab0
	ld c,(ix+01fh)		;7ab3
	ld b,000h		;7ab6
	ldir		;7ab8
	ret			;7aba
repone_e540:		; lo de debajo de los huecos de 0xE540
	ld ix,0e540h		;7abb   ; los tres de 0xE540: dos caracteres
	exx			;7abf
	ld b,003h		;7ac0
	ld de,00020h		;7ac2
L_7AC5:
	exx			;7ac5
	call repone_un_e540		;7ac6   ; repone_un_e540: lo de debajo de un hueco de 0xE540
	exx			;7ac9
	add ix,de		;7aca
	djnz L_7AC5		;7acc
	exx			;7ace
	ret			;7acf
repone_un_e540:		; lo de debajo de un hueco de 0xE540
	ld a,(ix+000h)		;7ad0   ; si esta...
	or a			;7ad3
	ret z			;7ad4
	bit 7,(ix+014h)		;7ad5   ; ...y es de caracteres...
	ret nz			;7ad9
	ld e,(ix+015h)		;7ada   ; ...sus dos caracteres en su casilla
	ld d,(ix+016h)		;7add
	ldi		;7ae0
	ldi		;7ae2
	ret			;7ae4
repone_la_cosa:		; lo de debajo de la cosa de la sala
	ld a,(0e740h)		;7ae5   ; la cosa de la sala: 2 x 2
	or a			;7ae8
	ret z			;7ae9
	ld de,(0e744h)		;7aea   ; lee la casilla de la cosa de la sala y el byte siguiente (16 bits)
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
repone_el_castillo:		; lo de 0xEB00 de vuelta en las figuras del castillo
	call repone_escalera_ec08		;7afe   ; lo de 0xEB00 de vuelta en las figuras del castillo
	call repone_escalera_ec00		;7b01   ; repone_escalera_ec00: vuelve lo de la escalera de 0xEC00
	call repone_bloque_eac0		;7b04   ; repone_bloque_eac0: vuelve lo del bloque de 0xEAC0
	call repone_puertas		;7b07   ; repone_puertas: vuelve lo de las puertas de 0xEA00
	call repone_figuras_2		;7b0a   ; repone_figuras_2: vuelve lo de las de 0xEA30
	call repone_figura_3		;7b0d   ; repone_figura_3: vuelve lo de la de 0xEA50
	call repone_figuras_4		;7b10   ; repone_figuras_4: vuelve lo de las de 0xEA60
	call repone_eab0		;7b13   ; repone_eab0: vuelve lo de las de 0xEAB8
	call repone_figura_7		;7b16   ; repone_figura_7: vuelve lo de la de 0xEA20
	call repone_eaa0		;7b19   ; repone_eaa0: vuelve la columna de 0xEAA0
	call repone_bloque_eac9		;7b1c   ; repone_bloque_eac9: vuelve lo del bloque de 0xEAC9
	ld a,(0eac8h)		;7b1f   ; con 0xEAC8, la fila 11
	or a			;7b22
	ret z			;7b23
	ld de,0ee68h		;7b24
	ld bc,00010h		;7b27
	ldir		;7b2a
	ret			;7b2c
repone_eaa0:		; vuelve la columna de 0xEAA0
	ld de,0eaa0h		;7b2d
	jr L_7B4A		;7b30
repone_puertas:		; vuelve lo de las puertas de 0xEA00
	ld ix,0ea00h		;7b32   ; apunta a las puertas del castillo (figura 1, dos de 16 bytes)
	exx			;7b36
	ld b,002h		;7b37
	ld de,00010h		;7b39
L_7B3C:
	exx			;7b3c
	call repone_columna		;7b3d   ; repone_columna: vuelve lo de la columna de IX
	exx			;7b40
	add ix,de		;7b41
	djnz L_7B3C		;7b43
	exx			;7b45
	ret			;7b46
repone_columna:		; vuelve lo de la columna de IX
	push ix		;7b47
	pop de			;7b49
L_7B4A:
	ld a,(de)			;7b4a   ; si esta: su alto (byte 4) y su casilla (bytes 5-6)...
	and a			;7b4b
	ret z			;7b4c
	push hl			;7b4d   ; el alto (byte 4)...
	ex de,hl			;7b4e
	inc hl			;7b4f
	inc hl			;7b50
	inc hl			;7b51
	inc hl			;7b52
	ld a,(hl)			;7b53
	inc hl			;7b54
	ld e,(hl)			;7b55   ; ...y la casilla (bytes 5-6)
	inc hl			;7b56
	ld d,(hl)			;7b57
	pop hl			;7b58
	and a			;7b59   ; sin alto, nada
	ret z			;7b5a
	ld b,a			;7b5b
L_7B5C:
	push bc			;7b5c   ; ...en columna
	ldi		;7b5d
	ld bc,0001fh		;7b5f
	ex de,hl			;7b62
	add hl,bc			;7b63
	ex de,hl			;7b64
	pop bc			;7b65
	djnz L_7B5C		;7b66
	ret			;7b68
repone_figuras_2:		; vuelve lo de las de 0xEA30
	ld ix,0ea30h		;7b69
	exx			;7b6d
	ld b,002h		;7b6e
	ld de,00010h		;7b70
L_7B73:
	exx			;7b73
	call repone_figura_2		;7b74   ; repone_figura_2: vuelve lo de una de 0xEA30
	exx			;7b77
	add ix,de		;7b78
	djnz L_7B73		;7b7a
	exx			;7b7c
	ret			;7b7d
repone_figura_2:		; vuelve lo de una de 0xEA30
	ld a,(ix+000h)		;7b7e   ; su casilla (6-7), ancho y alto (8-9)...
	and a			;7b81
	ret z			;7b82
	ld e,(ix+006h)		;7b83
	ld d,(ix+007h)		;7b86
	ld c,(ix+008h)		;7b89
	ld b,(ix+009h)		;7b8c
L_7B8F:
	push bc			;7b8f   ; ...fila a fila
	ld b,000h		;7b90   ; una fila...
	ldir		;7b92
	ld a,(ix+008h)		;7b94   ; ...y a la siguiente: 32 - ancho
	ld c,a			;7b97
	ld a,020h		;7b98
	sub c			;7b9a
	ld c,a			;7b9b
	ex de,hl			;7b9c
	add hl,bc			;7b9d
	ex de,hl			;7b9e
	pop bc			;7b9f
	djnz L_7B8F		;7ba0   ; B filas
	ret			;7ba2
repone_figuras_4:		; vuelve lo de las de 0xEA60
	ld ix,0ea60h		;7ba3
	exx			;7ba7
	ld b,004h		;7ba8
	ld de,00010h		;7baa
L_7BAD:
	exx			;7bad
	call repone_figura_3_4		;7bae   ; repone_figura_3_4: vuelve lo de una de 0xEA50/0xEA60
	exx			;7bb1
	add ix,de		;7bb2
	djnz L_7BAD		;7bb4
	exx			;7bb6
	ret			;7bb7
repone_figura_3:		; vuelve lo de la de 0xEA50
	ld ix,0ea50h		;7bb8
repone_figura_3_4:		; vuelve lo de una de 0xEA50/0xEA60
	push ix		;7bbc   ; su dibujo (byte 5) y su casilla (7-8)...
	pop de			;7bbe
	ld a,(de)			;7bbf   ; si esta...
	and a			;7bc0
	ret z			;7bc1
	push hl			;7bc2
	ex de,hl			;7bc3
	inc hl			;7bc4
	inc hl			;7bc5
	inc hl			;7bc6
	inc hl			;7bc7
	inc hl			;7bc8
	ld a,(hl)			;7bc9   ; ...su dibujo (byte 5)...
	inc hl			;7bca
	inc hl			;7bcb
	ld e,(hl)			;7bcc   ; ...su casilla (bytes 7-8)
	inc hl			;7bcd
	ld d,(hl)			;7bce
	pop hl			;7bcf
	ld b,003h		;7bd0   ; ...3 filas de 1 o de 3
	ld c,001h		;7bd2
	and a			;7bd4   ; 3 filas de 1 con el dibujo 0, de 3 con los demas
	jr z,L_7BD9		;7bd5
	ld c,003h		;7bd7
L_7BD9:
	ld a,c			;7bd9
	push bc			;7bda
	ld b,000h		;7bdb   ; una fila de C...
	ldir		;7bdd
	ld c,a			;7bdf   ; ...y a la siguiente
	ld a,020h		;7be0
	sub c			;7be2
	ld c,a			;7be3
	ex de,hl			;7be4
	add hl,bc			;7be5
	ex de,hl			;7be6
	pop bc			;7be7
	djnz L_7BD9		;7be8   ; 3 filas
	ret			;7bea
repone_eab0:		; vuelve lo de las de 0xEAB8
	ld de,0eab0h		;7beb   ; con 0xEAB0, las dos de 0xEAB8: dos caracteres
	ld a,(de)			;7bee
	and a			;7bef
	ret z			;7bf0
	ld de,0eab8h		;7bf1
	exx			;7bf4
	ld b,002h		;7bf5
L_7BF7:
	exx			;7bf7
	ld a,(de)			;7bf8   ; si esta...
	and a			;7bf9
	jr z,L_7C09		;7bfa
	inc de			;7bfc
	ld a,(de)			;7bfd   ; ...su casilla...
	ld c,a			;7bfe
	inc de			;7bff
	ld a,(de)			;7c00
	ld b,a			;7c01
	ld e,c			;7c02
	ld d,b			;7c03
	ld bc,00002h		;7c04   ; ...y sus dos caracteres
	ldir		;7c07
L_7C09:
	ld de,0eabch		;7c09
	exx			;7c0c
	djnz L_7BF7		;7c0d
	exx			;7c0f
	ret			;7c10
repone_figura_7:		; vuelve lo de la de 0xEA20
	ld a,(0ea20h)		;7c11   ; con 0xEA20, 3 x 4
	or a			;7c14
	ret z			;7c15
	ld de,(0ea24h)		;7c16
	exx			;7c1a
	ld b,003h		;7c1b
L_7C1D:
	exx			;7c1d
	ldi		;7c1e   ; una fila de 4...
	ldi		;7c20
	ldi		;7c22
	ldi		;7c24
	ld a,01ch		;7c26   ; ...y la siguiente
	add a,e			;7c28
	ld e,a			;7c29
	jr nc,L_7C2D		;7c2a
	inc d			;7c2c
L_7C2D:
	exx			;7c2d
	djnz L_7C1D		;7c2e
	exx			;7c30
	ret			;7c31
repone_escalera_ec08:		; vuelve lo de la escalera de 0xEC08
	ld a,(0ec08h)		;7c32   ; con la escalera de 0xEC08...
	or a			;7c35
	ret z			;7c36
	ld de,(0ec0ah)		;7c37   ; ...su casilla y su alto
	ld a,(0ec09h)		;7c3b
	jr L_7C4C		;7c3e
repone_escalera_ec00:		; vuelve lo de la escalera de 0xEC00
	ld a,(0ec00h)		;7c40
	or a			;7c43
	ret z			;7c44
	ld de,(0ec05h)		;7c45
	ld a,(0ec03h)		;7c49
L_7C4C:
	ldi		;7c4c   ; columnas de 2
	ldi		;7c4e
	ld bc,0001eh		;7c50
	ex de,hl			;7c53
	add hl,bc			;7c54
	ex de,hl			;7c55
	dec a			;7c56
	jr nz,L_7C4C		;7c57
	ret			;7c59
repone_bloque_eac9:		; vuelve lo del bloque de 0xEAC9
	ld a,(0eac9h)		;7c5a
	or a			;7c5d
	ret z			;7c5e
	ld de,0ed9ch		;7c5f
	jr L_7C6D		;7c62
repone_bloque_eac0:		; vuelve lo del bloque de 0xEAC0
	ld a,(0eac0h)		;7c64
	or a			;7c67
	ret z			;7c68
	ld de,(0eac2h)		;7c69
L_7C6D:
	ld a,003h		;7c6d   ; 3 filas de 4
L_7C6F:
	ld bc,00004h		;7c6f   ; 4 caracteres...
	ldir		;7c72
	ld bc,0001ch		;7c74   ; ...y la fila siguiente
	ex de,hl			;7c77
	add hl,bc			;7c78
	ex de,hl			;7c79
	dec a			;7c7a
	jr nz,L_7C6F		;7c7b
	ret			;7c7d
repone_ec30:		; vuelve lo de los huecos de 0xEC30
	ld ix,0ec30h		;7c7e   ; los tres huecos de 0xEC30: 2 x 2 en su casilla
	exx			;7c82
	ld de,00008h		;7c83
	ld b,003h		;7c86
L_7C88:
	exx			;7c88
	call repone_un_ec30		;7c89   ; repone_un_ec30: vuelve lo de un hueco de 0xEC30
	exx			;7c8c
	add ix,de		;7c8d
	djnz L_7C88		;7c8f
	exx			;7c91
	ret			;7c92
repone_un_ec30:		; vuelve lo de un hueco de 0xEC30
	ld a,(ix+000h)		;7c93   ; si esta...
	or a			;7c96
	ret z			;7c97
	ld e,(ix+004h)		;7c98   ; ...su casilla...
	ld d,(ix+005h)		;7c9b
	ldi		;7c9e   ; ...2 de arriba...
	ldi		;7ca0
	ld a,01eh		;7ca2   ; ...y 2 de abajo
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


empieza_demostracion:		; la demostracion 0xE023 (tabla 0x7DD9; se usan la 0 y la 1)
	ld hl,(0e022h)		;7d82   ; la demostracion: una partida nueva...
	exx			;7d85
	call 04cb0h		;7d86   ; partida_nueva: RAM a cero, sala 1 del castillo, Popolon y las vidas de 0x4CE6
	exx			;7d89
	ld (0e022h),hl		;7d8a   ; guarda la tecla de la demostracion (0xFF acaba) y el byte siguiente (16 bits)
	ld a,(0e023h)		;7d8d   ; ...en la sala de 0x7DD9 de la demostracion 0xE023 (se usan la 0 y la 1)...
	ld hl,07dd9h		;7d90
	call 0414ch		;7d93   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld (0e041h),de		;7d96   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
	xor a			;7d9a
	ld (0e604h),a		;7d9b   ; guarda el contador de cuadros de partida
	call 0510bh		;7d9e   ; ...montada...
	ld a,001h		;7da1   ; ...con el arma 1 y 100 flechas
	ld (0e070h),a		;7da3   ; guarda tiene el objeto 0x01
	ld (0e510h),a		;7da6   ; guarda el arma elegida
	ld hl,00100h		;7da9
	ld (0e046h),hl		;7dac   ; guarda las flechas (BCD, 16 bits)
	call cabecera		;7daf   ; cabecera: los rotulos, flechas, monedas, llaves, arma y las cuatro barras
	ld a,(0e023h)		;7db2   ; lo que dura: tabla 0x7DE3
	ld hl,07de3h		;7db5
	call 04155h		;7db8   ; byte_de_tabla: A = el byte HL + A
	ld (0e033h),a		;7dbb   ; guarda lo que queda de demostracion (de 32 en 32 cuadros)
	ld a,(0e00dh)		;7dbe   ; con musica si no esta callada
	or a			;7dc1
	jr nz,L_7DCA		;7dc2
	call 05d1ah		;7dc4   ; musica_del_mapa: A = 0x88 en el castillo, 0x8A en los mundos
	call 05cafh		;7dc7   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
L_7DCA:
	xor a			;7dca   ; 0xE01A y 0xE00B a 0; en juego; 0xE00C = 1
	ld (0e01ah),a		;7dcb   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	ld (0e00bh),a		;7dce
	inc a			;7dd1
	ld (0e019h),a		;7dd2   ; guarda en juego (a 0 se acaba la vida: estado 6)
	ld (0e00ch),a		;7dd5   ; guarda los cuadros que quedan a la tecla de la demostracion
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


cuadro_de_demostracion:		; un cuadro de la demostracion
	call 05488h		;7de8   ; un cuadro de la demostracion: los sprites y la partida...
	call 052f5h		;7deb   ; cuadro_de_partida: un cuadro de la partida: todas las rutinas de cada banco
	ld a,(0e604h)		;7dee   ; ...cada 32 cuadros baja lo que queda (0xE033)...
	and 01fh		;7df1
	jr nz,L_7E04		;7df3
	ld hl,0e033h		;7df5   ; apunta a lo que queda de demostracion (de 32 en 32 cuadros)
	ld a,(hl)			;7df8
	or a			;7df9
	jr z,L_7E04		;7dfa
	dec (hl)			;7dfc
	jr nz,L_7E04		;7dfd
	ld a,0ffh		;7dff   ; ...a cero se apaga la musica
	call 04e1fh		;7e01   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_7E04:
	ld a,(0e01ah)		;7e04   ; al salir por un lado...
	and a			;7e07
	ret z			;7e08
	call 04d38h		;7e09   ; ...la sala vecina, montada
	call 04d47h		;7e0c   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	ld a,020h		;7e0f
	ld (0e004h),a		;7e11   ; guarda la espera del paso, en cuadros
	call 04792h		;7e14   ; vecina_del_lado: A = la vecina 0xE647 + 0xE01A
	ld (0e042h),a		;7e17   ; guarda la sala
	call 051cdh		;7e1a   ; monta_otra_sala: la sala al pasar a otra
	xor a			;7e1d
	ld (0e01ah),a		;7e1e   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	ret			;7e21
teclas_de_demostracion:		; las teclas grabadas de la demostracion (0xBAFD, banco 15)
	ld hl,0e00ch		;7e22   ; las teclas de la demostracion: cuenta 0xE00C...
	dec (hl)			;7e25
	jr z,L_7E35		;7e26
L_7E28:
	ld a,(0e022h)		;7e28   ; ...la tecla 0xE022 hace de mando (0xFF acaba la demostracion)
	cp 0ffh		;7e2b
	jp nz,04c6bh		;7e2d
	xor a			;7e30
	ld (0e019h),a		;7e31   ; guarda en juego (a 0 se acaba la vida: estado 6)
	ret			;7e34
L_7E35:
	dec hl			;7e35   ; la pareja siguiente de la tabla 0xBAFD (banco 15) de la demostracion...
	ld c,(hl)			;7e36
	inc (hl)			;7e37
	call 04241h		;7e38   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	ld hl,0bafdh		;7e3b
	ld a,(0e023h)		;7e3e   ; lee la demostracion que toca (0 o 1)
	call 0414ch		;7e41   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld l,c			;7e44
	ld h,000h		;7e45
	add hl,hl			;7e47
	add hl,de			;7e48
	ld a,(hl)			;7e49   ; ...[cuadros][teclas]
	ld (0e00ch),a		;7e4a   ; guarda los cuadros que quedan a la tecla de la demostracion
	inc hl			;7e4d
	ld a,(hl)			;7e4e
	ld (0e022h),a		;7e4f   ; guarda la tecla de la demostracion (0xFF acaba)
	call 04215h		;7e52   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	jr L_7E28		;7e55
mira_zeus:		; en la pausa de F2 y en la sala 1 del castillo, cuenta las letras de ZEUS
	ld hl,(0e041h)		;7e57   ; solo en la sala 1 del castillo
	ld de,00101h		;7e5a
	rst 20h			;7e5d
	ret nz			;7e5e
	call 09c13h		;7e5f   ; la tecla...
	ld hl,0e02ah		;7e62
	ld c,(hl)			;7e65
	ld (hl),a			;7e66   ; ...recien apretada...
	xor c			;7e67
	and (hl)			;7e68
	ret z			;7e69
	ld b,a			;7e6a
	ld de,07e88h		;7e6b   ; ...comparada con la letra que toca de ZEUS (0x7E88)
	ld hl,0e028h		;7e6e   ; apunta a las letras de ZEUS acertadas
	ld a,(hl)			;7e71
	call 0413bh		;7e72   ; de_mas_a: DE += A
	ld a,(de)			;7e75
	cp b			;7e76
	jr z,L_7E7C		;7e77
	ld (hl),000h		;7e79   ; una que no va: vuelta a empezar
	ret			;7e7b
L_7E7C:
	inc (hl)			;7e7c   ; las cuatro: ZEUS tecleado
	ld a,(hl)			;7e7d
	cp 004h		;7e7e
	ret c			;7e80
	xor a			;7e81
	ld (hl),a			;7e82
	inc a			;7e83
	ld (0e027h),a		;7e84   ; guarda ZEUS tecleado
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


sigue_con_f5:		; con ZEUS y F5, la partida sigue (una vez)
	ld a,(0e026h)		;7e8c   ; al acabar la partida, una sola vez...
	and a			;7e8f
	ret nz			;7e90
	ld a,(0e027h)		;7e91   ; ...con ZEUS...
	and a			;7e94
	ret z			;7e95
	call tecla_f5		;7e96   ; ...y F5...
	ret nc			;7e99
	ld de,07ecfh		;7e9a   ; ...se borra F5 CONTINUE...
	call 05c3ch		;7e9d   ; borra_lista_vram: como lista_a_vram pero escribiendo ceros
	xor a			;7ea0   ; ...sin experiencia ni pendientes...
	ld h,a			;7ea1
	ld l,a			;7ea2
	ld (0e050h),a		;7ea3   ; guarda la experiencia de Afrodita (barra)
	ld (0e05eh),a		;7ea6   ; guarda el cambio de vida pendiente de Afrodita (con signo)
	ld (0e054h),a		;7ea9   ; guarda la experiencia de Popolon (barra)
	ld (0e061h),a		;7eac   ; guarda el cambio de vida pendiente de Popolon (con signo)
	ld (0e05ch),hl		;7eaf   ; guarda la experiencia de Afrodita
	ld (0e05fh),hl		;7eb2   ; guarda la experiencia de Popolon
	ld (0e059h),a		;7eb5   ; ...una vida para Afrodita y ninguna para Popolon...
	inc a			;7eb8
	ld (0e058h),a		;7eb9   ; guarda las vidas de Afrodita (BCD)
	ld (0e501h),a		;7ebc   ; ...y la vida llena
	ld (0e026h),a		;7ebf   ; guarda ya se ha seguido con F5
	ld a,(0e053h)		;7ec2   ; lee el tope de la vida de Afrodita
	ld (0e052h),a		;7ec5   ; guarda la vida de Afrodita
	ld a,(0e057h)		;7ec8   ; lee el tope de la vida de Popolon
	ld (0e056h),a		;7ecb   ; guarda la vida de Popolon
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


f5_una_vez:		; C la primera vez que se aprieta F5
	call tecla_f5		;7edd   ; F5 en la demostracion: C la primera vez que se aprieta (0xE032)
	jr c,L_7EE7		;7ee0
	xor a			;7ee2
	ld (0e032h),a		;7ee3   ; guarda F5 ya apretada
	ret			;7ee6
L_7EE7:
	ld hl,0e032h		;7ee7   ; apunta a F5 ya apretada
	ld a,(hl)			;7eea
	or a			;7eeb
	ret nz			;7eec
	ld (hl),001h		;7eed
	scf			;7eef
	ret			;7ef0
tecla_f5:		; C si F5 esta apretada (fila 7 de la matriz)
	ld a,007h		;7ef1   ; la fila 7 del teclado: el bit 1 es F5
	call 00141h		;7ef3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;7ef6
	and 002h		;7ef7
	ret z			;7ef9
	scf			;7efa
	ret			;7efb
jefe_cada_cuadro:		; el jefe: humo, salida y lo de su tipo
	ld hl,0e0d2h		;7efc   ; el jefe cada cuadro: 0xE0D2 = 1...
	ld a,(hl)			;7eff
	or a			;7f00
	ret z			;7f01
	dec a			;7f02
	jp z,empieza_el_humo		;7f03   ; empieza_el_humo: 0xE0D2 = 2, 0x41 cuadros de humo y la musica 0x90
	sub 002h		;7f06   ; ...2, el humo...
	jp m,humo		;7f08   ; humo: una nube cada 8 cuadros en los sitios de 0x8003
	jr z,$+75		;7f0b
	ld ix,0e700h		;7f0d   ; ...4, en pie: p06:B3E7 y p06:B3F7
	call 04220h		;7f11   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b3e7h		;7f14   ; para_con_escudo: C si el personaje quieto para el disparo mirando hacia el (sonido 0x1D)
	call 0b3f7h		;7f17
	call 04215h		;7f1a   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e0d5h)		;7f1d   ; mientras 0xE0D5, nada mas
	or a			;7f20
	ret nz			;7f21
	call lo_del_jefe		;7f22   ; lo de su tipo
	ld a,(0e700h)		;7f25   ; lee el tipo del jefe (el hueco 0xE700 es el jefe)
	or a			;7f28
	ret z			;7f29
	bit 4,(ix+002h)		;7f2a   ; con el bit 4, p06:B0ED
	ret z			;7f2e
	call 04220h		;7f2f   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b0edh		;7f32
	jp 04215h		;7f35   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
lo_del_jefe:		; la rutina del tipo de jefe (tabla 0x7F40)
	ld a,(0e700h)		;7f38   ; por el tipo del jefe (tabla que sigue)
	dec a			;7f3b
	ret m			;7f3c
	call 04140h		;7f3d   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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


sale_el_jefe:		; el jefe sale: tipo, vida (0x7F97, a la mitad con el objeto 0x07)
	inc (hl)			;7f56   ; 3: el jefe sale: su tipo...
	inc l			;7f57
	ld a,(hl)			;7f58
	ld (0e700h),a		;7f59   ; guarda el tipo del jefe (el hueco 0xE700 es el jefe)
	ld hl,07f97h		;7f5c   ; ...su vida de la tabla 0x7F97...
	call 04155h		;7f5f   ; byte_de_tabla: A = el byte HL + A
	ld b,a			;7f62
	ld a,(0e076h)		;7f63   ; ...a la mitad con el objeto 0x07 del mundo...
	or a			;7f66
	ld a,b			;7f67
	jr z,L_7F6C		;7f68
	srl a		;7f6a
L_7F6C:
	ld (0e710h),a		;7f6c   ; ...en (ix+0x10)
	ld ix,0e700h		;7f6f   ; apunta a el tipo del jefe (el hueco 0xE700 es el jefe)
	ld (ix+001h),000h		;7f73   ; paso 0 y banderas 0xF0
	ld (ix+002h),0f0h		;7f77   ; las banderas de la figura (bit 7: en pantalla) = 0xF0
	ld a,(0e700h)		;7f7b   ; y lo de entrar de su tipo
	dec a			;7f7e
	call 04140h		;7f7f   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call 04220h		;7fa3   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b13eh		;7fa6
	jp 04215h		;7fa9   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
L_7FAC:
	call 04220h		;7fac   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b15fh		;7faf
	jp 04215h		;7fb2   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
L_7FB5:
	call 04220h		;7fb5   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b137h		;7fb8
	jp 04215h		;7fbb   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
L_7FBE:
	call 04220h		;7fbe   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b145h		;7fc1
	jp 04215h		;7fc4   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
L_7FC7:
	call 04220h		;7fc7   ; a000_banco_6: pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	call 0b14ch		;7fca
	jp 04215h		;7fcd   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
empieza_el_humo:		; 0xE0D2 = 2, 0x41 cuadros de humo y la musica 0x90
	inc (hl)			;7fd0   ; 1: a 2, 0x41 cuadros de humo y la musica 0x90
	ld a,041h		;7fd1
	ld (0e640h),a		;7fd3   ; guarda los cuadros de humo del jefe
	ld a,090h		;7fd6
	jp 05cc4h		;7fd8   ; musica_ya: sin musica esperando, la musica A
humo:		; una nube cada 8 cuadros en los sitios de 0x8003
	ld hl,0e640h		;7fdb   ; 2: el humo...
	ld a,(hl)			;7fde
	or a			;7fdf
	jr z,L_7FF9		;7fe0
	dec (hl)			;7fe2   ; ...cada 8 cuadros...
	ld a,(hl)			;7fe3
	and 007h		;7fe4
	ret nz			;7fe6
	ld hl,0e643h		;7fe7   ; ...una nube (figura 0x63) en uno de los 8 sitios de 0x8003
	inc (hl)			;7fea
	ld a,(hl)			;7feb
	and 007h		;7fec
	ld hl,08003h		;7fee
	call 0414ch		;7ff1   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
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
