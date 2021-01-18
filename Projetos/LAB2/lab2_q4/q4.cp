#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab2_q4/q4.c"
#line 34 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/lab2_q4/q4.c"
float dist_cm;
unsigned int distancia;
unsigned char txt[15];
int flag, aux;

void GTMOint() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
 IFS0bits.T1IF = 0;
 distancia = TMR1;
 TMR1 = 0;
}

void criativ() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
 delay_ms(50);
 flag = ~flag;
 IFS0bits.INT0IF = 0;
}

int dis_play(int valor){
 int resp;
 switch(valor){
 case 0: resp = 192;
 break;
 case 1: resp = 249;
 break;
 case 2: resp = 164;
 break;
 case 3: resp = 176;
 break;
 case 4: resp = 153;
 break;
 case 5: resp = 146;
 break;
 case 6: resp = 130;
 break;
 case 7: resp = 248;
 break;
 case 8: resp = 128;
 break;
 case 9: resp = 152;
 break;
 }
 return resp;
 }

int conversao(float distancia){
 int Ia, dist_disp, unidade1, dezena1, centena1;
 dist_disp = distancia;

 unidade1 = (dist_disp/1)%10;
 dezena1 = (dist_disp/10)%10;
 centena1 = (dist_disp/100)%10;

 for(Ia=0; Ia<3; Ia++) {
 switch (Ia){
 case(0):  LATFbits.LATF0  = 0;
  LATFbits.LATF1  = 0;
  LATFbits.LATF4  = 1;
  LATB  = dis_play(unidade1);
 delay_ms(1);
  LATFbits.LATF0  = 0;
  LATFbits.LATF1  = 0;
  LATFbits.LATF4  = 0;
 break;
 case(1):  LATFbits.LATF0  = 0;
  LATFbits.LATF1  = 1;
  LATFbits.LATF4  = 0;
  LATB  = dis_play(dezena1);
 delay_ms(1);
  LATFbits.LATF0  = 0;
  LATFbits.LATF1  = 0;
  LATFbits.LATF4  = 0;
 break;
 case(2):  LATFbits.LATF0  = 1;
  LATFbits.LATF1  = 0;
  LATFbits.LATF4  = 0;
  LATB  = dis_play(centena1);
 delay_ms(1);
  LATFbits.LATF0  = 0;
  LATFbits.LATF1  = 0;
  LATFbits.LATF4  = 0;
 break;
 }
 }
}

void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0x0000;
 TRISCbits.TRISC13 = 0;
  TRISCbits.TRISC14  = 1;
 TRISD = 0x0000;
 TRISEbits.TRISE0 = 0;
 TRISEbits.TRISE1 = 0;
 TRISEbits.TRISE2 = 0;
 TRISEbits.TRISE3 = 0;
 TRISEbits.TRISE8 = 1;
 TRISF = 0x0000;
 IFS0 = 0;
 LATB = 0;
 LATC = 0;
 LATD = 0;
 LATF = 0;

 IEC0bits.INT0IE = 1;
 IEC0bits.T1IE = 1;
 PR1 = 0xFFFF;
 PR2 = 16000;

 T1CON = 0x8070;
 T2CON = 0x8000;

 flag = 0;

 while(1){
 dist_cm = (distancia*0.272);
  LATDbits.LATD2  = 1;
 delay_us(15);
  LATDbits.LATD2  = 0;

 conversao(dist_cm);

 if(flag == 0) {
 if ((dist_cm > 200)){
 dist_cm == 200;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
  LATDbits.LATD3  = 0;
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;
 }
 else if ((dist_cm > 180) && (dist_cm <= 200)){
  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<900;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<900;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 120) && (dist_cm <= 180)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<600;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<600;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 80) && (dist_cm <= 120)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<300;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<300;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 50) && (dist_cm <= 80)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<225;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<225;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 20) && (dist_cm <= 50)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<150;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;


 for(aux=0;aux<150;aux++){
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm <= 20)){
 conversao(dist_cm);
  LATDbits.LATD3  = 1;
  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;
  LATFbits.LATF5  = 0;
 }
 }
 else{
 if ((dist_cm < 20)){
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 1;

  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;
 }
 else if ((dist_cm > 20) && (dist_cm <= 50)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<150;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<150;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 1;
 }
 }
 else if ((dist_cm > 50) && (dist_cm <= 80)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<225;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 0;

 for(aux=0;aux<225;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 80) && (dist_cm <= 120)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<300;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 0;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<300;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 120) && (dist_cm <= 180)){
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<600;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 0;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<600;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 180) && (dist_cm <= 200)){
  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<900;aux++) {
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }

  LATEbits.LATE0  = 0;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;

 for(aux=0;aux<900;aux++) {
  LATDbits.LATD3  = 1;
 conversao(dist_cm);
  LATFbits.LATF5  = 0;
 }
 }
 else if ((dist_cm > 200)){
  LATDbits.LATD3  = 0;
 conversao(dist_cm);
  LATEbits.LATE0  = 1;
  LATEbits.LATE1  = 1;
  LATEbits.LATE2  = 1;
  LATEbits.LATE3  = 1;
  LATFbits.LATF5  = 0;
 }
 }
 }
}
