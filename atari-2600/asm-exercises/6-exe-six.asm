;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;             Assembly Exercises - Exer. 6                  ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg Code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:

    lda #1          ; Load A with decimal 1
    ldx #2          ; Load X with decimal 2
    ldy #3          ; Load y with decimal 3

    inx             ; Increment 1 to X
    iny             ; Increment 1 to Y

    clc             ; Clear CARRY flag
    adc #1          ; Add 1 to A - 6502 does not increment the Accumulator

    dex             ; Decrement 1 from X
    dey             ; Decrement 1 from Y

    sec             ; Set the CARRY flag
    sbc #1          ; Remove 1 from A - Does not have DEA directly

    jmp Start

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)