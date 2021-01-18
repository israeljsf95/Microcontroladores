
float temp, pot, LDR, conv;

int count; unsigned soma;

char str[8];

//Inicializa a UART2
void Init_UART2(unsigned char valor_baud){
     U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
     U2MODE = 0x0000; //ver tabela para saber as outras configura??es
     U2STA = 0x0000;
     IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
     IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
     IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
     IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
     U2MODEbits.UARTEN = 1; //Liga a UART
     U2STAbits.UTXEN = 1;   //Come?a a comunica??o
}

//Reseta flag da transmissao
void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
     IFS1bits.U2TXIF = 0;
}

//envia um char pelo reg da uart
void send_char(unsigned char c){
     while( U2STAbits.UTXBF);
     U2TXREG = c; // escreve caractere
}

//usa a função de char pra enviar uma string
void send_str(unsigned char* str){
     unsigned int i = 0;
     while(str[i])
         send_char(str[i++]);
}

int* ADC16Ptr;
void conversaoAD(){
  //RB2 - LDR
      ADCHSbits.CH0SA = 0b0010;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF0;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      //++ADC16Ptr;
      for (count = 0; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      soma = soma >> 4;
      conv = (float)(soma);
      //conv = conv/16;
      LDR  = conv*(4.5)/1023;
  //RB5 - POT
      ADCHSbits.CH0SA = 0b0101;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF0;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      //++ADC16Ptr;
      for (count = 0; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      soma = soma >> 4;
      conv = (float)(soma);
      //conv = conv/16;
      pot  = conv*(4.5)/1023;
  //RB7 - LM35
      ADCHSbits.CH0SA = 0b0111;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF0;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      //++ADC16Ptr;
      for (count = 0; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      soma = soma >> 4;
      conv = (float)(soma);
      //conv = conv/16;
      temp = 100*((conv*5)/1023);
}

void Init_ADC(){
    //Configruação dos registradores  AD e das PORTAS
    ADPCFG = 0xFFFF;
    ADPCFGbits.PCFG2 = 0;
    ADPCFGbits.PCFG5 = 0;
    ADPCFGbits.PCFG7 = 0;
    TRISB = 0xFFFF;
    ADCON1 = 0;
    ADCON1bits.SSRC = 0b111;
    ADCSSL = 0;
    ADCON2 = 0;
    ADCON3 = 0x0008;
    ADCON2bits.SMPI = 0b1111;
    ADCON1bits.ADON = 1;

}

int ler_ADC(int canal){
    ADCHS = canal;
    ADCON1bits.SAMP = 1;
    delay_us(10);
    while(!ADCON1bits.DONE);
    return ADCBUF0;
}


char txt1[] = "";
char txt2[] = "";
char txt3[] = "";


void main() {
    Init_ADC();
    Init_UART2(103);
    while(1){
       conversaoAD();
       sprintf(txt1, "%.2f", temp);
       sprintf(txt2, "%.2f", LDR);
       sprintf(txt3, "%.2f", pot);
       send_str("Temp ");
       send_str(txt1);
       send_str("ºC\r\n");
       delay_ms(500);
       send_str("LDR ");
       send_str(txt2);
       send_str(" V \r\n");
       delay_ms(500);
       send_str("Potenciometro ");
       send_str(txt3);
       send_str("V \r\n");
    }
}