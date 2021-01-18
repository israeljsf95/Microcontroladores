#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/PWM_Motor/PWM_Motor.c"


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
unsigned char txt2[15];
float tensao;
float PWM_1;
int convertido;
int flag;

void PWM() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 if (flag == 0){
 PR1 = floor(32000*convertido/1023);
 }else{
 PR1 = floor(32000*(1 - convertido/1023));
 }
 flag =~flag;
 IFS0bits.T1IF = 0;
}

void main() {
 flag =0;
 ADPCFG = 0xFEFF;
 TRISB = 0xFFFF;

 IFS0 = 0;
 TMR1 = 0;
 IEC0bits.T1IE = 1;
 T1CON = 0x8000;
 PR1 = 32000;


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
 PWM_1 = floor(tensao*20);

 FloatToStr(tensao, txt);
 IntToStr(PWM_1, txt2);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1, txt);
 Lcd_Out(2,1, txt2);
 delay_ms(500);
 }
}
