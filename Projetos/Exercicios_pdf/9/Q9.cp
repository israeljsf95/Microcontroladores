#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/9/Q9.c"



unsigned int num[10]={0b01000000,0b01111001,0b00100100,0b00110000,0b00011001,0b00010010,0b00000010,0b01111000,0b00000000,0b00010000};
unsigned int i;
unsigned int cont = 0;
void main() {
 ADPCFG=0xFFFF;
 TRISD = 0;
 LATD = 0;
 TRISB = 0;
 LATB = 0;
 TRISF = 1;
 while(1){

 LATDbits.LATD1 = 1;
 LATDbits.LATD2 = 1;
 LATDbits.LATD3 = 1;
 LATDbits.LATD0 = 0;
 while(PORTFbits.RF0 == 1){
 cont = 0;
 if (PORTFbits.RF0 == 0){
 cont = 0;
 break;
 }
 LATDbits.LATD1 = 1;
 LATDbits.LATD2 = 1;
 LATDbits.LATD3 = 1;
 LATDbits.LATD0 = 0;
 cont = 0;
 }
 for(i=0; i <= 50; i++){

 LATDbits.LATD0 = 0;
 LATB = num[cont];
 Delay_ms(100);
 LATDbits.LATD0 = 1;
 }
 cont++;
 if (cont==10){
 cont=0;
 }
 }


}
