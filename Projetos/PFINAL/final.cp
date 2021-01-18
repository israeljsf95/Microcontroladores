#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/PFINAL/final.c"






void Init_UART1(unsigned char valor_baud)
{
 U1BRG = valor_baud;
 U1MODE = 0x0000;
 U1MODEbits.ALTIO = 1;
 U1STA = 0x0000;
 IFS0bits.U1TXIF = 0;
 IEC0bits.U1TXIE = 0;
 IFS0bits.U1RXIF = 0;
 IEC0bits.U1RXIE = 0;
 U1MODEbits.UARTEN = 1;
 U1STAbits.UTXEN = 1;
}


void Tx_serial1() iv IVT_ADDR_U1TXINTERRUPT
{
 IFS0bits.U1TXIF = 0;
}


void send_char1(unsigned char c)
{
 while (U1STAbits.UTXBF);
 U1TXREG = c;
}


void send_str1(unsigned char *str)
{
 unsigned int i = 0;
 while (str[i])
 send_char1(str[i++]);
}


char receive_char1(){
 char c;
 while(!U1STAbits.URXDA);
 c = U1RXREG;
 return c;
}

char str1[100];
void receive_str1(){
 int i = 0;
 char c;
 do{
 c = receive_char1();
 str1[i] = c;
 i++;
 }while(c != 0x69);
 str1[i-1] = '\0';
}



void Init_UART2(unsigned char valor_baud)
{
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


void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT
{
 IFS1bits.U2TXIF = 0;
}


void send_char2(unsigned char c)
{
 while (U2STAbits.UTXBF);
 U2TXREG = c;
}


void send_str2(unsigned char *str)
{
 unsigned int i = 0;
 while (str[i])
 send_char2(str[i++]);
}


char receive_char2(){
 char c;
 while(!U2STAbits.URXDA);
 c = U2RXREG;
 return c;
}

char str2[100];
void receive_str2(){
 int i = 0;
 char c;

 do{
 c = receive_char2();
 str2[i] = c;
 i++;
 }while(c != 0x0A);
 str2[i-1] = '\0';
}



void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO
{
 IFS0bits.INT0IF = 0;
}
#line 187 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/PFINAL/final.c"
int menu;
char flag_menu;

void funcao1(){

 LATB = 1;
 send_char2('1');
 send_char2('\n');
 send_str1(flag_menu);
 receive_str1();
 send_char2('\n');
 send_str2(str1);
 send_char2('\n');
}

void funcao2(){

 LATB = 0;
 send_char2('2');
 send_char2('\n');
 send_str1(flag_menu);
 receive_str1();
 send_char2('\n');
 send_str2(str1);
 send_char2('\n');
}

void funcao3(){

 LATB = 1;
 send_char2('3');
 send_char2('\n');
 send_str1(flag_menu);
 receive_str1();
 send_char2('\n');
 send_str2(str1);
 send_char2('\n');
}

void funcao4(){

 LATB = 0;
 send_char2('4');
 send_char2('\n');
 send_str1(flag_menu);
 receive_str1();
 send_char2('\n');
 send_str2(str1);
 send_char2('\n');
}

void funcao5(){

 LATB = 1;
 send_char2('5');
 send_char2('\n');
 send_str1(flag_menu);
 send_char2('\n');
 send_str2(str1);
 send_char2('\n');
}



char nomes[10][200] = {"",
 "",
 "",
 "",
 "",
 "",
 "",
 "",
 "",
 ""};
char txt;
void main()
{
 ADPCFG = 0xFFFF;
 TRISB = 0;
 Init_UART1(51);
 Init_UART2(51);

 while(1){
#line 286 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/PFINAL/final.c"
 receive_str2();
 send_str1(str2);
 delay_ms(200);
 receive_str1();
 send_str2(str1);
 send_char2('\n');
 delay_ms(200);




 }
#line 343 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/PFINAL/final.c"
}
