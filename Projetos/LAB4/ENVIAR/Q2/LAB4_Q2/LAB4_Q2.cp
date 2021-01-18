#line 1 "C:/Users/gprufs/Desktop/LAB4/LAB4_Q2/LAB4_Q2.c"
#line 12 "C:/Users/gprufs/Desktop/LAB4/LAB4_Q2/LAB4_Q2.c"
char criat[] = "criati";
char criat_aux[20] = " ";


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


unsigned char receive_char(){
 unsigned char c;
 while(!U2STAbits.URXDA);
 c = U2RXREG;
 return c;
}

char criatividade[100];

void receive_str(){
 int i = 0;
 char c;
 do{
 c = receive_char();
 criatividade[i] = c;
 i++;
 }while(c != 0x0A);
 criatividade[i-1] = '\0';
}



void receive_str_cri(){
 int i = 0;
 char c;
 do{
 c = receive_char();
 criat_aux[i] = c;
 i++;
 }while(c != 0x0A);
 criat_aux[i-1] = '\0';

 delay_ms(250);
}

int flag_criatividade = 0;

void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 Delay_Ms(50);
 if (flag_criatividade == 0){
 flag_criatividade = 1;
 LATBbits.LATB0 = 1;
 }else{
 flag_criatividade = 0;
 LATBbits.LATB0 = 0;
 }
 IFS0bits.INT0IF = 0;
}


int aux2 =  20000 /10;
int aux3;
int duty;
char txt[7];

void mudarPWM(char aux){

 switch(aux){
 case 'F':
  LATBbits.LATB2  = 1;
  LATBbits.LATB3  = 0;
  LATBbits.LATB4  = 1;
  LATBbits.LATB5  = 0;
 send_str("FRENTE \r\n");
 break;
 case 'E':
  LATBbits.LATB2  = 0;
  LATBbits.LATB3  = 1;
  LATBbits.LATB4  = 1;
  LATBbits.LATB5  = 0;
 send_str("ESQUERDA \r\n");
 break;
 case 'D':
  LATBbits.LATB2  = 1;
  LATBbits.LATB3  = 0;
  LATBbits.LATB4  = 0;
  LATBbits.LATB5  = 1;
 send_str("DIREITA \r\n");
 break;
 case 'A':
  LATBbits.LATB4  = 0;
  LATBbits.LATB5  = 1;
  LATBbits.LATB2  = 0;
  LATBbits.LATB3  = 1;
 send_str("ATRAS \r\n");
 break;
 case 'P':

 duty = duty + 10;
 aux3 =  OC1RS  + aux2;
 if (aux3 <=  20000 ){
  OC1RS  += aux2;
 }else{
  OC1RS  =  20000 ;
 duty = 100;
 }
 aux3 =  OC3RS  + aux2;
 if (aux3 <=  20000 ){
  OC3RS  += aux2;
 }else{
  OC3RS  =  20000 ;
 duty = 100;
 }
 send_str("DUTY");
 IntToStr(duty,txt);
 send_str(txt);
 send_str("\r\n");
 break;
 case 'L':
 duty = duty - 10;
 aux3 =  OC1RS  - aux2;
 if(aux3 >= 0){
  OC1RS  -= aux2;
 }else{
  OC1RS  = 0;
 duty = 0;
 }

 aux3 =  OC3RS  - aux2;
 if(aux3 >= 0){
  OC3RS  -= aux2;
 }else{
  OC3RS  = 0;
 duty = 0;
 }
 send_str("DUTY");
 IntToStr(duty,txt);
 send_str(txt);
 send_str("\r\n");
 break;
 default:
 break;
 }
}

unsigned char m = 'y';
unsigned char m2;

void msg() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {

 if (m == 'F')
 send_str("FRENTE ");
 if (m == 'A')
 send_str("ATRAS ");
 if (m == 'D')
 send_str("DIREITA ");
 if (m == 'E')
 send_str("ESQUERDA ");
 send_str("DUTY");
 IntToStr(duty,txt);
 send_str(txt);
 send_str("\r\n");
 IFS0bits.T1IF = 0;
}

int j = 0;
char pepe;
char txt22[8];
void main(){
 ADPCFG = 0xFFFF;
 TRISB = 0;
 LATB = 0;
  OC1RS  = 0;
 OC1CON = 0x0006;
 IEC0bits.INT0IE = 1;

  OC3RS  = 0;
 OC3CON = 0x0006;

 PR2 =  20000 ;
 T2CON = 0x8010;

 IEC0bits.T1IE = 1;
 PR1 = 0xFFFF;
 T1CON = 0x8030;
 TMR1 = 0;

 IFS0 = 0;

 INIT_UART2(51);
 send_char(0x030);
 LATBbits.LATB1 = 0;

 while(1){
 if(flag_criatividade == 0){
 Delay_ms(100);
 m = receive_char();
 mudarPWM(m);
 }else{
 j = 0;
 LATBbits.LATB1 = 1;
 receive_str();
 while(criatividade[j] != '\0'){
 pepe = criatividade[j];
 mudarPWM(pepe);
 j++;
 Delay_ms(500);
 }
 }
 }
}
