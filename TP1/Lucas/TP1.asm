
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
 
 BANKSEL PORTC
 CLRF PORTC
 BANKSEL TRISC
 MOVLW B'00000000'
 MOVWF TRISC
 
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
  MOVF PORTB,0
 
  ;Identifica correctamente los 2 numeros:
  CLRF AX ;Setea todos los bits en cero
  CLRF BX ;Setea todos los bits en cero
  ;MOVLW B'11100001' ;Setea el valor en W
  MOVWF BX ;Mueve el valor de W a B
  ANDLW 0X0F ;Realiza un AND logico de k con W
  MOVWF AX ;Mueve el resultado a AX
  MOVF BX,0 ; Mueve el valor de BX a W
  ANDLW 0XF0 ; Realiza un AND logico de k con W
  MOVWF BX ;Mueve el valor de W a BX
  SWAPF BX,1 ;Swapea los bits 7a4 con los de 3a0 y los guarda en BX
  
  ;Realiza la suma:
  MOVF AX,0 ;Mueve el valor de AX a W
  ADDWF BX,1 ;Suma el valor que contiene W con el de BX y lo guarda en BX
  BTFSC BX,4 ;Se fija si el bit de la posicion 4 es 1 o 0 (osea si hay carry o no), si es 1 la siguiente instruccion se ejecuta
  GOTO LEDON ;Va a TITILO
  MOVF BX,0 ;Como no se ejecuto la anterior, mueve el valor de BX a W
  MOVWF PORTC ;Mueve el valor de W a PORTA
  GOTO INICIO ;Vuelve a INICIO

LEDON ;Como hay carry tiene que titilar otro LED
  BSF PORTC,4 ;Setea en 1 el bit de la posicion 4 de PORTA
LAZO  
  MOVLW 0X08 ;Mueve 00000110 (6) a W
  MOVWF CONT3 ;Mueve el valor de W a CONT3
LAZO3
  MOVLW 0XFF ;Mueve 11011001 (217) a W
  MOVWF CONT2 ; Mueve el valor de W a CONT2
LAZO2
  MOVLW 0XFF ;Mueve 11111111 (255) a W
  MOVWF CONT1 ;Mueve el valor de W a CONT1
LAZO1
  DECFSZ CONT1,1 ;Se decrementa el valor de CONT1 y se guarda en CONT1. Si el resultado es 0 Sale y un NOP es ejecutado
  GOTO LAZO1 ;Ciclo de 64 clocks
  DECFSZ CONT2,1 ;Se decrementa el valor de CONT2 y se guarda en CONT2, hasta que sea 0
  GOTO LAZO2 ;Ciclo de -- clocks
  DECFSZ CONT3,1 ;Se decrementa el valor de CONT3 y se guarda en CONT3, hasta que el resultado sea 0, cuando esto ocurra salta la prox instruccion
  GOTO LAZO3 ;Ciclo de 7 clocks

LEDOFF ;Como hay carry tiene que titilar otro LED
  BCF PORTC,4 ;Setea en 1 el bit de la posicion 4 de PORTA
LAZOF  
  MOVLW 0X08 ;Mueve 00000110 (6) a W
  MOVWF CONT3 ;Mueve el valor de W a CONT3
LAZOF3
  MOVLW 0XFF ;Mueve 11011001 (217) a W
  MOVWF CONT2 ; Mueve el valor de W a CONT2
LAZOF2
  MOVLW 0XFF ;Mueve 11111111 (255) a W
  MOVWF CONT1 ;Mueve el valor de W a CONT1
LAZOF1
  DECFSZ CONT1,1 ;Se decrementa el valor de CONT1 y se guarda en CONT1. Si el resultado es 0 Sale y un NOP es ejecutado
  GOTO LAZOF1 ;Ciclo de 64 clocks
  DECFSZ CONT2,1 ;Se decrementa el valor de CONT2 y se guarda en CONT2, hasta que sea 0
  GOTO LAZOF2 ;Ciclo de -- clocks
  DECFSZ CONT3,1 ;Se decrementa el valor de CONT3 y se guarda en CONT3, hasta que el resultado sea 0, cuando esto ocurra salta la prox instruccion
  GOTO LAZOF3 ;Ciclo de 7 clocks
  
  ;BTFSS PORTA,4   ;SALTO SI ESTA PRENDIDO - Si el bit 4 es cero se ejecuta sino salta
  ;BSF PORTA,4 ;Setea un 1 en bit 4
  
  ;BTFSC PORTA,4   ;SALTO SI ESTA APAGADO - Si el bit 4 es uno se ejecuta sino salta
  ;BCF PORTA,4 ;Setea un 0 en bit 4
  
  GOTO LEDON ;Vuelve a LAZO
 
  GOTO $
  END

