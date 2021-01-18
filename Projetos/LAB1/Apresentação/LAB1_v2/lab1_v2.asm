
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;lab1_v2.c,80 :: 		void main() {
;lab1_v2.c,82 :: 		ADPCFG = 0xFFFF;
	PUSH	W10
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;lab1_v2.c,84 :: 		TRISB  = 0;
	CLR	TRISB
;lab1_v2.c,86 :: 		TRISD  = 0;
	CLR	TRISD
;lab1_v2.c,88 :: 		TRISF  = 0;
	CLR	TRISF
;lab1_v2.c,90 :: 		TRISE  = 0;
	CLR	TRISE
;lab1_v2.c,93 :: 		while(1){
L_main0:
;lab1_v2.c,96 :: 		if(PORTF == 0x01){
	MOV	PORTF, WREG
	CP	W0, #1
	BRA Z	L__main171
	GOTO	L_main2
L__main171:
;lab1_v2.c,98 :: 		if (contador<31){
	MOV	_contador, W0
	CP	W0, #31
	BRA LT	L__main172
	GOTO	L_main3
L__main172:
;lab1_v2.c,99 :: 		contador++;
	MOV	#1, W1
	MOV	#lo_addr(_contador), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,100 :: 		}else{
	GOTO	L_main4
L_main3:
;lab1_v2.c,101 :: 		contador = 0;
	CLR	W0
	MOV	W0, _contador
;lab1_v2.c,102 :: 		}
L_main4:
;lab1_v2.c,104 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
;lab1_v2.c,106 :: 		disp7[0] = letras[contador];
	MOV	#lo_addr(_letras), W1
	MOV	#lo_addr(_contador), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W1
	MOV	#lo_addr(_disp7), W0
	MOV.B	W1, [W0]
;lab1_v2.c,107 :: 		}
L_main2:
;lab1_v2.c,110 :: 		if(PORTF == 0b00010000){
	MOV	PORTF, WREG
	CP	W0, #16
	BRA Z	L__main173
	GOTO	L_main7
L__main173:
;lab1_v2.c,111 :: 		flag_bomba=1;
	MOV	#1, W0
	MOV	W0, _flag_bomba
;lab1_v2.c,112 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
;lab1_v2.c,113 :: 		}
L_main7:
;lab1_v2.c,116 :: 		if (PORTF == 0x02){
	MOV	PORTF, WREG
	CP	W0, #2
	BRA Z	L__main174
	GOTO	L_main10
L__main174:
;lab1_v2.c,118 :: 		usuario[cont_u] = letras[contador];
	MOV	#lo_addr(_usuario), W1
	MOV	#lo_addr(_cont_u), W0
	ADD	W1, [W0], W2
	MOV	#lo_addr(_letras), W1
	MOV	#lo_addr(_contador), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], [W2]
;lab1_v2.c,120 :: 		contador = 0;
	CLR	W0
	MOV	W0, _contador
;lab1_v2.c,122 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main11:
	DEC	W7
	BRA NZ	L_main11
	DEC	W8
	BRA NZ	L_main11
;lab1_v2.c,124 :: 		mostra_usuario(cont_u);
	MOV	_cont_u, W10
	CALL	_mostra_usuario
;lab1_v2.c,128 :: 		if  (cont_u<6){
	MOV	_cont_u, W0
	CP	W0, #6
	BRA LT	L__main175
	GOTO	L_main13
L__main175:
;lab1_v2.c,129 :: 		cont_u++;
	MOV	#1, W1
	MOV	#lo_addr(_cont_u), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,130 :: 		PORTE = 1;
	MOV	#1, W0
	MOV	WREG, PORTE
;lab1_v2.c,131 :: 		Delay_ms(200);
	MOV	#17, W8
	MOV	#18095, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;lab1_v2.c,132 :: 		PORTE = 0;
	CLR	PORTE
;lab1_v2.c,133 :: 		}
L_main13:
;lab1_v2.c,135 :: 		if  (cont_u == 6){
	MOV	_cont_u, W0
	CP	W0, #6
	BRA Z	L__main176
	GOTO	L_main16
L__main176:
;lab1_v2.c,136 :: 		flag = 1;
	MOV	#1, W0
	MOV	W0, _flag
;lab1_v2.c,137 :: 		for (k = 0; k <= 5; k++){
	CLR	W0
	MOV	W0, _k
L_main17:
	MOV	_k, W0
	CP	W0, #5
	BRA LE	L__main177
	GOTO	L_main18
L__main177:
;lab1_v2.c,138 :: 		if (usuario[k] != secreto[k]){
	MOV	#lo_addr(_usuario), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W2
	MOV	#lo_addr(_secreto), W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], W1
	MOV.B	[W2], W0
	CP.B	W0, [W1]
	BRA NZ	L__main178
	GOTO	L_main20
L__main178:
;lab1_v2.c,139 :: 		flag = 2;
	MOV	#2, W0
	MOV	W0, _flag
;lab1_v2.c,140 :: 		}
L_main20:
;lab1_v2.c,137 :: 		for (k = 0; k <= 5; k++){
	MOV	#1, W1
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,141 :: 		}
	GOTO	L_main17
L_main18:
;lab1_v2.c,142 :: 		}
L_main16:
;lab1_v2.c,144 :: 		disp7[0] = letras[contador];
	MOV	#lo_addr(_letras), W1
	MOV	#lo_addr(_contador), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W1
	MOV	#lo_addr(_disp7), W0
	MOV.B	W1, [W0]
;lab1_v2.c,145 :: 		}
L_main10:
;lab1_v2.c,148 :: 		if(contdosconts == 3){
	MOV	_contdosconts, W0
	CP	W0, #3
	BRA Z	L__main179
	GOTO	L_main21
L__main179:
;lab1_v2.c,149 :: 		PORTE = 1;
	MOV	#1, W0
	MOV	WREG, PORTE
;lab1_v2.c,150 :: 		Delay_ms(5000);
	MOV	#407, W8
	MOV	#59185, W7
L_main22:
	DEC	W7
	BRA NZ	L_main22
	DEC	W8
	BRA NZ	L_main22
;lab1_v2.c,151 :: 		PORTE = 0;
	CLR	PORTE
;lab1_v2.c,152 :: 		contdosconts = 0;
	CLR	W0
	MOV	W0, _contdosconts
;lab1_v2.c,155 :: 		reseta_tudo();
	CALL	_reseta_tudo
;lab1_v2.c,158 :: 		if  (flag_bomba == 1){
	MOV	_flag_bomba, W0
	CP	W0, #1
	BRA Z	L__main180
	GOTO	L_main24
L__main180:
;lab1_v2.c,159 :: 		bomba();
	CALL	_bomba
;lab1_v2.c,160 :: 		}
L_main24:
;lab1_v2.c,162 :: 		}
L_main21:
;lab1_v2.c,165 :: 		if (PORTF == 0x03){
	MOV	PORTF, WREG
	CP	W0, #3
	BRA Z	L__main181
	GOTO	L_main25
L__main181:
;lab1_v2.c,166 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_main26:
	DEC	W7
	BRA NZ	L_main26
	DEC	W8
	BRA NZ	L_main26
;lab1_v2.c,169 :: 		if (flag == 2){
	MOV	_flag, W0
	CP	W0, #2
	BRA Z	L__main182
	GOTO	L_main28
L__main182:
;lab1_v2.c,170 :: 		if (contdosconts < 3){
	MOV	_contdosconts, W0
	CP	W0, #3
	BRA LT	L__main183
	GOTO	L_main29
L__main183:
;lab1_v2.c,171 :: 		contdosconts++;
	MOV	#1, W1
	MOV	#lo_addr(_contdosconts), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,172 :: 		}
L_main29:
;lab1_v2.c,173 :: 		}
L_main28:
;lab1_v2.c,175 :: 		reseta_tudo();
	CALL	_reseta_tudo
;lab1_v2.c,178 :: 		i = 0;
	CLR	W0
	MOV	W0, _i
;lab1_v2.c,179 :: 		for ( m = 0; m < 4; m++ ){
	CLR	W0
	MOV	W0, _m
L_main30:
	MOV	_m, W0
	CP	W0, #4
	BRA LT	L__main184
	GOTO	L_main31
L__main184:
;lab1_v2.c,180 :: 		disp7[m] = '-';
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], W1
	MOV.B	#45, W0
	MOV.B	W0, [W1]
;lab1_v2.c,179 :: 		for ( m = 0; m < 4; m++ ){
	MOV	#1, W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,181 :: 		}
	GOTO	L_main30
L_main31:
;lab1_v2.c,182 :: 		for ( m = 0; m < 6; m++ ){
	CLR	W0
	MOV	W0, _m
L_main33:
	MOV	_m, W0
	CP	W0, #6
	BRA LT	L__main185
	GOTO	L_main34
L__main185:
;lab1_v2.c,183 :: 		usuario[m] = '-';
	MOV	#lo_addr(_usuario), W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], W1
	MOV.B	#45, W0
	MOV.B	W0, [W1]
;lab1_v2.c,182 :: 		for ( m = 0; m < 6; m++ ){
	MOV	#1, W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,184 :: 		}
	GOTO	L_main33
L_main34:
;lab1_v2.c,185 :: 		}
L_main25:
;lab1_v2.c,188 :: 		if ((cont_u == 6)&&(flag==1)){
	MOV	_cont_u, W0
	CP	W0, #6
	BRA Z	L__main186
	GOTO	L__main167
L__main186:
	MOV	_flag, W0
	CP	W0, #1
	BRA Z	L__main187
	GOTO	L__main166
L__main187:
L__main165:
;lab1_v2.c,189 :: 		if (flag2 == 0){
	MOV	_flag2, W0
	CP	W0, #0
	BRA Z	L__main188
	GOTO	L_main39
L__main188:
;lab1_v2.c,190 :: 		PORTE = 1;
	MOV	#1, W0
	MOV	WREG, PORTE
;lab1_v2.c,191 :: 		Delay_ms(1000);
	MOV	#82, W8
	MOV	#24943, W7
L_main40:
	DEC	W7
	BRA NZ	L_main40
	DEC	W8
	BRA NZ	L_main40
	NOP
;lab1_v2.c,192 :: 		PORTE = 0;
	CLR	PORTE
;lab1_v2.c,193 :: 		flag2=1;
	MOV	#1, W0
	MOV	W0, _flag2
;lab1_v2.c,194 :: 		}
L_main39:
;lab1_v2.c,196 :: 		teste_acerto();
	CALL	_teste_acerto
;lab1_v2.c,188 :: 		if ((cont_u == 6)&&(flag==1)){
L__main167:
L__main166:
;lab1_v2.c,200 :: 		if (( cont_u == 6)&&(flag == 2)){
	MOV	_cont_u, W0
	CP	W0, #6
	BRA Z	L__main189
	GOTO	L__main169
L__main189:
	MOV	_flag, W0
	CP	W0, #2
	BRA Z	L__main190
	GOTO	L__main168
L__main190:
L__main164:
;lab1_v2.c,201 :: 		if (flag_erro == 1){
	MOV	_flag_erro, W0
	CP	W0, #1
	BRA Z	L__main191
	GOTO	L_main45
L__main191:
;lab1_v2.c,203 :: 		mostt_uu();
	CALL	_mostt_uu
;lab1_v2.c,204 :: 		}else{
	GOTO	L_main46
L_main45:
;lab1_v2.c,206 :: 		teste_erro();
	CALL	_teste_erro
;lab1_v2.c,207 :: 		}
L_main46:
;lab1_v2.c,200 :: 		if (( cont_u == 6)&&(flag == 2)){
L__main169:
L__main168:
;lab1_v2.c,211 :: 		if (flag == 0){
	MOV	_flag, W0
	CP	W0, #0
	BRA Z	L__main192
	GOTO	L_main47
L__main192:
;lab1_v2.c,212 :: 		leitor();
	CALL	_leitor
;lab1_v2.c,213 :: 		}else{
	GOTO	L_main48
L_main47:
;lab1_v2.c,216 :: 		for (kk = 0; kk < 100; kk++){
	CLR	W0
	MOV	W0, _kk
L_main49:
	MOV	#100, W1
	MOV	#lo_addr(_kk), W0
	CP	W1, [W0]
	BRA GT	L__main193
	GOTO	L_main50
L__main193:
;lab1_v2.c,217 :: 		leitor();
	CALL	_leitor
;lab1_v2.c,216 :: 		for (kk = 0; kk < 100; kk++){
	MOV	#1, W1
	MOV	#lo_addr(_kk), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,218 :: 		}
	GOTO	L_main49
L_main50:
;lab1_v2.c,219 :: 		}
L_main48:
;lab1_v2.c,221 :: 		Delay_ms(1);
	MOV	#5333, W7
L_main52:
	DEC	W7
	BRA NZ	L_main52
	NOP
;lab1_v2.c,223 :: 		conv_char_to_hexa();
	CALL	_conv_char_to_hexa
;lab1_v2.c,224 :: 		}
	GOTO	L_main0
;lab1_v2.c,225 :: 		}
L_end_main:
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_leitor:

;lab1_v2.c,228 :: 		void leitor(){
;lab1_v2.c,229 :: 		LATD = 0xF7;
	MOV	#247, W0
	MOV	WREG, LATD
;lab1_v2.c,230 :: 		LATB = hexa1[0];
	MOV	#lo_addr(_hexa1), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;lab1_v2.c,231 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor54:
	DEC	W7
	BRA NZ	L_leitor54
	NOP
;lab1_v2.c,233 :: 		LATD = 0xFB;
	MOV	#251, W0
	MOV	WREG, LATD
;lab1_v2.c,234 :: 		LATB = hexa1[1];
	MOV	#lo_addr(_hexa1+1), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;lab1_v2.c,235 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor56:
	DEC	W7
	BRA NZ	L_leitor56
	NOP
;lab1_v2.c,237 :: 		LATD = 0xFD;
	MOV	#253, W0
	MOV	WREG, LATD
;lab1_v2.c,238 :: 		LATB = hexa1[2];
	MOV	#lo_addr(_hexa1+2), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;lab1_v2.c,239 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor58:
	DEC	W7
	BRA NZ	L_leitor58
	NOP
;lab1_v2.c,241 :: 		LATD = 0xFE;
	MOV	#254, W0
	MOV	WREG, LATD
;lab1_v2.c,242 :: 		LATB = hexa1[3];
	MOV	#lo_addr(_hexa1+3), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;lab1_v2.c,243 :: 		Delay_ms(T);
	MOV	#5333, W7
L_leitor60:
	DEC	W7
	BRA NZ	L_leitor60
	NOP
;lab1_v2.c,244 :: 		}
L_end_leitor:
	RETURN
; end of _leitor

_conv_char_to_hexa:
	LNK	#2

;lab1_v2.c,247 :: 		void conv_char_to_hexa(){
;lab1_v2.c,248 :: 		for(j=0;j<4;j++){
	PUSH	W10
	CLR	W0
	MOV	W0, _j
L_conv_char_to_hexa62:
	MOV	_j, W0
	CP	W0, #4
	BRA LTU	L__conv_char_to_hexa197
	GOTO	L_conv_char_to_hexa63
L__conv_char_to_hexa197:
;lab1_v2.c,249 :: 		hexa1[j] = char_to_7seg(disp7[j]);
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
;lab1_v2.c,250 :: 		Delay_ms(1);
	MOV	#5333, W7
L_conv_char_to_hexa65:
	DEC	W7
	BRA NZ	L_conv_char_to_hexa65
	NOP
;lab1_v2.c,248 :: 		for(j=0;j<4;j++){
	MOV	#1, W1
	MOV	#lo_addr(_j), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,251 :: 		}
	GOTO	L_conv_char_to_hexa62
L_conv_char_to_hexa63:
;lab1_v2.c,252 :: 		}
L_end_conv_char_to_hexa:
	POP	W10
	ULNK
	RETURN
; end of _conv_char_to_hexa

_teste_acerto:

;lab1_v2.c,255 :: 		void teste_acerto(){
;lab1_v2.c,257 :: 		escreve_acertou();
	CALL	_escreve_acertou
;lab1_v2.c,258 :: 		mostra_men_final_1();
	CALL	_mostra_men_final_1
;lab1_v2.c,259 :: 		descreve_acertou();
	CALL	_descreve_acertou
;lab1_v2.c,261 :: 		}
L_end_teste_acerto:
	RETURN
; end of _teste_acerto

_escreve_acertou:

;lab1_v2.c,263 :: 		void escreve_acertou(){
;lab1_v2.c,264 :: 		for (i = 0; i < 20; i++){
	CLR	W0
	MOV	W0, _i
L_escreve_acertou67:
	MOV	_i, W0
	CP	W0, #20
	BRA LTU	L__escreve_acertou200
	GOTO	L_escreve_acertou68
L__escreve_acertou200:
;lab1_v2.c,265 :: 		if (i<6){
	MOV	_i, W0
	CP	W0, #6
	BRA LTU	L__escreve_acertou201
	GOTO	L_escreve_acertou70
L__escreve_acertou201:
;lab1_v2.c,266 :: 		acertou[i] = usuario[i];
	MOV	#lo_addr(_acertou), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W2
	MOV	#lo_addr(_usuario), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], [W2]
;lab1_v2.c,267 :: 		}else{
	GOTO	L_escreve_acertou71
L_escreve_acertou70:
;lab1_v2.c,268 :: 		acertou[i] = men_final[i-6];
	MOV	#lo_addr(_acertou), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W2
	MOV	_i, W0
	SUB	W0, #6, W1
	MOV	#lo_addr(_men_final), W0
	ADD	W0, W1, W0
	MOV.B	[W0], [W2]
;lab1_v2.c,269 :: 		}
L_escreve_acertou71:
;lab1_v2.c,264 :: 		for (i = 0; i < 20; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,270 :: 		}
	GOTO	L_escreve_acertou67
L_escreve_acertou68:
;lab1_v2.c,271 :: 		}
L_end_escreve_acertou:
	RETURN
; end of _escreve_acertou

_descreve_acertou:

;lab1_v2.c,273 :: 		void descreve_acertou(){
;lab1_v2.c,274 :: 		for (i = 0; i < 20; i++){
	CLR	W0
	MOV	W0, _i
L_descreve_acertou72:
	MOV	_i, W0
	CP	W0, #20
	BRA LTU	L__descreve_acertou203
	GOTO	L_descreve_acertou73
L__descreve_acertou203:
;lab1_v2.c,275 :: 		acertou[i] = ' ';
	MOV	#lo_addr(_acertou), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W1
	MOV.B	#32, W0
	MOV.B	W0, [W1]
;lab1_v2.c,274 :: 		for (i = 0; i < 20; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,276 :: 		}
	GOTO	L_descreve_acertou72
L_descreve_acertou73:
;lab1_v2.c,277 :: 		}
L_end_descreve_acertou:
	RETURN
; end of _descreve_acertou

_mostt_uu:

;lab1_v2.c,279 :: 		void mostt_uu(){
;lab1_v2.c,280 :: 		for (i = 0; i < 50800; i++){
	CLR	W0
	MOV	W0, _i
L_mostt_uu75:
	MOV	_i, W1
	MOV	#50800, W0
	CP	W1, W0
	BRA LTU	L__mostt_uu205
	GOTO	L_mostt_uu76
L__mostt_uu205:
;lab1_v2.c,281 :: 		mostra_men_usuario();
	CALL	_mostra_men_usuario
;lab1_v2.c,280 :: 		for (i = 0; i < 50800; i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,282 :: 		}
	GOTO	L_mostt_uu75
L_mostt_uu76:
;lab1_v2.c,283 :: 		flag_erro = 0;
	CLR	W0
	MOV	W0, _flag_erro
;lab1_v2.c,284 :: 		}
L_end_mostt_uu:
	RETURN
; end of _mostt_uu

_mostra_men_usuario:

;lab1_v2.c,287 :: 		void mostra_men_usuario(){
;lab1_v2.c,290 :: 		for (jj = 0; jj < 4; jj++){
	CLR	W0
	MOV	W0, _jj
L_mostra_men_usuario78:
	MOV	_jj, W0
	CP	W0, #4
	BRA LT	L__mostra_men_usuario207
	GOTO	L_mostra_men_usuario79
L__mostra_men_usuario207:
;lab1_v2.c,291 :: 		disp7[jj] = usuario[cont3+jj];
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], W2
	MOV	_cont3, W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], W1
	MOV	#lo_addr(_usuario), W0
	ADD	W0, W1, W0
	MOV.B	[W0], [W2]
;lab1_v2.c,290 :: 		for (jj = 0; jj < 4; jj++){
	MOV	#1, W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,292 :: 		}
	GOTO	L_mostra_men_usuario78
L_mostra_men_usuario79:
;lab1_v2.c,295 :: 		cont3++;
	MOV	#1, W1
	MOV	#lo_addr(_cont3), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,298 :: 		if (cont3 == 2){
	MOV	_cont3, W0
	CP	W0, #2
	BRA Z	L__mostra_men_usuario208
	GOTO	L_mostra_men_usuario81
L__mostra_men_usuario208:
;lab1_v2.c,299 :: 		cont3 = 0;
	CLR	W0
	MOV	W0, _cont3
;lab1_v2.c,300 :: 		}
L_mostra_men_usuario81:
;lab1_v2.c,303 :: 		aux = disp7[0];
	MOV	#lo_addr(_disp7), W0
	ZE	[W0], W0
	MOV	W0, _aux
;lab1_v2.c,304 :: 		disp7[0] = disp7[3];
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_disp7+3), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,305 :: 		disp7[3] = aux;
	MOV	#lo_addr(_disp7+3), W1
	MOV	_aux, W0
	MOV.B	W0, [W1]
;lab1_v2.c,306 :: 		aux = disp7[1];
	MOV	#lo_addr(_disp7+1), W0
	ZE	[W0], W0
	MOV	W0, _aux
;lab1_v2.c,307 :: 		disp7[1] = disp7[2];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_disp7+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,308 :: 		disp7[2] = aux;
	MOV	#lo_addr(_disp7+2), W1
	MOV	_aux, W0
	MOV.B	W0, [W1]
;lab1_v2.c,309 :: 		}
L_end_mostra_men_usuario:
	RETURN
; end of _mostra_men_usuario

_mostra_men_final_1:

;lab1_v2.c,311 :: 		void mostra_men_final_1(){
;lab1_v2.c,312 :: 		for (jj = 0; jj < 4; jj++){
	CLR	W0
	MOV	W0, _jj
L_mostra_men_final_182:
	MOV	_jj, W0
	CP	W0, #4
	BRA LT	L__mostra_men_final_1210
	GOTO	L_mostra_men_final_183
L__mostra_men_final_1210:
;lab1_v2.c,313 :: 		disp7[jj] = acertou[cont2+jj];
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], W2
	MOV	_cont2, W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], W1
	MOV	#lo_addr(_acertou), W0
	ADD	W0, W1, W0
	MOV.B	[W0], [W2]
;lab1_v2.c,312 :: 		for (jj = 0; jj < 4; jj++){
	MOV	#1, W1
	MOV	#lo_addr(_jj), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,314 :: 		}
	GOTO	L_mostra_men_final_182
L_mostra_men_final_183:
;lab1_v2.c,315 :: 		cont2++;
	MOV	#1, W1
	MOV	#lo_addr(_cont2), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,317 :: 		if (cont2 == 23){
	MOV	_cont2, W0
	CP	W0, #23
	BRA Z	L__mostra_men_final_1211
	GOTO	L_mostra_men_final_185
L__mostra_men_final_1211:
;lab1_v2.c,318 :: 		cont2 = 0;
	CLR	W0
	MOV	W0, _cont2
;lab1_v2.c,319 :: 		}
L_mostra_men_final_185:
;lab1_v2.c,320 :: 		aux = disp7[0];
	MOV	#lo_addr(_disp7), W0
	ZE	[W0], W0
	MOV	W0, _aux
;lab1_v2.c,321 :: 		disp7[0] = disp7[3];
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_disp7+3), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,322 :: 		disp7[3] = aux;
	MOV	#lo_addr(_disp7+3), W1
	MOV	_aux, W0
	MOV.B	W0, [W1]
;lab1_v2.c,323 :: 		aux = disp7[1];
	MOV	#lo_addr(_disp7+1), W0
	ZE	[W0], W0
	MOV	W0, _aux
;lab1_v2.c,324 :: 		disp7[1] = disp7[2];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_disp7+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,325 :: 		disp7[2] = aux;
	MOV	#lo_addr(_disp7+2), W1
	MOV	_aux, W0
	MOV.B	W0, [W1]
;lab1_v2.c,326 :: 		}
L_end_mostra_men_final_1:
	RETURN
; end of _mostra_men_final_1

_teste_erro:

;lab1_v2.c,329 :: 		void teste_erro(){
;lab1_v2.c,330 :: 		if (flag5 == 0){
	MOV	_flag5, W0
	CP	W0, #0
	BRA Z	L__teste_erro213
	GOTO	L_teste_erro86
L__teste_erro213:
;lab1_v2.c,331 :: 		for(ll = 0;ll < 4;ll++){
	CLR	W0
	MOV	W0, _ll
L_teste_erro87:
	MOV	_ll, W0
	CP	W0, #4
	BRA LT	L__teste_erro214
	GOTO	L_teste_erro88
L__teste_erro214:
;lab1_v2.c,332 :: 		disp7[ll]=erro[3-ll];
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_ll), W0
	ADD	W1, [W0], W2
	MOV	_ll, W0
	SUBR	W0, #3, W1
	MOV	#lo_addr(_erro), W0
	ADD	W0, W1, W0
	MOV.B	[W0], [W2]
;lab1_v2.c,331 :: 		for(ll = 0;ll < 4;ll++){
	MOV	#1, W1
	MOV	#lo_addr(_ll), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,333 :: 		}
	GOTO	L_teste_erro87
L_teste_erro88:
;lab1_v2.c,334 :: 		flag5=1;
	MOV	#1, W0
	MOV	W0, _flag5
;lab1_v2.c,335 :: 		}else{
	GOTO	L_teste_erro90
L_teste_erro86:
;lab1_v2.c,336 :: 		for(ll = 0;ll < 4;ll++){
	CLR	W0
	MOV	W0, _ll
L_teste_erro91:
	MOV	_ll, W0
	CP	W0, #4
	BRA LT	L__teste_erro215
	GOTO	L_teste_erro92
L__teste_erro215:
;lab1_v2.c,337 :: 		disp7[ll]=' ';
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_ll), W0
	ADD	W1, [W0], W1
	MOV.B	#32, W0
	MOV.B	W0, [W1]
;lab1_v2.c,336 :: 		for(ll = 0;ll < 4;ll++){
	MOV	#1, W1
	MOV	#lo_addr(_ll), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,338 :: 		}
	GOTO	L_teste_erro91
L_teste_erro92:
;lab1_v2.c,339 :: 		flag5=0;
	CLR	W0
	MOV	W0, _flag5
;lab1_v2.c,340 :: 		}
L_teste_erro90:
;lab1_v2.c,341 :: 		}
L_end_teste_erro:
	RETURN
; end of _teste_erro

_reseta_tudo:

;lab1_v2.c,346 :: 		void reseta_tudo(){
;lab1_v2.c,347 :: 		contador = 0;
	CLR	W0
	MOV	W0, _contador
;lab1_v2.c,348 :: 		cont_u = 0;
	CLR	W0
	MOV	W0, _cont_u
;lab1_v2.c,349 :: 		flag = 0;
	CLR	W0
	MOV	W0, _flag
;lab1_v2.c,350 :: 		jj = 0;
	CLR	W0
	MOV	W0, _jj
;lab1_v2.c,351 :: 		k = 0;
	CLR	W0
	MOV	W0, _k
;lab1_v2.c,352 :: 		kk = 0;
	CLR	W0
	MOV	W0, _kk
;lab1_v2.c,353 :: 		flag2 = 0;
	CLR	W0
	MOV	W0, _flag2
;lab1_v2.c,354 :: 		cont4 = 0;
	CLR	W0
	MOV	W0, _cont4
;lab1_v2.c,355 :: 		ll = 0;
	CLR	W0
	MOV	W0, _ll
;lab1_v2.c,356 :: 		flag5 = 0;
	CLR	W0
	MOV	W0, _flag5
;lab1_v2.c,357 :: 		cont2 = 0;
	CLR	W0
	MOV	W0, _cont2
;lab1_v2.c,358 :: 		cont3 = 0;
	CLR	W0
	MOV	W0, _cont3
;lab1_v2.c,359 :: 		m = 0;
	CLR	W0
	MOV	W0, _m
;lab1_v2.c,360 :: 		i = 0;
	CLR	W0
	MOV	W0, _i
;lab1_v2.c,361 :: 		y = 9;
	MOV	#9, W0
	MOV	W0, _y
;lab1_v2.c,362 :: 		flag_erro = 1;
	MOV	#1, W0
	MOV	W0, _flag_erro
;lab1_v2.c,363 :: 		for (i = 0; i<6;i++){
	CLR	W0
	MOV	W0, _i
L_reseta_tudo94:
	MOV	_i, W0
	CP	W0, #6
	BRA LTU	L__reseta_tudo217
	GOTO	L_reseta_tudo95
L__reseta_tudo217:
;lab1_v2.c,364 :: 		usuario[i] = ' ';
	MOV	#lo_addr(_usuario), W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], W1
	MOV.B	#32, W0
	MOV.B	W0, [W1]
;lab1_v2.c,363 :: 		for (i = 0; i<6;i++){
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,365 :: 		}
	GOTO	L_reseta_tudo94
L_reseta_tudo95:
;lab1_v2.c,367 :: 		}
L_end_reseta_tudo:
	RETURN
; end of _reseta_tudo

_mostra_usuario:

;lab1_v2.c,369 :: 		void mostra_usuario(int cont3){
;lab1_v2.c,370 :: 		switch(cont3){
	GOTO	L_mostra_usuario97
;lab1_v2.c,371 :: 		case 0:
L_mostra_usuario99:
;lab1_v2.c,372 :: 		disp7[1] = usuario[0];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,373 :: 		break;
	GOTO	L_mostra_usuario98
;lab1_v2.c,374 :: 		case 1:
L_mostra_usuario100:
;lab1_v2.c,375 :: 		disp7[1] = usuario[1];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario+1), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,376 :: 		disp7[2] = usuario[0];
	MOV	#lo_addr(_disp7+2), W1
	MOV	#lo_addr(_usuario), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,377 :: 		break;
	GOTO	L_mostra_usuario98
;lab1_v2.c,378 :: 		case 2:
L_mostra_usuario101:
;lab1_v2.c,379 :: 		disp7[1] = usuario[2];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,380 :: 		disp7[2] = usuario[1];
	MOV	#lo_addr(_disp7+2), W1
	MOV	#lo_addr(_usuario+1), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,381 :: 		disp7[3] = usuario[0];
	MOV	#lo_addr(_disp7+3), W1
	MOV	#lo_addr(_usuario), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,382 :: 		break;
	GOTO	L_mostra_usuario98
;lab1_v2.c,383 :: 		case 3:
L_mostra_usuario102:
;lab1_v2.c,384 :: 		disp7[1] = usuario[3];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario+3), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,385 :: 		disp7[2] = usuario[2];
	MOV	#lo_addr(_disp7+2), W1
	MOV	#lo_addr(_usuario+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,386 :: 		disp7[3] = usuario[1];
	MOV	#lo_addr(_disp7+3), W1
	MOV	#lo_addr(_usuario+1), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,387 :: 		break;
	GOTO	L_mostra_usuario98
;lab1_v2.c,388 :: 		case 4:
L_mostra_usuario103:
;lab1_v2.c,389 :: 		disp7[1] = usuario[4];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario+4), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,390 :: 		disp7[2] = usuario[3];
	MOV	#lo_addr(_disp7+2), W1
	MOV	#lo_addr(_usuario+3), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,391 :: 		disp7[3] = usuario[2];
	MOV	#lo_addr(_disp7+3), W1
	MOV	#lo_addr(_usuario+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,392 :: 		disp7[1] = usuario[4];
	MOV	#lo_addr(_disp7+1), W1
	MOV	#lo_addr(_usuario+4), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,393 :: 		disp7[2] = usuario[3];
	MOV	#lo_addr(_disp7+2), W1
	MOV	#lo_addr(_usuario+3), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,394 :: 		disp7[3] = usuario[2];
	MOV	#lo_addr(_disp7+3), W1
	MOV	#lo_addr(_usuario+2), W0
	MOV.B	[W0], [W1]
;lab1_v2.c,395 :: 		break;
	GOTO	L_mostra_usuario98
;lab1_v2.c,396 :: 		}
L_mostra_usuario97:
	CP	W10, #0
	BRA NZ	L__mostra_usuario219
	GOTO	L_mostra_usuario99
L__mostra_usuario219:
	CP	W10, #1
	BRA NZ	L__mostra_usuario220
	GOTO	L_mostra_usuario100
L__mostra_usuario220:
	CP	W10, #2
	BRA NZ	L__mostra_usuario221
	GOTO	L_mostra_usuario101
L__mostra_usuario221:
	CP	W10, #3
	BRA NZ	L__mostra_usuario222
	GOTO	L_mostra_usuario102
L__mostra_usuario222:
	CP	W10, #4
	BRA NZ	L__mostra_usuario223
	GOTO	L_mostra_usuario103
L__mostra_usuario223:
L_mostra_usuario98:
;lab1_v2.c,397 :: 		}
L_end_mostra_usuario:
	RETURN
; end of _mostra_usuario

_char_to_7seg:

;lab1_v2.c,400 :: 		int char_to_7seg(char _char){
;lab1_v2.c,402 :: 		switch(_char){
	GOTO	L_char_to_7seg104
;lab1_v2.c,403 :: 		case ('-'):
L_char_to_7seg106:
;lab1_v2.c,404 :: 		hexa = 0xBF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#191, W0
	MOV.B	W0, [W1]
;lab1_v2.c,405 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,407 :: 		case(' '):
L_char_to_7seg107:
;lab1_v2.c,408 :: 		hexa = 0xFF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#255, W0
	MOV.B	W0, [W1]
;lab1_v2.c,409 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,411 :: 		case('a'):
L_char_to_7seg108:
;lab1_v2.c,412 :: 		hexa = 0x88;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#136, W0
	MOV.B	W0, [W1]
;lab1_v2.c,413 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,415 :: 		case('b'):
L_char_to_7seg109:
;lab1_v2.c,416 :: 		hexa = 0x83;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#131, W0
	MOV.B	W0, [W1]
;lab1_v2.c,417 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,419 :: 		case('c'):
L_char_to_7seg110:
;lab1_v2.c,420 :: 		hexa = 0xC6;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#198, W0
	MOV.B	W0, [W1]
;lab1_v2.c,421 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,423 :: 		case('d'):
L_char_to_7seg111:
;lab1_v2.c,424 :: 		hexa=0xA1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#161, W0
	MOV.B	W0, [W1]
;lab1_v2.c,425 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,427 :: 		case('e'):
L_char_to_7seg112:
;lab1_v2.c,428 :: 		hexa = 0x86;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#134, W0
	MOV.B	W0, [W1]
;lab1_v2.c,429 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,431 :: 		case('f'):
L_char_to_7seg113:
;lab1_v2.c,432 :: 		hexa = 0x8E;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#142, W0
	MOV.B	W0, [W1]
;lab1_v2.c,433 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,435 :: 		case('g'):
L_char_to_7seg114:
;lab1_v2.c,436 :: 		hexa = 0x90;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#144, W0
	MOV.B	W0, [W1]
;lab1_v2.c,437 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,439 :: 		case('h'):
L_char_to_7seg115:
;lab1_v2.c,440 :: 		hexa = 0x8B;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#139, W0
	MOV.B	W0, [W1]
;lab1_v2.c,441 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,443 :: 		case('i'):
L_char_to_7seg116:
;lab1_v2.c,444 :: 		hexa = 0xF9;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#249, W0
	MOV.B	W0, [W1]
;lab1_v2.c,445 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,447 :: 		case('j'):
L_char_to_7seg117:
;lab1_v2.c,448 :: 		hexa = 0xE1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#225, W0
	MOV.B	W0, [W1]
;lab1_v2.c,449 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,451 :: 		case('l'):
L_char_to_7seg118:
;lab1_v2.c,452 :: 		hexa = 0xC7;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#199, W0
	MOV.B	W0, [W1]
;lab1_v2.c,453 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,455 :: 		case('n'):
L_char_to_7seg119:
;lab1_v2.c,456 :: 		hexa = 0xAB;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#171, W0
	MOV.B	W0, [W1]
;lab1_v2.c,457 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,459 :: 		case('o'):
L_char_to_7seg120:
;lab1_v2.c,460 :: 		hexa = 0xC0;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#192, W0
	MOV.B	W0, [W1]
;lab1_v2.c,461 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,463 :: 		case('p'):
L_char_to_7seg121:
;lab1_v2.c,464 :: 		hexa = 0x8C;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#140, W0
	MOV.B	W0, [W1]
;lab1_v2.c,465 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,467 :: 		case('q'):
L_char_to_7seg122:
;lab1_v2.c,468 :: 		hexa = 0x98;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#152, W0
	MOV.B	W0, [W1]
;lab1_v2.c,469 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,471 :: 		case('r'):
L_char_to_7seg123:
;lab1_v2.c,472 :: 		hexa = 0xAF;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#175, W0
	MOV.B	W0, [W1]
;lab1_v2.c,473 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,475 :: 		case('s'):
L_char_to_7seg124:
;lab1_v2.c,476 :: 		hexa = 0x92;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#146, W0
	MOV.B	W0, [W1]
;lab1_v2.c,477 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,479 :: 		case('u'):
L_char_to_7seg125:
;lab1_v2.c,480 :: 		hexa = 0xC1;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#193, W0
	MOV.B	W0, [W1]
;lab1_v2.c,481 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,483 :: 		case('v'):
L_char_to_7seg126:
;lab1_v2.c,484 :: 		hexa = 0xE3;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#227, W0
	MOV.B	W0, [W1]
;lab1_v2.c,485 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,487 :: 		case('0'):
L_char_to_7seg127:
;lab1_v2.c,488 :: 		hexa = 0xC0;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#192, W0
	MOV.B	W0, [W1]
;lab1_v2.c,489 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,491 :: 		case('1'):
L_char_to_7seg128:
;lab1_v2.c,492 :: 		hexa = 0xF9;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#249, W0
	MOV.B	W0, [W1]
;lab1_v2.c,493 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,495 :: 		case('2'):
L_char_to_7seg129:
;lab1_v2.c,496 :: 		hexa = 0xA4;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#164, W0
	MOV.B	W0, [W1]
;lab1_v2.c,497 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,499 :: 		case('3'):
L_char_to_7seg130:
;lab1_v2.c,500 :: 		hexa = 0xB0;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#176, W0
	MOV.B	W0, [W1]
;lab1_v2.c,501 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,503 :: 		case('4'):
L_char_to_7seg131:
;lab1_v2.c,504 :: 		hexa = 0x99;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#153, W0
	MOV.B	W0, [W1]
;lab1_v2.c,505 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,507 :: 		case('5'):
L_char_to_7seg132:
;lab1_v2.c,508 :: 		hexa = 0x92;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#146, W0
	MOV.B	W0, [W1]
;lab1_v2.c,509 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,511 :: 		case('6'):
L_char_to_7seg133:
;lab1_v2.c,512 :: 		hexa = 0x82;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#130, W0
	MOV.B	W0, [W1]
;lab1_v2.c,513 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,515 :: 		case('7'):
L_char_to_7seg134:
;lab1_v2.c,516 :: 		hexa = 0xF8;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#248, W0
	MOV.B	W0, [W1]
;lab1_v2.c,517 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,519 :: 		case('8'):
L_char_to_7seg135:
;lab1_v2.c,520 :: 		hexa = 0x80;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#128, W0
	MOV.B	W0, [W1]
;lab1_v2.c,521 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,523 :: 		case('9'):
L_char_to_7seg136:
;lab1_v2.c,524 :: 		hexa = 0x90;
	MOV	#lo_addr(_hexa), W1
	MOV.B	#144, W0
	MOV.B	W0, [W1]
;lab1_v2.c,525 :: 		break;
	GOTO	L_char_to_7seg105
;lab1_v2.c,526 :: 		}
L_char_to_7seg104:
	MOV.B	#45, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg225
	GOTO	L_char_to_7seg106
L__char_to_7seg225:
	MOV.B	#32, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg226
	GOTO	L_char_to_7seg107
L__char_to_7seg226:
	MOV.B	#97, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg227
	GOTO	L_char_to_7seg108
L__char_to_7seg227:
	MOV.B	#98, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg228
	GOTO	L_char_to_7seg109
L__char_to_7seg228:
	MOV.B	#99, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg229
	GOTO	L_char_to_7seg110
L__char_to_7seg229:
	MOV.B	#100, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg230
	GOTO	L_char_to_7seg111
L__char_to_7seg230:
	MOV.B	#101, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg231
	GOTO	L_char_to_7seg112
L__char_to_7seg231:
	MOV.B	#102, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg232
	GOTO	L_char_to_7seg113
L__char_to_7seg232:
	MOV.B	#103, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg233
	GOTO	L_char_to_7seg114
L__char_to_7seg233:
	MOV.B	#104, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg234
	GOTO	L_char_to_7seg115
L__char_to_7seg234:
	MOV.B	#105, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg235
	GOTO	L_char_to_7seg116
L__char_to_7seg235:
	MOV.B	#106, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg236
	GOTO	L_char_to_7seg117
L__char_to_7seg236:
	MOV.B	#108, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg237
	GOTO	L_char_to_7seg118
L__char_to_7seg237:
	MOV.B	#110, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg238
	GOTO	L_char_to_7seg119
L__char_to_7seg238:
	MOV.B	#111, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg239
	GOTO	L_char_to_7seg120
L__char_to_7seg239:
	MOV.B	#112, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg240
	GOTO	L_char_to_7seg121
L__char_to_7seg240:
	MOV.B	#113, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg241
	GOTO	L_char_to_7seg122
L__char_to_7seg241:
	MOV.B	#114, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg242
	GOTO	L_char_to_7seg123
L__char_to_7seg242:
	MOV.B	#115, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg243
	GOTO	L_char_to_7seg124
L__char_to_7seg243:
	MOV.B	#117, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg244
	GOTO	L_char_to_7seg125
L__char_to_7seg244:
	MOV.B	#118, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg245
	GOTO	L_char_to_7seg126
L__char_to_7seg245:
	MOV.B	#48, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg246
	GOTO	L_char_to_7seg127
L__char_to_7seg246:
	MOV.B	#49, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg247
	GOTO	L_char_to_7seg128
L__char_to_7seg247:
	MOV.B	#50, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg248
	GOTO	L_char_to_7seg129
L__char_to_7seg248:
	MOV.B	#51, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg249
	GOTO	L_char_to_7seg130
L__char_to_7seg249:
	MOV.B	#52, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg250
	GOTO	L_char_to_7seg131
L__char_to_7seg250:
	MOV.B	#53, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg251
	GOTO	L_char_to_7seg132
L__char_to_7seg251:
	MOV.B	#54, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg252
	GOTO	L_char_to_7seg133
L__char_to_7seg252:
	MOV.B	#55, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg253
	GOTO	L_char_to_7seg134
L__char_to_7seg253:
	MOV.B	#56, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg254
	GOTO	L_char_to_7seg135
L__char_to_7seg254:
	MOV.B	#57, W0
	CP.B	W10, W0
	BRA NZ	L__char_to_7seg255
	GOTO	L_char_to_7seg136
L__char_to_7seg255:
L_char_to_7seg105:
;lab1_v2.c,527 :: 		return hexa;
	MOV	#lo_addr(_hexa), W0
	ZE	[W0], W0
;lab1_v2.c,528 :: 		}
L_end_char_to_7seg:
	RETURN
; end of _char_to_7seg

_bomba:

;lab1_v2.c,531 :: 		void bomba(){
;lab1_v2.c,533 :: 		while(y >= 0){
L_bomba137:
	MOV	_y, W0
	CP	W0, #0
	BRA GE	L__bomba257
	GOTO	L_bomba138
L__bomba257:
;lab1_v2.c,535 :: 		disp7[0] = tempo[y];
	MOV	#lo_addr(_tempo), W1
	MOV	#lo_addr(_y), W0
	ADD	W1, [W0], W0
	MOV.B	[W0], W1
	MOV	#lo_addr(_disp7), W0
	MOV.B	W1, [W0]
;lab1_v2.c,536 :: 		disp7[1] = '0';
	MOV	#lo_addr(_disp7+1), W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;lab1_v2.c,537 :: 		disp7[2] = '0';
	MOV	#lo_addr(_disp7+2), W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;lab1_v2.c,538 :: 		disp7[3] = '0';
	MOV	#lo_addr(_disp7+3), W1
	MOV.B	#48, W0
	MOV.B	W0, [W1]
;lab1_v2.c,541 :: 		y--;
	MOV	#1, W1
	MOV	#lo_addr(_y), W0
	SUBR	W1, [W0], [W0]
;lab1_v2.c,543 :: 		PORTE = 0;
	CLR	PORTE
;lab1_v2.c,545 :: 		for( aa = 0 ; aa<100 ; aa++){
	CLR	W0
	MOV	W0, _aa
L_bomba139:
	MOV	#100, W1
	MOV	#lo_addr(_aa), W0
	CP	W1, [W0]
	BRA GT	L__bomba258
	GOTO	L_bomba140
L__bomba258:
;lab1_v2.c,547 :: 		if (flag_cri == 1){
	MOV	#lo_addr(_flag_cri), W0
	MOV.B	[W0], W0
	CP.B	W0, #1
	BRA Z	L__bomba259
	GOTO	L_bomba142
L__bomba259:
;lab1_v2.c,548 :: 		leitor(); }
	CALL	_leitor
L_bomba142:
;lab1_v2.c,545 :: 		for( aa = 0 ; aa<100 ; aa++){
	MOV	#1, W1
	MOV	#lo_addr(_aa), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,549 :: 		}
	GOTO	L_bomba139
L_bomba140:
;lab1_v2.c,551 :: 		for (temp = 1; temp < y; temp++){
	MOV	#1, W0
	MOV	W0, _temp
L_bomba143:
	MOV	_temp, W1
	MOV	#lo_addr(_y), W0
	CP	W1, [W0]
	BRA LT	L__bomba260
	GOTO	L_bomba144
L__bomba260:
;lab1_v2.c,552 :: 		Delay_ms(1);
	MOV	#5333, W7
L_bomba146:
	DEC	W7
	BRA NZ	L_bomba146
	NOP
;lab1_v2.c,551 :: 		for (temp = 1; temp < y; temp++){
	MOV	#1, W1
	MOV	#lo_addr(_temp), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,553 :: 		}
	GOTO	L_bomba143
L_bomba144:
;lab1_v2.c,555 :: 		PORTE = 1;
	MOV	#1, W0
	MOV	WREG, PORTE
;lab1_v2.c,557 :: 		conv_char_to_hexa();
	CALL	_conv_char_to_hexa
;lab1_v2.c,558 :: 		}
	GOTO	L_bomba137
L_bomba138:
;lab1_v2.c,559 :: 		while(1){
L_bomba148:
;lab1_v2.c,561 :: 		PORTD = 0xFE;
	MOV	#254, W0
	MOV	WREG, PORTD
;lab1_v2.c,562 :: 		PORTB = rand()%127;
	CALL	_rand
	MOV	#127, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	WREG, PORTB
;lab1_v2.c,563 :: 		Delay_ms(10);
	MOV	#53333, W7
L_bomba150:
	DEC	W7
	BRA NZ	L_bomba150
	NOP
;lab1_v2.c,564 :: 		PORTD = 0xFD;
	MOV	#253, W0
	MOV	WREG, PORTD
;lab1_v2.c,565 :: 		PORTB = rand()%127;
	CALL	_rand
	MOV	#127, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	WREG, PORTB
;lab1_v2.c,566 :: 		Delay_ms(10);
	MOV	#53333, W7
L_bomba152:
	DEC	W7
	BRA NZ	L_bomba152
	NOP
;lab1_v2.c,567 :: 		PORTD = 0xFB;
	MOV	#251, W0
	MOV	WREG, PORTD
;lab1_v2.c,568 :: 		PORTB = rand()%127;
	CALL	_rand
	MOV	#127, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	WREG, PORTB
;lab1_v2.c,569 :: 		Delay_ms(10);
	MOV	#53333, W7
L_bomba154:
	DEC	W7
	BRA NZ	L_bomba154
	NOP
;lab1_v2.c,570 :: 		PORTD = 0x07;
	MOV	#7, W0
	MOV	WREG, PORTD
;lab1_v2.c,571 :: 		PORTB = rand()%127;
	CALL	_rand
	MOV	#127, W2
	REPEAT	#17
	DIV.S	W0, W2
	MOV	W1, W0
	MOV	WREG, PORTB
;lab1_v2.c,572 :: 		Delay_ms(10);
	MOV	#53333, W7
L_bomba156:
	DEC	W7
	BRA NZ	L_bomba156
	NOP
;lab1_v2.c,575 :: 		if (PORTF == 0x13){
	MOV	PORTF, WREG
	CP	W0, #19
	BRA Z	L__bomba261
	GOTO	L_bomba158
L__bomba261:
;lab1_v2.c,577 :: 		Delay_ms(500);
	MOV	#41, W8
	MOV	#45239, W7
L_bomba159:
	DEC	W7
	BRA NZ	L_bomba159
	DEC	W8
	BRA NZ	L_bomba159
;lab1_v2.c,579 :: 		PORTE = 0;
	CLR	PORTE
;lab1_v2.c,580 :: 		flag_bomba = 0;
	CLR	W0
	MOV	W0, _flag_bomba
;lab1_v2.c,581 :: 		reseta_tudo();
	CALL	_reseta_tudo
;lab1_v2.c,582 :: 		i = 0;
	CLR	W0
	MOV	W0, _i
;lab1_v2.c,583 :: 		for ( m = 0; m < 4; m++ ){
	CLR	W0
	MOV	W0, _m
L_bomba161:
	MOV	_m, W0
	CP	W0, #4
	BRA LT	L__bomba262
	GOTO	L_bomba162
L__bomba262:
;lab1_v2.c,584 :: 		disp7[m] = '-';
	MOV	#lo_addr(_disp7), W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], W1
	MOV.B	#45, W0
	MOV.B	W0, [W1]
;lab1_v2.c,583 :: 		for ( m = 0; m < 4; m++ ){
	MOV	#1, W1
	MOV	#lo_addr(_m), W0
	ADD	W1, [W0], [W0]
;lab1_v2.c,585 :: 		}
	GOTO	L_bomba161
L_bomba162:
;lab1_v2.c,586 :: 		LATD = 0x00;
	CLR	LATD
;lab1_v2.c,587 :: 		LATB = hexa1[0];
	MOV	#lo_addr(_hexa1), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;lab1_v2.c,588 :: 		break;
	GOTO	L_bomba149
;lab1_v2.c,589 :: 		}
L_bomba158:
;lab1_v2.c,591 :: 		}
	GOTO	L_bomba148
L_bomba149:
;lab1_v2.c,592 :: 		}
L_end_bomba:
	RETURN
; end of _bomba
