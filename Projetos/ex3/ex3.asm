
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex3.c,7 :: 		void main() {
;ex3.c,8 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex3.c,9 :: 		TRISB = 0;//PORTB how saida
	CLR	TRISB
;ex3.c,10 :: 		while(1){
L_main0:
;ex3.c,11 :: 		for (j = 0; j < 8 ; j ++)
	MOV	#lo_addr(_j), W1
	CLR	W0
	MOV.B	W0, [W1]
L_main2:
	MOV	#lo_addr(_j), W0
	MOV.B	[W0], W0
	CP.B	W0, #8
	BRA LTU	L__main8
	GOTO	L_main3
L__main8:
;ex3.c,13 :: 		LATB = num[j];  //Porta B saida Leds
	MOV	#lo_addr(_j), W0
	ZE	[W0], W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;ex3.c,14 :: 		Delay_ms(1000); //Frequencia de clock é de XTAL = 8MHz. No edit Project
	MOV	#82, W8
	MOV	#24943, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
	NOP
;ex3.c,11 :: 		for (j = 0; j < 8 ; j ++)
	MOV.B	#1, W1
	MOV	#lo_addr(_j), W0
	ADD.B	W1, [W0], [W0]
;ex3.c,17 :: 		}
	GOTO	L_main2
L_main3:
;ex3.c,18 :: 		}
	GOTO	L_main0
;ex3.c,19 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
