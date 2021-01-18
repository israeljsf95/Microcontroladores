int ti;

void relogio() iv IVT_ADDR_T1INTERRUPT {
     ti = ~ti;
     IFS0 = IFS0 & 0xFFF7;
}

estado=0;

void botao() iv IVT_ADDR_INT0INTERRUPT ics ICS_AUTO {
     Delay_ms(50);
     estado = ~estado;
     IFS0 = IFS0 & 0xFFFE;
}


void main() {
     ADPCFG=0xFFFF;
     TRISB=0;
     TRISE=0x0010;
     TMR1=0;
     IFS0=0;
     IEC0=0x0008;
     PR1=31250;
     T1CON=0x8030;
     while(1){
            if (estado == 0){
               LATB= 0;
               PR1=31250;
               T1CON=0x8030;
            }else{
               LATB=1;
               PR1=800;
               T1CON=0x8000;
            }
     }
}