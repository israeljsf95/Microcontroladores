// LCD module connections
     sbit LCD_RS at LATE5_bit;
     sbit LCD_EN at LATE4_bit;
     sbit LCD_D4 at LATE3_bit;
     sbit LCD_D5 at LATE2_bit;
     sbit LCD_D6 at LATE1_bit;
     sbit LCD_D7 at LATE0_bit;
     sbit LCD_RS_Direction at TRISE5_bit;
     sbit LCD_EN_Direction at TRISE4_bit;
     sbit LCD_D4_Direction at TRISE3_bit;
     sbit LCD_D5_Direction at TRISE2_bit;
     sbit LCD_D6_Direction at TRISE1_bit;
     sbit LCD_D7_Direction at TRISE0_bit;
// End LCD module connections

#define sensor TRISBbits.TRISB2
int aa = 0;
int ADCValue, count;
int *ADC16Ptr;
float conversao, armazena, media_temp, temperatura;
float fahr, kel;
//float vetor[16];
unsigned char txt[15];
unsigned char txt1[15];
unsigned char txt2[15];


void BOTAO1int() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
     delay_ms(50);
     ADCValue = 0; // valor que guadara a convesao
     ADC16Ptr = &ADCBUF1; // recebe o endereco de memoria do BUF0 do modulo AD
     IFS0bits.ADIF = 0; // flag AD recebe zero
     ADCON1bits.ASAM = 1; // Auto amostragem
     //
     while (!IFS0bits.ADIF); // Espera a conversao ser feita
     ADCON1bits.ASAM = 0; // faz o modulo parar a conversao
     for (count = 1; count < 16; count++) // Adicao dos valores em cada conversao
           ADCValue = ADCValue + *ADC16Ptr++; //Acessando o valor dos buff usando aritmetica de ponteiro acessando o valor guardado atraves do operador de desreferencia(*)
     conversao = (float)(ADCValue);
     media_temp  = conversao/15;
     temperatura = 100*((media_temp*5)/1023);
     fahr =    (9/5)*temperatura + 32;
     kel = temperatura + 273;
     IFS0.INT0IF = 0;

}

//Processamento da INT02
int flag_bot = 0;
void BOTAO2int() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
      delay_ms(50);
      IFS1bits.INT2IF = 0;
      flag_bot++;
      if (flag_bot>1){
         flag_bot = 0;
      }
}

//Amostragem manual do conversor A/D
void inicializa(){
             ADCON1 = 0;           // controle de sequencia de conversão manual
             ADCSSL = 0;           // não é requerida a varredura ou escaneamento
             ADCON2 = 0;           // usa MUXA, AVdd e AVss são usados como Vref+/-
             ADCON3 = 0x0007;      // Tad = 4 x Tcy = 4* 62,5ns = 250 ns > 153,85 ns (quando Vdd = 4,5 a 5,5V); SAMC = 0 (não é levado em consideração quando é conversão manual)
             ADCON1bits.ADON = 1;  // liga o ADC
}

int leitura(int canal){
             ADCHSbits.CH0SA = canal;  // seleciona canal de entrada analógica (sample and hold)
             ADCON1bits.SAMP = 1;      // começa amostragem
             delay_us(125);            // tempo de amostragem para frequência de 8KHz.
             ADCON1bits.SAMP = 0;      // começa a conversão
             while (!ADCON1bits.DONE); // espera que complete a conversão
             return ADCBUF0;           // le o resultado da conversão.
}
//fim amostragem manual do conversor A/D

void main() {
     ADPCFG = 0xFFFF;                // Todas as portas digitais
     ADPCFGbits.PCFG2 = 0;           // PORTA 8 ANALOGICA

     sensor = 1;
     TRISEbits.TRISE8 = 1;         //SETANDO COMO ENTRADA PARA O BOTAO
     IEC0bits.INT0IE = 1;          //ATIVANDO A INTErrupcao externa int0
     IEC1bits.INT2IE = 1;          //ATIVANDO A INTErrupcao externa int2
     IFS0 = 0;
     INTCON2 = 0;
     INTCON2bits.INT0EP = 1;       //ATIVADO NA BORDA de DESCIDA
     INTCON2bits.INT2EP = 0;       //ATIVADO NA BORDA de SUBIDA
     IFS0bits.INT0IF = 0;          //ZErando a flag da int0
     IFS1bits.INT2IF = 0;          //ZErando a flag da int2

     ADCON1 = 0;
     ADCON1bits.SSRC = 0b010; // SSRC bit = Sinca  clock de conversao do modulo AD com o TIMER 3

     TMR3 = 0x0000;
     PR3 = 16000;
     T3CON = 0x8000;

     // counter ends sampling and starts
     // converting.
     ADCHS = 0x0002; // Conectando a entrada 8 ao canal 0 para conversao
     // in this example RB8/AN8 is the in
     ADCSSL = 0;
     ADCON3 = 0x0007; // Periodo de Amostragem
     ADCON2 = 0;
     ADCON2bits.SMPI = 0b1111; // Configuracao para fazer 16 conversoes e libera a flag do AD
     ADCON1.ADON = 1;
     Lcd_Init();               // Initializa o LCD
     Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
     Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
     Lcd_Out(1,1,"Temperatura");

     while(1){
        if (flag_bot == 0){
           Lcd_Cmd(_LCD_CLEAR);
           Lcd_Out(1,1,"Temperatura");
           FloatToStr(temperatura, txt);
           txt[5]=0;
           Lcd_Out(2,1,txt);
           Lcd_Out(2,7,"Celsius");
           delay_ms(500);
        }else if (flag_bot == 1){
           Lcd_Cmd(_LCD_CLEAR);
           Lcd_Out(1,1,"Temp:");
           FloatToStr(temperatura, txt);
           txt[5]=0;
           Lcd_Out(1,7,txt);
           Lcd_Out(1,11,"C");
           FloatToStr(fahr, txt1);
           txt1[5]=0;
           Lcd_Out(2,1,txt1);
           Lcd_Out(2,7,"F");
           FloatToStr(kel, txt2);
           txt2[5]=0;
           Lcd_Out(2,9,txt2);
           Lcd_Out(2,14,"K");
           delay_ms(500);
        }

     }
}