//Comandos para configurar a serial do Arduino para ler os dados enviados do DSPIC
String pic;
String pic2 = "TOMA PIC";
String pic3 = "OLAR PIC";


void setup() {
  pinMode(8, OUTPUT);
  Serial.begin(19200);
}
  
int pic_num;

void loop() {
    
    if (Serial.available() > 0) {
      pic = Serial.readStringUntil('\0');
      pic_num = pic.toInt();
      if (pic_num == 1){
        Serial.write("LED LIGADOi");
        digitalWrite(8, HIGH);
        delay(200);
      }else{
        Serial.write("LED DESLIGADOi");
        digitalWrite(8, LOW);
        delay(200);
      }  
    }
    delay(300);
   
}



uint8_t ler_num(void) {
  uint8_t num; 
  while (num == 0) {
    while (! Serial.available());
    num = Serial.parseInt();
  }
  return num;
}

void comando_pic(int num){
  switch(num){
    case 1:
      Serial.println("RECEBENDO COMANDO 1 !!!");
      digitalWrite(8, HIGH);
      break; 
    
    case 2:
      Serial.println("RECEBENDO COMANDO 2 !!!");
      digitalWrite(8, LOW);
      break;
    
    case 3:
      Serial.println("RECEBENDO COMANDO 3 !!!");
      digitalWrite(8, HIGH);
      break;

    case 4:
      Serial.println("RECEBENDO COMANDO 4 !!!");
      digitalWrite(8, LOW);
      break;
    
    case 5:
      Serial.println("RECEBENDO COMANDO 5 !!!");
      digitalWrite(8, HIGH);
      break;
    
    default:
      Serial.println("COMANDO DESCONHECIDO!!!");
      digitalWrite(8, LOW);
  }


}
