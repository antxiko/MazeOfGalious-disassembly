#!/usr/bin/env python3
"""El logotipo de Konami y la pantalla de titulo, dibujados desde la ROM.

Sigue los pasos del cartucho con tools/vram.py:
  logotipo  p00:42D5 (estado 0, paso 0): registros de 0x4C5B (R7 = 0xE4),
            pantalla negra, la fuente del titulo (p00:5E34) y p01:6957 con
            el banco 9 en 0xA000: el rle con destino de 0xBCEF y 6 filas de
            21 caracteres desde el 0x40 en la fila 8, columna 7; el paso 1
            (p01:6985) los va pintando en color 0xF0.
  titulo    p00:42F1: la fuente del titulo, los graficos de p00:5772 con los
            bancos 1-14-15 (R7 = 0xE0, fichas 0x9A96, copias 0x9A9D, sprites
            0x99A9) y p01:6215: 4 sprites de 0x93E7, el rotulo de 0x933F (14 x
            12) en la fila 1, columna 9, y la lista de 0x7D51.

Uso: titulo.py png <logotipo|titulo> <png>
     titulo.py coteja <logotipo|titulo> <volcado .vram>
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import vram as V  # noqa: E402
from dibuja import TMS  # noqa: E402


def filvrm_tercios(v, hl, n, valor):
    """p00:5BEB."""
    for k in range(3):
        for i in range(n):
            v.v[(hl + 0x800 * k + i) & 0x3FFF] = valor


def fuente_del_titulo(rom, v):
    """p00:5E34: los 16 primeros caracteres de colores 0-15, las cifras, las
    letras y el color 0xF0 desde el caracter 0x10."""
    rom.pon(13, 14, 15)
    filvrm_tercios(v, 0x2000, 0x80, 0)
    for c in range(16):
        filvrm_tercios(v, 8 * c, 8, c)
    v.tercios(0x9AD3, 0x2080)
    v.tercios(0x9AA2, 0x20D0)
    v.tercios(0x9ACC, 0x2100)
    v.tercios(0x9B24, 0x2108)
    filvrm_tercios(v, 0x0080, 0x158, 0xF0)
    rom.pon(1, 2, 3)


def lista(rom, v, de):
    """p00:5C25: [destino] y bytes; 0xFE trae otro destino, 0xFF acaba."""
    while True:
        hl = rom.palabra(de)
        de += 2
        while True:
            b = rom[de]
            de += 1
            if b == 0xFF:
                return
            if b == 0xFE:
                break
            v.v[hl & 0x3FFF] = b
            hl += 1


def logotipo(rom):
    """(vram, r7) al acabar el paso 1 del estado 0."""
    v = V.Vram(rom)
    v.v[0x3B00] = 0xD0                        # p00:5BB5, sin sprites
    fuente_del_titulo(rom, v)
    rom.pon(1, 2, 9)
    de = 0xBCEF                               # p00:5C40, rle con destino
    v.rle(de + 2, rom.palabra(de))
    for i in range(0x3F0):                    # sus colores a 0...
        v.v[0x0A00 + i] = 0
    for f in range(6):                        # ...6 x 21 caracteres desde el 0x40
        for c in range(21):
            v.v[0x3907 + 32 * f + c] = 0x40 + 21 * f + c
    for col in range(6):                      # p01:6985, el paso 1 entero
        a = (0xEB + 0x15 * (col + 1)) & 0xFF
        for fila in range(8):
            for k in range(21):
                v.v[0x0A00 + a * 8 + fila + 8 * k] = 0xF0
    rom.pon(1, 2, 3)
    return v, rom[0x4C5B + 7]


def titulo(rom):
    """(vram, r7) con el titulo quieto: la mitad de arriba copiada de 0xED00
    (0x1A0 bytes, p01:6248) y los 4 sprites de 0x93E7. Se pinta encima del
    logotipo, que deja sus restos en los caracteres que el titulo no pisa."""
    v, _ = logotipo(rom)
    v.v[0x3800:0x3B00] = bytes(0x300)         # p00:42F1, pantalla a cero
    fuente_del_titulo(rom, v)
    rom.pon(1, 14, 15)
    v.fichas(0x9A96)                          # p00:5772
    v.copias(0x9A9D)
    v.rle(0x99A9, 0x1800)
    ed = bytearray(0x300)                     # la copia de nombres, a cero
    for f in range(12):                       # el rotulo de 0x933F en 0xED29
        for c in range(14):
            ed[0x29 + 32 * f + c] = rom[0x933F + 14 * f + c]
    v.v[0x3800:0x3800 + 0x1A0] = ed[:0x1A0]
    sat = [rom[0x93E7 + i] for i in range(16)] + [0xE0, 0, 0, 0] * 28
    v.v[0x3B00:0x3B80] = bytes(sat)
    lista(rom, v, 0x7D51)
    rom.pon(1, 2, 3)
    return v, 0xE0


def imagen(v, r7, sprites=0):
    from PIL import Image
    fondo = TMS[r7 & 0x0F]
    im = Image.new("RGB", (256, 192), fondo)
    px = im.load()
    for f in range(24):
        for c in range(32):
            n = v.v[0x3800 + 32 * f + c]
            o = (f // 8) * 0x800 + n * 8
            for y in range(8):
                p, k = v.v[0x2000 + o + y], v.v[o + y]
                for x in range(8):
                    ci = (k >> 4) if p & (0x80 >> x) else (k & 0x0F)
                    if ci:
                        px[8 * c + x, 8 * f + y] = TMS[ci]
    for s in reversed(range(sprites)):
        y, x, d, col = v.v[0x3B00 + 4 * s: 0x3B04 + 4 * s]
        if y == 0xD0:
            break
        if y >= 0xE0 or not col & 0x0F:
            continue
        y = (y + 1) & 0xFF
        d &= 0xFC
        for k in range(32):
            b = v.v[0x1800 + 8 * d + k]
            for i in range(8):
                if b & (0x80 >> i):
                    xx, yy = x + i + (8 if k >= 16 else 0), y + (k & 15)
                    if 0 <= xx < 256 and yy < 192:
                        px[xx, yy] = TMS[col & 0x0F]
    return im


def coteja(v, ruta):
    """Bytes distintos en los 16 KB de la VRAM. De los sprites 4-31 solo
    cuenta la y (escondidos, 0xE0): el resto de sus 4 bytes son restos de la
    copia de 0xEC80, que esconde_sprites no toca."""
    o = open(ruta, "rb").read()
    dif = 0
    for i in range(0x4000):
        if 0x3B10 <= i < 0x3B80 and i & 3:
            continue
        dif += v.v[i] != o[i]
    return dif


def main(argv):
    rom = V.Rom()
    que = {"logotipo": logotipo, "titulo": titulo}[argv[2]]
    v, r7 = que(rom)
    if argv[1] == "png":
        imagen(v, r7, 4 if argv[2] == "titulo" else 0).save(argv[3])
    elif argv[1] == "coteja":
        d = coteja(v, argv[3])
        print("%s: %d diferencias" % (argv[2], d))
        return 1 if d else 0
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
