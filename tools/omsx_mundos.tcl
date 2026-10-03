# omsx_mundos.tcl - Lleva la demo a las salas que se le pidan y vuelca cada una.
#
# En plena demo (0xE000 = 2, 0xE001 = 1, sin cambio de sala en curso: 0xE01A
# = 0) pone el mapa del objetivo en 0xE041, la sala en las cuatro vecinas
# copiadas (0xE648-0xE64B, p00:5221) y al personaje en el borde derecho
# (0xE507 = 0xF9), y borra 0xE690 y 0xE740 (la cosa, p00:5DAB): si no, la marca de la sala especial del
# mundo (p02:8EEF) se arrastra y las siguientes no se montan (p00:5561). El
# propio juego sale por la derecha (p03:A838) y carga la sala. GO_ESPERA
# cuadros despues (40 si no se da) se guarda como en omsx_vuelca.tcl:
#   <dir>/vMMSS.vram, vMMSS.ram (0xC000-0xFFFF) y vMMSS.png
# GO_OUT=<dir>, GO_SEGS=<segundos emulados>, GO_SALAS="MM:SS ..." (hex).
set OUT $::env(GO_OUT)
set SEGS $::env(GO_SEGS)
set ::pend $::env(GO_SALAS)
set ::ult ""
set ::espera 0
set ::ESPERA [expr {[info exists ::env(GO_ESPERA)] && $::env(GO_ESPERA) ne "" ? $::env(GO_ESPERA) : 40}]
set ::enfria 0
set ::hechos [dict create]
set ::cuadros 0
set ::err ""
# GO_FIG=1: <dir>/figuras.txt, una linea por cada [mapa:sala tipo dibujo
# color sprite] distinto de los huecos de figura 0xE800-0xE9FF (32 bytes:
# (ix+0) tipo, (ix+0x0A) dibujo, (ix+0x0B) color, bit 7 de (ix+0x14) sprite)
set ::FIG [expr {[info exists ::env(GO_FIG)] && $::env(GO_FIG) ne ""}]
set ::figs [dict create]
proc vuelca {k} {
    set b [file join $::OUT "v$k"]
    if {[catch {save_debuggable VRAM "$b.vram"} e]} { append ::err " vram:$e" }
    set f [open "$b.ram" w]; fconfigure $f -translation binary
    set s ""
    for {set a 0xC000} {$a <= 0xFFFF} {incr a} { append s [binary format c [debug read memory $a]] }
    puts -nonewline $f $s; close $f
    if {[catch {screenshot "$b.png"} e]} { append ::err " png:$e" }
}
proc figuras {} {
    set k [format "%02X:%02X" [debug read memory 0xE041] [debug read memory 0xE042]]
    for {set a 0xE800} {$a < 0xEA00} {incr a 0x20} {
        set t [debug read memory $a]
        if {$t == 0} continue
        set l [format "%s %02X %02X %02X %02X" $k $t [debug read memory [expr {$a + 0x0A}]]             [debug read memory [expr {$a + 0x0B}]] [expr {[debug read memory [expr {$a + 0x14}]] >> 7}]]
        if {![dict exists $::figs $l]} { dict set ::figs $l $::cuadros }
    }
}
proc mira {} {
    incr ::cuadros
    if {$::FIG} figuras
    set k [format "%02X:%02X" [debug read memory 0xE041] [debug read memory 0xE042]]
    if {$k ne $::ult} { set ::ult $k; set ::espera $::ESPERA; return }
    if {$::espera > 0} {
        incr ::espera -1
        if {$::espera == 0 && [lsearch $::pend $k] >= 0 && ![dict exists $::hechos $k]} {
            dict set ::hechos $k 1
            vuelca [string map {: ""} $k]
            set ::pend [lsearch -all -inline -not -exact $::pend $k]
            if {[llength $::pend] == 0} { fin }
        }
        return
    }
    if {$::enfria > 0} { incr ::enfria -1; return }
    if {[debug read memory 0xE000] != 2 || [debug read memory 0xE001] != 1} return
    if {[debug read memory 0xE01A] != 0} return
    lassign [split [lindex $::pend 0] :] m s
    debug write memory 0xE041 [expr {"0x$m"}]
    foreach a {0xE648 0xE649 0xE64A 0xE64B} { debug write memory $a [expr {"0x$s"}] }
    debug write memory 0xE507 0xF9
    debug write memory 0xE690 0
    debug write memory 0xE740 0
    set ::enfria 30
}
proc fin {} {
    set f [open [file join $::OUT traza.txt] w]
    puts $f "cuadros $::cuadros hechos [dict keys $::hechos] faltan $::pend err $::err"
    close $f
    if {$::FIG} {
        set f [open [file join $::OUT figuras.txt] w]
        dict for {l c} $::figs { puts $f "$l $c" }
        close $f
    }
    exit
}
set throttle off
debug set_bp 0x40EF {} mira
after time $SEGS fin
# Opcional: GO_DE/GO_A apuntan en <dir>/escrituras.txt quien escribe en ese
# tramo de la RAM (PC, direccion, valor, mapa:sala).
if {[info exists ::env(GO_DE)] && $::env(GO_DE) ne ""} {
    set ::fe [open [file join $OUT escrituras.txt] w]
    proc apunta {} {
        puts $::fe [format "%02X:%02X pc %04X dir %04X valor %02X" [debug read memory 0xE041] \
            [debug read memory 0xE042] [reg pc] $::wp_last_address $::wp_last_value]
        flush $::fe
    }
    debug set_watchpoint write_mem [list $::env(GO_DE) $::env(GO_A)] {} apunta
}
# Opcional: GO_SPR=1 apunta en <dir>/sprites.txt cada direccion de escritura
# de la VRAM en 0x1800-0x1FFF (puerto 0x99): mapa:sala, PC y la pila.
if {[info exists ::env(GO_SPR)] && $::env(GO_SPR) ne ""} {
    set ::fs [open [file join $OUT sprites.txt] w]
    set ::bajo -1
    proc apunta99 {} {
        set v $::wp_last_value
        if {$::bajo < 0} { set ::bajo $v; return }
        set a [expr {(($v & 0x3F) << 8) | $::bajo}]
        set ::bajo -1
        if {($v & 0xC0) != 0x40 || $a < 0x1800 || $a > 0x1FFF} return
        set sp [reg sp]
        puts $::fs [format "%02X:%02X cuadro %d pc %04X vram %04X pila %04X %04X %04X %04X"             [debug read memory 0xE041] [debug read memory 0xE042] $::cuadros [reg pc] $a             [peek16 $sp] [peek16 [expr {$sp+2}]] [peek16 [expr {$sp+4}]] [peek16 [expr {$sp+6}]]]
        flush $::fs
    }
    debug set_watchpoint write_io 0x99 {} apunta99
}
