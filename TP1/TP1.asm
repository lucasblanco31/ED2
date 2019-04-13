
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0xFFF7
 __CONFIG _CONFIG1, _FOSC_EXTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 
 
 ORG 0x00
 goto 0x05
 ORG 0X05
 
 BANKSEL PORTA
 CLRF PORTA
 BANKSEL TRISA
 MOVLW B'00000000'
 MOVWF TRISA
 
 BANKSEL PORTB
 CLRF PORTB
 BANKSEL TRISB
 MOVLW B'11111111'
 MOVWF TRISB
 
AX EQU 0x20
BX EQU 0X21
CBLOCK 0X22
 CONT1
 CONT2
 CONT3
 ENDC
INICIO
  BANKSEL PIR1
 ; MOVF PORTB
  CLRF AX
  CLRF BX
  MOVLW B'11100001'
  MOVWF BX
  ANDLW 0X0F
  MOVWF AX
  MOVF BX,0
  ANDLW 0XF0
  MOVWF BX
  SWAPF BX,1
  MOVF AX,0
  ADDWF BX,1
  BTFSC BX,4
  GOTO TITILO
  MOVF BX,0
  MOVWF PORTA
  GOTO INICIO
TITILO
  BSF PORTA,4
LAZO  
  MOVLW 0X06
  MOVWF CONT3
LAZO3
  MOVLW 0XD7
  MOVWF CONT2
LAZO2
  MOVLW 0XFF
  MOVWF CONT1
LAZO1
  DECFSZ CONT1,1
  GOTO LAZO1
  DECFSZ CONT2,1
  GOTO LAZO2
  DECFSZ CONT3,1
  GOTO LAZO3
  
  BTFSS PORTA,4   ;SALTO SI ESTA PRENDIDO
  BSF PORTA,4
  
  BTFSC PORTA,4   ;SALTO SI ESTA APAGADO
  BCF PORTA,4
  
  GOTO LAZO
 
  GOTO $
  END

