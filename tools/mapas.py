#!/usr/bin/env python3
"""Los mapas de The Maze of Galious leidos de sus tablas.

Lo que hay (medido en el codigo, ver las notas):
  - 0xE041 es el mapa (1 el castillo, 2-11 los diez mundos) y 0xE042 la sala,
    que empieza en 1.
  - p00:560D: la sala son 8 x 5 bloques (40 bytes) desde la palabra 0xE041 de
    la tabla 0x6ABE (bancos 7-8-9), sala n en base + (n-1) x 40. Las salas del
    castillo van seguidas desde 0x6AD6 y pasan del banco 7 al 8.
  - p00:5649: cada bloque son 4 x 4 caracteres, 16 bytes desde 0x6000 + 16 x n
    (banco 7), y van a la copia de la tabla de nombres de 0xED80 (fila 4).
  - p00:5221: las vecinas de cada sala, 4 bytes [arriba][abajo][izq][der]
    desde la palabra 0xE041 de la tabla 0xA9EF (banco 9) + 4 x sala; 0xFF no
    hay salida. La entrada 0 de cada mapa es la ultima sala del anterior.

Uso: mapas.py resumen
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = os.path.join(RAIZ, "galious.rom")
TAM = 0x2000

TABLA_MAPAS = 0x6ABE      # bancos 7-8-9 (p00:5610)
TABLA_VECINAS = 0xA9EF    # bancos 7-8-9 (p00:5224)
BLOQUES = 0x6000          # banco 7 (p00:5654)
S789 = (7, 8, 9)


def lee(rom, s, a):
    """Byte de la direccion a con el reparto s en 0x6000/0x8000/0xA000."""
    b = 0 if a < 0x6000 else s[(a - 0x6000) // TAM]
    return rom[b * TAM + (a & 0x1FFF)]


def palabra(rom, s, a):
    return lee(rom, s, a) | lee(rom, s, a + 1) << 8


def base_mapa(rom, m):
    return palabra(rom, S789, TABLA_MAPAS + 2 * m)


def base_vecinas(rom, m):
    return palabra(rom, S789, TABLA_VECINAS + 2 * m)


def n_salas(rom, m):
    """Las salas de un mapa: hasta donde empieza el siguiente en la tabla de
    vecinas (la entrada 0 del siguiente es la ultima de este).

    El mapa 11 es el ultimo y no tiene siguiente: son 6 salas. La 6 no tiene
    salidas (sus vecinas, 0xAF07, son FF FF FF FF) y estan su dibujo (40 bytes
    en 0x9BBE, detras de la sala 5), su lista de decoracion (p11:9A13) y la
    de objetos (p06:BFC3), cada una la sexta de su mapa.
    """
    if m == 11:
        return 6
    return (base_vecinas(rom, m + 1) - base_vecinas(rom, m)) // 4


def sala(rom, m, n):
    """Los 40 bloques de la sala n del mapa m."""
    a = base_mapa(rom, m) + (n - 1) * 40
    return [lee(rom, S789, a + i) for i in range(40)]


def vecinas(rom, m, n):
    a = base_vecinas(rom, m) + 4 * n
    return [lee(rom, S789, a + k) for k in range(4)]


def bloque(rom, k):
    return [lee(rom, S789, BLOQUES + 16 * k + i) for i in range(16)]


def main(argv):
    rom = open(ROM, "rb").read()
    if len(argv) > 1 and argv[1] == "resumen":
        maxb = 0
        for m in range(1, 12):
            n = n_salas(rom, m)
            usados = set()
            for r in range(1, n + 1):
                usados |= set(sala(rom, m, r))
            maxb = max(maxb, max(usados))
            print("mapa %2d: %3d salas desde 0x%04X, vecinas 0x%04X, %d bloques distintos (max 0x%02X)"
                  % (m, n, base_mapa(rom, m), base_vecinas(rom, m), len(usados), max(usados)))
        print("bloque mas alto: 0x%02X" % maxb)
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
