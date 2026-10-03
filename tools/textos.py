#!/usr/bin/env python3
"""Los textos que suben por la pantalla (p01:6B40), leidos del banco 15.

p01:6ACA pone 0xA84A en 0xF020 y p01:6AC5 pone 0xAE28. Cada linea es
[columna][largo][caracteres]; 0xFB delante calla la musica (p01:6B4E), 0xFD
[n] espera n pasos, 0xFE es una linea vacia y 0xFF acaba. Las letras son de
dos medias filas: cada linea va dos veces, la de arriba con la letra en
codigos impares (A = 0x0B, B = 0x0D...) y la de abajo con uno menos.

Uso: textos.py
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TAM = 0x2000
S = (1, 2, 15)
INICIOS = ((0xA84A, "p01:6ACA"), (0xAE28, "p01:6AC5"))


def lee(rom, a):
    return rom[S[(a - 0x6000) // TAM] * TAM + (a & 0x1FFF)]


SIGNOS = {0x3F: ".", 0x41: ",", 0x43: "©", 0x45: "'", 0x03: "1", 0x05: "7", 0x07: "8", 0x09: "9"}


def letra(c):
    if c == 0:
        return " "
    if c in SIGNOS:
        return SIGNOS[c]
    if 0x0B <= c <= 0x3D and c % 2 == 1:
        return chr(ord("A") + (c - 0x0B) // 2)
    return "{%02X}" % c


def recorre(rom, a):
    """[(columna, codigos)] y la direccion de despues del 0xFF."""
    lineas, i = [], a
    while True:
        c = lee(rom, i)
        i += 1
        if c == 0xFB:
            c = lee(rom, i)
            i += 1
        if c == 0xFF:
            return lineas, i
        if c == 0xFD:
            lineas.append(("espera", lee(rom, i)))
            i += 1
            continue
        if c == 0xFE:
            lineas.append(("vacia", 0))
            continue
        n = lee(rom, i)
        lineas.append((c, [lee(rom, i + 1 + k) for k in range(n)]))
        i += 1 + n


MENSAJES = 0xB09E      # p02:9505, con el banco 15 en 0xA000 (p02:94FB)


def mensajes(rom):
    """[(n, direccion, destino, codigos con 0xFE de salto de linea, fin)]: la
    tabla 0xB09E, una palabra por mensaje hasta el primero de ellos."""
    w = lambda a: lee(rom, a) | lee(rom, a + 1) << 8
    n = (w(MENSAJES) - MENSAJES) // 2
    fuera = []
    for k in range(n):
        p = w(MENSAJES + 2 * k)
        i, cod = p + 2, []
        while lee(rom, i) != 0xFF:
            cod.append(lee(rom, i))
            i += 1
        fuera.append((k, p, w(p), cod, i + 1))
    return fuera


def letra_normal(c):
    """La fuente de los mensajes: 0x01-0x0A las cifras, 0x0B-0x24 las letras."""
    if c == 0:
        return " "
    if c == 0xFE:
        return " / "
    if 0x01 <= c <= 0x0A:
        return str(c - 1)
    if 0x0B <= c <= 0x24:
        return chr(ord("A") + c - 0x0B)
    return "{%02X}" % c


def main(argv):
    rom = open(os.path.join(RAIZ, "galious.rom"), "rb").read()
    for a, quien in INICIOS:
        lineas, fin = recorre(rom, a)
        print("== 0x%04X-0x%04X (%s)" % (a, fin, quien))
        for k, (c, cod) in enumerate(lineas):
            if c in ("espera", "vacia"):
                print("   [%s %s]" % (c, cod) if c == "espera" else "")
            elif any(x % 2 == 1 or x == 0 for x in cod) and k % 2 == 0:
                print("%s%s" % (" " * c, "".join(letra(x) for x in cod)))


def main_mensajes():
    rom = open(os.path.join(RAIZ, "galious.rom"), "rb").read()
    for k, p, dest, cod, fin in mensajes(rom):
        print("%2d 0x%04X -> 0x%04X  %s" % (k, p, dest, "".join(letra_normal(c) for c in cod)))


if __name__ == "__main__" and sys.argv[1:] == ["mensajes"]:
    main_mensajes()
elif __name__ == "__main__":
    main(sys.argv)
