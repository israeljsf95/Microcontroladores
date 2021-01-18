#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/LAB1/lab1.c"

unsigned char hexa1[4]={0xBF,0xBF,0xBF,0xBF};

 unsigned char secreto[6] = {'U','F','S','1','4','5'};
 unsigned char men_final[14] = {'d','S','P','I','C','3','0','F','4','0','1','1'};


char disp7[4]={'e','r','0',' '};


int char_to_7seg(char _char);
void leitor();
void conv_char_to_hexa();


void main() {

 ADPCFG=0xFFFF;
 TRISB=0;
 TRISD=0;

 while(1){
 leitor();
 Delay_ms(5);
 conv_char_to_hexa();
 }
}


unsigned int i = 0;
unsigned int j = 0;


const int T = 1;


unsigned char D[4]={0xFE,0xFD,0xFB,0xF7};


void leitor(){

 for(i=0;i < 4;i++){
 LATD = 0xFF;
 Delay_ms(T);
 LATB = 0xFF;
 Delay_ms(T);
 LATB = hexa1[i];
 Delay_ms(T);
 LATD = D[i];
 Delay_ms(T);
 }
}

void conv_char_to_hexa(){
 for(j=0;j<4;j++){
 hexa1[j] = char_to_7seg(disp7[j]);
 Delay_ms(1);
 }
}





char hexa;

int char_to_7seg(char _char){

 switch(_char){
 case ('-'):
 hexa = 0xBF;
 break;

 case(' '):
 hexa = 0xFF;
 break;

 case('a'):
 hexa=0x88;
 break;

 case('b'):
 hexa=0x83;
 break;

 case('c'):
 hexa=0xA7;
 break;

 case('d'):
 hexa=0xA1;
 break;

 case('e'):
 hexa=0x86;
 break;

 case('f'):
 hexa=0x8E;
 break;

 case('g'):
 hexa=0x90;
 break;

 case('h'):
 hexa=0x8B;
 break;

 case('i'):
 hexa=0xF9;
 break;

 case('j'):
 hexa=0xE1;
 break;

 case('l'):
 hexa=0xF1;
 break;

 case('n'):
 hexa=0xAB;
 break;

 case('o'):
 hexa=0xA3;
 break;

 case('p'):
 hexa=0x8C;
 break;

 case('q'):
 hexa=0x98;
 break;

 case('r'):
 hexa=0xAF;
 break;

 case('s'):
 hexa=0x92;
 break;

 case('u'):
 hexa=0xC1;
 break;

 case('v'):
 hexa=0xE3;
 break;

 case('z'):
 hexa=0xE4;
 break;

 case('0'):
 hexa=0xC0;
 break;

 case('1'):
 hexa=0xF9;
 break;

 case('2'):
 hexa=0xA4;
 break;

 case('3'):
 hexa=0xB0;
 break;

 case('4'):
 hexa=0x99;
 break;

 case('5'):
 hexa=0x92;
 break;

 case('6'):
 hexa=0x82;
 break;

 case('7'):
 hexa=0xF8;
 break;

 case('8'):
 hexa=0x80;
 break;

 case('9'):
 hexa=0x90;
 break;
 }
 return hexa;
}
