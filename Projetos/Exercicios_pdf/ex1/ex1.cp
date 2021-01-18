#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/ex1/ex1.c"


void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 LATB = 0;
 while(1){
 LATB = 0x0F;
 Delay_ms(250);
 LATB = 0xF;
 Delay_ms(250);
 LATB = 0;
 Delay_ms(250);
 }

}
