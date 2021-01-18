#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2_cria/criat_q2.c"
#line 24 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2_cria/criat_q2.c"
void tocar(int freq, long tempo_ms);
void marcha_imp();



void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 TRISD = 0;
 TRISE = 0;
 TRISF = 0;
 while(1){
 marcha_imp();
 }
}

int x;


void tocar(int freq, long tempo_ms){

 long atraso = (long)(1000000/freq);
 long loop = (long)((tempo_ms*1000)/(atraso*2));
 for (x = 0; x < loop; x++){
 PORTE = 0x01;
 while(atraso > 0){
 Delay_ms(1);
 atraso--;
 }
 PORTE = 0x00;
 while(atraso > 0){
 Delay_ms(1);
 atraso--;
 }
 }
 Delay_ms(50);
}

void marcha_imp(){
 tocar( 440 , 100);
 tocar( 440 , 100);
 tocar( 440 , 100);
 tocar( 349 , 100);
 tocar( 523 , 100);
#line 79 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2_cria/criat_q2.c"
}
