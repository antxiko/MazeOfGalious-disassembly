# omsx_poses.tcl - Apunta lo que p01:73E4 escribe del jugador.
#
# Deja correr la demo. En p01:745B (el ret de p01:7400, con el jugador ya
# escrito desde la direccion de 0xE60A) apunta la RAM que lo decide y los
# 12 bytes escritos; solo las lineas distintas. Cada GO_CAMBIA cuadros
# (H.KEYI, 0x40EF) cambia de personaje: 0xE501 = 1 Popolon, 0 Afrodita.
# GO_OUT=<dir>, GO_SEGS=<segundos emulados>, GO_CAMBIA (600 si no se da),
# GO_FOTOS="cuadro ...": vuelca VRAM, RAM (0xC000-) y pantalla en <dir>/fNNNN.*
# Salida: <dir>/poses.txt
#   E000 E500 E501 E502 E53D E505 E507 E523 E533 E604 | 12 bytes
set OUT $::env(GO_OUT)
set SEGS $::env(GO_SEGS)
set ::CAMBIA [expr {[info exists ::env(GO_CAMBIA)] && $::env(GO_CAMBIA) ne "" ? $::env(GO_CAMBIA) : 600}]
set ::vistas [dict create]
set ::cuadros 0
proc b {a} { return [format %02X [debug read memory $a]] }
proc apunta {} {
    # el banco 1 en 0x6000: djnz en 0x7459 y ret en 0x745B
    if {[debug read memory 0x7459] != 0x10 || [debug read memory 0x745B] != 0xC9} return
    set l ""
    foreach a {0xE000 0xE500 0xE501 0xE502 0xE53D 0xE505 0xE507 0xE523 0xE533 0xE604} { append l [b $a] " " }
    append l "|"
    set p [expr {[debug read memory 0xE60A] | ([debug read memory 0xE60B] << 8)}]
    for {set i 0} {$i < 12} {incr i} { append l " " [b [expr {$p + $i}]] }
    if {![dict exists $::vistas $l]} { dict set ::vistas $l $::cuadros }
}
set ::FOTOS [expr {[info exists ::env(GO_FOTOS)] ? $::env(GO_FOTOS) : ""}]
proc foto {} {
    set b [file join $::OUT [format "f%04d" $::cuadros]]
    save_debuggable VRAM "$b.vram"
    set f [open "$b.ram" w]; fconfigure $f -translation binary
    set s ""
    for {set a 0xC000} {$a <= 0xFFFF} {incr a} { append s [binary format c [debug read memory $a]] }
    puts -nonewline $f $s; close $f
    screenshot "$b.png"
}
proc cuadro {} {
    incr ::cuadros
    if {[lsearch $::FOTOS $::cuadros] >= 0} { foto }
    if {$::cuadros % $::CAMBIA == 0} {
        debug write memory 0xE501 [expr {1 - ([debug read memory 0xE501] & 1)}]
    }
}
proc fin {} {
    set f [open [file join $::OUT poses.txt] w]
    dict for {l c} $::vistas { puts $f $l }
    close $f
    exit
}
set throttle off
debug set_bp 0x745B {} apunta
debug set_bp 0x40EF {} cuadro
after time $SEGS fin
