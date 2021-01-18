//Exercicio 5
//Com a tecla ligada a RD1 do kit fazer o seguinte:
//quando RD1 está em 1 se ligam todos os leds na porta B e
//quando RD1 está em 0 desligar todos os leds.


void main() {
     ADPCFG = 0xFFFF;
     TRISB = 0;//a PORTB como saida
     TRISD = 247; //pino 1(RD1) da porta D como entrada.
     LATB = 0;
     while(1)//loop infinito
     {
        if(PORTDbits.RD1 == 1){
            PORTDbits.RD3 = 1;

        }else {
              PORTDbits.RD3 = 0;
        }
     }
}