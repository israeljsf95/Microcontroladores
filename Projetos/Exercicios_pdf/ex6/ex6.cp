#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Exercicios_pdf/ex6/ex6.c"

unsigned int numeros[10]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};

int i=0;

void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 TRISD = 0;

 LATD = 0xFFFF;

 while(1){
 LATB = numeros[i];
 Delay_ms(2000);
 i = i+1;
 if (i==10){
 i = 0;
 }
 }
}
