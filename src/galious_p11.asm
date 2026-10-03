; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 11 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS rle_7FE3_cola: rle a la VRAM (0x5C46) de la pieza de decoracion 0x38
;   (sigue del banco anterior, 0x7FE3); lo leen p00:59B9 (16 bytes)
;   0x8000..0x8010  (16 bytes)
DATA_rle_7FE3_cola:
	defb 003h,005h,000h,083h,0c0h,0f0h,0f0h,005h,0f8h,002h,0f0h,081h,0c0h,005h,000h,000h	; 8000  ................

; ----------------------------------------------------------------------
; DATOS rle_8010: rle a la VRAM (0x5C46) de la pieza de decoracion 0x09; lo
;   leen p00:59B9 (131 bytes)
;   0x8010..0x8093  (131 bytes)
DATA_rle_8010:
	defb 0c0h,000h,003h,00fh,03fh,05bh,06fh,0f6h,0bbh,0e8h,0bbh,0f6h,077h,02dh,01fh,00fh	; 8010  ....?[o.....w-..
	defb 007h,000h,070h,0b8h,0dch,06eh,0e3h,0dch,0bfh,02fh,0bdh,0bfh,0dbh,0deh,0ech,068h	; 8020  ..p..n.../.....h
	defb 0f0h,000h,00fh,01bh,02fh,073h,0fch,0eeh,0fah,0beh,0f8h,0e7h,09eh,07fh,037h,01dh	; 8030  ..../s........7.
	defb 00fh,000h,0f0h,068h,0dch,0beh,06eh,0fbh,0bfh,0ech,07bh,0b7h,0ceh,0dch,0d8h,0b0h	; 8040  ...h..n...{.....
	defb 0a0h,0c0h,000h,00fh,016h,037h,07bh,0dbh,0fdh,0bdh,0f4h,0fdh,03bh,0c7h,076h,03bh	; 8050  .....7{.......v.
	defb 01dh,00eh,000h,0e0h,0f0h,0f8h,0b4h,0eeh,06fh,0ddh,017h,0ddh,06fh,0f6h,0dah,0fch	; 8060  ........o...o...
	defb 0f0h,0c0h,000h,005h,00dh,01bh,03bh,073h,0edh,0deh,037h,0fdh,0dfh,076h,07dh,03bh	; 8070  .......s..7..v}.
	defb 016h,00fh,000h,0f0h,0b8h,0ech,0feh,079h,0e7h,01fh,07dh,05fh,077h,03fh,0ceh,0f4h	; 8080  .......y..}_w?..
	defb 0d8h,0f0h,000h	; 8090

; ----------------------------------------------------------------------
; DATOS rle_8093: rle a la VRAM (0x5C46) de la pieza de decoracion 0x29; lo
;   leen p00:59B9 (53 bytes)
;   0x8093..0x80c8  (53 bytes)
DATA_rle_8093:
	defb 083h,001h,03bh,077h,003h,0ffh,085h,0f7h,0efh,06fh,00fh,007h,005h,000h,084h,0e0h	; 8093  ...w.....o......
	defb 0f0h,0c8h,0f6h,003h,0fbh,084h,0f5h,0fch,0d8h,0c0h,005h,000h,083h,001h,01bh,037h	; 80a3  ...............7
	defb 003h,07fh,083h,037h,00fh,007h,007h,000h,089h,0e0h,090h,0ech,0eeh,0eeh,0dah,0fch	; 80b3  ...7............
	defb 0d8h,080h,007h,000h,000h	; 80c3

; ----------------------------------------------------------------------
; DATOS rle_80C8: rle a la VRAM (0x5C46) de la pieza de decoracion 0x02; lo
;   leen p00:59B9 (51 bytes)
;   0x80c8..0x80fb  (51 bytes)
DATA_rle_80C8:
	defb 002h,000h,08bh,020h,011h,009h,005h,003h,01eh,003h,005h,009h,011h,020h,005h,000h	; 80c8  ... ......... ..
	defb 08bh,008h,010h,020h,040h,080h,0f0h,080h,040h,020h,010h,008h,005h,000h,003h,001h	; 80d8  ... @...@ ......
	defb 085h,003h,007h,03eh,007h,003h,003h,001h,008h,000h,085h,080h,0c0h,0f8h,0c0h,080h	; 80e8  ...>............
	defb 006h,000h,000h	; 80f8

; ----------------------------------------------------------------------
; DATOS rle_80FB: rle a la VRAM (0x5C46) de la pieza de decoracion 0x01; lo
;   leen p00:59B9 (147 bytes)
;   0x80fb..0x818e  (147 bytes)
DATA_rle_80FB:
	defb 0ffh,000h,00fh,03fh,07fh,07fh,0ffh,0ffh,0fbh,0fdh,0fch,0edh,07eh,016h,03dh,028h	; 80fb  ...?........~.=(
	defb 03fh,0fch,0feh,0fbh,0ddh,0efh,0f7h,0f4h,0b6h,0f8h,0dch,03ch,096h,0deh,006h,016h	; 810b  ?..........<....
	defb 08eh,000h,000h,00fh,03fh,07fh,07fh,0ffh,0f7h,0fah,0fbh,0eah,03bh,00dh,029h,067h	; 811b  ....?.........)g
	defb 04bh,000h,0fch,0feh,0fbh,0fdh,0efh,0efh,0dch,0deh,0a0h,09ch,0b6h,08fh,081h,083h	; 812b  K...............
	defb 000h,007h,00fh,00ch,03fh,07fh,0f7h,0fbh,0fch,0ffh,0bfh,0e7h,0afh,0dch,0d8h,0ech	; 813b  ....?...........
	defb 06ch,0e0h,0d0h,0b6h,0fbh,0b7h,0f7h,0efh,01fh,0fdh,0e7h,0f5h,0fbh,037h,016h,038h	; 814b  l............7.8
	defb 03eh,007h,00ch,00fh,03fh,07fh,0f7h,0fbh,0fch,0ffh,0bfh,0e7h,0afh,0dch,0d8h,0ech	; 815b  >...?...........
	defb 06ch,0efh,097h,0f7h,0bbh,0f6h,0f6h,0eeh,01ch,0fch,0f8h,0f8h,0ech,03ah,01eh,034h	; 816b  l............:.4
	defb 081h,03fh,013h,000h,08dh,070h,0d0h,0f0h,070h,038h,02ch,03ch,02ah,01eh,00eh,01eh	; 817b  .?...p..p8,<*...
	defb 01fh,01fh,000h	; 818b

; ----------------------------------------------------------------------
; DATOS rle_818E: rle a la VRAM (0x5C46) de la pieza de decoracion 0x08; lo
;   leen p00:59B9 (97 bytes)
;   0x818e..0x81ef  (97 bytes)
DATA_rle_818E:
	defb 003h,000h,002h,006h,0b8h,000h,00ah,001h,001h,000h,00dh,004h,072h,07ah,00eh,0c3h	; 818e  ............rz..
	defb 000h,000h,080h,000h,080h,018h,018h,040h,000h,000h,030h,070h,047h,08fh,0b8h,0c0h	; 819e  .......@..0pG...
	defb 010h,03bh,036h,02fh,02fh,03bh,01bh,01bh,01dh,0eeh,0efh,077h,039h,03eh,01eh,00eh	; 81ae  ..6//......w9>..
	defb 0f8h,0e8h,04ch,0a8h,08ch,048h,011h,053h,08eh,0feh,01ch,0f8h,0e0h,003h,000h,08fh	; 81be  ..L..H.S........
	defb 006h,00eh,03eh,079h,0f7h,0efh,0eeh,01dh,01bh,01ah,01ah,00eh,00fh,007h,003h,003h	; 81ce  ..>y............
	defb 000h,08eh,03eh,0e7h,0fah,01ch,0feh,0fah,01bh,0a7h,00bh,0c1h,03fh,014h,080h,0c0h	; 81de  ..>.........?...
	defb 000h	; 81ee

; ----------------------------------------------------------------------
; DATOS rle_81EF: rle a la VRAM (0x5C46) de la pieza de decoracion 0x34; lo
;   leen p00:59B9 (12 bytes)
;   0x81ef..0x81fb  (12 bytes)
DATA_rle_81EF:
	defb 088h,03ch,07eh,0dfh,0bfh,0bfh,0ffh,07eh,03ch,018h,000h,000h	; 81ef  .<~....~<...

; ----------------------------------------------------------------------
; DATOS rle_81FB: rle a la VRAM (0x5C46) de la pieza de decoracion 0x05; lo
;   leen p00:59B9 (111 bytes)
;   0x81fb..0x826a  (111 bytes)
DATA_rle_81FB:
	defb 0a3h,00fh,03bh,038h,07ch,07fh,07fh,03fh,03fh,01eh,007h,001h,01eh,03fh,0bfh,0f7h	; 81fb  ...8|..??....?..
	defb 063h,080h,0e0h,070h,0b0h,038h,0d8h,078h,008h,0e0h,0c0h,0f8h,0ech,076h,0f6h,0ceh	; 820b  c..p.8.x.....v..
	defb 0fch,001h,007h,007h,003h,00fh,002h,007h,002h,003h,0abh,001h,04dh,09dh,0ffh,06fh	; 821b  ............M..o
	defb 007h,0f0h,07ch,00eh,096h,0e7h,0fbh,0efh,0e1h,0dch,0e0h,0b0h,0b8h,0dch,0dch,03ch	; 822b  ..|............<
	defb 0f8h,00fh,038h,03eh,07bh,076h,074h,034h,03ch,01eh,007h,001h,01eh,03fh,0bfh,0f7h	; 823b  ..8>{vt4<....?..
	defb 063h,0f0h,0fch,0d6h,014h,028h,003h,000h,08bh,028h,0fch,0e0h,0fch,076h,0f6h,0ceh	; 824b  c....(...(...v..
	defb 0fch,000h,004h,001h,00dh,000h,085h,00eh,0bfh,07fh,0bfh,00eh,00bh,000h,000h	; 825b  ...............

; ----------------------------------------------------------------------
; DATOS rle_826A: rle a la VRAM (0x5C46) de la pieza de decoracion 0x31; lo
;   leen p00:59B9 (204 bytes)
;   0x826a..0x8336  (204 bytes)
DATA_rle_826A:
	defb 009h,000h,087h,003h,005h,00fh,00fh,005h,001h,001h,00ah,000h,084h,0c0h,0e0h,0a0h	; 826a  ................
	defb 0c0h,008h,000h,087h,001h,00dh,00fh,01fh,01fh,01bh,00dh,003h,001h,006h,000h,088h	; 827a  ................
	defb 0c0h,0b0h,0d8h,0d8h,0f0h,0f8h,0b0h,080h,005h,000h,081h,00eh,003h,01fh,086h,02fh	; 828a  .............../
	defb 03fh,03fh,037h,01bh,003h,003h,001h,003h,000h,083h,0e0h,0f0h,090h,003h,0ech,085h	; 829a  ??7.............
	defb 0d8h,0fch,0d8h,080h,080h,003h,000h,08ch,00eh,01fh,039h,037h,01fh,02fh,07fh,07fh	; 82aa  ..........97./..
	defb 06fh,02fh,013h,00fh,003h,001h,097h,000h,078h,07ch,0feh,01ah,0ech,0eeh,0eeh,0dch	; 82ba  o/......x|......
	defb 0fah,0fch,0dch,0b8h,080h,000h,000h,001h,001h,005h,00fh,00fh,005h,003h,00bh,000h	; 82ca  ................
	defb 084h,0c0h,0a0h,0e0h,0c0h,00ah,000h,003h,001h,087h,00dh,01bh,01fh,01fh,00fh,00dh	; 82da  ................
	defb 001h,008h,000h,088h,080h,0b0h,0f8h,0f0h,0d8h,0d8h,0b0h,0c0h,006h,000h,003h,001h	; 82ea  ................
	defb 086h,003h,01bh,037h,03fh,03fh,02fh,003h,01fh,081h,00eh,005h,000h,002h,080h,083h	; 82fa  ...7??/.........
	defb 0d8h,0fch,0d8h,003h,0ech,083h,090h,0f0h,0e0h,003h,000h,003h,001h,08ch,00fh,013h	; 830a  ................
	defb 02fh,06fh,07fh,07fh,02fh,01fh,037h,039h,01fh,00eh,003h,000h,08eh,080h,0b8h,0dch	; 831a  /o../.79........
	defb 0fch,0fah,0dch,0eeh,0eeh,0ech,01ah,0feh,07ch,078h,000h,000h	; 832a  ........|x..

; ----------------------------------------------------------------------
; DATOS rle_8336: rle a la VRAM (0x5C46) de la pieza de decoracion 0x11; lo
;   leen p00:59B9 (129 bytes)
;   0x8336..0x83b7  (129 bytes)
DATA_rle_8336:
	defb 083h,003h,000h,03fh,003h,000h,081h,007h,009h,000h,087h,0f0h,000h,080h,000h,07eh	; 8336  ...?...........~
	defb 000h,0e0h,00fh,000h,08ah,015h,02ah,055h,0afh,07fh,0fdh,0feh,0feh,0f9h,03eh,007h	; 8346  ......*U......>.
	defb 000h,089h,0a0h,050h,0e8h,0d8h,0e4h,0fah,0efh,0f0h,03ch,005h,000h,08ah,015h,02ah	; 8356  ...P......<....*
	defb 055h,0afh,07fh,0fdh,0feh,0ffh,07fh,00eh,007h,000h,091h,0a0h,050h,0e8h,0f8h,0dch	; 8366  U...........P...
	defb 0e4h,03ah,0dfh,020h,0c0h,00fh,01fh,07fh,07fh,0fdh,0bdh,083h,003h,01fh,002h,00fh	; 8376  .:. ............
	defb 081h,002h,003h,000h,090h,0a0h,0c0h,0d0h,0a0h,0d0h,0a0h,0d0h,0a0h,0d0h,0e8h,0d8h	; 8386  ................
	defb 0e4h,0fah,0efh,070h,03ch,005h,000h,08bh,005h,02ah,015h,02fh,01fh,01bh,036h,031h	; 8396  ...p<....*./..61
	defb 03fh,01bh,01ch,006h,000h,08ah,0a0h,050h,0d0h,0e8h,0ech,0f6h,0f6h,0f7h,0e0h,0e0h	; 83a6  ?......P........
	defb 000h	; 83b6

; ----------------------------------------------------------------------
; DATOS rle_83B7: rle a la VRAM (0x5C46) de la pieza de decoracion 0x14; lo
;   leen p00:59B9 (113 bytes)
;   0x83b7..0x8428  (113 bytes)
DATA_rle_83B7:
	defb 00dh,000h,083h,003h,00fh,01fh,00dh,000h,083h,0c0h,0f0h,0f8h,00ch,000h,084h,006h	; 83b7  ................
	defb 01fh,03fh,0feh,00ch,000h,084h,0e0h,038h,05ch,0efh,008h,000h,088h,008h,000h,064h	; 83c7  .?.....8\......d
	defb 061h,009h,03ch,07eh,0fch,008h,000h,0c8h,010h,040h,00ch,08ch,0a0h,018h,00ch,0c7h	; 83d7  a.<~.....@......
	defb 007h,01fh,01dh,035h,03bh,05fh,05dh,03bh,05bh,056h,02fh,01dh,013h,00fh,01fh,01fh	; 83e7  ...5._].[V/.....
	defb 0e0h,090h,0d8h,0f8h,068h,030h,0ceh,0f7h,095h,068h,0f0h,0e0h,090h,0b0h,000h,0e8h	; 83f7  ....h0...h......
	defb 000h,007h,01fh,01dh,035h,03bh,05fh,05dh,03bh,05bh,066h,03bh,027h,07eh,0f8h,0ffh	; 8407  ....5._].[f.'~..
	defb 000h,0e0h,090h,0d8h,0f0h,060h,030h,0ceh,0f7h,095h,068h,0e0h,01ch,034h,078h,07fh	; 8417  .....`0...h..4x.
	defb 000h	; 8427

; ----------------------------------------------------------------------
; DATOS rle_8428: rle a la VRAM (0x5C46) de la pieza de decoracion 0x0A; lo
;   leen p00:59B9 (236 bytes)
;   0x8428..0x8514  (236 bytes)
DATA_rle_8428:
	defb 0ffh,000h,00eh,01eh,05eh,05eh,01eh,00fh,030h,037h,00fh,001h,00eh,017h,00ah,00eh	; 8428  ....^^..07......
	defb 00eh,080h,0f0h,0f8h,0fah,0fah,078h,0f0h,00ch,0eeh,0f0h,08eh,076h,0e8h,050h,070h	; 8438  ......x.....v.Pp
	defb 000h,000h,00eh,01eh,05eh,05eh,01eh,00fh,030h,037h,00fh,001h,00eh,017h,00ah,00eh	; 8448  ....^^..07......
	defb 000h,080h,0f0h,0f8h,0fah,0fah,078h,0f0h,00ch,0eeh,0f0h,08eh,076h,0e8h,050h,070h	; 8458  ......x.....v.Pp
	defb 070h,001h,00fh,010h,04fh,058h,01fh,00fh,030h,077h,00fh,071h,06eh,015h,00ah,00eh	; 8468  p...OX..0w.qn...
	defb 00eh,080h,0f0h,008h,0f2h,01ah,0f8h,0f0h,00ch,0eeh,0f6h,088h,077h,0aah,052h,072h	; 8478  ............w.Rr
	defb 000h,001h,00fh,010h,04fh,058h,01fh,00fh,030h,077h,00fh,071h,06eh,015h,00ah,00eh	; 8488  ....OX..0w.qn...
	defb 000h,080h,0f0h,008h,0f2h,01ah,0f8h,0f0h,00ch,0eeh,0f6h,088h,077h,0aah,052h,072h	; 8498  ............w.Rr
	defb 002h,070h,0ceh,0cfh,0bfh,0fch,0fbh,0bch,0bfh,000h,01dh,03dh,01eh,035h,05fh,009h	; 84a8  .p.........=.5_.
	defb 01fh,01fh,000h,0c0h,030h,0f0h,080h,0f0h,030h,000h,0c1h,0d9h,0bfh,05dh,0a1h,000h	; 84b8  ....0...0....]..
	defb 000h,0c0h,000h,038h,067h,05fh,07eh,07dh,05eh,05eh,00dh,01bh,01dh,07eh,035h,02eh	; 84c8  ...8g_~}^^...~5.
	defb 0e1h,0f9h,000h,000h,0e0h,098h,078h,0c0h,078h,018h,0c0h,0c1h,0b9h,03fh,04dh,0a1h	; 84d8  ......x.x....?M.
	defb 0c0h,0f0h,000h,038h,067h,05fh,07eh,07dh,05eh,05eh,00dh,01bh,01dh,0aeh,0ddh,0cah	; 84e8  ...8g_~}^^......
	defb 060h,003h,000h,08dh,0e0h,098h,078h,0c0h,078h,018h,0c1h,0d9h,0bfh,01dh,061h,0b8h	; 84f8  `.....x.x.....a.
	defb 010h,00ah,000h,003h,07fh,00eh,000h,081h,0c0h,005h,000h,000h	; 8508  ............

; ----------------------------------------------------------------------
; DATOS rle_8514: rle a la VRAM (0x5C46) de la pieza de decoracion 0x0E; lo
;   leen p00:59B9 (158 bytes)
;   0x8514..0x85b2  (158 bytes)
DATA_rle_8514:
	defb 002h,001h,002h,003h,088h,007h,00fh,00eh,00dh,00dh,006h,001h,002h,004h,000h,002h	; 8514  ................
	defb 080h,002h,0c0h,088h,0a0h,070h,070h,0b0h,0b0h,060h,080h,040h,004h,000h,085h,0e1h	; 8524  .....pp..`.@....
	defb 052h,02dh,01eh,00ch,00bh,000h,082h,0c0h,080h,00fh,000h,086h,012h,00ch,05eh,0edh	; 8534  R-............^.
	defb 0c0h,040h,00ch,000h,084h,080h,0c0h,0c0h,080h,00ah,000h,089h,078h,0feh,01ch,00ch	; 8544  .@..........x...
	defb 00ah,007h,00dh,007h,001h,007h,000h,089h,01eh,07fh,038h,030h,050h,0e0h,0b0h,0e0h	; 8554  ..........80P...
	defb 080h,006h,000h,089h,004h,002h,037h,06dh,0f7h,0e1h,0f0h,060h,030h,007h,000h,089h	; 8564  ......7m...`0...
	defb 020h,040h,0ech,0b6h,0efh,087h,00fh,006h,00ch,007h,000h,085h,007h,01fh,02fh,00bh	; 8574   @............/.
	defb 002h,00bh,000h,08eh,0e0h,0f8h,0feh,0f0h,0ech,077h,033h,035h,02eh,02dh,012h,00dh	; 8584  .........w35.-..
	defb 00ah,001h,008h,000h,083h,001h,003h,003h,004h,007h,002h,003h,003h,000h,08eh,00ch	; 8594  ................
	defb 007h,003h,075h,0eeh,0edh,0f2h,0ddh,0deh,0ebh,081h,0c0h,080h,0e0h,000h	; 85a4  ..u...........

; ----------------------------------------------------------------------
; DATOS rle_85B2: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2F; lo
;   leen p00:59B9 (34 bytes)
;   0x85b2..0x85d4  (34 bytes)
DATA_rle_85B2:
	defb 0a0h,000h,00dh,005h,039h,016h,01bh,00dh,0e6h,0d9h,06eh,076h,01bh,01dh,066h,030h	; 85b2  ....9.....nv..f0
	defb 003h,080h,098h,050h,040h,05ch,028h,058h,0a6h,099h,076h,06eh,098h,0b8h,0a6h,058h	; 85c2  ...P@\(X..vn...X
	defb 0e0h,000h	; 85d2

; ----------------------------------------------------------------------
; DATOS rle_85D4: rle a la VRAM (0x5C46) de la pieza de decoracion 0x07; lo
;   leen p00:59B9 (43 bytes)
;   0x85d4..0x85ff  (43 bytes)
DATA_rle_85D4:
	defb 00ah,000h,086h,016h,02dh,06dh,0edh,0edh,056h,00ah,000h,086h,0d0h,0b8h,0b6h,0afh	; 85d4  ....-m..V.......
	defb 0afh,0d6h,007h,000h,089h,007h,00eh,00dh,015h,015h,01ah,02ch,032h,01ch,007h,000h	; 85e4  ...........,2...
	defb 089h,080h,0e0h,0c0h,0b0h,060h,0d8h,0bch,0bch,058h,000h	; 85f4  .....`...X.

; ----------------------------------------------------------------------
; DATOS rle_85FF: rle a la VRAM (0x5C46) de la pieza de decoracion 0x12; lo
;   leen p00:59B9 (170 bytes)
;   0x85ff..0x86a9  (170 bytes)
DATA_rle_85FF:
	defb 085h,078h,0fch,0f4h,0bch,070h,01ch,000h,0ffh,003h,00fh,01fh,033h,03bh,07dh,0ffh	; 85ff  .x...p......3.}.
	defb 0d6h,07dh,06eh,07bh,02fh,01ah,01fh,01fh,000h,0e0h,0f8h,0e8h,074h,07eh,088h,063h	; 860f  .}n{/.......t~.c
	defb 01fh,0c7h,0e8h,06ch,028h,0d0h,070h,0b8h,000h,003h,00fh,01fh,03bh,02fh,055h,07bh	; 861f  ...l(.p....../U{
	defb 0f0h,0fdh,0d6h,077h,02fh,01fh,01bh,007h,000h,0e0h,0b8h,0c8h,0f6h,063h,09ch,077h	; 862f  ...w/........c.w
	defb 01fh,0c7h,0ebh,0eeh,0aah,0d4h,078h,0b8h,000h,003h,00fh,03fh,05bh,06fh,0f6h,0bbh	; 863f  ......x....?[o..
	defb 0e8h,0bbh,0f6h,077h,02dh,01fh,00fh,007h,000h,070h,0b8h,0dch,06eh,0e3h,0dch,0bfh	; 864f  ...w-....p..n...
	defb 02fh,0bdh,0bfh,0dbh,0deh,0ech,068h,0f0h,000h,00fh,01dh,03bh,07bh,07bh,07dh,07fh	; 865f  /.....h.....{{}.
	defb 07fh,05fh,07dh,02eh,07eh,06ch,0b8h,0feh,000h,0f0h,0fch,0e6h,072h,07eh,088h,063h	; 866f  ._}.~l......r~.c
	defb 0bfh,0cfh,0d0h,0e8h,068h,0a8h,050h,07eh,086h,00fh,01dh,03bh,07bh,07bh,007h,003h	; 867f  ....h.P~....{{..
	defb 07fh,097h,07dh,06eh,03bh,01fh,01ah,02eh,03fh,0f0h,0fch,0e6h,072h,07eh,088h,060h	; 868f  ..}n....?...r~.`
	defb 0a0h,0d3h,0dfh,0e7h,068h,028h,0c0h,040h,0b0h,000h	; 869f  ....h(.@..

; ----------------------------------------------------------------------
; DATOS rle_86A9: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2E; lo
;   leen p00:59B9 (135 bytes)
;   0x86a9..0x8730  (135 bytes)
DATA_rle_86A9:
	defb 00ah,000h,086h,002h,015h,02ah,02ah,037h,03fh,00ah,000h,086h,020h,050h,0a8h,0a8h	; 86a9  .....**7?... P..
	defb 078h,0f8h,007h,000h,089h,001h,00ah,015h,013h,01dh,02ah,02ah,037h,03fh,008h,000h	; 86b9  x.........**7?..
	defb 088h,0a0h,050h,030h,0d0h,0a8h,0a8h,078h,0f8h,005h,000h,08bh,005h,00ah,00bh,00eh	; 86c9  ..P0...x........
	defb 015h,01bh,01dh,02ah,02ah,037h,03fh,004h,000h,0cch,080h,040h,020h,060h,0e0h,050h	; 86d9  ...**7?....@ `.P
	defb 0b0h,0d0h,0a8h,0a8h,078h,0f8h,000h,000h,002h,005h,006h,005h,00ah,00fh,00eh,015h	; 86e9  ....x...........
	defb 01bh,01dh,02ah,02ah,037h,03fh,000h,080h,080h,040h,0c0h,0c0h,0a0h,060h,0e0h,050h	; 86f9  ..**7?...@...`.P
	defb 0b0h,0d0h,0a8h,0a8h,078h,0f8h,001h,002h,003h,005h,006h,005h,00ah,00fh,00eh,015h	; 8709  ....x...........
	defb 01bh,01dh,02ah,02ah,037h,03fh,000h,080h,080h,040h,0c0h,0c0h,0a0h,060h,0e0h,050h	; 8719  ..**7?...@...`.P
	defb 0b0h,0d0h,0a8h,0a8h,078h,0f8h,000h	; 8729

; ----------------------------------------------------------------------
; DATOS rle_8730: rle a la VRAM (0x5C46) de la pieza de decoracion 0x23; lo
;   leen p00:59B9 (49 bytes)
;   0x8730..0x8761  (49 bytes)
DATA_rle_8730:
	defb 093h,02fh,05fh,0d7h,0dfh,0ddh,0dfh,0dfh,0d7h,0dfh,0dah,0dfh,0dfh,0d7h,0deh,0dbh	; 8730  ./_.............
	defb 0dfh,080h,0c0h,040h,003h,0c0h,081h,040h,009h,0c0h,088h,0dbh,0dfh,0d7h,0dfh,0dbh	; 8740  ...@...@........
	defb 0dfh,0ddh,06fh,008h,000h,081h,040h,003h,0c0h,084h,040h,0c0h,0c0h,080h,008h,000h	; 8750  ..o...@...@.....
	defb 000h	; 8760

; ----------------------------------------------------------------------
; DATOS rle_8761: rle a la VRAM (0x5C46) de la pieza de decoracion 0x20; lo
;   leen p00:59B9 (23 bytes)
;   0x8761..0x8778  (23 bytes)
DATA_rle_8761:
	defb 008h,000h,088h,003h,00fh,01bh,037h,037h,03fh,07fh,0ffh,008h,000h,083h,0c0h,0f0h	; 8761  ......77?.......
	defb 0f8h,003h,0fch,082h,0feh,0ffh,000h	; 8771

; ----------------------------------------------------------------------
; DATOS rle_8778: rle a la VRAM (0x5C46) de la pieza de decoracion 0x28; lo
;   leen p00:59B9 (142 bytes)
;   0x8778..0x8806  (142 bytes)
DATA_rle_8778:
	defb 094h,001h,003h,006h,005h,00dh,00dh,00fh,00dh,007h,007h,003h,005h,001h,002h,002h	; 8778  ................
	defb 000h,080h,0c0h,0e0h,0e0h,004h,0f0h,002h,0a0h,002h,040h,002h,000h,002h,080h,002h	; 8788  ..........@.....
	defb 001h,002h,000h,002h,002h,002h,005h,004h,00fh,002h,007h,092h,003h,001h,000h,040h	; 8798  ...............@
	defb 040h,080h,0a0h,0c0h,0e0h,0e0h,0b0h,0f0h,0b0h,0b0h,0a0h,060h,0c0h,080h,005h,000h	; 87a8  @..........`....
	defb 086h,00bh,067h,01fh,0c3h,00ch,003h,009h,000h,088h,0f0h,0fch,046h,0fbh,0ffh,0feh	; 87b8  ..g.........F...
	defb 0fch,0f0h,007h,000h,099h,001h,003h,007h,005h,00fh,00fh,007h,02bh,016h,02dh,040h	; 87c8  ............+.-@
	defb 090h,020h,000h,000h,078h,0ach,07ch,0fch,0fch,0f8h,0f8h,0f0h,060h,080h,004h,000h	; 87d8  . ..x.|.....`...
	defb 08dh,040h,020h,094h,048h,015h,01bh,00fh,017h,00bh,007h,007h,003h,001h,007h,000h	; 87e8  .@ .H...........
	defb 08ch,080h,0e0h,0b0h,0f8h,0e8h,0f4h,0fch,0f4h,0fch,078h,000h,000h,000h	; 87f8  ..........x...

; ----------------------------------------------------------------------
; DATOS rle_8806: rle a la VRAM (0x5C46) de la pieza de decoracion 0x21; lo
;   leen p00:59B9 (51 bytes)
;   0x8806..0x8839  (51 bytes)
DATA_rle_8806:
	defb 006h,000h,08ah,001h,006h,00dh,01dh,01dh,02dh,06dh,06dh,0f6h,029h,006h,000h,08ah	; 8806  ........-mm.)...
	defb 060h,0d8h,0bch,0bch,0b6h,0b2h,0b5h,0b9h,0dfh,02ah,007h,000h,081h,001h,003h,003h	; 8816  `........*......
	defb 003h,005h,082h,01ah,005h,006h,000h,082h,050h,0ach,003h,05eh,085h,05ah,059h,05dh	; 8826  ........P..^.ZY]
	defb 0afh,054h,000h	; 8836

; ----------------------------------------------------------------------
; DATOS rle_8839: rle a la VRAM (0x5C46) de la pieza de decoracion 0x03; lo
;   leen p00:59B9 (66 bytes)
;   0x8839..0x887b  (66 bytes)
DATA_rle_8839:
	defb 086h,03fh,07fh,067h,03dh,007h,003h,00ah,000h,086h,0fch,0feh,0feh,0fch,0e0h,0c0h	; 8839  .?.g=...........
	defb 00eh,000h,088h,003h,00fh,01fh,017h,017h,01bh,00fh,003h,008h,000h,082h,0c0h,0f0h	; 8849  ................
	defb 004h,0f8h,082h,0f0h,0c0h,004h,000h,081h,00fh,003h,01fh,086h,01dh,00dh,005h,006h	; 8859  ................
	defb 003h,001h,006h,000h,081h,0e0h,003h,0f0h,086h,0e0h,0c0h,0c0h,0e0h,0e0h,0c0h,006h	; 8869  ................
	defb 000h,000h	; 8879

; ----------------------------------------------------------------------
; DATOS rle_887B: rle a la VRAM (0x5C46) de la pieza de decoracion 0x10; lo
;   leen p00:59B9 (85 bytes)
;   0x887b..0x88d0  (85 bytes)
DATA_rle_887B:
	defb 005h,000h,08ah,00ch,01eh,03eh,03bh,073h,071h,0e4h,085h,009h,012h,006h,000h,082h	; 887b  .....>.sq.......
	defb 020h,074h,003h,076h,086h,0f6h,076h,074h,024h,023h,010h,005h,000h,08bh,00ch,02eh	; 888b   t.v..vt$#......
	defb 05eh,05bh,05dh,05dh,05ch,05dh,048h,088h,030h,004h,000h,08bh,020h,070h,054h,026h	; 889b  ^[]]\]H.0... pT&
	defb 056h,02eh,08eh,02eh,024h,094h,003h,006h,000h,08bh,04ch,0eeh,09fh,09bh,0ddh,05dh	; 88ab  V...$.....L....]
	defb 05ch,05dh,089h,00ah,030h,004h,000h,08ch,006h,02fh,077h,073h,077h,077h,0f6h,072h	; 88bb  \]..0..../wsww.r
	defb 071h,020h,020h,010h,000h	; 88cb

; ----------------------------------------------------------------------
; DATOS rle_88D0: rle a la VRAM (0x5C46) de la pieza de decoracion 0x08; lo
;   leen p00:59B9 (123 bytes)
;   0x88d0..0x894b  (123 bytes)
DATA_rle_88D0:
	defb 089h,02eh,018h,0a6h,0bdh,05eh,0beh,04dh,073h,01ch,008h,000h,087h,080h,000h,040h	; 88d0  .....^.Ms......@
	defb 080h,080h,000h,040h,00dh,000h,083h,001h,005h,00ah,003h,00fh,081h,006h,00ah,000h	; 88e0  ...@............
	defb 082h,020h,080h,003h,0c0h,081h,080h,009h,000h,083h,002h,009h,003h,003h,007h,081h	; 88f0  . ..............
	defb 003h,00ah,000h,002h,040h,003h,080h,005h,000h,08eh,001h,00ah,013h,05bh,04fh,07fh	; 8900  ....@........[O.
	defb 03fh,0bfh,05fh,07fh,03fh,05fh,03fh,01bh,003h,000h,09dh,040h,020h,034h,0e8h,0f8h	; 8910  ?._.?_?....@ 4..
	defb 0f8h,0f0h,0f4h,0f8h,0f8h,0f0h,0c8h,070h,000h,000h,008h,011h,01ah,00bh,01fh,05fh	; 8920  .......p......._
	defb 03fh,07fh,03fh,03fh,05fh,03fh,01fh,007h,003h,000h,08fh,010h,030h,020h,0c8h,0e8h	; 8930  ?.??_?......0 ..
	defb 0f0h,0f4h,0e0h,0e8h,0f0h,0f0h,0e0h,080h,000h,000h,000h	; 8940  ...........

; ----------------------------------------------------------------------
; DATOS rle_894B: rle a la VRAM (0x5C46) de la pieza de decoracion 0x0C; lo
;   leen p00:59B9 (175 bytes)
;   0x894b..0x89fa  (175 bytes)
DATA_rle_894B:
	defb 088h,020h,000h,020h,068h,078h,0bch,0fch,078h,018h,000h,0cdh,002h,014h,004h,016h	; 894b  . . hx..x.......
	defb 02fh,03fh,05dh,036h,03bh,03bh,01ch,01fh,006h,01ch,00eh,03eh,090h,080h,048h,0d0h	; 895b  /?]6.......>..H.
	defb 0f4h,0fah,0bah,06ch,0dch,0dch,038h,0f8h,060h,038h,070h,07ch,001h,004h,00ch,00eh	; 896b  ...l..8.`8p|....
	defb 017h,02fh,02dh,03fh,017h,01bh,01bh,00ch,007h,00fh,002h,006h,020h,000h,0a0h,0d4h	; 897b  ./-?........ ...
	defb 0f0h,0e8h,0f4h,0bch,078h,0f8h,078h,0f0h,0e0h,0f0h,060h,048h,008h,00ah,040h,052h	; 898b  ....x.x...`H..@R
	defb 09ah,0bch,0feh,07eh,0dfh,0dfh,0efh,07eh,018h,008h,000h,084h,080h,000h,080h,080h	; 899b  ...~...~........
	defb 007h,000h,08ah,010h,000h,02ah,048h,05ah,07eh,0ffh,0dfh,06eh,03ch,016h,000h,096h	; 89ab  .....*HZ~..n<...
	defb 044h,021h,024h,01bh,08fh,05fh,05fh,03fh,05fh,02fh,01fh,04fh,006h,01eh,038h,03eh	; 89bb  D!$..__?_/.O..8>
	defb 000h,020h,0d0h,0f0h,028h,0fch,005h,0ech,0a5h,0f8h,0e0h,018h,030h,03eh,010h,052h	; 89cb  . ..(.......0>.R
	defb 019h,029h,02eh,09fh,01fh,05fh,05fh,02fh,03fh,01fh,003h,023h,007h,007h,080h,010h	; 89db  .)...__/?..#....
	defb 048h,0d8h,0f0h,0f8h,094h,0d4h,0feh,0f6h,0f6h,078h,080h,0a0h,020h,0d8h,000h	; 89eb  H........x.. ..

; ----------------------------------------------------------------------
; DATOS rle_89FA: rle a la VRAM (0x5C46) de la pieza de decoracion 0x24; lo
;   leen p00:59B9 (97 bytes)
;   0x89fa..0x8a5b  (97 bytes)
DATA_rle_89FA:
	defb 0ddh,000h,010h,037h,07ch,07fh,0feh,07dh,0bfh,07fh,07bh,004h,05fh,080h,0beh,020h	; 89fa  ...7|..}..{._..
	defb 010h,018h,028h,070h,0f8h,0c0h,010h,0e0h,01ah,0f5h,0e0h,000h,0f0h,030h,070h,040h	; 8a0a  ..(p.........0p@
	defb 060h,010h,037h,07ch,07fh,0feh,07dh,0bfh,07fh,07bh,004h,03fh,0c7h,083h,01eh,009h	; 8a1a  `.7|..}..{.?....
	defb 004h,006h,01ah,0fch,0fch,038h,0c0h,01ah,0f5h,0e0h,000h,0e0h,080h,0a0h,040h,000h	; 8a2a  .....8........@.
	defb 080h,010h,037h,07ch,07fh,0feh,07dh,0bfh,07fh,07bh,004h,03fh,0d8h,0b0h,080h,000h	; 8a3a  ..7|..}..{.?....
	defb 000h,006h,01ah,0fch,0fch,038h,0c0h,01ah,0f5h,0e0h,018h,0fdh,00eh,004h,003h,000h	; 8a4a  .....8..........
	defb 000h	; 8a5a

; ----------------------------------------------------------------------
; DATOS rle_8A5B: rle a la VRAM (0x5C46) de la pieza de decoracion 0x27; lo
;   leen p00:59B9 (79 bytes)
;   0x8a5b..0x8aaa  (79 bytes)
DATA_rle_8A5B:
	defb 084h,00ch,01eh,01ah,00ch,00ch,000h,084h,030h,058h,078h,030h,00dh,000h,0bfh,06ah	; 8a5b  ........0Xx0...j
	defb 015h,03fh,010h,02ch,09eh,0dah,0adh,0d2h,0eeh,071h,00eh,007h,01bh,02ch,000h,056h	; 8a6b  .?.,.....q...,.V
	defb 0a8h,0fch,008h,034h,059h,07bh,0b5h,04bh,077h,08eh,070h,0e0h,0d8h,034h,06ah,015h	; 8a7b  ...4Y{.Kw.p..4j.
	defb 03fh,010h,02ch,01ah,01eh,02dh,012h,02eh,071h,0feh,0efh,0c7h,09bh,02ch,056h,0a8h	; 8a8b  ?.,..-..q....,V.
	defb 0fch,008h,034h,078h,058h,0b4h,048h,074h,08eh,07fh,0f7h,0e3h,0d9h,034h,000h	; 8a9b  ..4xX.Ht.....4.

; ----------------------------------------------------------------------
; DATOS rle_8AAA: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2B; lo
;   leen p00:59B9 (66 bytes)
;   0x8aaa..0x8aec  (66 bytes)
DATA_rle_8AAA:
	defb 0c0h,000h,007h,00dh,00bh,017h,007h,0ffh,000h,00ah,01ah,075h,00fh,0f3h,06dh,031h	; 8aaa  ...........u..m1
	defb 007h,000h,080h,0c0h,0e0h,0f0h,0f0h,0ffh,000h,0dch,0f0h,078h,09ch,0e0h,0f7h,0e8h	; 8aba  ...........x....
	defb 090h,007h,00dh,00bh,067h,007h,0ffh,000h,00ah,01ah,0b5h,00fh,033h,06dh,0f1h,007h	; 8aca  ....g.......3m..
	defb 030h,080h,0c0h,0e0h,0f0h,0f0h,0ffh,000h,0dch,0f0h,078h,09ch,0e0h,0e7h,0d8h,030h	; 8ada  0.........x....0
	defb 000h,000h	; 8aea

; ----------------------------------------------------------------------
; DATOS rle_8AEC: rle a la VRAM (0x5C46) de la pieza de decoracion 0x3C; lo
;   leen p00:59B9 (44 bytes)
;   0x8aec..0x8b18  (44 bytes)
DATA_rle_8AEC:
	defb 088h,024h,018h,0a5h,05ah,05ah,0a5h,018h,024h,019h,000h,09fh,006h,00fh,01fh,03fh	; 8aec  .$..ZZ..$......?
	defb 073h,079h,03fh,01fh,03fh,07bh,07bh,03dh,041h,07fh,0efh,000h,000h,080h,0e0h,0b0h	; 8afc  sy?.?{{=A.......
	defb 037h,06eh,0feh,0f4h,0f4h,0f8h,0fah,0f6h,0eeh,0dch,018h,000h	; 8b0c  7n..........

; ----------------------------------------------------------------------
; DATOS rle_8B18: rle a la VRAM (0x5C46) de la pieza de decoracion 0x32; lo
;   leen p00:59B9 (13 bytes)
;   0x8b18..0x8b25  (13 bytes)
DATA_rle_8B18:
	defb 083h,02ah,01fh,02ah,00dh,000h,083h,004h,0ffh,004h,00dh,000h,000h	; 8b18  .*.*.........

; ----------------------------------------------------------------------
; DATOS rle_8B25: rle a la VRAM (0x5C46) de la pieza de decoracion 0x3E; lo
;   leen p00:59B9 (57 bytes)
;   0x8b25..0x8b5e  (57 bytes)
DATA_rle_8B25:
	defb 08ah,010h,018h,029h,02dh,03ch,09dh,07fh,0ffh,07fh,09ch,007h,000h,089h,0a0h,040h	; 8b25  ...)-<.........@
	defb 040h,0f0h,0d8h,0e8h,0feh,0f7h,0f1h,007h,000h,002h,001h,08ah,000h,081h,05dh,0ffh	; 8b35  @.............].
	defb 07fh,0beh,016h,00ah,007h,001h,003h,000h,08dh,0a0h,040h,040h,0f0h,0dah,0efh,0f9h	; 8b45  ..........@@....
	defb 0f0h,0f8h,00ch,000h,000h,080h,003h,000h,000h	; 8b55  .........

; ----------------------------------------------------------------------
; DATOS rle_8B5E: rle a la VRAM (0x5C46) de la pieza de decoracion 0x26; lo
;   leen p00:59B9 (73 bytes)
;   0x8b5e..0x8ba7  (73 bytes)
DATA_rle_8B5E:
	defb 084h,060h,0f0h,0f0h,060h,01ch,000h,0c0h,001h,021h,021h,067h,05fh,020h,01fh,06ah	; 8b5e  .`..`....!!g_ .j
	defb 06ah,01fh,020h,01eh,02eh,036h,039h,007h,000h,008h,008h,0cch,0f4h,008h,0f0h,0ach	; 8b6e  j. ..69.........
	defb 0ach,0f0h,008h,0f0h,0e8h,0d8h,038h,0c0h,001h,021h,021h,067h,05fh,020h,01fh,06ah	; 8b7e  ......8..!!g_ .j
	defb 06ah,01fh,022h,010h,029h,036h,039h,007h,000h,008h,008h,0cch,0f4h,008h,0f0h,0ach	; 8b8e  j.".)69.........
	defb 0ach,0f0h,088h,010h,028h,0d8h,038h,0c0h,000h	; 8b9e  ....(.8..

; ----------------------------------------------------------------------
; DATOS rle_8BA7: rle a la VRAM (0x5C46) de la pieza de decoracion 0x3A; lo
;   leen p00:59B9 (27 bytes)
;   0x8ba7..0x8bc2  (27 bytes)
DATA_rle_8BA7:
	defb 084h,00eh,031h,06eh,05fh,003h,0bfh,084h,05fh,06eh,031h,00eh,006h,000h,083h,080h	; 8ba7  ..1n_..._n1.....
	defb 0c0h,040h,003h,0a0h,083h,040h,0c0h,080h,006h,000h,000h	; 8bb7  .@...@.....

; ----------------------------------------------------------------------
; DATOS rle_8BC2: rle a la VRAM (0x5C46) de la pieza de decoracion 0x39; lo
;   leen p00:59B9 (33 bytes)
;   0x8bc2..0x8be3  (33 bytes)
DATA_rle_8BC2:
	defb 08dh,015h,04fh,03fh,0bfh,07fh,0efh,07fh,0dfh,07bh,0afh,035h,04fh,015h,003h,000h	; 8bc2  ..O?.....{.5O...
	defb 08dh,020h,0c8h,0f0h,0f4h,0f8h,0fch,0f8h,0fch,0f8h,0f4h,0f0h,0c8h,020h,003h,000h	; 8bd2  . ........... ..
	defb 000h	; 8be2

; ----------------------------------------------------------------------
; DATOS rle_8BE3: rle a la VRAM (0x5C46) de la pieza de decoracion 0x43; lo
;   leen p00:59B9 (115 bytes)
;   0x8be3..0x8c56  (115 bytes)
DATA_rle_8BE3:
	defb 081h,060h,003h,0f0h,084h,0b0h,0f0h,0f0h,0b0h,004h,0f0h,003h,0b0h,081h,0f0h,010h	; 8be3  .`..............
	defb 000h,081h,0b0h,003h,0f0h,081h,0b0h,005h,0f0h,002h,0b0h,002h,0f0h,082h,0b0h,0f0h	; 8bf3  ................
	defb 010h,000h,002h,0b0h,002h,0f0h,085h,0b0h,0f0h,0b0h,0f0h,0f0h,003h,0b0h,003h,0f0h	; 8c03  ................
	defb 081h,060h,012h,000h,09eh,003h,007h,039h,07eh,0ffh,0ffh,0f9h,0feh,0ffh,07fh,01bh	; 8c13  .`.....9~.......
	defb 007h,01ah,025h,001h,001h,081h,0cdh,0b2h,06fh,08fh,0b7h,057h,065h,06fh,09ah,0b0h	; 8c23  ..%.....o..Weo..
	defb 0d9h,0efh,023h,004h,000h,08dh,001h,03eh,07eh,0ffh,0fbh,0fdh,0fdh,07dh,079h,03eh	; 8c33  ..#....>~....}y>
	defb 06bh,094h,000h,003h,001h,08ch,0cdh,0b2h,06fh,08fh,0b7h,057h,065h,06fh,09ah,051h	; 8c43  k.......o..Weo.Q
	defb 01fh,087h,000h	; 8c53

; ----------------------------------------------------------------------
; DATOS rle_8C56: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2C; lo
;   leen p00:59B9 (110 bytes)
;   0x8c56..0x8cc4  (110 bytes)
DATA_rle_8C56:
	defb 005h,000h,082h,01fh,023h,003h,03fh,086h,02fh,07eh,0ffh,0edh,0bfh,079h,006h,000h	; 8c56  ....#.?./~...y..
	defb 005h,080h,091h,0c0h,0f0h,0f8h,0eeh,0ffh,000h,000h,001h,003h,007h,01dh,03fh,02eh	; 8c66  ..............?.
	defb 03bh,01fh,007h,001h,004h,000h,092h,040h,0f0h,0f8h,07ch,0fch,0f8h,0f0h,0e0h,0e0h	; 8c76  .......@..|.....
	defb 0f0h,070h,0f8h,0d8h,07ch,03fh,000h,01fh,023h,003h,03fh,086h,02fh,07eh,0ffh,0edh	; 8c86  .p..|?..#.?./~..
	defb 0bfh,079h,006h,000h,005h,080h,085h,0c0h,0f0h,0f8h,0eeh,0ffh,007h,000h,09eh,018h	; 8c96  .y..............
	defb 03ch,07eh,07fh,0ffh,06fh,03eh,01bh,00fh,007h,006h,003h,000h,000h,002h,002h,006h	; 8ca6  <~..o>..........
	defb 01eh,07eh,0f6h,0fch,0d8h,0f0h,0e0h,060h,0c0h,0c0h,080h,000h,000h,000h	; 8cb6  .~.....`......

; ----------------------------------------------------------------------
; DATOS rle_8CC4: rle a la VRAM (0x5C46) de la pieza de decoracion 0x1F; lo
;   leen p00:59B9 (98 bytes)
;   0x8cc4..0x8d26  (98 bytes)
DATA_rle_8CC4:
	defb 09eh,007h,004h,026h,01bh,07fh,03fh,07fh,07fh,07eh,0ffh,0bfh,03fh,0feh,0ddh,062h	; 8cc4  ...&..?..~..?..b
	defb 073h,080h,0f8h,0e8h,0f4h,0deh,0e2h,0f8h,0e0h,0f8h,07eh,00fh,041h,0c0h,080h,003h	; 8cd4  s.........~.A...
	defb 000h,0bfh,007h,004h,026h,01bh,07fh,03fh,07bh,07dh,07dh,0fbh,0bbh,09bh,047h,006h	; 8ce4  ....&..?{}}...G.
	defb 00ch,000h,080h,0f8h,0e8h,0f4h,0deh,0cah,0c0h,0e8h,0bch,080h,04dh,07ah,074h,028h	; 8cf4  ............Mzt(
	defb 000h,003h,002h,003h,05dh,03fh,039h,09eh,0a3h,07dh,03bh,01ch,03fh,037h,018h,00ch	; 8d04  ....]?9..}..?7..
	defb 004h,0c0h,07ch,074h,0fah,0efh,0f1h,0f8h,07ch,060h,056h,0b2h,0b4h,060h,080h,0c0h	; 8d14  ..|t....|`V..`..
	defb 040h,000h	; 8d24

; ----------------------------------------------------------------------
; DATOS rle_8D26: rle a la VRAM (0x5C46) de la pieza de decoracion 0x0B; lo
;   leen p00:59B9 (44 bytes)
;   0x8d26..0x8d52  (44 bytes)
DATA_rle_8D26:
	defb 002h,000h,087h,003h,01fh,066h,019h,063h,00ch,031h,009h,000h,087h,0f6h,0cbh,0a9h	; 8d26  .....f.c.1......
	defb 026h,020h,0c0h,080h,008h,000h,087h,003h,01fh,076h,009h,00ah,031h,042h,008h,000h	; 8d36  & .......v..1B..
	defb 088h,006h,0ebh,0c9h,0a6h,020h,040h,034h,00ah,008h,000h,000h	; 8d46  ..... @4....

; ----------------------------------------------------------------------
; DATOS rle_8D52: rle a la VRAM (0x5C46) de la pieza de decoracion 0x25; lo
;   leen p00:59B9 (155 bytes)
;   0x8d52..0x8ded  (155 bytes)
DATA_rle_8D52:
	defb 002h,000h,09eh,01fh,03fh,030h,026h,039h,08fh,0c9h,0c6h,0c1h,0e1h,067h,068h,063h	; 8d52  ....?0&9.....ghc
	defb 02ch,000h,000h,080h,0c0h,0c0h,040h,0cch,014h,062h,091h,092h,024h,072h,050h,04ah	; 8d62  ,.....@..b..$rPJ
	defb 08dh,006h,000h,002h,001h,088h,011h,031h,034h,06bh,070h,0cah,0c1h,08eh,005h,000h	; 8d72  .......14kp.....
	defb 08bh,0fch,0feh,086h,032h,0ceh,078h,048h,0b4h,042h,038h,0c6h,008h,000h,088h,007h	; 8d82  ....2.xH.B8.....
	defb 00eh,00ch,00dh,00dh,02ch,00eh,0a7h,008h,000h,002h,080h,0c6h,0e0h,050h,054h,0e1h	; 8d92  ....,........PT.
	defb 086h,09dh,007h,00fh,01fh,01fh,00fh,000h,004h,008h,016h,06bh,070h,010h,008h,018h	; 8da2  ...........kp...
	defb 030h,03eh,0e0h,0f0h,0e0h,0f0h,0cah,083h,083h,0c3h,073h,008h,0ebh,07bh,00bh,008h	; 8db2  0>........s..{..
	defb 002h,000h,000h,007h,00fh,01fh,01fh,00fh,000h,004h,008h,016h,073h,05ch,026h,062h	; 8dc2  ............s\&b
	defb 0c6h,0f7h,000h,0e0h,0f0h,0e0h,0e0h,0f2h,09bh,0c3h,073h,003h,008h,0ebh,07bh,00bh	; 8dd2  ..........s...{.
	defb 008h,0c2h,00bh,000h,083h,0feh,0ffh,0feh,012h,000h,000h	; 8de2  ...........

; ----------------------------------------------------------------------
; DATOS rle_8DED: rle a la VRAM (0x5C46) de la pieza de decoracion 0x06; lo
;   leen p00:59B9 (221 bytes)
;   0x8ded..0x8eca  (221 bytes)
DATA_rle_8DED:
	defb 004h,002h,081h,00ch,004h,010h,002h,028h,002h,044h,002h,080h,081h,040h,010h,000h	; 8ded  .......(.D...@..
	defb 002h,001h,004h,000h,085h,003h,004h,008h,008h,030h,003h,050h,089h,008h,00eh,000h	; 8dfd  .........0.P....
	defb 000h,080h,060h,050h,048h,088h,003h,004h,087h,00ah,009h,011h,010h,010h,000h,080h	; 8e0d  ..`PH...........
	defb 003h,040h,08ch,020h,03eh,021h,020h,030h,008h,008h,00eh,009h,008h,010h,010h,007h	; 8e1d  .@. >! 0........
	defb 000h,081h,080h,004h,000h,081h,0c0h,003h,020h,005h,000h,087h,003h,004h,008h,008h	; 8e2d  ........ .......
	defb 038h,020h,0c0h,004h,000h,003h,001h,084h,006h,078h,0d0h,010h,003h,020h,002h,010h	; 8e3d  8 .......x... ..
	defb 002h,020h,002h,010h,002h,008h,002h,010h,08ah,008h,014h,014h,013h,008h,008h,010h	; 8e4d  . ..............
	defb 010h,008h,008h,009h,000h,086h,080h,060h,010h,010h,018h,006h,003h,002h,008h,000h	; 8e5d  .......`........
	defb 088h,001h,009h,018h,002h,02ch,03dh,07fh,0ffh,00ah,000h,086h,040h,050h,080h,0a0h	; 8e6d  .....,=.....@P..
	defb 0c0h,0e0h,008h,000h,088h,004h,001h,008h,009h,032h,077h,07fh,0ffh,007h,000h,094h	; 8e7d  .........2w.....
	defb 040h,0c0h,010h,004h,060h,0d8h,0f2h,0f8h,0f4h,003h,037h,06fh,0ffh,0f3h,0f9h,0ffh	; 8e8d  @...`.....7o....
	defb 0ffh,06fh,00fh,007h,005h,000h,08bh,0e0h,0f4h,0feh,0feh,09fh,03fh,0ffh,0fdh,0fch	; 8e9d  .o..........?...
	defb 0d8h,0c0h,005h,000h,089h,001h,01bh,03fh,07fh,077h,079h,03fh,00fh,007h,007h,000h	; 8ead  .......?.wy?....
	defb 089h,0e0h,0f0h,0fch,0feh,0deh,03eh,0fch,0e0h,0c0h,007h,000h,000h	; 8ebd  ......>......

; ----------------------------------------------------------------------
; DATOS rle_8ECA: rle a la VRAM (0x5C46) de la pieza de decoracion 0x13; lo
;   leen p00:59B9 (184 bytes)
;   0x8eca..0x8f82  (184 bytes)
DATA_rle_8ECA:
	defb 083h,003h,037h,06fh,003h,0ffh,083h,06fh,01fh,00fh,007h,000h,088h,0c0h,020h,0d8h	; 8eca  ..7o...o...... .
	defb 0dch,0dch,0b4h,0f8h,0b0h,008h,000h,087h,00eh,01fh,05eh,0ffh,0ffh,07eh,00fh,00bh	; 8eda  ..........^..~..
	defb 000h,084h,0e0h,0f0h,0f0h,0e0h,00ah,000h,003h,001h,089h,011h,00bh,005h,00bh,0ffh	; 8eea  ................
	defb 00bh,005h,00bh,011h,003h,001h,004h,000h,089h,010h,0a0h,040h,0a0h,0feh,0a0h,040h	; 8efa  ...........@...@
	defb 0a0h,010h,004h,000h,088h,082h,0c1h,06dh,01eh,0dah,06dh,003h,002h,008h,000h,088h	; 8f0a  .......m..m.....
	defb 082h,006h,06ch,0f0h,0b6h,06ch,080h,080h,008h,000h,088h,002h,001h,06dh,0deh,01ah	; 8f1a  ..l..l.......m..
	defb 06dh,0c3h,002h,008h,000h,088h,080h,000h,06ch,0f6h,0b0h,06ch,086h,080h,008h,000h	; 8f2a  m.......l..l....
	defb 086h,010h,038h,000h,07ch,000h,0feh,01ah,000h,09dh,047h,03ch,04bh,036h,017h,029h	; 8f3a  ..8.|.....G<K6.)
	defb 006h,00dh,035h,038h,01fh,0e0h,0b6h,084h,042h,000h,0c0h,020h,050h,0b0h,080h,060h	; 8f4a  ..58....B.. P..`
	defb 0a0h,010h,0bch,0d2h,040h,040h,080h,004h,000h,09bh,047h,03ch,04bh,036h,017h,029h	; 8f5a  ....@@....G<K6.)
	defb 006h,00dh,035h,038h,01fh,001h,00eh,008h,004h,000h,0c0h,020h,050h,0b0h,080h,060h	; 8f6a  ..58....... P..`
	defb 0a0h,008h,0c4h,070h,088h,004h,000h,000h	; 8f7a  ...p....

; ----------------------------------------------------------------------
; DATOS rle_8F82: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2D; lo
;   leen p00:59B9 (83 bytes)
;   0x8f82..0x8fd5  (83 bytes)
DATA_rle_8F82:
	defb 085h,000h,007h,01fh,03fh,03fh,004h,07fh,09dh,07dh,03eh,01fh,00fh,00fh,01eh,01fh	; 8f82  ....??...}>.....
	defb 000h,0f0h,0bch,0ceh,0ffh,0f3h,07ch,0a7h,0d8h,0dch,0ech,068h,020h,000h,000h,0c0h	; 8f92  ......|....h ...
	defb 000h,000h,007h,01eh,03fh,03fh,004h,07fh,096h,07dh,03eh,07dh,078h,0f1h,0fdh,01eh	; 8fa2  ....??...}>}x...
	defb 0ffh,0fah,0f2h,030h,0e0h,0e8h,07ah,0afh,0d0h,0dch,0ech,068h,0a0h,0c0h,0f8h,003h	; 8fb2  ...0..z....h....
	defb 000h,083h,033h,000h,00fh,00ah,000h,088h,038h,044h,046h,009h,001h,001h,046h,038h	; 8fc2  ..3.....8DF...F8
	defb 008h,000h,000h	; 8fd2

; ----------------------------------------------------------------------
; DATOS rle_8FD5: rle a la VRAM (0x5C46) de la pieza de decoracion 0x22; lo
;   leen p00:59B9 (72 bytes)
;   0x8fd5..0x901d  (72 bytes)
DATA_rle_8FD5:
	defb 0c4h,01ch,00eh,002h,01eh,007h,07bh,0ceh,096h,0cfh,07bh,006h,01eh,00fh,003h,000h	; 8fd5  ......{...{.....
	defb 000h,038h,070h,0c0h,0f8h,060h,05eh,0f3h,0e9h,073h,05ch,0e0h,0f8h,0f0h,0c0h,000h	; 8fe5  .8p..`^..s\.....
	defb 000h,0e0h,070h,010h,028h,07ch,07ah,0f9h,0f8h,0fch,0fch,07eh,03eh,01fh,003h,000h	; 8ff5  ..p.(|z....~>...
	defb 000h,007h,00eh,008h,014h,03eh,05eh,09fh,01fh,03fh,03fh,07eh,07ch,0f8h,0c0h,000h	; 9005  .....>^..??~|...
	defb 000h,070h,0b0h,0f0h,0e0h,01ch,000h,000h	; 9015  .p......

; ----------------------------------------------------------------------
; DATOS rle_901D: rle a la VRAM (0x5C46) de la pieza de decoracion 0x17; lo
;   leen p00:59B9 (295 bytes)
;   0x901d..0x9144  (295 bytes)
DATA_rle_901D:
	defb 00ch,000h,081h,001h,003h,003h,007h,000h,085h,001h,037h,077h,07fh,067h,003h,0dfh	; 901d  ..........7w.g..
	defb 081h,0efh,007h,000h,089h,0e0h,0f0h,0f7h,08fh,077h,0f7h,0f7h,0efh,0fdh,00ah,000h	; 902d  .........w......
	defb 003h,080h,085h,000h,0c0h,0e0h,001h,003h,003h,007h,082h,003h,001h,009h,000h,08ah	; 903d  ................
	defb 0bfh,07fh,07fh,07dh,0bdh,0ceh,0dfh,01fh,01fh,00eh,006h,000h,002h,0feh,087h,0f6h	; 904d  ...}............
	defb 0f5h,0f7h,0efh,01eh,0beh,09ch,007h,000h,003h,0f0h,082h,0e0h,0c0h,00dh,000h,08eh	; 905d  ................
	defb 002h,001h,000h,008h,004h,002h,001h,000h,061h,018h,003h,00fh,01fh,01fh,004h,002h	; 906d  ........a.......
	defb 089h,082h,001h,07bh,0f7h,077h,0bfh,07fh,08fh,0bfh,003h,07fh,002h,000h,002h,080h	; 907d  ...{.w..........
	defb 087h,000h,0f0h,0f8h,0fbh,0ffh,08fh,077h,004h,0fbh,081h,0f6h,003h,000h,090h,040h	; 908d  .......w.......@
	defb 088h,010h,020h,040h,080h,0c0h,0c3h,0cch,0c0h,080h,0e0h,0f7h,0dbh,017h,06eh,003h	; 909d  .. @..........n.
	defb 00eh,087h,025h,002h,005h,00ah,014h,020h,040h,003h,000h,082h,0bfh,0cfh,003h,0ffh	; 90ad  ..%.... @.......
	defb 088h,077h,00fh,0ffh,03dh,03eh,01fh,04eh,080h,003h,000h,004h,0ffh,088h,0eeh,0f7h	; 90bd  .w..=>.N........
	defb 0f6h,0f7h,0efh,01fh,07eh,0bch,004h,080h,08eh,078h,07ah,078h,078h,0f0h,0e0h,040h	; 90cd  ....~....xzxx..@
	defb 020h,010h,040h,020h,010h,008h,004h,008h,000h,083h,03ch,07eh,05eh,003h,0bfh,084h	; 90dd   .@ ......<~^...
	defb 0ffh,07eh,07eh,03ch,018h,000h,088h,01eh,07fh,0dfh,0bfh,0bfh,0ffh,07fh,01eh,009h	; 90ed  .~~<............
	defb 000h,081h,080h,004h,0c0h,0beh,080h,000h,000h,047h,03fh,09ch,07eh,03fh,0bfh,07fh	; 90fd  .........G?.~?..
	defb 03fh,01fh,0bfh,07eh,0afh,044h,087h,00ah,000h,080h,0e0h,0f0h,060h,0deh,0bfh,0bbh	; 910d  ?..~.D......`...
	defb 0ddh,060h,078h,0f0h,080h,0c0h,030h,0a8h,047h,03ch,09eh,07fh,03fh,0bfh,07fh,03fh	; 911d  .`x...0.G<..?..?
	defb 07dh,0adh,05bh,0b7h,00bh,014h,068h,000h,080h,0eeh,05fh,0b1h,0a0h,0a8h,0b4h,0deh	; 912d  }.[...h..._.....
	defb 0e0h,0f0h,0e0h,0c0h,004h,000h,000h	; 913d

; ----------------------------------------------------------------------
; DATOS rle_9144: rle a la VRAM (0x5C46) de la pieza de decoracion 0x4C; lo
;   leen p00:59B9 (257 bytes)
;   0x9144..0x9245  (257 bytes)
DATA_rle_9144:
	defb 007h,000h,089h,002h,001h,002h,008h,007h,000h,00dh,002h,00dh,004h,000h,08ch,004h	; 9144  ................
	defb 014h,092h,04dh,0cbh,03fh,0ffh,0ffh,0afh,0ffh,0f7h,0bfh,004h,000h,08ch,040h,04ch	; 9154  ..M.?.........@L
	defb 090h,021h,0eeh,078h,0ffh,0feh,0ffh,0feh,0ffh,0ffh,006h,000h,093h,080h,000h,000h	; 9164  .!.x............
	defb 0c0h,010h,060h,080h,070h,0c0h,010h,012h,005h,00ah,013h,002h,00dh,000h,003h,004h	; 9174  ..`.p...........
	defb 007h,000h,08dh,0ffh,0bfh,0f7h,0dfh,0fdh,06fh,0bbh,05fh,054h,096h,0aah,04ah,001h	; 9184  ........o._T..J.
	defb 003h,000h,002h,0ffh,08ah,0fbh,0ffh,077h,0ddh,07eh,0ebh,0a4h,097h,051h,048h,004h	; 9194  .......w.~...QH.
	defb 000h,089h,060h,080h,030h,0e0h,000h,090h,0e0h,000h,0c0h,00eh,000h,089h,001h,002h	; 91a4  ..`.0...........
	defb 000h,002h,009h,004h,003h,004h,003h,005h,000h,08bh,022h,011h,096h,068h,02fh,0deh	; 91b4  .........."..h/.
	defb 07fh,05fh,0f7h,0dfh,07fh,004h,000h,08ch,020h,040h,024h,069h,099h,0e2h,0feh,0bdh	; 91c4  ._...... @$i....
	defb 0feh,0ffh,0feh,0ffh,009h,000h,08fh,020h,0c0h,000h,0c0h,020h,040h,0a0h,00ch,002h	; 91d4  ....... ... @...
	defb 00dh,001h,006h,000h,002h,001h,008h,000h,08bh,0f7h,05dh,0ffh,07fh,06dh,09fh,0a7h	; 91e4  ..........]..m..
	defb 02ah,051h,091h,00ah,005h,000h,08bh,0feh,0ffh,0f6h,0ech,0ffh,07ah,0e5h,054h,04bh	; 91f4  *Q..........z.TK
	defb 028h,044h,006h,000h,087h,0c0h,020h,080h,040h,000h,080h,040h,008h,000h,08ah,040h	; 9204  (D.... .@..@...@
	defb 080h,080h,040h,020h,020h,026h,019h,001h,002h,016h,000h,08ah,010h,008h,008h,018h	; 9214  ..@  &..........
	defb 020h,020h,010h,010h,060h,080h,016h,000h,085h,006h,009h,008h,070h,080h,00bh,000h	; 9224    ..`.......p...
	defb 082h,040h,080h,00eh,000h,002h,080h,086h,078h,006h,001h,002h,002h,001h,018h,000h	; 9234  .@......x.......
	defb 000h	; 9244

; ----------------------------------------------------------------------
; DATOS rle_9245: rle a la VRAM (0x5C46) de la pieza de decoracion 0x30; lo
;   leen p00:59B9 (110 bytes)
;   0x9245..0x92b3  (110 bytes)
DATA_rle_9245:
	defb 00ah,000h,0a5h,001h,007h,08ch,09bh,07eh,038h,000h,000h,002h,005h,002h,001h,004h	; 9245  .......~8.......
	defb 002h,005h,003h,0efh,0ffh,0fch,077h,039h,00fh,000h,092h,049h,025h,09fh,07fh,0feh	; 9255  ......w9...I%...
	defb 0ffh,0f7h,0efh,0f7h,0f8h,077h,0bfh,0cch,005h,000h,08ch,002h,0c5h,06eh,038h,0e0h	; 9265  .....w.......n8.
	defb 0c0h,0c0h,0b0h,008h,0f6h,0dbh,029h,009h,000h,087h,010h,011h,023h,023h,037h,01fh	; 9275  ......).....##7.
	defb 00fh,003h,000h,09dh,001h,004h,002h,005h,00ah,005h,0cbh,0e6h,0feh,07dh,06dh,0b5h	; 9285  .............}m.
	defb 01eh,000h,000h,020h,014h,08ah,04ah,03fh,0ffh,0feh,07fh,0f7h,0f7h,0e0h,0dfh,0ffh	; 9295  ... ..J?........
	defb 0f9h,007h,000h,089h,0c0h,070h,038h,0eeh,0c5h,0c2h,000h,0c0h,0a0h,000h	; 92a5  .....p8.......

; ----------------------------------------------------------------------
; DATOS rle_92B3: rle a la VRAM (0x5C46) de la pieza de decoracion 0x15; lo
;   leen p00:59B9 (122 bytes)
;   0x92b3..0x932d  (122 bytes)
DATA_rle_92B3:
	defb 086h,0b4h,078h,0fch,0fch,078h,0b4h,020h,000h,082h,03ch,07fh,003h,0ffh,085h,0f0h	; 92b3  ..x..x. ..<.....
	defb 060h,031h,003h,007h,006h,000h,08ch,010h,00ch,086h,0e6h,0c6h,093h,05fh,0dbh,0edh	; 92c3  `1..........._..
	defb 0efh,017h,01fh,003h,00fh,002h,007h,082h,005h,002h,007h,000h,0b7h,0ebh,0b5h,075h	; 92d3  ...............u
	defb 07ah,07bh,0bch,05fh,03bh,0bch,078h,03eh,00eh,00ch,058h,030h,000h,000h,001h,00fh	; 92e3  z{._..x>..X0....
	defb 01fh,03eh,03eh,07eh,04fh,0bfh,0b3h,027h,04fh,05fh,012h,021h,021h,000h,0f8h,0a4h	; 92f3  .>>~O..'O_.!!...
	defb 040h,080h,090h,08ch,046h,0b6h,0e6h,0d3h,09fh,06bh,0edh,0ebh,0e9h,003h,003h,00bh	; 9303  @...F....k......
	defb 007h,007h,003h,003h,003h,001h,006h,000h,002h,0f4h,08eh,0dah,0dbh,0bch,08fh,0f7h	; 9313  ................
	defb 0cdh,0eeh,054h,0a8h,01eh,00eh,00ch,058h,030h,000h	; 9323  ..T....X0.

; ----------------------------------------------------------------------
; DATOS rle_932D: rle a la VRAM (0x5C46) de la pieza de decoracion 0x2A; lo
;   leen p00:59B9 (34 bytes)
;   0x932d..0x934f  (34 bytes)
DATA_rle_932D:
	defb 0a0h,003h,02fh,00eh,09dh,039h,016h,037h,07bh,07dh,0ech,05dh,0beh,07fh,0feh,03dh	; 932d  ../..9.7{}.]...=
	defb 08fh,0c0h,074h,0b0h,0d8h,0c8h,0ach,0edh,06ch,0deh,016h,0d9h,0bch,03eh,07fh,0fch	; 933d  ..t.....l....>..
	defb 0f2h,000h	; 934d

; ----------------------------------------------------------------------
; DATOS rle_934F: rle a la VRAM (0x5C46) de la pieza de decoracion 0x19; lo
;   leen p00:59B9 (287 bytes)
;   0x934f..0x946e  (287 bytes)
DATA_rle_934F:
	defb 007h,000h,089h,038h,0c7h,038h,0ffh,0c3h,07ch,073h,03eh,03fh,005h,000h,08bh,010h	; 934f  ...8.8..|s>?....
	defb 008h,008h,08bh,067h,097h,0e5h,077h,085h,073h,08ch,005h,000h,08bh,008h,010h,010h	; 935f  ...g..w.s.......
	defb 0d1h,0e6h,0e9h,0e7h,0eeh,061h,0ceh,031h,007h,000h,08fh,01ch,0e3h,01ch,0ffh,0c3h	; 936f  .....a.1........
	defb 03eh,0ceh,07ch,0fch,01ch,003h,005h,005h,002h,001h,00ah,000h,08bh,07bh,0f1h,0f7h	; 937f  >.|..........{..
	defb 0f7h,02ah,0d7h,017h,011h,023h,001h,001h,005h,000h,08bh,0deh,06fh,0efh,0efh,0d4h	; 938f  .*...#......o...
	defb 0ebh,0e8h,068h,0c4h,080h,080h,005h,000h,086h,038h,0c0h,0a0h,0a0h,040h,080h,00fh	; 939f  ..h......8...@..
	defb 000h,082h,001h,002h,004h,003h,003h,001h,008h,000h,08ah,090h,048h,048h,0abh,057h	; 93af  ............HH.W
	defb 06ah,093h,0aah,0f9h,0f4h,006h,000h,08ah,009h,012h,012h,0d5h,0eah,0d6h,0c9h,0d5h	; 93bf  j...............
	defb 09fh,02fh,005h,000h,082h,080h,040h,004h,0c0h,003h,080h,012h,000h,08ah,06bh,019h	; 93cf  ./....@.......k.
	defb 03bh,05bh,055h,05bh,059h,02bh,029h,011h,006h,000h,08ah,0d6h,058h,0dch,0dah,06ah	; 93df  .[U[Y+).....X..j
	defb 0dah,05ah,0d4h,094h,088h,018h,000h,08ch,004h,0e2h,09ch,0e3h,07bh,07bh,064h,01bh	; 93ef  .Z..........{{d.
	defb 039h,01bh,002h,001h,004h,000h,08ch,020h,047h,039h,0c7h,0deh,0deh,026h,0d8h,05ch	; 93ff  9...... G9...&.\
	defb 0d8h,0c0h,080h,003h,000h,08dh,010h,014h,01ah,01ch,01dh,01dh,00dh,002h,00dh,00dh	; 940f  ................
	defb 00ch,00dh,004h,003h,000h,088h,008h,028h,058h,038h,0b8h,0b8h,0b0h,040h,004h,0b0h	; 941f  .......(X8...@..
	defb 081h,020h,003h,000h,087h,0d2h,0edh,0edh,073h,00ch,06dh,02dh,009h,000h,003h,0c0h	; 942f  . ......s.m-....
	defb 083h,080h,000h,080h,009h,000h,089h,040h,052h,06dh,02dh,033h,00ch,02dh,02dh,021h	; 943f  .......@Rm-3.--!
	defb 007h,000h,003h,080h,00dh,000h,085h,088h,0d8h,020h,0d8h,050h,01bh,000h,002h,050h	; 944f  ......... .P...P
	defb 083h,020h,050h,050h,01bh,000h,085h,020h,070h,0f8h,070h,020h,01bh,000h,000h	; 945f  . PP... p.p ...

; ----------------------------------------------------------------------
; DATOS rle_946E: rle a la VRAM (0x5C46) de la pieza de decoracion 0x16; lo
;   leen p00:59B9 (259 bytes)
;   0x946e..0x9571  (259 bytes)
DATA_rle_946E:
	defb 086h,078h,0dch,0bch,0bch,0fch,078h,01dh,000h,0adh,00fh,03fh,07fh,07fh,0f8h,0f0h	; 946e  .x....x....?....
	defb 0e0h,0e0h,071h,073h,033h,033h,077h,000h,000h,001h,0c0h,0f1h,0f8h,0f9h,0fch,07ch	; 947e  ..qs33w........|
	defb 0fch,0fch,0f8h,0f8h,0f0h,0efh,0ffh,000h,000h,050h,0aah,05fh,0b9h,07dh,0beh,07eh	; 948e  .........P._.}.~
	defb 0beh,07fh,01eh,01fh,00fh,01fh,0ffh,004h,000h,002h,080h,0a2h,070h,0f8h,08ch,0f4h	; 949e  ............p...
	defb 000h,0c0h,020h,060h,050h,0b0h,067h,067h,0c7h,087h,083h,083h,041h,001h,01dh,01fh	; 94ae  .. `P.gg....A...
	defb 017h,01bh,00bh,019h,068h,010h,0bfh,06ah,055h,055h,095h,0e6h,0f9h,0ffh,003h,0feh	; 94be  ....h..jUU......
	defb 092h,0fdh,0f2h,0cfh,000h,000h,0ffh,0dfh,0b9h,0beh,0bfh,0dfh,01fh,0f7h,0c8h,036h	; 94ce  ...............6
	defb 0bah,0dch,0e0h,003h,000h,08dh,0a0h,090h,0b0h,0b0h,040h,076h,0a5h,0c5h,0f8h,01eh	; 94de  ..........@v....
	defb 005h,005h,00ah,005h,000h,094h,007h,00fh,01fh,01fh,01dh,038h,038h,039h,071h,073h	; 94ee  ...........889qs
	defb 0e3h,0c3h,0c7h,086h,000h,001h,080h,0c1h,0e0h,0e1h,003h,0f0h,002h,0e4h,095h,096h	; 94fe  ................
	defb 053h,05bh,06dh,0afh,000h,050h,0aah,05fh,0b9h,07dh,0beh,07eh,0beh,07fh,03eh,01eh	; 950e  S[m..P._.}.~..>.
	defb 01fh,0cfh,0efh,0efh,003h,000h,0a0h,0bch,072h,060h,0c0h,0a0h,0d0h,078h,080h,0c0h	; 951e  ........r`...x..
	defb 020h,060h,050h,0b0h,086h,0c6h,047h,067h,023h,023h,041h,001h,01dh,01fh,017h,01bh	; 952e   `P...Gg##A.....
	defb 00bh,019h,068h,010h,0b7h,0dfh,07fh,003h,0ffh,081h,0fdh,004h,0feh,089h,0fdh,0f2h	; 953e  ..h.............
	defb 0cfh,000h,000h,0efh,0dfh,0f9h,0feh,003h,0ffh,086h,0f7h,0c8h,036h,0bah,0dch,0e0h	; 954e  ............6...
	defb 003h,000h,08dh,0a0h,090h,0b0h,0b0h,040h,076h,0a5h,0c5h,0f8h,01eh,005h,005h,00ah	; 955e  .......@v.......
	defb 003h,000h,000h	; 956e

; ----------------------------------------------------------------------
; DATOS rle_9571: rle a la VRAM (0x5C46) de la pieza de decoracion 0x36; lo
;   leen p00:59B9 (64 bytes)
;   0x9571..0x95b1  (64 bytes)
DATA_rle_9571:
	defb 0aah,002h,001h,007h,01fh,01ch,03bh,03ah,038h,01ch,01fh,067h,09ah,085h,069h,009h	; 9571  .......:8..g..i.
	defb 005h,080h,000h,0c0h,0f0h,070h,038h,038h,0b8h,070h,0f0h,0cch,0b2h,042h,02ch,020h	; 9581  .....p88.p...B,
	defb 040h,007h,01fh,01ch,038h,03ah,03bh,01ch,01fh,007h,003h,004h,005h,08ch,003h,001h	; 9591  @...8:..........
	defb 0c0h,0f0h,070h,0b8h,038h,038h,070h,0f0h,0c0h,080h,004h,040h,082h,080h,000h,000h	; 95a1  ..p.88p....@....

; ----------------------------------------------------------------------
; DATOS rle_95B1: rle a la VRAM (0x5C46) de la pieza de decoracion 0x42; lo
;   leen p00:59B9 (40 bytes)
;   0x95b1..0x95d9  (40 bytes)
DATA_rle_95B1:
	defb 083h,004h,044h,0eeh,00dh,0ffh,083h,004h,044h,0eeh,00dh,0ffh,006h,000h,002h,001h	; 95b1  ..D.....D.......
	defb 081h,003h,005h,007h,092h,003h,000h,000h,003h,01ch,03bh,03fh,0fbh,08dh,065h,063h	; 95c1  ...........?..ec
	defb 07ah,0bdh,0e7h,0c2h,0cdh,0efh,078h,000h	; 95d1  z.....x.

; ----------------------------------------------------------------------
; DATOS rle_95D9: rle a la VRAM (0x5C46) de la pieza de decoracion 0x42; lo
;   leen p00:59B9 (48 bytes)
;   0x95d9..0x9609  (48 bytes)
DATA_rle_95D9:
	defb 020h,0ffh,090h,07eh,06eh,07eh,056h,0fch,0ech,0bch,0fch,06eh,07eh,05eh,076h,0dch	; 95d9   ..~n~V....n~^v.
	defb 0fch,0ach,0fch,010h,000h,090h,038h,03ch,06ch,07eh,0deh,0fch,0bch,0ech,07eh,05eh	; 95e9  ......8<l~....~^
	defb 076h,05eh,0fch,0ech,0bch,0fch,010h,000h,084h,060h,0d0h,0f0h,060h,01ch,000h,000h	; 95f9  v^.......`..`...

; ----------------------------------------------------------------------
; DATOS rle_9609: rle a la VRAM (0x5C46) de la pieza de decoracion 0x40; lo
;   leen p00:59B9 (172 bytes)
;   0x9609..0x96b5  (172 bytes)
DATA_rle_9609:
	defb 085h,078h,0bch,0cch,0fch,078h,01bh,000h,083h,022h,0d5h,008h,00dh,000h,083h,020h	; 9609  .x...x...".....
	defb 057h,088h,00dh,000h,003h,040h,08dh,020h,040h,080h,040h,020h,040h,080h,040h,020h	; 9619  W....@. @.@ @.@
	defb 040h,080h,040h,040h,014h,000h,0ach,001h,000h,001h,004h,003h,000h,00bh,004h,003h	; 9629  @.@@............
	defb 007h,008h,003h,000h,005h,055h,02ah,02fh,0dfh,07fh,0ffh,07fh,0ffh,0d8h,0e2h,0e0h	; 9639  .....U*/........
	defb 0f0h,0fch,0ffh,080h,050h,055h,0a9h,0f6h,0fbh,0fch,0ffh,0feh,0ffh,01bh,007h,007h	; 9649  ....PU..........
	defb 00fh,03fh,0feh,005h,000h,094h,0a0h,040h,080h,040h,090h,060h,080h,020h,0d0h,080h	; 9659  .?.....@.@.`. ..
	defb 060h,00ch,012h,005h,005h,01bh,005h,004h,002h,004h,007h,000h,0a9h,07fh,0ffh,0bfh	; 9669  `...............
	defb 057h,054h,055h,0abh,0a4h,06ah,05bh,096h,00dh,005h,009h,000h,000h,0ffh,0feh,0ffh	; 9679  WTU..j[.........
	defb 0eah,0aah,055h,055h,0aah,0aah,05ah,054h,052h,088h,040h,080h,000h,0c8h,0a0h,058h	; 9689  ..UU..ZTR.@....X
	defb 0e0h,090h,040h,080h,080h,040h,00fh,000h,086h,003h,002h,004h,01ch,010h,020h,004h	; 9699  ..@..@........ .
	defb 000h,087h,004h,008h,010h,070h,040h,080h,080h,007h,000h,000h	; 96a9  .....p@.....

; ----------------------------------------------------------------------
; DATOS rle_96B5: rle a la VRAM (0x5C46) de la pieza de decoracion 0x4E; lo
;   leen p00:59B9 (132 bytes)
;   0x96b5..0x9739  (132 bytes)
DATA_rle_96B5:
	defb 084h,060h,090h,090h,060h,020h,000h,002h,001h,085h,003h,00fh,003h,001h,001h,00bh	; 96b5  .`..` ..........
	defb 000h,083h,080h,0e0h,080h,009h,000h,002h,004h,089h,024h,015h,00eh,0ffh,00eh,015h	; 96c5  ..........$.....
	defb 024h,004h,004h,007h,000h,087h,080h,000h,000h,0e0h,000h,000h,080h,005h,000h,09ah	; 96d5  $...............
	defb 008h,06ch,075h,039h,0ddh,0e6h,079h,001h,002h,003h,002h,000h,000h,00eh,019h,010h	; 96e5  .lu9..y.........
	defb 000h,0f0h,0f8h,0bch,00eh,00fh,08eh,0e0h,040h,0a0h,005h,000h,09bh,080h,000h,000h	; 96f5  ........@.......
	defb 001h,001h,031h,00eh,0f9h,0e1h,012h,063h,002h,000h,000h,00eh,019h,010h,000h,0f0h	; 9705  ..1....c........
	defb 0f8h,0bch,00eh,00fh,08eh,0e0h,040h,0a0h,005h,000h,08ch,080h,002h,005h,007h,013h	; 9715  ......@.........
	defb 030h,060h,040h,08eh,007h,01bh,00eh,007h,000h,087h,080h,000h,080h,0c0h,060h,098h	; 9725  0`@...........`.
	defb 080h,007h,000h,000h	; 9735

; ----------------------------------------------------------------------
; DATOS tabla_decoracion: 11 punteros, uno por mapa (0xE041) desde el 1, a las
;   piezas de decoracion de cada sala; la tabla se lee desde 0x9737, pero el
;   mapa 0 no existe; lo leen p00:5972 (22 bytes)
;   0x9739..0x974f  (22 bytes)
DATA_tabla_decoracion:
	defb 04fh,097h	; 9739
	defb 0a9h,098h	; 973b
	defb 0cah,098h	; 973d
	defb 0e8h,098h	; 973f
	defb 009h,099h	; 9741
	defb 02ch,099h	; 9743
	defb 050h,099h	; 9745
	defb 07ah,099h	; 9747
	defb 0a5h,099h	; 9749
	defb 0d1h,099h	; 974b
	defb 009h,09ah	; 974d

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_1: las piezas de decoracion de cada sala del mapa 1:
;   una lista por sala (147); lo leen p00:5972 (346 bytes)
;   0x974f..0x98a9  (346 bytes)
DATA_decoracion_mapa_1:
	defb 000h,032h,023h,000h,018h,03ah,000h,026h	; 974f  .2#..:.&
	defb 000h,011h,02eh,000h,03ch,025h,000h,002h	; 9757  ....<%..
	defb 000h,026h,000h,032h,025h,000h,021h,000h	; 975f  .&.2%.!.
	defb 011h,02eh,000h,025h,000h,02eh,00eh,000h	; 9767  ...%....
	defb 00eh,000h,023h,000h,03ah,00eh,000h,021h	; 976f  ..#.:..!
	defb 034h,000h,019h,000h,034h,000h,00ah,000h	; 9777  4...4...
	defb 02eh,025h,000h,00eh,000h,011h,000h,00eh	; 977f  .%......
	defb 000h,04eh,000h,00eh,000h,019h,000h,021h	; 9787  .N.....!
	defb 000h,00eh,000h,019h,000h,011h,02eh,000h	; 978f  ........
	defb 025h,000h,00ah,000h,00eh,032h,000h,00eh	; 9797  %....2..
	defb 000h,00eh,000h,00eh,000h,00eh,034h,000h	; 979f  ......4.
	defb 02eh,00eh,000h,00ah,000h,02eh,025h,000h	; 97a7  ......%.
	defb 035h,00eh,000h,00eh,000h,00ah,000h,025h	; 97af  5......%
	defb 009h,000h,00ah,000h,035h,00eh,000h,034h	; 97b7  ....5..4
	defb 000h,00eh,031h,000h,00ah,000h,034h,025h	; 97bf  ..1...4%
	defb 000h,00eh,031h,000h,00eh,000h,025h,009h	; 97c7  ..1...%.
	defb 000h,025h,000h,021h,031h,000h,031h,000h	; 97cf  .%.!1.1.
	defb 025h,009h,000h,035h,00eh,000h,00ah,000h	; 97d7  %..5....
	defb 00ah,000h,019h,000h,025h,02eh,000h,025h	; 97df  ....%..%
	defb 000h,019h,000h,025h,034h,000h,00ah,000h	; 97e7  ...%4...
	defb 031h,00eh,000h,00ah,000h,031h,00eh,000h	; 97ef  1....1..
	defb 009h,00eh,000h,00eh,000h,021h,034h,000h	; 97f7  .....!4.
	defb 025h,034h,000h,00ah,000h,00eh,02eh,000h	; 97ff  %4......
	defb 00ah,000h,00eh,02eh,000h,00ah,000h,021h	; 9807  .......!
	defb 000h,00ah,000h,00ah,000h,025h,031h,000h	; 980f  .....%1.
	defb 031h,000h,018h,000h,011h,02eh,000h,025h	; 9817  1......%
	defb 02eh,000h,00eh,000h,00eh,031h,000h,031h	; 981f  .....1.1
	defb 000h,04eh,000h,00eh,000h,025h,000h,000h	; 9827  .N...%..
	defb 00eh,038h,000h,000h,000h,025h,000h,00ah	; 982f  .8...%..
	defb 000h,00eh,034h,000h,00eh,000h,038h,000h	; 9837  ..4...8.
	defb 00eh,000h,032h,025h,000h,00eh,000h,025h	; 983f  ..2%...%
	defb 000h,00eh,000h,03ch,000h,00eh,000h,04eh	; 9847  ...<...N
	defb 000h,011h,000h,00eh,02eh,000h,009h,00eh	; 984f  ........
	defb 000h,025h,009h,000h,025h,032h,000h,00eh	; 9857  .%..%2..
	defb 000h,018h,000h,018h,000h,018h,000h,025h	; 985f  .......%
	defb 018h,000h,032h,018h,000h,021h,034h,000h	; 9867  ..2..!4.
	defb 02eh,000h,02eh,000h,00ah,000h,00eh,000h	; 986f  ........
	defb 00ah,000h,018h,000h,00eh,000h,026h,018h	; 9877  ......&.
	defb 000h,021h,000h,021h,000h,034h,000h,031h	; 987f  .!.!.4.1
	defb 000h,00eh,031h,000h,031h,000h,00dh,002h	; 9887  ..1.1...
	defb 000h,00dh,000h,00dh,002h,000h,00dh,000h	; 988f  ........
	defb 042h,021h,000h,042h,000h,042h,021h,000h	; 9897  B!.B.B!.
	defb 00eh,008h,000h,008h,000h,008h,000h,025h	; 989f  .......%
	defb 008h,000h	; 98a7

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_2: las piezas de decoracion de cada sala del mapa 2:
;   una lista por sala (15); lo leen p00:5972 (33 bytes)
;   0x98a9..0x98ca  (33 bytes)
DATA_decoracion_mapa_2:
	defb 000h,02fh,000h,02fh,000h,010h,000h,010h	; 98a9  ././....
	defb 000h,028h,000h,009h,00eh,000h,028h,00eh	; 98b1  .(....(.
	defb 000h,010h,009h,000h,02fh,000h,02fh,010h	; 98b9  ...././.
	defb 000h,010h,000h,054h,000h,010h,028h,000h	; 98c1  ...T..(.
	defb 000h	; 98c9

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_3: las piezas de decoracion de cada sala del mapa 3:
;   una lista por sala (15); lo leen p00:5972 (30 bytes)
;   0x98ca..0x98e8  (30 bytes)
DATA_decoracion_mapa_3:
	defb 000h,020h,000h,020h,000h,02ah,000h,02dh	; 98ca  . . .*.-
	defb 000h,02dh,000h,02ah,000h,02ah,020h,000h	; 98d2  .-.*.* .
	defb 059h,000h,009h,02ch,000h,000h,02ah,02ch	; 98da  Y..,..*,
	defb 000h,02ah,000h,02dh,000h,000h	; 98e2

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_4: las piezas de decoracion de cada sala del mapa 4:
;   una lista por sala (16); lo leen p00:5972 (33 bytes)
;   0x98e8..0x9909  (33 bytes)
DATA_decoracion_mapa_4:
	defb 000h,02fh,000h,023h,003h,000h,02fh,000h	; 98e8  ./.#../.
	defb 003h,000h,024h,003h,000h,024h,000h,00eh	; 98f0  ..$..$..
	defb 000h,02fh,024h,000h,00eh,000h,023h,003h	; 98f8  ./$...#.
	defb 000h,024h,000h,000h,049h,000h,024h,000h	; 9900  .$..I.$.
	defb 000h	; 9908

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_5: las piezas de decoracion de cada sala del mapa 5:
;   una lista por sala (17); lo leen p00:5972 (35 bytes)
;   0x9909..0x992c  (35 bytes)
DATA_decoracion_mapa_5:
	defb 000h,017h,000h,014h,000h,017h,000h,021h	; 9909  .......!
	defb 029h,000h,00eh,000h,014h,000h,017h,000h	; 9911  ).......
	defb 014h,000h,021h,029h,000h,00eh,000h,021h	; 9919  ..!)...!
	defb 029h,000h,017h,000h,000h,00eh,029h,000h	; 9921  ).....).
	defb 029h,000h,000h	; 9929

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_6: las piezas de decoracion de cada sala del mapa 6:
;   una lista por sala (18); lo leen p00:5972 (36 bytes)
;   0x992c..0x9950  (36 bytes)
DATA_decoracion_mapa_6:
	defb 000h,007h,000h,007h,000h,007h,000h,036h	; 992c  .......6
	defb 000h,04ch,000h,030h,000h,007h,030h,000h	; 9934  .L.0..0.
	defb 007h,030h,000h,030h,000h,007h,000h,00bh	; 993c  .0.0....
	defb 000h,00bh,000h,04ch,000h,007h,000h,036h	; 9944  ...L...6
	defb 000h,000h,05ah,000h	; 994c

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_7: las piezas de decoracion de cada sala del mapa 7:
;   una lista por sala (19); lo leen p00:5972 (42 bytes)
;   0x9950..0x997a  (42 bytes)
DATA_decoracion_mapa_7:
	defb 000h,00eh,03eh,000h,03eh,000h,00eh,03eh	; 9950  ..>.>..>
	defb 000h,012h,000h,00eh,000h,021h,03eh,000h	; 9958  .....!>.
	defb 021h,03eh,000h,00fh,000h,00fh,000h,016h	; 9960  !>......
	defb 000h,00fh,000h,058h,000h,00fh,000h,00fh	; 9968  ...X....
	defb 000h,012h,000h,012h,03eh,000h,012h,03eh	; 9970  ....>..>
	defb 000h,000h	; 9978

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_8: las piezas de decoracion de cada sala del mapa 8:
;   una lista por sala (20); lo leen p00:5972 (43 bytes)
;   0x997a..0x99a5  (43 bytes)
DATA_decoracion_mapa_8:
	defb 000h,00eh,000h,00eh,000h,027h,000h,027h	; 997a  .....'.'
	defb 000h,00eh,027h,000h,01fh,000h,01fh,000h	; 9982  ..'.....
	defb 00eh,000h,065h,000h,01fh,028h,000h,00eh	; 998a  ..e..(..
	defb 028h,000h,01fh,000h,028h,000h,00eh,000h	; 9992  (...(...
	defb 022h,000h,028h,00eh,000h,022h,000h,027h	; 999a  ".(..".'
	defb 01fh,000h,000h	; 99a2

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_9: las piezas de decoracion de cada sala del mapa 9:
;   una lista por sala (21); lo leen p00:5972 (44 bytes)
;   0x99a5..0x99d1  (44 bytes)
DATA_decoracion_mapa_9:
	defb 000h,035h,000h,013h,000h,02bh,000h,013h	; 99a5  .5...+..
	defb 000h,00ch,02bh,000h,068h,000h,00ch,000h	; 99ad  ..+.h...
	defb 00ch,000h,02bh,000h,02bh,000h,013h,000h	; 99b5  ..+.+...
	defb 00ch,000h,035h,000h,008h,00ch,000h,008h	; 99bd  ..5.....
	defb 000h,008h,000h,008h,000h,008h,00ch,000h	; 99c5  ........
	defb 040h,000h,068h,000h	; 99cd

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_10: las piezas de decoracion de cada sala del mapa 10:
;   una lista por sala (27); lo leen p00:5972 (56 bytes)
;   0x99d1..0x9a09  (56 bytes)
DATA_decoracion_mapa_10:
	defb 00eh,000h,00eh,000h,008h,00eh,000h,00eh	; 99d1  ........
	defb 008h,000h,00eh,008h,000h,043h,000h,006h	; 99d9  .....C..
	defb 000h,043h,000h,006h,000h,043h,000h,001h	; 99e1  .C...C..
	defb 000h,006h,000h,00eh,000h,005h,000h,005h	; 99e9  ........
	defb 000h,001h,000h,006h,000h,043h,000h,006h	; 99f1  .....C..
	defb 000h,006h,000h,005h,000h,00eh,000h,006h	; 99f9  ........
	defb 000h,00eh,000h,006h,000h,015h,000h,000h	; 9a01  ........

; ----------------------------------------------------------------------
; DATOS decoracion_mapa_11: las piezas de decoracion de cada sala del mapa 11:
;   una lista por sala (6); lo leen p00:5972 (12 bytes)
;   0x9a09..0x9a15  (12 bytes)
DATA_decoracion_mapa_11:
	defb 000h,008h,000h,008h,00eh,000h,00eh,000h	; 9a09  ........
	defb 067h,000h,039h,000h	; 9a11

; ----------------------------------------------------------------------
; DATOS dibujos_9A15: los dibujos de unos caracteres desde el 0x5A, en rle
;   (0x5C46), que pide la ficha 0x616F; lo leen p00:5860 (485 bytes)
;   0x9a15..0x9bfa  (485 bytes)
DATA_dibujos_9A15:
	defb 002h,0c7h,086h,0efh,078h,0f6h,0adh,09ch,0fah,007h,000h,089h,0b8h,000h,000h,001h	; 9a15  ....x...........
	defb 016h,08ch,0dfh,0dfh,0efh,003h,000h,095h,001h,003h,00eh,01dh,019h,01eh,01dh,00eh	; 9a25  ................
	defb 00dh,09dh,07bh,0f7h,06ah,019h,01dh,00eh,00dh,00dh,01eh,01ch,038h,004h,000h,089h	; 9a35  ..{.j.......8...
	defb 080h,0c0h,0c0h,0e0h,080h,060h,018h,004h,0c4h,003h,020h,004h,000h,08ch,080h,0c0h	; 9a45  .....`.... .....
	defb 0c0h,0e3h,05fh,06fh,06fh,02fh,02fh,01fh,01fh,03eh,004h,000h,084h,001h,002h,005h	; 9a55  .._oo//..>......
	defb 005h,003h,000h,089h,003h,054h,0afh,076h,069h,0fbh,07bh,075h,03ah,003h,07bh,091h	; 9a65  .....T.vi.{u:.{.
	defb 031h,07fh,0c0h,03ch,043h,0b0h,0c8h,004h,082h,0a0h,05ah,027h,012h,009h,010h,039h	; 9a75  1..<C.....Z'...9
	defb 063h,004h,080h,084h,060h,0e0h,0d8h,0fah,006h,000h,085h,0c0h,030h,088h,048h,040h	; 9a85  c...`.......0.H@
	defb 003h,000h,08fh,080h,000h,060h,0b0h,0f0h,0c0h,0ech,0feh,0b2h,058h,03ch,03dh,03fh	; 9a95  .....`......X<=?
	defb 03eh,01eh,003h,01ch,088h,080h,001h,001h,003h,007h,007h,008h,006h,005h,000h,08bh	; 9aa5  >...............
	defb 02fh,057h,0d4h,000h,0c0h,0a0h,000h,060h,0f0h,0c0h,0b8h,004h,000h,08ah,00fh,012h	; 9ab5  /W.....`........
	defb 000h,0b8h,0feh,03ch,0d0h,0e0h,0d0h,0d0h,004h,0a0h,09ah,070h,030h,0c0h,0b0h,018h	; 9ac5  ...<.......p0...
	defb 068h,06fh,077h,07bh,0fbh,07dh,07dh,07ch,078h,06dh,029h,014h,01ah,00dh,023h,07eh	; 9ad5  how{.}}|xm)...#~
	defb 0a0h,0d7h,0e9h,0f7h,0f2h,003h,0e0h,085h,0a0h,0d0h,0e0h,0f0h,0f0h,003h,0e1h,083h	; 9ae5  ................
	defb 0a1h,078h,0f8h,006h,0f0h,097h,002h,001h,001h,003h,003h,007h,007h,00fh,022h,0c1h	; 9af5  .x............".
	defb 0c1h,003h,003h,007h,007h,00fh,010h,0d0h,0e0h,0c0h,0c4h,098h,0e0h,005h,000h,004h	; 9b05  ................
	defb 001h,084h,0d3h,0e1h,0f1h,0f2h,003h,0e0h,084h,0a0h,020h,0c0h,0c0h,005h,000h,084h	; 9b15  .......... .....
	defb 026h,016h,004h,008h,004h,000h,0a0h,064h,04ch,099h,002h,000h,005h,00dh,03eh,0c3h	; 9b25  &......dL.....>.
	defb 0e7h,0ceh,0c7h,09bh,0a6h,0ceh,006h,00eh,00fh,011h,01eh,01eh,071h,0eeh,0deh,001h	; 9b35  ............q...
	defb 002h,001h,001h,002h,00dh,02bh,0d6h,003h,005h,08dh,00dh,01dh,07eh,0b1h,0a6h,01ch	; 9b45  .....+......~...
	defb 026h,03ah,07ch,0fch,072h,06dh,01ah,005h,000h,09bh,0ffh,0c6h,079h,0f0h,078h,0e0h	; 9b55  &:|.rm......y.x.
	defb 0f0h,080h,040h,000h,080h,000h,001h,007h,00fh,018h,006h,018h,000h,000h,0f8h,077h	; 9b65  ..@............w
	defb 06fh,08eh,0e5h,01bh,00ch,004h,000h,0a8h,0d9h,0ddh,09fh,078h,00ah,007h,01bh,03dh	; 9b75  o..........x...=
	defb 07eh,07ch,03ch,02eh,0f7h,0f3h,0f4h,0eeh,01dh,010h,008h,00dh,002h,002h,084h,030h	; 9b85  ~|<............0
	defb 078h,093h,0f7h,0f9h,038h,0b8h,070h,0e3h,0dfh,0afh,0b6h,0a9h,0eeh,0e6h,0e6h,0f7h	; 9b95  x...8.p.........
	defb 003h,0f3h,0d1h,0fbh,08dh,038h,073h,077h,0bfh,0ddh,0e1h,0eeh,048h,000h,0a0h,070h	; 9ba5  .....8sw....H..p
	defb 0e8h,0d0h,080h,000h,056h,054h,0eeh,0c6h,0c3h,083h,080h,0c3h,053h,023h,04bh,096h	; 9bb5  ....VT......S#K.
	defb 02ch,05ch,018h,078h,030h,039h,01fh,01eh,01dh,00eh,006h,001h,086h,001h,081h,030h	; 9bc5  ,\.x09.........0
	defb 078h,093h,0f7h,0f9h,04ah,03dh,00eh,003h,000h,006h,02bh,055h,013h,00ch,07eh,0bch	; 9bd5  x...J=....+U..~.
	defb 0dch,0c0h,05ch,038h,073h,037h,0fbh,0bch,0dbh,0d7h,00fh,02fh,087h,038h,073h,077h	; 9be5  ..\8s7...../.8sw
	defb 0bfh,0ddh,0e1h,0eeh,000h	; 9bf5

; ----------------------------------------------------------------------
; DATOS dibujos_9BFA: los dibujos de unos caracteres desde el 0xBA, en rle
;   (0x5C46), que pide la ficha 0x6175; lo leen p00:5860 (195 bytes)
;   0x9bfa..0x9cbd  (195 bytes)
DATA_dibujos_9BFA:
	defb 004h,000h,091h,001h,003h,006h,006h,0f6h,07fh,05fh,055h,08ah,0e0h,010h,070h,0f0h	; 9bfa  ........._U...p.
	defb 0f8h,0c0h,030h,080h,003h,000h,0a5h,038h,070h,03ch,058h,03ch,058h,07ch,0b8h,030h	; 9c0a  ..0....8p<X<X|.0
	defb 060h,030h,060h,030h,060h,038h,070h,0f4h,0e8h,092h,021h,085h,001h,00bh,017h,0eeh	; 9c1a  `0`0`8p...!.....
	defb 0e7h,0dfh,0efh,0e9h,0e6h,0edh,0c3h,09fh,063h,06dh,076h,076h,003h,036h,082h,0fah	; 9c2a  ........cmvv.6..
	defb 078h,003h,07ch,09bh,0f6h,0c2h,0b8h,064h,04ch,099h,002h,000h,001h,001h,080h,0dah	; 9c3a  x.|....dL.......
	defb 0dfh,0b9h,066h,09eh,0ffh,00fh,0f7h,0fbh,0fbh,0f5h,0ceh,0afh,067h,067h,095h,004h	; 9c4a  ..f.........gg..
	defb 000h,089h,008h,010h,010h,020h,0eeh,0c6h,0c6h,097h,0a3h,003h,023h,003h,000h,0b6h	; 9c5a  ..... ......#...
	defb 003h,0dfh,0afh,0b6h,0a9h,038h,0b8h,070h,0e0h,0c0h,080h,080h,000h,0e7h,0e3h,0dfh	; 9c6a  .....8.p........
	defb 0efh,0e9h,0e6h,0e6h,0c3h,073h,037h,0fbh,0bch,0dbh,0d7h,00fh,02fh,020h,0c0h,0c0h	; 9c7a  .....s7...../ ..
	defb 000h,001h,003h,002h,005h,03eh,07eh,0fch,0fch,0fdh,0f9h,01ah,0d2h,01fh,027h,0fbh	; 9c8a  .....>~.......'.
	defb 0fdh,0fch,072h,06ch,092h,001h,003h,003h,003h,007h,085h,00fh,020h,021h,040h,081h	; 9c9a  ..rl........ !@.
	defb 004h,000h,088h,080h,001h,00ch,06fh,06eh,0ffh,0fdh,052h,004h,000h,084h,060h,09dh	; 9caa  ......on..R...`.
	defb 02fh,073h,000h	; 9cba

; ----------------------------------------------------------------------
; DATOS colores_9CBD: los colores de unos caracteres desde el 0x5A, en rle
;   (0x5C46), que pide la ficha 0x616F; lo leen p00:5860 (100 bytes)
;   0x9cbd..0x9d21  (100 bytes)
DATA_colores_9CBD:
	defb 07fh,0f0h,041h,0f0h,07fh,0e0h,011h,0e0h,006h,0f0h,002h,0e0h,002h,0f0h,081h,0e0h	; 9cbd  ..A.............
	defb 005h,0f0h,005h,0e0h,002h,0f0h,085h,0e0h,0f0h,0e0h,0f0h,0e0h,009h,0f0h,004h,0e0h	; 9ccd  ................
	defb 003h,0f0h,004h,0e0h,006h,0f0h,003h,0e0h,005h,0f0h,086h,0e0h,0f0h,0f0h,0e0h,0f0h	; 9cdd  ................
	defb 0e0h,00bh,0f0h,081h,0e0h,004h,0f0h,003h,0e0h,082h,0f0h,0e0h,007h,0f0h,081h,0e0h	; 9ced  ................
	defb 004h,0f0h,083h,0e0h,0f0h,0e0h,008h,0f0h,003h,0e0h,00fh,0f0h,007h,0e0h,006h,0f0h	; 9cfd  ................
	defb 081h,0e0h,008h,0f0h,005h,0e0h,082h,0f0h,0e0h,005h,0f0h,005h,0e0h,004h,0f0h,083h	; 9d0d  ................
	defb 0e0h,0f0h,0e0h,000h	; 9d1d

; ----------------------------------------------------------------------
; DATOS colores_9D21: los colores de unos caracteres desde el 0xBA, en rle
;   (0x5C46), que pide la ficha 0x6175; lo leen p00:5860 (128 bytes)
;   0x9d21..0x9da1  (128 bytes)
DATA_colores_9D21:
	defb 005h,0f0h,085h,0e0h,0f0h,0e0h,0f0h,0f0h,006h,0e0h,081h,0f0h,007h,0e0h,093h,0f0h	; 9d21  ................
	defb 0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h,0e0h,0f0h	; 9d31  ................
	defb 0f0h,0e0h,00ah,0f0h,082h,0e0h,0f0h,003h,0e0h,004h,0f0h,081h,0e0h,008h,0f0h,005h	; 9d41  ................
	defb 0e0h,088h,0f0h,0e0h,0e0h,0f0h,0e0h,0f0h,0e0h,0e0h,007h,0f0h,082h,0e0h,0f0h,003h	; 9d51  ................
	defb 0e0h,007h,0f0h,081h,0e0h,006h,0f0h,081h,0e0h,005h,0f0h,002h,0e0h,006h,0f0h,004h	; 9d61  ................
	defb 0e0h,005h,0f0h,083h,0e0h,0f0h,0e0h,004h,0f0h,002h,0e0h,002h,0f0h,003h,0e0h,004h	; 9d71  ................
	defb 0f0h,081h,0e0h,007h,0f0h,081h,0e0h,007h,0f0h,083h,0feh,0f0h,0e0h,007h,0f0h,082h	; 9d81  ................
	defb 0e0h,0f0h,005h,0e0h,004h,0f0h,084h,0e0h,0ffh,0e0h,0e0h,007h,0f0h,081h,0e0h,000h	; 9d91  ................

; ----------------------------------------------------------------------
; DATOS dibujos_9DA1: los dibujos de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x61C8; lo leen p00:5860 (37 bytes)
;   0x9da1..0x9dc6  (37 bytes)
DATA_dibujos_9DA1:
	defb 004h,000h,082h,091h,007h,003h,000h,095h,003h,000h,01fh,00bh,021h,017h,000h,0bfh	; 9da1  ............!...
	defb 0c7h,09fh,03fh,0e3h,0c0h,081h,000h,080h,0f0h,0e0h,0ffh,080h,0e0h,005h,000h,082h	; 9db1  ..?.............
	defb 0e0h,0fch,003h,000h,000h	; 9dc1

; ----------------------------------------------------------------------
; DATOS colores_9DC6: los colores de unos caracteres desde el 0xA6, en rle
;   (0x5C46), que pide la ficha 0x61C8; lo leen p00:5860 (25 bytes)
;   0x9dc6..0x9ddf  (25 bytes)
DATA_colores_9DC6:
	defb 00ch,090h,081h,0a9h,005h,090h,002h,0a9h,083h,0a8h,096h,060h,003h,090h,002h,0a9h	; 9dc6  ...........`....
	defb 081h,0a6h,003h,060h,004h,090h,004h,060h,000h	; 9dd6  ...`...`.

; ----------------------------------------------------------------------
; DATOS dibujos_9DDF: los dibujos de unos caracteres desde el 0x5A, en rle
;   (0x5C46), que pide la ficha 0x61EA; lo leen p00:5860 (459 bytes)
;   0x9ddf..0x9faa  (459 bytes)
DATA_dibujos_9DDF:
	defb 0ffh,0f0h,0feh,06bh,055h,02ah,0bfh,077h,00fh,000h,000h,080h,0e0h,0f8h,055h,0afh	; 9ddf  ...kU*.w......U.
	defb 012h,000h,03fh,079h,0d6h,03fh,01fh,001h,000h,01fh,03fh,0feh,0feh,0fdh,0e8h,0feh	; 9def  ..?y.?....?.....
	defb 0f9h,00fh,01fh,03fh,07fh,0fbh,0ech,0feh,0fdh,0fah,0f6h,0f4h,0e8h,0d0h,0c0h,0a0h	; 9dff  ...?............
	defb 080h,0fch,0f0h,0f7h,0aeh,0a8h,040h,000h,000h,0d4h,0f6h,074h,058h,0d0h,080h,000h	; 9e0f  ......@....tX...
	defb 000h,0c1h,0b9h,0fch,0feh,0edh,0d4h,0dbh,03bh,0ffh,0dfh,0fdh,077h,03fh,0c0h,0b5h	; 9e1f  ............w?..
	defb 0fah,09bh,036h,0ddh,0f7h,02ch,0fah,054h,0f8h,0bfh,0cfh,021h,0fch,001h,07fh,02bh	; 9e2f  ..6..,.T...!...+
	defb 040h,00dh,0e0h,0b7h,0dah,0a9h,0feh,0dbh,0edh,089h,087h,0b5h,073h,0adh,0d4h,0dbh	; 9e3f  @...........s...
	defb 03bh,03fh,0ffh,0a9h,0d7h,034h,02dh,0bfh,0bfh,00ch,0e1h,0f9h,0feh,0a9h,053h,000h	; 9e4f  .?...4-.......S.
	defb 0a9h,000h,007h,01fh,0ech,06bh,09ch,0adh,072h,069h,0feh,0fdh,0b9h,0d6h,0d6h,028h	; 9e5f  .....k..ri.....(
	defb 087h,000h,0feh,09bh,0adh,072h,08dh,06fh,060h,084h,09fh,0ddh,013h,06eh,0b5h,069h	; 9e6f  .....r.o`....n.i
	defb 0abh,0f4h,000h,000h,080h,000h,000h,080h,0c0h,0e0h,003h,000h,085h,001h,01fh,0ffh	; 9e7f  ................
	defb 0d5h,0f9h,004h,000h,084h,040h,0d8h,00bh,0f1h,006h,000h,087h,020h,064h,003h,0f0h	; 9e8f  .....@...... d..
	defb 07eh,003h,001h,008h,000h,083h,08fh,033h,061h,005h,000h,0c1h,016h,034h,003h,000h	; 9e9f  ~......3a....4..
	defb 01dh,073h,0e4h,0c9h,090h,023h,046h,0f8h,0ffh,000h,078h,007h,0f0h,000h,01ch,000h	; 9eaf  .s...#F...x.....
	defb 087h,0fch,000h,000h,016h,034h,003h,0d0h,0c3h,0f8h,0fch,0deh,08fh,03eh,078h,081h	; 9ebf  .....4.......>x.
	defb 07ch,0eeh,0deh,0deh,01ch,01ch,01bh,068h,0b4h,04ah,0fah,0f8h,07fh,03fh,003h,0feh	; 9ecf  |......h.J...?..
	defb 0feh,0fch,0f8h,07eh,03eh,00fh,007h,0dch,0a7h,058h,077h,099h,0ech,003h,000h,084h	; 9edf  ...~>....Xw.....
	defb 080h,0f0h,010h,0e0h,008h,000h,088h,001h,002h,085h,03ch,08ch,0cdh,066h,019h,006h	; 9eef  ..........<..f..
	defb 000h,085h,001h,01fh,0ffh,0e3h,0fdh,006h,000h,082h,003h,01fh,006h,000h,082h,001h	; 9eff  ................
	defb 003h,006h,000h,082h,001h,007h,003h,000h,085h,001h,003h,007h,00fh,03fh,005h,000h	; 9f0f  .............?..
	defb 002h,001h,002h,003h,087h,007h,00fh,01fh,01fh,03fh,03fh,07fh,005h,000h,083h,003h	; 9f1f  .........??.....
	defb 000h,07fh,005h,000h,083h,0f0h,0fch,0feh,004h,000h,084h,0c0h,080h,000h,080h,004h	; 9f2f  ................
	defb 000h,091h,001h,003h,000h,07fh,050h,0ffh,0afh,0a3h,050h,002h,002h,004h,000h,080h	; 9f3f  ......P...P.....
	defb 020h,040h,080h,003h,000h,083h,03ch,030h,070h,003h,0a0h,081h,050h,003h,000h,083h	; 9f4f   @....<0p...P...
	defb 024h,0c8h,030h,003h,000h,003h,080h,005h,000h,002h,003h,0a0h,0c1h,014h,028h,0e8h	; 9f5f  $.0...........(.
	defb 000h,000h,0e0h,081h,00fh,01ch,014h,012h,000h,000h,0f5h,03ah,005h,005h,002h,080h	; 9f6f  ...........:....
	defb 040h,000h,000h,03fh,079h,0d5h,008h,002h,03fh,001h,003h,001h,006h,000h,082h,0e0h	; 9f7f  @..?y...?.......
	defb 03fh,006h,000h,002h,0c0h,003h,020h,003h,000h,081h,001h,003h,002h,004h,000h,082h	; 9f8f  ?..... .........
	defb 036h,0c0h,005h,000h,083h,080h,000h,006h,006h,000h,000h	; 9f9f  6..........

; ----------------------------------------------------------------------
; DATOS dibujos_9FAA: los dibujos de unos caracteres desde el 0xBA, en rle
;   (0x5C46), que pide la ficha 0x61F0; lo leen p00:5860 (86 bytes)
;   0x9faa..0xa000  (86 bytes)
DATA_dibujos_9FAA:
	defb 083h,0f6h,0c8h,020h,005h,000h,091h,0f8h,0cfh,0abh,03bh,052h,0e5h,0e0h,0c0h,0f8h	; 9faa  ... .......R....
	defb 0cfh,0fbh,07bh,0f2h,0e5h,0c0h,000h,07fh,003h,0ffh,0d4h,0dfh,0a0h,00bh,001h,07fh	; 9fba  ..{.............
	defb 0ffh,02fh,007h,03fh,040h,0aah,000h,0efh,0dfh,0bfh,0bfh,09fh,00fh,0e0h,000h,005h	; 9fca  ./.?@...........
	defb 006h,0d8h,036h,00dh,003h,000h,000h,0ffh,0ffh,0feh,0c0h,0ffh,000h,056h,0abh,002h	; 9fda  ..6..........V..
	defb 001h,007h,0e0h,0deh,055h,0dbh,0b6h,0feh,0f0h,005h,054h,040h,006h,085h,0f8h,0feh	; 9fea  ....U.....T@....
	defb 0f0h,005h,054h,000h,0e1h,0fdh	; 9ffa
