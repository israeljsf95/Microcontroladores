
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#4

;ex3.c,1 :: 		void main() {
;ex3.c,2 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;ex3.c,3 :: 		TRISB=0;
	CLR	TRISB
;ex3.c,4 :: 		TRISD=255;
	MOV	#255, W0
	MOV	WREG, TRISD
;ex3.c,5 :: 		while(1){
L_main0:
;ex3.c,6 :: 		if (PORTDbits.RD1==1){
	BTSS.B	PORTDbits, #1
	GOTO	L_main2
;ex3.c,8 :: 		for(i=256;i>=1;i=i/2){
	MOV	#256, W0
	MOV	W0, [W14+0]
L_main3:
	MOV	[W14+0], W0
	CP	W0, #1
	BRA GE	L__main17
	GOTO	L_main4
L__main17:
;ex3.c,9 :: 		LATB=i;
	MOV	[W14+0], W0
	MOV	WREG, LATB
;ex3.c,10 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	DEC	W8
	BRA NZ	L_main6
;ex3.c,8 :: 		for(i=256;i>=1;i=i/2){
	MOV	[W14+0], W0
	MOV	#2, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, [W14+0]
;ex3.c,11 :: 		}
	GOTO	L_main3
L_main4:
;ex3.c,12 :: 		}else{
	GOTO	L_main8
L_main2:
;ex3.c,14 :: 		for(i=1;i<256;i=i*2){
	MOV	#1, W0
	MOV	W0, [W14+2]
L_main9:
	MOV	[W14+2], W1
	MOV	#256, W0
	CP	W1, W0
	BRA LT	L__main18
	GOTO	L_main10
L__main18:
;ex3.c,15 :: 		LATB=i;
	MOV	[W14+2], W0
	MOV	WREG, LATB
;ex3.c,16 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	DEC	W8
	BRA NZ	L_main12
;ex3.c,14 :: 		for(i=1;i<256;i=i*2){
	MOV	[W14+2], W0
	SL	W0, #1, W0
	MOV	W0, [W14+2]
;ex3.c,17 :: 		}
	GOTO	L_main9
L_main10:
;ex3.c,18 :: 		}
L_main8:
;ex3.c,19 :: 		LATB=0;
	CLR	LATB
;ex3.c,20 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;ex3.c,21 :: 		}
	GOTO	L_main0
;ex3.c,22 :: 		}
L_end_main:
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
