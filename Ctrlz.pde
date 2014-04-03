import ddf.minim.*;
import java.util.Arrays;
import java.io.FileOutputStream;
import java.awt.Color;

String fileName = "jingle.mp3";
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

  analyzeUsingAudioSample();
}

void analyzeUsingAudioSample() {
  AudioSample jingle = minim.loadSample(fileName, 2048);
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

void draw() {
  background(0);

  if (!(new File(dataPath(fileName+".eps")).isFile())) {
    // for eps file
    FileOutputStream finalImage;
    EpsGraphics2D g;

    try {
      finalImage = new FileOutputStream(dataPath(fileName+".eps"));
      g = new EpsGraphics2D(fileName, finalImage, 0, 0, width, height);

      g.setBackground(Color.BLACK);
      g.clearRect(0, 0, width, height);
      g.setColor(Color.WHITE);

      for (int i=1; i<ys.length; i++) {
        PVector ovalDimensions = new PVector(height/8, ys[i-1]/maxY*height); 
        g.fillOval((int)(i-ovalDimensions.x/2), (int)(height/2-ovalDimensions.y/2), (int)ovalDimensions.x, (int)ovalDimensions.y);
      }

      g.flush();
      g.close();
      finalImage.close();
    }
    catch (Exception e) {
      println("Exception: "+e);
      exit();
    }
  }

  pushMatrix();
  translate(0, height/2);
  for (int i=1; i<ys.length; i++) {
    ellipse(i, 0, height/8, ys[i-1]/maxY*height);
  }
  popMatrix();
}

