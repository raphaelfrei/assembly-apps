;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 Raphael Frei - 2023                       ;;
;;               Designed for Atari 2600                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    processor 6502  ; Define the target processor

    include "vcs.h"
    include "macro.h"

    seg Code        ; Segment
    org $F000       ; Define code origin in $F000 (First ROM space)

START:
    CLEAN_START     ; Clear memory and TIA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Starting a new frame using VBLANK and VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NEXTFRAME:
    lda #2          ; Load 2 into A
    sta VBLANK      ; Turn VBLANK on
    sta VSYNC       ; Turn VSYNC on

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate VSYNC 3 lines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    sta WSYNC       ; First line
    sta WSYNC       ; Second line
    sta WSYNC       ; Third line

    lda #0
    sta VSYNC       ; Turn VSYNC off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate 37 lines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldx #37         ; Loads 37 into X

LOOPVBLANK:

    sta WSYNC       ; Hit WSYNC to wait next scanline
    dex             ; Decrement X
    bne LOOPVBLANK  ; Loop until X == 0

    lda #0
    sta VBLANK      ; Turn VBLANK off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 192 visible lines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldx #192        ; Counter for the 192 lines

LOOPVISIBLE:

    stx COLUBK      ; Store the X value into background
    sta WSYNC       ; Wait for the next scanline
    dex             ; Decrement X
    bne LOOPVISIBLE ; Loop until X == 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 30 lines into OVERSCAN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #2          
    sta VBLANK      ; Turn VBLANK back on

    ldx #30         ; Counter for the 30 lines

LOOPOVERSC:

    sta WSYNC       ; Wait for the next scanline
    dex             ; Decrement X
    bne LOOPOVERSC  ; Loop until X == 0

    jmp NEXTFRAME

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              Fill the ROM size to exactly 4KB              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The cartridge (and every 6502 code) requires this at the last 4 bytes

    org $FFFC       ; The bottom of the ROM
    .word START     ; Reset vector at $FFFC (Where the program starts)
    .word START     ; Interrupt vector at $FFFE (Unused in VCS)