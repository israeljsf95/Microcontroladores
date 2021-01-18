
_nFloatToStr:
	LNK	#10

;float_string_conv.c,16 :: 		void nFloatToStr(float f, short p, char *txt)
;float_string_conv.c,19 :: 		char sinal = ((char *)&f)[1].B5;
	MOV	#lo_addr(W10), W0
	INC	W0
	MOV.B	[W0], W1
	ADD	W14, #4, W0
	CLR.B	[W0]
	BTSC.B	W1, #5
	INC.B	[W0], [W0]
;float_string_conv.c,20 :: 		unsigned long fator = 10;
; fator start address is: 8 (W4)
	MOV	#10, W4
	MOV	#0, W5
;float_string_conv.c,21 :: 		short i = p, j = 0;
; i start address is: 2 (W1)
	MOV.B	W12, W1
	MOV	#0, W0
	MOV.B	W0, [W14+5]
; i end address is: 2 (W1)
; fator end address is: 8 (W4)
	MOV.D	W4, W2
;float_string_conv.c,23 :: 		while (i--)
L_nFloatToStr0:
; i start address is: 12 (W6)
; i start address is: 2 (W1)
; fator start address is: 4 (W2)
	MOV.B	W1, W0
; i start address is: 12 (W6)
	SUB.B	W1, #1, W6
; i end address is: 2 (W1)
; i end address is: 12 (W6)
	CP0.B	W0
	BRA NZ	L__nFloatToStr19
	GOTO	L_nFloatToStr1
L__nFloatToStr19:
; i end address is: 12 (W6)
;float_string_conv.c,24 :: 		fator *= 10;
; i start address is: 12 (W6)
	MOV	#10, W0
	MOV	#0, W1
	CALL	__Multiply_32x32
; fator end address is: 4 (W2)
; fator start address is: 8 (W4)
	MOV.D	W0, W4
	MOV.D	W4, W2
; i end address is: 12 (W6)
; fator end address is: 8 (W4)
	MOV.B	W6, W1
	GOTO	L_nFloatToStr0
L_nFloatToStr1:
;float_string_conv.c,26 :: 		((char *)&f)[1].B5 = 0;
; fator start address is: 4 (W2)
	MOV	#lo_addr(W10), W0
	INC	W0
	BCLR.B	[W0], #5
;float_string_conv.c,28 :: 		resultado = ((unsigned long)(f * fator) + 5) / 10;
	PUSH.D	W12
; fator end address is: 4 (W2)
	PUSH.D	W10
	MOV.D	W2, W0
	CALL	__Long2Float
	POP.D	W10
	PUSH.D	W10
	MOV.D	W10, W2
	CALL	__Mul_FP
	CALL	__Float2Longword
	ADD	W0, #5, W0
	ADDC	W1, #0, W1
	MOV	#10, W2
	MOV	#0, W3
	CLR	W4
	CALL	__Divide_32x32
	POP.D	W10
	POP.D	W12
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
;float_string_conv.c,35 :: 		} while (((resultado /= 10) > 0) || (p > 0));
L__nFloatToStr17:
L__nFloatToStr16:
;float_string_conv.c,32 :: 		txt[j++] = resultado % 10 + '0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV	W0, [W14+8]
	PUSH.D	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	CLR	W4
	CALL	__Modulus_32x32
	POP.D	W10
	POP.D	W12
	MOV	#48, W2
	MOV	#0, W3
	ADD	W0, W2, W2
	MOV	[W14+8], W0
	MOV.B	W2, [W0]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
;float_string_conv.c,33 :: 		if (--p == 0)
	SUB.B	W12, #1, W0
	MOV.B	W0, W12
	CP.B	W12, #0
	BRA Z	L__nFloatToStr20
	GOTO	L_nFloatToStr5
L__nFloatToStr20:
;float_string_conv.c,34 :: 		txt[j++] = '.';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#46, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr5:
;float_string_conv.c,35 :: 		} while (((resultado /= 10) > 0) || (p > 0));
	PUSH.D	W12
	PUSH.D	W10
	MOV	#10, W2
	MOV	#0, W3
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	CLR	W4
	CALL	__Divide_32x32
	POP.D	W10
	POP.D	W12
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	CP	W0, #0
	CPB	W1, #0
	BRA LEU	L__nFloatToStr21
	GOTO	L__nFloatToStr17
L__nFloatToStr21:
	CP.B	W12, #0
	BRA LE	L__nFloatToStr22
	GOTO	L__nFloatToStr16
L__nFloatToStr22:
L__nFloatToStr15:
;float_string_conv.c,37 :: 		if (txt[j - 1] == '.')
	ADD	W14, #5, W0
	SE	[W0], W0
	DEC	W0
	ADD	W13, W0, W0
	MOV.B	[W0], W1
	MOV.B	#46, W0
	CP.B	W1, W0
	BRA Z	L__nFloatToStr23
	GOTO	L_nFloatToStr8
L__nFloatToStr23:
;float_string_conv.c,38 :: 		txt[j++] = '0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr8:
;float_string_conv.c,40 :: 		if (sinal)
	ADD	W14, #4, W0
	CP0.B	[W0]
	BRA NZ	L__nFloatToStr24
	GOTO	L_nFloatToStr9
L__nFloatToStr24:
;float_string_conv.c,41 :: 		txt[j++] = '-';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	MOV.B	#45, W0
	MOV.B	W0, [W1]
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	ADD.B	W1, #1, [W0]
L_nFloatToStr9:
;float_string_conv.c,43 :: 		txt[j] = '\0';
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W1
	CLR	W0
	MOV.B	W0, [W1]
;float_string_conv.c,45 :: 		for (i = 0, j--; i < j; i++, j--)
; i start address is: 6 (W3)
	CLR	W3
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	SUB.B	W1, #1, [W0]
	MOV.B	W3, W2
; i end address is: 6 (W3)
L_nFloatToStr10:
; i start address is: 4 (W2)
	ADD	W14, #5, W0
	CP.B	W2, [W0]
	BRA LT	L__nFloatToStr25
	GOTO	L_nFloatToStr11
L__nFloatToStr25:
;float_string_conv.c,47 :: 		p = txt[i];
	SE	W2, W0
	ADD	W13, W0, W1
	MOV.B	[W1], W12
;float_string_conv.c,48 :: 		txt[i] = txt[j];
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV.B	[W0], [W1]
;float_string_conv.c,49 :: 		txt[j] = p;
	ADD	W14, #5, W0
	SE	[W0], W0
	ADD	W13, W0, W0
	MOV.B	W12, [W0]
;float_string_conv.c,45 :: 		for (i = 0, j--; i < j; i++, j--)
; i start address is: 6 (W3)
	ADD.B	W2, #1, W3
; i end address is: 4 (W2)
	MOV.B	[W14+5], W1
	ADD	W14, #5, W0
	SUB.B	W1, #1, [W0]
;float_string_conv.c,50 :: 		}
	MOV.B	W3, W2
; i end address is: 6 (W3)
	GOTO	L_nFloatToStr10
L_nFloatToStr11:
;float_string_conv.c,51 :: 		}
L_end_nFloatToStr:
	ULNK
	RETURN
; end of _nFloatToStr

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;float_string_conv.c,59 :: 		void main()
;float_string_conv.c,61 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;float_string_conv.c,65 :: 		Lcd_Init();               // Initializa o LCD
	CALL	_Lcd_Init
;float_string_conv.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;float_string_conv.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;float_string_conv.c,70 :: 		sprintf(txt_teste1, "%.2f", mostrar);
	PUSH	_mostrar
	PUSH	_mostrar+2
	MOV	#lo_addr(?lstr_1_float_string_conv), W0
	PUSH	W0
	MOV	#lo_addr(_txt_teste1), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#8, W15
;float_string_conv.c,71 :: 		Lcd_Out(1, 1, txt_teste1);
	MOV	#lo_addr(_txt_teste1), W12
	MOV	#1, W11
	MOV	#1, W10
	CALL	_Lcd_Out
;float_string_conv.c,73 :: 		while (1)
L_main13:
;float_string_conv.c,75 :: 		}
	GOTO	L_main13
;float_string_conv.c,76 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
