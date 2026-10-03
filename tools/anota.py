#!/usr/bin/env python3
"""Anota lo que ya esta identificado: rutinas con nombre, RAM y cambios de banco.

Una vez se sabe que 0xC281 es la casilla no tiene merito -ni fiabilidad-
escribir a mano "la casilla" las cincuenta veces que aparece. Esto lo hace
de una vez y sin equivocarse, en una seccion delimitada de src/pNN.notes que
reescribe entera cada vez.

- RUTINAS: el nombre de cada rutina (directiva L) y, en cada `call`/`jp` que
  va a ella, un comentario con lo que hace.
- RAM: en cada instruccion que nombra una direccion de la tabla, que es.
- Los cambios de banco (`ld (0x6000/0x8000/0xA000),a` con un `ld a,N` o un
  `inc a` delante) y las copias en 0xF0F1-0xF0F3.

CADA ENTRADA LLEVA DE DONDE SALE. Lo que no se sabe no esta en la tabla.
Donde ya hay un comentario escrito a mano no se pone otro.

Uso: anota.py              informa de cuantos pondria
     anota.py --escribe    y los escribe
"""
import os
import re
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)

from paginas import ORG                                    # noqa: E402

BANCOS = (0, 1, 2, 3, 10)
INI = "# --- ANOTACIONES AUTOMATICAS (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de las anotaciones de anota.py ---"

# (banco, direccion) -> (nombre, lo que hace). Cada una leida en el listado.
RUTINAS = {
    (0, 0x4045): ("interrupcion", "cada cuadro, por H.TIMI: el sonido (banco 10 en 0x6000) y el juego"),
    (0, 0x4083): ("hl_mas_a", "HL += A"),
    (0, 0x4088): ("de_mas_a", "DE += A"),
    (0, 0x408D): ("despacha", "salta a la entrada A de la tabla que va detras del call"),
    (0, 0x4097): ("init", "arranque del cartucho"),
    (0, 0x4129): ("calla_y_guarda", "guarda los volumenes del PSG (registros 8-10) en 0xEF11-0xEF13 y los pone a cero"),
    (0, 0x4141): ("calla_el_psg", "los tres volumenes del PSG a cero"),
    (0, 0x4154): ("devuelve_volumen", "vuelve a poner los volumenes guardados en 0xEF11-0xEF13"),
    (0, 0x416F): ("musica_de_la_zona", "la musica del juego de graficos de la zona (tabla 0x4182)"),
    (0, 0x4188): ("enlaces_de_la_zona", "copia los enlaces entre casillas de la zona a 0xE780"),
    (0, 0x41F6): ("indice_de_la_zona", "A = (fase * 7 + zona) * 2"),
    (0, 0x4206): ("bancos_1_2_3", "pone los bancos 1, 2 y 3"),
    (0, 0x4220): ("bancos_4_5_6", "pone los bancos 4, 5 y 6"),
    (0, 0x4238): ("bancos_7_8_9", "pone los bancos 7, 8 y 9"),
    (0, 0x4250): ("bancos_10_11_12", "pone los bancos 10, 11 y 12"),
    (0, 0x4268): ("bancos_13_14_15", "pone los bancos 13, 14 y 15"),
    (0, 0x4280): ("rotulo_numero", "pinta el rotulo A de la tabla de 0xA9C0 (banco 12)"),
    (0, 0x4295): ("pantallas_de_la_zona", "descomprime las pantallas de la zona a 0xD000"),
    (0, 0x42AC): ("bloques_de_la_zona", "descomprime los bloques de la zona a 0xE100"),
    (0, 0x42C3): ("rle_a_la_ram", "descomprime un rle a la RAM"),
    (0, 0x42E1): ("empieza_texto", "empieza un texto letra a letra: HL el texto, DE el sitio (0xCD61-0xCD67)"),
    (0, 0x42F1): ("sigue_texto", "saca la letra siguiente del texto de 0xCD65 (0xFF acaba)"),
    (0, 0x4351): ("empieza_la_partida", "la RAM de la partida a cero desde 0xC25A, y vidas de 0x437B"),
    (0, 0x437E): ("suma_puntos", "suma puntos en BCD al jugador que juega"),
    (0, 0x43E2): ("pinta_el_marcador", "pinta el marcador entero"),
    (0, 0x4406): ("pinta_los_puntos", "pinta los puntos"),
    (0, 0x4418): ("pinta_las_vidas", "pinta las vidas"),
    (0, 0x4420): ("pinta_bcd", "pinta cifras en BCD"),
    (0, 0x4449): ("intercambia", "intercambia los bytes de (HL) y (DE)"),
    (0, 0x447C): ("palabra_de_tabla_de", "DE = la palabra A de la tabla de DE"),
    (0, 0x4321): ("avanza_la_x", "la x del texto (0xCD61) avanza A puntos"),
    (0, 0x4438): ("pinta_una_cifra", "pinta la cifra de abajo de A (con C = 0, un cero sale en blanco)"),
    (0, 0x4458): ("parpadea_la_opcion", "la marca de 0x63D8 parpadea en la opcion escogida (0xC252)"),
    (0, 0x4476): ("marca_de_opcion", "pinta (C = 0xFF) o borra (C = 0) la marca de 0x63D8 en DE"),
    (0, 0x4485): ("marco_de_la_vida", "el marco de la barra de vida, del ancho de la vida maxima"),
    (0, 0x4496): ("lee_de_la_vram", "copia BC bytes de la VRAM de HL a DE"),
    (0, 0x44A9): ("vueltas_de_bc", "de BC, las vueltas de un bucle de inir/otir (B y A); cambia HL y DE"),
    (0, 0x44DD): ("lee_un_byte_de_la_vram", "A = el byte de la VRAM de HL"),
    (0, 0x44E9): ("escribe_un_byte_en_la_vram", "escribe A en la VRAM de HL"),
    (0, 0x44B1): ("copia_a_la_vram", "copia BC bytes de HL a la VRAM de DE"),
    (0, 0x44C4): ("rellena_la_vram", "llena BC bytes de la VRAM de HL con A"),
    (0, 0x44F7): ("vram_para_escribir", "prepara el V9938 para escribir en la VRAM"),
    (0, 0x4516): ("vram_para_leer", "prepara el V9938 para leer de la VRAM de HL"),
    (0, 0x4533): ("rle_con_destino", "descomprime a la VRAM un rle que lleva el destino delante"),
    (0, 0x4539): ("rle_a_la_vram", "descomprime un rle a la VRAM"),
    (0, 0x455C): ("rle_vuelto_con_destino", "como rle_vuelto, con la VRAM de destino delante del rle"),
    (0, 0x4562): ("rle_vuelto", "descomprime sprites de 16x16 dados la vuelta (espejo) y los sube a la VRAM de HL"),
    (0, 0x4598): ("sitio_del_byte_vuelto", "el sitio del byte siguiente al dar la vuelta a un sprite de 16x16"),
    (0, 0x45C0): ("bits_al_reves", "da la vuelta a los bits de A"),
    (0, 0x45CB): ("borra_la_pagina", "esconde los sprites y pinta del color 0 los 256 x 256 puntos"),
    (0, 0x45D3): ("borra_la_pantalla", "borra la pantalla"),
    (0, 0x45E1): ("enciende_la_pantalla", "bit 6 del registro 1 del VDP a uno"),
    (0, 0x45EE): ("apaga_la_pantalla", "bit 6 del registro 1 del VDP a cero"),
    (0, 0x45FB): ("pinta_de_color_0", "rellena del color 0 B x C puntos desde (0, 0) y pone el scroll a 0"),
    (0, 0x460A): ("esconde_los_sprites", "y = 0xE0 a los 32 sprites de la VRAM (0xF600 y 0x7600) y de la RAM"),
    (0, 0x4626): ("sprites_fuera", "apaga los sprites (bit 1 del registro 8 del VDP)"),
    (0, 0x4631): ("sprites_dentro", "enciende los sprites (bit 1 del registro 8 del VDP a cero)"),
    (0, 0x463C): ("pon_un_color", "color A de la paleta = DE"),
    (0, 0x4666): ("pon_paleta", "pone una lista de colores en la paleta"),
    (0, 0x4674): ("espera_al_vdp", "espera a que el V9938 acabe la orden"),
    (0, 0x467D): ("lee_estado_del_vdp", "lee un registro de estado del V9938"),
    (0, 0x469D): ("linea_horizontal", "orden LINE: B puntos desde (H, L) a la derecha, del color C"),
    (0, 0x46D0): ("linea_vertical", "orden LINE: B puntos desde (H, L) hacia abajo, del color C"),
    (0, 0x4704): ("marco", "pinta un marco: (H, L), D de ancho, E de alto, color C"),
    (0, 0x471E): ("linea_vertical_guardando", "linea_vertical sin perder HL, DE ni BC"),
    (0, 0x4728): ("linea_horizontal_guardando", "linea_horizontal sin perder HL, DE ni BC"),
    (0, 0x4732): ("hmmv", "orden HMMV del V9938: rellena un rectangulo (H, L, pagina D; B x C; color A)"),
    (0, 0x476E): ("hmmm", "orden HMMM del V9938: copia el rectangulo de (H, L) a (D, E), B x C; paginas en A"),
    (0, 0x47B2): ("hmmc", "orden HMMC del V9938: los puntos de HL a (D, E), B x C; pagina A"),
    (0, 0x4803): ("lmmm", "orden LMMM del V9938: copia un rectangulo con operacion logica"),
    (0, 0x484F): ("sube_letras", "sube B letras de 1 bit de HL a la VRAM, del color C"),
    (0, 0x4858): ("sube_una_letra", "sube la letra de 1 bit de HL a (D, E) de la pagina 1, del color C"),
    (0, 0x4879): ("sube_un_dibujo", "un dibujo de 8x8 a 4 bits (32 bytes) de HL a la VRAM de DE"),
    (0, 0x488E): ("sube_dibujos", "B dibujos de 8x8 seguidos a la VRAM, 32 por fila"),
    (0, 0x48A3): ("sube_un_dibujo_de_16", "un dibujo de 16x16 a 4 bits (128 bytes) de HL a la VRAM de DE"),
    (0, 0x48B8): ("sube_dibujos_de_16", "B dibujos de 16x16 seguidos a la VRAM"),
    (0, 0x48CD): ("letra_a_4_bits", "la letra de 1 bit de HL a 4 bits en 0xC210, del color C"),
    (0, 0x48F3): ("rotulo", "pinta un rotulo: [x][y] y el texto; 0xFE otra posicion, 0xFF acaba"),
    (0, 0x48F7): ("borra_rotulo", "borra un rotulo ([x][y] y el texto)"),
    (0, 0x48FD): ("rotulo_sin_posicion", "pinta el texto de HL en DE (D = x, E = y), sin [x][y] delante; C = 0 borra"),
    (0, 0x491C): ("letra", "pinta la letra A en DE (D = x, E = y), copiandola de la pagina 1; 0 es un hueco"),
    (0, 0x4935): ("letra_repetida", "pinta B veces la letra A seguidas"),
    (0, 0x4940): ("caracter", "pinta el caracter A de la pagina 1 en DE de la pagina 0"),
    (0, 0x4952): ("caracter_transparente", "como caracter, con LMMM y TIMP: el color 0 deja ver lo de debajo"),
    (0, 0x4964): ("caracter_en_la_pagina_1", "pinta el caracter A de la pagina 1 en DE de la misma pagina"),
    (0, 0x4976): ("sitio_del_caracter", "H = x, L = y del caracter A en la pagina 1 (32 por fila)"),
    (0, 0x4984): ("siguiente_sitio", "D 8 puntos a la derecha; al dar la vuelta, E 8 mas abajo"),
    (0, 0x498E): ("prepara_el_vdp", "pasa a SCREEN 5 y pone los registros del V9938"),
    (0, 0x49D2): ("lee_los_mandos", "en partida: F1-F3 a 0xC00C/0xC00B y el mando 1 con el teclado a 0xC007/0xC006"),
    (0, 0x49E7): ("apretado_y_nuevo", "guarda A en (HL) y en (HL-1) lo que no estaba apretado antes"),
    (0, 0x49EE): ("lee_mando_y_teclado", "A = el mando 1 y el teclado juntos: bits 0-3 direcciones, 4-5 botones"),
    (0, 0x4A37): ("lee_f1_f3", "A = F1, F2 y F3 en los bits 0-2"),
    (0, 0x4B5D): ("dibujos_del_pasadizo_secreto", "los dibujos, la paleta y los sprites del pasadizo secreto"),
    (0, 0x4C0E): ("vueltos_del_juego", "de la tabla de 0x4C57: DE el sitio, B cuantos y HL de donde, de los dibujos que van dados la vuelta"),
    (0, 0x4A43): ("dibujos_de_konami", "sube los dibujos del logotipo de Konami"),
    (0, 0x4A6D): ("letras_del_texto", "sube las letras de los textos"),
    (0, 0x4A96): ("caracteres_del_juego", "sube los caracteres del juego de graficos de la zona"),
    (0, 0x4B91): ("caracteres_del_titulo", "sube los caracteres del titulo"),
    (0, 0x4C75): ("sube_dibujos_vueltos", "sube dibujos dados la vuelta"),
    (0, 0x4CAB): ("sprites_del_jugador", "sube los sprites del jugador"),
    (0, 0x4CD4): ("patrones_del_final", "los patrones de sprite de 0xBE32 (banco 6) a 0xF800"),
    (0, 0x4CE3): ("paleta_de_la_zona", "pone la paleta del juego de graficos de la zona"),
    (0, 0x4CFC): ("paleta_base", "pone la paleta base"),
    (0, 0x4D2C): ("colores_del_sitio", "cambia los colores del sitio (0xC267)"),
    (0, 0x4D48): ("paleta_del_titulo", "pone la paleta de 0xA44E (banco 9)"),
    (0, 0x4D81): ("palabra_de_tabla", "HL = la palabra A de la tabla de HL"),
    (0, 0x4D89): ("sprites_de_0xF8C0", "patrones de sprite de 0x9369 (banco 8) a 0xF8C0 y de 0x87D1 (banco 11) a 0xF900"),
    (0, 0x4DA4): ("dibujos_de_siempre", "los dibujos de la pagina 1 que estan en todas las zonas (bancos 7 y 8)"),
    (0, 0x4E7F): ("hmmc_a_la_pagina_1", "hmmc con A = 1: los puntos de HL a (D, E) de la pagina 1"),
    (0, 0x4E84): ("pinta_pieza", "pinta la pieza de 16x16 de (B, C) de la pagina 1 en (D, E) + (0xCD28, 0xCD27) y la marca en 0xD800"),
    (0, 0x4EB9): ("pinta_icono", "pinta en DE el icono A de la pagina 1 (tabla 0x4EFC); 0xFF lo borra"),
    (0, 0x4ED7): ("borra_icono", "pinta en blanco los cuatro caracteres de 16x16 desde DE"),
    (0, 0x4EEC): ("caracter_en_blanco", "DE += HL y pinta alli el caracter en blanco"),
    (0, 0x4EF1): ("copia_caracter", "el caracter de (H, L) de la pagina 1 en (D, E) de la 0 (LMMM IMP)"),
    (0, 0x4F26): ("marca_el_caracter", "pone la marca de 0xCD2A en el caracter (D, E) del mapa de 0xD800"),
    (0, 0x4F47): ("pinta_pasadizo", "pinta el pasadizo A con la pieza de (0x00, 0x80): 9 filas de bits de 0xAB18 (banco 9)"),
    (0, 0x4F94): ("ocho_piezas", "pinta la pieza de BC donde haya un bit a uno en A, de 16 en 16 puntos"),
    (0, 0x4FB5): ("sonido_a_cero", "para la musica y los efectos y pone el mezclador del PSG"),
    (0, 0x4FC7): ("calla_la_musica", "sin musica ni efecto: los cuatro manejadores a canal_en_reposo"),
    (0, 0x4FE4): ("sonido", "A: 0x80 + n la musica n, 1-0x7F un efecto, 0 calla, 0xFD pausa, 0xFE sigue, 0xFF fundido"),
    (0, 0x51D6): ("suena_algo", "Z si no suena nada; A = la musica que suena"),
    (0, 0x51ED): ("monta_la_pantalla", "monta en 0xD800 la pantalla de la casilla: 8 x 6 bloques de 4 x 4 caracteres"),
    (0, 0x5306): ("pantalla_de_la_casilla", "A = la pantalla de la casilla de 0xC281 (tabla de 0xE700)"),
    (0, 0x5311): ("rejilla_de_la_zona", "la pantalla de cada casilla de la zona, a 0xE700 (tabla 0x600C, banco 13)"),
    (0, 0x534E): ("pinta_la_pantalla", "pinta los caracteres de 0xD800 en la pantalla"),
    (0, 0x5382): ("cosas_de_la_pantalla", "llena la lista de 0xC500 con lo de esta pantalla (0x97D5) y esta casilla (0x981D)"),
    (0, 0x53E3): ("figura_del_interior", "los sprites de un interior (figuras 0x22-0x24)"),
    (0, 0x5413): ("dibujos_de_las_figuras", "los patrones y los colores 4 y 6 de las figuras de la casilla (fichas de 0xA830, banco 12)"),
    (0, 0x54E6): ("colores_de_la_figura", "los 16 colores de cada sprite de la figura, con la lista de su pose (0x554E)"),
    (0, 0x57FA): ("pinta_cosa_del_marcador", "pinta la cosa A del marcador (0-9; la 0x0A va aparte)"),
    (0, 0x5825): ("x_de_la_cosa", "D = el byte de DE (la x), E = 0x10"),
    (0, 0x5834): ("pinta_cuantas", "el icono A tantas veces como diga (HL), en tres sitios; el resto en blanco"),
    (0, 0x5856): ("pinta_las_cosas", "pinta las cosas del marcador"),
    (0, 0x5863): ("pinta_la_cosa_0a", "la cosa 0x0A del marcador, en (0xB8, 0x10), si 0xC27E no es cero"),
    (0, 0x5878): ("resta_vida", "quita A de la vida, hasta 0, y la pinta"),
    (0, 0x5884): ("suma_vida", "suma A a la vida, hasta la maxima, y la pinta"),
    (0, 0x5890): ("pinta_la_vida", "pinta la barra de vida"),
    (0, 0x58C5): ("cuenta_el_tiempo", "cada 60 - fase * 5 cuadros, un segundo menos"),
    (0, 0x58F5): ("pinta_el_tiempo", "pinta el tiempo (4 cifras) en (0x48, 8)"),
    (0, 0x5900): ("gasta_la_cosa_8", "un segundo menos de la cosa 8; a cero, se pierde"),
    (0, 0x5915): ("resta_bcd", "(HL) -= DE, dos bytes en BCD"),
    (0, 0x591F): ("suma_bcd", "(HL) += DE, dos bytes en BCD"),
    (0, 0x5929): ("suma_dinero", "suma E ryo (BCD) al dinero, hasta 9999"),
    (0, 0x593A): ("pinta_el_dinero", "pinta el dinero (4 cifras) en (0x70, 8)"),
    (0, 0x5945): ("suma_tiempo", "suma DE (BCD) al tiempo, hasta 5000"),
    (0, 0x5958): ("resta_dinero", "resta DE ryo (BCD) al dinero, hasta 0"),
    (0, 0x5969): ("entra_en_el_pasadizo_secreto", "pasa al pasadizo secreto de la zona, en primera persona"),
    (0, 0x598D): ("pinta_el_pasadizo_secreto", "la vista del pasadizo secreto y el marcador"),
    (0, 0x59A9): ("monta_el_pasadizo_secreto", "monta en 0xD800 el pasadizo secreto de la zona (tablas 0xA575 y 0xA86D, banco 9)"),
    (0, 0x59D7): ("pasadizo_secreto_de_bits", "los bits del pasadizo secreto (A de ancho, B de alto), un byte por casilla en 0xD800"),
    (0, 0x5A10): ("marcas_del_pasadizo_secreto", "lo que hay en el pasadizo secreto (lista de DE), salvo lo ya cogido (0xC290)"),
    (0, 0x5A35): ("pon_si_no_esta", "pone C en (HL) si HL no esta entre las 11 palabras de 0xC290"),
    (0, 0x5A4C): ("por_28", "HL = A * 28"),
    (0, 0x5A59): ("ocho_bits_a_bytes", "hasta 8 bits de A a bytes 1/0 en HL; C cuenta lo que queda de fila"),
    (0, 0x5A6A): ("sitio_en_el_pasadizo_secreto", "HL = 0xD800 + H * 28 + L"),
    (0, 0x5A81): ("prepara_el_titulo", "borra, letras, caracteres y paleta del titulo"),
    (0, 0x5A93): ("pantalla_del_titulo", "pinta el titulo: dibujo de 20 x 12, 23 sprites, el marco y el menu"),
    (0, 0x5B09): ("franja_a_la_pagina_1", "con el jugador en el estado 0-1, copia la franja de y 0xE8 a la pagina 1; si no, los colores de los sprites"),
    (0, 0x5B1D): ("gira_los_sprites", "gira el orden de los sprites (0xC25F) y los sube a 0x7400/0x7600"),
    (0, 0x5B47): ("colores_girados", "los colores de los sprites a 0x7400, en el orden girado"),
    (0, 0x5B61): ("sube_colores_de_sprite", "la copia de 0xEC00-0xEE7F (colores y atributos de los sprites) a 0xF400"),
    (0, 0x5B6D): ("figuras_de_la_casilla", "DE = la lista de figuras de la casilla (conjunto de 0x9BF0, banco 14)"),
    (0, 0x5DBB): ("maquina_de_estados", "un cuadro: despacha por el estado de 0xC000 (16, tabla de 0x5DCF)"),
    (0, 0x5DEF): ("estado_0", "el logotipo de Konami y el titulo"),
    (0, 0x5E15): ("estado_1", "el menu del titulo"),
    (0, 0x5E1F): ("estado_2", "la demostracion"),
    (0, 0x5E48): ("estado_3", "empieza la partida"),
    (0, 0x5EA3): ("estado_4", "la entrada en la zona"),
    (0, 0x5F17): ("estado_5", "el juego"),
    (0, 0x5F57): ("estado_6", "se pierde una vida"),
    (0, 0x5F86): ("estado_7", "sin vidas: continuar o se acabo"),
    (0, 0x5E2D): ("cambia_de_estado", "pasa al estado A, paso 0, con 0x20 cuadros de espera"),
    (0, 0x5E40): ("espera_y_sigue", "A cuadros de espera y el paso siguiente"),
    (0, 0x5E43): ("siguiente_paso", "pasa al paso siguiente (0xC001)"),
    (0, 0x5FE9): ("f5_apretada", "carry si F5 NO esta apretada"),
    (0, 0x5EEF): ("siguiente_estado", "el estado siguiente, paso 0, con 0x20 cuadros de espera"),
    (1, 0x6034): ("estado_8", "la zona pasada: su pantalla, el tiempo a puntos y la zona siguiente"),
    (1, 0x609C): ("estado_9", "se sale de la casilla"),
    (1, 0x60D4): ("estado_0a", "la pausa: F1 la quita, F2 al estado 0x0D, y se teclean las palabras"),
    (1, 0x610A): ("estado_0b", "la fase pasada"),
    (1, 0x61AF): ("estado_0c", "el menu del vecino (Game Master o Q*bert en la otra ranura)"),
    (1, 0x6232): ("estado_0d", "F2 en la pausa"),
    (1, 0x6256): ("estado_0e", "la contrasena"),
    (1, 0x6292): ("estado_0f", "el final del juego"),
    (1, 0x62FE): ("tras_el_titulo", "en los estados 0-2: una tecla salta al titulo, o en el menu elige"),
    (1, 0x635A): ("ventana_de_la_pausa", "la ventana con el texto de la pausa"),
    (1, 0x6374): ("quita_la_ventana", "devuelve lo que tapaba la ventana de la pausa"),
    (1, 0x6382): ("ventana", "guarda en la pagina 1 el rectangulo de (H, L), B x C, lo borra y le pone marco"),
    (1, 0x643F): ("logotipo_de_konami", "prepara el logotipo de Konami en la pagina 1"),
    (1, 0x6486): ("destapa_el_logotipo", "una linea mas del logotipo cada dos cuadros; al acabar, 0xC482 = 1"),
    (1, 0x64A9): ("cartel", "caracteres de HL en DE de la pagina 1; 0xFE [dx] baja, 0xFF acaba"),
    (1, 0x650A): ("tiempo_a_puntos", "el tiempo que queda, a puntos: 10 por segundo"),
    (1, 0x653C): ("texto_del_final", "monta en 0xD800 el texto del final, uno de cuatro"),
    (1, 0x65A2): ("sprites_del_final", "los 16 sprites de la ultima pantalla"),
    (1, 0x65F7): ("sale_de_la_casilla", "0xC281 = la casilla vecina por el lado de 0xC283 (enlaces de 0xE780)"),
    (1, 0x6617): ("enlaces_de_la_casilla", "los cuatro enlaces de la casilla a 0xC284-0xC287"),
    (1, 0x662C): ("prepara_la_partida", "letras, dibujos de siempre y la vida a 0x10"),
    (1, 0x663A): ("carga_la_zona", "carga la zona de 0xC280: graficos, pantallas, bloques, casillas, vida y tiempo, y entra en la casilla"),
    (1, 0x66F6): ("entra_en_la_casilla", "monta y pinta la casilla con sus figuras"),
    (1, 0x672F): ("entra_por_el_lado_5", "la casilla sin cosas fijas, con el jugador abajo en medio"),
    (1, 0x6756): ("punto_de_entrada", "la primera vez en la zona, el jugador en el primer sitio de 0xB8E0 donde se puede pisar"),
    (1, 0x6798): ("jugador_abajo_en_medio", "el jugador en (0x80, 0xB0); por el lado 6, solo la musica"),
    (1, 0x67B3): ("borra_las_figuras", "el tipo a 0 en las ocho fichas de 0xC600 y las ocho de 0xCA00"),
    (1, 0x67CC): ("borra_al_jugador", "los 0x60 bytes del jugador (0xC490) a cero"),
    (1, 0x67DA): ("esconde_los_sprites_de_ram", "y = 0xE0 en los 32 sprites de la copia de 0xEE00"),
    (1, 0x67E8): ("las_dos_de_0xc4d3", "p01:76AC con 0xC4D3 y con 0xC4E3"),
    (1, 0x67F4): ("borra_las_de_0xcc00", "0xCC00-0xCCFF a cero"),
    (1, 0x6802): ("cuadro_del_juego", "un cuadro del juego: el jugador en los pares, las figuras en los impares"),
    (1, 0x6877): ("f1_pausa", "F1 recien apretada: la pausa (0xC008 = 1) y carry"),
    (1, 0x688B): ("empieza_la_demo", "la demostracion: el otro jugador, zona 0, casilla 12, 99 vidas y 999 ryo"),
    (1, 0x68F3): ("cuadro_de_la_demo", "un cuadro de la demostracion"),
    (1, 0x6923): ("teclas_de_la_demo", "la tecla de la demostracion, cada dos cuadros"),
    (1, 0x693F): ("tecla_de_la_demo", "la tecla siguiente del guion de 0x6955"),
    (1, 0x69D1): ("pasadizo", "se entra o se sale de un pasadizo"),
    (1, 0x6A06): ("tramo_siguiente", "al tramo siguiente o al anterior del pasadizo"),
    (1, 0x6A14): ("pinta_el_tramo", "la pantalla del tramo de pasadizo 0xC484"),
    (1, 0x6A59): ("destino_del_pasadizo", "el tramo al entrar (0xEA80) o la casilla al salir (0xEB00)"),
    (1, 0x6A9C): ("en_la_puerta", "pone al jugador junto a la puerta (figura 6 o 7)"),
    (1, 0x6AFC): ("pasadizos_de_la_zona", "los tramos y las puertas de los pasadizos de la zona, a 0xEA00, 0xEA80 y 0xEB00"),
    (1, 0x6B5F): ("ensena_la_contrasena", "F2 en la pausa: la contrasena del sitio donde se esta"),
    (1, 0x6BE7): ("quita_la_contrasena", "devuelve lo que tapaba la ventana de la contrasena"),
    (1, 0x6BF5): ("en_dos_nibbles", "A en (HL) y (HL+1): el nibble de arriba y el de abajo"),
    (1, 0x6C03): ("teclea_la_contrasena", "una letra mas de la contrasena; con 9, la deshace y mira la suma: carry al acabar, 0xEB82 = 1 si vale"),
    (1, 0x6C7A): ("aplica_la_contrasena", "la fase, el jugador, la zona, la casilla y los colores de la contrasena de 0xEBC0"),
    (1, 0x6CAB): ("junta_nibbles", "A = L * 16 + H"),
    (1, 0x6CB8): ("contrasena_en_blanco", "nada tecleado"),
    (1, 0x6CD8): ("lee_el_teclado", "lee una tecla"),
    (1, 0x6D38): ("el_jugador", "el jugador, un cuadro: mandos y su estado (tabla de 0x6D4C)"),
    (1, 0x6D58): ("jugador_en_el_suelo", "estado 0: andar, saltar, el golpe, los hoyos"),
    (1, 0x6D9F): ("anda", "segun la direccion de A: velocidad y lado"),
    (1, 0x6DB9): ("pide_el_golpe", "0xC492 = 1"),
    (1, 0x6DBF): ("salta", "el salto: estado 1 y el efecto 1"),
    (1, 0x6DD6): ("cae_al_hoyo", "estado 2 y la musica 0x0B"),
    (1, 0x6E7B): ("velocidad_del_jugador", "0xC4A3 segun las cosas 0 (0x6E92) y parado"),
    (1, 0x6E9A): ("jugador_saltando", "estado 1: la curva del salto"),
    (1, 0x6F48): ("jugador_cayendo", "estado 2: baja y, al acabar la musica, pierde"),
    (1, 0x6F60): ("sprites_en_la_y", "los 16 sprites de la copia en la y del jugador + C"),
    (1, 0x6F8F): ("jugador_despedido", "estado 3: sin vida o sin tiempo, sale despedido"),
    (1, 0x700A): ("pierde", "fuera las cosas 0 y 1, a la entrada de la zona y el dinero a la mitad"),
    (1, 0x701E): ("dinero_a_la_mitad", "el dinero (BCD) entre dos"),
    (1, 0x706E): ("jugador_al_pasadizo", "estado 4: baja dando vueltas y entra o sale del pasadizo"),
    (1, 0x70A9): ("jugador_sale_de_la_zona", "estado 5: la puerta y sube; al acabar, 0xC282 = 1"),
    (1, 0x70F5): ("pinta_la_puerta", "la puerta de salida de la zona, 32 x 32"),
    (1, 0x710E): ("baja_0xc4a7", "0xC4A7 cuenta hasta 0"),
    (1, 0x7116): ("prisas", "por debajo de 50 segundos, su musica"),
    (1, 0x715D): ("sin_vida_o_tiempo", "sin vida (y sin la cosa 7) o sin tiempo: estado 3"),
    (1, 0x71A2): ("direccion_que_vale", "0xC485 = la direccion apretada"),
    (1, 0x71BB): ("bordes", "por los lados se sale de la casilla; puertas e interiores"),
    (1, 0x7258): ("puertas", "con arriba ante una puerta, se entra en el interior"),
    (1, 0x729D): ("salida_del_interior", "con abajo en la salida, fuera del interior"),
    (1, 0x72E6): ("salidas_especiales", "las puertas de 0xC28A: la de la zona (3 cosas 9) y la de la fase"),
    (1, 0x7370): ("mueve_al_jugador", "posicion += velocidad"),
    (1, 0x7395): ("donde_para_el_salto", "0xC4A6: los pasos del salto en los que hay pared"),
    (1, 0x741B): ("hasta_donde_salta", "segun las cosas 0, A = 0 sigue o compara con los cuadros del salto"),
    (1, 0x74A6): ("sprites_del_jugador_de_ram", "la posicion y los patrones de sus sprites en la copia de 0xEE00"),
    (1, 0x75E4): ("el_golpe", "el golpe del primer boton, o lanza algo con la cosa 1"),
    (1, 0x762B): ("lanza", "en un hueco libre de 0xC4D0 o 0xC4E0, con el efecto 9"),
    (1, 0x7655): ("velocidad_de_lo_lanzado", "4 puntos por cuadro hacia donde mira"),
    (1, 0x766C): ("hay_algo_lanzado", "NZ si 0xC4D0 o 0xC4E0 estan en uso"),
    (1, 0x7675): ("mueve_lo_lanzado", "posicion += velocidad de los dos"),
    (1, 0x768E): ("lanzado_fuera", "borra los que se salen de la pantalla"),
    (1, 0x76AC): ("borra_lo_lanzado", "sus 16 bytes a cero y su sprite fuera"),
    (1, 0x76D1): ("lo_lanzado", "un cuadro de lo lanzado"),
    (1, 0x771F): ("choca_arriba", "carry si hay pared encima"),
    (1, 0x7741): ("choca_abajo", "carry si hay pared debajo"),
    (1, 0x7763): ("en_un_hoyo", "carry si bajo los dos pies hay hoyo"),
    (1, 0x777E): ("choca_derecha", "carry si hay pared a la derecha"),
    (1, 0x7794): ("choca_izquierda", "carry si hay pared a la izquierda"),
    (1, 0x77AA): ("topes_del_juego", "pared y hoyos del juego de graficos, a 0xC4F0"),
    (1, 0x77D1): ("es_pared", "carry si el caracter A es pared"),
    (1, 0x77FD): ("es_hoyo", "carry si el caracter A es hoyo"),
    (1, 0x7833): ("choques", "los choques del jugador con las figuras, sus disparos, su golpe y lo lanzado"),
    (1, 0x7855): ("figuras_contra_el_jugador", "si le toca una figura que hace dano: parpadeo, efecto y lo que pierde"),
    (1, 0x78C4): ("disparos_contra_el_jugador", "si le toca un disparo de 0xCA00: 2 de vida o lo que lo pare"),
    (1, 0x78FA): ("golpe_contra_las_figuras", "si el golpe da a una figura: puntos y dinero"),
    (1, 0x793C): ("lanzado_contra_las_figuras", "si lo lanzado da a una figura: puntos y dinero, y se borra"),
    (1, 0x7926): ("efecto_del_golpe", "el efecto 0x0D (0x0C con el tipo 3)"),
    (1, 0x7980): ("puntos_del_tipo", "suma los puntos del tipo de la figura (0xB84C, en centenas)"),
    (1, 0x799D): ("dinero_del_tipo", "suma el dinero del tipo (0xB86D); los tipos 8 y 0x21 quitan 50"),
    (1, 0x79C8): ("toca_la_buena", "tocar un tipo 8 o 0x21: 1000 puntos (y 10 ryo con el bit 1 de 0xEF80)"),
    (1, 0x79E2): ("quita_la_cosa_0a", "pierde la cosa 0x0A; sin ella, 20 ryo"),
    (1, 0x79F0): ("quita_20_ryo", "20 ryo menos"),
    (1, 0x79F6): ("quita_4_de_vida", "4 de vida menos"),
    (1, 0x79F8): ("quita_vida", "B de vida menos, hasta 0"),
    (1, 0x7A04): ("quita_2_de_vida", "2 de vida menos"),
    (1, 0x7A08): ("lo_para", "carry si lleva lo que para a ese tipo, y se gasta uno"),
    (1, 0x7A20): ("gasta_una", "si (HL) no es cero, una menos y carry"),
    (1, 0x7A29): ("repinta_la_cosa", "pinta la cosa de la direccion L (0xC270 + n)"),
    (1, 0x7A2F): ("lo_para_del_disparo", "como lo_para, para los disparos"),
    (1, 0x7A3E): ("toca_el_disparo", "carry si el disparo IX toca al jugador"),
    (1, 0x7A4E): ("toca_la_figura", "carry si la figura IX toca al jugador"),
    (1, 0x7A61): ("le_da_el_golpe", "carry si el golpe da a la figura IX"),
    (1, 0x7A73): ("le_da_lo_lanzado", "carry si lo lanzado da a la figura IX"),
    (1, 0x7A85): ("caja_del_tipo", "A = la clase de caja del tipo, B y C su centro"),
    (1, 0x7ACA): ("caja_del_disparo", "A = la clase de caja del disparo, B y C su centro"),
    (1, 0x7B49): ("toca_al_jugador", "carry si la caja (H, L) en (B, C) toca al jugador"),
    (1, 0x7B67): ("toca_al_golpe", "carry si la caja toca el golpe, delante del jugador"),
    (1, 0x7BAA): ("toca_lo_lanzado", "carry si la caja toca alguno de los dos lanzados"),
    (1, 0x7BBC): ("toca_al_lanzado", "carry si la caja toca el lanzado IY"),
    (1, 0x7804): ("caracter_bajo", "A = el caracter de 0xD800 en el punto (D, E)"),
    (1, 0x781F): ("no_se_puede_estar", "carry si en (D, E) no se puede estar: hoyo o pared (0xC4F1, 0xC4F0)"),
    (1, 0x7BDA): ("lo_del_suelo", "las cosas de 0xCC00: se cogen, o una boca de pasadizo"),
    (1, 0x7CDB): ("golpe_al_0e", "el golpe contra el tipo 0x0E de 0xCC00"),
    (1, 0x7D0D): ("entrada_del_pasadizo_secreto", "con 0xCDB0, arriba en (0x30-0x50, 0x40) se entra en el pasadizo secreto"),
    (1, 0x7D30): ("cerca_de_la_figura", "carry si el jugador esta a menos de 32 de la figura"),
    (1, 0x7D4A): ("toca_de_8", "carry si el jugador toca la caja de 8 x 8 de la figura"),
    (1, 0x7D56): ("coge", "lo que da el tipo 1 (la cosa 1) o el 2 (la cosa 0), o 10 ryo"),
    (1, 0x7D7E): ("efecto_del_tipo", "el efecto de sonido del tipo (0x7D98)"),
    (1, 0x7D9E): ("salidas_de_la_casilla", "0xC520: la salida especial de la casilla (tabla 0xB5D6)"),
    (1, 0x7DE9): ("cosas_de_la_casilla", "la lista de 0xC500 de la casilla (tabla 0x981D)"),
    (1, 0x7E34): ("vacia_0xc500", "0xC500-0xC52F a cero"),
    (1, 0x7E42): ("las_del_tipo_14", "las cosas de tipo 0x14 de la zona a 0xC340; una al azar marcada"),
    (1, 0x7E9D): ("limpia_0xc340", "deja solo el bit 7 de cada marca de 0xC340"),
    (1, 0x7EAB): ("busca_al_vecino", "0xEF00 = 0xFF si hay un Game Master (firma en 0x7FFA) o un Q*bert (0xBFFA) en otra ranura"),
    (1, 0x7ED1): ("busca_en_subranuras", "las cuatro subranuras de la ranura C"),
    (1, 0x7EE5): ("es_el_vecino", "carry si en la ranura C esta la firma de Q*bert o la del Game Master"),
    (1, 0x7EF9): ("compara_en_ranura", "carry si los B bytes de HL en la ranura C son los de DE"),
    (1, 0x7F1A): ("menu_del_vecino", "la ventana, el marco y el texto del menu"),
    (1, 0x7F28): ("ventana_del_menu", "borra (0x20, 0x90), 0xC0 x 0x38"),
    (1, 0x7F2E): ("rellena_y_mide", "rellena (H, L) B x C del color 0; DE = el tamano"),
    (1, 0x7F39): ("ventana_con_marco", "rellena y le pone marco"),
    (1, 0x7F83): ("opcion_1", "texto y numero (0xEF05) de la opcion 1"),
    (1, 0x7FA3): ("opcion_2", "texto y numero (0xEF07) de la opcion 2"),
    (1, 0x7FB1): ("texto_de_opcion", "borra la linea y pinta el rotulo de HL"),
    (1, 0x7FC8): ("borra_las_opciones", "borra (0x24, 0xA0), 0xB8 x 0x20"),
    (1, 0x7FD1): ("cifra_del_menu", "la cifra tecleada en el menu del vecino"),
    (2, 0x8334): ("crea_figura", "crea una figura en el primer hueco libre de 0xC600"),
    (2, 0x87B7): ("borra_la_figura", "borra la figura"),
    (2, 0x87E4): ("pon_velocidad_x", "velocidad horizontal de la figura ((ix+8), (ix+9)) = DE"),
    (2, 0x87EB): ("pon_velocidad_y", "velocidad vertical de la figura ((ix+6), (ix+7)) = DE"),
    (2, 0x893D): ("pon_la_pose", "pone la pose de la figura"),
    (2, 0x89C2): ("dispara", "crea el disparo A (tabla de 0x8B6B)"),
    (2, 0x8C0A): ("niega_de", "DE = -DE"),
    (2, 0x90C0): ("cosas_fijas", "pinta las cosas fijas de la casilla"),
    (2, 0x960C): ("texto_de_la_zona", "el texto de la zona"),
    (2, 0x99FB): ("dibujo_de_caracteres", "pinta un dibujo hecho de caracteres"),
    (3, 0xBAD2): ("hl_mas_de", "HL += DE"),
    (3, 0xBDF6): ("teclea_palabra", "las palabras de la pausa: 5 letras, comparadas con las de 0xBE44 y 0xBE49"),
    (3, 0xBE4E): ("claves_secretas", "las cuatro claves de 9 letras (0xBE8A) en vez de la contrasena"),
    (3, 0xA0ED): ("tipo_01_sale", "la figura de tipo 1 (0x01): su arranque (tabla de p02:8427)"),
    (3, 0xA0FE): ("tipo_01", "la figura de tipo 1 (0x01), un cuadro (tabla de p02:871C)"),
    (3, 0xA296): ("tipo_02_sale", "la figura de tipo 2 (0x02): su arranque (tabla de p02:8427)"),
    (3, 0xA2CF): ("tipo_02", "la figura de tipo 2 (0x02), un cuadro (tabla de p02:871C)"),
    (3, 0xA151): ("tipo_03_sale", "la figura de tipo 3 (0x03): su arranque (tabla de p02:8427)"),
    (3, 0xA184): ("tipo_03", "la figura de tipo 3 (0x03), un cuadro (tabla de p02:871C)"),
    (3, 0xA368): ("tipo_04_sale", "la figura de tipo 4 (0x04): su arranque (tabla de p02:8427)"),
    (3, 0xA3E0): ("tipo_04", "la figura de tipo 4 (0x04), un cuadro (tabla de p02:871C)"),
    (3, 0xA3F9): ("tipo_05_sale", "la figura de tipo 5 (0x05): su arranque (tabla de p02:8427)"),
    (3, 0xA48D): ("tipo_05", "la figura de tipo 5 (0x05), un cuadro (tabla de p02:871C)"),
    (3, 0xA49E): ("tipo_06_sale", "la figura de tipo 6 (0x06): su arranque (tabla de p02:8427)"),
    (3, 0xA4BC): ("tipo_06", "la figura de tipo 6 (0x06), un cuadro (tabla de p02:871C)"),
    (3, 0xAAD5): ("tipo_10_sale", "la figura de tipo 10 (0x0A): su arranque (tabla de p02:8427)"),
    (3, 0xAB0C): ("tipo_10", "la figura de tipo 10 (0x0A), un cuadro (tabla de p02:871C)"),
    (2, 0x9CE9): ("tipo_18_sale", "la figura de tipo 18 (0x12): su arranque (tabla de p02:8427)"),
    (2, 0x9D32): ("tipo_18", "la figura de tipo 18 (0x12), un cuadro (tabla de p02:871C)"),
    (2, 0x9BE3): ("tipo_29_sale", "la figura de tipo 29 (0x1D): su arranque (tabla de p02:8427)"),
    (2, 0x9BFF): ("tipo_29", "la figura de tipo 29 (0x1D), un cuadro (tabla de p02:871C)"),
    (3, 0xB16C): ("tipo_36_sale", "la figura de tipo 36 (0x24): su arranque (tabla de p02:8427)"),
    (3, 0xB1BA): ("tipo_36", "la figura de tipo 36 (0x24), un cuadro (tabla de p02:871C)"),
    (3, 0xAD39): ("tipo_37_sale", "la figura de tipo 37 (0x25): su arranque (tabla de p02:8427)"),
    (3, 0xAD78): ("tipo_37", "la figura de tipo 37 (0x25), un cuadro (tabla de p02:871C)"),
    (3, 0xB086): ("tipo_38_sale", "la figura de tipo 38 (0x26): su arranque (tabla de p02:8427)"),
    (3, 0xB09F): ("tipo_38", "la figura de tipo 38 (0x26), un cuadro (tabla de p02:871C)"),
    (3, 0xAF10): ("tipo_39_sale", "la figura de tipo 39 (0x27): su arranque (tabla de p02:8427)"),
    (3, 0xAF36): ("tipo_39", "la figura de tipo 39 (0x27), un cuadro (tabla de p02:871C)"),
    (3, 0xB0FA): ("tipo_40_sale", "la figura de tipo 40 (0x28): su arranque (tabla de p02:8427)"),
    (3, 0xB12A): ("tipo_40", "la figura de tipo 40 (0x28), un cuadro (tabla de p02:871C)"),
    (3, 0xB551): ("tipo_43_sale", "la figura de tipo 43 (0x2B): su arranque (tabla de p02:8427)"),
    (3, 0xB573): ("tipo_43", "la figura de tipo 43 (0x2B), un cuadro (tabla de p02:871C)"),
    (3, 0xB34F): ("tipo_44_sale", "la figura de tipo 44 (0x2C): su arranque (tabla de p02:8427)"),
    (3, 0xB36C): ("tipo_44", "la figura de tipo 44 (0x2C), un cuadro (tabla de p02:871C)"),
    (2, 0x9653): ("tipo_45_sale", "la figura de tipo 45 (0x2D): su arranque (tabla de p02:8427)"),
    (2, 0x9678): ("tipo_45", "la figura de tipo 45 (0x2D), un cuadro (tabla de p02:871C)"),
    (2, 0x9712): ("tipo_46_sale", "la figura de tipo 46 (0x2E): su arranque (tabla de p02:8427)"),
    (2, 0x9727): ("tipo_46", "la figura de tipo 46 (0x2E), un cuadro (tabla de p02:871C)"),
    (3, 0xB68D): ("tipo_47_sale", "la figura de tipo 47 (0x2F): su arranque (tabla de p02:8427)"),
    (3, 0xB692): ("tipo_47", "la figura de tipo 47 (0x2F), un cuadro (tabla de p02:871C)"),
    (3, 0xB5EC): ("tipos_07_13_sale", "los tipos 7 y 13: su arranque"),
    (3, 0xA4EB): ("andador", "un cuadro de los tipos 7, 8, 16, 19, 20, 27, 28, 30 y 33"),
    (3, 0xA4D3): ("andador_sale", "el arranque de los tipos 8, 16, 19, 20, 27, 28, 30 y 33"),
    (3, 0xA747): ("perseguidor_sale", "el arranque de los tipos 9, 14, 15, 17, 21-26, 31 y 32: los que persiguen al jugador"),
    (3, 0xA778): ("perseguidor", "un cuadro de los tipos 9, 13-15, 17, 22-26, 31 y 32: persiguen al jugador"),
    (3, 0xA763): ("tipo_21", "la figura de tipo 21 (0x15), un cuadro"),
    (3, 0xABD3): ("tipos_11_12_sale", "los tipos 11 y 12: su arranque"),
    (3, 0xAC00): ("tipos_11_12", "los tipos 11 y 12, un cuadro"),
    (3, 0xACE6): ("tipos_34_35_sale", "los tipos 34 y 35 (0x22, 0x23): su arranque"),
    (3, 0xACFE): ("tipos_34_35", "los tipos 34 y 35, un cuadro"),
    (3, 0xB2AA): ("tipos_41_42_sale", "los tipos 41 y 42 (0x29, 0x2A): su arranque"),
    (3, 0xB2D2): ("tipos_41_42", "los tipos 41 y 42, un cuadro"),
    (2, 0x8AA2): ("disparo_1_sale", "el disparo 1: cae"),
    (2, 0x8AB9): ("disparo_2_sale", "el disparo 2: hacia el jugador"),
    (2, 0x8ACF): ("disparo_3_sale", "el disparo 3: hacia el jugador"),
    (2, 0x8AD8): ("disparo_4_sale", "el disparo 4: hacia el jugador"),
    (2, 0x8AE1): ("disparo_5_sale", "el disparo 5: en horizontal"),
    (2, 0x8B02): ("disparo_6_sale", "el disparo 6: en horizontal, por delante"),
    (2, 0x8B22): ("disparo_7_sale", "el disparo 7: sube y cae"),
    (2, 0x88EA): ("disparo_1", "el disparo 1, un cuadro"),
    (2, 0x8918): ("disparo_2", "el disparo 2, un cuadro"),
    (2, 0x892A): ("disparo_4", "el disparo 4, un cuadro"),
    (2, 0x8926): ("disparo_5", "el disparo 5, un cuadro"),
    (2, 0x8981): ("disparo_7", "el disparo 7, un cuadro"),
    (2, 0x8DB3): ("bloque_que_suelta", "las cosas del suelo 1-3: el bloque que al romperse suelta algo que rebota"),
    (2, 0x8D32): ("bloque_de_dinero", "la cosa del suelo 4: el bloque que da dinero"),
    (2, 0x8E4B): ("boca_de_pasadizo", "la cosa del suelo 6: la boca de un pasadizo"),
    (2, 0x8EC0): ("bloque_200_ryo", "la cosa del suelo 8: 200 ryo"),
    (2, 0x8F12): ("bloque_de_vida", "la cosa del suelo 9: 8 de vida"),
    (2, 0x8EF4): ("bloque_vida_extra", "la cosa del suelo 10: una vida"),
    (2, 0x8F25): ("bloque_cosa_0", "la cosa del suelo 11: una cosa 0"),
    (2, 0x8F43): ("bloque_cosa_9", "la cosa del suelo 12: una cosa 9"),
    (2, 0x8F9A): ("bloque_cosa_1", "la cosa del suelo 13: la cosa 1"),
    (2, 0x8FA6): ("pared_que_se_rompe", "la cosa del suelo 14: la pared que se rompe"),
    (2, 0x8ED5): ("bloque_vida_maxima", "la cosa del suelo 15: 4 de vida maxima"),
    (3, 0xB8C3): ("anda_por_el_pasadizo_secreto", "arriba avanza, izquierda y derecha giran, abajo da media vuelta, el boton el mapa"),
    (3, 0xB955): ("lo_de_delante", "hasta 4 casillas hacia delante: la pared y lo que hay"),
    (3, 0xB9CB): ("flecha_de_direccion", "los sprites de la flecha hacia donde se mira"),
    (3, 0xBA47): ("lado_izquierdo", "las paredes del lado izquierdo de la vista"),
    (3, 0xBA62): ("lado_derecho", "las paredes del lado derecho de la vista"),
    (3, 0xBAF1): ("mapa_del_pasadizo_secreto", "el mapa entero, si se tiene (0xC27A)"),
    (3, 0xBB1B): ("pinta_el_mapa", "el pasadizo secreto en piezas de 8 x 8, centrado"),
    (3, 0xBBAA): ("donde_se_esta", "la marca del jugador en el mapa"),
    (3, 0xBC27): ("sale_del_mapa", "el boton vuelve a la vista"),
    (3, 0xBC43): ("iconos_del_pasadizo_secreto", "los iconos de lo cogido en el pasadizo secreto"),
    (3, 0xBC5C): ("coge_en_el_pasadizo_secreto", "lo que hay en la casilla, una vez"),
    (3, 0xBCD3): ("apunta_lo_cogido", "la casilla, a la lista de 0xC290"),
    (3, 0xBCF2): ("pasadizo_secreto_a_cero", "lo cogido y el mapa, a cero"),
    (3, 0xBD06): ("salida_del_pasadizo_secreto", "la puerta, el premio y fuera"),
    (3, 0xBEAE): ("lo_que_da_la_clave", "jugador 2, vida 0x20, 2000 ryo o continuar"),
    (3, 0xBEDD): ("secreto_del_menu", "el bit 6 de 0xEF80"),
    (0, 0x4C26): ("dibujos_tras_perder_una_vida", "los dibujos y los patrones de sprite de la pantalla del estado 4, paso 0"),
    (0, 0x4D54): ("paleta_tras_perder_una_vida", "la paleta base y la de 0xA476"),
    (0, 0x5532): ("colores_de_la_pose", "sin pose, nada; con ella, la lista de tripletes de DE"),
    (1, 0x67C6): ("tipo_a_cero", "el tipo a 0 en B fichas de DE en DE"),
    (1, 0x6F64): ("sprites_en_la_y_del_jugador", "los 16 sprites de la copia en la y del jugador"),
    (1, 0x7069): ("paso_siguiente_del_jugador", "0xC491 + 1"),
    (1, 0x7132): ("justo_en_50", "si el tiempo esta justo en 50 segundos, la musica de las prisas una vez"),
    (1, 0x714E): ("musica_de_las_prisas", "0xC0AF = 1 y la musica 0x12"),
    (1, 0x7477): ("e_8_arriba", "E -= 8"),
    (1, 0x747C): ("e_8_abajo", "E += 8"),
    (1, 0x7481): ("d_8_izquierda", "D -= 8"),
    (1, 0x7486): ("d_8_derecha", "D += 8"),
    (1, 0x748B): ("e_16_abajo", "E += 16"),
    (1, 0x7490): ("e_16_arriba", "E -= 16"),
    (1, 0x7495): ("d_16_derecha", "D += 16, y si se sale, 0xEE80 = 1"),
    (1, 0x749B): ("d_16_izquierda", "D -= 16, y si se sale, 0xEE80 = 1"),
    (1, 0x767E): ("mueve_un_lanzado", "posicion += velocidad del lanzado HL"),
    (1, 0x7697): ("lanzado_que_se_sale", "borra el lanzado HL si sale de la pantalla"),
    (1, 0x76EA): ("sprite_del_lanzado", "el sprite y los colores del lanzado DE en HL"),
    (1, 0x7706): ("colores_del_lanzado", "los 16 colores de 0x770F en DE"),
    (1, 0x7E8C): ("apunta_la_del_tipo_14", "la casilla y la marca de una cosa de tipo 0x14"),
    (2, 0x8065): ("cambia_de_jugador", "los 256 bytes de un jugador por los del otro"),
    (2, 0x8071): ("aplica_el_menu", "la zona, la fase y las vidas del menu del vecino"),
    (2, 0x80BB): ("marca_de_opcion_borrada", "C y B = 0: sin marca"),
    (2, 0x80EE): ("plano_de_la_fase", "3 filas de 28 caracteres de 0xA099"),
    (2, 0x8123): ("marcos_de_la_fase", "el rotulo 0x0C y los dos marcos"),
    (2, 0x813F): ("sprites_de_la_fase", "los colores y los sprites de la pantalla de la fase"),
    (2, 0x8192): ("marca_de_la_zona", "los dos sprites que marcan la zona"),
    (2, 0x81D0): ("colores_de_la_fase", "los colores de los sprites de la pantalla de la fase"),
    (2, 0x81EB): ("rellena_b", "B veces A desde HL"),
    (2, 0x81F0): ("zonas_de_la_fase", "los dibujos de las siete zonas"),
    (2, 0x822A): ("dibujo_del_juego", "el dibujo del juego de graficos A en DE"),
    (2, 0x8233): ("copia_32x24", "HMMM de 32 x 24 de la pagina 1 a la 0"),
    (2, 0x8255): ("figuras_que_salen", "las figuras que van saliendo"),
    (2, 0x828F): ("crea_por_tipo", "crea la figura de tipo A segun su tabla"),
    (2, 0x82F2): ("espera_de_figura", "la espera hasta la figura siguiente"),
    (2, 0x8302): ("cuantas_figuras", "cuantas figuras hay y si hay que esperar"),
    (2, 0x83D2): ("figura_a_cero", "los 32 primeros bytes de la figura a cero"),
    (2, 0x8485): ("patrones_de_la_figura", "los patrones de sus sprites, de la lista de DE"),
    (2, 0x84A0): ("hueco_del_sprite", "el sprite E de la figura usa el hueco D"),
    (2, 0x85E8): ("cerca_del_jugador", "carry si el jugador esta a menos de 32; pasado 0xC0, se borra"),
    (2, 0x861F): ("la_que_vuelve", "la primera de la lista sale otra vez cada tanto"),
    (2, 0x868E): ("las_figuras", "un cuadro de todas las figuras"),
    (2, 0x86BC): ("calcula_la_dificultad", "0xCD12 = fase + zona + cosas / 4"),
    (2, 0x86F1): ("sprites_de_los_disparos", "los sprites de las doce de 0xCA00"),
    (2, 0x86FC): ("sprites_de_las_figuras", "los sprites de las ocho de 0xC600"),
    (2, 0x8715): ("cuadro_del_tipo", "lo que hace cada tipo, por la tabla de 0x871C"),
    (2, 0x877A): ("mueve_la_figura", "x += velocidad horizontal e y += la vertical"),
    (2, 0x8791): ("mueve_en_vertical", "y += la velocidad vertical"),
    (2, 0x87A5): ("fuera_por_los_lados", "se borra si x < 8 o x >= 0xF8"),
    (2, 0x87B1): ("fuera_por_abajo", "se borra si y >= 0xE4"),
    (2, 0x87F2): ("sprites_segun_la_pose", "la y, la x y el patron de cada sprite segun la pose"),
    (2, 0x883C): ("x_del_sprite", "x + dx con signo; si se sale, el sprite no se ve"),
    (2, 0x8857): ("copia_los_disparos", "sprites de las doce de 0xCA00 a la copia de 0xEE20"),
    (2, 0x8861): ("copia_las_figuras", "sprites de las ocho de 0xC600 a la copia de 0xEE20"),
    (2, 0x8879): ("se_ve", "NC si la figura existe, se ve y lleva sprites"),
    (2, 0x8893): ("copia_sus_sprites", "la y, la x y el patron de cada sprite a 0xEE20"),
    (2, 0x88D5): ("cuadro_del_disparo", "lo que hace cada disparo, por la tabla de 0x88DC"),
    (2, 0x88FD): ("se_para", "velocidad 0"),
    (2, 0x89E9): ("crea_el_disparo", "el disparo en el primer hueco de 0xCA00"),
    (2, 0x8B48): ("mas_dificultad", "DE += la dificultad * 16"),
    (2, 0x8B76): ("hacia_el_jugador", "la velocidad hacia el jugador, de modulo A + dificultad * 8"),
    (2, 0x8BC2): ("angulo_al_jugador", "el angulo hacia el jugador, de la tabla de 0x8C30"),
    (2, 0x8C12): ("componente", "DE = (0xCD1D * E) / 32"),
    (2, 0x8C24): ("multiplica", "HL = H * E"),
    (2, 0x8CD2): ("cuadro_de_lo_del_suelo", "lo que hace cada cosa del suelo, por la tabla de 0x8CE1"),
    (2, 0x8D89): ("gravedad_de_la_moneda", "la velocidad vertical += 0x40"),
    (2, 0x8D8F): ("salta_arriba", "la velocidad vertical = 0xFC00"),
    (2, 0x8D95): ("cuanto_da_el_bloque", "5 ryo, o 50 si el tiempo acaba en dos cifras iguales e impares"),
    (2, 0x8E65): ("con_la_cosa_8", "con la cosa 8, el paso 4"),
    (2, 0x8E76): ("pared_abierta", "dos piezas de pared"),
    (2, 0x8E86): ("pieza_a0", "la pieza de (0xA0, 0x90) sin marca"),
    (2, 0x8E8F): ("pieza_vacia", "la pieza de (0x70, 0x90) sin marca"),
    (2, 0x8E99): ("pieza_rota", "la pieza de (0x00, 0x80) con marca de pared"),
    (2, 0x8EB1): ("pieza_en_la_figura", "la pieza de BC donde esta la figura"),
    (2, 0x8F57): ("apunta_lo_roto", "lo roto a la lista de 0xC2B0"),
    (2, 0x8FD5): ("crea_lo_del_suelo", "una cosa del suelo en 0xCC00, de los dos bytes de HL"),
    (2, 0x9066): ("marca_de_pared", "0xCD2A = 0xFF"),
    (2, 0x908C): ("huecos_seguidos", "los huecos de sprite, seguidos desde 0xCD41"),
    (2, 0x90AF): ("coge_un_hueco", "el hueco a la copia y a la figura"),
    (2, 0x911E): ("busca_la_casilla", "carry si la casilla no tiene cosas fijas"),
    (2, 0x9132): ("pinta_dibujo_fijo", "el dibujo A de 0xA02B"),
    (2, 0x9155): ("pinta_dibujo_del_tramo", "el dibujo A de 0xB36D"),
    (2, 0x91CB): ("a_dos", "A = 2"),
    (2, 0x91D8): ("esta_roto", "0xCD4F = si esto ya se rompio"),
    (2, 0x9221): ("tramos_de_la_zona", "lo de los tramos de la zona a 0xCDE0"),
    (2, 0x924E): ("tramos_que_faltan", "los tramos que faltan, a 0xFF"),
    (2, 0x92B2): ("lo_que_se_vende", "la lista y los precios de lo que se vende"),
    (2, 0x92DA): ("precio_de_la_cosa", "el precio de la cosa B, doblado por cada compra"),
    (2, 0x932A): ("tabla_de_precios", "DE = la tabla de precios del juego y del avance"),
    (2, 0x9364): ("suma_bcd_9999", "HL += DE en BCD, hasta 9999"),
    (2, 0x96A8): ("pose_del_2d", "las poses de la figura 0x2D"),
    (2, 0x96D3): ("trozo_del_dibujo", "un trozo mas del dibujo de la zona pasada"),
    (2, 0x974C): ("letra_cada_16", "una letra del texto cada 16 cuadros"),
    (2, 0x9785): ("filas_de_los_bordes", "las filas libres de los bordes"),
    (2, 0x97B2): ("filas_libres", "las 8 filas en las que se puede estar desde (D, E)"),
    (2, 0x97E4): ("sale_por_la_derecha", "x 0xF7, mirando a la izquierda"),
    (2, 0x9833): ("fila_al_azar", "una fila libre al azar"),
    (2, 0x9858): ("lista_de_filas", "las y de las filas libres a 0xCD00"),
    (2, 0x9876): ("apunta_fila", "la y a la lista y una mas"),
    (2, 0x9881): ("cuadro_del_pasadizo_secreto", "un cuadro del pasadizo secreto"),
    (2, 0x98AF): ("sprites_fuera_desde_2", "fuera los sprites desde el 2"),
    (2, 0x98BE): ("pinta_la_vista", "las paredes de la vista del pasadizo secreto"),
    (2, 0x98E3): ("sprites_de_la_vista", "los sprites de lo que hay delante"),
    (2, 0x98F8): ("sprite_de_lo_de_delante", "el sprite de lo que hay en la casilla C"),
    (2, 0x9AAB): ("timp_de_la_pagina_1", "LMMM con TIMP de la pagina 1 a la 0"),
    (2, 0x9AB0): ("sprites_del_final_de_fase", "8 sprites de 0x9AF4"),
    (2, 0x9ABF): ("cuatro_sprites", "4 sprites de 0x9B04"),
    (2, 0x9AC9): ("colores_del_final_de_fase", "los colores de 0xEC80"),
    (2, 0x9AD8): ("colores_de_0xec40", "los colores de 0xEC40"),
    (2, 0x9ADF): ("fuera_ocho", "fuera los 8 sprites desde el 8"),
    (2, 0x9AED): ("fuera_cuatro", "fuera los 4 sprites desde el 4"),
    (2, 0x9BBF): ("texto_de_la_fase", "HL = el texto del final de la fase"),
    (2, 0x9DF0): ("pose_de_la_7e", "la pose de (ix+0x7E), segun el lado"),
    (2, 0x9DFC): ("pose_cada_8", "la pose B o B + 1, cada 8 cuadros"),
    (3, 0xA067): ("guarda_la_velocidad", "la velocidad a (ix+0x79)-(ix+0x7C)"),
    (3, 0xA080): ("recupera_la_velocidad", "la velocidad de (ix+0x79)-(ix+0x7C)"),
    (3, 0xA13B): ("mas_vertical", "la velocidad vertical += DE"),
    (3, 0xA26C): ("mas_horizontal", "la velocidad horizontal += DE"),
    (3, 0xA27A): ("cuenta_y_dispara", "cuenta hasta irse y dispara el 2 cada 8"),
    (3, 0xA31F): ("rebota", "rebota con su gravedad"),
    (3, 0xA344): ("pon_salida", "(ix+0x12, 0x13) = DE"),
    (3, 0xA34B): ("pon_gravedad", "(ix+0x10, 0x11) = DE"),
    (3, 0xA352): ("lee_gravedad", "DE = (ix+0x10, 0x11)"),
    (3, 0xA359): ("lee_vertical", "DE = la velocidad vertical"),
    (3, 0xA398): ("al_azar", "A = un numero al azar"),
    (3, 0xA3A1): ("sale_de_abajo", "en x a 0x38 del jugador, y 0xC8"),
    (3, 0xA420): ("sale_por_un_lado", "por la izquierda o la derecha, si el jugador esta lejos"),
    (3, 0xA46B): ("segun_la_dificultad", "tres bytes de 0xA481 segun la dificultad"),
    (3, 0xA4D6): ("ficha_y_rumbo", "su ficha, su pose y su rumbo"),
    (3, 0xA50E): ("prueba_el_otro_eje", "prueba la direccion del otro eje que prefiere"),
    (3, 0xA560): ("preferencias_de_antes", "vuelven las direcciones que preferia"),
    (3, 0xA567): ("vertical_hacia_el_jugador", "la direccion vertical hacia el jugador"),
    (3, 0xA58A): ("pon_rumbo", "la direccion A y su velocidad"),
    (3, 0xA58E): ("velocidad_del_rumbo", "la velocidad de la direccion A segun la dificultad"),
    (3, 0xA5B8): ("rumbo_al_jugador", "arriba, abajo o 2, hacia el jugador"),
    (3, 0xA611): ("media_vuelta", "la direccion contraria"),
    (3, 0xA625): ("salta_por_encima", "NC si puede saltar por encima de lo que tiene delante"),
    (3, 0xA683): ("chocaria", "carry si en la direccion B choca"),
    (3, 0xA699): ("choca_al_avanzar", "carry si el paso siguiente choca"),
    (3, 0xA6BC): ("choca_en_direccion", "carry si en su direccion hay pared u hoyo"),
    (3, 0xA750): ("cada_cuanto_cambia", "la espera entre rumbos y los disparos"),
    (3, 0xA78D): ("jugador_delante", "carry si el jugador esta delante y a su altura"),
    (3, 0xA8B3): ("distancia_al_jugador", "las distancias en vertical y en horizontal hasta el jugador"),
    (3, 0xA917): ("cuando_dispara", "dispara cuando le toca"),
    (3, 0xA954): ("lado_segun_rumbo", "el lado segun hacia donde anda"),
    (3, 0xA966): ("se_para_a_ratos", "se para cada (ix+0x78) cuadros"),
    (3, 0xAA04): ("ficha_del_tipo", "la ficha del tipo de 0xAA51"),
    (3, 0xAA40): ("menos_dificultad", "A - la dificultad * 6, minimo H"),
    (3, 0xAB8C): ("dispara_el_4", "el disparo 4 cada tanto"),
    (3, 0xABC4): ("cae_al_acabar", "al acabar la cuenta de (ix+0x75), cae"),
    (3, 0xABF6): ("sale_como_los_demas", "por un lado, o al azar en la primera tanda"),
    (3, 0xAC6D): ("mira_al_jugador", "andando en vertical, mira al jugador"),
    (3, 0xAC83): ("listo_para_lanzarse", "(ix+0x1D) = 1 cada tanto"),
    (3, 0xAC98): ("se_lanza", "el disparo 5 si esta a la altura del jugador"),
    (3, 0xACB7): ("cuenta_de_0x75", "al acabar (ix+0x75), el paso siguiente"),
    (3, 0xAE11): ("compra_con_valor", "se paga y la cosa vale A"),
    (3, 0xAE38): ("paga_la_elegida", "paga el precio de la elegida: carry si no llega"),
    (3, 0xAE5B): ("una_mas", "una mas de la cosa, hasta 3"),
    (3, 0xAE81): ("fuera_de_la_tienda", "fuera el icono de la elegida"),
    (3, 0xAED5): ("texto_de_la_tienda", "el texto de la tienda, o el de sin dinero (AED9)"),
    (3, 0xAEF9): ("sube_el_precio", "una compra mas de la cosa elegida"),
    (3, 0xAEFC): ("sube_el_precio_de_a", "una compra mas de la cosa A"),
    (3, 0xAF6F): ("siguiente_que_se_tiene", "la cosa siguiente que se tiene"),
    (3, 0xAFBE): ("valor_de_cambio", "lo que vale la cosa en la casa de cambio"),
    (3, 0xB007): ("mitad_de_nibble", "la mitad de un nibble BCD"),
    (3, 0xB01A): ("x_de_la_ultima", "la x de la ultima que se tiene"),
    (3, 0xB024): ("vuelta_a_la_0", "pasada la 8, vuelta a la 0"),
    (3, 0xB070): ("da_continuar", "0xC27F = 1, con su texto"),
    (3, 0xB25F): ("pinta_los_dados", "las cifras de los dados y par o impar"),
    (3, 0xB289): ("hay_dinero", "carry si no hay dinero"),
    (3, 0xB303): ("espera_al_otro_dado", "el dado 0x2A espera al otro"),
    (3, 0xB320): ("cara_siguiente", "la cara siguiente del dado"),
    (3, 0xB43F): ("fundido", "un paso del fundido de la paleta"),
    (3, 0xB539): ("paga", "paga DE ryo: carry si no llega"),
    (3, 0xB67A): ("fila_a_cero", "las cuentas de las filas de figuras a cero"),
    (3, 0xB71D): ("marca_de_la_casilla", "HL = la marca de esta casilla en 0xC340"),
    (3, 0xB75E): ("texto_al_azar", "un texto al azar"),
    (3, 0xB7A6): ("modulo", "A mod C"),
    (3, 0xB7D3): ("lo_que_se_cobra", "lo que se cobra segun el dinero"),
    (3, 0xB836): ("caja_y_texto", "la caja del texto y el texto A"),
    (3, 0xB8A2): ("caracter_hacia_abajo", "el caracter de HL 14 veces hacia abajo"),
    (3, 0xB8B3): ("caracter_a_la_derecha", "el caracter de HL 16 veces a la derecha"),
    (3, 0xB9AB): ("lo_de_detras", "si detras no hay pared, 0xCDCC = 1"),
    (3, 0xBA33): ("apunta_lo_de_delante", "lo de la casilla C de delante a 0xCDC9"),
    (3, 0xBAA5): ("dibujo_de_la_casilla", "el dibujo de una casilla del lado"),
    (3, 0xBC3A): ("borra_todo", "borra la pantalla y los sprites"),
    (3, 0xBC89): ("icono_de_moneda", "el icono 0x10 de la moneda n"),
    (3, 0xBCA5): ("icono_del_mapa", "el icono del mapa del pasadizo secreto"),
    (3, 0xBD48): ("prepara_la_puerta", "los datos de la puerta que se abre"),
    (3, 0xBD57): ("abre_la_puerta", "un paso de la puerta que se abre"),
    (3, 0xBE31): ("compara_la_palabra", "el bit C en 0xEF80 si las 5 letras son las de DE"),
    (3, 0xBE36): ("compara_b", "Z si los B bytes de HL y DE son iguales; si lo son, el bit C en 0xEF80"),
    (10, 0x6000): ("sonido_del_cuadro", "un cuadro de sonido: musica y efectos"),
    (10, 0x6067): ("canal_en_reposo", "el canal que no suena"),
    (10, 0x608F): ("pon_el_tono", "escribe el tono del canal en el PSG"),
    (10, 0x609B): ("pon_el_volumen", "escribe el volumen del canal en el PSG"),
    (10, 0x61F1): ("lee_la_partitura", "lee la nota siguiente de la partitura"),
    (10, 0x605F): ("al_manejador", "0xC09C el canal del PSG, 0xC09D la ficha; salta a HL"),
    (10, 0x60A3): ("mezclador_nada", "el canal, ni tono ni ruido"),
    (10, 0x60AA): ("mezclador_ruido", "el canal, con ruido"),
    (10, 0x60B1): ("mezclador_tono_y_ruido", "el canal, con tono y ruido"),
    (10, 0x60B8): ("mezclador_tono", "el canal, con tono"),
    (10, 0x60ED): ("musica_de_la_pausa", "la ficha 0xC082"),
    (10, 0x60F4): ("canal_a", "la ficha 0xC01A"),
    (10, 0x60FB): ("canal_b", "la ficha 0xC034"),
    (10, 0x6102): ("canal_c", "la ficha 0xC04E"),
    (10, 0x6106): ("un_canal", "un cuadro del canal de la ficha IX"),
    (10, 0x6165): ("vibrato", "el vibrato del canal"),
    (10, 0x631B): ("silencio", "una pausa de la partitura"),
    (10, 0x6341): ("orden_de_la_partitura", "las ordenes 0xD0-0xFF"),
    (10, 0x6449): ("el_efecto", "un cuadro del efecto (ficha 0xC068)"),
    (10, 0x6454): ("cuadro_del_efecto", "un cuadro del efecto de sonido"),
}

# direccion -> (que es, de donde se sabe)
RAM = {
    0xC000: ("el ESTADO del juego", "p00:5DBF despacha por el"),
    0xC001: ("el paso del estado", "p00:5E43 lo sube"),
    0xC002: ("las banderas de la partida (bit 7 jugador 2, bit 6 en juego)", "p00:416F"),
    0xC003: ("el contador de cuadros", "p00:5DBB"),
    0xC004: ("la espera del estado, en cuadros", "p00:5E40"),
    0xC005: ("el semaforo de la interrupcion", "p00:4045"),
    0xC006: ("lo que se acaba de apretar (mando y cursores)", "p00:49E4"),
    0xC007: ("lo apretado: bits 0-3 arriba, abajo, izquierda, derecha; 4 y 5 los botones", "p00:49EE"),
    0xC00A: ("los cuadros que le quedan a la tecla de la demostracion", "p01:6928 la baja y p01:694B la recarga"),
    0xC00B: ("F1-F3 recien apretadas (bits 0-2)", "p00:4A37 y p00:49E7"),
    0xC00C: ("F1-F3 apretadas (bits 0-2)", "p00:4A37"),
    0xC010: ("el manejador del canal A del sonido", "p10:6000"),
    0xC012: ("el manejador del canal B del sonido", "p10:6000"),
    0xC014: ("el manejador del canal C del sonido", "p10:6000"),
    0xC016: ("el manejador del efecto de sonido", "p10:6000"),
    0xC018: ("el manejador del segundo efecto", "p10:6000"),
    0xC09F: ("la copia del registro 7 del PSG (el mezclador)", "p10"),
    0xC0AB: ("los canales que suenan", "p00:51D6"),
    0xC0AD: ("la musica que suena", "p00:4FE4"),
    0xC257: ("los puntos del jugador 1 (BCD)", "p00:437E"),
    0xC25A: ("los puntos del jugador 2 (BCD)", "p00:437E"),
    0xC260: ("las vidas", "p00:435E las pone a 3"),
    0xC262: ("los puntos de la proxima vida", "p00:43AA"),
    0xC265: ("el DINERO (ryo, BCD)", "p00:5929 y p00:5958"),
    0xC267: ("los colores del sitio", "p00:4D2C; 0 al entrar en la zona"),
    0xC268: ("si ya entro en la zona", "p01:663A"),
    0xC270: ("las 10 cosas del marcador", "p00:57FE"),
    0xC27F: ("si se puede continuar", "p01:6C7A"),
    0xC280: ("la ZONA (0-6)", "p00:41F6"),
    0xC281: ("la CASILLA de la zona", "p00:5306"),
    0xC283: ("por donde se sale de la casilla (1-4 arriba, abajo, izquierda, derecha; 5 y 6 otros; 0 nada)", "p01:65F7 y p01:609C"),
    0xC288: ("la FASE (0-6)", "p00:41F6"),
    0xC289: ("el juego de graficos de la zona", "p00:4A96 y p00:416F"),
    0xC480: ("la vida maxima", "p00:5890"),
    0xC481: ("la VIDA del jugador", "p00:5884 y p00:5890"),
    0xC482: ("la pantalla especial", "p00"),
    0xC483: ("si esta en un pasadizo", "p00:4F47"),
    0xC490: ("el estado del jugador", "p01"),
    0xC494: ("la y del jugador", "p01:7804"),
    0xC496: ("la x del jugador", "p01:7804"),
    0xC498: ("la y de los sprites del jugador", "p00:4CAB"),
    0xC49A: ("la x de los sprites del jugador", "p00:4CAB"),
    0xC49F: ("la accion del jugador", "p01"),
    0xC4A2: ("el lado al que mira el jugador", "p01"),
    0xC4AE: ("el parpadeo del jugador", "p01"),
    0xC4B0: ("el TIEMPO (BCD)", "p00:58F5"),
    0xC580: ("lo tecleado en la pausa", "p03:BDF6"),
    0xCD27: ("lo que se baja la pieza", "p00:4E84 lo suma a su y"),
    0xCD28: ("lo que se corre la pieza", "p00:4E89 lo suma a su x"),
    0xCD2A: ("la marca que se pone en 0xD800", "p00:4F40"),
    0xCDB1: ("si se esta en el pasadizo secreto", "p00:5969"),
    0xEB81: ("la tecla", "p01:6CD8"),
    0xEB83: ("los caracteres de la contrasena", "p01:6C03"),
    0xEF00: ("el VECINO: 0xFF con el Game Master o Q*bert en otra ranura", "p01:7EAB"),
    0xEF80: ("los SECRETOS: bit 0 y 1 las palabras de la pausa, 2-5 las claves, 6 el menu", "p03:BE31, p03:BE4E, p03:BEDD"),
    0xF0F1: ("la copia del banco de 0x6000", "se escribe con el registro del mapper"),
    0xF0F2: ("la copia del banco de 0x8000", "se escribe con el registro del mapper"),
    0xF0F3: ("la copia del banco de 0xA000", "se escribe con el registro del mapper"),
}

# Lo que es la PALABRA que empieza en esa direccion, para `ld hl,(nn)`,
# `ld (nn),de`... cuando no es lo mismo que el byte.
RAM16 = {
    0xC000: "el estado (0xC000) y el paso (0xC001) de un tiron",
}

# Los campos de la ficha de cada figura (IX apunta a ella: 0xC600 + 0x80 * n,
# ocho, p02:8334). De donde sale cada uno:
#   0      p02:8334 busca el primer hueco con 0 aqui; p01:7ACA elige por el la caja
#   1      se despacha por el y se sube para pasar al paso siguiente
#   2-3    p02:8791 les suma (ix+6, ix+7); la y es (ix+3) (p03:A008, p01:7AE1)
#   4-5    p02:877D les suma (ix+8, ix+9); la x es (ix+5)
#   0x0A   la pose (p02:8D21, p02:96B4)
#   0x20   cuantos sprites lleva (p02:835C)
CAMPOS = {
    0x00: "el tipo de la figura",
    0x01: "el paso en que va la figura",
    0x02: "la fraccion de la y de la figura",
    0x03: "la y de la figura",
    0x04: "la fraccion de la x de la figura",
    0x05: "la x de la figura",
    0x06: "la velocidad vertical (parte baja)",
    0x07: "la velocidad vertical",
    0x08: "la velocidad horizontal (parte baja)",
    0x09: "la velocidad horizontal",
    0x0A: "la pose de la figura",
    0x20: "cuantos sprites lleva la figura",
}

REGISTROS_MAPPER = {0x6000: "0x6000", 0x8000: "0x8000", 0xA000: "0xA000"}


def listado(b):
    filas = []
    for ln in open(os.path.join(RAIZ, "src", "galious_p%02d.asm" % b), encoding="utf-8"):
        m = re.match(r"\t([a-z][^\t;]*?)\s*;([0-9a-f]{4})", ln)
        if m and not ln.startswith("\tdefb"):
            filas.append((int(m.group(2), 16), m.group(1).strip()))
    return filas


def a_mano(b):
    """Direcciones con C escrita fuera de la seccion, y los L ya puestos."""
    ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
    cs, ls, dentro = set(), set(), False
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(INI):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("C "):
            cs.add(int(ln.split()[1], 0))
        elif not dentro and ln.startswith("L "):
            ls.add(int(ln.split()[1], 0))
    return cs, ls


def num(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def valor(txt):
    txt = txt.strip()
    return int(txt[:-1], 16) if txt.endswith("h") else int(txt, 0)


def por_nombre():
    """nombre de etiqueta del listado -> (banco, direccion)."""
    return {}


# En el banco 0 IX solo se carga con `push hl / pop ix` en p00:546A, y es la
# ficha de 0xA830 del banco 12, no una figura: el banco entero queda fuera.
NO_FICHAS = {
    0: [(0x4000, 0x6000)],
}


def fichas_de(filas):
    """Para cada instruccion, si IX apunta ahi a una figura.

    Hay tres listas con los mismos campos 0-0x0A y 0x20: 0xC600 (ocho de
    0x80, p02:8334), 0xCA00 (de 0x40, p02:86F1 y p02:88B0) y 0xCC00 (cuatro de
    0x40, p02:8CB0); las tres pasan por p02:877A (posicion) y p02:87F2 (pose).
    Se da por buena salvo en un tramo (hasta un `ret` o un `jp`) en el que IX
    se carga con otra direccion.
    """
    fuera, malo = {}, False
    for k, (a, t) in enumerate(filas):
        m = re.match(r"ld ix,0([0-9a-f]{4})h$", t)
        if m:
            v = int(m.group(1), 16)
            malo = not (0xC600 <= v < 0xCD00)
        fuera[k] = not malo
        if t.startswith(("ret", "jp ")) and not re.match(r"ret [a-z]", t):
            malo = False
    return fuera


def comentario(b, filas, k, fichas):
    a, t = filas[k]
    # llamadas y saltos a rutinas con nombre
    m = re.match(r"(call|jp)\s+(?:(?:nz|z|nc|c|po|pe|p|m),)?(?:L_([0-9A-F]{4})|0([0-9a-f]{4})h|([a-z_][a-z0-9_]*))$", t)
    if m and m.group(4):
        # ya lleva el nombre puesto: basta con decir que hace
        for (bb, aa), (nom, que) in RUTINAS.items():
            if nom == m.group(4):
                return "%s: %s" % (nom, que)
        m = None
    if m:
        dest = int(m.group(2) or m.group(3), 16)
        for (bb, aa), (nom, que) in RUTINAS.items():
            if bb == 10 and b != bb:
                continue            # el sonido solo esta en 0x6000 cuando lo llama la interrupcion
            if b == 10 and bb != 10 and bb != 0:
                continue            # y en el banco 10 no hay otro en 0x6000-0x7FFF
            if aa == dest and (bb == b or ORG[bb] == 0x4000 or not (ORG[b] <= dest < ORG[b] + 0x2000)):
                if bb == 0 or ORG[bb] <= dest < ORG[bb] + 0x2000:
                    return "%s: %s" % (nom, que)
    # los campos de la figura
    if b in (0, 1, 2, 3) and fichas.get(k, False) and \
            not any(i <= a < f for i, f in NO_FICHAS.get(b, [])):
        mm = re.search(r"\(ix\+0?([0-9a-f]+)h?\)", t)
        if mm:
            n = int(mm.group(1), 16)
            que = CAMPOS.get(n)
            if que:
                op = t.split()[0]
                if op == "ld" and t.startswith("ld (ix"):
                    v = t.split(",", 1)[1]
                    if re.match(r"^[a-z]$", v):
                        return "guarda %s" % que
                    v = "0x%02X" % num(v) if re.match(r"^[0-9a-f]+h$", v) else v
                    return "%s = %s" % (que, v)
                if op == "ld":
                    return "lee %s" % que
                if op in ("inc", "dec"):
                    return ("sube " if op == "inc" else "baja ") + que
                if op == "bit":
                    return "mira el bit %s de %s" % (t.split()[1].split(",")[0], que)
                if op in ("set", "res"):
                    return "%s el bit %s de %s" % ("pone a uno" if op == "set" else "pone a cero",
                                                   t.split()[1].split(",")[0], que)
                if op in ("cp", "sub", "add", "adc", "sbc", "and", "or", "xor"):
                    return {"cp": "compara con ", "sub": "le resta ", "add": "le suma ",
                            "adc": "le suma ", "sbc": "le resta ", "and": "AND con ", "or": "OR con ",
                            "xor": "XOR con "}[op] + que
    # cambios de banco
    m = re.match(r"ld \(0(6000|8000|a000)h\),a$", t)
    if m:
        reg = int(m.group(1), 16)
        return "el mapper: pone en %s el banco de A" % REGISTROS_MAPPER[reg]
    # RAM
    m16 = re.match(r"ld (?:(hl|de|bc|ix|iy),\(0([c-f][0-9a-f]{3})h\)|\(0([c-f][0-9a-f]{3})h\),(hl|de|bc|ix|iy))$", t)
    if m16:
        v = int(m16.group(2) or m16.group(3), 16)
        if v in RAM16:
            return ("lee " if m16.group(1) else "guarda ") + RAM16[v]
        if v in RAM:
            return ("lee " if m16.group(1) else "guarda ") + RAM[v][0] + " y el byte siguiente (16 bits)"
    for x in re.findall(r"\b0([c-f][0-9a-f]{3})h\b", t):
        v = int(x, 16)
        if v in RAM:
            que = RAM[v][0]
            if re.match(r"ld \(0%04xh\)," % v, t):
                return "guarda %s" % que
            if re.match(r"ld [a-z]+,\(0%04xh\)$" % v, t):
                return "lee %s" % que
            if re.match(r"ld (hl|de|bc|ix|iy),0%04xh$" % v, t):
                return "apunta a %s" % que
            return que
    return None


def main(argv):
    total = 0
    for b in BANCOS:
        filas = listado(b)
        cs, ls = a_mano(b)
        fichas = fichas_de(filas)
        lineas = []
        for (bb, aa), (nom, que) in sorted(RUTINAS.items()):
            if bb == b and aa not in ls:
                lineas.append("L 0x%04X %s %s" % (aa, nom, que))
        n = 0
        for k, (a, t) in enumerate(filas):
            if a in cs:
                continue
            c = comentario(b, filas, k, fichas)
            if c:
                lineas.append("C 0x%04X %s" % (a, c))
                n += 1
        total += n
        print("p%02d: %d comentarios, %d nombres" % (b, n, sum(1 for l in lineas if l.startswith("L "))))
        if "--escribe" in argv:
            ruta = os.path.join(RAIZ, "src", "p%02d.notes" % b)
            viejas = open(ruta, encoding="utf-8").read().split("\n")
            nuevas, dentro = [], False
            for ln in viejas:
                if ln.startswith(INI):
                    dentro = True
                    continue
                if ln.startswith(FIN):
                    dentro = False
                    continue
                if not dentro:
                    nuevas.append(ln)
            while nuevas and not nuevas[-1].strip():
                nuevas.pop()
            nuevas += ["", INI] + lineas + [FIN, ""]
            open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(nuevas))
    print("en total: %d comentarios" % total)


if __name__ == "__main__":
    main(sys.argv)
