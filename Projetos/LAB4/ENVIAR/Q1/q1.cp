#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB4/ENVIAR/Q1/q1.c"
char mC[4][80] = {"Oi, PC tudo bem?",
 "Por favor digita a palavra 'leds' para ligar e desligar os leds a cada 0.5s",
 "Agora digita a palavra PWM!",
 "Obrigado! Digite PARAR para 'parar' e apitar o Buzzer!"};

char pC[6][20] = {"Tudo bem e você?",
 "Tá bom.",
 "leds",
 "Sem problema.",
 "PWM",
 "PARAR"};

const int size = 80;
char str[size] = "";
int estado = 0;

int step = 25;

int var = 0;

void tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 IFS0bits.T1IF = 0;
 if (estado == 6 || estado == 7 || estado == 8)
 LATB = ~LATB;
 if (estado == 9 || estado == 10){
 if (var <= 225){
 var = var + step;
 }else{
 var = 0;
 }
 }
}

int cont;

void tempo2() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
 IFS0bits.T2IF = 0;
 cont++;
 if(cont == 250){
 LATB = 0xFFFF;
 cont = 0;
 }
 if(cont == var)
 LATB = 0;

}


void INIT_UART2(unsigned char valor_baud){
 U2BRG = valor_baud;
 U2MODE = 0x0000;
 U2STA = 0x0000;
 IFS1bits.U2TXIF = 0;
 IEC1bits.U2TXIE = 0;
 IFS1bits.U2RXIF = 0;
 IEC1bits.U2RXIE = 0;
 U2MODEbits.UARTEN = 1;
 U2STAbits.UTXEN = 1;
}


void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
 IFS1bits.U2TXIF = 0;
}


void send_char(unsigned char c){
 while( U2STAbits.UTXBF);
 U2TXREG = c;
}


void send_str(unsigned char* str){
 unsigned int i = 0;
 while(str[i])
 send_char(str[i++]);
}

char receive_char(){
 char c;
 while(!U2STAbits.URXDA);
 c = U2RXREG;
 return c;
}

void receive_str(){
 int i = 0;
 char c;
 do{
 c = receive_char();
 str[i] = c;
 i++;
 }while(c != 0x0A);
 str[i-1] = '\0';
}

int flag = 0;

void check(char* str1){
 flag = strcmp(str, str1);
 if(flag == 0){
 estado++;
 }else{
 send_str("Não entendi, Repita por favor\n\r");
 }
}

void conversa(){
 switch(estado){
 case 0:
 receive_str();
 estado++;
 break;
 case 1:
 send_str(mC[0]);
 send_str("\n\r");
 estado++;
 break;
 case 2:
 receive_str();
 check(pC[0]);
 break;
 case 3:
 send_str(mC[1]);
 send_str("\n\r");
 estado++;
 break;
 case 4:
 receive_str();
 check(pC[1]);
 break;
 case 5:
 receive_str();
 check(pC[2]);
 break;
 case 6:
 T1CONbits.TON = 1;
 send_str(mC[2]);
 send_str("\n\r");
 estado++;
 break;
 case 7:
 receive_str();
 check(pC[3]);
 break;
 case 8:
 receive_str();
 check(pC[4]);
 break;
 case 9:
 var = 0;
 T2CONbits.TON = 1;
 send_str(mC[3]);
 send_str("\n\r");
 estado++;
 break;
 case 10:
 receive_str();
 check(pC[5]);
 break;
 default:
 LATDbits.LATD3 = 1;
 T1CONbits.TON = 0;
 T2CONbits.TON = 0;
 estado = 1;
 LATB = 0;
 Delay_ms(3000);
 LATDbits.LATD3 = 0;
 break;
 }

}


int estado_criatividade = 0;

char mensagens[4][39] = {"CPF válido\r\n",
 "CPF inválido, tente novamente\r\n",
 "Identidade válida\r\n",
 "Identidade inválida, tente novamente\r\n"};

char perguntas[2][25] = {"Informe seu CPF\r\n",
 "Informe sua identidade\r\n"};

char respostas[2][15] = {"000.000.000-00",
 "0123456789"};

int botao = 0;

void botaozinho() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 IFS0bits.INT0IF = 0;
 if (botao == 0){
 botao = 1;
 LATBbits.LATB0 = 1;
 }else{
 LATBbits.LATB0 = 0;
 botao = 0;
 }
}


void receive_criat(char* stri){
 int i = 0;
 char c;
 do{
 c = receive_char();
 stri[i] = c;
 i++;
 }while(c != 0x0A);
 stri[i-1] = '\0';
}

char str_criat[20];
int numero_tentativas = 2;
int flag_criat = 0;

void criatividade(){
 switch(estado_criatividade){
 case 0:
 receive_criat(str_criat);
 estado_criatividade++;
 break;
 case 1:
 send_str(perguntas[0]);
 estado_criatividade++;
 break;
 case 2:
 receive_criat(str_criat);
 flag_criat = strcmp(respostas[0],str_criat);
 if (flag_criat == 0){
 send_str(mensagens[0]);
 estado_criatividade++;
 }else{
 send_str(mensagens[1]);
 numero_tentativas--;
 }
 break;
 case 3:
 send_str(perguntas[1]);
 estado_criatividade++;
 break;
 case 4:
 receive_criat(str_criat);
 flag_criat = strcmp(respostas[1],str_criat);
 if (flag_criat == 0){
 send_str(mensagens[2]);
 estado_criatividade++;
 }else{
 send_str(mensagens[3]);
 numero_tentativas--;
 }
 break;
 case 5:
 send_str("Acesso liberado\r\n");
 numero_tentativas = 2;
 LATBbits.LATB0 = 0;
 botao = 0;
 estado_criatividade++;
 break;
 default:
 estado_criatividade = 0;
 break;
 }
}

char txt[7];

void main() {

 INIT_UART2(103);
 ADPCFG = 0xFFFF;

 TRISB = 0;
 TRISD = 0;
 LATD = 0;
 LATB = 0;
 IEC0 = 0;

 IEC0bits.T1IE = 1;
 IEC0bits.T2IE = 1;

 T1CON = 0x0030;
 PR1 = 64000;

 T2CON = 0x0010;
 PR2 = 250;

 IEC0bits.INT0IE = 1;
 while(1){
 if (botao == 0){
 conversa();
 estado_criatividade = 0;
 }else{
 if (numero_tentativas > 0){
 criatividade();
 }else{
 send_str("BLOQUEIO TOTAL\r\n");
 botao = 0;
 LATBbits.LATB0 = 0;
 estado_criatividade = 0;
 numero_tentativas = 2;
 }
 estado = 0;
 }
 }
}
