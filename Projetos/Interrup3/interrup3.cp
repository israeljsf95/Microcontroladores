#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/Interrup3/interrup3.c"




int flag = 0;



void INT0Int() iv IVT_ADDR_INT0INTERRUPT {
 Delay_ms(100);

 flag++;

 IFS0bits.INT0IF = 0;
}

unsigned char HOLA[4] = {0x89,0xC0,0xC7,0x88};
unsigned char zer_nove[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
unsigned char mux[4] = {0xFE,0xFD,0xFB,0xF7};

int i = 0;
int k = 0;


void main () {

 ADPCFG = 0xFFFF;
 TRISD = 0;
 TRISB = 0;
 LATB = 0;

 TRISE = 0x0100;



 IFS0 = 0;

 IEC0bits.INT0IE = 1;

 INTCON2.INT0EP = 0;



 while(1){
 if (flag == 1){
 for(k = 0; k<250 ; k++){
 for (i = 0; i <= 3; i++){
 Delay_ms(1);
 LATD = mux[i];
 LATB = HOLA[i];
 }
 }
 LATB = 0xFF;
 Delay_ms(250);

 }else if(flag == 2){
 for(k = 0; k <= 9 ; k++){
 for (i = 0; i <= 550; i++){
 Delay_ms(1);
 LATD = mux[0];
 LATB = zer_nove[k];
 }
 }
 LATB = 0xFF;
 Delay_ms(250);

 }else if(flag ==3){
 for(k = 0; k <= 9 ; k++){
 for (i = 0; i <= 550; i++){
 Delay_ms(1);
 LATD = mux[0];
 LATB = zer_nove[9-k];
 }
 }
 LATB = 0xFF;
 Delay_ms(250);

 }else if(flag >=4){
 flag=0;
 }
 }
}
