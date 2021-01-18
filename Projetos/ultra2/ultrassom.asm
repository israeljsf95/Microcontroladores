
_contador:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;ultrassom.c,32 :: 		void contador() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;ultrassom.c,33 :: 		IFS0 = 0;
	CLR	IFS0
;ultrassom.c,34 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__contador5
	GOTO	L_contador0
L__contador5:
;ultrassom.c,35 :: 		PR1 = desl;
	MOV	_desl, W0
	MOV	WREG, PR1
;ultrassom.c,36 :: 		T1CON = confdesl;
	MOV	_confdesl, W0
	MOV	WREG, T1CON
;ultrassom.c,37 :: 		LATFbits.LATF1 = 0;
	BCLR.B	LATFbits, #1
;ultrassom.c,40 :: 		}else{
	GOTO	L_contador1
L_contador0:
;ultrassom.c,41 :: 		PR1 = lig;
	MOV	_lig, W0
	MOV	WREG, PR1
;ultrassom.c,42 :: 		T1CON = conflig;
	MOV	_conflig, W0
	MOV	WREG, T1CON
;ultrassom.c,43 :: 		LATFbits.LATF1 = 1;
	BSET.B	LATFbits, #1
;ultrassom.c,45 :: 		}
L_contador1:
;ultrassom.c,47 :: 		estado = ~estado;
	MOV	#lo_addr(_estado), W0
	COM	[W0], [W0]
;ultrassom.c,48 :: 		}
L_end_contador:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _contador

_distancia:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;ultrassom.c,50 :: 		void distancia() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO{
;ultrassom.c,51 :: 		IFS0 = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	IFS0
;ultrassom.c,52 :: 		dist = TMR2/58.8;
	MOV	TMR2, WREG
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#17003, W3
	CALL	__Div_FP
	MOV	W0, _dist
	MOV	W1, _dist+2
;ultrassom.c,53 :: 		IntToStr(dist, txt2);//    ' Convert float to string
	CALL	__Float2Longint
	MOV	#lo_addr(_txt2), W11
	MOV	W0, W10
	CALL	_IntToStr
;ultrassom.c,55 :: 		Lcd_Out(2, 5, txt2);
	MOV	#lo_addr(_txt2), W12
	MOV	#5, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;ultrassom.c,56 :: 		TMR2 = 0;
	CLR	TMR2
;ultrassom.c,57 :: 		}
L_end_distancia:
	POP	W12
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _distancia

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ultrassom.c,60 :: 		void main() {
;ultrassom.c,61 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ultrassom.c,62 :: 		TRISF = 0 ;
	CLR	TRISF
;ultrassom.c,63 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;ultrassom.c,64 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;ultrassom.c,65 :: 		IFS0 = 0;
	CLR	IFS0
;ultrassom.c,67 :: 		lig = 16000;
	MOV	#16000, W0
	MOV	W0, _lig
;ultrassom.c,68 :: 		desl = 6250;
	MOV	#6250, W0
	MOV	W0, _desl
;ultrassom.c,70 :: 		confdesl = 0x8030;
	MOV	#32816, W0
	MOV	W0, _confdesl
;ultrassom.c,71 :: 		conflig = 0x8000;
	MOV	#32768, W0
	MOV	W0, _conflig
;ultrassom.c,73 :: 		estado = 0;
	CLR	W0
	MOV	W0, _estado
;ultrassom.c,75 :: 		PR1 = desl;
	MOV	#6250, W0
	MOV	WREG, PR1
;ultrassom.c,76 :: 		PR2 = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, PR2
;ultrassom.c,77 :: 		T1CON = conflig;
	MOV	#32768, W0
	MOV	WREG, T1CON
;ultrassom.c,78 :: 		T2CON = 0x8040; //Gate acumulation
	MOV	#32832, W0
	MOV	WREG, T2CON
;ultrassom.c,79 :: 		LATF = 0;
	CLR	LATF
;ultrassom.c,80 :: 		Lcd_Init();
	CALL	_Lcd_Init
;ultrassom.c,81 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;ultrassom.c,82 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;ultrassom.c,83 :: 		Lcd_Out(1,6,txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	#6, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;ultrassom.c,84 :: 		while(1){
L_main2:
;ultrassom.c,85 :: 		}
	GOTO	L_main2
;ultrassom.c,87 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
