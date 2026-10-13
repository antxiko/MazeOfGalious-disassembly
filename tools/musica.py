#!/usr/bin/env python3
"""La musica del cartucho, ejecutando su motor de sonido (ver motor_musica.py).

Primero `sonido_a_cero` (p00:4DED), que deja la mezcla del PSG en 0xBC; luego
`sonido` (p00:4E6B, A = numero, con los bancos 13 y 14 en 0x6000 y 0x8000: 0
calla, 0x01-0x7F efecto, 0x80-0xF9 musica de la tabla de 0x743E) y, cada
cuadro, `sonido_cada_cuadro` (p13:6004), como hace la interrupcion
(p00:410A). La RAM del sonido es 0xE100-0xE1CD. MegaROM Konami4 de 128 KB,
sin SCC.
Uso:  musica.py registros 0x8A [cuadros] | mp3 0x8A f.mp3 | todas docs/audio
      musica.py barrido 0x80 0xA0 | emu | python tools/unicas.py 0x80 0xA0
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica  # noqa: E402
from motor_musica import P  # noqa: E402

PIEZAS = [
    P(0x8A, "La música del mapa de los mundos", "The worlds' map tune",
      "`L_45E8` y `L_484F`; la rutina `musica_del_mapa` pide la 0x88 en el "
      "castillo y la 0x8A en los mundos"),
    P(0x88, "La música del mapa del castillo", "The castle's map tune",
      "`L_46EC` y `L_4835`"),
    P(0x87, "La pieza del 0x4416", "The tune at 0x4416", "`L_4416`"),
    P(0x86, "La pieza del 0x4363", "The tune at 0x4363", "`L_4363`"),
    P(0x8F, "La música de la sala", "The room tune", "`musica_de_la_sala`"),
    P(0x90, "El jefe", "The boss", "`musica_del_jefe`"),
    P(0x8C, "La pieza del 0x486E", "The tune at 0x486E", "`L_486E`"),
    P(0x8D, "La sala especial", "The special room",
      "`L_48B7` y `graficos_de_la_sala_especial`"),
    P(0x91, "El jefe vencido", "The boss defeated",
      "`musica_del_jefe` y `L_5CEF`"),
    P(0x92, "La pieza del 0x49F9", "The tune at 0x49F9", "`L_49F9`"),
    P(0x93, "La pieza del 0x4A35", "The tune at 0x4A35", "`L_4A35`"),
    P(0x95, "La pieza del 0x4547", "The tune at 0x4547", "`L_4547`"),
    P(0x8B, "Una pista de la tabla", "A track in the table",
      "ninguna llamada directa: sale de la tabla de música por un número "
      "calculado"),
    P(0x8E, "La pieza del 0x4599", "The tune at 0x4599", "`L_4599`"),
    P(0x81, "La pieza del 0x499B", "The tune at 0x499B", "`L_499B`"),
    P(0x84, "La pieza de `jefe_vencido`", "The `jefe_vencido` tune",
      "`jefe_vencido`"),
]

PAGINA = motor_musica.pagina_basica(
    "`sonido_cada_cuadro`, p13:6004, y `sonido`, p00:4E6B, que reparte las "
    "partituras; la interrupción lo llama en p00:410A con los bancos 13 y 14",
    "`sonido_cada_cuadro`, p13:6004, and `sonido`, p00:4E6B, which shares out "
    "the scores; the interrupt calls it at p00:410A with banks 13 and 14",
    "C-BIOS MSX1 japonés",
    [("la música 0x8A, sus primeros 205 cuadros",
      "tune 0x8A, its first 205 frames"),
     ("la música 0x8F, sus primeros 205 cuadros",
      "tune 0x8F, its first 205 frames")],
    [("Cómo se pide una pieza",
      "`pide_sonido` (p00:4E1F) y `pide_sonido_ya` (p00:4E34, sin mirar la "
      "pausa) guardan los bancos de 0x6000 y 0x8000, ponen el 13 y el 14 y "
      "llaman a `sonido` con el número en A: 0 lo calla todo, del 0x01 al "
      "0x7F es un efecto, del 0x80 al 0xF9 una música (tabla de 0x743E) y "
      "del 0xFA en adelante, órdenes (pausa, sigue). Antes se corre "
      "`sonido_a_cero`, que deja la copia del mezclador del PSG en 0xBC. La "
      "RAM del sonido está en 0xE100-0xE1CD. Las que suenan igual que otra "
      "se publican una vez, y las que duran más de 75 segundos sin volver a "
      "empezar se cortan a los 75.",
      "How a piece is asked for",
      "`pide_sonido` (p00:4E1F) and `pide_sonido_ya` (p00:4E34, without "
      "looking at the pause) save the banks at 0x6000 and 0x8000, map 13 and "
      "14 and call `sonido` with the number in A: 0 silences everything, "
      "0x01 to 0x7F is an effect, 0x80 to 0xF9 a tune (table at 0x743E) and "
      "from 0xFA up, orders (pause, resume). Before that, `sonido_a_cero` "
      "runs, leaving the copy of the PSG mixer at 0xBC. The sound RAM is at "
      "0xE100-0xE1CD. Those that sound like another are published once, and "
      "those that last over 75 seconds without starting again are cut at "
      "75.")])

CFG = dict(rom="galious.rom", org=0x4000, mapper="konami",
           bancos0=((0x4000, 0), (0x6000, 13), (0x8000, 14), (0xA000, 3)),
           bancos_frame=((0x6000, 13), (0x8000, 14)),
           init=[(0x4DED, {})], frame=0x6004, pide=0x4E6B,
           banco_frame=13, banco_pide=0, ram=(0xE100, 0xE1CE), hz=60,
           psg0={7: 0xBC}, romtype="konami", max_s=75, piezas=PIEZAS,
           pagina=PAGINA, cotejado=[(0x8A, 1945, 25)])

if __name__ == "__main__":
    sys.exit(motor_musica.main(CFG, sys.argv[1:]))
