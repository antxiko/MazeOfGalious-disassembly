#!/bin/sh
# lanza_titulo.sh <dir> [segundos]: tools/omsx_titulo.tcl en work/<dir>, UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/$1
mkdir -p $d
cd $R
TI_OUT="$d" TI_SEGS=${2:-20} timeout 900 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_JP -cart galious.rom -romtype Konami -script tools/omsx_titulo.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
