#!/bin/sh
# lanza_mundos.sh <dir> <segundos> "<MM:SS ...>": tools/omsx_mundos.tcl, UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/$1
mkdir -p $d
cd $R
GO_OUT="$d" GO_SEGS=$2 GO_SALAS="$3" GO_DE=$4 GO_A=$5 timeout 3000 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_JP -cart galious.rom -romtype Konami -script tools/omsx_mundos.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
