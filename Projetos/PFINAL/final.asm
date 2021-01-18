
_Init_UART1:

;final.c,7 :: 		void Init_UART1(unsigned char valor_baud)
;final.c,9 :: 		U1BRG = valor_baud; //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U1BRG
;final.c,10 :: 		U1MODE = 0x0000;    //ver tabela para saber as outras configura??es
	CLR	U1MODE
;final.c,11 :: 		U1MODEbits.ALTIO = 1;
	BSET	U1MODEbits, #10
;final.c,12 :: 		U1STA = 0x0000;
	CLR	U1STA
;final.c,13 :: 		IFS0bits.U1TXIF = 0;   //Zera a flag de interrupcao de Tx
	BCLR	IFS0bits, #10
;final.c,14 :: 		IEC0bits.U1TXIE = 0;   //Desabilita a interrupcao de Tx
	BCLR	IEC0bits, #10
;final.c,15 :: 		IFS0bits.U1RXIF = 0;   //Zera a flag de de interrupcao de Rx
	BCLR	IFS0bits, #9
;final.c,16 :: 		IEC0bits.U1RXIE = 0;   //Desabilita a flag de interrupcao de Rx
	BCLR	IEC0bits, #9
;final.c,17 :: 		U1MODEbits.UARTEN = 1; //Liga a UART
	BSET	U1MODEbits, #15
;final.c,18 :: 		U1STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U1STAbits, #10
;final.c,19 :: 		}
L_end_Init_UART1:
	RETURN
; end of _Init_UART1

_Tx_serial1:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;final.c,22 :: 		void Tx_serial1() iv IVT_ADDR_U1TXINTERRUPT
;final.c,24 :: 		IFS0bits.U1TXIF = 0;
	BCLR	IFS0bits, #10
;final.c,25 :: 		}
L_end_Tx_serial1:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial1

_send_char1:

;final.c,28 :: 		void send_char1(unsigned char c)
;final.c,30 :: 		while (U1STAbits.UTXBF);
L_send_char10:
	BTSS	U1STAbits, #9
	GOTO	L_send_char11
	GOTO	L_send_char10
L_send_char11:
;final.c,31 :: 		U1TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U1TXREG
;final.c,32 :: 		}
L_end_send_char1:
	RETURN
; end of _send_char1

_send_str1:

;final.c,35 :: 		void send_str1(unsigned char *str)
;final.c,37 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;final.c,38 :: 		while (str[i])
L_send_str12:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str130
	GOTO	L_send_str13
L__send_str130:
;final.c,39 :: 		send_char1(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char1
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str12
L_send_str13:
;final.c,40 :: 		}
L_end_send_str1:
	RETURN
; end of _send_str1

_receive_char1:

;final.c,43 :: 		char receive_char1(){
;final.c,45 :: 		while(!U1STAbits.URXDA);
L_receive_char14:
	BTSC	U1STAbits, #0
	GOTO	L_receive_char15
	GOTO	L_receive_char14
L_receive_char15:
;final.c,46 :: 		c = U1RXREG; // escreve caractere
; c start address is: 2 (W1)
	MOV	U1RXREG, W1
;final.c,47 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;final.c,48 :: 		}
L_end_receive_char1:
	RETURN
; end of _receive_char1

_receive_str1:

;final.c,51 :: 		void receive_str1(){
;final.c,52 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;final.c,54 :: 		do{
	GOTO	L_receive_str16
L__receive_str124:
;final.c,58 :: 		}while(c != 0x69);
;final.c,54 :: 		do{
L_receive_str16:
;final.c,55 :: 		c = receive_char1();
; i start address is: 6 (W3)
	CALL	_receive_char1
; c start address is: 4 (W2)
	MOV.B	W0, W2
;final.c,56 :: 		str1[i] = c;
	MOV	#lo_addr(_str1), W1
	ADD	W1, W3, W1
	MOV.B	W0, [W1]
;final.c,57 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;final.c,58 :: 		}while(c != 0x69);
	MOV.B	#105, W0
	CP.B	W2, W0
	BRA Z	L__receive_str133
	GOTO	L__receive_str124
L__receive_str133:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;final.c,59 :: 		str1[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W1
; i end address is: 6 (W3)
	MOV	#lo_addr(_str1), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV.B	W0, [W1]
;final.c,60 :: 		}
L_end_receive_str1:
	RETURN
; end of _receive_str1

_Init_UART2:

;final.c,64 :: 		void Init_UART2(unsigned char valor_baud)
;final.c,66 :: 		U2BRG = valor_baud; //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
	ZE	W10, W0
	MOV	WREG, U2BRG
;final.c,67 :: 		U2MODE = 0x0000;    //ver tabela para saber as outras configura??es
	CLR	U2MODE
;final.c,68 :: 		U2STA = 0x0000;
	CLR	U2STA
;final.c,69 :: 		IFS1bits.U2TXIF = 0;   //Zera a flag de interrupcao de Tx
	BCLR	IFS1bits, #9
;final.c,70 :: 		IEC1bits.U2TXIE = 0;   //Desabilita a interrupcao de Tx
	BCLR	IEC1bits, #9
;final.c,71 :: 		IFS1bits.U2RXIF = 0;   //Zera a flag de de interrupcao de Rx
	BCLR	IFS1bits, #8
;final.c,72 :: 		IEC1bits.U2RXIE = 0;   //Desabilita a flag de interrupcao de Rx
	BCLR	IEC1bits, #8
;final.c,73 :: 		U2MODEbits.UARTEN = 1; //Liga a UART
	BSET	U2MODEbits, #15
;final.c,74 :: 		U2STAbits.UTXEN = 1;   //Come?a a comunica??o
	BSET	U2STAbits, #10
;final.c,75 :: 		}
L_end_Init_UART2:
	RETURN
; end of _Init_UART2

_Tx_serial2:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;final.c,78 :: 		void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT
;final.c,80 :: 		IFS1bits.U2TXIF = 0;
	BCLR	IFS1bits, #9
;final.c,81 :: 		}
L_end_Tx_serial2:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _Tx_serial2

_send_char2:

;final.c,84 :: 		void send_char2(unsigned char c)
;final.c,86 :: 		while (U2STAbits.UTXBF);
L_send_char29:
	BTSS	U2STAbits, #9
	GOTO	L_send_char210
	GOTO	L_send_char29
L_send_char210:
;final.c,87 :: 		U2TXREG = c; // escreve caractere
	ZE	W10, W0
	MOV	WREG, U2TXREG
;final.c,88 :: 		}
L_end_send_char2:
	RETURN
; end of _send_char2

_send_str2:

;final.c,91 :: 		void send_str2(unsigned char *str)
;final.c,93 :: 		unsigned int i = 0;
; i start address is: 2 (W1)
	CLR	W1
; i end address is: 2 (W1)
;final.c,94 :: 		while (str[i])
L_send_str211:
; i start address is: 2 (W1)
	ADD	W10, W1, W0
	CP0.B	[W0]
	BRA NZ	L__send_str238
	GOTO	L_send_str212
L__send_str238:
;final.c,95 :: 		send_char2(str[i++]);
	ADD	W10, W1, W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_send_char2
	POP	W10
	INC	W1
; i end address is: 2 (W1)
	GOTO	L_send_str211
L_send_str212:
;final.c,96 :: 		}
L_end_send_str2:
	RETURN
; end of _send_str2

_receive_char2:

;final.c,99 :: 		char receive_char2(){
;final.c,101 :: 		while(!U2STAbits.URXDA);
L_receive_char213:
	BTSC	U2STAbits, #0
	GOTO	L_receive_char214
	GOTO	L_receive_char213
L_receive_char214:
;final.c,102 :: 		c = U2RXREG; // escreve caractere
; c start address is: 2 (W1)
	MOV	U2RXREG, W1
;final.c,103 :: 		return c;
	MOV.B	W1, W0
; c end address is: 2 (W1)
;final.c,104 :: 		}
L_end_receive_char2:
	RETURN
; end of _receive_char2

_receive_str2:

;final.c,107 :: 		void receive_str2(){
;final.c,108 :: 		int i = 0;
; i start address is: 6 (W3)
; i start address is: 6 (W3)
	CLR	W3
; i end address is: 6 (W3)
;final.c,111 :: 		do{
	GOTO	L_receive_str215
L__receive_str225:
;final.c,115 :: 		}while(c != 0x0A);
;final.c,111 :: 		do{
L_receive_str215:
;final.c,112 :: 		c = receive_char2();
; i start address is: 6 (W3)
	CALL	_receive_char2
; c start address is: 4 (W2)
	MOV.B	W0, W2
;final.c,113 :: 		str2[i] = c;
	MOV	#lo_addr(_str2), W1
	ADD	W1, W3, W1
	MOV.B	W0, [W1]
;final.c,114 :: 		i++;
	INC	W3
; i end address is: 6 (W3)
;final.c,115 :: 		}while(c != 0x0A);
	CP.B	W2, #10
	BRA Z	L__receive_str241
	GOTO	L__receive_str225
L__receive_str241:
; c end address is: 4 (W2)
; i end address is: 6 (W3)
;final.c,116 :: 		str2[i-1] = '\0';
; i start address is: 6 (W3)
	SUB	W3, #1, W1
; i end address is: 6 (W3)
	MOV	#lo_addr(_str2), W0
	ADD	W0, W1, W1
	CLR	W0
	MOV.B	W0, [W1]
;final.c,117 :: 		}
L_end_receive_str2:
	RETURN
; end of _receive_str2

_criatividade:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;final.c,121 :: 		void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO
;final.c,123 :: 		IFS0bits.INT0IF = 0;
	BCLR.B	IFS0bits, #0
;final.c,124 :: 		}
L_end_criatividade:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _criatividade

_funcao1:

;final.c,190 :: 		void funcao1(){
;final.c,192 :: 		LATB = 1;
	PUSH	W10
	MOV	#1, W0
	MOV	WREG, LATB
;final.c,193 :: 		send_char2('1');
	MOV.B	#49, W10
	CALL	_send_char2
;final.c,194 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,195 :: 		send_str1(flag_menu);
	MOV	#lo_addr(_flag_menu), W0
	ZE	[W0], W10
	CALL	_send_str1
;final.c,196 :: 		receive_str1();
	CALL	_receive_str1
;final.c,197 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,198 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,199 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,200 :: 		}
L_end_funcao1:
	POP	W10
	RETURN
; end of _funcao1

_funcao2:

;final.c,202 :: 		void funcao2(){
;final.c,204 :: 		LATB = 0;
	PUSH	W10
	CLR	LATB
;final.c,205 :: 		send_char2('2');
	MOV.B	#50, W10
	CALL	_send_char2
;final.c,206 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,207 :: 		send_str1(flag_menu);
	MOV	#lo_addr(_flag_menu), W0
	ZE	[W0], W10
	CALL	_send_str1
;final.c,208 :: 		receive_str1();
	CALL	_receive_str1
;final.c,209 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,210 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,211 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,212 :: 		}
L_end_funcao2:
	POP	W10
	RETURN
; end of _funcao2

_funcao3:

;final.c,214 :: 		void funcao3(){
;final.c,216 :: 		LATB = 1;
	PUSH	W10
	MOV	#1, W0
	MOV	WREG, LATB
;final.c,217 :: 		send_char2('3');
	MOV.B	#51, W10
	CALL	_send_char2
;final.c,218 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,219 :: 		send_str1(flag_menu);
	MOV	#lo_addr(_flag_menu), W0
	ZE	[W0], W10
	CALL	_send_str1
;final.c,220 :: 		receive_str1();
	CALL	_receive_str1
;final.c,221 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,222 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,223 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,224 :: 		}
L_end_funcao3:
	POP	W10
	RETURN
; end of _funcao3

_funcao4:

;final.c,226 :: 		void funcao4(){
;final.c,228 :: 		LATB = 0;
	PUSH	W10
	CLR	LATB
;final.c,229 :: 		send_char2('4');
	MOV.B	#52, W10
	CALL	_send_char2
;final.c,230 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,231 :: 		send_str1(flag_menu);
	MOV	#lo_addr(_flag_menu), W0
	ZE	[W0], W10
	CALL	_send_str1
;final.c,232 :: 		receive_str1();
	CALL	_receive_str1
;final.c,233 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,234 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,235 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,236 :: 		}
L_end_funcao4:
	POP	W10
	RETURN
; end of _funcao4

_funcao5:

;final.c,238 :: 		void funcao5(){
;final.c,240 :: 		LATB = 1;
	PUSH	W10
	MOV	#1, W0
	MOV	WREG, LATB
;final.c,241 :: 		send_char2('5');
	MOV.B	#53, W10
	CALL	_send_char2
;final.c,242 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,243 :: 		send_str1(flag_menu);
	MOV	#lo_addr(_flag_menu), W0
	ZE	[W0], W10
	CALL	_send_str1
;final.c,244 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,245 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,246 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,247 :: 		}
L_end_funcao5:
	POP	W10
	RETURN
; end of _funcao5

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;final.c,262 :: 		void main()
;final.c,264 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;final.c,265 :: 		TRISB = 0;
	CLR	TRISB
;final.c,266 :: 		Init_UART1(51);
	MOV.B	#51, W10
	CALL	_Init_UART1
;final.c,267 :: 		Init_UART2(51);
	MOV.B	#51, W10
	CALL	_Init_UART2
;final.c,269 :: 		while(1){
L_main18:
;final.c,286 :: 		receive_str2();
	CALL	_receive_str2
;final.c,287 :: 		send_str1(str2);
	MOV	#lo_addr(_str2), W10
	CALL	_send_str1
;final.c,288 :: 		delay_ms(200);
	MOV	#17, W8
	MOV	#18095, W7
L_main20:
	DEC	W7
	BRA NZ	L_main20
	DEC	W8
	BRA NZ	L_main20
;final.c,289 :: 		receive_str1();
	CALL	_receive_str1
;final.c,290 :: 		send_str2(str1);
	MOV	#lo_addr(_str1), W10
	CALL	_send_str2
;final.c,291 :: 		send_char2('\n');
	MOV.B	#10, W10
	CALL	_send_char2
;final.c,292 :: 		delay_ms(200);
	MOV	#17, W8
	MOV	#18095, W7
L_main22:
	DEC	W7
	BRA NZ	L_main22
	DEC	W8
	BRA NZ	L_main22
;final.c,297 :: 		}
	GOTO	L_main18
;final.c,343 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
