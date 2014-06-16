int pins[] = {
  3, 5, 6, 9, 10, 11};
int currPin[] = {
  0,1};
int currValue[] = {
  -255,-255};
int currDelay[] = {
  5,10};
long lastChangeMillis[] = {
  0,0};


void setup(){
  for(int i=0; i<6; i++){
    pinMode(pins[i], OUTPUT);
    analogWrite(pins[i], 0);
  }
  lastChangeMillis[0] = lastChangeMillis[1] = millis();
}

void loop(){
  analogWrite(pins[currPin[0]], 255-abs(currValue[0]));
  analogWrite(pins[currPin[1]], 255-abs(currValue[1]));

  for(int i=0; i<2; i++){
    if(millis()-lastChangeMillis[i] > currDelay[i]){
      currValue[i]+=random(1,3);
      if(currValue[i] > 255) {
        currValue[i] = -255;
        currPin[i] = random(0,6);
        if(currPin[i] == currPin[(i+1)%2]){
          currPin[i] = (currPin[i]+1)%6;
        }
        currDelay[i] = random(5,10);
      }
      lastChangeMillis[i] = millis();
    }
  }

}






