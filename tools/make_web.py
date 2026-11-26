#!/usr/bin/env python3
"""Genera la portada de la web, en los dos idiomas.

La maquinaria no nombra ningun juego: el nombre, la cabecera, las cifras y
la lista de paginas salen de tools/contenido_web.py. Aqui solo van los
rotulos de la pagina. El diseno es el compartido por la serie
(tools/estilo_web.py) y la pagina sale autocontenida, con las imagenes
embebidas como data URI.

Uso: make_web.py <docs/imagenes> <salida.html> <idioma>
"""
import base64
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                   # noqa: E402
from contenido_web import (NOMBRE, PORTADA, PAGINAS, LOGOTIPO,  # noqa: E402
                           CODIGO, DATOS, RUTINAS, densidad)


def mil(n, idioma):
    return f"{n:,}".replace(",", "." if idioma == "es" else ",")


TXT = {
    "es": dict(
        otro=("../", "In English"),
        h_num="El cartucho en cifras", h_pag="Lo que hay dentro",
        bloques=["El juego", "Curiosidades", "Por dentro"],
        cifras=[("100 %", "del binario explicado"),
                (mil(RUTINAS, "es"), "rutinas y etiquetas"),
                (densidad("es") + " %", "del listado comentado"),
                (mil(CODIGO, "es"), "bytes de código"),
                (mil(DATOS, "es"), "bytes de datos"),
                ("0", "bytes sin identificar")],
        pie_leg="Esto es trabajo de documentación y preservación: el código y "
                "los gráficos siguen siendo de sus autores y de Konami, y la "
                "imagen del cartucho no se distribuye.",
    ),
    "en": dict(
        otro=("es/", "En castellano"),
        h_num="The cartridge in numbers", h_pag="What is inside",
        bloques=["The game", "Curiosities", "Under the hood"],
        cifras=[("100%", "of the binary explained"),
                (mil(RUTINAS, "en"), "routines and labels"),
                (densidad("en") + "%", "of the listing commented"),
                (mil(CODIGO, "en"), "bytes of code"),
                (mil(DATOS, "en"), "bytes of data"),
                ("0", "bytes unidentified")],
        pie_leg="This is documentation and preservation work: the code and "
                "artwork still belong to their authors and to Konami, and the "
                "cartridge image is not distributed.",
    ),
}


def img64(ruta):
    with open(ruta, "rb") as f:
        return "data:image/png;base64," + base64.b64encode(f.read()).decode()


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    imgdir, salida, idioma = argv[1:4]
    t = dict(TXT[idioma], **PORTADA[idioma])

    # El "logotipo" de la cabecera no es un montaje ni una captura: es la
    # pantalla de titulo que pinta el propio cartucho, dibujada desde la ROM
    # (contenido_web.LOGOTIPO). Si el PNG no esta, el trabajo NO esta hecho: se
    # cae al texto, y eso se ve.
    ruta_logo = os.path.join(imgdir, LOGOTIPO)
    cabecera = (f'<img src="{img64(ruta_logo)}" alt="{NOMBRE}">'
                if os.path.exists(ruta_logo)
                else f"<h1>{NOMBRE}</h1>")

    # el menu y la lista de paginas, en los tres bloques de PAGINAS
    k_h, k_t, k_d = (0, 2, 4) if idioma == "en" else (1, 3, 5)
    sep = '<span style="opacity:.35">|</span>'
    nav = sep.join("".join(f'<a href="{p[k_h]}">{p[k_t]}</a>' for p in b) for b in PAGINAS)
    nav += (f'<a href="{t["otro"][0]}" style="margin-left:auto;color:var(--oro)">'
            f'{t["otro"][1]}</a>')

    cifras = "".join(f'<div class="cifra"><b>{v}</b><span>{e}</span></div>'
                     for v, e in t["cifras"])
    paginas = "".join(
        f'<div class="hall"><h3>{tit}</h3><ul>'
        + "".join(f'<li><a href="{p[k_h]}">{p[k_t]}</a>: {p[k_d]}.</li>' for p in b)
        + "</ul></div>"
        for tit, b in zip(t["bloques"], PAGINAS))

    html = f"""<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{t['titulo']}</title>
<style>{ESTILO}</style>
<header class="top">
  {cabecera}
  <p class="claim">{t['claim']}</p>
  <p class="ficha">{' - '.join(t['ficha'])}</p>
</header>
<p class="ficha" style="border:1px solid var(--oro);padding:.8em 1em;margin:1.5em 0">
{t['aviso']}</p>
<nav>{nav}</nav>
<section id="numbers">
  <h2>{t['h_num']}</h2>
  <div class="cifras">{cifras}</div>
</section>
<section id="pages"><h2>{t['h_pag']}</h2>{paginas}</section>
<footer><p>{t['pie_leg']}</p></footer>
"""
    with open(salida, "w", encoding="utf-8") as f:
        f.write(html)
    print("  %s: %d KB (%s)" % (salida, len(html) // 1024, idioma))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
