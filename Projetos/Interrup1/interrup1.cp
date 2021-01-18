#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Interrup1/interrup1.c"
int flag = 0;



void INT0Int() iv IVT_ADDR_INT0INTERRUPT {
 Delay_ms(100);

 if (flag == 0){
 flag = 1;
 }

 else {
 flag = 0;
 LATB = 0;
 }

 IFS0bits.INT0IF = 0;
}



void main () {

ADPCFG = 0xFFFF;

TRISB = 0;
LATB = 0;

TRISE = 0x0100;



IFS0 = 0;

IEC0bits.INT0IE = 1;

INTCON2.INT0EP = 0;



while(1){
 if (flag != 0){

 LATB = 0xFF;
 Delay_ms(1000);
 LATB = 0;
 Delay_ms(1000);
 }
 }
}
