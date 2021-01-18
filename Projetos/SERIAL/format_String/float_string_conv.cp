#line 1 "D:/Bibliotecas_Usuario/Documentos/Documentos/UFS/Microcontroladores/Projetos/SERIAL/format_String/float_string_conv.c"

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

void nFloatToStr(float f, short p, char *txt)
{
 unsigned long resultado;
 char sinal = ((char *)&f)[1].B5;
 unsigned long fator = 10;
 short i = p, j = 0;

 while (i--)
 fator *= 10;

 ((char *)&f)[1].B5 = 0;

 resultado = ((unsigned long)(f * fator) + 5) / 10;

 do
 {
 txt[j++] = resultado % 10 + '0';
 if (--p == 0)
 txt[j++] = '.';
 } while (((resultado /= 10) > 0) || (p > 0));

 if (txt[j - 1] == '.')
 txt[j++] = '0';

 if (sinal)
 txt[j++] = '-';

 txt[j] = '\0';

 for (i = 0, j--; i < j; i++, j--)
 {
 p = txt[i];
 txt[i] = txt[j];
 txt[j] = p;
 }
}

char txt_teste1[10];
char txt_teste2[10];
char txt_teste3[10];
char txt_teste4[10];
float mostrar = -3.145;

void main()
{
 ADPCFG = 0xFFFF;



 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);


 sprintf(txt_teste1, "%.2f", mostrar);
 Lcd_Out(1, 1, txt_teste1);

 while (1)
 {
 }
}
