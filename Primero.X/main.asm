#include "p10f200.inc"
; CONFIG
    __CONFIG _WDT_OFF & _CP_OFF & _MCLRE_OFF
    ORG 0x0000
INIT ; We are initializing the microcontroller over the next three lines
    MOVLW ~(1 << GP1) ; these two lines set GP1 as an output
    TRIS GPIO
    BSF GPIO, GP1 ; this line is where we set GP1 output high to light the LED
 LOOP
    GOTO LOOP	; loop forever
 END	; needed to end the program


