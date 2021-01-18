
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ADC1.c,20 :: 		void main() {
;ADC1.c,21 :: 		ADPCFG = 0xFEFF;//PINO RB8 como entrada analogica
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;ADC1.c,22 :: 		TRISB = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, TRISB
;ADC1.c,24 :: 		ADCON1 = 0;
	CLR	ADCON1
;ADC1.c,27 :: 		ADCON2 = 0;
	CLR	ADCON2
;ADC1.c,30 :: 		ADCON3 = 0x0007; // Tad  = 4*Tcy = 4*62.5ns = 250ns > 153.85ns (qnd Vdd = 4.5 a 5.5v)
	MOV	#7, W0
	MOV	WREG, ADCON3
;ADC1.c,31 :: 		ADCON3 = 0x000B; // Tad  = 6*Tcy = 6*62.5ns = 375ns > 256.41ns (qnd Vdd = 3 a 5.5v)
	MOV	#11, W0
	MOV	WREG, ADCON3
;ADC1.c,34 :: 		ADCHS = 0x0000;
	CLR	ADCHS
;ADC1.c,35 :: 		ADCHSbits.CH0SA = 8; // seleciona a entrada analogica 8
	MOV.B	#8, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;ADC1.c,37 :: 		ADCSSL = 0;
	CLR	ADCSSL
;ADC1.c,38 :: 		ADCON1bits.ADON = 1; //Ativa o ADC
	BSET	ADCON1bits, #15
;ADC1.c,41 :: 		Lcd_Init();                // Inicializa o LCD
	CALL	_Lcd_Init
;ADC1.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;ADC1.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;ADC1.c,45 :: 		while(1){
L_main0:
;ADC1.c,46 :: 		ADCON1bits.SAMP = 1; //Inicia a amostragem
	BSET.B	ADCON1bits, #1
;ADC1.c,47 :: 		delay_us(10); // Espera a amostragem
	MOV	#53, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	NOP
;ADC1.c,48 :: 		ADCON1bits.SAMP = 0; //para a amostragem e inicia a conversao
	BCLR.B	ADCON1bits, #1
;ADC1.c,49 :: 		while(!ADCON1bits.DONE); // Aguarda o fim da conversao
L_main4:
	BTSC	ADCON1bits, #0
	GOTO	L_main5
	GOTO	L_main4
L_main5:
;ADC1.c,50 :: 		convertido = ADCBUF0; // Ler o valor convertido no canal 0 do  ADC
	MOV	ADCBUF0, WREG
	MOV	W0, _convertido
;ADC1.c,51 :: 		tensao = (convertido*5.0)/1023; //Calculo da tensao de entrada
	MOV	_convertido, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _tensao
	MOV	W1, _tensao+2
;ADC1.c,52 :: 		FloatToStr(tensao, txt);
	MOV	#lo_addr(_txt), W12
	MOV.D	W0, W10
	CALL	_FloatToStr
;ADC1.c,53 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;ADC1.c,54 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;ADC1.c,55 :: 		Lcd_Out(1,1, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;ADC1.c,56 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	DEC	W8
	BRA NZ	L_main6
;ADC1.c,57 :: 		}
	GOTO	L_main0
;ADC1.c,62 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
