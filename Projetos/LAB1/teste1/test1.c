#include "char2bcd.h"


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