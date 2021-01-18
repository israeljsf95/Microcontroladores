#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/adc_ex1/ADC1.c"


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

unsigned char txt[15];
float tensao;
int convertido;

void main() {
 ADPCFG = 0xFEFF;
 TRISB = 0xFFFF;

 ADCON1 = 0;


 ADCON2 = 0;


 ADCON3 = 0x0007;
 ADCON3 = 0x000B;


 ADCHS = 0x0000;
 ADCHSbits.CH0SA = 8;

 ADCSSL = 0;
 ADCON1bits.ADON = 1;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 ADCON1bits.SAMP = 1;
 delay_us(10);
 ADCON1bits.SAMP = 0;
 while(!ADCON1bits.DONE);
 convertido = ADCBUF0;
 tensao = (convertido*5.0)/1023;
 FloatToStr(tensao, txt);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1, txt);
 delay_ms(500);
 }




}
