;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                 Raphael Frei - 2023                       ;
;               Designed for Atari 2600                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

processor 6502  ; Define the target processor

    seg code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;              Fill the ROM size to exactly 4KB              ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The cartridge (and every 6502 code) requires this at the last 4 bytes

    org $FFFC       ; The bottom of the ROM
    .word Start     ; Reset vector at $FFFC (Where the program starts)
    .word Start     ; Interrupt vector at $FFFE (Unused in VCS)