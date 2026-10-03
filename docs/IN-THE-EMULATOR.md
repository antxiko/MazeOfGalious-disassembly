# In the emulator

Everything drawn on this site is checked against **openMSX** on a Japanese
MSX1 machine (`C-BIOS_MSX1_JP`). The probes are Tcl scripts that take the
cartridge wherever needed, by poking RAM or pressing real keys, and dump the
VRAM (the first 16 KB) and the RAM. One emulator at a time.

## The probes

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

## The checks

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

## Tips for watching it

- The Japanese machine shows the messages in Japanese; with
  `C-BIOS_MSX1_EU` they come out in English (p02:94F0 reads byte 0x002B of the
  BIOS).
- openMSX screenshots can come out stale or black with the emulator sped up:
  the check is always done on the VRAM.
- A game starts with space or M on the title (p00:4BFA).
- F1 opens the item screen; F2, the pause (the one with the cup).
