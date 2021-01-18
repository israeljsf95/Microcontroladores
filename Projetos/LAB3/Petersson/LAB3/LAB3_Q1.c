// conexoes do LCD
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


//Variaveis
char txt1[]= "Sampling Time";  //Texto do Lcd 1 linha
char txtmeioseg[] = "0.5 s   ";
char txtumseg[] = "1 s    ";
char txtdezseg[] = "10 s   ";
char txtummin[] = "1 min   ";
char txtumahora[] = "1 hora   ";
int flag_botao = 0;
int flag_seleciona = 0;
int PRs[5] = {1,2,20,120,7200};
int contador_tempo = 0;
float soma_media = 0; // Vetor que armazenara cada uma das conversoes AD para
int media;                          //que a media possa ser tirada

/*

ADPCFG = 0xFFFB;
ADCON1 = 0x0040;

ADCHS = 0x0002;

ADCSSL = 0;
ADCON3 = 0x0000;
ADCON2 = 0x0000;
//Interrompendo a cada 16 ciclos de conversao
ADCON2bits.SMPI0 = 1;
ADCON2bits.SMPI1 = 1;
ADCON2bits.SMPI2 = 1;
ADCON2bits.SMPI3 = 1;
//Usando o outro timer para amostrar as 16 vezes
TMR3 = 0x0000;
PR3  =  500;
T3CON = 0x8010;

ADCON1bits.ADON = 1;
ADCON1bits.ASAM = 1;
*/


void temporizador() iv IVT_ADDR_T1INTERRUPT {
    contador_tempo++;
    IFS0bits.INT0IF = 0;
}

void conversao() iv IVT_ADDR_ADCINTERRUPT {//botao para selecao do menu
     IFS0bits.ADIF = 0;
     media = (int)(ADCBUF1 + ADCBUF2 + ADCBUF3 + ADCBUF4 + ADCBUF5 + ADCBUF6 + ADCBUF7 + ADCBUF8 + ADCBUF9 + ADCBUF10 + ADCBUF11 + ADCBUF12 + ADCBUF13 + ADCBUF14 + ADCBUF15)/16;
}

void botao() iv IVT_ADDR_INT0INTERRUPT {//botao para selecao do menu
     flag_botao++;
     contador_tempo = 0;
     flag_seleciona = 0;
     if (flag_botao > 4){
        flag_botao = 0;
     }
     Delay_ms(50);
     IFS0bits.INT0IF = 0;
}

void seleciona() iv IVT_ADDR_INT2INTERRUPT {
     flag_seleciona = 1;
     contador_tempo = 0;
     Delay_ms(50);
     IFS1bits.INT1IF = 0;
}

void main() {
      ADPCFG = 0xFFFF;

      IEC0bits.INT0IE = 1;//Ativando interrupçao do botao
      IEC1bits.INT2IE = 1;
      IEC0bits.T1IE = 1;
      T1CON = 0x8030;
      PR1 = 31250;
      IFS0 = 0;
      
      Lcd_Init();                        // Initialize LCD
      Lcd_Cmd(_LCD_CLEAR);               // Clear display
      Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off

      while(1){
          if (flag_seleciona == 0){
              switch(flag_botao){
                  case 0:
                       Lcd_Out(2,1,txtmeioseg);
                       break;
                  case 1:
                       Lcd_Out(2,1,txtumseg);
                       break;
                  case 2:
                       Lcd_Out(2,1,txtdezseg);
                       break;
                  case 3:
                       Lcd_Out(2,1,txtummin);
                       break;
                  case 4:
                       Lcd_Out(2,1,txtumahora);
                       break;
                  default:
                       break;
              }
              Lcd_Out(1,1,txt1);
          }else{
              switch(flag_botao){
                  case 0:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 1:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 2:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 3:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  case 4:
                       if (contador_tempo == PRs[flag_botao]){
                          contador_tempo = 0;
                       }
                  break;
                  default:
                  break;
              }
          }
      }
}