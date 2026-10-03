#!/usr/bin/env python3
"""Lo que tools/anota.py sabe de The Maze of Galious: rutinas con nombre, RAM y
los campos de los huecos de figura. Solo datos; la maquinaria esta en anota.py.

CADA ENTRADA LLEVA DE DONDE SALE. Lo que no se sabe no esta en la tabla.
"""

# Los bancos con codigo (make densidad: el 7, 10, 11, 12 y 14 son solo datos).
BANCOS = (0, 1, 2, 3, 4, 5, 6, 8, 9, 13, 15)

# Los saltos del banco 0 en 0x4050 + 3 x k (jp a la rutina de verdad): los
# demas bancos llaman aqui. Leidos en p00:4050-4094.
VECTORES = {
    0x4050: 0x4140, 0x4053: 0x414C, 0x4056: 0x4DA1, 0x4059: 0x4E1F, 0x405C: 0x4164,
    0x405F: 0x4DB5, 0x4062: 0x4136, 0x4065: 0x413B, 0x4068: 0x415C, 0x406B: 0x4DCF,
    0x406E: 0x4DC8, 0x4071: 0x4DC5, 0x4074: 0x54FF, 0x4077: 0x551F, 0x407A: 0x553E,
    0x407D: 0x424C, 0x4080: 0x5CC4, 0x4083: 0x4155, 0x4086: 0x5D12, 0x4089: 0x4DDB,
    0x408C: 0x5F8F, 0x4092: 0x4269,
}

# (banco, direccion) -> (nombre, lo que hace). Cada una leida en el listado.
RUTINAS = {
    (0, 0x4136): ("hl_mas_a", "HL += A"),
    (0, 0x413B): ("de_mas_a", "DE += A"),
    (0, 0x4140): ("despacha", "salta a la entrada A de la tabla de palabras que va detras del call"),
    (0, 0x414C): ("palabra_de_tabla", "DE = la palabra A de la tabla de HL"),
    (0, 0x4155): ("byte_de_tabla", "A = el byte HL + A"),
    (0, 0x415C): ("de_negado", "DE = -DE"),
    (0, 0x4215): ("a000_banco_3", "pone el banco 3 en 0xA000 (y su copia en 0xF0F3)"),
    (0, 0x4220): ("a000_banco_6", "pone el banco 6 en 0xA000 (y su copia en 0xF0F3)"),
    (0, 0x422B): ("a000_banco_9", "pone el banco 9 en 0xA000 (y su copia en 0xF0F3)"),
    (0, 0x4236): ("a000_banco_12", "pone el banco 12 en 0xA000 (y su copia en 0xF0F3)"),
    (0, 0x4241): ("a000_banco_15", "pone el banco 15 en 0xA000 (y su copia en 0xF0F3)"),
    (0, 0x4D5A): ("suma_flechas", "suma A (BCD) a las flechas de 0xE046, hasta 999"),
    (0, 0x4D7B): ("suma_monedas", "suma A (BCD) a las monedas de 0xE048, hasta 999"),
    (0, 0x4D82): ("suma_llaves", "suma A (BCD) a las llaves de 0xE04A, hasta 999"),
    (0, 0x4DA1): ("casilla_de_yx", "HL = la casilla de la copia de nombres de 0xED00 en la y (L) y la x (H)"),
    (0, 0x4DDB): ("tiene_o_popolon", "NZ si la marca de HL esta puesta o se lleva a Popolon (0xE501)"),
    (0, 0x4E1F): ("pide_sonido", "pide el sonido A al banco 13 (p00:4E6B con los bancos 13 y 14)"),
    (0, 0x5A8D): ("copias_volteadas", "copia caracteres dandoles la vuelta, fichas de 4 bytes desde IX"),
    (0, 0x5AB3): ("fichas_graficas", "dibujos y colores por rle, fichas de 6 bytes desde IX"),
    (0, 0x5BFC): ("rle_tres_tercios", "el rle de DE en HL y en los otros dos tercios (+0x800)"),
    (0, 0x5C25): ("lista_a_vram", "pinta la lista de DE: [destino] y bytes, 0xFE otro destino, 0xFF acaba"),
    (0, 0x5C3C): ("borra_lista_vram", "como lista_a_vram pero escribiendo ceros"),
    (0, 0x5C46): ("rle_a_vram", "descomprime el rle de DE en la VRAM de HL"),
    (0, 0x58E1): ("dibujo_de_cosa", "carga el dibujo y los colores de la cosa A (0x6E34/0x6E80) en HL"),
    (0, 0x5F0C): ("busca_cartuchos", "mira la firma de Game Master, Q*bert y Knightmare en la otra ranura (0xF0F8)"),
    (0, 0x4CF1): ("regalo_de_cartucho", "lo que dan Q*bert (bit 1) y Knightmare (bit 0) de 0xF0F8 al empezar"),
    (1, 0x612C): ("cambia_vida", "suma A (con signo) al cambio de vida pendiente del que juega"),
    (1, 0x6158): ("suma_experiencia", "suma A x 256 a la experiencia del que juega"),
    (1, 0x7E57): ("mira_zeus", "en la pausa de F2 y en la sala 1 del castillo, cuenta las letras de ZEUS"),
    (1, 0x7EF1): ("tecla_f5", "C si F5 esta apretada (fila 7 de la matriz)"),
    (2, 0x922B): ("paga", "resta BC (BCD) de las monedas de 0xE048 y las repinta"),
    (2, 0x9234): ("resta_bcd", "(HL) -= BC en BCD"),
    (2, 0x923E): ("articulo_de_tienda", "C = precio y D = objeto del articulo 0xE692 de la tienda 0xE690"),
    (2, 0x94EF): ("mensaje", "pinta el mensaje A del banco 15 (+0x20 en ingles, segun 0x002B)"),
    (2, 0x9C13): ("tecla_ascii", "A = el ASCII de la primera tecla apretada (0 si ninguna)"),
    (3, 0xA8A0): ("cambia_izquierda_derecha", "en el mapa 9 sin el objeto 0x13 cambia los bits 2 y 3 del mando"),
    (3, 0xB337): ("muere", "la vida y la experiencia del que juega a cero"),
    (3, 0xB5EA): ("umbrella", "acaba con todas las figuras de tipo 0x0E (p03:B604)"),
}

RAM = {
    0xE000: ("el ESTADO del juego", "p00:428E despacha por el"),
    0xE001: ("el paso del estado", ""),
    0xE008: ("el mando: bits 2 y 3 los que p03:A8BE cambia en el mapa 9", "p03:A8B4"),
    0xE009: ("el mando (la otra copia que cambia p03:A8BE)", "p03:A8AB"),
    0xE020: ("el nombre del jefe acertado", "p02:9B14"),
    0xE026: ("ya se ha seguido con F5", "p01:7EBF"),
    0xE027: ("ZEUS tecleado", "p01:7E84"),
    0xE028: ("las letras de ZEUS acertadas", "p01:7E6E"),
    0xE041: ("el mapa (1 el castillo, 2-11 los mundos)", "tools/mapas.py"),
    0xE042: ("la sala", "tools/mapas.py"),
    0xE046: ("las flechas (BCD)", "p00:4D5A"),
    0xE048: ("las monedas (BCD)", "p00:4D7B"),
    0xE04A: ("las llaves (BCD)", "p00:4D82"),
    0xE052: ("la vida de Afrodita", "p01:619A, barra de 0x382D"),
    0xE053: ("el tope de la vida de Afrodita", "p01:61FB"),
    0xE056: ("la vida de Popolon", "p01:61C0, barra de 0x3822"),
    0xE057: ("el tope de la vida de Popolon", "p01:61FB"),
    0xE05C: ("la experiencia de Afrodita", "p01:6158"),
    0xE05E: ("el cambio de vida pendiente de Afrodita (con signo)", "p01:6203"),
    0xE05F: ("la experiencia de Popolon", "p01:6169"),
    0xE061: ("el cambio de vida pendiente de Popolon (con signo)", "p01:6130"),
    0xE097: ("el nivel de los objetos 0x28/0x2B/0x2C", "p02:91F4, p03:B74F"),
    0xE0D2: ("el estado del jefe", "p01:7EFC"),
    0xE0D3: ("que jefe (0x5E05 + mapa)", "p00:5856"),
    0xE500: ("el estado del personaje (5 = hundirse)", "p00:5832"),
    0xE501: ("quien juega (0 Afrodita)", "p01:612D"),
    0xE505: ("la y del personaje", ""),
    0xE507: ("la x del personaje", "0xF9 es el borde derecho (tools/omsx_partida.tcl)"),
    0xE635: ("cuantos huecos de figura hay", "p03:B5EE"),
    0xE690: ("la sala especial (pista o tienda)", "p02:8F4A"),
    0xE691: ("el paso de la sala especial", "p02:9126"),
    0xE692: ("el articulo elegido en la tienda", "p02:923E"),
    0xE6B8: ("las letras tecleadas", "p02:9B33"),
    0xE700: ("el tipo del jefe (el hueco 0xE700 es el jefe)", "p01:7F38"),
    0xE70A: ("el mosaico del jefe", "tests/jefes_openmsx.txt"),
    0xE800: ("los huecos de figura (32 bytes cada uno)", "p03:B5EA"),
    0xF0F8: ("los cartuchos de la otra ranura (bit 0 Knightmare, 1 Q*bert, 2 Game Master)", "p00:5F0C"),
}
for _k in range(1, 0x2D):
    RAM.setdefault(0xE06F + _k, ("tiene el objeto 0x%02X" % _k, "p03:B746"))

# Lo que es la PALABRA que empieza en esa direccion, para `ld hl,(nn)`...
RAM16 = {
    0xE041: "el mapa (0xE041) y la sala (0xE042) de un tiron",
    0xE046: "las flechas (BCD, 16 bits)",
    0xE048: "las monedas (BCD, 16 bits)",
    0xE04A: "las llaves (BCD, 16 bits)",
    0xE05C: "la experiencia de Afrodita",
    0xE05F: "la experiencia de Popolon",
}

# IX apunta a un hueco de figura cuando se carga con una de estas (el jefe y
# el primero de 0xE800; p03:B5EA los recorre de 32 en 32).
FICHAS_IX = (0xE700, 0xE800)
CAMPOS = {
    0x00: "el tipo de la figura",
    0x0A: "el mosaico de la figura",
    0x10: "la vida de la figura",       # p03:B580 la baja en cada golpe; a 0, p03:B604
}
