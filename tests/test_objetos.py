#!/usr/bin/env python3
"""Las tiendas y los objetos de tools/objetos.py son los de openMSX.

Medido en partida (tools/omsx_partida.tcl, sala 06:12, work/v_negra06b,
cuadro 1200): la tienda 0xE690 = 12 ensena un solo articulo, en el hueco del
medio, con los caracteres 0x8E-0x91 y el precio 30 (cifras 04 01 en la fila
de 0xEEAF). Aqui: la ficha de la tienda y la huella de esos cuatro caracteres
(tres tercios) cargados como p00:5814 -> p00:58E1.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "galious.rom")
HUELLA_8E_91 = "c1023def0fd9d74a"


class TestObjetos(unittest.TestCase):
    def setUp(self):
        self.assertTrue(os.path.exists(ROM), "falta galious.rom en la raiz del repo")

    def test_tienda_12(self):
        import objetos as O
        import vram as V
        rom = V.Rom(ROM)
        self.assertEqual(O.tiendas(rom)[12], [(30, 0x10)])
        rom.pon(1, 2, 3)
        self.assertEqual(rom[0x5824 + 12], 0x10)     # lo que carga p00:580B (0x4155 desde 0x5824)
        v = V.Vram(rom)
        rom.pon(10, 11, 12)
        v.tercios(rom.palabra(0x6E34 + 2 * 0x10), 0x2470)
        v.tercios(rom.palabra(0x6E80 + 2 * 0x10), 0x0470)
        h = hashlib.sha1()
        for t in range(3):
            for c in range(0x8E, 0x92):
                p, k = v.caracter(t, c)
                h.update(bytes(p) + bytes(k))
        self.assertEqual(h.hexdigest()[:16], HUELLA_8E_91)


if __name__ == "__main__":
    unittest.main()
