#!/usr/bin/env python3
"""Prepara docs/ para que GitHub Pages convierta las paginas con Jekyll.

En el repositorio solo estan los .md: Jekyll (el de GitHub Pages, 3.10, con
kramdown en modo GFM) los convierte al publicar. Aqui se escriben:

  docs/_config.yml           kramdown GFM, los plugins que GitHub Pages trae
                             activados (paginas sin cabecera YAML, titulo desde
                             el primer #) y la plantilla de cada idioma
  docs/_layouts/en.html,     el estilo de la serie (tools/estilo_web.py), el
  docs/_layouts/es.html      menu en los bloques de contenido_web.PAGINAS con la
                             pagina actual marcada, el selector de idioma a la
                             pagina pareja y el pie legal
  las paginas viejas         contenido_web.VIEJAS: una redireccion a la nueva

La portada (docs/index.html) la sigue montando make_web.py: es HTML y Jekyll
la copia tal cual. La maquinaria no nombra ningun juego: todo sale de
tools/contenido_web.py.

Uso: jekyll.py <docs>
Para verlo en local: jekyll build -s docs -d work/_site
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                          # noqa: E402
from contenido_web import NOMBRE, ANIO, PIE_LEGAL, PAGINAS, VIEJAS     # noqa: E402

CONFIG = """# Lo escribe tools/jekyll.py: no se toca a mano.
markdown: kramdown
kramdown:
  input: GFM
  hard_wrap: false
  auto_ids: true
  # el texto tal cual: ni comillas tipograficas ni ... convertidos en un signo
  smart_quotes: ["apos", "apos", "quot", "quot"]
  typographic_symbols: {hellip: "...", mdash: "---", ndash: "--"}
plugins:
  - jekyll-optional-front-matter
  - jekyll-titles-from-headings
# GitHub Pages lo trae puesto y vuelve absolutas las rutas de las imagenes
relative_links:
  enabled: false
titles_from_headings:
  strip_title: false
defaults:
  - scope: {path: ""}
    values: {layout: en}
  - scope: {path: "es"}
    values: {layout: es}
exclude: [README.md]
"""

SEPARA = '<span style="opacity:.35">|</span>'


def plantilla(idioma):
    k_h, k_t, otro_k = (0, 2, 1) if idioma == "en" else (1, 3, 0)
    portada = "Home" if idioma == "en" else "Portada"
    marca = ('{%% if page.name == "%s" %%} style=color:var(--tinta){%% endif %%}')

    def enlace(h, t):
        return f'<a href="{h}"{marca % (h[:-5] + ".md")}>{t}</a>'

    bloques = [enlace("index.html", portada)]
    for b in PAGINAS:
        bloques.append("".join(enlace(p[k_h], p[k_t]) for p in b))
    nav = SEPARA.join(bloques)
    # el selector de idioma lleva a la pagina pareja
    casos = "".join('{%% when "%s" %%}%s' % (p[k_h][:-5] + ".md", p[otro_k])
                    for b in PAGINAS for p in b)
    pareja = "{% case page.name %}" + casos + "{% else %}index.html{% endcase %}"
    if idioma == "en":
        nav += (f'<a href="es/{pareja}" style="margin-left:auto;color:var(--oro)">'
                'Castellano</a>')
    else:
        nav += (f'<a href="../{pareja}" style="margin-left:auto;color:var(--oro)">'
                'English</a>')
    return ('<meta charset="utf-8">\n'
            '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
            f'<title>{{{{ page.title }}}} — {NOMBRE} (Konami, {ANIO})</title>\n'
            f'<style>{ESTILO}</style>\n'
            f'<div class="w"><nav class="top">{nav}</nav>\n'
            '{{ content }}\n'
            f'<footer><p>{PIE_LEGAL[idioma]}</p></footer></div>\n')


def redireccion(nueva):
    return ('<meta charset="utf-8">\n'
            f'<meta http-equiv="refresh" content="0; url={nueva}">\n'
            f'<link rel="canonical" href="{nueva}">\n'
            f'<p><a href="{nueva}">{nueva}</a></p>\n')


def escribe(ruta, texto):
    os.makedirs(os.path.dirname(ruta), exist_ok=True)
    with open(ruta, "w", encoding="utf-8", newline="\n") as f:
        f.write(texto)
    print("  " + ruta)


def main(docs):
    escribe(os.path.join(docs, "_config.yml"), CONFIG)
    for idioma in ("en", "es"):
        escribe(os.path.join(docs, "_layouts", idioma + ".html"), plantilla(idioma))
    es = {p[1] for b in PAGINAS for p in b}
    for vieja, nueva in VIEJAS.items():
        d = os.path.join(docs, "es") if nueva in es else docs
        escribe(os.path.join(d, vieja), redireccion(nueva))
    return 0


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    sys.exit(main(sys.argv[1]))
