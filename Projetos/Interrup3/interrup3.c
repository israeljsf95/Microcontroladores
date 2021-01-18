

//Declaracao de variaveis

int flag = 0; // estado de botão


// configuração da subrotina de interrupção
void INT0Int() iv IVT_ADDR_INT0INTERRUPT { // declaração da interrupção
     Delay_ms(100); // delay anti-bouncing
     
     flag++;
     
     IFS0bits.INT0IF = 0; // "zeramento" da interrupção após ser executada --> desabilitação de flag
}

unsigned char HOLA[4] = {0x89,0xC0,0xC7,0x88};
unsigned char zer_nove[10] = {0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8, 0x80, 0x90};
unsigned char mux[4] = {0xFE,0xFD,0xFB,0xF7};

int i = 0;
int k = 0;

// função principal
void main () {
   // configurando os registradores das portas
   ADPCFG = 0xFFFF; // porta B digital
   TRISD = 0; // inicialização
   TRISB = 0; // porta B de saída
   LATB = 0; // inicialização

   TRISE = 0x0100; // porta A com pino 8 de entrada (INT0 = RE4)


   // configurando os registradores de interrupção
   IFS0 = 0; // inicialização do registrador de interrupção IFS0 --> desabilitação de flag

   IEC0bits.INT0IE = 1; // habilitação de INT0

   INTCON2.INT0EP = 0; // configuração de borda de subida;


   // loop infinito de execução do programa
   while(1){
      if (flag == 1){ // se não estiver no estado 0
         for(k = 0; k<250 ; k++){
            for (i = 0; i <= 3; i++){
                Delay_ms(1);
                LATD = mux[i];
                LATB = HOLA[i];
            }
         }
         LATB = 0xFF;
         Delay_ms(250);
         
      }else if(flag == 2){
         for(k = 0; k <= 9 ; k++){
            for (i = 0; i <= 550; i++){
                Delay_ms(1);
                LATD = mux[0];
                LATB = zer_nove[k];
            }
         }
         LATB = 0xFF;
         Delay_ms(250);
      
      }else if(flag ==3){
         for(k = 0; k <= 9 ; k++){
            for (i = 0; i <= 550; i++){
                Delay_ms(1);
                LATD = mux[0];
                LATB = zer_nove[9-k];
            }
         }
         LATB = 0xFF;
         Delay_ms(250);
      
      }else if(flag >=4){
            flag=0;
      }
   }
}