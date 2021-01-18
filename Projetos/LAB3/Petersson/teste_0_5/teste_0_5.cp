#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste_0_5/teste_0_5.c"

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
char txt1[]= "Sampling Time";
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
 ADCValue = 0;
 ADC16Ptr = &ADCBUF0;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;

 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 0; count < 16; count++)
 ADCValue = ADCValue + *ADC16Ptr++;
 conv = (float)(ADCValue);
 media = conv/16;
 T1CON = 0x8000;
}
#line 108 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste_0_5/teste_0_5.c"
void main() {
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



 ADCHSbits.CH0SA = 0b0010;

 ADCSSL = 0;
 ADCON3 = 0x0007;
 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;
 ADCON1.ADON = 1;



 TMR1 = 0x0000;
 PR1 = 30048;
 T1CON = 0x8000;
 T1CONbits.TCKPS = 0b11;
 IEC0bits.T1IE = 1;
 IFS0bits.T1IF = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 Lcd_Out(1,1,"Conv");
 FloatToStr(media, txt);
 Lcd_Out(2,1, txt);
 }


}
