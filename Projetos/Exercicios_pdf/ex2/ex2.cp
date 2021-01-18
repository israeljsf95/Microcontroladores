#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/ex2/ex2.c"
void main() {
 ADPCFG=0xFFFF;
 TRISB=0;
 LATB=0;
 while(1){
 LATB= 0x81;
 Delay_ms(250);
 LATB=0;
 Delay_ms(250);
 LATB= 0x42;
 Delay_ms(250);
 LATB=0;
 Delay_ms(250);
 LATB= 0x24;
 Delay_ms(250);
 LATB=0;
 Delay_ms(250);
 LATB= 0x18;
 Delay_ms(250);
 LATB=0;
 Delay_ms(250);
 }
}
