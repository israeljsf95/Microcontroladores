#define trigger LATDbits.LATD2
#define echo TRISCbits.TRISC14

#define rele1 LATEbits.LATE0
#define rele2 LATEbits.LATE1
#define rele3 LATEbits.LATE2
#define rele4 LATEbits.LATE3

#define mux1 LATFbits.LATF0
#define mux2 LATFbits.LATF1
#define mux3 LATFbits.LATF4

#define criatividade LATFbits.LATF5

#define buzzer LATDbits.LATD3

#define display LATB
/*
// LCD module connections
     sbit LCD_RS at LATE5_bit;
     sbit LCD_EN at LATE4_bit;
     sbit LCD_D4 at LATE3_bit;
     sbit LCD_D5 at LATE2_bit;
     sbit LCD_D6 at LATE1_bit;
     sbit LCD_D7 at LATE0_bit;
     sbit LCD_RS_Direction at TRISE5_bit;
     sbit LCD_EN_Direction at TRISE4_bit;
     sbit LCD_D4_Direction at TRISE3_bit;
     sbit LCD_D5_Direction at TRISE2_bit;
     sbit LCD_D6_Direction at TRISE1_bit;
     sbit LCD_D7_Direction at TRISE0_bit;
// End LCD module connections */

float dist_cm;
unsigned int distancia;
unsigned char txt[15];
int flag, aux;

void GTMOint() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
     IFS0bits.T1IF = 0;  // zera a flag do timer ap?s ela ser ativada
     distancia = TMR1;   // Dist?ncia em cm
     TMR1 = 0;           // TMR1 ? zerado depois da contagem
}

void criativ() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
     delay_ms(50);        // debouncing do botao
     flag = ~flag;        // sempre que o botao for acionado ele inverte o estado anterior
     IFS0bits.INT0IF = 0; // interrup??o ? zerada e fica esperando ser acionada outra vez
}

int dis_play(int valor){
         int resp;   //recebe o valor decimal e converte pro valor do display
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

           for(Ia=0; Ia<3; Ia++) {  // multiplexa??o para exibi??o dos valores nos displays
                     switch (Ia){
                            case(0): mux1 = 0;
                                     mux2 = 0;
                                     mux3 = 1;
                                     display = dis_play(unidade1);
                                     delay_ms(1);
                                     mux1 = 0;
                                     mux2 = 0;
                                     mux3 = 0;
                                     break;
                            case(1): mux1 = 0;
                                     mux2 = 1;
                                     mux3 = 0;
                                     display = dis_play(dezena1);
                                     delay_ms(1);
                                     mux1 = 0;
                                     mux2 = 0;
                                     mux3 = 0;
                                     break;
                            case(2): mux1 = 1;
                                     mux2 = 0;
                                     mux3 = 0;
                                     display = dis_play(centena1);
                                     delay_ms(1);
                                     mux1 = 0;
                                     mux2 = 0;
                                     mux3 = 0;
                                     break;
                       }
            }
}

void main() {
     ADPCFG = 0xFFFF;           // configura entradas e sa?das como digitais;
     TRISB = 0x0000;            // PORTB como sa?da
     TRISCbits.TRISC13 = 0;     // RC13 como sa?da
     echo = 1;                  // T1CK como ENTRADA
     TRISD = 0x0000;            // PORTD como sa?da
     TRISEbits.TRISE0 = 0;      // RE0 como SA?DA
     TRISEbits.TRISE1 = 0;      // RE1 como SA?DA
     TRISEbits.TRISE2 = 0;      // RE2 como SA?DA
     TRISEbits.TRISE3 = 0;      // RE3 como SA?DA
     TRISEbits.TRISE8 = 1;      // RE8 como ENTRADA (? a interrup??o)
     TRISF = 0x0000;            // PORTF como sa?da
     IFS0 = 0;                  // flag de interrup??o do timer1
     LATB = 0;
     LATC = 0;
     LATD = 0;                  // sa?das
     LATF = 0;

     IEC0bits.INT0IE = 1;
     IEC0bits.T1IE = 1;         // o bit 3 do registrador IEC0 habilita a interrup??o do timer
     PR1 = 0xFFFF;              // coloca o pr no m?ximo pq ele vai contar o tempo que a onda do echo passou em alta
     PR2 = 16000;               // usado pra que a fun??o atraso_ms seja feita

     T1CON = 0x8070;            // ativamos o timer 1 e o prescaler fica em 256 p caber as contas
     T2CON = 0x8000;            // ativamos o timer 2 na fun??o timer

     flag = 0;

     while(1){
              dist_cm = (distancia*0.272);  // distancia multiplicada pela convers?o (256*62.5e-9*340/2)*100
              trigger = 1;                  // inicio do pulso de ativa??o do sensor
              delay_us(15);                 // dura??o do pulso de ativa??o do sensor
              trigger = 0;                  // fim do pulso de ativa??o do sensor

              conversao(dist_cm);

            if(flag == 0) {
              if ((dist_cm > 200)){
                 dist_cm == 200;
                 conversao(dist_cm);
                 criatividade = 0;
                 buzzer = 0; // buzzer sempre desligado
                 rele1 = 1;  // rel?1 desligado
                 rele2 = 1;  // rel?2 desligado
                 rele3 = 1;  // rel?3 desligado
                 rele4 = 1;  // rel?4 desligado
              }
              else if ((dist_cm > 180) && (dist_cm <= 200)){
                       rele1 = 0;
                       rele2 = 1;
                       rele3 = 1;
                       rele4 = 1;

                       for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                       }

                       rele1 = 0;
                       rele2 = 1;
                       rele3 = 1;
                       rele4 = 1;

                       for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                       }
               }
              else if ((dist_cm > 120) && (dist_cm <= 180)){
                       rele1 = 1;
                       rele2 = 0;
                       rele3 = 1;
                       rele4 = 1;

                       for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                       }

                       rele1 = 1;
                       rele2 = 0;
                       rele3 = 1;
                       rele4 = 1;

                       for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                       }
              }
              else if ((dist_cm > 80) && (dist_cm <= 120)){
                       rele1 = 1;
                       rele2 = 1;
                       rele3 = 0;
                       rele4 = 1;

                       for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                       }

                       rele1 = 1;
                       rele2 = 1;
                       rele3 = 0;
                       rele4 = 1;

                       for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                       }
              }
              else if ((dist_cm > 50) && (dist_cm <= 80)){
                       rele1 = 1;
                       rele2 = 1;
                       rele3 = 1;
                       rele4 = 0;

                       for(aux=0;aux<225;aux++) {   //atraso de 0.75 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                       }

                       rele1 = 1;
                       rele2 = 1;
                       rele3 = 1;
                       rele4 = 0;

                       for(aux=0;aux<225;aux++) {
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                       }
              }
              else if ((dist_cm > 20) && (dist_cm <= 50)){
                      rele1 = 1;
                      rele2 = 1;
                      rele3 = 0;
                      rele4 = 0;

                      for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                       }

                      rele1 = 1;
                      rele2 = 1;
                      rele3 = 0;
                      rele4 = 0;

                       //atraso_ms(500);
                       for(aux=0;aux<150;aux++){
                          buzzer = 1;
                          conversao(dist_cm);
                          criatividade = 0;
                       }
              }
              else if ((dist_cm <= 20)){
                       conversao(dist_cm);
                       buzzer = 1; // buzzer sempre ligado
                       rele1 = 0;  // rel?1 sempre ligado
                       rele2 = 0;  // rel?2 sempre ligado
                       rele3 = 0;  // rel?3 sempre ligado
                       rele4 = 0;  // rel?4 sempre ligado
                       criatividade = 0;
              }
            }
            else{
              if ((dist_cm < 20)){
                   buzzer = 1; // buzzer sempre ligado
                   conversao(dist_cm);
                   criatividade = 1;

                   rele1 = 0;  // rel?1 sempre ligado
                   rele2 = 0;  // rel?2 sempre ligado
                   rele3 = 0;  // rel?3 sempre ligado
                   rele4 = 0;  // rel?4 sempre ligado
              }
              else if ((dist_cm > 20) && (dist_cm <= 50)){
                   rele1 = 1;
                   rele2 = 1;
                   rele3 = 0;
                   rele4 = 0;

                   for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                    }

                   rele1 = 1;
                   rele2 = 1;
                   rele3 = 0;
                   rele4 = 0;

                   for(aux=0;aux<150;aux++) {  //atraso de 0.5 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 1;
                    }
              }
              else if ((dist_cm > 50) && (dist_cm <= 80)){
                   rele1 = 1;
                   rele2 = 1;
                   rele3 = 1;
                   rele4 = 0;

                   for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                    }

                   rele1 = 1;
                   rele2 = 1;
                   rele3 = 1;
                   rele4 = 0;

                   for(aux=0;aux<225;aux++) {  //atraso de 0.75 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                    }
              }
              else if ((dist_cm > 80) && (dist_cm <= 120)){
                      rele1 = 1;
                      rele2 = 1;
                      rele3 = 0;
                      rele4 = 1;

                      for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                      }

                      rele1 = 1;
                      rele2 = 1;
                      rele3 = 0;
                      rele4 = 1;

                      for(aux=0;aux<300;aux++) {  //atraso de 1 segundo
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                      }
              }
              else if ((dist_cm > 120) && (dist_cm <= 180)){
                      rele1 = 1;
                      rele2 = 0;
                      rele3 = 1;
                      rele4 = 1;

                      for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                      }

                      rele1 = 1;
                      rele2 = 0;
                      rele3 = 1;
                      rele4 = 1;

                      for(aux=0;aux<600;aux++) {  //atraso de 2 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                      }
              }
              else if ((dist_cm > 180) && (dist_cm <= 200)){
                   rele1 = 0;
                   rele2 = 1;
                   rele3 = 1;
                   rele4 = 1;

                   for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
                         buzzer = 0;
                         conversao(dist_cm);
                         criatividade = 0;
                    }

                   rele1 = 0;
                   rele2 = 1;
                   rele3 = 1;
                   rele4 = 1;

                   for(aux=0;aux<900;aux++) {  //atraso de 3 segundos
                         buzzer = 1;
                         conversao(dist_cm);
                         criatividade = 0;
                    }
              }
              else if ((dist_cm > 200)){
                 buzzer = 0; // buzzer sempre desligado
                 conversao(dist_cm);
                 rele1 = 1;  // rel?1 desligado
                 rele2 = 1;  // rel?2 desligado
                 rele3 = 1;  // rel?3 desligado
                 rele4 = 1;  // rel?4 desligado
                 criatividade = 0;
              }
            }
     }
} // fim void