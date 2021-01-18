

//Variaveis para o funcionamento do sistema
float temp, pot, LDR, conv;

long int count, soma;

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


//Parte referente ao processo de Conversao AD
//Fui usado somente um canal para fazer a conversao sequenciamente
//Cada entrada analógica é setada como entrada para o canal de conversao
//Entre cada conversao e dada um delay
int* ADC16Ptr;
void conversaoAD(){
  //RB0 - LDR
      ADCHSbits.CH0SA = 0b0110;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF1;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      //++ADC16Ptr;
      for (count = 1; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      conv = (float)(soma);
      conv = conv/16;
      LDR  = conv*(4.5)/1023;
      Delay_ms(350);
  //RB7 - TEMP
      ADCHSbits.CH0SA = 0b0111;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF1;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      ADC16Ptr;
      for (count = 1; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      conv = (float)(soma);
      conv = conv/16;
      temp = 100*((conv*5)/1023);
      Delay_ms(350);
  //RB8 - POT
      ADCHSbits.CH0SA = 0b1000;
      conv = 0;
      soma = 0;
      ADC16Ptr = &ADCBUF1;
      IFS0bits.ADIF = 0;
      ADCON1bits.ASAM = 1;
      while (!IFS0bits.ADIF);
      ADCON1bits.ASAM = 0;
      //++ADC16Ptr;
      for (count = 1; count < 16; count++)
          soma = soma + *ADC16Ptr++;
      conv = (float)(soma);
      conv = conv/16;
      pot  = conv*(4.5)/1023;
      Delay_ms(350);
}

//Parte da Criatividade

//Variaveis de Criatividade
float velocidades[4] = {0.25, 0.5, 0.75, 1};
float valores[4] = {1.0475,  2.095, 3.1425, 4.19};
char perigo[10] = "PERIGO!!!";
char venti_vel[4][25] = {"VElOCIDADE 1 - 25%",
                         "VElOCIDADE 2 - 50%",
                         "VElOCIDADE 3 - 75%",
                         "VElOCIDADE 4 - 100%"};
int flag_criat = 0;
int flag_perigo = 0;

//Interrupcao para entrar no modo criatividade do sistema
void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
   delay_ms(100);
   IFS0bits.INT0IF = 0;
   if (flag_criat == 0){
     flag_criat = 1;
   }else{
     flag_criat = 0;
     };
}

//funcao que entra no estado de criatividade!!!
//Temos niveis de tensões que simbolizam o nivel de temperatura
//Na medida em qua a tensao no pot entra em cada um dos niveis um PWM é ativado
//Com um duty diferente para controlar o sistema
//Alem disso temos um limiar que para temperatura
//Qnd a temperatura passa desse limiar um aviso sonoro é emitido, os leds sim
//bolizam o problema e o PWM é setado para sua maior velocidade até que a tempe
//tura baixe novamente
void compara_cri(int cri_cri){
     if(cri_cri == 1){
       send_str("Estufa!");
       send_char('\n');
       if((pot >= 0)&&(pot < valores[0])){
        if (flag_perigo == 1){
          OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
          LATBbits.LATB0 = 1;
          LATBbits.LATB1 = 1;
          send_str(perigo);
          send_char('\n');
          LATDbits.LATD3 = 1;
          delay_ms(700);
          LATDbits.LATD3 = 0;
          send_str(venti_vel[3]);
          send_char('\n');}
        else{
          LATBbits.LATB0 = 0;
          LATBbits.LATB1 = 0;
          //OC1RS = 313;
          OC1RS = 1250;
          send_str(venti_vel[0]);
          send_char('\n');
        };
       };
       if((pot >= valores[0])&&(pot < valores[1])){
          if (flag_perigo == 1){
            OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
            LATBbits.LATB0 = 1;
            LATBbits.LATB1 = 1;
            send_str(perigo);
            send_char('\n');
            LATDbits.LATD3 = 1;
            delay_ms(700);
            LATDbits.LATD3 = 0;
            send_str(venti_vel[3]);
            send_char('\n');}
          else{
            LATBbits.LATB0 = 1;
            LATBbits.LATB1 = 0;
            //OC1RS = 625;
            OC1RS = 938;
            send_str(venti_vel[1]);
            send_char('\n');
          };
       };
       if((pot >= valores[1])&&(pot < valores[2])){
          if (flag_perigo == 1){
            OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
            LATBbits.LATB0 = 1;
            LATBbits.LATB1 = 1;
            send_str(perigo);
            send_char('\n');
            LATDbits.LATD3 = 1;
            delay_ms(700);
            LATDbits.LATD3 = 0;
            send_str(venti_vel[3]);
            send_char('\n');}
          else{
            LATBbits.LATB0 = 0;
            LATBbits.LATB1 = 1;
            OC1RS = 625;
            //OC1RS = 938;
            send_str(venti_vel[2]);
            send_char('\n');
        };
       };
       if((pot >= valores[2])&&(pot < valores[3])){
          if (flag_perigo == 1){
            OC1RS = 313; //Ventilador na Velocidade máxima para resfriar o sistema
            LATBbits.LATB0 = 1;
            LATBbits.LATB1 = 1;
            send_str(perigo);
            send_char('\n');
            LATDbits.LATD3 = 1;
            delay_ms(700);
            LATDbits.LATD3 = 0;
            send_str(venti_vel[3]);
            send_char('\n');}
          else{
            LATBbits.LATB0 = 1;
            LATBbits.LATB1 = 1;
            OC1RS = 313;
            // OC1RS = 1250;
            send_str(venti_vel[0]);
            send_char('\n');
          };
       }

       if(flag_perigo == 1){

       };
     }
     if(cri_cri == 0){
        OC1RS = 1250;
        LATBbits.LATB0 = 0;
        LATBbits.LATB1 = 0;
     };
}


//Configuracao dos Registradores e PORTAS usadas pelo PROGRAMA
void Init_ADC(){
    //Configruação dos registradores  AD e das PORTAS
    ADPCFG = 0xFFFF;
    ADPCFGbits.PCFG0 = 1;
    ADPCFGbits.PCFG1 = 1;
    ADPCFGbits.PCFG6 = 0;
    ADPCFGbits.PCFG7 = 0;
    ADPCFGbits.PCFG8 = 0;
    IFS0 = 0;
    IFS1 = 0;
    TRISB = 0;
    LATBbits.LATB0 = 0;
    LATBbits.LATB1 = 0;
    TRISE = 0x0100;
    TRISBbits.TRISB6 = 1;
    TRISBbits.TRISB7 = 1;
    TRISBbits.TRISB8 = 1;
    TRISD = 0;
    ADCON1 = 0;
    ADCON1bits.SSRC = 0b010; // Sincando o tempo de conversao com o timer 3

    //Configurando o timer para 8kHz sem psk
    TMR3 = 0x0000;
    PR3 = 1500;
    T3CON = 0x8000;

    // Conectando o canal as entradas em que estão os sensores
    ADCHS = 0x0002; // Connect RB2/AN2 as CH0 input ..
    ADCSSL = 0;
    ADCON3 = 0x0007;
    ADCON3bits.ADCS = 8;
    ADCON3bits.SAMC = 32;
    ADCON2 = 0;
    ADCON2bits.SMPI = 0b1111;
    ADCON1.ADON = 1;
    IEC0bits.INT0IE = 1;
    INTCON2bits.INT0EP = 0;

    T2CON = 0x8030;
    PR2 = 1250;
    OC1CON = 0x0006;
    OC1RS = 0;


}

//Variaveis Responsaveis para guardar a string com os numeros formatados do jeito
//escolhido
char txt1[10] = "0";
char txt2[10] = "0";
char txt3[10] = "0";

void main() {
    Init_ADC();
    Init_UART2(51); // UBRG = int((16000000/(16*19200)) - 1) -> FCY = 16000000 = 1/MIPS
    while(1){
       delay_ms(100);
       conversaoAD();
       sprintf(txt1, "%.2f", temp);
       sprintf(txt3, "%.2f", pot);
       sprintf(txt2, "%.2f", LDR);
       send_str("Temp\t        LDR\tPOT");
       send_char('\n');
       send_str(txt1);
       send_str("°C ");
       //send_char('\n');
       send_char('\t');
       send_str(txt2);
       send_str("V");
       send_char('\t');
       send_str(txt3);
       send_str("V");
       send_char('\n');
       if (temp > 40){flag_perigo = 1;}
       else{flag_perigo = 0;};
       compara_cri(flag_criat);
       delay_ms(200);
    }
}