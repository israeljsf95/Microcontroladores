#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/LAB3/Petersson/LAB3/LAB3_Q1.c"

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



char txt1[]= "Sampling Time";
char txtmeioseg[] = "0.5 s   ";
char txtumseg[] = "1 s    ";
char txtdezseg[] = "10 s   ";
char txtummin[] = "1 min   ";
char txtumahora[] = "1 hora   ";
int flag_botao = 0;
int flag_seleciona = 0;
int PRs[5] = {1,2,20,120,7200};
int contador_tempo = 0;

void temporizador() iv IVT_ADDR_T1INTERRUPT {
 contador_tempo++;
 IFS0bits.INT0IF = 0;
}


void botao() iv IVT_ADDR_INT0INTERRUPT {
 flag_botao++;
 contador_tempo = 0;
 flag_seleciona = 0;
 if (flag_botao > 4){
 flag_botao = 0;
 }
 Delay_ms(50);
 IFS0bits.INT0IF = 0;
}

void seleciona() iv IVT_ADDR_INT2INTERRUPT {
 flag_seleciona = 1;
 contador_tempo = 0;
 Delay_ms(50);
 IFS1bits.INT1IF = 0;
}

void main() {
 ADPCFG = 0xFFFF;

 IEC0bits.INT0IE = 1;
 IEC1bits.INT2IE = 1;
 IEC0bits.T1IE = 1;
 T1CON = 0x8030;
 PR1 = 31250;
 IFS0 = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 while(1){
 if (flag_seleciona == 0){
 switch(flag_botao){
 case 0:
 Lcd_Out(2,1,txtmeioseg);
 break;
 case 1:
 Lcd_Out(2,1,txtumseg);
 break;
 case 2:
 Lcd_Out(2,1,txtdezseg);
 break;
 case 3:
 Lcd_Out(2,1,txtummin);
 break;
 case 4:
 Lcd_Out(2,1,txtumahora);
 break;
 default:
 break;
 }
 Lcd_Out(1,1,txt1);
 }else{
 switch(flag_botao){
 case 0:
 if (contador_tempo == PRs[flag_botao]){
 contador_tempo = 0;
 }
 break;
 case 1:
 if (contador_tempo == PRs[flag_botao]){
 contador_tempo = 0;
 }
 break;
 case 2:
 if (contador_tempo == PRs[flag_botao]){
 contador_tempo = 0;
 }
 break;
 case 3:
 if (contador_tempo == PRs[flag_botao]){
 contador_tempo = 0;
 }
 break;
 case 4:
 if (contador_tempo == PRs[flag_botao]){
 contador_tempo = 0;
 }
 break;
 default:
 break;
 }
 }
 }
}
