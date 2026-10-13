# The music

Everything you hear here comes from running the cartridge's own sound engine (`sonido_cada_cuadro`, p13:6004, and `sonido`, p00:4E6B, which shares out the scores; the interrupt calls it at p00:410A with banks 13 and 14) on an emulated Z80, frame by frame at 60 per second, just as the game calls it. What the engine writes to the PSG is turned into sound with an AY-3-8910 (`tools/musica.py`). Each MP3 is the whole piece up to where it starts again, plus 8 seconds of the repeat fading out; those that do not repeat end where the engine ends.

## Checked against openMSX

The PSG writes have been compared frame by frame with those of openMSX (C-BIOS MSX1 japonés). In every frame the PSG ends up the same:

- tune 0x8A, its first 205 frames;
- tune 0x8F, its first 205 frames.

The timbre is not checked: it is a textbook AY-3-8910, not a recording of the emulator. The probes are `tools/omsx_psg.tcl` and `tools/coteja_psg.py`.

## How a piece is asked for

`pide_sonido` (p00:4E1F) and `pide_sonido_ya` (p00:4E34, without looking at the pause) save the banks at 0x6000 and 0x8000, map 13 and 14 and call `sonido` with the number in A: 0 silences everything, 0x01 to 0x7F is an effect, 0x80 to 0xF9 a tune (table at 0x743E) and from 0xFA up, orders (pause, resume). Before that, `sonido_a_cero` runs, leaving the copy of the PSG mixer at 0xBC. The sound RAM is at 0xE100-0xE1CD. Those that sound like another are published once, and those that last over 75 seconds without starting again are cut at 75.

## The tunes

**The worlds' map tune** (0x8A)

Asked for by `L_45E8` y `L_484F`; la rutina `musica_del_mapa` pide la 0x88 en el castillo y la 0x8A en los mundos; lasts 32.4 s and starts again at second 0.4.

<audio controls preload="none" src="audio/musica_8A.mp3?v=e832fa57"></audio>

**The castle's map tune** (0x88)

Asked for by `L_46EC` y `L_4835`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_88.mp3?v=a8bb8709"></audio>

**The tune at 0x4416** (0x87)

Asked for by `L_4416`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_87.mp3?v=10be02c7"></audio>

**The tune at 0x4363** (0x86)

Asked for by `L_4363`; lasts 22.9 s and starts again at second 11.7.

<audio controls preload="none" src="audio/musica_86.mp3?v=b83515a0"></audio>

**The room tune** (0x8F)

Asked for by `musica_de_la_sala`; lasts 38.4 s and starts again at second 12.8.

<audio controls preload="none" src="audio/musica_8F.mp3?v=9661349e"></audio>

**The boss** (0x90)

Asked for by `musica_del_jefe`; lasts 23.1 s and starts again at second 3.9.

<audio controls preload="none" src="audio/musica_90.mp3?v=0e62b396"></audio>

**The tune at 0x486E** (0x8C)

Asked for by `L_486E`; lasts 8.5 s and starts again at second 2.6.

<audio controls preload="none" src="audio/musica_8C.mp3?v=56c5550a"></audio>

**The special room** (0x8D)

Asked for by `L_48B7` y `graficos_de_la_sala_especial`; lasts 22.7 s and starts again at second 3.5.

<audio controls preload="none" src="audio/musica_8D.mp3?v=9a4b08da"></audio>

**The boss defeated** (0x91)

Asked for by `musica_del_jefe` y `L_5CEF`; lasts 3.2 s and starts again at second 1.6.

<audio controls preload="none" src="audio/musica_91.mp3?v=13494a7b"></audio>

**The tune at 0x49F9** (0x92)

Asked for by `L_49F9`; lasts 12.4 s.

<audio controls preload="none" src="audio/musica_92.mp3?v=37fe28a7"></audio>

**The tune at 0x4A35** (0x93)

Asked for by `L_4A35`; is cut at 75 s (the piece goes on).

<audio controls preload="none" src="audio/musica_93.mp3?v=c702ef88"></audio>

**The tune at 0x4547** (0x95)

Asked for by `L_4547`; lasts 7.1 s.

<audio controls preload="none" src="audio/musica_95.mp3?v=135f28a9"></audio>

**A track in the table** (0x8B)

Asked for by ninguna llamada directa: sale de la tabla de música por un número calculado; lasts 38.9 s and starts again at second 6.9.

<audio controls preload="none" src="audio/musica_8B.mp3?v=bc7206be"></audio>

**The tune at 0x4599** (0x8E)

Asked for by `L_4599`; lasts 1.6 s.

<audio controls preload="none" src="audio/musica_8E.mp3?v=8a5e5d33"></audio>

**The tune at 0x499B** (0x81)

Asked for by `L_499B`; lasts 3.3 s.

<audio controls preload="none" src="audio/musica_81.mp3?v=55e8f07d"></audio>

**The `jefe_vencido` tune** (0x84)

Asked for by `jefe_vencido`; lasts 2.6 s.

<audio controls preload="none" src="audio/musica_84.mp3?v=4cd39f8e"></audio>
