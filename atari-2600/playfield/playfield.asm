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

    ldx #$80        ; Load BLUE COLOR into X
    stx COLUBK      ; Store the X value into background

    lda #$1C        ; Load YELLOW COLOR into X
    sta COLUPF      ; Store the X value into playfield

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Starting a new frame using VBLANK and VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
STARTFRAME:
    lda #2          ; Load 2 into A
    sta VBLANK      ; Turn VBLANK on
    sta VSYNC       ; Turn VSYNC on

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate VSYNC 3 lines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    REPEAT 3          ; Repeat the next instruction 3 times
        sta WSYNC   ; Hit WSYNC to wait next scanline
    REPEND

    lda #0          ; Load 0 into A
    sta VSYNC       ; Turn VSYNC off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate 37 lines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    REPEAT #37         ; Repeat the next instruction 37 times
        sta WSYNC   ; Hit WSYNC to wait next scanline
    REPEND

    lda #0
    sta VBLANK      ; Turn VBLANK off

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set CTRLPF register to reflect playfield
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #%00000001  ; Reflect
    sta CTRLPF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 192 lines into VISIBLE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Skip 7 lines with no PF
    ldx #%00000000  ; Set the PF0 into 0000 (LSB First) and PF-1 PF-2 as 0000 0000
    stx PF0
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC   ; Hit WSYNC to wait next scanline
    REPEND

    ; Set the PF0 into 1110 (LSB First) and PF-1 PF-2 as 1111 1111

    ldx #%11100000
    stx PF0

    ldx #%11111111
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND

    ; Set the next 164 lines only with PF-0 third bit enabled

    ldx #%00100000
    stx PF0

    ldx #%00000000  ; Set the PF-1 PF-2 as 0000 0000
    stx PF1
    stx PF2

    REPEAT 164
        sta WSYNC
    REPEND

    ; Set the PF-0 to 1110 and PF-1 PF-2 to 1111 1111

    ldx #%11100000
    stx PF0

    ldx #%11111111  ; Set the PF-1 PF-2 as 0000 0000
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND

    ; Skip next 7 lines with no PF set

    ldx #%00000000  ; Set the PF-1 PF-2 as 0000 0000
    stx PF0
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Draw 30 lines into OVERSCAN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #2          
    sta VBLANK      ; Turn VBLANK back on

    REPEAT 30         ; Repeat the next instruction 30 times
        sta WSYNC   ; Hit WSYNC to wait next scanline
    REPEND

    lda #0
    sta VBLANK      ; Turn VBLANK off

    jmp STARTFRAME

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              Fill the ROM size to exactly 4KB              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; The cartridge (and every 6502 code) requires this at the last 4 bytes

    org $FFFC       ; The bottom of the ROM
    .word START     ; Reset vector at $FFFC (Where the program starts)
    .word START     ; Interrupt vector at $FFFE (Unused in VCS)