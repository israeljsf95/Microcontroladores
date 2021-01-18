
_botao_1:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;teste_0_5.c,28 :: 		void botao_1() iv IVT_ADDR_INT0INTERRUPT{
;teste_0_5.c,30 :: 		}
L_end_botao_1:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao_1

_timer_1_conv:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;teste_0_5.c,32 :: 		void timer_1_conv() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{
;teste_0_5.c,33 :: 		T1CON = 0x0000;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	T1CON
;teste_0_5.c,34 :: 		LCD_Out(1,1,"Entrei");
	MOV	#lo_addr(?lstr1_teste_0_5), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;teste_0_5.c,35 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;teste_0_5.c,36 :: 		ADCValue = 0; // clear value
	CLR	W0
	MOV	W0, _ADCValue
;teste_0_5.c,37 :: 		ADC16Ptr = &ADCBUF0; // initialize ADCBUF pointer
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;teste_0_5.c,38 :: 		IFS0bits.ADIF = 0; // clear ADC interrupt flag
	BCLR	IFS0bits, #11
;teste_0_5.c,39 :: 		ADCON1bits.ASAM = 1; // auto start sampling
	BSET.B	ADCON1bits, #2
;teste_0_5.c,41 :: 		while (!IFS0bits.ADIF); // conversion done?
L_timer_1_conv0:
	BTSC	IFS0bits, #11
	GOTO	L_timer_1_conv1
	GOTO	L_timer_1_conv0
L_timer_1_conv1:
;teste_0_5.c,42 :: 		ADCON1bits.ASAM = 0; // yes then stop sample/convert
	BCLR.B	ADCON1bits, #2
;teste_0_5.c,43 :: 		for (count = 0; count < 16; count++) // average the 2 ADC value
	CLR	W0
	MOV	W0, _count
L_timer_1_conv2:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__timer_1_conv9
	GOTO	L_timer_1_conv3
L__timer_1_conv9:
;teste_0_5.c,44 :: 		ADCValue = ADCValue + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_ADCValue), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;teste_0_5.c,43 :: 		for (count = 0; count < 16; count++) // average the 2 ADC value
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;teste_0_5.c,44 :: 		ADCValue = ADCValue + *ADC16Ptr++;
	GOTO	L_timer_1_conv2
L_timer_1_conv3:
;teste_0_5.c,45 :: 		conv = (float)(ADCValue);
	MOV	_ADCValue, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _conv
	MOV	W1, _conv+2
;teste_0_5.c,46 :: 		media = conv/16;
	MOV	#0, W2
	MOV	#16768, W3
	CALL	__Div_FP
	MOV	W0, _media
	MOV	W1, _media+2
;teste_0_5.c,47 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;teste_0_5.c,48 :: 		}
L_end_timer_1_conv:
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
; end of _timer_1_conv

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste_0_5.c,108 :: 		void main() {
;teste_0_5.c,109 :: 		ADPCFG = 0xFFFF; // all PORTB = Digital but RB7 = analog
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste_0_5.c,110 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;teste_0_5.c,111 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;teste_0_5.c,112 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;teste_0_5.c,114 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;teste_0_5.c,115 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;teste_0_5.c,116 :: 		IFS0 = 0;
	CLR	IFS0
;teste_0_5.c,119 :: 		ADCON1 = 0;
	CLR	ADCON1
;teste_0_5.c,120 :: 		ADCON1bits.SSRC = 0b010; // SSRC bit = 111 implies internal
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
;teste_0_5.c,122 :: 		TMR3 = 0x0000;
	CLR	TMR3
;teste_0_5.c,123 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;teste_0_5.c,124 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;teste_0_5.c,128 :: 		ADCHSbits.CH0SA = 0b0010; // Connect RB2/AN2 as CH0 input ..
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;teste_0_5.c,130 :: 		ADCSSL = 0;
	CLR	ADCSSL
;teste_0_5.c,131 :: 		ADCON3 = 0x0007; // Sample time = 15Tad, Tad = intern
	MOV	#7, W0
	MOV	WREG, ADCON3
;teste_0_5.c,132 :: 		ADCON2 = 0;
	CLR	ADCON2
;teste_0_5.c,133 :: 		ADCON2bits.SMPI = 0b1111; // Interrupt after every 16 samples
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;teste_0_5.c,134 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;teste_0_5.c,138 :: 		TMR1 = 0x0000;
	CLR	TMR1
;teste_0_5.c,139 :: 		PR1 = 30048;
	MOV	#30048, W0
	MOV	WREG, PR1
;teste_0_5.c,140 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;teste_0_5.c,141 :: 		T1CONbits.TCKPS = 0b11;
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	[W0], W1
	MOV.B	#48, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	W1, [W0]
;teste_0_5.c,142 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;teste_0_5.c,143 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;teste_0_5.c,146 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;teste_0_5.c,147 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;teste_0_5.c,148 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;teste_0_5.c,150 :: 		while(1){
L_main5:
;teste_0_5.c,151 :: 		Lcd_Out(1,1,"Conv");
	MOV	#lo_addr(?lstr2_teste_0_5), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;teste_0_5.c,152 :: 		FloatToStr(media, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_media, W10
	MOV	_media+2, W11
	CALL	_FloatToStr
;teste_0_5.c,153 :: 		Lcd_Out(2,1, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;teste_0_5.c,154 :: 		}
	GOTO	L_main5
;teste_0_5.c,157 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
