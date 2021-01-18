#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/multP_disp/mult_disp.c"





unsigned int a1[5] = {0x09, 0x40, 0x47, 0x08, 0xFF};
unsigned int i;
unsigned int aux;
void main() {

 ADPCFG - 0XFFFF;
 TRISD = 0;
 LATD = 0;
 TRISB = 0;
 LATB = 0;


 do{

 for(i=0; i <= 35; i++){
 LATDbits.LATD0 = 0;
 LATB = a1[0];
 Delay_ms(2);
 LATDbits.LATD0 = 1;

 LATDbits.LATD1 = 0;
 LATB = a1[1];
 Delay_ms(2);
 LATDbits.LATD1 = 1;

 LATDbits.LATD2 = 0;
 LATB = a1[2];
 Delay_ms(2);
 LATDbits.LATD2 = 1; ;

 LATDbits.LATD3 = 0;
 LATB = a1[3];
 Delay_ms(2);
 LATDbits.LATD3 = 1;
 }
 aux = a1[0];
 a1[0] = a1[1];
 a1[1] = a1[2];
 a1[2] = a1[3];
 a1[3] = aux;



 }while(1);
}
