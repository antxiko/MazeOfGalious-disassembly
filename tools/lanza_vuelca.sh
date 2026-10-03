#!/bin/sh
# lanza_vuelca.sh <dir> <segundos> [teclas] [pokes]: tools/omsx_vuelca.tcl, UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/$1
mkdir -p $d
cd $R
GO_OUT="$d" GO_SEGS=$2 GO_TECLAS="$3" GO_POKES="$4" timeout 1800 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_JP -cart galious.rom -romtype Konami -script tools/omsx_vuelca.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
