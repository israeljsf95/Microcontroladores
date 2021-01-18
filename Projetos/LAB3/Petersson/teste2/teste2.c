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

unsigned int ADCValue;
char txt[16];
int flag_canal;
float convertido[3] = {0,0,0} ;

int count;
int *ADC16Ptr;

void botao_tempo() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
      IFS0bits.INT0IF = 0;
      Delay_ms(50);
}

void intADC() iv IVT_ADDR_ADCINTERRUPT ics ICS_AUTO {
   /*
     ADCON1bits.ASAM = 0;
     
     ADC16Ptr = &ADCBUF0;
     
     for (count = 0; count < 16; count++) // average the 2 ADC value
          ADCValue = ADCValue + *ADC16Ptr++;
          
     convertido[flag_canal] = ADCValue/15;
     
     flag_canal++;
     
     IFS0bits.ADIF = 0;
     ADCON1bits.ASAM = 1;

     if(flag_canal > 2){
         flag_canal = 0;
         ADCON1bits.ASAM = 0;
     }


     switch(flag_canal){
           case 0:
                ADCHSbits.CH0SA = 2;
           break;
           case 1:
                ADCHSbits.CH0SA = 5;
           break;
           case 2:
                ADCHSbits.CH0SA = 7;
           break;
           default:
           break;
      }
      
      

    */
}

void main() {
    flag_canal = 0;

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
    ADCHS = 0x0002; // Connect RB2/AN2 as CH0 input ..
    // in this example RB2/AN2 is the in
    ADCSSL = 0;
    ADCON3 = 0x0007; // Sample time = 15Tad, Tad = intern
    ADCON2 = 0;
    ADCON2bits.SMPI = 0b1111; // Interrupt after every 2 samples
    
    ADCON1.ADON = 1;

  
    Lcd_Init();                        // Initialize LCD
    Lcd_Cmd(_LCD_CLEAR);               // Clear display
    Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
    
    ADCON1bits.ASAM = 1;
    while (1) // repeat continuously
    {
       ADCValue = 0; // clear value
        ADC16Ptr = &ADCBUF0; // initialize ADCBUF pointer
        IFS0bits.ADIF = 0; // clear ADC interrupt flag
        ADCON1bits.ASAM = 1; // auto start sampling
        // for 31Tad then go to conversion
        while (!IFS0bits.ADIF); // conversion done?
        ADCON1bits.ASAM = 0; // yes then stop sample/convert
        for (count = 0; count < 16; count++) // average the 2 ADC value
            ADCValue = ADCValue + *ADC16Ptr++;
        ADCValue = ADCValue >> 1;
        ADCValue = ADCValue >> 1;
        ADCValue = ADCValue >> 1;
        ADCValue = ADCValue >> 1;


  /*    FloatToStr(ADCValue,txt);
      Lcd_Out(1,1,txt);
      FloatToStr(convertido[1],txt);
      Lcd_Out(1,9,txt);
      FloatToStr(convertido[2],txt);
      Lcd_Out(2,1,txt);*/
      ADCON1bits.ASAM = 1;
      
      }
  /*
  while (1) // repeat continuously
  {
      Delay_ms(1); // sample for 100 mS
      ADCON1bits.SAMP = 1; // start Converting
      while (!IFS0bits.ADIF); // conversion done?
            ADCValue = ADCBUF0; // yes then get ADC value
      IFS0bits.ADIF = 0;
      IntToStr(ADCValue,txt);
      Lcd_Out(1,1,txt);
      

      
  } // repeat  */
}