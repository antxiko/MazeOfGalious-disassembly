#!/usr/bin/env python3
"""EL CONTENIDO de la web de este cartucho: lo unico que es de este juego.

md2html.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui. Asi no se puede colar el texto de otro
cartucho al copiar la maquinaria.

Todas las cifras de aqui estan medidas sobre este cartucho, con las
herramientas de tools/: CODIGO y DATOS los imprime tools/presupuesto.py
(make sanity) y RUTINAS, INSTRUCCIONES y COMENTARIOS son la suma de los
bancos con codigo en tools/densidad.py (make densidad). Un test las vuelve a
medir.
"""

NOMBRE = "The Maze of Galious"
CATALOGO = "RC-749"
ANIO = 1987
REPOSITORIO = "https://github.com/antxiko/MazeOfGalious-disassembly"

CODIGO = 53613
DATOS = 77459
RUTINAS = 3423
INSTRUCCIONES = 25226
COMENTARIOS = 10114

# Los bancos con codigo, para volver a medir la densidad (tests/test_web.py)
BANCOS_CON_CODIGO = ("00", "01", "02", "03", "04", "05", "06", "08", "09", "13", "15")


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


# El pie legal de cada pagina. El cartucho lleva la marca oculta de la casa al
# final del banco 3 (tools/marca_konami.py).
PIE_LEGAL = {
    "es": "<em>The Maze of Galious</em> (<em>Knightmare II</em>) lo public&oacute; "
          "Konami para MSX en 1987; su n&uacute;mero de cat&aacute;logo es "
          "RC-749 y son 128 KB. Todos los derechos sobre el juego siguen siendo "
          "de sus titulares. Este trabajo es de preservaci&oacute;n, estudio y "
          "documentaci&oacute;n, y la imagen del cartucho no se distribuye.",
    "en": "<em>The Maze of Galious</em> (<em>Knightmare II</em>) was published "
          "by Konami for the MSX in 1987; its catalogue number is RC-749 and it "
          "is 128 KB. All rights in the game remain with their holders. This "
          "is preservation, study and documentation work, and the cartridge "
          "image is not distributed.",
}

# La cabecera de la portada
PORTADA = {
    "es": dict(
        titulo="The Maze of Galious - desensamblado comentado",
        claim="El castillo y diez mundos, 321 salas montadas desde sus tablas, "
              "los diez jefes hechos de caracteres, 47 objetos y las tiendas, "
              "todo dibujado desde la ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "Cartucho <b>RC-749</b>, MegaROM de 128 KB (Konami4)",
               "<b>MSX</b>", "Volcado <b>420c42c1...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las im&aacute;genes "
              "est&aacute;n <b>dibujadas desde los bytes de la ROM</b>: el "
              "logotipo y el t&iacute;tulo, las 321 salas del castillo y de los "
              "diez mundos, Popolon y Afrodita, los juegos de sprites, los jefes "
              "y los objetos, con las tablas del cartucho, y <b>cotejadas contra "
              "openMSX</b> en una m&aacute;quina MSX1 japonesa, sin una "
              "diferencia. El listado y las cifras se reproducen con "
              "<code>make</code>, y el reensamblado devuelve la ROM <b>byte a "
              "byte</b>.",
    ),
    "en": dict(
        titulo="The Maze of Galious - a commented disassembly",
        claim="The castle and ten worlds, 321 rooms built from their tables, "
              "the ten bosses made of characters, 47 items and the shops, all "
              "drawn from the ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "An <b>RC-749</b> cartridge, a 128 KB MegaROM (Konami4)",
               "<b>MSX</b>", "Dump <b>420c42c1...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b>: the logo and the title, the 321 rooms of "
              "the castle and the ten worlds, Popolon and Aphrodite, the sprite "
              "sets, the bosses and the items, with the cartridge's own tables, "
              "and <b>checked against openMSX</b> on a Japanese MSX1 machine, "
              "without a single difference. The listing and the numbers are "
              "reproducible with <code>make</code>, and reassembling gives back "
              "the ROM <b>byte for byte</b>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("F2: el personaje se sienta en una taza",
         "<p>F2 en plena partida (<code>p02:9E07</code>) pone el estado 9 y el "
         "personaje sale sentado en una taza blanca, con los dibujos del banco "
         "15 (<code>p00:5917</code>, <code>p03:BE36</code>).</p><p>Visto en "
         "openMSX.</p>"),
        ("ZEUS en la pausa: continuar",
         "<p>Tecleado en la pausa de F2 en la sala 1 del castillo "
         "(<code>p01:7E57</code>), al perder sale GAME OVER y F5 CONTINUE; F5 "
         "sigue en la sala 1 con la vida en 8 (<code>p01:7EF1</code>).</p><p>Visto "
         "en openMSX.</p>"),
        ("Las salas negras son pistas y tiendas",
         "<p>Nueve mundos tienen una sala especial (<code>0x8F0A</code>) que "
         "el juego no monta: sale en negro. No son jefes: son Demeter con una "
         "pista o su tienda, con el mensaje en ingl&eacute;s o en japon&eacute;s "
         "seg&uacute;n la m&aacute;quina (<code>p02:94F0</code>).</p><p>Las dos "
         "salas y los dos idiomas, vistos en openMSX.</p>"),
        ("El jefe se llama por su nombre",
         "<p>En su sala se teclea su nombre (<code>p02:9B18</code>, tabla "
         "<code>0x9B4F</code>): YOMAR, ELOHIM... HAMALECH. Sale un humo y "
         "despu&eacute;s el jefe, con el fondo en negro.</p><p>Visto en openMSX "
         "forzando la marca de acertado.</p>"),
        ("Los jefes no son sprites",
         "<p>Son mosaicos de caracteres (61 en <code>0x9E0A</code>) que se "
         "cambian para moverlos. Los gr&aacute;ficos del jefe del mundo 3 se "
         "cargan por pasos con una direcci&oacute;n calculada, y por eso "
         "ninguna palabra de la ROM los nombra.</p><p>Medido en partida, "
         "cuadro a cuadro.</p>"),
        ("Con otro cartucho al lado",
         "<p><code>p00:5F0C</code> mira la otra ranura: con Q*bert se empieza "
         "con 100 flechas, 100 monedas y 100 llaves; con Knightmare cambia "
         "0xE05A y 0xE05B; con el Game Master, un bit.</p><p>Le&iacute;do en el "
         "c&oacute;digo.</p>"),
        ("Objetos escondidos en el castillo",
         "<p>Cinco objetos salen al vencer a las figuras de ciertas salas "
         "(<code>p02:9F82</code>); el 0x26 pide adem&aacute;s derecha, abajo, "
         "izquierda y arriba (<code>p03:A056</code>).</p><p>Le&iacute;do en el "
         "c&oacute;digo.</p>"),
        ("La marca de Konami",
         "<p>Al final del banco 3: &#12460;&#12522;&#12454;&#12473; &#12494; "
         "&#12513;&#12452;&#12461;&#12517;&#12454; y el RC-749. El formato de "
         "la marca lo destap&oacute; Manuel Pazos.</p>"),
    ],
    "en": [
        ("F2: the character sits on a cup",
         "<p>F2 in the middle of a game (<code>p02:9E07</code>) sets state 9 "
         "and the character appears sitting on a white cup, with patterns from "
         "bank 15 (<code>p00:5917</code>, <code>p03:BE36</code>).</p><p>Seen in "
         "openMSX.</p>"),
        ("ZEUS in the pause: continue",
         "<p>Typed in the F2 pause in room 1 of the castle "
         "(<code>p01:7E57</code>), losing shows GAME OVER and F5 CONTINUE; F5 "
         "carries on in room 1 with life at 8 (<code>p01:7EF1</code>).</p><p>Seen "
         "in openMSX.</p>"),
        ("The black rooms are hints and shops",
         "<p>Nine worlds have a special room (<code>0x8F0A</code>) the game "
         "does not build: it comes out black. They are not bosses: they are "
         "Demeter with a hint or her shop, with the message in English or "
         "Japanese depending on the machine (<code>p02:94F0</code>).</p><p>Both "
         "rooms and both languages, seen in openMSX.</p>"),
        ("The boss is called by its name",
         "<p>In its room you type its name (<code>p02:9B18</code>, table "
         "<code>0x9B4F</code>): YOMAR, ELOHIM... HAMALECH. Smoke comes out and "
         "then the boss, with the background in black.</p><p>Seen in openMSX "
         "by forcing the guessed flag.</p>"),
        ("The bosses are not sprites",
         "<p>They are character mosaics (61 at <code>0x9E0A</code>) swapped to "
         "move them. World 3's boss graphics are loaded in steps through a "
         "computed address, which is why no word in the ROM names them.</p>"
         "<p>Measured in game, frame by frame.</p>"),
        ("With another cartridge next to it",
         "<p><code>p00:5F0C</code> looks at the other slot: with Q*bert you "
         "start with 100 arrows, 100 coins and 100 keys; with Knightmare it "
         "changes 0xE05A and 0xE05B; with the Game Master, a bit.</p><p>Read in "
         "the code.</p>"),
        ("Hidden items in the castle",
         "<p>Five items come out when the figures of certain rooms are defeated "
         "(<code>p02:9F82</code>); 0x26 also asks for right, down, left and up "
         "(<code>p03:A056</code>).</p><p>Read in the code.</p>"),
        ("Konami's mark",
         "<p>At the end of bank 3: &#12460;&#12522;&#12454;&#12473; &#12494; "
         "&#12513;&#12452;&#12461;&#12517;&#12454; and the RC-749. The format "
         "of the mark was uncovered by Manuel Pazos.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "La pantalla de t&iacute;tulo, montada desde la ROM: coincide con openMSX "
     "en los 16 KB de la VRAM (<code>titulo.py coteja</code>).",
     "The title screen, built from the ROM: it matches openMSX in all 16 KB of "
     "VRAM (<code>titulo.py coteja</code>)."),
    ("mapa_1.png",
     "El castillo: sus 147 salas con su n&uacute;mero, colocadas por sus "
     "vecinas (<code>0xA9EF</code>). Las 321 salas del juego, cotejadas "
     "car&aacute;cter a car&aacute;cter contra openMSX.",
     "The castle: its 147 rooms with their numbers, laid out by their "
     "neighbours (<code>0xA9EF</code>). All 321 rooms in the game, checked "
     "character for character against openMSX."),
    ("mapa_10.png",
     "El mundo 9, sus 27 salas. Las negras son pistas y tiendas; la del sello, "
     "la del jefe.",
     "World 9, its 27 rooms. The black ones are hints and shops; the one with "
     "the seal, the boss's."),
    ("sala_del_jefe.png",
     "La sala del jefe del mundo 1 con el sello: una mitad de "
     "<code>0xB760</code> y la otra, la misma dada la vuelta.",
     "The boss room of world 1 with the seal: one half from "
     "<code>0xB760</code> and the other, the same flipped."),
    ("jefes.png",
     "Los diez jefes enteros: mosaicos de caracteres (<code>0x9E0A</code>), "
     "medidos en partida y a cero contra openMSX.",
     "The ten bosses in full: character mosaics (<code>0x9E0A</code>), "
     "measured in game and down to zero against openMSX."),
    ("poses.png",
     "Las 32 poses de Popolon y de Afrodita (<code>0x7529</code>), que comparten "
     "dibujos y cambian de color.",
     "Popolon's and Aphrodite's 32 poses (<code>0x7529</code>), which share "
     "patterns and change colour."),
    ("objetos.png",
     "Los 47 objetos (<code>0x6E34</code>, <code>0x6E80</code>). El juego no "
     "los nombra: solo los dibuja.",
     "The 47 items (<code>0x6E34</code>, <code>0x6E80</code>). The game never "
     "names them: it only draws them."),
    ("logotipo.png",
     "El logotipo de Konami, a cero contra openMSX.",
     "The Konami logo, down to zero against openMSX."),
]
