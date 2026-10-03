#!/usr/bin/env python3
"""Dibuja salas y mapas de The Maze of Galious desde la ROM (tools/vram.py).

Uso: dibuja.py sala <mapa> <sala> <png>
     dibuja.py mapa <mapa> <png> [--numeros]
                                          el mapa entero, colocado por sus vecinas
                                          (con --numeros, el numero de cada sala)
     dibuja.py coteja <dir de volcados>   compara cada volcado vMMSS.vram con el modelo
"""
import glob
import os
import sys

try:
    from PIL import Image
except ImportError:            # solo lo necesitan los PNG
    Image = None

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import mapas as M  # noqa: E402
import vram as V  # noqa: E402

# Los 16 colores del TMS9918 (los de openMSX por defecto)
TMS = [(0, 0, 0), (0, 0, 0), (33, 200, 66), (94, 220, 120), (84, 85, 237), (125, 118, 252),
       (212, 82, 77), (66, 235, 245), (252, 85, 84), (255, 121, 120), (212, 193, 84),
       (230, 206, 128), (33, 176, 59), (201, 91, 186), (204, 204, 204), (255, 255, 255)]


def pinta_caracter(px, x, y, pat, col, fondo=(0, 0, 0)):
    for f in range(8):
        p, c = pat[f], col[f]
        for b in range(8):
            ci = (c >> 4) if p & (0x80 >> b) else (c & 0x0F)
            px[x + b, y + f] = TMS[ci] if ci else fondo


def sala_png(rom, m, n):
    vr = V.carga_sala(rom, V.Vram(rom), m, n)
    t = V.nombres_con_objetos(rom, m, n)
    im = Image.new("RGB", (256, 160))
    px = im.load()
    for fy in range(20):
        terc = (fy + 4) // 8
        for fx in range(32):
            pat, col = vr.caracter(terc, t[fy][fx])
            pinta_caracter(px, fx * 8, fy * 8, pat, col)
    return im


def rejilla(rom, m):
    """{sala: (x, y)} colocando las salas por sus vecinas desde la 1."""
    pos = {1: (0, 0)}
    pend = [1]
    while pend:
        s = pend.pop()
        x, y = pos[s]
        for (dx, dy), v in zip(((0, -1), (0, 1), (-1, 0), (1, 0)), M.vecinas(rom.d, m, s)):
            if 1 <= v <= M.n_salas(rom.d, m) and v not in pos:
                pos[v] = (x + dx, y + dy)
                pend.append(v)
    return pos


def mapa_png(rom, m, numeros=False):
    """El mapa entero colocado por vecinas (rejilla). Las salas que no se
    alcanzan por vecinas van aparte, en una fila debajo. Con numeros, cada sala
    lleva el suyo en la esquina de arriba a la izquierda."""
    pos = rejilla(rom, m)
    xs = [p[0] for p in pos.values()]
    ys = [p[1] for p in pos.values()]
    x0, y0 = min(xs), min(ys)
    sueltas = [s for s in range(1, M.n_salas(rom.d, m) + 1) if s not in pos]
    # Las salas se numeran en orden de lectura (salvo la entrada del castillo):
    # una sala sin vecinas va al hueco que dejan la anterior y la siguiente si
    # estan en la misma fila con un solo hueco libre entre ellas (la 94 del
    # castillo, entre la 93 y la 95). Es una deduccion, no una vecina.
    por_numero = {}
    for s in list(sueltas):
        a, b = pos.get(s - 1), pos.get(s + 1)
        if a and b and a[1] == b[1] and b[0] - a[0] == 2 and (a[0] + 1, a[1]) not in pos.values():
            por_numero[s] = (a[0] + 1, a[1])
            sueltas.remove(s)
    filas = max(ys) - y0 + 1 + (2 if sueltas else 0)
    im = Image.new("RGB", ((max(xs) - x0 + 1) * 256, filas * 160), (16, 16, 16))
    sitios = {s: ((x - x0) * 256, (y - y0) * 160) for s, (x, y) in list(pos.items()) + list(por_numero.items())}
    for k, s in enumerate(sueltas):
        sitios[s] = (k * 256, (filas - 1) * 160)
    for s, xy in sitios.items():
        im.paste(sala_png(rom, m, s), xy)
    if numeros:
        from PIL import ImageDraw, ImageFont
        dr = ImageDraw.Draw(im)
        try:
            letra = ImageFont.truetype("arial.ttf", 22)
        except OSError:
            letra = ImageFont.load_default()
        for s, (x, y) in sitios.items():
            texto = "%d" % s + (" (sin vecinas)" if s in sueltas else "") +                 (" (sin vecinas)" if s in por_numero else "")
            dr.rectangle((x + 2, y + 2, x + 8 + 14 * len(texto), y + 28), fill=(0, 0, 0))
            dr.text((x + 5, y + 3), texto, fill=(255, 230, 90), font=letra)
    return im, pos


def coteja(dirv):
    rom = V.Rom()
    total = 0
    for f in sorted(glob.glob(os.path.join(dirv, "v*.vram"))):
        k = os.path.basename(f)[1:5]
        m, n = int(k[:2], 16), int(k[2:], 16)
        if m == 0 or n == 0:
            continue
        vr = open(f, "rb").read()
        nom = vr[0x3800 + 4 * 32:0x3800 + 24 * 32]
        t = V.nombres_con_objetos(rom, m, n)
        mod = V.carga_sala(rom, V.Vram(rom), m, n)
        dif_nom = sum(1 for fy in range(20) for fx in range(32) if nom[fy * 32 + fx] != t[fy][fx])
        dif_car = 0
        usados = set()
        for fy in range(20):
            terc = (fy + 4) // 8
            for fx in range(32):
                c = nom[fy * 32 + fx]
                usados.add((terc, c))
        anim = V.animados(rom, m, n)
        for terc, c in usados:
            o = terc * 0x800 + c * 8
            que = anim.get((terc, c))
            if (que != "dibujo" and vr[0x2000 + o:0x2000 + o + 8] != mod.v[0x2000 + o:0x2000 + o + 8]) or \
               (que != "color" and vr[o:o + 8] != mod.v[o:o + 8]):
                dif_car += 1
        total += dif_nom + dif_car
        print("mapa %2d sala %3d: %3d caracteres de la tabla de nombres distintos, "
              "%3d de %3d caracteres usados con otro dibujo o color (%d animados)"
              % (m, n, dif_nom, dif_car, len(usados), len(anim)))
    print("total de diferencias: %d" % total)


def main(argv):
    rom = V.Rom()
    if argv[1] == "sala":
        sala_png(rom, int(argv[2]), int(argv[3])).save(argv[4])
    elif argv[1] == "mapa":
        im, pos = mapa_png(rom, int(argv[2]), "--numeros" in argv)
        im.save(argv[3])
        print("%d salas colocadas" % len(pos))
    elif argv[1] == "coteja":
        coteja(argv[2])
    else:
        sys.exit(__doc__)


if __name__ == "__main__":
    main(sys.argv)
