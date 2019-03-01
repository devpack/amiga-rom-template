        org $f80000             ; System ROM image location

custom=$dff000
bplcon0=$100
color00=$180
ciaa=$bfe001
pra=$000
ddra=$200

        ; The ROM is mapped at $000000 on startup shadowing RAM
rom_start:
        dc.l    0               ; Initial SP
        dc.l    rom_code        ; Initial PC

rom_code:
        move.l  #custom, a0     ; a0 = custom
        move.l  #ciaa, a1       ; a1 = ciaa
        move.b  #3, ddra(a1)    ; Set port A direction to output for /LED and OVL
        move.b  #0, pra(a1)     ; Disable OVL (Memory from $0 onwards available)
        move.w  #1<<9, bplcon0(a0) ; BPU=0, COLOR=1

.l:
        bchg.b  #1, pra(a1)     ; Blink LED
        move.w  d0, color00(a0) ; Change background color
        addq.w  #1, d0
        moveq   #-1, d1

.delay: dbf     d1, .delay
        bra.s   .l
