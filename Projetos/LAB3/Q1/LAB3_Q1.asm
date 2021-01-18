
_botao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB3_Q1.c,28 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT {//botao para selecao do menu
;LAB3_Q1.c,29 :: 		flag_botao++;
	MOV	#1, W1
	MOV	#lo_addr(_flag_botao), W0
	ADD	W1, [W0], [W0]
;LAB3_Q1.c,30 :: 		if (flag_botao > 4){
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA GT	L__botao14
	GOTO	L_botao0
L__botao14:
;LAB3_Q1.c,31 :: 		flag_botao = 0;
	CLR	W0
	MOV	W0, _flag_botao
;LAB3_Q1.c,32 :: 		}
L_botao0:
;LAB3_Q1.c,33 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao1:
	DEC	W7
	BRA NZ	L_botao1
	DEC	W8
	BRA NZ	L_botao1
;LAB3_Q1.c,34 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;LAB3_Q1.c,35 :: 		}
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

;LAB3_Q1.c,38 :: 		void main() {
;LAB3_Q1.c,39 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB3_Q1.c,41 :: 		IEC0bits.INT0IE = 1;//Ativando interrupçao do botao
	BSET.B	IEC0bits, #0
;LAB3_Q1.c,43 :: 		IFS0 = 0;
	CLR	IFS0
;LAB3_Q1.c,45 :: 		Lcd_Init();                        // Initialize LCD
	CALL	_Lcd_Init
;LAB3_Q1.c,46 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;LAB3_Q1.c,47 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;LAB3_Q1.c,49 :: 		while(1){
L_main3:
;LAB3_Q1.c,50 :: 		switch(flag_botao){
	GOTO	L_main5
;LAB3_Q1.c,51 :: 		case 0:
L_main7:
;LAB3_Q1.c,52 :: 		Lcd_Out(1,1,txtmeioseg);
	MOV	#lo_addr(_txtmeioseg), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,53 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,54 :: 		case 1:
L_main8:
;LAB3_Q1.c,55 :: 		Lcd_Out(1,1,txtumseg);
	MOV	#lo_addr(_txtumseg), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,56 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,57 :: 		case 2:
L_main9:
;LAB3_Q1.c,58 :: 		Lcd_Out(1,1,txtdezseg);
	MOV	#lo_addr(_txtdezseg), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,59 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,60 :: 		case 3:
L_main10:
;LAB3_Q1.c,61 :: 		Lcd_Out(1,1,txtummin);
	MOV	#lo_addr(_txtummin), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,62 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,63 :: 		case 4:
L_main11:
;LAB3_Q1.c,64 :: 		Lcd_Out(1,1,txtumahora);
	MOV	#lo_addr(_txtumahora), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;LAB3_Q1.c,65 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,66 :: 		default:
L_main12:
;LAB3_Q1.c,67 :: 		break;
	GOTO	L_main6
;LAB3_Q1.c,68 :: 		}
L_main5:
	MOV	_flag_botao, W0
	CP	W0, #0
	BRA NZ	L__main16
	GOTO	L_main7
L__main16:
	MOV	_flag_botao, W0
	CP	W0, #1
	BRA NZ	L__main17
	GOTO	L_main8
L__main17:
	MOV	_flag_botao, W0
	CP	W0, #2
	BRA NZ	L__main18
	GOTO	L_main9
L__main18:
	MOV	_flag_botao, W0
	CP	W0, #3
	BRA NZ	L__main19
	GOTO	L_main10
L__main19:
	MOV	_flag_botao, W0
	CP	W0, #4
	BRA NZ	L__main20
	GOTO	L_main11
L__main20:
	GOTO	L_main12
L_main6:
;LAB3_Q1.c,70 :: 		}
	GOTO	L_main3
;LAB3_Q1.c,71 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
