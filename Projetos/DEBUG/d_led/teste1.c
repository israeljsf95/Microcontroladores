void main() {
    ADPCFG = 0xFFFF;
    TRISB = 0;
    
    while(1){
      LATB = 0b111111111;
    }
}