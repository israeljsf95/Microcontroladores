
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;ex7.c,8 :: 		void main() {
;ex7.c,9 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex7.c,10 :: 		TRISD = 0xFF;
	MOV	#255, W0
	MOV	WREG, TRISD
;ex7.c,11 :: 		TRISB = 0;
	CLR	TRISB
;ex7.c,13 :: 		while(1){
L_main0:
;ex7.c,14 :: 		if (PORTDbits.RD1 == 1){
	BTSS.B	PORTDbits, #1
	GOTO	L_main2
;ex7.c,15 :: 		Delay_ms(120);
	MOV	#10, W8
	MOV	#50178, W7
L_main3:
	DEC	W7
	BRA NZ	L_main3
	DEC	W8
	BRA NZ	L_main3
;ex7.c,16 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;ex7.c,17 :: 		}
L_main2:
;ex7.c,19 :: 		switch (cont){
	GOTO	L_main5
;ex7.c,20 :: 		case 1:
L_main7:
;ex7.c,21 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;ex7.c,22 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
;ex7.c,23 :: 		break;
	GOTO	L_main6
;ex7.c,24 :: 		case 2:
L_main10:
;ex7.c,25 :: 		for (i=1;i < 256; i=i*2){
	MOV	#1, W0
	MOV	W0, _i
L_main11:
	MOV	_i, W1
	MOV	#256, W0
	CP	W1, W0
	BRA LTU	L__main38
	GOTO	L_main12
L__main38:
;ex7.c,28 :: 		LATB = i;
	MOV	_i, W0
	MOV	WREG, LATB
;ex7.c,29 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;ex7.c,25 :: 		for (i=1;i < 256; i=i*2){
	MOV	_i, W0
	SL	W0, #1, W0
	MOV	W0, _i
;ex7.c,30 :: 		}
	GOTO	L_main11
L_main12:
;ex7.c,31 :: 		break;
	GOTO	L_main6
;ex7.c,32 :: 		case 3:
L_main16:
;ex7.c,33 :: 		for (i=256; i >= 1; i=i/2){
	MOV	#256, W0
	MOV	W0, _i
L_main17:
	MOV	_i, W0
	CP	W0, #1
	BRA GEU	L__main39
	GOTO	L_main18
L__main39:
;ex7.c,36 :: 		LATB = i;
	MOV	_i, W0
	MOV	WREG, LATB
;ex7.c,37 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main20:
	DEC	W7
	BRA NZ	L_main20
	DEC	W8
	BRA NZ	L_main20
;ex7.c,33 :: 		for (i=256; i >= 1; i=i/2){
	MOV	_i, W0
	LSR	W0, #1, W0
	MOV	W0, _i
;ex7.c,38 :: 		}
	GOTO	L_main17
L_main18:
;ex7.c,39 :: 		break;
	GOTO	L_main6
;ex7.c,40 :: 		case 4:
L_main22:
;ex7.c,41 :: 		for (i=0; i<4; i++){
	CLR	W0
	MOV	W0, _i
L_main23:
	MOV	_i, W0
	CP	W0, #4
	BRA LTU	L__main40
	GOTO	L_main24
L__main40:
;ex7.c,42 :: 		LATB = num_2[i];
	MOV	#lo_addr(_num_2), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;ex7.c,43 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main26:
	DEC	W7
	BRA NZ	L_main26
	DEC	W8
	BRA NZ	L_main26
;ex7.c,41 :: 		for (i=0; i<4; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;ex7.c,46 :: 		}
	GOTO	L_main23
L_main24:
;ex7.c,47 :: 		break;
	GOTO	L_main6
;ex7.c,48 :: 		case 5:
L_main28:
;ex7.c,49 :: 		for (i=0; i<4; i++){
	CLR	W0
	MOV	W0, _i
L_main29:
	MOV	_i, W0
	CP	W0, #4
	BRA LTU	L__main41
	GOTO	L_main30
L__main41:
;ex7.c,50 :: 		LATB = num_3[i];
	MOV	#lo_addr(_num_3), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;ex7.c,51 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main32:
	DEC	W7
	BRA NZ	L_main32
	DEC	W8
	BRA NZ	L_main32
;ex7.c,49 :: 		for (i=0; i<4; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;ex7.c,52 :: 		}
	GOTO	L_main29
L_main30:
;ex7.c,53 :: 		break;
	GOTO	L_main6
;ex7.c,58 :: 		}
L_main5:
	MOV	_cont, W0
	CP	W0, #1
	BRA NZ	L__main42
	GOTO	L_main7
L__main42:
	MOV	_cont, W0
	CP	W0, #2
	BRA NZ	L__main43
	GOTO	L_main10
L__main43:
	MOV	_cont, W0
	CP	W0, #3
	BRA NZ	L__main44
	GOTO	L_main16
L__main44:
	MOV	_cont, W0
	CP	W0, #4
	BRA NZ	L__main45
	GOTO	L_main22
L__main45:
	MOV	_cont, W0
	CP	W0, #5
	BRA NZ	L__main46
	GOTO	L_main28
L__main46:
L_main6:
;ex7.c,59 :: 		if ((cont>5)){
	MOV	_cont, W0
	CP	W0, #5
	BRA GTU	L__main47
	GOTO	L_main34
L__main47:
;ex7.c,60 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;ex7.c,61 :: 		LATB = 0;
	CLR	LATB
;ex7.c,62 :: 		Delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_main35:
	DEC	W7
	BRA NZ	L_main35
	DEC	W8
	BRA NZ	L_main35
;ex7.c,63 :: 		}
L_main34:
;ex7.c,64 :: 		}
	GOTO	L_main0
;ex7.c,65 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
