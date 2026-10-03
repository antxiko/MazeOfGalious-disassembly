#!/usr/bin/env python3
"""Los bytes de cada hueco sin explicar de un banco (uso: bytes_huecos.py <banco> [max])."""
import os
import re
import subprocess
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
from paginas import ORG  # noqa: E402

b = int(sys.argv[1])
tope = int(sys.argv[2]) if len(sys.argv) > 2 else 64
out = subprocess.run([sys.executable, os.path.join(RAIZ, "tools", "presupuesto.py"),
                      os.path.join(RAIZ, "work"), os.path.join(RAIZ, "src")],
                     capture_output=True, text=True).stdout
d = open(os.path.join(RAIZ, "galious.rom"), "rb").read()
for m in re.finditer(r"p%02d 0x([0-9A-F]+)\.\.0x([0-9A-F]+)" % b, out):
    a, f = int(m.group(1), 16), int(m.group(2), 16) + 1
    o = b * 0x2000 + a - ORG[b]
    print("%04X-%04X %4d  %s%s" % (a, f, f - a, d[o:o + min(f - a, tope)].hex(), "..." if f - a > tope else ""))
