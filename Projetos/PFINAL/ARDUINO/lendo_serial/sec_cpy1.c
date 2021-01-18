//Comandos para configurar a serial do Arduino para ler os dados enviados do DSPIC
String pic;

int flag = 1;
char buf[100] = " ";
void setup()
{
  pinMode(8, OUTPUT);
  Serial.begin(9600);
  Serial.println("Comecei"); // so I can keep track of what is loaded
}

String string = "olar";
int pic_num;

void loop()
{

  pic_num = Serial.parseInt();
  comando_pic(pic_num);
  delay(1500);
  /*if (Serial.available()){
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
    }*/
}

void comando_pic(int num)
{
  switch (num)
  {
  case 1:
    Serial.println('RECEBENDO COMANDO 1 !!!');
    digitalWrite(8, HIGH);
    break;

  case 2:
    Serial.println('RECEBENDO COMANDO 2 !!!');
    digitalWrite(8, LOW);
    break;

  case 3:
    Serial.println('RECEBENDO COMANDO 3 !!!');
    digitalWrite(8, HIGH);
    break;

  case 4:
    Serial.println('RECEBENDO COMANDO 4 !!!');
    digitalWrite(8, LOW);
    break;

  case 5:
    Serial.println('RECEBENDO COMANDO 5 !!!');
    digitalWrite(8, HIGH);
    break;

  default:
    Serial.println('COMANDO DESCONHECIDO!!!');
    digitalWrite(8, LOW);
  }
}