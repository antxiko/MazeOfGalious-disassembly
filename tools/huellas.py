#!/usr/bin/env python3
"""Huellas de las salas volcadas en openMSX, para que un test compruebe el
modelo (tools/vram.py) sin tener los volcados.

De cada volcado vMMSS.vram se guarda el sha1 de los 640 caracteres de la
tabla de nombres de la sala (0x3880-0x3AFF) y el de los dibujos y colores de
los caracteres que usa, en orden, sin lo que el juego anima (vram.animados).

Uso: huellas.py saca DIR [DIR...]   escribe tests/huellas_salas.json; si una
                                    sala sale en varios, manda el ULTIMO DIR
     huellas.py de_modelo M S       las dos huellas que da el modelo
"""
import glob
import hashlib
import json
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import vram as V  # noqa: E402

SALIDA = os.path.join(RAIZ, "tests", "huellas_salas.json")


def huellas(v, anim):
    """(nombres, caracteres) de una VRAM de 16 KB."""
    nom = bytes(v[0x3880:0x3B00])
    h = hashlib.sha1()
    for terc, c in sorted({((i // 32 + 4) // 8, nom[i]) for i in range(640)}):
        o = terc * 0x800 + c * 8
        que = anim.get((terc, c))
        h.update(bytes([terc, c]))
        h.update(b"-" * 8 if que == "dibujo" else bytes(v[0x2000 + o:0x2000 + o + 8]))
        h.update(b"-" * 8 if que == "color" else bytes(v[o:o + 8]))
    return hashlib.sha1(nom).hexdigest(), h.hexdigest()


def de_modelo(rom, m, n):
    """Las huellas de la sala montada por el modelo."""
    v = V.carga_sala(rom, V.Vram(rom), m, n).v
    t = V.nombres_con_objetos(rom, m, n)
    v[0x3880:0x3B00] = bytes(ch for fila in t for ch in fila)
    return huellas(v, V.animados(rom, m, n))


def saca(dirs):
    rom = V.Rom()
    fuera = {}
    for d in dirs:
        for f in sorted(glob.glob(os.path.join(d, "v*.vram"))):
            k = os.path.basename(f)[1:5]
            m, n = int(k[:2], 16), int(k[2:], 16)
            if m == 0 or n == 0:
                continue
            fuera["%d:%d" % (m, n)] = huellas(open(f, "rb").read(), V.animados(rom, m, n))
    orden = sorted(fuera, key=lambda k: tuple(map(int, k.split(":"))))
    with open(SALIDA, "w") as f:
        json.dump({k: fuera[k] for k in orden}, f, indent=0)
    print("%d salas en %s" % (len(fuera), os.path.relpath(SALIDA, RAIZ)))


def main(argv):
    if len(argv) > 2 and argv[1] == "saca":
        saca(argv[2:])
    elif len(argv) == 4 and argv[1] == "de_modelo":
        print(de_modelo(V.Rom(), int(argv[2]), int(argv[3])))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
