# En el emulador

Todo lo que se dibuja en esta web está cotejado contra **openMSX** con una
máquina MSX1 japonesa (`C-BIOS_MSX1_JP`). Las sondas son guiones Tcl que
llevan el cartucho adonde hace falta, tocando la RAM o pulsando teclas de
verdad, y vuelcan la VRAM (los primeros 16 KB) y la RAM. Se lanza un emulador
cada vez.

## Las sondas

| sonda | qué hace | lanzador |
|---|---|---|
| `omsx_titulo.tcl` | el arranque, el logotipo y el título, un volcado cada 0,25 s | `lanza_titulo.sh` |
| `omsx_vuelca.tcl` | la demo, en cada cambio de sala | `lanza_vuelca.sh` |
| `omsx_mundos.tcl` | lleva la demo a las salas pedidas y vuelca cada una | `lanza_mundos.sh` |
| `omsx_partida.tcl` | empieza una partida, va a una sala y la vuelca; con el jefe, pone 0xE020 como al acertar su nombre | `lanza_partida.sh` |
| `omsx_bordes.tcl` | en partida, saca al personaje por los bordes sin tocar las vecinas | — |
| `omsx_poses.tcl` | lo que p01:73E4 escribe del jugador, con Popolon y con Afrodita | `lanza_poses.sh` |
| `omsx_zeus.tcl` | ZEUS en la pausa de F2, GAME OVER y F5 | — |
| `omsx_lecturas.tcl` | quién lee cada byte del cartucho | `lanza_lecturas.sh` |
| `omsx_vigila.tcl` | quién escribe en un tramo de memoria | `lanza_vigila.sh` |
| `omsx_puerto99.tcl` | qué direcciones de VRAM se fijan en una sala | `lanza_puerto99.sh` |

Para llevar al personaje a una sala, `omsx_mundos.tcl` pone el mapa en 0xE041,
la sala en las cuatro vecinas cargadas (0xE648-0xE64B) y al personaje en el
borde derecho (0xE507 = 0xF9): el propio juego sale por la derecha y carga la
sala. Hay que borrar 0xE690 y 0xE740; si no, la marca de la sala especial se
arrastra y las salas siguientes no se montan.

## Los cotejos

Los volcados no viajan en el repositorio; lo que viaja es su huella, en
`tests/`, y los tests comparan con ella lo que se dibuja desde la ROM:

| test | qué compara | resultado |
|---|---|---|
| `test_titulo.py` | el logotipo y el título: los 16 KB de VRAM | 0 bytes distintos |
| `test_mapas.py` | cada sala: la tabla de nombres y los caracteres que usa | 321 salas, 0 distintas |
| `test_sprites.py` | los dibujos de sprite de cada sala y las poses del jugador | 321 salas y 136 combinaciones, 0 distintas |
| `test_vecinas.py` | el orden de las vecinas, saliendo por los bordes | 6 salidas, 0 distintas |
| `test_jefes.py` | qué mosaicos toma cada jefe y los 18 vistos enteros | 0 distintos |
| `test_objetos.py` | la tienda 12 y sus caracteres | 0 distintos |

## Trucos para verlo

- La máquina japonesa enseña los mensajes en japonés; con `C-BIOS_MSX1_EU`
  salen en inglés (p02:94F0 lee el byte 0x002B de la BIOS).
- Las capturas de pantalla de openMSX pueden salir viejas o negras con el
  emulador acelerado: el cotejo se hace siempre con la VRAM.
- Una partida empieza con espacio o M en el título (p00:4BFA).
- F1 abre la pantalla de objetos; F2, la pausa (la de la taza).
