#!/usr/bin/env python3
"""La tabla de dibujos de sprite (0x1800-0x1FFF, R6 = 3) de cada sala, como
la llena p00:592F al entrar:

  p00:5937  rle de 0x790D al destino que dice la palabra 0x790B, y vueltas
            (p00:59BF) de las ternas de 0x7907
  p00:5944  rle 0x7849 -> 0x1E20 y 0x7BB2 -> 0x1F20
  p00:595F  los juegos de sprites de la sala (0x9737 banco 11 -> 0x7C72
            banco 10): [dibujo][rle] acabadas en 0 y ternas
            [desde][hasta][cuantos] acabadas en 0xFF

Vuelta (p00:59BF -> p00:5C6B): el sprite de 16x16 en 0x1800 + 8 x hasta se
copia dado la vuelta a 0x1800 + 8 x desde: la mitad izquierda pasa a la
derecha y al reves, cada byte con los bits al reves; `cuantos` sprites.

Suceso: con el jugador en 0xE500 = 5 (p03:B35E), p00:5832 reescribe 0x1900
con el rle 0x7B34 y las vueltas de 0x7B30 (el caballero hundiendose, 5
cuadros): `hundimiento`.

  python3 tools/sprites.py coteja DIR...   compara con los .vram de openMSX
  python3 tools/sprites.py poses DIR...    el jugador de cada volcado
  python3 tools/sprites.py saca DIR...     tests/huellas_sprites.json: por
        sala, el sha1 de los bytes de 0x1800-0x1FFF que escribe la carga de
        la sala; si sale en varios, manda el ULTIMO DIR (como huellas.py), y
        se saltan los volcados con el jugador en 0xE500 = 5
"""
import glob
import hashlib
import json
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import mapas as M  # noqa: E402
import vram as V  # noqa: E402

BASE = 0x1800


def _rev(b):
    return int("{:08b}".format(b)[::-1], 2)


def vueltas(rom, vram, ix):
    """p00:59BF."""
    v = vram.v
    while rom[ix] != 0xFF:
        dst = BASE + 8 * rom[ix]
        src = BASE + 8 * rom[ix + 1]
        for k in range(rom[ix + 2]):
            s, d = src + 32 * k, dst + 32 * k
            izq = [_rev(b) for b in v[s:s + 16]]
            der = [_rev(b) for b in v[s + 16:s + 32]]
            v[d + 16:d + 32] = bytes(izq)
            v[d:d + 16] = bytes(der)
        ix += 3


def juego(rom, vram, k):
    """p00:5989: el juego de sprites k."""
    rom.pon(10, 11, 12)
    a = rom.palabra(0x7C72 + 2 * k)
    while rom[a]:
        vram.rle(rom.palabra(a + 1), BASE + 8 * rom[a])
        a += 3
    vueltas(rom, vram, a + 1)
    if k == 0x39:
        vram.fichas(0x6365)


def juegos_de_sala(rom, m, n):
    """p00:595F: la lista de juegos de la sala n (desde 1) del mapa m."""
    if m == 0:
        return []
    rom.pon(10, 11, 12)
    a = rom.palabra(0x9737 + 2 * m)
    for _ in range(n - 1):
        while rom[a]:
            a += 1
        a += 1
    r = []
    while rom[a]:
        r.append(rom[a])
        a += 1
    return r


def tabla_de_sala(rom, m, n, vram=None):
    """p00:592F. Devuelve la Vram con 0x1800-0x1FFF llena."""
    vram = vram or V.Vram(rom)
    rom.pon(10, 11, 12)
    vram.rle(0x790D, rom.palabra(0x790B))   # p00:5937 (p00:5C40)
    vueltas(rom, vram, 0x7907)
    vram.rle(0x7849, 0x1E20)                # p00:5944
    vram.rle(0x7BB2, 0x1F20)
    for k in juegos_de_sala(rom, m, n):
        juego(rom, vram, k)
    return vram


def hundimiento(rom, vram):
    """p00:5832."""
    rom.pon(10, 11, 12)
    vram.rle(0x7B34, 0x1900)
    vueltas(rom, vram, 0x7B30)
    return vram


def escritos(rom, m, n):
    """Las posiciones (desde 0x1800) que escribe la carga de la sala: las
    que no cambian si la VRAM empieza llena de 0 o de 0xFF."""
    a = tabla_de_sala(rom, m, n).v
    v2 = V.Vram(rom)
    v2.v[:] = bytes([0xFF]) * 0x4000
    b = tabla_de_sala(rom, m, n, v2).v
    return [i - BASE for i in range(BASE, 0x2000) if a[i] == b[i]]


def huella(v, pos):
    return hashlib.sha1(bytes(v[BASE + i] for i in pos)).hexdigest()


SALIDA = os.path.join(RAIZ, "tests", "huellas_sprites.json")


def saca(dirs):
    rom = V.Rom()
    fuera = {}
    for d in dirs:
        for f in sorted(glob.glob(os.path.join(d, "v[0-9A-F][0-9A-F][0-9A-F][0-9A-F].vram"))):
            b = os.path.basename(f)
            m, n = int(b[1:3], 16), int(b[3:5], 16)
            if not (1 <= m <= 11 and 1 <= n <= M.n_salas(rom.d, m)):
                continue
            if open(f[:-4] + "ram", "rb").read()[0xE500 - 0xC000] == 5:
                continue
            fuera["%d:%d" % (m, n)] = huella(open(f, "rb").read(), escritos(rom, m, n))
    orden = sorted(fuera, key=lambda k: tuple(map(int, k.split(":"))))
    with open(SALIDA, "w") as f:
        json.dump({k: fuera[k] for k in orden}, f, indent=0)
    print("%d salas en %s" % (len(fuera), os.path.relpath(SALIDA, RAIZ)))


def poses_del_jugador(rom):
    """Las 32 poses de p01:7529: listas de (dY, dX, dibujo, color)."""
    rom.pon(1, 2, 3)
    fuera = []
    for i in range(32):
        p = rom.palabra(0x7529 + 2 * i)
        fuera.append([((rom[p + 1 + 4 * k] ^ 0x80) - 0x80, (rom[p + 2 + 4 * k] ^ 0x80) - 0x80,
                       rom[p + 3 + 4 * k], rom[p + 4 + 4 * k]) for k in range(rom[p])])
    return fuera


def atributos_del_jugador(rom, ram):
    """p01:73E4: las entradas [Y][X][dibujo][color] del jugador que van a
    0xEC80, dada la RAM (funcion de direccion -> byte)."""
    est = ram(0xE000)
    pose = ram(0xE53D) if est == 9 else ram(0xE502)
    if pose == 0xFF:
        return []
    sp = poses_del_jugador(rom)[pose]
    fuera = []
    for k, (dy, dx, d, c) in enumerate(sp):
        b = len(sp) - k
        y = (ram(0xE505) + dy - 1) & 0xFF
        if b == 3 and ram(0xE523):
            y = 0xE0                            # p01:7418, sin arma
        if est != 9 and (ram(0xE500) == 4 or ram(0xE533) == 1):
            if not (ram(0xE604) & 2) and b != 2:
                c = 6                           # p01:745C
        elif b == 2 or (b >= 3 and est == 9):
            pass
        elif not (ram(0xE501) & 1):
            c = 9                               # p01:7454, Afrodita
        fuera.append((y, (ram(0xE507) + dx) & 0xFF, d, c))
    return fuera


def coteja_poses(dirs):
    """El jugador de cada volcado: sus entradas tienen que estar en la tabla
    de atributos (0x3B00, el juego la reparte en otro orden) y sus dibujos
    en 0x1800 tienen que ser los del modelo."""
    rom = V.Rom()
    vistos = {}
    for d in dirs:
        for f in sorted(glob.glob(os.path.join(d, "*.vram"))):
            v = open(f, "rb").read()
            ram = open(f[:-4] + "ram", "rb").read()
            r = lambda a: ram[a - 0xC000]       # noqa: E731
            if r(0xE000) not in (2, 9, 14):
                continue
            at = atributos_del_jugador(rom, r)
            sat = {bytes(v[0x3B00 + 4 * i:0x3B04 + 4 * i]) for i in range(32)}
            m, n = r(0xE041), r(0xE042)
            mod = tabla_de_sala(rom, m, n).v if m else None
            # la tabla es la del cuadro anterior: la posicion del jugador ya
            # se ha movido; se mira el dibujo, el color y la posicion de cada
            # sprite RELATIVA al primero
            at = [e for e in at if e[0] != 0xE0]
            mal = []
            if at:
                cand = [e for e in sat if e[0] < 0xD0 and (e[2], e[3]) == (at[0][2], at[0][3])]
                bien = any(all(bytes(((c[0] + e[0] - at[0][0]) & 0xFF, (c[1] + e[1] - at[0][1]) & 0xFF,
                                      e[2], e[3])) in sat for e in at) for c in cand)
                mal = [] if bien else at
            dib = [e[2] for e in at if mod is not None and
                   bytes(mod[BASE + 8 * e[2]:BASE + 8 * e[2] + 32]) != v[BASE + 8 * e[2]:BASE + 8 * e[2] + 32]]
            k = (r(0xE501), r(0xE502) if r(0xE000) != 9 else r(0xE53D), r(0xE500))
            vistos.setdefault(k, [0, 0])
            vistos[k][0] += 1
            if mal or dib:
                vistos[k][1] += 1
                print("%s: %s fuera de la tabla, dibujos distintos %s" % (f, mal, dib))
    for k in sorted(vistos):
        print("personaje %d pose %2d estado %d: %d volcados, %d mal" % (k + tuple(vistos[k])))


def coteja(dirs):
    rom = V.Rom()
    tot = mal = 0
    for d in dirs:
        for f in sorted(glob.glob(os.path.join(d, "v[0-9A-F][0-9A-F][0-9A-F][0-9A-F].vram"))):
            b = os.path.basename(f)
            m, n = int(b[1:3], 16), int(b[3:5], 16)
            real = open(f, "rb").read()[BASE:0x2000]
            mio = tabla_de_sala(rom, m, n).v[BASE:0x2000]
            # lo que la sala no escribe guarda restos de la anterior: un
            # segundo modelo lleno de 0xFF marca los bytes que no se tocan
            v2 = V.Vram(rom)
            v2.v[:] = bytes([0xFF]) * 0x4000
            otro = tabla_de_sala(rom, m, n, v2).v[BASE:0x2000]
            dif = [i for i in range(0x800) if mio[i] == otro[i] and real[i] != mio[i]]
            tot += 1
            if dif:
                mal += 1
                difs = sorted({i // 32 for i in dif})
                print("%s %d:%d  %d bytes en sprites %s" % (d, m, n, len(dif), difs[:12]))
    print("salas %d, con diferencias %d" % (tot, mal))


if __name__ == "__main__":
    if sys.argv[1:2] == ["coteja"]:
        coteja(sys.argv[2:])
    elif sys.argv[1:2] == ["poses"]:
        coteja_poses(sys.argv[2:])
    elif sys.argv[1:2] == ["saca"]:
        saca(sys.argv[2:])
    else:
        sys.exit(__doc__)
