
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex2.c,1 :: 		void main() {
;ex2.c,2 :: 		ADPCFG=0xFFFF; //digital
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex2.c,3 :: 		TRISB=0;//saida
	CLR	TRISB
;ex2.c,4 :: 		LATB=0;
	CLR	LATB
;ex2.c,5 :: 		while(1){
L_main0:
;ex2.c,6 :: 		LATB= 0x81;
	MOV	#129, W0
	MOV	WREG, LATB
;ex2.c,7 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
;ex2.c,8 :: 		LATB=0;
	CLR	LATB
;ex2.c,9 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	DEC	W8
	BRA NZ	L_main4
;ex2.c,10 :: 		LATB= 0x42;
	MOV	#66, W0
	MOV	WREG, LATB
;ex2.c,11 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	DEC	W8
	BRA NZ	L_main6
;ex2.c,12 :: 		LATB=0;
	CLR	LATB
;ex2.c,13 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
;ex2.c,14 :: 		LATB= 0x24;
	MOV	#36, W0
	MOV	WREG, LATB
;ex2.c,15 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main10:
	DEC	W7
	BRA NZ	L_main10
	DEC	W8
	BRA NZ	L_main10
;ex2.c,16 :: 		LATB=0;
	CLR	LATB
;ex2.c,17 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	DEC	W8
	BRA NZ	L_main12
;ex2.c,18 :: 		LATB= 0x18;
	MOV	#24, W0
	MOV	WREG, LATB
;ex2.c,19 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;ex2.c,20 :: 		LATB=0;
	CLR	LATB
;ex2.c,21 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main16:
	DEC	W7
	BRA NZ	L_main16
	DEC	W8
	BRA NZ	L_main16
;ex2.c,22 :: 		}
	GOTO	L_main0
;ex2.c,23 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
