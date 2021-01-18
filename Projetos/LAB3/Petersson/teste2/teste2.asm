
_botao_tempo:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;teste2.c,24 :: 		void botao_tempo() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;teste2.c,25 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;teste2.c,26 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao_tempo0:
	DEC	W7
	BRA NZ	L_botao_tempo0
	DEC	W8
	BRA NZ	L_botao_tempo0
;teste2.c,27 :: 		}
L_end_botao_tempo:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao_tempo

_intADC:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;teste2.c,31 :: 		void intADC() iv IVT_ADDR_ADCINTERRUPT ics ICS_AUTO {
;teste2.c,70 :: 		}
L_end_intADC:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _intADC

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste2.c,72 :: 		void main() {
;teste2.c,73 :: 		flag_canal = 0;
	PUSH	W10
	CLR	W0
	MOV	W0, _flag_canal
;teste2.c,75 :: 		ADPCFG = 0xFFFF; // all PORTB = Digital but RB7 = analog
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste2.c,76 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;teste2.c,77 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;teste2.c,78 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;teste2.c,80 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;teste2.c,81 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;teste2.c,82 :: 		IFS0 = 0;
	CLR	IFS0
;teste2.c,85 :: 		ADCON1 = 0;
	CLR	ADCON1
;teste2.c,86 :: 		ADCON1bits.SSRC = 0b010; // SSRC bit = 111 implies internal
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
;teste2.c,88 :: 		TMR3 = 0x0000;
	CLR	TMR3
;teste2.c,89 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;teste2.c,90 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;teste2.c,94 :: 		ADCHS = 0x0002; // Connect RB2/AN2 as CH0 input ..
	MOV	#2, W0
	MOV	WREG, ADCHS
;teste2.c,96 :: 		ADCSSL = 0;
	CLR	ADCSSL
;teste2.c,97 :: 		ADCON3 = 0x0007; // Sample time = 15Tad, Tad = intern
	MOV	#7, W0
	MOV	WREG, ADCON3
;teste2.c,98 :: 		ADCON2 = 0;
	CLR	ADCON2
;teste2.c,99 :: 		ADCON2bits.SMPI = 0b1111; // Interrupt after every 2 samples
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;teste2.c,101 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;teste2.c,104 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;teste2.c,105 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;teste2.c,106 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;teste2.c,108 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;teste2.c,109 :: 		while (1) // repeat continuously
L_main2:
;teste2.c,111 :: 		ADCValue = 0; // clear value
	CLR	W0
	MOV	W0, _ADCValue
;teste2.c,112 :: 		ADC16Ptr = &ADCBUF0; // initialize ADCBUF pointer
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;teste2.c,113 :: 		IFS0bits.ADIF = 0; // clear ADC interrupt flag
	BCLR	IFS0bits, #11
;teste2.c,114 :: 		ADCON1bits.ASAM = 1; // auto start sampling
	BSET.B	ADCON1bits, #2
;teste2.c,116 :: 		while (!IFS0bits.ADIF); // conversion done?
L_main4:
	BTSC	IFS0bits, #11
	GOTO	L_main5
	GOTO	L_main4
L_main5:
;teste2.c,117 :: 		ADCON1bits.ASAM = 0; // yes then stop sample/convert
	BCLR.B	ADCON1bits, #2
;teste2.c,118 :: 		for (count = 0; count < 16; count++) // average the 2 ADC value
	CLR	W0
	MOV	W0, _count
L_main6:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__main12
	GOTO	L_main7
L__main12:
;teste2.c,119 :: 		ADCValue = ADCValue + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_ADCValue), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;teste2.c,118 :: 		for (count = 0; count < 16; count++) // average the 2 ADC value
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;teste2.c,119 :: 		ADCValue = ADCValue + *ADC16Ptr++;
	GOTO	L_main6
L_main7:
;teste2.c,120 :: 		ADCValue = ADCValue >> 1;
	MOV	_ADCValue, W0
	LSR	W0, #1, W0
	MOV	W0, _ADCValue
;teste2.c,121 :: 		ADCValue = ADCValue >> 1;
	LSR	W0, #1, W0
	MOV	W0, _ADCValue
;teste2.c,122 :: 		ADCValue = ADCValue >> 1;
	LSR	W0, #1, W0
	MOV	W0, _ADCValue
;teste2.c,123 :: 		ADCValue = ADCValue >> 1;
	LSR	W0, #1, W0
	MOV	W0, _ADCValue
;teste2.c,132 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;teste2.c,134 :: 		}
	GOTO	L_main2
;teste2.c,149 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
