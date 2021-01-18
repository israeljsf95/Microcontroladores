#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/SERIAL/EX1/OUTCHR_UART2.c"


 void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
 IFS1bits.U2TXIF = 0;
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


void OUTCHR_UART2(unsigned char c){
 while( U2STAbits.UTXBF);
 U2TXREG = c;
}


unsigned char INCHR_UART2(){
 unsigned char c;
 while(!U2STAbits.URXDA);
 c = U2RXREG;
 return c;
}

void echo(unsigned char c){
 while (U2STAbits.UTXBF){
 U2TXREG = INCHR_UART2();
 }
}


unsigned char m;
unsigned char m2;
void main(){
 ADPCFG = 0xFFFF;
 TRISB = 0x0000;

 INIT_UART2(103);
 OUTCHR_UART2(0x030);
 while(1){
 m = INCHR_UART2();
 echo(m);
 LATB = m;
 };

}
