void main() {
     ADPCFG=0xFFFF; //digital
     TRISB=0;//saida
     LATB=0;
     while(1){
              LATB= 0x81;
              Delay_ms(250);
              LATB=0;
              Delay_ms(250);
              LATB= 0x42;
              Delay_ms(250);
              LATB=0;
              Delay_ms(250);
              LATB= 0x24;
              Delay_ms(250);
              LATB=0;
              Delay_ms(250);
              LATB= 0x18;
              Delay_ms(250);
              LATB=0;
              Delay_ms(250);
     }
}