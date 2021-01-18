
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex2.c,4 :: 		void main() {
;ex2.c,5 :: 		ADPCFG = 0xFFFF; //porta B como digital
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex2.c,6 :: 		TRISB = 0;//porta B como saida
	CLR	TRISB
;ex2.c,7 :: 		while(1){
L_main0:
;ex2.c,8 :: 		LATB = 255;
	MOV	#255, W0
	MOV	WREG, LATB
;ex2.c,9 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
;ex2.c,10 :: 		LATB = 0;
	CLR	LATB
;ex2.c,11 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	DEC	W8
	BRA NZ	L_main4
	NOP
;ex2.c,12 :: 		}
	GOTO	L_main0
;ex2.c,13 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
