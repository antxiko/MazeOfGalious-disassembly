#!/usr/bin/env python3
"""El orden de las vecinas (arriba, abajo, izquierda, derecha; p03:A7F8) es el
del juego: en openMSX (tests/bordes_openmsx.txt) el personaje sale por los
bordes de las salas sin tocar las vecinas, y llega a la que dice la tabla
(tools/mapas.py vecinas), y las cuatro cargadas en 0xE648 son las de la tabla."""
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
ROM = os.path.join(RAIZ, "galious.rom")


class TestVecinas(unittest.TestCase):
    def test_bordes_contra_openmsx(self):
        import mapas as M
        rom = open(ROM, "rb").read()
        lineas = [l.split() for l in open(os.path.join(RAIZ, "tests", "bordes_openmsx.txt")) if not l.startswith("#")]
        hechas = 0
        for a, b in zip(lineas, lineas[1:]):
            if a[1] != "sale" or b[1] != "llega":
                continue
            m, n = (int(x, 16) for x in a[2].split(":"))
            v = M.vecinas(rom, m, n)
            self.assertEqual([int(x, 16) for x in a[6:10]], v)
            lado = {"i": 2, "d": 3}[a[4]]
            self.assertEqual(int(b[2].split(":")[1], 16), v[lado])
            hechas += 1
        self.assertEqual(hechas, 6)


if __name__ == "__main__":
    unittest.main()
