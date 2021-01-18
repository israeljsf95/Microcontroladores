
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex1.c,3 :: 		void main() {
;ex1.c,4 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex1.c,5 :: 		TRISB  = 0; // Configurando como saida
	CLR	TRISB
;ex1.c,6 :: 		LATB = 0;
	CLR	LATB
;ex1.c,7 :: 		while(1){
L_main0:
;ex1.c,8 :: 		LATB = 0x0F;
	MOV	#15, W0
	MOV	WREG, LATB
;ex1.c,9 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
;ex1.c,10 :: 		LATB = 0xF;
	MOV	#15, W0
	MOV	WREG, LATB
;ex1.c,11 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	DEC	W8
	BRA NZ	L_main4
;ex1.c,12 :: 		LATB = 0;
	CLR	LATB
;ex1.c,13 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	DEC	W8
	BRA NZ	L_main6
;ex1.c,14 :: 		}
	GOTO	L_main0
;ex1.c,16 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
