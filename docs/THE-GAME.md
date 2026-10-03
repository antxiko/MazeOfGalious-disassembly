# The game

Popolon and Aphrodite explore **the castle and ten worlds: 321 rooms**. The
castle has 147; the worlds have 15 to 27, and the tenth, GALIOUS's, has 6. On
this site map 1 is the castle and maps 2 to 11 are worlds 1 to 10.

Every picture on this page is **drawn from the bytes of the ROM** with the
tools in `tools/`, which follow the cartridge's own steps, and checked
against openMSX dumps (`C-BIOS_MSX1_JP`). Each caption says which table it
comes from.

## The title screen

![The Konami logo](imagenes/logotipo.png)

*The logo: 6 rows of 21 characters from 0x40 (p01:6957), with the patterns
at 0xBCEF in bank 9. It appears from top to bottom, one line of every row
every two frames (p01:6985), over the blue of register 7 (0xE4).*

![The title screen](imagenes/titulo.png)

*The sign at 0x933F (14 × 12 characters), the letters of the list at 0x7D51
and four sprites from 0x93E7. A sparkle runs down the sword and goes out
(p01:6267).*

Both match openMSX in all 16 KB of VRAM (`titulo.py coteja`).

## The castle

![The castle](imagenes/mapa_1.png)

*The castle's 147 rooms, each with its number, laid out by their neighbours
(table 0xA9EF in bank 9). Each room is 8 × 5 blocks of 4 × 4 characters.*

The order of the neighbours (up, down, left, right) is checked in openMSX:
leaving by the left and right edges leads to the room the table says, and the
four rooms the game loads at 0xE648 are the table's; up and down are used by
p03:A7F8. Rooms are numbered in reading order except those at the entrance.
Room 94 has no neighbours: it goes in the only gap left between 93 and 95,
and how to reach it is in [Open questions](OPEN-QUESTIONS.md).

On top of the floor plan the game places ladders, the world doors and the
way-back doors, items and pink orbs. All 321 rooms, with all of that, match
openMSX character for character.

## The ten worlds

| World | Rooms | The boss's name |
|---|---|---|
| [1](imagenes/mapa_2.png) | 15 | YOMAR |
| [2](imagenes/mapa_3.png) | 15 | ELOHIM |
| [3](imagenes/mapa_4.png) | 16 | HAHAKLA |
| [4](imagenes/mapa_5.png) | 17 | BARECHET |
| [5](imagenes/mapa_6.png) | 18 | HEOTYMEO |
| [6](imagenes/mapa_7.png) | 19 | LEPHA |
| [7](imagenes/mapa_8.png) | 20 | NAWABRA |
| [8](imagenes/mapa_9.png) | 21 | ASCHER |
| [9](imagenes/mapa_10.png) | 27 | XYWOLEH |
| [10](imagenes/mapa_11.png) | 6 | HAMALECH |

*Each number links to its map. The names come from the table at 0x9B4F in
bank 2, three bytes per map: where the text is and how many letters it
has.*

The black rooms on the maps are the hint and shop rooms: the game does not
build them like the others (see [Findings](FINDINGS.md)).

## Popolon and Aphrodite

![The poses](imagenes/poses.png)

*The player's 32 poses (table 0x7529 in bank 1), Popolon above and Aphrodite
below. From 18 to 27 the character sinks (p00:5832). Checked against openMSX
in 2748 in-game situations.*

Both use the same patterns; Aphrodite has colour 9 where Popolon has 15.

## The enemies

![The sprite sets](imagenes/juegos.png)

*The sprite sets each room loads (base 0x790D and tables 0x9737 and 0x7C72),
in white: each figure sets its own colour when it appears.*

Patterns go by room, not by enemy: each room loads its set and its figures
share it. Those of all 321 rooms match openMSX.

## The bosses

![The boss room of world 1](imagenes/sala_del_jefe.png)

*The boss room of world 1 before the boss appears: the seal is the 8 × 8
character frame at 0x9BE2. Its left half is the patterns at 0xB760 (30
characters from 0x5A, entry p10:6121) and the right half, the same
characters flipped (copies at p10:6128). p00:56FA loads it while the boss has
not come out.*

The boss does not appear on its own: in its room you have to type its name
(p02:9B18 compares the last letters typed). Then smoke comes out and, after
it, the boss, with the room's background in black.

![The ten bosses](imagenes/jefes.png)

*The ten bosses in full, with the number of their world. They are not
sprites: they are character mosaics (61 in the table at 0x9E0A in bank 14)
swapped to move them. p00:5856 loads their graphics; world 3's goes in steps,
one piece per frame.*

Which mosaics each boss uses was measured in game, frame by frame, over 6000
frames; the 18 seen whole match openMSX.

## The items

![The items](imagenes/objetos.png)

*The 47 item types (1 to 0x2F), each with its number and how many there are
in the rooms. Types 7 to 0x2C have their own picture (0x6E34 and 0x6E80 in
bank 10); the last three are arrows, coins and keys.*

The game never names them: it only draws them. That is why they go by number
here. What each one does comes from who reads its flag (0xE06F plus the
type); some of them:

- **0x07:** the world boss's life starts at half.
- **0x08:** the boss takes off half when it touches you.
- **0x0B:** without it GALIOUS cannot be hurt.
- **0x11:** you walk faster.
- **0x19:** the figures take off half.
- **0x1B:** every enemy gives double experience.
- **0x20:** with CTRL the figures and the boss stop, up to 16 times.
- **0x25:** every hit takes off double.

The rest, with their addresses, are in `tools/objetos.py`.

## The shops

There are 13 shop entries (0x9255 in bank 2), of up to three items each, with
the price in coins:

| What is sold | Price |
|---|---|
| 100 arrows (0x2D) | 20 |
| a key (0x2F) | 5 |
| 0x05, 0x06 | 30, 20 |
| 0x0D, 0x23 | 25 |
| 0x10, 0x18, 0x21, 0x28 | 30 |
| 0x2B | 40 |
| 0x19, 0x2C | 50 |

The feather shop (0x10, entry 12), in room 18 of world 5, is checked in
openMSX.
