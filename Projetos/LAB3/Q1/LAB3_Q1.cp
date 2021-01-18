#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Q1/LAB3_Q1.c"

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



char txtmeioseg[] = "0.5 seg";
char txtumseg[] = "1 seg";
char txtdezseg[] = "10 seg";
char txtummin[] = "1 min";
char txtumahora[] = "1 hora";



int flag_botao = 0;

void botao() iv IVT_ADDR_INT0INTERRUPT {
 flag_botao++;
 if (flag_botao > 4){
 flag_botao = 0;
 }
 Delay_ms(50);
 IFS0bits.INT0IF = 0;
}


void main() {
 ADPCFG = 0xFFFF;

 IEC0bits.INT0IE = 1;

 IFS0 = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 switch(flag_botao){
 case 0:
 Lcd_Out(1,1,txtmeioseg);
 break;
 case 1:
 Lcd_Out(1,1,txtumseg);
 break;
 case 2:
 Lcd_Out(1,1,txtdezseg);
 break;
 case 3:
 Lcd_Out(1,1,txtummin);
 break;
 case 4:
 Lcd_Out(1,1,txtumahora);
 break;
 default:
 break;
 }

 }
}
