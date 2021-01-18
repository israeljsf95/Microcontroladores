//Exemplo 2.ligar e desligar os leds na porta B,
//com um atraso de tempo

void main() {
       ADPCFG = 0xFFFF; //porta B como digital
       TRISB = 0;//porta B como saida
       while(1){
           LATB = 255;
           Delay_ms(1000);
           LATB = 0;
           Delay_ms(1000);
       }
}