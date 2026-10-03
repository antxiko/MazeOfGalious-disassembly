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
	jp despacha		;4050   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call
L_4053:
	jp palabra_de_tabla		;4053   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
L_4056:
	jp casilla_de_yx		;4056   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
L_4059:
	jp pide_sonido		;4059   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_405C:
	jp hl_negado		;405c   ; hl_negado: HL = -HL
L_405F:
	jp bajo_la_figura		;405f   ; bajo_la_figura: C si el caracter de debajo de la figura IX o su derecha pasa de 0xB9
L_4062:
	jp hl_mas_a		;4062   ; hl_mas_a: HL += A
L_4065:
	jp de_mas_a		;4065   ; de_mas_a: DE += A
L_4068:
	jp de_negado		;4068   ; de_negado: DE = -DE
L_406B:
	jp multiplica		;406b   ; multiplica: HL = H x E
L_406E:
	jp casilla_b9		;406e   ; casilla_b9: C si el caracter de la casilla de HL pasa de 0xB9
L_4071:
	jp casilla_derecha		;4071   ; casilla_derecha: compara 0xB9 con el caracter de HL + 1
L_4074:
	jp pared_en_fila		;4074   ; pared_en_fila: C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
L_4077:
	jp pared_en_columna		;4077   ; pared_en_columna: C si una de las casillas (x+B) o (y+D) llega al umbral de 0xF020
L_407A:
	jp pared_en		;407a   ; pared_en: C si la casilla (y+E) llega al umbral de 0xF020
L_407D:
	jp L_424C		;407d
L_4080:
	jp musica_ya		;4080   ; musica_ya: sin musica esperando, la musica A
L_4083:
	jp byte_de_tabla		;4083   ; byte_de_tabla: A = el byte HL + A
L_4086:
	jp musica_espera		;4086   ; musica_espera: deja esperando la musica A
L_4089:
	jp tiene_o_popolon		;4089   ; tiene_o_popolon: NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)
L_408C:
	jp pinta_llaves		;408c   ; pinta_llaves: las llaves en la fila 2, columna 24
L_408F:
	jp 06d49h		;408f
L_4092:
	jp L_4269		;4092
init:		; el arranque del cartucho: slot, H.KEYI, RAM a cero, y a esperar la interrupcion
	di			;4095   ; el arranque del cartucho: sin interrupciones y en modo 1
	im 1		;4096
	call slot_del_cartucho		;4098   ; C = el slot del cartucho en la pagina 1
	ld h,080h		;409b   ; y lo mismo en la pagina 2 (0x8000-0xBFFF)
	call 00024h		;409d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,0c3h		;40a0   ; H.KEYI (0xFD9A) = jp 0x40EF: todo el juego va por la interrupcion
	ld (0fd9ah),a		;40a2
	ld hl,interrupcion		;40a5
	ld (0fd9bh),hl		;40a8
	ld sp,0f0f0h		;40ab   ; la pila, debajo de 0xF0F0
	ld hl,0e000h		;40ae   ; apunta a el ESTADO del juego
	ld de,0e001h		;40b1   ; apunta a el paso del estado
	ld bc,010efh		;40b4   ; borra la RAM del juego, 0xE000-0xF0EF
	ld (hl),000h		;40b7
	ldir		;40b9
	ld a,001h		;40bb   ; el semaforo del juego puesto mientras se prepara
	ld (0e005h),a		;40bd   ; guarda el semaforo del juego (1 mientras va el juego del cuadro)
	call vram_a_cero		;40c0   ; vram_a_cero: el sonido desde cero, la VRAM a 0 y los registros del VDP
	call mira_las_ranuras		;40c3   ; mira_las_ranuras: busca en todos los slots y subslots las firmas de busca_cartuchos
	call bancos_1_2_3		;40c6   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	xor a			;40c9
	ld (0e005h),a		;40ca   ; guarda el semaforo del juego (1 mientras va el juego del cuadro)
	call 0013eh		;40cd   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP (suelta una interrupcion pendiente)
	ei			;40d0
L_40D1:
	jr L_40D1		;40d1   ; y aqui se queda para siempre: lo demas pasa en la interrupcion
slot_del_cartucho:		; A = el slot de la pagina 1 para ENASLT (con el bit 7 y el subslot si esta expandido)
	call 00138h		;40d3   ; BIOS RSLREG - Reads the primary slot register | A = el registro de slots primarios
	rrca			;40d6
	rrca			;40d7
	and 003h		;40d8   ; el slot primario de la pagina 1
	ld c,a			;40da
	ld b,000h		;40db
	ld hl,0fcc1h		;40dd   ; EXPTBL (0xFCC1): el bit 7 dice si el slot esta expandido
	add hl,bc			;40e0
	ld a,(hl)			;40e1
	and 080h		;40e2
	or c			;40e4   ; C = slot primario y bit de expandido
	ld c,a			;40e5
	inc hl			;40e6
	inc hl			;40e7
	inc hl			;40e8
	inc hl			;40e9   ; SLTTBL (0xFCC5): el subslot de cada pagina
	ld a,(hl)			;40ea
	and 00ch		;40eb   ; los bits 2-3, el subslot de la pagina 1
	or c			;40ed
	ret			;40ee
interrupcion:		; H.KEYI, cada cuadro: el sonido (bancos 13 y 14) y el juego (p00:4277)
	call 0013eh		;40ef   ; BIOS RDVDP - Reads VDP status register | cada cuadro: lee el estado del VDP (suelta la interrupcion)
	di			;40f2
	ld hl,0e006h		;40f3   ; apunta a el semaforo de la interrupcion
	ld a,(hl)			;40f6   ; 0xE006 a 1 mientras dura; si ya lo estaba, es una interrupcion dentro de otra
	and a			;40f7
	ld (hl),001h		;40f8
	jp nz,L_4131		;40fa   ; y entonces solo suelta el VDP
	call vram_del_estado		;40fd   ; vram_del_estado: lo de la VRAM en la interrupcion segun el estado (tabla 0x543B)
	di			;4100
	ld a,00dh		;4101   ; el sonido: bancos 13 y 14 en 0x6000 y 0x8000
	ld (06000h),a		;4103   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4106
	ld (08000h),a		;4107   ; el mapper: pone en 0x8000 el banco de A
	call 06004h		;410a   ; el reproductor del banco 13
	xor a			;410d
	ld (0e006h),a		;410e   ; guarda el semaforo de la interrupcion
	di			;4111
	ld a,(0f0f1h)		;4112   ; vuelven los bancos que habia, de sus copias
	ld (06000h),a		;4115   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f2h)		;4118   ; lee la copia del banco de 0x8000
	ld (08000h),a		;411b   ; el mapper: pone en 0x8000 el banco de A
	call musica_que_espera		;411e   ; musica_que_espera: pide la musica de 0xE01E cuando acaba lo que suena
	ld hl,0e005h		;4121   ; 0xE005 a 1 mientras va el juego del cuadro
	ld a,(hl)			;4124
	or a			;4125
	jr nz,L_4131		;4126   ; si el del cuadro anterior no ha acabado, este se salta
	inc (hl)			;4128
	ei			;4129   ; el juego deja entrar la interrupcion siguiente (el sonido no se pierde)
	call juego_del_cuadro		;412a   ; el juego del cuadro
	xor a			;412d
	ld (0e005h),a		;412e   ; guarda el semaforo del juego (1 mientras va el juego del cuadro)
L_4131:
	call 0013eh		;4131   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP para soltar la interrupcion
	ei			;4134
	ret			;4135
hl_mas_a:		; HL += A
	add a,l			;4136
	ld l,a			;4137
	ret nc			;4138
	inc h			;4139
	ret			;413a
de_mas_a:		; DE += A
	add a,e			;413b
	ld e,a			;413c
	ret nc			;413d
	inc d			;413e
	ret			;413f
despacha:		; salta a la entrada A de la tabla de palabras que va detras del call
	pop hl			;4140   ; la direccion de vuelta es la tabla: HL + 2 x A...
	add a,a			;4141
	add a,l			;4142
	ld l,a			;4143
	jr nc,L_4147		;4144
	inc h			;4146
L_4147:
	ld a,(hl)			;4147   ; ...y salta a lo que diga
	inc hl			;4148
	ld h,(hl)			;4149
	ld l,a			;414a
	jp (hl)			;414b
palabra_de_tabla:		; DE = la palabra A de la tabla de HL
	add a,a			;414c   ; DE = HL + 2 x A...
	ld e,a			;414d
	ld d,000h		;414e
	add hl,de			;4150
	ld e,(hl)			;4151   ; ...y lo que hay ahi
	inc hl			;4152
	ld d,(hl)			;4153
	ret			;4154
byte_de_tabla:		; A = el byte HL + A
	add a,l			;4155
	ld l,a			;4156
	jr nc,L_415A		;4157
	inc h			;4159
L_415A:
	ld a,(hl)			;415a
	ret			;415b
de_negado:		; DE = -DE
	ld a,e			;415c   ; DE = -DE: complemento...
	cpl			;415d
	ld e,a			;415e
	ld a,d			;415f
	cpl			;4160
	ld d,a			;4161
	inc de			;4162   ; ...mas uno
	ret			;4163
hl_negado:		; HL = -HL
	ld a,l			;4164   ; HL = -HL
	cpl			;4165
	ld l,a			;4166
	ld a,h			;4167
	cpl			;4168
	ld h,a			;4169
	inc hl			;416a   ; complemento a dos
	ret			;416b
bancos_1_2_3:		; pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	di			;416c
	ld a,001h		;416d
	ld (06000h),a		;416f   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;4172   ; guarda la copia del banco de 0x6000
	inc a			;4175
	ld (08000h),a		;4176   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4179   ; guarda la copia del banco de 0x8000
	inc a			;417c
	ld (0a000h),a		;417d   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4180   ; guarda la copia del banco de 0xA000
	ei			;4183
	ret			;4184
bancos_4_5_6:		; pone los bancos 4, 5 y 6 (y sus copias en 0xF0F1-0xF0F3)
	di			;4185
	ld a,004h		;4186
	ld (06000h),a		;4188   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;418b   ; guarda la copia del banco de 0x6000
	inc a			;418e
	ld (08000h),a		;418f   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4192   ; guarda la copia del banco de 0x8000
	inc a			;4195
	ld (0a000h),a		;4196   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4199   ; guarda la copia del banco de 0xA000
	ei			;419c
	ret			;419d
bancos_7_8_9:		; pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	di			;419e
	ld a,007h		;419f
	ld (06000h),a		;41a1   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;41a4   ; guarda la copia del banco de 0x6000
	inc a			;41a7
	ld (08000h),a		;41a8   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;41ab   ; guarda la copia del banco de 0x8000
	inc a			;41ae
	ld (0a000h),a		;41af   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;41b2   ; guarda la copia del banco de 0xA000
	ei			;41b5
	ret			;41b6
bancos_10_11_12:		; pone los bancos 10, 11 y 12 (y sus copias en 0xF0F1-0xF0F3)
	di			;41b7
	ld a,00ah		;41b8
	ld (06000h),a		;41ba   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;41bd   ; guarda la copia del banco de 0x6000
	inc a			;41c0
	ld (08000h),a		;41c1   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;41c4   ; guarda la copia del banco de 0x8000
	inc a			;41c7
	ld (0a000h),a		;41c8   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;41cb   ; guarda la copia del banco de 0xA000
	ei			;41ce
	ret			;41cf
bancos_13_14_15:		; pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	di			;41d0
	ld a,00dh		;41d1
	ld (06000h),a		;41d3   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;41d6   ; guarda la copia del banco de 0x6000
	inc a			;41d9
	ld (08000h),a		;41da   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;41dd   ; guarda la copia del banco de 0x8000
	inc a			;41e0
	ld (0a000h),a		;41e1   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;41e4   ; guarda la copia del banco de 0xA000
	ei			;41e7
	ret			;41e8
p6000_banco_1:		; pone el banco 1 en 0x6000
	di			;41e9
	ld a,001h		;41ea
	ld (06000h),a		;41ec   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;41ef   ; guarda la copia del banco de 0x6000
	ei			;41f2
	ret			;41f3
p6000_banco_4:		; pone el banco 4 en 0x6000
	di			;41f4
	ld a,004h		;41f5
	ld (06000h),a		;41f7   ; el mapper: pone en 0x6000 el banco de A
	ld (0f0f1h),a		;41fa   ; guarda la copia del banco de 0x6000
	ei			;41fd
	ret			;41fe
p8000_banco_2:		; pone el banco 2 en 0x8000
	di			;41ff
	ld a,002h		;4200
	ld (08000h),a		;4202   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4205   ; guarda la copia del banco de 0x8000
	ei			;4208
	ret			;4209
p8000_banco_14:		; pone el banco 14 en 0x8000
	di			;420a
	ld a,00eh		;420b
	ld (08000h),a		;420d   ; el mapper: pone en 0x8000 el banco de A
	ld (0f0f2h),a		;4210   ; guarda la copia del banco de 0x8000
	ei			;4213
	ret			;4214
a000_banco_3:		; pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	di			;4215
	ld a,003h		;4216
	ld (0a000h),a		;4218   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;421b   ; guarda la copia del banco de 0xA000
	ei			;421e
	ret			;421f
a000_banco_6:		; pone el banco 6 en 0xA000 (y su copia en 0xF0F3)
	di			;4220
	ld a,006h		;4221
	ld (0a000h),a		;4223   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4226   ; guarda la copia del banco de 0xA000
	ei			;4229
	ret			;422a
a000_banco_9:		; pone el banco 9 en 0xA000 (y su copia en 0xF0F3)
	di			;422b
	ld a,009h		;422c
	ld (0a000h),a		;422e   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4231   ; guarda la copia del banco de 0xA000
	ei			;4234
	ret			;4235
a000_banco_12:		; pone el banco 12 en 0xA000 (y su copia en 0xF0F3)
	di			;4236
	ld a,00ch		;4237
	ld (0a000h),a		;4239   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;423c   ; guarda la copia del banco de 0xA000
	ei			;423f
	ret			;4240
a000_banco_15:		; pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	di			;4241
	ld a,00fh		;4242
	ld (0a000h),a		;4244   ; el mapper: pone en 0xA000 el banco de A
	ld (0f0f3h),a		;4247   ; guarda la copia del banco de 0xA000
	ei			;424a
	ret			;424b
L_424C:
	push af			;424c
	call bancos_4_5_6		;424d   ; bancos_4_5_6: pone los bancos 4, 5 y 6 (y sus copias en 0xF0F1-0xF0F3)
	pop af			;4250
	call 06551h		;4251   ; crea_figura_hl: crea la figura A en DE con HL en 0xF014
	jp bancos_1_2_3		;4254   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
L_4257:
	call bancos_4_5_6		;4257   ; bancos_4_5_6: pone los bancos 4, 5 y 6 (y sus copias en 0xF0F1-0xF0F3)
	call 0b41ch		;425a   ; acaba_figura: la figura se acaba: el hueco vacio y una menos
	jp bancos_1_2_3		;425d   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
L_4260:
	call bancos_7_8_9		;4260   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call 09d5fh		;4263
	jp bancos_1_2_3		;4266   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
L_4269:
	call bancos_1_2_3		;4269   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call 0b389h		;426c   ; estado_4: el estado 4 (golpeado)
	ld b,002h		;426f
	call 0b3ceh		;4271
	jp bancos_4_5_6		;4274   ; bancos_4_5_6: pone los bancos 4, 5 y 6 (y sus copias en 0xF0F1-0xF0F3)
juego_del_cuadro:		; sube 0xE003 y despacha por el estado 0xE000 (tabla 0x428E)
	ld hl,0e003h		;4277   ; el contador de cuadros
	inc (hl)			;427a
	ld a,(0e000h)		;427b   ; lee el ESTADO del juego
	cp 003h		;427e   ; en los estados 0, 1 y 2...
	jr nc,L_4286		;4280
	ld hl,04bfah		;4282   ; ...al acabar vuelve por p00:4BFA
	push hl			;4285
L_4286:
	ld bc,(0e000h)		;4286   ; C = el estado, B = el paso
	ld a,c			;428a
	call despacha		;428b   ; el estado despacha por la tabla que sigue

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
	djnz L_42C7		;42b8   ; estado 0: el paso 0...
	ld a,(0e003h)		;42ba   ; ...cada dos cuadros...
	rra			;42bd
	ret nc			;42be
	call 06985h		;42bf   ; ...mira p01:6985; cuando da cero, paso siguiente con espera 0
	ret nz			;42c2
	xor a			;42c3
	jp L_435B		;42c4
L_42C7:
	djnz L_42D5		;42c7   ; paso 1: espera 0xE004 cuadros
	ld hl,0e004h		;42c9   ; apunta a la espera del paso, en cuadros
	dec (hl)			;42cc
	ret nz			;42cd
	call prepara_el_titulo		;42ce   ; y prepara el titulo
	xor a			;42d1   ; al estado siguiente con espera 0
	jp L_443B		;42d2
L_42D5:
	call registros_del_vdp		;42d5   ; paso 2
	call pantalla_negra		;42d8   ; pantalla_negra: la tabla de nombres a 0, sin sprites
	call fuente_del_titulo		;42db   ; fuente_del_titulo: la fuente del titulo y los colores de los primeros caracteres
	call a000_banco_9		;42de   ; a000_banco_9: pone el banco 9 en 0xA000 (y su copia en 0xF0F3)
	call 06957h		;42e1   ; p09:6957 con el banco 9 en 0xA000
	call a000_banco_3		;42e4   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	xor a			;42e7   ; el sonido 0: calla
	call pide_sonido		;42e8   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call sin_musica_esperando		;42eb   ; sin_musica_esperando: 0xE01D-0xE01E a cero
	jp paso_siguiente		;42ee   ; y al paso siguiente
prepara_el_titulo:		; pantalla, sprites y graficos del titulo (p01:6215)
	call pantalla_a_cero		;42f1   ; pantalla_a_cero: la copia de la tabla de nombres a cero y a la VRAM
	call sin_sprites		;42f4   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call fuente_del_titulo		;42f7   ; fuente_del_titulo: la fuente del titulo y los colores de los primeros caracteres
	call p8000_banco_14		;42fa   ; banco 14 en 0x8000 y 15 en 0xA000 para p01:6215
	call a000_banco_15		;42fd   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call graficos_del_titulo		;4300   ; graficos_del_titulo: los graficos del titulo
	call 06215h		;4303
	call p8000_banco_2		;4306   ; vuelven el 2 y el 3
	jp a000_banco_3		;4309   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
L_430C:
	push bc			;430c   ; estado 1: p02:98E5...
	call 098e5h		;430d
	pop bc			;4310
	jr nc,L_4330		;4311   ; sin acarreo, al estado 0x12
	call p8000_banco_14		;4313   ; con acarreo, p01:6251 con los bancos 14 y 15
	call a000_banco_15		;4316   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call 06251h		;4319
	call p8000_banco_2		;431c   ; p8000_banco_2: pone el banco 2 en 0x8000
	call a000_banco_3		;431f   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e019h)		;4322   ; mientras 0xE019 este puesto, nada mas
	or a			;4325
	ret nz			;4326
	call sin_sprites		;4327   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call pantalla_a_cero		;432a   ; pantalla_a_cero: la copia de la tabla de nombres a cero y a la VRAM
	jp estado_siguiente		;432d   ; al estado 2
L_4330:
	ld a,012h		;4330   ; el estado 0x12
	jp al_estado		;4332   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
pon_e698:		; 0xE698 = 1
	ld hl,00001h		;4335   ; 0xE698 = 1
	ld (0e698h),hl		;4338   ; guarda el humo del jefe en marcha y el byte siguiente (16 bits)
	ret			;433b
L_433C:
	ld a,b			;433c   ; estado 2: despacha por el paso (B)
	call despacha		;433d   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call cortinilla		;4348   ; paso 0: hasta que vence p00:4D1E
	ret p			;434b
	call esconde_sprites		;434c   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	ld a,(0e025h)		;434f   ; el bit 0 de 0xE025: la vuelta del titulo
	bit 0,a		;4352
	jr nz,L_4363		;4354
	call 07d82h		;4356   ; sin el, p01:7D82
L_4359:
	ld a,020h		;4359   ; espera de 0x20 cuadros...
L_435B:
	ld (0e004h),a		;435b   ; ...en 0xE004...
paso_siguiente:		; sube el paso 0xE001
	ld hl,0e001h		;435e   ; ...y al paso siguiente
	inc (hl)			;4361
	ret			;4362
L_4363:
	call graficos_de_la_sala		;4363   ; con el: monta la sala...
	call 06a1eh		;4366   ; ...y los textos de p01:6A1E y p01:6AC5 (la historia)
	call 06ac5h		;4369
	ld a,001h		;436c
	ld (0e02eh),a		;436e   ; 0xE02E = 1: los textos suben
	ld a,086h		;4371   ; la musica 0x86, sin mirar la pausa
	call pide_sonido_ya		;4373   ; pide_sonido_ya: como pide_sonido, sin mirar la pausa
	ld a,002h		;4376
	jp paso_a		;4378   ; y al paso 2
L_437B:
	call 07e22h		;437b   ; paso 1
	call 07de8h		;437e
	call 07eddh		;4381
	call c,calla_o_vuelve		;4384   ; con acarreo de p01:7EDD, p00:43D8
	ld a,(0e019h)		;4387   ; mientras 0xE019 este puesto, nada mas
	or a			;438a
	ret nz			;438b
	xor a			;438c   ; sin el objeto 0x01...
	ld (0e070h),a		;438d   ; guarda tiene el objeto 0x01
	ld (0e510h),a		;4390   ; ...0xE510 a 0...
	ld hl,00000h		;4393   ; ...y sin flechas
	ld (0e046h),hl		;4396   ; guarda las flechas (BCD, 16 bits)
	call vuelta_de_e023		;4399   ; vuelta_de_e023: 0xE023 de 0 a 1 y vuelta
L_439C:
	ld hl,0e025h		;439c   ; la vuelta siguiente del titulo (0xE025)
	inc (hl)			;439f
L_43A0:
	ld a,0ffh		;43a0   ; al estado 0xFF + 1 = 0...
estado_a:		; el estado A con el paso 0
	ld (0e000h),a		;43a2   ; ...con el paso a 0
	xor a			;43a5
	jp L_443B		;43a6
al_estado:		; al estado A con el paso 0 y 0x20 cuadros de espera
	ld (0e000h),a		;43a9   ; al estado A...
	ld a,020h		;43ac   ; ...con espera de 0x20 cuadros y el paso a 0
	ld (0e004h),a		;43ae   ; guarda la espera del paso, en cuadros
	jp L_4442		;43b1
L_43B4:
	call a000_banco_15		;43b4   ; paso 2: los textos que suben (p01:6ADC con el banco 15)
	call 06adch		;43b7
	call a000_banco_3		;43ba   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e02eh)		;43bd   ; hasta que 0xE02E vuelve a 0
	or a			;43c0
	ret nz			;43c1
	jp paso_siguiente		;43c2   ; paso_siguiente: sube el paso 0xE001
L_43C5:
	call suena		;43c5   ; paso 3: con p00:50F5 distinto de cero...
	ret z			;43c8
	jr L_439C		;43c9   ; ...otra vuelta del titulo
vuelta_de_e023:		; 0xE023 de 0 a 1 y vuelta
	ld a,(0e023h)		;43cb   ; 0xE023 va de 0 a 1 y vuelta
	inc a			;43ce
	cp 002h		;43cf
	jr c,L_43D4		;43d1
	xor a			;43d3
L_43D4:
	ld (0e023h),a		;43d4   ; guarda la demostracion que toca (0 o 1)
	ret			;43d7
calla_o_vuelve:		; da la vuelta al bit 0 de 0xE00D: calla o vuelve la musica
	ld hl,0e00dh		;43d8   ; da la vuelta al bit 0 de 0xE00D
	ld a,(hl)			;43db
	xor 001h		;43dc
	ld (hl),a			;43de
	jr nz,L_43EC		;43df   ; a 1: calla (sonido 0)
	ld a,(0e033h)		;43e1   ; a 0: si 0xE033...
	or a			;43e4
	ret z			;43e5
	call musica_del_mapa		;43e6   ; ...vuelve a pedir la musica que tocaba (p00:5D1A)
	jp musica		;43e9   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
L_43EC:
	xor a			;43ec
	jp pide_sonido		;43ed   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_43F0:
	djnz L_4404		;43f0   ; estado 3, paso 0: cuenta 0xE004 hacia atras
	ld hl,0e004h		;43f2   ; apunta a la espera del paso, en cuadros
	dec (hl)			;43f5
	jp z,paso_siguiente		;43f6   ; al acabar, paso siguiente
	bit 2,(hl)		;43f9   ; el texto de 0x7D71 parpadea con el bit 2 de la cuenta
	ld de,07d71h		;43fb
	jp z,lista_a_vram		;43fe   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	jp borra_lista_vram		;4401   ; borra_lista_vram: como lista_a_vram pero escribiendo ceros
L_4404:
	djnz L_4416		;4404   ; paso 1
	call pantalla_a_cero		;4406   ; pantalla_a_cero: la copia de la tabla de nombres a cero y a la VRAM
	call sin_sprites		;4409   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call partida_nueva		;440c   ; partida_nueva: RAM a cero, sala 1 del castillo, Popolon y las vidas de 0x4CE6
	ld a,001h		;440f   ; 0xE007 = 1
	ld (0e007h),a		;4411
	jr estado_siguiente		;4414
L_4416:
	ld a,087h		;4416   ; paso 2: la musica 0x87 con p00:5CAF...
	call musica		;4418   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
	ld a,02dh		;441b   ; ...y 0x2D cuadros de espera
	jp L_435B		;441d
L_4420:
	djnz L_4447		;4420   ; estado 4, paso 0: entra en la sala
	call 0604dh		;4422   ; p01:604D y p00:510B
	call monta_la_sala		;4425   ; monta_la_sala: la sala entera con todo lo que lleva
	xor a			;4428   ; 0xE01A a 0 y 0xE019 a 1
	ld (0e01ah),a		;4429   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	inc a			;442c
	ld (0e019h),a		;442d   ; guarda en juego (a 0 se acaba la vida: estado 6)
	ld a,(0e690h)		;4430   ; lee la sala especial (pista o tienda)
	or a			;4433   ; en una sala especial, al estado 0x0E
	ld a,00eh		;4434
	jp nz,al_estado		;4436   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
estado_siguiente:		; al estado siguiente con el paso 0 y 0x20 cuadros de espera
	ld a,020h		;4439   ; al estado siguiente con 0x20 cuadros de espera
L_443B:
	ld (0e004h),a		;443b   ; guarda la espera del paso, en cuadros
	ld hl,0e000h		;443e   ; sube el estado
	inc (hl)			;4441
L_4442:
	xor a			;4442
paso_a:		; el paso A
	ld (0e001h),a		;4443   ; y el paso a A (0 casi siempre)
	ret			;4446
L_4447:
	call cortinilla		;4447   ; paso 1: cuando vence p00:4D1E...
	ret p			;444a
	ld hl,0e007h		;444b   ; ...la primera vez (0xE007 a 0)...
	ld a,(hl)			;444e
	or a			;444f
	ld (hl),001h		;4450
	jr nz,L_445F		;4452
	call hay_jefe		;4454   ; ...si no hay jefe (p00:4579)...
	jr nz,L_445F		;4457
	call musica_del_mapa		;4459   ; ...vuelve la musica de la sala
	call musica		;445c   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
L_445F:
	jp paso_siguiente		;445f   ; y al paso siguiente
L_4462:
	call cuadro_de_partida		;4462   ; estado 5, la partida: un cuadro de juego (p00:52F5)
	ld a,(0e019h)		;4465   ; con 0xE019 a 0 se acabo esta vida: al estado 6
	or a			;4468
	jr z,estado_siguiente		;4469
	ld a,(0e020h)		;446b   ; el nombre del jefe acertado: estado 0x0F
	or a			;446e
	ld a,00fh		;446f
	jr nz,L_44D2		;4471
	ld a,(0e01fh)		;4473   ; 0xE01F = 1: estado 8
	ld b,a			;4476
	dec b			;4477
	ld a,008h		;4478
	jr z,L_44D2		;447a
	dec b			;447c   ; 0xE01F = 2: estado 0x0D
	ld a,00dh		;447d
	jr z,L_44D2		;447f
	ld a,(0e01ch)		;4481   ; 0xE01C: estado 0x10
	or a			;4484
	ld a,010h		;4485
	jr nz,L_44D2		;4487
	ld a,(0e031h)		;4489   ; 0xE031: estado 0x14
	or a			;448c
	ld a,014h		;448d
	jr nz,L_44D2		;448f
	ld a,(0e01ah)		;4491   ; 0xE01A: estado 0x0A
	or a			;4494
	ld a,00ah		;4495
	jr nz,L_44D2		;4497
	ld a,(0e01bh)		;4499   ; 0xE01B: estado 0x0C
	or a			;449c
	ld a,00ch		;449d
	jr nz,L_44D2		;449f
	ld a,(0e024h)		;44a1   ; 0xE024: estado 0x11
	or a			;44a4
	ld a,011h		;44a5
	jr nz,L_44D2		;44a7
	ld a,(0e02ch)		;44a9   ; 0xE02C: estado 0x13
	or a			;44ac
	ld a,013h		;44ad
	jr nz,L_44D2		;44af
	call 09e07h		;44b1   ; F2 (p02:9E07): la pausa
	jr nc,L_44D5		;44b4
	ld a,(0e500h)		;44b6   ; no mientras se hunde
	cp 005h		;44b9
	ret z			;44bb
	call 0a8ceh		;44bc   ; con p03:A8CE, 0xE61D + 1
	jr z,L_44C5		;44bf
	ld hl,0e61dh		;44c1
	inc (hl)			;44c4
L_44C5:
	ld a,0fdh		;44c5   ; el sonido 0xFD...
	call pide_sonido		;44c7   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call sprites_de_la_taza		;44ca   ; ...los dibujos de la taza (p00:5917, banco 15 a 0x1800)...
	call 0be26h		;44cd   ; ...p03:BE26...
	ld a,009h		;44d0   ; ...y al estado 9
L_44D2:
	jp al_estado		;44d2   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_44D5:
	call personaje_4_a_7		;44d5   ; sin F2: no en los estados 4-7 del personaje
	ret c			;44d8
	call 09e21h		;44d9   ; p02:9E21...
	ret nc			;44dc
	ld a,02bh		;44dd   ; ...con acarreo, el sonido 0x2B...
	call pide_sonido		;44df   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call esconde_sprites		;44e2   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	ld a,00bh		;44e5   ; ...y al estado 0x0B
	jp al_estado		;44e7   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
personaje_4_a_7:		; C si el estado del personaje es 4-7
	ld a,(0e500h)		;44ea   ; acarreo si el estado del personaje es 4-7
	sub 004h		;44ed
	cp 004h		;44ef
	ret			;44f1
L_44F2:
	djnz L_4502		;44f2   ; estado 6, paso 0: espera 0xE004 cuadros
	ld hl,0e004h		;44f4   ; apunta a la espera del paso, en cuadros
	dec (hl)			;44f7
	ret nz			;44f8
	xor a			;44f9
	ld (0e007h),a		;44fa
	ld a,004h		;44fd   ; y al estado 4 (la sala otra vez)
	jp al_estado		;44ff   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4502:
	call sin_sprites		;4502   ; paso 1: cuando vence p00:4D1E...
	call cortinilla		;4505   ; cortinilla: baja la espera y borra una columna; P mientras quede
	ret p			;4508
	ld a,(0e501h)		;4509   ; ...las vidas del que juega (0xE058 + 0xE501)
	ld hl,0e058h		;450c   ; apunta a las vidas de Afrodita (BCD)
	add a,l			;450f
	ld l,a			;4510
	ld a,(hl)			;4511   ; ...si le quedan, uno menos (BCD)...
	or a			;4512
	jr z,L_451F		;4513
	sub 001h		;4515
	daa			;4517
	ld (hl),a			;4518
	call pinta_vidas		;4519   ; ...se repinta...
L_451C:
	jp L_4359		;451c   ; ...y 0x20 cuadros
L_451F:
	ld a,l			;451f   ; si no, el otro personaje...
	xor 001h		;4520
	ld l,a			;4522
	ld a,(hl)			;4523
	or a			;4524   ; ...si tampoco le quedan, se acabo
	jr z,L_4547		;4525
	sub 001h		;4527
	daa			;4529
	ld (hl),a			;452a
	call pinta_vidas		;452b   ; pinta_vidas: la lista de 0x7CF6 o 0x7D06 segun quien juega
	ld a,(0e501h)		;452e   ; y pasa a jugar el otro
	xor 001h		;4531
	ld (0e501h),a		;4533   ; guarda quien juega (0 Afrodita)
	jr L_451C		;4536
pinta_vidas:		; la lista de 0x7CF6 o 0x7D06 segun quien juega
	ld a,(0e501h)		;4538   ; la lista de 0x7CF6 (Afrodita) o 0x7D06 (Popolon)
	or a			;453b
	ld de,07cf6h		;453c
	jr z,L_4544		;453f
	ld de,07d06h		;4541
L_4544:
	jp lista_a_vram		;4544   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
L_4547:
	ld a,095h		;4547   ; se acabo: la musica 0x95 y al estado 7
	call pide_sonido		;4549   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp estado_siguiente		;454c   ; estado_siguiente: al estado siguiente con el paso 0 y 0x20 cuadros de espera
L_454F:
	djnz L_4582		;454f   ; estado 7, paso 0: lo de ZEUS (p01:7E8C)
	call 07e8ch		;4551
	call suena		;4554   ; hasta que p00:50F5 de cero
	ret nz			;4557
	ld hl,0e026h		;4558   ; si se ha seguido con F5...
	ld a,(hl)			;455b
	and a			;455c
	jr nz,L_4567		;455d
L_455F:
	ld hl,0e002h		;455f   ; si no, quita el bit 6 de 0xE002...
	res 6,(hl)		;4562
	jp L_43A0		;4564   ; ...y al estado 0
L_4567:
	ld (hl),000h		;4567   ; 0xE026 a 0 otra vez
	ld hl,00004h		;4569   ; estado 4, paso 0: la partida sigue
	ld (0e000h),hl		;456c   ; guarda el ESTADO del juego y el byte siguiente (16 bits)
	call hay_jefe		;456f   ; sin jefe, vuelve la musica
	ret nz			;4572
	call musica_del_mapa		;4573   ; musica_del_mapa: A = 0x88 en el castillo, 0x8A en los mundos
	jp musica_ya		;4576   ; musica_ya: sin musica esperando, la musica A
hay_jefe:		; NZ si hay jefe en la sala (0xE0D2 o 0xE0D4)
	ld a,(0e0d4h)		;4579   ; NZ si hay jefe (0xE0D2 o 0xE0D4)
	ld b,a			;457c
	ld a,(0e0d2h)		;457d   ; lee el estado del jefe
	or b			;4580
	ret			;4581
L_4582:
	call cortinilla		;4582   ; paso 1: cuando vence p00:4D1E
	ret p			;4585
	ld de,07d44h		;4586   ; GAME OVER (lista 0x7D44)
	call lista_a_vram		;4589   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	ld a,(0e027h)		;458c   ; lee ZEUS tecleado
	and a			;458f
	ld de,07ecfh		;4590   ; y con ZEUS, F5 CONTINUE debajo
	call nz,lista_a_vram		;4593   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	jp paso_siguiente		;4596   ; paso_siguiente: sube el paso 0xE001
L_4599:
	djnz L_45E8		;4599   ; estado 8, paso 0: p02:9E6F
	call 09e6fh		;459b
	ld a,(0e608h)		;459e   ; mientras 0xE608 este puesto, nada
	or a			;45a1
	ret nz			;45a2
	call esconde_sprites		;45a3   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call borra_la_sala		;45a6   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	ld de,07d28h		;45a9   ; borra la lista de 0x7D28...
	call borra_lista_vram		;45ac   ; borra_lista_vram: como lista_a_vram pero escribiendo ceros
	ld de,07d14h		;45af   ; ...y pinta la de 0x7D14
	call lista_a_vram		;45b2   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	ld a,(0e688h)		;45b5   ; 0xE688 (BCD, de 1 en adelante)...
	dec a			;45b8
	add a,001h		;45b9
	daa			;45bb
	ld de,0f000h		;45bc   ; ...en 0xF000...
	ld (de),a			;45bf
	ld b,001h		;45c0
	cp 010h		;45c2   ; ...con una cifra o con dos...
	push af			;45c4
	call c,cifra_baja		;45c5   ; cifra_baja: pinta la cifra baja de (DE) y sigue con cifras_bcd
	pop af			;45c8
	call nc,cifras_bcd		;45c9   ; cifras_bcd: pinta B bytes BCD de DE hacia atras en la VRAM de HL
	inc l			;45cc
	ld a,028h		;45cd   ; ...y un caracter 0x28 detras
	call 0004dh		;45cf   ; BIOS WRTVRM - Writes data in VRAM
	call borra_tramo_del_mapa		;45d2   ; borra_tramo_del_mapa: el tramo de RAM del mapa (0xAF09/0xAF20, banco 9) a cero
	call mapa_del_mundo		;45d5   ; mapa_del_mundo: mapa = 0xE688 + 1, sala 1
	call borra_lo_del_mapa		;45d8   ; borra_lo_del_mapa: dos bytes de la tabla 0x4689 y el tramo de RAM del mapa (0xAF09/0xAF20, banco 9) a cero
	call objetos_del_mundo		;45db   ; objetos_del_mundo: pone los objetos 0x07-0x0A segun los bits 7-4 de 0xE061 + mapa
	ld a,08eh		;45de   ; el sonido 0x8E y 0x60 cuadros
	call pide_sonido		;45e0   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,060h		;45e3
	jp L_435B		;45e5
L_45E8:
	djnz L_4603		;45e8   ; paso 1: espera
	ld hl,0e004h		;45ea   ; apunta a la espera del paso, en cuadros
	dec (hl)			;45ed
	ret nz			;45ee
	call entra_el_personaje		;45ef   ; p00:528E y p00:51CD
	call monta_otra_sala		;45f2   ; monta_otra_sala: la sala al pasar a otra
	ld a,08ah		;45f5   ; la musica 0x8A
	call musica_ya		;45f7   ; musica_ya: sin musica esperando, la musica A
	xor a			;45fa   ; 0xE01F a 0
	ld (0e01fh),a		;45fb   ; guarda 1 = estado 8, 2 = estado 0x0D
	ld a,005h		;45fe   ; y al estado 5, la partida
	jp al_estado		;4600   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4603:
	call esconde_sprites		;4603   ; paso 2: vacia los huecos de figura
	call vacia_figuras		;4606   ; vacia_figuras: los huecos de figura 0xE800-0xE9FF a cero
	call 09e3bh		;4609   ; p02:9E3B y 0xE608 = 1
	ld a,001h		;460c
	ld (0e608h),a		;460e   ; guarda un paso de varios cuadros en marcha
	jp paso_siguiente		;4611   ; paso_siguiente: sube el paso 0xE001
mapa_del_mundo:		; mapa = 0xE688 + 1, sala 1
	ld a,(0e688h)		;4614   ; el mundo elegido (0xE688) + 1 es el mapa...
	inc a			;4617
	ld l,a			;4618
	ld h,001h		;4619   ; ...y se empieza en su sala 1
	ld (0e041h),hl		;461b   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
	ret			;461e
objetos_del_mundo:		; pone los objetos 0x07-0x0A segun los bits 7-4 de 0xE061 + mapa
	ld a,(0e041h)		;461f   ; las marcas del mundo, 0xE061 + mapa...
	ld hl,0e061h		;4622   ; apunta a el cambio de vida pendiente de Popolon (con signo)
	call hl_mas_a		;4625   ; hl_mas_a: HL += A
	ld a,001h		;4628
	bit 7,(hl)		;462a   ; ...bit 7: ya tiene el objeto 0x09 de este mundo
	jr z,L_4631		;462c
	ld (0e078h),a		;462e   ; guarda tiene el objeto 0x09
L_4631:
	bit 6,(hl)		;4631   ; bit 6: el 0x08
	jr z,L_4638		;4633
	ld (0e077h),a		;4635   ; guarda tiene el objeto 0x08
L_4638:
	bit 5,(hl)		;4638   ; bit 5: el 0x07
	jr z,L_463F		;463a
	ld (0e076h),a		;463c   ; guarda tiene el objeto 0x07
L_463F:
	bit 4,(hl)		;463f   ; bit 4: el 0x0A
	ret z			;4641
	ld (0e079h),a		;4642   ; guarda tiene el objeto 0x0A
	ret			;4645
borra_lo_del_mapa:		; dos bytes de la tabla 0x4689 y el tramo de RAM del mapa (0xAF09/0xAF20, banco 9) a cero
	ld a,(0e041h)		;4646   ; en el mapa 11 nada; en los demas...
	cp 00bh		;4649
	ret z			;464b
	ld hl,04689h		;464c   ; ...dos bytes de 0xE000 + los de la tabla 0x4689 a cero
	call palabra_de_tabla		;464f   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld h,0e0h		;4652
	ld l,d			;4654
	ld (hl),000h		;4655
	ld l,e			;4657
	ld (hl),000h		;4658
borra_tramo_del_mapa:		; el tramo de RAM del mapa (0xAF09/0xAF20, banco 9) a cero
	call a000_banco_9		;465a   ; con el banco 9: el tramo de RAM del mapa (0xAF09 + 2 x mapa)...
	ld a,(0e041h)		;465d   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,0af09h		;4660
	call palabra_de_tabla		;4663   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld hl,0af20h		;4666   ; ...de largo 0xAF20 + mapa...
	ld a,(0e041h)		;4669   ; lee el mapa (1 el castillo, 2-11 los mundos)
	call byte_de_tabla		;466c   ; byte_de_tabla: A = el byte HL + A
	ld c,a			;466f
	dec c			;4670
	ld b,000h		;4671
	push de			;4673
	push bc			;4674
	ld h,d			;4675
	ld l,e			;4676
	inc de			;4677
	ld (hl),b			;4678
	ldir		;4679   ; ...a cero
	pop bc			;467b
	pop de			;467c
	ld hl,00150h		;467d   ; y en el de 0x150 mas alla solo queda el bit 0 de cada byte
	add hl,de			;4680
	ld b,c			;4681
	inc b			;4682
L_4683:
	ld a,(hl)			;4683
	and 001h		;4684
	ld (hl),a			;4686
	inc hl			;4687
	djnz L_4683		;4688
	jp a000_banco_3		;468a   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)

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


vacia_figuras:		; los huecos de figura 0xE800-0xE9FF a cero
	ld hl,0e800h		;469f   ; los huecos de figura, 0xE800-0xE9FF, a cero
	ld de,0e801h		;46a2
	ld bc,001ffh		;46a5
	ld (hl),000h		;46a8
	ldir		;46aa
	ret			;46ac
L_46AD:
	djnz L_46EC		;46ad   ; estado 0x0D, paso 0: la vuelta al castillo
	call suena		;46af   ; suena: NZ mientras suena algo
	ret nz			;46b2
	ld a,(0e041h)		;46b3   ; desde el mapa 11, a la sala de 0xE06D
	cp 00bh		;46b6
	jr nz,L_46C0		;46b8
	ld a,(0e06dh)		;46ba   ; lee la sala de la puerta del mapa 11
	ld h,a			;46bd
	jr L_46D3		;46be
L_46C0:
	ld a,(0e01ah)		;46c0   ; desde un mundo: la vecina 0xE647 + 0xE01A...
	ld hl,0e647h		;46c3   ; apunta a las cuatro vecinas de la sala (0xE648-0xE64B)
	add a,l			;46c6
	ld l,a			;46c7
	ld a,(hl)			;46c8
	neg		;46c9   ; ...elige en 0x998E la sala del castillo
	ld c,a			;46cb
	ld b,000h		;46cc
	ld hl,0998eh		;46ce
	add hl,bc			;46d1
	ld h,(hl)			;46d2
L_46D3:
	ld l,001h		;46d3   ; mapa 1, la sala de H
	ld (0e041h),hl		;46d5   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
	call monta_otra_sala		;46d8   ; p00:51CD, p01:6C95 y p02:9E8F
	call 06c95h		;46db
	call 09e8fh		;46de
	xor a			;46e1   ; 0xE01A a 0 y 0xE608 a 1
	ld (0e01ah),a		;46e2   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	inc a			;46e5
	ld (0e608h),a		;46e6   ; guarda un paso de varios cuadros en marcha
	jp paso_siguiente		;46e9   ; paso_siguiente: sube el paso 0xE001
L_46EC:
	djnz L_470D		;46ec   ; paso 1: hasta que 0xE608 vuelve a 0 (p02:9E97)
	call sala_a_vram		;46ee   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	call 09e97h		;46f1
	ld a,(0e608h)		;46f4   ; lee un paso de varios cuadros en marcha
	or a			;46f7
	ret nz			;46f8
	call esconde_sprites		;46f9   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	xor a			;46fc   ; 0xE01F a 0
	ld (0e01fh),a		;46fd   ; guarda 1 = estado 8, 2 = estado 0x0D
	ld a,088h		;4700   ; la musica 0x88
	call musica_ya		;4702   ; musica_ya: sin musica esperando, la musica A
	call sprites_1f20_solos		;4705   ; sprites_1f20_solos: el rle de 0x7BB2 a 0x1F20 con las figuras quietas
	ld a,005h		;4708   ; y a la partida
	jp al_estado		;470a   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_470D:
	call esconde_sprites		;470d   ; paso 2
	call borra_la_sala		;4710   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	ld de,07d28h		;4713   ; borra la lista de 0x7D28 y pinta la de 0x7D1D
	call borra_lista_vram		;4716   ; borra_lista_vram: como lista_a_vram pero escribiendo ceros
	call lista_7d1d		;4719   ; lista_7d1d: pinta la lista de 0x7D1D
	call sin_objetos_del_mundo		;471c   ; sin los cuatro objetos del mundo
	call sonido_fc		;471f   ; sonido_fc: con 0xE0D5, una vez, el sonido 0xFC
	ld a,0fah		;4722   ; el sonido 0xFA
	call pide_sonido		;4724   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	jp paso_siguiente		;4727   ; paso_siguiente: sube el paso 0xE001
lista_7d1d:		; pinta la lista de 0x7D1D
	ld de,07d1dh		;472a
	jp lista_a_vram		;472d   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
sin_objetos_del_mundo:		; los objetos 0x07-0x0A a cero
	ld hl,00000h		;4730   ; los objetos 0x07-0x0A a cero (al entrar en otro mundo)
	ld (0e076h),hl		;4733   ; guarda tiene el objeto 0x07 y el byte siguiente (16 bits)
	ld (0e078h),hl		;4736   ; guarda tiene el objeto 0x09 y el byte siguiente (16 bits)
	ret			;4739
L_473A:
	djnz L_474A		;473a   ; estado 9, la pausa de F2: paso 0, a la partida otra vez
	ld a,005h		;473c
	call al_estado		;473e   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
	call 073d6h		;4741   ; p01:73D6 y p00:5474...
	call sprites_a_vram		;4744   ; sprites_a_vram: la copia de la tabla de sprites (0xEC80) a 0x3B00
	jp sprites_del_personaje		;4747   ; ...y los dibujos de sprite de la sala (p00:590E)
L_474A:
	call 09e07h		;474a   ; paso 1: F2 otra vez acaba la pausa
	jr c,L_475E		;474d
	call 0be36h		;474f   ; la taza (p03:BE36)
	call 073d6h		;4752
	call 07e57h		;4755   ; y las letras de ZEUS
	call sprites_a_vram		;4758   ; sprites_a_vram: la copia de la tabla de sprites (0xEC80) a 0x3B00
	jp fin_del_cuadro		;475b   ; fin_del_cuadro: p15:BD06 y p15:BDA1 con las figuras quietas
L_475E:
	ld a,0feh		;475e   ; el sonido 0xFE y al paso siguiente
	call pide_sonido		;4760   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call esconde_sprites		;4763   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	jp paso_siguiente		;4766   ; paso_siguiente: sube el paso 0xE001
L_4769:
	call sin_sprites		;4769   ; estado 0x0A: el paso a la sala vecina
	call borra_la_sala		;476c   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	ld a,(0e041h)		;476f   ; lee el mapa (1 el castillo, 2-11 los mundos)
	cp 004h		;4772   ; en el mapa 4, p00:479C
	call z,pozo_del_mapa_4		;4774   ; pozo_del_mapa_4: en el mapa 4, subir cinco veces seguidas por arriba de la sala 4 pone 0xE0A1
	call vecina_del_lado		;4777   ; la sala vecina por el lado 0xE01A
	ld (0e042h),a		;477a   ; guarda la sala
	call monta_otra_sala		;477d   ; monta_otra_sala: la sala al pasar a otra
	xor a			;4780   ; 0xE01A a 0
	ld (0e01ah),a		;4781   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	ld a,(0e690h)		;4784   ; en una sala especial al estado 0x0E...
	or a			;4787
	ld a,00eh		;4788
	jp nz,al_estado		;478a   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
	ld a,005h		;478d   ; ...si no, a la partida
	jp al_estado		;478f   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
vecina_del_lado:		; A = la vecina 0xE647 + 0xE01A
	ld a,(0e01ah)		;4792   ; A = la vecina 0xE647 + 0xE01A (1-4)
	ld hl,0e647h		;4795   ; apunta a las cuatro vecinas de la sala (0xE648-0xE64B)
	add a,l			;4798
	ld l,a			;4799
	ld a,(hl)			;479a
	ret			;479b
pozo_del_mapa_4:		; en el mapa 4, subir cinco veces seguidas por arriba de la sala 4 pone 0xE0A1
	call vecina_del_lado		;479c   ; en el mapa 4 solo si la vecina es la sala 4 (la que se sube a si misma)
	cp 004h		;479f
	ret nz			;47a1
	ld a,(0e01ah)		;47a2   ; saliendo por arriba (lado 1)...
	dec a			;47a5
	jr z,L_47B9		;47a6
	dec a			;47a8
	ret z			;47a9
	dec a			;47aa   ; ...o por la izquierda (3)
	ret nz			;47ab
	ld a,(0e505h)		;47ac   ; por la izquierda, con la y >= 0x80, la cuenta a cero
	cp 080h		;47af
	ret c			;47b1
	ld hl,00000h		;47b2
	ld (0e0a0h),hl		;47b5   ; guarda las veces seguidas que se sube por arriba de la sala 4 del mapa 4 y el byte siguiente (16 bits)
	ret			;47b8
L_47B9:
	ld hl,0e0a1h		;47b9   ; por arriba, si 0xE0A1 aun no esta...
	bit 0,(hl)		;47bc
	ret nz			;47be
	dec l			;47bf   ; ...una vez mas en 0xE0A0...
	inc (hl)			;47c0
	ld a,(hl)			;47c1
	cp 005h		;47c2   ; ...y a la quinta...
	ret c			;47c4
	ld (hl),000h		;47c5   ; ...0xE0A1 = 1 y el sonido 0x2E
	inc l			;47c7
	ld (hl),001h		;47c8
	ld a,02eh		;47ca
	jp pide_sonido		;47cc   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
L_47CF:
	djnz L_4835		;47cf   ; estado 0x0B, paso 0: las cifras del castillo (p02:9A99)
	xor a			;47d1
	ld (0f000h),a		;47d2
	call 09a99h		;47d5
	ld a,(0f000h)		;47d8   ; si han puesto 0xF000, a su puerta
	and a			;47db
	jr nz,L_480D		;47dc
	call 09ac9h		;47de   ; lo tecleado (p02:9AC9)
	jr nc,L_481E		;47e1
	ld a,(0e041h)		;47e3   ; en el castillo, a la sala 0x48 del mapa 1
	dec a			;47e6
	jr z,L_4807		;47e7
	call sin_objetos_del_mundo		;47e9   ; en un mundo: fuera los objetos del mundo...
	call sin_sprites		;47ec   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call borra_la_sala		;47ef   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	call esconde_sprites		;47f2   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call lista_7d1d		;47f5   ; lista_7d1d: pinta la lista de 0x7D1D
	ld a,0fah		;47f8   ; ...el sonido 0xFA, 0x78 cuadros y al paso 2
	call pide_sonido		;47fa   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,078h		;47fd
	ld (0e004h),a		;47ff   ; guarda la espera del paso, en cuadros
	ld a,002h		;4802
	jp paso_a		;4804   ; paso_a: el paso A
L_4807:
	ld hl,04801h		;4807   ; mapa 1, sala 0x48
	ld (0e041h),hl		;480a   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
L_480D:
	call sin_sprites		;480d   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call borra_la_sala		;4810   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	call esconde_sprites		;4813   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call 06903h		;4816   ; p01:6903 y p00:51E8
	call monta_la_sala_otra_vez		;4819   ; monta_la_sala_otra_vez: la sala y lo de encima
	jr L_4830		;481c
L_481E:
	call 09e21h		;481e   ; p02:9E21; sin acarreo, p01:67E2
	jp nc,067e2h		;4821
	call esconde_sprites		;4824   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call borra_la_sala		;4827   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	call 06903h		;482a   ; p01:6903 y p00:51DF
	call monta_la_sala_sola		;482d   ; monta_la_sala_sola: la sala, sin sprites
L_4830:
	ld a,005h		;4830   ; y a la partida
	jp al_estado		;4832   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4835:
	djnz L_4843		;4835   ; paso 1: espera 0xE004 cuadros
	ld hl,0e004h		;4837   ; apunta a la espera del paso, en cuadros
	dec (hl)			;483a
	ret nz			;483b
	ld a,088h		;483c   ; la musica 0x88 y al castillo, sala 0x48
	call musica		;483e   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
	jr L_4807		;4841
L_4843:
	call borra_la_sala		;4843   ; paso 2: p00:5711 y p04:65A8
	call graficos_del_estado_0b		;4846   ; graficos_del_estado_0b: los graficos del estado 0x0B (el objeto de 0xE097 en el caracter 0xF1)
	call 065a8h		;4849
	jp paso_siguiente		;484c   ; paso_siguiente: sube el paso 0xE001
L_484F:
	djnz L_486E		;484f   ; estado 0x0C, paso 0: p00:4C68...
	call lee_el_mando		;4851   ; lee_el_mando: el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	ld a,(0e008h)		;4854   ; ...hasta el bit 5 del mando
	bit 5,a		;4857
	ret z			;4859
	call borra_la_sala		;485a   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	call monta_la_sala_sola		;485d   ; monta_la_sala_sola: la sala, sin sprites
	xor a			;4860   ; 0xE01B a 0, la musica 0x8A y a la partida
	ld (0e01bh),a		;4861   ; guarda estado 0x0C pedido
	ld a,08ah		;4864
	call musica_ya		;4866   ; musica_ya: sin musica esperando, la musica A
	ld a,005h		;4869
	jp al_estado		;486b   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_486E:
	call sin_sprites		;486e   ; paso 1
	call borra_la_sala		;4871   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	call esconde_sprites		;4874   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	ld a,08ch		;4877   ; la musica 0x8C
	call musica_ya		;4879   ; musica_ya: sin musica esperando, la musica A
	call sonido_fc		;487c   ; sonido_fc: con 0xE0D5, una vez, el sonido 0xFC
	call graficos_del_estado_0c		;487f   ; graficos_del_estado_0c: los graficos del estado 0x0C
	call a000_banco_9		;4882   ; p09:69B9 con el banco 9
	call 069b9h		;4885
	call a000_banco_3		;4888   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	jp paso_siguiente		;488b   ; paso_siguiente: sube el paso 0xE001
L_488E:
	djnz L_48B7		;488e   ; estado 0x0E, la sala especial, paso 0: lo de la sala (p02:8F43)
	call lee_el_mando		;4890   ; lee_el_mando: el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	call 08f43h		;4893
	call 0938eh		;4896   ; y p02:938E
	ld a,(0e008h)		;4899   ; hasta el bit 1 del mando
	and 002h		;489c
	ret z			;489e
	xor a			;489f   ; al salir, 0xE690 a 0...
	ld (0e690h),a		;48a0   ; guarda la sala especial (pista o tienda)
	ld a,010h		;48a3
	ld (0e502h),a		;48a5   ; ...0xE502 = 0x10, por el lado 2...
	ld a,002h		;48a8
	ld (0e01ah),a		;48aa   ; guarda el lado por el que se sale de la sala: 1 arriba, 2 abajo, 3 izquierda, 4 derecha
	ld a,08ah		;48ad   ; ...la musica 0x8A y al estado 0x0A
	call musica_despues		;48af   ; musica_despues: apaga lo que suena y deja esperando la musica A
	ld a,00ah		;48b2
	jp al_estado		;48b4   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_48B7:
	ld a,08dh		;48b7   ; paso 1: la musica 0x8D, p00:57E1 y p02:8F1E
	call musica_despues		;48b9   ; musica_despues: apaga lo que suena y deja esperando la musica A
	call graficos_de_sala_especial		;48bc   ; graficos_de_sala_especial: los graficos de la sala especial y lo que vende
	call 08f1eh		;48bf
	jp paso_siguiente		;48c2   ; paso_siguiente: sube el paso 0xE001
L_48C5:
	ld a,b			;48c5   ; estado 0x10: por el paso
	call despacha		;48c6   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	call esconde_sprites		;48d3   ; paso 0: p02:9F0F y 0xE608 = 1
	call sonido_fc		;48d6   ; sonido_fc: con 0xE0D5, una vez, el sonido 0xFC
	call 09f0fh		;48d9
	ld a,001h		;48dc
	ld (0e608h),a		;48de   ; guarda un paso de varios cuadros en marcha
	jp paso_siguiente		;48e1   ; paso_siguiente: sube el paso 0xE001
L_48E4:
	call 09f2eh		;48e4   ; paso 1: p02:9F2E hasta que 0xE608 vuelve a 0
	ld a,(0e608h)		;48e7   ; lee un paso de varios cuadros en marcha
	or a			;48ea
	ret nz			;48eb
	call esconde_sprites		;48ec   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call borra_la_sala		;48ef   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	ld a,(0e680h)		;48f2   ; la sala especial de 0xE680
	ld (0e690h),a		;48f5   ; guarda la sala especial (pista o tienda)
	call graficos_de_la_sala_especial		;48f8   ; graficos_de_la_sala_especial: sus graficos y la musica 0x8D
	call 08f1eh		;48fb
	jp paso_siguiente		;48fe   ; paso_siguiente: sube el paso 0xE001
graficos_de_la_sala_especial:		; sus graficos y la musica 0x8D
	call graficos_de_sala_especial		;4901   ; p00:57E1 y la musica 0x8D
	ld a,08dh		;4904
	jp musica		;4906   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
L_4909:
	call lee_el_mando		;4909   ; paso 2: lo de la sala especial (p02:8F43, p02:938E)
	call 08f43h		;490c
	call 0938eh		;490f
	ld a,(0e693h)		;4912   ; 0xE693 = 1: nada; 2: sigue sin esperar...
	dec a			;4915
	ret z			;4916
	dec a			;4917
	jr z,L_4920		;4918
	ld a,(0e008h)		;491a   ; ...si no, hasta el bit 1 del mando
	and 002h		;491d
	ret z			;491f
L_4920:
	jr L_493A		;4920
L_4922:
	call esconde_sprites		;4922   ; paso 3: fuera de la sala especial
	call borra_la_sala		;4925   ; borra_la_sala: sin sprites y las filas 4-23 de la pantalla a 0
	xor a			;4928
	ld (0e690h),a		;4929   ; guarda la sala especial (pista o tienda)
	call monta_la_sala_sola		;492c   ; monta_la_sala_sola: la sala, sin sprites
	call 09f42h		;492f   ; p02:9F42 y p01:73B7
	call 073b7h		;4932
	ld a,001h		;4935   ; 0xE608 = 1
	ld (0e608h),a		;4937   ; guarda un paso de varios cuadros en marcha
L_493A:
	jp paso_siguiente		;493a   ; paso_siguiente: sube el paso 0xE001
L_493D:
	call sala_a_vram		;493d   ; paso 4: hasta que 0xE608 vuelve a 0 (p02:9F56)
	call 09f56h		;4940
	ld a,(0e608h)		;4943   ; lee un paso de varios cuadros en marcha
	or a			;4946
	ret nz			;4947
	ld a,088h		;4948   ; la musica 0x88 y los sprites de la sala
	call musica		;494a   ; musica: la musica A (0xE021 = 1 salvo 0x87-0x8B)
	call sprites_1f20_solos		;494d   ; sprites_1f20_solos: el rle de 0x7BB2 a 0x1F20 con las figuras quietas
	xor a			;4950   ; 0xE01C a 0 y a la partida
	ld (0e01ch),a		;4951   ; guarda estado 0x10 pedido
	ld a,005h		;4954
	jp al_estado		;4956   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4959:
	djnz L_4969		;4959   ; estado 0x0F, el jefe: paso 0, p02:9F68 hasta que 0xE64C vuelve a 0
	call 09f68h		;495b
	ld a,(0e64ch)		;495e
	or a			;4961
	ret nz			;4962
	call pon_e698		;4963   ; 0xE698 = 1 y al paso siguiente
	jp paso_siguiente		;4966   ; paso_siguiente: sube el paso 0xE001
L_4969:
	djnz L_4991		;4969   ; paso 1: el humo (p15:BE1C) mientras 0xE698
	call a000_banco_15		;496b   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call 0be1ch		;496e
	call a000_banco_3		;4971   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e698h)		;4974   ; lee el humo del jefe en marcha
	or a			;4977
	ret nz			;4978
	ld a,(0e041h)		;4979   ; luego el jefe del mapa (0x5E05 + mapa)...
	ld hl,05e05h		;497c
	call hl_mas_a		;497f   ; hl_mas_a: HL += A
	ld h,(hl)			;4982
	ld l,001h		;4983   ; ...en 0xE0D3, con 0xE0D2 = 1
	ld (0e0d2h),hl		;4985   ; guarda el estado del jefe y el byte siguiente (16 bits)
	call monta_la_planta		;4988   ; p00:5561 y p00:54BF
	call sala_a_vram		;498b   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	jp paso_siguiente		;498e   ; paso_siguiente: sube el paso 0xE001
L_4991:
	djnz L_499B		;4991   ; paso 2: los graficos del jefe (p00:5848) y a la partida
	call graficos_del_jefe_si_hay		;4993   ; graficos_del_jefe_si_hay: con jefe, sus graficos
	ld a,005h		;4996
	jp al_estado		;4998   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_499B:
	xor a			;499b   ; paso 3: 0xE615 y el nombre acertado a 0
	ld (0e615h),a		;499c   ; guarda en la sala del jefe sin jefe (el recuadro)
	ld (0e020h),a		;499f   ; guarda el nombre del jefe acertado
	call sala_sin_salidas		;49a2   ; la sala sin salidas
	ld a,081h		;49a5   ; la musica 0x81
	call pide_sonido		;49a7   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call 09f61h		;49aa
	jp paso_siguiente		;49ad   ; paso_siguiente: sube el paso 0xE001
sala_sin_salidas:		; las cuatro vecinas 0xE648-0xE64B a 0xFF
	ld hl,0ffffh		;49b0   ; las cuatro vecinas a 0xFF: la sala del jefe no tiene salida
	ld (0e648h),hl		;49b3   ; guarda las vecinas de la sala: arriba, abajo, izquierda, derecha y el byte siguiente (16 bits)
	ld (0e64ah),hl		;49b6
	ret			;49b9
L_49BA:
	ld a,b			;49ba   ; estado 0x11, el final: por el paso
	call despacha		;49bb   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld a,0ffh		;49d0   ; paso 0: el sonido 0xFF y 0x28 cuadros
	call pide_sonido		;49d2   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ld a,028h		;49d5
	jp L_435B		;49d7
L_49DA:
	ld hl,0e004h		;49da   ; paso 1: espera y p03:A05A
	dec (hl)			;49dd
	ret nz			;49de
	call 0a05ah		;49df
L_49E2:
	jp paso_siguiente		;49e2   ; paso_siguiente: sube el paso 0xE001
L_49E5:
	call 0a06dh		;49e5   ; paso 2: hasta que p03:A06D da cero; luego 0x78 cuadros
	jp nz,sala_a_vram		;49e8   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	ld a,078h		;49eb
	jp L_435B		;49ed
L_49F0:
	ld hl,0e004h		;49f0   ; paso 3: espera
	dec (hl)			;49f3
	jp nz,sala_a_vram		;49f4   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	jr L_49E2		;49f7
L_49F9:
	call borra_la_sala		;49f9   ; paso 4
	call esconde_sprites		;49fc   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call pantalla_a_cero		;49ff   ; pantalla_a_cero: la copia de la tabla de nombres a cero y a la VRAM
	call graficos_del_final		;4a02   ; graficos_del_final: los graficos del final
	call a000_banco_15		;4a05   ; p15:B7C0 con el banco 15
	call 0b7c0h		;4a08
	call a000_banco_3		;4a0b   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	xor a			;4a0e   ; 0xE024 a 0 y 0xE608 a 1
	ld (0e024h),a		;4a0f   ; guarda el final (estado 0x11)
	inc a			;4a12
	ld (0e608h),a		;4a13   ; guarda un paso de varios cuadros en marcha
	ld a,092h		;4a16   ; la musica 0x92
	call pide_sonido_ya		;4a18   ; pide_sonido_ya: como pide_sonido, sin mirar la pausa
	jp paso_siguiente		;4a1b   ; paso_siguiente: sube el paso 0xE001
L_4A1E:
	call sprites_a_vram		;4a1e   ; paso 5: p15:B847 mientras 0xE608
	call nombres_a_vram		;4a21   ; nombres_a_vram: la copia de la tabla de nombres (0xED00) a 0x3800
	call a000_banco_15		;4a24   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call 0b847h		;4a27
	call a000_banco_3		;4a2a   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e608h)		;4a2d   ; lee un paso de varios cuadros en marcha
	or a			;4a30
	ret nz			;4a31
	jp L_4359		;4a32   ; luego 0x20 cuadros y paso siguiente
L_4A35:
	call borra_la_sala		;4a35   ; paso 6: la sala y los textos del epilogo (p01:6A1E, p01:6ACA)
	call esconde_sprites		;4a38   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call graficos_de_la_sala		;4a3b   ; graficos_de_la_sala: la carga grafica de la sala (tools/vram.py carga_sala)
	call 06a1eh		;4a3e
	call 06acah		;4a41
	ld a,001h		;4a44   ; los textos suben
	ld (0e02eh),a		;4a46   ; guarda los textos estan subiendo
	ld a,093h		;4a49   ; la musica 0x93
	call pide_sonido_ya		;4a4b   ; pide_sonido_ya: como pide_sonido, sin mirar la pausa
	jp paso_siguiente		;4a4e   ; paso_siguiente: sube el paso 0xE001
L_4A51:
	call a000_banco_15		;4a51   ; paso 7: los textos que suben (p01:6ADC con el banco 15)
	call 06adch		;4a54
	call a000_banco_3		;4a57   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e02eh)		;4a5a   ; hasta que acaban
	or a			;4a5d
	ret nz			;4a5e
	jp paso_siguiente		;4a5f   ; paso_siguiente: sube el paso 0xE001
L_4A62:
	call suena		;4a62   ; paso 8: con p00:50F5 a cero, al titulo
	ret z			;4a65
	jp L_455F		;4a66
L_4A69:
	push bc			;4a69   ; estado 0x12: el mando cada cuadro (p00:4C68)
	call lee_el_mando		;4a6a   ; lee_el_mando: el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	pop bc			;4a6d
	djnz L_4A7F		;4a6e   ; paso 0: p02:9716 hasta 0xE02D
	call 09716h		;4a70
	ld a,(0e02dh)		;4a73   ; lee hecho (estado 0x12)
	and a			;4a76
	ret z			;4a77
L_4A78:
	xor a			;4a78   ; 0xE02D a 0 y paso siguiente
	ld (0e02dh),a		;4a79   ; guarda hecho (estado 0x12)
	jp paso_siguiente		;4a7c   ; paso_siguiente: sube el paso 0xE001
L_4A7F:
	djnz L_4AA5		;4a7f   ; paso 1: p02:97DD
	call 097ddh		;4a81
	ld a,(0e02dh)		;4a84   ; lee hecho (estado 0x12)
	and a			;4a87
	jr nz,L_4AA0		;4a88   ; con 0xE02D, p02:9908 y paso siguiente
	call 09926h		;4a8a   ; sin el: p02:9926, 0xB4 cuadros y al paso 4
	ld a,0b4h		;4a8d
	ld (0e004h),a		;4a8f   ; guarda la espera del paso, en cuadros
	ld a,004h		;4a92
	call paso_a		;4a94   ; paso_a: el paso A
	call sin_sprites		;4a97   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call esconde_sprites		;4a9a   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	jp esconde_sprites		;4a9d   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
L_4AA0:
	call 09908h		;4aa0
	jr L_4A78		;4aa3
L_4AA5:
	djnz L_4AB8		;4aa5   ; paso 2: una tecla del mando...
	ld a,(0e008h)		;4aa7   ; lee lo recien apretado (bits 0-5: arriba, abajo, izquierda, derecha, A/espacio, B/M)
	and a			;4aaa
	ret z			;4aab
	ld hl,0e001h		;4aac   ; ...vuelve dos pasos atras (p02:990F)
	dec (hl)			;4aaf
	dec (hl)			;4ab0
	xor a			;4ab1
	ld (0e02dh),a		;4ab2   ; guarda hecho (estado 0x12)
	jp 0990fh		;4ab5
L_4AB8:
	djnz L_4B27		;4ab8   ; paso 3: espera 0xE004 cuadros
	ld hl,0e004h		;4aba   ; apunta a la espera del paso, en cuadros
	dec (hl)			;4abd
	ret nz			;4abe
	xor a			;4abf   ; la partida empieza: 0xE007 a 0...
	ld (0e007h),a		;4ac0
	ld hl,0e016h		;4ac3   ; ...0xE016-0xE0FF a cero...
	ld de,0e017h		;4ac6
	ld bc,000e9h		;4ac9
	ld (hl),000h		;4acc
	ldir		;4ace
	ld hl,0e200h		;4ad0   ; ...0xE200-0xEAFF...
	ld de,0e201h		;4ad3
	ld bc,008feh		;4ad6
	ld (hl),000h		;4ad9
	ldir		;4adb
	ld hl,0ec00h		;4add   ; ...y 0xEC00-0xF03F
	ld de,0ec01h		;4ae0
	ld bc,0043fh		;4ae3
	ld (hl),000h		;4ae6
	ldir		;4ae8
	call 0982bh		;4aea   ; p02:982B y p02:99B3
	call 099b3h		;4aed
	ld hl,00101h		;4af0   ; en la sala 1 del castillo
	ld (0e041h),hl		;4af3   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,(0e501h)		;4af6   ; la vida del que juega llena (su tope)
	and a			;4af9
	ld hl,0e053h		;4afa   ; apunta a el tope de la vida de Afrodita
	jr z,L_4B01		;4afd
	ld l,057h		;4aff
L_4B01:
	ld a,(hl)			;4b01
	dec l			;4b02
	ld (hl),a			;4b03
	ld a,(0e501h)		;4b04   ; y la del otro, si le quedan vidas (bit 0)
	or a			;4b07
	ld hl,0e059h		;4b08   ; apunta a las vidas de Popolon (BCD)
	ld de,0e057h		;4b0b   ; apunta a el tope de la vida de Popolon
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
	call regalo_de_cartucho		;4b1a   ; lo que dan los cartuchos de la otra ranura
	ld a,040h		;4b1d   ; 0xE002 = 0x40
	ld (0e002h),a		;4b1f
	ld a,004h		;4b22   ; y al estado 4: entrar en la sala
	jp al_estado		;4b24   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4B27:
	call pantalla_a_cero		;4b27   ; paso 4
	call sin_sprites		;4b2a   ; sin_sprites: 0xD0 en la tabla de sprites: no se ve ninguno
	call esconde_sprites		;4b2d   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	call graficos_de_la_sala		;4b30   ; graficos_de_la_sala: la carga grafica de la sala (tools/vram.py carga_sala)
	call caracteres_25d0		;4b33   ; caracteres_25d0: el rle de 0x9BEC en 0x25D0 en color 0xF0
	call figuras_quietas		;4b36   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	ld hl,01800h		;4b39   ; el rle de 0x4B4E a los dibujos de sprite (0x1800)
	ld de,04b4eh		;4b3c
	call rle_a_vram		;4b3f   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	call figuras_sueltas		;4b42   ; figuras_sueltas: 0xE602 = 0
	call 09704h		;4b45   ; p02:9704 y p02:98ED
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
	djnz L_4B8E		;4b5b   ; estado 0x13, el jefe vencido: paso 0, el humo (p15:BE1C)
	call a000_banco_15		;4b5d   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call 0be1ch		;4b60
	call a000_banco_3		;4b63   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	ld a,(0e698h)		;4b66   ; mientras 0xE698
	or a			;4b69
	ret nz			;4b6a
	call 079f4h		;4b6b   ; p01:79F4 y p00:54BF
	call sala_a_vram		;4b6e   ; sala_a_vram: la pantalla de la sala (0xED80) a las filas 4-23
	xor a			;4b71   ; sin jefe: 0xE0D2, 0xE0D3, el hueco 0xE700 y 0xE02C a cero
	ld h,a			;4b72
	ld l,a			;4b73
	ld (0e0d2h),hl		;4b74   ; guarda el estado del jefe y el byte siguiente (16 bits)
	ld (0e700h),a		;4b77   ; guarda el tipo del jefe (el hueco 0xE700 es el jefe)
	ld (0e702h),hl		;4b7a
	ld (0e02ch),a		;4b7d   ; guarda el jefe vencido (estado 0x13)
	ld a,(0e041h)		;4b80   ; y en las marcas del mapa, el bit 2: jefe vencido
	ld hl,0e061h		;4b83   ; apunta a el cambio de vida pendiente de Popolon (con signo)
	call hl_mas_a		;4b86   ; hl_mas_a: HL += A
	set 2,(hl)		;4b89
L_4B8B:
	jp paso_siguiente		;4b8b   ; paso_siguiente: sube el paso 0xE001
L_4B8E:
	djnz L_4BCA		;4b8e   ; paso 1: en el mapa 11...
	ld a,(0e041h)		;4b90   ; lee el mapa (1 el castillo, 2-11 los mundos)
	cp 00bh		;4b93
	jr z,L_4BA2		;4b95
	call dibujo_de_la_cosa_0c		;4b97   ; en los demas, p00:58D3 y la puerta de p00:4BA9
	call cosa_del_jefe_vencido		;4b9a   ; cosa_del_jefe_vencido: pone la cosa 0x0C en el sitio de la tabla 0x4BCD del mapa (0xE0D4 = 1)
L_4B9D:
	ld a,005h		;4b9d   ; y a la partida
	jp al_estado		;4b9f   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4BA2:
	ld a,006h		;4ba2   ; en el mapa 11 la vecina de abajo pasa a ser la sala 6
	ld (0e64bh),a		;4ba4
	jr L_4B9D		;4ba7
cosa_del_jefe_vencido:		; pone la cosa 0x0C en el sitio de la tabla 0x4BCD del mapa (0xE0D4 = 1)
	ld a,(0e041h)		;4ba9   ; el sitio de la tabla 0x4BCD por mapa: y en el nibble alto...
	ld hl,l4bcdh		;4bac
	call byte_de_tabla		;4baf   ; byte_de_tabla: A = el byte HL + A
	and 0f0h		;4bb2
	sub 008h		;4bb4   ; ...menos 8...
	ld d,a			;4bb6
	ld a,(hl)			;4bb7   ; ...x en el bajo
	rlca			;4bb8
	rlca			;4bb9
	rlca			;4bba
	rlca			;4bbb
	and 0f0h		;4bbc
	ld e,a			;4bbe
	ld c,00ch		;4bbf   ; la cosa 0x0C en ese sitio (p00:5D88)
	call pon_cosa		;4bc1   ; pon_cosa: la cosa C en la y D, x E (hueco 0xE740)
	ld a,001h		;4bc4   ; 0xE0D4 = 1
	ld (0e0d4h),a		;4bc6   ; guarda la cosa del jefe vencido puesta
	ret			;4bc9
L_4BCA:
	call pon_e698		;4bca   ; paso 2: 0xE698 = 1
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
	djnz L_4BF0		;4bd8   ; estado 0x14, paso 0: p15:BE81 hasta que 0xE53F vuelve a 0
	call 0be81h		;4bda
	ld a,(0e53fh)		;4bdd   ; lee los saltos de alegria
	and a			;4be0
	ret nz			;4be1
	call vecinas_de_la_sala		;4be2   ; p00:5218, p00:5561 y p03:AE9A, y a la partida
	call monta_la_planta		;4be5   ; monta_la_planta: la planta y lo que la cambia (objeto 0x18, mapa 4); no en salas especiales
	call 0ae9ah		;4be8
	ld a,005h		;4beb
	jp al_estado		;4bed   ; al_estado: al estado A con el paso 0 y 0x20 cuadros de espera
L_4BF0:
	xor a			;4bf0   ; paso 1: 0xE031 a 0 y p15:BE5F
	ld (0e031h),a		;4bf1   ; guarda estado 0x14 pedido
	call 0be5fh		;4bf4
	jp paso_siguiente		;4bf7   ; paso_siguiente: sube el paso 0xE001
tecla_en_el_titulo:		; espacio o M en el titulo empieza; en los estados 1 y 2 vuelve al 0
	call mando		;4bfa   ; el mando...
	ld hl,0e012h		;4bfd
	call guarda_el_mando		;4c00   ; ...con 0xE012/0xE013 como lo apretado y lo recien apretado
	or a			;4c03
	ret z			;4c04   ; sin tecla, nada
	ld hl,0e004h		;4c05   ; apunta a la espera del paso, en cuadros
	ld (hl),000h		;4c08
	ld hl,0e000h		;4c0a   ; en el estado 0...
	ld b,(hl)			;4c0d
	djnz L_4C1E		;4c0e
	and 030h		;4c10   ; ...espacio o M (bits 4 y 5)...
	ret z			;4c12
	ld a,040h		;4c13   ; ...empiezan: 0xE002 = 0x40 y al estado 3
	ld (0e002h),a		;4c15
	ld (hl),003h		;4c18
	inc hl			;4c1a
	ld (hl),000h		;4c1b
	ret			;4c1d
L_4C1E:
	inc b			;4c1e   ; en los estados 1 y 2, al estado 0
	ex af,af'			;4c1f
	xor a			;4c20
	call estado_a		;4c21   ; estado_a: el estado A con el paso 0
	ex af,af'			;4c24
	jr z,L_4C33		;4c25
	ld a,(0e025h)		;4c27   ; y la vuelta siguiente del titulo
	bit 0,a		;4c2a
	call z,vuelta_de_e023		;4c2c   ; vuelta_de_e023: 0xE023 de 0 a 1 y vuelta
	ld hl,0e025h		;4c2f   ; apunta a las vueltas del titulo (el bit 0 elige la historia)
	inc (hl)			;4c32
L_4C33:
	xor a			;4c33   ; calla y otra vez el titulo
	call pide_sonido		;4c34   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	call sin_musica_esperando		;4c37   ; sin_musica_esperando: 0xE01D-0xE01E a cero
	jp prepara_el_titulo		;4c3a   ; prepara_el_titulo: pantalla, sprites y graficos del titulo (p01:6215)
vram_a_cero:		; el sonido desde cero, la VRAM a 0 y los registros del VDP
	call sonido_a_cero		;4c3d   ; el sonido a cero y la VRAM entera a 0
	ld hl,00000h		;4c40
	ld bc,04000h		;4c43
	xor a			;4c46
	call 00056h		;4c47   ; BIOS FILVRM - Fills VRAM with value
registros_del_vdp:		; los registros 0-7 del VDP de la tabla 0x4C5B
	ld hl,04c5bh		;4c4a   ; los 8 registros del VDP de la tabla 0x4C5B
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


color_de_fondo:		; el registro 7 del VDP = B
	ld c,007h		;4c63   ; el registro 7 (el color de fondo) = B
	jp 00047h		;4c65   ; BIOS WRTVDP - Writes data in the VDP-register
lee_el_mando:		; el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	call mando		;4c68   ; lee el mando...
L_4C6B:
	ld hl,0e009h		;4c6b   ; ...y lo guarda en 0xE009 (apretado) y 0xE008 (recien apretado)
guarda_el_mando:		; A en (HL) y lo recien apretado en (HL - 1)
	ld c,(hl)			;4c6e
	ld (hl),a			;4c6f
	xor c			;4c70   ; lo que no estaba apretado antes
	and (hl)			;4c71
	dec hl			;4c72
	ld (hl),a			;4c73
	ret			;4c74
mando:		; A = joystick 1 y teclado: arriba, abajo, izquierda, derecha, A/espacio, B/M
	ld e,08fh		;4c75   ; el puerto 1 del joystick (registro 15 del PSG)...
	ld a,00fh		;4c77
	call 00093h		;4c79   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;4c7c   ; ...leido en el registro 14
	di			;4c7e
	call 00096h		;4c7f   ; BIOS RDPSG - Reads value from PSG-register
	ei			;4c82
	cpl			;4c83
	and 03fh		;4c84   ; bits 0-5: arriba, abajo, izquierda, derecha, boton A, boton B
	push af			;4c86
	ld a,004h		;4c87   ; la fila 4 del teclado...
	call 00141h		;4c89   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4c8c
	rlca			;4c8d
	rlca			;4c8e
	rlca			;4c8f
	and 020h		;4c90   ; ...su bit 2, la M, como boton B (bit 5)
	ld e,a			;4c92
	ld a,008h		;4c93   ; la fila 8: espacio y cursores
	call 00141h		;4c95   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;4c98
	rrca			;4c99
	rrca			;4c9a
	ld b,a			;4c9b
	and 004h		;4c9c   ; izquierda al bit 2
	or e			;4c9e
	ld c,a			;4c9f
	ld a,b			;4ca0
	rrca			;4ca1
	rrca			;4ca2
	ld b,a			;4ca3
	and 018h		;4ca4   ; derecha al bit 3 y espacio al bit 4
	or c			;4ca6
	ld c,a			;4ca7
	ld a,b			;4ca8
	rrca			;4ca9
	and 003h		;4caa   ; arriba al bit 0 y abajo al bit 1
	or c			;4cac
	pop bc			;4cad
	or b			;4cae   ; junto con el joystick
	ret			;4caf
partida_nueva:		; RAM a cero, sala 1 del castillo, Popolon y las vidas de 0x4CE6
	ld hl,0e016h		;4cb0   ; partida nueva: 0xE016-0xE0FF a cero...
	ld de,0e017h		;4cb3
	ld bc,000e9h		;4cb6
	ld (hl),000h		;4cb9
	ldir		;4cbb
	ld hl,0e200h		;4cbd   ; ...y 0xE200-0xF03F
	ld de,0e201h		;4cc0
	ld bc,00e3fh		;4cc3
	ld (hl),000h		;4cc6
	ldir		;4cc8
	ld hl,00101h		;4cca   ; sala 1 del castillo
	ld (0e041h),hl		;4ccd   ; guarda el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,001h		;4cd0   ; empieza Popolon
	ld (0e501h),a		;4cd2   ; guarda quien juega (0 Afrodita)
	ld hl,04ce6h		;4cd5   ; la vida, los topes y las vidas de partida (0x4CE6, 11 bytes)
	ld de,0e051h		;4cd8   ; apunta a el tope de la experiencia de Afrodita
	ld bc,0000bh		;4cdb
	ldir		;4cde
	call regalo_de_cartucho		;4ce0   ; regalo_de_cartucho: lo que dan Q*bert (bit 1) y Knightmare (bit 0) de 0xF0F8 al empezar
	jp 099b3h		;4ce3   ; y p02:99B3

; ----------------------------------------------------------------------
; DATOS al_empezar: 11 bytes que p00:4CD5 copia a 0xE051-0xE05B al empezar la
;   partida (el mapa 1, sala 1, va a 0xE041 justo antes)
;   0x4ce6..0x4cf1  (11 bytes)
DATA_al_empezar:
	defb 030h,008h,008h,000h,030h,008h,008h,001h,000h,001h,001h	; 4ce6  0...0......

; ======================================================================
; CODIGO 0x4cf1..0x4ef7  (518 bytes)
; ======================================================================


regalo_de_cartucho:		; lo que dan Q*bert (bit 1) y Knightmare (bit 0) de 0xF0F8 al empezar
	ld a,(0f0f8h)		;4cf1   ; sin cartucho en la otra ranura, nada
	or a			;4cf4
	ret z			;4cf5
	rra			;4cf6   ; bit 0: Knightmare
	jr c,L_4D15		;4cf7
	rra			;4cf9   ; bit 1: Q*bert
	jr c,L_4CFF		;4cfa
	rra			;4cfc
	ret nc			;4cfd
	ret			;4cfe
L_4CFF:
	ld hl,00100h		;4cff   ; Q*bert: 100 flechas, 100 llaves y 100 monedas...
	ld (0e046h),hl		;4d02   ; guarda las flechas (BCD, 16 bits)
	ld (0e04ah),hl		;4d05   ; guarda las llaves (BCD, 16 bits)
	ld (0e048h),hl		;4d08   ; guarda las monedas (BCD, 16 bits)
	ld hl,03030h		;4d0b   ; ...y la vida y su tope a 0x30 en los dos
	ld (0e052h),hl		;4d0e   ; guarda la vida de Afrodita y el byte siguiente (16 bits)
	ld (0e056h),hl		;4d11   ; guarda la vida de Popolon y el byte siguiente (16 bits)
	ret			;4d14
L_4D15:
	ld a,099h		;4d15   ; Knightmare: 99 en 0xE05A y 0xE05B
	ld (0e05ah),a		;4d17   ; guarda de Afrodita: baja uno al revivirla (Knightmare lo pone a 99)
	ld (0e05bh),a		;4d1a   ; guarda de Popolon: baja uno al revivirlo (Knightmare lo pone a 99)
	ret			;4d1d
cortinilla:		; baja la espera y borra una columna; P mientras quede
	ld hl,0e004h		;4d1e   ; cuenta la espera hacia atras; acabada, sale con el signo puesto
	dec (hl)			;4d21
	ret m			;4d22
	ld a,(hl)			;4d23   ; la columna 0x1F - espera...
	ld h,038h		;4d24
	xor 01fh		;4d26
	add a,080h		;4d28   ; ...desde la fila 4 de la tabla de nombres...
	ld l,a			;4d2a
	ld b,014h		;4d2b   ; ...20 filas a 0: la pantalla se borra columna a columna
	xor a			;4d2d
	ld de,00020h		;4d2e
L_4D31:
	call 0004dh		;4d31   ; BIOS WRTVRM - Writes data in VRAM
	add hl,de			;4d34
	djnz L_4D31		;4d35
	ret			;4d37
sin_sprites:		; 0xD0 en la tabla de sprites: no se ve ninguno
	call figuras_quietas		;4d38   ; 0xD0 en la primera y de la tabla de sprites: no se ve ninguno
	ld hl,03b00h		;4d3b
	ld a,0d0h		;4d3e
	call 0004dh		;4d40   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;4d43
	jp figuras_sueltas		;4d44   ; figuras_sueltas: 0xE602 = 0
borra_la_sala:		; sin sprites y las filas 4-23 de la pantalla a 0
	call sin_sprites		;4d47   ; sin sprites y las filas 4-23 de la tabla de nombres a 0
	call figuras_quietas		;4d4a   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	ld hl,03880h		;4d4d
	ld bc,00280h		;4d50
	xor a			;4d53
	call 00056h		;4d54   ; BIOS FILVRM - Fills VRAM with value
	jp figuras_sueltas		;4d57   ; figuras_sueltas: 0xE602 = 0
suma_flechas:		; suma A (BCD) a las flechas de 0xE046, hasta 999
	ld b,000h		;4d5a
	ld hl,0e046h		;4d5c   ; apunta a las flechas (BCD)
L_4D5F:
	add a,(hl)			;4d5f   ; suma en BCD...
	daa			;4d60
	ld (hl),a			;4d61
	inc hl			;4d62
	ld a,(hl)			;4d63   ; ...con el acarreo al byte alto
	adc a,000h		;4d64
	daa			;4d66
	ld (hl),a			;4d67
	cp 010h		;4d68   ; a partir de 1000...
	jr c,L_4D71		;4d6a
	ld (hl),009h		;4d6c   ; ...se queda en 999
	dec l			;4d6e
	ld (hl),099h		;4d6f
L_4D71:
	dec b			;4d71   ; y repinta las flechas (B = 0), las monedas (1) o las llaves (2)
	jp m,pinta_flechas		;4d72   ; pinta_flechas: las flechas en la fila 0, columna 24
	jp z,pinta_monedas		;4d75   ; pinta_monedas: las monedas en la fila 1, columna 24
	jp pinta_llaves		;4d78   ; pinta_llaves: las llaves en la fila 2, columna 24
suma_monedas:		; suma A (BCD) a las monedas de 0xE048, hasta 999
	ld b,001h		;4d7b
	ld hl,0e048h		;4d7d   ; apunta a las monedas (BCD)
	jr L_4D5F		;4d80
suma_llaves:		; suma A (BCD) a las llaves de 0xE04A, hasta 999
	ld b,002h		;4d82
	ld hl,0e04ah		;4d84   ; apunta a las llaves (BCD)
	jr L_4D5F		;4d87
cifras_bcd:		; pinta B bytes BCD de DE hacia atras en la VRAM de HL
	ld a,(de)			;4d89   ; las cifras BCD de DE hacia atras: la de arriba...
	rra			;4d8a
	rra			;4d8b
	rra			;4d8c
	rra			;4d8d
	and 00fh		;4d8e
	inc a			;4d90   ; ...el caracter de la cifra es la cifra + 1
	call 0004dh		;4d91   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;4d94
cifra_baja:		; pinta la cifra baja de (DE) y sigue con cifras_bcd
	ld a,(de)			;4d95   ; ...y la de abajo
	and 00fh		;4d96
	inc a			;4d98
	call 0004dh		;4d99   ; BIOS WRTVRM - Writes data in VRAM
	dec de			;4d9c   ; B bytes
	inc hl			;4d9d
	djnz cifras_bcd		;4d9e
	ret			;4da0
casilla_de_yx:		; HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,l			;4da1   ; la y (L) en filas de 8...
	rra			;4da2
	rra			;4da3
	rra			;4da4
	rra			;4da5
	rr h		;4da6   ; ...y la x (H) en columnas de 8...
	rra			;4da8
	rr h		;4da9
	rra			;4dab
	rr h		;4dac
	ld l,h			;4dae   ; ...HL = 0xED00 + 32 x fila + columna
	and 003h		;4daf
	add a,0edh		;4db1
	ld h,a			;4db3
	ret			;4db4
bajo_la_figura:		; C si el caracter de debajo de la figura IX o su derecha pasa de 0xB9
	ld h,(ix+007h)		;4db5   ; la casilla de debajo de la figura IX (y + 16)
	ld a,(ix+005h)		;4db8
	add a,010h		;4dbb
	ld l,a			;4dbd
	call casilla_de_yx		;4dbe   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,0b9h		;4dc1   ; acarreo si su caracter pasa de 0xB9...
	cp (hl)			;4dc3
	ret c			;4dc4
casilla_derecha:		; compara 0xB9 con el caracter de HL + 1
	inc hl			;4dc5   ; ...o el de la derecha
	cp (hl)			;4dc6
	ret			;4dc7
casilla_b9:		; C si el caracter de la casilla de HL pasa de 0xB9
	call casilla_de_yx		;4dc8   ; acarreo si el caracter de la casilla de HL pasa de 0xB9
	ld a,0b9h		;4dcb
	cp (hl)			;4dcd
	ret			;4dce
multiplica:		; HL = H x E
	ld b,008h		;4dcf   ; HL = H x E, ocho vueltas de suma y desplaza
	ld l,000h		;4dd1
	ld d,l			;4dd3
L_4DD4:
	add hl,hl			;4dd4
	jr nc,L_4DD8		;4dd5
	add hl,de			;4dd7
L_4DD8:
	djnz L_4DD4		;4dd8
	ret			;4dda
tiene_o_popolon:		; NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)
	ld a,(hl)			;4ddb
	and a			;4ddc
	ret nz			;4ddd
	ld a,(0e501h)		;4dde   ; lee quien juega (0 Afrodita)
	and a			;4de1
	ret			;4de2
azar:		; A = R con el contador de cuadros
	ld a,r		;4de3   ; un numero al azar: el registro R...
	rrca			;4de5
	rrca			;4de6
	rrca			;4de7
	ld hl,0e003h		;4de8   ; apunta a el contador de cuadros
	xor (hl)			;4deb   ; ...con el contador de cuadros
	ret			;4dec
sonido_a_cero:		; el estado del sonido a cero y los canales callados
	ld a,0bch		;4ded   ; el sonido desde cero: 0xE1B1 = 0xBC y lo demas a 0
	ld (0e1b1h),a		;4def
	xor a			;4df2
	ld (0e1c0h),a		;4df3
	ld (0e1c1h),a		;4df6
	ld (0e1c2h),a		;4df9
	ld (0e1c6h),a		;4dfc
	ld (0e1c5h),a		;4dff   ; guarda lo herido que esta el jefe (0, 1, 2)
calla:		; los programas de canal al vacio de 0x6075
	xor a			;4e02   ; calla: los cuatro programas de canal (0xE100-0xE106)...
	ld (0e1c7h),a		;4e03   ; guarda la musica que suena
	ld (0e1b0h),a		;4e06
	ld (0e1b2h),a		;4e09
	ld (0e1c3h),a		;4e0c
	ld hl,06075h		;4e0f   ; ...apuntan al programa vacio de 0x6075
	ld (0e100h),hl		;4e12   ; guarda los programas de los cuatro canales de sonido (0xE100-0xE107) y el byte siguiente (16 bits)
	ld (0e102h),hl		;4e15
	ld (0e104h),hl		;4e18
	ld (0e106h),hl		;4e1b
	ret			;4e1e
pide_sonido:		; pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	or a			;4e1f   ; la musica (bit 7)...
	jp p,pide_sonido_ya		;4e20   ; pide_sonido_ya: como pide_sonido, sin mirar la pausa
	push hl			;4e23
	ld hl,0e002h		;4e24   ; ...no se pide si 0xE002 no tiene el bit 6...
	bit 6,(hl)		;4e27
	pop hl			;4e29
	jr nz,pide_sonido_ya		;4e2a
	push hl			;4e2c
	ld hl,0e00dh		;4e2d   ; ...y el bit 0 de 0xE00D la tiene callada
	bit 0,(hl)		;4e30
	pop hl			;4e32
	ret nz			;4e33
pide_sonido_ya:		; como pide_sonido, sin mirar la pausa
	di			;4e34   ; guarda los bancos de 0x6000 y 0x8000...
	push hl			;4e35
	push de			;4e36
	push bc			;4e37
	push af			;4e38
	ld a,(0f0f1h)		;4e39   ; lee la copia del banco de 0x6000
	ld (0f0f4h),a		;4e3c   ; guarda el banco de 0x6000 guardado mientras suena el sonido
	ld a,(0f0f2h)		;4e3f   ; lee la copia del banco de 0x8000
	ld (0f0f5h),a		;4e42   ; guarda el banco de 0x8000 guardado mientras suena el sonido
	ld a,00dh		;4e45   ; ...pone los del sonido, 13 y 14...
	ld (06000h),a		;4e47   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4e4a
	ld (08000h),a		;4e4b   ; el mapper: pone en 0x8000 el banco de A
	pop af			;4e4e
	push af			;4e4f
	call sonido		;4e50   ; ...pide el sonido...
	ld a,(0f0f4h)		;4e53   ; ...y vuelve a dejar los que habia
	ld (0f0f1h),a		;4e56   ; guarda la copia del banco de 0x6000
	ld (06000h),a		;4e59   ; el mapper: pone en 0x6000 el banco de A
	ld a,(0f0f5h)		;4e5c   ; lee el banco de 0x8000 guardado mientras suena el sonido
	ld (0f0f2h),a		;4e5f   ; guarda la copia del banco de 0x8000
	ld (08000h),a		;4e62   ; el mapper: pone en 0x8000 el banco de A
	pop af			;4e65
	pop bc			;4e66
	pop de			;4e67
	pop hl			;4e68
	ei			;4e69
	ret			;4e6a
sonido:		; 0 calla, 0x01-0x7F efecto, 0x80-0xF9 musica (tabla 0x743E), 0xFA-0xFF p00:4F52
	or a			;4e6b   ; 0: calla
	jp z,calla		;4e6c   ; calla: los programas de canal al vacio de 0x6075
	cp 0fah		;4e6f   ; 0xFA-0xFF: p00:4F52
	jp nc,sonido_especial		;4e71   ; sonido_especial: 0xFA/0xFF se apaga, 0xFB/0xFC, 0xFD/0xFE la pausa
	or a			;4e74   ; 0x01-0x7F: un efecto (p00:4F12)
	jp p,efecto		;4e75   ; efecto: el efecto A si no suena uno mayor (tabla 0x73DC, canal 0xE15D)
	ld (0e1c7h),a		;4e78   ; 0x80-0xF9: una musica, en 0xE1C7
	cp 083h		;4e7b   ; la 0x83 pone 0xE1CB
	jr nz,L_4E86		;4e7d
	ld a,001h		;4e7f
	ld (0e1cbh),a		;4e81
	jr L_4E8A		;4e84
L_4E86:
	xor a			;4e86
	ld (0e1cbh),a		;4e87
L_4E8A:
	ld a,(0e1c7h)		;4e8a   ; lee la musica que suena
	ld de,0e10ch		;4e8d   ; los tres canales (0xE10C, 0xE127, 0xE142) desde la plantilla de 0x4EF7
	ld hl,04ef7h		;4e90
	ld bc,0001bh		;4e93
	ldir		;4e96
	ld hl,04ef7h		;4e98
	ld bc,0001bh		;4e9b
	ldir		;4e9e
	ld hl,04ef7h		;4ea0
	ld bc,0001bh		;4ea3
	ldir		;4ea6
	and 07fh		;4ea8   ; 6 x (musica - 0x80)...
	rlca			;4eaa
	ld e,a			;4eab
	rlca			;4eac
	add a,e			;4ead
	ld hl,0743eh		;4eae   ; ...en la tabla 0x743E (banco 13)...
	add a,l			;4eb1
	ld l,a			;4eb2
	jr nc,L_4EB6		;4eb3
	inc h			;4eb5
L_4EB6:
	ld e,(hl)			;4eb6
	inc hl			;4eb7
	ld d,(hl)			;4eb8
	inc hl			;4eb9
	ld (0e10ch),de		;4eba   ; ...el principio del canal A...
	ld e,(hl)			;4ebe
	inc hl			;4ebf
	ld d,(hl)			;4ec0
	inc hl			;4ec1
	ld (0e127h),de		;4ec2   ; ...el del B...
	ld e,(hl)			;4ec6
	inc hl			;4ec7
	ld d,(hl)			;4ec8
	ld (0e142h),de		;4ec9   ; ...y el del C
	ld hl,0610bh		;4ecd   ; los programas de canal de la musica: 0x610B, 0x6112 y 0x6119
	ld (0e100h),hl		;4ed0   ; guarda los programas de los cuatro canales de sonido (0xE100-0xE107) y el byte siguiente (16 bits)
	ld hl,06112h		;4ed3
	ld (0e102h),hl		;4ed6
	ld hl,06119h		;4ed9
	ld (0e104h),hl		;4edc
	ld a,(0e1b2h)		;4edf   ; sin el bit 1 de 0xE1B2
	and 0fdh		;4ee2
	ld (0e1b2h),a		;4ee4
L_4EE7:
	xor a			;4ee7   ; 0xE1C0, 0xE1C1 y 0xE1C3 a 0, 0xE1C2 = 7
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


efecto:		; el efecto A si no suena uno mayor (tabla 0x73DC, canal 0xE15D)
	ld c,a			;4f12   ; un efecto: no mientras 0xE1C3...
	ld a,(0e1c3h)		;4f13
	or a			;4f16
	ret nz			;4f17
	ld a,(0e1b0h)		;4f18   ; ...ni si suena uno mayor (0xE1C0 es el que suena)
	cp c			;4f1b
	jr z,L_4F1F		;4f1c
	ret nc			;4f1e
L_4F1F:
	cp 025h		;4f1f   ; el 0x25 no suena con 0xE511 = 1
	jr nz,L_4F2C		;4f21
	ld a,(0e511h)		;4f23   ; lee en el agua
	or a			;4f26
	cp 001h		;4f27
	jr nz,L_4F2C		;4f29
	ret			;4f2b
L_4F2C:
	ld a,c			;4f2c   ; el efecto que suena...
	ld (0e1b0h),a		;4f2d
	ld de,0e15dh		;4f30   ; ...su canal 0xE15D desde la plantilla...
	ld hl,04ef7h		;4f33
	ld bc,0001bh		;4f36
	ldir		;4f39
	rlca			;4f3b   ; ...y su principio en la tabla 0x73DC (banco 13)
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
	ld hl,064a5h		;4f4b   ; el programa del canal de efectos: 0x64A5
	ld (0e106h),hl		;4f4e
	ret			;4f51
sonido_especial:		; 0xFA/0xFF se apaga, 0xFB/0xFC, 0xFD/0xFE la pausa
	jr z,L_4F77		;4f52   ; 0xFA, 0xFB, 0xFC, 0xFD, 0xFE...
	cp 0fbh		;4f54
	jp z,L_5064		;4f56
	cp 0fch		;4f59
	jp z,L_50B3		;4f5b
	cp 0fdh		;4f5e
	jr z,pausa_del_sonido		;4f60
	cp 0feh		;4f62
	jp z,fin_de_la_pausa_del_sonido		;4f64   ; fin_de_la_pausa_del_sonido: 0xFE: la musica y el PSG como estaban
	ld a,001h		;4f67   ; 0xFF: se apaga despacio (0xE1C8, 0xE1C4 = 0xFF, 0x30)
	ld (0e1c8h),a		;4f69
	ld a,0ffh		;4f6c
	ld (0e1c4h),a		;4f6e
	ld a,030h		;4f71
	ld (0e1c0h),a		;4f73
	ret			;4f76
L_4F77:
	ld a,001h		;4f77   ; 0xFA: se apaga mas deprisa (0xE1C4 = 0xFA, 0x0A)
	ld (0e1c8h),a		;4f79
	ld a,0fah		;4f7c
	ld (0e1c4h),a		;4f7e
	ld a,00ah		;4f81
	ld (0e1c0h),a		;4f83
	ret			;4f86
pausa_del_sonido:		; 0xFD: guarda la musica y el PSG y calla
	ld a,001h		;4f87   ; 0xFD, la pausa: 0xE1C9 = 1 y el bit 0 de 0xE1B2...
	ld (0e1c9h),a		;4f89
	ld a,(0e1b2h)		;4f8c
	or 001h		;4f8f
	ld (0e1b2h),a		;4f91
	ld a,(0e1c0h)		;4f94   ; ...guarda el estado de la musica en 0xE1B3-0xE1B6...
	ld (0e1b3h),a		;4f97
	ld a,(0e1c1h)		;4f9a
	ld (0e1b4h),a		;4f9d
	ld a,(0e1b1h)		;4fa0
	ld (0e1b5h),a		;4fa3
	ld a,(0e1c2h)		;4fa6
	ld (0e1b6h),a		;4fa9
	xor a			;4fac
	ld (0e1c2h),a		;4fad
	ld a,0bfh		;4fb0   ; ...0xE1B1 = 0xBF (el mezclador sin nada)...
	ld (0e1b1h),a		;4fb2
	xor a			;4fb5   ; ...guarda los registros 0, 1, 8, 9 y 10 del PSG...
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
	ld a,008h		;4fdc   ; ...y calla los tres volumenes
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
	ld hl,06104h		;4ffa   ; el programa de la pausa, 0x6104, en el canal 0xE10A...
	ld (0e10ah),hl		;4ffd
	ld de,0e193h		;5000
	ld hl,04ef7h		;5003
	ld bc,0001bh		;5006
	ldir		;5009
	ld hl,07de5h		;500b   ; ...con su canal 0xE193 desde 0x7DE5
	ld (0e193h),hl		;500e
	jp L_4EE7		;5011
fin_de_la_pausa_del_sonido:		; 0xFE: la musica y el PSG como estaban
	xor a			;5014   ; 0xFE, fin de la pausa: todo como estaba
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
	ld a,(0e1b7h)		;5038   ; los registros del PSG guardados, otra vez
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
	ld a,(0e1b2h)		;5064   ; 0xFB: el bit 1 de 0xE1B2...
	or 002h		;5067
	ld (0e1b2h),a		;5069
	ld a,(0e1b1h)		;506c   ; ...guarda el mezclador...
	ld (0e1bch),a		;506f
	ld a,(0e1b0h)		;5072   ; ...sin efecto sonando, todo apagado (0xBF)...
	or a			;5075
	jr nz,L_507C		;5076
	ld a,0bfh		;5078
	jr L_5081		;507a
L_507C:
	ld a,(0e1b1h)		;507c   ; ...con uno, sin los canales A y B
	or 01bh		;507f
L_5081:
	ld (0e1b1h),a		;5081
	xor a			;5084   ; guarda los registros 0, 1 y 8 del PSG
	call 00096h		;5085   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bdh),a		;5088
	ld a,001h		;508b
	call 00096h		;508d   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1beh),a		;5090
	ld a,008h		;5093
	call 00096h		;5095   ; BIOS RDPSG - Reads value from PSG-register
	ld (0e1bfh),a		;5098
	ld hl,0649eh		;509b   ; el programa 0x649E en 0xE108, con su canal 0xE178 desde 0x7DF2
	ld (0e108h),hl		;509e
	ld de,0e178h		;50a1
	ld hl,04ef7h		;50a4
	ld bc,0001bh		;50a7
	ldir		;50aa
	ld hl,07df2h		;50ac
	ld (0e184h),hl		;50af
	ret			;50b2
L_50B3:
	ld a,(0e1b2h)		;50b3   ; 0xFC: deshace el 0xFB si lo hay
	bit 1,a		;50b6
	ret z			;50b8
	ld a,(0e1b2h)		;50b9
	and 0fdh		;50bc
	ld (0e1b2h),a		;50be
	ld a,(0e1b0h)		;50c1   ; el mezclador como estaba...
	or a			;50c4
	ld a,(0e1bch)		;50c5
	jr z,L_50D8		;50c8
	ld b,a			;50ca   ; ...dejando lo del efecto
	ld a,(0e1b1h)		;50cb
	or 0dbh		;50ce
	and b			;50d0
	ld b,a			;50d1
	ld a,(0e1b1h)		;50d2
	and 024h		;50d5
	or b			;50d7
L_50D8:
	ld (0e1b1h),a		;50d8
	ld a,(0e1bdh)		;50db   ; y los registros 0, 1 y 8 del PSG
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
suena:		; NZ mientras suena algo
	ld a,(0e1c0h)		;50f5   ; NZ mientras suena algo (0xE1C0)...
	or a			;50f8
	jr nz,L_5100		;50f9
	ld a,(0e1c2h)		;50fb   ; ...o 0xE1C2
	or a			;50fe
	ret			;50ff
L_5100:
	ld a,(0e1c1h)		;5100   ; con 0xE1C1 = 0xFB, 0xE1C8 a 0 y Z
	cp 0fbh		;5103
	ret nz			;5105
	xor a			;5106
	ld (0e1c8h),a		;5107
	ret			;510a
monta_la_sala:		; la sala entera con todo lo que lleva
	call borra_e600		;510b   ; montar la sala entera
	call borra_e540		;510e   ; borra_e540: 0xE51C, 0xE51D y 0xE540-0xE5FF a cero
	call graficos_de_la_sala		;5111   ; graficos_de_la_sala: la carga grafica de la sala (tools/vram.py carga_sala)
	call entra_el_personaje		;5114   ; entra_el_personaje: el personaje al entrar: estado a cero y el sitio de la tabla 0xB106
	call a000_banco_9		;5117   ; p09:63C2 con el banco 9
	call 063c2h		;511a
	call a000_banco_3		;511d   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call sala_92		;5120   ; p00:5FA8, p00:51F7 y p00:5200
	call jefe_otra_vez		;5123   ; jefe_otra_vez: si hay jefe, 0xE0D2 = 1
	call cosa_del_jefe_otra_vez		;5126   ; cosa_del_jefe_otra_vez: si estaba puesta, la cosa del jefe vencido
monta_lo_de_la_sala:		; lo que va encima de la sala: figuras, cosas, puertas, escaleras, rotulo
	call esconde_sprites		;5129   ; lo que se monta en cada sala
	call 0602fh		;512c   ; p01:602F
	call vecinas_de_la_sala		;512f   ; vecinas_de_la_sala: las vecinas de la sala (tabla 0xA9EF, banco 9) a 0xE648; con jefe, ninguna
	call marcas_de_la_sala		;5132   ; marcas_de_la_sala: 0xE60C y 0xE60E: los bytes de la sala en el tramo del mapa (0xAF09)
	call a000_banco_15		;5135   ; p15:BCB9 y p15:BD58
	call 0bcb9h		;5138
	call 0bd58h		;513b
	call a000_banco_3		;513e   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 09ae5h		;5141   ; p02:9AE5 y p02:8EEF (la sala especial)
	call sonido_fc		;5144   ; sonido_fc: con 0xE0D5, una vez, el sonido 0xFC
	call 08eefh		;5147
	call monta_la_planta		;514a   ; monta_la_planta: la planta y lo que la cambia (objeto 0x18, mapa 4); no en salas especiales
	ld a,(0e690h)		;514d   ; en una sala especial no se monta lo demas
	or a			;5150
	jr nz,rotulo_del_mapa		;5151
	call a000_banco_9		;5153   ; con el banco 9: la cosa de la sala, p01:691A y p01:656E
	call cosa_de_la_sala		;5156   ; cosa_de_la_sala: pone la cosa de la sala en el hueco 0xE740 si no se ha cogido
	call 0691ah		;5159
	call 0656eh		;515c
	call a000_banco_3		;515f   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call bancos_4_5_6		;5162   ; con los bancos 4, 5 y 6: p04:6054, p04:6000 y p04:6186
	call 06054h		;5165   ; sala_sin_vuelta: 0xE612 en las salas de 0x60EE: las figuras vencidas no vuelven
	call 06000h		;5168   ; figuras_de_la_sala: crea las figuras de la lista de la sala (0xB5CB, banco 6)
	xor a			;516b
	ld (0e612h),a		;516c   ; guarda las figuras vencidas no vuelven en esta sala
	call 06186h		;516f   ; especiales_de_la_sala: lo especial de cada sala (0xE650-0xE66F)
	call bancos_1_2_3		;5172   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	xor a			;5175   ; 0xE6A1 a 0
	ld (0e6a1h),a		;5176
	call 0993dh		;5179   ; p02:993D (las puertas de vuelta), p02:9DAF (las de los mundos), p01:69E3
	call 09dafh		;517c   ; puerta_de_vuelta_de_la_sala: en el castillo, la puerta de vuelta de la sala (0x9DDA) en 0xE680-0xE685
	call 069e3h		;517f   ; cosa_e678: en los mundos, 0xE678-0xE67A de la lista 0x9C83 de la sala
	call bancos_7_8_9		;5182   ; con los bancos 7, 8 y 9: p08:9CFA, p08:9F1A, p08:9E61 y las escaleras (p09:A746)
	call 09cfah		;5185
	call 09f1ah		;5188
	call 09e61h		;518b
	call 0a746h		;518e
	call bancos_1_2_3		;5191   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
	call a000_banco_9		;5194   ; p01:62EF y p01:63EA con el banco 9
	call 062efh		;5197   ; cosas_del_castillo: 0xE6A0 a 0 y lo de la sala del castillo (tabla 0xB8A2)
	call 063eah		;519a   ; figura_ec20: en el castillo, la figura de la tabla 0xBA53 en 0xEC20
	call a000_banco_3		;519d   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call musica_de_la_sala		;51a0   ; p00:5CD0 y lo del objeto 0x14 (p00:5D24)
	call pista_del_objeto_14		;51a3   ; pista_del_objeto_14: con el objeto 0x14, el sonido 0x28 en las salas de la lista del castillo
rotulo_del_mapa:		; el rotulo de arriba (castillo o WORLD) y el numero del mundo
	ld a,(0e041h)		;51a6   ; el rotulo de arriba: el del castillo (0x7D28)...
	dec a			;51a9
	ld de,07d28h		;51aa
	jr z,L_51B2		;51ad
	ld de,07d33h		;51af   ; ...o el de los mundos (0x7D33)
L_51B2:
	call lista_a_vram		;51b2   ; lista_a_vram: pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	ld a,(0e041h)		;51b5   ; en un mundo, su numero: mapa - 1...
	sub 001h		;51b8
	ret z			;51ba
	cp 00ah		;51bb   ; ...el mapa 11 es el 10 (BCD 0x10)...
	jr c,L_51C1		;51bd
	ld a,010h		;51bf
L_51C1:
	ld de,0f000h		;51c1   ; ...en 0xF000...
	ld (de),a			;51c4
	ld b,001h		;51c5   ; ...una cifra o dos
	jp nc,cifras_bcd		;51c7   ; cifras_bcd: pinta B bytes BCD de DE hacia atras en la VRAM de HL
	jp cifra_baja		;51ca   ; cifra_baja: pinta la cifra baja de (DE) y sigue con cifras_bcd
monta_otra_sala:		; la sala al pasar a otra
	call borra_e600		;51cd   ; montar la sala al cambiar de sala
	call graficos_de_la_sala		;51d0   ; graficos_de_la_sala: la carga grafica de la sala (tools/vram.py carga_sala)
	call sitio_al_entrar		;51d3   ; sitio_al_entrar: el sitio del personaje segun el lado por el que sale
	call borra_e540		;51d6   ; borra_e540: 0xE51C, 0xE51D y 0xE540-0xE5FF a cero
	call fin_del_estado_7		;51d9   ; fin_del_estado_7: el estado 7 del personaje vuelve a 0
	jp monta_lo_de_la_sala		;51dc   ; monta_lo_de_la_sala: lo que va encima de la sala: figuras, cosas, puertas, escaleras, rotulo
monta_la_sala_sola:		; la sala, sin sprites
	call graficos_de_la_sala		;51df   ; montar la sala sin el resto
	call esconde_sprites		;51e2   ; esconde_sprites: la copia de la tabla de sprites (0xEC80) con y = 0xE0
	jp monta_la_planta		;51e5   ; monta_la_planta: la planta y lo que la cambia (objeto 0x18, mapa 4); no en salas especiales
monta_la_sala_otra_vez:		; la sala y lo de encima
	call borra_e600		;51e8   ; montar la sala sin p00:5FC3 ni p00:5F9A
	call borra_e540		;51eb   ; borra_e540: 0xE51C, 0xE51D y 0xE540-0xE5FF a cero
	call graficos_de_la_sala		;51ee   ; graficos_de_la_sala: la carga grafica de la sala (tools/vram.py carga_sala)
	call entra_el_personaje		;51f1   ; entra_el_personaje: el personaje al entrar: estado a cero y el sitio de la tabla 0xB106
	jp monta_lo_de_la_sala		;51f4   ; monta_lo_de_la_sala: lo que va encima de la sala: figuras, cosas, puertas, escaleras, rotulo
jefe_otra_vez:		; si hay jefe, 0xE0D2 = 1
	ld hl,0e0d2h		;51f7   ; si hay jefe, 0xE0D2 vuelve a 1
	ld a,(hl)			;51fa
	or a			;51fb
	ret z			;51fc
	ld (hl),001h		;51fd
	ret			;51ff
cosa_del_jefe_otra_vez:		; si estaba puesta, la cosa del jefe vencido
	ld a,(0e0d4h)		;5200   ; con la cosa del jefe vencido puesta...
	or a			;5203
	ret z			;5204
	call dibujo_de_la_cosa_0c		;5205   ; ...vuelve a pintarla
	jp cosa_del_jefe_vencido		;5208   ; cosa_del_jefe_vencido: pone la cosa 0x0C en el sitio de la tabla 0x4BCD del mapa (0xE0D4 = 1)
sonido_fc:		; con 0xE0D5, una vez, el sonido 0xFC
	ld hl,0e0d5h		;520b   ; con 0xE0D5, una vez: el sonido 0xFC
	ld a,(hl)			;520e
	or a			;520f
	ret z			;5210
	ld (hl),000h		;5211
	ld a,0fch		;5213
	jp pide_sonido		;5215   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
vecinas_de_la_sala:		; las vecinas de la sala (tabla 0xA9EF, banco 9) a 0xE648; con jefe, ninguna
	call hay_jefe		;5218   ; con jefe, la sala sin salidas
	jp nz,sala_sin_salidas		;521b   ; sala_sin_salidas: las cuatro vecinas 0xE648-0xE64B a 0xFF
	call bancos_7_8_9		;521e   ; las vecinas de la sala: tabla 0xA9EF del mapa (banco 9)...
	ld a,(0e041h)		;5221   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,0a9efh		;5224
	call palabra_de_tabla		;5227   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,(0e042h)		;522a   ; ...4 bytes por sala...
	ld l,a			;522d
	ld h,000h		;522e
	add hl,hl			;5230
	add hl,hl			;5231
	add hl,de			;5232
	ld de,0e648h		;5233   ; ...a 0xE648-0xE64B
	ld bc,00004h		;5236
	ldir		;5239
	jp bancos_1_2_3		;523b   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
marcas_de_la_sala:		; 0xE60C y 0xE60E: los bytes de la sala en el tramo del mapa (0xAF09)
	call a000_banco_9		;523e   ; con el banco 9: el byte de la sala en el tramo del mapa (0xAF09)...
	ld bc,(0e041h)		;5241   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;5245
	ld hl,0af09h		;5246
	call palabra_de_tabla		;5249   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld l,b			;524c   ; ...sala - 1...
	dec l			;524d
	ld h,000h		;524e
	add hl,de			;5250
	ld (0e60ch),hl		;5251   ; ...en 0xE60C...
	ld de,00150h		;5254   ; ...y el de 0x150 mas alla en 0xE60E
	add hl,de			;5257
	ld (0e60eh),hl		;5258   ; guarda la direccion de las marcas de la sala (0xE60C + 0x150) y el byte siguiente (16 bits)
	jp a000_banco_3		;525b   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
borra_e600:		; 0xE600-0xF03F a cero
	ld hl,0e600h		;525e   ; 0xE600-0xF03F a cero
	ld de,0e601h		;5261
	ld bc,00a3fh		;5264
	ld (hl),000h		;5267
	ldir		;5269
	ret			;526b
borra_e540:		; 0xE51C, 0xE51D y 0xE540-0xE5FF a cero
	ld hl,00000h		;526c   ; 0xE51C-0xE51D y 0xE540-0xE5FF a cero
	ld (0e51ch),hl		;526f   ; guarda las armas 1-4 en pantalla y el byte siguiente (16 bits)
	ld hl,0e540h		;5272   ; apunta a tres huecos de 32 bytes (armas)
	ld de,0e541h		;5275
	ld bc,000bfh		;5278
	ld (hl),000h		;527b
	ldir		;527d
	ret			;527f
esconde_sprites:		; la copia de la tabla de sprites (0xEC80) con y = 0xE0
	ld hl,0ec80h		;5280   ; la copia de la tabla de sprites (0xEC80) toda con y = 0xE0: ninguno se ve
	ld de,0ec81h		;5283
	ld (hl),0e0h		;5286
	ld bc,0007fh		;5288
	ldir		;528b
	ret			;528d
entra_el_personaje:		; el personaje al entrar: estado a cero y el sitio de la tabla 0xB106
	call a000_banco_9		;528e   ; el personaje al entrar en la sala: estado 0...
	xor a			;5291
	ld (0e500h),a		;5292   ; guarda el estado del personaje (5 = hundirse)
	ld (0e503h),a		;5295   ; guarda hacia donde mira el personaje (0 derecha, 1 izquierda, 2 de espaldas)
	ld (0e502h),a		;5298   ; guarda la pose del personaje
	ld (0e508h),a		;529b   ; guarda la espada (1 empieza, 2 golpeando)
	ld (0e518h),a		;529e   ; guarda sin daño (tras un golpe o al entrar)
	ld (0e533h),a		;52a1   ; guarda parpadeando
	inc a			;52a4   ; ...0xE518 = 1, 0xE533 = 2, 0xE532 = 8
	ld (0e518h),a		;52a5   ; guarda sin daño (tras un golpe o al entrar)
	inc a			;52a8
	ld (0e533h),a		;52a9   ; guarda parpadeando
	ld a,008h		;52ac
	ld (0e532h),a		;52ae   ; guarda los cuadros de parpadeo tras un golpe
	ld hl,(0e041h)		;52b1   ; en la sala 0x8A del castillo...
	ld de,08a01h		;52b4
	rst 20h			;52b7
	jr nz,L_52CD		;52b8
	ld a,(0e507h)		;52ba   ; ...entrando por la izquierda (x >= 0x80)...
	or a			;52bd
	jp p,L_52CD		;52be
	ld a,0a8h		;52c1   ; ...aparece en x = 0xA8, y = 0x58
	ld (0e507h),a		;52c3   ; guarda la x del personaje
	ld a,058h		;52c6
	ld (0e505h),a		;52c8   ; guarda la y del personaje
	jr L_52F2		;52cb
L_52CD:
	ld a,(0e041h)		;52cd   ; el sitio de entrada de la sala: tabla 0xB106 del mapa (banco 9)
	ld hl,0b106h		;52d0
	call palabra_de_tabla		;52d3   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;52d6
	ld a,(0e042h)		;52d7   ; lee la sala
	call byte_de_tabla		;52da   ; byte_de_tabla: A = el byte HL + A
	or a			;52dd   ; 0: se queda donde estaba
	jr z,L_52F2		;52de
	ld b,a			;52e0   ; nibble alto: la y (+ 8)
	and 0f0h		;52e1
	add a,008h		;52e3
	ld (0e505h),a		;52e5   ; guarda la y del personaje
	ld a,b			;52e8   ; nibble bajo: la x (x 16)
	rla			;52e9
	rla			;52ea
	rla			;52eb
	rla			;52ec
	and 0f0h		;52ed
	ld (0e507h),a		;52ef   ; guarda la x del personaje
L_52F2:
	jp a000_banco_3		;52f2   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
cuadro_de_partida:		; un cuadro de la partida: todas las rutinas de cada banco
	ld hl,0e604h		;52f5   ; un cuadro de partida: 0xE604 + 1
	inc (hl)			;52f8
	call p8000_banco_14		;52f9   ; con los bancos 14 y 15: lo que va primero (p01)
	call a000_banco_15		;52fc   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	call 076c6h		;52ff
	call 079b2h		;5302
	call 06c56h		;5305
	call 06c95h		;5308
	call 073b7h		;530b
	call 071e3h		;530e
	call figuras_quietas		;5311   ; con las figuras quietas mientras tanto (0xE602 = 1)
	call 073d6h		;5314
	xor a			;5317
	call 06df7h		;5318
	call 0766ch		;531b
	call figuras_sueltas		;531e   ; figuras_sueltas: 0xE602 = 0
	call 07378h		;5321
	call p8000_banco_2		;5324   ; con 2 y 3: p03:AEBC
	call a000_banco_3		;5327   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 0aebch		;532a   ; paredes_del_personaje: las cuatro paredes del personaje a 0xE519
	call p8000_banco_14		;532d   ; p8000_banco_14: pone el banco 14 en 0x8000
	call a000_banco_15		;5330   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	ld a,001h		;5333   ; p01:6DF7 con A = 1
	call 06df7h		;5335
	call 06bb0h		;5338
	call figuras_quietas		;533b   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	call 0746dh		;533e
	call figuras_sueltas		;5341   ; figuras_sueltas: 0xE602 = 0
	call sala_a_vram		;5344   ; la pantalla de la sala a la VRAM
	call 079ddh		;5347
	call 07c7eh		;534a
	call p8000_banco_2		;534d   ; p8000_banco_2: pone el banco 2 en 0x8000
	call a000_banco_3		;5350   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 0a8a0h		;5353   ; izquierda y derecha cambiadas en el mapa 9...
	ld a,(0e002h)		;5356   ; ...el mando, si 0xE002 tiene el bit 7...
	add a,a			;5359
	call m,lee_el_mando		;535a   ; lee_el_mando: el mando en 0xE009 (apretado) y 0xE008 (recien apretado)
	call 0a8a0h		;535d   ; ...y otra vez cambiadas
	call 09b02h		;5360   ; lo tecleado (p02:9B02) y el objeto 0x20 (p02:9BB6)
	call 09bb6h		;5363   ; objeto_20: con el objeto 0x20 y CTRL, todo se para un rato (hasta 16 veces)
	call bancos_7_8_9		;5366   ; con los bancos 7, 8 y 9: las figuras del castillo (p09)
	call 0a036h		;5369
	call 0a12eh		;536c
	call 0a22dh		;536f
	call 0a2b6h		;5372
	call 0a43ah		;5375
	call 0a541h		;5378
	call 0a661h		;537b
	call 0a6b5h		;537e
	call 0a7a4h		;5381
	call bancos_1_2_3		;5384   ; con 1, 2 y 3
	call 06371h		;5387   ; cuenta_huecos_ec30: los tres huecos de 0xEC30: cuentan y se vacian
	call 06398h		;538a   ; objeto_21: con el objeto 0x21 y el boton A, p15:B85C con cada hueco de 0xEC30
	call a000_banco_9		;538d   ; p01:643C y p01:6531 con el banco 9
	call 0643ch		;5390   ; mueve_de_sala_en_sala: mueve las seis de 0xE4A0 y copia en 0xEC10 la de esta sala
	call 06531h		;5393   ; mueve_ec20: la figura de 0xEC20 sube y baja entre sus topes
	call a000_banco_3		;5396   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 0a916h		;5399   ; p03:A916
	call p8000_banco_14		;539c   ; p8000_banco_14: pone el banco 14 en 0x8000
	call a000_banco_15		;539f   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	ld de,0eb00h		;53a2   ; con 14 y 15: las figuras de 0xEB00
	call 077eeh		;53a5   ; debajo_del_castillo: lo de debajo de las figuras del castillo
	call 079b2h		;53a8   ; debajo_ec30: lo de debajo de los huecos de 0xEC30
	call 071e3h		;53ab   ; figuras_del_castillo: las figuras del castillo de cada cuadro
	call 07378h		;53ae   ; huecos_ec30_en_la_copia: los tres huecos de 0xEC30 en la copia de nombres
	call p8000_banco_2		;53b1   ; con 2 y 3: p03:A0F4, p03:AD4C, p03:B095
	call a000_banco_3		;53b4   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 0a0f4h		;53b7   ; personaje: el personaje cada cuadro
	call 0ad4ch		;53ba   ; mueve_armas: las armas se mueven y se acaban fuera de la pantalla
	call 0b095h		;53bd   ; figuras_que_llevan: las figuras de 0xEC10 y 0xEC20 con el personaje
	call bancos_4_5_6		;53c0   ; con los bancos 4, 5 y 6: los enemigos
	call 0b3b4h		;53c3
	call 0b3c5h		;53c6
	call 0aecch		;53c9
	call 0afe8h		;53cc
	call 062dbh		;53cf   ; generadores: cada cuadro, las figuras que salen solas en las salas especiales
	call 069d2h		;53d2   ; humos: cada 16 cuadros un humo (figura 0x5B) alrededor de 0xE6C0
	call bancos_1_2_3		;53d5   ; con 14 y 15: las figuras de 0xEB00 otra vez
	call p8000_banco_14		;53d8   ; p8000_banco_14: pone el banco 14 en 0x8000
	call a000_banco_15		;53db   ; a000_banco_15: pone el banco 15 en 0xA000 (y su copia en 0xF0F3)
	ld hl,0eb00h		;53de   ; apunta a el tampon de 0xEB00 (lo de debajo de las figuras; la contraseña)
	call 07afeh		;53e1   ; repone_el_castillo: lo de 0xEB00 de vuelta en las figuras del castillo
	call 07c7eh		;53e4   ; repone_ec30: vuelve lo de los huecos de 0xEC30
	call p8000_banco_2		;53e7   ; con 2 y 3: el jefe (p01:7EFC) y lo demas de la partida
	call a000_banco_3		;53ea   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	call 07efch		;53ed   ; jefe_cada_cuadro: el jefe: humo, salida y lo de su tipo
	call 09f82h		;53f0   ; objetos_escondidos: los objetos escondidos del castillo (salas 0x30, 0x4B, 0x28, 0x18 y 0x2B)
	call 09beeh		;53f3   ; mira_umbrella: con el objeto 0x26, las 8 ultimas letras contra UMBRELLA
	call 0b701h		;53f6   ; recoge_la_cosa: recoger la cosa de la sala: objeto, marcas y lo del 0x0C
	call 0b492h		;53f9   ; armas_contra_figuras: las armas contra las figuras
	call 0b6c1h		;53fc   ; espada_contra_figuras: la espada contra las figuras
	call 0bb24h		;53ff   ; armas_contra_el_jefe: las armas contra el jefe
	call 0bd55h		;5402   ; espada_al_jefe: la espada contra el jefe
	call 0b9b2h		;5405   ; choque_con_el_jefe: el personaje contra el jefe: golpeado y el daño de 0xBAD2
	call 0b1c1h		;5408   ; choques_con_figuras: el personaje contra las figuras de los huecos
	call 0b40ch		;540b   ; mina_hiere: la explosion del arma 5 hiere al personaje
	call 0b194h		;540e   ; lee_el_monumento: el arma 6 junto a la cosa 0xE678 de la sala: estado 0x0C
	call 0b7d5h		;5411   ; armas_contra_ec30: las armas contra los huecos de 0xEC30
	call 099ffh		;5414   ; entra_en_el_mundo: con abajo delante de la puerta abierta: al estado 8
	call 099c8h		;5417   ; abre_la_puerta: la puerta del mundo se abre poco a poco; abierta, se gasta el objeto 0x0C
	call 09a76h		;541a   ; sale_del_mundo: con abajo delante de la puerta de vuelta: estado 0x10
	call 06171h		;541d   ; vida_y_experiencia: cada 4 cuadros, lo pendiente de vida y experiencia de los dos
	call 06085h		;5420   ; repinta_barras: las barras de los bits de 0xE062
fin_del_cuadro:		; p15:BD06 y p15:BDA1 con las figuras quietas
	call figuras_quietas		;5423   ; al final, con las figuras quietas...
	call a000_banco_15		;5426   ; ...p15:BD06 y p15:BDA1
	call 0bd06h		;5429
	call 0bda1h		;542c
	call a000_banco_3		;542f   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
	jp figuras_sueltas		;5432   ; figuras_sueltas: 0xE602 = 0
vram_del_estado:		; lo de la VRAM en la interrupcion segun el estado (tabla 0x543B)
	ld a,(0e000h)		;5435   ; lo de la VRAM en la interrupcion, segun el estado (tabla 0x543B)
	call despacha		;5438   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	ld a,(0e02eh)		;5465   ; nada mientras suben los textos
	or a			;5468
	ret nz			;5469
	ld a,(0e608h)		;546a   ; solo en un paso de varios cuadros
	or a			;546d
	ret z			;546e
L_546F:
	ld a,(0e602h)		;546f   ; y no con las figuras quietas
	or a			;5472
	ret nz			;5473
sprites_a_vram:		; la copia de la tabla de sprites (0xEC80) a 0x3B00
	ld hl,03b00h		;5474   ; la copia de la tabla de sprites (0xEC80) a la VRAM (0x3B00)...
	call vram_para_escribir		;5477   ; vram_para_escribir: SETWRT de HL y C' = el puerto de datos del VDP
	di			;547a
	exx			;547b
	ld hl,0ec80h		;547c   ; apunta a la copia de la tabla de sprites (128 bytes)
	ld b,080h		;547f   ; ...los 128 bytes
L_5481:
	outi		;5481
	jp nz,L_5481		;5483
	ei			;5486
L_5487:
	ret			;5487
sprites_turnados:		; la tabla de sprites a la VRAM empezando cada cuadro por otro
	ld a,(0e602h)		;5488   ; no con las figuras quietas...
	or a			;548b
	ret nz			;548c
	ld a,(0e603h)		;548d   ; ...con 0xE603, la tabla tal cual
	or a			;5490
	jr nz,sprites_a_vram		;5491
	ld hl,03b00h		;5493   ; si no, los 32 sprites en otro orden cada cuadro...
	call vram_para_escribir		;5496   ; vram_para_escribir: SETWRT de HL y C' = el puerto de datos del VDP
	di			;5499
	exx			;549a
	ld hl,0e601h		;549b   ; ...empezando 0x1C mas alla del de antes (0xE601)...
	ld a,(hl)			;549e
	add a,01ch		;549f
	and 07ch		;54a1
	ld (hl),a			;54a3
	ld e,a			;54a4
	ld d,020h		;54a5
L_54A7:
	ld a,e			;54a7
	ld hl,0ec80h		;54a8   ; apunta a la copia de la tabla de sprites (128 bytes)
	add a,l			;54ab
	ld l,a			;54ac
	ld b,004h		;54ad   ; ...4 bytes...
L_54AF:
	outi		;54af
	jp nz,L_54AF		;54b1
	ld a,e			;54b4   ; ...y el siguiente 12 mas alla: los que coinciden en una linea se turnan
	add a,00ch		;54b5
	and 07ch		;54b7
	ld e,a			;54b9
	dec d			;54ba
	jr nz,L_54A7		;54bb
	ei			;54bd
	ret			;54be
sala_a_vram:		; la pantalla de la sala (0xED80) a las filas 4-23
	di			;54bf   ; la pantalla de la sala (0xED80) a las filas 4-23 de la VRAM (0x3880)...
	ld hl,03880h		;54c0
	call vram_para_escribir		;54c3   ; vram_para_escribir: SETWRT de HL y C' = el puerto de datos del VDP
	exx			;54c6
	ld hl,0ed80h		;54c7   ; apunta a la pantalla de la sala en la copia (filas 4-23)
	ld b,080h		;54ca   ; ...0x80 + 0x100 + 0x100 bytes
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
figuras_quietas:		; 0xE602 = 1: no se tocan los sprites
	ld a,001h		;54dd   ; figuras quietas: 0xE602 = 1...
	jr L_54E2		;54df
figuras_sueltas:		; 0xE602 = 0
	xor a			;54e1   ; ...o 0
L_54E2:
	ld (0e602h),a		;54e2   ; guarda las figuras quietas (no se tocan los sprites)
	ret			;54e5
pantalla_a_cero:		; la copia de la tabla de nombres a cero y a la VRAM
	ld hl,0ed00h		;54e6   ; la copia de la tabla de nombres (0xED00) a cero...
	ld de,0ed01h		;54e9
	ld bc,002ffh		;54ec
	xor a			;54ef
	ld (hl),a			;54f0
	ldir		;54f1
nombres_a_vram:		; la copia de la tabla de nombres (0xED00) a 0x3800
	ld bc,00300h		;54f3   ; ...y entera a la VRAM
nombres_a_vram_bc:		; BC bytes de 0xED00 a 0x3800
	ld hl,03800h		;54f6   ; BC bytes de 0xED00 a 0x3800
	ld de,0ed00h		;54f9   ; apunta a la copia de la tabla de nombres (0x300 bytes)
	jp ldirvm		;54fc   ; ldirvm: LDIRVM de DE a HL
pared_en_fila:		; C si una de las casillas (y+B, x+D) o (y+B, x+E) llega al umbral de 0xF020
	call umbral_de_pared		;54ff   ; dos casillas en fila: la y + B...
	ld a,l			;5502
	add a,b			;5503
	ld l,a			;5504
	push hl			;5505
	ld a,h			;5506   ; ...con la x + D...
	add a,d			;5507
	ld h,a			;5508
	call casilla_de_yx		;5509   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;550c
	pop hl			;550d
	exx			;550e   ; ...acarreo si llega al umbral de 0xF020 (pared)
	cp (hl)			;550f
	exx			;5510
	ccf			;5511
	ret c			;5512
	ld a,h			;5513   ; ...y con la x + E
	add a,e			;5514
	ld h,a			;5515
	call casilla_de_yx		;5516   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;5519
	exx			;551a
	cp (hl)			;551b
	exx			;551c
	ccf			;551d
	ret			;551e
pared_en_columna:		; C si una de las casillas (x+B) o (y+D) llega al umbral de 0xF020
	call umbral_de_pared		;551f   ; dos casillas en columna: la x + B...
	ld a,h			;5522
	add a,b			;5523
	ld h,a			;5524
	push hl			;5525
	call casilla_de_yx		;5526   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;5529
	pop hl			;552a
	exx			;552b   ; ...acarreo si llega al umbral...
	cp (hl)			;552c
	exx			;552d
	ccf			;552e
	ret c			;552f
	push hl			;5530
	ld a,l			;5531   ; ...y la y + D
	add a,d			;5532
	ld l,a			;5533
	call casilla_de_yx		;5534   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;5537
	pop hl			;5538
	exx			;5539
	cp (hl)			;553a
	exx			;553b
	ccf			;553c
	ret c			;553d
pared_en:		; C si la casilla (y+E) llega al umbral de 0xF020
	call umbral_de_pared		;553e   ; una casilla: la y + E
	ld a,l			;5541
	add a,e			;5542
	ld l,a			;5543
	call casilla_de_yx		;5544   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld a,(hl)			;5547
	exx			;5548
	cp (hl)			;5549   ; acarreo si llega al umbral
	exx			;554a
	ccf			;554b
	ret			;554c
umbral_de_pared:		; 0xF020 = 0xBA, o 0xF0 con jefe
	exx			;554d   ; el umbral de pared en 0xF020: 0xBA...
	ld hl,0f020h		;554e
	exx			;5551
	ld c,0bah		;5552
	ld a,(0e0d2h)		;5554   ; ...y 0xF0 con jefe
	and a			;5557
	jr z,L_555C		;5558
	ld c,0f0h		;555a
L_555C:
	ld a,c			;555c
	exx			;555d
	ld (hl),a			;555e
	exx			;555f
	ret			;5560
monta_la_planta:		; la planta y lo que la cambia (objeto 0x18, mapa 4); no en salas especiales
	ld a,(0e690h)		;5561   ; no en las salas especiales
	or a			;5564
	ret nz			;5565
	call bancos_7_8_9		;5566   ; bancos_7_8_9: pone los bancos 7, 8 y 9 (y sus copias en 0xF0F1-0xF0F3)
	call planta_y_recuadro		;5569   ; con los bancos 7, 8 y 9: la planta, lo del objeto 0x18 y lo del mapa 4
	call fila_f0_del_mapa_9		;556c   ; fila_f0_del_mapa_9: con el objeto 0x18 y 0xE619, en el mapa 9 las filas 16-23 a 0xF0
	call sala_del_jefe_del_mapa_4		;556f   ; sala_del_jefe_del_mapa_4: en el mapa 4 con jefe, las paredes de los lados vacias
	jp bancos_1_2_3		;5572   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
fila_f0_del_mapa_9:		; con el objeto 0x18 y 0xE619, en el mapa 9 las filas 16-23 a 0xF0
	ld a,(0e087h)		;5575   ; con el objeto 0x18...
	or a			;5578
	ret z			;5579
	ld a,(0e619h)		;557a   ; ...y 0xE619...
	or a			;557d
	ret z			;557e
	ld a,(0e041h)		;557f   ; ...en el mapa 9...
	cp 009h		;5582
	ret nz			;5584
	ld b,000h		;5585   ; ...las filas 16-23 de la copia se llenan de 0xF0
	ld hl,0ef00h		;5587
L_558A:
	ld (hl),0f0h		;558a
	inc hl			;558c
	djnz L_558A		;558d
	ret			;558f
sala_del_jefe_del_mapa_4:		; en el mapa 4 con jefe, las paredes de los lados vacias
	ld a,(0e041h)		;5590   ; en el mapa 4 con jefe...
	cp 004h		;5593
	ret nz			;5595
	ld a,(0e0d2h)		;5596   ; lee el estado del jefe
	or a			;5599
	jr nz,L_55A1		;559a
	ld a,(0e0d4h)		;559c   ; lee la cosa del jefe vencido puesta
	or a			;559f
	ret z			;55a0
L_55A1:
	ld hl,0f0f0h		;55a1   ; ...0xF0 0xF0 en 0xEFE2...
	ld (0efe2h),hl		;55a4
	ld hl,0ed80h		;55a7   ; ...y las dos primeras columnas...
	call vacia_columna		;55aa   ; vacia_columna: 5 x 3 filas de 2 casillas a 0
	ld hl,0ed9eh		;55ad   ; ...y las dos ultimas de las filas de arriba, vacias
vacia_columna:		; 5 x 3 filas de 2 casillas a 0
	xor a			;55b0   ; 5 veces 3 filas de 2 casillas a 0, saltando una fila
	ld c,005h		;55b1
L_55B3:
	ld b,003h		;55b3
L_55B5:
	ld (hl),a			;55b5   ; dos casillas a 0...
	inc hl			;55b6
	ld (hl),a			;55b7
	ld de,0001fh		;55b8   ; ...y a la fila siguiente
	add hl,de			;55bb
	djnz L_55B5		;55bc
	ld de,00020h		;55be   ; y una fila saltada
	add hl,de			;55c1
	dec c			;55c2
	jr nz,L_55B3		;55c3
	ret			;55c5
planta_y_recuadro:		; la planta y, con 0xE615, el recuadro del jefe (0x9BE2)
	call planta		;55c6   ; la planta...
	ld a,(0e615h)		;55c9   ; ...y con 0xE615 el recuadro de 8 x 8 del jefe...
	or a			;55cc
	ret z			;55cd
	ld hl,09be2h		;55ce   ; ...de la tabla 0x9BE2 + 2 x mapa...
	ld a,(0e041h)		;55d1   ; lee el mapa (1 el castillo, 2-11 los mundos)
	call palabra_de_tabla		;55d4   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;55d7
	ld de,0ee0ch		;55d8   ; ...en la fila 4, columna 12...
	ld a,(0e041h)		;55db   ; lee el mapa (1 el castillo, 2-11 los mundos)
	cp 007h		;55de
	jr nz,L_55E5		;55e0
	ld de,0ee4ch		;55e2   ; ...la 6 en el mapa 7
L_55E5:
	exx			;55e5
	ld b,008h		;55e6
L_55E8:
	exx			;55e8
	ld bc,00008h		;55e9   ; 8 filas de 8
	ldir		;55ec
	ld a,018h		;55ee
	call de_mas_a		;55f0   ; de_mas_a: DE += A
	exx			;55f3
	djnz L_55E8		;55f4
	ret			;55f6
planta:		; los 40 bloques de la sala (tabla 0x6ABE) en la copia de nombres
	ld a,(0e085h)		;55f7   ; sin el objeto 0x16...
	or a			;55fa
	jr nz,L_560D		;55fb
	ld hl,(0e041h)		;55fd   ; ...la sala 6 del mapa 6...
	ld de,00606h		;5600
	or a			;5603
	sbc hl,de		;5604
	jr nz,L_560D		;5606
	ld hl,08daeh		;5608   ; ...sale de la otra planta, 0x8DAE
	jr L_5626		;560b
L_560D:
	ld a,(0e041h)		;560d   ; la planta: tabla 0x6ABE del mapa...
	ld hl,06abeh		;5610
	call palabra_de_tabla		;5613   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,(0e042h)		;5616   ; ...40 bytes por sala...
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
	ld (0f000h),hl		;5626   ; ...que son 8 x 5 bloques de 4 x 4 caracteres...
	ld de,0ed80h		;5629   ; ...a la copia de las filas 4-23
	exx			;562c
	ld de,(0f000h)		;562d
	ld c,005h		;5631
L_5633:
	ld b,008h		;5633
L_5635:
	exx			;5635
	call bloque		;5636   ; bloque: un bloque de 4 x 4 caracteres (0x6000 + 16 x bloque)
	exx			;5639
	djnz L_5635		;563a
	exx			;563c
	ld bc,00060h		;563d   ; la fila de bloques siguiente, 4 filas de caracteres mas abajo
	ex de,hl			;5640
	add hl,bc			;5641
	ex de,hl			;5642
	exx			;5643
	dec c			;5644
	jp nz,L_5633		;5645
	ret			;5648
bloque:		; un bloque de 4 x 4 caracteres (0x6000 + 16 x bloque)
	exx			;5649   ; el bloque (DE): 16 caracteres en 0x6000 + 16 x bloque...
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
	ld a,01ch		;5660   ; ...4 por fila...
	call de_mas_a		;5662   ; de_mas_a: DE += A
	ldi		;5665
	ldi		;5667
	ldi		;5669
	ldi		;566b
	ld a,01ch		;566d
	call de_mas_a		;566f   ; de_mas_a: DE += A
	ldi		;5672
	ldi		;5674
	ldi		;5676
	ldi		;5678
	ld a,01ch		;567a
	call de_mas_a		;567c   ; de_mas_a: DE += A
	ldi		;567f
	ldi		;5681
	ldi		;5683
	ldi		;5685
	ld bc,0ffa0h		;5687   ; ...y DE al bloque de la derecha
	ex de,hl			;568a
	add hl,bc			;568b
	ex de,hl			;568c
	ret			;568d
graficos_de_la_sala:		; la carga grafica de la sala (tools/vram.py carga_sala)
	call figuras_quietas		;568e   ; la carga grafica de la sala, con las figuras quietas
	call fuente		;5691   ; la fuente y lo comun (p00:5E11)
	call bancos_10_11_12		;5694   ; bancos_10_11_12: pone los bancos 10, 11 y 12 (y sus copias en 0xF0F1-0xF0F3)
	call graficos_del_mapa		;5697   ; con los bancos 10, 11 y 12, los graficos del mapa (p00:59E9)
	call a000_banco_9		;569a   ; a000_banco_9: pone el banco 9 en 0xA000 (y su copia en 0xF0F3)
	call tipo_de_cosa		;569d   ; la cosa de la sala (banco 9)...
	push af			;56a0
	call a000_banco_12		;56a1   ; a000_banco_12: pone el banco 12 en 0xA000 (y su copia en 0xF0F3)
	pop af			;56a4
	call nz,dibujo_de_la_cosa		;56a5   ; ...y su dibujo en 0x23B0 si la hay
	call graficos_de_la_sala_del_jefe		;56a8   ; los graficos de la sala del jefe
	call caracteres_del_jefe_en_blanco		;56ab   ; con jefe, unos caracteres en blanco
	ld a,(0e0d2h)		;56ae   ; con el jefe en pie, sus graficos
	or a			;56b1
	call nz,graficos_del_jefe		;56b2   ; graficos_del_jefe: los graficos del jefe 0xE0D3 (fichas 0x6157, copias 0x6202; el 2 por pasos)
	call sprites_de_la_sala		;56b5   ; y los dibujos de sprite
acaba_graficos:		; las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
	call borra_cabecera		;56b8   ; la cabecera de la copia a cero, figuras sueltas y bancos 1-2-3
	call figuras_sueltas		;56bb   ; figuras_sueltas: 0xE602 = 0
	jp bancos_1_2_3		;56be   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
empieza_graficos:		; bancos 10-11-12 y figuras quietas
	call bancos_10_11_12		;56c1   ; bancos_10_11_12: pone los bancos 10, 11 y 12 (y sus copias en 0xF0F1-0xF0F3)
	jp figuras_quietas		;56c4   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
borra_cabecera:		; las filas 0-3 de la copia de nombres a cero
	ld hl,0ed00h		;56c7   ; las filas 0-3 de la copia de nombres a cero
	ld de,0ed01h		;56ca
	ld (hl),000h		;56cd
	ld bc,0007fh		;56cf
	ldir		;56d2
	ret			;56d4
caracteres_del_jefe_en_blanco:		; con jefe, los colores de 0x9C-0xA5 a 0
	ld a,(0e0d4h)		;56d5   ; con la cosa del jefe vencido o con jefe...
	or a			;56d8
	jr nz,L_56E0		;56d9
	ld a,(0e0d2h)		;56db   ; lee el estado del jefe
	or a			;56de
	ret z			;56df
L_56E0:
	exx			;56e0
	ld b,003h		;56e1
	exx			;56e3
	ld hl,004e0h		;56e4   ; ...los colores de los caracteres 0x9C-0xA5 a 0 en los tres tercios
L_56E7:
	ld bc,00050h		;56e7   ; 0x50 bytes de colores a 0...
	xor a			;56ea
	push hl			;56eb
	call 00056h		;56ec   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;56ef
	ld bc,00800h		;56f0   ; ...en cada tercio
	add hl,bc			;56f3
	exx			;56f4
	dec b			;56f5
	exx			;56f6
	jr nz,L_56E7		;56f7
	ret			;56f9
graficos_de_la_sala_del_jefe:		; en la sala del jefe, sin jefe, los graficos de 0x6121
	call sala_del_jefe		;56fa   ; en la sala del jefe del mapa (p00:5DE4)...
	ret nz			;56fd
	ld a,(0e0d2h)		;56fe   ; ...sin el jefe aun...
	or a			;5701
	ret nz			;5702
	ld ix,06121h		;5703   ; ...los graficos de 0x6121 y 0x6128
	call fichas_graficas		;5707   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,06128h		;570a
	jp copias_volteadas		;570e   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
graficos_del_estado_0b:		; los graficos del estado 0x0B (el objeto de 0xE097 en el caracter 0xF1)
	call empieza_graficos		;5711   ; los graficos del estado 0x0B
	call graficos_del_inventario		;5714   ; graficos_del_inventario: los caracteres de 0x6EDA/0x6F91 y el objeto de 0xE097
	call sprites_1d00		;5717   ; sprites_1d00: el rle de 0x7831 a 0x1D00
	jr acaba_graficos		;571a
graficos_del_inventario:		; los caracteres de 0x6EDA/0x6F91 y el objeto de 0xE097
	ld de,06edah		;571c   ; dibujos de 0x6EDA y colores de 0x7385 desde el caracter 0x5A...
	ld hl,022d0h		;571f
	call rle_tres_tercios_trozos		;5722   ; rle_tres_tercios_trozos: el rle con sus trozos en los tres tercios
	ld de,07385h		;5725
	ld hl,002d0h		;5728
	call rle_tres_tercios_trozos		;572b   ; rle_tres_tercios_trozos: el rle con sus trozos en los tres tercios
	ld de,06f91h		;572e   ; ...y de 0x6F91 y 0x73E5 desde el 0x85
	ld hl,02428h		;5731
	call rle_tres_tercios_trozos		;5734   ; rle_tres_tercios_trozos: el rle con sus trozos en los tres tercios
	ld de,073e5h		;5737
	ld hl,00428h		;573a
	call rle_tres_tercios_trozos		;573d   ; rle_tres_tercios_trozos: el rle con sus trozos en los tres tercios
	ld ix,06365h		;5740
	call fichas_graficas		;5744   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld a,(0e097h)		;5747   ; con el nivel 2 o 3 de 0xE097...
	sub 002h		;574a
	ret m			;574c
	add a,02bh		;574d   ; ...el dibujo del objeto 0x2B o 0x2C en el caracter 0xF1
	ld hl,02788h		;574f
	jp dibujo_de_cosa		;5752   ; dibujo_de_cosa: carga el dibujo y los colores de la cosa A (0x6E34/0x6E80) en HL
sprites_1d00:		; el rle de 0x7831 a 0x1D00
	ld de,07831h		;5755   ; el rle de 0x7831 a los dibujos de sprite de 0x1D00
	ld hl,01d00h		;5758
	jp rle_a_vram		;575b   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
graficos_del_estado_0c:		; los graficos del estado 0x0C
	call empieza_graficos		;575e   ; los graficos del estado 0x0C: 0x6139 y 0x6140
	ld ix,06139h		;5761
	call fichas_graficas		;5765   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,06140h		;5768
	call copias_volteadas		;576c   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	jp acaba_graficos		;576f   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
graficos_del_titulo:		; los graficos del titulo
	call figuras_quietas		;5772   ; los graficos del titulo: fondo negro...
	ld b,0e0h		;5775
	call color_de_fondo		;5777   ; color_de_fondo: el registro 7 del VDP = B
	call pantalla_negra		;577a   ; pantalla_negra: la tabla de nombres a 0, sin sprites
	ld ix,09a96h		;577d   ; ...los caracteres de 0x9A96 y 0x9A9D...
	call fichas_graficas		;5781   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,09a9dh		;5784
	call copias_volteadas		;5788   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld hl,01800h		;578b   ; ...y los sprites de 0x99A9
	ld de,099a9h		;578e
	call rle_a_vram		;5791   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	call borra_cabecera		;5794   ; borra_cabecera: las filas 0-3 de la copia de nombres a cero
	jp figuras_sueltas		;5797   ; figuras_sueltas: 0xE602 = 0
graficos_del_final:		; los graficos del final
	call empieza_graficos		;579a   ; los graficos del final
	ld ix,06000h		;579d
	call fichas_graficas		;57a1   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	call fichas_6076		;57a4   ; p00:5A33 y p00:57C4
	call reescribe_2510		;57a7   ; reescribe_2510: 0xA0 bytes de 0x2510 y 0x0510 en los tres tercios
	ld ix,0636ch		;57aa
	call fichas_graficas		;57ae   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,0637fh		;57b1
	call copias_volteadas		;57b5   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld hl,01800h		;57b8   ; y los sprites de 0xBEAF
	ld de,0beafh		;57bb
	call rle_a_vram		;57be   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	jp acaba_graficos		;57c1   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
reescribe_2510:		; 0xA0 bytes de 0x2510 y 0x0510 en los tres tercios
	ld hl,02510h		;57c4   ; 0xA0 bytes de dibujos (0x2510) y de colores (0x0510)...
	call reescribe_tercios		;57c7   ; reescribe_tercios: 0xA0 bytes de HL a 0xE800 y de vuelta a los tres tercios
	ld hl,00510h		;57ca
reescribe_tercios:		; 0xA0 bytes de HL a 0xE800 y de vuelta a los tres tercios
	ld de,0e800h		;57cd   ; ...a 0xE800...
	ld bc,000a0h		;57d0
	push hl			;57d3
	call 00059h		;57d4   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;57d7
	ld de,0e800h		;57d8   ; ...y de vuelta con p00:5BD8
	ld bc,000a0h		;57db
	jp ldirvm_tres_tercios		;57de   ; ldirvm_tres_tercios: LDIRVM en los tres tercios
graficos_de_sala_especial:		; los graficos de la sala especial y lo que vende
	call figuras_quietas		;57e1   ; los graficos de la sala especial
	call caracteres_25d0		;57e4   ; caracteres_25d0: el rle de 0x9BEC en 0x25D0 en color 0xF0
	call bancos_10_11_12		;57e7   ; bancos_10_11_12: pone los bancos 10, 11 y 12 (y sus copias en 0xF0F1-0xF0F3)
	ld ix,06390h		;57ea
	call copias_volteadas		;57ee   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld ix,0635eh		;57f1
	call fichas_graficas		;57f5   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld hl,00780h		;57f8
	ld de,0581dh		;57fb
	ld bc,00008h		;57fe
	call ldirvm_tres_tercios		;5801   ; ldirvm_tres_tercios: LDIRVM en los tres tercios
	ld a,(0e690h)		;5804   ; lee la sala especial (pista o tienda)
	cp 00eh		;5807
	jr nc,L_581A		;5809
	ld hl,05824h		;580b
	call byte_de_tabla		;580e   ; byte_de_tabla: A = el byte HL + A
	or a			;5811
	jr z,L_581A		;5812
	ld hl,02470h		;5814
	call dibujo_de_cosa		;5817   ; dibujo_de_cosa: carga el dibujo y los colores de la cosa A (0x6E34/0x6E80) en HL
L_581A:
	jp acaba_graficos		;581a   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3

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


dibujos_de_hundirse:		; los dibujos de sprite de hundirse (0x7B34 en 0x1900)
	call empieza_graficos		;5832   ; hundirse: los dibujos de sprite del rle de 0x7B34 en 0x1900...
	ld hl,01900h		;5835
	ld de,07b34h		;5838
	call rle_a_vram		;583b   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	ld ix,07b30h		;583e   ; ...y las vueltas de 0x7B30
	call vueltas_de_sprites		;5842   ; vueltas_de_sprites: [de][a][cuantos] hasta 0xFF: dibujos de sprite del reves
	jp acaba_graficos		;5845   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
graficos_del_jefe_si_hay:		; con jefe, sus graficos
	ld a,(0e0d2h)		;5848   ; con jefe, sus graficos
	or a			;584b
	ret z			;584c
	call empieza_graficos		;584d   ; empieza_graficos: bancos 10-11-12 y figuras quietas
	call graficos_del_jefe		;5850   ; graficos_del_jefe: los graficos del jefe 0xE0D3 (fichas 0x6157, copias 0x6202; el 2 por pasos)
	jp acaba_graficos		;5853   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
graficos_del_jefe:		; los graficos del jefe 0xE0D3 (fichas 0x6157, copias 0x6202; el 2 por pasos)
	ld a,(0e0d3h)		;5856   ; los graficos del jefe 0xE0D3...
	cp 002h		;5859
	jr z,L_586C		;585b
	ld hl,06157h		;585d   ; ...fichas de la tabla 0x6157...
	call fichas_de_tabla		;5860   ; fichas_de_tabla: las fichas del elemento A de la tabla HL
	ld a,(0e0d3h)		;5863   ; lee que jefe (0x5E05 + mapa)
	ld hl,06202h		;5866   ; ...y copias de la tabla 0x6202
	jp copias_de_tabla		;5869   ; copias_de_tabla: las copias del elemento A de la tabla HL
L_586C:
	ld a,001h		;586c   ; el jefe 2 va por pasos (0xE61B)...
	ld (0e61bh),a		;586e   ; guarda el paso de los graficos del jefe 2
L_5871:
	call paso_del_jefe_2		;5871   ; ...todos seguidos aqui
	ld a,(0e61bh)		;5874   ; lee el paso de los graficos del jefe 2
	or a			;5877
	jr nz,L_5871		;5878
	ret			;587a
un_paso_del_jefe_2:		; un paso de los graficos del jefe 2
	call empieza_graficos		;587b   ; un paso de los graficos del jefe 2
	call paso_del_jefe_2		;587e   ; paso_del_jefe_2: el paso 0xE61B: fichas 0x6175 (1-7) o copias 0x621A (8-0x2B)
	jp acaba_graficos		;5881   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
paso_del_jefe_2:		; el paso 0xE61B: fichas 0x6175 (1-7) o copias 0x621A (8-0x2B)
	ld a,(0e61bh)		;5884   ; pasos 1-7: fichas en 0x6175 + 7 x paso
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
	call fichas_graficas		;589d   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld a,(0e61bh)		;58a0   ; del 7 solo se sigue con el bit 5 de 0xE709
	cp 007h		;58a3
	jr c,L_58AE		;58a5
	ld a,(0e709h)		;58a7
	bit 5,a		;58aa
	jr z,L_58CE		;58ac
L_58AE:
	ld hl,0e61bh		;58ae   ; paso siguiente
	inc (hl)			;58b1
	ret			;58b2
L_58B3:
	sub 008h		;58b3   ; pasos 8-0x2B: copias en 0x621A + 5 x (paso - 8)
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
	call copias_volteadas		;58c4   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld a,(0e61bh)		;58c7   ; lee el paso de los graficos del jefe 2
	cp 02ch		;58ca
	jr c,L_58AE		;58cc
L_58CE:
	xor a			;58ce   ; y acaba: 0xE61B a 0
	ld (0e61bh),a		;58cf   ; guarda el paso de los graficos del jefe 2
	ret			;58d2
dibujo_de_la_cosa_0c:		; el dibujo de la cosa 0x0C en 0x23B0
	call empieza_graficos		;58d3   ; la cosa 0x0C (la del jefe vencido) en 0x23B0
	ld a,00ch		;58d6
	call dibujo_de_la_cosa		;58d8   ; dibujo_de_la_cosa: el dibujo de la cosa A en el caracter 0x76
	jp acaba_graficos		;58db   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
dibujo_de_la_cosa:		; el dibujo de la cosa A en el caracter 0x76
	ld hl,023b0h		;58de   ; las cosas van al caracter 0x76 (0x23B0)
dibujo_de_cosa:		; carga el dibujo y los colores de la cosa A (0x6E34/0x6E80) en HL
	ld (0f000h),hl		;58e1
	cp 007h		;58e4   ; solo las de dibujo propio, 7-0x2C
	ret c			;58e6
	cp 02dh		;58e7
	ret nc			;58e9
	ld l,a			;58ea   ; su dibujo: tabla 0x6E34...
	ld h,000h		;58eb
	add hl,hl			;58ed
	push hl			;58ee
	ld de,06e34h		;58ef
	add hl,de			;58f2
	ld e,(hl)			;58f3
	inc hl			;58f4
	ld d,(hl)			;58f5
	ld hl,(0f000h)		;58f6
	call rle_tres_tercios		;58f9   ; ...en los tres tercios...
	pop hl			;58fc
	ld de,06e80h		;58fd   ; ...y sus colores: tabla 0x6E80...
	add hl,de			;5900
	ld e,(hl)			;5901
	inc hl			;5902
	ld d,(hl)			;5903
	ld hl,(0f000h)		;5904
	ld bc,0e000h		;5907   ; ...en la tabla de colores (HL - 0x2000)
	add hl,bc			;590a
	jp rle_tres_tercios		;590b   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
sprites_del_personaje:		; los dibujos de sprite del personaje
	call empieza_graficos		;590e   ; los dibujos de sprite del personaje
	call sprites_base		;5911   ; sprites_base: el rle de 0x790B y las vueltas de 0x7907
	jp acaba_graficos		;5914   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
sprites_de_la_taza:		; la taza de la pausa: 0xBF16 (banco 15) a 0x1800
	call a000_banco_15		;5917   ; la taza de la pausa: el rle de 0xBF16 (banco 15) a los dibujos de sprite
	call figuras_quietas		;591a   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	ld hl,01800h		;591d
	ld de,0bf16h		;5920
	call rle_a_vram		;5923   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	call borra_cabecera		;5926   ; borra_cabecera: las filas 0-3 de la copia de nombres a cero
	call figuras_sueltas		;5929   ; figuras_sueltas: 0xE602 = 0
	jp a000_banco_3		;592c   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
sprites_de_la_sala:		; los dibujos de sprite de la sala (tools/sprites.py)
	call sprites_base		;592f   ; los dibujos de sprite de la sala: los del personaje...
	call sprites_1e20		;5932   ; ...los de 0x1E20 y 0x1F20...
	jr juegos_de_la_sala		;5935   ; ...y los juegos de la sala
sprites_base:		; el rle de 0x790B y las vueltas de 0x7907
	ld de,0790bh		;5937   ; el rle de 0x790B a 0x1800 y las vueltas de 0x7907
	ld ix,07907h		;593a
	call rle_con_destino		;593e   ; rle_con_destino: el rle de la direccion que hay en DE
	jp vueltas_de_sprites		;5941   ; vueltas_de_sprites: [de][a][cuantos] hasta 0xFF: dibujos de sprite del reves
sprites_1e20:		; los rle de 0x7849 y 0x7BB2 a 0x1E20 y 0x1F20
	ld de,07849h		;5944   ; el rle de 0x7849 a 0x1E20...
	ld hl,01e20h		;5947
	call rle_a_vram		;594a   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
sprites_1f20:		; el rle de 0x7BB2 a 0x1F20
	ld de,07bb2h		;594d   ; ...y el de 0x7BB2 a 0x1F20
	ld hl,01f20h		;5950
	jp rle_a_vram		;5953   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
sprites_1f20_solos:		; el rle de 0x7BB2 a 0x1F20 con las figuras quietas
	call empieza_graficos		;5956   ; empieza_graficos: bancos 10-11-12 y figuras quietas
	call sprites_1f20		;5959   ; sprites_1f20: el rle de 0x7BB2 a 0x1F20
	jp acaba_graficos		;595c   ; acaba_graficos: las filas 0-3 a cero, figuras sueltas y bancos 1-2-3
juegos_de_la_sala:		; los juegos de sprites de la lista 0x9737 de la sala
	ld a,(0e041h)		;595f   ; los juegos de sprites de la sala: lista de 0x9737 del mapa...
	or a			;5962
	ret z			;5963
	ld hl,09737h		;5964
	call palabra_de_tabla		;5967   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;596a
	ld a,(0e042h)		;596b   ; lee la sala
	dec a			;596e   ; ...saltando una lista (acabada en 0) por sala anterior
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
	ld a,(hl)			;597e   ; cada juego de la lista...
	or a			;597f
	ret z			;5980
	inc hl			;5981
	push hl			;5982
	call juego_de_sprites		;5983   ; ...se carga
	pop hl			;5986
	jr L_597E		;5987
juego_de_sprites:		; el juego A (ficha 0x7C72): dibujos y vueltas
	push af			;5989   ; el juego A: su ficha en 0x7C72...
	ld hl,07c72h		;598a
	call palabra_de_tabla		;598d   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;5990
	call dibujos_de_juego		;5991   ; ...los dibujos...
	inc hl			;5994
	push hl			;5995
	pop ix		;5996
	call vueltas_de_sprites		;5998   ; ...y las vueltas
	pop af			;599b
	cp 039h		;599c   ; el juego 0x39 trae ademas los caracteres de 0x6365
	ret nz			;599e
	ld ix,06365h		;599f
	jp fichas_graficas		;59a3   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
dibujos_de_juego:		; [dibujo][rle] hasta 0: cada rle a 0x1800 + 8 x dibujo
	ld a,(hl)			;59a6   ; [dibujo][rle] hasta un 0: el rle a 0x1800 + 8 x dibujo
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
	call rle_a_vram		;59b9   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	pop hl			;59bc
	jr dibujos_de_juego		;59bd
vueltas_de_sprites:		; [de][a][cuantos] hasta 0xFF: dibujos de sprite del reves
	ld l,(ix+000h)		;59bf   ; [de][a][cuantos] hasta 0xFF: los dibujos de sprite...
	inc l			;59c2
	ret z			;59c3
	dec l			;59c4
	ld h,000h		;59c5
	add hl,hl			;59c7   ; ...desde 0x1810 + 8 x de...
	add hl,hl			;59c8
	add hl,hl			;59c9
	ld bc,01810h		;59ca
	add hl,bc			;59cd
	ex de,hl			;59ce
	ld l,(ix+001h)		;59cf   ; ...a 0x1800 + 8 x a...
	ld h,000h		;59d2
	add hl,hl			;59d4
	add hl,hl			;59d5
	add hl,hl			;59d6
	ld bc,01800h		;59d7
	add hl,bc			;59da
	ld c,(ix+002h)		;59db
	call sprites_del_reves		;59de   ; ...vueltos del reves (p00:5C6B)
	ld bc,00003h		;59e1
	add ix,bc		;59e4
	jp vueltas_de_sprites		;59e6   ; vueltas_de_sprites: [de][a][cuantos] hasta 0xFF: dibujos de sprite del reves
graficos_del_mapa:		; las fichas comunes y las del castillo por zona (0x60D7) o de los mundos
	ld ix,06000h		;59e9   ; los graficos comunes de los mapas: 0x6000 y 0x6037...
	call fichas_graficas		;59ed   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,06037h		;59f0
	call copias_volteadas		;59f4   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld a,(0e041h)		;59f7   ; ...en los mundos, 0x6044
	dec a			;59fa
	ret m			;59fb
	jr z,L_5A05		;59fc
	ld ix,06044h		;59fe
	jp fichas_graficas		;5a02   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
L_5A05:
	ld a,(0e042h)		;5a05   ; en el castillo, la zona de la sala: medio byte de 0x60D7...
	ld b,a			;5a08
	or a			;5a09
	rra			;5a0a
	ld hl,060d7h		;5a0b
	call byte_de_tabla		;5a0e   ; byte_de_tabla: A = el byte HL + A
	bit 0,b		;5a11   ; ...el bajo en las salas impares
	jr nz,L_5A19		;5a13
	rra			;5a15
	rra			;5a16
	rra			;5a17
	rra			;5a18
L_5A19:
	and 00fh		;5a19   ; cada zona carga sus fichas (tabla que sigue)
	call despacha		;5a1b   ; despacha: salta a la entrada A de la tabla de palabras que va detras del call

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
	jp fichas_graficas		;5a30   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
fichas_6076:		; las fichas de 0x6076
	ld ix,06076h		;5a33
	jp fichas_graficas		;5a37   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
L_5A3A:
	ld ix,06083h		;5a3a
	call fichas_graficas		;5a3e   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060a8h		;5a41
	jp copias_volteadas		;5a45   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
L_5A48:
	ld ix,06083h		;5a48
	call fichas_graficas		;5a4c   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060c9h		;5a4f
	call fichas_graficas		;5a53   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060a8h		;5a56
	jp copias_volteadas		;5a5a   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
L_5A5D:
	ld ix,060b1h		;5a5d
	call fichas_graficas		;5a61   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060a1h		;5a64
	call fichas_graficas		;5a68   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060ach		;5a6b
	jp copias_volteadas		;5a6f   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
L_5A72:
	ld ix,060b1h		;5a72
	call fichas_graficas		;5a76   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
	ld ix,060ach		;5a79
	jp copias_volteadas		;5a7d   ; copias_volteadas: copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
L_5A80:
	ld ix,060d0h		;5a80
	jp fichas_graficas		;5a84   ; fichas_graficas: dibujos y colores por rle, fichas de 6 bytes desde IX
copias_de_tabla:		; las copias del elemento A de la tabla HL
	call palabra_de_tabla		;5a87   ; HL = la tabla, A = el elemento: sus copias
	push de			;5a8a
	pop ix		;5a8b
copias_volteadas:		; copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX
	ld a,(ix+000h)		;5a8d   ; [de][a][tercios][cuantos] hasta un 0...
	and a			;5a90
	ret z			;5a91
	ld l,(ix+003h)		;5a92   ; ...a = el caracter de destino...
	ld h,000h		;5a95
	add hl,hl			;5a97
	add hl,hl			;5a98
	add hl,hl			;5a99
	ld (0e03eh),hl		;5a9a   ; guarda cuantos bytes copian las copias volteadas y el byte siguiente (16 bits)
	call lee_caracteres		;5a9d   ; ...copia los dibujos y colores del de origen...
	call vuelta_a_bytes		;5aa0   ; ...dandoles la vuelta...
	call copia_a_tercios		;5aa3   ; ...y los escribe en los tercios del bit 3-5
	ld de,00004h		;5aa6
	add ix,de		;5aa9
	jr copias_volteadas		;5aab
fichas_de_tabla:		; las fichas del elemento A de la tabla HL
	call palabra_de_tabla		;5aad   ; HL = la tabla, A = el elemento: sus fichas
	push de			;5ab0
	pop ix		;5ab1
fichas_graficas:		; dibujos y colores por rle, fichas de 6 bytes desde IX
	ld a,(ix+000h)		;5ab3   ; [tercios][dibujos][caracter][colores] hasta un 0
	and a			;5ab6
	ret z			;5ab7
	rra			;5ab8   ; bit 0: el tercio de abajo (0x1000)
	ld de,01000h		;5ab9
	call c,ficha_en_tercio		;5abc   ; ficha_en_tercio: los dibujos y colores de una ficha en el tercio DE
	bit 1,(ix+000h)		;5abf   ; bit 1: el del medio (0x0800)
	ld de,00800h		;5ac3
	call nz,ficha_en_tercio		;5ac6   ; ficha_en_tercio: los dibujos y colores de una ficha en el tercio DE
	bit 2,(ix+000h)		;5ac9   ; bit 2: el de arriba
	ld de,00000h		;5acd
	call nz,ficha_en_tercio		;5ad0   ; ficha_en_tercio: los dibujos y colores de una ficha en el tercio DE
	ld de,00006h		;5ad3
	add ix,de		;5ad6
	jr fichas_graficas		;5ad8
ficha_en_tercio:		; los dibujos y colores de una ficha en el tercio DE
	ld l,(ix+003h)		;5ada   ; el caracter x 8 en el tercio...
	ld h,000h		;5add
	add hl,hl			;5adf
	add hl,hl			;5ae0
	add hl,hl			;5ae1
	add hl,de			;5ae2
	push hl			;5ae3
	ld de,02000h		;5ae4   ; ...sus dibujos (0x2000 +)...
	add hl,de			;5ae7
	ld e,(ix+001h)		;5ae8
	ld d,(ix+002h)		;5aeb
	push ix		;5aee
	call rle_a_vram		;5af0   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	pop ix		;5af3
	pop hl			;5af5
	ld de,00000h		;5af6
	add hl,de			;5af9
	ld e,(ix+004h)		;5afa   ; ...y sus colores
	ld d,(ix+005h)		;5afd
	push ix		;5b00
	call rle_a_vram		;5b02   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	pop ix		;5b05
	ret			;5b07
vuelta_a_bytes:		; da la vuelta a los bits de los bytes de 0xED00
	ld hl,0ed00h		;5b08   ; da la vuelta a cada byte de 0xED00 (0xE03E bytes)...
	ld de,(0e03eh)		;5b0b   ; lee cuantos bytes copian las copias volteadas y el byte siguiente (16 bits)
L_5B0F:
	ld b,008h		;5b0f
L_5B11:
	rr (hl)		;5b11   ; ...bit a bit, de derecha a izquierda
	adc a,a			;5b13
	djnz L_5B11		;5b14
	ld (hl),a			;5b16
	inc hl			;5b17
	dec de			;5b18
	ld a,d			;5b19
	or e			;5b1a
	jr nz,L_5B0F		;5b1b
	ret			;5b1d
copia_a_tercios:		; los dibujos y colores de 0xED00/0xED40 a los tercios de la ficha
	bit 3,(ix+002h)		;5b1e   ; los tercios de destino: bit 3 el de abajo...
	ld de,01000h		;5b22
	call nz,copia_a_un_tercio		;5b25   ; copia_a_un_tercio: los dibujos y colores de 0xED00/0xED40 al tercio DE
	bit 4,(ix+002h)		;5b28   ; ...bit 4 el del medio...
	ld de,00800h		;5b2c
	call nz,copia_a_un_tercio		;5b2f   ; copia_a_un_tercio: los dibujos y colores de 0xED00/0xED40 al tercio DE
	bit 5,(ix+002h)		;5b32   ; ...bit 5 el de arriba
	ld de,00000h		;5b36
	ret z			;5b39
copia_a_un_tercio:		; los dibujos y colores de 0xED00/0xED40 al tercio DE
	push ix		;5b3a   ; el caracter de destino x 8...
	ld l,(ix+001h)		;5b3c
	ld h,000h		;5b3f
	add hl,hl			;5b41
	add hl,hl			;5b42
	add hl,hl			;5b43
	add hl,de			;5b44
	push hl			;5b45
	ld de,02000h		;5b46   ; ...sus dibujos desde 0xED00...
	add hl,de			;5b49
	ld de,0ed00h		;5b4a   ; apunta a la copia de la tabla de nombres (0x300 bytes)
	ld bc,(0e03eh)		;5b4d   ; lee cuantos bytes copian las copias volteadas y el byte siguiente (16 bits)
	call ldirvm		;5b51   ; ldirvm: LDIRVM de DE a HL
	pop hl			;5b54
	ld de,00000h		;5b55   ; ...y sus colores desde 0xED40
	add hl,de			;5b58
	ld de,0ed40h		;5b59
	ld bc,(0e03eh)		;5b5c   ; lee cuantos bytes copian las copias volteadas y el byte siguiente (16 bits)
	call ldirvm		;5b60   ; ldirvm: LDIRVM de DE a HL
	pop ix		;5b63
	ret			;5b65
lee_caracteres:		; los dibujos y colores del caracter de origen a 0xED00/0xED40
	ld bc,(0e03eh)		;5b66   ; el caracter de origen: sus dibujos...
	ld l,(ix+000h)		;5b6a
	ld h,000h		;5b6d
	add hl,hl			;5b6f
	add hl,hl			;5b70
	add hl,hl			;5b71
	push hl			;5b72
	ld de,02000h		;5b73
	bit 2,(ix+002h)		;5b76   ; ...del tercio de arriba (bit 2), el del medio (bit 1) o el de abajo...
	jr nz,L_5B86		;5b7a
	ld d,028h		;5b7c
	bit 1,(ix+002h)		;5b7e
	jr nz,L_5B86		;5b82
	ld d,030h		;5b84
L_5B86:
	add hl,de			;5b86
	ld de,0ed00h		;5b87   ; ...a 0xED00...
	push ix		;5b8a
	call 00059h		;5b8c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;5b8f
	pop hl			;5b91
	ld de,00000h		;5b92   ; ...y sus colores, del mismo tercio, a 0xED40
	bit 2,(ix+002h)		;5b95
	jr nz,L_5BA5		;5b99
	ld d,008h		;5b9b
	bit 1,(ix+002h)		;5b9d
	jr nz,L_5BA5		;5ba1
	ld d,010h		;5ba3
L_5BA5:
	add hl,de			;5ba5
	ld de,0ed40h		;5ba6
	ld bc,(0e03eh)		;5ba9   ; lee cuantos bytes copian las copias volteadas y el byte siguiente (16 bits)
	push ix		;5bad
	call 00059h		;5baf   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop ix		;5bb2
	ret			;5bb4
pantalla_negra:		; la tabla de nombres a 0, sin sprites
	call sin_sprites		;5bb5   ; la pantalla entera a 0, sin sprites
	call figuras_quietas		;5bb8   ; figuras_quietas: 0xE602 = 1: no se tocan los sprites
	ld hl,03800h		;5bbb
	ld bc,00300h		;5bbe
	xor a			;5bc1
	call 00056h		;5bc2   ; BIOS FILVRM - Fills VRAM with value
	jp figuras_sueltas		;5bc5   ; figuras_sueltas: 0xE602 = 0
vram_para_escribir:		; SETWRT de HL y C' = el puerto de datos del VDP
	ex af,af'			;5bc8   ; la VRAM de HL para escribir...
	call 00053h		;5bc9   ; BIOS SETWRT - Enables VDP to write
	exx			;5bcc
	ld a,(00007h)		;5bcd   ; ...y C' = el puerto de datos del VDP (0x0007)
	ld c,a			;5bd0
	exx			;5bd1
	ex af,af'			;5bd2
	ret			;5bd3
ldirvm:		; LDIRVM de DE a HL
	ex de,hl			;5bd4   ; LDIRVM de DE a HL
	jp 0005ch		;5bd5   ; BIOS LDIRVM - Block transfers to VRAM from memory
ldirvm_tres_tercios:		; LDIRVM en los tres tercios
	exx			;5bd8   ; lo mismo en los tres tercios
	ld b,003h		;5bd9
L_5BDB:
	exx			;5bdb   ; LDIRVM...
	push bc			;5bdc
	push de			;5bdd
	call ldirvm		;5bde   ; ldirvm: LDIRVM de DE a HL
	ld de,00800h		;5be1   ; ...y al tercio siguiente
	add hl,de			;5be4
	pop de			;5be5
	pop bc			;5be6
	exx			;5be7
	djnz L_5BDB		;5be8
	ret			;5bea
filvrm_tres_tercios:		; FILVRM en los tres tercios
	ld d,003h		;5beb   ; FILVRM en los tres tercios
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
rle_tres_tercios:		; el rle de DE en HL y en los otros dos tercios (+0x800)
	ld b,003h		;5bfc   ; el mismo rle en los tres tercios
L_5BFE:
	push bc			;5bfe
	push de			;5bff
	call rle_a_vram		;5c00   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	ld de,00800h		;5c03
	add hl,de			;5c06
	pop de			;5c07
	pop bc			;5c08
	djnz L_5BFE		;5c09
	ret			;5c0b
rle_tres_tercios_trozos:		; el rle con sus trozos en los tres tercios
	ld b,003h		;5c0c   ; el rle en los tres tercios, con sus trozos seguidos hasta un 0
L_5C0E:
	push bc			;5c0e
	push de			;5c0f
	call rle_a_vram		;5c10   ; rle_a_vram: descomprime el rle de DE en la VRAM de HL
	inc de			;5c13
L_5C14:
	call rle_sigue		;5c14   ; los trozos que siguen al primero...
	inc de			;5c17
	ld a,(de)			;5c18   ; ...hasta un 0
	or a			;5c19
	jr nz,L_5C14		;5c1a
	ld de,00800h		;5c1c   ; y al tercio siguiente
	add hl,de			;5c1f
	pop de			;5c20
	pop bc			;5c21
	djnz L_5C0E		;5c22
	ret			;5c24
lista_a_vram:		; pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba
	ld c,0ffh		;5c25   ; C = 0xFF: los bytes tal cual
L_5C27:
	ex de,hl			;5c27   ; [destino] y bytes...
	ld e,(hl)			;5c28
	inc hl			;5c29
	ld d,(hl)			;5c2a
	ex de,hl			;5c2b
	inc de			;5c2c
L_5C2D:
	ld a,(de)			;5c2d
	inc de			;5c2e
	ld b,a			;5c2f
	inc b			;5c30   ; ...0xFF acaba...
	ret z			;5c31
	inc b			;5c32   ; ...0xFE trae otro destino
	jr z,L_5C27		;5c33
	and c			;5c35   ; con C = 0 se escriben ceros
	call 0004dh		;5c36   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;5c39
	jr L_5C2D		;5c3a
borra_lista_vram:		; como lista_a_vram pero escribiendo ceros
	ld c,000h		;5c3c   ; C = 0: borra lo que pinta la lista
	jr L_5C27		;5c3e
rle_con_destino:		; el rle de la direccion que hay en DE
	ex de,hl			;5c40   ; el rle con su destino delante
	ld e,(hl)			;5c41
	inc hl			;5c42
	ld d,(hl)			;5c43
	ex de,hl			;5c44
	inc de			;5c45
rle_a_vram:		; descomprime el rle de DE en la VRAM de HL
	call vram_para_escribir		;5c46   ; la VRAM de HL para escribir
rle_sigue:		; el rle desde DE con la VRAM ya puesta
	ld a,(de)			;5c49   ; 0 acaba
	and a			;5c4a
	ret z			;5c4b
	inc de			;5c4c
	ld b,a			;5c4d
	and 07fh		;5c4e   ; 0x80 + n: n bytes tal cual
	cp b			;5c50
	jr z,L_5C61		;5c51
	and a			;5c53   ; 0x80: otro destino
	jr z,rle_con_destino		;5c54
	ld b,a			;5c56   ; n < 0x80: el byte siguiente n veces
L_5C57:
	ld a,(de)			;5c57   ; n bytes tal cual al puerto del VDP
	inc de			;5c58
	exx			;5c59
	out (c),a		;5c5a
	exx			;5c5c
	djnz L_5C57		;5c5d   ; (C' es el puerto)
	jr rle_sigue		;5c5f
L_5C61:
	ld a,(de)			;5c61
	inc de			;5c62
L_5C63:
	exx			;5c63
	out (c),a		;5c64
	exx			;5c66
	djnz L_5C63		;5c67
	jr rle_sigue		;5c69
sprites_del_reves:		; C sprites de 16 x 16 del reves
	call sprite_del_reves		;5c6b   ; C sprites de 16 x 16 del reves
	ld a,020h		;5c6e
	call de_mas_a		;5c70   ; de_mas_a: DE += A
	dec c			;5c73
	jr nz,sprites_del_reves		;5c74
	ret			;5c76
sprite_del_reves:		; un sprite de 16 x 16 del reves
	push de			;5c77   ; 16 bytes de una mitad...
L_5C78:
	ld b,010h		;5c78
L_5C7A:
	call 0004ah		;5c7a   ; BIOS RDVRM - Reads the content of VRAM
	call bits_del_reves		;5c7d   ; ...con los bits del reves...
	ex de,hl			;5c80   ; ...a la otra mitad
	call 0004dh		;5c81   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;5c84
	inc e			;5c85
	inc hl			;5c86
	djnz L_5C7A		;5c87
	ld a,e			;5c89   ; y luego la otra
	sub 020h		;5c8a
	ld e,a			;5c8c
	bit 4,e		;5c8d
	jr z,L_5C78		;5c8f
	pop de			;5c91
	ret			;5c92
bits_del_reves:		; A con los bits del reves
	push bc			;5c93   ; A con los bits del reves
	ld c,a			;5c94
	ld b,008h		;5c95
L_5C97:
	rr c		;5c97
	rla			;5c99
	djnz L_5C97		;5c9a
	pop bc			;5c9c
	ret			;5c9d
musica_que_espera:		; pide la musica de 0xE01E cuando acaba lo que suena
	ld a,(0e01dh)		;5c9e   ; la musica que espera (0xE01D/0xE01E)...
	or a			;5ca1
	ret z			;5ca2
	call suena		;5ca3   ; ...cuando acaba lo que suena
	ret nz			;5ca6
	di			;5ca7
	ld hl,0e01eh		;5ca8   ; apunta a la musica que espera
	ld a,(hl)			;5cab
	dec l			;5cac
	ld (hl),000h		;5cad
musica:		; la musica A (0xE021 = 1 salvo 0x87-0x8B)
	di			;5caf   ; la musica A: 0xE021 = 1 salvo las 0x87-0x8B
	ld hl,0e021h		;5cb0   ; apunta a la musica del mapa debe volver
	ld (hl),000h		;5cb3
	ld b,a			;5cb5
	sub 087h		;5cb6
	cp 005h		;5cb8
	ld a,b			;5cba
	jr c,L_5CBF		;5cbb
	ld (hl),001h		;5cbd
L_5CBF:
	call pide_sonido		;5cbf   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	ei			;5cc2
	ret			;5cc3
musica_ya:		; sin musica esperando, la musica A
	call sin_musica_esperando		;5cc4   ; sin musica esperando, la musica A ya
	jr musica		;5cc7
sin_musica_esperando:		; 0xE01D-0xE01E a cero
	ld hl,00000h		;5cc9   ; nada esperando
	ld (0e01dh),hl		;5ccc   ; guarda hay musica esperando y el byte siguiente (16 bits)
	ret			;5ccf
musica_de_la_sala:		; la musica de la sala (jefe 0x90, jefe vencido 0x91, 0x8F)
	call musica_del_jefe		;5cd0   ; la musica de la sala
	ret c			;5cd3
	call musica_del_mapa_si		;5cd4   ; musica_del_mapa_si: la musica del mapa si espera la 0x8F o con 0xE021
	ld a,(0e615h)		;5cd7   ; con 0xE615, la 0x8F
	or a			;5cda
	ret z			;5cdb
	ld a,08fh		;5cdc
	jr musica_despues		;5cde
musica_del_jefe:		; C con jefe (0x90) o con la cosa del jefe vencido (0x91)
	ld a,(0e0d4h)		;5ce0   ; con la cosa del jefe vencido, la 0x91...
	or a			;5ce3
	jr nz,L_5CEF		;5ce4
	ld a,(0e0d2h)		;5ce6   ; ...con jefe, la 0x90
	or a			;5ce9
	ret z			;5cea
	ld a,090h		;5ceb
	jr L_5CF1		;5ced
L_5CEF:
	ld a,091h		;5cef
L_5CF1:
	call musica_ya		;5cf1   ; musica_ya: sin musica esperando, la musica A
	scf			;5cf4
	ret			;5cf5
musica_del_mapa_si:		; la musica del mapa si espera la 0x8F o con 0xE021
	ld hl,(0e01dh)		;5cf6   ; si ya esperaba la 0x8F...
	dec l			;5cf9
	jr nz,L_5D02		;5cfa
	ld a,h			;5cfc
	cp 08fh		;5cfd
	jr z,L_5D07		;5cff
	ret			;5d01
L_5D02:
	ld a,(0e021h)		;5d02   ; ...o con 0xE021, la del mapa
	or a			;5d05
	ret z			;5d06
L_5D07:
	call musica_del_mapa		;5d07   ; musica_del_mapa: A = 0x88 en el castillo, 0x8A en los mundos
musica_despues:		; apaga lo que suena y deja esperando la musica A
	di			;5d0a   ; se apaga lo que suena (0xFA)...
	push af			;5d0b
	ld a,0fah		;5d0c
	call pide_sonido		;5d0e   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
	pop af			;5d11
musica_espera:		; deja esperando la musica A
	ld h,a			;5d12   ; ...y la musica A espera
	ld l,001h		;5d13
	ld (0e01dh),hl		;5d15   ; guarda hay musica esperando y el byte siguiente (16 bits)
	ei			;5d18
	ret			;5d19
musica_del_mapa:		; A = 0x88 en el castillo, 0x8A en los mundos
	ld a,(0e041h)		;5d1a   ; la musica del mapa: 0x88 el castillo, 0x8A los mundos
	dec a			;5d1d
	ld a,088h		;5d1e
	ret z			;5d20
	ld a,08ah		;5d21
	ret			;5d23
pista_del_objeto_14:		; con el objeto 0x14, el sonido 0x28 en las salas de la lista del castillo
	ld a,(0e083h)		;5d24   ; con el objeto 0x14...
	or a			;5d27
	ret z			;5d28
	ld a,(0e041h)		;5d29   ; ...en el castillo...
	dec a			;5d2c
	ret nz			;5d2d
	call a000_banco_9		;5d2e   ; a000_banco_9: pone el banco 9 en 0xA000 (y su copia en 0xF0F3)
	call salas_del_objeto_14		;5d31   ; salas_del_objeto_14: la lista de salas del ultimo mundo con el bit 1
	jp a000_banco_3		;5d34   ; a000_banco_3: pone el banco 3 en 0xA000 (y su copia en 0xF0F3)
salas_del_objeto_14:		; la lista de salas del ultimo mundo con el bit 1
	ld hl,0e06ch		;5d37   ; con el bit 1 de las marcas del mapa 11, la lista de 0xBE63 + 0xE06E
	bit 1,(hl)		;5d3a
	jr z,L_5D46		;5d3c
	ld a,(0e06eh)		;5d3e   ; lee el sitio de la puerta del mapa 11 (0-3)
	ld hl,0be63h		;5d41
	jr L_5D55		;5d44
L_5D46:
	ld b,009h		;5d46   ; si no, el ultimo mundo con el bit 1...
	dec l			;5d48
L_5D49:
	bit 1,(hl)		;5d49
	jr nz,L_5D51		;5d4b
	dec l			;5d4d
	djnz L_5D49		;5d4e
	ret			;5d50
L_5D51:
	ld hl,0be4fh		;5d51   ; ...y su lista de 0xBE4F
	ld a,b			;5d54
L_5D55:
	call palabra_de_tabla		;5d55   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ld a,(0e042h)		;5d58   ; si la sala esta en la lista...
	ld b,a			;5d5b
L_5D5C:
	ld a,(de)			;5d5c
	or a			;5d5d
	ret z			;5d5e
	inc de			;5d5f
	cp b			;5d60
	jr nz,L_5D5C		;5d61
	ld a,028h		;5d63   ; ...el sonido 0x28
	jp pide_sonido		;5d65   ; pide_sonido: pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)
cosa_de_la_sala:		; pone la cosa de la sala en el hueco 0xE740 si no se ha cogido
	ld hl,(0e60eh)		;5d68   ; la cosa de la sala: no si ya se cogio (bit 0 de sus marcas)
	bit 0,(hl)		;5d6b
	ret nz			;5d6d
	call tipo_de_cosa		;5d6e   ; su tipo (0xB6FC)...
	ret z			;5d71
	ld c,a			;5d72
	ld b,(hl)			;5d73   ; ...y su sitio: [b7 b6 tipo][y:5 x:3]
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
pon_cosa:		; la cosa C en la y D, x E (hueco 0xE740)
	ld a,d			;5d88   ; sin sitio, nada
	or e			;5d89
	ret z			;5d8a
	ld a,c			;5d8b   ; los objetos (< 0x2D) que ya se tienen no salen
	cp 02dh		;5d8c
	jr nc,L_5DAB		;5d8e
	ld b,000h		;5d90
	ld hl,0e06fh		;5d92
	add hl,bc			;5d95
	ld a,(hl)			;5d96
	or a			;5d97
	ret nz			;5d98
	ld a,c			;5d99   ; la 0x0C no sale con los bits 0-1 de 0xE062 + mapa
	cp 00ch		;5d9a
	jr nz,L_5DAB		;5d9c
	ld a,(0e041h)		;5d9e   ; lee el mapa (1 el castillo, 2-11 los mundos)
	ld hl,0e062h		;5da1   ; apunta a las barras que repintar (bits 0-3)
	call hl_mas_a		;5da4   ; hl_mas_a: HL += A
	ld a,(hl)			;5da7
	and 003h		;5da8
	ret nz			;5daa
L_5DAB:
	ld hl,0e740h		;5dab   ; el hueco 0xE740, si esta libre: el tipo...
	ld a,(hl)			;5dae
	or a			;5daf
	ret nz			;5db0
	ld (hl),c			;5db1
	inc l			;5db2
	inc l			;5db3
	ld a,c			;5db4   ; ...la y (8 mas abajo los tipos 1-6)...
	cp 007h		;5db5
	jr nc,L_5DBD		;5db7
	ld a,d			;5db9
	add a,008h		;5dba
	ld d,a			;5dbc
L_5DBD:
	ld (hl),d			;5dbd   ; ...la x...
	inc l			;5dbe
	ld (hl),e			;5dbf
	ld h,e			;5dc0   ; ...y su casilla en 0xE744
	ld l,d			;5dc1
	call casilla_de_yx		;5dc2   ; casilla_de_yx: HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)
	ld (0e744h),hl		;5dc5   ; guarda la casilla de la cosa de la sala y el byte siguiente (16 bits)
	ret			;5dc8
tipo_de_cosa:		; A = el tipo de la cosa de la sala (0xB6FC), Z sin cosa
	ld bc,(0e041h)		;5dc9   ; la cosa de la sala: fichas de 3 bytes de 0xB6FC + 2 x mapa...
	ld a,c			;5dcd
	ld hl,0b6fch		;5dce
	call palabra_de_tabla		;5dd1   ; palabra_de_tabla: DE = la palabra A de la tabla de HL
	ex de,hl			;5dd4
L_5DD5:
	ld a,(hl)			;5dd5
	or a			;5dd6
	ret z			;5dd7
	inc hl			;5dd8
	cp b			;5dd9   ; ...la de esta sala...
	jr nz,L_5DE0		;5dda
	ld a,(hl)			;5ddc   ; ...A = su tipo
	and 03fh		;5ddd
	ret			;5ddf
L_5DE0:
	inc hl			;5de0
	inc hl			;5de1
	jr L_5DD5		;5de2
sala_del_jefe:		; Z en la sala del jefe del mapa sin vencer
	ld a,(0e041h)		;5de4   ; Z en la sala del jefe del mapa (0x5DFB + mapa), si no esta vencido
	ld hl,0e061h		;5de7   ; apunta a el cambio de vida pendiente de Popolon (con signo)
	call hl_mas_a		;5dea   ; hl_mas_a: HL += A
	bit 2,(hl)		;5ded
	ret nz			;5def
	ld hl,(0e041h)		;5df0   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
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


fuente:		; la fuente (0x9AD3, 0x9B24) y los caracteres 1-0x24 en color 0xF0
	call bancos_13_14_15		;5e11   ; con los bancos 13, 14 y 15: la fuente desde el caracter 1...
	ld de,09ad3h		;5e14
	ld hl,02008h		;5e17
	call rle_tres_tercios		;5e1a   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld de,09b24h		;5e1d   ; ...y desde el 0x0B...
	ld hl,02058h		;5e20
	call rle_tres_tercios		;5e23   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld a,0f0h		;5e26   ; ...en color 0xF0 (blanco sobre transparente)
	ld hl,00008h		;5e28
	ld bc,00120h		;5e2b
	call filvrm_tres_tercios		;5e2e   ; filvrm_tres_tercios: FILVRM en los tres tercios
	jp bancos_1_2_3		;5e31   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
fuente_del_titulo:		; la fuente del titulo y los colores de los primeros caracteres
	call bancos_13_14_15		;5e34   ; la fuente del titulo: colores en franjas...
	call colores_en_franjas		;5e37   ; colores_en_franjas: los 16 primeros caracteres con colores 0-15
	ld de,09ad3h		;5e3a   ; ...las cifras en 0x10...
	ld hl,02080h		;5e3d
	call rle_tres_tercios		;5e40   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld de,09aa2h		;5e43   ; ...0x9AA2 en el 0x1A, 0x9ACC en el 0x20...
	ld hl,020d0h		;5e46
	call rle_tres_tercios		;5e49   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld de,09acch		;5e4c
	ld hl,02100h		;5e4f
	call rle_tres_tercios		;5e52   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld de,09b24h		;5e55   ; ...y las letras en 0x21
	ld hl,02108h		;5e58
	call rle_tres_tercios		;5e5b   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld a,0f0h		;5e5e   ; en color 0xF0 desde el caracter 0x10
	ld hl,00080h		;5e60
	ld bc,00158h		;5e63
	call filvrm_tres_tercios		;5e66   ; filvrm_tres_tercios: FILVRM en los tres tercios
	jp bancos_1_2_3		;5e69   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
caracteres_2160:		; el rle de 0x9AA2 en 0x2160
	call bancos_13_14_15		;5e6c   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	ld de,09aa2h		;5e6f
	ld hl,02160h		;5e72
	call rle_tres_tercios		;5e75   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	jp bancos_1_2_3		;5e78   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
caracteres_2168:		; el rle de 0x9ABD en 0x2168 en color 0xF0
	call bancos_13_14_15		;5e7b   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	ld de,09abdh		;5e7e
	ld hl,02168h		;5e81
	call rle_tres_tercios		;5e84   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld a,0f0h		;5e87
	ld hl,00168h		;5e89
	ld bc,00010h		;5e8c
	call filvrm_tres_tercios		;5e8f   ; filvrm_tres_tercios: FILVRM en los tres tercios
	jp bancos_1_2_3		;5e92   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
caracteres_25d0:		; el rle de 0x9BEC en 0x25D0 en color 0xF0
	call bancos_13_14_15		;5e95   ; bancos_13_14_15: pone los bancos 13, 14 y 15 (y sus copias en 0xF0F1-0xF0F3)
	ld de,09bech		;5e98
	ld hl,025d0h		;5e9b
	call rle_tres_tercios		;5e9e   ; rle_tres_tercios: el rle de DE en HL y en los otros dos tercios (+0x800)
	ld a,0f0h		;5ea1
	ld hl,005d0h		;5ea3
	ld bc,001b0h		;5ea6
	call filvrm_tres_tercios		;5ea9   ; filvrm_tres_tercios: FILVRM en los tres tercios
	jp bancos_1_2_3		;5eac   ; bancos_1_2_3: pone los bancos 1, 2 y 3 (y sus copias en 0xF0F1-0xF0F3)
colores_en_franjas:		; los 16 primeros caracteres con colores 0-15
	ld hl,02000h		;5eaf   ; los dibujos de los 16 primeros a 0...
	ld bc,00080h		;5eb2
	xor a			;5eb5
	call filvrm_tres_tercios		;5eb6   ; filvrm_tres_tercios: FILVRM en los tres tercios
	ld hl,00000h		;5eb9
	ld de,00008h		;5ebc
	ld b,010h		;5ebf
L_5EC1:
	push bc			;5ec1   ; ...y cada uno de un color, de 0 a 15
	ld bc,00008h		;5ec2
	push hl			;5ec5
	call filvrm_tres_tercios		;5ec6   ; filvrm_tres_tercios: FILVRM en los tres tercios
	pop hl			;5ec9
	add hl,de			;5eca
	inc a			;5ecb
	pop bc			;5ecc
	djnz L_5EC1		;5ecd
	ret			;5ecf
mira_las_ranuras:		; busca en todos los slots y subslots las firmas de busca_cartuchos
	xor a			;5ed0   ; ningun cartucho aun
	ld (0f0f8h),a		;5ed1   ; guarda los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)
	ld bc,00400h		;5ed4
	ld hl,0fcc1h		;5ed7   ; EXPTBL: los cuatro slots
L_5EDA:
	push bc			;5eda
	push hl			;5edb
	ld a,(hl)			;5edc
	bit 7,a		;5edd   ; los expandidos se miran por subslots
	jr nz,L_5EF0		;5edf
	call busca_cartuchos		;5ee1   ; busca_cartuchos: mira la firma de Game Master, Q*bert y Knightmare en la otra ranura (0xF0F8)
L_5EE4:
	pop hl			;5ee4
	pop bc			;5ee5
	ld a,(0f0f8h)		;5ee6   ; al primero que se encuentra, se acaba
	and a			;5ee9
	ret nz			;5eea
	inc hl			;5eeb
	inc c			;5eec
	djnz L_5EDA		;5eed
	ret			;5eef
L_5EF0:
	call mira_subslots		;5ef0   ; mira_subslots: busca_cartuchos en los cuatro subslots del slot C
	jr L_5EE4		;5ef3
mira_subslots:		; busca_cartuchos en los cuatro subslots del slot C
	and 080h		;5ef5   ; el slot con el bit de expandido...
	or c			;5ef7
	ld c,a			;5ef8
	ld b,004h		;5ef9
L_5EFB:
	push bc			;5efb
	call busca_cartuchos		;5efc   ; busca_cartuchos: mira la firma de Game Master, Q*bert y Knightmare en la otra ranura (0xF0F8)
	pop bc			;5eff
	ld a,(0f0f8h)		;5f00   ; lee los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)
	and a			;5f03
	ret nz			;5f04
	ld a,c			;5f05   ; ...y los cuatro subslots (+4)
	add a,004h		;5f06
	ld c,a			;5f08
	djnz L_5EFB		;5f09
	ret			;5f0b
busca_cartuchos:		; mira la firma de Game Master, Q*bert y Knightmare en la otra ranura (0xF0F8)
	ld de,05f59h		;5f0c   ; 6 bytes en 0x7FFA del slot: Game Master...
	ld hl,07ffah		;5f0f
	ld b,006h		;5f12
	call compara_en_slot		;5f14   ; compara_en_slot: C si los B bytes de HL en el slot C son los de DE
	jr nc,L_5F1F		;5f17
	ld hl,0f0f8h		;5f19   ; apunta a los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)
	set 2,(hl)		;5f1c
	ret			;5f1e
L_5F1F:
	ld de,05f65h		;5f1f   ; ...6 en 0xBFFA: Q*bert...
	ld hl,0bffah		;5f22
	ld b,006h		;5f25
	call compara_en_slot		;5f27   ; compara_en_slot: C si los B bytes de HL en el slot C son los de DE
	jr nc,L_5F32		;5f2a
	ld hl,0f0f8h		;5f2c   ; apunta a los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)
	set 1,(hl)		;5f2f
	ret			;5f31
L_5F32:
	ld de,05f5fh		;5f32   ; ...o Knightmare
	ld hl,0bffah		;5f35
	ld b,006h		;5f38
	call compara_en_slot		;5f3a   ; compara_en_slot: C si los B bytes de HL en el slot C son los de DE
	ret nc			;5f3d
	ld hl,0f0f8h		;5f3e   ; apunta a los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)
	set 0,(hl)		;5f41
	ret			;5f43
compara_en_slot:		; C si los B bytes de HL en el slot C son los de DE
	push bc			;5f44   ; un byte de HL en el slot C...
	push de			;5f45
	ld a,c			;5f46
	call 0000ch		;5f47   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;5f4a
	pop bc			;5f4b
	ex de,hl			;5f4c   ; ...comparado con el de DE
	cp (hl)			;5f4d
	ex de,hl			;5f4e
	jr nz,L_5F57		;5f4f
	inc hl			;5f51
	inc de			;5f52
	djnz compara_en_slot		;5f53
	scf			;5f55   ; los B iguales: acarreo
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


pinta_flechas:		; las flechas en la fila 0, columna 24
	ld de,0e047h		;5f79   ; las flechas: 3 cifras en la fila 0, columna 24
	ld hl,03818h		;5f7c
	ld b,002h		;5f7f
	jp cifra_baja		;5f81   ; cifra_baja: pinta la cifra baja de (DE) y sigue con cifras_bcd
pinta_monedas:		; las monedas en la fila 1, columna 24
	ld de,0e049h		;5f84   ; las monedas: fila 1
	ld hl,03838h		;5f87
	ld b,002h		;5f8a
	jp cifra_baja		;5f8c   ; cifra_baja: pinta la cifra baja de (DE) y sigue con cifras_bcd
pinta_llaves:		; las llaves en la fila 2, columna 24
	ld de,0e04bh		;5f8f   ; las llaves: fila 2
	ld hl,03858h		;5f92
	ld b,002h		;5f95
	jp cifra_baja		;5f97   ; cifra_baja: pinta la cifra baja de (DE) y sigue con cifras_bcd
fin_del_estado_7:		; el estado 7 del personaje vuelve a 0
	ld a,(0e500h)		;5f9a   ; el estado 7 del personaje, al cambiar de sala, vuelve a 0
	cp 007h		;5f9d
	ret nz			;5f9f
	xor a			;5fa0
	ld (0e500h),a		;5fa1   ; guarda el estado del personaje (5 = hundirse)
	ld (0e518h),a		;5fa4   ; guarda sin daño (tras un golpe o al entrar)
	ret			;5fa7
sala_92:		; en la sala 0x92, 9 bytes de 0x5FBA a 0xE4A1
	ld a,(0e042h)		;5fa8   ; en la sala 0x92, 9 bytes de 0x5FBA a 0xE4A1
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


sitio_al_entrar:		; el sitio del personaje segun el lado por el que sale
	ld a,(0e01fh)		;5fc3   ; 0xE01F = 1 o 2: su sitio (detras)
	dec a			;5fc6
	jr z,$+60		;5fc7
	dec a			;5fc9
	jr z,$+75		;5fca
	ld a,(0e01ah)		;5fcc   ; por arriba (1): aparece abajo, y = 0xB9
	dec a			;5fcf
	jr z,L_5FDC		;5fd0
	dec a			;5fd2   ; por abajo (2): arriba, y = 0x28
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
	ld (0e505h),a		;5fe2   ; guarda la y del personaje
	ld hl,0ec12h		;5fe5   ; con el bit 0 de 0xEC12...
	bit 0,(hl)		;5fe8
	ret z			;5fea
	ld de,00006h		;5feb   ; ...la y mas lo de 0xEC18
	add hl,de			;5fee
	ld e,(hl)			;5fef
	ld d,(hl)			;5ff0
	ld h,a			;5ff1
	ld l,000h		;5ff2
	add hl,de			;5ff4
	ld (0e505h),hl		;5ff5   ; guarda la y del personaje y el byte siguiente (16 bits)
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
