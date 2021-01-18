#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/ex3/ex3.c"




unsigned char num[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
unsigned char j;
void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 while(1){
 for (j = 0; j < 8 ; j ++)
 {
 LATB = num[j];
 Delay_ms(1000);


 }
 }
}
