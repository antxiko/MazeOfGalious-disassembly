# omsx_zeus.tcl - ZEUS en partida: empieza una partida (espacio hasta 0xE000 = 5),
# pulsa F2 (la pausa de la taza, p00:474A, la unica que llama a p01:7E57),
# teclea Z E U S, vuelve a pulsar F2 y apunta 0xE027/0xE028. Luego mete dano
# (0xC0 en 0xE05E y 0xE061, el cambio de vida con signo de p01:6203) hasta que
# se acaba la partida, y vuelca a los cuadros de GO_FOTOS desde que deja el
# estado 5; GO_F5 cuadros despues pulsa F5 (fila 7, bit 1; p01:7EF1).
# Con GO_SIN=1 no teclea (la partida sin ZEUS, para comparar).
# GO_OUT=<dir>, GO_SEGS, GO_FOTOS, GO_F5. Traza en <dir>/traza.txt.
set OUT $::env(GO_OUT)
set SEGS $::env(GO_SEGS)
set ::FOTOS $::env(GO_FOTOS)
set ::F5 $::env(GO_F5)
set ::SIN [expr {[info exists ::env(GO_SIN)] && $::env(GO_SIN) eq "1"}]
set ::fase arranca
set ::cuadros 0
set ::t0 0
set ::est ""
set ::t [open [file join $OUT traza.txt] w]
proc apunta {s} { puts $::t "$::cuadros $s"; flush $::t }
proc rd {a} { format %02X [debug read memory $a] }
proc vuelca {k} {
    set b [file join $::OUT "v$k"]
    catch {save_debuggable VRAM "$b.vram"}
    set f [open "$b.ram" w]; fconfigure $f -translation binary
    set s ""
    for {set a 0xC000} {$a <= 0xFFFF} {incr a} { append s [binary format c [debug read memory $a]] }
    puts -nonewline $f $s; close $f
    catch {screenshot "$b.png"}
    apunta "vuelca $k"
}
# Z (5,7) E (3,2) U (5,2) S (5,0)
set ::teclas {{5 0x80} {3 0x04} {5 0x04} {5 0x01}}
proc mira {} {
    incr ::cuadros
    set e "[rd 0xE000]:[rd 0xE001]"
    if {$e ne $::est} { set ::est $e; apunta "estado $e sala [rd 0xE041][rd 0xE042] E027 [rd 0xE027]" }
    set n [expr {$::cuadros - $::t0}]
    switch $::fase {
        arranca {
            if {[debug read memory 0xE000] == 5} { set ::fase teclea; set ::t0 $::cuadros; apunta "partida sala [rd 0xE041][rd 0xE042]"; return }
            if {$::cuadros % 60 == 0} { keymatrixdown 8 0x01 }
            if {$::cuadros % 60 == 5} { keymatrixup 8 0x01 }
        }
        teclea {
            if {$n == 100} { keymatrixdown 6 0x40; apunta "F2" }
            if {$n == 105} { keymatrixup 6 0x40 }
            if {$n < 160} return
            set k [expr {($n - 160) / 12}]
            if {$::SIN || $k >= 4} {
                if {$k == 6 && ($n - 160) % 12 == 0} { keymatrixdown 6 0x40; apunta "F2 tecleado E027 [rd 0xE027] E028 [rd 0xE028]" }
                if {$k == 6 && ($n - 160) % 12 == 5} { keymatrixup 6 0x40 }
                if {$k >= 9} { set ::fase dano; apunta "dano E027 [rd 0xE027]" }
                return
            }
            lassign [lindex $::teclas $k] fila bit
            if {($n - 160) % 12 == 0} { keymatrixdown $fila $bit }
            if {($n - 160) % 12 == 6} { keymatrixup $fila $bit; apunta "tecla $k E028 [rd 0xE028]" }
        }
        dano {
            if {[debug read memory 0xE000] != 5} { set ::fase mata; set ::t0 $::cuadros; apunta "fuera del 5"; return }
            debug write memory 0xE05E 0xC0; debug write memory 0xE061 0xC0
        }
        mata {
            if {$n == $::F5} { keymatrixdown 7 0x02; apunta "F5" }
            if {$n == $::F5 + 6} { keymatrixup 7 0x02 }
            if {[lsearch $::FOTOS $n] >= 0} { vuelca "z_$n" }
            if {$n >= [lindex $::FOTOS end]} { apunta "fin"; close $::t; exit }
        }
    }
}
set throttle off
debug set_bp 0x40EF {} mira
after time $SEGS {apunta "tiempo"; close $::t; exit}
