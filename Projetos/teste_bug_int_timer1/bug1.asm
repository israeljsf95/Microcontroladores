
_relogio:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;bug1.c,1 :: 		void relogio() iv IVT_ADDR_T1INTERRUPT {
;bug1.c,2 :: 		IFS0 = 0;
	CLR	IFS0
;bug1.c,3 :: 		LATFbits.LATF0 = ~LATFbits.LATF0;
	BTG.B	LATFbits, #0
;bug1.c,4 :: 		}
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

;bug1.c,6 :: 		void main() {
;bug1.c,7 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;bug1.c,8 :: 		TRISF = 0;
	CLR	TRISF
;bug1.c,9 :: 		LATF = 0;
	CLR	LATF
;bug1.c,10 :: 		IFS0 = 0;
	CLR	IFS0
;bug1.c,11 :: 		IEC0 = 0x0008;
	MOV	#8, W0
	MOV	WREG, IEC0
;bug1.c,12 :: 		PR1 = 160;
	MOV	#160, W0
	MOV	WREG, PR1
;bug1.c,13 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;bug1.c,14 :: 		TMR1 = 0;
	CLR	TMR1
;bug1.c,15 :: 		while(1){
L_main0:
;bug1.c,17 :: 		}
	GOTO	L_main0
;bug1.c,18 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
