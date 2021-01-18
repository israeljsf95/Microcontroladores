
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;LAB1_Q2.c,36 :: 		void main() {
;LAB1_Q2.c,37 :: 		ADPCFG = 0xFFFF;
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;LAB1_Q2.c,38 :: 		TRISB = 0;
	CLR	TRISB
;LAB1_Q2.c,39 :: 		TRISD = 0;
	CLR	TRISD
;LAB1_Q2.c,40 :: 		TRISE = 0;
	CLR	TRISE
;LAB1_Q2.c,41 :: 		TRISF = 0;
	CLR	TRISF
;LAB1_Q2.c,42 :: 		atual=0;
	CLR	W0
	MOV	W0, _atual
;LAB1_Q2.c,44 :: 		while(1){
L_main0:
;LAB1_Q2.c,45 :: 		calcula_distancia();
	CALL	_calcula_distancia
;LAB1_Q2.c,46 :: 		ativa_sensores();
	CALL	_ativa_sensores
;LAB1_Q2.c,47 :: 		mostra_display();
	CALL	_mostra_display
;LAB1_Q2.c,48 :: 		atual++;
	MOV	#1, W1
	MOV	#lo_addr(_atual), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,49 :: 		if (PORTF == 0b00010000){
	MOV	PORTF, WREG
	CP	W0, #16
	BRA Z	L__main137
	GOTO	L_main2
L__main137:
;LAB1_Q2.c,54 :: 		PORTE = 0;*/
	MOV	#1, W1
	MOV	#lo_addr(_escolha), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,55 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main3:
	DEC	W7
	BRA NZ	L_main3
	DEC	W8
	BRA NZ	L_main3
;LAB1_Q2.c,56 :: 		}
L_main2:
;LAB1_Q2.c,58 :: 		if ((escolha == 1) && (PORTF == 0b00100000)){
	MOV	_escolha, W0
	CP	W0, #1
	BRA Z	L__main138
	GOTO	L__main131
L__main138:
	MOV	#32, W1
	MOV	#lo_addr(PORTF), W0
	CP	W1, [W0]
	BRA Z	L__main139
	GOTO	L__main130
L__main139:
L__main129:
;LAB1_Q2.c,59 :: 		PORTD = 0xFF;
	MOV	#255, W0
	MOV	WREG, PORTD
;LAB1_Q2.c,60 :: 		tocar_marcha();
	CALL	_tocar_marcha
;LAB1_Q2.c,58 :: 		if ((escolha == 1) && (PORTF == 0b00100000)){
L__main131:
L__main130:
;LAB1_Q2.c,63 :: 		if ((escolha == 2) && (PORTF == 0b00100000)){
	MOV	_escolha, W0
	CP	W0, #2
	BRA Z	L__main140
	GOTO	L__main133
L__main140:
	MOV	#32, W1
	MOV	#lo_addr(PORTF), W0
	CP	W1, [W0]
	BRA Z	L__main141
	GOTO	L__main132
L__main141:
L__main128:
;LAB1_Q2.c,64 :: 		PORTD = 0xFF;
	MOV	#255, W0
	MOV	WREG, PORTD
;LAB1_Q2.c,65 :: 		tocar_forca();
	CALL	_tocar_forca
;LAB1_Q2.c,63 :: 		if ((escolha == 2) && (PORTF == 0b00100000)){
L__main133:
L__main132:
;LAB1_Q2.c,68 :: 		if ((escolha == 3) && (PORTF == 0b00100000)){
	MOV	_escolha, W0
	CP	W0, #3
	BRA Z	L__main142
	GOTO	L__main135
L__main142:
	MOV	#32, W1
	MOV	#lo_addr(PORTF), W0
	CP	W1, [W0]
	BRA Z	L__main143
	GOTO	L__main134
L__main143:
L__main127:
;LAB1_Q2.c,69 :: 		PORTD = 0xFF;
	MOV	#255, W0
	MOV	WREG, PORTD
;LAB1_Q2.c,70 :: 		tocar_jb();
	CALL	_tocar_jb
;LAB1_Q2.c,68 :: 		if ((escolha == 3) && (PORTF == 0b00100000)){
L__main135:
L__main134:
;LAB1_Q2.c,73 :: 		if (escolha == 4){
	MOV	_escolha, W0
	CP	W0, #4
	BRA Z	L__main144
	GOTO	L_main14
L__main144:
;LAB1_Q2.c,74 :: 		escolha = 0;
	CLR	W0
	MOV	W0, _escolha
;LAB1_Q2.c,75 :: 		}
L_main14:
;LAB1_Q2.c,76 :: 		}
	GOTO	L_main0
;LAB1_Q2.c,77 :: 		}
L_end_main:
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_calcula_distancia:

;LAB1_Q2.c,80 :: 		void calcula_distancia(){
;LAB1_Q2.c,82 :: 		if(PORTF == 0x01){
	MOV	PORTF, WREG
	CP	W0, #1
	BRA Z	L__calcula_distancia147
	GOTO	L_calcula_distancia15
L__calcula_distancia147:
;LAB1_Q2.c,83 :: 		if (dist < distmax){
	MOV	_dist, W1
	MOV	#400, W0
	CP	W1, W0
	BRA LT	L__calcula_distancia148
	GOTO	L_calcula_distancia16
L__calcula_distancia148:
;LAB1_Q2.c,84 :: 		dist++;
	MOV	#1, W1
	MOV	#lo_addr(_dist), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,85 :: 		}
L_calcula_distancia16:
;LAB1_Q2.c,86 :: 		Delay_ms(10);
	MOV	#53333, W7
L_calcula_distancia17:
	DEC	W7
	BRA NZ	L_calcula_distancia17
	NOP
;LAB1_Q2.c,87 :: 		}
L_calcula_distancia15:
;LAB1_Q2.c,89 :: 		if(PORTF == 0x02){
	MOV	PORTF, WREG
	CP	W0, #2
	BRA Z	L__calcula_distancia149
	GOTO	L_calcula_distancia19
L__calcula_distancia149:
;LAB1_Q2.c,90 :: 		if ( dist > distmin ){
	MOV	_dist, W0
	CP	W0, #2
	BRA GT	L__calcula_distancia150
	GOTO	L_calcula_distancia20
L__calcula_distancia150:
;LAB1_Q2.c,91 :: 		dist--;
	MOV	#1, W1
	MOV	#lo_addr(_dist), W0
	SUBR	W1, [W0], [W0]
;LAB1_Q2.c,92 :: 		}
L_calcula_distancia20:
;LAB1_Q2.c,93 :: 		Delay_ms(10);
	MOV	#53333, W7
L_calcula_distancia21:
	DEC	W7
	BRA NZ	L_calcula_distancia21
	NOP
;LAB1_Q2.c,94 :: 		}
L_calcula_distancia19:
;LAB1_Q2.c,95 :: 		}
L_end_calcula_distancia:
	RETURN
; end of _calcula_distancia

_ativa_sensores:

;LAB1_Q2.c,97 :: 		void ativa_sensores(){
;LAB1_Q2.c,99 :: 		if (dist > distval[0]){//maior que 200 cm
	MOV	_dist, W1
	MOV	#lo_addr(_distval), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores152
	GOTO	L_ativa_sensores23
L__ativa_sensores152:
;LAB1_Q2.c,100 :: 		PORTE = 0b11111110;
	MOV	#254, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,101 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,102 :: 		estado = 0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,103 :: 		}else if((dist > distval[1])&&(dist <= distval[0])){//maior que 180 cm e menor que 200
	GOTO	L_ativa_sensores24
L_ativa_sensores23:
	MOV	_dist, W1
	MOV	#lo_addr(_distval+2), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores153
	GOTO	L__ativa_sensores118
L__ativa_sensores153:
	MOV	_dist, W1
	MOV	#lo_addr(_distval), W0
	CP	W1, [W0]
	BRA LE	L__ativa_sensores154
	GOTO	L__ativa_sensores117
L__ativa_sensores154:
L__ativa_sensores116:
;LAB1_Q2.c,105 :: 		if (estado == 1){
	MOV	_estado, W0
	CP	W0, #1
	BRA Z	L__ativa_sensores155
	GOTO	L_ativa_sensores28
L__ativa_sensores155:
;LAB1_Q2.c,106 :: 		PORTE=0b11111101;//liga rele 1 e buzzer
	MOV	#253, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,107 :: 		}else{
	GOTO	L_ativa_sensores29
L_ativa_sensores28:
;LAB1_Q2.c,108 :: 		PORTE=0b11111100;//desliga buzzer e liga rele 1
	MOV	#252, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,109 :: 		}
L_ativa_sensores29:
;LAB1_Q2.c,111 :: 		if (atual == antigo + 1500){
	MOV	_antigo, W1
	MOV	#1500, W0
	ADD	W1, W0, W1
	MOV	#lo_addr(_atual), W0
	CP	W1, [W0]
	BRA Z	L__ativa_sensores156
	GOTO	L_ativa_sensores30
L__ativa_sensores156:
;LAB1_Q2.c,112 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,113 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__ativa_sensores157
	GOTO	L_ativa_sensores31
L__ativa_sensores157:
;LAB1_Q2.c,114 :: 		estado=1;
	MOV	#1, W0
	MOV	W0, _estado
;LAB1_Q2.c,115 :: 		}else{
	GOTO	L_ativa_sensores32
L_ativa_sensores31:
;LAB1_Q2.c,116 :: 		estado=0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,117 :: 		}
L_ativa_sensores32:
;LAB1_Q2.c,118 :: 		}
L_ativa_sensores30:
;LAB1_Q2.c,120 :: 		}else if((dist > distval[2])&&(dist <= distval[1])){//maior que 120 cm e menor que 180
	GOTO	L_ativa_sensores33
;LAB1_Q2.c,103 :: 		}else if((dist > distval[1])&&(dist <= distval[0])){//maior que 180 cm e menor que 200
L__ativa_sensores118:
L__ativa_sensores117:
;LAB1_Q2.c,120 :: 		}else if((dist > distval[2])&&(dist <= distval[1])){//maior que 120 cm e menor que 180
	MOV	_dist, W1
	MOV	#lo_addr(_distval+4), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores158
	GOTO	L__ativa_sensores120
L__ativa_sensores158:
	MOV	_dist, W1
	MOV	#lo_addr(_distval+2), W0
	CP	W1, [W0]
	BRA LE	L__ativa_sensores159
	GOTO	L__ativa_sensores119
L__ativa_sensores159:
L__ativa_sensores115:
;LAB1_Q2.c,122 :: 		if (estado == 1){
	MOV	_estado, W0
	CP	W0, #1
	BRA Z	L__ativa_sensores160
	GOTO	L_ativa_sensores37
L__ativa_sensores160:
;LAB1_Q2.c,123 :: 		PORTE=0b11111011;//liga rele 1 e buzzer
	MOV	#251, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,124 :: 		}else{
	GOTO	L_ativa_sensores38
L_ativa_sensores37:
;LAB1_Q2.c,125 :: 		PORTE=0b11111010;//desliga buzzer e liga rele 1
	MOV	#250, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,126 :: 		}
L_ativa_sensores38:
;LAB1_Q2.c,128 :: 		if (atual == antigo + 1000){
	MOV	_antigo, W1
	MOV	#1000, W0
	ADD	W1, W0, W1
	MOV	#lo_addr(_atual), W0
	CP	W1, [W0]
	BRA Z	L__ativa_sensores161
	GOTO	L_ativa_sensores39
L__ativa_sensores161:
;LAB1_Q2.c,129 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,130 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__ativa_sensores162
	GOTO	L_ativa_sensores40
L__ativa_sensores162:
;LAB1_Q2.c,131 :: 		estado=1;
	MOV	#1, W0
	MOV	W0, _estado
;LAB1_Q2.c,132 :: 		}else{
	GOTO	L_ativa_sensores41
L_ativa_sensores40:
;LAB1_Q2.c,133 :: 		estado=0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,134 :: 		}
L_ativa_sensores41:
;LAB1_Q2.c,135 :: 		}
L_ativa_sensores39:
;LAB1_Q2.c,137 :: 		}else if((dist > distval[3])&&(dist <= distval[2])){//maior que 80 cm e menor que 120
	GOTO	L_ativa_sensores42
;LAB1_Q2.c,120 :: 		}else if((dist > distval[2])&&(dist <= distval[1])){//maior que 120 cm e menor que 180
L__ativa_sensores120:
L__ativa_sensores119:
;LAB1_Q2.c,137 :: 		}else if((dist > distval[3])&&(dist <= distval[2])){//maior que 80 cm e menor que 120
	MOV	_dist, W1
	MOV	#lo_addr(_distval+6), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores163
	GOTO	L__ativa_sensores122
L__ativa_sensores163:
	MOV	_dist, W1
	MOV	#lo_addr(_distval+4), W0
	CP	W1, [W0]
	BRA LE	L__ativa_sensores164
	GOTO	L__ativa_sensores121
L__ativa_sensores164:
L__ativa_sensores114:
;LAB1_Q2.c,139 :: 		if (estado == 1){
	MOV	_estado, W0
	CP	W0, #1
	BRA Z	L__ativa_sensores165
	GOTO	L_ativa_sensores46
L__ativa_sensores165:
;LAB1_Q2.c,140 :: 		PORTE=0b11110111;//liga rele 1 e buzzer
	MOV	#247, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,141 :: 		}else{
	GOTO	L_ativa_sensores47
L_ativa_sensores46:
;LAB1_Q2.c,142 :: 		PORTE=0b11110110;//desliga buzzer e liga rele 1
	MOV	#246, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,143 :: 		}
L_ativa_sensores47:
;LAB1_Q2.c,145 :: 		if (atual == antigo + 500){
	MOV	_antigo, W1
	MOV	#500, W0
	ADD	W1, W0, W1
	MOV	#lo_addr(_atual), W0
	CP	W1, [W0]
	BRA Z	L__ativa_sensores166
	GOTO	L_ativa_sensores48
L__ativa_sensores166:
;LAB1_Q2.c,146 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,147 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__ativa_sensores167
	GOTO	L_ativa_sensores49
L__ativa_sensores167:
;LAB1_Q2.c,148 :: 		estado=1;
	MOV	#1, W0
	MOV	W0, _estado
;LAB1_Q2.c,149 :: 		}else{
	GOTO	L_ativa_sensores50
L_ativa_sensores49:
;LAB1_Q2.c,150 :: 		estado=0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,151 :: 		}
L_ativa_sensores50:
;LAB1_Q2.c,152 :: 		}
L_ativa_sensores48:
;LAB1_Q2.c,154 :: 		}else if((dist > distval[4])&&(dist <= distval[3])){//maior que 50 cm e menor que 80
	GOTO	L_ativa_sensores51
;LAB1_Q2.c,137 :: 		}else if((dist > distval[3])&&(dist <= distval[2])){//maior que 80 cm e menor que 120
L__ativa_sensores122:
L__ativa_sensores121:
;LAB1_Q2.c,154 :: 		}else if((dist > distval[4])&&(dist <= distval[3])){//maior que 50 cm e menor que 80
	MOV	_dist, W1
	MOV	#lo_addr(_distval+8), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores168
	GOTO	L__ativa_sensores124
L__ativa_sensores168:
	MOV	_dist, W1
	MOV	#lo_addr(_distval+6), W0
	CP	W1, [W0]
	BRA LE	L__ativa_sensores169
	GOTO	L__ativa_sensores123
L__ativa_sensores169:
L__ativa_sensores113:
;LAB1_Q2.c,156 :: 		if (estado == 1){
	MOV	_estado, W0
	CP	W0, #1
	BRA Z	L__ativa_sensores170
	GOTO	L_ativa_sensores55
L__ativa_sensores170:
;LAB1_Q2.c,157 :: 		PORTE=0b11101111;//liga rele 1 e buzzer
	MOV	#239, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,158 :: 		}else{
	GOTO	L_ativa_sensores56
L_ativa_sensores55:
;LAB1_Q2.c,159 :: 		PORTE=0b11101110;//desliga buzzer e liga rele 1
	MOV	#238, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,160 :: 		}
L_ativa_sensores56:
;LAB1_Q2.c,162 :: 		if (atual == antigo + 375){
	MOV	_antigo, W1
	MOV	#375, W0
	ADD	W1, W0, W1
	MOV	#lo_addr(_atual), W0
	CP	W1, [W0]
	BRA Z	L__ativa_sensores171
	GOTO	L_ativa_sensores57
L__ativa_sensores171:
;LAB1_Q2.c,163 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,164 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__ativa_sensores172
	GOTO	L_ativa_sensores58
L__ativa_sensores172:
;LAB1_Q2.c,165 :: 		estado=1;
	MOV	#1, W0
	MOV	W0, _estado
;LAB1_Q2.c,166 :: 		}else{
	GOTO	L_ativa_sensores59
L_ativa_sensores58:
;LAB1_Q2.c,167 :: 		estado=0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,168 :: 		}
L_ativa_sensores59:
;LAB1_Q2.c,169 :: 		}
L_ativa_sensores57:
;LAB1_Q2.c,171 :: 		}else if((dist > distval[5])&&(dist <= distval[4])){//maior que 20 cm e menor que 50
	GOTO	L_ativa_sensores60
;LAB1_Q2.c,154 :: 		}else if((dist > distval[4])&&(dist <= distval[3])){//maior que 50 cm e menor que 80
L__ativa_sensores124:
L__ativa_sensores123:
;LAB1_Q2.c,171 :: 		}else if((dist > distval[5])&&(dist <= distval[4])){//maior que 20 cm e menor que 50
	MOV	_dist, W1
	MOV	#lo_addr(_distval+10), W0
	CP	W1, [W0]
	BRA GT	L__ativa_sensores173
	GOTO	L__ativa_sensores126
L__ativa_sensores173:
	MOV	_dist, W1
	MOV	#lo_addr(_distval+8), W0
	CP	W1, [W0]
	BRA LE	L__ativa_sensores174
	GOTO	L__ativa_sensores125
L__ativa_sensores174:
L__ativa_sensores112:
;LAB1_Q2.c,173 :: 		if (estado == 1){
	MOV	_estado, W0
	CP	W0, #1
	BRA Z	L__ativa_sensores175
	GOTO	L_ativa_sensores64
L__ativa_sensores175:
;LAB1_Q2.c,174 :: 		PORTE=0b11111001;//liga rele 1 e buzzer
	MOV	#249, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,175 :: 		}else{
	GOTO	L_ativa_sensores65
L_ativa_sensores64:
;LAB1_Q2.c,176 :: 		PORTE=0b11111000;//desliga buzzer e liga rele 1 e 2
	MOV	#248, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,177 :: 		}
L_ativa_sensores65:
;LAB1_Q2.c,179 :: 		if (atual == antigo + 250){
	MOV	#250, W1
	MOV	#lo_addr(_antigo), W0
	ADD	W1, [W0], W1
	MOV	#lo_addr(_atual), W0
	CP	W1, [W0]
	BRA Z	L__ativa_sensores176
	GOTO	L_ativa_sensores66
L__ativa_sensores176:
;LAB1_Q2.c,180 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,181 :: 		if (estado == 0){
	MOV	_estado, W0
	CP	W0, #0
	BRA Z	L__ativa_sensores177
	GOTO	L_ativa_sensores67
L__ativa_sensores177:
;LAB1_Q2.c,182 :: 		estado=1;
	MOV	#1, W0
	MOV	W0, _estado
;LAB1_Q2.c,183 :: 		}else{
	GOTO	L_ativa_sensores68
L_ativa_sensores67:
;LAB1_Q2.c,184 :: 		estado=0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,185 :: 		}
L_ativa_sensores68:
;LAB1_Q2.c,186 :: 		}
L_ativa_sensores66:
;LAB1_Q2.c,188 :: 		}else{//menor que 20 cm
	GOTO	L_ativa_sensores69
;LAB1_Q2.c,171 :: 		}else if((dist > distval[5])&&(dist <= distval[4])){//maior que 20 cm e menor que 50
L__ativa_sensores126:
L__ativa_sensores125:
;LAB1_Q2.c,189 :: 		PORTE=0b00000001;//liga reles e buzzer
	MOV	#1, W0
	MOV	WREG, PORTE
;LAB1_Q2.c,190 :: 		antigo = atual;
	MOV	_atual, W0
	MOV	W0, _antigo
;LAB1_Q2.c,191 :: 		estado = 0;
	CLR	W0
	MOV	W0, _estado
;LAB1_Q2.c,192 :: 		}
L_ativa_sensores69:
L_ativa_sensores60:
L_ativa_sensores51:
L_ativa_sensores42:
L_ativa_sensores33:
L_ativa_sensores24:
;LAB1_Q2.c,193 :: 		}
L_end_ativa_sensores:
	RETURN
; end of _ativa_sensores

_mostra_display:

;LAB1_Q2.c,195 :: 		void mostra_display(){
;LAB1_Q2.c,196 :: 		d[3] = 0;
	CLR	W0
	MOV	W0, _d+6
;LAB1_Q2.c,197 :: 		d[2] = dist/100;       //centenas
	MOV	#100, W2
	MOV	_dist, W0
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _d+4
;LAB1_Q2.c,198 :: 		d[1] = (dist%100)/10;  //dezenas
	MOV	#100, W2
	MOV	_dist, W0
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	#10, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W0, _d+2
;LAB1_Q2.c,199 :: 		d[0] = dist%10;        //unidade
	MOV	_dist, W0
	MOV	#10, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	W0, _d
;LAB1_Q2.c,200 :: 		for(i = 0;i < 4;i++){
	CLR	W0
	MOV	W0, _i
L_mostra_display70:
	MOV	_i, W0
	CP	W0, #4
	BRA LT	L__mostra_display179
	GOTO	L_mostra_display71
L__mostra_display179:
;LAB1_Q2.c,201 :: 		LATD = mux[i];
	MOV	_i, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_mux), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	WREG, LATD
;LAB1_Q2.c,202 :: 		LATB = seg7[d[i]];
	MOV	#lo_addr(_d), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_seg7), W0
	ADD	W0, W1, W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATB
;LAB1_Q2.c,203 :: 		Delay_ms(1);
	MOV	#5333, W7
L_mostra_display73:
	DEC	W7
	BRA NZ	L_mostra_display73
	NOP
;LAB1_Q2.c,200 :: 		for(i = 0;i < 4;i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,204 :: 		}
	GOTO	L_mostra_display70
L_mostra_display71:
;LAB1_Q2.c,205 :: 		}
L_end_mostra_display:
	RETURN
; end of _mostra_display

_tocar_marcha:

;LAB1_Q2.c,209 :: 		void tocar_marcha(){
;LAB1_Q2.c,210 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;LAB1_Q2.c,211 :: 		k=0;
	CLR	W0
	MOV	W0, _k
;LAB1_Q2.c,212 :: 		while(cont < tamanhos[escolha - 1]){
L_tocar_marcha75:
	MOV	_escolha, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_tamanhos), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA GT	L__tocar_marcha181
	GOTO	L_tocar_marcha76
L__tocar_marcha181:
;LAB1_Q2.c,216 :: 		LATE=muxrelay[k];
	MOV	#lo_addr(_muxrelay), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATE
;LAB1_Q2.c,217 :: 		Delay_ms(30);
	MOV	#3, W8
	MOV	#28927, W7
L_tocar_marcha77:
	DEC	W7
	BRA NZ	L_tocar_marcha77
	DEC	W8
	BRA NZ	L_tocar_marcha77
	NOP
	NOP
;LAB1_Q2.c,218 :: 		LATE=0xFE;
	MOV	#254, W0
	MOV	WREG, LATE
;LAB1_Q2.c,220 :: 		if (k<3){
	MOV	_k, W0
	CP	W0, #3
	BRA LT	L__tocar_marcha182
	GOTO	L_tocar_marcha79
L__tocar_marcha182:
;LAB1_Q2.c,221 :: 		k++;
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,222 :: 		}else{
	GOTO	L_tocar_marcha80
L_tocar_marcha79:
;LAB1_Q2.c,223 :: 		k=0;
	CLR	W0
	MOV	W0, _k
;LAB1_Q2.c,224 :: 		}
L_tocar_marcha80:
;LAB1_Q2.c,233 :: 		for ( j = marcha[cont]; j > 0 ; j--) {
	MOV	_cont, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_marcha), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	W0, _j
L_tocar_marcha81:
	MOV	_j, W0
	CP	W0, #0
	BRA GT	L__tocar_marcha183
	GOTO	L_tocar_marcha82
L__tocar_marcha183:
;LAB1_Q2.c,234 :: 		Delay_ms(1);
	MOV	#5333, W7
L_tocar_marcha84:
	DEC	W7
	BRA NZ	L_tocar_marcha84
	NOP
;LAB1_Q2.c,233 :: 		for ( j = marcha[cont]; j > 0 ; j--) {
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	SUBR	W1, [W0], [W0]
;LAB1_Q2.c,235 :: 		}
	GOTO	L_tocar_marcha81
L_tocar_marcha82:
;LAB1_Q2.c,237 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,240 :: 		}
	GOTO	L_tocar_marcha75
L_tocar_marcha76:
;LAB1_Q2.c,241 :: 		}
L_end_tocar_marcha:
	RETURN
; end of _tocar_marcha

_tocar_forca:

;LAB1_Q2.c,243 :: 		void tocar_forca(){
;LAB1_Q2.c,244 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;LAB1_Q2.c,245 :: 		while(cont<tamanhos[escolha-1]){
L_tocar_forca86:
	MOV	_escolha, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_tamanhos), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA GT	L__tocar_forca185
	GOTO	L_tocar_forca87
L__tocar_forca185:
;LAB1_Q2.c,248 :: 		LATE=muxrelay[k];
	MOV	#lo_addr(_muxrelay), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATE
;LAB1_Q2.c,249 :: 		Delay_ms(30);
	MOV	#3, W8
	MOV	#28927, W7
L_tocar_forca88:
	DEC	W7
	BRA NZ	L_tocar_forca88
	DEC	W8
	BRA NZ	L_tocar_forca88
	NOP
	NOP
;LAB1_Q2.c,250 :: 		LATE=0xFE;
	MOV	#254, W0
	MOV	WREG, LATE
;LAB1_Q2.c,252 :: 		if (k<3){
	MOV	_k, W0
	CP	W0, #3
	BRA LT	L__tocar_forca186
	GOTO	L_tocar_forca90
L__tocar_forca186:
;LAB1_Q2.c,253 :: 		k++;
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,254 :: 		}else{
	GOTO	L_tocar_forca91
L_tocar_forca90:
;LAB1_Q2.c,255 :: 		k=0;
	CLR	W0
	MOV	W0, _k
;LAB1_Q2.c,256 :: 		}
L_tocar_forca91:
;LAB1_Q2.c,264 :: 		for ( j = forca[cont]; j>0 ; j--) {
	MOV	_cont, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_forca), W0
	ADD	W0, W1, W0
	MOV	[W0], W0
	MOV	W0, _j
L_tocar_forca92:
	MOV	_j, W0
	CP	W0, #0
	BRA GT	L__tocar_forca187
	GOTO	L_tocar_forca93
L__tocar_forca187:
;LAB1_Q2.c,265 :: 		Delay_ms(1);
	MOV	#5333, W7
L_tocar_forca95:
	DEC	W7
	BRA NZ	L_tocar_forca95
	NOP
;LAB1_Q2.c,264 :: 		for ( j = forca[cont]; j>0 ; j--) {
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	SUBR	W1, [W0], [W0]
;LAB1_Q2.c,266 :: 		}
	GOTO	L_tocar_forca92
L_tocar_forca93:
;LAB1_Q2.c,268 :: 		if (cont<tamanhos[escolha-1]){
	MOV	_escolha, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_tamanhos), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA GT	L__tocar_forca188
	GOTO	L_tocar_forca97
L__tocar_forca188:
;LAB1_Q2.c,269 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,270 :: 		}else{
	GOTO	L_tocar_forca98
L_tocar_forca97:
;LAB1_Q2.c,271 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;LAB1_Q2.c,272 :: 		}
L_tocar_forca98:
;LAB1_Q2.c,274 :: 		}
	GOTO	L_tocar_forca86
L_tocar_forca87:
;LAB1_Q2.c,275 :: 		}
L_end_tocar_forca:
	RETURN
; end of _tocar_forca

_tocar_jb:

;LAB1_Q2.c,278 :: 		void tocar_jb(){
;LAB1_Q2.c,279 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;LAB1_Q2.c,280 :: 		while(cont<tamanhos[escolha - 1]){
L_tocar_jb99:
	MOV	_escolha, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_tamanhos), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA GT	L__tocar_jb190
	GOTO	L_tocar_jb100
L__tocar_jb190:
;LAB1_Q2.c,283 :: 		LATE=muxrelay[k];
	MOV	#lo_addr(_muxrelay), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W0
	ZE	W0, W0
	MOV	WREG, LATE
;LAB1_Q2.c,284 :: 		Delay_ms(30);
	MOV	#3, W8
	MOV	#28927, W7
L_tocar_jb101:
	DEC	W7
	BRA NZ	L_tocar_jb101
	DEC	W8
	BRA NZ	L_tocar_jb101
	NOP
	NOP
;LAB1_Q2.c,285 :: 		LATE=0xFE;
	MOV	#254, W0
	MOV	WREG, LATE
;LAB1_Q2.c,287 :: 		if (k<3){
	MOV	_k, W0
	CP	W0, #3
	BRA LT	L__tocar_jb191
	GOTO	L_tocar_jb103
L__tocar_jb191:
;LAB1_Q2.c,288 :: 		k++;
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,289 :: 		}else{
	GOTO	L_tocar_jb104
L_tocar_jb103:
;LAB1_Q2.c,290 :: 		k=0;
	CLR	W0
	MOV	W0, _k
;LAB1_Q2.c,291 :: 		}
L_tocar_jb104:
;LAB1_Q2.c,300 :: 		for ( j = jb[cont]+75; j>0 ; j--) {
	MOV	_cont, W0
	SL	W0, #1, W1
	MOV	#lo_addr(_jb), W0
	ADD	W0, W1, W2
	MOV	#75, W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W2], [W0]
L_tocar_jb105:
	MOV	_j, W0
	CP	W0, #0
	BRA GT	L__tocar_jb192
	GOTO	L_tocar_jb106
L__tocar_jb192:
;LAB1_Q2.c,301 :: 		Delay_ms(1);
	MOV	#5333, W7
L_tocar_jb108:
	DEC	W7
	BRA NZ	L_tocar_jb108
	NOP
;LAB1_Q2.c,300 :: 		for ( j = jb[cont]+75; j>0 ; j--) {
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	SUBR	W1, [W0], [W0]
;LAB1_Q2.c,302 :: 		}
	GOTO	L_tocar_jb105
L_tocar_jb106:
;LAB1_Q2.c,304 :: 		if (cont<tamanhos[escolha - 1]){
	MOV	_escolha, W0
	DEC	W0
	SL	W0, #1, W1
	MOV	#lo_addr(_tamanhos), W0
	ADD	W0, W1, W0
	MOV	[W0], W1
	MOV	#lo_addr(_cont), W0
	CP	W1, [W0]
	BRA GT	L__tocar_jb193
	GOTO	L_tocar_jb110
L__tocar_jb193:
;LAB1_Q2.c,305 :: 		cont++;
	MOV	#1, W1
	MOV	#lo_addr(_cont), W0
	ADD	W1, [W0], [W0]
;LAB1_Q2.c,306 :: 		}else{
	GOTO	L_tocar_jb111
L_tocar_jb110:
;LAB1_Q2.c,307 :: 		cont = 0;
	CLR	W0
	MOV	W0, _cont
;LAB1_Q2.c,308 :: 		}
L_tocar_jb111:
;LAB1_Q2.c,309 :: 		}
	GOTO	L_tocar_jb99
L_tocar_jb100:
;LAB1_Q2.c,310 :: 		}
L_end_tocar_jb:
	RETURN
; end of _tocar_jb
