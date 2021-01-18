#define motor LATBbits.LATB3
#define led1 LATBbits.LATB0
#define led2 LATBbits.LATB1

// conexoes do LCD
sbit LCD_RS at LATE5_bit;
sbit LCD_EN at LATE4_bit;
sbit LCD_D4 at LATE3_bit;
sbit LCD_D5 at LATE2_bit;
sbit LCD_D6 at LATE1_bit;
sbit LCD_D7 at LATE0_bit;

sbit LCD_RS_Direction at TRISE5_bit;
sbit LCD_EN_Direction at TRISE4_bit;
sbit LCD_D4_Direction at TRISE3_bit;
sbit LCD_D5_Direction at TRISE2_bit;
sbit LCD_D6_Direction at TRISE1_bit;
sbit LCD_D7_Direction at TRISE0_bit;

int soma,count;
int *ADC16Ptr;
int media[3];
char txt[16];
float temp,LDR,pot;
int flag_criatividade;
float duty2,duty4;
char aux[2];
int PRx = 25000; //10 Hertz
//Ativa e desativa criatividade
void criatividade() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
    Delay_ms(100);
    flag_criatividade = ~flag_criatividade;
    IFS0bits.INT0IF = 0;
}
//Gera o PWM para motor
void PWMmotor() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
     if(flag_criatividade == 0){
           motor = ~motor;
     }else{
           led1 = ~led1;
     }
     IFS0bits.T2IF = 0;
}
//Gera o PWM para os leds
void PWMleds() iv IVT_ADDR_T4INTERRUPT ics ICS_AUTO {

     if(flag_criatividade == 0){
           led1 = ~led1;
           led2 = ~led2;
     }else{
           led2 = ~led2;
     }

     IFS1bits.T4IF = 0;
}

//faz a conversao a cada 0.5s
void conversao_temporizada() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO{

    IFS0bits.T1IF = 0;

     //conversao de RB2 (temperatura)
        ADCHSbits.CH0SA = 0b0010;  //liga o canal 0 na entrada RB2
        soma = 0;                  //reseta soma
        ADC16Ptr = &ADCBUF1;       //pega o endereço do segundo buffer
        IFS0bits.ADIF = 0;         //reseta flag da interrupção do ADC
        ADCON1bits.ASAM = 1;       //inicia amostragem automatica
        while (!IFS0bits.ADIF);    //Espera conversao acabar
        ADCON1bits.ASAM = 0;       //desliga amostragem automatica
        for (count = 1; count < 16; count++)
            soma = soma + *ADC16Ptr++; //descarta a primeira amostra
        media[0] = soma/15;            //calcula a media

    //conversao de RB5 (LDR)
        ADCHSbits.CH0SA = 0b0101;
        soma = 0;
        ADC16Ptr = &ADCBUF1;
        IFS0bits.ADIF = 0;
        ADCON1bits.ASAM = 1;
        while (!IFS0bits.ADIF);
        ADCON1bits.ASAM = 0;
        for (count = 1; count < 16; count++)
            soma = soma + *ADC16Ptr++;
        media[1] = soma/15;

    //conversao de RB7 (potenciometro)
        ADCHSbits.CH0SA = 0b0111;
        soma = 0;
        ADC16Ptr = &ADCBUF1;
        IFS0bits.ADIF = 0;
        ADCON1bits.ASAM = 1;
        while (!IFS0bits.ADIF);
        ADCON1bits.ASAM = 0;
        for (count = 1; count < 16; count++)
            soma = soma + *ADC16Ptr++;
        media[2] = soma/15;

     //Calculo dos valores de temperatura e tensao
        temp = (float)media[0]*0.488758;
        LDR = (float)media[1]*5/1023;
        pot = (float)media[2]*5/1023;

}

void main() {
    //COnfiguração das portas de Entrada
    ADPCFG = 0xFFFF;
    ADPCFGbits.PCFG2 = 0;
    ADPCFGbits.PCFG5 = 0;
    ADPCFGbits.PCFG7 = 0;

    TRISB = 0;
    TRISBbits.TRISB2 = 1;
    TRISBbits.TRISB5 = 1;
    TRISBbits.TRISB7 = 1;

    //Interrupções dos botoes
    TRISEbits.TRISE8 = 1;
    IEC0bits.INT0IE = 1;
    IFS0 = 0;
    IFS1 = 0;

    //Configurações do ADC
    ADCHSbits.CH0SA = 0b0010; //Iniciar conversao pelo pino RB2
    ADCSSL = 0;

    ADCON1 = 0;
    ADCON1bits.SSRC = 0b010; // Clock pelo timer 3

    TMR3 = 0x0000;     //Configurando timer 3 para 8Khz
    PR3 = 2000;
    T3CON = 0x8000;

    ADCON2 = 0;
    ADCON2bits.SMPI = 0b1111; // Interrupção depois de 16 conversões
    ADCON3 = 0x0008; // 15Tad


    //Configurando o Timer 1 para 0.5 s
    IEC0bits.T1IE = 1;
    TMR1 = 0x0000;
    PR1 = 31250;
    T1CON = 0x8030;


    //Configurando o Timer 2
    IEC0bits.T2IE = 1;
    TMR2 = 0x0000;
    PR2 = PRx;    //10Hertz
    T2CON = 0x8020;

    //Configurando o Timer 4
    IEC1bits.T4IE = 1;
    TMR4 = 0x0000;
    PR4 = PRx;   //10Hertz
    T4CON = 0x8020;

    //Inicialização de outras variaveis
    flag_criatividade = 0;
    led1 = 0;
    led2 = 0;
    motor = 0;

    //LCD
    Lcd_Init();               // Inicializa o LCD
    Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
    Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor

    ADCON1.ADON = 1;    //Liga o ADC

    while(1){
    Lcd_Cmd(_LCD_CLEAR);

          if(flag_criatividade == 0){
                duty2 = temp/100;
                duty4 = LDR/5;

                if (motor == 0){
                     PR2 = floor((1 - duty2)*PRx);
                }else{
                     PR2 =  floor(duty2*PRx);
                }

                if (led1 == 0){
                     PR4 = floor((1 - duty4)*PRx);
                }else{
                     PR4 =  floor(duty4*PRx);
                }

                Lcd_Out(1,1,"Potenciometro       ");

                if (pot < 0.1){
                   pot = 0;
                }

                FloatToStr(pot,txt);//mostra tensao do potenciometro

                if (pot < 1){
                     aux[0] = txt[0];
                     aux[1] = txt[3];
                     txt[0] = '0';
                     txt[2] = aux[0];
                     txt[3] = aux[1];
                }
                Lcd_Out(2,1,txt);
                Lcd_Out(2,5,"              ");

          }else{

                duty2 = pot/5;
                duty4 = LDR/5;

                if (led1 == 0){
                     PR2 = floor((1 - duty2)*PRx);
                }else{
                     PR2 =  floor(duty2*PRx);
                }

                if (led2 == 0){
                     PR4 = floor((1 - duty4)*PRx);
                }else{
                     PR4 =  floor(duty4*PRx);
                }

                if(temp > 40){
                      motor = 1;
                      Lcd_Out(1,1,"      PERIGO       ");
                      Lcd_Out(2,1,"    RESFRIANDO     ");
                }else{
                      Lcd_Out(1,1,"    TEMPERATURA    ");
                      Lcd_Out(2,1,"      NORMAL       ");
                }
          }
          Delay_ms(500);
    }
}