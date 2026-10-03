#!/usr/bin/env python3
"""Los jefes que dibuja tools/personajes.py son los de openMSX.

tests/jefes_openmsx.txt guarda lo medido en partida (tools/omsx_partida.tcl
con GO_JEFE=1): que mosaicos toma cada jefe (0xE70A) y la huella de los
caracteres de los mosaicos vistos enteros. Aqui se comparan con
personajes.MOSAICOS_DEL_JEFE y con los graficos de vram.graficos_del_jefe.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "galious.rom")
MEDIDO = os.path.join(RAIZ, "tests", "jefes_openmsx.txt")


def huella(v, chs):
    h = hashlib.sha1()
    for c in sorted(chs):
        for t in range(3):
            o = t * 0x800 + c * 8
            h.update(bytes(v[0x2000 + o:0x2008 + o]) + bytes(v[o:o + 8]))
    return h.hexdigest()[:16]


class TestJefes(unittest.TestCase):
    def setUp(self):
        self.assertTrue(os.path.exists(ROM), "falta galious.rom en la raiz del repo")
        self.lineas = [l.split() for l in open(MEDIDO) if l.strip() and not l.startswith("#")]

    def test_mosaicos_de_cada_jefe(self):
        import personajes as P
        medido = {int(l[1]): tuple(int(x) for x in l[2:]) for l in self.lineas if l[0] == "mosaicos"}
        self.assertEqual(medido, P.MOSAICOS_DEL_JEFE)

    def test_graficos_contra_openmsx(self):
        import vram as V
        rom = V.Rom(ROM)
        hs = [l for l in self.lineas if l[0] == "huella"]
        self.assertEqual(len(hs), 18)
        for _, m, k, h, e in hs:
            m, k, e = int(m), int(k), int(e[5:], 16)
            v = V.carga_sala(rom, V.Vram(rom), m, rom[0x5DFB + m])
            V.graficos_del_jefe(rom, v, rom[0x5E05 + m], e)
            chs = set(V.mosaico(rom, k)[2]) - {0}
            self.assertEqual(huella(v.v, chs), h, "jefe del mapa %d, mosaico %d" % (m, k))


if __name__ == "__main__":
    unittest.main()
