


//Teste da geração da onda de ativacao do Sensor

int t2;
int t1;
int aux1_pr1;
int aux2_pr1;
int aux1_psk1;
int aux2_psk1;
int aux_echo;
int bord_sub;
int bord_des;
float dist;
//char txt1[6] = {'D','i','s','t',':',' '};
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



void relogio() iv IVT_ADDR_T1INTERRUPT {

     if (PR1 == aux1_pr1){
        PR1 = aux2_pr1;
        T1CON = aux1_psk1;
        LATF = 0x0002;
     }else{
        PR1 = aux1_pr1;
        T1CON = aux2_psk1;
        LATF = 0x0000;
     }
     TMR1 = 0;
     IFS0 = 0;
}

void calc_dist() iv IVT_ADDR_T2INTERRUPT {
     IFS0 = 0;
     dist = TMR2/58.8;
     TMR2 = 0;
}

void main() {
     ADPCFG = 0xFFFF;
     //TRISB = 0;
     TRISF = 0;
     LATF = 0x0000;
     TMR1 = 0;//onda de 10micro
     t1 = 0;
     t2 = 0;
     TMR2 = 0;//onda de 500mili
     IFS0 = 0;//
     IEC0 = 0x00C8;//habilitacao do timer1
     aux_echo = 0;
     aux1_pr1 = 160; //10E-6
     //aux2_pr1 = 31250;//500e-3
     aux2_pr1 = 6000;
     aux1_psk1 = 0x8030;
     aux2_psk1 = 0x8000;
     
     T1CON = aux1_psk1;
     
     T2CON = 0x8040;
	 PR1 = aux2_pr1;
     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);               // Clear display
     Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
     Lcd_Out(1,6,txt1);
     
     while(1){
     //     FloatToStr(dist, txt2);//    ' Convert float to string
     //     txt2[5] = 0;          //    ' Terminate the string at 4-th place (the result will have 4 digits)
     //     Lcd_Out(2, 5, txt2);
     }
}