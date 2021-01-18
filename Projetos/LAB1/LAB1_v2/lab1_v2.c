#include <stdlib.h>

//Variavel a ser mostrada pelo display
char disp7[4] = {'-','-','-','-'};

//Inicializa hexa como - - - -
unsigned char hexa1[4] = {0xBF,0xBF,0xBF,0xBF};
unsigned char acertou[20];

//unsigned char secreto[6] = {' ',' ',' ',' ',' ',' '};
unsigned char secreto[6] = {'u','f','s','1','4','5'};

//mensagem de acerto
unsigned char men_final[14] = {'d','s','p','i','c','3','0','f','4','0','1','1',' ',' '};

//Mensagem de erro
char erro[4] = {'e','r','o',' '};

//Array com todos os caracteres disponiveis para os 7 segmentos
char letras[31] = {'-',' ','a','b','c','d','e','f','g','h','i','j','l','n','o','p','q','r','s','u','v','0','1','2','3','4','5','6','7','8','9'};

//Senha que o usuario digitou
char usuario[6];

//prototipos das funções
int char_to_7seg(char _char);
void leitor();
void conv_char_to_hexa();
void teste_acerto();
void teste_erro();
void mostra_usuario(int cont3);
void reseta_tudo();
void bomba();
void mostra_men_final_1();
void mostra_men_usuario();
void escreve_acertou();
void descreve_acertou();
void mostt_uu();

//variaveis da main
int contador = 0; //conta o alfabeto
int cont_u = 0;   //conta a quantidade de caracteres inseridos pelo usuario
int flag = 0;     //verifica se a quantidade de caracteres ultrapassou 6

int jj = 0;       //
int k = 0;        //
int kk = 0;       //
int flag2 = 0;    //

int contdosconts = 0;

int cont4 = 0;
int ll = 0;
int flag5 = 0;
int flag_bomba = 0;
int cont2 = 0;
int cont3 = 0;
int aux;
char hexa;
int m = 0; //MENSAGEM
int flag_erro = 1;

char tempo[10] = {'0','1','2','3','4','5','6','7','8','9'};
int y = 9;
int aa=0;

int temp = 0;
char flag_cri =  1;

//contador para leitor
unsigned int i = 0;
unsigned int j = 0;

//Tempo que cada display permanece ligado
const int T = 1;

//pra facilitar a multiplexacao dos 7 segmentos
unsigned char D[4] = {0xF7,0xFB,0xFD,0xFE};

void main() {
    //CONFIGURA AS PORTAS B D E F COMO DIGITAL
    ADPCFG = 0xFFFF;
    //Porta B como saida para os 7 segmentos
    TRISB  = 0;
    //Porta D como saida para multiplexar os 7 segmentos
    TRISD  = 0;
    //Porta F como entrada para os botoes SW0 e Sw1
    TRISF  = 0;
    //Porta E como saida para ligar o buzzer
    TRISE  = 0;
    
    //Loop infinito
    while(1){
          
          //se botao sw0 estiver apertado incrementa contador e mostra o caractere correspondente no primeiro display
          if(PORTF == 0x01){
               //se contador for menor que 31 incrementa, senao reseta o contador
               if (contador<31){
                   contador++;
               }else{
                   contador = 0;
               }
               //Debounce
               Delay_ms(500);
               //Mostra o caractere para ser selecionado pelo usuario
               disp7[0] = letras[contador];
          }
          
          //se a porta SW2 for apertada ativar o modo bomba
          if(PORTF == 0b00010000){
               flag_bomba=1;
               Delay_ms(500);
          }
          
          //se botao sw1 for apertado guarda o caractere escolhido, e reseta o contador dos caracteres
          if (PORTF == 0x02){
              //Guarda o caractere na variavel usuario
              usuario[cont_u] = letras[contador];
              //reseta contador para facilitar as proximas escolhas do usuario
              contador = 0;
              //Debounce
              Delay_ms(500);
              //Atualiza o display com o caractere inserido pelo usuario
              mostra_usuario(cont_u);
              //O tamanho maximo da senha foi escolhido como 6 ja que e o tamanho de UFS145
              
              //Bipa o buzzer quando o caractere for selecionado e nao tiver ultrapassado o limite dos 6 caracteres
              if  (cont_u<6){
                  cont_u++;
                  PORTE = 1;
                  Delay_ms(200);
                  PORTE = 0;
              }
              //Verifica se o usuario acertou a palavra secreta
              if  (cont_u == 6){
                  flag = 1;
                  for (k = 0; k <= 5; k++){
                      if (usuario[k] != secreto[k]){
                         flag = 2;
                      }
                  }
              }
              //Mostra o caractere para ser selecionado pelo usuario
              disp7[0] = letras[contador];
          }
          
          //Ativa o buzzer apos 3 erros e ativa bomba
          if(contdosconts == 3){
              PORTE = 1;
              Delay_ms(5000);
              PORTE = 0;
              contdosconts = 0;
              
              //reseta as variáveis do sistema
              reseta_tudo();
              
              //ativa a bomba
              if  (flag_bomba == 1){
                  bomba();
              }
              
          }

          //se os dois botoes forem apertados ao mesmo tempo, se ativa o criterio de parada resetando o sistema
          if (PORTF == 0x03){
             Delay_ms(500);
             
             //contador de tentativas falhas
             if (flag == 2){
                if (contdosconts < 3){
                   contdosconts++;
                }
             }
             //reseta as variáveis do sistema
             reseta_tudo();
             
             //reseta o display
             i = 0;
             for ( m = 0; m < 4; m++ ){
                disp7[m] = '-';
             }
             for ( m = 0; m < 6; m++ ){
                usuario[m] = '-';
             }
          }
          
          //Usuario acertou a senha
          if ((cont_u == 6)&&(flag==1)){
             if (flag2 == 0){
                PORTE = 1;
                Delay_ms(1000);
                PORTE = 0;
                flag2=1;
              }
              //mostra mensagem de acerto
             teste_acerto();
          }
          
          //Usuario errou a senha
          if (( cont_u == 6)&&(flag == 2)){
            if (flag_erro == 1){
               //mostra mensagem digitada pelo usuario
               mostt_uu();
            }else{
               //mostra mensagem de erro
               teste_erro();
            }
          }
          
          //Usuario ainda esta digitando a palavra, nesse caso se atualiza as informações inseridas nos displays
          if (flag == 0){
              leitor();
          }else{
              //se o usuario tiver acertado ou errado, esse laço torna a mensagem mais lenta,
              // permitindo a visualização das letras se movendo
              for (kk = 0; kk < 100; kk++){
                  leitor();
              }
          }
          
          Delay_ms(1);
          //converte os caracteres em disp7 para hexadecimal(anodo comum)
          conv_char_to_hexa();
    }
}

//mostra a variavel hexa no display de 7 segmentos
void leitor(){
     LATD = 0xF7;
     LATB = hexa1[0];
     Delay_ms(T);

     LATD = 0xFB;
     LATB = hexa1[1];
     Delay_ms(T);

     LATD = 0xFD;
     LATB = hexa1[2];
     Delay_ms(T);
         
     LATD = 0xFE;
     LATB = hexa1[3];
     Delay_ms(T);
}

//Funcao que converte um array em hexadecimais para 7 segmentos
void conv_char_to_hexa(){
     for(j=0;j<4;j++){
         hexa1[j] = char_to_7seg(disp7[j]);
         Delay_ms(1);
     }
}

//funcao para imprimir os caracteres de acerto
void teste_acerto(){

        escreve_acertou();
        mostra_men_final_1();
        descreve_acertou();

}
//escreve a senha digitada pelo usuario e em seguida a mensagem secreta
void escreve_acertou(){
     for (i = 0; i < 20; i++){
        if (i<6){
           acertou[i] = usuario[i];
        }else{
           acertou[i] = men_final[i-6];
        }
     }
}
//apaga a mensagem de acerto
void descreve_acertou(){
    for (i = 0; i < 20; i++){
        acertou[i] = ' ';
     }
}
//mostra palavra inserida pelo usuario
void mostt_uu(){
     for (i = 0; i < 50800; i++){
         mostra_men_usuario();
     }
     flag_erro = 0;
}

//mostra mensagem final de acerto ao usuario
void mostra_men_usuario(){

        //mostra as letras se movendo da esquerda para a direita
        for (jj = 0; jj < 4; jj++){
             disp7[jj] = usuario[cont3+jj];
        }
        
        //incrementa contador
        cont3++;
        
        //reseta contador caso ultrapasse limite
        if (cont3 == 2){
            cont3 = 0;
        }
        
        //força as letras a virem da direita para a esquerda
        aux = disp7[0];
        disp7[0] = disp7[3];
        disp7[3] = aux;
        aux = disp7[1];
        disp7[1] = disp7[2];
        disp7[2] = aux;
}

void mostra_men_final_1(){
        for (jj = 0; jj < 4; jj++){
             disp7[jj] = acertou[cont2+jj];
        }
        cont2++;
        
        if (cont2 == 23){
              cont2 = 0;
        }
           aux = disp7[0];
           disp7[0] = disp7[3];
           disp7[3] = aux;
           aux = disp7[1];
           disp7[1] = disp7[2];
           disp7[2] = aux;
}

//funcao para imprimir os caracteres de erro
void teste_erro(){
   if (flag5 == 0){
          for(ll = 0;ll < 4;ll++){
             disp7[ll]=erro[3-ll];
          }
       flag5=1;
   }else{
       for(ll = 0;ll < 4;ll++){
             disp7[ll]=' ';
       }
       flag5=0;
    }
}
   


//reseta o valor das variaveis
void reseta_tudo(){
     contador = 0;
     cont_u = 0;
     flag = 0;
     jj = 0;
     k = 0;
     kk = 0;
     flag2 = 0;
     cont4 = 0;
     ll = 0;
     flag5 = 0;
     cont2 = 0;
     cont3 = 0;
     m = 0;
     i = 0;
     y = 9;
     flag_erro = 1;
     for (i = 0; i<6;i++){
       usuario[i] = ' ';
     }

}
//Funcao que mostra os caracteres digitados pelo usuario da direita para a esquerda
void mostra_usuario(int cont3){
              switch(cont3){
                  case 0:
                      disp7[1] = usuario[0];
                      break;
                  case 1:
                      disp7[1] = usuario[1];
                      disp7[2] = usuario[0];
                      break;
                  case 2:
                      disp7[1] = usuario[2];
                      disp7[2] = usuario[1];
                      disp7[3] = usuario[0];
                      break;
                  case 3:
                      disp7[1] = usuario[3];
                      disp7[2] = usuario[2];
                      disp7[3] = usuario[1];
                      break;
                  case 4:
                      disp7[1] = usuario[4];
                      disp7[2] = usuario[3];
                      disp7[3] = usuario[2];
                      disp7[1] = usuario[4];
                      disp7[2] = usuario[3];
                      disp7[3] = usuario[2];
                      break;
              }
}

//Funcao para mapear os caracteres para hexadecimal( 7seg anodo comum)
int char_to_7seg(char _char){

    switch(_char){
       case ('-'):
            hexa = 0xBF;
       break;

       case(' '):
            hexa = 0xFF;
       break;

       case('a'):
            hexa = 0x88;
       break;

       case('b'):
            hexa = 0x83;
       break;

       case('c'):
            hexa = 0xC6;
       break;

       case('d'):
            hexa=0xA1;
       break;

       case('e'):
            hexa = 0x86;
       break;

       case('f'):
            hexa = 0x8E;
       break;

       case('g'):
           hexa = 0x90;
       break;

       case('h'):
           hexa = 0x8B;
       break;

       case('i'):
           hexa = 0xF9;
       break;

       case('j'):
           hexa = 0xE1;
       break;

       case('l'):
           hexa = 0xC7;
       break;

       case('n'):
           hexa = 0xAB;
       break;

       case('o'):
           hexa = 0xC0;
       break;

       case('p'):
           hexa = 0x8C;
       break;

       case('q'):
           hexa = 0x98;
       break;

       case('r'):
           hexa = 0xAF;
       break;

       case('s'):
           hexa = 0x92;
       break;

       case('u'):
           hexa = 0xC1;
       break;

       case('v'):
           hexa = 0xE3;
       break;

       case('0'):
           hexa = 0xC0;
       break;

       case('1'):
           hexa = 0xF9;
       break;

       case('2'):
           hexa = 0xA4;
       break;

       case('3'):
           hexa = 0xB0;
       break;

       case('4'):
           hexa = 0x99;
       break;

       case('5'):
           hexa = 0x92;
       break;

       case('6'):
           hexa = 0x82;
       break;

       case('7'):
           hexa = 0xF8;
       break;

       case('8'):
           hexa = 0x80;
       break;

       case('9'):
           hexa = 0x90;
       break;
    }
    return hexa;
}

//função da criatividade, mostra contador regressivo de tempo, sendo em seguida mostrados caracteres aleatorios
 void bomba(){
      // contador regressivo
      while(y >= 0){
          //armazenando no display o contador
          disp7[0] = tempo[y];
          disp7[1] = '0';
          disp7[2] = '0';
          disp7[3] = '0';
          
          //decrementando o contador
          y--;
          //desligando buzzer
          PORTE = 0;
          
          for( aa = 0 ; aa<100 ; aa++){
          //mostra tempo no display
          if (flag_cri == 1){
               leitor(); }
          }
          //maneira de implementar delay_ms com tempo dinamico
          for (temp = 1; temp < y; temp++){
               Delay_ms(1);
          }
          //liga buzzer
          PORTE = 1;
          //converte de char pra hexa
          conv_char_to_hexa();
      }
      while(1){
          //mostra caracteres aleatorios nos display ate SW,SW1 e SW2 sejam pressionados simultaneamente
          PORTD = 0xFE;
          PORTB = rand()%127;
          Delay_ms(10);
          PORTD = 0xFD;
          PORTB = rand()%127;
          Delay_ms(10);
          PORTD = 0xFB;
          PORTB = rand()%127;
          Delay_ms(10);
          PORTD = 0x07;
          PORTB = rand()%127;
          Delay_ms(10);
          
          //condição de parada
          if (PORTF == 0x13){
             //Debounce
             Delay_ms(500);
             //reset das variaveis
             PORTE = 0;
             flag_bomba = 0;
             reseta_tudo();
             i = 0;
             for ( m = 0; m < 4; m++ ){
                disp7[m] = '-';
             }
             LATD = 0x00;
             LATB = hexa1[0];
             break;
          }
          
      }
 }