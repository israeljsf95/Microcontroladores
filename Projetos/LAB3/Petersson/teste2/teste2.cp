#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste2/teste2.c"

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
#line 70 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste2/teste2.c"
}

void main() {
 flag_canal = 0;

 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG5 = 0;
 ADPCFGbits.PCFG7 = 0;

 TRISEbits.TRISE8 = 1;
 IEC0bits.INT0IE = 1;
 IFS0 = 0;


 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;

 TMR3 = 0x0000;
 PR3 = 2000;
 T3CON = 0x8000;



 ADCHS = 0x0002;

 ADCSSL = 0;
 ADCON3 = 0x0007;
 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;

 ADCON1.ADON = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 ADCON1bits.ASAM = 1;
 while (1)
 {
 ADCValue = 0;
 ADC16Ptr = &ADCBUF0;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;

 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 0; count < 16; count++)
 ADCValue = ADCValue + *ADC16Ptr++;
 ADCValue = ADCValue >> 1;
 ADCValue = ADCValue >> 1;
 ADCValue = ADCValue >> 1;
 ADCValue = ADCValue >> 1;
#line 132 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste2/teste2.c"
 ADCON1bits.ASAM = 1;

 }
#line 149 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste2/teste2.c"
}
