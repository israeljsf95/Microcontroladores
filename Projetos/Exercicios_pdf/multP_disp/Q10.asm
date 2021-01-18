
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Q10.c,10 :: 		void main() {
;Q10.c,11 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q10.c,12 :: 		TRISD = 0;
	CLR	TRISD
;Q10.c,13 :: 		LATD = 0;
	CLR	LATD
;Q10.c,14 :: 		TRISB = 0;
	CLR	TRISB
;Q10.c,15 :: 		LATB = 0;
	CLR	LATB
;Q10.c,17 :: 		do{
L_main0:
;Q10.c,19 :: 		for(i=0; i <= 5; i++){
	CLR	W0
	MOV	W0, _i
L_main3:
	MOV	_i, W0
	CP	W0, #5
	BRA LEU	L__main19
	GOTO	L_main4
L__main19:
;Q10.c,21 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;Q10.c,22 :: 		LATB = num[contu];
	MOV	_contu, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;Q10.c,23 :: 		Delay_us(1000);
	MOV	#5333, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	NOP
;Q10.c,24 :: 		LATDbits.LATD0 = 1;
	BSET.B	LATDbits, #0
;Q10.c,26 :: 		LATDbits.LATD1 = 0;
	BCLR.B	LATDbits, #1
;Q10.c,27 :: 		LATB = num[contd];
	MOV	_contd, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;Q10.c,28 :: 		Delay_us(1000);
	MOV	#5333, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	NOP
;Q10.c,29 :: 		LATDbits.LATD1 = 1;
	BSET.B	LATDbits, #1
;Q10.c,31 :: 		LATDbits.LATD2 = 0;
	BCLR.B	LATDbits, #2
;Q10.c,32 :: 		LATB = num[contc];
	MOV	_contc, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;Q10.c,33 :: 		Delay_us(1000);
	MOV	#5333, W7
L_main10:
	DEC	W7
	BRA NZ	L_main10
	NOP
;Q10.c,34 :: 		LATDbits.LATD2 = 1;
	BSET.B	LATDbits, #2
;Q10.c,36 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;Q10.c,37 :: 		LATB = num[contm];
	MOV	_contm, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;Q10.c,38 :: 		Delay_us(1000);
	MOV	#5333, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	NOP
;Q10.c,39 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;Q10.c,19 :: 		for(i=0; i <= 5; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;Q10.c,40 :: 		}
	GOTO	L_main3
L_main4:
;Q10.c,41 :: 		contu++;
	MOV	#1, W1
	MOV	#lo_addr(_contu), W0
	ADD	W1, [W0], [W0]
;Q10.c,42 :: 		if (contu==10){
	MOV	_contu, W0
	CP	W0, #10
	BRA Z	L__main20
	GOTO	L_main14
L__main20:
;Q10.c,43 :: 		contu=0;
	CLR	W0
	MOV	W0, _contu
;Q10.c,44 :: 		contd++;
	MOV	#1, W1
	MOV	#lo_addr(_contd), W0
	ADD	W1, [W0], [W0]
;Q10.c,45 :: 		}
L_main14:
;Q10.c,46 :: 		if (contd==10){
	MOV	_contd, W0
	CP	W0, #10
	BRA Z	L__main21
	GOTO	L_main15
L__main21:
;Q10.c,47 :: 		contd=0;
	CLR	W0
	MOV	W0, _contd
;Q10.c,48 :: 		contc++;
	MOV	#1, W1
	MOV	#lo_addr(_contc), W0
	ADD	W1, [W0], [W0]
;Q10.c,49 :: 		}
L_main15:
;Q10.c,50 :: 		if (contc==10){
	MOV	_contc, W0
	CP	W0, #10
	BRA Z	L__main22
	GOTO	L_main16
L__main22:
;Q10.c,51 :: 		contc=0;
	CLR	W0
	MOV	W0, _contc
;Q10.c,52 :: 		contm++;
	MOV	#1, W1
	MOV	#lo_addr(_contm), W0
	ADD	W1, [W0], [W0]
;Q10.c,53 :: 		}
L_main16:
;Q10.c,54 :: 		if (contm==10){
	MOV	_contm, W0
	CP	W0, #10
	BRA Z	L__main23
	GOTO	L_main17
L__main23:
;Q10.c,55 :: 		contm=0;
	CLR	W0
	MOV	W0, _contm
;Q10.c,56 :: 		}
L_main17:
;Q10.c,57 :: 		}while(1);
	GOTO	L_main0
;Q10.c,58 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
