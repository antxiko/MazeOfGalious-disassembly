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
    cosa = cosa_de_sala(rom, m, n)          # p00:569D-56A5 y p00:58DE
    rom.pon(10, 11, 12)
    if cosa and 7 <= cosa[0] < 0x2D:
        vram.tercios(rom.palabra(0x6E34 + 2 * cosa[0]), 0x23B0)
        vram.tercios(rom.palabra(0x6E80 + 2 * cosa[0]), 0x03B0)
    if n == rom[0x5DFB + m]:                # p00:56FA, la sala del jefe
        vram.fichas(0x6121)
        vram.copias(0x6128)
    return vram


def nombres(rom, m, n):
    """Los 32 x 20 caracteres de la sala (filas 4-23 de la pantalla), como los
    monta p00:55C6.

    Con las marcas de partida nueva: la sala 6 del mapa 6 sale de la otra
    planta de 0x8DAE mientras 0xE085 este a 0 (p00:55F7), y en la sala del
    jefe (0x5DFB + mapa) va encima el recuadro de 8 x 8 de 0x9BE2 + 2 x mapa
    en la fila 4, columna 12 (la 6 en el mapa 7), p00:55C9 con 0xE615 = 1
    (p02:9AE5)."""
    rom.pon(7, 8, 9)
    if (m, n) == (6, 6):
        sala = [rom[0x8DAE + i] for i in range(40)]
    else:
        sala = M.sala(rom.d, m, n)
    t = [[0] * 32 for _ in range(20)]
    for k, b in enumerate(sala):
        bx, by = k % 8, k // 8
        for i in range(16):
            t[by * 4 + i // 4][bx * 4 + i % 4] = rom[0x6000 + 16 * b + i]
    if n == rom[0x5DFB + m]:
        a = rom.palabra(0x9BE2 + 2 * m)
        f0 = 6 if m == 7 else 4
        for f in range(8):
            for c in range(8):
                t[f0 + f][12 + c] = rom[a + 8 * f + c]
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


def casilla(y, x):
    """p00:4DA1: (fila, columna) de la sala para el punto (y, x) de pantalla."""
    return (y >> 3) - 4, x >> 3


def figuras(rom, m, n):
    """[(tipo, y, x)] de la lista de figuras de la sala (0xA7BC, p08:9D1D):
    [tipo][y:3 bits, x:5 bits] y un 0 al final."""
    rom.pon(7, 8, 9)
    i = rom.palabra(0xA7BC + 2 * m)
    for _ in range(1, n):
        while rom[i]:
            i += 2
        i += 1
    fuera = []
    while rom[i]:
        c, p = rom[i], rom[i + 1]
        fuera.append((c, p & 0xE0, (p << 3) & 0xF8))
        i += 2
    return fuera


def dibujo(rom, tabla, k, ancho, alto):
    """Las filas del dibujo k de una tabla de punteros del banco 15."""
    rom.pon(13, 14, 15)
    a = rom.palabra(tabla + 2 * k)
    return [[rom[a + f * ancho + c] for c in range(ancho)] for f in range(alto)]


# Los bloques que tapan un paso hasta que se abre (p08:9F1A): (mapa, sala) ->
# donde va en la copia de la tabla de nombres; 3 filas de 4 caracteres 0xF0
# (p01:7367). La marca que los quita (0xE0A1-0xE0AC) empieza a 0.
BLOQUES_F0 = {(4, 4): 0xED9C, (2, 12): 0xED80, (3, 13): 0xEE9C, (5, 15): 0xEF0E,
              (6, 13): 0xEE9C, (7, 8): 0xEF00, (8, 8): 0xEF84, (8, 14): 0xED88,
              (9, 3): 0xEE1C, (9, 20): 0xEE1C, (10, 26): 0xED84}


def cosa_de_sala(rom, m, n):
    """La cosa (tesoro, cofre...) de la sala, de la tabla 0xB6FC + 2 x mapa
    (banco 9, p00:5DC9): fichas de 3 bytes [sala][b7 b6 tipo:6][y:5 x:3]. La
    primera de la sala manda. Devuelve (tipo, y, x) en pixeles, con la y ya
    bajada 8 para los tipos 1-6 (p00:5DB5), o None.
    Con las marcas a 0 de partida nueva siempre se pinta (p00:5D68-5DAA)."""
    rom.pon(7, 8, 9)
    i = rom.palabra(0xB6FC + 2 * m)
    while rom[i]:
        if rom[i] == n:
            b, p = rom[i + 1], rom[i + 2]
            tipo = b & 0x3F
            if not tipo:
                return None
            y = p & 0xF8
            x = (((p & 7) << 2) | ((b >> 6) & 3)) << 3
            if not y | x:
                return None
            if tipo < 7:
                y += 8
            return tipo, y, x
        i += 3
    return None


def piezas(rom, m, n):
    """Lo que el juego pinta encima de la sala al entrar, con las marcas de una
    partida nueva (todas a 0): [(fila, columna, caracter)].

      - figuras de 0xA7BC (p08:9D44 las monta, p01:77EE y p01:71E3 las pintan):
        1 puerta, columna de 3 x 0xC5 (p09:A013); 5 paso escondido, nada hasta
        que se abre (p09:A415); 2, 3 y 4 el dibujo 0 de las tablas 0xA6FB,
        0xA726 y 0xA74C (1 x 3); 7 los 3 x 4 de 0xA772 si la marca del mundo
        no tiene el bit 2; 6 nada al entrar (p09:A52E)
      - las 13 escaleras del castillo (p09:A746): 0xA6EB [mapa][sala] y 0xA700
        + 5 x k [y][x][filas]..., columnas de 9A 9B
      - las puertas de los mundos en el castillo (p02:9DAF): 0x9DDA
        [sala][mundo][y][x], 2 x 2 de 0x73D2 (p01:73B7)
      - la cosa de la sala (cosa_de_sala, p01:6C56): tipos 1-6 una pareja de
        0x6C89, 7-0x2C el cofre 76 77 / 78 79, desde 0x2D 2 x 2 desde
        0x60 + 4 x (tipo - 0x2D)
      - las 9 puertas de vuelta de los mundos en el castillo (p02:9943): salas
        de 0x9990, [y][x] de 0x9999, 3 x 4 de 0x6CC7 (p01:6C95; el dibujo 0,
        el de mundo sin visitar)
      - los bloques de BLOQUES_F0
    """
    fuera = []

    def rect(f0, c0, filas):
        for df, fila in enumerate(filas):
            for dc, ch in enumerate(fila):
                fuera.append((f0 + df, c0 + dc, ch))

    # la cosa va primero: las figuras la tapan (3:4 y 7:6, figura 7)
    cosa = cosa_de_sala(rom, m, n)
    if cosa:
        tipo, y, x = cosa
        f, c = casilla(y, x)
        if tipo < 7:
            rom.pon(1, 2, 3)
            a = 0x6C87 + 2 * tipo
            rect(f, c, [[rom[a + 1], rom[a]]])     # el 0 tambien se escribe
        else:
            b = 0x76 if tipo < 0x2D else 0x60 + 4 * (tipo - 0x2D)
            rect(f, c, [[b, b + 1], [b + 2, b + 3]])
    for c, y, x in figuras(rom, m, n):
        f, k = casilla(y, x)
        t = c & 0x0F
        if t == 1:
            rect(f, k, [[0xC5]] * 3)
        elif t == 2:
            rect(f, k, dibujo(rom, 0xA6FB, 0, 1, 3))
        elif t == 3:
            rect(f, k, dibujo(rom, 0xA726, 0, 1, 3))
        elif t == 4:
            rect(f, k, dibujo(rom, 0xA74C, 0, 1, 3))
        elif t == 7:
            rom.pon(13, 14, 15)
            rect(f, k, [[rom[0xA772 + 4 * r + q] for q in range(4)] for r in range(3)])
    if m == 1:
        rom.pon(7, 8, 9)
        for k in range(13):
            if rom[0xA6EB + 2 * k] == m and rom[0xA6EC + 2 * k] == n:
                a = 0xA705 + 5 * k
                f, c = casilla(rom[a], rom[a + 1])
                rect(f, c, [[0x9A, 0x9B]] * rom[a + 2])
        rom.pon(1, 2, 3)
        i = 0x9DDA
        while rom[i]:
            if rom[i] == n:
                f, c = casilla(rom[i + 2], rom[i + 3])
                rom.pon(1, 2, 3)
                rect(f, c, [[rom[0x73D2], rom[0x73D3]], [rom[0x73D4], rom[0x73D5]]])
            i += 4
    if m == 1:
        rom.pon(1, 2, 3)
        for i in range(9):
            if rom[0x9990 + i] == n:
                f, c = casilla(rom[0x9999 + 2 * i], rom[0x999A + 2 * i])
                rect(f, c, [[rom[0x6CC7 + 4 * r + q] for q in range(4)] for r in range(3)])
    if (m, n) in BLOQUES_F0:
        a = BLOQUES_F0[(m, n)] - 0xED80
        rect(a // 32, a % 32, [[0xF0] * 4] * 3)
    return fuera


def _en_lista(rom, tabla, m, n):
    rom.pon(13, 14, 15)
    i = rom.palabra(tabla + 2 * m)
    while rom[i]:
        if rom[i] == n:
            return True
        i += 1
    return False


def animados(rom, m, n):
    """Los caracteres que el juego anima mientras se esta en la sala, y que por
    eso cambian en la VRAM de un cuadro a otro: {(tercio, caracter): que}.

      - el agua (p15:BD06): las salas de 0xBCD3 + 2 x mapa giran los dibujos
        del caracter 0xB6 de los tercios 1 y 2 (0x2DB0 y 0x35B0)
      - el ciclo de colores (p15:BDA1): las de 0xBD72 + 2 x mapa reescriben los
        colores del 0xB8 del tercio 2 (0x15C0-0x15C4, tabla 0xBDCE)
    """
    fuera = {}
    if _en_lista(rom, 0xBCD3, m, n):
        fuera[(1, 0xB6)] = fuera[(2, 0xB6)] = "dibujo"
    if _en_lista(rom, 0xBD72, m, n):
        fuera[(2, 0xB8)] = "color"
    return fuera


def es_especial(rom, m, n):
    """La sala especial de cada mundo (p02:8EEF): 0x8F0A + mapa - 2 da la sala
    y 0x8F14 + mapa - 2 lo que va a 0xE690. Con 0xE690 puesto p00:514D salta
    todo el montaje (p00:5561 tambien lo mira): la sala queda NEGRA."""
    if m < 2:
        return False
    rom.pon(1, 2, 3)
    return rom[0x8F0A + m - 2] == n and n != 0


def nombres_con_objetos(rom, m, n):
    """La tabla de nombres de la sala con las tinajas, los objetos que se
    pintan con caracteres (los de ficha sin el bit 7: puertas...) y las
    piezas (ver piezas)."""
    if es_especial(rom, m, n):
        return [[0] * 32 for _ in range(20)]
    t = nombres(rom, m, n)
    for f, c, ch in piezas(rom, m, n):
        if 0 <= f < 20 and 0 <= c < 32:
            t[f][c] = ch
    if m == 1:
        for fy, fx in tinajas(rom, n):
            for dy, dx, c in ((0, 0, 0xBA), (0, 1, 0xBB), (1, 0, 0xBC), (1, 1, 0xBD)):
                if 0 <= fy - 4 + dy < 20 and fx + dx < 32:
                    t[fy - 4 + dy][fx + dx] = c
    for tipo, b7, y, x in objetos(rom, m, n):
        fi = ficha_de_tipo(rom, tipo)
        if fi[0] & 0x80:                    # sprite
            continue
        if fi[0] & 0x40:
            # p01:6E4E -> 6F2C, que elige con el tercer byte; solo el tipo 4
            # lo tiene, con un 0: p01:6F54, una columna de (ix+14) caracteres
            # (0 al entrar) y un 0x99 debajo
            if fi[2] == 0 and 0 <= y // 8 - 4 < 20:
                t[y // 8 - 4][x // 8] = 0x99
            continue
        if fi[1] >= 61:
            continue
        c, f, cs = mosaico(rom, fi[1])
        for k, ch in enumerate(cs):
            fy, fx = y // 8 - 4 + k // c, x // 8 + k % c
            if ch and 0 <= fy < 20 and 0 <= fx < 32:
                t[fy][fx] = ch
    return t
