

//Declaracao de variaveis

int flag = 0; // estado de botão


// configuração da subrotina de interrupção
void INT0Int() iv IVT_ADDR_INT0INTERRUPT { // declaração da interrupção
     Delay_ms(100); // delay anti-bouncing

     if (flag == 0){ //estado 0 troca pra estado 1 (vai piscar o LED)
        flag = 1;
     }

     else { // estado 1 troca pra estado 0 (não vai piscar o LED)
          flag = 0;
          LATB = 0;
     }

     IFS0bits.INT0IF = 0; // "zeramento" da interrupção após ser executada --> desabilitação de flag
}


// função principal
void main () {
   // configurando os registradores das portas
   ADPCFG = 0xFFFF; // porta B digital

   TRISB = 0; // porta B de saída
   LATB = 0; // inicialização

   TRISE = 0x0100; // porta A com pino 8 de entrada (INT0 = RE4)


   // configurando os registradores de interrupção
   IFS0 = 0; // inicialização do registrador de interrupção IFS0 --> desabilitação de flag

   IEC0bits.INT0IE = 1; // habilitação de INT0

   INTCON2.INT0EP = 0; // configuração de borda de subida;


   // loop infinito de execução do programa
   while(1){
      if (flag != 0){ // se não estiver no estado 0
         // pisca led
         LATB = 0xFF;
         Delay_ms(1000);
         LATB = 0;
         Delay_ms(1000);
      }
   }
}