
_criatividade:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q2.c,30 :: 		void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;Q2.c,31 :: 		Delay_ms(100);
	MOV	#2, W8
	MOV	#17796, W7
L_criatividade0:
	DEC	W7
	BRA NZ	L_criatividade0
	DEC	W8
	BRA NZ	L_criatividade0
	NOP
	NOP
;Q2.c,32 :: 		flag_criatividade = ~flag_criatividade;
	MOV	#lo_addr(_flag_criatividade), W0
	COM	[W0], [W0]
;Q2.c,33 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;Q2.c,34 :: 		}
L_end_criatividade:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _criatividade

_PWMmotor:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q2.c,36 :: 		void PWMmotor() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;Q2.c,37 :: 		if(flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__PWMmotor41
	GOTO	L_PWMmotor2
L__PWMmotor41:
;Q2.c,38 :: 		motor = ~motor;
	BTG	LATBbits, #3
;Q2.c,39 :: 		}else{
	GOTO	L_PWMmotor3
L_PWMmotor2:
;Q2.c,40 :: 		led1 = ~led1;
	BTG	LATBbits, #0
;Q2.c,41 :: 		}
L_PWMmotor3:
;Q2.c,42 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;Q2.c,43 :: 		}
L_end_PWMmotor:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _PWMmotor

_PWMleds:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q2.c,45 :: 		void PWMleds() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {
;Q2.c,47 :: 		if(flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__PWMleds43
	GOTO	L_PWMleds4
L__PWMleds43:
;Q2.c,48 :: 		led1 = ~led1;
	BTG	LATBbits, #0
;Q2.c,49 :: 		led2 = ~led2;
	BTG	LATBbits, #1
;Q2.c,50 :: 		}else{
	GOTO	L_PWMleds5
L_PWMleds4:
;Q2.c,51 :: 		led2 = ~led2;
	BTG	LATBbits, #1
;Q2.c,52 :: 		}
L_PWMleds5:
;Q2.c,54 :: 		IFS1bits.T4IF = 0;
	BCLR.B	IFS1bits, #5
;Q2.c,55 :: 		}
L_end_PWMleds:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _PWMleds

_conversao_temporizada:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q2.c,58 :: 		void conversao_temporizada() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{
;Q2.c,60 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;Q2.c,63 :: 		ADCHSbits.CH0SA = 0b0010;  //liga o canal 0 na entrada RB2
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q2.c,64 :: 		soma = 0;                  //reseta soma
	CLR	W0
	MOV	W0, _soma
;Q2.c,65 :: 		ADC16Ptr = &ADCBUF1;       //pega o endereço do segundo buffer
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;Q2.c,66 :: 		IFS0bits.ADIF = 0;         //reseta flag da interrupção do ADC
	BCLR	IFS0bits, #11
;Q2.c,67 :: 		ADCON1bits.ASAM = 1;       //inicia amostragem automatica
	BSET.B	ADCON1bits, #2
;Q2.c,68 :: 		while (!IFS0bits.ADIF);    //Espera conversao acabar
L_conversao_temporizada6:
	BTSC	IFS0bits, #11
	GOTO	L_conversao_temporizada7
	GOTO	L_conversao_temporizada6
L_conversao_temporizada7:
;Q2.c,69 :: 		ADCON1bits.ASAM = 0;       //desliga amostragem automatica
	BCLR.B	ADCON1bits, #2
;Q2.c,70 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_conversao_temporizada8:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversao_temporizada45
	GOTO	L_conversao_temporizada9
L__conversao_temporizada45:
;Q2.c,71 :: 		soma = soma + *ADC16Ptr++; //descarta a primeira amostra
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;Q2.c,70 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;Q2.c,71 :: 		soma = soma + *ADC16Ptr++; //descarta a primeira amostra
	GOTO	L_conversao_temporizada8
L_conversao_temporizada9:
;Q2.c,72 :: 		media[0] = soma/15;            //calcula a media
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media
;Q2.c,75 :: 		ADCHSbits.CH0SA = 0b0101;
	MOV.B	#5, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q2.c,76 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;Q2.c,77 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;Q2.c,78 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;Q2.c,79 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;Q2.c,80 :: 		while (!IFS0bits.ADIF);
L_conversao_temporizada11:
	BTSC	IFS0bits, #11
	GOTO	L_conversao_temporizada12
	GOTO	L_conversao_temporizada11
L_conversao_temporizada12:
;Q2.c,81 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;Q2.c,82 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_conversao_temporizada13:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversao_temporizada46
	GOTO	L_conversao_temporizada14
L__conversao_temporizada46:
;Q2.c,83 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;Q2.c,82 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;Q2.c,83 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversao_temporizada13
L_conversao_temporizada14:
;Q2.c,84 :: 		media[1] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media+2
;Q2.c,87 :: 		ADCHSbits.CH0SA = 0b0111;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q2.c,88 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;Q2.c,89 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;Q2.c,90 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;Q2.c,91 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;Q2.c,92 :: 		while (!IFS0bits.ADIF);
L_conversao_temporizada16:
	BTSC	IFS0bits, #11
	GOTO	L_conversao_temporizada17
	GOTO	L_conversao_temporizada16
L_conversao_temporizada17:
;Q2.c,93 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;Q2.c,94 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_conversao_temporizada18:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__conversao_temporizada47
	GOTO	L_conversao_temporizada19
L__conversao_temporizada47:
;Q2.c,95 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;Q2.c,94 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;Q2.c,95 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_conversao_temporizada18
L_conversao_temporizada19:
;Q2.c,96 :: 		media[2] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media+4
;Q2.c,99 :: 		temp = (float)media[0]*0.488758;
	MOV	_media, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#15997, W2
	MOV	#16122, W3
	CALL	__Mul_FP
	MOV	W0, _temp
	MOV	W1, _temp+2
;Q2.c,100 :: 		LDR = (float)media[1]*5/1023;
	MOV	_media+2, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _LDR
	MOV	W1, _LDR+2
;Q2.c,101 :: 		pot = (float)media[2]*5/1023;
	MOV	_media+4, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _pot
	MOV	W1, _pot+2
;Q2.c,103 :: 		}
L_end_conversao_temporizada:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _conversao_temporizada

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#4

;Q2.c,105 :: 		void main() {
;Q2.c,107 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q2.c,108 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;Q2.c,109 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;Q2.c,110 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;Q2.c,112 :: 		TRISB = 0;
	CLR	TRISB
;Q2.c,113 :: 		TRISBbits.TRISB2 = 1;
	BSET.B	TRISBbits, #2
;Q2.c,114 :: 		TRISBbits.TRISB5 = 1;
	BSET.B	TRISBbits, #5
;Q2.c,115 :: 		TRISBbits.TRISB7 = 1;
	BSET.B	TRISBbits, #7
;Q2.c,118 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;Q2.c,119 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;Q2.c,120 :: 		IFS0 = 0;
	CLR	IFS0
;Q2.c,121 :: 		IFS1 = 0;
	CLR	IFS1
;Q2.c,124 :: 		ADCHSbits.CH0SA = 0b0010; //Iniciar conversao pelo pino RB2
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q2.c,125 :: 		ADCSSL = 0;
	CLR	ADCSSL
;Q2.c,127 :: 		ADCON1 = 0;
	CLR	ADCON1
;Q2.c,128 :: 		ADCON1bits.SSRC = 0b010; // Clock pelo timer 3
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
;Q2.c,130 :: 		TMR3 = 0x0000;     //Configurando timer 3 para 8Khz
	CLR	TMR3
;Q2.c,131 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;Q2.c,132 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;Q2.c,134 :: 		ADCON2 = 0;
	CLR	ADCON2
;Q2.c,135 :: 		ADCON2bits.SMPI = 0b1111; // Interrupção depois de 16 conversões
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;Q2.c,136 :: 		ADCON3 = 0x0008; // 15Tad
	MOV	#8, W0
	MOV	WREG, ADCON3
;Q2.c,140 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;Q2.c,141 :: 		TMR1 = 0x0000;
	CLR	TMR1
;Q2.c,142 :: 		PR1 = 31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;Q2.c,143 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;Q2.c,147 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;Q2.c,148 :: 		TMR2 = 0x0000;
	CLR	TMR2
;Q2.c,149 :: 		PR2 = PRx;    //10Hertz
	MOV	_PRx, W0
	MOV	WREG, PR2
;Q2.c,150 :: 		T2CON = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T2CON
;Q2.c,153 :: 		IEC1bits.T4IE = 1;
	BSET.B	IEC1bits, #5
;Q2.c,154 :: 		TMR4 = 0x0000;
	CLR	TMR4
;Q2.c,155 :: 		PR4 = PRx;   //10Hertz
	MOV	_PRx, W0
	MOV	WREG, PR4
;Q2.c,156 :: 		T4CON = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T4CON
;Q2.c,159 :: 		flag_criatividade = 0;
	CLR	W0
	MOV	W0, _flag_criatividade
;Q2.c,160 :: 		led1 = 0;
	BCLR.B	LATBbits, #0
;Q2.c,161 :: 		led2 = 0;
	BCLR.B	LATBbits, #1
;Q2.c,162 :: 		motor = 0;
	BCLR.B	LATBbits, #3
;Q2.c,165 :: 		Lcd_Init();               // Inicializa o LCD
	CALL	_Lcd_Init
;Q2.c,166 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q2.c,167 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;Q2.c,169 :: 		ADCON1.ADON = 1;    //Liga o ADC
	BSET	ADCON1, #15
;Q2.c,171 :: 		while(1){
L_main21:
;Q2.c,172 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q2.c,174 :: 		if(flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__main49
	GOTO	L_main23
L__main49:
;Q2.c,175 :: 		duty2 = temp/100;
	MOV	#0, W2
	MOV	#17096, W3
	MOV	_temp, W0
	MOV	_temp+2, W1
	CALL	__Div_FP
	MOV	W0, _duty2
	MOV	W1, _duty2+2
;Q2.c,176 :: 		duty4 = LDR/5;
	MOV	#0, W2
	MOV	#16544, W3
	MOV	_LDR, W0
	MOV	_LDR+2, W1
	CALL	__Div_FP
	MOV	W0, _duty4
	MOV	W1, _duty4+2
;Q2.c,178 :: 		if (motor == 0){
	BTSC	LATBbits, #3
	GOTO	L_main24
;Q2.c,179 :: 		PR2 = floor((1 - duty2)*PRx);
	MOV	#0, W0
	MOV	#16256, W1
	MOV	_duty2, W2
	MOV	_duty2+2, W3
	CALL	__Sub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR2
;Q2.c,180 :: 		}else{
	GOTO	L_main25
L_main24:
;Q2.c,181 :: 		PR2 =  floor(duty2*PRx);
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty2, W2
	MOV	_duty2+2, W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR2
;Q2.c,182 :: 		}
L_main25:
;Q2.c,184 :: 		if (led1 == 0){
	BTSC	LATBbits, #0
	GOTO	L_main26
;Q2.c,185 :: 		PR4 = floor((1 - duty4)*PRx);
	MOV	#0, W0
	MOV	#16256, W1
	MOV	_duty4, W2
	MOV	_duty4+2, W3
	CALL	__Sub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR4
;Q2.c,186 :: 		}else{
	GOTO	L_main27
L_main26:
;Q2.c,187 :: 		PR4 =  floor(duty4*PRx);
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty4, W2
	MOV	_duty4+2, W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR4
;Q2.c,188 :: 		}
L_main27:
;Q2.c,190 :: 		Lcd_Out(1,1,"Potenciometro       ");
	MOV	#lo_addr(?lstr1_Q2), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q2.c,192 :: 		if (pot < 0.1){
	MOV	#52429, W2
	MOV	#15820, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__main50
	INC.B	W0
L__main50:
	CP0.B	W0
	BRA NZ	L__main51
	GOTO	L_main28
L__main51:
;Q2.c,193 :: 		pot = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _pot
	MOV	W1, _pot+2
;Q2.c,194 :: 		}
L_main28:
;Q2.c,196 :: 		FloatToStr(pot,txt);//mostra tensao do potenciometro
	MOV	#lo_addr(_txt), W12
	MOV	_pot, W10
	MOV	_pot+2, W11
	CALL	_FloatToStr
;Q2.c,198 :: 		if (pot < 1){
	MOV	#0, W2
	MOV	#16256, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__main52
	INC.B	W0
L__main52:
	CP0.B	W0
	BRA NZ	L__main53
	GOTO	L_main29
L__main53:
;Q2.c,199 :: 		aux[0] = txt[0];
	MOV	#lo_addr(_aux), W1
	MOV	#lo_addr(_txt), W0
	MOV.B	[W0], [W1]
;Q2.c,200 :: 		aux[1] = txt[3];
	MOV	#lo_addr(_aux+1), W1
	MOV	#lo_addr(_txt+3), W0
	MOV.B	[W0], [W1]
;Q2.c,201 :: 		txt[0] = '0';
	MOV	#lo_addr(_txt), W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;Q2.c,202 :: 		txt[2] = aux[0];
	MOV	#lo_addr(_txt+2), W1
	MOV	#lo_addr(_aux), W0
	MOV.B	[W0], [W1]
;Q2.c,203 :: 		txt[3] = aux[1];
	MOV	#lo_addr(_txt+3), W1
	MOV	#lo_addr(_aux+1), W0
	MOV.B	[W0], [W1]
;Q2.c,204 :: 		}
L_main29:
;Q2.c,205 :: 		Lcd_Out(2,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q2.c,206 :: 		Lcd_Out(2,5,"              ");
	MOV	#lo_addr(?lstr2_Q2), W12
	MOV	#5, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q2.c,208 :: 		}else{
	GOTO	L_main30
L_main23:
;Q2.c,210 :: 		duty2 = pot/5;
	MOV	#0, W2
	MOV	#16544, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Div_FP
	MOV	W0, _duty2
	MOV	W1, _duty2+2
;Q2.c,211 :: 		duty4 = LDR/5;
	MOV	#0, W2
	MOV	#16544, W3
	MOV	_LDR, W0
	MOV	_LDR+2, W1
	CALL	__Div_FP
	MOV	W0, _duty4
	MOV	W1, _duty4+2
;Q2.c,213 :: 		if (led1 == 0){
	BTSC	LATBbits, #0
	GOTO	L_main31
;Q2.c,214 :: 		PR2 = floor((1 - duty2)*PRx);
	MOV	#0, W0
	MOV	#16256, W1
	MOV	_duty2, W2
	MOV	_duty2+2, W3
	CALL	__Sub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR2
;Q2.c,215 :: 		}else{
	GOTO	L_main32
L_main31:
;Q2.c,216 :: 		PR2 =  floor(duty2*PRx);
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty2, W2
	MOV	_duty2+2, W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR2
;Q2.c,217 :: 		}
L_main32:
;Q2.c,219 :: 		if (led2 == 0){
	BTSC	LATBbits, #1
	GOTO	L_main33
;Q2.c,220 :: 		PR4 = floor((1 - duty4)*PRx);
	MOV	#0, W0
	MOV	#16256, W1
	MOV	_duty4, W2
	MOV	_duty4+2, W3
	CALL	__Sub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR4
;Q2.c,221 :: 		}else{
	GOTO	L_main34
L_main33:
;Q2.c,222 :: 		PR4 =  floor(duty4*PRx);
	MOV	_PRx, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty4, W2
	MOV	_duty4+2, W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR4
;Q2.c,223 :: 		}
L_main34:
;Q2.c,225 :: 		if(temp > 40){
	MOV	#0, W2
	MOV	#16928, W3
	MOV	_temp, W0
	MOV	_temp+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main54
	INC.B	W0
L__main54:
	CP0.B	W0
	BRA NZ	L__main55
	GOTO	L_main35
L__main55:
;Q2.c,226 :: 		motor = 1;
	BSET.B	LATBbits, #3
;Q2.c,227 :: 		Lcd_Out(1,1,"      PERIGO       ");
	MOV	#lo_addr(?lstr3_Q2), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q2.c,228 :: 		Lcd_Out(2,1,"    RESFRIANDO     ");
	MOV	#lo_addr(?lstr4_Q2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q2.c,229 :: 		}else{
	GOTO	L_main36
L_main35:
;Q2.c,230 :: 		Lcd_Out(1,1,"    TEMPERATURA    ");
	MOV	#lo_addr(?lstr5_Q2), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q2.c,231 :: 		Lcd_Out(2,1,"      NORMAL       ");
	MOV	#lo_addr(?lstr6_Q2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q2.c,232 :: 		}
L_main36:
;Q2.c,233 :: 		}
L_main30:
;Q2.c,234 :: 		Delay_ms(500);
	MOV	#7, W8
	MOV	#23451, W7
L_main37:
	DEC	W7
	BRA NZ	L_main37
	DEC	W8
	BRA NZ	L_main37
	NOP
	NOP
;Q2.c,235 :: 		}
	GOTO	L_main21
;Q2.c,236 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
