
_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,18 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;Q1.c,20 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;Q1.c,21 :: 		}
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

;Q1.c,24 :: 		void init_uart2(unsigned char baud_rate){
;Q1.c,25 :: 		U2BRG = baud_rate;
	ZE	W10, W0
	MOV	WREG, U2BRG
;Q1.c,26 :: 		U2MODE = 0;
	CLR	U2MODE
;Q1.c,27 :: 		U2STA = 0;
	CLR	U2STA
;Q1.c,28 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;Q1.c,29 :: 		IEC1bits.U2TXIE = 0;
	BCLR	IEC1bits, #9
;Q1.c,30 :: 		IFS1BITS.U2RXIF = 0;
	BCLR	IFS1bits, #8
;Q1.c,31 :: 		IEC1bits.U2RXIE = 0;
	BCLR	IEC1bits, #8
;Q1.c,32 :: 		U2MODEbits.UARTEN = 1;
	BSET	U2MODEbits, #15
;Q1.c,33 :: 		U2STAbits.UTXEN = 1;
	BSET	U2STAbits, #10
;Q1.c,34 :: 		}
L_end_init_uart2:
	RETURN
; end of _init_uart2

_enviar_char:

;Q1.c,55 :: 		void enviar_char(unsigned char c){
;Q1.c,56 :: 		while(U2STAbits.UTXBF);
L_enviar_char0:
	BTSS	U2STAbits, #9
	GOTO	L_enviar_char1
	GOTO	L_enviar_char0
L_enviar_char1:
;Q1.c,57 :: 		U2TXREG = c;
	ZE	W10, W0
	MOV	WREG, U2TXREG
;Q1.c,58 :: 		}
L_end_enviar_char:
	RETURN
; end of _enviar_char

_enviar_string:

;Q1.c,61 :: 		void enviar_string(unsigned char *s){
;Q1.c,62 :: 		cont_str = 0;
	CLR	W0
	MOV	W0, _cont_str
;Q1.c,63 :: 		while(s[cont_str]){
L_enviar_string2:
	MOV	#lo_addr(_cont_str), W0
	ADD	W10, [W0], W0
	CP0.B	[W0]
	BRA NZ	L__enviar_string24
	GOTO	L_enviar_string3
L__enviar_string24:
;Q1.c,64 :: 		enviar_char(s[cont_str++]);
	MOV	#lo_addr(_cont_str), W0
	ADD	W10, [W0], W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_enviar_char
	POP	W10
	MOV	#1, W1
	MOV	#lo_addr(_cont_str), W0
	ADD	W1, [W0], [W0]
;Q1.c,65 :: 		}
	GOTO	L_enviar_string2
L_enviar_string3:
;Q1.c,66 :: 		}
L_end_enviar_string:
	RETURN
; end of _enviar_string

_receber_char:

;Q1.c,69 :: 		unsigned char receber_char(){
;Q1.c,71 :: 		while(!U2STAbits.URXDA);
L_receber_char4:
	BTSC	U2STAbits, #0
	GOTO	L_receber_char5
	GOTO	L_receber_char4
L_receber_char5:
;Q1.c,72 :: 		c = U2RXREG;
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;Q1.c,73 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;Q1.c,74 :: 		}
L_end_receber_char:
	RETURN
; end of _receber_char

_receber_string:

;Q1.c,81 :: 		void receber_string(char *rec, short int max){
;Q1.c,82 :: 		cont_rec_str = 0;
	CLR	W0
	MOV	W0, _cont_rec_str
;Q1.c,83 :: 		tmp = 1;
	MOV	#lo_addr(_tmp), W1
	MOV.B	#1, W0
	MOV.B	W0, [W1]
;Q1.c,84 :: 		for(cont_rec_str = 0; ((cont_rec_str < max) && ((tmp != end_line))); cont_rec_str++){
	CLR	W0
	MOV	W0, _cont_rec_str
L_receber_string6:
	SE	W11, W1
	MOV	#lo_addr(_cont_rec_str), W0
	CP	W1, [W0]
	BRA GT	L__receber_string27
	GOTO	L__receber_string19
L__receber_string27:
	MOV	#lo_addr(_tmp), W0
	MOV.B	[W0], W1
	MOV	#lo_addr(_end_line), W0
	CP.B	W1, [W0]
	BRA NZ	L__receber_string28
	GOTO	L__receber_string18
L__receber_string28:
L__receber_string17:
;Q1.c,85 :: 		tmp = receber_char();
	CALL	_receber_char
	MOV	#lo_addr(_tmp), W1
	MOV.B	W0, [W1]
;Q1.c,86 :: 		rec[cont_rec_str] = tmp;
	MOV	#lo_addr(_cont_rec_str), W1
	ADD	W10, [W1], W1
	MOV.B	W0, [W1]
;Q1.c,84 :: 		for(cont_rec_str = 0; ((cont_rec_str < max) && ((tmp != end_line))); cont_rec_str++){
	MOV	#1, W1
	MOV	#lo_addr(_cont_rec_str), W0
	ADD	W1, [W0], [W0]
;Q1.c,87 :: 		}
	GOTO	L_receber_string6
;Q1.c,84 :: 		for(cont_rec_str = 0; ((cont_rec_str < max) && ((tmp != end_line))); cont_rec_str++){
L__receber_string19:
L__receber_string18:
;Q1.c,90 :: 		}
L_end_receber_string:
	RETURN
; end of _receber_string

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Q1.c,114 :: 		void main(){
;Q1.c,115 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q1.c,116 :: 		TRISB = 0;
	CLR	TRISB
;Q1.c,117 :: 		LATB = 0;
	CLR	LATB
;Q1.c,118 :: 		init_uart2(103);
	MOV.B	#103, W10
	CALL	_init_uart2
;Q1.c,121 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;Q1.c,122 :: 		IFS0 = 0;
	CLR	IFS0
;Q1.c,123 :: 		PR1 = 625;
	MOV	#625, W0
	MOV	WREG, PR1
;Q1.c,124 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;Q1.c,125 :: 		valor = 0;
	CLR	W0
	MOV	W0, _valor
;Q1.c,126 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;Q1.c,127 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q1.c,128 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;Q1.c,130 :: 		IntToStr(strlen(mC4), txt);
	MOV	#lo_addr(_mC4), W10
	CALL	_strlen
	MOV	#lo_addr(_txt), W11
	MOV	W0, W10
	CALL	_IntToStr
;Q1.c,134 :: 		Lcd_Out(1,1, mC1);
	MOV	#lo_addr(_mC1), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q1.c,135 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main11:
	DEC	W7
	BRA NZ	L_main11
	DEC	W8
	BRA NZ	L_main11
	NOP
;Q1.c,138 :: 		while(1){
L_main13:
;Q1.c,140 :: 		if(strcmp(tmp, pC4) == 0){
	MOV	#lo_addr(_tmp), W0
	MOV	#lo_addr(_pC4), W11
	ZE	[W0], W10
	CALL	_strcmp
	CP	W0, #0
	BRA Z	L__main30
	GOTO	L_main15
L__main30:
;Q1.c,141 :: 		IntToStr(txt, strcmp(tmp, pC4));
	MOV	#lo_addr(_tmp), W0
	MOV	#lo_addr(_pC4), W11
	ZE	[W0], W10
	CALL	_strcmp
	MOV	W0, W11
	MOV	#lo_addr(_txt), W10
	CALL	_IntToStr
;Q1.c,142 :: 		enviar_string(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_enviar_string
;Q1.c,143 :: 		}else{
	GOTO	L_main16
L_main15:
;Q1.c,144 :: 		tmp = receber_char();
	CALL	_receber_char
	MOV	#lo_addr(_tmp), W1
	MOV.B	W0, [W1]
;Q1.c,145 :: 		}
L_main16:
;Q1.c,149 :: 		}
	GOTO	L_main13
;Q1.c,150 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
