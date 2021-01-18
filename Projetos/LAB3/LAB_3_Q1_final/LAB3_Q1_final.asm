
_copystr:

;LAB3_Q1_final.c,39 :: 		void copystr(char *str,char *str2){
;LAB3_Q1_final.c,40 :: 		str[0] = str2[0];
	MOV.B	[W11], [W10]
;LAB3_Q1_final.c,41 :: 		str[1] = str2[1];
	ADD	W10, #1, W1
	ADD	W11, #1, W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,42 :: 		str[2] = str2[2];
	ADD	W10, #2, W1
	ADD	W11, #2, W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,43 :: 		str[3] = str2[3];
	ADD	W10, #3, W1
	ADD	W11, #3, W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,44 :: 		}
L_end_copystr:
	RETURN
; end of _copystr

_botao_menu:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1_final.c,46 :: 		void botao_menu() iv IVT_ADDR_INT0INTERRUPT{
;LAB3_Q1_final.c,48 :: 		flag_seleciona = 0;
	CLR	W0
	MOV	W0, _flag_seleciona
;LAB3_Q1_final.c,49 :: 		flag_botao++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_botao), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,50 :: 		if (flag_botao > 4)
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA GT	L__botao_menu49
	GOTO	L_botao_menu0
L__botao_menu49:
;LAB3_Q1_final.c,51 :: 		flag_botao = 0;
	CLR	W0
	MOV	W0, _flag_botao
L_botao_menu0:
;LAB3_Q1_final.c,52 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_botao_menu1:
	DEC	W7
	BRA NZ	L_botao_menu1
	DEC	W8
	BRA NZ	L_botao_menu1
;LAB3_Q1_final.c,53 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;LAB3_Q1_final.c,54 :: 		}
L_end_botao_menu:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao_menu

_criatividade:

;LAB3_Q1_final.c,60 :: 		void criatividade(){
;LAB3_Q1_final.c,61 :: 		cria_temp = media[0]*0.488758;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	_media, W0
	MOV	_media+2, W1
	MOV	#15997, W2
	MOV	#16122, W3
	CALL	__Mul_FP
	MOV	W0, _cria_temp
	MOV	W1, _cria_temp+2
;LAB3_Q1_final.c,62 :: 		cria_LDR = media[1]*5/1023;
	MOV	_media+4, W0
	MOV	_media+6, W1
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _cria_LDR
	MOV	W1, _cria_LDR+2
;LAB3_Q1_final.c,63 :: 		cria_pot = media[2]*150/1023;
	MOV	_media+8, W0
	MOV	_media+10, W1
	MOV	#0, W2
	MOV	#17174, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _cria_pot
	MOV	W1, _cria_pot+2
;LAB3_Q1_final.c,65 :: 		Lcd_Out(1,1,"Temp    :");
	MOV	#lo_addr(?lstr1_LAB3_Q1_final), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,66 :: 		FloatToStr(cria_temp,txt);
	MOV	#lo_addr(_txt), W12
	MOV	_cria_temp, W10
	MOV	_cria_temp+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,67 :: 		copystr(aux6,txt);
	MOV	#lo_addr(_txt), W11
	MOV	#lo_addr(_aux6), W10
	CALL	_copystr
;LAB3_Q1_final.c,68 :: 		Lcd_Out(1,10,aux6);
	MOV	#lo_addr(_aux6), W12
	MOV	#10, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,70 :: 		Lcd_Out(2,1,"SetPoint:");
	MOV	#lo_addr(?lstr2_LAB3_Q1_final), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,71 :: 		FloatToStr(cria_pot,txt);
	MOV	#lo_addr(_txt), W12
	MOV	_cria_pot, W10
	MOV	_cria_pot+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,73 :: 		copystr(aux6,txt);
	MOV	#lo_addr(_txt), W11
	MOV	#lo_addr(_aux6), W10
	CALL	_copystr
;LAB3_Q1_final.c,74 :: 		Lcd_Out(2,11,aux6);
	MOV	#lo_addr(_aux6), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,76 :: 		if ((cria_temp <= cria_pot + 1)&&(cria_temp >= cria_pot - 1)){
	MOV	_cria_pot, W2
	MOV	_cria_pot+2, W3
	MOV	#0, W0
	MOV	#16256, W1
	CALL	__AddSub_FP
	MOV.D	W0, W2
	MOV	_cria_temp, W0
	MOV	_cria_temp+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__criatividade51
	INC.B	W0
L__criatividade51:
	CP0.B	W0
	BRA NZ	L__criatividade52
	GOTO	L__criatividade46
L__criatividade52:
	MOV	_cria_pot, W0
	MOV	_cria_pot+2, W1
	MOV	#0, W2
	MOV	#16256, W3
	CALL	__Sub_FP
	MOV.D	W0, W2
	MOV	_cria_temp, W0
	MOV	_cria_temp+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__criatividade53
	INC.B	W0
L__criatividade53:
	CP0.B	W0
	BRA NZ	L__criatividade54
	GOTO	L__criatividade45
L__criatividade54:
L__criatividade44:
;LAB3_Q1_final.c,77 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB3_Q1_final.c,78 :: 		}else{
	GOTO	L_criatividade6
;LAB3_Q1_final.c,76 :: 		if ((cria_temp <= cria_pot + 1)&&(cria_temp >= cria_pot - 1)){
L__criatividade46:
L__criatividade45:
;LAB3_Q1_final.c,79 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB3_Q1_final.c,81 :: 		}
L_criatividade6:
;LAB3_Q1_final.c,82 :: 		if (cria_LDR <= threshold){
	MOV	_threshold, W2
	MOV	_threshold+2, W3
	MOV	_cria_LDR, W0
	MOV	_cria_LDR+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__criatividade55
	INC.B	W0
L__criatividade55:
	CP0.B	W0
	BRA NZ	L__criatividade56
	GOTO	L_criatividade7
L__criatividade56:
;LAB3_Q1_final.c,83 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB3_Q1_final.c,84 :: 		}else{
	GOTO	L_criatividade8
L_criatividade7:
;LAB3_Q1_final.c,85 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB3_Q1_final.c,86 :: 		}
L_criatividade8:
;LAB3_Q1_final.c,87 :: 		}
L_end_criatividade:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _criatividade

_botao_selecionado:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1_final.c,89 :: 		void botao_selecionado() iv IVT_ADDR_INT2INTERRUPT{
;LAB3_Q1_final.c,91 :: 		flag_seleciona = flag_seleciona++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_seleciona), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,92 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_botao_selecionado9:
	DEC	W7
	BRA NZ	L_botao_selecionado9
	DEC	W8
	BRA NZ	L_botao_selecionado9
;LAB3_Q1_final.c,93 :: 		IFS1bits.INT2IF = 0;
	BCLR.B	IFS1bits, #7
;LAB3_Q1_final.c,94 :: 		}
L_end_botao_selecionado:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao_selecionado

_timer_1_conv:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1_final.c,97 :: 		void timer_1_conv() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{
;LAB3_Q1_final.c,99 :: 		IFS0bits.T1IF = 0;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	BCLR.B	IFS0bits, #3
;LAB3_Q1_final.c,101 :: 		if (flag_seleciona >= 1){
	MOV	_flag_seleciona, W0
	CP	W0, #1
	BRA GE	L__timer_1_conv59
	GOTO	L_timer_1_conv11
L__timer_1_conv59:
;LAB3_Q1_final.c,102 :: 		if(contador_tempo == PRs[flag_botao]-1){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	SUB	W0, #1, W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__timer_1_conv60
	GOTO	L_timer_1_conv12
L__timer_1_conv60:
;LAB3_Q1_final.c,104 :: 		ADCHSbits.CH0SA = 0b0010;
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,105 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;LAB3_Q1_final.c,106 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB3_Q1_final.c,107 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB3_Q1_final.c,108 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB3_Q1_final.c,109 :: 		while (!IFS0bits.ADIF);
L_timer_1_conv13:
	BTSC	IFS0bits, #11
	GOTO	L_timer_1_conv14
	GOTO	L_timer_1_conv13
L_timer_1_conv14:
;LAB3_Q1_final.c,110 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB3_Q1_final.c,111 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_timer_1_conv15:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__timer_1_conv61
	GOTO	L_timer_1_conv16
L__timer_1_conv61:
;LAB3_Q1_final.c,112 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,111 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,112 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_timer_1_conv15
L_timer_1_conv16:
;LAB3_Q1_final.c,113 :: 		media[0] = soma/16;
	MOV	_soma, W0
	MOV	#16, W2
	REPEAT	#17
	DIV.S	W0, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _media
	MOV	W1, _media+2
;LAB3_Q1_final.c,115 :: 		ADCHSbits.CH0SA = 0b0101;
	MOV.B	#5, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,116 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;LAB3_Q1_final.c,117 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB3_Q1_final.c,118 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB3_Q1_final.c,119 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB3_Q1_final.c,120 :: 		while (!IFS0bits.ADIF);
L_timer_1_conv18:
	BTSC	IFS0bits, #11
	GOTO	L_timer_1_conv19
	GOTO	L_timer_1_conv18
L_timer_1_conv19:
;LAB3_Q1_final.c,121 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB3_Q1_final.c,122 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_timer_1_conv20:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__timer_1_conv62
	GOTO	L_timer_1_conv21
L__timer_1_conv62:
;LAB3_Q1_final.c,123 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,122 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,123 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_timer_1_conv20
L_timer_1_conv21:
;LAB3_Q1_final.c,124 :: 		media[1] = soma/16;
	MOV	_soma, W0
	MOV	#16, W2
	REPEAT	#17
	DIV.S	W0, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _media+4
	MOV	W1, _media+6
;LAB3_Q1_final.c,126 :: 		ADCHSbits.CH0SA = 0b0111;
	MOV.B	#7, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,127 :: 		soma = 0;
	CLR	W0
	MOV	W0, _soma
;LAB3_Q1_final.c,129 :: 		ADC16Ptr = &ADCBUF1;
	MOV	#lo_addr(ADCBUF1), W0
	MOV	W0, _ADC16Ptr
;LAB3_Q1_final.c,130 :: 		IFS0bits.ADIF = 0;
	BCLR	IFS0bits, #11
;LAB3_Q1_final.c,131 :: 		ADCON1bits.ASAM = 1;
	BSET.B	ADCON1bits, #2
;LAB3_Q1_final.c,132 :: 		while (!IFS0bits.ADIF);
L_timer_1_conv23:
	BTSC	IFS0bits, #11
	GOTO	L_timer_1_conv24
	GOTO	L_timer_1_conv23
L_timer_1_conv24:
;LAB3_Q1_final.c,133 :: 		ADCON1bits.ASAM = 0;
	BCLR.B	ADCON1bits, #2
;LAB3_Q1_final.c,134 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W0
	MOV	W0, _count
L_timer_1_conv25:
	MOV	_count, W0
	CP	W0, #16
	BRA LT	L__timer_1_conv63
	GOTO	L_timer_1_conv26
L__timer_1_conv63:
;LAB3_Q1_final.c,135 :: 		soma = soma + *ADC16Ptr++;
	MOV	_ADC16Ptr, W0
	MOV	[W0], W1
	MOV	#lo_addr(_soma), W0
	ADD	W1, [W0], [W0]
	MOV	#2, W1
	MOV	#lo_addr(_ADC16Ptr), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,134 :: 		for (count = 1; count < 16; count++)
	MOV	#1, W1
	MOV	#lo_addr(_count), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,135 :: 		soma = soma + *ADC16Ptr++;
	GOTO	L_timer_1_conv25
L_timer_1_conv26:
;LAB3_Q1_final.c,136 :: 		media[2] = soma/15;
	MOV	_soma, W0
	MOV	#15, W2
	REPEAT	#17
	DIV.S	W0, W2
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _media+8
	MOV	W1, _media+10
;LAB3_Q1_final.c,137 :: 		}
L_timer_1_conv12:
;LAB3_Q1_final.c,139 :: 		temp = media[0]*0.488758;
	MOV	_media, W0
	MOV	_media+2, W1
	MOV	#15997, W2
	MOV	#16122, W3
	CALL	__Mul_FP
	MOV	W0, _temp
	MOV	W1, _temp+2
;LAB3_Q1_final.c,140 :: 		LDR = media[1]*5/1023;
	MOV	_media+4, W0
	MOV	_media+6, W1
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _LDR
	MOV	W1, _LDR+2
;LAB3_Q1_final.c,141 :: 		pot = media[2]*5/1023;
	MOV	_media+8, W0
	MOV	_media+10, W1
	MOV	#0, W2
	MOV	#16544, W3
	CALL	__Mul_FP
	MOV	#49152, W2
	MOV	#17535, W3
	CALL	__Div_FP
	MOV	W0, _pot
	MOV	W1, _pot+2
;LAB3_Q1_final.c,143 :: 		if (flag_seleciona == 1){
	MOV	_flag_seleciona, W0
	CP	W0, #1
	BRA Z	L__timer_1_conv64
	GOTO	L_timer_1_conv28
L__timer_1_conv64:
;LAB3_Q1_final.c,144 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB3_Q1_final.c,145 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB3_Q1_final.c,146 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB3_Q1_final.c,148 :: 		FloatToStr(temp, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_temp, W10
	MOV	_temp+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,149 :: 		txt[5] = 0;
	MOV	#lo_addr(_txt+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;LAB3_Q1_final.c,150 :: 		copystr(aux,txt);
	MOV	#lo_addr(_txt), W11
	MOV	#lo_addr(_aux), W10
	CALL	_copystr
;LAB3_Q1_final.c,151 :: 		Lcd_Out(1,1, "T ");
	MOV	#lo_addr(?lstr3_LAB3_Q1_final), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,152 :: 		Lcd_Out(1,3, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#3, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,153 :: 		Lcd_Out(1,7, "C ");
	MOV	#lo_addr(?lstr4_LAB3_Q1_final), W12
	MOV	#7, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,155 :: 		FloatToStr(LDR, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_LDR, W10
	MOV	_LDR+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,156 :: 		txt[5] = 0;
	MOV	#lo_addr(_txt+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;LAB3_Q1_final.c,157 :: 		copystr(aux,txt);
	MOV	#lo_addr(_txt), W11
	MOV	#lo_addr(_aux), W10
	CALL	_copystr
;LAB3_Q1_final.c,158 :: 		Lcd_Out(1,9, "LD ");
	MOV	#lo_addr(?lstr5_LAB3_Q1_final), W12
	MOV	#9, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,159 :: 		Lcd_Out(1,12, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#12, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,160 :: 		Lcd_Out(1,16, "V");
	MOV	#lo_addr(?lstr6_LAB3_Q1_final), W12
	MOV	#16, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,162 :: 		if (pot <1){
	MOV	#0, W2
	MOV	#16256, W3
	MOV	_pot, W0
	MOV	_pot+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__timer_1_conv65
	INC.B	W0
L__timer_1_conv65:
	CP0.B	W0
	BRA NZ	L__timer_1_conv66
	GOTO	L_timer_1_conv29
L__timer_1_conv66:
;LAB3_Q1_final.c,163 :: 		FloatToStr(pot, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_pot, W10
	MOV	_pot+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,164 :: 		aux20[0] = txt[0];
	MOV	#lo_addr(_aux20), W1
	MOV	#lo_addr(_txt), W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,165 :: 		aux20[1] = txt[2];
	MOV	#lo_addr(_aux20+1), W1
	MOV	#lo_addr(_txt+2), W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,166 :: 		txt[0] = '0';
	MOV	#lo_addr(_txt), W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;LAB3_Q1_final.c,167 :: 		txt[2] = aux20[0];
	MOV	#lo_addr(_txt+2), W1
	MOV	#lo_addr(_aux20), W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,168 :: 		txt[3] = aux20[1];
	MOV	#lo_addr(_txt+3), W1
	MOV	#lo_addr(_aux20+1), W0
	MOV.B	[W0], [W1]
;LAB3_Q1_final.c,169 :: 		}else{
	GOTO	L_timer_1_conv30
L_timer_1_conv29:
;LAB3_Q1_final.c,170 :: 		FloatToStr(pot, txt);
	MOV	#lo_addr(_txt), W12
	MOV	_pot, W10
	MOV	_pot+2, W11
	CALL	_FloatToStr
;LAB3_Q1_final.c,171 :: 		}
L_timer_1_conv30:
;LAB3_Q1_final.c,172 :: 		txt[5] = 0;
	MOV	#lo_addr(_txt+5), W1
	CLR	W0
	MOV.B	W0, [W1]
;LAB3_Q1_final.c,173 :: 		copystr(aux,txt);
	MOV	#lo_addr(_txt), W11
	MOV	#lo_addr(_aux), W10
	CALL	_copystr
;LAB3_Q1_final.c,174 :: 		Lcd_Out(2,1, "PO ");
	MOV	#lo_addr(?lstr7_LAB3_Q1_final), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,175 :: 		Lcd_Out(2,4, aux);
	MOV	#lo_addr(_aux), W12
	MOV	#4, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,176 :: 		Lcd_Out(2,8, "V");
	MOV	#lo_addr(?lstr8_LAB3_Q1_final), W12
	MOV	#8, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,178 :: 		IntToStr(contador_tempo/2, txt);
	MOV	_contador_tempo, W0
	MOV	#2, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	#lo_addr(_txt), W11
	MOV	W0, W10
	CALL	_IntToStr
;LAB3_Q1_final.c,179 :: 		Lcd_Out(2,9, txt);
	MOV	#lo_addr(_txt), W12
	MOV	#9, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,180 :: 		Lcd_Out(2,15, "  ");
	MOV	#lo_addr(?lstr9_LAB3_Q1_final), W12
	MOV	#15, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,181 :: 		}
L_timer_1_conv28:
;LAB3_Q1_final.c,182 :: 		}else{
	GOTO	L_timer_1_conv31
L_timer_1_conv11:
;LAB3_Q1_final.c,183 :: 		switch(flag_botao){
	GOTO	L_timer_1_conv32
;LAB3_Q1_final.c,184 :: 		case 0:
L_timer_1_conv34:
;LAB3_Q1_final.c,185 :: 		Lcd_Out(2,1,txtmeioseg);
	MOV	#lo_addr(_txtmeioseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,186 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,187 :: 		case 1:
L_timer_1_conv35:
;LAB3_Q1_final.c,188 :: 		Lcd_Out(2,1,txtumseg);
	MOV	#lo_addr(_txtumseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,189 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,190 :: 		case 2:
L_timer_1_conv36:
;LAB3_Q1_final.c,191 :: 		Lcd_Out(2,1,txtdezseg);
	MOV	#lo_addr(_txtdezseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,192 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,193 :: 		case 3:
L_timer_1_conv37:
;LAB3_Q1_final.c,194 :: 		Lcd_Out(2,1,txtummin);
	MOV	#lo_addr(_txtummin), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,195 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,196 :: 		case 4:
L_timer_1_conv38:
;LAB3_Q1_final.c,197 :: 		Lcd_Out(2,1,txtumahora);
	MOV	#lo_addr(_txtumahora), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,198 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,199 :: 		default:
L_timer_1_conv39:
;LAB3_Q1_final.c,200 :: 		break;
	GOTO	L_timer_1_conv33
;LAB3_Q1_final.c,201 :: 		}
L_timer_1_conv32:
	MOV	_flag_botao, W0
	CP	W0, #0
	BRA NZ	L__timer_1_conv67
	GOTO	L_timer_1_conv34
L__timer_1_conv67:
	MOV	_flag_botao, W0
	CP	W0, #1
	BRA NZ	L__timer_1_conv68
	GOTO	L_timer_1_conv35
L__timer_1_conv68:
	MOV	_flag_botao, W0
	CP	W0, #2
	BRA NZ	L__timer_1_conv69
	GOTO	L_timer_1_conv36
L__timer_1_conv69:
	MOV	_flag_botao, W0
	CP	W0, #3
	BRA NZ	L__timer_1_conv70
	GOTO	L_timer_1_conv37
L__timer_1_conv70:
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA NZ	L__timer_1_conv71
	GOTO	L_timer_1_conv38
L__timer_1_conv71:
	GOTO	L_timer_1_conv39
L_timer_1_conv33:
;LAB3_Q1_final.c,202 :: 		Lcd_Out(1,1,txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1_final.c,203 :: 		}
L_timer_1_conv31:
;LAB3_Q1_final.c,205 :: 		contador_tempo++;
	MOV	#1, W1
	MOV	#lo_addr(_contador_tempo), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1_final.c,206 :: 		if(contador_tempo >= PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA LE	L__timer_1_conv72
	GOTO	L_timer_1_conv40
L__timer_1_conv72:
;LAB3_Q1_final.c,207 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1_final.c,208 :: 		}
L_timer_1_conv40:
;LAB3_Q1_final.c,209 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;LAB3_Q1_final.c,210 :: 		}
L_end_timer_1_conv:
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
; end of _timer_1_conv

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB3_Q1_final.c,215 :: 		void main() {
;LAB3_Q1_final.c,216 :: 		ADPCFG = 0xFFFF; // all PORTB = Digital but RB7 = analog
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB3_Q1_final.c,217 :: 		ADPCFGbits.PCFG2 = 0;
	BCLR.B	ADPCFGbits, #2
;LAB3_Q1_final.c,218 :: 		ADPCFGbits.PCFG5 = 0;
	BCLR.B	ADPCFGbits, #5
;LAB3_Q1_final.c,219 :: 		ADPCFGbits.PCFG7 = 0;
	BCLR.B	ADPCFGbits, #7
;LAB3_Q1_final.c,222 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;LAB3_Q1_final.c,223 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;LAB3_Q1_final.c,224 :: 		IFS0 = 0;
	CLR	IFS0
;LAB3_Q1_final.c,226 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;LAB3_Q1_final.c,227 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;LAB3_Q1_final.c,228 :: 		IFS1 = 0;
	CLR	IFS1
;LAB3_Q1_final.c,230 :: 		TRISBbits.TRISB0 = 0;
	BCLR.B	TRISBbits, #0
;LAB3_Q1_final.c,231 :: 		TRISBbits.TRISB1 = 0;
	BCLR.B	TRISBbits, #1
;LAB3_Q1_final.c,233 :: 		ADCON1 = 0;
	CLR	ADCON1
;LAB3_Q1_final.c,234 :: 		ADCON1bits.SSRC = 0b010; // SSRC bit = 111 implies internal
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
;LAB3_Q1_final.c,236 :: 		TMR3 = 0x0000;
	CLR	TMR3
;LAB3_Q1_final.c,237 :: 		PR3 = 2000;
	MOV	#2000, W0
	MOV	WREG, PR3
;LAB3_Q1_final.c,238 :: 		T3CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T3CON
;LAB3_Q1_final.c,242 :: 		ADCHSbits.CH0SA = 0b0010; // Connect RB2/AN2 as CH0 input ..
	MOV.B	#2, W0
	MOV.B	W0, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #15, W1
	MOV	#lo_addr(ADCHSbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(ADCHSbits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,244 :: 		ADCSSL = 0;
	CLR	ADCSSL
;LAB3_Q1_final.c,245 :: 		ADCON3 = 0x0008; // Sample time = 15Tad, Tad = intern
	MOV	#8, W0
	MOV	WREG, ADCON3
;LAB3_Q1_final.c,246 :: 		ADCON2 = 0;
	CLR	ADCON2
;LAB3_Q1_final.c,247 :: 		ADCON2bits.SMPI = 0b1111; // Interrupt after every 16 samples
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	[W0], W1
	MOV.B	#60, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(ADCON2bits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,248 :: 		ADCON1.ADON = 1;
	BSET	ADCON1, #15
;LAB3_Q1_final.c,250 :: 		flag_seleciona = 0;
	CLR	W0
	MOV	W0, _flag_seleciona
;LAB3_Q1_final.c,251 :: 		flag_botao = 0;
	CLR	W0
	MOV	W0, _flag_botao
;LAB3_Q1_final.c,253 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;LAB3_Q1_final.c,256 :: 		TMR1 = 0x0000;
	CLR	TMR1
;LAB3_Q1_final.c,257 :: 		PR1 = 31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;LAB3_Q1_final.c,258 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;LAB3_Q1_final.c,260 :: 		T1CONbits.TCKPS = 0b11;
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	[W0], W1
	MOV.B	#48, W0
	IOR.B	W1, W0, W1
	MOV	#lo_addr(T1CONbits), W0
	MOV.B	W1, [W0]
;LAB3_Q1_final.c,261 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;LAB3_Q1_final.c,262 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;LAB3_Q1_final.c,265 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;LAB3_Q1_final.c,266 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB3_Q1_final.c,267 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;LAB3_Q1_final.c,269 :: 		while(1){
L_main41:
;LAB3_Q1_final.c,270 :: 		if (flag_seleciona > 1){
	MOV	_flag_seleciona, W0
	CP	W0, #1
	BRA GT	L__main74
	GOTO	L_main43
L__main74:
;LAB3_Q1_final.c,271 :: 		criatividade();
	CALL	_criatividade
;LAB3_Q1_final.c,272 :: 		}
L_main43:
;LAB3_Q1_final.c,273 :: 		}
	GOTO	L_main41
;LAB3_Q1_final.c,276 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
