# El cartucho

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

## El mapper

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

## Qué hay en cada banco

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

## La VRAM

El juego corre en **SCREEN 2** con los registros de 0x4C5B: tabla de nombres
en 0x3800, colores en 0x0000 (R3 = 0x7F), dibujos en 0x2000 (R4 = 7),
atributos de sprite en 0x3B00 y sus dibujos en 0x1800. Los sprites son de 16
× 16. R7 vale 0xE4 (fondo azul) en el logotipo y 0xE0 (negro) después.

La pantalla se monta en una copia en RAM (0xED00) y p00:54F3 la sube con
LDIRVM. Una sala ocupa las filas 4 a 23; las 0 a 3 son el marcador.

## La RAM que importa

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
