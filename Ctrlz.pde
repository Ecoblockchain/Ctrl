import ddf.minim.*;

Minim minim;
float[] ys;
float minY;

void setup() {
  size(1280, 512);
  smooth();

  minim = new Minim(this);
  ys = new float[width];

  for (String fn: (new File(dataPath(""))).list()) {
    if (fn.endsWith(".mp3")) {
      analyzeUsingAudioSample(fn);
      drawAudio(fn);
    }
  }
}

void analyzeUsingAudioSample(String fileName) {
  AudioSample audio = minim.loadSample(dataPath(fileName), 2048);
  float[] leftChannel = audio.getChannel(AudioSample.LEFT);
  audio.close();

  minY = 0;
  int spp = (int)(leftChannel.length/width);
  for (int i=0; i<ys.length; i++) {
    float sum = leftChannel[i*spp];
    for (int j=1; j<spp; j++) {
      sum += leftChannel[i*spp+j];
    }
    ys[i] = (sum/spp);
    minY = (ys[i] < minY)?ys[i]:minY;
  }
}

void drawAudio(String fileName) {
  pushMatrix();
  translate(0,-100);

  background(0);
  fill(255);
  stroke(255);
  strokeWeight(10);

  for (int i=1; i<ys.length; i++) {
    ellipse(i, 0, height/8, ys[i]/minY*2*height);
  }

  fill(0);
  stroke(0);
  strokeWeight(0);

  for (int i=1; i<ys.length; i++) {
    ellipse(i, 0, height/8, ys[i]/minY*2*height);
  }

  saveFrame(dataPath(fileName+".png"));
  popMatrix();
}

void draw() {
}

