#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/LAB_3_Q1_final/LAB3_Q1_final.c"

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

int soma;

int *ADC16Ptr;

float aux5;

int count, flag_seleciona, flag_botao, contador_tempo;

int PRs[5] = {1,2,20,120,7200};

float pot,temp,LDR;
char aux[4];
float media[3];

char txt[16];
char txt1[]= "Sampling Time   ";
char txtmeioseg[] = "0.5 s            ";
char txtumseg[] = "1 s                ";
char txtdezseg[] = "10 s              ";
char txtummin[] = "1 min              ";
char txtumahora[] = "1 hora               ";


void copystr(char *str,char *str2){
 str[0] = str2[0];
 str[1] = str2[1];
 str[2] = str2[2];
 str[3] = str2[3];
}

void botao_menu() iv IVT_ADDR_INT0INTERRUPT{

 flag_seleciona = 0;
 flag_botao++;
 if (flag_botao > 4)
 flag_botao = 0;
 Delay_ms(100);
 IFS0bits.INT0IF = 0;
}

float cria_temp,cria_pot,cria_LDR,threshold = 4;
char txt_cria[16];
char aux6[4];

void criatividade(){
 cria_temp = media[0]*0.488758;
 cria_LDR = media[1]*5/1023;
 cria_pot = media[2]*150/1023;

 Lcd_Out(1,1,"Temp    :");
 FloatToStr(cria_temp,txt);
 copystr(aux6,txt);
 Lcd_Out(1,10,aux6);

 Lcd_Out(2,1,"SetPoint:");
 FloatToStr(cria_pot,txt);

 copystr(aux6,txt);
 Lcd_Out(2,11,aux6);

 if ((cria_temp <= cria_pot + 1)&&(cria_temp >= cria_pot - 1)){
 LATBbits.LATB0 = 1;
 }else{
 LATBbits.LATB0 = 0;

 }
 if (cria_LDR <= threshold){
 LATBbits.LATB1 = 1;
 }else{
 LATBbits.LATB1 = 0;
 }
}

void botao_selecionado() iv IVT_ADDR_INT2INTERRUPT{

 flag_seleciona = flag_seleciona++;
 Delay_ms(100);
 IFS1bits.INT2IF = 0;
}
char aux20[2];

void timer_1_conv() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{

 IFS0bits.T1IF = 0;

 if (flag_seleciona >= 1){
 if(contador_tempo == PRs[flag_botao]-1){

 ADCHSbits.CH0SA = 0b0010;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 media[0] = soma/16;

 ADCHSbits.CH0SA = 0b0101;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 media[1] = soma/16;

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
 }

 temp = media[0]*0.488758;
 LDR = media[1]*5/1023;
 pot = media[2]*5/1023;

 if (flag_seleciona == 1){
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;
 Lcd_Cmd(_LCD_CLEAR);

 FloatToStr(temp, txt);
 txt[5] = 0;
 copystr(aux,txt);
 Lcd_Out(1,1, "T ");
 Lcd_Out(1,3, txt);
 Lcd_Out(1,7, "C ");

 FloatToStr(LDR, txt);
 txt[5] = 0;
 copystr(aux,txt);
 Lcd_Out(1,9, "LD ");
 Lcd_Out(1,12, txt);
 Lcd_Out(1,16, "V");

 if (pot <1){
 FloatToStr(pot, txt);
 aux20[0] = txt[0];
 aux20[1] = txt[2];
 txt[0] = '0';
 txt[2] = aux20[0];
 txt[3] = aux20[1];
 }else{
 FloatToStr(pot, txt);
 }
 txt[5] = 0;
 copystr(aux,txt);
 Lcd_Out(2,1, "PO ");
 Lcd_Out(2,4, aux);
 Lcd_Out(2,8, "V");

 IntToStr(contador_tempo/2, txt);
 Lcd_Out(2,9, txt);
 Lcd_Out(2,15, "  ");
 }
 }else{
 switch(flag_botao){
 case 0:
 Lcd_Out(2,1,txtmeioseg);
 break;
 case 1:
 Lcd_Out(2,1,txtumseg);
 break;
 case 2:
 Lcd_Out(2,1,txtdezseg);
 break;
 case 3:
 Lcd_Out(2,1,txtummin);
 break;
 case 4:
 Lcd_Out(2,1,txtumahora);
 break;
 default:
 break;
 }
 Lcd_Out(1,1,txt1);
 }

 contador_tempo++;
 if(contador_tempo >= PRs[flag_botao]){
 contador_tempo = 0;
 }
 T1CON = 0x8030;
}

char txt3[16];
char aux2[4];

void main() {
 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG2 = 0;
 ADPCFGbits.PCFG5 = 0;
 ADPCFGbits.PCFG7 = 0;


 TRISEbits.TRISE8 = 1;
 IEC0bits.INT0IE = 1;
 IFS0 = 0;

 TRISDbits.TRISD1 = 1;
 IEC1bits.INT2IE = 1;
 IFS1 = 0;

 TRISBbits.TRISB0 = 0;
 TRISBbits.TRISB1 = 0;

 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;

 TMR3 = 0x0000;
 PR3 = 2000;
 T3CON = 0x8000;



 ADCHSbits.CH0SA = 0b0010;

 ADCSSL = 0;
 ADCON3 = 0x0008;
 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;
 ADCON1.ADON = 1;

 flag_seleciona = 0;
 flag_botao = 0;

 IEC0bits.T1IE = 1;


 TMR1 = 0x0000;
 PR1 = 31250;
 T1CON = 0x8030;

 T1CONbits.TCKPS = 0b11;
 IEC0bits.T1IE = 1;
 IFS0bits.T1IF = 0;


 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 if (flag_seleciona > 1){
 criatividade();
 }
 }


}
