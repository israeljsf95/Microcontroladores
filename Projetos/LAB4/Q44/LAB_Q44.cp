#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB4/Q44/LAB_Q44.c"



float temp, pot, LDR, conv;

long int count, soma;

char str[8];


void Init_UART2(unsigned char valor_baud){
 U2BRG = valor_baud;
 U2MODE = 0x0000;
 U2STA = 0x0000;
 IFS1bits.U2TXIF = 0;
 IEC1bits.U2TXIE = 0;
 IFS1bits.U2RXIF = 0;
 IEC1bits.U2RXIE = 0;
 U2MODEbits.UARTEN = 1;
 U2STAbits.UTXEN = 1;
}


void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
 IFS1bits.U2TXIF = 0;
}


void send_char(unsigned char c){
 while( U2STAbits.UTXBF);
 U2TXREG = c;
}


void send_str(unsigned char* str){
 unsigned int i = 0;
 while(str[i])
 send_char(str[i++]);
}






int* ADC16Ptr;
void conversaoAD(){

 ADCHSbits.CH0SA = 0b0110;
 conv = 0;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;

 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 conv = (float)(soma);
 conv = conv/16;
 LDR = conv*(4.5)/1023;
 Delay_ms(350);

 ADCHSbits.CH0SA = 0b0111;
 conv = 0;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;
 ADC16Ptr;
 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 conv = (float)(soma);
 conv = conv/16;
 temp = 100*((conv*5)/1023);
 Delay_ms(350);

 ADCHSbits.CH0SA = 0b1000;
 conv = 0;
 soma = 0;
 ADC16Ptr = &ADCBUF1;
 IFS0bits.ADIF = 0;
 ADCON1bits.ASAM = 1;
 while (!IFS0bits.ADIF);
 ADCON1bits.ASAM = 0;

 for (count = 1; count < 16; count++)
 soma = soma + *ADC16Ptr++;
 conv = (float)(soma);
 conv = conv/16;
 pot = conv*(4.5)/1023;
 Delay_ms(350);
}




float velocidades[4] = {0.25, 0.5, 0.75, 1};
float valores[4] = {1.0475, 2.095, 3.1425, 4.19};
char perigo[10] = "PERIGO!!!";
char venti_vel[4][25] = {"VElOCIDADE 1 - 25%",
 "VElOCIDADE 2 - 50%",
 "VElOCIDADE 3 - 75%",
 "VElOCIDADE 4 - 100%"};
int flag_criat = 0;
int flag_perigo = 0;


void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 delay_ms(100);
 IFS0bits.INT0IF = 0;
 if (flag_criat == 0){
 flag_criat = 1;
 }else{
 flag_criat = 0;
 };
}









void compara_cri(int cri_cri){
 if(cri_cri == 1){
 send_str("Estufa!");
 send_char('\n');
 if((pot >= 0)&&(pot < valores[0])){
 if (flag_perigo == 1){
 OC1RS = 313;
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 send_str(perigo);
 send_char('\n');
 LATDbits.LATD3 = 1;
 delay_ms(700);
 LATDbits.LATD3 = 0;
 send_str(venti_vel[3]);
 send_char('\n');}
 else{
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;

 OC1RS = 1250;
 send_str(venti_vel[0]);
 send_char('\n');
 };
 };
 if((pot >= valores[0])&&(pot < valores[1])){
 if (flag_perigo == 1){
 OC1RS = 313;
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 send_str(perigo);
 send_char('\n');
 LATDbits.LATD3 = 1;
 delay_ms(700);
 LATDbits.LATD3 = 0;
 send_str(venti_vel[3]);
 send_char('\n');}
 else{
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 0;

 OC1RS = 938;
 send_str(venti_vel[1]);
 send_char('\n');
 };
 };
 if((pot >= valores[1])&&(pot < valores[2])){
 if (flag_perigo == 1){
 OC1RS = 313;
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 send_str(perigo);
 send_char('\n');
 LATDbits.LATD3 = 1;
 delay_ms(700);
 LATDbits.LATD3 = 0;
 send_str(venti_vel[3]);
 send_char('\n');}
 else{
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 1;
 OC1RS = 625;

 send_str(venti_vel[2]);
 send_char('\n');
 };
 };
 if((pot >= valores[2])&&(pot < valores[3])){
 if (flag_perigo == 1){
 OC1RS = 313;
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 send_str(perigo);
 send_char('\n');
 LATDbits.LATD3 = 1;
 delay_ms(700);
 LATDbits.LATD3 = 0;
 send_str(venti_vel[3]);
 send_char('\n');}
 else{
 LATBbits.LATB0 = 1;
 LATBbits.LATB1 = 1;
 OC1RS = 313;

 send_str(venti_vel[0]);
 send_char('\n');
 };
 }

 if(flag_perigo == 1){

 };
 }
 if(cri_cri == 0){
 OC1RS = 1250;
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;
 };
}



void Init_ADC(){

 ADPCFG = 0xFFFF;
 ADPCFGbits.PCFG0 = 1;
 ADPCFGbits.PCFG1 = 1;
 ADPCFGbits.PCFG6 = 0;
 ADPCFGbits.PCFG7 = 0;
 ADPCFGbits.PCFG8 = 0;
 IFS0 = 0;
 IFS1 = 0;
 TRISB = 0;
 LATBbits.LATB0 = 0;
 LATBbits.LATB1 = 0;
 TRISE = 0x0100;
 TRISBbits.TRISB6 = 1;
 TRISBbits.TRISB7 = 1;
 TRISBbits.TRISB8 = 1;
 TRISD = 0;
 ADCON1 = 0;
 ADCON1bits.SSRC = 0b010;


 TMR3 = 0x0000;
 PR3 = 1500;
 T3CON = 0x8000;


 ADCHS = 0x0002;
 ADCSSL = 0;
 ADCON3 = 0x0007;
 ADCON3bits.ADCS = 8;
 ADCON3bits.SAMC = 32;
 ADCON2 = 0;
 ADCON2bits.SMPI = 0b1111;
 ADCON1.ADON = 1;
 IEC0bits.INT0IE = 1;
 INTCON2bits.INT0EP = 0;

 T2CON = 0x8030;
 PR2 = 1250;
 OC1CON = 0x0006;
 OC1RS = 0;


}



char txt1[10] = "0";
char txt2[10] = "0";
char txt3[10] = "0";

void main() {
 Init_ADC();
 Init_UART2(51);
 while(1){
 delay_ms(100);
 conversaoAD();
 sprintf(txt1, "%.2f", temp);
 sprintf(txt3, "%.2f", pot);
 sprintf(txt2, "%.2f", LDR);
 send_str("Temp\t        LDR\tPOT");
 send_char('\n');
 send_str(txt1);
 send_str("°C ");

 send_char('\t');
 send_str(txt2);
 send_str("V");
 send_char('\t');
 send_str(txt3);
 send_str("V");
 send_char('\n');
 if (temp > 40){flag_perigo = 1;}
 else{flag_perigo = 0;};
 compara_cri(flag_criat);
 delay_ms(200);
 }
}
