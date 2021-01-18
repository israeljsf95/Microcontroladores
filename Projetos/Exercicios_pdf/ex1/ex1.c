

void main() {
     ADPCFG = 0xFFFF;
     TRISB  = 0; // Configurando como saida
     LATB = 0;
     while(1){
        LATB = 0x0F;
        Delay_ms(250);   // Teste 1
        LATB = 0xF;
        Delay_ms(250);  //Teste 2
        LATB = 0;
        Delay_ms(250); //Visualizacao do pisca pisca !!!
     }

}