
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste3.c,19 :: 		void main() {
;teste3.c,21 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste3.c,22 :: 		TRISBbits.TRISB2 = 1;
	BSET.B	TRISBbits, #2
;teste3.c,23 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;teste3.c,24 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;teste3.c,25 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;teste3.c,27 :: 		ADCON1 = 0x0040;
	MOV	#64, W0
	MOV	WREG, ADCON1
;teste3.c,29 :: 		ADCON2 = 0x0004;
	MOV	#4, W0
	MOV	WREG, ADCON2
;teste3.c,30 :: 		ADCON2bits.SMPI = 0;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#195, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;teste3.c,32 :: 		ADCON3 = 0;
	CLR	ADCON3
;teste3.c,34 :: 		ADCSSL = 0;
	CLR	ADCSSL
;teste3.c,35 :: 		ADCHS = 0x0002;
	MOV	#2, W0
	MOV	WREG, ADCHS
;teste3.c,37 :: 		TMR3 = 0x0000;
	CLR	TMR3
;teste3.c,38 :: 		PR3  =  0x3FFF;
	MOV	#16383, W0
	MOV	WREG, PR3
;teste3.c,39 :: 		T3CON = 0x8010;
	MOV	#32784, W0
	MOV	WREG, T3CON
;teste3.c,41 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;teste3.c,42 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;teste3.c,43 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;teste3.c,45 :: 		ADCON1bits.ADON = 1;
	BSET	ADCON1bits, #15
;teste3.c,47 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;teste3.c,49 :: 		while(1){
L_main0:
;teste3.c,50 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	NOP
;teste3.c,51 :: 		while (!ADCON1bits.DONE); // conversion done?
L_main4:
	BTSC	ADCON1bits, #0
	GOTO	L_main5
	GOTO	L_main4
L_main5:
;teste3.c,52 :: 		Valor = ADCBUF0;
	MOV	ADCBUF0, WREG
	MOV	W0, _Valor
;teste3.c,53 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;teste3.c,55 :: 		IntToStr(txt,Valor);
	MOV	_Valor, W11
	MOV	#lo_addr(_txt), W10
	CALL	_IntToStr
;teste3.c,56 :: 		Lcd_Out(1,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;teste3.c,57 :: 		}
	GOTO	L_main0
;teste3.c,58 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
