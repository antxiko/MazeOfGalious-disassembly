#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Un test que se salta no comprueba nada y en verde daria la impresion
contraria. Quien clone esto sin poner su copia del cartucho vera fallar este
fichero con un mensaje que dice exactamente que falta; los tests que solo
miran el listado publicado siguen pasando.

Cada una corresponde a una afirmacion de la web o de las notas, y todas leen
el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

from paginas import ORG, TAM_PAGINA, N_PAGINAS, EXCEPCIONES   # noqa: E402

ROM = os.path.join(RAIZ, "galious.rom")
SHA = "420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280"

FALTA = ("falta galious.rom en la raiz del repo. Son los 131.072 bytes de "
         "The Maze of Galious (Konami, RC-749, 1987, MSX), y no se distribuyen "
         "aqui: pon tu copia. El sha256 tiene que ser %s" % SHA)


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(FALTA)
        with open(ROM, "rb") as f:
            cls.rom = f.read()

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x4095 y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        self.assertEqual(self.rom[2] | (self.rom[3] << 8), 0x4095)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_segunda_cabecera_del_game_master(self):
        """0x4010: 'CD', 0x07 y 0x49, o sea RC-749."""
        self.assertEqual(self.rom[0x10:0x14], bytes([0x43, 0x44, 0x07, 0x49]))

    def test_es_msx1_no_cambia_de_modo_por_la_bios(self):
        """Ni un `call 0x005F` (CHGMOD) en los 128 KB: el modo de pantalla lo
        pone el propio cartucho escribiendo los registros del VDP."""
        self.assertNotIn(bytes([0xCD, 0x5F, 0x00]), self.rom)

    def test_mapper_es_konami4(self):
        """Ni una escritura a los registros del mapper CON SCC."""
        for reg in (0x5000, 0x7000, 0x9000, 0xB000):
            pat = bytes([0x32, reg & 0xFF, reg >> 8])
            self.assertNotIn(pat, self.rom,
                             "aparece un ld (%#06x),a: seria Konami5" % reg)
        for reg in (0x6000, 0x8000, 0xA000):
            self.assertIn(bytes([0x32, reg & 0xFF, reg >> 8]), self.rom)

    def test_regla_banco_org(self):
        """Cada banco se mapea en su ranura, salvo la excepcion declarada.

        Se recorren los `ld a,N` seguidos de `ld (reg),a` -con los `inc a` y
        `ld (0xF0F1..3),a` de la copia en RAM en medio-: el
        banco que llega a cada registro tiene que ser de los que
        tools/paginas.py pone en esa ranura, o una EXCEPCION con su sitio.
        """
        regs = (0x6000, 0x8000, 0xA000)
        vistos = {}
        for i in range(len(self.rom) - 5):
            if self.rom[i] != 0x3E:                 # ld a,N
                continue
            j, val = i + 2, self.rom[i + 1]
            while j < len(self.rom) - 2:
                w = self.rom[j + 1] | (self.rom[j + 2] << 8)
                if self.rom[j] == 0x32 and w in regs:
                    if val < N_PAGINAS:
                        b = j // TAM_PAGINA
                        sitio = (b, ORG[b] + j % TAM_PAGINA)
                        vistos.setdefault(val, set()).add((w, sitio))
                    j += 3
                elif self.rom[j] == 0x32 and w in (0xF0F1, 0xF0F2, 0xF0F3):
                    j += 3                          # su copia en RAM
                elif self.rom[j] == 0x3C:           # inc a
                    val += 1
                    j += 1
                elif self.rom[j] in (0x77, 0x2C, 0x23):  # ld (hl),a / inc l / inc hl
                    j += 1
                else:
                    break
        self.assertEqual(sorted(vistos), list(range(1, 16)))
        for banco, rs in sorted(vistos.items()):
            for reg, sitio in rs:
                if ORG[banco] != reg:
                    self.assertEqual(EXCEPCIONES.get((banco, sitio)), reg,
                                     "el banco %d va a %#06x en %s y paginas.py dice %#06x"
                                     % (banco, reg, sitio, ORG[banco]))

    def test_gancho_de_interrupcion(self):
        """INIT engancha 0x40EF en H.KEYI (0xFD9A/0xFD9B) y se queda en `jr $`."""
        pat = bytes([0x3E, 0xC3,                     # ld a,0xC3
                     0x32, 0x9A, 0xFD,               # ld (0xFD9A),a
                     0x21, 0xEF, 0x40,               # ld hl,0x40EF
                     0x22, 0x9B, 0xFD])              # ld (0xFD9B),hl
        self.assertEqual(self.rom[0x00A0:0x00A0 + len(pat)], pat)
        self.assertEqual(self.rom[0x00D1:0x00D3], bytes([0x18, 0xFE]))   # jr $

    def test_la_interrupcion_llama_al_sonido_en_el_banco_13(self):
        """p00:4101 pone los bancos 13 y 14, llama a 0x6004 y devuelve las
        dos ranuras leyendo las copias 0xF0F1 y 0xF0F2."""
        esperado = bytes([0x3E, 0x0D, 0x32, 0x00, 0x60,  # ld a,13 / ld (0x6000),a
                          0x3C, 0x32, 0x00, 0x80,        # inc a / ld (0x8000),a
                          0xCD, 0x04, 0x60,              # call 0x6004
                          0xAF, 0x32, 0x06, 0xE0, 0xF3,  # xor a / ld (0xE006),a / di
                          0x3A, 0xF1, 0xF0, 0x32, 0x00, 0x60,
                          0x3A, 0xF2, 0xF0, 0x32, 0x00, 0x80])
        self.assertEqual(self.rom[0x0101:0x0101 + len(esperado)], esperado)

    def test_no_hay_bancos_de_relleno(self):
        """Ningun banco es 0xFF de punta a punta."""
        for b in range(N_PAGINAS):
            blq = self.rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]
            self.assertNotEqual(blq, b"\xff" * TAM_PAGINA)

    def test_despachador_de_konami(self):
        """El despachador esta en 0x4140 (y 0x4050 salta a el): la tabla va
        detras del `call`.

        `pop hl / add a,a / add a,l / ld l,a / jr nc,+1 / inc h / ld a,(hl) /
        inc hl / ld h,(hl) / ld l,a / jp (hl)`.
        """
        self.assertEqual(self.rom[0x0140:0x014C],
                         bytes([0xE1, 0x87, 0x85, 0x6F, 0x30, 0x01, 0x24,
                                0x7E, 0x23, 0x66, 0x6F, 0xE9]))
        self.assertEqual(self.rom[0x0050:0x0053], bytes([0xC3, 0x40, 0x41]))


if __name__ == "__main__":
    unittest.main()
