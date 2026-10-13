#!/usr/bin/env python3
"""Piezas distintas de un juego: recorre numeros, descarta las que suenan igual que otra
(misma secuencia de escrituras al PSG) y las casi mudas. Uso (desde el repo):
  python tools/unicas.py DESDE HASTA [MIN_EVENTOS=100] [MAX_S=75]"""
import hashlib
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor_musica as m  # noqa: E402
import musica  # noqa: E402

d, h = int(sys.argv[1], 0), int(sys.argv[2], 0)
minimo = int(sys.argv[3]) if len(sys.argv) > 3 else 100
tope = int(sys.argv[4]) if len(sys.argv) > 4 else 75
rom = open(os.path.join(m.RAIZ, musica.CFG["rom"]), "rb").read()
cfg = dict(musica.CFG, max_s=tope)
vistas = {}
for n in range(d, h + 1):
    try:
        cu, v = m.ejecuta(cfg, rom, n)
    except Exception as e:
        continue
    firma = hashlib.sha1(repr(cu).encode()).hexdigest()
    aud = sum(1 for c in cu for r, x in c if 8 <= r <= 10 and x & 0x1F)
    if firma in vistas:
        print("0x%02X = 0x%02X" % (n, vistas[firma]))
        continue
    vistas[firma] = n
    if aud >= minimo:
        print("0x%02X %6.1f s vuelta %s eventos %d" % (n, len(cu) / cfg.get("hz", 60), v and round(v / 60, 1), aud))
