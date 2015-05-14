float y[] = {0, 0, 0};
float TWO_PI_F = TWO_PI / 2609.0f;
float PI_3 = PI / 3.0f;
void setup() {}

void loop() {
  for (short i = 0; i < 3; i++) {
    y[i] = 127.0f * sin(TWO_PI_F * millis() + i * PI_3) + 128.0f;
  }

  analogWrite(3, int(y[0]));
  analogWrite(5, int(y[1]));
  analogWrite(6, int(y[2]));
}

