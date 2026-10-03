# Getting started

To reproduce this disassembly you need Python 3 (with Pillow for the
pictures), GNU make and [Pasmo](https://pasmo.speccy.org/). The cartridge
image **is not in this repository**: bring your own.

```
galious.rom   131,072 bytes
sha256        420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280
```

With the file at the root of the repository:

```
make            # listing, verification, consistency and tests
```

## What each step does

| command | what it does |
|---|---|
| `make comprueba` | checks the ROM's sha256 |
| `make reconoce` | the header and the 32 mapper writes, with their bank |
| `make semillas` | traces the whole cartridge and writes each bank's entries and tables |
| `make listado` | generates the sixteen `.asm` files from the binary, the notes and the seeds |
| `make verify` | reassembles each bank and the whole ROM, and compares the sha256 |
| `make sanity` | checks that no data is read as code and that no byte is left unassigned |
| `make test` | the tests, with the checks against openMSX |
| `make densidad` | how many instructions carry a comment, bank by bank |
| `make imagenes` | draws the PNGs in `docs/imagenes/` from the ROM |
| `make web` | generates the HTML pages and checks the links |

`make verify` is the one that decides: at the end it has to print `OK: la ROM
entera reproducible byte a byte`.

The tests compare what is drawn from the ROM with the fingerprints of the
openMSX dumps stored in `tests/`. The dumps are not in the repository; they
are made again with the launchers in [In the emulator](IN-THE-EMULATOR.md).

## Where everything is

- `src/galious_pNN.asm`: the listing, one per bank. **It is generated**: do
  not edit it by hand.
- `src/pNN.notes`: the labels (`L`), line comments (`C`), data ranges (`D`)
  and routine headers (`B`). This **is** edited.
- `tools/anotaciones.py`: the names of the routines and of the RAM.
- `src/pNN.entries` and `src/pNN.nocode`: each bank's entries and the tables
  that are not code, from the trace of the whole cartridge (`make semillas`);
  `src/semillas.txt` and `src/tablas.txt`, the ones added by hand.
- `tools/`: the tracer, the listing generator and the tools that draw
  (`vram.py`, `dibuja.py`, `titulo.py`, `personajes.py`, `objetos.py`).
- `docs/`: this site, in English at the root and in Spanish in `docs/es/`.
