
_GTMOint:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q4.c,39 :: 		void GTMOint() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;q4.c,40 :: 		IFS0bits.T1IF = 0;  // zera a flag do timer ap?s ela ser ativada
	BCLR.B	IFS0bits, #3
;q4.c,41 :: 		distancia = TMR1;   // Dist?ncia em cm
	MOV	TMR1, WREG
	MOV	W0, _distancia
;q4.c,42 :: 		TMR1 = 0;           // TMR1 ? zerado depois da contagem
	CLR	TMR1
;q4.c,43 :: 		}
L_end_GTMOint:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _GTMOint

_criativ:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q4.c,45 :: 		void criativ() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;q4.c,46 :: 		delay_ms(50);        // debouncing do botao
	MOV	#5, W8
	MOV	#4523, W7
L_criativ0:
	DEC	W7
	BRA NZ	L_criativ0
	DEC	W8
	BRA NZ	L_criativ0
;q4.c,47 :: 		flag = ~flag;        // sempre que o botao for acionado ele inverte o estado anterior
	MOV	#lo_addr(_flag), W0
	COM	[W0], [W0]
;q4.c,48 :: 		IFS0bits.INT0IF = 0; // interrup??o ? zerada e fica esperando ser acionada outra vez
	BCLR.B	IFS0bits, #0
;q4.c,49 :: 		}
L_end_criativ:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _criativ

_dis_play:
	LNK	#2

;q4.c,51 :: 		int dis_play(int valor){
;q4.c,53 :: 		switch(valor){
	GOTO	L_dis_play2
;q4.c,54 :: 		case 0: resp = 192;
L_dis_play4:
	MOV	#192, W0
	MOV	W0, [W14+0]
;q4.c,55 :: 		break;
	GOTO	L_dis_play3
;q4.c,56 :: 		case 1: resp = 249;
L_dis_play5:
	MOV	#249, W0
	MOV	W0, [W14+0]
;q4.c,57 :: 		break;
	GOTO	L_dis_play3
;q4.c,58 :: 		case 2: resp = 164;
L_dis_play6:
	MOV	#164, W0
	MOV	W0, [W14+0]
;q4.c,59 :: 		break;
	GOTO	L_dis_play3
;q4.c,60 :: 		case 3: resp = 176;
L_dis_play7:
	MOV	#176, W0
	MOV	W0, [W14+0]
;q4.c,61 :: 		break;
	GOTO	L_dis_play3
;q4.c,62 :: 		case 4: resp = 153;
L_dis_play8:
	MOV	#153, W0
	MOV	W0, [W14+0]
;q4.c,63 :: 		break;
	GOTO	L_dis_play3
;q4.c,64 :: 		case 5: resp = 146;
L_dis_play9:
	MOV	#146, W0
	MOV	W0, [W14+0]
;q4.c,65 :: 		break;
	GOTO	L_dis_play3
;q4.c,66 :: 		case 6: resp = 130;
L_dis_play10:
	MOV	#130, W0
	MOV	W0, [W14+0]
;q4.c,67 :: 		break;
	GOTO	L_dis_play3
;q4.c,68 :: 		case 7: resp = 248;
L_dis_play11:
	MOV	#248, W0
	MOV	W0, [W14+0]
;q4.c,69 :: 		break;
	GOTO	L_dis_play3
;q4.c,70 :: 		case 8: resp = 128;
L_dis_play12:
	MOV	#128, W0
	MOV	W0, [W14+0]
;q4.c,71 :: 		break;
	GOTO	L_dis_play3
;q4.c,72 :: 		case 9: resp = 152;
L_dis_play13:
	MOV	#152, W0
	MOV	W0, [W14+0]
;q4.c,73 :: 		break;
	GOTO	L_dis_play3
;q4.c,74 :: 		}
L_dis_play2:
	CP	W10, #0
	BRA NZ	L__dis_play173
	GOTO	L_dis_play4
L__dis_play173:
	CP	W10, #1
	BRA NZ	L__dis_play174
	GOTO	L_dis_play5
L__dis_play174:
	CP	W10, #2
	BRA NZ	L__dis_play175
	GOTO	L_dis_play6
L__dis_play175:
	CP	W10, #3
	BRA NZ	L__dis_play176
	GOTO	L_dis_play7
L__dis_play176:
	CP	W10, #4
	BRA NZ	L__dis_play177
	GOTO	L_dis_play8
L__dis_play177:
	CP	W10, #5
	BRA NZ	L__dis_play178
	GOTO	L_dis_play9
L__dis_play178:
	CP	W10, #6
	BRA NZ	L__dis_play179
	GOTO	L_dis_play10
L__dis_play179:
	CP	W10, #7
	BRA NZ	L__dis_play180
	GOTO	L_dis_play11
L__dis_play180:
	CP	W10, #8
	BRA NZ	L__dis_play181
	GOTO	L_dis_play12
L__dis_play181:
	CP	W10, #9
	BRA NZ	L__dis_play182
	GOTO	L_dis_play13
L__dis_play182:
L_dis_play3:
;q4.c,75 :: 		return resp;
	MOV	[W14+0], W0
;q4.c,76 :: 		}
L_end_dis_play:
	ULNK
	RETURN
; end of _dis_play

_conversao:
	LNK	#2

;q4.c,78 :: 		int conversao(float distancia){
;q4.c,80 :: 		dist_disp = distancia;
	MOV.D	W10, W0
	CALL	__Float2Longint
	MOV	W0, [W14+0]
;q4.c,82 :: 		unidade1 = (dist_disp/1)%10;
	MOV	#10, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
; unidade1 start address is: 6 (W3)
	MOV	W0, W3
;q4.c,83 :: 		dezena1 = (dist_disp/10)%10;
	MOV	#10, W2
	MOV	[W14+0], W0
	REPEAT	#17
	DIV.S	W0, W2
	MOV	#10, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
; dezena1 start address is: 8 (W4)
	MOV	W0, W4
;q4.c,84 :: 		centena1 = (dist_disp/100)%10;
	MOV	#100, W2
	MOV	[W14+0], W0
	REPEAT	#17
	DIV.S	W0, W2
	MOV	#10, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
; centena1 start address is: 2 (W1)
	MOV	W0, W1
;q4.c,86 :: 		for(Ia=0; Ia<3; Ia++) {  // multiplexa??o para exibi??o dos valores nos displays
; Ia start address is: 0 (W0)
	CLR	W0
; dezena1 end address is: 8 (W4)
; Ia end address is: 0 (W0)
	MOV	W4, W2
	MOV	W0, W4
L_conversao14:
; Ia start address is: 8 (W4)
; dezena1 start address is: 4 (W2)
; centena1 start address is: 2 (W1)
; centena1 end address is: 2 (W1)
; dezena1 start address is: 4 (W2)
; dezena1 end address is: 4 (W2)
; unidade1 start address is: 6 (W3)
; unidade1 end address is: 6 (W3)
	CP	W4, #3
	BRA LT	L__conversao184
	GOTO	L_conversao15
L__conversao184:
; centena1 end address is: 2 (W1)
; dezena1 end address is: 4 (W2)
; unidade1 end address is: 6 (W3)
;q4.c,87 :: 		switch (Ia){
; unidade1 start address is: 6 (W3)
; dezena1 start address is: 4 (W2)
; centena1 start address is: 2 (W1)
	GOTO	L_conversao17
;q4.c,88 :: 		case(0): mux1 = 0;
L_conversao19:
	BCLR.B	LATFbits, #0
;q4.c,89 :: 		mux2 = 0;
	BCLR.B	LATFbits, #1
;q4.c,90 :: 		mux3 = 1;
	BSET.B	LATFbits, #4
;q4.c,91 :: 		display = dis_play(unidade1);
	PUSH.D	W10
	MOV	W3, W10
	CALL	_dis_play
	POP.D	W10
	MOV	WREG, LATB
;q4.c,92 :: 		delay_ms(1);
	MOV	#5333, W7
L_conversao20:
	DEC	W7
	BRA NZ	L_conversao20
	NOP
;q4.c,93 :: 		mux1 = 0;
	BCLR.B	LATFbits, #0
;q4.c,94 :: 		mux2 = 0;
	BCLR.B	LATFbits, #1
;q4.c,95 :: 		mux3 = 0;
	BCLR.B	LATFbits, #4
;q4.c,96 :: 		break;
	GOTO	L_conversao18
;q4.c,97 :: 		case(1): mux1 = 0;
L_conversao22:
	BCLR.B	LATFbits, #0
;q4.c,98 :: 		mux2 = 1;
	BSET.B	LATFbits, #1
;q4.c,99 :: 		mux3 = 0;
	BCLR.B	LATFbits, #4
;q4.c,100 :: 		display = dis_play(dezena1);
	PUSH.D	W10
	MOV	W2, W10
	CALL	_dis_play
	POP.D	W10
	MOV	WREG, LATB
;q4.c,101 :: 		delay_ms(1);
	MOV	#5333, W7
L_conversao23:
	DEC	W7
	BRA NZ	L_conversao23
	NOP
;q4.c,102 :: 		mux1 = 0;
	BCLR.B	LATFbits, #0
;q4.c,103 :: 		mux2 = 0;
	BCLR.B	LATFbits, #1
;q4.c,104 :: 		mux3 = 0;
	BCLR.B	LATFbits, #4
;q4.c,105 :: 		break;
	GOTO	L_conversao18
;q4.c,106 :: 		case(2): mux1 = 1;
L_conversao25:
	BSET.B	LATFbits, #0
;q4.c,107 :: 		mux2 = 0;
	BCLR.B	LATFbits, #1
;q4.c,108 :: 		mux3 = 0;
	BCLR.B	LATFbits, #4
;q4.c,109 :: 		display = dis_play(centena1);
	PUSH.D	W10
	MOV	W1, W10
	CALL	_dis_play
	POP.D	W10
	MOV	WREG, LATB
;q4.c,110 :: 		delay_ms(1);
	MOV	#5333, W7
L_conversao26:
	DEC	W7
	BRA NZ	L_conversao26
	NOP
;q4.c,111 :: 		mux1 = 0;
	BCLR.B	LATFbits, #0
;q4.c,112 :: 		mux2 = 0;
	BCLR.B	LATFbits, #1
;q4.c,113 :: 		mux3 = 0;
	BCLR.B	LATFbits, #4
;q4.c,114 :: 		break;
	GOTO	L_conversao18
;q4.c,115 :: 		}
L_conversao17:
	CP	W4, #0
	BRA NZ	L__conversao185
	GOTO	L_conversao19
L__conversao185:
	CP	W4, #1
	BRA NZ	L__conversao186
	GOTO	L_conversao22
L__conversao186:
	CP	W4, #2
	BRA NZ	L__conversao187
	GOTO	L_conversao25
L__conversao187:
L_conversao18:
;q4.c,86 :: 		for(Ia=0; Ia<3; Ia++) {  // multiplexa??o para exibi??o dos valores nos displays
	INC	W4
;q4.c,116 :: 		}
; centena1 end address is: 2 (W1)
; dezena1 end address is: 4 (W2)
; unidade1 end address is: 6 (W3)
; Ia end address is: 8 (W4)
	GOTO	L_conversao14
L_conversao15:
;q4.c,117 :: 		}
L_end_conversao:
	ULNK
	RETURN
; end of _conversao

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q4.c,119 :: 		void main() {
;q4.c,120 :: 		ADPCFG = 0xFFFF;           // configura entradas e sa?das como digitais;
	PUSH	W10
	PUSH	W11
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q4.c,121 :: 		TRISB = 0x0000;            // PORTB como sa?da
	CLR	TRISB
;q4.c,122 :: 		TRISCbits.TRISC13 = 0;     // RC13 como sa?da
	BCLR	TRISCbits, #13
;q4.c,123 :: 		echo = 1;                  // T1CK como ENTRADA
	BSET	TRISCbits, #14
;q4.c,124 :: 		TRISD = 0x0000;            // PORTD como sa?da
	CLR	TRISD
;q4.c,125 :: 		TRISEbits.TRISE0 = 0;      // RE0 como SA?DA
	BCLR.B	TRISEbits, #0
;q4.c,126 :: 		TRISEbits.TRISE1 = 0;      // RE1 como SA?DA
	BCLR.B	TRISEbits, #1
;q4.c,127 :: 		TRISEbits.TRISE2 = 0;      // RE2 como SA?DA
	BCLR.B	TRISEbits, #2
;q4.c,128 :: 		TRISEbits.TRISE3 = 0;      // RE3 como SA?DA
	BCLR.B	TRISEbits, #3
;q4.c,129 :: 		TRISEbits.TRISE8 = 1;      // RE8 como ENTRADA (? a interrup??o)
	BSET	TRISEbits, #8
;q4.c,130 :: 		TRISF = 0x0000;            // PORTF como sa?da
	CLR	TRISF
;q4.c,131 :: 		IFS0 = 0;                  // flag de interrup??o do timer1
	CLR	IFS0
;q4.c,132 :: 		LATB = 0;
	CLR	LATB
;q4.c,133 :: 		LATC = 0;
	CLR	LATC
;q4.c,134 :: 		LATD = 0;                  // sa?das
	CLR	LATD
;q4.c,135 :: 		LATF = 0;
	CLR	LATF
;q4.c,137 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;q4.c,138 :: 		IEC0bits.T1IE = 1;         // o bit 3 do registrador IEC0 habilita a interrup??o do timer
	BSET.B	IEC0bits, #3
;q4.c,139 :: 		PR1 = 0xFFFF;              // coloca o pr no m?ximo pq ele vai contar o tempo que a onda do echo passou em alta
	MOV	#65535, W0
	MOV	WREG, PR1
;q4.c,140 :: 		PR2 = 16000;               // usado pra que a fun??o atraso_ms seja feita
	MOV	#16000, W0
	MOV	WREG, PR2
;q4.c,142 :: 		T1CON = 0x8070;            // ativamos o timer 1 e o prescaler fica em 256 p caber as contas
	MOV	#32880, W0
	MOV	WREG, T1CON
;q4.c,143 :: 		T2CON = 0x8000;            // ativamos o timer 2 na fun??o timer
	MOV	#32768, W0
	MOV	WREG, T2CON
;q4.c,145 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;q4.c,147 :: 		while(1){
L_main28:
;q4.c,148 :: 		dist_cm = (distancia*0.272);  // distancia multiplicada pela convers?o (256*62.5e-9*340/2)*100
	MOV	_distancia, W0
	CLR	W1
	CALL	__Long2Float
	MOV	#17302, W2
	MOV	#16011, W3
	CALL	__Mul_FP
	MOV	W0, _dist_cm
	MOV	W1, _dist_cm+2
;q4.c,149 :: 		trigger = 1;                  // inicio do pulso de ativa??o do sensor
	BSET.B	LATDbits, #2
;q4.c,150 :: 		delay_us(15);                 // dura??o do pulso de ativa??o do sensor
	MOV	#80, W7
L_main30:
	DEC	W7
	BRA NZ	L_main30
;q4.c,151 :: 		trigger = 0;                  // fim do pulso de ativa??o do sensor
	BCLR.B	LATDbits, #2
;q4.c,153 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,155 :: 		if(flag == 0) {
	MOV	_flag, W0
	CP	W0, #0
	BRA Z	L__main189
	GOTO	L_main32
L__main189:
;q4.c,156 :: 		if ((dist_cm > 200)){
	MOV	#0, W2
	MOV	#17224, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main190
	INC.B	W0
L__main190:
	CP0.B	W0
	BRA NZ	L__main191
	GOTO	L_main33
L__main191:
;q4.c,158 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,159 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,160 :: 		buzzer = 0; // buzzer sempre desligado
	BCLR.B	LATDbits, #3
;q4.c,161 :: 		rele1 = 1;  // rel?1 desligado
	BSET.B	LATEbits, #0
;q4.c,162 :: 		rele2 = 1;  // rel?2 desligado
	BSET.B	LATEbits, #1
;q4.c,163 :: 		rele3 = 1;  // rel?3 desligado
	BSET.B	LATEbits, #2
;q4.c,164 :: 		rele4 = 1;  // rel?4 desligado
	BSET.B	LATEbits, #3
;q4.c,165 :: 		}
	GOTO	L_main34
L_main33:
;q4.c,166 :: 		else if ((dist_cm > 180) && (dist_cm <= 200)){
	MOV	#0, W2
	MOV	#17204, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main192
	INC.B	W0
L__main192:
	CP0.B	W0
	BRA NZ	L__main193
	GOTO	L__main151
L__main193:
	MOV	#0, W2
	MOV	#17224, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main194
	INC.B	W0
L__main194:
	CP0.B	W0
	BRA NZ	L__main195
	GOTO	L__main150
L__main195:
L__main149:
;q4.c,167 :: 		rele1 = 0;
	BCLR.B	LATEbits, #0
;q4.c,168 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,169 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,170 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,172 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	CLR	W0
	MOV	W0, _aux
L_main38:
	MOV	_aux, W1
	MOV	#900, W0
	CP	W1, W0
	BRA LT	L__main196
	GOTO	L_main39
L__main196:
;q4.c,173 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,174 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,175 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,172 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,176 :: 		}
	GOTO	L_main38
L_main39:
;q4.c,178 :: 		rele1 = 0;
	BCLR.B	LATEbits, #0
;q4.c,179 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,180 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,181 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,183 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	CLR	W0
	MOV	W0, _aux
L_main41:
	MOV	_aux, W1
	MOV	#900, W0
	CP	W1, W0
	BRA LT	L__main197
	GOTO	L_main42
L__main197:
;q4.c,184 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,185 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,186 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,183 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,187 :: 		}
	GOTO	L_main41
L_main42:
;q4.c,188 :: 		}
	GOTO	L_main44
;q4.c,166 :: 		else if ((dist_cm > 180) && (dist_cm <= 200)){
L__main151:
L__main150:
;q4.c,189 :: 		else if ((dist_cm > 120) && (dist_cm <= 180)){
	MOV	#0, W2
	MOV	#17136, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main198
	INC.B	W0
L__main198:
	CP0.B	W0
	BRA NZ	L__main199
	GOTO	L__main153
L__main199:
	MOV	#0, W2
	MOV	#17204, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main200
	INC.B	W0
L__main200:
	CP0.B	W0
	BRA NZ	L__main201
	GOTO	L__main152
L__main201:
L__main148:
;q4.c,190 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,191 :: 		rele2 = 0;
	BCLR.B	LATEbits, #1
;q4.c,192 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,193 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,195 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	CLR	W0
	MOV	W0, _aux
L_main48:
	MOV	_aux, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LT	L__main202
	GOTO	L_main49
L__main202:
;q4.c,196 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,197 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,198 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,195 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,199 :: 		}
	GOTO	L_main48
L_main49:
;q4.c,201 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,202 :: 		rele2 = 0;
	BCLR.B	LATEbits, #1
;q4.c,203 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,204 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,206 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	CLR	W0
	MOV	W0, _aux
L_main51:
	MOV	_aux, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LT	L__main203
	GOTO	L_main52
L__main203:
;q4.c,207 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,208 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,209 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,206 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,210 :: 		}
	GOTO	L_main51
L_main52:
;q4.c,211 :: 		}
	GOTO	L_main54
;q4.c,189 :: 		else if ((dist_cm > 120) && (dist_cm <= 180)){
L__main153:
L__main152:
;q4.c,212 :: 		else if ((dist_cm > 80) && (dist_cm <= 120)){
	MOV	#0, W2
	MOV	#17056, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main204
	INC.B	W0
L__main204:
	CP0.B	W0
	BRA NZ	L__main205
	GOTO	L__main155
L__main205:
	MOV	#0, W2
	MOV	#17136, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main206
	INC.B	W0
L__main206:
	CP0.B	W0
	BRA NZ	L__main207
	GOTO	L__main154
L__main207:
L__main147:
;q4.c,213 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,214 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,215 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,216 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,218 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	CLR	W0
	MOV	W0, _aux
L_main58:
	MOV	_aux, W1
	MOV	#300, W0
	CP	W1, W0
	BRA LT	L__main208
	GOTO	L_main59
L__main208:
;q4.c,219 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,220 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,221 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,218 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,222 :: 		}
	GOTO	L_main58
L_main59:
;q4.c,224 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,225 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,226 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,227 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,229 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	CLR	W0
	MOV	W0, _aux
L_main61:
	MOV	_aux, W1
	MOV	#300, W0
	CP	W1, W0
	BRA LT	L__main209
	GOTO	L_main62
L__main209:
;q4.c,230 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,231 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,232 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,229 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,233 :: 		}
	GOTO	L_main61
L_main62:
;q4.c,234 :: 		}
	GOTO	L_main64
;q4.c,212 :: 		else if ((dist_cm > 80) && (dist_cm <= 120)){
L__main155:
L__main154:
;q4.c,235 :: 		else if ((dist_cm > 50) && (dist_cm <= 80)){
	MOV	#0, W2
	MOV	#16968, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main210
	INC.B	W0
L__main210:
	CP0.B	W0
	BRA NZ	L__main211
	GOTO	L__main157
L__main211:
	MOV	#0, W2
	MOV	#17056, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main212
	INC.B	W0
L__main212:
	CP0.B	W0
	BRA NZ	L__main213
	GOTO	L__main156
L__main213:
L__main146:
;q4.c,236 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,237 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,238 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,239 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,241 :: 		for(aux=0;aux<225;aux++) {   //atraso de 0.75 segundos
	CLR	W0
	MOV	W0, _aux
L_main68:
	MOV	#225, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main214
	GOTO	L_main69
L__main214:
;q4.c,242 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,243 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,244 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,241 :: 		for(aux=0;aux<225;aux++) {   //atraso de 0.75 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,245 :: 		}
	GOTO	L_main68
L_main69:
;q4.c,247 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,248 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,249 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,250 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,252 :: 		for(aux=0;aux<225;aux++) {
	CLR	W0
	MOV	W0, _aux
L_main71:
	MOV	#225, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main215
	GOTO	L_main72
L__main215:
;q4.c,253 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,254 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,255 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,252 :: 		for(aux=0;aux<225;aux++) {
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,256 :: 		}
	GOTO	L_main71
L_main72:
;q4.c,257 :: 		}
	GOTO	L_main74
;q4.c,235 :: 		else if ((dist_cm > 50) && (dist_cm <= 80)){
L__main157:
L__main156:
;q4.c,258 :: 		else if ((dist_cm > 20) && (dist_cm <= 50)){
	MOV	#0, W2
	MOV	#16800, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main216
	INC.B	W0
L__main216:
	CP0.B	W0
	BRA NZ	L__main217
	GOTO	L__main159
L__main217:
	MOV	#0, W2
	MOV	#16968, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main218
	INC.B	W0
L__main218:
	CP0.B	W0
	BRA NZ	L__main219
	GOTO	L__main158
L__main219:
L__main145:
;q4.c,259 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,260 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,261 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,262 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,264 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	CLR	W0
	MOV	W0, _aux
L_main78:
	MOV	#150, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main220
	GOTO	L_main79
L__main220:
;q4.c,265 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,266 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,267 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,264 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,268 :: 		}
	GOTO	L_main78
L_main79:
;q4.c,270 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,271 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,272 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,273 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,276 :: 		for(aux=0;aux<150;aux++){
	CLR	W0
	MOV	W0, _aux
L_main81:
	MOV	#150, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main221
	GOTO	L_main82
L__main221:
;q4.c,277 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,278 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,279 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,276 :: 		for(aux=0;aux<150;aux++){
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,280 :: 		}
	GOTO	L_main81
L_main82:
;q4.c,281 :: 		}
	GOTO	L_main84
;q4.c,258 :: 		else if ((dist_cm > 20) && (dist_cm <= 50)){
L__main159:
L__main158:
;q4.c,282 :: 		else if ((dist_cm <= 20)){
	MOV	#0, W2
	MOV	#16800, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main222
	INC.B	W0
L__main222:
	CP0.B	W0
	BRA NZ	L__main223
	GOTO	L_main85
L__main223:
;q4.c,283 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,284 :: 		buzzer = 1; // buzzer sempre ligado
	BSET.B	LATDbits, #3
;q4.c,285 :: 		rele1 = 0;  // rel?1 sempre ligado
	BCLR.B	LATEbits, #0
;q4.c,286 :: 		rele2 = 0;  // rel?2 sempre ligado
	BCLR.B	LATEbits, #1
;q4.c,287 :: 		rele3 = 0;  // rel?3 sempre ligado
	BCLR.B	LATEbits, #2
;q4.c,288 :: 		rele4 = 0;  // rel?4 sempre ligado
	BCLR.B	LATEbits, #3
;q4.c,289 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,290 :: 		}
L_main85:
L_main84:
L_main74:
L_main64:
L_main54:
L_main44:
L_main34:
;q4.c,291 :: 		}
	GOTO	L_main86
L_main32:
;q4.c,293 :: 		if ((dist_cm < 20)){
	MOV	#0, W2
	MOV	#16800, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__main224
	INC.B	W0
L__main224:
	CP0.B	W0
	BRA NZ	L__main225
	GOTO	L_main87
L__main225:
;q4.c,294 :: 		buzzer = 1; // buzzer sempre ligado
	BSET.B	LATDbits, #3
;q4.c,295 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,296 :: 		criatividade = 1;
	BSET.B	LATFbits, #5
;q4.c,298 :: 		rele1 = 0;  // rel?1 sempre ligado
	BCLR.B	LATEbits, #0
;q4.c,299 :: 		rele2 = 0;  // rel?2 sempre ligado
	BCLR.B	LATEbits, #1
;q4.c,300 :: 		rele3 = 0;  // rel?3 sempre ligado
	BCLR.B	LATEbits, #2
;q4.c,301 :: 		rele4 = 0;  // rel?4 sempre ligado
	BCLR.B	LATEbits, #3
;q4.c,302 :: 		}
	GOTO	L_main88
L_main87:
;q4.c,303 :: 		else if ((dist_cm > 20) && (dist_cm <= 50)){
	MOV	#0, W2
	MOV	#16800, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main226
	INC.B	W0
L__main226:
	CP0.B	W0
	BRA NZ	L__main227
	GOTO	L__main161
L__main227:
	MOV	#0, W2
	MOV	#16968, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main228
	INC.B	W0
L__main228:
	CP0.B	W0
	BRA NZ	L__main229
	GOTO	L__main160
L__main229:
L__main144:
;q4.c,304 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,305 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,306 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,307 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,309 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	CLR	W0
	MOV	W0, _aux
L_main92:
	MOV	#150, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main230
	GOTO	L_main93
L__main230:
;q4.c,310 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,311 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,312 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,309 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,313 :: 		}
	GOTO	L_main92
L_main93:
;q4.c,315 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,316 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,317 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,318 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,320 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	CLR	W0
	MOV	W0, _aux
L_main95:
	MOV	#150, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main231
	GOTO	L_main96
L__main231:
;q4.c,321 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,322 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,323 :: 		criatividade = 1;
	BSET.B	LATFbits, #5
;q4.c,320 :: 		for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,324 :: 		}
	GOTO	L_main95
L_main96:
;q4.c,325 :: 		}
	GOTO	L_main98
;q4.c,303 :: 		else if ((dist_cm > 20) && (dist_cm <= 50)){
L__main161:
L__main160:
;q4.c,326 :: 		else if ((dist_cm > 50) && (dist_cm <= 80)){
	MOV	#0, W2
	MOV	#16968, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main232
	INC.B	W0
L__main232:
	CP0.B	W0
	BRA NZ	L__main233
	GOTO	L__main163
L__main233:
	MOV	#0, W2
	MOV	#17056, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main234
	INC.B	W0
L__main234:
	CP0.B	W0
	BRA NZ	L__main235
	GOTO	L__main162
L__main235:
L__main143:
;q4.c,327 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,328 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,329 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,330 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,332 :: 		for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
	CLR	W0
	MOV	W0, _aux
L_main102:
	MOV	#225, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main236
	GOTO	L_main103
L__main236:
;q4.c,333 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,334 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,335 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,332 :: 		for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,336 :: 		}
	GOTO	L_main102
L_main103:
;q4.c,338 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,339 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,340 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,341 :: 		rele4 = 0;
	BCLR.B	LATEbits, #3
;q4.c,343 :: 		for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
	CLR	W0
	MOV	W0, _aux
L_main105:
	MOV	#225, W1
	MOV	#lo_addr(_aux), W0
	CP	W1, [W0]
	BRA GT	L__main237
	GOTO	L_main106
L__main237:
;q4.c,344 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,345 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,346 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,343 :: 		for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,347 :: 		}
	GOTO	L_main105
L_main106:
;q4.c,348 :: 		}
	GOTO	L_main108
;q4.c,326 :: 		else if ((dist_cm > 50) && (dist_cm <= 80)){
L__main163:
L__main162:
;q4.c,349 :: 		else if ((dist_cm > 80) && (dist_cm <= 120)){
	MOV	#0, W2
	MOV	#17056, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main238
	INC.B	W0
L__main238:
	CP0.B	W0
	BRA NZ	L__main239
	GOTO	L__main165
L__main239:
	MOV	#0, W2
	MOV	#17136, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main240
	INC.B	W0
L__main240:
	CP0.B	W0
	BRA NZ	L__main241
	GOTO	L__main164
L__main241:
L__main142:
;q4.c,350 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,351 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,352 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,353 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,355 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	CLR	W0
	MOV	W0, _aux
L_main112:
	MOV	_aux, W1
	MOV	#300, W0
	CP	W1, W0
	BRA LT	L__main242
	GOTO	L_main113
L__main242:
;q4.c,356 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,357 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,358 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,355 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,359 :: 		}
	GOTO	L_main112
L_main113:
;q4.c,361 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,362 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,363 :: 		rele3 = 0;
	BCLR.B	LATEbits, #2
;q4.c,364 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,366 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	CLR	W0
	MOV	W0, _aux
L_main115:
	MOV	_aux, W1
	MOV	#300, W0
	CP	W1, W0
	BRA LT	L__main243
	GOTO	L_main116
L__main243:
;q4.c,367 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,368 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,369 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,366 :: 		for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,370 :: 		}
	GOTO	L_main115
L_main116:
;q4.c,371 :: 		}
	GOTO	L_main118
;q4.c,349 :: 		else if ((dist_cm > 80) && (dist_cm <= 120)){
L__main165:
L__main164:
;q4.c,372 :: 		else if ((dist_cm > 120) && (dist_cm <= 180)){
	MOV	#0, W2
	MOV	#17136, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main244
	INC.B	W0
L__main244:
	CP0.B	W0
	BRA NZ	L__main245
	GOTO	L__main167
L__main245:
	MOV	#0, W2
	MOV	#17204, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main246
	INC.B	W0
L__main246:
	CP0.B	W0
	BRA NZ	L__main247
	GOTO	L__main166
L__main247:
L__main141:
;q4.c,373 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,374 :: 		rele2 = 0;
	BCLR.B	LATEbits, #1
;q4.c,375 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,376 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,378 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	CLR	W0
	MOV	W0, _aux
L_main122:
	MOV	_aux, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LT	L__main248
	GOTO	L_main123
L__main248:
;q4.c,379 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,380 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,381 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,378 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,382 :: 		}
	GOTO	L_main122
L_main123:
;q4.c,384 :: 		rele1 = 1;
	BSET.B	LATEbits, #0
;q4.c,385 :: 		rele2 = 0;
	BCLR.B	LATEbits, #1
;q4.c,386 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,387 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,389 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	CLR	W0
	MOV	W0, _aux
L_main125:
	MOV	_aux, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LT	L__main249
	GOTO	L_main126
L__main249:
;q4.c,390 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,391 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,392 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,389 :: 		for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,393 :: 		}
	GOTO	L_main125
L_main126:
;q4.c,394 :: 		}
	GOTO	L_main128
;q4.c,372 :: 		else if ((dist_cm > 120) && (dist_cm <= 180)){
L__main167:
L__main166:
;q4.c,395 :: 		else if ((dist_cm > 180) && (dist_cm <= 200)){
	MOV	#0, W2
	MOV	#17204, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main250
	INC.B	W0
L__main250:
	CP0.B	W0
	BRA NZ	L__main251
	GOTO	L__main169
L__main251:
	MOV	#0, W2
	MOV	#17224, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__main252
	INC.B	W0
L__main252:
	CP0.B	W0
	BRA NZ	L__main253
	GOTO	L__main168
L__main253:
L__main140:
;q4.c,396 :: 		rele1 = 0;
	BCLR.B	LATEbits, #0
;q4.c,397 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,398 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,399 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,401 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	CLR	W0
	MOV	W0, _aux
L_main132:
	MOV	_aux, W1
	MOV	#900, W0
	CP	W1, W0
	BRA LT	L__main254
	GOTO	L_main133
L__main254:
;q4.c,402 :: 		buzzer = 0;
	BCLR.B	LATDbits, #3
;q4.c,403 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,404 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,401 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,405 :: 		}
	GOTO	L_main132
L_main133:
;q4.c,407 :: 		rele1 = 0;
	BCLR.B	LATEbits, #0
;q4.c,408 :: 		rele2 = 1;
	BSET.B	LATEbits, #1
;q4.c,409 :: 		rele3 = 1;
	BSET.B	LATEbits, #2
;q4.c,410 :: 		rele4 = 1;
	BSET.B	LATEbits, #3
;q4.c,412 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	CLR	W0
	MOV	W0, _aux
L_main135:
	MOV	_aux, W1
	MOV	#900, W0
	CP	W1, W0
	BRA LT	L__main255
	GOTO	L_main136
L__main255:
;q4.c,413 :: 		buzzer = 1;
	BSET.B	LATDbits, #3
;q4.c,414 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,415 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,412 :: 		for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
	MOV	#1, W1
	MOV	#lo_addr(_aux), W0
	ADD	W1, [W0], [W0]
;q4.c,416 :: 		}
	GOTO	L_main135
L_main136:
;q4.c,417 :: 		}
	GOTO	L_main138
;q4.c,395 :: 		else if ((dist_cm > 180) && (dist_cm <= 200)){
L__main169:
L__main168:
;q4.c,418 :: 		else if ((dist_cm > 200)){
	MOV	#0, W2
	MOV	#17224, W3
	MOV	_dist_cm, W0
	MOV	_dist_cm+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LE	L__main256
	INC.B	W0
L__main256:
	CP0.B	W0
	BRA NZ	L__main257
	GOTO	L_main139
L__main257:
;q4.c,419 :: 		buzzer = 0; // buzzer sempre desligado
	BCLR.B	LATDbits, #3
;q4.c,420 :: 		conversao(dist_cm);
	MOV	_dist_cm, W10
	MOV	_dist_cm+2, W11
	CALL	_conversao
;q4.c,421 :: 		rele1 = 1;  // rel?1 desligado
	BSET.B	LATEbits, #0
;q4.c,422 :: 		rele2 = 1;  // rel?2 desligado
	BSET.B	LATEbits, #1
;q4.c,423 :: 		rele3 = 1;  // rel?3 desligado
	BSET.B	LATEbits, #2
;q4.c,424 :: 		rele4 = 1;  // rel?4 desligado
	BSET.B	LATEbits, #3
;q4.c,425 :: 		criatividade = 0;
	BCLR.B	LATFbits, #5
;q4.c,426 :: 		}
L_main139:
L_main138:
L_main128:
L_main118:
L_main108:
L_main98:
L_main88:
;q4.c,427 :: 		}
L_main86:
;q4.c,428 :: 		}
	GOTO	L_main28
;q4.c,429 :: 		} // fim void
L_end_main:
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
