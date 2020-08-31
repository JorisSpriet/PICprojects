#include "p10f200.inc"
 ; CONFIG
    __CONFIG _WDT_OFF & _CP_OFF & _MCLRE_OFF
    ORG 0x0000
 INIT
    MOVLW ~(1 << T0CS)	;enable GPIO2 by clearing as input for timer/counter T0
    OPTION		;copies W register to OPTION register
    MOVLW ~(1 << GP2)	;set GP2 as output
    TRIS GPIO
 LOOP
    BSF GPIO, GP2
    CALL DELAY
    BCF	GPIO, GP2
    CALL DELAY
    GOTO LOOP
    
  DELAY
    MOVLW D'162'	;load initial value into Working register
    MOVWF 10		;copy to register 0x10
    MOVWF 11		;copy to 0x11
  DELAY_LOOP
    DECFSZ  10,F	;decrement 0x10, check if zero
    GOTO DELAY_LOOP	;if not zero, loop
    DECFSZ  11,F	;decrement 0x11, check if zero
    GOTO DELAY_LOOP	;if not zero, loop
    RETLW 0		;returnm set W to 0
    
    ;calculation : 4Mhz, 1 instr per clock
    ;162 * 255 = 41472 loops (approx)
    ;	DECFSZ  :  1 cycle = 4 clock ticks = 1e-6 seconds
    ;	GOTO	:  2 cycles = 12 cclock ticks
    ; 41472 * 3 *  1e-6 ~ 0.125s time on/off => period ~0.250s = 4Hz
 
    END
    
    
