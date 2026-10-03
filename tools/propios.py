#!/usr/bin/env python3
"""Para cada hueco sin explicar de un banco, las instrucciones DEL MISMO BANCO
que nombran una direccion de dentro (o el byte de antes), con su contexto.

Uso: propios.py <banco> [minimo] [contexto]
"""
import os
import re
import subprocess
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def huecos(b):
    out = subprocess.run([sys.executable, os.path.join(RAIZ, "tools", "presupuesto.py"),
                          os.path.join(RAIZ, "work"), os.path.join(RAIZ, "src")],
                         capture_output=True, text=True).stdout
    for m in re.finditer(r"p%02d 0x([0-9A-F]+)\.\.0x([0-9A-F]+)" % b, out):
        yield int(m.group(1), 16), int(m.group(2), 16) + 1


def main(argv):
    b = int(argv[1])
    minimo = int(argv[2]) if len(argv) > 2 else 1
    ctx = int(argv[3]) if len(argv) > 3 else 2
    filas = []
    for ln in open(os.path.join(RAIZ, "src", "galious_p%02d.asm" % b), encoding="utf-8"):
        m = re.match(r"\t([a-z][^\t;]*)\t+;([0-9a-f]{4})", ln)
        if m:
            filas.append((int(m.group(2), 16), m.group(1).strip()))
    for a, f in huecos(b):
        if f - a < minimo:
            continue
        print("== p%02d 0x%04X..0x%04X (%d bytes)" % (b, a, f, f - a))
        for k, (pc, t) in enumerate(filas):
            for x in re.findall(r"0([0-9a-f]{4})h", t):
                v = int(x, 16)
                if a - 1 <= v < f:
                    for pc2, t2 in filas[max(0, k - ctx):k + ctx + 1]:
                        print("   %s%04X  %s" % (">" if pc2 == pc else " ", pc2, t2))
                    print("   --")


if __name__ == "__main__":
    main(sys.argv)
