
_INT0Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q2.c,12 :: 		void INT0Int() iv IVT_ADDR_INT0INTERRUPT{
;q2.c,14 :: 		}
L_end_INT0Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _INT0Int

_contador_pulsos:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q2.c,43 :: 		void contador_pulsos() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;q2.c,44 :: 		frequencia = cont_pulso;
	MOV	_cont_pulso, W0
	MOV	_cont_pulso+2, W1
	MOV	W0, _frequencia
	MOV	W1, _frequencia+2
;q2.c,45 :: 		cont_pulso = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _cont_pulso
	MOV	W1, _cont_pulso+2
;q2.c,46 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;q2.c,47 :: 		}
L_end_contador_pulsos:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _contador_pulsos

_PWM:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q2.c,49 :: 		void PWM() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;q2.c,50 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;q2.c,51 :: 		LATBbits.LATB5 = ~LATBbits.LATB5;
	BTG	LATBbits, #5
;q2.c,52 :: 		}
L_end_PWM:
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

;q2.c,54 :: 		void main() {
;q2.c,55 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q2.c,56 :: 		TRISE = 0;
	CLR	TRISE
;q2.c,57 :: 		TRISB = 0;
	CLR	TRISB
;q2.c,58 :: 		LATB = 0;
	CLR	LATB
;q2.c,60 :: 		Lcd_Init();
	CALL	_Lcd_Init
;q2.c,64 :: 		IFS0 = 0;
	CLR	IFS0
;q2.c,65 :: 		IEC0 = 0;
	CLR	IEC0
;q2.c,66 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q2.c,67 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;q2.c,68 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;q2.c,69 :: 		INTCON2bits.INT0EP = 0;
	BCLR.B	INTCON2bits, #0
;q2.c,70 :: 		PR1 = 62500; //ate 1 segundo
	MOV	#62500, W0
	MOV	WREG, PR1
;q2.c,71 :: 		PR2 = 400;
	MOV	#400, W0
	MOV	WREG, PR2
;q2.c,72 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;q2.c,73 :: 		T2CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T2CON
;q2.c,74 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;q2.c,75 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;q2.c,78 :: 		while(1){
L_main0:
;q2.c,79 :: 		if ((LATBbits.LATB5 == 1)&(passado == 0)){
	BSET	W3, #0
	BTSS	LATBbits, #5
	BCLR	W3, #0
	MOV	_passado, W0
	MOV	_passado+2, W1
	CP	W0, #0
	CPB	W1, #0
	CLR.B	W2
	BRA NZ	L__main7
	INC.B	W2
L__main7:
	CLR.B	W0
	BTSC	W3, #0
	INC.B	W0
	ZE	W0, W1
	ZE	W2, W0
	AND	W1, W0, W0
	BRA NZ	L__main8
	GOTO	L_main2
L__main8:
;q2.c,80 :: 		cont_pulso++;
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_cont_pulso), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;q2.c,81 :: 		}
L_main2:
;q2.c,82 :: 		passado = LATBbits.LATB5;
	MOV	#lo_addr(_passado), W2
	CLR	W0
	BTSC	LATBbits, #5
	INC	W0
	CLR	W1
	MOV.D	W0, [W2]
;q2.c,84 :: 		IntToStr(frequencia, txt);
	MOV	#lo_addr(_txt), W11
	MOV	_frequencia, W10
	CALL	_IntToStr
;q2.c,85 :: 		Lcd_Out(1,10,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#10, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q2.c,86 :: 		}
	GOTO	L_main0
;q2.c,88 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
