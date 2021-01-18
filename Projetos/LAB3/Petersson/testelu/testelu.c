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

#define sensor TRISBbits.TRISB8
int aa = 0;
float conversao, armazena, media_temp, temperatura;
//float vetor[16];
unsigned char txt[15];

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
     ADPCFG = 0xFFFF;   // O registrador RB8 está configurado como entrada analógica
     ADPCFGbits.PCFG8;
     TRISB = 0;         // define todos os pinos de B como saída (exceto o 8 q será definido como entrada a seguir)

     sensor = 1;        // pino do sensor (RB8) definido como entrada (de temperatura)
     inicializa();

     Lcd_Init();               // Initializa o LCD
     Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
     Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor

     while(1){
              Lcd_Cmd(_LCD_CLEAR);      // Limpa o display

              for(aa = 0; aa < 16; aa++){
                                           // lê o canal 8 (onde está o sensor)
                    armazena = leitura(8);               //aqui ele armazena no buffer o valor medido pelo sensor (em tensão)
                    temperatura += (float)((armazena*5)/1023);  //faz o calculo da temperatura
                    //vetor[aa] = temperatura;

              }

              media_temp = temperatura/16;
              FloatToStr(media_temp,txt);

              Lcd_Out(1,1,"Temperatura");
              Lcd_Out(2,1,txt);
              delay_ms(500);
     }

     /*FloatToStr(media_temp,txt);
     Lcd_Out(1,1,"Temperatura");
     Lcd_Out(2,1,txt);  */
}