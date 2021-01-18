
_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;OUTCHR_UART2.c,3 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;OUTCHR_UART2.c,4 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;OUTCHR_UART2.c,5 :: 		}
L_end_Tx_serial2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial2

_INIT_UART2:

;OUTCHR_UART2.c,7 :: 		void INIT_UART2(unsigned char valor_baud){
;OUTCHR_UART2.c,8 :: 		U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;OUTCHR_UART2.c,9 :: 		U2MODE = 0x0000; //ver tabela para saber as outras configurações
	CLR	U2MODE
;OUTCHR_UART2.c,10 :: 		U2STA = 0x0000;
	CLR	U2STA
;OUTCHR_UART2.c,11 :: 		IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;OUTCHR_UART2.c,12 :: 		IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;OUTCHR_UART2.c,13 :: 		IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;OUTCHR_UART2.c,14 :: 		IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;OUTCHR_UART2.c,15 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;OUTCHR_UART2.c,16 :: 		U2STAbits.UTXEN = 1;   //Começa a comunicação
	BSET	U2STAbits, #10
;OUTCHR_UART2.c,17 :: 		}
L_end_INIT_UART2:
	RETURN
; end of _INIT_UART2

_OUTCHR_UART2:

;OUTCHR_UART2.c,20 :: 		void OUTCHR_UART2(unsigned char c){
;OUTCHR_UART2.c,21 :: 		while( U2STAbits.UTXBF);
L_OUTCHR_UART20:
	BTSS	U2STAbits, #9
	GOTO	L_OUTCHR_UART21
	GOTO	L_OUTCHR_UART20
L_OUTCHR_UART21:
;OUTCHR_UART2.c,22 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;OUTCHR_UART2.c,23 :: 		}
L_end_OUTCHR_UART2:
	RETURN
; end of _OUTCHR_UART2

_INCHR_UART2:

;OUTCHR_UART2.c,26 :: 		unsigned char INCHR_UART2(){
;OUTCHR_UART2.c,28 :: 		while(!U2STAbits.URXDA);
L_INCHR_UART22:
	BTSC	U2STAbits, #0
	GOTO	L_INCHR_UART23
	GOTO	L_INCHR_UART22
L_INCHR_UART23:
;OUTCHR_UART2.c,29 :: 		c = U2RXREG; // escreve caractere
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;OUTCHR_UART2.c,30 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;OUTCHR_UART2.c,31 :: 		}
L_end_INCHR_UART2:
	RETURN
; end of _INCHR_UART2

_echo:

;OUTCHR_UART2.c,33 :: 		void echo(unsigned char c){
;OUTCHR_UART2.c,34 :: 		while (U2STAbits.UTXBF){
L_echo4:
	BTSS	U2STAbits, #9
	GOTO	L_echo5
;OUTCHR_UART2.c,35 :: 		U2TXREG = INCHR_UART2(); // escreve caractere
	CALL	_INCHR_UART2
	ZE	W0, W0
	MOV	WREG, U2TXREG
;OUTCHR_UART2.c,36 :: 		}
	GOTO	L_echo4
L_echo5:
;OUTCHR_UART2.c,37 :: 		}
L_end_echo:
	RETURN
; end of _echo

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;OUTCHR_UART2.c,42 :: 		void main(){
;OUTCHR_UART2.c,43 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;OUTCHR_UART2.c,44 :: 		TRISB = 0x0000;
	CLR	TRISB
;OUTCHR_UART2.c,46 :: 		INIT_UART2(103);
	MOV.B	#103, W10
	CALL	_INIT_UART2
;OUTCHR_UART2.c,47 :: 		OUTCHR_UART2(0x030);
	MOV.B	#48, W10
	CALL	_OUTCHR_UART2
;OUTCHR_UART2.c,48 :: 		while(1){
L_main6:
;OUTCHR_UART2.c,49 :: 		m = INCHR_UART2();
	CALL	_INCHR_UART2
	MOV	#lo_addr(_m), W1
	MOV.B	W0, [W1]
;OUTCHR_UART2.c,50 :: 		echo(m);
	MOV.B	W0, W10
	CALL	_echo
;OUTCHR_UART2.c,51 :: 		LATB = m;
	MOV	#lo_addr(_m), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;OUTCHR_UART2.c,52 :: 		};
	GOTO	L_main6
;OUTCHR_UART2.c,54 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
