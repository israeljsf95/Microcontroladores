
_bcd:

;char2bcd.h,1 :: 		unsigned int bcd(char _char){
;char2bcd.h,2 :: 		unsigned int hexa = 0;
; hexa start address is: 2 (W1)
	CLR	W1
;char2bcd.h,3 :: 		switch(_char){
	GOTO	L_bcd0
; hexa end address is: 2 (W1)
;char2bcd.h,4 :: 		case('a'):
L_bcd2:
;char2bcd.h,5 :: 		hexa=0x23;
; hexa start address is: 2 (W1)
	MOV	#35, W1
;char2bcd.h,6 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,8 :: 		case('b'):
L_bcd3:
;char2bcd.h,9 :: 		hexa=0x83;
; hexa start address is: 2 (W1)
	MOV	#131, W1
;char2bcd.h,10 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,12 :: 		case('c'):
L_bcd4:
;char2bcd.h,13 :: 		hexa=0xA7;
; hexa start address is: 2 (W1)
	MOV	#167, W1
;char2bcd.h,14 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,16 :: 		case('d'):
L_bcd5:
;char2bcd.h,17 :: 		hexa=0xA1;
; hexa start address is: 2 (W1)
	MOV	#161, W1
;char2bcd.h,18 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,20 :: 		case('e'):
L_bcd6:
;char2bcd.h,21 :: 		hexa=0x86;
; hexa start address is: 2 (W1)
	MOV	#134, W1
;char2bcd.h,22 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,24 :: 		case('f'):
L_bcd7:
;char2bcd.h,25 :: 		hexa=0x8E;
; hexa start address is: 2 (W1)
	MOV	#142, W1
;char2bcd.h,26 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,28 :: 		case('g'):
L_bcd8:
;char2bcd.h,29 :: 		hexa=0x90;
; hexa start address is: 2 (W1)
	MOV	#144, W1
;char2bcd.h,30 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,32 :: 		case('h'):
L_bcd9:
;char2bcd.h,33 :: 		hexa=0x8B;
; hexa start address is: 2 (W1)
	MOV	#139, W1
;char2bcd.h,34 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,36 :: 		case('i'):
L_bcd10:
;char2bcd.h,37 :: 		hexa=0xF9;
; hexa start address is: 2 (W1)
	MOV	#249, W1
;char2bcd.h,38 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,40 :: 		case('j'):
L_bcd11:
;char2bcd.h,41 :: 		hexa=0xE1;
; hexa start address is: 2 (W1)
	MOV	#225, W1
;char2bcd.h,42 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,44 :: 		case('l'):
L_bcd12:
;char2bcd.h,45 :: 		hexa=0xC7;
; hexa start address is: 2 (W1)
	MOV	#199, W1
;char2bcd.h,46 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,48 :: 		case('n'):
L_bcd13:
;char2bcd.h,49 :: 		hexa=0xAB;
; hexa start address is: 2 (W1)
	MOV	#171, W1
;char2bcd.h,50 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,52 :: 		case('o'):
L_bcd14:
;char2bcd.h,53 :: 		hexa=0xA3;
; hexa start address is: 2 (W1)
	MOV	#163, W1
;char2bcd.h,54 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,56 :: 		case('p'):
L_bcd15:
;char2bcd.h,57 :: 		hexa=0x8C;
; hexa start address is: 2 (W1)
	MOV	#140, W1
;char2bcd.h,58 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,60 :: 		case('q'):
L_bcd16:
;char2bcd.h,61 :: 		hexa=0x98;
; hexa start address is: 2 (W1)
	MOV	#152, W1
;char2bcd.h,62 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,64 :: 		case('r'):
L_bcd17:
;char2bcd.h,65 :: 		hexa=0xAF;
; hexa start address is: 2 (W1)
	MOV	#175, W1
;char2bcd.h,66 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,68 :: 		case('s'):
L_bcd18:
;char2bcd.h,69 :: 		hexa=0x92;
; hexa start address is: 2 (W1)
	MOV	#146, W1
;char2bcd.h,70 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,72 :: 		case('u'):
L_bcd19:
;char2bcd.h,73 :: 		hexa=0xC1;
; hexa start address is: 2 (W1)
	MOV	#193, W1
;char2bcd.h,74 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,76 :: 		case('v'):
L_bcd20:
;char2bcd.h,77 :: 		hexa=0xE3;
; hexa start address is: 2 (W1)
	MOV	#227, W1
;char2bcd.h,78 :: 		break;
; hexa end address is: 2 (W1)
	GOTO	L_bcd1
;char2bcd.h,80 :: 		case('z'):
L_bcd21:
;char2bcd.h,81 :: 		hexa=0xE4;
; hexa start address is: 2 (W1)
	MOV	#228, W1
;char2bcd.h,82 :: 		break;
	GOTO	L_bcd1
;char2bcd.h,84 :: 		}
L_bcd0:
	MOV.B	#97, W0
	CP.B	W10, W0
	BRA NZ	L__bcd30
	GOTO	L_bcd2
L__bcd30:
	MOV.B	#98, W0
	CP.B	W10, W0
	BRA NZ	L__bcd31
	GOTO	L_bcd3
L__bcd31:
	MOV.B	#99, W0
	CP.B	W10, W0
	BRA NZ	L__bcd32
	GOTO	L_bcd4
L__bcd32:
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA NZ	L__bcd33
	GOTO	L_bcd5
L__bcd33:
	MOV.B	#101, W0
	CP.B	W10, W0
	BRA NZ	L__bcd34
	GOTO	L_bcd6
L__bcd34:
	MOV.B	#102, W0
	CP.B	W10, W0
	BRA NZ	L__bcd35
	GOTO	L_bcd7
L__bcd35:
	MOV.B	#103, W0
	CP.B	W10, W0
	BRA NZ	L__bcd36
	GOTO	L_bcd8
L__bcd36:
	MOV.B	#104, W0
	CP.B	W10, W0
	BRA NZ	L__bcd37
	GOTO	L_bcd9
L__bcd37:
	MOV.B	#105, W0
	CP.B	W10, W0
	BRA NZ	L__bcd38
	GOTO	L_bcd10
L__bcd38:
	MOV.B	#106, W0
	CP.B	W10, W0
	BRA NZ	L__bcd39
	GOTO	L_bcd11
L__bcd39:
	MOV.B	#108, W0
	CP.B	W10, W0
	BRA NZ	L__bcd40
	GOTO	L_bcd12
L__bcd40:
	MOV.B	#110, W0
	CP.B	W10, W0
	BRA NZ	L__bcd41
	GOTO	L_bcd13
L__bcd41:
	MOV.B	#111, W0
	CP.B	W10, W0
	BRA NZ	L__bcd42
	GOTO	L_bcd14
L__bcd42:
	MOV.B	#112, W0
	CP.B	W10, W0
	BRA NZ	L__bcd43
	GOTO	L_bcd15
L__bcd43:
	MOV.B	#113, W0
	CP.B	W10, W0
	BRA NZ	L__bcd44
	GOTO	L_bcd16
L__bcd44:
	MOV.B	#114, W0
	CP.B	W10, W0
	BRA NZ	L__bcd45
	GOTO	L_bcd17
L__bcd45:
	MOV.B	#115, W0
	CP.B	W10, W0
	BRA NZ	L__bcd46
	GOTO	L_bcd18
L__bcd46:
	MOV.B	#117, W0
	CP.B	W10, W0
	BRA NZ	L__bcd47
	GOTO	L_bcd19
L__bcd47:
	MOV.B	#118, W0
	CP.B	W10, W0
	BRA NZ	L__bcd48
	GOTO	L_bcd20
L__bcd48:
	MOV.B	#122, W0
	CP.B	W10, W0
	BRA NZ	L__bcd49
	GOTO	L_bcd21
L__bcd49:
; hexa end address is: 2 (W1)
L_bcd1:
;char2bcd.h,85 :: 		return hexa;
; hexa start address is: 2 (W1)
	MOV	W1, W0
; hexa end address is: 2 (W1)
;char2bcd.h,86 :: 		}
L_end_bcd:
	RETURN
; end of _bcd

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;test1.c,6 :: 		void main() {
;test1.c,7 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;test1.c,8 :: 		TRISD = 0;
	CLR	TRISD
;test1.c,9 :: 		TRISB = 0;
	CLR	TRISB
;test1.c,10 :: 		LATD = 1;
	MOV	#1, W0
	MOV	WREG, LATD
;test1.c,11 :: 		LATB = 0;
	CLR	LATB
;test1.c,12 :: 		while(1){
L_main22:
;test1.c,13 :: 		for(i = 0; i<20; i++){
	CLR	W0
	MOV	W0, _i
L_main24:
	MOV	_i, W0
	CP	W0, #20
	BRA LTU	L__main51
	GOTO	L_main25
L__main51:
;test1.c,14 :: 		LATD = 0b1110;
	MOV	#14, W0
	MOV	WREG, LATD
;test1.c,15 :: 		LATB = bcd(letras[i]);
	MOV	#lo_addr(_letras), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W10
	CALL	_bcd
	MOV	WREG, LATB
;test1.c,16 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main27:
	DEC	W7
	BRA NZ	L_main27
	DEC	W8
	BRA NZ	L_main27
;test1.c,13 :: 		for(i = 0; i<20; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;test1.c,18 :: 		}
	GOTO	L_main24
L_main25:
;test1.c,19 :: 		}
	GOTO	L_main22
;test1.c,20 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
