//Configuracao do LCD
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


//Interrup??o de transmiss?o
void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
     //reseta flag
     IFS1bits.U2TXIF = 0;
}

void Tx_serial2() iv IVT_ADDR_U2TXINTERRUPT{
     //reseta flag
     IFS1bits.U2RXIF = 0;
}

//SETUP inicial da UART
void init_uart2(unsigned char baud_rate){
     U2BRG = baud_rate;
     U2MODE = 0;
     U2STA = 0;
     IFS1bits.U2TXIF = 0;
     IEC1bits.U2TXIE = 0;
     IFS1BITS.U2RXIF = 0;
     IEC1bits.U2RXIE = 1;
     U2MODEbits.UARTEN = 1;
     U2STAbits.UTXEN = 1;
}

int cont = 0;
int valor;

/*
void timer() iv IVT_ADDR_T1INTERRUPT {
    cont++;

    if (cont == valor+1){
       LATBbits.LATB0 = 0;
    }
    if (cont == 99){
       LATBbits.LATB0 = 1;
       cont = 0;
    }

    IFS0bits.T1IF = 0;
}*/

//Bloco para enviar do PC para o micro
void enviar_char(unsigned char c){
     while(U2STAbits.UTXBF);
     U2TXREG = c;
}

int cont_str;
void enviar_string(unsigned char *s){
    cont_str = 0;
    while(s[cont_str]){
      enviar_char(s[cont_str++]);
    }
}

//Receber do Micro para o PC
unsigned char receber_char(){
         unsigned char c;
         while(!U2STAbits.URXDA);
         c = U2RXREG;
         return c;
}

int cont_rec_str;
int flag_rec = 0;
char end_line;
char tmp;

void receber_string(char *rec, short int max){
   cont_rec_str = 0;
   tmp = 1;
   for(cont_rec_str = 0; ((cont_rec_str < max) && ((tmp != end_line))); cont_rec_str++){
     tmp = receber_char();
     rec[cont_rec_str] = tmp;
   }
   //rec[cont_rec_str] = '\0';
   //flag_rec = 1;
}
//int i;
//unsigned char m2[] = "OL? MUNDO \r\n";
//

char recebido[100] = "";

char mC[4][100] = {"Oi, PC tudo bem?\r\n\0",
                    "Por favor digita a palavra 'leds' para ligar e desligar os leds a cada 0.5s\r\n\0",
                    "Agora digita a palavra PWM, chama na grande!\r\n\0",
                    "Obrigado! Digite PARAR para 'parar' e apitar o Buzzer!\r\n\0"};
char pC[6][100] = {"Tudo bem e você?",
                   "Tá bom.",
                   "Sem problema.",
                   "PWM",
                   "PARAR"};

int  tam_mC_vet[4] = {16, 75, 44, 54};
int  tam_pC_vet[5] = {16, 7, 13, 3, 5};
char txt[20];
int i;
int flag_1 = 0;

unsigned char m;
void main(){
     ADPCFG = 0xFFFF;
     TRISB = 0;
     LATB = 0;
     init_uart2(103);
     //enviar_char(0x30);
   //  i = 0;
     IEC0bits.T1IE = 1;
     IFS0 = 0;
     PR1 = 625;
     T1CON = 0x8000;
     valor = 0;
     Lcd_Init();               // Initializa o LCD
     Lcd_Cmd(_LCD_CLEAR);      // Limpa o display
     Lcd_Cmd(_LCD_CURSOR_OFF); // Desativa o cursor
     //la?o do programa
     IntToStr(strlen(mC4), txt);
     //for (i=0; i < tam_mC_vet[i]; i++){
     //     Lcd_Out(1, i+1, mC1[i]);
     //}
     Lcd_Out(1,1, mC1);
     Delay_ms(1000);
     //Lcd_Out(1,1, txt);
     
     while(1){

           if(strcmp(tmp, pC4) == 0){
             IntToStr(txt, strcmp(tmp, pC4));
             enviar_string(txt);
           }else{
             tmp = receber_char();
           }

           //Delay_ms(2500);
         //}
     }
}