
_relogio:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;MyProject.c,2 :: 		void relogio() iv IVT_ADDR_T1INTERRUPT {
;MyProject.c,3 :: 		IFS0 = 0;
	CLR	IFS0
;MyProject.c,4 :: 		LATFbits.LATF1 = ~LATFbits.LATF1;
	BTG.B	LATFbits, #1
;MyProject.c,5 :: 		}
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

;MyProject.c,7 :: 		void main() {
;MyProject.c,8 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;MyProject.c,9 :: 		TRISF = 0;
	CLR	TRISF
;MyProject.c,10 :: 		LATF = 0;
	CLR	LATF
;MyProject.c,11 :: 		IFS0 = 0;
	CLR	IFS0
;MyProject.c,12 :: 		IEC0 = 0x0008;
	MOV	#8, W0
	MOV	WREG, IEC0
;MyProject.c,13 :: 		PR1 = 160;
	MOV	#160, W0
	MOV	WREG, PR1
;MyProject.c,14 :: 		T1CON = 0x8000;
	MOV	#32768, W0
	MOV	WREG, T1CON
;MyProject.c,15 :: 		TMR1 = 0;
	CLR	TMR1
;MyProject.c,16 :: 		while(1){
L_main0:
;MyProject.c,18 :: 		}
	GOTO	L_main0
;MyProject.c,19 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
