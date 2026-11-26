# Por dentro

## Empezar

Para reproducir este desensamblado hace falta Python 3 (con Pillow para las
imágenes), GNU make y [Pasmo](https://pasmo.speccy.org/). La imagen del
cartucho **no viaja en este repositorio**: cada cual pone la suya.

```
galious.rom   131.072 bytes
sha256        420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280
```

Con el fichero en la raíz del repositorio:

```
make            # listado, verificación, coherencia y tests
```

### Qué hace cada paso

| orden | qué hace |
|---|---|
| `make comprueba` | comprueba el sha256 de la ROM |
| `make reconoce` | la cabecera y las 32 escrituras al mapper, con su banco |
| `make semillas` | traza el cartucho entero y escribe las entradas y las tablas de cada banco |
| `make listado` | genera los dieciséis `.asm` desde el binario, las notas y las semillas |
| `make verify` | reensambla cada banco y la ROM entera, y compara los sha256 |
| `make sanity` | comprueba que ningún dato se lea como código y que no quede un byte sin asignar |
| `make test` | los tests, con los cotejos contra openMSX |
| `make densidad` | cuántas instrucciones llevan comentario, banco a banco |
| `make imagenes` | dibuja los PNG de `docs/imagenes/` desde la ROM |
| `make web` | genera las páginas HTML y comprueba los enlaces |

`make verify` es el que decide: al final tiene que imprimir `OK: la ROM entera
reproducible byte a byte`.

Los tests comparan lo dibujado desde la ROM con las huellas de los volcados de
openMSX guardadas en `tests/`. Los volcados no viajan; se rehacen con los
lanzadores de [En el emulador](POR-DENTRO.html).

### Dónde está cada cosa

- `src/galious_pNN.asm`: el listado, uno por banco. **Se genera**: no se edita
  a mano.
- `src/pNN.notes`: las etiquetas (`L`), los comentarios de línea (`C`), los
  rangos de datos (`D`) y los encabezados de rutina (`B`). Esto **sí** se
  edita.
- `tools/anotaciones.py`: los nombres de las rutinas y de la RAM.
- `src/pNN.entries` y `src/pNN.nocode`: las entradas de cada banco y las tablas
  que no son código, sacadas del trazado del cartucho entero (`make semillas`);
  `src/semillas.txt` y `src/tablas.txt`, las que se añaden a mano.
- `tools/`: el trazador, el generador del listado y las herramientas que
  dibujan (`vram.py`, `dibuja.py`, `titulo.py`, `personajes.py`,
  `objetos.py`).
- `docs/`: esta web, en inglés en la raíz y en castellano en `docs/es/`.

## El cartucho

| | |
|---|---|
| título | *The Maze of Galious* (*Knightmare II*; ガリウスの迷宮), Konami, 1987 |
| número | RC-749 |
| máquina | MSX1 (TMS9918), SCREEN 2 |
| tamaño | 131.072 bytes: 16 bancos de 8 KB |
| mapper | Konami sin SCC (Konami4) |
| sonido | PSG, tres canales |
| sha256 | `420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280` |

La cabecera es `AB` con INIT en 0x4095. En 0x4010 hay una segunda cabecera,
`CD` seguida de 07 49, que es la que busca el Game Master. El juego no toca
ningún registro del V9938: es de MSX1.

### El mapper

El banco 0 está **fijo** en 0x4000-0x5FFF. Los otros tres huecos se eligen
escribiendo el número de banco en 0x6000, 0x8000 y 0xA000. No hay ni una
escritura a 0x5000, 0x7000, 0x9000 ni 0xB000, que son los registros del mapper
con SCC: por eso es Konami4.

Hay **32 escrituras** al mapper (`tools/reconocimiento.py`): 11 a 0x6000, 11 a
0x8000 y 10 a 0xA000. Los bancos se ponen de tres en tres (p00:416C-0x41E1:
1-2-3, 4-5-6, 7-8-9, 10-11-12 y 13-14-15) o de uno en uno, y **todas** cumplen
la regla: cada banco va siempre al mismo hueco. Con eso el listado se parte en
dieciséis módulos, cada uno con su `org`:

| hueco | bancos |
|---|---|
| 0x4000 (fijo) | 0 |
| 0x6000 | 1, 4, 7, 10, 13 |
| 0x8000 | 2, 5, 8, 11, 14 |
| 0xA000 | 3, 6, 9, 12, 15 |

El código **cruza de banco** en cuatro sitios: una instrucción empieza al
final de un banco y acaba en el siguiente (p00:5FFF, p01:7FFE, p04:7FFF y
p08:9FFF); el listado parte cada una en dos `defb`. La
interrupción pone los bancos 13 y 14 para el sonido y al salir devuelve los
que había desde sus copias en RAM (0xF0F1-0xF0F3).

### Qué hay en cada banco

| banco | código | qué lleva |
|---|---|---|
| 0 | 7.808 B | el arranque, la interrupción, el despachador, los 21 estados del juego, los lectores de gráficos (rle, fichas, copias dadas la vuelta), el montaje de la sala y lo de encima, el marcador |
| 1 | 7.282 B | el personaje y sus poses, la vida y la experiencia, el logotipo y el título, la historia, las demos, GAME OVER y ZEUS, la pantalla de objetos |
| 2 | 7.162 B | las salas especiales (pistas y tiendas), la contraseña, el teclado y las palabras, los nombres de los jefes, las puertas de los mundos |
| 3 | 7.644 B | el personaje en la sala: andar, escaleras, armas, el agua, los golpes, las bolas rosas, los objetos escondidos, los jefes; la marca de Konami |
| 4 | 6.452 B | las figuras: cómo se mueve cada tipo |
| 5 | 7.798 B | más figuras y sus tablas de movimiento |
| 6 | 4.660 B | más figuras; los objetos de cada sala |
| 7 | — | las salas de los 11 mapas (8 × 5 bloques) y los 172 bloques de 4 × 4 caracteres |
| 8 | 739 B | las paredes y escaleras de los mundos; el resto de las salas y los recuadros de los jefes |
| 9 | 1.873 B | las puertas del castillo; las figuras de cada sala, las vecinas (0xA9EF), el logotipo de Konami |
| 10 | — | las fichas de caracteres de cada sitio y los 64 juegos de sprites |
| 11 | — | los dibujos de sprite y qué juego carga cada sala |
| 12 | — | dibujos y colores de caracteres en rle: los gráficos de los jefes y el sello de su sala |
| 13 | 1.351 B | el **sonido**: 23 músicas, 48 efectos y el intérprete |
| 14 | — | las partituras, los mosaicos de los jefes (0x9E0A), la fuente y el rótulo del título |
| 15 | 844 B | el final, el agua y el humo del jefe; los mensajes |

En total, **53.613 bytes de código y 77.459 de datos**: el 100 % del cartucho
asignado (`make sanity`).

### La VRAM

El juego corre en **SCREEN 2** con los registros de 0x4C5B: tabla de nombres
en 0x3800, colores en 0x0000 (R3 = 0x7F), dibujos en 0x2000 (R4 = 7),
atributos de sprite en 0x3B00 y sus dibujos en 0x1800. Los sprites son de 16
× 16. R7 vale 0xE4 (fondo azul) en el logotipo y 0xE0 (negro) después.

La pantalla se monta en una copia en RAM (0xED00) y p00:54F3 la sube con
LDIRVM. Una sala ocupa las filas 4 a 23; las 0 a 3 son el marcador.

### La RAM que importa

| dirección | qué es |
|---|---|
| 0xE000 / 0xE001 | el estado del juego y su paso |
| 0xE003 | el contador de cuadros |
| 0xE020 | el nombre del jefe acertado |
| 0xE027 | ZEUS tecleado |
| 0xE041 / 0xE042 | el mapa (1 el castillo, 2-11 los mundos) y la sala |
| 0xE046 / 0xE048 / 0xE04A | flechas, monedas y llaves, en BCD |
| 0xE052 / 0xE056 | la vida de Afrodita y la de Popolon |
| 0xE050 / 0xE054 | la experiencia de Afrodita y la de Popolon |
| 0xE06F + tipo | la marca de cada objeto |
| 0xE0D2 / 0xE0D3 | el estado del jefe y qué jefe |
| 0xE500 / 0xE501 | el estado del personaje y quién juega (0 Afrodita) |
| 0xE690 | la sala especial (pista o tienda) |
| 0xE800 | las figuras, 32 bytes cada una |
| 0xEC80 / 0xED00 | las copias de la tabla de sprites y de la de nombres |

## El código

### Todo corre en la interrupción

INIT (0x4095) pone el cartucho también en la página 2, engancha **H.KEYI**
(0xFD9A = `jp 0x40EF`), deja la pila debajo de 0xF0F0, borra la RAM del juego
(0xE000-0xF0EF), pone la VRAM y el sonido a cero, busca otros cartuchos en
las ranuras (p00:5F0C) y pone los bancos 1-2-3. Desde ahí se queda en un `jr`
sobre sí mismo (p00:40D1), y todo el juego corre en **p00:40EF**, una vez por
cuadro:

1. Si ya estaba dentro (el semáforo de 0xE006), solo suelta el VDP.
2. Lo de la VRAM que toca según el estado (tabla 0x543B).
3. El sonido, con los bancos 13 y 14 puestos (p13:6004). Luego vuelven los
   bancos del juego desde 0xF0F1-0xF0F3, y si hay una música esperando, se
   pide.
4. Si el cuadro anterior ya acabó (el semáforo de 0xE005), el **juego del
   cuadro** (p00:4277). La interrupción se abre antes, para que el sonido no
   espere al juego.

### El despachador

p00:4140 es el despachador de Konami: la tabla de destinos va **pegada detrás
del `call`**. Saca de la pila la dirección de vuelta, que es la base de la
tabla, y salta al destino número A. El listado marca cada una de esas tablas
como datos y nombra sus destinos.

### Los estados del juego

0xE000 es el estado y 0xE001 su paso (tabla de 0x428E):

| estado | qué es |
|---|---|
| 0 | el logotipo de Konami |
| 1 | el título |
| 2 | la demo o la historia, una vuelta cada una |
| 3 | empieza la partida |
| 4 | entra en la sala |
| 5 | la partida |
| 6 | se acaba una vida |
| 7 | GAME OVER, y con ZEUS, F5 para continuar |
| 8 | entra en un mundo por su puerta |
| 9 | la pausa de F2 |
| 0x0A | pasa a la sala vecina |
| 0x0B | la pantalla de objetos (F1) |
| 0x0C | lee el monumento de la sala (el arma 6 junto a él) |
| 0x0D | vuelve al castillo |
| 0x0E | la sala especial: una pista o una tienda |
| 0x0F | el jefe: el nombre acertado, el humo y el jefe |
| 0x10 | por una puerta, a la sala especial de 0xE680 |
| 0x11 | el final |
| 0x12 | teclear la contraseña |
| 0x13 | el jefe vencido |
| 0x14 | nueve saltos de alegría (p03:BE5F) |

Los estados con pocos pasos se reparten con `djnz` sobre el paso: la primera
caída es el paso 1 y el último destino de la cadena, el paso 0. Se ve en el
logotipo: el paso 0 lo prepara, el 1 lo va pintando y el 2 espera (comprobado
en openMSX, `tools/omsx_titulo.tcl`).

### Una sala

Al entrar en una sala, el juego carga sus gráficos (p00:568E) y monta la
pantalla (p00:55C6). Lo mismo hace `tools/vram.py`, paso a paso:

1. la fuente y el marcador (banco 14);
2. las fichas de caracteres del sitio: las comunes (p10:6000), las de la zona
   del castillo (0x60D7) o las de los mundos (0x6044);
3. el dibujo de la cosa de la sala, si la hay (0x6E34 y 0x6E80);
4. en la sala del jefe, el sello (p10:6121);
5. la planta: 8 × 5 bloques de la sala (banco 7), cada uno de 4 × 4
   caracteres (0x6000 + 16 × bloque);
6. encima, escaleras, puertas, objetos, bolas rosas y lo animado (agua y
   colores), con sus marcas de partida;
7. los dibujos de sprite de la sala (p00:592F): la base de 0x790D y el juego
   de la sala.

Las 321 salas montadas así dan 0 diferencias contra openMSX en la tabla de
nombres y en los caracteres que usan.

### Las figuras

Las figuras viven en 0xE800, 32 bytes cada una: tipo en (ix+0), su paso en
(ix+1), y la ficha de cada tipo (p04:67BB) da su dibujo y su color. Los bancos
4, 5 y 6 llevan el movimiento de cada tipo. Los dibujos no son de cada tipo
sino de cada sala: todas sus figuras comparten el juego de sprites que carga
la sala.

### Los jefes

Un jefe no es un sprite: es un **mosaico** de caracteres que se pinta en la
pantalla y se cambia por otro para moverlo (61 mosaicos en 0x9E0A del banco
14). p00:5856 carga sus gráficos según 0xE0D3, que es el jefe de cada mapa
(0x5E05 + mapa). El del mundo 3 va por pasos (0xE61B): siete fichas de
p10:617C, una por cuadro, y luego, si el bit 5 de 0xE709 está puesto, las 37
copias de p10:621A.

### El sonido

Todo está en el banco 13, y lo llama la interrupción en cada cuadro. Hay **23
músicas** (0x743E, seis bytes cada una: un puntero por canal del PSG) y **48
efectos** (0x73DC). p13:6197 lee las partituras, que están en el banco 14:
notas, silencios, saltos, llamadas y repeticiones. La música del jefe acelera
cuando le queda poca vida.

### Cómo está hecho el listado

- `tools/bancos.py` traza **el cartucho entero** llevando la cuenta de qué
  banco hay en cada hueco. De ahí salen las llamadas que cruzan el mapper
  (`src/pNN.entries`) y las tablas del despachador (`src/pNN.nocode`).
- `tools/z80trace.py` sigue el flujo de cada banco desde esas entradas.
- `tools/bloques.py` declara los datos recorriéndolos como los lectores del
  banco 0 (rle, fichas, copias, listas, salas, partituras).
- `src/pNN.notes` guarda las etiquetas, los comentarios y los rangos de datos,
  anclados a dirección. `tools/mkasm.py` los mezcla con el trazado y escribe
  `src/galious_pNN.asm`.
- `make verify` reensambla los dieciséis bancos con Pasmo y la ROM entera, y
  compara los sha256.
- `make sanity` comprueba que ningún dato se lea como código y que no quede ni
  un byte sin asignar.

La densidad: **40,1 %** de las 25.226 instrucciones llevan comentario, y las
3.423 rutinas pasan todas del 10 % (`make densidad`).

## En el emulador

Todo lo que se dibuja en esta web está cotejado contra **openMSX** con una
máquina MSX1 japonesa (`C-BIOS_MSX1_JP`). Las sondas son guiones Tcl que
llevan el cartucho adonde hace falta, tocando la RAM o pulsando teclas de
verdad, y vuelcan la VRAM (los primeros 16 KB) y la RAM. Se lanza un emulador
cada vez.

### Las sondas

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

### Los cotejos

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

### Trucos para verlo

- La máquina japonesa enseña los mensajes en japonés; con `C-BIOS_MSX1_EU`
  salen en inglés (p02:94F0 lee el byte 0x002B de la BIOS).
- Las capturas de pantalla de openMSX pueden salir viejas o negras con el
  emulador acelerado: el cotejo se hace siempre con la VRAM.
- Una partida empieza con espacio o M en el título (p00:4BFA).
- F1 abre la pantalla de objetos; F2, la pausa (la de la taza).

## Código compartido con otros cartuchos de Konami

Este desensamblado se ha comparado, instrucción por instrucción, con
todos los demás de Konami de la serie. Cuenta un bloque cuando las
mismas instrucciones, al menos seis desde una etiqueta hasta su `ret`
o su salto sin condición, están en los dos cartuchos; las direcciones
no se miran, porque cambian de un cartucho a otro. De los otros 57,
**47** tienen al menos un bloque en común con este; estos son los
que más comparten:

| Cartucho | Bloques | Instrucciones | Por ejemplo (aquí = allí) |
|---|---:|---:|---|
| [Nemesis 2](https://antxiko.github.io/Nemesis2-disassembly/es/) | 49 | 612 | `lee_caracteres` (p00:5B66) |
| [Salamander - Operation X](https://antxiko.github.io/Salamander-disassembly/es/) | 41 | 447 | `rle_con_destino` (p00:5C40) = `rachas_con_destino` |
| [Parodius](https://antxiko.github.io/Parodius-disassembly/es/) | 31 | 343 | `rle_con_destino` (p00:5C40) = `rachas_con_destino` |
| [Nemesis 3 - The Eve of Destruction](https://antxiko.github.io/Nemesis3-disassembly/es/) | 30 | 312 | `rle_con_destino` (p00:5C40) = `rle_con_direccion` |
| [Nemesis / Gradius](https://antxiko.github.io/Nemesis-disassembly/es/) | 28 | 380 | `lee_caracteres` (p00:5B66) = `baja_el_caracter_a_la_ram` |
| [Ganbare Goemon! Karakuri Dōchū](https://antxiko.github.io/GanbareGoemon-disassembly/es/) | 23 | 312 | `paso_de_envolvente` (p13:64B0) = `cuadro_del_efecto` |
| [Vampire Killer](https://antxiko.github.io/VampireKiller-disassembly/es/) | 22 | 320 | `paso_de_envolvente` (p13:64B0) = `cuenta_del_paso` |
| [Shalom: Knightmare III](https://antxiko.github.io/Shalom-disassembly/es/) | 21 | 235 | `logotipo_de_konami` (p01:6957) = `rotulo_konami` |
| [King's Valley II](https://antxiko.github.io/KingsValley2-disassembly/es/) | 19 | 238 | `mando` (p00:4C75) |
| [King Kong 2: Yomigaeru Densetsu](https://antxiko.github.io/KingKong2-disassembly/es/) | 17 | 197 | `sonido_a_cero` (p00:4DED) = `el_sonido_desde_cero` |

La matriz entera, los 58 cartuchos entre sí, está en
[Las rutinas](https://antxiko.github.io/MSX-disassembly-database/es/LAS-RUTINAS.html) de la base de datos de la
serie, con el método y el programa que la mide.
