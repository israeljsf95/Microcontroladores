// Codigo para ativar Display de 7 segmentos
//Declaração de variaveis globais
unsigned int num[10] = {63,6,91,79,102,109,125,7,127,111}; // numero estão no formato decimal, tambem pode ser colocado em HEX
int i = 0; // variavel usada para o for

void main() {
// configuações de registradores
ADPCFG = 0xFFFF;
TRISB = 0;
TRISD = 0;
while(1) {
         PortD = 0x1;
         for(i=0;i!=10;i++){
                           delay_ms(1000);
                           PortB = num[i];
                           
                           
d         }
}

}