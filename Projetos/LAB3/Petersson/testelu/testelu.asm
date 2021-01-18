
_inicializa:

;testelu.c,23 :: 		void inicializa(){
;testelu.c,24 :: 		ADCON1 = 0;           // controle de sequencia de conversão manual
	CLR	ADCON1
;testelu.c,25 :: 		ADCSSL = 0;           // não é requerida a varredura ou escaneamento
	CLR	ADCSSL
;testelu.c,26 :: 		ADCON2 = 0;           // usa MUXA, AVdd e AVss são usados como Vref+/-
	CLR	ADCON2
;testelu.c,27 :: 		ADCON3 = 0x0007;      // Tad = 4 x Tcy = 4* 62,5ns = 250 ns > 153,85 ns (quando Vdd = 4,5 a 5,5V); SAMC = 0 (não é levado em consideração quando é conversão manual)
	MOV	#7, W0
	MOV	WREG, ADCON3
;testelu.c,28 :: 		ADCON1bits.ADON = 1;  // liga o ADC
	BSET	ADCON1bits, #15
;testelu.c,29 :: 		}
L_end_inicializa:
	RETURN
; end of _inicializa

_leitura:

;testelu.c,31 :: 		int leitura(int canal){
;testelu.c,32 :: 		ADCHSbits.CH0SA = canal;  // seleciona canal de entrada analógica (sample and hold)
	MOV.B	W10, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;testelu.c,33 :: 		ADCON1bits.SAMP = 1;      // começa amostragem
	BSET.B	ADCON1bits, #1
;testelu.c,34 :: 		delay_us(125);            // tempo de amostragem para frequência de 8KHz.
	MOV	#666, W7
L_leitura0:
	DEC	W7
	BRA NZ	L_leitura0
	NOP
	NOP
;testelu.c,35 :: 		ADCON1bits.SAMP = 0;      // começa a conversão
	BCLR.B	ADCON1bits, #1
;testelu.c,36 :: 		while (!ADCON1bits.DONE); // espera que complete a conversão
L_leitura2:
	BTSC	ADCON1bits, #0
	GOTO	L_leitura3
	GOTO	L_leitura2
L_leitura3:
;testelu.c,37 :: 		return ADCBUF0;           // le o resultado da conversão.
	MOV	ADCBUF0, WREG
;testelu.c,38 :: 		}
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

;testelu.c,41 :: 		void main() {
;testelu.c,42 :: 		ADPCFG = 0xFFFF;   // O registrador RB8 está configurado como entrada analógica
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;testelu.c,44 :: 		TRISB = 0;         // define todos os pinos de B como saída (exceto o 8 q será definido como entrada a seguir)
	CLR	TRISB
;testelu.c,46 :: 		sensor = 1;        // pino do sensor (RB8) definido como entrada (de temperatura)
	BSET	TRISBbits, #8
;testelu.c,47 :: 		inicializa();
	CALL	_inicializa
;testelu.c,49 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;testelu.c,50 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;testelu.c,51 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;testelu.c,53 :: 		while(1){
L_main4:
;testelu.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;testelu.c,56 :: 		for(aa = 0; aa < 16; aa++){
	CLR	W0
	MOV	W0, _aa
L_main6:
	MOV	_aa, W0
	CP	W0, #16
	BRA LT	L__main14
	GOTO	L_main7
L__main14:
;testelu.c,57 :: 		leitura(8);                       // lê o canal 8 (onde está o sensor)
	MOV	#8, W10
	CALL	_leitura
;testelu.c,58 :: 		armazena = ADCBUF0;               //aqui ele armazena no buffer o valor medido pelo sensor (em tensão)
	MOV	ADCBUF0, WREG
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _armazena
	MOV	W1, _armazena+2
;testelu.c,59 :: 		temperatura += (float)((armazena*5)/1023);  //faz o calculo da temperatura
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	_temperatura, W2
	MOV	_temperatura+2, W3
	CALL	__AddSub_FP
	MOV	W0, _temperatura
	MOV	W1, _temperatura+2
;testelu.c,56 :: 		for(aa = 0; aa < 16; aa++){
	MOV	#1, W1
	MOV	#lo_addr(_aa), W0
	ADD	W1, [W0], [W0]
;testelu.c,62 :: 		}
	GOTO	L_main6
L_main7:
;testelu.c,64 :: 		media_temp = temperatura/16;
	MOV	#0, W2
	MOV	#16768, W3
	MOV	_temperatura, W0
	MOV	_temperatura+2, W1
	CALL	__Div_FP
	MOV	W0, _media_temp
	MOV	W1, _media_temp+2
;testelu.c,65 :: 		FloatToStr(media_temp,txt);
	MOV	#lo_addr(_txt), W12
	MOV.D	W0, W10
	CALL	_FloatToStr
;testelu.c,67 :: 		Lcd_Out(1,1,"Temperatura");
	MOV	#lo_addr(?lstr1_testelu), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;testelu.c,68 :: 		Lcd_Out(2,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;testelu.c,69 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main9:
	DEC	W7
	BRA NZ	L_main9
	DEC	W8
	BRA NZ	L_main9
;testelu.c,70 :: 		}
	GOTO	L_main4
;testelu.c,75 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
