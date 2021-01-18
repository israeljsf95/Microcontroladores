//tempo ligado 10us
int lig;
int conflig;
//tempo desligado 100ms
int desl;
int confdesl;
int estado;
float dist;


//Configuracao do LCD
char txt1[]= "Dist: ";
char txt2[5];

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
// End LCD module connections


void contador() iv IVT_ADDR_T1INTERRUPT ics ICS_AUTO {
     IFS0 = 0;
     if (estado == 0){
        PR1 = desl;
        T1CON = confdesl;
        LATFbits.LATF1 = 0;
        //dist = TMR1;

     }else{
        PR1 = lig;
        T1CON = conflig;
        LATFbits.LATF1 = 1;
        //TMR1 = 0;
     }
     //TMR1 = 0;
     estado = ~estado;
}

void distancia() iv IVT_ADDR_T2INTERRUPT ics ICS_AUTO{
     IFS0 = 0;
     dist = TMR2/58.8;
     IntToStr(dist, txt2);//    ' Convert float to string
          //txt2[5] = 0;          //    ' Terminate the string at 4-th place (the result will have 4 digits)
     Lcd_Out(2, 5, txt2);
     TMR2 = 0;
}


void main() {
     ADPCFG = 0xFFFF;
     TRISF = 0 ;
     IEC0bits.T1IE = 1;
     IEC0bits.T2IE = 1;
     IFS0 = 0;
     
     lig = 16000;
     desl = 6250;
     
     confdesl = 0x8030;
     conflig = 0x8000;
     
     estado = 0;
     
     PR1 = desl;
     PR2 = 0xFFFF;
     T1CON = conflig;
     T2CON = 0x8040; //Gate acumulation
     LATF = 0;
     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);               // Clear display
     Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
     Lcd_Out(1,6,txt1);
     while(1){
     }

}