#!/bin/sh
# lanza_poses.sh <dir> <segundos> [cambia] ["cuadros de foto"]: tools/omsx_poses.tcl, UN openMSX.
R=$(cd "$(dirname "$0")/.." && pwd)
d=$R/work/$1
mkdir -p $d
cd $R
GO_OUT="$d" GO_SEGS=$2 GO_CAMBIA=$3 GO_FOTOS="$4" timeout 3000 "/c/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_JP -cart galious.rom -romtype Konami -script tools/omsx_poses.tcl > $d/stdout.txt 2>&1
echo hecho > $d/fin.txt
