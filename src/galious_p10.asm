; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 10 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS caracteres_6000: 9 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:59ED (55 bytes)
;   0x6000..0x6037  (55 bytes)
DATA_caracteres_6000:
	defb 007h,099h,063h,025h,063h,065h	; 6000
	defb 007h,04fh,06ch,07ah,0dbh,06ch	; 6006
	defb 007h,060h,06dh,0c2h,0d0h,06dh	; 600c
	defb 007h,00eh,066h,0bah,030h,066h	; 6012
	defb 007h,03fh,066h,09ah,059h,069h	; 6018
	defb 007h,03fh,066h,06dh,059h,069h	; 601e
	defb 007h,051h,066h,0b6h,06bh,069h	; 6024
	defb 007h,068h,066h,0f0h,06dh,066h	; 602a
	defb 007h,068h,066h,06ch,06dh,066h	; 6030
	defb 000h	; 6036

; ----------------------------------------------------------------------
; DATOS copias_6037: 3 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:59F4 (13 bytes)
;   0x6037..0x6044  (13 bytes)
DATA_copias_6037:
	defb 044h,04ah,03ch,004h	; 6037
	defb 08dh,093h,03ch,006h	; 603b
	defb 0d3h,0dah,03ch,007h	; 603f
	defb 000h	; 6043

; ----------------------------------------------------------------------
; DATOS caracteres_6044: 6 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5A02 (37 bytes)
;   0x6044..0x6069  (37 bytes)
DATA_caracteres_6044:
	defb 007h,0beh,06bh,09ch,031h,06ch	; 6044
	defb 007h,0ddh,06bh,0a0h,034h,06ch	; 604a
	defb 007h,0ddh,06bh,0f1h,034h,06ch	; 6050
	defb 007h,00fh,06ch,0a6h,03eh,06ch	; 6056
	defb 007h,0ddh,06bh,0f1h,034h,06ch	; 605c
	defb 007h,077h,066h,0f0h,080h,066h	; 6062
	defb 000h	; 6068

; ----------------------------------------------------------------------
; DATOS caracteres_6069: 2 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5A30 (13 bytes)
;   0x6069..0x6076  (13 bytes)
DATA_caracteres_6069:
	defb 007h,089h,066h,09ch,07ah,069h	; 6069
	defb 007h,0a8h,066h,0a2h,07dh,069h	; 606f
	defb 000h	; 6075

; ----------------------------------------------------------------------
; DATOS caracteres_6076: 2 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5A37 (13 bytes)
;   0x6076..0x6083  (13 bytes)
DATA_caracteres_6076:
	defb 007h,046h,067h,09ch,0a6h,069h	; 6076
	defb 007h,065h,067h,0a2h,0a9h,069h	; 607c
	defb 000h	; 6082

; ----------------------------------------------------------------------
; DATOS caracteres_6083: 6 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; se solapan 2 bloques (0x6083-0x60A8, 0x60A1-0x60A8); lo leen
;   p00:5A4C, p00:5A68 (37 bytes)
;   0x6083..0x60a8  (37 bytes)
DATA_caracteres_6083:
	defb 007h,008h,068h,09ch,0aeh,069h	; 6083
	defb 007h,03ch,068h,0a0h,0cah,069h	; 6089
	defb 007h,06bh,068h,0a6h,0edh,069h	; 608f
	defb 007h,029h,068h,099h,0b8h,069h	; 6095
	defb 007h,033h,068h,0b4h,0c1h,069h	; 609b
	defb 007h,0f5h,068h,0f1h,02ch,06ah	; 60a1
	defb 000h	; 60a7

; ----------------------------------------------------------------------
; DATOS copias_60A8: 2 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); se solapan 2 bloques (0x60A8-0x60B1,
;   0x60AC-0x60B1); lo leen p00:5A5A, p00:5A7D (9 bytes)
;   0x60a8..0x60b1  (9 bytes)
DATA_copias_60A8:
	defb 0a6h,0adh,03ch,007h	; 60a8
	defb 0f1h,0f7h,03ch,006h	; 60ac
	defb 000h	; 60b0

; ----------------------------------------------------------------------
; DATOS caracteres_60B1: 5 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; se solapan 2 bloques (0x60B1-0x60D0, 0x60C9-0x60D0); lo leen
;   p00:5A53, p00:5A76 (31 bytes)
;   0x60b1..0x60d0  (31 bytes)
DATA_caracteres_60B1:
	defb 007h,008h,068h,09ch,0aeh,069h	; 60b1
	defb 007h,0a2h,068h,0a0h,007h,06ah	; 60b7
	defb 007h,0c1h,068h,0a6h,00ah,06ah	; 60bd
	defb 007h,0dbh,068h,0a9h,018h,06ah	; 60c3
	defb 007h,027h,069h,0f1h,056h,06ah	; 60c9
	defb 000h	; 60cf

; ----------------------------------------------------------------------
; DATOS caracteres_60D0: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5A84 (7 bytes)
;   0x60d0..0x60d7  (7 bytes)
DATA_caracteres_60D0:
	defb 007h,077h,06ah,09ch,039h,06bh	; 60d0
	defb 000h	; 60d6

; ----------------------------------------------------------------------
; DATOS zonas_del_castillo: un nibble por sala del castillo (sala / 2 el byte;
;   el bajo las impares) que elige cual de los 7 juegos de caracteres pone
;   p00:5A1B (74 bytes para las salas 0-147); lo leen p00:5A0E (74 bytes)
;   0x60d7..0x6121  (74 bytes)
DATA_zonas_del_castillo:
	defb 004h,052h,036h,042h,025h,016h,066h,044h,041h,011h,066h,066h,042h,041h,011h,016h	; 60d7  .R6B%.fDA.ffBA..
	defb 066h,054h,011h,016h,066h,000h,000h,000h,011h,011h,000h,000h,010h,000h,001h,016h	; 60e7  fT..f...........
	defb 011h,010h,000h,000h,001h,011h,066h,061h,011h,000h,002h,066h,010h,000h,024h,044h	; 60f7  ......fa...f..$D
	defb 056h,066h,011h,044h,054h,014h,044h,066h,060h,005h,042h,011h,023h,016h,060h,000h	; 6107  Vf.DT.Df`.B.#.`.
	defb 022h,021h,011h,000h,002h,022h,021h,011h,000h,000h	; 6117  "!..."!...

; ----------------------------------------------------------------------
; DATOS caracteres_6121: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5707 (7 bytes)
;   0x6121..0x6128  (7 bytes)
DATA_caracteres_6121:
	defb 007h,060h,0b7h,05ah,040h,0b9h	; 6121
	defb 000h	; 6127

; ----------------------------------------------------------------------
; DATOS copias_6128: 4 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:570E (17 bytes)
;   0x6128..0x6139  (17 bytes)
DATA_copias_6128:
	defb 05ah,078h,03ch,008h	; 6128
	defb 062h,080h,03ch,008h	; 612c
	defb 06ah,088h,03ch,008h	; 6130
	defb 072h,090h,03ch,006h	; 6134
	defb 000h	; 6138

; ----------------------------------------------------------------------
; DATOS caracteres_6139: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5765 (7 bytes)
;   0x6139..0x6140  (7 bytes)
DATA_caracteres_6139:
	defb 007h,045h,0b9h,05ah,0a7h,0bah	; 6139
	defb 000h	; 613f

; ----------------------------------------------------------------------
; DATOS copias_6140: 6 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:576C (25 bytes)
;   0x6140..0x6159  (25 bytes)
DATA_copias_6140:
	defb 06bh,08fh,03ch,008h	; 6140
	defb 073h,097h,03ch,003h	; 6144
	defb 076h,0bah,03ch,008h	; 6148
	defb 07eh,0c2h,03ch,008h	; 614c
	defb 086h,0cah,03ch,008h	; 6150
	defb 08eh,0d2h,03ch,001h	; 6154
	defb 000h	; 6158

; ----------------------------------------------------------------------
; DATOS tabla_6157: 11 punteros (0xE0D3 = 1-11; la palabra 0 no es un puntero)
;   a fichas de caracteres (0x5AB3); lo leen p00:5860 (22 bytes)
;   0x6159..0x616f  (22 bytes)
DATA_tabla_6157:
	defb 06fh,061h	; 6159
	defb 0ach,061h	; 615b
	defb 0adh,061h	; 615d
	defb 0b4h,061h	; 615f
	defb 0bbh,061h	; 6161
	defb 0bch,061h	; 6163
	defb 0cfh,061h	; 6165
	defb 0dch,061h	; 6167
	defb 0e3h,061h	; 6169
	defb 0eah,061h	; 616b
	defb 0fdh,061h	; 616d

; ----------------------------------------------------------------------
; DATOS caracteres_616F: 2 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (13 bytes)
;   0x616f..0x617c  (13 bytes)
DATA_caracteres_616F:
	defb 007h,015h,09ah,05ah,0bdh,09ch	; 616f
	defb 007h,0fah,09bh,0bah,021h,09dh	; 6175
	defb 000h	; 617b

; ----------------------------------------------------------------------
; DATOS fichas_sin_uso: SIN USO: seis listas de fichas de caracteres (0x5AB3)
;   de un solo tercio cada una (4, 2 y 1 dos veces: [tercios][dibujos][primer
;   caracter][colores] y un 0), entre la lista de la entrada 1 de 0x6157 (que
;   acaba en 0x617C) y la de la entrada 2 (0x61AC). Ninguna palabra de los 128
;   KB apunta a ellas: apuntan a los rle sin uso de 0xA148-0xA4BC del banco 12
;   (64 caracteres desde el 0x5A y 6 desde el 0xBA)
;   0x617c..0x61ac  (48 bytes)
DATA_fichas_sin_uso:
	defb 004h,048h,0a1h,05ah,068h,0a3h,000h	; 617c
	defb 002h,048h,0a1h,05ah,068h,0a3h,000h	; 6183
	defb 001h,048h,0a1h,05ah,068h,0a3h,000h	; 618a
	defb 004h,036h,0a3h,0bah,09dh,0a4h,000h	; 6191
	defb 002h,036h,0a3h,0bah,09dh,0a4h,000h	; 6198
	defb 001h,036h,0a3h,0bah,09dh,0a4h,000h	; 619f
	defb 007h,0a1h,09dh,0c8h,0c6h,09dh	; 61a6

; ----------------------------------------------------------------------
; DATOS caracteres_61AC: 0 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (1 bytes)
;   0x61ac..0x61ad  (1 bytes)
DATA_caracteres_61AC:
	defb 000h	; 61ac

; ----------------------------------------------------------------------
; DATOS caracteres_61AD: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (7 bytes)
;   0x61ad..0x61b4  (7 bytes)
DATA_caracteres_61AD:
	defb 007h,0deh,0a8h,05ah,041h,0aah	; 61ad
	defb 000h	; 61b3

; ----------------------------------------------------------------------
; DATOS caracteres_61B4: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (7 bytes)
;   0x61b4..0x61bb  (7 bytes)
DATA_caracteres_61B4:
	defb 007h,0bch,0a4h,05ah,0e2h,0a5h	; 61b4
	defb 000h	; 61ba

; ----------------------------------------------------------------------
; DATOS caracteres_61BB: 0 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (1 bytes)
;   0x61bb..0x61bc  (1 bytes)
DATA_caracteres_61BB:
	defb 000h	; 61bb

; ----------------------------------------------------------------------
; DATOS caracteres_61BC: 3 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (19 bytes)
;   0x61bc..0x61cf  (19 bytes)
DATA_caracteres_61BC:
	defb 007h,040h,0aeh,05ah,0cdh,0b1h	; 61bc
	defb 007h,036h,0b0h,0bah,0a3h,0b2h	; 61c2
	defb 007h,0a1h,09dh,0a6h,0c6h,09dh	; 61c8
	defb 000h	; 61ce

; ----------------------------------------------------------------------
; DATOS caracteres_61CF: 2 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (13 bytes)
;   0x61cf..0x61dc  (13 bytes)
DATA_caracteres_61CF:
	defb 007h,0a9h,0a6h,05ah,039h,0a8h	; 61cf
	defb 007h,0d8h,0a8h,0dch,0dbh,0a8h	; 61d5
	defb 000h	; 61db

; ----------------------------------------------------------------------
; DATOS caracteres_61DC: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (7 bytes)
;   0x61dc..0x61e3  (7 bytes)
DATA_caracteres_61DC:
	defb 007h,0e0h,0ach,05ah,0c3h,0adh	; 61dc
	defb 000h	; 61e2

; ----------------------------------------------------------------------
; DATOS caracteres_61E3: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (7 bytes)
;   0x61e3..0x61ea  (7 bytes)
DATA_caracteres_61E3:
	defb 007h,0f8h,0aah,05ah,036h,0ach	; 61e3
	defb 000h	; 61e9

; ----------------------------------------------------------------------
; DATOS caracteres_61EA: 3 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (19 bytes)
;   0x61ea..0x61fd  (19 bytes)
DATA_caracteres_61EA:
	defb 007h,0dfh,09dh,05ah,01ah,0a0h	; 61ea
	defb 007h,0aah,09fh,0bah,0edh,0a0h	; 61f0
	defb 007h,0a1h,09dh,0c8h,0c6h,09dh	; 61f6
	defb 000h	; 61fc

; ----------------------------------------------------------------------
; DATOS caracteres_61FD: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5860 (7 bytes)
;   0x61fd..0x6204  (7 bytes)
DATA_caracteres_61FD:
	defb 007h,07ah,0b3h,05ah,020h,0b5h	; 61fd
	defb 000h	; 6203

; ----------------------------------------------------------------------
; DATOS tabla_6202: 11 punteros (0xE0D3 = 1-11; la palabra 0 no es un puntero)
;   a fichas de copia (0x5A8D); lo leen p00:5869 (22 bytes)
;   0x6204..0x621a  (22 bytes)
DATA_tabla_6202:
	defb 05dh,063h	; 6204
	defb 05dh,063h	; 6206
	defb 0d4h,062h	; 6208
	defb 045h,063h	; 620a
	defb 0d3h,062h	; 620c
	defb 05dh,063h	; 620e
	defb 0edh,062h	; 6210
	defb 013h,063h	; 6212
	defb 00ah,063h	; 6214
	defb 05dh,063h	; 6216
	defb 024h,063h	; 6218

; ----------------------------------------------------------------------
; DATOS copias_de_cosas: 37 fichas de copia de caracteres (0x5A8D), una por
;   cosa 8-0x2C, de 5 bytes ([desde][hasta][tercios][cuantos] y el 0 que
;   acaba): p00:58B3 apunta IX a 0x621A + 5 x (0xE61B - 8)
;   0x621a..0x62d3  (185 bytes)
DATA_copias_de_cosas:
	defb 05ah,05ah,039h,002h,000h	; 621a
	defb 05ch,05ch,039h,002h,000h	; 621f
	defb 05eh,05eh,039h,002h,000h	; 6224
	defb 060h,060h,039h,002h,000h	; 6229
	defb 062h,062h,039h,002h,000h	; 622e
	defb 064h,064h,039h,002h,000h	; 6233
	defb 066h,066h,039h,002h,000h	; 6238
	defb 068h,068h,039h,002h,000h	; 623d
	defb 06ah,06ah,039h,002h,000h	; 6242
	defb 06ch,06ch,039h,002h,000h	; 6247
	defb 06eh,06eh,039h,002h,000h	; 624c
	defb 070h,070h,039h,002h,000h	; 6251
	defb 072h,072h,039h,002h,000h	; 6256
	defb 074h,074h,039h,002h,000h	; 625b
	defb 076h,076h,039h,002h,000h	; 6260
	defb 078h,078h,039h,002h,000h	; 6265
	defb 07ah,07ah,039h,002h,000h	; 626a
	defb 07ch,07ch,039h,002h,000h	; 626f
	defb 07eh,07eh,039h,002h,000h	; 6274
	defb 080h,080h,039h,002h,000h	; 6279
	defb 082h,082h,039h,002h,000h	; 627e
	defb 084h,084h,039h,002h,000h	; 6283
	defb 086h,086h,039h,002h,000h	; 6288
	defb 088h,088h,039h,002h,000h	; 628d
	defb 08ah,08ah,039h,002h,000h	; 6292
	defb 08ch,08ch,039h,002h,000h	; 6297
	defb 08eh,08eh,039h,002h,000h	; 629c
	defb 090h,090h,039h,002h,000h	; 62a1
	defb 092h,092h,039h,002h,000h	; 62a6
	defb 094h,094h,039h,002h,000h	; 62ab
	defb 096h,096h,039h,002h,000h	; 62b0
	defb 098h,098h,039h,002h,000h	; 62b5
	defb 0bah,0bah,039h,002h,000h	; 62ba
	defb 0bch,0bch,039h,002h,000h	; 62bf
	defb 0beh,0beh,039h,002h,000h	; 62c4
	defb 0c8h,0c8h,039h,002h,000h	; 62c9
	defb 0cah,0cah,039h,003h,000h	; 62ce

; ----------------------------------------------------------------------
; DATOS copias_62D3: 0 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (1 bytes)
;   0x62d3..0x62d4  (1 bytes)
DATA_copias_62D3:
	defb 000h	; 62d3

; ----------------------------------------------------------------------
; DATOS copias_62D4: 6 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (25 bytes)
;   0x62d4..0x62ed  (25 bytes)
DATA_copias_62D4:
	defb 05ah,086h,03ch,008h	; 62d4
	defb 062h,08eh,03ch,008h	; 62d8
	defb 06ah,096h,03ch,004h	; 62dc
	defb 06eh,0bah,03ch,008h	; 62e0
	defb 076h,0c2h,03ch,008h	; 62e4
	defb 07eh,0cah,03ch,008h	; 62e8
	defb 000h	; 62ec

; ----------------------------------------------------------------------
; DATOS copias_62ED: 7 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (29 bytes)
;   0x62ed..0x630a  (29 bytes)
DATA_copias_62ED:
	defb 064h,090h,03ch,008h	; 62ed
	defb 06ch,098h,03ch,002h	; 62f1
	defb 06eh,0bah,03ch,008h	; 62f5
	defb 076h,0c2h,03ch,008h	; 62f9
	defb 07eh,0cah,03ch,008h	; 62fd
	defb 086h,0d2h,03ch,008h	; 6301
	defb 08eh,0dah,03ch,002h	; 6305
	defb 000h	; 6309

; ----------------------------------------------------------------------
; DATOS copias_630A: 2 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (9 bytes)
;   0x630a..0x6313  (9 bytes)
DATA_copias_630A:
	defb 07bh,085h,03ch,008h	; 630a
	defb 083h,08dh,03ch,002h	; 630e
	defb 000h	; 6312

; ----------------------------------------------------------------------
; DATOS copias_6313: 4 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (17 bytes)
;   0x6313..0x6324  (17 bytes)
DATA_copias_6313:
	defb 05ah,077h,03ch,008h	; 6313
	defb 062h,07fh,03ch,008h	; 6317
	defb 06ah,087h,03ch,008h	; 631b
	defb 072h,08fh,03ch,005h	; 631f
	defb 000h	; 6323

; ----------------------------------------------------------------------
; DATOS copias_6324: 8 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5869 (33 bytes)
;   0x6324..0x6345  (33 bytes)
DATA_copias_6324:
	defb 05ch,094h,03ch,006h	; 6324
	defb 062h,0bah,03ch,008h	; 6328
	defb 06ah,0c2h,03ch,008h	; 632c
	defb 072h,0cah,03ch,008h	; 6330
	defb 07ah,0d2h,03ch,008h	; 6334
	defb 082h,0dah,03ch,008h	; 6338
	defb 08ah,0e2h,03ch,008h	; 633c
	defb 092h,0eah,03ch,002h	; 6340
	defb 000h	; 6344

; ----------------------------------------------------------------------
; DATOS copias_6345: 6 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); se solapan 2 bloques (0x6345-0x635E,
;   0x635D-0x635E); lo leen p00:5869 (25 bytes)
;   0x6345..0x635e  (25 bytes)
DATA_copias_6345:
	defb 05ah,07fh,03ch,008h	; 6345
	defb 062h,087h,03ch,008h	; 6349
	defb 06ah,08fh,03ch,008h	; 634d
	defb 072h,097h,03ch,003h	; 6351
	defb 075h,0bah,03ch,008h	; 6355
	defb 07dh,0c2h,03ch,002h	; 6359
	defb 000h	; 635d

; ----------------------------------------------------------------------
; DATOS caracteres_635E: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:57F5 (7 bytes)
;   0x635e..0x6365  (7 bytes)
DATA_caracteres_635E:
	defb 007h,08ah,076h,06ah,09ch,077h	; 635e
	defb 000h	; 6364

; ----------------------------------------------------------------------
; DATOS caracteres_6365: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:59A3 (7 bytes)
;   0x6365..0x636c  (7 bytes)
DATA_caracteres_6365:
	defb 007h,0d2h,075h,076h,043h,076h	; 6365
	defb 000h	; 636b

; ----------------------------------------------------------------------
; DATOS caracteres_636C: 3 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:57AE (19 bytes)
;   0x636c..0x637f  (19 bytes)
DATA_caracteres_636C:
	defb 007h,0e6h,0bah,05ah,046h,0bdh	; 636c
	defb 007h,065h,067h,0d1h,0a9h,069h	; 6372
	defb 007h,068h,066h,0f0h,06dh,066h	; 6378
	defb 000h	; 637e

; ----------------------------------------------------------------------
; DATOS copias_637F: 4 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:57B5 (17 bytes)
;   0x637f..0x6390  (17 bytes)
DATA_copias_637F:
	defb 097h,0b3h,039h,008h	; 637f
	defb 09fh,0bbh,039h,008h	; 6383
	defb 0a7h,0c3h,039h,008h	; 6387
	defb 0afh,0cbh,039h,004h	; 638b
	defb 000h	; 638f

; ----------------------------------------------------------------------
; DATOS copias_6390: 2 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:57EE (9 bytes)
;   0x6390..0x6399  (9 bytes)
DATA_copias_6390:
	defb 068h,064h,009h,004h	; 6390
	defb 064h,064h,039h,004h	; 6394
	defb 000h	; 6398

; ----------------------------------------------------------------------
; DATOS dibujos_6399: los dibujos de unos caracteres desde el 0x25, en rle
;   (0x5C46), que pide la ficha 0x6000; lo leen p00:59ED (458 bytes)
;   0x6399..0x6563  (458 bytes)
DATA_dibujos_6399:
	defb 003h,000h,081h,07ch,006h,000h,09dh,024h,018h,018h,024h,000h,000h,010h,038h,038h	; 6399  ...|...$..$...88
	defb 010h,010h,000h,010h,000h,044h,0eeh,0eeh,044h,044h,000h,044h,000h,03ch,046h,006h	; 63a9  .....D..DD.D.<F.
	defb 00ch,018h,000h,018h,006h,000h,002h,030h,005h,000h,086h,030h,010h,020h,000h,000h	; 63b9  .......0...0. ..
	defb 0ffh,004h,0c0h,084h,0ffh,000h,000h,0ffh,004h,080h,084h,0ffh,000h,000h,0ffh,004h	; 63c9  ................
	defb 0c0h,084h,0ffh,000h,000h,0ffh,004h,0e0h,084h,0ffh,000h,000h,0ffh,004h,0f0h,084h	; 63d9  ................
	defb 0ffh,000h,000h,0ffh,004h,0f8h,084h,0ffh,000h,000h,0ffh,004h,0fch,084h,0ffh,000h	; 63e9  ................
	defb 000h,0ffh,004h,0feh,083h,0ffh,000h,000h,006h,0ffh,002h,000h,081h,0ffh,004h,000h	; 63f9  ................
	defb 083h,0ffh,000h,000h,006h,001h,002h,000h,006h,080h,002h,000h,081h,0ffh,004h,080h	; 6409  ................
	defb 084h,0ffh,000h,000h,0ffh,004h,0c0h,084h,0ffh,000h,000h,0ffh,004h,0e0h,084h,0ffh	; 6419  ................
	defb 000h,000h,0ffh,004h,0f0h,084h,0ffh,000h,000h,0ffh,004h,0f8h,084h,0ffh,000h,000h	; 6429  ................
	defb 0ffh,004h,0fch,084h,0ffh,000h,000h,0ffh,004h,0feh,083h,0ffh,000h,000h,006h,0ffh	; 6439  ................
	defb 004h,000h,002h,0ffh,003h,000h,008h,018h,003h,000h,002h,01fh,006h,018h,002h,01fh	; 6449  ................
	defb 004h,000h,085h,074h,03ah,01fh,03ah,074h,004h,000h,083h,02ch,0f3h,02ch,004h,000h	; 6459  ...t:.:t...,.,..
	defb 085h,074h,03ah,01fh,03ah,074h,004h,000h,083h,02ch,0f3h,02ch,006h,000h,002h,0f8h	; 6469  .t:.:t...,.,....
	defb 006h,018h,002h,0f8h,023h,000h,08eh,024h,000h,099h,03ch,03ch,099h,000h,024h,000h	; 6479  ....#..$..<<..$.
	defb 000h,02eh,09fh,03fh,04eh,004h,000h,084h,005h,01ah,03fh,00fh,004h,000h,084h,0a0h	; 6489  ...?N.....?.....
	defb 058h,0fch,0f0h,004h,000h,083h,0bch,0bfh,0bch,003h,000h,09eh,038h,044h,0a2h,082h	; 6499  X...........8D..
	defb 082h,044h,038h,000h,000h,00fh,03fh,06fh,030h,00fh,000h,000h,045h,0deh,0c5h,0d8h	; 64a9  .D8...?o0...E...
	defb 045h,0deh,045h,000h,000h,00fh,03fh,00fh,030h,00fh,003h,000h,085h,0f0h,0fch,0f0h	; 64b9  E.E...?.0.......
	defb 00ch,0f0h,003h,000h,086h,03ch,066h,05bh,05ah,066h,03ch,004h,000h,083h,0feh,056h	; 64c9  .....<f[Zf<....V
	defb 056h,003h,000h,088h,0bdh,07eh,07eh,07dh,038h,007h,076h,000h,003h,077h,0a4h,000h	; 64d9  V....~~}8.v..w..
	defb 0ffh,024h,0dbh,001h,003h,040h,0dch,08dh,020h,00ch,05fh,000h,000h,038h,07ch,0fah	; 64e9  .$...@.. ._..8|.
	defb 0f6h,0f7h,04fh,05fh,0deh,0ech,0e3h,0f7h,068h,00fh,0e7h,007h,0f2h,0fch,07eh,07dh	; 64f9  ..O_....h.....~}
	defb 073h,02eh,0dch,004h,000h,098h,007h,00fh,009h,00eh,030h,056h,02eh,00ch,053h,085h	; 6509  s.........0V..S.
	defb 0d2h,0e0h,03bh,07bh,060h,0ebh,083h,0aeh,08ch,0f8h,070h,0b0h,0b0h,0e0h,005h,000h	; 6519  ...{`.....p.....
	defb 09eh,00fh,01fh,02dh,058h,016h,056h,018h,000h,080h,0e0h,070h,018h,0bch,0bch,006h	; 6529  ...-X.V....p....
	defb 04fh,02fh,026h,013h,008h,006h,001h,000h,05ah,05ah,006h,0ach,0fah,004h,050h,00ah	; 6539  O/&.....ZZ....P.
	defb 000h,097h,003h,006h,00ch,018h,037h,06ch,09eh,001h,002h,03fh,060h,061h,01eh,061h	; 6549  ......7l...?`a.a
	defb 01eh,000h,01ch,080h,0c0h,0c0h,040h,080h,000h,000h	; 6559  ......@...

; ----------------------------------------------------------------------
; DATOS colores_6563: los colores de unos caracteres desde el 0x25, en rle
;   (0x5C46), que pide la ficha 0x6000; lo leen p00:59ED (171 bytes)
;   0x6563..0x660e  (171 bytes)
DATA_colores_6563:
	defb 042h,0f0h,004h,050h,004h,0f0h,004h,050h,004h,0f0h,004h,050h,004h,0f0h,004h,050h	; 6563  B..P...P...P...P
	defb 004h,0f0h,004h,050h,004h,0f0h,004h,050h,004h,0f0h,004h,050h,004h,0f0h,004h,050h	; 6573  ...P...P...P...P
	defb 01ch,0f0h,004h,080h,004h,0f0h,004h,080h,004h,0f0h,004h,080h,004h,0f0h,004h,080h	; 6583  ................
	defb 004h,0f0h,004h,080h,004h,0f0h,004h,080h,004h,0f0h,004h,080h,004h,0f0h,004h,080h	; 6593  ................
	defb 002h,0f0h,020h,080h,004h,090h,004h,080h,003h,090h,081h,09fh,004h,080h,004h,0f0h	; 65a3  .. .............
	defb 004h,0e0h,003h,0f0h,081h,0fah,004h,0e0h,030h,080h,012h,0a0h,082h,070h,050h,006h	; 65b3  ........0....pP.
	defb 040h,082h,070h,050h,006h,040h,082h,070h,050h,004h,040h,008h,0f0h,010h,090h,020h	; 65c3  @.pP.@.pP.@....
	defb 0a0h,002h,0f0h,004h,0e0h,082h,0f0h,0e0h,005h,060h,083h,080h,0b8h,080h,014h,090h	; 65d3  .........`......
	defb 003h,080h,081h,060h,005h,080h,003h,060h,005h,090h,002h,080h,002h,090h,00dh,080h	; 65e3  ...`...`........
	defb 002h,060h,008h,080h,002h,0f0h,003h,0b0h,004h,0a0h,081h,0f0h,006h,0b0h,008h,0a0h	; 65f3  .`..............
	defb 003h,0b0h,01bh,0a0h,004h,090h,003h,0a0h,003h,090h,000h	; 6603  ...........

; ----------------------------------------------------------------------
; DATOS dibujos_660E: los dibujos de unos caracteres desde el 0xBA, en rle
;   (0x5C46), que pide la ficha 0x6012; lo leen p00:59ED (34 bytes)
;   0x660e..0x6630  (34 bytes)
DATA_dibujos_660E:
	defb 0a0h,00fh,033h,05ch,067h,0dfh,0bfh,0afh,0afh,0f0h,0f8h,0feh,0edh,0f6h,0fah,0fah	; 660e  ..3\g...........
	defb 0fah,0afh,0b7h,05fh,0e3h,09ch,06fh,033h,00fh,0f8h,0f0h,0e0h,0f1h,066h,09eh,0dch	; 661e  ..._..o3.....f..
	defb 0e8h,000h	; 662e

; ----------------------------------------------------------------------
; DATOS colores_6630: los colores de unos caracteres desde el 0xBA, en rle
;   (0x5C46), que pide la ficha 0x6012; lo leen p00:59ED (15 bytes)
;   0x6630..0x663f  (15 bytes)
DATA_colores_6630:
	defb 00bh,090h,005h,098h,004h,090h,004h,060h,003h,098h,081h,080h,004h,060h,000h	; 6630  .......`.....`.

; ----------------------------------------------------------------------
; DATOS dibujos_663F: los dibujos de unos caracteres desde el 0x9A, en rle
;   (0x5C46), que pide la ficha 0x6018; lo leen p00:59ED (18 bytes)
;   0x663f..0x6651  (18 bytes)
DATA_dibujos_663F:
	defb 090h,030h,030h,03fh,030h,030h,030h,03fh,030h,00ch,00ch,0fch,00ch,00ch,00ch,0fch	; 663f  .00?000?0.......
	defb 00ch,000h	; 664f

; ----------------------------------------------------------------------
; DATOS dibujos_6651: los dibujos de unos caracteres desde el 0xB6, en rle
;   (0x5C46), que pide la ficha 0x6024; lo leen p00:59ED (23 bytes)
;   0x6651..0x6668  (23 bytes)
DATA_dibujos_6651:
	defb 088h,039h,066h,0d6h,021h,0d2h,004h,01ah,0a0h,008h,000h,088h,0c9h,022h,0adh,012h	; 6651  .9f.!........"..
	defb 044h,001h,008h,052h,008h,000h,000h	; 6661

; ----------------------------------------------------------------------
; DATOS dibujos_6668: los dibujos de unos caracteres desde el 0xF0, en rle
;   (0x5C46), que pide la ficha 0x602A; lo leen p00:57AE, p00:59ED (5 bytes)
;   0x6668..0x666d  (5 bytes)
DATA_dibujos_6668:
	defb 004h,0fbh,004h,0bfh,000h	; 6668

; ----------------------------------------------------------------------
; DATOS colores_666D: los colores de unos caracteres desde el 0xF0, en rle
;   (0x5C46), que pide la ficha 0x602A; lo leen p00:57AE, p00:59ED (10 bytes)
;   0x666d..0x6677  (10 bytes)
DATA_colores_666D:
	defb 088h,075h,050h,050h,040h,075h,050h,050h,040h,000h	; 666d  .uPP@uPP@.

; ----------------------------------------------------------------------
; DATOS dibujos_6677: los dibujos de unos caracteres desde el 0xF0, en rle
;   (0x5C46), que pide la ficha 0x6062; lo leen p00:5A02 (9 bytes)
;   0x6677..0x6680  (9 bytes)
DATA_dibujos_6677:
	defb 003h,0fbh,081h,000h,003h,0bfh,081h,000h,000h	; 6677  .........

; ----------------------------------------------------------------------
; DATOS colores_6680: los colores de unos caracteres desde el 0xF0, en rle
;   (0x5C46), que pide la ficha 0x6062; lo leen p00:5A02 (9 bytes)
;   0x6680..0x6689  (9 bytes)
DATA_colores_6680:
	defb 081h,0f0h,003h,0e0h,081h,0f0h,003h,0e0h,000h	; 6680  .........

; ----------------------------------------------------------------------
; DATOS dibujos_6689: los dibujos de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6069; lo leen p00:5A30 (31 bytes)
;   0x6689..0x66a8  (31 bytes)
DATA_dibujos_6689:
	defb 088h,007h,016h,003h,000h,01fh,000h,008h,017h,003h,0f8h,085h,000h,0f8h,000h,0f0h	; 6689  ................
	defb 0f8h,003h,017h,085h,015h,007h,005h,015h,011h,006h,0f8h,082h,078h,0f8h,000h	; 6699  ............x..

; ----------------------------------------------------------------------
; DATOS dibujos_66A8: los dibujos de unos caracteres desde el 0xA2, en rle
;   (0x5C46), que pide la ficha 0x606F; lo leen p00:5A30 (158 bytes)
;   0x66a8..0x6746  (158 bytes)
DATA_dibujos_66A8:
	defb 082h,00fh,003h,004h,07fh,002h,03fh,084h,08fh,086h,082h,0d1h,003h,0dbh,0ach,0ebh	; 66a8  ......?.........
	defb 001h,000h,003h,003h,001h,001h,000h,001h,0fch,0fch,0f8h,0f8h,0f0h,0f0h,0e0h,0e0h	; 66b8  ................
	defb 03fh,01fh,01fh,00fh,00eh,00ch,008h,010h,0edh,0d5h,0b9h,07dh,0fch,07eh,03dh,00bh	; 66c8  ?..........}.~=.
	defb 003h,0fdh,0fch,0fbh,07ah,006h,004h,001h,080h,040h,080h,004h,000h,0c4h,0c0h,021h	; 66d8  ....z....@.....!
	defb 04dh,08eh,007h,003h,021h,070h,0f8h,0c3h,0edh,0f5h,0fah,0fch,0f8h,0f0h,000h,00dh	; 66e8  M...!p..........
	defb 0beh,07fh,0ffh,0feh,0f0h,0c0h,000h,0e0h,0f8h,07ch,030h,00eh,03ch,038h,060h,0fch	; 66f8  .........|0.<8`.
	defb 0fch,0feh,01eh,03ch,008h,030h,07eh,07fh,03eh,018h,0ech,059h,033h,064h,007h,000h	; 6708  ...<.0~.>..Y3d..
	defb 000h,03fh,007h,001h,00fh,0ffh,0ffh,001h,003h,004h,080h,0c0h,0e0h,0f0h,0f8h,000h	; 6718  .?..............
	defb 000h,007h,003h,07fh,002h,03fh,002h,000h,08eh,080h,0c1h,0c3h,0dbh,0dbh,0ebh,000h	; 6728  .....?..........
	defb 000h,0f0h,003h,001h,001h,000h,001h,004h,000h,002h,0f0h,002h,0e0h,000h	; 6738  ..............

; ----------------------------------------------------------------------
; DATOS dibujos_6746: los dibujos de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6076; lo leen p00:5A37 (31 bytes)
;   0x6746..0x6765  (31 bytes)
DATA_dibujos_6746:
	defb 088h,007h,016h,003h,000h,01fh,000h,008h,017h,003h,0f8h,085h,000h,0f8h,000h,0f0h	; 6746  ................
	defb 0f8h,003h,017h,085h,015h,007h,005h,015h,011h,006h,0f8h,082h,078h,0f8h,000h	; 6756  ............x..

; ----------------------------------------------------------------------
; DATOS dibujos_6765: los dibujos de unos caracteres desde el 0xA2, en rle
;   (0x5C46), que pide la ficha 0x607C; lo leen p00:57AE, p00:5A37 (163 bytes)
;   0x6765..0x6808  (163 bytes)
DATA_dibujos_6765:
	defb 0ffh,0c8h,0d0h,081h,079h,08eh,0f3h,07dh,03eh,0dch,0b8h,0e1h,006h,06fh,00bh,02dh	; 6765  ....y..}>....o.-
	defb 098h,026h,02dh,08bh,0c0h,067h,0ach,0cbh,024h,023h,0e4h,08bh,027h,01ch,0c0h,098h	; 6775  .&-..g..$#..'...
	defb 064h,00fh,061h,09ch,066h,07ah,01eh,0c2h,0b4h,003h,09ch,0b3h,06eh,05ch,0b1h,0a1h	; 6785  d.a.fz......n\..
	defb 045h,000h,098h,076h,0eeh,0deh,0bdh,0b8h,065h,0deh,0bah,046h,031h,0cch,0f6h,03ah	; 6795  E..v....e..F1..:
	defb 08dh,060h,0e7h,0c0h,031h,04dh,076h,07ah,03ah,055h,016h,0d6h,04bh,0abh,024h,041h	; 67a5  .`..1Mvz:U..K.$A
	defb 01ch,049h,08ah,09ch,05bh,01bh,09dh,04dh,04dh,0a5h,08ah,02dh,06bh,046h,024h,002h	; 67b5  .I..[..MM..-kF$.
	defb 060h,00ch,002h,032h,059h,06dh,074h,035h,014h,06ch,0dbh,0b4h,077h,063h,0c3h,019h	; 67c5  `..2Ymt5.l..wc..
	defb 064h,00ah,099h,0c1h,063h,0a2h,0d7h,0d0h,071h,0a2h,0adh,06bh,05bh,0d7h,016h,014h	; 67d5  d...c...q..k[...
	defb 081h,0c8h,003h,000h,095h,078h,08eh,0f3h,07dh,03eh,000h,000h,001h,006h,06fh,00bh	; 67e5  .....x..}>....o.
	defb 02dh,098h,000h,000h,080h,0c0h,067h,0ach,0cbh,024h,003h,000h,085h,027h,01ch,0c0h	; 67f5  -.....g..$...'..
	defb 098h,064h,000h	; 6805

; ----------------------------------------------------------------------
; DATOS dibujos_6808: los dibujos de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x60B1; lo leen p00:5A4C, p00:5A76 (33 bytes)
;   0x6808..0x6829  (33 bytes)
DATA_dibujos_6808:
	defb 08fh,03fh,07fh,05fh,07fh,05fh,062h,03fh,000h,0feh,001h,0ffh,0ffh,0fdh,073h,0feh	; 6808  .?._._b?......s.
	defb 003h,000h,085h,040h,07fh,05fh,062h,03fh,004h,000h,085h,0ffh,0fdh,073h,0feh,000h	; 6818  ...@._b?.....s..
	defb 000h	; 6828

; ----------------------------------------------------------------------
; DATOS dibujos_6829: los dibujos de unos caracteres desde el 0x99, en rle
;   (0x5C46), que pide la ficha 0x6095; lo leen p00:5A4C (10 bytes)
;   0x6829..0x6833  (10 bytes)
DATA_dibujos_6829:
	defb 088h,066h,0dbh,066h,018h,024h,018h,024h,018h,000h	; 6829  .f.f.$.$..

; ----------------------------------------------------------------------
; DATOS dibujos_6833: los dibujos de unos caracteres desde el 0xB4, en rle
;   (0x5C46), que pide la ficha 0x609B; lo leen p00:5A4C (9 bytes)
;   0x6833..0x683c  (9 bytes)
DATA_dibujos_6833:
	defb 007h,0f7h,004h,008h,004h,0f7h,081h,008h,000h	; 6833  .........

; ----------------------------------------------------------------------
; DATOS dibujos_683C: los dibujos de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x6089; lo leen p00:5A4C (47 bytes)
;   0x683c..0x686b  (47 bytes)
DATA_dibujos_683C:
	defb 002h,000h,0a9h,040h,0feh,002h,004h,048h,03fh,03eh,03eh,030h,030h,03eh,036h,037h	; 683c  ...@...H?>>00>67
	defb 027h,023h,022h,002h,0feh,0fch,072h,0feh,000h,000h,080h,080h,040h,0a0h,090h,089h	; 684c  '#"...r.....@...
	defb 0feh,03eh,03eh,006h,006h,03eh,036h,0f6h,072h,022h,0a2h,0a0h,005h,080h,000h	; 685c  .>>..>6.r".....

; ----------------------------------------------------------------------
; DATOS dibujos_686B: los dibujos de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x608F; lo leen p00:5A4C (55 bytes)
;   0x686b..0x68a2  (55 bytes)
DATA_dibujos_686B:
	defb 003h,000h,002h,0edh,08dh,000h,0deh,0deh,01eh,0dah,0dah,01eh,0deh,0deh,0edh,0edh	; 686b  ................
	defb 000h,048h,004h,0ffh,086h,0fdh,0dah,000h,040h,0e0h,0ech,003h,0eeh,08ch,0deh,0dah	; 687b  .H......@.......
	defb 0fah,0fah,0d9h,0d2h,0d5h,0abh,000h,0ech,0f6h,0f6h,003h,0ffh,002h,055h,003h,0fch	; 688b  .............U..
	defb 085h,0f8h,0f0h,0c0h,007h,000h,000h	; 689b

; ----------------------------------------------------------------------
; DATOS dibujos_68A2: los dibujos de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x60B7; lo leen p00:5A76 (31 bytes)
;   0x68a2..0x68c1  (31 bytes)
DATA_dibujos_68A2:
	defb 087h,007h,016h,003h,000h,01fh,000h,00fh,004h,017h,085h,015h,007h,005h,015h,011h	; 68a2  ................
	defb 008h,000h,003h,0f8h,084h,000h,0fbh,000h,0f0h,007h,0f8h,082h,078h,0f8h,000h	; 68b2  ............x..

; ----------------------------------------------------------------------
; DATOS dibujos_68C1: los dibujos de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x60BD; lo leen p00:5A76 (26 bytes)
;   0x68c1..0x68db  (26 bytes)
DATA_dibujos_68C1:
	defb 098h,0feh,001h,0dfh,0bfh,0adh,003h,00eh,000h,0fch,0feh,0e6h,0f8h,0f8h,040h,0e0h	; 68c1  ..............@.
	defb 000h,00fh,00fh,003h,007h,001h,002h,007h,000h,000h	; 68d1  ..........

; ----------------------------------------------------------------------
; DATOS dibujos_68DB: los dibujos de unos caracteres desde el 0xA9, en rle
;   (0x5C46), que pide la ficha 0x60C3; lo leen p00:5A76 (26 bytes)
;   0x68db..0x68f5  (26 bytes)
DATA_dibujos_68DB:
	defb 098h,002h,007h,005h,007h,002h,007h,005h,007h,002h,007h,005h,007h,002h,007h,005h	; 68db  ................
	defb 007h,0fch,0f8h,0fah,0f8h,0fdh,073h,0feh,000h,000h	; 68eb  ......s...

; ----------------------------------------------------------------------
; DATOS dibujos_68F5: los dibujos de unos caracteres desde el 0xF1, en rle
;   (0x5C46), que pide la ficha 0x60A1; lo leen p00:5A4C, p00:5A68 (50 bytes)
;   0x68f5..0x6927  (50 bytes)
DATA_dibujos_68F5:
	defb 0b0h,03fh,07fh,07eh,07ch,078h,003h,006h,00fh,01fh,03fh,07dh,0c0h,03fh,01dh,0e0h	; 68f5  .?.~|x....?}.?..
	defb 07ah,0beh,0bah,0eeh,07ah,06ch,07ch,0d4h,0fch,063h,047h,002h,001h,001h,042h,0e0h	; 6905  z...zl|..cG...B.
	defb 0ffh,063h,047h,001h,01ch,03fh,077h,0ddh,0ffh,01fh,03fh,07dh,09fh,03fh,07dh,0e0h	; 6915  .cG..?w...?}.?}.
	defb 07ah,000h	; 6925

; ----------------------------------------------------------------------
; DATOS dibujos_6927: los dibujos de unos caracteres desde el 0xF1, en rle
;   (0x5C46), que pide la ficha 0x60C9; lo leen p00:5A53, p00:5A76 (50 bytes)
;   0x6927..0x6959  (50 bytes)
DATA_dibujos_6927:
	defb 092h,060h,0f3h,063h,060h,0f3h,063h,060h,000h,065h,06fh,06fh,006h,061h,06dh,06dh	; 6927  .`.c`.c`.eoo.amm
	defb 061h,06dh,06dh,003h,06ch,092h,068h,062h,06dh,0fch,01eh,0e6h,07ah,0e6h,014h,0eah	; 6937  amm.l.hbm...z...
	defb 01ah,0ech,0f6h,0f6h,06eh,09ch,0fch,0feh,003h,06ah,081h,094h,003h,0bch,082h,07eh	; 6947  ....n....j.....~
	defb 0e6h,000h	; 6957

; ----------------------------------------------------------------------
; DATOS colores_6959: los colores de unos caracteres desde el 0x9A, en rle
;   (0x5C46), que pide la ficha 0x6018; lo leen p00:59ED (18 bytes)
;   0x6959..0x696b  (18 bytes)
DATA_colores_6959:
	defb 002h,0e0h,081h,0f0h,003h,0e0h,081h,0f0h,003h,0e0h,081h,0f0h,003h,0e0h,082h,0f0h	; 6959  ................
	defb 0e0h,000h	; 6969

; ----------------------------------------------------------------------
; DATOS colores_696B: los colores de unos caracteres desde el 0xB6, en rle
;   (0x5C46), que pide la ficha 0x6024; lo leen p00:59ED (15 bytes)
;   0x696b..0x697a  (15 bytes)
DATA_colores_696B:
	defb 084h,0f0h,0f7h,074h,074h,00ch,054h,084h,0a0h,0a9h,096h,096h,00ch,086h,000h	; 696b  ...tt.T........

; ----------------------------------------------------------------------
; DATOS colores_697A: los colores de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6069; lo leen p00:5A30 (3 bytes)
;   0x697a..0x697d  (3 bytes)
DATA_colores_697A:
	defb 020h,080h,000h	; 697a

; ----------------------------------------------------------------------
; DATOS colores_697D: los colores de unos caracteres desde el 0xA2, en rle
;   (0x5C46), que pide la ficha 0x606F; lo leen p00:5A30 (41 bytes)
;   0x697d..0x69a6  (41 bytes)
DATA_colores_697D:
	defb 002h,086h,00eh,060h,008h,086h,008h,080h,010h,060h,081h,086h,004h,060h,004h,080h	; 697d  ...`.....`...`..
	defb 006h,060h,081h,080h,01ch,060h,003h,080h,011h,060h,003h,080h,002h,086h,006h,060h	; 698d  .`...`...`.....`
	defb 005h,080h,013h,060h,005h,086h,008h,080h,000h	; 699d  ...`.....

; ----------------------------------------------------------------------
; DATOS colores_69A6: los colores de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6076; lo leen p00:5A37 (3 bytes)
;   0x69a6..0x69a9  (3 bytes)
DATA_colores_69A6:
	defb 020h,040h,000h	; 69a6

; ----------------------------------------------------------------------
; DATOS colores_69A9: los colores de unos caracteres desde el 0xA2, en rle
;   (0x5C46), que pide la ficha 0x607C; lo leen p00:57AE, p00:5A37 (5 bytes)
;   0x69a9..0x69ae  (5 bytes)
DATA_colores_69A9:
	defb 07fh,0c0h,021h,0c0h,000h	; 69a9

; ----------------------------------------------------------------------
; DATOS colores_69AE: los colores de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x60B1; lo leen p00:5A4C, p00:5A76 (10 bytes)
;   0x69ae..0x69b8  (10 bytes)
DATA_colores_69AE:
	defb 081h,050h,007h,040h,082h,050h,054h,016h,040h,000h	; 69ae  .P.@.PT.@.

; ----------------------------------------------------------------------
; DATOS colores_69B8: los colores de unos caracteres desde el 0x99, en rle
;   (0x5C46), que pide la ficha 0x6095; lo leen p00:5A4C (9 bytes)
;   0x69b8..0x69c1  (9 bytes)
DATA_colores_69B8:
	defb 002h,0f0h,081h,0f4h,004h,0a4h,081h,0a0h,000h	; 69b8  .........

; ----------------------------------------------------------------------
; DATOS colores_69C1: los colores de unos caracteres desde el 0xB4, en rle
;   (0x5C46), que pide la ficha 0x609B; lo leen p00:5A4C (9 bytes)
;   0x69c1..0x69ca  (9 bytes)
DATA_colores_69C1:
	defb 007h,043h,004h,030h,004h,043h,081h,030h,000h	; 69c1  .C.0.C.0.

; ----------------------------------------------------------------------
; DATOS colores_69CA: los colores de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x6089; lo leen p00:5A4C (35 bytes)
;   0x69ca..0x69ed  (35 bytes)
DATA_colores_69CA:
	defb 004h,040h,003h,0f4h,082h,0a0h,0a5h,006h,0a4h,084h,0a0h,0a5h,0a4h,0a4h,005h,040h	; 69ca  .@.............@
	defb 003h,0f0h,004h,0f4h,082h,0a0h,0a5h,006h,0a4h,084h,0a0h,0a5h,0a4h,0a4h,004h,0f4h	; 69da  ................
	defb 081h,0f0h,000h	; 69ea

; ----------------------------------------------------------------------
; DATOS colores_69ED: los colores de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x608F; lo leen p00:5A4C (26 bytes)
;   0x69ed..0x6a07  (26 bytes)
DATA_colores_69ED:
	defb 003h,080h,08ch,090h,080h,080h,090h,080h,060h,090h,080h,060h,090h,080h,090h,01eh	; 69ed  ........`..`....
	defb 060h,083h,096h,086h,086h,006h,060h,002h,040h,000h	; 69fd  `.....`.@.

; ----------------------------------------------------------------------
; DATOS colores_6A07: los colores de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x60B7; lo leen p00:5A76 (3 bytes)
;   0x6a07..0x6a0a  (3 bytes)
DATA_colores_6A07:
	defb 028h,040h,000h	; 6a07

; ----------------------------------------------------------------------
; DATOS colores_6A0A: los colores de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x60BD; lo leen p00:5A76 (14 bytes)
;   0x6a0a..0x6a18  (14 bytes)
DATA_colores_6A0A:
	defb 082h,050h,054h,006h,040h,081h,050h,007h,040h,081h,050h,007h,040h,000h	; 6a0a  .PT.@.P.@.P.@.

; ----------------------------------------------------------------------
; DATOS colores_6A18: los colores de unos caracteres desde el 0xA9, en rle
;   (0x5C46), que pide la ficha 0x60C3; lo leen p00:5A76 (20 bytes)
;   0x6a18..0x6a2c  (20 bytes)
DATA_colores_6A18:
	defb 003h,0f0h,081h,0e4h,003h,0f4h,085h,0e0h,0f5h,0f4h,0f4h,0e4h,003h,0f4h,082h,0e0h	; 6a18  ................
	defb 050h,007h,040h,000h	; 6a28

; ----------------------------------------------------------------------
; DATOS colores_6A2C: los colores de unos caracteres desde el 0xF1, en rle
;   (0x5C46), que pide la ficha 0x60A1; lo leen p00:5A4C, p00:5A68 (42 bytes)
;   0x6a2c..0x6a56  (42 bytes)
DATA_colores_6A2C:
	defb 081h,050h,004h,040h,08ah,0f4h,074h,070h,070h,050h,050h,075h,050h,050h,0f5h,008h	; 6a2c  .P.@..tppPPuPP..
	defb 050h,002h,040h,081h,050h,003h,040h,002h,050h,002h,040h,002h,050h,081h,070h,003h	; 6a3c  P.@.P.@.P.@.P.p.
	defb 050h,082h,040h,070h,005h,050h,082h,0f5h,050h,000h	; 6a4c  P.@p.P..P.

; ----------------------------------------------------------------------
; DATOS colores_6A56: los colores de unos caracteres desde el 0xF1, en rle
;   (0x5C46), que pide la ficha 0x60C9; lo leen p00:5A53, p00:5A76 (33 bytes)
;   0x6a56..0x6a77  (33 bytes)
DATA_colores_6A56:
	defb 003h,070h,082h,040h,070h,003h,040h,082h,070h,050h,00eh,040h,002h,070h,003h,050h	; 6a56  .p.@p.@.pP.@.p.P
	defb 003h,040h,087h,0f0h,070h,050h,040h,040h,070h,050h,005h,040h,002h,050h,002h,040h	; 6a66  .@..pP@@pP.@.P.@
	defb 000h	; 6a76

; ----------------------------------------------------------------------
; DATOS dibujos_6A77: los dibujos de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x60D0; lo leen p00:5A84 (194 bytes)
;   0x6a77..0x6b39  (194 bytes)
DATA_dibujos_6A77:
	defb 088h,007h,016h,003h,000h,01fh,000h,00fh,017h,003h,0f8h,085h,000h,0f8h,000h,0f0h	; 6a77  ................
	defb 0f8h,003h,017h,085h,015h,007h,005h,015h,011h,006h,0f8h,082h,078h,0f8h,010h,000h	; 6a87  ............x...
	defb 0b2h,040h,080h,040h,0bfh,0ffh,0bfh,0c4h,080h,064h,003h,005h,0feh,0feh,0fah,0e6h	; 6a97  .@.@.....d......
	defb 003h,0b0h,098h,061h,0bfh,0ffh,0bfh,0c5h,07fh,045h,023h,001h,003h,0feh,0fah,0e6h	; 6aa7  ...a.....E#.....
	defb 0c3h,089h,063h,001h,0feh,0feh,0fah,0e6h,0e3h,001h,0c0h,040h,0bfh,0ffh,0bfh,0c6h	; 6ab7  ..c........@....
	defb 0f8h,09ah,073h,003h,001h,0adh,0fah,0e6h,0fch,044h,0ffh,098h,0bfh,0ffh,0bfh,0cfh	; 6ac7  ..s......D......
	defb 0f8h,040h,080h,007h,0bfh,001h,0bfh,0c5h,07fh,014h,063h,0c1h,081h,001h,0fah,0e6h	; 6ad7  .@........c.....
	defb 03fh,040h,080h,0c3h,0bfh,0ffh,0c0h,0c5h,080h,054h,003h,005h,0feh,0feh,0fah,0e6h	; 6ae7  ?@.......T......
	defb 073h,006h,0fch,003h,0feh,08dh,0fah,0e6h,0fch,025h,080h,0ffh,0bfh,0ffh,0bfh,0dfh	; 6af7  s........%......
	defb 08bh,001h,003h,003h,0feh,093h,0fah,0e6h,0fch,041h,07fh,0bfh,0ffh,0bfh,0bfh,01eh	; 6b07  .........A......
	defb 0f8h,000h,000h,080h,0ffh,0ffh,0bfh,0c4h,080h,003h,000h,002h,0feh,08bh,0fah,0e6h	; 6b17  ................
	defb 003h,000h,000h,080h,0ffh,0ffh,0bfh,0c5h,07fh,003h,000h,085h,003h,0feh,0fah,0e6h	; 6b27  ................
	defb 0c3h,000h	; 6b37

; ----------------------------------------------------------------------
; DATOS colores_6B39: los colores de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x60D0; lo leen p00:5A84 (133 bytes)
;   0x6b39..0x6bbe  (133 bytes)
DATA_colores_6B39:
	defb 030h,060h,083h,0c0h,0c8h,086h,004h,060h,084h,0c6h,0c0h,0c8h,0c6h,004h,060h,084h	; 6b39  0`.....`......`.
	defb 0c6h,0c0h,0c8h,086h,005h,060h,084h,0c0h,0c8h,0c6h,0c6h,003h,060h,084h,0c6h,0c0h	; 6b49  .....`......`...
	defb 0c8h,0c6h,004h,060h,084h,0c6h,0c0h,0c8h,086h,003h,060h,084h,0c0h,0c6h,0c0h,0c8h	; 6b59  ...`......`.....
	defb 003h,0c6h,003h,060h,002h,0c0h,081h,0c6h,003h,060h,087h,0c0h,0c6h,0c0h,0c8h,086h	; 6b69  ...`.....`......
	defb 060h,0c6h,003h,060h,082h,0c0h,0c8h,003h,0c6h,08eh,060h,0c0h,0c6h,0c0h,0c8h,086h	; 6b79  `..`......`.....
	defb 060h,060h,0c6h,0c0h,0c6h,0c0h,0c8h,0c6h,004h,060h,083h,0c6h,0c0h,080h,006h,060h	; 6b89  ``.......`.....`
	defb 082h,0c0h,0c6h,004h,060h,084h,0c0h,0c6h,0c0h,0c8h,005h,060h,002h,0c0h,081h,080h	; 6b99  ....`......`....
	defb 004h,060h,002h,0c6h,007h,060h,081h,0c6h,007h,060h,081h,0c6h,00bh,060h,081h,0c6h	; 6ba9  .`...`...`...`..
	defb 003h,060h,081h,0c6h,000h	; 6bb9

; ----------------------------------------------------------------------
; DATOS dibujos_6BBE: los dibujos de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6044; lo leen p00:5A02 (31 bytes)
;   0x6bbe..0x6bdd  (31 bytes)
DATA_dibujos_6BBE:
	defb 088h,007h,016h,003h,000h,01fh,000h,00fh,017h,003h,0f8h,085h,000h,0f8h,000h,0f0h	; 6bbe  ................
	defb 0f8h,003h,017h,085h,015h,007h,005h,015h,011h,006h,0f8h,082h,078h,0f8h,000h	; 6bce  ............x..

; ----------------------------------------------------------------------
; DATOS dibujos_6BDD: los dibujos de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x604A; lo leen p00:5A02 (50 bytes)
;   0x6bdd..0x6c0f  (50 bytes)
DATA_dibujos_6BDD:
	defb 082h,000h,03fh,003h,042h,09bh,05eh,056h,050h,000h,0feh,001h,079h,005h,0e5h,085h	; 6bdd  ..?.B.^VP...y...
	defb 09dh,050h,053h,052h,052h,05eh,040h,040h,03fh,085h,0e5h,005h,0fdh,081h,09dh,081h	; 6bed  .PSRR^@@?.......
	defb 0feh,003h,000h,085h,002h,042h,05eh,056h,050h,003h,000h,085h,078h,005h,0e5h,085h	; 6bfd  .....B^VP...x...
	defb 09dh,000h	; 6c0d

; ----------------------------------------------------------------------
; DATOS dibujos_6C0F: los dibujos de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x6056; lo leen p00:5A02 (34 bytes)
;   0x6c0f..0x6c31  (34 bytes)
DATA_dibujos_6C0F:
	defb 0a0h,02fh,05fh,05ch,05fh,05dh,05fh,05ch,05fh,0fch,0feh,0aeh,0feh,02eh,0feh,0ceh	; 6c0f  ./_\_]_\_.......
	defb 0feh,05dh,05fh,05ch,05fh,040h,01fh,0ffh,000h,04eh,0feh,06eh,0feh,000h,0ffh,0ffh	; 6c1f  .]_\_@...N.n....
	defb 000h,000h	; 6c2f

; ----------------------------------------------------------------------
; DATOS colores_6C31: los colores de unos caracteres desde el 0x9C, en rle
;   (0x5C46), que pide la ficha 0x6044; lo leen p00:5A02 (3 bytes)
;   0x6c31..0x6c34  (3 bytes)
DATA_colores_6C31:
	defb 020h,0e0h,000h	; 6c31

; ----------------------------------------------------------------------
; DATOS colores_6C34: los colores de unos caracteres desde el 0xA0, en rle
;   (0x5C46), que pide la ficha 0x604A; lo leen p00:5A02 (10 bytes)
;   0x6c34..0x6c3e  (10 bytes)
DATA_colores_6C34:
	defb 082h,0e0h,050h,007h,040h,081h,050h,026h,040h,000h	; 6c34  ..P.@.P&@.

; ----------------------------------------------------------------------
; DATOS colores_6C3E: los colores de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x6056; lo leen p00:5A02 (17 bytes)
;   0x6c3e..0x6c4f  (17 bytes)
DATA_colores_6C3E:
	defb 081h,0f0h,007h,0e0h,081h,0f0h,00ch,0e0h,081h,0feh,007h,0e0h,083h,0f0h,0e0h,0e0h	; 6c3e  ................
	defb 000h	; 6c4e

; ----------------------------------------------------------------------
; DATOS dibujos_6C4F: los dibujos de unos caracteres desde el 0x7A, en rle
;   (0x5C46), que pide la ficha 0x6006; lo leen p00:59ED (140 bytes)
;   0x6c4f..0x6cdb  (140 bytes)
DATA_dibujos_6C4F:
	defb 098h,001h,007h,00fh,00ch,01bh,01fh,01fh,030h,0ffh,073h,0ffh,000h,0deh,0ffh,0ffh	; 6c4f  ........0.s.....
	defb 000h,0e0h,0b8h,0fch,00ch,0f6h,0feh,0feh,003h,003h,03bh,082h,03fh,020h,003h,03bh	; 6c5f  ............? ..
	defb 003h,0deh,082h,0ffh,000h,003h,0deh,003h,0f7h,082h,0ffh,003h,003h,0f7h,082h,03fh	; 6c6f  ...............?
	defb 020h,003h,03bh,003h,03fh,082h,0ffh,000h,003h,0deh,004h,0ffh,081h,003h,003h,0f7h	; 6c7f   ...?...........
	defb 003h,0ffh,081h,000h,003h,07fh,081h,000h,003h,0f7h,084h,07fh,000h,000h,01fh,004h	; 6c8f  ................
	defb 03fh,083h,001h,07fh,000h,005h,0ffh,083h,0f8h,0fch,01ch,005h,0ech,008h,03fh,008h	; 6c9f  ?.............?.
	defb 0ffh,008h,0ech,004h,03fh,084h,01fh,0e0h,0ffh,07fh,005h,0ffh,083h,000h,00fh,0ffh	; 6caf  ....?...........
	defb 005h,0ech,088h,01ch,0fch,0f8h,007h,01fh,038h,060h,060h,00bh,0c0h,081h,000h,003h	; 6cbf  ........8``.....
	defb 003h,081h,000h,003h,003h,081h,001h,016h,003h,081h,001h,000h	; 6ccf  ............

; ----------------------------------------------------------------------
; DATOS colores_6CDB: los colores de unos caracteres desde el 0x7A, en rle
;   (0x5C46), que pide la ficha 0x6006; lo leen p00:59ED (133 bytes)
;   0x6cdb..0x6d60  (133 bytes)
DATA_colores_6CDB:
	defb 002h,080h,081h,090h,003h,080h,002h,090h,092h,088h,080h,090h,090h,080h,060h,090h	; 6cdb  ..............`.
	defb 090h,080h,080h,090h,080h,080h,060h,090h,090h,080h,080h,003h,090h,002h,080h,09ah	; 6ceb  ......`.........
	defb 090h,060h,060h,096h,090h,090h,060h,060h,096h,060h,060h,096h,090h,090h,060h,060h	; 6cfb  .``...``.``...``
	defb 096h,090h,090h,080h,080h,090h,090h,080h,090h,090h,003h,060h,083h,096h,090h,060h	; 6d0b  ...........`...`
	defb 003h,090h,002h,060h,084h,096h,090h,060h,090h,003h,0b0h,081h,090h,003h,0b0h,082h	; 6d1b  ...`...`........
	defb 090h,054h,00fh,075h,002h,074h,023h,075h,002h,050h,081h,054h,006h,070h,007h,075h	; 6d2b  .T.u.t#u.P.T.p.u
	defb 003h,074h,090h,070h,050h,050h,040h,070h,050h,050h,040h,070h,050h,050h,040h,070h	; 6d3b  .t.pPP@pPP@pPP@p
	defb 050h,050h,040h,003h,0b0h,081h,090h,003h,0b0h,084h,090h,050h,050h,040h,012h,050h	; 6d4b  PP@........PP@.P
	defb 083h,040h,050h,050h,000h	; 6d5b

; ----------------------------------------------------------------------
; DATOS dibujos_6D60: los dibujos de unos caracteres desde el 0xC2, en rle
;   (0x5C46), que pide la ficha 0x600C; lo leen p00:59ED (112 bytes)
;   0x6d60..0x6dd0  (112 bytes)
DATA_dibujos_6D60:
	defb 099h,01fh,07fh,0ffh,077h,020h,0feh,068h,03fh,0f8h,0feh,0ech,0fbh,0f5h,0c1h,002h	; 6d60  ....w .h?.......
	defb 0fch,000h,06fh,0ffh,00dh,0c6h,0c0h,000h,000h,0ffh,003h,099h,081h,081h,003h,099h	; 6d70  ..o.............
	defb 018h,03ch,090h,003h,00eh,01fh,010h,016h,03fh,03fh,030h,0f0h,0d8h,0fch,00eh,0d6h	; 6d80  .<......??0.....
	defb 0feh,0fch,003h,003h,036h,082h,03fh,020h,003h,036h,002h,0dbh,088h,0d8h,0fch,003h	; 6d90  ....6.? .6......
	defb 0dbh,0dbh,0d8h,03fh,020h,003h,036h,003h,03fh,08fh,0fch,003h,0dbh,0dbh,0d8h,0fch	; 6da0  ...? .6.?.......
	defb 000h,0ffh,0fch,0b4h,0b4h,0fch,0fch,0b4h,0b4h,019h,0fch,08bh,0f8h,0a8h,0a8h,0f8h	; 6db0  ................
	defb 0f8h,0a8h,0a8h,0f8h,006h,01fh,007h,012h,0fbh,002h,007h,081h,01eh,018h,0f0h,000h	; 6dc0  ................

; ----------------------------------------------------------------------
; DATOS colores_6DD0: los colores de unos caracteres desde el 0xC2, en rle
;   (0x5C46), que pide la ficha 0x600C; lo leen p00:59ED (114 bytes)
;   0x6dd0..0x6e42  (114 bytes)
DATA_colores_6DD0:
	defb 002h,0f0h,003h,0feh,003h,0e0h,002h,0f0h,081h,0feh,006h,0e0h,085h,0b9h,099h,098h	; 6dd0  ................
	defb 080h,086h,003h,060h,084h,080h,090h,090h,096h,003h,090h,002h,060h,082h,090h,080h	; 6de0  ...`........`...
	defb 013h,090h,003h,080h,08dh,090h,080h,080h,060h,090h,090h,080h,080h,090h,080h,080h	; 6df0  ........`.......
	defb 060h,096h,003h,080h,003h,090h,002h,080h,085h,090h,080h,060h,096h,096h,003h,060h	; 6e00  `..........`...`
	defb 08ah,096h,090h,090h,080h,080h,090h,090h,060h,090h,096h,003h,060h,004h,096h,008h	; 6e10  ........`...`...
	defb 090h,002h,040h,082h,050h,040h,010h,050h,084h,040h,050h,040h,040h,008h,090h,002h	; 6e20  ..@.P@.P.@P@@...
	defb 075h,014h,074h,002h,075h,002h,040h,082h,050h,040h,010h,050h,084h,040h,050h,040h	; 6e30  u.t.u.@.P@.P.@P@
	defb 040h,000h	; 6e40

; ----------------------------------------------------------------------
; DATOS tabla_dibujos_de_cosas: 38 punteros a los dibujos de las cosas 7-0x2C,
;   en rle a los tres tercios (0x5BFC); p00:58E4 descarta las de fuera; lo
;   leen p00:58F3 (76 bytes)
;   0x6e42..0x6e8e  (76 bytes)
DATA_tabla_dibujos_de_cosas:
	defb 0dah,06eh	; 6e42
	defb 0fch,06eh	; 6e44
	defb 01eh,06fh	; 6e46
	defb 033h,06fh	; 6e48
	defb 055h,06fh	; 6e4a
	defb 071h,06fh	; 6e4c
	defb 091h,06fh	; 6e4e
	defb 0b1h,06fh	; 6e50
	defb 0d3h,06fh	; 6e52
	defb 0f5h,06fh	; 6e54
	defb 00dh,070h	; 6e56
	defb 02fh,070h	; 6e58
	defb 051h,070h	; 6e5a
	defb 073h,070h	; 6e5c
	defb 094h,070h	; 6e5e
	defb 0aah,070h	; 6e60
	defb 0c9h,070h	; 6e62
	defb 0ebh,070h	; 6e64
	defb 00ah,071h	; 6e66
	defb 02bh,071h	; 6e68
	defb 047h,071h	; 6e6a
	defb 067h,071h	; 6e6c
	defb 085h,071h	; 6e6e
	defb 0a7h,071h	; 6e70
	defb 0c9h,071h	; 6e72
	defb 0ebh,071h	; 6e74
	defb 00dh,072h	; 6e76
	defb 02ch,072h	; 6e78
	defb 04eh,072h	; 6e7a
	defb 06ch,072h	; 6e7c
	defb 08bh,072h	; 6e7e
	defb 0a8h,072h	; 6e80
	defb 0c5h,072h	; 6e82
	defb 0e2h,072h	; 6e84
	defb 002h,073h	; 6e86
	defb 024h,073h	; 6e88
	defb 042h,073h	; 6e8a
	defb 063h,073h	; 6e8c

; ----------------------------------------------------------------------
; DATOS tabla_colores_de_cosas: 38 punteros a los colores de las cosas 7-0x2C,
;   en rle a los tres tercios (0x5BFC); p00:58E4 descarta las de fuera; lo
;   leen p00:5901 (76 bytes)
;   0x6e8e..0x6eda  (76 bytes)
DATA_tabla_colores_de_cosas:
	defb 085h,073h	; 6e8e
	defb 0a6h,073h	; 6e90
	defb 0bch,073h	; 6e92
	defb 0c1h,073h	; 6e94
	defb 0cch,073h	; 6e96
	defb 0dbh,073h	; 6e98
	defb 0e5h,073h	; 6e9a
	defb 0f9h,073h	; 6e9c
	defb 008h,074h	; 6e9e
	defb 01ch,074h	; 6ea0
	defb 01fh,074h	; 6ea2
	defb 035h,074h	; 6ea4
	defb 046h,074h	; 6ea6
	defb 058h,074h	; 6ea8
	defb 06ch,074h	; 6eaa
	defb 071h,074h	; 6eac
	defb 08ah,074h	; 6eae
	defb 09eh,074h	; 6eb0
	defb 0a7h,074h	; 6eb2
	defb 0b8h,074h	; 6eb4
	defb 0cdh,074h	; 6eb6
	defb 0e8h,074h	; 6eb8
	defb 0f4h,074h	; 6eba
	defb 007h,075h	; 6ebc
	defb 014h,075h	; 6ebe
	defb 02bh,075h	; 6ec0
	defb 032h,075h	; 6ec2
	defb 03dh,075h	; 6ec4
	defb 042h,075h	; 6ec6
	defb 04dh,075h	; 6ec8
	defb 05eh,075h	; 6eca
	defb 066h,075h	; 6ecc
	defb 075h,075h	; 6ece
	defb 087h,075h	; 6ed0
	defb 090h,075h	; 6ed2
	defb 0aah,075h	; 6ed4
	defb 0b7h,075h	; 6ed6
	defb 0c5h,075h	; 6ed8

; ----------------------------------------------------------------------
; DATOS dibujos_cosa_07: los dibujos de la cosa 0x07, rle a los tres tercios
;   (0x5BFC); se solapan 7 bloques (0x6EDA-0x6EFC, 0x6EDA-0x6F91,
;   0x6EFC-0x6F1E, 0x6F1E-0x6F33, 0x6F33-0x6F55, 0x6F55-0x6F71); lo leen
;   p00:5722, p00:58F3 (183 bytes)
;   0x6eda..0x6f91  (183 bytes)
DATA_dibujos_cosa_07:
	defb 088h,000h,001h,0ffh,003h,007h,007h,003h,001h,003h,000h,095h,080h,0c0h,0c0h,080h	; 6eda  ................
	defb 000h,003h,01fh,030h,040h,05fh,07fh,03fh,01fh,080h,0f0h,018h,074h,074h,004h,068h	; 6eea  ...0@_.?....tt.h
	defb 0f0h,000h,093h,000h,018h,008h,00eh,00dh,01eh,01fh,01fh,000h,030h,010h,010h,090h	; 6efa  ............0...
	defb 0f0h,068h,098h,01fh,01eh,01fh,003h,00fh,08ah,00eh,00ch,0f8h,0f4h,00eh,0ffh,0f8h	; 6f0a  .h..............
	defb 007h,018h,000h,000h,088h,000h,068h,074h,030h,04ch,00ch,003h,003h,010h,000h,002h	; 6f1a  ......ht0L......
	defb 0c0h,002h,030h,084h,00ch,00eh,005h,003h,000h,0a0h,000h,040h,078h,04fh,020h,02fh	; 6f2a  ..0........@xO /
	defb 02fh,016h,000h,03ch,07eh,07ah,07dh,079h,07eh,0f2h,02eh,02dh,058h,059h,0e9h,03ch	; 6f3a  /..<~z}y~..-XY.<
	defb 00fh,000h,0fch,0fch,038h,098h,050h,050h,0c0h,000h,000h,090h,000h,001h,002h,003h	; 6f4a  ....8.PP........
	defb 003h,03dh,052h,03dh,000h,080h,040h,0c0h,0c0h,0bch,04ah,0bch,006h,003h,082h,002h	; 6f5a  .=R=..@...J.....
	defb 001h,006h,0c0h,082h,040h,080h,000h,09bh,000h,007h,00ch,00ch,00fh,007h,001h,003h	; 6f6a  ....@...........
	defb 01ch,0b6h,0e2h,0e6h,09ch,01fh,0b3h,0f3h,047h,0eeh,05dh,03ah,074h,0e8h,0d0h,0e0h	; 6f7a  ........G.]:t...
	defb 0bdh,0b1h,01eh,005h,000h,000h,000h	; 6f8a

; ----------------------------------------------------------------------
; DATOS dibujos_cosa_0D: los dibujos de la cosa 0x0D, rle a los tres tercios
;   (0x5BFC); se solapan 31 bloques (0x6F91-0x6FB1, 0x6F91-0x7342,
;   0x6FB1-0x6FD3, 0x6FD3-0x6FF5, 0x6FF5-0x700D, 0x700D-0x702F); lo leen
;   p00:5734, p00:58F3 (945 bytes)
;   0x6f91..0x7342  (945 bytes)
DATA_dibujos_cosa_0D:
	defb 004h,000h,09ch,003h,01bh,018h,060h,000h,008h,060h,066h,006h,000h,003h,003h,060h	; 6f91  ......`..`f....`
	defb 000h,020h,070h,04eh,01fh,017h,00eh,000h,006h,00eh,074h,0f8h,068h,030h,000h,000h	; 6fa1  . pN......t.h0..
	defb 088h,000h,004h,00eh,004h,011h,05bh,004h,044h,003h,000h,095h,010h,011h,0bbh,0ffh	; 6fb1  ......[.D.......
	defb 021h,044h,06eh,03fh,07bh,03fh,04fh,030h,00fh,021h,073h,0feh,0dfh,0feh,0f9h,006h	; 6fc1  !Dn?{?O0.!s.....
	defb 0f8h,000h,088h,000h,060h,030h,030h,06bh,04ah,05ah,019h,003h,000h,095h,003h,0a6h	; 6fd1  ....`00kJZ......
	defb 076h,0eeh,0ceh,00fh,004h,024h,014h,01fh,026h,016h,006h,08ch,010h,01ch,03ch,0e4h	; 6fe1  v....$..&.....<.
	defb 00ch,0f8h,0e0h,000h,009h,000h,090h,001h,003h,006h,00ch,018h,030h,060h,000h,005h	; 6ff1  ............0`..
	defb 00bh,017h,02fh,02eh,078h,070h,0c0h,003h,080h,004h,000h,000h,085h,000h,003h,017h	; 7001  ../.xp..........
	defb 016h,001h,003h,00bh,098h,000h,0f8h,0f8h,000h,00fh,03ch,060h,05eh,00ah,00ah,00bh	; 7011  ..........<`^...
	defb 012h,02fh,05fh,03fh,07fh,090h,0b8h,0f0h,080h,0f8h,0f8h,0c0h,038h,000h,0a0h,000h	; 7021  ./_?........8...
	defb 007h,00fh,00fh,000h,00ah,00ah,007h,000h,0e0h,0f0h,0f0h,000h,0d0h,050h,0e0h,01bh	; 7031  .............P..
	defb 03ch,01fh,027h,028h,01fh,000h,01eh,0d8h,03ch,0f8h,0e4h,014h,0f8h,000h,078h,000h	; 7041  <.'(....<.....x.
	defb 091h,000h,007h,014h,037h,02dh,068h,06dh,0edh,000h,0e0h,028h,0ech,0cch,09ch,09eh	; 7051  ....7-hm...(....
	defb 03eh,0afh,003h,0a6h,08ch,03fh,01fh,03fh,000h,03ah,07ah,03ah,05ah,0e6h,0f8h,0fch	; 7061  >....?.?.:z:Z...
	defb 000h,000h,002h,000h,083h,00ch,00bh,007h,003h,00fh,003h,000h,088h,0c0h,0e0h,0f0h	; 7071  ................
	defb 0feh,00fh,00fh,007h,003h,003h,001h,002h,000h,088h,0f8h,0f1h,0e0h,0cch,08eh,096h	; 7081  ................
	defb 0a0h,000h,000h,006h,000h,082h,001h,00fh,006h,000h,085h,0fch,00eh,038h,071h,03fh	; 7091  .............8q?
	defb 005h,000h,083h,01ch,0f0h,080h,005h,000h,000h,002h,000h,002h,001h,002h,000h,002h	; 70a1  ................
	defb 001h,081h,000h,004h,080h,083h,000h,080h,080h,004h,001h,084h,00eh,003h,001h,003h	; 70b1  ................
	defb 004h,080h,084h,076h,0d4h,088h,0c0h,000h,0a0h,000h,00dh,012h,017h,007h,01bh,004h	; 70c1  ...v............
	defb 017h,000h,09eh,039h,0f6h,0e9h,0d7h,02ch,0f3h,017h,007h,013h,011h,034h,035h,06bh	; 70d1  ...9...,.....45k
	defb 06bh,0f3h,0d3h,0e4h,08fh,02eh,09dh,0b9h,0b3h,000h,005h,000h,09bh,010h,038h,03dh	; 70e1  k.............8=
	defb 000h,000h,028h,018h,02eh,037h,07bh,0fdh,07eh,0bfh,0deh,06ch,074h,018h,014h,004h	; 70f1  ..(..7{.~..lt...
	defb 0feh,07fh,0bfh,03eh,01eh,008h,000h,000h,000h,088h,000h,004h,002h,003h,002h,005h	; 7101  ...>............
	defb 00ah,005h,004h,000h,094h,0c0h,030h,098h,0cah,018h,005h,00bh,013h,01bh,01bh,00bh	; 7111  ......0.........
	defb 001h,00ch,0ffh,00fh,000h,002h,006h,03eh,006h,000h,006h,000h,082h,040h,020h,005h	; 7121  .......>.....@ .
	defb 000h,093h,080h,002h,085h,023h,02ch,02fh,02fh,017h,003h,001h,003h,0e5h,019h,0fah	; 7131  .....#,//.......
	defb 0fah,0f4h,0e4h,0c0h,0e0h,000h,082h,000h,003h,004h,001h,084h,037h,04ah,000h,0e0h	; 7141  ............7J..
	defb 004h,0c0h,092h,0f6h,0a9h,04ah,02dh,00dh,016h,006h,007h,003h,003h,0a9h,05ah,058h	; 7151  .....J-.......ZX
	defb 0b4h,0b0h,0f0h,0e0h,0e0h,000h,002h,000h,08fh,00ah,020h,040h,000h,040h,010h,000h	; 7161  .......... @.@..
	defb 000h,0a0h,008h,000h,004h,000h,004h,005h,007h,000h,088h,040h,018h,000h,060h,0a0h	; 7171  ...........@..`.
	defb 0a0h,0c0h,000h,000h,0a0h,000h,010h,008h,010h,022h,024h,018h,008h,000h,000h,032h	; 7181  ........."$....2
	defb 04ch,048h,020h,020h,010h,000h,004h,000h,002h,038h,038h,010h,000h,004h,000h,004h	; 7191  LH  .....88.....
	defb 000h,01ch,01ch,008h,000h,000h,002h,000h,09eh,003h,007h,00ch,01dh,01eh,027h,000h	; 71a1  ..............'.
	defb 0f8h,0cch,0d6h,0eeh,072h,062h,0c4h,02bh,073h,05eh,05ch,068h,039h,01eh,000h,084h	; 71b1  ....rb.+s^\h9...
	defb 008h,010h,020h,040h,080h,000h,000h,000h,088h,000h,00eh,019h,01dh,01bh,00eh,000h	; 71c1  .. @............
	defb 007h,003h,000h,087h,078h,07ch,060h,082h,002h,00eh,00eh,003h,00ch,08bh,006h,003h	; 71d1  ....x|`.........
	defb 000h,002h,004h,004h,008h,018h,060h,040h,000h,000h,002h,000h,090h,001h,003h,006h	; 71e1  ......`@........
	defb 00eh,01ch,03fh,000h,000h,0feh,0bfh,01dh,07bh,0f7h,0eeh,07fh,0ffh,003h,07fh,08bh	; 71f1  ..?.....{.......
	defb 0ffh,000h,000h,0deh,0fch,078h,030h,020h,0c0h,000h,000h,000h,084h,000h,07fh,031h	; 7201  .....x0 .......1
	defb 034h,004h,035h,088h,000h,080h,0c0h,0e0h,07eh,003h,055h,055h,005h,035h,08bh,03dh	; 7211  4.5.....~.UU.5.=
	defb 03fh,07fh,053h,056h,04ch,058h,030h,060h,0c0h,0c0h,000h,0a0h,000h,001h,003h,002h	; 7221  ?.SVLX0`........
	defb 006h,004h,00ch,008h,000h,080h,081h,0c1h,063h,026h,034h,018h,018h,010h,030h,020h	; 7231  ........c&4...0
	defb 060h,04fh,000h,000h,008h,02ch,064h,0c6h,003h,0ffh,000h,000h,000h,006h,000h,09ah	; 7241  `O...,d.........
	defb 040h,030h,000h,000h,007h,03ah,046h,03eh,078h,073h,000h,018h,010h,006h,008h,002h	; 7251  @0...:F>xs......
	defb 003h,000h,00fh,03fh,01eh,021h,0beh,0cch,070h,000h,000h,082h,000h,007h,006h,003h	; 7261  ...?.!..p.......
	defb 098h,000h,0e0h,0c0h,0c0h,0cch,0d2h,0c2h,0c2h,00fh,01fh,037h,02ah,01dh,03fh,01fh	; 7271  ...........7*.?.
	defb 007h,0f2h,0fah,074h,0a8h,0dch,0fch,0f8h,0e0h,000h,002h,000h,084h,001h,002h,001h	; 7281  ...t............
	defb 003h,003h,000h,090h,0e7h,00eh,01ch,0fch,006h,060h,0c0h,001h,003h,006h,00ch,018h	; 7291  .........`......
	defb 030h,060h,080h,080h,007h,000h,000h,005h,000h,097h,001h,002h,000h,000h,003h,007h	; 72a1  0`..............
	defb 00eh,004h,0fch,00fh,0a0h,001h,002h,005h,00bh,017h,02fh,038h,020h,040h,0c0h,080h	; 72b1  ........../8 @..
	defb 080h,004h,000h,000h,099h,000h,001h,005h,00fh,00eh,02dh,03bh,03bh,03fh,06eh,0beh	; 72c1  ..........-..?n.
	defb 07ch,0e0h,0f0h,080h,060h,037h,017h,0ach,051h,02ch,022h,060h,060h,0c0h,007h,000h	; 72d1  |...`7..Q,"``...
	defb 000h,004h,000h,002h,001h,09ah,000h,003h,000h,07eh,013h,0a9h,05dh,05ah,09ah,0e4h	; 72e1  .........~..]Z..
	defb 001h,005h,00ah,00ah,015h,015h,020h,01fh,014h,068h,0e8h,0d0h,0a0h,060h,0c0h,000h	; 72f1  ...... ..h...`..
	defb 000h,0a0h,000h,00fh,010h,01fh,010h,007h,000h,01fh,000h,080h,040h,0c0h,040h,080h	; 7301  ............@.@.
	defb 040h,0c0h,01fh,01fh,00fh,003h,005h,00eh,00fh,007h,0c0h,0c0h,068h,0b6h,0dfh,08ah	; 7311  @...........h...
	defb 05fh,0fch,000h,005h,000h,083h,001h,003h,00fh,004h,000h,089h,080h,0c0h,0e0h,0f8h	; 7321  _...............
	defb 03fh,07fh,03fh,057h,001h,003h,000h,085h,0feh,079h,0feh,0f9h,020h,003h,000h,000h	; 7331  ?.?W.....y.. ...
	defb 000h	; 7341

; ----------------------------------------------------------------------
; DATOS dibujos_cosa_2B: los dibujos de la cosa 0x2B, rle a los tres tercios
;   (0x5BFC); lo leen p00:58F3 (33 bytes)
;   0x7342..0x7363  (33 bytes)
DATA_dibujos_cosa_2B:
	defb 003h,000h,09dh,001h,003h,003h,006h,007h,000h,03ch,0f6h,0bah,07fh,0efh,0fdh,07dh	; 7342  .........<.....}
	defb 00ch,00fh,007h,00fh,00dh,007h,004h,003h,0edh,0f9h,0fah,0b6h,0fch,0d8h,070h,0c0h	; 7352  ..............p.
	defb 000h	; 7362

; ----------------------------------------------------------------------
; DATOS dibujos_cosa_2C: los dibujos de la cosa 0x2C, rle a los tres tercios
;   (0x5BFC); lo leen p00:58F3 (34 bytes)
;   0x7363..0x7385  (34 bytes)
DATA_dibujos_cosa_2C:
	defb 0a0h,000h,007h,01eh,01ch,03dh,027h,02ch,049h,000h,0fch,0feh,0feh,09eh,0ceh,0ceh	; 7363  .....=',I.......
	defb 08ch,040h,046h,066h,030h,03bh,031h,01fh,00ch,01ch,03ch,078h,0f0h,0e0h,0c0h,000h	; 7373  .@Ff0.1...<x....
	defb 000h,000h	; 7383

; ----------------------------------------------------------------------
; DATOS colores_cosa_07: los colores de la cosa 0x07, rle a los tres tercios
;   (0x5BFC); se solapan 7 bloques (0x7385-0x73A6, 0x7385-0x73E5,
;   0x73A6-0x73BC, 0x73BC-0x73C1, 0x73C1-0x73CC, 0x73CC-0x73DB); lo leen
;   p00:572B, p00:5901 (96 bytes)
;   0x7385..0x73e5  (96 bytes)
DATA_colores_cosa_07:
	defb 002h,0f0h,086h,000h,0b0h,0f0h,050h,050h,0e0h,004h,0b0h,081h,0f0h,003h,0e0h,082h	; 7385  ......PP........
	defb 0f0h,0b0h,003h,050h,002h,070h,089h,050h,0f0h,0f0h,050h,0f0h,0f0h,070h,0f0h,050h	; 7395  ...P.p.P..P..p.P
	defb 000h,002h,0a0h,007h,080h,083h,0a0h,060h,060h,003h,090h,002h,080h,007h,060h,082h	; 73a5  .......``.....`.
	defb 080h,090h,003h,060h,003h,040h,000h,005h,080h,01bh,070h,000h,008h,0b0h,008h,0f0h	; 73b5  ...`.@....p.....
	defb 008h,0b0h,003h,0f0h,005h,0b0h,000h,002h,0a0h,081h,0b0h,006h,0a0h,002h,0f0h,005h	; 73c5  ................
	defb 0b0h,008h,0a0h,008h,0b0h,000h,005h,0b0h,003h,0a0h,004h,0b0h,014h,0a0h,000h,000h	; 73d5  ................

; ----------------------------------------------------------------------
; DATOS colores_cosa_0D: los colores de la cosa 0x0D, rle a los tres tercios
;   (0x5BFC); se solapan 31 bloques (0x73E5-0x73F9, 0x73E5-0x75B7,
;   0x73F9-0x7408, 0x7408-0x741C, 0x741C-0x741F, 0x741F-0x7435); lo leen
;   p00:573D, p00:5901 (466 bytes)
;   0x73e5..0x75b7  (466 bytes)
DATA_colores_cosa_0D:
	defb 00eh,070h,081h,0f0h,003h,070h,083h,0f0h,070h,0f0h,004h,070h,084h,0f0h,070h,0f0h	; 73e5  .p...p..p..p..p.
	defb 0f0h,003h,070h,000h,004h,0a0h,002h,060h,005h,0a0h,004h,060h,081h,096h,008h,0a0h	; 73f5  ..p....`...`....
	defb 008h,090h,000h,003h,0b0h,005h,0e0h,006h,0b0h,002h,0f0h,008h,0e0h,081h,0f0h,003h	; 7405  ................
	defb 0b0h,084h,0f0h,0b0h,0e0h,0e0h,000h,020h,090h,000h,004h,050h,081h,040h,004h,050h	; 7415  ....... ...P.@.P
	defb 002h,040h,082h,0a0h,0a4h,003h,0a0h,007h,050h,081h,040h,004h,0a0h,004h,040h,000h	; 7425  .@......P.@...@.
	defb 005h,020h,003h,0b0h,005h,0c0h,003h,0b0h,007h,020h,081h,0b0h,007h,0c0h,081h,0b0h	; 7435  . ....... ......
	defb 000h,002h,040h,007h,0f0h,082h,040h,0f0h,005h,0e0h,005h,0f0h,003h,040h,005h,0e0h	; 7445  ..@...@......@..
	defb 003h,040h,000h,00bh,0a0h,002h,0f0h,002h,0a0h,084h,0fah,0a0h,0a0h,090h,003h,0a0h	; 7455  .@..............
	defb 081h,090h,006h,0a0h,003h,090h,000h,010h,0f0h,010h,0a0h,000h,006h,090h,002h,0f0h	; 7465  ................
	defb 003h,090h,082h,0a0h,090h,003h,070h,004h,0f0h,002h,050h,002h,040h,004h,070h,002h	; 7475  ......p...P.@.p.
	defb 0e0h,082h,050h,0e0h,000h,004h,030h,082h,020h,030h,003h,020h,081h,030h,003h,020h	; 7485  ..P...0. 0. .0.
	defb 002h,0c0h,003h,020h,002h,030h,00ch,0c0h,000h,008h,080h,008h,090h,008h,080h,008h	; 7495  ... .0..........
	defb 090h,000h,004h,070h,004h,0c0h,005h,070h,003h,020h,008h,0c0h,002h,070h,081h,072h	; 74a5  ...p...p. ...p.r
	defb 005h,0c0h,000h,006h,0a0h,007h,050h,003h,0a0h,004h,050h,003h,040h,089h,050h,0a0h	; 74b5  ......P...P.@.P.
	defb 050h,050h,0a0h,0a0h,050h,040h,0a0h,000h,002h,080h,081h,060h,003h,080h,085h,090h	; 74c5  PP..P@.....`....
	defb 080h,090h,090h,060h,003h,080h,002h,090h,006h,080h,082h,060h,080h,006h,090h,082h	; 74d5  ...`.......`....
	defb 060h,090h,000h,011h,0a0h,005h,070h,004h,0a0h,004h,070h,082h,0c0h,0a0h,000h,007h	; 74e5  `.....p...p.....
	defb 0a0h,081h,090h,006h,0a0h,006h,090h,083h,0f0h,070h,070h,005h,090h,081h,0f0h,003h	; 74f5  .........pp.....
	defb 070h,000h,081h,070h,00eh,090h,004h,080h,005h,060h,081h,080h,007h,060h,000h,002h	; 7505  p..p.....`...`..
	defb 0f0h,002h,070h,002h,050h,005h,0b0h,081h,0f0h,003h,0b0h,081h,030h,005h,0b0h,003h	; 7515  ..p.P.......0...
	defb 0a0h,006h,030h,002h,0a0h,000h,012h,040h,003h,0f0h,00bh,040h,000h,003h,0b0h,005h	; 7525  ..0....@...@....
	defb 0a0h,005h,0f0h,002h,0b0h,011h,0a0h,000h,008h,0f0h,018h,070h,000h,00fh,0a0h,081h	; 7535  ...........p....
	defb 0f0h,008h,0a0h,081h,0f0h,007h,0a0h,000h,002h,030h,081h,0c0h,007h,020h,006h,0c0h	; 7545  .........0... ..
	defb 005h,030h,003h,0c0h,005h,020h,003h,0c0h,000h,00ch,040h,082h,050h,040h,012h,0f0h	; 7555  .0... ....@.P@..
	defb 000h,006h,090h,007h,080h,083h,090h,080h,0e0h,008h,0f0h,004h,0e0h,004h,0f0h,000h	; 7565  ................
	defb 005h,0a0h,083h,0f0h,0a0h,0f0h,005h,0a0h,082h,0f0h,0a0h,006h,0f0h,003h,0e0h,008h	; 7575  ................
	defb 0f0h,000h,006h,080h,00bh,090h,007h,080h,008h,090h,000h,005h,0f0h,003h,070h,005h	; 7585  ..............p.
	defb 0f0h,083h,070h,0f0h,0f0h,003h,070h,003h,090h,002h,0b0h,082h,070h,0f0h,003h,090h	; 7595  ..p...p.....p...
	defb 002h,0b9h,081h,0b0h,000h,008h,0e0h,008h,0f0h,008h,0e0h,082h,0f0h,0feh,006h,0e0h	; 75a5  ................
	defb 000h,000h	; 75b5

; ----------------------------------------------------------------------
; DATOS colores_cosa_2B: los colores de la cosa 0x2B, rle a los tres tercios
;   (0x5BFC); lo leen p00:5901 (14 bytes)
;   0x75b7..0x75c5  (14 bytes)
DATA_colores_cosa_2B:
	defb 007h,0e0h,081h,0f0h,003h,0e0h,082h,0f0h,0feh,003h,0f0h,010h,0e0h,000h	; 75b7  ..............

; ----------------------------------------------------------------------
; DATOS colores_cosa_2C: los colores de la cosa 0x2C, rle a los tres tercios
;   (0x5BFC); lo leen p00:5901 (13 bytes)
;   0x75c5..0x75d2  (13 bytes)
DATA_colores_cosa_2C:
	defb 004h,0f0h,005h,0b0h,081h,0f0h,006h,0a0h,006h,0b0h,00ah,0a0h,000h	; 75c5  .............

; ----------------------------------------------------------------------
; DATOS dibujos_75D2: los dibujos de unos caracteres desde el 0x76, en rle
;   (0x5C46), que pide la ficha 0x6365; lo leen p00:59A3 (113 bytes)
;   0x75d2..0x7643  (113 bytes)
DATA_dibujos_75D2:
	defb 0e1h,02fh,03fh,018h,005h,00dh,00fh,007h,000h,0f4h,0fch,018h,0a0h,0b0h,0f0h,0e0h	; 75d2  ./?.............
	defb 006h,037h,00fh,031h,02ah,015h,00ah,00eh,01eh,0efh,0efh,08fh,04bh,0abh,046h,070h	; 75e2  .7.1*.......K.Fp
	defb 078h,000h,000h,007h,01fh,01fh,03fh,03fh,038h,000h,000h,080h,0d0h,0e8h,0e8h,0f4h	; 75f2  x.....??8.......
	defb 074h,017h,00ah,00ah,00ch,00eh,004h,02ch,035h,0b4h,0d4h,0c8h,0d0h,020h,070h,0ech	; 7602  t......,5.... p.
	defb 09ch,017h,02fh,018h,005h,00dh,00fh,007h,000h,0e8h,0f4h,018h,0a0h,0b0h,0f0h,0e0h	; 7612  ../.............
	defb 006h,037h,00fh,031h,02ah,01fh,00ah,00eh,01eh,0efh,0efh,08fh,04bh,0ebh,046h,070h	; 7622  .7.1*.......K.Fp
	defb 078h,000h,003h,07fh,009h,000h,003h,07fh,081h,000h,003h,07fh,081h,000h,003h,07fh	; 7632  x...............
	defb 000h	; 7642

; ----------------------------------------------------------------------
; DATOS colores_7643: los colores de unos caracteres desde el 0x76, en rle
;   (0x5C46), que pide la ficha 0x6365; lo leen p00:59A3 (71 bytes)
;   0x7643..0x768a  (71 bytes)
DATA_colores_7643:
	defb 083h,0f0h,070h,070h,005h,0b0h,083h,0f0h,070h,070h,004h,0b0h,002h,070h,002h,0f0h	; 7643  ..pp....pp...p..
	defb 081h,070h,003h,0f0h,002h,070h,002h,0f0h,081h,070h,003h,0f0h,081h,070h,013h,0b0h	; 7653  .p...p...p...p..
	defb 003h,070h,002h,0d0h,004h,0b0h,005h,0d0h,002h,060h,005h,0b0h,083h,0d0h,060h,060h	; 7663  .p.......`....``
	defb 004h,0b0h,002h,060h,002h,0d0h,08dh,060h,0d0h,0d0h,0b0h,060h,060h,0d0h,0d0h,060h	; 7673  ...`...`...``..`
	defb 0d0h,0d0h,0b0h,060h,018h,0f0h,000h	; 7683

; ----------------------------------------------------------------------
; DATOS dibujos_768A: los dibujos de unos caracteres desde el 0x6A, en rle
;   (0x5C46), que pide la ficha 0x635E; lo leen p00:57F5 (274 bytes)
;   0x768a..0x779c  (274 bytes)
DATA_dibujos_768A:
	defb 085h,00eh,03ch,07ch,0ffh,0ffh,006h,000h,002h,0ffh,083h,03eh,03ch,070h,003h,000h	; 768a  ..<|.......><p..
	defb 002h,0ffh,003h,000h,008h,018h,005h,000h,084h,001h,007h,00fh,040h,004h,060h,083h	; 769a  ............@.`.
	defb 0e0h,0f0h,0f0h,003h,00fh,085h,007h,003h,007h,004h,003h,003h,0f0h,085h,0a0h,0c0h	; 76aa  ................
	defb 0e0h,020h,0c0h,003h,000h,08ah,003h,007h,00eh,01ch,018h,018h,01ch,00eh,007h,003h	; 76ba  . ..............
	defb 006h,000h,08ah,0c0h,0e0h,070h,038h,018h,018h,038h,070h,0e0h,0c0h,003h,000h,0ffh	; 76ca  .....p8..8p.....
	defb 063h,0e3h,0a7h,0a4h,0a0h,023h,000h,070h,0e8h,0d8h,0fch,044h,0e0h,0b8h,0e0h,0e0h	; 76da  c....#.p...D....
	defb 051h,060h,007h,02bh,02ch,023h,027h,02fh,050h,0e0h,0eeh,0dbh,033h,0fah,0d4h,02ch	; 76ea  Q`.+,#'/P...3..,
	defb 01fh,03fh,05fh,05ah,04fh,02ah,035h,01fh,0c0h,0e0h,0d0h,0c4h,0dbh,09fh,064h,0c4h	; 76fa  .?_ZO*5.......d.
	defb 007h,058h,0bfh,0c0h,080h,07fh,000h,078h,00ch,0deh,0ech,000h,0f0h,0f0h,000h,0f0h	; 770a  .X.....x........
	defb 00fh,01ch,01bh,016h,037h,008h,0dfh,0efh,0f8h,01ch,0ech,0b4h,0f6h,088h,07ch,0f8h	; 771a  ....7.........|.
	defb 0c7h,039h,05fh,04fh,048h,05fh,059h,056h,0f0h,0c0h,00ch,00ch,014h,0fch,0cch,0b4h	; 772a  .9_OH_YV........
	defb 003h,00dh,014h,0dbh,055h,010h,067h,067h,0e0h,058h,094h,0ech,0d4h,084h,0b0h,030h	; 773a  ....U.gg.X.....0
	defb 003h,04ch,047h,041h,04fh,058h,047h,05fh,0e0h,01ah,0f6h,0c2h,078h,08ch,0f0h,0c1h	; 774a  .LGAOXG_....x...
	defb 0fch,047h,04fh,04dh,05ah,057h,054h,04fh,0e7h,0f0h,078h,0d8h,0ach,074h,094h,0b8h	; 775a  .GOMZWTO..x..t..
	defb 070h,001h,0deh,0e7h,059h,007h,00bh,005h,01eh,0c0h,03fh,03dh,03dh,03fh,03dh,0c4h	; 776a  p...Y.....?==?=.
	defb 01eh,047h,0eah,055h,058h,053h,016h,04eh,067h,0f0h,028h,0dch,09ch,064h,0b4h,0b8h	; 777a  .G.UXS.Ng.(..d..
	defb 0f0h,04bh,004h,05bh,04ch,043h,047h,047h,04dh,0e8h,010h,0e6h,08bh,06fh,06bh,0ebh	; 778a  .K.[LCGGM....ok.
	defb 0d6h,000h	; 779a

; ----------------------------------------------------------------------
; DATOS colores_779C: los colores de unos caracteres desde el 0x6A, en rle
;   (0x5C46), que pide la ficha 0x635E; lo leen p00:57F5 (149 bytes)
;   0x779c..0x7831  (149 bytes)
DATA_colores_779C:
	defb 062h,0f0h,004h,0e0h,005h,0f0h,081h,0e0h,004h,0f0h,002h,0e0h,081h,050h,005h,040h	; 779c  b............P.@
	defb 002h,0e0h,088h,050h,040h,050h,040h,040h,0e0h,0f0h,090h,004h,0b0h,002h,0f0h,082h	; 77ac  ...P@P@@........
	defb 0e0h,060h,004h,0b0h,002h,0e0h,086h,0f0h,060h,090h,0b0h,0b6h,090h,003h,0b0h,004h	; 77bc  .`......`.......
	defb 060h,002h,090h,083h,0b0h,0f0h,0f0h,003h,0b0h,005h,0f0h,004h,0b0h,002h,0e0h,083h	; 77cc  `...............
	defb 0f0h,040h,040h,005h,050h,002h,0e0h,086h,0b4h,0b5h,040h,040h,050h,050h,004h,0f0h	; 77dc  .@@.P.....@@PP..
	defb 004h,0b0h,003h,0e0h,081h,0f0h,005h,0b0h,007h,0d0h,081h,0b0h,003h,060h,002h,0d0h	; 77ec  .............`..
	defb 082h,060h,0d0h,004h,0f0h,004h,0b0h,004h,0e0h,005h,0b0h,002h,030h,003h,020h,08eh	; 77fc  .`..........0. .
	defb 0e0h,020h,0b0h,0c0h,0c3h,0c2h,0c0h,0c2h,0ech,0c0h,0f0h,0f0h,070h,050h,004h,0b0h	; 780c  . ..........pP..
	defb 002h,0f0h,082h,070h,050h,005h,0b0h,083h,0d0h,070h,070h,004h,0f0h,082h,0b0h,0d0h	; 781c  ...pP....pp.....
	defb 004h,070h,002h,0f0h,000h	; 782c

; ----------------------------------------------------------------------
; DATOS rle_7831: rle a la VRAM (0x5C46); lo leen p00:575B (24 bytes)
;   0x7831..0x7849  (24 bytes)
DATA_rle_7831:
	defb 083h,03fh,060h,0c0h,00ah,080h,086h,0c0h,060h,03fh,0fch,006h,003h,00ah,001h,083h	; 7831  .?`.....`?......
	defb 003h,006h,0fch,003h,0feh,01dh,000h,000h	; 7841  ........

; ----------------------------------------------------------------------
; DATOS rle_7849: rle a la VRAM (0x5C46); lo leen p00:594A (190 bytes)
;   0x7849..0x7907  (190 bytes)
DATA_rle_7849:
	defb 090h,000h,00eh,01dh,038h,038h,031h,013h,017h,007h,004h,007h,002h,003h,001h,007h	; 7849  ....881.........
	defb 00dh,003h,000h,092h,03ch,0fbh,0ffh,0efh,0efh,07fh,0cfh,096h,037h,073h,07bh,0ffh	; 7859  ....<.......7s{.
	defb 0ffh,01fh,01ch,01eh,00fh,006h,003h,000h,085h,01ch,03eh,02eh,032h,01eh,003h,000h	; 7869  ..........>.2...
	defb 08ch,0ffh,0eeh,070h,0f9h,07fh,03dh,05fh,08bh,0c7h,0eeh,07fh,03ch,005h,000h,08fh	; 7879  ...p..=_....<...
	defb 018h,03fh,00fh,0f2h,0fch,0ffh,0ffh,0fdh,0ffh,0fdh,03bh,0f3h,007h,09ch,0ffh,003h	; 7889  .?..............
	defb 000h,0a9h,080h,0c0h,0c0h,0c4h,0deh,096h,0deh,0cch,080h,080h,010h,098h,0d8h,0feh	; 7899  ................
	defb 073h,0fdh,0fbh,073h,087h,0deh,07ch,00ah,087h,067h,041h,036h,01ch,000h,000h,0d8h	; 78a9  s..s..|..gA6....
	defb 0d0h,080h,0b0h,098h,05ch,0fch,03ch,0fch,0e8h,098h,0f0h,019h,000h,08bh,001h,007h	; 78b9  ....\.<.........
	defb 00fh,06fh,0e4h,0ceh,0b9h,0b9h,03ch,02fh,026h,010h,000h,088h,093h,087h,06fh,0eah	; 78c9  .o....</&.....o.
	defb 04bh,005h,033h,038h,00dh,000h,08bh,038h,0bch,078h,047h,0efh,0fbh,0ffh,0fah,0fbh	; 78d9  K.38...8.xG.....
	defb 0f0h,0e6h,009h,000h,08fh,080h,0c0h,050h,058h,098h,038h,018h,0bfh,0ffh,0fdh,072h	; 78e9  .......PX.8....r
	defb 03ch,0c0h,09ah,01ch,008h,000h,084h,028h,060h,030h,060h,00ch,000h,000h	; 78f9  <......(`0`...

; ----------------------------------------------------------------------
; DATOS copia_7907: una terna [desde][hasta][cuantos] y el 0xFF que acaba, que
;   p00:593A pasa en IX a p00:59BF
;   0x7907..0x790b  (4 bytes)
DATA_copia_7907:
	defb 058h,000h,00ch,0ffh	; 7907

; ----------------------------------------------------------------------
; DATOS rle_790B: rle a la VRAM con el destino delante (0x5C40); lo leen
;   p00:593E (549 bytes)
;   0x790b..0x7b30  (549 bytes)
DATA_rle_790B:
	defb 000h,018h,0e0h,0bdh,0dbh,057h,0ach,0d0h,0e8h,070h,00ch,02dh,02ah,016h,029h,056h	; 790b  .....W...p.-*.)V
	defb 009h,017h,01fh,0c0h,0f0h,002h,002h,003h,083h,003h,003h,0dbh,0ebh,0e3h,043h,0a2h	; 791b  ..............C.
	defb 002h,000h,0c0h,000h,0bdh,0dbh,057h,0ach,0d0h,0e8h,070h,00ch,02dh,02ah,016h,029h	; 792b  ......W...p.-*.)
	defb 056h,070h,03ch,000h,0c0h,0f0h,002h,002h,003h,083h,003h,003h,0dbh,0ebh,0e3h,043h	; 793b  Vp<............C
	defb 0aah,07ah,070h,000h,05eh,06dh,02bh,056h,068h,074h,0b2h,0cdh,0dbh,0ddh,0aeh,055h	; 794b  .zp.^m+Vht.....U
	defb 02ah,0e1h,0f9h,000h,0e0h,0f8h,080h,000h,000h,040h,000h,0c1h,0d9h,0bfh,01dh,041h	; 795b  *........@.....A
	defb 0a0h,040h,0f0h,003h,07fh,00eh,000h,081h,0c0h,00fh,000h,0beh,0bdh,0dbh,057h,0ach	; 796b  .@............W.
	defb 0d0h,0e8h,070h,00ch,02dh,02ah,0d6h,0a9h,0d6h,060h,000h,000h,0c0h,0f0h,002h,002h	; 797b  ..p.-*...`......
	defb 003h,083h,003h,003h,0dbh,0e3h,0ebh,05bh,0bah,012h,000h,000h,05eh,06dh,02bh,056h	; 798b  .......[....^m+V
	defb 068h,074h,0b2h,0cdh,0dbh,05dh,0aeh,0d5h,0cah,060h,000h,000h,0e0h,0f8h,080h,000h	; 799b  ht...]...`......
	defb 000h,040h,000h,0c1h,0d9h,0bfh,01dh,041h,0b8h,010h,01ch,000h,085h,008h,028h,0ech	; 79ab  .@.....A......(.
	defb 0d8h,0f0h,01bh,000h,093h,008h,028h,0ech,0d8h,010h,000h,000h,0beh,0ddh,053h,0afh	; 79bb  ......(.......S.
	defb 0d0h,0e8h,070h,007h,016h,011h,00fh,003h,004h,000h,08eh,0c0h,0e0h,0f0h,004h,002h	; 79cb  ..p.............
	defb 00fh,017h,06ch,0d0h,02dh,057h,06eh,046h,020h,003h,000h,08dh,05fh,06fh,02eh,055h	; 79db  ..l.-WnF ..._o.U
	defb 06bh,074h,032h,00dh,05bh,0ddh,0aeh,095h,04ah,003h,000h,08dh,0a0h,070h,0f8h,0e0h	; 79eb  kt2.[...J....p..
	defb 000h,040h,000h,040h,080h,030h,0d8h,068h,0b6h,01dh,000h,083h,00fh,032h,008h,01dh	; 79fb  .@.@.0.h.....2..
	defb 000h,087h,003h,016h,01ch,02eh,09fh,03fh,04eh,01ch,000h,084h,00eh,05fh,0bfh,02eh	; 7a0b  .......?N...._..
	defb 01ch,000h,0ffh,027h,037h,00fh,03fh,03fh,05fh,06fh,0d0h,0d7h,0efh,0f1h,06ah,055h	; 7a1b  ...'7.??_o....jU
	defb 02ah,00eh,00eh,0e4h,0ech,0f0h,0fch,0fch,0f8h,0f0h,008h,0ech,0f0h,08ch,054h,0a8h	; 7a2b  *.............T.
	defb 050h,070h,000h,027h,037h,00fh,03fh,03fh,05fh,06fh,0d0h,0d7h,0efh,0f1h,06ah,055h	; 7a3b  Pp.'7.??_o....jU
	defb 02ah,00eh,000h,0e4h,0ech,0f0h,0fch,0fch,0f8h,0f0h,008h,0ech,0f0h,08ch,054h,0a8h	; 7a4b  *.............T.
	defb 050h,070h,070h,02fh,03fh,018h,030h,020h,014h,010h,008h,037h,00fh,031h,02ah,015h	; 7a5b  Ppp/?.0 ...7.1*.
	defb 00ah,00eh,00eh,0f4h,0fch,018h,00ch,004h,028h,008h,016h,0efh,0efh,08fh,04bh,0abh	; 7a6b  ........(.....K.
	defb 049h,076h,000h,02fh,03fh,018h,030h,020h,014h,010h,008h,037h,00fh,031h,02ah,015h	; 7a7b  Iv./?.0 ...7.1*.
	defb 00ah,00eh,000h,0f4h,0fch,018h,00ch,004h,028h,008h,016h,0efh,0efh,08fh,04bh,0abh	; 7a8b  ........(.....K.
	defb 049h,076h,081h,070h,01ch,000h,08ch,05ah,0dbh,0bdh,07eh,010h,042h,018h,03dh,0bch	; 7a9b  Iv.p...Z..~.B.=.
	defb 018h,042h,008h,018h,000h,088h,024h,000h,099h,03ch,03ch,099h,000h,024h,018h,000h	; 7aab  .B....$..<<..$..
	defb 084h,005h,01ah,03fh,00fh,00ch,000h,084h,0a0h,058h,0fch,0f0h,00ch,000h,080h,040h	; 7abb  ...?.....X.....@
	defb 01ch,084h,074h,0f9h,0fch,072h,01ch,000h,084h,070h,0fah,0fdh,074h,01dh,000h,0beh	; 7acb  ..t..r...p..t...
	defb 04eh,01ah,035h,03ah,050h,038h,030h,070h,0f0h,02ah,064h,01eh,00ch,016h,000h,000h	; 7adb  N.5:P80p.*d.....
	defb 068h,0fah,0b4h,07ch,02ch,006h,00ah,004h,016h,00eh,09ch,06ah,0f0h,050h,000h,040h	; 7aeb  h..|,......j.P.@
	defb 020h,060h,030h,002h,001h,027h,007h,00dh,007h,009h,002h,000h,014h,010h,000h,002h	; 7afb   `0..'..........
	defb 080h,008h,018h,0c0h,0f6h,0e0h,064h,098h,0e8h,060h,098h,028h,000h,001h,005h,000h	; 7b0b  ......d..`.(....
	defb 088h,004h,001h,003h,007h,006h,009h,000h,001h,009h,000h,086h,020h,0c0h,048h,0a0h	; 7b1b  ............ .H.
	defb 080h,0a0h,005h,000h,000h	; 7b2b

; ----------------------------------------------------------------------
; DATOS copia_7b30: otra terna con su 0xFF, que p00:583E pasa en IX a p00:59BF
;   despues de escribir el rle de 0x7B34
;   0x7b30..0x7b34  (4 bytes)
DATA_copia_7b30:
	defb 034h,020h,005h,0ffh	; 7b30

; ----------------------------------------------------------------------
; DATOS rle_7B34: rle a la VRAM (0x5C46); lo leen p00:583B (126 bytes)
;   0x7b34..0x7bb2  (126 bytes)
DATA_rle_7B34:
	defb 0a0h,000h,0bfh,0dfh,05eh,0a9h,0d7h,0ebh,070h,00ch,00dh,029h,016h,02bh,056h,009h	; 7b34  ....^...p..).+V.
	defb 017h,000h,000h,0c0h,002h,0f0h,052h,0f3h,0f2h,001h,09bh,0c9h,062h,040h,0a2h,000h	; 7b44  ......R.....b@..
	defb 0b0h,003h,000h,08dh,00fh,03eh,0bdh,0dah,054h,0a1h,058h,024h,00dh,029h,094h,0bah	; 7b54  .....>..T.X$.)..
	defb 0d7h,004h,000h,08ch,0c0h,000h,0f8h,0a8h,0f8h,07ah,002h,085h,0dah,0eah,044h,0a9h	; 7b64  .........z....D.
	defb 006h,000h,08ah,00fh,03dh,0bbh,0d4h,054h,0a8h,058h,022h,08ah,0b5h,007h,000h,089h	; 7b74  ....=..T.X".....
	defb 0c0h,020h,000h,070h,0ech,07ch,03ch,0a3h,0cah,009h,000h,087h,00fh,03eh,0bdh,0dah	; 7b84  . .p.|<......>..
	defb 062h,088h,035h,00ah,000h,086h,0e4h,080h,035h,07ch,01dh,093h,00bh,000h,085h,005h	; 7b94  b.5.....5|......
	defb 000h,031h,045h,02eh,00ah,000h,086h,080h,000h,040h,0d4h,060h,09ch,000h	; 7ba4  .1E......@.`..

; ----------------------------------------------------------------------
; DATOS rle_7BB2: rle a la VRAM (0x5C46); se solapan 2 bloques (0x7BB2-0x7C74,
;   0x7C72-0x7D48); lo leen p00:5953, p00:598D (406 bytes)
;   0x7bb2..0x7d48  (406 bytes)
DATA_rle_7BB2:
	defb 0a0h,07fh,0c0h,09fh,0a0h,0a6h,0aeh,0aah,0a6h,0adh,0afh,0a2h,0ach,0a0h,09fh,0c0h	; 7bb2  ................
	defb 07fh,0feh,003h,0f9h,005h,075h,085h,0e5h,085h,0e5h,095h,075h,0a5h,005h,0f9h,003h	; 7bc2  .....u.....u....
	defb 0feh,009h,000h,087h,041h,023h,017h,01bh,03fh,01fh,02fh,009h,000h,087h,0c1h,0f2h	; 7bd2  ....A#..?./.....
	defb 0f5h,0eah,0f4h,0eeh,0feh,004h,000h,089h,011h,00ah,006h,007h,02eh,007h,005h,00bh	; 7be2  ................
	defb 012h,003h,000h,002h,07fh,096h,02fh,05bh,007h,073h,0f8h,074h,0fdh,0fch,0f9h,0b2h	; 7bf2  ....../[.s.t....
	defb 000h,001h,002h,000h,0ffh,0feh,0f7h,0d9h,0e8h,086h,07eh,0fdh,003h,0ffh,085h,0dfh	; 7c02  ..........~.....
	defb 0bfh,07fh,03fh,00ch,003h,000h,08ch,050h,022h,024h,0e8h,0d0h,0e4h,0cch,0beh,0feh	; 7c12  ..?....P"$......
	defb 0fch,0beh,06ch,00bh,000h,086h,020h,011h,00bh,00dh,006h,00fh,00bh,000h,085h,0e0h	; 7c22  ..l... .........
	defb 0f2h,0f4h,0e8h,0f4h,003h,000h,097h,042h,020h,013h,02fh,013h,07fh,03fh,00fh,01fh	; 7c32  .......B ./..?..
	defb 00eh,031h,046h,000h,02fh,017h,0cfh,002h,021h,0deh,0efh,0efh,0feh,0dfh,003h,0ffh	; 7c42  .1F./...!.......
	defb 092h,0fbh,098h,000h,0fch,0f8h,0f4h,0e8h,0c0h,010h,032h,047h,087h,093h,0bfh,037h	; 7c52  ..........2G...7
	defb 08fh,03fh,00bh,006h,000h,08bh,010h,020h,080h,0a8h,070h,0f0h,0e0h,0f0h,040h,090h	; 7c62  .?..... ..p...@.
	defb 000h,000h,048h,07dh,050h,07dh,055h,07dh,0fbh,07eh,05dh,07dh,065h,07dh,06ah,07dh	; 7c72  ..H}P}U}.~]}e}j}
	defb 06fh,07dh,077h,07dh,07ch,07dh,084h,07dh,08ch,07dh,094h,07dh,09ch,07dh,0a4h,07dh	; 7c82  o}w}|}.}.}.}.}.}
	defb 0ach,07dh,0b1h,07dh,0b9h,07dh,0c1h,07dh,0c9h,07dh,0d1h,07dh,0d9h,07dh,0e1h,07dh	; 7c92  .}.}.}.}.}.}.}.}
	defb 0e9h,07dh,0f1h,07dh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0f6h,07dh	; 7ca2  .}.}.~.~.~.~.~.}
	defb 0feh,07dh,003h,07eh,00bh,07eh,010h,07eh,015h,07eh,01dh,07eh,025h,07eh,02ah,07eh	; 7cb2  .}.~.~.~.~.~%~*~
	defb 02fh,07eh,037h,07eh,03ch,07eh,041h,07eh,049h,07eh,051h,07eh,059h,07eh,05eh,07eh	; 7cc2  /~7~<~A~I~Q~Y~^~
	defb 063h,07eh,06eh,07eh,073h,07eh,0fbh,07eh,0c7h,07eh,077h,07dh,07bh,07eh,0fbh,07eh	; 7cd2  c~n~s~.~.~w}{~.~
	defb 080h,07eh,085h,07eh,08ah,07eh,0fbh,07eh,08fh,07eh,0fbh,07eh,097h,07eh,0fbh,07eh	; 7ce2  .~.~.~.~.~.~.~.~
	defb 09fh,07eh,0fbh,07eh,0a7h,07eh,0b2h,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh	; 7cf2  .~.~.~.~.~.~.~.~
	defb 0fbh,07eh,09ch,07dh,0fbh,07eh,0fbh,07eh,0bah,07eh,0fbh,07eh,0cch,07eh,0bfh,07eh	; 7d02  .~.}.~.~.~.~.~.~
	defb 0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0d4h,07eh,0d4h,07eh,0fbh,07eh,0fbh,07eh	; 7d12  .~.~.~.~.~.~.~.~
	defb 0dch,07eh,0f8h,07eh,0e6h,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh	; 7d22  .~.~.~.~.~.~.~.~
	defb 0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0fbh,07eh,0f0h,07eh,0fbh,07eh,0e1h,07eh	; 7d32  .~.~.~.~.~.~.~.~
	defb 0ebh,07eh,0fbh,07eh,0fbh,07eh	; 7d42

; ----------------------------------------------------------------------
; DATOS pieza_01: la pieza de decoracion 0x01: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d48..0x7d50  (8 bytes)
DATA_pieza_01:
	defb 0a0h,0fbh,080h,000h,0b4h,0a0h,005h,0ffh	; 7d48  ........

; ----------------------------------------------------------------------
; DATOS pieza_02: la pieza de decoracion 0x02: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7d50..0x7d55  (5 bytes)
DATA_pieza_02:
	defb 0a0h,0c8h,080h,000h,0ffh	; 7d50

; ----------------------------------------------------------------------
; DATOS pieza_03: la pieza de decoracion 0x03: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d55..0x7d5d  (8 bytes)
DATA_pieza_03:
	defb 0c4h,039h,088h,000h,0d0h,0cch,001h,0ffh	; 7d55  .9......

; ----------------------------------------------------------------------
; DATOS pieza_05: la pieza de decoracion 0x05: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d5d..0x7d65  (8 bytes)
DATA_pieza_05:
	defb 0a0h,0fbh,081h,000h,0b0h,0a0h,004h,0ffh	; 7d5d  ........

; ----------------------------------------------------------------------
; DATOS pieza_06: la pieza de decoracion 0x06: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7d65..0x7d6a  (5 bytes)
DATA_pieza_06:
	defb 0a0h,0edh,08dh,000h,0ffh	; 7d65

; ----------------------------------------------------------------------
; DATOS pieza_07: la pieza de decoracion 0x07: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7d6a..0x7d6f  (5 bytes)
DATA_pieza_07:
	defb 0a0h,0d4h,085h,000h,0ffh	; 7d6a

; ----------------------------------------------------------------------
; DATOS pieza_08: la pieza de decoracion 0x08: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d6f..0x7d77  (8 bytes)
DATA_pieza_08:
	defb 0c4h,08eh,081h,0c8h,0d0h,088h,000h,0ffh	; 7d6f  ........

; ----------------------------------------------------------------------
; DATOS pieza_09: la pieza de decoracion 0x09: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7d77..0x7d7c  (5 bytes)
DATA_pieza_09:
	defb 0c4h,010h,080h,000h,0ffh	; 7d77

; ----------------------------------------------------------------------
; DATOS pieza_0A: la pieza de decoracion 0x0A: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d7c..0x7d84  (8 bytes)
DATA_pieza_0A:
	defb 0a0h,028h,084h,000h,0c0h,0b0h,004h,0ffh	; 7d7c  .(......

; ----------------------------------------------------------------------
; DATOS pieza_0B: la pieza de decoracion 0x0B: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d84..0x7d8c  (8 bytes)
DATA_pieza_0B:
	defb 0a0h,026h,08dh,000h,0a8h,0a0h,002h,0ffh	; 7d84  .&......

; ----------------------------------------------------------------------
; DATOS pieza_0C: la pieza de decoracion 0x0C: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d8c..0x7d94  (8 bytes)
DATA_pieza_0C:
	defb 0a0h,04bh,089h,000h,0bch,0b4h,002h,0ffh	; 7d8c  .K......

; ----------------------------------------------------------------------
; DATOS pieza_0D: la pieza de decoracion 0x0D: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d94..0x7d9c  (8 bytes)
DATA_pieza_0D:
	defb 0c4h,08eh,081h,000h,0d0h,0c8h,002h,0ffh	; 7d94  ........

; ----------------------------------------------------------------------
; DATOS pieza_0E: la pieza de decoracion 0x0E: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7d9c..0x7da4  (8 bytes)
DATA_pieza_0E:
	defb 0a0h,014h,085h,000h,0bch,0b4h,002h,0ffh	; 7d9c  ........

; ----------------------------------------------------------------------
; DATOS pieza_0F: la pieza de decoracion 0x0F: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7da4..0x7dac  (8 bytes)
DATA_pieza_0F:
	defb 0a0h,0fdh,07eh,000h,0c0h,0a0h,008h,0ffh	; 7da4  ..~.....

; ----------------------------------------------------------------------
; DATOS pieza_10: la pieza de decoracion 0x10: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7dac..0x7db1  (5 bytes)
DATA_pieza_10:
	defb 0a0h,07bh,088h,000h,0ffh	; 7dac

; ----------------------------------------------------------------------
; DATOS pieza_11: la pieza de decoracion 0x11: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7db1..0x7db9  (8 bytes)
DATA_pieza_11:
	defb 0a0h,036h,083h,000h,0b4h,0a4h,004h,0ffh	; 7db1  .6......

; ----------------------------------------------------------------------
; DATOS pieza_12: la pieza de decoracion 0x12: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7db9..0x7dc1  (8 bytes)
DATA_pieza_12:
	defb 0a0h,0ffh,085h,000h,0b8h,0b0h,002h,0ffh	; 7db9  ........

; ----------------------------------------------------------------------
; DATOS pieza_13: la pieza de decoracion 0x13: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7dc1..0x7dc9  (8 bytes)
DATA_pieza_13:
	defb 0a0h,0cah,08eh,000h,0c0h,0b8h,002h,0ffh	; 7dc1  ........

; ----------------------------------------------------------------------
; DATOS pieza_14: la pieza de decoracion 0x14: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7dc9..0x7dd1  (8 bytes)
DATA_pieza_14:
	defb 0a0h,0b7h,083h,000h,0b4h,0ach,002h,0ffh	; 7dc9  ........

; ----------------------------------------------------------------------
; DATOS pieza_15: la pieza de decoracion 0x15: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7dd1..0x7dd9  (8 bytes)
DATA_pieza_15:
	defb 0a0h,0b3h,092h,000h,0b4h,0a4h,004h,0ffh	; 7dd1  ........

; ----------------------------------------------------------------------
; DATOS pieza_16: la pieza de decoracion 0x16: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7dd9..0x7de1  (8 bytes)
DATA_pieza_16:
	defb 0a0h,06eh,094h,000h,0c4h,0a4h,008h,0ffh	; 7dd9  .n......

; ----------------------------------------------------------------------
; DATOS pieza_17: la pieza de decoracion 0x17: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7de1..0x7de9  (8 bytes)
DATA_pieza_17:
	defb 0a0h,01dh,090h,000h,0d0h,0c8h,002h,0ffh	; 7de1  ........

; ----------------------------------------------------------------------
; DATOS pieza_18: la pieza de decoracion 0x18: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7de9..0x7df1  (8 bytes)
DATA_pieza_18:
	defb 0a0h,098h,07fh,000h,0b0h,0a8h,002h,0ffh	; 7de9  ........

; ----------------------------------------------------------------------
; DATOS pieza_19: la pieza de decoracion 0x19: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7df1..0x7df6  (5 bytes)
DATA_pieza_19:
	defb 0a0h,04fh,093h,000h,0ffh	; 7df1

; ----------------------------------------------------------------------
; DATOS pieza_1F: la pieza de decoracion 0x1F: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7df6..0x7dfe  (8 bytes)
DATA_pieza_1F:
	defb 0a0h,0c4h,08ch,000h,0ach,0a0h,003h,0ffh	; 7df6  ........

; ----------------------------------------------------------------------
; DATOS pieza_20: la pieza de decoracion 0x20: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7dfe..0x7e03  (5 bytes)
DATA_pieza_20:
	defb 0a0h,061h,087h,000h,0ffh	; 7dfe

; ----------------------------------------------------------------------
; DATOS pieza_21: la pieza de decoracion 0x21: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e03..0x7e0b  (8 bytes)
DATA_pieza_21:
	defb 0a0h,006h,088h,000h,0a8h,0a0h,002h,0ffh	; 7e03  ........

; ----------------------------------------------------------------------
; DATOS pieza_22: la pieza de decoracion 0x22: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e0b..0x7e10  (5 bytes)
DATA_pieza_22:
	defb 0c4h,0d5h,08fh,000h,0ffh	; 7e0b

; ----------------------------------------------------------------------
; DATOS pieza_23: la pieza de decoracion 0x23: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e10..0x7e15  (5 bytes)
DATA_pieza_23:
	defb 0a0h,030h,087h,000h,0ffh	; 7e10

; ----------------------------------------------------------------------
; DATOS pieza_24: la pieza de decoracion 0x24: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e15..0x7e1d  (8 bytes)
DATA_pieza_24:
	defb 0a0h,0fah,089h,000h,0ach,0a0h,003h,0ffh	; 7e15  ........

; ----------------------------------------------------------------------
; DATOS pieza_25: la pieza de decoracion 0x25: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e1d..0x7e25  (8 bytes)
DATA_pieza_25:
	defb 0a0h,052h,08dh,000h,0b8h,0ach,003h,0ffh	; 7e1d  .R......

; ----------------------------------------------------------------------
; DATOS pieza_26: la pieza de decoracion 0x26: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e25..0x7e2a  (5 bytes)
DATA_pieza_26:
	defb 0c4h,05eh,08bh,000h,0ffh	; 7e25

; ----------------------------------------------------------------------
; DATOS pieza_27: la pieza de decoracion 0x27: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e2a..0x7e2f  (5 bytes)
DATA_pieza_27:
	defb 0c4h,05bh,08ah,000h,0ffh	; 7e2a

; ----------------------------------------------------------------------
; DATOS pieza_28: la pieza de decoracion 0x28: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e2f..0x7e37  (8 bytes)
DATA_pieza_28:
	defb 0c4h,078h,087h,000h,0d8h,0cch,003h,0ffh	; 7e2f  .x......

; ----------------------------------------------------------------------
; DATOS pieza_29: la pieza de decoracion 0x29: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e37..0x7e3c  (5 bytes)
DATA_pieza_29:
	defb 0c4h,093h,080h,000h,0ffh	; 7e37

; ----------------------------------------------------------------------
; DATOS pieza_2A: la pieza de decoracion 0x2A: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e3c..0x7e41  (5 bytes)
DATA_pieza_2A:
	defb 0c4h,02dh,093h,000h,0ffh	; 7e3c

; ----------------------------------------------------------------------
; DATOS pieza_2B: la pieza de decoracion 0x2B: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e41..0x7e49  (8 bytes)
DATA_pieza_2B:
	defb 0c4h,0aah,08ah,000h,0cch,0c4h,002h,0ffh	; 7e41  ........

; ----------------------------------------------------------------------
; DATOS pieza_2C: la pieza de decoracion 0x2C: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e49..0x7e51  (8 bytes)
DATA_pieza_2C:
	defb 0a0h,056h,08ch,000h,0b0h,0a0h,004h,0ffh	; 7e49  .V......

; ----------------------------------------------------------------------
; DATOS pieza_2D: la pieza de decoracion 0x2D: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e51..0x7e59  (8 bytes)
DATA_pieza_2D:
	defb 0a0h,082h,08fh,000h,0ach,0a0h,003h,0ffh	; 7e51  ........

; ----------------------------------------------------------------------
; DATOS pieza_2E: la pieza de decoracion 0x2E: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e59..0x7e5e  (5 bytes)
DATA_pieza_2E:
	defb 0c4h,0a9h,086h,000h,0ffh	; 7e59

; ----------------------------------------------------------------------
; DATOS pieza_2F: la pieza de decoracion 0x2F: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e5e..0x7e63  (5 bytes)
DATA_pieza_2F:
	defb 0c4h,0b2h,085h,000h,0ffh	; 7e5e

; ----------------------------------------------------------------------
; DATOS pieza_30: la pieza de decoracion 0x30: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (11 bytes)
;   0x7e63..0x7e6e  (11 bytes)
DATA_pieza_30:
	defb 0c0h,08eh,081h,0c4h,045h,092h,000h,0d4h,0c4h,004h,0ffh	; 7e63  ....E......

; ----------------------------------------------------------------------
; DATOS pieza_31: la pieza de decoracion 0x31: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e6e..0x7e73  (5 bytes)
DATA_pieza_31:
	defb 0c4h,06ah,082h,000h,0ffh	; 7e6e

; ----------------------------------------------------------------------
; DATOS pieza_32: la pieza de decoracion 0x32: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e73..0x7e7b  (8 bytes)
DATA_pieza_32:
	defb 0c4h,018h,08bh,000h,0c8h,0c4h,001h,0ffh	; 7e73  ........

; ----------------------------------------------------------------------
; DATOS pieza_36: la pieza de decoracion 0x36: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e7b..0x7e80  (5 bytes)
DATA_pieza_36:
	defb 0c4h,071h,095h,000h,0ffh	; 7e7b

; ----------------------------------------------------------------------
; DATOS pieza_38: la pieza de decoracion 0x38: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e80..0x7e85  (5 bytes)
DATA_pieza_38:
	defb 0c4h,0e3h,07fh,000h,0ffh	; 7e80

; ----------------------------------------------------------------------
; DATOS pieza_39: la pieza de decoracion 0x39: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e85..0x7e8a  (5 bytes)
DATA_pieza_39:
	defb 0c4h,0c2h,08bh,000h,0ffh	; 7e85

; ----------------------------------------------------------------------
; DATOS pieza_3A: la pieza de decoracion 0x3A: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7e8a..0x7e8f  (5 bytes)
DATA_pieza_3A:
	defb 0c4h,0a7h,08bh,000h,0ffh	; 7e8a

; ----------------------------------------------------------------------
; DATOS pieza_3C: la pieza de decoracion 0x3C: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e8f..0x7e97  (8 bytes)
DATA_pieza_3C:
	defb 0c4h,0ech,08ah,000h,0cch,0c8h,001h,0ffh	; 7e8f  ........

; ----------------------------------------------------------------------
; DATOS pieza_3E: la pieza de decoracion 0x3E: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e97..0x7e9f  (8 bytes)
DATA_pieza_3E:
	defb 0c4h,025h,08bh,000h,0cch,0c4h,002h,0ffh	; 7e97  .%......

; ----------------------------------------------------------------------
; DATOS pieza_40: la pieza de decoracion 0x40: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7e9f..0x7ea7  (8 bytes)
DATA_pieza_40:
	defb 0a0h,009h,096h,000h,0c0h,0b4h,003h,0ffh	; 7e9f  ........

; ----------------------------------------------------------------------
; DATOS pieza_42: la pieza de decoracion 0x42: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (11 bytes)
;   0x7ea7..0x7eb2  (11 bytes)
DATA_pieza_42:
	defb 0c4h,0b1h,095h,0d0h,0d9h,095h,000h,0cch,0c8h,001h,0ffh	; 7ea7  ...........

; ----------------------------------------------------------------------
; DATOS pieza_43: la pieza de decoracion 0x43: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7eb2..0x7eba  (8 bytes)
DATA_pieza_43:
	defb 0c4h,0e3h,08bh,000h,0d8h,0d0h,002h,0ffh	; 7eb2  ........

; ----------------------------------------------------------------------
; DATOS pieza_4C: la pieza de decoracion 0x4C: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7eba..0x7ebf  (5 bytes)
DATA_pieza_4C:
	defb 0a0h,044h,091h,000h,0ffh	; 7eba

; ----------------------------------------------------------------------
; DATOS pieza_4F: la pieza de decoracion 0x4F: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); NINGUNA
;   SALA LA PIDE; lo leen p00:59A6 (8 bytes)
;   0x7ebf..0x7ec7  (8 bytes)
DATA_pieza_4F:
	defb 0a0h,0b5h,096h,000h,0b8h,0ach,003h,0ffh	; 7ebf  ........

; ----------------------------------------------------------------------
; DATOS pieza_34: la pieza de decoracion 0x34: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7ec7..0x7ecc  (5 bytes)
DATA_pieza_34:
	defb 0c4h,0efh,081h,000h,0ffh	; 7ec7

; ----------------------------------------------------------------------
; DATOS pieza_4E: la pieza de decoracion 0x4E: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7ecc..0x7ed4  (8 bytes)
DATA_pieza_4E:
	defb 0a0h,0b5h,096h,000h,0b8h,0ach,003h,0ffh	; 7ecc  ........

; ----------------------------------------------------------------------
; DATOS pieza_54: la pieza de decoracion 0x54: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7ed4..0x7edc  (8 bytes)
DATA_pieza_54:
	defb 0a0h,0cdh,0b5h,000h,0b8h,0b0h,002h,0ffh	; 7ed4  ........

; ----------------------------------------------------------------------
; DATOS pieza_58: la pieza de decoracion 0x58: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7edc..0x7ee1  (5 bytes)
DATA_pieza_58:
	defb 0a0h,035h,0b6h,000h,0ffh	; 7edc

; ----------------------------------------------------------------------
; DATOS pieza_67: la pieza de decoracion 0x67: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7ee1..0x7ee6  (5 bytes)
DATA_pieza_67:
	defb 0a0h,06eh,0b6h,000h,0ffh	; 7ee1

; ----------------------------------------------------------------------
; DATOS pieza_5A: la pieza de decoracion 0x5A: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7ee6..0x7eeb  (5 bytes)
DATA_pieza_5A:
	defb 0a0h,090h,0b6h,000h,0ffh	; 7ee6

; ----------------------------------------------------------------------
; DATOS pieza_68: la pieza de decoracion 0x68: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (5 bytes)
;   0x7eeb..0x7ef0  (5 bytes)
DATA_pieza_68:
	defb 0a0h,0adh,0b6h,000h,0ffh	; 7eeb

; ----------------------------------------------------------------------
; DATOS pieza_65: la pieza de decoracion 0x65: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); lo leen
;   p00:59A6 (8 bytes)
;   0x7ef0..0x7ef8  (8 bytes)
DATA_pieza_65:
	defb 0a0h,0e1h,0b6h,000h,0b4h,0a8h,003h,0ffh	; 7ef0  ........

; ----------------------------------------------------------------------
; DATOS pieza_59: la pieza de decoracion 0x59: [caracter][rle] acabadas en 0
;   (p00:59A6) y [desde][hasta][cuantos] acabadas en 0xFF (p00:59BF); se
;   solapan 2 bloques (0x7EF8-0x7EFD, 0x7EFB-0x7EFD); lo leen p00:59A6 (5
;   bytes)
;   0x7ef8..0x7efd  (5 bytes)
DATA_pieza_59:
	defb 0a0h,0cah,0b6h,000h,0ffh	; 7ef8

; ----------------------------------------------------------------------
; DATOS rle_7EFD: rle a la VRAM (0x5C46) de la pieza de decoracion 0x0F; lo
;   leen p00:59B9 (155 bytes)
;   0x7efd..0x7f98  (155 bytes)
DATA_rle_7EFD:
	defb 00ch,000h,084h,060h,0f0h,0f0h,060h,01ch,000h,084h,060h,090h,010h,060h,018h,000h	; 7efd  ...`..`...`..`..
	defb 088h,03ch,07eh,0dfh,0fdh,0ddh,09fh,06eh,03ch,018h,000h,088h,03ch,05eh,0ffh,0a5h	; 7f0d  .<~....n<...<^..
	defb 003h,003h,056h,07ch,014h,000h,08ch,00fh,03fh,07fh,067h,0efh,0ffh,0efh,08fh,02fh	; 7f1d  ..V|....?.g..../
	defb 077h,03fh,00fh,005h,000h,08ah,0c0h,0e0h,0e0h,0b0h,050h,0d0h,050h,0a0h,0e0h,0c0h	; 7f2d  w?........P.P...
	defb 005h,000h,085h,00fh,037h,06fh,057h,0a9h,003h,000h,084h,001h,015h,06bh,03fh,005h	; 7f3d  ....7oW......k?.
	defb 000h,084h,0c0h,0e0h,0e0h,0b0h,003h,0d0h,0aah,0a0h,0e0h,0c0h,000h,007h,01fh,03fh	; 7f4d  ...............?
	defb 07bh,079h,0fbh,0f7h,0ffh,0f7h,087h,037h,077h,07bh,03dh,01fh,007h,0e0h,0f8h,0fch	; 7f5d  {y.....7w{=.....
	defb 0feh,0feh,0f3h,0edh,0f9h,0f5h,0f5h,0fdh,0eah,0f6h,0fch,0f8h,0e0h,00fh,03ch,07bh	; 7f6d  ..............<{
	defb 07fh,0d5h,0aah,006h,000h,094h,015h,06ah,03fh,00fh,0e0h,0f8h,0fch,0feh,0deh,063h	; 7f7d  .......j?......c
	defb 0bdh,039h,015h,015h,01dh,03ah,076h,0fch,0f8h,0e0h,000h	; 7f8d  .9...:v....

; ----------------------------------------------------------------------
; DATOS rle_7F98: rle a la VRAM (0x5C46) de la pieza de decoracion 0x18; lo
;   leen p00:59B9 (75 bytes)
;   0x7f98..0x7fe3  (75 bytes)
DATA_rle_7F98:
	defb 00ch,000h,084h,07fh,0ffh,0ffh,07fh,00ch,000h,08bh,0feh,0ffh,0ffh,0feh,007h,01fh	; 7f98  ................
	defb 07fh,07fh,0f8h,0e0h,0c0h,009h,000h,087h,0e0h,0f8h,0feh,0feh,01fh,007h,003h,014h	; 7fa8  ................
	defb 000h,085h,003h,07fh,0ffh,0ffh,078h,005h,000h,089h,00ch,01eh,01eh,03ch,07ch,0f8h	; 7fb8  ......x......<|.
	defb 0f0h,0e0h,0c0h,008h,000h,086h,001h,007h,01fh,03fh,03eh,018h,005h,000h,089h,01eh	; 7fc8  .........?>.....
	defb 03fh,07eh,078h,0f8h,0f0h,0e0h,0c0h,080h,006h,000h,000h	; 7fd8  ?~x........

; ----------------------------------------------------------------------
; DATOS rle_7FE3: rle a la VRAM (0x5C46) de la pieza de decoracion 0x38; lo
;   leen p00:59B9 (29 bytes)
;   0x7fe3..0x8000  (29 bytes)
DATA_rle_7FE3:
	defb 086h,03fh,07fh,067h,03dh,007h,003h,00ah,000h,086h,0fch,0feh,0feh,0fch,0e0h,0c0h	; 7fe3  .?.g=...........
	defb 00ah,000h,085h,003h,00fh,00fh,01fh,01fh,003h,017h,083h,00bh,00fh	; 7ff3  .............
