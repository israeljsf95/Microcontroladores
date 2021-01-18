//Exemplo 1
//Fazer um conjunto de leds acender

//Cria variável global de 8 bits   (1 byte)
unsigned char num;

void main() {
     //COnfigura porta B para digital
     ADPCFG=0xFFFF;
     //Configura porta B como saida
     TRISB=0;
     //Atribui um valor a num=15
     num=0x00;
     while(1){
              //Saida B do microcontrolador recebe num
                LATB=num;
                num=num+1;
                if (num>255)
                {
                   num=0;
                }
                Delay_ms(500);
                
     }
}