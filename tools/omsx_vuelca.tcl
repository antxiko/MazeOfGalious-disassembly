# omsx_vuelca.tcl - Vuelca la VRAM y la RAM en cada cambio de sala.
#
# Cada cuadro (por la interrupcion) mira 0xE041/0xE042 (mapa y sala). Cuando
# cambian, espera 40 cuadros a que la sala este pintada y guarda:
#   <dir>/vMMSS.vram  los 16 KB de la VRAM
#   <dir>/vMMSS.ram   0xC000-0xFFFF
#   <dir>/vMMSS.png   una captura (solo para mirar; el cotejo es con la VRAM)
# GO_OUT=<dir>, GO_SEGS=<segundos emulados>, GO_TECLAS (opcional, como en
# omsx_lecturas.tcl), GO_POKES="t:dir:valor ..." (opcional).
set OUT $::env(GO_OUT)
set SEGS [expr {[info exists ::env(GO_SEGS)] ? $::env(GO_SEGS) : 120}]
set ::ult ""
set ::espera 0
set ::hechos [dict create]
proc mira {} {
    incr ::cuadros
    set m [debug read memory 0xE041]
    set s [debug read memory 0xE042]
    set k [format "%02X%02X" $m $s]
    if {$k ne $::ult} { set ::ult $k; set ::espera 40; return }
    if {$::espera > 0} {
        incr ::espera -1
        if {$::espera == 0 && ![dict exists $::hechos $k]} {
            dict set ::hechos $k 1
            set b [file join $::OUT "v$k"]
            if {[catch {save_debuggable VRAM "$b.vram"} e]} { append ::err " vram:$e" }
            set f [open "$b.ram" w]; fconfigure $f -translation binary
            set s ""
            for {set a 0xC000} {$a <= 0xFFFF} {incr a} { append s [binary format c [debug read memory $a]] }
            puts -nonewline $f $s; close $f
            if {[catch {screenshot "$b.png"} e]} { append ::err " png:$e" }
        }
    }
}
proc pulsa {fila mascara dur} {
    keymatrixdown $fila $mascara
    after time $dur [list keymatrixup $fila $mascara]
}
set throttle off
debug set_bp 0x40EF {} mira
if {[info exists ::env(GO_TECLAS)]} {
    foreach t $::env(GO_TECLAS) { lassign [split $t :] s fila m dur; after time $s [list pulsa $fila $m $dur] }
}
if {[info exists ::env(GO_POKES)]} {
    foreach t $::env(GO_POKES) { lassign [split $t :] s a v; after time $s [list debug write memory $a $v] }
}
set ::cuadros 0
set ::err ""
after time $SEGS {set f [open [file join $::OUT traza.txt] w]; puts $f "cuadros $::cuadros ult $::ult hechos [dict keys $::hechos] err $::err"; close $f; exit}
