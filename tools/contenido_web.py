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
# El rotulo de la cifra de rutinas en la portada
RUTINAS_ROTULO = {"es": "rutinas con nombre", "en": "named routines"}

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

# Las paginas, en tres bloques: lo del juego, las curiosidades y lo tecnico.
# Cada una: (ingles, castellano, rotulo en, rotulo es, de que va en, de que va es).
PAGINAS = [
    [("THE-WORLDS.html", "LOS-MUNDOS.html", "The castle and the worlds",
      "El castillo y los mundos",
      "the title screen, the castle and the ten worlds, room by room",
      "la pantalla de t&iacute;tulo, el castillo y los diez mundos, sala por sala"),
     ("THE-HEROES.html", "LOS-PROTAGONISTAS.html", "Popolon and Aphrodite",
      "Popolon y Afrodita",
      "the 32 poses of the two heroes",
      "las 32 poses de los dos h&eacute;roes"),
     ("THE-ENEMIES.html", "LOS-ENEMIGOS.html", "The enemies", "Los enemigos",
      "the sprite sets each room loads",
      "los juegos de sprites que carga cada sala"),
     ("THE-BOSSES.html", "LOS-JEFES.html", "The bosses", "Los jefes",
      "the boss room and the ten bosses made of characters",
      "la sala del jefe y los diez jefes hechos de caracteres"),
     ("THE-ITEMS.html", "LOS-OBJETOS.html", "The items and the shops",
      "Los objetos y las tiendas",
      "the 47 items and the 13 shop entries",
      "los 47 objetos y las 13 entradas de tienda"),
     ("THE-MUSIC.html", "LA-MUSICA.html", "The music", "La m&uacute;sica",
      "the tunes, from its own sound engine",
      "las m&uacute;sicas, de su propio motor de sonido")],
    [("CURIOSITIES.html", "CURIOSIDADES.html", "Curiosities", "Curiosidades",
      "the findings and what is still open",
      "los hallazgos y lo que queda abierto")],
    [("UNDER-THE-HOOD.html", "POR-DENTRO.html", "Under the hood", "Por dentro",
      "getting started, the mapper, the banks, the interrupt, the code and the emulator",
      "empezar, el mapper, los bancos, la interrupci&oacute;n, el c&oacute;digo y el emulador")],
]

# Las paginas de antes y a donde llevan ahora (los feeds y otras webs las enlazan).
VIEJAS = {
    "GETTING-STARTED.html": "UNDER-THE-HOOD.html", "THE-GAME.html": "THE-WORLDS.html",
    "THE-CARTRIDGE.html": "UNDER-THE-HOOD.html", "THE-CODE.html": "UNDER-THE-HOOD.html",
    "IN-THE-EMULATOR.html": "UNDER-THE-HOOD.html",
    "FINDINGS.html": "CURIOSITIES.html", "OPEN-QUESTIONS.html": "CURIOSITIES.html",
    "EMPEZAR.html": "POR-DENTRO.html", "EL-JUEGO.html": "LOS-MUNDOS.html",
    "EL-CARTUCHO.html": "POR-DENTRO.html", "EL-CODIGO.html": "POR-DENTRO.html",
    "HALLAZGOS.html": "CURIOSIDADES.html", "PREGUNTAS-ABIERTAS.html": "CURIOSIDADES.html",
    "EN-EL-EMULADOR.html": "POR-DENTRO.html",
}

LOGOTIPO = "titulo.png"
