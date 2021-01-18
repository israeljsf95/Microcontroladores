#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab2_Q3/LAB2_Q3.c"

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




float long dist_cm;
unsigned char txt[15];
unsigned char txt2[15];


int massa_max;
int massa_min;


int flag;
int tempo;
int long altura;
int flag_criatividade;

void criatividade() iv IVT_ADDR_INT2INTERRUPT ics ICS_AUTO {
 Delay_ms(50);

 flag_criatividade++;

 if (flag_criatividade > 2){
 flag_criatividade = 0;
 }

 IFS1bits.INT2IF = 0;
}

void distancia() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 IFS0bits.T1IF = 0;
 dist_cm = (TMR1*0.272);
 TMR1 = 0;
}

void temporizador() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
 tempo--;
 if (tempo == 0){
 T2CON = 0x0000;
 TMR2 = 0;
 tempo = 10;
 flag = 0;
 }
 IFS0bits.T2IF = 0;
}


void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 Delay_ms(50);
 if (flag == 1){
 T2CON = 0x0000;
 TMR2 = 0;
 flag = 0;
 tempo = 10;
 }else{
 T2CON = 0x8030;
 flag = 1;
 }
 IFS0bits.INT0IF = 0;
}



void main() {
 ADPCFG = 0xFFFF;
 IFS0 = 0;
 flag = 0;
 tempo = 10;
 flag_criatividade = 0;

 TRISD = 0;
 TRISE = 0;
 TRISEbits.TRISE8 = 1;
 TRISCbits.TRISC14 = 1;
 TRISDbits.TRISD1 = 1;

 IEC0bits.T1IE = 1;
 IEC0bits.INT0IE = 1;
 IEC0bits.T1IE = 1;
 IEC0bits.T2IE = 1;
 IEC1bits.INT2IE = 1;

 INTCON2bits.INT0EP = 0;
 INTCON2bits.INT2EP = 0;

 T2CON = 0x0000;
 TMR2 = 0;
 PR2 = 62500;

 PR1 = 0xFFFF;
 T1CON = 0x8070;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 if (flag_criatividade == 0){
 if (flag == 1){
 altura = 200 - dist_cm;
 IntToStr(altura,txt);
 IntToStr(tempo,txt2);
  LATDbits.LATD2  = 1;
 delay_us(15);
  LATDbits.LATD2  = 0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,txt);
 Lcd_Out(2,1,txt2);
 Lcd_out(1,8,"cm");
 delay_ms(500);
 }else{
 Lcd_Out(1,1,"Altura:                 ");
 Lcd_Out(2,1,"Tempo:                  ");
 }
 }else{

  LATDbits.LATD2  = 1;
 delay_us(15);
  LATDbits.LATD2  = 0;

 Delay_ms(500);

 altura = 200 - dist_cm;

 if(flag_criatividade == 1){
 Lcd_Cmd(_LCD_CLEAR);
 massa_min = floor(20.7*(altura*altura)/10000);
 massa_max = floor(24.9*(altura*altura)/10000);

 IntToStr(massa_max,txt);
 IntToStr(massa_min,txt2);

 ltrim(txt);
 ltrim(txt2);

 Lcd_Out(1,1,"Massa ideal Masc");
 Lcd_Out(2,1,txt2);
 Lcd_Out(2,3," Kg a ");
 Lcd_Out(2,9,txt);
 Lcd_Out(2,12,"Kg");

 }else if (flag_criatividade == 2){
 Lcd_Cmd(_LCD_CLEAR);
 massa_min = floor(19.1*(altura*altura)/10000);
 massa_max = floor(25.8*(altura*altura)/10000);

 IntToStr(massa_max,txt);
 IntToStr(massa_min,txt2);

 ltrim(txt);
 ltrim(txt2);

 Lcd_Out(1,1,"Massa ideal Femi");
 Lcd_Out(2,1,txt2);
 Lcd_Out(2,3," Kg a ");
 Lcd_Out(2,9,txt);
 Lcd_Out(2,12,"Kg");

 }
 }
 }
}
