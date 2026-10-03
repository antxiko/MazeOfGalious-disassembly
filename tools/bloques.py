#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Casi siempre es una llamada a uno de los lectores del
banco 0, y el trazador de cartucho entero (tools/bancos.py) sabe, para cada
llamada, que valen HL y DE y que bancos hay en cada ranura. Con eso:

  1. se coge el puntero que el lector va a leer;
  2. el banco al que cae sale del reparto de ese momento, no de suponerlo;
  3. el final sale de RECORRER el formato como lo recorre el lector, o de la
     cuenta que le pasa quien llama (B, BC), leida en el listado.

Los lectores del banco 0 (The Maze of Galious es MSX1: SCREEN 2, la VRAM por
los puertos del VDP o por la BIOS):

  rle      0x5C46  DE fuente, HL destino en la VRAM: 0x00 acaba; 0x80 trae
                   otro destino (dos bytes, 0x5C40 los lee); 0x81-0xFF, van tal
                   cual los n&0x7F bytes que siguen; 0x01-0x7F, se repite el
                   byte que viene esas veces.
           0x5C49  lo mismo sin volver a poner la direccion de escritura.
           0x5C40  lo mismo, con el destino delante.
           0x5BFC  el mismo rle tres veces, una por tercio de la pantalla.
  rle00    0x5C0C  tramos de rle separados por un 0; dos 0 seguidos acaban;
                   lo mismo en los tres tercios.
  lista    0x5C25  [destino] y bytes; 0xFE trae otro destino, 0xFF acaba.
                   0x5C3C recorre lo mismo escribiendo ceros (borra).

Lo que sale se escribe, banco a banco, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque algo esta mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import re
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from bancos import traza_completa, Cartucho                  # noqa: E402
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre        # noqa: E402

ROM = os.path.join(RAIZ, "galious.rom")
SRC = os.path.join(RAIZ, "src")
WORK = os.path.join(RAIZ, "work")

INI = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"


class FueraDelBanco(Exception):
    pass


def banco_de(a, s):
    b = Cartucho.banco(a, s)
    if b is None or b >= N_PAGINAS:
        raise FueraDelBanco("0x%04X no cae en el cartucho con %s" % (a, s))
    return b


def byte(rom, s, a):
    return rom[banco_de(a, s) * TAM_PAGINA + (a & 0x1FFF)]


def palabra(rom, s, a):
    return byte(rom, s, a) | (byte(rom, s, a + 1) << 8)


def trozos(s, a, f):
    """[a, f) de la ventana del Z80, partido por bancos: [(banco, ini, fin)]."""
    fuera = []
    while a < f:
        corte = min(f, (a & 0xE000) + TAM_PAGINA)
        fuera.append((banco_de(a, s), a, corte))
        a = corte
    return fuera


# ------------------------------------------------------------------ registro
class Bloques:
    """{banco: {(ini, fin): {"nom", "que", "desde": set, "ancho"}}}"""

    def __init__(self):
        self.d = defaultdict(dict)
        self.avisos = []

    def anota(self, s, a, f, nom, que, quien, ancho=16):
        if a < 0xC000 < f:
            # p00:54E4: el ultimo dibujo se sale del cartucho y lo que falta
            # lo lee de la RAM de 0xC000 en adelante
            que += "; se sale de la ventana del cartucho: los ultimos %d bytes los lee "                    "de la RAM, de 0xC000 a 0x%04X" % (f - 0xC000, f - 1)
            f = 0xC000
        for b, i, j in trozos(s, a, f):
            e = self.d[b].setdefault((i, j), {"nom": nom if i == a else "%s_cola" % nom,
                                              "que": que, "desde": set(), "ancho": ancho})
            e["desde"].add(quien)
            if i != a:
                e["que"] = "%s (sigue del banco anterior, 0x%04X)" % (que, a)


# ------------------------------------------------------------------ listado
_LISTADO = {}


def listado(p):
    """[(dir, texto)] de las instrucciones del listado del banco p."""
    if p not in _LISTADO:
        ruta = os.path.join(SRC, "galious_p%02d.asm" % p)
        filas = []
        for ln in open(ruta, encoding="utf-8"):
            m = re.match(r"\t([a-z][^\t;]*)\t+;([0-9a-f]{4})", ln)
            if m:
                filas.append((int(m.group(2), 16), m.group(1).strip()))
        _LISTADO[p] = filas
    return _LISTADO[p]


def num(txt):
    txt = txt.strip()
    if txt.endswith("h"):
        return int(txt[:-1], 16)
    return int(txt, 0)


def registro_antes(p, pc, reg, hasta=10):
    """El valor constante de B, C o BC cargado justo antes de pc, o None.

    Se miran hacia atras las instrucciones del listado; si alguna otra toca el
    registro antes de encontrar su `ld`, no se sabe.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    for a, t in reversed(filas[max(0, idx - hasta):idx]):
        if t.startswith(("call", "jp", "jr", "ret", "djnz")):
            return None
        m = re.match(r"ld (bc|b|c),([0-9a-f]+h|\d+)$", t)
        if m:
            r, v = m.group(1), num(m.group(2))
            if r == reg:
                return v
            if r == "bc":
                return {"b": v >> 8, "c": v & 0xFF}.get(reg)
            continue
        if re.match(r"(ld|inc|dec|pop|ex|exx|add|sub|and|or|xor)\b.*\b%s\b" % reg[0], t) and reg != "bc":
            if re.match(r"ld [^,]+,%s$" % reg, t):
                continue            # solo lo lee
            return None
    return None


def tabla_antes(p, pc):
    """Si pc lee su puntero de una tabla indexada, la base de esa tabla.

    El patron es el de siempre en este cartucho: `ld hl,TABLA / call 0x4061
    (hl += a) / ld e,(hl) / inc hl / ld d,(hl)` y, a lo sumo, un `ld hl,nn`
    o `ex de,hl` antes del lector.
    """
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    txt = [t for _, t in filas[max(0, idx - 8):idx]]
    for k in range(len(txt)):
        m = re.match(r"ld hl,([0-9a-f]+h)$", txt[k])
        if not m:
            continue
        # entre el `ld hl` y el `call 0x4061` puede ir el calculo del indice
        # (`ld a,(0xD000) / add a,a`), que no toca HL
        for j in range(k + 1, min(k + 4, len(txt) - 3)):
            if txt[j] in ("call L_4061", "call 04061h", "call hl_mas_a"):
                if txt[j + 1] == "ld e,(hl)" and txt[j + 2] == "inc hl" and txt[j + 3] == "ld d,(hl)":
                    return num(m.group(1))
                break
            if "hl" in txt[j] or txt[j].startswith(("call", "jp", "jr")):
                break
    return None


def punteros_de_tabla(rom, s, base, limite=None):
    """Las palabras de una tabla de punteros: hasta el primer destino, hasta una
    palabra que no apunte a la ventana del cartucho, o hasta `limite`."""
    ptrs, a = [], base
    tope = limite or base + 512
    while a < tope:
        w = palabra(rom, s, a)
        if not 0x4000 <= w < 0xC000:
            break
        ptrs.append(w)
        a += 2
        if base < min(ptrs) <= a + 1:
            break
        tope = min(tope, min(p for p in ptrs if p > base) if any(p > base for p in ptrs) else tope)
    return ptrs


# ------------------------------------------------------------------ formatos
def fin_rle(rom, s, a, con_destino):
    """Recorre un rle como 0x5C46 / 0x5C40 y devuelve el primer byte de fuera."""
    if con_destino:
        a += 2
    for _ in range(40000):
        n = byte(rom, s, a)
        a += 1
        if n == 0:
            return a
        if n & 0x80:
            k = n & 0x7F
            a += 2 if k == 0 else k
        else:
            a += 1
    raise FueraDelBanco("rle sin fin desde 0x%04X" % a)


def fin_rle00(rom, s, a):
    """0x5C0C: tramos de rle separados por un 0; acaba con dos 0 seguidos."""
    for _ in range(200):
        a = fin_rle(rom, s, a, False)
        if byte(rom, s, a) == 0:
            return a + 1
    raise FueraDelBanco("rle00 sin fin desde 0x%04X" % a)


def fin_lista_vram(rom, s, a):
    """0x5C25: [destino] y bytes; 0xFE trae otro destino; 0xFF acaba."""
    a += 2
    for _ in range(8000):
        c = byte(rom, s, a)
        a += 1
        if c == 0xFF:
            return a
        if c == 0xFE:
            a += 2
    raise FueraDelBanco("lista sin 0xFF desde 0x%04X" % a)


def fin_lista(rom, s, a, paso):
    """Lista de registros de `paso` bytes que acaba en un 0xFF."""
    for _ in range(2000):
        if byte(rom, s, a) == 0xFF:
            return a + 1
        a += paso
    raise FueraDelBanco("lista sin 0xFF desde 0x%04X" % a)


def _n(v):
    return 256 if v == 0 else v


# lector -> (registro de la fuente, como se mide, nombre, que)
LECTORES = {
    0x5C46: ("de", "rle", "rle", "rle a la VRAM (0x5C46)"),
    0x5C49: ("de", "rle", "rle", "rle a la VRAM, siguiendo donde iba (0x5C49)"),
    0x5C40: ("de", "rle+", "rle", "rle a la VRAM con el destino delante (0x5C40)"),
    0x5BFC: ("de", "rle", "rle_tercios", "rle a la VRAM, el mismo en los tres tercios (0x5BFC)"),
    0x5C0C: ("de", "rle00", "rle_tercios", "tramos de rle separados por un 0 y acabados en dos, "
             "los mismos en los tres tercios (0x5C0C)"),
    0x5C25: ("de", "lista", "lista_vram", "[destino] y bytes a la VRAM; 0xFE otro destino, 0xFF "
             "acaba (0x5C25)"),
    0x5C27: ("de", "lista", "lista_vram", "[destino] y bytes a la VRAM; 0xFE otro destino, 0xFF "
             "acaba (0x5C27)"),
    0x5C3C: ("de", "lista", "lista_vram", "la misma lista, que 0x5C3C recorre poniendo ceros (borra)"),
}


def llamadas_a_lectores(rom, t, bl):
    vistos = set()
    for dest, b, pc, s, hl, de in t.llamadas:
        if dest not in LECTORES:
            continue
        reg, como, nom, que = LECTORES[dest]
        a = hl if reg == "hl" else de
        if a is None or not 0x4000 <= a < 0xC000:
            continue
        clave = (dest, b, pc, s, a)
        if clave in vistos:
            continue
        vistos.add(clave)
        quien = "%s:%04X" % (nombre(b), pc)
        if como == "rle":
            f = fin_rle(rom, s, a, False)
        elif como == "rle+":
            f = fin_rle(rom, s, a, True)
        elif como == "rle00":
            f = fin_rle00(rom, s, a)
        elif como == "lista":
            f = fin_lista_vram(rom, s, a)
        elif como.startswith("b*"):
            n = registro_antes(b, pc, "b")
            if n is None:
                bl.avisos.append("%s: no se sabe B para 0x%04X (%04X)" % (quien, dest, a))
                continue
            f = a + _n(n) * int(como[2:])
        elif como == "bc/2":
            w = registro_antes(b, pc, "bc")
            if w is None:
                bl.avisos.append("%s: no se sabe BC para 0x%04X (%04X)" % (quien, dest, a))
                continue
            f = a + _n(w >> 8) * _n(w & 0xFF) // 2
        else:
            f = a + int(como)
        bl.anota(s, a, f, "%s_%04X" % (nom, a), que, quien)



# ------------------------------------------------------------------ listas por IX
def ix_antes(p, pc, hasta=4):
    """El `ld ix,nn` de justo antes de pc, o None."""
    filas = listado(p)
    idx = next((i for i, (a, _) in enumerate(filas) if a == pc), None)
    if idx is None:
        return None
    for a, t in reversed(filas[max(0, idx - hasta):idx]):
        m = re.match(r"ld ix,([0-9a-f]+h)$", t)
        if m:
            return num(m.group(1))
        if "ix" in t or t.startswith(("call", "jp", "jr", "ret")):
            return None
    return None


def caracteres_por_ix(rom, s, a, bl, quien):
    """0x5AB3: fichas de 6 bytes [tercios][dibujos][primer caracter][colores],
    0 acaba. Los bits 0-2 de [tercios] dicen en cuales de los tres tercios
    se escribe (0x1000, 0x0800, 0x0000); [dibujos] y [colores] apuntan a dos
    rle (0x5C46) que van a 0x2000 + 8 x caracter (los dibujos: R4 = 7) y a
    8 x caracter (los colores: R3 = 0x7F), p00:4C5B."""
    i = a
    while byte(rom, s, i) != 0:
        primero = byte(rom, s, i + 3)
        for k, que in ((1, "dibujos"), (4, "colores")):
            p = palabra(rom, s, i + k)
            bl.anota(s, p, fin_rle(rom, s, p, False), "%s_%04X" % (que, p),
                     "los %s de unos caracteres desde el 0x%02X, en rle (0x5C46), que pide la "
                     "ficha 0x%04X" % (que, primero, i), quien)
        i += 6
    bl.anota(s, a, i + 1, "caracteres_%04X" % a,
             "%d fichas de caracteres (0x5AB3): [tercios][dibujos][primer caracter][colores], "
             "6 bytes cada una, y un 0 al final" % ((i - a) // 6), quien, ancho=6)


def copias_por_ix(rom, s, a, bl, quien):
    """0x5A8D: fichas de 4 bytes [de][a][tercios][cuantos], 0 acaba: copia
    caracteres dentro de la VRAM dandoles la vuelta (0x5B08)."""
    i = a
    while byte(rom, s, i) != 0:
        i += 4
    bl.anota(s, a, i + 1, "copias_%04X" % a,
             "%d fichas de copia de caracteres (0x5A8D): [desde][hasta][tercios][cuantos], "
             "4 bytes cada una, y un 0 al final; los copia dados la vuelta (0x5B08)" % ((i - a) // 4),
             quien, ancho=4)


def listas_por_ix(rom, t, bl):
    vistos = set()
    for dest, b, pc, s, hl, de in t.llamadas:
        if dest not in (0x5AB3, 0x5A8D):
            continue
        a = ix_antes(b, pc)
        if a is None or (dest, a, s) in vistos:
            continue
        vistos.add((dest, a, s))
        quien = "%s:%04X" % (nombre(b), pc)
        (caracteres_por_ix if dest == 0x5AB3 else copias_por_ix)(rom, s, a, bl, quien)



# ------------------------------------------------------------------ los mapas
def mapas(rom, t, bl):
    """Los bloques, las salas y las vecinas (tools/mapas.py los lee igual)."""
    import mapas as M
    S = M.S789
    usados = set()
    for m in range(1, 12):
        n = M.n_salas(rom, m)
        a = M.base_mapa(rom, m)
        for r in range(1, n + 1):
            usados |= set(M.sala(rom, m, r))
    maxb = max(usados)
    bl.anota(S, M.BLOQUES, M.BLOQUES + 16 * (maxb + 1), "bloques",
             "%d bloques de 4 x 4 caracteres, 16 bytes cada uno, que p00:5649 copia a la tabla de "
             "nombres de 0xED80 por cada uno de los 40 de la sala; el 0x%02X acaba en los dos "
             "primeros bytes de la tabla 0x6ABE" % (maxb + 1, maxb), "p00:564A", ancho=16)
    bl.anota(S, M.TABLA_MAPAS, M.TABLA_MAPAS + 24, "tabla_de_mapas",
             "12 punteros, uno por mapa (0xE041: 1 el castillo, 2-11 los diez mundos), a las salas de "
             "40 bytes; el 0 son los ultimos bytes del bloque 0xAB (p00:5610)", "p00:5613", ancho=2)
    ini = M.base_mapa(rom, 1)
    fin = M.base_mapa(rom, 11) + 40 * M.n_salas(rom, 11)
    bl.anota(S, ini, fin, "salas",
             "las salas de los 11 mapas, 8 x 5 bloques (40 bytes) cada una, seguidas: el castillo "
             "(147, de 0x6AD6 a 0x81CE, pasando del banco 7 al 8) y los diez mundos desde 0x81CE "
             "(p00:5626)", "p00:564A", ancho=8)
    bl.anota(S, M.TABLA_VECINAS, M.TABLA_VECINAS + 24, "tabla_de_vecinas",
             "12 punteros, uno por mapa, a las vecinas de sus salas (p00:5224); los dos ultimos "
             "son a la vez los 4 bytes de la sala 0 del castillo", "p00:5227", ancho=2)
    vfin = M.base_vecinas(rom, 11) + 4 * (M.n_salas(rom, 11) + 1)
    bl.anota(S, M.TABLA_VECINAS + 24, vfin, "vecinas",
             "las vecinas de cada sala, [arriba][abajo][izquierda][derecha], 0xFF sin salida; las "
             "de la sala n del mapa m en la palabra m de 0xA9EF + 4 x n, y la entrada 0 de cada "
             "mapa es la ultima sala del anterior (p00:5232 las copia a 0xE648)", "p00:5239", ancho=4)



# ------------------------------------------------------------------ la decoracion de las salas
S_10 = (10, 11, 12)


def listas_por_sala(rom, s, tabla, n_mapas, bl, nom, que, quien, mapa0=1, paso=1,
                    acaba=lambda x: x == 0):
    """Tabla de punteros por mapa (0xE041) a n_salas listas seguidas de
    registros de `paso` bytes, cada una acabada en un byte que cumple `acaba`.
    Devuelve el conjunto de primeros bytes de los registros."""
    import mapas as M
    vistos = set()
    fin_tabla = tabla + 2 * (n_mapas + 1)
    bl.anota(s, tabla + 2 * mapa0, fin_tabla, "tabla_%s" % nom,
             "%d punteros, uno por mapa (0xE041) desde el %d, a %s; la tabla se lee desde 0x%04X, "
             "pero el mapa 0 no existe" % (n_mapas + 1 - mapa0, mapa0, que, tabla), quien, ancho=2)
    for m in range(mapa0, n_mapas + 1):
        a = palabra(rom, s, tabla + 2 * m)
        i = a
        for r in range(M.n_salas(rom, m)):
            while not acaba(byte(rom, s, i)):
                vistos.add(byte(rom, s, i))
                i += paso
            i += 1
        bl.anota(s, a, i, "%s_mapa_%d" % (nom, m),
                 "%s del mapa %d: una lista por sala (%d)" % (que, m, M.n_salas(rom, m)),
                 quien, ancho=8)
    return vistos


def decoracion(rom, t, bl):
    """p00:595F: por sala, las piezas de decoracion (0x9737, banco 11); cada
    pieza (0x7C72, banco 10) es una lista de [caracter][rle] acabada en 0 que
    p00:59A6 escribe en la tabla de nombres desde 0x1800 + 8 x caracter, y
    detras ternas [desde][hasta][cuantos] que p00:59BF copia, acabadas en 0xFF."""
    piezas = listas_por_sala(rom, S_10, 0x9737, 11, bl, "decoracion",
                             "las piezas de decoracion de cada sala", "p00:5972")
    primera = min(palabra(rom, S_10, 0x7C72 + 2 * k) for k in piezas)
    n = (primera - 0x7C72) // 2
    bl.anota(S_10, 0x7C72, primera, "tabla_de_piezas",
             "%d punteros a las piezas de decoracion (p00:598D), hasta la primera pieza; la 0 no se "
             "usa (el 0 acaba la lista de la sala) y las salas piden %d distintas, la mas alta la "
             "0x%02X" % (n, len(piezas), max(piezas)), "p00:598D", ancho=2)
    for k in range(1, n):
        a = palabra(rom, S_10, 0x7C72 + 2 * k)
        i = a
        while byte(rom, S_10, i) != 0:
            p = palabra(rom, S_10, i + 1)
            bl.anota(S_10, p, fin_rle(rom, S_10, p, False), "rle_%04X" % p,
                     "rle a la VRAM (0x5C46) de la pieza de decoracion 0x%02X" % k, "p00:59B9")
            i += 3
        i += 1
        while byte(rom, S_10, i) != 0xFF:
            i += 3
        bl.anota(S_10, a, i + 1, "pieza_%02X" % k,
                 "la pieza de decoracion 0x%02X: [caracter][rle] acabadas en 0 (p00:59A6) y "
                 "[desde][hasta][cuantos] acabadas en 0xFF (p00:59BF)%s"
                 % (k, "" if k in piezas else "; NINGUNA SALA LA PIDE"), "p00:59A6")



def listas_por_mapa(rom, s, tabla, primero, n, bl, nom, que, quien):
    """Tabla de n punteros (el primero para el mapa `primero`) a una lista de
    salas por mapa, acabada en 0."""
    bl.anota(s, tabla, tabla + 2 * n, "tabla_%s" % nom,
             "%d punteros, uno por mapa desde el %d, a %s" % (n, primero, que), quien, ancho=2)
    for k in range(n):
        a = palabra(rom, s, tabla + 2 * k)
        if not 0x4000 <= a < 0xC000:
            continue
        i = a
        while byte(rom, s, i) != 0:
            i += 1
        bl.anota(s, a, i + 1, "%s_mapa_%d" % (nom, primero + k),
                 "%s del mapa %d, acabadas en 0" % (que, primero + k), quien, ancho=16)


S4 = (4, 5, 6)


def objetos(rom, t, bl):
    """p04:6000: los objetos y enemigos de cada sala, 0xB5CB (banco 6) por mapa:
    registros de 2 bytes [tipo][sitio] y un byte con los 7 bits bajos a 0 al
    final de cada sala. p04:6091 y p04:6054: dos listas de salas por mapa."""
    listas_por_sala(rom, S4, 0xB5CB, 11, bl, "objetos",
                    "los objetos de cada sala, [tipo][sitio] y un byte con los 7 bits bajos a 0 "
                    "al final (p04:6014)", "p04:6014", paso=2, acaba=lambda x: x & 0x7F == 0)
    listas_por_mapa(rom, S4, 0x60AE, 1, 11, bl, "salas_e610",
                    "las salas en las que p04:6091 pone 0xE610 a 1", "p04:60A1")
    listas_por_mapa(rom, S4, 0x60EE, 0, 11, bl, "salas_e612",
                    "las salas en las que p04:6054 pone 0xE612 a 1 (el 0 y el mapa 11 no tienen)",
                    "p04:6066")



S7 = (7, 8, 9)


def banco9_por_sala(rom, t, bl):
    """Las tablas por sala del banco 9."""
    import mapas as M
    bl.anota(S7, 0xAF0B, 0xAF21, "estado_de_las_salas",
             "11 punteros a la RAM, uno por mapa (p00:5246, p01:6940): el byte de estado de cada sala "
             "(el castillo en 0xE200, sus 147 salas, el mapa 2 en 0xE293...); la palabra 0 de la "
             "tabla son los 0xFF de la ultima vecina", "p00:5249", ancho=2)
    bl.anota(S7, 0xB108, 0xB11E, "tabla_de_entradas",
             "11 punteros, uno por mapa, a un byte por sala (p00:52D0); el puntero va un byte antes "
             "de la sala 1, porque p00:4155 suma la sala tal cual", "p00:52D3", ancho=2)
    fin = M.palabra(rom, S7, 0xB106 + 22) + M.n_salas(rom, 11) + 1
    bl.anota(S7, 0xB11E, fin, "entradas",
             "un byte por sala, los 11 mapas seguidos (p00:52DA): 0 no cambia nada; si no, el nibble "
             "alto + 8 es la Y (0xE505) y el bajo x 16 la X (0xE507) del jugador al entrar", "p00:52DA")
    bl.anota(S7, 0xB25F, 0xB273, "tabla_de_reinicios",
             "10 punteros, uno por mapa del 1 al 10, a las listas de 0xB25D (p01:6922); la del 11 "
             "seria la palabra 0x6A55 que hacen los dos primeros bytes de la lista del castillo "
             "(p01:691F solo descarta el 12)", "p01:6925", ancho=2)
    i = 0xB273
    for m in range(1, 11):
        for r in range(M.n_salas(rom, m)):
            while byte(rom, S7, i) != 0:
                i += 1
            i += 1
    bl.anota(S7, 0xB273, i, "reinicios",
             "por sala, la lista de salas cuyo byte de estado (0xAF09) se pone a 0 al entrar, "
             "acabada en 0; los mapas 1-10 seguidos (p01:6931, p01:694A)", "p01:694A", ancho=16)
    listas_por_sala(rom, S7, 0xA7BC, 11, bl, "figuras_9d1d",
                    "las figuras que p08:9D2A pone en cada sala: [tipo][y:3 bits, x:5 bits] y un 0 al "
                    "final (p08:9D1D)", "p08:9D1D", paso=2)
    bl.anota(S7, 0x9BE6, 0x9BFA, "tabla_de_recuadros_9be2",
             "10 punteros, mapas 2-11, a un recuadro de 8 x 8 caracteres que p00:55CE copia a 0xEE0C "
             "(0xEE4C en el mapa 7) cuando 0xE615 no es 0; solo hay 4 recuadros distintos", "p00:55D4",
             ancho=2)
    bl.anota(S7, 0x9BFA, 0x9CFA, "recuadros_8x8",
             "los 4 recuadros de 8 x 8 caracteres de 0x9BE2 (0x9BFA, 0x9C3A, 0x9C7A y 0x9CBA)",
             "p00:55E8", ancho=8)
    bl.anota(S7, 0xB6FE, 0xB714, "tabla_de_cosas",
             "11 punteros, uno por mapa, a las cosas que hay en las salas (p00:5DCE); la palabra 0 "
             "son los dos ultimos bytes de las listas de 0xB25D", "p00:5DD1", ancho=2)
    i = 0xB714
    for m in range(1, 12):
        while byte(rom, S7, i) != 0:
            i += 3
        i += 1
    bl.anota(S7, 0xB714, i, "cosas",
             "por mapa, las cosas de las salas: [sala][cosa (6 bits) y dos marcas][sitio], 3 bytes "
             "cada una, y un 0 al final (p00:5DD5 busca la de la sala 0xE042); la 0x0C esta en la "
             "sala del jefe de cada mundo (0x5DFC)", "p00:5DD5", ancho=3)
    i = 0xB8A2
    for r in range(M.n_salas(rom, 1)):
        while byte(rom, S7, i) != 0:
            i += 1
        i += 1
    bl.anota(S7, 0xB8A2, i, "castillo_b8a2",
             "solo el castillo: por sala, una lista de bytes [y:3 bits][x:5 bits] acabada en 0 que "
             "p01:6309 convierte en una posicion (0xF002) para p01:632C", "p01:6301", ancho=16)



def partidas(rom, t, bl):
    """Las instrucciones que empiezan al final de un banco y acaban en el
    siguiente. Cada listado se ensambla aparte, asi que en los dos se ponen
    como bytes: la cabeza en uno y la cola en el otro."""
    for b, pc, n in sorted(t.partidas):
        fin_banco = (pc & 0xE000) + TAM_PAGINA
        cab = fin_banco - pc
        s = tuple(b + 1 if ORG[b + 1] == r else (b if ORG[b] == r else 0)
                  for r in (0x6000, 0x8000, 0xA000))
        texto = " ".join("%02X" % rom[b * TAM_PAGINA + (pc & 0x1FFF) + i] for i in range(cab))
        texto += " | " + " ".join("%02X" % rom[(b + 1) * TAM_PAGINA + i] for i in range(n - cab))
        que = ("la instruccion de %s:%04X (%s) empieza al final del banco %d y acaba al principio "
               "del %d, que el cartucho pone siempre a continuacion" % (nombre(b), pc, texto, b, b + 1))
        bl.d[b].setdefault((pc, fin_banco), {"nom": "partida_%04X" % pc, "que": que + ": aqui "
                                             "%s" % ("el primer byte" if cab == 1 else "los %d primeros bytes" % cab),
                                             "desde": {"%s:%04X" % (nombre(b), pc)}, "ancho": 4})
        bl.d[b + 1].setdefault((fin_banco, fin_banco + n - cab),
                               {"nom": "partida_%04X_cola" % pc, "que": que + ": aqui el resto",
                                "desde": {"%s:%04X" % (nombre(b), pc)}, "ancho": 4})



S13 = (13, 14, 15)


def sonido(rom, t, bl):
    """La musica y los efectos (tools/sonido.py los recorre igual)."""
    import sonido as SO
    for a, nom, que in ((0x60EC, "mezclador_0", "p13:60CF"), (0x60F2, "mezclador_1", "p13:60C8"),
                        (0x60F8, "mezclador_2", "p13:60C1"), (0x60FE, "mezclador_3", "p13:60BA")):
        bl.anota(S13, a, a + 6, nom,
                 "tres parejas [and][or], una por canal (0xE1AE), para el registro 7 del PSG "
                 "(p13:60DF); la pide %s" % que, "p13:60DF", ancho=2)
    for a, quien in ((0x62D0, "p13:6224"), (0x62E8, "p13:6219"), (0x6300, "p13:620E")):
        bl.anota(S13, a, a + 24, "notas_%04X" % a,
                 "12 periodos del PSG, uno por nota (el nibble alto del byte de la partitura x 2), "
                 "que %s elige segun 0xE1C5" % quien, "p13:622C", ancho=2)
    envolventes = set()
    for k, a in enumerate((0x65A7, 0x65BF, 0x65D7, 0x65EF, 0x6607, 0x661F)):
        bl.anota(S13, a, a + 24, "instrumento_%d" % (k + 1 if k < 5 else 0),
                 "12 punteros, uno por nota, a la envolvente del instrumento %d ((ix+8), "
                 "p13:627A)" % (k + 1 if k < 5 else 0), "p13:629F", ancho=2)
        for n in range(12):
            envolventes.add(SO.palabra(rom, a + 2 * n))
    t2 = set()
    for e in envolventes:
        SO.recorre_efecto(rom, e, t2)
    for a, f in SO.tramos(t2):
        bl.anota(S13, a, f, "envolventes_%04X" % a,
                 "envolventes de los instrumentos, con el formato de los efectos (p13:64C2)", "p13:64C2")
    m = SO.musicas(rom)
    bl.anota(S13, SO.EFECTOS + 2, SO.MUSICAS, "efectos",
             "%d punteros, uno por efecto de sonido (1-0x%02X), que p00:4F3C lee con el banco 13 en "
             "0x6000" % (len(SO.efectos(rom)), len(SO.efectos(rom))), "p00:4F44", ancho=2)
    bl.anota(S13, SO.MUSICAS, SO.MUSICAS + 6 * len(m), "musicas",
             "%d musicas (0x80-0x%02X), tres punteros cada una: los canales A, B y C (p00:4EAE)"
             % (len(m), 0x80 + len(m) - 1), "p00:4EB6", ancho=6)
    t3 = set()
    for k, p in m:
        for x in p:
            SO.recorre_partitura(rom, x, t3)
    for a, f in SO.tramos(t3):
        bl.anota(S13, a, f, "partituras_%04X" % a,
                 "partituras de las musicas (p13:6197): notas, silencios y ordenes", "p13:6197")
    t4 = set()
    for k, p in SO.efectos(rom):
        SO.recorre_efecto(rom, p, t4)
    for a, f in SO.tramos(t4):
        bl.anota(S13, a, f, "efectos_%04X" % a, "los efectos de sonido (p13:64C2)", "p13:64C2")
    t5 = set()
    SO.recorre_partitura(rom, 0x7DE5, t5)
    for a, f in SO.tramos(t5):
        bl.anota(S13, a, f, "partitura_7DE5",
                 "la partitura del canal de 0xE193, que p00:500B pone a mano (y p13:6104 toca)", "p00:500E")
    t6 = set()
    SO.recorre_efecto(rom, 0x7DF2, t6)
    for a, f in SO.tramos(t6):
        bl.anota(S13, a, f, "efecto_7DF2",
                 "la envolvente del canal de 0xE178, que p00:50AC pone a mano en 0xE184", "p00:50AF")



def graficos_banco10(rom, t, bl):
    """Las tablas de graficos del banco 10 que se leen con un indice."""
    import mapas as M
    n = (M.n_salas(rom, 1) + 2) // 2
    bl.anota(S_10, 0x60D7, 0x60D7 + n, "zonas_del_castillo",
             "un nibble por sala del castillo (sala / 2 el byte; el bajo las impares) que elige cual "
             "de los 7 juegos de caracteres pone p00:5A1B (%d bytes para las salas 0-%d)" % (n, 2 * n - 1),
             "p00:5A0E", ancho=16)
    for tabla, lector, quien in ((0x6157, caracteres_por_ix, "p00:5860"),
                                 (0x6202, copias_por_ix, "p00:5869")):
        bl.anota(S_10, tabla + 2, tabla + 24, "tabla_%04X" % tabla,
                 "11 punteros (0xE0D3 = 1-11; la palabra 0 no es un puntero) a fichas de %s"
                 % ("caracteres (0x5AB3)" if lector is caracteres_por_ix else "copia (0x5A8D)"),
                 quien, ancho=2)
        for k in range(1, 12):
            lector(rom, S_10, palabra(rom, S_10, tabla + 2 * k), bl, quien)
    for tabla, que, quien in ((0x6E34, "dibujos", "p00:58F3"), (0x6E80, "colores", "p00:5901")):
        bl.anota(S_10, tabla + 14, tabla + 2 * 0x2D, "tabla_%s_de_cosas" % que,
                 "38 punteros a los %s de las cosas 7-0x2C, en rle a los tres tercios (0x5BFC); "
                 "p00:58E4 descarta las de fuera" % que, quien, ancho=2)
        for k in range(7, 0x2D):
            p = palabra(rom, S_10, tabla + 2 * k)
            bl.anota(S_10, p, fin_rle(rom, S_10, p, False), "%s_cosa_%02X" % (que, k),
                     "los %s de la cosa 0x%02X, rle a los tres tercios (0x5BFC)" % (que, k), quien)



def textos_que_suben(rom, t, bl):
    import textos as TX
    m = TX.mensajes(rom)
    bl.anota(TX.S, TX.MENSAJES, TX.MENSAJES + 2 * len(m), "tabla_de_mensajes",
             "%d punteros, uno por mensaje (p02:9505); si la BIOS no es japonesa (los 4 bits bajos "
             "de 0x002B) p02:94F8 suma 0x20: 0-0x13 en japones, 0x20-0x33 en ingles" % len(m),
             "p02:9508", ancho=2)
    bl.anota(TX.S, m[0][1], max(x[4] for x in m), "mensajes",
             "los mensajes: [direccion en la copia de la tabla de nombres] y caracteres; 0xFE baja "
             "una linea (0x20 mas), 0xFF acaba (p02:9512); varios punteros comparten mensaje",
             "p02:9512", ancho=16)
    for a, quien in TX.INICIOS:
        _, fin = TX.recorre(rom, a)
        nom = "epilogo_y_creditos" if a == 0xA84A else "historia"
        bl.anota(TX.S, a, fin, nom,
                 "el texto que sube por la pantalla (%s, p01:6B40): por linea [columna][largo] y "
                 "letras de dos medias filas (A = 0x0B, de dos en dos; la de abajo, una menos); 0xFB "
                 "calla la musica, 0xFD [n] espera, 0xFE linea vacia, 0xFF acaba (tools/textos.py)"
                 % ("el epilogo y los creditos" if a == 0xA84A else "la historia del principio"),
                 quien, ancho=16)



S_1_14_15 = (1, 14, 15)


def mosaicos(rom, t, bl):
    """Los dibujos hechos con caracteres de fondo (jefes y otros), que p01
    copia a la copia de la tabla de nombres con los bancos 1-14-15 puestos."""
    S = S_1_14_15
    n = (palabra(rom, S, 0x9E0A) - 0x9E0A) // 2
    bl.anota(S, 0x9D90, 0x9D90 + 2 * n, "tamanos_de_mosaico",
             "%d parejas [ancho][alto] en caracteres, una por mosaico (p01:6EAB, (ix+0x0A))" % n,
             "p01:6EAF", ancho=2)
    bl.anota(S, 0x9E0A, 0x9E0A + 2 * n, "tabla_de_mosaicos",
             "%d punteros a los mosaicos (p01:6D61 y otros, (ix+0x0A)); los 20, 21 y 22 (6 x 12) "
             "apuntan donde el 23 (2 x 2)" % n, "p01:6D64", ancho=2)
    for k in range(n):
        a = palabra(rom, S, 0x9E0A + 2 * k)
        c, f = byte(rom, S, 0x9D90 + 2 * k), byte(rom, S, 0x9D91 + 2 * k)
        bl.anota(S, a, a + c * f, "mosaico_%02d" % k,
                 "el mosaico %d: %d x %d caracteres por filas (p01:6D87; el 0 no se pinta)" % (k, c, f),
                 "p01:6D87", ancho=c if c <= 16 else 16)
    for tabla, quien, que in ((0xA6FB, "p01:7272", "5 punteros a dibujos de filas de (ix+8) "
                               "caracteres (p01:727C)"),
                              (0xA726, "p01:72C6", "4 punteros a dibujos de 3 filas de 1 o 3 caracteres "
                               "(p01:72DA)"),
                              (0xA74C, "p01:72B1", "4 punteros a dibujos de 3 filas de 1 o 3 caracteres "
                               "(p01:72DA)"),
                              (0xA77E, "p01:6F90", "24 punteros a tiras de (ix+0x1F) caracteres "
                               "(p01:6FA6; en el mapa 10 se les resta 0x22, p01:6FAC)")):
        k = 0
        ptrs = []
        while True:
            p = palabra(rom, S, tabla + 2 * k)
            if not tabla < p < 0xA84A or (ptrs and tabla + 2 * k >= min(ptrs)):
                break
            ptrs.append(p)
            k += 1
        bl.anota(S, tabla, tabla + 2 * len(ptrs), "tabla_%04X" % tabla, que, quien, ancho=2)
        bl.anota(S, min(ptrs), {0xA6FB: 0xA726, 0xA726: 0xA74C, 0xA74C: 0xA772,
                                0xA77E: 0xA84A}[tabla], "dibujos_%04X" % tabla,
                 "los dibujos de la tabla 0x%04X, seguidos" % tabla, quien, ancho=16)
    bl.anota(S, 0xA772, 0xA77E, "dibujo_A772",
             "3 filas de 4 caracteres que p01:731A copia a (0xEA24)", "p01:7310", ancho=4)



def rellenos(rom, t, bl):
    """Los 0xFF con los que acaban algunos bancos: ni se ejecutan ni se leen."""
    for b in range(N_PAGINAS):
        blq = rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
        n = len(blq) - len(blq.rstrip(bytes([0xFF])))
        if b == 9:
            n -= 1          # el 0xFF de p09:BFE8 acaba el ultimo mensaje (p02:9938)
        if n >= 16:
            a = ORG[b] + TAM_PAGINA - n
            bl.d[b].setdefault((a, ORG[b] + TAM_PAGINA), {
                "nom": "relleno_%s" % nombre(b),
                "que": "relleno: %d bytes 0xFF hasta el final del banco, sin nada que los lea ni "
                       "los ejecute" % n, "desde": set(), "ancho": 16})



S1 = (1, 2, 3)


def tablas_del_despachador(rom, t, bl):
    """Las tablas de destinos pegadas detras de cada `call 0x4140`.

    Las mide tools/bancos.py (hasta el destino mas bajo, o lo que diga
    src/tablas.txt) y ya estan en el .nocode para que el trazador no entre;
    aqui se declaran como datos, con cuantos destinos tienen.
    """
    for (b, pc), (tab, n, dest, ss) in sorted(t.tablas.items()):
        if not n:
            continue
        bl.anota(ss, tab, tab + 2 * n, "tabla_%04X" % tab,
                 "%d destinos del despachador de 0x4140 (call en %s:%04X): %s"
                 % (n, nombre(b), pc, ", ".join("0x%04X" % w for w in dest[:8])
                    + (" ..." if n > 8 else "")),
                 "%s:%04X" % (nombre(b), pc), ancho=2)


def cabecera(rom, t, bl):
    """0x4000-0x404F: la cabecera AB y la que lee el Konami Game Master."""
    bl.anota(S1, 0x4000, 0x4010, "cabecera_ab",
             "la cabecera del cartucho: 'AB', INIT (0x4095) y STATEMENT, DEVICE y TEXT a cero",
             "la BIOS", ancho=16)
    bl.anota(S1, 0x4010, 0x4050, "cabecera_de_konami",
             "la cabecera de Konami que lee el Game Master desde la otra ranura: 'CD', 0x07 0x49 "
             "(RC-749) y, detras, direcciones de la RAM del juego (0xE0FE, 0xE104, 0xE1C6...); el "
             "propio cartucho no la lee", "el Game Master", ancho=8)


RECORRIDOS = [partidas, llamadas_a_lectores, listas_por_ix, mapas, decoracion, objetos, banco9_por_sala, sonido, graficos_banco10, textos_que_suben, mosaicos, rellenos, tablas_del_despachador, cabecera]


# ------------------------------------------------------------------ escritura
def ocupado(p):
    """bytearray del banco: 1 = codigo trazado, 2 = D escrita fuera de la seccion."""
    o = ORG[p]
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(WORK, nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - o, b - o):
                    m[i] = 1
    notas = os.path.join(SRC, nombre(p) + ".notes")
    dentro = False
    if os.path.exists(notas):
        for ln in open(notas, encoding="utf-8"):
            if ln.startswith(INI):
                dentro = True
            elif ln.startswith(FIN):
                dentro = False
            elif not dentro and ln.startswith("D "):
                q = ln.split(None, 3)
                for i in range(max(0, int(q[1], 0) - o), min(TAM_PAGINA, int(q[2], 0) - o)):
                    m[i] = 2
    return m


def une(bloques_banco):
    """Los que se solapan se juntan en uno: dos juegos que comparten dibujos."""
    fuera = []
    for (a, f), e in sorted(bloques_banco.items()):
        if fuera and a < fuera[-1][1]:
            pa, pf, pe = fuera[-1]
            fuera[-1] = (pa, max(pf, f), pe + [(a, f, e)])
        else:
            fuera.append((a, f, [(a, f, e)]))
    return fuera


def linea_d(a, f, partes):
    e0 = partes[0][2]
    desde = sorted({d for _, _, e in partes for d in e["desde"]})
    if len(partes) == 1:
        txt = e0["que"]
    else:
        txt = "%s; se solapan %d bloques (%s)" % (
            e0["que"], len(partes),
            ", ".join("0x%04X-0x%04X" % (x, y) for x, y, _ in partes[:6]))
    desde = [d for d in desde if d != "nadie"]
    if desde:
        txt += "; lo leen %s" % ", ".join(desde[:8])
    if len(desde) > 8:
        txt += " y %d mas" % (len(desde) - 8)
    txt += " (%d bytes)" % (f - a)
    return ["D 0x%04X 0x%04X %s  %s" % (a, f, e0["nom"], txt), "F 0x%04X %d" % (a, e0["ancho"])]


def escribe(p, lineas):
    ruta = os.path.join(SRC, nombre(p) + ".notes")
    viejas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else []
    nuevas, dentro, puesto = [], False, False
    for ln in viejas:
        if ln.startswith(INI):
            dentro = True
            if lineas:
                nuevas += [INI] + lineas + [FIN]
            puesto = True
            continue
        if ln.startswith(FIN):
            dentro = False
            continue
        if not dentro:
            nuevas.append(ln)
    if not puesto and lineas:
        while nuevas and not nuevas[-1].strip():
            nuevas.pop()
        nuevas += ["", INI] + lineas + [FIN, ""]
    open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas).rstrip("\n") + "\n")


def main(argv):
    rom = open(ROM, "rb").read()
    t, _ = traza_completa(rom, SRC)
    bl = Bloques()
    for r in RECORRIDOS:
        try:
            r(rom, t, bl)
        except FueraDelBanco as e:
            bl.avisos.append("%s: %s" % (r.__name__, e))
    total = 0
    for p in range(N_PAGINAS):
        m = ocupado(p)
        buenas, conflictos = [], []
        for a, f, partes in une(bl.d.get(p, {})):
            marcas = set(m[i - ORG[p]] for i in range(a, f))
            if marcas == {2}:
                continue
            pisa = marcas - {0}
            if pisa:
                conflictos.append("  %s 0x%04X-0x%04X (%s) pisa %s" % (
                    nombre(p), a, f, partes[0][2]["nom"],
                    " y ".join({1: "codigo trazado", 2: "una D escrita a mano"}[x] for x in sorted(pisa))))
                continue
            buenas.append((a, f, partes))
        n = sum(f - a for a, f, _ in buenas)
        total += n
        if buenas or conflictos:
            print("%s: %d bloques, %d bytes%s" % (nombre(p), len(buenas), n,
                                                  ", %d en conflicto" % len(conflictos) if conflictos else ""))
            for c in conflictos:
                print(c)
        if "--escribe" in argv:
            lineas = []
            for a, f, partes in buenas:
                lineas += linea_d(a, f, partes)
            escribe(p, lineas)
    print("en total: %d bytes en bloques que lee el codigo" % total)
    if bl.avisos:
        print("%d avisos:" % len(bl.avisos))
        for x in sorted(set(bl.avisos))[:80]:
            print("  " + x)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
