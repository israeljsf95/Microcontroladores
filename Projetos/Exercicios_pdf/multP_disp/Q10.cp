#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/multP_disp/Q10.c"

unsigned int num[10]={0b01000000,0b01111001,0b00100100,0b00110000,0b00011001,0b00010010,0b00000010,0b01111000,0b00000000,0b00010000};

unsigned int i=0;
unsigned int contu=0;
unsigned int contd=0;
unsigned int contc=0;
unsigned int contm=0;

void main() {
ADPCFG=0xFFFF;
 TRISD = 0;
 LATD = 0;
 TRISB = 0;
 LATB = 0;

 do{

 for(i=0; i <= 5; i++){

 LATDbits.LATD0 = 0;
 LATB = num[contu];
 Delay_ms(0.5);
 LATDbits.LATD0 = 1;

 LATDbits.LATD1 = 0;
 LATB = num[contd];
 Delay_ms(1000);
 LATDbits.LATD1 = 1;

 LATDbits.LATD2 = 0;
 LATB = num[contc];
 Delay_ms(1000);
 LATDbits.LATD2 = 1;

 LATDbits.LATD3 = 0;
 LATB = num[contm];
 Delay_ms(1000);
 LATDbits.LATD3 = 1;
 }
 contu++;
 if (contu==10){
 contu=0;
 contd++;
 }
 if (contd==10){
 contd=0;
 contc++;
 }
 if (contc==10){
 contc=0;
 contm++;
 }
 if (contm==10){
 contm=0;
 }
 }while(1);
}
