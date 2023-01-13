;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                    Raphael Frei - 2023                    ;
;                Assembly Exercises - Exer. 4               ;
;                   Designed for Atari 2600                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    processor 6502
    seg Code            ; Define a new segment named "Code"
    org $F000           ; Define the origin of the ROM code at memory address $F000

Start:
    
    cld
    lda #100

    clc
    adc #5

    sec
    sbc #10

    org $FFFC           ; End the ROM by adding required values to memory position $FFFC
    .word Start         ; Put 2 bytes with the reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with the break address at memory position $FFFE