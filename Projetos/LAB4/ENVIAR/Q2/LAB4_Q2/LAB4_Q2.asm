
_INIT_UART2:

;LAB4_Q2.c,16 :: 		void INIT_UART2(unsigned char valor_baud){
;LAB4_Q2.c,17 :: 		U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;LAB4_Q2.c,18 :: 		U2MODE = 0x0000; //ver tabela para saber as outras configura??es
	CLR	U2MODE
;LAB4_Q2.c,19 :: 		U2STA = 0x0000;
	CLR	U2STA
;LAB4_Q2.c,20 :: 		IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;LAB4_Q2.c,21 :: 		IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;LAB4_Q2.c,22 :: 		IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;LAB4_Q2.c,23 :: 		IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;LAB4_Q2.c,24 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;LAB4_Q2.c,25 :: 		U2STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U2STAbits, #10
;LAB4_Q2.c,26 :: 		}
L_end_INIT_UART2:
	RETURN
; end of _INIT_UART2

_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB4_Q2.c,29 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;LAB4_Q2.c,30 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;LAB4_Q2.c,31 :: 		}
L_end_Tx_serial2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial2

_send_char:

;LAB4_Q2.c,34 :: 		void send_char(unsigned char c){
;LAB4_Q2.c,35 :: 		while( U2STAbits.UTXBF);
L_send_char0:
	BTSS	U2STAbits, #9
	GOTO	L_send_char1
	GOTO	L_send_char0
L_send_char1:
;LAB4_Q2.c,36 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;LAB4_Q2.c,37 :: 		}
L_end_send_char:
	RETURN
; end of _send_char

_send_str:

;LAB4_Q2.c,40 :: 		void send_str(unsigned char* str){
;LAB4_Q2.c,41 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;LAB4_Q2.c,42 :: 		while(str[i])
L_send_str2:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str55
	GOTO	L_send_str3
L__send_str55:
;LAB4_Q2.c,43 :: 		send_char(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str2
L_send_str3:
;LAB4_Q2.c,44 :: 		}
L_end_send_str:
	RETURN
; end of _send_str

_receive_char:

;LAB4_Q2.c,47 :: 		unsigned char receive_char(){
;LAB4_Q2.c,49 :: 		while(!U2STAbits.URXDA);
L_receive_char4:
	BTSC	U2STAbits, #0
	GOTO	L_receive_char5
	GOTO	L_receive_char4
L_receive_char5:
;LAB4_Q2.c,50 :: 		c = U2RXREG; // escreve caractere
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;LAB4_Q2.c,51 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;LAB4_Q2.c,52 :: 		}
L_end_receive_char:
	RETURN
; end of _receive_char

_receive_str:

;LAB4_Q2.c,56 :: 		void receive_str(){
;LAB4_Q2.c,57 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;LAB4_Q2.c,59 :: 		do{
	GOTO	L_receive_str6
L__receive_str49:
;LAB4_Q2.c,63 :: 		}while(c != 0x0A);
;LAB4_Q2.c,59 :: 		do{
L_receive_str6:
;LAB4_Q2.c,60 :: 		c = receive_char();
; i start address is: 6 (W3)
	CALL	_receive_char
; c start address is: 4 (W2)
	MOV.B	W0, W2
;LAB4_Q2.c,61 :: 		criatividade[i] = c;
	MOV	#lo_addr(_criatividade), W1
	ADD	W1, W3, W1
	MOV.B	W0, [W1]
;LAB4_Q2.c,62 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;LAB4_Q2.c,63 :: 		}while(c != 0x0A);
	CP.B	W2, #10
	BRA Z	L__receive_str58
	GOTO	L__receive_str49
L__receive_str58:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;LAB4_Q2.c,64 :: 		criatividade[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W1
; i end address is: 6 (W3)
	MOV	#lo_addr(_criatividade), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV.B	W0, [W1]
;LAB4_Q2.c,65 :: 		}
L_end_receive_str:
	RETURN
; end of _receive_str

_receive_str_cri:

;LAB4_Q2.c,69 :: 		void receive_str_cri(){
;LAB4_Q2.c,70 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;LAB4_Q2.c,72 :: 		do{
	GOTO	L_receive_str_cri9
L__receive_str_cri50:
;LAB4_Q2.c,76 :: 		}while(c != 0x0A);
;LAB4_Q2.c,72 :: 		do{
L_receive_str_cri9:
;LAB4_Q2.c,73 :: 		c = receive_char();
; i start address is: 6 (W3)
	CALL	_receive_char
; c start address is: 4 (W2)
	MOV.B	W0, W2
;LAB4_Q2.c,74 :: 		criat_aux[i] = c;
	MOV	#lo_addr(_criat_aux), W1
	ADD	W1, W3, W1
	MOV.B	W0, [W1]
;LAB4_Q2.c,75 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;LAB4_Q2.c,76 :: 		}while(c != 0x0A);
	CP.B	W2, #10
	BRA Z	L__receive_str_cri60
	GOTO	L__receive_str_cri50
L__receive_str_cri60:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;LAB4_Q2.c,77 :: 		criat_aux[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W1
; i end address is: 6 (W3)
	MOV	#lo_addr(_criat_aux), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV.B	W0, [W1]
;LAB4_Q2.c,79 :: 		delay_ms(250);
	MOV	#21, W8
	MOV	#22619, W7
L_receive_str_cri12:
	DEC	W7
	BRA NZ	L_receive_str_cri12
	DEC	W8
	BRA NZ	L_receive_str_cri12
;LAB4_Q2.c,80 :: 		}
L_end_receive_str_cri:
	RETURN
; end of _receive_str_cri

_botao:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB4_Q2.c,84 :: 		void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;LAB4_Q2.c,85 :: 		Delay_Ms(50);
	MOV	#5, W8
	MOV	#4523, W7
L_botao14:
	DEC	W7
	BRA NZ	L_botao14
	DEC	W8
	BRA NZ	L_botao14
;LAB4_Q2.c,86 :: 		if (flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__botao62
	GOTO	L_botao16
L__botao62:
;LAB4_Q2.c,87 :: 		flag_criatividade = 1;
	MOV	#1, W0
	MOV	W0, _flag_criatividade
;LAB4_Q2.c,88 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;LAB4_Q2.c,89 :: 		}else{
	GOTO	L_botao17
L_botao16:
;LAB4_Q2.c,90 :: 		flag_criatividade = 0;
	CLR	W0
	MOV	W0, _flag_criatividade
;LAB4_Q2.c,91 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;LAB4_Q2.c,92 :: 		}
L_botao17:
;LAB4_Q2.c,93 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;LAB4_Q2.c,94 :: 		}
L_end_botao:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botao

_mudarPWM:

;LAB4_Q2.c,102 :: 		void mudarPWM(char aux){
;LAB4_Q2.c,104 :: 		switch(aux){
	PUSH	W10
	PUSH	W11
	GOTO	L_mudarPWM18
;LAB4_Q2.c,105 :: 		case 'F':  //frente
L_mudarPWM20:
;LAB4_Q2.c,106 :: 		E1 = 1;
	BSET.B	LATBbits, #2
;LAB4_Q2.c,107 :: 		E2 = 0;
	BCLR.B	LATBbits, #3
;LAB4_Q2.c,108 :: 		D1 = 1;
	BSET.B	LATBbits, #4
;LAB4_Q2.c,109 :: 		D2 = 0;
	BCLR.B	LATBbits, #5
;LAB4_Q2.c,110 :: 		send_str("FRENTE \r\n");
	MOV	#lo_addr(?lstr1_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,111 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,112 :: 		case 'E':  //esquerda
L_mudarPWM21:
;LAB4_Q2.c,113 :: 		E1 = 0;
	BCLR.B	LATBbits, #2
;LAB4_Q2.c,114 :: 		E2 = 1;
	BSET.B	LATBbits, #3
;LAB4_Q2.c,115 :: 		D1 = 1;
	BSET.B	LATBbits, #4
;LAB4_Q2.c,116 :: 		D2 = 0;
	BCLR.B	LATBbits, #5
;LAB4_Q2.c,117 :: 		send_str("ESQUERDA \r\n");
	MOV	#lo_addr(?lstr2_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,118 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,119 :: 		case 'D':  //direita
L_mudarPWM22:
;LAB4_Q2.c,120 :: 		E1 = 1;
	BSET.B	LATBbits, #2
;LAB4_Q2.c,121 :: 		E2 = 0;
	BCLR.B	LATBbits, #3
;LAB4_Q2.c,122 :: 		D1 = 0;
	BCLR.B	LATBbits, #4
;LAB4_Q2.c,123 :: 		D2 = 1;
	BSET.B	LATBbits, #5
;LAB4_Q2.c,124 :: 		send_str("DIREITA \r\n");
	MOV	#lo_addr(?lstr3_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,125 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,126 :: 		case 'A':  //atras
L_mudarPWM23:
;LAB4_Q2.c,127 :: 		D1 = 0;
	BCLR.B	LATBbits, #4
;LAB4_Q2.c,128 :: 		D2 = 1;
	BSET.B	LATBbits, #5
;LAB4_Q2.c,129 :: 		E1 = 0;
	BCLR.B	LATBbits, #2
;LAB4_Q2.c,130 :: 		E2 = 1;
	BSET.B	LATBbits, #3
;LAB4_Q2.c,131 :: 		send_str("ATRAS \r\n");
	MOV	#lo_addr(?lstr4_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,132 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,133 :: 		case 'P':  //acelera
L_mudarPWM24:
;LAB4_Q2.c,135 :: 		duty = duty + 10;
	MOV	#10, W1
	MOV	#lo_addr(_duty), W0
	ADD	W1, [W0], [W0]
;LAB4_Q2.c,136 :: 		aux3 = PWMd + aux2;
	MOV	OC1RS, W1
	MOV	#lo_addr(_aux2), W0
	ADD	W1, [W0], W1
	MOV	W1, _aux3
;LAB4_Q2.c,137 :: 		if (aux3 <= periodo){
	MOV	#20000, W0
	CP	W1, W0
	BRA LE	L__mudarPWM64
	GOTO	L_mudarPWM25
L__mudarPWM64:
;LAB4_Q2.c,138 :: 		PWMd += aux2;
	MOV	_aux2, W1
	MOV	#lo_addr(OC1RS), W0
	ADD	W1, [W0], [W0]
;LAB4_Q2.c,139 :: 		}else{
	GOTO	L_mudarPWM26
L_mudarPWM25:
;LAB4_Q2.c,140 :: 		PWMd = periodo;
	MOV	#20000, W0
	MOV	WREG, OC1RS
;LAB4_Q2.c,141 :: 		duty = 100;
	MOV	#100, W0
	MOV	W0, _duty
;LAB4_Q2.c,142 :: 		}
L_mudarPWM26:
;LAB4_Q2.c,143 :: 		aux3 = PWMe + aux2;
	MOV	OC3RS, W1
	MOV	#lo_addr(_aux2), W0
	ADD	W1, [W0], W1
	MOV	W1, _aux3
;LAB4_Q2.c,144 :: 		if (aux3 <= periodo){
	MOV	#20000, W0
	CP	W1, W0
	BRA LE	L__mudarPWM65
	GOTO	L_mudarPWM27
L__mudarPWM65:
;LAB4_Q2.c,145 :: 		PWMe += aux2;
	MOV	_aux2, W1
	MOV	#lo_addr(OC3RS), W0
	ADD	W1, [W0], [W0]
;LAB4_Q2.c,146 :: 		}else{
	GOTO	L_mudarPWM28
L_mudarPWM27:
;LAB4_Q2.c,147 :: 		PWMe = periodo;
	MOV	#20000, W0
	MOV	WREG, OC3RS
;LAB4_Q2.c,148 :: 		duty = 100;
	MOV	#100, W0
	MOV	W0, _duty
;LAB4_Q2.c,149 :: 		}
L_mudarPWM28:
;LAB4_Q2.c,150 :: 		send_str("DUTY");
	MOV	#lo_addr(?lstr5_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,151 :: 		IntToStr(duty,txt);
	MOV	#lo_addr(_txt), W11
	MOV	_duty, W10
	CALL	_IntToStr
;LAB4_Q2.c,152 :: 		send_str(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_send_str
;LAB4_Q2.c,153 :: 		send_str("\r\n");
	MOV	#lo_addr(?lstr6_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,154 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,155 :: 		case 'L':  //desacelera
L_mudarPWM29:
;LAB4_Q2.c,156 :: 		duty = duty - 10;
	MOV	#10, W1
	MOV	#lo_addr(_duty), W0
	SUBR	W1, [W0], [W0]
;LAB4_Q2.c,157 :: 		aux3 = PWMd - aux2;
	MOV	OC1RS, W1
	MOV	#lo_addr(_aux2), W0
	SUB	W1, [W0], W0
	MOV	W0, _aux3
;LAB4_Q2.c,158 :: 		if(aux3 >= 0){
	CP	W0, #0
	BRA GE	L__mudarPWM66
	GOTO	L_mudarPWM30
L__mudarPWM66:
;LAB4_Q2.c,159 :: 		PWMd -= aux2;
	MOV	_aux2, W1
	MOV	#lo_addr(OC1RS), W0
	SUBR	W1, [W0], [W0]
;LAB4_Q2.c,160 :: 		}else{
	GOTO	L_mudarPWM31
L_mudarPWM30:
;LAB4_Q2.c,161 :: 		PWMd = 0;
	CLR	OC1RS
;LAB4_Q2.c,162 :: 		duty = 0;
	CLR	W0
	MOV	W0, _duty
;LAB4_Q2.c,163 :: 		}
L_mudarPWM31:
;LAB4_Q2.c,165 :: 		aux3 = PWMe - aux2;
	MOV	OC3RS, W1
	MOV	#lo_addr(_aux2), W0
	SUB	W1, [W0], W0
	MOV	W0, _aux3
;LAB4_Q2.c,166 :: 		if(aux3 >= 0){
	CP	W0, #0
	BRA GE	L__mudarPWM67
	GOTO	L_mudarPWM32
L__mudarPWM67:
;LAB4_Q2.c,167 :: 		PWMe -= aux2;
	MOV	_aux2, W1
	MOV	#lo_addr(OC3RS), W0
	SUBR	W1, [W0], [W0]
;LAB4_Q2.c,168 :: 		}else{
	GOTO	L_mudarPWM33
L_mudarPWM32:
;LAB4_Q2.c,169 :: 		PWMe = 0;
	CLR	OC3RS
;LAB4_Q2.c,170 :: 		duty = 0;
	CLR	W0
	MOV	W0, _duty
;LAB4_Q2.c,171 :: 		}
L_mudarPWM33:
;LAB4_Q2.c,172 :: 		send_str("DUTY");
	MOV	#lo_addr(?lstr7_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,173 :: 		IntToStr(duty,txt);
	MOV	#lo_addr(_txt), W11
	MOV	_duty, W10
	CALL	_IntToStr
;LAB4_Q2.c,174 :: 		send_str(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_send_str
;LAB4_Q2.c,175 :: 		send_str("\r\n");
	MOV	#lo_addr(?lstr8_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,176 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,177 :: 		default:
L_mudarPWM34:
;LAB4_Q2.c,178 :: 		break;
	GOTO	L_mudarPWM19
;LAB4_Q2.c,179 :: 		}
L_mudarPWM18:
	MOV.B	#70, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM68
	GOTO	L_mudarPWM20
L__mudarPWM68:
	MOV.B	#69, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM69
	GOTO	L_mudarPWM21
L__mudarPWM69:
	MOV.B	#68, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM70
	GOTO	L_mudarPWM22
L__mudarPWM70:
	MOV.B	#65, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM71
	GOTO	L_mudarPWM23
L__mudarPWM71:
	MOV.B	#80, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM72
	GOTO	L_mudarPWM24
L__mudarPWM72:
	MOV.B	#76, W0
	CP.B	W10, W0
	BRA NZ	L__mudarPWM73
	GOTO	L_mudarPWM29
L__mudarPWM73:
	GOTO	L_mudarPWM34
L_mudarPWM19:
;LAB4_Q2.c,180 :: 		}
L_end_mudarPWM:
	POP	W11
	POP	W10
	RETURN
; end of _mudarPWM

_msg:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;LAB4_Q2.c,185 :: 		void msg() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;LAB4_Q2.c,187 :: 		if (m == 'F')
	PUSH	W10
	PUSH	W11
	MOV	#lo_addr(_m), W0
	MOV.B	[W0], W1
	MOV.B	#70, W0
	CP.B	W1, W0
	BRA Z	L__msg75
	GOTO	L_msg35
L__msg75:
;LAB4_Q2.c,188 :: 		send_str("FRENTE ");
	MOV	#lo_addr(?lstr9_LAB4_Q2), W10
	CALL	_send_str
L_msg35:
;LAB4_Q2.c,189 :: 		if (m == 'A')
	MOV	#lo_addr(_m), W0
	MOV.B	[W0], W1
	MOV.B	#65, W0
	CP.B	W1, W0
	BRA Z	L__msg76
	GOTO	L_msg36
L__msg76:
;LAB4_Q2.c,190 :: 		send_str("ATRAS ");
	MOV	#lo_addr(?lstr10_LAB4_Q2), W10
	CALL	_send_str
L_msg36:
;LAB4_Q2.c,191 :: 		if (m == 'D')
	MOV	#lo_addr(_m), W0
	MOV.B	[W0], W1
	MOV.B	#68, W0
	CP.B	W1, W0
	BRA Z	L__msg77
	GOTO	L_msg37
L__msg77:
;LAB4_Q2.c,192 :: 		send_str("DIREITA ");
	MOV	#lo_addr(?lstr11_LAB4_Q2), W10
	CALL	_send_str
L_msg37:
;LAB4_Q2.c,193 :: 		if (m == 'E')
	MOV	#lo_addr(_m), W0
	MOV.B	[W0], W1
	MOV.B	#69, W0
	CP.B	W1, W0
	BRA Z	L__msg78
	GOTO	L_msg38
L__msg78:
;LAB4_Q2.c,194 :: 		send_str("ESQUERDA ");
	MOV	#lo_addr(?lstr12_LAB4_Q2), W10
	CALL	_send_str
L_msg38:
;LAB4_Q2.c,195 :: 		send_str("DUTY");
	MOV	#lo_addr(?lstr13_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,196 :: 		IntToStr(duty,txt);
	MOV	#lo_addr(_txt), W11
	MOV	_duty, W10
	CALL	_IntToStr
;LAB4_Q2.c,197 :: 		send_str(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_send_str
;LAB4_Q2.c,198 :: 		send_str("\r\n");
	MOV	#lo_addr(?lstr14_LAB4_Q2), W10
	CALL	_send_str
;LAB4_Q2.c,199 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;LAB4_Q2.c,200 :: 		}
L_end_msg:
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _msg

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB4_Q2.c,205 :: 		void main(){
;LAB4_Q2.c,206 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB4_Q2.c,207 :: 		TRISB = 0;
	CLR	TRISB
;LAB4_Q2.c,208 :: 		LATB = 0;
	CLR	LATB
;LAB4_Q2.c,209 :: 		PWMd = 0;
	CLR	OC1RS
;LAB4_Q2.c,210 :: 		OC1CON = 0x0006;
	MOV	#6, W0
	MOV	WREG, OC1CON
;LAB4_Q2.c,211 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;LAB4_Q2.c,213 :: 		PWMe = 0;
	CLR	OC3RS
;LAB4_Q2.c,214 :: 		OC3CON = 0x0006;
	MOV	#6, W0
	MOV	WREG, OC3CON
;LAB4_Q2.c,216 :: 		PR2 = periodo;
	MOV	#20000, W0
	MOV	WREG, PR2
;LAB4_Q2.c,217 :: 		T2CON = 0x8010;
	MOV	#32784, W0
	MOV	WREG, T2CON
;LAB4_Q2.c,219 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;LAB4_Q2.c,220 :: 		PR1 = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, PR1
;LAB4_Q2.c,221 :: 		T1CON = 0x8030;
	MOV	#32816, W0
	MOV	WREG, T1CON
;LAB4_Q2.c,222 :: 		TMR1 = 0;
	CLR	TMR1
;LAB4_Q2.c,224 :: 		IFS0 = 0;
	CLR	IFS0
;LAB4_Q2.c,226 :: 		INIT_UART2(51);
	MOV.B	#51, W10
	CALL	_INIT_UART2
;LAB4_Q2.c,227 :: 		send_char(0x030);
	MOV.B	#48, W10
	CALL	_send_char
;LAB4_Q2.c,228 :: 		LATBbits.LATB1 = 0;
	BCLR.B	LATBbits, #1
;LAB4_Q2.c,230 :: 		while(1){
L_main39:
;LAB4_Q2.c,231 :: 		if(flag_criatividade == 0){
	MOV	_flag_criatividade, W0
	CP	W0, #0
	BRA Z	L__main80
	GOTO	L_main41
L__main80:
;LAB4_Q2.c,232 :: 		Delay_ms(100);
	MOV	#9, W8
	MOV	#9047, W7
L_main42:
	DEC	W7
	BRA NZ	L_main42
	DEC	W8
	BRA NZ	L_main42
;LAB4_Q2.c,233 :: 		m = receive_char();
	CALL	_receive_char
	MOV	#lo_addr(_m), W1
	MOV.B	W0, [W1]
;LAB4_Q2.c,234 :: 		mudarPWM(m);
	MOV.B	W0, W10
	CALL	_mudarPWM
;LAB4_Q2.c,235 :: 		}else{
	GOTO	L_main44
L_main41:
;LAB4_Q2.c,236 :: 		j = 0;
	CLR	W0
	MOV	W0, _j
;LAB4_Q2.c,237 :: 		LATBbits.LATB1 = 1;
	BSET.B	LATBbits, #1
;LAB4_Q2.c,238 :: 		receive_str();
	CALL	_receive_str
;LAB4_Q2.c,239 :: 		while(criatividade[j] != '\0'){
L_main45:
	MOV	#lo_addr(_criatividade), W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	CP.B	W0, #0
	BRA NZ	L__main81
	GOTO	L_main46
L__main81:
;LAB4_Q2.c,240 :: 		pepe = criatividade[j];
	MOV	#lo_addr(_criatividade), W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W1
	MOV	#lo_addr(_pepe), W0
	MOV.B	W1, [W0]
;LAB4_Q2.c,241 :: 		mudarPWM(pepe);
	MOV.B	W1, W10
	CALL	_mudarPWM
;LAB4_Q2.c,242 :: 		j++;
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], [W0]
;LAB4_Q2.c,243 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main47:
	DEC	W7
	BRA NZ	L_main47
	DEC	W8
	BRA NZ	L_main47
;LAB4_Q2.c,244 :: 		}
	GOTO	L_main45
L_main46:
;LAB4_Q2.c,245 :: 		}
L_main44:
;LAB4_Q2.c,246 :: 		}
	GOTO	L_main39
;LAB4_Q2.c,247 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
