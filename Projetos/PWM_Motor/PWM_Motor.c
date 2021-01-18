
// LCD module connections
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
// End LCD module connections



unsigned char txt[15];
unsigned char txt2[15];
float tensao;
int hab_motor = 1;
int chave1 = 1;
int chave2 = 0;
int chave3 = 1;
int chave4 = 0;
float PWM_1;
int convertido;
int flag;

void PWM() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
     if (flag == 0){
         PR1 = floor(32000*convertido/1023);

     }else{
         PR1 = floor(32000*(1 - convertido/1023));
     }
     flag =~flag;
     IFS0bits.T1IF = 0;
}

void main() {
     flag = 0;
     ADPCFG = 0xFEFF;//PINO RB8 como entrada analogica
     TRISB = 0xFFFF;
     
     IFS0 = 0;
     TMR1 = 0;
     IEC0bits.T1IE = 1;
     T1CON = 0x8000;
     PR1 =  32000;
     
     //Config do ADCON1:adc desligado, Formato de Saida: inteiro, Amostragem Conversao Manual
     ADCON1 = 0;
     //tensao de ref: AVDD e AVSS, sem varredura, conversao pelop canal 0
     //interrupcao apos uma amostra buffer como palavra de 16bits
     ADCON2 = 0;
     //config do SRF ADCON3: para o clock do ADC de 500khz, tempo de auto-amostragem = 0  TAD
     //fonte do clock: ciclo da maquina
     ADCON3 = 0x0007; // Tad  = 4*Tcy = 4*62.5ns = 250ns > 153.85ns (qnd Vdd = 4.5 a 5.5v)
     ADCON3 = 0x000B; // Tad  = 6*Tcy = 6*62.5ns = 375ns > 256.41ns (qnd Vdd = 3 a 5.5v)
     //Configuracao do SRF ADCHS: seleciona o canal CH0, configura entrada analogica AN8 (RB8)
     //entrada de referencia negativa do CHO igual a Vref-
     ADCHS = 0x0000;
     ADCHSbits.CH0SA = 8; // seleciona a entrada analogica 8
     //Configuracao do SRD ADCSSL: varredura desativada
     ADCSSL = 0;
     ADCON1bits.ADON = 1; //Ativa o ADC

     //Configuracao do LCD
     Lcd_Init();                // Inicializa o LCD
     Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
     Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor

     while(1){
         ADCON1bits.SAMP = 1; //Inicia a amostragem
         delay_us(10); // Espera a amostragem
         ADCON1bits.SAMP = 0; //para a amostragem e inicia a conversao
         while(!ADCON1bits.DONE); // Aguarda o fim da conversao
         convertido = ADCBUF0; // Ler o valor convertido no canal 0 do  ADC
         tensao = (convertido*5.0)/1023; //Calculo da tensao de entrada
         PWM_1 = floor(tensao*20);

         FloatToStr(tensao, txt);
         IntToStr(PWM_1, txt2);
         Lcd_Cmd(_LCD_CLEAR);       // Limpa o display
         Lcd_Cmd(_LCD_CURSOR_OFF);  // Desativa o cursor
         Lcd_Out(1,1, txt);
         Lcd_Out(2,1, txt2);
         delay_ms(500);
     }
}