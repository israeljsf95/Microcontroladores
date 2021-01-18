
_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;send_string.c,2 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;send_string.c,4 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;send_string.c,5 :: 		}
L_end_Tx_serial2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial2

_init_uart2:

;send_string.c,8 :: 		void init_uart2(unsigned char baud_rate){
;send_string.c,9 :: 		U2BRG = baud_rate;
	ZE	W10, W0
	MOV	WREG, U2BRG
;send_string.c,10 :: 		U2MODE = 0;
	CLR	U2MODE
;send_string.c,11 :: 		U2STA = 0;
	CLR	U2STA
;send_string.c,12 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;send_string.c,13 :: 		IEC1bits.U2TXIE = 0;
	BCLR	IEC1bits, #9
;send_string.c,14 :: 		IFS1BITS.U2RXIF = 0;
	BCLR	IFS1bits, #8
;send_string.c,15 :: 		IEC1bits.U2RXIE = 0;
	BCLR	IEC1bits, #8
;send_string.c,16 :: 		U2MODEbits.UARTEN = 1;
	BSET	U2MODEbits, #15
;send_string.c,17 :: 		U2STAbits.UTXEN = 1;
	BSET	U2STAbits, #10
;send_string.c,18 :: 		}
L_end_init_uart2:
	RETURN
; end of _init_uart2

_timer:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;send_string.c,23 :: 		void timer() iv IVT_ADDR_T1INTERRUPT {
;send_string.c,24 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;send_string.c,26 :: 		if (cont == valor+1){
	MOV	_valor, W0
	ADD	W0, #1, W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA Z	L__timer15
	GOTO	L_timer0
L__timer15:
;send_string.c,27 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;send_string.c,28 :: 		}
L_timer0:
;send_string.c,29 :: 		if (cont == 99){
	MOV	#99, W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA Z	L__timer16
	GOTO	L_timer1
L__timer16:
;send_string.c,30 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;send_string.c,31 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;send_string.c,32 :: 		}
L_timer1:
;send_string.c,34 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;send_string.c,35 :: 		}
L_end_timer:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _timer

_enviar_char:

;send_string.c,37 :: 		void enviar_char(unsigned char c){
;send_string.c,38 :: 		while(U2STAbits.UTXBF);
L_enviar_char2:
	BTSS	U2STAbits, #9
	GOTO	L_enviar_char3
	GOTO	L_enviar_char2
L_enviar_char3:
;send_string.c,39 :: 		U2TXREG = c;
	ZE	W10, W0
	MOV	WREG, U2TXREG
;send_string.c,40 :: 		}
L_end_enviar_char:
	RETURN
; end of _enviar_char

_receber_char:

;send_string.c,42 :: 		unsigned char receber_char(){
;send_string.c,44 :: 		while(!U2STAbits.URXDA);
L_receber_char4:
	BTSC	U2STAbits, #0
	GOTO	L_receber_char5
	GOTO	L_receber_char4
L_receber_char5:
;send_string.c,45 :: 		c = U2RXREG;
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;send_string.c,46 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;send_string.c,47 :: 		}
L_end_receber_char:
	RETURN
; end of _receber_char

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;send_string.c,53 :: 		void main(){
;send_string.c,54 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;send_string.c,55 :: 		TRISB = 0;
	CLR	TRISB
;send_string.c,56 :: 		LATB = 0;
	CLR	LATB
;send_string.c,57 :: 		init_uart2(103);
	MOV.B	#103, W10
	CALL	_init_uart2
;send_string.c,58 :: 		enviar_char(0x30);
	MOV.B	#48, W10
	CALL	_enviar_char
;send_string.c,60 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;send_string.c,61 :: 		IFS0 = 0;
	CLR	IFS0
;send_string.c,62 :: 		PR1 = 625;
	MOV	#625, W0
	MOV	WREG, PR1
;send_string.c,63 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;send_string.c,64 :: 		valor = 0;
	CLR	W0
	MOV	W0, _valor
;send_string.c,65 :: 		while(1){
L_main6:
;send_string.c,66 :: 		m = receber_char();
	CALL	_receber_char
	MOV	#lo_addr(_m), W1
	MOV.B	W0, [W1]
;send_string.c,68 :: 		if (m == 'a'){
	MOV.B	#97, W1
	CP.B	W0, W1
	BRA Z	L__main20
	GOTO	L_main8
L__main20:
;send_string.c,69 :: 		valor = valor + 20;
	MOV	#20, W1
	MOV	#lo_addr(_valor), W0
	ADD	W1, [W0], [W0]
;send_string.c,70 :: 		}
L_main8:
;send_string.c,71 :: 		if (m == 'd'){
	MOV	#lo_addr(_m), W0
	MOV.B	[W0], W1
	MOV.B	#100, W0
	CP.B	W1, W0
	BRA Z	L__main21
	GOTO	L_main9
L__main21:
;send_string.c,72 :: 		valor = valor - 20;
	MOV	#20, W1
	MOV	#lo_addr(_valor), W0
	SUBR	W1, [W0], [W0]
;send_string.c,73 :: 		}
L_main9:
;send_string.c,74 :: 		if (valor <= 1){
	MOV	_valor, W0
	CP	W0, #1
	BRA LE	L__main22
	GOTO	L_main10
L__main22:
;send_string.c,75 :: 		valor = 0;
	CLR	W0
	MOV	W0, _valor
;send_string.c,76 :: 		}
L_main10:
;send_string.c,77 :: 		if (valor >= 99){
	MOV	#99, W1
	MOV	#lo_addr(_valor), W0
	CP	W1, [W0]
	BRA LE	L__main23
	GOTO	L_main11
L__main23:
;send_string.c,78 :: 		valor = 100;
	MOV	#100, W0
	MOV	W0, _valor
;send_string.c,79 :: 		}
L_main11:
;send_string.c,88 :: 		}
	GOTO	L_main6
;send_string.c,89 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
