# The Maze of Galious — desensamblado comentado

*(Also available [in English](README.md).)*

Desensamblado comentado de ***The Maze of Galious*** (*Knightmare II*),
Konami, 1987, cartucho **RC-749** para **MSX**: un MegaROM de 128 KB con el
mapper Konami sin SCC, dieciséis bancos de 8 KB.

**La web**: https://antxiko.github.io/MazeOfGalious-disassembly/es/

| | |
|---|---|
| explicado | 100 % (53.613 bytes de código, 77.459 de datos) |
| comentado | 40,1 % de las instrucciones |
| rutinas | 3.423, ninguna por debajo del 10 % |
| reensamblado | la ROM, byte a byte |
| imágenes | dibujadas desde la ROM y cotejadas contra openMSX |

## Qué hay

- El listado de los dieciséis bancos (`src/galious_pNN.asm`), que se genera
  desde el binario y las notas y reensambla la ROM exacta.
- El castillo y los diez mundos, las 321 salas, montados desde las tablas del
  cartucho y colocados por sus vecinas.
- Popolon y Afrodita, los juegos de sprites de cada sala, los diez jefes, los
  47 objetos y las tiendas.
- Los cotejos contra openMSX, en los tests (`make test`).

## Cómo reproducirlo

Hace falta Python 3 (con Pillow), GNU make, [Pasmo](https://pasmo.speccy.org/)
y **tu propia imagen del cartucho** como `galious.rom` en la raíz:

```
sha256  420c42c18006eb5dbb25efa5b83e340d740824c15a714929a945c0db51f97280
make
```

Los detalles, en [Empezar](docs/es/EMPEZAR.md).

## Aviso

El juego es de Konami; aquí solo están el análisis, los comentarios y las
herramientas. La ROM no se distribuye. Ver [AVISO-LEGAL.md](AVISO-LEGAL.md).
