; ==========================================================================
; THE MAZE OF GALIOUS - Konami (1987) - MSX - MegaROM RC-749 de 128 KB (Konami4) - banco 14 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; DATOS partituras_7E02_cola: partituras de las musicas (p13:6197): notas,
;   silencios y ordenes (sigue del banco anterior, 0x7E02); lo leen p13:6197
;   (4102 bytes)
;   0x8000..0x9006  (4102 bytes)
DATA_partituras_7E02_cola:
	defb 070h,0f9h,051h,020h,040h,050h,070h,0feh,002h,0c1h,07fh,0eeh,0fch,035h,0e2h,021h	; 8000  p.Q @Pp......5.!
	defb 020h,020h,021h,020h,020h,020h,0e3h,090h,0e2h,000h,050h,040h,0e3h,090h,0e2h,000h	; 8010    !   ....P@....
	defb 020h,0e3h,071h,070h,070h,071h,070h,070h,0e2h,070h,020h,050h,0a0h,090h,020h,050h	; 8020   .qppqpp.p P.. P
	defb 070h,0feh,002h,00ch,080h,0eeh,0e6h,0d6h,0fch,051h,0e1h,0c0h,0e8h,005h,042h,0e8h	; 8030  p........Q....B.
	defb 006h,07bh,0ebh,0edh,055h,080h,0edh,0cch,080h,0edh,055h,080h,0edh,0cch,080h,0edh	; 8040  .{..U.....U.....
	defb 0c8h,081h,0eah,043h,080h,0e9h,0e7h,0d6h,0fdh,034h,0e3h,021h,020h,020h,001h,000h	; 8050  ...C.....4.!  ..
	defb 000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,0e3h,001h,000h,000h,0e4h,071h,070h,070h	; 8060  .............qpp
	defb 0e3h,001h,000h,000h,0e4h,071h,070h,070h,0e3h,031h,030h,030h,0e4h,0a1h,0a0h,0a0h	; 8070  .....qpp.100....
	defb 0e3h,031h,030h,030h,0e4h,0a1h,0a0h,0a0h,0e3h,021h,020h,020h,001h,000h,000h,0e4h	; 8080  .100.....!  ....
	defb 0a1h,0a0h,0a0h,091h,090h,090h,0e3h,021h,020h,020h,001h,000h,000h,0e4h,0a1h,0a0h	; 8090  .......!  ......
	defb 0a0h,091h,090h,090h,0e3h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,071h	; 80a0  ...............q
	defb 070h,070h,071h,070h,070h,091h,090h,090h,0a1h,0a0h,0a0h,0e3h,001h,000h,000h,021h	; 80b0  ppqpp..........!
	defb 020h,020h,021h,020h,020h,021h,020h,020h,021h,020h,020h,0eeh,0e9h,0e7h,0d6h,0fch	; 80c0    !  !  !  .....
	defb 052h,0e3h,030h,030h,030h,030h,0e8h,001h,063h,0e9h,0e7h,031h,030h,030h,031h,030h	; 80d0  R.0000..c..10010
	defb 030h,021h,020h,020h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,0e4h,080h	; 80e0  0!  ............
	defb 080h,080h,080h,0e8h,001h,063h,0e9h,0e7h,081h,080h,080h,081h,080h,080h,0e3h,001h	; 80f0  .....c..........
	defb 000h,000h,021h,020h,020h,031h,030h,030h,051h,050h,050h,030h,030h,030h,030h,0e8h	; 8100  ..!  100QPP0000.
	defb 001h,063h,0e9h,0e7h,031h,030h,030h,031h,030h,030h,020h,020h,020h,020h,0e8h,001h	; 8110  .c..100100    ..
	defb 063h,0e9h,0e7h,021h,020h,020h,021h,020h,020h,0e9h,0e7h,0e4h,070h,070h,070h,070h	; 8120  c..!  !  ...pppp
	defb 0e8h,001h,063h,0e9h,0e7h,080h,080h,080h,080h,0e8h,001h,063h,0e9h,0e7h,090h,0e3h	; 8130  ..c........c....
	defb 090h,0e4h,090h,090h,091h,090h,090h,091h,090h,090h,090h,090h,090h,090h,0e9h,0e7h	; 8140  ................
	defb 0d6h,0fdh,034h,0e3h,021h,020h,020h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,091h,090h	; 8150  ..4.!  .........
	defb 090h,0e3h,001h,000h,000h,0e4h,071h,070h,070h,0e3h,001h,000h,000h,0e4h,071h,070h	; 8160  ......qpp.....qp
	defb 070h,0e3h,031h,030h,030h,0e4h,0a1h,0a0h,0a0h,0e3h,031h,030h,030h,0e4h,0a1h,0a0h	; 8170  p.100.....100...
	defb 0a0h,0e3h,021h,020h,020h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,0e3h	; 8180  ..!  ...........
	defb 021h,020h,020h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,0e3h,001h,000h	; 8190  !  .............
	defb 000h,0e4h,0a1h,0a0h,0a0h,091h,090h,090h,071h,070h,070h,0e3h,031h,030h,030h,021h	; 81a0  ........qpp.100!
	defb 020h,020h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,0e3h,021h,020h,020h,001h,000h,000h	; 81b0    ........!  ...
	defb 0e4h,0a1h,0a0h,0a0h,091h,090h,090h,0eeh,0e3h,021h,020h,020h,021h,020h,020h,020h	; 81c0  .........!  !
	defb 0e4h,090h,0e3h,000h,050h,040h,0e4h,090h,0e3h,000h,020h,0e4h,071h,070h,070h,071h	; 81d0  ....P@.... .qppq
	defb 070h,070h,0e3h,070h,020h,050h,0a0h,090h,020h,050h,070h,0feh,002h,0c8h,081h,0eeh	; 81e0  pp.p P.. Pp.....
	defb 0e6h,0d6h,0fch,051h,0e1h,0c1h,0e8h,005h,07dh,0ebh,0edh,00ch,082h,0edh,05eh,082h	; 81f0  ...Q....}.....^.
	defb 0edh,00ch,082h,0edh,05eh,082h,0edh,021h,083h,0eah,0fah,081h,0e9h,0d6h,0fah,052h	; 8200  ....^..!.......R
	defb 0e3h,095h,0fbh,051h,0e2h,020h,040h,053h,093h,073h,043h,0fch,051h,023h,003h,0fbh	; 8210  ...Q. @S.sC.Q#..
	defb 051h,075h,050h,030h,075h,050h,030h,053h,0fah,052h,0e3h,093h,0e8h,001h,000h,000h	; 8220  QuP0uP0S.R......
	defb 010h,000h,000h,000h,010h,000h,0e9h,095h,0fbh,051h,0e2h,020h,040h,053h,073h,093h	; 8230  .........Q. @Ss.
	defb 051h,040h,020h,010h,020h,040h,050h,071h,0e1h,001h,0e2h,075h,050h,040h,075h,050h	; 8240  Q@ . @Pq...uP@uP
	defb 040h,053h,093h,0e8h,001h,000h,000h,010h,000h,000h,000h,010h,000h,0eeh,0e9h,0d6h	; 8250  @S..............
	defb 0fbh,051h,0e2h,073h,0e8h,001h,000h,000h,000h,000h,0e9h,033h,073h,053h,0fah,051h	; 8260  .Q.s.......3sS.Q
	defb 0e3h,097h,0e8h,001h,000h,000h,010h,000h,0e9h,0fbh,051h,0e2h,033h,0e8h,001h,000h	; 8270  ..........Q.3...
	defb 000h,000h,000h,0e9h,023h,033h,003h,0fah,051h,0e3h,077h,0e8h,001h,000h,000h,010h	; 8280  ....#3..Q.w.....
	defb 000h,0e9h,0fbh,051h,0e2h,073h,0e8h,001h,000h,000h,000h,000h,0e9h,033h,073h,053h	; 8290  ...Q.s.......3sS
	defb 0e8h,001h,000h,000h,000h,000h,0e9h,023h,053h,043h,0e8h,001h,000h,000h,000h,000h	; 82a0  .......#SC......
	defb 0e9h,043h,0e8h,001h,000h,000h,000h,000h,0e9h,0fch,051h,043h,013h,0e3h,093h,0e8h	; 82b0  .C........QC....
	defb 001h,010h,000h,000h,000h,0e9h,0e7h,0d6h,0f9h,022h,0e1h,0c1h,021h,0e2h,091h,0e1h	; 82c0  ........."..!...
	defb 041h,0e2h,091h,0e1h,051h,040h,020h,0e8h,001h,000h,000h,0e9h,0e7h,0e2h,091h,0e1h	; 82d0  A...Q@ .........
	defb 001h,0e2h,071h,0e1h,021h,0e2h,071h,0e1h,041h,020h,000h,0e8h,001h,000h,000h,0e9h	; 82e0  ..q.!.q.A ......
	defb 0e7h,0e2h,071h,0e1h,031h,0e2h,0a1h,0e1h,051h,0e2h,0a1h,0e1h,071h,050h,030h,0e8h	; 82f0  ..q.1...Q...qP0.
	defb 001h,000h,000h,0e9h,0e7h,0e2h,0a1h,0e1h,020h,040h,050h,070h,0f8h,022h,020h,040h	; 8300  ........ @Pp." @
	defb 050h,070h,0f7h,022h,020h,040h,050h,070h,0e8h,001h,000h,000h,0feh,002h,0c5h,082h	; 8310  Pp." @Pp........
	defb 0eeh,0e9h,0fch,035h,0e4h,021h,0e8h,001h,000h,000h,0e9h,021h,0e8h,001h,000h,000h	; 8320  ...5.!.....!....
	defb 0e9h,020h,0e5h,090h,0e4h,000h,050h,040h,0e5h,090h,0e8h,001h,000h,000h,0e9h,0e5h	; 8330  . ....P@........
	defb 071h,0e8h,001h,000h,000h,0e9h,071h,0e8h,001h,000h,000h,0e9h,0e4h,070h,020h,050h	; 8340  q.....q......p P
	defb 0a0h,090h,020h,0e8h,001h,000h,000h,0feh,002h,021h,083h,0eeh,0e9h,0d4h,0fch,024h	; 8350  .. ......!.....$
	defb 0e8h,002h,003h,0e8h,003h,003h,0e8h,002h,043h,0e8h,003h,043h,0e8h,002h,0b3h,0e8h	; 8360  ........C..C....
	defb 003h,0b3h,0e9h,0d8h,0e8h,005h,04fh,0e9h,0d4h,0c0h,0edh,05dh,07fh,0edh,087h,07fh	; 8370  ......O....]....
	defb 0edh,05dh,07fh,0edh,087h,07fh,0edh,00ch,080h,0eah,07ah,083h,0e9h,0d4h,0fch,024h	; 8380  .]........z....$
	defb 0e1h,0c1h,0e8h,002h,003h,0e8h,003h,003h,0e8h,002h,043h,0e8h,003h,043h,0e8h,002h	; 8390  ..........C..C..
	defb 0b3h,0e8h,003h,0b2h,0e9h,0d8h,0e8h,005h,0bfh,0edh,055h,080h,0edh,0cch,080h,0edh	; 83a0  ..........U.....
	defb 055h,080h,0edh,0cch,080h,0edh,0c8h,081h,0eah,0a9h,083h,0e9h,0d4h,0fah,035h,0e1h	; 83b0  U.............5.
	defb 0c1h,0e8h,005h,007h,047h,0b7h,0e9h,0d8h,0e8h,006h,02dh,0e9h,0d4h,0c2h,0edh,00ch	; 83c0  ....G.....-.....
	defb 082h,0edh,05eh,082h,0edh,00ch,082h,0edh,05eh,082h,0edh,021h,083h,0eah,0ceh,083h	; 83d0  ..^.....^..!....
	defb 0e6h,0d6h,0e8h,004h,002h,0e8h,005h,033h,022h,0e8h,006h,01dh,0ebh,0e9h,0dbh,0fbh	; 83e0  .......3".......
	defb 023h,0e1h,0edh,0f5h,083h,020h,000h,020h,0e2h,090h,0e1h,000h,010h,020h,070h,060h	; 83f0  #.... . ..... p`
	defb 020h,000h,0e2h,090h,080h,070h,060h,070h,0e1h,020h,000h,020h,0e2h,090h,0e1h,000h	; 8400   ....p`p. . ....
	defb 010h,020h,090h,0e0h,000h,0e1h,090h,0e0h,020h,000h,0e1h,090h,080h,070h,050h,0eah	; 8410  . ...... ....pP.
	defb 0f5h,083h,0e6h,0d6h,0c0h,0e8h,004h,066h,0e8h,005h,08fh,0ebh,0e9h,0dbh,0f9h,000h	; 8420  .......f........
	defb 0e8h,005h,023h,053h,043h,033h,023h,053h,043h,033h,0eah,02ch,084h,0e6h,0d6h,0c1h	; 8430  ..#SC3#SC3.,....
	defb 0e8h,004h,095h,0e9h,0c0h,0e8h,005h,0beh,0ebh,0e9h,0e7h,0dbh,0f9h,010h,0e1h,0c0h	; 8440  ................
	defb 0edh,0f5h,083h,0e9h,0d6h,0fbh,022h,0e8h,003h,0b1h,081h,041h,021h,0e8h,002h,0b1h	; 8450  ......"....A!...
	defb 081h,041h,0e9h,0e0h,021h,0e1h,0b1h,081h,041h,021h,0f9h,022h,0b1h,081h,041h,021h	; 8460  .A..!...A!."..A!
	defb 0e9h,0ech,042h,0d6h,0fah,013h,0e1h,003h,023h,043h,073h,0b3h,093h,02fh,047h,003h	; 8470  ..B.....#Cs../G.
	defb 023h,043h,073h,0b3h,093h,06fh,097h,003h,023h,043h,073h,0b3h,093h,02fh,047h,043h	; 8480  #Cs..o..#Cs../GC
	defb 023h,003h,023h,043h,073h,02fh,047h,0eah,070h,084h,0e9h,0e7h,0d6h,0fah,022h,0e2h	; 8490  #.#Cs/G.p.....".
	defb 0c0h,0e8h,003h,0b1h,081h,041h,021h,0b1h,081h,040h,0e9h,021h,0e3h,0b1h,081h,041h	; 84a0  .....A!..@.!...A
	defb 021h,0f9h,012h,0e4h,0b1h,081h,041h,021h,0e9h,0d6h,0edh,0ffh,084h,0edh,00ah,085h	; 84b0  !.....A!........
	defb 0edh,014h,085h,0edh,00ah,085h,0edh,0ffh,084h,0edh,00ah,085h,0fah,000h,021h,0fbh	; 84c0  ..............!.
	defb 000h,021h,0fch,014h,023h,0edh,00ah,085h,0fah,000h,061h,0fbh,000h,061h,0fch,014h	; 84d0  .!..#.....a..a..
	defb 063h,0edh,0ffh,084h,0edh,00ah,085h,0edh,014h,085h,0d4h,043h,073h,0b3h,0d6h,0edh	; 84e0  c..........Cs...
	defb 0ffh,084h,0edh,00ah,085h,0edh,014h,085h,061h,091h,071h,0b1h,0eah,0b8h,084h,0fah	; 84f0  ........a.q.....
	defb 000h,0e4h,091h,0fbh,000h,091h,0fch,014h,09bh,0eeh,0fah,000h,041h,0fbh,000h,041h	; 8500  ............A..A
	defb 0fch,014h,043h,0eeh,0fah,000h,021h,0fbh,000h,021h,0fch,014h,02bh,0eeh,0e9h,0d6h	; 8510  ..C...!..!..+...
	defb 0f8h,022h,0e8h,003h,0b2h,0b1h,081h,041h,021h,0e8h,002h,0b1h,081h,041h,0e9h,0e0h	; 8520  .".....A!....A..
	defb 021h,0e1h,0b1h,081h,041h,021h,0f7h,022h,0b1h,081h,040h,0e9h,0e7h,0ech,042h,0d6h	; 8530  !...A!."..@...B.
	defb 0f9h,020h,0e1h,0c2h,003h,023h,043h,073h,0b3h,091h,02fh,049h,003h,023h,043h,073h	; 8540  . ...#Cs../I.#Cs
	defb 0b3h,091h,06fh,099h,003h,023h,043h,073h,0b3h,091h,02fh,049h,043h,023h,003h,023h	; 8550  ..o..#Cs../IC#.#
	defb 043h,070h,0fah,013h,0e2h,067h,047h,027h,0eah,03bh,085h,0e6h,0d6h,0fch,051h,0e8h	; 8560  Cp...gG'......Q.
	defb 004h,092h,0e8h,006h,06ch,0ebh,0ffh,0e6h,0d6h,0fch,051h,0e1h,0c0h,0e8h,005h,042h	; 8570  ....l.....Q....B
	defb 0e8h,006h,07bh,0ebh,0ffh,0e6h,0d6h,0fch,051h,0e1h,0c1h,0e8h,005h,07dh,0ebh,0ffh	; 8580  ..{.....Q....}..
	defb 0edh,099h,085h,0edh,0cah,085h,0eah,090h,085h,0e9h,0d6h,0fch,051h,0e1h,001h,0e2h	; 8590  ............Q...
	defb 001h,0fah,035h,0e4h,001h,0fch,051h,0e2h,031h,0fah,035h,0e4h,031h,0fch,051h,0e2h	; 85a0  ..5...Q.1.5.1.Q.
	defb 031h,053h,0fah,035h,0e4h,051h,050h,050h,051h,050h,050h,0fch,034h,0e2h,071h,070h	; 85b0  1S.5.QPPQPP.4.qp
	defb 080h,070h,050h,030h,020h,0feh,002h,099h,085h,0eeh,0e9h,0d6h,0fch,051h,0e2h,003h	; 85c0  .pP0 ........Q..
	defb 032h,070h,0e1h,005h,020h,030h,020h,0c0h,0e2h,0a0h,0c0h,050h,0c0h,0a0h,0c0h,071h	; 85d0  2p.. 0 ....P...q
	defb 031h,0fah,035h,0e4h,030h,030h,030h,030h,0fch,051h,0e2h,050h,070h,080h,070h,050h	; 85e0  1.5.0000.Q.Pp.pP
	defb 0fah,051h,070h,080h,050h,0fch,051h,030h,050h,070h,050h,030h,0fah,051h,050h,070h	; 85f0  .Qp.P.Q0PpP0.QPp
	defb 030h,0fch,051h,020h,0c0h,020h,040h,050h,0c0h,060h,090h,071h,0fah,035h,0e4h,050h	; 8600  0.Q . @P.`.q.5.P
	defb 050h,030h,030h,020h,020h,0feh,002h,0cch,085h,0fch,051h,0e1h,001h,000h,000h,001h	; 8610  P00  .....Q.....
	defb 071h,051h,0e2h,0a1h,0e3h,070h,080h,0a0h,070h,0e1h,001h,000h,000h,001h,031h,021h	; 8620  qQ...p..p.....1!
	defb 071h,0e3h,070h,090h,0a0h,0b0h,0feh,002h,019h,086h,0e1h,001h,000h,000h,001h,031h	; 8630  q.p............1
	defb 022h,032h,051h,030h,020h,000h,0fah,051h,030h,020h,000h,0fch,051h,0e2h,030h,020h	; 8640  "2Q0 ..Q0 ..Q.0
	defb 000h,0fah,051h,030h,020h,000h,0fah,035h,0e4h,000h,000h,000h,000h,0fch,051h,0e1h	; 8650  ..Q0 ..5......Q.
	defb 001h,000h,000h,001h,071h,052h,022h,0e2h,0a1h,0fch,043h,071h,0f9h,023h,070h,070h	; 8660  ....qR"...Cq.#pp
	defb 0fch,043h,0b1h,0f9h,023h,0b0h,0b0h,0fch,043h,0e1h,001h,0f9h,023h,000h,000h,0fch	; 8670  .C..#...C...#...
	defb 043h,021h,0f9h,023h,020h,020h,0eeh,0edh,090h,086h,0edh,0b3h,086h,0eah,087h,086h	; 8680  C!.#  ..........
	defb 0e9h,0d6h,0fch,035h,0e3h,001h,000h,000h,001h,030h,030h,031h,030h,030h,051h,050h	; 8690  ...5.....00100QP
	defb 050h,051h,050h,050h,051h,050h,050h,071h,070h,080h,070h,050h,030h,020h,0feh,002h	; 86a0  PQPPQPPqp.pP0 ..
	defb 090h,086h,0eeh,0e9h,0d6h,0fch,035h,0e3h,001h,000h,000h,0e4h,0a1h,0a0h,0a0h,081h	; 86b0  ......5.........
	defb 080h,080h,071h,070h,070h,0a1h,0a0h,0a0h,0e3h,021h,020h,020h,031h,030h,030h,030h	; 86c0  ..qpp....!  1000
	defb 030h,030h,030h,051h,050h,050h,051h,050h,050h,001h,000h,000h,001h,000h,000h,021h	; 86d0  000QPPQPP......!
	defb 020h,020h,021h,020h,020h,071h,050h,050h,030h,030h,020h,020h,0feh,002h,0b8h,086h	; 86e0    !  qPP00  ....
	defb 0e3h,001h,000h,000h,001h,000h,000h,0e4h,071h,070h,070h,071h,070h,070h,081h,080h	; 86f0  ........qppqpp..
	defb 080h,081h,080h,080h,0a1h,0a0h,0a0h,071h,070h,070h,0feh,002h,0f0h,086h,081h,080h	; 8700  .......qpp......
	defb 080h,081h,080h,080h,0a1h,0a0h,0a0h,0a1h,0a0h,0a0h,0e3h,001h,000h,000h,001h,000h	; 8710  ................
	defb 000h,001h,000h,000h,000h,000h,000h,000h,0e4h,081h,080h,080h,081h,080h,080h,0a1h	; 8720  ................
	defb 0a0h,0a0h,0a1h,0a0h,0a0h,0fdh,035h,0e4h,071h,070h,070h,051h,050h,050h,031h,030h	; 8730  ......5.qppQPP10
	defb 030h,021h,020h,020h,0eeh,0edh,04eh,087h,0edh,07fh,087h,0eah,045h,087h,0e9h,0d6h	; 8740  0!  ..N.....E...
	defb 0fbh,051h,0e2h,071h,0e3h,071h,0e8h,001h,000h,000h,0e9h,0a1h,0e8h,001h,000h,000h	; 8750  .Q.q.q..........
	defb 0e9h,0a1h,0e2h,003h,0e8h,001h,010h,000h,000h,000h,010h,000h,000h,000h,0e9h,0fbh	; 8760  ................
	defb 034h,021h,020h,030h,0e8h,001h,010h,000h,000h,000h,0feh,002h,04eh,087h,0eeh,0e9h	; 8770  4! 0........N...
	defb 0d6h,0e9h,0fah,035h,0e3h,071h,0e8h,001h,000h,000h,0e9h,051h,0e8h,001h,000h,000h	; 8780  ...5.q.....Q....
	defb 0e9h,031h,0e8h,001h,000h,000h,0e9h,021h,0e8h,001h,000h,000h,0e9h,051h,0e8h,001h	; 8790  .1.....!.....Q..
	defb 000h,000h,0e9h,0a1h,0e8h,001h,000h,000h,0e9h,0a1h,0e8h,001h,000h,000h,010h,000h	; 87a0  ................
	defb 000h,000h,0e9h,0e4h,051h,050h,050h,0e8h,001h,000h,000h,000h,000h,0e9h,001h,000h	; 87b0  ....QPP.........
	defb 000h,0e8h,001h,000h,000h,000h,000h,0e9h,0fbh,051h,0e2h,061h,0e8h,001h,000h,000h	; 87c0  .........Q.a....
	defb 0e9h,091h,0e8h,001h,000h,000h,0e9h,0b1h,0e8h,001h,000h,000h,010h,000h,000h,000h	; 87d0  ................
	defb 0feh,002h,081h,087h,0e9h,031h,030h,030h,031h,0e1h,001h,0e2h,0a1h,0e8h,001h,000h	; 87e0  .....1001.......
	defb 000h,000h,000h,000h,000h,0e9h,031h,030h,030h,031h,0e1h,001h,0e2h,0a1h,0e8h,001h	; 87f0  ......1001......
	defb 000h,000h,010h,000h,000h,000h,0feh,002h,0e4h,087h,0e9h,031h,0e8h,001h,000h,000h	; 8800  ...........1....
	defb 0e9h,031h,071h,052h,072h,0a1h,070h,050h,030h,0e8h,001h,000h,010h,000h,0e9h,0e3h	; 8810  .1qRr.pP0.......
	defb 070h,050h,030h,0e8h,001h,000h,010h,000h,000h,000h,000h,000h,0e9h,0e2h,031h,0e8h	; 8820  pP0...........1.
	defb 001h,000h,000h,0e9h,031h,0e1h,001h,0e2h,0a2h,052h,021h,0fbh,043h,021h,0e8h,001h	; 8830  ....1....R!.C!..
	defb 000h,000h,0e9h,021h,0e8h,001h,000h,000h,0e9h,071h,0e8h,001h,000h,000h,0e9h,0b1h	; 8840  ...!.....q......
	defb 0e8h,001h,000h,000h,0eeh,0e9h,0d6h,0fch,022h,0e2h,081h,0e1h,021h,051h,0b1h,0fbh	; 8850  ........"...!Q..
	defb 022h,0e2h,081h,0e1h,021h,051h,0b1h,0fah,022h,0e2h,081h,0e1h,021h,051h,0b1h,0f9h	; 8860  "...!Q.."...!Q..
	defb 022h,0e2h,081h,0e1h,021h,051h,0b1h,0dch,0fbh,022h,0e2h,0b1h,021h,081h,021h,0b1h	; 8870  "...!Q..."..!.!.
	defb 021h,0e1h,001h,0e2h,031h,091h,031h,0e1h,001h,0e2h,031h,0d6h,041h,071h,0a1h,0e1h	; 8880  !...1.1...1.Aq..
	defb 011h,041h,0f5h,022h,041h,0fah,022h,0e2h,041h,071h,0a1h,0e1h,011h,041h,0f5h,022h	; 8890  .A."A.".Aq...A."
	defb 041h,0fbh,022h,0e2h,051h,081h,0b1h,0e1h,021h,051h,0f5h,022h,051h,0fah,022h,0e2h	; 88a0  A.".Q...!Q."Q.".
	defb 051h,081h,0b1h,0e1h,021h,051h,0f3h,022h,051h,0dch,0fbh,022h,0e2h,020h,080h,0b0h	; 88b0  Q...!Q."Q..". ..
	defb 020h,080h,0b0h,0e1h,020h,050h,080h,050h,020h,0e2h,0b0h,080h,050h,020h,080h,0eah	; 88c0   ... P.P ...P ..
	defb 077h,088h,0e9h,0d6h,0fdh,035h,0e4h,081h,0e3h,021h,051h,0b1h,0fch,035h,0e4h,081h	; 88d0  w....5...!Q..5..
	defb 0e3h,021h,051h,0b1h,0fbh,035h,0e4h,081h,0e3h,021h,051h,0b1h,0fah,035h,0e4h,081h	; 88e0  .!Q..5...!Q..5..
	defb 0e3h,021h,051h,0b1h,0d3h,0fbh,023h,0e3h,02dh,0f7h,000h,021h,0fbh,023h,0e4h,08dh	; 88f0  .!Q...#.-..!.#..
	defb 0f7h,000h,081h,0fbh,023h,0bdh,0f7h,000h,0b1h,0fbh,023h,0e3h,03dh,0f7h,000h,031h	; 8900  ....#.....#.=..1
	defb 0fbh,023h,0e4h,09dh,0f7h,000h,091h,0fbh,023h,0e3h,00dh,0f7h,000h,001h,0fbh,023h	; 8910  .#......#......#
	defb 0e4h,07dh,0f7h,000h,071h,0fbh,023h,0adh,0f7h,000h,0a1h,0fbh,023h,0e3h,04dh,0f7h	; 8920  .}..q.#.....#.M.
	defb 000h,041h,0fbh,023h,05dh,0f7h,000h,051h,0fbh,023h,0e4h,08dh,0f7h,000h,081h,0fbh	; 8930  .A.#]..Q.#......
	defb 023h,0bdh,0f7h,000h,0b1h,0fbh,023h,0ech,042h,023h,083h,0b3h,023h,083h,0b3h,0e3h	; 8940  #.....#.B#..#...
	defb 023h,053h,0d6h,0e4h,0bfh,0eah,0f4h,088h,0e9h,0d6h,0fah,022h,0e1h,050h,0b1h,0e2h	; 8950  #S.........".P..
	defb 081h,0e1h,021h,051h,0b1h,0f9h,020h,0e2h,081h,0e1h,021h,051h,0b1h,0f8h,020h,0e2h	; 8960  ..!Q.. ...!Q.. .
	defb 081h,0e1h,021h,051h,0b1h,0f7h,020h,0e2h,081h,0e1h,021h,050h,0e7h,0dch,0f8h,020h	; 8970  ..!Q.. ...!P...
	defb 0e2h,0b0h,021h,0b1h,021h,081h,021h,0b1h,021h,0e1h,001h,0e2h,031h,091h,031h,0e1h	; 8980  ..!.!.!.!...1.1.
	defb 001h,0e2h,031h,0d6h,041h,071h,0a1h,0e1h,011h,041h,0f2h,020h,041h,0f7h,020h,0e2h	; 8990  ..1.Aq...A. A. .
	defb 041h,071h,0a1h,0e1h,011h,041h,0f2h,020h,041h,0f8h,020h,0e2h,051h,081h,0b1h,0e1h	; 89a0  Aq...A. A. .Q...
	defb 021h,051h,0f2h,020h,051h,0f7h,020h,0e2h,051h,081h,0b1h,0e1h,021h,051h,0f1h,020h	; 89b0  !Q. Q. .Q...!Q.
	defb 051h,0dch,0f9h,020h,0e2h,020h,080h,0b0h,020h,080h,0b0h,0e1h,020h,050h,080h,050h	; 89c0  Q.. . .. ... P.P
	defb 020h,0e2h,0b0h,080h,0eah,07ch,089h,0e9h,0ech,042h,0d3h,0fch,023h,0e1h,0edh,06bh	; 89d0   ....|...B..#..k
	defb 08ah,0a1h,0e1h,011h,041h,0e2h,011h,041h,071h,041h,071h,0a1h,0d6h,0e1h,01bh,0ech	; 89e0  ....A..AqAq.....
	defb 000h,0fch,023h,0edh,0ffh,089h,0edh,0ffh,089h,0edh,035h,08ah,0eah,0f1h,089h,0e1h	; 89f0  ..#.......5.....
	defb 020h,020h,010h,010h,020h,020h,050h,050h,0feh,002h,0ffh,089h,020h,020h,010h,010h	; 8a00    ..  PP....  ..
	defb 020h,020h,070h,070h,0feh,002h,00ch,08ah,020h,020h,010h,010h,020h,020h,050h,050h	; 8a10    pp....  ..  PP
	defb 0feh,002h,018h,08ah,020h,020h,010h,010h,020h,020h,090h,090h,070h,070h,050h,050h	; 8a20  ....  ..  ..ppPP
	defb 040h,040h,010h,010h,0eeh,050h,050h,040h,040h,050h,050h,080h,080h,0feh,002h,035h	; 8a30  @@...PP@@PP....5
	defb 08ah,040h,040h,030h,030h,040h,040h,090h,090h,0feh,002h,041h,08ah,050h,050h,040h	; 8a40  .@@00@@....A.PP@
	defb 040h,050h,050h,080h,080h,0feh,002h,04dh,08ah,0a0h,0a0h,070h,070h,040h,040h,010h	; 8a50  @PP....M...pp@@.
	defb 010h,040h,040h,070h,070h,0a0h,0a0h,0e0h,010h,010h,0eeh,073h,011h,041h,071h,0a1h	; 8a60  .@@pp......s.Aq.
	defb 043h,0e2h,0a1h,0e1h,011h,041h,071h,0e2h,0a3h,071h,0eeh,0e9h,0d6h,0fdh,034h,0e4h	; 8a70  C....Aq..q....4.
	defb 071h,040h,0a0h,0e3h,010h,070h,041h,011h,0e4h,071h,0a1h,071h,041h,010h,040h,070h	; 8a80  q@...pA..q.qA.@p
	defb 010h,040h,0a0h,0ech,05fh,04bh,0edh,0d0h,08ah,0edh,0d0h,08ah,050h,0feh,00eh,09ch	; 8a90  .@.._K......P...
	defb 08ah,0fdh,023h,050h,050h,0fch,000h,060h,0feh,00eh,0a5h,08ah,0fdh,023h,060h,060h	; 8aa0  ..#PP..`.....#``
	defb 0fch,000h,050h,0feh,008h,0b0h,08ah,080h,0feh,008h,0b7h,08ah,090h,090h,090h,090h	; 8ab0  ..P.............
	defb 0fdh,023h,040h,040h,070h,080h,0fch,000h,090h,0feh,008h,0c6h,08ah,0eah,096h,08ah	; 8ac0  .#@@p...........
	defb 0e9h,0fch,000h,0e4h,020h,0feh,00eh,0d0h,08ah,0fdh,023h,020h,030h,0fch,000h,040h	; 8ad0  .... .....# 0..@
	defb 0feh,00eh,0ddh,08ah,0fdh,023h,040h,040h,0fch,000h,050h,0feh,00eh,0e8h,08ah,0fdh	; 8ae0  .....#@@..P.....
	defb 023h,050h,050h,0fch,000h,070h,0feh,006h,0f3h,08ah,0fdh,023h,070h,080h,0fch,000h	; 8af0  #PP..p.....#p...
	defb 090h,0feh,008h,0feh,08ah,0eeh,0e9h,0e6h,0e7h,0ech,044h,0d3h,0f9h,010h,0e1h,0c2h	; 8b00  ..........D.....
	defb 0edh,06bh,08ah,0a0h,0e1h,011h,0fbh,033h,0e3h,0a1h,0e2h,011h,041h,011h,041h,071h	; 8b10  .k.....3....A.Aq
	defb 0d6h,0abh,0ech,000h,0ebh,0e7h,0fah,020h,0c2h,0edh,0ffh,089h,0edh,0ffh,089h,0edh	; 8b20  ....... ........
	defb 035h,08ah,0eah,029h,08bh,0e9h,0d6h,0cfh,0edh,03eh,08bh,0eah,038h,08bh,0d4h,0fah	; 8b30  5..).....>..8...
	defb 023h,0e0h,001h,0e1h,061h,0e2h,0b1h,061h,0f9h,023h,0e1h,061h,0e2h,0b1h,061h,001h	; 8b40  #...a..a.#.a..a.
	defb 0f8h,023h,0b1h,061h,001h,0e3h,0b1h,0eeh,0e9h,0d6h,0cfh,0e7h,0edh,03eh,08bh,0eah	; 8b50  .#.a.........>..
	defb 05ch,08bh,0e9h,0d6h,0cfh,0e7h,0d4h,0f8h,022h,0e0h,002h,001h,0e1h,061h,0e2h,0b1h	; 8b60  \......."....a..
	defb 061h,0e1h,061h,0e2h,0b1h,061h,001h,0f6h,022h,0b1h,061h,000h,0eah,065h,08bh,0edh	; 8b70  a.a..a..".a..e..
	defb 08eh,08bh,0e9h,0d6h,0c3h,0edh,099h,085h,0edh,0cah,085h,0eah,085h,08bh,0e9h,0d8h	; 8b80  ................
	defb 0fch,041h,0e1h,002h,072h,052h,020h,040h,050h,042h,002h,030h,020h,0d9h,000h,020h	; 8b90  .A..rR @PB.0 ..
	defb 050h,0a0h,0e0h,006h,0e8h,005h,04bh,0eeh,0edh,0b7h,08bh,0e9h,0d6h,0c3h,0edh,090h	; 8ba0  P.....K.........
	defb 086h,0edh,0b3h,086h,0eah,0aeh,08bh,0e9h,0e7h,0d1h,0fch,024h,0e3h,00bh,074h,0e2h	; 8bb0  ...........$..t.
	defb 006h,0e3h,007h,007h,007h,0e4h,0a7h,0e3h,057h,0a7h,0e4h,0a7h,0a7h,0a7h,097h,0e3h	; 8bc0  ........W.......
	defb 047h,097h,0e4h,097h,097h,097h,087h,0e3h,037h,0d9h,080h,0e4h,0a0h,0e3h,050h,0a0h	; 8bd0  G.......7.....P.
	defb 0fch,025h,006h,0d4h,0c1h,0dah,0e8h,006h,009h,0eeh,0edh,0f9h,08bh,0e9h,0d6h,0c3h	; 8be0  .%..............
	defb 0edh,04eh,087h,0edh,07fh,087h,0eah,0f0h,08bh,0e9h,0d8h,0fch,041h,0e2h,072h,0e1h	; 8bf0  .N..........A.r.
	defb 002h,0e2h,0a2h,0a0h,0a0h,0a0h,092h,092h,0e1h,000h,0e2h,0a0h,0d9h,080h,0a0h,0e1h	; 8c00  ................
	defb 020h,050h,046h,0d4h,0c0h,0ddh,0e8h,005h,077h,0eeh,0e9h,0ech,041h,0d3h,0fbh,003h	; 8c10   PF.....w...A...
	defb 0e2h,0edh,03dh,08ch,0fbh,021h,0e1h,0edh,061h,08ch,0fbh,003h,041h,021h,04fh,0edh	; 8c20  ..=..!..a...A!O.
	defb 068h,08ch,0fbh,021h,0edh,085h,08ch,0fch,024h,063h,0d6h,02bh,0ffh,093h,0e1h,021h	; 8c30  h..!....$c.+...!
	defb 011h,025h,011h,0e2h,0b1h,0e1h,011h,029h,061h,077h,071h,061h,041h,071h,011h,041h	; 8c40  .%.....)awqaAq.A
	defb 099h,071h,063h,0e0h,021h,011h,025h,011h,0e1h,0b3h,0e0h,023h,0e1h,093h,0e0h,023h	; 8c50  .qc.!.%....#...#
	defb 0eeh,060h,070h,0feh,006h,061h,08ch,0eeh,0e2h,093h,0e1h,021h,011h,025h,011h,0e2h	; 8c60  .`p..a.....!.%..
	defb 0b1h,0e1h,011h,029h,061h,077h,071h,061h,041h,071h,011h,041h,099h,071h,063h,021h	; 8c70  ...)awqaAq.A.qc!
	defb 061h,073h,041h,061h,0eeh,040h,060h,0feh,006h,085h,08ch,0eeh,0e9h,0d3h,0fbh,011h	; 8c80  asAa.@`.........
	defb 0e3h,02fh,0e4h,07fh,0e3h,047h,027h,017h,0e4h,097h,0e3h,02fh,0e4h,0bfh,0e3h,047h	; 8c90  ./...G'..../...G
	defb 0e4h,0b7h,097h,0e3h,017h,02fh,0e4h,07fh,0e3h,047h,027h,017h,0e4h,097h,0e3h,027h	; 8ca0  ...../...G'....'
	defb 0e4h,077h,09bh,0d6h,0e3h,011h,02bh,0ffh,0e9h,0e7h,0ech,041h,0d3h,0f9h,003h,0e2h	; 8cb0  .w....+....A....
	defb 0c2h,0edh,03dh,08ch,0f9h,021h,0e1h,0edh,061h,08ch,0f9h,003h,041h,021h,04fh,0edh	; 8cc0  ..=..!..a...A!O.
	defb 068h,08ch,0f9h,021h,0edh,085h,08ch,0fah,024h,063h,0d6h,029h,0ffh,0e9h,0d8h,0c3h	; 8cd0  h..!....$c.)....
	defb 0edh,05fh,08dh,071h,0e9h,0ech,042h,0d8h,0fch,041h,0edh,0f6h,08ch,0edh,0f6h,08ch	; 8ce0  ._.q..B..A......
	defb 0edh,031h,08dh,0eah,0e4h,08ch,0e1h,043h,001h,021h,043h,021h,001h,023h,023h,073h	; 8cf0  .1.....C.!C!.##s
	defb 0e2h,0b3h,0e1h,003h,0e2h,091h,0b1h,0e1h,003h,0e2h,0b1h,091h,0b3h,0b3h,0e1h,043h	; 8d00  ...............C
	defb 0e2h,0b3h,093h,091h,0b1h,0e1h,003h,0e2h,0b1h,091h,073h,041h,071h,0e1h,003h,0e2h	; 8d10  ..........sAq...
	defb 073h,063h,061h,091h,0e1h,001h,021h,041h,061h,073h,071h,091h,071h,051h,041h,021h	; 8d20  sca...!Aasq.qQA!
	defb 0eeh,073h,031h,051h,073h,051h,031h,053h,053h,0a3h,023h,033h,001h,021h,033h,021h	; 8d30  .s1QsQ1SS.#3.!3!
	defb 001h,023h,023h,073h,0e2h,0a3h,0e1h,003h,001h,021h,033h,021h,001h,0e2h,0a3h,0a1h	; 8d40  .##s.....!3!....
	defb 0e1h,021h,033h,0e2h,0a1h,071h,093h,091h,0e1h,001h,023h,041h,061h,07fh,0eeh,0e8h	; 8d50  .!3..q....#Aa...
	defb 002h,071h,021h,041h,001h,0feh,006h,05fh,08dh,0e8h,003h,0a1h,081h,071h,051h,031h	; 8d60  .q!A..._.....qQ1
	defb 021h,0e8h,002h,0a1h,0eeh,0e9h,0d8h,0c3h,0e8h,005h,007h,007h,0e8h,004h,0a7h,0a7h	; 8d70  !...............
	defb 097h,097h,0e9h,0fbh,024h,0e3h,0a1h,081h,071h,051h,031h,021h,0e4h,0a1h,071h,0e9h	; 8d80  ....$...qQ1!..q.
	defb 0d8h,0fbh,024h,0e3h,001h,0f9h,024h,001h,0fbh,024h,041h,0f9h,024h,041h,0fbh,024h	; 8d90  ..$...$..$A.$A.$
	defb 071h,0f9h,024h,071h,0fbh,024h,001h,0f9h,024h,001h,0fbh,024h,0e4h,0b1h,0f9h,024h	; 8da0  q.$q.$..$..$...$
	defb 0b1h,0fbh,024h,0b1h,091h,0b1h,0f9h,024h,0b1h,0fbh,024h,071h,0f9h,024h,071h,0fbh	; 8db0  ..$....$..$q.$q.
	defb 024h,091h,0f9h,024h,091h,0fbh,024h,0e3h,001h,0f9h,024h,001h,0fbh,024h,041h,0f9h	; 8dc0  $..$..$...$..$A.
	defb 024h,041h,0fbh,024h,0e4h,091h,0f9h,024h,091h,0fbh,024h,0e3h,041h,0f9h,024h,041h	; 8dd0  $A.$...$..$.A.$A
	defb 0fbh,024h,041h,021h,041h,0f9h,024h,041h,0fbh,024h,0e4h,071h,0f9h,024h,071h,0fbh	; 8de0  .$A!A.$A.$.q.$q.
	defb 024h,0e3h,051h,0f9h,024h,051h,0fbh,024h,001h,0f9h,024h,001h,0fbh,024h,0e4h,091h	; 8df0  $.Q.$Q.$..$..$..
	defb 0f9h,024h,091h,0fbh,024h,0e3h,051h,0f9h,024h,051h,0fbh,024h,041h,0f9h,024h,041h	; 8e00  .$..$.Q.$Q.$A.$A
	defb 0fbh,024h,001h,0f9h,024h,001h,0fbh,024h,0e4h,071h,0f9h,024h,071h,0fbh,024h,0e3h	; 8e10  .$..$..$.q.$q.$.
	defb 041h,0f9h,024h,041h,0fbh,024h,021h,0f9h,024h,021h,0fbh,024h,0e4h,091h,0f9h,024h	; 8e20  A.$A.$!.$!.$...$
	defb 091h,0fbh,024h,061h,0f9h,024h,061h,0fbh,024h,0e3h,021h,0f9h,024h,021h,0fbh,024h	; 8e30  ..$a.$a.$.!.$!.$
	defb 071h,0f9h,024h,071h,0fbh,024h,021h,0f9h,024h,021h,0fbh,024h,071h,0f9h,024h,071h	; 8e40  q.$q.$!.$!.$q.$q
	defb 0fbh,024h,0b1h,0f9h,024h,0b1h,0feh,002h,08fh,08dh,0fbh,024h,031h,0f9h,024h,031h	; 8e50  .$..$......$1.$1
	defb 0fbh,024h,0a1h,081h,0a1h,0f9h,024h,0a1h,0fbh,024h,071h,0f9h,024h,071h,0fbh,024h	; 8e60  .$....$..$q.$q.$
	defb 0a1h,0f9h,024h,0a1h,0fbh,024h,051h,0f9h,024h,051h,0fbh,024h,0a1h,0e2h,001h,021h	; 8e70  ..$..$Q.$Q.$...!
	defb 0e3h,0a1h,001h,0f9h,024h,001h,0fbh,024h,071h,051h,071h,0f9h,024h,071h,0fbh,024h	; 8e80  ....$..$qQq.$q.$
	defb 001h,0f9h,024h,001h,0fbh,024h,0e4h,0a1h,0f9h,024h,0a1h,0fbh,024h,0a1h,0f9h,024h	; 8e90  ..$..$...$..$..$
	defb 0a1h,0fbh,024h,0e3h,021h,0a1h,071h,0a1h,0fbh,024h,081h,0f9h,024h,081h,0fbh,024h	; 8ea0  ..$.!.q..$..$..$
	defb 031h,0f9h,024h,031h,0fbh,024h,0e2h,001h,0f9h,024h,001h,0fbh,024h,0e3h,081h,0f9h	; 8eb0  1.$1.$...$..$...
	defb 024h,081h,0fbh,024h,071h,0f9h,024h,071h,0fbh,024h,031h,0f9h,024h,031h,0fbh,024h	; 8ec0  $..$q.$q.$1.$1.$
	defb 0a1h,0f9h,024h,0a1h,0fbh,024h,071h,0f9h,024h,071h,0fbh,024h,061h,0f9h,024h,061h	; 8ed0  ..$..$q.$q.$a.$a
	defb 0fbh,024h,021h,0f9h,024h,021h,0fbh,024h,091h,0f9h,024h,091h,0fbh,024h,061h,0f9h	; 8ee0  .$!.$!.$..$..$a.
	defb 024h,061h,0fbh,024h,071h,0f9h,024h,071h,0fbh,024h,071h,091h,0b1h,071h,091h,0b1h	; 8ef0  $a.$q.$q.$q..q..
	defb 0eah,08fh,08dh,0e9h,0d8h,0c0h,0c3h,0edh,05fh,08dh,070h,0e9h,0e7h,0ech,042h,0d8h	; 8f00  ........_.p...B.
	defb 0f8h,020h,0c1h,0edh,0f6h,08ch,0edh,0f6h,08ch,0edh,031h,08dh,0eah,013h,08fh,0e9h	; 8f10  . ........1.....
	defb 0e6h,0d3h,0fbh,021h,0e2h,0b1h,051h,021h,0a1h,041h,011h,091h,031h,001h,071h,011h	; 8f20  ...!..Q!.A..1.q.
	defb 0e3h,0a1h,0d4h,0fah,045h,040h,040h,040h,0f9h,045h,040h,040h,040h,0ebh,0ffh,0e9h	; 8f30  ....E@@@.E@@@...
	defb 0e6h,0d3h,0fbh,021h,0e3h,0b1h,051h,021h,0a1h,041h,011h,091h,031h,001h,071h,011h	; 8f40  ...!..Q!.A..1.q.
	defb 0e4h,0a1h,0d4h,0fah,045h,040h,040h,040h,0f9h,045h,040h,040h,040h,0ebh,0ffh,0e9h	; 8f50  ....E@@@.E@@@...
	defb 0e6h,0e7h,0d3h,0f9h,020h,0e2h,0c1h,0b1h,051h,021h,0a1h,041h,011h,091h,031h,001h	; 8f60  .... ...Q!.A..1.
	defb 071h,011h,0e3h,0a1h,0d4h,0f7h,021h,040h,040h,040h,0f6h,021h,040h,0ebh,0ffh,0e9h	; 8f70  q.....!@@@.!@...
	defb 0d7h,0fch,041h,0e2h,0c3h,0b2h,022h,0e1h,000h,0e2h,0b0h,090h,0b2h,022h,0e1h,020h	; 8f80  ..A..."......".
	defb 000h,0e2h,0b0h,0e1h,002h,0e2h,072h,092h,0e1h,002h,0d8h,0e2h,0b2h,092h,078h,0c7h	; 8f90  ......r.......x.
	defb 0ffh,0e9h,0d7h,0fch,035h,0e3h,0c3h,0d1h,076h,0e4h,076h,0e3h,076h,0d7h,072h,070h	; 8fa0  ....5...v.v.v.rp
	defb 0e4h,070h,0e3h,070h,0d1h,056h,0e4h,056h,0e3h,056h,0d7h,052h,050h,0e4h,050h,0e3h	; 8fb0  .p.p.V.V.V.RP.P.
	defb 050h,0d1h,046h,0e4h,046h,0e3h,046h,0d7h,042h,040h,0e4h,040h,0e3h,040h,0d1h,036h	; 8fc0  P.F.F.F.B@.@.@.6
	defb 0e4h,036h,0e3h,036h,0d8h,032h,050h,000h,050h,078h,0c7h,0ffh,0e9h,0d7h,0fbh,041h	; 8fd0  .6.6.2P.Px.....A
	defb 0e2h,0c3h,072h,0e2h,070h,090h,0e1h,020h,0e2h,070h,070h,020h,052h,070h,090h,0b0h	; 8fe0  ..r.p.. .pp Rp..
	defb 0b0h,070h,020h,042h,040h,000h,040h,040h,000h,040h,032h,0d8h,070h,030h,050h,050h	; 8ff0  .p B@.@@.@2.p0PP
	defb 000h,050h,028h,0c7h,0ffh,0ffh	; 9000

; ----------------------------------------------------------------------
; DATOS fichas_de_choque: fichas de 4 bytes que p03:B954 lee en 0x9006 + 4 x
;   (ix+0x11), con el banco 14 en 0x8000 (p03:B954 llama a 0x420A): dos
;   parejas que devuelve en BC y en HL. El numero de fichas no esta medido
;   (hay sitio para 206 y un byte); el bloque llega hasta el recuadro de
;   0x933F
;   0x9006..0x933f  (825 bytes)
DATA_fichas_de_choque:
	defb 000h,000h,010h,010h	; 9006
	defb 0f3h,000h,01dh,010h	; 900a
	defb 000h,007h,005h,009h	; 900e
	defb 000h,000h,00ah,00ah	; 9012
	defb 001h,001h,007h,007h	; 9016
	defb 000h,000h,006h,00eh	; 901a
	defb 000h,000h,008h,009h	; 901e
	defb 000h,000h,009h,009h	; 9022
	defb 000h,007h,009h,009h	; 9026
	defb 000h,000h,00eh,010h	; 902a
	defb 000h,000h,004h,004h	; 902e
	defb 005h,000h,00bh,010h	; 9032
	defb 002h,002h,00eh,00eh	; 9036
	defb 002h,000h,00eh,00eh	; 903a
	defb 000h,000h,00bh,010h	; 903e
	defb 000h,000h,009h,010h	; 9042
	defb 000h,000h,010h,007h	; 9046
	defb 000h,003h,004h,00ah	; 904a
	defb 000h,001h,010h,00dh	; 904e
	defb 001h,000h,00fh,010h	; 9052
	defb 000h,000h,008h,008h	; 9056
	defb 000h,002h,010h,00bh	; 905a
	defb 000h,001h,010h,00fh	; 905e
	defb 000h,000h,010h,00bh	; 9062
	defb 000h,003h,010h,00dh	; 9066
	defb 008h,000h,008h,010h	; 906a
	defb 000h,000h,00eh,00fh	; 906e
	defb 009h,000h,007h,008h	; 9072
	defb 006h,000h,00ah,00ah	; 9076
	defb 003h,000h,00dh,00dh	; 907a
	defb 00ch,000h,004h,010h	; 907e
	defb 000h,000h,007h,010h	; 9082
	defb 000h,004h,008h,00ch	; 9086
	defb 000h,000h,008h,00ch	; 908a
	defb 000h,000h,007h,008h	; 908e
	defb 000h,000h,00dh,00dh	; 9092
	defb 000h,002h,00ch,00eh	; 9096
	defb 000h,000h,00ch,00eh	; 909a
	defb 00ah,002h,006h,00bh	; 909e
	defb 008h,002h,008h,00bh	; 90a2
	defb 004h,002h,00ch,00bh	; 90a6
	defb 001h,002h,00fh,00bh	; 90aa
	defb 000h,000h,010h,00fh	; 90ae
	defb 00ah,000h,006h,010h	; 90b2
	defb 000h,000h,005h,006h	; 90b6
	defb 000h,000h,009h,00eh	; 90ba
	defb 000h,000h,007h,00ch	; 90be
	defb 000h,000h,008h,00fh	; 90c2
	defb 000h,000h,006h,007h	; 90c6
	defb 000h,002h,00fh,00eh	; 90ca
	defb 00ch,000h,004h,004h	; 90ce
	defb 00ch,00ch,004h,004h	; 90d2
	defb 008h,000h,008h,008h	; 90d6
	defb 008h,008h,008h,008h	; 90da
	defb 004h,000h,00ch,00ch	; 90de
	defb 004h,004h,00ch,00ch	; 90e2
	defb 00ch,003h,004h,00ah	; 90e6
	defb 000h,003h,01fh,01ah	; 90ea
	defb 000h,000h,010h,003h	; 90ee
	defb 000h,000h,003h,010h	; 90f2
	defb 001h,005h,00fh,016h	; 90f6
	defb 006h,006h,014h,014h	; 90fa
	defb 002h,001h,007h,00fh	; 90fe
	defb 002h,000h,007h,00fh	; 9102
	defb 000h,002h,006h,00eh	; 9106
	defb 002h,000h,00eh,020h	; 910a
	defb 006h,000h,019h,020h	; 910e
	defb 002h,000h,01eh,020h	; 9112
	defb 000h,000h,006h,006h	; 9116
	defb 005h,000h,016h,020h	; 911a
	defb 002h,000h,00ch,010h	; 911e
	defb 001h,003h,00dh,00ah	; 9122
	defb 001h,000h,007h,00ah	; 9126
	defb 000h,001h,009h,008h	; 912a
	defb 000h,000h,005h,005h	; 912e
	defb 000h,001h,005h,003h	; 9132
	defb 000h,000h,00dh,00eh	; 9136
	defb 002h,000h,00eh,010h	; 913a
	defb 001h,000h,00fh,018h	; 913e
	defb 001h,0f8h,00fh,018h	; 9142
	defb 000h,001h,00eh,00eh	; 9146
	defb 000h,000h,008h,006h	; 914a
	defb 000h,002h,010h,00ch	; 914e
	defb 000h,000h,00dh,009h	; 9152
	defb 000h,000h,00ah,008h	; 9156
	defb 000h,001h,010h,00eh	; 915a
	defb 000h,000h,005h,009h	; 915e
	defb 000h,002h,007h,00dh	; 9162
	defb 006h,000h,00ah,010h	; 9166
	defb 006h,002h,00ah,00eh	; 916a
	defb 006h,000h,00ah,00eh	; 916e
	defb 000h,000h,020h,020h	; 9172
	defb 006h,000h,00ah,008h	; 9176
	defb 008h,000h,008h,00ah	; 917a
	defb 000h,000h,00ah,005h	; 917e
	defb 000h,002h,003h,00eh	; 9182
	defb 000h,000h,003h,00eh	; 9186
	defb 000h,000h,00ch,00ch	; 918a
	defb 000h,004h,010h,008h	; 918e
	defb 004h,000h,008h,010h	; 9192
	defb 000h,000h,00eh,00eh	; 9196
	defb 000h,004h,00eh,00eh	; 919a
	defb 000h,001h,006h,00eh	; 919e
	defb 000h,003h,00bh,00ah	; 91a2
	defb 000h,001h,009h,00eh	; 91a6
	defb 001h,000h,009h,010h	; 91aa
	defb 000h,002h,00eh,01ch	; 91ae
	defb 002h,005h,00eh,016h	; 91b2
	defb 000h,0feh,018h,00eh	; 91b6
	defb 003h,002h,00ch,00ch	; 91ba
	defb 003h,002h,00ah,00ah	; 91be
	defb 004h,004h,008h,008h	; 91c2
	defb 005h,005h,006h,006h	; 91c6
	defb 000h,003h,010h,00ah	; 91ca
	defb 009h,004h,007h,007h	; 91ce
	defb 006h,003h,00ah,00ah	; 91d2
	defb 004h,002h,00ah,00ch	; 91d6
	defb 002h,002h,00ch,00ch	; 91da
	defb 000h,004h,007h,007h	; 91de
	defb 000h,003h,009h,00ah	; 91e2
	defb 006h,006h,005h,005h	; 91e6
	defb 000h,000h,018h,010h	; 91ea
	defb 004h,092h,015h,092h	; 91ee
	defb 015h,092h,026h,092h	; 91f2
	defb 02fh,092h,02fh,092h	; 91f6
	defb 02fh,092h,03ch,092h	; 91fa
	defb 059h,092h,062h,092h	; 91fe
	defb 073h,092h,00ch,00ch	; 9202
	defb 004h,020h,010h,004h	; 9206
	defb 004h,020h,010h,004h	; 920a
	defb 004h,020h,010h,004h	; 920e
	defb 004h,020h,010h,03ah	; 9212
	defb 00ch,020h,00ch,010h	; 9216
	defb 00ch,020h,00ch,010h	; 921a
	defb 00ch,020h,00ch,010h	; 921e
	defb 00ch,020h,00ch,010h	; 9222
	defb 012h,000h,010h,008h	; 9226
	defb 010h,000h,010h,008h	; 922a
	defb 010h,019h,020h,018h	; 922e
	defb 010h,010h,020h,018h	; 9232
	defb 010h,010h,020h,018h	; 9236
	defb 018h,010h,024h,004h	; 923a
	defb 004h,014h,028h,004h	; 923e
	defb 004h,014h,028h,004h	; 9242
	defb 004h,014h,028h,004h	; 9246
	defb 004h,014h,028h,004h	; 924a
	defb 004h,014h,028h,004h	; 924e
	defb 004h,014h,028h,004h	; 9252
	defb 004h,01ch,018h,037h	; 9256
	defb 028h,018h,008h,008h	; 925a
	defb 028h,018h,008h,008h	; 925e
	defb 01eh,008h,000h,008h	; 9262
	defb 018h,010h,000h,008h	; 9266
	defb 018h,018h,000h,008h	; 926a
	defb 018h,020h,000h,008h	; 926e
	defb 018h,02bh,020h,010h	; 9272
	defb 008h,030h,020h,018h	; 9276
	defb 008h,020h,020h,018h	; 927a
	defb 008h,018h,020h,020h	; 927e
	defb 008h,018h,018h,028h	; 9282
	defb 010h,00ch,018h,01ch	; 9286
	defb 010h,00ch,0a2h,092h	; 928a
	defb 0b3h,092h,0b3h,092h	; 928e
	defb 0c4h,092h,0d5h,092h	; 9292
	defb 0d5h,092h,0e2h,092h	; 9296
	defb 0f3h,092h,010h,093h	; 929a
	defb 01dh,093h,026h,093h	; 929e
	defb 00ch,004h,004h,028h	; 92a2
	defb 048h,004h,004h,028h	; 92a6
	defb 048h,00ch,004h,028h	; 92aa
	defb 048h,004h,004h,028h	; 92ae
	defb 048h,03ah,004h,004h	; 92b2
	defb 020h,048h,004h,004h	; 92b6
	defb 020h,048h,004h,004h	; 92ba
	defb 020h,048h,004h,004h	; 92be
	defb 020h,048h,010h,010h	; 92c2
	defb 008h,020h,020h,008h	; 92c6
	defb 008h,028h,020h,008h	; 92ca
	defb 008h,028h,020h,008h	; 92ce
	defb 008h,028h,020h,034h	; 92d2
	defb 000h,028h,048h,03ch	; 92d6
	defb 004h,02ch,040h,038h	; 92da
	defb 004h,014h,040h,048h	; 92de
	defb 018h,014h,00ch,018h	; 92e2
	defb 028h,004h,00ch,038h	; 92e6
	defb 028h,010h,00ch,024h	; 92ea
	defb 028h,00ch,00ch,028h	; 92ee
	defb 028h,024h,004h,004h	; 92f2
	defb 014h,028h,004h,004h	; 92f6
	defb 014h,028h,004h,004h	; 92fa
	defb 014h,028h,004h,004h	; 92fe
	defb 014h,028h,004h,004h	; 9302
	defb 014h,028h,004h,004h	; 9306
	defb 014h,028h,004h,004h	; 930a
	defb 01ch,018h,037h,000h	; 930e
	defb 008h,038h,028h,000h	; 9312
	defb 008h,038h,028h,000h	; 9316
	defb 008h,038h,028h,01ch	; 931a
	defb 004h,018h,018h,054h	; 931e
	defb 004h,018h,018h,054h	; 9322
	defb 02bh,010h,008h,008h	; 9326
	defb 040h,00ch,014h,00ch	; 932a
	defb 028h,000h,020h,010h	; 932e
	defb 020h,000h,010h,010h	; 9332
	defb 020h,000h,028h,018h	; 9336
	defb 028h,000h,000h,018h	; 933a
	defb 028h	; 933e

; ----------------------------------------------------------------------
; DATOS recuadro_de_14x12: un recuadro de 14 x 12 caracteres que p01:6226
;   copia por filas a 0xED29 con p01:6D49 (bancos 1-14-15, p00:42FA)
;   0x933f..0x93e7  (168 bytes)
DATA_recuadro_de_14x12:
	defb 000h,000h,000h,000h,000h,05fh,076h,077h,069h,000h,000h,000h,000h,000h	; 933f  ....._vwi.....
	defb 000h,000h,05ah,05bh,07ah,07bh,089h,08ah,07fh,084h,068h,067h,000h,000h	; 934d  ..Z[z{....hg..
	defb 000h,000h,05ch,05dh,08dh,08eh,08fh,090h,091h,085h,065h,066h,000h,000h	; 935b  ..\]......ef..
	defb 09fh,0a0h,07dh,05eh,061h,062h,078h,079h,063h,064h,000h,0a1h,0a2h,0a3h	; 9369  ..}^abxycd....
	defb 0aah,000h,0afh,080h,07ch,07eh,08bh,08ch,081h,086h,0aeh,0adh,000h,0ach	; 9377  ....|~........
	defb 0c1h,0c2h,0c3h,0c4h,092h,093h,094h,096h,097h,098h,0c5h,0c6h,0c7h,000h	; 9385  ..............
	defb 0b0h,0b1h,0b2h,0b3h,099h,09ah,09bh,09ch,09dh,09eh,0b4h,000h,0b5h,0b6h	; 9393  ..............
	defb 0a4h,0a7h,0a8h,0a9h,087h,082h,0cbh,0cfh,083h,095h,088h,0abh,0a6h,0a5h	; 93a1  ..............
	defb 0b8h,0b9h,0bah,0bdh,0bch,0bch,0bch,0bch,0bch,0bch,0beh,0bfh,0c0h,0bbh	; 93af  ..............
	defb 000h,000h,0b7h,000h,000h,0c8h,0c9h,0cdh,0cch,000h,000h,000h,000h,000h	; 93bd  ..............
	defb 000h,000h,000h,000h,000h,000h,0cah,0ceh,000h,000h,000h,000h,060h,000h	; 93cb  ............`.
	defb 000h,06ah,06bh,06ch,06dh,06eh,06fh,070h,071h,072h,073h,074h,075h,000h	; 93d9  .jklmnopqrstu.

; ----------------------------------------------------------------------
; DATOS sprites_93e7: 16 bytes de atributos de sprite que p01:6218 copia a
;   0xEC80
;   0x93e7..0x93f7  (16 bytes)
DATA_sprites_93e7:
	defb 027h,058h,000h,004h,037h,058h,004h,004h,01fh,098h,008h,004h,02fh,098h,00ch,004h	; 93e7  'X..7X....../...

; ----------------------------------------------------------------------
; DATOS sprites_93f7: 8 bytes de atributos de sprite que p01:62B1 copia a
;   0xEC98
;   0x93f7..0x93ff  (8 bytes)
DATA_sprites_93f7:
	defb 03fh,0a0h,020h,007h,0e0h,000h,000h,000h	; 93f7  ?. .....

; ----------------------------------------------------------------------
; DATOS sprites_93ff: 8 bytes de atributos de sprite que p01:62BD copia a
;   0xEC98
;   0x93ff..0x9407  (8 bytes)
DATA_sprites_93ff:
	defb 03fh,0a4h,024h,007h,047h,09ch,028h,007h	; 93ff  ?.$.G.(.

; ----------------------------------------------------------------------
; DATOS sprites_9407: 4 bytes de atributos de sprite que p01:62DF copia a
;   0xEC98
;   0x9407..0x940b  (4 bytes)
DATA_sprites_9407:
	defb 047h,060h,010h,007h	; 9407

; ----------------------------------------------------------------------
; DATOS dibujos_940B: los dibujos de unos caracteres desde el 0x5A, en rle
;   (0x5C46), que pide la ficha 0x9A96; lo leen p00:5781 (844 bytes)
;   0x940b..0x9757  (844 bytes)
DATA_dibujos_940B:
	defb 006h,000h,0a2h,001h,0ffh,000h,000h,001h,007h,01fh,07fh,0f8h,0e7h,0ffh,0feh,0e1h	; 940b  ................
	defb 0efh,074h,075h,075h,076h,09ch,07bh,0fah,03bh,0c7h,03fh,03fh,0ffh,01fh,0efh,097h	; 941b  .tuuv.{...??....
	defb 097h,0efh,09fh,07fh,0ffh,004h,000h,084h,007h,03fh,03fh,07fh,004h,000h,087h,07fh	; 942b  .........??.....
	defb 0feh,06ch,06ch,0fch,0f8h,0f0h,005h,0ffh,002h,000h,081h,00fh,005h,0ffh,002h,000h	; 943b  .ll.............
	defb 081h,0f0h,003h,0fch,002h,0feh,008h,0ffh,090h,039h,0deh,05fh,0dch,0e3h,0fch,0fch	; 944b  .........9._....
	defb 0ffh,0ffh,07fh,087h,0f7h,02eh,0aeh,0aeh,06eh,006h,000h,08ah,080h,0ffh,000h,000h	; 945b  ........n.......
	defb 080h,0e0h,0f8h,0feh,01fh,0e7h,004h,000h,09fh,0e0h,0fch,0fch,0feh,007h,003h,006h	; 946b  ................
	defb 007h,00dh,00ch,00ch,000h,066h,042h,087h,087h,08bh,0c9h,069h,000h,023h,021h,041h	; 947b  .....fB....i.#!A
	defb 043h,0c3h,087h,08fh,000h,0c1h,082h,086h,003h,00ch,08ch,087h,000h,0c2h,022h,004h	; 948b  C.............".
	defb 0e7h,064h,0c9h,069h,000h,067h,061h,003h,0c3h,002h,086h,0a9h,000h,0e6h,082h,006h	; 949b  .d.i.ga.........
	defb 007h,00bh,00bh,009h,000h,0c3h,041h,0c2h,0c4h,04fh,068h,068h,000h,0c3h,0c2h,0c2h	; 94ab  ......A..Ohh....
	defb 0c7h,0c5h,0cch,0ech,000h,0c3h,062h,062h,0c7h,086h,0ceh,0cfh,000h,0e0h,000h,000h	; 94bb  ......bb........
	defb 0c1h,001h,003h,0c7h,000h,003h,0d8h,002h,0b0h,082h,0f8h,0f0h,004h,000h,085h,03fh	; 94cb  ...............?
	defb 013h,031h,011h,079h,003h,000h,092h,0fch,0ffh,00eh,04ah,0dch,0ffh,0ffh,00ch,016h	; 94db  .1.y......J.....
	defb 037h,036h,034h,018h,000h,018h,020h,060h,0f8h,003h,060h,098h,000h,060h,0f1h,0ffh	; 94eb  764... `..`..`..
	defb 0feh,003h,007h,003h,07ah,0c7h,0bfh,0bfh,07fh,087h,086h,08eh,000h,0c0h,0e0h,0e0h	; 94fb  ....z...........
	defb 0f0h,0f0h,078h,078h,004h,03bh,084h,01dh,0e0h,0fdh,0ffh,003h,000h,092h,00fh,01eh	; 950b  ..xx............
	defb 01eh,026h,006h,05eh,0e3h,0fdh,0fdh,0feh,0dfh,0a8h,088h,03fh,003h,007h,007h,009h	; 951b  .&.^.......?....
	defb 003h,001h,002h,0feh,089h,018h,07ch,0feh,08eh,00fh,00fh,000h,0ffh,0fch,003h,000h	; 952b  ......|.........
	defb 085h,01fh,000h,0fch,0ffh,003h,003h,000h,0cbh,0f8h,000h,000h,006h,08fh,0ffh,0ffh	; 953b  ................
	defb 0c0h,080h,000h,0ffh,0ffh,080h,000h,000h,040h,080h,080h,000h,00eh,03eh,07ch,09ch	; 954b  ........@....>|.
	defb 03ch,03ch,038h,0c0h,003h,001h,01fh,0e0h,0dfh,0efh,000h,0b8h,070h,0e0h,0f0h,0c0h	; 955b  <<8.........p...
	defb 0fch,03fh,00fh,012h,036h,02ah,03ah,000h,018h,03ch,05ch,050h,092h,0ach,0ech,000h	; 956b  .?..6*:..<\P....
	defb 00fh,009h,011h,000h,000h,007h,001h,003h,003h,004h,000h,040h,0c0h,080h,0f0h,0e1h	; 957b  ...........@....
	defb 0e3h,0e7h,0e7h,003h,005h,002h,0a4h,005h,00eh,08eh,0d6h,0d6h,053h,073h,073h,031h	; 958b  ............Sss1
	defb 027h,014h,016h,022h,07eh,023h,023h,0a1h,073h,003h,01ah,00fh,00dh,008h,018h,0b8h	; 959b  '.."~##.s.......
	defb 07fh,008h,00bh,00dh,088h,008h,058h,090h,0bfh,03ch,03ch,003h,01eh,083h,0ffh,001h	; 95ab  ......X..<<.....
	defb 0ffh,003h,00eh,002h,00fh,083h,007h,0f8h,087h,008h,001h,08ah,007h,0f0h,0ffh,03fh	; 95bb  ...............?
	defb 007h,0fbh,0f7h,000h,0e7h,0e7h,004h,0efh,082h,010h,0eeh,006h,00eh,082h,0e1h,01eh	; 95cb  ................
	defb 005h,078h,09bh,070h,00fh,0f0h,007h,003h,003h,001h,001h,011h,021h,0e3h,087h,0c7h	; 95db  .x.p........!...
	defb 0c7h,0c3h,0e7h,0f7h,0e4h,000h,001h,001h,005h,00dh,0fdh,0fbh,008h,007h,004h,0eeh	; 95eb  ................
	defb 094h,0efh,0e7h,001h,0e0h,01ch,01ch,01dh,01dh,031h,0c0h,080h,000h,0f0h,0f1h,0e1h	; 95fb  .........1......
	defb 0e3h,0ffh,0ffh,07bh,063h,005h,000h,083h,001h,003h,00fh,004h,000h,084h,03fh,0ffh	; 960b  ...{c.........?.
	defb 0ffh,0c3h,006h,000h,082h,003h,00fh,004h,000h,084h,01fh,0ffh,0ffh,0c3h,004h,000h	; 961b  ................
	defb 090h,0e0h,0f8h,0fch,0feh,001h,000h,000h,001h,003h,007h,00fh,01fh,0e0h,0c0h,0c0h	; 962b  ................
	defb 080h,004h,000h,003h,007h,087h,00fh,01fh,07eh,0fch,0f8h,0afh,05fh,003h,0dfh,097h	; 963b  ........~..._...
	defb 0cfh,0e0h,0ffh,00fh,0fdh,0f9h,0f1h,0e0h,087h,01fh,0ffh,087h,088h,001h,00fh,001h	; 964b  ................
	defb 0feh,0f0h,0c0h,01fh,03eh,07ch,07ch,004h,0f8h,005h,000h,08eh,0f0h,0c0h,0f0h,0feh	; 965b  ....>||.........
	defb 07ch,03ch,038h,018h,010h,010h,000h,01fh,03eh,03ch,004h,07ch,085h,07eh,00fh,03eh	; 966b  |<8.....><.|.~.>
	defb 07eh,09eh,003h,03ch,099h,078h,07fh,01fh,00fh,007h,003h,001h,001h,000h,07fh,03fh	; 967b  ~..<.x.........?
	defb 03fh,01fh,00fh,00fh,007h,003h,080h,0c0h,0c0h,0e0h,0e0h,0f0h,0f8h,0dch,004h,007h	; 968b  ?...............
	defb 003h,003h,089h,007h,087h,0c9h,0c9h,0c1h,0e1h,0e1h,0c1h,0c3h,004h,0e0h,002h,0c0h	; 969b  ................
	defb 08eh,080h,0e0h,0ffh,07fh,03fh,01fh,00fh,00fh,007h,007h,000h,080h,0c0h,0c0h,004h	; 96ab  .....?..........
	defb 0e0h,002h,001h,0a6h,003h,007h,007h,002h,000h,000h,03fh,01fh,007h,068h,06fh,02fh	; 96bb  ..........?..ho/
	defb 020h,060h,000h,0c0h,0ffh,0ffh,000h,0ffh,000h,000h,0feh,0f8h,0e0h,00bh,0dbh,0dbh	; 96cb   `..............
	defb 01bh,003h,000h,000h,0c0h,0f8h,0ffh,0f8h,0c0h,000h,004h,0ffh,003h,000h,09bh,0ffh	; 96db  ................
	defb 03fh,007h,03fh,0ffh,000h,00dh,07fh,03fh,001h,0f0h,0ffh,0ffh,0d8h,000h,000h,0ffh	; 96eb  ?.?....?........
	defb 0ffh,07fh,00eh,01fh,07fh,01fh,003h,0f0h,0e0h,0f8h,005h,0ffh,003h,0f8h,002h,0fch	; 96fb  ................
	defb 084h,0feh,07eh,041h,07fh,006h,000h,08ah,001h,080h,000h,003h,01fh,03fh,07fh,0cfh	; 970b  ..~A.........?..
	defb 008h,00fh,005h,001h,083h,081h,082h,087h,004h,078h,002h,0f0h,097h,000h,0f0h,07fh	; 971b  .........x......
	defb 03fh,03fh,01fh,00fh,007h,002h,001h,000h,080h,0c0h,0e0h,0f0h,0f8h,004h,0feh,000h	; 972b  ??..............
	defb 03bh,01dh,006h,003h,004h,000h,089h,0ffh,0b2h,04dh,0bdh,0ceh,073h,01ch,007h,001h	; 973b  .........M..s...
	defb 006h,000h,082h,0ffh,0f0h,003h,000h,002h,0ffh,081h,000h,000h	; 974b  ............

; ----------------------------------------------------------------------
; DATOS colores_9757: los colores de unos caracteres desde el 0x5A, en rle
;   (0x5C46), que pide la ficha 0x9A96; lo leen p00:5781 (594 bytes)
;   0x9757..0x99a9  (594 bytes)
DATA_colores_9757:
	defb 038h,050h,018h,054h,02ch,040h,081h,050h,003h,040h,002h,050h,082h,070h,050h,004h	; 9757  8P.T,@.P.@.P.pP.
	defb 070h,002h,050h,082h,070h,050h,004h,070h,002h,050h,082h,070h,050h,004h,070h,002h	; 9767  p.P.pP.p.P.pP.p.
	defb 050h,082h,070h,050h,004h,070h,002h,050h,082h,070h,050h,004h,070h,002h,050h,082h	; 9777  P.pP.p.P.pP.p.P.
	defb 070h,050h,004h,070h,002h,050h,082h,070h,050h,004h,070h,002h,050h,082h,070h,050h	; 9787  pP.p.P.pP.p.P.pP
	defb 004h,070h,002h,050h,082h,070h,050h,004h,070h,002h,050h,082h,070h,050h,004h,070h	; 9797  .p.P.pP.p.P.pP.p
	defb 002h,050h,082h,070h,050h,004h,070h,002h,050h,082h,070h,050h,004h,070h,004h,050h	; 97a7  .P.pP.p.P.pP.p.P
	defb 084h,0f5h,0f4h,0f4h,0f0h,005h,050h,002h,0f4h,083h,0f0h,040h,040h,005h,0f5h,083h	; 97b7  ......P....@@...
	defb 075h,0f4h,0f4h,006h,0f5h,005h,050h,083h,0a0h,0a5h,0b0h,005h,050h,002h,0a5h,081h	; 97c7  u.....P.....P...
	defb 0b5h,004h,0a5h,084h,0b5h,0a5h,0b5h,0b5h,005h,050h,082h,0a5h,0a0h,005h,0a5h,084h	; 97d7  .........P......
	defb 0b5h,0a5h,0b5h,0b5h,005h,040h,002h,0a5h,082h,0b5h,050h,003h,0a0h,08ah,0b0h,0a0h	; 97e7  .....@....P.....
	defb 0b0h,0b0h,054h,054h,0a5h,0a5h,0b5h,0a4h,003h,0b4h,081h,0a4h,004h,0b4h,082h,054h	; 97f7  ..TT...........T
	defb 000h,006h,0a4h,082h,054h,000h,005h,040h,082h,0a0h,0a4h,003h,040h,081h,064h,009h	; 9807  ....T..@....@.d.
	defb 0a4h,089h,0b4h,0a4h,0b4h,0b4h,0a4h,0a4h,0bah,0bah,0b4h,006h,040h,085h,0a0h,0bah	; 9817  ............@...
	defb 0bah,0b0h,0b0h,003h,0f5h,081h,075h,003h,0a5h,081h,0b5h,003h,0f5h,081h,075h,003h	; 9827  ......u.......u.
	defb 0a5h,003h,0b5h,08ch,075h,0a5h,0b5h,0a5h,0b5h,0b5h,0f5h,0f5h,075h,0a5h,0b5h,0a5h	; 9837  ....u.......u...
	defb 003h,0b5h,084h,0f5h,065h,085h,095h,003h,0a5h,085h,0b5h,0f5h,065h,085h,095h,003h	; 9847  ....e.......e...
	defb 0a5h,085h,0b5h,0f5h,065h,085h,095h,003h,0a5h,085h,0b5h,0f5h,065h,085h,095h,003h	; 9857  ....e.......e...
	defb 0a5h,085h,0b5h,0f5h,065h,085h,095h,003h,0a5h,002h,0b5h,096h,0f5h,0b5h,0f5h,0f5h	; 9867  ....e...........
	defb 060h,060h,0b5h,0b5h,0f5h,0b5h,0f5h,0f5h,050h,065h,0b5h,0b5h,0f5h,0b5h,0f5h,0f5h	; 9877  ``......Pe......
	defb 065h,065h,004h,0a4h,081h,0b4h,003h,040h,002h,0b5h,09bh,0f5h,0b5h,0f5h,0f5h,050h	; 9887  ee.....@.......P
	defb 065h,0b5h,0b5h,0f5h,0b5h,0f5h,0f5h,050h,065h,0b4h,0b4h,0f4h,0b4h,0f4h,0f4h,040h	; 9897  e......Pe......@
	defb 064h,064h,084h,0a5h,095h,0a5h,003h,0a4h,084h,065h,085h,0a5h,095h,004h,0a4h,084h	; 98a7  dd.......e......
	defb 065h,085h,0a5h,094h,004h,0a4h,084h,065h,085h,0a5h,094h,004h,0a4h,084h,065h,085h	; 98b7  e......e......e.
	defb 0a5h,094h,004h,0a4h,088h,064h,084h,0a4h,094h,0a0h,0a0h,0a4h,0a4h,054h,0a0h,084h	; 98c7  .....d.......T..
	defb 0bah,0a0h,0b0h,0b0h,004h,0a0h,084h,0b0h,0a0h,0b0h,0b0h,006h,0a0h,002h,0bah,004h	; 98d7  ................
	defb 0a0h,083h,0b0h,0a0h,0b0h,005h,0a0h,084h,0b0h,0a0h,0b0h,0b0h,004h,0a0h,084h,0b0h	; 98e7  ................
	defb 0a0h,0b0h,0b0h,004h,0a0h,088h,0b0h,0a0h,0b0h,0b0h,060h,080h,0a0h,090h,004h,0a0h	; 98f7  ..........`.....
	defb 084h,060h,080h,0a0h,090h,004h,0a0h,084h,060h,080h,0a0h,090h,004h,0a0h,084h,060h	; 9907  .`......`......`
	defb 080h,0a0h,090h,004h,0a0h,084h,060h,080h,0a0h,090h,004h,0a0h,084h,060h,080h,0a0h	; 9917  ......`......`..
	defb 090h,005h,0a0h,083h,080h,0a0h,090h,004h,0a0h,003h,060h,081h,080h,004h,090h,003h	; 9927  ..........`.....
	defb 0b0h,085h,090h,060h,060h,080h,080h,004h,0bah,004h,060h,084h,0a0h,0b0h,0b0h,090h	; 9937  ...``.....`.....
	defb 004h,060h,00dh,0f0h,003h,0feh,081h,0a0h,003h,0fah,003h,0e0h,082h,0f0h,0bah,003h	; 9947  .`..............
	defb 0fah,081h,0e0h,003h,0feh,003h,0bah,087h,0feh,0f0h,0f0h,0feh,0feh,0b0h,0a0h,005h	; 9957  ................
	defb 0f0h,089h,0e0h,0b0h,0b0h,0f0h,0b0h,0f0h,0f0h,060h,060h,007h,0f0h,095h,060h,0b0h	; 9967  .........``...`.
	defb 0b0h,0f0h,0b0h,0f0h,0f0h,060h,060h,0b0h,0b0h,0f0h,0b0h,0f0h,0f0h,060h,060h,0b0h	; 9977  .....``......``.
	defb 0b0h,0f0h,0b0h,003h,0f0h,087h,060h,0b0h,0b0h,0f0h,0b0h,0f0h,0f0h,003h,060h,087h	; 9987  ......`.......`.
	defb 0b0h,0f0h,0b0h,0f0h,0f0h,060h,060h,00fh,040h,009h,050h,002h,0a4h,005h,054h,081h	; 9997  .....``.@.P...T.
	defb 050h,000h	; 99a7

; ----------------------------------------------------------------------
; DATOS rle_99A9: rle a la VRAM (0x5C46); lo leen p00:5791 (237 bytes)
;   0x99a9..0x9a96  (237 bytes)
DATA_rle_99A9:
	defb 002h,000h,083h,010h,018h,01ch,003h,00eh,082h,007h,004h,006h,000h,085h,0c0h,0fch	; 99a9  ................
	defb 0f8h,0f8h,0f6h,003h,0feh,003h,07eh,002h,0beh,083h,03eh,05ch,058h,010h,000h,09ch	; 99b9  ......~...>\X...
	defb 068h,026h,036h,036h,016h,01ah,03ah,01ch,000h,007h,002h,000h,000h,001h,000h,000h	; 99c9  h&66..:.........
	defb 0f8h,0f7h,0e9h,0e9h,0f7h,0f9h,0ffh,0ffh,0f0h,0c1h,081h,061h,003h,0c3h,081h,086h	; 99d9  ...........a....
	defb 005h,0dch,002h,0b8h,084h,0f0h,0a0h,080h,080h,004h,000h,081h,080h,003h,086h,085h	; 99e9  ................
	defb 085h,00dh,00dh,00bh,00bh,003h,017h,086h,00eh,02eh,01ch,05ch,018h,080h,005h,0c0h	; 99f9  ...........\....
	defb 002h,080h,008h,000h,088h,001h,003h,004h,008h,013h,03fh,046h,0ffh,008h,000h,088h	; 9a09  ..........?F....
	defb 0ffh,0bch,078h,0e8h,0c0h,000h,000h,0c0h,008h,000h,088h,004h,006h,002h,006h,006h	; 9a19  ..x.............
	defb 00ch,01fh,0ffh,008h,000h,087h,07ch,068h,028h,028h,078h,0f0h,0e0h,00ah,000h,084h	; 9a29  ......|h((x.....
	defb 003h,007h,00fh,0f0h,00bh,000h,083h,076h,09ch,0f0h,00fh,000h,081h,00bh,00eh,000h	; 9a39  .......v........
	defb 082h,02fh,0f8h,015h,000h,081h,001h,00bh,000h,003h,010h,083h,038h,0ffh,038h,003h	; 9a49  ./..........8.8.
	defb 010h,003h,000h,0a1h,001h,000h,041h,021h,011h,009h,005h,003h,0ffh,003h,005h,009h	; 9a59  ......A!........
	defb 011h,021h,041h,081h,000h,002h,004h,008h,010h,020h,040h,080h,0fdh,080h,040h,020h	; 9a69  .!A...... @...@
	defb 010h,008h,004h,000h,005h,007h,000h,092h,001h,002h,004h,008h,000h,020h,000h,000h	; 9a79  ............. ..
	defb 0ffh,003h,005h,009h,011h,021h,041h,081h,001h,001h,006h,000h,000h	; 9a89  .....!A......

; ----------------------------------------------------------------------
; DATOS caracteres_9A96: 1 fichas de caracteres (0x5AB3):
;   [tercios][dibujos][primer caracter][colores], 6 bytes cada una, y un 0 al
;   final; lo leen p00:5781 (7 bytes)
;   0x9a96..0x9a9d  (7 bytes)
DATA_caracteres_9A96:
	defb 007h,00bh,094h,05ah,057h,097h	; 9a96
	defb 000h	; 9a9c

; ----------------------------------------------------------------------
; DATOS copias_9A9D: 1 fichas de copia de caracteres (0x5A8D):
;   [desde][hasta][tercios][cuantos], 4 bytes cada una, y un 0 al final; los
;   copia dados la vuelta (0x5B08); lo leen p00:5788 (5 bytes)
;   0x9a9d..0x9aa2  (5 bytes)
DATA_copias_9A9D:
	defb 0c8h,0cch,039h,004h	; 9a9d
	defb 000h	; 9aa1

; ----------------------------------------------------------------------
; DATOS rle_tercios_9AA2: rle a la VRAM, el mismo en los tres tercios
;   (0x5BFC); lo leen p00:5E49, p00:5E75 (27 bytes)
;   0x9aa2..0x9abd  (27 bytes)
DATA_rle_tercios_9AA2:
	defb 08bh,03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,000h,00fh,01fh,004h,0ffh,089h,00fh	; 9aa2  .<B....B<.......
	defb 000h,000h,0feh,0e0h,0e0h,0c0h,0c0h,080h,018h,000h,000h	; 9ab2  ...........

; ----------------------------------------------------------------------
; DATOS rle_tercios_9ABD: rle a la VRAM, el mismo en los tres tercios
;   (0x5BFC); se solapan 2 bloques (0x9ABD-0x9AD3, 0x9ACC-0x9AD3); lo leen
;   p00:5E52, p00:5E84 (22 bytes)
;   0x9abd..0x9ad3  (22 bytes)
DATA_rle_tercios_9ABD:
	defb 084h,000h,030h,010h,020h,005h,000h,085h,054h,010h,07ch,010h,054h,002h,000h,004h	; 9abd  ..0. ...T.|.T...
	defb 000h,081h,07eh,003h,000h,000h	; 9acd

; ----------------------------------------------------------------------
; DATOS rle_tercios_9AD3: rle a la VRAM, el mismo en los tres tercios
;   (0x5BFC); lo leen p00:5E1A, p00:5E40 (81 bytes)
;   0x9ad3..0x9b24  (81 bytes)
DATA_rle_tercios_9AD3:
	defb 082h,038h,044h,003h,0c6h,085h,044h,038h,000h,018h,038h,004h,018h,0c2h,03ch,000h	; 9ad3  .8D...D8..8...<.
	defb 07ch,0c6h,006h,01ch,060h,0c6h,0feh,000h,07ch,086h,006h,01ch,006h,086h,07ch,000h	; 9ae3  |...`...|.....|.
	defb 00ch,01ch,02ch,04ch,0feh,00ch,01eh,000h,0feh,080h,0fch,086h,006h,086h,07ch,000h	; 9af3  ..,L..........|.
	defb 07ch,0c2h,0c0h,0fch,0c6h,0c6h,07ch,000h,0feh,086h,086h,00ch,018h,030h,030h,000h	; 9b03  |.....|......00.
	defb 07ch,0c6h,0c6h,07ch,0c6h,0c6h,07ch,000h,07ch,0c6h,0c6h,07eh,006h,086h,07ch,000h	; 9b13  |..|..|.|..~..|.
	defb 000h	; 9b23

; ----------------------------------------------------------------------
; DATOS rle_tercios_9B24: rle a la VRAM, el mismo en los tres tercios
;   (0x5BFC); lo leen p00:5E23, p00:5E5B (200 bytes)
;   0x9b24..0x9bec  (200 bytes)
DATA_rle_tercios_9B24:
	defb 002h,038h,097h,028h,06ch,07ch,044h,0eeh,000h,0fch,066h,066h,07ch,066h,066h,0fch	; 9b24  .8.(l|D...ff|ff.
	defb 000h,03ah,066h,0c0h,0c0h,0c2h,066h,03ch,000h,0fch,005h,066h,0a3h,0fch,000h,0feh	; 9b34  .:f...f<...f....
	defb 062h,068h,078h,068h,062h,0feh,000h,0feh,062h,068h,078h,068h,060h,0f0h,000h,03ah	; 9b44  bhxhb...bhxh`..:
	defb 066h,0c0h,0ceh,0c6h,066h,03ch,000h,0deh,04ch,04ch,07ch,04ch,04ch,0deh,000h,03ch	; 9b54  f...f<..LL|LL..<
	defb 005h,018h,083h,03ch,000h,01eh,003h,00ch,002h,08ch,08bh,078h,000h,0f6h,064h,068h	; 9b64  ...<.......x..dh
	defb 078h,06ch,066h,0f7h,000h,0f0h,004h,060h,094h,062h,0feh,000h,0c7h,06eh,07eh,056h	; 9b74  xlf....`.b...n~V
	defb 046h,046h,0efh,000h,0cfh,066h,076h,07eh,05eh,04eh,0e6h,000h,07ch,005h,0c6h,083h	; 9b84  FF...fv~^N..|...
	defb 07ch,000h,0fch,003h,066h,09eh,07ch,060h,0f0h,000h,038h,044h,0c6h,0c6h,0f6h,04ch	; 9b94  |...f.|`..8D...L
	defb 036h,000h,0fch,066h,066h,07ch,078h,06ch,0e6h,000h,07ah,0c6h,0c0h,07ch,006h,0c6h	; 9ba4  6..ff|xl..z..|..
	defb 0bch,000h,07eh,099h,004h,018h,083h,03ch,000h,0efh,005h,046h,09dh,03ch,000h,0efh	; 9bb4  ..~....<...F.<..
	defb 046h,046h,02ch,02ch,018h,018h,000h,0ceh,086h,0b6h,0b6h,056h,06ch,06ch,000h,0efh	; 9bc4  FF,,.......Vll..
	defb 046h,02ch,018h,034h,062h,0f7h,000h,0efh,046h,02ch,003h,018h,08ah,03ch,000h,0feh	; 9bd4  F,.4b...F,...<..
	defb 08eh,01ch,038h,070h,0e2h,0feh,000h,000h	; 9be4  ..8p....

; ----------------------------------------------------------------------
; DATOS rle_tercios_9BEC: rle a la VRAM, el mismo en los tres tercios
;   (0x5BFC); lo leen p00:5E9E (420 bytes)
;   0x9bec..0x9d90  (420 bytes)
DATA_rle_tercios_9BEC:
	defb 08ah,010h,0feh,020h,07ah,0a4h,09ah,072h,000h,000h,084h,004h,082h,085h,040h,000h	; 9bec  ... z..r......@.
	defb 03ch,000h,07ch,003h,002h,094h,03ch,000h,07eh,000h,0fch,002h,00ch,030h,0ceh,000h	; 9bfc  <.|...<.~....0..
	defb 011h,0feh,010h,07ch,092h,092h,064h,000h,024h,0fah,003h,024h,095h,044h,088h,000h	; 9c0c  ...|..d.$..$.D..
	defb 020h,0fch,010h,07eh,008h,080h,07ch,000h,004h,018h,060h,080h,060h,018h,004h,000h	; 9c1c   ..~..|...`.`...
	defb 084h,09eh,004h,084h,084h,048h,000h,07ch,002h,003h,000h,08bh,040h,03eh,000h,020h	; 9c2c  .....H.|....@>.
	defb 0feh,010h,008h,084h,080h,07ch,000h,005h,080h,0adh,042h,03ch,000h,008h,0feh,038h	; 9c3c  .....|....B<...8
	defb 048h,048h,038h,0f0h,000h,044h,0feh,044h,044h,040h,040h,03eh,000h,042h,024h,0feh	; 9c4c  HH8..D.DD@@>.B$.
	defb 020h,040h,040h,03eh,000h,040h,0e0h,05eh,040h,040h,050h,08eh,000h,010h,0feh,020h	; 9c5c   @@>.@.^@@P....
	defb 07ch,082h,002h,07ch,000h,000h,0fch,003h,002h,09dh,004h,078h,000h,000h,0feh,018h	; 9c6c  |..|.......x....
	defb 020h,040h,040h,03ch,000h,080h,04eh,030h,060h,080h,080h,07eh,000h,04ch,0e2h,044h	; 9c7c   @@<..N0`..~.L.D
	defb 044h,09ch,026h,018h,000h,09eh,0a0h,003h,080h,094h,0a0h,05eh,000h,048h,07ch,04ah	; 9c8c  D.&........^.H|J
	defb 0d2h,0a6h,0bah,06ch,000h,040h,0ech,052h,062h,0ceh,052h,04ch,000h,07ch,005h,092h	; 9c9c  ...l.@.Rb.RL.|..
	defb 08dh,064h,000h,084h,09eh,084h,084h,09ch,0a6h,058h,000h,068h,0a4h,046h,003h,084h	; 9cac  .d.......X.h.F..
	defb 0cch,078h,000h,070h,008h,020h,092h,08ah,08ah,0b2h,000h,020h,050h,088h,088h,004h	; 9cbc  .x.p. ..... P...
	defb 004h,002h,000h,0beh,084h,0beh,084h,09ch,0a6h,058h,000h,008h,0feh,008h,0feh,008h	; 9ccc  .........X......
	defb 07ch,08ah,070h,0f0h,014h,014h,07eh,094h,094h,064h,000h,026h,0f0h,020h,062h,0a2h	; 9cdc  |.p...~..d.&. b.
	defb 0a2h,05ch,000h,048h,07ch,04ah,0d2h,0a2h,0b2h,064h,000h,040h,0f8h,040h,0f8h,040h	; 9cec  .\.H|J...d.@.@.@
	defb 042h,03ch,000h,048h,0fch,04ah,052h,044h,040h,040h,000h,088h,0bch,003h,0cah,0c3h	; 9cfc  B<.H.JRD@@......
	defb 0bch,090h,000h,008h,00eh,008h,078h,08ch,08ah,070h,000h,03ch,082h,080h,0fch,082h	; 9d0c  ......x..p.<....
	defb 002h,07ch,000h,042h,082h,082h,042h,002h,00ch,070h,000h,0feh,018h,020h,07ch,09ah	; 9d1c  .|.B..B..p... |.
	defb 026h,01ch,000h,040h,0ech,054h,064h,0c4h,044h,042h,000h,0feh,018h,020h,07ch,082h	; 9d2c  &..@.Td.DB... |.
	defb 002h,07ch,000h,040h,0e0h,05ch,062h,0c2h,042h,044h,000h,010h,0feh,020h,07ah,08ch	; 9d3c  .|.@.\b.BD... z.
	defb 080h,07eh,000h,003h,040h,084h,072h,092h,092h,08ch,003h,000h,084h,078h,004h,004h	; 9d4c  .~..@.r......x..
	defb 038h,004h,000h,084h,048h,044h,044h,020h,003h,000h,085h,048h,07ch,04ah,04ah,05ch	; 9d5c  8...HDD ...H|JJ\
	defb 003h,000h,08bh,008h,00ch,038h,04ch,038h,000h,000h,020h,090h,050h,040h,004h,000h	; 9d6c  .....8L8.. .P@..
	defb 084h,060h,090h,090h,060h,008h,000h,083h,040h,020h,020h,004h,000h,085h,030h,048h	; 9d7c  .`..`...@  ...0H
	defb 048h,030h,000h,000h	; 9d8c

; ----------------------------------------------------------------------
; DATOS tamanos_de_mosaico: 61 parejas [ancho][alto] en caracteres, una por
;   mosaico (p01:6EAB, (ix+0x0A)); lo leen p01:6EAF (122 bytes)
;   0x9d90..0x9e0a  (122 bytes)
DATA_tamanos_de_mosaico:
	defb 002h,002h	; 9d90
	defb 002h,002h	; 9d92
	defb 002h,002h	; 9d94
	defb 002h,002h	; 9d96
	defb 002h,003h	; 9d98
	defb 002h,003h	; 9d9a
	defb 010h,003h	; 9d9c
	defb 010h,003h	; 9d9e
	defb 010h,003h	; 9da0
	defb 010h,003h	; 9da2
	defb 010h,003h	; 9da4
	defb 010h,003h	; 9da6
	defb 00ah,006h	; 9da8
	defb 00ah,006h	; 9daa
	defb 00ah,007h	; 9dac
	defb 00ah,006h	; 9dae
	defb 006h,006h	; 9db0
	defb 006h,006h	; 9db2
	defb 006h,006h	; 9db4
	defb 006h,006h	; 9db6
	defb 006h,00ch	; 9db8
	defb 006h,00ch	; 9dba
	defb 006h,00ch	; 9dbc
	defb 002h,002h	; 9dbe
	defb 008h,008h	; 9dc0
	defb 008h,008h	; 9dc2
	defb 008h,008h	; 9dc4
	defb 008h,008h	; 9dc6
	defb 00ah,004h	; 9dc8
	defb 00ah,004h	; 9dca
	defb 002h,004h	; 9dcc
	defb 002h,004h	; 9dce
	defb 002h,004h	; 9dd0
	defb 002h,004h	; 9dd2
	defb 002h,001h	; 9dd4
	defb 002h,001h	; 9dd6
	defb 006h,003h	; 9dd8
	defb 006h,003h	; 9dda
	defb 006h,003h	; 9ddc
	defb 006h,003h	; 9dde
	defb 006h,003h	; 9de0
	defb 006h,003h	; 9de2
	defb 004h,004h	; 9de4
	defb 00ah,005h	; 9de6
	defb 00ah,005h	; 9de8
	defb 00ah,005h	; 9dea
	defb 00ah,005h	; 9dec
	defb 00ah,005h	; 9dee
	defb 00ah,005h	; 9df0
	defb 00ah,005h	; 9df2
	defb 00ah,005h	; 9df4
	defb 00ah,005h	; 9df6
	defb 00fh,009h	; 9df8
	defb 00fh,009h	; 9dfa
	defb 00fh,009h	; 9dfc
	defb 007h,007h	; 9dfe
	defb 007h,007h	; 9e00
	defb 002h,002h	; 9e02
	defb 00ah,005h	; 9e04
	defb 00ah,005h	; 9e06
	defb 00ah,005h	; 9e08

; ----------------------------------------------------------------------
; DATOS tabla_de_mosaicos: 61 punteros a los mosaicos (p01:6D61 y otros,
;   (ix+0x0A)); los 20, 21 y 22 (6 x 12) apuntan donde el 23 (2 x 2); lo leen
;   p01:6D64 (122 bytes)
;   0x9e0a..0x9e84  (122 bytes)
DATA_tabla_de_mosaicos:
	defb 084h,09eh	; 9e0a
	defb 088h,09eh	; 9e0c
	defb 08ch,09eh	; 9e0e
	defb 090h,09eh	; 9e10
	defb 094h,09eh	; 9e12
	defb 09ah,09eh	; 9e14
	defb 0a0h,09eh	; 9e16
	defb 0d0h,09eh	; 9e18
	defb 000h,09fh	; 9e1a
	defb 030h,09fh	; 9e1c
	defb 060h,09fh	; 9e1e
	defb 090h,09fh	; 9e20
	defb 0c0h,09fh	; 9e22
	defb 0fch,09fh	; 9e24
	defb 038h,0a0h	; 9e26
	defb 07eh,0a0h	; 9e28
	defb 0bah,0a0h	; 9e2a
	defb 0deh,0a0h	; 9e2c
	defb 002h,0a1h	; 9e2e
	defb 026h,0a1h	; 9e30
	defb 04ah,0a1h	; 9e32
	defb 04ah,0a1h	; 9e34
	defb 04ah,0a1h	; 9e36
	defb 04ah,0a1h	; 9e38
	defb 04eh,0a1h	; 9e3a
	defb 08eh,0a1h	; 9e3c
	defb 0ceh,0a1h	; 9e3e
	defb 00eh,0a2h	; 9e40
	defb 04eh,0a2h	; 9e42
	defb 076h,0a2h	; 9e44
	defb 09eh,0a2h	; 9e46
	defb 0a6h,0a2h	; 9e48
	defb 0aeh,0a2h	; 9e4a
	defb 0b6h,0a2h	; 9e4c
	defb 0beh,0a2h	; 9e4e
	defb 0c0h,0a2h	; 9e50
	defb 0c2h,0a2h	; 9e52
	defb 0d4h,0a2h	; 9e54
	defb 0e6h,0a2h	; 9e56
	defb 0f8h,0a2h	; 9e58
	defb 00ah,0a3h	; 9e5a
	defb 01ch,0a3h	; 9e5c
	defb 02eh,0a3h	; 9e5e
	defb 03eh,0a3h	; 9e60
	defb 070h,0a3h	; 9e62
	defb 0a2h,0a3h	; 9e64
	defb 0d4h,0a3h	; 9e66
	defb 006h,0a4h	; 9e68
	defb 038h,0a4h	; 9e6a
	defb 06ah,0a4h	; 9e6c
	defb 06ah,0a4h	; 9e6e
	defb 06ah,0a4h	; 9e70
	defb 06ah,0a4h	; 9e72
	defb 0f1h,0a4h	; 9e74
	defb 078h,0a5h	; 9e76
	defb 0ffh,0a5h	; 9e78
	defb 030h,0a6h	; 9e7a
	defb 061h,0a6h	; 9e7c
	defb 065h,0a6h	; 9e7e
	defb 097h,0a6h	; 9e80
	defb 0c9h,0a6h	; 9e82

; ----------------------------------------------------------------------
; DATOS mosaico_00: el mosaico 0: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0x9e84..0x9e88  (4 bytes)
DATA_mosaico_00:
	defb 0f8h,0f7h	; 9e84
	defb 0f9h,0fbh	; 9e86

; ----------------------------------------------------------------------
; DATOS mosaico_01: el mosaico 1: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0x9e88..0x9e8c  (4 bytes)
DATA_mosaico_01:
	defb 0fch,0f7h	; 9e88
	defb 0f9h,0fah	; 9e8a

; ----------------------------------------------------------------------
; DATOS mosaico_02: el mosaico 2: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0x9e8c..0x9e90  (4 bytes)
DATA_mosaico_02:
	defb 0f1h,0f2h	; 9e8c
	defb 0f5h,0f3h	; 9e8e

; ----------------------------------------------------------------------
; DATOS mosaico_03: el mosaico 3: 2 x 2 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0x9e90..0x9e94  (4 bytes)
DATA_mosaico_03:
	defb 0f1h,0f6h	; 9e90
	defb 0f4h,0f3h	; 9e92

; ----------------------------------------------------------------------
; DATOS mosaico_04: el mosaico 4: 2 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (6 bytes)
;   0x9e94..0x9e9a  (6 bytes)
DATA_mosaico_04:
	defb 0fah,0f7h	; 9e94
	defb 0fbh,0f8h	; 9e96
	defb 0fch,0f9h	; 9e98

; ----------------------------------------------------------------------
; DATOS mosaico_05: el mosaico 5: 2 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (6 bytes)
;   0x9e9a..0x9ea0  (6 bytes)
DATA_mosaico_05:
	defb 0f1h,0f4h	; 9e9a
	defb 0f2h,0f5h	; 9e9c
	defb 0f3h,0f6h	; 9e9e

; ----------------------------------------------------------------------
; DATOS mosaico_06: el mosaico 6: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9ea0..0x9ed0  (48 bytes)
DATA_mosaico_06:
	defb 000h,08dh,0bfh,08eh,08fh,079h,07ch,05eh,092h,094h,068h,06eh,06fh,072h,070h,06ch	; 9ea0  .....y|^..hnorpl
	defb 060h,08ch,089h,078h,090h,071h,091h,073h,093h,095h,06dh,05ch,098h,063h,06bh,065h	; 9eb0  `..x.q.s..m\.cke
	defb 076h,077h,000h,000h,074h,07ah,07bh,07dh,083h,096h,087h,07eh,07fh,08bh,064h,085h	; 9ec0  vw..tz{}...~..d.

; ----------------------------------------------------------------------
; DATOS mosaico_07: el mosaico 7: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9ed0..0x9f00  (48 bytes)
DATA_mosaico_07:
	defb 000h,000h,000h,000h,000h,000h,05dh,05eh,092h,094h,068h,06eh,06fh,072h,070h,06ch	; 9ed0  ......]^..hnorpl
	defb 000h,08dh,0bfh,08eh,097h,099h,0bah,073h,093h,0bdh,069h,05ah,098h,066h,06ah,067h	; 9ee0  .......s..iZ.fjg
	defb 060h,08ch,089h,078h,0bbh,0bch,081h,07dh,080h,08ah,062h,086h,084h,0beh,088h,082h	; 9ef0  `..x...}..b.....

; ----------------------------------------------------------------------
; DATOS mosaico_08: el mosaico 8: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9f00..0x9f30  (48 bytes)
DATA_mosaico_08:
	defb 06ch,070h,072h,06fh,06eh,068h,094h,092h,05eh,07ch,079h,08fh,08eh,0bfh,08dh,000h	; 9f00  lpronh..^|y.....
	defb 065h,06bh,063h,098h,05ch,06dh,095h,093h,073h,091h,071h,090h,078h,089h,08ch,060h	; 9f10  ekc.\m..s.q.x..`
	defb 085h,064h,08bh,07fh,07eh,087h,096h,083h,07dh,07bh,07ah,074h,000h,000h,077h,076h	; 9f20  .d..~...}{zt..wv

; ----------------------------------------------------------------------
; DATOS mosaico_09: el mosaico 9: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9f30..0x9f60  (48 bytes)
DATA_mosaico_09:
	defb 06ch,070h,072h,06fh,06eh,068h,094h,092h,05eh,05dh,000h,000h,000h,000h,000h,000h	; 9f30  lpronh..^]......
	defb 067h,06ah,066h,098h,05ah,069h,0bdh,093h,073h,0bah,099h,097h,08eh,0bfh,08dh,000h	; 9f40  gjf.Zi..s.......
	defb 082h,088h,0beh,084h,086h,062h,08ah,080h,07dh,081h,0bch,0bbh,078h,089h,08ch,060h	; 9f50  .....b..}...x..`

; ----------------------------------------------------------------------
; DATOS mosaico_10: el mosaico 10: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9f60..0x9f90  (48 bytes)
DATA_mosaico_10:
	defb 000h,08dh,0bfh,08eh,08fh,079h,07ch,05eh,092h,094h,068h,06eh,06fh,072h,070h,06ch	; 9f60  .....y|^..hnorpl
	defb 061h,05fh,089h,078h,090h,071h,091h,073h,093h,095h,06dh,05ch,098h,063h,06bh,065h	; 9f70  a_.x.q.s..m\.cke
	defb 000h,05bh,075h,000h,074h,07ah,07bh,07dh,083h,096h,087h,07eh,07fh,08bh,064h,085h	; 9f80  .[u.tz{}...~..d.

; ----------------------------------------------------------------------
; DATOS mosaico_11: el mosaico 11: 16 x 3 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (48 bytes)
;   0x9f90..0x9fc0  (48 bytes)
DATA_mosaico_11:
	defb 06ch,070h,072h,06fh,06eh,068h,094h,092h,05eh,07ch,079h,08fh,08eh,0bfh,08dh,000h	; 9f90  lpronh..^|y.....
	defb 065h,06bh,063h,098h,05ch,06dh,095h,093h,073h,091h,071h,090h,078h,089h,05fh,061h	; 9fa0  ekc.\m..s.q.x._a
	defb 085h,064h,08bh,07fh,07eh,087h,096h,083h,07dh,07bh,07ah,074h,000h,075h,05bh,000h	; 9fb0  .d..~...}{zt.u[.

; ----------------------------------------------------------------------
; DATOS mosaico_12: el mosaico 12: 10 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (60 bytes)
;   0x9fc0..0x9ffc  (60 bytes)
DATA_mosaico_12:
	defb 088h,089h,08ah,062h,05bh,068h,067h,061h,000h,000h	; 9fc0  ...b[hga..
	defb 000h,08bh,08ch,0cah,0cbh,099h,08dh,000h,000h,0c6h	; 9fca  ..........
	defb 05dh,092h,05eh,07dh,063h,0c7h,0c1h,06ch,000h,0beh	; 9fd4  ].^}c..l..
	defb 05fh,05ah,093h,0cch,0cdh,07fh,080h,0c4h,000h,0bdh	; 9fde  _Z........
	defb 094h,0bfh,0c9h,0cfh,081h,0d0h,072h,066h,0d1h,087h	; 9fe8  ......rf..
	defb 000h,064h,065h,0ceh,082h,083h,073h,096h,091h,000h	; 9ff2  .de...s...

; ----------------------------------------------------------------------
; DATOS mosaico_13: el mosaico 13: 10 x 6 caracteres por filas (p01:6D87; el 0
;   no se pinta); lo leen p01:6D87 (4 bytes)
;   0x9ffc..0xa000  (4 bytes)
DATA_mosaico_13:
	defb 000h,000h,000h,000h	; 9ffc
