# Empezar

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

## Qué hace cada paso

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
lanzadores de [En el emulador](EN-EL-EMULADOR.md).

## Dónde está cada cosa

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
