#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/LAB33/Q1.c"







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



char txt1[]= "Sampling Time";
char txtmeioseg[] = "0.5 s   ";
char txtumseg[] = "1 s    ";
char txtdezseg[] = "10 s   ";
char txtummin[] = "1 min   ";
char txtumahora[] = "1 hora   ";
int flag_botao = 0;
int flag_seleciona = 0;
int PRs[5] = {1,2,20,120,7200};
int contador_tempo = 0;
float soma_media = 0;
long media;
float temperatura;
float tensao;
float LDR;

char txt4[16],txt2[16],txt3[16];
#line 67 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/LAB33/Q1.c"
void temporizador() iv IVT_ADDR_T1INTERRUPT {
 contador_tempo++;
 IFS0bits.T1IF = 0;
}

int flag_ADC = 0;
int convertido[3] = {0,0,0};

void conversao() iv IVT_ADDR_ADCINTERRUPT {



 media = ADCBUFF;


 convertido[flag_ADC] = media;

 flag_ADC++;

 if (flag_ADC > 2){
 flag_ADC = 0;
 }

 if (flag_ADC == 0){
 ADCHSbits.CH0SA = 2;
 }else{
 if (flag_ADC == 1){
 ADCHSbits.CH0SA = 5;
 }else{
 ADCHSbits.CH0SA = 7;
 }
 }

 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
}

void botao() iv IVT_ADDR_INT0INTERRUPT {
 flag_botao++;
 contador_tempo = 0;
 flag_seleciona = 0;
 if (flag_botao > 4){
 flag_botao = 0;
 }
 Delay_ms(50);
 IFS0bits.INT0IF = 0;
}

void seleciona() iv IVT_ADDR_INT2INTERRUPT {
 flag_seleciona = 1;
 contador_tempo = 0;
 Delay_ms(50);
 IFS1bits.INT2IF = 0;
}

void temp3() iv IVT_ADDR_T3INTERRUPT ics ICS_AUTO {
 IFS0bits.T3IF = 0;
}

int main() {

 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG5 = 0;
 ADPCFGbits.PCFG7 = 0;

 TRISB = 0;
  LATBbits.LATB5  = 1;
  LATBbits.LATB7  = 1;
  LATBbits.LATB2  = 1;

 TRISD = 0;
 TRISDbits.TRISD1 = 1;
 TRISEbits.TRISE8 = 1;
 IEC0bits.INT0IE = 1;
 IEC1bits.INT2IE = 1;
 IEC0bits.T1IE = 1;
 IEC0bits.T3IE = 1;

 T1CON = 0x8030;
 PR1 = 31250;
 IFS0 = 0;

 ADCHS = 0;

 ADCHSbits.CH0SA = 2;

 ADCSSL = 0;

 ADCON1 = 0x0000;

 ADCON1bits.ASAM = 1;
 ADCON1bits.SSRC = 0b010;

 ADCON2 = 0x0000;

 ADCON2bits.SMPI0 = 1;
 ADCON2bits.SMPI1 = 1;
 ADCON2bits.SMPI2 = 1;
 ADCON2bits.SMPI3 = 1;

 ADCON3 = 0x0000;
 ADCON3bits.ADCS = 7;


 TMR3 = 0x0000;
 PR3 = 500;
 T3CON = 0x8010;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 ADCON1bits.ADON = 1;
 ADCON1bits.SAMP = 1;
 while(1){
#line 245 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/LAB33/Q1.c"
 IntToStr(convertido[0],txt4);
 IntToStr(convertido[1],txt2);
 IntToStr(convertido[2],txt3);

 Lcd_Out(1,1,txt4);
 Lcd_Out(1,8,txt2);
 Lcd_Out(2,1,txt3);


 }
 }
