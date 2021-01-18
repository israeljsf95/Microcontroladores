
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex5.c,7 :: 		void main() {
;ex5.c,8 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex5.c,9 :: 		TRISB = 0;//a PORTB como saida
	CLR	TRISB
;ex5.c,10 :: 		TRISD = 255; //pino 1(RD1) da porta D como entrada.
	MOV	#255, W0
	MOV	WREG, TRISD
;ex5.c,11 :: 		LATB = 0;
	CLR	LATB
;ex5.c,12 :: 		while(1)//loop infinito
L_main0:
;ex5.c,14 :: 		if(PORTDbits.RD1 == 1){
	BTSS.B	PORTDbits, #1
	GOTO	L_main2
;ex5.c,15 :: 		LATB = 255;
	MOV	#255, W0
	MOV	WREG, LATB
;ex5.c,17 :: 		}else {
	GOTO	L_main3
L_main2:
;ex5.c,18 :: 		LATB = 0;
	CLR	LATB
;ex5.c,19 :: 		}
L_main3:
;ex5.c,20 :: 		}
	GOTO	L_main0
;ex5.c,22 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
