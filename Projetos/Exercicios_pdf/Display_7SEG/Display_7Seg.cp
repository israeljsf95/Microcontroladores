#line 1 "C:/Users/Aluno 05/Desktop/Display_7SEG/Display_7Seg.c"


unsigned int num[10] = {63,6,91,79,102,109,125,7,127,111};
int i = 0;

void main() {

ADPCFG = 0xFFFF;
TRISB = 0;
TRISD = 0;
while(1) {
 PortD = 0x1;
 for(i=0;i!=10;i++){
 delay_ms(1000);
 PortB = num[i];


 }
}

}
