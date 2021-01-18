#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/teste/teste.c"
int ADCValue;


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

float tensao;
char txt[16];



void main(){
 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG7 = 1;

 TRISB = 0;
 TRISBbits.TRISB7 = 1;

 ADCON1 = 0x0000;
 ADCON2 = 0x0000;
 ADCON3 = 0x0000;

 ADCON2bits.VCFG = 0;
 ADCON3bits.ADCS = 7;
 ADCON2bits.CHPS = 0;
 ADCON1bits.SIMSAM = 0;
 ADCSSL = 0;
 ADCHS = 0;
 ADCHSbits.CH0SA = 0x0111;
 ADCON1bits.SSRC = 2;
 ADCON1bits.ASAM = 1;
 ADCON3bits.SAMC = 1;
 ADCON1bits.FORM = 0;
 ADCON2bits.SMPI = 15;

 TMR3 = 0x0000;
 PR3 = 500;
 T3CON = 0x8010;

 ADCON1bits.ADON = 1;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 while(!ADCON1bits.DONE){
 ADCValue = ADCBUF5;
 IFS0bits.ADIF = 0;
 }
 tensao = ADCValue;
 FloatToStr(tensao,txt);
 Lcd_Out(2,1,txt);
 }
}
