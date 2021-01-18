//Frequencímetro: Israel, Petersson e Luisa
//Laboratorio 2




/*void contador_alta() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {

} */


void INT0Int() iv IVT_ADDR_INT0INTERRUPT{

}

/*void EXT0Int() iv IVT_ADDR_INT0INTERRUPT{

}*/


// LCD module connections
sbit LCD_RS at LATE5_bit;
sbit LCD_EN at LATE4_bit;
sbit LCD_D4 at LATE0_bit;
sbit LCD_D5 at LATE1_bit;
sbit LCD_D6 at LATE2_bit;
sbit LCD_D7 at LATE3_bit;

sbit LCD_RS_Direction at TRISE5_bit;
sbit LCD_EN_Direction at TRISE4_bit;
sbit LCD_D4_Direction at TRISE0_bit;
sbit LCD_D5_Direction at TRISE1_bit;
sbit LCD_D6_Direction at TRISE2_bit;
sbit LCD_D7_Direction at TRISE3_bit;


long int cont_pulso = 0;
long int passado = 0;
long int frequencia;
char txt[15];
char txt4[] = "example";

void contador_pulsos() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
   frequencia = cont_pulso;
   cont_pulso = 0;
   IFS0bits.T1IF = 0;
}

void PWM() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO {
     IFS0bits.T2IF = 0;
     LATBbits.LATB5 = ~LATBbits.LATB5;
}

void main() {
     ADPCFG = 0xFFFF;
     TRISE = 0;
     TRISB = 0;
     LATB = 0;
     //TRISBbits.TRISB8 = 1;
     Lcd_Init();
     
     //flags de interrupcoes e configuracao dos registradores
     //do timer
     IFS0 = 0;
     IEC0 = 0;
     IEC0bits.T1IE = 1;
     IEC0bits.T2IE = 1;
     IEC0bits.INT0IE = 1;
     INTCON2bits.INT0EP = 0;
     PR1 = 62500; //ate 1 segundo
     PR2 = 400;
     T1CON = 0x8030;
     T2CON = 0x8030;
     Lcd_Cmd(_LCD_CLEAR);               // Clear display
     Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off


     while(1){
         if ((LATBbits.LATB5 == 1)&(passado == 0)){
            cont_pulso++;
         }
         passado = LATBbits.LATB5;
         
         IntToStr(frequencia, txt);
         Lcd_Out(1,10,txt);
     }
     
}