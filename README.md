# The Maze of Galious — a commented disassembly

*(También disponible [en castellano](README.es.md).)*

A commented disassembly of ***The Maze of Galious*** (*Knightmare II*),
Konami, 1987, cartridge **RC-749** for the **MSX**: a 128 KB MegaROM with
Konami's mapper without SCC, sixteen 8 KB banks.

**The website**: https://antxiko.github.io/MazeOfGalious-disassembly/

| | |
|---|---|
| explained | 100% (53,613 bytes of code, 77,459 of data) |
| commented | 40.1% of the instructions |
| routines | 3,423, none below 10% |
| reassembly | the ROM, byte for byte |
| pictures | drawn from the ROM and checked against openMSX |

## What is here

- The listing of the sixteen banks (`src/galious_pNN.asm`), generated from the
  binary and the notes, which reassembles the exact ROM.
- The castle and the ten worlds, all 321 rooms, built from the cartridge's
  tables and laid out by their neighbours.
- Popolon and Aphrodite, each room's sprite sets, the ten bosses, the 47
  items and the shops.
- The checks against openMSX, in the tests (`make test`).

## How to reproduce it

You need Python 3 (with Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
and **your own cartridge image** as `galious.rom` at the root:

```
sha256  420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280
make
```

The details, in [Getting started](docs/GETTING-STARTED.md).

## Notice

The game belongs to Konami; only the analysis, the comments and the tools are
here. The ROM is not distributed. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
