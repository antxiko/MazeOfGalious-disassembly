# omsx_bordes.tcl - El orden de las vecinas, en partida: empieza una partida
# (espacio hasta 0xE000 = 5) y saca al personaje por los bordes SIN tocar las
# vecinas: pone la x en 0xF9 (o 0x08) y aprieta derecha (o izquierda) hasta que
# cambia la sala. GO_PASOS="d d i i" (d derecha, i izquierda). Apunta en
# <dir>/traza.txt la sala de salida, las cuatro vecinas de 0xE648 y la sala
# de llegada. GO_OUT=<dir>, GO_SEGS.
set OUT $::env(GO_OUT)
set ::PASOS $::env(GO_PASOS)
set ::fase arranca
set ::cuadros 0
set ::t0 0
set ::t [open [file join $OUT traza.txt] w]
proc apunta {s} { puts $::t "$::cuadros $s"; flush $::t }
proc rd {a} { format %02X [debug read memory $a] }
proc sala {} { return "[rd 0xE041]:[rd 0xE042]" }
proc mira {} {
    incr ::cuadros
    set n [expr {$::cuadros - $::t0}]
    switch $::fase {
        arranca {
            if {[debug read memory 0xE000] == 5} { set ::fase espera; set ::t0 $::cuadros; apunta "partida [sala]"; return }
            if {$::cuadros % 60 == 0} { keymatrixdown 8 0x01 }
            if {$::cuadros % 60 == 5} { keymatrixup 8 0x01 }
        }
        espera {
            if {$n < 90 || [debug read memory 0xE000] != 5 || [debug read memory 0xE01A] != 0} return
            if {[llength $::PASOS] == 0} { apunta fin; close $::t; exit }
            set ::lado [lindex $::PASOS 0]; set ::PASOS [lrange $::PASOS 1 end]
            set ::de [sala]
            apunta "sale $::de por $::lado vecinas [rd 0xE648] [rd 0xE649] [rd 0xE64A] [rd 0xE64B]"
            if {$::lado eq "d"} { debug write memory 0xE507 0xF9; keymatrixdown 8 0x80 } else { debug write memory 0xE507 0x08; keymatrixdown 8 0x10 }
            set ::fase andando; set ::t0 $::cuadros
        }
        andando {
            if {[sala] ne $::de} { keymatrixup 8 0x80; keymatrixup 8 0x10; apunta "llega [sala]"; set ::fase espera; set ::t0 $::cuadros; return }
            if {$n > 300} { keymatrixup 8 0x80; keymatrixup 8 0x10; apunta "no sale"; set ::fase espera; set ::t0 $::cuadros }
        }
    }
}
set throttle off
debug set_bp 0x40EF {} mira
after time $::env(GO_SEGS) {apunta tiempo; close $::t; exit}
