
_temporizador:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,67 :: 		void temporizador() iv IVT_ADDR_T1INTERRUPT {
;Q1.c,68 :: 		contador_tempo++;
	MOV	#1, W1
	MOV	#lo_addr(_contador_tempo), W0
	ADD	W1, [W0], [W0]
;Q1.c,69 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;Q1.c,70 :: 		}
L_end_temporizador:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _temporizador

_conversao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,75 :: 		void conversao() iv IVT_ADDR_ADCINTERRUPT {//botao para selecao do menu
;Q1.c,79 :: 		media = ADCBUFF;
	MOV	ADCBUFF, WREG
	CLR	W1
	MOV	W0, _media
	MOV	W1, _media+2
;Q1.c,82 :: 		convertido[flag_ADC] = media;
	MOV	_flag_ADC, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_convertido), W0
	ADD	W0, W1, W1
	MOV	_media, W0
	MOV	W0, [W1]
;Q1.c,84 :: 		flag_ADC++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_ADC), W0
	ADD	W1, [W0], [W0]
;Q1.c,86 :: 		if (flag_ADC > 2){
	MOV	_flag_ADC, W0
	CP	W0, #2
	BRA GT	L__conversao14
	GOTO	L_conversao0
L__conversao14:
;Q1.c,87 :: 		flag_ADC = 0;
	CLR	W0
	MOV	W0, _flag_ADC
;Q1.c,88 :: 		}
L_conversao0:
;Q1.c,90 :: 		if (flag_ADC == 0){
	MOV	_flag_ADC, W0
	CP	W0, #0
	BRA Z	L__conversao15
	GOTO	L_conversao1
L__conversao15:
;Q1.c,91 :: 		ADCHSbits.CH0SA = 2;
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q1.c,92 :: 		}else{
	GOTO	L_conversao2
L_conversao1:
;Q1.c,93 :: 		if (flag_ADC == 1){
	MOV	_flag_ADC, W0
	CP	W0, #1
	BRA Z	L__conversao16
	GOTO	L_conversao3
L__conversao16:
;Q1.c,94 :: 		ADCHSbits.CH0SA = 5;
	MOV.B	#5, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q1.c,95 :: 		}else{
	GOTO	L_conversao4
L_conversao3:
;Q1.c,96 :: 		ADCHSbits.CH0SA = 7;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q1.c,97 :: 		}
L_conversao4:
;Q1.c,98 :: 		}
L_conversao2:
;Q1.c,100 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;Q1.c,101 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;Q1.c,102 :: 		}
L_end_conversao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _conversao

_botao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,104 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT {//botao para selecao do menu
;Q1.c,105 :: 		flag_botao++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_botao), W0
	ADD	W1, [W0], [W0]
;Q1.c,106 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;Q1.c,107 :: 		flag_seleciona = 0;
	CLR	W0
	MOV	W0, _flag_seleciona
;Q1.c,108 :: 		if (flag_botao > 4){
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA GT	L__botao18
	GOTO	L_botao5
L__botao18:
;Q1.c,109 :: 		flag_botao = 0;
	CLR	W0
	MOV	W0, _flag_botao
;Q1.c,110 :: 		}
L_botao5:
;Q1.c,111 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao6:
	DEC	W7
	BRA NZ	L_botao6
	DEC	W8
	BRA NZ	L_botao6
;Q1.c,112 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;Q1.c,113 :: 		}
L_end_botao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao

_seleciona:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,115 :: 		void seleciona() iv IVT_ADDR_INT2INTERRUPT {
;Q1.c,116 :: 		flag_seleciona = 1;
	MOV	#1, W0
	MOV	W0, _flag_seleciona
;Q1.c,117 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;Q1.c,118 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_seleciona8:
	DEC	W7
	BRA NZ	L_seleciona8
	DEC	W8
	BRA NZ	L_seleciona8
;Q1.c,119 :: 		IFS1bits.INT2IF = 0;
	BCLR.B	IFS1bits, #7
;Q1.c,120 :: 		}
L_end_seleciona:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _seleciona

_temp3:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q1.c,122 :: 		void temp3() iv IVT_ADDR_T3INTERRUPT ics ICS_AUTO {
;Q1.c,123 :: 		IFS0bits.T3IF = 0;
	BCLR.B	IFS0bits, #7
;Q1.c,124 :: 		}
L_end_temp3:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _temp3

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Q1.c,126 :: 		int main() {
;Q1.c,128 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q1.c,129 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;Q1.c,130 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;Q1.c,131 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;Q1.c,133 :: 		TRISB = 0;
	CLR	TRISB
;Q1.c,134 :: 		porta_LDR = 1;
	BSET.B	LATBbits, #5
;Q1.c,135 :: 		porta_potenciometro = 1;
	BSET.B	LATBbits, #7
;Q1.c,136 :: 		porta_temperatura = 1;
	BSET.B	LATBbits, #2
;Q1.c,138 :: 		TRISD = 0;
	CLR	TRISD
;Q1.c,139 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;Q1.c,140 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;Q1.c,141 :: 		IEC0bits.INT0IE = 1;//Ativando interrupçao do botao
	BSET.B	IEC0bits, #0
;Q1.c,142 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;Q1.c,143 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;Q1.c,144 :: 		IEC0bits.T3IE = 1;
	BSET.B	IEC0bits, #7
;Q1.c,146 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;Q1.c,147 :: 		PR1 = 31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;Q1.c,148 :: 		IFS0 = 0;
	CLR	IFS0
;Q1.c,150 :: 		ADCHS = 0;
	CLR	ADCHS
;Q1.c,152 :: 		ADCHSbits.CH0SA = 2;
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q1.c,154 :: 		ADCSSL = 0;
	CLR	ADCSSL
;Q1.c,156 :: 		ADCON1 = 0x0000;
	CLR	ADCON1
;Q1.c,158 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;Q1.c,159 :: 		ADCON1bits.SSRC = 0b010;
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
;Q1.c,161 :: 		ADCON2 = 0x0000;
	CLR	ADCON2
;Q1.c,163 :: 		ADCON2bits.SMPI0 = 1;
	BSET.B	ADCON2bits, #2
;Q1.c,164 :: 		ADCON2bits.SMPI1 = 1;
	BSET.B	ADCON2bits, #3
;Q1.c,165 :: 		ADCON2bits.SMPI2 = 1;
	BSET.B	ADCON2bits, #4
;Q1.c,166 :: 		ADCON2bits.SMPI3 = 1;
	BSET.B	ADCON2bits, #5
;Q1.c,168 :: 		ADCON3 = 0x0000;
	CLR	ADCON3
;Q1.c,169 :: 		ADCON3bits.ADCS = 7;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV.B	#63, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCON3bits), W0
	MOV.B	W1, [W0]
;Q1.c,172 :: 		TMR3 = 0x0000;
	CLR	TMR3
;Q1.c,173 :: 		PR3  =  500;
	MOV	#500, W0
	MOV	WREG, PR3
;Q1.c,174 :: 		T3CON = 0x8010;
	MOV	#32784, W0
	MOV	WREG, T3CON
;Q1.c,176 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;Q1.c,177 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q1.c,178 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;Q1.c,180 :: 		ADCON1bits.ADON = 1;
	BSET	ADCON1bits, #15
;Q1.c,181 :: 		ADCON1bits.SAMP = 1;
	BSET.B	ADCON1bits, #1
;Q1.c,182 :: 		while(1){
L_main10:
;Q1.c,245 :: 		IntToStr(convertido[0],txt4);
	MOV	#lo_addr(_txt4), W11
	MOV	_convertido, W10
	CALL	_IntToStr
;Q1.c,246 :: 		IntToStr(convertido[1],txt2);
	MOV	#lo_addr(_txt2), W11
	MOV	_convertido+2, W10
	CALL	_IntToStr
;Q1.c,247 :: 		IntToStr(convertido[2],txt3);
	MOV	#lo_addr(_txt3), W11
	MOV	_convertido+4, W10
	CALL	_IntToStr
;Q1.c,249 :: 		Lcd_Out(1,1,txt4);
	MOV	#lo_addr(_txt4), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q1.c,250 :: 		Lcd_Out(1,8,txt2);
	MOV	#lo_addr(_txt2), W12
	MOV	#8, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q1.c,251 :: 		Lcd_Out(2,1,txt3);
	MOV	#lo_addr(_txt3), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q1.c,254 :: 		}
	GOTO	L_main10
;Q1.c,255 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
