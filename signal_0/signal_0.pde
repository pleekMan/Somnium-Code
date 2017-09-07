
float[] signalLinesY;
float[] lineAttribute;
float signalLineLength;

float spikeAccel;
float spikeVel;
float spikePos;
float spikeDamp;

SignalScanner scanner;

void setup() {
  size(1000, 500);
  stroke(255);
  strokeWeight(2);

  signalLinesY = new float[50];
  lineAttribute = new float[50];

  signalLineLength = (float)width / signalLinesY.length;

  spikeAccel = 0;
  spikeVel = 0;
  spikePos = height * 0.5;
  spikeDamp = 0.95;
  
  scanner = new SignalScanner();
}

void draw() {
  background(0);

  spikeVel += spikeAccel;
  spikeVel *= spikeDamp; 
  spikePos += spikeVel;

  float spikeY = (height * 0.5) + (sin(spikePos) * (height * 0.5));
  signalLinesY[signalLinesY.length - 1] = spikeY;
  lineAttribute[signalLinesY.length - 1] = 50 * spikeVel;

  stroke(255);
  for (int i=0; i < signalLinesY.length - 1; i++) {

    signalLinesY[i] = signalLinesY[i+1];
    lineAttribute[i] = lineAttribute[i+1];
    
    //line(i * signalLineLength, signalLinesY[i], (i * signalLineLength) + (signalLineLength), signalLinesY[i]);
    line(i * signalLineLength, signalLinesY[i], i * signalLineLength, signalLinesY[i] + lineAttribute[i]);
  }
  
  scanner.render();
}

void keyPressed() {
}

void mousePressed() {
  spikeAccel = random(TWO_PI * 0.2);
  spikeVel = spikeAccel;
  spikeAccel = 0;
  
  scanner.trigger();
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
