#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/SERIAL/UART2/send_string.c"

void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{

 IFS1bits.U2TXIF = 0;
}


void init_uart2(unsigned char baud_rate){
 U2BRG = baud_rate;
 U2MODE = 0;
 U2STA = 0;
 IFS1bits.U2TXIF = 0;
 IEC1bits.U2TXIE = 0;
 IFS1BITS.U2RXIF = 0;
 IEC1bits.U2RXIE = 0;
 U2MODEbits.UARTEN = 1;
 U2STAbits.UTXEN = 1;
}

int cont = 0;
int valor;

void timer() iv IVT_ADDR_T1INTERRUPT {
 cont++;

 if (cont == valor+1){
 LATBbits.LATB0 = 0;
 }
 if (cont == 99){
 LATBbits.LATB0 = 1;
 cont = 0;
 }

 IFS0bits.T1IF = 0;
}

void enviar_char(unsigned char c){
 while(U2STAbits.UTXBF);
 U2TXREG = c;
}

unsigned char receber_char(){
 unsigned char c;
 while(!U2STAbits.URXDA);
 c = U2RXREG;
 return c;
}




unsigned char m;
void main(){
 ADPCFG = 0xFFFF;
 TRISB = 0;
 LATB = 0;
 init_uart2(103);
 enviar_char(0x30);

 IEC0bits.T1IE = 1;
 IFS0 = 0;
 PR1 = 625;
 T1CON = 0x8000;
 valor = 0;
 while(1){
 m = receber_char();

 if (m == 'a'){
 valor = valor + 20;
 }
 if (m == 'd'){
 valor = valor - 20;
 }
 if (valor <= 1){
 valor = 0;
 }
 if (valor >= 99){
 valor = 100;
 }
#line 88 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/SERIAL/UART2/send_string.c"
 }
}
