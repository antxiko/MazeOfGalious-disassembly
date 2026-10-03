#!/usr/bin/env python3
"""Los objetos de The Maze of Galious (las cosas de sala, p00:5DC9, y lo que
venden las tiendas, p02:9126), dibujados desde la ROM.

Cada cosa es un tipo de 1 a 0x2F. Al entrar en la sala (vram.piezas):
  1-6        una pareja de caracteres de 0x6C87 + 2 x tipo (p01:6C56)
  7-0x2C     2 x 2 caracteres 0x76-0x79 con el dibujo propio del tipo:
             dibujos 0x6E34 + 2 x tipo y colores 0x6E80 + 2 x tipo, rle a
             0x23B0/0x03B0 en los tres tercios (p00:58E1)
  0x2D-0x2F  2 x 2 caracteres desde 0x60 + 4 x (tipo - 0x2D)
Recoger el tipo k (< 0x28) pone a 1 su marca 0xE06F + k.

Las tiendas: 0xE690 (1-13) elige en 0x9255 una ficha de tres articulos
[precio BCD][tipo] (p02:923E); el precio se resta de las monedas 0xE048
(p02:922B). 0x2D = 100 flechas (dos veces 50 en 0xE046, p00:4D5A), 0x2F =
una llave (0xE04A, p00:4D82), 0x28/0x2B/0x2C = el nivel 1/2/3 de 0xE097
(el 0x2C pide antes el 0x2B, p02:91F4).

Uso: objetos.py lista          tipos, salas donde estan y tiendas
     objetos.py hoja <png>     la hoja de los 47 tipos
"""
import os
import sys
from collections import defaultdict

try:
    from PIL import Image, ImageDraw
except ImportError:            # las hojas necesitan PIL; los datos y los tests no
    Image = ImageDraw = None

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import mapas as M  # noqa: E402
import vram as V  # noqa: E402

FONDO = (24, 24, 40)
TIENDAS = 0x9255        # p02:9483, banco 2 en 0x8000

# Lo que hace cada marca 0xE06F + tipo, leido en el codigo (quien la lee).
# "sin mirar" = se sabe quien la lee, no que hace.
EFECTOS = {
    0x07: "la vida del jefe del mundo empieza a la mitad (p01:7F63, srl sobre la tabla 0x7F97)",
    0x08: "el dano que hace el jefe se queda en la mitad (p03:BAC4, tabla 0xBAD2)",
    0x09: "con el jefe en la sala, disparar no gasta flechas (p03:AA94)",
    0x0A: "en la pantalla de objetos (estado 0x0B) pinta el mapa del mundo (tabla 0xAF2A) con la sala marcada (p01:661B)",
    0x0B: "deja tocar algo que sin el no se mira (p03:BBA8; sin mirar)",
    0x0C: "lo deja el jefe vencido (la cosa 0x0C, p00:4BA9); se gasta al abrir la puerta del mundo siguiente (p02:99FB)",
    0x0D: "sin el, Popolon no entra en el mundo 7 (p02:9A41) ni se puede cambiar de personaje en el mapa 8 (p01:684F)",
    0x0E: "el enemigo de tipo 0x2A no le toca (p03:B20B)",
    0x0F: "el enemigo de tipo 0x28 no le toca (p03:B215)",
    0x10: "en el mapa 6, salas 12 y 13, pisar el caracter 0xB6 (agua) pone 0xE52A = 1 y no 0xE511 = 1 (p03:B037; que cambia: sin mirar)",
    0x11: "suma 0x140 en vez de 0x100 a 0xE504 (p03:A6B6; sin mirar que mueve) y p03:A5FE",
    0x12: "abre algo en la sala 0x0B del mapa 3 (p08:9F87, 0xEAC8 = 1; sin mirar)",
    0x13: "sin el, en el mapa 9 la izquierda y la derecha van cambiadas (p03:A8A6 -> p03:A8BE, bits 2 y 3 de 0xE008/0xE009)",
    0x14: "en el castillo, p00:5D24 pinta algo segun 0xE06C (sin mirar)",
    0x15: "en la pantalla de objetos, sin jefe, RETURN lleva a la sala 0x48 del castillo (p02:9AC9, p00:47DE)",
    0x16: "la sala 6 del mapa 6 sale con su otra planta (p00:55F7, 0x8DAE)",
    0x17: "el enemigo de tipo 0x2E no le toca (p03:B21F)",
    0x18: "en el mapa 9 llena 0xEF00 de 0xF0 (p00:5575) y p04:6200 (sin mirar)",
    0x19: "p03:B3BF (sin mirar)",
    0x1A: "en ese mapa marca tambien el sitio de la tabla 0xB0FC (p01:668F)",
    0x1B: "cada enemigo da el doble de experiencia (p03:B62E, tabla 0xBF27 -> p01:6158)",
    0x1C: "p09:A668 (sin mirar)",
    0x1D: "disparos con flechas (p03:A99E; sin mirar)",
    0x1E: "disparos con flechas (p03:A9B7; sin mirar)",
    0x1F: "el golpe quita 5 en vez de 1 cuando no se lleva a Popolon (p03:B841 -> p00:4DDB)",
    0x20: "con CTRL (fila 6, bit 1) se paran las figuras y el jefe (0xE0D5 = 1, 0x96 en 0xE0D6), hasta 16 veces (0xE531) (p02:9BB6)",
    0x21: "con el boton de disparo, p01:6398 (sin mirar)",
    0x22: "el enemigo de tipo 0x31 no le toca (p03:B229)",
    0x23: "sin el, Afrodita no entra en el mundo 5 (p02:9A33) ni se puede cambiar de personaje en el mapa 6 (p01:6844)",
    0x24: "el enemigo de tipo 0x08 no le toca (p03:B201)",
    0x25: "cada golpe quita el doble (p03:B586 y p03:B5D1)",
    0x26: "sin el no se mira la palabra UMBRELLA (p02:9BEE), que acaba con las figuras de tipo 0x0E (p03:B5EA)",
    0x27: "en la pantalla de objetos del castillo, la cifra 1-9 lleva a la puerta de ese mundo si ya esta abierta (p02:9A99)",
    0x28: "nivel 1 de 0xE097",
    0x29: "p09:A345 (sin mirar)",
    0x2A: "hace falta para las puertas de vuelta de tipo 3 (p02:9A84)",
    0x2B: "nivel 2 de 0xE097",
    0x2C: "nivel 3 de 0xE097",
}


def salas_por_tipo(rom):
    d = defaultdict(list)
    for m in range(1, 12):
        for n in range(1, M.n_salas(rom.d, m) + 1):
            c = V.cosa_de_sala(rom, m, n)
            if c:
                d[c[0]].append((m, n))
    return d


def tiendas(rom):
    """{tienda (0xE690): [(precio, tipo)]} sin los huecos (tipo 0 o 0xFF)."""
    rom.pon(1, 2, 3)
    fuera = {}
    for t in range(1, 14):
        f = rom.palabra(TIENDAS + 2 * (t - 1))
        arts = [(int("%02X" % rom[f + 2 * k]), rom[f + 2 * k + 1]) for k in range(3)]
        fuera[t] = [a for a in arts if a[1] not in (0, 0xFF)]
    return fuera


def caracteres(rom, tipo):
    """[[caracter]] con el que se pinta el tipo en la sala, y la VRAM."""
    v = V.carga_sala(rom, V.Vram(rom), 2, 1)
    if tipo < 7:
        rom.pon(1, 2, 3)
        a = 0x6C87 + 2 * tipo
        return [[rom[a + 1], rom[a]]], v
    if tipo < 0x2D:
        rom.pon(10, 11, 12)
        v.tercios(rom.palabra(0x6E34 + 2 * tipo), 0x23B0)
        v.tercios(rom.palabra(0x6E80 + 2 * tipo), 0x03B0)
        return [[0x76, 0x77], [0x78, 0x79]], v
    b = 0x60 + 4 * (tipo - 0x2D)
    return [[b, b + 1], [b + 2, b + 3]], v


def pinta(px, rom, tipo, ox, oy, esc=1):
    from dibuja import pinta_caracter
    cs, v = caracteres(rom, tipo)
    im = Image.new("RGB", (16, 16), FONDO)
    p = im.load()
    for f, fila in enumerate(cs):
        for c, ch in enumerate(fila):
            pat, col = v.caracter(1, ch)
            pinta_caracter(p, c * 8, f * 8 + (8 if len(cs) == 1 else 0), pat, col, FONDO)
    im = im.resize((16 * esc, 16 * esc), Image.NEAREST)
    q = im.load()
    for y in range(16 * esc):
        for x in range(16 * esc):
            px[ox + x, oy + y] = q[x, y]


def hoja():
    rom = V.Rom()
    sal = salas_por_tipo(rom)
    esc, paso = 3, 64
    im = Image.new("RGB", (8 * paso, 6 * paso), FONDO)
    px = im.load()
    dr = ImageDraw.Draw(im)
    for tipo in range(1, 0x30):
        j, i = divmod(tipo - 1, 8)
        pinta(px, rom, tipo, i * paso + 8, j * paso + 4, esc)
        dr.text((i * paso + 4, j * paso + 52), "%02X x%d" % (tipo, len(sal[tipo])),
                fill=(160, 160, 190) if sal[tipo] else (90, 90, 110))
    return im


def main(argv):
    if argv[1:] == ["lista"]:
        rom = V.Rom()
        sal = salas_por_tipo(rom)
        for t in range(1, 0x30):
            print("%02X %2d  %s" % (t, len(sal[t]), " ".join("%d:%d" % s for s in sal[t])))
        for t, arts in tiendas(rom).items():
            print("tienda %2d  %s" % (t, "  ".join("%02X por %d" % (k, p) for p, k in arts)))
    elif len(argv) == 3 and argv[1] == "hoja":
        hoja().save(argv[2])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
