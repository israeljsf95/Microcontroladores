int distval[6] = {200,180,120,80,50,20};
const int distmax = 400;
const int distmin = 2;
int dist = 3;
int atual = 0;

int tamanhos[3]={31,15,22};

int marcha[31]={500,500,500,350,150,500,350,150,1000,500,500,500,350,150,500,350,150,1000,500,350,150,500,250,250,125,125,250,250,500,250,250};
int forca[15]={1000,1000,150,150,150,600,800,150,150,150,1000,150,150,150,2000};
int jb[22]={150, 150, 300, 150, 150, 250, 150, 150, 200, 75, 500, 150, 150, 300, 150, 150, 250,150, 150, 150, 150, 800};

unsigned char seg7[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
int d[4];
int i;
int j;
int escolha = 0;
int mux[4] = {0x07,0xFB,0xFD,0xFE};

int cont=0;
unsigned char muxrelay[4] = {0b11111100,0b11111010,0b11110110,0b11101110};


// Prototipos
void ativa_sensores();
void calcula_distancia();
void mostra_display();
void tocar_marcha();
void tocar_forca();
void tocar_jb();

int antigo;
int estado = 0;

void main() {
     ADPCFG = 0xFFFF;
     TRISB = 0;
     TRISD = 0;
     TRISE = 0;
     TRISF = 0;
     atual=0;
     
     while(1){
        calcula_distancia();
        ativa_sensores();
        mostra_display();
        atual++;
        if (PORTF == 0b00010000){
           Delay_ms(500);
           escolha++;
           PORTE = 1;
           Delay_ms(100);
           PORTE = 0;
        }
        
        if ((escolha == 1) && (PORTF == 0b00100000)){
           PORTD = 0xFF;
           tocar_marcha();
        }
        
        if ((escolha == 2) && (PORTF == 0b00100000)){
           PORTD = 0xFF;
           tocar_forca();
        }
        
        if ((escolha == 3) && (PORTF == 0b00100000)){
           PORTD = 0xFF;
           tocar_jb();
        }
        
        if (escolha == 4){
           escolha = 0;
        }

    }
}


void calcula_distancia(){

          if(PORTF == 0x01){
              if (dist < distmax){
                  dist++;
              }
              Delay_ms(10);
          }

          if(PORTF == 0x02){
             if ( dist > distmin ){
                   dist--;
             }
             Delay_ms(10);
          }
}

void ativa_sensores(){

          if (dist > distval[0]){//maior que 200 cm
             PORTE = 0b11111110;
             antigo = atual;
             estado = 0;
          }else if((dist > distval[1])&&(dist <= distval[0])){//maior que 180 cm e menor que 200
             
             if (estado == 1){
                  PORTE=0b11111101;//liga rele 1 e buzzer
             }else{
                  PORTE=0b11111100;//desliga buzzer e liga rele 1
             }
             
             if (atual == antigo + 1500){
               antigo = atual;
               if (estado == 0){
                   estado=1;
               }else{
                   estado=0;
               }
             }

          }else if((dist > distval[2])&&(dist <= distval[1])){//maior que 120 cm e menor que 180

             if (estado == 1){
                  PORTE=0b11110111;//liga rele 2 e buzzer
             }else{
                  PORTE=0b11111110;//desliga buzzer e liga rele 1
             }

             if (atual == antigo + 1000){
               antigo = atual;
               if (estado == 0){
                   estado=1;
               }else{
                   estado=0;
               }
             }

          }else if((dist > distval[3])&&(dist <= distval[2])){//maior que 80 cm e menor que 120

             if (estado == 1){
                  PORTE=0b11111011;//liga rele 3 e buzzer
             }else{
                  PORTE=0b11111110;//desliga buzzer e liga rele 1
             }

             if (atual == antigo + 500){
               antigo = atual;
               if (estado == 0){
                   estado=1;
               }else{
                   estado=0;
               }
             }

          }else if((dist > distval[4])&&(dist <= distval[3])){//maior que 50 cm e menor que 80

             if (estado == 1){
                  PORTE=0b11101111;//liga rele 4 e buzzer
             }else{
                  PORTE=0b11101110;//desliga buzzer e liga rele 4
             }

             if (atual == antigo + 375){
               antigo = atual;
               if (estado == 0){
                   estado=1;
               }else{
                   estado=0;
               }
             }

          }else if((dist > distval[5])&&(dist <= distval[4])){//maior que 20 cm e menor que 50

             if (estado == 1){
                  PORTE=0b11111001;//liga rele 1 e buzzer
             }else{
                  PORTE=0b11111000;//desliga buzzer e liga rele 1 e 2
             }

             if (atual == antigo + 250){
               antigo = atual;
               if (estado == 0){
                   estado=1;
               }else{
                   estado=0;
               }
             }

          }else{//menor que 20 cm
             PORTE=0b00000001;//liga reles e buzzer
             antigo = atual;
             estado = 0;
          }
}

void mostra_display(){
     d[3] = 0;
     d[2] = dist/100;       //centenas
     d[1] = (dist%100)/10;  //dezenas
     d[0] = dist%10;        //unidade
     for(i = 0;i < 4;i++){
          LATD = mux[i];
          LATB = seg7[d[i]];
          Delay_ms(1);
     }
}

void tocar_marcha(){
   cont = 0;
  while(cont<tamanhos[escolha - 1]){
  /*
    //Com rel�s
    LATE=mux[k];
    Delay_ms(30);
    LATE=0xFE;

    if (k<4){
       k++;
    }else{
       k=0;
    }
    */
    //Com Buzzer

    LATE=0b11111111;
    Delay_ms(50);
    LATE=0b11111110;

    for ( j = marcha[cont]; j > 0 ; j--) {
        Delay_ms(1);
    }
    
    if (cont<tamanhos[escolha - 1]){
        cont++;
    }else{
        cont = 0;
    }
    
    }
}

void tocar_forca(){
  cont = 0;
  while(cont<tamanhos[escolha-1]){
  /*
    //Com rel�s
    LATE=mux[k];
    Delay_ms(30);
    LATE=0xFE;

    if (k<4){
       k++;
    }else{
       k=0;
    }
    */
    //Com Buzzer

    LATE=0b11111111;
    Delay_ms(50);
    LATE=0b11111110;

    for ( j = forca[cont]; j>0 ; j--) {
        Delay_ms(1);
    }

    if (cont<tamanhos[escolha-1]){
        cont++;
    }else{
        cont = 0;
    }

    }
}


void tocar_jb(){
  cont = 0;
  while(cont<tamanhos[escolha - 1]){
  /*
    //Com rel�s
    LATE=mux[k];
    Delay_ms(30);
    LATE=0xFE;

    if (k<4){
       k++;
    }else{
       k=0;
    }
    */
    //Com Buzzer

    LATE=0b11111111;
    Delay_ms(50);
    LATE=0b11111110;

    for ( j = jb[cont]+75; j>0 ; j--) {
        Delay_ms(1);
    }

    if (cont<tamanhos[escolha - 1]){
        cont++;
    }else{
        cont = 0;
    }
  }
}