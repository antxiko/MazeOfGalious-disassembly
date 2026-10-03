#!/usr/bin/env python3
"""Las musicas y los efectos de sonido, recorridos como el interprete del banco 13.

p00:4E6B arranca una musica (A = 0x80 + n): 6 bytes de la tabla 0x743E, los
tres canales del PSG. p00:4F12 un efecto (A = 1..0x7F): la palabra A de la
tabla 0x73DC. Las dos tablas estan en el banco 13, que p00:4E45 pone en
0x6000 (y el 14 en 0x8000) antes de llamar.

Partitura de un canal (p13:6197):
  00-BF  nota (1 byte)          C0-CF  silencio (1)       D0-DF  (ix+3) (1)
  E0-EF  E8 y EC llevan 1 byte mas; EA salta a [dir]; ED llama a [dir] y
         EE vuelve; el resto, 1 byte
  F0-FD  1 byte mas (p13:6385)  FE  repite: [veces][dir]  FF  acaba
Efecto (p13:64C2):
  FF acaba; FE repite [veces][dir]; 2x [duracion] y, si x >= 8, dos bytes
  mas para los registros 12 y 11; 1x dos bytes; el resto, 1 byte mas.

Uso: sonido.py resumen
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TAM = 0x2000
S13 = (13, 14, 15)
MUSICAS = 0x743E
EFECTOS = 0x73DC


def lee(rom, a):
    b = S13[(a - 0x6000) // TAM]
    return rom[b * TAM + (a & 0x1FFF)]


def palabra(rom, a):
    return lee(rom, a) | lee(rom, a + 1) << 8


def recorre_partitura(rom, a, tocados):
    pend, vistos = [a], set()
    while pend:
        i = pend.pop()
        while i not in vistos:
            vistos.add(i)
            c = lee(rom, i)
            if c == 0xFF:
                tocados.add(i)
                break
            if c == 0xFE:
                tocados.update(range(i, i + 4))
                pend.append(palabra(rom, i + 2))
                i += 4
                continue
            if c == 0xEA:
                tocados.update(range(i, i + 3))
                pend.append(palabra(rom, i + 1))
                break
            if c == 0xED:
                tocados.update(range(i, i + 3))
                pend.append(palabra(rom, i + 1))
                i += 3
                continue
            if c == 0xEE:
                tocados.add(i)
                break
            n = 2 if c in (0xE8, 0xEC) or 0xF0 <= c <= 0xFD else 1
            tocados.update(range(i, i + n))
            i += n


def recorre_efecto(rom, a, tocados):
    pend, vistos = [a], set()
    while pend:
        i = pend.pop()
        while i not in vistos:
            vistos.add(i)
            c = lee(rom, i)
            if c == 0xFF:
                tocados.add(i)
                break
            if c == 0xFE:
                tocados.update(range(i, i + 4))
                pend.append(palabra(rom, i + 2))
                i += 4
                continue
            if c & 0xF0 == 0x20:
                n = 4 if c >= 0x28 else 2
            elif c & 0xF0 == 0x10:
                n = 3
            else:
                n = 2
            tocados.update(range(i, i + n))
            i += n


def musicas(rom):
    """[(n, (canal A, B, C))] mientras los punteros caigan en el banco 13 o 14."""
    fuera = []
    k = 0
    while True:
        p = [palabra(rom, MUSICAS + 6 * k + 2 * c) for c in range(3)]
        if not all(0x6000 <= x < 0xA000 for x in p) or MUSICAS + 6 * k >= 0x8000:
            break
        fuera.append((k, p))
        k += 1
    return fuera


def efectos(rom):
    return [(k, palabra(rom, EFECTOS + 2 * k)) for k in range(1, (MUSICAS - EFECTOS) // 2)]


def tramos(dirs):
    fuera = []
    for a in sorted(dirs):
        if fuera and a == fuera[-1][1]:
            fuera[-1][1] = a + 1
        else:
            fuera.append([a, a + 1])
    return fuera


def main(argv):
    rom = open(os.path.join(RAIZ, "galious.rom"), "rb").read()
    m = musicas(rom)
    print("%d musicas, %d efectos" % (len(m), len(efectos(rom))))
    t = set()
    for k, p in m:
        for x in p:
            recorre_partitura(rom, x, t)
    for k, p in efectos(rom):
        recorre_efecto(rom, p, t)
    for a, f in tramos(t):
        print("  %04X..%04X %5d" % (a, f, f - a))


if __name__ == "__main__":
    main(sys.argv)
