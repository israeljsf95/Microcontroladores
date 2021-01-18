
_PWM:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;PWM_Motor.c,26 :: 		void PWM() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;PWM_Motor.c,27 :: 		if (flag == 0){
	PUSH	W10
	PUSH	W11
	MOV	_flag, W0
	CP	W0, #0
	BRA Z	L__PWM11
	GOTO	L_PWM0
L__PWM11:
;PWM_Motor.c,28 :: 		PR1 = floor(32000*convertido/1023);
	MOV	#32000, W1
	MOV	#lo_addr(_convertido), W0
	MUL.SS	W1, [W0], W4
	MOV	#1023, W2
	REPEAT	#17
	DIV.S	W4, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR1
;PWM_Motor.c,29 :: 		}else{
	GOTO	L_PWM1
L_PWM0:
;PWM_Motor.c,30 :: 		PR1 = floor(32000*(1 - convertido/1023));
	MOV	_convertido, W0
	MOV	#1023, W2
	REPEAT	#17
	DIV.S	W0, W2
	SUBR	W0, #1, W1
	MOV	#32000, W0
	MUL.SS	W0, W1, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, PR1
;PWM_Motor.c,31 :: 		}
L_PWM1:
;PWM_Motor.c,32 :: 		flag =~flag;
	MOV	#lo_addr(_flag), W0
	COM	[W0], [W0]
;PWM_Motor.c,33 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;PWM_Motor.c,34 :: 		}
L_end_PWM:
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _PWM

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;PWM_Motor.c,36 :: 		void main() {
;PWM_Motor.c,37 :: 		flag =0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	W0
	MOV	W0, _flag
;PWM_Motor.c,38 :: 		ADPCFG = 0xFEFF;//PINO RB8 como entrada analogica
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;PWM_Motor.c,39 :: 		TRISB = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, TRISB
;PWM_Motor.c,41 :: 		IFS0 = 0;
	CLR	IFS0
;PWM_Motor.c,42 :: 		TMR1 = 0;
	CLR	TMR1
;PWM_Motor.c,43 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;PWM_Motor.c,44 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;PWM_Motor.c,45 :: 		PR1 =  32000;
	MOV	#32000, W0
	MOV	WREG, PR1
;PWM_Motor.c,48 :: 		ADCON1 = 0;
	CLR	ADCON1
;PWM_Motor.c,51 :: 		ADCON2 = 0;
	CLR	ADCON2
;PWM_Motor.c,54 :: 		ADCON3 = 0x0007; // Tad  = 4*Tcy = 4*62.5ns = 250ns > 153.85ns (qnd Vdd = 4.5 a 5.5v)
	MOV	#7, W0
	MOV	WREG, ADCON3
;PWM_Motor.c,55 :: 		ADCON3 = 0x000B; // Tad  = 6*Tcy = 6*62.5ns = 375ns > 256.41ns (qnd Vdd = 3 a 5.5v)
	MOV	#11, W0
	MOV	WREG, ADCON3
;PWM_Motor.c,58 :: 		ADCHS = 0x0000;
	CLR	ADCHS
;PWM_Motor.c,59 :: 		ADCHSbits.CH0SA = 8; // seleciona a entrada analogica 8
	MOV.B	#8, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;PWM_Motor.c,61 :: 		ADCSSL = 0;
	CLR	ADCSSL
;PWM_Motor.c,62 :: 		ADCON1bits.ADON = 1; //Ativa o ADC
	BSET	ADCON1bits, #15
;PWM_Motor.c,65 :: 		Lcd_Init();                // Inicializa o LCD
	CALL	_Lcd_Init
;PWM_Motor.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;PWM_Motor.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;PWM_Motor.c,69 :: 		while(1){
L_main2:
;PWM_Motor.c,70 :: 		ADCON1bits.SAMP = 1; //Inicia a amostragem
	BSET.B	ADCON1bits, #1
;PWM_Motor.c,71 :: 		delay_us(10); // Espera a amostragem
	MOV	#53, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	NOP
;PWM_Motor.c,72 :: 		ADCON1bits.SAMP = 0; //para a amostragem e inicia a conversao
	BCLR.B	ADCON1bits, #1
;PWM_Motor.c,73 :: 		while(!ADCON1bits.DONE); // Aguarda o fim da conversao
L_main6:
	BTSC	ADCON1bits, #0
	GOTO	L_main7
	GOTO	L_main6
L_main7:
;PWM_Motor.c,74 :: 		convertido = ADCBUF0; // Ler o valor convertido no canal 0 do  ADC
	MOV	ADCBUF0, WREG
	MOV	W0, _convertido
;PWM_Motor.c,75 :: 		tensao = (convertido*5.0)/1023; //Calculo da tensao de entrada
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
;PWM_Motor.c,76 :: 		PWM_1 = floor(tensao*20);
	MOV	#0, W2
	MOV	#16800, W3
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	MOV	W0, _PWM_1
	MOV	W1, _PWM_1+2
;PWM_Motor.c,78 :: 		FloatToStr(tensao, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_tensao, W10
	MOV	_tensao+2, W11
	CALL	_FloatToStr
;PWM_Motor.c,79 :: 		IntToStr(PWM_1, txt2);
	MOV	_PWM_1, W0
	MOV	_PWM_1+2, W1
	CALL	__Float2Longint
	MOV	#lo_addr(_txt2), W11
	MOV	W0, W10
	CALL	_IntToStr
;PWM_Motor.c,80 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;PWM_Motor.c,81 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;PWM_Motor.c,82 :: 		Lcd_Out(1,1, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;PWM_Motor.c,83 :: 		Lcd_Out(2,1, txt2);
	MOV	#lo_addr(_txt2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;PWM_Motor.c,84 :: 		delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
;PWM_Motor.c,85 :: 		}
	GOTO	L_main2
;PWM_Motor.c,86 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
