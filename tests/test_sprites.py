#!/usr/bin/env python3
"""La tabla de dibujos de sprite que monta tools/sprites.py es la del juego.

tests/huellas_sprites.json guarda, de cada sala volcada en openMSX, el sha1
de los bytes de 0x1800-0x1FFF que escribe la carga de la sala (tools/
sprites.py saca). Aqui el modelo carga cada sala desde la ROM y tiene que dar
la misma huella. tests/poses_openmsx.txt guarda lo que p01:73E4 escribe del
jugador en openMSX (tools/omsx_poses.tcl): sprites.atributos_del_jugador
tiene que dar lo mismo. Necesita la ROM.
"""
import json
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "galious.rom")
HUELLAS = os.path.join(RAIZ, "tests", "huellas_sprites.json")
# sha1 de 0x1800-0x18FF en openMSX tras pulsar F2 (work/v_f2/v0101_760.vram)
F2_SHA1 = "c27353b2e46c2fefd91ad17f1d82449800dcee78"


class TestSprites(unittest.TestCase):
    def setUp(self):
        self.assertTrue(os.path.exists(ROM), "falta galious.rom en la raiz del repo")

    def test_todas_las_salas_contra_openmsx(self):
        import mapas as M
        import sprites as S
        import vram as V
        rom = V.Rom(ROM)
        esperadas = json.load(open(HUELLAS))
        todas = {"%d:%d" % (m, n) for m in range(1, 12) for n in range(1, M.n_salas(rom.d, m) + 1)}
        self.assertEqual(set(esperadas), todas, "faltan o sobran salas en las huellas")
        malas = []
        for k, h in esperadas.items():
            m, n = map(int, k.split(":"))
            if S.huella(S.tabla_de_sala(rom, m, n).v, S.escritos(rom, m, n)) != h:
                malas.append(k)
        self.assertEqual(malas, [], "salas cuyos sprites el modelo no carga como openMSX")

    def test_poses_del_jugador_contra_openmsx(self):
        import sprites as S
        import vram as V
        rom = V.Rom(ROM)
        cab = [0xE000, 0xE500, 0xE501, 0xE502, 0xE53D, 0xE505, 0xE507, 0xE523, 0xE533, 0xE604]
        n = 0
        malas = []
        for linea in open(os.path.join(RAIZ, "tests", "poses_openmsx.txt")):
            if linea.startswith("#"):
                continue
            a, b = linea.split("|")
            ram = dict(zip(cab, (int(x, 16) for x in a.split())))
            escrito = [int(x, 16) for x in b.split()]
            espera = [x for e in S.atributos_del_jugador(rom, ram.__getitem__) for x in e]
            n += 1
            if escrito[:len(espera)] != espera:
                malas.append(linea.strip())
        self.assertGreater(n, 100)
        self.assertEqual(malas, [], "poses que el modelo no escribe como openMSX")

    def test_f2_carga_otros_dibujos(self):
        """p00:5917: con F2 (estado 9) el rle de 0xBF16 (banco 15) va a 0x1800;
        en openMSX (work/v_f2, sala 1:1) da los mismos 256 bytes."""
        import hashlib
        import sprites as S
        import vram as V
        rom = V.Rom(ROM)
        v = S.tabla_de_sala(rom, 1, 1)
        rom.pon(10, 11, 15)
        v.rle(0xBF16, 0x1800)
        self.assertEqual(hashlib.sha1(bytes(v.v[0x1800:0x1900])).hexdigest(), F2_SHA1)


if __name__ == "__main__":
    unittest.main()
