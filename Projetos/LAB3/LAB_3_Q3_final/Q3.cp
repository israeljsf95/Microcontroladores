#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/LAB_3_Q3_final/Q3.c"

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



int aa = 0;
int ADCValue, count;
int *ADC16Ptr;
float conversao, armazena, media_temp, temperatura;
float fahr, kel;

unsigned char txt[15];
unsigned char txt1[15];
unsigned char txt2[15];


void BOTAO1int() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 delay_ms(50);
 ADCValue = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;

 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 ADCValue = ADCValue + *ADC16Ptr++;
 conversao = (float)(ADCValue);
 media_temp = conversao/15;
 temperatura = 100*((media_temp*5)/1023);
 fahr = (9/5)*temperatura + 32;
 kel = temperatura + 273;
 IFS0.INT0IF = 0;

}


int flag_bot = 0;
void BOTAO2int() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
 delay_ms(50);
 IFS1bits.INT2IF = 0;
 flag_bot++;
 if (flag_bot>1){
 flag_bot = 0;
 }
}


void inicializa(){
 ADCON1 = 0;
 ADCSSL = 0;
 ADCON2 = 0;
 ADCON3 = 0x0007;
 ADCON1bits.ADON = 1;
}

int leitura(int canal){
 ADCHSbits.CH0SA = canal;
 ADCON1bits.SAMP = 1;
 delay_us(125);
 ADCON1bits.SAMP = 0;
 while (!ADCON1bits.DONE);
 return ADCBUF0;
}


void main() {
 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG2 = 0;

  TRISBbits.TRISB2  = 1;
 TRISEbits.TRISE8 = 1;
 IEC0bits.INT0IE = 1;
 IEC1bits.INT2IE = 1;
 IFS0 = 0;
 INTCON2 = 0;
 INTCON2bits.INT0EP = 1;
 INTCON2bits.INT2EP = 0;
 IFS0bits.INT0IF = 0;
 IFS1bits.INT2IF = 0;

 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;

 TMR3 = 0x0000;
 PR3 = 16000;
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
