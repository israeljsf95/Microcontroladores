
_Init_UART2:

;LAB_Q44.c,11 :: 		void Init_UART2(unsigned char valor_baud){
;LAB_Q44.c,12 :: 		U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;LAB_Q44.c,13 :: 		U2MODE = 0x0000; //ver tabela para saber as outras configura??es
	CLR	U2MODE
;LAB_Q44.c,14 :: 		U2STA = 0x0000;
	CLR	U2STA
;LAB_Q44.c,15 :: 		IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;LAB_Q44.c,16 :: 		IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;LAB_Q44.c,17 :: 		IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;LAB_Q44.c,18 :: 		IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;LAB_Q44.c,19 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;LAB_Q44.c,20 :: 		U2STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U2STAbits, #10
;LAB_Q44.c,21 :: 		}
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

;LAB_Q44.c,24 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;LAB_Q44.c,25 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;LAB_Q44.c,26 :: 		}
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

;LAB_Q44.c,29 :: 		void send_char(unsigned char c){
;LAB_Q44.c,30 :: 		while( U2STAbits.UTXBF);
L_send_char0:
	BTSS	U2STAbits, #9
	GOTO	L_send_char1
	GOTO	L_send_char0
L_send_char1:
;LAB_Q44.c,31 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;LAB_Q44.c,32 :: 		}
L_end_send_char:
	RETURN
; end of _send_char

_send_str:

;LAB_Q44.c,35 :: 		void send_str(unsigned char* str){
;LAB_Q44.c,36 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;LAB_Q44.c,37 :: 		while(str[i])
L_send_str2:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str84
	GOTO	L_send_str3
L__send_str84:
;LAB_Q44.c,38 :: 		send_char(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str2
L_send_str3:
;LAB_Q44.c,39 :: 		}
L_end_send_str:
	RETURN
; end of _send_str

_conversaoAD:

;LAB_Q44.c,47 :: 		void conversaoAD(){
;LAB_Q44.c,49 :: 		ADCHSbits.CH0SA = 0b0110;
	MOV.B	#6, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,50 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,51 :: 		soma = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _soma
	MOV	W1, _soma+2
;LAB_Q44.c,52 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB_Q44.c,53 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB_Q44.c,54 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB_Q44.c,55 :: 		while (!IFS0bits.ADIF);
L_conversaoAD4:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD5
	GOTO	L_conversaoAD4
L_conversaoAD5:
;LAB_Q44.c,56 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB_Q44.c,58 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	#0, W1
	MOV	W0, _count
	MOV	W1, _count+2
L_conversaoAD6:
	MOV	_count, W0
	MOV	_count+2, W1
	CP	W0, #16
	CPB	W1, #0
	BRA LT	L__conversaoAD86
	GOTO	L_conversaoAD7
L__conversaoAD86:
;LAB_Q44.c,59 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W0
	MOV	W0, W1
	ASR	W1, #15, W2
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB_Q44.c,58 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;LAB_Q44.c,59 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD6
L_conversaoAD7:
;LAB_Q44.c,60 :: 		conv = (float)(soma);
	MOV	_soma, W0
	MOV	_soma+2, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,61 :: 		conv = conv/16;
	MOV	#0, W2
	MOV	#16768, W3
	CALL	__Div_FP
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,62 :: 		LDR  = conv*(4.5)/1023;
	MOV	#0, W2
	MOV	#16528, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _LDR
	MOV	W1, _LDR+2
;LAB_Q44.c,63 :: 		Delay_ms(350);
	MOV	#29, W8
	MOV	#31667, W7
L_conversaoAD9:
	DEC	W7
	BRA NZ	L_conversaoAD9
	DEC	W8
	BRA NZ	L_conversaoAD9
;LAB_Q44.c,65 :: 		ADCHSbits.CH0SA = 0b0111;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,66 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,67 :: 		soma = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _soma
	MOV	W1, _soma+2
;LAB_Q44.c,68 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB_Q44.c,69 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB_Q44.c,70 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB_Q44.c,71 :: 		while (!IFS0bits.ADIF);
L_conversaoAD11:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD12
	GOTO	L_conversaoAD11
L_conversaoAD12:
;LAB_Q44.c,72 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB_Q44.c,74 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	#0, W1
	MOV	W0, _count
	MOV	W1, _count+2
L_conversaoAD13:
	MOV	_count, W0
	MOV	_count+2, W1
	CP	W0, #16
	CPB	W1, #0
	BRA LT	L__conversaoAD87
	GOTO	L_conversaoAD14
L__conversaoAD87:
;LAB_Q44.c,75 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W0
	MOV	W0, W1
	ASR	W1, #15, W2
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB_Q44.c,74 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;LAB_Q44.c,75 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD13
L_conversaoAD14:
;LAB_Q44.c,76 :: 		conv = (float)(soma);
	MOV	_soma, W0
	MOV	_soma+2, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,77 :: 		conv = conv/16;
	MOV	#0, W2
	MOV	#16768, W3
	CALL	__Div_FP
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,78 :: 		temp = 100*((conv*5)/1023);
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
;LAB_Q44.c,79 :: 		Delay_ms(350);
	MOV	#29, W8
	MOV	#31667, W7
L_conversaoAD16:
	DEC	W7
	BRA NZ	L_conversaoAD16
	DEC	W8
	BRA NZ	L_conversaoAD16
;LAB_Q44.c,81 :: 		ADCHSbits.CH0SA = 0b1000;
	MOV.B	#8, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,82 :: 		conv = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,83 :: 		soma = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _soma
	MOV	W1, _soma+2
;LAB_Q44.c,84 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB_Q44.c,85 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB_Q44.c,86 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB_Q44.c,87 :: 		while (!IFS0bits.ADIF);
L_conversaoAD18:
	BTSC	IFS0bits, #11
	GOTO	L_conversaoAD19
	GOTO	L_conversaoAD18
L_conversaoAD19:
;LAB_Q44.c,88 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB_Q44.c,90 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	#0, W1
	MOV	W0, _count
	MOV	W1, _count+2
L_conversaoAD20:
	MOV	_count, W0
	MOV	_count+2, W1
	CP	W0, #16
	CPB	W1, #0
	BRA LT	L__conversaoAD88
	GOTO	L_conversaoAD21
L__conversaoAD88:
;LAB_Q44.c,91 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W0
	MOV	W0, W1
	ASR	W1, #15, W2
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB_Q44.c,90 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;LAB_Q44.c,91 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversaoAD20
L_conversaoAD21:
;LAB_Q44.c,92 :: 		conv = (float)(soma);
	MOV	_soma, W0
	MOV	_soma+2, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,93 :: 		conv = conv/16;
	MOV	#0, W2
	MOV	#16768, W3
	CALL	__Div_FP
	MOV	W0, _conv
	MOV	W1, _conv+2
;LAB_Q44.c,94 :: 		pot  = conv*(4.5)/1023;
	MOV	#0, W2
	MOV	#16528, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _pot
	MOV	W1, _pot+2
;LAB_Q44.c,95 :: 		Delay_ms(350);
	MOV	#29, W8
	MOV	#31667, W7
L_conversaoAD23:
	DEC	W7
	BRA NZ	L_conversaoAD23
	DEC	W8
	BRA NZ	L_conversaoAD23
;LAB_Q44.c,96 :: 		}
L_end_conversaoAD:
	RETURN
; end of _conversaoAD

_criatividade:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB_Q44.c,112 :: 		void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;LAB_Q44.c,113 :: 		delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_criatividade25:
	DEC	W7
	BRA NZ	L_criatividade25
	DEC	W8
	BRA NZ	L_criatividade25
;LAB_Q44.c,114 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;LAB_Q44.c,115 :: 		if (flag_criat == 0){
	MOV	_flag_criat, W0
	CP	W0, #0
	BRA Z	L__criatividade90
	GOTO	L_criatividade27
L__criatividade90:
;LAB_Q44.c,116 :: 		flag_criat = 1;
	MOV	#1, W0
	MOV	W0, _flag_criat
;LAB_Q44.c,117 :: 		}else{
	GOTO	L_criatividade28
L_criatividade27:
;LAB_Q44.c,118 :: 		flag_criat = 0;
	CLR	W0
	MOV	W0, _flag_criat
;LAB_Q44.c,119 :: 		};
L_criatividade28:
;LAB_Q44.c,120 :: 		}
L_end_criatividade:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _criatividade

_compara_cri:

;LAB_Q44.c,130 :: 		void compara_cri(int cri_cri){
;LAB_Q44.c,131 :: 		if(cri_cri == 1){
	CP	W10, #1
	BRA Z	L__compara_cri92
	GOTO	L_compara_cri29
L__compara_cri92:
;LAB_Q44.c,132 :: 		send_str("Estufa!");
	PUSH	W10
	MOV	#lo_addr(?lstr1_LAB_Q44), W10
	CALL	_send_str
;LAB_Q44.c,133 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,134 :: 		if((pot >= 0)&&(pot < valores[0])){
	CLR	W2
	CLR	W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__compara_cri93
	INC.B	W0
L__compara_cri93:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri94
	GOTO	L__compara_cri73
L__compara_cri94:
	PUSH	W10
	MOV	_valores, W2
	MOV	_valores+2, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__compara_cri95
	INC.B	W0
L__compara_cri95:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri96
	GOTO	L__compara_cri72
L__compara_cri96:
L__compara_cri71:
;LAB_Q44.c,135 :: 		if (flag_perigo == 1){
	MOV	_flag_perigo, W0
	CP	W0, #1
	BRA Z	L__compara_cri97
	GOTO	L_compara_cri33
L__compara_cri97:
;LAB_Q44.c,136 :: 		OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
	MOV	#313, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,137 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,138 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,139 :: 		send_str(perigo);
	PUSH	W10
	MOV	#lo_addr(_perigo), W10
	CALL	_send_str
;LAB_Q44.c,140 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,141 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;LAB_Q44.c,142 :: 		delay_ms(700);
	MOV	#57, W8
	MOV	#63335, W7
L_compara_cri34:
	DEC	W7
	BRA NZ	L_compara_cri34
	DEC	W8
	BRA NZ	L_compara_cri34
;LAB_Q44.c,143 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;LAB_Q44.c,144 :: 		send_str(venti_vel[3]);
	MOV	#lo_addr(_venti_vel+75), W10
	CALL	_send_str
;LAB_Q44.c,145 :: 		send_char('\n');}
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
	GOTO	L_compara_cri36
L_compara_cri33:
;LAB_Q44.c,147 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB_Q44.c,148 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB_Q44.c,150 :: 		OC1RS = 1250;
	MOV	#1250, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,151 :: 		send_str(venti_vel[0]);
	PUSH	W10
	MOV	#lo_addr(_venti_vel), W10
	CALL	_send_str
;LAB_Q44.c,152 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
;LAB_Q44.c,153 :: 		};
L_compara_cri36:
;LAB_Q44.c,134 :: 		if((pot >= 0)&&(pot < valores[0])){
L__compara_cri73:
L__compara_cri72:
;LAB_Q44.c,155 :: 		if((pot >= valores[0])&&(pot < valores[1])){
	PUSH	W10
	MOV	_valores, W2
	MOV	_valores+2, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__compara_cri98
	INC.B	W0
L__compara_cri98:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri99
	GOTO	L__compara_cri75
L__compara_cri99:
	PUSH	W10
	MOV	_valores+4, W2
	MOV	_valores+6, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__compara_cri100
	INC.B	W0
L__compara_cri100:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri101
	GOTO	L__compara_cri74
L__compara_cri101:
L__compara_cri70:
;LAB_Q44.c,156 :: 		if (flag_perigo == 1){
	MOV	_flag_perigo, W0
	CP	W0, #1
	BRA Z	L__compara_cri102
	GOTO	L_compara_cri40
L__compara_cri102:
;LAB_Q44.c,157 :: 		OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
	MOV	#313, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,158 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,159 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,160 :: 		send_str(perigo);
	PUSH	W10
	MOV	#lo_addr(_perigo), W10
	CALL	_send_str
;LAB_Q44.c,161 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,162 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;LAB_Q44.c,163 :: 		delay_ms(700);
	MOV	#57, W8
	MOV	#63335, W7
L_compara_cri41:
	DEC	W7
	BRA NZ	L_compara_cri41
	DEC	W8
	BRA NZ	L_compara_cri41
;LAB_Q44.c,164 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;LAB_Q44.c,165 :: 		send_str(venti_vel[3]);
	MOV	#lo_addr(_venti_vel+75), W10
	CALL	_send_str
;LAB_Q44.c,166 :: 		send_char('\n');}
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
	GOTO	L_compara_cri43
L_compara_cri40:
;LAB_Q44.c,168 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,169 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB_Q44.c,171 :: 		OC1RS = 938;
	MOV	#938, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,172 :: 		send_str(venti_vel[1]);
	PUSH	W10
	MOV	#lo_addr(_venti_vel+25), W10
	CALL	_send_str
;LAB_Q44.c,173 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
;LAB_Q44.c,174 :: 		};
L_compara_cri43:
;LAB_Q44.c,155 :: 		if((pot >= valores[0])&&(pot < valores[1])){
L__compara_cri75:
L__compara_cri74:
;LAB_Q44.c,176 :: 		if((pot >= valores[1])&&(pot < valores[2])){
	PUSH	W10
	MOV	_valores+4, W2
	MOV	_valores+6, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__compara_cri103
	INC.B	W0
L__compara_cri103:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri104
	GOTO	L__compara_cri77
L__compara_cri104:
	PUSH	W10
	MOV	_valores+8, W2
	MOV	_valores+10, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__compara_cri105
	INC.B	W0
L__compara_cri105:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri106
	GOTO	L__compara_cri76
L__compara_cri106:
L__compara_cri69:
;LAB_Q44.c,177 :: 		if (flag_perigo == 1){
	MOV	_flag_perigo, W0
	CP	W0, #1
	BRA Z	L__compara_cri107
	GOTO	L_compara_cri47
L__compara_cri107:
;LAB_Q44.c,178 :: 		OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
	MOV	#313, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,179 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,180 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,181 :: 		send_str(perigo);
	PUSH	W10
	MOV	#lo_addr(_perigo), W10
	CALL	_send_str
;LAB_Q44.c,182 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,183 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;LAB_Q44.c,184 :: 		delay_ms(700);
	MOV	#57, W8
	MOV	#63335, W7
L_compara_cri48:
	DEC	W7
	BRA NZ	L_compara_cri48
	DEC	W8
	BRA NZ	L_compara_cri48
;LAB_Q44.c,185 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;LAB_Q44.c,186 :: 		send_str(venti_vel[3]);
	MOV	#lo_addr(_venti_vel+75), W10
	CALL	_send_str
;LAB_Q44.c,187 :: 		send_char('\n');}
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
	GOTO	L_compara_cri50
L_compara_cri47:
;LAB_Q44.c,189 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB_Q44.c,190 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,191 :: 		OC1RS = 625;
	MOV	#625, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,193 :: 		send_str(venti_vel[2]);
	PUSH	W10
	MOV	#lo_addr(_venti_vel+50), W10
	CALL	_send_str
;LAB_Q44.c,194 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
;LAB_Q44.c,195 :: 		};
L_compara_cri50:
;LAB_Q44.c,176 :: 		if((pot >= valores[1])&&(pot < valores[2])){
L__compara_cri77:
L__compara_cri76:
;LAB_Q44.c,197 :: 		if((pot >= valores[2])&&(pot < valores[3])){
	PUSH	W10
	MOV	_valores+8, W2
	MOV	_valores+10, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__compara_cri108
	INC.B	W0
L__compara_cri108:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri109
	GOTO	L__compara_cri79
L__compara_cri109:
	PUSH	W10
	MOV	_valores+12, W2
	MOV	_valores+14, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__compara_cri110
	INC.B	W0
L__compara_cri110:
	POP	W10
	CP0.B	W0
	BRA NZ	L__compara_cri111
	GOTO	L__compara_cri78
L__compara_cri111:
L__compara_cri68:
;LAB_Q44.c,198 :: 		if (flag_perigo == 1){
	MOV	_flag_perigo, W0
	CP	W0, #1
	BRA Z	L__compara_cri112
	GOTO	L_compara_cri54
L__compara_cri112:
;LAB_Q44.c,199 :: 		OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
	MOV	#313, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,200 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,201 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,202 :: 		send_str(perigo);
	PUSH	W10
	MOV	#lo_addr(_perigo), W10
	CALL	_send_str
;LAB_Q44.c,203 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,204 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;LAB_Q44.c,205 :: 		delay_ms(700);
	MOV	#57, W8
	MOV	#63335, W7
L_compara_cri55:
	DEC	W7
	BRA NZ	L_compara_cri55
	DEC	W8
	BRA NZ	L_compara_cri55
;LAB_Q44.c,206 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;LAB_Q44.c,207 :: 		send_str(venti_vel[3]);
	MOV	#lo_addr(_venti_vel+75), W10
	CALL	_send_str
;LAB_Q44.c,208 :: 		send_char('\n');}
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
	GOTO	L_compara_cri57
L_compara_cri54:
;LAB_Q44.c,210 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB_Q44.c,211 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB_Q44.c,212 :: 		OC1RS = 313;
	MOV	#313, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,214 :: 		send_str(venti_vel[0]);
	PUSH	W10
	MOV	#lo_addr(_venti_vel), W10
	CALL	_send_str
;LAB_Q44.c,215 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
	POP	W10
;LAB_Q44.c,216 :: 		};
L_compara_cri57:
;LAB_Q44.c,197 :: 		if((pot >= valores[2])&&(pot < valores[3])){
L__compara_cri79:
L__compara_cri78:
;LAB_Q44.c,219 :: 		if(flag_perigo == 1){
	MOV	_flag_perigo, W0
	CP	W0, #1
	BRA Z	L__compara_cri113
	GOTO	L_compara_cri58
L__compara_cri113:
;LAB_Q44.c,221 :: 		};
L_compara_cri58:
;LAB_Q44.c,222 :: 		}
L_compara_cri29:
;LAB_Q44.c,223 :: 		if(cri_cri == 0){
	CP	W10, #0
	BRA Z	L__compara_cri114
	GOTO	L_compara_cri59
L__compara_cri114:
;LAB_Q44.c,224 :: 		OC1RS = 1250;
	MOV	#1250, W0
	MOV	WREG, OC1RS
;LAB_Q44.c,225 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB_Q44.c,226 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB_Q44.c,227 :: 		};
L_compara_cri59:
;LAB_Q44.c,228 :: 		}
L_end_compara_cri:
	RETURN
; end of _compara_cri

_Init_ADC:

;LAB_Q44.c,232 :: 		void Init_ADC(){
;LAB_Q44.c,234 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB_Q44.c,235 :: 		ADPCFGbits.PCFG0 = 1;
	BSET.B	ADPCFGbits, #0
;LAB_Q44.c,236 :: 		ADPCFGbits.PCFG1 = 1;
	BSET.B	ADPCFGbits, #1
;LAB_Q44.c,237 :: 		ADPCFGbits.PCFG6 = 0;
	BCLR.B	ADPCFGbits, #6
;LAB_Q44.c,238 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;LAB_Q44.c,239 :: 		ADPCFGbits.PCFG8 = 0;
	BCLR	ADPCFGbits, #8
;LAB_Q44.c,240 :: 		IFS0 = 0;
	CLR	IFS0
;LAB_Q44.c,241 :: 		IFS1 = 0;
	CLR	IFS1
;LAB_Q44.c,242 :: 		TRISB = 0;
	CLR	TRISB
;LAB_Q44.c,243 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB_Q44.c,244 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB_Q44.c,245 :: 		TRISE = 0x0100;
	MOV	#256, W0
	MOV	WREG, TRISE
;LAB_Q44.c,246 :: 		TRISBbits.TRISB6 = 1;
	BSET.B	TRISBbits, #6
;LAB_Q44.c,247 :: 		TRISBbits.TRISB7 = 1;
	BSET.B	TRISBbits, #7
;LAB_Q44.c,248 :: 		TRISBbits.TRISB8 = 1;
	BSET	TRISBbits, #8
;LAB_Q44.c,249 :: 		TRISD = 0;
	CLR	TRISD
;LAB_Q44.c,250 :: 		ADCON1 = 0;
	CLR	ADCON1
;LAB_Q44.c,251 :: 		ADCON1bits.SSRC = 0b010; // Sincando o tempo de conversao com o timer 3
	MOV.B	#64, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#224, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCON1bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCON1bits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,254 :: 		TMR3 = 0x0000;
	CLR	TMR3
;LAB_Q44.c,255 :: 		PR3 = 1500;
	MOV	#1500, W0
	MOV	WREG, PR3
;LAB_Q44.c,256 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;LAB_Q44.c,259 :: 		ADCHS = 0x0002; // Connect RB2/AN2 as CH0 input ..
	MOV	#2, W0
	MOV	WREG, ADCHS
;LAB_Q44.c,260 :: 		ADCSSL = 0;
	CLR	ADCSSL
;LAB_Q44.c,261 :: 		ADCON3 = 0x0007;
	MOV	#7, W0
	MOV	WREG, ADCON3
;LAB_Q44.c,262 :: 		ADCON3bits.ADCS = 8;
	MOV.B	#8, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCON3bits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,263 :: 		ADCON3bits.SAMC = 32;
	MOV	ADCON3bits, W1
	MOV	#57599, W0
	AND	W1, W0, W0
	MOV	WREG, ADCON3bits
;LAB_Q44.c,264 :: 		ADCON2 = 0;
	CLR	ADCON2
;LAB_Q44.c,265 :: 		ADCON2bits.SMPI = 0b1111;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;LAB_Q44.c,266 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;LAB_Q44.c,267 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;LAB_Q44.c,268 :: 		INTCON2bits.INT0EP = 0;
	BCLR.B	INTCON2bits, #0
;LAB_Q44.c,270 :: 		T2CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T2CON
;LAB_Q44.c,271 :: 		PR2 = 1250;
	MOV	#1250, W0
	MOV	WREG, PR2
;LAB_Q44.c,272 :: 		OC1CON = 0x0006;
	MOV	#6, W0
	MOV	WREG, OC1CON
;LAB_Q44.c,273 :: 		OC1RS = 0;
	CLR	OC1RS
;LAB_Q44.c,276 :: 		}
L_end_Init_ADC:
	RETURN
; end of _Init_ADC

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB_Q44.c,284 :: 		void main() {
;LAB_Q44.c,285 :: 		Init_ADC();
	PUSH	W10
	CALL	_Init_ADC
;LAB_Q44.c,286 :: 		Init_UART2(51); // UBRG = int((16000000/(16*19200)) - 1) -> FCY = 16000000 = 1/MIPS
	MOV.B	#51, W10
	CALL	_Init_UART2
;LAB_Q44.c,287 :: 		while(1){
L_main60:
;LAB_Q44.c,288 :: 		delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_main62:
	DEC	W7
	BRA NZ	L_main62
	DEC	W8
	BRA NZ	L_main62
;LAB_Q44.c,289 :: 		conversaoAD();
	CALL	_conversaoAD
;LAB_Q44.c,290 :: 		sprintf(txt1, "%.2f", temp);
	PUSH	_temp
	PUSH	_temp+2
	MOV	#lo_addr(?lstr_2_LAB_Q44), W0
	PUSH	W0
	MOV	#lo_addr(_txt1), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;LAB_Q44.c,291 :: 		sprintf(txt3, "%.2f", pot);
	PUSH	_pot
	PUSH	_pot+2
	MOV	#lo_addr(?lstr_3_LAB_Q44), W0
	PUSH	W0
	MOV	#lo_addr(_txt3), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;LAB_Q44.c,292 :: 		sprintf(txt2, "%.2f", LDR);
	PUSH	_LDR
	PUSH	_LDR+2
	MOV	#lo_addr(?lstr_4_LAB_Q44), W0
	PUSH	W0
	MOV	#lo_addr(_txt2), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;LAB_Q44.c,293 :: 		send_str("Temp\t        LDR\tPOT");
	MOV	#lo_addr(?lstr5_LAB_Q44), W10
	CALL	_send_str
;LAB_Q44.c,294 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,295 :: 		send_str(txt1);
	MOV	#lo_addr(_txt1), W10
	CALL	_send_str
;LAB_Q44.c,296 :: 		send_str("°C ");
	MOV	#lo_addr(?lstr6_LAB_Q44), W10
	CALL	_send_str
;LAB_Q44.c,298 :: 		send_char('\t');
	MOV.B	#9, W10
	CALL	_send_char
;LAB_Q44.c,299 :: 		send_str(txt2);
	MOV	#lo_addr(_txt2), W10
	CALL	_send_str
;LAB_Q44.c,300 :: 		send_str("V");
	MOV	#lo_addr(?lstr7_LAB_Q44), W10
	CALL	_send_str
;LAB_Q44.c,301 :: 		send_char('\t');
	MOV.B	#9, W10
	CALL	_send_char
;LAB_Q44.c,302 :: 		send_str(txt3);
	MOV	#lo_addr(_txt3), W10
	CALL	_send_str
;LAB_Q44.c,303 :: 		send_str("V");
	MOV	#lo_addr(?lstr8_LAB_Q44), W10
	CALL	_send_str
;LAB_Q44.c,304 :: 		send_char('\n');
	MOV.B	#10, W10
	CALL	_send_char
;LAB_Q44.c,305 :: 		if (temp > 40){flag_perigo = 1;}
	MOV	#0, W2
	MOV	#16928, W3
	MOV	_temp, W0
	MOV	_temp+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main117
	INC.B	W0
L__main117:
	CP0.B	W0
	BRA NZ	L__main118
	GOTO	L_main64
L__main118:
	MOV	#1, W0
	MOV	W0, _flag_perigo
	GOTO	L_main65
L_main64:
;LAB_Q44.c,306 :: 		else{flag_perigo = 0;};
	CLR	W0
	MOV	W0, _flag_perigo
L_main65:
;LAB_Q44.c,307 :: 		compara_cri(flag_criat);
	MOV	_flag_criat, W10
	CALL	_compara_cri
;LAB_Q44.c,308 :: 		delay_ms(200);
	MOV	#17, W8
	MOV	#18095, W7
L_main66:
	DEC	W7
	BRA NZ	L_main66
	DEC	W8
	BRA NZ	L_main66
;LAB_Q44.c,309 :: 		}
	GOTO	L_main60
;LAB_Q44.c,310 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
