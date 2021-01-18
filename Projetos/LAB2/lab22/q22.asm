
_INT2Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q22.c,32 :: 		void INT2Int() iv IVT_ADDR_INT2INTERRUPT{
;q22.c,34 :: 		cont_int++;    // a cada vez que a interrupção 2 é ativada cont_int incrementa 1
	MOV	#1, W1
	MOV	#lo_addr(_cont_int), W0
	ADD	W1, [W0], [W0]
;q22.c,37 :: 		if (cont_int > 3){  // se a variável de contagem for maior que 3, volta para o primeiro estado (medida em Hertz)
	MOV	_cont_int, W0
	CP	W0, #3
	BRA GT	L__INT2Int7
	GOTO	L_INT2Int0
L__INT2Int7:
;q22.c,38 :: 		cont_int = 1;
	MOV	#1, W0
	MOV	W0, _cont_int
;q22.c,39 :: 		}
L_INT2Int0:
;q22.c,41 :: 		if (cont_int == 1){  //1º estado (Medição em Hertz)
	MOV	_cont_int, W0
	CP	W0, #1
	BRA Z	L__INT2Int8
	GOTO	L_INT2Int1
L__INT2Int8:
;q22.c,42 :: 		PR1 = 62500;  // valor máximo da comparação do timer 2
	MOV	#62500, W0
	MOV	WREG, PR1
;q22.c,43 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;q22.c,45 :: 		}
L_INT2Int1:
;q22.c,47 :: 		if (cont_int == 2){ // 2º estado (medição em KHz)
	MOV	_cont_int, W0
	CP	W0, #2
	BRA Z	L__INT2Int9
	GOTO	L_INT2Int2
L__INT2Int9:
;q22.c,48 :: 		PR1 = 250;
	MOV	#250, W0
	MOV	WREG, PR1
;q22.c,49 :: 		T1CON = 0x8020;
	MOV	#32800, W0
	MOV	WREG, T1CON
;q22.c,51 :: 		}
L_INT2Int2:
;q22.c,53 :: 		if (cont_int == 3){  // 3º estado (Medição em MHz)
	MOV	_cont_int, W0
	CP	W0, #3
	BRA Z	L__INT2Int10
	GOTO	L_INT2Int3
L__INT2Int10:
;q22.c,54 :: 		PR1 = 16;
	MOV	#16, W0
	MOV	WREG, PR1
;q22.c,55 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;q22.c,57 :: 		}
L_INT2Int3:
;q22.c,58 :: 		TMR2 = 0;
	CLR	TMR2
;q22.c,59 :: 		IFS1 = 0; //interrupção externa 2 é desativada
	CLR	IFS1
;q22.c,61 :: 		}
L_end_INT2Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _INT2Int

_Frequencimetro:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q22.c,66 :: 		void Frequencimetro() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;q22.c,67 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;q22.c,68 :: 		}
L_end_Frequencimetro:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Frequencimetro

_janela_de_tempo:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q22.c,70 :: 		void janela_de_tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;q22.c,71 :: 		frequencia = TMR2;
	MOV	TMR2, WREG
	CLR	W1
	MOV	W0, _frequencia
	MOV	W1, _frequencia+2
;q22.c,72 :: 		TMR2 = 0;
	CLR	TMR2
;q22.c,73 :: 		IFS0 = 0;
	CLR	IFS0
;q22.c,74 :: 		}
L_end_janela_de_tempo:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _janela_de_tempo

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q22.c,78 :: 		void main() {
;q22.c,80 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q22.c,81 :: 		TRISE = 0;
	CLR	TRISE
;q22.c,82 :: 		TRISB = 0;
	CLR	TRISB
;q22.c,83 :: 		TRISC = 0;
	CLR	TRISC
;q22.c,84 :: 		TRISD = 0;
	CLR	TRISD
;q22.c,86 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;q22.c,88 :: 		TRISCbits.TRISC14 = 1;
	BSET	TRISCbits, #14
;q22.c,90 :: 		Lcd_Init();
	CALL	_Lcd_Init
;q22.c,94 :: 		IFS0 = 0;
	CLR	IFS0
;q22.c,95 :: 		IFS1 = 0;
	CLR	IFS1
;q22.c,97 :: 		IEC0 = 0;
	CLR	IEC0
;q22.c,98 :: 		IEC1 = 0;
	CLR	IEC1
;q22.c,100 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;q22.c,101 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q22.c,103 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;q22.c,104 :: 		INTCON2bits.INT2EP = 0;
	BCLR.B	INTCON2bits, #2
;q22.c,106 :: 		PR2 = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, PR2
;q22.c,107 :: 		PR1 = 62500;
	MOV	#62500, W0
	MOV	WREG, PR1
;q22.c,109 :: 		T2CON = 0x8002;//modo sincrono
	MOV	#32770, W0
	MOV	WREG, T2CON
;q22.c,110 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;q22.c,112 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;q22.c,113 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;q22.c,116 :: 		while(1){
L_main4:
;q22.c,117 :: 		LongToStr(TMR2, txt);
	MOV	#lo_addr(_txt), W12
	MOV	TMR2, W10
	CLR	W11
	CALL	_LongToStr
;q22.c,128 :: 		Lcd_Out(1,2,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#2, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q22.c,129 :: 		}
	GOTO	L_main4
;q22.c,131 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
