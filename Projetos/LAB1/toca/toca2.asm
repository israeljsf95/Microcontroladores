
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;toca2.c,12 :: 		void main() {
;toca2.c,13 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;toca2.c,14 :: 		TRISE=0;
	CLR	TRISE
;toca2.c,16 :: 		while(1){
L_main0:
;toca2.c,19 :: 		LATE=mux[k];
	MOV	#lo_addr(_mux), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATE
;toca2.c,20 :: 		Delay_ms(30);
	MOV	#3, W8
	MOV	#28927, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
	NOP
;toca2.c,21 :: 		LATE=0xFE;
	MOV	#254, W0
	MOV	WREG, LATE
;toca2.c,23 :: 		if (k<4){
	MOV	_k, W0
	CP	W0, #4
	BRA LT	L__main14
	GOTO	L_main4
L__main14:
;toca2.c,24 :: 		k++;
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;toca2.c,25 :: 		}else{
	GOTO	L_main5
L_main4:
;toca2.c,26 :: 		k=0;
	CLR	W0
	MOV	W0, _k
;toca2.c,27 :: 		}
L_main5:
;toca2.c,35 :: 		for ( i=jb[cont]+75; i>0 ; i--) {
	MOV	_cont, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_jb), W0
	ADD	W0, W1, W2
	MOV	#75, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W2], [W0]
L_main6:
	MOV	_i, W0
	CP	W0, #0
	BRA GT	L__main15
	GOTO	L_main7
L__main15:
;toca2.c,36 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main9:
	DEC	W7
	BRA NZ	L_main9
	NOP
;toca2.c,35 :: 		for ( i=jb[cont]+75; i>0 ; i--) {
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	SUBR	W1, [W0], [W0]
;toca2.c,37 :: 		}
	GOTO	L_main6
L_main7:
;toca2.c,38 :: 		if (cont<22){
	MOV	_cont, W0
	CP	W0, #22
	BRA LT	L__main16
	GOTO	L_main11
L__main16:
;toca2.c,39 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;toca2.c,40 :: 		}else{
	GOTO	L_main12
L_main11:
;toca2.c,41 :: 		cont=0;
	CLR	W0
	MOV	W0, _cont
;toca2.c,42 :: 		}
L_main12:
;toca2.c,43 :: 		}
	GOTO	L_main0
;toca2.c,44 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
