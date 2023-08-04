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

    clc                ; Clear the CARRY flag
    adc #5             ; Add #5 (Decimal) into the accumulator - A now has #105

    sec                ; Always set the CARRY flag before subtraction
    sbc #10            ; Remove $10 from the accumulator - A now has #95

    org $FFFC           ; End the ROM by adding required values to memory position $FFFC
    .word Start         ; Put 2 bytes with the reset address at memory position $FFFC
    .word Start         ; Put 2 bytes with the break address at memory position $FFFE
