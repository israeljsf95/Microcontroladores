
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;criat_q2.c,29 :: 		void main() {
;criat_q2.c,30 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;criat_q2.c,31 :: 		TRISB = 0;
	CLR	TRISB
;criat_q2.c,32 :: 		TRISD = 0;
	CLR	TRISD
;criat_q2.c,33 :: 		TRISE = 0;
	CLR	TRISE
;criat_q2.c,34 :: 		TRISF = 0;
	CLR	TRISF
;criat_q2.c,35 :: 		while(1){
L_main0:
;criat_q2.c,36 :: 		marcha_imp();
	CALL	_marcha_imp
;criat_q2.c,37 :: 		}
	GOTO	L_main0
;criat_q2.c,38 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_tocar:

;criat_q2.c,43 :: 		void tocar(int freq, long tempo_ms){
;criat_q2.c,45 :: 		long atraso = (long)(1000000/freq);
	PUSH	W11
	PUSH	W12
	MOV	W10, W2
	ASR	W2, #15, W3
	MOV	#16960, W0
	MOV	#15, W1
	SETM	W4
	CALL	__Divide_32x32
	POP	W12
	POP	W11
; atraso start address is: 8 (W4)
	MOV.D	W0, W4
;criat_q2.c,46 :: 		long loop = (long)((tempo_ms*1000)/(atraso*2));
	PUSH.D	W4
	MOV	W11, W0
	MOV	W12, W1
	MOV	#1000, W2
	MOV	#0, W3
	CALL	__Multiply_32x32
	POP.D	W4
	SL	W4, W2
	RLC	W5, W3
	PUSH.D	W4
	SETM	W4
	CALL	__Divide_32x32
	POP.D	W4
; loop start address is: 4 (W2)
	MOV.D	W0, W2
;criat_q2.c,47 :: 		for (x = 0; x < loop; x++){
	CLR	W0
	MOV	W0, _x
; loop end address is: 4 (W2)
; atraso end address is: 8 (W4)
L_tocar2:
; loop start address is: 4 (W2)
; atraso start address is: 8 (W4)
	MOV	_x, W0
	ASR	W0, #15, W1
	CP	W0, W2
	CPB	W1, W3
	BRA LT	L__tocar18
	GOTO	L_tocar3
L__tocar18:
;criat_q2.c,48 :: 		PORTE = 0x01;
	MOV	#1, W0
	MOV	WREG, PORTE
; loop end address is: 4 (W2)
; atraso end address is: 8 (W4)
;criat_q2.c,49 :: 		while(atraso > 0){
L_tocar5:
; atraso start address is: 8 (W4)
; loop start address is: 4 (W2)
	CP	W4, #0
	CPB	W5, #0
	BRA GT	L__tocar19
	GOTO	L_tocar6
L__tocar19:
;criat_q2.c,50 :: 		Delay_ms(1);
	MOV	#5333, W7
L_tocar7:
	DEC	W7
	BRA NZ	L_tocar7
	NOP
;criat_q2.c,51 :: 		atraso--;
	SUB	W4, #1, W4
	SUBB	W5, #0, W5
;criat_q2.c,52 :: 		}
	GOTO	L_tocar5
L_tocar6:
;criat_q2.c,53 :: 		PORTE = 0x00;
	CLR	PORTE
; loop end address is: 4 (W2)
; atraso end address is: 8 (W4)
;criat_q2.c,54 :: 		while(atraso > 0){
L_tocar9:
; loop start address is: 4 (W2)
; atraso start address is: 8 (W4)
	CP	W4, #0
	CPB	W5, #0
	BRA GT	L__tocar20
	GOTO	L_tocar10
L__tocar20:
;criat_q2.c,55 :: 		Delay_ms(1);
	MOV	#5333, W7
L_tocar11:
	DEC	W7
	BRA NZ	L_tocar11
	NOP
;criat_q2.c,56 :: 		atraso--;
	SUB	W4, #1, W4
	SUBB	W5, #0, W5
;criat_q2.c,57 :: 		}
	GOTO	L_tocar9
L_tocar10:
;criat_q2.c,47 :: 		for (x = 0; x < loop; x++){
	MOV	#1, W1
	MOV	#lo_addr(_x), W0
	ADD	W1, [W0], [W0]
;criat_q2.c,58 :: 		}
; loop end address is: 4 (W2)
; atraso end address is: 8 (W4)
	GOTO	L_tocar2
L_tocar3:
;criat_q2.c,59 :: 		Delay_ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_tocar13:
	DEC	W7
	BRA NZ	L_tocar13
	DEC	W8
	BRA NZ	L_tocar13
;criat_q2.c,60 :: 		}
L_end_tocar:
	RETURN
; end of _tocar

_marcha_imp:

;criat_q2.c,62 :: 		void marcha_imp(){
;criat_q2.c,63 :: 		tocar(a, 100);
	PUSH	W10
	PUSH	W11
	PUSH	W12
	MOV	#100, W11
	MOV	#0, W12
	MOV	#440, W10
	CALL	_tocar
;criat_q2.c,64 :: 		tocar(a, 100);
	MOV	#100, W11
	MOV	#0, W12
	MOV	#440, W10
	CALL	_tocar
;criat_q2.c,65 :: 		tocar(a, 100);
	MOV	#100, W11
	MOV	#0, W12
	MOV	#440, W10
	CALL	_tocar
;criat_q2.c,66 :: 		tocar(f, 100);
	MOV	#100, W11
	MOV	#0, W12
	MOV	#349, W10
	CALL	_tocar
;criat_q2.c,67 :: 		tocar(cH, 100);
	MOV	#100, W11
	MOV	#0, W12
	MOV	#523, W10
	CALL	_tocar
;criat_q2.c,79 :: 		}
L_end_marcha_imp:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _marcha_imp
