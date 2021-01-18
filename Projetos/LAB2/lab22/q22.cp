#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab22/q22.c"




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


long int frequencia = 0;
char txt[16];

char hertz[3] = {'H','z',' '};
char khertz[3] = {'k','H','z'};
char mhertz[3] = {'M','H','z'};

int cont_int = 1;




void INT2Int() iv IVT_ADDR_INT2INTERRUPT{

 cont_int++;


 if (cont_int > 3){
 cont_int = 1;
 }

 if (cont_int == 1){
 PR1 = 62500;
 T1CON = 0x8030;

 }

 if (cont_int == 2){
 PR1 = 250;
 T1CON = 0x8020;

 }

 if (cont_int == 3){
 PR1 = 16;
 T1CON = 0x8000;

 }
 TMR2 = 0;
 IFS1 = 0;

}




void Frequencimetro() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
 IFS0bits.T2IF = 0;
}

void janela_de_tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 frequencia = TMR2;
 TMR2 = 0;
 IFS0 = 0;
}

long int x = 250;

void main() {

 ADPCFG = 0xFFFF;
 TRISE = 0;
 TRISB = 0;
 TRISC = 0;
 TRISD = 0;

 TRISDbits.TRISD1 = 1;

 TRISCbits.TRISC14 = 1;

 Lcd_Init();



 IFS0 = 0;
 IFS1 = 0;

 IEC0 = 0;
 IEC1 = 0;

 IEC0bits.T2IE = 1;
 IEC0bits.T1IE = 1;

 IEC1bits.INT2IE = 1;
 INTCON2bits.INT2EP = 0;

 PR2 = 0xFFFF;
 PR1 = 62500;

 T2CON = 0x8002;
 T1CON = 0x8030;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 while(1){
 LongToStr(TMR2, txt);
#line 128 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab22/q22.c"
 Lcd_Out(1,2,txt);
 }

}
