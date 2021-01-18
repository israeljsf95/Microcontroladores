#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/timer1_ex1/timer1.c"
int ti;

void relogio() iv IVT_ADDR_T1INTERRUPT {

 ti = ~ti;
 IFS0 = 0;
}

void main() {
 ADPCFG=0xFFFF;
 TRISB=0;
 TMR1=0;
 IFS0=0;
 IEC0=0x0008;
 PR1=31250;
 T1CON=0x8030;
 while(1){
 if (ti == 0){
 LATB= 0;
 }else{
 LATB=1;
 }
 }
}
