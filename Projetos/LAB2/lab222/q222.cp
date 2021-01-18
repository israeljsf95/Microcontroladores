#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab222/q222.c"



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


unsigned long int frequencia = 0;
unsigned long int frequencia1 = 0;
unsigned long int frequencia2 = 0;
unsigned long int frequencia_aux = 0;
int cont_int = 1;

char txt[16];
char txt2[16];
char txt_flag[6];


char hertz[3] = {'H','z',' '};
char khertz[3] = {'k','H','z'};
char mhertz[3] = {'M','H','z'};









int flag_c = 0;

void INT0_Int() iv IVT_ADDR_INT0INTERRUPT{
 Delay_ms(100);
 if (flag_c == 0){
 flag_c = 1;
 }else{
 flag_c = 0;
 }


 IFS0bits.INT0IF = 0;
}


void INT2_Int() iv IVT_ADDR_INT2INTERRUPT{
 Delay_ms(100);

 cont_int++;
 if (cont_int > 3){
 cont_int = 1;
 }
 IFS1bits.INT2IF = 0;
 TMR2 = 0;
 TMR3 = 0;
}



void janela_de_tempo() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {

 frequencia1 = TMR2;
 frequencia2 = TMR3;

 TMR2 = 0;
 TMR3 = 0;

 IFS0bits.T1IF = 0;

 IFS0bits.T3IF = 0;




}

void criatividade(int num){
 switch(num){
 case 0:
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;
 LATBbits.LATB2 = 0;
 LATBbits.LATB3 = 0;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 1:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 0;
 LATBbits.LATB2 = 0;
 LATBbits.LATB3 = 0;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 2:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 0;
 LATBbits.LATB3 = 0;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 3:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 0;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 4:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 1;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 5:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 1;
 LATBbits.LATB4 = 1;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 6:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 1;
 LATBbits.LATB4 = 1;
 LATBbits.LATB5 = 1;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 case 7:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 1;
 LATBbits.LATB4 = 1;
 LATBbits.LATB5 = 1;
 LATBbits.LATB6 = 1;
 LATBbits.LATB7 = 0;
 break;
 case 8:
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 LATBbits.LATB2 = 1;
 LATBbits.LATB3 = 1;
 LATBbits.LATB4 = 1;
 LATBbits.LATB5 = 1;
 LATBbits.LATB6 = 1;
 LATBbits.LATB7 = 1;
 break;
 default:
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;
 LATBbits.LATB2 = 0;
 LATBbits.LATB3 = 0;
 LATBbits.LATB4 = 0;
 LATBbits.LATB5 = 0;
 LATBbits.LATB6 = 0;
 LATBbits.LATB7 = 0;
 break;
 }
}

int criat;

void main() {

 ADPCFG = 0xFFFF;

 TRISB = 0;
 TRISD = 0x0002;
 TRISE = 0x0000;
 TRISEbits.TRISE8 = 1;
 IFS1bits.INT2IF = 0;
 IFS0bits.INT0IF = 0;
 IEC1bits.INT2IE = 1;
 IEC0bits.INT0IE = 1;
 INTCON2bits.INT2EP = 0;
 INTCON2bits.INT0EP = 0;


 IFS0bits.T1IF = 0;
 IFS0bits.T2IF = 0;
 IEC0bits.T1IE = 1;
 IEC0bits.T2IE = 1;
 T1CON = 0x8030;
 T2CON = 0x800A;

 PR1 = 62500;
 PR2 = 0xFFFF;
 PR3 = 0xFFFF;



 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 IPC0 = 0x7006;
 IPC1 = 0x0500;

 criat = 0;

 while(1){

 frequencia = frequencia1 + frequencia2*65536;
 if (cont_int == 1){
 if ((frequencia >= 0)&&(frequencia < 1000)){
 LongToStr((frequencia), txt);
 Lcd_Out(1, 1,txt);
 Lcd_Out(2, 11,"Hz  ");
 }else{
 Lcd_Out(1, 1, "           ");
 Lcd_Out(2, 11,"erro");
 if (flag_c == 1){
 criat = floor((frequencia / 1000));
 criatividade(criat);
 }
 }
 }

 if (cont_int == 2){
 frequencia_aux = floor(frequencia/1000);
 if ((frequencia_aux > 0)&&(frequencia_aux < 1000)){
 LongToStr((frequencia_aux), txt);
 Lcd_Out(1, 1,txt);
 Lcd_Out(2, 11, "kHz ");
 }else{
 Lcd_Out(1, 1, "          ");
 Lcd_Out(2, 11, "erro");
 if (flag_c == 1){
 criat = floor(frequencia/1000000);
 criatividade(criat);
 }
 }
 }

 if (cont_int == 3){
 frequencia_aux = floor(frequencia/1000000);
 if ((frequencia_aux >= 0)&&(frequencia_aux < 10)){
 LongToStr((frequencia_aux), txt);
 Lcd_Out(1,1,txt);
 Lcd_Out(2,11,"MHz ");
 }else{
 Lcd_Out(1,1,"          ");
 Lcd_Out(2,11,"erro");
 }
 }
 }
}
