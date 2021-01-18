#define PWMd OC1RS
#define PWMe OC3RS
#define periodo 20000 //250Hz

#define E1 LATBbits.LATB2
#define E2 LATBbits.LATB3

#define D1 LATBbits.LATB4
#define D2 LATBbits.LATB5


char criat[] = "criati";
char criat_aux[20] = " ";

//Inicializa a UART2
void INIT_UART2(unsigned char valor_baud){
     U2BRG = valor_baud;  //Configurar UART: 8bits de dados, 1 it de parada, sem paridade
     U2MODE = 0x0000; //ver tabela para saber as outras configura??es
     U2STA = 0x0000;
     IFS1bits.U2TXIF = 0;  //Zera a flag de interrupcao de Tx
     IEC1bits.U2TXIE = 0;  //Desabilita a interrupcao de Tx
     IFS1bits.U2RXIF = 0;  //Zera a flag de de interrupcao de Rx
     IEC1bits.U2RXIE = 0;  //Desabilita a flag de interrupcao de Rx
     U2MODEbits.UARTEN = 1; //Liga a UART
     U2STAbits.UTXEN = 1;   //Come?a a comunica??o
}

//Reseta flag da transmissao
void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
     IFS1bits.U2TXIF = 0;
}

//envia um char pelo reg da uart
void send_char(unsigned char c){
     while( U2STAbits.UTXBF);
     U2TXREG = c; // escreve caractere
}

//usa a função de char pra enviar uma string
void send_str(unsigned char* str){
     unsigned int i = 0;
     while(str[i])
         send_char(str[i++]);
}

//recebe char
unsigned char receive_char(){
     unsigned char c;
     while(!U2STAbits.URXDA);
     c = U2RXREG; // escreve caractere
     return c;
}

char criatividade[100];
//recebe string
void receive_str(){
     int i = 0;
     char c;
     do{
         c = receive_char();
         criatividade[i] = c;
         i++;
     }while(c != 0x0A);
         criatividade[i-1] = '\0';
}


//Funcao para dar match e ativar a criatividade
void receive_str_cri(){
     int i = 0;
     char c;
     do{
         c = receive_char();
         criat_aux[i] = c;
         i++;
     }while(c != 0x0A);
         criat_aux[i-1] = '\0';

     delay_ms(250);
}

int flag_criatividade = 0;

//botao que ativa criatividade
void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
  Delay_Ms(50);
  if (flag_criatividade == 0){
      flag_criatividade = 1;
      LATBbits.LATB0 = 1;
  }else{
      flag_criatividade = 0;
      LATBbits.LATB0 = 0;
  }
  IFS0bits.INT0IF = 0;
}

int aux2 = periodo/10;
int aux3;
int duty;
char txt[7];
//troca PWM e portas digitais que controlam a direção dos motores
void mudarPWM(char aux){
     //Seleciona modo
     switch(aux){
       case 'F':  //FRENTE
          E1 = 1; //dois motores pra frente
          E2 = 0;
          D1 = 1;
          D2 = 0;
          send_str("FRENTE \r\n");
          break;
       case 'E':  //ESQUERDA
          E1 = 0;
          E2 = 1; //um motor para frente e outro para trás
          D1 = 1;
          D2 = 0;
          send_str("ESQUERDA \r\n");
          break;
       case 'D':  //DIREITA
          E1 = 1;
          E2 = 0; //um motor para frente e outro para trás
          D1 = 0;
          D2 = 1;
          send_str("DIREITA \r\n");
          break;
       case 'A':  //atras
          D1 = 0;
          D2 = 1;  //dois motores para tras
          E1 = 0;
          E2 = 1;
          send_str("ATRAS \r\n");
          break;
       case 'P':  //acelera
         //evita overflow e underflow do registrador
         duty = duty + 10;
         aux3 = PWMd + aux2;
         if (aux3 <= periodo){
            PWMd += aux2;
         }else{
            PWMd = periodo;
            duty = 100;
         }
         aux3 = PWMe + aux2;
         if (aux3 <= periodo){
            PWMe += aux2;
         }else{
            PWMe = periodo;
            duty = 100;
         }
         send_str("DUTY");
         IntToStr(duty,txt);
         send_str(txt);
         send_str("\r\n");
         break;
       case 'L':  //desacelera
          duty = duty - 10;
          aux3 = PWMd - aux2;
          if(aux3 >= 0){
              PWMd -= aux2;
          }else{
              PWMd = 0;
              duty = 0;
          }
          
          aux3 = PWMe - aux2;
          if(aux3 >= 0){
              PWMe -= aux2;
          }else{
              PWMe = 0;
              duty = 0;
          }
          send_str("DUTY");
          IntToStr(duty,txt);
          send_str(txt);
          send_str("\r\n");
          break;
       default:
          break;
     }
}

unsigned char m = 'y';
unsigned char m2;

//Timer que envia msg depois que certo tempo passa depois da uma tecla ser pressionada
void msg() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {

     if (m == 'F')
        send_str("FRENTE ");
     if (m == 'A')
        send_str("ATRAS ");
     if (m == 'D')
        send_str("DIREITA ");
     if (m == 'E')
        send_str("ESQUERDA ");
     send_str("DUTY");
     IntToStr(duty,txt);
     send_str(txt);
     send_str("\r\n");
     IFS0bits.T1IF = 0;
}

int j = 0;
char pepe;

void main(){
     ADPCFG = 0xFFFF;
     TRISB = 0;
     LATB = 0;
     PWMd = 0;
     OC1CON = 0x0006;
     IEC0bits.INT0IE = 1;

     PWMe = 0;
     OC3CON = 0x0006;

     PR2 = periodo;
     T2CON = 0x8010;

     IEC0bits.T1IE = 1;
     PR1 = 0xFFFF;
     T1CON = 0x8030;
     TMR1 = 0;

     IFS0 = 0;
     
     INIT_UART2(51);
     send_char(0x030);
     
     while(1){
     //Sem criatividade
       if(flag_criatividade == 0){
         Delay_ms(100);
         m = receive_char();
         mudarPWM(m);
       }else{//com criatividade
         j = 0;
         receive_str();
         while(criatividade[j] != '\0'){
              pepe = criatividade[j];
              mudarPWM(pepe);
              j++;
              Delay_ms(500);
         }
       }
     }
}