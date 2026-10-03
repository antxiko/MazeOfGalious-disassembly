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

NOMBRE = "Ganbare Goemon!"
CATALOGO = "RC-748"
ANIO = 1987
REPOSITORIO = "https://github.com/antxiko/GanbareGoemon-disassembly"

CODIGO = 28724
DATOS = 102348
RUTINAS = 1678
INSTRUCCIONES = 14355
COMENTARIOS = 6103


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


# El pie legal de cada pagina. El cartucho lleva la marca oculta de la casa al
# final del banco 3 (tools/marca_konami.py).
PIE_LEGAL = {
    "es": "<em>Ganbare Goemon! Karakuri D&#333;ch&#363;</em> lo public&oacute; "
          "Konami para MSX2 en 1987; su n&uacute;mero de cat&aacute;logo es "
          "RC-748 y son 128 KB. Todos los derechos sobre el juego siguen siendo "
          "de sus titulares. Este trabajo es de preservaci&oacute;n, estudio y "
          "documentaci&oacute;n, y la imagen del cartucho no se distribuye.",
    "en": "<em>Ganbare Goemon! Karakuri D&#333;ch&#363;</em> was published by "
          "Konami for the MSX2 in 1987; its catalogue number is RC-748 and it "
          "is 128 KB. All rights in the game remain with their holders. This "
          "is preservation, study and documentation work, and the cartridge "
          "image is not distributed.",
}

# La cabecera de la portada
PORTADA = {
    "es": dict(
        titulo="Ganbare Goemon! - desensamblado comentado",
        claim="Siete fases de siete zonas, 124 pantallas, 21 interiores con "
              "sus precios y 42 pasadizos secretos en primera persona, todo "
              "dibujado desde la ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "Cartucho <b>RC-748</b>, MegaROM de 128 KB (Konami4)",
               "<b>MSX2</b>", "Volcado <b>a436addc...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las im&aacute;genes "
              "est&aacute;n <b>dibujadas desde los bytes de la ROM</b>: el "
              "t&iacute;tulo, las 49 zonas, Goemon y Ebisumaru, los enemigos, "
              "los 21 interiores y los 42 pasadizos secretos, con las tablas del "
              "cartucho, y <b>cotejadas contra openMSX</b> en una m&aacute;quina "
              "MSX2 japonesa, sin una diferencia. El listado y las cifras se "
              "reproducen con <code>make</code>, y el reensamblado devuelve la "
              "ROM <b>byte a byte</b>.",
    ),
    "en": dict(
        titulo="Ganbare Goemon! - a commented disassembly",
        claim="Seven stages of seven areas, 124 screens, 21 interiors with "
              "their prices and 42 first-person secret passages, all drawn "
              "from the ROM.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "An <b>RC-748</b> cartridge, a 128 KB MegaROM (Konami4)",
               "<b>MSX2</b>", "Dump <b>a436addc...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b>: the title, the 49 areas, Goemon and "
              "Ebisumaru, the enemies, the 21 interiors and the 42 secret "
              "passages, with the cartridge's own tables, and <b>checked "
              "against openMSX</b> on a Japanese MSX2 machine, without a single "
              "difference. The listing and the numbers are reproducible with "
              "<code>make</code>, and reassembling gives back the ROM <b>byte "
              "for byte</b>.",
    ),
}

HALLAZGOS = {
    "es": [
        ("Los pasadizos secretos",
         "<p>En cada zona menos la 5 de cada fase, el interior 16 cobra 900 ryo "
         "por llevarte al pasadizo secreto del fondo: <b>42 pasadizos</b> hechos "
         "con 16 dibujos (<code>0xA86D</code>), que se recorren en primera "
         "persona (<code>p03:B8C3</code>).</p><p>Dentro hay 200 ryo, una vida, "
         "el mapa y la salida, que da 10.000 puntos. Los 42 cotejados a cero "
         "contra openMSX.</p>"),
        ("Con Q*bert o el Game Master al lado, un men&uacute; para elegir fase",
         "<p><code>p01:7EAB</code> mira la otra ranura; si encuentra Q*bert o "
         "el Game Master, el t&iacute;tulo saca un men&uacute; m&aacute;s "
         "(<code>p01:7F1A</code>) para elegir la fase y las vidas.</p><p>Visto "
         "en openMSX con los dos cartuchos.</p>"),
        ("Cuatro claves en la contrase&ntilde;a",
         "<p>&#12367;&#12427;&#12367;&#12427;&#12390;&#12435;&#12390;&#12435; "
         "(jugador 2), &#12365;&#12415;&#12385;&#12420;&#12435;&#12370;&#12435;&#12365; "
         "(vida m&aacute;xima 0x20), &#12354;&#12369;&#12415;&#12373;&#12435;&#12398;&#12373;&#12356;&#12405; "
         "(2000 ryo) y &#12388;&#12389;&#12365;&#12364;&#12375;&#12383;&#12356; "
         "(continuar), en <code>0xBE8A</code>.</p><p>Las cuatro comprobadas en "
         "openMSX.</p>"),
        ("Dos palabras en la pausa",
         "<p>En la pausa se teclean cinco letras (<code>p03:BDF6</code>): "
         "&#12362;&#12420;&#12406;&#12435; dentro de un pasadizo secreto da su "
         "mapa; &#12377;&#12365;&#12420;&#12397;&#12435; fuera hace que tocar a "
         "los tipos 8 y 0x21 d&eacute; 10 ryo.</p><p>Los dos bits, vistos en "
         "openMSX tecle&aacute;ndolas.</p>"),
        ("F2 ense&ntilde;a la contrase&ntilde;a, F5 contin&uacute;a",
         "<p>F2 en la pausa ense&ntilde;a la contrase&ntilde;a del sitio "
         "(<code>p01:6B5F</code>); sin vidas, F5 sigue la partida si se ha "
         "ganado &laquo;continuar&raquo; (<code>p00:5F8E</code>).</p><p>Los dos, "
         "vistos en openMSX.</p>"),
        ("Al morir, la mitad del dinero",
         "<p><code>p01:701E</code> divide el dinero entre dos en BCD, cifra a "
         "cifra.</p><p>En openMSX, 4800 ryo se quedaron en 2400.</p>"),
        ("Las tiendas abren seg&uacute;n el reloj",
         "<p>Los interiores 8 a 15 cierran cuando la cifra de las decenas del "
         "tiempo es impar (<code>p03:AD57</code>).</p><p>Visto en openMSX, "
         "abiertos y cerrados.</p>"),
        ("Cuatro finales",
         "<p><code>p01:6546</code> elige el final seg&uacute;n si se han pasado "
         "las 7 fases y si estaba el vecino. Con las 7, el juego anuncia "
         "Hinotori y Maj&#333; Densetsu 2.</p>"),
        ("Cuatro fallos del c&oacute;digo",
         "<p>Una escritura que va a la ROM de la BIOS (<code>p03:AAFE</code>), "
         "una vida que se llena entera por pasar DE en vez de A "
         "(<code>p03:B4F1</code>), un <code>ld hl,(nn)</code> por "
         "<code>ld hl,nn</code> (<code>p03:A5BB</code>) y una tabla que se "
         "ejecuta como c&oacute;digo (<code>p03:ADB4</code>).</p>"),
        ("La marca de Konami, en hiragana",
         "<p>Al final del banco 3, en la fuente del propio juego: "
         "&#12364;&#12435;&#12400;&#12428;&#12372;&#12360;&#12418;&#12435; y el "
         "RC-748. El formato de la marca lo destap&oacute; Manuel Pazos.</p>"),
    ],
    "en": [
        ("The secret passages",
         "<p>In every area except area 5 of each stage, interior 16 charges 900 "
         "ryo to take you to the secret passage at the back: <b>42 passages</b> "
         "made from 16 drawings (<code>0xA86D</code>), walked in first person "
         "(<code>p03:B8C3</code>).</p><p>Inside there are 200 ryo, a life, the "
         "map and the exit, which gives 10,000 points. All 42 checked down to "
         "zero against openMSX.</p>"),
        ("With Q*bert or the Game Master next to it, a menu to pick the stage",
         "<p><code>p01:7EAB</code> looks at the other slot; if it finds Q*bert "
         "or the Game Master, the title screen shows an extra menu "
         "(<code>p01:7F1A</code>) to choose the stage and the lives.</p><p>Seen "
         "in openMSX with both cartridges.</p>"),
        ("Four keywords on the password screen",
         "<p>&#12367;&#12427;&#12367;&#12427;&#12390;&#12435;&#12390;&#12435; "
         "(player 2), &#12365;&#12415;&#12385;&#12420;&#12435;&#12370;&#12435;&#12365; "
         "(maximum life 0x20), &#12354;&#12369;&#12415;&#12373;&#12435;&#12398;&#12373;&#12356;&#12405; "
         "(2000 ryo) and &#12388;&#12389;&#12365;&#12364;&#12375;&#12383;&#12356; "
         "(continue), at <code>0xBE8A</code>.</p><p>All four checked in "
         "openMSX.</p>"),
        ("Two words in the pause",
         "<p>During the pause five letters can be typed (<code>p03:BDF6</code>): "
         "&#12362;&#12420;&#12406;&#12435; inside a secret passage gives its "
         "map; &#12377;&#12365;&#12420;&#12397;&#12435; outside makes touching "
         "types 8 and 0x21 give 10 ryo.</p><p>Both bits seen in openMSX by "
         "typing them.</p>"),
        ("F2 shows the password, F5 continues",
         "<p>F2 in the pause shows the password for the current place "
         "(<code>p01:6B5F</code>); out of lives, F5 carries on if "
         "&ldquo;continue&rdquo; has been earned (<code>p00:5F8E</code>).</p>"
         "<p>Both seen in openMSX.</p>"),
        ("Dying halves the money",
         "<p><code>p01:701E</code> divides the money by two in BCD, digit by "
         "digit.</p><p>In openMSX, 4800 ryo became 2400.</p>"),
        ("The shops open by the clock",
         "<p>Interiors 8 to 15 are closed when the tens digit of the timer is "
         "odd (<code>p03:AD57</code>).</p><p>Seen in openMSX, open and "
         "closed.</p>"),
        ("Four endings",
         "<p><code>p01:6546</code> picks the ending from whether all 7 stages "
         "have been played and whether the neighbour was there. With the 7, "
         "the game announces Hinotori and Maj&#333; Densetsu 2.</p>"),
        ("Four bugs in the code",
         "<p>A write that goes to BIOS ROM (<code>p03:AAFE</code>), a life that "
         "fills completely because DE is passed instead of A "
         "(<code>p03:B4F1</code>), an <code>ld hl,(nn)</code> instead of "
         "<code>ld hl,nn</code> (<code>p03:A5BB</code>) and a table run as code "
         "(<code>p03:ADB4</code>).</p>"),
        ("Konami's mark, in hiragana",
         "<p>At the end of bank 3, in the game's own font: "
         "&#12364;&#12435;&#12400;&#12428;&#12372;&#12360;&#12418;&#12435; and "
         "the RC-748. The format of the mark was uncovered by Manuel "
         "Pazos.</p>"),
    ],
}

# (imagen, pie en castellano, pie en ingles). El logotipo de la cabecera es
# LOGOTIPO: el titulo que pinta el cartucho, no un montaje.
LOGOTIPO = "titulo.png"
GALERIA = [
    ("titulo.png",
     "La pantalla de t&iacute;tulo, montada desde la ROM. Coincide con openMSX "
     "sin un punto distinto (<code>titulo.py coteja</code>).",
     "The title screen, built from the ROM. It matches openMSX with not a "
     "single pixel different (<code>titulo.py coteja</code>)."),
    ("zona_1_0.png",
     "La zona 0 de la fase 1, calle a calle (<code>p00:4188</code>); las "
     "flechas dicen adonde llevan las salidas de arriba y de abajo "
     "(<code>0xB7D0</code>). Las 49 entradas de zona, cotejadas contra "
     "openMSX.",
     "Area 0 of stage 1, street by street (<code>p00:4188</code>); the arrows "
     "say where the up and down exits lead (<code>0xB7D0</code>). All 49 "
     "area entrances checked against openMSX."),
    ("goemon.png",
     "Las 20 poses de Goemon: dibujos, sprites y colores cotejados con la pose "
     "de cada volcado.",
     "Goemon's 20 poses: patterns, sprites and colours checked against the "
     "pose in each dump."),
    ("ebisumaru.png",
     "Ebisumaru, el jugador 2, con sus 20 poses.",
     "Ebisumaru, player 2, with his 20 poses."),
    ("enemigos.png",
     "Los 30 tipos que salen en las casillas (listas de <code>0x9BF0</code> y "
     "<code>0x5BB2</code>), con la paleta de la primera zona donde sale cada "
     "uno. 107 figuras de los volcados, cotejadas a cero.",
     "The 30 types that appear in the cells (lists at <code>0x9BF0</code> and "
     "<code>0x5BB2</code>), each with the palette of the first area where it "
     "appears. 107 figures from the dumps, checked down to zero."),
    ("interior_00.png",
     "Un interior: cada uno tiene sus figuras y lo que vende "
     "(<code>0x9567</code>), con los precios de <code>0x9371</code>. Los 21, "
     "cotejados a cero.",
     "An interior: each has its figures and what it sells "
     "(<code>0x9567</code>), with the prices at <code>0x9371</code>. All 21 "
     "checked down to zero."),
    ("pasadizo_1_0.png",
     "El mapa del pasadizo secreto de la zona 1-0, como lo ense&ntilde;a el "
     "juego (<code>p03:BB1B</code>). Hay 42, cotejados contra openMSX.",
     "The map of the secret passage in area 1-0, as the game shows it "
     "(<code>p03:BB1B</code>). There are 42, checked against openMSX."),
    ("menu_vecino.png",
     "El men&uacute; que sale con Q*bert o el Game Master en la otra ranura "
     "(<code>p01:7F1A</code>), dibujado desde la ROM y a cero contra openMSX.",
     "The menu that shows up with Q*bert or the Game Master in the other slot "
     "(<code>p01:7F1A</code>), drawn from the ROM and down to zero against "
     "openMSX."),
    ("konami.png",
     "El logotipo de Konami, a cero contra openMSX.",
     "The Konami logo, down to zero against openMSX."),
]
