
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste.c,23 :: 		void main(){
;teste.c,24 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste.c,25 :: 		ADPCFGbits.PCFG7 = 1;
	BSET.B	ADPCFGbits, #7
;teste.c,27 :: 		TRISB = 0;
	CLR	TRISB
;teste.c,28 :: 		TRISBbits.TRISB7 = 1;
	BSET.B	TRISBbits, #7
;teste.c,30 :: 		ADCON1 = 0x0000;
	CLR	ADCON1
;teste.c,31 :: 		ADCON2 = 0x0000;
	CLR	ADCON2
;teste.c,32 :: 		ADCON3 = 0x0000;
	CLR	ADCON3
;teste.c,34 :: 		ADCON2bits.VCFG = 0;
	MOV	ADCON2bits, W1
	MOV	#8191, W0
	AND	W1, W0, W0
	MOV	WREG, ADCON2bits
;teste.c,35 :: 		ADCON3bits.ADCS = 7;
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
;teste.c,36 :: 		ADCON2bits.CHPS = 0;
	MOV	ADCON2bits, W1
	MOV	#64767, W0
	AND	W1, W0, W0
	MOV	WREG, ADCON2bits
;teste.c,37 :: 		ADCON1bits.SIMSAM = 0;
	BCLR.B	ADCON1bits, #3
;teste.c,38 :: 		ADCSSL = 0;
	CLR	ADCSSL
;teste.c,39 :: 		ADCHS = 0;
	CLR	ADCHS
;teste.c,40 :: 		ADCHSbits.CH0SA = 0x0111;
	MOV.B	#17, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;teste.c,41 :: 		ADCON1bits.SSRC = 2;
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
;teste.c,42 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;teste.c,43 :: 		ADCON3bits.SAMC = 1;
	MOV	#256, W0
	MOV	W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR	W1, [W0], W1
	MOV	#7936, W0
	AND	W1, W0, W1
	MOV	#lo_addr(ADCON3bits), W0
	XOR	W1, [W0], W1
	MOV	W1, ADCON3bits
;teste.c,44 :: 		ADCON1bits.FORM = 0;
	MOV	ADCON1bits, W1
	MOV	#64767, W0
	AND	W1, W0, W0
	MOV	WREG, ADCON1bits
;teste.c,45 :: 		ADCON2bits.SMPI = 15;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;teste.c,47 :: 		TMR3 = 0x0000;
	CLR	TMR3
;teste.c,48 :: 		PR3  =  500;
	MOV	#500, W0
	MOV	WREG, PR3
;teste.c,49 :: 		T3CON = 0x8010;
	MOV	#32784, W0
	MOV	WREG, T3CON
;teste.c,51 :: 		ADCON1bits.ADON = 1;
	BSET	ADCON1bits, #15
;teste.c,53 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;teste.c,54 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;teste.c,55 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;teste.c,57 :: 		while(1){
L_main0:
;teste.c,58 :: 		while(!ADCON1bits.DONE){
L_main2:
	BTSC	ADCON1bits, #0
	GOTO	L_main3
;teste.c,59 :: 		ADCValue = ADCBUF5;
	MOV	ADCBUF5, WREG
	MOV	W0, _ADCValue
;teste.c,60 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;teste.c,61 :: 		}
	GOTO	L_main2
L_main3:
;teste.c,62 :: 		tensao = ADCValue;
	MOV	_ADCValue, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _tensao
	MOV	W1, _tensao+2
;teste.c,63 :: 		FloatToStr(tensao,txt);
	MOV	#lo_addr(_txt), W12
	MOV.D	W0, W10
	CALL	_FloatToStr
;teste.c,64 :: 		Lcd_Out(2,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;teste.c,65 :: 		}
	GOTO	L_main0
;teste.c,66 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
