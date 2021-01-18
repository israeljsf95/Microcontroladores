//Notas musicais

#define c 261
#define d 294
#define e 329
#define f 349
#define g 391
#define gS 415
#define a 440
#define aS 455
#define b 466
#define cH 523
#define cSH 554
#define dH 587
#define dSH 622
#define eH 659
#define fH 698
#define fSH 740
#define gH 784
#define gSH 830
#define aH 880


void tocar(int freq, long tempo_ms);
void marcha_imp();



void main() {
     ADPCFG = 0xFFFF;
     TRISB = 0;
     TRISD = 0;
     TRISE = 0;
     TRISF = 0;
     while(1){
        marcha_imp();
     }
}

int x;


void tocar(int freq, long tempo_ms){

    long atraso = (long)(1000000/freq);
    long loop = (long)((tempo_ms*1000)/(atraso*2));
    for (x = 0; x < loop; x++){
        PORTE = 0x01;
        while(atraso > 0){
           Delay_ms(1);
           atraso--;
        }
        PORTE = 0x00;
        while(atraso > 0){
           Delay_ms(1);
           atraso--;
        }
    }
    Delay_ms(50);
}

void marcha_imp(){
    tocar(a, 100);
    tocar(a, 100);
    tocar(a, 100);
    tocar(f, 100);
    tocar(cH, 100);

/*    tocar(a, 200);
    tocar(f, 50);
    tocar(cH, 25);
    tocar(a, 600);

    tocar(eH, 500);
    tocar(eH, 500);
    tocar(eH, 500);
    tocar(fH, 350);
    tocar(cH, 150);*/
}


