
_criatividade:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB2_Q3.c,32 :: 		void criatividade() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
;LAB2_Q3.c,33 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_criatividade0:
	DEC	W7
	BRA NZ	L_criatividade0
	DEC	W8
	BRA NZ	L_criatividade0
;LAB2_Q3.c,35 :: 		flag_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_criatividade), W0
	ADD	W1, [W0], [W0]
;LAB2_Q3.c,37 :: 		if (flag_criatividade > 2){
	MOV	_flag_criatividade, W0
	CP	W0, #2
	BRA GT	L__criatividade26
	GOTO	L_criatividade2
L__criatividade26:
;LAB2_Q3.c,38 :: 		flag_criatividade = 0;
	CLR	W0
	MOV	W0, _flag_criatividade
;LAB2_Q3.c,39 :: 		}
L_criatividade2:
;LAB2_Q3.c,41 :: 		IFS1bits.INT2IF = 0;
	BCLR.B	IFS1bits, #7
;LAB2_Q3.c,42 :: 		}
L_end_criatividade:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _criatividade

_distancia:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB2_Q3.c,44 :: 		void distancia() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;LAB2_Q3.c,45 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;LAB2_Q3.c,46 :: 		dist_cm = (TMR1*0.272);  //Distância em cm
	MOV	TMR1, WREG
	CLR	W1
	CALL	__Long2Float
	MOV	#17302, W2
	MOV	#16011, W3
	CALL	__Mul_FP
	MOV	W0, _dist_cm
	MOV	W1, _dist_cm+2
;LAB2_Q3.c,47 :: 		TMR1 = 0;                                  //TMR1 é zerado depois da contagem
	CLR	TMR1
;LAB2_Q3.c,48 :: 		}
L_end_distancia:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _distancia

_temporizador:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB2_Q3.c,50 :: 		void temporizador() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;LAB2_Q3.c,51 :: 		tempo--;
	MOV	#1, W1
	MOV	#lo_addr(_tempo), W0
	SUBR	W1, [W0], [W0]
;LAB2_Q3.c,52 :: 		if (tempo == 0){
	MOV	_tempo, W0
	CP	W0, #0
	BRA Z	L__temporizador29
	GOTO	L_temporizador3
L__temporizador29:
;LAB2_Q3.c,53 :: 		T2CON = 0x0000;
	CLR	T2CON
;LAB2_Q3.c,54 :: 		TMR2 = 0;
	CLR	TMR2
;LAB2_Q3.c,55 :: 		tempo = 10;
	MOV	#10, W0
	MOV	W0, _tempo
;LAB2_Q3.c,56 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;LAB2_Q3.c,57 :: 		}
L_temporizador3:
;LAB2_Q3.c,58 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;LAB2_Q3.c,59 :: 		}
L_end_temporizador:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _temporizador

_botao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB2_Q3.c,62 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;LAB2_Q3.c,63 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao4:
	DEC	W7
	BRA NZ	L_botao4
	DEC	W8
	BRA NZ	L_botao4
;LAB2_Q3.c,64 :: 		if (flag == 1){
	MOV	_flag, W0
	CP	W0, #1
	BRA Z	L__botao31
	GOTO	L_botao6
L__botao31:
;LAB2_Q3.c,65 :: 		T2CON = 0x0000;
	CLR	T2CON
;LAB2_Q3.c,66 :: 		TMR2 = 0;
	CLR	TMR2
;LAB2_Q3.c,67 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;LAB2_Q3.c,68 :: 		tempo = 10;
	MOV	#10, W0
	MOV	W0, _tempo
;LAB2_Q3.c,69 :: 		}else{
	GOTO	L_botao7
L_botao6:
;LAB2_Q3.c,70 :: 		T2CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T2CON
;LAB2_Q3.c,71 :: 		flag = 1;
	MOV	#1, W0
	MOV	W0, _flag
;LAB2_Q3.c,72 :: 		}
L_botao7:
;LAB2_Q3.c,73 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;LAB2_Q3.c,74 :: 		}
L_end_botao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB2_Q3.c,78 :: 		void main() {
;LAB2_Q3.c,79 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB2_Q3.c,80 :: 		IFS0 = 0;
	CLR	IFS0
;LAB2_Q3.c,81 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;LAB2_Q3.c,82 :: 		tempo = 10;
	MOV	#10, W0
	MOV	W0, _tempo
;LAB2_Q3.c,83 :: 		flag_criatividade = 0;
	CLR	W0
	MOV	W0, _flag_criatividade
;LAB2_Q3.c,85 :: 		TRISD = 0;                 // PORTD como saída
	CLR	TRISD
;LAB2_Q3.c,86 :: 		TRISE = 0;
	CLR	TRISE
;LAB2_Q3.c,87 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;LAB2_Q3.c,88 :: 		TRISCbits.TRISC14 = 1;     // T1CK como entrada
	BSET	TRISCbits, #14
;LAB2_Q3.c,89 :: 		TRISDbits.TRISD1 = 1;
	BSET.B	TRISDbits, #1
;LAB2_Q3.c,91 :: 		IEC0bits.T1IE = 1;         // o bit 3 do registrador IEC0 habilita a interrupção do timer
	BSET.B	IEC0bits, #3
;LAB2_Q3.c,92 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;LAB2_Q3.c,93 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;LAB2_Q3.c,94 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;LAB2_Q3.c,95 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;LAB2_Q3.c,97 :: 		INTCON2bits.INT0EP = 0;
	BCLR.B	INTCON2bits, #0
;LAB2_Q3.c,98 :: 		INTCON2bits.INT2EP = 0;
	BCLR.B	INTCON2bits, #2
;LAB2_Q3.c,100 :: 		T2CON = 0x0000;
	CLR	T2CON
;LAB2_Q3.c,101 :: 		TMR2 = 0;
	CLR	TMR2
;LAB2_Q3.c,102 :: 		PR2 = 62500;
	MOV	#62500, W0
	MOV	WREG, PR2
;LAB2_Q3.c,104 :: 		PR1 = 0xFFFF;              // coloca o pr no máximo pq ele vai contar o tempo que a onda do echo passou em alta
	MOV	#65535, W0
	MOV	WREG, PR1
;LAB2_Q3.c,105 :: 		T1CON = 0x8070;            // ativamos o timer 1 e o prescaler fica em 256 p caber as contas
	MOV	#32880, W0
	MOV	WREG, T1CON
;LAB2_Q3.c,107 :: 		Lcd_Init();                // Inicializa o LCD
	CALL	_Lcd_Init
;LAB2_Q3.c,108 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB2_Q3.c,109 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;LAB2_Q3.c,111 :: 		while(1){
L_main8:
;LAB2_Q3.c,112 :: 		if (flag_criatividade == 0){ //criatividade desativada
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__main33
	GOTO	L_main10
L__main33:
;LAB2_Q3.c,113 :: 		if (flag == 1){
	MOV	_flag, W0
	CP	W0, #1
	BRA Z	L__main34
	GOTO	L_main11
L__main34:
;LAB2_Q3.c,114 :: 		altura = 200 - dist_cm;
	MOV	#0, W0
	MOV	#17224, W1
	MOV	_dist_cm, W2
	MOV	_dist_cm+2, W3
	CALL	__Sub_FP
	CALL	__Float2Longint
	MOV	W0, _altura
	MOV	W1, _altura+2
;LAB2_Q3.c,115 :: 		IntToStr(altura,txt);  // Converte o valor da variável em texto pra ser exibido no display
	MOV	#lo_addr(_txt), W11
	MOV	W0, W10
	CALL	_IntToStr
;LAB2_Q3.c,116 :: 		IntToStr(tempo,txt2);  // Converte o valor da variável em texto pra ser exibido no display
	MOV	#lo_addr(_txt2), W11
	MOV	_tempo, W10
	CALL	_IntToStr
;LAB2_Q3.c,117 :: 		trigger = 1;              // Pulso que indica o início da medição
	BSET.B	LATDbits, #2
;LAB2_Q3.c,118 :: 		delay_us(15);             // duração do pulso de ativação do sensor
	MOV	#80, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
;LAB2_Q3.c,119 :: 		trigger = 0;              // Fim do pulso de ativação do sensor
	BCLR.B	LATDbits, #2
;LAB2_Q3.c,120 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB2_Q3.c,121 :: 		Lcd_Out(1,1,txt);  // exibe no display "Distancia em cm:"
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,122 :: 		Lcd_Out(2,1,txt2);                 // exibe no display o valor da distância calculado
	MOV	#lo_addr(_txt2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,123 :: 		Lcd_out(1,8,"cm");
	MOV	#lo_addr(?lstr1_LAB2_Q3), W12
	MOV	#8, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,124 :: 		delay_ms(500);                    // tempo entre uma medição e outra (0.5 segundos)
	MOV	#41, W8
	MOV	#45239, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;LAB2_Q3.c,125 :: 		}else{
	GOTO	L_main16
L_main11:
;LAB2_Q3.c,126 :: 		Lcd_Out(1,1,"Altura:                 ");  // exibe no display "Distancia em cm:"
	MOV	#lo_addr(?lstr2_LAB2_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,127 :: 		Lcd_Out(2,1,"Tempo:                  ");                 // exibe no display o valor da distância calculado
	MOV	#lo_addr(?lstr3_LAB2_Q3), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,128 :: 		}
L_main16:
;LAB2_Q3.c,129 :: 		}else{     //criatividade ativada
	GOTO	L_main17
L_main10:
;LAB2_Q3.c,131 :: 		trigger = 1;              // Pulso que indica o início da medição
	BSET.B	LATDbits, #2
;LAB2_Q3.c,132 :: 		delay_us(15);             // duração do pulso de ativação do sensor
	MOV	#80, W7
L_main18:
	DEC	W7
	BRA NZ	L_main18
;LAB2_Q3.c,133 :: 		trigger = 0;              // Fim do pulso de ativação do sensor
	BCLR.B	LATDbits, #2
;LAB2_Q3.c,135 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main20:
	DEC	W7
	BRA NZ	L_main20
	DEC	W8
	BRA NZ	L_main20
;LAB2_Q3.c,137 :: 		altura = 200 - dist_cm;
	MOV	#0, W0
	MOV	#17224, W1
	MOV	_dist_cm, W2
	MOV	_dist_cm+2, W3
	CALL	__Sub_FP
	CALL	__Float2Longint
	MOV	W0, _altura
	MOV	W1, _altura+2
;LAB2_Q3.c,139 :: 		if(flag_criatividade == 1){     //IMC para homens
	MOV	_flag_criatividade, W0
	CP	W0, #1
	BRA Z	L__main35
	GOTO	L_main22
L__main35:
;LAB2_Q3.c,140 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB2_Q3.c,141 :: 		massa_min = floor(20.7*(altura*altura)/10000);
	MOV	_altura, W0
	MOV	_altura+2, W1
	MOV	_altura, W2
	MOV	_altura+2, W3
	CALL	__Multiply_32x32
	SETM	W2
	CALL	__Long2Float
	MOV	#39322, W2
	MOV	#16805, W3
	CALL	__Mul_FP
	MOV	#16384, W2
	MOV	#17948, W3
	CALL	__Div_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _massa_min
;LAB2_Q3.c,142 :: 		massa_max = floor(24.9*(altura*altura)/10000);
	MOV	_altura, W0
	MOV	_altura+2, W1
	MOV	_altura, W2
	MOV	_altura+2, W3
	CALL	__Multiply_32x32
	SETM	W2
	CALL	__Long2Float
	MOV	#13107, W2
	MOV	#16839, W3
	CALL	__Mul_FP
	MOV	#16384, W2
	MOV	#17948, W3
	CALL	__Div_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _massa_max
;LAB2_Q3.c,144 :: 		IntToStr(massa_max,txt);
	MOV	#lo_addr(_txt), W11
	MOV	W0, W10
	CALL	_IntToStr
;LAB2_Q3.c,145 :: 		IntToStr(massa_min,txt2);
	MOV	#lo_addr(_txt2), W11
	MOV	_massa_min, W10
	CALL	_IntToStr
;LAB2_Q3.c,147 :: 		ltrim(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_Ltrim
;LAB2_Q3.c,148 :: 		ltrim(txt2);
	MOV	#lo_addr(_txt2), W10
	CALL	_Ltrim
;LAB2_Q3.c,150 :: 		Lcd_Out(1,1,"Massa ideal Masc");  // exibe no display "massa ideal para homens"
	MOV	#lo_addr(?lstr4_LAB2_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,151 :: 		Lcd_Out(2,1,txt2);                 // exibe no display da massa calculada
	MOV	#lo_addr(_txt2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,152 :: 		Lcd_Out(2,3," Kg a ");
	MOV	#lo_addr(?lstr5_LAB2_Q3), W12
	MOV	#3, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,153 :: 		Lcd_Out(2,9,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#9, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,154 :: 		Lcd_Out(2,12,"Kg");
	MOV	#lo_addr(?lstr6_LAB2_Q3), W12
	MOV	#12, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,156 :: 		}else if (flag_criatividade == 2){  //IMC para mulheres
	GOTO	L_main23
L_main22:
	MOV	_flag_criatividade, W0
	CP	W0, #2
	BRA Z	L__main36
	GOTO	L_main24
L__main36:
;LAB2_Q3.c,157 :: 		Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB2_Q3.c,158 :: 		massa_min = floor(19.1*(altura*altura)/10000);
	MOV	_altura, W0
	MOV	_altura+2, W1
	MOV	_altura, W2
	MOV	_altura+2, W3
	CALL	__Multiply_32x32
	SETM	W2
	CALL	__Long2Float
	MOV	#52429, W2
	MOV	#16792, W3
	CALL	__Mul_FP
	MOV	#16384, W2
	MOV	#17948, W3
	CALL	__Div_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _massa_min
;LAB2_Q3.c,159 :: 		massa_max = floor(25.8*(altura*altura)/10000);
	MOV	_altura, W0
	MOV	_altura+2, W1
	MOV	_altura, W2
	MOV	_altura+2, W3
	CALL	__Multiply_32x32
	SETM	W2
	CALL	__Long2Float
	MOV	#26214, W2
	MOV	#16846, W3
	CALL	__Mul_FP
	MOV	#16384, W2
	MOV	#17948, W3
	CALL	__Div_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _massa_max
;LAB2_Q3.c,161 :: 		IntToStr(massa_max,txt);
	MOV	#lo_addr(_txt), W11
	MOV	W0, W10
	CALL	_IntToStr
;LAB2_Q3.c,162 :: 		IntToStr(massa_min,txt2);
	MOV	#lo_addr(_txt2), W11
	MOV	_massa_min, W10
	CALL	_IntToStr
;LAB2_Q3.c,164 :: 		ltrim(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_Ltrim
;LAB2_Q3.c,165 :: 		ltrim(txt2);
	MOV	#lo_addr(_txt2), W10
	CALL	_Ltrim
;LAB2_Q3.c,167 :: 		Lcd_Out(1,1,"Massa ideal Femi");  // exibe no display "massa ideal para mulheres"
	MOV	#lo_addr(?lstr7_LAB2_Q3), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,168 :: 		Lcd_Out(2,1,txt2);                 // exibe no display da massa calculada
	MOV	#lo_addr(_txt2), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,169 :: 		Lcd_Out(2,3," Kg a ");
	MOV	#lo_addr(?lstr8_LAB2_Q3), W12
	MOV	#3, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,170 :: 		Lcd_Out(2,9,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#9, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,171 :: 		Lcd_Out(2,12,"Kg");
	MOV	#lo_addr(?lstr9_LAB2_Q3), W12
	MOV	#12, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB2_Q3.c,173 :: 		}
L_main24:
L_main23:
;LAB2_Q3.c,174 :: 		}
L_main17:
;LAB2_Q3.c,175 :: 		}
	GOTO	L_main8
;LAB2_Q3.c,176 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
