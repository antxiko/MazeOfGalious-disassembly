#!/bin/sh
# lanza_partida.sh <dir> <segundos> <MM:SS> "<cuadros>" [jefe]: tools/omsx_partida.tcl, UN openMSX. (GO_MAQ=otra maquina)
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/$1
mkdir -p $d
cd $R
GO_OUT="$d" GO_SEGS=$2 GO_SALA="$3" GO_FOTOS="$4" GO_JEFE="$5" timeout 1200 "/c/Program Files/openMSX/openmsx.exe" -machine ${GO_MAQ:-C-BIOS_MSX1_JP} -cart galious.rom -romtype Konami -script tools/omsx_partida.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
