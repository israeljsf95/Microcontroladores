/*************************************************** 
  This is an example sketch for our optical Fingerprint sensor

  Designed specifically to work with the Adafruit BMP085 Breakout 
  ----> http://www.adafruit.com/products/751

  These displays use TTL Serial to communicate, 2 pins are required to 
  interface
  Adafruit invests time and resources providing this open source code, 
  please support Adafruit and open-source hardware by purchasing 
  products from Adafruit!

  Written by Limor Fried/Ladyada for Adafruit Industries.  
  BSD license, all text above must be included in any redistribution
 ****************************************************/

#include <Adafruit_Fingerprint.h>

// On Leonardo/Micro or others with hardware serial, use those! #0 is green wire, #1 is white
// uncomment this line:
// #define mySerial Serial1

// For UNO and others without hardware serial, we must use software serial...
// pin #2 is IN from sensor (GREEN wire)
// pin #3 is OUT from arduino  (WHITE wire)
// comment these two lines if using hardware serial

//Variaveis para ler as coisas que virão do PIC
String pic; //leitura da mensagem DSPIC

int escolha; //armazenamento da escolha

SoftwareSerial mySerial(2, 3);

Adafruit_Fingerprint finger = Adafruit_Fingerprint(&mySerial);

void setup()
{
  Serial.begin(9600);
  while (!Serial)
    ; // For Yun/Leo/Micro/Zero/...
  delay(100);
  Serial.println("\n\nAdafruit Sensor Biométrico Teste");

  // set the data rate for the sensor serial port
  finger.begin(57600);
  delay(5);
  if (finger.verifyPassword())
  {
    Serial.println("Sensor de Digitais Encontrado!");
  }
  else
  {
    Serial.println("Sensor de Digitais nao Encontrado :(");
    while (1)
    {
      delay(1);
    }
  }

  finger.getTemplateCount();
  Serial.print("Sensor Contem: ");
  Serial.print(finger.templateCount);
  Serial.println(" modelos");
  Serial.println("Encoste o dedo para validar...");
}

void loop() // run over and over again
{
  getFingerprintIDez();
  delay(50); //don't ned to run this at full speed.
}

//Funcao para ler o numero da Serial, o número que será lido vai ser enviado do
//PC para o DSPIC, do PIC para o ARDUINO
uint8_t readnumber(void)
{

  while (num == 0)
  {
    while (!Serial.available())
      ;
    num = Serial.parseInt();
  }
  return num;
}

//Função para deletar um dado modelo adicionao ao banco de digitais do sensor
uint8_t deleteFingerprint(uint8_t id)
{
  uint8_t p = -1;

  p = finger.deleteModel(id);

  if (p == FINGERPRINT_OK)
  {
    Serial.println("Deletado!");
  }
  else if (p == FINGERPRINT_PACKETRECIEVEERR)
  {
    Serial.println("Erro de Comunicacao!");
    return p;
  }
  else if (p == FINGERPRINT_BADLOCATION)
  {
    Serial.println("Nao e possivel deletar nesta localizacao");
    return p;
  }
  else if (p == FINGERPRINT_FLASHERR)
  {
    Serial.println("Erro ao escrever na memoria FLASH");
    return p;
  }
  else
  {
    Serial.print("Erro desconhecido: 0x");
    Serial.println(p, HEX);
    return p;
  }
}

//Função para adquirir um modelo de digital já armazenado no data set
uint8_t getFingerprintID()
{
  uint8_t p = finger.getImage();
  switch (p)
  {
  case FINGERPRINT_OK:
    Serial.println("Imagem Tirada");
    break;
  case FINGERPRINT_NOFINGER:
    Serial.println("Nenhum dedo detectado");
    return p;
  case FINGERPRINT_PACKETRECIEVEERR:
    Serial.println("Erro de comunicacao");
    return p;
  case FINGERPRINT_IMAGEFAIL:
    Serial.println("Erro na Imagem");
    return p;
  default:
    Serial.println("Erro desconhecido");
    return p;
  }

  // OK success!

  p = finger.image2Tz();
  switch (p)
  {
  case FINGERPRINT_OK:
    Serial.println("Imagem Convertida");
    break;
  case FINGERPRINT_IMAGEMESS:
    Serial.println("Imagem muito Baguncada");
    return p;
  case FINGERPRINT_PACKETRECIEVEERR:
    Serial.println("Erro de Comunicacao");
    return p;
  case FINGERPRINT_FEATUREFAIL:
    Serial.println("Nao achou caracteristicas das digitias");
    return p;
  case FINGERPRINT_INVALIDIMAGE:
    Serial.println("Caracateristicas das Digitais nao encontrada");
    return p;
  default:
    Serial.println("Erro Desconhecido");
    return p;
  }

  // OK converted!
  p = finger.fingerFastSearch();
  if (p == FINGERPRINT_OK)
  {
    Serial.println("Achou Modelo no banco de dados!");
  }
  else if (p == FINGERPRINT_PACKETRECIEVEERR)
  {
    Serial.println("Erro de comunicacao");
    return p;
  }
  else if (p == FINGERPRINT_NOTFOUND)
  {
    Serial.println("Modelo nao presente no banco de dados!");
    return p;
  }
  else
  {
    Serial.println("Erro Desconhecido");
    return p;
  }

  // found a match!
  Serial.print("Achou ID #");
  Serial.print(finger.fingerID);
  Serial.print(" com confianca de ");
  Serial.println(finger.confidence);

  return finger.fingerID;
}

// returns -1 if failed, otherwise returns ID #
int getFingerprintIDez()
{
  uint8_t p = finger.getImage();
  if (p != FINGERPRINT_OK)
    return -1;

  p = finger.image2Tz();
  if (p != FINGERPRINT_OK)
    return -1;

  p = finger.fingerFastSearch();
  if (p != FINGERPRINT_OK)
    return -1;

  // found a match!
  Serial.print("Achou ID #");
  Serial.print(finger.fingerID);
  Serial.print(" com confianca de ");
  Serial.println(finger.confidence);
  return finger.fingerID;
}

//Funcao para adquirir um modelo e colocar no banco de dados
uint8_t getFingerprintEnroll()
{

  int p = -1;
  Serial.print("Esperando para validar a digital #");
  Serial.println(id);
  while (p != FINGERPRINT_OK)
  {
    p = finger.getImage();
    switch (p)
    {
    case FINGERPRINT_OK:
      Serial.println("Imagem Tirada");
      break;
    case FINGERPRINT_NOFINGER:
      Serial.println(".");
      break;
    case FINGERPRINT_PACKETRECIEVEERR:
      Serial.println("Erro de Comunicacao");
      break;
    case FINGERPRINT_IMAGEFAIL:
      Serial.println("Erro de Imagem");
      break;
    default:
      Serial.println("Erro Desconhecido");
      break;
    }
  }

  // OK success!

  p = finger.image2Tz(1);
  switch (p)
  {
  case FINGERPRINT_OK:
    Serial.println("Imagem Convertida");
    break;
  case FINGERPRINT_IMAGEMESS:
    Serial.println("Imagem Bagunçada");
    return p;
  case FINGERPRINT_PACKETRECIEVEERR:
    Serial.println("Erro de Comunicacao");
    return p;
  case FINGERPRINT_FEATUREFAIL:
    Serial.println("Caracteristicas Digitais nao Encontradas");
    return p;
  case FINGERPRINT_INVALIDIMAGE:
    Serial.println("Caracteristicas Digitais nao Encontradas");
    return p;
  default:
    Serial.println("Erro Desconhecido");
    return p;
  }

  Serial.println("Remova o dedo!");
  delay(2000);
  p = 0;
  while (p != FINGERPRINT_NOFINGER)
  {
    p = finger.getImage();
  }
  Serial.print("ID ");
  Serial.println(id);
  p = -1;
  Serial.println("Coloque o mesmo dedo novamente");
  while (p != FINGERPRINT_OK)
  {
    p = finger.getImage();
    switch (p)
    {
    case FINGERPRINT_OK:
      Serial.println("Imagem Tirada");
      break;
    case FINGERPRINT_NOFINGER:
      Serial.print(".");
      break;
    case FINGERPRINT_PACKETRECIEVEERR:
      Serial.println("Erro de Comunicacao");
      break;
    case FINGERPRINT_IMAGEFAIL:
      Serial.println("Erro de Imagem");
      break;
    default:
      Serial.println("Erro Desconhecido");
      break;
    }
  }

  // OK success!

  p = finger.image2Tz(2);
  switch (p)
  {
  case FINGERPRINT_OK:
    Serial.println("Imagem convertida");
    break;
  case FINGERPRINT_IMAGEMESS:
    Serial.println("Imagem baguncada");
    return p;
  case FINGERPRINT_PACKETRECIEVEERR:
    Serial.println("Erro de Comunicacao");
    return p;
  case FINGERPRINT_FEATUREFAIL:
    Serial.println("Caracteristicas Digitais nao encontradas");
    return p;
  case FINGERPRINT_INVALIDIMAGE:
    Serial.println("Caracteristicas Digitais nao encontradas");
    return p;
  default:
    Serial.println("Erro Desconhecido");
    return p;
  }

  // OK converted!
  Serial.print("Criando modelo para #");
  Serial.println(id);

  p = finger.createModel();
  if (p == FINGERPRINT_OK)
  {
    Serial.println("Impressoes batem!");
  }
  else if (p == FINGERPRINT_PACKETRECIEVEERR)
  {
    Serial.println("Erro de Comunicacao");
    return p;
  }
  else if (p == FINGERPRINT_ENROLLMISMATCH)
  {
    Serial.println("Digitais nao batem");
    return p;
  }
  else
  {
    Serial.println("Erro Desconhecido");
    return p;
  }

  Serial.print("ID ");
  Serial.println(id);
  p = finger.storeModel(id);
  if (p == FINGERPRINT_OK)
  {
    Serial.println("Armazenado!");
  }
  else if (p == FINGERPRINT_PACKETRECIEVEERR)
  {
    Serial.println("Erro de Comunicacao");
    return p;
  }
  else if (p == FINGERPRINT_BADLOCATION)
  {
    Serial.println("Não e possivel armazenar nesse local");
    return p;
  }
  else if (p == FINGERPRINT_FLASHERR)
  {
    Serial.println("Erro ao escrever na FLASH");
    return p;
  }
  else
  {
    Serial.println("Erro Desconhecido");
    return p;
  }
}

//Para testar se o sensor está sem modelo armazenado
/*
finger.emptyDatabase();

Serial.println("Now database is empty :)");

*/
