# La música

Todo lo que suena aquí sale de ejecutar el motor de sonido del cartucho (`sonido_cada_cuadro`, p13:6004, y `sonido`, p00:4E6B, que reparte las partituras; la interrupción lo llama en p00:410A con los bancos 13 y 14) en un Z80 emulado, cuadro a cuadro y a 60 por segundo, igual que lo llama el juego. Lo que el motor escribe en el PSG pasa a sonido con un AY-3-8910 (`tools/musica.py`). Cada MP3 es la pieza entera hasta donde vuelve a empezar, más 8 segundos de la vuelta apagándose; las que no se repiten acaban donde acaba el motor.

## Cotejado con openMSX

Las escrituras al PSG se han comparado cuadro a cuadro con las de openMSX (C-BIOS MSX1 japonés). En todos los cuadros el PSG queda igual:

- la música 0x8A, sus primeros 205 cuadros;
- la música 0x8F, sus primeros 205 cuadros.

El timbre no está cotejado: es el de un AY-3-8910 de manual, no una grabación del emulador. Las sondas están en `tools/omsx_psg.tcl` y `tools/coteja_psg.py`.

## Cómo se pide una pieza

`pide_sonido` (p00:4E1F) y `pide_sonido_ya` (p00:4E34, sin mirar la pausa) guardan los bancos de 0x6000 y 0x8000, ponen el 13 y el 14 y llaman a `sonido` con el número en A: 0 lo calla todo, del 0x01 al 0x7F es un efecto, del 0x80 al 0xF9 una música (tabla de 0x743E) y del 0xFA en adelante, órdenes (pausa, sigue). Antes se corre `sonido_a_cero`, que deja la copia del mezclador del PSG en 0xBC. La RAM del sonido está en 0xE100-0xE1CD. Las que suenan igual que otra se publican una vez, y las que duran más de 75 segundos sin volver a empezar se cortan a los 75.

## Las músicas

**La música del mapa de los mundos** (0x8A)

Lo pide `L_45E8` y `L_484F`; la rutina `musica_del_mapa` pide la 0x88 en el castillo y la 0x8A en los mundos; dura 32,4 s y vuelve a empezar en el segundo 0,4.

<audio controls preload="none" src="../audio/musica_8A.mp3?v=e832fa57"></audio>

**La música del mapa del castillo** (0x88)

Lo pide `L_46EC` y `L_4835`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_88.mp3?v=a8bb8709"></audio>

**La pieza del 0x4416** (0x87)

Lo pide `L_4416`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_87.mp3?v=10be02c7"></audio>

**La pieza del 0x4363** (0x86)

Lo pide `L_4363`; dura 22,9 s y vuelve a empezar en el segundo 11,7.

<audio controls preload="none" src="../audio/musica_86.mp3?v=b83515a0"></audio>

**La música de la sala** (0x8F)

Lo pide `musica_de_la_sala`; dura 38,4 s y vuelve a empezar en el segundo 12,8.

<audio controls preload="none" src="../audio/musica_8F.mp3?v=9661349e"></audio>

**El jefe** (0x90)

Lo pide `musica_del_jefe`; dura 23,1 s y vuelve a empezar en el segundo 3,9.

<audio controls preload="none" src="../audio/musica_90.mp3?v=0e62b396"></audio>

**La pieza del 0x486E** (0x8C)

Lo pide `L_486E`; dura 8,5 s y vuelve a empezar en el segundo 2,6.

<audio controls preload="none" src="../audio/musica_8C.mp3?v=56c5550a"></audio>

**La sala especial** (0x8D)

Lo pide `L_48B7` y `graficos_de_la_sala_especial`; dura 22,7 s y vuelve a empezar en el segundo 3,5.

<audio controls preload="none" src="../audio/musica_8D.mp3?v=9a4b08da"></audio>

**El jefe vencido** (0x91)

Lo pide `musica_del_jefe` y `L_5CEF`; dura 3,2 s y vuelve a empezar en el segundo 1,6.

<audio controls preload="none" src="../audio/musica_91.mp3?v=13494a7b"></audio>

**La pieza del 0x49F9** (0x92)

Lo pide `L_49F9`; dura 12,4 s.

<audio controls preload="none" src="../audio/musica_92.mp3?v=37fe28a7"></audio>

**La pieza del 0x4A35** (0x93)

Lo pide `L_4A35`; se corta a los 75 s (la pieza sigue).

<audio controls preload="none" src="../audio/musica_93.mp3?v=c702ef88"></audio>

**La pieza del 0x4547** (0x95)

Lo pide `L_4547`; dura 7,1 s.

<audio controls preload="none" src="../audio/musica_95.mp3?v=135f28a9"></audio>

**Una pista de la tabla** (0x8B)

Lo pide ninguna llamada directa: sale de la tabla de música por un número calculado; dura 38,9 s y vuelve a empezar en el segundo 6,9.

<audio controls preload="none" src="../audio/musica_8B.mp3?v=bc7206be"></audio>

**La pieza del 0x4599** (0x8E)

Lo pide `L_4599`; dura 1,6 s.

<audio controls preload="none" src="../audio/musica_8E.mp3?v=8a5e5d33"></audio>

**La pieza del 0x499B** (0x81)

Lo pide `L_499B`; dura 3,3 s.

<audio controls preload="none" src="../audio/musica_81.mp3?v=55e8f07d"></audio>

**La pieza de `jefe_vencido`** (0x84)

Lo pide `jefe_vencido`; dura 2,6 s.

<audio controls preload="none" src="../audio/musica_84.mp3?v=4cd39f8e"></audio>
