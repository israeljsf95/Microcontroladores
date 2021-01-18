
_INT0Int:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;interrup1.c,5 :: 		void INT0Int() iv IVT_ADDR_INT0INTERRUPT { // declaração da interrupção
;interrup1.c,6 :: 		Delay_ms(100); // delay anti-bouncing
	MOV	#9, W8
	MOV	#9047, W7
L_INT0Int0:
	DEC	W7
	BRA NZ	L_INT0Int0
	DEC	W8
	BRA NZ	L_INT0Int0
;interrup1.c,8 :: 		if (flag == 0){ //estado 0 troca pra estado 1 (vai piscar o LED)
	MOV	_flag, W0
	CP	W0, #0
	BRA Z	L__INT0Int12
	GOTO	L_INT0Int2
L__INT0Int12:
;interrup1.c,9 :: 		flag = 1;
	MOV	#1, W0
	MOV	W0, _flag
;interrup1.c,10 :: 		}
	GOTO	L_INT0Int3
L_INT0Int2:
;interrup1.c,13 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;interrup1.c,14 :: 		LATB = 0;
	CLR	LATB
;interrup1.c,15 :: 		}
L_INT0Int3:
;interrup1.c,17 :: 		IFS0bits.INT0IF = 0; // "zeramento" da interrupção após ser executada --> desabilitação de flag
	BCLR.B	IFS0bits, #0
;interrup1.c,18 :: 		}
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

;interrup1.c,22 :: 		void main () {
;interrup1.c,24 :: 		ADPCFG = 0xFFFF; // porta B digital
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;interrup1.c,26 :: 		TRISB = 0; // porta B de saída
	CLR	TRISB
;interrup1.c,27 :: 		LATB = 0; // inicialização
	CLR	LATB
;interrup1.c,29 :: 		TRISE = 0x0100; // porta A com pino 8 de entrada (INT0 = RE4)
	MOV	#256, W0
	MOV	WREG, TRISE
;interrup1.c,33 :: 		IFS0 = 0; // inicialização do registrador de interrupção IFS0 --> desabilitação de flag
	CLR	IFS0
;interrup1.c,35 :: 		IEC0bits.INT0IE = 1; // habilitação de INT0
	BSET.B	IEC0bits, #0
;interrup1.c,37 :: 		INTCON2.INT0EP = 0; // configuração de borda de subida;
	BCLR.B	INTCON2, #0
;interrup1.c,41 :: 		while(1){
L_main4:
;interrup1.c,42 :: 		if (flag != 0){ // se não estiver no estado 0
	MOV	_flag, W0
	CP	W0, #0
	BRA NZ	L__main14
	GOTO	L_main6
L__main14:
;interrup1.c,44 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;interrup1.c,45 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	DEC	W8
	BRA NZ	L_main7
	NOP
;interrup1.c,46 :: 		LATB = 0;
	CLR	LATB
;interrup1.c,47 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main9:
	DEC	W7
	BRA NZ	L_main9
	DEC	W8
	BRA NZ	L_main9
	NOP
;interrup1.c,48 :: 		}
L_main6:
;interrup1.c,49 :: 		}
	GOTO	L_main4
;interrup1.c,50 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
