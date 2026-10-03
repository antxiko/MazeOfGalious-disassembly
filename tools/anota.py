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

INI = "# --- ANOTACIONES AUTOMATICAS (seccion que reescribe tools/anota.py; no editar a mano) ---"
FIN = "# --- fin de las anotaciones de anota.py ---"

# Lo propio del juego (rutinas, RAM, campos de las figuras) esta en
# tools/anotaciones.py: aqui solo la maquinaria.
from anotaciones import BANCOS, CAMPOS, FICHAS_IX, RAM, RAM16, RUTINAS, VECTORES  # noqa: E402

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


def fichas_de(filas):
    """Para cada instruccion, si IX apunta ahi a un hueco de figura: desde un
    `ld ix,nn` con nn en FICHAS_IX hasta el siguiente `ld ix` con otra cosa,
    un `ret` o un `jp` (un tramo sin carga de IX no cuenta)."""
    fuera, bueno = {}, False
    for k, (a, t) in enumerate(filas):
        m = re.match(r"ld ix,0([0-9a-f]{4})h$", t)
        if m:
            bueno = int(m.group(1), 16) in FICHAS_IX
        elif t.startswith(("ld ix", "pop ix")):
            bueno = False
        fuera[k] = bueno
        if t.startswith(("ret", "jp ")) and not re.match(r"ret [a-z]", t):
            bueno = False
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
        destino = VECTORES.get(dest, dest)
        via = " (por 0x%04X)" % dest if dest in VECTORES else ""
        for (bb, aa), (nom, que) in RUTINAS.items():
            if aa == destino and (bb == b or ORG[bb] == 0x4000 or not (ORG[b] <= destino < ORG[b] + 0x2000)):
                if bb == 0 or ORG[bb] <= destino < ORG[bb] + 0x2000:
                    return "%s%s: %s" % (nom, via, que)
    # los campos de la figura
    if fichas.get(k, False):
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
    m16 = re.match(r"ld (?:(hl|de|bc|ix|iy),\(0([e-f][0-9a-f]{3})h\)|\(0([e-f][0-9a-f]{3})h\),(hl|de|bc|ix|iy))$", t)
    if m16:
        v = int(m16.group(2) or m16.group(3), 16)
        if v in RAM16:
            return ("lee " if m16.group(1) else "guarda ") + RAM16[v]
        if v in RAM:
            return ("lee " if m16.group(1) else "guarda ") + RAM[v][0] + " y el byte siguiente (16 bits)"
    for x in re.findall(r"\b0([e-f][0-9a-f]{3})h\b", t):
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
