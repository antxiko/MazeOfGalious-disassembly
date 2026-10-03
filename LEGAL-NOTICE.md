# Legal notice and attribution

*(También disponible [en castellano](AVISO-LEGAL.md).)*

## Who owns what

**The game is not ours.** *The Maze of Galious* (*Knightmare II*) was published by
**Konami** for the MSX in 1987; its catalogue number is **RC-749** and it is
128 KB. All rights over the game remain with their holders.

**What is ours** are this repository's tools, the comments in the listing, the
analysis and the documentation. That is published under the licence in
`LICENSE`.

## What is in this repository

The files `src/galious_pNN.asm` are the commented disassembly of the
cartridge's sixteen banks. They are published for the **preservation, study
and documentation** of a title that is part of MSX software history.

The cartridge image (`.rom`) is **not** distributed here. Anyone who wants to
rebuild the listing has to supply their own, and the `Makefile` checks its
sha256 before doing anything.

The pictures in `docs/imagenes/` are neither illustrations brought in from
outside nor captures: they are drawn by reading the cartridge's own tables, at
the addresses the listing gives, and checked against openMSX dumps. They are
part of the proof that the reading of the binary is right: if it were wrong,
they would come out as noise.

## What it rests on

Everything stated here comes from reading this binary or from measuring it
running, and each claim carries its evidence next to it: the instruction that
reads a datum, the table that ends where it has to end, or the emulator dump.
What is not settled is said not to be.

This cartridge carries Konami's hidden mark at the end of bank 3
(`tools/marca_konami.py`). The format of that mark was discovered by Manuel
Pazos, and he is thanked for it.

## If you are one of the authors

If you worked on *The Maze of Galious* or hold rights over the game, and you would
rather this material were not published, **say so and it comes down, no
argument**. The intent of this work is the opposite of harming you: it is to
put on record how it was made.
