#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/toca/toca2.c"

int delays[31]={500,500,500,350,150,500,350,150,1000,500,500,500,350,150,500,350,150,1000,500,350,150,500,250,250,125,125,250,250,500,250,250};
int delays2[15]={1000,1000,150,150,150,600,800,150,150,150,1000,150,150,150,2000};
int jb[22]={150, 150, 300, 150, 150, 250, 150, 150, 200, 75, 500, 150, 150, 300, 150, 150, 250,150, 150, 150, 150, 800};
int cont=0;

int i;

unsigned char mux[4] = {0b11111100,0b11111010,0b11110110,0b11101110};
int k=0;

void main() {
 ADPCFG=0xFFFF;
 TRISE=0;

 while(1){


 LATE=mux[k];
 Delay_ms(30);
 LATE=0xFE;

 if (k<4){
 k++;
 }else{
 k=0;
 }
#line 35 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB1/toca/toca2.c"
 for ( i=jb[cont]+75; i>0 ; i--) {
 Delay_ms(1);
 }
 if (cont<22){
 cont++;
 }else{
 cont=0;
 }
 }
}
