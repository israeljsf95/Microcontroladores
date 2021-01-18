
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Q9.c,7 :: 		void main() {
;Q9.c,8 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Q9.c,9 :: 		TRISD = 0;
	CLR	TRISD
;Q9.c,10 :: 		LATD = 0;
	CLR	LATD
;Q9.c,11 :: 		TRISB = 0;
	CLR	TRISB
;Q9.c,12 :: 		LATB = 0;
	CLR	LATB
;Q9.c,13 :: 		TRISF = 1;
	MOV	#1, W0
	MOV	WREG, TRISF
;Q9.c,14 :: 		while(1){
L_main0:
;Q9.c,16 :: 		LATDbits.LATD1 = 1;
	BSET.B	LATDbits, #1
;Q9.c,17 :: 		LATDbits.LATD2 = 1;
	BSET.B	LATDbits, #2
;Q9.c,18 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;Q9.c,19 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;Q9.c,20 :: 		while(PORTFbits.RF0 == 1){
L_main2:
	BTSS.B	PORTFbits, #0
	GOTO	L_main3
;Q9.c,21 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;Q9.c,22 :: 		if (PORTFbits.RF0 == 0){
	BTSC.B	PORTFbits, #0
	GOTO	L_main4
;Q9.c,23 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;Q9.c,24 :: 		break;
	GOTO	L_main3
;Q9.c,25 :: 		}
L_main4:
;Q9.c,26 :: 		LATDbits.LATD1 = 1;
	BSET.B	LATDbits, #1
;Q9.c,27 :: 		LATDbits.LATD2 = 1;
	BSET.B	LATDbits, #2
;Q9.c,28 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;Q9.c,29 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;Q9.c,30 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;Q9.c,31 :: 		}
	GOTO	L_main2
L_main3:
;Q9.c,32 :: 		for(i=0; i <= 50; i++){
	CLR	W0
	MOV	W0, _i
L_main5:
	MOV	#50, W1
	MOV	#lo_addr(_i), W0
	CP	W1, [W0]
	BRA GEU	L__main12
	GOTO	L_main6
L__main12:
;Q9.c,34 :: 		LATDbits.LATD0 = 0;
	BCLR.B	LATDbits, #0
;Q9.c,35 :: 		LATB = num[cont];
	MOV	_cont, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATB
;Q9.c,36 :: 		Delay_ms(100);
	MOV	#2, W8
	MOV	#17796, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
	NOP
	NOP
;Q9.c,37 :: 		LATDbits.LATD0 = 1;
	BSET.B	LATDbits, #0
;Q9.c,32 :: 		for(i=0; i <= 50; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;Q9.c,38 :: 		}
	GOTO	L_main5
L_main6:
;Q9.c,39 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;Q9.c,40 :: 		if (cont==10){
	MOV	_cont, W0
	CP	W0, #10
	BRA Z	L__main13
	GOTO	L_main10
L__main13:
;Q9.c,41 :: 		cont=0;
	CLR	W0
	MOV	W0, _cont
;Q9.c,42 :: 		}
L_main10:
;Q9.c,43 :: 		}
	GOTO	L_main0
;Q9.c,46 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
