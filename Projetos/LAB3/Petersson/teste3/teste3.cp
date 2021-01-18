#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste3/teste3.c"
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

char txt[16];

int Valor;

void main() {

 ADPCFG = 0xFFFF;
 TRISBbits.TRISB2 = 1;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG2 = 0;

 ADCON1 = 0x0040;

 ADCON2 = 0x0004;
 ADCON2bits.SMPI = 0;

 ADCON3 = 0;

 ADCSSL = 0;
 ADCHS = 0x0002;

 TMR3 = 0x0000;
 PR3 = 0x3FFF;
 T3CON = 0x8010;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 ADCON1bits.ADON = 1;

 ADCON1bits.ASAM = 1;

 while(1){
 Delay_ms(1);
 while (!ADCON1bits.DONE);
 Valor = ADCBUF0;
 IFS0bits.ADIF = 0;

 IntToStr(txt,Valor);
 Lcd_Out(1,1,txt);
 }
}
