
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;teste_reg_AD.c,3 :: 		void main() {
;teste_reg_AD.c,4 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;teste_reg_AD.c,7 :: 		while(1) {
L_main0:
;teste_reg_AD.c,8 :: 		}
	GOTO	L_main0
;teste_reg_AD.c,9 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
