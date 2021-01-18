
_INT0_Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q222.c,44 :: 		void INT0_Int() iv IVT_ADDR_INT0INTERRUPT{
;q222.c,45 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_INT0_Int0:
	DEC	W7
	BRA NZ	L_INT0_Int0
	DEC	W8
	BRA NZ	L_INT0_Int0
;q222.c,46 :: 		if (flag_c == 0){
	MOV	_flag_c, W0
	CP	W0, #0
	BRA Z	L__INT0_Int48
	GOTO	L_INT0_Int2
L__INT0_Int48:
;q222.c,47 :: 		flag_c = 1;
	MOV	#1, W0
	MOV	W0, _flag_c
;q222.c,48 :: 		}else{
	GOTO	L_INT0_Int3
L_INT0_Int2:
;q222.c,49 :: 		flag_c = 0;
	CLR	W0
	MOV	W0, _flag_c
;q222.c,50 :: 		}
L_INT0_Int3:
;q222.c,53 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;q222.c,54 :: 		}
L_end_INT0_Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _INT0_Int

_INT2_Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q222.c,57 :: 		void INT2_Int() iv IVT_ADDR_INT2INTERRUPT{
;q222.c,58 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_INT2_Int4:
	DEC	W7
	BRA NZ	L_INT2_Int4
	DEC	W8
	BRA NZ	L_INT2_Int4
;q222.c,60 :: 		cont_int++;    // a cada vez que a interrupcao 2 e ativada cont_int incrementa 1
	MOV	#1, W1
	MOV	#lo_addr(_cont_int), W0
	ADD	W1, [W0], [W0]
;q222.c,61 :: 		if (cont_int > 3){
	MOV	_cont_int, W0
	CP	W0, #3
	BRA GT	L__INT2_Int50
	GOTO	L_INT2_Int6
L__INT2_Int50:
;q222.c,62 :: 		cont_int = 1;
	MOV	#1, W0
	MOV	W0, _cont_int
;q222.c,63 :: 		}
L_INT2_Int6:
;q222.c,64 :: 		IFS1bits.INT2IF = 0; //interrupcao externa 2 e desativada
	BCLR.B	IFS1bits, #7
;q222.c,65 :: 		TMR2 = 0;
	CLR	TMR2
;q222.c,66 :: 		TMR3 = 0;
	CLR	TMR3
;q222.c,67 :: 		}
L_end_INT2_Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _INT2_Int

_janela_de_tempo:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q222.c,71 :: 		void janela_de_tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;q222.c,73 :: 		frequencia1 = TMR2;
	MOV	TMR2, WREG
	CLR	W1
	MOV	W0, _frequencia1
	MOV	W1, _frequencia1+2
;q222.c,74 :: 		frequencia2 = TMR3;
	MOV	TMR3, WREG
	CLR	W1
	MOV	W0, _frequencia2
	MOV	W1, _frequencia2+2
;q222.c,76 :: 		TMR2 = 0;
	CLR	TMR2
;q222.c,77 :: 		TMR3 = 0;
	CLR	TMR3
;q222.c,79 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;q222.c,81 :: 		IFS0bits.T3IF = 0;
	BCLR.B	IFS0bits, #7
;q222.c,86 :: 		}
L_end_janela_de_tempo:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _janela_de_tempo

_criatividade:

;q222.c,88 :: 		void criatividade(int num){
;q222.c,89 :: 		switch(num){
	GOTO	L_criatividade7
;q222.c,90 :: 		case 0:
L_criatividade9:
;q222.c,91 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;q222.c,92 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;q222.c,93 :: 		LATBbits.LATB2 = 0;
	BCLR.B	LATBbits, #2
;q222.c,94 :: 		LATBbits.LATB3 = 0;
	BCLR.B	LATBbits, #3
;q222.c,95 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,96 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,97 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,98 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,99 :: 		break;
	GOTO	L_criatividade8
;q222.c,100 :: 		case 1:
L_criatividade10:
;q222.c,101 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,102 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;q222.c,103 :: 		LATBbits.LATB2 = 0;
	BCLR.B	LATBbits, #2
;q222.c,104 :: 		LATBbits.LATB3 = 0;
	BCLR.B	LATBbits, #3
;q222.c,105 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,106 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,107 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,108 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,109 :: 		break;
	GOTO	L_criatividade8
;q222.c,110 :: 		case 2:
L_criatividade11:
;q222.c,111 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,112 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,113 :: 		LATBbits.LATB2 = 0;
	BCLR.B	LATBbits, #2
;q222.c,114 :: 		LATBbits.LATB3 = 0;
	BCLR.B	LATBbits, #3
;q222.c,115 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,116 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,117 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,118 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,119 :: 		break;
	GOTO	L_criatividade8
;q222.c,120 :: 		case 3:
L_criatividade12:
;q222.c,121 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,122 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,123 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,124 :: 		LATBbits.LATB3 = 0;
	BCLR.B	LATBbits, #3
;q222.c,125 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,126 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,127 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,128 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,129 :: 		break;
	GOTO	L_criatividade8
;q222.c,130 :: 		case 4:
L_criatividade13:
;q222.c,131 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,132 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,133 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,134 :: 		LATBbits.LATB3 = 1;
	BSET.B	LATBbits, #3
;q222.c,135 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,136 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,137 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,138 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,139 :: 		break;
	GOTO	L_criatividade8
;q222.c,140 :: 		case 5:
L_criatividade14:
;q222.c,141 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,142 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,143 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,144 :: 		LATBbits.LATB3 = 1;
	BSET.B	LATBbits, #3
;q222.c,145 :: 		LATBbits.LATB4 = 1;
	BSET.B	LATBbits, #4
;q222.c,146 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,147 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,148 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,149 :: 		break;
	GOTO	L_criatividade8
;q222.c,150 :: 		case 6:
L_criatividade15:
;q222.c,151 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,152 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,153 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,154 :: 		LATBbits.LATB3 = 1;
	BSET.B	LATBbits, #3
;q222.c,155 :: 		LATBbits.LATB4 = 1;
	BSET.B	LATBbits, #4
;q222.c,156 :: 		LATBbits.LATB5 = 1;
	BSET.B	LATBbits, #5
;q222.c,157 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,158 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,159 :: 		break;
	GOTO	L_criatividade8
;q222.c,160 :: 		case 7:
L_criatividade16:
;q222.c,161 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,162 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,163 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,164 :: 		LATBbits.LATB3 = 1;
	BSET.B	LATBbits, #3
;q222.c,165 :: 		LATBbits.LATB4 = 1;
	BSET.B	LATBbits, #4
;q222.c,166 :: 		LATBbits.LATB5 = 1;
	BSET.B	LATBbits, #5
;q222.c,167 :: 		LATBbits.LATB6 = 1;
	BSET.B	LATBbits, #6
;q222.c,168 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,169 :: 		break;
	GOTO	L_criatividade8
;q222.c,170 :: 		case 8:
L_criatividade17:
;q222.c,171 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q222.c,172 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;q222.c,173 :: 		LATBbits.LATB2 = 1;
	BSET.B	LATBbits, #2
;q222.c,174 :: 		LATBbits.LATB3 = 1;
	BSET.B	LATBbits, #3
;q222.c,175 :: 		LATBbits.LATB4 = 1;
	BSET.B	LATBbits, #4
;q222.c,176 :: 		LATBbits.LATB5 = 1;
	BSET.B	LATBbits, #5
;q222.c,177 :: 		LATBbits.LATB6 = 1;
	BSET.B	LATBbits, #6
;q222.c,178 :: 		LATBbits.LATB7 = 1;
	BSET.B	LATBbits, #7
;q222.c,179 :: 		break;
	GOTO	L_criatividade8
;q222.c,180 :: 		default:
L_criatividade18:
;q222.c,181 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;q222.c,182 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;q222.c,183 :: 		LATBbits.LATB2 = 0;
	BCLR.B	LATBbits, #2
;q222.c,184 :: 		LATBbits.LATB3 = 0;
	BCLR.B	LATBbits, #3
;q222.c,185 :: 		LATBbits.LATB4 = 0;
	BCLR.B	LATBbits, #4
;q222.c,186 :: 		LATBbits.LATB5 = 0;
	BCLR.B	LATBbits, #5
;q222.c,187 :: 		LATBbits.LATB6 = 0;
	BCLR.B	LATBbits, #6
;q222.c,188 :: 		LATBbits.LATB7 = 0;
	BCLR.B	LATBbits, #7
;q222.c,189 :: 		break;
	GOTO	L_criatividade8
;q222.c,190 :: 		}
L_criatividade7:
	CP	W10, #0
	BRA NZ	L__criatividade53
	GOTO	L_criatividade9
L__criatividade53:
	CP	W10, #1
	BRA NZ	L__criatividade54
	GOTO	L_criatividade10
L__criatividade54:
	CP	W10, #2
	BRA NZ	L__criatividade55
	GOTO	L_criatividade11
L__criatividade55:
	CP	W10, #3
	BRA NZ	L__criatividade56
	GOTO	L_criatividade12
L__criatividade56:
	CP	W10, #4
	BRA NZ	L__criatividade57
	GOTO	L_criatividade13
L__criatividade57:
	CP	W10, #5
	BRA NZ	L__criatividade58
	GOTO	L_criatividade14
L__criatividade58:
	CP	W10, #6
	BRA NZ	L__criatividade59
	GOTO	L_criatividade15
L__criatividade59:
	CP	W10, #7
	BRA NZ	L__criatividade60
	GOTO	L_criatividade16
L__criatividade60:
	CP	W10, #8
	BRA NZ	L__criatividade61
	GOTO	L_criatividade17
L__criatividade61:
	GOTO	L_criatividade18
L_criatividade8:
;q222.c,191 :: 		}
L_end_criatividade:
	RETURN
; end of _criatividade

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q222.c,195 :: 		void main() {
;q222.c,197 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q222.c,199 :: 		TRISB = 0;
	CLR	TRISB
;q222.c,200 :: 		TRISD = 0x0002;
	MOV	#2, W0
	MOV	WREG, TRISD
;q222.c,201 :: 		TRISE = 0x0000;
	CLR	TRISE
;q222.c,202 :: 		TRISEbits.TRISE8 = 1;
	BSET	TRISEbits, #8
;q222.c,203 :: 		IFS1bits.INT2IF = 0;
	BCLR.B	IFS1bits, #7
;q222.c,204 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;q222.c,205 :: 		IEC1bits.INT2IE = 1;
	BSET.B	IEC1bits, #7
;q222.c,206 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;q222.c,207 :: 		INTCON2bits.INT2EP = 0;
	BCLR.B	INTCON2bits, #2
;q222.c,208 :: 		INTCON2bits.INT0EP = 0;
	BCLR.B	INTCON2bits, #0
;q222.c,211 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;q222.c,212 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;q222.c,213 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q222.c,214 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;q222.c,215 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;q222.c,216 :: 		T2CON = 0x800A;
	MOV	#32778, W0
	MOV	WREG, T2CON
;q222.c,218 :: 		PR1 = 62500;
	MOV	#62500, W0
	MOV	WREG, PR1
;q222.c,219 :: 		PR2 = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, PR2
;q222.c,220 :: 		PR3 = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, PR3
;q222.c,224 :: 		Lcd_Init();
	CALL	_Lcd_Init
;q222.c,225 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;q222.c,226 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;q222.c,228 :: 		IPC0 = 0x7006;
	MOV	#28678, W0
	MOV	WREG, IPC0
;q222.c,229 :: 		IPC1 = 0x0500;
	MOV	#1280, W0
	MOV	WREG, IPC1
;q222.c,231 :: 		criat = 0;
	CLR	W0
	MOV	W0, _criat
;q222.c,233 :: 		while(1){
L_main19:
;q222.c,235 :: 		frequencia = frequencia1 + frequencia2*65536;
	MOV	#lo_addr(_frequencia2), W0
	MOV	[W0], W3
	CLR	W2
	MOV	#lo_addr(_frequencia1), W1
	MOV	#lo_addr(_frequencia), W0
	ADD	W2, [W1++], [W0++]
	ADDC	W3, [W1--], [W0--]
;q222.c,236 :: 		if (cont_int == 1){
	MOV	_cont_int, W0
	CP	W0, #1
	BRA Z	L__main63
	GOTO	L_main21
L__main63:
;q222.c,237 :: 		if ((frequencia >= 0)&&(frequencia < 1000)){
	MOV	_frequencia, W0
	MOV	_frequencia+2, W1
	CP	W0, #0
	CPB	W1, #0
	BRA GEU	L__main64
	GOTO	L__main42
L__main64:
	MOV	#1000, W1
	MOV	#0, W2
	MOV	#lo_addr(_frequencia), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA GTU	L__main65
	GOTO	L__main41
L__main65:
L__main40:
;q222.c,238 :: 		LongToStr((frequencia), txt);
	MOV	#lo_addr(_txt), W12
	MOV	_frequencia, W10
	MOV	_frequencia+2, W11
	CALL	_LongToStr
;q222.c,239 :: 		Lcd_Out(1, 1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,240 :: 		Lcd_Out(2, 11,"Hz  ");
	MOV	#lo_addr(?lstr1_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,241 :: 		}else{
	GOTO	L_main25
;q222.c,237 :: 		if ((frequencia >= 0)&&(frequencia < 1000)){
L__main42:
L__main41:
;q222.c,242 :: 		Lcd_Out(1, 1, "           ");
	MOV	#lo_addr(?lstr2_q222), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,243 :: 		Lcd_Out(2, 11,"erro");
	MOV	#lo_addr(?lstr3_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,244 :: 		if (flag_c == 1){
	MOV	_flag_c, W0
	CP	W0, #1
	BRA Z	L__main66
	GOTO	L_main26
L__main66:
;q222.c,245 :: 		criat = floor((frequencia / 1000));
	MOV	#1000, W2
	MOV	#0, W3
	MOV	_frequencia, W0
	MOV	_frequencia+2, W1
	CLR	W4
	CALL	__Divide_32x32
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _criat
;q222.c,246 :: 		criatividade(criat);
	MOV	W0, W10
	CALL	_criatividade
;q222.c,247 :: 		}
L_main26:
;q222.c,248 :: 		}
L_main25:
;q222.c,249 :: 		}
L_main21:
;q222.c,251 :: 		if (cont_int == 2){
	MOV	_cont_int, W0
	CP	W0, #2
	BRA Z	L__main67
	GOTO	L_main27
L__main67:
;q222.c,252 :: 		frequencia_aux = floor(frequencia/1000);
	MOV	#1000, W2
	MOV	#0, W3
	MOV	_frequencia, W0
	MOV	_frequencia+2, W1
	CLR	W4
	CALL	__Divide_32x32
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longword
	MOV	W0, _frequencia_aux
	MOV	W1, _frequencia_aux+2
;q222.c,253 :: 		if ((frequencia_aux > 0)&&(frequencia_aux < 1000)){
	CP	W0, #0
	CPB	W1, #0
	BRA GTU	L__main68
	GOTO	L__main44
L__main68:
	MOV	#1000, W1
	MOV	#0, W2
	MOV	#lo_addr(_frequencia_aux), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA GTU	L__main69
	GOTO	L__main43
L__main69:
L__main39:
;q222.c,254 :: 		LongToStr((frequencia_aux), txt);
	MOV	#lo_addr(_txt), W12
	MOV	_frequencia_aux, W10
	MOV	_frequencia_aux+2, W11
	CALL	_LongToStr
;q222.c,255 :: 		Lcd_Out(1, 1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,256 :: 		Lcd_Out(2, 11, "kHz ");
	MOV	#lo_addr(?lstr4_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,257 :: 		}else{
	GOTO	L_main31
;q222.c,253 :: 		if ((frequencia_aux > 0)&&(frequencia_aux < 1000)){
L__main44:
L__main43:
;q222.c,258 :: 		Lcd_Out(1, 1, "          ");
	MOV	#lo_addr(?lstr5_q222), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,259 :: 		Lcd_Out(2, 11, "erro");
	MOV	#lo_addr(?lstr6_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,260 :: 		if (flag_c == 1){
	MOV	_flag_c, W0
	CP	W0, #1
	BRA Z	L__main70
	GOTO	L_main32
L__main70:
;q222.c,261 :: 		criat = floor(frequencia/1000000);
	MOV	#16960, W2
	MOV	#15, W3
	MOV	_frequencia, W0
	MOV	_frequencia+2, W1
	CLR	W4
	CALL	__Divide_32x32
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	W0, _criat
;q222.c,262 :: 		criatividade(criat);
	MOV	W0, W10
	CALL	_criatividade
;q222.c,263 :: 		}
L_main32:
;q222.c,264 :: 		}
L_main31:
;q222.c,265 :: 		}
L_main27:
;q222.c,267 :: 		if (cont_int == 3){
	MOV	_cont_int, W0
	CP	W0, #3
	BRA Z	L__main71
	GOTO	L_main33
L__main71:
;q222.c,268 :: 		frequencia_aux = floor(frequencia/1000000);
	MOV	#16960, W2
	MOV	#15, W3
	MOV	_frequencia, W0
	MOV	_frequencia+2, W1
	CLR	W4
	CALL	__Divide_32x32
	CALL	__Long2Float
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longword
	MOV	W0, _frequencia_aux
	MOV	W1, _frequencia_aux+2
;q222.c,269 :: 		if ((frequencia_aux >= 0)&&(frequencia_aux < 10)){
	CP	W0, #0
	CPB	W1, #0
	BRA GEU	L__main72
	GOTO	L__main46
L__main72:
	MOV	_frequencia_aux, W0
	MOV	_frequencia_aux+2, W1
	CP	W0, #10
	CPB	W1, #0
	BRA LTU	L__main73
	GOTO	L__main45
L__main73:
L__main38:
;q222.c,270 :: 		LongToStr((frequencia_aux), txt);
	MOV	#lo_addr(_txt), W12
	MOV	_frequencia_aux, W10
	MOV	_frequencia_aux+2, W11
	CALL	_LongToStr
;q222.c,271 :: 		Lcd_Out(1,1,txt);
	MOV	#lo_addr(_txt), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,272 :: 		Lcd_Out(2,11,"MHz ");
	MOV	#lo_addr(?lstr7_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,273 :: 		}else{
	GOTO	L_main37
;q222.c,269 :: 		if ((frequencia_aux >= 0)&&(frequencia_aux < 10)){
L__main46:
L__main45:
;q222.c,274 :: 		Lcd_Out(1,1,"          ");
	MOV	#lo_addr(?lstr8_q222), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;q222.c,275 :: 		Lcd_Out(2,11,"erro");
	MOV	#lo_addr(?lstr9_q222), W12
	MOV	#11, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;q222.c,276 :: 		}
L_main37:
;q222.c,277 :: 		}
L_main33:
;q222.c,278 :: 		}
	GOTO	L_main19
;q222.c,279 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
