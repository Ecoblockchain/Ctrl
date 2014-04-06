import ddf.minim.*;

Minim minim;
float[] ys;
float maxY = 0;

void setup() {
  size(900, 600);
  smooth();
  fill(255);
  stroke(255);

  minim = new Minim(this);
  ys = new float[width];

  String[] files = (new File(dataPath(""))).list();
  for (int i=0; i<files.length; i++) {
    if (files[i].endsWith(".mp3")) {
      analyzeUsingAudioSample(files[i]);
      drawAudio(files[i]);
    }
  }
}

void analyzeUsingAudioSample(String fileName) {
  AudioSample jingle = minim.loadSample(dataPath(fileName), 2048);
  float[] leftChannel = jingle.getChannel(AudioSample.LEFT);
  jingle.close();

  int spp = (int)(leftChannel.length/width);
  for (int i=0; i<ys.length; i++) {
    float sum = leftChannel[i*spp];
    for (int j=1; j<spp; j++) {
      sum += leftChannel[i*spp+j];
    }
    ys[i] = (sum/spp);
    maxY = (abs(ys[i]) > maxY)?abs(ys[i]):maxY;
  }
}

void drawAudio(String fileName) {
  background(0);
  pushMatrix();
  translate(0, height/2);
  for (int i=1; i<ys.length; i++) {
    ellipse(i, 0, height/32, ys[i-1]/maxY*height);
  }
  popMatrix();

  saveFrame(dataPath(fileName+".png"));
}

void draw() {
}

