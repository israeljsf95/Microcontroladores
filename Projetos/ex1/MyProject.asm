
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;MyProject.c,7 :: 		void main() {
;MyProject.c,9 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;MyProject.c,11 :: 		TRISB=0;
	CLR	TRISB
;MyProject.c,13 :: 		num=0x00;
	MOV	#lo_addr(_num), W1
	CLR	W0
	MOV.B	W0, [W1]
;MyProject.c,14 :: 		while(1){
L_main0:
;MyProject.c,16 :: 		LATB=num;
	MOV	#lo_addr(_num), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;MyProject.c,17 :: 		num=num+1;
	MOV.B	#1, W1
	MOV	#lo_addr(_num), W0
	ADD.B	W1, [W0], [W0]
;MyProject.c,18 :: 		if (num>255)
	MOV	#lo_addr(_num), W0
	MOV.B	[W0], W1
	MOV.B	#255, W0
	CP.B	W1, W0
	BRA GTU	L__main6
	GOTO	L_main2
L__main6:
;MyProject.c,20 :: 		num=0;
	MOV	#lo_addr(_num), W1
	CLR	W0
	MOV.B	W0, [W1]
;MyProject.c,21 :: 		}
L_main2:
;MyProject.c,22 :: 		Delay_ms(500);
	MOV	#21, W8
	MOV	#22619, W7
L_main3:
	DEC	W7
	BRA NZ	L_main3
	DEC	W8
	BRA NZ	L_main3
;MyProject.c,24 :: 		}
	GOTO	L_main0
;MyProject.c,25 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
