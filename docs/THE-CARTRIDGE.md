# The cartridge

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

## The mapper

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

## What each bank holds

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

## The VRAM

The game runs in **SCREEN 2** with the registers at 0x4C5B: name table at
0x3800, colours at 0x0000 (R3 = 0x7F), patterns at 0x2000 (R4 = 7), sprite
attributes at 0x3B00 and their patterns at 0x1800. Sprites are 16 × 16. R7
is 0xE4 (blue background) on the logo and 0xE0 (black) afterwards.

The screen is built in a copy in RAM (0xED00) and p00:54F3 uploads it with
LDIRVM. A room takes rows 4 to 23; rows 0 to 3 are the status bar.

## The RAM that matters

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
