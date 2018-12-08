
LIST P=PIC18F452, F=INHX32, N=0, ST=OFF, R=HEX
config OSC=HS, OSCS=OFF, WDT=OFF, BORV=45, PWRT=ON, BOR=ON, DEBUG=OFF, LVP=OFF, STVR=OFF

#INCLUDE<P18F452.INC>
ORG 00H 

GOTO MAIN

ORG 08H

BTFSS INTCON,TMR0IF ; Timer0 interrupt ?
RETFIE
GOTO ISR

MAIN
ORG 200H
 
CLRF TRISD



MOVLW 0x68
MOVWF T0CON

MOVLW 0xFA
MOVWF TMR0L

MOVLW D'5';FOR COUNTER TO EXIT AFTET 5 PRESSES
MOVWF 06H

BCF INTCON,TMR0IF
BSF T0CON,7

BSF INTCON,TMR0IE
BSF INTCON,GIE

TOP 
MOVFF TMR0L,09H  ;TO COMPARE AND CHECK IF BUTTON IS PRESSED
TSTFSZ 06H ;TEST IF COUNTER IS ZERO
BRA LED ; IF NOT BLINK LED NUMBER OF TIMES BUTTON PRESSED
LP BRA LP

LED
MOVF 09H,W ;TO MAKE SURE COUNTER2 IS INCREMENTED AFTER BUTTON PRESS
STUCK2 CPFSEQ TMR0L
BRA LED2
BRA STUCK2
LED2
INCF 07H;COUNTER2
MOVFF 07H,PORTD
DECF 06H

BRA TOP




ISR
ORG 400H
SETF PORTD
BCF INTCON,TMR0IF

RETFIE

end