#line 1 "C:/Users/israe/Desktop/PWM/PWM.c"



 void init_OCmod(){
 TRISD = 0;
 IFS0 = 0;
 IEC0 = 0;

 IEC0bits.T2IE = 1;
 T2CON = 0x8030;
 PR2 = 1250;

 OC1CON = 0;
 OC1CONbits.OCM = 0b110;
 OC1CONbits.OCTSEL = 0;
 OC1RS = 1250;

 OC3CON = 0;
 OC3CONbits.OCM = 0b110;
 OC3CONbits.OCTSEL = 0;
 OC3RS = 0;
}

void mudar_PWM(float duty1, float duty2){
 OC1RS = floor(PR2*duty1);
 OC3RS = floor(PR2*duty2);
}

int i;
int j;
void main() {

 ADPCFG = 0xFFFF;
 init_OCmod();

 while(1){
 for (i=0, j = 3; i < 4; i++, j--){
 mudar_PWM(0.25*i, 0.25*j);
 Delay_ms(1000);
 }
 }
}
