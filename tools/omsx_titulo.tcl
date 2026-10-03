# omsx_titulo.tcl - Vuelca la VRAM del logotipo de Konami y del titulo.
#
# Cada TI segundos emulados (por defecto 0.25) guarda <dir>/tNNN.vram (los 16
# KB de la VRAM) y apunta en <dir>/estados.txt "NNN estado paso r0..r7"
# (0xE000, 0xE001 y los registros del VDP). Sin teclas: el arranque, el
# logotipo y el titulo tal como salen solos.
# TI_OUT=<dir>, TI_SEGS=<segundos emulados> (por defecto 20).
set OUT $::env(TI_OUT)
set SEGS [expr {[info exists ::env(TI_SEGS)] ? $::env(TI_SEGS) : 20}]
set PASO [expr {[info exists ::env(TI_PASO)] ? $::env(TI_PASO) : 0.25}]
set ::n 0
set ::log [open [file join $OUT estados.txt] w]
proc vuelca {} {
    set b [file join $::OUT [format "t%03d" $::n]]
    save_debuggable VRAM "$b.vram"
    set r ""
    for {set i 0} {$i < 8} {incr i} { append r " [format %02X [debug read {VDP regs} $i]]" }
    puts $::log [format "%03d %02X %02X%s" $::n [debug read memory 0xE000] [debug read memory 0xE001] $r]
    flush $::log
    incr ::n
    after time $::PASO vuelca
}
proc fin {} { close $::log; exit }
set throttle off
after time $PASO vuelca
after time $SEGS fin
