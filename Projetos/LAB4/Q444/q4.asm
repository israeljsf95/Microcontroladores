
_Init_UART2:

;q4.c,9 :: 		void Init_UART2(unsigned char valor_baud){
;q4.c,10 :: 		U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;q4.c,11 :: 		U2MODE = 0x0000; //ver tabela para saber as outras configura??es
	CLR	U2MODE
;q4.c,12 :: 		U2STA = 0x0000;
	CLR	U2STA
;q4.c,13 :: 		IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;q4.c,14 :: 		IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;q4.c,15 :: 		IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;q4.c,16 :: 		IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;q4.c,17 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;q4.c,18 :: 		U2STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U2STAbits, #10
;q4.c,19 :: 		}
L_end_Init_UART2:
	RETURN
; end of _Init_UART2

_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q4.c,22 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;q4.c,23 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;q4.c,24 :: 		}
L_end_Tx_serial2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial2

_send_char:

;q4.c,27 :: 		void send_char(unsigned char c){
;q4.c,28 :: 		while( U2STAbits.UTXBF);
L_send_char0:
	BTSS	U2STAbits, #9
	GOTO	L_send_char1
	GOTO	L_send_char0
L_send_char1:
;q4.c,29 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;q4.c,30 :: 		}
L_end_send_char:
	RETURN
; end of _send_char

_send_str:

;q4.c,33 :: 		void send_str(unsigned char* str){
;q4.c,34 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;q4.c,35 :: 		while(str[i])
L_send_str2:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str33
	GOTO	L_send_str3
L__send_str33:
;q4.c,36 :: 		send_char(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str2
L_send_str3:
;q4.c,37 :: 		}
L_end_send_str:
	RETURN
; end of _send_str

_conversaoAD:

;q4.c,40 :: 		void conversaoAD(){
;q4.c,42 :: 		ADCHSbits.CH0SA = 0b0010;
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;q4.c,43 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,44 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;q4.c,45 :: 		ADC16Ptr = &ADCBUF0;
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;q4.c,46 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;q4.c,47 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;q4.c,48 :: 		while (!IFS0bits.ADIF);
L_conversaoAD4:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD5
	GOTO	L_conversaoAD4
L_conversaoAD5:
;q4.c,49 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;q4.c,51 :: 		for (count = 0; count < 16; count++)
	CLR	W0
	MOV	W0, _count
L_conversaoAD6:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversaoAD35
	GOTO	L_conversaoAD7
L__conversaoAD35:
;q4.c,52 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;q4.c,51 :: 		for (count = 0; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;q4.c,52 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD6
L_conversaoAD7:
;q4.c,53 :: 		soma = soma >> 4;
	MOV	_soma, W0
	LSR	W0, #4, W0
	MOV	W0, _soma
;q4.c,54 :: 		conv = (float)(soma);
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,56 :: 		LDR  = conv*(4.5)/1023;
	MOV	#0, W2
	MOV	#16528, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _LDR
	MOV	W1, _LDR+2
;q4.c,58 :: 		ADCHSbits.CH0SA = 0b0101;
	MOV.B	#5, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;q4.c,59 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,60 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;q4.c,61 :: 		ADC16Ptr = &ADCBUF0;
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;q4.c,62 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;q4.c,63 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;q4.c,64 :: 		while (!IFS0bits.ADIF);
L_conversaoAD9:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD10
	GOTO	L_conversaoAD9
L_conversaoAD10:
;q4.c,65 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;q4.c,67 :: 		for (count = 0; count < 16; count++)
	CLR	W0
	MOV	W0, _count
L_conversaoAD11:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversaoAD36
	GOTO	L_conversaoAD12
L__conversaoAD36:
;q4.c,68 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;q4.c,67 :: 		for (count = 0; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;q4.c,68 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD11
L_conversaoAD12:
;q4.c,69 :: 		soma = soma >> 4;
	MOV	_soma, W0
	LSR	W0, #4, W0
	MOV	W0, _soma
;q4.c,70 :: 		conv = (float)(soma);
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,72 :: 		pot  = conv*(4.5)/1023;
	MOV	#0, W2
	MOV	#16528, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _pot
	MOV	W1, _pot+2
;q4.c,74 :: 		ADCHSbits.CH0SA = 0b0111;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;q4.c,75 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,76 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;q4.c,77 :: 		ADC16Ptr = &ADCBUF0;
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;q4.c,78 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;q4.c,79 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;q4.c,80 :: 		while (!IFS0bits.ADIF);
L_conversaoAD14:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD15
	GOTO	L_conversaoAD14
L_conversaoAD15:
;q4.c,81 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;q4.c,83 :: 		for (count = 0; count < 16; count++)
	CLR	W0
	MOV	W0, _count
L_conversaoAD16:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversaoAD37
	GOTO	L_conversaoAD17
L__conversaoAD37:
;q4.c,84 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;q4.c,83 :: 		for (count = 0; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;q4.c,84 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD16
L_conversaoAD17:
;q4.c,85 :: 		soma = soma >> 4;
	MOV	_soma, W0
	LSR	W0, #4, W0
	MOV	W0, _soma
;q4.c,86 :: 		conv = (float)(soma);
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;q4.c,88 :: 		temp = 100*((conv*5)/1023);
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Mul_FP
	MOV	W0, _temp
	MOV	W1, _temp+2
;q4.c,89 :: 		}
L_end_conversaoAD:
	RETURN
; end of _conversaoAD

_Init_ADC:

;q4.c,91 :: 		void Init_ADC(){
;q4.c,93 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q4.c,94 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;q4.c,95 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;q4.c,96 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;q4.c,97 :: 		TRISB = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, TRISB
;q4.c,98 :: 		ADCON1 = 0;
	CLR	ADCON1
;q4.c,99 :: 		ADCON1bits.SSRC = 0b111;
	MOV	#lo_addr(ADCON1bits), W0
	MOV.B	[W0], W1
	MOV.B	#224, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	MOV.B	W1, [W0]
;q4.c,100 :: 		ADCSSL = 0;
	CLR	ADCSSL
;q4.c,101 :: 		ADCON2 = 0;
	CLR	ADCON2
;q4.c,102 :: 		ADCON3 = 0x0008;
	MOV	#8, W0
	MOV	WREG, ADCON3
;q4.c,103 :: 		ADCON2bits.SMPI = 0b1111;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;q4.c,104 :: 		ADCON1bits.ADON = 1;
	BSET	ADCON1bits, #15
;q4.c,106 :: 		}
L_end_Init_ADC:
	RETURN
; end of _Init_ADC

_ler_ADC:

;q4.c,108 :: 		int ler_ADC(int canal){
;q4.c,109 :: 		ADCHS = canal;
	MOV	W10, ADCHS
;q4.c,110 :: 		ADCON1bits.SAMP = 1;
	BSET.B	ADCON1bits, #1
;q4.c,111 :: 		delay_us(10);
	MOV	#53, W7
L_ler_ADC19:
	DEC	W7
	BRA NZ	L_ler_ADC19
	NOP
;q4.c,112 :: 		while(!ADCON1bits.DONE);
L_ler_ADC21:
	BTSC	ADCON1bits, #0
	GOTO	L_ler_ADC22
	GOTO	L_ler_ADC21
L_ler_ADC22:
;q4.c,113 :: 		return ADCBUF0;
	MOV	ADCBUF0, WREG
;q4.c,114 :: 		}
L_end_ler_ADC:
	RETURN
; end of _ler_ADC

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q4.c,122 :: 		void main() {
;q4.c,123 :: 		Init_ADC();
	PUSH	W10
	CALL	_Init_ADC
;q4.c,124 :: 		Init_UART2(103);
	MOV.B	#103, W10
	CALL	_Init_UART2
;q4.c,125 :: 		while(1){
L_main23:
;q4.c,126 :: 		conversaoAD();
	CALL	_conversaoAD
;q4.c,127 :: 		sprintf(txt1, "%.2f", temp);
	PUSH	_temp
	PUSH	_temp+2
	MOV	#lo_addr(?lstr_1_q4), W0
	PUSH	W0
	MOV	#lo_addr(_txt1), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;q4.c,128 :: 		sprintf(txt2, "%.2f", LDR);
	PUSH	_LDR
	PUSH	_LDR+2
	MOV	#lo_addr(?lstr_2_q4), W0
	PUSH	W0
	MOV	#lo_addr(_txt2), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;q4.c,129 :: 		sprintf(txt3, "%.2f", pot);
	PUSH	_pot
	PUSH	_pot+2
	MOV	#lo_addr(?lstr_3_q4), W0
	PUSH	W0
	MOV	#lo_addr(_txt3), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;q4.c,130 :: 		send_str("Temp ");
	MOV	#lo_addr(?lstr4_q4), W10
	CALL	_send_str
;q4.c,131 :: 		send_str(txt1);
	MOV	#lo_addr(_txt1), W10
	CALL	_send_str
;q4.c,132 :: 		send_str("ºC\r\n");
	MOV	#lo_addr(?lstr5_q4), W10
	CALL	_send_str
;q4.c,133 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main25:
	DEC	W7
	BRA NZ	L_main25
	DEC	W8
	BRA NZ	L_main25
;q4.c,134 :: 		send_str("LDR ");
	MOV	#lo_addr(?lstr6_q4), W10
	CALL	_send_str
;q4.c,135 :: 		send_str(txt2);
	MOV	#lo_addr(_txt2), W10
	CALL	_send_str
;q4.c,136 :: 		send_str(" V \r\n");
	MOV	#lo_addr(?lstr7_q4), W10
	CALL	_send_str
;q4.c,137 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main27:
	DEC	W7
	BRA NZ	L_main27
	DEC	W8
	BRA NZ	L_main27
;q4.c,138 :: 		send_str("Potenciometro ");
	MOV	#lo_addr(?lstr8_q4), W10
	CALL	_send_str
;q4.c,139 :: 		send_str(txt3);
	MOV	#lo_addr(_txt3), W10
	CALL	_send_str
;q4.c,140 :: 		send_str("V \r\n");
	MOV	#lo_addr(?lstr9_q4), W10
	CALL	_send_str
;q4.c,141 :: 		}
	GOTO	L_main23
;q4.c,142 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
