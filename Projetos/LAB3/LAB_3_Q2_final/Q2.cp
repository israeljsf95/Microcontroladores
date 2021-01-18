#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/LAB_3_Q2_final/Q2.c"





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

int soma,count;
int *ADC16Ptr;
int media[3];
char txt[16];
float temp,LDR,pot;
int flag_criatividade;
float duty2,duty4;
char aux[2];
int PRx = 25000;

void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 Delay_ms(100);
 flag_criatividade = ~flag_criatividade;
 IFS0bits.INT0IF = 0;
}

void PWMmotor() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
 if(flag_criatividade == 0){
  LATBbits.LATB3  = ~ LATBbits.LATB3 ;
 }else{
  LATBbits.LATB0  = ~ LATBbits.LATB0 ;
 }
 IFS0bits.T2IF = 0;
}

void PWMleds() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {

 if(flag_criatividade == 0){
  LATBbits.LATB0  = ~ LATBbits.LATB0 ;
  LATBbits.LATB1  = ~ LATBbits.LATB1 ;
 }else{
  LATBbits.LATB1  = ~ LATBbits.LATB1 ;
 }

 IFS1bits.T4IF = 0;
}


void conversao_temporizada() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{

 IFS0bits.T1IF = 0;


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


 temp = (float)media[0]*0.488758;
 LDR = (float)media[1]*5/1023;
 pot = (float)media[2]*5/1023;

}

void main() {

 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG5 = 0;
 ADPCFGbits.PCFG7 = 0;

 TRISB = 0;
 TRISBbits.TRISB2 = 1;
 TRISBbits.TRISB5 = 1;
 TRISBbits.TRISB7 = 1;


 TRISEbits.TRISE8 = 1;
 IEC0bits.INT0IE = 1;
 IFS0 = 0;
 IFS1 = 0;


 ADCHSbits.CH0SA = 0b0010;
 ADCSSL = 0;

 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;

 TMR3 = 0x0000;
 PR3 = 2000;
 T3CON = 0x8000;

 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;
 ADCON3 = 0x0008;



 IEC0bits.T1IE = 1;
 TMR1 = 0x0000;
 PR1 = 31250;
 T1CON = 0x8030;



 IEC0bits.T2IE = 1;
 TMR2 = 0x0000;
 PR2 = PRx;
 T2CON = 0x8020;


 IEC1bits.T4IE = 1;
 TMR4 = 0x0000;
 PR4 = PRx;
 T4CON = 0x8020;


 flag_criatividade = 0;
  LATBbits.LATB0  = 0;
  LATBbits.LATB1  = 0;
  LATBbits.LATB3  = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 ADCON1.ADON = 1;

 while(1){
 Lcd_Cmd(_LCD_CLEAR);

 if(flag_criatividade == 0){
 duty2 = temp/100;
 duty4 = LDR/5;

 if ( LATBbits.LATB3  == 0){
 PR2 = floor((1 - duty2)*PRx);
 }else{
 PR2 = floor(duty2*PRx);
 }

 if ( LATBbits.LATB0  == 0){
 PR4 = floor((1 - duty4)*PRx);
 }else{
 PR4 = floor(duty4*PRx);
 }

 Lcd_Out(1,1,"Potenciometro       ");

 if (pot < 0.1){
 pot = 0;
 }

 FloatToStr(pot,txt);

 if (pot < 1){
 aux[0] = txt[0];
 aux[1] = txt[3];
 txt[0] = '0';
 txt[2] = aux[0];
 txt[3] = aux[1];
 }
 Lcd_Out(2,1,txt);
 Lcd_Out(2,5,"              ");

 }else{

 duty2 = pot/5;
 duty4 = LDR/5;

 if ( LATBbits.LATB0  == 0){
 PR2 = floor((1 - duty2)*PRx);
 }else{
 PR2 = floor(duty2*PRx);
 }

 if ( LATBbits.LATB1  == 0){
 PR4 = floor((1 - duty4)*PRx);
 }else{
 PR4 = floor(duty4*PRx);
 }

 if(temp > 40){
  LATBbits.LATB3  = 1;
 Lcd_Out(1,1,"      PERIGO       ");
 Lcd_Out(2,1,"    RESFRIANDO     ");
 }else{
 Lcd_Out(1,1,"    TEMPERATURA    ");
 Lcd_Out(2,1,"      NORMAL       ");
 }
 }
 Delay_ms(500);
 }
}
