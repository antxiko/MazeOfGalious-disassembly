#!/usr/bin/env python3
"""La regla banco -> direccion del MegaROM, compartida por todas las herramientas.

The Maze of Galious (Konami, RC-749, 1987) es un cartucho de 128 KB con el mapper
Konami SIN SCC (Konami4): 16 bancos de 8 KB. El banco de 0x4000-0x5FFF es FIJO
-no hay registro para el- y los otros tres se eligen escribiendo el numero de
banco en 0x6000 (para 0x6000-0x7FFF), 0x8000 (para 0x8000-0x9FFF) y 0xA000
(para 0xA000-0xBFFF).

Lo que dice la ROM (tools/reconocimiento.py lo vuelve a medir cada vez):
  - NO hay ni una escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, que son los
    registros del mapper con SCC.
  - Los trios se meten con `ld a,N` / `inc a` / `inc a` (p00:416C..41E7):
    1-2-3, 4-5-6, 7-8-9, 10-11-12 y 13-14-15 llenan de golpe 0x6000-0xBFFF.
    De ahi sale la tabla: el banco 3k+1 va a 0x6000, el 3k+2 a 0x8000 y el
    3k+3 a 0xA000.
  - Ninguna excepcion: las 32 escrituras con banco conocido lo ponen en su
    ranura (las otras 4 devuelven el que habia, leido de la copia en RAM).

Uso como programa:
    paginas.py org <n>               imprime el org del banco n
    paginas.py lista                 imprime "n org" para los 16
    paginas.py corta <rom> <dir>     escribe <dir>/pNN.bin con cada banco
"""
import os
import sys

TAM_PAGINA = 0x2000
N_PAGINAS = 16

# banco -> direccion de ejecucion. Medido, no supuesto: ver reconocimiento.py.
ORG = {0: 0x4000}
for _b in range(1, 16):
    ORG[_b] = (0x6000, 0x8000, 0xA000)[(_b - 1) % 3]

# Escrituras al mapper que ponen un banco fuera de su ranura, medidas en
# reconocimiento.py: (banco, pc de la escritura) -> ranura.
EXCEPCIONES = {}

# Todos los bancos los selecciona alguien: aqui no hay ninguno huerfano.
NUNCA_MAPEADOS = ()


def org(p):
    """Direccion en la que se ejecuta el banco p."""
    return ORG[p]


def nombre(p):
    """Nombre del modulo del banco p: p00..p15."""
    return "p%02d" % p


def main(argv):
    if len(argv) < 2:
        sys.exit(__doc__)
    if argv[1] == "org":
        print("%#06x" % org(int(argv[2], 10)))
    elif argv[1] == "lista":
        for p in range(N_PAGINAS):
            print("%d %#06x" % (p, org(p)))
    elif argv[1] == "corta":
        rom, dst = argv[2], argv[3]
        d = open(rom, "rb").read()
        if len(d) != TAM_PAGINA * N_PAGINAS:
            sys.exit("la ROM mide %d bytes y no %d" % (len(d), TAM_PAGINA * N_PAGINAS))
        os.makedirs(dst, exist_ok=True)
        for p in range(N_PAGINAS):
            with open(os.path.join(dst, nombre(p) + ".bin"), "wb") as f:
                f.write(d[p * TAM_PAGINA:(p + 1) * TAM_PAGINA])
        print("16 bancos de %d bytes en %s/" % (TAM_PAGINA, dst))
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
