
_init_uart2:

;q4.c,15 :: 		void init_uart2(unsigned char baud_rate)
;q4.c,17 :: 		U2BRG = baud_rate;
	ZE	W10, W0
	MOV	WREG, U2BRG
;q4.c,18 :: 		U2MODE = 0;
	CLR	U2MODE
;q4.c,19 :: 		U2STA = 0;
	CLR	U2STA
;q4.c,20 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;q4.c,21 :: 		IEC1bits.U2TXIE = 0;
	BCLR	IEC1bits, #9
;q4.c,22 :: 		IFS1BITS.U2RXIF = 0;
	BCLR	IFS1bits, #8
;q4.c,23 :: 		IEC1bits.U2RXIE = 0;
	BCLR	IEC1bits, #8
;q4.c,24 :: 		U2MODEbits.UARTEN = 1;
	BSET	U2MODEbits, #15
;q4.c,25 :: 		U2STAbits.UTXEN = 1;
	BSET	U2STAbits, #10
;q4.c,26 :: 		}
L_end_init_uart2:
	RETURN
; end of _init_uart2

_nFloatToStr:
	LNK	#10

;q4.c,36 :: 		void nFloatToStr(float f, short p, char *txt)
;q4.c,39 :: 		char sign = ((char *)&f)[2].B7;
	MOV	#lo_addr(W10), W0
	INC2	W0
	MOV.B	[W0], W1
	ADD	W14, #4, W0
	CLR.B	[W0]
	BTSC.B	W1, #7
	INC.B	[W0], [W0]
;q4.c,40 :: 		unsigned long factor = 10;
; factor start address is: 8 (W4)
	MOV	#10, W4
	MOV	#0, W5
;q4.c,41 :: 		short i = p, j = 0;
; i start address is: 2 (W1)
	MOV.B	W12, W1
	MOV	#0, W0
	MOV.B	W0, [W14+5]
; i end address is: 2 (W1)
; factor end address is: 8 (W4)
	MOV.D	W4, W2
;q4.c,43 :: 		while (i--)
L_nFloatToStr0:
; i start address is: 12 (W6)
; i start address is: 2 (W1)
; factor start address is: 4 (W2)
	MOV.B	W1, W0
; i start address is: 12 (W6)
	SUB.B	W1, #1, W6
; i end address is: 2 (W1)
; i end address is: 12 (W6)
	CP0.B	W0
	BRA NZ	L__nFloatToStr28
	GOTO	L_nFloatToStr1
L__nFloatToStr28:
; i end address is: 12 (W6)
;q4.c,44 :: 		factor *= 10;
; i start address is: 12 (W6)
	MOV	#10, W0
	MOV	#0, W1
	CALL	__Multiply_32x32
; factor end address is: 4 (W2)
; factor start address is: 8 (W4)
	MOV.D	W0, W4
	MOV.D	W4, W2
; i end address is: 12 (W6)
; factor end address is: 8 (W4)
	MOV.B	W6, W1
	GOTO	L_nFloatToStr0
L_nFloatToStr1:
;q4.c,46 :: 		((char *)&f)[2].B7 = 0;
; factor start address is: 4 (W2)
	MOV	#lo_addr(W10), W0
	INC2	W0
	BCLR.B	[W0], #7
;q4.c,48 :: 		result = ((unsigned long)(f * factor) + 5) / 10;
	PUSH.D	W12
; factor end address is: 4 (W2)
	PUSH.D	W10
	MOV.D	W2, W0
	CALL	__Long2Float
	POP.D	W10
	PUSH.D	W10
	MOV.D	W10, W2
	CALL	__Mul_FP
	CALL	__Float2Longword
	ADD	W0, #5, W0
	ADDC	W1, #0, W1
	MOV	#10, W2
	MOV	#0, W3
	CLR	W4
	CALL	__Divide_32x32
	POP.D	W10
	POP.D	W12
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
;q4.c,55 :: 		} while (((result /= 10) > 0) || (p > 0));
L__nFloatToStr25:
L__nFloatToStr24:
;q4.c,52 :: 		txt[j++] = result % 10 + '0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV	W0, [W14+8]
	PUSH.D	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	CLR	W4
	CALL	__Modulus_32x32
	POP.D	W10
	POP.D	W12
	MOV	#48, W2
	MOV	#0, W3
	ADD	W0, W2, W2
	MOV	[W14+8], W0
	MOV.B	W2, [W0]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
;q4.c,53 :: 		if (--p == 0)
	SUB.B	W12, #1, W0
	MOV.B	W0, W12
	CP.B	W12, #0
	BRA Z	L__nFloatToStr29
	GOTO	L_nFloatToStr5
L__nFloatToStr29:
;q4.c,54 :: 		txt[j++] = '.';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#46, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr5:
;q4.c,55 :: 		} while (((result /= 10) > 0) || (p > 0));
	PUSH.D	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	CLR	W4
	CALL	__Divide_32x32
	POP.D	W10
	POP.D	W12
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	CP	W0, #0
	CPB	W1, #0
	BRA LEU	L__nFloatToStr30
	GOTO	L__nFloatToStr25
L__nFloatToStr30:
	CP.B	W12, #0
	BRA LE	L__nFloatToStr31
	GOTO	L__nFloatToStr24
L__nFloatToStr31:
L__nFloatToStr23:
;q4.c,57 :: 		if (txt[j - 1] == '.')
	ADD	W14, #5, W0
	SE	[W0], W0
	DEC	W0
	ADD	W13, W0, W0
	MOV.B	[W0], W1
	MOV.B	#46, W0
	CP.B	W1, W0
	BRA Z	L__nFloatToStr32
	GOTO	L_nFloatToStr8
L__nFloatToStr32:
;q4.c,58 :: 		txt[j++] = '0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr8:
;q4.c,60 :: 		if (sign)
	ADD	W14, #4, W0
	CP0.B	[W0]
	BRA NZ	L__nFloatToStr33
	GOTO	L_nFloatToStr9
L__nFloatToStr33:
;q4.c,61 :: 		txt[j++] = '-';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#45, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr9:
;q4.c,63 :: 		txt[j] = '\0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	CLR	W0
	MOV.B	W0, [W1]
;q4.c,65 :: 		for (i = 0, j--; i < j; i++, j--)
; i start address is: 6 (W3)
	CLR	W3
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	SUB.B	W1, #1, [W0]
	MOV.B	W3, W2
; i end address is: 6 (W3)
L_nFloatToStr10:
; i start address is: 4 (W2)
	ADD	W14, #5, W0
	CP.B	W2, [W0]
	BRA LT	L__nFloatToStr34
	GOTO	L_nFloatToStr11
L__nFloatToStr34:
;q4.c,66 :: 		p = txt[i], txt[i] = txt[j], txt[j] = p;
	SE	W2, W0
	ADD	W13, W0, W1
	MOV.B	[W1], W12
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV.B	[W0], [W1]
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV.B	W12, [W0]
;q4.c,65 :: 		for (i = 0, j--; i < j; i++, j--)
; i start address is: 6 (W3)
	ADD.B	W2, #1, W3
; i end address is: 4 (W2)
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	SUB.B	W1, #1, [W0]
;q4.c,66 :: 		p = txt[i], txt[i] = txt[j], txt[j] = p;
	MOV.B	W3, W2
; i end address is: 6 (W3)
	GOTO	L_nFloatToStr10
L_nFloatToStr11:
;q4.c,67 :: 		}
L_end_nFloatToStr:
	ULNK
	RETURN
; end of _nFloatToStr

_converter:

;q4.c,71 :: 		void converter()
;q4.c,73 :: 		for (i = 0; i < 3; i++)
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CLR	W0
	MOV	W0, _i
L_converter13:
	MOV	_i, W0
	CP	W0, #3
	BRA LT	L__converter36
	GOTO	L_converter14
L__converter36:
;q4.c,75 :: 		ADCHSbits.CH0SA = canais[i];
	MOV	_i, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_canais), W0
	ADD	W0, W1, W0
	MOV.B	[W0], W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;q4.c,76 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;q4.c,77 :: 		ADC16Ptr = &ADCBUF0;
	MOV	#lo_addr(ADCBUF0), W0
	MOV	W0, _ADC16Ptr
;q4.c,78 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;q4.c,79 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;q4.c,80 :: 		while (!IFS0bits.ADIF)
L_converter16:
	BTSC	IFS0bits, #11
	GOTO	L_converter17
;q4.c,81 :: 		;
	GOTO	L_converter16
L_converter17:
;q4.c,82 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;q4.c,83 :: 		for (j = 0; j < 16; j++)
	CLR	W0
	MOV	W0, _j
L_converter18:
	MOV	_j, W0
	CP	W0, #16
	BRA LT	L__converter37
	GOTO	L_converter19
L__converter37:
;q4.c,85 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W1
	MOV	_soma, W0
	ADD	W0, [W1], W2
	MOV	W2, _soma
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;q4.c,86 :: 		soma = soma >> 1;
	ASR	W2, #1, W0
	MOV	W0, _soma
;q4.c,83 :: 		for (j = 0; j < 16; j++)
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], [W0]
;q4.c,87 :: 		}
	GOTO	L_converter18
L_converter19:
;q4.c,88 :: 		media[i] = soma;
	MOV	_i, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_media), W0
	ADD	W0, W1, W1
	MOV	_soma, W0
	MOV	W0, [W1]
;q4.c,73 :: 		for (i = 0; i < 3; i++)
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;q4.c,89 :: 		}
	GOTO	L_converter13
L_converter14:
;q4.c,90 :: 		temp = media[1] * 0.488758;
	MOV	_media+2, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#15997, W2
	MOV	#16122, W3
	CALL	__Mul_FP
	MOV	W0, _temp
	MOV	W1, _temp+2
;q4.c,91 :: 		ldr = media[2] * 5 / 1023;
	MOV	_media+4, W1
	MOV	#5, W0
	MUL.SS	W1, W0, W0
	MOV	#1023, W2
	REPEAT	#17
	DIV.S	W0, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _ldr
	MOV	W1, _ldr+2
;q4.c,92 :: 		pot = media[0] * 5 / 1023;
	MOV	_media, W1
	MOV	#5, W0
	MUL.SS	W1, W0, W0
	MOV	#1023, W2
	REPEAT	#17
	DIV.S	W0, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _pot
	MOV	W1, _pot+2
;q4.c,93 :: 		nFloatToStr(temp, 2, txt_temp);
	MOV	#lo_addr(_txt_temp), W13
	MOV.B	#2, W12
	MOV	_temp, W10
	MOV	_temp+2, W11
	CALL	_nFloatToStr
;q4.c,94 :: 		nFloatToStr(ldr, 2, txt_ldr);
	MOV	#lo_addr(_txt_ldr), W13
	MOV.B	#2, W12
	MOV	_ldr, W10
	MOV	_ldr+2, W11
	CALL	_nFloatToStr
;q4.c,95 :: 		nFloatToStr(pot, 2, txt_pot);
	MOV	#lo_addr(_txt_pot), W13
	MOV.B	#2, W12
	MOV	_pot, W10
	MOV	_pot+2, W11
	CALL	_nFloatToStr
;q4.c,96 :: 		}
L_end_converter:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _converter

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q4.c,101 :: 		void main()
;q4.c,104 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q4.c,105 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;q4.c,106 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;q4.c,107 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;q4.c,109 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;q4.c,110 :: 		IEC0bits.INT0IE = 1; //Talvez as coisas nao usem
	BSET.B	IEC0bits, #0
;q4.c,111 :: 		IFS0 = 0;
	CLR	IFS0
;q4.c,113 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;q4.c,114 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;q4.c,115 :: 		IFS1 = 0;
	CLR	IFS1
;q4.c,117 :: 		TRISBbits.TRISB0 = 0;
	BCLR.B	TRISBbits, #0
;q4.c,118 :: 		TRISBbits.TRISB1 = 0;
	BCLR.B	TRISBbits, #1
;q4.c,120 :: 		ADCON1 = 0;
	CLR	ADCON1
;q4.c,121 :: 		ADCON1bits.SSRC = 0b010; // Sincando o tempo de conversao com o timer 3
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
;q4.c,124 :: 		TMR3 = 0x0000;
	CLR	TMR3
;q4.c,125 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;q4.c,126 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;q4.c,129 :: 		ADCHSbits.CH0SA = 0b0010; // Connect RB2/AN2 as CH0 input ..
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;q4.c,130 :: 		ADCSSL = 0;
	CLR	ADCSSL
;q4.c,131 :: 		ADCON3 = 0x0008;
	MOV	#8, W0
	MOV	WREG, ADCON3
;q4.c,132 :: 		ADCON2 = 0;
	CLR	ADCON2
;q4.c,133 :: 		ADCON2bits.SMPI = 0b1111;
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;q4.c,134 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;q4.c,136 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q4.c,139 :: 		TMR1 = 0x0000;
	CLR	TMR1
;q4.c,140 :: 		PR1 = 31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;q4.c,141 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;q4.c,143 :: 		T1CONbits.TCKPS = 0b11;
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	[W0], W1
	MOV.B	#48, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	W1, [W0]
;q4.c,144 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q4.c,145 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;q4.c,146 :: 		while (1)
L_main21:
;q4.c,148 :: 		converter();
	CALL	_converter
;q4.c,160 :: 		}
	GOTO	L_main21
;q4.c,161 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
