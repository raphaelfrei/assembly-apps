;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;             Assembly Exercises - Exer. 7                  ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg Code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:
    lda #10         ; Load 10 into A
    sta $80         ; Storage A value into Memory 80

    inc $80         ; Increment 1 from Memory Position 80
    dec $80         ; Decrement 1 from Memory Position 80

    jmp Start

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)