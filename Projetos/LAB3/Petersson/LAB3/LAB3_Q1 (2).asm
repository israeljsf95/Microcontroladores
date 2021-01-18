
_temporizador:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1.c,29 :: 		void temporizador() iv IVT_ADDR_T1INTERRUPT {
;LAB3_Q1.c,30 :: 		contador_tempo++;
	MOV	#1, W1
	MOV	#lo_addr(_contador_tempo), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1.c,31 :: 		IFS0bits.INT0IF = 0;
	BCLR	IFS0bits, #0
;LAB3_Q1.c,32 :: 		}
L_end_temporizador:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _temporizador

_botao:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1.c,35 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT {//botao para selecao do menu
;LAB3_Q1.c,36 :: 		flag_botao++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_botao), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1.c,37 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,38 :: 		flag_seleciona = 0;
	CLR	W0
	MOV	W0, _flag_seleciona
;LAB3_Q1.c,39 :: 		if (flag_botao > 4){
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA GT	L__botao32
	GOTO	L_botao0
L__botao32:
;LAB3_Q1.c,40 :: 		flag_botao = 0;
	CLR	W0
	MOV	W0, _flag_botao
;LAB3_Q1.c,41 :: 		}
L_botao0:
;LAB3_Q1.c,42 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao1:
	DEC	W7
	BRA NZ	L_botao1
	DEC	W8
	BRA NZ	L_botao1
;LAB3_Q1.c,43 :: 		IFS0bits.INT0IF = 0;
	BCLR	IFS0bits, #0
;LAB3_Q1.c,44 :: 		}
L_end_botao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _botao

_seleciona:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1.c,46 :: 		void seleciona() iv IVT_ADDR_INT2INTERRUPT {
;LAB3_Q1.c,47 :: 		flag_seleciona = 1;
	MOV	#1, W0
	MOV	W0, _flag_seleciona
;LAB3_Q1.c,48 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,49 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_seleciona3:
	DEC	W7
	BRA NZ	L_seleciona3
	DEC	W8
	BRA NZ	L_seleciona3
;LAB3_Q1.c,50 :: 		IFS1bits.INT1IF = 0;
	BCLR	IFS1bits, #0
;LAB3_Q1.c,51 :: 		}
L_end_seleciona:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _seleciona

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB3_Q1.c,53 :: 		void main() {
;LAB3_Q1.c,54 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB3_Q1.c,56 :: 		IEC0bits.INT0IE = 1;//Ativando interrupçao do botao
	BSET	IEC0bits, #0
;LAB3_Q1.c,57 :: 		IEC1bits.INT2IE = 1;
	BSET	IEC1bits, #7
;LAB3_Q1.c,58 :: 		IEC0bits.T1IE = 1;
	BSET	IEC0bits, #3
;LAB3_Q1.c,59 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;LAB3_Q1.c,60 :: 		PR1 = 31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;LAB3_Q1.c,61 :: 		IFS0 = 0;
	CLR	IFS0
;LAB3_Q1.c,63 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;LAB3_Q1.c,64 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB3_Q1.c,65 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;LAB3_Q1.c,67 :: 		while(1){
L_main5:
;LAB3_Q1.c,68 :: 		if (flag_seleciona == 0){
	MOV	_flag_seleciona, W0
	CP	W0, #0
	BRA Z	L__main35
	GOTO	L_main7
L__main35:
;LAB3_Q1.c,69 :: 		switch(flag_botao){
	GOTO	L_main8
;LAB3_Q1.c,70 :: 		case 0:
L_main10:
;LAB3_Q1.c,71 :: 		Lcd_Out(2,1,txtmeioseg);
	MOV	#lo_addr(_txtmeioseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,72 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,73 :: 		case 1:
L_main11:
;LAB3_Q1.c,74 :: 		Lcd_Out(2,1,txtumseg);
	MOV	#lo_addr(_txtumseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,75 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,76 :: 		case 2:
L_main12:
;LAB3_Q1.c,77 :: 		Lcd_Out(2,1,txtdezseg);
	MOV	#lo_addr(_txtdezseg), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,78 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,79 :: 		case 3:
L_main13:
;LAB3_Q1.c,80 :: 		Lcd_Out(2,1,txtummin);
	MOV	#lo_addr(_txtummin), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,81 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,82 :: 		case 4:
L_main14:
;LAB3_Q1.c,83 :: 		Lcd_Out(2,1,txtumahora);
	MOV	#lo_addr(_txtumahora), W12
	MOV	#1, W11
	MOV	#2, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,84 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,85 :: 		default:
L_main15:
;LAB3_Q1.c,86 :: 		break;
	GOTO	L_main9
;LAB3_Q1.c,87 :: 		}
L_main8:
	MOV	_flag_botao, W0
	CP	W0, #0
	BRA NZ	L__main36
	GOTO	L_main10
L__main36:
	MOV	_flag_botao, W0
	CP	W0, #1
	BRA NZ	L__main37
	GOTO	L_main11
L__main37:
	MOV	_flag_botao, W0
	CP	W0, #2
	BRA NZ	L__main38
	GOTO	L_main12
L__main38:
	MOV	_flag_botao, W0
	CP	W0, #3
	BRA NZ	L__main39
	GOTO	L_main13
L__main39:
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA NZ	L__main40
	GOTO	L_main14
L__main40:
	GOTO	L_main15
L_main9:
;LAB3_Q1.c,88 :: 		Lcd_Out(1,1,txt1);
	MOV	#lo_addr(_txt1), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,89 :: 		}else{
	GOTO	L_main16
L_main7:
;LAB3_Q1.c,90 :: 		switch(flag_botao){
	GOTO	L_main17
;LAB3_Q1.c,91 :: 		case 0:
L_main19:
;LAB3_Q1.c,92 :: 		if (contador_tempo == PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__main41
	GOTO	L_main20
L__main41:
;LAB3_Q1.c,93 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,94 :: 		}
L_main20:
;LAB3_Q1.c,95 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,96 :: 		case 1:
L_main21:
;LAB3_Q1.c,97 :: 		if (contador_tempo == PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__main42
	GOTO	L_main22
L__main42:
;LAB3_Q1.c,98 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,99 :: 		}
L_main22:
;LAB3_Q1.c,100 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,101 :: 		case 2:
L_main23:
;LAB3_Q1.c,102 :: 		if (contador_tempo == PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__main43
	GOTO	L_main24
L__main43:
;LAB3_Q1.c,103 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,104 :: 		}
L_main24:
;LAB3_Q1.c,105 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,106 :: 		case 3:
L_main25:
;LAB3_Q1.c,107 :: 		if (contador_tempo == PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__main44
	GOTO	L_main26
L__main44:
;LAB3_Q1.c,108 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,109 :: 		}
L_main26:
;LAB3_Q1.c,110 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,111 :: 		case 4:
L_main27:
;LAB3_Q1.c,112 :: 		if (contador_tempo == PRs[flag_botao]){
	MOV	_flag_botao, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_PRs), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_contador_tempo), W0
	CP	W1, [W0]
	BRA Z	L__main45
	GOTO	L_main28
L__main45:
;LAB3_Q1.c,113 :: 		contador_tempo = 0;
	CLR	W0
	MOV	W0, _contador_tempo
;LAB3_Q1.c,114 :: 		}
L_main28:
;LAB3_Q1.c,115 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,116 :: 		default:
L_main29:
;LAB3_Q1.c,117 :: 		break;
	GOTO	L_main18
;LAB3_Q1.c,118 :: 		}
L_main17:
	MOV	_flag_botao, W0
	CP	W0, #0
	BRA NZ	L__main46
	GOTO	L_main19
L__main46:
	MOV	_flag_botao, W0
	CP	W0, #1
	BRA NZ	L__main47
	GOTO	L_main21
L__main47:
	MOV	_flag_botao, W0
	CP	W0, #2
	BRA NZ	L__main48
	GOTO	L_main23
L__main48:
	MOV	_flag_botao, W0
	CP	W0, #3
	BRA NZ	L__main49
	GOTO	L_main25
L__main49:
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA NZ	L__main50
	GOTO	L_main27
L__main50:
	GOTO	L_main29
L_main18:
;LAB3_Q1.c,119 :: 		}
L_main16:
;LAB3_Q1.c,120 :: 		}
	GOTO	L_main5
;LAB3_Q1.c,121 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
