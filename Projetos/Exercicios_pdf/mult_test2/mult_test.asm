
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;mult_test.c,9 :: 		void main() {
;mult_test.c,12 :: 		TRISD = 0;
	CLR	TRISD
;mult_test.c,13 :: 		LATD = 0;
	CLR	LATD
;mult_test.c,14 :: 		TRISB = 0;
	CLR	TRISB
;mult_test.c,15 :: 		LATB = 0;
	CLR	LATB
;mult_test.c,18 :: 		do{
L_main0:
;mult_test.c,20 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;mult_test.c,21 :: 		LATB = a1[0];
	MOV	_a1, W0
	MOV	WREG, LATB
;mult_test.c,22 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main3:
	DEC	W7
	BRA NZ	L_main3
	NOP
	NOP
;mult_test.c,23 :: 		LATDbits.LATD0 = 1;
	BSET.B	LATDbits, #0
;mult_test.c,25 :: 		LATDbits.LATD1 = 0;
	BCLR.B	LATDbits, #1
;mult_test.c,26 :: 		LATB = a1[1];
	MOV	_a1+2, W0
	MOV	WREG, LATB
;mult_test.c,27 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	NOP
	NOP
;mult_test.c,28 :: 		LATDbits.LATD1 = 1;
	BSET.B	LATDbits, #1
;mult_test.c,30 :: 		LATDbits.LATD2 = 0;
	BCLR.B	LATDbits, #2
;mult_test.c,31 :: 		LATB = a1[2];
	MOV	_a1+4, W0
	MOV	WREG, LATB
;mult_test.c,32 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	NOP
	NOP
;mult_test.c,33 :: 		LATDbits.LATD2 = 1;   ;
	BSET.B	LATDbits, #2
;mult_test.c,35 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;mult_test.c,36 :: 		LATB = a1[3];
	MOV	_a1+6, W0
	MOV	WREG, LATB
;mult_test.c,37 :: 		Delay_ms(2);
	MOV	#10666, W7
L_main9:
	DEC	W7
	BRA NZ	L_main9
	NOP
	NOP
;mult_test.c,38 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;mult_test.c,39 :: 		if (i >= 60){
	MOV	#60, W1
	MOV	#lo_addr(_i), W0
	CP	W1, [W0]
	BRA LEU	L__main13
	GOTO	L_main11
L__main13:
;mult_test.c,40 :: 		i = 0;
	CLR	W0
	MOV	W0, _i
;mult_test.c,41 :: 		aux   = a1[0];
	MOV	_a1, W0
	MOV	W0, _aux
;mult_test.c,42 :: 		a1[0] = a1[1];
	MOV	_a1+2, W0
	MOV	W0, _a1
;mult_test.c,43 :: 		a1[1] = a1[2];
	MOV	_a1+4, W0
	MOV	W0, _a1+2
;mult_test.c,44 :: 		a1[2] = a1[3];
	MOV	_a1+6, W0
	MOV	W0, _a1+4
;mult_test.c,45 :: 		a1[3] = aux;
	MOV	_aux, W0
	MOV	W0, _a1+6
;mult_test.c,46 :: 		}
L_main11:
;mult_test.c,47 :: 		i++;
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;mult_test.c,50 :: 		}while(1);
	GOTO	L_main0
;mult_test.c,51 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
