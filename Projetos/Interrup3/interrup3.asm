
_INT0Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;interrup3.c,9 :: 		void INT0Int() iv IVT_ADDR_INT0INTERRUPT { // declaração da interrupção
;interrup3.c,10 :: 		Delay_ms(100); // delay anti-bouncing
	MOV	#9, W8
	MOV	#9047, W7
L_INT0Int0:
	DEC	W7
	BRA NZ	L_INT0Int0
	DEC	W8
	BRA NZ	L_INT0Int0
;interrup3.c,12 :: 		flag++;
	MOV	#1, W1
	MOV	#lo_addr(_flag), W0
	ADD	W1, [W0], [W0]
;interrup3.c,14 :: 		IFS0bits.INT0IF = 0; // "zeramento" da interrupção após ser executada --> desabilitação de flag
	BCLR.B	IFS0bits, #0
;interrup3.c,15 :: 		}
L_end_INT0Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _INT0Int

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;interrup3.c,25 :: 		void main () {
;interrup3.c,27 :: 		ADPCFG = 0xFFFF; // porta B digital
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;interrup3.c,28 :: 		TRISD = 0; // inicialização
	CLR	TRISD
;interrup3.c,29 :: 		TRISB = 0; // porta B de saída
	CLR	TRISB
;interrup3.c,30 :: 		LATB = 0; // inicialização
	CLR	LATB
;interrup3.c,32 :: 		TRISE = 0x0100; // porta A com pino 8 de entrada (INT0 = RE4)
	MOV	#256, W0
	MOV	WREG, TRISE
;interrup3.c,36 :: 		IFS0 = 0; // inicialização do registrador de interrupção IFS0 --> desabilitação de flag
	CLR	IFS0
;interrup3.c,38 :: 		IEC0bits.INT0IE = 1; // habilitação de INT0
	BSET.B	IEC0bits, #0
;interrup3.c,40 :: 		INTCON2.INT0EP = 0; // configuração de borda de subida;
	BCLR.B	INTCON2, #0
;interrup3.c,44 :: 		while(1){
L_main2:
;interrup3.c,45 :: 		if (flag == 1){ // se não estiver no estado 0
	MOV	_flag, W0
	CP	W0, #1
	BRA Z	L__main43
	GOTO	L_main4
L__main43:
;interrup3.c,46 :: 		for(k = 0; k<250 ; k++){
	CLR	W0
	MOV	W0, _k
L_main5:
	MOV	#250, W1
	MOV	#lo_addr(_k), W0
	CP	W1, [W0]
	BRA GT	L__main44
	GOTO	L_main6
L__main44:
;interrup3.c,47 :: 		for (i = 0; i <= 3; i++){
	CLR	W0
	MOV	W0, _i
L_main8:
	MOV	_i, W0
	CP	W0, #3
	BRA LE	L__main45
	GOTO	L_main9
L__main45:
;interrup3.c,48 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main11:
	DEC	W7
	BRA NZ	L_main11
	NOP
;interrup3.c,49 :: 		LATD = mux[i];
	MOV	#lo_addr(_mux), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATD
;interrup3.c,50 :: 		LATB = HOLA[i];
	MOV	#lo_addr(_HOLA), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;interrup3.c,47 :: 		for (i = 0; i <= 3; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;interrup3.c,51 :: 		}
	GOTO	L_main8
L_main9:
;interrup3.c,46 :: 		for(k = 0; k<250 ; k++){
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;interrup3.c,52 :: 		}
	GOTO	L_main5
L_main6:
;interrup3.c,53 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;interrup3.c,54 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main13:
	DEC	W7
	BRA NZ	L_main13
	DEC	W8
	BRA NZ	L_main13
;interrup3.c,56 :: 		}else if(flag == 2){
	GOTO	L_main15
L_main4:
	MOV	_flag, W0
	CP	W0, #2
	BRA Z	L__main46
	GOTO	L_main16
L__main46:
;interrup3.c,57 :: 		for(k = 0; k <= 9 ; k++){
	CLR	W0
	MOV	W0, _k
L_main17:
	MOV	_k, W0
	CP	W0, #9
	BRA LE	L__main47
	GOTO	L_main18
L__main47:
;interrup3.c,58 :: 		for (i = 0; i <= 550; i++){
	CLR	W0
	MOV	W0, _i
L_main20:
	MOV	_i, W1
	MOV	#550, W0
	CP	W1, W0
	BRA LE	L__main48
	GOTO	L_main21
L__main48:
;interrup3.c,59 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main23:
	DEC	W7
	BRA NZ	L_main23
	NOP
;interrup3.c,60 :: 		LATD = mux[0];
	MOV	#lo_addr(_mux), W0
	ZE	[W0], W0
	MOV	WREG, LATD
;interrup3.c,61 :: 		LATB = zer_nove[k];
	MOV	#lo_addr(_zer_nove), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;interrup3.c,58 :: 		for (i = 0; i <= 550; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;interrup3.c,62 :: 		}
	GOTO	L_main20
L_main21:
;interrup3.c,57 :: 		for(k = 0; k <= 9 ; k++){
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;interrup3.c,63 :: 		}
	GOTO	L_main17
L_main18:
;interrup3.c,64 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;interrup3.c,65 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main25:
	DEC	W7
	BRA NZ	L_main25
	DEC	W8
	BRA NZ	L_main25
;interrup3.c,67 :: 		}else if(flag ==3){
	GOTO	L_main27
L_main16:
	MOV	_flag, W0
	CP	W0, #3
	BRA Z	L__main49
	GOTO	L_main28
L__main49:
;interrup3.c,68 :: 		for(k = 0; k <= 9 ; k++){
	CLR	W0
	MOV	W0, _k
L_main29:
	MOV	_k, W0
	CP	W0, #9
	BRA LE	L__main50
	GOTO	L_main30
L__main50:
;interrup3.c,69 :: 		for (i = 0; i <= 550; i++){
	CLR	W0
	MOV	W0, _i
L_main32:
	MOV	_i, W1
	MOV	#550, W0
	CP	W1, W0
	BRA LE	L__main51
	GOTO	L_main33
L__main51:
;interrup3.c,70 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main35:
	DEC	W7
	BRA NZ	L_main35
	NOP
;interrup3.c,71 :: 		LATD = mux[0];
	MOV	#lo_addr(_mux), W0
	ZE	[W0], W0
	MOV	WREG, LATD
;interrup3.c,72 :: 		LATB = zer_nove[9-k];
	MOV	_k, W0
	SUBR	W0, #9, W1
	MOV	#lo_addr(_zer_nove), W0
	ADD	W0, W1, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;interrup3.c,69 :: 		for (i = 0; i <= 550; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;interrup3.c,73 :: 		}
	GOTO	L_main32
L_main33:
;interrup3.c,68 :: 		for(k = 0; k <= 9 ; k++){
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;interrup3.c,74 :: 		}
	GOTO	L_main29
L_main30:
;interrup3.c,75 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;interrup3.c,76 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main37:
	DEC	W7
	BRA NZ	L_main37
	DEC	W8
	BRA NZ	L_main37
;interrup3.c,78 :: 		}else if(flag >=4){
	GOTO	L_main39
L_main28:
	MOV	_flag, W0
	CP	W0, #4
	BRA GE	L__main52
	GOTO	L_main40
L__main52:
;interrup3.c,79 :: 		flag=0;
	CLR	W0
	MOV	W0, _flag
;interrup3.c,80 :: 		}
L_main40:
L_main39:
L_main27:
L_main15:
;interrup3.c,81 :: 		}
	GOTO	L_main2
;interrup3.c,82 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
