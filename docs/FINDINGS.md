# Findings

What turned up when taking the cartridge apart. Each item gives the address
where it can be checked and says whether it has been seen in openMSX or only
read in the code. Rooms carry the number they have on this site's maps; map
1 is the castle and maps 2 to 11 are the ten worlds.

## F2: the character sits on a cup

F2 in the middle of a game (p02:9E07) sets state 9: p00:5917 loads some
patterns from bank 15 and the character appears sitting on a white cup, with
one fixed pose for 600 frames and then two that alternate every 8 (p03:BE36).
Checked in openMSX.

## ZEUS in the pause: continue

In the F2 pause, in room 1 of the castle, you can type ZEUS (p01:7E57; the
only thing that calls it is p00:474A). It sets 0xE027 to 1, and when the game
is lost the screen says GAME OVER and below it F5 CONTINUE; without the word
only GAME OVER comes up. F5 (p01:7EF1) carries on in room 1 of the castle
with life at 8 and experience at 0 (p01:7E8C). Checked in openMSX.

## With another cartridge next to it

At start-up, p00:4CF1 looks at the other slot (p00:5F0C reads 0x7FFA and
0xBFFA):

| Cartridge | What it does |
|---|---|
| Q\*bert | 100 arrows, 100 coins, 100 keys and life 0x30 |
| Knightmare | puts 99 in 0xE05A and 0xE05B; what for, not looked at |
| Game Master | sets bit 2 of 0xF0F8; p00:4CF1 does nothing with it |

Read in the code, not tried with the cartridges.

## The black rooms are hints and shops

Nine worlds have a special room (table 0x8F0A in bank 2) that the game does
not build like the others: it comes out black, because p00:514D skips the
building. They are not bosses. Room 15 of world 1 is Demeter with a hint,
and room 18 of world 5 is Demeter's shop. The message comes out in English or
in Japanese depending on the machine: p02:94F0 reads byte 0x002B of the BIOS.
Both rooms and both languages, checked in openMSX.

## The boss is called by its name

In the boss room you type its name (p02:9B18, table 0x9B4F). The game goes to
state 0x0F, smoke comes out and, about 800 frames later, the boss, with the
room's background in black. Defeating it sets bit 2 of 0xE061 plus the map
number (p00:4B89). Seen in openMSX by forcing the flag in RAM; by typing the
name, not tried.

## More words and shortcuts

- **UMBRELLA**, with item 0x26 (p02:9BEE): gets rid of every type 0x0E enemy
  in the room (p03:B604).
- **A digit from 1 to 9 in the castle**, with item 0x27 (p02:9A99): to that
  world's door.
- **Item 0x15 and RETURN**: to room 72 of the castle.
- **In world 8 without item 0x13** left and right are swapped (p00:5353 and
  p00:535D call p03:A8A0).

Read in the code, not tried.

## Hidden items in the castle

p02:9F82 hides five items. They come out when the room's figures are
defeated (p03:B6AA), and some ask for something more:

| Room | Item | Also |
|---|---|---|
| 48 | 0x13 | |
| 75 | 0x16 | |
| 40 | 0x1B | map 5's boss defeated and 9 steps |
| 24 | 0x25 | map 7's boss defeated |
| 43 | 0x26 | right, down, left and up (table p03:A056) |

Read in the code.

## Popolon and Aphrodite

They share all their patterns; Aphrodite has colour 9 where Popolon has 15.
Checked in openMSX. In water 0xB6 and 0xB7 Popolon loses life every frame and
Aphrodite every 255; in 0xB8, both every 4 (p03:B068). Read in the code.

## The castle's pink orbs

116 rooms in the castle have pink orbs, in the cells of table 0xB8A2. Each
hit takes 1 off them, or 5 if Popolon hits or item 0x1F is carried
(p03:B83C); once broken they stay broken in the room's flags (p03:B85C).
Where they are, checked in openMSX; the hits, read in the code.

## Konami's mark

At the end of bank 3, as in the house's other cartridges, there is the hidden
mark: ガリウス ノ メイキュウ and RC-749 (tools/marca_konami.py). The format of
the mark was uncovered by Manuel Pazos.
