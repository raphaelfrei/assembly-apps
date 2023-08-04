;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;             Assembly Exercises - Exer. 9                  ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg Code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:
    lda #10         ; Load A with 10

Loop:
    clc             ; Clear CARRY flag
    adc #1          ; Add 1 to A
    cmp #10         ; Compare A with 10 (Always compares the A)
    bne Loop        ; Branch if the comparision was not equals (to 0)

    jmp Start

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)