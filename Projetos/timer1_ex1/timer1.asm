
_relogio:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;timer1.c,3 :: 		void relogio() iv IVT_ADDR_T1INTERRUPT {
;timer1.c,5 :: 		ti = ~ti;
	MOV	#lo_addr(_ti), W0
	COM	[W0], [W0]
;timer1.c,6 :: 		IFS0 = 0;
	CLR	IFS0
;timer1.c,7 :: 		}
L_end_relogio:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _relogio

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;timer1.c,9 :: 		void main() {
;timer1.c,10 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;timer1.c,11 :: 		TRISB=0;
	CLR	TRISB
;timer1.c,12 :: 		TMR1=0;
	CLR	TMR1
;timer1.c,13 :: 		IFS0=0;
	CLR	IFS0
;timer1.c,14 :: 		IEC0=0x0008;
	MOV	#8, W0
	MOV	WREG, IEC0
;timer1.c,15 :: 		PR1=31250;
	MOV	#31250, W0
	MOV	WREG, PR1
;timer1.c,16 :: 		T1CON=0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;timer1.c,17 :: 		while(1){
L_main0:
;timer1.c,18 :: 		if (ti == 0){
	MOV	_ti, W0
	CP	W0, #0
	BRA Z	L__main6
	GOTO	L_main2
L__main6:
;timer1.c,19 :: 		LATB= 0;
	CLR	LATB
;timer1.c,20 :: 		}else{
	GOTO	L_main3
L_main2:
;timer1.c,21 :: 		LATB=1;
	MOV	#1, W0
	MOV	WREG, LATB
;timer1.c,22 :: 		}
L_main3:
;timer1.c,23 :: 		}
	GOTO	L_main0
;timer1.c,24 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
