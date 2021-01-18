#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/teste1/test1.c"
#line 1 "d:/bibliotecas_usuario/documentos/documentos/ufs/microcontroladores/projetos/lab1/teste1/char2bcd.h"
unsigned int bcd(char _char){
 unsigned int hexa = 0;
 switch(_char){
 case('a'):
 hexa=0x23;
 break;

 case('b'):
 hexa=0x83;
 break;

 case('c'):
 hexa=0xA7;
 break;

 case('d'):
 hexa=0xA1;
 break;

 case('e'):
 hexa=0x86;
 break;

 case('f'):
 hexa=0x8E;
 break;

 case('g'):
 hexa=0x90;
 break;

 case('h'):
 hexa=0x8B;
 break;

 case('i'):
 hexa=0xF9;
 break;

 case('j'):
 hexa=0xE1;
 break;

 case('l'):
 hexa=0xC7;
 break;

 case('n'):
 hexa=0xAB;
 break;

 case('o'):
 hexa=0xA3;
 break;

 case('p'):
 hexa=0x8C;
 break;

 case('q'):
 hexa=0x98;
 break;

 case('r'):
 hexa=0xAF;
 break;

 case('s'):
 hexa=0x92;
 break;

 case('u'):
 hexa=0xC1;
 break;

 case('v'):
 hexa=0xE3;
 break;

 case('z'):
 hexa=0xE4;
 break;

 }
 return hexa;
}
#line 4 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/teste1/test1.c"
unsigned int i = 0;
char letras[20] = {'a','b','c','d','e','f','g','h','i','j','l','n','o','p','q','r','s','u','v', 'z'};
void main() {
 ADPCFG = 0xFFFF;
 TRISD = 0;
 TRISB = 0;
 LATD = 1;
 LATB = 0;
 while(1){
 for(i = 0; i<20; i++){
 LATD = 0b1110;
 LATB = bcd(letras[i]);
 Delay_ms(500);

 }
 }
}
