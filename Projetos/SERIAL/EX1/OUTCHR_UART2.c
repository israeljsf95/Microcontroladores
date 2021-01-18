

 void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
     IFS1bits.U2TXIF = 0;
}

void INIT_UART2(unsigned char valor_baud){
     U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
     U2MODE = 0x0000; //ver tabela para saber as outras configurações
     U2STA = 0x0000;
     IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
     IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
     IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
     IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
     U2MODEbits.UARTEN = 1; //Liga a UART
     U2STAbits.UTXEN = 1;   //Começa a comunicação
}


void OUTCHR_UART2(unsigned char c){
     while( U2STAbits.UTXBF);
     U2TXREG = c; // escreve caractere
}


unsigned char INCHR_UART2(){
     unsigned char c;
     while(!U2STAbits.URXDA);
     c = U2RXREG; // escreve caractere
     return c;
}

void echo(unsigned char c){
     while (U2STAbits.UTXBF){
        U2TXREG = INCHR_UART2(); // escreve caractere
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