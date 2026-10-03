# Preguntas abiertas

Lo que no se sabe, o se ha leído en el código y no se ha comprobado en el
emulador.

## Lo que nadie nombra

Ninguna instrucción ni palabra de la ROM apunta a estos trozos. Eso no prueba
que no se usen: una dirección calculada no deja rastro, y ya pasó con los
gráficos del jefe del mundo 3, que se eligen con 0x6175 + 7 × paso. Nada de
esto se ha medido en openMSX:

- **Código:** p00:405F y p00:4077;
  p02:8153; p03:A871, A904, AAC1, ADF7, AE23, B16F y B17E; p06:A1F8, ACE2,
  ADE5 y B183. Los dos primeros son entradas de un vector de saltos que nadie
  llama; los demás van detrás de un `jp`, un `jr` o un `ret`.
- **p04:6DC6:** 56 bytes (16 parejas de pasos y tres ordenaciones de 0-7), los
  mismos que p05:88FD.
- **p12:B850:** 240 bytes iguales, byte a byte, al rle de 0xB760 (el sello de
  la sala del jefe), justo detrás de él.

## La sala 94 del castillo

No tiene vecinas: ninguna sala lleva a ella y ella no lleva a ninguna. En el
mapa va en el único hueco que queda entre la 93 y la 95, pero eso es una
deducción por el número, no una vecina. p04:62A4 la usa como generador. Cómo
se entra, si se entra, está sin ver.

## Las demos

La tabla de p01:7DD9 tiene cinco demos. Cuántas llegan a salir, sin
medir.

## Leído en el código, sin probar

- **Teclear el nombre del jefe.** Visto en openMSX poniendo a mano la marca de
  acertado (0xE020); tecleándolo, no.
- **UMBRELLA**, las **cifras del castillo** con el objeto 0x27, el objeto
  **0x15 con RETURN** y el **mundo 8 sin el objeto 0x13**.
- **Los objetos escondidos del castillo** (p02:9F82) y lo que pide cada uno.
- **La contraseña** (p02:95A0): 43 letras de 5 bits más 2 de suma, en 11
  grupos de 4 y uno de 1, y se teclea en el estado 0x12 (p02:9716). Desde
  dónde se llega a esa pantalla, sin comprobar.
- **Con Knightmare en la otra ranura** pone 99 en 0xE05A y 0xE05B; p02:908D
  los pasa a 0xE053 y 0xE057 (los topes de vida). Sin probar con el cartucho.
- **Con el Game Master** pone el bit 2 de 0xF0F8; qué hacen p00:5EE6 y
  p00:5F00 con él, sin mirar.

## Lo que no se ha mirado

- **Los objetos 0x12 y 0x14:** el 0x12 abre algo en la sala 11 del mundo 2
  (p08:9F87) y el 0x14 hace pintar algo en el castillo según 0xE06C
  (p00:5D24).
- **La vida, el arma y el daño de cada jefe.** La tabla de vida (p01:7F97) va
  por tipo de jefe y no por mundo, y el tipo 5 no existe: falta casar cada
  tipo con su mapa antes de dar las cifras por mundo.
- **Una máquina de verdad.** Todo está probado en openMSX con C-BIOS.
