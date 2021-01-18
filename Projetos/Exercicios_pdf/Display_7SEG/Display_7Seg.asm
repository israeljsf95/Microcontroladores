
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Display_7Seg.c,6 :: 		void main() {
;Display_7Seg.c,8 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;Display_7Seg.c,9 :: 		TRISB = 0;
	CLR	TRISB
;Display_7Seg.c,10 :: 		TRISD = 0;
	CLR	TRISD
;Display_7Seg.c,11 :: 		while(1) {
L_main0:
;Display_7Seg.c,12 :: 		PortD = 0x1;
	MOV	#1, W0
	MOV	WREG, PORTD
;Display_7Seg.c,13 :: 		for(i=0;i!=10;i++){
	CLR	W0
	MOV	W0, _i
L_main2:
	MOV	_i, W0
	CP	W0, #10
	BRA NZ	L__main8
	GOTO	L_main3
L__main8:
;Display_7Seg.c,14 :: 		delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
	NOP
;Display_7Seg.c,15 :: 		PortB = num[i];
	MOV	_i, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_num), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, PORTB
;Display_7Seg.c,13 :: 		for(i=0;i!=10;i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;Display_7Seg.c,18 :: 		}
	GOTO	L_main2
L_main3:
;Display_7Seg.c,19 :: 		}
	GOTO	L_main0
;Display_7Seg.c,21 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
