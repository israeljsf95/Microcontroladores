#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/PWM/PWM.c"





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

int flag_PWM;
int flag_PWM4;
float duty;
int PR1x;
int up;
int down;
int soma;
int *ADC16Ptr;
int count;
int media[3];
char txt[16];
char aux[2];
float conv;
float duty2;
int up2;
int down2;
int flag_criatividade;

void PWM_Motor() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 flag_PWM = ~flag_PWM;

 if (flag_criatividade == 0){
  LATBbits.LATB3  =~  LATBbits.LATB3 ;
 }

 IFS0bits.T1IF = 0;
}

void PWM_Led() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {
 flag_PWM4 = ~flag_PWM4;

  LATBbits.LATB0  =~  LATBbits.LATB0 ;
  LATBbits.LATB1  =~  LATBbits.LATB1 ;

 IFS1bits.T4IF = 0;
}

void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 flag_criatividade = ~flag_criatividade;
 Delay_ms(100);
 IFS0bits.INT0IF = 0;
}

void ADC() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {


 ADCHSbits.CH0SA = 0b0010;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 media[0] = soma/15;

 ADCHSbits.CH0SA = 0b0101;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 media[1] = soma/15;

 ADCHSbits.CH0SA = 0b0111;
 soma = 0;

 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 media[2] = soma/15;


 if (flag_criatividade == 0){
 IntToStr(media[2],txt);
#line 111 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/PWM/PWM.c"
 Lcd_Out(1,1,"Potenciometro");
 Lcd_Out(2,1,txt);


 }

 IFS0bits.T2IF = 0;
}


void main() {

 ADPCFG = 0xFFFF;
 TRISB = 0;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG5 = 0;
 ADPCFGbits.PCFG7 = 0;

 IFS0 = 0;

 IEC0bits.T1IE = 1;
 IEC0bits.T2IE = 1;
 IEC1bits.T4IE = 1;
 IEC0bits.INT0IE = 1;
 TRISEbits.TRISE8 = 1;
 TRISDbits.TRISD1 = 1;

 TRISBbits.TRISB0 = 0;
 TRISBbits.TRISB1 = 0;
 TRISBbits.TRISB3 = 0;


 flag_PWM = 0;
 PR1x = 25000;

 duty = 1;
 duty2 =1;

 up2 = PR1x*duty;
 down2 = PR1x - up2;

 up = PR1x*duty;
 down = PR1x - up;


 ADCSSL = 0;
 ADCHSbits.CH0SA = 0b0010;
 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;
 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;
 ADCON3 = 0x0008;


 PR1 = up;
 T1CON = 0x8020;

 PR4 = up2;
 T4CON = 0x8020;

 TMR3 = 0x0000;
 PR3 = 2000;
 T3CON = 0x8000;


 ADCON1.ADON = 1;

 T2CON = 0x8030;
 PR2 = 32500;

 flag_criatividade = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 duty = (float)media[0]*5/1023;

 duty2 = (float)media[1]/1023;

 if(flag_criatividade == 0){

 LATBbits.LATB4 = 0;
 up = PR1x*duty;
 down = PR1x - up+1;

 if(flag_PWM == 0){
 PR1 = down;
 }else{
 PR1 = up;
 }

 up2 = PR1x*duty2;
 down2 = PR1x - up2+1;

 if(flag_PWM4 == 0){
 PR4 = down2;
 }else{
 PR4 = up2;
 }

 }else{
 if(duty < 0.3){
 FloatToStr(duty,txt);
 Lcd_Out(1,1,txt);

 Lcd_Out(2,1,"     NORMAL     ");
 }else{
 FloatToStr(duty,txt);
 Lcd_Out(1,1,txt);
 Lcd_Out(2,1,"  RESFRIANDO   ");
 LATBbits.LATB4 = 1;
  LATBbits.LATB3  = 1;
 }

 }
 }
}
