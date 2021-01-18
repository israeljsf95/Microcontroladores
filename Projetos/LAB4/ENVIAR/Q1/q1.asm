
_tempo:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q1.c,21 :: 		void tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
;q1.c,22 :: 		IFS0bits.T1IF = 0;
	BCLR.B	IFS0bits, #3
;q1.c,23 :: 		if (estado == 6 || estado == 7 || estado == 8)
	MOV	_estado, W0
	CP	W0, #6
	BRA NZ	L__tempo71
	GOTO	L__tempo65
L__tempo71:
	MOV	_estado, W0
	CP	W0, #7
	BRA NZ	L__tempo72
	GOTO	L__tempo64
L__tempo72:
	MOV	_estado, W0
	CP	W0, #8
	BRA NZ	L__tempo73
	GOTO	L__tempo63
L__tempo73:
	GOTO	L_tempo2
L__tempo65:
L__tempo64:
L__tempo63:
;q1.c,24 :: 		LATB = ~LATB;
	COM	LATB
L_tempo2:
;q1.c,25 :: 		if (estado == 9 || estado == 10){
	MOV	_estado, W0
	CP	W0, #9
	BRA NZ	L__tempo74
	GOTO	L__tempo67
L__tempo74:
	MOV	_estado, W0
	CP	W0, #10
	BRA NZ	L__tempo75
	GOTO	L__tempo66
L__tempo75:
	GOTO	L_tempo5
L__tempo67:
L__tempo66:
;q1.c,26 :: 		if (var <= 225){
	MOV	#225, W1
	MOV	#lo_addr(_var), W0
	CP	W1, [W0]
	BRA GE	L__tempo76
	GOTO	L_tempo6
L__tempo76:
;q1.c,27 :: 		var = var + step;
	MOV	_step, W1
	MOV	#lo_addr(_var), W0
	ADD	W1, [W0], [W0]
;q1.c,28 :: 		}else{
	GOTO	L_tempo7
L_tempo6:
;q1.c,29 :: 		var = 0;
	CLR	W0
	MOV	W0, _var
;q1.c,30 :: 		}
L_tempo7:
;q1.c,31 :: 		}
L_tempo5:
;q1.c,32 :: 		}
L_end_tempo:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _tempo

_tempo2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q1.c,36 :: 		void tempo2() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
;q1.c,37 :: 		IFS0bits.T2IF = 0;
	BCLR.B	IFS0bits, #6
;q1.c,38 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;q1.c,39 :: 		if(cont == 250){
	MOV	#250, W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA Z	L__tempo278
	GOTO	L_tempo28
L__tempo278:
;q1.c,40 :: 		LATB = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, LATB
;q1.c,41 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;q1.c,42 :: 		}
L_tempo28:
;q1.c,43 :: 		if(cont == var)
	MOV	_cont, W1
	MOV	#lo_addr(_var), W0
	CP	W1, [W0]
	BRA Z	L__tempo279
	GOTO	L_tempo29
L__tempo279:
;q1.c,44 :: 		LATB = 0;
	CLR	LATB
L_tempo29:
;q1.c,46 :: 		}
L_end_tempo2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _tempo2

_INIT_UART2:

;q1.c,49 :: 		void INIT_UART2(unsigned char valor_baud){
;q1.c,50 :: 		U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;q1.c,51 :: 		U2MODE = 0x0000; //ver tabela para saber as outras configura??es
	CLR	U2MODE
;q1.c,52 :: 		U2STA = 0x0000;
	CLR	U2STA
;q1.c,53 :: 		IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;q1.c,54 :: 		IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;q1.c,55 :: 		IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;q1.c,56 :: 		IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;q1.c,57 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;q1.c,58 :: 		U2STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U2STAbits, #10
;q1.c,59 :: 		}
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

;q1.c,62 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
;q1.c,63 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;q1.c,64 :: 		}
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

;q1.c,67 :: 		void send_char(unsigned char c){
;q1.c,68 :: 		while( U2STAbits.UTXBF);
L_send_char10:
	BTSS	U2STAbits, #9
	GOTO	L_send_char11
	GOTO	L_send_char10
L_send_char11:
;q1.c,69 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;q1.c,70 :: 		}
L_end_send_char:
	RETURN
; end of _send_char

_send_str:

;q1.c,73 :: 		void send_str(unsigned char* str){
;q1.c,74 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;q1.c,75 :: 		while(str[i])
L_send_str12:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str84
	GOTO	L_send_str13
L__send_str84:
;q1.c,76 :: 		send_char(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str12
L_send_str13:
;q1.c,77 :: 		}
L_end_send_str:
	RETURN
; end of _send_str

_receive_char:

;q1.c,79 :: 		char receive_char(){
;q1.c,81 :: 		while(!U2STAbits.URXDA);
L_receive_char14:
	BTSC	U2STAbits, #0
	GOTO	L_receive_char15
	GOTO	L_receive_char14
L_receive_char15:
;q1.c,82 :: 		c = U2RXREG; // escreve caractere
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;q1.c,83 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;q1.c,84 :: 		}
L_end_receive_char:
	RETURN
; end of _receive_char

_receive_str:

;q1.c,86 :: 		void receive_str(){
;q1.c,87 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;q1.c,89 :: 		do{
	GOTO	L_receive_str16
L__receive_str68:
;q1.c,93 :: 		}while(c != 0x0A);
;q1.c,89 :: 		do{
L_receive_str16:
;q1.c,90 :: 		c = receive_char();
; i start address is: 6 (W3)
	CALL	_receive_char
; c start address is: 4 (W2)
	MOV.B	W0, W2
;q1.c,91 :: 		str[i] = c;
	MOV	#lo_addr(_str), W1
	ADD	W1, W3, W1
	MOV.B	W0, [W1]
;q1.c,92 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;q1.c,93 :: 		}while(c != 0x0A);
	CP.B	W2, #10
	BRA Z	L__receive_str87
	GOTO	L__receive_str68
L__receive_str87:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;q1.c,94 :: 		str[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W1
; i end address is: 6 (W3)
	MOV	#lo_addr(_str), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV.B	W0, [W1]
;q1.c,95 :: 		}
L_end_receive_str:
	RETURN
; end of _receive_str

_check:

;q1.c,99 :: 		void check(char* str1){
;q1.c,100 :: 		flag = strcmp(str, str1);
	PUSH	W10
	PUSH	W11
	MOV	W10, W11
	MOV	#lo_addr(_str), W10
	CALL	_strcmp
	MOV	W0, _flag
;q1.c,101 :: 		if(flag == 0){
	CP	W0, #0
	BRA Z	L__check89
	GOTO	L_check19
L__check89:
;q1.c,102 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,103 :: 		}else{
	GOTO	L_check20
L_check19:
;q1.c,104 :: 		send_str("Não entendi, Repita por favor\n\r");
	MOV	#lo_addr(?lstr1_q1), W10
	CALL	_send_str
;q1.c,105 :: 		}
L_check20:
;q1.c,106 :: 		}
L_end_check:
	POP	W11
	POP	W10
	RETURN
; end of _check

_conversa:

;q1.c,108 :: 		void conversa(){
;q1.c,109 :: 		switch(estado){
	PUSH	W10
	GOTO	L_conversa21
;q1.c,110 :: 		case 0:
L_conversa23:
;q1.c,111 :: 		receive_str();
	CALL	_receive_str
;q1.c,112 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,113 :: 		break;
	GOTO	L_conversa22
;q1.c,114 :: 		case 1:
L_conversa24:
;q1.c,115 :: 		send_str(mC[0]); //uC:envia oi pC
	MOV	#lo_addr(_mC), W10
	CALL	_send_str
;q1.c,116 :: 		send_str("\n\r");
	MOV	#lo_addr(?lstr2_q1), W10
	CALL	_send_str
;q1.c,117 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,118 :: 		break;
	GOTO	L_conversa22
;q1.c,119 :: 		case 2:            //Pc:Tudo bem
L_conversa25:
;q1.c,120 :: 		receive_str();
	CALL	_receive_str
;q1.c,121 :: 		check(pC[0]);
	MOV	#lo_addr(_pC), W10
	CALL	_check
;q1.c,122 :: 		break;
	GOTO	L_conversa22
;q1.c,123 :: 		case 3:
L_conversa26:
;q1.c,124 :: 		send_str(mC[1]);//digite leds
	MOV	#lo_addr(_mC+80), W10
	CALL	_send_str
;q1.c,125 :: 		send_str("\n\r");
	MOV	#lo_addr(?lstr3_q1), W10
	CALL	_send_str
;q1.c,126 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,127 :: 		break;
	GOTO	L_conversa22
;q1.c,128 :: 		case 4:
L_conversa27:
;q1.c,129 :: 		receive_str();  //ta bom
	CALL	_receive_str
;q1.c,130 :: 		check(pC[1]);
	MOV	#lo_addr(_pC+20), W10
	CALL	_check
;q1.c,131 :: 		break;
	GOTO	L_conversa22
;q1.c,132 :: 		case 5:              //leds
L_conversa28:
;q1.c,133 :: 		receive_str();
	CALL	_receive_str
;q1.c,134 :: 		check(pC[2]);
	MOV	#lo_addr(_pC+40), W10
	CALL	_check
;q1.c,135 :: 		break;
	GOTO	L_conversa22
;q1.c,136 :: 		case 6:
L_conversa29:
;q1.c,137 :: 		T1CONbits.TON = 1;
	BSET	T1CONbits, #15
;q1.c,138 :: 		send_str(mC[2]); //digite pwm
	MOV	#lo_addr(_mC+160), W10
	CALL	_send_str
;q1.c,139 :: 		send_str("\n\r");
	MOV	#lo_addr(?lstr4_q1), W10
	CALL	_send_str
;q1.c,140 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,141 :: 		break;
	GOTO	L_conversa22
;q1.c,142 :: 		case 7:
L_conversa30:
;q1.c,143 :: 		receive_str();    //sem problema
	CALL	_receive_str
;q1.c,144 :: 		check(pC[3]);
	MOV	#lo_addr(_pC+60), W10
	CALL	_check
;q1.c,145 :: 		break;
	GOTO	L_conversa22
;q1.c,146 :: 		case 8:
L_conversa31:
;q1.c,147 :: 		receive_str();    //pwm
	CALL	_receive_str
;q1.c,148 :: 		check(pC[4]);
	MOV	#lo_addr(_pC+80), W10
	CALL	_check
;q1.c,149 :: 		break;
	GOTO	L_conversa22
;q1.c,150 :: 		case 9:
L_conversa32:
;q1.c,151 :: 		var = 0;
	CLR	W0
	MOV	W0, _var
;q1.c,152 :: 		T2CONbits.TON = 1;
	BSET	T2CONbits, #15
;q1.c,153 :: 		send_str(mC[3]); //digite parar
	MOV	#lo_addr(_mC+240), W10
	CALL	_send_str
;q1.c,154 :: 		send_str("\n\r");
	MOV	#lo_addr(?lstr5_q1), W10
	CALL	_send_str
;q1.c,155 :: 		estado++;
	MOV	#1, W1
	MOV	#lo_addr(_estado), W0
	ADD	W1, [W0], [W0]
;q1.c,156 :: 		break;
	GOTO	L_conversa22
;q1.c,157 :: 		case 10:
L_conversa33:
;q1.c,158 :: 		receive_str();   //parar
	CALL	_receive_str
;q1.c,159 :: 		check(pC[5]);
	MOV	#lo_addr(_pC+100), W10
	CALL	_check
;q1.c,160 :: 		break;
	GOTO	L_conversa22
;q1.c,161 :: 		default:
L_conversa34:
;q1.c,162 :: 		LATDbits.LATD3 = 1;
	BSET.B	LATDbits, #3
;q1.c,163 :: 		T1CONbits.TON = 0;
	BCLR	T1CONbits, #15
;q1.c,164 :: 		T2CONbits.TON = 0;
	BCLR	T2CONbits, #15
;q1.c,165 :: 		estado = 1;
	MOV	#1, W0
	MOV	W0, _estado
;q1.c,166 :: 		LATB = 0;
	CLR	LATB
;q1.c,167 :: 		Delay_ms(3000);
	MOV	#39, W8
	MOV	#9643, W7
L_conversa35:
	DEC	W7
	BRA NZ	L_conversa35
	DEC	W8
	BRA NZ	L_conversa35
	NOP
	NOP
;q1.c,168 :: 		LATDbits.LATD3 = 0;
	BCLR.B	LATDbits, #3
;q1.c,169 :: 		break;
	GOTO	L_conversa22
;q1.c,170 :: 		}
L_conversa21:
	MOV	_estado, W0
	CP	W0, #0
	BRA NZ	L__conversa91
	GOTO	L_conversa23
L__conversa91:
	MOV	_estado, W0
	CP	W0, #1
	BRA NZ	L__conversa92
	GOTO	L_conversa24
L__conversa92:
	MOV	_estado, W0
	CP	W0, #2
	BRA NZ	L__conversa93
	GOTO	L_conversa25
L__conversa93:
	MOV	_estado, W0
	CP	W0, #3
	BRA NZ	L__conversa94
	GOTO	L_conversa26
L__conversa94:
	MOV	_estado, W0
	CP	W0, #4
	BRA NZ	L__conversa95
	GOTO	L_conversa27
L__conversa95:
	MOV	_estado, W0
	CP	W0, #5
	BRA NZ	L__conversa96
	GOTO	L_conversa28
L__conversa96:
	MOV	_estado, W0
	CP	W0, #6
	BRA NZ	L__conversa97
	GOTO	L_conversa29
L__conversa97:
	MOV	_estado, W0
	CP	W0, #7
	BRA NZ	L__conversa98
	GOTO	L_conversa30
L__conversa98:
	MOV	_estado, W0
	CP	W0, #8
	BRA NZ	L__conversa99
	GOTO	L_conversa31
L__conversa99:
	MOV	_estado, W0
	CP	W0, #9
	BRA NZ	L__conversa100
	GOTO	L_conversa32
L__conversa100:
	MOV	_estado, W0
	CP	W0, #10
	BRA NZ	L__conversa101
	GOTO	L_conversa33
L__conversa101:
	GOTO	L_conversa34
L_conversa22:
;q1.c,172 :: 		}
L_end_conversa:
	POP	W10
	RETURN
; end of _conversa

_botaozinho:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;q1.c,190 :: 		void botaozinho() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
;q1.c,191 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;q1.c,192 :: 		if (botao == 0){
	MOV	_botao, W0
	CP	W0, #0
	BRA Z	L__botaozinho103
	GOTO	L_botaozinho37
L__botaozinho103:
;q1.c,193 :: 		botao = 1;
	MOV	#1, W0
	MOV	W0, _botao
;q1.c,194 :: 		LATBbits.LATB0 = 1;
	BSET.B	LATBbits, #0
;q1.c,195 :: 		}else{
	GOTO	L_botaozinho38
L_botaozinho37:
;q1.c,196 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;q1.c,197 :: 		botao = 0;
	CLR	W0
	MOV	W0, _botao
;q1.c,198 :: 		}
L_botaozinho38:
;q1.c,199 :: 		}
L_end_botaozinho:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _botaozinho

_receive_criat:

;q1.c,202 :: 		void receive_criat(char* stri){
;q1.c,203 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;q1.c,205 :: 		do{
	GOTO	L_receive_criat39
L__receive_criat69:
;q1.c,209 :: 		}while(c != 0x0A);
;q1.c,205 :: 		do{
L_receive_criat39:
;q1.c,206 :: 		c = receive_char();
; i start address is: 6 (W3)
	CALL	_receive_char
; c start address is: 4 (W2)
	MOV.B	W0, W2
;q1.c,207 :: 		stri[i] = c;
	ADD	W10, W3, W1
	MOV.B	W0, [W1]
;q1.c,208 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;q1.c,209 :: 		}while(c != 0x0A);
	CP.B	W2, #10
	BRA Z	L__receive_criat105
	GOTO	L__receive_criat69
L__receive_criat105:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;q1.c,210 :: 		stri[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W0
; i end address is: 6 (W3)
	ADD	W10, W0, W1
	CLR	W0
	MOV.B	W0, [W1]
;q1.c,211 :: 		}
L_end_receive_criat:
	RETURN
; end of _receive_criat

_criatividade:

;q1.c,217 :: 		void criatividade(){
;q1.c,218 :: 		switch(estado_criatividade){
	PUSH	W10
	PUSH	W11
	GOTO	L_criatividade42
;q1.c,219 :: 		case 0:
L_criatividade44:
;q1.c,220 :: 		receive_criat(str_criat);
	MOV	#lo_addr(_str_criat), W10
	CALL	_receive_criat
;q1.c,221 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,222 :: 		break;
	GOTO	L_criatividade43
;q1.c,223 :: 		case 1:
L_criatividade45:
;q1.c,224 :: 		send_str(perguntas[0]);
	MOV	#lo_addr(_perguntas), W10
	CALL	_send_str
;q1.c,225 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,226 :: 		break;
	GOTO	L_criatividade43
;q1.c,227 :: 		case 2:
L_criatividade46:
;q1.c,228 :: 		receive_criat(str_criat);
	MOV	#lo_addr(_str_criat), W10
	CALL	_receive_criat
;q1.c,229 :: 		flag_criat = strcmp(respostas[0],str_criat);
	MOV	#lo_addr(_str_criat), W11
	MOV	#lo_addr(_respostas), W10
	CALL	_strcmp
	MOV	W0, _flag_criat
;q1.c,230 :: 		if (flag_criat == 0){
	CP	W0, #0
	BRA Z	L__criatividade107
	GOTO	L_criatividade47
L__criatividade107:
;q1.c,231 :: 		send_str(mensagens[0]);
	MOV	#lo_addr(_mensagens), W10
	CALL	_send_str
;q1.c,232 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,233 :: 		}else{
	GOTO	L_criatividade48
L_criatividade47:
;q1.c,234 :: 		send_str(mensagens[1]);
	MOV	#lo_addr(_mensagens+39), W10
	CALL	_send_str
;q1.c,235 :: 		numero_tentativas--;
	MOV	#1, W1
	MOV	#lo_addr(_numero_tentativas), W0
	SUBR	W1, [W0], [W0]
;q1.c,236 :: 		}
L_criatividade48:
;q1.c,237 :: 		break;
	GOTO	L_criatividade43
;q1.c,238 :: 		case 3:
L_criatividade49:
;q1.c,239 :: 		send_str(perguntas[1]);
	MOV	#lo_addr(_perguntas+25), W10
	CALL	_send_str
;q1.c,240 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,241 :: 		break;
	GOTO	L_criatividade43
;q1.c,242 :: 		case 4:
L_criatividade50:
;q1.c,243 :: 		receive_criat(str_criat);
	MOV	#lo_addr(_str_criat), W10
	CALL	_receive_criat
;q1.c,244 :: 		flag_criat = strcmp(respostas[1],str_criat);
	MOV	#lo_addr(_str_criat), W11
	MOV	#lo_addr(_respostas+15), W10
	CALL	_strcmp
	MOV	W0, _flag_criat
;q1.c,245 :: 		if (flag_criat == 0){
	CP	W0, #0
	BRA Z	L__criatividade108
	GOTO	L_criatividade51
L__criatividade108:
;q1.c,246 :: 		send_str(mensagens[2]);
	MOV	#lo_addr(_mensagens+78), W10
	CALL	_send_str
;q1.c,247 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,248 :: 		}else{
	GOTO	L_criatividade52
L_criatividade51:
;q1.c,249 :: 		send_str(mensagens[3]);
	MOV	#lo_addr(_mensagens+117), W10
	CALL	_send_str
;q1.c,250 :: 		numero_tentativas--;
	MOV	#1, W1
	MOV	#lo_addr(_numero_tentativas), W0
	SUBR	W1, [W0], [W0]
;q1.c,251 :: 		}
L_criatividade52:
;q1.c,252 :: 		break;
	GOTO	L_criatividade43
;q1.c,253 :: 		case 5:
L_criatividade53:
;q1.c,254 :: 		send_str("Acesso liberado\r\n");
	MOV	#lo_addr(?lstr6_q1), W10
	CALL	_send_str
;q1.c,255 :: 		numero_tentativas = 2;
	MOV	#2, W0
	MOV	W0, _numero_tentativas
;q1.c,256 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;q1.c,257 :: 		botao = 0;
	CLR	W0
	MOV	W0, _botao
;q1.c,258 :: 		estado_criatividade++;
	MOV	#1, W1
	MOV	#lo_addr(_estado_criatividade), W0
	ADD	W1, [W0], [W0]
;q1.c,259 :: 		break;
	GOTO	L_criatividade43
;q1.c,260 :: 		default:
L_criatividade54:
;q1.c,261 :: 		estado_criatividade = 0;
	CLR	W0
	MOV	W0, _estado_criatividade
;q1.c,262 :: 		break;
	GOTO	L_criatividade43
;q1.c,263 :: 		}
L_criatividade42:
	MOV	_estado_criatividade, W0
	CP	W0, #0
	BRA NZ	L__criatividade109
	GOTO	L_criatividade44
L__criatividade109:
	MOV	_estado_criatividade, W0
	CP	W0, #1
	BRA NZ	L__criatividade110
	GOTO	L_criatividade45
L__criatividade110:
	MOV	_estado_criatividade, W0
	CP	W0, #2
	BRA NZ	L__criatividade111
	GOTO	L_criatividade46
L__criatividade111:
	MOV	_estado_criatividade, W0
	CP	W0, #3
	BRA NZ	L__criatividade112
	GOTO	L_criatividade49
L__criatividade112:
	MOV	_estado_criatividade, W0
	CP	W0, #4
	BRA NZ	L__criatividade113
	GOTO	L_criatividade50
L__criatividade113:
	MOV	_estado_criatividade, W0
	CP	W0, #5
	BRA NZ	L__criatividade114
	GOTO	L_criatividade53
L__criatividade114:
	GOTO	L_criatividade54
L_criatividade43:
;q1.c,264 :: 		}
L_end_criatividade:
	POP	W11
	POP	W10
	RETURN
; end of _criatividade

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;q1.c,268 :: 		void main() {
;q1.c,270 :: 		INIT_UART2(103);
	PUSH	W10
	MOV.B	#103, W10
	CALL	_INIT_UART2
;q1.c,271 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;q1.c,273 :: 		TRISB = 0;
	CLR	TRISB
;q1.c,274 :: 		TRISD = 0;
	CLR	TRISD
;q1.c,275 :: 		LATD = 0;
	CLR	LATD
;q1.c,276 :: 		LATB = 0;
	CLR	LATB
;q1.c,277 :: 		IEC0 = 0;
	CLR	IEC0
;q1.c,279 :: 		IEC0bits.T1IE = 1;
	BSET.B	IEC0bits, #3
;q1.c,280 :: 		IEC0bits.T2IE = 1;
	BSET.B	IEC0bits, #6
;q1.c,282 :: 		T1CON = 0x0030;
	MOV	#48, W0
	MOV	WREG, T1CON
;q1.c,283 :: 		PR1 = 64000;
	MOV	#64000, W0
	MOV	WREG, PR1
;q1.c,285 :: 		T2CON = 0x0010;
	MOV	#16, W0
	MOV	WREG, T2CON
;q1.c,286 :: 		PR2 = 250;
	MOV	#250, W0
	MOV	WREG, PR2
;q1.c,288 :: 		IEC0bits.INT0IE = 1;
	BSET.B	IEC0bits, #0
;q1.c,289 :: 		while(1){
L_main55:
;q1.c,290 :: 		if (botao == 0){
	MOV	_botao, W0
	CP	W0, #0
	BRA Z	L__main116
	GOTO	L_main57
L__main116:
;q1.c,291 :: 		conversa();
	CALL	_conversa
;q1.c,292 :: 		estado_criatividade = 0;
	CLR	W0
	MOV	W0, _estado_criatividade
;q1.c,293 :: 		}else{
	GOTO	L_main58
L_main57:
;q1.c,294 :: 		if (numero_tentativas > 0){
	MOV	_numero_tentativas, W0
	CP	W0, #0
	BRA GT	L__main117
	GOTO	L_main59
L__main117:
;q1.c,295 :: 		criatividade();
	CALL	_criatividade
;q1.c,296 :: 		}else{
	GOTO	L_main60
L_main59:
;q1.c,297 :: 		send_str("BLOQUEIO TOTAL\r\n");
	MOV	#lo_addr(?lstr7_q1), W10
	CALL	_send_str
;q1.c,298 :: 		botao = 0;
	CLR	W0
	MOV	W0, _botao
;q1.c,299 :: 		LATBbits.LATB0 = 0;
	BCLR.B	LATBbits, #0
;q1.c,300 :: 		estado_criatividade = 0;
	CLR	W0
	MOV	W0, _estado_criatividade
;q1.c,301 :: 		numero_tentativas = 2;
	MOV	#2, W0
	MOV	W0, _numero_tentativas
;q1.c,302 :: 		}
L_main60:
;q1.c,303 :: 		estado = 0;
	CLR	W0
	MOV	W0, _estado
;q1.c,304 :: 		}
L_main58:
;q1.c,305 :: 		}
	GOTO	L_main55
;q1.c,306 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
