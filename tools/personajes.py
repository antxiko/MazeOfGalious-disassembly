#!/usr/bin/env python3
"""Las hojas de sprites de The Maze of Galious, dibujadas desde la ROM con
tools/sprites.py (la tabla de dibujos de cada sala y las poses de p01:7529).

Uso: personajes.py poses <png>    Popolon y Afrodita: las 32 poses
     personajes.py juegos <png>   los juegos de sprites que cargan las salas
"""
import os
import sys

from PIL import Image, ImageDraw

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import mapas as M  # noqa: E402
import sprites as S  # noqa: E402
import vram as V  # noqa: E402
from dibuja import TMS  # noqa: E402

FONDO = (24, 24, 40)
ESC = 3


def pinta_sprite(px, v, ox, oy, d, color):
    """El sprite de 16x16 del dibujo d (0x1800 + 8 x d) en (ox, oy)."""
    a = S.BASE + 8 * d
    for mitad in (0, 1):
        for y in range(16):
            b = v[a + 16 * mitad + y]
            for x in range(8):
                if b & (0x80 >> x):
                    px[ox + 8 * mitad + x, oy + y] = color


def pinta_pose(px, v, pose, ox, oy, afrodita, estado=2):
    """La pose como la escribe p01:73E4 con el jugador en (oy, ox). Las
    coordenadas del juego son de un byte: se calcula con el jugador en
    (0x80, 0x80) y se lleva luego a (oy, ox)."""
    ram = {0xE000: estado, 0xE500: 0, 0xE501: 0 if afrodita else 1, 0xE502: pose,
           0xE53D: pose, 0xE505: 0x81, 0xE507: 0x80, 0xE523: 0, 0xE533: 0, 0xE604: 0}
    rom = V.Rom()
    for y, x, d, c in reversed(S.atributos_del_jugador(rom, ram.__getitem__)):
        pinta_sprite(px, v, ox + x - 0x80, oy + y + 1 - 0x80, d, TMS[c])


def hoja_poses():
    """Tres tiras por personaje: las 18 de la partida (p01:7529, 0-17), el
    hundimiento (18-27, dibujos de p00:5832) y la de F2 (28-31, dibujos de
    p00:5917; la 29 apunta a la misma lista que la 30)."""
    rom = V.Rom()
    base = S.tabla_de_sala(rom, 1, 1)
    hundir = S.hundimiento(rom, S.tabla_de_sala(rom, 1, 1))
    f2 = S.tabla_de_sala(rom, 1, 1)
    rom.pon(10, 11, 15)
    f2.rle(0xBF16, 0x1800)                  # p00:5917
    tiras = [(base.v, range(0, 18), 2), (hundir.v, range(18, 28), 2), (f2.v, (28, 30, 31), 9)]
    paso, alto = 40, 44
    im = Image.new("RGB", (18 * paso, 2 * 3 * alto), FONDO)
    px = im.load()
    for k, afro in enumerate((False, True)):
        for t, (v, poses, est) in enumerate(tiras):
            for i, p in enumerate(poses):
                pinta_pose(px, v, p, i * paso + 14, (k * 3 + t) * alto + 36, afro, est)
    return im.resize((im.width * ESC, im.height * ESC), Image.NEAREST)


def juegos_usados(rom):
    """{juego: [(mapa, sala)...]} de las listas de p00:595F."""
    fuera = {}
    for m in range(1, 12):
        for n in range(1, M.n_salas(rom.d, m) + 1):
            for k in S.juegos_de_sala(rom, m, n):
                fuera.setdefault(k, []).append((m, n))
    return fuera


def dibujos_del_juego(rom, k):
    """Los sprites de 16x16 que escribe el juego k (sin las vueltas, que son
    los mismos mirando al otro lado)."""
    rom.pon(10, 11, 12)
    a = rom.palabra(0x7C72 + 2 * k)
    v = V.Vram(rom)
    v.v[:] = bytes([0x55]) * 0x4000
    while rom[a]:
        v.rle(rom.palabra(a + 1), S.BASE + 8 * rom[a])
        a += 3
    w = V.Vram(rom)
    w.v[:] = bytes([0xAA]) * 0x4000
    a = rom.palabra(0x7C72 + 2 * k)
    while rom[a]:
        w.rle(rom.palabra(a + 1), S.BASE + 8 * rom[a])
        a += 3
    # un sprite cuenta si el juego escribe algun byte suyo (los que no
    # escribe salen distintos en las dos pasadas) y no esta vacio
    escritos = []
    for d in range(0, 256, 4):
        a = S.BASE + 8 * d
        tocados = [i for i in range(a, a + 32) if v.v[i] == w.v[i]]
        if tocados and any(v.v[i] for i in tocados):
            escritos.append(d)
            for i in range(a, a + 32):
                if v.v[i] != w.v[i]:
                    v.v[i] = 0
    return v.v, escritos


def hoja_juegos():
    rom = V.Rom()
    usados = juegos_usados(rom)
    filas = []
    for k in sorted(usados):
        v, ds = dibujos_del_juego(rom, k)
        filas.append((k, v, ds))
    ancho = max(len(f[2]) for f in filas)
    paso = 20
    im = Image.new("RGB", (60 + ancho * paso, len(filas) * paso + 4), FONDO)
    px = im.load()
    dr = ImageDraw.Draw(im)
    for j, (k, v, ds) in enumerate(filas):
        dr.text((4, j * paso + 5), "%02X" % k, fill=(160, 160, 190))
        dr.text((22, j * paso + 5), "%3d" % len(usados[k]), fill=(110, 110, 140))
        for i, d in enumerate(ds):
            pinta_sprite(px, v, 60 + i * paso, j * paso + 2, d, (230, 230, 230))
    return im.resize((im.width * 2, im.height * 2), Image.NEAREST)


def main(argv):
    if len(argv) == 3 and argv[1] == "poses":
        hoja_poses().save(argv[2])
    elif len(argv) == 3 and argv[1] == "juegos":
        hoja_juegos().save(argv[2])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
