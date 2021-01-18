
_relogio:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;test_1.c,38 :: 		void relogio() iv IVT_ADDR_T1INTERRUPT {
;test_1.c,40 :: 		if (PR1 == aux1_pr1){
	MOV	PR1, W1
	MOV	#lo_addr(_aux1_pr1), W0
	CP	W1, [W0]
	BRA Z	L__relogio5
	GOTO	L_relogio0
L__relogio5:
;test_1.c,41 :: 		PR1 = aux2_pr1;
	MOV	_aux2_pr1, W0
	MOV	WREG, PR1
;test_1.c,42 :: 		T1CON = aux1_psk1;
	MOV	_aux1_psk1, W0
	MOV	WREG, T1CON
;test_1.c,43 :: 		LATF = 0x0002;
	MOV	#2, W0
	MOV	WREG, LATF
;test_1.c,44 :: 		}else{
	GOTO	L_relogio1
L_relogio0:
;test_1.c,45 :: 		PR1 = aux1_pr1;
	MOV	_aux1_pr1, W0
	MOV	WREG, PR1
;test_1.c,46 :: 		T1CON = aux2_psk1;
	MOV	_aux2_psk1, W0
	MOV	WREG, T1CON
;test_1.c,47 :: 		LATF = 0x0000;
	CLR	LATF
;test_1.c,48 :: 		}
L_relogio1:
;test_1.c,49 :: 		TMR1 = 0;
	CLR	TMR1
;test_1.c,50 :: 		IFS0 = 0;
	CLR	IFS0
;test_1.c,52 :: 		}
L_end_relogio:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _relogio

_calc_dist:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;test_1.c,54 :: 		void calc_dist() iv IVT_ADDR_T2INTERRUPT {
;test_1.c,55 :: 		IFS0 = 0;
	CLR	IFS0
;test_1.c,56 :: 		dist = TMR2/58.8;
	MOV	TMR2, WREG
	CLR	W1
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#17003, W3
	CALL	__Div_FP
	MOV	W0, _dist
	MOV	W1, _dist+2
;test_1.c,57 :: 		TMR2 = 0;
	CLR	TMR2
;test_1.c,58 :: 		}
L_end_calc_dist:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _calc_dist

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;test_1.c,60 :: 		void main() {
;test_1.c,61 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;test_1.c,63 :: 		TRISF = 0;
	CLR	TRISF
;test_1.c,64 :: 		LATF = 0x0000;
	CLR	LATF
;test_1.c,65 :: 		TMR1 = 0;//onda de 10micro
	CLR	TMR1
;test_1.c,66 :: 		t1 = 0;
	CLR	W0
	MOV	W0, _t1
;test_1.c,67 :: 		t2 = 0;
	CLR	W0
	MOV	W0, _t2
;test_1.c,68 :: 		TMR2 = 0;//onda de 500mili
	CLR	TMR2
;test_1.c,69 :: 		IFS0 = 0;//
	CLR	IFS0
;test_1.c,70 :: 		IEC0 = 0x00C8;//habilitacao do timer1
	MOV	#200, W0
	MOV	WREG, IEC0
;test_1.c,71 :: 		aux_echo = 0;
	CLR	W0
	MOV	W0, _aux_echo
;test_1.c,72 :: 		aux1_pr1 = 160; //10E-6
	MOV	#160, W0
	MOV	W0, _aux1_pr1
;test_1.c,74 :: 		aux2_pr1 = 6000;
	MOV	#6000, W0
	MOV	W0, _aux2_pr1
;test_1.c,75 :: 		aux1_psk1 = 0x8030;
	MOV	#32816, W0
	MOV	W0, _aux1_psk1
;test_1.c,76 :: 		aux2_psk1 = 0x8000;
	MOV	#32768, W0
	MOV	W0, _aux2_psk1
;test_1.c,78 :: 		T1CON = aux1_psk1;
	MOV	#32816, W0
	MOV	WREG, T1CON
;test_1.c,80 :: 		T2CON = 0x8040;
	MOV	#32832, W0
	MOV	WREG, T2CON
;test_1.c,81 :: 		PR1 = aux2_pr1;
	MOV	#6000, W0
	MOV	WREG, PR1
;test_1.c,82 :: 		Lcd_Init();
	CALL	_Lcd_Init
;test_1.c,83 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;test_1.c,84 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;test_1.c,85 :: 		Lcd_Out(1,6,txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	#6, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;test_1.c,87 :: 		while(1){
L_main2:
;test_1.c,91 :: 		}
	GOTO	L_main2
;test_1.c,92 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
