# The code

## Everything runs in the interrupt

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

## The dispatcher

p00:4140 is Konami's dispatcher: the table of destinations sits **right after
the `call`**. It pops the return address, which is the table's base, and
jumps to destination number A. The listing marks each of those tables as data
and names their destinations.

## The game states

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

## A room

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

## The figures

Figures live at 0xE800, 32 bytes each: type at (ix+0), its step at (ix+1),
and each type's entry (p04:67BB) gives its pattern and colour. Banks 4, 5 and
6 hold how each type moves. Patterns do not belong to each type but to each
room: all its figures share the sprite set the room loads.

## The bosses

A boss is not a sprite: it is a **mosaic** of characters drawn on the screen
and swapped for another to move it (61 mosaics at 0x9E0A in bank 14).
p00:5856 loads its graphics from 0xE0D3, which is each map's boss (0x5E05 +
map). World 3's goes in steps (0xE61B): seven entries at p10:617C, one per
frame, and then, if bit 5 of 0xE709 is set, the 37 copies at p10:621A.

## The sound

It is all in bank 13, and the interrupt calls it every frame. There are **23
tunes** (0x743E, six bytes each: one pointer per PSG channel) and **48
effects** (0x73DC). p13:6197 reads the scores, which live in bank 14: notes,
rests, jumps, calls and repeats. The boss tune speeds up when the boss is low
on life.

## How the listing is made

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
