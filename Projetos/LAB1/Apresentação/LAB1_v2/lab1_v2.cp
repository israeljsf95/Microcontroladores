#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/LAB1_v2/lab1_v2.c"
#line 1 "d:/microchip/mikroc pro for dspic/include/stdlib.h"







 typedef struct divstruct {
 int quot;
 int rem;
 } div_t;

 typedef struct ldivstruct {
 long quot;
 long rem;
 } ldiv_t;

 typedef struct uldivstruct {
 unsigned long quot;
 unsigned long rem;
 } uldiv_t;

int abs(int a);
float atof(char * s);
int atoi(char * s);
long atol(char * s);
div_t div(int number, int denom);
ldiv_t ldiv(long number, long denom);
uldiv_t uldiv(unsigned long number, unsigned long denom);
long labs(long x);
int max(int a, int b);
int min(int a, int b);
void srand(unsigned x);
int rand();
int xtoi(char * s);
#line 4 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/LAB1_v2/lab1_v2.c"
char disp7[4] = {'-','-','-','-'};


unsigned char hexa1[4] = {0xBF,0xBF,0xBF,0xBF};
unsigned char acertou[20];


unsigned char secreto[6] = {'u','f','s','1','4','5'};


unsigned char men_final[14] = {'d','s','p','i','c','3','0','f','4','0','1','1',' ',' '};


char erro[4] = {'e','r','o',' '};


char letras[31] = {'-',' ','a','b','c','d','e','f','g','h','i','j','l','n','o','p','q','r','s','u','v','0','1','2','3','4','5','6','7','8','9'};


char usuario[6];


int char_to_7seg(char _char);
void leitor();
void conv_char_to_hexa();
void teste_acerto();
void teste_erro();
void mostra_usuario(int cont3);
void reseta_tudo();
void bomba();
void mostra_men_final_1();
void mostra_men_usuario();
void escreve_acertou();
void descreve_acertou();
void mostt_uu();


int contador = 0;
int cont_u = 0;
int flag = 0;

int jj = 0;
int k = 0;
int kk = 0;
int flag2 = 0;

int contdosconts = 0;

int cont4 = 0;
int ll = 0;
int flag5 = 0;
int flag_bomba = 0;
int cont2 = 0;
int cont3 = 0;
int aux;
char hexa;
int m = 0;
int flag_erro = 1;

char tempo[10] = {'0','1','2','3','4','5','6','7','8','9'};
int y = 9;
int aa=0;

int temp = 0;
char flag_cri = 1;


unsigned int i = 0;
unsigned int j = 0;


const int T = 1;


unsigned char D[4] = {0xF7,0xFB,0xFD,0xFE};

void main() {

 ADPCFG = 0xFFFF;

 TRISB = 0;

 TRISD = 0;

 TRISF = 0;

 TRISE = 0;


 while(1){


 if(PORTF == 0x01){

 if (contador<31){
 contador++;
 }else{
 contador = 0;
 }

 Delay_ms(500);

 disp7[0] = letras[contador];
 }


 if(PORTF == 0b00010000){
 flag_bomba=1;
 Delay_ms(500);
 }


 if (PORTF == 0x02){

 usuario[cont_u] = letras[contador];

 contador = 0;

 Delay_ms(500);

 mostra_usuario(cont_u);



 if (cont_u<6){
 cont_u++;
 PORTE = 1;
 Delay_ms(200);
 PORTE = 0;
 }

 if (cont_u == 6){
 flag = 1;
 for (k = 0; k <= 5; k++){
 if (usuario[k] != secreto[k]){
 flag = 2;
 }
 }
 }

 disp7[0] = letras[contador];
 }


 if(contdosconts == 3){
 PORTE = 1;
 Delay_ms(5000);
 PORTE = 0;
 contdosconts = 0;


 reseta_tudo();


 if (flag_bomba == 1){
 bomba();
 }

 }


 if (PORTF == 0x03){
 Delay_ms(500);


 if (flag == 2){
 if (contdosconts < 3){
 contdosconts++;
 }
 }

 reseta_tudo();


 i = 0;
 for ( m = 0; m < 4; m++ ){
 disp7[m] = '-';
 }
 for ( m = 0; m < 6; m++ ){
 usuario[m] = '-';
 }
 }


 if ((cont_u == 6)&&(flag==1)){
 if (flag2 == 0){
 PORTE = 1;
 Delay_ms(1000);
 PORTE = 0;
 flag2=1;
 }

 teste_acerto();
 }


 if (( cont_u == 6)&&(flag == 2)){
 if (flag_erro == 1){

 mostt_uu();
 }else{

 teste_erro();
 }
 }


 if (flag == 0){
 leitor();
 }else{


 for (kk = 0; kk < 100; kk++){
 leitor();
 }
 }

 Delay_ms(1);

 conv_char_to_hexa();
 }
}


void leitor(){
 LATD = 0xF7;
 LATB = hexa1[0];
 Delay_ms(T);

 LATD = 0xFB;
 LATB = hexa1[1];
 Delay_ms(T);

 LATD = 0xFD;
 LATB = hexa1[2];
 Delay_ms(T);

 LATD = 0xFE;
 LATB = hexa1[3];
 Delay_ms(T);
}


void conv_char_to_hexa(){
 for(j=0;j<4;j++){
 hexa1[j] = char_to_7seg(disp7[j]);
 Delay_ms(1);
 }
}


void teste_acerto(){

 escreve_acertou();
 mostra_men_final_1();
 descreve_acertou();

}

void escreve_acertou(){
 for (i = 0; i < 20; i++){
 if (i<6){
 acertou[i] = usuario[i];
 }else{
 acertou[i] = men_final[i-6];
 }
 }
}

void descreve_acertou(){
 for (i = 0; i < 20; i++){
 acertou[i] = ' ';
 }
}

void mostt_uu(){
 for (i = 0; i < 50800; i++){
 mostra_men_usuario();
 }
 flag_erro = 0;
}


void mostra_men_usuario(){


 for (jj = 0; jj < 4; jj++){
 disp7[jj] = usuario[cont3+jj];
 }


 cont3++;


 if (cont3 == 2){
 cont3 = 0;
 }


 aux = disp7[0];
 disp7[0] = disp7[3];
 disp7[3] = aux;
 aux = disp7[1];
 disp7[1] = disp7[2];
 disp7[2] = aux;
}

void mostra_men_final_1(){
 for (jj = 0; jj < 4; jj++){
 disp7[jj] = acertou[cont2+jj];
 }
 cont2++;

 if (cont2 == 23){
 cont2 = 0;
 }
 aux = disp7[0];
 disp7[0] = disp7[3];
 disp7[3] = aux;
 aux = disp7[1];
 disp7[1] = disp7[2];
 disp7[2] = aux;
}


void teste_erro(){
 if (flag5 == 0){
 for(ll = 0;ll < 4;ll++){
 disp7[ll]=erro[3-ll];
 }
 flag5=1;
 }else{
 for(ll = 0;ll < 4;ll++){
 disp7[ll]=' ';
 }
 flag5=0;
 }
}




void reseta_tudo(){
 contador = 0;
 cont_u = 0;
 flag = 0;
 jj = 0;
 k = 0;
 kk = 0;
 flag2 = 0;
 cont4 = 0;
 ll = 0;
 flag5 = 0;
 cont2 = 0;
 cont3 = 0;
 m = 0;
 i = 0;
 y = 9;
 flag_erro = 1;
 for (i = 0; i<6;i++){
 usuario[i] = ' ';
 }

}

void mostra_usuario(int cont3){
 switch(cont3){
 case 0:
 disp7[1] = usuario[0];
 break;
 case 1:
 disp7[1] = usuario[1];
 disp7[2] = usuario[0];
 break;
 case 2:
 disp7[1] = usuario[2];
 disp7[2] = usuario[1];
 disp7[3] = usuario[0];
 break;
 case 3:
 disp7[1] = usuario[3];
 disp7[2] = usuario[2];
 disp7[3] = usuario[1];
 break;
 case 4:
 disp7[1] = usuario[4];
 disp7[2] = usuario[3];
 disp7[3] = usuario[2];
 disp7[1] = usuario[4];
 disp7[2] = usuario[3];
 disp7[3] = usuario[2];
 break;
 }
}


int char_to_7seg(char _char){

 switch(_char){
 case ('-'):
 hexa = 0xBF;
 break;

 case(' '):
 hexa = 0xFF;
 break;

 case('a'):
 hexa = 0x88;
 break;

 case('b'):
 hexa = 0x83;
 break;

 case('c'):
 hexa = 0xC6;
 break;

 case('d'):
 hexa=0xA1;
 break;

 case('e'):
 hexa = 0x86;
 break;

 case('f'):
 hexa = 0x8E;
 break;

 case('g'):
 hexa = 0x90;
 break;

 case('h'):
 hexa = 0x8B;
 break;

 case('i'):
 hexa = 0xF9;
 break;

 case('j'):
 hexa = 0xE1;
 break;

 case('l'):
 hexa = 0xC7;
 break;

 case('n'):
 hexa = 0xAB;
 break;

 case('o'):
 hexa = 0xC0;
 break;

 case('p'):
 hexa = 0x8C;
 break;

 case('q'):
 hexa = 0x98;
 break;

 case('r'):
 hexa = 0xAF;
 break;

 case('s'):
 hexa = 0x92;
 break;

 case('u'):
 hexa = 0xC1;
 break;

 case('v'):
 hexa = 0xE3;
 break;

 case('0'):
 hexa = 0xC0;
 break;

 case('1'):
 hexa = 0xF9;
 break;

 case('2'):
 hexa = 0xA4;
 break;

 case('3'):
 hexa = 0xB0;
 break;

 case('4'):
 hexa = 0x99;
 break;

 case('5'):
 hexa = 0x92;
 break;

 case('6'):
 hexa = 0x82;
 break;

 case('7'):
 hexa = 0xF8;
 break;

 case('8'):
 hexa = 0x80;
 break;

 case('9'):
 hexa = 0x90;
 break;
 }
 return hexa;
}


 void bomba(){

 while(y >= 0){

 disp7[0] = tempo[y];
 disp7[1] = '0';
 disp7[2] = '0';
 disp7[3] = '0';


 y--;

 PORTE = 0;

 for( aa = 0 ; aa<100 ; aa++){

 if (flag_cri == 1){
 leitor(); }
 }

 for (temp = 1; temp < y; temp++){
 Delay_ms(1);
 }

 PORTE = 1;

 conv_char_to_hexa();
 }
 while(1){

 PORTD = 0xFE;
 PORTB = rand()%127;
 Delay_ms(10);
 PORTD = 0xFD;
 PORTB = rand()%127;
 Delay_ms(10);
 PORTD = 0xFB;
 PORTB = rand()%127;
 Delay_ms(10);
 PORTD = 0x07;
 PORTB = rand()%127;
 Delay_ms(10);


 if (PORTF == 0x13){

 Delay_ms(500);

 PORTE = 0;
 flag_bomba = 0;
 reseta_tudo();
 i = 0;
 for ( m = 0; m < 4; m++ ){
 disp7[m] = '-';
 }
 LATD = 0x00;
 LATB = hexa1[0];
 break;
 }

 }
 }
