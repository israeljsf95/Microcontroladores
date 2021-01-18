#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/DEBUG/d_led/teste1.c"
void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;

 while(1){
 LATB = 0b111111111;
 }
}
