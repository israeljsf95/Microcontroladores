
_BOTAO1int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q3.c,28 :: 		void BOTAO1int() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;Q3.c,29 :: 		delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_BOTAO1int0:
	DEC	W7
	BRA NZ	L_BOTAO1int0
	DEC	W8
	BRA NZ	L_BOTAO1int0
;Q3.c,30 :: 		ADCValue = 0; // valor que guadara a convesao
	CLR	W0
	MOV	W0, _ADCValue
;Q3.c,31 :: 		ADC16Ptr = &ADCBUF1; // recebe o endereco de memoria do BUF0 do modulo AD
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;Q3.c,32 :: 		IFS0bits.ADIF = 0; // flag AD recebe zero
	BCLR	IFS0bits, #11
;Q3.c,33 :: 		ADCON1bits.ASAM = 1; // Auto amostragem
	BSET.B	ADCON1bits, #2
;Q3.c,35 :: 		while (!IFS0bits.ADIF); // Espera a conversao ser feita
L_BOTAO1int2:
	BTSC	IFS0bits, #11
	GOTO	L_BOTAO1int3
	GOTO	L_BOTAO1int2
L_BOTAO1int3:
;Q3.c,36 :: 		ADCON1bits.ASAM = 0; // faz o modulo parar a conversao
	BCLR.B	ADCON1bits, #2
;Q3.c,37 :: 		for (count = 1; count < 16; count++) // Adicao dos valores em cada conversao
	MOV	#1, W0
	MOV	W0, _count
L_BOTAO1int4:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__BOTAO1int24
	GOTO	L_BOTAO1int5
L__BOTAO1int24:
;Q3.c,38 :: 		ADCValue = ADCValue + *ADC16Ptr++; //Acessando o valor dos buff usando aritmetica de ponteiro acessando o valor guardado atraves do operador de desreferencia(*)
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_ADCValue), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;Q3.c,37 :: 		for (count = 1; count < 16; count++) // Adicao dos valores em cada conversao
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;Q3.c,38 :: 		ADCValue = ADCValue + *ADC16Ptr++; //Acessando o valor dos buff usando aritmetica de ponteiro acessando o valor guardado atraves do operador de desreferencia(*)
	GOTO	L_BOTAO1int4
L_BOTAO1int5:
;Q3.c,39 :: 		conversao = (float)(ADCValue);
	MOV	_ADCValue, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _conversao
	MOV	W1, _conversao+2
;Q3.c,40 :: 		media_temp  = conversao/15;
	MOV	#0, W2
	MOV	#16752, W3
	CALL	__Div_FP
	MOV	W0, _media_temp
	MOV	W1, _media_temp+2
;Q3.c,41 :: 		temperatura = 100*((media_temp*5)/1023);
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Mul_FP
	MOV	W0, _temperatura
	MOV	W1, _temperatura+2
;Q3.c,42 :: 		fahr =    (9/5)*temperatura + 32;
	MOV	#0, W2
	MOV	#16896, W3
	CALL	__AddSub_FP
	MOV	W0, _fahr
	MOV	W1, _fahr+2
;Q3.c,43 :: 		kel = temperatura + 273;
	MOV	_temperatura, W2
	MOV	_temperatura+2, W3
	MOV	#32768, W0
	MOV	#17288, W1
	CALL	__AddSub_FP
	MOV	W0, _kel
	MOV	W1, _kel+2
;Q3.c,44 :: 		IFS0.INT0IF = 0;
	BCLR.B	IFS0, #0
;Q3.c,46 :: 		}
L_end_BOTAO1int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _BOTAO1int

_BOTAO2int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Q3.c,50 :: 		void BOTAO2int() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
;Q3.c,51 :: 		delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_BOTAO2int7:
	DEC	W7
	BRA NZ	L_BOTAO2int7
	DEC	W8
	BRA NZ	L_BOTAO2int7
;Q3.c,52 :: 		IFS1bits.INT2IF = 0;
	BCLR.B	IFS1bits, #7
;Q3.c,53 :: 		flag_bot++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_bot), W0
	ADD	W1, [W0], [W0]
;Q3.c,54 :: 		if (flag_bot>1){
	MOV	_flag_bot, W0
	CP	W0, #1
	BRA GT	L__BOTAO2int26
	GOTO	L_BOTAO2int9
L__BOTAO2int26:
;Q3.c,55 :: 		flag_bot = 0;
	CLR	W0
	MOV	W0, _flag_bot
;Q3.c,56 :: 		}
L_BOTAO2int9:
;Q3.c,57 :: 		}
L_end_BOTAO2int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _BOTAO2int

_inicializa:

;Q3.c,60 :: 		void inicializa(){
;Q3.c,61 :: 		ADCON1 = 0;           // controle de sequencia de conversão manual
	CLR	ADCON1
;Q3.c,62 :: 		ADCSSL = 0;           // não é requerida a varredura ou escaneamento
	CLR	ADCSSL
;Q3.c,63 :: 		ADCON2 = 0;           // usa MUXA, AVdd e AVss são usados como Vref+/-
	CLR	ADCON2
;Q3.c,64 :: 		ADCON3 = 0x0007;      // Tad = 4 x Tcy = 4* 62,5ns = 250 ns > 153,85 ns (quando Vdd = 4,5 a 5,5V); SAMC = 0 (não é levado em consideração quando é conversão manual)
	MOV	#7, W0
	MOV	WREG, ADCON3
;Q3.c,65 :: 		ADCON1bits.ADON = 1;  // liga o ADC
	BSET	ADCON1bits, #15
;Q3.c,66 :: 		}
L_end_inicializa:
	RETURN
; end of _inicializa

_leitura:

;Q3.c,68 :: 		int leitura(int canal){
;Q3.c,69 :: 		ADCHSbits.CH0SA = canal;  // seleciona canal de entrada analógica (sample and hold)
	MOV.B	W10, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;Q3.c,70 :: 		ADCON1bits.SAMP = 1;      // começa amostragem
	BSET.B	ADCON1bits, #1
;Q3.c,71 :: 		delay_us(125);            // tempo de amostragem para frequência de 8KHz.
	MOV	#666, W7
L_leitura10:
	DEC	W7
	BRA NZ	L_leitura10
	NOP
	NOP
;Q3.c,72 :: 		ADCON1bits.SAMP = 0;      // começa a conversão
	BCLR.B	ADCON1bits, #1
;Q3.c,73 :: 		while (!ADCON1bits.DONE); // espera que complete a conversão
L_leitura12:
	BTSC	ADCON1bits, #0
	GOTO	L_leitura13
	GOTO	L_leitura12
L_leitura13:
;Q3.c,74 :: 		return ADCBUF0;           // le o resultado da conversão.
	MOV	ADCBUF0, WREG
;Q3.c,75 :: 		}
L_end_leitura:
	RETURN
; end of _leitura

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Q3.c,78 :: 		void main() {
;Q3.c,79 :: 		ADPCFG = 0xFFFF;                // Todas as portas digitais
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q3.c,80 :: 		ADPCFGbits.PCFG2 = 0;           // PORTA 8 ANALOGICA
	BCLR.B	ADPCFGbits, #2
;Q3.c,82 :: 		sensor = 1;
	BSET.B	TRISBbits, #2
;Q3.c,83 :: 		TRISEbits.TRISE8 = 1;         //SETANDO COMO ENTRADA PARA O BOTAO
	BSET	TRISEbits, #8
;Q3.c,84 :: 		IEC0bits.INT0IE = 1;          //ATIVANDO A INTErrupcao externa int0
	BSET.B	IEC0bits, #0
;Q3.c,85 :: 		IEC1bits.INT2IE = 1;          //ATIVANDO A INTErrupcao externa int2
	BSET.B	IEC1bits, #7
;Q3.c,86 :: 		IFS0 = 0;
	CLR	IFS0
;Q3.c,87 :: 		INTCON2 = 0;
	CLR	INTCON2
;Q3.c,88 :: 		INTCON2bits.INT0EP = 1;       //ATIVADO NA BORDA de DESCIDA
	BSET.B	INTCON2bits, #0
;Q3.c,89 :: 		INTCON2bits.INT2EP = 0;       //ATIVADO NA BORDA de SUBIDA
	BCLR.B	INTCON2bits, #2
;Q3.c,90 :: 		IFS0bits.INT0IF = 0;          //ZErando a flag da int0
	BCLR.B	IFS0bits, #0
;Q3.c,91 :: 		IFS1bits.INT2IF = 0;          //ZErando a flag da int2
	BCLR.B	IFS1bits, #7
;Q3.c,93 :: 		ADCON1 = 0;
	CLR	ADCON1
;Q3.c,94 :: 		ADCON1bits.SSRC = 0b010; // SSRC bit = Sinca  clock de conversao do modulo AD com o TIMER 3
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
;Q3.c,96 :: 		TMR3 = 0x0000;
	CLR	TMR3
;Q3.c,97 :: 		PR3 = 16000;
	MOV	#16000, W0
	MOV	WREG, PR3
;Q3.c,98 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;Q3.c,102 :: 		ADCHS = 0x0002; // Conectando a entrada 8 ao canal 0 para conversao
	MOV	#2, W0
	MOV	WREG, ADCHS
;Q3.c,104 :: 		ADCSSL = 0;
	CLR	ADCSSL
;Q3.c,105 :: 		ADCON3 = 0x0007; // Periodo de Amostragem
	MOV	#7, W0
	MOV	WREG, ADCON3
;Q3.c,106 :: 		ADCON2 = 0;
	CLR	ADCON2
;Q3.c,107 :: 		ADCON2bits.SMPI = 0b1111; // Configuracao para fazer 16 conversoes e libera a flag do AD
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;Q3.c,108 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;Q3.c,109 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;Q3.c,110 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q3.c,111 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;Q3.c,112 :: 		Lcd_Out(1,1,"Temperatura");
	MOV	#lo_addr(?lstr1_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q3.c,114 :: 		while(1){
L_main14:
;Q3.c,115 :: 		if (flag_bot == 0){
	MOV	_flag_bot, W0
	CP	W0, #0
	BRA Z	L__main30
	GOTO	L_main16
L__main30:
;Q3.c,116 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q3.c,117 :: 		Lcd_Out(1,1,"Temperatura");
	MOV	#lo_addr(?lstr2_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q3.c,118 :: 		FloatToStr(temperatura, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_temperatura, W10
	MOV	_temperatura+2, W11
	CALL	_FloatToStr
;Q3.c,119 :: 		txt[5]=0;
	MOV	#lo_addr(_txt+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;Q3.c,120 :: 		Lcd_Out(2,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,121 :: 		Lcd_Out(2,7,"Celsius");
	MOV	#lo_addr(?lstr3_Q3), W12
	MOV	#7, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,122 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main17:
	DEC	W7
	BRA NZ	L_main17
	DEC	W8
	BRA NZ	L_main17
;Q3.c,123 :: 		}else if (flag_bot == 1){
	GOTO	L_main19
L_main16:
	MOV	_flag_bot, W0
	CP	W0, #1
	BRA Z	L__main31
	GOTO	L_main20
L__main31:
;Q3.c,124 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;Q3.c,125 :: 		Lcd_Out(1,1,"Temp:");
	MOV	#lo_addr(?lstr4_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q3.c,126 :: 		FloatToStr(temperatura, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_temperatura, W10
	MOV	_temperatura+2, W11
	CALL	_FloatToStr
;Q3.c,127 :: 		txt[5]=0;
	MOV	#lo_addr(_txt+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;Q3.c,128 :: 		Lcd_Out(1,7,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#7, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q3.c,129 :: 		Lcd_Out(1,11,"C");
	MOV	#lo_addr(?lstr5_Q3), W12
	MOV	#11, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;Q3.c,130 :: 		FloatToStr(fahr, txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	_fahr, W10
	MOV	_fahr+2, W11
	CALL	_FloatToStr
;Q3.c,131 :: 		txt1[5]=0;
	MOV	#lo_addr(_txt1+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;Q3.c,132 :: 		Lcd_Out(2,1,txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,133 :: 		Lcd_Out(2,7,"F");
	MOV	#lo_addr(?lstr6_Q3), W12
	MOV	#7, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,134 :: 		FloatToStr(kel, txt2);
	MOV	#lo_addr(_txt2), W12
	MOV	_kel, W10
	MOV	_kel+2, W11
	CALL	_FloatToStr
;Q3.c,135 :: 		txt2[5]=0;
	MOV	#lo_addr(_txt2+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;Q3.c,136 :: 		Lcd_Out(2,9,txt2);
	MOV	#lo_addr(_txt2), W12
	MOV	#9, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,137 :: 		Lcd_Out(2,14,"K");
	MOV	#lo_addr(?lstr7_Q3), W12
	MOV	#14, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;Q3.c,138 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main21:
	DEC	W7
	BRA NZ	L_main21
	DEC	W8
	BRA NZ	L_main21
;Q3.c,139 :: 		}
L_main20:
L_main19:
;Q3.c,141 :: 		}
	GOTO	L_main14
;Q3.c,142 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
