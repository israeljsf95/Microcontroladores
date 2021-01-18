// conexoes do LCD
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

unsigned ADCValue;
int *ADC16Ptr;
int count, flag_seleciona, flag_botao, contador_tempo;
float conv, media;
char txt[16];
char txt1[]= "Sampling Time";  //Texto do Lcd 1 linha
char txtmeioseg[] = "0.5 s   ";
char txtumseg[] = "1 s    ";
char txtdezseg[] = "10 s   ";
char txtummin[] = "1 min   ";
char txtumahora[] = "1 hora   ";

void botao_1() iv IVT_ADDR_INT0INTERRUPT{

}

void timer_1_conv() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{
    T1CON = 0x0000;
    LCD_Out(1,1,"Entrei");
    IFS0bits.T1IF = 0;
    ADCValue = 0; // clear value
    ADC16Ptr = &ADCBUF0; // initialize ADCBUF pointer
    IFS0bits.ADIF = 0; // clear ADC interrupt flag
    ADCON1bits.ASAM = 1; // auto start sampling
    // for 31Tad then go to conversion
    while (!IFS0bits.ADIF); // conversion done?
    ADCON1bits.ASAM = 0; // yes then stop sample/convert
    for (count = 0; count < 16; count++) // average the 2 ADC value
        ADCValue = ADCValue + *ADC16Ptr++;
    conv = (float)(ADCValue);
    media = conv/16;
    T1CON = 0x8000;
}
/*
void menu(){
    if (flag_seleciona == 0){
              switch(flag_botao){
                  case 0:
                       Lcd_Out(2,1,txtmeioseg);
                       break;
                  case 1:
                       Lcd_Out(2,1,txtumseg);
                       break;
                  case 2:
                       Lcd_Out(2,1,txtdezseg);
                       break;
                  case 3:
                       Lcd_Out(2,1,txtummin);
                       break;
                  case 4:
                       Lcd_Out(2,1,txtumahora);
                       break;
                  default:
                       break;
              }
              Lcd_Out(1,1,txt1);
          }else{
              switch(flag_botao){
                  case 0:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 1:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 2:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
             case 3:
                if (contador_tempo == PRs[flag_botao]){
                       contador_tempo = 0;
                }
                break;
             case 4:
                if (contador_tempo == PRs[flag_botao]){
                   contador_tempo = 0;
                }
                break;
             default:
             break;
       }
    }
}
*/



void main() {
    ADPCFG = 0xFFFF; // all PORTB = Digital but RB7 = analog
    ADPCFGbits.PCFG2 = 0;
    ADPCFGbits.PCFG5 = 0;
    ADPCFGbits.PCFG7 = 0;

    TRISEbits.TRISE8 = 1;
    IEC0bits.INT0IE = 1;
    IFS0 = 0;

     // ADPCFG = 0xFFFB; // all PORTB = Digital; RB2 = analog
    ADCON1 = 0;
    ADCON1bits.SSRC = 0b010; // SSRC bit = 111 implies internal

    TMR3 = 0x0000;
    PR3 = 2000;
    T3CON = 0x8000;

    // counter ends sampling and starts
    // converting.
    ADCHSbits.CH0SA = 0b0010; // Connect RB2/AN2 as CH0 input ..
    // in this example RB2/AN2 is the in
    ADCSSL = 0;
    ADCON3 = 0x0007; // Sample time = 15Tad, Tad = intern
    ADCON2 = 0;
    ADCON2bits.SMPI = 0b1111; // Interrupt after every 16 samples
    ADCON1.ADON = 1;
    
    //Configurando o Timer para 0.5
    
    TMR1 = 0x0000;
    PR1 = 30048;
    T1CON = 0x8000;
    T1CONbits.TCKPS = 0b11;
    IEC0bits.T1IE = 1;
    IFS0bits.T1IF = 0;
    
    //LCD
     Lcd_Init();               // Initializa o LCD
     Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
     Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
    
    while(1){
      Lcd_Out(1,1,"Conv");
      FloatToStr(media, txt);
      Lcd_Out(2,1, txt);
    }
    
    
}