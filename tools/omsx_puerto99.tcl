# omsx_puerto99.tcl - Apunta las direcciones de VRAM que se fijan (puerto 0x99)
# mientras el juego esta en una sala dada.
# GO_OUT=<dir>, GO_SEGS=<segundos>, GO_SALAS="mapa:sala ..." (hex, como 01:8F).
set OUT $::env(GO_OUT)
set ::f [open [file join $OUT puerto99.txt] w]
set ::salas $::env(GO_SALAS)
set ::bajo -1
proc apunta {} {
    set k [format "%02X:%02X" [debug read memory 0xE041] [debug read memory 0xE042]]
    if {[lsearch $::salas $k] < 0} { set ::bajo -1; return }
    set v $::wp_last_value
    if {$::bajo < 0} { set ::bajo $v; return }
    if {($v & 0x80) == 0} {
        set sp [reg sp]
        puts $::f [format "%s pc %04X vram %04X %s pila %04X %04X %04X %04X" $k [reg pc] [expr {(($v & 0x3F) << 8) | $::bajo}] [expr {$v & 0x40 ? "escribe" : "lee"}] [peek16 $sp] [peek16 [expr {$sp+2}]] [peek16 [expr {$sp+4}]] [peek16 [expr {$sp+6}]]]
    }
    set ::bajo -1
}
set throttle off
debug set_watchpoint write_io 0x99 {} apunta
after time $::env(GO_SEGS) {close $::f; exit}
# Y, si se da GO_DE/GO_A, quien escribe en ese tramo de la RAM en esas salas.
proc apunta_ram {} {
    set k [format "%02X:%02X" [debug read memory 0xE041] [debug read memory 0xE042]]
    if {[lsearch $::salas $k] < 0} return
    puts $::f [format "%s pc %04X ram %04X valor %02X" $k [reg pc] $::wp_last_address $::wp_last_value]
}
if {[info exists ::env(GO_DE)]} {
    debug set_watchpoint write_mem [list $::env(GO_DE) $::env(GO_A)] {} apunta_ram
}
