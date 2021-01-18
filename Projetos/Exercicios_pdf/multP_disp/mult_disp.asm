
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;mult_disp.c,9 :: 		void main() {
;mult_disp.c,12 :: 		TRISD = 0;
	CLR	TRISD
;mult_disp.c,13 :: 		LATD = 0;
	CLR	LATD
;mult_disp.c,14 :: 		TRISB = 0;
	CLR	TRISB
;mult_disp.c,15 :: 		LATB = 0;
	CLR	LATB
;mult_disp.c,18 :: 		do{
L_main0:
;mult_disp.c,20 :: 		for(i=0; i <= 35; i++){
	CLR	W0
	MOV	W0, _i
L_main3:
	MOV	#35, W1
	MOV	#lo_addr(_i), W0
	CP	W1, [W0]
	BRA GEU	L__main15
	GOTO	L_main4
L__main15:
;mult_disp.c,21 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;mult_disp.c,22 :: 		LATB = a1[0];
	MOV	_a1, W0
	MOV	WREG, LATB
;mult_disp.c,23 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	NOP
	NOP
;mult_disp.c,24 :: 		LATDbits.LATD0 = 1;
	BSET.B	LATDbits, #0
;mult_disp.c,26 :: 		LATDbits.LATD1 = 0;
	BCLR.B	LATDbits, #1
;mult_disp.c,27 :: 		LATB = a1[1];
	MOV	_a1+2, W0
	MOV	WREG, LATB
;mult_disp.c,28 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	NOP
	NOP
;mult_disp.c,29 :: 		LATDbits.LATD1 = 1;
	BSET.B	LATDbits, #1
;mult_disp.c,31 :: 		LATDbits.LATD2 = 0;
	BCLR.B	LATDbits, #2
;mult_disp.c,32 :: 		LATB = a1[2];
	MOV	_a1+4, W0
	MOV	WREG, LATB
;mult_disp.c,33 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main10:
	DEC	W7
	BRA NZ	L_main10
	NOP
	NOP
;mult_disp.c,34 :: 		LATDbits.LATD2 = 1;   ;
	BSET.B	LATDbits, #2
;mult_disp.c,36 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;mult_disp.c,37 :: 		LATB = a1[3];
	MOV	_a1+6, W0
	MOV	WREG, LATB
;mult_disp.c,38 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	NOP
	NOP
;mult_disp.c,39 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;mult_disp.c,20 :: 		for(i=0; i <= 35; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;mult_disp.c,40 :: 		}
	GOTO	L_main3
L_main4:
;mult_disp.c,41 :: 		aux   = a1[0];
	MOV	_a1, W0
	MOV	W0, _aux
;mult_disp.c,42 :: 		a1[0] = a1[1];
	MOV	_a1+2, W0
	MOV	W0, _a1
;mult_disp.c,43 :: 		a1[1] = a1[2];
	MOV	_a1+4, W0
	MOV	W0, _a1+2
;mult_disp.c,44 :: 		a1[2] = a1[3];
	MOV	_a1+6, W0
	MOV	W0, _a1+4
;mult_disp.c,45 :: 		a1[3] = aux;
	MOV	_aux, W0
	MOV	W0, _a1+6
;mult_disp.c,49 :: 		}while(1);
	GOTO	L_main0
;mult_disp.c,50 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
