#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2/LAB1_Q2.c"
int distval[6] = {200,180,120,80,50,20};
const int distmax = 400;
const int distmin = 2;
int dist = 3;
int atual = 0;

int tamanhos[3]={31,15,22};

int marcha[31]={500,500,500,350,150,500,350,150,1000,500,500,500,350,150,500,350,150,1000,500,350,150,500,250,250,125,125,250,250,500,250,250};
int forca[15]={1000,1000,150,150,150,600,800,150,150,150,1000,150,150,150,2000};
int jb[22]={150, 150, 300, 150, 150, 250, 150, 150, 200, 75, 500, 150, 150, 300, 150, 150, 250,150, 150, 150, 150, 800};

unsigned char seg7[10] = {0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
int d[4];
int i;
int j;
int k=0;
int escolha = 0;
int mux[4] = {0x07,0xFB,0xFD,0xFE};

int cont=0;




void ativa_sensores();
void calcula_distancia();
void mostra_display();
void tocar_marcha();
void tocar_forca();
void tocar_jb();

int antigo;
int estado = 0;

void main() {
 ADPCFG = 0xFFFF;
 TRISB = 0;
 TRISD = 0;
 TRISE = 0;
 TRISF = 0;
 atual=0;

 while(1){
 calcula_distancia();
 ativa_sensores();
 mostra_display();
 atual++;
 if (PORTF == 0b00010000){
#line 54 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2/LAB1_Q2.c"
 escolha++;
 Delay_ms(500);
 }

 if ((escolha == 1) && (PORTF == 0b00100000)){
 PORTD = 0xFF;
 tocar_marcha();
 }

 if ((escolha == 2) && (PORTF == 0b00100000)){
 PORTD = 0xFF;
 tocar_forca();
 }

 if ((escolha == 3) && (PORTF == 0b00100000)){
 PORTD = 0xFF;
 tocar_jb();
 }

 if (escolha == 4){
 escolha = 0;
 }
 }
}


void calcula_distancia(){

 if(PORTF == 0x01){
 if (dist < distmax){
 dist++;
 }
 Delay_ms(10);
 }

 if(PORTF == 0x02){
 if ( dist > distmin ){
 dist--;
 }
 Delay_ms(10);
 }
}

void ativa_sensores(){

 if (dist > distval[0]){
 PORTE = 0b11111110;
 antigo = atual;
 estado = 0;
 }else if((dist > distval[1])&&(dist <= distval[0])){

 if (estado == 1){
 PORTE=0b11111101;
 }else{
 PORTE=0b11111100;
 }

 if (atual == antigo + 1500){
 antigo = atual;
 if (estado == 0){
 estado=1;
 }else{
 estado=0;
 }
 }

 }else if((dist > distval[2])&&(dist <= distval[1])){

 if (estado == 1){
 PORTE=0b11111011;
 }else{
 PORTE=0b11111010;
 }

 if (atual == antigo + 1000){
 antigo = atual;
 if (estado == 0){
 estado=1;
 }else{
 estado=0;
 }
 }

 }else if((dist > distval[3])&&(dist <= distval[2])){

 if (estado == 1){
 PORTE=0b11110111;
 }else{
 PORTE=0b11110110;
 }

 if (atual == antigo + 500){
 antigo = atual;
 if (estado == 0){
 estado=1;
 }else{
 estado=0;
 }
 }

 }else if((dist > distval[4])&&(dist <= distval[3])){

 if (estado == 1){
 PORTE=0b11101111;
 }else{
 PORTE=0b11101110;
 }

 if (atual == antigo + 375){
 antigo = atual;
 if (estado == 0){
 estado=1;
 }else{
 estado=0;
 }
 }

 }else if((dist > distval[5])&&(dist <= distval[4])){

 if (estado == 1){
 PORTE=0b11111001;
 }else{
 PORTE=0b11111000;
 }

 if (atual == antigo + 250){
 antigo = atual;
 if (estado == 0){
 estado=1;
 }else{
 estado=0;
 }
 }

 }else{
 PORTE=0b00000001;
 antigo = atual;
 estado = 0;
 }
}

void mostra_display(){
 d[3] = 0;
 d[2] = dist/100;
 d[1] = (dist%100)/10;
 d[0] = dist%10;
 for(i = 0;i < 4;i++){
 LATD = mux[i];
 LATB = seg7[d[i]];
 Delay_ms(1);
 }
}

unsigned char muxrelay[4] = {0b111111100,0b111111010,0b111110110,0b111101110};

void tocar_marcha(){
 cont = 0;
 k=0;
 while(cont < tamanhos[escolha - 1]){



 LATE=muxrelay[k];
 Delay_ms(30);
 LATE=0xFE;

 if (k<3){
 k++;
 }else{
 k=0;
 }
#line 233 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2/LAB1_Q2.c"
 for ( j = marcha[cont]; j > 0 ; j--) {
 Delay_ms(1);
 }

 cont++;


 }
}

void tocar_forca(){
 cont = 0;
 while(cont<tamanhos[escolha-1]){


 LATE=muxrelay[k];
 Delay_ms(30);
 LATE=0xFE;

 if (k<3){
 k++;
 }else{
 k=0;
 }
#line 264 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2/LAB1_Q2.c"
 for ( j = forca[cont]; j>0 ; j--) {
 Delay_ms(1);
 }

 if (cont<tamanhos[escolha-1]){
 cont++;
 }else{
 cont = 0;
 }

 }
}


void tocar_jb(){
 cont = 0;
 while(cont<tamanhos[escolha - 1]){


 LATE=muxrelay[k];
 Delay_ms(30);
 LATE=0xFE;

 if (k<3){
 k++;
 }else{
 k=0;
 }
#line 300 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/Q2/LAB1_Q2.c"
 for ( j = jb[cont]+75; j>0 ; j--) {
 Delay_ms(1);
 }

 if (cont<tamanhos[escolha - 1]){
 cont++;
 }else{
 cont = 0;
 }
 }
}
