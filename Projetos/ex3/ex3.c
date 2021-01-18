//Ex 3 ligar e desliga os leds da porta B
//sequencialmente em intervalos de xx ms indefinidamente

//defininod o vetor que para ligar e desligar os leds
unsigned char num[8] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
//Variavel contador
unsigned char j;
void main() {
     ADPCFG = 0xFFFF;
     TRISB = 0;//PORTB how saida
     while(1){
          for (j = 0; j < 8 ; j ++)
          {//Liga e desliga LEDS 0,1,2,3,4,5,6,7
            LATB = num[j];  //Porta B saida Leds
            Delay_ms(1000); //Frequencia de clock é de XTAL = 8MHz. No edit Project
            //Oscillator FREQUENCY[MHZ] = 64.00000 = XTAL*PLL8. PLL8 = multipli
            //cacao por 8
          }
     }
}