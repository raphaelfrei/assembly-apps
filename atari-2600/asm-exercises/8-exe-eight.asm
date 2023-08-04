;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;             Assembly Exercises - Exer. 8                  ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg Code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:
    ldy #10         ; Load Y with 10

Loop:
    tya             ; Transfer Y to A
    sta $80, Y      ; Store the value inside A to Memory Position $80 + Y
    dey             ; Decrement 1 from Y
    bpl Loop        ; Branch if plus (Last operation result was positive)
    ;bne Loop       ; Branch if not equal to 0 - The BPL includes 0

    jmp Start

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)