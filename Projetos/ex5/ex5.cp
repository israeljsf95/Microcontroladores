#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/ex5/ex5.c"






void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 TRISD = 255;
 LATB = 0;
 while(1)
 {
 if(PORTDbits.RD1 == 1){
 LATB = 255;

 }else {
 LATB = 0;
 }
 }

}
