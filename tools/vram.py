#!/usr/bin/env python3
"""Un modelo de la VRAM de The Maze of Galious que se llena como el cartucho.

SCREEN 2 (p00:4C5B): dibujos en 0x2000, colores en 0x0000 (tres tercios de
0x800 cada uno), tabla de nombres en 0x3800, dibujos de sprite en 0x1800.

Las rutinas del banco 0 que se reproducen:
  rle        p00:5C46  [n<0x80][byte] repite, [0x80+n] n tal cual, 0x80 trae
                       otro destino, 0 acaba
  tercios    p00:5BFC  el mismo rle en los tres tercios (+0x800)
  llena      p00:5BEB  FILVRM en los tres tercios
  fichas     p00:5AB3  fichas de 6 bytes [tercios][dibujos][caracter][colores]
  copias     p00:5A8D  fichas de 4 bytes [de][a][tercios][cuantos]: copia
                       dibujos y colores dando la vuelta a los dibujos (p00:5B08)
  sala       p00:568E  la carga grafica de una sala (ver carga_sala)
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import mapas as M  # noqa: E402

TAM = 0x2000


class Rom:
    def __init__(self, ruta=os.path.join(RAIZ, "galious.rom")):
        self.d = open(ruta, "rb").read()
        self.s = (1, 2, 3)

    def pon(self, a=None, b=None, c=None):
        self.s = tuple(n if n is not None else v for n, v in zip((a, b, c), self.s))

    def __getitem__(self, a):
        bank = 0 if a < 0x6000 else self.s[(a - 0x6000) // TAM]
        return self.d[bank * TAM + (a & 0x1FFF)]

    def palabra(self, a):
        return self[a] | self[a + 1] << 8


class Vram:
    def __init__(self, rom):
        self.v = bytearray(0x4000)
        self.r = rom

    def rle(self, de, hl):
        """p00:5C46. Devuelve el DE de despues del 0."""
        r = self.r
        while True:
            n = r[de]
            if n == 0:
                return de
            de += 1
            if n < 0x80:
                b = r[de]
                de += 1
                for _ in range(n):
                    self.v[hl & 0x3FFF] = b
                    hl += 1
            elif n == 0x80:
                hl = r.palabra(de)
                de += 2
            else:
                for _ in range(n & 0x7F):
                    self.v[hl & 0x3FFF] = r[de]
                    de += 1
                    hl += 1

    def tercios(self, de, hl):
        for k in range(3):
            self.rle(de, hl + 0x800 * k)

    def llena(self, hl, n, valor):
        for k in range(3):
            for i in range(n):
                self.v[(hl + 0x800 * k + i) & 0x3FFF] = valor

    def fichas(self, ix):
        """p00:5AB3."""
        r = self.r
        while r[ix]:
            t = r[ix]
            for bit, base in ((0, 0x1000), (1, 0x0800), (2, 0x0000)):
                if t & (1 << bit):
                    hl = r[ix + 3] * 8 + base
                    self.rle(r.palabra(ix + 1), hl + 0x2000)
                    self.rle(r.palabra(ix + 4), hl)
            ix += 6

    def copias(self, ix):
        """p00:5A8D."""
        r = self.r
        while r[ix]:
            src, dst, fl, n = r[ix], r[ix + 1], r[ix + 2], r[ix + 3]
            ln = n * 8
            if fl & 4:
                ps, cs = 0x2000, 0x0000
            elif fl & 2:
                ps, cs = 0x2800, 0x0800
            else:
                ps, cs = 0x3000, 0x1000
            pat = self.v[ps + src * 8: ps + src * 8 + ln]
            col = self.v[cs + src * 8: cs + src * 8 + ln]
            pat = bytes(int("{:08b}".format(b)[::-1], 2) for b in pat)
            for bit, base in ((3, 0x1000), (4, 0x0800), (5, 0x0000)):
                if fl & (1 << bit):
                    o = dst * 8 + base
                    self.v[0x2000 + o:0x2000 + o + ln] = pat
                    self.v[o:o + ln] = col
            ix += 4

    def caracter(self, tercio, c):
        o = tercio * 0x800 + c * 8
        return self.v[0x2000 + o:0x2000 + o + 8], self.v[o:o + 8]


def carga_sala(rom, vram, m, n):
    """Lo grafico de p00:568E para la sala n del mapa m (sin sprites)."""
    rom.pon(13, 14, 15)                     # p00:5E11
    vram.tercios(0x9AD3, 0x2008)
    vram.tercios(0x9B24, 0x2058)
    vram.llena(0x0008, 0x120, 0xF0)
    rom.pon(10, 11, 12)                     # p00:59E9
    vram.fichas(0x6000)
    vram.copias(0x6037)
    if m == 1:
        z = rom[0x60D7 + n // 2]
        z = (z if n & 1 else z >> 4) & 0x0F
        for f in {0: [("f", 0x6069)], 1: [("f", 0x6076)], 2: [("f", 0x6083), ("c", 0x60A8)],
                  3: [("f", 0x6083), ("f", 0x60C9), ("c", 0x60A8)],
                  4: [("f", 0x60B1), ("f", 0x60A1), ("c", 0x60AC)],
                  5: [("f", 0x60B1), ("c", 0x60AC)], 6: [("f", 0x60D0)]}[z]:
            (vram.fichas if f[0] == "f" else vram.copias)(f[1])
    elif m > 1:
        vram.fichas(0x6044)
    return vram


def nombres(rom, m, n):
    """Los 32 x 20 caracteres de la sala (filas 4-23 de la pantalla)."""
    rom.pon(7, 8, 9)
    sala = M.sala(rom.d, m, n)
    t = [[0] * 32 for _ in range(20)]
    for k, b in enumerate(sala):
        bx, by = k % 8, k // 8
        for i in range(16):
            t[by * 4 + i // 4][bx * 4 + i % 4] = rom[0x6000 + 16 * b + i]
    return t


def objetos(rom, m, n):
    """[(tipo, bit 7, Y en pixeles, X en pixeles)] de la lista 0xB5CB (p04:6022)."""
    rom.pon(4, 5, 6)
    i = rom.palabra(0xB5CB + 2 * m)
    for _ in range(1, n):
        while rom[i] & 0x7F:
            i += 2
        i += 1
    fuera = []
    while rom[i] & 0x7F:
        t, p = rom[i], rom[i + 1]
        fuera.append((t & 0x7F, t >> 7, p & 0xF8, (((p & 7) << 1) | (t >> 7)) * 16))
        i += 2
    return fuera


def ficha_de_tipo(rom, t):
    """Los 5 bytes del tipo t (p04:67AF)."""
    rom.pon(4, 5, 6)
    return [rom[0x67B6 + 5 * t + k] for k in range(5)]


def mosaico(rom, k):
    """(ancho, alto, caracteres) del mosaico k (0x9D90 y 0x9E0A, bancos 1-14-15)."""
    rom.pon(1, 14, 15)
    a = rom.palabra(0x9E0A + 2 * k)
    c, f = rom[0x9D90 + 2 * k], rom[0x9D91 + 2 * k]
    return c, f, [rom[a + i] for i in range(c * f)]


def tinajas(rom, n):
    """Las tinajas del castillo (0xB8A2, p01:6309): [(fila, columna)] de pantalla."""
    rom.pon(7, 8, 9)
    i = 0xB8A2
    for _ in range(1, n):
        while rom[i]:
            i += 1
        i += 1
    fuera = []
    while rom[i]:
        v = rom[i]
        fuera.append((((v & 0xE0) | 8) // 8, (v & 0x1F)))
        i += 1
    return fuera


def nombres_con_objetos(rom, m, n):
    """La tabla de nombres de la sala con las tinajas y los objetos que se
    pintan con caracteres (los de ficha sin el bit 7: puertas...)."""
    t = nombres(rom, m, n)
    if m == 1:
        for fy, fx in tinajas(rom, n):
            for dy, dx, c in ((0, 0, 0xBA), (0, 1, 0xBB), (1, 0, 0xBC), (1, 1, 0xBD)):
                if 0 <= fy - 4 + dy < 20 and fx + dx < 32:
                    t[fy - 4 + dy][fx + dx] = c
    for tipo, b7, y, x in objetos(rom, m, n):
        fi = ficha_de_tipo(rom, tipo)
        if fi[0] & 0x80 or fi[1] >= 61:
            continue
        c, f, cs = mosaico(rom, fi[1])
        for k, ch in enumerate(cs):
            fy, fx = y // 8 - 4 + k // c, x // 8 + k % c
            if ch and 0 <= fy < 20 and 0 <= fx < 32:
                t[fy][fx] = ch
    return t
