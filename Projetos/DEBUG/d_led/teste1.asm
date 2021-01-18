
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste1.c,1 :: 		void main() {
;teste1.c,2 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste1.c,3 :: 		TRISB = 0;
	CLR	TRISB
;teste1.c,5 :: 		while(1){
L_main0:
;teste1.c,6 :: 		LATB = 0b111111111;
	MOV	#511, W0
	MOV	WREG, LATB
;teste1.c,7 :: 		}
	GOTO	L_main0
;teste1.c,8 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
