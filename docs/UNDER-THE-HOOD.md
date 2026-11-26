# Under the hood

## Getting started

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

### What each step does

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
are made again with the launchers in [In the emulator](UNDER-THE-HOOD.html).

### Where everything is

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

## The cartridge

| | |
|---|---|
| title | *The Maze of Galious* (*Knightmare II*; ガリウスの迷宮), Konami, 1987 |
| number | RC-749 |
| machine | MSX1 (TMS9918), SCREEN 2 |
| size | 131,072 bytes: 16 banks of 8 KB |
| mapper | Konami without SCC (Konami4) |
| sound | PSG, three channels |
| sha256 | `420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280` |

The header is `AB` with INIT at 0x4095. At 0x4010 there is a second header,
`CD` followed by 07 49, which is what the Game Master looks for. The game does
not touch any V9938 register: it is an MSX1 game.

### The mapper

Bank 0 is **fixed** at 0x4000-0x5FFF. The other three windows are selected by
writing the bank number to 0x6000, 0x8000 and 0xA000. There is not a single
write to 0x5000, 0x7000, 0x9000 or 0xB000, the registers of the SCC mapper:
that is why it is Konami4.

There are **32 writes** to the mapper (`tools/reconocimiento.py`): 11 to
0x6000, 11 to 0x8000 and 10 to 0xA000. Banks are set three at a time
(p00:416C-0x41E1: 1-2-3, 4-5-6, 7-8-9, 10-11-12 and 13-14-15) or one at a
time, and **all** of them follow the rule: each bank always goes to the same
window. So the listing splits into sixteen modules, each with its `org`:

| window | banks |
|---|---|
| 0x4000 (fixed) | 0 |
| 0x6000 | 1, 4, 7, 10, 13 |
| 0x8000 | 2, 5, 8, 11, 14 |
| 0xA000 | 3, 6, 9, 12, 15 |

The code **crosses banks** in four places: an instruction starts at the end
of one bank and ends in the next (p00:5FFF, p01:7FFE, p04:7FFF and
p08:9FFF); the listing splits each one into two `defb`. The interrupt sets
banks 13 and 14 for the sound and on the way out restores the previous ones
from their copies in RAM (0xF0F1-0xF0F3).

### What each bank holds

| bank | code | what it holds |
|---|---|---|
| 0 | 7,808 B | the start-up, the interrupt, the dispatcher, the game's 21 states, the graphics readers (rle, entries, flipped copies), building the room and what goes on it, the status bar |
| 1 | 7,282 B | the character and its poses, life and experience, the logo and the title, the story, the demos, GAME OVER and ZEUS, the item screen |
| 2 | 7,162 B | the special rooms (hints and shops), the password, the keyboard and the words, the bosses' names, the world doors |
| 3 | 7,644 B | the character in the room: walking, ladders, weapons, water, hits, the pink orbs, the hidden items, the bosses; Konami's mark |
| 4 | 6,452 B | the figures: how each type moves |
| 5 | 7,798 B | more figures and their movement tables |
| 6 | 4,660 B | more figures; the items in each room |
| 7 | — | the rooms of the 11 maps (8 × 5 blocks) and the 172 blocks of 4 × 4 characters |
| 8 | 739 B | the walls and ladders of the worlds; the rest of the rooms and the bosses' frames |
| 9 | 1,873 B | the castle doors; the figures in each room, the neighbours (0xA9EF), the Konami logo |
| 10 | — | the character entries for each place and the 64 sprite sets |
| 11 | — | the sprite patterns and which set each room loads |
| 12 | — | character patterns and colours in rle: the bosses' graphics and the seal in their room |
| 13 | 1,351 B | the **sound**: 23 tunes, 48 effects and the player |
| 14 | — | the music scores, the bosses' mosaics (0x9E0A), the font and the title sign |
| 15 | 844 B | the ending, the water and the boss's smoke; the messages |

In total, **53,613 bytes of code and 77,459 of data**: 100% of the cartridge
accounted for (`make sanity`).

### The VRAM

The game runs in **SCREEN 2** with the registers at 0x4C5B: name table at
0x3800, colours at 0x0000 (R3 = 0x7F), patterns at 0x2000 (R4 = 7), sprite
attributes at 0x3B00 and their patterns at 0x1800. Sprites are 16 × 16. R7
is 0xE4 (blue background) on the logo and 0xE0 (black) afterwards.

The screen is built in a copy in RAM (0xED00) and p00:54F3 uploads it with
LDIRVM. A room takes rows 4 to 23; rows 0 to 3 are the status bar.

### The RAM that matters

| address | what it is |
|---|---|
| 0xE000 / 0xE001 | the game state and its step |
| 0xE003 | the frame counter |
| 0xE020 | the boss's name guessed |
| 0xE027 | ZEUS typed |
| 0xE041 / 0xE042 | the map (1 the castle, 2-11 the worlds) and the room |
| 0xE046 / 0xE048 / 0xE04A | arrows, coins and keys, in BCD |
| 0xE052 / 0xE056 | Aphrodite's and Popolon's life |
| 0xE050 / 0xE054 | Aphrodite's and Popolon's experience |
| 0xE06F + type | each item's flag |
| 0xE0D2 / 0xE0D3 | the boss's state and which boss |
| 0xE500 / 0xE501 | the character's state and who is playing (0 Aphrodite) |
| 0xE690 | the special room (hint or shop) |
| 0xE800 | the figures, 32 bytes each |
| 0xEC80 / 0xED00 | the copies of the sprite table and the name table |

## The code

### Everything runs in the interrupt

INIT (0x4095) also maps the cartridge into page 2, hooks **H.KEYI** (0xFD9A
= `jp 0x40EF`), puts the stack below 0xF0F0, clears the game's RAM
(0xE000-0xF0EF), zeroes the VRAM and the sound, looks for other cartridges in
the slots (p00:5F0C) and sets banks 1-2-3. From then on it sits in a `jr` to
itself (p00:40D1), and the whole game runs in **p00:40EF**, once per frame:

1. If it was already inside (the flag at 0xE006), it only releases the VDP.
2. Whatever VRAM work the current state needs (table 0x543B).
3. The sound, with banks 13 and 14 mapped (p13:6004). Then the game's banks
   come back from 0xF0F1-0xF0F3, and a waiting tune, if any, is requested.
4. If the previous frame has finished (the flag at 0xE005), the **frame's
   game** (p00:4277). Interrupts are opened first, so the sound does not wait
   for the game.

### The dispatcher

p00:4140 is Konami's dispatcher: the table of destinations sits **right after
the `call`**. It pops the return address, which is the table's base, and
jumps to destination number A. The listing marks each of those tables as data
and names their destinations.

### The game states

0xE000 is the state and 0xE001 its step (table at 0x428E):

| state | what it is |
|---|---|
| 0 | the Konami logo |
| 1 | the title |
| 2 | the demo or the story, one round each |
| 3 | the game starts |
| 4 | entering the room |
| 5 | the game |
| 6 | a life ends |
| 7 | GAME OVER, and with ZEUS, F5 to continue |
| 8 | entering a world through its door |
| 9 | the F2 pause |
| 0x0A | moving to the neighbouring room |
| 0x0B | the item screen (F1) |
| 0x0C | reading the room's monument (weapon 6 next to it) |
| 0x0D | back to the castle |
| 0x0E | the special room: a hint or a shop |
| 0x0F | the boss: the name guessed, the smoke and the boss |
| 0x10 | through a door, to the special room at 0xE680 |
| 0x11 | the ending |
| 0x12 | typing the password |
| 0x13 | the boss defeated |
| 0x14 | nine jumps of joy (p03:BE5F) |

States with few steps branch with `djnz` on the step: the first fall-through
is step 1 and the last destination of the chain, step 0. You can see it on
the logo: step 0 prepares it, step 1 draws it and step 2 waits (checked in
openMSX, `tools/omsx_titulo.tcl`).

### A room

On entering a room, the game loads its graphics (p00:568E) and builds the
screen (p00:55C6). `tools/vram.py` does the same, step by step:

1. the font and the status bar (bank 14);
2. the character entries for the place: the common ones (p10:6000), those of
   the castle zone (0x60D7) or those of the worlds (0x6044);
3. the picture of the room's item, if any (0x6E34 and 0x6E80);
4. in the boss room, the seal (p10:6121);
5. the floor plan: the room's 8 × 5 blocks (bank 7), each of 4 × 4
   characters (0x6000 + 16 × block);
6. on top, ladders, doors, items, pink orbs and the animated bits (water and
   colours), with their in-game flags;
7. the room's sprite patterns (p00:592F): the base at 0x790D and the room's
   set.

The 321 rooms built this way give 0 differences against openMSX in the name
table and in the characters they use.

### The figures

Figures live at 0xE800, 32 bytes each: type at (ix+0), its step at (ix+1),
and each type's entry (p04:67BB) gives its pattern and colour. Banks 4, 5 and
6 hold how each type moves. Patterns do not belong to each type but to each
room: all its figures share the sprite set the room loads.

### The bosses

A boss is not a sprite: it is a **mosaic** of characters drawn on the screen
and swapped for another to move it (61 mosaics at 0x9E0A in bank 14).
p00:5856 loads its graphics from 0xE0D3, which is each map's boss (0x5E05 +
map). World 3's goes in steps (0xE61B): seven entries at p10:617C, one per
frame, and then, if bit 5 of 0xE709 is set, the 37 copies at p10:621A.

### The sound

It is all in bank 13, and the interrupt calls it every frame. There are **23
tunes** (0x743E, six bytes each: one pointer per PSG channel) and **48
effects** (0x73DC). p13:6197 reads the scores, which live in bank 14: notes,
rests, jumps, calls and repeats. The boss tune speeds up when the boss is low
on life.

### How the listing is made

- `tools/bancos.py` traces **the whole cartridge** keeping track of which
  bank is in each window. That gives the calls that cross the mapper
  (`src/pNN.entries`) and the dispatcher tables (`src/pNN.nocode`).
- `tools/z80trace.py` follows each bank's flow from those entries.
- `tools/bloques.py` declares the data by walking it like the readers in bank
  0 do (rle, entries, copies, lists, rooms, scores).
- `src/pNN.notes` holds the labels, the comments and the data ranges, anchored
  to addresses. `tools/mkasm.py` merges them with the trace and writes
  `src/galious_pNN.asm`.
- `make verify` reassembles the sixteen banks with Pasmo and the whole ROM,
  and compares the sha256.
- `make sanity` checks that no data is read as code and that not a single
  byte is left unassigned.

The density: **40.1%** of the 25,226 instructions carry a comment, and all
3,423 routines are above 10% (`make densidad`).

## In the emulator

Everything drawn on this site is checked against **openMSX** on a Japanese
MSX1 machine (`C-BIOS_MSX1_JP`). The probes are Tcl scripts that take the
cartridge wherever needed, by poking RAM or pressing real keys, and dump the
VRAM (the first 16 KB) and the RAM. One emulator at a time.

### The probes

| probe | what it does | launcher |
|---|---|---|
| `omsx_titulo.tcl` | the start-up, the logo and the title, one dump every 0.25 s | `lanza_titulo.sh` |
| `omsx_vuelca.tcl` | the demo, on every room change | `lanza_vuelca.sh` |
| `omsx_mundos.tcl` | takes the demo to the requested rooms and dumps each one | `lanza_mundos.sh` |
| `omsx_partida.tcl` | starts a game, goes to a room and dumps it; with the boss, sets 0xE020 as when its name is guessed | `lanza_partida.sh` |
| `omsx_bordes.tcl` | in game, takes the character out through the edges without touching the neighbours | — |
| `omsx_poses.tcl` | what p01:73E4 writes for the player, with Popolon and with Aphrodite | `lanza_poses.sh` |
| `omsx_zeus.tcl` | ZEUS in the F2 pause, GAME OVER and F5 | — |
| `omsx_lecturas.tcl` | who reads each byte of the cartridge | `lanza_lecturas.sh` |
| `omsx_vigila.tcl` | who writes to a stretch of memory | `lanza_vigila.sh` |
| `omsx_puerto99.tcl` | which VRAM addresses are set in a room | `lanza_puerto99.sh` |

To take the character to a room, `omsx_mundos.tcl` puts the map in 0xE041,
the room in the four loaded neighbours (0xE648-0xE64B) and the character on
the right edge (0xE507 = 0xF9): the game itself leaves through the right and
loads the room. 0xE690 and 0xE740 must be cleared; otherwise the special room
flag carries over and the next rooms are not built.

### The checks

The dumps are not in the repository; their fingerprints are, in `tests/`, and
the tests compare them with what is drawn from the ROM:

| test | what it compares | result |
|---|---|---|
| `test_titulo.py` | the logo and the title: all 16 KB of VRAM | 0 bytes different |
| `test_mapas.py` | each room: the name table and the characters it uses | 321 rooms, 0 different |
| `test_sprites.py` | each room's sprite patterns and the player's poses | 321 rooms and 136 combinations, 0 different |
| `test_vecinas.py` | the order of the neighbours, leaving through the edges | 6 exits, 0 different |
| `test_jefes.py` | which mosaics each boss takes and the 18 seen whole | 0 different |
| `test_objetos.py` | shop 12 and its characters | 0 different |

### Tips for watching it

- The Japanese machine shows the messages in Japanese; with
  `C-BIOS_MSX1_EU` they come out in English (p02:94F0 reads byte 0x002B of the
  BIOS).
- openMSX screenshots can come out stale or black with the emulator sped up:
  the check is always done on the VRAM.
- A game starts with space or M on the title (p00:4BFA).
- F1 opens the item screen; F2, the pause (the one with the cup).

## Code shared with other Konami cartridges

This disassembly has been compared, instruction by instruction, with
every other Konami one in the series. A block counts when the same
instructions, at least six of them from a label to its `ret` or its
unconditional jump, are in both cartridges; the addresses are left
aside, because they change from one cartridge to the next. Of the
other 57, **47** have at least one block in common with this one;
these are the ones that share the most:

| Cartridge | Blocks | Instructions | For example (here = there) |
|---|---:|---:|---|
| [Nemesis 2](https://antxiko.github.io/Nemesis2-disassembly/) | 49 | 612 | `lee_caracteres` (p00:5B66) |
| [Salamander - Operation X](https://antxiko.github.io/Salamander-disassembly/) | 41 | 447 | `rle_con_destino` (p00:5C40) = `rachas_con_destino` |
| [Parodius](https://antxiko.github.io/Parodius-disassembly/) | 31 | 343 | `rle_con_destino` (p00:5C40) = `rachas_con_destino` |
| [Nemesis 3 - The Eve of Destruction](https://antxiko.github.io/Nemesis3-disassembly/) | 30 | 312 | `rle_con_destino` (p00:5C40) = `rle_con_direccion` |
| [Nemesis / Gradius](https://antxiko.github.io/Nemesis-disassembly/) | 28 | 380 | `lee_caracteres` (p00:5B66) = `baja_el_caracter_a_la_ram` |
| [Ganbare Goemon! Karakuri Dōchū](https://antxiko.github.io/GanbareGoemon-disassembly/) | 23 | 312 | `paso_de_envolvente` (p13:64B0) = `cuadro_del_efecto` |
| [Vampire Killer](https://antxiko.github.io/VampireKiller-disassembly/) | 22 | 320 | `paso_de_envolvente` (p13:64B0) = `cuenta_del_paso` |
| [Shalom: Knightmare III](https://antxiko.github.io/Shalom-disassembly/) | 21 | 235 | `logotipo_de_konami` (p01:6957) = `rotulo_konami` |
| [King's Valley II](https://antxiko.github.io/KingsValley2-disassembly/) | 19 | 238 | `mando` (p00:4C75) |
| [King Kong 2: Yomigaeru Densetsu](https://antxiko.github.io/KingKong2-disassembly/) | 17 | 197 | `sonido_a_cero` (p00:4DED) = `el_sonido_desde_cero` |

The whole matrix, the 58 cartridges against each other, is on
[The routines](https://antxiko.github.io/MSX-disassembly-database/THE-ROUTINES.html) in the series database, along
with the method and the program that measures it.
