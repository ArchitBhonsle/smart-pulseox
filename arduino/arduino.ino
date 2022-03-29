#include <SoftwareSerial.h>

#define TXD_PIN 11
#define RXD_PIN 10

SoftwareSerial bt(10, 11);

void setup() {
  bt.begin(9600);
  Serial.begin(9600);
}

void loop() {
  bt.write((int) 97);
  bt.write((int) 72);
  
  delay(1000);
}
