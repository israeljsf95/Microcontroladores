#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/testelu/testelu.c"

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
float conversao, armazena, media_temp, temperatura;

unsigned char txt[15];


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
 ADPCFGbits.PCFG8;
 TRISB = 0;

  TRISBbits.TRISB8  = 1;
 inicializa();

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 Lcd_Cmd(_LCD_CLEAR);

 for(aa = 0; aa < 16; aa++){
 leitura(8);
 armazena = ADCBUF0;
 temperatura += (float)((armazena*5)/1023);


 }

 media_temp = temperatura/16;
 FloatToStr(media_temp,txt);

 Lcd_Out(1,1,"Temperatura");
 Lcd_Out(2,1,txt);
 delay_ms(500);
 }
#line 75 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/testelu/testelu.c"
}
