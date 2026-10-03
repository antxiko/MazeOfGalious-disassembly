# omsx_partida.tcl - Empieza una PARTIDA (no la demo), lleva al personaje a
# UNA sala y la vuelca varias veces.
#
# Pulsa espacio cada segundo hasta que el juego esta en su bucle de partida
# (0xE000 = 5). Entonces, como omsx_mundos.tcl, pone el mapa en 0xE041, la
# sala en las cuatro vecinas (0xE648-0xE64B) y al personaje en el borde
# derecho (0xE507 = 0xF9), y aprieta la flecha derecha hasta que cambia la
# sala. NO borra 0xE690: la sala especial (p02:8EEF) debe hacer lo suyo.
# Con GO_JEFE=1, GO_ESPERA cuadros despues de llegar pone 0xE020 = 1, lo que
# el juego hace al acertar el nombre del jefe (p02:9B14).
# Vuelca (como omsx_vuelca.tcl) a los cuadros de GO_FOTOS contados desde la
# llegada: <dir>/vMMSS_<cuadro>.vram/.ram/.png. En <dir>/traza.txt cada
# cambio de 0xE000/0xE001 con su cuadro.
# Con GO_F2=1, GO_ESPERA cuadros despues de llegar pulsa F2 (fila 6, bit 6;
# lo lee p02:9E07) durante 5 cuadros.
# Con GO_JEFE=1 apunta tambien en traza.txt cada cambio del mosaico del jefe
# (0xE70A, el hueco 0xE700) con su tipo (0xE700).
# GO_OUT=<dir>, GO_SEGS, GO_SALA="MM:SS" (hex), GO_FOTOS="40 200 ...".
set OUT $::env(GO_OUT)
set SEGS $::env(GO_SEGS)
lassign [split $::env(GO_SALA) :] ::M ::S
set ::FOTOS $::env(GO_FOTOS)
set ::F2 [expr {[info exists ::env(GO_F2)] && $::env(GO_F2) eq "1"}]
set ::JEFE [expr {[info exists ::env(GO_JEFE)] && $::env(GO_JEFE) eq "1"}]
set ::ESPERA [expr {[info exists ::env(GO_ESPERA)] && $::env(GO_ESPERA) ne "" ? $::env(GO_ESPERA) : 60}]
set ::fase arranca
set ::cuadros 0
set ::llegada 0
set ::est ""
set ::mos -1
set ::err ""
set ::t [open [file join $OUT traza.txt] w]
proc apunta {s} { puts $::t "$::cuadros $s"; flush $::t }
proc vuelca {k} {
    set b [file join $::OUT "v$k"]
    if {[catch {save_debuggable VRAM "$b.vram"} e]} { append ::err " vram:$e" }
    set f [open "$b.ram" w]; fconfigure $f -translation binary
    set s ""
    for {set a 0xC000} {$a <= 0xFFFF} {incr a} { append s [binary format c [debug read memory $a]] }
    puts -nonewline $f $s; close $f
    if {[catch {screenshot "$b.png"} e]} { append ::err " png:$e" }
    apunta "vuelca $k"
}
proc mira {} {
    incr ::cuadros
    set e [format "%02X:%02X" [debug read memory 0xE000] [debug read memory 0xE001]]
    set k [format "%02X%02X" [debug read memory 0xE041] [debug read memory 0xE042]]
    if {$e ne $::est} { set ::est $e; apunta "estado $e sala $k E690 [format %02X [debug read memory 0xE690]] E0D2 [format %02X [debug read memory 0xE0D2]]" }
    switch $::fase {
        arranca {
            if {[debug read memory 0xE000] == 5} { set ::fase lleva; apunta "partida"; return }
            if {$::cuadros % 60 == 0} { keymatrixdown 8 0x01 }
            if {$::cuadros % 60 == 5} { keymatrixup 8 0x01 }
        }
        lleva {
            if {[debug read memory 0xE000] != 5 || [debug read memory 0xE01A] != 0} return
            debug write memory 0xE041 [expr {"0x$::M"}]
            foreach a {0xE648 0xE649 0xE64A 0xE64B} { debug write memory $a [expr {"0x$::S"}] }
            debug write memory 0xE507 0xF9
            keymatrixdown 8 0x80
            set ::fase espera
            apunta "lleva a $::M:$::S"
        }
        espera {
            if {$k eq "$::M$::S"} { keymatrixup 8 0x80; set ::fase dentro; set ::llegada $::cuadros; apunta "llega" }
        }
        dentro {
            set n [expr {$::cuadros - $::llegada}]
            if {$::JEFE && $n == $::ESPERA} { debug write memory 0xE020 1; apunta "E020=1" }
            if {$::F2 && $n == $::ESPERA} { keymatrixdown 6 0x40; apunta "F2" }
            if {$::F2 && $n == $::ESPERA + 5} { keymatrixup 6 0x40 }
            if {$::JEFE} {
                set v [debug read memory 0xE70A]
                if {$v != $::mos} { set ::mos $v; apunta [format "mosaico %d tipo %02X" $v [debug read memory 0xE700]] }
            }
            if {[lsearch $::FOTOS $n] >= 0} { vuelca "${::M}${::S}_$n" }
            if {$n >= [lindex $::FOTOS end]} { fin }
        }
    }
}
proc fin {} {
    apunta "fin fase $::fase err $::err"
    close $::t
    exit
}
set throttle off
debug set_bp 0x40EF {} mira
after time $SEGS fin
