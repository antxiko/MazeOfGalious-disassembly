#!/usr/bin/env python3
"""Las salas que dibuja tools/vram.py son las que pone el juego.

tests/huellas_salas.json guarda, de cada sala volcada en openMSX (tools/
omsx_mundos.tcl), el sha1 de su tabla de nombres y el de los dibujos y colores
de los caracteres que usa (tools/huellas.py). Aqui el modelo monta cada sala
desde la ROM y tiene que dar las dos huellas iguales. Necesita la ROM: si no
esta, falla (como test_cartucho.py).
"""
import json
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "galious.rom")
HUELLAS = os.path.join(RAIZ, "tests", "huellas_salas.json")


class TestMapas(unittest.TestCase):
    def setUp(self):
        self.assertTrue(os.path.exists(ROM), "falta galious.rom en la raiz del repo")

    def test_todas_las_salas_contra_openmsx(self):
        import huellas as H
        import mapas as M
        import vram as V
        rom = V.Rom(ROM)
        esperadas = json.load(open(HUELLAS))
        todas = {"%d:%d" % (m, n) for m in range(1, 12) for n in range(1, M.n_salas(rom.d, m) + 1)}
        self.assertEqual(set(esperadas), todas, "faltan o sobran salas en las huellas")
        malas = [k for k, h in esperadas.items()
                 if list(H.de_modelo(rom, *map(int, k.split(":")))) != h]
        self.assertEqual(malas, [], "salas que el modelo no dibuja como openMSX")

    def test_salas_por_mapa(self):
        import mapas as M
        rom = open(ROM, "rb").read()
        self.assertEqual([M.n_salas(rom, m) for m in range(1, 12)],
                         [147, 15, 15, 16, 17, 18, 19, 20, 21, 27, 6])


if __name__ == "__main__":
    unittest.main()
