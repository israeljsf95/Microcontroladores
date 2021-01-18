#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/ex2/ex2.c"



void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 while(1){
 LATB = 255;
 Delay_ms(1000);
 LATB = 0;
 Delay_ms(1000);
 }
}
