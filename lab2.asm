include <P18F452.INC>
ORG 00H

START


BCF TRISB,1;Led 1 for even check
BCF TRISB,2;Led 2 for < 10 check
CLRF TRISD;Count led

BCF PORTB,1;just to make sure its cleared after every run
BCF PORTB,2
CLRF 06H
CLRF 05H

MOVLW 0AH;COMPARE WITH 10
MOVWF 03H

;making two copies of input
MOVFF PORTC,01H; to be used in last loop
MOVFF PORTC,00H; to be used in zeros/ones check

BCF STATUS,C;we will rotate so make it zero initially

BTFSS PORTB,0;Switch at RB0
BRA ZEROS;switch off
BRA ONES;switch on


ONES

MOVLW D'8' ;Placed a counter to count rotations
MOVWF 05H

LOOP1

RRCF 00H,F
BTFSC STATUS,C
INCF 06H;NUMBER OF ONES
DECF 05H;COUNT 8

BNZ LOOP1

MOVFF 06H,PORTD

BRA EN

ZEROS


MOVLW D'8'
MOVWF 05H


LOOP2

RRCF 00H,F
BTFSS STATUS,C
INCF 06H;NUMBER OF ZEROS
DECF 05H;COUNT 8
BNZ LOOP2

MOVFF 06H,PORTD

BRA EN



EN
;To check if the number or the condition is changed
MOVF PORTC,W
CPFSEQ 01H
BRA START
;for led <10 check
BTFSC PORTC,0;check if inputs 1st bit is zero
BRA LESSCHECK;if not dont turn on led
CPFSEQ 02H;if yes check if whole input = 0
BSF PORTB,1;if not turn led even on as 0 is not even nor odd

LESSCHECK
MOVF 03H,W;Moving 10 or A in hex to working so to compare
CPFSLT PORTC
BRA EN
BSF PORTB,2;Turn on <10 led
BRA EN


END


;Fa16-epe-035
;Fa16-epe-007
;Fa16-epe-005
;Fa16-epe-018
;Group 1