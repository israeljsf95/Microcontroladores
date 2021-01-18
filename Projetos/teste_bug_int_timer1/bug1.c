void relogio() iv IVT_ADDR_T1INTERRUPT {
     IFS0 = 0;
     LATFbits.LATF0 = ~LATFbits.LATF0;
}

void main() {
    ADPCFG = 0xFFFF;
    TRISF = 0;
    LATF = 0;
    IFS0 = 0;
    IEC0 = 0x0008;
    PR1 = 160;
    T1CON = 0x8030;
    TMR1 = 0;
    while(1){

    }
}