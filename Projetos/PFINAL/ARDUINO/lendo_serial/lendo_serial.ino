

//Comandos para configurar a serial do Arduino para ler os dados enviados do DSPIC
String pic;

int flag = 1;
char buf[100] = " ";
void setup() {
  Serial.begin(9600);
  Serial.println("Comecei"); // so I can keep track of what is loaded
}

String string = "olar";  
void loop() {
  
  if (Serial.available()){
    Serial.println("OlAR PIC");
    delay(500);
    //Serial.println("Recebendo Mensagem do PIC!!!");
    //pic = Serial.readStringUntil('\0');  //gets one byte from serial buffer
    //delay(500);
    //Serial.println(pic);
    //flag = pic.compareTo(string);
    //if (flag == 0){Serial.println("Acertou MIZERAVI"); Serial.write("Acertou", 7); delay(1500); };
    //delay(1500);
  //}else{
    //Serial.println("Esperando PIC!!!");
    //delay(1000);
    }
}
