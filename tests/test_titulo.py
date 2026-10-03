#!/usr/bin/env python3
"""El logotipo de Konami y el titulo de tools/titulo.py son los de openMSX.

tests/titulo_openmsx.txt guarda la huella de la VRAM entera volcada en
openMSX (tools/omsx_titulo.tcl); aqui se compara con la que monta el modelo.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "galious.rom")
MEDIDO = os.path.join(RAIZ, "tests", "titulo_openmsx.txt")


def huella(v):
    o = bytearray(v)
    for i in range(0x3B10, 0x3B80):
        if i & 3:
            o[i] = 0
    return hashlib.sha1(bytes(o)).hexdigest()


class TestTitulo(unittest.TestCase):
    def setUp(self):
        self.assertTrue(os.path.exists(ROM), "falta galious.rom en la raiz del repo")
        self.medido = dict(l.split() for l in open(MEDIDO) if l.strip() and not l.startswith("#"))

    def test_logotipo(self):
        import titulo as T
        import vram as V
        self.assertEqual(huella(T.logotipo(V.Rom())[0].v), self.medido["logotipo"])

    def test_titulo(self):
        import titulo as T
        import vram as V
        self.assertEqual(huella(T.titulo(V.Rom())[0].v), self.medido["titulo"])

    def test_mutacion_sin_rotulo(self):
        """Sin el rotulo de 0x933F la huella ya no casa."""
        import titulo as T
        import vram as V
        v = T.titulo(V.Rom())[0].v
        v[0x3829:0x3829 + 14] = bytes(14)
        self.assertNotEqual(huella(v), self.medido["titulo"])


if __name__ == "__main__":
    unittest.main()
