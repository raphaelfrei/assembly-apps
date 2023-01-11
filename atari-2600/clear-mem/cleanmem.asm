;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                    Raphael Frei - 2023                    ;
;                First Assembly Code for 6502               ;
;          Clear Processor' Memory - From 00 to FF          ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    processor 6502  ; Define the target processor

    seg code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

Start:
    sei             ; Disable interruptions - All Atari's 2600 games begins this way
    cld             ; Disable o BCD Decimal Math Mode
    ldx #$FF        ; Loads the X Register with #$FF
    txs             ; Transfer the X Register to (S)tack Pointer - Last RAM space

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;        Clear the Page Zero section ($00 until $FF)        ;
;              The entire RAM and TIA Register              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #0          ; A = 0
    ldx #$FF        ; X = #$FF

MemoryLoop:
    sta $0,X        ; Store the value of A inside Memory Address $0 + X
    dex             ; X--
    bne MemoryLoop  ; Branch if X != 0 (Z-Flag is set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;              Fill the ROM size to exactly 4KB              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The cartridge (and every 6502 code) requires this at the last 4 bytes

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)