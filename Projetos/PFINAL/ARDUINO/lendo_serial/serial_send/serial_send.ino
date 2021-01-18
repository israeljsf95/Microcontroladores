void setup() {
  // put your setup code here, to run once:
  Serial.begin(19200);
}

void loop() {
  
  // put your main code here, to run repeatedly:
  Serial.write("AMEMi");
  delay(500);
}
