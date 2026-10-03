# omsx_vigila.tcl - Apunta quien escribe en un tramo de memoria.
#
# GO_OUT=<dir>, GO_SEGS=<segundos emulados>, GO_DE / GO_A = el tramo (hex).
# Deja en <dir>/escrituras.txt una linea por escritura: el PC de la
# instruccion, la direccion, el valor y el mapa/sala (0xE041/0xE042).
set OUT $::env(GO_OUT)
set SEGS $::env(GO_SEGS)
set ::f [open [file join $OUT escrituras.txt] w]
proc apunta {} {
    puts $::f [format "pc %04X dir %04X valor %02X mapa %02X sala %02X" \
        [reg pc] $::wp_last_address $::wp_last_value \
        [debug read memory 0xE041] [debug read memory 0xE042]]
}
set throttle off
debug set_watchpoint write_mem [list $::env(GO_DE) $::env(GO_A)] {} apunta
after time $SEGS {close $::f; exit}
