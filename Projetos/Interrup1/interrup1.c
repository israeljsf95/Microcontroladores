

//Declaracao de variaveis

int flag = 0; // estado de bot�o


// configura��o da subrotina de interrup��o
void INT0Int() iv IVT_ADDR_INT0INTERRUPT { // declara��o da interrup��o
     Delay_ms(100); // delay anti-bouncing

     if (flag == 0){ //estado 0 troca pra estado 1 (vai piscar o LED)
        flag = 1;
     }

     else { // estado 1 troca pra estado 0 (n�o vai piscar o LED)
          flag = 0;
          LATB = 0;
     }

     IFS0bits.INT0IF = 0; // "zeramento" da interrup��o ap�s ser executada --> desabilita��o de flag
}


// fun��o principal
void main () {
   // configurando os registradores das portas
   ADPCFG = 0xFFFF; // porta B digital

   TRISB = 0; // porta B de sa�da
   LATB = 0; // inicializa��o

   TRISE = 0x0100; // porta A com pino 8 de entrada (INT0 = RE4)


   // configurando os registradores de interrup��o
   IFS0 = 0; // inicializa��o do registrador de interrup��o IFS0 --> desabilita��o de flag

   IEC0bits.INT0IE = 1; // habilita��o de INT0

   INTCON2.INT0EP = 0; // configura��o de borda de subida;


   // loop infinito de execu��o do programa
   while(1){
      if (flag != 0){ // se n�o estiver no estado 0
         // pisca led
         LATB = 0xFF;
         Delay_ms(1000);
         LATB = 0;
         Delay_ms(1000);
      }
   }
}