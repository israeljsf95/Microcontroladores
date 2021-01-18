
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex6.c,6 :: 		void main() {
;ex6.c,7 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex6.c,8 :: 		TRISB = 0;
	CLR	TRISB
;ex6.c,9 :: 		TRISD = 0;
	CLR	TRISD
;ex6.c,11 :: 		LATD = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, LATD
;ex6.c,13 :: 		while(1){
L_main0:
;ex6.c,14 :: 		LATB = numeros[i];
	MOV	_i, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_numeros), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;ex6.c,15 :: 		Delay_ms(2000);
	MOV	#163, W8
	MOV	#49887, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
	NOP
;ex6.c,16 :: 		i = i+1;
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;ex6.c,17 :: 		if (i==10){
	MOV	_i, W0
	CP	W0, #10
	BRA Z	L__main6
	GOTO	L_main4
L__main6:
;ex6.c,18 :: 		i = 0;
	CLR	W0
	MOV	W0, _i
;ex6.c,19 :: 		}
L_main4:
;ex6.c,20 :: 		}
	GOTO	L_main0
;ex6.c,21 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
