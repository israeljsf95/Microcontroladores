
_PWM_Motor:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;PWM.c,38 :: 		void PWM_Motor() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;PWM.c,39 :: 		flag_PWM = ~flag_PWM;
	MOV	#lo_addr(_flag_PWM), W0
	COM	[W0], [W0]
;PWM.c,41 :: 		if (flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__PWM_Motor30
	GOTO	L_PWM_Motor0
L__PWM_Motor30:
;PWM.c,42 :: 		PWM1 =~ PWM1;
	BTG	LATBbits, #3
;PWM.c,43 :: 		}
L_PWM_Motor0:
;PWM.c,45 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;PWM.c,46 :: 		}
L_end_PWM_Motor:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _PWM_Motor

_PWM_Led:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;PWM.c,48 :: 		void PWM_Led() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {
;PWM.c,49 :: 		flag_PWM4 = ~flag_PWM4;
	MOV	#lo_addr(_flag_PWM4), W0
	COM	[W0], [W0]
;PWM.c,51 :: 		PWM2 =~ PWM2;
	BTG	LATBbits, #0
;PWM.c,52 :: 		PWM3 =~ PWM3;
	BTG	LATBbits, #1
;PWM.c,54 :: 		IFS1bits.T4IF = 0;
	BCLR.B	IFS1bits, #5
;PWM.c,55 :: 		}
L_end_PWM_Led:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _PWM_Led

_botao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;PWM.c,57 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;PWM.c,58 :: 		flag_criatividade = ~flag_criatividade;
	MOV	#lo_addr(_flag_criatividade), W0
	COM	[W0], [W0]
;PWM.c,59 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_botao1:
	DEC	W7
	BRA NZ	L_botao1
	DEC	W8
	BRA NZ	L_botao1
;PWM.c,60 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;PWM.c,61 :: 		}
L_end_botao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao

_ADC:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;PWM.c,63 :: 		void ADC() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;PWM.c,66 :: 		ADCHSbits.CH0SA = 0b0010;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;PWM.c,67 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;PWM.c,68 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;PWM.c,69 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;PWM.c,70 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;PWM.c,71 :: 		while (!IFS0bits.ADIF);
L_ADC3:
	BTSC	IFS0bits, #11
	GOTO	L_ADC4
	GOTO	L_ADC3
L_ADC4:
;PWM.c,72 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;PWM.c,73 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_ADC5:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__ADC34
	GOTO	L_ADC6
L__ADC34:
;PWM.c,74 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;PWM.c,73 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;PWM.c,74 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_ADC5
L_ADC6:
;PWM.c,75 :: 		media[0] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media
;PWM.c,77 :: 		ADCHSbits.CH0SA = 0b0101;
	MOV.B	#5, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;PWM.c,78 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;PWM.c,79 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;PWM.c,80 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;PWM.c,81 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;PWM.c,82 :: 		while (!IFS0bits.ADIF);
L_ADC8:
	BTSC	IFS0bits, #11
	GOTO	L_ADC9
	GOTO	L_ADC8
L_ADC9:
;PWM.c,83 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;PWM.c,84 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_ADC10:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__ADC35
	GOTO	L_ADC11
L__ADC35:
;PWM.c,85 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;PWM.c,84 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;PWM.c,85 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_ADC10
L_ADC11:
;PWM.c,86 :: 		media[1] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media+2
;PWM.c,88 :: 		ADCHSbits.CH0SA = 0b0111;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;PWM.c,89 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;PWM.c,91 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;PWM.c,92 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;PWM.c,93 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;PWM.c,94 :: 		while (!IFS0bits.ADIF);
L_ADC13:
	BTSC	IFS0bits, #11
	GOTO	L_ADC14
	GOTO	L_ADC13
L_ADC14:
;PWM.c,95 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;PWM.c,96 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_ADC15:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__ADC36
	GOTO	L_ADC16
L__ADC36:
;PWM.c,97 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;PWM.c,96 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;PWM.c,97 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_ADC15
L_ADC16:
;PWM.c,98 :: 		media[2] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _media+4
;PWM.c,101 :: 		if (flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__ADC37
	GOTO	L_ADC18
L__ADC37:
;PWM.c,102 :: 		IntToStr(media[2],txt);
	MOV	#lo_addr(_txt), W11
	MOV	_media+4, W10
	CALL	_IntToStr
;PWM.c,111 :: 		Lcd_Out(1,1,"Potenciometro");
	MOV	#lo_addr(?lstr1_PWM), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;PWM.c,112 :: 		Lcd_Out(2,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;PWM.c,115 :: 		}
L_ADC18:
;PWM.c,117 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;PWM.c,118 :: 		}
L_end_ADC:
	POP	W12
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _ADC

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;PWM.c,121 :: 		void main() {
;PWM.c,123 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;PWM.c,124 :: 		TRISB = 0;
	CLR	TRISB
;PWM.c,125 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;PWM.c,126 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;PWM.c,127 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;PWM.c,129 :: 		IFS0 = 0;
	CLR	IFS0
;PWM.c,131 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;PWM.c,132 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;PWM.c,133 :: 		IEC1bits.T4IE = 1;
	BSET.B	IEC1bits, #5
;PWM.c,134 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;PWM.c,135 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;PWM.c,136 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;PWM.c,138 :: 		TRISBbits.TRISB0 = 0;
	BCLR.B	TRISBbits, #0
;PWM.c,139 :: 		TRISBbits.TRISB1 = 0;
	BCLR.B	TRISBbits, #1
;PWM.c,140 :: 		TRISBbits.TRISB3 = 0;
	BCLR.B	TRISBbits, #3
;PWM.c,143 :: 		flag_PWM = 0;
	CLR	W0
	MOV	W0, _flag_PWM
;PWM.c,144 :: 		PR1x = 25000;
	MOV	#25000, W0
	MOV	W0, _PR1x
;PWM.c,146 :: 		duty = 1;
	MOV	#0, W0
	MOV	#16256, W1
	MOV	W0, _duty
	MOV	W1, _duty+2
;PWM.c,147 :: 		duty2 =1;
	MOV	#0, W0
	MOV	#16256, W1
	MOV	W0, _duty2
	MOV	W1, _duty2+2
;PWM.c,149 :: 		up2 = PR1x*duty;
	MOV	#25000, W0
	MOV	W0, _up2
;PWM.c,150 :: 		down2 = PR1x - up2;
	CLR	W0
	MOV	W0, _down2
;PWM.c,152 :: 		up = PR1x*duty;
	MOV	#25000, W0
	MOV	W0, _up
;PWM.c,153 :: 		down = PR1x - up;
	CLR	W0
	MOV	W0, _down
;PWM.c,156 :: 		ADCSSL = 0;
	CLR	ADCSSL
;PWM.c,157 :: 		ADCHSbits.CH0SA = 0b0010;
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;PWM.c,158 :: 		ADCON1 = 0;
	CLR	ADCON1
;PWM.c,159 :: 		ADCON1bits.SSRC = 0b010; // SSRC bit = 111 implies internal
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
;PWM.c,160 :: 		ADCON2 = 0;
	CLR	ADCON2
;PWM.c,161 :: 		ADCON2bits.SMPI = 0b1111;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;PWM.c,162 :: 		ADCON3 = 0x0008;
	MOV	#8, W0
	MOV	WREG, ADCON3
;PWM.c,165 :: 		PR1 = up;
	MOV	#25000, W0
	MOV	WREG, PR1
;PWM.c,166 :: 		T1CON = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T1CON
;PWM.c,168 :: 		PR4 = up2;
	MOV	#25000, W0
	MOV	WREG, PR4
;PWM.c,169 :: 		T4CON = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T4CON
;PWM.c,171 :: 		TMR3 = 0x0000;
	CLR	TMR3
;PWM.c,172 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;PWM.c,173 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;PWM.c,176 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;PWM.c,178 :: 		T2CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T2CON
;PWM.c,179 :: 		PR2 = 32500;
	MOV	#32500, W0
	MOV	WREG, PR2
;PWM.c,181 :: 		flag_criatividade = 0;
	CLR	W0
	MOV	W0, _flag_criatividade
;PWM.c,184 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;PWM.c,185 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;PWM.c,186 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;PWM.c,188 :: 		while(1){
L_main19:
;PWM.c,189 :: 		duty = (float)media[0]*5/1023;
	MOV	_media, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _duty
	MOV	W1, _duty+2
;PWM.c,191 :: 		duty2 = (float)media[1]/1023;
	MOV	_media+2, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _duty2
	MOV	W1, _duty2+2
;PWM.c,193 :: 		if(flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__main39
	GOTO	L_main21
L__main39:
;PWM.c,195 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;PWM.c,196 :: 		up = PR1x*duty;
	MOV	_PR1x, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty, W2
	MOV	_duty+2, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _up
;PWM.c,197 :: 		down = PR1x - up+1;
	MOV	#lo_addr(_PR1x), W1
	SUBR	W0, [W1], W1
	MOV	#lo_addr(_down), W0
	ADD	W1, #1, [W0]
;PWM.c,199 :: 		if(flag_PWM == 0){
	MOV	_flag_PWM, W0
	CP	W0, #0
	BRA Z	L__main40
	GOTO	L_main22
L__main40:
;PWM.c,200 :: 		PR1 = down;
	MOV	_down, W0
	MOV	WREG, PR1
;PWM.c,201 :: 		}else{
	GOTO	L_main23
L_main22:
;PWM.c,202 :: 		PR1 = up;
	MOV	_up, W0
	MOV	WREG, PR1
;PWM.c,203 :: 		}
L_main23:
;PWM.c,205 :: 		up2 = PR1x*duty2;
	MOV	_PR1x, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	_duty2, W2
	MOV	_duty2+2, W3
	CALL	__Mul_FP
	CALL	__Float2Longint
	MOV	W0, _up2
;PWM.c,206 :: 		down2 = PR1x - up2+1;
	MOV	#lo_addr(_PR1x), W1
	SUBR	W0, [W1], W1
	MOV	#lo_addr(_down2), W0
	ADD	W1, #1, [W0]
;PWM.c,208 :: 		if(flag_PWM4 == 0){
	MOV	_flag_PWM4, W0
	CP	W0, #0
	BRA Z	L__main41
	GOTO	L_main24
L__main41:
;PWM.c,209 :: 		PR4 = down2;
	MOV	_down2, W0
	MOV	WREG, PR4
;PWM.c,210 :: 		}else{
	GOTO	L_main25
L_main24:
;PWM.c,211 :: 		PR4 = up2;
	MOV	_up2, W0
	MOV	WREG, PR4
;PWM.c,212 :: 		}
L_main25:
;PWM.c,214 :: 		}else{
	GOTO	L_main26
L_main21:
;PWM.c,215 :: 		if(duty < 0.3){
	MOV	#39322, W2
	MOV	#16025, W3
	MOV	_duty, W0
	MOV	_duty+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__main42
	INC.B	W0
L__main42:
	CP0.B	W0
	BRA NZ	L__main43
	GOTO	L_main27
L__main43:
;PWM.c,216 :: 		FloatToStr(duty,txt);
	MOV	#lo_addr(_txt), W12
	MOV	_duty, W10
	MOV	_duty+2, W11
	CALL	_FloatToStr
;PWM.c,217 :: 		Lcd_Out(1,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;PWM.c,219 :: 		Lcd_Out(2,1,"     NORMAL     ");
	MOV	#lo_addr(?lstr2_PWM), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;PWM.c,220 :: 		}else{
	GOTO	L_main28
L_main27:
;PWM.c,221 :: 		FloatToStr(duty,txt);
	MOV	#lo_addr(_txt), W12
	MOV	_duty, W10
	MOV	_duty+2, W11
	CALL	_FloatToStr
;PWM.c,222 :: 		Lcd_Out(1,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;PWM.c,223 :: 		Lcd_Out(2,1,"  RESFRIANDO   ");
	MOV	#lo_addr(?lstr3_PWM), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;PWM.c,224 :: 		LATBbits.LATB4 = 1;
	BSET.B	LATBbits, #4
;PWM.c,225 :: 		PWM1 = 1;
	BSET.B	LATBbits, #3
;PWM.c,226 :: 		}
L_main28:
;PWM.c,228 :: 		}
L_main26:
;PWM.c,229 :: 		}
	GOTO	L_main19
;PWM.c,230 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
