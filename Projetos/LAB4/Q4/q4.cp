#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB4/Q4/q4.c"


int *ADC16Ptr;
int media[3];
int canais[3] = {0b0010, 0b0101, 0b0111};
float pot = 0;
float temp = 0;
float ldr = 0;

char txt_pot[8];
char txt_temp[8];
char txt_ldr[8];


void init_uart2(unsigned char baud_rate)
{
 U2BRG = baud_rate;
 U2MODE = 0;
 U2STA = 0;
 IFS1bits.U2TXIF = 0;
 IEC1bits.U2TXIE = 0;
 IFS1BITS.U2RXIF = 0;
 IEC1bits.U2RXIE = 0;
 U2MODEbits.UARTEN = 1;
 U2STAbits.UTXEN = 1;
}
#line 36 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB4/Q4/q4.c"
void nFloatToStr(float f, short p, char *txt)
{
 unsigned long result;
 char sign = ((char *)&f)[2].B7;
 unsigned long factor = 10;
 short i = p, j = 0;

 while (i--)
 factor *= 10;

 ((char *)&f)[2].B7 = 0;

 result = ((unsigned long)(f * factor) + 5) / 10;

 do
 {
 txt[j++] = result % 10 + '0';
 if (--p == 0)
 txt[j++] = '.';
 } while (((result /= 10) > 0) || (p > 0));

 if (txt[j - 1] == '.')
 txt[j++] = '0';

 if (sign)
 txt[j++] = '-';

 txt[j] = '\0';

 for (i = 0, j--; i < j; i++, j--)
 p = txt[i], txt[i] = txt[j], txt[j] = p;
}


int i, j, soma;
void converter()
{
 for (i = 0; i < 3; i++)
 {
 ADCHSbits.CH0SA = canais[i];
 soma = 0;
 ADC16Ptr = &ADCBUF0;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF)
 ;
 ADCON1bits.ASAM = 0;
 for (j = 0; j < 16; j++)
 {
 soma = soma + *ADC16Ptr++;
 soma = soma >> 1;
 }
 media[i] = soma;
 }
 temp = media[1] * 0.488758;
 ldr = media[2] * 5 / 1023;
 pot = media[0] * 5 / 1023;
 nFloatToStr(temp, 2, txt_temp);
 nFloatToStr(ldr, 2, txt_ldr);
 nFloatToStr(pot, 2, txt_pot);
}




void main()
{

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

 IEC0bits.T1IE = 1;


 TMR1 = 0x0000;
 PR1 = 31250;
 T1CON = 0x8030;

 T1CONbits.TCKPS = 0b11;
 IEC0bits.T1IE = 1;
 IFS0bits.T1IF = 0;
 while (1)
 {
 converter();
#line 160 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB4/Q4/q4.c"
 }
}
