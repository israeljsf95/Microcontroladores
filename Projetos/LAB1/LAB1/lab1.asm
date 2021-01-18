
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;lab1.c,16 :: 		void main() {
;lab1.c,18 :: 		ADPCFG=0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;lab1.c,19 :: 		TRISB=0;
	CLR	TRISB
;lab1.c,20 :: 		TRISD=0;
	CLR	TRISD
;lab1.c,22 :: 		while(1){
L_main0:
;lab1.c,23 :: 		leitor();
	CALL	_leitor
;lab1.c,24 :: 		Delay_ms(5);
	MOV	#26666, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	NOP
	NOP
;lab1.c,25 :: 		conv_char_to_hexa();
	CALL	_conv_char_to_hexa
;lab1.c,26 :: 		}
	GOTO	L_main0
;lab1.c,27 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_leitor:

;lab1.c,40 :: 		void leitor(){
;lab1.c,42 :: 		for(i=0;i < 4;i++){
	CLR	W0
	MOV	W0, _i
L_leitor4:
	MOV	_i, W0
	CP	W0, #4
	BRA LTU	L__leitor57
	GOTO	L_leitor5
L__leitor57:
;lab1.c,43 :: 		LATD = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATD
;lab1.c,44 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor7:
	DEC	W7
	BRA NZ	L_leitor7
	NOP
;lab1.c,45 :: 		LATB = 0xFF;
	MOV	#255, W0
	MOV	WREG, LATB
;lab1.c,46 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor9:
	DEC	W7
	BRA NZ	L_leitor9
	NOP
;lab1.c,47 :: 		LATB = hexa1[i];
	MOV	#lo_addr(_hexa1), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;lab1.c,48 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor11:
	DEC	W7
	BRA NZ	L_leitor11
	NOP
;lab1.c,49 :: 		LATD = D[i];
	MOV	#lo_addr(_D), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATD
;lab1.c,50 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor13:
	DEC	W7
	BRA NZ	L_leitor13
	NOP
;lab1.c,42 :: 		for(i=0;i < 4;i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;lab1.c,51 :: 		}
	GOTO	L_leitor4
L_leitor5:
;lab1.c,52 :: 		}
L_end_leitor:
	RETURN
; end of _leitor

_conv_char_to_hexa:
	LNK	#2

;lab1.c,54 :: 		void conv_char_to_hexa(){
;lab1.c,55 :: 		for(j=0;j<4;j++){
	PUSH	W10
	CLR	W0
	MOV	W0, _j
L_conv_char_to_hexa15:
	MOV	_j, W0
	CP	W0, #4
	BRA LTU	L__conv_char_to_hexa59
	GOTO	L_conv_char_to_hexa16
L__conv_char_to_hexa59:
;lab1.c,56 :: 		hexa1[j] = char_to_7seg(disp7[j]);
	MOV	#lo_addr(_hexa1), W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], W0
	MOV	W0, [W14+0]
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W10
	CALL	_char_to_7seg
	MOV	[W14+0], W1
	MOV.B	W0, [W1]
;lab1.c,57 :: 		Delay_ms(1);
	MOV	#5333, W7
L_conv_char_to_hexa18:
	DEC	W7
	BRA NZ	L_conv_char_to_hexa18
	NOP
;lab1.c,55 :: 		for(j=0;j<4;j++){
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], [W0]
;lab1.c,58 :: 		}
	GOTO	L_conv_char_to_hexa15
L_conv_char_to_hexa16:
;lab1.c,59 :: 		}
L_end_conv_char_to_hexa:
	POP	W10
	ULNK
	RETURN
; end of _conv_char_to_hexa

_char_to_7seg:

;lab1.c,67 :: 		int char_to_7seg(char _char){
;lab1.c,69 :: 		switch(_char){
	GOTO	L_char_to_7seg20
;lab1.c,70 :: 		case ('-'):
L_char_to_7seg22:
;lab1.c,71 :: 		hexa = 0xBF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#191, W0
	MOV.B	W0, [W1]
;lab1.c,72 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,74 :: 		case(' '):
L_char_to_7seg23:
;lab1.c,75 :: 		hexa = 0xFF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#255, W0
	MOV.B	W0, [W1]
;lab1.c,76 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,78 :: 		case('a'):
L_char_to_7seg24:
;lab1.c,79 :: 		hexa=0x88;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#136, W0
	MOV.B	W0, [W1]
;lab1.c,80 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,82 :: 		case('b'):
L_char_to_7seg25:
;lab1.c,83 :: 		hexa=0x83;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#131, W0
	MOV.B	W0, [W1]
;lab1.c,84 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,86 :: 		case('c'):
L_char_to_7seg26:
;lab1.c,87 :: 		hexa=0xA7;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#167, W0
	MOV.B	W0, [W1]
;lab1.c,88 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,90 :: 		case('d'):
L_char_to_7seg27:
;lab1.c,91 :: 		hexa=0xA1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#161, W0
	MOV.B	W0, [W1]
;lab1.c,92 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,94 :: 		case('e'):
L_char_to_7seg28:
;lab1.c,95 :: 		hexa=0x86;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#134, W0
	MOV.B	W0, [W1]
;lab1.c,96 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,98 :: 		case('f'):
L_char_to_7seg29:
;lab1.c,99 :: 		hexa=0x8E;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#142, W0
	MOV.B	W0, [W1]
;lab1.c,100 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,102 :: 		case('g'):
L_char_to_7seg30:
;lab1.c,103 :: 		hexa=0x90;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#144, W0
	MOV.B	W0, [W1]
;lab1.c,104 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,106 :: 		case('h'):
L_char_to_7seg31:
;lab1.c,107 :: 		hexa=0x8B;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#139, W0
	MOV.B	W0, [W1]
;lab1.c,108 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,110 :: 		case('i'):
L_char_to_7seg32:
;lab1.c,111 :: 		hexa=0xF9;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#249, W0
	MOV.B	W0, [W1]
;lab1.c,112 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,114 :: 		case('j'):
L_char_to_7seg33:
;lab1.c,115 :: 		hexa=0xE1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#225, W0
	MOV.B	W0, [W1]
;lab1.c,116 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,118 :: 		case('l'):
L_char_to_7seg34:
;lab1.c,119 :: 		hexa=0xF1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#241, W0
	MOV.B	W0, [W1]
;lab1.c,120 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,122 :: 		case('n'):
L_char_to_7seg35:
;lab1.c,123 :: 		hexa=0xAB;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#171, W0
	MOV.B	W0, [W1]
;lab1.c,124 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,126 :: 		case('o'):
L_char_to_7seg36:
;lab1.c,127 :: 		hexa=0xA3;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#163, W0
	MOV.B	W0, [W1]
;lab1.c,128 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,130 :: 		case('p'):
L_char_to_7seg37:
;lab1.c,131 :: 		hexa=0x8C;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#140, W0
	MOV.B	W0, [W1]
;lab1.c,132 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,134 :: 		case('q'):
L_char_to_7seg38:
;lab1.c,135 :: 		hexa=0x98;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#152, W0
	MOV.B	W0, [W1]
;lab1.c,136 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,138 :: 		case('r'):
L_char_to_7seg39:
;lab1.c,139 :: 		hexa=0xAF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#175, W0
	MOV.B	W0, [W1]
;lab1.c,140 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,142 :: 		case('s'):
L_char_to_7seg40:
;lab1.c,143 :: 		hexa=0x92;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#146, W0
	MOV.B	W0, [W1]
;lab1.c,144 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,146 :: 		case('u'):
L_char_to_7seg41:
;lab1.c,147 :: 		hexa=0xC1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#193, W0
	MOV.B	W0, [W1]
;lab1.c,148 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,150 :: 		case('v'):
L_char_to_7seg42:
;lab1.c,151 :: 		hexa=0xE3;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#227, W0
	MOV.B	W0, [W1]
;lab1.c,152 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,154 :: 		case('z'):
L_char_to_7seg43:
;lab1.c,155 :: 		hexa=0xE4;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#228, W0
	MOV.B	W0, [W1]
;lab1.c,156 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,158 :: 		case('0'):
L_char_to_7seg44:
;lab1.c,159 :: 		hexa=0xC0;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#192, W0
	MOV.B	W0, [W1]
;lab1.c,160 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,162 :: 		case('1'):
L_char_to_7seg45:
;lab1.c,163 :: 		hexa=0xF9;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#249, W0
	MOV.B	W0, [W1]
;lab1.c,164 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,166 :: 		case('2'):
L_char_to_7seg46:
;lab1.c,167 :: 		hexa=0xA4;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#164, W0
	MOV.B	W0, [W1]
;lab1.c,168 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,170 :: 		case('3'):
L_char_to_7seg47:
;lab1.c,171 :: 		hexa=0xB0;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#176, W0
	MOV.B	W0, [W1]
;lab1.c,172 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,174 :: 		case('4'):
L_char_to_7seg48:
;lab1.c,175 :: 		hexa=0x99;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#153, W0
	MOV.B	W0, [W1]
;lab1.c,176 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,178 :: 		case('5'):
L_char_to_7seg49:
;lab1.c,179 :: 		hexa=0x92;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#146, W0
	MOV.B	W0, [W1]
;lab1.c,180 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,182 :: 		case('6'):
L_char_to_7seg50:
;lab1.c,183 :: 		hexa=0x82;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#130, W0
	MOV.B	W0, [W1]
;lab1.c,184 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,186 :: 		case('7'):
L_char_to_7seg51:
;lab1.c,187 :: 		hexa=0xF8;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#248, W0
	MOV.B	W0, [W1]
;lab1.c,188 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,190 :: 		case('8'):
L_char_to_7seg52:
;lab1.c,191 :: 		hexa=0x80;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#128, W0
	MOV.B	W0, [W1]
;lab1.c,192 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,194 :: 		case('9'):
L_char_to_7seg53:
;lab1.c,195 :: 		hexa=0x90;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#144, W0
	MOV.B	W0, [W1]
;lab1.c,196 :: 		break;
	GOTO	L_char_to_7seg21
;lab1.c,197 :: 		}
L_char_to_7seg20:
	MOV.B	#45, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg61
	GOTO	L_char_to_7seg22
L__char_to_7seg61:
	MOV.B	#32, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg62
	GOTO	L_char_to_7seg23
L__char_to_7seg62:
	MOV.B	#97, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg63
	GOTO	L_char_to_7seg24
L__char_to_7seg63:
	MOV.B	#98, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg64
	GOTO	L_char_to_7seg25
L__char_to_7seg64:
	MOV.B	#99, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg65
	GOTO	L_char_to_7seg26
L__char_to_7seg65:
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg66
	GOTO	L_char_to_7seg27
L__char_to_7seg66:
	MOV.B	#101, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg67
	GOTO	L_char_to_7seg28
L__char_to_7seg67:
	MOV.B	#102, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg68
	GOTO	L_char_to_7seg29
L__char_to_7seg68:
	MOV.B	#103, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg69
	GOTO	L_char_to_7seg30
L__char_to_7seg69:
	MOV.B	#104, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg70
	GOTO	L_char_to_7seg31
L__char_to_7seg70:
	MOV.B	#105, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg71
	GOTO	L_char_to_7seg32
L__char_to_7seg71:
	MOV.B	#106, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg72
	GOTO	L_char_to_7seg33
L__char_to_7seg72:
	MOV.B	#108, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg73
	GOTO	L_char_to_7seg34
L__char_to_7seg73:
	MOV.B	#110, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg74
	GOTO	L_char_to_7seg35
L__char_to_7seg74:
	MOV.B	#111, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg75
	GOTO	L_char_to_7seg36
L__char_to_7seg75:
	MOV.B	#112, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg76
	GOTO	L_char_to_7seg37
L__char_to_7seg76:
	MOV.B	#113, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg77
	GOTO	L_char_to_7seg38
L__char_to_7seg77:
	MOV.B	#114, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg78
	GOTO	L_char_to_7seg39
L__char_to_7seg78:
	MOV.B	#115, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg79
	GOTO	L_char_to_7seg40
L__char_to_7seg79:
	MOV.B	#117, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg80
	GOTO	L_char_to_7seg41
L__char_to_7seg80:
	MOV.B	#118, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg81
	GOTO	L_char_to_7seg42
L__char_to_7seg81:
	MOV.B	#122, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg82
	GOTO	L_char_to_7seg43
L__char_to_7seg82:
	MOV.B	#48, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg83
	GOTO	L_char_to_7seg44
L__char_to_7seg83:
	MOV.B	#49, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg84
	GOTO	L_char_to_7seg45
L__char_to_7seg84:
	MOV.B	#50, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg85
	GOTO	L_char_to_7seg46
L__char_to_7seg85:
	MOV.B	#51, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg86
	GOTO	L_char_to_7seg47
L__char_to_7seg86:
	MOV.B	#52, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg87
	GOTO	L_char_to_7seg48
L__char_to_7seg87:
	MOV.B	#53, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg88
	GOTO	L_char_to_7seg49
L__char_to_7seg88:
	MOV.B	#54, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg89
	GOTO	L_char_to_7seg50
L__char_to_7seg89:
	MOV.B	#55, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg90
	GOTO	L_char_to_7seg51
L__char_to_7seg90:
	MOV.B	#56, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg91
	GOTO	L_char_to_7seg52
L__char_to_7seg91:
	MOV.B	#57, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg92
	GOTO	L_char_to_7seg53
L__char_to_7seg92:
L_char_to_7seg21:
;lab1.c,198 :: 		return hexa;
	MOV	#lo_addr(_hexa), W0
	ZE	[W0], W0
;lab1.c,199 :: 		}
L_end_char_to_7seg:
	RETURN
; end of _char_to_7seg
