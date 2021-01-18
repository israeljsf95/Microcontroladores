#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/ex1/MyProject.c"




unsigned char num;

void main() {

 ADPCFG=0xFFFF;

 TRISB=0;

 num=0x00;
 while(1){

 LATB=num;
 num=num+1;
 if (num>255)
 {
 num=0;
 }
 Delay_ms(500);

 }
}
