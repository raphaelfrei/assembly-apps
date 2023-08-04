;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;             Assembly Exercises - Exer. 5                  ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:

    lda #$A         ; Load A with hexadecimal $A
    ldx #%1010      ; Load X with binary %1010

    sta $80         ; Store the value in the A register into Memory Address $80
    stx $81         ; Store the value in the X register into Memory Address $81

    lda #10         ; Load decimal #10 into A register

    clc             ; Clear CARRY flag before add operation
    adc $80         ; Add to A the value inside RAM Address $80
    adc $81         ; Add to A the value inside RAM Address $81
                    ; A now has (#10 + $A + %1010) = #30 or $1E

    sta $82         ; Store the value from A into RAM $82

    jmp Start


    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)
