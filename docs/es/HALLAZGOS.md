# Hallazgos

Lo que apareció al desmontar el cartucho. Cada cosa lleva la dirección donde
se puede comprobar y dice si se ha visto en openMSX o solo se ha leído en el
código. Las salas van con el número que llevan en los mapas de esta web; el
mapa 1 es el castillo y los mapas 2 a 11 son los diez mundos.

## F2: el personaje se sienta en una taza

F2 en plena partida (p02:9E07) pone el estado 9: p00:5917 carga unos dibujos
del banco 15 y el personaje sale sentado en una taza blanca, con una pose fija
durante 600 cuadros y luego dos que se alternan cada 8 (p03:BE36). Comprobado
en openMSX.

## ZEUS en la pausa: continuar

En la pausa de F2, en la sala 1 del castillo, se puede teclear ZEUS
(p01:7E57; lo único que la llama es p00:474A). Pone 0xE027 a 1, y al perder la
pantalla dice GAME OVER y debajo F5 CONTINUE; sin la palabra solo sale GAME
OVER. F5 (p01:7EF1) sigue en la sala 1 del castillo con la vida en 8 y la
experiencia a 0 (p01:7E8C). Comprobado en openMSX.

## Con otro cartucho al lado

Al empezar, p00:4CF1 mira la otra ranura (p00:5F0C lee 0x7FFA y 0xBFFA):

| Cartucho | Lo que hace |
|---|---|
| Q\*bert | 100 flechas, 100 monedas, 100 llaves y vida 0x30 |
| Knightmare | pone 99 en 0xE05A y 0xE05B; para qué, sin mirar |
| Game Master | pone el bit 2 de 0xF0F8; p00:4CF1 no hace nada con él |

Leído en el código, sin probar con los cartuchos.

## Las salas negras son pistas y tiendas

Nueve mundos tienen una sala especial (tabla 0x8F0A del banco 2) que el juego
no monta como las demás: sale en negro, porque p00:514D se salta el montaje.
No son jefes. La sala 15 del mundo 1 es Demeter con una pista, y la 18 del
mundo 5 es la tienda de Demeter. El mensaje sale en inglés o en japonés según
la máquina: p02:94F0 lee el byte 0x002B de la BIOS. Las dos salas y los dos
idiomas, comprobados en openMSX.

## El jefe se llama por su nombre

En la sala del jefe se teclea su nombre (p02:9B18, tabla 0x9B4F). El juego
pasa al estado 0x0F, sale un humo y, unos 800 cuadros después, el jefe, con el
fondo de la sala en negro. Vencerlo pone el bit 2 de 0xE061 más el número del
mapa (p00:4B89). Visto en openMSX forzando la marca en la RAM; tecleando el
nombre, sin probar.

## Más palabras y atajos

- **UMBRELLA**, con el objeto 0x26 (p02:9BEE): acaba con todos los enemigos
  de tipo 0x0E de la sala (p03:B604).
- **Una cifra del 1 al 9 en el castillo**, con el objeto 0x27 (p02:9A99): a
  la puerta de ese mundo.
- **El objeto 0x15 y RETURN**: a la sala 72 del castillo.
- **En el mundo 8 sin el objeto 0x13** van cambiadas izquierda y derecha
  (p00:5353 y p00:535D llaman a p03:A8A0).

Leído en el código, sin probar.

## Objetos escondidos en el castillo

p02:9F82 esconde cinco objetos. Salen al vencer a las figuras de la sala
(p03:B6AA), y algunos piden algo más:

| Sala | Objeto | Además |
|---|---|---|
| 48 | 0x13 | |
| 75 | 0x16 | |
| 40 | 0x1B | el jefe del mapa 5 vencido y 9 pasos |
| 24 | 0x25 | el jefe del mapa 7 vencido |
| 43 | 0x26 | derecha, abajo, izquierda y arriba (tabla p03:A056) |

Leído en el código.

## Popolon y Afrodita

Comparten todos los dibujos; Afrodita lleva el color 9 donde Popolon lleva el
15. Comprobado en openMSX. En el agua 0xB6 y 0xB7 Popolon pierde vida cada
cuadro y Afrodita cada 255; en la 0xB8, los dos cada 4 (p03:B068). Leído en
el código.

## Las bolas rosas del castillo

116 salas del castillo tienen bolas rosas, en las casillas de la tabla 0xB8A2.
Cada golpe les quita 1, o 5 si golpea Popolon o se lleva el objeto 0x1F
(p03:B83C); al romperse quedan rotas en las marcas de la sala (p03:B85C).
Dónde están, comprobado en openMSX; los golpes, leídos en el código.

## La marca de Konami

Al final del banco 3, como en los otros cartuchos de la casa, va la marca
oculta: ガリウス ノ メイキュウ y RC-749 (tools/marca_konami.py). El formato de
la marca lo destapó Manuel Pazos.
