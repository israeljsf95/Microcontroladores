
_init_OCmod:

;PWM.c,4 :: 		void init_OCmod(){
;PWM.c,5 :: 		TRISD = 0;
	CLR	TRISD
;PWM.c,6 :: 		IFS0 = 0;
	CLR	IFS0
;PWM.c,7 :: 		IEC0 = 0;
	CLR	IEC0
;PWM.c,9 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;PWM.c,10 :: 		T2CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T2CON
;PWM.c,11 :: 		PR2 = 1250;
	MOV	#1250, W0
	MOV	WREG, PR2
;PWM.c,13 :: 		OC1CON = 0;
	CLR	OC1CON
;PWM.c,14 :: 		OC1CONbits.OCM = 0b110;
	MOV.B	#6, W0
	MOV.B	W0, W1
	MOV	#lo_addr(OC1CONbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #7, W1
	MOV	#lo_addr(OC1CONbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(OC1CONbits), W0
	MOV.B	W1, [W0]
;PWM.c,15 :: 		OC1CONbits.OCTSEL = 0;
	BCLR.B	OC1CONbits, #3
;PWM.c,16 :: 		OC1RS = 1250;
	MOV	#1250, W0
	MOV	WREG, OC1RS
;PWM.c,18 :: 		OC3CON = 0;
	CLR	OC3CON
;PWM.c,19 :: 		OC3CONbits.OCM = 0b110;
	MOV.B	#6, W0
	MOV.B	W0, W1
	MOV	#lo_addr(OC3CONbits), W0
	XOR.B	W1, [W0], W1
	AND.B	W1, #7, W1
	MOV	#lo_addr(OC3CONbits), W0
	XOR.B	W1, [W0], W1
	MOV	#lo_addr(OC3CONbits), W0
	MOV.B	W1, [W0]
;PWM.c,20 :: 		OC3CONbits.OCTSEL = 0;
	BCLR.B	OC3CONbits, #3
;PWM.c,21 :: 		OC3RS = 0;
	CLR	OC3RS
;PWM.c,22 :: 		}
L_end_init_OCmod:
	RETURN
; end of _init_OCmod

_mudar_PWM:

;PWM.c,24 :: 		void mudar_PWM(float duty1, float duty2){
;PWM.c,25 :: 		OC1RS = floor(PR2*duty1);
	PUSH	W10
	PUSH	W11
	PUSH.D	W12
	PUSH.D	W10
	MOV	PR2, WREG
	CLR	W1
	CALL	__Long2Float
	POP.D	W10
	MOV.D	W10, W2
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, OC1RS
;PWM.c,26 :: 		OC3RS = floor(PR2*duty2);
	MOV	PR2, WREG
	CLR	W1
	CALL	__Long2Float
	POP.D	W12
	MOV.D	W12, W2
	CALL	__Mul_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	MOV	WREG, OC3RS
;PWM.c,27 :: 		}
L_end_mudar_PWM:
	POP	W11
	POP	W10
	RETURN
; end of _mudar_PWM

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#4

;PWM.c,31 :: 		void main() {
;PWM.c,33 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;PWM.c,34 :: 		init_OCmod();
	CALL	_init_OCmod
;PWM.c,36 :: 		while(1){
L_main0:
;PWM.c,37 :: 		for (i=0, j = 3; i < 4; i++, j--){
	CLR	W0
	MOV	W0, _i
	MOV	#3, W0
	MOV	W0, _j
L_main2:
	MOV	_i, W0
	CP	W0, #4
	BRA LT	L__main10
	GOTO	L_main3
L__main10:
;PWM.c,38 :: 		mudar_PWM(0.25*i, 0.25*j);
	MOV	_j, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16000, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_i, W0
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	#0, W2
	MOV	#16000, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	MOV.D	W2, W12
	MOV.D	W0, W10
	CALL	_mudar_PWM
;PWM.c,39 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
	NOP
;PWM.c,37 :: 		for (i=0, j = 3; i < 4; i++, j--){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	SUBR	W1, [W0], [W0]
;PWM.c,40 :: 		}
	GOTO	L_main2
L_main3:
;PWM.c,41 :: 		}
	GOTO	L_main0
;PWM.c,42 :: 		}
L_end_main:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
