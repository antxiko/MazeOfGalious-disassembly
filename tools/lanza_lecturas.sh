#!/bin/sh
# lanza_lecturas.sh <nombre> <segundos> [fichero de teclas]: una medida de
# tools/omsx_lecturas.tcl en work/omsx/<nombre>.txt. UN openMSX cada vez.
R=$(cd "$(dirname "$0")/.." && pwd)
O=$R/work/omsx
mkdir -p $O
cd $R
X="/c/Program Files/openMSX/openmsx.exe"
T=""
[ -n "$3" ] && T="$(cat $3)"
KK_OUT=$O/$1.txt KK_SEGS=$2 KK_TECLAS="$T" KK_FOTOS="20 40 60 80" \
  timeout 1800 "$X" -machine C-BIOS_MSX1_JP -cart galious.rom -romtype Konami -script tools/omsx_lecturas.tcl > $O/$1.log 2>&1
echo hecho > $O/$1.fin
