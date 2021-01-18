void main() {
       ADPCFG=0xFFFF;
       TRISB=0;
       TRISD=255;
       while(1){
            if (PORTDbits.RD1==1){
                 int i;
                 for(i=256;i>=1;i=i/2){
                     LATB=i;
                     Delay_ms(500);
                 }
            }else{
            int i;
                for(i=1;i<256;i=i*2){
                     LATB=i;
                     Delay_ms(500);
                 }
            }
            LATB=0;
            Delay_ms(500);
       }
}