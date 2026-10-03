; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 15 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS mosaico_13_cola: el mosaico 13: 10 x 6 caracteres por filas (p01:6D87;
;   el 0 no se pinta) (sigue del banco anterior, 0x9FFC); lo leen p01:6D87 (56
;   bytes)
;   0xa000..0xa038  (56 bytes)
DATA_mosaico_13_cola:
	defb 05bh,068h,067h,061h,000h,000h,088h,089h,08ah,05ch	; a000  [hga.....\
	defb 098h,099h,08dh,000h,000h,000h,000h,08bh,08ch,076h	; a00a  .........v
	defb 074h,08fh,0c1h,06ch,000h,0c6h,05dh,092h,05eh,077h	; a014  t..l..].^w
	defb 078h,0c2h,0c3h,0c4h,000h,0beh,05fh,05ah,093h,07ah	; a01e  x....._Z.z
	defb 07bh,06dh,06eh,0c5h,069h,0bdh,094h,0bfh,08eh,097h	; a028  {mn.i.....
	defb 06fh,084h,085h,075h,0bbh,0bch	; a032

; ----------------------------------------------------------------------
; DATOS mosaico_14: el mosaico 14: 10 x 7 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (70 bytes)
;   0xa038..0xa07e  (70 bytes)
DATA_mosaico_14:
	defb 088h,089h,08ah,060h,000h,000h,000h,000h,000h,000h	; a038  ...`......
	defb 000h,08bh,08ch,0c0h,070h,068h,067h,061h,000h,000h	; a042  ....phga..
	defb 05dh,092h,05eh,07dh,098h,099h,08dh,000h,000h,000h	; a04c  ].^}......
	defb 05fh,05ah,093h,07eh,074h,08fh,0c1h,06ch,000h,0c6h	; a056  _Z.~t..l..
	defb 094h,0bfh,0c9h,07ch,078h,0c2h,0c3h,0c4h,000h,0beh	; a060  ...|x.....
	defb 000h,000h,000h,079h,07bh,06dh,06eh,0c5h,069h,0bdh	; a06a  ...y{mn.i.
	defb 000h,0bah,0c8h,097h,06fh,084h,085h,075h,0bbh,0bch	; a074  ....o..u..

; ----------------------------------------------------------------------
; DATOS mosaico_15: el mosaico 15: 10 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (60 bytes)
;   0xa07e..0xa0ba  (60 bytes)
DATA_mosaico_15:
	defb 000h,000h,000h,000h,071h,0d2h,086h,06ah,000h,000h	; a07e  ....q..j..
	defb 088h,089h,08ah,05ch,098h,090h,095h,06bh,000h,000h	; a088  ...\...k..
	defb 000h,08bh,08ch,076h,074h,08fh,0c1h,06ch,000h,0c6h	; a092  ...vt..l..
	defb 05dh,092h,05eh,077h,078h,0c2h,0c3h,0c4h,000h,0beh	; a09c  ].^wx.....
	defb 05fh,05ah,093h,07ah,07bh,06dh,06eh,0c5h,069h,0bdh	; a0a6  _Z.z{mn.i.
	defb 094h,0bfh,08eh,097h,06fh,084h,085h,075h,0bbh,0bch	; a0b0  ....o..u..

; ----------------------------------------------------------------------
; DATOS mosaico_16: el mosaico 16: 6 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (36 bytes)
;   0xa0ba..0xa0de  (36 bytes)
DATA_mosaico_16:
	defb 000h,000h,000h,000h,000h,000h	; a0ba
	defb 000h,000h,000h,000h,000h,000h	; a0c0
	defb 000h,064h,063h,088h,089h,000h	; a0c6
	defb 066h,06fh,072h,097h,094h,08bh	; a0cc
	defb 067h,06dh,06eh,093h,092h,08ch	; a0d2
	defb 07ch,078h,079h,0beh,0bdh,0c1h	; a0d8

; ----------------------------------------------------------------------
; DATOS mosaico_17: el mosaico 17: 6 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (36 bytes)
;   0xa0de..0xa102  (36 bytes)
DATA_mosaico_17:
	defb 000h,000h,000h,000h,000h,000h	; a0de
	defb 000h,061h,062h,087h,086h,000h	; a0e4
	defb 000h,06bh,077h,0bch,090h,000h	; a0ea
	defb 000h,068h,072h,097h,08dh,000h	; a0f0
	defb 06ah,070h,06eh,093h,095h,08fh	; a0f6
	defb 07ah,078h,079h,0beh,0bdh,0bfh	; a0fc

; ----------------------------------------------------------------------
; DATOS mosaico_18: el mosaico 18: 6 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (36 bytes)
;   0xa102..0xa126  (36 bytes)
DATA_mosaico_18:
	defb 000h,05ah,074h,099h,07fh,000h	; a102
	defb 05bh,05eh,07eh,0c3h,083h,080h	; a108
	defb 05dh,069h,075h,0bah,08eh,082h	; a10e
	defb 000h,065h,072h,097h,08ah,000h	; a114
	defb 000h,071h,06eh,093h,096h,000h	; a11a
	defb 000h,07bh,079h,0beh,0c0h,000h	; a120

; ----------------------------------------------------------------------
; DATOS mosaico_19: el mosaico 19: 6 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (36 bytes)
;   0xa126..0xa14a  (36 bytes)
DATA_mosaico_19:
	defb 000h,000h,073h,098h,000h,000h	; a126
	defb 05fh,060h,07dh,0c2h,085h,084h	; a12c
	defb 05ch,06ch,076h,0bbh,091h,081h	; a132
	defb 000h,065h,072h,097h,08ah,000h	; a138
	defb 000h,071h,06eh,093h,096h,000h	; a13e
	defb 000h,07bh,079h,0beh,0c0h,000h	; a144

; ----------------------------------------------------------------------
; DATOS mosaico_23: el mosaico 23: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); se solapan 4 bloques (0xA14A-0xA14E, 0xA14A-0xA192,
;   0xA14E-0xA18E, 0xA18E-0xA1CE); lo leen p01:6D87 (132 bytes)
;   0xa14a..0xa1ce  (132 bytes)
DATA_mosaico_23:
	defb 07ah,07bh	; a14a
	defb 07ch,07dh	; a14c
	defb 000h,000h	; a14e
	defb 000h,000h	; a150
	defb 000h,000h	; a152
	defb 000h,000h	; a154
	defb 000h,000h	; a156
	defb 000h,000h	; a158
	defb 000h,000h	; a15a
	defb 000h,000h	; a15c
	defb 000h,000h	; a15e
	defb 07bh,060h	; a160
	defb 05ah,0c7h	; a162
	defb 000h,000h	; a164
	defb 065h,081h	; a166
	defb 086h,062h	; a168
	defb 05ch,0d2h	; a16a
	defb 0cdh,091h	; a16c
	defb 07ch,07dh	; a16e
	defb 082h,063h	; a170
	defb 05dh,0ceh	; a172
	defb 0c9h,0c8h	; a174
	defb 000h,066h	; a176
	defb 077h,078h	; a178
	defb 0c4h,0c3h	; a17a
	defb 092h,000h	; a17c
	defb 000h,000h	; a17e
	defb 000h,000h	; a180
	defb 000h,000h	; a182
	defb 000h,000h	; a184
	defb 000h,000h	; a186
	defb 000h,000h	; a188
	defb 000h,000h	; a18a
	defb 000h,000h	; a18c
	defb 000h,000h	; a18e
	defb 07bh,060h	; a190
	defb 05ah,0c7h	; a192
	defb 000h,000h	; a194
	defb 000h,06eh	; a196
	defb 088h,062h	; a198
	defb 05ch,0d4h	; a19a
	defb 0bah,000h	; a19c
	defb 000h,067h	; a19e
	defb 085h,06dh	; a1a0
	defb 099h,0d1h	; a1a2
	defb 093h,000h	; a1a4
	defb 000h,068h	; a1a6
	defb 087h,0dch	; a1a8
	defb 0dch,0d3h	; a1aa
	defb 094h,000h	; a1ac
	defb 000h,069h	; a1ae
	defb 080h,08bh	; a1b0
	defb 0d7h,0cch	; a1b2
	defb 095h,000h	; a1b4
	defb 000h,06ah	; a1b6
	defb 072h,08dh	; a1b8
	defb 0d9h,0beh	; a1ba
	defb 096h,000h	; a1bc
	defb 000h,06bh	; a1be
	defb 073h,063h	; a1c0
	defb 05dh,0bfh	; a1c2
	defb 097h,000h	; a1c4
	defb 000h,000h	; a1c6
	defb 077h,078h	; a1c8
	defb 0c4h,0c3h	; a1ca
	defb 000h,000h	; a1cc

; ----------------------------------------------------------------------
; DATOS mosaico_26: el mosaico 26: 8 x 8 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (64 bytes)
;   0xa1ce..0xa20e  (64 bytes)
DATA_mosaico_26:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a1ce  ........
	defb 000h,000h,076h,060h,05ah,0c2h,000h,000h	; a1d6  ..v`Z...
	defb 000h,000h,074h,062h,05ch,0c0h,000h,000h	; a1de  ..tb\...
	defb 065h,081h,083h,06dh,099h,0cfh,0cdh,091h	; a1e6  e..m....
	defb 07ch,07dh,08ah,08ch,0d8h,0d6h,0c9h,0c8h	; a1ee  |}......
	defb 000h,066h,06fh,08eh,0dah,0bbh,092h,000h	; a1f6  .fo.....
	defb 000h,000h,077h,07ah,0c6h,0c3h,000h,000h	; a1fe  ..wz....
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a206  ........

; ----------------------------------------------------------------------
; DATOS mosaico_27: el mosaico 27: 8 x 8 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (64 bytes)
;   0xa20e..0xa24e  (64 bytes)
DATA_mosaico_27:
	defb 000h,000h,000h,000h,000h,000h,000h,000h	; a20e  ........
	defb 000h,000h,079h,061h,05eh,0c5h,000h,000h	; a216  ..ya^...
	defb 000h,06ch,075h,05fh,05bh,0c1h,098h,000h	; a21e  .lu_[...
	defb 000h,07fh,089h,0dch,0dch,0d5h,0cbh,000h	; a226  ........
	defb 000h,07eh,084h,08ch,0d8h,0d0h,0cah,000h	; a22e  .~......
	defb 000h,066h,071h,08fh,0dbh,0bdh,092h,000h	; a236  .fq.....
	defb 000h,000h,070h,08eh,0dah,0bch,000h,000h	; a23e  ..p.....
	defb 000h,000h,000h,064h,090h,000h,000h,000h	; a246  ...d....

; ----------------------------------------------------------------------
; DATOS mosaico_28: el mosaico 28: 10 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (40 bytes)
;   0xa24e..0xa276  (40 bytes)
DATA_mosaico_28:
	defb 000h,000h,087h,073h,088h,074h,070h,071h,07eh,089h	; a24e  ...s.tpq~.
	defb 080h,06ah,06bh,062h,063h,065h,06ch,066h,064h,000h	; a258  .jkbcelfd.
	defb 0beh,078h,0c7h,0c2h,0c5h,07ah,0c3h,098h,000h,000h	; a262  .x...z....
	defb 08bh,091h,096h,000h,000h,095h,07fh,08ch,000h,000h	; a26c  ..........

; ----------------------------------------------------------------------
; DATOS mosaico_29: el mosaico 29: 10 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (40 bytes)
;   0xa276..0xa29e  (40 bytes)
DATA_mosaico_29:
	defb 000h,000h,08ah,075h,076h,077h,070h,071h,000h,000h	; a276  ...uvwpq..
	defb 06fh,06ah,06bh,067h,068h,06dh,06ch,069h,06eh,000h	; a280  ojkghmlin.
	defb 0bfh,079h,0c7h,0c2h,0c6h,07bh,0c4h,092h,07ch,07dh	; a28a  .y...{..|}
	defb 097h,08dh,08fh,000h,094h,072h,090h,08eh,000h,000h	; a294  .....r....

; ----------------------------------------------------------------------
; DATOS mosaico_30: el mosaico 30: 2 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (8 bytes)
;   0xa29e..0xa2a6  (8 bytes)
DATA_mosaico_30:
	defb 05ah,05bh	; a29e
	defb 099h,0c0h	; a2a0
	defb 000h,000h	; a2a2
	defb 000h,000h	; a2a4

; ----------------------------------------------------------------------
; DATOS mosaico_31: el mosaico 31: 2 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (8 bytes)
;   0xa2a6..0xa2ae  (8 bytes)
DATA_mosaico_31:
	defb 000h,081h	; a2a6
	defb 0bdh,0c1h	; a2a8
	defb 000h,000h	; a2aa
	defb 000h,000h	; a2ac

; ----------------------------------------------------------------------
; DATOS mosaico_32: el mosaico 32: 2 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (8 bytes)
;   0xa2ae..0xa2b6  (8 bytes)
DATA_mosaico_32:
	defb 000h,083h	; a2ae
	defb 084h,05dh	; a2b0
	defb 060h,0bah	; a2b2
	defb 000h,000h	; a2b4

; ----------------------------------------------------------------------
; DATOS mosaico_33: el mosaico 33: 2 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (8 bytes)
;   0xa2b6..0xa2be  (8 bytes)
DATA_mosaico_33:
	defb 000h,082h	; a2b6
	defb 085h,05eh	; a2b8
	defb 086h,05fh	; a2ba
	defb 061h,000h	; a2bc

; ----------------------------------------------------------------------
; DATOS mosaico_34: el mosaico 34: 2 x 1 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (2 bytes)
;   0xa2be..0xa2c0  (2 bytes)
DATA_mosaico_34:
	defb 093h,0bbh	; a2be

; ----------------------------------------------------------------------
; DATOS mosaico_35: el mosaico 35: 2 x 1 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (2 bytes)
;   0xa2c0..0xa2c2  (2 bytes)
DATA_mosaico_35:
	defb 05ch,0bch	; a2c0

; ----------------------------------------------------------------------
; DATOS mosaico_36: el mosaico 36: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa2c2..0xa2d4  (18 bytes)
DATA_mosaico_36:
	defb 000h,05bh,073h,090h,078h,000h	; a2c2
	defb 05ch,05fh,071h,08eh,07ch,079h	; a2c8
	defb 06ch,06ah,06dh,08ah,087h,089h	; a2ce

; ----------------------------------------------------------------------
; DATOS mosaico_37: el mosaico 37: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa2d4..0xa2e6  (18 bytes)
DATA_mosaico_37:
	defb 063h,05eh,073h,090h,078h,000h	; a2d4
	defb 069h,064h,071h,08eh,07ch,079h	; a2da
	defb 068h,066h,06dh,08ah,087h,089h	; a2e0

; ----------------------------------------------------------------------
; DATOS mosaico_38: el mosaico 38: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa2e6..0xa2f8  (18 bytes)
DATA_mosaico_38:
	defb 000h,05bh,073h,090h,07bh,080h	; a2e6
	defb 05ch,05fh,071h,08eh,081h,086h	; a2ec
	defb 06ch,06ah,06dh,08ah,083h,085h	; a2f2

; ----------------------------------------------------------------------
; DATOS mosaico_39: el mosaico 39: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa2f8..0xa30a  (18 bytes)
DATA_mosaico_39:
	defb 000h,05dh,072h,08fh,07ah,000h	; a2f8
	defb 05ch,065h,06fh,08ch,082h,079h	; a2fe
	defb 06ch,06ah,06bh,088h,087h,089h	; a304

; ----------------------------------------------------------------------
; DATOS mosaico_40: el mosaico 40: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa30a..0xa31c  (18 bytes)
DATA_mosaico_40:
	defb 000h,05bh,074h,092h,078h,000h	; a30a
	defb 05ch,05fh,071h,08eh,07ch,079h	; a310
	defb 06ch,06ah,06dh,08ah,087h,089h	; a316

; ----------------------------------------------------------------------
; DATOS mosaico_41: el mosaico 41: 6 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (18 bytes)
;   0xa31c..0xa32e  (18 bytes)
DATA_mosaico_41:
	defb 000h,05bh,075h,091h,078h,000h	; a31c
	defb 05ch,05fh,071h,08eh,07ch,079h	; a322
	defb 06ch,06ah,06dh,08ah,087h,089h	; a328

; ----------------------------------------------------------------------
; DATOS mosaico_42: el mosaico 42: 4 x 4 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (16 bytes)
;   0xa32e..0xa33e  (16 bytes)
DATA_mosaico_42:
	defb 05ah,076h,093h,077h	; a32e
	defb 060h,070h,08dh,07dh	; a332
	defb 061h,06eh,08bh,07eh	; a336
	defb 062h,067h,084h,07fh	; a33a

; ----------------------------------------------------------------------
; DATOS mosaico_43: el mosaico 43: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa33e..0xa370  (50 bytes)
DATA_mosaico_43:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a33e  ..........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a348  ..........
	defb 000h,05ch,078h,079h,07ah,0d2h,0d1h,0d0h,094h,000h	; a352  .\xyz.....
	defb 065h,05ah,05ah,05ah,05ah,05ah,05ah,05ah,05ah,0bdh	; a35c  eZZZZZZZZ.
	defb 070h,08dh,08eh,08fh,090h,0e8h,0e7h,0e6h,0e5h,0c8h	; a366  p.........

; ----------------------------------------------------------------------
; DATOS mosaico_44: el mosaico 44: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa370..0xa3a2  (50 bytes)
DATA_mosaico_44:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a370  ..........
	defb 000h,000h,000h,05dh,07bh,0d3h,095h,000h,000h,000h	; a37a  ...]{.....
	defb 000h,000h,06bh,087h,05ah,05ah,0dfh,0c3h,000h,000h	; a384  ..k.ZZ....
	defb 000h,06ch,084h,05ah,05ah,05ah,05ah,0dch,0c4h,000h	; a38e  .l.ZZZZ...
	defb 000h,06dh,092h,093h,05bh,05bh,0ebh,0eah,0c5h,000h	; a398  .m..[[....

; ----------------------------------------------------------------------
; DATOS mosaico_45: el mosaico 45: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa3a2..0xa3d4  (50 bytes)
DATA_mosaico_45:
	defb 000h,000h,000h,000h,097h,0d4h,0d5h,096h,000h,000h	; a3a2  ..........
	defb 000h,000h,000h,098h,05ah,05ah,0ddh,0c2h,000h,000h	; a3ac  ....ZZ....
	defb 000h,000h,098h,05ah,05ah,0e0h,0c6h,000h,000h,000h	; a3b6  ...ZZ.....
	defb 000h,0beh,0deh,05ah,05ah,05ah,0e9h,0c9h,000h,000h	; a3c0  ...ZZZ....
	defb 000h,06fh,092h,05bh,05bh,05bh,0eah,0c7h,000h,000h	; a3ca  .o.[[[....

; ----------------------------------------------------------------------
; DATOS mosaico_46: el mosaico 46: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa3d4..0xa406  (50 bytes)
DATA_mosaico_46:
	defb 000h,000h,05eh,07dh,07ch,05fh,000h,000h,000h,000h	; a3d4  ..^}|_....
	defb 000h,000h,06ah,085h,05ah,05ah,060h,000h,000h,000h	; a3de  ..j.ZZ`...
	defb 000h,000h,000h,06eh,088h,05ah,05ah,060h,000h,000h	; a3e8  ...n.ZZ`..
	defb 000h,000h,071h,091h,05ah,05ah,05ah,086h,066h,000h	; a3f2  ..q.ZZZ.f.
	defb 000h,000h,06fh,092h,05bh,05bh,05bh,0eah,0c7h,000h	; a3fc  ..o.[[[...

; ----------------------------------------------------------------------
; DATOS mosaico_47: el mosaico 47: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa406..0xa438  (50 bytes)
DATA_mosaico_47:
	defb 000h,000h,000h,000h,000h,0d8h,0bah,0d7h,0d6h,099h	; a406  ..........
	defb 000h,000h,000h,0bbh,0dah,0d9h,05ah,05ah,0dbh,0bfh	; a410  ......ZZ..
	defb 000h,000h,0bch,05ah,05ah,05ah,0e2h,0e1h,0cah,0cfh	; a41a  ...ZZZ....
	defb 000h,000h,0c1h,05ah,0c0h,0e3h,0cbh,000h,000h,000h	; a424  ...Z......
	defb 000h,000h,0cdh,0e4h,0cch,0ceh,000h,000h,000h,000h	; a42e  ..........

; ----------------------------------------------------------------------
; DATOS mosaico_48: el mosaico 48: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa438..0xa46a  (50 bytes)
DATA_mosaico_48:
	defb 061h,07eh,07fh,062h,080h,000h,000h,000h,000h,000h	; a438  a~.b......
	defb 067h,083h,05ah,05ah,081h,082h,063h,000h,000h,000h	; a442  g.ZZ..c...
	defb 077h,072h,089h,08ah,05ah,05ah,05ah,064h,000h,000h	; a44c  wr..ZZZd..
	defb 000h,000h,000h,073h,08bh,068h,05ah,069h,000h,000h	; a456  ...s.hZi..
	defb 000h,000h,000h,000h,076h,074h,08ch,075h,000h,000h	; a460  ....vt.u..

; ----------------------------------------------------------------------
; DATOS mosaico_49: el mosaico 49: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); se solapan 2 bloques (0xA46A-0xA49C, 0xA46A-0xA4F1); lo leen
;   p01:6D87 (135 bytes)
;   0xa46a..0xa4f1  (135 bytes)
DATA_mosaico_49:
	defb 000h,000h,000h,000h,000h,0e2h,0e4h,0e3h,0e5h,0c5h	; a46a  ..........
	defb 06ch,000h,000h,000h,000h,000h,000h,000h,000h,000h	; a474  l.........
	defb 0e8h,0e9h,0eah,0e1h,0e4h,0e3h,0e5h,000h,000h,000h	; a47e  ..........
	defb 000h,000h,0e2h,0e4h,0e3h,0e5h,0dbh,06bh,0e8h,0e9h	; a488  .......k..
	defb 0e0h,0d6h,000h,000h,000h,000h,000h,0e8h,0e9h,0eah	; a492  ..........
	defb 0ebh,0bbh,087h,08bh,08ch,08dh,07ah,06dh,000h,000h	; a49c  ......zm..
	defb 000h,000h,000h,000h,000h,0bah,096h,08eh,0ddh,0c0h	; a4a6  ..........
	defb 0c1h,06eh,000h,000h,000h,000h,000h,000h,000h,000h	; a4b0  .n........
	defb 099h,08ah,0d8h,076h,0beh,0bfh,077h,000h,000h,0edh	; a4ba  ...v..w...
	defb 000h,000h,000h,000h,000h,097h,089h,06fh,070h,0cfh	; a4c4  .......op.
	defb 081h,073h,000h,0d1h,0eeh,000h,000h,000h,000h,000h	; a4ce  .s........
	defb 093h,086h,0cdh,0ceh,072h,094h,0d5h,0bdh,075h,000h	; a4d8  ....r...u.
	defb 000h,000h,000h,000h,000h,098h,085h,07bh,071h,000h	; a4e2  .......{q.
	defb 095h,084h,0dch,074h,000h	; a4ec

; ----------------------------------------------------------------------
; DATOS mosaico_53: el mosaico 53: 15 x 9 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (135 bytes)
;   0xa4f1..0xa578  (135 bytes)
DATA_mosaico_53:
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0e2h,0e4h,0e3h,0e5h,000h,000h,000h	; a4f1  ...............
	defb 000h,000h,000h,000h,000h,000h,06ah,000h,0d3h,0e7h,0dfh,0d2h,000h,000h,000h	; a500  ......j........
	defb 000h,0e2h,0e4h,0e3h,0e5h,0d7h,069h,0cbh,0cch,078h,091h,062h,000h,000h,000h	; a50f  ......i..x.b...
	defb 000h,0e8h,0e9h,0eah,0ebh,0bch,068h,0dah,080h,083h,088h,067h,000h,000h,000h	; a51e  ......h....g...
	defb 000h,000h,000h,0e2h,0e4h,0e3h,0e5h,07eh,0c2h,0c3h,066h,000h,000h,000h,000h	; a52d  .......~..f....
	defb 000h,000h,000h,0e6h,0e7h,0deh,0d4h,0d8h,0c9h,0bfh,077h,000h,0ech,000h,000h	; a53c  ..........w....
	defb 000h,000h,000h,000h,000h,097h,089h,064h,0cah,081h,073h,000h,0d0h,000h,000h	; a54b  .......d..s....
	defb 000h,000h,000h,000h,000h,093h,086h,0cdh,063h,094h,0d5h,0bdh,075h,000h,000h	; a55a  ........c...u..
	defb 000h,000h,000h,000h,000h,098h,085h,07bh,065h,095h,084h,0dch,074h,000h,000h	; a569  .......{e...t..

; ----------------------------------------------------------------------
; DATOS mosaico_54: el mosaico 54: 15 x 9 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (135 bytes)
;   0xa578..0xa5ff  (135 bytes)
DATA_mosaico_54:
	defb 000h,000h,000h,000h,000h,000h,000h,0e2h,0e4h,0e3h,0e5h,000h,000h,000h,000h	; a578  ...............
	defb 000h,000h,0e2h,0e4h,0e3h,0e5h,05eh,0e6h,0e7h,0dfh,0d2h,000h,000h,000h,000h	; a587  ......^........
	defb 000h,000h,0e6h,0e7h,0eah,0ebh,07dh,05fh,000h,092h,062h,000h,000h,000h,000h	; a596  ......}_..b....
	defb 000h,000h,000h,000h,000h,05dh,0c6h,0c7h,082h,08fh,061h,000h,000h,000h,000h	; a5a5  .....]....a....
	defb 000h,000h,000h,000h,05ch,0c4h,081h,07fh,0d9h,079h,060h,000h,000h,000h,000h	; a5b4  ....\....y`....
	defb 000h,000h,000h,000h,05bh,07ch,08ah,0d8h,076h,0c8h,0bfh,077h,000h,000h,0edh	; a5c3  ....[|..v..w...
	defb 0e2h,0e4h,0e3h,0e5h,05ah,090h,089h,06fh,070h,0cfh,081h,073h,000h,0d1h,0eeh	; a5d2  ....Z..op..s...
	defb 0e8h,0e9h,0eah,0ebh,000h,093h,086h,0cdh,0ceh,072h,094h,0d5h,0bdh,075h,000h	; a5e1  .........r...u.
	defb 000h,000h,000h,000h,000h,098h,085h,07bh,071h,000h,095h,084h,0dch,074h,000h	; a5f0  .......{q....t.

; ----------------------------------------------------------------------
; DATOS mosaico_55: el mosaico 55: 7 x 7 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (49 bytes)
;   0xa5ff..0xa630  (49 bytes)
DATA_mosaico_55:
	defb 000h,083h,084h,071h,08eh,08dh,000h	; a5ff
	defb 075h,079h,07dh,06fh,087h,078h,077h	; a606
	defb 063h,05ch,085h,067h,07bh,000h,000h	; a60d
	defb 074h,064h,07eh,06bh,088h,05eh,000h	; a614
	defb 070h,05fh,07fh,068h,089h,061h,000h	; a61b
	defb 076h,065h,080h,05bh,08ah,062h,000h	; a622
	defb 076h,082h,081h,066h,08bh,08ch,000h	; a629

; ----------------------------------------------------------------------
; DATOS mosaico_56: el mosaico 56: 7 x 7 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (49 bytes)
;   0xa630..0xa661  (49 bytes)
DATA_mosaico_56:
	defb 000h,083h,084h,071h,08eh,08dh,000h	; a630
	defb 075h,079h,07dh,06fh,087h,078h,077h	; a637
	defb 063h,05ch,086h,072h,07ch,06dh,06ch	; a63e
	defb 074h,064h,07eh,069h,073h,06ah,06eh	; a645
	defb 070h,05fh,07fh,068h,07ah,05ah,060h	; a64c
	defb 076h,065h,080h,05bh,08ah,05dh,000h	; a653
	defb 076h,082h,081h,066h,08bh,08ch,000h	; a65a

; ----------------------------------------------------------------------
; DATOS mosaico_57: el mosaico 57: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0xa661..0xa665  (4 bytes)
DATA_mosaico_57:
	defb 0bah,0bbh	; a661
	defb 0bch,0bdh	; a663

; ----------------------------------------------------------------------
; DATOS mosaico_58: el mosaico 58: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa665..0xa697  (50 bytes)
DATA_mosaico_58:
	defb 000h,000h,000h,085h,05fh,08bh,0d1h,000h,000h,000h	; a665  ...._.....
	defb 000h,000h,05bh,076h,077h,0c3h,0c2h,087h,000h,000h	; a66f  ..[vw.....
	defb 06fh,073h,06eh,071h,06dh,099h,0bdh,0bah,0bfh,0bbh	; a679  osnqm.....
	defb 063h,05eh,070h,07fh,07bh,0c7h,0cbh,0bch,08ah,08fh	; a683  c^p.{.....
	defb 074h,05ah,06ch,079h,000h,000h,0c5h,098h,086h,0c0h	; a68d  tZly......

; ----------------------------------------------------------------------
; DATOS mosaico_59: el mosaico 59: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa697..0xa6c9  (50 bytes)
DATA_mosaico_59:
	defb 000h,000h,000h,084h,05fh,08bh,0d0h,000h,000h,000h	; a697  ...._.....
	defb 000h,000h,05bh,076h,077h,0c3h,0c2h,087h,000h,000h	; a6a1  ..[vw.....
	defb 072h,05ch,075h,07eh,081h,0cdh,0cah,0c1h,088h,0beh	; a6ab  r\u~......
	defb 064h,067h,06ah,082h,083h,0cfh,0ceh,096h,093h,090h	; a6b5  dgj.......
	defb 061h,06bh,078h,000h,000h,000h,000h,0c4h,097h,08dh	; a6bf  akx.......

; ----------------------------------------------------------------------
; DATOS mosaico_60: el mosaico 60: 10 x 5 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (50 bytes)
;   0xa6c9..0xa6fb  (50 bytes)
DATA_mosaico_60:
	defb 000h,000h,000h,085h,05fh,08bh,0d1h,000h,000h,000h	; a6c9  ...._.....
	defb 000h,000h,05bh,076h,077h,0c3h,0c2h,087h,000h,000h	; a6d3  ..[vw.....
	defb 060h,05dh,075h,07ah,07ch,0c8h,0c6h,0c1h,089h,08ch	; a6dd  `]uz|.....
	defb 062h,069h,065h,07dh,080h,0cch,0c9h,091h,095h,08eh	; a6e7  bie}......
	defb 068h,066h,06ch,079h,000h,000h,0c5h,098h,092h,094h	; a6f1  hfly......

; ----------------------------------------------------------------------
; DATOS tabla_A6FB: 5 punteros a dibujos de filas de (ix+8) caracteres
;   (p01:727C); lo leen p01:7272 (10 bytes)
;   0xa6fb..0xa705  (10 bytes)
DATA_tabla_A6FB:
	defb 005h,0a7h	; a6fb
	defb 008h,0a7h	; a6fd
	defb 00eh,0a7h	; a6ff
	defb 017h,0a7h	; a701
	defb 01dh,0a7h	; a703

; ----------------------------------------------------------------------
; DATOS dibujos_A6FB: los dibujos de la tabla 0xA6FB, seguidos; lo leen
;   p01:7272 (33 bytes)
;   0xa705..0xa726  (33 bytes)
DATA_dibujos_A6FB:
	defb 0c6h,0c7h,0c8h,0c9h,0cah,0cbh,0cch,0cdh,0ceh,07ah,07bh,07ch,07dh,07eh,07fh,080h	; a705  .........z{|}~..
	defb 081h,082h,0c9h,0cah,0cbh,0cch,0cdh,0ceh,07ah,07bh,07ch,07dh,07eh,07fh,080h,081h	; a715  ........z{|}~...
	defb 082h	; a725

; ----------------------------------------------------------------------
; DATOS tabla_A726: 4 punteros a dibujos de 3 filas de 1 o 3 caracteres
;   (p01:72DA); lo leen p01:72C6 (8 bytes)
;   0xa726..0xa72e  (8 bytes)
DATA_tabla_A726:
	defb 02eh,0a7h	; a726
	defb 031h,0a7h	; a728
	defb 03ah,0a7h	; a72a
	defb 043h,0a7h	; a72c

; ----------------------------------------------------------------------
; DATOS dibujos_A726: los dibujos de la tabla 0xA726, seguidos; lo leen
;   p01:72C6 (30 bytes)
;   0xa72e..0xa74c  (30 bytes)
DATA_dibujos_A726:
	defb 0cfh,0cfh,0cfh,08fh,083h,0d3h,08fh,083h,0d3h,08fh,083h,0d3h,083h,083h,083h,083h	; a72e  ................
	defb 083h,083h,083h,083h,083h,0dah,083h,095h,0dah,083h,095h,0dah,083h,095h	; a73e  ..............

; ----------------------------------------------------------------------
; DATOS tabla_A74C: 4 punteros a dibujos de 3 filas de 1 o 3 caracteres
;   (p01:72DA); lo leen p01:72B1 (8 bytes)
;   0xa74c..0xa754  (8 bytes)
DATA_tabla_A74C:
	defb 054h,0a7h	; a74c
	defb 057h,0a7h	; a74e
	defb 060h,0a7h	; a750
	defb 069h,0a7h	; a752

; ----------------------------------------------------------------------
; DATOS dibujos_A74C: los dibujos de la tabla 0xA74C, seguidos; lo leen
;   p01:72B1 (30 bytes)
;   0xa754..0xa772  (30 bytes)
DATA_dibujos_A74C:
	defb 0d0h,0d1h,0d2h,090h,0d4h,0d7h,091h,0d5h,0d8h,092h,0d6h,0d9h,084h,085h,086h,087h	; a754  ................
	defb 088h,089h,08ah,08bh,08ch,0deh,0dbh,096h,0dfh,0dch,097h,0e0h,0ddh,098h	; a764  ..............

; ----------------------------------------------------------------------
; DATOS dibujo_A772: 3 filas de 4 caracteres que p01:731A copia a (0xEA24); lo
;   leen p01:7310 (12 bytes)
;   0xa772..0xa77e  (12 bytes)
DATA_dibujo_A772:
	defb 0f0h,0f0h,0f0h,0f0h	; a772
	defb 0f0h,0f0h,0f0h,0f0h	; a776
	defb 0f0h,0f0h,0f0h,0f0h	; a77a

; ----------------------------------------------------------------------
; DATOS tabla_A77E: 24 punteros a tiras de (ix+0x1F) caracteres (p01:6FA6; en
;   el mapa 10 se les resta 0x22, p01:6FAC); lo leen p01:6F90 (48 bytes)
;   0xa77e..0xa7ae  (48 bytes)
DATA_tabla_A77E:
	defb 0aeh,0a7h	; a77e
	defb 0afh,0a7h	; a780
	defb 0b1h,0a7h	; a782
	defb 0b4h,0a7h	; a784
	defb 0b8h,0a7h	; a786
	defb 0bdh,0a7h	; a788
	defb 0c3h,0a7h	; a78a
	defb 0cah,0a7h	; a78c
	defb 0d2h,0a7h	; a78e
	defb 0dbh,0a7h	; a790
	defb 0e5h,0a7h	; a792
	defb 0f0h,0a7h	; a794
	defb 0fch,0a7h	; a796
	defb 0fdh,0a7h	; a798
	defb 0ffh,0a7h	; a79a
	defb 002h,0a8h	; a79c
	defb 006h,0a8h	; a79e
	defb 00bh,0a8h	; a7a0
	defb 011h,0a8h	; a7a2
	defb 018h,0a8h	; a7a4
	defb 020h,0a8h	; a7a6
	defb 029h,0a8h	; a7a8
	defb 033h,0a8h	; a7aa
	defb 03eh,0a8h	; a7ac

; ----------------------------------------------------------------------
; DATOS dibujos_A77E: los dibujos de la tabla 0xA77E, seguidos; lo leen
;   p01:6F90 (156 bytes)
;   0xa7ae..0xa84a  (156 bytes)
DATA_dibujos_A77E:
	defb 0c8h,0c8h,0cch,0c8h,0c9h,0cch,0c8h,0c9h,0cbh,0cch,0c8h,0c9h,0cah,0cbh,0cch,0c8h	; a7ae  ................
	defb 0c9h,0cah,0cah,0cbh,0cch,0c8h,0c9h,0cah,0cah,0cah,0cbh,0cch,0c8h,0c9h,0cah,0cah	; a7be  ................
	defb 0cah,0cah,0cbh,0cch,0c8h,0c9h,0cah,0cah,0cah,0cah,0cah,0cbh,0cch,0c8h,0c9h,0cah	; a7ce  ................
	defb 0cah,0cah,0cah,0cah,0cah,0cbh,0cch,0c8h,0c9h,0cah,0cah,0cah,0cah,0cah,0cah,0cah	; a7de  ................
	defb 0cbh,0cch,0c8h,0c9h,0cah,0cah,0cah,0cah,0cah,0cah,0cah,0cah,0cbh,0cch,0c8h,0cch	; a7ee  ................
	defb 0c8h,0cch,0c9h,0c8h,0cch,0cbh,0c9h,0c8h,0cch,0cbh,0cah,0c9h,0c8h,0cch,0cbh,0cah	; a7fe  ................
	defb 0cah,0c9h,0c8h,0cch,0cbh,0cah,0cah,0cah,0c9h,0c8h,0cch,0cbh,0cah,0cah,0cah,0cah	; a80e  ................
	defb 0c9h,0c8h,0cch,0cbh,0cah,0cah,0cah,0cah,0cah,0c9h,0c8h,0cch,0cbh,0cah,0cah,0cah	; a81e  ................
	defb 0cah,0cah,0cah,0c9h,0c8h,0cch,0cbh,0cah,0cah,0cah,0cah,0cah,0cah,0cah,0c9h,0c8h	; a82e  ................
	defb 0cch,0cbh,0cah,0cah,0cah,0cah,0cah,0cah,0cah,0cah,0c9h,0c8h	; a83e  ............

; ----------------------------------------------------------------------
; DATOS epilogo_y_creditos: el texto que sube por la pantalla (el epilogo y
;   los creditos, p01:6B40): por linea [columna][largo] y letras de dos medias
;   filas (A = 0x0B, de dos en dos; la de abajo, una menos); 0xFB calla la
;   musica, 0xFD [n] espera, 0xFE linea vacia, 0xFF acaba (tools/textos.py);
;   lo leen p01:6ACA (1502 bytes)
;   0xa84a..0xae28  (1502 bytes)
DATA_epilogo_y_creditos:
	defb 00ch,008h,013h,029h,01bh,021h,027h,017h,033h,013h,00ch,008h,012h,028h,01ah,020h	; a84a  ...).!'.3....(.
	defb 026h,016h,032h,012h,002h,01ah,031h,019h,00bh,025h,01fh,02fh,000h,031h,027h,000h	; a85a  &.2...1..%./.1'.
	defb 03bh,027h,033h,041h,031h,019h,013h,000h,00dh,00bh,00dh,03bh,000h,037h,00bh,02fh	; a86a  .'3A1........7./
	defb 002h,01ah,030h,018h,00ah,024h,01eh,02eh,000h,030h,026h,000h,03ah,026h,032h,040h	; a87a  ..0..$...0&.:&2@
	defb 030h,018h,012h,000h,00ch,00ah,00ch,03ah,000h,036h,00ah,02eh,002h,01ah,02dh,013h	; a88a  0......:.6....-.
	defb 02fh,00fh,033h,013h,011h,000h,02fh,00bh,015h,013h,021h,03bh,03fh,031h,019h,013h	; a89a  /.3.../...!.?1..
	defb 000h,01fh,01bh,025h,017h,011h,027h,023h,002h,01ah,02ch,012h,02eh,00eh,032h,012h	; a8aa  ...%..'#..,...2.
	defb 010h,000h,02eh,00ah,014h,012h,020h,03ah,03eh,030h,018h,012h,000h,01eh,01ah,024h	; a8ba  ...... :>0.....$
	defb 016h,010h,026h,022h,002h,01ah,031h,027h,027h,01fh,000h,00dh,00bh,00fh,01fh,000h	; a8ca  ..&"..1''.......
	defb 029h,013h,00bh,00fh,013h,000h,00bh,025h,011h,000h,035h,01bh,017h,027h,02dh,03fh	; a8da  )......%..5..'-?
	defb 002h,01ah,030h,026h,026h,01eh,000h,00ch,00ah,00eh,01eh,000h,028h,012h,00ah,00eh	; a8ea  ..0&&.......(...
	defb 012h,000h,00ah,024h,010h,000h,034h,01ah,016h,026h,02ch,03eh,002h,017h,029h,027h	; a8fa  ...$..4..&,>..)'
	defb 029h,027h,021h,027h,025h,000h,037h,00bh,02fh,000h,00bh,037h,00bh,02dh,011h,013h	; a90a  )'!'%.7./..7.-..
	defb 011h,000h,031h,019h,013h,002h,017h,028h,026h,028h,026h,020h,026h,024h,000h,036h	; a91a  ..1....(&(& &$.6
	defb 00ah,02eh,000h,00ah,036h,00ah,02ch,010h,012h,010h,000h,030h,018h,012h,002h,01ch	; a92a  ....6.,....0....
	defb 00fh,02dh,027h,037h,025h,000h,015h,027h,02dh,000h,019h,01bh,02fh,000h,00bh,00fh	; a93a  .-'7%..'-.../...
	defb 019h,01bh,013h,035h,013h,023h,013h,025h,031h,03fh,01bh,031h,002h,01ch,00eh,02ch	; a94a  ...5.#.%1?.1...,
	defb 026h,036h,024h,000h,014h,026h,02ch,000h,018h,01ah,02eh,000h,00ah,00eh,018h,01ah	; a95a  &6$..&,.........
	defb 012h,034h,012h,022h,012h,024h,030h,03eh,01ah,030h,002h,01bh,037h,00bh,02fh,000h	; a96a  .4.".$0>.0..7./.
	defb 011h,013h,00fh,01bh,011h,013h,011h,000h,031h,019h,00bh,031h,000h,019h,013h,000h	; a97a  ........1..1....
	defb 029h,02dh,027h,031h,013h,00fh,031h,002h,01bh,036h,00ah,02eh,000h,010h,012h,00eh	; a98a  )-'1..1..6......
	defb 01ah,010h,012h,010h,000h,030h,018h,00ah,030h,000h,018h,012h,000h,028h,02ch,026h	; a99a  .....0..0....(,&
	defb 030h,012h,00eh,030h,002h,01ah,031h,019h,013h,000h,01fh,01bh,025h,017h,011h,027h	; a9aa  0..0..1.....%..'
	defb 023h,000h,037h,01bh,031h,019h,000h,00bh,029h,019h,02dh,027h,011h,01bh,031h,013h	; a9ba  #.7.1...).-'..1.
	defb 002h,01ah,030h,018h,012h,000h,01eh,01ah,024h,016h,010h,026h,022h,000h,036h,01ah	; a9ca  ..0.....$..&".6.
	defb 030h,018h,000h,00ah,028h,018h,02ch,026h,010h,01ah,030h,012h,002h,01bh,00bh,02fh	; a9da  0...(.,&..0..../
	defb 000h,019h,01bh,02fh,000h,037h,01bh,015h,013h,000h,015h,027h,02dh,000h,031h,019h	; a9ea  .../.7.....'-.1.
	defb 013h,000h,02dh,013h,02fh,031h,000h,027h,015h,002h,01bh,00ah,02eh,000h,018h,01ah	; a9fa  ..-./1.'........
	defb 02eh,000h,036h,01ah,014h,012h,000h,014h,026h,02ch,000h,030h,018h,012h,000h,02ch	; aa0a  ..6.....&,.0...,
	defb 012h,02eh,030h,000h,026h,014h,002h,01ch,031h,019h,013h,01bh,02dh,000h,021h,01bh	; aa1a  ..0.&...1...-.!.
	defb 035h,013h,02fh,03fh,031h,019h,01bh,02fh,000h,021h,013h,017h,013h,025h,011h,000h	; aa2a  5./?1../.!...%..
	defb 037h,01bh,021h,021h,002h,01ch,030h,018h,012h,01ah,02ch,000h,020h,01ah,034h,012h	; aa3a  7.!!..0...,. .4.
	defb 02eh,03eh,030h,018h,01ah,02eh,000h,020h,012h,016h,012h,024h,010h,000h,036h,01ah	; aa4a  .>0.... ...$..6.
	defb 020h,020h,002h,01bh,00dh,013h,000h,031h,027h,021h,011h,000h,00bh,017h,00bh,01bh	; aa5a    .....1'!......
	defb 025h,000h,037h,019h,013h,025h,000h,031h,019h,013h,03bh,000h,00bh,02dh,013h,002h	; aa6a  %.7..%.1.....-..
	defb 01bh,00ch,012h,000h,030h,026h,020h,010h,000h,00ah,016h,00ah,01ah,024h,000h,036h	; aa7a  ....0& ......$.6
	defb 018h,012h,024h,000h,030h,018h,012h,03ah,000h,00ah,02ch,012h,002h,01bh,00bh,029h	; aa8a  ..$.0..:..,....)
	defb 031h,000h,031h,027h,000h,021h,027h,02fh,013h,000h,00dh,013h,021h,01bh,013h,015h	; aa9a  1.1'.!'/....!...
	defb 000h,01bh,025h,000h,021h,027h,035h,013h,03fh,002h,01bh,00ah,028h,030h,000h,030h	; aaaa  ..%.!'5.?...(0.0
	defb 026h,000h,020h,026h,02eh,012h,000h,00ch,012h,020h,01ah,012h,014h,000h,01ah,024h	; aaba  &. &..... .....$
	defb 000h,020h,026h,034h,012h,03eh,0fdh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; aaca  . &4.>..........
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,00dh,005h,02fh,031h,00bh,015h,015h,00dh,005h	; aada  ........./1.....
	defb 02eh,030h,00ah,014h,014h,0feh,0feh,009h,00fh,023h,00bh,01bh,025h,000h,029h,02dh	; aaea  .0.......#..%.)-
	defb 027h,017h,02dh,00bh,023h,023h,013h,02dh,009h,00fh,022h,00ah,01ah,024h,000h,028h	; aafa  '.-.##.-.."..$.(
	defb 02ch,026h,016h,02ch,00ah,022h,022h,012h,02ch,00ch,008h,03bh,03fh,019h,00bh,02dh	; ab0a  ,&.,."".,...?..-
	defb 033h,01fh,01bh,00ch,008h,03ah,03eh,018h,00ah,02ch,032h,01eh,01ah,0feh,0feh,009h	; ab1a  3....:>..,2.....
	defb 00fh,02fh,033h,00dh,000h,000h,029h,02dh,027h,017h,02dh,00bh,023h,023h,013h,02dh	; ab2a  ./3...)-'.-.##.-
	defb 009h,00fh,02eh,032h,00ch,000h,000h,028h,02ch,026h,016h,02ch,00ah,022h,022h,012h	; ab3a  ...2...(,&.,."".
	defb 02ch,00dh,007h,01bh,03fh,00bh,01fh,00bh,011h,00bh,00dh,007h,01ah,03eh,00ah,01eh	; ab4a  ,...?........>..
	defb 00ah,010h,00ah,00dh,007h,023h,03fh,027h,03dh,00bh,037h,00bh,00dh,007h,022h,03eh	; ab5a  .....#?'=.7...">
	defb 026h,03ch,00ah,036h,00ah,00eh,005h,031h,03fh,027h,01fh,00bh,00eh,005h,030h,03eh	; ab6a  &<.6...1?'....0>
	defb 026h,01eh,00ah,00bh,00ah,03bh,03fh,019h,01bh,02dh,027h,025h,00bh,01fh,00bh,00bh	; ab7a  &.....?..-'%....
	defb 00ah,03ah,03eh,018h,01ah,02ch,026h,024h,00ah,01eh,00ah,00dh,007h,01fh,03fh,027h	; ab8a  .:>..,&$......?'
	defb 03dh,00bh,037h,00bh,00dh,007h,01eh,03eh,026h,03ch,00ah,036h,00ah,00bh,00bh,02fh	; ab9a  =.7....>&<.6.../
	defb 03fh,03bh,027h,02fh,019h,01bh,01fh,00bh,037h,00bh,00bh,00bh,02eh,03eh,03ah,026h	; abaa  ?.'/....7....>:&
	defb 02eh,018h,01ah,01eh,00ah,036h,00ah,0feh,0feh,008h,010h,017h,02dh,00bh,029h,019h	; abba  .....6......-.).
	defb 01bh,00fh,000h,011h,013h,02fh,01bh,017h,025h,013h,02dh,008h,010h,016h,02ch,00ah	; abca  ...../..%.-...,.
	defb 028h,018h,01ah,00eh,000h,010h,012h,02eh,01ah,016h,024h,012h,02ch,00ch,009h,02dh	; abda  (.........$.,..-
	defb 03fh,02fh,019h,027h,017h,00bh,01fh,01bh,00ch,009h,02ch,03eh,02eh,018h,026h,016h	; abea  ?/.'......,>..&.
	defb 00ah,01eh,01ah,00bh,00ah,00fh,03fh,031h,00bh,025h,01bh,017h,00bh,01fh,01bh,00bh	; abfa  ......?1.%......
	defb 00ah,00eh,03eh,030h,00ah,024h,01ah,016h,00ah,01eh,01ah,00ch,009h,031h,03fh,023h	; ac0a  ..>0.$.......1?#
	defb 01bh,03bh,027h,02fh,019h,01bh,00ch,009h,030h,03eh,022h,01ah,03ah,026h,02eh,018h	; ac1a  ..'/....0>".:&..
	defb 01ah,00bh,00bh,01fh,03fh,02fh,019h,01bh,02dh,00bh,017h,00bh,01fh,01bh,00bh,00bh	; ac2a  ....?/..-.......
	defb 01eh,03eh,02eh,018h,01ah,02ch,00ah,016h,00ah,01eh,01ah,0feh,0feh,009h,00eh,02fh	; ac3a  .>...,........./
	defb 027h,033h,025h,011h,000h,000h,00fh,02dh,013h,00bh,031h,027h,02dh,009h,00eh,02eh	; ac4a  '3%....-..1'-...
	defb 026h,032h,024h,010h,000h,000h,00eh,02ch,012h,00ah,030h,026h,02ch,00ch,008h,01fh	; ac5a  &2$....,..0&,...
	defb 03fh,033h,013h,019h,00bh,02dh,00bh,00ch,008h,01eh,03eh,032h,012h,018h,00ah,02ch	; ac6a  ?3...-....>2...,
	defb 00ah,0feh,0feh,0feh,0feh,0feh,0feh,006h,014h,029h,021h,00bh,025h,025h,013h,02dh	; ac7a  .........)!.%%.-
	defb 000h,00bh,025h,011h,000h,011h,01bh,02dh,013h,00fh,031h,027h,02dh,006h,014h,028h	; ac8a  ..%....-..1'-..(
	defb 020h,00ah,024h,024h,012h,02ch,000h,00ah,024h,010h,000h,010h,01ah,02ch,012h,00eh	; ac9a   .$$.,..$....,..
	defb 030h,026h,02ch,00ch,009h,02dh,03fh,02fh,019h,027h,017h,00bh,01fh,01bh,00ch,009h	; acaa  0&,..-?/.'......
	defb 02ch,03eh,02eh,018h,026h,016h,00ah,01eh,01ah,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; acba  ,>..&...........
	defb 0feh,0feh,0feh,0feh,0feh,005h,016h,037h,013h,000h,029h,02dh,027h,023h,01bh,02fh	; acca  .......7..)-'#./
	defb 013h,000h,031h,027h,000h,00fh,027h,025h,031h,01bh,025h,033h,013h,005h,016h,036h	; acda  ..1'..'%1.%3...6
	defb 012h,000h,028h,02ch,026h,022h,01ah,02eh,012h,000h,030h,026h,000h,00eh,026h,024h	; acea  ..(,&"....0&..&$
	defb 030h,01ah,024h,032h,012h,005h,015h,02fh,013h,025h,011h,01bh,025h,017h,000h,02dh	; acfa  0.$2.../.%..%..-
	defb 027h,023h,00bh,025h,031h,01bh,00fh,000h,017h,00bh,023h,013h,005h,015h,02eh,012h	; ad0a  '#.%1.....#.....
	defb 024h,010h,01ah,024h,016h,000h,02ch,026h,022h,00ah,024h,030h,01ah,00eh,000h,016h	; ad1a  $..$..,&".$0....
	defb 00ah,022h,012h,005h,009h,023h,013h,02fh,02fh,00bh,017h,013h,02fh,03fh,005h,009h	; ad2a  ."...#.//.../?..
	defb 022h,012h,02eh,02eh,00ah,016h,012h,02eh,03eh,0feh,0feh,005h,013h,031h,019h,00bh	; ad3a  ".......>....1..
	defb 025h,01fh,000h,03bh,027h,033h,000h,035h,013h,02dh,03bh,000h,023h,033h,00fh,019h	; ad4a  %...'3.5.-..#3..
	defb 005h,013h,030h,018h,00ah,024h,01eh,000h,03ah,026h,032h,000h,034h,012h,02ch,03ah	; ad5a  ..0..$..:&2.4.,:
	defb 000h,022h,032h,00eh,018h,005h,013h,015h,027h,02dh,000h,03bh,027h,033h,02dh,000h	; ad6a  ."2.....'-..'3-.
	defb 01dh,027h,01bh,025h,01bh,025h,017h,000h,01bh,025h,005h,013h,014h,026h,02ch,000h	; ad7a  .'.%.%...%...&,.
	defb 03ah,026h,032h,02ch,000h,01ch,026h,01ah,024h,01ah,024h,016h,000h,01ah,024h,005h	; ad8a  :&2,..&.$.$...$.
	defb 00bh,031h,019h,01bh,02fh,000h,02fh,031h,027h,02dh,03bh,03fh,005h,00bh,030h,018h	; ad9a  .1.././1'-.?..0.
	defb 01ah,02eh,000h,02eh,030h,026h,02ch,03ah,03eh,0feh,0feh,0feh,0feh,0feh,0fdh,0ffh	; adaa  ....0&,:>.......
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,006h,013h,029h,02dh,013h,02fh,013h,025h	; adba  ..........)-./.%
	defb 031h,013h,011h,000h,00dh,03bh,000h,01fh,027h,025h,00bh,023h,01bh,006h,013h,028h	; adca  1.......'%.#...(
	defb 02ch,012h,02eh,012h,024h,030h,012h,010h,000h,00ch,03ah,000h,01eh,026h,024h,00ah	; adda  ,...$0....:..&$.
	defb 022h,01ah,009h,00eh,043h,000h,003h,009h,007h,005h,000h,000h,01fh,027h,025h,00bh	; adea  "...C........'%.
	defb 023h,01bh,009h,00eh,042h,000h,002h,008h,006h,004h,000h,000h,01eh,026h,024h,00ah	; adfa  #...B........&$.
	defb 022h,01ah,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fdh,0ffh,0fbh	; ae0a  "...............
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0ffh	; ae1a  ..............

; ----------------------------------------------------------------------
; DATOS historia: el texto que sube por la pantalla (la historia del
;   principio, p01:6B40): por linea [columna][largo] y letras de dos medias
;   filas (A = 0x0B, de dos en dos; la de abajo, una menos); 0xFB calla la
;   musica, 0xFD [n] espera, 0xFE linea vacia, 0xFF acaba (tools/textos.py);
;   lo leen p01:6AC5 (630 bytes)
;   0xae28..0xb09e  (630 bytes)
DATA_historia:
	defb 00dh,005h,02fh,031h,027h,02dh,03bh,00dh,005h,02eh,030h,026h,02ch,03ah,002h,01ch	; ae28  ../1'-....0&,:..
	defb 029h,027h,029h,027h,021h,027h,025h,000h,037h,013h,025h,031h,000h,01bh,025h,031h	; ae38  )')'!'%.7.%1..%1
	defb 027h,000h,023h,031h,03fh,00bh,031h,027h,02fh,000h,031h,027h,002h,01ch,028h,026h	; ae48  '.#1?.1'/.1'..(&
	defb 028h,026h,020h,026h,024h,000h,036h,012h,024h,030h,000h,01ah,024h,030h,026h,000h	; ae58  (& &$.6.$0..$0&.
	defb 022h,030h,03eh,00ah,030h,026h,02eh,000h,030h,026h,002h,01ah,02dh,013h,02fh,00fh	; ae68  "0>.0&..0&..-./.
	defb 033h,013h,000h,00bh,029h,019h,02dh,027h,011h,01bh,031h,013h,000h,01fh,01bh,011h	; ae78  3...).-'..1.....
	defb 025h,00bh,029h,029h,013h,011h,002h,01ah,02ch,012h,02eh,00eh,032h,012h,000h,00ah	; ae88  %.))....,...2...
	defb 028h,018h,02ch,026h,010h,01ah,030h,012h,000h,01eh,01ah,010h,024h,00ah,028h,028h	; ae98  (.,&..0.....$.((
	defb 012h,010h,002h,01ch,00dh,03bh,000h,019h,033h,011h,025h,027h,02fh,03fh,000h,00dh	; aea8  ........3.%'/?..
	defb 033h,031h,000h,01bh,031h,000h,037h,00bh,02fh,000h,00bh,000h,031h,02dh,00bh,029h	; aeb8  31..1.7./...1-.)
	defb 002h,01ch,00ch,03ah,000h,018h,032h,010h,024h,026h,02eh,03eh,000h,00ch,032h,030h	; aec8  ...:..2.$&.>..20
	defb 000h,01ah,030h,000h,036h,00ah,02eh,000h,00ah,000h,030h,02ch,00ah,028h,002h,01ch	; aed8  ..0.6.....0,.(..
	defb 023h,00bh,011h,013h,000h,00dh,03bh,000h,017h,00bh,021h,01bh,027h,033h,02fh,03fh	; aee8  #.........!.'3/?
	defb 000h,019h,013h,000h,00bh,031h,031h,00bh,00fh,01fh,013h,011h,002h,01ch,022h,00ah	; aef8  .....11.......".
	defb 010h,012h,000h,00ch,03ah,000h,016h,00ah,020h,01ah,026h,032h,02eh,03eh,000h,018h	; af08  ....:... .&2.>..
	defb 012h,000h,00ah,030h,030h,00ah,00eh,01eh,012h,010h,002h,01bh,031h,019h,013h,000h	; af18  ...00.......1...
	defb 00fh,00bh,02fh,031h,021h,013h,000h,011h,033h,02dh,01bh,025h,017h,000h,029h,027h	; af28  ../1!...3-.%..)'
	defb 029h,027h,021h,027h,025h,045h,02fh,002h,01bh,030h,018h,012h,000h,00eh,00ah,02eh	; af38  )'!'%E/..0......
	defb 030h,020h,012h,000h,010h,032h,02ch,01ah,024h,016h,000h,028h,026h,028h,026h,020h	; af48  0 ...2,.$..(&(&
	defb 026h,024h,044h,02eh,002h,01ah,00bh,00dh,02fh,013h,025h,00fh,013h,000h,00bh,025h	; af58  &$D...../.%....%
	defb 011h,000h,00bh,021h,02fh,027h,000h,01fh,01bh,011h,025h,00bh,029h,029h,013h,011h	; af68  ...!/'....%.))..
	defb 002h,01ah,00ah,00ch,02eh,012h,024h,00eh,012h,000h,00ah,024h,010h,000h,00ah,020h	; af78  ......$....$...
	defb 02eh,026h,000h,01eh,01ah,010h,024h,00ah,028h,028h,012h,010h,002h,01ah,00bh,025h	; af88  .&....$.((.....%
	defb 011h,000h,01bh,023h,029h,02dh,01bh,02fh,027h,025h,013h,011h,000h,00bh,000h,00dh	; af98  ...#)-./'%......
	defb 00bh,00dh,03bh,000h,015h,02dh,027h,023h,002h,01ah,00ah,024h,010h,000h,01ah,022h	; afa8  .....-'#...$..."
	defb 028h,02ch,01ah,02eh,026h,024h,012h,010h,000h,00ah,000h,00ch,00ah,00ch,03ah,000h	; afb8  (,..&$........:.
	defb 014h,02ch,026h,022h,002h,01bh,031h,019h,013h,000h,019h,013h,00bh,035h,013h,025h	; afc8  .,&"..1......5.%
	defb 000h,037h,019h,027h,000h,037h,00bh,02fh,000h,02fh,033h,029h,029h,027h,02fh,013h	; afd8  .7.'.7././3))'/.
	defb 011h,002h,01bh,030h,018h,012h,000h,018h,012h,00ah,034h,012h,024h,000h,036h,018h	; afe8  ...0......4.$.6.
	defb 026h,000h,036h,00ah,02eh,000h,02eh,032h,028h,028h,026h,02eh,012h,010h,002h,019h	; aff8  &.6....2((&.....
	defb 031h,027h,000h,00dh,013h,000h,00dh,027h,02dh,025h,000h,031h,027h,000h,029h,027h	; b008  1'.....'-%.1'.)'
	defb 029h,027h,021h,027h,025h,000h,00bh,025h,011h,002h,019h,030h,026h,000h,00ch,012h	; b018  )'!'%..%...0&...
	defb 000h,00ch,026h,02ch,024h,000h,030h,026h,000h,028h,026h,028h,026h,020h,026h,024h	; b028  ..&,$.0&.(&(& &$
	defb 000h,00ah,024h,010h,002h,017h,00bh,029h,019h,02dh,027h,011h,01bh,031h,013h,000h	; b038  ..$....).-'..1..
	defb 02fh,013h,035h,013h,02dh,00bh,021h,000h,03bh,013h,00bh,02dh,02fh,002h,017h,00ah	; b048  /.5.-.!....-/...
	defb 028h,018h,02ch,026h,010h,01ah,030h,012h,000h,02eh,012h,034h,012h,02ch,00ah,020h	; b058  (.,&..0....4.,.
	defb 000h,03ah,012h,00ah,02ch,02eh,002h,008h,021h,00bh,031h,013h,02dh,03fh,03fh,03fh	; b068  .:..,...!.1.-???
	defb 002h,008h,020h,00ah,030h,012h,02ch,03eh,03eh,03eh,0fdh,0ffh,0feh,0feh,0feh,0feh	; b078  .. .0.,>>>......
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0fbh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; b088  ................
	defb 0feh,0feh,0feh,0feh,0feh,0ffh	; b098

; ----------------------------------------------------------------------
; DATOS tabla_de_mensajes: 52 punteros, uno por mensaje (p02:9505); si la BIOS
;   no es japonesa (los 4 bits bajos de 0x002B) p02:94F8 suma 0x20: 0-0x13 en
;   japones, 0x20-0x33 en ingles; lo leen p02:9508 (104 bytes)
;   0xb09e..0xb106  (104 bytes)
DATA_tabla_de_mensajes:
	defb 006h,0b1h	; b09e
	defb 048h,0b1h	; b0a0
	defb 068h,0b1h	; b0a2
	defb 09ah,0b1h	; b0a4
	defb 0d7h,0b1h	; b0a6
	defb 0fch,0b1h	; b0a8
	defb 01dh,0b2h	; b0aa
	defb 036h,0b2h	; b0ac
	defb 059h,0b2h	; b0ae
	defb 072h,0b2h	; b0b0
	defb 089h,0b2h	; b0b2
	defb 0a2h,0b2h	; b0b4
	defb 0cch,0b2h	; b0b6
	defb 00ch,0b3h	; b0b8
	defb 01eh,0b3h	; b0ba
	defb 041h,0b3h	; b0bc
	defb 051h,0b3h	; b0be
	defb 05bh,0b3h	; b0c0
	defb 07dh,0b3h	; b0c2
	defb 08dh,0b3h	; b0c4
	defb 0a2h,0b3h	; b0c6
	defb 0a2h,0b3h	; b0c8
	defb 0a2h,0b3h	; b0ca
	defb 0a2h,0b3h	; b0cc
	defb 0a2h,0b3h	; b0ce
	defb 0aah,0b3h	; b0d0
	defb 0b7h,0b3h	; b0d2
	defb 0c3h,0b3h	; b0d4
	defb 0cdh,0b3h	; b0d6
	defb 0d4h,0b3h	; b0d8
	defb 0ddh,0b3h	; b0da
	defb 0ddh,0b3h	; b0dc
	defb 0ddh,0b3h	; b0de
	defb 025h,0b4h	; b0e0
	defb 04dh,0b4h	; b0e2
	defb 093h,0b4h	; b0e4
	defb 0dfh,0b4h	; b0e6
	defb 014h,0b5h	; b0e8
	defb 037h,0b5h	; b0ea
	defb 066h,0b5h	; b0ec
	defb 0afh,0b5h	; b0ee
	defb 0d6h,0b5h	; b0f0
	defb 0fbh,0b5h	; b0f2
	defb 02eh,0b6h	; b0f4
	defb 074h,0b6h	; b0f6
	defb 0beh,0b6h	; b0f8
	defb 0cfh,0b6h	; b0fa
	defb 0f9h,0b6h	; b0fc
	defb 014h,0b7h	; b0fe
	defb 025h,0b7h	; b100
	defb 06ah,0b7h	; b102
	defb 082h,0b7h	; b104

; ----------------------------------------------------------------------
; DATOS mensajes: los mensajes: [direccion en la copia de la tabla de nombres]
;   y caracteres; 0xFE baja una linea (0x20 mas), 0xFF acaba (p02:9512);
;   varios punteros comparten mensaje; lo leen p02:9512 (1722 bytes)
;   0xb106..0xb7c0  (1722 bytes)
DATA_mensajes:
	defb 026h,0eeh,0ceh,0e7h,0c5h,0ech,0d2h,000h,0c3h,0bbh,0d4h,0ech,0cdh,0bfh,0ech,000h	; b106  &...............
	defb 0bbh,0d2h,0cah,0e6h,0feh,0beh,0cdh,0c5h,0c9h,0e0h,000h,054h,055h,026h,002h,001h	; b116  ...........TU&..
	defb 001h,0eeh,0feh,056h,057h,026h,002h,001h,001h,0eeh,058h,059h,026h,003h,001h,0e6h	; b126  ...VW&....XY&...
	defb 000h,0c8h,0e4h,0bdh,0cch,0feh,0c3h,0c3h,0e6h,000h,0beh,0cdh,0c6h,0ech,0e3h,0dfh	; b136  ................
	defb 0efh,0ffh,026h,0eeh,0c9h,0bbh,0e1h,0ebh,0c1h,0e6h,000h,0bfh,0bbh,0d5h,0c1h,0c6h	; b146  ..&.............
	defb 0e2h,0cfh,0d3h,0feh,0dfh,0bch,0c7h,0bbh,0cfh,000h,0bah,0bch,0bfh,0ech,0dfh,0bbh	; b156  ................
	defb 0efh,0ffh,026h,0eeh,0c8h,0c7h,0bbh,0d2h,000h,0beh,0e3h,0bbh,0cdh,0c5h,0cch,054h	; b166  ..&............T
	defb 055h,026h,002h,001h,001h,0eeh,0feh,056h,057h,026h,002h,001h,001h,0eeh,058h,059h	; b176  U&.....VW&....XY
	defb 026h,003h,001h,0e6h,0feh,0dch,0e0h,0bbh,0bch,0c2h,0e2h,0bfh,0ech,0eeh,0dfh,0bbh	; b186  &...............
	defb 0bfh,0ceh,029h,0ffh,026h,0eeh,0c3h,0bbh,0d4h,0ech,0cdh,0d3h,000h,0bbh,0c0h,0bfh	; b196  ..).&...........
	defb 0bdh,0e8h,0c9h,0efh,0feh,0d5h,0c9h,0e1h,000h,0cah,0bfh,0e0h,0e6h,000h,0bah,0e5h	; b1a6  ................
	defb 0c7h,0cch,0eeh,0feh,01ah,00bh,017h,01ah,00fh,01ch,01dh,00fh,0e6h,000h,0cdh,0e1h	; b1b6  ................
	defb 0dch,0cdh,0ech,0c7h,0dfh,0efh,0feh,0c4h,0bah,0eeh,0deh,0c0h,0ceh,0c4h,0bbh,0efh	; b1c6  ................
	defb 0ffh,026h,0eeh,0ceh,0e0h,0d3h,0ech,000h,0d4h,0cdh,0e1h,0cch,0ech,000h,0c9h,0c9h	; b1d6  .&..............
	defb 0bfh,0bch,0d2h,0c9h,0ech,0ceh,0efh,0feh,0c4h,0bah,0eeh,0d3h,0ddh,0c1h,000h,0deh	; b1e6  ................
	defb 0c0h,0ceh,0c4h,0bbh,0efh,0ffh,026h,0eeh,0c0h,0e7h,0bfh,0cdh,000h,0d4h,0c0h,0bfh	; b1f6  ......&.........
	defb 0bdh,0cfh,000h,0dfh,0d2h,000h,0c9h,0bfh,0e0h,0e6h,0feh,0bah,0c9h,0bdh,0cch,0c5h	; b206  ................
	defb 0e7h,0c7h,0ech,0dfh,0bch,0efh,0ffh,026h,0eeh,021h,019h,01ch,016h,00eh,000h,005h	; b216  .......&.!......
	defb 0d6h,0d3h,0feh,0c5h,0ech,0e0h,0bbh,0e6h,000h,0dch,0e8h,0cch,0deh,0c2h,0efh,0ffh	; b226  ................
	defb 026h,0eeh,0dah,0c3h,0bch,0c0h,0ech,0c5h,0cfh,000h,0e5h,0c9h,0e1h,0c9h,0c1h,0d3h	; b236  &...............
	defb 0ech,0eeh,0c2h,0e7h,0cch,0ech,0feh,0bfh,0d6h,0ech,0e6h,000h,0bch,0cah,0c6h,0bdh	; b246  ................
	defb 0e4h,0efh,0ffh,026h,0eeh,00bh,01ah,012h,01ch,019h,00eh,013h,01eh,00fh,0dfh,0eeh	; b256  ...&............
	defb 0d9h,0c6h,0ech,0e6h,0feh,0beh,0c8h,0e3h,0e2h,0ceh,0efh,0ffh,026h,0eeh,0c0h,0dfh	; b266  ............&...
	defb 0c0h,0d9h,0c6h,0ech,0d3h,000h,0bfh,0d6h,0ech,0d2h,000h,0ceh,0bfh,0cfh,000h,0bah	; b276  ................
	defb 0e1h,0efh,0ffh,026h,0eeh,0bfh,0bbh,0c9h,0ech,0e7h,0d2h,000h,0cdh,0cah,0eah,0bch	; b286  ...&............
	defb 0cch,0ech,000h,0bfh,0d6h,0ech,0e6h,0feh,0bch,0cch,0efh,0ffh,026h,0eeh,011h,00bh	; b296  ............&...
	defb 016h,013h,019h,01fh,01dh,0d6h,000h,0bbh,0c9h,0e2h,000h,0dch,0e7h,0bfh,0ech,0feh	; b2a6  ................
	defb 0c5h,0e4h,0d2h,000h,0cdh,0ech,0c3h,0bfh,0cfh,0feh,0bah,0e0h,0e5h,0e3h,0e2h,0cch	; b2b6  ................
	defb 0ech,0bah,0e4h,0bch,0efh,0ffh,026h,0eeh,0bbh,0d8h,0d8h,0cch,0ech,0d2h,000h,0ceh	; b2c6  ......&.........
	defb 0e7h,0c5h,0ech,0d2h,000h,0beh,0c3h,0ceh,0bbh,0d3h,0feh,0dfh,0d2h,000h,0c0h,0beh	; b2d6  ................
	defb 0c1h,0cfh,000h,0cdh,0cdh,0ech,0dbh,0cch,0bah,0e2h,0efh,0feh,0c0h,0beh,0c1h,0e6h	; b2e6  ................
	defb 000h,0dfh,0d4h,0ech,0c4h,0d8h,0c6h,000h,0bah,0e7h,0c3h,0ech,0bch,0e6h,0feh,0c5h	; b2f6  ................
	defb 0e1h,0c9h,0bbh,0bfh,029h,0ffh,0a9h,0eeh,0d3h,0bbh,000h,000h,000h,000h,000h,000h	; b306  ....)...........
	defb 000h,000h,000h,000h,0bbh,0bbh,0bdh,0ffh,026h,0eeh,0bbh,0e8h,0c3h,0c1h,0dch,000h	; b316  ........&.......
	defb 0d3h,0ddh,0c1h,000h,01ah,00bh,017h,01ah,00fh,01ch,01dh,00fh,0e6h,0feh,0c9h,0c6h	; b326  ................
	defb 0c2h,0e2h,0d2h,0c9h,0ech,0efh,0feh,0deh,0c2h,027h,0ffh,086h,0eeh,0beh,0d7h,0ech	; b336  .........'......
	defb 0bdh,0c9h,0bfh,029h,0feh,000h,000h,000h,0d3h,0bbh,0ffh,026h,0eeh,0d8h,0c9h,000h	; b346  ...).......&....
	defb 0bah,0beh,0bch,0efh,0ffh,026h,0eeh,0c9h,0ech,0bbh,0bah,0c1h,0d8h,000h,0bbh,0e8h	; b356  .....&..........
	defb 0d4h,0edh,0c0h,000h,0c9h,0beh,0c6h,0c3h,0ech,0cdh,0cfh,0feh,0c3h,0e3h,0e6h,000h	; b366  ................
	defb 0bah,0c9h,0bdh,0dfh,0bch,0efh,0ffh,026h,0eeh,0c3h,0bbh,0e7h,0bfh,0ech,000h,0c9h	; b376  .......&........
	defb 0e1h,0ceh,0bbh,0c8h,0ech,0efh,0ffh,026h,0eeh,0c5h,0ech,0eah,0dch,0e7h,0d3h,000h	; b386  .......&........
	defb 0d9h,0c6h,0ech,0d2h,0c5h,0c9h,0cfh,0bah,0e4h,0bch,0efh,0ffh,0aeh,0edh,00eh,00fh	; b396  ................
	defb 00bh,01eh,012h,0ffh,0abh,0edh,012h,00fh,01ah,012h,00bh,00fh,01dh,01eh,01fh,01dh	; b3a6  ................
	defb 0ffh,0abh,0edh,00bh,01dh,00dh,016h,00fh,01ah,013h,01fh,01dh,0ffh,0adh,0edh,00eh	; b3b6  ................
	defb 00fh,017h,00fh,01eh,00fh,01ch,0ffh,0aeh,0edh,00bh,01ch,00fh,01dh,0ffh,0adh,0edh	; b3c6  ................
	defb 00bh,01eh,012h,00fh,018h,00bh,0ffh,026h,0eeh,013h,010h,000h,023h,019h,01fh,01ch	; b3d6  .......&....#...
	defb 000h,016h,019h,020h,00fh,01ch,000h,013h,01dh,0feh,015h,013h,016h,016h,00fh,00eh	; b3e6  ... ............
	defb 02bh,00dh,019h,017h,00fh,000h,00ch,00bh,00dh,015h,0feh,012h,00fh,01ch,00fh,000h	; b3f6  +...............
	defb 021h,013h,01eh,012h,000h,054h,055h,026h,002h,001h,001h,02bh,0feh,056h,057h,026h	; b406  !....TU&...+.VW&
	defb 002h,001h,001h,000h,00bh,018h,00eh,000h,058h,059h,026h,003h,001h,02ah,0ffh,026h	; b416  ........XY&..*.&
	defb 0eeh,01dh,00fh,00fh,000h,00bh,000h,010h,00bh,013h,01ch,023h,000h,01eh,019h,0feh	; b426  ...........#....
	defb 01ch,00fh,01dh,01eh,019h,01ch,00fh,000h,023h,019h,01fh,01ch,0feh,020h,013h,01eh	; b436  ........#.... ..
	defb 00bh,016h,013h,01eh,023h,02ah,0ffh,026h,0eeh,011h,013h,020h,00fh,000h,017h,00fh	; b446  ....#*.&... ....
	defb 000h,054h,055h,026h,002h,001h,001h,02bh,0feh,056h,057h,026h,002h,001h,001h,000h	; b456  .TU&...+.VW&....
	defb 00bh,018h,00eh,000h,058h,059h,026h,003h,001h,000h,013h,018h,0feh,01ch,00fh,01eh	; b466  ....XY&.........
	defb 01fh,01ch,018h,000h,010h,019h,01ch,000h,01ch,00fh,020h,013h,020h,013h,018h,011h	; b476  .......... . ...
	defb 0feh,023h,019h,01fh,01ch,000h,016h,019h,020h,00fh,01ch,02ah,0ffh,026h,0eeh,023h	; b486  .#...... ..*.&.#
	defb 019h,01fh,01ch,000h,016h,019h,020h,00fh,01ch,000h,012h,00bh,01dh,0feh,01ch,00fh	; b496  ...... .........
	defb 020h,013h,020h,00fh,00eh,02ah,011h,019h,000h,00bh,018h,00eh,000h,011h,00fh,01eh	; b4a6   . ..*..........
	defb 0feh,00ch,00bh,00dh,015h,000h,01eh,012h,00fh,000h,016h,013h,01eh,01eh,016h,00fh	; b4b6  ................
	defb 000h,00ch,00bh,00ch,023h,0feh,01eh,019h,011h,00fh,01eh,012h,00fh,01ch,02ah,011h	; b4c6  ....#.........*.
	defb 019h,000h,00bh,012h,00fh,00bh,00eh,027h,0ffh,026h,0eeh,01eh,012h,00fh,018h,02bh	; b4d6  .......'.&.....+
	defb 023h,019h,01fh,000h,017h,01fh,01dh,01eh,000h,010h,013h,011h,012h,01eh,0feh,00bh	; b4e6  #...............
	defb 016h,016h,000h,00ch,023h,000h,023h,019h,01fh,01ch,01dh,00fh,016h,010h,02ah,0feh	; b4f6  ....#.#.......*.
	defb 011h,019h,02bh,01ch,013h,011h,012h,01eh,000h,018h,019h,021h,02ah,0ffh,026h,0eeh	; b506  ..+........!*.&.
	defb 023h,019h,01fh,000h,00dh,00bh,018h,000h,00ch,01fh,023h,000h,01dh,019h,017h,00fh	; b516  #.........#.....
	defb 000h,019h,010h,0feh,017h,023h,000h,01eh,01ch,00fh,00bh,01dh,01fh,01ch,00fh,02ah	; b526  .....#.........*
	defb 0ffh,026h,0eeh,01eh,00bh,015h,00fh,000h,00bh,000h,017h,013h,018h,00fh,000h,021h	; b536  .&.............!
	defb 013h,01eh,012h,000h,023h,019h,01fh,0feh,021h,012h,00fh,018h,000h,023h,019h,01fh	; b546  ....#...!....#..
	defb 000h,011h,019h,000h,01eh,019h,0feh,021h,019h,01ch,016h,00eh,000h,005h,02ah,0ffh	; b556  .......!......*.
	defb 026h,0eeh,012h,013h,01eh,000h,01eh,012h,00fh,000h,021h,00bh,016h,016h,000h,021h	; b566  &.........!....!
	defb 013h,01eh,012h,0feh,023h,019h,01fh,01ch,00fh,000h,01dh,021h,019h,01ch,00eh,000h	; b576  ....#......!....
	defb 013h,010h,000h,023h,019h,01fh,0feh,021h,00bh,018h,01eh,000h,01eh,019h,000h,011h	; b586  ...#...!........
	defb 019h,000h,01eh,019h,000h,01eh,012h,00fh,0feh,019h,01ah,01ah,019h,01dh,013h,01eh	; b596  ................
	defb 00fh,000h,01dh,012h,019h,01ch,00fh,02ah,0ffh,026h,0eeh,00bh,01ah,012h,01ch,019h	; b5a6  .......*.&......
	defb 00eh,013h,01eh,00fh,02ah,00eh,019h,000h,018h,019h,01eh,000h,00ch,00fh,0feh,00bh	; b5b6  ....*...........
	defb 010h,01ch,00bh,013h,00eh,000h,019h,010h,000h,021h,00bh,01eh,00fh,01ch,02ah,0ffh	; b5c6  .........!....*.
	defb 026h,0eeh,01eh,012h,00fh,000h,01ah,01fh,01ch,00fh,000h,021h,00bh,01eh,00fh,01ch	; b5d6  &..........!....
	defb 000h,013h,01dh,0feh,013h,018h,01dh,013h,00eh,00fh,000h,01eh,012h,00fh,000h,021h	; b5e6  ...............!
	defb 00bh,016h,016h,02ah,0ffh,026h,0eeh,012h,013h,01eh,000h,01eh,012h,00fh,000h,021h	; b5f6  ...*.&.........!
	defb 00bh,016h,016h,000h,021h,012h,00fh,018h,0feh,023h,019h,01fh,000h,00bh,01ch,00fh	; b606  ....!....#......
	defb 000h,012h,00bh,016h,010h,021h,00bh,023h,000h,019h,010h,0feh,01eh,012h,00fh,000h	; b616  .....!.#........
	defb 01dh,01eh,00bh,013h,01ch,01dh,02ah,0ffh,026h,0eeh,00bh,000h,011h,00bh,01eh,00fh	; b626  ......*.&.......
	defb 000h,021h,012h,013h,00dh,012h,000h,016h,00fh,00bh,01ch,00eh,01dh,0feh,01eh,019h	; b636  .!..............
	defb 000h,011h,00bh,016h,013h,019h,01fh,01dh,000h,021h,013h,016h,016h,0feh,00bh,01ah	; b646  .........!......
	defb 01ah,00fh,00bh,01ch,000h,01dh,019h,017h,00fh,021h,012h,00fh,01ch,00fh,000h,013h	; b656  .........!......
	defb 018h,0feh,01eh,012h,00fh,000h,00dh,00bh,01dh,01eh,016h,00fh,02ah,0ffh,026h,0eeh	; b666  ............*.&.
	defb 023h,019h,01fh,000h,021h,00bh,018h,01eh,000h,01eh,012h,00fh,000h,01dh,00fh,00dh	; b676  #...!...........
	defb 01ch,00fh,01eh,0feh,00dh,019h,00eh,00fh,000h,01eh,019h,000h,021h,00bh,015h,00fh	; b686  ............!...
	defb 018h,0feh,017h,023h,000h,017h,00fh,017h,019h,01ch,023h,000h,015h,00fh,00fh,01ah	; b696  ...#......#.....
	defb 000h,01eh,012h,00fh,0feh,01ch,00fh,00dh,019h,01ch,00eh,01dh,000h,00bh,00ch,019h	; b6a6  ................
	defb 01fh,01eh,000h,023h,019h,01fh,029h,0ffh,0a9h,0eeh,023h,00fh,01dh,000h,000h,000h	; b6b6  ...#..)...#.....
	defb 000h,000h,000h,000h,000h,000h,018h,019h,0ffh,026h,0eeh,01ch,00fh,01dh,00dh,01fh	; b6c6  .........&......
	defb 00fh,000h,01eh,012h,00fh,000h,00ch,00bh,00ch,023h,000h,00bh,01dh,0feh,01bh,01fh	; b6d6  .........#......
	defb 013h,00dh,015h,016h,023h,000h,00bh,01dh,000h,01ah,019h,01dh,01dh,013h,00ch,016h	; b6e6  ....#...........
	defb 00fh,02ah,0ffh,086h,0eeh,00eh,013h,00eh,000h,023h,019h,01fh,000h,011h,00fh,01eh	; b6f6  .*.......#......
	defb 000h,01eh,012h,00fh,017h,029h,0feh,000h,000h,000h,023h,00fh,01dh,0ffh,026h,0eeh	; b706  .....)....#...&.
	defb 01dh,00fh,00fh,000h,023h,019h,01fh,000h,00bh,011h,00bh,013h,018h,02ah,0ffh,026h	; b716  ....#........*.&
	defb 0eeh,023h,019h,01fh,000h,01dh,012h,00bh,016h,016h,000h,012h,00bh,020h,00fh,000h	; b726  .#........... ..
	defb 01dh,019h,017h,00fh,0feh,00ch,01ch,00fh,00bh,00eh,000h,00bh,018h,00eh,000h,021h	; b736  ...............!
	defb 00bh,01eh,00fh,01ch,02ah,0feh,00fh,020h,00fh,01ch,023h,01eh,013h,017h,00fh,000h	; b746  ....*.. ..#.....
	defb 023h,019h,01fh,000h,00eh,00fh,010h,00dh,00bh,01eh,0feh,00bh,000h,00eh,00fh,020h	; b756  #..............
	defb 013h,016h,02ah,0ffh,026h,0eeh,00dh,019h,013h,018h,01dh,000h,00bh,01ch,00fh,000h	; b766  ..*.&...........
	defb 018h,019h,01eh,0feh,00fh,018h,019h,01fh,011h,012h,02ah,0ffh,026h,0eeh,010h,013h	; b776  ..........*.&...
	defb 018h,00eh,000h,01eh,012h,00fh,000h,01dh,01ah,00fh,016h,016h,0feh,021h,01ch,013h	; b786  .............!..
	defb 01eh,01eh,00fh,018h,000h,019h,018h,000h,00bh,000h,01dh,01eh,019h,018h,00fh,0feh	; b796  ................
	defb 017h,019h,018h,01fh,017h,00fh,018h,01eh,000h,01fh,018h,00eh,00fh,01ch,000h,01eh	; b7a6  ................
	defb 012h,00fh,0feh,021h,00bh,01eh,00fh,01ch,02ah,0ffh	; b7b6  ...!....*.

; ======================================================================
; CODIGO 0xb7c0..0xb860  (160 bytes)
; ======================================================================


L_B7C0:
	call L_B810		;b7c0
	ld a,0bfh		;b7c3
	ld (0f02bh),a		;b7c5
	call L_B81C		;b7c8
	call L_B7E3		;b7cb
	call L_B83B		;b7ce
	xor a			;b7d1
	ld (0f02fh),a		;b7d2
	ld (0f01fh),a		;b7d5
	ld (0f022h),a		;b7d8
	ld (0f031h),a		;b7db
	inc a			;b7de
	ld (0f026h),a		;b7df
	ret			;b7e2
L_B7E3:
	call L_B7F2		;b7e3
	ld hl,0bae1h		;b7e6
L_B7E9:
	ld de,0eca8h		;b7e9
	ld bc,00008h		;b7ec
	ldir		;b7ef
	ret			;b7f1
L_B7F2:
	ld bc,00460h		;b7f2
	ld hl,0ec80h		;b7f5   ; apunta a la copia de la tabla de sprites (128 bytes)
	ld de,0baf1h		;b7f8
L_B7FB:
	ld a,040h		;b7fb
	ld (hl),a			;b7fd
	inc hl			;b7fe
	ld (hl),c			;b7ff
	inc hl			;b800
	ld a,010h		;b801
	add a,c			;b803
	ld c,a			;b804
	ld a,(de)			;b805
	ld (hl),a			;b806
	inc de			;b807
	inc hl			;b808
	ld a,001h		;b809
	ld (hl),a			;b80b
	inc hl			;b80c
	djnz L_B7FB		;b80d
	ret			;b80f
L_B810:
	ld de,0ed86h		;b810
	ld hl,0b989h		;b813
	ld bc,00e14h		;b816
	jp 0408fh		;b819
L_B81C:
	ld hl,01e00h		;b81c
	ld a,0ffh		;b81f
	ld bc,00008h		;b821
	call 00056h		;b824   ; BIOS FILVRM - Fills VRAM with value
	ld hl,0b97bh		;b827
	ld de,0ec90h		;b82a
	ld b,004h		;b82d
L_B82F:
	push hl			;b82f
	push bc			;b830
	ld bc,00004h		;b831
	ldir		;b834
	pop bc			;b836
	pop hl			;b837
	djnz L_B82F		;b838
	ret			;b83a
L_B83B:
	ld hl,0baf5h		;b83b
	ld de,0eca0h		;b83e
	ld bc,00008h		;b841
	ldir		;b844
	ret			;b846
L_B847:
	ld a,(0f031h)		;b847
	or a			;b84a
	jr z,L_B85A		;b84b
	ld a,(0e003h)		;b84d   ; lee el contador de cuadros
	bit 0,a		;b850
	jr nz,L_B85A		;b852
	ld hl,0f02bh		;b854
	dec (hl)			;b857
	jr z,$+16		;b858
L_B85A:
	ld a,(0f031h)		;b85a
	call 04050h		;b85d   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_B860: 4 destinos del despachador de 0x4140 (call en p15:B85D):
;   0xB925, 0xB8D0, 0xB86D, 0xB890; lo leen p15:B85D (8 bytes)
;   0xb860..0xb868  (8 bytes)
DATA_tabla_B860:
	defb 025h,0b9h	; b860
	defb 0d0h,0b8h	; b862
	defb 06dh,0b8h	; b864
	defb 090h,0b8h	; b866

; ======================================================================
; CODIGO 0xb868..0xb97b  (275 bytes)
; ======================================================================


L_B868:
	xor a			;b868
	ld (0e608h),a		;b869   ; guarda un paso de varios cuadros en marcha
	ret			;b86c
L_B86D:
	ld a,(0e003h)		;b86d   ; lee el contador de cuadros
	and 003h		;b870
	ret nz			;b872
	ld hl,0eca0h		;b873
	ld a,(hl)			;b876
	dec a			;b877
	cp 05fh		;b878
	jp c,L_B883		;b87a
	ld (hl),a			;b87d
	ld hl,0eca4h		;b87e
	ld (hl),a			;b881
	ret			;b882
L_B883:
	ld a,001h		;b883
	ld (0f032h),a		;b885
	ld a,040h		;b888
	ld (0f02ch),a		;b88a
	jp L_B963		;b88d
L_B890:
	ld hl,0f02ch		;b890
	dec (hl)			;b893
	jr nz,L_B89A		;b894
	xor a			;b896
	ld (0f032h),a		;b897
L_B89A:
	call L_B905		;b89a
	ld a,(0f032h)		;b89d
	or a			;b8a0
	ret nz			;b8a1
	ld a,(0e003h)		;b8a2   ; lee el contador de cuadros
	and 03fh		;b8a5
	ret nz			;b8a7
	ld a,r		;b8a8
	ld hl,0baa1h		;b8aa
	bit 0,a		;b8ad
	jr z,L_B8B4		;b8af
	ld hl,0bac1h		;b8b1
L_B8B4:
	ld de,0eea3h		;b8b4
	ld bc,00207h		;b8b7
	call 0408fh		;b8ba
	ld de,0ee95h		;b8bd
	ld bc,00208h		;b8c0
	call 0408fh		;b8c3
	ld a,(hl)			;b8c6
	ld (0eee5h),a		;b8c7
	inc hl			;b8ca
	ld a,(hl)			;b8cb
	ld (0eedah),a		;b8cc
	ret			;b8cf
L_B8D0:
	ld a,(0e003h)		;b8d0   ; lee el contador de cuadros
	and 003h		;b8d3
	ret nz			;b8d5
	ld a,(0f02fh)		;b8d6
	or a			;b8d9
	jr nz,L_B8F5		;b8da
	ld a,0ffh		;b8dc
	ld (0f02bh),a		;b8de
	ld hl,0eca8h		;b8e1
	ld a,(hl)			;b8e4
	inc a			;b8e5
	cp 03fh		;b8e6
	jr c,L_B8FF		;b8e8
	ld hl,0bae9h		;b8ea
	call L_B7E9		;b8ed
	ld hl,0f02fh		;b8f0
	inc (hl)			;b8f3
	ret			;b8f4
L_B8F5:
	ld hl,0eca8h		;b8f5
	ld a,(hl)			;b8f8
	dec a			;b8f9
	cp 02eh		;b8fa
	jp c,L_B963		;b8fc
L_B8FF:
	ld (hl),a			;b8ff
	ld hl,0ecach		;b900
	ld (hl),a			;b903
	ret			;b904
L_B905:
	ld a,(0e003h)		;b905   ; lee el contador de cuadros
	and 00fh		;b908
	ret nz			;b90a
	ld hl,0f01fh		;b90b
	inc (hl)			;b90e
	bit 0,(hl)		;b90f
	jr nz,L_B920		;b911
	ld hl,0b985h		;b913
L_B916:
	ld a,(hl)			;b916
	inc hl			;b917
	ld (0eeadh),a		;b918
	ld a,(hl)			;b91b
	ld (0eeb2h),a		;b91c
	ret			;b91f
L_B920:
	ld hl,0b987h		;b920
	jr L_B916		;b923
L_B925:
	ld hl,0f02bh		;b925
	dec (hl)			;b928
	jr z,L_B960		;b929
	ld a,(0f022h)		;b92b
	or a			;b92e
	jr nz,L_B968		;b92f
	ld a,(0e003h)		;b931   ; lee el contador de cuadros
	and 00fh		;b934
	ret nz			;b936
	ld hl,0f023h		;b937
	inc (hl)			;b93a
	ld hl,0ecb0h		;b93b
	ld a,02bh		;b93e
	ld (hl),a			;b940
	inc hl			;b941
	ld de,0b97fh		;b942
	ld a,(0f023h)		;b945
	and 001h		;b948
	call 04065h		;b94a   ; de_mas_a (por 0x4065): DE += A
	ld a,(de)			;b94d
	ld (hl),a			;b94e
	inc hl			;b94f
	ld a,018h		;b950
	ld (hl),a			;b952
	inc hl			;b953
	ld a,00fh		;b954
	ld (hl),a			;b956
	xor a			;b957
	ld (0f030h),a		;b958
	inc a			;b95b
	ld (0f022h),a		;b95c
	ret			;b95f
L_B960:
	call L_B970		;b960
L_B963:
	ld hl,0f031h		;b963
	inc (hl)			;b966
	ret			;b967
L_B968:
	ld a,(0e003h)		;b968   ; lee el contador de cuadros
	and 007h		;b96b
	ret nz			;b96d
	jr L_B970		;b96e
L_B970:
	ld hl,0ecb0h		;b970
	ld a,0d0h		;b973
	ld (hl),a			;b975
	xor a			;b976
	ld (0f022h),a		;b977
	ret			;b97a

; ----------------------------------------------------------------------
; DATOS atributos_b97b: 4 bytes de atributos de sprite que p15:B827 copia
;   cuatro veces a 0xEC90 (los mismos 4 en los cuatro)
;   0xb97b..0xb97f  (4 bytes)
DATA_atributos_b97b:
	defb 06fh,078h,0c0h,000h	; b97b

; ----------------------------------------------------------------------
; DATOS dos_dibujos_b97f: dos numeros de dibujo de sprite; p15:B942 coge el
;   bit 0 de 0xF023 y pone uno de los dos en 0xECB1
;   0xb97f..0xb981  (2 bytes)
DATA_dos_dibujos_b97f:
	defb 060h,090h	; b97f

; ----------------------------------------------------------------------
; DATOS sin_nombrar_b981: 4 bytes (1C 08 20 0A) entre las tablas de la escena
;   que ninguna instruccion nombra (los de alrededor si); no estan medidos en
;   openMSX
;   0xb981..0xb985  (4 bytes)
DATA_sin_nombrar_b981:
	defb 01ch,008h,020h,00ah	; b981

; ----------------------------------------------------------------------
; DATOS parejas_b985: dos parejas de caracteres que p15:B913 y p15:B920 ponen
;   en 0xEEAD y 0xEEB2 por turnos (bit 0 de 0xF01F)
;   0xb985..0xb989  (4 bytes)
DATA_parejas_b985:
	defb 074h,07bh	; b985
	defb 075h,07ch	; b987

; ----------------------------------------------------------------------
; DATOS recuadro_de_20x14: un recuadro de 20 x 14 caracteres que p15:B810
;   copia por filas a 0xED86 con 0x408F (p01:6D49)
;   0xb989..0xbaa1  (280 bytes)
DATA_recuadro_de_20x14:
	defb 0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h	; b989  ....................
	defb 0d6h,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,05dh,0d6h	; b99d  .]]]]]]]]]]]]]]]]]].
	defb 0dah,05dh,05eh,05fh,05dh,05dh,05dh,05dh,05dh,05ah,05ch,05dh,05dh,05dh,05dh,05dh,05eh,05fh,05dh,0dah	; b9b1  .]^_]]]]]Z\]]]]]^_].
	defb 0deh,05dh,060h,061h,05eh,05fh,05dh,05dh,05dh,05bh,05dh,05dh,05dh,05dh,05eh,05fh,060h,061h,05dh,0deh	; b9c5  .]`a^_]]][]]]]^_`a].
	defb 0d2h,05dh,062h,063h,060h,061h,0a7h,0a8h,0aah,064h,065h,0c6h,0c4h,0c3h,060h,061h,062h,063h,05dh,0d2h	; b9d9  .]bc`a...de...`abc].
	defb 0d6h,05dh,06eh,0b8h,062h,063h,0ach,0a9h,0adh,067h,068h,0c9h,0c5h,0c8h,062h,063h,09ch,069h,05dh,0d6h	; b9ed  .]n.bc...gh...bc.i].
	defb 0dah,0c7h,072h,0b7h,06eh,069h,0cah,0cah,0a5h,09dh,0b9h,0c1h,0aeh,0aeh,06eh,069h,09bh,06bh,0abh,0dah	; ba01  ..r.ni........ni.k..
	defb 0deh,097h,06dh,097h,072h,06bh,0bfh,0a2h,0a4h,000h,000h,0c0h,0beh,0a3h,072h,06bh,0b3h,06ch,0b3h,0deh	; ba15  ..m.rk........rk.l..
	defb 0d2h,098h,070h,098h,06dh,06ch,09eh,0a1h,076h,0bdh,0a6h,07ah,0c2h,0bah,06dh,06ch,0b4h,070h,0b4h,0d2h	; ba29  ..p.ml..v..z..ml.p..
	defb 0d6h,0b5h,06fh,0b5h,073h,06ah,09fh,074h,078h,077h,079h,07dh,07bh,0bbh,073h,06ah,099h,06fh,099h,0d6h	; ba3d  ..o.sj.txwy}{.sj.o..
	defb 0dah,0afh,0bch,09ah,073h,06ah,071h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,073h,06ah,0b6h,0a0h,0cbh,0dah	; ba51  ....sjq.......sj....
	defb 0deh,0f0h,080h,0afh,073h,06ah,080h,066h,066h,080h,066h,080h,066h,066h,073h,06ah,0cbh,080h,0f0h,0deh	; ba65  ....sj.ff.f.ffsj....
	defb 0d2h,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh,0d2h	; ba79  ..~.~.~.~.~.~.~.~.~.
	defb 0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h,0d2h,0d3h,0d4h,0d5h	; ba8d  ....................

; ----------------------------------------------------------------------
; DATOS dos_variantes: dos variantes de 32 bytes (p15:B8AA o B8B1, al azar con
;   R): 2 filas de 7 caracteres a 0xEEA3, 2 de 8 a 0xEE95 y dos bytes que van
;   a 0xEEE5 y 0xEEDA
;   0xbaa1..0xbae1  (64 bytes)
DATA_dos_variantes:
	defb 0cch,08dh,08eh,08fh,090h,091h,0b0h,0cdh,092h,093h,094h,095h,096h,0b1h,06ch,0b4h	; baa1  ..............l.
	defb 070h,0b4h,0d2h,000h,000h,000h,06ah,099h,06fh,099h,0d6h,000h,000h,000h,0ceh,000h	; bab1  p.....j.o.......
	defb 000h,000h,000h,0d6h,0b5h,06fh,0b5h,000h,000h,000h,0dah,0afh,0bch,09ah,0cch,081h	; bac1  .....o..........
	defb 082h,083h,084h,085h,086h,0b0h,0cdh,087h,088h,089h,08ah,08bh,08ch,0b1h,000h,0b2h	; bad1  ................

; ----------------------------------------------------------------------
; DATOS sprites_bae1: 8 bytes de atributos de sprite que p15:B7E6 copia a
;   0xECA8
;   0xbae1..0xbae9  (8 bytes)
DATA_sprites_bae1:
	defb 02eh,080h,008h,001h,02eh,080h,00ch,008h	; bae1  ........

; ----------------------------------------------------------------------
; DATOS sprites_bae9: 8 bytes de atributos de sprite que p15:B8EA copia a
;   0xECA8 (p15:B7E9)
;   0xbae9..0xbaf1  (8 bytes)
DATA_sprites_bae9:
	defb 03fh,080h,010h,004h,03fh,080h,014h,00fh	; bae9  ?...?...

; ----------------------------------------------------------------------
; DATOS cuatro_dibujos: 4 numeros de dibujo que p15:B7F8 reparte en 0xEC80
;   (uno por sprite)
;   0xbaf1..0xbaf5  (4 bytes)
DATA_cuatro_dibujos:
	defb 020h,01ch,024h,028h	; baf1

; ----------------------------------------------------------------------
; DATOS sprites_baf5: 8 bytes de atributos de sprite que p15:B83B copia a
;   0xECA0
;   0xbaf5..0xbafd  (8 bytes)
DATA_sprites_baf5:
	defb 06bh,078h,000h,00bh,06bh,078h,004h,00fh	; baf5  kx..kx..

; ----------------------------------------------------------------------
; DATOS tabla_de_demos: dos punteros, uno por demo (0xE023 = 0 o 1, p01:7E3B)
;   0xbafd..0xbb01  (4 bytes)
DATA_tabla_de_demos:
	defb 001h,0bbh	; bafd
	defb 0bfh,0bbh	; baff

; ----------------------------------------------------------------------
; DATOS demo_0: la demo 0: parejas [cuadros][teclas] que p01:7E49 y p01:7E4E
;   van poniendo en 0xE00C y 0xE022; 0xFF en las teclas la acaba (p01:7E2B).
;   95 parejas
;   0xbb01..0xbbbf  (190 bytes)
DATA_demo_0:
	defb 012h,000h	; bb01
	defb 004h,004h	; bb03
	defb 058h,000h	; bb05
	defb 00ah,001h	; bb07
	defb 081h,000h	; bb09
	defb 001h,001h	; bb0b
	defb 009h,005h	; bb0d
	defb 004h,015h	; bb0f
	defb 003h,005h	; bb11
	defb 003h,015h	; bb13
	defb 002h,005h	; bb15
	defb 003h,015h	; bb17
	defb 002h,005h	; bb19
	defb 003h,015h	; bb1b
	defb 002h,005h	; bb1d
	defb 004h,015h	; bb1f
	defb 001h,005h	; bb21
	defb 001h,004h	; bb23
	defb 009h,000h	; bb25
	defb 008h,008h	; bb27
	defb 006h,000h	; bb29
	defb 006h,004h	; bb2b
	defb 004h,014h	; bb2d
	defb 003h,004h	; bb2f
	defb 002h,014h	; bb31
	defb 002h,004h	; bb33
	defb 003h,014h	; bb35
	defb 003h,004h	; bb37
	defb 003h,014h	; bb39
	defb 002h,004h	; bb3b
	defb 004h,014h	; bb3d
	defb 002h,004h	; bb3f
	defb 008h,000h	; bb41
	defb 008h,004h	; bb43
	defb 00dh,000h	; bb45
	defb 001h,004h	; bb47
	defb 011h,005h	; bb49
	defb 040h,004h	; bb4b
	defb 004h,010h	; bb4d
	defb 003h,000h	; bb4f
	defb 001h,010h	; bb51
	defb 002h,000h	; bb53
	defb 002h,010h	; bb55
	defb 003h,000h	; bb57
	defb 002h,010h	; bb59
	defb 002h,000h	; bb5b
	defb 002h,010h	; bb5d
	defb 003h,000h	; bb5f
	defb 001h,010h	; bb61
	defb 003h,000h	; bb63
	defb 002h,010h	; bb65
	defb 003h,000h	; bb67
	defb 002h,010h	; bb69
	defb 001h,000h	; bb6b
	defb 014h,004h	; bb6d
	defb 003h,014h	; bb6f
	defb 002h,004h	; bb71
	defb 001h,000h	; bb73
	defb 002h,010h	; bb75
	defb 002h,000h	; bb77
	defb 002h,010h	; bb79
	defb 003h,000h	; bb7b
	defb 002h,010h	; bb7d
	defb 002h,000h	; bb7f
	defb 002h,010h	; bb81
	defb 006h,000h	; bb83
	defb 0c8h,004h	; bb85
	defb 004h,020h	; bb87
	defb 003h,000h	; bb89
	defb 002h,020h	; bb8b
	defb 002h,000h	; bb8d
	defb 002h,020h	; bb8f
	defb 009h,000h	; bb91
	defb 031h,004h	; bb93
	defb 01ch,002h	; bb95
	defb 002h,006h	; bb97
	defb 063h,004h	; bb99
	defb 00fh,000h	; bb9b
	defb 005h,004h	; bb9d
	defb 00dh,000h	; bb9f
	defb 01ch,004h	; bba1
	defb 00eh,005h	; bba3
	defb 00eh,004h	; bba5
	defb 003h,014h	; bba7
	defb 003h,000h	; bba9
	defb 003h,010h	; bbab
	defb 002h,000h	; bbad
	defb 003h,010h	; bbaf
	defb 003h,000h	; bbb1
	defb 003h,010h	; bbb3
	defb 009h,000h	; bbb5
	defb 008h,004h	; bbb7
	defb 00ch,005h	; bbb9
	defb 01eh,004h	; bbbb
	defb 001h,0ffh	; bbbd

; ----------------------------------------------------------------------
; DATOS demo_1: la demo 1, con el mismo formato: 125 parejas
;   0xbbbf..0xbcb9  (250 bytes)
DATA_demo_1:
	defb 041h,000h	; bbbf
	defb 01ch,008h	; bbc1
	defb 00ah,009h	; bbc3
	defb 005h,029h	; bbc5
	defb 002h,009h	; bbc7
	defb 00bh,000h	; bbc9
	defb 008h,008h	; bbcb
	defb 001h,00ch	; bbcd
	defb 006h,004h	; bbcf
	defb 001h,006h	; bbd1
	defb 01ch,002h	; bbd3
	defb 003h,000h	; bbd5
	defb 01ah,002h	; bbd7
	defb 002h,00ah	; bbd9
	defb 006h,008h	; bbdb
	defb 003h,010h	; bbdd
	defb 003h,000h	; bbdf
	defb 002h,010h	; bbe1
	defb 004h,000h	; bbe3
	defb 003h,010h	; bbe5
	defb 004h,000h	; bbe7
	defb 002h,010h	; bbe9
	defb 009h,000h	; bbeb
	defb 03eh,008h	; bbed
	defb 007h,000h	; bbef
	defb 006h,004h	; bbf1
	defb 004h,024h	; bbf3
	defb 004h,004h	; bbf5
	defb 002h,024h	; bbf7
	defb 003h,004h	; bbf9
	defb 003h,024h	; bbfb
	defb 00ah,004h	; bbfd
	defb 003h,024h	; bbff
	defb 030h,004h	; bc01
	defb 001h,000h	; bc03
	defb 014h,008h	; bc05
	defb 002h,000h	; bc07
	defb 00eh,004h	; bc09
	defb 007h,000h	; bc0b
	defb 016h,008h	; bc0d
	defb 003h,000h	; bc0f
	defb 003h,020h	; bc11
	defb 004h,000h	; bc13
	defb 002h,020h	; bc15
	defb 001h,028h	; bc17
	defb 066h,008h	; bc19
	defb 005h,009h	; bc1b
	defb 01ah,000h	; bc1d
	defb 050h,008h	; bc1f
	defb 008h,000h	; bc21
	defb 003h,010h	; bc23
	defb 004h,000h	; bc25
	defb 002h,010h	; bc27
	defb 004h,000h	; bc29
	defb 002h,010h	; bc2b
	defb 004h,000h	; bc2d
	defb 002h,010h	; bc2f
	defb 003h,000h	; bc31
	defb 003h,010h	; bc33
	defb 010h,000h	; bc35
	defb 003h,010h	; bc37
	defb 005h,000h	; bc39
	defb 004h,010h	; bc3b
	defb 007h,000h	; bc3d
	defb 015h,008h	; bc3f
	defb 002h,000h	; bc41
	defb 003h,010h	; bc43
	defb 004h,000h	; bc45
	defb 004h,010h	; bc47
	defb 005h,000h	; bc49
	defb 004h,010h	; bc4b
	defb 004h,000h	; bc4d
	defb 001h,010h	; bc4f
	defb 00bh,000h	; bc51
	defb 00ch,008h	; bc53
	defb 008h,000h	; bc55
	defb 004h,010h	; bc57
	defb 005h,000h	; bc59
	defb 004h,010h	; bc5b
	defb 005h,000h	; bc5d
	defb 004h,010h	; bc5f
	defb 005h,000h	; bc61
	defb 004h,010h	; bc63
	defb 006h,000h	; bc65
	defb 003h,010h	; bc67
	defb 005h,000h	; bc69
	defb 003h,010h	; bc6b
	defb 012h,000h	; bc6d
	defb 02dh,008h	; bc6f
	defb 040h,002h	; bc71
	defb 001h,000h	; bc73
	defb 010h,008h	; bc75
	defb 012h,004h	; bc77
	defb 008h,000h	; bc79
	defb 003h,010h	; bc7b
	defb 006h,000h	; bc7d
	defb 004h,010h	; bc7f
	defb 005h,000h	; bc81
	defb 004h,010h	; bc83
	defb 014h,000h	; bc85
	defb 015h,004h	; bc87
	defb 018h,000h	; bc89
	defb 003h,010h	; bc8b
	defb 005h,000h	; bc8d
	defb 003h,010h	; bc8f
	defb 005h,000h	; bc91
	defb 003h,010h	; bc93
	defb 004h,000h	; bc95
	defb 004h,010h	; bc97
	defb 009h,000h	; bc99
	defb 00bh,004h	; bc9b
	defb 004h,010h	; bc9d
	defb 003h,000h	; bc9f
	defb 003h,010h	; bca1
	defb 004h,000h	; bca3
	defb 005h,010h	; bca5
	defb 00ah,000h	; bca7
	defb 009h,008h	; bca9
	defb 013h,009h	; bcab
	defb 005h,008h	; bcad
	defb 006h,000h	; bcaf
	defb 006h,004h	; bcb1
	defb 001h,000h	; bcb3
	defb 027h,001h	; bcb5
	defb 001h,0ffh	; bcb7

; ======================================================================
; CODIGO 0xbcb9..0xbcd5  (28 bytes)
; ======================================================================


L_BCB9:
	ld bc,(0e041h)		;bcb9   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;bcbd
	ld hl,0bcd3h		;bcbe
	call 04053h		;bcc1   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ex de,hl			;bcc4
L_BCC5:
	ld a,(hl)			;bcc5
	or a			;bcc6
	ret z			;bcc7
	cp b			;bcc8
	jr z,L_BCCF		;bcc9
	inc hl			;bccb
	jp L_BCC5		;bccc
L_BCCF:
	ld a,001h		;bccf
	ld (0e617h),a		;bcd1
	ret			;bcd4

; ----------------------------------------------------------------------
; DATOS tabla_bcd3: 11 punteros, uno por mapa (p15:BCBE lee 0xBCD3; la palabra
;   0 son los dos ultimos bytes del codigo), a listas de salas en las que
;   p15:BCC5 pone 0xE617 a 1
;   0xbcd5..0xbceb  (22 bytes)
DATA_tabla_bcd3:
	defb 0ebh,0bch	; bcd5
	defb 0f4h,0bch	; bcd7
	defb 0f5h,0bch	; bcd9
	defb 0f8h,0bch	; bcdb
	defb 0fbh,0bch	; bcdd
	defb 0fdh,0bch	; bcdf
	defb 0f4h,0bch	; bce1
	defb 0f3h,0bch	; bce3
	defb 0f4h,0bch	; bce5
	defb 0f4h,0bch	; bce7
	defb 0f4h,0bch	; bce9

; ----------------------------------------------------------------------
; DATOS salas_e617: las listas de 0xBCD3, acabadas en 0, compartidas por
;   varios mapas (castillo: 137-143)
;   0xbceb..0xbd06  (27 bytes)
DATA_salas_e617:
	defb 089h,08ah,08bh,08ch,08dh,08eh,08fh,000h,00bh,000h,009h,00bh,000h,005h,00dh,000h	; bceb  ................
	defb 011h,000h,007h,008h,009h,00ah,00bh,00ch,00dh,012h,000h	; bcfb  ...........

; ======================================================================
; CODIGO 0xbd06..0xbd74  (110 bytes)
; ======================================================================


L_BD06:
	ld a,(0e617h)		;bd06
	and a			;bd09
	ret z			;bd0a
	ld hl,0e618h		;bd0b
	inc (hl)			;bd0e
	ld hl,02db5h		;bd0f
	ld b,003h		;bd12
	call L_BD3E		;bd14
	ld a,(0e618h)		;bd17
	and 001h		;bd1a
	ret nz			;bd1c
	ld hl,02db3h		;bd1d
	ld b,002h		;bd20
	call L_BD3E		;bd22
	ld a,(0e618h)		;bd25
	and 003h		;bd28
	ret nz			;bd2a
	ld hl,02db1h		;bd2b
	ld b,002h		;bd2e
	call L_BD3E		;bd30
	ld a,(0e618h)		;bd33
	and 007h		;bd36
	ret nz			;bd38
	ld hl,02db0h		;bd39
	ld b,001h		;bd3c
L_BD3E:
	ld c,002h		;bd3e
	push hl			;bd40
L_BD41:
	push hl			;bd41
	call 0004ah		;bd42   ; BIOS RDVRM - Reads the content of VRAM
	pop hl			;bd45
	rlca			;bd46
	push hl			;bd47
	call 0004dh		;bd48   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;bd4b
	ld de,00800h		;bd4c
	add hl,de			;bd4f
	dec c			;bd50
	jr nz,L_BD41		;bd51
	pop hl			;bd53
	inc hl			;bd54
	djnz L_BD3E		;bd55
	ret			;bd57
L_BD58:
	ld bc,(0e041h)		;bd58   ; lee el mapa (0xE041) y la sala (0xE042) de un tiron
	ld a,c			;bd5c
	ld hl,0bd72h		;bd5d
	call 04053h		;bd60   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ex de,hl			;bd63
L_BD64:
	ld a,(hl)			;bd64
	or a			;bd65
	ret z			;bd66
	cp b			;bd67
	jr z,L_BD6E		;bd68
	inc hl			;bd6a
	jp L_BD64		;bd6b
L_BD6E:
	ld a,001h		;bd6e
	ld (0e619h),a		;bd70
	ret			;bd73

; ----------------------------------------------------------------------
; DATOS tabla_bd72: 11 punteros, uno por mapa (p15:BD5D; la palabra 0 son los
;   dos ultimos bytes del codigo), a listas de salas en las que p15:BD64 pone
;   0xE619 a 1
;   0xbd74..0xbd8a  (22 bytes)
DATA_tabla_bd72:
	defb 08ah,0bdh	; bd74
	defb 09bh,0bdh	; bd76
	defb 09bh,0bdh	; bd78
	defb 09bh,0bdh	; bd7a
	defb 09bh,0bdh	; bd7c
	defb 09bh,0bdh	; bd7e
	defb 09bh,0bdh	; bd80
	defb 09bh,0bdh	; bd82
	defb 090h,0bdh	; bd84
	defb 097h,0bdh	; bd86
	defb 09ch,0bdh	; bd88

; ----------------------------------------------------------------------
; DATOS salas_e619: las listas de 0xBD72, acabadas en 0 (castillo: 96 y
;   144-147)
;   0xbd8a..0xbda1  (23 bytes)
DATA_salas_e619:
	defb 060h,090h,091h,092h,093h,000h,00fh,010h,011h,012h,013h,014h,000h,002h,003h,004h	; bd8a  `...............
	defb 005h,000h,001h,002h,003h,004h,000h	; bd9a

; ======================================================================
; CODIGO 0xbda1..0xbdce  (45 bytes)
; ======================================================================


L_BDA1:
	ld a,(0e619h)		;bda1
	and a			;bda4
	ret z			;bda5
	ld a,(0e003h)		;bda6   ; lee el contador de cuadros
	and 003h		;bda9
	ret nz			;bdab
	ld hl,0e61ah		;bdac
	inc (hl)			;bdaf
	ld a,(hl)			;bdb0
	cp 00ah		;bdb1
	jr nz,L_BDB7		;bdb3
	xor a			;bdb5
	ld (hl),a			;bdb6
L_BDB7:
	ld hl,0bdceh		;bdb7
	call 04053h		;bdba   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ex de,hl			;bdbd
	ld e,(hl)			;bdbe
	inc hl			;bdbf
	ld d,(hl)			;bdc0
	inc hl			;bdc1
	ld b,(hl)			;bdc2
	inc hl			;bdc3
	ex de,hl			;bdc4
L_BDC5:
	ld a,(de)			;bdc5
	call 0004dh		;bdc6   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;bdc9
	inc de			;bdca
	djnz L_BDC5		;bdcb
	ret			;bdcd

; ----------------------------------------------------------------------
; DATOS tabla_bdce: 10 punteros (0xE61A = 0-9, p15:BDB7) a [direccion de
;   VRAM][cuantos][bytes] que p15:BDC5 escribe con WRTVRM
;   0xbdce..0xbde2  (20 bytes)
DATA_tabla_bdce:
	defb 0e2h,0bdh	; bdce
	defb 0e7h,0bdh	; bdd0
	defb 0ech,0bdh	; bdd2
	defb 0f2h,0bdh	; bdd4
	defb 0f7h,0bdh	; bdd6
	defb 0fdh,0bdh	; bdd8
	defb 004h,0beh	; bdda
	defb 00bh,0beh	; bddc
	defb 011h,0beh	; bdde
	defb 016h,0beh	; bde0

; ----------------------------------------------------------------------
; DATOS escrituras_bdce: las 10 escrituras de 0xBDCE: [direccion
;   0x15C0-0x15C4][2-4][bytes]
;   0xbde2..0xbe1c  (58 bytes)
DATA_escrituras_bdce:
	defb 0c0h,015h,002h,0a0h,0a9h,0c0h,015h,002h,090h,099h,0c1h,015h,003h,098h,068h,068h	; bde2  ..............hh
	defb 0c0h,015h,002h,080h,088h,0c1h,015h,003h,086h,066h,066h,0c4h,015h,004h,066h,066h	; bdf2  .........ff...ff
	defb 066h,066h,0c4h,015h,004h,068h,068h,068h,068h,0c1h,015h,003h,088h,068h,068h,0c0h	; be02  ff...hhhh....hh.
	defb 015h,002h,090h,098h,0c1h,015h,003h,099h,069h,069h	; be12  ........ii

; ======================================================================
; CODIGO 0xbe1c..0xbe22  (6 bytes)
; ======================================================================


L_BE1C:
	ld a,(0e699h)		;be1c
	call 04050h		;be1f   ; despacha (por 0x4050): salta a la entrada A de la tabla de palabras que va detras del call

; ----------------------------------------------------------------------
; DATOS tabla_BE22: 6 destinos del despachador de 0x4140 (call en p15:BE1F):
;   0xBE2E, 0xBE5C, 0xBEF4, 0xBE5C, 0xBF05, 0xBE5C; lo leen p15:BE1F (12
;   bytes)
;   0xbe22..0xbe2e  (12 bytes)
DATA_tabla_BE22:
	defb 02eh,0beh	; be22
	defb 05ch,0beh	; be24
	defb 0f4h,0beh	; be26
	defb 05ch,0beh	; be28
	defb 005h,0bfh	; be2a
	defb 05ch,0beh	; be2c

; ======================================================================
; CODIGO 0xbe2e..0xbec8  (154 bytes)
; ======================================================================


L_BE2E:
	ld hl,0e69ah		;be2e
	ld (hl),003h		;be31
	inc l			;be33
	ld (hl),09ch		;be34
	inc l			;be36
	ld (hl),00ah		;be37
	inc l			;be39
	ld (hl),0f0h		;be3a
L_BE3C:
	ld b,003h		;be3c
L_BE3E:
	push bc			;be3e
	call L_BE7F		;be3f
	ld hl,0e69ah		;be42
	inc (hl)			;be45
	pop bc			;be46
	djnz L_BE3E		;be47
	xor a			;be49
	ld (0e69ah),a		;be4a
	ld a,0feh		;be4d
	ld (0e69dh),a		;be4f
	ld a,008h		;be52
	ld (0e69eh),a		;be54
L_BE57:
	ld hl,0e699h		;be57
	inc (hl)			;be5a
	ret			;be5b
L_BE5C:
	call L_BE7F		;be5c
	ld hl,0e69ah		;be5f
	inc (hl)			;be62
	ld a,(hl)			;be63
	cp 003h		;be64
	ret c			;be66
	ld (hl),000h		;be67
	ld hl,0e69dh		;be69
	sla (hl)		;be6c
	ld hl,0e69eh		;be6e
	dec (hl)			;be71
	ret nz			;be72
	ld a,(0e699h)		;be73
	cp 005h		;be76
	jr c,L_BE57		;be78
	xor a			;be7a
	ld (0e698h),a		;be7b   ; guarda el humo del jefe en marcha
	ret			;be7e
L_BE7F:
	ld a,(0e69ah)		;be7f
	ld hl,0bec8h		;be82
	call 04053h		;be85   ; palabra_de_tabla (por 0x4053): DE = la palabra A de la tabla de HL
	ld a,(0e69bh)		;be88
	ld l,a			;be8b
	ld h,000h		;be8c
	add hl,hl			;be8e
	add hl,hl			;be8f
	add hl,hl			;be90
	add hl,de			;be91
	ld (0f000h),hl		;be92
	ld a,(0e69ch)		;be95
	ld l,a			;be98
	ld h,000h		;be99
	add hl,hl			;be9b
	add hl,hl			;be9c
	add hl,hl			;be9d
	ld (0f002h),hl		;be9e
	ld b,h			;bea1
	ld c,l			;bea2
	ld de,0e800h		;bea3   ; apunta a los huecos de figura (32 bytes cada uno)
	ld hl,(0f000h)		;bea6
	call 00059h		;bea9   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld bc,(0f002h)		;beac
	ld hl,0e800h		;beb0   ; apunta a los huecos de figura (32 bytes cada uno)
	ld a,(0e69dh)		;beb3
	ld e,a			;beb6
	call L_BED4		;beb7
	ld bc,(0f002h)		;beba
	ld de,(0f000h)		;bebe
	ld hl,0e800h		;bec2   ; apunta a los huecos de figura (32 bytes cada uno)
	jp 0005ch		;bec5   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS tabla_bec8: 6 palabras (0x2000, 0x2800, 0x3000, 0x0000, 0x0800 y
;   0x1000: los tercios de la tabla de colores y de la de dibujos) que
;   p15:BE85 elige con 0xE69A y a las que suma 0xE69B x 8
;   0xbec8..0xbed4  (12 bytes)
DATA_tabla_bec8:
	defb 000h,020h	; bec8
	defb 000h,028h	; beca
	defb 000h,030h	; becc
	defb 000h,000h	; bece
	defb 000h,008h	; bed0
	defb 000h,010h	; bed2

; ======================================================================
; CODIGO 0xbed4..0xbf16  (66 bytes)
; ======================================================================


L_BED4:
	ld a,(0e699h)		;bed4
	rra			;bed7
	jr c,L_BEE4		;bed8
L_BEDA:
	ld a,(hl)			;beda
	and e			;bedb
	ld (hl),a			;bedc
	inc hl			;bedd
	dec bc			;bede
	ld a,b			;bedf
	or c			;bee0
	jr nz,L_BEDA		;bee1
	ret			;bee3
L_BEE4:
	ld a,(hl)			;bee4
	and e			;bee5
	ld (hl),a			;bee6
	inc hl			;bee7
	rrc e		;bee8
	rrc e		;beea
	rrc e		;beec
	dec bc			;beee
	ld a,b			;beef
	or c			;bef0
	jr nz,L_BEE4		;bef1
	ret			;bef3
L_BEF4:
	ld hl,0e69ah		;bef4
	ld (hl),003h		;bef7
	inc l			;bef9
	ld (hl),05ah		;befa
	inc l			;befc
	ld (hl),040h		;befd
	inc l			;beff
	ld (hl),0f0h		;bf00
	jp L_BE3C		;bf02
L_BF05:
	ld hl,0e69ah		;bf05
	ld (hl),003h		;bf08
	inc l			;bf0a
	ld (hl),0bah		;bf0b
	inc l			;bf0d
	ld (hl),036h		;bf0e
	inc l			;bf10
	ld (hl),0f0h		;bf11
	jp L_BE3C		;bf13

; ----------------------------------------------------------------------
; DATOS rle_BF16: rle a la VRAM (0x5C46); lo leen p00:5923 (180 bytes)
;   0xbf16..0xbfca  (180 bytes)
DATA_rle_BF16:
	defb 090h,080h,0c0h,040h,060h,020h,030h,010h,010h,01fh,00fh,000h,007h,003h,000h,001h	; bf16  ...@` 0.........
	defb 007h,008h,000h,088h,0feh,0ffh,000h,0feh,0f8h,0e0h,0f0h,0feh,006h,000h,003h,003h	; bf26  ................
	defb 002h,000h,084h,002h,006h,038h,01eh,005h,000h,085h,020h,0a0h,0b0h,060h,0c0h,004h	; bf36  .....8.... ..`..
	defb 000h,091h,010h,030h,000h,000h,0beh,0ddh,05bh,057h,0ach,0d0h,068h,030h,00ch,02dh	; bf46  ...0....[W..h0.-
	defb 02ah,006h,001h,003h,000h,083h,0c0h,0a0h,0f0h,003h,000h,089h,080h,000h,000h,0c0h	; bf56  *...............
	defb 0c0h,0a2h,046h,08eh,004h,00ah,000h,085h,001h,007h,002h,00dh,004h,00ah,000h,086h	; bf66  ..F.............
	defb 040h,000h,060h,0c0h,098h,038h,007h,000h,089h,07dh,0bbh,0b7h,02eh,058h,020h,011h	; bf76  @.`..8...}...X .
	defb 020h,010h,007h,000h,085h,080h,040h,0e0h,000h,000h,004h,005h,086h,00ah,020h,012h	; bf86   .....@....... .
	defb 000h,0c0h,020h,006h,000h,08bh,013h,01bh,001h,000h,000h,048h,010h,000h,000h,006h	; bf96  .. ........H....
	defb 008h,003h,000h,08fh,020h,0a0h,0b4h,06ch,000h,01ch,00eh,07dh,0bbh,037h,02eh,058h	; bfa6  .... ..l...}.7.X
	defb 000h,001h,018h,008h,000h,086h,080h,040h,0e8h,00ch,006h,006h,004h,000h,082h,00eh	; bfb6  .......@........
	defb 00fh,004h,000h,000h	; bfc6

; ----------------------------------------------------------------------
; DATOS relleno_p15: relleno: 54 bytes 0xFF hasta el final del banco, sin nada
;   que los lea ni los ejecute (54 bytes)
;   0xbfca..0xc000  (54 bytes)
DATA_relleno_p15:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bffa
