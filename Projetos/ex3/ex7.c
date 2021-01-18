//Questao 7
unsigned char num_1[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
unsigned char num_2[4] = {0x81, 0x42, 0x24, 0x18};
unsigned char num_3[4] = {0x18, 0x24, 0x42, 0x81};
unsigned int i = 0;
unsigned int cont = 0;

void main() {
     ADPCFG = 0xFFFF;
     TRISD = 0xFF;
     TRISB = 0;

     while(1){
       if (PORTDbits.RD1 == 1){
           Delay_ms(120);
           cont++;
       }
       
       switch (cont){
              case 1:
                   LATB = 0xFF;
                   Delay_ms(250);
                   break;
              case 2:
                  for (i=1;i < 256; i=i*2){
                    //LATB = num[i];
                    //Delay_ms(250);
                    LATB = i;
                    Delay_ms(250);
                  }
                  break;
              case 3:
                   for (i=256; i >= 1; i=i/2){
                    //LATB = num[i];
                        //Delay_ms(250);
                    LATB = i;
                    Delay_ms(250);
                  }
                  break;
              case 4:
                   for (i=0; i<4; i++){
                      LATB = num_2[i];
                      Delay_ms(250);
                      /*if (PORTDbits.RD1 == 0){
                        break;}*/
                   }
                   break;
               case 5:
                   for (i=0; i<4; i++){
                      LATB = num_3[i];
                      Delay_ms(250);
                   }
                   break;
               /*default:
                 LATB = 0;
                 Delay_ms(250);
                 cont = 0;*/
       }
       if ((cont>5)){
          cont = 0;
          LATB = 0;
          Delay_ms(250);
       }
     }
}