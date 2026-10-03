# Open questions

What is not known, or has been read in the code and not checked in the
emulator.

## What nothing points to

No instruction or word in the ROM points to these pieces. That does not prove
they are unused: a computed address leaves no trace, and that already
happened with the graphics of world 3's boss, which are picked with 0x6175 +
7 × step. None of this has been measured in openMSX:

- **Code:** p00:405F and p00:4077; p02:8153; p03:A871, A904, AAC1, ADF7,
  AE23, B16F and B17E; p06:A1F8, ACE2, ADE5 and B183. The first two are
  entries of a jump vector nobody calls; the rest sit after a `jp`, a `jr` or
  a `ret`.
- **p04:6DC6:** 56 bytes (16 pairs of steps and three orderings of 0-7), the
  same as p05:88FD.
- **p12:B850:** 240 bytes identical, byte for byte, to the rle at 0xB760 (the
  seal in the boss room), right after it.

## Room 94 of the castle

It has no neighbours: no room leads to it and it leads to none. On the map it
goes in the only gap left between 93 and 95, but that is a deduction from the
number, not a neighbour. p04:62A4 uses it as a generator. How to get in, if at
all, has not been seen.

## The demos

The table at p01:7DD9 has five demos. How many actually play, not measured.

## Read in the code, not tried

- **Typing the boss's name.** Seen in openMSX by setting the guessed flag
  (0xE020) by hand; by typing it, no.
- **UMBRELLA**, the **castle digits** with item 0x27, item **0x15 with
  RETURN** and **world 8 without item 0x13**.
- **The castle's hidden items** (p02:9F82) and what each one asks for.
- **The password** (p02:95A0): 43 letters of 5 bits plus 2 of checksum, in 11
  groups of 4 and one of 1, typed in state 0x12 (p02:9716). How that screen
  is reached, not checked.
- **With Knightmare in the other slot** it puts 99 in 0xE05A and 0xE05B;
  p02:908D copies them to 0xE053 and 0xE057 (the life caps). Not tried with
  the cartridge.
- **With the Game Master** it sets bit 2 of 0xF0F8; what p00:5EE6 and
  p00:5F00 do with it, not looked at.

## Not looked at

- **Items 0x12 and 0x14:** 0x12 opens something in room 11 of world 2
  (p08:9F87) and 0x14 makes something be drawn in the castle depending on
  0xE06C (p00:5D24).
- **Each boss's life, weapon and damage.** The life table (p01:7F97) goes by
  boss type, not by world, and type 5 does not exist: each type has to be
  matched to its map before giving the numbers per world.
- **A real machine.** Everything is tested in openMSX with C-BIOS.
