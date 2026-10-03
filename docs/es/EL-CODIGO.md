# El código

## Todo corre en la interrupción

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

## El despachador

p00:4140 es el despachador de Konami: la tabla de destinos va **pegada detrás
del `call`**. Saca de la pila la dirección de vuelta, que es la base de la
tabla, y salta al destino número A. El listado marca cada una de esas tablas
como datos y nombra sus destinos.

## Los estados del juego

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

## Una sala

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

## Las figuras

Las figuras viven en 0xE800, 32 bytes cada una: tipo en (ix+0), su paso en
(ix+1), y la ficha de cada tipo (p04:67BB) da su dibujo y su color. Los bancos
4, 5 y 6 llevan el movimiento de cada tipo. Los dibujos no son de cada tipo
sino de cada sala: todas sus figuras comparten el juego de sprites que carga
la sala.

## Los jefes

Un jefe no es un sprite: es un **mosaico** de caracteres que se pinta en la
pantalla y se cambia por otro para moverlo (61 mosaicos en 0x9E0A del banco
14). p00:5856 carga sus gráficos según 0xE0D3, que es el jefe de cada mapa
(0x5E05 + mapa). El del mundo 3 va por pasos (0xE61B): siete fichas de
p10:617C, una por cuadro, y luego, si el bit 5 de 0xE709 está puesto, las 37
copias de p10:621A.

## El sonido

Todo está en el banco 13, y lo llama la interrupción en cada cuadro. Hay **23
músicas** (0x743E, seis bytes cada una: un puntero por canal del PSG) y **48
efectos** (0x73DC). p13:6197 lee las partituras, que están en el banco 14:
notas, silencios, saltos, llamadas y repeticiones. La música del jefe acelera
cuando le queda poca vida.

## Cómo está hecho el listado

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
